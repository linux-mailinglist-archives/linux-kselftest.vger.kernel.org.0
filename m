Return-Path: <linux-kselftest+bounces-25299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F086AA209A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A783A8BA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCBD1A071C;
	Tue, 28 Jan 2025 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A8HR97SQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011033.outbound.protection.outlook.com [52.103.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F119F420;
	Tue, 28 Jan 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063389; cv=fail; b=kzSwLgBKkOAgVI/gma4dClTA+V/M8TKWP4RtySR10e1BptCmw0KnOgjx+p0xULN6zzaUr4H0DsjZTI46WY0xXHOh4jz2p3Ng+GlzbgYh+i1d1nOTTAA1YtawdKuAvR2KuwoSza3x+vrhISYmrnfE7YIl4aLEK0iVObnrPqpQ3VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063389; c=relaxed/simple;
	bh=dEXQ35Woj2Uz7Fc7q2qgRxqHr6bJ3o/k6kzJ6/5aY+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dw3yrFzApVWQAo5VKeBRRfi8LpK7Og0VWs9P8GrMLXgZkHs7QTLWgoe7XMKKoaCigv5BMDl6rkCW600Ut2Dwr9i9mpr+tuvY3D36gyrWFt/t4pyNVuaFLdNbBSwAHMEPMtkZpx/v0tI63Cx6EmlL4H+QO1yTNUclUVHUg4QFKFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A8HR97SQ; arc=fail smtp.client-ip=52.103.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDdQlRdunNVXFcudpxknNF/Nrz3AUMrVZN0smk9WQS9gFAiFK7qrdW9NUbxtRB2oP+bBLAW998ilOQpmIr2jnQKdwaBwb6FATxKIILLstLlsbtE3OoQQNHECA95cKmDltwT5Id6QHUYOY3g32h4jUHrinzyEf6dDNPHFiGrU/a8lPFjRW3C5fJX0aZpCGCOlaMPub7ZQwO6GJWWcFNaLWWftbFQAuJBfyqyiYoo+ZQ82gq8n+WoludhAsLZh14O2K0WLlRM/+vDsOOgAZ6cNxF/2+vTFHEmGZ6Ms8udgGtc1KDdjM+TJKKh8FtZ28U33jd+PvzCvF9b94kdqg/MxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgdZeK40lfZz/ZBXNETGCwhsyDfzkpq3AtbsZpSuWVc=;
 b=jhwhqktkjAMhB8IxF6zqMdqlexUalV4o/tM/Y8WaWYpGQzLXlP291Faxw8G7hKdsRZG0A0pk3SVWS71DWmPxvXre+DmGv8TbvJBCxwr65S79Drx2M990O3OKCklwSHWTr7Q3A8M7xr9srqhHMghLkuBrri9nCvjiQ/dsC0m5J2RBTwzpq38VdPkErj6cYyPX0CLBKYFFU71XdBI1vVQ1ZIbpYZNqV+E+YjHBLTnYogjWg8BMip7C25t9C6zcL2VhSBrHWKFgrrdETVN5JE9hfBz1Bhlfs5CH8dZMhngWcPmbRYenDO5MngCH6yt6ZF1+WCRw7CBTqUuVT/S+oTzVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgdZeK40lfZz/ZBXNETGCwhsyDfzkpq3AtbsZpSuWVc=;
 b=A8HR97SQZeVe/jY+5sUt0VZ2LE08pfzmMga8ChHh1FDukZFobw0WKF3/5ukxIwHqA9h0/1NtwQwQfRdEhhMi3LLT62JRIWYGWb4P6agFZAaNSXs4Ii4SBZP3sOHRky6YOoNzXqPe8qveuHJkSsEuxVvFB27JN9Vlkn2jtSwwEZYxRiGsx/QyOjkBIC+L+1gsWsuNGmRxE+fvU5l8yZ8inFh8n+rn/aEOUwVHWEyBto0UxCdbIi9Ey+u6z3fhhn+uax61vt1tlf3LJT+FsgJUjdo+zaX/l4f1UtZEhTYLZ1AHJUY370wgldRWso/88xsRYTTIbuFoZHe7OBdIeYwB8Q==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 ME3P282MB0961.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Tue, 28 Jan 2025 11:22:58 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%6]) with mapi id 15.20.8398.014; Tue, 28 Jan 2025
 11:22:58 +0000
Message-ID:
 <SY4P282MB23134B64BA6B0AC71A27BF37C6EF2@SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 28 Jan 2025 19:22:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement
 bpf_probe_read_kernel_dynptr helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, Jordan Rome
 <linux@jordanrome.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com>
 <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
 <CABWLseu6=ZSYpQncaj=0EeVzKtP8vjPyOBJkWcFb-dxbm5OfVQ@mail.gmail.com>
 <CAEf4BzYLPVqRzwzziugfV+fXbd6KQnkvsXJWOYDEgQ6rgUSH9A@mail.gmail.com>
 <CAADnVQKLrCf=wSrJQWEHgGLRnmwqTO98n2waU78KvUZgPXJsjg@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <CAADnVQKLrCf=wSrJQWEHgGLRnmwqTO98n2waU78KvUZgPXJsjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:10e::10)
X-Microsoft-Original-Message-ID:
 <61df18bf-29c4-4298-81e8-9fc9dd891976@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|ME3P282MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c91b299-7886-4ba5-1454-08dd3f8e1b4c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|6090799003|461199028|12121999004|7092599003|15080799006|440099028|3412199025|10035399004|41001999003|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjZUZnlPQ3VLU1dDYTVqbDZiNUhQbForVTl4cjJGVUJxUSt6UHhoTG9GbDlO?=
 =?utf-8?B?OHVnME9EU2xod2FzM3VzdG9zV0FQd3U3emwrVFc4MUt1UzlXeDJ1dXF6dHQ2?=
 =?utf-8?B?cmhjYW9iVzJ2cEc5TlpLSHFZKzNNNmZHQTJOUDhQcmhqY2pUZis2bHlhYnhW?=
 =?utf-8?B?ZzVhNWJvK2tTOGpqa1JEcms3eXM1RWdxMzB4L1RxblZXUS9JMVh2M3pRUlpC?=
 =?utf-8?B?aWR3ZjRqT0FuY0cyaDBnSkRNeGwzZ2V1dTZ2TmtNRG84N21nM1UyOWZvRG9N?=
 =?utf-8?B?SFk3SDZjejZ0Q2h3QlNTWFRMVEY3OWEwL25aTkF4K3FNSHpDMElDL3pqMDdV?=
 =?utf-8?B?NjY5RlZmL2ZhNzcyeVJvQWc1TU51bytaUlcxM3NOTloxREJoU2JEWHFVRE1L?=
 =?utf-8?B?Rm81MFRiVmVacGlsSEpWSjV4YlZxalA4MXkxdkRRWjZFT1NNWWtQVjhROFY3?=
 =?utf-8?B?OE10VTl5RkhXTmFiaW81dE5wZlZEdkozVXloZEg3eEZYcFFRV1k1MlY0bzBj?=
 =?utf-8?B?NDk1QTg3RFVlanVweWltUHNDQk5tMmUrODZzOXFVcklxTmtrbjU1amd5M1Q4?=
 =?utf-8?B?UE1rOXV4TUVSMjMyL2hjOFF5VUdEb0FhZ1kzUkhOcTFRUlEwOG9MVkFZOFRT?=
 =?utf-8?B?bEJWMGQ5d2pjSXU4VG1Db2RpNVlJQ0JzMXZPbkh5c1RYUWV3a3A1S0RkeFIx?=
 =?utf-8?B?dlZoWkZCYUNDa1Qxc1NxV1dHY0FWeXMxQWo0eC9YemdwdmhLM0RPdDB2azVy?=
 =?utf-8?B?M3ZGYkI1bUNQVXhFODhwMDluK3lOcEduUVBEVlAxWWVHMHRhQlVSa1pYUEsw?=
 =?utf-8?B?RitOMHhETytocGJUVVhpb254TnM5SXZwby9Hd3RWTnpIbzZSbzFSajREZ0xt?=
 =?utf-8?B?Nzl5cnRsSWFQdUNjVldjYm1CZ1UvcXRZVmVZVVdFcFVwdXI3K2taMUtvNkEy?=
 =?utf-8?B?T3NPVG9XS3daZUFzQkVOY0tZRW5VVGduRU40SEN0dUdkWDlrUHMrekNMemxs?=
 =?utf-8?B?VnJQTFFaZmM0Qm9Wc0tLblliYjNQaUQyNWl6dWtTLzliK2Ivc3ZrYmowb1dU?=
 =?utf-8?B?NmY4dmhsWUdMVG9UYTJYZWdieEpTZ3B3dkZUb2MvaXlvNHVyaFhDUVhiWWtw?=
 =?utf-8?B?ekFCRVBodjdISU5xUXBENFZwc0ozMlRiUkd4NnVyZmZ2bktPWUw4SUVkOGYv?=
 =?utf-8?B?ZmZVSDVWM0ZKQm5tbEh0RXMzUzRLRXF2Ny9NaCsvazlxOGF6VlVaeTg2aDRu?=
 =?utf-8?B?VGhsUWlmR2RlU1dRaVNRNlBnS0J1U1NMbzFYd2U3SnBVQlE1V1UzTUFicExD?=
 =?utf-8?B?RnFJeDBCME9VU294Ri8zWXVYZ0p1WGV0QlNzRHhROWtHcVlEbU54UDFTL1hO?=
 =?utf-8?B?NGZFbDhyR2lLTGRoMGZkRXZHelE0ZmxXQ0tLalRwM1o2Wk9hZlZSdnBMMWkz?=
 =?utf-8?B?bkk0RVB1U0krM2lmYzNCbjBPYTdoaW1sc3NZMHdyUkozaWhwV0pwam5zWWp6?=
 =?utf-8?B?SndBbUdEcDVYaGV4K2NlME53ZUxnSERoaHU3eXpxTFVjdk5NQytBVzlhY0Ix?=
 =?utf-8?B?azBkaHIwM1hyVkxZTlc4aldIVkJtZXhHVDRsOURDRnVsa0dlVWQ1bE43THVS?=
 =?utf-8?B?YllmSFpCK1ZGZDBEUVllWFRHVnM5aGJiZXVxaFJueFExQzBzN29FczVLdlc1?=
 =?utf-8?B?dGFHRW1hSEhQU1hqcGF5ZGFHMW5UMGhGVWYyKzhHWTlKc2g3K0tydnIydVhI?=
 =?utf-8?Q?MtKEhlfAD6evqzMkLw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2dya2pLUERIdEcyYk1UbjdNTkdtWENNaWx1OTRsZ2JDQjhTYlh5bWJ1VWwz?=
 =?utf-8?B?K1dDN1poNnp5T3g0YWRLRmRLZUVNYTJ2MkszT0xhaTdxSGxMRTFYclBQdHp2?=
 =?utf-8?B?MEtkVTFBSkVweXVZeFBCRDJ5Y2FmQlZwcVhxVUY2NE4rYlRYb3BOdHhiSnVR?=
 =?utf-8?B?OWY1bG5NTSttVVB3WGRFN2ZjbS80ZTZ0eDd3dW9UUytwTG5sT3pYQmg0eVFl?=
 =?utf-8?B?S001S1VXNFdBeVBkNVFPQ3RaRElOa0ViU0J5emUwaW81MnpEN2tpOHRCOHlB?=
 =?utf-8?B?dXBST0NnVVlHZTVUUHRuZnpvN3cvY2hXdUQ2cld3TjRIeE1zWHhmOHVrcGI2?=
 =?utf-8?B?TDEvaHFQc1lvYzQ3NWVzOVpQNnkxQzQ4R2RSSEZQZG50cmJQaG1nQU9jZDlQ?=
 =?utf-8?B?WndDeGpCSEV3R0JBWlVpTXNyZ1oySnpWcFQvOFNMWGxsanB1UThoR1ZhU2ZY?=
 =?utf-8?B?cWlHMC9qR0RGRFFBb2JTdFdDUVIwRytGU21iWHBuOHlwZ2VlL28zRUJQY0xr?=
 =?utf-8?B?eEl4V3c2VURzcUV2N1ZFOGE0N0VRVEE0OHdxdkFyR1NwRFZFYUV2L0NNbTJa?=
 =?utf-8?B?cGNibFFDRHhYVlV5M3hEWnRUczExcHFuSkFGb3p5NVhUY0htYjlSQ042VFZL?=
 =?utf-8?B?SmVsMGJ0ZFcva1o3SjgrUTFVVkJIT3ZhQWJlQVE2OVB0U2hzZXc0cEdhTWV4?=
 =?utf-8?B?cEl1RkpPc0IyR255TnZtKzQ1cHdkaTJ3NWMzU0FoT2hUOUdlQVJuOTRiajJS?=
 =?utf-8?B?SE02WEdoZlJzdHhoZEdCZmJyRmZKU1ZMVFY2bC9SRWtkQ254Q0o5T2tqNVcz?=
 =?utf-8?B?NXo4Z3BsWTJEeS9IcGU3czZQRVg2ODN5RnZiVHBxemNYQVRkVDFEVHFOVGRm?=
 =?utf-8?B?MHlDTlhzSUpEYXpUMXIyRFNVRkJXZVRMbWpnOEtEdGxTSm9nT2Era3p0NU81?=
 =?utf-8?B?bWcyaGR1bzRBSDR5MitvWTRJQ3BwZ2JPaVUxOWtLS0lRUjJTb25UQXhoTXl5?=
 =?utf-8?B?UGRtOXU0b1V6cGxZTWZHRllXcGNVazdaKys4UzRpeXdSWEJhSzM0VlNWRzUv?=
 =?utf-8?B?TXMxbmdESFc4dndLcE1hL0NKMnRsOC83MlA3VEVqUjViZHRpcHJEKytVUU40?=
 =?utf-8?B?NXo2Mmd6cVFHWWt4WmFhWGhUU1FoeGh5WUxXRnd2YWtUM0xlT0xrbGx4N3g2?=
 =?utf-8?B?MExjZm1pY2NjWGdCOVRjQ2loc2F1RXUraWkxNDVYOHVzcnBiWit2d2x3RWho?=
 =?utf-8?B?amxnMUY3WmhYNDlwd3RLNTlYT3FnUDZXNThBdlptMjJOYkRvblQ5bmNWT3Rz?=
 =?utf-8?B?dDdWS1BLSjcrOFNiTm5nV1FUS3VLUzNmL3pmRllFUjMydUdSekM4R3FqWHIw?=
 =?utf-8?B?LzF5QVdhWU1JenBQQWc0bVovR21QeGkvT2hlRGlrNHR1bitaMjNHb2d1VTJH?=
 =?utf-8?B?cDRpQ1U4ZU1rMHBQN29Db21zWE5vdWFnQm96cTBtZXFUYnJjelJNZzN6dDZs?=
 =?utf-8?B?UFRTN212NXN3NXA4Uk9qN2NDM1liTUVPU00vNnZOT2hhQk8xVDYycmVCQUJZ?=
 =?utf-8?B?VWF1Y25RN1BBMW0raE9aVkUwWE5GR2tybDVxa2ZIL21Rcm5DOGdkSkFsVVFT?=
 =?utf-8?B?NjYrVjlzcktpSnBzcUd2a0hIU25SNkFCaEdlOXhxeDFkWWpibzJQRWZTRklu?=
 =?utf-8?B?UFBySkZqMnNwMXRhOHZadUVtY05PbkFIckZWT1JzMEhtZWVaWi9KQXMxWWtn?=
 =?utf-8?Q?fDtrvOMbrP5aLgt2o+vyyVM8cZsYIjFsDuZOWrh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c91b299-7886-4ba5-1454-08dd3f8e1b4c
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 11:22:58.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB0961

On 2025/1/28 10:57, Alexei Starovoitov wrote:
> On Mon, Jan 27, 2025 at 3:09 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Mon, Jan 27, 2025 at 2:54 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>>> On Mon, Jan 27, 2025 at 5:04 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> On Sat, Jan 25, 2025 at 5:05 PM Levi Zim <rsworktech@outlook.com> wrote:
>>>>> On 2025/1/26 00:58, Alexei Starovoitov wrote:
>>>>>   > On Sat, Jan 25, 2025 at 12:30 AM Levi Zim via B4 Relay
>>>>>   > <devnull+rsworktech.outlook.com@kernel.org> wrote:
>>>>>   >> From: Levi Zim <rsworktech@outlook.com>
>>>>>   >>
>>>>>   >> This patch add a helper function bpf_probe_read_kernel_dynptr:
>>>>>   >>
>>>>>   >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
>>>>>   >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
>>>>>   > We stopped adding helpers years ago.
>>>>>   > Only new kfuncs are allowed.
>>>>>
>>>>> Sorry, I didn't know that. Just asking, is there any
>>>>> documentation/discussion
>>>>> about stopping adding helpers?
>>>>>
>>>>> I will switch the implementation to kfuncs in v3.
>>>>>
>>>>>   > This particular one doesn't look useful as-is.
>>>>>   > The same logic can be expressed with
>>>>>   > - create dynptr
>>>>>   > - dynptr_slice
>>>>>   > - copy_from_kernel
>>>>>
>>>>> By copy_from_kernel I assume you mean bpf_probe_read_kernel. The problem
>>>>> with dynptr_slice_rdwr and probe_read_kernel is that they only support a
>>>>> compile-time constant size [1].
>>>>>
>>>>> But in order to best utilize the space on a BPF ringbuf, it is possible
>>>>> to reserve a
>>>>> variable length of space as dynptr on a ringbuf with
>>>>> bpf_ringbuf_reserve_dynptr.
>>> For our uprobes, we've run into similar issues around doing variable-sized
>>> bpf_probe_read_user() into ring buffers for our debugger [1]. Our use case
>>> is that we generate uprobes that recursively read data structures until we
>>> fill up a buffer. The verifier's insistence on knowing statically that a read
>>> fits into the buffer makes for awkward code, and makes it hard to pack the
>>> buffer fully; we have to split our reads into a couple of static size classes.
>>>
>>> Any chance there'd be interest in taking the opportunity to support
>>> dynamically-sized reads from userspace too? :)
>> That's bpf_probe_read_user_dynptr() from patch #2, no?
>>
>> But generally speaking, here's a list of new APIs that we'd need to
>> cover all existing fixed buffer versions:
>>
>> - non-sleepable probe reads:
>>
>>    bpf_probe_read_kernel_dynptr()
>>    bpf_probe_read_user_dynptr()
>>    bpf_probe_read_kernel_str_dynptr()
>>    bpf_probe_read_user_str_dynptr()
>>
>> - sleepable probe reads (copy_from_user):
>>
>> bpf_copy_from_user_dynptr()
>> bpf_copy_from_user_str_dynptr()
>>
>> - and then we have complementary task-based APIs for non-current process:
>>
>> bpf_probe_read_user_task_dynptr()
>> bpf_probe_read_user_str_task_dynptr()
>> bpf_copy_from_user_task_dynptr()
>> bpf_copy_from_user_str_task_dynptr()
>>
>> Jordan is working on non-dynptr version of
>> bpf_copy_from_user_str_task(), once he's done with that, we'll add
>> dynptr version, probably.
> This is quite a bunch of kfuncs.
> It doesn't look like adding _dynptr suffix and duplicating
> kfuncs approach scales.

The _str_dynptr versions might not worth adding [1].
So only four read_{kernel,user}_dynptr and copy_from_user{,_task}_dynptr 
are needed,
which seems manageable for now.

But taking other helpers like bpf_strtol into account does quickly show 
that this approach
is not scalable.

> Let's make the existing helpers/kfuncs more flexible ?
>
> We can introduce a kfunc bpf_dynptr_buf() that checks that
> dynptr is not readonly and type == local or ringbuf and
> return dynptr->data as PTR_TO_MEM | dynptr_flag | VERIFIER_ADDS_SIZE_CHECK.
>
> Then allow bpf_probe_read_user/kernel/... all of them to accept
> this register type where PTR_TO_MEM is required
> while relaxing ARG_CONST_SIZE 2nd argument to ARG_ANYTHING.
> Then the verifier will insert an extra check
> if (arg1->size < arg2)
> before the call.
Nice idea. I will try this approach first.
>
> Not only the bpf_probe_read_kernel/user, _str variants will work
> but things like bpf_strtol, bpf_strncmp, bpf_snprintf, bpf_get_stack
> will auto-magically work as well.
>
> I think those are quite valuable to make available with non-constant size.
> bpf_get_stack_*() directly into the ring buffer sounds very useful.

[1]: 
https://lore.kernel.org/bpf/20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com/T/#m9700146d286a88abc0b25ef47041015ba6c477a3


