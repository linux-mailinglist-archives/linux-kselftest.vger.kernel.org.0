Return-Path: <linux-kselftest+bounces-22649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA79DF6E2
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Dec 2024 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC120162B60
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Dec 2024 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175B1D7E5F;
	Sun,  1 Dec 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGWhUhDD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2651BC094
	for <linux-kselftest@vger.kernel.org>; Sun,  1 Dec 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075981; cv=none; b=aj2rZ+3VF51JJZEZj1mWNYkezfeNtK2Xo/7MOSLf/9mHjm2ey7N+RMefgjlpq4uo/6nAaC7BG5OmB8YFEDs0gHpJ2S75tdRFzMxlykYIR4nYSXJq/0Chy90IFfpS1PUzTnNBBNTO1Y0kNgdOglb0z/DqcepXoUZ00lmLrS5ewNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075981; c=relaxed/simple;
	bh=aCcFCSZJUXI54+bKPh/05TzVJL4t5c3nMnUzxLQ+3Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ0dJeXjH2oalrIfbKppABRFulailM961pNlVKKUs36LS9KwnLGducJFKkO9t1PjokHYyJKkdPgfe9xuE9T1UsthKDsWx0D8dEWt9lpFOI88s8aLYVQf0Q6pX5hHJakw2Q2gTkXydEdBirHsZ02nw/GZqd5AIGr8ErmkicmThx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGWhUhDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733075979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0A+hdS0S9TZs4FCHTCUNfBMXeoZLW6DBQh4uakYhdW8=;
	b=VGWhUhDDE6m+b2rIaDPxKgBtziQo68vTQzjnol33SUi5a7WqBSAxX3J8dbcFrfOmSUwi4l
	PMReeGzgyXw9S4COcKUsPozB5lUbftasOmkYhrKSUW3pxS0iEJQ8XDFsCOkie2R4LY2MDs
	UmWTclP2zOs1LOwyZhdE3FGltIQEBBk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-cRX3z_XTPJS5aoDbQSZypA-1; Sun, 01 Dec 2024 12:59:38 -0500
X-MC-Unique: cRX3z_XTPJS5aoDbQSZypA-1
X-Mimecast-MFC-AGG-ID: cRX3z_XTPJS5aoDbQSZypA
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a778ce76fbso36613395ab.1
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 09:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075977; x=1733680777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A+hdS0S9TZs4FCHTCUNfBMXeoZLW6DBQh4uakYhdW8=;
        b=TUPQ86WOAfNYWvGdzhJhVcQUdpp6Xmfgyy5IRL5+aNoQ01VybEV6N7arBhRIZ78n96
         HAPGkW8tiiXi3cln9pFRY3eQjEU1H6aK7y4pXiEZioKV3SrPl74CImzVj7EujtrYGNRy
         s/yx+Hq9eKl9+9em1Z5FkRXfT7UXe6YwcLAIOxSk2RXH5rI2TfU2FV/BcVyAr6D8exKR
         5y4jNO597GlPHiMVZsIZHB/VhjvVyon/P2AM990ZzuKp9VCryZ2L8uaMB5lE2MNv387E
         Xi5r+hthm7rTLch1NvB1hhbohiW2g2JfAfd4m4PVnaxqtopIEK3/Dj4s65OiGxX7h9AS
         7XIw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Q/njN0xQWH90T3v3R72D7jZ6LNpJXhY8DELlFINwHOb+C2S7S8/APUZIxkjebPIlMiPK8q5NNEesXdPMBH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRjuSy1W137kp4DhszFv4Xpzq4whR/2CDzmYbTceWxDr/Kxni
	wIN71pUvj8+WM1Kn1k5ar/XBFusrdwYJDdfp1PaeQ/tktdCjTlS2tlDOYFFoHSBh6mMjqJ4x5nu
	XkKB/GRTBz5f2YEVXH0LoZ+PEJ2kOsW35es+h1H9NzV8PlrrG0Iotq5Ho59A5gpkOWg==
X-Gm-Gg: ASbGnctOkqnGw13FZhOcR1FIOh4FrNoMrpWT/7G+3UKr4AJ15uJAbLFb8nLkFCjq67W
	58kM/spcFZN9UUgf2ZdH9cUh+x2piIZULd+b+9bCrka677tUpmyHvLitzKgmqonWjYD9bleJKxQ
	D1NRFcT1sQUj69bO6RFz6r9ukz5b2ncJ6PxOu1hirP9Puc+qdg78JU8LXsZYHgoFSP0dqBjTuUT
	9WcMc/GM5LXSzUqnT4tyOlrg+wEbq9eF/V57wS/B5q8k7E8WEbltlnQ5BgGIvf7WQjr10/t+CbB
	r0z97EVfsCc=
X-Received: by 2002:a05:6e02:2192:b0:3a7:dd45:bca1 with SMTP id e9e14a558f8ab-3a7dd45c5e2mr85506355ab.17.1733075977433;
        Sun, 01 Dec 2024 09:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHry52UnkIwNHPlxMfjuNJbz0kuNzIn+XivMrF6Q+kiRWIeU+o9LVgyCqSYZICKYohcFcyI2w==
X-Received: by 2002:a05:6e02:2192:b0:3a7:dd45:bca1 with SMTP id e9e14a558f8ab-3a7dd45c5e2mr85506025ab.17.1733075977146;
        Sun, 01 Dec 2024 09:59:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7ccc0b987sm18690775ab.34.2024.12.01.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:59:36 -0800 (PST)
Date: Sun, 1 Dec 2024 12:59:33 -0500
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
Message-ID: <Z0ykBZAOZUdf8GbB@x1n>
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
> +/**
> + * Removes folios in range [@lstart, @lend) from page cache of inode, updates
> + * inode metadata and hugetlb reservations.
> + */
> +static void kvm_gmem_hugetlb_truncate_folios_range(struct inode *inode,
> +						   loff_t lstart, loff_t lend)
> +{
> +	struct kvm_gmem_hugetlb *hgmem;
> +	struct hstate *h;
> +	int gbl_reserve;
> +	int num_freed;
> +
> +	hgmem = kvm_gmem_hgmem(inode);
> +	h = hgmem->h;
> +
> +	num_freed = kvm_gmem_hugetlb_filemap_remove_folios(inode->i_mapping,
> +							   h, lstart, lend);
> +
> +	gbl_reserve = hugepage_subpool_put_pages(hgmem->spool, num_freed);
> +	hugetlb_acct_memory(h, -gbl_reserve);

I wonder whether this is needed, and whether hugetlb_acct_memory() needs to
be exported in the other patch.

IIUC subpools manages the global reservation on its own when min_pages is
set (which should be gmem's case, where both max/min set to gmem size).
That's in hugepage_put_subpool() -> unlock_or_release_subpool().

> +
> +	spin_lock(&inode->i_lock);
> +	inode->i_blocks -= blocks_per_huge_page(h) * num_freed;
> +	spin_unlock(&inode->i_lock);
> +}

-- 
Peter Xu


