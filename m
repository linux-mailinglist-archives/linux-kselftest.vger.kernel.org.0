Return-Path: <linux-kselftest+bounces-32033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142EAA4FE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34994170ADA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6965825A345;
	Wed, 30 Apr 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FqQDNCpA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UOEfwIAZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4111C5D62;
	Wed, 30 Apr 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025737; cv=fail; b=o5yTvZ+NmnS2Ou/0cpdH8SFvk7i3iFxtG1SJl1TOoJVwvOvs9wfdrvvBH3GcCh+7DoR7rpD4yaX+eObxpDyZ28Xf4HKXpsjyDUEqto/qAB78XBhHSFBz2gHfG4fz1FzarWi5HJb9L3JA5jIUi20/9Q/mCcDgJof94WiVj5wpML8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025737; c=relaxed/simple;
	bh=GXJqN+2LBVFBiufO8c3jBeipszTUyT9Y2DwOn+jvtOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aEQfvvuhW9iDOv0DQW3Q83OansGKQZA0ajbj0QmwHzXyogT1pZCQMihtS2+zc3n/yz8fdW4f4okUNOwHGXd70LmhSatOkCvQbtzksPSRYlcQCWHahgkE9Qoa0GQou7CrSHh1dmKmvkYV1waSFG+6UO98/XvkQl/13n594iqzEIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FqQDNCpA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UOEfwIAZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDahrY003210;
	Wed, 30 Apr 2025 15:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qOsr4brmcZWM5e7dgArZvc3w+9RmsvXAvEAxi1T5ji4=; b=
	FqQDNCpAmZJ3Kh143SgSWQpVcBmEyMHPti9ohNhG2+5zwiOADIM0n0sMM2dGZZgG
	rl0hnQ3ks5bD1jgk/oAv/QyinzWJbxiTv0lrmwKfRfeJ1jiH7h0ACZFVr4J1W1dp
	GkTpmFIDPG5qDYC3UhFrAXUALu2xNlzjXSH0YgyJyCrtZsj8VcXZzXVileGDsbVW
	9TM1cLKBARsN410IlGt6nTex1Vx1+7rv8TqU3E6ZMzhfKFBGY3360i5rjR1myg5q
	sRKMReoJXUGsIs1rm2KG7OuF4sp072hfgfUd2X/78mMPMPqWWXvmBd1jhPH93Kh+
	Q6SveqXwPoZu9TG600Q6pw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uuhebd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:08:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDrnbS011290;
	Wed, 30 Apr 2025 15:08:28 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxby433-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aom+ROP/dlhOpmn4gLLk/w1WYrfNo19vOGv/31l2D78VZ3AFmra5yyg5r5XonTuvMqDwKyHLBM77xGMxECNYNXZ4leyTiJ4xaYRYN1SzucF1LLbXKtU87OpnQboBTphIMEoLN1HJyqw7ml6qv7JMwVPWRRHyFbNjBgPc2j3FDbko7ChcvWR0UrU0dL3ojuraTQtBiriU/5Q5Vs0Hr8Z/SIkhdT6Z9UNUOBOSK1tgICA8CFzL1i/LO1upDlS4OZMeLGp+09TqnWCyOueKtp/SAC/NOyGi535voydt8FA8AocnfZGqzNPVviLSxo0MK2H8q/JGsY7QzQx5k+5PAdagIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOsr4brmcZWM5e7dgArZvc3w+9RmsvXAvEAxi1T5ji4=;
 b=SwNKc1kfebRK0U6r1QNOHPjYBoJDf5EEWPMHsCtrAomaO+M/Ctfg1c3hYgYj/WS1DZJd5pwiTtt1YZXggYNqFsOx7ABcUcGNPe7oJpIyxG9ovS6KFsirHPlrKEZk5yVmlgdhYOOUNbkUoBv3ct238cnXgUo6tuW82uJx093SdrSEM3QvgSL6nOJCfDDgfTlmidjJ04HBHy0xMAN7a4iNFM/UO9PHeBPcqTTrn8EEDJLn9dmVIhTDpDxFvOtb9KJ3MAeAXqYXZnAuWzlMZQBr13k0nY0j46pltTwj6kTF0C3XGykQkJ0xb+jgja9lrVKz4oqrt0xFMf6vm/o+6thlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOsr4brmcZWM5e7dgArZvc3w+9RmsvXAvEAxi1T5ji4=;
 b=UOEfwIAZLfE4EAGjzXvUfe/ALDaQRJ+5siTl7jUcxspC24Y1tBZ4LlsEBUFiuiWx/j39bbiJAvON1pevWtrPQmTcS8pjDxMSjy1LA85R+cvQwyBLOZHEJhBDrVX757KpdhxldOg6tkdPYpvFUSYFHR/yu0DADSgOA6hhe4NaxSc=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA4PR10MB8326.namprd10.prod.outlook.com (2603:10b6:208:56a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 15:08:10 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 15:08:10 +0000
Message-ID: <288e0042-35fd-4b03-ba6b-07e9893ee343@oracle.com>
Date: Wed, 30 Apr 2025 20:37:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/22] iommu/tegra241-cmdqv: Add
 IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
        corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
        peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
        praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
        mochs@nvidia.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a7db1d2fe5dd43ac7ac075df662f3ab743ac6aa2.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <a7db1d2fe5dd43ac7ac075df662f3ab743ac6aa2.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA4PR10MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b1cfc0-ba6d-4d39-7242-08dd87f8d1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnZtVURxaEsrL0lEN1BuRVlFMm1NUjZaV3RGTkRqWTVZS2ZKS21EZXh1a213?=
 =?utf-8?B?UFhROFhvdDF0L3VYZUN0OEJiS1lOY3Q3M2VFTUtCTFo3VkVVdlJHOE90bVIy?=
 =?utf-8?B?NExZVER4YlZrV2VEKzVGcVI0dHJla3d6dUUvRnV1bkRJdEVzeFlWS09UNGZH?=
 =?utf-8?B?bHRsMnFxVVJnOTVyMFR3QlY2TVNaVkczRjVGSDlVQmdNVnhVcENNVEhHOUpU?=
 =?utf-8?B?WXR0b1hQdVVZNjE1ckpnKzdiZkVVblYvcWkvSHZkSit5aG5zcDlxaWpzWUxK?=
 =?utf-8?B?SWEzdWlNMTRhUlVkb29ISS9WaFlDUG9tK25HQlJpT1U3bXRRcit0MGZBNEtO?=
 =?utf-8?B?cDZpd1ozL0tzMkR5SzA4dDREeVBFQVp1SXBUY1lVNjdIdGhhSmJ4TmpwVGJt?=
 =?utf-8?B?SFhVclZaVEQxeW9mc3B6eERDZXRmS3NNT3Q5VnZMeVRhS01UOUlPNHRyc0pm?=
 =?utf-8?B?MGNuQkVyTFdOVG1VV240MnBvYXQ1Rk1iemVheTZkektISkY5QnF6SnE0SlBo?=
 =?utf-8?B?eS9ERmRRRXpIUU96bFBvVUZYc2t4OTEzd1RIc1hORGNRVU11cHpRQmRYNU5W?=
 =?utf-8?B?MUx4L0NldWZXSmx1Vjdia0xYd3FPMTd6ZS9kVHFOUkR3RlloZXp6bWJ0Q1lK?=
 =?utf-8?B?RldXZHpEUkN2Q3RmRTIvaWF5Q3ZoTkUrWERjZXE5bmZZSFNvcTgzaWpSSFpU?=
 =?utf-8?B?ajI5a0hTMGdYSlZIekVucWRIRS9pQ1h5MUhMeWxydUk2NTlDdTV5ekpLYWlO?=
 =?utf-8?B?bVozWVNtN285MldrQ3pVOUlpZXhKNlFiVThsOFpDajNwY3RCQjAzS2tJOGxM?=
 =?utf-8?B?QVRzSlRtZ2VVZFNYdHBGV1NXWXlVRW85dTJ6T0FWSVhHMmNCdGlhUFRpQjZD?=
 =?utf-8?B?bHQzOTdINktvdDd5ak50SUpGc0podm4wcFI4K3dlUndPZlJkTGFnT2pOWS82?=
 =?utf-8?B?WjBNTzdZNi9CekZQTFg5c3FiRzFuTmdqN2s4RzQwTXU0di9icGc5WFdxdFdD?=
 =?utf-8?B?NE5CbWRobGJkaXprMkp0ZXBXN0FpOTYwc1hEQnphK3VOQ2loNlQ1UDltbGxW?=
 =?utf-8?B?UURXdDZPbTBzR3NGdFQ2S3FBS0NaVTRWR2RhK0l0THp1K0cxV1h5R1pUV1dw?=
 =?utf-8?B?bzl6dFpQcTV5VkxhT0N4Q2hpMXQxbExNQmwvdk5zL2s3QmJEd2RSWkVuQTlv?=
 =?utf-8?B?WGdYVGxMdWNONmtXdXZzWC9WdFpwQzdhZC9iU3lMbUF1UHNOcE1QbGNDd3pY?=
 =?utf-8?B?ckc3VUM2dU5iU1FDYmM3MWdaWllyQ012RnBaTDdPRks1cmlCSHk5bkFZNExh?=
 =?utf-8?B?YXhQZWpZbGJLejlwSVIyWWNFQ1J2YTVXQjhydUJ0WldPdUlFUEtNQmw4RDdX?=
 =?utf-8?B?KzZPWVlXY2R6Ri9UOFJ6b2RJOUtvTWM3S1ZoZVc3ZGJseXUzenpiZmdNWFhF?=
 =?utf-8?B?dnFZWmY1ZGk5d1IvVVpKbzkvUkVsRFZXREtlSHF3Rk1zY3NjRGplQmVOaDZ5?=
 =?utf-8?B?V0t5Nmt4S0lzSzU0dlBOc1ZiZGFrdHY5MDdHY0h3TmhMQnB6MVZLM0x1SWU1?=
 =?utf-8?B?ckRXaVBlczJHVEEyUVlpYkNuKzZDNDZtbDl4bW1tVHlDelBqQUtHdWFlVWFD?=
 =?utf-8?B?Ykd3bTF6SGc2bzFUeEdPTTlEN1hXZ2ZhaW03eTQ5K2dReGYzelhkME5GOXFq?=
 =?utf-8?B?Q2pydk94SXBtODJ6ZUdTUVMvcTBTRElXbHJRSDg4MGFvM3NWTW8zMDRsK0tQ?=
 =?utf-8?B?T1FyOGdkTWR0VGdVVDBjZ2VJYytJY1o0cXRlandSUy8yY1ZhS3BGK0J3WnRZ?=
 =?utf-8?B?VGJmL1NEV0RxajBVVGovTm5HWmdOSlE1NEJmOFZNM3NDdmVOVFRxMnoyVGNM?=
 =?utf-8?B?dGljS0g3SUgzOE1NZ3B4V2J1QmprSCtUUnJmM3FrcVBoU0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdJaW1oTVFiU3hyV0dhRHFJTDlxK2VlM3NXMDVtS21FMldmUENFeHNQSTYw?=
 =?utf-8?B?U216YjhnZ1l6c1hHU3VUWmkvb1ZDaEdQVUFGUkUwOCtJY25qMXlQVzFqT2wy?=
 =?utf-8?B?TkZLSlF0cnhxZWVaandMZEVqTFdiVGc2dXVaZThLMkI4M0oxODhDRDEvbW9V?=
 =?utf-8?B?M1QrbE5MS0toK2xyMUhjWlRhUlNaTlZ3SFRNMlZIVjJEN2V1MWU3a2V2U0Qz?=
 =?utf-8?B?b2RqWkJIaGxsdUxsOGFJM1VZSXE4UTJYR0dzK0hnRUx5MVpmOVZxYXFiZFo0?=
 =?utf-8?B?cUJsczR4WVl5RDdlSzJtZklTczBCbjRFNWQyZXBXSk9Fb1J6UzY0WGRYVkl3?=
 =?utf-8?B?Y3JCMFdINlUybVl5OXFsQzhKY2ttMEhEdi9hVVdOVDFtd0w4dURqVk83SVl0?=
 =?utf-8?B?Ylk0R1FjNXJOQXhGbGNYdXkwa2tLcE9FREp3VHJpb04zUk44Qmg2dzRMckRz?=
 =?utf-8?B?d1RHc1AwU0pZU3NsVGRkOFBWZFM1TEZXSk01VENDemx0RVhHSmNqSTFaYzgx?=
 =?utf-8?B?NGw3Q21jZGhKT05rSGlKZVE2aUpaMzNNYmJOOW4reFRmRXFoaXR4MzFIdm9i?=
 =?utf-8?B?SUhEZ3NreGpwbjd1Zll4Y2pleW04eXZ2TDVPeGpyblh5Y0ZMWmdOYkFMeG9L?=
 =?utf-8?B?Si9GSjhwQnR4NTZUdHlOaUdJblpxeUtEQ2Y2TkdvMnlDQW1oNDFBNU9VYXNJ?=
 =?utf-8?B?V3F3OTdCbFFGZlJkUUlOci96QTdyZlpLSjJDTC9FZnZDNy95Z1NxZmV3S0FE?=
 =?utf-8?B?NmsrRjF4WjUyeFBCYVdTam9nOENtcCtWeU9QRTdET1ZXaXhHVkVYQkFENmFl?=
 =?utf-8?B?NlVFREMrRW0zb2pQTXZ1MjFoTFZMTTBVWnJ6cENlNkVvREV2c0YydFg1L0RI?=
 =?utf-8?B?L3l2eEE0c3BGeGU1RWdSaVk0anFGT3NLSmpvcWhydFcrMEN4eWtrVlRGM1dJ?=
 =?utf-8?B?U3QxampsNHBUMzdDdmV1WkphRHhaL0FFbUlMMkdaREFxN1l6WU9Xa3RPY3A2?=
 =?utf-8?B?NUdEbXVTN1lJRWlxSGlRblNESXlrNXNXY2VBdTNHZ0RpUU42V040VlQyRHRm?=
 =?utf-8?B?NXNOeVZTQ3ZNWXBGN0VhS2FvWDUyeXFVYUZPYThEMzA4YVlOQi9ydTk0QW41?=
 =?utf-8?B?UllqVjJuS0FTQzVSbUgyc3NObVQ1MzBNTStLaUhDYlBxelI4M2htSzk3ei85?=
 =?utf-8?B?d0JINmlZTUxYTHBDaFEvMDFYVzBnTVBqK1dOdnlyT2IwVHYwM1FNVGdOMHI0?=
 =?utf-8?B?R1pxVGZndVgwYjVIbVl2OFA3VUcxVHlHazd3U0NMUUg5cnhWdFg3ZktGdkky?=
 =?utf-8?B?RTJJOW9WRlg1bjZCdkltdTdNdHR0dEFYWFdKVjVTbmdPaDBOQmJsNDdDMVor?=
 =?utf-8?B?bnAzeCtEMC96U05FMnYzdjFDY1Z5K0c2OVhTRkJOcC9pS1ZpanZjYzJsWkNW?=
 =?utf-8?B?dDRid3RZZTlWRktSSEYvVW92aHg5aWFSS2RSWDlBSEsrN0tBL25ES1ZXSEw0?=
 =?utf-8?B?aTFKWXdBL2lJV2l5RHVCMUoraEVGZmFGRTRRdHZ5akJuMTQwd0JDdW02MmJt?=
 =?utf-8?B?SVZKU0ZYOXlSTWlLWndZNkVHRG9xTFdRVklpd3VEaXVPZ2pTS1U3TDZRNG5i?=
 =?utf-8?B?TzV6NnQ4VDdLUXh0emU0U3pFdFhLOEJsWkNncU1wWVRMYk9yRGxRRURkK0pp?=
 =?utf-8?B?U0V5YmtWMnV4NjVsanFGb1gzWnhCaFV2VUplVktpenJ1aklPa1hJdFhsRXFq?=
 =?utf-8?B?RTNGaHpRc1o4TzdwdnRRQk5SdkFiU3Z4WXlmU01McU5ObVFURXZ0R3lsd1Ir?=
 =?utf-8?B?bUF5WnhaQzdmQkw0MW5wYmZhZ3djUXFlNDVaUVFjV3BsbXpyQkw1eTQ4bUUz?=
 =?utf-8?B?R3lWTGd0Y2FkY1lMNU4zbC9keDd0TElYZlFmbUlWb00xSUsvaU9Qczk3cEZP?=
 =?utf-8?B?eUo5UUlJaTF1dnBlWEJnZ252ajM4SHZMMEVLKyt6VW1mRC91d3VORTJmYjM3?=
 =?utf-8?B?Y0hNUEFWRnFUYmJZaGRPWkI4aHhSTnNqUlNFS3Q0VGFycnc4b1RRZ3krcXVV?=
 =?utf-8?B?N2txNkF4UjJ3aXZuNytsY2NlZVVQSW9JcDlJQjVRSzJFR1Q1N2pTV0NYVjI3?=
 =?utf-8?B?bjVKcjU0UmFIeXVUMHFxOStxNi9FSTdMbkFOc3VITzhVUGhWMjVpV2pIWkNN?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q9mlZT/RUED/HdEqle4NfQ9+SAvEunoyeeVWgoVYgEEXMmbaPd1A7t7mxyn2jAw5+NdDH7/D0zq1Dzk0mXVvQWWT9ry8lZw5PbpTThDl12xMrEQSNdntQO0z6F1dPsmJ3+ETO5QtgnISEbFG6hXfLYjaITQ1QO6iEP3RxO0RQMkIDOTRw13CHH+7kLJThG+dfZDMB7Io1109G3Sr30h2nBjiI5dPRjoyuue5WQif3xPs57XTl2+kCwT1d5zorBpegntApMY6wuscAXNd4nj34LEy8BaJ/qltqXsgkwHg/aBSKyZ2gfgn9jL7Y3zHVMXfRey/7OttmK/C9kYfJdc+NpZcI5k51j6gVquwGHPaTkgwNj62y5aOBdNUx2QYa/S6Nwxkn1cKyVSxZe2rCmgRnIFg6TZCfTNvGGvdG/pEo6qmfUHoXlXedgV6l/que5BCmBZ0bNV2XQzWH0xhNEpZ0CRWQiX0CDlykBCJz48W97447rMwEIycTnyG+JRIJO8IQYZShAi6XI57q9BFcE5g7hMTZ2LZcyKeBvSa+7wqzSGzVCId+MEC76V4SLwFjCKELE9FN+7B4UZpXAcr+VX3p7b8LcVOV+zwCj22Da4ouV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b1cfc0-ba6d-4d39-7242-08dd87f8d1ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:08:10.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSq7S/rdZpLujR4ri8aoCyUGwELNK+3SDhMxpGNTi3gRjeQJ8KvEIS4HHqXnqgf7pj5PqAoTKHoB7LTm+VEfAJH069LJZi0+hRTK/G16K/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwOCBTYWx0ZWRfX5/sRRczMpPgE I5eTC9ieklOgz4lOgFlZgSBSnXHQeNIPP3WizO08tYUnChEhn0kdyijNffjETXV/5Lnwj64Zd17 ZWitXwdWdPofzdo4HZLYvnPiE4JsqYvtqbhlGx1oU48WK+/DA6tX9P7YI0vGnofQB7ivZaHxmw9
 CL1V4t6MGRIxQUQhigbKhURjxLrcLva5ztz1GYNuiGSgw1lc3fbVnija8zgch53nVdzurlYomUf 5y4E5uE7bjZ/QwK/IqkZSUpkYqfsqtWroRD+dPCi62HXVd14JtU4YnNF0bthocEt1hROqQtutcB HlJat0EDPf6QZN4leVdbyNuCK1l+BQaPpma7qmKDNtmsCR30K003JUlve+ud06Q5jw/LqCbjliZ
 c/a8ICbNB3byfZR2dHAamkMABvwXp4xaFaigHf5p7j3RkG3iLeh69MzjE3QdtkCDtt8eqRw8
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=68123ced cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=LBw5KNMWGSNgkYXM8a4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DH6kq_CUaJKbuiemyp_hmgnH_x2iPsXF
X-Proofpoint-GUID: DH6kq_CUaJKbuiemyp_hmgnH_x2iPsXF



On 26-04-2025 11:28, Nicolin Chen wrote:
> Add a new vEVENTQ type for VINTFs that are assigned to the user space.
> Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>


Thanks,
Alok

