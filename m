Return-Path: <linux-kselftest+bounces-40530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53917B3F84B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36A33B850D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B31400E;
	Tue,  2 Sep 2025 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IThPTPjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874F3D76
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801576; cv=none; b=BKlQ0hi6L34/uTR0z04Nb+YbJPdZ9yFBJZ+K0lPEtZIGEv8YcmQT8w1yPvUrQyAfFrtK2X98K7Bv0jFiyrRDC/W6gOt6rHsL8esKr+o5z0a1MlmxeDmnBHJ8FO+38CbIGoFMBEqwqezq6po9Gi78hMAB+ZBZSNr4F6n/+D6HClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801576; c=relaxed/simple;
	bh=26TtLDJd84xYUwkKfs2Z55VgKjpuNnFnyEesi24VpMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3uLdw2hepLs4alDJarVfGeftIa625rZgnE/Bk76oYlWuUjj34QhSUZlzoIFfndpFPUT+BcIoq8eoeBNet6wacBA9U1o3UhyfmfPypQfXBQ8+iu9UqNRlwabOu3RXxULFK7vS78cbjnCou4x479jZnDCcge12wOP1nIN3J66NjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IThPTPjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756801573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NT4cL3IBvSM+KsAgVhY9PNAtIvcQOi6uIxGIHK9QqtY=;
	b=IThPTPjlwYSKsm90MeQZPiNXrOLvoRY/TfTYBNGeK39ESrZwIYQ9JaIXC4BZLZmJmO/DQy
	FNBSxBlU7/m8A3gZFU36OgeX45NvHOkEp0JYB20zA8Qf1WN7tyrqJZnLzwWQE3PmbI9jDA
	XGSMbpAEKnTIk425jPAWIgDFr9ZsBfU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-1ndTPOwTO_io4HTiHtEURg-1; Tue, 02 Sep 2025 04:26:12 -0400
X-MC-Unique: 1ndTPOwTO_io4HTiHtEURg-1
X-Mimecast-MFC-AGG-ID: 1ndTPOwTO_io4HTiHtEURg_1756801571
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b7c01a6d3so28521255e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 01:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801571; x=1757406371;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT4cL3IBvSM+KsAgVhY9PNAtIvcQOi6uIxGIHK9QqtY=;
        b=tOFEhi+IPa3Ng5W7JmbSnmeK6aY6qs2FnerW0jOKxprdKYBHXRP15X4BpHEO0/5k1h
         7mZjwWPGwkdj8TeDCqZfNzPOT4F1OsKSuc6/qzebK9tK5JJLOZUrj5t65xGOfNzmNo/4
         eyaQ4tMIX7dsKa+zhinza/wgSnkdsIK8Hk6cQ42tF5AAKfeK2hz6SD8j8hfPLxoe0nfi
         aKAu+fsp40gx7WmicvELAwLWVSVIoSjaqTbsHzCW1e4TAPYqORORDI49LV5WS+vNfFuV
         8fiCs1KsQnrFEYNqkzDbZGjVziSbD+k8ohW3YMvcuqdD0EZLezEXyaHMWwO9tIsGXrym
         J6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3nEnzQjmPCbogHrJKUmr9T33vhyi4KfrQ5NDUjhCCtHRYgzwVVYH7K+ePQsiGmIN0yAg/5y8oEQ3ZSvFWUx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHIECmFefv8HCFwy18h/qhYwFGEfx9I6Z0muYd1Za/r7OSaTB
	BqEzoBg7/FJKY5MkqMYmI7Q63Z0EwcF7px8Vz6ybYhVA1eZ1/ZC2DJcSCgkMXSv0cMsyx9HDjmC
	g1Bi8Hr8sckvfE5AmKV2ec4JKxtHHFbYtjMc2FJRUtxwZBlmdzLRYLhgFW3mbE0GtdPDcpMCCfA
	KvdA==
X-Gm-Gg: ASbGnctrgo6Xd/DC4QvqbXKTbfy+m72LLoqZzvOdn79irb+qB/Y2yb3RjAK+X4H1fCt
	XN7FR+I2hZjde7BJJQ1bT08Neq56bl8lMAgSy49UypfyQ3Hir+ysOfAzJspqDP0kLdXUfxZDcC+
	eMeGTpsUsJyJLUE2PNpxpMGttY6FqLIz+iinAk8stiy3r4Fl/LRApvxwpnzIDrYP69Agx5+9+Gw
	8DAMJFfnCA779HsO2kcZWZs2/YVRDciz+K9MqHL8AToD4koVUSgJTByOgowiE94Mq1YKYU8Tv9t
	HCxDygjhi2zyCPkgt/9XEP7/YTVk7mD+7AGrmUX1lxtvNZIvibQHIJJDRlC6daQgORZ5DLGLqbW
	ppLnq+EyhK37IUG5TYDLzqinfqim3d1X0J12i4tw0HVgusAq4R0KZPX0bKxQ6Y4Uxww4=
X-Received: by 2002:a05:600c:5303:b0:45b:86ee:415f with SMTP id 5b1f17b1804b1-45b86ee43ebmr82879635e9.6.1756801571123;
        Tue, 02 Sep 2025 01:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM1cxF4JIXl8kNx81ZZuv9bKqY/543YOwc/dJB5l0AuAAHxnmf034l5+/Y8FWgJjfldXBlOQ==
X-Received: by 2002:a05:600c:5303:b0:45b:86ee:415f with SMTP id 5b1f17b1804b1-45b86ee43ebmr82879405e9.6.1756801570675;
        Tue, 02 Sep 2025 01:26:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm259793375e9.23.2025.09.02.01.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:26:10 -0700 (PDT)
Message-ID: <0c163e18-3684-4b1a-b379-be82fdc288fd@redhat.com>
Date: Tue, 2 Sep 2025 10:26:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
 <20250902081632.mopnwlt3stpijejj@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902081632.mopnwlt3stpijejj@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 10:16, Wei Yang wrote:
> On Mon, Sep 01, 2025 at 09:10:57PM +0200, David Hildenbrand wrote:
> [...]
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 10ae65ea032f6..aa0f0502efa06 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -390,67 +390,88 @@ static void split_pmd_thp_to_order(int order)
>> static void split_pte_mapped_thp(void)
>> {
>> -	char *one_page, *pte_mapped, *pte_mapped2;
>> -	size_t len = 4 * pmd_pagesize;
>> -	uint64_t thp_size;
>> +	const size_t nr_thps = 4;
>> +	const size_t thp_area_size = nr_thps * pmd_pagesize;
>> +	const size_t page_area_size = nr_thps * pagesize;
>> +	char *thp_area, *page_area = NULL, *tmp;
>> 	size_t i;
>> -	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>> +	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
>> 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> -	if (one_page == MAP_FAILED)
>> -		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>> +	if (thp_area == MAP_FAILED) {
>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>> +		goto out;
>> +	}
>> -	madvise(one_page, len, MADV_HUGEPAGE);
>> +	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
>> -	for (i = 0; i < len; i++)
>> -		one_page[i] = (char)i;
>> +	for (i = 0; i < thp_area_size; i++)
>> +		thp_area[i] = (char)i;
>> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
>> -		ksft_exit_fail_msg("No THP is allocated\n");
>> +	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
>> +		ksft_test_result_skip("Not all THPs allocated\n");
> 
> Not sure why we skip here?

We usually don't want tests to fail simply because our memory is fragmented.

If I'm going to send this I'll comment on all changes in the patch 
description.

[...]

>> +
>> +	/* Split failed? */
>> +	for (i = 0; i < nr_thps; i++) {
>> +		if (is_backed_by_folio(&page_area[i], 0, pagemap_fd, kpageflags_fd))
> 
> I guess we want to check (page_area + i * pagesize) here?

yes!

-- 
Cheers

David / dhildenb


