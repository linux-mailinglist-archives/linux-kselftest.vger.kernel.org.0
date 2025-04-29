Return-Path: <linux-kselftest+bounces-31930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47BAA1B83
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE33B5BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DD625E83C;
	Tue, 29 Apr 2025 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eIbI0+o3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DDGmu9LX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B627453;
	Tue, 29 Apr 2025 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956174; cv=fail; b=SiBs8c75S8uGjQlc5F69IYNCivJn1X1vvpsYBaAagDoSw399r8kByqJaXBcHJKV8y94yQJiQzmqUsvXrFQ2R0QbQ9LgqhoDxWSDyj34cYY+yIpNYtLr+Bg3c8ZRg75qouPPBgqy4vnecdPI6IFTJuSU0LAKNUoB/xWGN13W9Dhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956174; c=relaxed/simple;
	bh=mdHnvL41mrTHJVMTj/0BOLnDCsS8kceejx8xKYP1dHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOrcUHC+hPhDYAXHynp8mK5ZlqoqsruScHPXB5PAng4dZMNxidblcQwQ7o5b9RUmHfQJy77V1irN7/E2mL5k4HiFUY7iBBxFo/ILOpvCryvGIOaKRwTHwzlqnEEayTLu8oYi8JcmLrXUNCTTy+QpMwpyoEglsHNaEKTiMJrPMv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eIbI0+o3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DDGmu9LX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TJdIlZ029934;
	Tue, 29 Apr 2025 19:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9B55UodQH1DXLAeC8XlUEiLJCc4EKOGNiW7iS37ed7c=; b=
	eIbI0+o3yCf6Z+lDzomHReJbtDHTPAbcoFjx3tN+A6udkMz3+EDXYgaknRZWWpV0
	WXXpsuy9RvzYW9B9ZD/YeruppGKEudJnzkEYnqhKyjF9IjIZ+DGb4iIfiZdiTKGc
	3+ThVJ3BCkXlUPJ4YpQsSKoUojI+GvnQNx7CuuI6nePEWyhpwkHxibIpgtmpOn+I
	BDTOA9el6up20RMZr8AiMITN69rjPp+nvGSXLaFAslSRmlHN/CbW0I+0tt5aMzGF
	4xbQZNrM6KNGC8EDV05MbOGBBQsxHIRSZkSRSBOpamhBGWbEE7uLcoUKvZ3FVd/W
	58nWBj/Fdy/yzZjcbqAqWA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b4e003y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 19:48:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TJEDnE023907;
	Tue, 29 Apr 2025 19:48:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxgkvy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 19:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWMTz4xRK8zCvj27LGCO4/K+X5ozMGLkQ7WLGg2wMmvX6HHboqfh5unstNs5h2bJRxZL1aoNzaxhqClqfvxD8LeOsydHplUt757+iFrsakJBODmOjHWM4NygU39E/ADr17sfiUt3lzGGFJqtJk/BLFiAQGOre7CZwfa11nI8kiJCW8Iow2ZPf2oyfNyhs4PJYnIbBAbkO+N5MUR8ju1ETO3MoU8s4o3nbmDHE/tpqHwZT3hzRsV80PcD5J8tNfVAG940grf54HfwQ3jhxYBrAoppL7lgqpR4j7qzVIHON1VbWRANhTO092leE4ZwFT3uLdJpI0uVFxernxL+c9d8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B55UodQH1DXLAeC8XlUEiLJCc4EKOGNiW7iS37ed7c=;
 b=lgm6LK6Zx6CvDM6rkMRqCJFSrcT0jYaDZ0Jqy8hgqyXWEw1wMl9VV8QtmOo/75/lMNRuebAr+ToZ6yChYkQLbFVqJJ5jQjLY8AgtuyucBlPxEEyhjzf5Cy3/qcanXUBFgM7CXBeACNngS4axyzEtc6pgId3NpnLExALB7oLdcYBG8O6afxwqsiqXjLBnmVioirfMKcrgsfOGLbtNX252kOU+ysVoSnqP40aewPDt+b3arr+KmKvu3wCrpKE6pv5N47T77EvI00JuvPN8VXi8dwRAiQLzwH/TFZSd9Imwqe1Wng5meNlkWa0epSszVi14De/GtHeYZYdFz4a3fcTm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B55UodQH1DXLAeC8XlUEiLJCc4EKOGNiW7iS37ed7c=;
 b=DDGmu9LXge98n6hpa/2suzx/U93Z7GVYcU2KpBAxWHv1yaLPYAgQeBd3tlmML8l2lipMa+aE7vb4tKEjrjPhPdoFzrQybMfGj0RwWM1vCQcoabtvUBKgvmqNhH2gjH/lm7hkr2IpKMqMWfOQxywE3CQHY5tBwvlBJ/mh0CBfQ5g=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA2PR10MB4634.namprd10.prod.outlook.com (2603:10b6:806:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 19:48:01 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 19:48:01 +0000
Message-ID: <39fd41e0-2218-4c70-b79c-83be3eab30e7@oracle.com>
Date: Wed, 30 Apr 2025 01:17:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
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
 <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA2PR10MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: f53ac656-052f-465a-652e-08dd8756bf46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3c1eWFmN3ZhdmpFSEprc3QySHdTV2pvRG5xalRJK1VMMWhDZ2xMd0RnNFBu?=
 =?utf-8?B?cTJqUmk1cFVOL0RETzBlaVB5VWd2M1liQmUzcUh6NERqeUNLVlk5WkVpcTAz?=
 =?utf-8?B?NXBUVzdQYWp1dXVuWjliNGQvbWxTc3N0U0F4NjFCOEdqOEgyWWZwbXFuakxJ?=
 =?utf-8?B?RzloOFdzckp1SVNZZ1o3RVNCR1FTNDI4RG5kYXdOUkdYdEkrdDl3dkt6cDhK?=
 =?utf-8?B?UjdVTW03aXdvd1pqdVVvd3E2V2tkS3pnamNkc3l0eTNFOFNEQWFqckQyanM3?=
 =?utf-8?B?L3JxdUlyQUUyMTV5WndlbDNGWFhVWWJ0WU0vOUdtM3lLMmNGMzIrNkpaWmNh?=
 =?utf-8?B?S0RDem9GaGxvdXpLT2JsWExaTExFZUVUcUdhcFhIdkNKMGx3RjBiaHRERWI5?=
 =?utf-8?B?TWxZUnVqNjk2VndpZ2p4Z0R3Q2RDOWZWQWdVdVQ3TWpvWFpmSyt5UHhSZFQ1?=
 =?utf-8?B?eWkvc2pPYno5bTFpaWNzcXNRcDZvQU1ESU1nOVFieGU1VnZNVXdtM1h5blZG?=
 =?utf-8?B?TWhkN2lSNVlOK1RwTXJJQkQ1MEcyekQxcjFBSUZYZXR2VnE4dUc0NU1JbjBn?=
 =?utf-8?B?UjZUWVVaUHlXckUwUHJITFVLZytITnRMWTNuVDQwL2tzT3luNjkxdkJRb3NV?=
 =?utf-8?B?N2FoVHlrakRFK05EcEE1QTNDTmZzZVpMRmkxem0wUDR2M1Q0UVE5WXZENUdZ?=
 =?utf-8?B?MVN4N211R2JDU21PZUN2NThsNmQ4ZUtwOTc2cmVUa2NaNmVaUkN2ckV1RXRm?=
 =?utf-8?B?NGV2RmxUdHIvRWQyRGFjWEVrbDlmQ1ZYVXJodDVKVE5OYW1hbDM3K0tKOXBT?=
 =?utf-8?B?eDVaemlxMlI4VU84Y2U1N3lsQThlZ2oyaUIxWVZUWEJ1NnB5VGRCRCtwYitH?=
 =?utf-8?B?aktaZ2haV0M1YjdDOFpYMDJUcWlXVUE3M1l0Q2FVS3V2L2VNc0dvTDJ2bHFt?=
 =?utf-8?B?TUt5UnNDS2Nid3VpY1VsdnNXenlZd2dTUVh3WjBNaUljT3ZoOTVkMENDaDhD?=
 =?utf-8?B?dFB2VEhoTlZPdlZJdDhrOFEvMk5jVWkza0tDMC90Sno3YzFCT1N5eU5kQ2JP?=
 =?utf-8?B?YTZUcUVobkZUMDU1Sm0ySlBoSWQzV05WT1ZRcUhqZXpISThlanA4SzZML0ZN?=
 =?utf-8?B?WGw0eGJhREt4T2JlY3ErZXdLM1J6cmRSRk96R01Hd1JhaTU2S2RKd3ZWbUtD?=
 =?utf-8?B?ZXREemx6WnNVdWtTVWJuakpQQmxzM3JXOXpVWWRQczBXaHh3aTVXc1ZKRFE0?=
 =?utf-8?B?R3VoZzl3NUI2bjZBcEpCN0ZjQzhzWVIvd2QzckdGUGplbWx2dzlsODlqWFhU?=
 =?utf-8?B?Ym5aaFdXM1QxMUlBQ0NMaDNxaHczTnVTRWc0dDlNcjhzUmNwWm50QXVNTmZt?=
 =?utf-8?B?Y2ltN3NWdDVqRUpmT0VncndFUmZlRkZTZkJMeUx1WW1PcXRWQTVkWFhlNS9M?=
 =?utf-8?B?bGVmQTBTeVhoU2k0N3hNK3JtS1F5UFl3NWNHTGMwMlJ5U1F4N3Q2UE9INEVv?=
 =?utf-8?B?V1RTOGVqUmVFTTdXd0NGYlBjVlJkbXdwVXJnSFhTK0NpMWNMOWJRVWs0M0Q3?=
 =?utf-8?B?SXhPWVhZS2lzSFFjUkVjUmk0UDlyU203dHlNNlMwZjJ6VERwTVA4K3RBUVhG?=
 =?utf-8?B?dmRVcnJPNVczZGJCYUs3S2pLdG9tVGpldXdRZmRjT1VKRnpYTWh6Z0ZLUXRH?=
 =?utf-8?B?Ym5kcTdXN1FydWpjdDBuQnFOWHVLUWtCZ2QyS21aWUgrRjRHbkJGWmRHWlhz?=
 =?utf-8?B?cnpvYkI0amx1R3BUK1VHYWdLSllabzFWeDg3YktaVHJXNlYrb1QySUdReTlh?=
 =?utf-8?B?NWw0L2VxN2tiVWxpM2hnbS80ZVpkTjdCZDF0UTJqOVdPMUlTWHZ4aUVtSmxK?=
 =?utf-8?B?NHBVeHJ4bjB2bE03dnB2UDMrem1EbXFKbkwrVXp5TkRuKzBya2svenhDK3Z6?=
 =?utf-8?Q?o+92lwO4VrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkR2NmFRV3JqcittdkR2NXVpK3hPOU9lMzIvL0JDb3R5S25mbkFOZUY4N283?=
 =?utf-8?B?QVAwWS8xR1ZUZGRlVDkvb0hwZnJTZzNPSkk3VFpCSmcvSnZxQ2gxcFdVeVU0?=
 =?utf-8?B?UXFwMzhqeXRZMlYvcVhEOHUxSDQ5aU1VZHJCeDR0N3N3Nm9kZ3dJTk83NTR2?=
 =?utf-8?B?TjhIRFYrMnpHd1ZrR0FUTEQ5T3FWQlhBZHNhUUt1cHdmenU2V0l4aXZtVndm?=
 =?utf-8?B?ekxybHVsNEl2aGdWYURnZ2VHOU5ONnJ4UGhOZ2JPVDdwZkxrb2o3R2NTM3Vq?=
 =?utf-8?B?WWY0Vm5RT2J0NkYrcUdoWEl6WkplNGJaeVREOHhFcE9oS1BwNkhwYU50OWoz?=
 =?utf-8?B?SHBHbFhibXRPVDNLRVlKWS9nRVZRWFhqKzJRV0hxZC9YN2VCOFdLbEtNRnIz?=
 =?utf-8?B?dW5IWUpIVW9kdzRjdStiMHVvZE9La0M1TG8wT24zaEd6UWsyYXNwbDNEK1FX?=
 =?utf-8?B?NXk2YnJDWWhwdC94L1hPL2VDaEdQVHk4Snp4bFFVQWFrQmNmTS92eTJwdmw4?=
 =?utf-8?B?MTV1WkxHMWRydWtsSkRlS2xUaXR3eVlhcGtHV1RVQ2x5UWlHUkJZYmo3TCtm?=
 =?utf-8?B?RHgwWFIyMWViTjZJdkYxdysvWEdCN0xDaUZsd1RqVmxWMTZURzcyOU9WaldL?=
 =?utf-8?B?b1NzK2wwcC8wRmNjVHFGVG1GakZkdHlORzFOaUlPcXFpU3pIV1dXOTIvRTZt?=
 =?utf-8?B?YTF3bytjYktxL0xNTUFLM0E2SWNhOXBBRjJDQXVTdDh3TVRaZEdaMjJJR0lT?=
 =?utf-8?B?RGxqM29BcERVVUVHT1RmcXdvMXBJaWJGQnhOSVZIMEZXRFlSREJtc0poZ29F?=
 =?utf-8?B?ek1JcmpqclI1VlFFVG1sUnpPdW5HRmYwZDhQSnJZekNvLzFtNVh3dmdVdFlR?=
 =?utf-8?B?YU84SktmU3FCM0V2KzM1L0x2UG1qeUErdWZBeWVpVDRQbXN5TXV3Um9Rb25Y?=
 =?utf-8?B?WFR2TkNlVGV3cXpiK01uMFQ5MWVtUEtidkZzU3p0ejJJNnFZaVhLS09pa2Nr?=
 =?utf-8?B?NEtaSlFvVlJ6ME9IUk41Vk10TTgvdWVSQmFxUUpNTE5CT09GM014SXdhUGZv?=
 =?utf-8?B?U2JDSjlURjN5WUc4bUNYNXp3MjhJK2lXT0dyejZIemdBMUxNYUNhTE0wNDkr?=
 =?utf-8?B?bUxtRVl2dGhOc3UzQXNGRGhkQldqb1lXR3VrcjJCc2w3MEFJaTlQNWtMMTJN?=
 =?utf-8?B?YVo2blBReGVKYU8zVVNBdFdXSHlQYWUrUUFEb2JmQjd6OGVFNVlaL3R5My9J?=
 =?utf-8?B?R3k2djZ1OVVuVklBOERmWERZVG04cHJEUTV2MjYzMzFFSkY2ZTVqcjQ1emQ4?=
 =?utf-8?B?TGxmOC9XWVVkMzhYRjZQYW9BRTR6RDFFV29HNnlYRTRYZm93TGxzYTIvUDVT?=
 =?utf-8?B?QVRxMzFFSkNCNTU3TlVrYUxydnQrNmxQZ2tIZzIrUHozaGU0SlNSdEhpQjZL?=
 =?utf-8?B?d1oxSk9SbGFUWFkwaUF4NVBmcTVHOGc3dTNweVJwSXFteGUvTE9EVlBzSEZK?=
 =?utf-8?B?VGI5ZDV3ZTUwd0ZYei9GWXVQSlZNNVFmd0JjV2ZSaFp3RVpVOFpsSExlV0h6?=
 =?utf-8?B?WDQyRkdaM2cwdFY3R0ExMWpEbGlMNXNQeEMxWm00QmdGYXIzTThlVmV0eklD?=
 =?utf-8?B?ajlUd1VsMWVWYk9RVWZqK200SmliNnJoM2pwaldUVXJ6cFBCZ0RoNFYwVlFP?=
 =?utf-8?B?ZjZaRFVMZHhaOUNZYnRiRExLRVZwa0RyZmUrWUNubmVuSXZBb2lBY0pRYUNB?=
 =?utf-8?B?TWhGVFRwTVhsNWNsa2MwWjE1ZkZYYXhmOWprNTMzVXF3Tk4zUmtUblQ2ZGlC?=
 =?utf-8?B?bGxLUFNPVlh0VEJEN3dRdGNjVWxCNEpsM2FPQkhucjhZYVgwc2JHbjVqNWR5?=
 =?utf-8?B?b3ovYXIvWUJlL3lnREtza1d4VkljSjRmRzVkc3dWektraUF2N041OWN5S3Z5?=
 =?utf-8?B?RzNJYnpZK3A4cDFycUtnR2hVRUJpM0NoTEgycEtRQWtOV1lETzhnN2xTUlJO?=
 =?utf-8?B?eXNoTXdEbVlXVUR3NEdUUm5vaCtNVHducERDQWVJb2p5NURJczIxT1E4ZVBV?=
 =?utf-8?B?K05kWGVJWFhEZWU1SHpJVUxSVGIzNEJNWVpHMDhua0twdzR5dEVEZzYrajRV?=
 =?utf-8?B?dUFnSmgzb1htVWdKQjIrWnNjMng5Y0lsSHhtTzFwUmVLbFpzeHZsdnVlTVVB?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zmrvsmndHZOYLpq4eIXcuMo79uTitp1wYXrAk933XjtMggFR0XbHoWbEI1xHrP4f/7N56sUfoA/rdBgKrexPoLKofdYxQf2q94gKVFkAkyRCXc/qQ+wtWu1PxHvK1V6fP0t8+8dNfx+zAo/kpivF9TtJ30DKudDQ4yYZcsrzOZjybg9vmxl7Av4pzfPrvqWdQ9/tTCc6YTNtd5ScQMiQbj5RDRLptA5D9KLKKvnmTyz0wWufBweZzyjK8Fu2oT8KDvjQ5OgSBuDx5Y3EUUYpXh3DNHfa7099CQbqJSSBY9j9E6th2Qc64qxOhMwZgjS2FwrX/wT52XvZJd3gfsaXX4GoJS7wc+wfP7arKMM5tDttkPUeUoRg+6YadItuXsgKmLCvdGQZxC1WCVuyBgElCdTkMswKwFkH7KhIKo89xbU4K/R9M6oxQY+fJHX3Uzb10ccfMfY3OoYnLY3qQWaurO/PXao0beW7TdmmqceEFHX4UdrJYq9fSvHHO4+LwpsQ6KgBJpNBb6rlTAgFigzdqzIJbq/1ni1b8955p0DfzPuU2kpyVFlh9zoQ3gBobDeS8AxBfY2yzp70NGSDg6JXvuVVhV0SFKvnJ+/0UUNIJIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53ac656-052f-465a-652e-08dd8756bf46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:48:00.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fMG4L82k/btM+ApdVkIVsjyHWoOoOXUzRg8GKxpoZvHVJJQIsc3lEKgeNkZAaMs92EeJQok/TpBwgnoFI7z+er8gfANZGiqXuZSTxvI+dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290146
X-Proofpoint-GUID: Ws5vuzqcgZQoQi_xWWcah1eSLLCOT4qf
X-Authority-Analysis: v=2.4 cv=RdyQC0tv c=1 sm=1 tr=0 ts=68112d10 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=Ujh0E6Sa89lvdzjidwAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: Ws5vuzqcgZQoQi_xWWcah1eSLLCOT4qf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0NiBTYWx0ZWRfX01GQAcWnxOJG ur1n7OZpYN00+CEDD2MkmXci+V8uYmAKn0KemLVNM51o2AzP+My/I6sLGnsCOMdmRU0ZlTbnzgF L2vIlTlv5yMHxCw5X2Kcs/v7eiqN/bFvEfesP9y2Evj3Nlr+CbsbUZiCQP5rfqATTxhod6fiO5A
 bs3lRcBPag+ufrlS5Sk0U1TmIsipnfNQruBCs8KKJ6FuFbxSjWq+8yjOMO22rO2GcOJ6q4CDcHq 5mJG7PF/JgnniThdNpDwM1GuzOMb1lwrpyjY6EakAYBnzIBSZ331d/RHuFnahz9mgFO+kBae++/ 251OtBhctyeuQVWFbdn5ea/C9gcdMByvJ6gUc656/6LVQqy8cyBZ24qis47XTSvnFzyG5THnZbn lbIAwb6w

Hi Nicolin,


On 26-04-2025 11:28, Nicolin Chen wrote:
> The CMDQV HW supports a user-space use for virtualization cases. It allows
> the VM to issue guest-level TLBI or ATC_INV commands directly to the queue
> and executes them without a VMEXIT, as HW will replace the VMID field in a
> TLBI command and the SID field in an ATC_INV command with the preset VMID
> and SID.
> 
[clip]
> +
> +/**
> + * struct iommu_viommu_tegra241_cmdqv - NVIDIA Tegra241 CMDQV Virtual Interface
> + *                                      (IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
> + * @out_vintf_page0_pgoff: Offset of the VINTF page0 for mmap syscall
> + * @out_vintf_page0_pgsz: Size of the VINTF page0 for mmap syscall
> + *
> + * Both @out_vintf_page0_pgoff and @out_vintf_page0_pgsz are given by the kernel
> + * for user space to mmap the VINTF page0 from the host physical address space
> + * to the guest physical address space so that a guest kernel can directly R/W
> + * access to the VINTF page0 in order to control its virtual comamnd queues.

typo comamnd

> + */
> +struct iommu_viommu_tegra241_cmdqv {
> +	__aligned_u64 out_vintf_page0_pgoff;
> +	__aligned_u64 out_vintf_page0_pgsz;
>   };
>   
>   /**
> @@ -1152,9 +1183,23 @@ struct iommu_veventq_alloc {
>   /**
>    * enum iommu_vcmdq_type - Virtual Command Queue Type
>    * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
> + * @IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
>    */
>   enum iommu_vcmdq_type {
>   	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
> +	/*
> +	 * TEGRA241_CMDQV requirements (otherwise it will fail)
> +	 * - alloc starts from the lowest @index=0 in ascending order
> +	 * - destroy starts from the last allocated @index in descending order
> +	 * - @addr must be aligned to @length in bytes and be mmapped in IOAS
> +	 * - @length must be a power of 2, with a minimum 32 bytes and a maximum
> +	 *   1 ^ idr[1].CMDQS x 16 bytes (do GET_HW_INFO call to read idr[1] in

This line is ambiguous to me
intended to express a power of 2.
1 ^ idr[1].CMDQS x 16 bytes -> (2 ^ idr[1].CMDQS) x 16 bytes ?

You could consider like this
(2 ^ idr[1].CMDQS) * 16 bytes (use GET_HW_INFO call to read idr[1] from
struct iommu_hw_info_arm_smmuv3)
or more clear (2 to the power of idr[1].CMDQS)

> +	 *   struct iommu_hw_info_arm_smmuv3)
> +	 * - suggest to back the queue memory with contiguous physical pages or
> +	 *   a single huge page with alignment of the queue size, limit vSMMU's
> +	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
> +	 */
> +	IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV = 1,
>   };
>   
>   /**
[clip]
>   	struct arm_smmu_device *smmu = vsmmu->smmu;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 869c90b660c1..88e2b6506b3a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -8,7 +8,9 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/interrupt.h>
>   #include <linux/iommu.h>
> +#include <linux/iommufd.h>
>   #include <linux/iopoll.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #include <acpi/acpixf.h>
>   
[clip]
> +
> +/**
> + * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
> + * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
> + * @vintf: Parent VINTF pointer
> + * @sid: Physical Stream ID
> + * @id: Slot index in the VINTF

@idx

> + */
> +struct tegra241_vintf_sid {
> +	struct iommufd_vdevice core;
> +	struct tegra241_vintf *vintf;
> +	u32 sid;
> +	u8 idx;
>   };
[clip]
> +	/*
> +	 * HW requires to map LVCMDQs in ascending order, so reject if the
> +	 * previous lvcmdqs is not allocated yet.
> +	 */
> +	if (index) {
> +		prev = vintf->lvcmdqs[index - 1];
> +		if (!prev)
> +			return ERR_PTR(-EIO);
> +	}
> +	/*
> +	 * @length must be a power of 2, in range of
> +	 *   [ 32, 1 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) ]

2 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) or 1 << idr[1].CMDQS

> +	 */
> +	max_n_shift = FIELD_GET(IDR1_CMDQS,
> +				readl_relaxed(smmu->base + ARM_SMMU_IDR1));


LGTM, aside from a minor cosmetic thing.

Thanks,
Alok

