Return-Path: <linux-kselftest+bounces-2457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A384B81EDC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87DF1C2105B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECBD225AC;
	Wed, 27 Dec 2023 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cI4zHTgX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F228E10;
	Wed, 27 Dec 2023 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703669249; x=1735205249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Dhev+IgJxrnrxYqFCNKyFeSOT814Xii78wz0OIGq4Y=;
  b=cI4zHTgXDanXMfB13yrya+szOzbZoF8GTR3/uIvv6aqkT0j/p7A7+aPn
   Eryxb6mtDZu9XT0FSmM91DkPhNZWmn6qVzb+0xcgzJ+tlCEJMyijlUlBs
   wsxoC5Z2FyZaP7PZxNCAxRpxrbDV0LIkv7f3yKm058mqbMzNy2kcHlOaO
   3pHow9JU7qhhSdhXCqWWbJmH/Fn/zeh2y7IQ0oixRDZOKO4Eic9ioPUsq
   9jGQnlSH59BvXGCOvKyOSSGjpneP/MSEBSDuKA5NZKAJPUs1LelLbygLT
   PAA/lhdUy4okjYLxyTyb/VovoXwhAqza5HVdrQL1hfZWLvX7M8fuL/eSC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="396157318"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="396157318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 01:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1025352663"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1025352663"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 01:27:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 01:27:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 01:27:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 01:27:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LITdXZ3mrJ4J5O0EtlxpXyuWceo+up4Xebd8CZvvxJn62JbdpOtI+9qm58WwKw2cwyqOetzD2jXJM64kMBnaQH2t26jKX+xrScKEfIyOPf9i6EGciDw4TSpv77MekrR/g6rL8SqrkatpOS5CddSc1lpHshlLCxvwThxUCZKD5FztYL1PYrEL3GfhtAhDb1LUFuXlz9zXi4Y9AQ9+cmZ7jSHdQvofxzcm6jWrqmqfXgaYJGUCymmFbAfh9sxl0nVA+JrZYkg56e5NemYtc/1uuK+J92dUo9hXM35FC6WCI4zRhOyKXSZW8vHjL9T5+N9lPlfDjaZmeyikWzGoJ9cQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWVUZRQwsMY9gdTGnJvJI9GEL6IvNDA4hCsDYrVp7/U=;
 b=jE0/lSy7gXPm+7Hlej3dOsOXyS2i/OyvW9rjflUZi4TOfZyWnNx0G920pdf6+dD3dlZy8i52AqNkM1BbMQmYHApPNiMkqSxrdT9Giej4KlHUthdFGF5EeqZA+nNuUvOxPhfAV1dW23Yp5c+9GASeOjtestspXbXjAnw6FvLz3Df8mT16+C8Nbb+VUCSEaGrHw9/4+qRybKbwCvC60rb8CKUWgb6w+Sru7Or3K0Zfno+HuGZxicRSJMi0fPpmiXBuWIK8s4Uw64sQLqRiRldPU5CpHm5Tftjum0Gcq+P1mVMO4eWwtVCmj7AA7q1vDX3NLBZeoJIlfO8P0G3wG2BEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 09:27:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7113.026; Wed, 27 Dec 2023
 09:27:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4dolXES+lQE2ssT5l2eKSLrC85MyA
Date: Wed, 27 Dec 2023 09:27:24 +0000
Message-ID: <SJ0PR11MB6744F3EC34CA79A67548336D929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-10-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB5003:EE_
x-ms-office365-filtering-correlation-id: 367df162-2d4c-412b-b432-08dc06be08fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8FLOy9p+8xaqEAaNdlNAl8tNqADKJkHl401ZNS3hgFWYqIEYMSJMosDDkNdVWToo7J+cEev3vQEj+eq20VCrM8ucFQVGNzRtR3qrFbGEYZzFuuwWKzrBIr02sKa5HVIEn1KLolSviMGaqT/ssKlOEiPEJsxWicrI8llfjZTpyKEpkbmIafy7XpKKgRk/dtB3SNbz231CaWpR7cMbdHt8C+yXr/uSNYvnhFBOmhGxTHkPDi7cEmAjRatABeeFp/wf+vpEaYQKx3/Esi2RuJ8ymuI4cQPyK6oUAqtR6+5XdDOS5OL0IFI5hguec3jfI+91H+1eK4FookDwSrBMVomR1jo6zG7C6PpgF6YtvD2hXgLPwmY3IzBE3hyK/1cgGfsEiCDezmEz5z+jk+hxVsZkisczaGrXWBYJODtuDTQkrKpwlwHm4+retEBg5AwKsNEndcc6pA2eT436m+bnP0i8jSyUs6ZOdm9bEor4CU4PV1+EMDLHrfOBF9vTgORkuCKvRZqmW85HYOsOaO07cbDwVItJWeaHeMeO+hjvVqRKRMF2WlzrDpvnxSWmvOAjaaNSgLxzHTCSvMvh/ANJ9UpA5JpKz6ZovgjocIZ7RSXosPys/N0KdgfOufWYX59Sod6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82960400001)(2906002)(38100700002)(122000001)(33656002)(38070700009)(86362001)(41300700001)(55016003)(66446008)(76116006)(64756008)(54906003)(316002)(110136005)(66556008)(66476007)(66946007)(83380400001)(7696005)(6506007)(478600001)(26005)(71200400001)(52536014)(8676002)(4326008)(8936002)(9686003)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0pY1zVlZXURPAYVnZwUgbQrpUJOBSseeLy9tDUueFMXFLzpLDahH2oozHVF0?=
 =?us-ascii?Q?k7DSyE9v+BNhkGDLVFT7umywTUTe0MUc2iYohxbxcKWfPyJeSiagOPgrekpx?=
 =?us-ascii?Q?kTF3u/5P6HcScu045oPlrZRwvGZYr8E8KIHY9RdYwCTYEuiG+B0DiFMELXZI?=
 =?us-ascii?Q?tAEFVwwKPv98osDbTtonkbV/LxUJvVyWIyUOJTl9dCaCiQf5mWXc/3ICJoNN?=
 =?us-ascii?Q?Yzk0qNqaXl3XI1+EJt1dgeY4XFNIx9Y3/E1Y59qIzA1pW3xs8mTEx1H8m37g?=
 =?us-ascii?Q?Tmcio8gK/FzDObkGpiYANve46kyJcUmV3Sm4bqJIJ3H3rPR8lB5/bimSsGJ1?=
 =?us-ascii?Q?YP4kRT6UIs9GQIBhM5bq8qDD9DJSyuFDcjnMBTS0akjhSkiPOA0zw+w9NY3+?=
 =?us-ascii?Q?+srEg3ftQ08G7cvXSK4gnp4mLmE974Ew0hTW2RgD3UqAHZkGdGNeCrex83UH?=
 =?us-ascii?Q?t5UieRERKuQosJEWSeC7YUrmTJOqdJ7TsL5Jli7bJyMO6fUOkp4yV7JnhorU?=
 =?us-ascii?Q?OA0zrL1outlE+Yd5imbS4jnhABMZDoz3bYRDZCir3dFt97XTepued1zOzFL3?=
 =?us-ascii?Q?kytlS9bVXwAEXcK6QGz3dg5yiFoMPbqkmqvy8dTEZP/8xIKj3m4uxjzuZD+r?=
 =?us-ascii?Q?bf8lXyPPGid31g/Hb5x56q1AU/Sa14CJYqjOOvefRl1bX3Bj/xIbVy3YTbjI?=
 =?us-ascii?Q?7MxJyuAndWaYlduXcwpkm+tnP5M/ezHiKtNXJ7BpeBEGVJyG3UHtHrm68uAb?=
 =?us-ascii?Q?V4Fc0/nis8UZLk9WCIFTWLHc+ydqEV780EI0RaAPxy/TrfYCv7VcXcOmw6UX?=
 =?us-ascii?Q?7ySyexzLzfnd5jbm4Tnxm7oPVuTLUs/qrt1Z361LNRX3V4UAtJDOEbMio1aT?=
 =?us-ascii?Q?c/H2OcQQuWQqiPpD2ClPVFc62f0qGrtb5d4FkloZ6dsng62jcG/XL/XT/eOP?=
 =?us-ascii?Q?CgIDaUeqnBlrbEoDMk6ovNia3pCPeYfn/t9+YrI0Wer+g4mWhgInPACS+Ita?=
 =?us-ascii?Q?RacawvEhIkqWCXPdMG4rlXUp7qvVJGCEYRXKnE+21StTuTDPdmHu8PHARpLb?=
 =?us-ascii?Q?FfmbkgFUeAr2MFl3XYyQq7bf+JsOgGcBk38yfT4+CeiCWohJeft7gI6qXt4d?=
 =?us-ascii?Q?evfIf4CheRLxHFsJ0xQ7iqEwqz4yaWKAaYuXwtQvwzlmbz+24xn1Q1dKHwGQ?=
 =?us-ascii?Q?xVd3qcbqPks6eNes6nvGgoKO86wVgJlHt+UQzKm8R52TRWIu3Kfq9NibigwF?=
 =?us-ascii?Q?YVm6u365dPMczzwIstRrMHYyhn+i7dUiAHTZ17ulV0eio45oiKbfFTYoO/+9?=
 =?us-ascii?Q?6VAqsinywUfufTKXOqWNM2cXk8SrXosYVV+i2Zcp9w2Fl/yfus9JntwrE6Yg?=
 =?us-ascii?Q?TaxsySvne+mvR0Jy/QAnGCo48pTXMcYxgUlG0iYCt7N4xZDaPQ9LDklx3Tuj?=
 =?us-ascii?Q?2EwN3QOPv9eFEq4d1O/Jcbn5kSpWz4s9B6s894wflIkxIx6o7r1HaVpYzeHe?=
 =?us-ascii?Q?nxzLmy7f8yMCSeAF/RrtHcQOitrtoieQMGo/tAJ6TL5xL9z5mK8775eisGoL?=
 =?us-ascii?Q?qbqsQt3ydSkVPRW4r3lmepBeYXUxRU7Ol3ilwxpO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367df162-2d4c-412b-b432-08dc06be08fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 09:27:24.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vV5yL47r0QXu6kDiVFPaZuNbMO7oea473tZlCTAHpiicLwSxfNBWh9hr3pUpRMfUeTwpnNJsahtMBBiQ55CQoFCpSkw0JDrVbuBVQb73LqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
>
>From: Lu Baolu <baolu.lu@linux.intel.com>
>
>This implements the .cache_invalidate_user() callback to support iotlb
>flush for nested domain.
>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>Co-developed-by: Yi Liu <yi.l.liu@intel.com>
>Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>---
> drivers/iommu/intel/nested.c | 116
>+++++++++++++++++++++++++++++++++++
> 1 file changed, 116 insertions(+)
>
>diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>index b5a5563ab32c..c665e2647045 100644
>--- a/drivers/iommu/intel/nested.c
>+++ b/drivers/iommu/intel/nested.c
>@@ -73,9 +73,125 @@ static void intel_nested_domain_free(struct
>iommu_domain *domain)
> 	kfree(to_dmar_domain(domain));
> }
>
>+static void nested_flush_pasid_iotlb(struct intel_iommu *iommu,
>+				     struct dmar_domain *domain, u64 addr,
>+				     unsigned long npages, bool ih)
>+{
>+	u16 did =3D domain_id_iommu(domain, iommu);
>+	unsigned long flags;
>+
>+	spin_lock_irqsave(&domain->lock, flags);
>+	if (!list_empty(&domain->devices))
>+		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
>+				npages, ih, NULL);

Is it optimal to check if domain attached to iommu before trigger flush?
Or the check is redundant if intel_nested_flush_cache() is the only call si=
te.

Thanks
Zhenzhong

>+	spin_unlock_irqrestore(&domain->lock, flags);
>+}
>+
>+static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
>+				   unsigned mask, u32 *fault)
>+{
>+	struct device_domain_info *info;
>+	unsigned long flags;
>+	u16 sid, qdep;
>+
>+	spin_lock_irqsave(&domain->lock, flags);
>+	list_for_each_entry(info, &domain->devices, link) {
>+		if (!info->ats_enabled)
>+			continue;
>+		sid =3D info->bus << 8 | info->devfn;
>+		qdep =3D info->ats_qdep;
>+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
>+				   qdep, addr, mask, fault);
>+		quirk_extra_dev_tlb_flush(info, addr, mask,
>+					  IOMMU_NO_PASID, qdep);
>+	}
>+	spin_unlock_irqrestore(&domain->lock, flags);
>+}
>+
>+static void intel_nested_flush_cache(struct dmar_domain *domain, u64
>addr,
>+				     unsigned long npages, u32 *error)
>+{
>+	struct iommu_domain_info *info;
>+	unsigned long i;
>+	unsigned mask;
>+	u32 fault =3D 0;
>+
>+	if (npages =3D=3D U64_MAX)
>+		mask =3D 64 - VTD_PAGE_SHIFT;
>+	else
>+		mask =3D ilog2(__roundup_pow_of_two(npages));
>+
>+	xa_for_each(&domain->iommu_array, i, info) {
>+		nested_flush_pasid_iotlb(info->iommu, domain, addr,
>npages, 0);
>+
>+		if (domain->has_iotlb_device)
>+			continue;
>+
>+		nested_flush_dev_iotlb(domain, addr, mask, &fault);
>+		if (fault & (DMA_FSTS_ITE | DMA_FSTS_ICE))
>+			break;
>+	}
>+
>+	if (fault & DMA_FSTS_ICE)
>+		*error |=3D IOMMU_HWPT_INVALIDATE_VTD_S1_ICE;
>+	if (fault & DMA_FSTS_ITE)
>+		*error |=3D IOMMU_HWPT_INVALIDATE_VTD_S1_ITE;
>+}
>+
>+static int intel_nested_cache_invalidate_user(struct iommu_domain
>*domain,
>+					      struct iommu_user_data_array
>*array)
>+{
>+	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
>+	struct iommu_hwpt_vtd_s1_invalidate inv_entry;
>+	u32 processed =3D 0;
>+	int ret =3D 0;
>+	u32 index;
>+
>+	if (array->type !=3D IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
>+		ret =3D -EINVAL;
>+		goto out;
>+	}
>+
>+	for (index =3D 0; index < array->entry_num; index++) {
>+		ret =3D iommu_copy_struct_from_user_array(&inv_entry,
>array,
>+
>	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
>+							index, inv_error);
>+		if (ret)
>+			break;
>+
>+		if (inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) {
>+			ret =3D -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
>+		    ((inv_entry.npages =3D=3D U64_MAX) && inv_entry.addr)) {
>+			ret =3D -EINVAL;
>+			break;
>+		}
>+
>+		inv_entry.inv_error =3D 0;
>+		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
>+					 inv_entry.npages,
>&inv_entry.inv_error);
>+
>+		ret =3D iommu_respond_struct_to_user_array(array, index,
>+							 (void *)&inv_entry,
>+							 sizeof(inv_entry));
>+		if (ret)
>+			break;
>+
>+		processed++;
>+	}
>+
>+out:
>+	array->entry_num =3D processed;
>+	return ret;
>+}
>+
> static const struct iommu_domain_ops intel_nested_domain_ops =3D {
> 	.attach_dev		=3D intel_nested_attach_dev,
> 	.free			=3D intel_nested_domain_free,
>+	.cache_invalidate_user	=3D intel_nested_cache_invalidate_user,
> };
>
> struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain
>*parent,
>--
>2.34.1


