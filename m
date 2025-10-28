Return-Path: <linux-kselftest+bounces-44205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A1FC163F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D963AA881
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A23321CE;
	Tue, 28 Oct 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Iu8/a+C4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244A2727E2;
	Tue, 28 Oct 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673197; cv=none; b=OMPkcQC0Nx2GCZ/FR6rQEvZ+eEtv6XdC17n3+oj34XUTFUMpG45aN95LCsQ3wexhEwUHiJmsszgohTW+sXrNUa7c7NqbhPcRsmH/Y0TloM4HZmYCOUWhTjL252gsQQBrm/92+iJj+sPs7kpYo4o2yowc3dqCyZ4QeRPu6uG58no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673197; c=relaxed/simple;
	bh=3L4sQ+n0iCERodipuq4cDSnVAbS79qllvuLvEuRLRoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBJf0jm3vf5QEIeGXLuyaVWpLmmMM4wzpMhOFaMFQeyn0uYNZkbyYcg1mK7NCLShHpQCTNLSMa9BEOWdBWzNsY7kz8C9mp61tWpyKUvlD5Kpdy3UdMFBCwiPDWgSGouJ4wDDzrBQTqEFzjYOIgMLIJblIKWGhZsN4L/ZP2Kftu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Iu8/a+C4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id CDC4E200FE6A;
	Tue, 28 Oct 2025 10:39:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDC4E200FE6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761673188;
	bh=lGRetVmr1LlkyFgDzb6rTopLa8zqATdxCQN9LlITDAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iu8/a+C4j2dICZulfzHvt3zxTWTziHiZrzuxnC+WjIDUGjrZ8EyfGhTla40Vw82la
	 IDKDiwejtx4XNgvpqS1CxyGUcocDFcFEvi20fQGmIddCRqpM+KpD1IqkOuolbgyPw5
	 IMxsmpfF/a8hg4f+HF7LBh4buH0iRoCPitECm5xI=
Date: Tue, 28 Oct 2025 10:39:45 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
 alex.williamson@redhat.com, pasha.tatashin@soleen.com, dmatlack@google.com,
 graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
 chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
 saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
 david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
 epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <20251028103945.0000716e@linux.microsoft.com>
In-Reply-To: <20251028132855.GJ760669@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
	<20251018000713.677779-7-vipinsh@google.com>
	<20251027134430.00007e46@linux.microsoft.com>
	<20251028132855.GJ760669@ziepe.ca>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 10:28:55 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Oct 27, 2025 at 01:44:30PM -0700, Jacob Pan wrote:
> > I have a separate question regarding noiommu devices. I=E2=80=99m curre=
ntly
> > working on adding noiommu mode support for VFIO cdev under iommufd.
> > =20
>=20
> Oh how is that going? I was just thinking about that again..
>=20
I initially tried to create a special VFIO no-iommu iommu_domain
without an iommu driver, but I found it difficult without iommu_group
and other machinery. I also had a special vfio_device_ops
vfio_pci_noiommu_ops with special vfio_iommufd_noiommu_bind to create
iommufd_acess object as in Yi's original patch.

My current approach is that I have a special noiommu driver that handles
the special iommu_domain. It seems much cleaner though some extra code
overhead. I have a working prototype that has:
# tree /dev/vfio/   =20
/dev/vfio/          =20
|-- 7               =20
|-- devices         =20
|   `-- noiommu-vfio0
`-- vfio            =20

And the typical:
/sys/class/iommu/noiommu/
|-- devices
|   |-- 0000:00:00.0 -> ../../../../pci0000:00/0000:00:00.0
|   |-- 0000:00:01.0 -> ../../../../pci0000:00/0000:00:01.0
|   |-- 0000:00:02.0 -> ../../../../pci0000:00/0000:00:02.0
|   |-- 0000:00:03.0 -> ../../../../pci0000:00/0000:00:03.0
|   |-- 0000:00:04.0 -> ../../../../pci0000:00/0000:00:04.0
|   |-- 0000:00:05.0 -> ../../../../pci0000:00/0000:00:05.0
|   |-- 0000:01:00.0 -> ../../../../pci0000:00/0000:00:04.0/0000:0

The following user test can pass:
1. __iommufd =3D open("/dev/iommu", O_RDWR);
2. devfd =3D open a noiommu cdev
3. ioas_id =3D ioas_alloc(__iommufd)
4. iommufd_bind(__iommufd, devfd)
5. successfully do an ioas map, e.g.
ioctl(iommufd, IOMMU_IOAS_MAP, &map)=20
This will call pfn_reader_user_pin() but the noiommu driver does
nothing for mapping.

I am still debugging some cases, would like to have a direction check
before going too far.

> After writing the generic pt self test it occured to me we now have
> enough infrastructure for iommufd to internally create its own
> iommu_domain with a AMDv1 page table for the noiommu devices. It would
> then be so easy to feed that through the existing machinery and have
> all the pinning/etc work.
>=20
Could you elaborate a little more? noiommu devices don't have page
tables. Are you saying iommufd can create its own iommu_domain w/o a
vendor iommu driver? Let me catch up with your v7 :)

> Then only an ioctl to read back the physical addresses from this
> special domain would be needed
>=20
Yes, that was part of your original suggestion to avoid /proc pagemap.
I have not added that yet. Do you think this warrant a new ioctl or
just return it in
	struct iommu_ioas_map map =3D {
		.size =3D sizeof(map),
		.flags =3D IOMMU_IOAS_MAP_READABLE,
		.ioas_id =3D ioas_id,
		.iova =3D iova,
		.user_va =3D uvaddr,
		.length =3D size,
	};

> It actually sort of feels pretty easy..
>=20
> Jason


