Return-Path: <linux-kselftest+bounces-22848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD59E4BDC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 02:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E75284CEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27F12C530;
	Thu,  5 Dec 2024 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1+6IRNb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083F47A73;
	Thu,  5 Dec 2024 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362585; cv=fail; b=MBUCdkWSsOKf/Lxx+CE7bW+bLjY7/xq1+XJeh5W4MoHrj/soW0xYMIOfrat9ToGdiG83cAzR9SPvhjGw5lx+WKVTJtgzfJXqxXNQRpgc+uhFcTwQ7IXBT05sDczst6G2HEENnNiTm/te+8bLhsydNruKHOXtWoaOsXCJqbBd0aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362585; c=relaxed/simple;
	bh=dN13CBzxueDOky4WLhizFySpnaWbTh360ujkxfl5G/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tND+iyyJ3j5gRwGjtTl4JgmwCe2bXBOH5/yCuRvOTy73D1O6dMxLPMywANTOAkWWpYWcdrvZ7CILnh6DTgAxrqACIDooBXGSi0K32nagkOiCIshBLVB4cx0Lqf9+uBowHOFzcvzPJITinVNL2bX9AryMFDNTGlW+T3/GHJW6QaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1+6IRNb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733362583; x=1764898583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dN13CBzxueDOky4WLhizFySpnaWbTh360ujkxfl5G/k=;
  b=D1+6IRNbDk2pjal+J9Ast5DqlfXNlAyJblJC/pOmcUg9RjCBC58E8ABn
   gDyIJA1DTA6yQgTZldLPvHf8X2Xh/GU2D+U8mZ0e4xkgXDW8Vpa0B7lTp
   YGC1dDuL8fM4Q6lsErarcI3qOdbkTMYDlxRYUqiZ0i6dmg3IVLfjAIJrB
   D8zI+NkGG5U2ENszYtOaUZpawx1+c4nKn9bMF6re7gkaBUyDt2SckOo4+
   CYes786iS10vMJZxKaeTULBM23FuFMim3do1w4wwc+Oe2FYw+UlNOM8dW
   dMWxnPoC2yISe77qDW77lAnrPAeaJJuq/m02hPtsrNaP+FA/RvLOKkaZp
   Q==;
X-CSE-ConnectionGUID: 5aS0HczpQQSr2CcxJji4Fw==
X-CSE-MsgGUID: 4Hd9kH5ETbSP89++/ej5pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37320384"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37320384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:36:23 -0800
X-CSE-ConnectionGUID: El7gaKbWThCxS51a6IOdzg==
X-CSE-MsgGUID: cpYHlwt2SbSpgx5Kxb8NIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="94406749"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 17:36:22 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 17:36:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 17:36:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 17:36:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5xvt6v3HpZWv8Nvl8u/j4K9hYaBBtpHRgFo9V0UUJw9dRg2LYczhh0tXffNTYSLskBcahUe3PNYmS/+L//2n8cCZCQ/FtjT4Hyh8XaHQcYggf7LucyhO2TW4aLeL51iFHfcl5HcjQUtKLZlFKpYla9OSAH4OccFgVqw7EO0IIpfZ2NJPEtQCG2sMv4KcK5OZSwlZXI1klRvltJyd8cTsY37VTsPNgz8ooJqFUm1RIdUhpcAFVmXBy7B8ATcBee2eEmz8FJ1mM7ACq3t+fJchaFHz3rnxBHSIoa61u/SjjJaa3VR1SJTBpbNpBu0lWykS/DjcKwNKvx6kseVCXAm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN13CBzxueDOky4WLhizFySpnaWbTh360ujkxfl5G/k=;
 b=yplxGVPgtEuwZI4wOSz5P5qKTtluf3Sdxnm7+022Zp87+PNDRPGqNBAVowB0g1T1ESWclblz4qJBDrD2JO1bHVwamqsu+FFz/UOFxQZMwhsev2Y+BqwCUp1cCpswyt1ZDyw+97mXQMUntmckuImvOV2Eq9s4s6+BYwDy6wQI7tn9G2ZcTxlecXoJNWjMN4cZb7j656OY7C3MBf6vffmF75t3XbF0pHQ1TjtT3OnYotC3Ut1LE87PWEDWpt57DNHrSC8nAraFzIxmJgIINc1TUFFVMcP3cm/DRSAFzwMBKs9j2RsP1TgGYN865kxi4hWD4rp237cvcyUl0+AIKVNcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Thu, 5 Dec 2024 01:36:17 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 01:36:16 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf-next 1/1] selftests/bpf: Enable Tx hwtstamp in
 xdp_hw_metadata
Thread-Topic: [PATCH bpf-next 1/1] selftests/bpf: Enable Tx hwtstamp in
 xdp_hw_metadata
Thread-Index: AQHbRkPL/loT18FNKUmywfqDQg2zHrLWO2yAgACXcpA=
Date: Thu, 5 Dec 2024 01:36:16 +0000
Message-ID: <PH0PR11MB58309455A6E72493687D0515D8302@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20241204115715.3148412-1-yoong.siang.song@intel.com>
 <Z1B50w1jzHFt-LuA@mini-arch>
In-Reply-To: <Z1B50w1jzHFt-LuA@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: 43b25da8-d059-4589-e5a7-08dd14cd3653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TzFoUy9CU2U1VjAxMjdKYzVSUlpLVWNrSEtlR01BQTBQbTQ4ZkJkMndMRC8y?=
 =?utf-8?B?OWdBL1JrSGNZMm5ubTBCaDJEbHRTZlp6blpoZkpBZllmeGl6QUtlVlVaMXhT?=
 =?utf-8?B?UUgxYTlHVjRsa2syWEMxNkRTVWhlNHREQmdPSFRNMDFpTUdicWV3MCtjYVN4?=
 =?utf-8?B?SE4zOGZTQVkvZE5ZcUYzV2g0YWtQZlFRRC9hM0xCQXE4clhkQkVadnBURmFP?=
 =?utf-8?B?Y3k4ajYyM1dYWEkyUkh0NGIrRDc5Z3YzUExHckZQS2ZIblFqSDlLMTJzVFMx?=
 =?utf-8?B?UkE1OUpqd21ya202cEtDUUZITCtsTnNNN1NSRkQ4SmZVYWlKRDYxZmJTR0N1?=
 =?utf-8?B?Sko2bW9rMk5yenVHMzFBQkowOEk3MUJVcER2SnZyekhvc1NtRE42TEl5TGtT?=
 =?utf-8?B?L2tEa3hWb1QvdW5seENydnR1VUVRRXFRaFBHd2V4RjVNRktkWVBMcVlucTNJ?=
 =?utf-8?B?RmRBY3d0aFp1ck1tdjZURkxPVXRiMzJLT1VvVDdFRjhOaWNyZFpaWFdUelpm?=
 =?utf-8?B?RnlweFlUVEVoRGR4QUxsSGE1NGhPeWU2UUczUnFlNVIwS2JHeWJkMGhlM3Vy?=
 =?utf-8?B?VWdHeXNob0h4c2o0bzA2QnBSZ29HajhvSUpPOGxDOUZ1MXFSb3JrSE93QUxE?=
 =?utf-8?B?eVorQzNUSkJSbC9nOXlkSGh1bVp1dlN1NVQydDgyRjZRODlldVVHVnU0Vy9C?=
 =?utf-8?B?Qll0ZUZEbDQ2TFZ2TW1YdDVTekFpcURXT3liNGdQeGdVWjlhbm05L0hzc0F1?=
 =?utf-8?B?YmRoZXlzSFJUWE55b282TzNENmhCdDYwV1NJKzd2OC9lOVFmMUFUaGdQME1i?=
 =?utf-8?B?cnZWRWVvb1FzWmQyNzdlR09jbWxRaVUxTExQS1BsczhUQkFNWE1XK0lVSFEv?=
 =?utf-8?B?UFFua2dSeEhzNEJhNC9kQStOSWtkWmMrclh0aXRmYkVOaUFwZXNEakg3ZDFY?=
 =?utf-8?B?RW5hc3R1RFMwcFdTOVJjWGF0U1VYYW9paktXK1lKRjdtUnZuZmcxb3VoNlN3?=
 =?utf-8?B?ZHJIWndoQ05ERnRXZFFaKzhUNGo2ZkxSVFdpcUExa1BrZkpuSWEwcERrdjR6?=
 =?utf-8?B?c2ptdUxGMmcvV1NNa1ZMRXhHblg2bFRXZi9YeDJqQkdrYjRKZXkvRFh0aklx?=
 =?utf-8?B?S0ZTa2hPSUVndVFxVXpLUFRwdmc5UFhYSGtOdlRYTDhtcjJVR0p1VzRMLzZw?=
 =?utf-8?B?aWF1MlpPQ1N4YW5qSWtIblY0ak1SM0ROYS8xTUd5UkRueXRZSE9mL2tOaHJO?=
 =?utf-8?B?c1B3MURScklIWUJJUHcxSytUbk1LYjFxYyt6TC9oQzErSm9Oa3pQTDRWcTdJ?=
 =?utf-8?B?NmlyQjljQ1FLWXBWamN1b0RPMFFjakIyR0hkRU8veHNuQXMzcjF0Y1N3Q1lJ?=
 =?utf-8?B?N2M1VFJWUzMzclhPa2FSYVJINENMYyszVWc0TDhYL3hGZVJHcTUzNWl2L3Ez?=
 =?utf-8?B?MFRoUDRTYXJhSkZhaGpIOWZPcGRRMVg2SXMwR0R5anNPeDZ4OVBTaWkyS1JH?=
 =?utf-8?B?WGVva1Bqc0F0TG5WRmg1ZGJnSTI3eFRPUlVnRnF1cS81dGdPUWF1U1dSQzR3?=
 =?utf-8?B?WVRjNFdUOTljSUtvMzdjbnNBaTJNRWJ3T3lVeGR1akNsSVlFeGo4Vjc3Q3VI?=
 =?utf-8?B?MC8vWlZoaGpzUWpaUWxRaXVHVnVlR3RWS3hRN3FrZUFuMktncnoxTDNPUGpQ?=
 =?utf-8?B?N2FwY2R6WDNqeEhwL205UWdxZ2tJc2s5SWRsSDNISndKa2xQNWs0VVRDYXhW?=
 =?utf-8?B?TEtmNUdLOGhMQ2ZVekZxd0pQdmhoME1sV0tTQzdqSTZneENQNk5aMy9xODBr?=
 =?utf-8?B?YUwrNTJXNHpMbG9ZSG4rUjhMUmZqWWJLV0lLWTFHNmhMRFRGZllheFVaVGRF?=
 =?utf-8?B?RmlINy9VRHp6WXF2czBOVTlXbU9yNEFkTlFuUUlNaTNMVkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z21DalZiMnNlcTkreDZEVnUxZVowY0lGUjZ0Mms2TjVEbkkvUWthQmNwSUh4?=
 =?utf-8?B?ODZ3dmdtRk5ZT3FyRElFeWV1UHRzbjNyZ04rNFlIMXBaa0o1MnZ2K05QZ2kv?=
 =?utf-8?B?V0ZLZ3AyN0VQTWR4S1p3WEp3R3YyR015Z0VXUDZhY2N1Um44ZmNtRm9kUStQ?=
 =?utf-8?B?b2svQ3RDcFluOEJhSVJEL3lWdEl1UUlsc3lYNExVbDU2dTJtMmlRZk5ZRnIy?=
 =?utf-8?B?YnlXZGQxUCtESHRqN1pCUkhVZ1NYb0JxN3lVMEIxak5XT2xBamd5dVUxeUY5?=
 =?utf-8?B?cGRUb2xSUWdMbEV1azIraVhzQ01TN1ZPeldlRUFWV21LMVpHMzJsQ2lTbkw4?=
 =?utf-8?B?d2RDZnBVekx2Q0ZjeE0vbElMUjBXM1E5LzlRNDN1cWpLeERFL2xPakdMVGpj?=
 =?utf-8?B?ajdHOW1zUXV4MU1YZjkwTHJ3NGI4bUdSR3UvSlVUM2Z1b1gzODM2amgzTHRI?=
 =?utf-8?B?emRhaGdzWnRnS3dJZS9US1RCaEUxL08xMlVUUG5zWC9uZDJFeUZzYmFjUEpE?=
 =?utf-8?B?M1VybTJscFlCdlJ6K0hMeE1oODNINGQwRG43bE9kZ3hNcXZqYmF1UnROWTRh?=
 =?utf-8?B?RjQwVWNPRFRZOU9TTlZ4Tjd5dEplcjAxbWZFQ0VWUHY2alNCRmpTeW5HRldP?=
 =?utf-8?B?ZFQyMzdaanZaMEt6YkVFcWZZMDVoRWtXZEYxbHBrV2JYVUdZMjVKZEplVGpU?=
 =?utf-8?B?c0dpVjAvaXp1cUFqcGVjL2dGREF2T2lzSlpxdERwS1k3OTZMeEVFcTc4S21F?=
 =?utf-8?B?S3JyNjc3blc0NFBmMUtLbVpPTmVuM09PU29aM1AvNVRYOFU4RjJObUwvNS9k?=
 =?utf-8?B?OVUzM2dQVmJTOGlkNFg2THBmdWJxZjA3V3h6MmVNYmVGbVBRajFpZWV5WnJt?=
 =?utf-8?B?R1AzRU1ieDJBOFQ0WVVSWGZiai9RSmxvb2hUU0VuSys3V01JRjNIWVpQSy91?=
 =?utf-8?B?L0xNNFBWSmEwL0xuUjAydVRvUXZ0N0MzYUpUeFc4eTh0Y3RvY1oyd2wxVnpN?=
 =?utf-8?B?aTB6MkNUY0VFTEVpRzB4VmlKRzB2a2l4Y2hGclNrK2U0VlRVSU5jMjNGSlRv?=
 =?utf-8?B?cEVreGVUSFZaRitDQjYvYWdxZ0x5OWY0dzJJYnhwaXE4Y2FCZnpncWlDZmdO?=
 =?utf-8?B?UVA4VVJLRnB3U05SZElYOWxXT1dpNTVoSTlINVlqWlFjOEZsRGVraWdHaEJ4?=
 =?utf-8?B?M1hGdEoweWN3UHk4VXlHcW43NksvRHIzUUg1VE9CQnZNUzcvYVliUjlQclpj?=
 =?utf-8?B?MjVoU1FUS3dKS2xTWnhxbTl5RDQ1b0hFeUlDdEFJWHFhaWhLSWU3aHlzMDFq?=
 =?utf-8?B?Wlc5MUVvWXo4SndaR1BpZnNGZkpPVitTTCs5aDZjT0VzRG1MbnBnV29oZG43?=
 =?utf-8?B?c2paNkdYTE0yWU5jVjErVjAwbnBpYnF1MHZKY0NFK29FTFRRSWhzdjBlWHBa?=
 =?utf-8?B?dzhNczlyRE5Kbm4yRmlwWGp6aFFMbU45MlA2UlBlTzY2ZUNYeVRPNHRSS3RZ?=
 =?utf-8?B?RlJlKzlMWVlTVnNCV0NxbEQvdHpRN3hDT0xscWpYMFhoYXhudE1qNnRqNC9s?=
 =?utf-8?B?ZkZJUW9XRTFNeHpwbXdiSFBIR1RHZEtadVcrbmQzMUttWHU2UjhsNW80Unpv?=
 =?utf-8?B?d1Qxa1Y4MmIrL3Y4QU43OTlTWHJaQWNNeUhQL0p1N3lMTjkyYlhDV2VBTG94?=
 =?utf-8?B?bTVKNFViZlJqYnpIMlVaMmE2bk5HRmh4SjdvYXlUYVBndDdzc3lkV3BFakdr?=
 =?utf-8?B?ZnRReTlUUmRhSGQ3WC83SWJqcGN0THlYMGpPOFRvcjBheDkwSGR1amZYVldp?=
 =?utf-8?B?MTh1ZEZFU0pKSnY0SWQ5ZDkrNG95N3FJcm9OUW9YYTBselZBNVhXRnVqR05E?=
 =?utf-8?B?UUtNQy9QZ3hwdmJBanVLbXI1ejJzSVoySzNLTlorelJWL1NUYU9JdVVXQnkx?=
 =?utf-8?B?Mkp4UWlsdGRkNkNwSUxBQ0VTMXo1YjNIQVo3MlR3SGxLRXRIbDl4OGVkeEhr?=
 =?utf-8?B?RWZvSkVsN1k0dmFpK3hqYTMxY3V5cDR5U3lzQTQrZ2tyNm01TWZiK2N2TVFv?=
 =?utf-8?B?RGVwQTJ3SVNsRU9GTWZRWXJObThmcmt0dDdOMGhoeFNSd3Fobm4wdk5mZERa?=
 =?utf-8?B?WnFndDBmWUhtMk9JNUk4UVhUT1c1T3FqaXVOVTIyTTI4amZJTjRWTXJpM2pl?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b25da8-d059-4589-e5a7-08dd14cd3653
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 01:36:16.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gk8Haqhsgpbggl86MLXPztmmwmWqc/plIYcw3GBJudLKezUJDJUhDrpqyJem1WOYMejIX7sLb9cwz7xkW9hfrS4gy3ahr/t2X1I//03w9G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBEZWNlbWJlciA0LCAyMDI0IDExOjQ5IFBNLCBTdGFuaXNsYXYgRm9taWNo
ZXYgPHN0Zm9taWNoZXZAZ21haWwuY29tPiB3cm90ZToNCj5PbiAxMi8wNCwgU29uZyBZb29uZyBT
aWFuZyB3cm90ZToNCj4+IFNldCB0eF90eXBlIHRvIEhXVFNUQU1QX1RYX09OIHRvIGVuYWJsZSBo
YXJkd2FyZSB0aW1lc3RhbXBpbmcgZm9yIGFsbA0KPj4gb3V0Z29pbmcgcGFja2V0cy4NCj4+DQo+
PiBCZXNpZGVzLCBzZXQgWERQX1VNRU1fVFhfTUVUQURBVEFfTEVOIGZsYWcgdG8gcmVzZXJ2ZSB0
eF9tZXRhZGF0YV9sZW4gYnl0ZXMNCj4+IG9mIHBlci1jaHVuayBtZXRhZGF0YS4NCj4NCj5YRFBf
VU1FTV9UWF9NRVRBREFUQV9MRU4gaXMgbWlzc2luZyBhZnRlciBkNWU3MjZkOTE0M2MgKCJ4c2s6
IFJlcXVpcmUNCj5YRFBfVU1FTV9UWF9NRVRBREFUQV9MRU4gdG8gYWN0dWF0ZSB0eF9tZXRhZGF0
YV9sZW4iKSwgc28gdGhhdCBtYWtlDQo+c2Vuc2UuIE1heWJlIGFkZCBhIGZpeGVzIHRhZz8NCj4N
Cg0KU3VyZS4gSSB3aWxsIGFkZCB0aGUgZml4ZXMgdGFnIGFuZCBzdWJtaXQgd2l0aCAiUEFUQ0gg
YnBmIiBwcmVmaXgNCmluIG5leHQgdmVyc2lvbi4NCg0KPkFuZCBJIGRvbid0IHNlZSBtbHg1IGxv
b2tpbmcgYXQgSFdUU1RBTVBfVFggYW55d2hlcmUgaW4gdGhlIGRyaXZlcnMsDQo+c28gSSdtIGFz
c3VtaW5nIHRoYXQncyB3aHkgSSBkaWRuJ3QgbmVlZCBIV1RTVEFNUF9UWF9PTiBkdXJpbmcgbXkg
dGVzdHMuLg0KPldoaWNoIGRldmljZSBhcmUgeW91IHRlc3RpbmcgYWdhaW5zdD8gSSBkbyBzZWUg
c29tZSBod3RzX3R4X2VuDQo+Y2hlY2tzIGluIHRoZSBzdGZtbWFjIGF0IGxlYXN0Li4uIENhbiB5
b3UgYWRkIHRoZXNlIGRldGFpbHMgdG8gdGhlDQo+Y29tbWl0IG1lc3NhZ2UgYW5kIHJlc3Bpbj8N
Cj4NCg0KSSBhbSB0ZXN0aW5nIG9uIHN0bW1hYyBhbmQgaWdjIGRyaXZlcnMuDQpZb3UgYXJlIHJp
Z2h0LCBzdG1tYWMgbmVlZHMgaXQgZm9yIGh3dHNfdHhfZW4gY2hlY2suDQpCZXNpZGVzLCBpZ2Mg
bmVlZHMgaXQgdG8gc2V0IElHQ19SSU5HX0ZMQUdfVFhfSFdUU1RBTVAgZmxhZy4NCg0KV2l0aG91
dCB0aGlzIHBhdGNoLCB1c2VyIHdpbGwgbmVlZCB0byBtYW51YWxseSBlbmFibGUgdHggaHd0cyB1
c2luZw0KY29tbWFuZDogc3VkbyBod3N0YW1wX2N0bCAtaSBldGgwIC10IDEgLXIgMQ0KYWZ0ZXIg
c3RhcnQgeGRwX2h3X21ldGFkYXRhLg0KDQpUaGVyZWZvcmUsIGFkZGluZyBIV1RTVEFNUF9UWF9P
TiBpcyBub3QgYSBidWcgZml4IHNvbHV0aW9uLg0KSSB3aWxsIHNlcGFyYXRlIHRoaXMgYXMgYW5v
dGhlciBuZXcgcGF0Y2ggdG8gIlBBVENIIGJwZi1uZXh0Ig0KYW5kIHByb3ZpZGUgZGV0YWlsIGlu
IGNvbW1pdCBtZXNzYWdlLg0KDQpCdHcsIGlzIG1seDUgZHJpdmVyIGFsd2F5cyBlbmFibGUgVHgg
SFdUUz8NCg0KPldpdGggdGhlIGFib3ZlIGFkZHJlc3NlZDoNCj5BY2tlZC1ieTogU3RhbmlzbGF2
IEZvbWljaGV2IDxzZGZAZm9taWNoZXYubWU+DQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQoN
Cg==

