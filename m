Return-Path: <linux-kselftest+bounces-33554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F8AC19CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 03:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E367C1B617AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A241F2B83;
	Fri, 23 May 2025 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lG/sxwcc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579F2DCBE1;
	Fri, 23 May 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965137; cv=fail; b=PYooD0tSsIxcjI5de8cLR30Phn5IfKn0eW7v4+uL5cEoyd2a7S83c5nu4FhaJC8Iojs/+WSmMAxw+MzZITymfKgqzmdySTtRRAT3I/BAP0EtlTCe/gZv2f3Kw6GMDy8joXkySJUUb1RKs0UcWcLjwKeh+hhzvksoP3YZkATrFwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965137; c=relaxed/simple;
	bh=ndvsd4ukvwC6PxiC/tTcXyXhwXtHCu/agd9X40Jybk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F2m+r8VMDsnhLSHhTzVXpp7jSN0oy0ydR8MxM/Tt1evb/HukG9m3SnVn+BpCZ6mKBLHhREuyKWM0tkqt9VMlITukSn1k6WopwRyjLXuHEFywPBfRMEF0vOnpz88JNcrZC3TBnXRBTLhvL2vdL9urI5FQWuhOvTf/Je0ppDiKims=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lG/sxwcc; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747965136; x=1779501136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ndvsd4ukvwC6PxiC/tTcXyXhwXtHCu/agd9X40Jybk4=;
  b=lG/sxwcctS2ZJbPjhDEoAY9JSvgLhcmGHKbqrCzkW98VoOqBzrexlme/
   11eJQcBJ+gIll5sJCYJ+rKDx+NTgf21X2+r9N5nWoevENkeuC+sxgcZKM
   dBtq4Wn3RtUTfT3lSGl5rLQFz2Yy837plpyqGUiRsCYY1epFD23/Mn5+G
   NxExl8TLS4P8oICLyLpXWGG52UqpUZ9Ku9t4Y0jMLVKgLhivGEQzJN6a+
   G8TGfThNuyVEU/DxaBoT9cWO1EBokcvkpA+K9NF+vsqN01oZMSL5ZEYna
   llqGq+FSwySnL8hb5vs1hun96w8/5krZXGfQ5zR8HWFougNF1CIt+s+dD
   Q==;
X-CSE-ConnectionGUID: 3XmsDvi+TA2+4GY0lOtzMA==
X-CSE-MsgGUID: B1bO0BjERY69VSz7k+w9Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49267506"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="49267506"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 18:52:14 -0700
X-CSE-ConnectionGUID: D8TcJ1aTTpOUqRCynfU2BQ==
X-CSE-MsgGUID: NXc2atlpRziPl6PqdiAzfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="145833263"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 18:52:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 18:52:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 18:52:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 18:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCqJ7DImZmJuzeDIRT8u+kcWjDLN4ZBjbx3gwhsf5q/x4hJBKK3p3ChHQAdYBr/ZS6vWnLo5dL7+lnDQ2fGhQR8rPTzPiZqtEoafo7d0mltFFZ8uyS0SbrhZYsX2NEWj1aoELYUbyy4ohCVKoYaR3AYn35voQ+oXWwcd7HCf67seWSIsFjPuiNhlnhHCSutD8TvfxBmfYqLjB2YefvPloC0bhy+siHB+1lK0tZ29+Nds6d7/vxmhG8rmwiGrvFcjFgmcrXV+FrYqmhhOiw0JEM122bPTPC93X1tKZDyAuOorw4999Z4a/e9SflaHydwwfAI42xf0c9afDNdmHcvAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndvsd4ukvwC6PxiC/tTcXyXhwXtHCu/agd9X40Jybk4=;
 b=HBktdih65U3DZOHn1o+Jbz/kliYraX+XZ7JLH3+w63PaUtqPCzKwPO1JP8TsZQhb7kn+ze/ukTvll27A+ZLHYb7ZqOoVLX4i44K5E42Fsovpm7G9+v5zRk4/cw9yhyv7R962elgeUb9vn1MZqCcQuQ81haT354NI3O6154gxlCLAEBMCKIIokAMNTHA47n5m5cgPc7Y/wUiOck49Mr+rYgE2OeKSMaRxqJ2Ua0rvFq2QuPa+dWJSn9A/qM1EEhHy6jMhQghRTF8qa9YAy09H9xFdxxlse2TJ9NLWR724u7mG+rW5G2yEbxNdm0bDPxFZ5VCUPPmqjLRf+RkDFUnCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 01:51:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 01:51:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
Subject: RE: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Topic: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Index: AQHbwI8AVK9WzAglbEaPfz4i9w6907PT5XkAgAZgp4CAAAxyAIAA8XuAgARE5kA=
Date: Fri, 23 May 2025 01:51:25 +0000
Message-ID: <BN9PR11MB527614B4CE414911A181E25E8C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
 <0019943c-44c4-4dae-a175-8a5bdc02f017@amd.com>
 <aCt0/kOwCn8wZJG0@Asurada-Nvidia>
 <9cb7879c-5158-4fe0-bb80-91d5af6d3ad4@amd.com>
In-Reply-To: <9cb7879c-5158-4fe0-bb80-91d5af6d3ad4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4594:EE_
x-ms-office365-filtering-correlation-id: b356f80b-4af7-4ca8-0835-08dd999c538b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dlloUEIveCtubHJOaUdEaGpRMkljdVhKc3dSVVo5T3VSa2pteXBha00vZlZS?=
 =?utf-8?B?SktPaHlnMzhqdkxNL01QMGU5QkhqVG56RHJjUjRLdTlMU0NULzl4eTAvV3cv?=
 =?utf-8?B?RHhrZGNZd3ByYXF1bUhHZkxJcmRlVDlvV2J5dzEyTnZCb3RDczZ5RWNVSjBP?=
 =?utf-8?B?YXhTM3NuUWNYa1EwQ1FvNjJBN3R0aEU3dWpGd0RhcmVSU1NtUXdtOWdXblNz?=
 =?utf-8?B?MlVpMk5mbnFENzhBZTBjVzFtTnNmSmRzdVNXYjJQd2xyM25RVzlBNE1hcVFQ?=
 =?utf-8?B?ZDBzMityVHNkUHBVNldHVGorZzNLOHVKeVlHS25QN2VZMEhkQnRSdXY4SzI0?=
 =?utf-8?B?NUJ4cWlwM0J5S3VsMzk3NFNVTm1mVTl5ai85Y25yRmt2MlNObHAzSC91MmZ2?=
 =?utf-8?B?U3NVdnBXVk5hMUkwUXhGcTMxdGxHKyt6OTk0cXEyeEhjYUR2cGsxbjhqV3Vz?=
 =?utf-8?B?YmdsWHQ2amhUaVZUWm5TQzlnTm45ZWM2U2N0YTFMU1Y1VjNnaVVpMFFlWXBS?=
 =?utf-8?B?R0VGTXY4TktOQjZUYTZrWDF6aUdVdUdxWE11YXdySk94VnVtTWEzODZYTVY2?=
 =?utf-8?B?Y0JHS0lWUUhoanV3VDBPOCtBVzhJcitITndhRkR1Y09vdXlLQVBmamxTYXpl?=
 =?utf-8?B?aTcvS1E1SVBmQStXUXloUmMxczdJYXc5ZlZ3YnROak5kTzE5VkI5Z0lWN2xs?=
 =?utf-8?B?WVg0SE1GSVhLVTk4NnF5cW5EZkpUaXQvbGUxbU1NQitMQzZIRkdTSGVaaEsz?=
 =?utf-8?B?ZVVrVVZTZDh0aVBTY2l4RCtMZnA5Y2NkOEdwR3hUU24wT2JQcUtueFlhbmtD?=
 =?utf-8?B?bnRJQmJRa0Y5UkliTDhuaEhmL3BBM09yWGVMK2VKVU9hZk9mclZWU2VIRG5t?=
 =?utf-8?B?TXl1MlplTlJxVmVpYWhUVmhjdlQvRnNVWHpvOHpLVmUxZnVTNzhiVEY5cVM0?=
 =?utf-8?B?bFZ4RzV4UkptNXdBcG1uUUpZVFhyOWp6SkhIZmZaTmZvSmpVYkg1emxiQTlH?=
 =?utf-8?B?UStiRkpPT25GbEZSRVVJcldRK3hJdEFMOVVZNFJuS0U5ejh0eGFHczNqNm1h?=
 =?utf-8?B?Q0tnZDVxODJLbGxrQUJpT2t6R2xZbXVkYVJaQ0pCRkdMUVhqQmlPMzA4Y2ZP?=
 =?utf-8?B?NEhaaE5DczNLbHFieW9xdE5jUnlaeUJ4by90bEtDZWlibXA4Y2Jja3VFWW5x?=
 =?utf-8?B?QkJpQnpSS0JTaWZveFp0YTVQRUNNY2p5eFB4Q0wvM3cxaHMxREV6V2c4UmhT?=
 =?utf-8?B?SG9rS2hzdFFaMWYwdXB0MlJvaHJKK1M0d0dCc3gzN0J3eWhHMEpkRlJEdUhp?=
 =?utf-8?B?UGtJaVdhUWs2WFJLVmVrMW1YanozWk9JL3NGMWptZ1JTT1ZPL21yRWZYNDlE?=
 =?utf-8?B?T0JiUUNiU1UwelpyS1FDNFpEV1JTR3NxY3h0QjZmR3Myd0NwNm1iSVpaVGFB?=
 =?utf-8?B?L1J6L0FqbHMxcDlBRmFkVXNqTDZreDZZY0V3VzZjQ3ZmMk16SlVkMW4vMzh0?=
 =?utf-8?B?ZUhFNlNnYmZZRzF4allldFpGZ1hFMFkvOFN5TEZmWEJhWUM0eGlHb29Ld281?=
 =?utf-8?B?U2RYZERKYTVDbm1HN1Nrdm5aOU1GVzF3cGhDczhIaVl5Rm90cDhOWXhhdkdw?=
 =?utf-8?B?ZTlDQWxWcE5RREdraXlHMlZZclc2MEpDZkd5UUhwVFBMaTl3S2ExalBKTkJr?=
 =?utf-8?B?WW9NdnVWUkwzNjRRbE9Jb2QxcCtjWlFwVUpjMmNESWlUK3Y3Z0Q5cDFJc2sy?=
 =?utf-8?B?M2JRcnF3TnV2YTE0bDdUQ3BEUHcrT1V2SDEwRmV1dDUwSmNRbjZ5RUg3TUlD?=
 =?utf-8?B?Q0ttdVY4Y2h5cjdNTW9PZmV2bU9GTTBBTCtaNnZ5VHhYbnRySUVJR011RWJD?=
 =?utf-8?B?SWZ4V0xPYzlnZWwrS3lwVlIxbVhkdWNGcHJHTkpvSCt6ejdtNnBaZHZ6UFRn?=
 =?utf-8?B?Uld0K25ndHBkR2hyZGJDeFRHUCsvWENJdXdxZG1nU0VTdk5LRUFpbWR1ZERV?=
 =?utf-8?B?UnYvak5MWS9nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmxGTmJhaXBCNkZyZ1VETXhmaW9INnFmaWFCY25HYnVIVkhXeGxlR2I4WXVi?=
 =?utf-8?B?UFNjUTBDbmoyRHB5dUtQUGVUeVY2RmkvYzErMUJ4R0kxY0hFR01POXgxcXdh?=
 =?utf-8?B?SEo5MzVxM3R2MEN0akJzNXdpZkxrUHU2cCtMR0p1K0RqcFl2bjY3UWM0bmJL?=
 =?utf-8?B?VWdyVnBpbzRhVHgwVE1zemUrMTVzaTMvSE5Oak8vRWRkWWV4bjRraUZ1WStM?=
 =?utf-8?B?Uml1M3JQamRjc2xZdG0yM00rRW5kZk1WckFiMW85dUM4bFVjWjk3RlB6Y3Bn?=
 =?utf-8?B?N1lYY1ozZkxKSS9FQkhkd09QSHpveW9abUthYmN0VGFSbkF0WGliWWM3TTFu?=
 =?utf-8?B?VE9tbHRhTTFZUDE5VFZNV3BVTVNyWUdxWlJ0R3hNOHdoUGdvblQ2LzQ1Zi90?=
 =?utf-8?B?ZEVoTmZaOXJQeG9uRnU5cE5yS0lLTDlZakZkV0FRSXVxaWJNTEsydW9Udkxi?=
 =?utf-8?B?T0JFU21rNWpaQWpUOXdhV2VieG1UdldNRlNtV0MxKzdMcWZsSFhTYXNIenow?=
 =?utf-8?B?SWFjc0s2T244UXZraFhVbFEyL3pkZ01pU3pRQk9WMG1jeTlRaFFHZkRVYThs?=
 =?utf-8?B?dzZRSWM2aUZyVmgza1p0d2EvMi9LM2RNTFdtUEc2VFBxay9uSmI2SHlvdmwz?=
 =?utf-8?B?QmJrK0VFVXptM2JhOHhSZDV5Y3pIWFhZaExmcGJ1T3A4VVc3OGdKb0cwN0Q3?=
 =?utf-8?B?akRWbXZnUDB5U0xyMXVJc3ZVS3FKWTMrNEVIQ2t5QXVNWWdEeHNRaGwrY2d6?=
 =?utf-8?B?L091cEhGeFR5a3JXSldrRlhBaDVyanMzYVZKOGNXL3NmRis0VDVKNEIydVB1?=
 =?utf-8?B?QmhvSWhsS00yeTROclMyQisxeWdQeHpIUG80QTF6eEhTZHdUS1hmN0tnTEhG?=
 =?utf-8?B?aXNYOWRHRHhqTlRNY1psSUJIU1lXNnMrV2pzSEZaUWhQQURCVVNoaDRNeWpo?=
 =?utf-8?B?Smg0MTFrTUpmaG84aFNwN2VnbXkvL1J6cENVQzFuT2RQb0lMT2ZxUUZVRnlH?=
 =?utf-8?B?UkwzM1JVMG0wd1dINE5vSVl4VUNHdURya0RwYnpsWDZGK2p6SmY4SndnTk9s?=
 =?utf-8?B?SkpnQXBDTDFUUk1qT2QwUU84cFYzeEZISnNMWGtteDE1NmxGTzVlRGl4Q1lF?=
 =?utf-8?B?RytHSTFlRHJIV0lnczFCYkhBbXBuMDZ1V0JPdFl1RG1NQmhNeXBsbkVBakdz?=
 =?utf-8?B?NElmaDAvNmpYVVk4YjAxNVFCRzVzYjdMdE5HSElaLzhsTXFxOVZ6NE5NY3Nx?=
 =?utf-8?B?UFF0MjhVa3JOeldhWFFTVXlzbTNIRXhiVTIvU3czYVhyWXMyL3VqWm9Rd3dF?=
 =?utf-8?B?VWtrcEhJdU1ya08wTnlXYzFxN21rSml2TTRGRGdiWTBkYTQ4VU96SDU5ZTFH?=
 =?utf-8?B?bGpXK0hWRVRoOFFRL2lVeURRVnh2VWFsclJJSkZ6eGEvaUExdHpHUERPazBJ?=
 =?utf-8?B?anlmbFZEamFTcVR3dTJIcmY3NUVEQTMxTmZjaUo3Ry9HNTdKRDdBY3g5bmVz?=
 =?utf-8?B?S2lJcEU5N1o2SU91c2tHREJuMFRhODFiaTIwN0hWU21pak5aWHEvaWluWmN6?=
 =?utf-8?B?V0s3Wkp6UStaVDB0NlZlcTVCRG8yTSs2M2RVWDNXL1QzUG1nTVE0U2pPclFk?=
 =?utf-8?B?cDFPWG1KNktYbGJWb3h3b1JPZGZQTWg3bjFueElHTXFOb21ZVmlZK0N0NmdN?=
 =?utf-8?B?ZEVxV2NYV0hBcSt3WXJVZndNYTdkVnhPL2VzUlBrbjBZY3dXYmNUVHpCbU5S?=
 =?utf-8?B?WEg3OFNTR0M0S1lRTHN4QVNQS1FoU2VMWUcxTXRRYyt6SjlMNis4NytSdjMw?=
 =?utf-8?B?RWtPYnlPWHpMckt4YUJWa3dNWWdzRGp2RVZTb2w5M25TbEgwSEFVS3dBYXY2?=
 =?utf-8?B?VnVBSDhRMFBYa21rc0xpenVjMVdCNzhLb0pLdVJCK1dpTVZMSE9UTzRNazNG?=
 =?utf-8?B?clBWMjJoOUFpQXBjVUlFajB3NCt2KzlycUZON1RBTzRYd1Y4TkpDbEtreU9E?=
 =?utf-8?B?S3dZcTBlSkRuWjFKTUpuVDhDVm9NenovQUZCTW5meWZFWnZsMzIvLzVRdjRl?=
 =?utf-8?B?c1QyblJlWXpnaVZ1M2trNkFpTXRESi84b1lpK29xS2hVRVNLbVZLZ2NXOCto?=
 =?utf-8?Q?3fHh5+QpyH717p0XkGrEvAdP0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b356f80b-4af7-4ca8-0835-08dd999c538b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 01:51:25.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzw0aZ9z88bxdENL6074VibQu5znrdViR0fevAQQ+77848ly4KqVH460aPxebgPA+i0orXS+F733V3CWiPdh6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBNYXkgMjAsIDIwMjUgNDozOSBQTQ0KPiANCj4gSGkgTmljb2xpbiwNCj4gDQo+IA0KPiBP
biA1LzE5LzIwMjUgMTE6NDQgUE0sIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPiBPbiBNb24sIE1h
eSAxOSwgMjAyNSBhdCAxMDo1OTo0OVBNICswNTMwLCBWYXNhbnQgSGVnZGUgd3JvdGU6DQo+ID4+
IEphc29uLCBOaWNvbGluLCBLZXZpbiwNCj4gPj4NCj4gPj4NCj4gPj4gT24gNS8xNS8yMDI1IDk6
MzYgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+IE9uIFRodSwgTWF5IDA4LCAyMDI1
IGF0IDA4OjAyOjMyUE0gLTA3MDAsIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPj4+PiArLyoqDQo+
ID4+Pj4gKyAqIHN0cnVjdCBpb21tdV9od19xdWV1ZV9hbGxvYyAtIGlvY3RsKElPTU1VX0hXX1FV
RVVFX0FMTE9DKQ0KPiA+Pj4+ICsgKiBAc2l6ZTogc2l6ZW9mKHN0cnVjdCBpb21tdV9od19xdWV1
ZV9hbGxvYykNCj4gPj4+PiArICogQGZsYWdzOiBNdXN0IGJlIDANCj4gPj4+PiArICogQHZpb21t
dV9pZDogVmlydHVhbCBJT01NVSBJRCB0byBhc3NvY2lhdGUgdGhlIEhXIHF1ZXVlIHdpdGgNCj4g
Pj4+PiArICogQHR5cGU6IE9uZSBvZiBlbnVtIGlvbW11X2h3X3F1ZXVlX3R5cGUNCj4gPj4+PiAr
ICogQGluZGV4OiBUaGUgbG9naWNhbCBpbmRleCB0byB0aGUgSFcgcXVldWUgcGVyIHZpcnR1YWwg
SU9NTVUgZm9yIGENCj4gbXVsdGktcXVldWUNCj4gPj4+PiArICogICAgICAgICBtb2RlbA0KPiA+
Pj4+ICsgKiBAb3V0X2h3X3F1ZXVlX2lkOiBUaGUgSUQgb2YgdGhlIG5ldyBIVyBxdWV1ZQ0KPiA+
Pj4+ICsgKiBAYmFzZV9hZGRyOiBCYXNlIGFkZHJlc3Mgb2YgdGhlIHF1ZXVlIG1lbW9yeSBpbiBn
dWVzdCBwaHlzaWNhbA0KPiBhZGRyZXNzIHNwYWNlDQo+ID4+Pj4gKyAqIEBsZW5ndGg6IExlbmd0
aCBvZiB0aGUgcXVldWUgbWVtb3J5IGluIHRoZSBndWVzdCBwaHlzaWNhbCBhZGRyZXNzDQo+IHNw
YWNlDQo+ID4+Pj4gKyAqDQo+ID4+Pj4gKyAqIEFsbG9jYXRlIGEgSFcgcXVldWUgb2JqZWN0IGZv
ciBhIHZJT01NVS1zcGVjaWZpYyBIVy1hY2NlbGVyYXRlZA0KPiBxdWV1ZSwgd2hpY2gNCj4gPj4+
PiArICogYWxsb3dzIEhXIHRvIGFjY2VzcyBhIGd1ZXN0IHF1ZXVlIG1lbW9yeSBkZXNjcmliZWQg
YnkNCj4gQGJhc2VfYWRkciBhbmQgQGxlbmd0aC4NCj4gPj4+PiArICogVXBvbiBzdWNjZXNzLCB0
aGUgdW5kZXJseWluZyBwaHlzaWNhbCBwYWdlcyBvZiB0aGUgZ3Vlc3QgcXVldWUNCj4gbWVtb3J5
IHdpbGwgYmUNCj4gPj4+PiArICogcGlubmVkIHRvIHByZXZlbnQgVk1NIGZyb20gdW5tYXBwaW5n
IHRoZW0gaW4gdGhlIElPQVMgdW50aWwgdGhlDQo+IEhXIHF1ZXVlIGdldHMNCj4gPj4+PiArICog
ZGVzdHJveWVkLg0KPiA+Pj4NCj4gPj4+IERvIHdlIGhhdmUgd2F5IHRvIG1ha2UgdGhlIHBpbm5p
bmcgb3B0aW9uYWw/DQo+ID4+Pg0KPiA+Pj4gQXMgSSB1bmRlcnN0YW5kIEFNRCdzIHN5c3RlbSB0
aGUgaW9tbXUgSFcgaXRzZWxmIHRyYW5zbGF0ZXMgdGhlDQo+ID4+PiBiYXNlX2FkZHIgdGhyb3Vn
aCB0aGUgUzIgcGFnZSB0YWJsZSBhdXRvbWF0aWNhbGx5LCBzbyBpdCBkb2Vzbid0IG5lZWQNCj4g
Pj4+IHBpbm5lZCBtZW1vcnkgYW5kIHBoeXNpY2FsIGFkZHJlc3NlcyBidXQganVzdCB0aGUgSU9W
QS4NCj4gPj4NCj4gPj4gQ29ycmVjdC4gSFcgd2lsbCB0cmFuc2xhdGUgR1BBIC0+IFNQQSBhdXRv
bWF0aWNhbGx5IHVzaW5nIGJlbG93DQo+IGluZm9ybWF0aW9uLg0KPiA+Pg0KPiA+PiBBTUQgSU9N
TVUgbmVlZCBzcGVjaWFsIGRldmljZSBJRCB0byBzZXR1cCB3aXRoICBHUEEgLT4gU1BBIG1hcHBp
bmcNCj4gcGVyIFZNLg0KPiA+PiBhbmQgaXRzIHByb2dyYW1tZWQgaW4gVkYgQ29udHJvbCBCQVIg
KFZGQ250bE1NSU8gT2Zmc2V0DQo+IHsxNuKAmWJbR3Vlc3RJRF0sDQo+ID4+IDbigJliMDFfMDAw
MH0gR3Vlc3QgTWlzY2VsbGFuZW91cyBDb250cm9sIFJlZ2lzdGVyKS4gSU9NTVUgSFcgd2lsbCB1
c2UNCj4gdGhpcw0KPiA+PiBhZGRyZXNzIGZvciBHUEEgdG8gU1BBIHRyYW5zbGF0aW9uIGZvciBi
dWZmZXJzIGxpa2UgY29tbWFuZCBidWZmZXIuDQo+ID4+DQo+ID4+IFNvIEhXIHdpbGwgdXNlIEJh
c2UgYWRkcmVzcyAoR1BBKSwgaGVhZC90YWlsIHBvaW50ZXIgdG8gZ2V0IHRoZSBvZmZzZXQNCj4g
ZnJvbQ0KPiA+PiBCYXNlLiBUaGVuIGl0IHdpbGwgdXNlIEdQQSAtPiBTUEEgdHJhbnNsYXRpb24u
DQo+ID4+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4gUGVyaGFwcyBmb3IgdGhpcyByZWFzb24gdGhlIHBp
bm5pbmcgc2hvdWxkIGJlIGRvbmUgd2l0aCBhIGZ1bmN0aW9uDQo+ID4+PiBjYWxsIGZyb20gdGhl
IGRyaXZlcj8NCj4gPj4NCj4gPj4gV2Ugc3RpbGwgbmVlZCB0byBtYWtlIHN1cmUgbWVtb3J5IGFs
bG9jYXRlZCBmb3IgcGFnZSBpcyBwcmVzZW50IGluDQo+IG1lbW9yeSBzbw0KPiA+PiB0aGF0IElP
TU1VIEhXIGNhbiBhY2Nlc3MgaXQuDQo+ID4+DQo+ID4+IFBpbm5pbmcgYXQgdGhlIHRpbWUgb2Yg
Z3Vlc3QgYm9vdCBpcyBlbm91Z2ggaGVyZSAtT1ItIGRvIHdlIG5lZWQgdG8NCj4gaW5jcmVhc2UN
Cj4gPj4gcmVmZXJlbmNlIGluIHF1ZXVlX2FsbG9jKCkgcGF0aCA/DQo+ID4NCj4gPiBGb3IgTlZJ
RElBJ3MgdkNNRFEgdGhhdCByZWFkcyBob3N0IFBBIGRpcmVjdGx5LCBwYWdlcyBzaG91bGQgYmUN
Cj4gPiBwaW5uZWQgb25jZSB3aGVuIHN0YWdlIDIgbWFwcGluZ3MgYXJlIGNyZWF0ZWQgZm9yIHRo
ZSBndWVzdCBSQU0sDQo+ID4gYW5kIGlvbW11X2h3X3F1ZXVlX2FsbG9jKCkgc2hvdWxkIHBpbiB0
aGUgcGFnZXMgYWdhaW4gdG8gcHJldmVudA0KPiA+IHRoZSBnUEEgZnJvbSBiZWluZyB1bm1hcHBl
ZCBpbiB0aGUgc3RhZ2UgMiBwYWdlIHRhYmxlLiBPdGhlcndpc2UNCj4gPiBpdCB3aWxsIGJlIGEg
c2VjdXJpdHkgaG9sZSwgYXMgSFcgY29udGludWVzIHRvIHJlYWQgdGhlIHVubWFwcGVkDQo+ID4g
bWVtb3J5IHRocm91Z2ggcGh5c2ljYWwgYWRkcmVzcyBzcGFjZS4NCj4gPg0KPiA+IEkgdW5kZXJz
dGFuZCB0aGF0IEFNRCBDb21tYW5kIEJ1ZmZlciBhbHNvIG5lZWRzIHRoZSBTMiBtYXBwaW5ncw0K
PiA+IHRvIGJlIHByZXNlbnQgaW4gb3JkZXIgdG8gd29yayBjb3JyZWN0bHkuIEJ1dCB3aGF0IGhh
cHBlbnMgaWYgYQ0KPiA+IHF1ZXVlIG1lbW9yeSB0aGF0IGlzbid0IHBpbm5lZCAob3IgZXZlbiBn
ZXRzIHVubWFwcGVkKT8gV2lsbCBpdA0KPiA+IHJhaXNlIGEgdHJhbnNsYXRpb24gZmF1bHQgdi5z
LiBIVyByZWFkaW5nIHRoZSB1bm1hcHBlZCBtZW1vcnk/DQo+IA0KPiBJZiBwYWdlIGlzIHVubWFw
cGVkIHRoZW4gc3RhZ2UgMiAoSG9zdCBwYWdlIHRhYmxlKSBnZXRzIHVwZGF0ZWQuIElPTU1VDQo+
IHdpbGwgbm90DQo+IGJlIGFibGUgdG8gZmluZCBwYWdlIGFuZCBsb2dzIGZhdWx0Lg0KPiANCg0K
QXMgbG9uZyBhcyB0aGUgZmF1bHQgaXMgY29udGFpbmVkIG9ubHkgZm9yIHRoZSByZWxldmFudCBx
dWV1ZSwgeWVzDQp3ZSBkb24ndCBuZWVkIGFub3RoZXIgcGlubmluZyBmcm9tIHRoZSBkcml2ZXIu
DQo=

