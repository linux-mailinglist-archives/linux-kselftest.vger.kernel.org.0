Return-Path: <linux-kselftest+bounces-40840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADE5B45963
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE86A7A6F74
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55415350D56;
	Fri,  5 Sep 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnbQ+Nhz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128B263F2D
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079799; cv=none; b=VEn1X/RrQz/+mxj9CgckSZQlWFj7E0jd3662TnCsBOoHyINouAMrxxNIT9+xofY292ar8/y4X+thcfZXqVEFhZqOe2D1jrYZY/duZX6yoTiT9pahkboDIae1LgFRXbtFwpDOVtXO5D2mOhGmB/Un4KC1sDJwMe3LpmWyHFwYL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079799; c=relaxed/simple;
	bh=2AXQcgsNMS54+TY12tectkJ7slyxwSHfNUu724UuJCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXdHAJHM5q46RSKurwaMh4ItSOkK4mhk2xggyPOBfwojLPhA4CsboAJRNkpPHVsj8d8OJEq0u6lOZexNsq8LHjdVAFBNwFsbr40QWAVAZDO2nsXAez1rf0EOWF1khVdWU+ertcVn0okzkLVTUy7BMxXgGprzkLHvip3zA4Cs6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnbQ+Nhz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so5924636a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757079796; x=1757684596; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juZ+7zdFswSCV5MJ/mR3oqW01fzlnWz0KXmck3Yb0Yk=;
        b=BnbQ+NhzEhPCGSFDbXUbpX6LvL+0sFEQqpyZz/kpmVgR1pITeGPkFrWJwD53xcgeke
         7Os9SjTbfp5gkHHaH1dwKh7j55p7ujwUD+3MmsKx/fXGH2x9FBPbiKar1E66mA294IKU
         r/tjU7BjZBCFepG9GiyS8p6OoLb1zIEt0ByUZ9FlkNgrHwaTF/UAb1mTcl5py8JGZ1SO
         5K7rHauEKaX5lwAb+9p2+IeiKB8OOxACHBCBfcBRAMbRHXTZXhQyhLlZmuSSmKXfwacm
         9PXzHDs2bqb/xaKY8XRqowTkCwnZydBZBLZH1wxjryJdUcUegQ/NmFFaDbyVS7cxn9NB
         3kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079796; x=1757684596;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juZ+7zdFswSCV5MJ/mR3oqW01fzlnWz0KXmck3Yb0Yk=;
        b=cIyXOQiqPTYOPmWTd2B+zbyFdJgJNtlMY0OIDnQRBq6FEYwy0lqCmTfrSv6IhrdZop
         ciOW7W0sKXjkl3GRdI1lWcWNKJi/w/mW58HgUcw/NjEyPM4aGWQDghPZjcMeDFMBUhfS
         VcHZOuksW5mKTmobbLdmMj1ibvMMPZKcCidi5fqNqDp/UI4CxOFjE6mBUyvRRCxkbRMb
         xoKLVe4cwMRIA3jfIO23EPCH+mkzSbGvx1dt2JtcpIoM/kom9RpQoqCzOFzIfS4vmB77
         5fWqIRLqNSCQnEBReSTWHIp5COD1KxhTOXw7IMUh4Prkc9lVBxt/j1dc/LLR0t3F8Wfh
         ds1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzToK65NZYV5NL6U+z89FcvOMUGImPgSuzUKtGuZu+DiZXhfodYVoD1jdS+kZSqKp3z9js84QL9zz51ND5qH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUDXoqNSR0CGnspuboK+MFCZfEbDGjoBVb81R6CNlvt7umMBd
	pED+Ltr4sHhNey0fAiniJq4tRiMMhXctMlsbc348uOANuEjLKnqdYOnN6VxdEw==
X-Gm-Gg: ASbGncsuUVigq17f+bQngW8V2BGKg7FSUCjjTM7OXSA7qqASof1+NKeb6tN8n/9idtZ
	D5aG8N1P37UeD8tmMzy1WXvz4N9xTiYfO3853ExhUuvGDhr/FU0l1W/dcy2WO9X1kybgtwU7VOg
	sTnb5i7yPCCfIRyTMnF6RPawMhGD5kBiahRykQ8p0cnnGEGnmak0uQVXNqRigTN6k+NRj2LpPYb
	as/Gm5RgjvkPpeUMlnWvtGT6hfLtBG5qEXXPX+hK7S7TDz5acyUg0veHNJnL22Lmf/hok2vFOK1
	ZLL4KCiR1HPS42rcsuw+CeVRL7shJmnrS7VJ4i0/jtl82WfT2b5sMrXi+dd5jNSOh4WkYLw9lwB
	dSPnhVg8FNYsVefFC/mrwr30GyaRS87OtWGtD
X-Google-Smtp-Source: AGHT+IE5JMyQqUwpkPg8CFFCWJMeKbw0x/igK+7eH4dTNlZp1hUIn7oWePKMUt4WxHLfW/MktPRWMw==
X-Received: by 2002:a17:906:3457:b0:b04:2c2e:50a5 with SMTP id a640c23a62f3a-b04930fcdf3mr340136366b.16.1757079795706;
        Fri, 05 Sep 2025 06:43:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0438102debsm1132302466b.66.2025.09.05.06.43.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Sep 2025 06:43:15 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:43:14 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: wang lian <lianux.mm@gmail.com>
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com, david@redhat.com,
	donettom@linux.ibm.com, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, ryan.roberts@arm.com, ziy@nvidia.com
Subject: Re: [PATCH] selftests/mm: refactore split_huge_page_test with
 kselftest_harness
Message-ID: <20250905134314.vtc4qspuyfjp4oah@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250905032431.22179-1-richard.weiyang@gmail.com>
 <20250905091029.81259-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905091029.81259-1-lianux.mm@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Sep 05, 2025 at 05:10:29PM +0800, wang lian wrote:
>
>> Refactor split_huge_page_test with kselftest_harness, since there is a
>> magic counting about valid tests.
>
>> The idea is simple:
>
>> For standalone test, put it into TEST().
>
>> For tests iterating order/offset, define fixture and variant with
>> order and offset. And skip it if order/offset is not valid.
>
>> No functional change is expected.
>
>Sounds good.
>
>> -static void split_pmd_zero_pages(void)
>> +TEST(split_pmd_zero_pages)
>> {
>>  	char *one_page;
>> 	int nr_hpages = 4;
>> 	size_t len = nr_hpages * pmd_pagesize;
>
>nr_hpages and len appeared many times and 
>david use nr_thps and thp_area_size rename it.
>and maybe we can unify it and make it into FIXTURE and init.
> 

Thanks for your suggestion.

Let's see whether this refactor is reasonable first.

The first step is try to preserve the logic to make sure there is not
functional change. After this, we can have this refine in a separate
patch.

>> +	prepare_proc_fd();
>> +
>>  	one_page = allocate_zero_filled_hugepage(len);
>>  	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
>> -	ksft_test_result_pass("Split zero filled huge pages successful\n");
>>  	free(one_page);
>> +
>> +	cleanup_proc_fd();
>>  }
> 
>
>
>Best regards,
>wang lian

-- 
Wei Yang
Help you, Help me

