Return-Path: <linux-kselftest+bounces-400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F337F3D0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 05:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2737DB2189E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 04:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80472C2C2;
	Wed, 22 Nov 2023 04:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4yXwbut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D84D4B;
	Tue, 21 Nov 2023 20:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700629119; x=1732165119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Dd6kcDihbzHdtVqBkLdsW3hDZYGpbXqsqgcti/kvr0=;
  b=b4yXwbutxFJWq3DqeLKd6yMGUhl6h1rJT7O5SGxVBn6EsJpEn0JDx9HC
   NrJYy5CPenZcXqGNGEYse2lWzuUECEyRIDi6ZycFmjHdwFffKj4FIJg24
   n475F4xCvw/FlS2OfG7cAUybGKSBk2Ph/DvzbFgPmcywzE36J+M7OespQ
   qHN9Hu+LxcrRUjNvABVeI4h9upjWY089+OpmIvaT9u9RPxTmHd49O2eXn
   oHFNwT9ihycU/UyIDHdNBewcuxJy1HzNoMV8XlmDrdsdoWHvUSiDd8cc+
   LcsVMKBYyZE7iHQCvpLkHH69ETl+cwT+7EdkM1QOAnDNrsq3uyskDsffp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="478191020"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="478191020"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 20:58:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743264579"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="743264579"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 20:58:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 20:58:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 20:58:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 20:58:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD/cUvwDuv0KbeWgYcQ/ttvvzXBy6mE9mj2hywwUYcYYuzXFgjo0w8o+T/ORzOpzEiBJiYrvWPINfW2ZuOpbZu9xcZJ0vDg5mf4DheOFyBlN/CgQtHcJAmsdRB/4pW/IpJi/8lMMBWMHSdW9TesjF0tHMSjkQKnqdIdJLH8y2l3BBrRWlUJwz6C+QFisW46UIKV5SyVQMjINWQnUAp7svKDISVAmcOPKKJ3B5SIa1qVsLy32xGdi7MZGyelF7sUf/AIRKKd6kCDUdytHgQxlo0s6SnnWCvxWoBezLCvwlCCZN04msl6H6zXCPonzNx99NqVXlzRFomT/JkFMlAOM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dd6kcDihbzHdtVqBkLdsW3hDZYGpbXqsqgcti/kvr0=;
 b=XBiZFTaN4uB/uVkv78MRY8ODxEqFVglwCn42/jdgG+NOs8u4qIU6uziVfLF5G+FNBq46aj44ZZUFtvJ5HQfbqLGZsu7g+59EqPgQmcEa0Ih9E0Xdtpvysqlp70NFRAuWU57Fsk9ax0wVHNHXSuHpHB7PUYU4gXNbGmtQMXbms5ESPUrRSeSWse3mKo1yRwp1cvm7gKBy84ntNGRhieDcczJX2/wx6VmRnwz3xoylRRf+ueYsV7EMpEAT5x4CtSKTTQ16Ha12xIGmWjykCD+HMATtXeRPVniF7wqMalob3uohnSRzQ6a/OeQnDmFYZ7ZcnP3sPJWgsQ5/HwuLTKUd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 04:58:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 04:58:24 +0000
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
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCC4vaggAD2R4CAAD710IAAnmMAgAEUIFA=
Date: Wed, 22 Nov 2023 04:58:24 +0000
Message-ID: <BN9PR11MB5276BC5DD9824923C8A3ACC18CBAA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
 <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231121121704.GE6083@nvidia.com>
In-Reply-To: <20231121121704.GE6083@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4949:EE_
x-ms-office365-filtering-correlation-id: fd766d77-0992-4812-8b1f-08dbeb17a846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IoQT2MtvcE7ZVUFjQTUFnrV1PqIcxRDB8+ibIlqdL2to8ZYAKW0gO0204k9X0NG5Ca7CG10spuSiEf3TGLZEbc4jrDToDxUcvHHs51DrHtkfIeXxW9ntxhBn+FffmPtuQSZogtncn+skeTlPYqm6Pg1LXju74PInj2J6u42SsVdSDXfdxfbox+bRoD1d8SgdaPACUmXYFvbl3iUBe/6rJxidWX7eQHa/jY378h4bhf0DEZ1qMeVPGTVKD2yj5UHXe2p6jvz4EwpB5eLg4wArA5PAuIc+VZDYVrvhVd2oCUdS6LKYFdnR4296pd6jPWwLjms1W0qRrJgBlfoz1xBs7Jo58JSNY/xo/Grxcw+OANwXcFlDxp/YlFQBaS2i3P26Bl3iSeZRNPXBhMtnKq3K9yqmy9nnqw/AKsU+y7UghTil2ezJo3QbMEDFDL4NSanxVszSK7cdqnAoRjvNFeKfxeIGatq+xM7P8btG3mD13JFdYLN8OF+wJ6A+0EL5KY89oYn0YADni9Xac/8ORqY5SvNKp0E7yqY7ps1G5W2r8KnjNBkwJ5KUd68xwSm172GnD+oUDpAfS5zDun0xZ02ZZ7ofMadrmBWpeg806Uy/rBqMSFaRqSgyJFuq0Qx5Ztor
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(7416002)(5660300002)(2906002)(8936002)(4326008)(316002)(76116006)(41300700001)(66946007)(66476007)(8676002)(54906003)(66446008)(66556008)(64756008)(52536014)(55016003)(71200400001)(6506007)(478600001)(9686003)(7696005)(26005)(6916009)(83380400001)(38100700002)(86362001)(38070700009)(33656002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6MGkly+EP4mGQ9DuphZcGhU/0aV2a4qidOQG/hTY2xC9beorEaz6CDSwRNfb?=
 =?us-ascii?Q?9t28gN1IGQim39lTcm1Se3aA4avFG778sfD5MmW4uARo1Oiel68EMtBrruxG?=
 =?us-ascii?Q?38P3W4b1boWnc+jLZiYnbT9bP/RSuSyCXKAaPdfEpizaIz5g8OZQ8MTgheLF?=
 =?us-ascii?Q?3JXbhbmwieU95VXB/CX+DRGWWOW9ouynnhK3Zpu1hxaRkNpZclNyOywL86yR?=
 =?us-ascii?Q?/8/BWN6KH1MPxwwhNsX3c87wmfhgZcQX8AhAahfzPkYdg4PtLSynMJv83jIM?=
 =?us-ascii?Q?S3/QwZU1GTyoeEe0K0EVgfoL54JRx1kNz+SmV/c0MaDGtlDiNM9a64OXe6ae?=
 =?us-ascii?Q?VRFRUtbmvahROQO08qUAWgqv0iIAytTfoufeWBpq++LnepeQgT03X2lZL9Ew?=
 =?us-ascii?Q?svEzRcZVVS1BjS6RW9nEB4R1QNLBe40iV2oCMJPhbqMSHGf0EmZGGpL2T/8W?=
 =?us-ascii?Q?MUfIPQXtnjjHR2dFibzXvVzORxfyGGgquHqw0HwTs5JA9bqCqvvXWsWHMH5G?=
 =?us-ascii?Q?RasMPIzkwZh1IlGPy9qhxQssdvD1BvJoqRkTt3RqpVaD2HKaG1feF1vgvkRM?=
 =?us-ascii?Q?ZYaYjGfr6Pg2igLO3FhO2WAas4kGB5i8B6m3HYaYraZuIcI1gAsVEEgQAg4y?=
 =?us-ascii?Q?xLIRbff4Fc2BGg9Zn0vtoPQhKaxCGT7uFFVaUoBTZof8L8LbkD53/O1httie?=
 =?us-ascii?Q?OSFKD20fmL/TrBu+sgeNy/U6Pa9C/ZzXQ9fEcw4HdzzNMUqV6slS4D6BzOiE?=
 =?us-ascii?Q?48y2oHkyNlzslX6cmQLvOpr/SC/0hZ0Bz7J+VtqtR85gFWEENtb17QOh32WM?=
 =?us-ascii?Q?IAHgFLb/gyts/xRM9GAw8NlcdNs3UqWZ4hUMk5RaahNPjrQbyPO8mfXKr1vX?=
 =?us-ascii?Q?xZ7HJ/fOteIg+SKEf2I2k6nFkmO1SOgQ8EVLmfV34ZOIE9nyPmh9+LoH5y9P?=
 =?us-ascii?Q?+uli8Hz/fYmVrPQlxLtIfdyLJkgp2iwRWU8ZMaQ0qFoeLREhnD0/bd7c9nAO?=
 =?us-ascii?Q?qUBZrabwD/yonVtN9Y0f3JNeTtYTayHgaRLG2+8xzXqIy6LmtsgpQFnTKqps?=
 =?us-ascii?Q?wyJszsYTcmD5V3o72/W+B9phbaQ5LbjZhYXDFJRaQ7fqnYmWXQaX1Tx0gJ6Q?=
 =?us-ascii?Q?zYcRIu5v84rXq8fXIzpxF9/4Fh+KFgPZn8m/RDHasOW4exscNiKBdSGm6OzA?=
 =?us-ascii?Q?NGIkCS2mnLVeeSWwO05bkul7P6SQnLElwCGg867QVWZXrQPGgUBqSERI49Et?=
 =?us-ascii?Q?H54vKfg06lBihN7zmVv4tbNuLuBjJ9DnSZoNcBTkAbm3Vdc4WhL2PZ6ZQXl0?=
 =?us-ascii?Q?yt88tq76MIF+B50RlbBWR077wPK/6Y5ggJ8aDgd5CsXwfpUxjpYkfFuqhf/G?=
 =?us-ascii?Q?/Uxt0ySx9SuDfbht+R2qqnCkVktFA7PgWA1Pr9AiNiD2RgEQkzGPQNKI1IZz?=
 =?us-ascii?Q?R2Jmh9bGj6VEO0Gc5rWBd0EwjJ3PbiY0Ptik986vc8GL86AoCFBFzzRq1Abj?=
 =?us-ascii?Q?UycSn+VtXnMthvFUgoiaGg67rE+JEM2S5KhN4JlL3z/VGwWCnGBMSeOTPLtT?=
 =?us-ascii?Q?b2i3z5PZrOcI22X8yNxsw2j1gfi5WWfM8Jpe3a9I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd766d77-0992-4812-8b1f-08dbeb17a846
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 04:58:24.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+Q7h7O1PTkLbBhyOKpgIT8iN8HIBLYtgacWDsGobGBLdSvW/nb7ZSoUX8HUZVbhxkH4GHHoPc3YEcYJ+qND0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 21, 2023 8:17 PM
>=20
> On Tue, Nov 21, 2023 at 02:54:15AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, November 21, 2023 7:05 AM
> > >
> > > On Mon, Nov 20, 2023 at 08:26:31AM +0000, Tian, Kevin wrote:
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Friday, November 17, 2023 9:18 PM
> > > > >
> > > > > This adds the data structure for flushing iotlb for the nested do=
main
> > > > > allocated with IOMMU_HWPT_DATA_VTD_S1 type.
> > > > >
> > > > > This only supports invalidating IOTLB, but no for device-TLB as d=
evice-
> TLB
> > > > > invalidation will be covered automatically in the IOTLB invalidat=
ion if
> the
> > > > > underlying IOMMU driver has enabled ATS for the affected device.
> > > >
> > > > "no for device-TLB" is misleading. Here just say that cache invalid=
ation
> > > > request applies to both IOTLB and device TLB (if ATS is enabled ...=
)
> > >
> > > I think we should forward the ATS invalidation from the guest too?
> > > That is what ARM and AMD will have to do, can we keep them all
> > > consistent?
> > >
> > > I understand Intel keeps track of enough stuff to know what the RIDs
> > > are, but is it necessary to make it different?
> >
> > probably ask the other way. Now intel-iommu driver always flushes
> > iotlb and device tlb together then is it necessary to separate them
> > in uAPI for no good (except doubled syscalls)? :)
>=20
> I wish I knew more about Intel CC design to be able to answer that :|
>=20
> Doesn't the VM issue the ATC flush command regardless? How does it
> know it has a working ATC but does not need to flush it?
>=20
> > anyway this is driver specific contract. I don't see a need to keep
> > it consistent for all.
>=20
> Given that ARM and AMD need this and would have serious bugs if it
> didn't work this way I'm mildly concerned that Intel will be missing
> something here..
>=20
> To my mind it seems like this is just a hold over from the prior
> design.
>=20

As Yi/Baolu discussed there is an issue in intel-iommu driver which
incorrectly skips devtlb invalidation in the guest with the assumption
that the host combines iotlb/devtlb invalidation together. This is
incorrect and should be fixed.

But what I was talking about earlier is about the uAPI between
viommu and iommu driver. I don't see a need of having separate
invalidation cmds for each, as I'm not sure what the user can
expect in the window when iotlb and devtlb are out of sync.

then we just define hwpt 'cache' invalidation in vtd always refers to
both iotlb and devtlb. Then viommu just needs to call invalidation
uapi once when emulating virtual iotlb invalidation descriptor
while emulating the following devtlb invalidation descriptor
as a nop.


