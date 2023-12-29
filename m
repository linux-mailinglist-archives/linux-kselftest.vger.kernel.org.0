Return-Path: <linux-kselftest+bounces-2513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CD581FCA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 04:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10472856B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D4517E2;
	Fri, 29 Dec 2023 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbjlK0N6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF517C0;
	Fri, 29 Dec 2023 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703818819; x=1735354819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SQEJPDwUE8+9r4OeJWVSfmBSAOruSh86dpUs6nwCdrE=;
  b=jbjlK0N6Ek3X8tiIp/lBWkCnQBW95BQbwqY74OIzJRMKVblM0M29gJks
   3JhQUoL6tYRUKKJL/FYN84L06StMJOLfsFi1KYIb/KIHIT9fe07sg8ND0
   PJJT3JtSXii5sNjPVVFCkBVnVA71KcAeqpY+UbDM3s2r/+NaxD+AmAfcb
   G7DGUwwTSc20bssmtKZuAzDBQt94/OAk7SPG8iY2nwffUB/Gi7Z7v+2b+
   +TcWJCJ5LnqwsSREyKdmFe6zGvEHZrYPCTerWnIly+ybxOswm81QZ+ybx
   v4TsJ+KMbG+mLYmd1bHwt3XC8DENwJ/gHE4+kILe6AElmFdeAGbXweLzb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3910632"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="3910632"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 19:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="782200937"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="782200937"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 19:00:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 19:00:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 19:00:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 19:00:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 19:00:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSQE2Z7i+v0HH/np8/91cxvwW+OGP1ouVkR36pXW+fM6rLfEuBK8fWJV3oYqfzbThLGGn0P22iGA2bfjBOOLkwwSHcnSFOnX/1khb4tnZUvuatXtUs8iOx3dCnZU5Fv8vP0GGTBQPrYwIgEftiLt2g1tb3t8geyD5en2M3Cnozc1JavfWpvQLyhNsHsJNT905HNKHV2/6cxkvcCcqR8yXYeZ0jyKCuBAzF1IbyOlQYk0OuA/eu+YrnNILD4NeH6J7ar3RUO4x/MJhhJHeJ6+5ry6Jo8liK1R+FHbcUMRn2yyB4QDB84pJ+7rAY/p3NN+9UjWkNcEBO/EY+tXHKHb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQEJPDwUE8+9r4OeJWVSfmBSAOruSh86dpUs6nwCdrE=;
 b=i1P8BYqvG1pIuc4xX8q0p/iVYMUCFrM7uQChVtGjkZ0biUn0AFVOuRZQYsx7LDxC6JQBEPUBCnMJA/F7ZmQnSisFBuA54pbnoVYtIdtxl9ODNs3PEEY+8fb9RxE7O6/5dXIM2eoN3VQrGFC9BICGV5EH8/rQHj6pcjRGW2rHSEoE/yW11/dJ/HAf/jbwFTYaZFFOQ04rra/zUO4zVOVZTMr3THAfH+Xjk4KBmxgKUdeCWgpeKXptLsSY/FPqEfIVL8/0oZ/sOmj0gTObSls3r0/NjlpcxgSABU3vVdbyPrv573DR4eyYmgE8d+O5mG1GxLPHjBJ3/c3PmWoxemLEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Fri, 29 Dec
 2023 03:00:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 03:00:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v9 00/10] Add iommufd nesting (part 2/2)
Thread-Topic: [PATCH v9 00/10] Add iommufd nesting (part 2/2)
Thread-Index: AQHaOZ95LEdVlC03r0KOSmBZICdZ9LC/kgaA
Date: Fri, 29 Dec 2023 03:00:09 +0000
Message-ID: <BN9PR11MB52767FFD4DD1A4CDDCA782628C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228150629.13149-1-yi.l.liu@intel.com>
In-Reply-To: <20231228150629.13149-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7024:EE_
x-ms-office365-filtering-correlation-id: 200e545b-c72a-426c-0518-08dc081a4504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWzrRqtsGCXVcr5Yt0JEhNNe+JKfcGc+qzzJWn56HF+uE8f6e4nHtmBlbEEoQ22vD7x67bnXzs1Sexc5YbpTY/wd3dDu8hMqhwVbf9HbDAie12VtSftAmMMbWppaSoXFuCiwUHgLGQGLXS6EWh9KCVhLwdFFq8YTAMtLdFQ4JRLmR0D1ib0Q35Qq4SecBahgi0SQF6XHLrAh0fhHotqU9lAYhD8PevbywlYhW4rIW6bVx+Y9xJ02TMtiwxz5u49chwUqOp6MtmTgyYyU4CaN2BVPJ8udW3N5bOAUn2cee4/Z74jin+tQlhUKbreCN5f/+bWNeKx5OlOQ/YkglUpbmrUMYMDDyS6IdqvB09jsdfwofkr+CE6yz3o/4EfmFwQviM6mprWmi6chipTDbvYPz2f489notZCednaDKCxGbDiJ+odRLBkPIuMHnncMMykG/mhQkpIUSnh05P4NtbMuaZKOTk66pXpkl6XgYV7z7wJMZwtk5DE5fKEWwsXLBvbbmWARNJ5KNO8mF9pouoO1Icr55quAbbm1O5uxTtuHGP/nkBkVrcu21hLX6zf5EGXepnpToV+0yv4WHvkutsx9vJNToQm11kchXY5yM7ecvsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(71200400001)(33656002)(82960400001)(478600001)(966005)(6506007)(9686003)(66556008)(110136005)(86362001)(41300700001)(64756008)(66476007)(66446008)(7696005)(54906003)(76116006)(316002)(66946007)(55016003)(38100700002)(8936002)(8676002)(83380400001)(2906002)(52536014)(122000001)(4326008)(38070700009)(5660300002)(26005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGt36TUOi/1kXa51Kyl8qZjm4UVVY6cM+Nz5jmCRXvMVhxMTlDD0q/G19W9v?=
 =?us-ascii?Q?UFfDX8/EzPwcirybBAho01PJBiSwhI4jKaofx9G5nDWy9cSFLrpf80akgV3X?=
 =?us-ascii?Q?0nbt7vTHWSVEBok80nXlFQy5yj3n3Ypzr6yVNxg8FBVNmwFCMGEjOqmrf5v/?=
 =?us-ascii?Q?k7HNSCNGywqxTLhc+eztnHpAqEjR6c9punMTRlB8uQvog+5hAQdWO0+vgYLw?=
 =?us-ascii?Q?yhjl2USIU+DUglN4Vh9PDHWzz6bf5fd1LvEEcDF+J9xL00XClhE9YQ5PsEyL?=
 =?us-ascii?Q?DMmDV3220+FSntUEeXYXUisO6WCyQ/IrTJyO4uETYGnyrYZtGyol8btzv+ZD?=
 =?us-ascii?Q?KA+Un4RUlAT8/ow6pWWResRlkQRVih9SnNXXZPDN9ctbYrh+Xkm2BO7NsPGU?=
 =?us-ascii?Q?2Glud6gBTSoef6LodFIM0lNl6ehDVulfIQhZ8eGl0DgF81qNGHV8dUSHGM0C?=
 =?us-ascii?Q?t9xk9fDR51In3dS4wWKeXPZafYqAh6NSwXqxgpDYMSD+/l5CICSEkcf43CLQ?=
 =?us-ascii?Q?KQGlSgVCgiW5RySWehzwzqEyyT1/xmRdLeGsWArhCJgrOcKs5GX4Kvxf2202?=
 =?us-ascii?Q?gT4NJgvJ8Cg2m9y2V+orzm6Z2wYDBLdk1zKhIr7utkcKAjxRFiFz/82xeQ/K?=
 =?us-ascii?Q?sQH45HreKBKw2n+2RMTGS+jc7sgJImj7MgbumUv1L65LCbRd1lbjTFt7bZI2?=
 =?us-ascii?Q?c3fXSCWg9LTf3LHKXLcbTfWuWX3AP4NPIPHa3gRcq3kRIP/j2Kn62u5iVk/q?=
 =?us-ascii?Q?K30i3x5rjbX3kESiNQSd2N3E2zJKN1bxxL1XjiV4R0vLLoDFs1DQxbH7//+l?=
 =?us-ascii?Q?N2lOqb4ze/flItwHKqQ07hXAMB6+cyVHrGTuczyKg3gsHxVsU2B+4bav+yE3?=
 =?us-ascii?Q?Z6Dr+mbr2SRoy8HeK7SC0qrj0Enq/hRoCVbHf2ZVeOPB6rNChJLAbVmVvRul?=
 =?us-ascii?Q?vrVCTyXSY02N8ZvPCjqixNnwG1ON8LSnnbmk0qrUYxTNkCMZ9AKcsOr9ApiK?=
 =?us-ascii?Q?Ja2gCTFfs1sVzD9Hc7EJlajwD3UbXbF8z75zEveWXwiQ8gUHJjf/+GyuSBfr?=
 =?us-ascii?Q?oZhtYBTTZbO50bDkxjcyULUJvFWmX+gBDO0jGhptCSKn4rZRIQ1zgMjqrvzJ?=
 =?us-ascii?Q?hcEdgQqwRx77pFBC9f526UqQFmf9KvgpSjsPuST096gRA0BC8RhgA/fPkvGt?=
 =?us-ascii?Q?qgEWZm4e4zbZNC4y2wXkxWeRbnxkvnKpjbYM1S97FR+bqfJ3Ub3fmhdkNWTf?=
 =?us-ascii?Q?U9EKXlaRsIeUeb7ZQvDNBxk2kawj3ryH1/cDm8ytW3m8B3PfTmLSSU1wLf8E?=
 =?us-ascii?Q?nEkurG3orq3Iq3jv2778cyVI/Xz42ue5NWndBbiltX4qPO6JbeIjbAh+EKBw?=
 =?us-ascii?Q?vkTQWSz4K0xxxRInE2atY0bbmUdBRbVjVDiJcYFvFa1wKYm7Q4IdH5xQZMhE?=
 =?us-ascii?Q?O/xcz12O7gdd5ACq72jw16Z/ulV80d/t+3YOYMB1Q3inzPMFusT/sxYjznaa?=
 =?us-ascii?Q?/Z/Yw27PtMOJ+aOfNqlcw4HZEI/IbXS+2rVQIT9MaFBIjHezG1nUvCcaI3XV?=
 =?us-ascii?Q?tyS1xQWvzJc1d1eAvwW0AKDueeVZmTiBikYLnFaR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200e545b-c72a-426c-0518-08dc081a4504
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 03:00:09.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJ1jg635wm/lDYqQDjXiye86IuV5MKBbqIqymLAmvW7SOxxiftS6JWEQke3O8gemfd2vLkVjmsexIz4HAo6OVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 11:06 PM
>=20
> This series is based on the first part which was merged [1], this series =
is to
> add the cache invalidation interface or the userspace to invalidate cache
> after
> modifying the stage-1 page table. This includes both the iommufd changes
> and the
> VT-d driver changes.
>=20
> Complete code can be found in [2], QEMU could can be found in [3].
>=20
> At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
> them for the help. ^_^. Look forward to your feedbacks.
>=20
> [1] https://lore.kernel.org/linux-iommu/20231026044216.64964-1-
> yi.l.liu@intel.com/ - merged
> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
> [3]
> https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_
> rfcv1
>=20

this looks good to me now, except a few minor comments to patch7.

let's see whether Jason may have a chance to look in his holiday and if ok
whether he wants to see a new version or just change it while committing.

