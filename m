Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B511DF83
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2019 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMIeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Dec 2019 03:34:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:35322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfLMIeP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Dec 2019 03:34:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DE0DAB9B;
        Fri, 13 Dec 2019 08:34:12 +0000 (UTC)
Date:   Fri, 13 Dec 2019 09:34:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, shuah@kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: Fix it to do root uid check and
 skip
Message-ID: <20191213083411.delrxditrpcdm7az@pathway.suse.cz>
References: <20191213015617.23110-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213015617.23110-1-skhan@linuxfoundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2019-12-12 18:56:17, Shuah Khan wrote:
> livepatch test configures the system and debug environment to run
> tests. Some of these actions fail without root access and test
> dumps several permission denied messages before it exits.
> 
> Fix it to check root uid and exit with skip code instead.

It works when I run the tests directly, e.g.

$> cd tools/testing/selftests/livepatch
$> ./test-livepatch.sh

But I still get an error from the selftest framework when running
make run_tests:

$> make run_tests
TAP version 13
1..5
# selftests: livepatch: test-livepatch.sh
/mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
# selftests: livepatch: test-callbacks.sh
/mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
not ok 2 selftests: livepatch: test-callbacks.sh # exit=1
# selftests: livepatch: test-shadow-vars.sh
/mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
not ok 3 selftests: livepatch: test-shadow-vars.sh # exit=1
# selftests: livepatch: test-state.sh
/mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
not ok 4 selftests: livepatch: test-state.sh # exit=1
# selftests: livepatch: test-ftrace.sh
/mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
not ok 5 selftests: livepatch: test-ftrace.sh # exit=1

The same problem is also in linux-next. Is this a know problem, please?


> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 31eb09e38729..014b587692f0 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -45,6 +57,7 @@ function pop_config() {
>  }
>  
>  function set_dynamic_debug() {
> +	is_root
>          cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
>  		file kernel/livepatch/* +p
>  		func klp_try_switch_task -p

This test is superfluous.

I guess that it was added because of test-state.sh. But it calls
set_dynamic_debug() instead of config_setup() by mistake.
Please, use the patch below instead of the above hunk.

Otherwise, this patch looks good. Thanks for fixing this.
Without the hunk above, and with the patch below, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>


Here is the fix of test-state.sh:

From 01ca8fd71fc964b892e54aea198537d007d33b4f Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 13 Dec 2019 09:26:45 +0100
Subject: [PATCH] selftests/livepatch: Use setup_config() also in test-state.sh

The commit 35c9e74cff4c798d0 ("selftests/livepatch: Make dynamic debug
setup and restore generic") introduced setup_config() to prepare
the testing environment. All selftests should call it instead
of set_dynamic_debug().

test-state.sh has been developed in parallel and was not converted
by mistake.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 tools/testing/selftests/livepatch/test-state.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index dc2908c22c26..5c80e51fca55 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -8,7 +8,7 @@ MOD_LIVEPATCH=test_klp_state
 MOD_LIVEPATCH2=test_klp_state2
 MOD_LIVEPATCH3=test_klp_state3
 
-set_dynamic_debug
+setup_config
 
 
 # TEST: Loading and removing a module that modifies the system state
-- 
2.16.4

