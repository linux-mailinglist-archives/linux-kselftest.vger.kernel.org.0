Return-Path: <linux-kselftest+bounces-26828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B9EA3926F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 06:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF8216FC82
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C081B0421;
	Tue, 18 Feb 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJ9JbTP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACC1B0409;
	Tue, 18 Feb 2025 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739855648; cv=fail; b=JCzf+4cnT5S0461OQpGszgu+iZr4oRq9AV2tGh6h2WboJPkxmBWOck+jzMb60Kg+EZzrPtDrVt0FZFYkFA5mIX9qVk1ngIquhiYVQu65vAr8Buoz3QU7sT1JLGffM3kgK+xTFSCsLdoTcV6w0Y/eXwAfZj7Da9eH0OL6IMQXrOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739855648; c=relaxed/simple;
	bh=I7hYXdMzkarQQqdHOW3pqJ+6Z1QqcSuT6/6F2pA7vqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ekOj7GqEcPdiJdMOgEYvsbJo7YiH/SZ16IyP+lZAIIJHvP6UMf0r6aR6beeKO3niR1BxgTJl70XlfCqV27CEh8GpLEgq+cvdqxeoA6QM/knP7fi/uTFi5Ajw5ymi2ROObWfIDnANVT+FTCrlCFrdk1V3v3KbmdVTfVZfXTj1YoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJ9JbTP0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739855646; x=1771391646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I7hYXdMzkarQQqdHOW3pqJ+6Z1QqcSuT6/6F2pA7vqM=;
  b=QJ9JbTP0gV1rCeIuKGgaHGquH6STdd97I00UR600SJkjFthUOZeE8JLU
   re6sYiLC24QgdkkET1Ph5KCixWOQVbz1KQLniIErihx1Z06M3FIAbWk3w
   U1XruwNGM+YN0OAqp3uCd2rDtveYo/lVfMOZI+Is2hPGNq7I7bysCYoWY
   QKBOXnKoBaOgcIjNOwico4EtW+WKBG96ww6r+5pvV/4Lea+91mTXa7Nig
   6fqPE4wz1ZBA6qREHi2VA0SEM3hr656ikNcs7YWUnRaVxIeFSJOfKp0iI
   k/kae+Ks/Gq44E8uL+7lWVRyPWQqJHP1AVxnLuYiNqGj6ecgjv2cjGyLx
   Q==;
X-CSE-ConnectionGUID: Fk6L+RLvQzWnuPdNZ6U2VQ==
X-CSE-MsgGUID: HviXAhagQrOzQHEqNi9e4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40660399"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="40660399"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:14:05 -0800
X-CSE-ConnectionGUID: KxvosQ7ZSPOEXEabWpF+WQ==
X-CSE-MsgGUID: o5+DLotqQbGrrpwrKXjJTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118419323"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:14:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 21:14:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 21:14:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:14:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT+I0z3K5lXNv7ny1o+/D/Y3FrhWXNA9GpGmVy05Z3WRN11xDY0sRA3bkDjVfPSK/7I6oZUaZ9ZecUHe0adUmf9Rb4irHN6gS1CoFXapVAuqdQVX2Zxl0ZyJ0SmgGTXG9Ix0ZpSnsjnNC4AP5fJaALPVth5VqkzzUiIyB3+v2HCG6WgK3cfmePCGSofl9ewawqfTydDJduC37C7SolwfsyT1W7aoXzY69mPiks1TYofQ6jS1zIIjymbj7tXS2UzPYY9MGoJT568NYCoYTMHEQFasC4sX7ISfFh0OO/Z+/4TVh6x4VFdH0yO0ePq42KaswRKCXfMBYMuXjZmo8pEIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a87L3+BFeOMCj7F+S4bbzafaU8uU6LhPdjTj5GoCdsw=;
 b=U5GCA4t2otCCW+peASEhfrKiQlV/tCx2XBEOyhbaw2uPfTHdawu4lH0JAy3ZTiRjoUp0PD1W1YD3Pg2kXnvDtSeg916HyGe/2cIxDWM0qksrGumNIzc4Gy2JkVSLwjrfKL4NxhdG5LOIOR2FLvxpG0OydKOoRXZ0muByM3FtV7jsv2YX/5KYj2jjQYUVACP2pyd9ZjLBNP97/u4K760MJWZnnNZkhBPXR/QsE+FjH86qJCtSrjAi+DfLkFTEsn6HGeIbj1JXiaAPJ/r6JqX3aTuNLLKyvlaR0COFzZx7SkQs+ZaZtNyuFpFm/wHpkBJX3neSSzqjEpSPZMrKzgoYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 05:13:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:13:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
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
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Thread-Topic: [PATCH v6 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Thread-Index: AQHbbsB3/FSgDe1QKUK+gEWFAeDH5LNMeqcw
Date: Tue, 18 Feb 2025 05:13:47 +0000
Message-ID: <BN9PR11MB527614EB9CBA3BAB951B0DDD8CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
In-Reply-To: <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7015:EE_
x-ms-office365-filtering-correlation-id: 830c9cc8-cd22-4d60-9152-08dd4fdb05d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rJ2RVyEsTut+AnBu0DFNr8H2eBMaofFYa8Qo7l6aozm76i1TlyeT8EhdJ7Aw?=
 =?us-ascii?Q?ZFEPqgBmQNWo6o/EAmubNO/agWmBQF/4JpLdd8JYL4SbrMluN9OZU2m3w4nX?=
 =?us-ascii?Q?xVGObmLfkNffPSFbwSnG4f/aR77DaCeb2ndtRSxMOIUpynOdBM5HceWZiq2r?=
 =?us-ascii?Q?RC6KovyINqsRStnoMFfI6XdKx89M54Py4wD9QGeElMh30ysG5d0T9IXsO7/w?=
 =?us-ascii?Q?fTobEQDJPt1HrUSOdC6whHXT8D0WKUCRHacB95AccDuBn/w9NX8uHu1evpPU?=
 =?us-ascii?Q?wGCmll9P8fC3OVWQezUM+nmc2jrQRsj6mX6N7xzhF+Ftj+yKIJO3mxm7fnL0?=
 =?us-ascii?Q?sFi8w7Fp0TR5trKS7CE1tB856VtH2oPRTfjPfaofnxOn7theDfJ9TZBonJd1?=
 =?us-ascii?Q?ZltFFyygWzCwNE0UqN2fDzSYszoTAHXQTDmVokmFsAzuTZtte7AbLOE4IMG8?=
 =?us-ascii?Q?GPzs7/Aanb91c0CrDTIFLL/BUlHnbT+xkwhH/Y7/nUSkmURzUuSZN33CdKZF?=
 =?us-ascii?Q?9p2nvh5c118sDhGV7gZEzSnzqT4RY7BdnexVEQswWzzZ0XzruYcQgpJoKAi5?=
 =?us-ascii?Q?fKtI9ZzNlA646HDokGPcLUgz7c4YpbkeOxf1zMf0ekBO6Uk3KH+fhVfSM9+W?=
 =?us-ascii?Q?k/MNwAvniVlzAIZgrrLRzkpYg7kdT9+vhc0NysAsEFlwkKj67/lwrRN+/wn2?=
 =?us-ascii?Q?/CNdDBhGBtH8elXK/O+spvG+RyobMVxjdIaktHNar/YBQ/QvPW6/YIzSZ9XA?=
 =?us-ascii?Q?w5EiwQL23KMXbwR18N9izrwFJjxtxk7mkFEZmey490SP0OEVi8zdJGJmHemg?=
 =?us-ascii?Q?H+gZ7ZMFoKQV22o6N/PyIzEVb7EZkvWMAO+J2EC0BUQ0uRAsj3o4jpifsG1T?=
 =?us-ascii?Q?NZr22jGnK6UvkEBIjNNhI9u/o+1xrmOLr34+xquOSbds7mveFwqGJ8Ibsdss?=
 =?us-ascii?Q?3qDQbrEMwLN+CIPsJlvcGbwlW32U2gYiHql0UcS8LF1KJI1Q7xJHMv8JGjXW?=
 =?us-ascii?Q?10kDXefl+6yuxV65D8B/NVO019K0jIhHwyqDe28CF8P+UolecQR5nWotVMiv?=
 =?us-ascii?Q?zC33sPAANZgzJrmAxJ7cowpzM2LfJaqA7CCHwuViHWjyaCwZPGWo86AyMbEF?=
 =?us-ascii?Q?ZGWpLo3CKZ9NhxQTMuYArT9JEI5CSgerkAcQ4dh2BoJxtf/25PKAg6zioinQ?=
 =?us-ascii?Q?VHwrP/SJWv2ta5Pk6d9ZGlAlUMfpbHMJEQT/TGg2oZPnbwoTFqkfZPF5utBO?=
 =?us-ascii?Q?ugeu9GL8sOItMEYmiuGGTUlBEG2EHfCRfLCgk3uBZToQza/8oO8OJ7dFx81s?=
 =?us-ascii?Q?FNOZB6Lr7YJX353547VAK5KEjHVv2ybBzmRrz0yyr+DqoZtHvrica+676bxR?=
 =?us-ascii?Q?dMW3S9ibYNh7VLeCbI6JWWcUsQf+Zc9IG4cOig78VbGmM4Z0is9dep+eSpfP?=
 =?us-ascii?Q?CwH/g82I/uBAbXrtspuTn0zizMwEQIOp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U3kBoJNDriiIUweVhLB6DjRaV2nvugD40waXtTaiy0w+/9pWN2+AkTHSPlmZ?=
 =?us-ascii?Q?YR0Kkm2YjIPI0Tz/L6140gTu40vs07X1k1u8wzwyl2AyPW4BvIerOtvYtx93?=
 =?us-ascii?Q?PNAGSoVwqGfOoYXFio4+rZ4MRpYHpCkuLpufnXliJXdHppXpmjcOtmcpFNXq?=
 =?us-ascii?Q?ovbuRB5kgHCLgk29sbscCwWFxihGMg4a7J2dH21Tgceuddwdn9rJhX9lBg8c?=
 =?us-ascii?Q?cLDAqY34g9W2pc5cErxSLyaGUHC9UQxa84QW1vjKf2lMZUehKuNG52sEDiFn?=
 =?us-ascii?Q?So0Xy5UuTIL1K/8zDmaeTQ7zdMleSo0CTJdrHgsS9fFube6UAxgd9m1fGMgO?=
 =?us-ascii?Q?SAoLksqZAixRvcpqWlhm/3Utz6a1cClQnJkWOvGZWUWFfeH37lSqzQCIdTuM?=
 =?us-ascii?Q?WTfjD7h4SojqzLTyTCjr+VhCLX0hSI6+vZtTMBxsl8rR7xEhTBqa1zX/FFj5?=
 =?us-ascii?Q?HwFQgU94oAzNR2vQ5kzxggKx6zdMI4cBg4diGhaV98QVaP2KMpfJHzQ34Cu8?=
 =?us-ascii?Q?RP3zlMqo59wz2wQP5gNJLsEu42BBRE1G6ViyAkcefP5vv9/9t4rO2nskZj3d?=
 =?us-ascii?Q?zX9XFGddv035U8oWl8hKe930pyVYX2NaHrJb8VXTmBxKggkat+8MvkdO6klj?=
 =?us-ascii?Q?buUooiXDqfyn9WInW+ZN6IIamM8jMpNoeILnNGv2cBMaT9vHNINRg4s3+F+x?=
 =?us-ascii?Q?M9kZpAP1HGntaY4P8V9VIUJ5IzzRJNBETsNSt5+68da0647CHf+5EX3B0FCT?=
 =?us-ascii?Q?mR19byKBRkW84SMZT/vVsPKzXk+4nFJZDV4PxujhmGjw4Nz2XmZ7yeG4hjpB?=
 =?us-ascii?Q?mHIudGzg/ucrkmUv05pt6wiaWtgKUKY3EFz1qfZFBptPcp8OF+v9ASBUzcsS?=
 =?us-ascii?Q?a2ubWwtKmN/TvUQwA6GJWjrq5HT6tJpCvppp9no/iXMez1pTi3KwNs3ONF19?=
 =?us-ascii?Q?orpCIHjGuZxegmukJRr+hFF60WUUD919bA5lATN24hnzUhssf51jqf+KNqna?=
 =?us-ascii?Q?SV1wDdjTiPTBf928oSSb0iZyfx6uHT/HF7MHG3boIfgoAyBbfcSG7E+meuWc?=
 =?us-ascii?Q?JIF/qKYFfOd+uNrHMyB7CcOlnNcWWkLpfqo6zFhFCho8veXCsa48ZNlF6EEW?=
 =?us-ascii?Q?9q3wR4SASjabLydgmRmpLLDLsEBQCfaxBhrr1bQnlo17Lr+gv0ReEFPnIUrW?=
 =?us-ascii?Q?E4Fz05UaAY0bBR2MvxS/XNsjESGH5C2XUXVofkHUcjrQ9+yDcmRD5/cebXxJ?=
 =?us-ascii?Q?VewVdqOY/oSPOM/LU/EuHDmEFBaBrWrjy4LuAYsptsXecCfX/3yO2lfvxsme?=
 =?us-ascii?Q?x0bC3r45eyCXxYAGBMSUJ/gOTa2pOh4yrOVCEV4PsThg0WUHryt7GViYtUQe?=
 =?us-ascii?Q?eYIEK+PqhJYMTHKtvwa/9+JB1PMtxAaCf2BqB9hcSxWr6ISn4jEaoBRMKUSA?=
 =?us-ascii?Q?BjrZxZ3IJKqaL/2GrPnqtnzpIy6VN8ABfEROi8o+YDVdlhDs5QVgxQyWIbTJ?=
 =?us-ascii?Q?4HWNdSlTUd9iTxbit1fAIXIpNlGX+MFGY0++PtcIAz9owt5LIMos2qIJtEGl?=
 =?us-ascii?Q?yw4EMpELgj8FRLIsE/y0ZBL8/2U2gh0OX/E+Ooxi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 830c9cc8-cd22-4d60-9152-08dd4fdb05d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:13:47.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kj5fz76u8OoZGhZK1AyQswF/ok7I+IzzuJXKItQIQuDPjxP8Rz3yH7MxeFjqy5ZSqx+rX93V32EIJpWeBFOZmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 25, 2025 8:31 AM
> +
> +/*
> + * An iommufd_veventq object represents an interface to deliver vIOMMU
> events to
> + * the user space. It is created/destroyed by the user space and associa=
ted
> with
> + * vIOMMU object(s) during the allocations.

s/object(s)/object/, given the eventq cannot be shared between vIOMMUs.

> +static inline void iommufd_vevent_handler(struct iommufd_veventq
> *veventq,
> +					  struct iommufd_vevent *vevent)
> +{
> +	struct iommufd_eventq *eventq =3D &veventq->common;
> +
> +	/*
> +	 * Remove the overflow node and add the new node at the same
> time. Note
> +	 * it is possible that vevent =3D=3D &veventq->overflow for sequence
> update
> +	 */
> +	spin_lock(&eventq->lock);
> +	if (veventq->overflow.on_list) {
> +		list_del(&veventq->overflow.node);
> +		veventq->overflow.on_list =3D false;
> +	}

We can save one field 'on_list' in every entry by:

	if (list_is_last(&veventq->overflow.node, &eventq->deliver))
		list_del(&veventq->overflow.node);

> +
> +/**
> + * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ
> Status
> + * @flags: Combination of enum iommu_veventq_flag
> + * @sequence: The sequence index of a vEVENT in the vEVENTQ, with a
> range of
> + *            [0, INT_MAX] where the following index of INT_MAX is 0
> + * @__reserved: Must be 0
> + *
> + * Each iommufd_vevent_header reports a sequence index of the following
> vEVENT:
> + *  --------------------------------------------------------------------=
-------
> + * || header0 {sequence=3D0} | data0 | header1 {sequence=3D1} | data1 |.=
..|
> dataN ||
> + *  --------------------------------------------------------------------=
-------
> + * And this sequence index is expected to be monotonic to the sequence
> index of
> + * the previous vEVENT. If two adjacent sequence indexes has a delta lar=
ger
> than
> + * 1, it indicates that an overflow occurred to the vEVENTQ and that del=
ta - 1
> + * number of vEVENTs lost due to the overflow (e.g. two lost vEVENTs):
> + *  --------------------------------------------------------------------=
-------
> + * || ... | header3 {sequence=3D3} | data3 | header6 {sequence=3D6} | da=
ta6 | ...
> ||
> + *  --------------------------------------------------------------------=
-------
> + * If an overflow occurred to the tail of the vEVENTQ and there is no
> following
> + * vEVENT providing the next sequence index, a special overflow header
> would be
> + * added to the tail of the vEVENTQ, where there would be no more type-
> specific
> + * data following the vEVENTQ:
> + *  --------------------------------------------------------------------=
-------
> + * ||...| header3 {sequence=3D3} | data4 | header4 {flags=3DOVERFLOW,
> sequence=3D4} ||
> + *  --------------------------------------------------------------------=
-------
> + */
> +struct iommufd_vevent_header {
> +	__aligned_u64 flags;
> +	__u32 sequence;
> +	__u32 __reserved;
> +};

Is there a reason that flags must be u64? At a glance all flags fields
(except the one in iommu_hwpt_vtd_s1) in iommufd uAPIs are u32
which can cut the size of the header by half...

> +void iommufd_veventq_abort(struct iommufd_object *obj)
> +{
> +	struct iommufd_eventq *eventq =3D
> +		container_of(obj, struct iommufd_eventq, obj);
> +	struct iommufd_veventq *veventq =3D eventq_to_veventq(eventq);
> +	struct iommufd_viommu *viommu =3D veventq->viommu;
> +	struct iommufd_vevent *cur, *next;
> +
> +	lockdep_assert_held_write(&viommu->veventqs_rwsem);
> +
> +	list_for_each_entry_safe(cur, next, &eventq->deliver, node) {
> +		list_del(&cur->node);
> +		kfree(cur);

kfree() doesn't apply to the overflow node.

otherwise it looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

