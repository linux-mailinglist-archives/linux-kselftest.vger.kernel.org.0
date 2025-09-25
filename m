Return-Path: <linux-kselftest+bounces-42413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E423BA1415
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6974C84DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B38231E0FB;
	Thu, 25 Sep 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYH8pmio"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8231D748
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829484; cv=none; b=sPsT7xdy5kgeiaPKRIi16XhqmvPtijNzBnMDhjtzKHS6/BhRXu4/ve6Gmqcc+b8rRSkq2Ufl6TS/aJXTGt8tsq6+PvgSYqkfx7QwlBQvZT8VP3ANVltwYV/Jq3UAOnq+nG+QkAQXG2Msrjbbv0cZgNbAvwuiQQagL40xYafKvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829484; c=relaxed/simple;
	bh=hlXPqA9leDXyKU+a+StNvMRXfLd7Oiz0q/nTjQYZxBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuW9VqtHkmxIzqWBe4tnAo6Rk4agWLo8Vm97HqCQWvnOARuhmlTxGKrMVBuA7+wAAYPtKsWfyc/qpdO+Xg9g8MRyYIv+N9EjeLMYcIeS4xRQzhYyHoYkwBn8NIGCWtzFrUpUSmieic3UagoH5b5pyvtJwxjQbPU3CLvemw+WzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYH8pmio; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso11994195ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758829480; x=1759434280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=or54vQrDlSCc4oUoPw4bOHl4mIflQax8gxz1ImqODMU=;
        b=GYH8pmiom14ZpZtigjGxS20dZbUrgA0wHsSkqgPWK69dQGxtZrQdYc1HTSts3cI/B8
         9QPV62PzEGKjGvKKfwSsi57ZVtnRgWY2XQnPkj0FXyCFRPAjOILwu8X4rCMwP+lSybHb
         1CiuHILRKzG+OH0yWwbsQ8gbJyNMeIhY7qDqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829480; x=1759434280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or54vQrDlSCc4oUoPw4bOHl4mIflQax8gxz1ImqODMU=;
        b=qyAfk/1QR3x5FIkm/KvXvN2jChKwSbI4prRqcMl/3qxB8CDCe8536A0cfwVxDdjR9g
         JZyQKzNckiQ6+pOHlTBHEih0t0lfBrOxb0H/37eR7vJ0YrXYw5XVp+wNYYbCEgv4IrbW
         t2DjlFwR09iSmaGrRLtyJ38nPhmveVv7S6z0AKVovkY6hfeTF4jiApR/S9LrGQLxpCI0
         /MFd5Bty/1fkzMZ0AmU6nDUzM7VY91gnleJAYybvqZ0Zt/NO6Ec66vIhX+VRIMBS7Ork
         GB60LYPOTpeTGmsHB2COQgiYaO0rsyk2WD4n+w8KTiZ39wO7tJIcJj6uWNqrIY6FI4O2
         FM2w==
X-Forwarded-Encrypted: i=1; AJvYcCUhEhEtQKIyqq5CVQx0OEY/8OTWfjIaNJELJ+87yyFq6EMDHFtNlYu92tt3IQI0RtndgsFfAvth8AJpxbnVQds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8mhLT3VRepB07dstdz8+GepC+jI5EaSqEa3j+ihm9CT4HoUK
	ZD3z4v1i51wnn2cho8/sOoa1qZulRIEKoBkcjQ+uN2X9SWv0mwvovTugBXUKODNY7CU=
X-Gm-Gg: ASbGncvkRwgD5jEofIT5J8eF0006wXLZHWrpzTe0PxFUNNRIt1fZddBVjjQV0pRvmaT
	peVZjdsW0NoO/n0u21rRNIc9V7z2aYMoSgOQ2Thhqkr9Cl3TeX+P8TQ4+xNQsGCJFjrkBn7ax8J
	u/AUVafxMppLZDWuhZ8XoEdHGHBmZvvWe9jKx94BWwjvUi05Yck+xZajSRLmrIP854ghR7ftaJH
	ZmxC41Il42V+nASxLC2uJztW4ANAzCdVACWo4mKm+T/w7OrqROTKnEi+tWgTAFmat3GbEUiw1OZ
	C7Z5vUSlxJLrFWTeApmZf/8zUVUEGlqK9K9oeih5ksh0xAWvfr0XYxyeu/UbIElrDQwypUouFys
	qtnRjl/Uh6/vda/6DJ/R157cxO2VNfWOojcTIILejXK4CTQ==
X-Google-Smtp-Source: AGHT+IEPVyp7JzGHapxNvv4LYOPSv8tJ+j6O50sbKDaIYjBItoXAtC7pX4vo8bCfw1S4ZxWm8QkoJA==
X-Received: by 2002:a05:6e02:1fe8:b0:424:64c7:ffae with SMTP id e9e14a558f8ab-425955ed735mr80558725ab.12.1758829480118;
        Thu, 25 Sep 2025 12:44:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6ae6ec6esm1116952173.76.2025.09.25.12.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:44:39 -0700 (PDT)
Message-ID: <3fe5d44f-cf33-42b2-bb91-6a4238f83470@linuxfoundation.org>
Date: Thu, 25 Sep 2025 13:44:38 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/kexec: Ignore selftest binary
To: Sohil Mehta <sohil.mehta@intel.com>, Shuah Khan <shuah@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Cc: Simon Horman <horms@kernel.org>, Dylan Yudaken <dyudaken@gmail.com>,
 Moon Hee Lee <moonhee.lee.ca@gmail.com>,
 Ricardo Canuelo <ricardo.canuelo@collabora.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250919170139.3452889-1-sohil.mehta@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250919170139.3452889-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 11:01, Sohil Mehta wrote:
> From: Dylan Yudaken <dyudaken@gmail.com>
> 
> Add a .gitignore for the test case build object.
> 
> Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> The binary creates some noise. The patch to fix that seems to have
> fallen through the cracks. Sending another revision with an expanded Cc
> list.
> 
> v2:
>   - Pick up the review tag
> 
> v1: https://lore.kernel.org/all/20250623232549.3263273-1-dyudaken@gmail.com/
> ---

Applied to linux-kselftest next for Linux 6.18-rc1.

thanks,
-- Shuah

