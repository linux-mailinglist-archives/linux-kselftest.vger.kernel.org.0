Return-Path: <linux-kselftest+bounces-46887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33207C9BF97
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C88124E2B8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526DC258EF6;
	Tue,  2 Dec 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmXLQLqR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXNttpwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5B224AE0
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689776; cv=none; b=EpyioMJ3wPqzk74PXdvH0YOzl+1cZ64TKN5HczkpL7zMlnxto0iaiJ5lHnoq4qm8x9Hl1cxWxpsOxXrwzfYbljYyZ6/OHuGyhOPE21DU8X2+ggkPtI5/BnT7uRJ0Az2i1K+yOnKWmMuZ+Zv8KfLG+s4GneK4IrcuKW1BDW05cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689776; c=relaxed/simple;
	bh=i3C3bUlfDJDSJz+UEgqncbzEDCMJ04lynUCqoI5h7Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aakAkqTmNvl1KeiGFZINH6qhucoUdyXFCyq0cM58TYzKHT1THa7Ak52SpZwRKbcD9tREs1OjJh2uzu9mc63NyTQU88N/WChddgLMgxv2lMFUbSwilHm82zUWlSIwea/eM60fBq5LAGJ1K0fFmHujVIpO3ja22RuEin5M+Ilzwd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmXLQLqR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXNttpwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764689773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YeUhnIQnNrHzJpcHAzDpdS8MH/0dybZ954xw+b5apLM=;
	b=cmXLQLqRunxvZ9AwHsDVH20Hxu178oczWcKHt6kSJyZQ/DSNgd3oCCNaTDpujmFnT/6DQs
	bv3d0Mv1VADXHDx8F6BxfAhjnUuVBhHocNeIDdAiC6FlTxdQY/4LNyykGrxRHG8WoxvWXV
	QIsn5YYc03RdCnU/QBCIUcmK7yopmIE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-QgYy_5-XOpeFYvT-KEMEaQ-1; Tue, 02 Dec 2025 10:36:12 -0500
X-MC-Unique: QgYy_5-XOpeFYvT-KEMEaQ-1
X-Mimecast-MFC-AGG-ID: QgYy_5-XOpeFYvT-KEMEaQ_1764689772
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b26bc4984bso723297685a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764689772; x=1765294572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeUhnIQnNrHzJpcHAzDpdS8MH/0dybZ954xw+b5apLM=;
        b=bXNttpwic51dPVpgUGsg7JohE924HeWKXleYn93pdrvXRmKPqZdN4GD9mAqOaCnKpX
         8O149A6cFJgWkIjk/uPvps0ThD5WUMIFN3C8EiZFaZhI4NXODZQVhZoKD+bmJ/PEWYIS
         v9JIW+BVBcUZJSlpu34opG+lrww3TJEqIuOm48Us9Eb0jMWXJ201jT3LduSIVQZbtVYT
         B4flYcAvSqaRq+MZNQqh9apOl8MhiV9dpGoedSqJwDUf/zJ2oN+8hR2MVXVf8f+zfQOV
         aMpNTx1GZeJShYby59mb99irnAkxXpfHXzsyeCQORx4RGkBBWNCGoKSeA4AWZcTYjnRa
         zv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689772; x=1765294572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeUhnIQnNrHzJpcHAzDpdS8MH/0dybZ954xw+b5apLM=;
        b=wVSf89RJ0dwJ0SC+VF6ANj6XNq7zv7Cmx6gOqoXmTDjU+uOqaUR6UljUTGr/C+AcLW
         tisyJv8D2mtvCd7c5Wbbjdy5oweVt8us4CcpJZtYl3dLhkwAX0aqN9y4mMa0NGwvv+k4
         P0+u0JUmgS49oLf2L03gzmIIapdJKqgWVDcm9H7NB/OKtCBD53NyBvOXJB1h14XeBtGD
         4L6CqABgiUd8EjQzOIxOjjSZOG6eVXm6gTCX1gLk4xVftv1B0RhOkEySV1gPlotSBvgN
         WBqN1YVq8AFnJ30CDlojZuMYQzDxbXrBGwdQfzEZQEqpizTKLQztPWxjFkM0uU++P8nI
         v4rw==
X-Forwarded-Encrypted: i=1; AJvYcCVQP4olijRWcnk1qvd1t8EgHXqJ9uqKaRMZw9WS/WbfqrYDQUMexP86g9J+mrd0U074Jz3yKg/IbK4VLJ1Ycjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywglq22b9FG5BsGPyvkGQFMggpnhyiD1kjByFU8Xjghih0E0H42
	DW8+ul3bHXeWhBwcFqY5WzLODNwbkjkJizDeqntVFxgsF52bOc1wEnBPhl9dkyEPpEX3R9S4riA
	Zdj1y4fmrpDYPTKR1T8bfYVMmobHd3cFYnPzPfysKaaTYEzaPWAaMyTI/k/tyKtNrV/VIGg==
X-Gm-Gg: ASbGnctcA386M+3AqiunmdeHDjglVLj8wi7U9XXCZpJh/6NoqqGPMWBft7LYWCZWULq
	WjAA4IeoBu+PzA2YJB7yq9md+q//3qRc9pn2+glzGWygd2qHdmKFvY/UXxcwiQeML0nXiZ/OfEL
	72rSvtcGU2r22LJit3mO9EQ0HDUUSYNW4Vj5lm+fzLT2PWnXP5ak795aoxvLvZvEOpeS0S+3/up
	svLaKYBEOqfG9jYOe7S3R2U1puBbc332YhV+XBEVqHiIBcIbzEFsATzMn65XtcnS6NK8OmX+q42
	3/4x0+Ph+uPtfXmeHm9j3wmZ42sNiSBLRqNy1as7dIfrf0a12gqNAK3VAUJivhslF5WWPdrjl3S
	jkvA=
X-Received: by 2002:ac8:5a49:0:b0:4ee:41b2:91a6 with SMTP id d75a77b69052e-4ee58b066b0mr583360501cf.82.1764689771711;
        Tue, 02 Dec 2025 07:36:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLXfWGfXaBCM5txXHiaHxg/MnHqIkbYXvhInhcx15cakUIHeqTAWdqvhhC3SSFQ3wIt4nqmQ==
X-Received: by 2002:ac8:5a49:0:b0:4ee:41b2:91a6 with SMTP id d75a77b69052e-4ee58b066b0mr583359971cf.82.1764689771231;
        Tue, 02 Dec 2025 07:36:11 -0800 (PST)
Received: from x1.local ([142.188.210.156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2edcebcsm95292531cf.0.2025.12.02.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:36:10 -0800 (PST)
Date: Tue, 2 Dec 2025 10:36:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
Message-ID: <aS8HaDX5Pg9h_nkl@x1.local>
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
 <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
 <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
 <553c64e8-d224-4764-9057-84289257cac9@amazon.com>
 <aS3f_PlxWLb-6NmR@x1.local>
 <76e3d5bf-df73-4293-84f6-0d6ddabd0fd7@amazon.com>
 <aS4BVC42JiUT51rS@x1.local>
 <415a5956-1dec-4f10-be36-85f6d4d8f4b4@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <415a5956-1dec-4f10-be36-85f6d4d8f4b4@amazon.com>

On Tue, Dec 02, 2025 at 11:50:31AM +0000, Nikita Kalyazin wrote:
> > It looks fine indeed, but it looks slightly weird then, as you'll have two
> > ways to populate the page cache.  Logically here atomicity is indeed not
> > needed when you trap both MISSING + MINOR.
> 
> I reran the test based on the UFFDIO_COPY prototype I had using your series
> [2], and UFFDIO_COPY is slower than write() to populate 512 MiB: 237 vs 202
> ms (+17%).  Even though UFFDIO_COPY alone is functionally sufficient, I
> would prefer to have an option to use write() where possible and only
> falling back to UFFDIO_COPY for userspace faults to have better performance.

Yes, write() should be fine.

Especially to gmem, I guess write() support is needed when VMAs cannot be
mapped at all in strict CoCo context, so it needs to be available one way
or another.

IIUC it's because UFFDIO_COPY (or memcpy(), I recall you used to test that
instead) will involve pgtable operations.  So I wonder if the VMA mapping
the gmem will still be accessed at some point later (either private->share
convertable ones for device DMAs for CoCo, or fully shared non-CoCo use
case), then the pgtable overhead will happen later for a write()-styled
fault resolution.

From that POV, above number makes sense.

Thanks for the extra testing results.

> 
> [2]
> https://lore.kernel.org/all/7666ee96-6f09-4dc1-8cb2-002a2d2a29cf@amazon.com

-- 
Peter Xu


