Return-Path: <linux-kselftest+bounces-39284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29FB2BAA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197FD625994
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B02765CC;
	Tue, 19 Aug 2025 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O72OcNTl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D8233D7B
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588363; cv=none; b=f5/vvMDyxOG6WiFUDL3uG3xIPJHuIczFevNDEjg9hMZXFoisr0NXHz6aZgVA5V2ikcfCNToGQ31VemHN90s2F6l/jmv5gMuvENXKGLALpcen/uva861Kz8Nq94/RSt+Vh0c36R8r4luqtBpyaPhwY5ZCtbe3hA+b/DAK/xwBmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588363; c=relaxed/simple;
	bh=irusahjcgH1FkJMVRqGEPpFm2OpYlwPirZD/QqGE2L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS7e/ZI2S3f25NZq0/UN5xvcFusv4w1wFWNJIUFriRgKm5SEvqw7vvI0MwjfaxjaNxo+G1Beplav/I1/3TxiNj1ACt6XgqlDudQe6BynyGzBYvGOPEQsDOdyFJl0wlS3USPrdO5NJzhoIi4zCeDaH1XLHcLXlihHj72iysBkRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O72OcNTl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755588360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jHfqlcSubeJn7/W38DDDWlN7ObnUVNPyWAs05D4g68c=;
	b=O72OcNTlKH3qHTqSxMJekNWw0PKjRV9e2qra9YFZLhNTFe2t580xmvWA5y8QsJy04V8SKX
	qEh6hXgs1ab89KnBuv5g5jdj1MIUqs6kNrcuv3PPfbBuWj/rqgFwOL5G7EpYrV/2ht2Mhs
	EacQTZ+MqV+qzxFDWj6ADrOeka5Q8Vw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-VaC4edlHPsqnOiM1vn8fOw-1; Tue, 19 Aug 2025 03:25:57 -0400
X-MC-Unique: VaC4edlHPsqnOiM1vn8fOw-1
X-Mimecast-MFC-AGG-ID: VaC4edlHPsqnOiM1vn8fOw_1755588357
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so21310785e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588357; x=1756193157;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHfqlcSubeJn7/W38DDDWlN7ObnUVNPyWAs05D4g68c=;
        b=sdioZs9fEMP3sPD3K8+I2EpexsOTBLuMiBrmhKyekoeaGlkt6f7hUqNXdKr57ky21O
         HsXBxgV3nRPOFM0qHY8yQfWctES22+BnFy1txrm8hwxniS4x2EAWvS88UPLIW51zTkhX
         +Ju9ss9a3Go7UqtvpLdjYHxfrxGRejq84+4psOA3jvaP2woAvGksde01danzzxgS/sxb
         ee+5SKiVHisMCS5ze78BAJIA0TUJJT1DZACDiLuP+ATxRt42Op98vlBtNaQgFLAjtNZp
         lAvbxjJDB2inc2qpr8r22Pv24RDLWazyB3YmDQo6RK1+rrtd3L61EU6lSXHUCN9S/FGJ
         kq1A==
X-Forwarded-Encrypted: i=1; AJvYcCXS1IgRe4Tmo9H1fVX73MC8aWLBu7HdvTFwdu+MZo7djME6HOWiHuaiVx2kxeYgQOEpCR5IzNL24wfVA69/mqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMci4Qd3nEhbpcvV9F60Iio5iZ03OsZnb1IXPe5OtSCHB7GBo
	uBTEvNYAXCaNna06BZJbmYPdwhp64KtRKIOPOW5FmDyDCUv+FOCorsC5IJqLDqE7j8X10pFS8gs
	I8BeUA8Rvhp0iQeaou1yth+0pv+5YFMus1RlxcmHfuyypr0c0y3yKSA/aHWyGTfOwl+qFHg==
X-Gm-Gg: ASbGncttxPmX1vQBAWqWVxlU9UYpDYu3rp+8trkx5fIWGxc1rgkWbaM5e/j4ikB/bwI
	xxNOWtVyMfph7L8v1NEmc0JkR67WAKloX+Gmv54OI5m4cj9BEg6VOKDxvw/G9zVFyfESyBE6bqH
	WGHifYkxjy9YY54J8MXmyXZp/B6ZW2OLfLxvmm+ysHuIl4IqDnRNLAGIYpFHgSYdMvxNoVA/uGK
	UhfHmCQRQy6byhj1/ttIDVIHbUh8mtENyWJ5Daiy5s7n8x4U5NdEo/Rk6AkNQ5rMULjK+pevW8b
	1EgKJkBtXqzzCL/8qyVoqzdNYibxt4lHWUxHG7Kz1CFTwcmXfxuFpHGkVocr8rGyEYxuDsufOCN
	hkXw945vQUU6owMGevNy65JTfwe8uXmFRDjVS33QSgx8inBJDduaIUd7YgXoUAniNMMA=
X-Received: by 2002:a05:600c:358f:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-45b43f77da0mr10625455e9.7.1755588356733;
        Tue, 19 Aug 2025 00:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiCUhqGQNn0Jp/QYUQ0I6wiZbOyiVGMzK7ZWG8eNWkfWyIP3UZUKCKLtKKgTXe7raIvIZrIQ==
X-Received: by 2002:a05:600c:358f:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-45b43f77da0mr10625195e9.7.1755588356252;
        Tue, 19 Aug 2025 00:25:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a24e5562csm146699305e9.20.2025.08.19.00.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:25:55 -0700 (PDT)
Message-ID: <8142d36d-2a0e-476c-8250-1a69c1f92913@redhat.com>
Date: Tue, 19 Aug 2025 09:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Fixup PATCH] mm/selftests: Fix formattig in split_huge_page_test
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250816040113.760010-5-aboorvad@linux.ibm.com>
 <20250819041239.167537-1-aboorvad@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250819041239.167537-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 06:12, Aboorva Devarajan wrote:
> Removed an extra space in split_huge_page_test that was introduced
> by commit 4b76e221794b ("mm/selftests: fix split_huge_page_test
> failure on systems with 64KB page size").
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 54e86f00aabc..faf7e1f88743 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -544,7 +544,7 @@ int main(int argc, char **argv)
>   		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>   
>   	nr_pages = pmd_pagesize / pagesize;
> -	max_order =  sz2ord(pmd_pagesize, pagesize);
> +	max_order = sz2ord(pmd_pagesize, pagesize);
>   	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
>   	ksft_set_plan(tests);
>   

Please just comment next time one the respective patch as review comment.

-- 
Cheers

David / dhildenb


