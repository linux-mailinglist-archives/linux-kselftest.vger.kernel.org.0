Return-Path: <linux-kselftest+bounces-15177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E770394F840
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 22:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F136282540
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB391194AC7;
	Mon, 12 Aug 2024 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7l3qGic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F3194A65;
	Mon, 12 Aug 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494985; cv=fail; b=BJCr27rP3746oCtKCprVjvXKOXXqAoo1fyHapc5M+BaAJ/4+/P8ganQDpVyjD6DnZnhYhhvbthHjWuiIIQvizvnGvO/uSQx883zCAHqPCeS8sGD6bzmSGLpyIbfkXPOnD6CtdV1OPYJfbryki3xrzss0+CVTZcoz/4PftR9G6uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494985; c=relaxed/simple;
	bh=S2dt2hij3Tgm1AxS4+GHnPEwOUwISjCnrp5KIEpIYeo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDJksL+lpytBSANRExOAj9suVn5dVpJgVB68PfOGUsrpoJHPMLGzLDHy82vEWyxEy7UMoVFm1Vsre1mwWoARRJWErebAtPq1aPLrlLz97Nd11E1BsZZQLuVL1OsaVonW80e+SxrXivJv0/sX5FgDpjUarMEONv4zqAmD4F6uNVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7l3qGic; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723494983; x=1755030983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S2dt2hij3Tgm1AxS4+GHnPEwOUwISjCnrp5KIEpIYeo=;
  b=U7l3qGicVoqA3zDOcepmbU4CS4kZHom6I8rZATGEpucufd9rwusgVq6Y
   PmW5ndbgiUmj2kNI4lFS2FPSzrvlMBvokqQ/4yBhoxHGTuhL27nvDqtaF
   KMXRJERCD8oztstZihGvsTtN42dDBnzrL9oyJ+h2vsF+XkY4a7c4nemkc
   Co6zjB2S9AQZTI7ESU1xWPmIkg6clBHsfeYCmQ45DafVLsG0NED43o33A
   5fEelBH1mJYFUO1xR9KWH4Rgh0zvFEqlrzuR1gSd/OAfE6p+RvFE3LdZe
   lWVfSO9LTlztTHBxzvk+TZ8OAYVojFJ3iwUFcCENg2RxD8SVtyg79W0Ar
   Q==;
X-CSE-ConnectionGUID: vHuR1j/tQvGl5gmAGcF+og==
X-CSE-MsgGUID: K2/RLJdOR5241n5WNLBShg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32199751"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="32199751"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 13:36:23 -0700
X-CSE-ConnectionGUID: Wc3NsR/eRJGlj6FxxBZvgA==
X-CSE-MsgGUID: B0mEolLDRMOd2FSpAuuwXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="58329153"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 13:36:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 13:36:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 13:36:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 13:36:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 13:36:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRTWHLKrvOJIDs43kx7GU9ZAmGBBx7858PIodUKec26iO5fFRhYbB5xgydRWBaNS8QAvajhw4n1qxH9ZfRlp3+dm6vmB70UWgrme26a3o3b+2Vtz9f+5MUTgrixrh4vgbqpjpoKsn4Koxupv3YUzrNKAH7qCY/1BAYLwVzZ7njLjympA14Q5jX7hYwXl7YiIJ2AbODjDd1C9BQ4pnyIHO7qffgIqf264gRfoUZbSdtRvJixK3I8svz/vv+pq+3U66C0oQBycNIpgJFdSWNnQWDyiUahg1Qno0BMGxN6r9RS7sq7a3AsKnPH8C1e8jNIOP1lCNRvKZNX2UHsFPdInXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Hy2b3Y9uu8hJ1T9Djg3hfl9hBDsXAVkceFYaSe4vls=;
 b=Q0soJ+uGdaKeZulcAdSwVOVUEnoZQbiRb78iF/iArCGAf1+sF8RiKtTgIr3R0wbMhQMfoRe77FbgrxDEBHqpFWm0BddUT0S7FhS9K6VDPTS/PHhnIjrlCW1LfBFQiLCFMsehfV5oV20HZ0QsigY6v1djArHIluorY3kc+SQt+UelFeSSrabofozv21DxOFAU538xQmPdvEkHjDIWbphcF71/RwcqR7jbynz3oUXjbt7N1b3QU/UmTE0157mkVviwl3KH7YsvdlQbKUWvJxRwRJoB/68iH7YZmRFLTmSthSw7DYI0PI5q8G7PSFuBdP7ryg6GbeJRE15MbbuiZtR7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 12 Aug
 2024 20:36:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 20:36:19 +0000
Message-ID: <db16db55-5f68-484f-ba9f-3312b41bf426@intel.com>
Date: Mon, 12 Aug 2024 13:36:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Muhammad
 Usama Anjum" <Usama.Anjum@collabora.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, <kernel@collabora.com>, Shuah Khan
	<skhan@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
References: <20240809071059.265914-1-usama.anjum@collabora.com>
 <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
 <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
 <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e92c01c-8d52-49db-c796-08dcbb0e6bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk5wNmVEdm9Xbzc3dDBUcnlNVmdTQUhUWUpJOE9XVXQ0cm0wUEQ1USsyNzhL?=
 =?utf-8?B?Qys5aDJEQWEvenhyM092SzNETzZMV1hGN0VmZVJjbjJ0VU1Ic2tveXBqSi9D?=
 =?utf-8?B?TElPOHA0K0dFaEZ2V2NveDBTRDZtNEpMM3MrbzNhZUFUamlMcTd3WHY3SGE0?=
 =?utf-8?B?T2xuWlJGc2JnbDhKV0dPaG5hRGF6dCtlSENJSW81OHZ0ZUhKYytpS2krL2VN?=
 =?utf-8?B?QVd3anFVUXhFN2tha2hWTkc2TmxOcW5jbFpQREkvditkT2IyK1dLcFhFSTFr?=
 =?utf-8?B?T3ZNSUVrQ3lpT0c2N2h6T1BYaXFhUTBGWEFCN0VRcWZhcUNFQWhwaTBPL09y?=
 =?utf-8?B?VnJ0SStDZUJaYmoyaGI4ZWNUSS9yaXFpVmJaZThISTcvOVdZbDZwVFp2VmFO?=
 =?utf-8?B?M01KdUZQYktuTUtyRHR3OCtiMjVMcXRpdG1tWnNEdGdMcXFnM3dyMUx1d0w4?=
 =?utf-8?B?Y29yVXhhL3gzT3AxQU9FbUlhSXduQWIxMGRoZDhzT2lvS2dBY1ZrL21YdmdY?=
 =?utf-8?B?d1k1ZlNkdmVVSkQyL1UrQ2M3Nk5QN1hGTERxRFpSMmpRQWM1WUEzb1J4Z3ht?=
 =?utf-8?B?SDlpN2ZoZlRtbGJselR0dmxFb1NXbWJjclU3RWxVMlVhZVl4dktNWXdmSlNk?=
 =?utf-8?B?d0lTb3ltcmFNRDZWUkpNdm8rM0F3eWhHK2I5alI4NEJPNk1xb0k5VDRWZkNW?=
 =?utf-8?B?NFRZM0xYZ1pzWGNuT0w1T0kxNWJtZ1FCcW0zQ0FLc1ViVHlXYjArcllPdlg0?=
 =?utf-8?B?U2U5ZjcraHVyTVpkbndVbXg3UytIRmNZOVEySnNxSkdtYkVLWDQ3aDB2TENo?=
 =?utf-8?B?NzFmQS9FVWRnUVg1cGlidmNjMUJnV0ZUajc4QUdUd1JkS1FLMm9BUWJjNWpD?=
 =?utf-8?B?dHlqQ2dnd2dNbW9QYzdsVVdqOVc5SFR4bWhRWk9UMVdJek9iY3VOVjd0cTVv?=
 =?utf-8?B?QTBXVWl1YzRwaVZ6TnlNMWswOXNDbEZybEJXU0owZy9lWkc4dFRPbFY4Zmxk?=
 =?utf-8?B?VUFqT0ZObWRYR2c3VlBnOTZtWE1ocURIUDRNTE41V2ZLNEtJd1hma3l5Nk94?=
 =?utf-8?B?Z1NVc3luRDNob3FEMGJQQUlIMk9jWmZjVk96eXRjTnE3L3VUb2Z0cmZ5ZVNr?=
 =?utf-8?B?bWlLWnpqVUx6WW0yYXE5Mzkvb2psMlk3bWZ5eWV4Z2xYK1dXL1h4THRnU1pz?=
 =?utf-8?B?eTRSdERZM0JSR2xZUmtmaUdYVzk5eU9Cb0l2WW9YYlAyMHNlWmpTYWZacjFZ?=
 =?utf-8?B?MlRMcDNSanM4ZkhGVXU3MDZsM0pOVzFqZVQ3VUMyWmsrZGtsMGFuV2dnUCs5?=
 =?utf-8?B?SktCcmU5djl0Ykd2b1lQRVJnL0pUVHRtUGZKNDR1OU12amZ6dFBCMHkrbUZt?=
 =?utf-8?B?WVNXUjRrQkduaEtJWC9tb1hCSjc4d1dBRzhWbisvVW1YSHdtOFk2Zlk3RkRI?=
 =?utf-8?B?czVYMURMRk9WQ1YweWZiTktWK3FFenk5cHZwUk5LTE5NTVRHbzNERnNSdnBl?=
 =?utf-8?B?T0FlMWdQMlZENWQ2UnI0cFBXbUttc2ltNkFUVzgycW1MSXd6eit0OHkrV21S?=
 =?utf-8?B?dXF5U3BBU01IVzJhUUxQUTVBdXlDQ3A1cW5wek1VTk9hcDVndjRIdXN1Y1N2?=
 =?utf-8?B?V3FrZVdmUHlGR29CR3l2bjlhWkFuaXd6RXMybUhXRHNrNXEwWjAxM2gyVW5U?=
 =?utf-8?B?NWlQVkljZ0FlNWVFMGhObStvUlhPMTZSTHdLMzhjRE1rVytEVW5ZNk1INWUy?=
 =?utf-8?B?cjQzYU9kbkJqSlhRSU9SMWlHZkZxdFEzOUNEZW12VFgwY1ZRdjNKTUpWK2NH?=
 =?utf-8?B?WEhkVWhFZ2FpUHBKZjFmQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJQSjZ5RDk0T2VPYTJXTXRaMHF1MjZXU3dXWHlRK1hONDBmYjZrZFFjS1Fj?=
 =?utf-8?B?VU4rUWVQRXJYT1hEWGt0a3FIVmpqZ1g4M1pKN1lRcHllSFFZRFRLakU0dGxn?=
 =?utf-8?B?bys0disrTTZqK3FiM3ZlVHpZUm5hdHJTNG9nVnZqempmV0lIdko1aW9nK3da?=
 =?utf-8?B?c2x0ZEM5cmhOVmsxRlRZdmFoSUVxaTBnTXFGSWJYblZ0UFpaWXI4L2MrV0t3?=
 =?utf-8?B?TmVDWldQMmVNS2YzcjA0T2NVY0RMTExSSEtsNUhaeTkrVlNsZTMyeGdGMWxp?=
 =?utf-8?B?WTc2OUpud2ZSYk1uYzdUMktuYlp4K0ZheUxvcExtUDdYUmRwSmtTR1NJdUsy?=
 =?utf-8?B?ay9sS0hQNk1lOXFodlc1WmVJRE1teEFLTll1K3hUckUxWXVKd2tod0xUbVZN?=
 =?utf-8?B?emdJb0xuQnQwU09WakhQMVJZYnZiTkdTVnpmWmdwYnJ6bGorRU9SM3N2SURW?=
 =?utf-8?B?ZlQ1WFJIWG9Rd2lTUS9Za0pYV3JHZ0xGTjF2Vjd5a20yQ1g2R3hUUDBNempy?=
 =?utf-8?B?VXRoK2pFRUM5ZG0rWkVCVWs1VVZZbEZOTXZrMzVIT2U0eWtVbDhFOCtDK0dS?=
 =?utf-8?B?VndCSVZEd1BicFdzamhpclRmcW5WdWhtRDZ4d25nZUlOUkExYnhONktmUjkx?=
 =?utf-8?B?WkhMN1BMZ0pIbDVKVGhZMldndnRaL0xFbHBSOWdBcmtQOUFYZDVjcXhNNndZ?=
 =?utf-8?B?djJrdTJ2N0NQdzFoR0x4elkzNUdkWVBFQnI2VmoxSmd5RkZjWWxlTUgrb2JI?=
 =?utf-8?B?b0dpeWdHMFlUci9UamI5TDVEa0NyS1cxM3QwQVJsaXdSNjhtZjVjUWg5U3Jp?=
 =?utf-8?B?WXh5c1NoTGMzYmkrSXVLRTFUWVo5TFJkSjZnYmt4QURwbFE5SHdUNHlUSmFZ?=
 =?utf-8?B?NHZ6TEVGV1k3YkhCTDFpRE5LdThDRDlpVWwxaXh4dHpta0UxQjNiUnZCTnVh?=
 =?utf-8?B?T0lIWlErRXJHNDgxNEtsWDNZZW5ReUhYUkxYSDFIeTA0VHRjN3J3bmw5TXIr?=
 =?utf-8?B?aFpGUFh5aEhRM3BuNFErL3U2NTM3QUl5eTFiMGR0dWZ1dTRDMmRjVUc4c3F3?=
 =?utf-8?B?SFZqRDlrQlA1R2NHWHlkVEpnY2ZpcWRZdkk4dWdmTU5aYlM2MFZzeWJ1dVd3?=
 =?utf-8?B?d1VSS0xLelNySWF3SE95cmxjREdoRFRtSkNSdFRDSzY5N25UOUl3elBIbVpi?=
 =?utf-8?B?eFFudGc4anBtQmVzSTRCZ3NERHorUnJwcVhzMGtSYUlvMThVdnFPMHNZbElD?=
 =?utf-8?B?ZkVDT3dRb1Q4NXFZTWZCYU9laTJrRU5Qa1M4N0N6WnhnelpLTlB0dW1kVHVH?=
 =?utf-8?B?NFA0UWVqbDRSOXBaYkJwTmZackxaWkFaaFFnYVM4RFZFZHVlUzB6MmNiR1l2?=
 =?utf-8?B?WHBsRk1wYXRwNEpWU2ZXaDRlanAvbG8wNnRtblpkVi84OGh1YUZKV1NYdlhM?=
 =?utf-8?B?MGdkZGtxYlAycWZsSjkwL0sraWpDYk5sQTJqczE3M0wvdlVwa1dYRGJtbDhN?=
 =?utf-8?B?aUhidXdCQXkvVENWdXJzQjh2UHRyaEZ5UEF5L0xmYmlQWC9CcjBBNXB0MVdj?=
 =?utf-8?B?ZXZKMkZZblIvVkVDZWlPZGZERDNCZHdBQ1NiZkN6cnBhZEQyS0Z6b3Zabnhq?=
 =?utf-8?B?QWlBdHdYcWJPVkszRE4wbnBhc3NhQ1V6alN0RXRQN284OWUySXA1ZGU2L0RN?=
 =?utf-8?B?THBidEdoQ2xaMFNZaU43Q2xDSExUV1RTU1FzWWN6YitJSCtBamVQRi9nQUtq?=
 =?utf-8?B?T0h2NEhIZUFTdmpzUTNzVEJMRGZ6MVlDTWRuc2UxT05vUUpiRVRVMjFqcUdT?=
 =?utf-8?B?dkU2eGs3WUlsY3FwNjgzZVpPVHZZQUphbmMxOVAydXFLZnRjb3A5Z3NnSEp4?=
 =?utf-8?B?VmFwbHFXaU9UTXE2R243TkhWdUVpMmxqeFRkR0NLN3NXcU5XbUVPK1ZaNlFp?=
 =?utf-8?B?TkxWYk5kd1dDRHhkNVovMlpzdHE1ZnI0UGkvMWhQdzN2K0dCUTl1eEZNMzQr?=
 =?utf-8?B?cTVROTY0MGhkeDRSaVd4dTF4bFpuTVlpTlFRS3RJS0tNWXF0VktHeU5tTHJp?=
 =?utf-8?B?dmh0ZENJbU03WFpzUjZETmpTU294UjNtNEdHVENKVUQ4aG10ZFJ4RDFORUd6?=
 =?utf-8?B?MnlvWS9uQmZXeSt6WVVhS2psN1FEa0hKUzJGODlSL3l4T2VyMklvbDBYeVdl?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e92c01c-8d52-49db-c796-08dcbb0e6bf8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 20:36:19.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vc+17olNPW1zSMsmm34QpAHXbLPXOIX06UO00z+6Ow8DETGgA2t+usqjv3mnlOO2wEH4jsMuqPfrBAYfArpZt808r9/GAlVZjGEm0oIq+b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com



On 8/9/24 1:45 AM, Ilpo Järvinen wrote:
> Adding Maciej.
> 
> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>> On 8/9/24 12:23 PM, Ilpo Järvinen wrote:
>>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>>
>>>> This test doesn't have support for other architectures. Altough resctrl
>>>> is supported on x86 and ARM, but arch_supports_noncont_cat() shows that
>>>> only x86 for AMD and Intel are supported by the test.
>>>
>>> One does not follow from the other. arch_supports_noncont_cat() is only
>>> small part of the tests so saying "This test" based on a small subset of
>>> all tests is bogus. Also, I don't see any reason why ARCH_ARM could not be
>>> added and arch_supports_noncont_cat() adapted accordingly.
>> I'm not familiar with resctrl and the architectural part of it. Feel
>> free to fix it and ignore this patch.
>>
>> If more things are missing than just adjusting
>> arch_supports_noncont_cat(), the test should be turned off until proper
>> support is added to the test.
>>
>>>> We get build
>>>> errors when built for ARM and ARM64.
>>>
>>> As this seems the real reason, please quote any errors when you use them
>>> as justification so it can be reviewed if the reasoning is sound or not.
>>
>>    CC       resctrl_tests
>> In file included from resctrl.h:24,
>>                   from cat_test.c:11:
>> In function 'arch_supports_noncont_cat',
>>      inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>         \
>>        |         ^~~~~~~
>> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>>    301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>         \
>>        |         ^~~~~~~
>> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>>    303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
> 
> Okay, so it's specific to lack of CPUID. This seems a kselftest common
> level problem to me, since __cpuid_count() is provided in kselftest.h.
> 
> Shuah (or others), what is the intended mechanism for selftests to know if
> it can be used or not since as is, it's always defined?
> 
> I see some Makefiles use compile testing a trivial program to decide whether
> they build some x86_64 tests or not. Is that what should be done here too,
> test if __cpuid_count() compiles or not (and then build some #ifdeffery
> based on the result of that compile testing)?
> 

It is not obvious to me that resctrl needs those "trivial program" compile
tests. For testing the target architecture ARCH seems appropriate. I do not
think it is guaranteed that ARCH will always be set though so the Makefile
may need an additional snippet to set ARCH to "uname -m" if it is not provided by
environment, similar to what is done in other Makefiles.

Reinette

