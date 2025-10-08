Return-Path: <linux-kselftest+bounces-42907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F387ABC6EE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE81A3B8E7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353E2D0C9C;
	Wed,  8 Oct 2025 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wh5lvFh8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E4D24166D;
	Wed,  8 Oct 2025 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966548; cv=fail; b=dJbQlh6Lc7jCAySRxqlzjhsdmQ0fxFK2wzRsg12F/dlR5WY5nQocKNRJBpYvV+6iPMu6jtBCOkX7S/eG6FkwGWp5EG3+Y4v31aRMqUmfdF70N6X93yEqr2X6IlX48rVoBrIvo9LLmijQmsuEfGRjXXUS99nEg841ABjXWDITKDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966548; c=relaxed/simple;
	bh=ETJ6ns+lu5j70ArzUWrrMqIcQVFeN6FnMoremForZFY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tB7EqeA5zaMLx/8KbTZgUYE2Esi0TtLaG84galHfB196Tx5WEOtIe1OBtSlZ0NTUBlAmdtM7o99I3fQnVICzrHPAhFQ3V5LjWqHG1N9rWtqlzoESEaFr9x/KirRfrVAKr4Aqy1RJv2QZYykoLs2DyxuxKPcobTcCgJN3I+kkQAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wh5lvFh8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966547; x=1791502547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ETJ6ns+lu5j70ArzUWrrMqIcQVFeN6FnMoremForZFY=;
  b=Wh5lvFh8XU2fkGfjNvLqamp+ayA1khXtqmG2TVpA/Vh/s3bWwx/Clp9l
   fRHHzuIzKpVk3vQK4fD0ddezGLcv5oW38vgyekWY+xjaKrBNi5K5uZhBp
   eJI943v89F02vIl1UBIPDDCBXVPUCOZzflS9oXcJI3As9FNaay6lwNi8Q
   C+hBBwNg0WdX5QPAep9mRwKTAALfulOK67TWM9xQGnZ8akLOfCr3h5KpD
   CceSiNkXT13twZh6XvMmgFeM5dhJ7VN8kv0PceGVlf8yhQ5EJNBIGNEY1
   fNkQjNI68IRohCjU1VR5q4kZ2XiNYr0oS4hzIqt3OqwTQboVxsjfnt9MD
   Q==;
X-CSE-ConnectionGUID: JWKaHR+KTvWUJ8AwfPDcSg==
X-CSE-MsgGUID: 7ah4f8XKT7WZ9qdUvuiUpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="72430997"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="72430997"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:35:47 -0700
X-CSE-ConnectionGUID: /em0ojSESwGApKbSJCiadg==
X-CSE-MsgGUID: RcmIgyU3QIa05WRiYC2nng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="180152828"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:35:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:35:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:35:45 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d24eVDwPdqMAC1aUFvXsE+VvfDbhpJw/d9DzzChGxmz04RUBaUnIqjzZWtRLDQ5My9KWNdOk8MbJoDAkBn8+gw/J3p7PhSwAnFZ4+fHd0QRtMyJEG4ZbBKyNu/8zzk+wj+mIa++XIerQmWi7itmXu/uwDcwxiBJgRURyp0n64dbzhM1RB/vkdgVqAk2AIxBdYKURd2RArTR8d+6Qwa3ULiMK8xQTlHmen+Zc8dhHiA3CkrCcXBoVuuqBZWwHzZtg4ZtnTA2vk5WqYWEur7/wovV0F+v6uGrieBV3ddLLUTWxVMOgBKr4NtvgOkl2icQSZWnl/PbGrIxXIpVQsm4w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2c+cW3i03JXILTPtnEIpS2oRhFi6d9bcka0gAwMvuc=;
 b=FUqDZrpBWDrYWiHI9zCUpq+vsT+abB3oonOJOITIkCSFBTPdtwghbINcCO4MozhQAdcIfSVUV8KiAgFVfHt6il18DMighGbpt9l4wVZtR2HZacA32KsfrPNM/sDavuMqm5GPEHH8sM555cD0G4odYF0lfBElFx4cbMeeXtSjFfN/6AUIzAFLI98xERV9wd9sTD7BzjRvi4LIoVzto3QDZhh8jDu2eAuoYNu2MYpNMlJ3HAN22v1LplKPn2tTBDiuY9zPhWOTO3tkMN1IKADJgPczkqVS0AOaeTHzCSOQfxPfxBp1YWVGrPu8bSgfCOfJMxx+4k1o2Gs3vgDbyuMkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 23:35:37 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:35:36 +0000
Message-ID: <7aa5715f-02eb-45e4-b4fd-72a35e475384@intel.com>
Date: Wed, 8 Oct 2025 16:35:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 8/9] selftests: drv-net: pp_alloc_fail: lower
 traffic expectations
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<shuah@kernel.org>, <johndale@cisco.com>, <linux-kselftest@vger.kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-9-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251007232653.2099376-9-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------8J0F67Z0TS4VqBUkZBgpy1cb"
X-ClientProxiedBy: MW4PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:303:b9::23) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: c499d66e-861d-4350-8eee-08de06c3619c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFBXTk1Eb2Y4czZ2RGVHUyt1UUp5Wk1mU1FkSWtXVUhNZGgwTmRuRTUxYlJw?=
 =?utf-8?B?OHJPSUREYzJ4cnZGUHJqV2ZZSUpwUmVtZW5SNVVsNlB3a1RZclFRQ1NQSndB?=
 =?utf-8?B?Vm9hNDZGalRubG1ibjB1MG92MVFmNTJZeEczZnY1aFdlaVAydDNwUkZjS3pk?=
 =?utf-8?B?STVWUW80RHJlbXE4V1RSa2R4NGlSakJXak9lL2tGbit1dDUrekl5TUxXUXo2?=
 =?utf-8?B?Yk5mTHNiU251bStsRGs2M0p5K0JlN0FPQjBXcUxXNDlrVm10TGs4dG42MTI4?=
 =?utf-8?B?Ky9EdE9ZTDlwNnBhWFhDbEM4MnRmNGQxZ0twTDl3MzF2VnZzUmxpSjdEZEtP?=
 =?utf-8?B?WFI4WHlTVHUyVFRXVzdlN2hCRlVvQVZ1eFVYTTdTN3lLM0RlbnpjUnNWMStv?=
 =?utf-8?B?eno2bEtsaDROL2F3MmVOVUtXVlNxV3loeEdyMGFNRXVuQzI4d3JEamFHWG9a?=
 =?utf-8?B?T3JrZ0xQUkJGMGVpUGN1aTFYS2YzUmRRQkZESGZPL254Zk43QnVra3AyUWsx?=
 =?utf-8?B?VFh0VzZVcjhOUUVQd2tGZmR1UVRkSjJJbmJrQ1JXWm1KQ3NrVUppVzh2RVEx?=
 =?utf-8?B?NldHR1diWjI0N3hpK3FweUJnNjdSeXhIbmRDUzFQOVQ2RGlxcjYvb1NNYVVP?=
 =?utf-8?B?dVFJaWxpaVBnQTZha3dtc2JuVzNHbzY4NTBVZmNrNk9GOTBYNWhFQTNSOGpR?=
 =?utf-8?B?K0RMWlFZU1RLQUg1ckVORUNHYzFSRDd6VU9kS0U2V3dIYXYzZi9sZXh1MTU5?=
 =?utf-8?B?eUk3ZVhvemFyY0ZlQzlNc0t5b3R0SGdORS8rMEdOOTlUUDQxeFpJR2VFaTNx?=
 =?utf-8?B?Um4wSHZSTEtGZXBuemtvZ1VIRXRiMG9LTSt6cmRFTEVyVnd4cWE5a2ZSdjBl?=
 =?utf-8?B?cnJWVjExWUJxVXJKS29ZRDhuSTJLOXdFRWxzdXVpdmtsNXhqRUw5Yit4ZnZI?=
 =?utf-8?B?VWRzZjdlNDlGRFR6Y0x6Ry9qMnJrWGl2bVpjeG1OMFQ0c05hdW9xeUExV2o4?=
 =?utf-8?B?U0ZkcFNlbGpaU0lNempvL0FJc0tmb1h4RUs0SzhxZmd3ZzFLb2M4akU2SmtI?=
 =?utf-8?B?cXpUQUgwRUN1cGluOWVXeTZJWGRLTDNOTDNHTTdsNXdOWjNlNkowOUQ4czdM?=
 =?utf-8?B?VmxPa29rd2ZIU2Z3cWFtRlllbythQ0JXK2ZlRjV0WTRoMkpySXF3V3JpQ09J?=
 =?utf-8?B?ckxsbVAzVWFZK3kzSjlKSHJsL1k1eEFBVHlBK1N3aTBoQk1nbHk5K21XN2NB?=
 =?utf-8?B?ZGx6VHRLY0M2bDU5MHRPZXVsWTVyS1RvV2NjcmtaOWZ0K1NpVHJBVzJNem1r?=
 =?utf-8?B?REY5cUdwNGkwSHJkYk9lK1hRcWQyVEwxNVVNWTNmaUtvc1FEQ2VxLzlzQUhZ?=
 =?utf-8?B?ZStRWFN0YzRMV2YzYytMdG00RHU3KzFHUXhjd3IzWmh4cTZDZmRuT1V5Ri9m?=
 =?utf-8?B?eHAzMWE0LzVDVXluMTdWeXNEWjIxeFU1OW1hZnRkMkZTN2tDNWR6Q3o0RnY4?=
 =?utf-8?B?aFFHbStKM2szUDFIdFB6RUpkKzIyOGZTbGU5aXAyb0t4cEhkY0JVelNhb2lp?=
 =?utf-8?B?TlFvV0VEZDBhd2o2dFJiNC9zTFRhYWVSeERZRHkvS2JpWmx1eWYwY2hMVlJV?=
 =?utf-8?B?SXBYMTdmdGNtdStmaTJKV3BOYy9ZYmR0ODJHeHZjNllNM0xUbTJIVFJjVFZs?=
 =?utf-8?B?MGRkcFFBSFlmQkdrWTFMamdZWDhFNXF4bTJlS1crUUkrSjU1Tk1RYWl4OW1W?=
 =?utf-8?B?OVFKVGQyL3l3T3Z2dGNDZFgyTkNvOGJZUFBvTFpwSlNkL3p4cDdZR3ZHNG1T?=
 =?utf-8?B?VFAwY3MybFZ2ZUN1aDlXNG1NVGczdnRDV1UrUllTMjZyQzNzNUp4ZTIzZjBP?=
 =?utf-8?B?U2hMeXg1cTh4M3ZiOGIzVXM5UkRxT0xRZ1p1cEdpeElvSFBLaDg3REJ3UCsv?=
 =?utf-8?Q?loTYk4Myw5gD3Rcrc4hsCIRTYXSvMGsX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURyNCsrK1JNMzdIVklUR2JCS0dacERDR3pqcmZzeWNrZThmTTIweU54NTBz?=
 =?utf-8?B?NkJjZUdRN0VjY1A5aUdWaDI2LzJhMyt6OVVkOFZEQWRKTDlERW5pZ09PYjVq?=
 =?utf-8?B?UkVIb0lRamdkdUtzMDYyNVBaeWFUOGZ6OW9OakhjMmtMeEl0WW9Cd1dtTHZs?=
 =?utf-8?B?dE5IK0wwbGFiWjFuSVJQdmIyRTkyQnUvQXpkY0wxVGtINkdaTXVVdEVMUy9M?=
 =?utf-8?B?ajRJajRUejM5b0cwTEl6NDc1SmdkbUt0Uk95QnZTNHV5QU11b3oxbFBSdWd3?=
 =?utf-8?B?V3JCL1V6L3FNZlk2RFBmaEFXclZsb3RSdi9TYnBGSG5vc2pRaTVWZk16ZFN2?=
 =?utf-8?B?NEdmUm4vR3QyTG1ESzZlWlRBK3lUY25pNFRxVDd0MVkvczJmbHhkdnJYMkJD?=
 =?utf-8?B?MWpLaGhWNytZS3BzSTR3ZFloTi9Vb1NLOUpZb01uQnRXTjR4eW9OSnV3T2NM?=
 =?utf-8?B?R2RLN1cvdkJPWlk1ay9nTkpHQk04dGtVNWxOV1lGU3BYRjBZUVM1bkNuUUxO?=
 =?utf-8?B?U2xHSUQ5U0FEL3JSOGVaR1BFNDQwQ1Rzemh3Y2RjNkM4VnlSZVNxQjNQb2NI?=
 =?utf-8?B?cmwxeUcyZWFIbWpmY2d2bnpjUjhoZGdyeFRUc1kyalZKV1JkRE1Qeklqd0tQ?=
 =?utf-8?B?ZWM2dFZhVVdHT3hOUXFhUnBzRXNtdVAwb0VwWWg5cVlSWlFXenhPTThjRVJC?=
 =?utf-8?B?T1c0Mmg4ZTJpNmQ4YTY3aXJ4VHNPZ29LSzNPdWsyM3hLMzdBQTcwY2loV0RP?=
 =?utf-8?B?VlZUSlRxL20rRlgxakFyb3ExdGFyVzRWbHhvL21NNHpwa3hUL3V6eSt2eGhX?=
 =?utf-8?B?NXpwYmxFQ3Q0amRvdHV0L0RSZVk3Q3JRbDdTMFlOZUcydjltcWVNUU5uVGY4?=
 =?utf-8?B?TTRiRXZqL3c5MFdHT1NaT3paUWhET0RuK0h2WXViZWRkeVpTVDJGN1ZVb29h?=
 =?utf-8?B?SGM3djV2Zk5oeWFmaE1KdGE4N09pUndOT2pDNjg1OFB6RlJsTk01N1dXdEp0?=
 =?utf-8?B?Rm9mYkJOWURZMm53RFBtRFBxeThldVMrcWhqZFp6QjNvRDRsajVGdDZmSlk5?=
 =?utf-8?B?K1hWZVpMOC83MDV5MWlMRUthQ0lGcER5bUsxRTdFNG50V0pIcS9lQVlKd0JX?=
 =?utf-8?B?Y0xRRDZyZXNrNlI3RndFYVBVSjJlVC9RT2NOSnBsNDZxVW1IYVhmT2pxRWVv?=
 =?utf-8?B?ZmxYcFQwZ0RBeGNOR3N1Mi9ocEJBR0ZzWjc4YnVBVWRFaFM4YnRXY1E5ZFQ1?=
 =?utf-8?B?dDlpREE0N05uMEljbkUrTklRZ0F1UTN1ekxRNVk1bkRYYjhSS0VQWTZyWkVw?=
 =?utf-8?B?MytGcU1IVGxXSDkvYzRDTjM2VlN6ZVQ2bjVDNURaelRHL285d1lMamp5MVd6?=
 =?utf-8?B?NnJUa0hvaUhGQ3M0WlQvUzY5WkFHV2hmMUdpMHRWaGtyY0MreGtVT01WeE5D?=
 =?utf-8?B?bjdLemF3Y3l4aFdtWUxyRE9kbXRjTWppdVRYcnVPZWJ3TWpNdHVkVnJTTDhj?=
 =?utf-8?B?R054K21FQ056WGhqYlFwUWNCQStoNzhGd1dwYWovVHJCQ05jT3hUemx5azN3?=
 =?utf-8?B?L3ZjbzZlY3Z4bURMRnZWYmE4SXZIa2JmK3A4SThudndDSDZGdE9EdlNOc1hS?=
 =?utf-8?B?YXJCcFE1eVNUWnRadHJmdVRLbWROcFk1OUNnekh1cWpJSm0xam15NFVsWCt3?=
 =?utf-8?B?MXlVVThIdHRpVGF6bVpNQ1dCMm9kYUV0VU13cWJ4UE5IRGtyVXMvN0VzWGVW?=
 =?utf-8?B?SFNYRmNwODN1dWM3MVVyeE5IZm84SWRTTG5mL2hMMWZMZTlJRklKVzdtRWQv?=
 =?utf-8?B?SlBFa0N0UzUvK2xnVjhnMitjcWVzTEZjRTRKOWM5dkpoZFBucG1zRkhvQXk2?=
 =?utf-8?B?NzN2eHlRNFNHOWxWRjFBMTJTWG5WK3o0eWVpYUFlRUZ5QVVqQWM5N25UMVhG?=
 =?utf-8?B?QVJWZ3ZSbnNwWGdId1NxN3ljZEg4ZWsrMXhCMlJBWkpnQmh3SDluL2RJZ08w?=
 =?utf-8?B?K25BYWQyZE9ZYzNpdzd0Q2h4QmpQSlNTaG4rTzNaTjVhTHdHR1d5cmE5eVly?=
 =?utf-8?B?VFRuYmF3bHA5MzVkenJMeXN2OWVNS1VLTlJuZHF0ZUhqODk4cjJ3N0xiTXFk?=
 =?utf-8?B?YW8wTHA1U0d2UVR2MFU5NHlldCtLYUEwUGRWc01US252c0todGpMdjJPRnB3?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c499d66e-861d-4350-8eee-08de06c3619c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:35:36.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33OaLFQBrLUypHnIu6xCqVavt7YaesUZXFiXHVdkB7w9xTknyOCRISYUmGJFW3FdkOxpnYFf59wMRLuTDJ0+fmGmxwNPuVbiC6Ggb8+SFdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com

--------------8J0F67Z0TS4VqBUkZBgpy1cb
Content-Type: multipart/mixed; boundary="------------erqW4YceCNEosEFFc9Ftp8PF";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 shuah@kernel.org, johndale@cisco.com, linux-kselftest@vger.kernel.org
Message-ID: <7aa5715f-02eb-45e4-b4fd-72a35e475384@intel.com>
Subject: Re: [PATCH net v2 8/9] selftests: drv-net: pp_alloc_fail: lower
 traffic expectations
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-9-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-9-kuba@kernel.org>

--------------erqW4YceCNEosEFFc9Ftp8PF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> Lower the expected level of traffic in the pp_alloc_fail test
> and calculate failure counter thresholds based on the traffic
> rather than using a fixed constant.
>=20
> We only have "QEMU HW" in NIPA right now, and the test (due to
> debug dependencies) only works on debug kernels in the first place.
> We need some place for it to pass otherwise it seems to be bit
> rotting. So lower the traffic threshold so that it passes on QEMU
> and with a debug kernel...
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - use seen_fails in 2 more places
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------erqW4YceCNEosEFFc9Ftp8PF--

--------------8J0F67Z0TS4VqBUkZBgpy1cb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOb1RQUDAAAAAAAKCRBqll0+bw8o6CgC
AP0ZeqlQJMK1imHn72QH3pVaFWHEehnCPhWz00rCFWyxdAEAxq2od94N9fSKOcayCnh/S5SLa4nl
E+DTIs1hBlLd9AQ=
=vV2g
-----END PGP SIGNATURE-----

--------------8J0F67Z0TS4VqBUkZBgpy1cb--

