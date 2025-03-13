Return-Path: <linux-kselftest+bounces-28989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E908BA60478
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 23:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B3E189FFB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5E1F4C9F;
	Thu, 13 Mar 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA98R1Sl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BE1E8329
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905495; cv=none; b=KTs2vyJ0MhYaxh7KvHLI7cBN7cKLKAOBu2a4G3QdxVVf//sJwqSgfkFcFURNT5l2Gkxt5h+vPz1qNxLdNnc9MO1Dbx77F2KWI1dIVrkDcIWT8hRr/nKb5EZ+fdeU0i753FPdmGoCWhAkFsf6y9cftQw9STPdbFC3tKxfgk51GRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905495; c=relaxed/simple;
	bh=DSWQgIJ7FXheJ8gYzjYJfYWpUIUUzmSGNhkDx6tGNEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTMKhbP1r8ePdUqe0rnmtZ3SqfJWsKtcHEvTH+HeplPgEi7/0akJp5mG4/Fv08z4YYJGe7a4Sgww0B0PeOWvd74L7J0EJQqQhIE6ciBItFA7Ny1RJdfGayX6iMxygB2R3sB3H1kE0tO7USq9p850T5Ee505MuXqfQhUBZw+IcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JA98R1Sl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741905492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFzr4WLi5EWJd9Q1lyDlYMS58+KhEJhXt4VWqBCulsA=;
	b=JA98R1SlWlV5Tg2+6aQ3PLxtAUHBhEcsJzfxNQOk+BllZXsShBDiCm3ZKzkys13Aw58upT
	2bga0eRAqoeXgzxwokxIj5i+rFBoEy7jHLmek6Z4Y0NXa51oK2RXmE/Fa3QP/AvTATedJ5
	P9WFIW/5yXQTudpDSsvOTpKH237WgzM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-VCKF9WovOue3OePDANLqDg-1; Thu, 13 Mar 2025 18:38:11 -0400
X-MC-Unique: VCKF9WovOue3OePDANLqDg-1
X-Mimecast-MFC-AGG-ID: VCKF9WovOue3OePDANLqDg_1741905491
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e90b13f5c3so31511586d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 15:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741905491; x=1742510291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFzr4WLi5EWJd9Q1lyDlYMS58+KhEJhXt4VWqBCulsA=;
        b=BbRGzV9bARkIi1a9JvfkT2BgZkrvabz7bUdvE1NjbcKkiGXIeh/lEDCHbFBJVoOidI
         7FNEbrj47LqscU0XKl5bugf+GalIacKps3Dc5lYjc1gAGCGdHtQEgX4Nv+RegAK6bw4a
         fOvkXXlKf/Dtv7YkcgRxo7VoaL4EkptcNrlWtSgDKPQJ4aYibN+XD/plrr0Q52nrO8sv
         7GDLC56dkxCN4kBg3bso2s8KjyDnwDIr6pXOr/zTIHQDjDXSTp+Q0REr6dkRe8nxwBdN
         HjcVfAbiaUUBEvG5JYTtmA8vOEbdZdR/RiSqC8pfw3KlahptC3yGyZi87pYhLJIyX0m0
         /T9g==
X-Forwarded-Encrypted: i=1; AJvYcCUbmDz/HhkH9ImtVNIMUaFvwxIJiX6Of56ycQKn8p1eUe94r+eNqp5YyyJekZhf6NCVw8eQw+4vrLOy2LGJKzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2CiLY2aS6i9xJ62hsHTrn8oLErESHZElUCqFZWzKHhuEMrSs
	HQYhW3EuVn5HfE40NGBmlSxPJaS1/JknpTBJ4ZHcXQ7uRHSVel2z4HkVeW3XBfbMVoqB1lziaLR
	wHUQhDpecuVAcANCNitbndmnVPAW0d9ziP/xtQ+nvzqmD4n8L3c9+SWPQCsvpuSwkpw==
X-Gm-Gg: ASbGncsmJyB/Mw3qxss4iQkswhX788V/aMP/VMBb00FXBZlWBHt0gpiUi/ND8zRBr7c
	MVsAFcQSg2O8nUlLgGopbouhT0MO5VxWFpPJRMDq21ObdhmC6T7HNcMsLgWhjVRiTjByPzxAXpf
	xzetYfubROER3UVnBXy1oIX1V4Y2d2bYY/KKwcYjX7t3C0B3mm1YZUYBuyFvi5ZfOqBOSszCblp
	mluFleQS6uIyjI8HhNPrPZorE2RkbxpmD9aAwuQlIQ/dKFjouifi42d9lhmQmJXpLTyk80aqK5D
	tephTrE=
X-Received: by 2002:ad4:5d65:0:b0:6e8:e8dd:30d1 with SMTP id 6a1803df08f44-6eaeaa5fa9amr2466946d6.22.1741905490927;
        Thu, 13 Mar 2025 15:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBXIseFJxXyT7V3i4JYoBiq0nyGeT0Insspj8UcFpuo+ZEN+6NwuINfQg0ot8cSpabuM7JsA==
X-Received: by 2002:ad4:5d65:0:b0:6e8:e8dd:30d1 with SMTP id 6a1803df08f44-6eaeaa5fa9amr2466586d6.22.1741905490665;
        Thu, 13 Mar 2025 15:38:10 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade208b20sm14700356d6.9.2025.03.13.15.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 15:38:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:38:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: James Houghton <jthoughton@google.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z9NeTQsn4xwTtU06@x1.local>
References: <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
 <Z9MuC5NCFUpCZ9l8@x1.local>
 <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>

On Thu, Mar 13, 2025 at 10:13:23PM +0000, Nikita Kalyazin wrote:
> Yes, that's right, mmap() + memcpy() is functionally sufficient. write() is
> an optimisation.  Most of the pages in guest_memfd are only ever accessed by
> the vCPU (not userspace) via TDP (stage-2 pagetables) so they don't need
> userspace pagetables set up.  By using write() we can avoid VMA faults,
> installing corresponding PTEs and double page initialisation we discussed
> earlier.  The optimised path only contains pagecache population via write().
> Even TDP faults can be avoided if using KVM prefaulting API [1].
> 
> [1] https://docs.kernel.org/virt/kvm/api.html#kvm-pre-fault-memory

Could you elaborate why VMA faults matters in perf?

If we're talking about postcopy-like migrations on top of KVM guest-memfd,
IIUC the VMAs can be pre-faulted too just like the TDP pgtables, e.g. with
MADV_POPULATE_WRITE.

Normally, AFAIU userapp optimizes IOs the other way round.. to change
write()s into mmap()s, which at least avoids one round of copy.

For postcopy using minor traps (and since guest-memfd is always shared and
non-private..), it's also possible to feed the mmap()ed VAs to NIC as
buffers (e.g. in recvmsg(), for example, as part of iovec[]), and as long
as the mmap()ed ranges are not registered by KVM memslots, there's no
concern on non-atomic copy.

Thanks,

-- 
Peter Xu


