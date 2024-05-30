Return-Path: <linux-kselftest+bounces-10940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA128D5228
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520EC1F222A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB87CF1F;
	Thu, 30 May 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JkyM3IRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C047404A;
	Thu, 30 May 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096595; cv=fail; b=XFGpyG+OMlSdJ8T7TOvYbw+OQRj7jXTNAPHSY5mQ99fVgfFxQDaPg0ka+RSG6/w6exTT1MxP/komXQgvxmmElonbo/Yz2Wv5HFhfVtyfOgrcJpDVJ+Oh9ArzMPhDVl2H3WoRiqqBQeUjkyStLkHSf7kb1AhP8MiW/Dq7a7Z1LxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096595; c=relaxed/simple;
	bh=Kvibaq2VSckIw5C8oI6lm0MOESbocxzSKnlMaG0tSEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjHRmH52ibQC08oxz4uMYv4BVck4MNrJoknZwms617xTLJjLzL3jA96mbViIwb00DXDdst6v4FkJEWXcMNsifrefnhMg6iqgwxqrV+Ln5YSXumhrFoHG/mRUFYqoABxU5Q3j3zacHzvhYAAFcx3kCq07Q4Kju2rVTa7ehUaT65Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JkyM3IRq; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asbzGAPAmIhnz667UNrD1haXsgOyho1z9H6kft7tIwEmK58zNoMRV12kRFgzoXeO5yCPlYd/KXlc7p1PYWhT2F4GjkUIlotEVjTFz6tlig4JXKVLnEC70TzqVrU+jYUXlA0WArlxqGQu+vgbGoH3vw9mCVily5fZDFaO20t9IwTYnABRDZhkYrlTph3Py9luyJoX3rpCA5q/B5kKCSKgjzZjpzGvQCBeqHApvKaZIRsfuwGoqIscXjzMoTb/uDTZq1nf8gYZTsE+Hjquyav1yDmIg+FdcPYHEk076WDyd5DX2AY+n8Bs5j70Ag71MsXl+j1VdaUiBvLx4F1Ohr9CtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyewkIDdGQoPPyRo7C7cECZvahqCeFjmTMFDmh/DdAQ=;
 b=VGJW94LYNspIXOaRrR2eFSB7h+bJUdtS41aP8mzZwg1xjfFZIFP55wWOGrJHpPbcwGWunTu1Y2mCD08ch+SHB9CgYdm/xBkZoniJeZ/rrB7AQ/SSbHIvWbzDxe/eP7R0JiHJuV62hC2SUyZi/eIXASnh6sZmcEF6etxQbnY6CaxRkHzQGweNSMhP22rjbCu5cqfkmxnhhnR/bGDwPPxohnNXiKqNImO4CevAFtnYZF5WMAp8N5L04ALkv3JZctynBNieg/yQOQdIfaliKXckCJg9fi9DVDMUNkejKIAUW2GgHYAsEvGjPDJxwnt6SJFUAVIaZ0I+sVVmfMoGGWERfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyewkIDdGQoPPyRo7C7cECZvahqCeFjmTMFDmh/DdAQ=;
 b=JkyM3IRqdIB9T9A9CSJzS1wEFValHSzqKE1ypmjB24VMe3SqSGCtRJVskGKcRqHMpiGUucGFvPiIjpvX+qIWdLQu9mt98GfF+89wh3U82P4+QA1YThBK5+yDvbgDa6iMoacaIfvoKs8yyAaFeAFS+lKfdeio4KvVcIqXGUQ+A98M3+6/OaJ4iO4/+7Zh+QvzJrWoUjtFMbcui5OOcTkojg/5jbY/5qYFMr1/f6sMdnYQHG7soIjCZkjmwcVRKqJMOwKEh2APLe59KRI0Ace8EnAr7DtMYXk8qZDo8VYBENDgHUBzhhJ3Eqqi306UH5Sj/lVU5aeOfiiTa1nBUfG9bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 19:16:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 19:16:28 +0000
Message-ID: <f0a1ca78-f94e-4f02-a5e0-ef9d610fac07@nvidia.com>
Date: Thu, 30 May 2024 12:16:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/futex: don't pass a const char* to
 asprintf(3)
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-3-jhubbard@nvidia.com>
 <94fe2649-8def-4f2a-ba5f-19ae8a4226bf@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <94fe2649-8def-4f2a-ba5f-19ae8a4226bf@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c43990-c8b0-4265-1d2c-08dc80dd0167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlJDd08yZWhxQmNoZzV2TjZzR3d0dFU2bVVLa1JEU1JPbCt1N1NBNFJoT284?=
 =?utf-8?B?R0NtYnZIa1NjVDlEK1A5WnJ5OTZyckRmeUVPb0F1SlBhQUFJYzlLaHpLaTdv?=
 =?utf-8?B?eko3M3JFTm02Sk55UmwwV09jNjhlU0w1aGhqZTZXYUp5VFNyOEx4U2sxZzZK?=
 =?utf-8?B?SnM3OEdlek1tNXJZSHZkcnFTUGlrS2xiNklUYkN0ZjFDVnJGVlZVN2xsMEZ6?=
 =?utf-8?B?cHExczZwVm15YmVmK2pVaWtNOHBPUU84b2hEQ3JJamYrUy84MG9ybVZKaVNv?=
 =?utf-8?B?eDAwaTBMbjhYelRnM1p1RzlsY3NkKzF1Q1Nuc2NjTDl2Sit5Zng2bHRhV2ll?=
 =?utf-8?B?REhudEVuYzBGMDlrM200Sytpc3EyYmgyYWVkOE5iTzV1QStQV2c1TE91V2Y5?=
 =?utf-8?B?L243NkRuMmIzaHVJKzRCZlp3a2lsTlkwbnVMM0M4OWF6QXphYVFHTWlRajlK?=
 =?utf-8?B?bXczclVpVjREK2Vtb0gvVGc2OXl1Z2Y4ZGtkUTk2bmJLVnFBTlZzRGVlTUo0?=
 =?utf-8?B?c1IvK2FGUEUrYm90bU5ZejVHN1loQ0t5MHNKVEpvTHEwd3RXbm5pRVJGVElo?=
 =?utf-8?B?YytyRlRCNDlHbk03dTNQblJrRDI4bjBZcFVlVW9wMjJ0MnVlMGNKcyt6Rm1l?=
 =?utf-8?B?U1gySndsZGI2R0hoY2svQnUxVVkxMVZuRUk3Q1U5dXpUV2o2MnQ0VytOaHVI?=
 =?utf-8?B?L1F4RXFmb2VSblZzbGhOUjlyNkxtS3MwRjlaYk1VVjZ3VFpJTWlFOEpRZytN?=
 =?utf-8?B?UkU4Sk05c3dMUTNVQWl0NU81cDdoTXVuSllyZGlSNVBRSE5hVXZTakVtR1dQ?=
 =?utf-8?B?QzUvOWw4LytmNGJlcWhHTitZSm5NSVAraVNreXVGSlZyWWk3WjFZcmxiSWxS?=
 =?utf-8?B?WDlaeVdTaXVIOGI5SXN6QUJiNC9LMGJ1czV0aTZDY0tzTkN3SVBVTzl5SnBL?=
 =?utf-8?B?WHRSRjg2ZjFxSTN6bzJ1Y1Y1dGZCS2RGQklSNFhTQUdqTTQ3RVRRRWJBZHRl?=
 =?utf-8?B?MFlJeWJHUzRNWXlMam9oeFA0MGlvNmI0cG5QdVZ0eitxaTdOMmwzeHc2YmEr?=
 =?utf-8?B?dk94N3NTYm92cy9QU0s4akJwWUxKb25rSGJlbWFKZFdYbDJJZ2JKTHpMOGpP?=
 =?utf-8?B?R0hDUndxajdhK1Nsb2ZmaXV2M1cxUU9Bdk1EdVpvZ2pESDBzSzNsc0w1MmUx?=
 =?utf-8?B?Ykl4Y0ZwTlo3OEtaUVFhTEJycU8vUlhWQTZLOEt2aTE2Q2hMS3BiT3VMcS9F?=
 =?utf-8?B?S29CbnBRZEF2N3Nqc2d4U1V0QURUanFZaTBBdmFVcjFseXNBT1A3RFExYXV3?=
 =?utf-8?B?WUlvK0dNcGhXUTB0c2o3Y2pSWlNuQkJyR3dSNnBocnVxZ3ArZytVcldGbXh1?=
 =?utf-8?B?RWJ6V3ZQaDB3NGhTelBWS3ZtWFNHandIZWErbDZXVkIwc0tGWm84NzZvTDhv?=
 =?utf-8?B?d1diYmpiTXVjTDJUbS9BN2daK0lZUlg1elRBaVpSa014K05hWk9oRFd6UDc4?=
 =?utf-8?B?dFlXekhZcUIrM1gxeHdTTDF3d2RxbkpnR3dTdGFtTDI3TnlDK2VrVmJhU2dB?=
 =?utf-8?B?SW9CUnN4OHZZaHY5NEFoNHhOUnZZemhoZDZhUEx5SHR2Y2tuNFpQQ2ZMZG9R?=
 =?utf-8?B?cURoaUJUdnhseWJudHAvWXFFdWNWM1d4c2cwTVVlbGlWKzJ4MUdqY0JIS2Qr?=
 =?utf-8?B?RXZsRERrd2hJckhpRFJOaFVReWpXemw1bjFKU3pid0V5WDh1SkpiVXp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW4wQmtSUWNJNVpwYThpRzhnRlozdDloSWhNNmJRdjE5azRwcm0zM3ZUeUND?=
 =?utf-8?B?R2c4QlJaYUtzaHVLUWd1V09tYUgxUVdmWEp6dUxNNTFyTFArWjVFbFdxWWlE?=
 =?utf-8?B?UzloN2lFRUtBcVZkVVFqV0QrcFh3MkRvNjFsWGlZUllqc1NBdSs4QlZuTXZL?=
 =?utf-8?B?dDhNMGVLYXZ6cm1WWDl4QzRhT1FxSWxOS1lyanpuVi9ZZDMxVWpyRFA5amxY?=
 =?utf-8?B?emJ0K2hYOTFuQkFmeEVvZ1k1N0dMOE4vblRDb25MQldncGdNOXRobkdVYmNO?=
 =?utf-8?B?NHNwQTl5Z1JpcENRMzlIYUV6Y2ZQMlZmejBydXU5SUFOeGRNZDR5UVpCNVpz?=
 =?utf-8?B?OE9LdVBWU0FER3Y0eStwU29KKzlEdDVTdldBaFk3ZWc0SVErSEZIcTNpTU5W?=
 =?utf-8?B?NkhUQVo3NEFBajJXL0YySXpDbFErMTVEdkxYSk1EWFI0Ym14WVBqdlA4aWZP?=
 =?utf-8?B?eTZCMlhRTEFLR1BNN3lDR3h6Z3RmeDVubzhCdkMrNXpqSVlTVElpcExraUs5?=
 =?utf-8?B?aXBYNENaRVZrL2pmcHlHbTZGaXNmM3F6aStiSnVucFJncFBmczhub2gyOFVs?=
 =?utf-8?B?S1daQmE2K1ZnWG90aVJCOVlobG50dzBFZzJLZXlRRVF5bEFxdTBSVGRCSWp1?=
 =?utf-8?B?U0cxRytJaEladjdCbEQ2dElQenZmVmNSSG4wRGVWa21CM0xOU0s1WElWT09a?=
 =?utf-8?B?K2IwWFgrQXNkdlpIQWZQMXEwSzV1aG1OQ2xnUkNhb3F3K28yenFSSkRuelpj?=
 =?utf-8?B?ZXdNbkJubHAzNjhNNmNRUkVYUzhxOHpJNW5mU3B5SXRsSlBYaHBuaWhLWkNo?=
 =?utf-8?B?bEt4eUhrSXp2K3kyVTN4cFJOejRGZXBtMzB4NjM2WjVuL0xNUFBMOGdWSGc3?=
 =?utf-8?B?VFBaSndFcXptRTd0L1cvcW5NTWwxQ3MvNjRlekkyT1BtVXBkbmI4NTR4OFJN?=
 =?utf-8?B?RE1zbUFDZlQ1d01pMitTeWo3amVtZDViVmJaZlZudis0YnVWNk1oRk16dHZn?=
 =?utf-8?B?RDcvZ1gxcmc1Z3p6Vi9pcWdzTjk0RW5ObGhtaUU3QTNEeEJLM2JrUXRjOWRm?=
 =?utf-8?B?QjFPc3orTnBoRC96NTFMSlFtbFVtZkVyRThaN284ZUx6NkVnK2UzZHVXRVJv?=
 =?utf-8?B?c2xPZUd0KzQ1bG1oSEZYakt0Z044amhBamg4bDVMazRXSjFUZXF2ZFF0alQr?=
 =?utf-8?B?QVlMY2M4aEl0djR2ZTR1SHBNWEI2TnUrUm9jeGVLSEdodDY2WHpDcFd3RVU3?=
 =?utf-8?B?Q3Q3Rlczdk9vY29oVWFGd0lFRENLMjlZU0FOUFhBT3ZjVE8xZVlsbjBxcnZ5?=
 =?utf-8?B?R2ZHWjZUNHZJUkhjZ3N6aTdoUlY5MUVKWEY2QlRZdlNZQUs0M0dwQitibVB2?=
 =?utf-8?B?WVlnTkd1K0JwTFhaUk53Z2dqZDhwUFRvYmxodGhtbitzSDJETWx4WGd4VUhK?=
 =?utf-8?B?L25ZTkVkNGIxTzBLWkw2bG1UQlFPNDF3d0RIL3l3RXcxblViNFd6RE5kZnZU?=
 =?utf-8?B?Q08wTVVDN21zWFB2cWxvenY0ZllLUU50RnJia05NdEZESjdORzFRcWsxK002?=
 =?utf-8?B?WWRNNmNvb2ROM3doTERIZWh4Z1BWek9yV1hWVXk3ZUYvazJjWUcrYnZqZHdZ?=
 =?utf-8?B?UUhBeTNXek9GdmhSRHd6WktiUEJrbHRLWlpkS0NPaUswdVZTTTlIa0hMQXl3?=
 =?utf-8?B?ellGcE5yVU01SEdEcTdqTVM2OEY3VXB1Zy9iM053Zy91TUVXaTdzNVlkbUVQ?=
 =?utf-8?B?K2RHbFJmbU5FUVRRVEx5K0NuVHNtd2w5VURwaENrUDkvZ1RGYjNsNXZvTUIv?=
 =?utf-8?B?WkVwY1RvS2pyVUpxdEZuTG9uYzZsZ1VCZDdKM1J4dGZGT1h1Y1lERXpHT0I0?=
 =?utf-8?B?MzdWRlgrQjh5b1k5a3hGT0dHek9JVUZOd0I4TWJHWGFmOGw1QXUvcitycmFs?=
 =?utf-8?B?Wmp4UGFITkRKajFoNzFmSzNycWhMRTZCeXRza0JESHcvZURJbGVGR0w5ZWNw?=
 =?utf-8?B?R1hPTkd0MEN3N05jbjBvY1IxZGJmcjE4VU8rU1I3a0hmOElTY09KNGd1a29H?=
 =?utf-8?B?ZDhhVGVOT01qTmxvWFR2c1ZwN1pPbE9CaFFZY1NvVHhSY3pObm93MmUzMkZH?=
 =?utf-8?B?VVorQ1NlN3hIMkFjZWh5WlBEWjI3blBzd0ZkSjRnKzFvdk16b1diOTVqU3I4?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c43990-c8b0-4265-1d2c-08dc80dd0167
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:16:28.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eoma1Ap1ujYpYjUCA7GR49zyZs6fNakvrjTdpRytX94Cys3DSkURgfp9o6iFQ7he65MYtfAus8IZaJ23LfqTIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

On 5/30/24 12:04 PM, Shuah Khan wrote:
> On 5/28/24 20:29, John Hubbard wrote:
>> When building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...clang issues a warning, because test_name is passed into asprintf(3),
>> which then changes it.
> 
> Please include the warning in the commit log.

Ah, OK, the warning is:

futex_requeue_pi.c:403:17: warning: passing 'const char **' to parameter
of type 'char **' discards qualifiers in nested pointer types
[-Wincompatible-pointer-types-discards-qualifiers]


Please let me know if you'd prefer a v3, or if you'd rather fix it
up, whatever seems easiest for you.


thanks,
-- 
John Hubbard
NVIDIA

