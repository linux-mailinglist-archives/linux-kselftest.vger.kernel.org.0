Return-Path: <linux-kselftest+bounces-24814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94AA174BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 23:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EA33A3843
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 22:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342A1EF094;
	Mon, 20 Jan 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiPqCDWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071B1684A4
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412948; cv=none; b=b+IZ4FoMKblNwzLi/NTvK9QwFy1RpnKStHcjceXx2XxOexioQ3yYwc6m+cckDD+84QX0HKWJ25LYZtgG1Q5au8KEApVdNhPZS2e49TPrqq6tnEe8RBtmj5WLb6q7G/ZV23HsU+Hl9MXVCTgkpLPcCa6O9w9M1f5KNSfo0x6FbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412948; c=relaxed/simple;
	bh=MI6K6OxxlBfwQa8RksvnhXGgY56IlPTqx9gNhRjrzEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lewUphxAthqntlKR8d4iKq7bmDc/bB4oXgxfXwjY3Wghz9mSxZkT7R1ZBo4Jdy4mwwHsEzflaik14E42L0InGHRlsYox9CblXTte1wr0drbfWXOFuKzOzxOX9L2rKozrJpxPxJyc5nPQ2Io6mERwKvwAYgHqCtLgLgD4SdH8nGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiPqCDWm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737412945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr/mJCPPlIoUxh0qeb7nwuTIwN1v1Uw8JIILAMa5xao=;
	b=EiPqCDWmpW5z2HBgMQUDqOtIOZ/Ff49QXGwEL0DQvHvrs7z2TUuItN3QYYVZs5EYdKTOvr
	2PBl9bkZfzFguF1zoxn4gGiLtXZQC7Pq5dNrxfF2754PD6VifwuvIvONhj9EfD4d14GxhD
	zdP7ZE/B24gim9u5FHGcqBnJph0UFPI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-VogrzfasPLe7toyFdB_y2g-1; Mon, 20 Jan 2025 17:42:24 -0500
X-MC-Unique: VogrzfasPLe7toyFdB_y2g-1
X-Mimecast-MFC-AGG-ID: VogrzfasPLe7toyFdB_y2g
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6d0be4fb8so842560285a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 14:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737412944; x=1738017744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr/mJCPPlIoUxh0qeb7nwuTIwN1v1Uw8JIILAMa5xao=;
        b=xMIsdyJToC89jpWNVADN/xxvpweekB2+BO1cSnYMLo3/hDdwUXYDPrFgE6bJjp0z9k
         9/e6TYoFuCffdDuvB9srSE84KeN7C+XpmsTiKcMANPDw1eE2Id6wSPJH0FRHg2xB01Po
         zo/oD/aywFPMib5pfMBoAbDtLdiCALnlBvYd5z3l9hhKWSn9FgGnWOoCxQZ6jUOlX2V/
         pZZBV4Q7o9w8KKZGHPlekxil5p8cbyl3utuCfLYlrm4Waoo1BcdtMt3aHcuBrmKnswlr
         4gEJ8LeRkzgCgfvYXk3ar0YqsKnJ0EhcSXtutP0A1/qf9QJrch8DqlhGlcLTPDyNQ6mN
         qJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWxKoCXM9wV8MGZ0d/AZ7ws9VsY1B0KwNMuGwwzSEZJcrhVnTjt7MTp6nGjZ7Y4MS8cmDhpNHruDLDsfpBT5K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iuQiz2wgB76R+cA9zNGde3N/K6mOrztJPvxskONoxEcXv4J/
	4YYkDPna3Bhv/ooqMuZXKlJ1Z4F7IcgCfT5JVKeAHGmtfQDzKQp951+FpfOoEyxXGjUnpwx141z
	VleP8UgLk9F/hl5ybiH5pY6BJE1Cgy42YzCXq6d8Dv1Mwojm7W7uII/bO6sqiVuPc6A==
X-Gm-Gg: ASbGnctMrYYbffvTRkN4d3fRALwDah2WX4CB7EMSGel5b/BFHk1QTgclGRIjRIzOOn0
	0gir5uqC/BTCwJQz7xfO5yqKe5708ufkzBGmSMMysxOyZh15vrZAVbD+T8YoyDaDJG9hI0QhVOg
	0SDxq3U21DvK6jk3ngwn7DCqoi7ORZD4p0TXNojQk1bZo+Outkl9SOtYad2mThCYg/L7CVGzXp7
	QW/Vrcsc5RQJDsUrxpLoWWfwi5c/Jw7tHeZtdcbo6sH319hh1RWr0v2a+/6uy0VN4e3UcGYBsd2
	tGcnmS8PkQPNZw3ILRubWk73ZAvvH8w=
X-Received: by 2002:a05:620a:1a02:b0:7b6:6a76:3a44 with SMTP id af79cd13be357-7be631f2fe6mr2099328985a.17.1737412944354;
        Mon, 20 Jan 2025 14:42:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEThixwCznyw5iNLbhD2xvehIRrXyI7UvkShNUVV9hD0bz/X+BcgicvUE24wdf1vF932XY0Hw==
X-Received: by 2002:a05:620a:1a02:b0:7b6:6a76:3a44 with SMTP id af79cd13be357-7be631f2fe6mr2099326185a.17.1737412944062;
        Mon, 20 Jan 2025 14:42:24 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d9955sm493015685a.81.2025.01.20.14.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 14:42:22 -0800 (PST)
Date: Mon, 20 Jan 2025 17:42:18 -0500
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
Subject: Re: [RFC PATCH 27/39] KVM: guest_memfd: Allow mmapping guest_memfd
 files
Message-ID: <Z47RSls2rr-xVqNk@x1n>
References: <cover.1726009989.git.ackerleytng@google.com>
 <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:58PM +0000, Ackerley Tng wrote:
> @@ -790,6 +791,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	 */
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> +	/* TODO: Check if even_cows should be 0 or 1 */
> +	unmap_mapping_range(inode->i_mapping, start, len, 0);
> +
>  	list_for_each_entry(gmem, gmem_list, entry)
>  		kvm_gmem_invalidate_begin(gmem, start, end);
>  
> @@ -946,6 +950,9 @@ static void kvm_gmem_hugetlb_teardown(struct inode *inode)
>  {
>  	struct kvm_gmem_hugetlb *hgmem;
>  
> +	/* TODO: Check if even_cows should be 0 or 1 */
> +	unmap_mapping_range(inode->i_mapping, 0, LLONG_MAX, 0);

Setting to 0 is ok in both places: even_cows only applies to MAP_PRIVATE,
which gmemfd doesn't support.  So feel free to drop the two comment lines.

Thanks,

-- 
Peter Xu


