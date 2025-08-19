Return-Path: <linux-kselftest+bounces-39263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E836B2B548
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913D92A24F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 00:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C5327456;
	Tue, 19 Aug 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DicVXpmg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C722615
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562856; cv=none; b=UhJyam3+jrhPncv6aPRZ7nJTE61Rn6/07ekLJ9E/dplBI5ogYZ3MNR51MdckkO8kkMhfatlEq+uVvDdCeE+ai2a6MarCKixO5HwiIpa5PaSIuhxUcUeNiOPDQLi1PJ2HCgi4kfkh+p0U3wCol1Sd/N4kRkI2I6FOBYC6s2CinkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562856; c=relaxed/simple;
	bh=atJmxdGeijGiXSExn+ZNLici/r4lWKBuniPkNBYv9iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFDPUOXz+r0sJ0rf28l3ctKXhu/ndOftPCt/LPJauRsj/UCRt7ioO7WJWVZLH/TJJ6OeBsFbZ7NFkgTIPdzGQ6N3ACnIx2IeY/jOmOw2jg87oFt3qkfxbu3X8Tx356GvVpE197QkXfryvk1sLldhR3PNoVvqYFL8Qut188tBbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DicVXpmg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70a928ffd37so51080706d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 17:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755562853; x=1756167653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwm+TVO3IE31QnUKkVxKkaPevhmZdZk1VLFBsWnyn6o=;
        b=DicVXpmgkTQZjFi9nytWca1uPxFD0adbDO0MbcUZDIh+QxBPVHXnGnm5jSYJBx3rjz
         Xp4UFOB/mVd4gKDdr7l72RMeYBWSHR/MjfTL3JMMf6g1+VAZl5UJKat62zj3FQoar+LC
         EnG5WvUcOM+XHq6kx7BgWtR39XOzx9in4x9MX3qijuFuAeHWt/OFrTGDNAdKA50TOmYK
         4Hmel5GIQIQYbtgBRoVFediUGzHtdzQrOnHr2/PjnSvZCjowS+MWKlHiTdUKH3ZwVls0
         pCU3jefQzPwc3iKuS3MsQldYagbFCHxQ9pn+MHvm/RNBqY1pLPqwy4l0W09c1DiFr5CA
         C6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755562853; x=1756167653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwm+TVO3IE31QnUKkVxKkaPevhmZdZk1VLFBsWnyn6o=;
        b=Onfy+xGsrQ4gv6wZf0Jrmi9Nh91Wa/Z3HvEatvL5w/AObm4et6Jt9d7HCGyaSTKrAH
         xa2kWYqssALXC2QNVXvwKO0yzxDHH4F8jh0djavfTgG5EoP636gGnnhF28CgfUwSq5BX
         E6WCQJ15gqJB5kgIS2gMGsYH2U8k0Pa/PGUR50s7QqdsCj14YN3x9O81g9Qxyebqt0o6
         ZlAGJmNiQXoIElZVUsPvYpsurgSYYmQnt+Dpjb9Gu17r7k9RhucR24qRUN2ZWyiYgy7N
         hgXzIeHYWR2bfAwfFosLPDqAVhho4DojAjRRUWu2b474Hf19YfFnXjDM3iAcRqfqi2q1
         0T4w==
X-Forwarded-Encrypted: i=1; AJvYcCVWSP2JSmK+2RJO4jyTHK3dVs/Z8CGB5R/wH5w6Li35TKHWokv+OsBfZI8dboCzpaCfp+2qSdSbQxUTLXO1ts0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSxlkyYnAvd7f4S1Xo2uEdUlmjGWcEOfaU6jZMEg8HGI+y13r
	RiG5IR4DJJrpm1RPxSs+j3q2oUio3h6VggA78E7mh36GO/baK5KFL9+WbufevYF0GUc=
X-Gm-Gg: ASbGnct2KqSoZj/Sp1xNfJWZ9w187wOVGdFoo6shLzZTqcKiEPVZON/f475wp+FGp0w
	bNcWmKRKWoEuUbhPY98e5ryCmuizzdh5OMvml05KDiHBNawm0krHpShZRSCEGsEp/EIuQI56Ffy
	pibITxncG/dX+1Zz9rymk0iOzqIAih+Oa6P1Dwa7cg2SxaPLdhHwNniq/gnM0hmiU/BwFqg6JTn
	kkXdmq5JWYT0Znrad++Cc8J2oLmTW6qFjrZErvi6QROykAu37knS6yGxHtBrKxySVtgzCx7tYqm
	qeLL6O6YnFogVOd78OcJRf63dEvHjSccezR+QqXYEw9ozeC5NaPl946qZLCynS0iejv4u4Xmjvx
	u+IXDpRkh9TJHMcPn6dUvZAo=
X-Google-Smtp-Source: AGHT+IGUgrllTL7Y8fMaxyBiG7OjFs5eQq62OO4Qg66bHPzC0RUUqBKv3WgzNhUUD2BQ4eiTpGJ75A==
X-Received: by 2002:a05:6214:2b0f:b0:707:7694:4604 with SMTP id 6a1803df08f44-70c2b6f4f67mr8160386d6.30.1755562853487;
        Mon, 18 Aug 2025 17:20:53 -0700 (PDT)
Received: from localhost ([173.23.183.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92f89e7sm60632856d6.45.2025.08.18.17.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:20:53 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:20:52 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: dayss1224@gmail.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 0/3] KVM: riscv: selftests: Enable supported test cases
Message-ID: <20250818-be8ccd84eebf62dafa95caa3@orel>
References: <cover.1754308799.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754308799.git.dayss1224@gmail.com>

On Thu, Aug 07, 2025 at 10:59:27PM +0800, dayss1224@gmail.com wrote:
> From: Dong Yang <dayss1224@gmail.com>
> 
> Add supported KVM test cases and fix the compilation dependencies.
> ---
> Changes in v2:
> - Delete some repeat KVM test cases on riscv
> - Add missing headers to fix the build for new RISC-V KVM selftests
> 
> Dong Yang (1):
>   KVM: riscv: selftests: Add missing headers for new testcases
> 
> Quan Zhou (2):
>   KVM: riscv: selftests: Add common supported test cases
>   KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
>     `rseq-riscv.h`
> 
>  tools/testing/selftests/kvm/Makefile.kvm              | 6 ++++++
>  tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
>  tools/testing/selftests/rseq/rseq-riscv.h             | 3 +--
>  3 files changed, 9 insertions(+), 2 deletions(-)
>

The two fix patches need to come before the Makefile patch in order to
avoid breaking the build.

Thanks,
drew

