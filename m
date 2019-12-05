Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94182113D05
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 09:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfLEI2d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 03:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEI2d (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 03:28:33 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8D220707;
        Thu,  5 Dec 2019 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575534513;
        bh=/l81rifg3rXzLUo11Q36GAttbB8DKI+R9E4DG7pEnKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=chCMKjcpCxO62O5MnivFHjPUdtxg6+WgtEauVsar/Y9E+qBshhHXHHYEm3xzSYQtp
         j9qCk2vZsSvQl57fNz6goAF5IZ8wLM65QreL0gu5o/TRVZicDsdEnAmAF3lJnUQ5bR
         I9Vp2X0muh1wOLdYMKXQmpjMSIQ8QfVinlMh1ZWI=
Date:   Thu, 5 Dec 2019 17:28:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH] selftests/x86: Check the availablity of
 sys/syscall.h
Message-Id: <20191205172829.66ec55907ac31303bbede593@kernel.org>
In-Reply-To: <157467982420.24866.4375165389279465782.stgit@devnote2>
References: <157467982420.24866.4375165389279465782.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Could you pick this if there si no issue?

Thank you,

On Mon, 25 Nov 2019 20:03:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since single_step_syscall.c depends on sys/syscall.h and
> its include, asm/unistd.h, we should check the availability
> of those headers.
> Without this fix, if gcc-multilib is not installed but
> libc6-dev-i386 is installed, kselftest tries to build 32bit
> binary and failed with following error message.
> 
> In file included from single_step_syscall.c:18:
> /usr/include/sys/syscall.h:24:10: fatal error: asm/unistd.h: No such file or directory
>  #include <asm/unistd.h>
>           ^~~~~~~~~~~~~~
> compilation terminated.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../testing/selftests/x86/trivial_32bit_program.c  |    1 +
>  .../testing/selftests/x86/trivial_64bit_program.c  |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/trivial_32bit_program.c b/tools/testing/selftests/x86/trivial_32bit_program.c
> index aa1f58c2f71c..6b455eda24f7 100644
> --- a/tools/testing/selftests/x86/trivial_32bit_program.c
> +++ b/tools/testing/selftests/x86/trivial_32bit_program.c
> @@ -8,6 +8,7 @@
>  # error wrong architecture
>  #endif
>  
> +#include <sys/syscall.h>
>  #include <stdio.h>
>  
>  int main()
> diff --git a/tools/testing/selftests/x86/trivial_64bit_program.c b/tools/testing/selftests/x86/trivial_64bit_program.c
> index 39f4b84fbf15..07ae86df18ff 100644
> --- a/tools/testing/selftests/x86/trivial_64bit_program.c
> +++ b/tools/testing/selftests/x86/trivial_64bit_program.c
> @@ -8,6 +8,7 @@
>  # error wrong architecture
>  #endif
>  
> +#include <sys/syscall.h>
>  #include <stdio.h>
>  
>  int main()
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
