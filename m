Return-Path: <linux-kselftest+bounces-40439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF7FB3E646
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F62B165CF3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B97338F44;
	Mon,  1 Sep 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AQVSptoR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012061.outbound.protection.outlook.com [52.101.126.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E691C27;
	Mon,  1 Sep 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734988; cv=fail; b=YmLXC41vfQLjbiX0gVtw9umgyH3U6yLZ1KzT8vWZo67w2FMLqXudPKqG/mT9lZpCkEN8hul2Tjlp9OHoSWjSXwwHOnECF0xdh52FiFHYh55JgGHK0l1N46dQ5mqspOYq+9N0BVYoDunOhc4RH3+dK/uZdCKYpeyd/MSBZqy6igU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734988; c=relaxed/simple;
	bh=p8yXwXQCcE5UYxmOZCda1bJLtUztfCiGZR1UbxBrjps=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HylNKt2rvCPe1RTP704UdfKqRsS8toUQqgGYM8rpvEcHUNQgAZLleFyeLBmag48EuMmzCu2UClvWb56bPutB+4LLzQEml/3rpEf9y42+fy66hhq0PfN/9la329Pm5hxdKVXh8nY8V4MmbVeTBABGnx+flbRWYjZArsFdFSYCbWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AQVSptoR; arc=fail smtp.client-ip=52.101.126.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhpZkHy3BUdrkt1CnJrcmb6J94GailOSkwuguQQikAmPj69uRAKzBt9IWrZkrSgUXra8XQf1e+A/ZRYRXS625wJOIOo0aY7H3T529IOdsZlDm2YLwfxPUCLWDtVuQ1gbJqTmu08k5aAzn9rUeHKeFgD1kqijg2a9m2L3TGXITFWlGxYIh+419GRTxq6wVboNgWJuUnQKIJUzldgRCCJpUswFdGXble4H2wKdePRH0PvNPRdIzh46A8QElVW6nzIoLc/ThbowYXAZiXrgjZABu6ASA9SaCRT8Ujhj6Sk8a7OkfjCUN8dagXBY6kO1vJQnegMlGQeRy7ILzEnEyHXvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz97yj3r7qeHQxOsHcGh3Q3FnomQlk4VBssm45mZFK4=;
 b=iFTCDmDXBmrUjgvSTaNULOoIj+dFGZYt+ZgRZYlM4IkPtZG4eBmIYIQslFZQAxiRu8i+nA6yWgE7Hcvuu9nyE0EShwt6csQwwW1IGg0Y9AtsCXOK7nuEgSC/M4QMJonFhM17+I7UrmuZ5t3n/rcb49tffW0DHZTK5IlZTiM7XlB6QTILH6Q6sJY2BtpkPTeA4ux9B3ltYi0rS1tWFdzln1Lbdc4omBRq2R3jWsamHXeraWnsL0JGpzggeTCodBjlbtsYzIBY6mAMlVo3THNz2anQJ7utsF8v6e9FSZAI6D5cWNxmCEu18IwCSU5vjpOkbk0vqa4zGv0Rweb2yu780Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz97yj3r7qeHQxOsHcGh3Q3FnomQlk4VBssm45mZFK4=;
 b=AQVSptoRVrrr5N/EOTf33gL+LjrvvTy1A3n23pj3N5XQjRep4XGHZLI+5F0y174nNmA5Mq6S8N2Fq1ADchHiAULIjvWcgWsOcDmb0bObzzk+Nje8HNM7fMyH+KXC4waG383rTzPHZRIxS89nZWdEOEgFxcG+dCqN0cS5LSRVjLR4stlN3LiSWSusUlTY+60HFuE9uqVJhFl5YhVwEM3tOwxb6JUZGmwYXM/JuQ0FivqY0hUwdP44alEptrLWgWjRMivARkS3doDIWAJZvU3j/9N0gZjphkxUCQBcf54WARCAv/Crt9vBqNEb5Z9C8nIBmQ0PUkop9bjoBQ9fRrQAxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by TY0PR06MB5732.apcprd06.prod.outlook.com (2603:1096:400:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 13:56:23 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:56:22 +0000
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
Subject: [PATCHSET V2 bpf-next 0/2] cpuidle, bpf: Introduce BPF-ext cpuidle governor policy via struct_ops
Date: Mon,  1 Sep 2025 21:56:07 +0800
Message-ID: <20250901135609.76590-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: d59a0a04-9555-44e5-1a71-08dde95f5491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXh6dy9ybjlaakVKRURKQTVWMXBocjJJajlWRi8zNTFDN1RPVkdaQ2x6eVhI?=
 =?utf-8?B?Q2p5TzlYank3dlBocElFS2dMU2xodW12S1dlcnZlUVdDVGUrZVVjM1MweklO?=
 =?utf-8?B?dUdLYm9QVmpiWlNWYU5TN2o0Z3JSZStMSExPT05RZlV4UGM4VnFoYytLMExt?=
 =?utf-8?B?dHhXRE1ncHg1ZndtaDZ2N0dJM3pHSkhBVC91VlNscjhvS01PYnRoYmFYOUc2?=
 =?utf-8?B?ZW5sTmhEWEE5TEFJYmgxTXlhNEo4elpManpFeE5VL2t3R3ZEditiZXZUTFkw?=
 =?utf-8?B?UFd0U0JmSTJ3VCtIQ3U3TTlxdWN5OC93ZXlWaUJFZDNXcGpEYms1NFVMWWJU?=
 =?utf-8?B?UjIyaUFhOXcwNVNIK0gydUl4ekxKK3UwMHpHOTZVWTRQZURBeW41bUEwb0oz?=
 =?utf-8?B?OW9adHRvcFZ5NTJVa0tRb0huSGZSaXF4UmRLZDZvS0x4V2dPY3R0eHZ2Z2pN?=
 =?utf-8?B?ZEZhS2VacVdjc00xZnNvVnBqdlZuUDlUb0NVZlZ1WTcvU0RJRmRXekIvVWYz?=
 =?utf-8?B?NHc3Z2Ywa2t0WkdCb2ZVWlBtSERkQzI0blZHdjBUMXVRQ1hGR1puU1ZCMmJU?=
 =?utf-8?B?eHpCSlhMWFVlTkxtNGR3RytlWUhrOEdmQjJXbTN6SXJNWGEycUdadVV1T3Rp?=
 =?utf-8?B?aUNNZ3AvK0w0T0dkb2RzaHMxN2JQZkM3SVNtcjdSZ0JlRXFla2VqZzYyK2dG?=
 =?utf-8?B?RDVVWlBkVEE4Z1V5bXdDSnFxY1BxaDE5bEdGMEFMbWs1QkhBTlpJNmtnYmxh?=
 =?utf-8?B?RWhxV1VSdFM0bE1aZWVQSUQrUE9nY3FaeWdhTFpNY0UvM2tuR1pSUzJKSUg5?=
 =?utf-8?B?TzZ5VFR5M1ptdkhwREdLN2RMWjM4MzFRdUt3cTAzbnQwRENNdjZCblMvaUtO?=
 =?utf-8?B?UWlleFZDbjhBYWtsSnZPcGNsS0tVb1FXY3dLQ0JtY1JxQUlxQ1Z3N2lWaHdl?=
 =?utf-8?B?T0ZWMmR1NDNUeUJib0hrWVNUcXJKRFBkNC9CeEd1ZTRucXRoY05DcExzOTVo?=
 =?utf-8?B?NkZFbXRJb2ZyWk90TnBRL2hUSy93YzF6WWdqMVdPL3VCeG9YYzFGQk91dU54?=
 =?utf-8?B?VldNL29SaUhUYmNlVGcvakU1cDRvWmJsdFdqbElldCtNd2I3OEZRSW9BMjBl?=
 =?utf-8?B?UGZJMFZGcmd6eEpVdVNBREQxaGdjdm1JSE53a0ZydVFuMHc2ODVEcXZoOHdG?=
 =?utf-8?B?cW9hM0x3V05RNGxoUWFuMmRhcW9JQy9KcThjQ0xEQUNmOVFUVmlBdVNQcU5l?=
 =?utf-8?B?V1RIOUlnOW9PM2xpcmliZ2RtellNUVI2eTNYYytFVkZSWm1LZzVCQk5scTJC?=
 =?utf-8?B?bW9iMDFjNHZqRi95SUw4QWRGYnE1L2tnZnhYMXp2NnJmN1JZT1pITjhBaTVI?=
 =?utf-8?B?Z2kwS2RrWXJkcWZuT2tjUFZlZWJMaFRYN214S29Hb0lPOEpKTkR2VHdyUTF1?=
 =?utf-8?B?bVFDU1VDNXJwbi9PL1JIUlJ3OUs4T1NJbXorWGtXa0EwNzJtQzlKV3hiTURY?=
 =?utf-8?B?N01LVmprU0tRYzllYTVNdTRuYmxmSnd3cU1ucnFCNHZuK3RXU2RxY3R6emhn?=
 =?utf-8?B?NHBrakw3djh0S3BKQURta0VhWUNBZXcvSDJXb1d4WkRRMjR4bnF6N2NsOHFR?=
 =?utf-8?B?QlRNT3IwVG9kOTFSclkrRk42YkFXc3VyVm03UElhRU50cW1NT1RFNS9kdFdK?=
 =?utf-8?B?OFBDUDFJRVVLMzNwVE5DMWxFejgvRDNCazNveFo3Y0ZXaURmc1NiQi8yNmN4?=
 =?utf-8?B?eW1ZS2ZkM3dSR21tbG5RTEQ4UTNzZWlWZDM4NjA2Vnh2VFpveUdKSExuT2Nz?=
 =?utf-8?B?eDBHSWk0TjE2LzhvbVBiaXBTcmpqNlZuRGF2cm1mM2c5T285OUhQbUlWbkpv?=
 =?utf-8?B?eGwzcmo1NTdxR2Z2a2xwQjhBQll2TlhINndJRjM0QXcxSUU5TkxBZHVqT08z?=
 =?utf-8?B?VThXVk1jYXFoOWNoa0N3VEFZMCs3cTZQZGV4YVVlNUtxM1BTUXBTRncrTDF0?=
 =?utf-8?Q?5ahdP21iLmo8asb/DTWN/fO3yTc2Tw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW1XQzVJRHhOQ3h6UGUveGxxNC91UzRLUHF3aDFYU2FDdWVvOGFtY0NneHcr?=
 =?utf-8?B?QVJTaWhoQzhWL1VkVGFvMW9GbGJTVkNZM3EvRDcxWERCa0srSWMrSmFTOFQw?=
 =?utf-8?B?M2NPR2JKa3pEcDVUNjA1RVg0d3VUR2tvVkszbHdMRkRzaXJoOUJWR3Q0MkpV?=
 =?utf-8?B?aCtkMHNZMFpkTzA3N25EV0Q1UElvTXJMb0NndW9iSXFSby9CMzBaVWZJSlZL?=
 =?utf-8?B?UzBRLzZSVyswRUg1VlRZdUpPVkFKamQzbkVpTzdvVDJxcWVxR2pUNFhGTkh6?=
 =?utf-8?B?WCtEdGY4aXNSUlBiZEtnSVpWOHlKMWFGRGpzS0FKWm8vdG9zUURMS2paZkh0?=
 =?utf-8?B?UkR1QXBQMHJGcjhIUzlXVUExWkoyVkVlWmhWZmtQalRsSFZuZURzellNbXZp?=
 =?utf-8?B?bWgrZjQrRy9zUjJTbStQdHhNTFNZVFltclpLVUNIeU9FZzh0Umc4OGtTY3pr?=
 =?utf-8?B?THdYdGN6OVFFSWZRT0lyWm11Y2VRV1NsZnRJSlNwUmRReFAxcHNjaXlEOFdl?=
 =?utf-8?B?NitjeEdkR3lITWpnR1FPbGczaWpac0g2dTVzL3R4c1dVV2V5UmlDcVdHTDRU?=
 =?utf-8?B?VDFrODRhaCtJVW04V1VzcXU5SjY3Yy90Sm5jQ0RPZUtNTFBiYTZlYWxkZ0N6?=
 =?utf-8?B?YjIxMDJqSCtvMHBJTTAwQzY2a09weitaQ0FtNDZwdm81OVUzRFNadmpvWXRW?=
 =?utf-8?B?TGhFVk5PMWJTVlpncCtwQlErRUZrc1RRZTdFbG1HV1VMbE5hMkNEWTEydGdv?=
 =?utf-8?B?bC91Ymhpc3Npa0xLaWk3aFFWTUNpMThCUlk4R2Zwa21SRXVPdGR3T2NwNW5a?=
 =?utf-8?B?ODhjRkE5UE5ObmxBaC9lZkNnRlNZbmFQR0M1WHZaMHdQakN5UllCc2JIalA3?=
 =?utf-8?B?NXNMTTZqWHZLdkhORUJsditEV1ZWYWYzT0RHcGd0NmxyNnJFbWJtUHl2clZ6?=
 =?utf-8?B?b3JJVk9FSjltOEcxZUw1Q0hKclFQOTNYOUszNTBGNk5TYXZUbFU1RWVaV3VX?=
 =?utf-8?B?NEQyc3o1YWxlOGtPTGttamovS0FTQUtScEFkb09VRTduaStmazdxWkRycjd2?=
 =?utf-8?B?Y3FTbzJaWm5hWTM2OWFsUTlGNzI4aFhjQVJQMU9WRm1abTJTaHZ0YlhtekFD?=
 =?utf-8?B?MHVyemFtZW5LMDZOb0hrWmp1dnVUMmw1V0JpYkNuY2N6Qm0vOFpKNHMyaUNK?=
 =?utf-8?B?VWUrbVN1U0lLbHd0UlJVWFNuZnEyRWYvcTg4TTFHK2E4bThYMWJDWGIzMnhQ?=
 =?utf-8?B?cWFCVXdUdzNDU3VqZDVJWU40UW4rdnpLUkgxZ1RleDZBdVozTDJkSVpWQlNk?=
 =?utf-8?B?YVNRUUQ5UXV2aVZlbWI5T1UwMm4zU0xjYVp6aEdNeEJhaC9TLzhGSFZVRWJx?=
 =?utf-8?B?SWFsdm5ISnZJQU5tWExUQjZtMmQvNnZZSmhsTU96TnFMT3JPeGNaWSt6TEhC?=
 =?utf-8?B?VGFZWEQwajdQZHRxdmtBZVZ3bVZSaWlZK0NpVE5nam8xTmQxYUs3UWxaamtZ?=
 =?utf-8?B?VysvcHJiQy9OUVV4Vnd1d0hpeEwyTDlqQUhVU1B4UDlISlR6aTFMVVJ0aTBj?=
 =?utf-8?B?ZTVSVFVjMTNYR2hzeE9TVzAyUFJlQWJONG91NUVjN0poNHlYeEN1amQyQ3dR?=
 =?utf-8?B?Y0IzeWNJUmlvNVlWeUVOdzlUSU1rd09Hc1VkOTZLSkozc2JHWjkwa3loa2xN?=
 =?utf-8?B?RTBBRE1vVlJ2WXlxUlFzd0UxbktJMElBZGlPb0ZJakpaVjJtaUZ2bkt4THFX?=
 =?utf-8?B?d0hueWl6NG1hbkZlWERMb1lYL0grYzZkNkppUTlSdjZ5aTBxd3UrSWNlOEh4?=
 =?utf-8?B?UVQ0d2NJZFZYOXdGdTNUdE0wMUE3NndNUVVTTnZsQy9HaGJsdTAzYXBpR3VI?=
 =?utf-8?B?QU56ZnU1NzNZL1dCZVZTUEFIbDNTbkk2RzNmYzFlcFlQaDdsNFdhdHRuNVVV?=
 =?utf-8?B?VFdtcDZxM2lzYzg1UkVNMlViMWJsTTdxSVlGdmFxZzVqbVF0WHVYNDllOTl3?=
 =?utf-8?B?QVo1MVpyYkFyL2RjNUU4UDFqUisvTVZReDF1MlVEQUVHM25OS0ZyQ2hVR0RV?=
 =?utf-8?B?VVFzbitaMXlzZHdweHNpb2cxa0pDL0Z0aWcvNHNuQ1dFM0g4aEs2SUt0T3Nw?=
 =?utf-8?Q?ObGmb86V5T3Ct4wZkFhfqYzS7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59a0a04-9555-44e5-1a71-08dde95f5491
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:56:22.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQLzA8hvso2U2ObTxDb4unG5OAOKNNQFUVbppdRcAnPbP3vHFyYAxlUZxm2JpjJv6swnDbxNFqKBzKvhDWYyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5732

Changes in v2:
 - Optimized the logic in descriptions. (Song Liu)
 - Created a new header file to declare kfuncs for future extensions included by other files. (Christian Loehle)
 - Fixed some logical issues in the code. (Christian Loehle)

Reference:
[1] https://lore.kernel.org/bpf/20250829101137.9507-1-yikai.lin@vivo.com/

Summary
----------
Hi, everyone,
This patch set introduces an extensible cpuidle governor framework
using BPF struct_ops, enabling dynamic implementation of idle-state selection policies
via BPF programs.

Motivation
----------
As is well-known, CPUs support multiple idle states (e.g., C0, C1, C2, ...),
where deeper states reduce power consumption, but results in longer wakeup latency,
potentially affecting performance. 
Existing generic cpuidle governors operate effectively in common scenarios
but exhibit suboptimal behavior in specific Android phone's use cases.

Our testing reveals that during low-utilization scenarios
(e.g., screen-off background tasks like music playback with CPU utilization <10%),
the C0 state occupies ~50% of idle time, causing significant energy inefficiency.
Reducing C0 to ≤20% could yield ≥5% power savings on mobile phones.

To address this, we expect:
  1.Dynamic governor switching to power-saved policies for low cpu utilization scenarios (e.g., screen-off mode)
  2.Dynamic switching to alternate governors for high-performance scenarios (e.g., gaming)

OverView
----------
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

Future work
----------
1. Scenario detection: Identifying low-utilization states (e.g., screen-off + background music)
2. Policy optimization: Optimizing state-selection algorithms for specific scenarios

Is it related to sched_ext?
---------------------------
The cpuidle framework is as follows.
  ----------------------------------------------------------
                 Scheduler Core
  ----------------------------------------------------------
                     |
                     v
  ----------------------------------------------------------
| FAIR Class | EXT Class |           IDLE Class           |
  ----------------------------------------------------------
|            |           |              |
|            |           |              v
|            |           |      ------------------------
|            |           |          enter_cpu_idle()
|            |           |      ------------------------
|            |           |              |
|            |           |              v
|            |           |   ------------------------------
|            |           |       | CPUIDLE Governor |
|            |           |   ------------------------------
|            |           |     |            |           |
|            |           |     v            v           v
|            |           |-----------------------------------
|            |           | default   | |   other  | | BPF ext  |
|            |           | Governor  | | Governor | | Governor |  <<===Here is the feature we add.
|            |           |-----------------------------------
|            |           |     |            |           |
|            |           |     v            v           v
|            |           |-------------------------------------
|            |           |           select idle state
|            |           |-------------------------------------

Whereas cpuidle is invoked after switching to idle class when no tasks are present in the scheduling RQ.
They are not directly related, so implementing kfuncs or other extensions through sched_ext is not feasible.


Lin Yikai (2):
  cpuidle: Implement BPF extensible cpuidle governor class
  selftests/bpf: Add selftests for cpuidle_gov_ext

 drivers/cpuidle/Kconfig                       |  12 +
 drivers/cpuidle/governors/Makefile            |   1 +
 drivers/cpuidle/governors/ext.c               | 537 ++++++++++++++++++
 .../bpf/prog_tests/test_cpuidle_gov_ext.c     |  28 +
 .../selftests/bpf/progs/cpuidle_common.h      |  13 +
 .../selftests/bpf/progs/cpuidle_gov_ext.c     | 200 +++++++
 6 files changed, 791 insertions(+)
 create mode 100644 drivers/cpuidle/governors/ext.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpuidle_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c

-- 
2.43.0


