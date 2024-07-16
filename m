Return-Path: <linux-kselftest+bounces-13817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2A093340E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 00:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210131F23DDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370314389F;
	Tue, 16 Jul 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gkb/WLmL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F91DFDE
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167225; cv=none; b=k5Fd3HHiOQ/53IsR1Z3LOW4RuHpPt00euQ6D9vgouKHOCzIvEJuxkIcUeCuTBdHu27/N2x317Rehh9XKKkHYCy5mBPNlaEic9Np3A8AyBcedCrJSndiCRg/wPofcpbqRs0Zw80FgJNHADtTN5VHrGCcInlORvuPgoyODZNWMhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167225; c=relaxed/simple;
	bh=1R7wr/CSPAA1iHr/h8MuMIditUBxtwJRY7Nbns8+sqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JC21k78Kz8F5M82le4dq7NtfXbr8rLGEC1NbEIjpKi2ApC95Bq1Wn+guCnQHJ12wzchkWoK6PCLrfdTrXCFvX6+a6r75JFmAkXFwE6DwY5+PZgwuW1uU/I9i9QELB04I2Nn3YnsYRY7dBxRPWOYb7ADKongrgQVXxF3EJnZDLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gkb/WLmL; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7fb3529622dso1301539f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721167221; x=1721772021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D43C5TtbFu53O2HFSds4/+8o7M/kPrl9sujLKKNyGx8=;
        b=gkb/WLmLVdkCV24pmLzLbZMrgaIrKa+Gv8CrKENnZyvY+XvA3yxcnR2/TCqBZjJUnN
         a/AMSH7uusOPEU6i/aukUP3vXp34Xq4QFsv7kFmHbfdKCUaNOFxXKXNsr5iJokXSTYbu
         oJPFN0RI4e3ae0EDeXgpf3PwwUR8/X6qHAn4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167221; x=1721772021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D43C5TtbFu53O2HFSds4/+8o7M/kPrl9sujLKKNyGx8=;
        b=psjXaNwiYnyj3KoeG1PSr9i+PdG9a8rjpWjmD1Q4R/RjFa9uziE4lw7xGCgigqJrX+
         +cq6jTxD3OR9CeEaRf4cKlkxXfWO+NBjwxBBg7zl/YomRohYBbMEXDxSaCUUwyxxDf34
         iN/huqaB5XN6kjwyezVBd5kgfo9a3EWo1v73AzVSUCdd0fTNAp4HMWDQ4l69dWxNR7xm
         K1Tu1wawLUVXZlYm9x4SrduREKi+MYx0JwfvVAiyt59Z/4rA2on4+PGlmnI2L/42AXrq
         uo0xo1Aghc5l8ySLbhzleQgWaqZwX5Qj/T/EPcv0oPBjohiW/7b0+JU7wIGs8xkxdnhG
         BP3w==
X-Forwarded-Encrypted: i=1; AJvYcCXB1Tkszs7M6heavAkKHmBg4LH1bWevGAnyZIm8YvbUWAIpktizq9G1a6wCYsvJ9hsEyMCHIKuOThQeq7nO4jGkrbcFlOzFNb2V6QxOtn96
X-Gm-Message-State: AOJu0YxkKacJu0iQ9UUGD0QU3KDb9xJwJ307uBjptaBAUXmWPj2ODJLV
	Sty12POY27hL46XknFT/RWRcj/2sxSpfrt7OhQkE5yGbHg0LV5nLV6vi+lUUF94=
X-Google-Smtp-Source: AGHT+IG1OOoDocWaqpAynyoemwtS+Ij3u9aPSsTymae4wzjO7bqNyaMRiC7XHDUFhRvJW5/wrIM2jw==
X-Received: by 2002:a05:6602:1605:b0:7f9:444e:4918 with SMTP id ca18e2360f4ac-816c51c7e48mr68814539f.2.1721167221509;
        Tue, 16 Jul 2024 15:00:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c1e8e118sm17824739f.28.2024.07.16.15.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 15:00:20 -0700 (PDT)
Message-ID: <37214c0b-4b75-44ed-8801-56a09b71040e@linuxfoundation.org>
Date: Tue, 16 Jul 2024 16:00:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: x86: vdso_restorer: remove manual counting
 of pass/fail tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240712073045.110014-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 01:30, Muhammad Usama Anjum wrote:
> Use kselftest wrapper to mark tests pass/fail instead of manually
> counting. This is needed to return correct exit status. This also
> improves readability and mainability.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

As mentioned earlier, include before and after output from test run
to see the improvement clearly.

thanks,
-- Shuah

