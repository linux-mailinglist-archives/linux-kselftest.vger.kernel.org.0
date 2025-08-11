Return-Path: <linux-kselftest+bounces-38716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD47B21757
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717103B0636
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23F2E2F17;
	Mon, 11 Aug 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1VqiMs9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B02E2DCB;
	Mon, 11 Aug 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947687; cv=none; b=V6RT8zrnDegoKkTteiiUudmYjLDiGlHbhtdYXYuND2yHwQ65i/yyh/6g6puUusPFlqfjALfnAe12LrFFHLd/nIWwUdn2VgqsaBae9aeCOeHebv2yznWRpAKCrjvPcHOeS5UlOP+w1VRG69rzcj2lR/Gwk515D5s1Nnp0cb0ktg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947687; c=relaxed/simple;
	bh=4jWt+vtaMp5Tdm13CVmodDS1jsKe4d7LMcQKGSs1wIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpKyYHElZRWJZP1ADolAWhuNLTx5ngsfyl7vpxkiUAPqoPq27txRwNihnWmXz6CYb7rD8b0EHFaUifLl+feIBgiiJP/xHUjE3kiD8pJ7T+chQt33sH7VQ02LxbsYedjbZQg2wIr27dAAIVrGMUv38RPOschYw828Qp390Mf6v3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1VqiMs9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso7590881a12.0;
        Mon, 11 Aug 2025 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754947683; x=1755552483; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7emz6ROM15eXVZD/JHmzk6WH3TEb4rlVhorWWEnTJU=;
        b=V1VqiMs9rhral5NZfF/f6XNs28RuDZ+nbWmhXEpfmCq4/VKYJ4Xx6Gyk8bR6CMOSTt
         +9OmWjgPrPwFWa6oja8i5wGMOyITalG0qi3ZPq2dopizSjrvV4QLVuE+M/MxXTsWI8Gi
         2uvqTaYEnS+p12w61/u770wtNaODINSRy1EIQ9UirlQhUh18P1q1QX50w+9ZJBld0yC6
         eH/xXSkvPnno0n5q4nQuTveDbum2ommpyJxw/KFQoiaaJCrMb13tE7NeC/AZAoWzt8P3
         MKkBkHoDymW8ECyRevR1S9z2cD0kFjltc6GOAJDe2kWCqBIWRonq7wwvhejXpXV5lKEf
         Rl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947683; x=1755552483;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u7emz6ROM15eXVZD/JHmzk6WH3TEb4rlVhorWWEnTJU=;
        b=le1VXJUeEWwQowV5D9Beo1qdi6F7gxvRqpbaUP3ssdwhMpKf0SXzJbmITPQPT1wzk8
         JxMwJaRRxNCO5SxH2pHHgK7hdjo0B9KIkF3hDuf7nyxinQQvVo8d9040Jxb4pweV+qMs
         VB/OB6n3W8LhTirdTigdSY2Yi7zaP9NJplzvmoaR5Yj60L5O/s1PRR0PvpTO+QgKlTUF
         ibPMH8DYG0DKOWbCKUG9AotjjH90rmOyHbiM/jLQAHHa6FyLKU56TRlemN4Sd/yU06eA
         ifIQqirCto0AGTmUNzZfLgBOF31c+6/mUGKS+ojapvIDUeQFQinY9PUGpqk6GyLB9omg
         o+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVO3fcpA7FY7EyZm6pUrdFPMyx6Zh2hOTT4e0xU7iggI2IqCWmowJN0bNd+xa4vSXxlAVBi78cCqT3hqsk=@vger.kernel.org, AJvYcCXF0qNwReIj76Mb4lWzYaTquv6FLl9Z3p4lU+S2f4iSq/oLyKHltwv8fbZf47HUHnthjjNPPlAArXM5ogPTc+rJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/ykWtJC5IfiDz/nEfBeNDLvY2JEt2Rv19X3B+TVx0/NaRyoh
	pHrgLzKWTjcrQls8aX4FH68uW50IB0hIkUsmfisLpqE1pkj+Y34VilQ6uS+eW5Fb
X-Gm-Gg: ASbGnctQySX8+nuGk4bdLMDQEzodC8mZ0TdVXkUPEftf7a3OlqykXGjOFJY5hTSetLM
	ZuYZ0cHCyDVbe+cqGKbC68A4lL5kp3rpEWMlksBxdEAQhOppueiylrA9HJ67PP3gdB0GfHI6dkl
	JGH+t5y7GQmOSe2K96pQ4yD6Q+isM/kBWPqiHtZWPg+/37H5XxcqqQf8V7I1sWLvVCvbkmj8aSL
	wCBpXcNkFHmDcjJjH/iTaGaRfjs5fR+JUxAieg20KP0k7pYRWBhUjkO5Vx+yRggztlel5X7mJnS
	VaNrxDuBylSdd3Yo22Dq+TLj0fKxi8JeMFHbrpBT3X9n4jA0DjkRDitkNpQhS9sU4hD9Jh3RztO
	8md9aSMlN4xJOMxZyA9gRZw==
X-Google-Smtp-Source: AGHT+IEJ09ZPMSOGoqTX4r3ubN8xEk05FcZvRutxM05qzde970yiia9Wthp2LHeb/ElEnlKIxxnWBw==
X-Received: by 2002:a17:906:f5a5:b0:ae3:f903:e41 with SMTP id a640c23a62f3a-afa1e152edamr90815566b.54.1754947682935;
        Mon, 11 Aug 2025 14:28:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3792sm2073582166b.50.2025.08.11.14.28.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Aug 2025 14:28:02 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:28:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftests/mm: add check_folio_orders() helper.
Message-ID: <20250811212802.gsvbeqmo62v4tqly@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-3-ziy@nvidia.com>
 <20250809201836.jegaanplfcjak44f@master>
 <B13F65A9-B001-4494-A060-23D95055553F@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B13F65A9-B001-4494-A060-23D95055553F@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Aug 11, 2025 at 02:39:08PM -0400, Zi Yan wrote:
[...]
>>> +static int gather_folio_orders(char *vaddr_start, size_t len,
>>> +			       int pagemap_file, int kpageflags_file,
>>> +			       int orders[], int nr_orders)
>>> +{
>>> +	uint64_t page_flags = 0;
>>> +	int cur_order = -1;
>>> +	char *vaddr;
>>> +
>>> +	if (!pagemap_file || !kpageflags_file)
>>> +		return -1;
>>> +	if (nr_orders <= 0)
>>> +		return -1;
>>> +
>>> +	for (vaddr = vaddr_start; vaddr < vaddr_start + len; ) {
>>> +		char *next_folio_vaddr;
>>> +		int status;
>>> +
>>> +		if (get_page_flags(vaddr, pagemap_file, kpageflags_file, &page_flags))
>>> +			return -1;
>>> +
>>> +		/* all order-0 pages with possible false postive (non folio) */
>>> +		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>>> +			orders[0]++;
>>> +			vaddr += psize();
>>> +			continue;
>>> +		}
>>> +
>>> +		/* skip non thp compound pages */
>>> +		if (!(page_flags & KPF_THP)) {
>>> +			vaddr += psize();
>>> +			continue;
>>> +		}
>>> +
>>> +		/* vpn points to part of a THP at this point */
>>> +		if (page_flags & KPF_COMPOUND_HEAD)
>>> +			cur_order = 1;
>>> +		else {
>>> +			/* not a head nor a tail in a THP? */
>>> +			if (!(page_flags & KPF_COMPOUND_TAIL))
>>> +				return -1;
>>> +			continue;
>>> +		}
>>> +
>>> +		next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
>>> +
>>> +		if (next_folio_vaddr >= vaddr_start + len)
>>> +			break;
>>
>> Would we skip order 1 folio at the last position?
>>
>> For example, vaddr_start is 0x2000, len is 0x2000 and the folio at vaddr_start
>> is an order 1 folio, whose size is exactly 0x2000.
>>
>> Then we will get next_folio_vaddr == vaddr_start + len.
>>
>> Could that happen?
>
>No. After the loop, there is code checking cur_order and updating orders[].
>

Oh, I missed this.

-- 
Wei Yang
Help you, Help me

