Return-Path: <linux-kselftest+bounces-2488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 688C081F4EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 07:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D4C1F22494
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924223A2;
	Thu, 28 Dec 2023 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksxBm6Fr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7985380;
	Thu, 28 Dec 2023 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703744249; x=1735280249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9eMWqUZacALKBNkg9n3OclmFS9yWe5uDTxsfbYspo/E=;
  b=ksxBm6FrfPef35WN+bcO8Ngk1bvnvac2AecZO/daSvZgbKxJAUDLGsFH
   FTd8BVIJEQy1lKwjfvmXOkgav1fE6b5IKi3KsA8ocEH1EFU0fjXyTlpOr
   Pfw3t7kXQv2UYG6jRnyKYd+5POXeUABbjrh3FDSUDJvkZ+LvYPVMzpmcA
   qkZ9Ahj6pQnp8Mv6iWBU0+OXtg2ergn5s5/T4kx+fn9KkQGMewdIGCx0t
   TZ9dJntvdKf08R6dmapuw8KEWuMDrSz6hOg97sEgqMVn/lM6eUm0kqYYx
   vr5z3jHXpN7vN/zjHF/Fb3FKRtkd0leEr+ZKfhXMubjPP4mZNsYLRr7Ej
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="376003395"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="376003395"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 22:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="951711889"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="951711889"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 22:17:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:17:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 22:17:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 22:17:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jejsaa5YDftECkb8FNA1RxGfskvWsjXGuoWWtuPJptG8LMKrmvZY/TvUVJ7tFAcn6UvMgVFYvdlz9OdZEGjvm9o44mpmKk0mk7oRbAmGGodUwJ8E2/GXOiEG3iCpvIwNl0P3fkl4nDG8V59yfZ6yY9G+tSMNzrdzb5NYfqcjkCcscSFI1325zIQzHKJOULPxFjmS0NrkzMuxYOvvovAUIo45vNJTwcUvPFO4xfaBvS9yaQE7Oy9eaCAwgIOvH2JUkT6kfyCHJ+KLalO1EMFBnAvwj6yQxAUlo4VAqMaJAZoEDNmgl0fhWC+MXzko8asf735obmAG8E1HFeZpI5pHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvaIuiPicdDDX1oTxbtJsO9LlED7ysia8t5A/8ACsT8=;
 b=GI0uioAycxIky37kXMvUGLdB+bVDS2chbahVfmhXYcHuD1GXWiuoolsY6+MA9LrQPrs/p9sh9+jPpVpkz6Sew6Ld9zGO77rGws8zAoVPA76adXbAlw6/MrByFSFSb9tYw+Ttt7ftI04hm40S8x2xuf4qaWUS0ZumRkpJ+lNe6GwsrLxKwxpEvLmmUIgo8c10OfBa+wyDVSMjozDimP+NQJmqJq/JScz6i8clqXgRYg4n/nl6tGIMYX6q7WWz5kOw6xHZ4I6dQAERBHQ5fcOo6hKof+L5hDyn2qrruLpaC4qLKTw+KL/GHem4dtz08V34hbRj+F4vt02Mch3e0d8uXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 06:17:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 06:17:19 +0000
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
Subject: RE: [PATCH v8 07/10] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Topic: [PATCH v8 07/10] iommu/vt-d: Allow qi_submit_sync() to return
 the QI faults
Thread-Index: AQHaON/A5bfZH72AA02vmOQ862qYJLC+OJ2Q
Date: Thu, 28 Dec 2023 06:17:19 +0000
Message-ID: <BN9PR11MB5276429906ED56258BB433068C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-8-yi.l.liu@intel.com>
In-Reply-To: <20231227161354.67701-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4822:EE_
x-ms-office365-filtering-correlation-id: 26cd99ec-c628-4d57-0301-08dc076ca575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PnHsWoYbZARPirV7JL92WQhzCFbZab3ePRq4mjNpr5JppdhGp53TdFgERTv57by7Fz6C48aHtXnpvovc5x27javvhcdKTMabFzXT3eHwKm195wj3lTD84vBTOPgwalzydR5/gqilaNxfgV6JfymfC/K/uy0SeikjD4kYdFqrR71HaywgZhwJnyLoIixsC/55ydIqaO/o1XA9PFfizHe3czLc7aQVAYcoXN7qXQbzXicFkyCwvdZo3sZ4gzudbY5pUSUnpWHG1oCk0yWGT/+l2nmYzgksVzvBN8zgguu3RseRjOlGNagD1EMswk8aXR+NCq6+7krs/xAcu3tGgC+pBo2jFPOGmXuEpLewNcb30DgpOJX97/CplRA9v+e7xPtr0Ptlp3m70jnQiuDdJD26UBvT7wFnWIIYdnPiYAMql/JacSXKI2oto4vroYFH02JeF9+07q9BFVnnxytsoUAQLiP4TMKEFJWYxMykTOaXbbRlGutVgx8M7ivg64w3PzElJKw6H+BKVvjURF1Ogu/hS+ACJTc4ZPvqJrh9tB6gbyFOIb9S82bWoCnbgZpSDGTjb3Hs+ylcVHrBqwpgpeGMz1grVhxNntDCsY7ycpBBz5J69ZGnb24f/I2Ps4jw37yJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(7696005)(83380400001)(6506007)(478600001)(71200400001)(110136005)(38100700002)(82960400001)(55016003)(122000001)(52536014)(76116006)(66946007)(66476007)(316002)(54906003)(66446008)(66556008)(64756008)(86362001)(8936002)(8676002)(26005)(4326008)(7416002)(4744005)(2906002)(5660300002)(33656002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IwSvjoM3R8b1gyTDL0Yeb7doUw5UOxyX+EiRqM0wZMuQg5J0RGOvFI5AyYkk?=
 =?us-ascii?Q?4MGH92pHjD7WfBvfed8RIjQm77Px5yLOTsHtg2FSI8SJFDTtBocrJhlYTKNo?=
 =?us-ascii?Q?9jRfq5hjEUUqfPKUKoUJEBIhRB+3WqeJkZRLSSZot4GoBoLoMqu8TkHFJ2aj?=
 =?us-ascii?Q?56JqaJm6JakIB/jsVa1P9tSTUYWilK89DlVXdvcjsVX0GbvgwclZQlg3So9K?=
 =?us-ascii?Q?XqxM5EyXIWFHadc/xoN7UrTX+Eyc75FNaQQB2oSbZogEiouvizSnJpVUxUun?=
 =?us-ascii?Q?uQbhKRoJsmFnaDRcybnMpph8i/zyLKP870oqX49NZPNeCR/w1BDalTr2Nceh?=
 =?us-ascii?Q?+a7KSqVj5MBPB5NDNk3q5fB4QAIM+C8L26eVGRoSI62yw9FngY2YnWXmqb9l?=
 =?us-ascii?Q?h4kWlCKFF1FUpr9tW1ub/PRGJOQJ54P+lqBrcgJgTIdmcYWXibbmwHeUDZwE?=
 =?us-ascii?Q?4kcbNCkl6GBSxZT/GOlf6qnpbkaB1DoBPzOYzZKuQBkCNW00cm8loc7z2gRQ?=
 =?us-ascii?Q?RhfqaowPi8/kwTA6CWPR8UwyuBcmgIFvnbQfnStDleMTG3KFS8F/p5r0qu3i?=
 =?us-ascii?Q?Mb3R2vzc3UwO11P0r0FmRdSBf2w2CW7cklH+Xp1ShlgMQ4irJ+CAUQAiYkbX?=
 =?us-ascii?Q?4PsmtrT7CzTaV+lx4mW8ZEuDBLI9FajzOOhFZbqO3vSMDlWTazkducdDiARk?=
 =?us-ascii?Q?6taZAjZ9Z/fXcD6a5TtmNCNGAprw3w1lxxqq+FVFWltOZEF2R7GV2JI/cvZe?=
 =?us-ascii?Q?50kuirrGTbO19LK+1zwVmYdl+L7elgV7hsLmKu8nnpbzJ3oSWo20FZsCc+Bx?=
 =?us-ascii?Q?bFBol/4ejKQmqIaVnklZNkEGabHpQADJucay/Be8eM1q4sC+FfkrAvmtMmyc?=
 =?us-ascii?Q?+q+WHQzj5rR06oBWRYvIodlgUXxQL4c+4NcFosIKzkw79CPDNahLVCzxZmU4?=
 =?us-ascii?Q?s1t4XRB+ZWqW6iKoVpZXsi5gYO5596yt9EVvUeRCFusdWFeZ4znP7ELeHv4r?=
 =?us-ascii?Q?JkBAesyDGlQ1HEClW1sUZOr6QKc6Y1TCTripFUlDfAKWizzAbFRvxsZR1uZR?=
 =?us-ascii?Q?oSGk0eiSOTdKe/aZnbtr5WfUlotEnZoHF3M9OXDEFs7BhnBrn/jwrNdeUdfK?=
 =?us-ascii?Q?1mw/COcVhBTnuno+3+KrAzwOzjkc+dtqKdSYTBqkK3mF+7TfTCOJN4a24vhw?=
 =?us-ascii?Q?PF/oaLArhtt2LX1gJWUdyeMCjmdKBsDyLDgtk0jdH7AOpR3Ysm2RAKgSG40X?=
 =?us-ascii?Q?j28N2yFewnIJiVa7UlXJMjMsnj0lswXh98h4oSCNyDBWsU3T51aFd+AlJhW2?=
 =?us-ascii?Q?7Amyxd+lGPGlhe/faK0lHIHmls8iZz09IWBCOSd5U0pIvR076qqNjcfHtvGV?=
 =?us-ascii?Q?LQqAF15maQIKpRFxnxsstrzepYuWEApBV8KBCtmcI8BxoNyGzzgJ7kkJyq43?=
 =?us-ascii?Q?3QcW6xNPxd2LwC8ANP30q8+gSKRwdKmOvOihp3by24z1PeMNwBr4o5BtntEh?=
 =?us-ascii?Q?IrVl0TDgAy0TzfcuvpAl9XMJcVRCgCPwejefpG+bAjne28AcFkjSSzNwnriY?=
 =?us-ascii?Q?LeFniNge5RDF2nRw6TUE/I9iAcNoKguq/uMKyuMp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cd99ec-c628-4d57-0301-08dc076ca575
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:17:19.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLi0KA4hZtPjA4GioFSQIPWhEtk1fAKDLAExT8/WYb/ghg+MZCQaqJvUaCigW3/pidrYpddlwK2VkS8pEXdJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 12:14 AM
>=20
> @@ -1376,6 +1383,8 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>=20
>  restart:
>  	rc =3D 0;
> +	if (fault)
> +		*fault =3D 0;

move it to right before the loop of qi_check_fault()

>=20
>  	raw_spin_lock_irqsave(&qi->q_lock, flags);
>  	/*
> @@ -1430,7 +1439,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  		 * a deadlock where the interrupt context can wait
> indefinitely
>  		 * for free slots in the queue.
>  		 */
> -		rc =3D qi_check_fault(iommu, index, wait_index);
> +		rc =3D qi_check_fault(iommu, index, wait_index, fault);
>  		if (rc)
>  			break;

and as replied in another thread let's change qi_check_fault to return
-ETIMEDOUT to break the restart loop when fault pointer is valid.

