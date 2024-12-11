Return-Path: <linux-kselftest+bounces-23157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E79EC61E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61971882EAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D51C726D;
	Wed, 11 Dec 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMncJDpB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F001C6F70;
	Wed, 11 Dec 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903761; cv=fail; b=Jmsw/JT9eM9JZguIYI6P0WwKW7hmXmQZlaNr53a3LvdoGR30rPIkmsQstkfv3xLVXFGhrnrbRqaFrbd9vrW+xyLV7HYjOB3tzulBMokPa/7VqqG92NQu2KmeFW8+1fh3WPrzBmmpHUHVQYg4hHfKzVumc7OXuu+QnPywA6Xob3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903761; c=relaxed/simple;
	bh=58z6+Gs9OhkBWfP066r7yFYiWRD3TnhgDetTzJqe3oQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OzGPfv2vk9NZGR+0uo5BB/hUWWO4EmHzKibF4EqqfDi8+w/URdGJAdSIDomZuaPrykucmcBPH+1kno9e3prVKyAqrGtBSLzDL5paoMUvKmgRcCgxn6FAZ/2TVT/LfykeH5T8LmCrxkIYh/me1zBGirMI6wtDErsjnSqt5MNbE1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMncJDpB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733903760; x=1765439760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=58z6+Gs9OhkBWfP066r7yFYiWRD3TnhgDetTzJqe3oQ=;
  b=AMncJDpBS7nwZhF7Cvs0z0A0f69A+NH/aF42RpR7MmWzhn3xsN1kGF95
   bMBppBtfO5huHImthB0ZgcvZghvz5RahTDVRXt9yTA2VCJr1aYyAR8SS7
   jNmDtTuVo+LFDKCm0ckoZ6XPcraMSAwpNg75uTELYFaqaxb8+QVTBil8T
   cVFA3JubxZcW3NXyrFyoUuxatRteES3OS3QtDEchu0BEAWcyQ6X2Cs1Hj
   aPQyE3ptR9YrRKcA3y3ACdJ/zYrZU1Sb3aqMsjH4aEvB8Lcq0AvMGwwRA
   SCMsuoYl1J/BWrFQ+8kj5wTG8A0Bfinx603ZU6KQkLkefN0+wlvjy++Wh
   g==;
X-CSE-ConnectionGUID: EnaEey2GQMmaIwJCz5z2PQ==
X-CSE-MsgGUID: TgogqZbpQtWwWhAz7lByoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34412031"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34412031"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:55:59 -0800
X-CSE-ConnectionGUID: Dtxg494ASKqCSYbuEhZ3GQ==
X-CSE-MsgGUID: qKNDLE9tQZiknyMAYd97mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118946424"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 23:55:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 23:55:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 23:55:56 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 23:55:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei9d3jDpETc3VqW38J27/w/8hGCgwIrG/+ywn833cUPkUEWvkphAgFq23YgA1edrA+kTapV4T4S5BMTBiR/tq+OonYjA/hiP6HgBpPJBLDnE2LCgCSgU6UnvPlBv2yArRcpD6tzzQ8Sl/+KSediT7uEhCZ2NBmGiryNvy3T5g+PqsTvgypgez69olMh0z2An8m89inK13sBZGSkGuX67abjemRnuvM4VVjQQru2sIv/cxfkYZJr5eVwCSeXzV5lmGo0DiwKMPa2NI3it9Yf4kZaITxfPpM7qRgkp2qoGq07a8X85blq1TIU6gbi0xt2gMPjqC8xi9CYE66yO4MK3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmY6PTsq2vG924a/9Fng0QYnD1Z8m6J/VdMxbb7flw4=;
 b=esgVWRHIeH7VUnjwBBr/l9WSOgUDXBNtzH9EnQS2js4U3UOffU+rPt/NaWlzi7eSUTEOMPqYUUL650ZWwIqxYA5UodeTncw3Hr+8nKgEU4h4GSi14xFE+F4DZ44XtbEZ+GzZ/Q5QWqhmwm/OIMV0fa5pdGq+3Z5+C+pjz7LV+pu9ybVqs0eCU0y9Ez9/4zbUxnt3qAB0OB8QIgRzs2mp+qypO2pGf21ujxzpc7cXdaBXC68sKVXe2gGja7fU5A8aPwckGmB64aGlkXw3cum6QKEx14e2pbp6kWz8Ylakf1h8rct6rRitvWQZ0uHKKn1Be4TkdbFJwWwDi1bLFzXunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 07:55:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:55:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 05/13] iommufd: Add IOMMUFD_OBJ_EVENTQ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Thread-Topic: [PATCH v2 05/13] iommufd: Add IOMMUFD_OBJ_EVENTQ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Thread-Index: AQHbRdBM3TNyF5X9yEOTaolkaqNMrrLgtY/w
Date: Wed, 11 Dec 2024 07:55:53 +0000
Message-ID: <BN9PR11MB52767F481C7D05EB1BDFD7D48C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <7f5f7adc2493c7bca7edf76ca15b377c8dc0d397.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <7f5f7adc2493c7bca7edf76ca15b377c8dc0d397.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5885:EE_
x-ms-office365-filtering-correlation-id: 89591516-d58b-4279-ae56-08dd19b93caa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1sQpSW2R4MDkkcBHQHJBnGl/j621ESNgz86HVhATF/2fhcouJoJhiW/nNx9m?=
 =?us-ascii?Q?44OVjqoyYe/sObQScjTM/LqJSqkzkTnwamU+TUMvMVowGLNUY77fOMp1PHvr?=
 =?us-ascii?Q?9gLY5KnwGMRW7QSul/tUHI+AinvW6ZZmFGKUc+mO/LxFi58w89QjoUvdqtd/?=
 =?us-ascii?Q?QEzKc2VkLFqflMwst+OrnG0xz+tOKif/0veIN7pL4M/36DFi3R0Y5zg6Q01m?=
 =?us-ascii?Q?L4AF5XtRo0jn/cX6n9BFKM5pNkFAv03eCNotYgM1qpHZRC2sPKnTAvPX2XWT?=
 =?us-ascii?Q?KruMoAwsA9fIxFpRyExqITyGu32H4eOMj+qwoZg8eacDMe1/aCnDh1PVqsQV?=
 =?us-ascii?Q?+7HTNoHvwXcgwEt2aNPK6nTpg2IFc6rKZPikny+WIjQrts6TqTqlqcymtQpI?=
 =?us-ascii?Q?RMiGJZSYnm8X44n0eRhonMO1WCAgNAKfps025SfGiZFwycsWdpqsbJ1oAgCS?=
 =?us-ascii?Q?JlpQmmbM33ugL0UMPgHuKrlEkn4gFJs6Z0jlBJk2luSjYeGCiqAuLnFCtSpk?=
 =?us-ascii?Q?sjszMGU4qVWr9HT6xFWYYk21o5Hvpe2Ivwt++tfZ9PsuXCl4Cdl5qkfPLdyZ?=
 =?us-ascii?Q?BMABqHtLeOJsTjPt2GCuK7omWVzNDe0aThwCN8zCKl6R3eUkNp3PyNTgQaWN?=
 =?us-ascii?Q?9sZ526t1S5lfB+tjle4Se4PJM7TK3v6E/c4UDHFpe5/tROhEQHqftJcUqQKt?=
 =?us-ascii?Q?2qUSDI8Ac1S49nUCI78QpIHAb2pYsA0aY85r24TR1eLejtWC8ym6oP5qnlDu?=
 =?us-ascii?Q?cWDUDu6NPyEHd6B/3jhs0OmFW5oYiifZYFWzxGqx6Y2XeGrkn/JnxuPQLb/9?=
 =?us-ascii?Q?xGfmFTFLXQMogEha68LeLrXxArGEBtwVA74ejrRwBBygMbl1ls7pii8l+YrB?=
 =?us-ascii?Q?PO005aSGPGh6OD7Gto+NaieeQSBifnbiXyelB4b+zVgaDi+clHzPWf2K+7Yj?=
 =?us-ascii?Q?IcNwrtaLsjruxopl1wqs7jKI/CAPUFgLDIub/3oHipzuI1sf5YFBk7/UW3ut?=
 =?us-ascii?Q?Rj9LbIqdlFjHKLk39Exp/GB86F+VDJsAT3/w1a8Cy0v319EbiZ34voIY/cQ4?=
 =?us-ascii?Q?VWIvc5GmsxuMpxRKBNH821ncssQNqwvOWiEyc6SgLKxEA9jXkQ8/OK9a2kb9?=
 =?us-ascii?Q?mbAZVQuiaLsX4SkmbTiWt+c2bwrLGdrIzayRVRpEKPjC7hTxdHi/JzC5C8Mi?=
 =?us-ascii?Q?BuX1COpia6E+m3xgvNULtd6+HArfPvl60fa6EXJomQNnFjY5PoIxqKB4WAAe?=
 =?us-ascii?Q?HYAffUKrbTqiHz/9Y0RkiWXe41HxvpNu0quPEq5UwlRG00nmV3ZOhhk/tFDo?=
 =?us-ascii?Q?F+ElwkQSVgclAAl3lQFx3n23VTS18uK53/fvIGltHCSlDs4qXwGMgj33sm1y?=
 =?us-ascii?Q?nKyTRD4i05oH0dpJdlX0c6mg4+x8BkCtV+u5dX5aENZg5b6r6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iqh4F0J0V8hFT/tVrIarUph98DfKNSF7pSrU9i5IRENF8evP+HlG44JL7iC0?=
 =?us-ascii?Q?25F64xQFMZ+zEtVmEoYJ9KNMkEcisgZiyQ7ivtA3VJZgdHa7WCcrM5hZoojb?=
 =?us-ascii?Q?UqkukHYMen3+MNWFhjpgUGdAsNkNcSsuLTK01HxV0GznnL3Sbxik8/MJGyft?=
 =?us-ascii?Q?u8hR1e1Lt48Wh3x/zv9VDPk5Mr4bkKZ3S+y+PUafp1dIIF8zsKfjCBM4IjUw?=
 =?us-ascii?Q?NOYdklFvmhzIRcOBcUjief6LaKT/U/IodRE1W/y6l3S9fGVo3ds+1JhaRCdJ?=
 =?us-ascii?Q?soemEbFjkFUD2HfYoRgwvbcix8NHbD3XcQ97LB/qkKLZp6dD2r58bQnrkrgh?=
 =?us-ascii?Q?MuEXnmV8qWVH6HAXgV5LSOaz60AVCtn91CBlRMcjfcTyX+Pi1HCAGHifOSMx?=
 =?us-ascii?Q?dOH4x1P/5r/vtWavxS/4IUkY7MH1Mh2RTaaTYIFegnIebn3l5NpdWXFxbcQP?=
 =?us-ascii?Q?/S4m85Z09QCjMjRzdYwBvHZvcEDeGsg8pVP4Nv6yC7iOf0owtoFN3dZktrDH?=
 =?us-ascii?Q?LYv4fEzucSjpVFrSXGJ63Fizix5FrGQPUOop4ZMhDDwAV3cBzUE8WzE7aStB?=
 =?us-ascii?Q?jX3ADE2xP84KWZFlFIAffgFyADqKGOW1yBBQXl15iyIwtPiN2tSnjR/a3iSu?=
 =?us-ascii?Q?EbtQZthL2T7y7oL3ISv4auareInvIKIXJ1FoTO9PdX0tLQZNi/x+ui5BXs8S?=
 =?us-ascii?Q?5q0hWQOqVQFoJ1PP4cuSGF4FNn+R7CbRx+q4kAZ/O1dnaA1lDCNG144Sb0uj?=
 =?us-ascii?Q?n2ElaO1kFFXYc6MA7M0ScTuZvM+2pDGd0VgAXrbuEm05czeCmoJpM6YgM2nN?=
 =?us-ascii?Q?6W3Co5YRli/qUVwbCCO5gayBzIv+wp8VYqM9ljQQHdXP7Li6ee9/z4r24mnN?=
 =?us-ascii?Q?YR55iuv57pPVh5xNOr90IVYcwruU9zPyWBTUuuUiS8cJ2yoxIg8H6jS3gNrz?=
 =?us-ascii?Q?yLu4OUwZO+v59jZ4gqR3J/zDThCRjE2oIdtKkNNHz9cqaLuduLiqYY4uo+L9?=
 =?us-ascii?Q?85h8ReqB6cTB2NYDnxWyS7s7/9nuu+YaVuB7JKl4IJU3/+wO1Gc+C8FDhE74?=
 =?us-ascii?Q?16YVWzsmVgsyoi/hLH//vnzOMjHKNP8auGfkCmGQGT6RqVHoycczs0FHgi99?=
 =?us-ascii?Q?VokzhW2gOyUj47ZWpK1QjEqCXRflrv7hNaE9BKJVcj0tNsgm2KPLKb5ov7s3?=
 =?us-ascii?Q?jiT2iiROhzC4NczpwlHrvZ7QN58kTdDZ1B8cHt0mlR9TDjzMtv0W/h3BMw+5?=
 =?us-ascii?Q?UkfcpY46qrf0VubISEAoakbUC788gOaE0WQDllt7mVIOGYwAe6g2WC1ktorG?=
 =?us-ascii?Q?L/fQKK/OM6Th14WZlGb5BrI5zJS9X4WvyKY+CFQ5qAnK3cPWo1QyKAxiSGWJ?=
 =?us-ascii?Q?znhwL45E2CLdGqNUrptC6rbh0rk/QvCe8T43OddGO3Ytwky8vjgbsytmDaoe?=
 =?us-ascii?Q?UqdBOziXNqyj7aM1udq/OTvLbV5OGqW59AlFw9gX9lCuvPPAvlXd2RQM6SXL?=
 =?us-ascii?Q?L1mbjO0tHR7ibg/0kmg7ZCLjJMtr9HBu72+HAK4Inb2sS97nUngiiOtCpkpi?=
 =?us-ascii?Q?yiPlGjoaGTf0H7OqpzQAy8adRgJNqK9cxbyLyhxl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89591516-d58b-4279-ae56-08dd19b93caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:55:53.3570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufhMYi1vu9NCGmV9nCpB+wYtaZBGvQ8JaMAnT0cujT9kw9NrVoaN2AO992p3VdtY9XnIVNo+ibKcu27q/KKOcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5885
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
> +
> +/* An iommufd_virq represents a vIOMMU interrupt in an eventq_virq
> queue */
> +struct iommufd_virq {
> +	struct iommufd_eventq_virq *eventq_virq;
> +	struct list_head node;
> +	ssize_t irq_len;
> +	void *irq_data;
> +};

looks the only use of eventq_virq is in below:

> +
> +static inline int iommufd_eventq_virq_handler(struct iommufd_virq *virq)
> +{
> +	return iommufd_eventq_notify(&virq->eventq_virq->common,
> &virq->node);
> +}

If there is no other intended usages upon that field, it's simpler to
remove it and directly pass the pointer in when the handler is=20
called. Anyway iommufd_viommu_report_irq() needs to find the
eventq first before calling it.

> +/**
> + * struct iommu_virq_alloc - ioctl(IOMMU_VIRQ_ALLOC)
> + * @size: sizeof(struct iommu_virq_alloc)
> + * @flags: Must be 0
> + * @viommu: virtual IOMMU ID to associate the virtual IRQ with
> + * @type: Type of the virtual IRQ. Must be defined in enum
> iommu_virq_type
> + * @out_virq_id: The ID of the new virtual IRQ
> + * @out_fault_fd: The fd of the new virtual IRQ. User space must close t=
he
> + *                successfully returned fd after using it

s/out_fault_fd/out_virq_fd/

> + *
> + * Explicitly allocate a virtual IRQ handler for a vIOMMU. A vIOMMU can
> have
> + * multiple FDs for different @type, but is confined to one FD per @type=
.
> + */

s/handler/interface/

> +
> +	eventq_virq->irq_wq =3D alloc_workqueue("viommu_irq/%d",
> WQ_UNBOUND, 0,
> +					      eventq_virq->common.obj.id);
> +	if (!eventq_virq->irq_wq) {
> +		rc =3D -ENOMEM;
> +		goto out_put_fdno;
> +	}

there is no use of this wq

> @@ -335,6 +335,8 @@ static const struct iommufd_ioctl_op
> iommufd_ioctl_ops[] =3D {
>  	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct
> iommu_destroy, id),
>  	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC,
> iommufd_eventq_iopf_alloc,
>  		 struct iommu_fault_alloc, out_fault_fd),
> +	IOCTL_OP(IOMMU_VIRQ_ALLOC, iommufd_eventq_virq_alloc,
> +		 struct iommu_virq_alloc, out_virq_fd),

sort it in alphabetical order.=20


