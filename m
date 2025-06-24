Return-Path: <linux-kselftest+bounces-35674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEEAE5F10
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0930C4A03FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFAF257422;
	Tue, 24 Jun 2025 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyacTO3l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421886347
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753532; cv=none; b=IicEJjERCL7LdFhsivA/H2qwEXuQs7o/HXkiuRVIfV7Q5brgNLJvGDzjW4MU0iuiKTmDBrwasrXPIPqnVAw1fZX/t+x8WhHANzTSGf2Bxu+JTztLJJRpSfOKPLX1NHoA4LZDUYzT5c0EVq38GSiPhPW2682hm5Aj2pECpMylZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753532; c=relaxed/simple;
	bh=v+j9A2P5tDS+QVyr3TAKXUYg9OnqGPp3gpGqYyOwpjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcjcsKYjTvCKCcVnqBSSb5Hg6hLnnbmwXJa5+7furRaCFpB7wWigCgIDdWNvDzcXoATJL7ddw/7kWdqp6lE0MaKeBs67iW+z/xhY4/Z/vfywilcURN+jp9/dZj3AYAcbrzN4xUmdfGQ9FogwdL56e9WYg1rhTocxDZtZ3Q2GVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyacTO3l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750753529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0ht9obNB/zWD628XTjaTGT1DPmDG/6sGT4fPKITh1Sk=;
	b=WyacTO3lTILZ5LgLNOgDnUsWHzqImB+XXtRb9w5++6hy1ce0OOd5VhdQ7R1YGIucPJlVZq
	RKgstaRVlIVcAqgt96ELtqq5Yh9P2OCk5JpoH2NLCLGwlYV9Dgsh/HNQOG0UMaN20XPVgF
	0iDXJ13pOQSI92FmbOPnCINjPr8BDiI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-F40DzE06P6qMS5Tot0mTIA-1; Tue, 24 Jun 2025 04:25:27 -0400
X-MC-Unique: F40DzE06P6qMS5Tot0mTIA-1
X-Mimecast-MFC-AGG-ID: F40DzE06P6qMS5Tot0mTIA_1750753526
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so2826181f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 01:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750753526; x=1751358326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ht9obNB/zWD628XTjaTGT1DPmDG/6sGT4fPKITh1Sk=;
        b=M8KTyRF8cXGYuwcZcysXO2OvDpH8Ia738q9gcFXOopxLULiGK588W1KZT+/OcIwSvQ
         IJvo7PRS6Nl8EcYZUsfk6dVJPSvnF+sprBx+nH5neJCTIRQPx6WwjbsuvPCLYb/OIo9n
         d8Del9a1qqWO2ErZfmOCktHWwxzyTtx77ZhpzB6RJGuietRYNR43kI8TVxupH85+4cAG
         HR2MgU1rJ6VhaTtXiHLEaX4/h9V5BdDPfYLdvXRu6pbQVUx1FZy2bFgKYiJpcfqXDuU5
         a4PJsLcDVpobQi/Qn4vgDagCzZW88YbsU5Uflx9L+NWvqGGCyl+g0buj3Qzc6QoCRW79
         QOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd5geQP8LaWmn1hWA4DG/IPMwKwvjImttlB0i2yohlaxg86yaqoltEWdjl4B++sRAP/GH0ZTQmfNEkn3fGo74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WFPE/urtZpvWi4eM51byjoUz0MJbcZW24u864zq9+nxgMW8k
	Ch322yFhqNFlH4fOUQYqNa9e4Sc0+4ia/Tte8bWJjqbGAW/Pm9dM8T1JfXAkShsQvy6Fb4iihFm
	eIm2dFgqMdE7vNETFx9KWmdaHaoTJZg1DIWGTbbriDI6HX3JBaSG+j8RuXBX8SfMqHuFicw==
X-Gm-Gg: ASbGncuwe1WCkGkE9+F3sphlnMMdGNZq1lI9gBCrSdIY/FP3qBkCwD2cfZOc3692tJk
	tfcn7jYz3LgcwFWpR9Lo9vpRl16OaP4EJ9M9QzfFVWOWoTMcTwH23KNRLNhz3nUu2C88S8PBlSi
	oBMGYpmrgu+c0MDZgUKxA2HwrskKRdRih8wlKD3t5uj2EKjIUkPOe0sSirMeWRDVL410uJyomm2
	s35DGvcN7twng0n32abBn9WjU24/hJCjnXPcMQSGBgvmNSxcPbBzpDRqqnFdbQWBQJGDhiVZ7ck
	onolsPChRw0ZhPssQVXfatdKXDe7fxgUVGYw
X-Received: by 2002:a05:6000:2801:b0:3a6:d95e:f37c with SMTP id ffacd0b85a97d-3a6e71c0f28mr1467903f8f.2.1750753525642;
        Tue, 24 Jun 2025 01:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcxpfGpPVAdzv6s7B138Q1weXcQzlV/9i1DRCxfMy/EA2TyONOhYuOH4WjacHa65ptKpGtOA==
X-Received: by 2002:a05:6000:2801:b0:3a6:d95e:f37c with SMTP id ffacd0b85a97d-3a6e71c0f28mr1467887f8f.2.1750753525196;
        Tue, 24 Jun 2025 01:25:25 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:84::108? (mischulz23.caps.cit.tum.de. [2a09:80c0:84::108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810caefsm1268633f8f.87.2025.06.24.01.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 01:25:24 -0700 (PDT)
Message-ID: <4b69c14f-1001-48a0-9c83-6d2284b5a04a@redhat.com>
Date: Tue, 24 Jun 2025 10:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ksm_tests: Skip hugepage test when Transparent
 Hugepages are disabled
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
References: <20250621004808.368878-1-liwang@redhat.com>
 <20250624032748.393836-1-liwang@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250624032748.393836-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.25 05:27, Li Wang wrote:
> Some systems (e.g. minimal or real-time kernels) may not enable
> Transparent Hugepages (THP), causing MADV_HUGEPAGE to return EINVAL.
> This patch introduces a runtime check using the existing THP sysfs
> interface and skips the hugepage merging test (`-H`) when THP is
> not available.
> 
> To avoid those failures:

But we deliberately have in tools/testing/selftests/mm/config:

CONFIG_TRANSPARENT_HUGEPAGE=y

So isn't this rather a test setup issue? Meaning, the environment is
not well prepared.

-- 
Cheers,

David / dhildenb


