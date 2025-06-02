Return-Path: <linux-kselftest+bounces-34175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7CACBD2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 00:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04CA1891EBB
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55F1DF263;
	Mon,  2 Jun 2025 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BK4v3r74"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9691422AB
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748902659; cv=none; b=SoM5L5vw5Vxb68oNj4wunV2YeUQE6pC4BM7fFg4nD8uqq15slDrcXCjnLRG3apBGH+6DcLuH3otLfIDAUBCwFuz82fFL9QgNU/98gJSC/cnurPCJmhCeC1148Lga7u/x9gHxg13Eb7urTV+ZIBA+DO3Rj4l7BnrWQ83Iy3VTCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748902659; c=relaxed/simple;
	bh=j6Fap+EQAIOK+jn18EOLW8N0FIHYXwyw9RKc0Puqt1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qh18ifKr0+5g2yIaM1QZ1WXLtx2QIBeeFwJpFMtwj+efr+4BX6i+Bi3rvRLEV7bC7ktCvTqcSJUzVKS+xExFc3jJKNoBjldOBmE8wkjmYtzj62Jdm5zLBu97QcRSiVT7mLhEPJ5Qo7irMiHI4i7ylCwO4TyjhEK0PrgO9wNDndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BK4v3r74; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-861d7a09c88so128595639f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748902656; x=1749507456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2QWknujeW14lLIRfZtcP+1dmYSGYay6rfog0SJjymc=;
        b=BK4v3r74kqkF4M6ZdU+2g2p0Xv/cuKXdLslyJSKmrVHEqeIUNf6hKDwnc42WnYIxfg
         xK75xtpwoauPCt8Al1uFNuij+dPILB/csOpQyYfGLYfeFQSJH80pDinld6LI4x1qOEXf
         cqDkvRq9gFkEHda5n7FVh0/hAqGjzcgqV+Q8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748902656; x=1749507456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2QWknujeW14lLIRfZtcP+1dmYSGYay6rfog0SJjymc=;
        b=uIo3cUv2UCucpGdV0ig1cjHbo/mtexduGkNPvQLKTfrYsiEOH43id9Raw9bbqhnA1j
         lloI6eJEJaViSd4J3ZYdAV3z2JeZdVWpM0mRRBTrclhDZ1A4VzEsz/KsTag2rHp7I69n
         BM3ycVw4BWvD5Fkm1PMxA0DRtHUtM3Rd88f3mvMbXP4cpmecHGiWcyajLDtdYM3Jew4t
         T9O3HoC+sNeBYBV5L+61zVjNfOGdKki6Us8pgEYHkhUqFcpzlimqj+wfq4mmy4kXyfbM
         47CEfgdbzxFzB3UVAc23DMjnr/4F8dFw9glRO1NuEU0KXfJ7U7hS4nBndpTPASXdFE1r
         Uy7A==
X-Forwarded-Encrypted: i=1; AJvYcCXIsGsUmwp96x6S8V86bD3fYbS2gf6XOFY066g7Jl2fFhigzBircjPl3cMd5j8PC9jgUTNpyFfgTf1s/9mQxCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5VeXT3BoBkVLh2XYjPTcr9c1IB0RdwwBg9n4ObY5TwLkPehaG
	mEt4krEG96frB1bAZYsKUYHDWhom4x+6zEpy82ffEFw+LjTsdg3lcLj40GhSo8Zp+Y4=
X-Gm-Gg: ASbGnctKQEAk0sFEdFzL/a2LJdENFx7tzR0fTN6A1VFwYs2njGGGj0lAmkDObCRCiTU
	C+hefj4FEajiiS5Lt7L41s/hDVZcgPECM0JAqseOyXJioKK/trDvRZNCHFSGBtxG+USlad239hb
	7vKoLrz09JaOdXs2tNd+dPZjCfkescdqBOHV/jH5qhIdVa7AHCCALRmPPuKyO+/t1eNKpxxpPp5
	4AcrRWnLmbo/Vi1IDJy/ChOjQdGWWISx9iz1VCLiDH6Q+dQm1qlikFmQnEwUV9tfA36gfZMkaRB
	3gsYcU+j3EupjcSAUBTO9hFTaQlnmPeUawZWiZmX6nlQWifORChs9kpBmPSp2A==
X-Google-Smtp-Source: AGHT+IHo0xFealycsEKSTMK+zGMcC7ZgOeGW2tvBAdIjxOTYpMujokNufwJ0G96rJS43d74JdBHfZQ==
X-Received: by 2002:a05:6602:3a07:b0:86a:93c:a721 with SMTP id ca18e2360f4ac-86d05094622mr1429654239f.2.1748902656177;
        Mon, 02 Jun 2025 15:17:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7e3be98sm1863324173.60.2025.06.02.15.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 15:17:35 -0700 (PDT)
Message-ID: <53586971-e67c-4b10-b42c-4aec8fc4fff7@linuxfoundation.org>
Date: Mon, 2 Jun 2025 16:17:34 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ipc: Replace fail print statements with
 ksft_test_result_fail
To: Nick Huang <sef1548@gmail.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Cc: usama.anjum@collabora.com, zhangjiao2@cmss.chinamobile.com,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250531070140.24287-1-sef1548@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250531070140.24287-1-sef1548@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/25 01:01, Nick Huang wrote:
> Use the standard kselftest failure report function to ensure consistent
> test output formatting. This improves readability and integration with
> automated test frameworks.
> 
> Signed-off-by: Nick Huang <sef1548@gmail.com>
> ---
>   tools/testing/selftests/ipc/msgque.c | 47 ++++++++++++++--------------
>   1 file changed, 23 insertions(+), 24 deletions(-)
> 

Looks good to me. I will apply this after merge window closes.

thanks,
-- Shuah

