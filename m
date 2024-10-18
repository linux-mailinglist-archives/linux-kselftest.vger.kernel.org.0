Return-Path: <linux-kselftest+bounces-20103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0649A33C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 06:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6F31F23847
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D31714A5;
	Fri, 18 Oct 2024 04:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hI8h9iI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054120E32F;
	Fri, 18 Oct 2024 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225642; cv=fail; b=bQPDYmOp5jukEhCpMtPbjVjBNP47vVce6CyJ6dg3VPRNI6LuY0CCA79alKjPoQB5yYLGjRnrjz8uhXLULCCNgh4LEgq8aXC+bLbG4vj8YHYruzGH8h3hWxypNqmJ0l7aWealc7b8CkKhhfijwryuB13YJATX8S9J8sNa7aC6X04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225642; c=relaxed/simple;
	bh=4+rykKZcgJwRsuaPMTNVlmImoDrJLVkNJ8mauKbey9Q=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5RiD8iT91N+lE3GuHIf1+Z19y4V0tlYgYMW2ihKAijSeO1FgPjWdPjQfTSTDFLGZL35lzg19FQB7jKWjzCyMDpHc3iPuuFlfiNVdgyb30cSJaiiSbjngLkqECcBz8ZZjpRbd4+URMpVX3GyxXtlxFkmry2U08xI5rZhap9RF+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hI8h9iI9; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZREQjceHx8KRf/nI88QVUaEcA9uo8xk+ygN6cpq0nihyZsgAPZzK/zJVNBBTBC7SUn6h0BBAy2GrZY6QRtIvwyR1Q41BOP8csJVyoGw/JV+jsV0GqPrQ5QgRayYAmfs7MtrQ99NUXQg4LAW5u3bfdLTeDdIlvs+2UNiH5qNOc99+eM7eue0mSgSRnohojhOpqspR9i/XegwPt/I5UOHQhbwtcqyGuDyfzgLtPagoY/x12Gn8DSYoIVjKmpI5CWsAThfTtE/lzwIdE3f6sSCChOsRzXSIApa9lYNhRWxQ7C3fCM584stu4jcBh5ao98a3USAU7Lz4ndxg/ZRfDEI9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv9qNfWdmNMmQnxYnCfA642vpTZczoAPV/8cc5RQNa4=;
 b=QSFnmwH42WLVg1EEWeL+RfNkt/Ti6+6ugswySrOx2Rto5DenCMovvJRfQOzy5SX32TLaLC4M7WYN9ueGnyUxvS6psPXA/druXk5A7+dvS7T+MYHpxEkh7aBKQkj47APSqAqsNHMmkTTG8fxOeCXAlk5WjkDnDsAqtbfUXMz4Dy4njJjH/AYO7pJ0BQqk4FKPj0czlFila20KugqlVewPBVFFVqeXUJ3LgXcUf7UjLcVoPJyflNvihHyRGglqGxP+47HygHZ4O2FP9HnMI0nbEN7yfUXQeQdnzHfr4/51Y+hJWUJfFGNSZPm9B4VbjiR6VNf/kJz3bJ+ucwUrLa3+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv9qNfWdmNMmQnxYnCfA642vpTZczoAPV/8cc5RQNa4=;
 b=hI8h9iI9hWEJbcT9AmMWBD6njwEHVThLYeLZXZNqtZPdTbaCFZ0W3mpjrMv+4H+rq52HvWO7/d/6GpCmgElASfLcN2oHF7P3y9f3azPWgGRlGgcRxyDddGDth+m37fHZP2QCuebc2J0aZ63mBjY7XfbQnPHexKGd2RwegjGA50rH8lBgmJG+XK5MoIRPJUzdGEmpEi6pZnkcSuR94YvEqPAM1Kv4uUFoYQFrxA4qSgHnlVRnroBVAmxcp75ff8KAIvBFH+ZyVF+105k5cwk685t5fdzJVFFKSYHq7NhGhgjggJnNewb9VQNZrO7TeHo259QhTWJ18dwO6F5us2/3hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 04:26:55 +0000
Received: from IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12]) by IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12%5]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 04:26:55 +0000
Message-ID: <c900db54-d764-4389-ad9a-bc2be61eedd2@nvidia.com>
Date: Fri, 18 Oct 2024 12:26:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
From: Joseph Jang <jjang@nvidia.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "avagin@google.com" <avagin@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>,
 Koba Ko <kobak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-2-jjang@nvidia.com>
 <20240620193654d3cd1f05@mail.local>
 <c0db5bd6-8c6a-4017-911e-f3e01cd522ed@nvidia.com>
Content-Language: en-US
In-Reply-To: <c0db5bd6-8c6a-4017-911e-f3e01cd522ed@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6580:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: df388203-235d-4fd8-1d58-08dcef2d18f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXNTTVlVUEhxTHhKcnVUbDJEcGVhZmNQUnVUbCthallmZTdqbDhTVEFVc0VY?=
 =?utf-8?B?Z1Z1S1dqM2VlMmliRyt1MFFiRDBLKzA2YUorUEYxTjN4WjMzV0JMdWZCVHVz?=
 =?utf-8?B?OG51K1VpSDl5R3RCTVZhSWw4T2F2VWJ4VnlJYW1WWXdEYlJhU1l0bC9NMkJh?=
 =?utf-8?B?VWNZaUNmUlFIRjVLUWJyZGlUWTFidzlVRHBWb1VkVzJVUkdhZERjdmFlcFd2?=
 =?utf-8?B?b1diaFpPVUl3aVprSTBxSGFIbEpaeStDck5OWFYxaVFreXZSTWVUSEQyb2F1?=
 =?utf-8?B?Q3dqQlJRWFk2UlBUaEdYakREZ3hlckt1Um5vSytpSnlldU5JNFRhRzlMaHBM?=
 =?utf-8?B?TGYyWkh1MnU1dTNRcHZkYnhaWUgxMDRESmdHVGFCZ2N0QVM0Yk5nV09yYUk4?=
 =?utf-8?B?dk9uOEZyTmdCL2c0VzNoSWU5TFlrYTNuM1JKbVNiVFQ0dnpIUWwvcERoSEhy?=
 =?utf-8?B?bEI2aXg0TUZMc2lod1ZTUitVTUN4Nnp6SVA0YmRVSldySnpWVDdweHozckpX?=
 =?utf-8?B?NGhSZ0dzNFVZZzVhbDhOSFMwTjFZN05RVlFUMGdoaHUzUU9qTTVZUk42VFpx?=
 =?utf-8?B?bEpqaXgyQWVpcHBiU1dZUTRSRnFhcFlvdmRJZHNxZVpBWkUvektOMnkwRFlr?=
 =?utf-8?B?NTJEOE1ocU9WaytMYmNpd09xZ0RKRWZEVHNncWRnUFN2dFhNQ0xZRUtRMWpy?=
 =?utf-8?B?S013d0d5TkhjNUpwTWJuM3RwbmhuNEdhc202N2M1QVpPd3Nvd2pLTmp2ako0?=
 =?utf-8?B?TyszaytYT0NBVjZRNVFQM2E4Vi9mVVpKbkNtQVZOOTlFd0p0c2gvOFljYVVL?=
 =?utf-8?B?R1FhVk1vSW4xeVBaTWxYd3lmaGxNd0FjRkNsd1dIQ3llVFV4OW52ZTljWXpU?=
 =?utf-8?B?Mkw0RkZ3YXVCZVo5dWdVVWd2UW02VndwTnozWnRPdXNnL3VjemV1ckxwbnlx?=
 =?utf-8?B?bTBCOG9sNHJ4d3Vrb0YxMGdRV3BKZDB1cFo1ZHlORGpReDdwaDFsaGJXMGEv?=
 =?utf-8?B?ZkcvKzhrMzhESE1XVDJ2YysrZmErSDRJWGlndG4xbWMxbVJtdndzbmE5a1Jq?=
 =?utf-8?B?NGk4ZER0SDY1VnNTQVpWNnA2OE0xR3ZMOWRlRDVRSk9HVG9zMDBhR1hiaDBm?=
 =?utf-8?B?ZlJ0RGtKS2FSd0VHbnFNNlpkM3lYc2RvRmtoL0pabm9VanBRREVOS3g2L0VB?=
 =?utf-8?B?SGZWVFNUV1BPT0lOVjVYUGFhdTVGYWhxUDB3V2VUN2xTUUo5ZkUxaGtGYmtB?=
 =?utf-8?B?SkduaFlGR0QwdkJja3RySnhOVFlLREdtVzhCazZYRjVZcGsvdkZESnUrOWRr?=
 =?utf-8?B?bnRubmV6RHE2dHBzc2ZCMlR4empNMXNvMVNMMEw2RkxrL1drVW1XS3VqQTBa?=
 =?utf-8?B?Z05CdURmaUQvUlRBTXUvektHZ2orVmt6amhoNmdvSFBPdHJjbzZOcEtUbExL?=
 =?utf-8?B?bUpiSHdHRFNrckxtTXQ4RXdXUlVISWMvZkJoNnphRHFPS3AyN1A1SWhiZGlU?=
 =?utf-8?B?aE4yRHJCT1hBZHdZNkhOd214MGhDZHVhUEdveFkyMXd6UjJLNHRkTVhOWlhh?=
 =?utf-8?B?Q3RsdTNhNHB6eUd0MEZ6d0R2TXNtT0Znek9CaGNXYlJVcndaVmFuWlovMEsy?=
 =?utf-8?B?MmdHT1BEK0VOUEFBVytNVnpDbHBmRVE1K2l5c0MxVzh1SnVxRy9BR0xDSVp3?=
 =?utf-8?B?ajg4alE0T3E3cSt1eU1qa1pLUHJodHdxRDhCdi9jRFE0ckpFdVpTNC85SWpW?=
 =?utf-8?Q?5qM1A2gZJVe7+WqlMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTVwcytLNnJBY1ZRT0NFVlUrTmtUeHQ5cDh0c010ZERpMmIwU3haNkJ5V2Vq?=
 =?utf-8?B?TUtnZTFxU1BRdDQwUmkwbmNaL0VuRklhNUZIUXhZN0JvVFY4NnN6L3k2cExD?=
 =?utf-8?B?S1JKbkFZWWdRMm01a2lvVDROK0ZpT1FCWlJUUHdjT0EyTzhSYkxDaGs2bTBq?=
 =?utf-8?B?SXJjc2YwV050Zk8zOFNrNXZwdUd6ZGN1LzJrTWlremNBVEZKcXovNHoxUTQ2?=
 =?utf-8?B?L25penU1STRKM0xkSkxvK0gvV2lwQjNqSXBQK20xZUdRNTBPbERvZEpOYUxj?=
 =?utf-8?B?Z1pCTXBCbGRtOVNPMVNjRTl0eFRmU3plNjdUbWNpaUNEeTE5L1JwSmZCbHdj?=
 =?utf-8?B?UkxoRGxseG5UMGZES3NMQ2JScmRUUlVocXJaU3p4cklsT0UyT1BPZEl0czNO?=
 =?utf-8?B?TzVmL255enZtQ1hMVTNRbU9BbS8ybUlkTzJ0cldjSHlLbnA4NnBzTWxUU0NQ?=
 =?utf-8?B?aXNXZGxON2xBOWlmcWhJYnA5NzMyUnlXc0JrZHo0ZzRWSFE3WnBFclliU1lP?=
 =?utf-8?B?cXJ6U09QVHJZS3NseW5hTjZCbWt4QkljaWNPbGVlSmlzV2Y0RXRaeE1KbkdF?=
 =?utf-8?B?UDc2eVZIaGxRWEcxZUVNK2tzMjBhQ2MxNE1RQjE2MjJFVnZ1V1FEcFFIb1Bl?=
 =?utf-8?B?MlljeXRZNGc2RHR4Y3FDTVRwMkRwbzN2WnBTbWV4bDlsekhtMkJoOVZDK2Mz?=
 =?utf-8?B?MXFxdE1tdC8wTEQ4WEluSWdkeDlvcjhtWHBKbVRsUDlmS2NjSjRISkJsbEdv?=
 =?utf-8?B?Nkplemc5OEp4RE05UVd0SkY5YzZCVFErd3pUeUdzRjVxVjh2ZmhvaTlxN2NY?=
 =?utf-8?B?Mk9NUTFMdldIUHNuV213ZnFySHFxblR3ME1Cd0gzOTZYYWdWczVES2wzY29Y?=
 =?utf-8?B?cHNtNDlIS1g2NlNwZjgreWJabXBPSjh2ZlJJazkrbGJBeEpQNTZIVG9OeHV6?=
 =?utf-8?B?RkQ5WDdMMzRFQ3l6M1VBSXRaNW9MZDArVUMxQTRmWDU0aklvOWc1bkl3L0pL?=
 =?utf-8?B?NEU5M2dyV3BjWllKb0VRNWxQS2tjMjQyUTlOMFY3WXpjZjVXYVZQeFUySFZT?=
 =?utf-8?B?b1RpRmFQNksxYUMrakcyYWQ2SWIwdXNSSVZyMzgyWk5jbGNTdFdoaVZZS3hS?=
 =?utf-8?B?aVZxVjVqMHFHREl2cW9uaHN2c1BrSzlicXhIbTJ2UFJxUHpCOVhOZ1poTlIx?=
 =?utf-8?B?WXZ0MXEvWk80S2Rsb0JMV0xVK3d3OHBaK2NWeW5RUlRFSVg2V212M3RPbWxp?=
 =?utf-8?B?SWVNMVMzTUxJekpvTjVqNFdkZGk2YlFJK3hXSytxdCt4UWF2QThieTBOYzZk?=
 =?utf-8?B?UjFIdzY1cHRjUENFQzNYWVlkaGk1ck9lWnptSWpjVjNnSnpnQ0NaWTdzZWNK?=
 =?utf-8?B?eFRrMG1OZkVHVm4yWVN3OEFpWGIwTTcvL21rSEJHY2VISEhmY1A5Nzc4TWpq?=
 =?utf-8?B?b0pUN3ZVZmxVMXJ5ZHlVZk81MjlEMEZ6RUFzdXVDQVZKWW1ROEFzZWltVmhj?=
 =?utf-8?B?UHB0TEY5eE0vaVNEVnVKeWsyRDBxdUlBK1lZWkkyc09MTXJBdTNxWHVJN3lj?=
 =?utf-8?B?WVNCNHpLWWt4VThWRUlWRit4aFBVdXhUSXQxckNIWUtUN3Azbi8vakdkRHFF?=
 =?utf-8?B?RUpJMXJIY1RocVJKRVU1SGR1a3dQMzZES29KVmJzN1FDU2ZqSUo3cGdKUFdq?=
 =?utf-8?B?WjZwUi92T09GamMrVzhua2cvTnQxTVRxMldSYmZLc1grWEd6SXdWcnc3Tkho?=
 =?utf-8?B?THRRc3RCbUlpNHRxVFIzTVBhRVJkTG5iZ1VKaVoyQ1BtbE1pS2pobWZ5Kzg1?=
 =?utf-8?B?bW5yOFVmWUJyck40Qi9EN3N3R2RTVXh5bWNjWng0VzQrTkVwSGd6RC9nVTZr?=
 =?utf-8?B?M1lTQWlYeWFLSlNmTmxTSWk0TEJLTGdkbWREb3Z3bVVOMHE4M01HM2E1TG4v?=
 =?utf-8?B?L2oxUlZyclFiMmtZMzJxckVJQ3NrazRaaDZ0U3BIZU82UDVacFltOWI4dVZB?=
 =?utf-8?B?ZVNVY0VLZ2JPdEczcTUzT3laTHIvK1JnNTV2Z1BKQzNHRElxUWhOdTA4bGEr?=
 =?utf-8?B?SVRLeU5hRzZ6bjRSSkFrQ2FsaXEvYWxTTWtLYk1VQ2cyL0lybVpSWjhnNzQ3?=
 =?utf-8?Q?jo+bnbB1fEoLYR8tnoURCEYP7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df388203-235d-4fd8-1d58-08dcef2d18f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:26:55.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3lgF/w6eONW9HaqqgIlBKVIpax2j7GuwBhk8JztBcpjzZT61cCogcUjKvyPrQ1danDZDt6IGP5YmnnNqH3ztQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128



On 2024/6/24 9:43 AM, Joseph Jang wrote:
> 
> 
> On 2024/6/21 3:36 AM, Alexandre Belloni wrote:
>> On 23/05/2024 18:38:06-0700, Joseph Jang wrote:
>>> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
>>> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
>>> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
>>> code. This design may miss detecting real problems when the
>>> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
>>> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
>>>
>>> In order to make rtctest more explicit and robust, we propose to use
>>> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
>>> running alarm related tests. If the kernel does not support RTC_PARAM_GET
>>> ioctl interface, we will fallback to check the error number of
>>> (RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.
>>>
>>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>>> as optional")
>>>
>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>>> ---
>>>    tools/testing/selftests/rtc/Makefile  |  2 +-
>>>    tools/testing/selftests/rtc/rtctest.c | 64 +++++++++++++++++++++++++++
>>>    2 files changed, 65 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
>>> index 55198ecc04db..6e3a98fb24ba 100644
>>> --- a/tools/testing/selftests/rtc/Makefile
>>> +++ b/tools/testing/selftests/rtc/Makefile
>>> @@ -1,5 +1,5 @@
>>>    # SPDX-License-Identifier: GPL-2.0
>>> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
>>> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
>>
>> Is this change actually needed?
> 
> If we didn't include "-I../../../../usr/include/" in rtctest Makefile,
> we may encounter build errors like the following because rtctest default
> look at the header file from /usr/include/linux/rtc.h which miss the
> definition of struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET.
> 
> rtctest.c: In function ‘get_rtc_alarm_state’:
> rtctest.c:94:15: error: variable ‘param’ has initializer but incomplete
> type
>      94 |        struct rtc_param param = { 0 };
>         |               ^~~~~~~~~
> rtctest.c:94:35: warning: excess elements in struct initializer
>      94 |        struct rtc_param param = { 0 };
>         |                                   ^
> rtctest.c:94:35: note: (near initialization for ‘param’)
> rtctest.c:94:25: error: storage size of ‘param’ isn’t known
>      94 |        struct rtc_param param = { 0 };
>         |                         ^~~~~
> rtctest.c:98:22: error: ‘RTC_PARAM_FEATURES’ undeclared (first use in
> this function)
>      98 |        param.param = RTC_PARAM_FEATURES;
>         |                      ^~~~~~~~~~~~~~~~~~
> rtctest.c:98:22: note: each undeclared identifier is reported only once
> for each function it appears in
> rtctest.c:100:23: error: ‘RTC_PARAM_GET’ undeclared (first use in this
> function); did you mean ‘RTC_ALM_SET’?
>     100 |        rc = ioctl(fd, RTC_PARAM_GET, &param);
>         |                       ^~~~~~~~~~~~~
>         |                       RTC_ALM_SET
> 
> After adding "-I../../../../usr/include/", the rtctest will look at
> linux kernel source header files from
> <Linux root directory>/usr/include/linux/rtc.h to find the definition of
> struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET and fix the
> rtctest build errors.
> 
> 
> Thank you,
> Joseph.
> 
>  >
Hi Alexandre,

Thank you for reviewing the kernel patch [PATCH 1/2].
We are still not sure if we could include linux headers files from 
kernel source directory by the following change ?

-CFLAGS += -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/

Thank you,
Joseph.



