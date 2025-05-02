Return-Path: <linux-kselftest+bounces-32153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51760AA6BA5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63A14A6D81
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 07:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C92222A0;
	Fri,  2 May 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdqG+Fwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FE1A5B88;
	Fri,  2 May 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171079; cv=none; b=Bht+KkFO05sJsNlXffbFKEF3AJl1lrqFuhiPCOGZ+IkRtBcnHq14ZBCDS4F7W4Qx9IyGz1gxpOHfJG7MuecP0pZfeAOw6vZCFaGNNfCYdkkLVb6zPvq/Il3Qfe0R1MOk1aKCBCCPuJc3EgXZJMKKYcVP6QpTAlC9zXAjWRkIJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171079; c=relaxed/simple;
	bh=wtoQr0xWC7SiqYlR1iiTaHqZi3kSYO3Wq5NsfIXggRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvmMyxEZ6I8jf1i09nkkDZBHazgZEK2GFDUo9cm6+kWymEougB+r2MBa2MOUXjTXHHu/N1ra2p9+slHQErc7/ig6z6ZTmh/1JquT0vijub3ISFcZdzbeN+dGilIUoZ9RD8PVkofdJ6VjmSuQXKIRkome+xhRCj+/8r97xq9tfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdqG+Fwy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22435603572so20241505ad.1;
        Fri, 02 May 2025 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746171077; x=1746775877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhyG+qPql1C6VOEStks/G335oAHhX6Klfc0SAJXR260=;
        b=KdqG+FwyuPZx7cr9Qv2cDQSRFJ7Ghy/9mz0uQq40At0o8lY7LzQ3NuDDlc5edKE0Tj
         JkQ/Tvi+N/5aj1EKnd5xKpvZg/jK999Fc1mgqIds4z1z4WISOrCNBWwv/XxphBAPgCcE
         qYaYoZu9ZdhAb3kkFVTn563I6caJmK65CvDDJBA1XqWt3lMGkfAgg5PttS4ScZj8Dgtu
         0cQ6+/tl3cw5yIM1QclAIJIDq/xiLcqFxRyONolF2oSv/8d+Kq5eE7YpRofuZQLKMtH0
         29Z+C1/78MMAiSISScy3XXu7IA+XFRRmeN8Pa5r2cDqS2ZijTh55gYPf9RSzM3D0Xv0v
         t+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746171077; x=1746775877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhyG+qPql1C6VOEStks/G335oAHhX6Klfc0SAJXR260=;
        b=ZjAuazlb4qNvgp1wj1KQhzGO0Z5YVjYa6IxnKqTlfyTFlmLRVrv5ZJ/fh4zXFmk4Jc
         ig2el3yLoYdHukROUiwU66IyNQbSA6p0fxIxBDrbS0j/+vA/Hj/izdzbsBQ4Z4joSyQc
         D450GdUA7xkxwfFp6WPhBvvs6jdQPcL/zyTlaKOPDAvXiWHpVkgTRu8i0MCc62uYt2r9
         cf+zReKEDYc0R3HXADvXiNkDkLeczntFQtwXSMgFpKiGPBmztIOU2gvsuQjl5HnYOgJe
         uDQTnBb1F28xZB/eFEzeTOjFfN2oZLJFqHNqgu9eHOHa/OIQrJQ02JaA75WfVNaGNxhN
         Y3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVVR30b/sHtpVdCNqUlIbchncu7XuvdOEwhlc3G3He6w7qv7DxVbx91oiEoqaBdSVpRSf3r2zy6Zzc=@vger.kernel.org, AJvYcCW1FCaK5S4AZslQmImhkquByBiQlERYmq4MgVxKKcNjAa/JVbcjepWGW2aC8fLpjt1n+/xLEOPAB9Bptp/u@vger.kernel.org, AJvYcCW72uvveCSxlRYCC6NH0+PHIhlYzw6mo9+8UtRBw1BXTGan03kzaHr6KzObY1j5MpUJeSJnd8OBHLc8TSI=@vger.kernel.org, AJvYcCXwuc/7e3mjYhvIGiCyfL4B4A2354O6BbknvxuDzOno3g0uFdCGdWwLcX8C/3TtiodTndtMKDIn810NoILlYOhX@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7Oijcb2IPNQoRM/xxe+FoNrQ6kVbE7D54h1fGICpHd4iUP3y
	vfj0A97XP1u6PC8FN385iTp36jUkL9A34HaSvfrb+pcKBMHQHGOp
X-Gm-Gg: ASbGncu25O3ALcydYRuE+WXqdiW4n62WZCN9g5jVUDLGG9igbNaDb2huHbg3fH0l4bT
	/aQ9+a2e1b83EPXTOlOkomsqZ9NShRBppy78/qRR/V/KRpvWkYkah0dnm+DtQxhVYO6RTYYkQSe
	WVoYy/Hlduxa2TeeOZWeYlvLOyM8mhDQ0IvY3LQhOsjjVvHySwZyZ3cFdt3gmUtFO6w7VmmUOdu
	uhCRCjzpGbBcLtciBQ31DygA355hKKQdSkBp56hSGHjSUU5t3fs6tONFo3JIvVcPv/ZLInNcB50
	Mb4uq/w1AoPO7YHrdOoocjkmdUewZ6AKlKuJw+S1
X-Google-Smtp-Source: AGHT+IH52a6BgPoPUu5N1D3Rb40EG6pjnTkV9nhRgxYGSZyv07U3fjSm8A6SXkBygATuXX2l4VA+sQ==
X-Received: by 2002:a17:903:2f91:b0:224:191d:8a87 with SMTP id d9443c01a7336-22e1034418bmr27532815ad.26.1746171077036;
        Fri, 02 May 2025 00:31:17 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522f7c8sm937775ad.228.2025.05.02.00.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:31:15 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B8C52420A6AB; Fri, 02 May 2025 14:31:13 +0700 (WIB)
Date: Fri, 2 May 2025 14:31:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 16/23] Documentation: userspace-api: iommufd: Update
 vQUEUE
Message-ID: <aBR0wWzQablOklyW@archie.me>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <0beddeaaa4a8a7a45ce93ff21c543ae58be64908.1746139811.git.nicolinc@nvidia.com>
 <aBRA75V9l9WlI2Q3@archie.me>
 <aBRYVkOKfFGMb5Y+@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vde97DQHR/3Yogi4"
Content-Disposition: inline
In-Reply-To: <aBRYVkOKfFGMb5Y+@Asurada-Nvidia>


--vde97DQHR/3Yogi4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 10:29:58PM -0700, Nicolin Chen wrote:
> On Fri, May 02, 2025 at 10:50:07AM +0700, Bagas Sanjaya wrote:
> > On Thu, May 01, 2025 at 04:01:22PM -0700, Nicolin Chen wrote:
> > > +- IOMMUFD_OBJ_VQUEUE, representing a hardware accelerated virtual qu=
eue, as a
> > > +  subset of IOMMU's virtualization features, for the IOMMU HW to dir=
ectly read
> > > +  or write the virtual queue memory owned by a guest OS. This HW-acc=
eleration
> > > +  allows VM to work with the IOMMU HW directly without a VM Exit, i.=
e. reducing
> > > +  overhead from the hypercalls. Along with this vQUEUE object, iommu=
fd provides
> > > +  user space an mmap interface for VMM to mmap a physical MMIO regio=
n from the
> > > +  host physical address space to the guest physical address space, a=
llowing the
> > > +  guest OS to control the allocated vQUEUE HW. Thus, when allocating=
 a vQUEUE,
> > > +  the VMM must request a pair of VMA info (vm_pgoff/size) for an mma=
p syscall.
> > > +  The length argument of an mmap syscall can be smaller than the giv=
en size for
> > > +  a partial mmap, but the addr argument of the mmap syscall should n=
ever offset
> > > +  from the returned vm_pgoff, which implies that an mmap will always=
 start from
> >=20
> > Did you mean never be offset from returned vm_pgoff?
>=20
> Yes. Will fix this.
>=20
> > > +  the beginning of the physical MMIO region.
> > > +
> >=20
> > Confused...
>=20
> Meaning that VMM should just use the given vm_pgoff as is, without
> adding any offset to the vm_pgoff.

Understood, thanks!
=20
--=20
An old man doll... just what I always wanted! - Clara

--vde97DQHR/3Yogi4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBR0wQAKCRD2uYlJVVFO
o2GmAQD6yTz+9Kdn/nHALYBCiSbtX+ewWJjZ0spXlFlQyWBmSgEA9HdlnssGmaCv
oibhf/yiDjC4MkNfQVDV7Jw5qTjhagQ=
=zmrU
-----END PGP SIGNATURE-----

--vde97DQHR/3Yogi4--

