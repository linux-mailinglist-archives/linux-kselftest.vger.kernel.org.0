Return-Path: <linux-kselftest+bounces-40526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE99B3F7FD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62D22C015F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33A62E9737;
	Tue,  2 Sep 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQHlo6vx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5142EA169
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800826; cv=none; b=b2VTB2v+v2p3kzQ0Tin/5GDdhEnJJVv6B3VrBoXmatvY1eizGOzAvS2zw6oz1jxCoSj0/aAW2OoBrxi1QLuDKRNMk/GAvqu0S9RroqnJFQqGfOkn/f5vF1jItrF3umhrGTPc2mrwigQib9ZCmWgTVTfvN4LqhWutC7aEAk+MDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800826; c=relaxed/simple;
	bh=BkM6l6APB2TFKCoFfdt9Ocj0nHtE/XpSdiMC8ZOLAsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT0KysF0XKuoInsdl8n/l7uCzkk0SRgS/XCn6zFTZnThDyym8dm4i4/RKdSv6ma1ZPeyBDzQkALtg6Dm+dbNNVi8PWyNl/w0jcxNd5gfhia76e1z+fM6X30V46kU7JihKM0gQnILypVA2JMri7ikkOOVZDAxB7+vlasBZx8r1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQHlo6vx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so379417666b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756800823; x=1757405623; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9023zF9YjRSOsUPLytfDAvNSQZrPyUAwlY34V1EiUsE=;
        b=bQHlo6vxa6HaSV16yfCGVkFWe3avbMELpiq4/PCXhaAZCp+R3GWlqPH6l8UVCGSyIE
         ksgMSBiOPFZeq9dNGws+n8K6AmtRe/RmV+kaz6ZzxLJjf6E3HZgivi2ix2QFJ9FUTXxp
         /Q/2WSVuVWaGjSjONsfmNMltHZX4ADLehEUjVrLuds3bWtsmz7IyS0pCNp/iyVX4b6m6
         tn0jr9jSefHfuZysAjtnf/IQXahVwpVerwBqZaIgRk3DrwhM/fiQg0QAmDrRjcCihdIB
         qN5SW24w8ArphLA8xMwge1a88nAQ6UmrMbuwpyr0aIbGj8RK2+FHB6zlcRXxoTStBPZp
         aTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800823; x=1757405623;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9023zF9YjRSOsUPLytfDAvNSQZrPyUAwlY34V1EiUsE=;
        b=u9SllKKUhgRkYZ6v8RUaMZbAkgrEH7yfCWVu0MurJaHifBLlXuc1gO/ZraryygUG3y
         AseRgLFk/01vMIjj7/YFBCCAacXakq8u0479zmAjL+2kIY6DzPjgcRN8rUpiKPlLCyIl
         Z2s6ZnxFpNSQvwc8xjCWjszO1z71kqLXm7b5YDut4x7YG8qClX9pDe6FahmQ6irNfLET
         TIZvRMKIFQYsdlObC7mSP/wKog3YqiqO9ic5U44fMSvBMpnza16bFMcNU2TlLg8/7SeP
         CodziLKjwvpuPyBzZIk3PB812zsCjyXBatVvY+vka/4wRVQADvw88+ALJHfl7h4CWoPw
         K4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXvJkU9Up5chryhiEcU2D7LYEKKFFKpLM/CwwUtNxcngNTG/28tkGlv5C+5Ze7m57bze+cQV48IR3eEfzOltyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxol2ZN2PoB5uH8KuKTps/19iYcQaZt3TD6qfth90BaCCzsrlIh
	yKgKdEPRNpwYuIMXRUQ7ykrylMDoRQ+tMJ/iyd4LRFHyaua+5aRPpEas
X-Gm-Gg: ASbGncuNMCYRGPnNq1KE8UAKLAjXHLLIWANrirrEmCxnD3zPnNmxB7Wks4YkHlZsh4a
	fRKQ9CBntVBZS67QRFZMDerUoYXoqL0X9hHXod7N1cWdKU1So9dYkPy2S6jT2ZOp5qxPl7zSo5I
	Qg3PeY9xQCHj4FX+zFBLA5Kxb8sOp3aXYkTStBlp0nwxu3PFWeh/2Rt5mI6cIqKOL137HsjyCjR
	AKEx9exsB73HAnE+CtlXroXgFzUOIWXk/Oj8H4i4r8/qdGg/mqrxpJqr8kg+3tZcaR8tIoCILAt
	xb4esCGB1YvAzMUsavrsrr16V/I4uvA0tZ9tnp72cePQo3DhtnH/yCp4P0IP7Q35Ec8jRgJ/PjJ
	30odEeFlMsHGJmyKr/DaDAgXgPi7wQczkNCBw
X-Google-Smtp-Source: AGHT+IHOLANPIOlqUUqaEwu94jaJxxWod+bsV1Xs0JCF3RYuGTmiVCDK4bHjkTjaBPdFyrtpJB6Q0w==
X-Received: by 2002:a17:907:5ca:b0:afe:e4d2:6d7f with SMTP id a640c23a62f3a-b01f1a0e59emr875555066b.60.1756800822806;
        Tue, 02 Sep 2025 01:13:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff032125e2sm1021634766b.77.2025.09.02.01.13.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Sep 2025 01:13:42 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:13:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Zi Yan <ziy@nvidia.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Message-ID: <20250902081342.rthx5sopowmg4hyb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
 <20250902025112.d2n3o4imeptppctd@master>
 <dd30710a-a210-44dc-93f9-1e7ddf096251@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd30710a-a210-44dc-93f9-1e7ddf096251@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Sep 02, 2025 at 09:49:48AM +0200, David Hildenbrand wrote:
>> > +	/*
>> > +	 * To challenge spitting code, we will mremap page[x] of the
>> > +	 * thp[x] into a smaller area, and trigger the split from that
>> > +	 * smaller area. This will end up replacing the PMD mappings in
>> > +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>> > +	 */

This confuse me a little. How about move "and trigger the split from that
smaller area" to the end? So that I know mremap convert to pte-mapping and
leave thp unsplit. Then we do the split.

>> > +	page_area = mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
>> > +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> > +	if (page_area == MAP_FAILED) {
>> > +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>> > +		goto out;
>> > +	}
>> > -		if (i % pagesize == 0 &&
>> > -		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
>> > -			thp_size++;
>> > +	for (i = 0; i < nr_thps; i++) {
>> > +		tmp = mremap(thp_area + pmd_pagesize * i + pagesize * i,
>> > +			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
>> > +			     page_area + pagesize * i);
>> 
>> Would this create one hole at the beginning of each 2M range and cause
>> splitting underlining THP?
>
>Yes, it will create a hole (this also happens in the old code).
>
>As the comment above it now states: "leaving the THPs unsplit"
>
>There is a check verifying that after this mremap code.
>

Thanks for clarifying. One nit to the comment above.

-- 
Wei Yang
Help you, Help me

