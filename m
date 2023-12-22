Return-Path: <linux-kselftest+bounces-2352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409081C554
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 07:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B69B21102
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FB8F49;
	Fri, 22 Dec 2023 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEcmA5N7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CFABE47;
	Fri, 22 Dec 2023 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703228286; x=1734764286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/m7ahfMwfCVu9sA0PTKwCAoXEMglQR6NRR3urdwUxbw=;
  b=gEcmA5N7PXDi/IaM0p6wAZmcAJZ2gMAxwJ9eHFTwZ3rrnW6jUvUAMazJ
   ao+dBrm0OfHhzJEchofqtvtrcJt9refW8OFz5Pa5jyN3C6cRtYeEOnnQV
   6nWlBuDjXKnuZLGltytd0g4OUX6Amt448GsMQAn+mMJpJmpyI/29LwV3i
   TDxd2/VoiA6mKn2voPShLiBOy2ZSyQ0zlExzOAWo8R6dONCba1V1S7HPg
   xvujVtrm7EfgiJ6p4jPIZjCaGfWS0vHPwOgM39efhtePpejQB4PXzl7fK
   QLt8UZ6d7wVSLnUMZ7JSBPe3MQYYKtaP1VQa99jewHUuefIIn0YyPqP4F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="14765315"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="14765315"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:58:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="776968501"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="776968501"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 22:58:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 22:58:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 22:58:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 22:58:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 22:58:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS3KOz9j0B+xvu7X9PWDzKHrblU/4cJgEDquTzFanBqXM7+PiD1d2O1dsgFwJpoxI3biluFrpOkDJyMOrZnKssdY1QvdG2uEBD+TKS62FKMv7Ggdh+gba2Owbgv7Jmz4qZkbDdcCXKDTOUVDf4co+06Fu2WnOYyAaPySePdNd/3DKCW2bbKSiafxtWM+hSxOfIHlfJTSvNriSFRuQnHgLiZQ9xY1ZIjD4OdGtaJ8Oz83/t48AjDgDfM6ALefunTenmeuFUcj8UwviNmHnZ8+3r0jfLya5y9RFYk28GPAfDuB9HGd5bSNea8KIh+GHKZ/QsmomfsrDWQGyP+osfunmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AQYO9OP2ZwKV2QB7nQhdALcaGemPbL94vDqj4gAKMI=;
 b=f0w+6cUE1TjC1IUMp+qqfPx4AgZwOqYnms6+LuI1ZAQ1+P6+RdawWTv/sKLPXo93x9WZHNxfWn4cok7Fh9LWjTc9iN8/VD054ohS0IkRrqaJ0V0vCWhP+bx8AB0YP9l63vx1Lfa5PzmuAsQcHoNr/XyEnQEXcOvmxPqlKTU7k6RjQ/eAjLKcLL2y4iA8mxo+tRjI2TcHW6gZqKCPudErfOLq4Z6nzY+2MN5CeI/mqRt1XaSnpD5qU8BU3+6P6n1/KD73U7H48uU2qN43r9uGj5xz7TqTKRrBZa3V63xMMdWMwac/y4vWTctLyqLMxTgCwnMa5WjDaC7EG3abdpQiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7944.namprd11.prod.outlook.com (2603:10b6:208:3d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 06:57:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 06:57:58 +0000
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
Subject: RE: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4zqzfCm0YG0WB/drS+mURdLC03Sew
Date: Fri, 22 Dec 2023 06:57:58 +0000
Message-ID: <BN9PR11MB5276A45F5355A6DAA8CBE5738C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-10-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7944:EE_
x-ms-office365-filtering-correlation-id: 983ab1af-7695-4b25-354b-08dc02bb5512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SVyWDS1o7tQRle7UIGYjOZzV1KD8tNyknpZC634QfMk+DIcsQ91EWD95srfOvTSLdFv+28aKT5AWoV3QuvXs5WG6CCdw82ZwODxNE5xby0vu5Dpn7cMCOvteLdT2e37hqT9oBq0M2XNmww56tv2xUZn4wFUNADpnlHIRD58mPM935faEu1VVlIK5kgeD3+8p85bU/A7fBWPa4jqcvif/4rW14uKDIz1qKydlox4N+cuMPpmre6QHBgkpFvPUxHDs+kEaorDkORRzcer6n39+9oEb48HMMsXz0FiRfz2L+opQWjKarajqznb3Odcu70D2XzCpZHMvrvLjn8J5dLDM8c7uRi0jkZpBlYq+ynlAMyIrwu+1Y46VyDTAarNNQ163cc1wJlvSm/hJMnzPhME9rvXH2UO31C+YedXaxWdnLfQAAUbRlpIRNlnKAyOfrMMhPbacxZRz+ogTjQMBNfuNv92FRGIjUiI8Z26PppWZEUV6usBmVNK0fBLvpVdrj0eWYiZ2JOgOrJghzVu0lkakEpOYab3E+95ZUqi/8nB/NTQl0gbKBquaNaEYVARZo0YLO+GCp2F4dLl2glMDtdSG8xl9IrZ1dUWQjOHEIaJEMfcUHm6fjn3VI2IyPXykxoDw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(76116006)(4326008)(122000001)(52536014)(8676002)(8936002)(66946007)(64756008)(66446008)(66476007)(66556008)(110136005)(54906003)(316002)(82960400001)(7416002)(2906002)(41300700001)(86362001)(33656002)(38070700009)(38100700002)(5660300002)(478600001)(7696005)(9686003)(6506007)(71200400001)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iTqhhiBr8E2KQmYx7A34CT2FPn1NpCG0lubO2dhhn8ZumrwoCcLlwNFv2TYt?=
 =?us-ascii?Q?MCHXZUPJ2MBsw03aZRx9Ux7U19D8eVUpvSygIGaeQnCNSi89FyaeXZNzR6Hw?=
 =?us-ascii?Q?JstPwvqqOIBX4aWOfK4Z3v/beTKtQTHf4eupvx6Rivjod0RwLXyvFU8qcJly?=
 =?us-ascii?Q?4xRmQddJNTSJaL+jhJPBUsr2E7+3jy0dDkfoF6zv6O5R4Vjfl5VpwXX1VzT6?=
 =?us-ascii?Q?PK7dFBJuyyO8G52TiyuEJDV5seIH8G33QFtteoI7TQF294/1JMs2yi2HIjjW?=
 =?us-ascii?Q?pge1ifbBMkQSZLzUJWLjfqI0rL6lLYsZEF7EyAEtL6VLnYEzAnBok4wllUZY?=
 =?us-ascii?Q?/oOkmohxPLoQQUbtxPqNkZaXAT61H1EC03gwrnYL5FMrq/JdYGOEqhSrBe79?=
 =?us-ascii?Q?al0jeaH6vUY8OnuFvqgAmZOnF3TfP3/l/RzoOFY9gW4zravBfH1RdPXnKOyz?=
 =?us-ascii?Q?bGxTNQeXRBvdN/6H6hpq1ogl55a3pJU60j5+V0IQfpwAcyGmccjBS/H3/Vfx?=
 =?us-ascii?Q?ey18fhgA7oq6NiE+0Ax0um8bBD5IibKTltOOPOzi7eZyTuQSHKLnN/wPp7f4?=
 =?us-ascii?Q?4By9gOiecuzXDbJ8LbSx8eQeHSdXTb/+wStqdfXbMYFxVDlTEuesfaIpv0vK?=
 =?us-ascii?Q?TKI/J6LvSpxxFUwyfeJ92tBmFOfI945hJYmgnLtJxutxNqyNKeLiLa7vJLRH?=
 =?us-ascii?Q?fBrbBFw/cAIvVoBKo6vhlHDPBU2g9vqFPthL1m3F7DM/UxGYaRXtH07yIzQV?=
 =?us-ascii?Q?wmGZuRnl8Zwhk6qlUxlpM8s0LKNGP9siMVTx8Ghd+G5LOWpSdh3ji515HE9w?=
 =?us-ascii?Q?sOBl5bcIc+YIj5kZHGZgqeUqxE/tzQZAz6hXN1nz+l/PZ07oKf+gdn5DMcNh?=
 =?us-ascii?Q?/qVYJ8yoG9/xWp+pAAkiKjiWyKOGxRhu348vNe5ffaC9l3To8fWOMG4gtqBr?=
 =?us-ascii?Q?7tu31V9NwXdH9ulHmqpwnLGesmWVE27OIkiwssmdbJABlvdp8IrLBFWTmESs?=
 =?us-ascii?Q?DiODxz/shpArlIKlJcpzRj5fZ+yEhUwWz5wU87aob+AMKLwxk3bDihV56dri?=
 =?us-ascii?Q?ouFHSNHa28Cz68h5aNYJUtPe1Wbbwr3HghUgo6Tt886JepCVLYQMmMF2R9V2?=
 =?us-ascii?Q?auVzAYep4r5JvRBEboJrFY3MRxfYSnPYCZjFvk8OsjoWh3vSkRrjy3aPlHPY?=
 =?us-ascii?Q?qnWkLhm6pcvv+Vu3t36pwAzvfHt69gnCRG+OtsV370OLWaqJb4/7XsR3wfry?=
 =?us-ascii?Q?1dSFTXrv/AFaVto0t3tv+XwQ8irNaHyqtbWyX+nQaQyueQVPl3fBubyccC4R?=
 =?us-ascii?Q?aG4UCMXAvc6lY7kHe2hs3F8EjAM+IOpqDUXmPhUZfFd8Wmh1jSU0YJS8r4BI?=
 =?us-ascii?Q?/z5msdj0gd+PkR43mvWH9XGcZ1zA9xnKOXoDyYRHjQ31LfLBlIuCezlIcOZ8?=
 =?us-ascii?Q?XQHxRTp4WBssGp7SxGrur0XB7x1gvIvJRyKJdznlwi+xSz8WlFT+3uSHJjpj?=
 =?us-ascii?Q?nDNf4PwM1ogpleEyh7yr2phFOwi9MUf7ms3wnUwGMHh1945TpmQ65GPly0DM?=
 =?us-ascii?Q?W/ODN323AH/2qI2EI7IAkeNMPmK0Yhzdjrem2q10?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 983ab1af-7695-4b25-354b-08dc02bb5512
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 06:57:58.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUuJrkQ2l5Swx2em+LRk3Zq6t10t7pjE96mww+TTuppisTwudSySRcqBqd1oDx7qB6n4se+LPxbeT3QL7JqKKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7944
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
>=20
> +
> +static void intel_nested_flush_cache(struct dmar_domain *domain, u64
> addr,
> +				     unsigned long npages, u32 *error)
> +{
> +	struct iommu_domain_info *info;
> +	unsigned long i;
> +	unsigned mask;
> +	u32 fault =3D 0;
> +
> +	if (npages =3D=3D U64_MAX)
> +		mask =3D 64 - VTD_PAGE_SHIFT;
> +	else
> +		mask =3D ilog2(__roundup_pow_of_two(npages));
> +
> +	xa_for_each(&domain->iommu_array, i, info) {
> +		nested_flush_pasid_iotlb(info->iommu, domain, addr,
> npages, 0);

so IOMMU_VTD_INV_FLAGS_LEAF is defined but ignored?

> +
> +		if (domain->has_iotlb_device)
> +			continue;
> +
> +		nested_flush_dev_iotlb(domain, addr, mask, &fault);
> +		if (fault & (DMA_FSTS_ITE | DMA_FSTS_ICE))
> +			break;

here you may add a note that we don't plan to forward invalidation=20
queue error (i.e. IQE) to the caller as it's caused only by driver
internal bug.

> +
> +		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
> +		    ((inv_entry.npages =3D=3D U64_MAX) && inv_entry.addr)) {
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +

why is [non-zero-addr, U64_MAX] an error? Is it explicitly stated to
be not supported by underlying helpers?

