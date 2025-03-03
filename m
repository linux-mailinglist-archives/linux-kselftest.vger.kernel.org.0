Return-Path: <linux-kselftest+bounces-28095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34FBA4CD82
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4FF3ACE5D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54D1F03CF;
	Mon,  3 Mar 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwysIRCE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AC723642B
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037383; cv=none; b=GWKGS30hsgnUjYJEI8HSFzTl+bxzJPHQ84LIjjsRbYdVSWjKWD190aXKISyuhljubL22QQMdsrYuZTifX6u5+FqxQUIxKmzvVxqhheG4H1oUiiSWAAx0XIrlq0vv0ZldStGD7d+gCOfcNhTvw3Qt8agIWghNVHjbalSw00XYDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037383; c=relaxed/simple;
	bh=uGCOquydQMu7XE8XjxA6YgTbUc8YWG3dslP5N8e1NUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGFfi7YJ8fw6Tzh2WPSAtRTjXG9DfEDeJAiLU8zfUEhFp1H/DCKoeHwKMC859E/glsKqsPrD3uhjK1QF9Gp67ZCaeKM8tY1Tx1cztQmfcjEjQW27EPqAc2BnSyrDnjxHKdDDMSf6UOeZeOnLGVQcfNh/wWKqQ5A2nCiovcG84Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwysIRCE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741037381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XHKmdvqQLV0kinajoxf6W7WfTOeuSd3If/M5JQf010=;
	b=LwysIRCEtalOKt8VpJ9w5zAzjkfGUqly2A+aeM9CztLgFtxfPLS2vz9bRH8Q2SyXZ3Nbl3
	zZ6DEekp72d0kN6w9Oj14H0Zml3RfQ6reS+dRpUU6CgH00b5oer4NalhpwlMRQehsLi/dI
	/2IeN+uWtCZxmRDfVzz7/hr0XkO7btY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-8U_izW1BMYCCikiRiCOw8g-1; Mon, 03 Mar 2025 16:29:35 -0500
X-MC-Unique: 8U_izW1BMYCCikiRiCOw8g-1
X-Mimecast-MFC-AGG-ID: 8U_izW1BMYCCikiRiCOw8g_1741037374
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-474eb86a314so26959001cf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 13:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741037374; x=1741642174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XHKmdvqQLV0kinajoxf6W7WfTOeuSd3If/M5JQf010=;
        b=hGl8BA7TsekfU7TTvWZAVLWzOI0yNoDNvjPtvT1DF126QVrNx+4EC2weecku0x1qao
         rsKi5AUFPyDTE+mbQ17ww0GX6hgzxmFzDgLWgrVV+JGxb9qQ6IuTG1sIpL3dkxm2pPAn
         pEJDdg9+7vW3byIPvyDVURBrGgGSlulkRZ5CZ55JOolXsBYB2koWMFco8VsZoQb3qu2J
         mMPjpCck+haQsyApBAnPCvHAsro2BKl6smD4CfuedDbGGSfH8VbGzAPkWGGJDhujmTVx
         /UFdRMX65j00gFowDD0YV6PAq/cAB7Z3fvB8eVkb5+oCZdx6gaVNP+LWSbRNA6IFKjUS
         /pbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCQ2im9hdpIsUwhesKQuI2wIL8Zhj7hTnzR7fGc8BL6EZlCXcDJc2/ANY35k8n47pAgOBa76Av4+TI6JDkZq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QBP/UtZBydNU0dPTU7c6x5XD02urE83aIeEkX2PK724PjEMx
	/FkrRfLZaoCv+IGvizgwQO/ABQ5PDY/Ks0MP3BnqPw/3DDpauLhrSNYoaAXLTdEGNC5v7KLMCzH
	vpvTWU4KpDRfyiQZRgqlfPO2DZUABN08Rs6S7TYyseWxIAYUStFJ08Jhh9J3iP9s7Gg==
X-Gm-Gg: ASbGncukof8DXkLX/TQHcbR2wie82L3JDUlsaboAiUH/5505vrLMVvkqSeGb1yPuYtc
	g8X//sCwN82PaRsGwl4rurVMbyYsc1zaYy8WW+ctcElF5PFAFPbTrHgUokVhG28hi9HS7h2FqMn
	5joMQ4vop5fSk4wponcZe6sm6xYq/BDM4GHs/bO/wZ39xdlmpTTxnc7S7N1ivJZVZIWlCxs9ZrU
	zBrOaxyWD/eIU9eh8F0nz8wRi4pEQZmyq90vwFfi7UGIjRyhQQAy+ChTr9eENPX4ThEXgTLxAu4
	7CILGR0=
X-Received: by 2002:a05:622a:1195:b0:471:f1c6:54a6 with SMTP id d75a77b69052e-474bbf8989cmr203598911cf.0.1741037374584;
        Mon, 03 Mar 2025 13:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyEWewqQv6y2LaIpicJJ1HPCHenu4T0jWbilaFvqyXO2dsNaQSyH7LiAJDW9m7DNjxLw6PZg==
X-Received: by 2002:a05:622a:1195:b0:471:f1c6:54a6 with SMTP id d75a77b69052e-474bbf8989cmr203598501cf.0.1741037374182;
        Mon, 03 Mar 2025 13:29:34 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474fd3a8bdasm603971cf.74.2025.03.03.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:29:33 -0800 (PST)
Date: Mon, 3 Mar 2025 16:29:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, david@redhat.com, ryan.roberts@arm.com,
	quic_eberman@quicinc.com, jthoughton@google.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z8YfOVYvbwlZST0J@x1.local>
References: <20250303133011.44095-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303133011.44095-1-kalyazin@amazon.com>

On Mon, Mar 03, 2025 at 01:30:06PM +0000, Nikita Kalyazin wrote:
> This series is built on top of the v3 write syscall support [1].
> 
> With James's KVM userfault [2], it is possible to handle stage-2 faults
> in guest_memfd in userspace.  However, KVM itself also triggers faults
> in guest_memfd in some cases, for example: PV interfaces like kvmclock,
> PV EOI and page table walking code when fetching the MMIO instruction on
> x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
> that KVM would be accessing those pages via userspace page tables.  In
> order for such faults to be handled in userspace, guest_memfd needs to
> support userfaultfd.
> 
> This series proposes a limited support for userfaultfd in guest_memfd:
>  - userfaultfd support is conditional to `CONFIG_KVM_GMEM_SHARED_MEM`
>    (as is fault support in general)
>  - Only `page missing` event is currently supported
>  - Userspace is supposed to respond to the event with the `write`
>    syscall followed by `UFFDIO_CONTINUE` ioctl to unblock the faulting
>    process.   Note that we can't use `UFFDIO_COPY` here because
>    userfaulfd code does not know how to prepare guest_memfd pages, eg
>    remove them from direct map [4].
> 
> Not included in this series:
>  - Proper interface for userfaultfd to recognise guest_memfd mappings
>  - Proper handling of truncation cases after locking the page
> 
> Request for comments:
>  - Is it a sensible workflow for guest_memfd to resolve a userfault
>    `page missing` event with `write` syscall + `UFFDIO_CONTINUE`?  One
>    of the alternatives is teaching `UFFDIO_COPY` how to deal with
>    guest_memfd pages.

Probably not..  I don't see what protects a thread fault concurrently
during write() happening, seeing partial data.  Since you check the page
cache it'll let it pass, but the partial page will be faulted in there.

I think we may need to either go with full MISSING or full MINOR traps.

One thing to mention is we probably need MINOR sooner or later to support
gmem huge pages.  The thing is for huge folios in gmem we can't rely on
missing in page cache, as we always need to allocate in hugetlb sizes.

>  - What is a way forward to make userfaultfd code aware of guest_memfd?
>    I saw that Patrick hit a somewhat similar problem in [5] when trying
>    to use direct map manipulation functions in KVM and was pointed by
>    David at Elliot's guestmem library [6] that might include a shim for that.
>    Would the library be the right place to expose required interfaces like
>    `vma_is_gmem`?

Not sure what's the best to do, but IIUC the current way this series uses
may not work as long as one tries to reference a kvm symbol from core mm..

One trick I used so far is leveraging vm_ops and provide hook function to
report specialties when it's gmem.  In general, I did not yet dare to
overload vm_area_struct, but I'm thinking maybe vm_ops is more possible to
be accepted.  E.g. something like this:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5e742738240c..b068bb79fdbc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -653,8 +653,26 @@ struct vm_operations_struct {
         */
        struct page *(*find_special_page)(struct vm_area_struct *vma,
                                          unsigned long addr);
+       /*
+        * When set, return the allowed orders bitmask in faults of mmap()
+        * ranges (e.g. for follow up huge_fault() processing).  Drivers
+        * can use this to bypass THP setups for specific types of VMAs.
+        */
+       unsigned long (*get_supported_orders)(struct vm_area_struct *vma);
 };
 
+static inline bool vma_has_supported_orders(struct vm_area_struct *vma)
+{
+       return vma->vm_ops && vma->vm_ops->get_supported_orders;
+}
+
+static inline unsigned long vma_get_supported_orders(struct vm_area_struct *vma)
+{
+       if (!vma_has_supported_orders(vma))
+               return 0;
+       return vma->vm_ops->get_supported_orders(vma);
+}
+

In my case I used that to allow gmem report huge page supports on faults.

Said that, above only existed in my own tree so far, so I also don't know
whether something like that could be accepted (even if it'll work for you).

Thanks,

-- 
Peter Xu


