Return-Path: <linux-kselftest+bounces-34629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30892AD45E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 00:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0371784EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122C28AB07;
	Tue, 10 Jun 2025 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcPF2iik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910CC27FD73
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594307; cv=none; b=ESo8yf4Ik3wUfqgmw4tdq80ndPdjBjANbtXpx1OJKTBroOxPbCMTtNvWChiJJ+1ULtXtG7BlGkE+JyMM2fKLupAJZZAbMIkzBooIwiZ9tauEY/2mH8FUk2Aiqz/uRzWXRf8Bsv3yNb1pM2NriTPHaiNKMjcmdutVr2lL5EeLTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594307; c=relaxed/simple;
	bh=XjgsdEhFvFB0B+RbA+5aNhRmFbtruOCW5OEOXUP/KY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CddpVCWIfOrwRbj3m0jVsy31AZYmFRx/DBe1pWLpW7I2IyhF75gcysmIYzHyhFXJXEiX74eQFUBhwJNZlw94QF2jEh496PjgiFevIIEfI6HPwf4TlXhXVGF716MbK2UuSmfZltN7N34od1Yru7oIUA58ZtZfaWykfIfO7ObW85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcPF2iik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749594304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLuQnm8GtR1mcurBIw5pIZijzYYYehwuFe+H/mrbon4=;
	b=AcPF2iikSz74O82QOvkNbWcKoPz52MxNfVCMrY3MJD0qjtSm6CFRqb3wbzGROS19qV7jAQ
	WoCIq1K2CIJgVZk5hu+ETV+18SOYL7Tb7PS9tWmTSTzOaAdkukwKCshib3sSRMpF0U/Hjx
	HBG6kVlEvQF4xrDYVBn/364i9zVouWU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-lMrI3odPNH6hGJWUMkub4g-1; Tue, 10 Jun 2025 18:22:42 -0400
X-MC-Unique: lMrI3odPNH6hGJWUMkub4g-1
X-Mimecast-MFC-AGG-ID: lMrI3odPNH6hGJWUMkub4g_1749594162
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2e9b472cfd1so5844280fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 15:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749594161; x=1750198961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLuQnm8GtR1mcurBIw5pIZijzYYYehwuFe+H/mrbon4=;
        b=uU15SsNYOms04U+bK+4EfqH/u4Stqppmn2stLeUq9Z3+2TIsUhGfenqbLkJj1jHguN
         wQuhSDp1mO3WJgmyru9/T4O9nekp7JV5CHsO3wO9eKxWKn8FmOrHfs5/ZBnqI49lN5Gd
         Rf/9ciIvUKHZIafW2mW4G2RwJtbprYm6mtTSK5I8mH461wh0GlxaiLAZSbscyFLma4Fw
         d9hez5m0uQ/7m7tt6M6GyKMPkW5S0v3XHYeI/7l1g3TeskkdrzGb5k7Qd+L9OPET/Poi
         QNKfYbTveUIcwAu3Q4KoM/nF/t/DOLeCYqonAVzN2cOhdQf0cXm8KNYCFiObupBUKkPy
         dtVA==
X-Forwarded-Encrypted: i=1; AJvYcCUDQghXM0jMU8XR3pOF6pNykwsiOHwNRGW4hXKesh7iMOXBPDQ7hwVyujxZk0DbeiaVezhUhZUKezcuXIA8DOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6vnf/LALSkRrigzze/YhC20D5I5NfCHh4a6M/Q7S2Au2Qu1L
	k5vPbppM97BDfCMHKZdvcRXoLWYaZB3yc5s+ENIAHS6MwjEnjYS6jgrRGR72F8KywsupfWKOA7X
	VIhfrx3uNzWwA2DkMV0baE/6T03344276AibZtgLeBiDRQZehHbupcx1v7XVsXyyO4o6fpNBTIp
	+idA==
X-Gm-Gg: ASbGnctVpdFyfJWFULd/VKOUolyweFETtRisW6YBoRd2x5ufCGXl1XWU2MeywgSiD+/
	f4lMzKC0UYug0u4GbhM96OplqceOCeIo5mkESpHQ8ktEa3fjv54hqL8YKAy9l34IYzMukOsLyL2
	jrLyy0WC9FBthPMw+c4Bid2PIxGSV20wk3iSiIPt5Mfh9CcIKgBMckIPnvFz95T2WBz/Oa/5Se+
	Bqn8Nc9ZQd5wAv/2cBrkKqg7VEk6fahXKEKJWRMxefJsl1pmNhG/wg7Su1lrlPB8D5e3Cn/5J5R
	gHB6lBTiGEZQNw==
X-Received: by 2002:a05:6870:240f:b0:2e8:f216:7b23 with SMTP id 586e51a60fabf-2ea96e8b7a1mr595970fac.37.1749594161210;
        Tue, 10 Jun 2025 15:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZPFHzLV7Sg4ZkCQBoFbsxw1VThpMG4z5lPpBVju0VP9CmUB6NZzQ74WH9fhjymqKd3HA8wA==
X-Received: by 2002:a05:622a:a18:b0:494:b924:1374 with SMTP id d75a77b69052e-4a713c4544cmr20646161cf.43.1749594147540;
        Tue, 10 Jun 2025 15:22:27 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a611150cb0sm78624171cf.11.2025.06.10.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:22:26 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:22:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	hughd@google.com, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
	jthoughton@google.com, graf@amazon.de, jgowans@amazon.com,
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
	xmarcalx@amazon.com
Subject: Re: [PATCH v3 1/6] mm: userfaultfd: generic continue for non
 hugetlbfs
Message-ID: <aEiwHjl4tsUt98sh@x1.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404154352.23078-2-kalyazin@amazon.com>

On Fri, Apr 04, 2025 at 03:43:47PM +0000, Nikita Kalyazin wrote:
> Remove shmem-specific code from UFFDIO_CONTINUE implementation for
> non-huge pages by calling vm_ops->fault().  A new VMF flag,
> FAULT_FLAG_USERFAULT_CONTINUE, is introduced to avoid recursive call to
> handle_userfault().

It's not clear yet on why this is needed to be generalized out of the blue.

Some mentioning of guest_memfd use case might help for other reviewers, or
some mention of the need to introduce userfaultfd support in kernel
modules.

> 
> Suggested-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  include/linux/mm_types.h |  4 ++++
>  mm/hugetlb.c             |  2 +-
>  mm/shmem.c               |  9 ++++++---
>  mm/userfaultfd.c         | 37 +++++++++++++++++++++++++++----------
>  4 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6..2f26ee9742bf 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1429,6 +1429,9 @@ enum tlb_flush_reason {
>   * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
>   *                        We should only access orig_pte if this flag set.
>   * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
> + * @FAULT_FLAG_USERFAULT_CONTINUE: The fault handler must not call userfaultfd
> + *                                 minor handler as it is being called by the
> + *                                 userfaultfd code itself.

We probably shouldn't leak the "CONTINUE" concept to mm core if possible,
as it's not easy to follow when without userfault minor context.  It might
be better to use generic terms like NO_USERFAULT.

Said that, I wonder if we'll need to add a vm_ops anyway in the latter
patch, whether we can also avoid reusing fault() but instead resolve the
page faults using the vm_ops hook too.  That might be helpful because then
we can avoid this new FAULT_FLAG_* that is totally not useful to
non-userfault users, meanwhile we also don't need to hand-cook the vm_fault
struct below just to suite the current fault() interfacing.

Thanks,

-- 
Peter Xu


