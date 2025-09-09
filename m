Return-Path: <linux-kselftest+bounces-41021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887ECB4A237
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770DC18841B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 06:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D72FCBF9;
	Tue,  9 Sep 2025 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEKaAma6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C32257853
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399331; cv=none; b=S7d5YLvCnqYBsKt/flqF6vOoFwBk2MASFqO5rjNpVnnYB0rdYFJmdQ18zZbLnTMR7H84zHp9ge/bYskXCw9cFyQ36QxARB0lzdN5T33e4D1ZSP5/lEcDGv31bkYPrBRsY3KEGvFi+WBfc/FnmogF0nYJiMAF4K1gK5OnqnWJfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399331; c=relaxed/simple;
	bh=sqn3YnlyT5vG7W1VV/krwDHcUzX/8Kspxeonyc+uTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCL+/SJQe5mFhuXntkP7nbdMzidURSt/LkxqEXMAzH2HZ4TNyVy1HO2sNn+zQmJsVYcqQiFOFHtwEkcx6BJpIwiwYXWHSB68R3pTGlG0Ad2qq4gEBNhwsQ2yibBxYGDgwYsyN7BagCeMFSyaYqt7qtR0A3bOk3x45utK10OQvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEKaAma6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757399328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyfaMLhE+eR6r1x04SbjrHAzIJx46jGGeK7FcNu4fRE=;
	b=HEKaAma6o3A8SYT6qaZp+dZs3hxVPOCxejl8nwLQXuxItqqSLwOGgyCLodgLuagjUu+l1B
	Sav40bUz/9iKiXfIQjGMFnqkhqsq8cks6OFlFYl/OIBpdleMcdTc+zC4u9wMjtlZZs6aBs
	awmuWBDXon5CB/vxhiXLCzo1Crw/LGM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-rzDKvLShMXasmEw3AvcgEg-1; Tue,
 09 Sep 2025 02:28:45 -0400
X-MC-Unique: rzDKvLShMXasmEw3AvcgEg-1
X-Mimecast-MFC-AGG-ID: rzDKvLShMXasmEw3AvcgEg_1757399323
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4336119560A7;
	Tue,  9 Sep 2025 06:28:43 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7A1319560B8;
	Tue,  9 Sep 2025 06:28:36 +0000 (UTC)
Date: Tue, 9 Sep 2025 14:28:31 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH v2 3/3] selftests/mm: fix va_high_addr_switch.sh failure
 on x86_64
Message-ID: <aL_JD_vNvM2kXoRJ@gmail.com>
References: <20250908124740.2946005-1-chuhu@redhat.com>
 <20250908124740.2946005-2-chuhu@redhat.com>
 <20250908124740.2946005-3-chuhu@redhat.com>
 <20250908124740.2946005-4-chuhu@redhat.com>
 <22a9dd3e-0755-4f7f-a59c-a79a52871f56@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a9dd3e-0755-4f7f-a59c-a79a52871f56@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 08, 2025 at 03:09:24PM +0200, David Hildenbrand wrote:
> On 08.09.25 14:47, Chunyu Hu wrote:
> > The test will fail as below on x86_64 with cpu la57 support (will skip if
> > no la57 support). Note, the test requries nr_hugepages to be set first.
> > 
> >    # running bash ./va_high_addr_switch.sh
> >    # -------------------------------------
> >    # mmap(addr_switch_hint - pagesize, pagesize): 0x7f55b60fa000 - OK
> >    # mmap(addr_switch_hint - pagesize, (2 * pagesize)): 0x7f55b60f9000 - OK
> >    # mmap(addr_switch_hint, pagesize): 0x800000000000 - OK
> >    # mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0x800000000000 - OK
> >    # mmap(NULL): 0x7f55b60f9000 - OK
> >    # mmap(low_addr): 0x40000000 - OK
> >    # mmap(high_addr): 0x1000000000000 - OK
> >    # mmap(high_addr) again: 0xffff55b6136000 - OK
> >    # mmap(high_addr, MAP_FIXED): 0x1000000000000 - OK
> >    # mmap(-1): 0xffff55b6134000 - OK
> >    # mmap(-1) again: 0xffff55b6132000 - OK
> >    # mmap(addr_switch_hint - pagesize, pagesize): 0x7f55b60fa000 - OK
> >    # mmap(addr_switch_hint - pagesize, 2 * pagesize): 0x7f55b60f9000 - OK
> >    # mmap(addr_switch_hint - pagesize/2 , 2 * pagesize): 0x7f55b60f7000 - OK
> >    # mmap(addr_switch_hint, pagesize): 0x800000000000 - OK
> >    # mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0x800000000000 - OK
> >    # mmap(NULL, MAP_HUGETLB): 0x7f55b5c00000 - OK
> >    # mmap(low_addr, MAP_HUGETLB): 0x40000000 - OK
> >    # mmap(high_addr, MAP_HUGETLB): 0x1000000000000 - OK
> >    # mmap(high_addr, MAP_HUGETLB) again: 0xffff55b5e00000 - OK
> >    # mmap(high_addr, MAP_FIXED | MAP_HUGETLB): 0x1000000000000 - OK
> >    # mmap(-1, MAP_HUGETLB): 0x7f55b5c00000 - OK
> >    # mmap(-1, MAP_HUGETLB) again: 0x7f55b5a00000 - OK
> >    # mmap(addr_switch_hint - pagesize, 2*hugepagesize, MAP_HUGETLB): 0x800000000000 - FAILED
> >    # mmap(addr_switch_hint , 2*hugepagesize, MAP_FIXED | MAP_HUGETLB): 0x800000000000 - OK
> >    # [FAIL]
> > 
> > addr_switch_hint is defined as DFEFAULT_MAP_WINDOW in the failed test (for
> > x86_64, DFEFAULT_MAP_WINDOW is defined as (1UL<<47) - pagesize) in 64 bit.
> > 
> > Before commit cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*}
> > functions"), for x86_64 hugetlb_get_unmapped_area() is handled in arch code
> > arch/x86/mm/hugetlbpage.c and addr is checked with map_address_hint_valid()
> > after align with 'addr &= huge_page_mask(h)' which is a round down way, and
> > it will fail the check because the addr is within the DEFAULT_MAP_WINDOW but
> > (addr + len) is above the DFEFAULT_MAP_WINDOW. So it wil go through the
> > hugetlb_get_unmmaped_area_top_down() to find an area within the
> > DFEFAULT_MAP_WINDOW.
> > 
> > After commit cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*}
> > functions").  The addr hint for hugetlb_get_unmmaped_area() will be rounded
> > up and aligned to hugepage size with ALIGN() for all arches.  And after the
> > align, the addr will be above the default MAP_DEFAULT_WINDOW, and the
> > map_addresshint_valid() check will pass because both aligned addr (addr0)
> > and (addr + len) are above the DEFAULT_MAP_WINDOW, and the aligned hint
> > address (0x800000000000) is returned as an suitable gap is found there,
> > in arch_get_unmapped_area_topdown().
> > 
> > To still cover the case that addr is within the DEFAULT_MAP_WINDOW, and
> > addr + len is above the DFEFAULT_MAP_WINDOW, make the addr hint one
> > hugepage lower, so that after the align it's still within DEFAULT_MAP_WINDOW,
> > and the addr + len (2 hugepages) will be above DEFAULT_MAP_WINDOW.
> > 
> > Fixes: cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*} functions")
> > Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> > ---
> >   tools/testing/selftests/mm/va_high_addr_switch.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
> > index 896b3f73fc53..bd96dc3b5931 100644
> > --- a/tools/testing/selftests/mm/va_high_addr_switch.c
> > +++ b/tools/testing/selftests/mm/va_high_addr_switch.c
> > @@ -230,10 +230,10 @@ void testcases_init(void)
> >   			.msg = "mmap(-1, MAP_HUGETLB) again",
> >   		},
> >   		{
> > -			.addr = (void *)(addr_switch_hint - pagesize),
> > +			.addr = (void *)(addr_switch_hint - pagesize - hugepagesize),
> 
> Wouldn't it be more deterministic to do the alignment/rounding ourselves?
> 
> (void *)(ALIGN_DOWN(addr_switch_hint - pagesize), hugepagesize)
> 
> Unfortunately we don't have an ALIGN_DOWN helper available yet.
> 
> We could just move the one in pkey-helpers.h into vm_util.h

Thanks for the review!

This is good idea and it would be more deterministic if we provide an
aligned address directly, then the kernel change won't affect the test.

> 
> 
> But now I realize that, likely,
> 
> 	.addr = (void *)(addr_switch_hint - hugepagesize),
> 
> would just work and be aligned?

Yes, it's aligned to the hugepagesize, align down and works. I prefer
this way as it's easier and all other tests in the file do like this.
Thanks for the suggestion.

I thought we would lose some test coverage on testing if it will work when
an un-hugepagesize aligned addr is provided. Do you think it's
necessary? If not, I'll change to:

	.addr = (void *)(addr_switch_hint - hugepagesize),

or we can add them both if necesasry.

> 
> -- 
> Cheers
> 
> David / dhildenb
> 


