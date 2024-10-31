Return-Path: <linux-kselftest+bounces-21262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC709B84EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 22:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6921F22644
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5711C9EA3;
	Thu, 31 Oct 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kd6/1DXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38D13A87C;
	Thu, 31 Oct 2024 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408794; cv=fail; b=WbKoZZfPRVKpNZ782aTloLZLajc723aQ8xh+0istEEZTPflkxO/uK0mQHmLUErQo7i8IqEwMZ/FaVu2C24yw/o9cbdzqd7oRxeSY9IPd8F2jTSlimPvh4avJyl7p6I1GZaZ2qvaoOTzojGbj4Jg5EHp+UaHM+TivK1XO91VV+cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408794; c=relaxed/simple;
	bh=A1jlGzLcr7WV9CbhyYa775thr6T/0JpT2HRjYMzYsJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gARo2ZiaNVPePFZ7aTXJL3LVTfGjN09d/veO4WKoPJCrIEeRmw/LMWUlrMCmR9Hh1bJkjb+yMkp6J/TRF3R5S41aW6ywMzgLwuzy8RbQV329BIiWHmEZ4ITlNUCzQhGB3wd//WZAddsWNW8k0YncIuv9wmwJQgWRdzDFNACCwrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kd6/1DXm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730408789; x=1761944789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A1jlGzLcr7WV9CbhyYa775thr6T/0JpT2HRjYMzYsJk=;
  b=Kd6/1DXm4GVbLGhLoRpzD1IGUME2HV/zrsczlqp2MbTGA2+A1hnQDQ4j
   viv+X3iznXThmSW1T+e342E1oBpzCjoXmeCwszDnnouGkt5vTkvwkkPyx
   nGLQYf3Slv5t/7SHjT/0aKyH7osVfMvGriMvFXrmrNaqYthsRn86KR7FC
   OIlwU1fa2ZH72b4W39YDhqT/1O+mwWGULUa4/JgkcT8daqO6V7rRtp/Wy
   sIyjok7brt6e7C7ctJrU2c4dWiaY/CHXhBl5+KSL7ot17g9q+4FoKIFQ1
   zbiHKZk+iyL3xaJqKzkUoS3P04goJQCdC3F+5F8HRBxqy7jDNZ7pl31hQ
   w==;
X-CSE-ConnectionGUID: BUb58C87QqmwPhljraDjrA==
X-CSE-MsgGUID: A3xl1OhEQZSRgW/mczJrdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52738654"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52738654"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 14:06:18 -0700
X-CSE-ConnectionGUID: Ad3YupPtQLOiwh+6O1ZOjg==
X-CSE-MsgGUID: Ufltr/OBSXOVmyRK4uNsWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113540346"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 14:06:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 14:06:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 14:06:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 14:06:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukp/c2zo7BUbxQIq1fziJ2tnppgXVpgRiBduwCl+K0wSTXPS2o3qMFudsEickR8XyvH0BxLXvvjL6/O9Od7w6t2REX7zWXaO4BMNAyhnsJ5ep/y+GXkV6IdY7jmR9BQA3IKdfh3M0W3RCS9VoJKYit57+wNUAICZbpOHrp7IUV2T/jch267B2XdPuhZnj/GIN5/J7l8/eFRfeOIfvalAg537kPA4JErL5DXSz1e+1yNt3NsmmaYYragUH7eSCJJKU5S9eUgZUsXJmCLDg3a8zdlnrhaxIyniZBA1vGKLvN0LyphGhHM7FaJwJyZo0flWhS+LoGWEGxnkL3wbGRWmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1jlGzLcr7WV9CbhyYa775thr6T/0JpT2HRjYMzYsJk=;
 b=l7fORxCRRS888xgEZv2a3RGIu/J4cKwOqvOod3ax2Ixnq6fRD0bik8W6bOwa9uiq8DiVZSIITwqhCe96kFRtyj3NrobmDv8YLqeG1ywu1ezU3wJ9P+CAGuZBwjleZDLxo2dyJMTlN1KEDrRP1ZEwQLn25bX1QvvjHEmbWUxbyrV00SWJfbRpWczMbFWEubKGteJRl7VmAKndyxoA+ZW9dqSIsmGBNeRYDOzjDThjst7Q6n7+7hnMNDtRxaYXj50jk5ErkQfssDvOBPTMaKnInyuCuoO3mtdHfgm8GVO4WwYy03A3qWQufi4HTvSFjWKxAmRfYVRITaxRsYtdlYQ+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB5947.namprd11.prod.outlook.com (2603:10b6:806:23b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22; Thu, 31 Oct
 2024 21:06:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 21:06:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "kees@kernel.org"
	<kees@kernel.org>
Subject: Re: [PATCH RFT v12 0/8] fork: Support shadow stacks in clone3()
Thread-Topic: [PATCH RFT v12 0/8] fork: Support shadow stacks in clone3()
Thread-Index: AQHbK8qwrNRMzTtafEWNeVWV00PA77KhWdMA
Date: Thu, 31 Oct 2024 21:06:09 +0000
Message-ID: <fe6cc8010b2b35aaa2629c4c5e972dc1c90c43c3.camel@intel.com>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
In-Reply-To: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB5947:EE_
x-ms-office365-filtering-correlation-id: d29c806e-ff08-46e6-8bd4-08dcf9efd7d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?YlNDQ1ZVYkZqbkZMU2dXS0ZxcW1zOEZucVRPUytyYVVLR1FRbC9JdktPVmsr?=
 =?utf-8?B?SW4zVUJHZDJBdjFWSTBVc01NTjg3bjYzY091UlJuUHYrWUN0a1FZOXBVbm91?=
 =?utf-8?B?MUhyV2sxQnlDblluK1p0dWg5WXByRXhoYUcyaEVxWFZtaDI0Q2xnTm1FU0ht?=
 =?utf-8?B?MnlrNlQyRjQ3S1RObjJTWFNnOXlxTVBFWTFMYXBTYm5UZUpVY01qUzJhb0s1?=
 =?utf-8?B?YkxVYURWZXQvMHVPT2ZGTDdCQk1xQVlDUHFIaXh3RjdmbzBreXgyL1k0OHlS?=
 =?utf-8?B?OFFXdWhLY0N6aUtMbmppZ3BLZ05QaU5EbTZSVStnTTdPaUR2aVozdnZlRXhS?=
 =?utf-8?B?ZTVZb2p4cE1YKzAvUTdzeVVRdlF1NEJOSXlOYTVrSlZOODQyOXozVHJrTmdl?=
 =?utf-8?B?ZSt1aDRxaUlRUEVPSEQrc3NGUUpENllDVGpxR0dDeU9YRDVKMkYzcDRWbjVk?=
 =?utf-8?B?RHdVZ3JGRE13bXZVYTZJRktoNGtwMVFraTM0M0hqa3gycHgxMjZzL080ZVhC?=
 =?utf-8?B?aGptT3dVNHRaTHBFOXFNbkxpUWxaTWNjZWZVV1c4VTVVdEdhaERtcXRFNnBQ?=
 =?utf-8?B?WnBodFlUczRieGQ0cGtlZUJORUpsOWFnRk5ISGlHaElteHZHc3AyUExacEM3?=
 =?utf-8?B?YitoalJ5bW5tMkZKUnd0ZXNZdmNaK3dHZXFnVWREQmNVRkZ3bWo4ZHM5SkM2?=
 =?utf-8?B?UGJWWUlkcEc3UGZTdnNWOTF3ck42MGFkZVBtWWpPU1kyMzNwaWY5UEdJenlz?=
 =?utf-8?B?emxEM0o5RmxWTTlMRzYxbGZxYVU4YVFmVGpLWGtPd2hkQlJpWDZ3b2VYM3Z1?=
 =?utf-8?B?VkZFZjFkY2hhemZuc2ZEYVNpMDVFRVh0QkhDL2xYcFR1anI3VTFFbjRHa1lw?=
 =?utf-8?B?ci9PSmpCSHEyWjNrcjkxRHJJV25JTG5SaitFejBBd2tJVmswalhIQkxPenk0?=
 =?utf-8?B?eUszaTBmMWNCT1Y1cWV0SlZlREUyM0hIcWlZMFRFeTlNelp3dDNtekppVkVi?=
 =?utf-8?B?NEdEeGIwVVp1aUkxcUxJN2RmaEMwNGFYazE4cHA4MmRISXNPU1laZnRKMk9B?=
 =?utf-8?B?Wlp1ejVrN1pGQUpvQkdnUTJ0TWpZUEl4WGVjWCt1bnpxdUpQc3hDc204dGxk?=
 =?utf-8?B?L00raWIvSm16ZWtwc1AvN2swOGI5dWVSS0JwSWtIVHdrNFF3dzlvdEtCOFRl?=
 =?utf-8?B?WkFFb0VUdE1MRGRNdlRDc09Oc043bUozY2JnUElCa3BCSithakxnbUp5c1Fq?=
 =?utf-8?B?dkRoZXVTUmJ6VVJZckthZ2FtU2FCSmpHMjczVlVjWUpoQWVBVjNzUFE4ZVBs?=
 =?utf-8?B?MGYwQkhzNWh5QmRRZkdmS1ljM3FBWW51VEZpY0NLTUxwcFpUQzRQYUM1Smgv?=
 =?utf-8?B?RktZQUtIWk5GRjRCRUVpUXVFVW13N2RLTVBwUTFjWUYrNHBDaTRTNnZVdUNm?=
 =?utf-8?B?dHdud09KcnlIbG1iMkJDNE1YaEtxMk9rSG1JclRwdHVjTGVnU0NTN3pKeVFt?=
 =?utf-8?B?YmhrYXl3ZWs4TVdCNE14UjYzWC84WERZdW9TczJOWGdqQlJXRWdqSlRwNFFU?=
 =?utf-8?B?ZUhkRjVNb1RxVWYxbTI4aGlPdUVmR2ZpUGtkSWRBSGJMNE5Tbkd4VmpoUlFJ?=
 =?utf-8?B?OVBjSFlmcEdwWlRYUWJsRWo5WitCWUxydVFWR0VFR1I3aERpLzR0YmVjbWFX?=
 =?utf-8?B?MnhsdlBCd3pROTdNQVcvZXhicTduQlluZHlYYytiNExLRm5WZ3h4YU0xdnZh?=
 =?utf-8?B?Ty9iN3d4QkpHNjh0Y3V2S0JqZmtWdUxkV1NwbUkrRFRPbURhTmZCaDU2QTlI?=
 =?utf-8?B?bU1QNlF2U2NYRVB5YytuNXkxUGRCN0xMTjdDVEpnUGI5bmVXNmZLMmY1bWVG?=
 =?utf-8?Q?0UGaoOh9pMVOp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3ZVMlZQQ2tLN3EyRVl3UmRIWCtYVzlaYXFnL1BJbzZjbWJTOTZZMERJMmVz?=
 =?utf-8?B?eENUdHZneXVlUG9xU283SFJEUVhINGtoZnJ4TEM3d0lIeEdYUmkwZGMrdWVa?=
 =?utf-8?B?RWVpV0FkcVRoTzlNU29LNk5Yd3M3VTVxMkNUQnkzaWZiV1lmOGFWcmx2eThq?=
 =?utf-8?B?NklkeWUvbnF6OHBKVVB5VWhnaTlmcUxhZTZuV1RxTFNmbEFoQVJNbngxZ1Ew?=
 =?utf-8?B?V28wMXVCWGhHVkJIOUNvZzIyMlQxRGRjNGpKSGlWR0FhczVRcWpoTks0ZWJX?=
 =?utf-8?B?b1ZLSENpYWdIRWNYQWpjNlZ6RXpZamt4ZEc1cTk5b2ovUDFhaG9FVEl0ZE9q?=
 =?utf-8?B?RTlGUURQV01HUXZNcGRqdVRRNEF2bzJYV0h6bVNIYlNmY0ZJc21hblY1UHlO?=
 =?utf-8?B?cDE4ZGxya3V4YzIvR3RycFBDaW9oMGdwVE9XZG5lN21yd3pMM0VFTit4N29l?=
 =?utf-8?B?NGFJcjlOQzkzNTFMVDFnK3FsT01zbjJSdzVsaDBSNmJ0dVY5bCtpYzZCL3ZZ?=
 =?utf-8?B?L0pZM0VoWG5RWE9MSmJkVmhrd1hDdXV0T2V0RDhCdUk1cjdGdmdabkM2R0ts?=
 =?utf-8?B?Qi9ra08waUg3Tm1nZDVnRkpKR2U4aDUreXBFL0hWU05ZQ2Jqb1BSYk9NQTNX?=
 =?utf-8?B?OFpQNDdzdVBTZ2VLUlVvVUU5RDRMeGViaUdRVVRXckxQVlJIT1YyUGZpTTI0?=
 =?utf-8?B?N3FqUXduSitzcWlwaTYzVGplRFRKdmZrbkNDcmluSUI4ZDNXUDFmVllNNEVi?=
 =?utf-8?B?bE5NZXNCOFVsdnB4RkEyeC9WT3BmUmpEL3FTMTk3NXh3WjJ2Q1A2SUtQbGtt?=
 =?utf-8?B?RSt6Q0c5dVFKOUdIL0oySkFOdUx1TEhlRUdtTmkzRnM4bFA5NlkrYk13cmhx?=
 =?utf-8?B?NmcyaUZYTEpBMjIxTEF2U3ZWbEpLVmVtcDhSNkplaHM5Rnlmd2RFVzVJS1Nm?=
 =?utf-8?B?TnpiaGVaeTNRYXB3WXJKM2F3ZjlkRk41aXZiQkJTSVlaaUpDZ2hhWS9BSUJk?=
 =?utf-8?B?dHVubzdnMGpuMUhWRkVsSFJpcEpDNGVLWlk1bTYzU2I0ZWtBcUNHSjVjbUVI?=
 =?utf-8?B?STcxV0piRmlhc2ROS1dhT0ZEdnZvWHh5bDJjR25vblVxditqSWRnVGZ0N1E0?=
 =?utf-8?B?Ti8zQ1Mrd2dZaXU1NWRJNkwvODlMbEpjWnlzMmFQcFhVVm0zMzFCQ0kySjRU?=
 =?utf-8?B?TUdxQ1MrZStDYVY2TXpTbFF5Qit2VlJqVVVGZ3BhZlNWZTJZY3V1cG1zcVlP?=
 =?utf-8?B?NmZsVXJFK3I0VnJOQkFPcGJYMW1scnlPOGhYZ0Q4SGZ1L3ZpbFlvK0ZYSVY4?=
 =?utf-8?B?bUU2M1k2OUxvTlZjdDBZTC9wdXNWdVRrYjIxeDdySU9mNlVRaWt1Vno4a1Vq?=
 =?utf-8?B?azd3c1dEQ0dtUGV4S0JndnZzYWxRRUZzazZDZmVNVmRRT2tHdVNETmVlK0JZ?=
 =?utf-8?B?Z2RYdlpOZW1HanZSTllybzRubnRmak5HNFRMdlZnWFRPVTRMV1VISHk2allp?=
 =?utf-8?B?cEttczMyMWNTVFlsNlo0bWpSSGdFK050aTB2SUZSRVVLdFllS3graS85dU85?=
 =?utf-8?B?c0VFQlJDeitoNFFVblVGWGR5Yjc1Ni9iYXNscmFtS1pQallSdnVaOFYrU2Jz?=
 =?utf-8?B?MTFNRkYvU09nekxjdlh1eHU3L2Y2K0VKVlVIak0zczF6eERYRlJoZ0VRZmpL?=
 =?utf-8?B?WTBOdEJ4ckc2MU9PSHZjVVpVRk9kZktPWTNmNXFFdDBDY0kyRUh5dGJ5c09y?=
 =?utf-8?B?VGt3NklRckJpTUhqRUNqS1h1eGF1Yk50Z2RMLzZlTGY1bTNjUnRJSlVoZTZJ?=
 =?utf-8?B?aE1KTEkycms2aGZQSjJnM2pZaWg0Q3BkM3ptL3RpUk44aW5pbzNwTXI5ZmdK?=
 =?utf-8?B?c2JNTC9Yc3FWbmlXb2pUeEp1bk1iSTBUZUl2SEJ1dGFBWnloYWg2cGt3Nk0y?=
 =?utf-8?B?M0tRTGdJckY2TGRWRFNic1VLZUVESTY2ajlHTkZFbVZsUndlNE1SbmIyTlNM?=
 =?utf-8?B?Q1hmK1oxK05TbzRaSFFGN2hwTlMvd1o5ajV4ZVlvMUpXOStBUnNEdituQ1FS?=
 =?utf-8?B?K0V6UENveGZ2MWhUWGltdjYybm5uMXZvMytjWVVnbHBxZHpqaXNiY014RCth?=
 =?utf-8?B?SkVTS0UxRTUyS1kwQytFQzdrMFRscE94eGMwZ28xMVhtQ2pWd2U4YytPTDda?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40547855F566B14B9CBC971926569448@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29c806e-ff08-46e6-8bd4-08dcf9efd7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 21:06:09.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0F6/L1/xB9Jqt+Cms/a9Icys0PnfMbMtQDQ2XukmXJc/90CSH9uUURw96Jj5F1t36M+A3ILqsIoqKpvbpe9ob3Un7sPGoEYxKdkWmKlLSak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5947
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTEwLTMxIGF0IDE5OjI1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAt
LS0NCj4gYmFzZS1jb21taXQ6IGQxN2NkN2I3Y2M5MmQzN2VlOGIyZGY4Zjk3NWZjODU5YTI2MWY0
ZGMNCg0KV2hlcmUgY2FuIEkgZmluZCB0aGlzIGJhc2UgY29tbWl0Pw0KDQo+IGNoYW5nZS1pZDog
MjAyMzEwMTktY2xvbmUzLXNoYWRvdy1zdGFjay0xNWQ0MGQyYmY1MzYNCg0K

