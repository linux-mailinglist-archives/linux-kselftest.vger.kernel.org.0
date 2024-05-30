Return-Path: <linux-kselftest+bounces-10920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00E8D4DC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6994E1F21F9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005C17625A;
	Thu, 30 May 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BzurcPT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F77176236
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079039; cv=none; b=jX9KwCY+pHtJxDYfSu7RTnogPyz1MsKX9yK8exssofFhXqG09aw43nO+WaiLgmeTExuEl9Vwff1gm6SS6qmLJAfjlbaBSii+dGPNXkJDOzE5SLctuboDcBfrVpeuhaIx/ERxcx0jE6KGTYx/Bz7lIXe65GjZ7pVkiLYh6ck9080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079039; c=relaxed/simple;
	bh=EX4ilp/gM6DnOi7FVKsFEfXk42z10f/YXvWX2qP7jMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPmdpuZTitvsyuhKDQC6tXnn5ZBRYn5L2wBozdnDRzLPammD0e0YYXlNMjlChAvGTvR8Yl68wtNXADa0GlBkeur/HMSFVpqVEACOsWauaVCsVU+muN5qzQGhGCsvRyE2ZxVqHyb/FGJYF5vTjiQNi67qd9aokuv3pYXKl5zin50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BzurcPT3; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e3b1981fe5so4665039f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717079037; x=1717683837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxJbPKzJ8dtx+UyxZICekfPff+1WnbN4JSU+63JMz6g=;
        b=BzurcPT3ekWnph72caB2YzditLtg0jKp9nQHSRQPaUHvS4fGbtx5sAYupzuAGTve22
         vPdxus1LO1ydT84eTqTDxwubncj9AWhqeFaDyMrbSJ0ipkaOqW0GFNo5A8GMQXJ34h8w
         xQO5K8/y8CX9cIQ6wDi6523F4I7x2AlxDpDyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079037; x=1717683837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxJbPKzJ8dtx+UyxZICekfPff+1WnbN4JSU+63JMz6g=;
        b=czY6KpJ5Jes31g/IAnA7U0OTEuxfZVhk15wDeyYJ2+clsM7TFe1wHLhKAZfNsHkYr9
         6ri5hrQiOFFTd5e64RNBmtVymKH80FS3cNjptX0zzqYpMcFT87g9HXT9jvcD2kve7CfI
         JDM3yysM9f4h7TxiexENcsamRoTB3TKJntMuDsuX7jh4pC/mQ17KJKwt4WCAAmDrZ79B
         ukYochtChqF5fQgpgkE0keYqOb3RN9ONPA4WFz9ZerT1W/ZNC4/jz/hiFQ24/DoI8XXy
         7CV5xZKNDOhOLSqva11AVczkIFtpT+6NCykmHG44oifxDnmegR6O8wnF1EvRG7tGjD9j
         C2nA==
X-Forwarded-Encrypted: i=1; AJvYcCV69C7c/RQ1QucAuaKYZR/s6WyTAt040wPofQQP8PGwx6ReV/MO25yd4BleOOm39zO72sD3+/JhixnRBAeCqN5Sl7JDFcr0X5qKrAsuY8xz
X-Gm-Message-State: AOJu0Yx12NcWHtG5bYAbzem3nc44W0iE4Xr9cZ2ndQH/2DkibyHQDWZQ
	ru2WrwGzIOKyexkkc6bS0k/vmOtCjlaHLUtInEIrEtg7xvaOo9rBbS9aHICxEm8=
X-Google-Smtp-Source: AGHT+IHZ3n61TibbNscl+7LwOckJECnDnFvgbdHvo1dPkikcdKjJueyYvW7lVGFFvXphOjiJ9ENBNQ==
X-Received: by 2002:a05:6602:4287:b0:7e1:b4c8:774d with SMTP id ca18e2360f4ac-7eaf5b719b3mr252361339f.0.1717079037225;
        Thu, 30 May 2024 07:23:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03e94d4bfsm4068830173.63.2024.05.30.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:23:56 -0700 (PDT)
Message-ID: <b6641940-f10a-4ed4-a672-69c6d51125a7@linuxfoundation.org>
Date: Thu, 30 May 2024 08:23:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] selftests/futex: clang-inspired fixes
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529022938.129624-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:29, John Hubbard wrote:
> Hi,
> 
> Here's a few fixes that are part of my effort to get all selftests
> building cleanly under clang. Plus one that I noticed by inspection.
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1
> 2) Added Reviewed-by's.
> 
> ...and it turns out that all three patches are still required, on -rc1,
> in order to get a clean clang build.

Thank you. I will apply these for the next rc.

thanks,
-- Shuah

