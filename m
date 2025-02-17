Return-Path: <linux-kselftest+bounces-26785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166CA38703
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 15:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8252C18842B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A57223316;
	Mon, 17 Feb 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJJd+w0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333422257C;
	Mon, 17 Feb 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804036; cv=none; b=Q3bk2YFLD5jqaDzDkGxdNZOdI4YctGK0OZlYpxavOcf13uNHFahWJxezrGLnSBFSZXOk2vcnNPSY0IQU8d5Bh6bp+acX06IWygtMgQJ/tQktt1RXzE7ZVApZFJ1O2DhUK4jOV1GkyGafKTwGgn804G/qs+tcpbiBIbaAjRZyizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804036; c=relaxed/simple;
	bh=Ln6Pxhrtq08MpslKMH8KjYThuQ2cTovnCdhdR7o2bUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EA8Ese6puOviXBvjxkl9eYG84hSRjLVnxUYRymxIzAKW7gC2suDT7ybkTrQJTlORio+0fQZgoxWs7bksvDseYoo3KojuMn2Kfov0FGlw8c8bdNMnxJRLSMHuKa2wpqM1ooFG8Gu6exSgRd+n7+HVkxLwaG/yRh23WkjszGs6yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJJd+w0S; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb97e15bcbso199894366b.0;
        Mon, 17 Feb 2025 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739804033; x=1740408833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5f6aC8BX7oN5H1g5D7i2G+cHIq3J3spwkYV0IVPVEs=;
        b=bJJd+w0SUeEzvVsXCIsvj9tTorwfF87ld1cCFjju1f6VUtalfphnVLO41ZtWeUzGEc
         g1NFf89rz8ICpH6g3Fp1duM/hV2QR7rL3Bzdyf/gVzFfEFy/2Rd92rpZP1/4+DooWrO8
         YjZwxkXSBITrauoS+271/9K6G3Q5LAn7DgqpJ1/yboPCH3Q1sFyAKemmiPLnH7mKxfPw
         hzz0+bq+l6bYFn1M5eDk7UF3H3VgCfCYX9c+E/VtZqn9JiBQx+3Oupvy4soN1AaZFwgw
         ba/iEGx52EVb3DZ8sx/evOcYIs2GHynCjKVZMX7amfY6Bw4tbakDZauKOVsXrxCPj5u1
         L+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804033; x=1740408833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5f6aC8BX7oN5H1g5D7i2G+cHIq3J3spwkYV0IVPVEs=;
        b=WNl9i7hW09WcQnCDfLLOALiqu9PEQ5hNHZXWDCAQVKjt39vxaQ/KWqI/FDPs7VpCgT
         p9Q/EO178Kfjb4WImrQphHpe+IgyY7mgJ5Vs6HdnDobnM9j7OcHu6DRDaaIMKt5DD1LQ
         7ILEkQoQAZTa5UmcmIrNLiKyXwb+8sVJETRYixMiwN06OFBEMC1gD46ktyFncxBMNcFw
         iE5PUcPwqgem/QZU0JF+yPdbEfgwguUXMJWnbtk2ipi6xlmxDuwM5BHFKTo6Su0AFcfT
         HXrKJICs8HWxrj4ywLAOM/8DF++fqiGNQNdCLk7HtqoGLWv9NmM5Jyj8f0P1XYB1vnC0
         N3xg==
X-Forwarded-Encrypted: i=1; AJvYcCVL95oqmcqGRazT7ouJyBTju37lDSScURDHYFD6/H5Gt3OWQ6B4YHVmY7tFuq7hfB+L4H0YlGrSCUZf23qi@vger.kernel.org, AJvYcCVYHcIMOdieEa+ddbR12kovuDcXt+Jj9y6r7gkaa+Dt+G0YpFr7QVf8/NnC/8vDPc11Vt43sP0P9EnMPi51d13+@vger.kernel.org, AJvYcCXYxZ4ey9luIFhs/h/qeX9Ceaw6CCxvM6FSkW1il7sc3j8LF44HuEh1Zp5Qf6dy96bdsUcn0Y9wuqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYI93LJpcXGvi1mUB7GpmLn1QgIJHKf6igoZFWBAcrKfAdPuPM
	YO73GwTaroiD61ybUmAMPG41300ZEcFqL4KSSv8naTbGl7DFvB26
X-Gm-Gg: ASbGncsOw3IvKxPW/ECb0BGgJWbrAhEqyxTL7dXM57jGdTKNpZCKemIltH78EOsaFBn
	BJtNIYFmZa9XT5GiRkU0401NTzf0oTWrCcUpAkLvSwRMuulosckMLoQYc4uXFa81dFAbnT5nMyY
	zA5za6kWFvHIWPqW3pcw55LI+liJwKXIrzP4xc9VefX0pXb7kIcP5dihrSrvASetbo4M8DQFYD5
	/ZEt7speHn3RXkdmdjmVnVyl6yGZ3TbiW203kka7N3cf2spGoFl1eKM4Hw763tWLT6wMp3MfdNl
	SOhUJDY4m4NUjB2VEZilCRkIz320bP3EgmJQXW2XDBHtynDDeo3v0JP0VSUsGA==
X-Google-Smtp-Source: AGHT+IG4plipIHpvzaykLWrhElfDcSRNym9uzg+ZwIJNV8YkpJeuIWZU7t+CCARAg71Nf/jYOJHtcg==
X-Received: by 2002:a17:907:2da7:b0:ab7:eff8:f92e with SMTP id a640c23a62f3a-abb70d36233mr933664566b.21.1739804032840;
        Mon, 17 Feb 2025 06:53:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:fb:39c9:9a24:d181? ([2620:10d:c092:500::7:6466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376966sm890128366b.112.2025.02.17.06.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 06:53:52 -0800 (PST)
Message-ID: <cd75eafc-e20a-4c32-bd29-7ab2c5c03008@gmail.com>
Date: Mon, 17 Feb 2025 14:53:51 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/5] mm: introduce THP deferred setting
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, shuah@kernel.org
References: <20250211004054.222931-1-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250211004054.222931-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/02/2025 00:40, Nico Pache wrote:
> This series is a follow-up to [1], which adds mTHP support to khugepaged.
> mTHP khugepaged support was necessary for the global="defer" and
> mTHP="inherit" case (and others) to make sense.
> 

Hi Nico,

Thanks for the patches!

Why is mTHP khugepaged a prerequisite for THP=defer?
THP=defer applies to PMD hugepages as well, so they should be independent.




