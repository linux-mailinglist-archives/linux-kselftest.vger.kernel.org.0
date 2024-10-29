Return-Path: <linux-kselftest+bounces-20901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966B9B4402
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA5C1F2315C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B075C202F64;
	Tue, 29 Oct 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pqzci5TN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454618A95A;
	Tue, 29 Oct 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189966; cv=fail; b=eVXFtCLAzFQYOpG7wSXQauo1msBHprVX3ONzs0j4whyrOVdQnufPPMX3EhEsiaritXNBtdmyx6RplxNlxGEqyMKwUxmxlIx8DTZ9NOgi4g5ORoCLKXTtRgufKk3Ho996XoNgbV2YTqFcQxB9mKy5cKNXnieIKwAhgSIzo+xCtJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189966; c=relaxed/simple;
	bh=zsKvR2wu6K64D4KhxP/42myAxogUujW50MePOsPJA+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8XTG3PsF1rXuud9mruGsS3r5mmHRAIc3Kbz9cySDZzinSnyGGd9jcRYjN6V/h7oNTJ115TuVN31+EZtEuFW/+vPlY0ejjJQIySD9nBRmQWZH737q03A1SypnybbiXoJP2+sOoEQmTGfP8Maq9q18dc1L74QZOMG85zz1cqzuqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pqzci5TN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730189965; x=1761725965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zsKvR2wu6K64D4KhxP/42myAxogUujW50MePOsPJA+A=;
  b=Pqzci5TNVH+M2nHr6fvk+BzYdQRer9oZxw1X9fHjSeX+Yl0GrlGbTlVy
   /NS7BZFBonwTfILegHWUnVhBUsnRzAgu2OR/SCcAIqE/tB+QeSoVMahM1
   AQVGCGHayY2DgUId4POd/77AKkMv+Vbra64+vyLnTEXWeIiUBjlrpt6UO
   zp/dPc9yU0EeRMJZh6kvAEN4lP/4IHR6JTci5/3grUk10dfMt75nPGehB
   FoABWM0P5RaTvCfCm+b95IFnHKZyQ51r1U70OZHmTsqLN2qaxFTNqlrF4
   JzBQwc8IJNiAnhQ2XxxBIoOHI9YN3IWCPDZgT5VjDDcHBuCVK1GJgbNZO
   Q==;
X-CSE-ConnectionGUID: bMvmg5mtRuKpcVnLYzE+/Q==
X-CSE-MsgGUID: b4YDi/VmSWiTyi/ShygKNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41212468"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="41212468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:19:24 -0700
X-CSE-ConnectionGUID: irouw2GrRRGuERDhYiOjfA==
X-CSE-MsgGUID: V2C3XqsqRiazSk1x7WvT2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82211387"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:19:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:19:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:19:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:19:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thaNdBK7fiWJo03pvB91Gvm3EProG4Ngysx0i5jaXuX3s8IHSkH98JhBsGSxerLCw0LNTx7XHPqeRFexXpbWv99u5e+LiJMebMoQPTBqypVzKuWnXcgY1CufZAiLHXWL09mFXYsw7u4pWs3/Vu7AY5EXtYyCFbNP3fNtzEFI9ObM2IfSQrQXr9Oq5BD3F3W+2IbyUAPo53e4TuNl3HHN5ThLsjehxYGp0vINumA2OO/CGIhu83AOaFtrVV7b9jm1F8mw7EONnhhJKsSuUBRs/llobJ8z3mUQN6MCJFQ6OUt+w3+ehtYbt1QvBgjLXJncd7Eoazsl6Qlm4UwsJko2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsKvR2wu6K64D4KhxP/42myAxogUujW50MePOsPJA+A=;
 b=XeX94zX/1SeepxNgEtldAcLOnxf5oAPYh6xnTSYYvkBqLe6uy59/I7hZ/p6L1yEDYbcfPPt/8Y+yU1UB/Zz0WXyMmuBq6YPEoBNOhnfFza9PpgCyWpEPZ1s2CkKDvRzlgbPTjNiAh8QFoy54HRgZ5iZ78vA6eSXKiz1aXwuwnaeqVls0UAKRjrFklJVwpYSZD+jqE1uD7lgG3bX6Na0QbpBMcauaYcriSIatbi+9PqH0fRBPRQ9IJpqs2ftWRW6sLMjns2ZTNKLIM5lq5ktyI92C+0yY/HkGmypMKGCagQXt0r1uwBISHaXw7wllAQ0G11sZ6huvfpyzAoqj2kuwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 29 Oct
 2024 08:19:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:19:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 02/13] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test
 coverage
Thread-Topic: [PATCH v5 02/13] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test
 coverage
Thread-Index: AQHbJzjJGHWG+R1oR0eGJ7dvq1rna7KdZ/jg
Date: Tue, 29 Oct 2024 08:19:17 +0000
Message-ID: <BN9PR11MB5276AF3CE6E70F13C7BBF0968C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <fab524b7054fc38d71b6d7a46f90e1f97538d2eb.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <fab524b7054fc38d71b6d7a46f90e1f97538d2eb.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5785:EE_
x-ms-office365-filtering-correlation-id: ee4e2d40-27d6-4ffa-71c8-08dcf7f261f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5B/ZKMYhxMrnLrDcjyutXG9Z0WSNjxQNnronoKoz+gSA/JvoeGQ4Af13Jb/9?=
 =?us-ascii?Q?7nlCYnw8TmvujMVvvQa5stFgR6Lof74GGjrmSV3m8SN6EVYX1/NYjSyUlIJm?=
 =?us-ascii?Q?ojQAJ4Uy79mVd9CBPa4iv/IWerdAMaYj5OlG9/g6mMu5jI7OHn6SkA2dCMxT?=
 =?us-ascii?Q?5aQiD1GTeOBKgZhqoRFMNIpOx8gh/tWtA80qwr8r35xg5bMSRd4f5kLc3+mu?=
 =?us-ascii?Q?DVJCXJC0SLrd7ZLomSkFDTF6oJ0gLmwUBhUqzF7etr5GAy++UPrtODVns3xJ?=
 =?us-ascii?Q?FcNNQOvpONGQ1Mz6AQ9Bmv7Gkgc+VUEI5fLrhk5ltKpqzTF3kI14LhboXj3y?=
 =?us-ascii?Q?z55g07JPB04v/Q8FH5oSO2v1BTF26slozs1UTGlKmY/zUvJCnYFILckhhoLc?=
 =?us-ascii?Q?giNuB0f8848n6vv4VsmHPKTavJH2eJFBVmwQBIBLYe7CEW4i9d41/vY8s25N?=
 =?us-ascii?Q?D5RvqCO/FyohcuYj83i3x1hbhUS54L7K0UjcoX/A8LCP23Iqk+tMtd7CWp9F?=
 =?us-ascii?Q?GEl5A+G5INsIBxEMeikSI9FWOk06A+AfMZweATmepydMPrxMUthigwgks1En?=
 =?us-ascii?Q?fPBSKlbIe1e/KNLXwIoZ9pBiNMgovwjSpJQczSMd3juZo3QhIaM/O5zP6spJ?=
 =?us-ascii?Q?iDnil+52Uo8h5yUo6X9TYugXsOEHTXOUOLRWIz7fecUp+ySkLJOabYJmzRIZ?=
 =?us-ascii?Q?ZZ24b74ZJQ24F9RBt2PkcvhZuULMeRF88Ac+ezAr2p3/cpog/rvTL3bIkaJo?=
 =?us-ascii?Q?4Imj82OMLBphVcpO41nzNVECZx6k9ynXaGvOClTe6ZD95vmM6X8mA6bura1e?=
 =?us-ascii?Q?FbVj1aB/HpTL+7FH+LsAEnZ+OqxmcIASzTZHJE8xVXhIeQD3cFbtihTTK8be?=
 =?us-ascii?Q?hDR6e5lwbnxHzhIEr4XC45QhiB6sK5c0Jex/FfsmjzSKF+9KZfbab/a11CW3?=
 =?us-ascii?Q?Ml5BEujHV/iHNLurTa55gXv8VYpd2w2KZpJfo92H9dfM8ngEZ3vZfS5+ww3r?=
 =?us-ascii?Q?UVv0q5cfOnW7SxInyjWZ6l1AG0jo1eFjVHJMNvWD8gB0ZXP/1c9ZMr2wcGhP?=
 =?us-ascii?Q?iUnn674FTdgEf80UhG1eC1VEpDJGahnXoOpJst1RBeZc0Drt4WCByJhHULtC?=
 =?us-ascii?Q?MH1yVXIJ6iy4pZU7Bo7/2f0+SqN4TF2PlIJZiuRciWqp+PKRF4Az5vk0vl5d?=
 =?us-ascii?Q?ZjonuRb6B30Eta8YbBNVrQaMWorkmM/1MhhyN6Ua/B1h0/Pbf/ECmzsp4nDs?=
 =?us-ascii?Q?orAs2USuYM+uM5UNHGS58/k59eNI396z9G6BA55aQHrSkEHXy3vJuZaw9qFE?=
 =?us-ascii?Q?i9t+k0ci6ymbj9/xsJ2VdItEKVvKeOdVrYnoNjhUt3XIx9oCTVO6pmH9KY1c?=
 =?us-ascii?Q?7lg2iUs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9crFKV3kN2pagA51T0drG4QVnjsMAPfFr8GqLUjeZAOtN1Tkv7ULwMirOuBy?=
 =?us-ascii?Q?m1E1+7fNlrX8Gbzqk7WhDqDGhQQU3KpoIbyWpEry7XwFUDI4yHTjrIFBRh8K?=
 =?us-ascii?Q?/cwn1m1Gu5fi1yx/hoprE4y5PDLDB8pECufFIYD0x1apv22TE4tAc2BPZhst?=
 =?us-ascii?Q?3rDFg8WsZi2i/jjVSZfx1LRJY6pLxdFstrbRJlmMDKq5IULF4qhs62oZ+Uxy?=
 =?us-ascii?Q?C0XkO/mqgX7X+t14wuARkyB52SkoHVMKx9ae/eSwimPiK9GD6H1M4JlHexlU?=
 =?us-ascii?Q?hBH2cwyXhJ6oPPSMwR/tevVlI90vvwr/tDnv0aw3rA2kJKCE2W0sG0OG6qcS?=
 =?us-ascii?Q?j8/YjbY4IVg4LkrvOe5joSn4diq5aaLwq5Ruamuqhg8zSBP2swblanim6TBD?=
 =?us-ascii?Q?VreCWj931P3FmdJ3b9K2rGcG9HIFPstLl++9Rwr0wQoSMBE6X3HjvVQ7tJ+j?=
 =?us-ascii?Q?/8Wj6aLecGek5JvV7ySSRkdHyAwFlt1HJoQUDlmA9vh8OnpsU6HyDo5C14hA?=
 =?us-ascii?Q?rTMFaiJpSrfs1VWq3mSVipjNwOPkcVjz3M2esvPMjUr5rd1yePQLF0l2/xW+?=
 =?us-ascii?Q?tL473q0D/Bf+nYN2zxbW/3lZMyjlVVjd1EDIRziWbBukcH44ySKhSSmjVOZ2?=
 =?us-ascii?Q?1C0JqaVM4J/qFQmsZQ25ZVhC0AwbTan3gc7y6OvsXkfR/XIPCIUBkSjVbB08?=
 =?us-ascii?Q?ThaeilnrpYRpZUShDxVw9C4P66l03LXmwV+Au3e7C35SQaT9HXjIYJTQsjT4?=
 =?us-ascii?Q?s4z/lC6FCIvoE7PRJKUOYELS+MEBvRLOqUUOeGsBvbX9j/O63vL1HuGBR/2v?=
 =?us-ascii?Q?fAzB30fFB1ZB4ZLUqwKPokzYM7qJ68FFnH5dGp563UvzWv89SJkKnm6fe6Wz?=
 =?us-ascii?Q?H8DNc/NaaQkKd286XN3zJgCUVkmVimA0AdSVA93qrBreyRt0FSgrxrxrEaUk?=
 =?us-ascii?Q?A8/3IKpxn35E51DSck55jYr5yu3ha5l2CFbqncDxEp7UA9OcviJ8UV7j+uEu?=
 =?us-ascii?Q?nPZHKvOW0KvXdzD6/BSSZ/8ax8AVEWBUdzECEwhEgb7JuPyH0PuzJ6WW7FOM?=
 =?us-ascii?Q?I0Ng57lvnUovJzb0mv8E2xfDgfWYUNnydwkwlSR7FIt7VAHAeHUiEn5Ys49H?=
 =?us-ascii?Q?fz5RVeOo3JSVBiEoCj2hxeCYn/nXmwuvz7vhCoN5OX4ijsIsZ/IbDe5KSZGl?=
 =?us-ascii?Q?chcYQjQjqrQTE+lpqo9tTLzoXto3x7VZUQrBib0aImcIySR5bSzEY2y4XZc2?=
 =?us-ascii?Q?UDKf14/Lk0ZItjJ5Ubdap4U25lACTeD6ZNJRApqxuOxpCdaS1fxd2LKgRenr?=
 =?us-ascii?Q?5nF+83DUOSGeb48eFiSFEe7Xpw0KukTv92QZ+dGXkMavcjwgzjZebkZLvD2M?=
 =?us-ascii?Q?8YGkev03bJfY3o0HdysRYVJYPDqygsuV7lsJUz3x19n/3rQKFS3T/xOZiitX?=
 =?us-ascii?Q?RgXyx2jePXrhb+M73XL4ggEECaAYZs/xQwFXpuYg2VXlvTb5e5hMwDcJoGer?=
 =?us-ascii?Q?wQezXJBPYV5uvIx/vncgHC4xNWq9/JvFHA6W+MaEa8IDy/YCgYARsfLIGDqk?=
 =?us-ascii?Q?7Z7x3hJJs8O0vPgdb7O1lMn0fdyXPodKRO+bW4T5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4e2d40-27d6-4ffa-71c8-08dcf7f261f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:19:17.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGfoHosDkPuLR8Q6zQzFX9XvQLBIWNuLlVeR1Y1EDrZuSodnSc1vRDm3ItuC6XdW46TWHVVEfOe6QY3n4mey1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> Add a vdevice_alloc op to the viommu mock_viommu_ops for the coverage
> of
> IOMMU_VIOMMU_TYPE_SELFTEST allocations. Then, add a vdevice_alloc
> TEST_F
> to cover the IOMMU_VDEVICE_ALLOC ioctl.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

