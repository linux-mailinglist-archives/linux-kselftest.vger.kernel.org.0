Return-Path: <linux-kselftest+bounces-2647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8AC824CD0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 03:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0CD2870D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E81FC4;
	Fri,  5 Jan 2024 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTyY1cW7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9920E6;
	Fri,  5 Jan 2024 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704420995; x=1735956995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kjymEDg9kzhfMAk1t+u1/GMcvA3bUE2Kn6IywILIapU=;
  b=YTyY1cW7B7xkdPblLMsxgBBibKTSbI9XHx5Sl8Y1YEDZEe3pIDAaJqN7
   dX56VYlzkN2UHQDMucjo7r47iwlKcSso5NmntsWPUsfCtE3tSGj+cu2Ud
   xTPa8AQvmwHDO8XroIEoQoW4NNwHLl86LUsu4YAySJaulVZhz9jOBJcuA
   v+vZrwrsL6C3bnT+LtOF/id3LQ/qthbW0C7bI5r6zPaeILfBLhV8N8Xub
   IZ4Ou5DEfWrdmZg3vzuka8o5gq/9veRnl7SmqHoRu7pS3DbtafHnYhxpP
   ZjCBXm9ec3swnibmc8bm5wt9RevJDAmKuP4okckKUI445MCsew6xV0I8R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="396296419"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="396296419"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 18:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="22366725"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 18:16:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 18:16:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 18:16:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 18:16:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKh3Qi1K1grHSr5YSzkpG+oPcXp5OitgpP2aKBa5QMztPyW//a35nZNvpc1RIYgJpKho7uVLhEvyRF/J52BESqb760gWUTNxWoKaQ10PBndPJYFSPDCJZZ62XvnXRNzL3st+G8xa60pZ3NYmlzAD529uIwZJHiXrneSFgUfsZLXpJJqqhULZHVaqLOfXAcbOeIWBcAsX5fzUK1OrU/qJFUI5cY99JsFSxQ5BCpSUnNC3ly08WG5bAjomvM299raIdx/7dLUmEzravaSInjlH8XIWJBAoC6qtbbTzEAtMZQc+9feKW5R1qtsIPPHktROpODplC4zSkjl+sr72SkCOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjymEDg9kzhfMAk1t+u1/GMcvA3bUE2Kn6IywILIapU=;
 b=SohM8SXIG4jP6Ixt1dnuCJptlzwvgNggm3KNkeC5WCs5baDwmWCYiY/PI3tdQcV7FZ59F2MoW5iNjszF7CF9UuixYoa35GoUaFMxPfQFQfqTfZphhTWIIYmOmZDisjWzza3OxazMS3WvYF4SBW9AFv4U3vQqELACHsN8XTLmhDJYd5Z9PgXJeLK/KwufvWbTWheainkhDkKQGmt+rQOOGD6z3KmBf1MJ9/PeqSt/Sxf6jMJAqoxrfF+f02G9RE0x6ovqkQTPz6bVgNuoO5mRVcIGaOJBcum9PhWoe4M8+rwVZ/k1nqZ5JS51OrBCAX3fSdW2CulFIH6t7CwbeeUTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 02:16:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 02:16:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCozh6AgCE2IQCAALd70A==
Date: Fri, 5 Jan 2024 02:16:31 +0000
Message-ID: <BN9PR11MB527699A02C25431DC3438E468C662@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <20240104143658.GX50406@nvidia.com>
In-Reply-To: <20240104143658.GX50406@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6687:EE_
x-ms-office365-filtering-correlation-id: 609ec3f7-0db9-435e-9386-08dc0d945530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0t4N4HBk8SfOL8vMloIPyLyDz2Ku1Kc48ze0aVYY1gvmiRsy1oWhHKocRyVWPxLYNjB6GLMCTKGsG4AuhG/Xo5xCpEpy4SJrXSWkLpCcSm7ozeFbX4imCRYJspM6IqFlwSi9Rd90xtl4OK9QaUjpPZVwsFe/6n2+ao45V94JiKvE3pSIyUl2yzgWp+p2gUpQTpiJWit5MBNUSxZB6XWvszl6AJ3hZIN2wUVrw9bk0MVxX/pYmrH4aAgHeSXmfAJD5oNqJDnSOMLdsp58JS1/bMMOd+3awDvPf9pSVLAhslEEUg+gSpcE/jMNjiDRSZ8dnV0cQH+knBHCnf50m/kAH5biDYEHxuNCcl2eSljIvIJVeNiMZgj2WZ2zlASFGURnoPFJksHUlQhGuaJ96H90k6DnCEQC+Ycihy7hvp9i810dC43yqJN2CI++YytgA+d8PVWYwf/JTqzi3nwCo/1MJEVdc9YrndghgkbitaSKEgaoluWJGuqYvGiOVQ5kqo3y0V+UzqtjaMAeVvMFg0ru5QTCsqc+eO38XQPyHOzLEcw1lJH443zNaM7TtguZLxHhTl/Ou4N7CWMpZ2IDQWHblevziBP3ZMHsFTnHjtQhS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(64756008)(66476007)(33656002)(6636002)(66946007)(66556008)(66446008)(76116006)(110136005)(8676002)(8936002)(54906003)(316002)(7696005)(71200400001)(9686003)(478600001)(5660300002)(966005)(2906002)(7416002)(6506007)(38070700009)(41300700001)(52536014)(4326008)(82960400001)(122000001)(38100700002)(83380400001)(86362001)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/vWzOn887aMZs5ty484usgSJ2rQf9DnPLxPlNnQrVircQBcWu/SYGeyetzuP?=
 =?us-ascii?Q?sUrMFgjVymrEHehH2vpchjwWjK19i2ZDyDwZFUf+lwQSghzvQan6lGYzz1om?=
 =?us-ascii?Q?C6955yfPeZGCTZ9YdnGOn4ptaQGMB6q8IvtJc7Le9AYV1yxo1L8+0nZh8U/Q?=
 =?us-ascii?Q?cRtAGApXNwrjPcVgbPFfT0cF0+r5MM7I5455OMYTA+2k0sEjNoAmUQDwELrf?=
 =?us-ascii?Q?JfJjv+tWqPtDv6hO8Ya4GG2bcjI2p0KNQZrpvKnZ3Y06wHdy74RGRAV41K9i?=
 =?us-ascii?Q?PWBRiF26Slv5tYSV0HZoF7ZFReeZuNPeLpMHPXTCq7CuWp4hZ+yQdiFdlnr6?=
 =?us-ascii?Q?68ZdtWrSSlaUqiBGUiX1kypiJ3cCMgz4/MonVpLzcHeFp4GKuCsZt7B0AaxH?=
 =?us-ascii?Q?Scrh7adcXgA+54NR8v9ZjRlJOkI1Eod0tEByWJdJETLmwBrvTcpSRq0vts1C?=
 =?us-ascii?Q?5ULgxR7vQzbHBki0yfkqTaxOM8mHnVCYUqujae+cq/eYk+ucJqgMcOofJHAE?=
 =?us-ascii?Q?1Me3KyflddFAEE7rnCN9oPvgwrsX17VJIIlYLOy0aWmEqQ7xZo0m1PX1ly6q?=
 =?us-ascii?Q?URPis5fCOlfFuHFDN+OCOmT1JevxGri5mMIxbXUwfry8r+eYfrqlN7s9iHDz?=
 =?us-ascii?Q?3GZtgCm8wrLfgnAwA4RSyNg6sGI8PwDWICsX1Bi/XfH7QIBc3sBw0KfgILbM?=
 =?us-ascii?Q?pvDMYehUY/HdWy9gnjLZtrqcAk7oBDSLobWZE4cG1xM7xbhfT1sfSbhBVD1P?=
 =?us-ascii?Q?qSicL0B+CqsnTpw0euaVYO0/tlkXTZ/1xBnji/73QyOcvFktEnP8INg993Jc?=
 =?us-ascii?Q?GoXwCz4gFixBxFTmKLr7NndWRxzbpCHA91Ft8HhUFGFcrD9ar/CzOFeCmItu?=
 =?us-ascii?Q?GBDSnwA9DRsJ5RpWNPRqQi39UxsTvufFYfGJRuTile3fcLRD2BNe1GKLGyi7?=
 =?us-ascii?Q?gLukU5CbIS4VseodSDHLJ5Va+BJKflX52wJ89f9d5gFk0wkLMHBwjwa0hgqA?=
 =?us-ascii?Q?yFHQxnfUy3RJYzGsAILjrOH+7lgPLW6bHplQayomCcGjA5T4b2oNJzxbt5zl?=
 =?us-ascii?Q?ZmcgszPoFU0mnWMdFQtvC0qkyeN+c0WATus3ohiYNu0+BfL2gsMBekCQjEjI?=
 =?us-ascii?Q?Exyk5gUAReGSMBy/CCOXRA/LWczYedfPr2ZpO40iYxvo9i1xRXdibvdU4xID?=
 =?us-ascii?Q?/hJYjXJz+zjE+sd4y4rNLMA5QqtZN7oKxmM/rkI23cB8+IWiyEdAkMWJN4mC?=
 =?us-ascii?Q?N3uepWYf5YMXoftjGJ5vrrZlhLp5BwtmY/F8/Q6sNE90KOvukYtiQFUNpTEj?=
 =?us-ascii?Q?QoIsBjMFM1GuHitMHVd085KgNKqHIb9Z/HWBIQ2P1bVJUhtgxSselgbVIL1i?=
 =?us-ascii?Q?Sy6C4jWb5fHjm3n22DHjGOAi+Xb0ei3/HpwO8I6JCk254CXx9k3cb3DUQY7m?=
 =?us-ascii?Q?GNsGkdve58XovAp2//lJz4UiEyICITF/ZtUnLfqMIsjUlVLVMgtl6cn1r1Xd?=
 =?us-ascii?Q?QOWPNjpjVrI6LMUfPsFRNXh9CzaFeBd8b3BU05j5UdltgajJ3kq2qcpIkRTe?=
 =?us-ascii?Q?VvP/JzppletPkU2R0sinxYiE2HPYECPSjx6iA+Ll?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 609ec3f7-0db9-435e-9386-08dc0d945530
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 02:16:31.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: As62HaFQ5KQZls+1rFQTTUqUZC5B8gbuorF7bfaTWiBk2ca75U8zmk9HUpdSgknHGMUedG9jU5RxQ/1iKtYRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, January 4, 2024 10:37 PM
>=20
> On Thu, Dec 14, 2023 at 07:26:39PM +0800, Yi Liu wrote:
> > Per the prior discussion[1], we agreed to move the error reporting into=
 the
> > driver specific part. On Intel side, we want to report two devTLB
> > invalidation errors: ICE (invalid completion error) and ITE (invalidati=
on
> > timeout error). Such errors have an additional SID information to tell
> > which device failed the devTLB invalidation. I've got the below structu=
re.
>=20
> IMHO all of this complexity is a consequence of the decision to hide
> the devtlb invalidation from the VM..
>=20
> On the other hand I guess you want to do this because of the SIOV
> troubles where the vPCI function in the VM is entirely virtual and
> can't be trivially mapped to a real PCI function for ATC invalidation
> like ARM and AMD can do (but they also can't support SIOV because of
> this). :(
>=20
> However it also makes it very confusing about how the VM would
> perceive an error - eg if it invalidates an SIOV device single PASID
> and that devtlb fails then the error should be connected back to the
> vPCI function for the SIOV's specific PASID and not back to the
> physical PCI function for the SIOV owner.
>=20
> As the iommu driver itself has no idea about the vPCI functions this
> seems like it is going to get really confusing. The API I suggested in
> the other email is not entirely going to work as the vPCI function for
> SIOV cases will have to be identified by the (struct device, PASID) -
> while it would be easy enough for the iommu driver to provide the
> PASID, I'm not sure how the iommufd core will relate the PASID back to
> the iommu_device to understand SIOV without actually being aware of
> SIOV to some degree :\

we plan to add such awareness with a new binding helper:

https://lore.kernel.org/lkml/20231009085123.463179-4-yi.l.liu@intel.com/

and with metadata to track association between PASID's and iommufd vdev.

but in reality the relation could be identified in an easy way due to a SIO=
V
restriction which we discussed before - shared PASID space of PF disallows
assigning sibling vdev's to a same VM (otherwise no way to identify which
sibling vdev triggering an iopf when a pasid is used on both vdev's). That
restriction implies that within an iommufd context every iommufd_device
object should contain a unique struct device pointer. So PASID can be
instead ignored in the lookup then just always do iommufd_get_dev_id()
using struct device.

