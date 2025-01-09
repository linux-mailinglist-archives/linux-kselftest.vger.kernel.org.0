Return-Path: <linux-kselftest+bounces-24099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CDA06E9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5073A209B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1A201039;
	Thu,  9 Jan 2025 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAAlL0l0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071637160;
	Thu,  9 Jan 2025 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406443; cv=fail; b=VmS+J9d/cpCfac2Ar6WZ82v+drDzTTceb8gJIDywyWTdD1zPpEys7+KxXhO706fvHwxm8dtO3TwPy89NPdKiI4xpfdw2dHlikUBk8Ypp96h4pZ8bdD6QVSCGYQhoIhJ7Bf3fcdiUZzP+QFIha6UMR7uYPUMhy2wiUJLzQdh+Rpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406443; c=relaxed/simple;
	bh=45ONKrXhQREDNDfcMnzxsbtQWfRmxuyltCAWcjQUDM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pk91juwXC68ktb3j8B0T9xt7ywwqQisNBP1nS7d4wq50PjkG7E9aArk7zhuTFsYMTIY+0fTJJeovp5Ka3XTXQ+mxuD5FF2xhS5JysB5rFqOGYaUrf3ZybjJezjfh1uYfsTQVB5EOGdr3uicOETfCsQ3C+J7kHROJZ6DCva7cefg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAAlL0l0; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736406441; x=1767942441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45ONKrXhQREDNDfcMnzxsbtQWfRmxuyltCAWcjQUDM4=;
  b=cAAlL0l0RJJIQ6wMVarOrrsFDV5Zx7Zy9QqfhdO5/VCZiKRnqGHTlCil
   YpXxbuevEbxqtqg8XftZK/3ggOFrfamwhrvtahGKsvyfNzGFeHjHCLaGZ
   k01yPhD0o3oYPX3GeyLZKN1ODqLQ8sD5ABShMetk1+LYDcj8ymwA+bGjN
   2hoKGYYJR4NxdDHxBbXbH4GisZ7YJheV1mAAdE+xPa1UfQiPmfXwQakmz
   vBbx9dYT6FGOpjL75nb2KHfb4vZ14rpQ4BJWcaAlrJ0hW7l3X6iaseGhT
   ZOJ0bMs8sxA4lXGTyVmIqGQDo9q3KJjnwcOP1crsGO9rC04/2boed/t0c
   Q==;
X-CSE-ConnectionGUID: 9tY6aa6WSaahC1eFyzhM2g==
X-CSE-MsgGUID: ixnZPvAdQn6d/kFfQy7cWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40333267"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="40333267"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:07:20 -0800
X-CSE-ConnectionGUID: YOLrmAm3Rayg9WtxPAGx+g==
X-CSE-MsgGUID: NdiR7HPFTlCHoC7oyIqENQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="103524701"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:07:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:07:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:07:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:07:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5FYiiW9NCoNYF/pkDVhEAcM2qAKHbeIfs+eQ4pATZg1jP9iQh+eshVoA2XpyUUun/lcsIUfA78lbfVFFL9UxTkg9dISuRpLadWBx29UoKRI8c3p+yr+zs86NGRdvsIT7Fx5rQjueEW3fVJmLTVq80VAzpujYDGiVeEx3aZi59VZCmms3Ck3IuDpOiZfr+aDa3cvgfdMloVJT65NABjFT1R9CFpzvfv2cQ/LNMEe8i5hKKTZ6bBWP9RRZoNP4wQBOe9c19K/Pu8oEC05+6a0C/4avFbGmM9Mko+hXRh7g4U5d3K8kxRcgG73ruv7Q91BtnRLa6kYE72f8AzsSukJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45ONKrXhQREDNDfcMnzxsbtQWfRmxuyltCAWcjQUDM4=;
 b=H2Gizf727tW2e4btVVHXwTNntuRVNAV/141dWJ/iiqmCb2yItKVyEyyvKrlaFbexKfD8ks0URUgAeClF8gNsABaAE8MVeUV6fp8A9lNbnaY52WnAeFuyQs2JZj/vuCo43ryh732IdbNXmwJHqx/wB0r3mf/almGsMEoxCB2H/rcWKYoMFJbhk6ZDjYVeP2mORkP9VAjTI95ZX7yNirqC7rygsQldtXf35JQt3KKtlbRfL1pIXM4joUjrxCr8H5hNDdgoAsvc7ZU6hwxSTcSOV47gzMKU9Gop8Vu3KWboNRk84rnkNXrKWHn8Lnxgks/jSczelPpf0td71sAMpSuoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 07:06:17 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:06:17 +0000
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
Subject: RE: [PATCH bpf-next v4 3/4] net: stmmac: Add launch time support to
 XDP ZC
Thread-Topic: [PATCH bpf-next v4 3/4] net: stmmac: Add launch time support to
 XDP ZC
Thread-Index: AQHbYELawmQBktcQAUCu97noioT57rMLjMsAgAJ56yA=
Date: Thu, 9 Jan 2025 07:06:17 +0000
Message-ID: <PH0PR11MB58304082BF0EA96D1A74E4C5D8132@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250106135658.9734-1-yoong.siang.song@intel.com>
 <Z31fXHxWuKNog_Qh@mini-arch>
In-Reply-To: <Z31fXHxWuKNog_Qh@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DS0PR11MB7969:EE_
x-ms-office365-filtering-correlation-id: c2fd9521-b31b-45e2-51af-08dd307c1d0e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QXRDMDlrY2h6QzhLMGVtSU90aU1zcVluNnlXUkNqdXByNzRkWWpUcXB1bzJM?=
 =?utf-8?B?b0F1OUlCYnlMU08yK1JHSGQvVW8zR3B2Nm5ZVW52Y1ArSElrS1VXZVNIWFdh?=
 =?utf-8?B?anBJMnhJSGpIblVZVjlrSzBTQUFTc0Q4dVZteXBFdkloZ2p6WGtQa1I1bCsy?=
 =?utf-8?B?SGR3L21CTitMOHNRSFNIclFwZUtOazZBbjZud3FmMjhSTXJ2M0laaHl6cDdz?=
 =?utf-8?B?Z3pVcm8xcVlteUF3UGw1NktUNFBnU1pEbjN1R1pzSjJGY0pUaFV5eDlRbk5Z?=
 =?utf-8?B?eVF5SXBIa0hmWjNPUnFmUnpoOFBaclp4dmVtRDRBdmhuc3Jwck8yUTdWU2dk?=
 =?utf-8?B?bklOQUE3dklZZW1ZOUVxRThxd0UxWHRuU3d5ZHRzUUttZ2hxWVl1WHZlTEw3?=
 =?utf-8?B?UGc5OVkwOU1reW1vMEI1ZWhzOHBYKzJEQjdEQnVMbm9Tc1JZa2paU1diWU1u?=
 =?utf-8?B?UmM1R2x3MEhaK1VKMFlHbzJPMXlwQThhT2NlcXltbmN6QkNNS1B2STI2LzNK?=
 =?utf-8?B?UFU0anVRaE5PRzRLSXcxYjFYSXpaUC9hTDZ2S1hhcGJDWGJxUmtlaHdiVHNT?=
 =?utf-8?B?REEvc0laYWZHaGxvcUxWYXMzdGpML2UvY0s5T1JBOERoeGlQMUJWMXZxaEtI?=
 =?utf-8?B?NXpVUEFnelZGa2I0a2lvUkdkSHY1SHJsZnkraWhpNFVtVks5ZGIzUEdMUThh?=
 =?utf-8?B?VTUxdGs4TDJ4cTR0ek9MOTVvaDRNOWxwSnB3QWlETFdQaUQ3SkJIc0JpMXM4?=
 =?utf-8?B?Q0JOQ0JDbm9QMVkwK2dza2UrN21oRXFoQzJpSlNFTFBIZlc3VnhJd1dneFNQ?=
 =?utf-8?B?NkxkRmwxSzh4S25HT0VoU2wweWoyNXFUVHk5OEtQdGVwYXhaZVV0QmJnNGpQ?=
 =?utf-8?B?cWRwNjR6WTIzNmduT0xPb0g1WFpOUVlKQ3o4OGdvN1JZc1ZCM0k3WjVLMXpU?=
 =?utf-8?B?dWxER0pSbHlRa25SMFZwS3RoUWRrd2VBOFNFZXVoVVJoS0dRQXhFUi9jN09J?=
 =?utf-8?B?MnJUOVU1ZWVQL1EyMXdkK2NQUXlmTWRreWowVmkvSzBYS3ZxMUlKWWI0UUw2?=
 =?utf-8?B?MnFPSnVjSmRlRE1udmZNdmtrbXRmLzVLKytJdXlab0NzYWlyRUs3a0Y4UVE2?=
 =?utf-8?B?VklPK0wySVNVT0VxTmduNXl0a1VwdlZ0Wjk3T3F2c2l4RXk3ci9nV1IrY3hW?=
 =?utf-8?B?SDBuVUFUTm4rUnRsTExMekxmMmZUWVlxS3JYa3hkZS8xczdaSmQ1cVVjSmdG?=
 =?utf-8?B?SU9uODlNV1RoYlBBOHo5NVZaajBqNVJ6cmtXM2tBZzRFdkJFSWdmdFdNNHNM?=
 =?utf-8?B?QkpmdU45MkpCL3BQdkVPekhzUU1QaGtlbWVrWnZWRDNrRXVjdDhPMy9VMDM4?=
 =?utf-8?B?UTBSQTJJL05JM2JFOUgwWmthOHdXaXdSOWtEb2MrWFJGTDcvYlZKU3UrRWow?=
 =?utf-8?B?clY1SnFDMTQ0S2NlOFhvcUlLc0s2SVRLWVRGWVVVQ1pXT01Eb1YxODFOWWpE?=
 =?utf-8?B?Z2U2V0duUzMramtPYjlQNk02eWlDMUFrbStyempHUmlPc2RuaUtobFVJVnov?=
 =?utf-8?B?bWcrRVdnZysxU25ML1VudVF3U3ZpZ3F2RlFjVVJVelgrRXNqMzFZRWo4ZFNi?=
 =?utf-8?B?TDZhNHZRcUVxazRPdWdnUnhLYVJHNjZMVzlkeDVUZmJwYXVGZE1jcHhlbjIz?=
 =?utf-8?B?QWxxMVA4UFBWZ3Bvc05jZGNtYVFOL1NaRVRWblh2emxEaWFDMVp6U1ZjV2JN?=
 =?utf-8?B?U0Y2QzlpSWlJZ3hXR3BXQXhkZ1ZyZlN1MnUzS0xzUVJoREl3NWtHcnk0bkxG?=
 =?utf-8?B?V0U0TVo3NFpzaVhmTjNncUZCbVpSbFhHUW9sVGY5N2pyVks5ZWxOaHJlVHRP?=
 =?utf-8?B?Q2lhMmMrU2lldXpXL0J4bEZYVTFjTGJDamRKTTk0M2FDOVY1YWxPUngyMkNO?=
 =?utf-8?Q?M9nHRWyfZVeDFh1NJ9uzdq3kJv594UG0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1BYbTg2TkRjcjlUWFJ2eGpJc0N0RFlwRjYxdUFwL250SS8yTHRTMUQ1TUZm?=
 =?utf-8?B?TEZxNGo5all5K29VaDNxMExiVWN5bGZxOW1sSmpyb3VtTEVNRU03L1VKNlVi?=
 =?utf-8?B?WTE0RWRkZitHM1RRSDBXTTFkZTAvcHBWMUU5bStJc0lva1A0aXJOdkUwZ2FM?=
 =?utf-8?B?bHc5ZFV0TktQdWh4ZXgwaDFRdWpiQThuT1lZdEpTaTNvRWlQRlBtZDN0a0pp?=
 =?utf-8?B?dEJmNE15dGlKYUdmamd5di8rSlMzREFEcmY5RTVWS1VUWk5XYXBIRmtQTkNI?=
 =?utf-8?B?T05FVUpHclZEWTI5SEpwYTk4QWNNS21aRTBNenhhVjYrYlpmdEJIS0NocWpX?=
 =?utf-8?B?cGtSS3NLNFZiV2liV25EN08vLzI3WUNTTWFDVmpkZmlEQ05RMkV1VS9QdnlQ?=
 =?utf-8?B?YktZTDJQbVRhRTJnaFdsbzVnZUtJb1BtOE5SRzRqSks4ZE9hSzNWZGRuNjdv?=
 =?utf-8?B?WEpYSHVHR2tYZlJMZU0rdzVPTTJSdHV1R0N3MGRpbVBUUEhXUitrT1I5WHlO?=
 =?utf-8?B?OVRwTXFNYURaeG1iUC9ydWpVUWdvR3AvSjRNT21LVnJUTnYrSE9ZSjZEcy9K?=
 =?utf-8?B?am5GbURIQ2xWTUh2dVBSOFFOWUljdHZDT3dJTkpmb1A4VGNERVRRYkZ3Ulc2?=
 =?utf-8?B?akJkWlJzNzBXNm9XVHNNaUxtb3hHNVZXbndHMUNtblF5cDByMXQrVTNHa3BG?=
 =?utf-8?B?VDJYdXpBZUNtVWFxRFE5VHFJeE9RcjFFUytNOTRoRXB6ejllMWgwWlBJWGRN?=
 =?utf-8?B?emM5MEhUamt1ejJGd0tXUXUxQk02NjFpOURaZWlEY1NjNWZTeWpyYU5aWXJ4?=
 =?utf-8?B?VnhZemhmVVFaMThvTFgwN2tHazRmV3pXcWhWY0dNcGRlR1hxL2ZhbEVmYlBG?=
 =?utf-8?B?T0o0czZRMk9vZUZxOGtKVlRJa1dQSWd3dzBpZDJMZEx0dEVyTXpzWlliRVhB?=
 =?utf-8?B?T2ZtR29HWDBhaWczVzlJWUErUGtDeWFwSDladzRWekJDRUFKbkZVQUdjc2RS?=
 =?utf-8?B?YVpJNW5DQkFPcktvelkwaU9UcTFKbEtxbk5yVGMrYnk3dXlZTnl4TzJKQTFF?=
 =?utf-8?B?OGVMOGx1WU0vZ3BRS2FDNE9SMm1jSjRWQlRWcHBIU1VXSy9XZk0weUpITjVI?=
 =?utf-8?B?Y3Z4ZGtjelJQTlZvdWVMMDFxUStaVVNzNHp4OVlPMUZUbiszMmVpaUJncjhR?=
 =?utf-8?B?THpTRjlsamhSbmpvSkxMWEJGalV3UllJaEI0ZHNuWExHZGRkbFZwbGZYWjhK?=
 =?utf-8?B?aVJnTy9JTVRSZDhPbzY5aVdGSXFidGNMMVhDU0ROa2ZRdlVONmgxU1dnV0V4?=
 =?utf-8?B?QnNqY0piSzZzaE9mZ0J5UFNjZkxZbExrWDhuVlFWTE5KcVRIbDd6RVVnR2Ur?=
 =?utf-8?B?QmxyV3F2MU1mb1FaNFdRSWJ5K1Rkb1NuNzdzYmNMRGd2ZGR1ZjZkMXg4QnlO?=
 =?utf-8?B?dzMySnlCS3ZabGlJUnBEeWJxK2VoeGhzcjFCamFpWGwwZUJSY0RaaGhnWXJL?=
 =?utf-8?B?aVdMbGdqVmxKMWVsQWZ1bWhFNzRLc3BBODNUMk11VXNXMjNqcG1UbHNIVDlQ?=
 =?utf-8?B?ZGxzaHdJKzYzK1RsU2hjVlRmOE44b2hWQ2p0UHJTYVBoOXU5QXgzZ2dXQzZU?=
 =?utf-8?B?N3J2S1h4ejFDUjVrUXFZVGhvdWgwMG9maHZVMHRFOHJoaCtrelhHcy81TnBY?=
 =?utf-8?B?bzRhcGE0dDAzMnpmdzhiL3BFcURQbFJkTjZZSnpYenRhYUwrcmhEU0hCaHBt?=
 =?utf-8?B?MlYrWE80REwwekU2TW15OXFxSUJQQkVLLzFzM05uZDNCNHdpRUQyRGNsSTNr?=
 =?utf-8?B?eGl1ODFGR2FaekdVSmFJTlk4R0lUMlNIbENBZFl5NGlqNjN3enBhQklOdm1z?=
 =?utf-8?B?bEhHKzZtNWtoQWE2Ym1uZGYveVBpSWhLQXhHSFNQNmpJYXhaQzlrdWhKL2kx?=
 =?utf-8?B?N2l5b242RlFhMmdhVEV5OTA4NXAyYkl1QWFqZFJrY2NYaVJKdnhOQzFLQWpq?=
 =?utf-8?B?cmkybUN3RHZMbVRCUDE3WW1YcFIvcC9XcFlWd0J3NEJIUUdSTFVqNkNtZmlF?=
 =?utf-8?B?NkI2TytoR3lldWd6eDNXMWcyWVFhZ1RhWEhSaVVHNmppbDd5TmpmOG9vVVdL?=
 =?utf-8?B?WGxpWDdCS05YY3ZRNXJJTzYvcmNSRndiK3hic2FyTmZUZUR1UzhYY1FDakg5?=
 =?utf-8?B?bFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd9521-b31b-45e2-51af-08dd307c1d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:06:17.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9ZpUh1kjai4qOQDXXAjYAq1urRWGLujLuavfA2wWwLUuv23yAvDVbmGg7VF2H2kdhZ+Fn8wvetDHNygvvvzpUZLujyfe6XiERevVem0eVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKYW51YXJ5IDgsIDIwMjUgMTowOCBBTSwgU3RhbmlzbGF2IEZvbWljaGV2
IDxzdGZvbWljaGV2QGdtYWlsLmNvbT4gd3JvdGU6DQo+T24gMDEvMDYsIFNvbmcgWW9vbmcgU2lh
bmcgd3JvdGU6DQo+PiBFbmFibGUgbGF1bmNoIHRpbWUgKFRpbWUtQmFzZWQgU2NoZWR1bGluZykg
c3VwcG9ydCB0byBYRFAgemVybyBjb3B5IHZpYSBYRFANCj4+IFR4IG1ldGFkYXRhIGZyYW1ld29y
ay4NCj4+DQo+PiBUaGlzIHBhdGNoIGlzIHRlc3RlZCB3aXRoIHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEgb24NCj4+IEludGVsIFRpZ2VyIExha2UgcGxhdGZvcm0u
IEJlbG93IGFyZSB0aGUgdGVzdCBzdGVwcyBhbmQgcmVzdWx0Lg0KPj4NCj4+IFRlc3QgU3RlcHM6
DQo+PiAxLiBBZGQgbXFwcmlvIHFkaXNjOg0KPj4gICAgJCBzdWRvIHRjIHFkaXNjIGFkZCBkZXYg
ZW5wMHMzMGY0IGhhbmRsZSA4MDAxOiBwYXJlbnQgcm9vdCBtcXByaW8gbnVtX3RjDQo+PiAgICAg
IDQgbWFwIDAgMSAyIDMgMyAzIDMgMyAzIDMgMyAzIDMgMyAzIDMgcXVldWVzIDFAMCAxQDEgMUAy
IDFAMyBodyAwDQo+Pg0KPj4gMi4gRW5hYmxlIGxhdW5jaCB0aW1lIGhhcmR3YXJlIG9mZmxvYWQg
b24gaGFyZHdhcmUgcXVldWUgMToNCj4+ICAgICQgc3VkbyB0YyBxZGlzYyByZXBsYWNlIGRldiBl
bnAwczMwZjQgcGFyZW50IDgwMDE6MiBldGYgb2ZmbG9hZCBjbG9ja2lkDQo+PiAgICAgIENMT0NL
X1RBSSBkZWx0YSA1MDAwMDANCj4+DQo+PiAzLiBBZGQgYW4gaW5ncmVzcyBxZGlzYzoNCj4+ICAg
ICQgc3VkbyB0YyBxZGlzYyBhZGQgZGV2IGVucDBzMzBmNCBpbmdyZXNzDQo+Pg0KPj4gNC4gQWRk
IGEgZmxvd2VyIGZpbHRlciB0byByb3V0ZSBpbmNvbWluZyBwYWNrZXQgd2l0aCBWTEFOIHByaW9y
aXR5IDEgaW50bw0KPj4gICAgaGFyZHdhcmUgcXVldWUgMToNCj4+ICAgICQgc3VkbyB0YyBmaWx0
ZXIgYWRkIGRldiBlbnAwczMwZjQgcGFyZW50IGZmZmY6IHByb3RvY29sIDgwMi4xUSBmbG93ZXIN
Cj4+ICAgICAgdmxhbl9wcmlvIDEgaHdfdGMgMQ0KPj4NCj4+IDUuIEVuYWJsZSBWTEFOIHRhZyBz
dHJpcHBpbmc6DQo+PiAgICAkIHN1ZG8gZXRodG9vbCAtSyBlbnAwczMwZjQgcnh2bGFuIG9uDQo+
Pg0KPj4gNi4gU3RhcnQgeGRwX2h3X21ldGFkYXRhIHNlbGZ0ZXN0IGFwcGxpY2F0aW9uOg0KPj4g
ICAgJCBzdWRvIC4veGRwX2h3X21ldGFkYXRhIGVucDBzMzBmNCAtbCAxMDAwMDAwMDAwDQo+Pg0K
Pj4gNy4gU2VuZCBhbiBVRFAgcGFja2V0IHdpdGggVkxBTiBwcmlvcml0eSAxIHRvIHBvcnQgOTA5
MSBvZiBEVVQuDQo+DQo+VGFuZ2VudGlhbDogSSB3b25kZXIgd2hldGhlciB3ZSBjYW4gYWRkIHRo
ZSBzZXR1cCBzdGVwcyB0byB0aGUNCj54ZHBfaHdfbWV0YWRhdGEgdG9vbD8gSXQgaXMgdXNlZnVs
IHRvIGhhdmUgb25lIGNvbW1hbmQgdG8gcnVuIHRoYXQNCj50YWtlcyBjYXJlIG9mIGFsbCB0aGUg
ZGV0YWlscy4gU2FtZSB3YXkgaXQgYWxyZWFkeSBlbmFibGVzIEhXDQo+dHN0YW1waW5nLi4NCj4N
Cj5PciwgaWYgbm90IHRoZSBmdWxsIHNldHVwLCBzb21lIGtpbmQgb2YgZGV0ZWN0aW9uIHdlIGNh
biBzaWduYWwgdG8gdGhlDQo+dXNlciB0aGF0IHNvbWUgdGhpbmdzIG1pZ2h0IGJlIG1pc3Npbmc/
DQoNClN1cmUuIEkgY2FuIHRyeSB0byBhZGQgdGhlIHNldHVwIHN0ZXBzIGludG8geGRwX2h3X21l
dGFkYXRhDQpieSB1c2luZyBpb2N0bCgpIGZ1bmN0aW9uLiBIb3dldmVyLCB0aGVyZSBhcmUgc29t
ZSBkZXZpY2Ugc3BlY2lmaWMNCmNvbW1hbmQsIGxpa2UgdGhlIG51bWJlciBvZiBxdWV1ZSwgdGhl
aXIgcHJpb3JpdHksDQpob3cgdGhleSByb3V0ZSB0aGUgaW5jb21pbmcgcGFja2V0LCBldGMuIEkg
d2lsbCB0cnkgdG8gZmluZCBvdXQNCmEgY29tbW9uIHdheSB0aGF0IGNhbiB3b3JrIGZvciBtb3N0
IG9mIHRoZSBkZXZpY2VzLA0KYXQgbGVhc3Qgd29yayBmb3IgYm90aCBpZ2MgYW5kIHN0bW1hYy4N
Cg0KVGhhbmtzICYgUmVnYXJkcw0KU2lhbmcNCg==

