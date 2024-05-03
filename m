Return-Path: <linux-kselftest+bounces-9425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F48BB3F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38872B22066
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C419158873;
	Fri,  3 May 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wgt+I4oA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEA339A1
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764521; cv=none; b=KbT5Q/xkeNFONkIRTbm12BF/AujMleM4bnRq5LSA/JLXjJ5oK8Qh3Wq3KhlsFeEaxpFudwnXufvH6LpIJGe8redbyFyP5eJYPpGd9Qc6DCJWFiLfYdLiTbbqas8pdTvHb+c7PwFjM/oDKMnFqNT6NEm2UTRGcNiN0UrPCy7UNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764521; c=relaxed/simple;
	bh=NtD/N9t4INPDtfSQnn+3iVWzc/81QHKoZhzuQv2WgVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ww5mwpJwslhrXBgr1oMP2cfgAb6kDQY/nY3YOyftTMW1IPAFgJOpxUPsEjY/W90QHLIZ1hTsEfU6KAGt8aVY/G512X15x9BpLCJFcC415fuNkZgwwUB98pGedHnlPOLfM3cZE9eedbTPvyHP55yv+PIvXsd+qFfxAcUAAQPuoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wgt+I4oA; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7dec82cc833so143839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714764518; x=1715369318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQQK668cb7m+WFTADFVdjdUFjoIDdrtZ7z2hWcOrUGo=;
        b=Wgt+I4oAqj98eWxvhPRILsGs3bHCNXVBgQR1g2y7kQgfsrgoN7/9hBWmfb4sBgdojx
         CkVjaga3rhkgm9LDb3u0BK4qWgNpY5PyRGs7my7+Ja95i2Wi1x0Ok0+fsK8sERK8NFT6
         4efDZwRgBda4t84Cdg3SwdAhuFLBtSWYrypiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764518; x=1715369318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQQK668cb7m+WFTADFVdjdUFjoIDdrtZ7z2hWcOrUGo=;
        b=u3P4fR3T2+ALWmEKlN7ok/IcfWFfp7i6hqyfDjZo7HA00UCyaJORWc5KOrvm4sWt/F
         bG4IQUnfgIrN14CsUtWqaG3vCYiXddTf/7ngllIECyLOS17gbNHTJkqzMNjpv3qsO2qD
         AFksMyy2jmKPS4O0xVJP+8CseV/JhrPKKv2GyCSo1orU518Inzg8M4++SurK+bamimNi
         mkN8rlqbrGG7iYcZg1K1Wyq22j+z4MyIoxsFnyhGyVnxYv44pZ9pztx9VUIfJbKXRVO7
         mifsuPUBzv8gABpy50zeurxVWiwfZrM7X9GQlGKPfierr/otOUJwvKyv7YN1E7czJm4/
         lIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM8HrvC8nhwVTlRig20Rnveu1TCyRQS95ebui/pdNi09iQFf/Tf0xWaEPUfZxHHlszV61475iDxtrno9egf9zBjYxSU1g6URMu58CLQsLe
X-Gm-Message-State: AOJu0YynekzWakYx3Tkr9J22ZSS1AYkf5wTeS6hFg0c1c0B/R1vgFO08
	ns7TkRZGCmjJ9LQswv3bPVhtiwMG37/cYh7iE8NpKvtl0wrIpQjqUDzp2FR9ako=
X-Google-Smtp-Source: AGHT+IHUNJ0TY1TW1Mg6HSF6/aaw8U7AHNICQZtR+RuZAgfJ7O/a5nOimtkvdAUcSDpyyFTRNcuVsw==
X-Received: by 2002:a05:6602:17ca:b0:7de:d808:4b29 with SMTP id z10-20020a05660217ca00b007ded8084b29mr3906372iox.0.1714764518457;
        Fri, 03 May 2024 12:28:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o21-20020a05660213d500b007dee16c48d0sm755883iov.11.2024.05.03.12.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:28:38 -0700 (PDT)
Message-ID: <c046fe18-8b69-4689-9d28-6926dcbba4b5@linuxfoundation.org>
Date: Fri, 3 May 2024 13:28:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/binderfs: use the Makefile's rules, not Make's
 implicit rules
To: Christian Brauner <brauner@kernel.org>, John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240503015820.76394-1-jhubbard@nvidia.com>
 <20240503-glossar-notfall-bd7c234c2da7@brauner>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240503-glossar-notfall-bd7c234c2da7@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 03:10, Christian Brauner wrote:
> On Thu, May 02, 2024 at 06:58:20PM -0700, John Hubbard wrote:
>> First of all, in order to build with clang at all, one must first apply
>> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
>> building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...the following error occurs:
>>
>>     clang: error: cannot specify -o when generating multiple output files
>>
>> This is because clang, unlike gcc, won't accept invocations of this
>> form:
>>
>>      clang file1.c header2.h
>>
>> While trying to fix this, I noticed that:
>>
>> a) selftests/lib.mk already avoids the problem, and
>>
>> b) The binderfs Makefile indavertently bypasses the selftests/lib.mk
>> build system, and quitely uses Make's implicit build rules for .c files
>> instead.
>>
>> The Makefile attempts to set up both a dependency and a source file,
>> neither of which was needed, because lib.mk is able to automatically
>> handle both. This line:
>>
>>      binderfs_test: binderfs_test.c
>>
>> ...causes Make's implicit rules to run, which builds binderfs_test
>> without ever looking at lib.mk.
>>
>> Fix this by simply deleting the "binderfs_test:" Makefile target and
>> letting lib.mk handle it instead.
>>
>> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
>>
>> Fixes: 6e29225af902 ("binderfs: port tests to test harness infrastructure")
>> Cc: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 

Thank you. Applied to linunx-kselftest next for Linux 6.10-rc1

thanks,
-- Shuah

