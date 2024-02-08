Return-Path: <linux-kselftest+bounces-4331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16A84DBAD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D461C23EBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F136BFC8;
	Thu,  8 Feb 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWUGteEA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96156BB50;
	Thu,  8 Feb 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381819; cv=fail; b=sUmLhiJORPQreWoJxmLdvaUrLBsMJbznpBS8CYBUuv1GgsZCGPhyEzBfFLbcXMv1/sS4q40+EOag8aN5Cj0067ja8LJXMR2HyKgjQbL00fEk6WzgJd84zja7brF1NXIULWlkvPGIOVd9I3UqKzQnYdtiqZrq9T/S5gCFeYCb0F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381819; c=relaxed/simple;
	bh=Fki4Eu1dgMq4qmzJQh7UVzrCpFSB3LIQFgkWuRaMEEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qpg+R5MQXMsA77HR8xz/yWuODgMaJo4TGwfalgUfg1LDiCXccPkZg5etbASfG6y+RZ1xFwHRzY1LCrOZsD29JOBhGFqVkW/UiE5v2msBjo9B2RNaTgTdwso2+44/18ys/dKZJnvcPbNj7ZzY6LTfT47BXB0DAxCOmZt0e9lmh/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWUGteEA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381818; x=1738917818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fki4Eu1dgMq4qmzJQh7UVzrCpFSB3LIQFgkWuRaMEEA=;
  b=nWUGteEABMZDJGV6QpTKeIf+ZdRyOwqaOLyPeD/5JOk/B2/QfJp8cJQ6
   bF7nxlOE/QMirbqHcFou8OK3BAuHdDwHb3L3dRFmu3/pSh8VdMPrHQT3A
   48a4aZgtU+15NqEOIrDHbOdbgcpIuE/XPAftgne7l5L0vWd7aKnmdK/9F
   jqI8iYLth+nqkKL00lRcEbGz9z78RWSFT3EXHOUfPWzr945fGUxeYNRqC
   b0ZSLAaROJaGjeZDBL0YsA4Y+YocsOO9zbqJrU4wvaMoHy3chJAZP95vo
   NcaffXFivuKGzL9n1QAiacLmzvKc9/ruMGsWhT9CUrByCCVe7savO7QUj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="26616521"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="26616521"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1883620"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:43:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:43:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:43:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:43:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:43:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD3SFTftZczJ0TE9NtEhG60KhvPkjn3QOzWTo740iHyfS1fTepUgkUxKfs8y5pI1tk0id4LI4BPmgxlO68oUaTCCdpKlXUCCMA8wGghl2xEyCcj164hOCOLobtfPI26MPvfK23SwhFnRkiUoElrkoomiSRPrRcLlsrMD3jIlgCdr0kgoBVze5e3ZiW+XTBDYWLZ8zJsCMGZEXOEiTlVddmCs2LD8+KQu+7Y3Ui2N8CCCyiuv8y/sRmNptAany3y9c3ouMlD3cRrFrPLTtqI4mF3XqsUd8SKuZk8O0AMGL4zaD6pINNGe/qoex3U2coLOOT80Vb5n5EtF27Xva/+m8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fki4Eu1dgMq4qmzJQh7UVzrCpFSB3LIQFgkWuRaMEEA=;
 b=he3v2iFz7B9rNsWB8T714SXkXY1Jj+0wlO+/f/JirrlJu40tfGEf7lRDck522Iel+LiMO1EXYA1Oj0mJwnK0+ALCd8EG7SK9msF2MzeERMN9gSZv/r+irYDiFILTf8Wsi8U+tBAxDAhvPIArJKRLuHUjdqDdaOVb1awfgj0QL5Q8vikzK5qQX1butloHC/ogYIgqrpLTjTSHRlKDtyqoX8AX6hJqKso/+aQ3vdGq5s9NVPK3RXQ125Op/hvNmASIKMulG4helAs6YoBpjn0jdp677w9CCSyef2TZV6/Nq5+R+h+HiXLiAvOtfl+W5qAa5g3q2Z1coWy2F0B+8iDhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 08:43:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:43:31 +0000
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
Subject: RE: [PATCH rc 6/8] iommu/vt-d: Remove @domain parameter from
 intel_pasid_setup_dirty_tracking()
Thread-Topic: [PATCH rc 6/8] iommu/vt-d: Remove @domain parameter from
 intel_pasid_setup_dirty_tracking()
Thread-Index: AQHaWmgTih3QdFqUskSgd4vslzF4P7EAIOEQ
Date: Thu, 8 Feb 2024 08:43:31 +0000
Message-ID: <BN9PR11MB5276EE225003B57E7063B9D48C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-7-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8255:EE_
x-ms-office365-filtering-correlation-id: bf8bc444-d780-4b97-fb3c-08dc2882073b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlhg/IqLnAqrFDhlIiZiJVGCxRzVsSMfn194p8c2rej1bMJLZUKc8aRBT49ZHiztQqSuk1f48QNLHlyZrKBXSUWIPqR2cYrtFi9W6W9MpQqFbfKIvSFUaVWfFT/6NxPSwT3DHlaevcpn8z1mDUPxBgUOyQj+5LCINzC1gabEd5/IxMRjPEhQiy8CMTuQdBaOrGyyILqyfLid10hzXZAswIr9+z6r9b9kfJHa1+oUSn8GQ8HaKqeTiEZKBqV8qbdNWICUmFw/+E//UaDIeYiHIM39xaDrv4wL85m5mPQFm+TauaFFJrEeGCAl1S2EBtIUUoA9paxzjZP5r55MS+34C1xbgSy/8Sc1Jn+9DiqIbE7XgbTnjcGVfKr2G0yJQbwk/stVLna4mGN8+7nkFbP7FRYL7bsOdfPNlUpMMiZnoDN4trI71iO0WOcI6Ug8wIi9VkPqi1HC30kN6dEaao6116XSGIAwBx+WGtdeS8/W7tjEdIfGyhoIfNiq5EAcLZaYvENRHeUo56Tp8r6Vjy1y7zPiFsMDtbarvptgRQYVtf3fNnVVf0NxXw584LRT6polzBhUnDtRf08RLXGKwgkGxsHy76aTAe1SFLfMS8AKsUdKFk5wVwIWSkNCCGbWIN2s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(55016003)(4744005)(52536014)(5660300002)(8936002)(8676002)(4326008)(7416002)(41300700001)(82960400001)(86362001)(38070700009)(26005)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(110136005)(7696005)(6506007)(71200400001)(38100700002)(122000001)(316002)(54906003)(478600001)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KjiM2g1u7pVLuPcpsWl/pA1MDnC/C9Io4yYC4CYzKt3JwMzpjnEl2aojjhJ2?=
 =?us-ascii?Q?MvXsrVWqgD1n7RckV70yFZKbvA8SnZ5AC7wQmTprJwmG7Mrijt+8s5+Dxa4P?=
 =?us-ascii?Q?fJE6ZELASXiaRu7lsPTZE0AMXl1uDLGeB+UE01Gr/cd/TnfLf53WukT+Vg4c?=
 =?us-ascii?Q?5tVUlRUwz4+BeMfyE8lVwNCnLH6o2XwifGfWxS+fBgVL/yZlemLLvMgNRSe3?=
 =?us-ascii?Q?YaAxi+hPz8+s0IkIaiTdJdtC2g3WZ/Zhl+hEVS/2fB998YZkMlXHaI6Kv1ul?=
 =?us-ascii?Q?Oqn0I0OpbDnjIMFZkO8gngdMep/Sg7Ol0IuYYDWVhlk3+ClQ/4JSpqg3zQqq?=
 =?us-ascii?Q?mJSSIyjs6WN5Gzwa7rq4yp8IcQmBynBBX+BVEQoiY/0UAk3S3wHA1vOPYSFx?=
 =?us-ascii?Q?4wqxLot5e17v2YHnp/TdCaqNE1sV6ihDWU3MYYo/UKmPIlUFaWhjJBpMS4d9?=
 =?us-ascii?Q?OXqcM7hM8dhp0mny+Qh569hez4FnmRLHOVSVXCM9pFwu7ldOc39esTyiply3?=
 =?us-ascii?Q?auHpL+faZ06nL1g3IpLtg+PZR6EkR27Zvmu01SRrNvWp1MzAQl/Gpka+fi3z?=
 =?us-ascii?Q?Nt7tYDl6g+DUZSkqZp8CHctRS66a7Idg61lZ/FZcUkZOVgbI1wmDrKacvZpF?=
 =?us-ascii?Q?FLdbu0+r7Q3ucgLnMpfJIRAE/REmSchJTJsdZ+mQKuDd/2sPL2B7a3+D9xyV?=
 =?us-ascii?Q?QLlkXLmxRM/raVxKh/1TR9VSY0SfzZt7EcsxzlEHDCtdbX+2t0TReee1oA0q?=
 =?us-ascii?Q?bXNWPns4pwYdnM1rNd4mx/81kqbWvta1OHVBD8eiF2qb7Tvk5VUUyhAbSX+A?=
 =?us-ascii?Q?r0oSIx3N4xDl0AmV/RnSDbZ+9eXGqGulK/+B5tqzxI+MLE/j/e+JpRp6ExgD?=
 =?us-ascii?Q?GN4QnXFdjO6QYt81faMkaw7L5WHVejprr2Fhq/xeoOtzrluFf7ynZQ+Ii5Eu?=
 =?us-ascii?Q?o0oC5nZBpPne1PokM9CnfclhLq7h6i1IMWl0zsrfmsFvliZtsNECL5IdytTw?=
 =?us-ascii?Q?RZo267Tm+N1gvSvUmMqVIsZ5cmgg7NQ/349nXK7nTLSn6Dv1KzDQFcfW0j87?=
 =?us-ascii?Q?7uThyDTRzeXQ0RDstn5FdSO6Yf84+XQE2BDyULox67Sho05PxyE1/3uQMQQk?=
 =?us-ascii?Q?UoWqa9Nw8rEv1yDIrEXy8+QAXBg4WPS2srKkCEyLrKUS4oByMev8eS3Ve8+m?=
 =?us-ascii?Q?CcgsHUOGCTyJrEibal44RKXEzH7xVqVILP6GWrOl9ZVhsn0USqNbA0myCEKd?=
 =?us-ascii?Q?qdrF9Vm1uqSVUmz5qJXK695N6g7ad6KEi1njboau87RxoyMT5yvLMpOABL4k?=
 =?us-ascii?Q?MZqBjO3QcsJmg2AH7mtXWVOUcJrODi1in0KQj8MRJQsOHEcINPLNpuAkEOwl?=
 =?us-ascii?Q?NYe3GEJe4k2fXd4OOhGB1zPBC76CYkCI+DMdt4dGgLOQBfbKmQeNKPGDMiEg?=
 =?us-ascii?Q?LYiGi547/3LnWWLFGfnXo7123FwBBY6eLHYVkN1ss+EjF49t09xqNHT5oyoq?=
 =?us-ascii?Q?UrEU8tTkvV7tOYu86C7+vFaoQmWAWdwzmiFOX2GvxlAVoEWfG1rs153e/eTe?=
 =?us-ascii?Q?8AlPnOG9Si/4wWKwCECuuZxV868BXYCbtz7ZZiIo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8bc444-d780-4b97-fb3c-08dc2882073b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:43:31.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ep2UtbBr0hAG9pck28ZdQvzU0varHhaSHYhKlE/VdjKue7JEv4MzSHtie8R2NQj5sqeJHy1rq15DGNdbgh6Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
> The only usage of input @domain is to get the domain id (DID) to flush
> cache after setting dirty tracking. However, DID can be obtained from
> the pasid entry. So no need to pass in domain. This can make this helper
> cleaner when adding the missing dirty tracking for the parent domain,
> which needs to use the DID of nested domain.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

