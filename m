Return-Path: <linux-kselftest+bounces-2348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690B81C3CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 05:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB401C23510
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31487210B;
	Fri, 22 Dec 2023 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHRvqfXa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728875395;
	Fri, 22 Dec 2023 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703219009; x=1734755009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HTT6ZAyGs/L23FfgH/2v7GhHoxgaeP67HFBchXwUQaI=;
  b=cHRvqfXa2lW+Pc/EqVMwsC03gYZuoy2ofJhrQWyZen0518I7rOXhLPYl
   dTDpo6vfr3saFQYVROB5Yh7uUZUgCfcYIjShprlEwD+3e1sqVSv3RH/s3
   C2evNm++WkZm2q2VjRPoMk+z5ebf7dTHbSBrT9gEKn3PcII8u2C9wKbIq
   KzlG7KTd0DG4iVrSTM+sVHeN/jzK481b99d6TbmaA947pRFahDxx3Li6L
   CPr+qHKkLJIDxWDdQOwpORWpd0juBITSIZZ7uONUzH0KBNJWN1NxMc73R
   QOwxI8x9NQuB0JHoEvN8li/B2RaD/P6ixxT3FRDwvSFpFte+jwdfwYq/l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393238511"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="393238511"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 20:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="18922721"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 20:23:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 20:23:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 20:23:27 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 20:23:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMvo71Pme3qOCgSKX2SsIAu99IvNR7ewC/XFpt2tNW68nsb7iuGEzD1LXo5W2vUgXMhGm0iyBUMwUpMCpP0fiKS8vVdkCJJl80Pt8wG0j8FINgXIueKFe/DXr74SFvdxYYUOhBs1GgIEKNVJ1/DYAbi+shR8gVkXIxH1UFOJGMIR339RtpZmKWKE4Ii8WCkW5bdgX+G4InvXgzOhygeesDD0EQHkEYLJ6OMMeQ9/k6swp+2Tb/rSfnmInPiiIRSR7W1Ek5VMbeDyeU08phXZnEK5/nFMj+v4SzKNl7Ij3Ad4K3OZC0qBJD8MlaON8Rlg7rF+CXHgu1Qe85Utl1OBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMYjSvj7qER7hzswkxKEUm+0O97KkWJz6MtTuHAEPgo=;
 b=R9STFumXopbUUDszDhkpintPDDwz5i4UgFRUZeoUGgz/ADC3ZdzFcmqHGaFmledOM51p64BatehazRrZQJBLQwlPOA8rBVscPx/Xa7u2B5e9Ln/xqHh/WRPfdpbRGkdos9MxLKkXXwaTP0a59wvAMDsug3ukGeDGblzvIvZu5gHaZJgcrJL5B4+QMElUFWZiTKqBFI7d6FLu6jVgA0rCTDbkfQz1e0e6YAX3u0yLL9CpYE7kjXO+OGDDaTTaO+0wdlb1haBdqoJbyfZFqEzds9P6Yuw2wea/3vqNq/FK0VzHlV+BvFlsI5UTOR6vsBsxhKTc1pyeichbF6IkuOKFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 04:23:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 04:23:23 +0000
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
Subject: RE: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Topic: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Index: AQHaNCP7GmW4equSLUGDinfwDm7MnLC0tG4A
Date: Fri, 22 Dec 2023 04:23:23 +0000
Message-ID: <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4859:EE_
x-ms-office365-filtering-correlation-id: 7648c05c-90e5-4c4e-e44d-08dc02a5bc92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tcfxbQjghv+KodxII56McFoMwZbW93yRSMxTxyqnCNI3RC0zFS3Xwo5e6/mE8Ivmv50MAg27lLIk9JJL66n23lwy88yC99GkUf7yD+V1e+Xzzgp9JEnBByDT4co+G0WH01HA1fYfe3nH+pMiBDVPhA/xSqGIdLIJ8lfRSZ0xiU9pVQ+J/fhraLeByo6j9V1ODBmJ3BQcvOvkKsEt3l2OMQsSokb2sTjUVZXqgtOjr4Vz34+tx5RzIKBrOcgaKnWvRxTzIIej7p+gPptTAtsyWgZWQwJIhUewApeMzgJbrbbQOwbr/OC4Ke/PSuuFDlYGCamWsMjIOS2FAJIFGYgBG5+W4C6Si/dC7M0SsHVWMWCdrih5rDDh2udfO36638sDeQPA/Q+qE2GIcvdeycEq0KjeAMJRmmwIx8UIarBEuWxwqXQaaU2gwJgnrZZNTXX1EIj7PsfXq2XNQ0lOZ7g1fEVBswwgSqGCk4wW6knu+amBPcuBuye3WLInhpsJHK+B1tug5ovHIFiJjYORQ8eFCOJ5EMXxuheFx4DeUbdCL5eKXq9YgE/g4yBKQDAavHdqu1vYriK1DsrCDa71A96hvywLruSwMLWyU0ggKj4m4JBiGYsDOtYJzvfPjJwMdRi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8936002)(8676002)(52536014)(5660300002)(2906002)(4744005)(7416002)(478600001)(6506007)(7696005)(9686003)(66946007)(76116006)(66556008)(54906003)(64756008)(66446008)(66476007)(110136005)(316002)(41300700001)(38070700009)(38100700002)(82960400001)(122000001)(26005)(71200400001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YDZkUyFvPZCL/KDFoisxtgVTl49YEVQqhti+NmHRTdobdmCmbNyKfVmiMi72?=
 =?us-ascii?Q?cZiZwdEd97pdLKbnYfUXpOJExg8gfIHrFk0xC4SgQY240LuXESON2TflzteV?=
 =?us-ascii?Q?jpyqLq4nUmOPll/jTj/UOxOHA0uvop9BwFH4pwtKNxtKpE80xSo7CLS3O5LW?=
 =?us-ascii?Q?FLQ69DaCXNZL7x3JGOpGHvJHMK8FnXxZ2JH/+TzTy7F+INq3NnrCkuyK3wf/?=
 =?us-ascii?Q?iwoIrnbTfddGpgV5ZUttNch6wCqaF9SuurdxDIYtff+c8AKVFEgh8Hml7Q8Y?=
 =?us-ascii?Q?4XrwmKpsm1M0e51uJ4pqlvis+94APrMSPC9zL1xPoBMGQuWhELAWqw0F8iy3?=
 =?us-ascii?Q?L0yy9KNHN6DKtxqyRGT0syh81iwapPPDxzodyvYuzBL7zDX0lbeJ0yEz+SpU?=
 =?us-ascii?Q?ZFB6oSQxK/+s/4RRWo4SRYZ6ejpGt+0gLYihWDq+oUd2+3KJJ6Chxx9jcufH?=
 =?us-ascii?Q?lurKVyyP0np1kTujtTZq6IQWISQj6RExCPdh+GKF4AfV3AtF9T/gZdtlsAuJ?=
 =?us-ascii?Q?OAXBq68Vt/LqBg6EjyD0JwzRQbBMde6kkcva12hCjuyUbuFLBMYs2CFP070X?=
 =?us-ascii?Q?den1FnQYkJE+xcewKbLVzY7N5TtJ4nE99/5kIstABp6UWIYqJ04ToC4t3rpe?=
 =?us-ascii?Q?SMrJ1fYYtUxtL/alTv/RvBqjXQkpfKjb/rU323raNpI6w+8ZTn784AuHyC4f?=
 =?us-ascii?Q?IabjfRbqgKo2DWfnbZyxYHDQaceCP7nFlmUTP9CigP1EKdpejdIAYIN6ypWO?=
 =?us-ascii?Q?axd5QRU+7a4lkZh1dTK7wgdLrI5Ds+v9YoDLaLR2rmc5N1ACHMwhgkqeCB0P?=
 =?us-ascii?Q?8LDAw2/a8KKSQ8Yu50ZAo0pt2fsvcjYkh9jidsQ3UP8InKWrlBn9fDucVQmP?=
 =?us-ascii?Q?rn6/JQkPWht4Yv87rnsZQFAVxkjpLcTWRSX/AsrHk+5jbvOR+ecXBy+RR23w?=
 =?us-ascii?Q?42fACpYq2EfsjFP0zT3alwdvrDfw8P03Ly53yi9HOSpt2YypNYYdzTRmdeOT?=
 =?us-ascii?Q?k+bn7M8hNkbcdzhBM4Ih1CS0wEZTWx3WhKzPKdS80GKBav0g36x5tMGGC9fq?=
 =?us-ascii?Q?LfGKrf632/R/z7uD9gDbLIuAx5LfzeTBMeGqYGh2e0jH/QEc4pTjXm+eZIVz?=
 =?us-ascii?Q?wa5BQ1HlNqLLIPOcyNVhYfeKsRJAAtT25+/W+u5r8b/4BAEua+Z6236069h1?=
 =?us-ascii?Q?pKIG8JO8EGoNc2ENBo3nItZuKvKdL8BwZH+jMonF8YpwTF61mBcuLqmh7mZ/?=
 =?us-ascii?Q?3QDY7sq/UzZXPxdYE8XOhkzXdifnoc/tTxff5IWbFhQ5Gv7HzTk2HHr+Omu3?=
 =?us-ascii?Q?wZGDF/bQVEcOOKniWsp7NKf1MH/5ZIjBoVr5ysm4j05SmMZ4gTQCh+hzUKem?=
 =?us-ascii?Q?4f/NFE9dj6qbABq5rUCnx3fgBMx38kYAGa7+jSpeUho7ydshPFB+Jqt7IQgP?=
 =?us-ascii?Q?yXTMq7hoSETYFTc521PiKmI4V8U1qF8ki263uFIX+pa7rsdlPl8go9Iqnoh2?=
 =?us-ascii?Q?FucNY+o12Q0gVnjZ18lNu8wiOZdzqBlJIPXk7Jate99z6tKMWk0gkpv6CQUx?=
 =?us-ascii?Q?nCKuszOc8Sh1bsqOnm8pfNYNzIN80Y8AlOH+ZF5M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7648c05c-90e5-4c4e-e44d-08dc02a5bc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 04:23:23.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCMQHH1Re0kQZ5eRp7ecMR74KVQAFXrn4raMo6tkgLAEIz2dmksz4Umg1ZpUyXAmzNRqgsxBNTu3D4/iczuqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
>
> +	fault &=3D DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE;
> +	if (fault) {
> +		if (fsts)
> +			*fsts |=3D fault;

do we expect the fault to be accumulated? otherwise it's clearer to
just do direct assignment instead of asking for the caller to clear
the variable before invocation.

the rest looks good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

