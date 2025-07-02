Return-Path: <linux-kselftest+bounces-36242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C47AF0871
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F99C1C05ECC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B319CD17;
	Wed,  2 Jul 2025 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hi67fbQK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91758219FC;
	Wed,  2 Jul 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423030; cv=fail; b=DodIQPyGNqiy0BvAsjvJAmchgSCB+/Vv7q7wCEO6zA9FX3kimUD+ubnx8t0ZmdW/9dtVwLLblRL5OIN0wZXa56VZNaZhCyApwT2XpYX6EMFWvBo2PlvTR+Ij0rjmmlgSj8VnvxjjSqqw7/7zMQA3lwGO53gb0XTYx6D06KGFFl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423030; c=relaxed/simple;
	bh=vvfg88oGa1mVfW/BzK2wXk+/ou5LZM51T8RV/kbur64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHx3OaAUt7fb0voUweNjdtbNVsnsmJAz24umUd8vEMcIy0Q46vJtPyZ+ZADtnpSmUBYGDlBpW0vbi1jSoy8xPJjvvUy37KfHLuOHCmCf7pPN1qvMzafL+XtnREvh7/aOthLW2zj6rwgzJ4UO+KDValgff3wcRNPzm9cKrRbUsLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hi67fbQK; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751423029; x=1782959029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vvfg88oGa1mVfW/BzK2wXk+/ou5LZM51T8RV/kbur64=;
  b=Hi67fbQKKh+YbidfLQ+gKt+hsTyatNaSHITDB8R9ucDXzXiZ0Unjom/4
   45fDScU5tD/sb2jcGdeaY5BEsTSi2KnrviyXOh7xLkK+rxaHJExJQYrUu
   vjSbVke2T2wWGsrhsPejBn2htnOq8eZ7cpojtRVG41RGK7Nnw26JpohcV
   370jGRnIZgkjawUKf9jT0kg3gvo54ZpvEuOwbUsV0ePWCIiwRjUrB1agS
   6B92qsk6B4TZtVY/3+n0ieotVc5gX/oqvORq5EiPGT08FScnEVV7R1DOi
   aRcPeu066P6lFMrkQIehOzGWdPVbxxL144jbacJOOtMKexJLL20KrAzpS
   w==;
X-CSE-ConnectionGUID: cKwtRS1jR6Cyn3HPGdCR8w==
X-CSE-MsgGUID: SGHRWbrdTTeM3i+CA4P0bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="76253514"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="76253514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 19:23:48 -0700
X-CSE-ConnectionGUID: 9nL2n0kPRkW8c+4Oxotf8A==
X-CSE-MsgGUID: 8fQgMfiTTh6t7hezA+r00w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="154668729"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 19:23:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 19:23:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 19:23:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 19:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm79j2ODHkPwFW45guz++Dk6YXwXw2t1IWHlu5hmLY/iNlQClI96Df86ASVzNBuO8fNmM/O5GCfOwLutQuE6E4x9WbmeK19EYwlvVSKX3nZ202uFTLAuYzJkZ6Qj9WT+uvpCVsvvxRwDawek9uRCxjRRMYyKmrfJh15JtqZ4bXO6gTI9uhaNrjuBUKUrztocnpqvrTJgqpGo6fb1tF3hytMrhMEsGOXBCZ4qcoCSuGXCpvR7Z0YxLwgM8++BGMRFvLEQg34NuPVgaElt5bYEuUgdmj1r4w+5YxpvHyewl+QMqHS9X6vMSgN0maS13tccyCNz/xMD3Pt79389TYv0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvfg88oGa1mVfW/BzK2wXk+/ou5LZM51T8RV/kbur64=;
 b=oZBkcJfH0exm+pJNWf39+hULn43xy0qVcEGF5VWVCtyBIN3anS+bfaJbcPZ3CgXf+ykvza04FSvFSROzrsoOjZb2AnsLhJZOvcsEqr41+HFPcyroSWPw/BFOTfdNoJrq2q9crk4TtfUOtHq+41k2HsXNviXCH5ZTt1GFvCCKvQPAJS2MYm8jn5P4eeOWOT4yFrOWFDxL4bxA/hc6btJiSUaOlZAiJn+mIQ3myTe1NBdPf/UfDzeE/dQRNMnN/Isg5T6wo9CqCUVEo8cCe1OqHCsPth3ziUynk5k8pGqQ9jQblMf20xCwrMLuSZzELSngDg1I+/8dzqaLRPzNgYoutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 02:23:29 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8857.016; Wed, 2 Jul 2025
 02:23:29 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Thread-Index: AQHb6kEMHPOPYZSFok6IH5vzoGeGvLQddqWAgACgmGA=
Date: Wed, 2 Jul 2025 02:23:29 +0000
Message-ID: <IA3PR11MB925416396633E361F37E819DD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250701042940.3272325-3-yoong.siang.song@intel.com>
 <aGQNWXe6FBks8D3U@mini-arch>
In-Reply-To: <aGQNWXe6FBks8D3U@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|MN2PR11MB4680:EE_
x-ms-office365-filtering-correlation-id: 4ffea343-ba74-44e8-b1aa-08ddb90f6f30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXphZnBjcWxxRFVhZ0IyQVN1ZS9DR2orL3hvVFlkcmVKR2xKL3ZXNnNydFNa?=
 =?utf-8?B?ODBCaFIyRGRzcWYwVmtqeEt2SVg0aWpDSzYvTXRrTDNndEx1eld5aEY3NHFm?=
 =?utf-8?B?WW13S28wUm9iSEt1dXpveDVPR3duNUlVekNhQ3Z4QWR2cGZwak1WTC8xOTNw?=
 =?utf-8?B?dzI2ZHF2R0VRNm5pMnE3ZzBCV2wxSkczSXF5ekJsbDJaNlVGYUxpRWR5VUNN?=
 =?utf-8?B?SVh3Z3FObit4ZGh1T0RxQjczb2p5N2VkcURzaGdnV3l0RWJJQnhPamFyOThw?=
 =?utf-8?B?cHNEa1RLbitQd0o4NTc0dGh5OUxJRTd3c2RnTE5BRExFMmFMQ3UvNWU4M3k4?=
 =?utf-8?B?NGhpYkZQNzdxQVNwOHFaV1kyMkYyMm1keEZ4NHBzVDZWcVJtL0dKaTZheFZ6?=
 =?utf-8?B?UTFLbXduRHRJSmc4bmZXRlRCeHpCTE5qNjZoN0tkMzFtR1pyeFlUQnRmK3dV?=
 =?utf-8?B?WHVHOWRRNHNTQ0twZjFWVFJETFFKTXZEdmpEWVhSL0pIM2lRcUh6OUs3N2la?=
 =?utf-8?B?THovT3F6ckY3bGh6QzlDamtzU25yKzVSTDN1a3RaN2FFVjdLU0NySlo0SmIv?=
 =?utf-8?B?eklmd0RGZ25HdUdFbVZRRUdFT1E3NWlXaDJkbnBBR04rSjN6cEVEMGVROTBs?=
 =?utf-8?B?YkNWeHlHREszMDRuRVBjaVBaTmdQVGNOeE9GMGx3cTh6a2tNVzUzSTgzdWlL?=
 =?utf-8?B?ejFVZjJXWFlEQnM4cWZZWXRub0hEQmxBay9QM09IeTVScWJKN2FpZGFNRnFy?=
 =?utf-8?B?Sy9nYVlPN3l0N0VsOGFpaG5TZjArZlpxZ3FVcFRjTHB3andCU3MxNUYrZjR1?=
 =?utf-8?B?eFBJTmg0R1RzNmkyVVZsN00xTUxYTHJ4WUNlRXBRSEM3N0l1TmxMaVZZcnQy?=
 =?utf-8?B?UjIrcDl2bjJHa3lxZEtrWmR6akdDaXhkcTRGUWNTV1VFTHlub01aRkhia09x?=
 =?utf-8?B?Tnc4QW5odVpnVTBqUGU5Mm13R2JSVk9GRGRFenQ3MExEVVZMMnFUbWEzeFZ3?=
 =?utf-8?B?a0xxZGJkcUtKMXRYY0t1SzlTblpSNmJPZ3dFZmNnN2pSaThRNm43cGdWM2Vx?=
 =?utf-8?B?Q2JjTVNnaTNmSmdJSm52MUYrSDdyV1BVVHE5aVc3V3JxTURUTTJTZzI4Ykth?=
 =?utf-8?B?ZTB4bkN6L0c2RkxVR0w4MTlLY2FkV2F2Q0F2bk5VUlpQZm85V2UwaHpTR1kr?=
 =?utf-8?B?L3J3d2o4MERUcThmTUZKMUhSWnVyLzA2UlFVejluZEo0ZkFBNW04NmRnRHNl?=
 =?utf-8?B?YnhqNlh2N1RlaGFJbWJ2YXR0a2lWU2JaV1k3VkNVWTZ0Q2lnMDhoVE16cUg0?=
 =?utf-8?B?eDRua0ZqNFhHREEraGxmMHkwT1pNdHdtbDVCamJVS2w2YTUyek93UDZabjFy?=
 =?utf-8?B?cWtFb3kzcmk0OFRlVS9VV3FmTmxOaFp2ZVNsZEt6Y1RHMG9MWjlsN1dEYW5k?=
 =?utf-8?B?eHlFTGR6bFFpcFY3WFFLekN6WXBaVkV4cHhOZ0VRVmRVSlFkWmpCeHhGRWhm?=
 =?utf-8?B?c1YwdnlLdHU2WWZ3MzY1TmRVNTZXUnU1bXBiQkFvOTVtS3dJcFhQd2ZCQnll?=
 =?utf-8?B?MlhYeG10ODFTd1ZNRUZDYzFHcldZRU5HQUt6L3ZMdExETElYTVczelNhL3VZ?=
 =?utf-8?B?dEFkN044N1AzVWRCMll0UEs5R3pUYjZvY2srNlBUZmtNOHp3VWFGM2RiNUE3?=
 =?utf-8?B?TDVNenFGalY2ODVXN1dUUGxvODl4cGZ1OElQQ0ZQS3NLYm83K1Z5bFR4V3pa?=
 =?utf-8?B?RmU4YWlQOWNZZUFVMUVLS29nTDVSQVJWdEtZeS9oVzlLbHAxc2lqckVRcUhX?=
 =?utf-8?B?ZS84d0tqY01ZZythbEJya0xBNWFycEtNTmRKYmJuVkVBalpZL050MVBkbzFz?=
 =?utf-8?B?RXM1SURMejNNcmdvVm1qM0pIM2R5aFo0dzF4OVVZcGMwN0RXRkh0ZEVIZDNZ?=
 =?utf-8?B?OFRHdkk3eDJRY3RJM1hGamZ0VTBMa3FhQU1UYUpTdVovUkhEM2dwbzJFODlF?=
 =?utf-8?Q?Vwnc14TqdKxqDy5EgiEC+YTxSd6WU8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnFGYUVhK05rYVFZRVJWVnMrZWJGcEhvNERMVjhSaU95SWE0ckpZdGxmWGtV?=
 =?utf-8?B?RXE1dE5tQlQvbDhZb05DSk9zdm56YUdLaW9GUUpONUVlSk5jVUFSNVd4ZC95?=
 =?utf-8?B?cXhrejI1YjFXbC9xUGg0bWNUcVdJWkdEUEp3MFkwQVh5YVNTcUZxN2tSdXpD?=
 =?utf-8?B?VFExaThQb2x4dHRsZzJvK3MzcWxaUVc1cVgwY2g2RUhqRkxRenhWN2p5TERT?=
 =?utf-8?B?ZmlWMXg4T1liaktabWxudEJ2S3JZT3N2aVhGRWdLeU16bVlMWVlZVWpQUGZt?=
 =?utf-8?B?ajgyc0JaTEViUk1ocmw2MnVZcXFYYllPU09JaW8yMDdyUWEza1FXS2NEM0pv?=
 =?utf-8?B?KzA1SEt5aEdNT2RoVDliR2kvTHdQWVE4c1ZBZjc2UDBha2xBZTg5b09PbWpt?=
 =?utf-8?B?eFpKYXlSb1VGcW1OUFpXZ1BUaHh2bkQ5QUFJcHBsN1NUWVV5b0ljNDFJdHFI?=
 =?utf-8?B?NnFORTA5R0NiT3UrZGQ3aE94WmNzbVIwcFZsdFd2UnFPQ3RMWFpwTHFaZ0th?=
 =?utf-8?B?SnN3M1lGdEhyR255eEFId3JBN05QNUU3MEdJaWsxQTZ5N3ZtaGR3cFR2QjFt?=
 =?utf-8?B?L2o3QnFGdVRFUHJKSFoxSHhyT2RCcTJQWVNqYUF0OHEvUnlMYUxrcXJXTzNk?=
 =?utf-8?B?a2ZoZXRQc2ptVG1BL2V1NnFPK1dWWkNNbXZJYUJBNlphb3lsd3ZNM2ozUjl6?=
 =?utf-8?B?V01NVXNIbzhJSGgvUjNScHhmSlFndnJIdldIajhiTHBZR1lvVEdDdUh2VXBn?=
 =?utf-8?B?S0VWc0d1VmRhQXBXVHNYSDg5TCsvMlZNR1lSSll4TUpXL2Q0ZHRsclo4YVkw?=
 =?utf-8?B?eFdpMVJReVhwNHlVRGZ5czNKakVGQmJpbXZLcTZiQkxvblBlS2Zyc0JYeWMz?=
 =?utf-8?B?OXBLMEN3MXh5ak15cE4wMnVVTmtBTVA2WUl2cURZeFdjT3dVeDVBTjhWZTZw?=
 =?utf-8?B?S2h5Tm5COVJ4Rk80cVh4S2g2bEZlTHM0N3Z5TlUxZ0hhbkNTMk15Q1dUeXFE?=
 =?utf-8?B?NDM5SEhXUHBpb2RMc2liWUU1aytFaGk0L3lFdGpRUjJGS0JqTnJ0WWt2Mm1H?=
 =?utf-8?B?bENzQ295MUVCVHloa1JKN1BhV0pWcGM0UlNMeEs5QU1UaXhpWFZHYjhqTGkr?=
 =?utf-8?B?QlhlMDdTRkdPYjhYdGN5VERjVU83UUIrakpyQjVyZ1pUSHJvdkFYVUhLcmxu?=
 =?utf-8?B?Vmg5TmttK0V5ZlBna1VjMkxjM2M1WFl1bWRkbEdtcitiVGMxY09yYWNHTEtk?=
 =?utf-8?B?d0Zoc0t5djhvSE9qdlQyQXNHdmVzTWR5UEZJbXJiMm9MYkwwMG1Ia0tndnVV?=
 =?utf-8?B?ZXpaalV2endXVE81ZkgraDU3UXVCR0wzWmdGcWgwcXNHdWhKLzZ4QmR1dXph?=
 =?utf-8?B?TDJPNmlXYndBNGZybFYwcWNrTmxQVXlreWNuZHN5WXV5VHV0RjloVS85djgr?=
 =?utf-8?B?V2VTNUxGQWxrK29qWEYwUFZ4NzY2V2FVOVFxdkIvWjdySFdpM0s1NWd0S0lM?=
 =?utf-8?B?d2lLVWRHeEhhelEwdXlnTFZIbFE5QnhtL3RPOEpFWG91UVJ6T240ZWZ1TVZF?=
 =?utf-8?B?NnUreis1bVFCSE9jOFUrbzNWaEsraEZFTXNRdzE5ZXpVZ1F6UG9jNVJUUXVt?=
 =?utf-8?B?TE91dnkrTEx0STgraTJvY0pkdkl6eUZnbkVZZnd2U1huUEZxcGFyYmxOYUlG?=
 =?utf-8?B?M1JPK0h6RnVGWEpRL1d0cyt1eWFlT2F1VW54MmtLK1dZOWlqRkM0SWdYcWQx?=
 =?utf-8?B?RnFtbkc0bksyZ3ZLMTBqeUYwN2sxa2o1cVVNRFpPVnluSHJySGR4aGpRMVZm?=
 =?utf-8?B?N3krM1BpdWNBQWFiVnZlUEpxcnRUZ0lYcEErT1F0L2R0elBBQTU3d2J4SU9j?=
 =?utf-8?B?MGNwME9SM094YSt6WXpMdHdFbDR5NFpEOVRia1o4cGRkazhJWXAzYUZpQzcy?=
 =?utf-8?B?L3pTY3haNFB6VVY5dXhEbGR6bGw0NXk1VUFpbytuUEtvTW45Sk5CT004c1VL?=
 =?utf-8?B?VVU1dmhKMzNBWXUwSy9hWHZ2NHFoeGtoUnI4a1Axa1dyOUhoTS8rdUc3aWRH?=
 =?utf-8?B?U212bWpxL1VNaFJBWmx2bjFPVi9DK2huWlVFU1p2VmRmWjJwbTlEcmNRdEZj?=
 =?utf-8?B?alhRWHYwN2NGQkNSSVl2UGZMczBFaU50NFlDTEhkV1Z3RGZvbTJjWXZoSlJO?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffea343-ba74-44e8-b1aa-08ddb90f6f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 02:23:29.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAAl2SIRs6yzgwK6UICcEbjfD2+8yfb/GF0WzFF5iPwQxC8kUhI86y2cXiWYuNPAuFu8Y52VGIxeLDVtBXlOxGhf5007BgIQBZlLLSEwRSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKdWx5IDIsIDIwMjUgMTI6MzEgQU0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPk9uIDA3LzAxLCBTb25nIFlvb25nIFNpYW5n
IHdyb3RlOg0KPj4gSW50cm9kdWNlIHRoZSBYRFBfTUVUQURBVEFfU0laRSBtYWNybyB0byBlbnN1
cmUgdGhhdCB1c2VyIGFwcGxpY2F0aW9ucyBjYW4NCj4+IGNvbnNpc3RlbnRseSByZXRyaWV2ZSB0
aGUgY29ycmVjdCBsb2NhdGlvbiBvZiBzdHJ1Y3QgeGRwX21ldGEuDQo+Pg0KPj4gUHJpb3IgdG8g
dGhpcyBjb21taXQsIHRoZSBYRFAgcHJvZ3JhbSBhZGp1c3RlZCB0aGUgZGF0YV9tZXRhIGJhY2t3
YXJkIGJ5DQo+PiB0aGUgc2l6ZSBvZiBzdHJ1Y3QgeGRwX21ldGEsIHdoaWxlIHRoZSB1c2VyIGFw
cGxpY2F0aW9uIHJldHJpZXZlZCB0aGUgZGF0YQ0KPj4gYnkgY2FsY3VsYXRpbmcgYmFja3dhcmQg
ZnJvbSB0aGUgZGF0YSBwb2ludGVyLiBUaGlzIGFwcHJvYWNoIG9ubHkgd29ya2VkIGlmDQo+PiB4
ZHBfYnVmZi0+ZGF0YV9tZXRhIHdhcyBlcXVhbCB0byB4ZHBfYnVmZi0+ZGF0YSBiZWZvcmUgY2Fs
bGluZw0KPj4gYnBmX3hkcF9hZGp1c3RfbWV0YS4NCj4+DQo+PiBXaXRoIHRoZSBpbnRyb2R1Y3Rp
b24gb2YgWERQX01FVEFEQVRBX1NJWkUsIGJvdGggdGhlIFhEUCBwcm9ncmFtIGFuZCB1c2VyDQo+
PiBhcHBsaWNhdGlvbiBub3cgY2FsY3VsYXRlIGFuZCBpZGVudGlmeSB0aGUgbG9jYXRpb24gb2Yg
c3RydWN0IHhkcF9tZXRhIGZyb20NCj4+IHRoZSBkYXRhIHBvaW50ZXIuIFRoaXMgZW5zdXJlcyB0
aGUgaW1wbGVtZW50YXRpb24gcmVtYWlucyBmdW5jdGlvbmFsIGV2ZW4NCj4+IHdoZW4gdGhlcmUg
aXMgZGV2aWNlLXJlc2VydmVkIG1ldGFkYXRhLCBtYWtpbmcgdGhlIHRlc3RzIG1vcmUgcG9ydGFi
bGUNCj4+IGFjcm9zcyBkaWZmZXJlbnQgTklDcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTb25n
IFlvb25nIFNpYW5nIDx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3hkcF9tZXRhZGF0YS5jIHwgIDIg
Ky0NCj4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRh
LmMgICB8IDEwICsrKysrKysrKy0NCj4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z3MveGRwX21ldGFkYXRhLmMgICAgICB8ICA4ICsrKysrKystDQo+PiAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3hkcF9od19tZXRhZGF0YS5jICAgICAgICAgfCAgMiArLQ0KPj4gIHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfbWV0YWRhdGEuaCAgICAgICAgICAgIHwgIDcgKysr
KysrKw0KPj4gIDUgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2df
dGVzdHMveGRwX21ldGFkYXRhLmMNCj5iL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL3hkcF9tZXRhZGF0YS5jDQo+PiBpbmRleCAxOWY5MmFmZmMyZGEuLjhkNmMyNjMzNjk4
YiAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3Rz
L3hkcF9tZXRhZGF0YS5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z190ZXN0cy94ZHBfbWV0YWRhdGEuYw0KPj4gQEAgLTMwMiw3ICszMDIsNyBAQCBzdGF0aWMgaW50
IHZlcmlmeV94c2tfbWV0YWRhdGEoc3RydWN0IHhzayAqeHNrLCBib29sDQo+c2VudF9mcm9tX2Fm
X3hkcCkNCj4+DQo+PiAgCS8qIGN1c3RvbSBtZXRhZGF0YSAqLw0KPj4NCj4+IC0JbWV0YSA9IGRh
dGEgLSBzaXplb2Yoc3RydWN0IHhkcF9tZXRhKTsNCj4+ICsJbWV0YSA9IGRhdGEgLSBYRFBfTUVU
QURBVEFfU0laRTsNCj4+DQo+PiAgCWlmICghQVNTRVJUX05FUShtZXRhLT5yeF90aW1lc3RhbXAs
IDAsICJyeF90aW1lc3RhbXAiKSkNCj4+ICAJCXJldHVybiAtMTsNCj4+IGRpZmYgLS1naXQgYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj5iL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy94ZHBfaHdfbWV0YWRhdGEuYw0KPj4gaW5k
ZXggMzMwZWNlMmVhYmRiLi43MjI0MmFjMWNkY2QgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj4+ICsrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy94ZHBfaHdfbWV0YWRhdGEuYw0KPj4gQEAgLTI3
LDYgKzI3LDcgQEAgZXh0ZXJuIGludCBicGZfeGRwX21ldGFkYXRhX3J4X3ZsYW5fdGFnKGNvbnN0
IHN0cnVjdA0KPnhkcF9tZCAqY3R4LA0KPj4gIFNFQygieGRwLmZyYWdzIikNCj4+ICBpbnQgcngo
c3RydWN0IHhkcF9tZCAqY3R4KQ0KPj4gIHsNCj4+ICsJaW50IG1ldGFsZW5fdXNlZCwgbWV0YWxl
bl90b19hZGp1c3Q7DQo+PiAgCXZvaWQgKmRhdGEsICpkYXRhX21ldGEsICpkYXRhX2VuZDsNCj4+
ICAJc3RydWN0IGlwdjZoZHIgKmlwNmggPSBOVUxMOw0KPj4gIAlzdHJ1Y3QgdWRwaGRyICp1ZHAg
PSBOVUxMOw0KPj4gQEAgLTcyLDcgKzczLDE0IEBAIGludCByeChzdHJ1Y3QgeGRwX21kICpjdHgp
DQo+PiAgCQlyZXR1cm4gWERQX1BBU1M7DQo+PiAgCX0NCj4+DQo+PiAtCWVyciA9IGJwZl94ZHBf
YWRqdXN0X21ldGEoY3R4LCAtKGludClzaXplb2Yoc3RydWN0IHhkcF9tZXRhKSk7DQo+DQo+Wy4u
XQ0KPg0KPj4gKwltZXRhbGVuX3VzZWQgPSBjdHgtPmRhdGEgLSBjdHgtPmRhdGFfbWV0YTsNCj4N
Cj5JcyB0aGUgaW50ZW50IGhlcmUgdG8gcXVlcnkgaG93IG11Y2ggbWV0YWRhdGEgaGFzIGJlZW4g
Y29uc3VtZWQvcmVzZXJ2ZWQNCj5ieSB0aGUgZHJpdmVyPw0KWWVzLg0KDQo+TG9va2luZyBhdCBJ
R0MgaXQgaGFzIHRoZSBmb2xsb3dpbmcgY29kZS9jb21tZW50Og0KPg0KPgliaS0+eGRwLT5kYXRh
ICs9IElHQ19UU19IRFJfTEVOOw0KPg0KPgkvKiBIVyB0aW1lc3RhbXAgaGFzIGJlZW4gY29waWVk
IGludG8gbG9jYWwgdmFyaWFibGUuIE1ldGFkYXRhDQo+CSAqIGxlbmd0aCB3aGVuIFhEUCBwcm9n
cmFtIGlzIGNhbGxlZCBzaG91bGQgYmUgMC4NCj4JICovDQo+CWJpLT54ZHAtPmRhdGFfbWV0YSAr
PSBJR0NfVFNfSERSX0xFTjsNCj4NCj5BcmUgeW91IHN1cmUgdGhhdCBtZXRhZGF0YSBzaXplIGlz
IGNvcnJlY3RseSBleHBvc2VkIHRvIHRoZSBicGYgcHJvZ3JhbT8NCllvdSBhcmUgcmlnaHQsIHRo
ZSBjdXJyZW50IGlnYyBkcml2ZXIgZGlkbid0IGV4cG9zZSB0aGUgbWV0YWRhdGEgc2l6ZSBjb3Jy
ZWN0bHkuDQpJIHN1Ym1pdHRlZCBbMV0gdG8gZml4IGl0Lg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L2ludGVsLXdpcmVkLWxhbi9wYXRjaC8yMDI1MDcwMTA4MDk1
NS4zMjczMTM3LTEteW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20vDQoNCj4NCj5NeSBhc3N1bXB0
aW9ucyB3YXMgdGhhdCB3ZSBzaG91bGQganVzdCB1bmNvbmRpdGlvbmFsbHkgZG8gYnBmX3hkcF9h
ZGp1c3RfbWV0YQ0KPndpdGggLVhEUF9NRVRBREFUQV9TSVpFIGFuZCB0aGF0IHNob3VsZCBiZSBn
b29kIGVub3VnaC4NCg0KVGhlIGNoZWNraW5nIGlzIGp1c3QgZm9yIHByZWNhdXRpb25zLiBObyBw
cm9ibGVtIGlmIGRpcmVjdGx5IGFkanVzdCB0aGUgbWV0YSB1bmNvbmRpdGlvbmFsbHkuDQpUaGF0
IHdpbGwgc2F2ZSBwcm9jZXNzaW5nIHRpbWUgZm9yIGVhY2ggcGFja2V0IGFzIHdlbGwuDQpJIHdp
bGwgcmVtb3ZlIHRoZSBjaGVja2luZyBhbmQgc3VibWl0IHYyLg0KDQpUaGFua3MgJiBSZWdhcmRz
DQpTaWFuZw0KDQoNCg0KDQo=

