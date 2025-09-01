Return-Path: <linux-kselftest+bounces-40440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C796B3E648
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CF169322
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CAD33A009;
	Mon,  1 Sep 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YZpKrzBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012061.outbound.protection.outlook.com [52.101.126.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04541338F45;
	Mon,  1 Sep 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734991; cv=fail; b=kcVQAToRFmmFz1zFKRAI9H2d3CKqlV2VAFpsYFbhlsUyz37f5qRFk5y+Vc/3z4dI1uQHw56tKkXAOWJGtjXCkFyBT/iuCjf7W4jotgAUf6ldRNpDpQ52BYIY2ciC3ekF0Lglq3FcWrHFa4Zvl3K/UuZspfzNIr13LFenMnaK+y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734991; c=relaxed/simple;
	bh=CZVbEfYLHTukYoi0yJ5A5ZdKGJxH0rbBMYbOHMikW6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXoltvXC80iKdriHj0c+HToYgWVjBH7qSIkU+uO+QqRUSqzAbK3HKgLAwQtfWDWDM6AIQra+YsdT9MqhfQMQv4jUJwE6vy0gfXjBTbexSmxX83DIbCY7vJPzLhkVDzUSXJaa9YloR5FFKs3WNUhqD6PfzvXchNPQaGJMJj4Nxao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YZpKrzBs; arc=fail smtp.client-ip=52.101.126.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOSfzSvYRliDCkCoo3lryIWO3oWCz1LR7WOIlpTaAUx6evRvNRhAN63kzX1c0i0cV4qwIyX7Jqmwzm3hSrc+3HAxb9xEFs2k5wyI1m7Gp9Mii6FaPd8K4CusYaq+t1pdgractJOs+/ZvwrrwQ6Im+eINkVbIjMIwxhNhl6zO3qLj/z1b8dbphIRCKtAOBb3P8snhibQDMdRX7oHc5xbdlfH9tRZ5ysIwfem/VFlDZXXc3nneDuZy9R1TAv6Q9cEK9YLO0g/2TKOpSwvYWa/q87244c+HYE0wxBtklRUiqqNhANwyAs6bEABW5Gre2gem7xcTAn4lVI20llbLyRDJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plv/UAaYjW+STiGjuOnd/ZCgpRGV6qysoNHlu64cIwY=;
 b=WLRPHqQUoVzoz8oXZq2qcQEHm51ZPEx4PEJb3FAoR2H99q7v+188Qq1QDhDGeLIyXnNV1K86jAIMDC8PnrkeLGNbF570Fek4qd4h9AOutIHzcH4QulbZvs2ueW6lwGeJSuFC8DaQuDMaU5/bc6XHBW6OZ6hNGqJCootb2/vpsfm8f5OzInAyc4HJKp8rn1RdIMctVgBfdeU2AVN1K8XGVZc09lbfipq+TYCI4h6iP3SConFB+OcWFqXzB54EyEEDFDGr9c562///zXjkMlwnz42ouG1BMfxErMP0TMD0phFMrjDsFtorxQKe7pf1HMEDslpDzSQnuQgSlAEQQVOxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plv/UAaYjW+STiGjuOnd/ZCgpRGV6qysoNHlu64cIwY=;
 b=YZpKrzBs3W9AEsIXKRZGWUEYUdtHJuz3NrFuEKMmdl8ODWUdKGHBxmi92XE+M/wctZ4Y+hyHlg7EzLwgKWxZcaw8EodBGtf+Dg4NyOGjfKfY02ZdrS5qPegeWV+Blg6wKiafHrm6iIMKIlIZ9Fpw45Qw5L0Fc8IvYTe9Q1Qh0LCWn8qn/562TM92yceY6ifJrbWMdK75/X1SDSRQ0EKYA+tdJzdh1Q5ItPV0F8TcEn3LFJbffJ+WzYcZn/Tp+YgB/NjWJS5LBqAEDPVVsAHksJzivjCVRgzqZmOy0PYAog5uTrr0HRgDDs2IKJkttLypG1OaQNE3hXjRDxxizu+ZtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by TY0PR06MB5732.apcprd06.prod.outlook.com (2603:1096:400:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 13:56:27 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:56:27 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: Christian Loehle <christian.loehle@arm.com>,
	Song Liu <song@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Lin Yikai <yikai.lin@vivo.com>
Cc: zhaofuyu@vivo.com
Subject: [PATCH v2 bpf-next 1/2] cpuidle: Implement BPF extensible cpuidle governor class
Date: Mon,  1 Sep 2025 21:56:08 +0800
Message-ID: <20250901135609.76590-2-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901135609.76590-1-yikai.lin@vivo.com>
References: <20250901135609.76590-1-yikai.lin@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To KL1PR0601MB4324.apcprd06.prod.outlook.com
 (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|TY0PR06MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 59dafaf9-b344-477e-f145-08dde95f5836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akI0WDhOaG1GVUFNbVdRNnZhUjBjOUsxMHQ2RTVTUDdXbmp4bnJPc2FXWDYv?=
 =?utf-8?B?cTl0MHJnYldJdEU1SEJtSVBNUFU5SEhrdDIySEQyYk9uZW9BeG5xdTEzRDBl?=
 =?utf-8?B?UXM3VUxXRGtUR21tUk5HWmZmcG1idXlKaUJic0xwWTJCbVdHQVFmSXhRaDNN?=
 =?utf-8?B?K1o4c2tyUkJnTW4rVlRvTHVXM1M0eHZKaVN5Z0ZXNk1kbTA3N3VrV0l4Ukd6?=
 =?utf-8?B?T3BNL1FQVU1BYldRQXZMQWZoOStIUkcrTGtDVHpabTkrWmtXRkp0aG51Y002?=
 =?utf-8?B?MHdDRTJSSnpjenB1Y3N4SC9kclduL0FEenlVbWhCcjRSV0JZVUFCS3Y5NTVT?=
 =?utf-8?B?RUZXVFl6cmF2S0piRE9MbjJjVmtNa0N2N2RINTM2U2Nad2R2TWVCcEt4SVIx?=
 =?utf-8?B?cFpHeHJpMnd3YzdxbGZWSklxT0Z1QVg5c3FVTjBuT3IwcnlHcHZPSVJqamtM?=
 =?utf-8?B?L2ZZdjZSV0RIRWRsejYxRU90TnR2eE5HS0REK2U0OVcwOFRIVjFGbDVxMVNJ?=
 =?utf-8?B?NHhZbHpCWStTTUlMK1NBYitFVUhpMWVFeDM5dVFJZDd4SjIrcFhpcWZiSGc3?=
 =?utf-8?B?cWhGcGE0MGd1RVNyZlVIQktmbDRwSTlRUEFpRFdDQVVhWDE4Uk0xbGt3Q3BL?=
 =?utf-8?B?TWVrSXk0WDdYZjZTeWpIeHA3Sk9kU1R0bGRyM28wOTIrS0RseW0zWkxVbkVw?=
 =?utf-8?B?anBzK2RXSWY1L1BWNVIwbHlGS1RNb3VxUlVOdTNzVE5vNzZpZXRaM09ybFNP?=
 =?utf-8?B?SFo2b1BNODUxd3ZlUDcyZG9ZSkl4N01tRlAwQld1dEdzbmtVVzNSK2NMY3Zk?=
 =?utf-8?B?a1E3bzFrZjVnZGh5cEd5NjRqRFh0ZjdtWFozOWp3dXdOV1JKTEg5RHJnTnpQ?=
 =?utf-8?B?VzNWMHZVT01vQVZKTHJUWTZhK0VzOXlhaHZGbTRqSVZQNUVpY0hDK0s4SjRR?=
 =?utf-8?B?ekphb2lVdG03N1N5THZBMjlEZTRtMUJ6TTNhU2g3WUF5ZnJ6OHdSLzFRa2Fh?=
 =?utf-8?B?VDNRNzFyTWd3SXZYWllqeWxCRlY0KzJDT2hoRzkzTnhscTBnWVVkYm9DUy96?=
 =?utf-8?B?bElhNHNoL3c4dE9nOGlDN0YvTUJRSTMvWHlxVUs1MEpBZDZyczVPL014VUtQ?=
 =?utf-8?B?UHJadGVjRStsUytjNVlzdkhPK2cwUk9VN0hjc0FoVjFLeDBkOFUzMjMrV2dv?=
 =?utf-8?B?aDk1dGdnSjNlRlI2MS81UTdrVG9UODNjZk5oRGh6TW00bjk2QmhBeFdXY1Av?=
 =?utf-8?B?L1JYaXprL04wVHpVbyt1UVU1Z3pOUG9uM1pxT3RXYTBCSzdYT0Myc2lLUXNM?=
 =?utf-8?B?eThJU1VuQy9oQ3BLb0ZJWUZXTzJ4REkrakZTMUt5RHIxWGNjb1B6d0w0bFpt?=
 =?utf-8?B?OUNWcit0azNkZVJnTi9JNDF4YVc1YzY0V052WCtQWjQrWmdtMGQzSmpJaUlD?=
 =?utf-8?B?ZTd2dUhTbDlCUUhZQ0k3MGV4Ujh2c0puMS91ME9Oc1RHN0ovRk44ZVhjZHgv?=
 =?utf-8?B?YkxJRU5NY0RDQjh5Z2hydk9XNDMvcHBGRTFmVW5iSEdTcU1BRVdZeVgrYVJl?=
 =?utf-8?B?S3JCNTIzYzZUaGdFcE15YlpyQUJka1lHejBPUWVBeFQ4NnNTYWd1Q2FFcGF0?=
 =?utf-8?B?NW1zVWlXMTlpZkZtdGJSeXFTbGpHbHI2NnA4ZVBLeExVekRWanIrRjMvdzE3?=
 =?utf-8?B?aTFXTERodDhCcEtJMnZ2dHVoOWpQeDRySmdjSjhCVE1SVXBvUmJMSDNwNDkw?=
 =?utf-8?B?K3N3TnpVTzRaL2JLRWF0TWp4NUtPRktyYmp2Z3JtSkJCTmxwUDRybUd5dFli?=
 =?utf-8?B?WlBRekMwQXpia3R0YnBMUURWWFl3QU5Ca3pZWVoyWnFKMitOZTFQWFp4Qkty?=
 =?utf-8?B?RDVEZ05iWTUzcmRUUzMvTHRZdm1QREpGV1NjZ0ZWQ3lHMWE0d3kxY2U3eS9P?=
 =?utf-8?B?L0VtTWNuVDdsYmxCQlovcXhmb2FWckh2RklxRS96L3VtNDFBMkM2UjR1bVhv?=
 =?utf-8?Q?S6NwidlIHETGhAV0ws2K+e69ixeF58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2hhT284K2FSTGNVelJ5YmxMNmU2b0hyUDByU0ZqdGtLeUNrS2I1a0RTUjdw?=
 =?utf-8?B?Wi9jd3phb0tHMHpna3VITC9GVWZmV05ia2xXeVQ2OFVFNFdiTWlrWVRMeW56?=
 =?utf-8?B?Smx3MWdHSjhldG8xKzdKZTV2WDZ3LzVPTmNFcS9IWTNiL0VaUFJZRlBVWDJI?=
 =?utf-8?B?QmhXWmZQcUQ2MlFPdGw5UTZVWWRUbXR2T3Q1OC96ZTFmTys3OFYzdm1nTWdh?=
 =?utf-8?B?ZmMxK01NVXoxdXAvcXhJYzR0SVk3Tys0OUkvcVM0Ynk3a0xmMHBvSytjd3pL?=
 =?utf-8?B?NVVaWXBLVVYzL2kyY3FPd1FWN3oxRFdicUtwRmZNTm9DWC9NNGYvUVhKak5F?=
 =?utf-8?B?ZUNjcDR0ZVJSQVNRd2ZCcjRIdlVZbktYMmpBM2ZWY3ZLTG1lbDFWdTAyV1Jt?=
 =?utf-8?B?aDRubFJvakJPUGkxMzlqMEF3eWN4NkZ0c2JnS1V5ejRRVUdRRDNyUlJoSVZB?=
 =?utf-8?B?NkpEMHVKOHNoTlFIcGZrMElKdTNEUnozTmxhUHErZndLMlJyc3FsUHZOWXFQ?=
 =?utf-8?B?TVJ1cmk1NC9QY0lvTTlFREllVE1tbVR5VG5WT3MrQVE0SSsvVEtxRjRRMzRn?=
 =?utf-8?B?NCtKSUNjZEUxY2FmV2c5ZFRiNFhEZWNqZUdQT2xQbHRKdDd4ek9SallXWkpt?=
 =?utf-8?B?Z3JYZGxUeHpQMS9vSXVMRHZJU3N0dGZjRWxnTEEwSW5tOVZobXVCcWZrUk5Z?=
 =?utf-8?B?cGdyN0U5T09Xck5FZkpqYjg2Uit6TEVianJSV2hocG9xQlhmVE5ySUQ0UHUy?=
 =?utf-8?B?MTJzblhlUXdOR2FybjIvSDA3Y05jakM3YXR5S3pLRmViQlQrUDAyMWRScFo0?=
 =?utf-8?B?MWlENDVhSXZVN0p6SFJROG9nb242K2ZycDNOYXNOTFN6ZEV5N0RJL3pUTDJW?=
 =?utf-8?B?QWRWanZlK1h1N0FSK0Z0R2lLcEFBdUNHU2w2Ujk2ejQzd2E2UXM0MjYydXox?=
 =?utf-8?B?M0U0MzVUcW01WGVIQTh0eUxpcUpack41bElzMGxmY1JwYjJVVmFyZ2ZjQzg1?=
 =?utf-8?B?Mk5Pa09JeU0xZmpxMWNrNWJmdWxOTGZMaXZEbVo2czY1ckNBUWFxNkdrSnBX?=
 =?utf-8?B?cC9GZVd1cEdCTElzTUxtdXpXb3EvQjF0YnJFWjFOb1NlaWUwdXZXWHRMeG8v?=
 =?utf-8?B?ekdkK3NWb1N5L3Y4cjc5eDNaTjRNZjV2T1h0cS9TZ20ySUM5UjdNS1FYcWtJ?=
 =?utf-8?B?a0lsaXJiU09WSDUxUjJDNzExTkJKTjRidjhyVS9IQ2wrc2hSQkxnaVdKcmlE?=
 =?utf-8?B?RmUyVTRncXcwMXROdWI1MUU0eVdkbks0SGtQWVUydldPWEsrc044L0dYdHp4?=
 =?utf-8?B?d1c5L0NNZmJkbktMaGdmRUpyckJUTjZVaDFvOUZiMXhqUkIvMU50SDdrYnkz?=
 =?utf-8?B?U2JVWlNMSW0wWlVkNkRlS0o4cjdyNCtHbkRGMC9WcExCS2k2cDRjT1NNeE1V?=
 =?utf-8?B?enFDRWVLMkE1RWJsU0ZnMUg2WXBQdnh6akIxME5Yd3BOckxzN3dvMGl6ZVBj?=
 =?utf-8?B?TDFPODhIN3NsNXpaUTJtT0orOWdhTlUxSHplYXZBaUFSQ1grc0RUa2ZBcUtr?=
 =?utf-8?B?SGJDem56UnVHTk9vOXNLYzJ0NWJ6akVLQTd1Skp0M2JEQlI2YkNHdklnK2Ez?=
 =?utf-8?B?QlJwQURlU3N3RTVCNElRKzdOMTFJN3kzWUhyYk5Jb05oVk54OVhld3l3Z0xw?=
 =?utf-8?B?QnhOTjEwU2dwaFluVHhSMzNvL05NVFpsSnJWRGN6NWthQnFneEFSQ1RBdFB5?=
 =?utf-8?B?dEdHNHp2Mzc3UmVLM2lpWUVaZ0VNWi8rN25WbVRhVHJhMllQVHIyRHA0YmpN?=
 =?utf-8?B?NldHZGNka2NJRVNOQnNKWitCUytMeW9odkNOSHdUNzRTRFNiL0JoUkwza01N?=
 =?utf-8?B?b3JtZytscnFqLzcrQVNmaXpYNkRHSWxHM2ZoZTZqSHBqQ0hlQUJXU0lSSk5v?=
 =?utf-8?B?VjM5Sy9TMTV5V0FpT2NZQ2d2YngwLzBOYmNtdW5YWnUwbk5MSmgvWXhVcTJB?=
 =?utf-8?B?UXVNbHdMTTRnOU53NU1wUDVrNC9GZFI3dExrL0g0clV5c2NwQkx3Rk8yRExS?=
 =?utf-8?B?clpjbEljQVR3bUxqdnEwU3VDMW9VT3hRdm1HdUtmaFJ2ME5pUDMxYW8yMHFE?=
 =?utf-8?Q?towIS8+IaqzQZ2jzJJ8Y31Hot?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dafaf9-b344-477e-f145-08dde95f5836
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:56:27.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUFCOlmggbGyK8fGpaYOkSzxCRVuCfDh+7IcQgQX/tyq32u5nqJNAzoBq8AafGS5ZfQ4vNLhIsRx845yzkOANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5732

The BPF cpuidle ext governor registers at postcore_initcall()
but remains disabled by default due to its low priority "rating" with value "1".
Activation requires adjust higer "rating" than other governors within BPF.

Core Components:
1.**struct cpuidle_gov_ext_ops** – BPF-overridable operations:
- ops.enable()/ops.disable(): enable or disable callback
- ops.select(): cpu Idle-state selection logic
- ops.set_stop_tick(): Scheduler tick management after state selection
- ops.reflect(): feedback info about previous idle state.
- ops.init()/ops.deinit(): Initialization or cleanup.

2.**Critical kfuncs for kernel state access**:
- bpf_cpuidle_ext_gov_update_rating():
  Activate ext governor by raising rating must be called from "ops.init()"
- bpf_cpuidle_ext_gov_latency_req(): get idle-state latency constraints
- bpf_tick_nohz_get_sleep_length(): get CPU sleep duration in tickless mode

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 drivers/cpuidle/Kconfig            |  12 +
 drivers/cpuidle/governors/Makefile |   1 +
 drivers/cpuidle/governors/ext.c    | 537 +++++++++++++++++++++++++++++
 3 files changed, 550 insertions(+)
 create mode 100644 drivers/cpuidle/governors/ext.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index cac5997dca50..4f2eac531b0b 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -44,6 +44,18 @@ config CPU_IDLE_GOV_HALTPOLL
 
 	  Some virtualized workloads benefit from using it.
 
+config CPU_IDLE_GOV_EXT
+    bool "bpf cpuidle ext governor"
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	default y
+	help
+	  This governor implements a simple cpuidle ext governor,
+	  which can be customized by a BPF program without modifying
+	  kernel code.
+
+	  Some scenarios benefit where CPUidle policy needs
+	  to be customized based on user-space requirements.
+
 config DT_IDLE_STATES
 	bool
 
diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
index 63abb5393a4d..cd5eaf9f275f 100644
--- a/drivers/cpuidle/governors/Makefile
+++ b/drivers/cpuidle/governors/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
 obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
 obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
 obj-$(CONFIG_CPU_IDLE_GOV_HALTPOLL) += haltpoll.o
+obj-$(CONFIG_CPU_IDLE_GOV_EXT) += ext.o
diff --git a/drivers/cpuidle/governors/ext.c b/drivers/cpuidle/governors/ext.c
new file mode 100644
index 000000000000..9968ae482899
--- /dev/null
+++ b/drivers/cpuidle/governors/ext.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ext.c - the cpuidle ext governor used by BPF
+ *
+ * Copyright (C) Yikai Lin <yikai.lin@vivo.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/percpu.h>
+#include <linux/ktime.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/tick.h>
+
+#define EXT_GOV_NAME	"ext"
+
+/********************************************************************************
+ * Helpers that can be called from the BPF cpuidle gov.
+ */
+#include <linux/btf_ids.h>
+#include <linux/btf.h>
+
+#include "../cpuidle.h"
+
+static struct cpuidle_governor *cpuidle_last_governor;
+
+/**
+ * restore_cpuidle_last_governor - restore last governor after bpf ext gov exiting.
+ */
+static void restore_cpuidle_last_governor(void)
+{
+	bool enabled = false;
+
+	if (cpuidle_curr_governor)
+		enabled = !strncasecmp(cpuidle_curr_governor->name, EXT_GOV_NAME, CPUIDLE_NAME_LEN);
+
+	mutex_lock(&cpuidle_lock);
+	if (enabled && cpuidle_last_governor)
+		if (cpuidle_switch_governor(cpuidle_last_governor))
+			cpuidle_last_governor = NULL;
+	mutex_unlock(&cpuidle_lock);
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_cpuidle_ext_gov_update_rating - update rating of bpf cpuidle ext governor.
+ * @rating: target rating
+ *
+ * The BPF cpuidle ext governor is registered by default
+ * but remains inactive due to its default @rating being set to 1
+ * which is significantly lower than that of other governors.
+ *
+ * To activate it, adjust @rating to a higher value within the BPF program.
+ *
+ * This function should be called from ops.init().
+ */
+__bpf_kfunc int bpf_cpuidle_ext_gov_update_rating(unsigned int rating)
+{
+	int ret = -EINVAL;
+	struct cpuidle_governor *ext_gov;
+
+	ext_gov = cpuidle_find_governor(EXT_GOV_NAME);
+	if (!ext_gov) {
+		ret = -EEXIST;
+		goto clean_up;
+	}
+	mutex_lock(&cpuidle_lock);
+	if (!cpuidle_curr_governor || cpuidle_curr_governor->rating < rating) {
+		cpuidle_last_governor = cpuidle_curr_governor;
+		ret = cpuidle_switch_governor(ext_gov);
+	}
+	mutex_unlock(&cpuidle_lock);
+
+clean_up:
+	return ret;
+}
+
+/**
+ * bpf_cpuidle_ext_gov_latency_req - get target cpu's latency constraint
+ * @cpu: Target CPU
+ *
+ * The BPF program may require this info.
+ */
+__bpf_kfunc s64 bpf_cpuidle_ext_gov_latency_req(unsigned int cpu)
+{
+	return cpuidle_governor_latency_req(cpu);
+}
+
+/**
+ * bpf_tick_nohz_get_sleep_length - return the expected length of the current sleep
+ *
+ * The BPF program may require this info.
+ */
+__bpf_kfunc s64 bpf_tick_nohz_get_sleep_length(void)
+{
+	ktime_t delta_tick;
+
+	return (s64)tick_nohz_get_sleep_length(&delta_tick);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(cpuidle_ext_gov_kfuncs)
+BTF_ID_FLAGS(func, bpf_cpuidle_ext_gov_update_rating)
+BTF_ID_FLAGS(func, bpf_cpuidle_ext_gov_latency_req)
+BTF_ID_FLAGS(func, bpf_tick_nohz_get_sleep_length)
+BTF_KFUNCS_END(cpuidle_ext_gov_kfuncs)
+
+static const struct btf_kfunc_id_set cpuidle_ext_gov_kfuncs_set = {
+	.owner  = THIS_MODULE,
+	.set	= &cpuidle_ext_gov_kfuncs,
+};
+
+static int cpuidle_gov_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpuidle_ext_gov_kfuncs_set);
+}
+
+/********************************************************************************
+ * bpf_struct_ops plumbing.
+ */
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+
+#define CPUIDLE_GOV_EXT_NAME_LEN 128
+enum ops_enable_state {
+	OPS_ENABLED,
+	OPS_DISABLED,
+};
+
+static const struct btf_type *cpuidle_device_type;
+static u32 cpuidle_device_type_id;
+static struct cpuidle_gov_ext_ops *ops;
+
+static DEFINE_MUTEX(ops_mutex);
+DEFINE_STATIC_KEY_FALSE(ops_enabled_key);
+static atomic_t ops_enable_state_var = ATOMIC_INIT(OPS_DISABLED);
+
+struct cpuidle_gov_ext_ops {
+	/**
+	 * enable - cpuidle ext governor enable
+	 * @drv: cpuidle driver containing state data.
+	 * @dev: target cpu
+	 */
+	int (*enable)(struct cpuidle_driver *drv, struct cpuidle_device *dev);
+
+	/**
+	 * disable - cpuidle ext governor disable
+	 * @drv: cpuidle driver containing state data.
+	 * @dev: target cpu
+	 */
+	void (*disable)(struct cpuidle_driver *drv, struct cpuidle_device *dev);
+
+	/*
+	 * select - select the next cpu idle state to enter
+	 * @drv: cpuidle driver containing state data.
+	 * @dev: target cpu
+	 */
+	int (*select)(struct cpuidle_driver *drv, struct cpuidle_device *dev);
+
+	/*
+	 * set_stop_tick - whether or not to stop the scheduler tick
+	 * automatically called after selecting cpuidle state
+	 */
+	bool (*set_stop_tick)(void);
+
+	/*
+	 * reflect - Give the governor an opportunity to reflect on the outcome
+	 * @dev: target cpu
+	 * @index: last idle state which target cpu has entered
+	 */
+	void (*reflect)(struct cpuidle_device *dev, int index);
+
+	/**
+	 * init - Initialize the BPF cpuidle governor
+	 */
+	int (*init)(void);
+
+	/**
+	 * exit - Clean up after the BPF cpuidle governor
+	 */
+	void (*exit)(void);
+
+	/**
+	 * name - BPF cpuidle governor name
+	 */
+	char name[CPUIDLE_GOV_EXT_NAME_LEN];
+};
+
+static enum ops_enable_state get_ops_enable_state(void)
+{
+	return atomic_read(&ops_enable_state_var);
+}
+
+static enum ops_enable_state
+set_ops_enable_state(enum ops_enable_state to)
+{
+	return atomic_xchg(&ops_enable_state_var, to);
+}
+
+static int enable_stub(struct cpuidle_driver *drv, struct cpuidle_device *dev) { return 0; }
+static void disable_stub(struct cpuidle_driver *drv, struct cpuidle_device *dev) {}
+static int select_stub(struct cpuidle_driver *drv, struct cpuidle_device *dev) { return 0; }
+static bool set_stop_tick_stub(void) {return false; }
+static void reflect_stub(struct cpuidle_device *dev, int index) {}
+static int init_stub(void) { return 0; }
+static void exit_stub(void) {}
+
+static struct cpuidle_gov_ext_ops __bpf_ops_cpuidle_gov_ext_ops = {
+	.enable = enable_stub,
+	.disable = disable_stub,
+	.select = select_stub,
+	.set_stop_tick = set_stop_tick_stub,
+	.reflect = reflect_stub,
+	.init = init_stub,
+	.exit = exit_stub,
+};
+
+static int ext_btf_struct_access(struct bpf_verifier_log *log,
+					 const struct bpf_reg_state *reg, int off,
+					 int size)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t == cpuidle_device_type) {
+		for (int i = 0; i < CPUIDLE_STATE_MAX; i++) {
+			size_t base_offset = offsetof(struct cpuidle_device, states_usage[i]);
+
+			if (off >= base_offset + offsetof(struct cpuidle_state_usage, disable) &&
+				off + size <= base_offset + offsetofend(struct cpuidle_state_usage, disable)) {
+				return SCALAR_VALUE;
+			}
+		}
+	}
+
+	return -EACCES;
+}
+
+static const struct bpf_verifier_ops ops_verifier = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = btf_ctx_access,
+	.btf_struct_access = ext_btf_struct_access,
+};
+
+static void ops_disable(void)
+{
+	restore_cpuidle_last_governor();
+	WARN_ON_ONCE(set_ops_enable_state(OPS_DISABLED) != OPS_ENABLED);
+	static_branch_disable(&ops_enabled_key);
+	if (ops->exit)
+		ops->exit();
+	memset(&ops, 0, sizeof(ops));
+}
+
+static void ops_unreg(void *kdata, struct bpf_link *link)
+{
+	mutex_lock(&ops_mutex);
+	ops_disable();
+	mutex_unlock(&ops_mutex);
+}
+
+static int ops_reg(void *kdata, struct bpf_link *link)
+{
+	mutex_lock(&ops_mutex);
+	if (get_ops_enable_state() != OPS_DISABLED) {
+		mutex_unlock(&ops_mutex);
+		return -EEXIST;
+	}
+	/*
+	 * Set ops, call ops.init(), and set enable state flag
+	 */
+	ops = (struct cpuidle_gov_ext_ops *)kdata;
+	if (ops->init && ops->init()) {
+		ops_disable();
+		mutex_unlock(&ops_mutex);
+		return -EINVAL;
+	}
+	WARN_ON_ONCE(set_ops_enable_state(OPS_ENABLED) != OPS_DISABLED);
+	static_branch_enable(&ops_enabled_key);
+
+	mutex_unlock(&ops_mutex);
+	return 0;
+}
+
+static int ops_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct cpuidle_gov_ext_ops, enable):
+	case offsetof(struct cpuidle_gov_ext_ops, disable):
+	case offsetof(struct cpuidle_gov_ext_ops, select):
+	case offsetof(struct cpuidle_gov_ext_ops, set_stop_tick):
+	case offsetof(struct cpuidle_gov_ext_ops, reflect):
+	case offsetof(struct cpuidle_gov_ext_ops, init):
+	case offsetof(struct cpuidle_gov_ext_ops, exit):
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int ops_init_member(const struct btf_type *t,
+				const struct btf_member *member,
+				void *kdata, const void *udata)
+{
+	const struct cpuidle_gov_ext_ops *uops = udata;
+	struct cpuidle_gov_ext_ops *ops = kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	int ret;
+
+	switch (moff) {
+	case offsetof(struct cpuidle_gov_ext_ops, name):
+		ret = bpf_obj_name_cpy(ops->name, uops->name,
+				sizeof(ops->name));
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -EINVAL;
+		return 1;
+	}
+	return 0;
+}
+
+static int ops_init(struct btf *btf)
+{
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "cpuidle_device", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	cpuidle_device_type = btf_type_by_id(btf, type_id);
+	cpuidle_device_type_id = type_id;
+
+	return 0;
+}
+
+static int ops_update(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	/*
+	 * Not support updating the actively-loaded BPF cpuidle governor
+	 */
+	return -EOPNOTSUPP;
+}
+
+static int ops_validate(void *kdata)
+{
+	return 0;
+}
+
+static struct bpf_struct_ops bpf_cpuidle_gov_ext_ops = {
+	.verifier_ops = &ops_verifier,
+	.reg = ops_reg,
+	.unreg = ops_unreg,
+	.check_member = ops_check_member,
+	.init_member = ops_init_member,
+	.init = ops_init,
+	.update = ops_update,
+	.validate = ops_validate,
+	.name = "cpuidle_gov_ext_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &__bpf_ops_cpuidle_gov_ext_ops
+};
+
+/********************************************************************************
+ * default cpuidle ext governor implementations
+ */
+#define ALPHA_SCALE 100
+#define FIT_FACTOR 90
+
+struct cpuidle_gov_ext {
+	int cpu;
+	int last_idx;
+	u64 last_duration;
+	u64 next_pred;
+};
+
+DEFINE_PER_CPU(struct cpuidle_gov_ext, cpuidle_gov_ext_data);
+
+static void update_predict_duration(struct cpuidle_gov_ext *data,
+			struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	int idx;
+	struct cpuidle_state *target;
+
+	if (!data || !drv || !dev)
+		return;
+	idx = data->last_idx;
+	data->last_duration = dev->last_residency_ns;
+	if (idx > 0) {
+		target = &drv->states[idx];
+		if (data->last_duration > target->exit_latency)
+			data->last_duration -= target->exit_latency;
+	}
+	data->next_pred = data->last_duration;
+}
+
+static void ext_reflect_dfl(struct cpuidle_device *dev, int index)
+{
+	struct cpuidle_gov_ext *data = this_cpu_ptr(&cpuidle_gov_ext_data);
+
+	if (!data)
+		return;
+	data->last_idx = index;
+}
+
+static int ext_select_dfl(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+				bool *stop_tick)
+{
+	int i, selected;
+	struct cpuidle_gov_ext *data;
+	ktime_t delta_tick;
+	s64 delta = tick_nohz_get_sleep_length(&delta_tick);
+	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
+
+	data = this_cpu_ptr(&cpuidle_gov_ext_data);
+	if (!data)
+		return 0;
+
+	/*
+	 * We aim to achieve function redefinition through BPF ops.select(),
+	 * so we do not use complex algorithm here.
+	 */
+	update_predict_duration(data, drv, dev);
+	for (i = drv->state_count - 1; i > 0; i--) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		if (su->disable)
+			continue;
+
+		if (latency_req < s->exit_latency_ns)
+			continue;
+
+		if (delta < s->target_residency_ns)
+			continue;
+
+		if (data->next_pred / FIT_FACTOR * ALPHA_SCALE < s->target_residency_ns)
+			continue;
+		break;
+	}
+	selected = i;
+	return selected;
+}
+
+static int ext_enable_dfl(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	struct cpuidle_gov_ext *data = &per_cpu(cpuidle_gov_ext_data, dev->cpu);
+
+	memset(data, 0, sizeof(struct cpuidle_gov_ext));
+	data->cpu = dev->cpu;
+	return 0;
+}
+
+static void ext_disable_dfl(struct cpuidle_driver *drv, struct cpuidle_device *dev) { }
+
+/********************************************************************************
+ * Register and init cpuidle governor
+ */
+static int ext_enable(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	if (static_branch_likely(&ops_enabled_key))
+		return ops->enable(drv, dev);
+	return ext_enable_dfl(drv, dev);
+}
+
+static void ext_disable(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	if (static_branch_likely(&ops_enabled_key))
+		return ops->disable(drv, dev);
+	return ext_disable_dfl(drv, dev);
+}
+
+static int ext_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+			   bool *stop_tick)
+{
+	int state = 0;
+
+	if (static_branch_likely(&ops_enabled_key)) {
+		state = ops->select(drv, dev);
+		*stop_tick = ops->set_stop_tick();
+	} else {
+		state = ext_select_dfl(drv, dev, stop_tick);
+	}
+	return state;
+}
+
+static void ext_reflect(struct cpuidle_device *dev, int index)
+{
+	if (static_branch_likely(&ops_enabled_key))
+		ops->reflect(dev, index);
+	ext_reflect_dfl(dev, index);
+}
+
+static struct cpuidle_governor ext_governor = {
+	.name = EXT_GOV_NAME,
+	.rating =	1,
+	.enable =	ext_enable,
+	.disable = ext_disable,
+	.select =	ext_select,
+	.reflect =	ext_reflect,
+};
+
+static int __init init_ext(void)
+{
+	int ret;
+
+	ret = cpuidle_register_governor(&ext_governor);
+	if (ret)
+		return ret;
+
+	ret = register_bpf_struct_ops(&bpf_cpuidle_gov_ext_ops, cpuidle_gov_ext_ops);
+	if (ret) {
+		pr_err("bpf_cpuidle_gov_ext_ops register fail: %d\n", ret);
+		return ret;
+	}
+
+	ret = cpuidle_gov_kfuncs_init();
+	if (ret) {
+		pr_err("bpf cpuidle_gov_kfuncs_init register fail: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+postcore_initcall(init_ext);
+MODULE_LICENSE("GPL");
-- 
2.43.0


