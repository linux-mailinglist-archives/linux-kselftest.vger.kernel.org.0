Return-Path: <linux-kselftest+bounces-36438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E912AAF772F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDED3B699E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2E2E9EC3;
	Thu,  3 Jul 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSwchaXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234832E92A6;
	Thu,  3 Jul 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552517; cv=fail; b=WJSse019QeEozqbJAjuyJ0Up/qh0OTxr3cHTEqiuS9FYwFi1t1qKYK8AY+F39u+EXNEqi65afZkFE1hVQHonqkI7GixVeIPR+181v+60nq04G5EKxrROO4byo71DuDy7YHA3MdFs06JsDqfK71ZJBwxKGLeH2KIEwQJWIMCrwKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552517; c=relaxed/simple;
	bh=/hNeZlAOCpG1NUvMbl6bFkiuPp9yxHh1mQzm91Lrc48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPo24NSdZqCLlYKLwQ+Ovigh9gfFHsrsAHwcJZunsATIfQL9g9YeneBy5sBC5/7fffDk602dnOK465Z5RIYOnKFMam5291IVcL7814NyfTSYokowFEtdkHGof43Bi/ZF1f0JMHCMNxSnZz0X6XS/OtbfyNNk+pz5L9fUhHlc13I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cSwchaXp; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fskhw8frOGjPY1OFZZN2F2ci3ALTr5b90nh4eIc6QZDSsPiSO1M8zN6VkNcrxpuGZOBDVpsTJVsjR9jdghdap+vybH0hqSswVL9xvJPfbxbOCzt0h5vFnW617O5H9LFJVZJGFr+oxBKVZGM05ZpHiohUUNW3EK4hU9aQlaDv6mo6BBKv15FeMwwbjI18TKJDHeF0MqCEcBrEbtGtz6vxvPX8hE2yGxXzP+bQKJYQj/y1yuu9pUkWQ5PLHsxn+LdhakjN4Xyi1tPlPx+Y3OSRFlXaLNCAbWvGcJEl3xjoZI8Q04oqC/WsjFl/l53JVGeN7CscKj1mbv6o+7+lG21diA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hNeZlAOCpG1NUvMbl6bFkiuPp9yxHh1mQzm91Lrc48=;
 b=Z4FguKprw1z7lq2YT6LkwKN8nJiwL1iif84CZwyWiX9Llw/vH0ZDitd1k/NAMTutV2plFsHV3eG6ii0aEpON9EuxlIfi4J7QRCk+hcUiZvVLQA16V92NzuFMewXNFt8E4/rdTrZb5Thv3C8X9BKo6TLNkpF8QiYadrIyhAQXa2QxMoDmz03mNBGlqogcaKMd1OwLcgp73/l0S/1fVsxFdHEJS4yazsnhrDkn+29cePgZtJFWL+zlf9d8UrCT+6O0uOWt9723TZr0GUrGEOlK6D55cksTnROeVYCkLqvoNTzSQUvwjAJCmsNqGz8iPdg9R3j4Vx6AHwwe247zF+K6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hNeZlAOCpG1NUvMbl6bFkiuPp9yxHh1mQzm91Lrc48=;
 b=cSwchaXpMSeWDdyba4UGSQYfVAUcclIJ168sboSvw/3PFA5kBk4OEocsR7Pr9D2LKWO2Q62KPE6dA5fD1MVcr6QXmfmy8W6lseD1tFyI/LElknq8MX62APdddqBgrEvZ86WV1AduHKkmr6i6bmDTHpKSvye6tmyAHzBKqBxsobevZy05cbGfVOW8wFwExhBLiYl5D8B81VJAS7yWLTi/E2EW9jV3/S5Wx2HXp2kzVeOLMjzHr71ITlsnY6GG6FjZjWd+JtsjzxN9sG2p/Oq+93tw+6KdoRpTaaBv7GwESW2KGE0mz3ojrCm+38WXhouIB0y1knw7lNJq5/nMuw7Lbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 3 Jul
 2025 14:21:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:21:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH v2 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
Date: Thu, 03 Jul 2025 10:21:45 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <788EBC0F-67CB-4EE2-883F-A55CD394EE21@nvidia.com>
In-Reply-To: <0e099baa-0a36-4ffd-821f-a7a4856fd52f@linux.ibm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-5-aboorvad@linux.ibm.com>
 <d73f0591-e407-4350-9ddd-dc05ff571a8d@redhat.com>
 <0e099baa-0a36-4ffd-821f-a7a4856fd52f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a29143-2f2b-4d1d-4c65-08ddba3cf3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWZ5SldxcEd0V0YwQUovMHp6MWFhdXBrTmdQcXd5K05LWDBsWEtTcDVWWDlB?=
 =?utf-8?B?ZE05KzNFbmxvQWFFZ2ZYTWJEQUJmaSs1SXArWjdhTVlROXYzeEZ1bEI2WFBx?=
 =?utf-8?B?Y0FMOHdFam1yaW5CTVUxTFpIQlBDUXdxRXBqZGRiaFhJOHROenNjclQxbEJ4?=
 =?utf-8?B?Sk84QzBiSEk4VGdGUFpLYTFiVlRueWdIRkozU0RveGp2R1dLTDFSeVJScVM2?=
 =?utf-8?B?cGoyOFhEcXJ0eERqWkZxeTIxeGcxSVY0cmFvaGY3cDgwVHZyb3FxOWx6Y0px?=
 =?utf-8?B?VEdEVzJid3d0UVZqZzRGVzg3R0M3UjBMa2hvY3ZoMUlacnNuWUJRT3ZkQ2Ri?=
 =?utf-8?B?c2g4U2pSOU4zUnd4bktkZkJ6OWJaSEl6Znd1UWh5UkQrMTZmbFBEQXNwUVE5?=
 =?utf-8?B?cmg0QXluVWdkTG41RFdXcFFGdmhmMFc3SmlNNW04b0d0ejU2NVE2czhvTlBF?=
 =?utf-8?B?d1J2NXMxbUF1RFh5Q3NaRkZzNEgwVytMOEx6bC9zMUFiR2NJWVJ4QUhRMnlD?=
 =?utf-8?B?WEhRRjd3SFN1bm9lRy9NdDRpSFlUbG12SFlIMncvZnNSd3NjYmt1NXJmbGlI?=
 =?utf-8?B?QTVmZU1ETlRJOHNWc3NrbncydkZrQzBmUVdCdGIwOGFXelhxcWtMMTVDc3h5?=
 =?utf-8?B?ZmJLZGhRZkxLTTZXQ1hRU1dzY1BvZXNHS0xEN1MrengyZWYvNGdJa2hTRUt1?=
 =?utf-8?B?bysxdFU4VlZWV1NsUWRpZmFWc1VFR2NZYitSUEJhVXJUSTBZQnlOZ2lObzlx?=
 =?utf-8?B?WXRCcVRRR0N3N242YlJ5YjBqcjFwMXRrLzZhVXI5aEE0ZC9FSmtOWWVVS0tF?=
 =?utf-8?B?TzJvVzdyYkJJT3BMUkgxdUUwMlpZUEZheGExeXRBVnpuR04xTXVWT3FWT2Iz?=
 =?utf-8?B?SC9seG11bDVFN2s0N1lpQmpGK1NEcC9DTElFYkc5azFMaGhpMVE4cnBVMmtQ?=
 =?utf-8?B?TUJnZFlYTlhZWG9sRk90RG05VWpLUTlaN3RIWjJWTWljYS9OR2xVNktnSEpI?=
 =?utf-8?B?eFpDQjlBUjUrQnRzaHdVWmQ0RXZKTmkyTC9sRlpLRTc2dWJWSkM3NER5U3lo?=
 =?utf-8?B?SElUQ3YvUk1kTXZUWXBHZ2M5cDFPdUpBTkl3ZWdOVlp3OEpaMVlLYUNwbU5x?=
 =?utf-8?B?WHNJOW9aeDZMcVE4U3NPelRIZEtBU3BxeTZPQjdFOGdyRUJPWmZLV3k0eFJY?=
 =?utf-8?B?Z0l5SUhYRmtHZ3d2MGVIQzYvaWtCRGVITDJzNTJZTHY2bnJES0tDQ0RUYkZL?=
 =?utf-8?B?Vk94T0JYTmtaY2dLK1Nxb0RMU2tLZkJ5Tlc1c3FMNDU0K001ZkdnbHhJSGkx?=
 =?utf-8?B?RWR1ZWtIZTlzWUMxUThQNEdSdXc2ejZBbnNHR2FxTyt5Q1k5TFpTcVQ3RVV3?=
 =?utf-8?B?Sm80QUh4aWszdmpIQmNzNWZCVWdSL0JxODF4NUxQNEVVeThIQU1Jb0toSUw4?=
 =?utf-8?B?ZDhJSWZhYlFhNVhEMmVFYUZwNVJCQmE5OFBVMkRlcElPWVh5dDRuNlpGQTIw?=
 =?utf-8?B?TGh2eXE0a1VnWjk0WjM5SElTaytMdzJWcldwM3ZDSVB6Tks4Q1lnZkVzTHJH?=
 =?utf-8?B?dzdRbjNBLzNYN3E4RjBWZDU0OUVkZXBRUGtQcFE5a2Rud2ltTHgwMFB1Q3N3?=
 =?utf-8?B?SithcUxNdUZlT1lzdllOcUtjNWJYWks4dDJNdzZTbmRKNEFnNnFvUXBRUHR4?=
 =?utf-8?B?cUZHSTRoSlg4SzA2VTduM1AwaW51S1pJaGNKZERFdnNHMS91OGY1V3NhNjUz?=
 =?utf-8?B?c0w0Y0M4OVRFVTlud2h3UDM5R0w1WjE3WUliZ3JuT0hkTkdreDNyampCTXlT?=
 =?utf-8?B?eWs3NWJVbXMzcUZUamtxb1NDRmFoWUJpZU1UaTNyeWVrUkxaL0lWOXo1cldR?=
 =?utf-8?B?WDYrODV4bDFKL2MzdHNPZVVjMVFkcG8vNnNWZEs5VHF6bVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURLRTVQQjJMY1RtK05Gc3pCd3dtR3JSVVRDVHpwSm94aWllRHJ1OWRKMExz?=
 =?utf-8?B?dTNGai85ekFQVDVPTjk3TnlQSjI1elpCV2l0U21uRG1BazMyRmFYSThCTHVi?=
 =?utf-8?B?Sm5BdXVPT29WZjNIVjl0V1U5V2VsS3pyKy9KWjkyeVdjVTE5TVNUL25TMTV1?=
 =?utf-8?B?bkFhRW4ybkdxdFl1RDJwUG9BbHkvSWYzV1VSU3VsZDhXbitITFBGcXJiY0pR?=
 =?utf-8?B?OGFoVndGQmRQVTZERTMyR1AwYXk1Q1dlWFNyK2JsT2hncWJ1L3gxdE8yVWVH?=
 =?utf-8?B?ZWNvdHJhWHhIYWFsOEJyYVNTU3lidStPbzVBaVU4bVRzcGYzRVpwSzMzdnk2?=
 =?utf-8?B?RXZJMUNFbDJnZkRjU2V6SXR4YzdoYUlZMWt3NktUL2svNFVVOWZWVDA3QjhO?=
 =?utf-8?B?aVl5OWVPZ2NETVlVSHBHS1gwdGk3MThWN1U1SW1ZOVlsbGNpdUpHTitaVk9q?=
 =?utf-8?B?Yzh3bnVFeEx6SHZad2swb1lLMlI4aHYyT004d09nWG4rZzkyQk1jQ3QwM1Fn?=
 =?utf-8?B?eGJ2WFI5SXlMdXlXamlCSGRDc2YzdDRyTFdNM05NangwL1Q0SUUyaHJleDVJ?=
 =?utf-8?B?c0ZoT0RDY1VhazczTWJ3VlJxcHpYbmp0SlEwbFpZU1hGYU9ScFFVeFYzcVZO?=
 =?utf-8?B?T0ozd1FqcHFvZkcyb0IySnhuVmdtTmtjdXpLd01TVys5VDREWE5WU2V1SVI0?=
 =?utf-8?B?WVJ6NEE2NUo2MzVsY3Q3ZTRLdnFZZlppbFJDc2FVUlhSbVg0RTVaVVRRdWFZ?=
 =?utf-8?B?VFg3UXdmc1BZLzltOFBUQVlCODgyMlh6bW4xeFlwUmxFREwrUXY3aWxiYVJs?=
 =?utf-8?B?VDczTXd1Vm1uUHhXM1lpNjgzYktIbW9PVGpheSs4b3NZV1JISHh2aDdWWnRZ?=
 =?utf-8?B?NzJqZlBPamVkYWJxVWdrRERaRDc4T1FZeGF0QXBCOG9DTzgxaHk2NGhEdW9y?=
 =?utf-8?B?TW5mZTVSU3RsK2RtbmhJamtrRnk5TlFWME5lSVlaOVJ0aGN4MVVLRy9JUU9Z?=
 =?utf-8?B?eWVmVHpJSGRDTjVDWUNPUFNFcXBSMDA3QkNzbk02NHpMZnpZMDJrL1M4Wjlr?=
 =?utf-8?B?eTZFQUM0QjI0Yng4U2hpdXdmTUlhY1hlcTdWV3ZkVzBST2lNZE1TaGNWUnQz?=
 =?utf-8?B?TGZsSmxiaC9Ucm1OOXBnMHFWVTI5VWVyQ2pRWWt3SW1EdG9WbDZacFlObkZy?=
 =?utf-8?B?U0JVYVFYeHQ4Z21WdDE5RFd0ZDdmMk90N0ZTSVdGeUwzQ0Q4Tk9YVEpqYyt6?=
 =?utf-8?B?czZpOHdKVGtHSFBRSDNNSDcvVGUzWjg5MVRlc3NZSGxDVi9OQUZaSk55Qkp6?=
 =?utf-8?B?eDhwbkZqSmU5NHBFbTc3RThid3hTWGZoV2dHUVA4eVYvRzkwZVI4ZHFoQ2Zz?=
 =?utf-8?B?QjlmbzFVL3BuRVNqSFQxVjdWOFg1WnpmSDlVaGNIMUZWZXF4OThjSElDSUgv?=
 =?utf-8?B?c2F1MWpYaW1aWGt4cThhMUdLT2ZoZjRrdWlzWXp2TTBQbWkzQSsyL2NDb0RY?=
 =?utf-8?B?N1NOOVFkRXZQZzMva1J1TjNMeEpscWVIZXFkckNhdUppTlRsb3dSSDNRcVNo?=
 =?utf-8?B?ajhoOXNZUlRDVDhzTjhMQ3hnMTB4RTVuTEF2V0xNSHB2V3ppVHBPZkJkWlcv?=
 =?utf-8?B?cXh2QVFKbVlvNWJ2KzFNQ2JRdDJZMWtjZXBTS3piRmtZWWdDdkIyUUpsYTRY?=
 =?utf-8?B?bkJpMG16RTJodHJ2QlU0RWpXbW5tRFFkYjNGMmV1NWY4ejk0VmxOZUhtMHI3?=
 =?utf-8?B?T0VjMU54Z2NpUTBpNFJ2S3h4TnJZT081VHZYZlB6TmR6NEhnTEJBUXdZSVBx?=
 =?utf-8?B?WHh6MWIyblFuZ0JSL1BIZ0lmamNnL0hLZTVrN28xeEs4UXAzWkg0eUV2RXRO?=
 =?utf-8?B?RStJS3ZFVWdRWitjbU82SnNiTDV3VGNKZ1k1a3FITFUzNVUwb3pBV0dTcEh2?=
 =?utf-8?B?UzdCZFk0SHBPcGFCRVB3RStXSjdlSmpJVWQ0OVFJMFNTQXM1YnV3UkFIZmdP?=
 =?utf-8?B?TkNGMmxVYlFKU0IvS1VlNFB6MEF6SFFHMnc5SlRsZ3pXNlRTTno0eCtLV0ZQ?=
 =?utf-8?B?M1BwaER1eFpXRjliMzVmRlROVXBZMTAyZ094ZUIyczdwVnZiV3QrNDNhUVVH?=
 =?utf-8?Q?b3ccqWUwWFnpJcn1J4KExLnNw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a29143-2f2b-4d1d-4c65-08ddba3cf3ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:21:51.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUEVQZWXKFzDRewSHJ8vR5VH+c2C/MPiBdnFuWYt5PjYpVBXt5BUZaYggVgXM1ol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

On 3 Jul 2025, at 4:58, Donet Tom wrote:

> On 7/3/25 1:52 PM, David Hildenbrand wrote:
>> On 03.07.25 08:06, Aboorva Devarajan wrote:
>>> From: Donet Tom <donettom@linux.ibm.com>
>>>
>>> The split_huge_page_test fails on systems with a 64KB base page size.
>>> This is because the order of a 2MB huge page is different:
>>>
>>> On 64KB systems, the order is 5.
>>>
>>> On 4KB systems, it's 9.
>>>
>>> The test currently assumes a maximum huge page order of 9, which is onl=
y
>>> valid for 4KB base page systems. On systems with 64KB pages, attempting
>>> to split huge pages beyond their actual order (5) causes the test to fa=
il.
>>>
>>> In this patch, we calculate the huge page order based on the system's b=
ase
>>> page size. With this change, the tests now run successfully on both 64K=
B
>>> and 4KB page size systems.
>>>
>>> Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for spl=
itting THP tests")
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> ---
>>> =C2=A0 .../selftests/mm/split_huge_page_test.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 23 ++++++++++++++-----
>>> =C2=A0 1 file changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/=
testing/selftests/mm/split_huge_page_test.c
>>> index aa7400ed0e99..38296a758330 100644
>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>> @@ -514,6 +514,15 @@ void split_thp_in_pagecache_to_order_at(size_t fd_=
size, const char *fs_loc,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> =C2=A0 +static unsigned int get_order(unsigned int pages)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned int order =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 while ((1U << order) < pages)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 order++;
>>> +=C2=A0=C2=A0=C2=A0 return order;
>>> +}
>>
>> I think this can simply be
>>
>> return 32 - __builtin_clz(pages - 1);
>>
>> That mimics what get_order() in the kernel does for BITS_PER_LONG =3D=3D=
 32
>>
>> or simpler
>>
>> return 31 - __builtin_clz(pages);
>>
>> E.g., if pages=3D512, you get 31-22=3D9
>
>
> Sure David, We will=C2=A0 change it.
>
>
>>
>>> +
>>> =C2=A0 int main(int argc, char **argv)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>> @@ -523,6 +532,7 @@ int main(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *fs_loc;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool created_tmp;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset;
>>> +=C2=A0=C2=A0=C2=A0 unsigned int max_order;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksft_print_header();
>>> =C2=A0 @@ -534,32 +544,33 @@ int main(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (argc > 1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optional_xfs_pat=
h =3D argv[1];
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ksft_set_plan(1+8+1+9+9+8*4+2);
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pagesize =3D getpagesize();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pageshift =3D ffs(pagesize) - 1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmd_pagesize =3D read_pmd_pagesize();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pmd_pagesize)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksft_exit_fail_m=
sg("Reading PMD pagesize failed\n");
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 max_order =3D get_order(pmd_pagesize/pagesiz=
e);
>>> + ksft_set_plan(1+(max_order-1)+1+max_order+max_order+(max_order-1)*4+2=
);
>>
>> Wow. Can we simplify that in any sane way?
>
>
> It is counting test by test. Let me try to simplify it and send the next =
version.

Yeah, I did that (ksft_set_plan(1+8+1+9+9+8*4+2);) to count different tests
separately and in the same order as the following tests, so that I could
get ksft_set_plan number right when adding or removing tests. Maybe it is
fine to just sum them up now.

Best Regards,
Yan, Zi

