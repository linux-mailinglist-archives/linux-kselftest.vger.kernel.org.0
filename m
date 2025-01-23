Return-Path: <linux-kselftest+bounces-24987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ACEA1A053
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 10:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D141188DB4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86820C48B;
	Thu, 23 Jan 2025 09:07:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056A20C004;
	Thu, 23 Jan 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737623224; cv=none; b=IMwCRc7rmgZ5/PtfVMoPaJwfGvD2CqmMHxxYnze5KtxACAsb8tmM+vjydy5lozi8f2wCvyFNpvzldRmBDexdeaFk5Cm5oc089wyL2wb/LLMpLzt+fBhvEp8Mt0giI1fV06qlzX2tmdFVY71rU8OsIzid1Ok9cU30Vmt8gxjVZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737623224; c=relaxed/simple;
	bh=jsYgGwDXjoD7lbJi5TWtQno9T386TZfovqcenXGzaD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTIQ63M/Mhx5mVbn4gA70x5MchJ5wCCPNTiXz+TphLHo9sQAfOuC8yC9ff1Mecp1j7hqtyq2OsmvBC0nfEx5E9nnyp0sO7nJzGJWegR5FxaybRQgMrMjKrfAUCyB/UxIXtWjH4DAqgjku+voIowgTlpalwXQPwfrJRgJQJwz038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ydw5q0xrkz1JFR3;
	Thu, 23 Jan 2025 17:05:51 +0800 (CST)
Received: from kwepemd500022.china.huawei.com (unknown [7.221.188.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BAF714010C;
	Thu, 23 Jan 2025 17:06:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 kwepemd500022.china.huawei.com (7.221.188.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Jan 2025 17:06:51 +0800
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 23 Jan 2025 10:06:49 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "maz@kernel.org" <maz@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "yebin (H)"
	<yebin10@huawei.com>, "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "anna-maria@linutronix.de"
	<anna-maria@linutronix.de>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"nipun.gupta@amd.com" <nipun.gupta@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>
Subject: RE: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Thread-Topic: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Thread-Index: AQHbY9mJD8uWl8wEh0eGXlblGWaZErMkIJUA
Date: Thu, 23 Jan 2025 09:06:49 +0000
Message-ID: <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nicolin,

> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 11, 2025 3:32 AM
> To: will@kernel.org; robin.murphy@arm.com; jgg@nvidia.com;
> kevin.tian@intel.com; tglx@linutronix.de; maz@kernel.org;
> alex.williamson@redhat.com
> Cc: joro@8bytes.org; shuah@kernel.org; reinette.chatre@intel.com;
> eric.auger@redhat.com; yebin (H) <yebin10@huawei.com>;
> apatel@ventanamicro.com; shivamurthy.shastri@linutronix.de;
> bhelgaas@google.com; anna-maria@linutronix.de; yury.norov@gmail.com;
> nipun.gupta@amd.com; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> kvm@vger.kernel.org; linux-kselftest@vger.kernel.org;
> patches@lists.linux.dev; jean-philippe@linaro.org; mdf@kernel.org;
> mshavit@google.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; smostafa@google.com;
> ddutile@redhat.com
> Subject: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with
> nested SMMU
>=20
> [ Background ]
> On ARM GIC systems and others, the target address of the MSI is translate=
d
> by the IOMMU. For GIC, the MSI address page is called "ITS" page. When
> the
> IOMMU is disabled, the MSI address is programmed to the physical location
> of the GIC ITS page (e.g. 0x20200000). When the IOMMU is enabled, the ITS
> page is behind the IOMMU, so the MSI address is programmed to an
> allocated
> IO virtual address (a.k.a IOVA), e.g. 0xFFFF0000, which must be mapped to
> the physical ITS page: IOVA (0xFFFF0000) =3D=3D=3D> PA (0x20200000).
> When a 2-stage translation is enabled, IOVA will be still used to program
> the MSI address, though the mappings will be in two stages:
>   IOVA (0xFFFF0000) =3D=3D=3D> IPA (e.g. 0x80900000) =3D=3D=3D> PA (0x202=
00000)
> (IPA stands for Intermediate Physical Address).
>=20
> If the device that generates MSI is attached to an IOMMU_DOMAIN_DMA,
> the
> IOVA is dynamically allocated from the top of the IOVA space. If attached
> to an IOMMU_DOMAIN_UNMANAGED (e.g. a VFIO passthrough device), the
> IOVA is
> fixed to an MSI window reported by the IOMMU driver via
> IOMMU_RESV_SW_MSI,
> which is hardwired to MSI_IOVA_BASE (IOVA=3D=3D0x8000000) for ARM
> IOMMUs.
>=20
> So far, this IOMMU_RESV_SW_MSI works well as kernel is entirely in charge
> of the IOMMU translation (1-stage translation), since the IOVA for the IT=
S
> page is fixed and known by kernel. However, with virtual machine enabling
> a nested IOMMU translation (2-stage), a guest kernel directly controls th=
e
> stage-1 translation with an IOMMU_DOMAIN_DMA, mapping a vITS page (at
> an
> IPA 0x80900000) onto its own IOVA space (e.g. 0xEEEE0000). Then, the host
> kernel can't know that guest-level IOVA to program the MSI address.
>=20
> There have been two approaches to solve this problem:
> 1. Create an identity mapping in the stage-1. VMM could insert a few RMRs
>    (Reserved Memory Regions) in guest's IORT. Then the guest kernel would
>    fetch these RMR entries from the IORT and create an
> IOMMU_RESV_DIRECT
>    region per iommu group for a direct mapping. Eventually, the mappings
>    would look like: IOVA (0x8000000) =3D=3D=3D IPA (0x8000000) =3D=3D=3D>=
 0x20200000
>    This requires an IOMMUFD ioctl for kernel and VMM to agree on the IPA.
> 2. Forward the guest-level MSI IOVA captured by VMM to the host-level GIC
>    driver, to program the correct MSI IOVA. Forward the VMM-defined vITS
>    page location (IPA) to the kernel for the stage-2 mapping. Eventually:
>    IOVA (0xFFFF0000) =3D=3D=3D> IPA (0x80900000) =3D=3D=3D> PA (0x2020000=
0)
>    This requires a VFIO ioctl (for IOVA) and an IOMMUFD ioctl (for IPA).
>=20
> Worth mentioning that when Eric Auger was working on the same topic
> with
> the VFIO iommu uAPI, he had the approach (2) first, and then switched to
> the approach (1), suggested by Jean-Philippe for reduction of complexity.
>=20
> The approach (1) basically feels like the existing VFIO passthrough that
> has a 1-stage mapping for the unmanaged domain, yet only by shifting the
> MSI mapping from stage 1 (guest-has-no-iommu case) to stage 2 (guest-has-
> iommu case). So, it could reuse the existing IOMMU_RESV_SW_MSI piece,
> by
> sharing the same idea of "VMM leaving everything to the kernel".
>=20
> The approach (2) is an ideal solution, yet it requires additional effort
> for kernel to be aware of the 1-stage gIOVA(s) and 2-stage IPAs for vITS
> page(s), which demands VMM to closely cooperate.
>  * It also brings some complicated use cases to the table where the host
>    or/and guest system(s) has/have multiple ITS pages.

I had done some basic sanity tests with this series and the Qemu branches y=
ou
provided on a HiSilicon hardwrae. The basic dev assignment works fine. I wi=
ll=20
rebase my Qemu smuv3-accel branch on top of this and will do some more test=
s.

One confusion I have about the above text is, do we still plan to support t=
he
approach -1( Using RMR in Qemu) or you are just mentioning it here because
it is still possible to make use of that. I think from previous discussions=
 the=20
argument was to adopt a more dedicated MSI pass-through model which I
think is  approach-2 here.  Could you please confirm.

Thanks,
Shameer




