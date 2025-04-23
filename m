Return-Path: <linux-kselftest+bounces-31449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BEA9996C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 22:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE72F1B84AA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CA26A091;
	Wed, 23 Apr 2025 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6KWxEd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862D267B7D
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439951; cv=none; b=jTv4JvfSZkZXGozJTrHS8AZ0uAqsDELx6LqClRGrNELyD21rPEmxYctPhfsyyNM0UyXMRSGx2ZW/XDC4XYGC28Vnc5ABSXlheS424WKBnHNPEczKhUTZwxViCSuW+IGy+1f4eSpmv/XgcOYocCMCQBUVYAoX0ew8xeE0D1KSWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439951; c=relaxed/simple;
	bh=FVGAb43n+nj0WTaGxkD+7N48DxDKHF+TEMQjE/V8uF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PmU4qXkvESKWoVngF8NcaxioMDXC617F+b+pdXv4YkXX0kpd7CjfoNFtA+YW1rnF3ubSm/zyOrem374nNVuTiT4lhofw4Lh6aMknMa7kBVgifDxK+/nBgUxIRc8xQfhGn+gZPFm9K2qtErZd0AeQZ9MZZZ0oYCVG4PJUci5Tdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6KWxEd0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736b431ee0dso145280b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745439949; x=1746044749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjX2WJaP/+hIZJnKE7ZkAy8ut0H0AnZ+KN3YDGIa+EI=;
        b=B6KWxEd0568908TIWQLQx4k1c+x0CSpZXkE1kYcxVLL81Tt9AN3dr3ltUQGsHM6mmL
         34jEuwT3lO03sF6lEH8EyoEIjz711G+PVcqYO8eqh6o/A2PpqXF3FySQzQGxx41v9Wqr
         yqS806Ds3P/KHbo5eiVSbHOLT4nY1ipeuog0OFyW4De9uwzamEuvQ9Qopbgjwd6qjrrp
         24kNv/QukRbbI9kcg4PBEEnENJRQ0oddSV8CUlmbgv4u+ncGFuFeh25OArs4+PJ3lidk
         UX6aZyAx0WQylgvg6WrqZ6lmaOrpJBfqkxhkI69tiSZRMEP6BHldGEkvesIvb3w6WcdN
         NSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439949; x=1746044749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjX2WJaP/+hIZJnKE7ZkAy8ut0H0AnZ+KN3YDGIa+EI=;
        b=GusFNUzRr8Z5/Mj9tV47SMmv6blv+MF+BRkst9P4c3wPe8y4yACf0Ub1Q3dJ6PiFgE
         lhJxkWK4qmthzh5JgEv5FQjsidLo0G7LG86kGixghhDfYilk+yCBB4ypLNAeWtNkiRBA
         6fyNR0azZyusgsfYiGqxemhKuESem+WmVyFa27FY1zu9tSY/3KWup7YmICfCISgMQ+fS
         q9sqO7VnVssC8ZdNMRiHHyP5SiUWlPmGD7PTaZmpTfYC4/a06539AjRrkGyUFOiBhoX2
         cl5GLWXK4DtSbqepN7x48CI3rFPFRXpXgMI5M5EeBEXHbTpB9RJ/L6WReUlZQxFLIEut
         jnzg==
X-Forwarded-Encrypted: i=1; AJvYcCWw9OTjezdtDvEoKNBgs+0rNokBF0+Pul1KRhAI+p36PbmDRoIovsUoPEKBtfNARpQeHKaBKC4YuwFpmtdMj/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPcyunHjdYLycrWp/7ge7xWFFQCn7I3xc83OTdpi7/Mgtudp1
	deEVhRdtuutSqldlQCKWG1zXcads+VUvhi3Zh6s8/2UJ+jMU5MICYwRfSGEWekf2u6pDtUCAQO5
	jzkbWIGsuILHj3lX2P/mnbw==
X-Google-Smtp-Source: AGHT+IFLEEtCn1zkdoknKQC40EflQZ5HCAiPFEe4xIPUK0dlv/WJ0C7ai9MKNllw9+iA8ZkUhOs7ih4lNf6hYQC50w==
X-Received: from pfam7.prod.google.com ([2002:aa7:8a07:0:b0:736:ae72:7543])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c889:b0:1ee:a914:1d64 with SMTP id adf61e73a8af0-2044113e9a5mr1184451637.28.1745439949162;
 Wed, 23 Apr 2025 13:25:49 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:25:47 -0700
In-Reply-To: <Z47RSls2rr-xVqNk@x1n>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
 <Z47RSls2rr-xVqNk@x1n>
Message-ID: <diqzplh2zktw.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 27/39] KVM: guest_memfd: Allow mmapping guest_memfd files
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

> On Tue, Sep 10, 2024 at 11:43:58PM +0000, Ackerley Tng wrote:
>> @@ -790,6 +791,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  	 */
>>  	filemap_invalidate_lock(inode->i_mapping);
>>  
>> +	/* TODO: Check if even_cows should be 0 or 1 */
>> +	unmap_mapping_range(inode->i_mapping, start, len, 0);
>> +
>>  	list_for_each_entry(gmem, gmem_list, entry)
>>  		kvm_gmem_invalidate_begin(gmem, start, end);
>>  
>> @@ -946,6 +950,9 @@ static void kvm_gmem_hugetlb_teardown(struct inode *inode)
>>  {
>>  	struct kvm_gmem_hugetlb *hgmem;
>>  
>> +	/* TODO: Check if even_cows should be 0 or 1 */
>> +	unmap_mapping_range(inode->i_mapping, 0, LLONG_MAX, 0);
>
> Setting to 0 is ok in both places: even_cows only applies to MAP_PRIVATE,
> which gmemfd doesn't support.  So feel free to drop the two comment lines.
>
> Thanks,
>
> -- 
> Peter Xu

Thank you for reviewing and helping me check on this!

