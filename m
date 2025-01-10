Return-Path: <linux-kselftest+bounces-24182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E862A08851
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 07:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71B13A6052
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC6746E;
	Fri, 10 Jan 2025 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FApzyixZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7C17B500;
	Fri, 10 Jan 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736490384; cv=fail; b=nAOghxfm3jutrVgGodo7U/BknjAIBvtDIF/cHLN/TwpeSgBnkzVVpWbLPyML1irMHUvctwKyijiSJ1J793GXKY5Tw4Vsbf2L9GaZzRe8Z+3NmN+Odvx2e8hxd2drvW81q081O9P0nyqPOngo5BNYFQ1i40H1PGsV37Gx5W1Zat8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736490384; c=relaxed/simple;
	bh=g6Q1lj8cFqce6vnH6+AgRR9GAm/ai/ZPLAVTtoU617w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQHDp9+tvLGeoC/ZJWqIx3PAqOmfHCXxTFR7/avZpkCD2ekcY/E+q1DTQg4rI0NinFJEx1LNU9oalG2geJkrGbWwiZPg13jLmzSIIA1fUGt8DdpeA4S0GtL4d0kuIKBBRRol3dB4el6pm3LWVLlQrzYjeevM/8vP0a5Bc1qmaMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FApzyixZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736490383; x=1768026383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g6Q1lj8cFqce6vnH6+AgRR9GAm/ai/ZPLAVTtoU617w=;
  b=FApzyixZF9SE7sSmjxPXAlCIEXceLG67lDHIJDFrvygOvVRjasw3uU83
   t8hkjsHrO824UrbDfjDrJP/G5AylltzmGYd98BHv6V8Bvym41rNB4Pcr8
   384MevXH0vAVrg8RMIhaWfYJuppb9QMqV/EMAyIv22I/icP19t1iENoy4
   lOTCFJakZT6SVenGpYeoCDbHEdGpIi0ExUx12fOuRbekQwc725/xCtvac
   jCSMr3JEohe9FOxtmdDXiyjVJXi+lrMJcAZmBXBhI8ftpuNrgw1zqrJ0X
   83/14MYORP66m9Y3Y8rY4xWLOcotpNsOa2Mb6Qm+Eq3e5FGcgQ7tB0VNk
   g==;
X-CSE-ConnectionGUID: 6DPeW2p1SB6W8CbCFAyM2w==
X-CSE-MsgGUID: O0/jyV/hS+Wv/ESWJbbaGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="40456441"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="40456441"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 22:26:22 -0800
X-CSE-ConnectionGUID: 9dESlnwiQR6klrq8Tp7STQ==
X-CSE-MsgGUID: 1wy74TTkRr+nYihaBE8oYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="104167821"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 22:26:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 22:26:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 22:26:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 22:26:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBryje2heDnQDb7uiy4BFPSQJ2U4xjoHZ0t9i2uEegO/CkCUphTBibt1mynHnjfAEIJkZK6Nmr97E7DhVNFIGrqnWF9QW/0TgnjLtk4uz+z67tTQqNnthXZteBimRmLC4KjftUd0uUIRUzLDGN3AieRy7hpyrFUIokIONW1v1oD72r219deFsyKViunSvEEL+MxZY0bAxlNFDpJJgXJGusJrC82V2OWgXnWA7MoocaQWcUpgRgC2MRDV6/y2DkP6qxcvSSyaBftZ/1FHSG+j6M0lAql3kzFJb2UU267I66jAHMoiaW26zN6rq8MGd39mbWIab4IjHdC1prsZaM9/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6Q1lj8cFqce6vnH6+AgRR9GAm/ai/ZPLAVTtoU617w=;
 b=p0GacM5ZfYhpRUVcuZvnwlJ5spAdjgqojk60TmynAX378bHyA4wQ+fmUTrme14stCjxu68XvmeEIFqoda3jFEBnxU1deE8se4c+u6FKUR/OgwT+vc/jIlahkoheFrcdoJ5gQylQd4LWRuHyPobG3TYEcqnkKkOxlLJunWRu+UsOJcyDuHuOiglWXa3UDLnCtJ092uP2kAyOmSb3Kyoqnogd2tGrNONxbqSEpsWwRBK9QEWWWSRR5TQvNnaKuWi8CecCZjx/imVJt/cGEnL5BgWe9kFvlhTyS4Vty8SawnkIcRqEHVOPJaBvSfNM45ItejXq78WUGx6gsWYIg2xpstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7266.namprd11.prod.outlook.com (2603:10b6:930:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 06:26:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:26:18 +0000
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
Subject: RE: [PATCH v5 01/14] iommufd: Keep OBJ/IOCTL lists in an alphabetical
 order
Thread-Topic: [PATCH v5 01/14] iommufd: Keep OBJ/IOCTL lists in an
 alphabetical order
Thread-Index: AQHbYScrMmnzwRNnP0qzUNty6/0/i7MPhoSw
Date: Fri, 10 Jan 2025 06:26:18 +0000
Message-ID: <BN9PR11MB5276F04212D9ED1B8C5F23C78C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <c5e6d6e0a0bb7abc92ad26937fde19c9426bee96.1736237481.git.nicolinc@nvidia.com>
In-Reply-To: <c5e6d6e0a0bb7abc92ad26937fde19c9426bee96.1736237481.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7266:EE_
x-ms-office365-filtering-correlation-id: 7f5d4289-6626-417c-b980-08dd313fb192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aGkM8auhpKf4Nt286IWNUcM4+EsIeiRcYTZXexaVUnSwLotbM0JqwZEszn3A?=
 =?us-ascii?Q?ACgjvBY0Y3omYUzPvMIQMVZAgYAIeYz8v8zJZaYIoQ5et1HmqbORfIpiH2nM?=
 =?us-ascii?Q?Z0G/eeCC/PjHRJ9CkdIQBY14TEfbvAIPOvJMJvn1osPpVIVlvpCkggor3alJ?=
 =?us-ascii?Q?8IMmBUQ0OcIL2Ogszcr76l3VajnQEhdPh/W+GqmGgSXcBeB8QDBVe70xRUzI?=
 =?us-ascii?Q?a3Y83ar/Bzu2eor8CWuadka8dK3mSV/Y+I8uYXQh4CwIDuyeplCRbWYJ/3Mz?=
 =?us-ascii?Q?0UP168B3XTk0oLx8W7wa5Yey3K3Vf/iznkMwUDTJ18q8w8Iz3/AnkmFSAhS3?=
 =?us-ascii?Q?yCZi3HrniXeTyL+BCMTsICfQGzk6IIhwaPhMGri6kjc4nYtQuguC4pwMM9fG?=
 =?us-ascii?Q?N8bXgSLEJlLuA8rk09eb15Yd61G6IfdOfAmgT+nrOFzJzq4m7AmY+HTF/8cF?=
 =?us-ascii?Q?u9cRfMrMlKWi2y4xJc24q/VQWKKwIfJg6EKjAkyMHwQxafjj5RQbl1XULEgi?=
 =?us-ascii?Q?+w30K9MBxowIIS/WJs/2fR7jV+NkYBfApO8nT9MUh7Z/tJa6ZYKPdT+bs/Sr?=
 =?us-ascii?Q?lnNK2y6h1s+GVLJrmZhMkRC7k5OCGbS+aIy95wFeBpbOL2xhL7V+QhmOIwJu?=
 =?us-ascii?Q?M7hj9BYCuoPOQbgJRRzJRHmDl2ms21QgDIEAba5KXPHkb/d7xMB8PFxTCxRF?=
 =?us-ascii?Q?PxVlUXpqTO4++8PVffDoM8HrFbPlV98jF1FNWI7VhjR2nqxvsoHE7TCfIycR?=
 =?us-ascii?Q?EBi3vYWEQ9OoltRfVyy0mO4nNOMC1NsBAyRl9MnIwUvFF2gFcWm4W8yZgroP?=
 =?us-ascii?Q?kEZfUwLBwOX2GhlJCBnTFso0UZnlzATp38wz16i6x8Ni+ORO8BP5fsbI16x1?=
 =?us-ascii?Q?SJW9zXbRD2xt9Z2kznHROqKQ+0nA8dZlaO2GAi3v5LG6N8gYHvM+Sa4BiO1w?=
 =?us-ascii?Q?M+21GNvwzEw1BSghkug4YjD8hBCJrXwA0lb9cET3ORtIwPlCOadYQ+GOlxrK?=
 =?us-ascii?Q?0pO5DPpkp1j5UnIy3Anf3GVMSkr1mWRjHo8TkFlQSMKW3EY6ALisn5NHshjN?=
 =?us-ascii?Q?F+GONe+KPgQJd48sAlpMsXDR5WuqAWYinBhJMZYNbze/inChMPkcVENqe6HI?=
 =?us-ascii?Q?iMMEy4DwFPPQBaphgV8zwmWUv0qiTVGcCYw6K270QczBW/4OOlAVmi0vQm+5?=
 =?us-ascii?Q?A72QNlzSXO1F84BAV1jtnHPA0E4PgO4N5sGJXqDuGQ/5viYnHtdRko4qjJIN?=
 =?us-ascii?Q?POXI8hpL1tqNuvnTIlggZX38e7a6U85VYmPhSK+BhCwEVgke/gTCaanWUtve?=
 =?us-ascii?Q?FgE2MrUjb6XuihhF9wuG2FKLjiIwShwiqX/kCN4Wth4e4XYO9cYaWDsxWStQ?=
 =?us-ascii?Q?Fmd/8RylqKZKDkQnLmgX1fpAL2hoUtIwTerUEHQD/jBnEYLD6N05EFhgkc42?=
 =?us-ascii?Q?VEtmmBXrhaM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/cx8yFI/qj8tCO5hMVj9zOQreafab3U5mhH0Hye4zGfjx+SuqyfEt6Zabi57?=
 =?us-ascii?Q?AaCIBVebRCX4mPnDg/2YdA+l/ANYSU+s05COmO8dznEd+SFfvNeQawWJq7SA?=
 =?us-ascii?Q?O9/Use25qs9GNZfVavvhdoS5e2H+9unBxjiBv0D1MnLF9EzgnHteqF36wRYS?=
 =?us-ascii?Q?RoF6gO7VrFXe1Viqs5Dtk4p4A4l8+YD23y3Zl7+xosFfMs4e8Zzhapc99ntB?=
 =?us-ascii?Q?3kSH0YE47wH9e7P71fECwx6y5ahwV5uFlmfB8lINEpxO/m13kWKPZRe5gQpc?=
 =?us-ascii?Q?xDlCxBdiqV/7bCC9kFP4ejLlwsoAU1H7CRfRmZqvKVNT9vKQa9vCyjhmfdHT?=
 =?us-ascii?Q?tQnSSdCJNdOHRGedNGwTuWo27H4JpLOQCK3XLI34aEE0FpwKeouGQANmK2k2?=
 =?us-ascii?Q?543zAq8R2Q9Y7HPLLKJbbq+98NR5RoCrWgnMp70t0OJVAH3GYDeISO5wQgKj?=
 =?us-ascii?Q?9Lm1AmfnfsArBiIPLECViCn2ZYnlHX6AlhRPHWqeY4yojtrq5geIRaGbYzmk?=
 =?us-ascii?Q?qiFdblxN9yNDNt6n3q/9ZEd78KeeOldFGa0NQ9OS9VqrXx3krolaE5xjdRXU?=
 =?us-ascii?Q?uDdK1+bcjmmk6YDnyJ8akF9km/k6r1YTYSMXHnXOUISzEaUluXqw4FEFSJhX?=
 =?us-ascii?Q?mzc+U3Akpkd2W6AIZyvBkWpSUMmrxD5YFTsbJn8xcoln60/WWT7e3IlUdrsg?=
 =?us-ascii?Q?IMij9GyEnlwnaoXLU7wOiipugP7sodfs1iGII7wz0+wb7KYSMwxC+pDTw9kw?=
 =?us-ascii?Q?Eorqro5tyf7lHtHdbHgOD/O188ipkcj/dGNDBcJ2vFf/3+v9Ymzz2HrPynEX?=
 =?us-ascii?Q?srs8K+kcC5JmzkyBJKk0Eee+JrxVWflFzJlDi0aeoqrbNr0TVkXCEr7lr1BG?=
 =?us-ascii?Q?kMExqXLgRtH84/gn/31u5PL6AyQ8XffZ1KEmH8aFjc6Y+DzX8PlfyKzUdbWW?=
 =?us-ascii?Q?ZY0igiGo1SeihgYyFPJI5B38XYxCERyErgTVzwtUvn1j3MUZ2My2kQ53UDNY?=
 =?us-ascii?Q?FuWEGdtSO1XpmuXVswQcdXBPWlZ2r2VRN4dOlatNPhSp6UmjUQ6/t1pMocZf?=
 =?us-ascii?Q?tqO98/aZdgC1ZoN1h650QWyeXOi4KSGobFYthPGe6CA+ut9Wv4qvSNfGHQXo?=
 =?us-ascii?Q?V5ieyJZnU4xKwov/cIpiPlztrscAghD0fFWQYzTCAZt4rB7ryc+6UxH9ViG2?=
 =?us-ascii?Q?UE1jVHAfNvcvSg8TXWEvEkojb2IiPGVopoo6ynw2RjZaoo3+sCRtESpNekTI?=
 =?us-ascii?Q?uyJ0URbKhA9HNzTX6fSfUckmBkx3TPNbb726M2G9kuHtwl8NZyoz2xZg7RqM?=
 =?us-ascii?Q?nEDTxnj53ZP9w6yZPsFsaVEmlowplONphtplaz9WH4zw+V8GGGVPlkMBmoAe?=
 =?us-ascii?Q?qT7Duig3XA4BWTl/XbSToHJn/MFgcYoYTH6X6O0SwvkERkc1x70JvUOz3yt3?=
 =?us-ascii?Q?BdF8oARLKUQ6QMtCWwuX+G8cVr8Pr6MwhnQpV/8PtIx2WVAximDLkNt7OT6m?=
 =?us-ascii?Q?c6svEZNK2z2X/Bzdy8i2zme/g7nmtXkhMQVPn+9dY5uXUoi7EHx0yAU//U9u?=
 =?us-ascii?Q?gXmJvxwKzIrUN9UZYzLOvl2Qw3y9qk+ildr77YbN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5d4289-6626-417c-b980-08dd313fb192
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 06:26:18.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpmGfzW7BtzrYVY+sSvUWe2qkThrTMioOWuyGEgbaNGe6zmuXKDHPU2BtGUMMbIgWX+vYtTrkojPbo08uOzANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7266
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 8, 2025 1:10 AM
>=20
> Reorder the existing OBJ/IOCTL lists.
>=20
> Also run clang-format for the same coding style at line wrappings.
>=20
> No functional change.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

