Return-Path: <linux-kselftest+bounces-28333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBEAA50C8C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27858188E1ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C182580DF;
	Wed,  5 Mar 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpgI5G2k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED972566DA
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206575; cv=none; b=XsmFZK0JnnfbWgAuhUD2pUf3iyaN/Hru5JSb3fapwKsiMjjKaSTESTUO6Yqk0peqoZ7ivg5ZxCMavsESBhnq3/BCH+CaDnRQ94gTUhkXyJDYF2Nu48KR9QGt+gZJZj4G3p1P6j085MMVGil0Fp5+2pc98Z7tjUk6JWcJxMjKu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206575; c=relaxed/simple;
	bh=2YVWFyfkS3CQD7maRiKkuIwzWsd29P7CBa7g4mJPku4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxCrjhQfof8N6nThY7xs05PwHpEhD++yTVr3YPIHigvtetfoKflKgX90bfHhYHSwL5tv9NEhMjwslQUVIermCCWBRM21sAtLzm4RdjqbyXgykQavZr8tZTv423eY30hOj2XImIdpjXe+xeB0iu1bHHnlzr9RDJOgwi6uCzTS1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpgI5G2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741206573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oalwxEzZmbkO3BEyiEOSG53V47EPWxAbwPV2MRYZBwA=;
	b=JpgI5G2k3wGwk2yDu8rH7O1WJSyB4ReHfdBs9pnhFOIbMcb50or6Ibv/2SYfluM5CPXAVm
	GGUEyIEezD0T75wtnULBK/wxNWTyRBrG97vwVhfP7kuPVFafZo7sQjxK2VEhOOMtQi9uMm
	6yWweGcgUaJoenk5tzGv0v5ZsxMmSAE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Bo6vG_qgOeOd_aEUHuWl5g-1; Wed, 05 Mar 2025 15:29:22 -0500
X-MC-Unique: Bo6vG_qgOeOd_aEUHuWl5g-1
X-Mimecast-MFC-AGG-ID: Bo6vG_qgOeOd_aEUHuWl5g_1741206561
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e88964702cso25181646d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 12:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741206561; x=1741811361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oalwxEzZmbkO3BEyiEOSG53V47EPWxAbwPV2MRYZBwA=;
        b=SX+pbrjtJ1hcFc3IsgBSzWG9HrTuOXrAL1N+Oxg+7CH3No2iiIEKoarB4hKwjNt2Ga
         +hEYlgiy6+gQ1hjWAGhu+g6bSwkMqCjgPq1y9snqLWM8Jga6o7i8s3p5zyv3ziJ5ix4k
         BEmQy5/WoSSmPOvkcPN0Zc2EBtHLtmGwHNqj+8yi6k44NBtzRmc9r2UuKUvj03snZVTo
         er5QH+h8OqI91SIPB9PBvY2sZpmdLkYNJb3nv06MGLjREOorfUdT7G4Po0ukC/RFuJ04
         3l6H8p0LnHpLKjKbubrCHvjNaehd0sgzfseq5L5MQiNq8xbdJfCzPWyxI3ybgy+yChAF
         ApVA==
X-Forwarded-Encrypted: i=1; AJvYcCUBcDrHrhkwZ5EmuFLO8TQ7qOPDCN4xcdvWizp/7OA35wj4Q0D8jaR80NFPoSNbVAfCBAUVXjs1orpTqMkdywU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mbkFKJ7VvK4wEdjISjh5nja3YGABZ07K2ws6NlF8+DGYpD8N
	gHtRU9KxevJ3qapx2+4j3HHN/C/WZzbVd/o+KSKDXyvBWRmL3dHWd3OohQo863GI9b4MsaR8q3z
	olbgpeqHAwMHfJnVFJ/2ceyBVJLTjRjk0oEfmj/l9/x0ei0K/cBXB3DWvz19V1AGIPg==
X-Gm-Gg: ASbGncvHoWNn7X0fj6HHop0cpyUNwMOUrnqe2PCMIrUUasOWa5Gr50FKi0AqBzkJjxX
	p0xXB2IXtta+tqo17PQVN43e7/dOj9R9AXmEuT1cO1M8uFeOgjRK3Ij2EemzbGGogvIFuHEnoGB
	IV7L3dkQBTewNgC7Cn7+Eq1uakyCHZY1YrtPZ+0NhvlX9QUmOQc4kA/MIef+FHg+FQX0urXQJw+
	dshLeGdkcYZkSRqAw+Q21Oyc0Ppz72hohbx3P5PvNCBWCPPpDjdEQDcgaY6HUzDxgTAEnu+BGmR
	W2fDB/U=
X-Received: by 2002:a05:6214:21e3:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6e8f46d5cd1mr8079986d6.8.1741206561647;
        Wed, 05 Mar 2025 12:29:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzj3VnzDaaIbvAFjVufn5nGxmexz91QgKSdKtxQ40yVUP2gqR5kYn2qDKbFG2xC9ZTZ7Hnpw==
X-Received: by 2002:a05:6214:21e3:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6e8f46d5cd1mr8079756d6.8.1741206561335;
        Wed, 05 Mar 2025 12:29:21 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm82983196d6.88.2025.03.05.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:29:20 -0800 (PST)
Date: Wed, 5 Mar 2025 15:29:17 -0500
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: Nikita Kalyazin <kalyazin@amazon.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z8i0HXen8gzVdgnh@x1.local>
References: <20250303133011.44095-1-kalyazin@amazon.com>
 <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>

On Wed, Mar 05, 2025 at 11:35:27AM -0800, James Houghton wrote:
> I think it might be useful to implement an fs-generic MINOR mode. The
> fault handler is already easy enough to do generically (though it
> would become more difficult to determine if the "MINOR" fault is
> actually a MISSING fault, but at least for my userspace, the
> distinction isn't important. :)) So the question becomes: what should
> UFFDIO_CONTINUE look like?
> 
> And I think it would be nice if UFFDIO_CONTINUE just called
> vm_ops->fault() to get the page we want to map and then mapped it,
> instead of having shmem-specific and hugetlb-specific versions (though
> maybe we need to keep the hugetlb specialization...). That would avoid
> putting kvm/gmem/etc. symbols in mm/userfaultfd code.
> 
> I've actually wanted to do this for a while but haven't had a good
> reason to pursue it. I wonder if it can be done in a
> backwards-compatible fashion...

Yes I also thought about that. :)

When Axel added minor fault, it's not a major concern as it's the only fs
that will consume the feature anyway in the do_fault() path - hugetlbfs has
its own path to take care of.. even until now.

And there's some valid points too if someone would argue to put it there
especially on folio lock - do that in shmem.c can avoid taking folio lock
when generating minor fault message.  It might make some difference when
the faults are heavy and when folio lock is frequently taken elsewhere too.

It might boil down to how many more FSes would support minor fault, and
whether we would care about such difference at last to shmem users. If gmem
is the only one after existing ones, IIUC there's still option we implement
it in gmem code.  After all, I expect the change should be very under
control (<20 LOCs?)..

-- 
Peter Xu


