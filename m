Return-Path: <linux-kselftest+bounces-15370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D29526BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797881F233E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD10A47;
	Thu, 15 Aug 2024 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrrAmqou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230A10E5;
	Thu, 15 Aug 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681109; cv=fail; b=aEpaA/X/KLArihXNpH9E57nqzXNfxamU19BMHb/wFgzxNHuVN7rFeWk8gUGno/qc4i5/AwVfnlDgbVDaeF+E6GUBBvQoLXnXxLhKRNTPaQ0Wc/B1EsBSIe7DCbueTMPZS+0H6616v2W43UqN9DvDlt5Tj13Z3rRdZ7Zjb0EfL5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681109; c=relaxed/simple;
	bh=BVS97xRWM3q9Vr4RbRXpfyeGU0jL75vbAUVijgn5ua4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fy8DzVBj4tRVXBKe7hxtmu+PLVN8kKarc1vOoGiv8HkiVSeH32Uesz+XoEn6wdyU7iq7KEsyIBw1k8KybRWiw/AdDry94rC6gD7wm7UIe3dbqw+nd6imPzrUYqGmF5jhsK0ffSXG6Jd9gvGYb+5YSp9YFcjtcJIz1V2ka2quzQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrrAmqou; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723681108; x=1755217108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BVS97xRWM3q9Vr4RbRXpfyeGU0jL75vbAUVijgn5ua4=;
  b=FrrAmqous2fr7HAG61Jz/8OsZY7uOvQU+EAc+sKOx8iJvmHxi9nEHZUa
   +uDCzuC3EvDBotLmzgM/Gl7iJ9cS0EnMRgr5wvVF0y8UlOIjV41OWiVfM
   iS0KUufbvMEIvp4Uero5xTmA4UJayG+U7gW6Ol3zAjZsVt48IIpTwbPQa
   6v+y3plhgjpnSmF0F67PBMVu+ezIlQg2TcFb4hdylEBihqadQiBLnWX5+
   SbJ7ZWJnlnrDVdtAJe26yNBpg8HgvwhdMNl3GNa9Y13CR6EMK2+oqaaWK
   dl0FiCBlmSjpuvmGUshUSSHsv0TIBx/ZWVKFt4ClCKT/8nRqftqadZoic
   Q==;
X-CSE-ConnectionGUID: +1eer/MIS6CcmyN8IGH3nQ==
X-CSE-MsgGUID: Y8v6KFMgSCq4GuT2nNrcPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="13019571"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="13019571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 17:18:27 -0700
X-CSE-ConnectionGUID: heGeiewsRKmv+EXUMEzXwg==
X-CSE-MsgGUID: WyQcyjhBTYye0IqGwF3qYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59193225"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 17:18:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 17:18:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 17:18:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 17:18:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 17:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF0DhCfpTlzI23DPyFByhIc6CyR3tVGxgGud2YuejE0pAkRt48usi7a1Q6WNQ6q6jXRs2pKJi+h5UsowP5KBNXvaPwD19n7FsDukT+IRTFMWYjwogzOosWKkygiYG8Lwfnuca3aGV+mo54vpe4ys9cLRPqC4RIpvZ3hvOG+tVjCk7tSsRI7oR+WKSpf3g8DvsxAv2jq7wZTCK0hifD12/wltU3rurUBzRGEibtWAzOgP9Cw7u0+fCOGy3SkD1vUF23YL+Sh8naoN0FO23M2hHiJKsmPoIRA4mee5BMtWSQgtTI9ML4F/wimnJuG2OdHZF03HB0EpuUbOguMbOs8d8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVS97xRWM3q9Vr4RbRXpfyeGU0jL75vbAUVijgn5ua4=;
 b=GQC/90a1zUmH9HuF9ZPZqH5mlTOjwvWZ33O5OWJl2So+wQlYMaUAXwzPVCagxZV1me2XvLzZxRfs+N6Rwe6EIf55/yjv3IcO0QVTbwiEEmS3otFFq/Df/NQ7gQfWrwyMlyvmH09TJDnVeSw5LR2wFuUvym5YMFPOvYWyqDhxnNH697f4aKoswe23cWNoOnREqnQYrgfXzTgnYMCe5S5CuN2XQxlhgE6FflCkSaEB7XTCT/H4LkK44ec7qB2CoGSO11g6Z2xrALQJg3f3UXqL7LCdz5c01lSftXFAhCT59XIDrtKwS9hu3x2Cpm97EVs1D4hVlKEvNZ7QBKw/jnCVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:18:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7828.030; Thu, 15 Aug 2024
 00:18:23 +0000
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
CC: "jannh@google.com" <jannh@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "will@kernel.org"
	<will@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Thread-Index: AQHa6Wtm9dJ/AN2M70yRn9JU+5jud7Infm8A
Date: Thu, 15 Aug 2024 00:18:23 +0000
Message-ID: <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
	 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5034:EE_
x-ms-office365-filtering-correlation-id: 3cee06d5-9405-45ff-018f-08dcbcbfc64e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmY4VU44NUVQNW83R05UZ1pCbkp4NUFhc3F4dkw5SkdGRldsZXBWdmNhdEZ3?=
 =?utf-8?B?U0FTVG05ZDdNYSt6bVV1Zkc3Uy9UV1huemhmMEMrRWdIVjlHT0h4b2dreS9r?=
 =?utf-8?B?NVNxcE1sQS96cm9jMlZOTXdCam80WGJQWGxZTEdwYmN1V09sWE1ocmNlNlhn?=
 =?utf-8?B?SEZUbUdHKzI2cTlyNEszdHVWMW9rTVg2VnRQSW5BeTEvOXBTUytrQ2JjZUlV?=
 =?utf-8?B?bTRTWmVNK3F3WEhyZUlSUDhERHBSVFg3WVZkekR3Q040Wm54aStVaVZGbHEx?=
 =?utf-8?B?emsvaEIxWlBBWHJOM2dYN3RaQSt5OHhNOFRLK204b3pQc0RMTk0xc1FGeE9t?=
 =?utf-8?B?NlFpVDFCUjBHN1JLbGZScFVpcDRQbENaRzRYdmFVUVo1UTl2M3JQd2NOajdW?=
 =?utf-8?B?VFpLbDFKVFNuc0F3OTJRKzUxcmVlWFdiOVdYMEllR2lqMlZlRTM0c1orZ0Ry?=
 =?utf-8?B?Y3R6K0ZFbDJyeWFQRkYvQVFrSDFoaTBTTzIzd3JGQVpTUmdBaVA2aXJxTUtV?=
 =?utf-8?B?a091RUhMeTBheHhqQkxQaGc5TDNNZGJoZEllc1RxSjJ0YmI1SEZ6Tm5oYnFW?=
 =?utf-8?B?UVlFSVN0NmVSNzAzNmFhWFJ0eXJtM0MrT1ZKVTZVRzlCRk5tdG5STllsR1VY?=
 =?utf-8?B?Ukg0U2pXYVkwN2VrYUZBVGx1YWdSZ2ppRFl6ZXVFWnpuOEpoZDBRZHZoY2FF?=
 =?utf-8?B?NjFQN0VsNUlVRTkycHVyMjJKYUkraHZFK1BTb0R3SnlSRFpYQWVtQlZnTkNY?=
 =?utf-8?B?Z3YrZmtDMGQyaGNIcHQ4NDJiZlRQNG9GNXRSWkZEVmxnbEJqR3EvbmY1OGN5?=
 =?utf-8?B?Mk9SVndrRHQ2V09jWmlnWWliZEJGU2liQVR6cDFrdkxjUWdQMUtFRHhyRmlk?=
 =?utf-8?B?bjZ3bys2NDJla0EvK014amErQm1XdzlxOTR5c2RtS1Izd1VwMHM2OEU0VGZh?=
 =?utf-8?B?bytjTkFyNCtJSjdKQldQaEU4dGlidmZFUlBiWE5zSkxodDVXUEcxVmVuL2Rz?=
 =?utf-8?B?NnJmSkpDNDZBamtDcVV4eUVVYnphZEhwcHJvTVhuNko3R0hnN2d6YzJJb2U1?=
 =?utf-8?B?M1RBd1pzSXprblFabGhKc21nVGNHSkZQZVN5WEZodnBVMlhZeFNwRkhOclhk?=
 =?utf-8?B?Q2VHUXZLTHlSdCtGS0FwbHd0V3NaR1FwZ1NBVytHTkRxOFg3SXZZejEvbktl?=
 =?utf-8?B?Wi9GUXMyakcxMXdKSldsSy9Cdmp1V2hmRnVmbVJOL2J2bXNwSHkrVXlxNnZj?=
 =?utf-8?B?U1ZIRUR0THNKQ1RucU01MDhCamdaUlU2clVnaUZVS1RQTmUzUmR2bC9DYmlk?=
 =?utf-8?B?MzFJZk94d0h0RWVKcmVEQXJnVUFHeXhKeTJSUWtKYnljSVNETjVGU2ZqSGdI?=
 =?utf-8?B?d2hLcmt2UlJSM0l1c1l4MVZsODBFTjhhYnRsbUdoYVcxOW51SDJVZ0dIQnA1?=
 =?utf-8?B?T2FraXRKajQraWpmZjRueWthN2lSajhkakxXMG10Wis4ckc0M1k2WjlrQitJ?=
 =?utf-8?B?bVg2eXV5RDYvVm9FeWltMzM4YjBLV0gwbkQxa1pxYWxqNDlnWDRvWm00L2Vt?=
 =?utf-8?B?U3V3YWM3dW9ZRTdBN0lydEhCcUcrWkt2YlNFWXNjeU1lK09Qb1RRSG9MTjk4?=
 =?utf-8?B?RFkrb1E2UGhWRHZlMjVTa012ZEs5YjZzVkR5ajNQUG1Ecml0VEttODk3dWlr?=
 =?utf-8?B?ZkVTSzVzRjBSdlZlOE9BWTBTVGJVQlVxWFp4VXd1WjNKbWkyd1pzNVpzSmYx?=
 =?utf-8?B?V0RHWTllM0ZvKzYxbCtRc3k2bnNLL2pkQVgyWld1S01sRVN0Y2VXYmhYRGJs?=
 =?utf-8?B?RklxeUtxT0RjNGxia1BsZUNpWlpJUDhIZVNlV0N3QWI2RHJTSVZ3NWI4bUYw?=
 =?utf-8?B?L01nK3laZ0xucXd1VXRWOGxROW9xbE9NVWgzZkdyTlRYblU4aGd5ZitCcDc3?=
 =?utf-8?Q?11H0PVe0xvA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9ETWJVWXVpa1hNSGJ2Y3hiUjNnTFFTdjYxcjBOclRKY3dEYTlEc2g2V2xN?=
 =?utf-8?B?WGxrZmRIbjRqMkQxRCtPcmVkZXZuUlRGRW1QMHlxcmVDSTI3TUNDTnBZQVBF?=
 =?utf-8?B?MFBTWXF5YXhhbHFxQy9MVEZtWDloZTgvUUt1Zmd6dTF0M2NqdkU2cUF5czNN?=
 =?utf-8?B?ekg0U04xVWlYM3UwNDJqN3VhVGFYNzNNQUc1UVIyTG5wV3I5WFI4QlA3ZGl6?=
 =?utf-8?B?dlB1RW8vK0hGTEYyU1VScncyNTNYMHdJRTd1aUEycytoRXd5WGdxa3cwWTNI?=
 =?utf-8?B?dHErZjdXWG4wMjJ4bmlPUENEZDZycFpMRkRiMVY2NUVodVlIb0p4MHROQ2Rm?=
 =?utf-8?B?MHM4aHlQd2lHQVVsZ1VJV0dxSHA4U3BLbTZHcVN5YlFieFBNU2FFcXhUbTRY?=
 =?utf-8?B?V2RnL1ExU0s0UGVmY1BvcHMxT1h1bTJKZ3Zwa0FUQkV6eEZJQkhudUk1bDNy?=
 =?utf-8?B?aFJYNXBvTHlkdDBxNVhkVkMvaEJzWUFtRUNSamM0VGJ4VXFJMXpleWhxK05Z?=
 =?utf-8?B?aUl3MmQ4a2YzZE54WXlML1VrRkdyMTBZV2FwaVdxaE8yRElYU1hQV2hhWkRG?=
 =?utf-8?B?Z3JYcDRkR1ZuWW1qcERxSmZQU2VnY2l2SGlsWG9QSTdQU0VPcEQ0aDdheno2?=
 =?utf-8?B?ZHlSdTdJRlUwL1BDcXdmSS9UakVCRmEvMTJpYUVSMjVLbFNlKzZNa0FjTnov?=
 =?utf-8?B?RHlvUW1EaXZGWVpRdkErRUJ5cGFsRWxrN1h5SU5ETW9OUjJMUEV6V2VFS3NG?=
 =?utf-8?B?Si9ibjZ2MFVYU0RFYXVUVVREblRKNjNHSGZxVEhmV3d4Y2lJemRDRGJUNmM4?=
 =?utf-8?B?NWJQUGZPQloxeVNSVi9nQ2JUNURPSkkxckRBdHVHR3NMZTcvNzBQZ2dWK3hT?=
 =?utf-8?B?bEtIL1ZGVGdjYUJleGZiZm91YU43QTU0Q3YyVlRnTnpIKzlJOUlmWEl5cmxM?=
 =?utf-8?B?c1BNd0N4dEs3b2hBMnlkZFJmNWpXNmdyQXlTaUZLMDB5bU5VSERCZ212Nk1m?=
 =?utf-8?B?YTJ0ZXVtRlE4TjFUS0ZaTTVqSUJDR1Y2RUFvSXVBMlhvNVJTUmluYnRJOTVV?=
 =?utf-8?B?ckQraXErOTlVUUNxNytLdFdINVM3TGx4YWZCRjV0M2RYYTZoMVlzMWlCM3JC?=
 =?utf-8?B?NTNDVSsyR1Ayd1ZzSkFOTEExZG14UjhxYTBScW5mWTN0TjNBajVvWCs3d3ov?=
 =?utf-8?B?dzhDcUlpbDVNWFh0T0FhbDF0dW1Falk5UnhCdUs4bUM5R1k5ZXFiaGpSUkt3?=
 =?utf-8?B?alFjRjRTanVnTWhTUzZOSFlBYXIzQnhzQm9lRWZ2Y3NFSTVCV0RUWXBCSVov?=
 =?utf-8?B?OUtZZkluaE0yd1lNMk5uV2FHWjdqUFR2ODFpV20zTXByRnR2Q095Uzdkc09Q?=
 =?utf-8?B?a005SmUreUJZbi9BTVo1b1JQdkpWUmo5VmZzb2JCd2owYUxEbnN6MmpJcHJp?=
 =?utf-8?B?N0hKMnQ3R0FkWEtmZWE5TGU5ZkJEcXRGY0pxbXJqbXhQUk1Od1BPQnNBdlNy?=
 =?utf-8?B?aFQ0MEUzcXV3d1ZZL3pwbUFwR25LekVkYzFXYmF1MGhja3FxOUN3aG9WSWZD?=
 =?utf-8?B?M1lya0RIbVJoNHEvendPQ21JeHR6Nys0WjgwT2RscGF0dUk5U0hRWm5OVjNX?=
 =?utf-8?B?Y3A1emF0a3c4K1hxY21EWTBUSVFEaVpyaXordUZiZWllQzZUMUwwZTIyL1Rm?=
 =?utf-8?B?SWlza2dScnpEd0VRMnduV05hdnBsWkxaRDdZV2JZbVRoaGxqZ1Y1R2hiSlBp?=
 =?utf-8?B?WU5ndTZWZEM2RldmQmxYeVNzZElkTnVSV2VUT0dsM2owMjdieS80ek5qS2Jm?=
 =?utf-8?B?VUh2MkJwMTEzU1MzVCtZb2p1TXFwK2tsWGRnK0tUOTNQUTdTYi9oaGdyc1dz?=
 =?utf-8?B?K09XMWd4TmR0SEN3RG5mc1Q2Y1JRU2JIVVZsNEhQQjJYOHdqOVliUTNUVjZ5?=
 =?utf-8?B?blJoU0RvYVZVdmtnOEJuSzJEZW1qMXU0VEZ0SG8zWkFEV3dUYUpHbkpwTk9T?=
 =?utf-8?B?eFcvZnowd09zYXhkbHY1a1ducE11NWQ2WnNQaXJlV2tjSnRDcFhRV2cvdmpw?=
 =?utf-8?B?NWFqZ2NuT3hQSEtuUmtsVHdBWmN6SjJpZmlNbDZaL1RpcGFWMUlyaUx0QUVv?=
 =?utf-8?B?VDlxeVRpeVJNSkVnUk5sRVNoMnpZUkx2RjhtUVlleENFTWVmaERZbi9xNElr?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <462A02A39638DA4BA90731907C445509@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cee06d5-9405-45ff-018f-08dcbcbfc64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 00:18:23.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIjIvZBIcPimdTk9vFuYPvlat7xlGcrluYoXmPEx33pX7dN4g9YR5kftd3VFBQ/2cYs6tKI5+D6PsXaz+x4GmiMirka9djAeTabj9Q9OAEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTA4IGF0IDA5OjE1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+ICtp
bnQgYXJjaF9zaHN0a19wb3N0X2Zvcmsoc3RydWN0IHRhc2tfc3RydWN0ICp0LCBzdHJ1Y3Qga2Vy
bmVsX2Nsb25lX2FyZ3MKPiAqYXJncykKPiArewo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDC
oMKgwqDCoMKgICogU1NQIGlzIGFsaWduZWQsIHNvIHJlc2VydmVkIGJpdHMgYW5kIG1vZGUgYml0
IGFyZSBhIHplcm8sIGp1c3QgbWFyawo+ICvCoMKgwqDCoMKgwqDCoCAqIHRoZSB0b2tlbiA2NC1i
aXQuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG1tX3N0cnVj
dCAqbW07Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBhZGRyLCBzc3A7Cj4gK8KgwqDC
oMKgwqDCoMKgdTY0IGV4cGVjdGVkOwo+ICvCoMKgwqDCoMKgwqDCoHU2NCB2YWw7Cj4gK8KgwqDC
oMKgwqDCoMKgaW50IHJldCA9IC1FSU5WQUw7CgpXZSBzaG91bGQgcHJvYmFibHk/CmlmICghZmVh
dHVyZXNfZW5hYmxlZChBUkNIX1NIU1RLX1NIU1RLKSkKCXJldHVybiAwOwoKPiArCj4gK8KgwqDC
oMKgwqDCoMKgc3NwID0gYXJncy0+c2hhZG93X3N0YWNrICsgYXJncy0+c2hhZG93X3N0YWNrX3Np
emU7Cj4gK8KgwqDCoMKgwqDCoMKgYWRkciA9IHNzcCAtIFNTX0ZSQU1FX1NJWkU7Cj4gK8KgwqDC
oMKgwqDCoMKgZXhwZWN0ZWQgPSBzc3AgfCBCSVQoMCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG1t
ID0gZ2V0X3Rhc2tfbW0odCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFtbSkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FRkFVTFQ7CgpXZSBjb3VsZCBjaGVjayB0aGF0
IHRoZSBWTUEgaXMgc2hhZG93IHN0YWNrIGhlcmUuIEknbSBub3Qgc3VyZSB3aGF0IGNvdWxkIGdv
Cndyb25nIHRob3VnaC4gSWYgeW91IHBvaW50IGl0IHRvIFJXIG1lbW9yeSBpdCBjb3VsZCBzdGFy
dCB0aGUgdGhyZWFkIHdpdGggdGhhdAphcyBhIHNoYWRvdyBzdGFjayBhbmQganVzdCBibG93IHVw
IGF0IHRoZSBmaXJzdCBjYWxsLiBJdCBtaWdodCBiZSBuaWNlciB0byBmYWlsCmVhcmxpZXIgdGhv
dWdoLgoKPiArCj4gK8KgwqDCoMKgwqDCoMKgLyogVGhpcyBzaG91bGQgcmVhbGx5IGJlIGFuIGF0
b21pYyBjbXB4Y2hnLsKgIEl0IGlzIG5vdC4gKi8KPiArwqDCoMKgwqDCoMKgwqBpZiAoYWNjZXNz
X3JlbW90ZV92bShtbSwgYWRkciwgJnZhbCwgc2l6ZW9mKHZhbCksCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGT0xMX0ZPUkNFKSAhPSBz
aXplb2YodmFsKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoGlmICh2YWwgIT0gZXhwZWN0ZWQpCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+ICvCoMKgwqDCoMKgwqDCoHZhbCA9IDA7CgpBZnRl
ciBhIHRva2VuIGlzIGNvbnN1bWVkIG5vcm1hbGx5LCBpdCBkb2Vzbid0IHNldCBpdCB0byB6ZXJv
LiBJbnN0ZWFkIGl0IHNldHMKaXQgdG8gYSAicHJldmlvdXMtc3NwIHRva2VuIi4gSSBkb24ndCB0
aGluayB3ZSBhY3R1YWxseSB3YW50IHRvIGRvIHRoYXQgaGVyZQp0aG91Z2ggYmVjYXVzZSBpdCBp
bnZvbHZlcyB0aGUgb2xkIFNTUCwgd2hpY2ggZG9lc24ndCByZWFsbHkgYXBwbHkgaW4gdGhpcyBj
YXNlLgpJIGRvbid0IHNlZSBhbnkgcHJvYmxlbSB3aXRoIHplcm8sIGJ1dCB3YXMgdGhlcmUgYW55
IHNwZWNpYWwgdGhpbmtpbmcgYmVoaW5kIGl0PwoKPiArwqDCoMKgwqDCoMKgwqBpZiAoYWNjZXNz
X3JlbW90ZV92bShtbSwgYWRkciwgJnZhbCwgc2l6ZW9mKHZhbCksCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGT0xMX0ZPUkNFIHwgRk9M
TF9XUklURSkgIT0gc2l6ZW9mKHZhbCkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGdvdG8gb3V0OwoKVGhlIEdVUHMgc3RpbGwgc2VlbSBhIGJpdCB1bmZvcnR1bmF0ZSBmb3IgYSBj
b3VwbGUgcmVhc29uczoKIC0gV2UgY291bGQgZG8gYSBDTVBYQ0hHIHZlcnNpb24gYW5kIGFyZSBq
dXN0IG5vdCAoSSBzZWUgQVJNIGhhcyBpZGVudGljYWwgY29kZQppbiBnY3NfY29uc3VtZV90b2tl
bigpKS4gSXQncyBub3QgdGhlIG9ubHkgcmFjZSBsaWtlIHRoaXMgdGhvdWdoIEZXSVcuCiAtIEkg
KnRoaW5rKiB0aGlzIGlzIHRoZSBvbmx5IHVucHJpdmlsZWdlZCBGT0xMX0ZPUkNFIHRoYXQgY2Fu
IHdyaXRlIHRvIHRoZQpjdXJyZW50IHByb2Nlc3MgaW4gdGhlIGtlcm5lbC4gQXMgaXMsIGl0IGNv
dWxkIGJlIHVzZWQgb24gbm9ybWFsIFJPIG1hcHBpbmdzLCBhdApsZWFzdCBpbiBhIGxpbWl0ZWQg
d2F5LiBNYXliZSBhbm90aGVyIHBvaW50IGZvciB0aGUgVk1BIGNoZWNrLiBXZSdkIHdhbnQgdG8K
Y2hlY2sgdGhhdCBpdCBpcyBub3JtYWwgc2hhZG93IHN0YWNrPwogLSBMaW5nZXJpbmcgZG91YnRz
IGFib3V0IHRoZSB3aXNkb20gb2YgZG9pbmcgR1VQcyBkdXJpbmcgdGFzayBjcmVhdGlvbi4KCkkg
ZG9uJ3QgdGhpbmsgdGhleSBhcmUgc2hvdyBzdG9wcGVycywgYnV0IHRoZSBWTUEgY2hlY2sgd291
bGQgYmUgbmljZSB0byBoYXZlIGluCnRoZSBmaXJzdCB1cHN0cmVhbSBzdXBwb3J0LgoKPiArCj4g
K8KgwqDCoMKgwqDCoMKgcmV0ID0gMDsKPiArCj4gK291dDoKPiArwqDCoMKgwqDCoMKgwqBtbXB1
dChtbSk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiArfQo+ICsKPiAKW3NuaXBdCj4g
Cj4gwqAKPiArc3RhdGljIHZvaWQgc2hzdGtfcG9zdF9mb3JrKHN0cnVjdCB0YXNrX3N0cnVjdCAq
cCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3Qga2VybmVsX2Nsb25lX2FyZ3MgKmFyZ3MpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBp
ZiAoIUlTX0VOQUJMRUQoQ09ORklHX0FSQ0hfSEFTX1VTRVJfU0hBRE9XX1NUQUNLKSkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBp
ZiAoIWFyZ3MtPnNoYWRvd19zdGFjaykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoYXJjaF9zaHN0a19wb3N0X2ZvcmsocCwg
YXJncykgIT0gMCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yY2Vfc2lnX2Zh
dWx0X3RvX3Rhc2soU0lHU0VHViwgU0VHVl9DUEVSUiwgTlVMTCwgcCk7Cj4gK30KPiArCgpIbW0s
IGlzIHRoaXMgZm9yY2luZyB0aGUgc2lnbmFsIG9uIHRoZSBuZXcgdGFzaywgd2hpY2ggaXMgc2V0
IHVwIG9uIGEgdXNlcgpwcm92aWRlZCBzaGFkb3cgc3RhY2sgdGhhdCBmYWlsZWQgdGhlIHRva2Vu
IGNoZWNrPyBJdCB3b3VsZCBoYW5kbGUgdGhlIHNpZ25hbAp3aXRoIGFuIGFyYml0cmFyeSBTU1Ag
dGhlbiBJIHRoaW5rLiBXZSBzaG91bGQgcHJvYmFibHkgZmFpbCB0aGUgY2xvbmUgY2FsbCBpbgp0
aGUgcGFyZW50IGluc3RlYWQsIHdoaWNoIGNhbiBiZSBkb25lIGJ5IGRvaW5nIHRoZSB3b3JrIGlu
IGNvcHlfcHJvY2VzcygpLiBEbwp5b3Ugc2VlIGEgcHJvYmxlbSB3aXRoIGRvaW5nIGl0IGF0IHRo
ZSBlbmQgb2YgY29weV9wcm9jZXNzKCk/IEkgZG9uJ3Qga25vdyBpZgp0aGVyZSBjb3VsZCBiZSBv
cmRlcmluZyBjb25zdHJhaW50cy4KCg==

