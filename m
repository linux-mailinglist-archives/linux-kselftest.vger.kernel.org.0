Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E065D6CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2019 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGBTW2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 15:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfGBTW2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 15:22:28 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 345E72184B;
        Tue,  2 Jul 2019 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562095347;
        bh=YJz7WwyCnzloTJVnD/NVya/TgR10dnxO8ZXDvH/R6Y8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f1gefd1UgVcy+vh9SxYcNPe75rrWu8sZbPSTEIPVgVB39uW7xgm3kAEj67lOxlycL
         AVxn1uLQPlhdt8IFzBzcEpUE5nfWIFBDTPsybjtqOchR+aRelliThVcTIev1+Sdd1W
         JAhyX6fjcCS9wHzuLHo/H99YM59XzzslwS+dqPek=
Subject: Re: [PATCH] selftests/ftrace: skip ftrace test if FTRACE was not
 enabled
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190702062358.7330-1-po-hsu.lin@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <4a44dd22-be88-ce5b-5c9b-6a3759b6c2eb@kernel.org>
Date:   Tue, 2 Jul 2019 13:22:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702062358.7330-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Po-Hsu Lin,

On 7/2/19 12:23 AM, Po-Hsu Lin wrote:
> The ftrace test will need to have CONFIG_FTRACE enabled to make the
> ftrace directory available.
> 
> Add an additional check to skip this test if the CONFIG_FTRACE was not
> enabled.
> 
> This will be helpful to avoid a false-positive test result when testing
> it directly with the following commad against a kernel that does not
> have CONFIG_FTRACE enabled:
>      make -C tools/testing/selftests TARGETS=ftrace run_tests
> 
> The test result on an Ubuntu KVM kernel will be changed from:
>      selftests: ftrace: ftracetest
>      ========================================
>      Error: No ftrace directory found
>      not ok 1..1 selftests: ftrace: ftracetest [FAIL]
> To:

Thanks for the patch.

Check patch fails with the above To:

WARNING: Use a single space after To:
#107:
To:

ERROR: Unrecognized email address: ''
#107:
To:

total: 1 errors, 1 warnings, 23 lines checked


Please fix and send v2.

>      selftests: ftrace: ftracetest
>      ========================================
>      CONFIG_FTRACE was not enabled, test skipped.
>      not ok 1..1 selftests: ftrace: ftracetest [SKIP]
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>   tools/testing/selftests/ftrace/ftracetest | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 6d5e9e8..6c8322e 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -7,6 +7,9 @@
>   #  Written by Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>   #

Hmm. You havem't cc'ed Masami on this. Adding Masami.

I would think Masami should be on the Signed-off-by as well,
since he is the author.

>   
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>   usage() { # errno [message]
>   [ ! -z "$2" ] && echo $2
>   echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
> @@ -139,7 +142,13 @@ parse_opts $*
>   
>   # Verify parameters
>   if [ -z "$TRACING_DIR" -o ! -d "$TRACING_DIR" ]; then
> -  errexit "No ftrace directory found"
> +  ftrace_enabled=`grep "^CONFIG_FTRACE=y" /lib/modules/$(uname -r)/build/.config`
> +  if [ -z "$ftrace_enabled" ]; then
> +    echo "CONFIG_FTRACE was not enabled, test skipped."
> +    exit $ksft_skip
> +  else
> +    errexit "No ftrace directory found"
> +  fi
>   fi
>   
>   # Preparing logs
> 

thanks,
-- Shuah
