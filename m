Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553567D956A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 12:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJ0Klw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0Klv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 06:41:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B818A;
        Fri, 27 Oct 2023 03:41:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso295393866b.2;
        Fri, 27 Oct 2023 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698403308; x=1699008108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJlIxAlI3qqoojs2SPzt67107Ewh+X9coDI5REUO6oE=;
        b=iMJLW6URSfB6bplkpHZiWbI76+UnB/HuwbwnVSbmtI6I77EZB9J6aPBcMG2v/Hi2g/
         mU6A1exU8YJ5bK7hWoCpT1mKHmyRZM9fbXKrQ+EPHw3iwIJYfFt4fvnM6qTKSAfIA/2V
         exjpXa9Z57nPLCZdmsQFXQjrLgYsTRcq5uGwSfc64+6RvQ2DResGo1AxitFNNZiGbQgT
         mRoFJV0m90QDdS0i0hm67XA+pLxTG3ToD1XfXf7OsW3Hip6NUDe8YmWZ1YxpIFQLOhr1
         h3tCpUhUAOCxkKvN7sZNC/J/INWPuhnewRm3JAFpDN66o6Jl7qqhfr9RqJzjWx/umLik
         P/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698403308; x=1699008108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJlIxAlI3qqoojs2SPzt67107Ewh+X9coDI5REUO6oE=;
        b=jlht486TqDnMWAJe4OU3RjVnsN2ka3GyP5oo1gke+hoRl+eV8uGACEyzWycafp58DY
         GYq4Ctfmn8kKyJ8vqRWPShI41+mcmXUynq63hwkGXTyJRe0a5RjvCvbqleOA93vs7FzU
         1fyHq+VS6Ph6eoBU9wqhnjyQxwaXgmKrE1AGDOeRjy66Oz4dsLtdfpTXrIicKhfljXFt
         e+f3TjoEL2uUzVUMYgnSubjugX3hyrpt7PHN7iguhTFfEQYtt3bxRhZhsrOj/JHK6ygO
         Si4UhMAGgPsUHXAjLFyHLco0RQKWnpHu8Bwy8yyLfoeN6o+LHR7MEmu6fVn/g/UkRH/B
         CPuQ==
X-Gm-Message-State: AOJu0YwRbv8ABIz9Gud3/jzkmyzWDgogduVR0pEK1GABNRSHhRxdjAxY
        GU2bgY/9a4E/6MamGIGyKlWAI4DB+A==
X-Google-Smtp-Source: AGHT+IGG0dNg9Z43zdOJ+I4D2u9uJ72OdmCpwTt73ucvr6QlsbPcc81T7NTMWkn2PS2Ln1LhaE5qFw==
X-Received: by 2002:a17:907:1ca3:b0:9bf:39f3:f11d with SMTP id nb35-20020a1709071ca300b009bf39f3f11dmr1986424ejc.30.1698403307469;
        Fri, 27 Oct 2023 03:41:47 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id qt7-20020a170906ece700b00988f168811bsm990259ejb.135.2023.10.27.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:41:46 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:41:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests:proc ProtectionKey check in smpas test
Message-ID: <397bbed6-9e9d-4aca-8b14-8b0f2d69d845@p183>
References: <20231025193627.316508-1-swarupkotikalapudi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025193627.316508-1-swarupkotikalapudi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 26, 2023 at 01:06:27AM +0530, Swarup Laxman Kotiaklapudi wrote:
> Check ProtectionKey field in /proc/*/smaps output,
> if system supports page-based memory permissions.

> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -37,6 +37,7 @@
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> +#include "../kselftest.h"

I'd rather not include stuff. The reason is that this include makes
the test not (less) self-contained so it requires copying two files
to some machine where it is broken for debugging.

> @@ -83,10 +84,7 @@ static const char proc_pid_smaps_vsyscall_1[] =
>  "SwapPss:               0 kB\n"
>  "Locked:                0 kB\n"
>  "THPeligible:           0\n"
> -/*
> - * "ProtectionKey:" field is conditional. It is possible to check it as well,
> - * but I don't have such machine.
> - */
> +"ProtectionKey:         0\n"
>  ;
>  
>  static const char proc_pid_smaps_vsyscall_2[] =
> @@ -113,10 +111,7 @@ static const char proc_pid_smaps_vsyscall_2[] =
>  "SwapPss:               0 kB\n"
>  "Locked:                0 kB\n"
>  "THPeligible:           0\n"
> -/*
> - * "ProtectionKey:" field is conditional. It is possible to check it as well,
> - * but I'm too tired.
> - */
> +"ProtectionKey:         0\n"
>  ;
>  
>  static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
> @@ -241,13 +236,26 @@ static int test_proc_pid_smaps(pid_t pid)
>  	} else {
>  		ssize_t rv = read(fd, buf, sizeof(buf));
>  		close(fd);
> -		if (g_vsyscall == 0) {
> -			assert(rv == 0);
> -		} else {
> -			size_t len = strlen(g_proc_pid_maps_vsyscall);
> -			/* TODO "ProtectionKey:" */
> -			assert(rv > len);
> -			assert(memcmp(buf, g_proc_pid_maps_vsyscall, len) == 0);
> +		assert(rv >= 0);
> +		assert(rv <= sizeof(buf));
> +		if (g_vsyscall != 0) {
> +			int pkey = pkey_alloc(0, 0);

I'd call syscall(). glibc might not have pkey_alloc(3) [[citation needed]]
And I'd move this pkey support testing to the very beginning (like vsyscall).

> +			if (pkey < 0) {
> +				size_t len = strlen(g_proc_pid_maps_vsyscall);

OK this test was broken, but it is not your fault. See my next patch.

> +
> +				assert(rv > len);
> +				assert(memcmp(buf, g_proc_pid_maps_vsyscall, len) == 0);
> +			} else {
> +				pkey_free(pkey);
> +				static const char * const S[] = {
> +					"ProtectionKey:         0\n"
> +				};
> +				int i;
> +
> +				for (i = 0; i < ARRAY_SIZE(S); i++)
> +					assert(memmem(buf, rv, S[i], strlen(S[i])));
> +			}

OK-ish.
