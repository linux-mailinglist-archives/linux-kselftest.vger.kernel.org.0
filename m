Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8361F7CC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFLSTp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 14:19:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45338 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSTp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 14:19:45 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jjoHF-0005Z9-OE; Fri, 12 Jun 2020 18:19:41 +0000
Date:   Fri, 12 Jun 2020 20:19:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] selftests/clone3: Reorder reporting output
Message-ID: <20200612181940.njkyjixo55vawf2i@wittgenstein>
References: <20200611224028.3275174-1-keescook@chromium.org>
 <20200611224028.3275174-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200611224028.3275174-2-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 11, 2020 at 03:40:22PM -0700, Kees Cook wrote:
> Selftest output reporting was happening before the TAP headers and plan
> had been emitted. Move the first test reports later.
> 
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Again, much appreciated:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  tools/testing/selftests/clone3/clone3.c               | 2 +-
>  tools/testing/selftests/clone3/clone3_clear_sighand.c | 3 +--
>  tools/testing/selftests/clone3/clone3_set_tid.c       | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index f14c269a5a18..b7e6dec36173 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -131,9 +131,9 @@ int main(int argc, char *argv[])
>  
>  	uid_t uid = getuid();
>  
> -	test_clone3_supported();
>  	ksft_print_header();
>  	ksft_set_plan(17);
> +	test_clone3_supported();
>  
>  	/* Just a simple clone3() should return 0.*/
>  	test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);
> diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> index 9e1af8aa7698..db5fc9c5edcf 100644
> --- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
> +++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> @@ -119,9 +119,8 @@ static void test_clone3_clear_sighand(void)
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
> -	test_clone3_supported();
> -
>  	ksft_set_plan(1);
> +	test_clone3_supported();
>  
>  	test_clone3_clear_sighand();
>  
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> index 25beb22f35b5..5831c1082d6d 100644
> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -157,8 +157,8 @@ int main(int argc, char *argv[])
>  	pid_t set_tid[MAX_PID_NS_LEVEL * 2];
>  
>  	ksft_print_header();
> -	test_clone3_supported();
>  	ksft_set_plan(29);
> +	test_clone3_supported();
>  
>  	if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
>  		ksft_exit_fail_msg("pipe() failed\n");
> -- 
> 2.25.1
> 
