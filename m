Return-Path: <linux-kselftest+bounces-13695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBEF93012E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E3DB2256D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D20383B1;
	Fri, 12 Jul 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="B7Un8gQF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FBBE46;
	Fri, 12 Jul 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720814435; cv=fail; b=EOciWURWNG4YQA0THjEVrUjWJ7w8hr+WHMVEhVcuwJkEp087XTuujrUdRrKtNotyU0ldjMnrM7GrvmXChJBlAEKpiCoXARaMYzyORABWjeuocmSaOfgXRFECahVujQWNCSnpbgxdwSAkax0BRzdt/1CX6XrT04GiChx/Rm/L+nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720814435; c=relaxed/simple;
	bh=0HmoPTHc9HOVQLiQJGvFNXW2jJoIYvthT4eAfKZ6rZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaDLzC7dnxZ0lHJHnB5uVdYwVmwRayJ/oxPIdZfcxrv0FR+KrBN1OZ5OhqUleY5VAG6w2ynzYebPP9QM1svyVii2HQjOII+nRJituap2COLEed6u3dwL9cqPUtt4JUIu39LUl9pMUVhRJKNNLu6lw2VpqviVvFldqqfwl3VzE9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=B7Un8gQF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 46CK0Vce030176;
	Fri, 12 Jul 2024 13:00:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=0HmoPTHc9HOVQLiQJGvFNXW2jJoIYvthT4eAfKZ6rZI
	=; b=B7Un8gQFqG69w0it4eyXl4dQVXusDRXCREUgPKhanLrAD6Y9FQE20uU1oSe
	efjip2yTbXtQegutBaPF/VyF2xgdhPaLfc+sDL4g5t3yKE8PYITMrQNtmYUttmzc
	cqgYCItzO0aH/9lgVnXEVN2wzH1pQ5NpJl0V/UFzMzk+USdy+xKnmNusIuYDOV6d
	1MOuB9KfJQzH2Z47g6sNYiyzhEDytkng/47AXN4IPu7HOKZA3O9/MLOaHaTTLB3j
	zxwGUeuDdMg6PoXDAnV2+5odbH/DJlXWx85rXbGfXeeu0tbL/JwDS+Az2Xm/OrBn
	iLMnjxO4xB/kK+zVaMih9azAqlw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by m0001303.ppops.net (PPS) with ESMTPS id 40arfant1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 13:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLz4cGS1FiagXGWU2EwzAF6IUeKMmA3Sg6JCO6rKN2rA369bOOLR8wuP8l1E6DAw69d/lfEM3qh+DCZdTOWuVCzVku17GysayM+Fk8/rQezEEpoM4AmrWGU6kb0rXyQ5fPm2vQmDDlGogMwrqckN9x/WwiD53gmm89+YbqxBU8WZCmK/bRmIoGgbAowfVp9D4mUTZ5I/ldAjtqj035YAOahNlC2xtJ0DV6TGgM1vymsmTsqg5xO7T/BqIOPtWGo5vzmTHhLWxY4AwtTE9vbKWqQ0B/hHUh4+Tv9UDgd7eRaYa8O7c5fKyo8UcIYRuJjX8WMWODGiG3tU17FfzF7pSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HmoPTHc9HOVQLiQJGvFNXW2jJoIYvthT4eAfKZ6rZI=;
 b=Xq8MN2wsRjFhD5vWaLAtUAIL7T41MuoPkm6l67PfUz1T6pY/WtWHCRnv3aEWPmzewrB8AyGqAolw5F3qh8nnABm/c2IYaNyiB8JN8V2K4cVIH5UK4ufdtA7K13rTa8iOUci9LzepUQC3Rq6n6jzbrwj1fWCOZlEF7rj3296hpM4kfT+9xpwdvcBMZ0LWPTT81gYFc874A74zKe2AAHMZwUZ8sfRvK1mtPmzWV1tMwm3CFI6JYjYAd6pObzJVyGjdT9NHoMpbgMMG57nbhIrmgUNmN2puhl85i7Xe3OBfPFoZrYODHNP6ZI9q5lmzn2vT/VWQ05gQnGoW5l4ZhgVRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by SJ0PR15MB4711.namprd15.prod.outlook.com (2603:10b6:a03:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 19:59:47 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 19:59:47 +0000
From: Manu Bretelle <chantra@meta.com>
To: Puranjay Mohan <puranjay12@gmail.com>
CC: Puranjay Mohan <puranjay@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko
	<mykolal@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Florent Revest <revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
Thread-Topic: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
Thread-Index: 
 AQHazuq1+2PUFsFL2EKpG1WqJaaiDrHs7xQAgAACPYCAAAdNgIAAALQAgAABvgCAAAmFAIAACTyAgAGjroCAABOmjIAC0mEAgAHLvzOAAAvYgIAAHeOA
Date: Fri, 12 Jul 2024 19:59:47 +0000
Message-ID: <BF0DCCB8-EB5D-433D-87C0-3FA82E2C09EC@meta.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org>
 <SJ0PR15MB4615BF10FDB6D4577AC84D87CBA62@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <CANk7y0gYSix9fVUC1Q+DLqu8UFaJgFbxCF+_zAzjMCyFzzM4uA@mail.gmail.com>
In-Reply-To: 
 <CANk7y0gYSix9fVUC1Q+DLqu8UFaJgFbxCF+_zAzjMCyFzzM4uA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|SJ0PR15MB4711:EE_
x-ms-office365-filtering-correlation-id: 68720dd8-2be8-4b50-a065-08dca2ad2eb0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K01JZ0VCQWNpcGlmc1NtV05vZ3p2a2gxaVRvYUpYNmFMeFRCSm1PYmhmVC85?=
 =?utf-8?B?TURUSkRIVWZDSDZ0YmFFQVdKempuRmVmcVpxRGtlVlppWWo2cUx1L05teFJ0?=
 =?utf-8?B?TWxlZ2tzU0wxSlpsUnEyV3J0dy9CSWJuT2JVVDVScVMyeFNCOHExMzBZTnc0?=
 =?utf-8?B?K21PTzFFQlltTmpnbExPQ2packpjbXY1MlpBdU84ZW1XVWV5Mis0WENXY1Bu?=
 =?utf-8?B?djUzeTc0ZFJEUCtiS3VvZWVhYmdkU0FPUkt2ZXRMOEJocEdBa2YwVE5RbDVI?=
 =?utf-8?B?M1pLNzA4R2VNRlBYK0xQYkVqWkp3bnFhb1BacHU5SUZEYTFYNTZsZUFEVk44?=
 =?utf-8?B?R2gzTlUybHVZSkJOby8vMTN3OGJ0UXA3Sm1idE90NG1kYzJhV0UyQWs5eFlB?=
 =?utf-8?B?QVdaVVVNQkNHVjV1blJIajVidGtKT1JmVklwOXZ0QVlKcDlGVFhFcW1wQmdT?=
 =?utf-8?B?VTI0TmV5WlZiWmVEa0wyY0VjU1RNcS9wTDdEMzlqeUVlVVl6dlJBTTduQWp4?=
 =?utf-8?B?QXZLWnhVZFpKaXlEU3V4Y0V2eEtPTHRveVFzMWZzc3pUd24zNXFTTlROYkt1?=
 =?utf-8?B?SXI2UnBuZExJN0FjcEU1NkxTM1pPZFg1OGpKSDA4eVloWGRGVVlSeFV0VjNM?=
 =?utf-8?B?QStOSzh4Q3NpVzJSaEdpMXZKWE1tNDJMckhyYjFoMHdDK2U3elloNjZQdWs4?=
 =?utf-8?B?R1ZzQnRWcy85SE10QUFia25LY2E5NXV6Rnl5SUR6OUVWc3BXTisxUldBOG16?=
 =?utf-8?B?N0J5NTMzWm1hbmJNU1RkcG5lUG1MZ3k0bEZ5RFZvSjVLQk5LY3BGWjRodGQx?=
 =?utf-8?B?K0xjYytSVXVrOHBsUnFmRzY0bEl3NEZySE9SenRTOCtuRDBrMUR2NUlxM2Fl?=
 =?utf-8?B?aGEzV0RmaHhqTjNFS2hvcU5MMVo0d0RFREtlQW9VYnA3VllDOHR4NlJRR0hp?=
 =?utf-8?B?bitrdFJYbCtmWkJHOTNrUnlheEFJT3FmK0didmlHdURuTnhtNHdlYXBsTG5y?=
 =?utf-8?B?K0Jzc2t5NC8zNUduQXlreFhNd0U4UDRBNDdKOWlpUUdBRCtiWEhsbXZWRW5r?=
 =?utf-8?B?eGUza0VTbG9ZSytxZ0xFd2FoL2lBeVZZRXVjZzNWQTVCZU5hV0FkNDJUWE1r?=
 =?utf-8?B?T01SMjlOL2lMcFgxOFZXRnBpUnkrTWZRKzhNWXo0VkJ6TlFQdmM1cStCRDNO?=
 =?utf-8?B?L0llRno2QzVYWmUzcWgzdlFsTlNyL0dEUEVNdXRRcXF6WGFOdG9zbWFrS0ha?=
 =?utf-8?B?aFVGY0JwQUo1OU9iTmhkSUVWTUVEVjNkaVY4aU50TzZuTjZRb3N4aUgzdmJz?=
 =?utf-8?B?bmN2NGJLemE2QmpXb0dkeXhTZnlRb2xKK1hNVWppVmZpd1J3cWhyajlHWFg3?=
 =?utf-8?B?cEJReU9yNWg4eWZMRFN0ZE4vSXovVWRsZ3YvNUNaM01Nd3lrai9FRjFXaVJ1?=
 =?utf-8?B?WC9kV2NKd1E1MzZaQVcwODNPbGJScDZ5c0t4Qk9KdzMyQnlKQmdHSVRuMWkx?=
 =?utf-8?B?d3RLaUx4Vlk5SEMxSFhlRFJEMVJsL2c2andTVnRQVG1YdjF6dHhmNmRGTW05?=
 =?utf-8?B?S1o5K29VTHRVZW0vN1BIMG0rWHdvLzViaGs0VDYrNDg4Z1ZGaWFUZ1AvTWt1?=
 =?utf-8?B?RmRqL00zRnVxWGI3UTE1K3FTdzFwb2VSVG1IMzVUbERrMkczVmpBZGlZdU5I?=
 =?utf-8?B?M3FBVmZvTC9MYVEzTSsvdVhCR1JwZ0E5bHRSUEw1bVBCaHRhNVQ1S2hnUGdw?=
 =?utf-8?B?TGtoUHQ4TkxwdXM0WXBhR29rblJGTEJlR1FUVnV0OEtMRXhVYUFFWmhqOVlG?=
 =?utf-8?B?SHFnRmdSTUkxUUFRQUd3N3ZjeUU2cmZLWWpkSG9IQXVFb1JXWmU4ZSs2bFEx?=
 =?utf-8?B?NG8zMjlXZVI5N1Z2dDVwbVlrSWp3cmo2QnpBRTNoSmJnSFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bElJVFJCY0NLUEg2blJORnpOM0ZaMGtQZ29raFgrV25FR1RCWll1WC9TVmdy?=
 =?utf-8?B?Tk1JSlczbDI0K3hWVjRlNGlIdGZFU2ZSN0lvcEZ1dXhoTUttSFN2UmpHU1di?=
 =?utf-8?B?am9JUEJqaGpJcGh1NGpsZWNQWVNTOXZBcmxabVB4a1ZlM2xqQ1NYeXdKa296?=
 =?utf-8?B?ODhrdUJEcW1CYlh6SWdLUm9lVHRsYmlWc3kvSGsvNzYraGdXWDVnaW02b3RH?=
 =?utf-8?B?MXlNaTcwSUZ3cDEybnVCWldOUlcxekZkY2VsZ01veDRzRDFML0V6cWJEM3R6?=
 =?utf-8?B?aXJWU2hYelhLOS9CYWZLMVlnNldXYWkvTndTUFBmczJiMEVScWdhT01vMnU1?=
 =?utf-8?B?dFZVV3p2WG82ZHZFdVZ0OFJpUVZVUzdacksxekJ4akZEQTZuSi9NUkI1TEVt?=
 =?utf-8?B?OS96ZkFzdUVEdG5NUE1VMUdVcHRqRFdQbVNVSldMaDJjUUdLL1h2UEJSazlQ?=
 =?utf-8?B?cTloREFuQWhtMDI2WEpxcGd0OGpqRXF0eU1OejVLSk5VeEpVZWhhazFWbUhU?=
 =?utf-8?B?OWlyZEo2M1BGTlBLb3ZJTzJ6MElNNE1xZXl0Z2k1NFV2L0VEeHV4RTVVV2Mz?=
 =?utf-8?B?c1FLelQwZDd2NEpwMWEvMXdQeVJQMTIrbFNLVkZ1STdmaEVFZy9ZUXNCeWQz?=
 =?utf-8?B?bHpmU1JtdnVDNkhYN0gxYnFyTGhQU2pGbi8zWlZ0R2l5ejUwcmVDazludVVL?=
 =?utf-8?B?cXg5cjNxc0l0NFd1ZWxvR0JpaDZwRXQrZjJyaVI3ZE1Fd3huQ3JzS3pGOXpO?=
 =?utf-8?B?NC9Fd2VuaHl6K3ZQUmJFNUJNYUVIWHZoUExCc2FGbGdBS2lPOVFXV2lkd0Ja?=
 =?utf-8?B?UVh5TjlxMHpyYTZQbFo5eDZLS2piRnVJeWU2bjZlYVpMZDV1bjBnTE9sRm9X?=
 =?utf-8?B?L0ZaNGRZYUFMWURFQVY0Tk53MllkUFY3U20ySEhvYVZNMVdsVHk5a2dnWldH?=
 =?utf-8?B?Y3ovWm5WUVA3bVZSdks1QWtQOUhDU0NQSmgyODg2aDUwMGZKWVlSK2czWnk0?=
 =?utf-8?B?TnJvNjBBdDVOdHVzMXlVNldTYnE1RkVpWXZDMDVVTHpjVTNiWnczTTlDWU5O?=
 =?utf-8?B?Sm5PK1h4WHpJK2hCdXMvcjRsRGJNeUhHMWY4eVFFS0tTV3FPbmc5MW5zVUhl?=
 =?utf-8?B?THVoYS9wOElkM0ZRUGxoMUNmaGs5Wmh0NWN6RUZrUitJa25NQUFYL0E2REMr?=
 =?utf-8?B?U0dkUDNlYzQ0UTd4SHQ1cHRxZ0FlK1p0bHREWlo5Y252WFF0Ujg1RW10aElq?=
 =?utf-8?B?VHVKdnRNQjVFd0NhMElLTHd2UDZjTytPOXQvVVY1VDRMMzVXRjMraUtwbFRq?=
 =?utf-8?B?ZFlnM01iMmgrUDZhc2lSRmEwaENDTFdYTUJHRFFFV2RYb2hyWXU2NGU0aEpJ?=
 =?utf-8?B?NlBzTW8weTBvZ0p1ZnpWYzFvVzZia0JBSmZKRWtYcWVaZFBMQ3hoVzNHZlVs?=
 =?utf-8?B?OENzY3l5bDdRYjR0aU1TanB4aU1ZWmVGN0VHV2JQY2NnS2pCKzF1NUhNQnBz?=
 =?utf-8?B?dk1laE9BM1ZXZ3Uvd2pNaG1BTlZaQXNWeE8rcTU5QTJnMzAyMDZOSnZhOEcz?=
 =?utf-8?B?TFB1U3NBL2t3RXdOTmYzWEVSSW9JMWdVYzNjM3BPMTdmNDg0S1ltbEdrNFpQ?=
 =?utf-8?B?ZVcxSVRla2lPT3ZMUlJWQ2RLbnJuc2ZTRHhlMDd6YTlvV3JBMndWU0hIRWRD?=
 =?utf-8?B?Wk9CM2Z6RTFVZHluVnFEUTBDK216RThDTjhESlZORk16OCtiOXBRa3JBbloz?=
 =?utf-8?B?YnR5cWlydUJlV2l2OU9QLzdRb1l4TFViUUJYWGVsYVM1QlZSd2JQb3FsamFS?=
 =?utf-8?B?L3BVSWNBWEdZN0FSV3lYby9CYTI3VTZmZ0JUbnZSMi93dmIxZG9GK1E2OFpX?=
 =?utf-8?B?cWpOVmtpbkFuVm5zVVBleXM1T2ZsQjlMQXRwNlBxZE11QVhMcitXbXhqenl3?=
 =?utf-8?B?clAyYlhRa2lWQmhkTjV5K3BaaE1TcThHdkJHTnNLcy9YQWFIS1QzRFp5eWZs?=
 =?utf-8?B?RmF4MnM3Tk1MWmF1dk9oaXZSSWNaWVFqaUNzNGdJS2N0N2k5OS9SczJXdFNR?=
 =?utf-8?B?YnMxd0d1TkxiT25zNXRxTmdwbDRmaVd1WUxMRUxFUm9FRmtMYXZKSmpDekRa?=
 =?utf-8?B?UVdUejA3Y2R1eDJFSWNpS2JzZ2VncDE3WS9TUEJlMC83dkJqQ1BCRHljaEQy?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4BEE73CF42AD941A0259C1647B67F06@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68720dd8-2be8-4b50-a065-08dca2ad2eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 19:59:47.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZGMNF8AL+iu0FSIr+aPChJ5DDFEqhTJ3l1WKyrV43MlOzlTjjf2jIbmLFLdn+bDuLzngTURuZcvz8R2ARDZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4711
X-Proofpoint-GUID: icCyCqLbekPrMKhc5HGSwpxS-Y8NExrB
X-Proofpoint-ORIG-GUID: icCyCqLbekPrMKhc5HGSwpxS-Y8NExrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01

DQoNCj4gT24gSnVsIDEyLCAyMDI0LCBhdCAxMTowOOKAr0FNLCBQdXJhbmpheSBNb2hhbiA8cHVy
YW5qYXkxMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gVGhhbmtzIGZvciB0ZXN0aW5nIHRoZSBm
aXguDQo+IA0KPiBUaGlzIGJ1ZyBoYXMgYmVlbiByZXNvbHZlZCBub3cgYnV0IHRoZSB0ZXN0IHN0
aWxsIGhhbmdzIHNvbWV0aW1lcy4NCj4gVW5mb3J0dW5hdGVseSwgSSBhbSBub3QgYWJsZSB0byBy
ZXByb2R1Y2UgdGhpcyBoYW5nDQo+IHVzaW5nIHZtdGVzdC4NCg0KSSBoYXZlIG5vdCBhYmxlIHRv
IHJlcHJvZHVjZSB0aGUgb3JpZ2luYWwgZXJyb3IgZWl0aGVyLiBJIHdpbGwgdHJ5IHRvIHJlcHJv
ZHVjZSBvbiB0aGUgYWN0dWFsIENJIGhvc3QgbmV4dCB3ZWVrICh3aGljaCBhcmUgbmF0aXZlIGFy
bTY0IGhvc3QgY29tcGFyZWQgdG8gbXkgbG9jYWwgc2V0dXAgd2hpY2ggdXNlcyBmdWxsIGVtdWxh
dGlvbikuDQoNCj4gQ2FuIHlvdSBleHRyYWN0IHNvbWUgbG9ncyBmcm9tIHRoZSBDSSBzb21laG93
Pz8gSWYgaXQgaXMNCj4gaGFuZ2luZyBpbiB0aGUga2VybmVsIHRoZXJlIHNob3VsZCBiZSBzb21l
DQo+IHNvZnQgbG9ja3VwIG9yIFJDVSBsb2NrdXAgcmVsYXRlZCBtZXNzYWdlcy4NCg0KSSB0aGlu
ayBvbmNlIHdlIGV4ZWN1dGUgdGhlIHRlc3QsIHZtdGVzdCBkb2VzIG5vdCB0cmFjayB0aGUgY29u
c29sZSBsb2dzIGFueW1vcmUsIHNvIHdlIHdvbuKAmXQgc2VlIHRob3NlLiBUaGF0IHNob3VsZCBi
ZSBmaXhhYmxlLCBidXQgZm9yIG5vdywgSSB3b27igJl0IGJlIGFibGUgdG8gZ2V0IG1vcmUgbG9n
cyB0aGFuIHlvdSBnZXQgZnJvbSB0aGUgVUkgY3VycmVudGx5Lg0KPiANCj4gSSB3YXMgdGFsa2lu
ZyBhYm91dCB0aGlzIHdpdGggS3VtYXIgYW5kIHdlIHRoaW5rIHRoYXQgdGhpcyB0ZXN0IGlzDQo+
IGhhbmdpbmcgaW4gdGhlIHVzZXJzcGFjZSBpbiB0aGUgZm9sbG93aW5nIGxvb3A6DQo+IA0KPiB3
aGlsZSAoUkVBRF9PTkNFKGZleGl0X3NrZWwtPmJzcy0+ZmVudHJ5X2NudCkgIT0gMik7DQo+IA0K
PiBDb3VsZCBpdCBiZSB0aGF0IGZlbnRyeV9jbnQgaXMgPiAyIHNvbWVob3cgYmVmb3JlIHdlIHJl
YWNoIHRoaXM/PyBUaGlzDQo+IGlzIG9ubHkgYSByYW5kb20gZ3Vlc3MgdGhvdWdoLg0KPiANCg0K
DQpNYW51DQoNCg==

