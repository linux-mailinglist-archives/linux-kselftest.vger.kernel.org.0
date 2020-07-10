Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE321B971
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 17:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGJP1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 11:27:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbgGJP1h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 11:27:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 502F9AC24;
        Fri, 10 Jul 2020 15:27:36 +0000 (UTC)
Date:   Fri, 10 Jul 2020 17:27:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: adopt to newer sysctl error format
Message-ID: <20200710152735.GA20226@alley>
References: <20200710051043.899291-1-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710051043.899291-1-kamalesh@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2020-07-10 10:40:43, Kamalesh Babulal wrote:
> With procfs v3.3.16, the sysctl command doesn't prints the set key and
> value on error.  This change breaks livepatch selftest test-ftrace.sh,
> that tests the interaction of sysctl ftrace_enabled:
> 
>  # selftests: livepatch: test-ftrace.sh
>  # TEST: livepatch interaction with ftrace_enabled sysctl ... not ok
>  #
>  # --- expected
>  # +++ result
>  # @@ -16,7 +16,7 @@ livepatch: 'test_klp_livepatch': initial
>  #  livepatch: 'test_klp_livepatch': starting patching transition
>  #  livepatch: 'test_klp_livepatch': completing patching transition
>  #  livepatch: 'test_klp_livepatch': patching complete
>  # -livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
>     resource busy kernel.ftrace_enabled = 0
>  # +livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
>     resource busy
>  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  #  livepatch: 'test_klp_livepatch': initializing unpatching transition
>  #  livepatch: 'test_klp_livepatch': starting unpatching transition
>  #
>  # ERROR: livepatch kselftest(s) failed
> 
> on setting sysctl kernel.ftrace_enabled={0,1} value successfully, the
> set key and value is displayed.
> 
> This patch fixes it by limiting the output from both the cases to eight
> words, that includes the error message or set key and value on failure
> and success. The upper bound of eight words is enough to display the
> only tracked error message. Also, adjust the check_result string in
> test-ftrace.sh to match the expected output.

This looks really tricky.

I wonder if we could use "sysctl -q" to refuse printing the value
even with older versions. The following patch works here with
sysctl 3.3.15:

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 2aab9791791d..47aa4c762bb4 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -64,7 +64,8 @@ function set_dynamic_debug() {
 }
 
 function set_ftrace_enabled() {
-	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
+	result=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1 && \
+		 sysctl kernel.ftrace_enabled 2>&1)
 	echo "livepatch: $result" > /dev/kmsg
 }
 
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index e2a76887f40a..aa967c5d0558 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -53,7 +53,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
-livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
+livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition


Best Regards,
Petr
