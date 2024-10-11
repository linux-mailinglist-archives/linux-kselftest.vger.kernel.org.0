Return-Path: <linux-kselftest+bounces-19542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9099A57F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03F7B22817
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4002194A4;
	Fri, 11 Oct 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gOwlOsBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4A2141C8
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654828; cv=none; b=NJzX0ubnE1wb0VPNkLLl/b3dmfygX4M91Q5KbqkCrQ42DEVky9qbkrp7hwGRwrHIxsAvrtn9mZE/VjA0lTYtwRFMwmHSvHLFuRAC+SHlFv0dSJjH003ekPSQtwl50h0lWx8OxLtc/cW67mahHYsqQ/pVeOI/BRPMBfiZ6VRioaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654828; c=relaxed/simple;
	bh=24PH1AvQ2UstDLFxh+naoT2b+0RbZS/2ZhRUHBgA1F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guygm6i/LYo2eWRAVHFUOfseH9dV0I8dol1adgT7s8XlKwgMd9u8CJicff9lgip1DxBrdNUCCqGhx6YdncCYXdN70eR2NxsyECXMgGwdkh0YDr5I5YwVoAh+7z/mgT8CKVI/QxUCFTtg7767W1516QJAQlse0PnhFumaZNp+S4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gOwlOsBI; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8378db14280so41212339f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728654825; x=1729259625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqLEhvqcyBsBrxJSzoEoaBYS5PEjWtm/RdX++xPA030=;
        b=gOwlOsBIAM9Ppq8bkOtGAJX+F5pWL4SzQvB/2i9ZfCGMDQNb3oTWI0CiCEszJ/5RY/
         VzRbKueijl4lWbpZdqnRd3EcWCTW55YcZePl+kYFlJNURF0qYgiFSIP8PHaVDdi7m6Hg
         T7ixqjc66oD1FNKIfUV7uVn4i9Kt2HKi44W+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654825; x=1729259625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqLEhvqcyBsBrxJSzoEoaBYS5PEjWtm/RdX++xPA030=;
        b=XBOpEtGd+7R+OyN4AXONXxH4MKOSuqsZatdra+/a2OZSakG/ZTkpQxEdbXI73Ji4am
         mGbk/EtgaYvgZIyambZspKBv+STv7QROIqPfd+fPio0lnXCIfTcQzgftXr1UmZcGBDlT
         8+9KKNGIwksraKwa52wZ3ezRF6VySIpdgMq6reJrvyc6j3KGblQLlPxKCvyPpEk1rQmg
         yLlHuKKpBLrCHxiFga+Z19ViINIBLLY4uMGZVs6WNzTIazdxtHBdbyJxBfHO69ds8fLt
         JKVsNlcKJS0vFy8HbYCXu2hlH2qyRMLt/p7sjGlQVarOsnN78wpGAqkxdripyIcNOb0r
         qIXg==
X-Gm-Message-State: AOJu0Ywcvv+Cx74KPgAub1FNEUt18EAbkUcav9VVsaDP6AlbLRxvTOZE
	BhPdB43rsnnvmHLq7/ccY787aV3wKTYfMsVVHjMOUe4Piqc7AWMM70a3qIRAcE4=
X-Google-Smtp-Source: AGHT+IH0ZjoMsHPp8mc/5RWu/qnSPZNLYI8+lebD2YEEDdEZg0xP0TMZzqA7mZLEnkv71J+Hf3vnWw==
X-Received: by 2002:a05:6602:6c19:b0:831:e9a8:ce2a with SMTP id ca18e2360f4ac-8379202d846mr206086939f.3.1728654824742;
        Fri, 11 Oct 2024 06:53:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadada148sm647676173.158.2024.10.11.06.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 06:53:44 -0700 (PDT)
Message-ID: <e67664ac-dd20-40f3-9bee-0785d428ecce@linuxfoundation.org>
Date: Fri, 11 Oct 2024 07:53:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] KUnit test moves / renames
To: David Gow <davidgow@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Brendan Higgins <brendanhiggins@google.com>,
 Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011072509.3068328-2-davidgow@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 01:25, David Gow wrote:
> As discussed in [1], the KUnit test naming scheme has changed to avoid
> name conflicts (and tab-completion woes) with the files being tested.
> These renames and moves have caused a nasty set of merge conflicts, so
> this series collates and rebases them all to be applied via
> mm-nonmm-unstable alongside any lib/ changes[2].
> 
> Thanks to everyone whose patches appear here, and everyone who reviewed
> on the original series. I hope I didn't break them too much during the
> rebase!
> 
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=E4piSojh3A4_0GjE0fAYbqKjtYGbE9beYRQ@mail.gmail.com/ [2]
> ---
> 
> Bruno Sobreira França (1):
>    lib/math: Add int_log test suite
> 
> Diego Vieira (1):
>    lib/tests/kfifo_kunit.c: add tests for the kfifo structure
> 
> Gabriela Bittencourt (2):
>    unicode: kunit: refactor selftest to kunit tests
>    unicode: kunit: change tests filename and path
> 
> Kees Cook (1):
>    lib: Move KUnit tests into tests/ subdirectory
> 
> Luis Felipe Hernandez (1):
>    lib: math: Move kunit tests into tests/ subdir


These look good to me. Thank you.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

