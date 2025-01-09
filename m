Return-Path: <linux-kselftest+bounces-24108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED33A06EEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71957A084D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20160201039;
	Thu,  9 Jan 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJGNh7qp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A71474A9;
	Thu,  9 Jan 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407176; cv=fail; b=PeCiVyAuWrYkj1lb+LI5RZcW7hdDwEVry1ubOn+CNLL5uyNr2m/DG6ndLEsADf62EpZsXMubznUjFxVKO80sZsr435u0BvYVSW0SGhIc4opahT4vxkENaEt3GSzgtP67S6gMplS2vFgqqw+s+BqokEomSriwaLnxHwCB6K2rrJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407176; c=relaxed/simple;
	bh=k6s7blhLaUfC+O5ahIz8LO/JFcw1Wi+UBmoRM1ujZlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loba0uWuickufifcPgcDwvjtPWfFmAttnENTX8uJ4ZCO67T3yJUhIzF86+RFjHTnFJ7yYWxeunV8ZpQtn2GBmV5UlMn2KqbYf7x/N0mgoeKSbuBt4sAlyJmyofVkegEpHy4KbEClWB6al8ePoMAqmO9cwkXigA0OVc9yUdxBsvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJGNh7qp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736407173; x=1767943173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k6s7blhLaUfC+O5ahIz8LO/JFcw1Wi+UBmoRM1ujZlA=;
  b=AJGNh7qph/kPaZAvgCcGuI/CJ9jeA+qHOgz9Xb0+NQI2AUhP3jEe2nws
   9lGN+fRpyetHFnos9LSwC7ohN22xycWk1EGfQmni6Vc/IO2oB2hwyay4F
   WoY1Q6tqiECfFCiREYCmonSwEJO1PrZs4Zm3uTfdCL6hmqYFzCGXlKSdu
   viBXNDltkKnQ7Y54VsKlGW3s27+EHciPRN0v9L6nrljHogIYDUFoP4PMK
   Y6sp4s52CGCiRj7ycUIxUgeVcu03Hn0x0La07CmeluDWWHs+7GDZSoQCB
   55ITy95yCJgxz+vmGf+/dbE3APyQ+cFkh5ybUoBTHZPMvZP9Cp6q+Uzwq
   w==;
X-CSE-ConnectionGUID: YDpQvEJhQT6WTxf4it2kLw==
X-CSE-MsgGUID: xLCRVDBVSMKChHehOEOMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47321519"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47321519"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:19:32 -0800
X-CSE-ConnectionGUID: LJtmf1qdQy+UaMxFa5YnMw==
X-CSE-MsgGUID: 5RapiDxFT4SdcOaTqlqdkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107365822"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:19:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:19:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:19:29 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:19:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUzmi5jrOlK9xkJwam7Mns8llJrDXm7rD9PNPAo+l/gANNCYxOf0cvznNgio5Ml+7ABU9j8xeJvBqyMmZw/NmqKv4BYhqH4xxpekOENQ34/t995ZNf9q5OBhQmzzoli3k6TbkvFNmokey/fwMg9Rvi4AGKJxdsap7I58bJvsVu8Bwp04+G91faLWguV6V24A1y3229nEvhLFLwagHMJyF0byhZk0QY7TuiQXNmeWcjzd5xuetn4g1ri+psAKFuhWqNmLqZIVIQVIJ8Uc2D8E20MvQTbJYhLQFtYCza9inMt4IlLxSYcm33+tv3SXzISAWfs1knR5px+861h8FKzM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6s7blhLaUfC+O5ahIz8LO/JFcw1Wi+UBmoRM1ujZlA=;
 b=qkK7N7ussb+mpECj8vrShguhYRMPEBlsr7OpVqbCSQi52vF9RZQ81dw5kuUHq8uXSTglsGADrcTNnQK+xZ6HLv6UKIU1sMumVG8A2dAdVh5jB9+Jox+WYHmP83Jb7GLKKDRNBYJfcN1DNXypz8TMnfX+y9VknHxNA6FiLav+sClWSwxwp45GDe6AIZZYbsuubWUfx8afrlSrJoelub/wNcS0wOVk8IESkeZ8ENWhQEf+7NzFqW/mftsOXA6r59FBTJkgfvxZpR7CJNR67pqFO31pBu7XL9msWtkFqiGi9xvFeKLcxRAmyl2A5mbOeIekvxkSHBIXS7EwVj4UHp/T9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 07:19:26 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:19:26 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato, Joe"
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v4 1/4] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Thread-Topic: [PATCH bpf-next v4 1/4] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Thread-Index: AQHbYELJmBa3r24x8EG4EXd8V3eakLMLh+iAgAKCPJA=
Date: Thu, 9 Jan 2025 07:19:26 +0000
Message-ID: <PH0PR11MB5830D33B679A0ACD3FD6E23CD8132@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250106135606.9704-1-yoong.siang.song@intel.com>
 <Z31bQ6xEkyQvbutN@mini-arch>
In-Reply-To: <Z31bQ6xEkyQvbutN@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CY8PR11MB7825:EE_
x-ms-office365-filtering-correlation-id: 8829c4d2-185e-49ad-3c83-08dd307df2fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a2M5ZVFKRUlWYldBUlZYS0FESVRKeHNKZWwzY08wUGNwSTVUMFpEc085ZVM1?=
 =?utf-8?B?TWo3YzBkVWllTmEwUUJLeTM3NHlDWldIR0lBUkw3UGt4NjJDM2ZLdzlxVEgz?=
 =?utf-8?B?anpEWWNWRXNsSUJWTE9yRnk3Tm5GL0FPZVBhNnBadjFyS1I3LzBhVnQxbG92?=
 =?utf-8?B?MXVVWDVoYS9ZcVRvMzdyWlAxRDdmN1B4VzBUb0k2USs4MjdNMTQ4NDR2UXVN?=
 =?utf-8?B?YS82Zi83WGQ0WERFV0lYclg0KzVMTXRoUCs1ZkdkN1hVSHFTNlhqc1ZBNS96?=
 =?utf-8?B?MWcrci9mWkE0OWdXc0JFMnZuenZHSTZqS1gwWnRjN2hZa3lmcmlTYlA0eXZI?=
 =?utf-8?B?aXVqR0JreTNlOXQ0LzkwR2RVMENhYVNFUDA3YVN5UDE1ekJsQkRpNFJZa3lF?=
 =?utf-8?B?aFByQ1JWMUNsdGNQYmJtNXI0dnlRY3dnOXBkWVZlb2dhNjJST3h0Qy95S3Rp?=
 =?utf-8?B?WkdVT3FOdHExZm9aYmJ4T1YyV3BtNnFYNTF4QVZVZzV0RnRncjNnazVjanA4?=
 =?utf-8?B?V0tOcHM1ZVRJSWJqUHAwK0RNMVFOS0dqdit4L2x2d2lVbzBEdXptcjdnZStY?=
 =?utf-8?B?TDllZWJhTE5Hd0hLUUE3WkpROEppbGNyV0FnTGJ0NzhBRWdzZWVqU2RaLy94?=
 =?utf-8?B?RnlDUG0veS91OHBzY3hKUXk2dzZNcmtZR3ZYaDQxQzBtMjhhenJVb1pxYUdB?=
 =?utf-8?B?ZmhHNDZhYWRCejFlSENCMzBUUVYzRXk2NEFLME9xTE5sTnJZOHlFVyt4VzRV?=
 =?utf-8?B?Z2ZjZEVUMlZqbTVlek0rWGluYzZTZmRLUW82TTYxNVN3QkF2WHEvS3VSbjJv?=
 =?utf-8?B?aXpDcHZUU0x5dlp1U2VNWnVpem5IYnoxSkg4UXl3Zi9wOGxyYUFub2RMaCtw?=
 =?utf-8?B?cUNHTkhXQUdpaVVDcUdYUUJuUC9jaHFQM3JGaTJURkNYOFBEaXY4NE1Mb1BH?=
 =?utf-8?B?bTl6ellWV2NvdEx0RDdzRHdLcTBnM2N0U1Uva2N5RVNSVFZBRFYrMWEzRTNj?=
 =?utf-8?B?ZmJQcC81NUFEOWd5YjZabEl1eFFvSjJQTGJ0U3I4a2Q3eW8yNzY1WThDR1Vo?=
 =?utf-8?B?eVFNcEF5WEovRTVFVURDaVFPUUlrOXVLZFBEYkJjTWkyM1R2SzFVTVp6WmxS?=
 =?utf-8?B?YU1LVExrYmZyREM0TkRMTXRZRVBSOEhHeWtHWUNnNE0vWHc0R29YNGYrTEF6?=
 =?utf-8?B?dW9nWlFRZTUvS0tuZm9OVGNKNUVKemRyZXUyNkphNFdQTzhEdEZ0NCttejRK?=
 =?utf-8?B?T0JXdHhVUU5adTBvMm1HM2N0UTY1cytMWUV3UG1jZXVMTTZsdkJFVlo5N3lL?=
 =?utf-8?B?RHYySXdteng1bXhKWTRlcG9GbnV0dmVlTUlnbEJNaEdDUXpDbzIxNGZOV0xG?=
 =?utf-8?B?L0NoQmJHeVJPUTl5Y250WVpReGEzWjlrQWIwNlNTVmpxQ2d1MDdoL041QjVz?=
 =?utf-8?B?QU9WbkhPd2dGRGtZdHZxRWZ1V2REZjc2dG0wRjYrcXNUTFM2c0h3OWJBUVho?=
 =?utf-8?B?SW9GSDU5ZU5weHppNE52SzNka29IaFNKS1phWFB1MTJMRU8rWithbHM4NVFQ?=
 =?utf-8?B?RjZjNGIrZWVvUnVBUWVLdndrTHBIOVRhUnBUZjh0eDVoOFRxSUFhM0Y3Tmlr?=
 =?utf-8?B?TTFpSEFNbm5JRG5HSDBsUDhFbHhTZXpNVnlYN0JFN0p0RG1wOU1kTEEyU29B?=
 =?utf-8?B?bWZyWXQ5S0RNSVgxcEJVMzNGb2JiaWNId2M0UlJaY2dOWkpUWEZtODl4RkFt?=
 =?utf-8?B?YlQyV1dWcXliVWxJc1o0eWxmK0ZTTW1OZ2xkYk0wb01pMzNCaXd3WVlLNUdC?=
 =?utf-8?B?cGM2NHRwTHZmZHlPTVdDUHVmOFl6NytZd1JBdmJtUmtsTVBTVlZ0RENZdzdK?=
 =?utf-8?B?RlNnNXo1WXpXMTQ3SFA3aFRzMFZYNkFoaWh5RnNaeFRvS1NGSmpoNmM0enJQ?=
 =?utf-8?Q?mN4Ek9ApT6a6bmiGXf3Pv7UZE6sCw7dy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0pCdzNxWmx4TnBDQ242VG5qa0hoRk1mUVhJZ1lGMTQ5K0E2ZUZoVG82MGFu?=
 =?utf-8?B?dWxIRVhRVTNIRXVFQ1RMSHFTTmtmdlVCUEx0ZCtmbzV0eXRGUlB1d25PdjhC?=
 =?utf-8?B?d21KcWl0dTNtTklZS0tuczdMcGFkMHRwYnNLYXBVQWJGcE05bm1aWG1tZVAz?=
 =?utf-8?B?anFWbk9QN1JOalI2MElrOWkrbWtzRXBQMm9QU3d4QkVxNkJyeVdTSHpnZUN0?=
 =?utf-8?B?YmVTbGtnQm1jS210Q2ljM3lXTkpLMzVVczQ4KzJWaGpzUW9HSFdsQk0vT2dq?=
 =?utf-8?B?N0E3UCszTnVtZ1VuSVVpOGZHRkxTbllTblJhdENDMFlKNVVBV1piRllmaFpm?=
 =?utf-8?B?aGc4OTk5QytQRWh3T2RTcVJqUUplbjNQQ0k1c2MzZ21UMzBhMUE1cTdqNVBj?=
 =?utf-8?B?L1RpQjFYV0Q1endTK0dnMmFodnRWbmthZ3ZYZG44MUhIUEZ5bTMwRXcyeTly?=
 =?utf-8?B?N3FuTWlvT3ZITUZhY1d4a0pSRGdxUjhOTFM2QU5vdnBwei9aOXpVNWFLOEV2?=
 =?utf-8?B?OUxsZUxrbE9YMmJ4TUljYVBNN0Z5ZnNmcVluQ0VUU21RMUtUS1RFVDZhSmJI?=
 =?utf-8?B?OTRGeFBuczExZG5tS2VXNmdIMGVodnhGa2pXRkpZMVNhMDlBUkt2Wnd6MnlT?=
 =?utf-8?B?Wlh2aTB5clRRMTVOYlUvdTZVNzRLUTJpMG8zaEVPNFgwOUlJaGxDcVhUNEFx?=
 =?utf-8?B?aHhZcVpSVVk1Uk1sNC9reENTNTFBK3hsUWE4SnVaK3YzRWhWR1RrNVkwemRt?=
 =?utf-8?B?NlNQRlA5cngyZ0dONzdBYlJJNWdpS0hGUDRNeTFUZlM2cFgzVVg5eldBQjlO?=
 =?utf-8?B?elFFN1ZUY0VOZDc3K3laL3RLOUZxakVKSUkvUUEwZ3o0amo4eUE3OEJ5Nm05?=
 =?utf-8?B?Y1pwa1dFTlhUR1VCdTdsWUtyNXZPZVVwdUxKald6eW5yajNCbzd6UW9uTUQy?=
 =?utf-8?B?Nzhldm1nUnpYbHdlWnJYY2UwYTBJZ2JGRDNZcVltY01ONmNrbzlwa3Y0S25G?=
 =?utf-8?B?bm00OUJSZERHN290UU9DWGR3ZHh5QmRBQlV6bGpiczJYOUZwWERhS1ZRbUN5?=
 =?utf-8?B?RGgrZkoyRUpIWEJxVzNPQUxsZ1hEanRTZC9Jd2JyQVR0K0g4L2ZFVUlGWVJr?=
 =?utf-8?B?K01qYlhueFdySXZwQWw3by9RbTZ4SUE5RkNqZnpnR3R0NWxYbTJKdmsyeHdw?=
 =?utf-8?B?M0xFUWFTVnB6U3B3VFJUckVQMS8xR0lhS1VONFJtMm0xeDRRZFBrZmRQenMy?=
 =?utf-8?B?bjJEUW5haFlaYmVjU3UzY0FnTEFIQUtCL0dPcTRkVGo2WnJGRlIway9xZU1a?=
 =?utf-8?B?NC8rVk5FVjZLTlJLUzgweU9FL2V2TFdpZmp6Nys4V3JmZE1xN21uQzNBNWdT?=
 =?utf-8?B?WHhiL0NJR0dVMWdmdzMxTTBmekV1elovWVlXME1VWk1WMStvelcveXZ6em1t?=
 =?utf-8?B?WDc3Q2R4TjFkZzFRc0RSQWQ3YU9LdUhpVjdSMHZ0UXpXMUpneWxjNVM3Vmph?=
 =?utf-8?B?a3Vuem00TlI3eVk5TWkramk3d2wwdkdlVk9NK05ldnBhL0R0azY4QVo4K09I?=
 =?utf-8?B?Z1FlVXg5dDlwWEQxelRRZ1NyaDc2NTRtaXpGTWZmdStJVzhpZ3RQOEpkWEQ3?=
 =?utf-8?B?V0lPUENJdk5CNFNLYUpPUG10Nmh6MjVOeDlpeFUyMnRzTGVXYW1DQjhFd3Zp?=
 =?utf-8?B?M0lWenRSUVNmOHEzUHQ5QXRVZ3BDRTNUNjJXTU9nYWc5VEx3Sm5KaFNsWWdC?=
 =?utf-8?B?bjlUSDJGTkVaem9FQVZUYmxEMlQ2eW9taVY4YVJ3aUlBSHQ1S3g2Q2NTZXBO?=
 =?utf-8?B?QmpQRmUrUEw5WFFVdVBDME9wMkY5WnorZTVsYXBuTE9GbE9uTHFOVnNvY2pH?=
 =?utf-8?B?d204RmthSkFuOW1JbEV0ZWhhbWhwNGwyM0R3UE10UGFXMmoweXVUaVFpRmg0?=
 =?utf-8?B?QTZGOE5TTGxkVEJiNURBWUduTU1WN3c3N0t2U3BYSUlVSUFoT0RtQUcrOTl5?=
 =?utf-8?B?Q2l3b1FObFk0ZHZYVTBLTDZjdzhDaGxWWXNMN2RnZW0zcXdkaFJFZWZkVGg4?=
 =?utf-8?B?RlRaQjgyMUcyK2wybGRpNW1mSnBFQyt5Zy9mQ01ETlE1eHdVNXFRS1BKdW9j?=
 =?utf-8?B?bmhtRllabUhIT25waFdrcEl3N21IQUxMMUFwUXZQeEE0bUlEUk9wYnJQdjVx?=
 =?utf-8?B?bWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8829c4d2-185e-49ad-3c83-08dd307df2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:19:26.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqDDKLEgqxKWg6J0dBoSivwmTPRNK7+e0Mco1Bz9ssAiWUye0AF6vD+6U4yYLI9Tnl2oNJEUsQBQnyr/92/HdIme+32SyT0LilEcKmdIS7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKYW51YXJ5IDgsIDIwMjUgMTI6NTAgQU0sIFN0YW5pc2xhdiBGb21pY2hl
diA8c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPk9uIDAxLzA2LCBTb25nIFlvb25nIFNp
YW5nIHdyb3RlOg0KPj4gRXh0ZW5kIHRoZSBYRFAgVHggbWV0YWRhdGEgZnJhbWV3b3JrIHNvIHRo
YXQgdXNlciBjYW4gcmVxdWVzdHMgbGF1bmNoIHRpbWUNCj4+IGhhcmR3YXJlIG9mZmxvYWQsIHdo
ZXJlIHRoZSBFdGhlcm5ldCBkZXZpY2Ugd2lsbCBzY2hlZHVsZSB0aGUgcGFja2V0IGZvcg0KPj4g
dHJhbnNtaXNzaW9uIGF0IGEgcHJlLWRldGVybWluZWQgdGltZSBjYWxsZWQgbGF1bmNoIHRpbWUu
IFRoZSB2YWx1ZSBvZg0KPj4gbGF1bmNoIHRpbWUgaXMgY29tbXVuaWNhdGVkIGZyb20gdXNlciBz
cGFjZSB0byBFdGhlcm5ldCBkcml2ZXIgdmlhDQo+PiBsYXVuY2hfdGltZSBmaWVsZCBvZiBzdHJ1
Y3QgeHNrX3R4X21ldGFkYXRhLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogU3RhbmlzbGF2IEZvbWlj
aGV2IDxzZGZAZ29vZ2xlLmNvbT4NCg0KSGkgU3RhbmlzbGF2IEZvbWljaGV2LA0KDQpUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3IGNvbW1lbnRzLg0KSSBub3RpY2UgdGhhdCB5b3UgaGF2ZSB0d28gZW1h
aWxzOg0Kc2RmQGdvb2dsZS5jb20gJiBzdGZvbWljaGV2QGdtYWlsLmNvbQ0KDQpXaGljaCBvbmUg
SSBzaG91bGQgdXNlIGluIHRoZSBzdWdnZXN0ZWQtYnkgdGFnPw0KDQo+PiBTaWduZWQtb2ZmLWJ5
OiBTb25nIFlvb25nIFNpYW5nIDx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pj4gIERvY3VtZW50YXRpb24vbmV0bGluay9zcGVjcy9uZXRkZXYueWFtbCAgICAgIHwgIDQgKysN
Cj4+ICBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcveHNrLXR4LW1ldGFkYXRhLnJzdCB8IDY0ICsr
KysrKysrKysrKysrKysrKysrDQo+PiAgaW5jbHVkZS9uZXQveGRwX3NvY2suaCAgICAgICAgICAg
ICAgICAgICAgICAgfCAxMCArKysNCj4+ICBpbmNsdWRlL25ldC94ZHBfc29ja19kcnYuaCAgICAg
ICAgICAgICAgICAgICB8ICAxICsNCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvaWZfeGRwLmggICAg
ICAgICAgICAgICAgICB8IDEwICsrKw0KPj4gIGluY2x1ZGUvdWFwaS9saW51eC9uZXRkZXYuaCAg
ICAgICAgICAgICAgICAgIHwgIDMgKw0KPj4gIG5ldC9jb3JlL25ldGRldi1nZW5sLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKw0KPj4gIG5ldC94ZHAveHNrLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgKw0KPj4gIHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9pZl94
ZHAuaCAgICAgICAgICAgIHwgMTAgKysrDQo+PiAgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L25l
dGRldi5oICAgICAgICAgICAgfCAgMyArDQo+PiAgMTAgZmlsZXMgY2hhbmdlZCwgMTEwIGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXRsaW5rL3NwZWNz
L25ldGRldi55YW1sDQo+Yi9Eb2N1bWVudGF0aW9uL25ldGxpbmsvc3BlY3MvbmV0ZGV2LnlhbWwN
Cj4+IGluZGV4IGNiYjU0NGJkNmM4NC4uZTU5YzhhMTRmN2QxIDEwMDY0NA0KPj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9uZXRsaW5rL3NwZWNzL25ldGRldi55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0
aW9uL25ldGxpbmsvc3BlY3MvbmV0ZGV2LnlhbWwNCj4+IEBAIC03MCw2ICs3MCwxMCBAQCBkZWZp
bml0aW9uczoNCj4+ICAgICAgICAgIG5hbWU6IHR4LWNoZWNrc3VtDQo+PiAgICAgICAgICBkb2M6
DQo+PiAgICAgICAgICAgIEwzIGNoZWNrc3VtIEhXIG9mZmxvYWQgaXMgc3VwcG9ydGVkIGJ5IHRo
ZSBkcml2ZXIuDQo+PiArICAgICAgLQ0KPj4gKyAgICAgICAgbmFtZTogdHgtbGF1bmNoLXRpbWUN
Cj4+ICsgICAgICAgIGRvYzoNCj4+ICsgICAgICAgICAgTGF1bmNoIHRpbWUgSFcgb2ZmbG9hZCBp
cyBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4NCj4+ICAgIC0NCj4+ICAgICAgbmFtZTogcXVldWUt
dHlwZQ0KPj4gICAgICB0eXBlOiBlbnVtDQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9u
ZXR3b3JraW5nL3hzay10eC1tZXRhZGF0YS5yc3QNCj5iL0RvY3VtZW50YXRpb24vbmV0d29ya2lu
Zy94c2stdHgtbWV0YWRhdGEucnN0DQo+PiBpbmRleCBlNzZiMGNmYzMyZjcuLjNjZWMwODk3NDdj
ZSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy94c2stdHgtbWV0YWRh
dGEucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcveHNrLXR4LW1ldGFkYXRh
LnJzdA0KPj4gQEAgLTUwLDYgKzUwLDEwIEBAIFRoZSBmbGFncyBmaWVsZCBlbmFibGVzIHRoZSBw
YXJ0aWN1bGFyIG9mZmxvYWQ6DQo+PiAgICBjaGVja3N1bS4gYGBjc3VtX3N0YXJ0YGAgc3BlY2lm
aWVzIGJ5dGUgb2Zmc2V0IG9mIHdoZXJlIHRoZSBjaGVja3N1bW1pbmcNCj4+ICAgIHNob3VsZCBz
dGFydCBhbmQgYGBjc3VtX29mZnNldGBgIHNwZWNpZmllcyBieXRlIG9mZnNldCB3aGVyZSB0aGUN
Cj4+ICAgIGRldmljZSBzaG91bGQgc3RvcmUgdGhlIGNvbXB1dGVkIGNoZWNrc3VtLg0KPj4gKy0g
YGBYRFBfVFhNRF9GTEFHU19MQVVOQ0hfVElNRWBgOiByZXF1ZXN0cyB0aGUgZGV2aWNlIHRvIHNj
aGVkdWxlIHRoZQ0KPj4gKyAgcGFja2V0IGZvciB0cmFuc21pc3Npb24gYXQgYSBwcmUtZGV0ZXJt
aW5lZCB0aW1lIGNhbGxlZCBsYXVuY2ggdGltZS4gVGhlDQo+PiArICB2YWx1ZSBvZiBsYXVuY2gg
dGltZSBpcyBpbmRpY2F0ZWQgYnkgYGBsYXVuY2hfdGltZWBgIGZpZWxkIG9mDQo+PiArICBgYHVu
aW9uIHhza190eF9tZXRhZGF0YWBgLg0KPj4NCj4+ICBCZXNpZGVzIHRoZSBmbGFncyBhYm92ZSwg
aW4gb3JkZXIgdG8gdHJpZ2dlciB0aGUgb2ZmbG9hZHMsIHRoZSBmaXJzdA0KPj4gIHBhY2tldCdz
IGBgc3RydWN0IHhkcF9kZXNjYGAgZGVzY3JpcHRvciBzaG91bGQgc2V0IGBgWERQX1RYX01FVEFE
QVRBYGANCj4+IEBAIC02NSw2ICs2OSw2NSBAQCBJbiB0aGlzIGNhc2UsIHdoZW4gcnVubmluZyBp
biBgYFhES19DT1BZYGAgbW9kZSwgdGhlIFRYDQo+Y2hlY2tzdW0NCj4+ICBpcyBjYWxjdWxhdGVk
IG9uIHRoZSBDUFUuIERvIG5vdCBlbmFibGUgdGhpcyBvcHRpb24gaW4gcHJvZHVjdGlvbiBiZWNh
dXNlDQo+PiAgaXQgd2lsbCBuZWdhdGl2ZWx5IGFmZmVjdCBwZXJmb3JtYW5jZS4NCj4+DQo+PiAr
TGF1bmNoIFRpbWUNCj4+ICs9PT09PT09PT09PQ0KPj4gKw0KPj4gK1RoZSB2YWx1ZSBvZiB0aGUg
cmVxdWVzdGVkIGxhdW5jaCB0aW1lIHNob3VsZCBiZSBiYXNlZCBvbiB0aGUgZGV2aWNlJ3MgUFRQ
DQo+PiArSGFyZHdhcmUgQ2xvY2sgKFBIQykgdG8gZW5zdXJlIGFjY3VyYWN5LiBBRl9YRFAgdGFr
ZXMgYSBkaWZmZXJlbnQgZGF0YSBwYXRoDQo+PiArY29tcGFyZWQgdG8gdGhlIEVURiBxdWV1aW5n
IGRpc2NpcGxpbmUsIHdoaWNoIG9yZ2FuaXplcyBwYWNrZXRzIGFuZCBkZWxheXMNCj4+ICt0aGVp
ciB0cmFuc21pc3Npb24uIEluc3RlYWQsIEFGX1hEUCBpbW1lZGlhdGVseSBoYW5kcyBvZmYgdGhl
IHBhY2tldHMgdG8NCj4+ICt0aGUgZGV2aWNlIGRyaXZlciB3aXRob3V0IHJlYXJyYW5naW5nIHRo
ZWlyIG9yZGVyIG9yIGhvbGRpbmcgdGhlbSBwcmlvciB0bw0KPj4gK3RyYW5zbWlzc2lvbi4gSW4g
c2NlbmFyaW9zIHdoZXJlIHRoZSBsYXVuY2ggdGltZSBvZmZsb2FkIGZlYXR1cmUgaXMNCj4+ICtk
aXNhYmxlZCwgdGhlIGRldmljZSBkcml2ZXIgaXMgZXhwZWN0ZWQgdG8gZGlzcmVnYXJkIHRoZSBs
YXVuY2ggdGltZQ0KPj4gK3JlcXVlc3QuIEZvciBjb3JyZWN0IGludGVycHJldGF0aW9uIGFuZCBt
ZWFuaW5nZnVsIG9wZXJhdGlvbiwgdGhlIGxhdW5jaA0KPj4gK3RpbWUgc2hvdWxkIG5ldmVyIGJl
IHNldCB0byBhIHZhbHVlIGxhcmdlciB0aGFuIHRoZSBmYXJ0aGVzdCBwcm9ncmFtbWFibGUNCj4+
ICt0aW1lIGluIHRoZSBmdXR1cmUgKHRoZSBob3Jpem9uKS4gRGlmZmVyZW50IGRldmljZXMgaGF2
ZSBkaWZmZXJlbnQgaGFyZHdhcmUNCj4+ICtsaW1pdGF0aW9ucyBvbiB0aGUgbGF1bmNoIHRpbWUg
b2ZmbG9hZCBmZWF0dXJlLg0KPj4gKw0KPj4gK3N0bW1hYyBkcml2ZXINCj4+ICstLS0tLS0tLS0t
LS0tDQo+PiArDQo+PiArRm9yIHN0bW1hYywgVFNPIGFuZCBsYXVuY2ggdGltZSAoVEJTKSBmZWF0
dXJlcyBhcmUgbXV0dWFsbHkgZXhjbHVzaXZlIGZvcg0KPj4gK2VhY2ggaW5kaXZpZHVhbCBUeCBR
dWV1ZS4gQnkgZGVmYXVsdCwgdGhlIGRyaXZlciBjb25maWd1cmVzIFR4IFF1ZXVlIDAgdG8NCj4+
ICtzdXBwb3J0IFRTTyBhbmQgdGhlIHJlc3Qgb2YgdGhlIFR4IFF1ZXVlcyB0byBzdXBwb3J0IFRC
Uy4gVGhlIGxhdW5jaCB0aW1lDQo+PiAraGFyZHdhcmUgb2ZmbG9hZCBmZWF0dXJlIGNhbiBiZSBl
bmFibGVkIG9yIGRpc2FibGVkIGJ5IHVzaW5nIHRoZSB0Yy1ldGYNCj4+ICtjb21tYW5kIHRvIGNh
bGwgdGhlIGRyaXZlcidzIG5kb19zZXR1cF90YygpIGNhbGxiYWNrLg0KPj4gKw0KPj4gK1RoZSB2
YWx1ZSBvZiB0aGUgbGF1bmNoIHRpbWUgdGhhdCBpcyBwcm9ncmFtbWVkIGluIHRoZSBFbmhhbmNl
ZCBOb3JtYWwNCj4+ICtUcmFuc21pdCBEZXNjcmlwdG9ycyBpcyBhIDMyLWJpdCB2YWx1ZSwgd2hl
cmUgdGhlIG1vc3Qgc2lnbmlmaWNhbnQgOCBiaXRzDQo+PiArcmVwcmVzZW50IHRoZSB0aW1lIGlu
IHNlY29uZHMgYW5kIHRoZSByZW1haW5pbmcgMjQgYml0cyByZXByZXNlbnQgdGhlIHRpbWUNCj4+
ICtpbiAyNTYgbnMgaW5jcmVtZW50cy4gVGhlIHByb2dyYW1tZWQgbGF1bmNoIHRpbWUgaXMgY29t
cGFyZWQgYWdhaW5zdCB0aGUNCj4+ICtQVFAgdGltZSAoYml0c1szOTo4XSkgYW5kIHJvbGxzIG92
ZXIgYWZ0ZXIgMjU2IHNlY29uZHMuIFRoZXJlZm9yZSwgdGhlDQo+PiAraG9yaXpvbiBvZiB0aGUg
bGF1bmNoIHRpbWUgZm9yIGR3bWFjNCBhbmQgZHd4bGdtYWMyIGlzIDEyOCBzZWNvbmRzIGluIHRo
ZQ0KPj4gK2Z1dHVyZS4NCj4+ICsNCj4+ICtUaGUgc3RtbWFjIGRyaXZlciBtYWludGFpbnMgRklG
TyBiZWhhdmlvciBhbmQgZG9lcyBub3QgcGVyZm9ybSBwYWNrZXQNCj4+ICtyZW9yZGVyaW5nLiBU
aGlzIG1lYW5zIHRoYXQgYSBwYWNrZXQgd2l0aCBhIGxhdW5jaCB0aW1lIHJlcXVlc3Qgd2lsbCBi
bG9jaw0KPj4gK290aGVyIHBhY2tldHMgaW4gdGhlIHNhbWUgVHggUXVldWUgdW50aWwgaXQgaXMg
dHJhbnNtaXR0ZWQuDQo+PiArDQo+PiAraWdjIGRyaXZlcg0KPj4gKy0tLS0tLS0tLS0NCj4+ICsN
Cj4+ICtGb3IgaWdjLCBhbGwgZm91ciBUeCBRdWV1ZXMgc3VwcG9ydCB0aGUgbGF1bmNoIHRpbWUg
ZmVhdHVyZS4gVGhlIGxhdW5jaA0KPj4gK3RpbWUgaGFyZHdhcmUgb2ZmbG9hZCBmZWF0dXJlIGNh
biBiZSBlbmFibGVkIG9yIGRpc2FibGVkIGJ5IHVzaW5nIHRoZQ0KPj4gK3RjLWV0ZiBjb21tYW5k
IHRvIGNhbGwgdGhlIGRyaXZlcidzIG5kb19zZXR1cF90YygpIGNhbGxiYWNrLiBXaGVuIGVudGVy
aW5nDQo+PiArVFNOIG1vZGUsIHRoZSBpZ2MgZHJpdmVyIHdpbGwgcmVzZXQgdGhlIGRldmljZSBh
bmQgY3JlYXRlIGEgZGVmYXVsdCBRYnYNCj4+ICtzY2hlZHVsZSB3aXRoIGEgMS1zZWNvbmQgY3lj
bGUgdGltZSwgd2l0aCBhbGwgVHggUXVldWVzIG9wZW4gYXQgYWxsIHRpbWVzLg0KPj4gKw0KPj4g
K1RoZSB2YWx1ZSBvZiB0aGUgbGF1bmNoIHRpbWUgdGhhdCBpcyBwcm9ncmFtbWVkIGluIHRoZSBB
ZHZhbmNlZCBUcmFuc21pdA0KPj4gK0NvbnRleHQgRGVzY3JpcHRvciBpcyBhIHJlbGF0aXZlIG9m
ZnNldCB0byB0aGUgc3RhcnRpbmcgdGltZSBvZiB0aGUgUWJ2DQo+PiArdHJhbnNtaXNzaW9uIHdp
bmRvdyBvZiB0aGUgcXVldWUuIFRoZSBGcnN0IGZsYWcgb2YgdGhlIGRlc2NyaXB0b3IgY2FuIGJl
DQo+PiArc2V0IHRvIHNjaGVkdWxlIHRoZSBwYWNrZXQgZm9yIHRoZSBuZXh0IFFidiBjeWNsZS4g
VGhlcmVmb3JlLCB0aGUgaG9yaXpvbg0KPj4gK29mIHRoZSBsYXVuY2ggdGltZSBmb3IgaTIyNSBh
bmQgaTIyNiBpcyB0aGUgZW5kaW5nIHRpbWUgb2YgdGhlIG5leHQgY3ljbGUNCj4+ICtvZiB0aGUg
UWJ2IHRyYW5zbWlzc2lvbiB3aW5kb3cgb2YgdGhlIHF1ZXVlLiBGb3IgZXhhbXBsZSwgd2hlbiB0
aGUgUWJ2DQo+PiArY3ljbGUgdGltZSBpcyBzZXQgdG8gMSBzZWNvbmQsIHRoZSBob3Jpem9uIG9m
IHRoZSBsYXVuY2ggdGltZSByYW5nZXMNCj4+ICtmcm9tIDEgc2Vjb25kIHRvIDIgc2Vjb25kcywg
ZGVwZW5kaW5nIG9uIHdoZXJlIHRoZSBRYnYgY3ljbGUgaXMgY3VycmVudGx5DQo+PiArcnVubmlu
Zy4NCj4+ICsNCj4+ICtUaGUgaWdjIGRyaXZlciBtYWludGFpbnMgRklGTyBiZWhhdmlvciBhbmQg
ZG9lcyBub3QgcGVyZm9ybSBwYWNrZXQNCj4+ICtyZW9yZGVyaW5nLiBUaGlzIG1lYW5zIHRoYXQg
YSBwYWNrZXQgd2l0aCBhIGxhdW5jaCB0aW1lIHJlcXVlc3Qgd2lsbCBibG9jaw0KPj4gK290aGVy
IHBhY2tldHMgaW4gdGhlIHNhbWUgVHggUXVldWUgdW50aWwgaXQgaXMgdHJhbnNtaXR0ZWQuDQo+
DQo+U2luY2UgdHdvIGRldmljZXMgd2UgaW5pdGlhbGx5IHN1cHBvcnQgYXJlIHVzaW5nIEZJRk8g
bW9kZSwgc2hvdWxkIHdlIG1vcmUNCj5leHBsaWNpdGx5IHRhcmdldCB0aGlzIGNhc2U/IE1heWJl
IGV2ZW4gY2FsbCBuZXRkZXYgZmVhdHVyZXMNCj50eC1sYXVuY2gtdGltZS1maWZvPyBJbiB0aGUg
ZnV0dXJlLCBpZi93aGVuIHdlIGdldCBzdXBwb3J0IHRpbWluZy13aGVlbC1saWtlDQo+cXVldWVz
LCB3ZSBjYW4gZXhwb3J0IGFub3RoZXIgdHgtbGF1bmNoLXRpbWUtd2hlZWw/DQo+DQo+SXQgc2Vl
bXMgaW1wb3J0YW50IGZvciB0aGUgdXNlcnNwYWNlIHRvIGtub3cgd2hpY2ggbW9kZSBpdCdzIHJ1
bm5pbmcuDQo+SW4gYSBmaWZvIG1vZGUsIGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gYWxsb2NhdGUg
c2VwYXJhdGUgcXVldWVzDQo+Zm9yIHNjaGVkdWxpbmcgdGhpbmdzIGZhciBpbnRvIHRoZSBmdXR1
cmUvZXRjLg0KDQpZb3UgYXJlIHJpZ2h0LCB1c2VyIHNob3VsZCBpc29sYXRlIG9uZSBxdWV1ZSBm
b3Igc2NoZWR1bGluZyB0aGluZ3MNCmZhciBpbnRvIGZ1dHVyZSBhbmQgdXNlIG90aGVyIHF1ZXVl
IGZvciBub3JtYWwgdHJhZmZpYy4NCg0KPg0KPlRob3VnaHRzPyBObyBjb2RlIGNoYW5nZXMgcmVx
dWlyZWQsIGp1c3QgbW9yZSBleHBsaWNpdGx5IHN0YXRlIHRoZQ0KPmV4cGVjdGF0aW9ucy4NCg0K
QWdyZWUgd2l0aCB5b3UsIGxldCBtZSBjaGFuZ2UgdGhlIG5hbWUgZnJvbSB0eC1sYXVuY2gtdGlt
ZSB0bw0KdHgtbGF1bmNoLXRpbWUtZmlmbyB0byBleHBsaWNpdGx5IHN0YXRlIHRoZSBmaWZvIGJl
aGF2aW9yLiAgDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQo=

