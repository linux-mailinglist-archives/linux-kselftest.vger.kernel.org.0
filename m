Return-Path: <linux-kselftest+bounces-20608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45E9AF969
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 07:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFB2282AD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 05:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640C318F2F0;
	Fri, 25 Oct 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sInP0h+S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691418BB89;
	Fri, 25 Oct 2024 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835928; cv=fail; b=bpnAaygDdQbMWmmyASI3Qmx+XiHo3xMbac/RixLGmJ5+86y0UR0KqKkG1aUYyus9NTbruYpWq1w7t3GSWYWk61CLrPI/79AUqwmt+fVTq/3XkVYgUrmaszRCMBnIerZ7MGnC6FQJNRqSQ/JUdK/uUK2k6TFnmYjjTac4Id896co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835928; c=relaxed/simple;
	bh=O6Xc2vLoCuODmmoX7LpIqxroaxOBq5FFfgbyccpTvho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cg4cGOYid+PGOXwG/VufxfehoRyckXo5ycn+AmcAMGV6FETQ2r+StaTGFzZK8RJMnj+b/zBLDnFbfjUZcX97Txllgd1zWCTnyvT2XHWn+5XrtjhaUdkGt1SFeFUheCivlfm4S2ohstOzE/qAjRCYPdSN32itGiKRXaclg2wdbAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sInP0h+S; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqqSbulRZPgIN4FerAr2joaxEx/XhzVLB9tYZQoZ+/eg/CliSm8v8ovNecfqX9sZ3lpQg2od8Pj/T61tbjEZVwgSSSCdO/uDLOytzvHGwVsAOGnYMTGVE1dtOyn053jEzooJ79FCuZQBqq89Qz2oD+Xxr4aXlLTRr7y34VJxsJbgojQPJFBxoU92LuPXrfIS0HLeYsdII0Ue2G+vOp8QFevjnTDMFKcijv1hjT39HgdQi16f2HS7SmT7C4uxdtVRK1ZCvd4/M2Ty+wyS7z1GuBwz4DylDSkFSEj3lsS/H/dpPf6ORDNrE7Bx6+6I4PcofxiCdWBiMcMwdkoZfGKPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHPFv0ip7HCJfpY8mXjRdpzfNRb7TydUCSBeXjmkHv0=;
 b=aZFnjfae/w49J5uiFPeguw32BrDlVVVOWNKPycdXfnYUXpLYkkAKi45X5azihzYVy96OCMPQVq/z2gUxw9d6CYipSN6XWx+xV2PAJPr4nMlyygSfg5z4dKIvBM8/+kYfvBKEqL3HDKPrP/KdilirkqQ4qz/FXg397CzWYscF7WYcrSibPE2dtGFkEh74hpRvtMmuM9AltQeA8HjMnEFcD3uS8NmP3vW1aGjrd59SU91sR+Aojh2GuI6QmFbWEOSeOHi5Oi9gi43Ovaum23ZPDcu5SAAa2Byxnsw2qO5kLWyrMEU0oQz+HPRJm+ZpVAFZuPgL9uaPudgqZIpL+djMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHPFv0ip7HCJfpY8mXjRdpzfNRb7TydUCSBeXjmkHv0=;
 b=sInP0h+SHEuc52ZWeM10lkGrLXqUuvx1DFSZZ88HJhK0iHbE1RXDc4E93Plbmux22nzOfwfz74+e1e7wZSYbyJvoxY+mx25uvN3/pAxDyrURZmPIiX4hWT2tf5AY4SyRv29LF/74jytEmJjb4v+OvN3R3mdgObYZpLTEz4HF76E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 05:58:43 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Fri, 25 Oct 2024
 05:58:43 +0000
Message-ID: <607d019e-25b7-45b8-8c85-3829d4b53a82@amd.com>
Date: Fri, 25 Oct 2024 16:58:33 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
 yi.l.liu@intel.com, zhangfei.gao@linaro.org, patches@lists.linux.dev
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
 <ZxslrakslZbphayO@Asurada-Nvidia>
 <487ebe2c-718f-405c-8f20-213eab59ca0f@amd.com>
 <ZxsvofcC9xSSEMHi@Asurada-Nvidia>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <ZxsvofcC9xSSEMHi@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYAPR01CA0031.ausprd01.prod.outlook.com (2603:10c6:1:1::19)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c16caa0-953c-4414-f900-08dcf4ba14aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGh0eml2OERTb01JSzRidmFyNHV3YXNTcjRyb2hKcEI5TVB2WUpOWDRjcHF1?=
 =?utf-8?B?L1JuWGhtYmNWZ1MyWUgveUlUbzFvRFhpM2hKMlJ1SXhZQmpVVmxIbnZxeGRQ?=
 =?utf-8?B?Z1BNK1N2SDl4S0hFOUdZUEYzeFNZaGVxWGtNZnlneDlzOEVDYTUwUWdQajg0?=
 =?utf-8?B?Z1huNk55MndCd3l3NjNtNTdXa0hpaHN6WmlBeFBBcDlzUStYVTBaVGsxZTZT?=
 =?utf-8?B?SFBKVEJSOTU1Z3N1d0RHUFU5L1A5ZHEyOUF5cjdGbUlaZG4xNDZsdnZac280?=
 =?utf-8?B?Vk1CWkdKSWxtdnZRZFF4UDdPazNnemVLb0ZocTdHb0ZpcVo3WG5abHZGNlpX?=
 =?utf-8?B?VTIzRlNHU3BQOHdFR1lPbmRCL2liVEdtcFBIai9nek43dHV4S3R2ZFBnbThM?=
 =?utf-8?B?dXpUVUYxdkhyUXNXdjE0aERsWERuWEg0dDBkdlJWdjFNWXRMS1lRcjRYaDd4?=
 =?utf-8?B?dHRkS2FLc1lWSE1oSHlRU0tYTUNkWDFNRkRZcVJ1SGlncDVJYTBTcWJacnlo?=
 =?utf-8?B?TVZWeGFCcm5EMWRkaEtXdG9SODQ4OXl6aUhHRHp6NFZVUkFTcTZWY3ZjYWtH?=
 =?utf-8?B?emQ2dkxDV1M5NWxrRUFvNkQ5ZnNsZE1MUkYxRWJLNXhlbXFBajduYlZ1U0pm?=
 =?utf-8?B?cG9Rd1RoOXRIRVFrUzFBZmNyYldFWUFsYzAzV01pZ3FYZHJkdW1TQ3pHZ3RO?=
 =?utf-8?B?SzUyYW1EK294cDVIckhZMlh5RmluRkkrTGVoRUpOeE9hK2hLeThIUzF5K2dM?=
 =?utf-8?B?NEorTG9YZGJDTzdwU0Z0SzJFdHRjQ2FJcXl1UkRSTGswZGo1YXVCNUJTNk9B?=
 =?utf-8?B?c2lkM3J4WUhadXhyVWtsa0F1cnZEZFRxMzVyQjQzR2xRVzR0Ylo3b01ka2pP?=
 =?utf-8?B?SXlaTzBheGlwd0g5dUgvT0xyOEZGV2F0Tit1UUtUczRpWlZhRGNwQkxRMkNF?=
 =?utf-8?B?eVBDNUlKMGplZk5IU2pmZ2g4MkJ6Ti9jYXlWeFBXcHBtTHBvcGliUmJKdFcy?=
 =?utf-8?B?b2JWN0w0Sk83K1BFbzVaMmw1TnBNRnAwWlUxeXRKK3hUZXlTS2FKS1dtL1dW?=
 =?utf-8?B?akFZVHc5WEVnL0dtY0pwZndxSURWQmQxcUlBdG9QQk9vcHhiK2hzbDEwRm5a?=
 =?utf-8?B?RW5zTlNzUFloRXQvMnRRajJxNGNxbkRpbWwwSURXWXVxZjRXbDFUUk52Wm51?=
 =?utf-8?B?eGZpZm9wdVcyL2lTQm5yR0dnVy94Yms4aHdTWm9hdHBNaVBCTURGdGw0TjB5?=
 =?utf-8?B?M0wxTEJWdVp0WnBGMVlsU1I4VWtnUmtSWHZoZFlDREczY2F3ek1LSlRJQkdi?=
 =?utf-8?B?RVE1MVpwMEVSZzhhMDRSTHY2eHJlSXBvMkh0d0NidWlzeVJ0b1c5M2kzRVlZ?=
 =?utf-8?B?QlA0a1NDSkduakJjRmticDZIV3A1MmlqMjZFdnZuSlNzQ0lLVUJTSnBjUXVK?=
 =?utf-8?B?c2F2V3VFNTROa285WGRRSW1IN3VsWkNHdEE2ZklwNUdVdEhueVAwL25lNGtD?=
 =?utf-8?B?d3FGSllabVhsdXdaWStFcHZSdkZnVmViVVhiLzlZSnhOUkJTL0t2c2tqNnRn?=
 =?utf-8?B?ZGd1bG5IR0I4TUZSaTAxVWgrR3BzNWFJL3ZtNGUvZjFnd0pqWEkrYjNEdVky?=
 =?utf-8?B?bDlMRC9pelJSc2szc2pIb1M1TDJ1RjRJbTFvVmFBNVhyTmdhUllMSGY3SDdp?=
 =?utf-8?B?d0hNMDNwMmtmcFV2OEJyL3AzTmI2RFZuU0RIZ0V1bW9jb1owOXg1WERRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEtCc0xYQXlsUTlQR3ZOWFFvV3VzRG0rS0drbVAwcTRmMTZXY2VsN3JkTjJS?=
 =?utf-8?B?MmNCUm1HMUt4V0I3L1FyQWNkU3JxN2lSaENWUmVLWTBHeFlLNElWeUZxY3VO?=
 =?utf-8?B?SEp5S0lvblVKK1FUS0xvQnBGMHdjQklZck13WnpWeDBzQ2dDOE41aEJNMkRn?=
 =?utf-8?B?TTZHU3Q5WVlkME1Oc25TM2pPQXo4a2RUTWJXanBKSXFvYitpVFVWcUNqYSt1?=
 =?utf-8?B?YjRDdmI1a2RWbkNGTmJ6c09TcUMvZFFBdFd1ZEhydjdYbUZLOUEwbDI1aW1E?=
 =?utf-8?B?VzViY2liN0ZkMlZiNW12N3R2d2FXUldZdENOSmRacTgrVEdpcDZuWkliUStM?=
 =?utf-8?B?VFAwNTJKdWcrR25mQkhpUFArOVc0UDFLQ3dXbjZtTGlkcU5VejQzNEhQUDF5?=
 =?utf-8?B?aGZlT0RTbXFkdUVLY3RwSTZKUmFxV2tPNHRmbjFLZnNHSGZCdEN4UHdDakFo?=
 =?utf-8?B?WHprblZaTE9CTVdSYnVJbVlGQnM3bG00ekFmbTVHdEl6SVNzL3FHUUc2WEhK?=
 =?utf-8?B?QUlTdHVoQW05M2lML3Q5VDMrVnVISGkyVFc0bVgrSUl1UW03Tm9SdlV0OWp1?=
 =?utf-8?B?VVNXYW0xM3R4UUFYYnlObDF3K0dISk9xSk43V3lsaUFUWFZvMXlTQ2xrdHpO?=
 =?utf-8?B?akJXdFhJU0lCTzNlS1kxT3lmQmdHbFA1MFhybm81aXoxMDBWWFFNVTBKUUcv?=
 =?utf-8?B?K3I3UmZUVlVoQ1FOb0ptNmVpZ0oyQStXL3RNR1dZKzJOakxaenBCaGQvb3JO?=
 =?utf-8?B?Z3BBOUM5aFdJS0JGcVRTYWNSNzN3NDZub3hWS0lLU1VTbXZTQkNpQW9heERT?=
 =?utf-8?B?TjNXbUtTWVJLMWl2V0t2MlZrNlBma1paRm9Kckg4eFRZMkovdFlvTitqeUJR?=
 =?utf-8?B?VGFXOWx1d0FpT2hZQ2t5M1BnQVpZeWpab1Z4b2xEVUZxZUR4L21jUWt2R2tY?=
 =?utf-8?B?T1RSRVRaSU5FV2NyTlpMcGo4QzhVRE9BQTJOSEVhdnpqNDBReHF2RHNkY2VW?=
 =?utf-8?B?S2dJRnkyYyt5SnRNQWc5N1ZJM1pRWGI5Y0w2VVFwZTE2Y2cxb2luMFptV0Z4?=
 =?utf-8?B?QmNUbU91QjBpVnVtb0Y3REI3QmZEUm83dGZ4bnRGTGJqRWdtY2xlTzA0ZjZq?=
 =?utf-8?B?c2lTVDN6NU1JUC9GNC8zdWluRTZidWdxc1NWeHlTNE9RWXlLQmtVeFV3dnFp?=
 =?utf-8?B?YkFtWE1nZ09EUytvdGlwajJRdExFc0ZpTkkyOWJJTmtBUkRtQnhQOTEzdnNu?=
 =?utf-8?B?eU5rUHdkNW1QNWlmUGl4ckhUdWU2N2lwRzlIUDZMakY3SjRLMk9rWFhnaFVm?=
 =?utf-8?B?MldFV2d5ZVN3WnJhN2EyTjZZN28vZEVVOVpJT1NrdmpJTjhvNGNKeWhJRTFZ?=
 =?utf-8?B?dlNhNWljcndjQjdqZ0UvNVhSaTVwMGR5R0lqT1JkRXZJVko3Z3k5UFRobHg2?=
 =?utf-8?B?V2pYcFVVL0dKejNSVWttK0dJMmx2NkZVUndwb0tvczNTcWxFeUh2UXlWNDdQ?=
 =?utf-8?B?TGRqRW51Y0JDTHB6R01HMzN3SlEwT0tnMnVHa0g2NnVkbFExK1Ntc1FwUHRk?=
 =?utf-8?B?SENQY1JhNWliU0ovZ1hiY3FJSXFGQkNiOFdqL2MxNmh2R0xLWFprR0VmdEtu?=
 =?utf-8?B?aFBoRWhhUGN6Q014MSt1QjRVMDM2MzJFR0RBZUNzTmp6Qi91VGhzUk91cGRR?=
 =?utf-8?B?cFZHTlpyS1JyaDNtUlhxOFVTRVp1U0gxK1o3S21VSkFSdGNFQTdaOEt5Tkhx?=
 =?utf-8?B?Zm01SXZLYnU2cFJqQUNVREVPTDBpbnZSa3NzdGdGbkp5amdOVW8wQncxSUR4?=
 =?utf-8?B?czJqaDdMT2wyVlplNkJXakw3dDdDTC84dXJFQmpjVjN5cS9JOG5wbHBXNTlj?=
 =?utf-8?B?UHMyMGVtYytJZjZycGpaMU9LanNla29qQjUxb2dxTU1KUzhRSmkvSmFRaXcx?=
 =?utf-8?B?L1dhVGVkOW4wZm5RM0NXL0JVdGlyd2RMSnhXanlMWExPVXZTSEwwdGtTdlh6?=
 =?utf-8?B?RUlmeGpRS2s3bXphUEEwOG42MUFnYTZCNHpOSlE3aFdHOFUxZm0zUjZ6UnFn?=
 =?utf-8?B?eVJZb0E2SUx4Z2tpT3ppZUVWdFMvTE81eUJXK2VJVWVyVERPRXUrcWUxZzYx?=
 =?utf-8?Q?9OZ1UJtn/JBqt3WcUvbRYjwRu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c16caa0-953c-4414-f900-08dcf4ba14aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 05:58:43.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhgh/vHSvNKqbJDo7a9mZmX8GEek1rddq/7WchtEKbDJqZ/wD+CNvcO8DUcaxKY9HoAbLyCYe9AgCzQyYgEcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057



On 25/10/24 16:41, Nicolin Chen wrote:
> On Fri, Oct 25, 2024 at 04:32:10PM +1100, Alexey Kardashevskiy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 25/10/24 15:59, Nicolin Chen wrote:
>>> On Fri, Oct 25, 2024 at 03:54:44PM +1100, Alexey Kardashevskiy wrote:
>>>> On 22/10/24 11:20, Nicolin Chen wrote:
>>>>> Following the previous vIOMMU series, this adds another vDEVICE structure,
>>>>> representing the association from an iommufd_device to an iommufd_viommu.
>>>>> This gives the whole architecture a new "v" layer:
>>>>>      _______________________________________________________________________
>>>>>     |                      iommufd (with vIOMMU/vDEVICE)                    |
>>>>>     |                        _____________      _____________               |
>>>>>     |                       |             |    |             |              |
>>>>>     |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
>>>>>     |      |                |             |    |_____________|       |      |
>>>>>     |      |     ______     |             |     _____________     ___|____  |
>>>>>     |      |    |      |    |             |    |             |   |        | |
>>>>>     |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
>>>>>     |      |    |______|    |_____________|    |_____________|   |________| |
>>>>>     |______|________|______________|__________________|_______________|_____|
>>>>>            |        |              |                  |               |
>>>>>      ______v_____   |        ______v_____       ______v_____       ___v__
>>>>>     |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
>>>>>     |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
>>>>>     |____________|   storage|____________|     |____________|     |______|
>>>>>
>>>>> This vDEVICE object is used to collect and store all vIOMMU-related device
>>>>> information/attributes in a VM. As an initial series for vDEVICE, add only
>>>>> the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
>>>>> e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to
>>>>> a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
>>>>> of the device against the physical IOMMU instance. This is essential for a
>>>>> vIOMMU-based invalidation, where the request contains a device's vID for a
>>>>> device cache flush, e.g. ATC invalidation.
>>>>>
>>>>> Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
>>>>> by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
>>>>> with a given driver data.
>>>>>
>>>>> As for the implementation of the series, add driver support in ARM SMMUv3
>>>>> for a real world use case.
>>>>>
>>>>> This series is on Github:
>>>>> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4
>>>>>
>>>>> For testing, try this "with-rmr" branch:
>>>>> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4-with-rmr
>>>>
>>>> Is there any real example of a .vdevice_alloc hook, besides the
>>>> selftests? It is not in iommufd_viommu_p2-v4-with-rmr, hence the
>>>> question. I am trying to sketch something with this new machinery and
>>>> less guessing would be nice. Thanks,
>>>
>>> No, I am actually dropping that one, and moving the vdevice struct
>>> to the private header, as there seems to be no use case:
>>
>> Why keep it then?
> 
> We need that structure to store per-vIOMMU virtual ID. Hiding it
> in the core only means we need to provide another vIOMMU APIs for
> drivers to look up the ID, v.s. exposing it for drivers to access
> directly.

Sorry I lost you here. If we need it, then there should be an example of 
.vdevice_alloc() somewhere but you say they is not one. How do you test 
this, with just selftests? :) Thanks,


> 
> Thanks
> Nicolin

-- 
Alexey


