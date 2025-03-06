Return-Path: <linux-kselftest+bounces-28421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1682A5532B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FED21881239
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8A2116F2;
	Thu,  6 Mar 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCkB8+yT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD725D202
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282406; cv=none; b=ka3f47Qc4/C90BhgwJJ982TjQTI6l4pRZFhELV/6CAFgJrt88yoXbtgdQvrKHRkelZZfO5y8kdZQcWm8qZBsDj1mm8n+bFL/AEmxFcMt92ECrvPBbYcGlPZRyMOFUK/0ySE4QFreEqGDFFXokm1Bbg3WrBllnQqmvra+/ZYJs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282406; c=relaxed/simple;
	bh=yesNcmtGbNvXrMqb4l4AWjH7Uh6GoBe2YNFgTLAoU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXlkF7UMJ+AjJAG8p5ZQkVn8ESiKEFuQ8s4LIFMKdbZiH0w7TE1wlsovR5rNMRADA8XvCtxD+fIxaBwKdKIKpI2A42jTeaMgJM3r2CcCdL2KWyiZjvz3fzQP91chKTxsHZroIKtl3GFSAPK0mjaoCVY7FHrqj47XHUoDeTTtibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCkB8+yT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741282403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hp0N3y6evf2yrWiBp62GjhkD2NyHCbEpRbyXBBPihTw=;
	b=aCkB8+yTrNndCul8pNoOfJNUvGbqBCBa5GAHpSVh7o28XWC6QnGqcDkg5OaNkl9bgYQhoC
	nyedf/DXLUK9SlSGNXyNkPvLZw+QyyyzoAs25yX7ZI9DS3k+ogndx39vFCSbj7eV3ZgrZO
	DbAMuvtEiyJGu8oEM3QOlFuftA+aV/k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Q2o1J8HQNDeSZbGIBjANlg-1; Thu, 06 Mar 2025 12:33:17 -0500
X-MC-Unique: Q2o1J8HQNDeSZbGIBjANlg-1
X-Mimecast-MFC-AGG-ID: Q2o1J8HQNDeSZbGIBjANlg_1741282397
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ba7d884bso19189066d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 09:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282397; x=1741887197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp0N3y6evf2yrWiBp62GjhkD2NyHCbEpRbyXBBPihTw=;
        b=PJdQVKsmjUpH670nTvOVKZc7Clw4aB0+f/yFpShHMKEpanYoxdFUBvskgPc4Zyuk8e
         zP5TmCGD06SsWMuerS69t2AUEZVHeKiy/Nwr6uf1M93Z1c3m5cGcNoK4nZNaYNRLZGLq
         wgFJSHs7gtZA0jklzM2Ztqji0Q+EaL2jashDYnIFl146ziCaU5SaozzCE9Wbxh/PNSx6
         WLxSEBxNo/EIfI9q6Rc5XL1AKzlaRy3AUH783odouQyDNnWF6bKYCahDGxPJa/6KnUU0
         h2O4GFJy7/upoGXH6kx886GQrfR7c1WlxhtTA0dWIKVbkLOVdwoAzp02Av16K3EHX/gQ
         co3A==
X-Forwarded-Encrypted: i=1; AJvYcCWGDbOqwB8b1yZrxE4zlCEG+K9rfzrF1sfApbgfWYURYtxWUaXI0sp6H2jfl97cFAV06n9R0C9h9UyOaA1YCvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkkVKBh4vchMyHADfp+uNoAs16A9nYW/7xeMLKco34g24ImE/
	mi16es1VkaFiVy90eKIs6vdK/rws/2iVHdg2IVWVQvnZPzhFkBzvFLZ4lErUc3eiLJav0WT47G8
	Aua6qSoBBXPVShajLedgx6hib1CD1KC8xA1jNNN+f0jJ+BGaPybwnXlfyjhEijj/o7A==
X-Gm-Gg: ASbGncspRWxVsurMjoYRlP7Y9JsZ3nMfcb0n+dXaFMavkD+69pacRvvh5tYrtDa9aJp
	n/wPmEKKs4q5jPMX+aoy+QkeqXpkUhuUY+SHgFMw+fSCMdyqxl30AY+ckudtNRcpZzfnqCLopsk
	8EdoZ7wIxX4EM2Bl+3C1BLKKM9mo2E8lNgf+tucdaaTDfTlWSj/PeSqrJnEvdVvqwNh/FzxXQYS
	x+Th4Off7vNyCDS+MKWO2aeW9VTtwX9ehGX281ooOL4hv2FuCpa4g32Ec0MqpOKnrxe94E3RNxP
	V98xQro=
X-Received: by 2002:ad4:5dcb:0:b0:6d3:f1ff:f8d6 with SMTP id 6a1803df08f44-6e8e6dd4013mr91007626d6.40.1741282397145;
        Thu, 06 Mar 2025 09:33:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXGTY2TZuxc/5qoe6G+TjInYEiN1/MY4M3Q3Wi5nBQl7XJwnFgOewPjxKsSfPGwYlCfIdGig==
X-Received: by 2002:ad4:5dcb:0:b0:6d3:f1ff:f8d6 with SMTP id 6a1803df08f44-6e8e6dd4013mr91007016d6.40.1741282396798;
        Thu, 06 Mar 2025 09:33:16 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44b8sm9395206d6.59.2025.03.06.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:33:15 -0800 (PST)
Date: Thu, 6 Mar 2025 12:33:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	mike.kravetz@oracle.com, erdemaktas@google.com,
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com,
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org,
	bfoster@redhat.com, kent.overstreet@linux.dev, pvorel@suse.cz,
	rppt@kernel.org, richard.weiyang@gmail.com, anup@brainfault.org,
	haibo1.xu@intel.com, ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 14/39] KVM: guest_memfd: hugetlb: initialization and
 cleanup
Message-ID: <Z8ncWAP7ln1St5W-@x1.local>
References: <cover.1726009989.git.ackerleytng@google.com>
 <3fec11d8a007505405eadcf2b3e10ec9051cf6bf.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fec11d8a007505405eadcf2b3e10ec9051cf6bf.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:45PM +0000, Ackerley Tng wrote:
> +static int kvm_gmem_hugetlb_filemap_remove_folios(struct address_space *mapping,
> +						  struct hstate *h,
> +						  loff_t lstart, loff_t lend)
> +{
> +	const pgoff_t end = lend >> PAGE_SHIFT;
> +	pgoff_t next = lstart >> PAGE_SHIFT;
> +	struct folio_batch fbatch;
> +	int num_freed = 0;
> +
> +	folio_batch_init(&fbatch);
> +	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> +		int i;
> +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +			struct folio *folio;
> +			pgoff_t hindex;
> +			u32 hash;
> +
> +			folio = fbatch.folios[i];
> +			hindex = folio->index >> huge_page_order(h);
> +			hash = hugetlb_fault_mutex_hash(mapping, hindex);
> +
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);

I'm debugging some issue and this caught my attention.  IIUC we need to
unmap the last time here with the fault mutex, right?  Something like:

        unmap_mapping_range(mapping, lstart, lend, 0);

Otherwise I don't know what protects a concurrent fault from happening when
removing the folio from the page cache simultaneously.  Could refer to
remove_inode_single_folio() for hugetlbfs.  For generic folios, it normally
needs the folio lock when unmap, iiuc, but here the mutex should be fine.

So far, even with the line added, my issue still didn't yet go away.
However I figured I should raise this up here anyway at least as a pure
question.

> +			kvm_gmem_hugetlb_filemap_remove_folio(folio);
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +
> +			num_freed++;
> +		}
> +		folio_batch_release(&fbatch);
> +		cond_resched();
> +	}
> +
> +	return num_freed;
> +}

-- 
Peter Xu


