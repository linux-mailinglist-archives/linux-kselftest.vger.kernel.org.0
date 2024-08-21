Return-Path: <linux-kselftest+bounces-15919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6FD95A5D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 22:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72A0284646
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CDC170828;
	Wed, 21 Aug 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i3dQzcIS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6F1D131A;
	Wed, 21 Aug 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272103; cv=fail; b=LlL3SiW7hcA6b8b5oB4c4uEShwmfYcq7fzWryOVXDsP+6eQoEXKBAiZkcFu0OESW0ubmhIQoZoZIQe7eHqcb0mR8mGK2JS93SAwq42AnmR3O6tsdQMS9MD5sDHb8mW3NBy73FbQ7COQ3V9JFc6dGi05+iPMUpdhYpsiclF/lL50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272103; c=relaxed/simple;
	bh=gmqODeTmAl9nNwnnwvuu6ic8TIsrP+tXwqH21do8SbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hAxMg9AJI/LVHqWL7p5Cc4Rh+k6K34FF2doC4BC5psf9WWfHNW0e9ZDTVVfXJKjzDAMC87n47zNRi+5eqxLHyf87WUo/mNkSI48mW3Ir+ou7tJNLYiOAzHTBTl1ws5s8YtCNuc59iS78nwAmZXORn1rcfiipu7OBR7cG04KU9kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i3dQzcIS; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LKLnKx027599;
	Wed, 21 Aug 2024 13:28:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding:content-id;
	 s=s2048-2021-q4; bh=HmV3Wr0jCWJxGfZwFxC6FkEC7aL0oyRZ2UZdsd1ZDI8
	=; b=i3dQzcISB63ew0CY+x5GcPRqlFSF5JaBzaybnH5mZR4dIyv4mYCEKaLxaoP
	QmEaQqB+VUGIj83M6LMpkaAhbuRh5ubFD3VZvBCUF4WYw8BUv1W9uQ5/3FCbtD0T
	mYnyJgTwHYZSWC+Vo+ettbu/kkTEQsO6TfmpLeTHo4GTe3Ek6OmoSycKp+XYjKYG
	hbjahONdSfrhIbOJPb/qGEVAhg+6QxNXzTdv/BVia/xcbe8r9d0KtHjlbqiym9Qp
	ZfiJZtVEMYCzvr40h9nNfRfbcHCM0pwpkD5mSB5tDOAO9hl9B4/W+6mBl51E+jUQ
	ipKH9a4F/lb+Z6b7oNkyo7zoMpg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 415dfpuxyk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 13:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmACaFA5LD7ldlzSka0KXqmWAkYFpO5qPaRvWNW/Luf97SUPHwq12c4tRLVfBquVMj4puvK4CzQkn/cjUES1zYvWf8twxX26LGCTOrDdwUkTu/lh83J+58QP7Zk2AoHc6tix+qmS1AtKgGSaX1jj9PJzfZseXuSx82Agh2QmFwi8PrZuVMSN3b1cN08Bc9ZBgUjRdHPd1K30tn9nsyEae6OiyMUSVcsFV6r0szV5NrriccImRMPaxr3bxwaXq4s2WHzL+HWEeN09wi+3F7xtLv7z3EhXKJT+99ZoDEJCKPO4+fMgqzAHuiYZsFICwnp0/6sX5LybTq5Umb0EBprMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPG/oEATsxuQRSxhlorwrXDXB09KcSMupFV1XbFdl8M=;
 b=uPr9FRo89MR0MK6zIu+mXoZOd+P5chX3clQAz9PVDFuhAaYIxLZoeH9e0lMxjtm9As3Goo/jLvq7y0IWRXx7Y6BVLnwZheTihvkLxLqipLwp+7kMS/QkQt5bU2oPJzh70TjZ1cd5l3BwFMLrGV9IVT0vv+ncr2DocUBceXxOoJI1iHPdu9Hdv30C/9H9XbPU2ctCWYT8UyfZvlVChM4yOXw9Rf31/hAzpBqGOwCFqur9uXMIEmmPyruvBDCMC+hQIWSNRZg0dWoY+68ly5+6NXQL0D85Jume2zEEq/4isajd9l/fgYa+WOvvanIAXUQJs/IUmpOkcTuBUvpqIn9B5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by SJ0PR15MB5823.namprd15.prod.outlook.com (2603:10b6:a03:4e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 20:28:16 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 20:28:16 +0000
From: Manu Bretelle <chantra@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthieu Baerts
	<matttbe@kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
        Mat Martineau
	<martineau@kernel.org>,
        Geliang Tang <geliang@kernel.org>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko
	<mykolal@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
	<john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Geliang
 Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
Thread-Topic: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
Thread-Index: AQHaoiihMJnNsDQVCEq70rk5JAhxYrGPOfIAgAFIGQD//+LlAICiZ/4A
Date: Wed, 21 Aug 2024 20:28:16 +0000
Message-ID: <6E4DB2E4-8143-44BE-B146-B63630533B50@meta.com>
References:
 <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
 <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-2-4048c2948665@kernel.org>
 <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org>
 <CAADnVQ+Tp8+Hhy__=uevSZsEetsWYommjhC9SqSfKEeBu51cKA@mail.gmail.com>
 <3BFB4741-22F2-4CBC-8FB4-9988DEE7E25A@meta.com>
In-Reply-To: <3BFB4741-22F2-4CBC-8FB4-9988DEE7E25A@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|SJ0PR15MB5823:EE_
x-ms-office365-filtering-correlation-id: 4d7a42ca-ed23-4cdc-b376-08dcc21fc9b0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1hVZEZjYi9sTFJDR0dOTkZmRHFwR3NTSlkyUE8rVHNuWW0zYmoxSmZwNFJy?=
 =?utf-8?B?Z0ZtL1IrdUVvZWtkNXlEaHdJc2QxemdpRm90K0tMaWxEeHAzVGxwbng0TmRC?=
 =?utf-8?B?bFkwSlVrVjk1UlJPZjhyVWZLTVVUWHA1dGI3T0sxTEhDbWZVaVhZQUZhTENX?=
 =?utf-8?B?b1N4a2hkZVBZdXFWVm0wVXloN2xzRUYyNlgrNXJFYWo5ZjN2TUp6dU1hTjRL?=
 =?utf-8?B?NUNFWjJieWU3Qk5EYk5DR2tTR0lVR2pCNG44bkJVR2hKbGxnWmdwR0t5LzU4?=
 =?utf-8?B?UDBQOWQybjA3czYyT2pIWVlQRzluTEtiUy90NzY0bHNESDMyYkJhS0RPdkxJ?=
 =?utf-8?B?SE5mUFM0bWFxS0Q5elZRZ1c4QXk4RFdYamU4dWtyaVl5Z0JhOTExMjdhU0Yz?=
 =?utf-8?B?K0JGZGo0NFJEcVRUQzBKb2tUSFpOdkRjZlhKYXo2dkpXTFduTldHL0xJcUhY?=
 =?utf-8?B?WjNLUjVCV1o4Zm0yUVNSMFhGVjdIWjVWbjVGNkxvTlZ0YkduTEt1TkpuclRG?=
 =?utf-8?B?THBjbVphcHZEVjAyWFdpbERha0RHb0xrYStnYmp2SVRBUVhIcUxYdXNRQnBJ?=
 =?utf-8?B?WEpPQ3pueldTT244ZFExTEpzbmJVRWlod0FmdkcrOUZEREY3RkdqQ25QU01J?=
 =?utf-8?B?MDUxQk1oaTlIb3NaTW9JZVI5L1MxR01ueFZPUUZ1cU00Rkhidk1raDVzMzVD?=
 =?utf-8?B?R0RIYUZ4c1RkQUpLS0tQNG5JWVk1M3I0UDRVc1ovbXQydmFLMW1GVys3NFlT?=
 =?utf-8?B?NVN5Z0lNd3ZuTWttRHlkL0FSVUVGZzBLb2NsQmZDcmRmdktqdEtLN3R4RUR1?=
 =?utf-8?B?UWgzYWVpRkE5N3lUVW5IT0ZRZlRqOHFrbm1JM1FXQkNwU3hDc1JTY2luc3Fr?=
 =?utf-8?B?SGRWQThCcm1GejEyWjVIV1pjbm1nS3dJU0RuTU5XOXFZTjF2ODFQUXBmY1ZW?=
 =?utf-8?B?a3NvbEk4c2NWME4xeFR4Yi9sL2RvaWxtdVBudkQ4Z3owSS9CR1FpMVE3aXQr?=
 =?utf-8?B?WmxTTzhWSXkrYXk5bnpJQUxnR2JWdVhGZGxvUUlENUlvRjRNK0hrTTE3UDAx?=
 =?utf-8?B?Y1JLcEcxb0VTeGVrOXkrMTNuQUJZNW5sS3NnMEl4MWhOZDN4YklhbEhscGlz?=
 =?utf-8?B?ZlZXRXRBOUozZUJudXFJb2Q0UVJPODA2Q01HdFJEUzE4UE5XZDNiZ2IrK1Er?=
 =?utf-8?B?WkRuL2R3dHpIdmdJM0cwd05iNGRKSzBjNEdJTi9yQU82akUzRXJBZmZlZkk3?=
 =?utf-8?B?SUJjT0RDV2JKYmNQTHpnTzY2OFUxZEtveUlpQldJZG9QbWZwalJjU0lwWHd5?=
 =?utf-8?B?ZStwc3U4dW1oWU5YVmo5NFFuOTI2ejI3ZUhvTHhXQjcweDhoV0lJMWkyUlVQ?=
 =?utf-8?B?TVdCem8veTRYaGU3NnVXSk5FUWUyTkNUcFZDOEdCaWFXSkJESGJLdVRGTEpM?=
 =?utf-8?B?Q2RCTjdxbWlBcitJNFEwUkc2U3RvMUhOWXR0dlBVT2MxdStydk1XNGFXZEhO?=
 =?utf-8?B?SzhEVkxhRjBmTU5lWk51SmREZ3RWOW9MWEE4aFRJYTAyNm02bndhZUlNcjJO?=
 =?utf-8?B?VVBvc2hkM0NYbEpzSjhoYW5pMnZTZ2FFUjdsQWtyV3RzQ1l4YXFEQ0NpZE9R?=
 =?utf-8?B?QW9FTnZ1SVhZZWk5c251RFBaOFVtNjhUQ241QmtUeThCNTNVaWJCVXhZYmNx?=
 =?utf-8?B?U3FJNDVDSGRveXlSaFo4SmFVbTdBdzRDdVJ6ZDZzZjc1WVJyMm5ITkFxbWNs?=
 =?utf-8?B?NEppS2xYbTNmZVc0TWdvVHVEWkQ0ekJjQzVrcTdMcDFYQkNNMWpVcDZ4Q2Ux?=
 =?utf-8?Q?PmoqqQCtFr3wi//8PDaTLJQELWzZ8/wVsx5Dw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDU2YmVtQWFuQzI5VDJXZnFOTGw1aGhhYk94SGdydExoZko0U0ZQTDljSFo3?=
 =?utf-8?B?eWNYZk1HbUV2b3ErRzVabUxBNjdLUnhKVi9yVnVuTkRpeHpVRzZCRXhGYXor?=
 =?utf-8?B?MHJQcVR1KzlBVE5Ld2RWOER3dzdER3JYeHlHMmlobmZqcGN2ZEozcVVlVytH?=
 =?utf-8?B?WkZpRHZTVDZtUm1EdHpHZENaUVd2NE5TV3JSYTBGK2pkTVVjd21Sd05iT21o?=
 =?utf-8?B?Nkp3Q2tpQVA5Y1B0UTdyL0F2Y0hwbjkzYVBXZXlDUENONlBwSjJvRnB0eExw?=
 =?utf-8?B?eEtFWmZhRHNMQ1lHeE9YTGJvY0tHd0VaOUp3bkVKTEZ1OFE0bUdJMmsvam16?=
 =?utf-8?B?Mk41aGVoSEhBZmlFZll4Mnl6eXducHdldEg2SmtjN3NxeUQzdVQxek9xVW4v?=
 =?utf-8?B?MmVNY2E1UDhmWVRmbzJ0TzJ0VEdLUjc5UHIwWVFOYW45bitYMUFIdXhMdjE3?=
 =?utf-8?B?Y0FSeE5pYVlMU2ZMMm9CZ3hFVFltcnUvQVUzQWtkemg5V1RjOTBDUWVZcE85?=
 =?utf-8?B?SHJwV2wwdGg1WGhhVmZoYk91d0xwbjVHZE5lMWdNNFV3VXFVNG8zWTlMT3o5?=
 =?utf-8?B?Q0VnMUVlUGZHclNEazZkUklwYkVmY09wVjlNdGpsdWk2eFd5bGlVQU4wTkJi?=
 =?utf-8?B?cks3WUdjU3FTS3VqWFpGbVJTb1hGTGhNaExhQklCckVJck1uV1Q4anQxVDhj?=
 =?utf-8?B?RENZWHZaSXRUckd1azZyVzVqSkVtV0pFSll2Wk1yNTh6Y2lLSmJwKzA3R3h4?=
 =?utf-8?B?d2luUHV4ay91WUJ6UkNSUlNZT2RtcGNPRTlyQUFqTDIyaXZsdjNWaURrTmRm?=
 =?utf-8?B?SERHc2tQWHI4RnZDQjRSRFdQa3dVdGVEZFdDbmxaSXN0K24weG92eTNkYzFn?=
 =?utf-8?B?L1FvZWVJOVFhVG5idGNnTGZ6TnQvUFN1ODBIaWk1S1Y2dWtvZ09QOThzb3h2?=
 =?utf-8?B?M2drNHVUcER2amtXbitvdTl5MFdPZDdpRkdncVNnZm1FNUNYZWZ0L2Y5OEUw?=
 =?utf-8?B?WGc2eWtCcDBaK210dTFXR0s4MEUyaC9jZlBlN2xZM25obmJ2WFZzSjRqTkZM?=
 =?utf-8?B?bThkYVN6U01LTkxCWDIxK2dPSXpXdktyNkg1MlFHS3ptWERuVjFabkV6OXlq?=
 =?utf-8?B?L3Y1ZGw1cjJqUUw1RytVTll4ckN2aFNVRzhUSkt5SEd4SlRIOTBwT2JESHJQ?=
 =?utf-8?B?NDRpTngvNkFGZDJuTlpZR2lhWlZ3RnMwcVN6ZkRXaEFBU29GdmgwOHRnU1BM?=
 =?utf-8?B?UHpWeGRwdzNhVW1wSXpWbTJPWVpKcUxlWnJGeGVyU0NNMEhkaWNJTEgwT1RK?=
 =?utf-8?B?NVR5c0ZIM2hsRzBSbWsvREJZWkhxVXd4a2VNRExHT0RjKzZVU2dKL3VyQ3Fx?=
 =?utf-8?B?MkRoTkNXSFUrbktCT0taQm1OVlh6UkNpYVVYdmsxemtMS215RElLSkVVVnNk?=
 =?utf-8?B?TWxjZmxMUUFHSnRVUytSM0VTWkxvaENKZlhkSFhEbEhya2JsckZCS3pjWFFl?=
 =?utf-8?B?VWJpK2pJd3pkbWpzODVIRW9VcndOQTd5Yk0zMXc5OU4xbG02UjBVblBkWC9k?=
 =?utf-8?B?Y0RneWdCd2xHZjg4cTYxaGpCYzZjYWN3Y3RkeTF0T2pERS8zdFJ6MFE3b0Z1?=
 =?utf-8?B?VjNvb1VFT3dzVlVMY1NZNXdncXc0TTFwaENEdnhub3E4cHBVKzNlWnhSRHNQ?=
 =?utf-8?B?dFJ5ZUdtc09QenpZQ1RqemRrQmhra3NKRnVQZ0IwVTZzbFFFbDdCSUU4UzNv?=
 =?utf-8?B?SjNCbE9xalRmSC9BUkNibHRxaEdDOW9pYmpmNmdpdzZYcEZXYnRzSXJqU2hy?=
 =?utf-8?B?cTZwV3hHclk5UFhZSlFsM0tQd3o4ZW1uNUMxL0VFM0NNMmpEQWY4Mnhib2xj?=
 =?utf-8?B?WTRxbjIrNWU4ZzNWRVhjb2lCUCtPRkVrUXJzMXR5b2tsMnp1U25aOWZ5ZXhY?=
 =?utf-8?B?Y2ozeUJMZjRaQ2VGY3YzdDNjNDgrN1NDK2M0L3pQVWY5VFpUa29MVTVSZUw0?=
 =?utf-8?B?TGhvTWhTT2FxT1h0VHVsNW5ob0cxcjlDajJHNUc5bURHSWNUWHRZTThOYkZW?=
 =?utf-8?B?Y1drQTN3N1cydkVIdGJmYWVlN09NWC9oK3ZWRnc4RHJMelBPZGwwQjdwNjNL?=
 =?utf-8?B?OHVMNWhOV0dzUS9XbUJZR01jMWZhUDJDNGdTNktBY2NJRkY2a1dqZlV0RTRq?=
 =?utf-8?Q?tXis03rBC5B3qdwtQXkNNds=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7a42ca-ed23-4cdc-b376-08dcc21fc9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 20:28:16.2883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCy11Hax8AVC5afX+p2ucCDBxaHI6ofzaKJxvWWk97tQM0ZHhpdBQtrcqpAV090vhgdeoY85GwaUDe27XSU89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5823
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <0C525FE7D33CB04B98D5C433F35AE639@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: NuelevtZFGKAT_dRuY4l3XKBcJABZFuO
X-Proofpoint-GUID: NuelevtZFGKAT_dRuY4l3XKBcJABZFuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_14,2024-08-19_03,2024-05-17_01



> On May 10, 2024, at 12:21=E2=80=AFPM, Manu Bretelle <chantra@meta.com> wr=
ote:
>=20
>=20
>=20
> =EF=BB=BFOn 5/10/24, 7:06 AM, "Alexei Starovoitov" <alexei.starovoitov@gm=
ail.com <mailto:alexei.starovoitov@gmail.com>> wrote:
>=20
>=20
> >=20
>=20
> On Thu, May 9, 2024 at 11:31 AM Matthieu Baerts <matttbe@kernel.org <mail=
to:matttbe@kernel.org>> wrote:
>>=20
>> Hello,
>>=20
>> On 09/05/2024 17:49, Matthieu Baerts (NGI0) wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn <mailto:tanggeliang@kylinos.=
cn>>
>>>=20
>>> This patch adds a subtest named test_subflow to load and verify the new=
ly
>>> added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
>>> to add a new subflow endpoint. Add another helper ss_search() to verify=
 the
>>> fwmark and congestion values set by mptcp_subflow prog using setsockopt=
s.
>>>=20
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76 <http=
s://github.com/multipath-tcp/mptcp_net-next/issues/76>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn <mailto:tanggeliang=
@kylinos.cn>>
>>> Reviewed-by: Mat Martineau <martineau@kernel.org <mailto:martineau@kern=
el.org>>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org <mailto:mattt=
be@kernel.org>>
>>> ---
>>> tools/testing/selftests/bpf/prog_tests/mptcp.c | 109 ++++++++++++++++++=
+++++++
>>> 1 file changed, 109 insertions(+)
>>>=20
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/tes=
ting/selftests/bpf/prog_tests/mptcp.c
>>> index 274d2e033e39..6039b0ff3801 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>=20
>> (...)
>>=20
>>> @@ -340,10 +344,115 @@ static void test_mptcpify(void)
>>> close(cgroup_fd);
>>> }
>>>=20
>>> +static int endpoint_init(char *flags)
>>> +{
>>> + SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_T=
EST);
>>> + SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
>>> + SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>>> + SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>>> + SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
>>> + SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, fla=
gs);
>>=20
>> I just noticed that this command is failing on the BPF CI:
>>=20
>> https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=3D7009 =
<https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=3D7009>
>>=20
>> Is it possible that an old version of IPRoute2 is installed?
>> 'ip mptcp' is supported since v5.8.0 (from 2020).
>>=20
>> It looks like Ubuntu Focal 20.04 is being used, which has the v5.5.0. Do
>> we then need to find another way to set the MPTCP endpoints?
>=20
>=20
>=20
>=20
> Manu, any idea?
>=20
> // retrying plain text format.... please outlook, please, make this happe=
n!
>=20
> Indeed, this is running Ubuntu 20.04. I am planning to eventually update =
to 22.04 (which has iproute 5.15),
> But I don=E2=80=99t have a good ETA to give other than this is not going =
to be in the coming month.
>=20
> It does not seem that iproute provides an easy way to check its version, =
and the version returned by the container is:
>=20
> root@081a02e57175:/actions-runner# ip --json -V
> ip utility, iproute2-ss200127
> root@081a02e57175:/actions-runner# dpkg -l iproute2
> Desired=3DUnknown/Install/Remove/Purge/Hold
> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Tr=
ig-pend
> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
> ||/ Name           Version        Architecture Description
> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> ii  iproute2       5.5.0-1ubuntu1 amd64        networking and traffic con=
trol tools
>=20
>=20
> How complicated is it to set MPTCP directly using netlink following https=
://github.com/iproute2/iproute2/blob/397383a30c3b0e3ff551042b6654898a0872b8=
3e/ip/ipmptcp.c#L573 ?
> Seems tools/testing/selftests/bpf/netlink_helpers.c could be useful to de=
al with the netlink part. And the former link to find out how to format the=
 message?
>=20
> Manu
>=20
>=20
>=20

FYI,

I have just deployed Ubuntu 24.04 runners. Assuming I don=E2=80=99t need to=
 revert the change because of some unforeseen issues, you should now have a=
 mptcp compatible iproute2 on the CI runners:

root@1fdd5d75581b:/actions-runner# ip --json -V
ip utility, iproute2-6.1.0, libbpf 1.3.0
root@1fdd5d75581b:/actions-runner# ip mptcp help
Usage:  ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]
                                      [ port NR ] [ FLAG-LIST ]
        ip mptcp endpoint delete id ID [ ADDRESS ]
        ip mptcp endpoint change [ id ID ] [ ADDRESS ] [ port NR ] CHANGE-O=
PT
        ip mptcp endpoint show [ id ID ]
        ip mptcp endpoint flush
        ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]
        ip mptcp limits show
        ip mptcp monitor
FLAG-LIST :=3D [ FLAG-LIST ] FLAG
FLAG  :=3D [ signal | subflow | backup | fullmesh ]
CHANGE-OPT :=3D [ backup | nobackup | fullmesh | nofullmesh ]

Manu


