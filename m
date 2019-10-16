Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB0D9501
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393978AbfJPPHo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 11:07:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391793AbfJPPHn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 11:07:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E93B1B41A;
        Wed, 16 Oct 2019 15:07:41 +0000 (UTC)
Date:   Wed, 16 Oct 2019 17:07:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     rostedt@goodmis.org, jikos@kernel.org, joe.lawrence@redhat.com,
        jpoimboe@redhat.com, mingo@redhat.com, shuah@kernel.org,
        kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests/livepatch: Test interaction with
 ftrace_enabled
Message-ID: <20191016150741.vrnwik5kkzcxubr2@pathway.suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz>
 <20191016113316.13415-4-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016113316.13415-4-mbenes@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2019-10-16 13:33:15, Miroslav Benes wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Since livepatching depends upon ftrace handlers to implement "patched"
> code functionality, verify that the ftrace_enabled sysctl value
> interacts with livepatch registration as expected.  At the same time,
> ensure that ftrace_enabled is set and part of the test environment
> configuration that is saved and restored when running the selftests.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  tools/testing/selftests/livepatch/Makefile    |  3 +-
>  .../testing/selftests/livepatch/functions.sh  | 14 +++-
>  .../selftests/livepatch/test-ftrace.sh        | 65 +++++++++++++++++++
>  3 files changed, 80 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/livepatch/test-ftrace.sh
> 
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index fd405402c3ff..1886d9d94b88 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -4,6 +4,7 @@ TEST_PROGS_EXTENDED := functions.sh
>  TEST_PROGS := \
>  	test-livepatch.sh \
>  	test-callbacks.sh \
> -	test-shadow-vars.sh
> +	test-shadow-vars.sh \
> +	test-ftrace.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index b7e5a67ae434..31eb09e38729 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -32,12 +32,16 @@ function die() {
>  function push_config() {
>  	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
>  			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
> +	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
>  }
>  
>  function pop_config() {
>  	if [[ -n "$DYNAMIC_DEBUG" ]]; then
>  		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
>  	fi
> +	if [[ -n "$FTRACE_ENABLED" ]]; then
> +		sysctl kernel.ftrace_enabled="$FTRACE_ENABLED" &> /dev/null
> +	fi
>  }
>  
>  function set_dynamic_debug() {
> @@ -47,12 +51,20 @@ function set_dynamic_debug() {
>  		EOF
>  }
>  
> +function set_ftrace_enabled() {
> +	local sysctl="$1"

The variable is not later used.

> +	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
> +	echo "livepatch: $result" > /dev/kmsg
> +}

Otherwise, the patch looks good to me. After removing or using the
variable:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
