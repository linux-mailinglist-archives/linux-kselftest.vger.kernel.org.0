Return-Path: <linux-kselftest+bounces-42488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6225BA4737
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C07E189A000
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB20215F7D;
	Fri, 26 Sep 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCOvPqNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEA1D5154;
	Fri, 26 Sep 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901199; cv=fail; b=WxoLswVxFttSMA8s62+AWWqMN4zd3358VBAwNryvPiw/ZeCHoYLNH344iKGA1HVC1eyGcVeHBH/a5fclOfNbbaQ77jOw73GAEbd+SCiAONLrdffrVCXICNkZ+BPMn9Vc39S/MfL28FF7tItleoli1/gbHZBJ/5LPvHC9pvtYSag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901199; c=relaxed/simple;
	bh=9VWa3SRJOyWdYbwCw/j2qv4Rerz6uqmcivaRjkGcBIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKwmnjmsLU0idYB18zBEfeELHRYCCI3hsFDR7DgiWpgLO3UuAUQIOOo/BwcAtiQpHeSmOwUE4AIFUB0E4M8E5JPE++0gdSANDEStNiwKZr6NzRMGRkI5PiJbwNKvAfhKPM+c/xNTuKPPGedS91ZMeBGBYyQVp9zeNZSrSdgnayo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCOvPqNa; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758901198; x=1790437198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9VWa3SRJOyWdYbwCw/j2qv4Rerz6uqmcivaRjkGcBIA=;
  b=fCOvPqNaRej824cVMrEySAZDAEw4oF3pD5C655CcoYRx12wCqflHX4Td
   rXdrxGjmrUxGMM8pA9EEPAeiRP1V5c+Svx9WI/NKR19qPgqgIB2uPgLJc
   AhxdXRc/GWFD6kILBD80Q4hujYmvyhAZ7B3veXlLdsoy6xprHc39pFqYj
   1dhSFdwn8+oSUYLIz4V7SwkPfhUURcSxz9J77nWdIQ0d4+M1RGs2h43y3
   WyuwtlxSIVE76yTBaiuSzLslY1xU36NoloC05OBCQIxd/H4bV25B2noph
   7W89Mlfp9opxnnPPhHpH+Rk2VsW/T5ztM+24kgsLxjwCH3T5fFYgZVu+2
   w==;
X-CSE-ConnectionGUID: nGzSzbr5S2idusXLBF+ldA==
X-CSE-MsgGUID: SL4CkYUiQme4MyEYNwdJoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61346477"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61346477"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 08:39:57 -0700
X-CSE-ConnectionGUID: OEXlGkF+S7ef/9i7vnGduA==
X-CSE-MsgGUID: lj8CxJW7Sge256bRNxLEVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="208390550"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 08:39:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:39:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 08:39:55 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:39:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfHsSBxPpnWBEhImrrAa92cb+hvFIf/vhB45DE7K5aOkYgqNOG2DwFOzpysz1Dn3qHNHwo5X/rblPQ4tKaW6J+X0UGqF5Lst59uqdtQe989mhckkMmaTF3zfEFE6HaacRo4mrhe0TzN5AasPA3Cr1snIbVTBfc5umd6tqLUZnF6nWsIzQPiDfI1rkDAsX7VwCIaKDpIOgIp8vJpDYUN1DTtqqJKVXijGHp45++0ijJapRZUwSMyPtVxca1eQQvnvVyOPEYw9A/V2lHMndAk3oy+Lcm/dJrL2kReYeFiVkcMfwDgM6O7QUGI5rFgMCdOBc1YNrRdKVT6csBezjTY/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VWa3SRJOyWdYbwCw/j2qv4Rerz6uqmcivaRjkGcBIA=;
 b=X9xd9rsgK+Je7Ca/5VeXxQwtSYnY5W1dA2JPXigofwqhp7TtbzqAOudOuA4jkiaGYsoAbWM2+YV4lXm07pZJeRbaRcQpT1IvJMrT1rXZSZDhIQt2NajhHhdk2/tZKVidbxCRaAF4gLbWEGG/hbpikpBgcMI5xhKSEyQ7zOwBzMWoHPyIMMmoqoGbgggyF3QegqbTGBrc1lEhuxkxKGA0G+xw73diS3M9QS9SPSSwdV3WpxI81WZrW/kqJ3sZukR9YSQRMGLr3F+++LNEZ01cZdUI0BX3SQCDmpx7AlZex7LIQIlj8yW9VT/sYtWJ87+u09/pXMXSqXl9Ev9WSSmtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 15:39:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:39:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>
CC: "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>, "brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "dalias@libc.org" <dalias@libc.org>,
	"jeffxu@google.com" <jeffxu@google.com>, "will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "codonell@redhat.com"
	<codonell@redhat.com>, "libc-alpha@sourceware.org"
	<libc-alpha@sourceware.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Topic: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Index: AQHcKvs2dWZnb030BEKK+EDimBzvQrSkY2wAgAE1TQCAAAjPAA==
Date: Fri, 26 Sep 2025 15:39:46 +0000
Message-ID: <04dc6271e11b453204255779fcd3c29573c9c296.camel@intel.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
	 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
	 <aNasTpkYm8n1AHZ7@arm.com>
In-Reply-To: <aNasTpkYm8n1AHZ7@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6805:EE_
x-ms-office365-filtering-correlation-id: e4670581-eb36-4368-4334-08ddfd12ebf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NHJxMGkzK2FhcFBrdGNFZ2o0cjdoL1l0LzZ6U3VVdzQ3VmtRcTdrdFpTYXpj?=
 =?utf-8?B?cTE0OEh6K25rSjA2b0JiTU5uRHVKdUJwSk15QmhTcXJ0VXJDc3dLUHR5UFJy?=
 =?utf-8?B?TGtkenRSbERjTjJYMngxOHZLRGh5UDZwbUx2RzNSSnVOajNCbEs5YXF3RGJ6?=
 =?utf-8?B?SHRvNGJQRW40UE1MUGlkWWdaejc0SE8wSHdZSFhHRmxSQ3hCaE0yd284dDha?=
 =?utf-8?B?QW80Z1VZcXJqTHZNeWJ2a1FPdzRnRk9RbEtmSm5USE1CYVZsQUpXT2pzRjZr?=
 =?utf-8?B?bEpjZlBHck5xV3QwTlNYUm9HTXVha3B1OWlwUDdsNWljYXM2MGhTWDhEOHZs?=
 =?utf-8?B?MjE0dVJVYlpDcVpuU1pOTTkyaXo5TTRFbU1OYkVsSzQxclhLcGZMcVhuVjRq?=
 =?utf-8?B?NmREQldLMkM3QmpTWjFwZjBhYXFPOG9jTnFMMmJmZnE1NXp6dCt2Mno5UzIr?=
 =?utf-8?B?R1c2QU1zQVpDd3RzMkw5am9qaWszdTVGaWcwYzVyTDRzWHF6NDZubWhKcmpI?=
 =?utf-8?B?am1MNmM2c3RUT2NYTkpWZTg2dUlhWGxQTnhzMmtHUER3Y1FuTnh5YzYrMGxk?=
 =?utf-8?B?UmZadXkzOWEva0lUTVN2VTBLSmg5dEcxVlhhQXA1djRqRmNpK203OXJSVzVj?=
 =?utf-8?B?SEpuajFGRmprWTBDQlVXOFptWHpxRko5MEsrcTZwQjdqWGdGYkJvMFdLN3BI?=
 =?utf-8?B?RHBjZXFRNTlLRlczNXVUVzdUSFR2MVNCbnpsVGtiWkZ3b0N3NDlTMTlvekQ5?=
 =?utf-8?B?dUk2dFBiVW11OURleTVlWDMrb0ZsWFZ1cHFEb0VhemlvZFBtNG9FbHBrK0ht?=
 =?utf-8?B?SldyMGFZbjFOK0JtTnBhR3cybm83V0RIS04yejVKWWxXd3B5SDdlUUZkR3M2?=
 =?utf-8?B?S3hTRm9QMzF2UStoQ0NBQXJNZldGU2tGVUNlTVR1MkFOZXJia29rV1hVVEVN?=
 =?utf-8?B?V1hhTjR1SE5VSFJmaGdRelBEaDNKemlWY1I0enI5eE5la2dRekhtWHQrRVhH?=
 =?utf-8?B?QnJIa0M3L0srM2ZqckgzNGZJeFVkYk0vc205OXpxZ0ZXRmFxalpaNS9yUGtE?=
 =?utf-8?B?TnV5Q25LbER2L2toeGQzb2JJS3VnaW9XeGxyVGRTelJNYktYNlE2S1hOdFZ0?=
 =?utf-8?B?QVNmSnV5dUovVjNabVJhQVpsSXFyWGJ3Ni9SdHEvTG0xK1JvaHVseThPK1JD?=
 =?utf-8?B?SmFwSmRveEdYc0dIakdYbXQ1ck1mampib3pNUk9sVjZjV3BMNkNaTXEwK3Bm?=
 =?utf-8?B?R05xOVFJeFRTU0lFd2NqdlBvNDNGa29CV0NPNlVQVExIWm9KZVdFRTZ0aUkr?=
 =?utf-8?B?b0VDNy9Ua2EraXpoc3ptTk9OSFJ6ZEQrcEZ0KytqUHlNdXFSVzJRRXJGOHZn?=
 =?utf-8?B?RjE4ZjZ5NmNzUTJ2bGhmVjNvdnhDSnJlaFNIcVVLRXpGZE1mVUsvWXV4OU9l?=
 =?utf-8?B?NWI1SEN4NmtFVi9JTzlNUFlGT090TGRlam1ldTdpbjBZdTh0eDU5TVVrQlla?=
 =?utf-8?B?aG5yV05CMjZBcG52bTF2RnZRbFdWTHRXMTVuR0g3UDBBVUJnbnpKTkdMTTRE?=
 =?utf-8?B?SVFSMmVJZCtPbFV5bTJnRDhKckdiTnpWSW5QYkRRWEw5Z1g2a1VDYVptTU45?=
 =?utf-8?B?bWNEQnNZdnRFYW1IK2tJTlNFWVBBTVJnT0JyV2NXTGEvcjR3M3JJRjJSZk9x?=
 =?utf-8?B?UDVlRGtNa09ZYVo1OU9YWUdiNVhQNEFpTWVkTTJsVmhBRDBHY1pabmFndlF2?=
 =?utf-8?B?MWNiaU8vNTAzUkExWVM5S1B1V1lIcWpyZnNUTWhsbmc1UDZTV2FoVUF6aXBN?=
 =?utf-8?B?K0pHbmRzWitKanBTMy8zVFFaeXY4eTljZlpMQ3FXdjE0YWFoYzZVV29WamxZ?=
 =?utf-8?B?amMrdjVFRmpmeTNlSmd1MDAxK0c3T1RlSlhxZDFhRWMrODZNM1MvUzhwcTho?=
 =?utf-8?B?VlZIczZuTmMydmdFZWwySWtSQUE5WjBtNDdUUE40QW5OTDJFZXU5UWltNytC?=
 =?utf-8?B?ZVVlamhKY0pjRWpWOXJqdDYyVUhmS0FvKzVXVSthZXBjS2k5cTJlOS9Yd1V2?=
 =?utf-8?Q?6e44J0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFUMUdGY1RtZ1J3ZkFFU1VNTU1ZTzk1azA0WnRJdUlTY3pyWGlYQnRSaVNV?=
 =?utf-8?B?Y3BSRW1MYlJvSHBUOFIvNWdJcnRiazlOSDEvR0pwcDIyNEY5aUFqOGlodVpo?=
 =?utf-8?B?YzNTeHB4L0tDendGL0VnZHV6akhuWm1LYUZIOVpidjRMMW00L25oRGVXWlRh?=
 =?utf-8?B?QlRCY0R6YWlkZUhKVTU5dGhiN2dKakJiWFBxNHpqY2doQ1p2UkZUNkVpRy9r?=
 =?utf-8?B?VlVUanJKMEc1ZXlaN1djRE94NjUxQjczbGlQOXE4cUtrN1lpU01CZVBpQjhm?=
 =?utf-8?B?VWlUNytqeVc0TzY4TmtENXN1SWoxL0ltNGVkZGhiWjkyQ283RG4wM2VjTzVk?=
 =?utf-8?B?TFowNUt0QUpyQ0FHZkE1Qy9oY2lya0htY2RaN0R1Rm1oOW52ZjMxQ3V2bjNW?=
 =?utf-8?B?bEJLUmlkeDJHcmFzWW9PUEdISTJGcXYrZHNSa0YyNjFmdXVMc21mSTlzTThI?=
 =?utf-8?B?WmxFS2pNN1VBKy9IVXNnZ05hR0oyRG5weXRITGxvM0F1OGY3YWJ3Qm9yZ0py?=
 =?utf-8?B?S2pKSVRmUk50OE9pUXhBL2J1Q3JEczN2dGx3NGh3eXZxK2FlMnU1czU0VXFY?=
 =?utf-8?B?ZVFIbEhFT0ZoWjliQkJRVnFCQmgvMWVWK0VyQUkxZzZZVWxyaGFUTDRNZmZz?=
 =?utf-8?B?RmFnU1EraVJYamI5QkdLb004eEFJTFgvMUhMN0N5RDFuWWRVZjlyUUYwOUI5?=
 =?utf-8?B?YVRsNmVyQWN0V1RiOTBLN3V1Y3I4RzZ6NlRSd0hCbVVDU01wUGVFdzFSSEdS?=
 =?utf-8?B?SUlYMk1pTS9PZkE2MkV0V1pJbTkvSXFrYXVyTk9HcmJqZFRGeTJGQnNJVm9u?=
 =?utf-8?B?bUpNTDFsT2NQWjRTMTFURVRvLzJVNUVOYnhXN283WWhUNlZ1QjlSd0Y4aWtr?=
 =?utf-8?B?RVpNem84VDAzemdhZlFQM1E2VExIMjFWaURkNGtDSFdnbGhxNUJrL1dETXpG?=
 =?utf-8?B?VWJBUHdsSlQzbTBWZURUSWl1TXFDY1VoMEUrclE2ell3K3Rxa1hHOE41a21L?=
 =?utf-8?B?M0sreHpKVjJKeGdOOU02bXB0cS95QjJWTE1yTzNVa0w0dFRyQTJzQlZna05a?=
 =?utf-8?B?NFI4UldYb0FrTW15SDFmcG1IRktTNDVVM05jUXNiOUlOb3JrWDRVS2cvMEIv?=
 =?utf-8?B?UVkrQzBpbjJLa1RvVk9sYU9JT0Fnek9VTmlHWmMrTTBYcW8zR25zWXc4Q09o?=
 =?utf-8?B?WHBlNWdENHBZYXQzeTE2bG1DV2hMQmcrMUEwWEF6VUVTaG1abXdaVFlHK2FV?=
 =?utf-8?B?SXZDamxIV2tRVS9NME13RnV3bnV1YXdzWkdhazdQWVZVVkZESUQ3UkpNT3V4?=
 =?utf-8?B?NkZ4YUsxWVF0Qi9ZUU1WanlCMWRpdVBRTU1HejBrLzBMZmNnUUsrbzR1K3RE?=
 =?utf-8?B?VGtlQXZHUzVIR2I1RFlEaXMwUWdaUytYeWdMcDBIbGRadmE5Q0hLZHM5eXlu?=
 =?utf-8?B?QjkrdkgzQWs1MDhOeUYwbnM1cVdSTHN0MVdadTlFKzNhR2V5TWc5TUNsZENo?=
 =?utf-8?B?dFlwaDRMYmZ4ZVRXNkpJb2NZb2psVERoRkxITFRIRFJXYTdKK1BnSWtSV3Rn?=
 =?utf-8?B?Y3cvZ09OVWxkQ09XZXRQTDV3OW0zRlh4aFZpV1pCMlhwcmdpak5Vdk5OQ0xC?=
 =?utf-8?B?NlgzWXE1RWRlSzBva0VzaG5lRm5wNm52VEFXUm5qZXltMDZlN1M3aDQzTlVR?=
 =?utf-8?B?RnpNc2lFNGRGZkxqUGFjUEtSdXBqTGVhT3lBempjaWkvTm90dE5ZVk5zRDhF?=
 =?utf-8?B?dWxsakZIeWdDc0NsajRSM29qdmxBZkRJUDZCNzg2a1BWVzBrNUsySzVjQ3Ji?=
 =?utf-8?B?RjZBUmdlZDJPblpRcDNoUWs0Z05vNGJIQUNWSUxlRHpyMGg5VGxuSW1lemdt?=
 =?utf-8?B?bUovZVhiYnNYa0FvMHZHMGJvMXE4OWJFd2RFMUJnZzFSU1pXOGZRL2tLUU9C?=
 =?utf-8?B?Q21tSk55RndaNGtCMEE4bXlxc09yU1MrK1JXaW82RUhDcTdGbFVaMW9qK2Fq?=
 =?utf-8?B?YlA2MzNWakQ2bXY1ZnVWREtDd0ZzQUplWmd1OEl0c1hTTmVZYkVmRDM2Njg4?=
 =?utf-8?B?VmpuZXh4T3RSVC9tdU9qQnBTOGEzNzhRYWpUL2EwV2ZKcGFsZ3dUWXpuMWMz?=
 =?utf-8?B?NHdkd0pPaTIrVFZVQnU2RmxKNFhoZzBWc0FWSk9pUEo0dnRXcHhCV1ZIcmZx?=
 =?utf-8?Q?FalCqI+gZuaAxwXP5dm4FFw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AFB561A6AE9BE4E938F4EE4A77C063C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4670581-eb36-4368-4334-08ddfd12ebf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 15:39:46.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pTu2hvw+cFa7m7Bz9jvflCe2qgi/yNyFp/5XzQl6mVHQxp9PMnnnL0nTNfzJztVLDM8VJA3Ag5gDUH0o8s7YxVBZA2xEqkGKeSCV3p4SBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA5LTI2IGF0IDE2OjA3ICswMTAwLCBZdXJ5IEtocnVzdGFsZXYgd3JvdGU6
DQo+ID4gSSB0aGluayB3ZSBzaG91bGQgc2VlIGEgZnVsbGVyIHNvbHV0aW9uIGZyb20gdGhlIGds
aWJjIHNpZGUgYmVmb3JlDQo+ID4gYWRkaW5nIG5ldw0KPiA+IGtlcm5lbCBmZWF0dXJlcyBsaWtl
IHRoaXMuIChhcG9sb2dpZXMgaWYgSSBtaXNzZWQgaXQpLg0KPiANCj4gV2hhdCBkbyB5b3UgbWVh
biBieSAiYSBmdWxsZXIgc29sdXRpb24gZnJvbSB0aGUgZ2xpYmMgc2lkZSI/IEENCj4gc29sdXRp
b24NCj4gZm9yIHJlLXVzaW5nIHNoYWRvdyBzdGFja3M/wqANCg0KSSBtZWFuIHNvbWUgY29kZSBv
ciBhIGZ1bGxlciBleHBsYWluZWQgc29sdXRpb24gdGhhdCB1c2VzIHRoaXMgbmV3DQprZXJuZWwg
ZnVuY3Rpb25hbGl0eS4gSSB0aGluayB0aGUgc2NoZW1lIHRoYXQgRmxvcmlhbiBzdWdnZXN0ZWQg
aW4gdGhlDQp0aHJlYWQgbGlua2VkIGFib3ZlIChsb25nam1wKCkgdG8gdGhlIHN0YXJ0IG9mIHRo
ZSBzdGFjaykgd2lsbCBoYXZlDQp0cm91YmxlIGlmIHRoZSB0aHJlYWQgcGl2b3RzIHRvIGEgbmV3
IHNoYWRvdyBzdGFjayBiZWZvcmUgZXhpdGluZyAoZS5nLg0KdWNvbnRleHQpLg0KDQo+IFJpZ2h0
IG5vdyBHbGliYyBjYW5ub3QgZG8gYW55dGhpbmcgYWJvdXQNCj4gc2hhZG93IHN0YWNrcyBmb3Ig
bmV3IHRocmVhZHMgYmVjYXVzZSBjbG9uZTMgaW50ZXJmYWNlIGRvZXNuJ3QgYWxsb3cNCj4gaXQu
DQoNCklmIHlvdSBlbmFibGUgV1JTUyAob3IgdGhlIGFybSBlcXVpdmFsZW50KSB5b3UgY2FuIHJl
LXVzZSBzaGFkb3cgc3RhY2tzDQp0b2RheSBieSB3cml0aW5nIGEgdG9rZW4uDQo=

