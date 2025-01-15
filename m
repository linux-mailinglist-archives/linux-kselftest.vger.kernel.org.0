Return-Path: <linux-kselftest+bounces-24587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B5A129AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D493A77AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4096C18C939;
	Wed, 15 Jan 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hccsjDLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B7181334
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961687; cv=none; b=cGgrXQKucC9g/lQa0biskO3J8ggFxLLwE0b4HWdzAEHR6aFkMHmqBGy43fyQ/IgAa8ocQ1b6TQsf1w/jvMBJ2GI/CuveNIji8hALZp9/Au1xmSYBzFiPPcYgKhWpdgZTQwv2RhJkFEGIOq6l24dWa3J7prvPFG0+vRILHxoBguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961687; c=relaxed/simple;
	bh=qv8K6P+rJ3N3NWZzO4UOpR58BJ5OlP70iiFx0t6OsTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO0iU7WJ2AeHVgB8l3dyjIMqgb3UOSuyxdcpc57H5eMKPpljkBowadcV8jv3fzUs8EAqqrjcElKpV4a5/kzCo35b+OE1O58MrH0r9HipfEZod22B5EuWwLGfyJ+odL2eeCUzi1CMDwbBtGkyDorIrtQ+qhDrhiNp1qtv8lPs1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hccsjDLT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736961684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n7fD6FZnMW/OK3LA1vYZfY+rnhacvCh2TilJm5lNlJg=;
	b=hccsjDLTmRjg3mGKUiuFmwXeUMZ7LMZhgSf59fjolI46cvyTMjcUhcNMZStrzpeWBg3bOu
	aQfzg8/EXrup1oP5hsJ/wbSCr4XRmsSO5qmXRId2b7VSYT/dTqgbiV1B+GQQMtgoYe9p3t
	zXV7IlH9w0MFkRNRkH5IZmIGHaNoYb4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-xHh68VnCMS25TkJqjXHprQ-1; Wed, 15 Jan 2025 12:21:22 -0500
X-MC-Unique: xHh68VnCMS25TkJqjXHprQ-1
X-Mimecast-MFC-AGG-ID: xHh68VnCMS25TkJqjXHprQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so104554a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 09:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736961682; x=1737566482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7fD6FZnMW/OK3LA1vYZfY+rnhacvCh2TilJm5lNlJg=;
        b=bcSrUA5CBCngyP4NtYKF+iHj7na42NexDb3tXjuvZ3k6gfuosYZtxBXi0V/5yp2aFG
         hOJxCBjyS1TDmmzG9oSnwX/d4gzS2TkAbZXp65tmT4ypxe7GHJgdodHRc4sss8GB9MOf
         oKekOqGMBvzil+iiEDvGujXYyQL/PpE6YUMBQaFVBjSHI25qLxF782bKavcvUww0DiOE
         gxYnbb/MXdCcagfWl+D3BeQLkJ4mdHYSFMchDSz18NpHiP1cMz+OCU08xbR7C7A92A3J
         nYOS3obzZFY+2lJCNQ/d71vfIMMn1NDHxowoqxl5a8mMglXolNBlx01hjdZf4AK3ZCHh
         7VFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6r3829zYZ/GhT2Yeok9/6Z95ydDjDvGZl4D7mYDLpnt7SySW00F3g1EWIHqr5hUq2akUUkHhwI1ZFmq5Z+Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiyboo8svRhL4xiZFCKoJQviieYDP8Cl+QOIbvSjr4mrnjEG3
	Yw3fnAjhz6o8njjRPspFrL+2shOoVRWFZgyr2p8auDdSBQ5+f9xqJTk/J3mWi+zw70gcZ5CqNI3
	iKAV46S8cgrq/xwhSkKu9KdjFEIxXmj2HdaaX9kLOIYUrmYlh5N++5TuQMGf2eax0kw==
X-Gm-Gg: ASbGncv10Lq2o3WA6GDqHKFlKs6M9rDHm5WJeR44ounlHaHoaGgbAIptp+FWlca5MsF
	yb8cvtFZP4DA/zWwSAnSQ2plDSYUDl+yqO/uAnmxxCQvaACUyWBaK0tlgnDS/zH0kNzE3l8HPK3
	dTJJEbUivIYBHKb6ltxfxRKqCL6yXuXG5mEpKbkdAFqR00fhQR82QUBQM48dZfxjddqpXj2RuoN
	YIrnl9v+cVnfigK5PnvveR0aMjk4puvsAYXkiJ6aJsf1YhZ9Hg1CSU//KUqmpZOsVwhc3LnYwWH
	boDDzHntxZq/nPNRVQ==
X-Received: by 2002:a05:6a00:914b:b0:72d:35ed:214b with SMTP id d2e1a72fcca58-72d35ed2202mr34314257b3a.24.1736961681637;
        Wed, 15 Jan 2025 09:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSsNepujGNbz1J1IXBjb/0km3pMtHIrAFEFy5rxiY9EIHAZSxb6F0qyHmauJ7UyfeA7MZUmQ==
X-Received: by 2002:a05:6a00:914b:b0:72d:35ed:214b with SMTP id d2e1a72fcca58-72d35ed2202mr34314191b3a.24.1736961680947;
        Wed, 15 Jan 2025 09:21:20 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067f84csm9648975b3a.142.2025.01.15.09.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:21:20 -0800 (PST)
Date: Wed, 15 Jan 2025 12:21:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Message-ID: <Z4fui1wQ97Hlmbqd@x1n>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
 <26ee9ae0-405f-4085-a864-48d1ee6371f1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26ee9ae0-405f-4085-a864-48d1ee6371f1@arm.com>

On Wed, Jan 15, 2025 at 04:58:06PM +0000, Ryan Roberts wrote:
> Hi Peter, David,

Hey, Ryan,

> 
> On 07/01/2025 14:47, Ryan Roberts wrote:
> > When mremap()ing a memory region previously registered with userfaultfd
> > as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
> > inconsistency in flag clearing leads to a mismatch between the vma flags
> > (which have uffd-wp cleared) and the pte/pmd flags (which do not have
> > uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
> > to trigger a warning in page_table_check_pte_flags() due to setting the
> > pte to writable while uffd-wp is still set.
> > 
> > Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
> > such mremap() so that the values are consistent with the existing
> > clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
> > of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
> > PTE, huge PMD and hugetlb paths.
> 
> I just noticed that Andrew sent this to Linus and it's now in his tree; I'm
> suddenly very nervous that it doesn't have any acks. I don't suppose you would
> be able to do a quick review to calm the nerves??

Heh, I fully trusted you, and I appreciated your help too. I'll need to run
for 1-2 hours, but I'll read it this afternoon.

Side note: no review is as good as tests on reliability POV if that was the
concern, but I'll try my best.

Thanks,

-- 
Peter Xu


