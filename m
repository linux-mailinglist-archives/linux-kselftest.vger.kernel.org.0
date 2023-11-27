Return-Path: <linux-kselftest+bounces-638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2B7F9AF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 08:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B001C2088A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E921078E;
	Mon, 27 Nov 2023 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abMHa+gV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A5D9;
	Sun, 26 Nov 2023 23:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701070111; x=1732606111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2nq8B6UGK0nmJJulYWt+VY6CZqd8NJZ2bP3EpOtsR1w=;
  b=abMHa+gVqs5JCZkw/iT0g/HP9L1ZIkxvBeQ1QOPrWsPopgQsqM7h9q68
   f/DSvNu/FW1nABdqrhxUIguDK7VkHkZWXFWLV4bjVJcg9xQoX5m2PzIXZ
   OUrQUfbIIe+xmAu9w5mh0oU/GFvaP+jaCavoPP/M/arOfMRmDgGsnQ+y6
   F5WMz9Ko9PJI5Rnun0I/uqYPqTVP9UV5Gew4U5TOn1SjcK1IULNEyV4uz
   AulvDrHLFLkv8um/18/x8iSA7WhMupAedbrfkazZUKZ3MAeuC5huUD+DC
   AUH9PuifqTYHd1NQqBozgAmmLxVN7BFKPjy69eF+VC1dXpf4y9ElbUBoO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="14210681"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="14210681"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 23:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="858959009"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="858959009"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 23:28:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 23:28:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 23:28:29 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 23:28:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrn8F3UyJh9BxdibMeemPfn4n+mhnCzE7hA22/J6UFuTzCnpG5p6cZHTsUoZSQijc+oSwzArgg2mr2S6ejuKagAu4kwgILZzyv4LXwOT6lSbXAaXz9WtSpqxjsPsRqiLPcU9ZMxbVtMl1wbtPQhQ86rrJ38kUT8QiBK8dS4fUMjpxiu7kvEseXzLeqLKvQdcLtO9+1NxBpADjJSotGs0fCP4sk6ua45RMXfpPDpRM29FkqZJPRQO/vZp1AKnBTQmnyADp7/zXSggi/vu1u7FG+WLnlC8KfEcy/S3R1bY2WhTSx2X6YJKMSlfzac8dxewfD12NJ01mRnK0fVQ9sr/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC8Y4SBntTPLzX9DvdZnUbjQuMMOdb0MA8EtwNZeBCc=;
 b=Fy1I28XKboSgvqBWEkVnJgIrTfi4XnVx313p8spJjRb1vgKE5HDuCgxpouP351POLfoE9xoE3Ofb1OFj9fOY5Auh5J1VEfUXLEnDa2wZc/Ijs8bxs9hVeKlwr2UyR6JV0MZv2hetQQVH0YK1kbYzr78AP6VSX69YwZE6gX2GsoBFNv5333nzlRECHLKMXiWsd9kMKo+v3uPJF2Wp6JRNDkWbrcjaZUQWDO35nv7bl+UXyZW9zb9fJjQbH69r3ECMVZeJSp3QHsqZeBIyWfrWcStezjeuonMo34t5oMxwE7og9D+jXyy40mI/yzmHoXFwmtJ9KI+FSr2O2yGzhJ7gxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6992.namprd11.prod.outlook.com (2603:10b6:806:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Mon, 27 Nov
 2023 07:28:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 07:28:22 +0000
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
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2oNLTxoUOTUKh4MiWO0yFiLCNv+Ug
Date: Mon, 27 Nov 2023 07:28:21 +0000
Message-ID: <SJ0PR11MB6744DC9B7C7D0E4122F224FD92BDA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
In-Reply-To: <20231127063909.129153-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6992:EE_
x-ms-office365-filtering-correlation-id: e751eee5-7041-4ffd-6e4e-08dbef1a6f2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: si6aZUzj8Eznwxnd12krWweTgsFsQfzyFfSTxFaK9FwI0KEH3TCoEH0Z/nvE4axI7/IolDthMYMx2CYGQFklJxs1dw7T0vgkg3GxYtDJQbnn9aFT7owFS0LrjsuqWmAI+2/HDNnvedcO1BGm5lamNHJjsulCOnIkf6nIYGe8gvrrAl3vKQuy+fVNvVYYbcQzos2EhBh/yHU0nXf1v+qu4sw25OGlx151kq0/ARBQuNh+k2ocp6vph7DEwH2kr1xVUXWd/PfDXiBT38ESc8xyTk/KuYBYFCBECeXeKPTVoUG+mBB0nGeavTWEmk7RlPdkivkPD0UZAEjptQy3iRUiqMLyX3nQAOUbzvQelak2MLHy8PfleVd90TSfcYOlJ1M81RPppAhcn2Tqk60FXlXoMp+K1HjXhWybnkGGo1Sz8dRkaDKCXKVJf/MHf3vsM1viQwLKWgYY00PSj8IaztQ9KdoEFqfnBs2VhMZr+vYadl9e+D9beonUyLNDFVMqep1RaKiXuJ2oRbvOq0wQlIgrOVpUzC5jFL+w7FoRlZcOFgSVrYNaSmhQ4qBdXaxxkCuV19/Rn2jdQDRaoGWdV+fzAvIiT9uD7+nc25pV06rpVPWJkMPKFgY+/znySKtuvpSw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7416002)(41300700001)(52536014)(33656002)(86362001)(2906002)(38070700009)(26005)(82960400001)(83380400001)(478600001)(8936002)(6506007)(38100700002)(9686003)(122000001)(4326008)(7696005)(5660300002)(71200400001)(55016003)(54906003)(316002)(66946007)(66476007)(66446008)(8676002)(76116006)(110136005)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IOt9lOh0cAJ4tQSdrB7Yr43JXK5dIGdaeCEeeupUxvyrjA5YKCCsdhZnu36m?=
 =?us-ascii?Q?zuLnkVaSheon3l627PyhqcOMjAPMdabtHz/esqvOKGdXTmWqNARuafUh8xIc?=
 =?us-ascii?Q?yZrVgkAOcOZXOBIFxVMWREJDqAjeRUdiHpQaFT1SoRSXsrWwYqHqLD1hSR+g?=
 =?us-ascii?Q?oZvr1FK7YCGdyMTK0uQ2+ec5yWqUW5H32N2iWoWWjDxqMLj0lFrCSSnwAIq5?=
 =?us-ascii?Q?4UsnGdbPJAHKpAmxhrYvMNsTazeVMVC3vWZE+coUW5tpATUZf0H/7kUi5fDe?=
 =?us-ascii?Q?iCRvmEinB95fEGlQD5Lrq8Emopt+ufsVYnjlDryzAD6UkddTv7o/26Jj3XvE?=
 =?us-ascii?Q?Po8lyWGa9J3FJf/VnBk5sunF/rjGxGiJpQJimCQ9xhZZoQe8A4JpfLnPQhya?=
 =?us-ascii?Q?eHwk9fd63h8YXn1IGdojVEf/Y6vzcUkzukYemx6eA2fQbkWroxJfMhzILj1u?=
 =?us-ascii?Q?jKlkhPwK3G0WMhNfimK1FX4H6Dp7IHWW5Q+j0ERVWNMOz9AM5M0S81+Q6WWk?=
 =?us-ascii?Q?Mv+y9CMrV4A1v+qlpm45CwFjf5G1+Z2NnctsOXzotAYbB3kfTsLaSfm+9vPQ?=
 =?us-ascii?Q?+ASa1oja9QjIp3Mqd9+XaUBzwMvobDvNm68+4Va0kcJOf89/AiHXUvfSneHc?=
 =?us-ascii?Q?8lJXRdFthSOCyHSHuJ+Grc+lzPR3BaOy2pw3+Hawdb8ch9jr3IhIj27Ul9xy?=
 =?us-ascii?Q?TpZ3aoMqmVSMQhHp+QIH73m3bdB0YyWQILD6A3kVoo+sC6kE5g4Qm8Ftgsgw?=
 =?us-ascii?Q?9DqkO7/SfQyiEDdR2Qa1w18FxcXwnYV6M+Kdt/29xJQweokhoCqT2cB5YFBL?=
 =?us-ascii?Q?bZWpRkICOo7pA7ajobDoIu4zEJ53jcQDWfeAu+Wkue7nvS8jZgnVlHObYcIw?=
 =?us-ascii?Q?dRTkpDGdiA9IahErhpo1LLxSTm6dtcFVDUOKrmlh6KYwed6N9hnbEhxzolNB?=
 =?us-ascii?Q?vQaep+RtiPW2eZHtuDIVNC5rwTn/wD+pHEy0eq1edJuDNGkQRSUoP37k4kNR?=
 =?us-ascii?Q?Jqsp0h/dfXa94accz/Wp515pRl6f61O3/Q+mGQPdB2E3xLizXSp66cMZzTZ2?=
 =?us-ascii?Q?MRXKShdpyv1+ANjdQxq9Mc/WJk6UIbmvz0IWMlDMznaYRazMvWbcrW4NOvI3?=
 =?us-ascii?Q?3+hJry9/qNX8jukwkdtj0YoxA0a+Hsx72OXko3gPf3W03kRwCVP6dt1aiw+J?=
 =?us-ascii?Q?3KtwMO0FEvQgVPi0mFshXDRdXWkF8bQ2UFVP1zQyw2SFuJsmrbqYmEZMhf21?=
 =?us-ascii?Q?lUY3BSu94rRx7sZh4nPt/QqoQw1Ge66jy0eDzDvRTGLJRC5ZT+titZa+1fG/?=
 =?us-ascii?Q?ZE43CY+eVkn5BFLpiALQYKqmKsRBbqnSKEXKy+OJ77d2mlGuIX2JIyEaaiT7?=
 =?us-ascii?Q?kSwdvqxIcZApGjXYHK15BKwcVeT1BFoZ0fsuXE7WfsdJJZTrks+Fu4LEFgnM?=
 =?us-ascii?Q?K/G/12h6ypmEaYm9eow4xmNdKcwz6bRsu2rB0XOaTzbnENU9S6GFIvciXPJA?=
 =?us-ascii?Q?nMtR9+DKvzGn+Tkj5U8bOWHcI2fnuZEL9CXoQktd659ylDeTJeb3S416dns8?=
 =?us-ascii?Q?A/Pf1MBxUgm7LRFzr9CzlJTPlSOTHUxyDEUoI5ec?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e751eee5-7041-4ffd-6e4e-08dbef1a6f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 07:28:21.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joeprRnvbD68T5gppCcPkuo68I8eBV9rtsXGx6U0lXjopPZYDDlFvNUtNIZcs5yQUJZR7CfZocmX1WQEcILNjKnuhrCsitRQGYuSuyg98ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6992
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Sent: Monday, November 27, 2023 2:39 PM
>Subject: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
>ioctl
>
>This reports the PASID capability data to userspace via VFIO_DEVICE_FEATUR=
E,
>hence userspace could probe PASID capability by it. This is a bit differen=
t
>with other capabilities which are reported to userspace when the user read=
s
>the device's PCI configuration space. There are two reasons for this.
>
> - First, Qemu by default exposes all available PCI capabilities in vfio-p=
ci
>   config space to the guest as read-only, so adding PASID capability in t=
he
>   vfio-pci config space will make it exposed to the guest automatically w=
hile
>   an old Qemu doesn't really support it.
>
> - Second, PASID capability does not exit on VFs (instead shares the cap o=
f
>   the PF). Creating a virtual PASID capability in vfio-pci config space n=
eeds
>   to find a hole to place it, but doing so may require device specific
>   knowledge to avoid potential conflict with device specific registers li=
ke
>   hiden bits in VF config space. It's simpler by moving this burden to th=
e
>   VMM instead of maintaining a quirk system in the kernel.
>
>Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>---
> drivers/vfio/pci/vfio_pci_core.c | 47 ++++++++++++++++++++++++++++++++
> include/uapi/linux/vfio.h        | 13 +++++++++
> 2 files changed, 60 insertions(+)
>
>diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_=
core.c
>index 1929103ee59a..8038aa45500e 100644
>--- a/drivers/vfio/pci/vfio_pci_core.c
>+++ b/drivers/vfio/pci/vfio_pci_core.c
>@@ -1495,6 +1495,51 @@ static int vfio_pci_core_feature_token(struct
>vfio_device *device, u32 flags,
> 	return 0;
> }
>
>+static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 fl=
ags,
>+				       struct vfio_device_feature_pasid __user
>*arg,
>+				       size_t argsz)
>+{
>+	struct vfio_pci_core_device *vdev =3D
>+		container_of(device, struct vfio_pci_core_device, vdev);
>+	struct vfio_device_feature_pasid pasid =3D { 0 };
>+	struct pci_dev *pdev =3D vdev->pdev;
>+	u32 capabilities =3D 0;
>+	int ret;
>+
>+	/* We do not support SET of the PASID capability */
>+	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>+				 sizeof(pasid));
>+	if (ret !=3D 1)
>+		return ret;
>+
>+	/*
>+	 * Needs go to PF if the device is VF as VF shares its PF's
>+	 * PASID Capability.
>+	 */
>+	if (pdev->is_virtfn)
>+		pdev =3D pci_physfn(pdev);
>+
>+	if (!pdev->pasid_enabled)
>+		goto out;

Does a PF bound to VFIO have pasid enabled by default?
Isn't the guest kernel's responsibility to enable pasid cap of an assigned =
PF?

Thanks
Zhenzhong

>+
>+#ifdef CONFIG_PCI_PASID
>+	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
>+			      &capabilities);
>+#endif
>+
>+	if (capabilities & PCI_PASID_CAP_EXEC)
>+		pasid.capabilities |=3D VFIO_DEVICE_PASID_CAP_EXEC;
>+	if (capabilities & PCI_PASID_CAP_PRIV)
>+		pasid.capabilities |=3D VFIO_DEVICE_PASID_CAP_PRIV;
>+
>+	pasid.width =3D (capabilities >> 8) & 0x1f;
>+
>+out:
>+	if (copy_to_user(arg, &pasid, sizeof(pasid)))
>+		return -EFAULT;
>+	return 0;
>+}
>+
> int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> 				void __user *arg, size_t argsz)
> {
>@@ -1508,6 +1553,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device
>*device, u32 flags,
> 		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
> 	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
> 		return vfio_pci_core_feature_token(device, flags, arg, argsz);
>+	case VFIO_DEVICE_FEATURE_PASID:
>+		return vfio_pci_core_feature_pasid(device, flags, arg, argsz);
> 	default:
> 		return -ENOTTY;
> 	}
>diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>index 495193629029..8326faf8622b 100644
>--- a/include/uapi/linux/vfio.h
>+++ b/include/uapi/linux/vfio.h
>@@ -1512,6 +1512,19 @@ struct vfio_device_feature_bus_master {
> };
> #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>
>+/**
>+ * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the devi=
ce.
>+ * Zero width means no support for PASID.
>+ */
>+struct vfio_device_feature_pasid {
>+	__u16 capabilities;
>+#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
>+#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
>+	__u8 width;
>+	__u8 __reserved;
>+};
>+#define VFIO_DEVICE_FEATURE_PASID 11
>+
> /* -------- API for Type1 VFIO IOMMU -------- */
>
> /**
>--
>2.34.1


