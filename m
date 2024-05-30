Return-Path: <linux-kselftest+bounces-10939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F98D521E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2CC1F219AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043474049;
	Thu, 30 May 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgtRYtBE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2D73539;
	Thu, 30 May 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096425; cv=fail; b=peEyAlb77pzEZGrmTvWBBmM6A6FueuYSbQysKiJFhTN4tv9wN0TzQy0F6jdARbafpNIEfcBSpLMGVZ5gH/ALVf6HWFJtyFRN4bxcYTQWBZNy/UrfOKne5NIPszd5BJLTVjq9Ro7SM2+AcyzbdRhNCD/YWRA+7kEYnAu7cGCOXh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096425; c=relaxed/simple;
	bh=euP1yV/qE/aNuBMCaLU0EYoeh5nh59IyrWs0jiVjhTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYZOBI77uIS1vltEPxOejJN/OMIRNzZ5OC7gh309FClOhhbHC8FlOD/46ClI2JxVQzHArN5Lf5xwFZWzV62tejvHyQbwxAao9/iNrGtQ10r4FVmZ4XzUgWWnrO3vk7l2K8AHX/KvCKPIqPYu8zjnrJhke409UgAgfExLAA46On0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sgtRYtBE; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elhdXkelXvcBEF7hr5OVYO8RDSJ+yBvFtABkMEYT/fbMSZIbKd6oC2qCawVEF6rNvs7QJDc3CUAX0A0kH9EMQH3Txnaz8XcWOgaDNi78hWuDP4PU89ZfZ8jSftWeJQZFtW36zZBpijcpErrAhuHIgi74qpZ7UrhH5je5gfLSLNbb4+RjACbvND0la6ukHgWF6Iis6pG78Rnhjaolb7J/S16TZRqKPpcwwW7tY7UqQYCwyNlFSVM8cttShxpZArPLeHDugibVDcYDctdXiwwKJdg5FiVK0ptO9T9hYAwmE0POMzDTRpYfST3A16WC3gK1tetxIn7YuWVCuAuy0Rgesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vyLiIcpHr7oXRBXaCmmO7y6kz7OBz29Rw7HAilNzNM=;
 b=RFiZxZRSjNbdo9rBSXIMszfywCQkaRzEYZS0iF0yREqu2z71bqjcu1bjlgKVWvyePj5DtYiLTAx6fnwiFUL27196+GPMbNWfcB3jeSKShbvhs00BlAE210lOC3zBQAeLgmD7OM3k5yJ4x1f+FJV6ebgRvDbQtnPUAnVlAOJYsq/jiaVIImtj/5gSsvHsB6OoLRPkh/Zd6TUmsB0XQwwr0jlExqY3zUbyDCl++wRg+Pmkj7L8eGqAHo7EFSGnhwTr6aa4dE/GSs/m7iIp3BOVao+eAbs87Q5wb7719nZhcBu7FE6/hpkCXBVePrOL8SwwdABhFvLM6A3Fau9WUAWIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vyLiIcpHr7oXRBXaCmmO7y6kz7OBz29Rw7HAilNzNM=;
 b=sgtRYtBEW7k8lW0e8nCjbftfkt4Y5r6IQAZ4aVQibP6PNQyUMAsCs6XopWEtSg/FBVmYlkeXn1HxEdknfOT/M9Mlml0T3DOWPo30i0DcvyI3WvvWGKsfPjLu39gxIZ6LLbRpe4IIiSXrrl/0OxX/YzL2cQL5yjqtmw+LsdfSx+t4qypKgS0CFWHRLPZ4J42Qwi0Z//zx+fpGFarcnBMAOy7rpRI2mo5xX4gwbLsoEi/utD6JIORG88bgd2Uk4NG59OYEHHuow5/bt2txgZqF6hC+rWxU1rogEKmR6TeuHlPhf1E2PQh6Vs7apmEaZXBIV8KHD0ci03iMFuYVxp6yIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Thu, 30 May
 2024 19:13:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 19:13:41 +0000
Message-ID: <20ebb3a6-cdbb-4ffc-9ba2-c9eaa4d6ec74@nvidia.com>
Date: Thu, 30 May 2024 12:13:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/futex: don't redefine .PHONY targets
 (all, clean)
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-2-jhubbard@nvidia.com>
 <ceb9182e-b6d4-4f6d-bb53-87efe5337230@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ceb9182e-b6d4-4f6d-bb53-87efe5337230@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 397c8411-f184-46cf-be25-08dc80dc9dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEtZMGJsdERlaUh3RWxZVUxLSnZ2a3F3b3RSRFNtSHZBYXVLUDRaakh2b2gr?=
 =?utf-8?B?V1dOU0pnZXdtYnhxOGRobE9NQ081bDN0UlUvalo5WmdlcmhwOW9EdTI4UWFp?=
 =?utf-8?B?T3owT2k2MnB1Mlc4bWhERmpjYVFOVjRxVnoxYmpUZUxzaUpRZGVnUFJJSURI?=
 =?utf-8?B?ZEdnTTNkVTgxaDl5L3cwbU5IN09mTVFkS1ZkUWRnOTVuTEFGdmE4SXFmVzZL?=
 =?utf-8?B?eDRQVml5S3lGdkdrUzZnM016RnNQanFsYUxrS0k0bEFpREEyL0FtZVNaano4?=
 =?utf-8?B?ejFwaVBkdGhKMzlPZVk1bjYvU2tkdFhMQVhraHlndzQ3M29WeUtFQmVDTDVy?=
 =?utf-8?B?L0pJeGtCOTgrVzZCNlVFai9MbzB2TFZYeXE5Wkw2bVlyYUlRK1BJQWVpS2l4?=
 =?utf-8?B?N1Q5U2Zlc1ROYjc5WGtzOW5HcFk3SnZEL3B5NDgySHpUSjZKa09SZWVZcjZY?=
 =?utf-8?B?djMvM2l2TmxuOE5EdG9MOEppTS9OdEZCSytXOUt3aU9ybktxQjlMOUNtTGZo?=
 =?utf-8?B?VndJSzR2Q2JOVUc3aEN5VklETkVSdTNiVjFKcEZUdmhVd1NMMjVmSHdkNnlp?=
 =?utf-8?B?VGpWOFdzYnBwd3JHTGZmNHVXV2N3eHdMSUppT3ZqL3d6aXBZbjdQdUhPNnkr?=
 =?utf-8?B?Z1k2eE14WHBuaitEN2JIQllEeEZoaUkzWWx3MlJPdmtMUkVJRE0vN2RUOVY3?=
 =?utf-8?B?b09kZ1J0RERKbkp6dFhidjBPQVVwNEc5MHZiejZPdG9aZ2xQMVFkc1FmNDBi?=
 =?utf-8?B?REVkQ24xVlorMXJiVlk4QmZRd2xrd3Bhamo4dFVxVTc3VkdQOHFPVW0yZldt?=
 =?utf-8?B?L0ljaVNETFBoVkppVGJGbXhvcEl4MEVmTmhDakp3eVgvY2duU1VYSTJlQXFk?=
 =?utf-8?B?anBoM0NpUFMvZlRYR0w2bC9PQXFHL0xnT3Iyd01DQTNmTWc2emM3TUZVSkI5?=
 =?utf-8?B?NlN1S3RSVjdqdnNBZkJ1eVFzM1gveVV5OG82YTJtLzJ2aCtoaW1NdjJQS2RC?=
 =?utf-8?B?eUdJTjFKbCtKM0hoSHZxMmpKOTkxempZVGl5M2JQTVpaSkZ1UEo1R1NuUFll?=
 =?utf-8?B?Wng4dzMxVGltbm9yRThoMG53eXNSWE93bGRWQkFiUXFFaDFxTHBaOVA1c1FZ?=
 =?utf-8?B?WXJGOFFmSzVPNUVVVUVlN1JmUlE0SnpZRkQ0alFoUzBjVVdRTzRRVGVLT0Vk?=
 =?utf-8?B?YWxYZFpjZVVLRUM3bXZ2bHZNd015aWdBR3dYdWovTjZiMktPVkY2bmtZcWhq?=
 =?utf-8?B?MHZsYmZQcnplZGVIZ0o5OFV4c3VBeEJFMEdCY0lFTC9DSGpjaXdMNzl3WENk?=
 =?utf-8?B?bTc2MjJCVU0zSStud3ZTWm9oaWJGaXd6c0RxUjBTVnV2Ym93Qk5NWUJnMUZ4?=
 =?utf-8?B?c3dkZDdNMWgzMXQreG1QeisvRGhhSUJDcy9aa24vZkVpbnloNUpzamtJS3Y4?=
 =?utf-8?B?eE1qeWs3VisySFlxUEwrRWhxdWxBd0hROFB0RHJEY1R6dWIycEpsWEd4N2Ez?=
 =?utf-8?B?M1RuUEF0Yk5XVmUwZ2Juazg5a2hFaCs5dFpublN5UlpEM3RUTHowdEpaNlgy?=
 =?utf-8?B?N01FM285eFVzbmFld2pZbDJyN2h6ZnYrSmY3MmQ2K0NZY2NTZHVJRnc1eVJj?=
 =?utf-8?B?YmgzYkdWanNQN1RHS25WbUUza2hpelZJSmluSENBaitWZlVkenVHN2JGeDZu?=
 =?utf-8?B?TUFwYjNROXEvalZuZExaWGNiM21yOFloL2JHeXpkeTRYZUNhdWlEVjNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjRMbThkUm5SS0hqWXhWbWRGVXcxMWFSRUxBK0RtbG5zbFpYRGxMNldYMkxS?=
 =?utf-8?B?c09hM3FuZHY4bERuVmdXdWVuN2p4dXNCak8wZWV0T3hHMy93d0dNdll0RGtO?=
 =?utf-8?B?WnZ3S0dLZWV1OHBwMnJERnFrQjBzWGNhK2ladE83WDAyTUZ2Mno5NXBYdjY3?=
 =?utf-8?B?eGdoaUZiMEJXbldJWEwxR2dPdW56MGFjcVJVMHFWTnVmYUFOMmFIRVRaTFFT?=
 =?utf-8?B?M3pLbGRyVW5CS05aMWZnaW5sOEdFT29ySjE4YlFTUDVmcTIxa08vTWVvVWZy?=
 =?utf-8?B?T0tESGxCckhaWnlJVlhMNHhORWVIVWNaZy9tczhQa1hpUEJGT0lQV04rb0FB?=
 =?utf-8?B?K1gyZ3U4MDJ1dUliNUw3M2VnV3I5L2FHU3FXNmltZEcrZVNVU1V1WThBQ2Yy?=
 =?utf-8?B?Z2JwWDlML1JpelA2V1o0UUdweTdSMjhkZkhVZHpOVVZ6MmZza1Z6a29aWVcz?=
 =?utf-8?B?cjl4TXFaMUVEVUpYUU1IYmdjRDlPUFlZb1p1ZFlPV0hkM3ZpS0dPQ2V0TmZS?=
 =?utf-8?B?OTZPOGFVbnNXWkVFYm83amk1cXZPeTZ1V1h4a3dYQ1VYekJEZFpiSjVON3Bp?=
 =?utf-8?B?SFN5bUNFZ01UQWY2N1F3T09Pc25GaVBCZzRkRzFhbU1kOGdUb3NrUUp5dlhF?=
 =?utf-8?B?U0dGSXdvQ1lSUThzbytyWUV0RzVjRDRRMXY4YnNhMUNSUStBcXJlaGNZKyth?=
 =?utf-8?B?V2xDTnRHWTh1ZjA2TlQ5ZlViNmlzdjcxWGNzWEtEN0dzNHdaWjQ5VmYvTENU?=
 =?utf-8?B?eVVhMS9HWms3MzQ4M0ZHZDRHMThUYnJYaVdNQkxmZm5GYXhweTVZc21IVU9m?=
 =?utf-8?B?Sm1HNTN1S0MrZVN5MnJ5elhFemV5TDdsUkFoNm0vc2toMGcrMVd3MytuSGY1?=
 =?utf-8?B?YjR4aHRSbnhDN2xqM2JESStzS0lWYkJDR3o2NzFUZXdZRlpZYy9BUDhLTVo3?=
 =?utf-8?B?SkoyY0txa1U3ZDBqM1NIeXJNR1M5V0FiM2M5b3lkZ3JKdVZ5UENnL0gyK0tu?=
 =?utf-8?B?WGlUQWRyaWFUN01QUzJIZklKZzRMRjhYc3JSd2kwdy9yLytTL0UrU1RJU0dO?=
 =?utf-8?B?MHN6SXZzcDdwV1lIWjYzTE1XR2h4MGVSZ3VWMDQ1aTFPWVcrRGQ0OGc2VXFP?=
 =?utf-8?B?cVlqRVRHZ3d6VDFObHNpS2VyLy9tUU5SSllzendqTjZzcWhieGdYRWFOV2Y3?=
 =?utf-8?B?WjlCU0VCYXlMN0M2R3ptbVp0dUttMW5XMzhyenp0empONXVCUExCV2hrZ3hH?=
 =?utf-8?B?bHAxaFNCb1lZUERidG95YTJ1aUVLa084MU5MaU9VbG5GWC80Zk1IcXJIVUxI?=
 =?utf-8?B?NnViT1dSQ1pFeXNPa0Q5eDZIdm52T0krSGNGRzZSakJlTE00VndwbDN5NVFC?=
 =?utf-8?B?ajFsQ0o0VW1UbFBoNWd6T0krOXFBd203d1Q5T1VQSGRWVU12SlBTQzM1S1BQ?=
 =?utf-8?B?SzY1dHBTamdjL3pROEg2MXNWakUyZmNlcmgySWEzTit6WWU2bVRrVkpaWVJr?=
 =?utf-8?B?bGNSWGcveUE0NXU5UGNUeXEyYk4za2JWcXM3N0pLK0Q0cTZpSDZtSUJKSEdn?=
 =?utf-8?B?ZWJ6dEZDQ1NnMFp2U3dUYWU3djc4RUNpY3V1SzBWc1RWK2EvQTVPdkxQMFU1?=
 =?utf-8?B?SmF1NjVzVW85OG9KSEtXZTJXRWljbTJPVFM4NXFEYVNRTE9JbDJRb2lHNUV4?=
 =?utf-8?B?MThzSEFLTXAvTHl1TXlFdjc5T0ZHVFJHWFBoamI5SjNKa1JZNVNHSjlTUjNu?=
 =?utf-8?B?cjhXWFF0ckkzUVRrclFoamVmL3V2RWh4RFZuMzU2dnlwcTVFVzd6d1lwcXB5?=
 =?utf-8?B?WjZ1ZlpKOHAxSEZUc3ExRTd3SGN0K0NnWnQyVFNia0J1Y3diZW9OVWtvOGNu?=
 =?utf-8?B?OVNyTnE5NDBpL0I4Mjlxa1E3Q1BxbFVLNnNEQ1N4aWZLM1Z6ZzJBMEl2OFRl?=
 =?utf-8?B?RXdmUUQ1aXFOU3N2MnpYcFNrTWlwekhRb2w1c0c0KzlCbEhrL2lQWG1vNWsr?=
 =?utf-8?B?aklYWGYxK01aTUROTUczS0x2cTROQTZDSWhTS1l3SEFuREp4bFVmOWlIYVRx?=
 =?utf-8?B?Mm9RVWRRNmZFWWdOVHE5R002MDBqdmdSdmVwcmJRSm96ZGg1dkhNMklEZzFx?=
 =?utf-8?B?dlZoL20vZm5GRkg5UXBFSHpndnlQR0pZMlkwNFhRNit3RHAvbzdwWEFMK2lB?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397c8411-f184-46cf-be25-08dc80dc9dd6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:13:40.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpO1OMHqgBnadPBaDVdkPz505BAQuOxpLCM2y4l12I+F5HylJ1xAeE1/FOjyCWJ7a5TuPemVWn/ZR4wzHk60jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

On 5/30/24 12:03 PM, Shuah Khan wrote:
> On 5/28/24 20:29, John Hubbard wrote:
>> The .PHONY targets "all" and "clean"  are both defined in the file that
>> is included in the very next line: ../lib.mk.
>>
> 
> What problems are you seeing without this patch?

Code duplication. It's a sin. :)

> If I recall correctly, futex needs these defined.

And so they are defined, in the very next line:

     include ../lib.mk

...which has this:

.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir

> 
> Please provide information on why this change is
> needed.

This patch is a valid cleanup, and doesn't introduce any problems
that I'm aware of. If there *are* problems that show up, those would
be deeper bugs, and I'll be happy to look into them and post solutions
if it comes up.

We don't just let latent bugs rest in peace. We fix them.

thanks,
-- 
John Hubbard
NVIDIA

> 
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/futex/Makefile | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/futex/Makefile 
>> b/tools/testing/selftests/futex/Makefile
>> index 11e157d7533b..78ab2cd111f6 100644
>> --- a/tools/testing/selftests/futex/Makefile
>> +++ b/tools/testing/selftests/futex/Makefile
>> @@ -3,8 +3,6 @@ SUBDIRS := functional
>>   TEST_PROGS := run.sh
>> -.PHONY: all clean
>> -
>>   include ../lib.mk
>>   all:
> 
> thanks,
> -- Shuah



