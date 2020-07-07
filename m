Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCC2171B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGPYZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 11:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbgGGPYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 11:24:16 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CBC061755
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jul 2020 08:24:16 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l63so33742976oih.13
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQlH+5Rxv1TZTmNUKokYf1gRnidmklj65FW3ajui8n8=;
        b=gtkvz8FGNaNJgUQOYZxrh8RQ//6B5EnuDkuA0CI343tqSUwxmVFPrUj22a9A5eJ0d8
         PeRYJ7/r2g4Kb8/uLNJPEoQbqvXD4iPm2Z9HvDz4VKCy0kRM+h+dhgWKuhgTucsBKEob
         mQC+mhd+P5O+UaZRgc8Myl3wXAx5Vygcp/Uq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQlH+5Rxv1TZTmNUKokYf1gRnidmklj65FW3ajui8n8=;
        b=Tj+yjqIvhN0oUQ7rLhn4hhBfiFxmIsXA3pWVAP4yVM2z6LDzpXHSKYX/bMeIchygMa
         XQQCZZ+BEt6nQRdlhqW41lY4i/ZoAuzSzpR4njO7Ndvm+WhnOYCW/iHinXIqIL6uTM/G
         op1LCcRrMUVi9LYth+yvLnP7zYCRmPwtPbXlQwlhXACY3oRs4FRbaFfj6+UVMllHPXGk
         XuXl46guFA0OSyyqlMWi1kpA87DuCYHP/8Z3UBY1ut5bdHq/XFLurexCGPJvn8OYng6t
         RVGZXv9qzfbF2WFBtLUhGXOF5X0Ef0KidNDR/9kLsPZk7ygVNBpTvMIE2vOigmnzyrZh
         VVmw==
X-Gm-Message-State: AOAM532EaBX8gBT510a11uZEg6T1CmMPfsnBjZ1Ve++h9ab54dObOnbi
        3Avlp4FsX9BmRXo7f9dd4Ji1tA==
X-Google-Smtp-Source: ABdhPJwTBVZClUaOBGBLJNT1lD+iIbNdX7fMrPQfh1eSqtSETAt6r/3QI8NT+64KTOzF8Wxb/CGV8w==
X-Received: by 2002:aca:5158:: with SMTP id f85mr3774047oib.6.1594135455807;
        Tue, 07 Jul 2020 08:24:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t16sm188781oou.28.2020.07.07.08.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:24:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200707101936.12052-1-pbonzini@redhat.com>
 <20200707101936.12052-2-pbonzini@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f10aaf26-39f6-79ae-c3cc-56c31835f57e@linuxfoundation.org>
Date:   Tue, 7 Jul 2020 09:24:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707101936.12052-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/7/20 4:19 AM, Paolo Bonzini wrote:
> Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
> than planned.  Use ksft_test_result_skip instead.
> 
> The plan passed to ksft_set_plan was wrong, too, so fix it while at it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20200623001547.22255-5-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tools/testing/selftests/pidfd/pidfd_test.c | 34 +++++++++++++++++++---
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 7aff2d3b42c0..f65ad4e32353 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -8,6 +8,7 @@
>   #include <sched.h>
>   #include <signal.h>
>   #include <stdio.h>
> +#include <stdbool.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <syscall.h>
> @@ -27,6 +28,8 @@
>   
>   #define MAX_EVENTS 5
>   
> +static bool have_pidfd_send_signal = false;

You don't need to initialize this to false. Rest looks good.

> +
>   static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
>   {
>   	size_t stack_size = 1024;
> @@ -56,6 +59,13 @@ static int test_pidfd_send_signal_simple_success(void)
>   	int pidfd, ret;
>   	const char *test_name = "pidfd_send_signal send SIGUSR1";
>   
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>   	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
>   	if (pidfd < 0)
>   		ksft_exit_fail_msg(
> @@ -86,6 +96,13 @@ static int test_pidfd_send_signal_exited_fail(void)
>   	pid_t pid;
>   	const char *test_name = "pidfd_send_signal signal exited process";
>   
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>   	pid = fork();
>   	if (pid < 0)
>   		ksft_exit_fail_msg("%s test: Failed to create new process\n",
> @@ -137,6 +154,13 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
>   	pid_t pid1;
>   	const char *test_name = "pidfd_send_signal signal recycled pid";
>   
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>   	ret = unshare(CLONE_NEWPID);
>   	if (ret < 0)
>   		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
> @@ -325,15 +349,17 @@ static int test_pidfd_send_signal_syscall_support(void)
>   
>   	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>   	if (ret < 0) {
> -		if (errno == ENOSYS)
> -			ksft_exit_skip(
> +		if (errno == ENOSYS) {
> +			ksft_test_result_skip(
>   				"%s test: pidfd_send_signal() syscall not supported\n",
>   				test_name);
> -
> +			return 0;
> +		}
>   		ksft_exit_fail_msg("%s test: Failed to send signal\n",
>   				   test_name);
>   	}
>   
> +	have_pidfd_send_signal = true;
>   	close(pidfd);
>   	ksft_test_result_pass(
>   		"%s test: pidfd_send_signal() syscall is supported. Tests can be executed\n",
> @@ -521,7 +547,7 @@ static void test_pidfd_poll_leader_exit(int use_waitpid)
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> -	ksft_set_plan(4);
> +	ksft_set_plan(8);
>   
>   	test_pidfd_poll_exec(0);
>   	test_pidfd_poll_exec(1);
> 

thanks,
-- Shuah
