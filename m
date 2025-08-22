Return-Path: <linux-kselftest+bounces-39718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A612EB3221A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CCA6267F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615A2BE628;
	Fri, 22 Aug 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yk69eiRN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D271A9FB9
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886266; cv=none; b=K43nXodwHOFUoX/dPPMd1+v9RGgIl6+OUnQdM6EPWoB1CQalDhs7/Zc/BtI3V64XQSkdxDgsTixlovFZXkrnSDUSfMXrzb/H5/Wtc019y8TUFeo/yNtKg2mBPx6SnucBaOLs4fXl9NhUEvvQcLGt6+5WAX3j/5ssaKDbOQoM44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886266; c=relaxed/simple;
	bh=zx8MvH5t85eVRYN60js9SAsxgYkD1auMlyzP4cjVgeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZwHYXZNS4njH5LNpJKx/MhtS0p4JlFxDjz1ucKJkSgAKnkRW3ZeeDx36BJRxYtQKr4i8hQqcKfL/7oSS0EOpRVaxQFtpNQYYnyftwDIa2RCmXyUQNwOp7V+keJxlLWyCVEv3rSh8XtGX4XA6HGdprMjshdOu0TxBr1VYyoN0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yk69eiRN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755886263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Cs65i5/BwS5INh2iU3PXL6F11yYfHDlCfNAhWqRXwfw=;
	b=Yk69eiRN34s0SayVuue89rmQ910iyrGp0tsmNpOruR/Ulrj97Om4WCO6R0ltmNu6Q+FVqY
	J8F+Vmm3afQhuwXIYO1kiP+Mvh2UzSbMy0UvDQ6cX75FP6GOtKfOFxUaUqghUoYt0DMamh
	8qSfytzeabBaMrW9q/2zINUkk50fOqU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-2h2YAio-Md-j0u8gbJt6Bw-1; Fri, 22 Aug 2025 14:10:57 -0400
X-MC-Unique: 2h2YAio-Md-j0u8gbJt6Bw-1
X-Mimecast-MFC-AGG-ID: 2h2YAio-Md-j0u8gbJt6Bw_1755886255
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4157303so1665916f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 11:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886255; x=1756491055;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs65i5/BwS5INh2iU3PXL6F11yYfHDlCfNAhWqRXwfw=;
        b=j6roBHUXalBD8UZjS2IApbZVjGghwstTOhWj+4Y5SRiI+5/pMyuxRsjA4U63C5p+Jb
         GBzHcE6t/lN8M2/5RQgnCJLVQ0azNIGfFExeTB2v36ho2/NkJ/AlKpciYMJs/yp+32i6
         FwZZ8nsXuVr6qcVu4TF/M/MopQFHbyS8Te8D7ycD/6a0ryaEy0NqHnDu6Hh4ewrz7HO1
         h/qwW8UEX61airPN8NyjSm1eO7nLiKQcX4enPCruBqKD9etjljm5F/Idop+tFMnVxX2/
         JtSASNslDU/dRvtTZ5X9wJAB1ifWilLWVtCLEIUkbWsyHO1HykJ2OxLGl4OB+JrvoLNe
         rBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6tARUeIP+10lXZO/63ibXuOnF+xilWP0/lcCcjR5p2xz368QUtUS9TpgkK8jkr509cGGCRUJOFtJr8+1SIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVT8FsQPibF8ywpGsZWK+66wFGit/fQK5JwoHbD9jCO32tyWVp
	Ve8BSLhtnLFLNapFaWsmWAazMsg6Yl5VZ+MZIN97uEKD1BLFmpDiBCGoNsWX/n1DXWqgfv+jy5k
	Z0WkOWCoA3fx001OUEJDndqw247czTVf3hyCmv4SUEnixvsQZ94qgs4HjmZW6J+j8V8GY3Q==
X-Gm-Gg: ASbGncuRFDBUZDG7EYfxjB5GnafL9EgkXcbbID2+OeRbUbaxjK7x4k8vwgG5NLLFIpi
	U+BNJ6I1MK39zkXXButvgv+0DkmZPEBYE1h5hOR1k0boNoNKdzwNZhVaR0XZ6eZm1JWBXYEB/oP
	BgxNUNYnWMIyHILganGIQ7kkWtZ9DTG4zIfAVxvmotWGJWCOzZlBFBEqgPC/LlmNxZSWQvWaQOb
	o+8l/JLSvahB/R0heJM6CmfxwcvbRoJaoNwhyrZcKeH/Y++FmJzZioB9SbRBA6z+/DSr5R80YIi
	pO9vMAQ0UVn+QBFnaU8j7kHRjls+0oPKw4r+VmII/5PNmslheC1cSqU+2wfFlkCdhAWMIGRxY4I
	9bW1ai0OlvuXYeVMjw9jlQTKnMdZavIOLKc+itpx72wYfJe1Z18JJErWuAyUNfdQ6dhE=
X-Received: by 2002:a05:6000:26ce:b0:3b7:83c0:a9e0 with SMTP id ffacd0b85a97d-3c5daefc76amr3207834f8f.25.1755886254526;
        Fri, 22 Aug 2025 11:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFruF/9yLWC9qQiiSeqlnaZybt0y1Lc6OlpmYaNOwlaf7dspYYth5O1iwJEpGlFoX5TNvjMRA==
X-Received: by 2002:a05:6000:26ce:b0:3b7:83c0:a9e0 with SMTP id ffacd0b85a97d-3c5daefc76amr3207779f8f.25.1755886254021;
        Fri, 22 Aug 2025 11:10:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:6100:d9da:ae87:764c:a77e? (p200300d82f2e6100d9daae87764ca77e.dip0.t-ipconnect.de. [2003:d8:2f2e:6100:d9da:ae87:764c:a77e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f238640sm404818f8f.26.2025.08.22.11.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 11:10:53 -0700 (PDT)
Message-ID: <9a9eb9ca-a5ae-4230-8921-fd0e0a79ccbb@redhat.com>
Date: Fri, 22 Aug 2025 20:10:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 29/35] scsi: core: drop nth_page() usage within SG
 entry
To: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>, Alexander Potapenko
 <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-30-david@redhat.com>
 <58816f2c-d4a7-4ec0-a48e-66a876ea1168@acm.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <58816f2c-d4a7-4ec0-a48e-66a876ea1168@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 20:01, Bart Van Assche wrote:
> On 8/21/25 1:06 PM, David Hildenbrand wrote:
>> It's no longer required to use nth_page() when iterating pages within a
>> single SG entry, so let's drop the nth_page() usage.
> Usually the SCSI core and the SG I/O driver are updated separately.
> Anyway:

Thanks, I had it separately but decided to merge per broader subsystem 
before sending. I can split it up in the next version.

-- 
Cheers

David / dhildenb


