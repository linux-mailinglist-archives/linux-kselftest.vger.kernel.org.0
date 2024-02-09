Return-Path: <linux-kselftest+bounces-4475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3E84FD84
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CE9286CD6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7201272A4;
	Fri,  9 Feb 2024 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GT8cwWtd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFF2E632;
	Fri,  9 Feb 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510272; cv=fail; b=lZGHYJ+bJT/TWTbP2MqO7d+iqeSDaxdyAVu6Kk6K5p7zzt/+yTy5j0cI45i+3YRT9tfLpFgFoxTbhBgQrNTIlykxWgu0qacWPjAinPizHZPacmMljl5hrosRRpfi6uJCqyj9EvZZy03apjIlkpJkVug/dSWpPVdXGeFrOf5MQs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510272; c=relaxed/simple;
	bh=/gIwVoC1OYpF2zgfOJImpdFtnQvFu7vbdPzfohaxb+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IB8l58fLJ+2S/0zzoWyKmvvgj3mLGUand4yfeU1O+Mfb52m8cd4McYFGMexEuyNtN6UNBtxKs83xAPmtxm/M0OKLTagL/mv3bfI1lzbZwytYXF/hH13lqNm7uDy0eO20VHbt9Wp72ObuMElhPaGTskR4SeaamroQrjV48dmMQAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GT8cwWtd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707510270; x=1739046270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/gIwVoC1OYpF2zgfOJImpdFtnQvFu7vbdPzfohaxb+8=;
  b=GT8cwWtdeGc3XeZftoUuu4PTl68hZYaYBErrfn+m/qrpgDX2tyS6YiG7
   uscZB4kxlxAXp+la0OoCP54el3AA4VVl0DGTAnXo/7Vctp/aoUwX2kGZA
   XeozIUhfTkkGinVboSuhph78g/saoODO2SSjwukjWl1Dbd36bh7hab5ey
   Y36PVLMa3hjKguyviSl5pdXriKwf19N1jqDNYdwREOQ4FH7JS4VisB4ee
   ffv19XgWy7PqtxMsc217SVxaumMajGnW49Y+A1FQKDTGM9tapJxCnJ91r
   RPNg/yAChE501yXlUqQSDgoZLlNjQtperoLBaSKglsIuDDxIJXEC1MGnp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="18909556"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18909556"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6669687"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:24:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:24:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:24:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:24:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE3f3G5XSpAiM8hkAix9ew9ZnJ27DdCiJQZphP7U4yQ5YOwf35gp3MzqUMEsiG1mgycCwOaMe0b5n2LYwV5eHs+lQx3lRu/ydkwCJCGPFgSkkBhyqZjL35xO3YSkNZ+g5lNaavSnZR95Exc9A5zWAw3iJcYj6xhA5QQkBW7edMgWM+ebO+SCzZdffrSytLmy3x3s4oINkn6kIhLJumcnE56HKjlshKwzOR1VXxCoNDKBo3ECInSr0m1kyLBhEq1cqzPjAUPBxTN8cX1eXOrFAWqt8r3C1Rxu81do4u4IDWlAzG/U1npFiUPJ+90ee6sXIe6BFhVbDRrhedS9pTndgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gIwVoC1OYpF2zgfOJImpdFtnQvFu7vbdPzfohaxb+8=;
 b=lIxi0kX7uwFZWZRCIkQOTH6H10Qid84IN+wyAJNlEIPo996wswJazWPscZOOOrVFNujCogsC6KhmIY0BODok63fsL18+zrswbBT1N2fpHE/0IQyDtPDNYglGcbhrLw0Grsl0aQ+8R3zcB/tPk5FIbfiHq/r8xLeI5wyp9VQAqeqJLBBlqGf/FhiUjosKdv2m9KwhDbCobpoaOYF6AvD/cCNNHIWbHNIncT+F0qWeWbfCbQL+VPXb3Sul0reCgSm4SK49q6q3LsYSheeDWWMxKVk90ofyda7WoWzxQR+7q/xwTpH23aWAQwuBLX8laBKj045RA7pWCLhhgmrFSge7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.38; Fri, 9 Feb 2024 20:24:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 20:24:24 +0000
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
	"shuah@kernel.org" <shuah@kernel.org>, "bristot@redhat.com"
	<bristot@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "keescook@chromium.org" <keescook@chromium.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v5 2/7] selftests: Provide helper header for shadow
 stack testing
Thread-Topic: [PATCH RFT v5 2/7] selftests: Provide helper header for shadow
 stack testing
Thread-Index: AQHaVjTEBewNg3PEREGR4RKuiF+gmLECf4aA
Date: Fri, 9 Feb 2024 20:24:24 +0000
Message-ID: <3de40b3a2a79abfb7b64696c9dc69e59bc42541e.camel@intel.com>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
	 <20240203-clone3-shadow-stack-v5-2-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-2-322c69598e4b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7902:EE_
x-ms-office365-filtering-correlation-id: 052ab7e5-75b4-47c4-51ad-08dc29ad1b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlXPjfE2qpVVRkvjVsyCFr8WzaMLj3dx+YLbWBLYRMY5h0aZ2uccX1sXvGxHo1A4WGQpZEum/tUGb+XJGQMTir3JHzC2OtQ7tFFYwHs1UqpbW5R0GE7IlcQNPiSoOJ9kj0+XCwLTMord3G4TW6pbf8P5ljh/RECEh6e0JTX6aqJfneBT8oZ6T9nOCb04Fx92FI2/2tscuivvoLPtWneBYxqpZ079tTXlpNpdI1xrcUy0qJ8A9ZRSzuyojeEnm1WiT6Ibra6bR63e9QnUytGjhEjE1cUAO9wXzgmHW47lnL6WPjOyCamv2zVgGCFf9hUeEoXUCSw+s+5YU7dw7lZdxbvzYDRtbrACNc9pFE3XeIk3ilZy5PuiARQaI/CmLljBCLNUKCbyvnILroI5j0TKH0XBynxfHQpepAGBuxVaDQrkp0j3MF7fnFgAhxZzhqGbgGaheQLZlHE4j5fhx3voQ3sJypx2u5ENnmFUL2/Uw5ADhVm4BsXBCEcwBEu15+IugQIVip9vfrk/KGhtJy17jDaAEeW4+sIq71RdvatcUsqoHsPXMJjPZl58HXkKj4wuS74gBV1CxazEQP6xRY5L+2SeNM6X0RZDfzQVELq2DKr6bMmZebp8HL1pPE2ukoQh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(921011)(7416002)(2906002)(4744005)(41300700001)(38100700002)(86362001)(26005)(2616005)(82960400001)(122000001)(54906003)(76116006)(66476007)(66446008)(64756008)(71200400001)(6506007)(478600001)(6486002)(66556008)(36756003)(110136005)(8676002)(4326008)(6512007)(66946007)(316002)(38070700009)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJaaXd0emdFdW5ZRXdpZUFXU21wa0wrUUowMHZ6WmhFS0YwY3FpV1Z3bG1o?=
 =?utf-8?B?TDY1TVhvMjdTMktxemdBU2syQjk0NEJTcUhCWkd5TFVjRGZkWDVWVXNRMzRY?=
 =?utf-8?B?eGhPaDFjczEzejhYbXVtdHN6L1VlcytNQmRnV2dRbzVhQ1lZZTdXMFFuYzEx?=
 =?utf-8?B?ZGhMOXk3ZmZjQXQ3NU4xbThYUUlueUJoV2JaQTFTSXRzRDQ3WE9zR1dUcVNV?=
 =?utf-8?B?WGt5NVNDVDBBNU5FWDJ6MVZBakpPakRsSW0zNWsxUnRmdXZuYmordExwRTZI?=
 =?utf-8?B?VmNtQ1RGN0pXM2ttWnVDaHZZNVVUOTFhaWVVOTBydDNDRUViZWNqcHhNWlUy?=
 =?utf-8?B?WDRIMzlXUllwRXJNeTFnakgzaS9CTERtdkV0ZjVTZWcvYWp5UURvTjEwTDFi?=
 =?utf-8?B?akV6cHk0aHQ1Tll5Uk1HY01yZjFpSDZXVTMyVTBraXhMRVQ5ZmZ4VkFkQXZn?=
 =?utf-8?B?L1pqUkl1ZStjVjBjaVlua1RHNUtlcC9EbFFRRnNlYVdlZVUvL2h2RHI1MGZC?=
 =?utf-8?B?b1ZWNHRtaCtGM1ZpWmhFUGVmcVQ1d3VJWCtNT0QvdHhnbFlGYmhMRXhUcjE1?=
 =?utf-8?B?STg5cSs0ZjhTclM4RDBmUFJ3YkJOMGhLaVBsZVJEeVNaY3JPSEpIa1V3VjVB?=
 =?utf-8?B?L2ZERXEyOS9pcGMwQ1BvcytlWHEzWStjWkhLdEsycUNUdnNhbWI2MXVQMTJF?=
 =?utf-8?B?UVl4WjhFak9TQzNPVkRtYWVtcDRqQng0K3R6M0NodTdpYlNIQW1wenJ5Ull4?=
 =?utf-8?B?V3hGR0F1RWF6eXhnVHZlS3pRelJPRkR5bGtCbHJSMlZTY3hKL2N0UFhLR0Zl?=
 =?utf-8?B?YTlObW1rcmpRZmpUZVJvaVdoc2JtOXc1WmFqTkhkaStxWFliNSs4SkxWa0RT?=
 =?utf-8?B?VHNqSmw0RDFlME9xbUR4SWl5cDg1dENRVGtoUVE1L1E0dlUzNnA4TDdWUk1p?=
 =?utf-8?B?bGJ4czJ0R1R5c29uY1N4UDR3UHpXbGFPaWg0WWJkUTBxMjZnTzhFTXVrN0Zj?=
 =?utf-8?B?cU9YOFNMaEZXVk0yUDArRVQ0NmxlWVlQK25QU1dSS1MvTWJRVDNQUzhvSktX?=
 =?utf-8?B?Mk12RVRWUkloUFVVMFFkejlFcHpYMVdOMjZ5cUlwZFg0akVlcmpSRGhIb0d2?=
 =?utf-8?B?YUdMem5OQTU5dldEVFVHd25sWVZzNEJ0cEZnNUwza0ZJdzJnbTdrblBsYkdM?=
 =?utf-8?B?ZjFuSC9NKzdoU3MxdFRZOU5FaUoxYnVUOVJZaGp6a0x3YWJlczVncEhJK2N2?=
 =?utf-8?B?WFhOaU1XeVNQZE9NZVUrVlBQY1llS3ozSjhGVkdIZVJrSzBZNGxZYU5vVFNQ?=
 =?utf-8?B?NmtkSERxbjR5c0pKNWFhZVplSzNqWlZEc0tPTi9qODh1RWc0VEJUbVVNcFJa?=
 =?utf-8?B?ZGg5SmtCZW80ams0MVVoNU5MdmRsSlYwS3VvYUF6VTRtZjBNeW9vZ2FXcisr?=
 =?utf-8?B?b0FlMzk0TkFrMVFIUVBNbDlXa1VXbWRlMVFYSHBTNVBEeFJkcWRVTks2eGJn?=
 =?utf-8?B?YjVnRjhjbUh6NzZRUHA4Vy9udW03MnMybXpYNjVMSC9NcUFpNTdvYkFuV0pi?=
 =?utf-8?B?NUttZGU5NVYvaEtROFA2Sllvc3luSTFQZGhXMTd1Q2RTeUx3YzdjeGJhaWR2?=
 =?utf-8?B?bGpiaVc3NEVGSktBSXFGbW45enRpeEgrRDZmckw2NHZnbGFzcS8rTms4WDNW?=
 =?utf-8?B?U0dtNjROSllsWW9yRmxHcFFuL3RCZTRJUzQvNVhOYjJMeGtDM2l1NVRGNmwz?=
 =?utf-8?B?VEgvVE90TjZad3VxTEdiWXpjTDgrQnlyaW1LQ3lNVW1SRXV2QVZRdHhQMUE2?=
 =?utf-8?B?aytIaHg2Ui9zQ3ZlQWRQN1pSK2IzeWF4OFM3THVFNUpJVFpyR3lSWndYVGVr?=
 =?utf-8?B?dnNUQ2ZPY080QXVzVFMwMHRYT0laNUtuQVN4TFpwaXJlQ0xpRGd0cU1ZaURM?=
 =?utf-8?B?VFJDKzUxNjdTc29rNU5Tb3NMOVhLcnRVdlIya1lwQ09NMUdsUjM4cWZNZjNF?=
 =?utf-8?B?TjhLb0puUlYyeFZ5QWJYeFBZZEI5ZURvdVlFMzc0RHhmUStUWG45bVM0SjlT?=
 =?utf-8?B?OGxGTWN5NzhnMVNTQ3diT1lPWWptV2tjaEZRZFM5SjNOYWVZWTRVV2NLZC9r?=
 =?utf-8?B?b1hweWlGTDQ2TDFNRnp1bEJ5RWFFL29ucWxnK3pDNG9QZ2praGdBUTN2ZXdw?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C2541EF82D480409C094DE981B1A47A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052ab7e5-75b4-47c4-51ad-08dc29ad1b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 20:24:24.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77TXbxL36A7CgnRS39aA+4FMw0pEhqTBES3K+/jozhtdUfGN/xsJInTD5dJZmSqGA0ddBt3s6zgEKLzr7LOZDAtx3NurS4565jA6vlC4EGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAyLTAzIGF0IDAwOjA0ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBX
aGlsZSBhbG1vc3QgYWxsIHVzZXJzIG9mIHNoYWRvdyBzdGFja3Mgc2hvdWxkIGJlIHJlbHlpbmcg
b24gdGhlDQo+IGR5bmFtaWMNCj4gbGlua2VyIGFuZCBsaWJjIHRvIGVuYWJsZSB0aGUgZmVhdHVy
ZSB0aGVyZSBhcmUgc2V2ZXJhbCBsb3cgbGV2ZWwNCj4gdGVzdA0KPiBwcm9ncmFtcyB3aGVyZSBp
dCBpcyB1c2VmdWwgdG8gZW5hYmxlIHdpdGhvdXQgYW55IGxpYmMgc3VwcG9ydCwNCj4gYWxsb3dp
bmcNCj4gdGVzdGluZyB3aXRob3V0IGZ1bGwgc3lzdGVtIGVuYWJsZW1lbnQuIFRoaXMgbG93IGxl
dmVsIHRlc3RpbmcgaXMNCj4gaGVscGZ1bA0KPiBkdXJpbmcgYnJpbmd1cCBvZiB0aGUgc3VwcG9y
dCBpdHNlbGYsIGFuZCBhbHNvIGluIGVuYWJsaW5nIGNvdmVyYWdlDQo+IGJ5DQo+IGF1dG9tYXRl
ZCB0ZXN0aW5nIHdpdGhvdXQgbmVlZGluZyBhbGwgc3lzdGVtIGNvbXBvbmVudHMgaW4gdGhlIHRh
cmdldA0KPiByb290DQo+IGZpbGVzeXN0ZW1zIHRvIGhhdmUgZW5hYmxlbWVudC4NCj4gDQo+IFBy
b3ZpZGUgYSBoZWFkZXIgd2l0aCBoZWxwZXJzIGZvciB0aGlzIHB1cnBvc2UsIGludGVuZGVkIGZv
ciB1c2Ugb25seQ0KPiBieQ0KPiB0ZXN0IHByb2dyYW1zIGRpcmVjdGx5IGV4ZXJjaXNpbmcgc2hh
ZG93IHN0YWNrIGludGVyZmFjZXMuDQoNClRoYW5rcy4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRn
ZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==

