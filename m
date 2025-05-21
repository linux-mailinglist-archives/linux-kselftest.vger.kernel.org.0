Return-Path: <linux-kselftest+bounces-33447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001FCABECB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783A117FE35
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D55235041;
	Wed, 21 May 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrIUPiya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1F22B8C3;
	Wed, 21 May 2025 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811123; cv=none; b=u8LgGSZtsBW+YLR3v0EAo+QN5H89eSYorj1Ztj+X5uOezyn7tE//Ix1MHrVarJxKpdwhEznNMBbD1C5U9TXjQI8laMUojPv0NRdWvUPZgsm88bLgRZ10fr00GCSlsYUNaYYlMDz/SzVK2fPYT4Sft4Bz1/Vp7pvi8sCpgObaO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811123; c=relaxed/simple;
	bh=CRWJpCEQTlPV9zuvKipkjRcKPNnuB3s5a8Y/uhRQISg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN/d1Dmsb+zIY70QWdPh5MN0pkcVZd+26clCN/VfM+eM0YnuuVaXEoSAa33XCdC6wtj8REuo0+dPVtcFwJLzolaiQq4vZtMwOkd7hWS0FrjF2Z5E4ZjtJXEPfB2I6omUkDQZixOhgkkdE4ZMgNf36gBxMMRVpGY3gvm1rXhdE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrIUPiya; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ede096d73so46911685e9.2;
        Wed, 21 May 2025 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747811120; x=1748415920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVBMFYR66wWyXi/ZLPMoKBQITzYK4w2QbdTYAurV8Y8=;
        b=GrIUPiya8k7FN9ik+h3vp3mcIiJUZs+Xcf+q9Ph2FCA4dzLwevLAaCGLswhATZ1G5v
         dHhKLiIQd4e8RsQsLR37ivrK5lCP3s5MSIZ2141aELlgbbhVPXBQBkw3wWNuo0Yt99El
         3KLOtTqMCaX8d4Nt1tmfRgFYN/JPGIVINby7+1eFRTU7EWUTd2+7EZEsptZkbKmMMJ0+
         6mnEiSgKpHkaUhJGaiC2msFXOUVK7vOq9CCJgIQzlMq+QMi5gKFohaIkfSI+mNxar6X1
         bqHwD0tddOcvmpLfLWq2x16XbD0DBTS+mQrarbZLBGTBbaS7Fh3x0Qxf0FehIVSWUg3Z
         E0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747811120; x=1748415920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVBMFYR66wWyXi/ZLPMoKBQITzYK4w2QbdTYAurV8Y8=;
        b=GA4ZR5v9+IM7SsGHwjDh6Ov1gQ/HGCo9VOXjpvOiffuFcIC5NfTa7RcByeu4gjLSIz
         J9wEg9JJlVxSuhsyUPTKFE6cyGS2aduMypldrfrgGskfvF2aEHLyBvidq4JGEYxzWXCJ
         j4EhYShyD5hs5gLMfOabWoGVCL45Ym4c1FDa0B/DArz5bQpOXhRVHknH7dMaFntwhycq
         R0Or0UXv1KCfqMDkJAfz4rkFJIx41hLBnOFHPEQWA9mhoxHLY9eLXWlLryVBex5CD31E
         2KlFbsbG0qUXVbc+4OB8/MtzkiuBn8wcQLa15mUBTfRGys9Wqw3WIEBVX6i5KHN2G9QW
         ad6g==
X-Forwarded-Encrypted: i=1; AJvYcCUARHDsqypX7wtVV3ezxlfOkkx1IDUXVz5rBqyS9PJuz5C0QgL5i0RTH1bCBFUImwHilrJx/EkdeZw=@vger.kernel.org, AJvYcCUD5rGDwSe2w5+zhC3UyfH09zhREjjKM/3vRdIzv0YMyLH1ckqtKUqWFcnJZfml5xbPpcjSskcw@vger.kernel.org, AJvYcCUTr4j+BO33yW9DWEpM2VCm/MmbGVKtKCiO06L+Sfg2M9Djx0KqiRxxiqHBsrmk2SMQlhZbkYgfmW7cNA==@vger.kernel.org, AJvYcCVOsn++c/eTSx5QnZEgAEr0/PohnBkvNFTQzME43FTe+EQjllQfKp14/cqJcfTPCoMbL10JnvBo7IY9DG00/rDO@vger.kernel.org, AJvYcCX1Fieiac28MVoB2K0GIvnH+F8Z682FLOi4Ns+M/1woYQY1iXMWgA6CX7zTgHyaRLQa2dFeONU0AwR+eBFn@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQzJ5d1qJpn8Qt+7tmO/6hp0aezjjPpHzqqjyeu6/VC8ZQiPR
	lw9Qjr0MV7pH+Ww3HIOxcofdNozeNvvK5VoxjSgIv1ePJ4IunWbpK4dr
X-Gm-Gg: ASbGnct4Ti7oj2RCkaeO3Jy17GNRdX0AOUkqesUjEpf1RoRiJgepr+qN79K4aS1VEA+
	6cCqMB+hIM/3ro7xg/wlMkZ1PNi5qzkZZlFRSeDxMiDKc9gsunrIEwmviDTBJwMxyBV5g8C7vqH
	7w6f5+SrVxOgioiisZxNZgdR6dUglw/3Mxo39m9N7HKQhhriyxLnwKmGnK7g8vZp4yAJgNC0N8r
	wrEvYyTd5t4SJQ+BKssRKgY6XNp5JlP2mDql3TBJlYld3GBu5NA9JNeujnAmot6chB4/innHTc+
	8f1dvp4BBxFarJHlCho1vK0RucNmIHM8LukJNWT65kYKzjbtUQlBJyYBv8j1tjlHtXRYgpbD
X-Google-Smtp-Source: AGHT+IH76b0+NNb6/NkbSwWOkVm7cWNBavLWnfUchKABErnQARC8/2YWL6aXIXncA8+i1sj6S+5VGw==
X-Received: by 2002:a05:6000:3105:b0:3a3:64d3:4047 with SMTP id ffacd0b85a97d-3a364d3405emr13275697f8f.37.1747811119524;
        Wed, 21 May 2025 00:05:19 -0700 (PDT)
Received: from [172.27.21.230] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca889a7sm18892685f8f.72.2025.05.21.00.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 00:05:19 -0700 (PDT)
Message-ID: <80b40828-8fa3-4313-8c98-823ac7c055c1@gmail.com>
Date: Wed, 21 May 2025 10:05:13 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V10 2/6] selftest: netdevsim: Add devlink rate
 tc-bw test
To: Jakub Kicinski <kuba@kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
 <1747766287-950144-3-git-send-email-tariqt@nvidia.com>
 <20250520155957.04b27217@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250520155957.04b27217@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2025 1:59, Jakub Kicinski wrote:
> On Tue, 20 May 2025 21:38:03 +0300 Tariq Toukan wrote:
>> Test verifies that netdevsim correctly implements devlink ops callbacks
>> that set tc-bw on leaf or node rate object.
> 
> Please add a test that can actually validate a NIC HW.
> The test probably needs to be in Python to use a remote endpoint,
> and should live under tools/testing/../drivers/net/hw
> 
> We had a long conversation about what we expect from the API
> vs how your HW works. One of the test cases should confirm
> the expected behavior, IOW fail on mlx5. Which is fine,
> unlikely that any NIC will have 100% compliance. But at
> least we will be documenting the expectations.
> 

No problem with that, we'll add.

We could've saved this extra cycle if my questions [1] exactly about 
this topic weren't ignored.
Area is vague and not well defined. We can continue with the iterative 
guess and fix cycles, or alternatively get it clearly and formally defined.

[1] 
https://lore.kernel.org/all/98386cab-11c0-4f74-9925-8230af2e65c8@gmail.com/


