Return-Path: <linux-kselftest+bounces-24100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48407A06EAD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7403A31DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141EF2036F4;
	Thu,  9 Jan 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzZg2g/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C237160;
	Thu,  9 Jan 2025 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406552; cv=fail; b=sH5OvXY7FzdV2+nqVKX98FaczYvTrjHcAofvVdPK/TuIoRov5gfSR6mjxr90NCUcSi10kVrqz4DOXH3v5nmq5lH71RccP1qYgONj81ECph2JbbIfrZn7QqqltvDSgv/zZE3amBE6zZY4skYot+Wh+WPEkyR61FunXkAYL/trMWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406552; c=relaxed/simple;
	bh=/H7Rze+eXUO+H341iUhtD0mzZNh0AiyRKCgr5Fwxc1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CgmfLbBvUPpGPhfkZH61FJGPhDXRCaqYPOumUG80mbH49Oc67G3KfyQmq3cLVYnOcUaSU1fyfYuxEJAiHTRdO3Y9Ltg9V8dDmM2aA/SF08C6D9BroPL/fPkpdifcgiug26zEKN2fNDQZoQGdbe8jSyW9KwtWhKrgEHl0Ft7PD/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzZg2g/F; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736406550; x=1767942550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/H7Rze+eXUO+H341iUhtD0mzZNh0AiyRKCgr5Fwxc1c=;
  b=SzZg2g/FYNrPWaJ4JDYJ6qtXEZT1m1PxTNeqhpBYKVT6tFurydBifKex
   /83OqNEZjmfgAW9B7gO6Se9cOqgj6UrmaAHN1N8mfqKE55hutPu9wmzOV
   xPxbX2L31bORuYeg7c6TorVr/ePMCNZpvYB0OAWqstJba3gN3aPZ2r4QN
   HwSHREl23zzvyo7TQZzxk/mJxk5843OxeUtWGOQK6mLlo/YypjNioEhTO
   SYMuyepDg1Z/hG49kQqM3Kr55rCp2Mpmpsb2iFhTwrKcPvbPRnvIpTjcM
   pWga2OurNLfavQITdqG2omFLGohUQLGS9PkTQAlloJe27sdV+PyorHwnc
   Q==;
X-CSE-ConnectionGUID: 2pNfAtkBTUqrL6HO3byVUQ==
X-CSE-MsgGUID: 50Z9/S6sSSSG1bu9K6Akdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="62030709"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="62030709"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:09:08 -0800
X-CSE-ConnectionGUID: RP6m90kaTyGyLoAMTAfwtg==
X-CSE-MsgGUID: mjHR1SZNRGq+Egz7ejufqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140636466"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:09:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:09:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:09:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:09:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cwdc5dMmK0oxWVat8oJ626kwN99FJaefP9ji1VTyL36rZmKVN7LIgTcwMwvPXwrgfcxPoh1EIZ4GVJHTH9llMn6jnsOpbi07U8MmKtq5j9MLYyZeMXZ3+y8Bxv6YDjrbuQnIlUQ3iYOlZvVQQh7bvHySfkoTivKQN13S4kYe7ruvE9Z7eyWmPgc6DqCpzxC8dTh6UoTcvDvWlTbXFYu7n5K5j09qf4GF6eOLGUSKJj/16f91OL5jlp6RCixiV9Di9sWB8cEPO2AAWw8Ktlwmmuitqt8KGRE0TeUXzqBuogHm1I5fr+8mV1Q4vAvA/I2df2gsUa13IJsmEsa/MWXwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H7Rze+eXUO+H341iUhtD0mzZNh0AiyRKCgr5Fwxc1c=;
 b=jcyJJ+iC+r295QjWtXrcEaPdwSzCZMJ6FY6wLpXGllxIcr3iWL1t2eS9zDzcTVug7Sy1rviqIAracpfqNnc+glzrxE3Y7g74QBcUsIX0Hk5IRta+2svE8+1k0GXqHP/ZDGc98ATzYL7hu7VL/FV0M85EiAMdqPFCTXuJ2t+LdquZH/cLoUBpeh/HUuN6EWgwQaDaCJa2gtESmSN7KVAgjoDAzzvDQ3TD7wpzZGZlsYOb3YYlfTzH+8rQ5yvJdPS8Bu9CerTXluIxvdIBERL5fceaX7suyjyKXvg71QN7m2cNj4kZ0dfP/g/Ji/1CJVAmkW577M5eCkZQuGqOF2pg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 07:08:32 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:08:32 +0000
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
Subject: RE: [PATCH bpf-next v4 2/4] selftests/bpf: Add Launch Time request to
 xdp_hw_metadata
Thread-Topic: [PATCH bpf-next v4 2/4] selftests/bpf: Add Launch Time request
 to xdp_hw_metadata
Thread-Index: AQHbYELePEInRYShVkCncb9Fi5UHZbMLifmAgAJ/iiA=
Date: Thu, 9 Jan 2025 07:08:32 +0000
Message-ID: <PH0PR11MB58308DE8330F4CDE6A954534D8132@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250106135638.9719-1-yoong.siang.song@intel.com>
 <Z31c_3j9MEP7Z3bd@mini-arch>
In-Reply-To: <Z31c_3j9MEP7Z3bd@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DS0PR11MB7969:EE_
x-ms-office365-filtering-correlation-id: 740d040f-b6e0-4542-1bd0-08dd307c6d3c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZlRtZWhpQmVIMHVTTlgwaHZYOExQZ2N6WTVaTzgwMHIvckxzNERqaXFZbUlI?=
 =?utf-8?B?dmhldGY4WFhuOFRpREhOT3NFcURmU0ZJNzU0ODYvQ1dUY3VCWGRMYUNsMG15?=
 =?utf-8?B?L0xPK0tINlU5ek9xdjBYMGtBRlhTOFk3YkpRakh4R0lKdnRVRWR1WWwwdG96?=
 =?utf-8?B?eEZBM3FQT0JlVGpycEw0TGEzS0lPd2RacUdUeEczMzh6RlB5N0ZIcFFxem5T?=
 =?utf-8?B?SUp6ZVZQcXFhUHYzVEJsVVgxWEZ2N0tWTWd2M2dQWlA3ZGYxYzFzL3N4SmVB?=
 =?utf-8?B?WEoyTlpJY0RYSU8xa1QvTTZXNGpCQXA4dVJJS1N1MGZpa2xFMVJqWkh1a2NX?=
 =?utf-8?B?M0dzckw4eU8zenQ4TGVtZGpTRXhnU1lPTmFqaWl3bDlMbTBCM0hCcVdEU3o1?=
 =?utf-8?B?eHIyTENBNjlrWldYNWhaY1JLdFpMVkQ3YjFoVnhpbEdVbTk0N2FnVmZoZHUr?=
 =?utf-8?B?MklhU0d4RVpXc2NQRHBPeG9jYVkreWFJY2k2QlFuWWRYbW5VbFRDbnBSQVY0?=
 =?utf-8?B?eEdmbEJFL0thWS9SQWVMVWFWaTFiNnQvSlRuOUltMjYyN3pvRVJQZjJVcHU2?=
 =?utf-8?B?bEJJSjdwOGxiTllnd3crZlVQckZyNW41S2xxbERsMFF1S2VmZXd4N3RKb1dP?=
 =?utf-8?B?eDBCcUQrckxDYUViUDcrd3AwV1NXZG1DZUdkWlJ2ZWpDa3dsN3lEZSsxbHF0?=
 =?utf-8?B?djY0YTJiQnBzZy9vUm03NlViVG5aUGdsczRyVysyYTUwa0ZweFRuWHA2dnp1?=
 =?utf-8?B?OGtrTnBYQlpVMHZqTUZlWWR1R3RGb2dzMTlEcW5aSy9DdjhWU1hCTm9TLzJK?=
 =?utf-8?B?aytyODB6V2t6SzFlUFRpQmk4Ykc3UWdaWFdEbHR3bHJTVGxuNmZ5bk5jcmNG?=
 =?utf-8?B?MmVmMVZDZTJFaEJyRnF2MEpGdEYxY1dWWFcrY0ZUR0tSWTI5U2FOYzdsL3N1?=
 =?utf-8?B?TjAvSTFTVWdmZHhJL1lxbHJ1OWF0TnZ5aWE3aTlvRzJMYmxEakFqVVAwLzdO?=
 =?utf-8?B?WFpLWWRVQ3pJclFPSFBlSVU3Rmp1ZTZzYWQ5QkVOOVYrZkJtNFJ0SWxZRlFp?=
 =?utf-8?B?ajczQ04zVDdwVFBUbkRtMzcvTTZ3OEgwNWx3RlNMaFlIaTZ3T1ZNQWwzRUVM?=
 =?utf-8?B?STg5aUoxelBZU0ZQWGRUY1I3QytPbzNqVTlaV3FCWnAwWUxKZmdiQTBhTXpB?=
 =?utf-8?B?RGFYcDYveWYzdmNpUjY3cGJyYThHY2RaQURzMXh5TDR5ZWkvTXlKQTBsVGhX?=
 =?utf-8?B?RHRhK2Mzc1BacVZxWXJjR096UXBVKzhFemlBME92N25YWlF6b0F5YVZXTG9K?=
 =?utf-8?B?S0FIMUFwcktIRDA4Y1JXMmhsVU56N3R2RVllVTdZbGh0NEN5dHo5RWNPQzVh?=
 =?utf-8?B?d1lVaTZJczhjblo1K3hlN1FxMFQ2ZkNqeHNHd2g5bzR4Q2tUS09MZ243VkZj?=
 =?utf-8?B?TkpFdXVMemcxTGgrQk9FMmxrRzRaNWlOMXZWUWlwNTBJQ2lvUkhxdFJiRVRK?=
 =?utf-8?B?ZmlISWVyNWhseGk4VGRURGJyTFovNkhkVncxNEpwdUdpSFdBNDBTZXh2VGZs?=
 =?utf-8?B?Z2JsQmp5ZnpGWFRONjBCRjFkUmN6bmN6Z0Fid1QwTDJJU1o2WWsrMmdiRkJJ?=
 =?utf-8?B?NXprQmdsa2VLTmRXalpLU3cxb2tiTzF2NHlXdjZpMXo3ZFZrd0NIbVl5bGpq?=
 =?utf-8?B?VmRLSE13cGNpTjN1aHpZdUhCN1ZVNVBlS2g4Y08wY2Q1K2VPakswY1hIMUZF?=
 =?utf-8?B?U2RFRElVSEZSUy93ZGpHNjRoZnljVVNvdkRuNm1lbm1HbzRJZ0hJV3FZVk1k?=
 =?utf-8?B?Z3ZvMTlYcis2b3NET1BvaStxdjV6Vm5CdENaVTYwSEZ4N2VLTWdRNVNNekdU?=
 =?utf-8?B?aldLU2FGelNScDNYNFF6b1RyOVVvMUkyVEtaZzhJNlAyMG9MTHY1cHo1MjRp?=
 =?utf-8?Q?Zznoh2BgLmpDRdlUDej8eSTXmzb2o8yE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmM0NkUwTkgvOC9wNUZKSlowV3A4MDZpdFpueTRuRkgrV05QM25MajVNT2FP?=
 =?utf-8?B?ZHVUZFdUSFdLbmlhckthbW54V3lZbFVWZU9IajhNRU5aU0xMNHM2cGN4RzJo?=
 =?utf-8?B?OEZJWVloY0sxL21wTGsyZUY5Yk1nL3NuU2MwbHRZSXliSjEwc0ptMnFGT3lo?=
 =?utf-8?B?MjU3RVZJaFkzLzFPQi9OTVE5VmI2QWNhVVJ5MTdJdG50dWV6elpIYkMzK2tw?=
 =?utf-8?B?WklMeWdNbjYvSHZXanY1bTc1WWpYVkxrV2VBYkFaaDhQN2hXK1ZrQ3VxNS9J?=
 =?utf-8?B?N1ZtcXJpZ0RkeC9GaCtXcDJMZk93SzhVMDlBcXEvb3BGczJRK2xURXFvWTda?=
 =?utf-8?B?S1hZcisxTDZMOEVad1ZRQ2tkc0FWdzBhWUw2Q2FTbjNnV3F1QVN5K2F3V09n?=
 =?utf-8?B?Y3hRR2dUSFZnanV5c0czbnJGR1VCNkJzVTFiMisvKytaaGlZZHZzcDAyMzBy?=
 =?utf-8?B?OFVkdU84Z3o2dkVIcTFHV1ZtV3lmY1Izenl3NGVreW1hZjBEYVNyYVhHSUNy?=
 =?utf-8?B?UjRVL2VYTXhEVmFmclgvKzJENDM1czVXcUV3M1JSUmFmSjcyVXJlMHJuVTJM?=
 =?utf-8?B?L3k2UXl6eEZrcHJ4U2Z2M085VUxNc0xHaVY1RUp0eFlQdFZrQ2F3TFA0Nlht?=
 =?utf-8?B?R3JWSXZoVDI4d3lZQWQrNTBHQzN4M01FMnd6Vkh5YXhBRGhTcng1UXZtZG00?=
 =?utf-8?B?Snd1ZjBxMFRubVhSMTVyUnBaZjl2blgzdzh6UGR1bE4yZk41cDlNc0lqV01M?=
 =?utf-8?B?ZEVZcWJaeTFuUC83a21xblZWVWtnS3FFcFdvTzZPWmFUc0FNMVJyK2hxQnAz?=
 =?utf-8?B?V1NmQVVrc2U4cDhBSC9GWkNFTFc0ZzB3L3ZLaElIUkN2N3NKOGc4RVE2cTU5?=
 =?utf-8?B?UDY1STJmWFdwTmhxRmF6UU04Mk03d09NVmtUME9zc3VyUEdnUDQrWHZNaUNw?=
 =?utf-8?B?WTQwYVRjUXhTelYzdUdOSVdxZ0FtZkh2OU1oa2liaHc0TzRUaldENUlvM3Zl?=
 =?utf-8?B?ZEpBNlJIYjRVMndGOUxXeTVzcHJFdFF4N2NKWEM3d2FkcUhXU01qaVdZZmor?=
 =?utf-8?B?YjdpSmg4Q2xick9jcSt5cGt2YjMrYVdPYmphTVM1SzRkcy9pSmFsOFlObE5S?=
 =?utf-8?B?RHRkcmgzOEkrVzY2allwbURnOEJBaDJJUmdCdUUxRHlKdFZaY3d6Sm9Dejd6?=
 =?utf-8?B?cjRUbC9JZGVKVzhOSTFac25BanhIRVMvZnBYaHZvWGlHaHpHMXZhSVN3U1p4?=
 =?utf-8?B?SUgyTU5saXh0aFpwUjU3TU5HMFJkV0R4ZFo3ZCtGY1JPNnZ0elVIUDhkaG9r?=
 =?utf-8?B?bm9ZUnVvcjBCWkNDMno0K3pkdUx3dWhMWjE1OTZQMk55aS90Tmg2NUNCaGU4?=
 =?utf-8?B?eHdUOC9ERWI1VzFWdlZaTUFVMFdBeHJaTk10cjFsaVhZN0YrVE12U2pRNmx3?=
 =?utf-8?B?Ti9CMGJnazhPZ2xzV2g3N1E3RzJhZzFUdXNPSWtvUElObXhlOVNrcWozVnN1?=
 =?utf-8?B?Si9ZTnNNRE9oTUFidzY2Z3ZQQmZTaDNHeGlCVUt4d2ZrYlcyRCs3VFJKQ0Nx?=
 =?utf-8?B?WGlxdnFLQk5UbnoxVmVueUh2SjZrTm9Ka1Yzb3luRnNNaVRza1JWQnY2ZlZu?=
 =?utf-8?B?S2N3Vjk4ZFU1WWtPMWNCL3I1UHFQQ0h1a1cxMWN3OElvZndab3pOY2dKVXIx?=
 =?utf-8?B?ZitUd0pHbWhZNGRhS0cwaE5oOERjSFh5Q04ycW1ZR1dBRk14YUhyV21ORTRM?=
 =?utf-8?B?d2QzcWowTlNqTGVRcWZ6TWVibHBzZlE5c1EwRjExUks2REdiN1lISWE3bzR2?=
 =?utf-8?B?VlNWWExnZlZVazdDVDBuVTdGSThnQXZZK2I1d25MNW1sbjlkdG4zeU1sQ3hW?=
 =?utf-8?B?amxpVWQwOThmb1RlSm03U0J1N1ZacHpVTngxRWJIek15U2hPWkZtb29DN2pG?=
 =?utf-8?B?alVOYUg5Mjh4UHd2YWEwdUZXbEdIVm91Zi9zbloyWUd4QTZHOHZpQjFIWCt0?=
 =?utf-8?B?aXZhT3QxV2p4TjBXelVyOFo0aUJSclZCZ3k1clp0SWVHOEM2bEZUaHlwYVd2?=
 =?utf-8?B?NmVoRHljaWRzZFZ0Z1lQaWIxMkRveDJqNG5qdDV1amF3eDExYUVCQTVudnZt?=
 =?utf-8?B?eGVtSlVnSExFWDlFYXlNaDBtMmlKVmFCL2RBSWw5Vm1Bb1ZpcDNJK0V0a2Ra?=
 =?utf-8?B?cFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 740d040f-b6e0-4542-1bd0-08dd307c6d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:08:32.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUwqoy6RAidVtJHIW6qB7RfZ8HrGwcMtcFNn7b2V2KorbmZ5X5kyEwSfOlljs5Rh1hlDcDysqaYiSDNeEH9CTrTeN5GFK9DqgxUS0AKqoPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKYW51YXJ5IDgsIDIwMjUgMTI6NTggQU0sIFN0YW5pc2xhdiBGb21pY2hl
diA8c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPk9uIDAxLzA2LCBTb25nIFlvb25nIFNp
YW5nIHdyb3RlOg0KPj4gQWRkIExhdW5jaCBUaW1lIGh3IG9mZmxvYWQgcmVxdWVzdCB0byB4ZHBf
aHdfbWV0YWRhdGEuIFVzZXIgY2FuIGNvbmZpZ3VyZQ0KPj4gdGhlIGRlbHRhIG9mIGxhdW5jaCB0
aW1lIHRvIEhXIFJYLXRpbWUgYnkgdXNpbmcgIi1sIiBhcmd1bWVudC4gVGhlIGRlZmF1bHQNCj4+
IGRlbHRhIGlzIDEwMCwwMDAsMDAwIG5hbm9zZWNvbmQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
U29uZyBZb29uZyBTaWFuZyA8eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20+DQo+PiAtLS0NCj4+
ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveGRwX2h3X21ldGFkYXRhLmMgfCAzMCArKysr
KysrKysrKysrKysrKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi94ZHBfaHdfbWV0YWRhdGEuYw0KPmIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hk
cF9od19tZXRhZGF0YS5jDQo+PiBpbmRleCA2ZjdiMTVkNmM2ZWQuLjc5NWMxZDE0ZTAyZCAxMDA2
NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEu
Yw0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hkcF9od19tZXRhZGF0YS5j
DQo+PiBAQCAtMTMsNiArMTMsNyBAQA0KPj4gICAqIC0gVURQIDkwOTEgcGFja2V0cyB0cmlnZ2Vy
IFRYIHJlcGx5DQo+PiAgICogLSBUWCBIVyB0aW1lc3RhbXAgaXMgcmVxdWVzdGVkIGFuZCByZXBv
cnRlZCBiYWNrIHVwb24gY29tcGxldGlvbg0KPj4gICAqIC0gVFggY2hlY2tzdW0gaXMgcmVxdWVz
dGVkDQo+PiArICogLSBUWCBsYXVuY2ggdGltZSBIVyBvZmZsb2FkIGlzIHJlcXVlc3RlZCBmb3Ig
dHJhbnNtaXNzaW9uDQo+PiAgICovDQo+Pg0KPj4gICNpbmNsdWRlIDx0ZXN0X3Byb2dzLmg+DQo+
PiBAQCAtNjQsNiArNjUsOCBAQCBpbnQgcnhxOw0KPj4gIGJvb2wgc2tpcF90eDsNCj4+ICBfX3U2
NCBsYXN0X2h3X3J4X3RpbWVzdGFtcDsNCj4+ICBfX3U2NCBsYXN0X3hkcF9yeF90aW1lc3RhbXA7
DQo+PiArX191NjQgbGFzdF9sYXVuY2hfdGltZTsNCj4+ICtfX3U2NCBsYXVuY2hfdGltZV9kZWx0
YV90b19od19yeF90aW1lc3RhbXAgPSAxMDAwMDAwMDA7IC8qIDAuMSBzZWNvbmQgKi8NCj4+DQo+
PiAgdm9pZCB0ZXN0X19mYWlsKHZvaWQpIHsgLyogZm9yIG5ldHdvcmtfaGVscGVycy5jICovIH0N
Cj4+DQo+PiBAQCAtMjk4LDYgKzMwMSw4IEBAIHN0YXRpYyBib29sIGNvbXBsZXRlX3R4KHN0cnVj
dCB4c2sgKnhzaywgY2xvY2tpZF90DQo+Y2xvY2tfaWQpDQo+PiAgCWlmIChtZXRhLT5jb21wbGV0
aW9uLnR4X3RpbWVzdGFtcCkgew0KPj4gIAkJX191NjQgcmVmX3RzdGFtcCA9IGdldHRpbWUoY2xv
Y2tfaWQpOw0KPj4NCj4+ICsJCXByaW50X3RzdGFtcF9kZWx0YSgiSFcgTGF1bmNoLXRpbWUiLCAi
SFcgVFgtY29tcGxldGUtdGltZSIsDQo+PiArCQkJCSAgIGxhc3RfbGF1bmNoX3RpbWUsIG1ldGEt
DQo+PmNvbXBsZXRpb24udHhfdGltZXN0YW1wKTsNCj4+ICAJCXByaW50X3RzdGFtcF9kZWx0YSgi
SFcgVFgtY29tcGxldGUtdGltZSIsICJVc2VyIFRYLWNvbXBsZXRlLQ0KPnRpbWUiLA0KPj4gIAkJ
CQkgICBtZXRhLT5jb21wbGV0aW9uLnR4X3RpbWVzdGFtcCwgcmVmX3RzdGFtcCk7DQo+PiAgCQlw
cmludF90c3RhbXBfZGVsdGEoIlhEUCBSWC10aW1lIiwgIlVzZXIgVFgtY29tcGxldGUtdGltZSIs
DQo+PiBAQCAtMzk1LDYgKzQwMCwxNCBAQCBzdGF0aWMgdm9pZCBwaW5nX3Bvbmcoc3RydWN0IHhz
ayAqeHNrLCB2b2lkICpyeF9wYWNrZXQsDQo+Y2xvY2tpZF90IGNsb2NrX2lkKQ0KPj4gIAkgICAg
ICAgeHNrLCBudG9ocyh1ZHBoLT5jaGVjayksIG50b2hzKHdhbnRfY3N1bSksDQo+PiAgCSAgICAg
ICBtZXRhLT5yZXF1ZXN0LmNzdW1fc3RhcnQsIG1ldGEtPnJlcXVlc3QuY3N1bV9vZmZzZXQpOw0K
Pj4NCj4+ICsJLyogU2V0IHRoZSB2YWx1ZSBvZiBsYXVuY2ggdGltZSAqLw0KPj4gKwltZXRhLT5m
bGFncyB8PSBYRFBfVFhNRF9GTEFHU19MQVVOQ0hfVElNRTsNCj4+ICsJbWV0YS0+cmVxdWVzdC5s
YXVuY2hfdGltZSA9IGxhc3RfaHdfcnhfdGltZXN0YW1wICsNCj4+ICsJCQkJICAgIGxhdW5jaF90
aW1lX2RlbHRhX3RvX2h3X3J4X3RpbWVzdGFtcDsNCj4+ICsJbGFzdF9sYXVuY2hfdGltZSA9IG1l
dGEtPnJlcXVlc3QubGF1bmNoX3RpbWU7DQo+PiArCXByaW50X3RzdGFtcF9kZWx0YSgiSFcgUlgt
dGltZSIsICJIVyBMYXVuY2gtdGltZSIsDQo+bGFzdF9od19yeF90aW1lc3RhbXAsDQo+PiArCQkJ
ICAgbWV0YS0+cmVxdWVzdC5sYXVuY2hfdGltZSk7DQo+PiArDQo+PiAgCW1lbWNweShkYXRhLCBy
eF9wYWNrZXQsIGxlbik7IC8qIGRvbid0IHNoYXJlIHVtZW0gY2h1bmsgZm9yIHNpbXBsaWNpdHkg
Ki8NCj4+ICAJdHhfZGVzYy0+b3B0aW9ucyB8PSBYRFBfVFhfTUVUQURBVEE7DQo+PiAgCXR4X2Rl
c2MtPmxlbiA9IGxlbjsNCj4+IEBAIC00MDIsMTAgKzQxNSwxNCBAQCBzdGF0aWMgdm9pZCBwaW5n
X3Bvbmcoc3RydWN0IHhzayAqeHNrLCB2b2lkICpyeF9wYWNrZXQsDQo+Y2xvY2tpZF90IGNsb2Nr
X2lkKQ0KPj4gIAl4c2tfcmluZ19wcm9kX19zdWJtaXQoJnhzay0+dHgsIDEpOw0KPj4gIH0NCj4+
DQo+PiArI2RlZmluZSBTTEVFUF9QRVJfSVRFUkFUSU9OX0lOX1VTIDEwDQo+PiArI2RlZmluZSBT
TEVFUF9QRVJfSVRFUkFUSU9OX0lOX05TIChTTEVFUF9QRVJfSVRFUkFUSU9OX0lOX1VTICogMTAw
MCkNCj4+ICsjZGVmaW5lIE1BWF9JVEVSQVRJT04oeCkgKCgoeCkgLyBTTEVFUF9QRVJfSVRFUkFU
SU9OX0lOX05TKSArIDUwMCkNCj4+ICBzdGF0aWMgaW50IHZlcmlmeV9tZXRhZGF0YShzdHJ1Y3Qg
eHNrICpyeF94c2ssIGludCByeHEsIGludCBzZXJ2ZXJfZmQsIGNsb2NraWRfdA0KPmNsb2NrX2lk
KQ0KPj4gIHsNCj4+ICAJY29uc3Qgc3RydWN0IHhkcF9kZXNjICpyeF9kZXNjOw0KPj4gIAlzdHJ1
Y3QgcG9sbGZkIGZkc1tyeHEgKyAxXTsNCj4+ICsJaW50IG1heF9pdGVyYXRpb25zOw0KPj4gIAlf
X3U2NCBjb21wX2FkZHI7DQo+PiAgCV9fdTY0IGFkZHI7DQo+PiAgCV9fdTMyIGlkeCA9IDA7DQo+
PiBAQCAtNDE4LDYgKzQzNSw5IEBAIHN0YXRpYyBpbnQgdmVyaWZ5X21ldGFkYXRhKHN0cnVjdCB4
c2sgKnJ4X3hzaywgaW50IHJ4cSwgaW50DQo+c2VydmVyX2ZkLCBjbG9ja2lkX3QNCj4+ICAJCWZk
c1tpXS5yZXZlbnRzID0gMDsNCj4+ICAJfQ0KPj4NCj4+ICsJLyogQ2FsY3VsYXRlIG1heCBpdGVy
YXRpb25zIHRvIHdhaXQgZm9yIHRyYW5zbWl0IGNvbXBsZXRpb24gKi8NCj4+ICsJbWF4X2l0ZXJh
dGlvbnMgPQ0KPk1BWF9JVEVSQVRJT04obGF1bmNoX3RpbWVfZGVsdGFfdG9faHdfcnhfdGltZXN0
YW1wKTsNCj4+ICsNCj4+ICAJZmRzW3J4cV0uZmQgPSBzZXJ2ZXJfZmQ7DQo+PiAgCWZkc1tyeHFd
LmV2ZW50cyA9IFBPTExJTjsNCj4+ICAJZmRzW3J4cV0ucmV2ZW50cyA9IDA7DQo+PiBAQCAtNDc3
LDEwICs0OTcsMTAgQEAgc3RhdGljIGludCB2ZXJpZnlfbWV0YWRhdGEoc3RydWN0IHhzayAqcnhf
eHNrLCBpbnQgcnhxLA0KPmludCBzZXJ2ZXJfZmQsIGNsb2NraWRfdA0KPj4gIAkJCQkJaWYgKHJl
dCkNCj4+ICAJCQkJCQlwcmludGYoImtpY2tfdHggcmV0PSVkXG4iLCByZXQpOw0KPj4NCj4NCj5b
Li5dDQo+DQo+PiAtCQkJCQlmb3IgKGludCBqID0gMDsgaiA8IDUwMDsgaisrKSB7DQo+PiArCQkJ
CQlmb3IgKGludCBqID0gMDsgaiA8IG1heF9pdGVyYXRpb25zOyBqKyspIHsNCj4+ICAJCQkJCQlp
ZiAoY29tcGxldGVfdHgoeHNrLCBjbG9ja19pZCkpDQo+PiAgCQkJCQkJCWJyZWFrOw0KPj4gLQkJ
CQkJCXVzbGVlcCgxMCk7DQo+PiArDQo+CXVzbGVlcChTTEVFUF9QRVJfSVRFUkFUSU9OX0lOX1VT
KTsNCj4NCj5uaXQ6IGluc3RlYWQgb2YgZG9pbmcgTUFYX0lURVJBVElPTi9tYXhfaXRlcmF0aW9u
cywgY2FuIHdlIHNpbXBsaWZ5IHRoaXMNCj50byB0aGUgZm9sbG93aW5nPw0KPg0KPnN0YXRpYyB1
NjQgbm93KHZvaWQpDQo+ew0KPgljbG9ja19nZXR0aW1lKC4uLik7DQo+CXJldHVybiB0cy50dl9z
ZWMgKiBOU0VDX1BFUl9TRUMgKyB0cy50dl9uc2VjOw0KPn0NCj4NCj4vKiB3YWl0IDUgc2Vjb25k
cyArIGNvdmVyIGxhdW5jaCB0aW1lICovDQo+ZGVhZGxpbmUgPSBub3coKSArIDUgKiBOU0VDX1BF
Ul9TRUMgKyBsYXVuY2hfdGltZV9kZWx0YV90b19od19yeF90aW1lc3RhbXA7DQo+d2hpbGUgKHRy
dWUpIHsNCj4JaWYgKGNvbXBsZXRlX3R4KCkpDQo+CQlicmVhazsNCj4JaWYgKG5vdygpID49IGRl
YWRsaW5lKQ0KPgkJYnJlYWs7DQo+CXVzbGVlcCgxMCk7DQo+fQ0KPg0KPkl0IGlzIGEgYml0IG1v
cmUgcmVhZGFibGUgdGhhbiBjb252ZXJ0aW5nIHRpbWUgdG8gd2FpdCB0byB0aGUNCj5pdGVyYXRp
b25zLi4NCg0KQWdyZWUgdGhhdCB5b3VyIGNvZGUgaXMgbW9yZSByZWFkYWJsZS4NCkkgd2lsbCB1
c2UgeW91ciBzdWdnZXN0aW9uIGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzICYgUmVnYXJkcw0K
U2lhbmcNCg==

