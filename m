Return-Path: <linux-kselftest+bounces-36763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17AAFCF38
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A671621D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D72E0929;
	Tue,  8 Jul 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+M9Gt3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318662DECB4
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988569; cv=none; b=o1OwZIGZHS3A1VGI7alcus4cqnjVszI7f4JUHkPLyJhVN80ORwBB+oMTUwyzo8ETcViR//82BchYgYTTiOWsU0s+2sNpD46Io9Mer6sYZKUqgTMWyPDN2EKTfI053yxdEcvU4hjbXwNeS6TydGgZPv/aja2iDDTu2X6ETsea4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988569; c=relaxed/simple;
	bh=DMoeAamdcn4x2vujQ/emwPNfhc2+DVpLF/Qy0VyrneI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JE5D68rSqyIr3gz6oH5ZuiAYsvpah6vgedIK16Qrc1KiETBOXRQbfIincsfGGlwagKlZ/zI6Mn+OuwQf08SA3PC7B8ArIQAYjqiugIvbjV4YiRtLPUlNIIJhj2AUd44Bo4XXc1hXRicJm3vh9qU2xPLREQtBBP/RooFfx/Y6rNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+M9Gt3H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751988567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qOTqGscz0IC329Fs7upIc9zkrTfsj/JtLQXQ3TvYX/s=;
	b=G+M9Gt3HdfOqZND/SPgsCLToKFTVW6hFO+DqR7ydfwXiUw1dSD4X3QqtFo9CP6orGcy4Jy
	fS9adAknLUyOKVuEovmYHqc+/l9KQgErNM+paqu0yKp6/uC50bpN3FDE0fU1HgFoogsG8T
	axTTFLmggVI5E6P9vIdRNIkdmeDrf3o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-MSMWyCXgP8C-uNSbjYz5ww-1; Tue, 08 Jul 2025 11:29:25 -0400
X-MC-Unique: MSMWyCXgP8C-uNSbjYz5ww-1
X-Mimecast-MFC-AGG-ID: MSMWyCXgP8C-uNSbjYz5ww_1751988564
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a579058758so1869547f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 08:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988564; x=1752593364;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOTqGscz0IC329Fs7upIc9zkrTfsj/JtLQXQ3TvYX/s=;
        b=rB9Jq28Da1Y/mIWuERsnilbcfri7jFQ/WxRwiGOuR2Pna5L0+75Tn413djZWy4GaZr
         HvWWLNmHRAc023wg/b4GmE0q4TLLcnH4bGemZ3wGxsuzZSEze49z2/nVvnzaxYEwD632
         UJtjHxAx8hfmEcOAg+QcFbjlHMukOIIsWmbp8lcKweuD3HFXM+la9x8iTFLW3U29Jyqh
         WZBUGgEvU5TVGYTqTDrgnT53OdowrHPvgGxa17qXga1A1IY0NTNBq/rXWN4NqNLg2acI
         Val/SpzkU7fQ9JDL2WCGasOc20aIjtfuyqdeCnHpFmfRu4fSAHNUrHX0sp7OWLmR5ed4
         HMMg==
X-Forwarded-Encrypted: i=1; AJvYcCUivsK/bsAwpcGKPoPmDB3WVgtKh+QqJxDayFhYiengwBzTDUh2P2eFQRAyh3VbJolsrAKzXIEvwB20YyXG4HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9kP4gfV0rLALugGCJ8RHjMRd1hne/02HAdj659VoGeLdGrqX
	gegQPsEIQpWMvcQHKoBELm+eMoqB/Z4X8/jAnQ24/FUJU7hTzg9EsSAxzpMnlLKrQ1V8FpkFWH9
	jUEthPGTL+qiawsVl2I8RmXRXxO0Hn+RHAVuy/XDAq3K4cY97yDED30u9B51PjAikRPqwdg==
X-Gm-Gg: ASbGncu0Y+F5luSQOuAcXMUFFAAEHQINJ3DV6i1TE2H6UvaHsLH1SxwpN07n0F+xPEQ
	DbDhzuUU1hX6Jlj44M8f02VhLAj6v0rowLhdWzqItNKkrHtsooI5GN2XgH2oTgugefkgbRmW/pU
	ZvWfbw32BPnqxbOuZwAq86nhj1J71YkBRbPz5UPiDb/5P1Gl30eu2eG/x+0H8P2qhYaCQ7c7+Kd
	jWNH8lzAAEdEYTsxSUwh39u3nohot+bBOC+zRNwqOAowEefFTbGWXaWcDBFzAbVEhD25Ns9A7rp
	NXNJOU9LNydduYDmgMNvyrOEJqBNCRGSEihB3Q7e5vQzgR7IYLfVdcrsntt1vuNghNP3QFEclO0
	bOAxEdQYBvVktSa7j2R6NVVEGIauN16sb1P4NvjEdCRjAJd7VgQ==
X-Received: by 2002:a05:6000:40df:b0:3a3:7987:945f with SMTP id ffacd0b85a97d-3b4964ee23emr14743246f8f.57.1751988563860;
        Tue, 08 Jul 2025 08:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Jx/p06W6BywwUvOMVKdLhp4+iHVWE6JG/qR6+y2wcBz0eHTjdPBuqN/ZiA8hpRlzl534Xw==
X-Received: by 2002:a05:6000:40df:b0:3a3:7987:945f with SMTP id ffacd0b85a97d-3b4964ee23emr14743210f8f.57.1751988563395;
        Tue, 08 Jul 2025 08:29:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f500:4346:f17c:2bde:808c? (p200300d82f1af5004346f17c2bde808c.dip0.t-ipconnect.de. [2003:d8:2f1a:f500:4346:f17c:2bde:808c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d2656sm25392275e9.21.2025.07.08.08.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:29:22 -0700 (PDT)
Message-ID: <34344793-128c-445b-9ef4-853c98f3d5a8@redhat.com>
Date: Tue, 8 Jul 2025 17:29:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/mm: Fix UFFDIO_API usage with proper
 two-step feature negotiation
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 peterx@redhat.com, linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Nadav Amit <nadav.amit@gmail.com>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
References: <20250625004645.400520-1-liwang@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250625004645.400520-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Key changes:
> 
> 1. Use features=0 in the initial UFFDIO_API call to query supported
>     feature bits, rather than immediately requesting WP support.
> 
> 2. Skip the test gracefully if:
>     - UFFDIO_API fails with EINVAL (e.g. unsupported API version), or
>     - UFFD_FEATURE_PAGEFAULT_FLAG_WP is not advertised by the kernel.
> 
> 3. Close the initial userfaultfd and create a new one before enabling
>     the required feature, since UFFDIO_API can only be called once per fd.
> 
> 4. Improve diagnostics by distinguishing between expected and unexpected
>     failures, using strerror() to report errors.
> 
> This ensures the test behaves correctly across a wider range of kernel
> versions and configurations, while preserving the intended behavior on
> kernels that support UFFD-WP.
> 
> Suggestted-by: David Hildenbrand <david@redhat.com>

Skimming over this once again ... sorry.

Nit:

"Suggested-by:"

Likely Andrew can fix it up ... if the patch is not upstream yet (did 
not check).

-- 
Cheers,

David / dhildenb


