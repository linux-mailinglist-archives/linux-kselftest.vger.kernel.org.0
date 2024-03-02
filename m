Return-Path: <linux-kselftest+bounces-5776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1C686EE76
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 05:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696B51F2112B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 04:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314458F5C;
	Sat,  2 Mar 2024 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK1NGvAf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1C10A05;
	Sat,  2 Mar 2024 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352257; cv=fail; b=OPJmgFuqEMd+ZE4eIosSofnbWHC8aJh+8GGoMoG9UJjoPlAytwTUpTJBDZqagZm1UNU0Gxq4gVk1YnjG+7IUluNcDZeGr2AIhFDwYka6rNPIFPvvABYS1zZ4ZqRDGlKc+GRQBpJwhhuF2TJu+u2hH+A0a3ZEDZnmBdaHNecC/PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352257; c=relaxed/simple;
	bh=kSpgd/PzSBzZBI5c4KmMlw0jh3W7Wul7IDGvE382Meg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zya5IQhNCyk5nzoYTCcPh1W6A3A2/NnX7LadS1XjN30conkHs3MoQOj3TEnA+ICOvAkB4hKciUWMpqpVLW5hbN4CIpW25P2DVAucYUNIJUfKKmz8g4bAfnKIG4w07w9sRvtCeJpmRHF1weYIDVtg2NLXEGPSX/FbwOSb+6h7evk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FK1NGvAf; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709352255; x=1740888255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kSpgd/PzSBzZBI5c4KmMlw0jh3W7Wul7IDGvE382Meg=;
  b=FK1NGvAfoSjyY0ZWSDsnn/yH1f0Ha0Jopg68ZY8k2mrZrZDSQM/M9aP7
   vonnIimKRuQlfDS1Z3mlTFb/W4EvZubmsimctpcXS5s6ENe2XMMGAFBCO
   gsjBWoCNKvOjBY0oewXJ/c1EaLPBgGbzumjoLZh6kuqB8ldosuqJ0aBYu
   eLbP8nlB/jOsLmNSO84frCTil5iIwTn7jGDM2EpjD5NanLaYuwKwJLBVj
   KmsVVv0D4fJkGT9LKTEM91/sOKfpgmMnEfJ/6TViGi4OmtyRtH/SNmt0d
   unBr/cXsZlGYYqkywukhPHmACfTYm66nSPf5uuaBYi1gPcIa6kWhmrA9U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7725625"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="7725625"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 20:04:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8332331"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 20:04:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:04:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:04:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 20:04:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 20:04:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0p/kRSrG0rhqUqpxjAggxez/a5T7xdPSs9iQOQcpZZRf1gHY+AbWP+bGxpNp9CdOura+T7n+TBTy8ba58zg8tlstyb1WJuD4CyV1GYLEnQaycioq2kz0ROasJ49nO/HARCki5IdlaIKy/6Hb4oRioYDmqnYEZW+qlS5cyvKTdMu2hUgfahvtCBFcFd1A2/pgsNw1rL1GflZw2L60t3WnPvkcyZsNB4889j65mgdIjQ3eOvCOvr7IKmN+FHpGXB8ABcRdhYlBK5oyM1S5gZQHtR/NsnB3QMpTmOghIt/6wJzRo4cmy8B5alMk11NZTx5xVbV7SicXXEweH5FtEkE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSpgd/PzSBzZBI5c4KmMlw0jh3W7Wul7IDGvE382Meg=;
 b=nD6Kwgwmr6VTAlOKwudpqHAfV8AKn0l8QlKlqFvIpOs/bwMuM2ENPpWwOZbSt/wvK3NKE7NSdIQAVbVewSK6IOdHekVZwmGd0xMzj8ccAXgbptJ96M3TF1Q0+/6L3cV9iLmTQS0HK6A2yPRvLQ0YQExWVdFMa6NNX3XFJt2CNJox6EgH+gCLzzTLN82iTkWX241MP349GBLpLdZv9in1V25d+nmAWtrFUUOqXn7voq83yCoIFryO5p5QITr1uaiHixdRi44wJP0gosX9Q89UcXBgKvaeTTz+DVNtGnI4izwjYv3zj9vIaXoYdAfJ0kucC04uBI+r474eAXX7V/CIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 04:04:09 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a%7]) with mapi id 15.20.7362.015; Sat, 2 Mar 2024
 04:04:09 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: John Fastabend <john.fastabend@gmail.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Bezdeka,
 Florian" <florian.bezdeka@siemens.com>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: RE: [PATCH iwl-next,v2 2/2] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Topic: [PATCH iwl-next,v2 2/2] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Index: AQHabAGNMRi+WAUgMkShE1BGP39O97EjyRHg
Date: Sat, 2 Mar 2024 04:04:08 +0000
Message-ID: <PH0PR11MB58305CA6B9ECA2005DC315CCD85D2@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240301162348.898619-1-yoong.siang.song@intel.com>
 <20240301162348.898619-3-yoong.siang.song@intel.com>
 <65e2165a89ed0_5dcfe20823@john.notmuch>
In-Reply-To: <65e2165a89ed0_5dcfe20823@john.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SA1PR11MB5828:EE_
x-ms-office365-filtering-correlation-id: 8b83dcae-199b-46fe-7010-08dc3a6dcf9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfjYnQXhzBt+pUGkH7R6fdJrt3Ku1kS4Jq/gfOYQLE6F0LDOinm8rokBhibQLDxUYIH/1H5ZiI1HorqRiq01WW9nPWP1wfwnMoPkWL1i4BTiDeEjB38i0hU8WcM/SpWN2APozUcX7A0FLurC/WJ1dJMFs5BrVJy5r/pFlzI3zA6jbBMzFK8Sf7UgR0c9XWfkpXO/beJsN6p10/pmivML/GsO7ZXEO1of0W83SPxnmce0jce1a0Qlb7J41kOEo0e0B6bEvU6HDvqCKPEkchlVtvmBpouSzc9Q0Kwvxb/AQeVL7P47Q7Zhkq92cIWKd193QfcBrORhhYBoCy6ql8sg2Y/VZfoZ1MSWJlht5w2GKUY6YPR5IXNFV8I1OvXz+VB6Yjs+/kROnYMiTWBuFcqf330YVCdeo9enpTqBGd604ADXBuIF464oJSw9ZVJbJuim2q48ryzYecN5z3sBgOzU1bGuNJxusYwPXprx2p4+LBCc0otzr8HE4QJqXHlAU4W7bFIzLqPqHDPHjCUvMHf24Wq+uCLgP0QDoneYLUCb1wmU2pp9hA9AkOVrQf+tWsmz1h/EXzem4WGNXlpNFR3bDSXbQ1nVXN58m8hlPEap0VnbTXcGAG7oJzGnaSX+UqJL4n8tORngqQvfg2ZPqW1PUOPEgqAG6XrRsblMgbUOGWEXHHMJR3b6fwSp0u+7zObLGwEVhUL8xEaTnmQiiePM4fudVAcS7cNOGLRw10BL8qQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDJJMEMzcTgrTHJVbWsvUk1FeTJEZlFnWkZhTmNabDV1ZnJxVEtiUDU3ejhx?=
 =?utf-8?B?OXA5eFlrTmxuRUkwZExrTGcxb0Fidzd2OWIxWFE5Z01JQ1RYeUZqcTFuczR1?=
 =?utf-8?B?QlBhekNheFhlbjgxVjFZOEZvZmllYzNoSUxtd01wZFZvSU1GWFY3SjJZeW5U?=
 =?utf-8?B?eVhZcnJ1a2EyS2JjcnQ5eVpDNWIvL0o4YXJRTGxIZ3NJWW9HQXFHRHQzVWEv?=
 =?utf-8?B?em4zOUZkSGxqUnQwOEhxbHBzb00xcUx0Z1BvVERQZVNyelB0Q01ZbVU0ei9I?=
 =?utf-8?B?clpyaXpWMFBiLzc3aXUvUlVBMmZGNFM4RWc0d3dDZHhUYUU5NUN4L2RBOUtp?=
 =?utf-8?B?YlB3RUExUHVSZ200OWZvVWQyUlpxYmMrSDhzNlZTWFA5NVRXdjhGYnFRdWUv?=
 =?utf-8?B?T0xISm5HVTY3YWt3YnBiL3pUbHR1WklCQ3FzcEYzWExMWENoby9yZ3hRNXc1?=
 =?utf-8?B?ODhVT1BteEdFTEh4ZFc5WUZGb1ZpYnpDUDJNQU1xWGM2REVhSVRWWlZ1Sjg4?=
 =?utf-8?B?STNzK3pCajgwbGFrQVNGeHpBQnU3RmtXUFdaQzhWVmw0b2NhelJrcHg4ejkw?=
 =?utf-8?B?NzZueXBjb3dwNzFXRVpmTFovRHpNVUF2SjY1cWpmWjBTTXBDNHhDSzVKRUtx?=
 =?utf-8?B?MUJrOC9saWdHbmsreWltem5mTFpRdWFacmowcjBHb3BJWW9Cb1JjdVBrMWFI?=
 =?utf-8?B?TjRxRzVBUjBYTXFTSXdkc2tyMkwvRFVRdnIxaE5aSjBVM0x1SGQxMXZPVnNl?=
 =?utf-8?B?dGZPVWVRZnlqcU5yL29lYlkwN2I5N2RtRnZPMUxWZnZMZnZGK0twc2FYc00w?=
 =?utf-8?B?MkM2SURuU0I0M1RTVkY5emVWcnpRYXhYWTZBSkc4RXluMXpaOHRERXdSbjk4?=
 =?utf-8?B?YTR5Y29oa1ROeXZsaGFZS0VkN1dTZFlNMkhsM0VDN0Z3RHBRZWRGSFBMUVpJ?=
 =?utf-8?B?VVJhUCtqWVAvY0xvYmpUeEFFM1F5aEU3ZXZBU3c5STVCaXpiTEtkTm9FTWZs?=
 =?utf-8?B?MmZGRUdyRm9rTFNXdGlJRTdBVVBSNzZjQkI2cWpKbEMrZm5tMkFNcnJ6aU1Q?=
 =?utf-8?B?aTlNUmJUYkJmSnZ2dGNNQkhpek5aRjVacVEyOTlDUHVIUFZzemp0RUpkdXJw?=
 =?utf-8?B?bXV1b1NGYjVkWTkveVIyRk9KOE9wcnVXYkJLOEx6UDNPR2JsQzFFc1NTTWJG?=
 =?utf-8?B?ZEgzUU9wYWpSclN5S2QzS0t5djlNSWVnS285Vi9tK1hDbENBZnkxL25ZOGtK?=
 =?utf-8?B?TzQ2TE9SKzV0c0JwazdNOUFQN0Z6Q095NWlnM1IrT3plYzViWlRBWEIybUJC?=
 =?utf-8?B?a3lhL3VudG40VW5aS3pLcDVPdjA3ZjE5L3NwNk5xenU4NW9HcThFQjNyaGxK?=
 =?utf-8?B?Tnh3bUdxeUh1ZFVEN0hMRW5tUzRMQkhOYS9DT1VqOVkzWUJQR01FQVQ0emM4?=
 =?utf-8?B?V3VNNXJ3WVoxSUl0TURPcHBhWjk2SnFXZXgwUXNhTEhVZGN0WGg5WHZoOEdq?=
 =?utf-8?B?VlFGRkswWkVObTlmZXFxWVpQbkovckU4U2NJc05TbHloYVFvL1V5SGsrSzRZ?=
 =?utf-8?B?Z25WSnZ3KytIMko2YzNjM3UwSjA0cEVLZnlzck9pS1lxMUpTOWthRVBtZWMr?=
 =?utf-8?B?bFVER2xVS2tkcUo1cFhrQ0tiUW1wM05pZHBETHRRUy9kWUZjSUtOa044Slpo?=
 =?utf-8?B?UE5KSWovZ3VBM1JiYlhZOVFBYmVwSjBadTJ4T01pUHRwVFRCTWpVdmV1NVNT?=
 =?utf-8?B?R0Y4YkpqOEJ4VFRjTEhFM3BPZnBiSUNBZnJmdGk2UE9GWkZhQ1pzTEFxVjlP?=
 =?utf-8?B?STg2OWdsdEpiVXpENlREVVZBWUc3d1owVy9wRG9sTWovc3VKNk1uNWdQV2wv?=
 =?utf-8?B?dnhZVTlJVzFKNmVHOVVYTjdLaHE3UVZySEE2UHpndGpNT1NCVHh6Q1Y2bU80?=
 =?utf-8?B?KzRHUHd5endNekpqUnc2eXNwaVpVZk15V2padnI5Q1RKRzBlV0xJOWRxVkhX?=
 =?utf-8?B?aGRDdTZhL2NkUzgzM0ZyT3VGaEtKclNieTZOaHdhTFk2U2luZDN1QUV2Zy9Q?=
 =?utf-8?B?YXM3ZmxVR283RDZEZGhqTjkzdlJmNUxwYkVsNStTL2xtem5TOU1vbnhqSmRU?=
 =?utf-8?B?bVhaZnBxWm95ZkVJbUV0M1V0dXVaL3JIcEw2SEcrYWJlRGF1Q2J3WVFQZHJG?=
 =?utf-8?B?ZXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b83dcae-199b-46fe-7010-08dc3a6dcf9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 04:04:08.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bjAxwLGyPjht/9lN3d9ORlxH4vmFid6/dGdd9NJwHxsd31Ri/lCUxq202E7RHpUt3FlCz9SKmRFIwtgnYafIyVi++uq2oT3IGMit8QUnyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com

T24gU2F0dXJkYXksIE1hcmNoIDIsIDIwMjQgMTo1NSBBTSwgSm9obiBGYXN0YWJlbmQgPGpvaG4u
ZmFzdGFiZW5kQGdtYWlsLmNvbT4gd3JvdGU6DQo+U29uZyBZb29uZyBTaWFuZyB3cm90ZToNCj4+
IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IHRvIHBlci1wYWNrZXQgVHggaGFyZHdhcmUgdGltZXN0
YW1wIHJlcXVlc3QgdG8NCj4+IEFGX1hEUCB6ZXJvLWNvcHkgcGFja2V0IHZpYSBYRFAgVHggbWV0
YWRhdGEgZnJhbWV3b3JrLiBQbGVhc2Ugbm90ZSB0aGF0DQo+PiB1c2VyIG5lZWRzIHRvIGVuYWJs
ZSBUeCBIVyB0aW1lc3RhbXAgY2FwYWJpbGl0eSB2aWEgaWdjX2lvY3RsKCkgd2l0aA0KPj4gU0lP
Q1NIV1RTVEFNUCBjbWQgYmVmb3JlIHNlbmRpbmcgeHNrIFR4IGhhcmR3YXJlIHRpbWVzdGFtcCBy
ZXF1ZXN0Lg0KPj4NCj4+IFNhbWUgYXMgaW1wbGVtZW50YXRpb24gaW4gUlggdGltZXN0YW1wIFhE
UCBoaW50cyBrZnVuYyBtZXRhZGF0YSwgVGltZXIgMA0KPj4gKGFkanVzdGFibGUgY2xvY2spIGlz
IHVzZWQgaW4geHNrIFR4IGhhcmR3YXJlIHRpbWVzdGFtcC4gaTIyNS9pMjI2IGhhdmUNCj4+IGZv
dXIgc2V0cyBvZiB0aW1lc3RhbXBpbmcgcmVnaXN0ZXJzLiBCb3RoICpza2IgYW5kICp4c2tfdHhf
YnVmZmVyIHBvaW50ZXJzDQo+PiBhcmUgdXNlZCB0byBpbmRpY2F0ZSB3aGV0aGVyIHRoZSB0aW1l
c3RhbXBpbmcgcmVnaXN0ZXIgaXMgYWxyZWFkeSBvY2N1cGllZC4NCj4+DQo+PiBGdXJ0aGVybW9y
ZSwgYSBib29sZWFuIHZhcmlhYmxlIG5hbWVkIHhza19wZW5kaW5nX3RzIGlzIHVzZWQgdG8gaG9s
ZCB0aGUNCj4+IHRyYW5zbWl0IGNvbXBsZXRpb24gdW50aWwgdGhlIHR4IGhhcmR3YXJlIHRpbWVz
dGFtcCBpcyByZWFkeS4gVGhpcyBpcw0KPj4gYmVjYXVzZSwgZm9yIGkyMjUvaTIyNiwgdGhlIHRp
bWVzdGFtcCBub3RpZmljYXRpb24gZXZlbnQgY29tZXMgc29tZSB0aW1lDQo+PiBhZnRlciB0aGUg
dHJhbnNtaXQgY29tcGxldGlvbiBldmVudC4gVGhlIGRyaXZlciB3aWxsIHJldHJpZ2dlciBoYXJk
d2FyZSBpcnENCj4+IHRvIGNsZWFuIHRoZSBwYWNrZXQgYWZ0ZXIgcmV0cmlldmUgdGhlIHR4IGhh
cmR3YXJlIHRpbWVzdGFtcC4NCj4+DQo+PiBCZXNpZGVzLCB4c2tfbWV0YSBpcyBhZGRlZCBpbnRv
IHN0cnVjdCBpZ2NfdHhfdGltZXN0YW1wX3JlcXVlc3QgYXMgYSBob29rDQo+PiB0byB0aGUgbWV0
YWRhdGEgbG9jYXRpb24gb2YgdGhlIHRyYW5zbWl0IHBhY2tldC4gV2hlbiB0aGUgVHggdGltZXN0
YW1wDQo+PiBpbnRlcnJ1cHQgaXMgZmlyZWQsIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciB3aWxsIGNv
cHkgdGhlIHZhbHVlIG9mIFR4IGh3dHMNCj4+IGludG8gbWV0YWRhdGEgbG9jYXRpb24gdmlhIHhz
a190eF9tZXRhZGF0YV9jb21wbGV0ZSgpLg0KPj4NCj4+IENvLWRldmVsb3BlZC1ieTogTGFpIFBl
dGVyIEp1biBBbm4gPGp1bi5hbm4ubGFpQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IExh
aSBQZXRlciBKdW4gQW5uIDxqdW4uYW5uLmxhaUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBTb25nIFlvb25nIFNpYW5nIDx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pg0KPlsuLi5dDQo+DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIGlnY194c2tfcmVxdWVzdF90aW1lc3Rh
bXAodm9pZCAqX3ByaXYpDQo+PiArew0KPj4gKwlzdHJ1Y3QgaWdjX21ldGFkYXRhX3JlcXVlc3Qg
Km1ldGFfcmVxID0gX3ByaXY7DQo+PiArCXN0cnVjdCBpZ2NfcmluZyAqdHhfcmluZyA9IG1ldGFf
cmVxLT50eF9yaW5nOw0KPj4gKwlzdHJ1Y3QgaWdjX3R4X3RpbWVzdGFtcF9yZXF1ZXN0ICp0c3Rh
bXA7DQo+PiArCXUzMiB0eF9mbGFncyA9IElHQ19UWF9GTEFHU19UU1RBTVA7DQo+PiArCXN0cnVj
dCBpZ2NfYWRhcHRlciAqYWRhcHRlcjsNCj4+ICsJdW5zaWduZWQgbG9uZyBsb2NrX2ZsYWdzOw0K
Pj4gKwlib29sIGZvdW5kID0gZmFsc2U7DQo+PiArCWludCBpOw0KPj4gKw0KPj4gKwlpZiAodGVz
dF9iaXQoSUdDX1JJTkdfRkxBR19UWF9IV1RTVEFNUCwgJnR4X3JpbmctPmZsYWdzKSkgew0KPj4g
KwkJYWRhcHRlciA9IG5ldGRldl9wcml2KHR4X3JpbmctPm5ldGRldik7DQo+PiArDQo+PiArCQlz
cGluX2xvY2tfaXJxc2F2ZSgmYWRhcHRlci0+cHRwX3R4X2xvY2ssIGxvY2tfZmxhZ3MpOw0KPj4g
Kw0KPj4gKwkJLyogU2VhcmNoIGZvciBhdmFpbGFibGUgdHN0YW1wIHJlZ3MgKi8NCj4+ICsJCWZv
ciAoaSA9IDA7IGkgPCBJR0NfTUFYX1RYX1RTVEFNUF9SRUdTOyBpKyspIHsNCj4+ICsJCQl0c3Rh
bXAgPSAmYWRhcHRlci0+dHhfdHN0YW1wW2ldOw0KPj4gKw0KPj4gKwkJCWlmICh0c3RhbXAtPnNr
YikNCj4+ICsJCQkJY29udGludWU7DQo+PiArDQo+PiArCQkJZm91bmQgPSB0cnVlOw0KPj4gKwkJ
CWJyZWFrOw0KPg0KPk5vdCBob3cgSSB3b3VsZCBoYXZlIHdyaXR0ZW4gdGhpcyBsb29wIGNvbnN0
cnVjdCBzZWVtcyBhIGJpdCBvZGQNCj50byBkZWZhdWx0IGJyZWFrIGJ1dCBpdCB3b3Jrcy4NCg0K
SGkgSm9obiwNCkZpcnN0IG9mIGFsbCwgdGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNo
Lg0KSSBhZ3JlZSB0aGF0IHdlIGNhbiBtYWtlIHRoZSBsb29wIGJldHRlci4gDQpIb3cgYWJvdXQg
SSBjaGFuZ2UgdGhlIGxvb3AgdG8gYmVsb3c6DQoNCmZvciAoaSA9IDA7IGkgPCBJR0NfTUFYX1RY
X1RTVEFNUF9SRUdTOyBpKyspIHsNCgl0c3RhbXAgPSAmYWRhcHRlci0+dHhfdHN0YW1wW2ldOw0K
DQoJaWYgKCF0c3RhbXAtPnNrYikgew0KCQlmb3VuZCA9IHRydWU7DQoJCWJyZWFrOw0KCX0NCn0N
Cg0KPg0KPj4gKwkJfQ0KPj4gKw0KPj4gKwkJLyogUmV0dXJuIGlmIG5vIGF2YWlsYWJsZSB0c3Rh
bXAgcmVncyAqLw0KPj4gKwkJaWYgKCFmb3VuZCkgew0KPj4gKwkJCWFkYXB0ZXItPnR4X2h3dHN0
YW1wX3NraXBwZWQrKzsNCj4+ICsJCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGFwdGVyLT5w
dHBfdHhfbG9jaywNCj4+ICsJCQkJCSAgICAgICBsb2NrX2ZsYWdzKTsNCj4+ICsJCQlyZXR1cm47
DQo+PiArCQl9DQo+DQo+Wy4uLl0NCj4NCj4+DQo+PiArc3RhdGljIHZvaWQgaWdjX3B0cF9mcmVl
X3R4X2J1ZmZlcihzdHJ1Y3QgaWdjX2FkYXB0ZXIgKmFkYXB0ZXIsDQo+PiArCQkJCSAgIHN0cnVj
dCBpZ2NfdHhfdGltZXN0YW1wX3JlcXVlc3QgKnRzdGFtcCkNCj4+ICt7DQo+PiArCWlmICh0c3Rh
bXAtPmJ1ZmZlcl90eXBlID09IElHQ19UWF9CVUZGRVJfVFlQRV9YU0spIHsNCj4+ICsJCS8qIFJl
bGVhc2UgdGhlIHRyYW5zbWl0IGNvbXBsZXRpb24gKi8NCj4+ICsJCXRzdGFtcC0+eHNrX3R4X2J1
ZmZlci0+eHNrX3BlbmRpbmdfdHMgPSBmYWxzZTsNCj4+ICsJCXRzdGFtcC0+eHNrX3R4X2J1ZmZl
ciA9IE5VTEw7DQo+PiArCQl0c3RhbXAtPmJ1ZmZlcl90eXBlID0gMDsNCj4+ICsNCj4+ICsJCS8q
IFRyaWdnZXIgdHhyeCBpbnRlcnJ1cHQgZm9yIHRyYW5zbWl0IGNvbXBsZXRpb24gKi8NCj4+ICsJ
CWlnY194c2tfd2FrZXVwKGFkYXB0ZXItPm5ldGRldiwgdHN0YW1wLT54c2tfcXVldWVfaW5kZXgs
IDApOw0KPg0KPkp1c3QgY3VyaW91cyBiZWNhdXNlIEkgZGlkbid0IGZpbmQgaXQuIEZhaXJseSBz
dXJlIEkganVzdCBuZWVkIHRvIGxvb2sgbW9yZSwNCj5idXQgZG9uJ3QgeW91IHdhbnQgdG8gc3Rp
bGwgJ3RzdGFtcC0+c2tiID0gTlVMTCcgaW4gdGhpcyBwYXRoIHNvbWV3aGVyZT8NCj5JdCBsb29r
cyBsaWtlIHRyaWdnZXJpbmcgdGhlIHR4IGludGVycnVwdCBhZ2FpbiB3aXRoIGJ1ZmZlcl90eXBl
ID09IDAgd291bGRuJ3QNCj5kbyB0aGUgbnVsbC4NCj4NCj5JIHN1c3BlY3QgSSBqdXN0IG1pc3Nl
ZCBpdC4NCg0KU2luY2UgdGhlIHRpbWVzdGFtcCByZWdpc3RlciB3aWxsIG9ubHkgYmUgdXNlZCBi
eSBlaXRoZXIgc2tiIG9yIHhzaywNClNvIHdlIG1ha2UgdHN0YW1wLT54c2tfdHhfYnVmZmVyIGFu
ZCB0c3RhbXAtPnNrYiBhcyB1bmlvbiwNClRoZW4gYmFzZWQgb24gdHN0YW1wLT5idWZmZXJfdHlw
ZSB0byBkZWNpZGUgd2hldGhlcg0KdHN0YW1wLT54c2tfdHhfYnVmZmVyIG9yIHRzdGFtcC0+c2ti
IHNob3VsZCBiZSB1c2VkLg0KDQpNeSB0aG91Z2h0IGlzLCBieSBzZXR0aW5nIHRzdGFtcC0+eHNr
X3R4X2J1ZmZlcj1OVUxMLA0KdHN0YW1wLT5za2Igd2lsbCBiZWNvbWUgTlVMTCBhcyB3ZWxsLCBh
bmQgdmljZSB2ZXJzYS4NCg0KVGhhbmtzICYgUmVnYXJkcw0KU2lhbmcNCg0KDQoNCg0KDQoNCg==

