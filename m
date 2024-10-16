Return-Path: <linux-kselftest+bounces-19896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B18A9A1642
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 01:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C387A1C21B2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8831D45FC;
	Wed, 16 Oct 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aoet//z6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17B282FA
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122581; cv=none; b=MIUM1ZdPsNa6VEPKQwaJgBUeeEjdvh7pYRV2nmAy9qqB55zyDz86UxsqwIZdAEbsYqvEynlKXJ9ytqytQW+BKf/EbJqgw5uU0Yxr7a3J3uvUzzXqZ7XHceJgXXORS1Q/gtCPhHebjWXQUem6GYu3udj8BQY7VMpdQ/AbtCagop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122581; c=relaxed/simple;
	bh=K3fXqvOYFiTV+YE1sJDtmSqPFLZLLnFs04oAxPQVYUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyaWWdxep1337eAF3imeRY3AmmBzJWARLgRp/n6phP0IUNJxQot4vLx67tT3VfcRXlX0ZpdWbnry8DDyBiJ7NkwFyc68FARLQUtpu5YYynVVGtWarh3eYafDXspMdIg0oM5fkuX4wXswOmsfnCp+YzHXhbn80oL1+ZuKkQzHlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aoet//z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729122579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdCmZ9Hln4F3TV8mrnoM2AWNUvAQWn+CFerwHQC2qPI=;
	b=Aoet//z6df3EZ5/K3ncRLDmGfx+TgCVSlE44xFn3VVI1CVsBXVmT7NedB5bIfiVkQX63rF
	Zw7PuCNP0nzOIvq/Zae153/eduCF+aOn+aMEcYmMNU2ZCkd0gfnSjspCqOkTwr9wHXT/f9
	0Sc9iv8IF6orCiE0W5vYuu81Zr3hjVw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-_xQnD0VsPeWvn_WxCoVQZA-1; Wed, 16 Oct 2024 19:49:37 -0400
X-MC-Unique: _xQnD0VsPeWvn_WxCoVQZA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbec7fbf1cso5187426d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 16:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122577; x=1729727377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdCmZ9Hln4F3TV8mrnoM2AWNUvAQWn+CFerwHQC2qPI=;
        b=s8D1UEVJNau2kr/Xvfpznz+q9mhlI4U3teOClxT7f/imqgWuHBZ1W18YyXDdYJmDbw
         fQ/8seLy7eILqNjCPOBOLoU6sNWICFNbl2R//dN8BQy2gvJSOaqkGIqRD9/okdmB2nXV
         Zb/jhCwX100dAZbNXAu5et9HDrZakcdQG8cPiAd1HpB7wNYsRpPkraio3niZarRvIGRk
         wz3pvzcwa0mETjJjoSxx02k+4hUEZpnA5gcmEngIFGNmzXFRJOt5f3232eidw/ATV3N3
         o0SbEbAOzo5U2glBmZPBz8j1s8tfB0+N8VTfz5iNZVuPqNPfBCx05qiXygEoqhpHfyXr
         Qc3A==
X-Forwarded-Encrypted: i=1; AJvYcCUOQkzT+IEBvzmb55ipcx+BI2dWreDfMMjbGRt0hagHPbtYY0l/2iapAudJ8odKzPkaY6in92CT4lWiXcCPM5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYaSsiVBp8XOa3UjHX5aUvmHCoLc9GNdiD/b1OvxaM62b4nJW7
	DCWQeC9kD8ELxrOL/pLDhsozQlMKk7wG6DsBc+vBG8ARqRptmnnWb0YtO8tvJ1KE9djIXsGM0k6
	OOF9NSYFmSX3wkLhKbc2nl9OWpWKbw7cdLELYwuqZS2TdC31sNAx+NVYAMI+57zU4Pg==
X-Received: by 2002:a05:6214:5541:b0:6cb:c994:160b with SMTP id 6a1803df08f44-6cbf0044c8amr256327666d6.18.1729122577436;
        Wed, 16 Oct 2024 16:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmipPb+bjkN1rVUXoFZ8wnXohSPm9OSuWjAO54jD6Ayz0Tg/8Zo1OktuIrYNhuOlrop+rkMQ==
X-Received: by 2002:a05:6214:5541:b0:6cb:c994:160b with SMTP id 6a1803df08f44-6cbf0044c8amr256327556d6.18.1729122577114;
        Wed, 16 Oct 2024 16:49:37 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290fa71sm22636456d6.27.2024.10.16.16.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:49:35 -0700 (PDT)
Date: Wed, 16 Oct 2024 19:49:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <ZxBRC-v9w7xS0xgk@x1n>
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016225157.GQ3559746@nvidia.com>

On Wed, Oct 16, 2024 at 07:51:57PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 04:16:17PM -0400, Peter Xu wrote:
> > 
> > Is there chance that when !CoCo will be supported, then external modules
> > (e.g. VFIO) can reuse the old user mappings, just like before gmemfd?
> > 
> > To support CoCo, I understand gmem+offset is required all over the places.
> > However in a non-CoCo context, I wonder whether the other modules are
> > required to stick with gmem+offset, or they can reuse the old VA ways,
> > because how it works can fundamentally be the same as before, except that
> > the folios now will be managed by gmemfd.
> 
> My intention with iommufd was to see fd + offest as the "new" way
> to refer to all guest memory and discourage people from using VMA
> handles.

Does it mean anonymous memory guests will not be supported at all for
iommufd?

Indeed it's very rare now, lose quite some flexibility (v.s. fd based), and
I can't think of a lot besides some default configs or KSM users (which I
would expect rare), but still I wonder there're other use cases that people
would still need to stick with anon, hence fd isn't around.

Thanks,

-- 
Peter Xu


