Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD14E1F7682
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFLKL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 06:11:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFLKL0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 06:11:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91EF9AAC7;
        Fri, 12 Jun 2020 10:11:27 +0000 (UTC)
Date:   Fri, 12 Jun 2020 12:11:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/livepatch: Don't clear dmesg when running
 tests
Message-ID: <20200612101122.GF4311@linux-b0ei>
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-2-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610172101.21910-2-joe.lawrence@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2020-06-10 13:20:59, Joe Lawrence wrote:
> Inspired by commit f131d9edc29d ("selftests/lkdtm: Don't clear dmesg
> when running tests"), keep a reference dmesg copy when beginning each
> test.  This way check_result() can compare against the initial copy
> rather than relying upon an empty log.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  tools/testing/selftests/livepatch/README      | 16 +++---
>  .../testing/selftests/livepatch/functions.sh  | 16 +++++-
>  .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
>  .../selftests/livepatch/test-ftrace.sh        |  5 +-
>  .../selftests/livepatch/test-livepatch.sh     | 15 +----
>  .../selftests/livepatch/test-shadow-vars.sh   |  5 +-
>  .../testing/selftests/livepatch/test-state.sh | 20 ++-----
>  7 files changed, 43 insertions(+), 89 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
> index 621d325425c2..0942dd5826f8 100644
> --- a/tools/testing/selftests/livepatch/README
> +++ b/tools/testing/selftests/livepatch/README
> @@ -6,8 +6,8 @@ This is a small set of sanity tests for the kernel livepatching.
>  
>  The test suite loads and unloads several test kernel modules to verify
>  livepatch behavior.  Debug information is logged to the kernel's message
> -buffer and parsed for expected messages.  (Note: the tests will clear
> -the message buffer between individual tests.)
> +buffer and parsed for expected messages.  (Note: the tests will compare
> +the message buffer for only the duration of each individual test.)
>  
>  
>  Config
> @@ -35,9 +35,9 @@ Adding tests
>  ------------
>  
>  See the common functions.sh file for the existing collection of utility
> -functions, most importantly setup_config() and check_result().  The
> -latter function greps the kernel's ring buffer for "livepatch:" and
> -"test_klp" strings, so tests be sure to include one of those strings for
> -result comparison.  Other utility functions include general module
> -loading and livepatch loading helpers (waiting for patch transitions,
> -sysfs entries, etc.)
> +functions, most importantly setup_config(), start_test() and
> +check_result().  The latter function greps the kernel's ring buffer for
> +"livepatch:" and "test_klp" strings, so tests be sure to include one of
> +those strings for result comparison.  Other utility functions include
> +general module loading and livepatch loading helpers (waiting for patch
> +transitions, sysfs entries, etc.)
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 2aab9791791d..e84375a33852 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -243,13 +243,25 @@ function set_pre_patch_ret {
>  		die "failed to set pre_patch_ret parameter for $mod module"
>  }
>  
> +function start_test {
> +	local test="$1"
> +
> +	# Save existing dmesg so we can detect new content below
> +	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
> +	dmesg > "$SAVED_DMESG"
> +

One more thing. Could we print a delimiter into dmesg log so that it
is easier to distinguish different tests.

The following looks fine to me but I do not resist on exactly
this format:

	log "===== TEST: $test ====="

> +	echo -n "TEST: $test ... "
> +}
> +

Best Regards,
Petr
