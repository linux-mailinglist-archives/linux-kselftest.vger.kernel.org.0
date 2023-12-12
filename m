Return-Path: <linux-kselftest+bounces-1636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72480E202
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC3A1F21C2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 02:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714DC1FC5;
	Tue, 12 Dec 2023 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZROWe66"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28795;
	Mon, 11 Dec 2023 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702349020; x=1733885020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GZGAIXKArqvN50iukXR4eGZH0j4NbThJt8fepWQRPCs=;
  b=PZROWe66F+aXp2e5vSdFAGEPwydPtgddSYvcxtuCaxpPP8zSbHBjlXG7
   w02peVLo1TLbVtaTNWKNznODmL5QJtHC1Lw2u6NFsaM2TMpkQYHDqvn+r
   EWGFdC13poRYDQ2+lyJJ5jt9uG08rw/iG//WEvKKIH25c8FBuXxszHRi1
   65BAS0LBb/WNwWPyr34C2EBSDafshT9ilxFprUaZs7ZDpFg/BDZBdxJh9
   cBUIUYOHvqs/Mj4aJCngQ7buN8WhcnOG0gZokBY2ui2/JlZD9FyNiz0Cm
   JRkc+tbNzemmulmJVdtTi2ChTP0ayO/mTdRK04u+82iD6ZO/BFcc5ebV3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1894012"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1894012"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:43:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="891398751"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="891398751"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 18:43:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 18:43:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 18:43:39 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 18:43:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk1rlWTUMF5HzIZWGWoWPvwEEs+nmLEeGnVlxOvwJBGadwPpST2cK6EOD3FGKTgtVLW7vooWVU2OTlxrgAPJyo+gFN4MhRrpQzInQHEQYV0GSKhotFGQ0i1l3Upqim8TQy/QQiojwp06f68J1azgqwCEDQREq7fwit3hXF6g+4ZzIe1qt0Q/F8gUW7HSEE7kDwad/zaITG86GkXoBuTzLyo3SR+S14iVbEWNdSAKVWPVdwQnFzAqtO+qxY0vePhB+QxGg6NTvXLZG14gQJX2U7u9ca2khaEinn+powxvcBeJ1Q8z7bHZ00VMo2gdEv6oTThWOOYZTFH7LLGsQc4mUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpSQ7N+btnNEEotJvm6ycuSTqiTYeFji8K+qb6z1peo=;
 b=aJGqpOMSxKbf0TCjVeXMyaJtTB4CL2G5KLATmDrTgWXLekQzV3RllV9i3hwbtKD2BiwwuBzNI1a/L9W8kMS8k399LeDSbnTBYOs4bh72ONijK7Ialr6wGkYYoxaf5dVkGpeVLkMZ3o1JvP29DOGiASuflj6/3ksXvL6LbErKqcAJJr8BUiXDC+74+pCe17UrsLwgVjLKf2e6PP2cWfkw5xeOMCsmw3DLoeiYPwBVkXj8nEr3SJf7W2Sg39x5vZO8TUW0ia4Sjx3JixGhEjxuqDbhjiaYmohMzHAOYHNfq6IqJzry2VwptwoyRxs96GdUSNehVpeQVDfFzJzB3YmuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 02:43:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 02:43:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2oNLTxoUOTUKh4MiWO0yFiLCkdsqAgACPmPA=
Date: Tue, 12 Dec 2023 02:43:20 +0000
Message-ID: <SJ0PR11MB674458A8B7319F30A67FE55F928EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
	<20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
In-Reply-To: <20231211110345.1b4526c6.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8443:EE_
x-ms-office365-filtering-correlation-id: f771e0ff-0d3a-4777-f45c-08dbfabc1a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdDxospZFW3+N6AtSYk8gaAHzD9F/aFfxwKwfU9UWdbeOU9HO3iXOzyeklgKJfxL9PQFgdthkjGyQyKRQBMazAem9gDaWdhM/xw8EoldPmyA35rw9LLJPqlTUe62whnTZSFaCepaf+gZZcZ733BV0DoYfCBoi2MLdJ946/VUfKGRRE9TTe297niOkI/MrmOeRcUXtlFdiqPSlDQukkhxDr1eArSkuKRAhuFeh3lcnathqYnBJGAVAAtM/o5adRviqfwa5nSA6JFK8pjyM3h/RhuwCTu5HQDPFeh73VIcBtTmUYfjDugkAcy4PbHRHkErsWHq2oontm6RZnU0QvdlLqelRtTk3eUTfwMIQiKv7gVNMSvqcr24GqxyDItkbSHNBT02jKM01smeXLkPtrrXpZj9UCM3EOOLnE8NPCvbfCmt8x3HIYVI0IK+51Ao8FEyjW3VvFHQUhrmtl5u+SWzkFnjMWgiirypkAqzX73JO9udmSOdYhTA1EyazNwLqTc5SXEjAg4pfMGDNwpYfpuZLSUBhYRyR0NZ8egbNMql9IJMPc6QLhielhc6BP5IgjvG30xbEZiUI7wRJsNsnY/6c2Lcw/cqldNFNDWb15FAaXI840/9JGKH9s/G6Fflyd4H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(41300700001)(110136005)(122000001)(66446008)(33656002)(66556008)(86362001)(66476007)(66946007)(38100700002)(6636002)(82960400001)(64756008)(76116006)(6506007)(7696005)(9686003)(478600001)(71200400001)(26005)(83380400001)(5660300002)(7416002)(4326008)(38070700009)(8936002)(54906003)(8676002)(316002)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DRUqtEhDxAZRBR1ETzJ5jpmy32gumb45frZX7eeIGXEHDBZ7M0UpaL5txLZN?=
 =?us-ascii?Q?Ky3z7MCDv6EgGKfLJWPc3OQNdVZOy9l2pzZv//6W7K1GZPcuQnJNMgoBj4JY?=
 =?us-ascii?Q?v0PCxQ2cmkz1g5cOrsKF5pA8trn15Sc0ZnBzY+usZPB+Yk+IsMOc65cTNKg+?=
 =?us-ascii?Q?PJ/M1BqMjLgf4Cc3x6/aUUNbbKnLGzgZcLVF5iMhfcdFEqEvT2uTv7ga6Nur?=
 =?us-ascii?Q?ydOQSJPQv3eLUv2WwdmIhbFS7fPnZ05Pd7IsQJDUZf64fIXnKrLK4FmkEOb1?=
 =?us-ascii?Q?dq9C7/vvkC15IHNYhITNtqo1kQviBx9rz9HL9ImiFL/W7QuA6M6H/BkUBC/l?=
 =?us-ascii?Q?Bd78avmc70tQeoXV6xuk1b5Zs9hVBc7j7SoAzvFLPpVxoUGzFZ6jE/WseQGW?=
 =?us-ascii?Q?e+NTmjvi9UhrEmB/cKKqq/Gu7tiMrhzqEZ1R4me8yiXyGMTFE7nzpKAoGDmM?=
 =?us-ascii?Q?sbNFJntPT/1qRE7GqDuz7JMj+zmFFuOvDb57M1grCGKHJuQdrTW6ZApSs8li?=
 =?us-ascii?Q?4kax/YQiFkcdmZxHnMef384lEwsj1XMSpONjCqXm/ioHRBcxysblBcZNK4oe?=
 =?us-ascii?Q?Jd1HogGR+ZFNSktAXtOOPmbAS49f7OV16zYWMahgkhiokDDB0+nc5W0/YoQW?=
 =?us-ascii?Q?1FVcodoXwXHpdms1x65iWKhA4jmkqt2Kx6Sp67+jMAGnh4dnqYS3KtBrGB9X?=
 =?us-ascii?Q?JXpLCn+h9xylJFS2ZJCej5xLtDMP0bWKngOs2J+0jJfP6FOupoy9m0BEkUgC?=
 =?us-ascii?Q?EA9iplObquSjLnVaRjwZd44ZDIdxvX4q5yGkcqeA13Zc2kY0Zkwikjdno4k4?=
 =?us-ascii?Q?mTyXjOucPNuajZ52jUOCwhWJKZ+2Z8Kt/wgS2wPvh+uN+xp0msQmFYZXxAQY?=
 =?us-ascii?Q?7aWXFLTvr5b1nGytdbntpm3p8rTGYQB6aLcJf0o/Xqmt6mSYNfLma0VTzkNb?=
 =?us-ascii?Q?55XQWZOxgSNnn1ROmT5X78FXPO6JdRhmhZPZkgq7VCATdSE5Sf/tciacqStj?=
 =?us-ascii?Q?9AC0uMruE+7sa3bi7P0NYR8yavrNeLKMsPVbvK8kOaH0/SgH75tA9wuNyy6v?=
 =?us-ascii?Q?SxBnT5xRqmx8wwPphP8qzCFI/JwTx1s7KU0kDtlGPzr6iMg/sGWdKkvpXZ7x?=
 =?us-ascii?Q?yiQ59LffeMVRplJ1IWb2Ivm8F7jZNTMtmNe3XH2Whr38QV2mttv76bgb68+a?=
 =?us-ascii?Q?Nk/AiOu4uoSJ1+5XGYYoQarX3D5lEC9CU3uT32LEumENrzsIdbXmpjpwtM9u?=
 =?us-ascii?Q?alSkdENxTtRURMB4zaR/1gZPK5hSF83W4HLFAQZxkcdCaRYLUqK3/SEovA3u?=
 =?us-ascii?Q?8RJfsLFCDBSJiNaUgsgKbHAmMT9ZM6yT6m7TM3NOl4PsA0X4am97Jqij0g52?=
 =?us-ascii?Q?zs8ozBTfr0e8Sgf8Iu8l6Uh+8vPtkT690vh/cfBH6m/HpqDRwIdN67tYmLPO?=
 =?us-ascii?Q?LIZeYTH8JC/DQioEnfsNU2lp7G4z61TF91gx0Jbuyy7Pa+lDtrbYlPxhD0/n?=
 =?us-ascii?Q?D1Lj9ZnlPZ/Pr1xqphjnoS5bVdiyTMZKX/WUZsrsyRp8E049APXXqbS+uIJ9?=
 =?us-ascii?Q?rZ5mWLvFn/GueKLuu2/SUFhvYtGxafmjMsY4yX0/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f771e0ff-0d3a-4777-f45c-08dbfabc1a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 02:43:20.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jc2OfRzjKq4iVQV2hThHV1qHKJJjyT5f8s06rJnazQj4L9oOWPoz2nG2VZ9RV/UiAmIMp6MEwa9GDzGvnc+3QVSgSSBQgEkfZMUObLzN9Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Alex Williamson <alex.williamson@redhat.com>
>Sent: Tuesday, December 12, 2023 2:04 AM
>Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
>VFIO_DEVICE_FEATURE ioctl
>
>On Sun, 26 Nov 2023 22:39:09 -0800
>Yi Liu <yi.l.liu@intel.com> wrote:
>
>> This reports the PASID capability data to userspace via
>VFIO_DEVICE_FEATURE,
>> hence userspace could probe PASID capability by it. This is a bit differ=
ent
>> with other capabilities which are reported to userspace when the user
>reads
>> the device's PCI configuration space. There are two reasons for this.
>>
>>  - First, Qemu by default exposes all available PCI capabilities in vfio=
-pci
>>    config space to the guest as read-only, so adding PASID capability in=
 the
>>    vfio-pci config space will make it exposed to the guest automatically
>while
>>    an old Qemu doesn't really support it.
>
>Shouldn't we also be working on hiding the PASID capability in QEMU
>ASAP?  This feature only allows QEMU to know PASID control is actually
>available, not the guest.  Maybe we're hoping this is really only used
>by VFs where there's no capability currently exposed to the guest?

PASID capability is not exposed to QEMU through config space,
VFIO_DEVICE_FEATURE ioctl is the only interface to expose PASID
cap to QEMU for both PF and VF.

/*
 * Lengths of PCIe/PCI-X Extended Config Capabilities
 *   0: Removed or masked from the user visible capability list
 *   FF: Variable length
 */
static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] =3D {
...
        [PCI_EXT_CAP_ID_PASID]  =3D       0,      /* not yet */
}

Thanks
Zhenzhong


