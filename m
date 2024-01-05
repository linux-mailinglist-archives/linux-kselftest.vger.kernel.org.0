Return-Path: <linux-kselftest+bounces-2651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A82824D44
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 03:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2731A1C217CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 02:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935992F4A;
	Fri,  5 Jan 2024 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbMMsJXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04A20E6;
	Fri,  5 Jan 2024 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704423180; x=1735959180;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nRAy/YpB9Rp3pVPl2n02NnpgSnzQYRLaEn0XIoaIQ1I=;
  b=fbMMsJXmtsq/eKdfGHBhQ/iO0Tn4ykSCWek8OIKBwXULUBaRQ14Mi/J5
   nxD7fDekJ0x56ZAH1OdYubFfRDWUtb6sAXVkna7nSrPDcXKkB5MuTgeHx
   WfYXV5tdKrOwMynBVEyBsIajy9YhNJtFzrrCaxpGp1yLIEvoP1LwzJFeE
   z6pwQuD0n0w9LlIfcA3jyf27mzjulyC17/gJyCfmJO17ugaqauZCxAuc7
   M3pGv4DcYUogBfP47OOG55WOGgKp7djprPQ4/kcLG/NeLflmbgCyccXDL
   d5Qwv09z8rD6IdGfDYjh/rCcm5K/5NJSKm1i11jG2oc3SWu5nsn5mY23z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="396303405"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="396303405"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 18:52:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773727612"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="773727612"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 18:52:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 18:52:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 18:52:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 18:52:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 18:52:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNwEfBNqk3Fr7XeTiPIf6CAx+ueFhEWmQ1kalF4avs30MwWOG4XL9+U7wngtmnsFG/TxoSQpEU2/8zrp/4Zb4kuViQFE3LnnjOF8rv4yu1/ETGdZuuDMEi3JOl/7xEtcet5cB5gaigfjpnDZfRSEXwL/l6O9cVNujWSMfdPuaZcliE52nC+LQwOqIf3s4qzZcG6qZdhNmlJX+C4YEJSHuhNNP/SvXFqw+0GHM3lqByT478LakBCN38Bc9wdV8ZbIv03pQm9J7dhlULdsHot6TP5ZuOoP164eTWOsaJN/R6PDgrYLciOUBWdubVg9Uxok++xnw1O+U1LqQnHDipvq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRAy/YpB9Rp3pVPl2n02NnpgSnzQYRLaEn0XIoaIQ1I=;
 b=WAlUWg61RrVkPzpEH4VBkMTrpImrkQUPXNglvkE0b6WfkHMmsWs9M/TgjoWg4a4PKGW4BRpG1dkg7sKlESLpV5kAtHQWd+N+KN2c/9lbcII3VOrZblPnBhuBfYdQL7pEKBwPFTfOD6u86rt39Rz5p1VzNsrPe7gpzkMPxre9cUOX87C86kgSiwTWnh6F9iustVObWD38tCU/6eNi/thyg75cMY0dFuVsdMXttZdUw8KQlAtx134+y7OQy7FFTOgpNhoftKYA/sdeWXmuhSfqBs5JH1Hh32g/YEWrtNTMM7YvArhrhXjRjryUe75YLe+ibAVVhxhu9OUcm7lhOOfGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 02:52:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 02:52:50 +0000
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
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCozh6AgCE2IQCAALd70IAADhug
Date: Fri, 5 Jan 2024 02:52:50 +0000
Message-ID: <BN9PR11MB52769EEDAE2783426144E2588C662@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <20240104143658.GX50406@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5791:EE_
x-ms-office365-filtering-correlation-id: 4ef16fa8-cda4-4712-73cb-08dc0d9967ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwwNMeNUCS74pW3murM+LdAWEFUI1IO4IJ65EtAcyJAldFZ+0vehqAFK1mTabuCrx19MY33kBPp0UUX1/jh0S1RptMRBiXYpMO5O433kOb54APvSIqF+hScRCIkA7J42C+My4nazgmHVJKi+Q/PjfRnJ0vEIJSDPjcgdjxFt+LveFTOACVWD7oP17Hn3tvKPUr/zVWnFNvE4z4bBNRofcp7IdVmupPA7aItj313xMXYS8yPcBwJfLR4m86hAuF1XZfqVDGUXLT7pUlUHWADbbE0zDyYHRReOLJYcL2QMpoR/sWNbBxjxCGizoqvlFEOyWHhGMCLkFFlnfNufdD+XzMJzV1wgsZHb11zCgxJ8zMSyxS3sd9iYu8NfY5X0INnBWNUC9JKKyOhdm6OYGT+Rw2yZ2W2DqiWlb9DG2goZsEbCgb1tvzXsTsjDkoWGNMguKa62qXZLMZA96gpi1ak4pCBQBFHH1OVQbW0mmuu9tWWyl5giNOZB+wbO9XzTIBOXCk1/8/U6CE7YTiBSgUPHICWGKbZwVc+k+3NCyC+MGHvkZZTEpSKpbNqs6XnM6fArAT4xG0pfsrzOCPAsroZBt/GqggfIAGtJXcDdMFDJHM8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(7416002)(5660300002)(2906002)(55016003)(122000001)(38100700002)(26005)(83380400001)(33656002)(86362001)(82960400001)(6506007)(9686003)(7696005)(66556008)(6636002)(54906003)(110136005)(8936002)(52536014)(66446008)(64756008)(316002)(66476007)(8676002)(66946007)(76116006)(71200400001)(4326008)(478600001)(966005)(38070700009)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6CHcRSO+UOAmhbBb2GhYhTZkKl6XL9L8xr2yUkFiuzpkhwwDFGEBzQtho7bU?=
 =?us-ascii?Q?MU8Z+TONY9Y/0xZBh9hWkinZSGS6NRXGANxbeSyE7VI44hJz2RTKy6rjHmWR?=
 =?us-ascii?Q?55q1KSYqJUiiul5AM+zKVZc8Ebk7WeWoU/KqrGvUnp68l6/XB6vB3XyNdNUK?=
 =?us-ascii?Q?rUDF36UG7up2fyPDOVKng6pThDpQJcrIjy+GHzhQxnq8KE6Nod0yO6m+cdtS?=
 =?us-ascii?Q?XGA0Oa7OUO+wVkA0aO+BoyXCoF5qZzwsrOOykeJW1PR8QH1w6crm0dvY4ViP?=
 =?us-ascii?Q?wz1WSNCLvpPhE7mY3EYPbJoDtVwI/TOITFKfLoUhY1drxAPEZ5GaTrm++G7j?=
 =?us-ascii?Q?ZcjlD0YKCDXXxezB3KzuorHHpzIjPconbK9fjKogt1id4MYkmK1bayJFWKDt?=
 =?us-ascii?Q?EsZku85JK5WMXqzObj0MlWvE+wlV7/9Nta8pSGCx4Gl3QVzbaP6TM0NANVYf?=
 =?us-ascii?Q?jB8x5uaoj20tc3CXMYvT0M/Wq1+Vy4OAH9o9mXzdQNSC/8qUi1E26U8GuDS4?=
 =?us-ascii?Q?QIC3T0n5geDyOlRKGlgSZgjeh6Xa69p9YYNai0XSkDeBaHHvwbCxu7MAZ9k/?=
 =?us-ascii?Q?uI8IgrKnCrdahWD3ZCewLMsNEkRFePYD4f6MCSsovKB3f8mfUDzwZqNL1XGG?=
 =?us-ascii?Q?H6dfjt5rd42fiXxGZlKIJwe7gcgdpexhUU50ibUR1nqjy021kL1Lf5WPMLh3?=
 =?us-ascii?Q?oM1hGU6G2Tg2AQfxEXSAE/Tjbk8LMnh+gZmgSpBJWyF2Tc4HyCK7vkzUfVVt?=
 =?us-ascii?Q?PMz5oNUv3OO/p2ZtAjWgU1+YzblfPC9n46ev5rJJCB+W3iBYEL3fqZbRyad7?=
 =?us-ascii?Q?2i9MKSiqRz+jEFRsH1Yo1s9aT18URXzqYQPD9l3IKZ5uJHjl7r0J6lPlUmhS?=
 =?us-ascii?Q?KhKaN7VklELGAjFqAijHb3w2sR37Ao1zY2HJrpPasBUQyqgAKgXxYBf3Vwn9?=
 =?us-ascii?Q?ZD8bdNGnasBvBSPdinX2owZzRuoswUQev8GIlewmFjVgY/KhsrtexnkCERoL?=
 =?us-ascii?Q?qH0kKOtDEtH4lZFP4ECH6rhHeQz/g1SnGW73IS4RgqqLUf0NRbqI5lR2fvd1?=
 =?us-ascii?Q?1kRWd756aw9rdJ1vMSkZowITx8ZH8fr+fHhksQJ4629CYGocs/xUjCf+gXXw?=
 =?us-ascii?Q?c8p9AtM70hLKQV8jRd9OPz55pDuaazk6uRBwMpaPAmy5P5kMVcES52qxHSwQ?=
 =?us-ascii?Q?ZFPFU8J1oKCzWcCayQYNJtEjaRGVU0HnueteXdc49avPr/5caCYMy1YwW55k?=
 =?us-ascii?Q?4ivgi7YcxvqxQqmpLdt/LvTk4U9xesO79cpLDmv5LdU/HhDq/1J1dvyZLii1?=
 =?us-ascii?Q?5FM1Fc4XuoLGbzBMg78z960rkjqTr3KnxUmXqlbgXHrIfsMqX1qe3sfatOPn?=
 =?us-ascii?Q?SVyhBQp3X0cOUxondzA3SEbSKIxOSPGlDmPwt0FpJ162Vre9u+4pTYxVE/+B?=
 =?us-ascii?Q?3/5sD3Be7jL6bXiiYKC2twjRZgBoSJ+C7g5XmcdnF4ENYdYCyhmN92l7D/TM?=
 =?us-ascii?Q?MdS+IfT9z4IalqoUjeBADl9LrbLtz9XzMBMByNSmjFp8OmCMNODSN8nMZISf?=
 =?us-ascii?Q?BKw7T/6t8s7WLWohcfzYythR6hoodwiyA87sLoBy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef16fa8-cda4-4712-73cb-08dc0d9967ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 02:52:50.2281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsrsOyKCCksMbcPTcGebkkKohkrUJtXUd1rgZTia6licLSxm6xEqoR9+uhwv/KxIqgRfOonuFXSRzZUfzNgwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
X-OriginatorOrg: intel.com

> From: Tian, Kevin
> Sent: Friday, January 5, 2024 10:16 AM
>=20
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, January 4, 2024 10:37 PM
> >
> > On Thu, Dec 14, 2023 at 07:26:39PM +0800, Yi Liu wrote:
> > > Per the prior discussion[1], we agreed to move the error reporting in=
to
> the
> > > driver specific part. On Intel side, we want to report two devTLB
> > > invalidation errors: ICE (invalid completion error) and ITE (invalida=
tion
> > > timeout error). Such errors have an additional SID information to tel=
l
> > > which device failed the devTLB invalidation. I've got the below struc=
ture.
> >
> > IMHO all of this complexity is a consequence of the decision to hide
> > the devtlb invalidation from the VM..
> >
> > On the other hand I guess you want to do this because of the SIOV
> > troubles where the vPCI function in the VM is entirely virtual and
> > can't be trivially mapped to a real PCI function for ATC invalidation
> > like ARM and AMD can do (but they also can't support SIOV because of
> > this). :(
> >
> > However it also makes it very confusing about how the VM would
> > perceive an error - eg if it invalidates an SIOV device single PASID
> > and that devtlb fails then the error should be connected back to the
> > vPCI function for the SIOV's specific PASID and not back to the
> > physical PCI function for the SIOV owner.
> >
> > As the iommu driver itself has no idea about the vPCI functions this
> > seems like it is going to get really confusing. The API I suggested in
> > the other email is not entirely going to work as the vPCI function for
> > SIOV cases will have to be identified by the (struct device, PASID) -
> > while it would be easy enough for the iommu driver to provide the
> > PASID, I'm not sure how the iommufd core will relate the PASID back to
> > the iommu_device to understand SIOV without actually being aware of
> > SIOV to some degree :\
>=20
> we plan to add such awareness with a new binding helper:
>=20
> https://lore.kernel.org/lkml/20231009085123.463179-4-yi.l.liu@intel.com/
>=20
> and with metadata to track association between PASID's and iommufd vdev.
>=20
> but in reality the relation could be identified in an easy way due to a S=
IOV
> restriction which we discussed before - shared PASID space of PF disallow=
s
> assigning sibling vdev's to a same VM (otherwise no way to identify which
> sibling vdev triggering an iopf when a pasid is used on both vdev's). Tha=
t
> restriction implies that within an iommufd context every iommufd_device
> object should contain a unique struct device pointer. So PASID can be
> instead ignored in the lookup then just always do iommufd_get_dev_id()
> using struct device.

A bit more background.

Previously we thought this restriction only applies to SIOV+vSVA, as
a guest process may bind to both sibling vdev's, leading to the same
pasid situation.

In concept w/o vSVA it's still possible to assign sibling vdev's to
a same VM as each vdev is allocated with a unique pasid to mark vRID
so can be differentiated from each other in the fault/error path.

But when looking at this err code issue with Yi closely, we found
there is another gap in the VT-d spec. Upon devtlb invalidation
timeout the hw doesn't report pasid in the error info register. this
makes it impossible to identify the source vdev if a hwpt invalidation
request involves sibling vdev's from a same PF.

with that I'm inclined to always imposing this restriction for SIOV.=20
One may argue that SIOV w/o vSVA w/o devtlb is conceptually immune
but I'm with you that given SIOVr1 is one-off I prefer to limiting its
usability other than complexing the kernel.

