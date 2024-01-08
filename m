Return-Path: <linux-kselftest+bounces-2708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA7826785
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 05:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF971C20B6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 04:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D010F7;
	Mon,  8 Jan 2024 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mu4L6Dfn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BD7493;
	Mon,  8 Jan 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704686837; x=1736222837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1BZxPey4EA+hg+6LDc2ICxtvC2/zLfSZ8i2i96+OmWY=;
  b=mu4L6DfnLSoLchoST219gTCsUoze7GRw8uKhRHkzgrM39EqMiPhBOOTk
   3YJI46V9mOXPVv0VS/pdSGmqJZOeksAVudm31wEEOVKtWvALsNWs2SEj2
   3akiNaIsLG0FwGxoQ5V/Pi8zmwk9HPYNsX3JzzYvNVXn3hync1FHMWkkH
   2eOhp/2AUrbdHHhTp+YyPcbe6jpNEfbieZ4MEy34LSq0sR9VckARPpp6v
   9LHhzYo03OD0LZiCZ1rrc3bZvTkb9DmPWFfLb48+Bo6O463OvmDvmihVK
   NbvKPiB04RFPIaBveHFsDWSxqfg/6Rtc5yD8FV1WRRmq7duGUbqQQsi5L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="464189906"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="464189906"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 20:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="29654489"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 20:07:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 20:07:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 20:07:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 20:07:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 20:07:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htlluF+fkWanC9NQe396UB8GjwJAkrsivyQS3yR/SJTXPhzOaCAKDqg5ZFkOccjfg2JcEltlDoJ/UoXt+Wx1v42ehNrKQ0SBbe41C3/a/Sj7UWdO0k+Qffyee8j1U0lpgCUd2yrPUMgRPABfh+U2D/cDdFWGQw0dGMi+RJwGLPUStLIeeNLbrnGDzT8cF4oXrFyZrEuCkR2PTQDYUqxxkkVTy4J8KPb8QAh4fK+jr7yDb5c6hFuJxGFFB0PmL3+lQ4j5FVVDQhzlYsW3VRxp0c4O3R/B1Wq16oaGeVxks3f/4d8ZV2+QZhGtXULjOMdab5rr4hCzeaxpx8SxYVxzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BZxPey4EA+hg+6LDc2ICxtvC2/zLfSZ8i2i96+OmWY=;
 b=c8bBHwq2FD4gi+mAcQnCiGIZpKZ3PhmXyHttatqrPbIZZOglRhYBxsHAdDwfRhELP/8O4Iz2QVmGoWkKlWqmsAtDXBD2VITUiBnJVhFS+nvflcw56q8sz42IbY23akOfKjXINFT23cHpaZNHNpDCLlEBx+bRqBpw2BO4KcBCW7HhoJ5Vf0xilhmTGFtd6/E/AKf3bcRUNN87UM3K9JxKuVvcIWq2agYrMJPtXsNZulay1cSgaHZ3tbH91M7f9FdO1wHXpiJM4Hs2nO0mT/A81g6kimqYIyCiQcjOcVk0qpcsPdSUurTMUe1db/czvwkbnC9eSHsCiEgT+or8yp/iHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 04:07:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 04:07:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Thread-Topic: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCozh6AgCE2IQCAALd70IAADhuggADPEQCAA/GQIA==
Date: Mon, 8 Jan 2024 04:07:12 +0000
Message-ID: <BN9PR11MB52765C91893A28A7D21D324E8C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <20240104143658.GX50406@nvidia.com>
 <BN9PR11MB52769EEDAE2783426144E2588C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240105144516.GC50406@nvidia.com>
In-Reply-To: <20240105144516.GC50406@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6991:EE_
x-ms-office365-filtering-correlation-id: 1ff0e0d1-b160-4428-b434-08dc0fff4ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bO/ZlxXVEjiuMKR5z1B8qLWl4AadjgCRGb8TS/S/2RwO5nLcQWQw49B4pZT1oij9J4m3ztxcvTTmF/u0shHXppltS68rCSh1C2+NxNJ6EXgUBSJS8hLwedU3wSxFUrh4mZLCD9MVsYE54CgU6GKx/EuShAC86ffWHtOfqGqP481kOZJd8GzfUq9FQeJWo8kGRDe6ydM1HTUhC/gI9tQ9/ziT2PJkR3PKDVGfyw70RlzSRpYovTWMJBud/AzlLxQkHBUl1tkD57LICLhb1xfuHlDTxXXrkmPTfpgUW8NEYixFMUMib6LEkOMLU+V4cwJD9Tl6o/33MJEF4d4H1n4FrN+roj94IVAYseWQcq2bC01KG5xPcgDiCGfZibYBd6ppkdxgNjY2XvbtDZD+c4ZQKE9nqo8/B35RHM5BeTM8Dkxio8B5v5jaZ+ePq2UKSdeHCZciW2R5a5xqv6vpnWJSyBn2rZGHs1AArDazEZ3aZe9Yd5e39wlIrQhhMBMg7lF/4ZN5D533dczK2odhqoRdJeVGqOjzgF2HBYaUg3ZVu32lOzXFy+TCo79+e/xQC9zrUrQVleKNWr0dfDUxxqSD+sFX2kbU4mKXl/zqgPTAsPFxGbf3KedMuL5inY0vwlE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(26005)(83380400001)(33656002)(7416002)(5660300002)(86362001)(6506007)(7696005)(71200400001)(478600001)(122000001)(38100700002)(9686003)(54906003)(41300700001)(66946007)(66556008)(6916009)(64756008)(66446008)(66476007)(2906002)(38070700009)(52536014)(8936002)(8676002)(4326008)(316002)(82960400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PhhxOj7L4ttO1n1gYVkTdxRndAb2YTOKLueHxZDblDmw+hSaxZ8apV5EnMj6?=
 =?us-ascii?Q?R9iX3OhZ832eOtgond1wNPlwW/vjzspOrFII7sgx5/EE3GWbCPEnT3/3TFH0?=
 =?us-ascii?Q?n30HuZAZnal/d0ZzUvpW6OOsQ5mlKX/7FbTscjZ1AFUkogT5+9HnC5DY3UHq?=
 =?us-ascii?Q?ug8AMQxk1UQ29ZyXDefd4YIcy7g/mhctYYX+wyFSRAERdm4oKvYrckqCS/+m?=
 =?us-ascii?Q?d27F3khMuOkQBOW+ce7jSgDAGaX+7IQtIAfL8qxidaUmp5C+YzFaGlBK0RPJ?=
 =?us-ascii?Q?jBScKWPppkJt/AGytPC2sx+e4RLhkCajO9m/gjKd3LrBtrxB6Yn25Q6REyz5?=
 =?us-ascii?Q?XUzNwAN+Krml8KOWFiTeH+HOHfM6MgrIDdDWgt+MbIbMFj5vVQKm3s/ubJRZ?=
 =?us-ascii?Q?VVT4PJfGEymjj5qP+25f6AR69ngMEe9mvr53S+8PjgnxqCCctHwz73ASnhge?=
 =?us-ascii?Q?hjxxv5VZaJOWJDmBPKWC881DxOKAWj2iWW75ojnX46ucAfLXtaXRwNZdjMFx?=
 =?us-ascii?Q?49dD5al5KpMdJikMTpSSbFsyK0vuzHa1KcHiGLuREioRsNy4yRJ6qMWK8P/x?=
 =?us-ascii?Q?U8vvCplCMoYu8PrwQbKzisI6xePhXQvNnXTPEZoNKA6lzwi+wxnQSmKYyQm+?=
 =?us-ascii?Q?PnPKiSYQg9JXlfzSahKK2XRbLIbQR//oZ+igK5OOHgTwFv3IHozQ/9wA9NWT?=
 =?us-ascii?Q?2WXvYzN9irWvbByf/AaNoyFjGGwhH2CBJeOBBrZmsrDOXszjEchdDYiCdb9Z?=
 =?us-ascii?Q?Z1NmW96RmMQ3cGMW5+ouaLLtAfHB3tQduwKrbQgASJkZcQ6UyU8zaudwjAOb?=
 =?us-ascii?Q?C4Vm+A5rRvhTZSPqZ++v2c5z51029BaObvYzWkDzxyGhD85fj0Wpj/za6vxp?=
 =?us-ascii?Q?r3ONc/DZ2lTENYj//37F44qqigP+FmjDrYyUp4nFpLEGzLETrdx5PbrtNcF1?=
 =?us-ascii?Q?fqh4bihtiu6CjOKSVw2WOqjvTu0ikNDpT8XlAPvAUzGj+GMBfgSzOinK/mEW?=
 =?us-ascii?Q?bSO5Ns82iUAuteKsWSFebso4y4qqv3GVSJO+4jSr2MAt4pFi3EKrV4I34u73?=
 =?us-ascii?Q?iQP1PYo+kkUy+fPqhg3dEb3C9CMWTCjdAnP4vBx4Z819LLPKIl+9kp0R93GU?=
 =?us-ascii?Q?v78fGK96ecIEPpsIpUvNC16K9/x7efP6ITsqLn668q+clW+4jkxpaEKwLTmE?=
 =?us-ascii?Q?EW9yP7pO/Wxu8IR0R+sV8h4CaLvDj6aswISgI73DqJlD3AbMNNfYkj31YtKo?=
 =?us-ascii?Q?PrlFQlAIPreBlQXQX7iIN3SCvSCfU+/YPV3o1v+BbR94t9sjXvygosY7vyUB?=
 =?us-ascii?Q?L53eeSq6OWVMqwPtwe/Amtsjc9e1HZDdmWBRn98KiaYPpqBlfPK6x4f39+Ns?=
 =?us-ascii?Q?JbDwGPkBs20bMlpIUPVtJ1/dEVUMBN92R3s2NkkMNTjQBFrO1s7Iwnd/i7vp?=
 =?us-ascii?Q?ojMb1JMGyPCudtG5KQpyQhSHPawteii++0ko8189SrtnZoxY84MQW2iibiEU?=
 =?us-ascii?Q?36zzwWaSNfIRtcCrv6aGpBKCoqXJOh5c0uqSxCwl3OtUJOn52+TZLSjLKVhQ?=
 =?us-ascii?Q?hfIO7Bs2SiW6/WrFePfkvET1MiSZW5mTZqD7UXQ4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff0e0d1-b160-4428-b434-08dc0fff4ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 04:07:12.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaWzIUXkvHB2qk098pPUkEYw3H7g6RCj5uLe7I5TqdJkXBGgZqlPq+CbRsRl3FQMYFMZ/0GiTYqfqcwgxuqbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, January 5, 2024 10:45 PM
>=20
> On Fri, Jan 05, 2024 at 02:52:50AM +0000, Tian, Kevin wrote:
> > > but in reality the relation could be identified in an easy way due to=
 a SIOV
> > > restriction which we discussed before - shared PASID space of PF
> disallows
> > > assigning sibling vdev's to a same VM (otherwise no way to identify w=
hich
> > > sibling vdev triggering an iopf when a pasid is used on both vdev's).=
 That
> > > restriction implies that within an iommufd context every iommufd_devi=
ce
> > > object should contain a unique struct device pointer. So PASID can be
> > > instead ignored in the lookup then just always do iommufd_get_dev_id(=
)
> > > using struct device.
> >
> > A bit more background.
> >
> > Previously we thought this restriction only applies to SIOV+vSVA, as
> > a guest process may bind to both sibling vdev's, leading to the same
> > pasid situation.
> >
> > In concept w/o vSVA it's still possible to assign sibling vdev's to
> > a same VM as each vdev is allocated with a unique pasid to mark vRID
> > so can be differentiated from each other in the fault/error path.
>=20
> I thought the SIOV plan was that each "vdev" ie vpci function would
> get a slice of the pRID's PASID space statically selected at creation?
>=20
> So SVA/etc doesn't matter, you reliably get a disjoint set of pRID &
> pPASID into each VM.
>=20
> From that view you can't identify the iommufd dev_id without knowing
> both the pRID and pPASID which will disambiguate the different SIOV
> iommufd dev_id instances sharing a rid.

true when assigning those instances to different VMs.

Here I was talking about assigning them to a same VM being a problem.
with rid sharing plus same ENQCMD pPASID potentially used on both
instances there'd be ambiguity in vSVA e.g. iopf to identify dev_id.

we agreed before on preventing sibling vdev's in one VM for above
reason, but only as far as vSVA is concerned.

then given the new finding in err reporting I wondered whether this
restriction should be applied to all SIOV scenarios (but irrelevant now
with below explanation after another thinking)

>=20
> > But when looking at this err code issue with Yi closely, we found
> > there is another gap in the VT-d spec. Upon devtlb invalidation
> > timeout the hw doesn't report pasid in the error info register. this
> > makes it impossible to identify the source vdev if a hwpt invalidation
> > request involves sibling vdev's from a same PF.
>=20
> Don't you know which command timed out?

unfortunately no.

for errors related to descriptor fetch the driver can tell the command
by looking at the head pointer of the invalidation queue.

command completion is indirectly detected by inserting a wait descriptor
as fence. completion timeout error is reported in an error register. but
this register doesn't record pasid, nor does the command location. if there
are multiple pending devtlb invalidation commands upon timeout=20
error the spec suggests the driver to treat all of them timeout as the
register can only record one rid.

this is kind of moot. If the driver submits only one command (plus wait)
at a time it doesn't need hw's help to identify the timeout command.=20
If the driver batches invalidation commands it must treat all timeout if
an timeout error is reported.

from this angle whether to record pasid doesn't really matter.

intel-iommu driver doesn't batch commands. so it's possible for
the driver to figure out the timeout device itself and identify rid plus
pasid to find dev_id from iommufd.

Thanks
Kevin

