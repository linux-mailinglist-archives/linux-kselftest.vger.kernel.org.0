Return-Path: <linux-kselftest+bounces-4484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39E85015B
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 01:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D47B22AF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051A1C14;
	Sat, 10 Feb 2024 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxceZRPg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0963C;
	Sat, 10 Feb 2024 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526529; cv=fail; b=Uq+AP6j6oH1c75xKluoXbl+KQxO9UVz4DuPCzs8yMAQhnQRjunDZoaLyrfNQged34QqQZcbR1HBIoBF1Vz2fr7kmUT2dLwrLrHa1xyhTNRVtBqAw8SrAiJov/b48dy7X69rx3oA+WMuGwl7DNbHC6Rd2c5it2FrsDIJdKCQnYaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526529; c=relaxed/simple;
	bh=lLvrt/odJ9bOvG0hJ3FT+FfBMyitlSW8V8jnPBO8AvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aVJ8eBbDkQNOWRCOvypeGaFCUJZvzVbOPFdxfa0Ql7XLKj8vSzMptDfQXe55J0xx5O2VTHL+LK/fyoj8wrTBUt4bQ80TD2FXZLYS/Y9BwgLlNiV4uj/G2Kc6w6ZA7k3sqehv0UYdJMDj7NL0ih9Qx4yvTaJnbwuSlDxKNXrJb1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxceZRPg; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707526527; x=1739062527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lLvrt/odJ9bOvG0hJ3FT+FfBMyitlSW8V8jnPBO8AvM=;
  b=gxceZRPgxQRZQq9speXRVfoCByRXcYyCQDx/ao3YUjU0EUBNhVz01F6o
   kxVv7Rmy+vNigIucKl2N+pigMWZ4HIi1HAjJB4pHJIoQk75GnEVFXJu3E
   2+eQ4ji3svs8Z8KNnd1dgkLuHNppLKZMf2zoAeBQbY/hQQLBPUF+05Ftl
   3L3QVkzSbETiBZO9mYuSc5jqW9ZH4LFJ8rcxIPMrT8jGcEOBQIPKzhqQ2
   klmjhiRfHFsOgrf+Qe7bU5NZp1wnb50U6OugmvlkWq98N/54cwFwiFW5I
   FK0FAuO7H5JA3Hbrj9jvr8kfjp6k+l4uremAyzxBdccafQfi2bOcP9fcf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1389437"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1389437"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 16:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2109781"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 16:55:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:55:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 16:55:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 16:55:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE6NPOaufjJRnuua9Sm0d1tRJlDgM3lnZ3z1ZdnhR2AMPsULjJaYB/ZXGzDaUSu9yPDSfZLV8KmSNm8iM51lSt/BsAPqdUP0n+gI7I/pu9D/sx+VoOUarJs8Xm0ks9fGNoHIxe6gXB/tYkCJT03Jddx2BgDQ9HCZIw14eM9jXUW38EbLNlBDjOh0speVCeJxZoqOhp5mOC2HPsmGk+QcqmU21/+DbseoSAxHXUhA/O8mxSRepeE2lQm+9xOwiVUvrxN09wcPpV7GM2Zsr01WUy2m2JoO/JSowalnRibF+5c80S9gGObNoiMsN8Mxu6cOLCSrtrFc3vRhRtaDodPDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLvrt/odJ9bOvG0hJ3FT+FfBMyitlSW8V8jnPBO8AvM=;
 b=FoHdxx5/rSD49iwgeMgiFm8XFQM9qaI8M5bhfx5Rt25Z7Fx465/8/cb5TxBel2KnS7crZjqw2MZ32zb4oHEghh0qLKmWnrGXVvTyoyBpLR0CVFS9lmaKFZ35q+nm8Cafz0UaNvQCMrJvMkZJPe+uDWcR4dES3vItBADIiN/rzeG6RJX1jUDxJ1BfqV+l/Fc5PPfjfPQ1WvrfIsW1CuKPpRtmgKqnUAUuO4Iwi0Ig+8xxDtmY7E0jIpWQ0NAGyLWYSW6Dh7Swde+GnzaRkGh0nYSoYsIVOaFDwe0OTjJoicYZr+Kybnf0zrDpEaMym0J9mE2LJLeuCOLxP58D4cNqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Sat, 10 Feb
 2024 00:55:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7270.031; Sat, 10 Feb 2024
 00:55:23 +0000
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
Subject: Re: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Thread-Index: AQHaVjTM4mh9/kTPoUSvLm4ofHC7c7ECfcqAgABNcYA=
Date: Sat, 10 Feb 2024 00:55:23 +0000
Message-ID: <563c21d91b4b8f29c434d0918d489ecdda3f67b7.camel@intel.com>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
	 <20240203-clone3-shadow-stack-v5-4-322c69598e4b@kernel.org>
	 <565ca9697cf26be5509ef4b3c1cc95fa4f692b9f.camel@intel.com>
In-Reply-To: <565ca9697cf26be5509ef4b3c1cc95fa4f692b9f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: b3a5895f-76f1-4401-b9e3-08dc29d2f692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYIfIMjC33gxLG3D/RdrRWKMOuAUXLYfahaSufUZF6KXXZPOpcd+j0MUw/6nf8b4a1Zb6II3HeKOdte3x2rO4oOlCZGbX3aQliVTKXlx0sQj7EPzHnLuI+XuINp6Q8DRMbWFlZhx/huDHaAjE9erc+mb9vN9bghaYbl1BAIkLvReBXXr2VY/HLKYFtmwMvSr9qMSyBWpBP9O9e8fDmPX8ltGWavX9qgshShZPNyLlB0y0g0M+CRl3FomrjUZobKPEjfVM/mGvIxRJPCREqS5BEY/YiTPdNglc4lgOksmCLeuPlnsqDNh8uGjuiqF5uDk1hmof5mwFXzWgi7OYBNfyfSkaL8YBJHO7xY3/DQbLriYA7fRrZB/peA4WmHIisByALAsJUF6Xg5NcPwnBybChVkiZRagEbEUU0630iAtwF4BIMGFAe8Ynw++KvGI9BmZdahrTRB3zd5TN+Kxdwp06aybuz/i7bO/USuf6fo/00QpfxlveeEf5X0IFnxrzlz5tyPPb/AvLQLyVUf9r9MGQUIHpnqG/HpJ2c1VjPVdEw7mQD2nkf6JCYpN5AIMvtXDdJTqFN4FPXMZW6rEGtZfdsiLnOScArrpc2pSmbEWd19TB9qUV+z8z9AGs+KbMmrWGbCDEfE42SiJjFCjrfafrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(66946007)(8676002)(5660300002)(7416002)(76116006)(8936002)(66556008)(66446008)(66476007)(64756008)(4744005)(2906002)(26005)(38070700009)(921011)(82960400001)(122000001)(36756003)(38100700002)(86362001)(110136005)(54906003)(316002)(71200400001)(41300700001)(6506007)(6486002)(2616005)(6512007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmRnNGttdHVpa2EyaUg4RmZOSDFpV3N2SXVaaVFJSlJOZC9EZktscjZWcExJ?=
 =?utf-8?B?VzJXMUFBSVB0QWtHTDlPem1LcDlMT1dLbHArbUZQS1lxa2Z4cThFOVVGbHFW?=
 =?utf-8?B?TUkvRnF2NnR0b0E1VEZwTjNtTWpyQXlKV1U3MkUxTm1RSENhZEUrUUlLcmRC?=
 =?utf-8?B?QjlFQ1RGR1EwbzBMcktkMlcvK29QVW95TjlhM2UrSnJ2a25FdkQ3QmRzWmlY?=
 =?utf-8?B?Ri9mU0Q1Mk9UZUwrUmNDd21QdXpGVzJjenMza2hKVzJKZnQrVVMvNWVYRnJY?=
 =?utf-8?B?ZFd0WUQ2TXFkaE14VUZWbnFGVzRiT3hPeFFJcmJCMFJKbi9jcGFDa3kzSkFP?=
 =?utf-8?B?V1lXUlgvVlpHMlN2UnBWUHZWWVNocW9rQmJsZHlaTlJkTkVLLzdsU3Urc3hH?=
 =?utf-8?B?S1pGK084UnRSdFRZbXFJTEJJSEdJR0Ewb1NZTklrTDBLTUZnT3NxaHhzbjhT?=
 =?utf-8?B?a1FkZGlobWVYMWNTQ2ZtSFFrNjhNRXEyQmlwR2hwMkM1WWtzZndkdGMyaEZG?=
 =?utf-8?B?S3g1c1d6YTFLcFVzY0g1c0o1M1k5c2xobEt5L0JvNmZka3ZRanlSSVYrR09a?=
 =?utf-8?B?ZDM1UXJ5UHpqODY1dFYxK3BYUnVyYm5RSVlsYW1TZDdkM25lSGMwQ3RjZUdJ?=
 =?utf-8?B?eG5tK0cxNFN0SGVOVVc3SmYrU1dZdkxSSStnMlFKRnFEUjRRUDE5VDZaU2dI?=
 =?utf-8?B?cWU0WWFFcENMUkxuYVRwOFFDR1MvNDZFMG5hTTBGQmdLV1RMRktXOXBPQ2JD?=
 =?utf-8?B?elR1OWU5S1NESjBwNExObFpTd1hEcys5UWxYQ1B0alY2SU91Qm02RXdGOTI3?=
 =?utf-8?B?Y3g3M3pVNlFHalhkMUdVMWl4VTNZVzEwTWh2MDRQYVM3Z1BDdE5TWlJFYWoz?=
 =?utf-8?B?MG16S2FkaFhlK29TVzd4MS9LZHA4ZHBvM2ZtazA0dGYxNlVtaWZyNUVtMGJW?=
 =?utf-8?B?RDFIaDJDZ2poN2RKdWZ0WEh0NVIyT2hPT3J3RWlLSzM3VjkzYUNKYWpyWktk?=
 =?utf-8?B?Z0ZHQ2xJWGxBcE9CVzlKU2NVS2dpM203ekFqOEp5RUF6VVowRlY3aUpIakZ0?=
 =?utf-8?B?ckpFZmsySnJSQU1IMXJFNDcxNnE5ODBUbFZramIwbXRpcjNaWUc4OE91alVa?=
 =?utf-8?B?V0VDeEVpT2JJb0I3TmhPOEJsNXltMThvT3lua0o2TW1PbU1KbUVoam5tOG9X?=
 =?utf-8?B?VjFyT3VMWG4vb3lLeXFvd2R1eUppN2JCU0QvR0lzbFNuK3d5b1c1Wk54L01J?=
 =?utf-8?B?VXZaQUR2Z25XTTZiOTdodStTOTlWVWFVWmMwVGFVTHQzRlB1VW9RYVNQRGRB?=
 =?utf-8?B?aTFkK0NNMmJFOTYzTjRqNVRZem8vckFyQXBvblVPZjN0NEg0WkhmS3dLVXZn?=
 =?utf-8?B?L3hMU0FlR1l4ZFRmL0hIS0tTRDVoZW9QZ1lNc2RoY2ZRa3FNWllFNVZRUTJr?=
 =?utf-8?B?eThURlhlL05CRjZlT0ZNQVVjcHdyaDJsZm5tTmVmbWV1Tm5PTWZhLzR2cytw?=
 =?utf-8?B?MG4wSUpGUk5FOUtXdDZoQzFtR3IxZzIrSHRXUktmM3BLR0laVFNmTkJPUnFo?=
 =?utf-8?B?d3gxWjAwMzN3bXRpSkc0QVJrdEtYb2NTWnVNaFRwQXZQSGJMSFVsNDdaR3lz?=
 =?utf-8?B?YzFwSE1QQ1RCV0hmNmpIQnVxRGN0ZHZKNXVDbFQ1WFI5S0hzWU5GaS9wUzlD?=
 =?utf-8?B?cUxEbUpVcm5INFhDQ1c0bGxGWXNlTUVaemMxVStiR1RPRkJQTHBBeDJWVTdX?=
 =?utf-8?B?c0hCMmdIMkYvOHIrbkpZZlNqNlhCY2ZKN0NRMmxyMTdIcVc3QW9mRzJJV2ZJ?=
 =?utf-8?B?bm5UVEc0V3F2OFhLRGsxVE1OSXJQWnE1ZXAxZXp2MVN0aVowMUZoY3FEVGxa?=
 =?utf-8?B?MmVPTHM4ZWsrZHl1K3J2RzhhbjRTNWpiZktxL25pWkkydUJYczhHOFNmNVBp?=
 =?utf-8?B?WVc5UGFJa1dXcGJrK252Y1BCcWVZemhycXo2K2xYMFZzMkw1TlUzZUVjNllz?=
 =?utf-8?B?S0JXOVJTNFg2TW9VREFQckNpVUdCNHN6Q0lyMjJ0citOQlhGN0l1S0Z1ZU56?=
 =?utf-8?B?TTRpZldueFV6dlk5MDRPaXRnRXZsR3h4MUlITlFRazFDVURmcTFpWk9XM1RR?=
 =?utf-8?B?ZHdTd1NsWlA0dkhreTQ2b0JBQUp5bENQcURIR2VWZlUwREk3aFJVY29MTHFB?=
 =?utf-8?Q?OCYjsnK9FjPuAhRpP/tadhk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CF78B62BCB5A5428E9C5C8DC43DE961@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a5895f-76f1-4401-b9e3-08dc29d2f692
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2024 00:55:23.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zkSHptq1WVoeWXlkAIELdmBUSOPPcLmAKXG3hdvUel0NVPC3WWllQBP2CwRrhs8oXuyLBgRb7EV77RE5QYPLeqOMM0PUfbQcSW0sya+CPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAyLTA5IGF0IDEyOjE4IC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gDQo+IFNvLCBkb24ndCB3ZSB3YW50IHRvIGNvbnN1bWUgdGhlIHRva2VuIG9uIHRoZSAqbmV3
KiB0YXNrJ3MgTU0sIHdoaWNoDQo+IHdhcyBhbHJlYWR5IGR1cGxpY2F0ZWQgYnV0IHN0aWxsIHVu
bWFwcGVkPyBJbiB3aGljaCBjYXNlIEkgdGhpbmsgdGhlDQo+IG90aGVyIGFyY2gncyB3b3VsZCBu
ZWVkIHRvIEdVUCByZWdhcmRsZXNzIG9mIHRoZSBleGlzdGVuY2Ugb2Ygc2hhZG93DQo+IHN0YWNr
IGF0b21pYyBvcHMuDQoNCkkgbWVhbiBmb3IgdGhlICFDTE9ORV9WTSBjYXNlLg0K

