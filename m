Return-Path: <linux-kselftest+bounces-38662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504ACB20116
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 10:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E8816B05B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F202DAFCF;
	Mon, 11 Aug 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/FXu8xx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618E2DAFB3
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899262; cv=none; b=uwlgl/87EzBjYm9WV6XSHxj4NqNgxYzDr5mncBGdYy3XeejUWhoqTDPURauEyOms77iMyA1dYYjTHiaLRfUMCLLbbvEbFAeegenE1x0On2oxdbF7ZuW+J2ZXsesMOpJVSt8SKERXrwpiETOgHEvTeCdDny6CpZFlDmTOIVYtOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899262; c=relaxed/simple;
	bh=Q9eNESckEu410Bg9di/9QdMkVpWO75fE8dqoZFlnv+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2vXeajMzGLmxKDL2qlY9nOSutiWmjr9B1b2MPIALWarD5FnSnRoiO+bxTWcks/0E724sGEmVbRIBrils3+oiprVXhJwqCjvcKL75vTUE6UFr5toidOqh1+Sa2r4c75uW658FnfxYrtyKujglSyLRu9rgqFk2lxh47xGHKt9snA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/FXu8xx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754899259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4E6fqFxwxnXPSUUu6SboQfpiNZsJ6risTizRFtUoN3w=;
	b=i/FXu8xxu21HwHL7Mz70TzvMYoXYbHXMXRsKm1ZspkLWBf8SG0np5wRqi74YsluX/wb40G
	BT6iBzHOK2TVhctJg38PV6yT+EiS9K3qLvxzuRCvnlv0U2QhpLceQ5WYUaNU9+XGXEugeL
	S3NCFsjchtp+Me6zr1Gwa8+o4MSGijE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-iFa5seJZOmKV92kM00gvKg-1; Mon, 11 Aug 2025 04:00:58 -0400
X-MC-Unique: iFa5seJZOmKV92kM00gvKg-1
X-Mimecast-MFC-AGG-ID: iFa5seJZOmKV92kM00gvKg_1754899257
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d7da3647so34611015e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 01:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899257; x=1755504057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4E6fqFxwxnXPSUUu6SboQfpiNZsJ6risTizRFtUoN3w=;
        b=PuOWsHd2XIN1ljm47KRvpc+0ZOaB0CzO/88eBRt+9p9QMhPYrlbnUN3mCKS3ivVzYU
         nFvy5n5JyXCREYPg7cxhmAMQpV47SWWdbItbuLB35Mm43KTh6Tj2sJks3Iy6P7U/2aZP
         NEjkq2O/CtTImX+RHFWz2LX/nzQguYInPuIb6sZndKwyPgn3SAsh1PLn4/u/HgbEIAwj
         KXap77RT5xiiyYyzf88nMH/wQJUYZU/8T0DOaBXwZEjhb6mTjQzU0RvyVf1/agjI3m5P
         JjXoaDHu5jpiAiqSZI/DBgPMVcoVslQnJPpSRIl2lhfzgA0bGhVSwx8ZVombHPVfxhT+
         eEKA==
X-Forwarded-Encrypted: i=1; AJvYcCWHH++YF7CPUaYeaSgFbp4SfId68jzTxMrjqt/mMbI+Sgaq02ENrwDWXqFsIp51bfqkCcIVXcyl/XmblrjHIJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybK6pJ6lf1UlcLDvxAbexjhoWSKiictuDwBcg7VNMbRTL/hy7V
	2J6RyRu/3plAWYsl4tTrvg0KDo7WCivAR34MlrfzMI3iHiI+UMdL/Uit9HfBTYkqqlKs9mqd9s3
	AjKWUxJioTZG6EWuVg6a2ZccHvYjy78BuLmsLTBVmCYNlzhrIBvCaI9J8geMoLwRDv4MJJg==
X-Gm-Gg: ASbGnctSust6ztG6pNiR+h6D1erSp91eIEd2QmWOGvvCit9DPQ4PjcJ2FUttXBUkVMq
	i+Stpw4Kc6L983shsBeWn1BHTifgXJj0PeRVO00+RTf1LKQ+4eSka9zh9XZCgDWZkMwcjKTBvDT
	55hRbgKGLWhiuOOVHm53EuChf5OWKQAC5oPgsVXipOpdRXzxM1H39NuHE5ZFnPG9k7kWHR8gBSJ
	eNuZIB/9EWXivNQP3MRTRFGMWapZUWit5uemA0zk6uCJy5yJXj2c707kgZoUvSQbVweCu2kX7Tp
	x4I+36O7t+41x0aBnqyeygQ2YEx+XNaL80UwkgxcsX7DokkY4B0BRkVRfg0ZYCZHkT9bn7E=
X-Received: by 2002:a05:600c:4ecf:b0:458:bd2a:496f with SMTP id 5b1f17b1804b1-459f4f9b16cmr79982075e9.21.1754899257189;
        Mon, 11 Aug 2025 01:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQj4yeDpFrPoA8t+TmdmB4Y3DMZn/XonbdeVQvwP9JCoSjHYJ/apPyH5+/zG2F16hnHaUm1g==
X-Received: by 2002:a05:600c:4ecf:b0:458:bd2a:496f with SMTP id 5b1f17b1804b1-459f4f9b16cmr79981725e9.21.1754899256766;
        Mon, 11 Aug 2025 01:00:56 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a3d6.dip0.t-ipconnect.de. [87.161.163.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0cd2c90sm289685575e9.17.2025.08.11.01.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:00:56 -0700 (PDT)
Message-ID: <6eb26cac-f6a4-4739-8f45-ea26e11cdd6f@redhat.com>
Date: Mon, 11 Aug 2025 10:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: do check_huge_anon() with a number been
 passed in
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Donet Tom <donettom@linux.ibm.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>
References: <20250809194209.30484-1-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250809194209.30484-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.25 21:42, Wei Yang wrote:
> Currently it hard codes the number of hugepage to check for
> check_huge_anon(), but it would be more reasonable to do the check based
> on a number passed in.
> 
> Pass in the hugepage number and do the check based on it.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> 
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


