Return-Path: <linux-kselftest+bounces-32559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94754AAD9A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 10:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE3D5042C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2462253AB;
	Wed,  7 May 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBWlcbIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D7224B00;
	Wed,  7 May 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604823; cv=fail; b=vBlQuKcjP5POt1Y0gPygDfdQt9sUd3Vui5Xb0JFyz0deHFSNPX5/13CoalR3qXo4bZq7UCQWIw7M+TeYXKsErXN5h/fWjk97wX16u+UnGFFRXUYgdBu+fJNqA+kVXq6jSgPKImHOcGW56ynx/GDjcs0MpahY3rS9gS/tnFmwnYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604823; c=relaxed/simple;
	bh=QB75ylNm7O/9JfKpX+4mrO20P7bZiacwwsj0falDcUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WU71CyaUZjFemeTsiWGZEwuD+fBq4H1o9Q6/nL3ZB2aamRLBWhMvOmCGcBJ023ISTG6rMWOLVC45FInQBU7nziT9S0xftM9ZellXFqagbdb/BSLvdXWkyeHsX7/mH78N3vzfEhE9PUF5f02ucKCDGLFOPfz2HDMHLIfIDBRpF3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBWlcbIU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746604822; x=1778140822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QB75ylNm7O/9JfKpX+4mrO20P7bZiacwwsj0falDcUM=;
  b=IBWlcbIUcDkjif5iB5oPk9BTTO8HBxpE/IFKevvlw+YImUoY7iTUIzgD
   6CXXRDasfzQ/43QufjnCsUllreUbJAZCeZtTeCVWqli3M+TqUUtAM2lDW
   zUmgOjL8D4HBwXFvojELUUEPhOEnGxcWHRrH5mEsNEExIRNLtTHEu4Xzm
   9ff+4sFynJgxVvv1DxrVAeYsGzxvOi05QU88mwqz5KlPUKuK+y/hF5QYm
   WDfBYnBvdN20JTE1n78NikwBPfxh9eNhJmlFzl+IRfGFVq+r2CSAkEAXQ
   pKJ7zrPiFp1ZRvcZoqQvrqZqU/8UEEU49aBx6F5ry9XKkNTjsNhzTIEkp
   g==;
X-CSE-ConnectionGUID: hWv/TEhCS2C9tbzcheYa0Q==
X-CSE-MsgGUID: qB3RLQGWTkqC89kaqpfpHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59715550"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="59715550"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 01:00:13 -0700
X-CSE-ConnectionGUID: 0KvI3eldSqqgRN6kIrwtPQ==
X-CSE-MsgGUID: 7AkbccmiQKizEYYLYrMkCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="135744515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 01:00:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 01:00:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 01:00:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 01:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EElrtWKIEv7TjWUgTjHBnLJZ58Jbn9S/Lf1hhkIcokVfTpnDNWKzXL7Wrocn7LsC4zaWiUvENK/r76HScXjbdGUucFDpdK8iOhmc6dWRXRJkJ1ul3btpY+dz2JRdt/QKTy37WDnYSmFB3ihO+u5lEQxw1IlU4euJV7GIo//E/9mgpWP1ARStKXqjtV+2QJ/m+eaJ9moEj28pZqm0CzT5+JNm6btRMe9Pp3CXDuJU/XQU7Ukh2/y2pY7qmLjXO9WQHLVMsFyh6hGYx0UuWG/3nl2dTLULhQVajKJRUcd8YARGH9pd+2cFFGSfqzPo+ZexRDRwOjojSgbbvXgwdI1PhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB75ylNm7O/9JfKpX+4mrO20P7bZiacwwsj0falDcUM=;
 b=yIK+C29R+JGDHBYdcs72vT3KVchCENK+9ovzYaRt/V3PX+2JLXDtNrhAwMRQGi/sB/dkcDWXTyJEAyVysi8GzgI7p1cHSx2Rfq+JYOZo5ksqNOPJjgVCp1dyJvs/wsA4cmjAPs/NcoQiZK27y2TMDQF5ePNpWK9TPkm7ozrcSrxZXhJHc9AjL1toFdRQr39Rz5V2Sk+w3SjEoq9peGxK4jpgho3c+CGCsE3BhFQuNjiWV/g7nSAcdk3ncEyhv3ssATWL99GGk4d+LWOc8+YyeuhDecn0JRx8BScc0Kq+PxzZzdlvLhKS3t5xswUjgPA+vKHzTMCnHvaL7DHrfAgvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8320.namprd11.prod.outlook.com (2603:10b6:806:37c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 08:00:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 08:00:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
Thread-Topic: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
Thread-Index: AQHbuu0eX5Qthdj/f0ujxZMby7jsqrPFWNUAgAAucgCAAUnSgIAABE9w
Date: Wed, 7 May 2025 08:00:05 +0000
Message-ID: <BN9PR11MB5276295092F09A70EFC388DF8C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
 <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
In-Reply-To: <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8320:EE_
x-ms-office365-filtering-correlation-id: 908bd599-41c4-4e24-7f7d-08dd8d3d2d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?blZJV004T2p3Yi8wRW8vbC80WmVXaXhiMDVxUFc3cHVvUHozeFRFbmtBM2Y0?=
 =?utf-8?B?M1hnTW1Sejg4aE01bzdjSGFSRVdRc0dadGVUeStGV2srN010ckhjeXF5MTJ4?=
 =?utf-8?B?MGEzbFNZMFhxbDY5cWFxT3JPeHFjR0Y0Qy9LdGhwWXEybzJrV3lvVXF3dmh4?=
 =?utf-8?B?TytydXFYbHJOcmZpNmZPMVlEYjZJSGsrRS84elRDanZtaVp5YmUwNmxwZkJj?=
 =?utf-8?B?YVo0WVlDd2VBdjdrcDRZOWVVU1oxRndzVmx0QW53Zjl2SEY2dzRTTGxVYjBT?=
 =?utf-8?B?b2pOemdYdC9USGxSUktVQ2htRHVjQVZEVTFvZTlHcDE5dUhlWkVBek9qSWdv?=
 =?utf-8?B?SlluWkQrcmdwZ2xibEgxTTFhc3dnNTExdGJyQTExanpmTDhLMjZyM0FyVktR?=
 =?utf-8?B?akpvM1hPUEJKOVl6VTdsd2xkRENVamFGYk5IVVBoVFhiNDZiY0dDazlXVmVy?=
 =?utf-8?B?WUlJaEJVTTJvZGZKNWlkRERTUHhGMU5sMyt6NEVVTlhnbllpYVRjN3F0T2ly?=
 =?utf-8?B?bW56WlFRdm10S1dHZFM1d1l2b3p4NElnVjY5VS9BYXh1Vkw5dmg1T3g2R2ZE?=
 =?utf-8?B?V1hsWklsVVAyeUs2SmhoZmpDTXFhcWtaNDZ3NzYwR3k5anVSZVQwYk11WUdl?=
 =?utf-8?B?WS9pbHpWTWxGQzRPR3lrazhQdWlLTm1jdlJ4aDVBcDJFV2NKTERZZjkybDhs?=
 =?utf-8?B?NjFJMlF5ajBpcmlFV0JiMUE2WWwzMGR1WFZwZTZ6ZG5JYmEzcWRhUCszY2V2?=
 =?utf-8?B?TVNmNDIwU2h5ZUZZalRrMndOZzEza0J6SU5VVmdBeXh0QXJidmJVNFJSSk9t?=
 =?utf-8?B?Z3hpWGlFenVvQ2pBOXdONnJ5NURJTkk1aUoweXlUVVVHc3Arbms0Y2hqL0FC?=
 =?utf-8?B?djUzaXIxSnQrTEtNa2VpQU15VEdHb1pWUjBqblh1c2lkWmRVNmI2SXhETDVU?=
 =?utf-8?B?cWNlcithSEZiY3lvTFNqMktFY2NCMHByYm5sTG9xQjlDZGVNWTJkTk9xMXVY?=
 =?utf-8?B?THVtdGltcXpUeUV2SVI1cFhBeFRmczlFaTczanRMV1ZOMmJ3dGRTRVZKc1Bx?=
 =?utf-8?B?QjkzbENnN0tJTnFaOWZuNWZPY2xSczJoQ1kwRkZjSVByYzVqWCt2VnpJV0FJ?=
 =?utf-8?B?UVAxeStsZWFIL1hXalNueDA3VXNSZ3VwSmJ2cXZJdFZBdE5FeFNVUHJLdjdG?=
 =?utf-8?B?bFRTdTUrYnFCbkpUaURUVEJoVmRRdXJHRXY0UmJkbElVK3JmWXM2MVhrVW03?=
 =?utf-8?B?b1h6UHFoZGFCOGcvWWIxd3IrSWc0TzdDcHFhVzhHWXQxdHVXcU5JMGw3Zkxu?=
 =?utf-8?B?ekFUZExzWmQreE9IUmNraGNWdzJLL2VCNEZRcXliL0RIMjl4U0JyTHp4b2Vz?=
 =?utf-8?B?SXFtenNycVBvcHNpSGl3QkwzS0Nsc2s5OFhIQTI3NzZTRFQrZy9wY3VocWhT?=
 =?utf-8?B?OGFoMWFSanViR1dvSHQzT3piZ2VSZ3BHNURZSHpidXdvcWMxcEN0bkR5QUky?=
 =?utf-8?B?WG9jVHVDbnUzNExsTG1VcUxVOTlUcmgxUDlQdVo0VFVWMlFnNDVKaXE3eVk4?=
 =?utf-8?B?SDlVdm5qNG03YjQvOG12UFdlMWQ5c0VuNDdneVVjdG5lL3lSajR0ZFYvV3dJ?=
 =?utf-8?B?ZUhncUJGV0dQRmp6VnJZaFJjeVJqTGZJZXVISXBJcXlvWXo5UXNJeFNjS3FX?=
 =?utf-8?B?ZnBqaGVCdWovcVh5cEdqK3N1SVN3SlFNOTZib1d0a2NWRzJzOEhMb2l4ejM0?=
 =?utf-8?B?K3JES3FOWnJZZ2tGUjBUK284TksreXRBcE03RXhPcy83THhYempuaDBJNVc4?=
 =?utf-8?B?alhNZFBsRTRGVXM1c3kzR1ZzcGI4NFJqdE9Qb2dPeU1oVEt4ME5CeVhacUtl?=
 =?utf-8?B?QlBZbzdOTEZqZzYwRWc2ZjI5Ums5b1RWSzIycHZqTWxkangvQndxdlp3dkY5?=
 =?utf-8?B?MXFObHBNWkZPTGxFTGU1dHE5Q0pMWGhycFpBVTNuOGVJcGhFMFdnZXhCdTZi?=
 =?utf-8?Q?VaZKjY6/x6TZ0xfkn8is6l2ZByZI1w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NPbmNwci9OMTFyaUZBUjJiU3lwUDErbko4NEk2V25pamwwVWpqVnhrV0RX?=
 =?utf-8?B?Qmk2aG13bkhieCtDa2ZTMTM2SVNXSEZMYWlCZWxMdzlvZWQ4TTV1WTlyWHZC?=
 =?utf-8?B?and0NjVpZHZuSmNCRE5kQUR2a1RITnl5ajI3OVFHVDVPQkRiK1RMUkw5bmtD?=
 =?utf-8?B?V21JeFNTMTVkVFAyR0Jwd2ExeVhpcnZHNGZZUVU5TmxBM3kwdmFhQjNMUnJm?=
 =?utf-8?B?U2RZUHZDZHhybHhLNnNFZWNqZC9ZaUxrMjJyWkxGb3R6TDlOeE5tZGxpRTBv?=
 =?utf-8?B?RTVNMEtGWnhlM1FQOU1tQm5OLzJ4b3ZXT0hQU3BVbHUrZmFlVVZtZURyUGds?=
 =?utf-8?B?MGphRGs2NkExanIrcCtrVysyMFJER0ZFOWZPNXBQOWw5bkJjN3IrM0plcEQv?=
 =?utf-8?B?ZlJVRmpQc3p6am1UaW82TlRvc1BHeHF3MDhLeStibEpiZjZURFY5NlVEMWpt?=
 =?utf-8?B?eG80endCV1F5bFltbXhWOTdzT1NycHdWMWRDYldZNVdsbHJlaXNDY3NpdHBa?=
 =?utf-8?B?eXNhTStaY3BBZmI1SHU1bEhDVDVTQzhQbFVzeUFrTEpLUXFCa3RqTlNHNk10?=
 =?utf-8?B?aUQvWWp4Z2VTTVNyeXNSQW9JSng5bnV4bnJoamVBWkIwRmlUUGVpMWttZS9i?=
 =?utf-8?B?RWU4SHF1dFB2dStYQmMzRysvVE1nNzVma2pCakdRNlpjYVVuT09jYjBWczBY?=
 =?utf-8?B?NTZwQ1oxdjNLWW5zZ0FoMXIvYUVLa3FnQ1BHNHBldG45SGdOVGpWOWJIVktB?=
 =?utf-8?B?RXNIbGFBa0NnejhKQThSSDZiRGdLRHU5bTd0RmE4ODZZYmxlVkF1N2YvdGx6?=
 =?utf-8?B?cjdtTmNiRkgxaUgyckxtSU1KbXpnZ3pGWS9KdWJwY1ZBc1QxaXRIQVJjNTBz?=
 =?utf-8?B?QTRFZzc0dVN2SS9keXR1Y0F1RDZ0RFU1RmpQa2pDc1ZOZkRBMytoakE0aUtD?=
 =?utf-8?B?WUFaYlAxeWJES0xqS0VrVXJ2bE8xYnErRXczdHVaVk9MTWdSMjlWY0J6am90?=
 =?utf-8?B?ek1HYXpQNURCTlp6S2ZjV29oTGk0ZmxkK3poaUJTSkdiSTEvNlNCbUhaZ0wv?=
 =?utf-8?B?MS95TEZHYXpuMFc0SzJOOFJ5cGQ5THFNMG16SXFUQ3A3Ukp0UTBPbi9IZmxm?=
 =?utf-8?B?L1h2cmlscVNoZkJWRWJoMWJDaHU3T1BPNS9LTDhqQUdFb2Fuc2lOa3h6RjRn?=
 =?utf-8?B?Zm84RnhnZGFhMkgzSE5tVFJRMnBpemhDZE1xQVA1Zjl2RVB6dzNzbTIxNXpz?=
 =?utf-8?B?RS9TRmY2R1JOTWtjZi8vajJTRDM3c1BHTWxTZDlpUG1ybTlhT2grTDJZZ2tu?=
 =?utf-8?B?STJjcTZrZGt5bTdMYi94UzVuNmcvZzMwSksrWWw3T0w1SXNHU0szMnhVQ05S?=
 =?utf-8?B?N2poRXJxMkthME9DdVFSZllXeHM2RjYzSSt0MHhhU2hIZnBqQ1JXUmFzNjA3?=
 =?utf-8?B?cUk2WFR1b1FibmIwalBncnJrWUN3M0pWQStxWExHdzJaK1Y0amFJRlhLaFUx?=
 =?utf-8?B?cDB4d1g4a3pYbldWWkVUMWJnakwwcUhvNFR3c1IvREpMN2RSdTloVUJYOEFD?=
 =?utf-8?B?KzhLUWhlL3AvRXgxZ2xjcWx5RW1qNVpBckswVTJmcDcyVGpMTHE3dkJEZ1p2?=
 =?utf-8?B?dTlsdTVwYlBWYTFQbm5EbC9RNC9kUXBMQjFtbTA3S240MnV5L095aERkMEpy?=
 =?utf-8?B?VVcxaU8zOU9IcEkzT1hqR0oreHNtb042d2dtQVJMb1h3cVRpVXR3OGhHUHRk?=
 =?utf-8?B?V3lNc0Y5SjRYWW9yTGNOR2ZLQlpQb3F4bFNBYzJBRGREKzZEbURSUTVyQlhF?=
 =?utf-8?B?WEF5TklMVjBaK251TWdGZm1zak9qRklHVU5NZFRWQWpBTndvVUpUYmlNelBh?=
 =?utf-8?B?N3BUNmh3OGxZeWFrVWdCelc4R3NZYjl6OXVMM0N5ZVZaNEwwUE5ieW02SkdI?=
 =?utf-8?B?ZldyRDgxMzBvbTRTclora25zMzVMUmRibUY5cTVHcHJ0NFNKY2VIbzAxc25w?=
 =?utf-8?B?OE53b2VhWlkzYmtMaEZwTnJHWHlUQXV3STRsOW1nTi9jc1hOck05TmtMdVds?=
 =?utf-8?B?Q0g2TmV4RGNScm5PTzNtZkpPWWIzaWF2UzBMbkNOVVZHYVk0QnpRczZ0MjdX?=
 =?utf-8?Q?sEHH8an09eG3b0Dg5bxBs8Xu7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 908bd599-41c4-4e24-7f7d-08dd8d3d2d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 08:00:05.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYaKOXLIbjFk2X6gssUCjX2aEQNenRZz/iN3Hoqx+UbTHGberCktn56WPXSKox+J9ktJK/NBtXUSGTEgFsqrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8320
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1heSA3LCAyMDI1IDM6NDIgUE0NCj4gDQo+IEhpIEphc29uLA0KPiANCj4gDQo+IE9u
IDUvNi8yMDI1IDU6MzEgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBEbyB5b3UgbmVl
ZCBhIG1vZGlmeSBxdWV1ZSBvcGVyYXRpb24/DQo+IA0KPiBXZSBoYXZlIHR3byB0eXBlcyBvZiBv
cGVyYXRpb25zLiBPbmUgdGhhdCBpbXBhY3RzIHRoZSBxdWV1ZSwgb3RoZXIgc2V0IG9mDQo+IGJp
dHMNCj4gd2hpY2ggZG9lc24ndCBvcGVyYXRlIG9uIHFldWV1ZS4NCj4gDQo+IGV4OiBFdmVudCBs
b2cgYnVmZmVyDQo+ICAgLSBXZSBjb25maWd1cmUgIk1NSU8gT2Zmc2V0IDAwMTBoIEV2ZW50IExv
ZyBCYXNlIEFkZHJlc3MgUmVnaXN0ZXIiIHdpdGgNCj4gQmFzZQ0KPiBhZGRyZXNzIGFuZCBzaXpl
DQo+IA0KPiAgIC0gIE1NSU8gT2Zmc2V0IDAwMThoIElPTU1VIENvbnRyb2wgUmVnaXN0ZXINCj4g
ICAgICBFdmVudExvZ0VuOiBFdmVudCBsb2cgZW5hYmxlDQo+ICAgICAgICAqIFdoZW4gZ3Vlc3Qg
c2V0cyB0aGlzIGJpdCwgcWVtdSB3aWxsIHRyYXAgYW5kIHdpbGwgc2VuZCBxdWV1ZV9hbGxvYw0K
PiAgICAgICAgKiBXaGVuIGd1ZXN0IGRpc2FibGVzIHRoaXMgYml0LCBxZW11IHdpbGwgdHJhcCBh
bmQgc2VuZCB2cXVldWVfZGVzdHJveQ0KPiANCj4gICAgICBUaGlzIHBhcnQgaXMgZmluZS4NCj4g
DQo+ICAgICAgRXZlbnRJbnRFbjogRXZlbnQgbG9nIGludGVycnVwdCBlbmFibGUNCj4gICAgICAg
ICogV2hlbiBndWVzdCBzZXRzIHRoaXMgYml0LCBxZW11IHdpbGwgdHJhcA0KPiAgICAgICAgKiB0
aGlzIG5lZWRzIHRvIGJlIGNvbW11bmljYXRlZCB0byBIb3N0IHNvIHRoYXQgd2UgY2FuIHByb2dy
YW0gVkYNCj4gQ29udHJvbA0KPiBCQVIgYW5kIGVuYWJsZSB0aGUgaW50ZXJydXB0DQo+IA0KPiAg
IC0gVGhlcmUgaXMgb3RoZXIgYml0ICJDb21wbGV0aW9uIHdhaXQgaW50ZXJydXB0IGVuYWJsZSIN
Cj4gICAgIFRoaXMgZG9lc24ndCByZWxhdGVkIHRvIGFueSBidWZmZXIuIEluc3RlYWQgaWYgd2Ug
Y29uZmlndXJlIHRoaXMgZm9yDQo+IGNvbXBsZXRpb24gd2FpdCBjb21tYW5kIGl0IHdpbGwgZ2Vu
ZXJhdGUgaW50ZXJydXB0Lg0KPiANCj4gSSBhbSBhc2tpbmcgaG93IGRvIHdlIGhhbmRsZSBhYm92
ZSB0d28gc3RlcHM/IFNob3VsZCBpdCBiZSBwYXJ0IG9mIHF1ZXVlDQo+IElPQ1RMDQo+IG9yIG1h
eSBiZSBzb21lIG90aGVyIElPQ1RMIHdoaWNoIGp1c3QgcGFzc2VzIHRoZXNlIGluZm8gdG8gSFcg
ZHJpdmVyPw0KPiANCg0KUHJvYmFibHkgSU9NTVVGRF9DTURfT1BUSU9OIGNhbiBzZXJ2ZXIgdGhl
IHB1cnBvc2U/IA0K

