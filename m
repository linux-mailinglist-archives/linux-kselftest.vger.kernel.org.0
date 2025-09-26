Return-Path: <linux-kselftest+bounces-42442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B76BA2B0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9FE383F5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07C284B37;
	Fri, 26 Sep 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huFYTzrS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76310E0;
	Fri, 26 Sep 2025 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871421; cv=fail; b=hO+JdCI3rZu4ak5ypuUdZqSg31kK+IwqtIM8Si7pWN5Ok3cSgnmFAsM4pJvk86wK2q0vNnMWQtCNHpcGeD7sXbi+orAmzvtXmjjmrMwCm+9olhScQAfvx4VH5/FF7hyBqpy+lgQrNpX2ahEAtKb/QoZpVmXgnaFtXOXa9pmNY4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871421; c=relaxed/simple;
	bh=VsI1Zc6zkSouYmrpYNwJnBXDpTwHWtGy72GKmCQQdZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UOWQypl0xEdI9Fqw8UubQL55dB9uL6VHoNGZcZE3g0/Muc5+tWQNGeXphWF+qmJ6PKpAbaocgr8M8rnxbLW0dqWLJ6V/K+ao2qVdPniHhHbxv2PjWl5zGy9DaWRwN4WhK+Ie9HWri8HQGcLde1WL8fMXe1vAWgRJrw5BGLINrQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huFYTzrS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758871421; x=1790407421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VsI1Zc6zkSouYmrpYNwJnBXDpTwHWtGy72GKmCQQdZE=;
  b=huFYTzrSh4SPyzoimtfYTxobyurrOMviyfyvu3dMXyMcNC+D7UAmFPkF
   HeprqvZ6Jd0ufnDRicZ4yBNEGZhcmyxfxZyd1t/wJBeV0hmjaS66tWWEe
   ixS5T08afRcIYE11cyyJY09NWDTc9k9ePRBawR3sz1oKzQk3PF4pNR2tG
   aaaQpsTIdBKiJEUiCkNac5iyfJKsYkkFwa72ogx3HVEjQpg36YSlwnMD+
   0aB2Zql/JezRgxPgMnZBtWcAFHXugF/uBSSn2sP6hjR+47LJeRwe6BSea
   KvfA+sa1jnYx3Agxi44fc/Oe9tTnTlara8przESVBhYdeCfr6arLOqQ2T
   Q==;
X-CSE-ConnectionGUID: AEJA8VLkRTCZK9APId0bXQ==
X-CSE-MsgGUID: +01GJYckQHCOuOC5y4HQ0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="64833151"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="64833151"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:23:40 -0700
X-CSE-ConnectionGUID: 760GlPU7TrizNLZOhro74g==
X-CSE-MsgGUID: 76HPZhJtSzSg1ErnZUMziA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="181844282"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:23:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:23:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 00:23:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgwQjjhLq9B4JvieAcSzFB/KMizyAlE4WYAzf4YlVUvBE9K+6owj7OTk2ivz8OFsMWPyX9uNpaVNeGVAeepYiwtoGeWmZzybF79q5qYz8NlC9athv7j9Jidk+qVgY3qcO/AL0wiDjkKmM0VmSEd+uJ5tWFXZORdg17Vffv5t9ARJfG669iEfJLhWqu7z4t9xqPlDHcRw6WMP1hDIJEcOtP4pv7912Gut7Zfddk2p79G7s18cXmc8JVdeHj8sHYyD24iLApaLSetHZjRwbQme1tfUVmJ1zbJ+dqOQ0FXh5/wAyKq0sxT3rwfuHpfy8j5XLTQdfs3tqLA7ZokI62Xb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsI1Zc6zkSouYmrpYNwJnBXDpTwHWtGy72GKmCQQdZE=;
 b=f+xP/WkYOi6pIm5Iap028vDSJ933KX/Bu0Iq7UejoEqWUcukzQNH+7uK9bP7FhWQ/UMbY8crmrK2jRCHwuMIJ+W+RTVjag4rHAQ3H1syQG1Q5qBGIDlCQQptwm2Zag8pFlpFRJo4yNaXImNN86P2GQgRTJnFYHtmAIc0JFMbsPd6CCBX7MhT2P1gr3Pg5YvPTLrWGU7lfGZodkkadpW8lfzKPXvnUp1IOVHA6CEeeOmDAk4SdWVnyn0pXn4RoBsq3dPZkRn5rGVartTRyKg/7t6AW9iLyCDPiRdLZg57LvjeZablK5LjwT81vHh6SxgSvjgMCwy4dKkjTYqQzglA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:23:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.013; Fri, 26 Sep 2025
 07:23:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 06/15] iommupt: Add unmap_pages op
Thread-Topic: [PATCH v5 06/15] iommupt: Add unmap_pages op
Thread-Index: AQHcHPrE6YwNV5JzRkqrJQzB9dWsZrSiMBrAgAAyDACAAtB30A==
Date: Fri, 26 Sep 2025 07:23:29 +0000
Message-ID: <BN9PR11MB52766001B89AA2857FC5A4638C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <6-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276277E4171547C0B5F247D8C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250924122338.GJ2132010@nvidia.com>
In-Reply-To: <20250924122338.GJ2132010@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5172:EE_
x-ms-office365-filtering-correlation-id: 0c9d0d50-1e28-4dca-862a-08ddfccd9768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TEJ2Q2NtTzNEcmRqVmlrQXVyLzFOdDNIU2FDTGFSdTQyS0xXcFBoamx4UzFO?=
 =?utf-8?B?MkVGUnRwUEhSUHZJWkJXbnNMM0EyT1F3eVRFU3QxcVY5YWRmUFdMRlpxOC9n?=
 =?utf-8?B?Y0VlODlKSHJadDRoNU1BWjlRYU1SZ0h4T2dKRU1qcy9XaEtWL1VoaUs1ck01?=
 =?utf-8?B?YVhrRndOcGZHZTBVR25ocE40MmgzbDhpWDVXVUx1SjZiTFZTWXJwMFNPS3JV?=
 =?utf-8?B?NzM4R1FIMlhTZjg1NEVGZm9QMWZtbHFOY3NONS9VMWZENGNKSWxJL0RFb1NQ?=
 =?utf-8?B?VWpzMkdPbXZ5N1N4dnR6YzlnZU9jU0NETnhRUGpZL2F1YmdEYS96UkF6T0ZV?=
 =?utf-8?B?STBMUW40WVVQRGhlMFg5N3NOL3JucDFJV3V4V0VjczNpQzF1aWc0WklNVEZj?=
 =?utf-8?B?N29ITnRIOHAyTGhFTjFjSC9kd0tkWnRXcndDSFNwTVRGTGNuakxlY3BKMk9Q?=
 =?utf-8?B?eG5UU3g0dnRHUDJHN2R3VEl5VUMyOUZ6aytFRXlmbTlMc0FhMlY3VWdaMzEz?=
 =?utf-8?B?blV3T3RlVkdObksvQTZ1RUlIN05TQVd2T3JVUWNVMDcrNmNJZnhZWjFxK3BB?=
 =?utf-8?B?V0V4YWVIR3pMY1JFdUs5dXl3L1Nkak5lNVNQUVRDZGFsdDRvallhamRBdVNh?=
 =?utf-8?B?WTJxUThPN2hyblpoeXViZC9XVEd1Rkp3MVpZVEpxNUxKMHpjdEhVVmxMNjlp?=
 =?utf-8?B?cHFmTGQ1SnA1RzMxL3FNc2F5azdaL0U5K051elJ0VWxORUVWOFpUTHVhc1Ux?=
 =?utf-8?B?NmJhZjltR2M4L2dqSjVuczlkYWtUT3dWZ2c5WkNYMVpOQm16b3c0TlFRVktZ?=
 =?utf-8?B?NDVLVTAwd01aSDBKWi9PNGdrUTNSMkhoZlFPYzU2VUF4V1J3bllKK1BkVktn?=
 =?utf-8?B?UzdYeUNLS3cxcHFhS1p2Y2pEWnkxOGFIWFV3NVU4NGZKekZ3YzdQRUdtMW1u?=
 =?utf-8?B?TU0wQ0tyWTZIcEtPRkxlTlpQMDFUSXRHSVdNdE96SGtkZTk4RE52ekxQMFc3?=
 =?utf-8?B?N3kvdkZqd3UvNjREblJ1MktFN2FkR0dMUUszWFVDMU1LWEpPdjg1bFNZSThl?=
 =?utf-8?B?SEV3eDh3dlU5SWNhaXJXUk9kVWc1SS9rL09mTm9kYkYwWVBTV044RVRLOFBJ?=
 =?utf-8?B?ajE0QzZ4Vk5uZmhVTVprMmtoZEoxOWtMSERQS0VxMlR0Yi9HR1hwT0I0ZFVi?=
 =?utf-8?B?cjJXTmIwb05qZnZySDJYQmI2V2JsS2lnV0RUNGFVREdGaGM1WVpvUUc5OHVF?=
 =?utf-8?B?NTMzU0s5dGYyVFdnZEdrMUhHa1poamVrZGNSWXlFVktMOEtLTDkrY2tqTi9F?=
 =?utf-8?B?ZThIZFhZUUttbVM4ZEp5OTIxYmdVbGZLaEZTMXR4Z3JRWXpyRjlqM2N2ZG5S?=
 =?utf-8?B?RWd6dWxROTNxT2ZkNndjUjJtL1lQYjVvRkFydW0rdWQyeitPV0YzS3JZRkYw?=
 =?utf-8?B?QkhXVWJrSFBESEdFaU5wRXErVm5mTktySEs2WERpQmV2Q3JDSDlqWFp3WXhz?=
 =?utf-8?B?SWU4aDhUVys2c1AxM2ltNzZOcWpXVXFsd0FFcWJUSUNLVXM5VXlJSDFBbUlB?=
 =?utf-8?B?eEJDSEhDRFN2T3RxeHNPZFdLQU5OT2srQ1plVy9iRnpSMmtZUTZvTm5Jallr?=
 =?utf-8?B?c3d4NjZaVFgrWTZlSXFPZzZPQkxkQTc2bnY5OVBpN1lNbTMzRkdTYThuRE1r?=
 =?utf-8?B?ZlEvRFROTGdTM2Z3azlIR0M2T21rdXJhaHdQdW9kNFdFNDBnVkpUeFg4YnNk?=
 =?utf-8?B?QUhZSmcwcFZoVXJZR2JXeHF6d3laWE5kOFZDVDNPQnZVLy95Mlh3Qnpkck94?=
 =?utf-8?B?K0RjdVBaZnllYnNFRTROVWt5UDlRY09vNlZUbEcxTnhuTHV3aGowZzUyRzdu?=
 =?utf-8?B?RDJub1lVTU9nNlNXWFo3THFzVE1kTW1ORUdQMThoTU8yQzBHZGxXZSt1ci9C?=
 =?utf-8?B?QzhiR0xibFR2eGhrV1ZoOElqL2VqUFp4T3hkL0kzajF0UHdybTBDcWlTK0N2?=
 =?utf-8?B?aTJJcVNCMVlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEdFRHhUZHFYcmU4Ym9WUEtmaGNQb3k4OVRmMjEvZFVNdGMwei9ObXQ5ekZQ?=
 =?utf-8?B?R1o4TXRBdUM1YnpxY0hVby8yNmFKZ0ZVdHhiZVR6RkZVUTBZM2dzVTZKRDlW?=
 =?utf-8?B?N2o3c1RvekIvUkQ0SmtULytJV3hDUmhTeXcvMndpN0xjVHhTZXQ5YkZTZGF2?=
 =?utf-8?B?aXdrcTlVM0V0YkNiTHAzVjZpQWdXTWJEeWw5VXdOY3N2Y0ZRTVBHakF6a04x?=
 =?utf-8?B?QXllQngzTU1oQ2NSa2p3OXVxSW9wVk9FUExCeWJoYnQ2OTJjaytZV1gwQzNE?=
 =?utf-8?B?b1l5d2UzTFZUaGtRa0F3cTNCT2pFanJtMG1SS0ZxY0VpV1o0elFaTVU1UExG?=
 =?utf-8?B?SnNsT2NZUkY5eU94dnNKaUkzMnExeVN6MSsvWURuTzVXaDFXN0ZKTG5LY3o3?=
 =?utf-8?B?bFNZSzVzdks2dFN2QVMzSFV4eGJiTUx4aG85bUo0VzBBNU9QOXRFeVhpYmFF?=
 =?utf-8?B?ZXF5SjRFbGU4SWhGV3cvVlBrUHppNXZlNTRjQUk5ZDE0TmwxVzNJN2h6S0ts?=
 =?utf-8?B?UnZDMWNsNWluY3NEOHZ0RW1vOS9Ld3N6YnhmdngrTEtNR3I4OTNlSEovNnQz?=
 =?utf-8?B?QVl5MnhWMnNQRDFvSFdRVE1zWSt0OVUvNG0ySXBnd1U1NVlaUEswZUd5ZEpO?=
 =?utf-8?B?Q0ZUZmN0QUxLTXVtRkJYblRUZU9NdnFldWloNkFkL2hPRmxMM1dNaWdVNlhU?=
 =?utf-8?B?OStZa3ppVHNnU1djQmR2Z0RiQkJFOFYxcmV1Ti96QjNPTGF5QWFRclBjOW5v?=
 =?utf-8?B?amRtNitDN01DOHE0N1hvdnkyekxNemkxTDRqWlZoa3g3c2VkazB2UE1KOU5J?=
 =?utf-8?B?bE01TE9iV3MzWE0ydmpBdmRBamZNTGtpM2NiRW1kK3NubEdqTVA1U2c1REZQ?=
 =?utf-8?B?N0pST2N5cDZEc1dtRjFlUW9CNEJHSjYwR3FTSVNmU2xUQkZ6a0VwYmN3OVhH?=
 =?utf-8?B?OFJlVFZOaFRvdStrdVhXc3RXYTJKbTRXQUFJY013bWhETHZOdEowU1FYYm9H?=
 =?utf-8?B?SWp2bm9pREJUYVE4aVkvN0JkNms1L2diQ01ud0dZRUw0QS9sRHBia2hQMUlL?=
 =?utf-8?B?RktDVURGZGF3Mm4rblU3elB6NmY2OXFpZUdmTUxReU1rN3lzMUcwRlVENzE5?=
 =?utf-8?B?M1A2Q0xUQmlBQnRMdktQcHlpK1dvZ0pvQ2NHQzF6OW5LUW81c2JHQmx3Qk4y?=
 =?utf-8?B?UWMzd0FkcjhHOFVkSHlGNDVvaDhYMjFQU1djMTkwcUlabEVHRmVhbzFEL28x?=
 =?utf-8?B?empGSEpDSGxHSVQyWi9TREJmUk5nMlZvTWovRUtIaTFjVTFSdTRJWW9rdXZI?=
 =?utf-8?B?bzNDQmdzaHBScHpMWVovbDJQY3pVS3lSOGt6eXEyaDkyZWZLTlFKK0FwQzYw?=
 =?utf-8?B?ZkxYQU1lckI0NUlSako4VlhUSEVCd0pFTFZ4ZGs4WFJLVE12TDNScGpJbWZs?=
 =?utf-8?B?aWtrSUowV3VFZ2RnNFpXNjNUMGZzSm1XNFRIMG0vMVl0MGYzNWFJb0k2NWEz?=
 =?utf-8?B?REZweDVKcXVTRWxNSXp2aWtMMW1YbXI4bDZRMmpCNTNzZUtJUTYvMG95djY4?=
 =?utf-8?B?NFlPZThJcGQ5UkFrK01pakVtakZ1YjBvQVk2TWV5TmNnbGRFc2w5Z1JmRzRa?=
 =?utf-8?B?dEYwK2lSRUNQSEd0aE1mbElRZEx6anJ5U0JqQnhqbklUaDVQV29GN2plYWU3?=
 =?utf-8?B?UWNENEkzK1oxRjNhVkR2a2k1cVV3TG02SXo0aG5VcDNkdGdkNFl1MkNFTXpU?=
 =?utf-8?B?NEF0VC9OeEk1L3dvTzQ2eWhyNHY4Q3MyWFhtNXU1T3hROERUM2xCcnhyM2Np?=
 =?utf-8?B?Q3hOV3dhazBGUEpna2JPanBGazNGVnBnNy96TkxlaEZQYTFHenNTUEo3N1dJ?=
 =?utf-8?B?cDE3S3VBUE95Z0Y5MFJieExMVFVqREdvd21ZUnRXTHZqbzBGM2xKeEhVVURV?=
 =?utf-8?B?K2kxT2JBRGphUWdDelUzbXpsSFRqNUJVUXlleUQ3dnFaMGpDWFhPck1nQXJk?=
 =?utf-8?B?Q2FReEdhUGZBTnlhS2VIQ0lrL0Nyc09NNENhV0dUaDlyNlpxS2luN3pURVZn?=
 =?utf-8?B?Q1hPYkdWT2NDY2p6SDd5Z3gvMXFLVEZqYTdGWEpxRTVOYVA4WnJHaks1Ykk3?=
 =?utf-8?Q?cR3YGzhr5AfTHf8gF2Ar5Gkqh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9d0d50-1e28-4dca-862a-08ddfccd9768
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 07:23:29.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhtZtcO++vi0v6HgxTmeDMYEXX8ToDW99JO/ZczbBFw8wHsS9yIXFV8vHvDcUjlYVRDSdOF0SzxtX43M/loYQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIFNlcHRlbWJlciAyNCwgMjAyNSA4OjI0IFBNDQo+IA0KPiBPbiBXZWQsIFNlcCAyNCwgMjAy
NSBhdCAwOToyODoxMkFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+ICsJaWYgKHB0
cy50eXBlID09IFBUX0VOVFJZX09BKSB7DQo+ID4gPiArCQlpZiAobG9nMl9tb2QocmFuZ2UtPnZh
LCBwdF9lbnRyeV9vYV9sZzJzeigmcHRzKSkpDQo+ID4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gPiArCQlnb3RvIHN0YXJ0X29hOw0KPiA+ID4gKwl9DQo+ID4NCj4gPiBpdCdzIG5vdCB0eXBp
Y2FsIGdvdG8gYSBsb2NhdGlvbiBpbnNpZGUgYSBsb29wLg0KPiA+DQo+ID4gQWN0dWFsbHkgZXZl
biB3L28gdGhhdCBnb3RvLCB0aGUgZmxvdyB3aWxsIGNvbnRpbnVlIHRvLi4uDQo+IA0KPiBZZXMs
IGJ1dCB0aGlzIGlzIGEgbWljcm8gb3B0aW1pemF0aW9uLCBjYW4gYWN0dWFsbHkgbWVhc3VyZSBp
dCBpbiB0aGUNCj4gYmVuY2htYXJrcyA6XA0KPiANCg0KYSBjb21tZW50IGlzIHByZWZlcnJlZCBp
biB0aGlzIGNhc2UuIPCfmIoNCg==

