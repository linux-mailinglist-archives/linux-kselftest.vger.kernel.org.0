Return-Path: <linux-kselftest+bounces-2486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641B781F4D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 07:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75BA28238E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7D23A2;
	Thu, 28 Dec 2023 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9mC0pfy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C51FDC;
	Thu, 28 Dec 2023 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703743638; x=1735279638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dtD73OuDqOowhURFkyB43XBOA9KxWyBs1IcjWBIuxVI=;
  b=h9mC0pfy8iwuOdeVSlIZ3jd8Yud49gDH+1yg3Zoa+7cwbhhXIS3g8fdL
   bQsJ4MHhAPziS5bZMC8EB+2l6VA9J7K6pSFYqLfkzEXdo937dnJywdc3m
   D58pIS5PWCH/03rwua1Rft4d9x8BwkFpVGXZWskWdgsDONk/6i9w8q5dg
   mI+7OfWFk97A+WiEbxAnNAOfyrg8mgMONlSlvjRtPasReOqBMHtwXButw
   p/TDh70gYvd4F0Dt6R6Zp+Phr5aFYAEWZTZ0uvPn1Dz5UXvrlrXO5lgFt
   IK/MkowGTR4TRChtOfa//GxKkSIBXMrUbwN2ANjCYo9RSwR6ItHABW5hi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3317100"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="3317100"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 22:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1109819407"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="1109819407"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 22:07:09 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:07:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 22:07:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 22:07:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7daNiE4vdmIs67XVsnCNfT/phBAcs6eTLPCDEurD9rP7TKnz/J00sR7+TWEACPmkTOv5Y1F/xULHxKO3Y9MYsndeV1qFJXR5OSdrk61SyCgUihNlLpvUTQguDXC023pHh5Bi09VduMviqQ8SHZgf7KVkMMirA0raFSwskqJaT5Dx1ck/pupkULkRFl8zvI39vAWuqIVDoCzazH2Ew69mm4OFwFRV+e6bcXRgU4n7s2CIQVSTSgPEHq9kJ867SNcjK51pdBUpspwIYznPAc9L9Cj6V1Ezvh8tYfw33c2BawKopECxWuokjcvmFXxuwNOSndtf5VUfvrXDhdV3WpWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtD73OuDqOowhURFkyB43XBOA9KxWyBs1IcjWBIuxVI=;
 b=SddEGMpQo95N2LN5nJ0dfmEjI7z03//wIAFU09T3UBxpQVqkIQiclHeCRZgiy3WCIj4m1EbHxCx+Ap2UER4J5bQM6UA8GCbQW5GotwiWDqh8ZtKrKbGKxXGheN6ONTsBudoVQJ3z+aqHNM0omDQvFQWItg6U7NZoCoZHkcQ9k80/Dypbtou043VicB9cfdUS5VSDK+PJh0b0YDXNi9kSj/NhIjmAWnT3VY4u2Jd7ZjtBEa6hM+FzC+iXPBm6kWVGcr/t927C7Uh02i8a/MgnJUhBe++z+ORKZK0Da1H1V5Ap+KVaSPqjydMI02xFiX63Mvkb7CyweET01HrfDikiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 06:07:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 06:07:06 +0000
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
Subject: RE: [PATCH v8 02/10] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v8 02/10] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaON+9WMP1ZcWuK0uW2zr9wlxAALC+NlEQ
Date: Thu, 28 Dec 2023 06:07:06 +0000
Message-ID: <BN9PR11MB5276232FBC1138DAC70BA81D8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-3-yi.l.liu@intel.com>
In-Reply-To: <20231227161354.67701-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4514:EE_
x-ms-office365-filtering-correlation-id: b364fe1c-85dd-4b08-c5ae-08dc076b37fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJDGMGPzsVWO7YlsyQvfSLiN5ilNkgkJFx9pNoTObJOEpdyJcOmAx66bqRhmYWH2lZEW2a3KVrhgDR5DKmkX88C+bjycVJ8CVdray3XjBWi1agCijXviFPT+FwbzmQVHpHqqE2W7iRkTzNNRlT7vZ7XFW0Q9zP8UAOOKOnhMZIDljtqpDQe8QU8z3sXbax88GpSdXAoafT6vC2JbovweqRbpf1HTAYFaTMxBAuH4ZDBYDDcYgHGFae+2OvllBKNMzKaz6mTHjR1gpwXKCxUACpIGnVVTBrCaK/movnvmr7EVdidaNkQyJvxpdjtgybxy2J3/H8wLsTe0issRLvRV5ICm5ybXDjzAeSni2+uYdmwIpBxFFrpsF8eMRcbXjcihshNZNjw+90BZjX8aok6Qi96hLGYdYuppNl6UVpgC8lRiytqXbF61clpDUYPgli+rfju9IsuAcL7fZLKRP7hedNalOpMTe11Pfk9s75GacLgFrE85DSphS34a3Bja52QiQOTADtT51xwFMYWuDN1ZNlbjkcKjSBMObaDHmK35PIsn0i1LT+fflfNQUYvS0exc6vjDj27qu/gJE8PDdKR5ibcv4kO0iu2sKsKVVIkjYEaYH1TFWpxTKPmCq3qa6NHP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(66446008)(66476007)(76116006)(5660300002)(66556008)(64756008)(52536014)(7416002)(55016003)(4744005)(4326008)(66946007)(8676002)(110136005)(8936002)(316002)(54906003)(41300700001)(9686003)(478600001)(71200400001)(86362001)(33656002)(7696005)(6506007)(83380400001)(38100700002)(38070700009)(82960400001)(26005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sj1Le5ApMFQ5gwXK/OGR1qtH0PyRNr6yZY4XG5ItABwf8uHo9Xd2S09HsWFp?=
 =?us-ascii?Q?VL5GxJfikj0UQmbKkcLtamxGk2A8nzWkX8py+MhfJiDAVFmtDGOeWFvPnrGp?=
 =?us-ascii?Q?DmHD2B30/i7ewuDpdz+TuJKyNmR1G3WKT4Epg0EbtjS1KWWts/6ea8OiiEtv?=
 =?us-ascii?Q?0x+pwaPn0KGF/v0Tzsx1Ai6rh/MUBwVfwB+yK8VQ+wlifxOvF1yiiprzCLIM?=
 =?us-ascii?Q?e67zz5Wifk7bXBUIaUrCHujgLHMySibsUxsTnGJZD5LiDl7i1hLwn1atNBeb?=
 =?us-ascii?Q?3MwHlyQF4r/zLlZaLKSxLBk0da2bT/AGOG9NIJIeON+A63DD4hoIPZRtc+94?=
 =?us-ascii?Q?akf/+6XLSHPOyHqo/8Xe4kwuhu+syehXSOtKR+FmF2hYZ2gI0WuMxG4NDzoJ?=
 =?us-ascii?Q?XEQnw0cChryBFiGq9HoEpIlZEZRjJMEgiYUQot8nzRVXqkQ99u2uM6iSpZzC?=
 =?us-ascii?Q?rtGNxRbKCpbxeecAnGie6N3Y5uvPyzMY268sqL1HEKPD8Z8D09PD26dzUksJ?=
 =?us-ascii?Q?Shz9Q/Mm0YY/ZK7p2lkaN2x1Qfq4CeCY6zPM+zva7ccoGattq2fBttNxEJtX?=
 =?us-ascii?Q?GyFKrDdjGsv3RsKhV8YYWjumBJh6J4Nsm3ztBVifq5tpsvS/yxxS+Z0DVaSw?=
 =?us-ascii?Q?rLrsqsYNQ9TKHcGMD9vuh91u2b149KAevyk8tfmn84lAegi9UvfCH6I3MD13?=
 =?us-ascii?Q?d1m2EusyLDNlNBDfC+yjLpYj/Af3PAfe09I6tvQBpnmZa/q3cLRlhhqbMRZi?=
 =?us-ascii?Q?l4yRg70bWtcYcMeVAboxAHpg+GYNWZE2rf7PyAxywrHc2V35Tth5gw+Zktbf?=
 =?us-ascii?Q?2/S8e/rO0IX/4qa1p9gjdAf1jg+W89JksXmltijGB4I3hfiBWYrLfD6LM7Ji?=
 =?us-ascii?Q?cMBsCxIldc0KBv6Sec2T7OE1DP8CnnHhHdF8L8DjSRz6DSm2kh9dYiKUXrKU?=
 =?us-ascii?Q?F+ZrF2JWi2wZhG67NJo19kWXa34ifvpa4JwynmPLgqBm26/kgyp0p3Ale8yq?=
 =?us-ascii?Q?uC4wPVWN3CVqR1ImReFQ01kcU6snLwGSUbgqgf+4NLQppX2viME8JVWK+h/C?=
 =?us-ascii?Q?DPy4llZlhkIJQQo4AzGl/UJGMGnPsGNMUQa4SOP3IsgrUAgT5G6XHQZP6Lvn?=
 =?us-ascii?Q?V5dgg7pXZJkkKxqVi+ShlSYodXR15M5e9oGN7J+CBUaU4R+WkJJ4SpVnh13V?=
 =?us-ascii?Q?tbwZ72QHHPMkxIFXLVf/fJcsAVjt9qw0a3TCNvkYb8SpYYqHpD5K0Bt8wF0A?=
 =?us-ascii?Q?aG+jElEc1j6QSAPK4PQj1NzmW64BNpl4+xYIOFEnpAKFRmcAnA/PzLDN3h9m?=
 =?us-ascii?Q?QjiPJ8s/8x+Srq3GW2J5VH9UF5YaiwWgIxzEOln5jbM+ZIQZAmZfWoLY6qOW?=
 =?us-ascii?Q?GZGTqkh2l3jbNHFIhTaBnRIGNwt2LHddhe+znyE9mtF41ERGi9Tj0OCSkJwc?=
 =?us-ascii?Q?V89jbveiuWmsxPMVLkGRx78YT9tZTDCDjlrPmtTt0ChVHEhqVckEF3KuAGEU?=
 =?us-ascii?Q?5IyInKTSyx6WFnbS+0AmK7b8TndNmO0vH+ITMdQiDBoZDCPae4DTF3Q7t/Yv?=
 =?us-ascii?Q?qQoDNWd/4Tfe3ejsUNAnRKNAI0B1kvQg9dz7AISc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b364fe1c-85dd-4b08-c5ae-08dc076b37fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:07:06.1977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE4xeGtqXRN5QNXV1I9nZ4M3Dnd+OzkPboKqdOf8M/czYm8nAUITPtcnkZesTOQ2EZ7/cZzTq6P1gNMB88Japg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 12:14 AM
>=20
> In nested translation, the stage-1 page table is user-managed but cached
> by the IOMMU hardware, so an update on present page table entries in the
> stage-1 page table should be followed with a cache invalidation.
>=20
> Add an IOMMU_HWPT_INVALIDATE ioctl to support such a cache
> invalidation.
> It takes hwpt_id to specify the iommu_domain, and a multi-entry array to
> support multiple invalidation data in one ioctl.
>=20
> enum iommu_hwpt_invalidate_data_type is defined to tag the data type of
> the entries in the multi-entry array.
>=20
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

