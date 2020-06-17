Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC31FC9C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 11:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgFQJXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 05:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:53942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQJXz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 05:23:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1FCD0AB76;
        Wed, 17 Jun 2020 09:23:57 +0000 (UTC)
Date:   Wed, 17 Jun 2020 11:23:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 2/4] selftests/livepatch: use $(dmesg --notime)
 instead of manually filtering
Message-ID: <20200617092352.GT31238@alley>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
 <20200615172756.12912-3-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615172756.12912-3-joe.lawrence@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2020-06-15 13:27:54, Joe Lawrence wrote:
> The dmesg utility already comes with a command line switch to omit
> kernel timestamps, let's use it instead of applying an extra regex to
> filter them out.
> 
> Now without the '[timestamp]: ' prefix at the beginning of the log
> entry, revise the filtering regex to search for the 'livepatch:'
> subsystem prefix at the beginning of the line.

I wanted to push this patchset and run full test after each patch.
Suddenly the tests started to fail, for example:

$/tools/testing/selftests/livepatch> ./test-livepatch.sh
TEST: basic function patching ... ok
TEST: multiple livepatches ... not ok

--- expected
+++ result
@@ -1,3 +1,9 @@
+% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
+livepatch: 'test_klp_livepatch': initializing unpatching transition
+livepatch: 'test_klp_livepatch': starting unpatching transition
+livepatch: 'test_klp_livepatch': completing unpatching transition
+livepatch: 'test_klp_livepatch': unpatching complete
+% rmmod test_klp_livepatch
 % modprobe test_klp_livepatch
 livepatch: enabling patch 'test_klp_livepatch'
 livepatch: 'test_klp_livepatch': initializing patching transition
@@ -20,9 +26,3 @@ livepatch: 'test_klp_atomic_replace': co
 livepatch: 'test_klp_atomic_replace': unpatching complete
 % rmmod test_klp_atomic_replace
 test_klp_livepatch: this has been live patched
-% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
-livepatch: 'test_klp_livepatch': initializing unpatching transition
-livepatch: 'test_klp_livepatch': starting unpatching transition
-livepatch: 'test_klp_livepatch': completing unpatching transition
-livepatch: 'test_klp_livepatch': unpatching complete
-% rmmod test_klp_livepatch

ERROR: livepatch kselftest(s) failed


The problem is a combination of:

  + 1st patch that causes that old kernel messages are not cleared
  + 2nd patch that removes time stamps from the diff
  + lost the oldest messages because internal kernel log buffer overflow
  + run the same tests more times

As a result, the diff might match with an incomplete log from
the previous run.

Everything works when this 2nd patch is not commited. The timestamp
helps to distinguish old and new messages. The lost messages
are ignored thanks to the diff parameters:

       --changed-group-format='%>' --unchanged-group-format=''

If you agree, I'll solve this problem by not committing this patch
into livepatch.git repo.

It would be great to add a comment that the timestamp is actually
important. But it might be done in a followup patch.

Best Regards,
Petr


> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -272,9 +272,8 @@ function check_result {
>  	local expect="$*"
>  	local result
>  
> -	result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
> -		 grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | \
> -		 sed 's/^\[[ 0-9.]*\] //')
> +	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
> +		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
>  
>  	if [[ "$expect" == "$result" ]] ; then
>  		echo "ok"
> -- 
> 2.21.3

