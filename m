Return-Path: <linux-kselftest+bounces-115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C47EBA34
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 00:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4239B281381
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87042FC2D;
	Tue, 14 Nov 2023 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SX5Z4Cbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120C2FC21;
	Tue, 14 Nov 2023 23:22:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A730D6;
	Tue, 14 Nov 2023 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700004141; x=1731540141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/eBvt+QQcgcZw9TJo26zFbpCwWJflOhNkk7eABfOKhY=;
  b=SX5Z4CbuP9EDbvqK846eBMSTMw38t8rXJG1PV9Y9BpHSMqqbEOFQ5+l9
   hykYE2b7J39S/jh44Gj596iVjbS238UboQtyZBuqFsIQThckjc6/r7Y8A
   tpY5YW6LaSVIzaTZCgPZKISXcO6yvB1GUIKTeb4usLjDkcCqd2Z9QPEME
   tsm6PCwWBlenxAuCwrEGN/3b7JEBBRE8kqGz6G9U5/ppRhSS5MAuE3kt+
   MijYWUOvmYAvy9ue8vBpRgfPjpnAEorKOqU1oCEKn5sD+r7C9i1V+El8Z
   +0a5IkcblF+/uPWv3GO91O1D8f8H34FdKlmI+Va7YJ/A0G/CA84q48uxa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="387930406"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="387930406"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12588318"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 15:22:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 15:22:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 15:22:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 15:22:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 15:22:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frDF/2v/kb9r/r433pnGhTJFZ9USOOv7wrCqXN3QpF1ibUrINhNv2c67uP9zKKXHYIXmM41hTW0rz/Fir/ET89JM93s+4FzJLQMQaKI5GhLcdxQPFwGmtqJLiKPLfVyo2NQ51xrO3Any1DXipDUF/Lh6nPJOpVjayI9ZCx1xCUjtiDT4UzlY54tYj0e0rZbhpYM53OcFmx37Ytk+2NwRTZe5Kms9HPHP0mX3eydKuQSWxDPX1sQKoOf6P9lkhjyWWayYW0C6yzOqFUxzj1LG7cM1OYD7F6itbSd/SAtAms+Yw1Wf6sM/AMqmfZgE9+Evq7wTx0kO2TmD7YH7qjCaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eBvt+QQcgcZw9TJo26zFbpCwWJflOhNkk7eABfOKhY=;
 b=RBXW3X9oSHQWhW0QMpqThklthK1VYFbGTUTQYF8azrhAt1Supwi886i41ZM16ccXEeUM9ZasSX8+DVRrK+cE5BzOoquHW6xdUIf+zLwZVC33rEYMi10eDM2JYZdyKvVqJVh/m1K7Ble18ooEZiDB7EAZkHaPoHEdYgCuwEAfGwM2v4OQAdhGvWjh3CZIgJb68dIVh3GNrtIMbNQdX610qMSrZ5ZrDA61i0Z86ifeFq9X+8UKzGQEDcXfiRVk+SBS1zKB5vgFV4nHpoBynm3UnbQTJMO3p1Vp7rE4xzib2aSZ3+cCy2YLbEishS3T3/h1TYyu9YAfzIck8fdy8ahfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 23:22:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 23:22:16 +0000
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
CC: "david@redhat.com" <david@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Thread-Topic: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Thread-Index: AQHaFzYYojYPkPRXOUSSdLu+YZLt4bB6dGGA
Date: Tue, 14 Nov 2023 23:22:16 +0000
Message-ID: <837fec017b9709eb42d35e9608c24619613ed221.camel@intel.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
	 <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB8265:EE_
x-ms-office365-filtering-correlation-id: e314505b-5245-48a6-7396-08dbe5688a7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fz5RUYeFzfNS+fbTob0PG09X9SGbVl0ERWnvUlUPWpd3xPy8crzri5Zo1GxXPwr1norE2yKpuRBEJqGuKzDmgqL+aUKDE7IvVn/fJ1oqzKXONsxaikBRSbwzsPltpzVjEgEuA7sjLSzjLJIXnV/ke11Ydg3rQHAncYw3++tJyOIP+sA8gvUInMoqV2AlglsfqosHuS/hfnWClXqRV7Krb3DRkMrt6gvNNRz0tnjqOPhg4IZRjjYtBa0kjY9r2/AsVTg+fZ97SfdDQsygtEtTflJfqIImNX+AZYc6bG9ER/0qjw8io+HbQ6ILqKiDlbZG2RqAcB692UrW+n7PXoRdO3K3Jfk8e++duajzYQ15P78HqjYcZPn0+1l/wePG4jJbGlggICc1pK7Gbo4tVwvdNNZoA3GpDRbxPPjGZ+TlPD0gi9Z2ZUxtyokBwYJcmcqpK6ncGHEWkTi/NZ0TzlRT9bKoiEQzJHbsowPIlrECENSS+vSDQZO1M41WmFVDE2uey9nHXCI4iAcLqVpPoD0C91sLEVxXEQZfLhTHO1iX2cdPjxMbzqG9aU5oG56gL77Iuy8MxU73dCGTQz4H+f2kSv4SrgKAV9mrmx+HXkEOZNAx27MZs5PCggjmYsDxUN2EZKrTUqqNtaEc7Tn5NBdqhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(54906003)(71200400001)(6506007)(7416002)(2616005)(6512007)(2906002)(5660300002)(4326008)(8936002)(7406005)(26005)(4744005)(8676002)(41300700001)(4001150100001)(478600001)(6486002)(316002)(110136005)(66946007)(76116006)(66556008)(66446008)(38100700002)(91956017)(66476007)(122000001)(64756008)(82960400001)(86362001)(38070700009)(36756003)(921008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3h1NmtMYVNML3VSb0c0ZVNNcGV0cVNJWXhTdVB6Y3BpR3NwVkZwNVdaVUgy?=
 =?utf-8?B?ZUtpRDhQQjg3MG1ubGFLMVN0RTJqaExJT0tOeEM4NG8vMzdXSzVsOUs3WGlz?=
 =?utf-8?B?MnpMOGloTG4waUE4VDEvQmR6V1F5Q05EcXBub2NTY2lRUFZtc250dUtyS01Q?=
 =?utf-8?B?WXQrTzlWRXIrTWk4dG1yeGdEZVVITXUyNmR2R3huSW0wdUNaeHJKZXc0MFN6?=
 =?utf-8?B?VmJSNUQ5OGNJbStvY3NQVUUyTlhCU1NNMkhWSzhDMk1KZVJLNStPdjJlZHpE?=
 =?utf-8?B?YkdiSElzdS9hQnB2eTFZaVhRVTJiRk9YUis3V3JvZS9JU1c3Ym9Ua0JNV0lJ?=
 =?utf-8?B?cE5XaWthclFTOVcxdStubTNHU245bHdJYWVDbjJxUmc4RmdOVURsZmdUbWJj?=
 =?utf-8?B?VSsvNGNuWm1OdWk1THA4K0dGWHYwNEpFQUVKZGViWk0xNlI1NWIrcFNvYlM4?=
 =?utf-8?B?cEJCa3R4TnJHYWZiSW1yY001T25oamdSVkJJZmhudWRvVU5ZYy8yc3JTcnNm?=
 =?utf-8?B?Z0NYb0J0RlZ2SjFPUjlBRlRCbTNzS1RmUWRManZzVVk0WTBqVTVDbitaWFhm?=
 =?utf-8?B?N2pMMnBJS0liencyQUt4cFcxSjlYY2R4QlBNemdyQUNiMDZPVnhjSitrMVNK?=
 =?utf-8?B?R2VwTVJVMFNBb0NNTVRDZExqRW5vTHdQd0QwOXlzME91eHM0L0hLd0xEaDdj?=
 =?utf-8?B?eHFxck1Ha1JjN0tCV09ZSFIrNjNzNHdqczdDYTI0cFpqQWJRVTRGaE8zV3VU?=
 =?utf-8?B?ODlPWUF5VUdZSFNRZFpqOTEyQks2NG5KMFlrU3p6SjJpZEdOL2Z3eUwySGhI?=
 =?utf-8?B?MFhpdWVxSTRVSGJTTFhMcHZRZDlrbVJGY0c1dkwrcUtyLzk4YzlLNHR0MWhW?=
 =?utf-8?B?dlZLSnUxTDBGcEtGZFBURVV1dkFNdkZ3SjlHRHNiTlJYSTV1TXBkRUVwZC84?=
 =?utf-8?B?U1ZaOEdSdWlsOGJlOXJvZXVabUIrQXpRZmtzanBydlVmclg4QUxxaWh4TUcr?=
 =?utf-8?B?UkN2Q0F0eWplQjA0MVhxRnBCV3hGTTlXUnZKSHNPNUxwdnN5OG9xak93UEU5?=
 =?utf-8?B?T1Z2TjJpRXB1VWhjY2JzOWNUL1V1WXk4OGw0STZsVGxHNnUwUG9xaEQxMDRS?=
 =?utf-8?B?RDZYZ0ZxTFc2bjltRWhxZVUwbVo3M1B0NHk2MzZ1dkZZYXNNbEIrWnIzQWVz?=
 =?utf-8?B?OGVJMkJjcVZMTG1nNTZuUk5WbEVjQkZwS2FndkYvSlRFZVgvU2VKcUd5Q3NU?=
 =?utf-8?B?OVpVb25SUCs0VVMwRzlDK0lFbDZBRkMxMThvWTZlbnpiRFhWRzNqc3VvVVRo?=
 =?utf-8?B?bmh4Z1A0TmQveFZLblVVR0JqQzdxblVYVVhvRkdWd2hqN3kvZzVXb0VTODUy?=
 =?utf-8?B?ekVBSUNVbmVOSWIvN3BFOTlmaSt0WWJiK1RCd0Nwcng0R1A2dXhSbDBiRmRZ?=
 =?utf-8?B?SkdnNzVrdlJ5d1FDbnpsdHZuZm1hai9VVGFra2t4QXJtWldkdFEwd1o5amlQ?=
 =?utf-8?B?ZUNZN1dHbk1IYXY5eUVkV3RNSFdjbWtoZDFkcTdtTmovVmRVRitFN1BEQ0tK?=
 =?utf-8?B?MW5CenYrUE80ejBWRSt6aVIxazFoUitVQXJkR081UzFYbmZMMU1oc2FtUVJy?=
 =?utf-8?B?TFNHaFE0blQ2ZDFNb05nUjNQTVZZRW5EOUxjdTlKVVg5NTc5ZFQxeWpUQjY3?=
 =?utf-8?B?eWRCK2RXRXdJMXRGMDVKWFN3czN6Tmk5VzlXa1NlLzBMRFJlYjE2VVBUTjN1?=
 =?utf-8?B?clZCZWdjaUtnNzArSWg5WmV3c0RLSVlSNUdZNXcwdDdqRUNEWmt3WGc4SEZV?=
 =?utf-8?B?WXNDcDBmZ0VrVkx4Z0NtVkYxQWdRRmU4Ty9aZ2RvZFdyUVVtSTZxVUFwRGxO?=
 =?utf-8?B?RTNkcVdiaHo4N0RMU2ZGWmo3OXlVUFFHdU0xejJVVStTUi9wMVFUU3JkbktZ?=
 =?utf-8?B?Vy9PK2gyQ09hZFNOeDA4d3JtVEJuaUVxQ0Uza0luMmE3UkpzZ1hHNlg2MytJ?=
 =?utf-8?B?dUp4bUdhdFVqaVVuWUU1QnZ5ZUZOaWlaZGhBUzU3UDFvN1NTWk9mLzE2RkZB?=
 =?utf-8?B?Vmp0WGNYRVdERjU4MjRuT2RwK1dGREFlWlJSYys0K3pMV0VVdHlQSjJLaVVS?=
 =?utf-8?B?eGV3c1o0eW5KRGI5KzNhMXZNa1J2Sy9HMW5QUUFtSVpjd3dCNVZka1JJZWFz?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03E4D574C47D5E4489DF1C07310786E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e314505b-5245-48a6-7396-08dbe5688a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 23:22:16.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ+BWz5D0lZXXkXK9CE8Q9yOBvS4yIJ39htPSnNb/UUEPtT1Y1VTupVzuQQyamPad2MUzKPZW5TBZM0oYrqyByDhABLuE2MiR3j1dBlDlMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTE0IGF0IDIwOjA1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAr
Y29uZmlnIEFSQ0hfSEFTX1VTRVJfU0hBRE9XX1NUQUNLDQo+ICvCoMKgwqDCoMKgwqDCoGJvb2wN
Cj4gK8KgwqDCoMKgwqDCoMKgaGVscA0KPiArwqDCoMKgwqDCoMKgwqDCoCBUaGUgYXJjaGl0ZWN0
dXJlIGhhcyBoYXJkd2FyZSBzdXBwb3J0IGZvciB1c2Vyc3BhY2Ugc2hhZG93DQo+IGNhbGwNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoCBzdGFja3MgKGVnLCB4ODYgQ0VULCBhcm02NCBHQ1MsIFJJU0Mt
ViBaaXNzbHBjZmkpLg0KDQpJIGZlZWwgbGlrZSBub3JtYWxseSBhIHBhdGNoIGxpa2UgdGhpcyBz
aG91bGQgY29tZSB3aXRoIHRoZSBzZWNvbmQNCmZlYXR1cmUgdGhhdCBnZXRzIGVuYWJsZWQuIChp
LmUuIGFybSBvciByaXNjdikuIEVzcGVjaWFsbHkgc2luY2UgdGhlDQpjb21tZW50IGxpc3RzIGN1
cnJlbnRseSB1bnN1cHBvcnRlZCBmZWF0dXJlcy4gSSB0aGluayBzb21ldGhpbmcgbGlrZQ0KdGhp
cyBnb3Qgbml4ZWQgYnkgYW4geDg2IG1haW50YWluZXIgZWFybGllciwgYnV0IHRoYXQgd2FzIGJl
Zm9yZSB0aGVzZQ0Kb3RoZXIgZmVhdHVyZXMgd2VyZSBnZXR0aW5nIHB1c2hlZC4NCg0KSSBkb24n
dCBoYXZlIGEgc3Ryb25nIG9iamVjdGlvbiB0byBoYXZpbmcgaXQgYWhlYWQgb2YgdGhlIG90aGVy
DQpmZWF0dXJlcyB0aG91Z2ggYW5kIGl0IGlzIG5pY2UgdG8gcmVtb3ZlIFg4NiBkZWZpbmVzIG91
dCBvZiBjb3JlIGNvZGUuDQo=

