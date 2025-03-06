Return-Path: <linux-kselftest+bounces-28363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B924AA53F91
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 02:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13643AA81A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B762E40B;
	Thu,  6 Mar 2025 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YUGKYpNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202412E1CD;
	Thu,  6 Mar 2025 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223116; cv=fail; b=KcXg1f1TVhu2aqvIalt4lytGLAFegCArqb40/hUU3qTA0khTedc3h8tiQSLYsrV5O0i5dJg4rkYm7Euz2Geh4IuRPTUM/vHjJZEj63DNAYwRBg+ox0Tbcd29MvK/BWWFqE0szcxfiQaPpgMqkdlIBhDh4JEnNbsv1w+b7AavUd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223116; c=relaxed/simple;
	bh=CGqjn54tgnlwZfn9WveBpZJIEltiZcFgHAGzQKa9dpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p3Bxnm+s67WBQFV/rXbdgsSvBhozR5dN6liV95Wunfx1lPTuGCMebftkppxm2aTa8EorlFkCNEDTld6hZ6W8SARVlYiQonmQVbgAZaqTxDCOpjdcAQkrCEaW8b8/shhphraoG7OImoabkLQcKjhrQG5xTUk36t667XgKBld/aA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YUGKYpNG; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741223114; x=1772759114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CGqjn54tgnlwZfn9WveBpZJIEltiZcFgHAGzQKa9dpM=;
  b=YUGKYpNGTGHarLtguoi17V+ZLq1eWHXqTpCbgLf9MS1r233vnWOkkZvU
   P7CzovLQU55Yi1kCHJf0bvCZmrJv+nUF+bIhIfvvDo94d2Ly2mThcxPPP
   XRzQ8TaaZzEPCr5ng5mCrfp2xr9zXJG3/ZuivGWmG3cQqRDFRuDYR7LDP
   /8PlNqWGOYwJrn163qIk1NDchOwhBlqcswvGbz9FkxqyBQlDg7KdEOw+z
   nhAY6DPJpFq32wuV6WlXg2U4bqqDYaFv3+UiqScsN+zA4MdrxSrBB2GHp
   vASZ3tMjR1gVce5Ms96E4TwAbqWLUckHm8w35h8Qq8l0IVswQ/xJXBgUF
   g==;
X-CSE-ConnectionGUID: EB4eHbRvSEe6dKrpXDU3Xw==
X-CSE-MsgGUID: PfKg7i9/StKe/eJ5f4Dy4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="148486743"
X-IronPort-AV: E=Sophos;i="6.14,224,1736780400"; 
   d="scan'208";a="148486743"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:03:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JztR8e/vVbmd1Pk8iLpvZKC7wXVwqXUq1pH+ch8JzWgi6qXvXudetx/VI6shh/TbsxYFQZi5FkG9acr4hMmi1KNAi+kdoMQ6smUaljGUHWNTGpLH7egIY29r1/Jfo02hnS4bX44wUDydp+cwZXndE5yux9dbeIB/yNQIM555A6guqpm/2yb2l7DaCYATFp9OPjNxKlHpKZ1wTxkwj+XyOPRi5AifmK9TxNe/FwJvuBDPfVr6SmAO/EMBlUf/hKXJKWmpYajLqzmfH+HlV5c01u6IaQT+C9GQfGujeI4MnyE2/MjZDCG/QxFtMX7oBQI55qb640WlL1JcDmYcU7SWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGqjn54tgnlwZfn9WveBpZJIEltiZcFgHAGzQKa9dpM=;
 b=h2l9X4Wqd4cIkhzqP4jrdSzCXXr9RmfiRP4eNRZR7vBv5VoguOuGOUHGAucJvr+xyNWNjlZQ7dIZVydjfHa3WBLLv94tjX2Q7ExK5ycGQUSYIn/vWapXYRpIzcilowu2p3tx/Eeq05yyhT7JZT0EbpB2xYj5E5MH+V1wBrfHFWbuB3iNyKpU/nD7cvO1Ryjx1s6YJbRw9jOhmpzTmCAvqVtBWQ6mBbfE92YC4ocguk1XQo0v+LKUA6xTbhpw7X6eFxu4iyBG9vPgrJ2IY7QARTqAi9TG0YCsS7mhXEBB5vDB4yxX05heuHE2fl3Xv41lcRpfb0ElP8quBlbi9tc76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSYPR01MB5351.jpnprd01.prod.outlook.com (2603:1096:604:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 01:03:35 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 01:03:35 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Daniel Borkmann <daniel@iogearbox.net>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Shuah
 Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
	<andrii@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Quentin
 Monnet <qmo@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH bpf-next v3] selftests/Makefile: override the srctree for
 out-of-tree builds
Thread-Topic: [PATCH bpf-next v3] selftests/Makefile: override the srctree for
 out-of-tree builds
Thread-Index: AQHbZu9RSPnmDjGMTEeodKscSb7N/7MX8D+AgE2pCgA=
Date: Thu, 6 Mar 2025 01:03:34 +0000
Message-ID: <2a7d773b-c63e-4782-a0a8-13a421de01a7@fujitsu.com>
References: <20250115014734.438225-1-lizhijian@fujitsu.com>
 <af9c413d-136a-413a-ad99-8aaf98f1e31c@iogearbox.net>
In-Reply-To: <af9c413d-136a-413a-ad99-8aaf98f1e31c@iogearbox.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSYPR01MB5351:EE_
x-ms-office365-filtering-correlation-id: 9272633c-67ec-47a2-9f4f-08dd5c4ab86a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WktaS05OT0FLcWwxUGp1c3M3enpKcjBGazFjMVBIdXZDNW5lZFlIeGt0NUp0?=
 =?utf-8?B?UnpzdFZiNlpZV0JNc1U1aDE1OGFFRjI0OTZsOXJiK1lWdGxmb1Q0cDU2MWVN?=
 =?utf-8?B?dTgrZU9OV1I2Z1I5UHRrNW0vZ2d2dW4wbzQrdzZjSVY2a1Izc1RLdkhsSmtr?=
 =?utf-8?B?MkNzMDBTdVplVUhsU0Y4N2RJbjArcTRBTGFLb25QMjc0Y1h0cWxRS3p4ZnFk?=
 =?utf-8?B?VDJlaEZNUzBWeWhFNzJ2Tkc5QUZIdkE4K0Z2S2RqM1h2UlRJMk9ScXRDRUZJ?=
 =?utf-8?B?U2M1MC9OQ09KQ25la1dBRDNtSXExd2ZGYkVNUnpYL2p2WEZienljWE5weUhs?=
 =?utf-8?B?djVNbXZJWnlrNEIxU2YvekRKM3dGa1A3ZlJRaFdDZnYwKzVXaTRLZ1pUSEFr?=
 =?utf-8?B?dTlNalYxc3ltVVoxODk5aHZhbWJmNlkvTVBqenJCZDFWZnZ4ZnFWSkFTS1ow?=
 =?utf-8?B?MmdZNWp0TU4xbVZSUTVjK3h6NTJQWllBd25PUzhzOHI5Smx2SHdoSFB2TGh3?=
 =?utf-8?B?RWtYbUNqV0VYaEdpblpyOG9XQnVSakN4LzlTSkQxREdMM0MvK0hhRmhoWGJC?=
 =?utf-8?B?amxWUTVHYStXOU40RHJnc3ZwY29ZK0dqanUyWUIrTTljZE1UUW4zT3lTa3RJ?=
 =?utf-8?B?ekZLNDFHUTFWcU9VVG15VHgxTWw4YXhWdEZUM1JVckNuZjNJTGdtVHFHMzJu?=
 =?utf-8?B?ZXNTOEZ2MElhajRhM1k5OTJwem1XQmFhZk00M21uZnRGd3pIU215MFZLQlRK?=
 =?utf-8?B?aFd1Z0liT2hyemsrTDRDbkdPMjZRdUx0QkhBY0hNaUttbnVMTXF1Qk1yNDlk?=
 =?utf-8?B?WnB2WVlQNjUzbHpHeHhNM0JrS2JURWk0U3VvS0lEenkxTUh4dzVTQkRia0Q1?=
 =?utf-8?B?QlFqNko1SWtTYktXQ3lsdCtGUGphZ2JFZjZjRHRIMjcxU2E4TzgwNmphVnNa?=
 =?utf-8?B?MTQxeXFWOE9rL29kdUExU2ZHVUI1RmVKVTIvQmJubS9qY0RZQTlmSjdtQzJ5?=
 =?utf-8?B?Vm9ieEJyQUpXdUpIaXN4VHd3b1Rqb2llRTFWUjZ3aWVGMU9ZU0NqVjRka2or?=
 =?utf-8?B?dDk4RlpkdzJybnRrWENRV3VDbUU1UU8wK0xTblRWZFJIaGtYRGRuTlE5bmY3?=
 =?utf-8?B?N2lKMDYxYUxTWVJnRGVqSWl4QW1QSTdaS0labU4wT2xoTXU5WHgwTFFUSW9a?=
 =?utf-8?B?ZEJpMmg5ZWsrbnJaSGRVOUpQSFREUEhZUTJ0cmsvNGV0MHArZEx1bk4vWVpn?=
 =?utf-8?B?dTBMTytrTitxQjVvWWZLdnhjWE1uVjhyYlcxc2hCOFQvUWY5b21WeC9rc0lh?=
 =?utf-8?B?VUdFZWk3eUdLcW1hZXZYNDZtWTNyUFFQNTJXNit3OHl2TXJnN1NxVGo1b00y?=
 =?utf-8?B?eENzZGczOURNN1ZuM0I1cUFZWTRQb3ZQcGgyTmttYWVQYlkraG1kZmF5dDd1?=
 =?utf-8?B?SlVNdDZxUjU0Ri9CUXNYTGgrVndqT0tXMkpzZmxtMi91Ymk1VnRrL05OTlVt?=
 =?utf-8?B?dWJIanFmQnFZY0lFZDhBcXBVTlA2MlFKR2k2ek05L3ZtT1NudlpkRVI5eCtY?=
 =?utf-8?B?QWVxM0l5czdGN25zNHYvTU55U3lRWFRQb3g1eGdHS2JkcER5ZW9KWUhxemlG?=
 =?utf-8?B?RXRFMzg3VUFLTTZoaFJmK3paVGZYaG9LdFNyVS8xQUJpN0Znd0pxM1FONGZL?=
 =?utf-8?B?YllyMENFR1BnMlY0eUJVSHYyUWxVc1NOUHNIR0c3U3gxVGovTmJBYVZlcFJF?=
 =?utf-8?B?NkNlZnVNaCtuL1o3MlczZU11blhaNWEvR2NKdGpORVVBc2ZKZ3FnR0hMckU2?=
 =?utf-8?B?NnFXcThCQlE0QWYyelI0RXhpU3NXb0FFNXRkNDZGTmZ2NkM4VkduS1lwUmFR?=
 =?utf-8?B?MklOMWxCZFFKMkxDZDlXSTdBWW45RGxIL2d4WHduZUVzMW9UN3hmWExXL080?=
 =?utf-8?B?TVZILzlHaVM1VVpHZmhFNmlEVnhZY3VhQWYxdXozQmZ5K0Z6cmIrU1ZaYWtX?=
 =?utf-8?B?RUtXTUFhMDl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUtRSklVc0xkZmREd1FUVUVRY0Z3YTV0d241M292aCs5WWQ4aVN0MjFWbk9q?=
 =?utf-8?B?Szc1ZkNKU1FoeVc3c01uOGYyMU41RjQ2TW9aNHcvYVh6dzhkWG1KbFN0SFFD?=
 =?utf-8?B?SFc1bDY3L1VYb0xKdExEMVFPUE9KVSs4UTY0OHhDZDFLT3hpdHJwNklWUDlR?=
 =?utf-8?B?QkxHM0VTNmxkbzR3UWcrZGpoL2hiWGR2aFJydTR3bkc5Y2JRYmNyVFJNR1NG?=
 =?utf-8?B?S2Z5TklVc2UwVVQydjdOVXJxalkxS2U2bnJoNGE1WFgzQ1VlMXhjaTY0MDJV?=
 =?utf-8?B?bFhJYTFaUkRSQW9iUk10WVROL09XT1hCYzFuWFRqdmhiODJabmoyQ0xzcGtp?=
 =?utf-8?B?NGpSUFNzQWFnYmVwY0tCdU9xK1VTbEtHOWdyYTg2dmJNWkV3UU5wbXNWNlQw?=
 =?utf-8?B?bGQ2clZUQWx6bXZnNlFiQ1JjbVFDMFkxZG40SmRHR2Y1ZldjSWZxTjBaV3pO?=
 =?utf-8?B?TDliR0dtRlBhOW5pWUxEKytMa1FqV3BwZko1ci90eldrU1BWSG1kblB5WS9W?=
 =?utf-8?B?Tm1jZHlJLzB5K1R1K1djdXVMWnN3SHUzQjZhakV2R2MyRTJ4UE5FQmlqYlNi?=
 =?utf-8?B?b1ZJUjNBT05PM3ZGNGtJU1JHaTlWTll6QTl6NExYWUJRMjR0OFJ6eWdLd3FW?=
 =?utf-8?B?a0s5VVRENmpna1NGb1BsTEJBSnpTN3dHUWt5TnNHMTRCSyt4QWJpMnVGek9n?=
 =?utf-8?B?cGVXWlJ5ZnU1VGZFMnlLVGZ2TmpRWFVzT25OWEFranlQVWRiKytVZ01UZjN2?=
 =?utf-8?B?STBnOWZwU21FS1hoYy8rSlZpdlJBNm4zRGJzTDNRbHFKa242S0JWd29vZkRp?=
 =?utf-8?B?QXdJZ0cwak5NbjRXODNWbjdiRHEycmVIR1FYcU1rczBxRWY0OUtBNXdRdllz?=
 =?utf-8?B?UDJhdGM1S1JucVprd2oxcVhob0JuRllET2h0K2dOZU1DaExsM0wvYmUrTVFU?=
 =?utf-8?B?Q3dnVW51RzYrRGtkTzNBTTBicFIvMnVlUE1HaDhMWU1XdkNhaEVQdDdlQzUw?=
 =?utf-8?B?UHMvSDgvRE9jRE5BR3V0dURid0czZlUzd1BDNmpQeVJrM0dQMUE2bEhwZWs3?=
 =?utf-8?B?T0ZnVEtIMU9Rbnk2b3c4RjdiZWt6Zmt4Sm9xSzhobkVKSGV1S09Wb0dWRSsv?=
 =?utf-8?B?YlNHN3JRNWJmQnAyNnlidGkzVWc3eFBpOUFIMlFJcGJkRDNmaDlzbHRFdk1n?=
 =?utf-8?B?dmJQVktOTTJNU0lHS1F0elBSMGFYelp4Y2RLUlZQYm81ald6bWhxbGFJWjJr?=
 =?utf-8?B?TkpRRGVDNkZ2OForay9jMHJXMFFZY3BWcCtOcXZrMXBnaTVOYXdHMUZ2R3M2?=
 =?utf-8?B?d0lpR0JMWEpKNjYzak1tM3o2bnBnT2UrV2tMSXp0ZkJ5c2dRaTR4U3kvOEM3?=
 =?utf-8?B?NFI3MFkzVUxTeXJUWW04VVlHd0w4NncxSEJzaGlxd2diYkJ4UklVak5HQ0No?=
 =?utf-8?B?UU5jRmNBSWEybnhadGlybkhDbzBqNFVrUVZRaEFGd1JlcVhaTGpKNC8zbTR4?=
 =?utf-8?B?YVExaGxnd244M0hCRUpEbk1iYXErdm1JZ3prUVpMU3NsUE9HVmREQ2d3dHIw?=
 =?utf-8?B?eGJLalNDNEJIY1lLU0MrcEMzSGh4Ni9wWlhKa0RjMFgyUTV1ZFI0YmZXZUZo?=
 =?utf-8?B?akNFS1FYbkd5dSt4MTRLRDQwZ1A4S05GTWdQWDhZMUhGL2tWcFpQWXBvNzc2?=
 =?utf-8?B?bVI1TnlRTGxhTFBhZG94dDR1NTc1UHhSU3dYR0V5OUM3QWhPellXY09yZHVI?=
 =?utf-8?B?Ni9UNWdCVTY1N2lDdHp5ZmZmWXRXVnh0RnVHVUJWTWZlNDZNYVpTOFV4UUVH?=
 =?utf-8?B?NmU5RUttelplSXJRb2VoeDFRaXFiNDV4SGlWeVRFSHV0bloyQmEySkx0anMv?=
 =?utf-8?B?MUlGSlkxdUVWNVJzQUM1NDJnMjBMdFhKbnlBYjROL1JlUjlMcWhLSWdqVzkw?=
 =?utf-8?B?RHh4anJXL0dZV1cyWE9oTXJ6Wnd6M21RRE4rbUpLdjBsUFhaZ2gwMWVSdXJ2?=
 =?utf-8?B?N0JEM1BXT0l6cE9WRWdnaXIzeVdxekFhb0VtcVgrWWNJRlJMMnpNdS9EVHEy?=
 =?utf-8?B?L2RhamJ4dDU3NUFwL2FEbCtpakdsc2w4a0NBZXRrZUNFdjZ6WDVmU0JwVXBs?=
 =?utf-8?B?bjBsaVE1V2l6Tno5QlZ3a2FtOEswWWgwa0ROMEZ3cXUrTk82a3NnMWxXcEEy?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32AC63E72769AD45A0A7F39C2B7DBDC0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7kQrXOStDyUGXEHN59VbMkYmF8D8WGV4ngPnqFTtvad9NBRjTpsq9Uh1ZGwn2+45g545Z9gfmLPm5qoEVfqj8pz1BxkM1qyAD/Ty+TFQskFu3Y4tmjslZVQ6RxcYzbuD/O9O56CpvHUS6dXvPPlknOxJHcS0BDc9Dq2RjH/Eoi0pCsKui1vQopsTSDXViOudqzrRlvpAumqi92T+bRQ7ZOLLmxJpxVIfo5Q1B8WnkYRTISDJLJ9n3Bf3YTtn5vrgbwjB1YcBWbSemMmVEJq/86qk1m460efbdIcjEzT+A+Ig3FEOv19afKfKsThkkkHG3OQqiax0IhnqM2odE7jQF9Znai+0xjiUG5N+ipFdTZa4wnUgUG3gz+rrOrGYPDnlj7VdjbO8bcDwGO345jNkWZQ/Y+zyrVI4cskYAyaNEmFIK1ifnq/c9deSrEsNp5llffvcq4O1OAJca6Khmsdacd8+aY+ymmpBxYmY6kxaYqmlT7FKCmXrZdrAlgnRXCjpFzpvfFimbG7+HFUl2XgZ+6sWpu1hYYHYLWBMlHhjrfpmXu27nHEDfHnMPGXeOuIqStlqCw6tG2dEjnBzfwr5YYPUKlK/WmfPSetxN26tDiziPORplmlaKwS8J+dgrFCR
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9272633c-67ec-47a2-9f4f-08dd5c4ab86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 01:03:34.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjrXmYLmmP4ETy5tUSZ0vSocFYIRug+Rqa2MFhWPJ0ZJgOsKBiQ6+6OcN3+BkQwdcYmLsfvA14/POzAhGTeBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5351

DQpwaW5nLi4uDQoNCg0KT24gMTUvMDEvMjAyNSAyMzowNiwgRGFuaWVsIEJvcmttYW5uIHdyb3Rl
Og0KPiBPbiAxLzE1LzI1IDI6NDcgQU0sIExpIFpoaWppYW4gd3JvdGU6DQo+PiBGaXhlcyBhbiBp
c3N1ZSB3aGVyZSBvdXQtb2YtdHJlZSBrc2VsZnRlc3QgYnVpbGRzIGZhaWwgd2hlbiBidWlsZGlu
Zw0KPj4gdGhlIEJQRiBhbmQgYnBmdG9vbHMgY29tcG9uZW50cy4gVGhlIGZhaWx1cmUgb2NjdXJz
IGJlY2F1c2UgdGhlIHRvcC1sZXZlbA0KPj4gTWFrZWZpbGUgcGFzc2VzIGEgcmVsYXRpdmUgc3Jj
dHJlZSBwYXRoIHRvIGl0cyBzdWItTWFrZWZpbGVzLCB3aGljaA0KPj4gbGVhZHMgdG8gZXJyb3Jz
IGluIGxvY2F0aW5nIG5lY2Vzc2FyeSBmaWxlcy4NCj4+DQo+PiBGb3IgZXhhbXBsZSwgdGhlIGZv
bGxvd2luZyBlcnJvciBpcyBlbmNvdW50ZXJlZDoNCj4+DQo+PiBgYGANCj4+ICQgbWFrZSBWPTEg
Tz0kYnVpbGQvIFRBUkdFVFM9aGlkIGtzZWxmdGVzdC1hbGwNCj4+IC4uLg0KPj4gbWFrZSAtQyAu
Li90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyBhbGwNCj4+IG1ha2VbNF06IEVudGVyaW5nIGRpcmVj
dG9yeSAnL3BhdGgvdG8vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlkJw0KPj4gbWFr
ZcKgIC1DIC9wYXRoL3RvL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzLy4uLy4uLy4uL3Rv
b2xzL2xpYi9icGYgT1VUUFVUPS9wYXRoL3RvL2xpbnV4L08va3NlbGZ0ZXN0L2hpZC90b29scy9i
dWlsZC9saWJicGYvIFwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFWFRSQV9DRkxBR1M9
Jy1nIC1PMCfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
REVTVERJUj0vcGF0aC90by9saW51eC9PL2tzZWxmdGVzdC9oaWQvdG9vbHMgcHJlZml4PSBhbGwg
aW5zdGFsbF9oZWFkZXJzDQo+PiBtYWtlWzVdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9wYXRoL3Rv
L2xpbnV4L3Rvb2xzL2xpYi9icGYnDQo+PiAuLi4NCj4+IG1ha2VbNV06IEVudGVyaW5nIGRpcmVj
dG9yeSAnL3BhdGgvdG8vbGludXgvdG9vbHMvYnBmL2JwZnRvb2wnDQo+PiBNYWtlZmlsZToxMjc6
IC4uL3Rvb2xzL2J1aWxkL01ha2VmaWxlLmZlYXR1cmU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rv
cnkNCj4+IG1ha2VbNV06ICoqKiBObyBydWxlIHRvIG1ha2UgdGFyZ2V0ICcuLi90b29scy9idWls
ZC9NYWtlZmlsZS5mZWF0dXJlJy7CoCBTdG9wLg0KPj4gYGBgDQo+Pg0KPj4gVG8gcmVzb2x2ZSB0
aGlzLCBvdmVycmlkZSB0aGUgc3JjdHJlZSBpbiB0aGUga3NlbGZ0ZXN0cydzIHRvcCBNYWtlZmls
ZQ0KPj4gd2hlbiBwZXJmb3JtaW5nIGFuIG91dC1vZi10cmVlIGJ1aWxkLiBUaGlzIGVuc3VyZXMg
dGhhdCBhbGwgc3ViLU1ha2VmaWxlcw0KPj4gaGF2ZSB0aGUgY29ycmVjdCBwYXRoIHRvIHRoZSBz
b3VyY2UgdHJlZSwgcHJldmVudGluZyBkaXJlY3RvcnkgcmVzb2x1dGlvbg0KPj4gZXJyb3JzLg0K
Pj4NCj4+IENjOiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiBU
ZXN0ZWQtYnk6IFF1ZW50aW4gTW9ubmV0IDxxbW9Aa2VybmVsLm9yZz4NCj4gDQo+IFsuLi5dDQo+
PiDCoCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9NYWtlZmlsZSB8IDggKysrKysrLS0NCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBT
aHVhaCwgd2FudCB0byBwaWNrIHRoaXMgdXAgZ2l2ZW4gaXRzIHRoZSB0b3AtbGV2ZWwgTWFrZWZp
bGUgb3Igd2FudCB1cyB0bw0KPiByb3V0ZSBpdCB2aWEgYnBmLW5leHQgd2l0aCB5b3VyIEFjaz8g
RndpdywgQlBGIENJIHdlbnQgdGhyb3VnaCBmaW5lLg==

