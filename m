Return-Path: <linux-kselftest+bounces-26511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEA7A33B88
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 10:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB65E3A5EF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91220E314;
	Thu, 13 Feb 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwnbyiS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDE20D4E6
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440057; cv=none; b=ha3tXKhPGm5vP65aNhCodXO/CTwD1x65d7IrvpwKAoWN9sUs7UXpqA0GW45oPOwMIl0Pr8qRByNznlEMz+/7mxgDPTUrNcA20GUhTD0EjZqmLXaCbEO4i8cWsxMXUNgMOBOr2EVyEXKwYRDTx5qpAgvNyRyJvH/iGiUmAUmMu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440057; c=relaxed/simple;
	bh=qzJGD2b+cbjGe2N6+DgDif/b8vffJoz0V+ySZt7b4BI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=fEsbZxMrafidI8CxFnrCxabt+nMyguRhWNX85q2KjDbV+TAAlkaNOMZPGT7q6HEEWRluj09ZDdnpq2g7RO0pooh58zvbp2BI83srDgL2bJU1kJGvdoUjb6Il1QLk7fcEEpX+OMPhBDIVFZOA4azxIwEHL2Z1egnmoQenpx8UQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwnbyiS6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so1628731a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 01:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739440055; x=1740044855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PuoEoBk1WxA1QM7rSYL5IAeW1R6CE44HE0t4+Ea+Jjs=;
        b=NwnbyiS6AzjDitoE3i/JvqabdY0H083Quox50BgWrq7l6EXhLMU94d9S3Tzv6t8Rvt
         zY0gs76Bc5llVbdwoCiwDCzP+X+GP6SM/r1k70gDcdAp2IvO0Kivd158O4oL2Clz3L6B
         HYCG0qG5e30MeJTm42S8I8NA1fRhS6uNX2OWZxvb+oJgGxoJdqLphl2UjpJcN0Sih3TY
         McsNSXaWfn/oFkIP621sY3KD37wpCP+Sqg3lh8rP/b92s/oNicuHYAyMQmgiZVDXlFPP
         kmiJaIwVA387jjH0XG/uDUAFk1ON2UoNe0m3jWUZkSbbYXJQdyiyrypcJWTpHAOtE+Eg
         GCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440055; x=1740044855;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuoEoBk1WxA1QM7rSYL5IAeW1R6CE44HE0t4+Ea+Jjs=;
        b=QgLowyKZNN//wT4TO2pAXuBPw/xcpX6ozYfZ+2XU7UXWWaDLyZQ/PhZEaAhSYx4Cbu
         ayZG/F8C+yLO1qgw4pvayNhFFybt6JhrOHLJuUgVdttB3N/RGWZbtwaXQn6Qc8hHcwXm
         rCG1PYfp7LiHQFShLnfpNj1EWsKn+sL8acGNiQ3EfjWrQFedxIzt+ePFJfU+zy+1IDMA
         I9tcyhijYQePvhNGaYKYcjuJvoxazMD4dQdK5KHggZUFbS99JVpjVu/Vzt4Okm9r2zlb
         WdbWUrHoUXeQtDca3F42li63R0M7TQeTsmWh34eng+gxUjIyREfdvHTCHl7OAT8XAqAW
         j2sw==
X-Forwarded-Encrypted: i=1; AJvYcCXdmlMRkB2REb/ibY4o7+e0nh09b5rsY+F50ye011EYx++BtVNOrl/gp2gD4yU1qG0NSL3JVfMeogi+pf5dI58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8w9gW35ZudRpWoWMt5nz4Qc3jMjzIGWwcCldHYOP98xSjfKHH
	gRH3k3K/Ds6ZFlxHwoIFeFd8aXQp6xfFIy7Gm9toGmkRTjdEQ16V+KVN/oCckYba8WDWRx+yv1D
	YrYsj5hphxE4Pro6XCmC6Hw==
X-Google-Smtp-Source: AGHT+IFjo0o7W8BMmhgfzjT1fZjgSjJW+Epialp3pC2emFjR4ZguxthbuHETUF+drifrj4mBdX3+3nB91gHNlOu2NQ==
X-Received: from pjbmp3.prod.google.com ([2002:a17:90b:1903:b0:2fa:a101:755])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a89:b0:2f4:423a:8fb2 with SMTP id 98e67ed59e1d1-2fc0e98dd17mr3572208a91.20.1739440055202;
 Thu, 13 Feb 2025 01:47:35 -0800 (PST)
Date: Thu, 13 Feb 2025 09:47:33 +0000
In-Reply-To: <Z0ykBZAOZUdf8GbB@x1n> (message from Peter Xu on Sun, 1 Dec 2024
 12:59:33 -0500)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz5xle9nwq.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 14/39] KVM: guest_memfd: hugetlb: initialization and cleanup
From: Ackerley Tng <ackerleytng@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, david@redhat.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, mike.kravetz@oracle.com, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Peter Xu <peterx@redhat.com> writes:

> On Tue, Sep 10, 2024 at 11:43:45PM +0000, Ackerley Tng wrote:
>> +/**
>> + * Removes folios in range [@lstart, @lend) from page cache of inode, updates
>> + * inode metadata and hugetlb reservations.
>> + */
>> +static void kvm_gmem_hugetlb_truncate_folios_range(struct inode *inode,
>> +						   loff_t lstart, loff_t lend)
>> +{
>> +	struct kvm_gmem_hugetlb *hgmem;
>> +	struct hstate *h;
>> +	int gbl_reserve;
>> +	int num_freed;
>> +
>> +	hgmem = kvm_gmem_hgmem(inode);
>> +	h = hgmem->h;
>> +
>> +	num_freed = kvm_gmem_hugetlb_filemap_remove_folios(inode->i_mapping,
>> +							   h, lstart, lend);
>> +
>> +	gbl_reserve = hugepage_subpool_put_pages(hgmem->spool, num_freed);
>> +	hugetlb_acct_memory(h, -gbl_reserve);
>
> I wonder whether this is needed, and whether hugetlb_acct_memory() needs to
> be exported in the other patch.
>
> IIUC subpools manages the global reservation on its own when min_pages is
> set (which should be gmem's case, where both max/min set to gmem size).
> That's in hugepage_put_subpool() -> unlock_or_release_subpool().
>

Thank you for pointing this out! You are right and I will remove
hugetlb_acct_memory() from here.

>> +
>> +	spin_lock(&inode->i_lock);
>> +	inode->i_blocks -= blocks_per_huge_page(h) * num_freed;
>> +	spin_unlock(&inode->i_lock);
>> +}

