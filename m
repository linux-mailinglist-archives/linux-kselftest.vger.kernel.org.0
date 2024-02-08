Return-Path: <linux-kselftest+bounces-4332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82784DBC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8BA1C23C71
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B66A8C6;
	Thu,  8 Feb 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmwRZMRO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335F6A8BB;
	Thu,  8 Feb 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381921; cv=fail; b=Q7ormIAXVBsu8A4geHVTYbcdXI2+OHYfhhca42P5kIg2KldlZGkY2N+8k72c0vSmthayQnJ29SkAsYteELdWzSRkxCYQLgDfPU2mI/dZeQqtm2C6nc2F0TLD9wHIOP5w6LB4H1X1ZZfiMwcsnwppALcISF/cc+Dxz0H8uZdDyKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381921; c=relaxed/simple;
	bh=Ca3FQi0X4J56IB1oagHTHSoHRPU7Q3/Mo718L/ytiwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EN/CgrI1X41NHQZ6v+xH5Yi7kmg7MgmU32HmLlQ3RSVY72vuR6ZD53xTgDaRWCdw+uWlzlSkDZP74IKzzXNPg+3R57DZV7TnwMkRSomiHR9QMolUQOAkU9XjbHMtOMXQ0F4EIFwzvz0rAy7e1ICQLteb/zXJZAiXIHY3ruqN19o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmwRZMRO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381919; x=1738917919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ca3FQi0X4J56IB1oagHTHSoHRPU7Q3/Mo718L/ytiwI=;
  b=BmwRZMROrMCEJ+bv1/H08wQHBdoVPEPW0qgnDXPvAtW1hmGXFdHxbwzK
   jokpkTa+UIkYbfs6D6LHPYbtaEN2zBbz+U1815gzcu6CP+jpKQDJbLF2m
   bL5Cagz86rNaMLQ/2qaXMy/iCEg4Irhg28kmlQ4eb2MWPWuIU5gLk7G4Z
   pfLBc16ve/3qCSB66xzuNFB0UDXayy1PcVnTSyQJbbneCxAeIDNn3u9BS
   6XiT84FyBTTREjwPewYzYbKwbPFL9Q5MT8nlS7R1B5cweulTYbRxGKfmo
   +TqnsWMDv9fvt5JIdo5OVFdqtkE17UD7wY1/lHja9Zlp8zwvz/Mbi1yHs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12540311"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="12540311"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6368624"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:45:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:45:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:45:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:45:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:45:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjVbU3nZb/e4I0vJBzMCYXzYYQRUf7XxLoFrLk6wPZmzFsXP2XkzRftLllO+RXxJ/xX8ESZayEy29Y8o91mQVOcNkopj8+cPfCjySHYcA2aNkOKeXn0tTDROBL+PHJpiB4XeoxgZVOuDqfeh7XT/XianNcae0nz5Dvnv/koTCpYIh0Hnni7yLqEefSJSplwhl0MkXnYKlCyRNI2lF/u7txHI/0sAJg2gcdZo0lWIh3mvpPaGPs5gVhlgnYtlnUhTj4ZOFlktlG/C45NpoJcXyahvFizfRCshbo/BQknn++roAxhb/+TvmsLstA3/mAaJ4sfqfBeSjw60vz9Wizg7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca3FQi0X4J56IB1oagHTHSoHRPU7Q3/Mo718L/ytiwI=;
 b=iaYa1NWESkc3Am5LKNycMJq8bWxYSkgDe5ZFMHL8S02R6bNiOsSYxu9OalS92P9wN61/h6KwPH0WTJLEnYmuhWXQBIu5YwTwXDK6aBsIALLTsdldzkNkKEXqBi18vuvQj50Cjym/MxYxLdlogwIrdeI+JprkVlHQkh1V2l/IU24pKW+/4eeQzUqn/TjJuybV/cU0frT33nQs4gtHLUm34Cqtk8a9xbaaxISdFIWx4TAlZhCYT7M3e71aiOHTX3GEiBCt1KSxL/JpyUo/yr1WX5cSz8kZzJ0+bOT468K7oBaVeY0V/C5NHeHpHpi2+tcfV2jZMRTr0/mfHlrmT9eOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 08:45:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:45:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: RE: [PATCH rc 7/8] iommu/vt-d: Wrap the dirty tracking loop to be a
 helper
Thread-Topic: [PATCH rc 7/8] iommu/vt-d: Wrap the dirty tracking loop to be a
 helper
Thread-Index: AQHaWmgUVEqRflyJEU+xdf00OVPGkrEAIUBw
Date: Thu, 8 Feb 2024 08:45:14 +0000
Message-ID: <BN9PR11MB5276714E6C1CB241CF17AF1E8C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-8-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8255:EE_
x-ms-office365-filtering-correlation-id: 99807b16-14f6-4224-607d-08dc28824492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QfBG/x3+rmtRePjZVm0BybAkNeKDNvFRBwiYN3S6+eTQ9ynmXrFAZalC6aPF/zGr+kUpxI7xVha3bU6jYrVHkbKqRhkBjSZN8rFy63rBibbuJgGhyxD1m4gdCQKwZhHjsG8ZVqvM78J72sggw0ECk/7qpLnvOXxXkHtxn0gp81vUBbR0NN0JlT/EgIPwZn6XMWcdVpDNfihcSCw6Zs7hSZMXrSV19U/p8RMXzIUJpw6MNDSrmBuw21UMhCFItu1vddhgtrJPXSK8Z0p7zyHOTGwstj201sGvk7LZFkQYLiC63JDPOeaCQqi9gmUoR7tz/gLb7Y539vj40XFQN7UMPqzKcJbmHn0KVBApe3eiHD8t0M6fHX0mEuEz4ZH17TF/4OWriQmcwTFdSgwK+1LPO+HEOYNjaRM6meH5lhNzCmrny0DKTVdDiEAdydlz1OwSbkNlE0k6kBZ0NsGpfjpR4Nd8C28TGXIAB+xdmWLwRseAPn55tdguVMqG3E5g0Rm1qvWgcbw+eM9temXFqyp7xM0IiHOQgUFK4KNh/YF+G9JCBXhzcvaNeawr12FsFatpXnkBY3FSJJffMm2NdX1U77BaOYOZJSNns00vHNISLyR/dHM+GpxgHZy98kGif2S/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(55016003)(52536014)(5660300002)(8936002)(8676002)(4326008)(7416002)(41300700001)(82960400001)(558084003)(86362001)(38070700009)(26005)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(110136005)(7696005)(6506007)(71200400001)(38100700002)(122000001)(316002)(54906003)(478600001)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uMli3RjSBR98jJyqb8gYiFYLEMmU0EFU9AUu6hRNqvBMq9dSHsiRnP7Sq1Ew?=
 =?us-ascii?Q?gHBNG96+0u82sOPLLy7/vhq/Ubq17SI4o2ql+HHw7392kx1IrBGy/Kd8eOd8?=
 =?us-ascii?Q?XKe/gwdV2n3jmJXmaQ+p1bSQ1hddoj/VOkdOUbpPSfQ5Uivic0FvYkgpHuM/?=
 =?us-ascii?Q?MhnriyGgByVNSnPS/aa1S7d14eQXuga18dxjzjzYZ7kPh3BeDX9ZNCXDgDDk?=
 =?us-ascii?Q?bmCLwOhQw7vq3fQ25RdqC9JU7uICkvH2ePNSRUysXP1+HvTmHsFyV6kmAXby?=
 =?us-ascii?Q?lmHlqNOjqBKWM/f58y7EWtwJjMk1hJqEOVW5xRzoBna1Xgduq2pRf5FWBU6c?=
 =?us-ascii?Q?ixz3V+TeeykogY4DJWaTTr5jW3Ye5ZXa6XmRs+QVwf/WaxIuw5hsl1JAw04o?=
 =?us-ascii?Q?iGYbfDxbe/guoMqrNT9tLD3hwGEpLhXkIlwDWSe5BTKe5Zl0RqxWQ4VOvaIF?=
 =?us-ascii?Q?/h28vSFiPv71STkPuX/uekdqJdAV0jkG7Kr31D2Q+563Xt+xUTNQnn3fMlDI?=
 =?us-ascii?Q?YPBt4p4kCF8l565mW2UjAKvKYHoWbK42ES2LPfo4kl/oWZFldmMiBNf8bBhl?=
 =?us-ascii?Q?FMPLpAi7Ha0PMTvkCsyB6Kf4CIvy3N6e8dYzuz6nh4X3yKLaR5GlLlq9h7CZ?=
 =?us-ascii?Q?x/lInRcqnlll91YfdEG3jclVqGX2xetOgaG+YuzZkr/Jm34mDFB97Yxn0bex?=
 =?us-ascii?Q?BM9sGEzLYRqMu2NSAdudptOzoZdzYjD54kYQoUSB4MJ9/KC60lLRcHXjn7mJ?=
 =?us-ascii?Q?YSCkA7WZCEIYtBOyIT1yIF6wPzBeZqr755UMSFiKzSlhY5HE3djaoDvUzuPE?=
 =?us-ascii?Q?DNVTOlzVncYsSEI7ZfGfalKDYqIynx9nzThcixzjwJkni4b3gI7SLc5oOhYS?=
 =?us-ascii?Q?URGVbKaS3O1tRSoICuzqo9ah1A15Xyh7eQcnnUQJMhd/pMYTfD8D0pZVvd3t?=
 =?us-ascii?Q?2+Yze8PHnvp8U47IbWb8+QunLK2TvQWXHnlwUvM6NIK9+3VijFjORfQgUeaH?=
 =?us-ascii?Q?sW5j631Jfwo9MKxD+erwD8T9ZyCclwihYqLSMV8E/hKwvQU2iiy58BpKfzgW?=
 =?us-ascii?Q?wvMVtDj7+90Hm1J5LSDKS48wcah1Bj+x1YVpq1Viq7b7dnvPcmd4ueDzwSxl?=
 =?us-ascii?Q?XbhZB7jz/8fw0/3Eg14CV3j3Y5CNJlQ8A/mte8tt8NBCKdyJqYNlsI8DljlS?=
 =?us-ascii?Q?DSpuK2iQVfiCk4N5lIUcOwpA7U+OctZtxPZ1hHX0DsA9tj/MJnSCpe7nP2Mz?=
 =?us-ascii?Q?rO8BGs++tGN8XydNe0gJSZvjyizyZD3vJjLXYUiRWUjoV+Xrsn+LToY3i3jF?=
 =?us-ascii?Q?P/vBrmG70gXMA4jYV8E1kfJpqYTO98VFRnI1IvMzC7a46ScsS3L32BN3J2iy?=
 =?us-ascii?Q?4BfDh3HsXGPT99PasKk+mjn0XcdvVQAfgU8XWHaNNc1M/JsWudvMTWah+27B?=
 =?us-ascii?Q?rDRaujbTnZeEDYp0AE0agzKI8EQj7JSS0z/qBA5AJMfVg0GkE0SbWsTHgkka?=
 =?us-ascii?Q?h9zMaOWVU+AS0F9eCBBQogy4k/142aqb6hDN1WkCTf4xmebYC3EvHbzl3SZd?=
 =?us-ascii?Q?pfe0neOvstv14ASszIycqP4lTtlECv7WYSTQvU2F?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99807b16-14f6-4224-607d-08dc28824492
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:45:14.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9AJuXJIx7YY0LFwfnDte3jaRiH3anmxLFW/+wr7u5/W8cvRGjuaZ01LvCTx9DN/fP3E19PWO1yAmx14B13uSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
> Add device_set_dirty_tracking() to loop all the devices and set the dirty
> tracking per the @enable parameter.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

