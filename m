Return-Path: <linux-kselftest+bounces-2837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3669182A750
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 06:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93EF286EE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506702101;
	Thu, 11 Jan 2024 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DS7biPIP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896E23AD;
	Thu, 11 Jan 2024 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704952280; x=1736488280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hMByXdK5p+7zRzsAO+EpD3ISwu+tZZ/0DOchrvRAkus=;
  b=DS7biPIPoff4K2xGYnaAxeXcIxIwloKt4PyqLOEx5zmP2Pm/3mTmBaLl
   k7Px8rczs8cHxYzAXf8BOFxzeqDrhuMgof4L0/ZWoOWvSHIUT9LLtsi9N
   CSCph9Sxhzk0uQU46FDy4YxE052KotZ9DCgUPQl2zwQoIrKaVgj3ybcx6
   7Is9CW7BK3jcbJj5PiRK+jG5v6YVeXQSX6+bQMwBk5VV01L3Hq7+OmZLD
   6rVfV1oqXzDtYEpPMN02lrXTCXuJfcyYTbzjIjs81VA4uPKf8Zsw28JCz
   ac57AdT3ZhpV2e7N5QTysgXaQlC/++Ds+Un/ATov+knWYRQtDVhFRfu1r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12102811"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12102811"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 21:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="955634569"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="955634569"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 21:51:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 21:51:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 21:51:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 21:51:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXTNPk9VwFxZABIxRjcM4/cRGC2kMlgsS7D3yUAlYhFKYtIMTFfh5HqTZ6u87iceosK/+PvQ0v3rHlFOC3+NW0y27qk4OV4F5UkoEGlZKyoXkVHm3tQxwlrD07qSMoIO1MUCaFMOHRUxxrXTcWFLqGqC6XJ7qOzdXWN9ldZScrVjLufm0RPHQzQZrCFLn8yxkf8OfkylndeSZVxe9Eo22jGs5W2dyjaSPQCuVxP4HXFaQ7nNeqQH6kUBrHjboSa1vaMMTleOKFSMrb8SqQfsUNNHdWTgpX6FKjPIWDgu2IHuE/TGu2VnqQcMeJVDMBs11dJM/K4Tup7+CY5t832/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWhUIuM8WrAlo2yyO2+R/HUW/SAFv6mFW1du8eh0pmg=;
 b=RfJ05HovzBse4oUELQEWFv4egy2DbuT0tTXcsTwcT6twqyu5BNqg1FM85+pYKZtufcTz+/R3r4fBIHdKUdzl2FjsnXdaMYqYmXBdc0WcBKxjBQr13knhaPD76YXD+5MALYUnxVLX09AMAVVLPcEx72zMoAWp5u4lPTrOQFZ1FImDQwTzVoAcSdMkUTFpl0X/+wNHpQx1n6lKM4MRMNv6uSJnJ3ml62SinOmD0ffj75DcD8qeSkmE11ogflCYSMlNSIcRroLHl00Oil5icJCxqmuDmURc7xLjmD5ReD4IAEp9rH/Pfx3PkB51jomkI1Zg8LQKRVonoTXqOqI3D9xLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 05:51:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 05:51:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: RE: [PATCH v11 0/8] Add iommufd nesting (part 2/2)
Thread-Topic: [PATCH v11 0/8] Add iommufd nesting (part 2/2)
Thread-Index: AQHaREQfMgcp3Gmjvk6R+p1VFKDDpLDUG6gQ
Date: Thu, 11 Jan 2024 05:51:14 +0000
Message-ID: <BN9PR11MB52769BA4CF43CAB1066437338C682@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
In-Reply-To: <20240111041015.47920-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM8PR11MB5670:EE_
x-ms-office365-filtering-correlation-id: 49f67f2b-ed62-4916-26cb-08dc12695275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mi4BThruvyLUm79iFyMXLzl7Yesqy65MHKVM95/3aYN4qxvTtZfPWlt01v2ZkK3P9xEQSlqN02z3ITuIEhd3a/HnxTFsCuZBan2Z50fmLFEx+QgSOTok4b9fEheOHgLaK5eiIrIhlNZ2YRmDBKqUnkQkAUXpLUW0fDysQq9k+BH4qWH4usa8rxFUhbr2EcWAOBsShOn/koLle4SaKQuf+U6AXIBqhz9D4gJFfncsygMweJTDgo1j/QLTLpENdV2N5JStkZqme53xPz5aQJKIpi6mIXhf4jXLdCY75H9MQvoU85Y+vBifKDmYz1tU7FLptnyqvV4YXSVRWzZsYj670LKgRa3WIqgGuA8HJA/vFbKPW71KVNmegXaD9rjhTH0GdHWfs+ZQA3RI65wNCMrZbMfUCLkV4EqrjAIBLSxIPevXq/jAPUVLAu1F+5OVbg0T4NTaEjsPN3JXKyeGH1jcQpRDJNoJN/uf05tZeCjj0Ek+q+7cWs6I3J91vppRy+WKkUXrNvATfYUhuzvj//I7aThBaxpLoxR4MZQwP3K+JQZ2DnY9FcKIkSDoO2B8dbfzjX01cCqLOZVAPqkcMdAxi9sEpa7rejR2u/9anRSTm1eTvn0EnnK8QWTFcljDOM9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(83380400001)(33656002)(76116006)(82960400001)(86362001)(41300700001)(38070700009)(38100700002)(122000001)(54906003)(66946007)(26005)(9686003)(66556008)(7696005)(2906002)(110136005)(316002)(6506007)(64756008)(8936002)(5660300002)(66476007)(478600001)(71200400001)(52536014)(4326008)(4744005)(7416002)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4KYfqXRP7h8U57aWrKJ9liyXSpVlEe0aUz57cz5u6nvOOfuVy+8+UOuzUqd2?=
 =?us-ascii?Q?mPNYbDLRixot3D5pumCWhsdJ0lpsD/bFeD5R86bkHmCl64em35Xd8ich6pMf?=
 =?us-ascii?Q?XDY2an6BrzxHvSvb7IO4QrJVJXEw03nFx697GFHIn9tfdZ8LMfcA14lH/iTU?=
 =?us-ascii?Q?kp6A6Coc8FO0gLyQVfpUT5EwmfgTD+ZEi9eI0r4w1t2bABINz4oacKXOXcbZ?=
 =?us-ascii?Q?dLZuVQIZtnc8xUnF1/QbzzU33kEVMguOIo62dzGC3wRnLqg8EYA2dAY2UgIg?=
 =?us-ascii?Q?xDjt5j/PwZ1LuS4VBxu4UAI803iwzMwWPcRgiQLWzwGUpEgzmGPXQSy0ErrQ?=
 =?us-ascii?Q?t9ukv5s8aoS6j4zEUflPblyLCt3fqUCl2FY1Xfej+D7r/e/kLteWdkTIylsF?=
 =?us-ascii?Q?9xGBGOJ9RZRnULDske2G08+cUCXQNIpU00819XwpradDS85T1qJzCk4x2KHq?=
 =?us-ascii?Q?9ZRI2oeShWdqdC1O+zjn2eOMMndxvlWyC489B4oO2eUUjys/2myD32lxl56b?=
 =?us-ascii?Q?GhL9YsEiLbdbD3/okYwLHU+JgrnO2pqFO7mVZ1aUx8BD0wb+6wq/43+Hb13S?=
 =?us-ascii?Q?xEVPY7NquPwFqcUftebm+7cr/r72mULQKFjmWxK9DxZTKoHEkHG24MQziAOl?=
 =?us-ascii?Q?tKlXeFTEZnqO0RhlreXJmoZNOTzGQPwVG7Xrltwc+tc/HlcKUD1UAbU0DAJv?=
 =?us-ascii?Q?aiq6+VvHD32t05jtDxb+1rMTIWe/qLBtYOEpinyvOxH/pG27spWls5uKcLq5?=
 =?us-ascii?Q?YRVWqCH2BZB9WGignWOJlvD0h4Hyn0cosAMijOX86+2mLuZ4HgIoEyzKRJCr?=
 =?us-ascii?Q?oflytMTMt0WevC0bfyT6ayIoZJg4mLkkjxXD2RXc+fxtvXa2NQleX1z9f85K?=
 =?us-ascii?Q?fGGF0xMeIhZz2JF/mgxjDvrft/lCZIQesItx3ITBqXRZOci2UFCrFdM2guGn?=
 =?us-ascii?Q?Se51/mtUO9AOWjJ0Igm9r/2DRNfGmCznm+kv01pTMxhJo4DaOfx0Q+9nzyVb?=
 =?us-ascii?Q?mbEbLUGkp2aJlSWO8OA2r57/TJN7PIcDQiwr4VOMwxahkggLdkPXvejXB+C6?=
 =?us-ascii?Q?9x5zh1nCQj8ePTGWr+KJ89VUryYHvYNkQ453AsR4JHJ8G0lhb95VwByApjt6?=
 =?us-ascii?Q?qQ8M7pJoJgXJtCqx2BMVwQYu41pdWUh5eC8HvmauZruPTLc5kNbxBSTrOKA6?=
 =?us-ascii?Q?EWptfv84fJ1kDfj9YGRdvdpYaJAFBIAGQ3u+260xC63EiZVGLW6qkLV26XAF?=
 =?us-ascii?Q?OF1KYreIujv5uyJXJwrHDII+EbxqwvfvRcR6Cwxa0d6fQykKTuTn8ovQ7rGS?=
 =?us-ascii?Q?k9NILEUAgGEiGHCxI92tz86Kc883NRTBK5yo/dbkF0RUkY1G9MeAftRffYey?=
 =?us-ascii?Q?QIcn7b5QTBZzHc17FAFjgFWmPLGeWZoW7+PWH0GkLcfrcgRPms9BT+M7Uo5d?=
 =?us-ascii?Q?EROkrpqN90dtroUAMGvdAw6o3PtxSiVaK3uocKNjG0nCdOAGqwPAPYZroHc9?=
 =?us-ascii?Q?RmfPsI9juLioTeKqlT5RyjgVOk+PQwz0by6l6m5vfhLo7d/rN+8TOuln9EqS?=
 =?us-ascii?Q?10Zj8ZQlHOmOa4m4tq00ek45QX+xyCw83wtZUZ++?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f67f2b-ed62-4916-26cb-08dc12695275
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 05:51:14.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxEVMOORZ6dJVIw0PE+3Kh8K0Yyja28lQvgNVElKSseYil7qMWlAKIBGOKmeQftZQlIG/mtyuu/lVC0ehBxNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, January 11, 2024 12:10 PM
>=20
> v11:
>  - Drop hw_error field in vtd cache invalidation uapi. devTLB invalidatio=
n
>    error is a serious security emergency requiring the host kernel to han=
dle.
>    No need to expose it to userspace (especially given existing VMs doesn=
't
>    issue devTLB invalidation at all).
>  - The vtd qi_submit_sync() and related callers are reverted back to the
>    original state due to above drop.
>  - Align with the vtd path, drop the hw_error reporting in mock driver an=
d
>    selftest as well since selftest is a demo of the real driver.
>  - Drop iommu_respond_struct_to_user_array() since no more driver want to
>    respond single entry in the user_array.
>  - Two typos from Wubinbin
>=20

this looks good to me. so my r-b still holds.

