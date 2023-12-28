Return-Path: <linux-kselftest+bounces-2489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA3D81F4F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 07:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63B21F22591
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 06:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17344256C;
	Thu, 28 Dec 2023 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL+OiBiY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DB23B7;
	Thu, 28 Dec 2023 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703744305; x=1735280305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0KRtugM1LmX3WjA96eYFys5Hl/QYtc7mAP/79WfYVy0=;
  b=bL+OiBiY2KTzNveiyrga4AZuCrjC6SyLJCewrDStCZtOUicmpJzJn43w
   R+hTKxyNItAlDl8qrdNIWoe7mp3QIPRDXgkJRH+8vfC/KeoC4jfdMg8iZ
   HH6o7odknfpsLN26S8nuPo7NU/yePxOysjHbWbcayf5AY1UX0/qfXZdHw
   fd+PtAgbaKFlTM4Yw52XngfS+PkBxYMgbPGIAqvsDCtWHQH9pDcyaLG71
   BbC8Y4aRuvbvO7Z9AKn0IwpaXyF7+k+luDLmnN4W+zy4Jftnhw0RYzKWw
   GAUZkYPYN0N+7697ByaziUtKEIhEEVpzgUokWf+jkPpSlBImTNC/nZjjr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427688034"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="427688034"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 22:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="20162915"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 22:18:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:18:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:18:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 22:18:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 22:18:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcA25EtMrGo0gC7gxwk7hzfl87Zbbr7EWEtd5GbWQtGJD7S90lgk2omtEyTXF3MUBMbVkpXhrZVXwrtLqltU+aLy5uFo2/Mib5jjnIx+bW+RfNCJS7c0rA1CzTFFgNdMZh4v3tgZwxWwsCplCwyZNkrEC9tajeR/N+yXwQFZJOZ7I4fGyr7HoYI3KfyaIlAI7Rmg7Ayj2eNfolPj6S0mNVkpfu1BSaa4vNOaspYO43YOKFPyoV0kgZrUwi0yJ3GA9YrpN12B++qUOd3OD9p9A8Vs6HAYMp1rd/Fex3x6wO8PY5LKZO8z5FJObxmzTxfibqoWqjVEfOyDs7vnUUkzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KRtugM1LmX3WjA96eYFys5Hl/QYtc7mAP/79WfYVy0=;
 b=iq+0N84gnyRn2tE2s9Dhfd62rQGQuiY9GIRme7mgPVDlMeQwgRqxcTLXzjCy8O04Bzi0t0Iuj/FLIEC3eMsjJ0L/fjTs4nrmGcBvY9N1WsyEoGy4g1febLrx5KcxN1G3HAUgDv9rYquP0+f0S0qqjXxTJxIahmucDNw8VhhxKJHJjKwTpR/E671RhoEgdCijJbU67VFYFcRxf8oGmGLyJ1b//GwusT8K6QXvfqt5Rpi5CHV9FkpVZWXL8DgBhEEWbPrJQRAsmiPOFBWLmDwE6qEDYqByAgO4GFiU1O0yiUJOUzyZv7BuZ5ruHMc95DSH1HIr18ch59SafNX8ry/NZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 06:18:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 06:18:20 +0000
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
Subject: RE: [PATCH v8 08/10] iommu/vt-d: Convert stage-1 cache invalidation
 to return QI fault
Thread-Topic: [PATCH v8 08/10] iommu/vt-d: Convert stage-1 cache invalidation
 to return QI fault
Thread-Index: AQHaON+9gqYm6qxxw0mBt1mNtusbibC+OXwg
Date: Thu, 28 Dec 2023 06:18:20 +0000
Message-ID: <BN9PR11MB52763B5B4BD9E2ABF700DFF78C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-9-yi.l.liu@intel.com>
In-Reply-To: <20231227161354.67701-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4822:EE_
x-ms-office365-filtering-correlation-id: 9d371e90-23c2-4947-7db9-08dc076cc9e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +UHQwRcgv+NdJPAaNq5S8OxEKRU7dczk5rpbEtFuHSblarHPLrpiqh5N2HrZnExMQtaslXST2njxV6Coe9w4kjWxvpX22JhADN7tvxPXyl/oMR4usXZY5ghPb7pkekXDxMVZbYoHFwpppEGgY0Le0dpZyd5/f6QxeyGaG6jicamACY9DpE7+0yQ0OadjNf3M0l7/6QqiQctxe9fKkYM4xOoOReGx3/KTNk0avVAuoIETm0WS7zbYwZXvrBApg7W7UdFOQZNJQR65gCu05ClusPNLikTv/la71RHQmjeZcmr33/kx7SG/0UHaz2IvPkqrwXzhrEnHPs+lVxWsjm7I5fR0U6YAxJpA9GVEEablEALjuF1gFS7q0UtM1Vg50B5CyBjtESRMi6RzfwgQ3ag+5G5oXVnTd74e8SXbxE0wtsanDtTvCAF+VbiGnDqC922O/VAyWDUmXQ0uMHO5tte95gxsCT1Bc2bFogoNA9ZsFCNg+Gz/81mhUNST1JzO3pbYfsbuikFb9HSHVo8gLGZf3H5yedYjN3JO8G+/DTmm1Zq41NB/JSAqDw0qxZ3ZG7N8KC3gALI0Wt2uNBXd1/YZMFLcDKg/eRqrtB6aKi/lUZT9D/YFUd4Eu9mUhUAdudWV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(7696005)(83380400001)(6506007)(478600001)(71200400001)(110136005)(38100700002)(82960400001)(55016003)(122000001)(52536014)(76116006)(66946007)(66476007)(316002)(54906003)(66446008)(66556008)(64756008)(86362001)(8936002)(8676002)(26005)(4326008)(7416002)(4744005)(2906002)(5660300002)(33656002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m9BPZwuU9VleMBg7FlgPAfwY2TrXy7uMtfIUmp2snPiNSHgHk8JpYcTAbjuC?=
 =?us-ascii?Q?D4c0Sm5ZH7aJXqqZBpMev+Pq5mQ1s/geUSZNyBL1njg6OGhqOHhyScDeUna4?=
 =?us-ascii?Q?rVLptoOv5RC++rX+6ZJETH9VFIpD07DaosJ9ZfCY505K02kNyrt8yPHh/O33?=
 =?us-ascii?Q?3rXqtLORiwJXAL8RXDu1yCFKloFbui45Y74iklsOpYY7XDbnTCq8sdhgEOAL?=
 =?us-ascii?Q?YCIcRzjfGiAL7dovEk1q2j6bCj3/4eEcQFP5vbuWYtK6zdNqN7MfrSdOAW1h?=
 =?us-ascii?Q?mhqrw277k8ciFQEdGOLz1wPhXbP4roxdK61GK+MP2vm0knw/zm5DFqX9NZX6?=
 =?us-ascii?Q?BcqNKHYzdh55u2YvPpl2mNn4qxXRNwxr8gWjZ4oPjZ6vS0dvQLspsSJud/BD?=
 =?us-ascii?Q?r0tfzGFbcLjlFq1IDQWE62tIpwuz+9ewSzXVAL4lSOyFi/k0E704AaKNv/Qj?=
 =?us-ascii?Q?/1WAz43OKmy28f8uo1p0pDAdy/Y4vMAWuuD8YArbvVcv9aXbIwq9U3N5ELTk?=
 =?us-ascii?Q?zkVk/ih60i/i0uxNIb6y8gJTTPXcJMPtRKhJPuQVjqMINL8x7J9nauqwFIvx?=
 =?us-ascii?Q?uDXtCDtE6EN8wy3MyxcB+lUjEQ2z67nY+VI/kltK4vEY/3YsDY8O1G1fi0gY?=
 =?us-ascii?Q?JM9IEoHessAqAwf8m0sk42ZvoOF3IVU7UMzPsK2Nk5bUis5ObLgRCbpN+VwY?=
 =?us-ascii?Q?Wrd4Vpag4wxXLSnNocMkEdEp+h24Xh2fEuQVxztBRALMA82rwEhy5p/qGN7r?=
 =?us-ascii?Q?oIr6tbmLb6k7Sc2g2zzmiNwUBsJz5jJFzPX21r4LZKyUE0+BQKU5M6SJz0EJ?=
 =?us-ascii?Q?Cfkp7I1RYXn7KiWPkwGzsWI4u25H2EmiZphQ9D1lO/wp2mP31Re9KbF8iC1F?=
 =?us-ascii?Q?HehiSkNgcHKFtrgliZW9VqV293Gph/e+BNw7yH+EVGr4rufQTROkQaQZipCN?=
 =?us-ascii?Q?++ZTCxolcuYVTEYlC6IKg9xFYmbj9equBOF7d9QoAD5I4ozPwTEcH5pCAIB1?=
 =?us-ascii?Q?0WnKwq2OQVgqvfQDKQbDP5h4DrJ0EktcjXP6GNKeESkLNo2VosNJKwb0YTrm?=
 =?us-ascii?Q?yfOgsqNCRHP5QnM0LH6YwHgLDZqx2W0lgzWdJCGSaIbADKjEMfj43jjjBEqz?=
 =?us-ascii?Q?pAQhyafK0pMWKghta7p08g7AZFq4GenvXTeSt1t0v8If4Fp6u/5xztbqh/wi?=
 =?us-ascii?Q?OOuPKwUhtLdn4jXCocSASb937cgGyKzLIJEgVkQiAp+9bE22V3+69SbODMf3?=
 =?us-ascii?Q?8a/b29NmtziG/TOt4JMK1YHD7bnOmFaNVRIT39d+/2crqldviPre+DXird99?=
 =?us-ascii?Q?pdfTQdEewc7vsuQsFcNSZMykzQ5LoBaACWazAUfZeicJ5xprjRQR2GbvgUA5?=
 =?us-ascii?Q?LoQ75mw9ZSmfuY7AWQHLT4QgudoFtA6tPhvxm4J9mX8VBw3cKViGX6aMfJF1?=
 =?us-ascii?Q?mqa3Gg9K0/eCmGq8i+XyWVjSU8CNPS41hGJCwINtnyTLMgb7DtL0ydkFIqdk?=
 =?us-ascii?Q?UdlULpu3+CbsdDv+1v6tXayy/nGbhU+UYEFonR3w/WI9Vlgdtr/WgnOcjT/6?=
 =?us-ascii?Q?k3i6sdpf0tidnNSmEglIkrImUkENP7nz08bD2eOh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d371e90-23c2-4947-7db9-08dc076cc9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:18:20.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tQXclZ70r1WI10kkJkdJmY4KTK0dmEuicgiTlwYgg2jNmBd5xLPk75c3wZvt4auM/HPJP2Joe69fqoRUC+i8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 12:14 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This makes the pasid based cache invalidation and device TLB invalidation
> to return QI faults to callers. This is needed when usersapce invalidates
> cache after modifying the stage-1 page table used in nested translation.
> Hardware errors during invalidation should be reported to user.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

