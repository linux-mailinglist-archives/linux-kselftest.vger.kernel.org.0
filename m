Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD549E9D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 19:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbiA0SKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 13:10:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56052 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245044AbiA0SKA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 13:10:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 828411F45959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643306993;
        bh=YVoSqeGpj1x8qNffk1ngm8QY3CihsqcwqVnxalY6JQA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D4BRmTKTR2LGJULzoGImx9UM8MAmQAIFxdKqz6IlmxXBouQq2exhNsZxnCO/goIEY
         VI//0QQps3np+GTOpmDfw3Db0pkiCvfi3vejGyDthT5kbCQIF7KjTgl6PJg5cZXIfg
         YQeo9LHstGvJ5+q9xL+Ke/tg+IREToOVT7CZgZcZs5FPz735EyBa7FzOvB2IYWnfqR
         b56ZmAfMEDJAklWtBjU5peZYwlhZXmS6vGKWmsmtNQ9cH2mz5mZT602qcCV59VsEcJ
         42lS4d7f6gylLPTiOA3kSPIiJh4HixJoFlqzcMWEjDiVDLXwPLEPFozl4XWMgAK9UD
         97sUShmLVHRgQ==
Message-ID: <65054310-e925-4072-7df2-e1550d8a9a4f@collabora.com>
Date:   Thu, 27 Jan 2022 15:09:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] selftests: futex: Use variable MAKE instead of make
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
References: <20220127174447.754605-1-usama.anjum@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20220127174447.754605-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Usama,

Às 14:44 de 27/01/22, Muhammad Usama Anjum escreveu:
> Recursive make commands should always use the variable MAKE, not the
> explicit command name ‘make’. This has benefits and removes the
> following warning when multiple jobs are used for the build:
> 
> make[2]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
> 
> Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks for the patch!

Reviewed-by: André Almeida <andrealmeid@collabora.com>

> ---
>  tools/testing/selftests/futex/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> index 12631f0076a10..11e157d7533b8 100644
> --- a/tools/testing/selftests/futex/Makefile
> +++ b/tools/testing/selftests/futex/Makefile
> @@ -11,7 +11,7 @@ all:
>  	@for DIR in $(SUBDIRS); do		\
>  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
>  		mkdir $$BUILD_TARGET  -p;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
>  		if [ -e $$DIR/$(TEST_PROGS) ]; then \
>  			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
>  		fi \
> @@ -32,6 +32,6 @@ override define CLEAN
>  	@for DIR in $(SUBDIRS); do		\
>  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
>  		mkdir $$BUILD_TARGET  -p;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
>  	done
>  endef
