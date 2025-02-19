Return-Path: <linux-kselftest+bounces-26936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B649BA3B1DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 07:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136C73ADE7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA01BD9DB;
	Wed, 19 Feb 2025 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/1LJDcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CD1BCA0F;
	Wed, 19 Feb 2025 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948317; cv=fail; b=HP7KMoqo1VKZ3Hh5IMRXDq3ALwmtWxiCAUk2dFaPPr934PSBoFVmvJhnovSQOU95J9ykqODnui9dQ9nEvkh+IB4lPY5buhzCJPDnKr2dGCcX+VCYHG2TwMl+KztbT/8iYL/7FbconSZ0Xc9ynG2TcCvx9s1mjOKqCC8YnCS/V5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948317; c=relaxed/simple;
	bh=C7hhYZZlQ8FqNEXDYbwzxrPJjkaS0BOFENRaRVtNw6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SomQt7tYiwJxZBjphAtpUIZ2ehUYrIXQkREQTzWN9Yu0Mb6wjNfsh1bu7m1YDMoij1JtEKZCc4Aw1vKhEdk/qgF1Lpsl2ggc10xZRm/+VeOOjPmi4xm2jShYuog3kmnmu/zC/iBEPNdJR8DA4X8vsyD5QE3u7s1lfyzKv4DHX9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/1LJDcU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739948316; x=1771484316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C7hhYZZlQ8FqNEXDYbwzxrPJjkaS0BOFENRaRVtNw6g=;
  b=e/1LJDcUcDU5HVC0+WZVxa6Tggr30RGWgqTbYrsYqk+7AUCkL/XYa0dB
   8cok7vdo0Zx1cE41157xhx3C1W2Shp0Hsx2P305zvb2xYv4jW57vhxPow
   SIqf/Mbz+IgTjZbXJEKnRR9a2S40b21Ay2TtjfFKgF4EW1ppu/j+gjTBK
   Vf0fiugddZfHl7DNL24kSlcOQOauVgCJ6nas1cVhEnJAPLVUCO2Q9PBUB
   Mw/uilgAOZ2V7tW6x9xEdqdS/fUJ4vJlgre1cgL4+LEBb2XXnJsJ5jtZ3
   Jn/k04PF5ShfqGXFv54KxFCe359FJiKtkuVyOuzQmujpO0gHn39qkN3Zq
   A==;
X-CSE-ConnectionGUID: UBwdLDwUQMG85p32Zaqyjw==
X-CSE-MsgGUID: AMeHtR/nTbW6GmTD/AbxGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40931238"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40931238"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:58:35 -0800
X-CSE-ConnectionGUID: 3wy5vTHKTXCNWr+hxZ+zqQ==
X-CSE-MsgGUID: mg7otcCdSheyOfCw9+6D2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118763542"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:58:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 22:58:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 22:58:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 22:58:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkAaPD8CLFLdHldkSl4aTxD8CJx4o8nMw9cTcHJrNuai0NA8vqEQI6GfCI2XnrwAjX2G3U0TuGLwZh8e1Wpj9SFLbDa15NOyOmpLdsOTHgiJa4YcBqrgZSMYeodAwhu/HgsAEs7R79FK8h1wQPHbR6EmFk5uUFvteRM4wxiHhK/sE524fQc9RfW6a/yWDAfSHU+qSf8ExrF9BI+BSgPA0w/vGn8A24OUtBe2EuVp8+VK28l43vM603Y3sEN+gpQoSK7SvamviPaUEyjNY1BtfLBbrrqmrOKiielu8OaXiqYQ+cHxwWeiF36c2LD/sEr+HbkKuQZF40TH5I/o/y7fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xjf45D++p7HWZP8D0e7lDeVVQgXBkPo17w8J2+JVKUI=;
 b=PH4LBqY8dSx2kZN/ickhrXpb/sbluGaJVMtlpkTJNf8xAhzh15OmDjgisc+1g9NpUbbhQTwVEBVSNiB3Ep6wNiRl2tMRnqTq94voxPTDfg7dpjEFlJgpjE6y8tvycRrKoRymTUHu69faJjmXvhSjFljL9FZa/nn8g+U/wKUX/n6nmU+4p7vH15OvViiyptAbJIgyJDvuBAiu0iCiFVGU6dZSMKqhEsbJLaM7dUzCraWzV/I2Q4KPNCfZhkyo/BZAXO4Nfe1fN8zibzxO171jiPeKR2dBVlGCw/7nDekpSKTfXxuzqGKFqNmQny8245vwFB4PccX/J0Ut8bHqVwdHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 06:58:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 06:58:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
Subject: RE: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Topic: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Index: AQHbbsB7HR9yJhey206dG82i6PAMFLNNWAeAgAEBU/A=
Date: Wed, 19 Feb 2025 06:58:16 +0000
Message-ID: <BN9PR11MB52766CE9C579D3EE1CE1A7058CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
 <20250218153541.GD4099685@nvidia.com>
In-Reply-To: <20250218153541.GD4099685@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6150:EE_
x-ms-office365-filtering-correlation-id: e34ebb00-da8c-48e9-5ae0-08dd50b2c8f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1tL8E+kxv+yMZsTcLnZjSA6RJ0fHNkNQWBXEz5TpzRuAVqIukNFkSqzjAOz3?=
 =?us-ascii?Q?C5LT+V2U36jx8DuFWwmD6PXDzQDgNrdBhZB+wpnwUZqcED5ofQggvoOcm0WG?=
 =?us-ascii?Q?xM7Fx7N9JkmS65n6mMXkkbdKnJR9LsV8/gpKUUwMVDSuTOdzjGXH6QB3dkq/?=
 =?us-ascii?Q?nFaAmgH5WPE6t1fIevfWAGfqMI+yjLUDmXlH69Mts0Bx3MKDWfHp4AtwW7KC?=
 =?us-ascii?Q?8be/eNC1jLXIEr1vbANspLY43J0OlQPUIkQfIYzJtZ5hh1g4VDaJtH0H3vAH?=
 =?us-ascii?Q?TNkJQBu+oABpaz2MPGbbjk820G9OnzIbC0TAt3PShwP8J6II/yqt/TmIDSM9?=
 =?us-ascii?Q?YaAuA2peG4eIWYbrHSb+M1NEhLvKT+d5YkyK/+u43thOptNcgge9UaINbCT9?=
 =?us-ascii?Q?91Mbk0Qh2MByDiq0ZHf69dF/PF35ISgoP6n1mSVXufSKoBf2TYjd9RyEwojp?=
 =?us-ascii?Q?GC5n/ltGd8WmJ7I5hxi6F9phiryWrOH3WdZwVz8xMhPlCSrJdFJieaRgOyIY?=
 =?us-ascii?Q?7sCfJqfLpkOzQdAAv/J/C44uLG0u3GMRowEAfShDscg4QT2QDGrDGqJ/ikgG?=
 =?us-ascii?Q?5VcXCUKMyJ1YoG3MfkrsKmTBIb+JaPEko78Ksac8qtMdOJkrSHEICfhst1bA?=
 =?us-ascii?Q?5t9uWyJEOXOeMrvJMjQ+ICzp96a9sX61AG0lthHl/dSn07N89spEA8sN0I2W?=
 =?us-ascii?Q?s8MRNyM+bEZ4X40SZwk4tDjc54WZHgzN9LQSnW2QDZPPyi4OjQ9hYbZaevA1?=
 =?us-ascii?Q?2dEAlEhR4DxpMvDu+p+9JDlFADzcdnTyyguKpIIBxg5f11+0MojFMbmvgq7y?=
 =?us-ascii?Q?lxj1oNf7uQWvhfbnbJpFl4IwXLXDPwr1lKr6hYZAFudCrjVRRBiLLlKTvinL?=
 =?us-ascii?Q?lOawx2HgSeFvehxKiwDUOAo+6ZEbb1K4TrIgV7Xtmw58dDzQX5ApC+I+KGR5?=
 =?us-ascii?Q?PVuT2ALN9IQkIGlAT/ogMeH3Gt2gDXVzOdPTdxh/Df64gqTXFGKZ/jYIN62h?=
 =?us-ascii?Q?PHKDOvYGXvAVR4jI6BLoxpEDIZjvsY+NmjVhvyGAWPJRxVQ+SVp20IVz87w5?=
 =?us-ascii?Q?9uxCa03bnRPkQfJXrxGBOMBjvurZ4x6r1OViNgK9dezIyMJ4zZftoLST6Ldn?=
 =?us-ascii?Q?BPRTlbEq790jCBQkP02U2mdmIO4Z5kUBgMfzPTLKkyTUQaYqT1BXCzeae8ey?=
 =?us-ascii?Q?Q/AWJanf48uUwNctOWEurmgGaw/K0cgtmCtyxNjUbXgG9g1CQh90WXaPs25D?=
 =?us-ascii?Q?phge+NI3b2CHWLU5XH1MLaYZxTVT/kVb6jEgVz8+hFQOt8i9y5lrNsG0TRg3?=
 =?us-ascii?Q?8fyfQPTeehkNwL3qNHpAXpnIiJ9bI1wB5rPkOYpemu06oBFG8pEC5d69ITLG?=
 =?us-ascii?Q?93Mgr/2SYFv4bZmMwfCs5QFvXLbTBvsAtJEzEUGXoKRP2jnxaJRY9fHHUR6z?=
 =?us-ascii?Q?4ZKvAfucUgqy7FxVaUYfv98khXkveeJq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?913gwlPaGA7lebAdGIjPtJ1KUA/G0KFxCe7Jx5vXy0bJTGZzkl6lVOeq1zEH?=
 =?us-ascii?Q?0yoZ/lAfMWdVzLjNIf480UtS2P0nNMdborotfMNueUN54hJUyMozgrPcH0u/?=
 =?us-ascii?Q?8NJxLXFUm1LA1b92OPqPUW5tjhQLS6k7OcnMLvjY7SslSOhtmbm/i+/rmhwX?=
 =?us-ascii?Q?S+HsWEUJ6XftctS/3OaxpniX0hXJScXive37+0rbJZRYyvLo1H7VO123o9cA?=
 =?us-ascii?Q?SQGyEx3VX3+pqfsFG0EiDWDt4E0vrKkXAX1Z0QnVd8q89b8OALp33bX4YGL2?=
 =?us-ascii?Q?7Vq7NrLO53u/c18uW/axDleawhVMgCrFGeDhMoFkUwQ523x7Y+wabbu6KLZO?=
 =?us-ascii?Q?falaEZIVoUpmgwnk2L1RgoGzJIUxqs1E+pfnHkOMgfnBGDtCDlrsK7WRkeq0?=
 =?us-ascii?Q?gAc2WDYQDVtyRgrJPsdi9jwaQZ4E9VCGk87GRudw94CY3p9nC/DE1FXcy5wx?=
 =?us-ascii?Q?14tA24m+Sd5xPWRYDra7zujS4C2uMEEivp+t0mMujeoaaZx4E2ze+HrAbFDY?=
 =?us-ascii?Q?P5RVPJE/yiS64nOrfIMywluPq4DEVbIdUE6d7MxraGbqNT8aeQbY/QkDyUVW?=
 =?us-ascii?Q?ufAV/EhizOgNVxb1tWDCwrSPuBLnc6LwYQeF8rsa1V2xluPz4yzZ67WxmhzZ?=
 =?us-ascii?Q?4sycNqCBcO1avYc8mxEMXIiOK5S5wWmBas2nJpw7HqLnzMwCOpRGv/4yGMOJ?=
 =?us-ascii?Q?WWPeCnELpNqD0pH1H2+2Xq88fKA2WN6cC/gSL/9VGL7ueMMkXohduyG0arS8?=
 =?us-ascii?Q?FiVfMWkoCKkiaDoK1A4NmEbCSciulqJQtquXEGVhxkV0KEBLL4eiRwqB3kyj?=
 =?us-ascii?Q?LCs+WUE5MCxOFNTSdVOOu1FqWISBKAIyeCa/a2P8A6PAC/n+5btCv3LdJ6px?=
 =?us-ascii?Q?yeNMQWkCOoKGtf3Z4zz5F8G1J2NXcC3Va8U//FO7Gn8ZAiG+ncrQfXtRrd99?=
 =?us-ascii?Q?VXgM36vC6xvmKQLu191FvQKI+QevHb1wQuNAAieEAhg7O46GqBbTqqfcPikS?=
 =?us-ascii?Q?PRV76pNn6/Vjah7t2zZG1rxyyVXpUdl+kGK7mG/QmhaY43OuVpKXh20wrbhH?=
 =?us-ascii?Q?iTydsr9zBb39CTn0PX6PKBiPLWG5mqxLs0K9K6CUknFCBRQvK4YRd0spXUgu?=
 =?us-ascii?Q?0Sf0XLi1TOAlcVmey38zigtY70hUK6JsKEgXsNQxwXzfbq83YNn9wEMuFWRF?=
 =?us-ascii?Q?E1SnDGaF3omBn0XCdWIIUEeOoRjbAHA5Y2IL74bs02ZI10CIh/48pOze2zvB?=
 =?us-ascii?Q?IGO+FrVEcMyd8RSDFH63/WUG4Imfhf1o10cD8EbfhnV2F/AoOUW1Yq6AvrfG?=
 =?us-ascii?Q?t0uVVroEP/i1wiYWbflGIPmIF91vpPy98CYxsFMN+yk5znWj0V7Xbje4c+vz?=
 =?us-ascii?Q?IdtJRTUl5ot1uFkf5oqFQkqVAn8Gk4yDlSoXaws5D2sBxnxU2Vyu5+U+06GG?=
 =?us-ascii?Q?iBtgfJwVjhDvMn0SvBw+hKCvfEwPDWnJ9M49Hcjr6ihC5YwpHe+xHw/vC6C7?=
 =?us-ascii?Q?/CHnAmWfJTAtK3hejA3ejxtej5/vZb6ugw3u+iVQJBMWbNOvhQxGyhpQn6f5?=
 =?us-ascii?Q?LNNQx3J8nPm9dyP6wERNpDP6LNc/HL7mjJ0t3btf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e34ebb00-da8c-48e9-5ae0-08dd50b2c8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 06:58:16.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h//jIYmxpnD2fjAzzP7GC9Q+Dj6zhAlCkUPdv/mGltB/uzr4dir22f4dsO0YSPYs+QlTrjlXqH1K17m9AjLrtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 18, 2025 11:36 PM
>=20
> On Fri, Jan 24, 2025 at 04:30:36PM -0800, Nicolin Chen wrote:
> > +int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
> > +				enum iommu_veventq_type type, void
> *event_data,
> > +				size_t data_len)
> > +{
> > +	struct iommufd_veventq *veventq;
> > +	struct iommufd_vevent *vevent;
> > +	int rc =3D 0;
> > +
> > +	if (WARN_ON_ONCE(!data_len || !event_data))
> > +		return -EINVAL;
> > +
> > +	down_read(&viommu->veventqs_rwsem);
> > +
> > +	veventq =3D iommufd_viommu_find_veventq(viommu, type);
> > +	if (!veventq) {
> > +		rc =3D -EOPNOTSUPP;
> > +		goto out_unlock_veventqs;
> > +	}
> > +
> > +	if (atomic_read(&veventq->num_events) =3D=3D veventq->depth) {
> > +		vevent =3D &veventq->overflow;
> > +		goto out_set_header;
> > +	}
> > +
> > +	vevent =3D kmalloc(struct_size(vevent, event_data, data_len),
> GFP_KERNEL);
> > +	if (!vevent) {
> > +		rc =3D -ENOMEM;
> > +		goto out_unlock_veventqs;
>=20
> This should record an overflow too
>=20

In that case probably we want to rename 'overflow' to 'lost_event'
which counts lost events for whatever reasons (overflow, oom, etc.)

