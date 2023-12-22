Return-Path: <linux-kselftest+bounces-2349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99BB81C4DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 07:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0481C24A43
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 06:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66D612E;
	Fri, 22 Dec 2023 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsQlkeJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DB6FBC;
	Fri, 22 Dec 2023 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703225046; x=1734761046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F178ZtF1nJTGwHQeu5aIYqD+2+vqWdWeQ8nZ1JJzuw0=;
  b=PsQlkeJwYXclcyx9FWTwx/NGDkcvb6IUcSRp+ztNnOp7WonAmpvy/klw
   RL9AS/JiXAT+jJn/6t1oRVBSVbYuRkXQW33ZJ1hNqs2EZ7PldyIkiX4k5
   gDPTt0czNC/sZdtYIDyKopkbL0okV74hwNHqgmpeBOEzcEg60LuXxUHND
   AakjIP/2HcweFulbo/rou+97ceXYJtWsOf0/3r2LSaseaqhlo6/hsLoQn
   jPodljhwnSF7cja1tPO/t3Lel+P69A3XGdSmZZ/TG1PiQ+qxjox7kzMcZ
   14pnC8P4XoGWFQ0h65cAWTSRvrKGXoi05eeeoeDZ5vqTCM5zFHwGZTAWS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="427237545"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="427237545"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1108367556"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1108367556"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 22:04:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 22:04:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 22:04:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 22:04:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 22:04:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWIgNypPH8QO8zhvD7O6kr2u3G08gXAtwaHeisEQ42P11n8arYR1FHZ8hDmkjDbLpz/V7BEjpq/elLSZrTeRc+PHrJ3Xh54+cwUg1YCsbI9cCO7oluO+2fB8pu5JPhLrOTcf2fJjMKHPE4Bf51ZiMZjs6J/FQl/GW184Y5Y8orVxDK7h/+tiTxaZ8hRUSTov0kNZVQWS/gLuv+KNPSvbBhw3YcQYw7ALecQ9RfJphPpsrL7zmCiDd6dGROtOtvaZ4NeHddkhsb8V/ifEWDGR7Ynn8EpR9LS/QuFLtF+th975h11W7zs53MVeYn6YF79ivl8xnN6hMkmBtOf4d3+3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F178ZtF1nJTGwHQeu5aIYqD+2+vqWdWeQ8nZ1JJzuw0=;
 b=SkZnMOS0IdWQbOCyLdGturFcJ6KXuBbVW119qTwteOGx7/INKbB6/nvRVcdrTUiDc3sFj3kjzUfABzHrkfBuI0326H44OMukplqXAtRZaHkcx8nkj1C5EoJz6B96BvHUChy0h8NsLzQS/sLPZlhf7zIIzw3d4e8u6wVn8bjb8kx8Fnhq33A6HU3GfnNAZCsVmrMzmIVzcGEvCiCNxvpd+q0hKDQY0Na60/2EF5bTWokeKJCVipMfZzf/IJNAiyb4T+968ic4V7JseoUOyYrj0y3pRLHEq2iQBGSr1XFXztF5mdlsTvZXXvscWOb6kGWJtNqVAWjyTZRv372fu0o1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 06:04:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 06:04:02 +0000
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
Subject: RE: [PATCH v7 8/9] iommu/vt-d: Convert pasid based cache invalidation
 to return QI fault
Thread-Topic: [PATCH v7 8/9] iommu/vt-d: Convert pasid based cache
 invalidation to return QI fault
Thread-Index: AQHaNCP3cIpzb8Tl/kWnM5cpop4qLrC00L5Q
Date: Fri, 22 Dec 2023 06:04:01 +0000
Message-ID: <BN9PR11MB527600A6E4F860C3273B3B098C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-9-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6518:EE_
x-ms-office365-filtering-correlation-id: 722ceea1-ed70-4942-55b4-08dc02b3cbb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QtoAkg7t4Z66arDGc8Iy91Qm7qniHr3k+IwElZ7DBsqxik4TpSdg2CGhFDW3jCKZQEndepqBTkQgBlFfbeweDzYl2I5qqPywRyXtnxbq+95/JPFl66pmICjRoROJLVwkdUzQ0h51XYuCE3E8ddj7mKrexnJaWM5PsNOrTIA6IRNakuIfMcG5lDeR9s8IuRixl5/pHQ+w9/AC1+1Ff6ydtAtXcDU6Xo0HakHOi5UHxG2cOpUTlyAtgInHmFrhNnDi0BK5Bc++AGYc7PY0vKrskSmCUGzDVfWLUcqiyLyVBy6Au+JdqKzb8PcUYrWVlIKXubDuP9NiqUH4xNcpfsC/AV5slNNqdaRPBmfE3Rt9Z2fO1VNILES76IZlkv7WFZ/c5bDlBo43ZcGs0xR4kqAR+f+h/bL9HRzxcfypeb36b11m0IetE8jstB3KM5i9guvifyMt/wRfXNr0SXhU7Qq3moPPXBxJrcfFmAv/gY8qmUUmFWVX9SNfjHT/Teg6/vfJmPkHedOSLhDujGWv0PtIVIZq47GD/uVr8e5jaD2DCABw+Xv4RYkNFskBn2nt6kKn+Fnxe354KP+ebIk12FbHL8iUm4yPspp+NtJcJlCCCFF93HRgQ4gmaAEGdG/juDLj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(122000001)(52536014)(76116006)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(110136005)(316002)(4744005)(82960400001)(7416002)(2906002)(41300700001)(86362001)(33656002)(38070700009)(38100700002)(5660300002)(7696005)(6506007)(9686003)(478600001)(71200400001)(83380400001)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kfs5bR8YQANMFDPhe56d85flS4jC84tweyWDYo1ccRNASxdjAC3jNxDtepiX?=
 =?us-ascii?Q?QQY5iRdXuElr6aPmgcCAaXY5JJK/OcniORO30JPeJGXAUy9tCq/rMnfMEnvE?=
 =?us-ascii?Q?iGMYHfrJvkbkdDdxXAJ54yq0fjan3xIltR+Vy1kAOt8p5jiYicQcyfYqCsPJ?=
 =?us-ascii?Q?/r1W2Dve/Se6aWEEV5B9z9pTnHoB3OTam89DRi1gymniTYzb0n6NakCMhw1x?=
 =?us-ascii?Q?kKt0JtOdn9/sSSF96SX7iMYQQ7SqvzWHMwFodjO34SJsVC4vHhDhyIRxg0B4?=
 =?us-ascii?Q?HCtk6T9amMuU/4QaKIEYGAqJWaGTYxZ90BG1LB53At8MtHVm5xBIJGnoa2ey?=
 =?us-ascii?Q?PXzZoQGNoUfqkTvb/A+pTLb5iNO+oe54MLH0WzsletKrDZNe2R0GZudpdqp6?=
 =?us-ascii?Q?gK/VE4KI9Rh3QKHUPOGA0vfD5o2wjrHnaC0RUO5wSDIUZY8TtRFfm3RWhITD?=
 =?us-ascii?Q?Jt9wok6rIboQASr6wYKu2MYoe7dmLs+XqFtDaQz4UAXwab6zmTELuFbSj2Ok?=
 =?us-ascii?Q?8DxUHxySHVkFYAQJg8V/olOGNJKq84Qs3yVGhwlwel1IkrdjAULjWW7tAmPB?=
 =?us-ascii?Q?52K/JQd94YP6XK64O1it/oni2junTl+Aw8r2t8DD9miwTelrFplstzvq3nmd?=
 =?us-ascii?Q?SYKinr/A+7niS5RvZzGCNTTr904dsALJ707EzMBERRqUY2o9niCYX4bGFfyM?=
 =?us-ascii?Q?YTJ+CoA3+ontiexzdyh65qDq5JpKteZwTwNcGHWqJSDYa7wBQwD9QXVztHbz?=
 =?us-ascii?Q?Uaw5flJQTGKj/HFHH5B9gXOqPm26Cw3XJOh1l6z4OQEAdktC5sR74s533soG?=
 =?us-ascii?Q?lkTxDawBvkAzrNZqfVM1L4Cmqbu7C8hlL5J0TwLSYSBYLxUS1TxbQtkUhehC?=
 =?us-ascii?Q?ATBW6moFbOypqjZXSLnKG2SQK5Ts2rXJ+jT+TG7Jz4EAiFHxEkd3R1eZsJm3?=
 =?us-ascii?Q?Z6EI3zpk9VUj64VnOoOaoqdX5qMY3sson0HV3u/T/ViQ+84Ego8Q679Ap8ce?=
 =?us-ascii?Q?OKf9JMMN5CUJHbADMyffEDRPsYwvE17LV03rxsUk9ZPrQ9B8jRtCOHMzdRYS?=
 =?us-ascii?Q?1AtkJF9OvqOCp1Vm33nntHzjw4TqaVuf9OzYzJW5MTPYrMTDMSOQ21Mj2Kqv?=
 =?us-ascii?Q?aIGKhCwonvmuzcNWBswdWNfIz0BoUXBHUqp7u1ppqJzKeSWt/IgeSJaw4p7u?=
 =?us-ascii?Q?AN4RmsbjzLgKUm20aTqQRZn/7MsrhXt+qX4NrhwDn1ZXopBjUxt8Yl8Qa4L7?=
 =?us-ascii?Q?VPRcAF04GrG22/dbD4yyWi9B17eYV6v2sT2+pcCGAW90Odp90FuGC3jfTr7c?=
 =?us-ascii?Q?nABYWKkmCgV7rhQfNpC+cOLsP1fhelruZybNoyWvD8InJznknayEvEewStPG?=
 =?us-ascii?Q?VU3JbwO8fDF/f9BaVZjVVyu2LROPnA7J6MBKJ1rMT4/N3ReDEnJpZ7ezBhWa?=
 =?us-ascii?Q?1kvdtl6TNfJ9aQO6AHKIkAvk3L56eKgZS32N8lJudyXpgTa3d5n5CG1pjrEz?=
 =?us-ascii?Q?cDxyu+1XEHBwnp3K3SHGhuordH31cr0/7AwwDX8pDugMM8jQ3WwbUqLVeSUb?=
 =?us-ascii?Q?eFqV7KllFK6900zFhuZPL+1C06cyI8/rkda3NwyZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 722ceea1-ed70-4942-55b4-08dc02b3cbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 06:04:01.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUyx/JPEg+bdi3B40Rvk/rYxnGU0IgkVjEQv1nTUCj9x5YqaVLrqlGru3CDfJSm0ZgrOK/NrM8gT3gfZ7JPTTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This makes the pasid based cache invalidation to return QI faults to call=
ers.

it's not just for pasid cache invalidation, e.g. there is also change on
qi_flush_dev_iotlb().

> This is needed when usersapce wants to invalidate cache after modifying t=
he
> stage-1 page table used in nested translation.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

