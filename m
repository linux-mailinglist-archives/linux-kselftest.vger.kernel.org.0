Return-Path: <linux-kselftest+bounces-18987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C398F9FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A9AB20CDB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371A1CDFA8;
	Thu,  3 Oct 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHxD0yCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFE1C9B68
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995366; cv=none; b=dDiTXXLCupSPNwlbrB7k8Hp/TQzqgScgAeoonuJITCi7YPJoku7MGld5GnXqwJZDqSaKxQU4P1DqX+Nihc1w3YFSN3VGnu0fV5zepQ7VBjbtrmLaAHTHDkzZxkLC20CiIO5eaMDleUNQJYPyAl3RRfyXg2xnxSmioBRehWFFKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995366; c=relaxed/simple;
	bh=slfJQabQannlP5EcAYVie8dca+GWvDtmH71yv9rA+Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=CQaZIbI3YzqGIUOqaQzF62rkZxeqq1HxFDwiZku47eMV7EVsI8/42LG+rKSmUKOm9saK/Ou+h2Yaq5TmvOC1IMOfbZD+yOAdxpw4EzvxlIFDse5EafgBq9Ti9SoCxSTQN0Mgc5naWXLlYD9ZV3CjldvpuTQ2VjzunrMcj3kOF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHxD0yCn; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a342bae051so6093545ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727995364; x=1728600164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NASCXobNgPDDO09OiBNFwTuAYgNfV1uLQ5qme5nt7E0=;
        b=KHxD0yCnM4bnmu0T3BBaEv8WGietX/7489ceen7cA/A//Xeyg489BSJIU1p6FnMz+7
         qQxjSdW7vu9RFcJW7pxNyhRTUp0cgxNxsCK4ELGdSRg1L9MxF2pG6IXw7OCexW/p+KVo
         rr2ySaNxxeax8zrb+vSkdY6+tmB2XOASOE4Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995364; x=1728600164;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NASCXobNgPDDO09OiBNFwTuAYgNfV1uLQ5qme5nt7E0=;
        b=e3qW0UDrdT6JkZvEWCtKx6FGF4aXtBJCa+gSqMb4g7fyfm3kWqayP8PYHYr0LoKJx4
         lODBxwcUWeQ/VogSJSdWovBwXJ+kQQBeFqlquO+AfQpWZfizD/NHKLwrXoYsl4BQRCey
         W6/bu37OYBtDLA1sNNdjHhaxtiowYX2BfPPYKbhew+c0BEiwvSN5BVIge95Zshw6zX0G
         3AKUM7BEMMamIMxB0TCHVF/XXwTnS55xPGk5+6+xwP6i61EfKpu/vn6KmZxDmqX9PaMh
         T5XbX5K5be++QX2acysEyRSThPywRqApRbUVtmkhACWgW0m0f9Y9NzK2dDlvLJiW2/NT
         DwSg==
X-Forwarded-Encrypted: i=1; AJvYcCVwl0hXSWlE+nvmcyA8dILl84uG9vCUS6NEe5QW8SuPdqYMHVfc62Bf8trEFXRLShhSrdGIH1mt9jAFFO1JG7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvthcM2Okeu5TP/biEaBH7lCrgddZJHiTf8HLhxOnf70mIE8O
	8tw3muj9u/E9sK6wxFvRhrIKTgyhNRkKYb+RcDBS0qJTbPReRVRjzyauL7mL2bc0XfAe5/e8lnb
	p
X-Google-Smtp-Source: AGHT+IERcsZOEOlEJwOkiQGwugmWyZzxb82mjL2+grbrsM7Vz7Kzejlpud+S4DLM61VJgCxdQ5JbRw==
X-Received: by 2002:a05:6e02:12c3:b0:3a3:3a5e:a337 with SMTP id e9e14a558f8ab-3a375bb6576mr8350295ab.16.1727995363914;
        Thu, 03 Oct 2024 15:42:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55aa203fsm464112173.124.2024.10.03.15.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:42:43 -0700 (PDT)
Message-ID: <8a64ac0a-9684-460d-aa68-31600be3e3f7@linuxfoundation.org>
Date: Thu, 3 Oct 2024 16:42:42 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kselftest 0/3] getrandom & chacha cleanups
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, greg@kroah.com,
 linux-kselftest@vger.kernel.org
References: <Zv20olVBlnxL9UnS@zx2c4.com>
 <20241003031307.2236454-1-Jason@zx2c4.com>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241003031307.2236454-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 21:13, Jason A. Donenfeld wrote:
> Hi Shuah,
> 
> I've now read your email several times trying to figure out what you
> meant and what your objections are. This series is my best attempt at
> trying to satisfy that. But my understanding still has a lot of question
> marks, so I may have missed your point here. Nonetheless, maybe this
> moves things forward a bit.
> 
> Jason
> 
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Greg KH <greg@kroah.com>
> 
> Jason A. Donenfeld (3):
>    selftests: vDSO: condition chacha build on chacha implementation
>    selftests: vDSO: unconditionally build getrandom test
>    selftests: vDSO: improve getrandom and chacha error messages
> 
>   tools/testing/selftests/vDSO/Makefile         |  4 +-
>   .../testing/selftests/vDSO/vdso_test_chacha.c | 27 ++++---
>   .../selftests/vDSO/vdso_test_getrandom.c      | 75 ++++++++-----------
>   3 files changed, 52 insertions(+), 54 deletions(-)
> 

Thank you Jason for fixing the problem. The patches look good
to me. I will run some tests and apply all 4 patches for next rc.

I did review the 4th patch as well.
https://patchwork.kernel.org/project/linux-kselftest/patch/20241003171852.2386463-1-Jason@zx2c4.com/

than

