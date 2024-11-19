Return-Path: <linux-kselftest+bounces-22248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4E9D2321
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD08B24AE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A21C2334;
	Tue, 19 Nov 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6uo4YtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84619E83C
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011145; cv=none; b=YH23XpFmOD56LHzONYGnJejMnEtXlu+7Ubi207jMJJUZ3PQ+54nk8yUTFAoIdPtLUfLIw5xfO7S2rMHk8KrV9PJanoL0xMwUdYtBzqPflsiK4ECZR/nm4JBjr4/NAXrMcgb4+sSyrIsO/UnJL1vahmi27yWoGDoj29iyV3wm0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011145; c=relaxed/simple;
	bh=RZKQppqR9ulv5+UY512XsPJDhRPR3ltZNrET/GxkkTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB5ScQ0aTdOYU/9xh4zeo59JCRXhiYuMBm2PtT8ElizIZ3kJEI5ryYuO395cChNNqBFgETcPTOc5zx4uD9TO0CZTcgdyEXg90w56AREh33kONXsR5PpDW2v6JCg8Fp0qnLnbhIqafgaY14a+/WtSKGDQOmS3uG3M8LVJKYtpCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6uo4YtP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732011142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ll/h4cIcHRULNe5533lZjrqgLdazs+/VxZDeHMmso=;
	b=d6uo4YtP/v45WmKuufMYZ5zeYVmyMCvOE2ItXflnK6juVrKBonwnArmUU1jCLMWRcEKnOi
	GpolrU4RVTvQ1IfdqeHbGDDJfAKyDkoEEwrwDrcPJOE39rCOX7nOIiGDB233vLy6jrKnuP
	/FNLIJ04uUOSvgbEa323bftsILZ9Ai0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-pMDmDYb-OdGV5yAr_cYIYA-1; Tue, 19 Nov 2024 05:12:20 -0500
X-MC-Unique: pMDmDYb-OdGV5yAr_cYIYA-1
X-Mimecast-MFC-AGG-ID: pMDmDYb-OdGV5yAr_cYIYA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3822ebe9321so2294188f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 02:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011139; x=1732615939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/ll/h4cIcHRULNe5533lZjrqgLdazs+/VxZDeHMmso=;
        b=WcMP+mzglNO9BKC2W9bfk+ySIimrWGr2cRrK20u5M8DmI4aifo7DgyH9FQlmF6CKw8
         AxjtTyegxPD/wmn/KKrqQrWMMSTPqFOxq0rt4ciAmA5qwSvSZPMlMFKWG2hOxwVl+0Au
         Nx0YA9oYiySP3K8prDwq5avEXpS80RtteqG7UVo5ziVTbmZ+ZL1GkpacwikVWpBmCtQA
         9WTjsQkpNCvJ51GKI2/Yp29sduiunBABMtZSXdDSGPuLLCU0yL2NrCk0s5V9grztuobL
         ZBGnIf3RsciFgm06GBdKAKXZ2qz71VX/kyEU3PNkcbdFjiqcPGW74UW3E3FQOeH6n6L1
         WasQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxggjb1J7cBRE/PiOuVb06Cal8zLud/pfPqmB/+WKeTjl8DXMC5WaXDd7T1/3XadkkKutkqGX3BmwJ+ithjv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCQCX8SPNd86tzqpZ1qBADeeyryRiBKKvhGgmr/JQRz0VaMtl
	W2lKGtioMiY/b2Of3rakt5uyLEGLRk8GvcwSzk8ArqL0e+tbKkazdU2YyOaOP+8cqZYxfT3p+BY
	O3no5+Wd4ZUT5avqTAlTsOcrDPHV9C533h/qwtS2vL4QSl0qf+Zq8EzGey87DfDBJZQ==
X-Received: by 2002:a5d:64c8:0:b0:382:2d59:b166 with SMTP id ffacd0b85a97d-3822d59b4c3mr9274034f8f.31.1732011139221;
        Tue, 19 Nov 2024 02:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsZiTehmq/TGAqmnasd9Ezz+OKagNClXCsAKRt9ii4MiUiLKopP3o2dTpIdkPJjOhag9LPew==
X-Received: by 2002:a5d:64c8:0:b0:382:2d59:b166 with SMTP id ffacd0b85a97d-3822d59b4c3mr9274006f8f.31.1732011138858;
        Tue, 19 Nov 2024 02:12:18 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38246b7db13sm5907061f8f.91.2024.11.19.02.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:12:18 -0800 (PST)
Message-ID: <554d8684-7eec-4379-9a21-0b4a562358be@redhat.com>
Date: Tue, 19 Nov 2024 11:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] selftests: nic_performance: Add selftest
 for performance of NIC driver
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch
Cc: edumazet@google.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, brett.creeley@amd.com,
 rosenp@gmail.com, UNGLinuxDriver@microchip.com, willemb@google.com,
 petrm@nvidia.com
References: <20241114192545.1742514-1-mohan.prasad@microchip.com>
 <20241114192545.1742514-4-mohan.prasad@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241114192545.1742514-4-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/24 20:25, Mohan Prasad J wrote:
> +#Setup:
> +#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
> +#
> +#        DUT PC                                              Partner PC
> +#┌───────────────────────┐                         ┌──────────────────────────┐
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#│           ┌───────────┐                         │                          │
> +#│           │DUT NIC    │         Eth             │                          │
> +#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
> +#│           └───────────┘                         │                          │
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#└───────────────────────┘                         └──────────────────────────┘
> +#
> +#Configurations:
> +#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
> +#Required minimum ethtool version is 6.10
> +#Change the below configuration based on your hw needs.
> +# """Default values"""
> +#time_delay = 8 #time taken to wait for transitions to happen, in seconds.
> +#test_duration = 10  #performance test duration for the throughput check, in seconds.
> +#send_throughput_threshold = 80 #percentage of send throughput required to pass the check
> +#receive_throughput_threshold = 50 #percentage of receive throughput required to pass the check

Very likely we will have to tune the thresholds and possibly make them
dependent on the H/W and S/W setup (Kconf), but overall I think it makes
sense as a first step.

Thanks,

Paolo


