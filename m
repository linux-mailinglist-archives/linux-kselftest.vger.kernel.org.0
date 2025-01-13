Return-Path: <linux-kselftest+bounces-24407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A5A0C26E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 21:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7783A5606
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F661CF7A2;
	Mon, 13 Jan 2025 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mCd0GN0F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B211CCB4B;
	Mon, 13 Jan 2025 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799027; cv=fail; b=mKvP7rLMMWLnG1/um1snNaBAAD4l/ost769xSfi06stvycdis6Kf1+7QJiIxYAAdDSusMpxVpiQzfRFezmTTIQyRGD7HVKPZ2E4QjW9VWwxYFGJoh+xt+OYh5GTp+ZxDUWNFOVN3lEJwH5unyZh6cD/bpSj6ZDyzeCtJ0NsyzQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799027; c=relaxed/simple;
	bh=VVj1Ymhz0zC8VISr7QCFn3PH3wzgKYnM1o1wVWpJVJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MFWC1UkiB5ijmmGLhPYBOkE/vwQSo47qrh1jEaIZpYnDRSMlPsxLCHdcAQ21wEmGcylncqyCy18BqgYFxPTe6r8TbYxybSTe+HToBOfi8fzayC310VPYYYYGeVdLz3LV74gIPuqczXPBLf5hfmg2XwVNbeM1MBT4cZZiO5kqGSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mCd0GN0F; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFqHQh45HrHiVIhthIlYmooPXjSQxSScj5ZcmghUiQecsswe5jJUkd10rhA/o8NMgQO0iLXaEDeaPfx86jLPK37Q77Is/zZPVcoeYoXqqKqUOWG8MxWa24HPMPpQ8n2Mbb5IMIMegoM9qOSEVa+oRwJpTnk21R7MSnNtkD1iuQRURtA168sqHjTwLpMqq8Q696X/odNDN46bXveW+CM9080ZCmLp0OvjH2f0y56YIGomuuGyn0MLMcpHAEDcRSup+EHQJ7GjFOacjkinT9qbg0nJxk+/FjQXdB0xX+Xp8IEcHnSlUy52STx8qpZietQqIVDwh8d8x0MGmEy2lx4ToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgueIHnlssDcCR0SziTBbVKNf57G98YqKByDW6PqfrY=;
 b=u3yFKO1bgD24Nb6vvd7AYhzoRwRuzCT7XSsjZg2e95DU5sf+d4nzxRDc0cluGgAS6g8x97LlTpR7K8CoKOvDhY7grRgcSL5GQaSyiQPYaZPJf3VhZq9vaNoydZat84D8vlMwjK+FgWwqDPZkaHy+A5k+8aD5ahxLlaANDOmXCqWbRrHfJm32k9PTAzO1HuT8ADCzcgOEO2guoKbMRLMrLlnwfI7fA3AxQVWPtE/H3Dzz/aFN2V8AZhBpQRRm4CHSLgmKTJjDuGkG5iU6M6RFf5v6+eluHAWdv0quVQQw+NypMY1qPYd9YUMHMcDGz25Bce3dp6rmhIij7VF1U4Os9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgueIHnlssDcCR0SziTBbVKNf57G98YqKByDW6PqfrY=;
 b=mCd0GN0F5vzyEKeme10vpmuZ2Moz5PJtSAmIFnIJwDaN/tzlQnMKU3NMfG3K6Bi40Ohu9f+rc6XIOThr7soXMCBVw81LVKA+vBP2pCwodZFLi3tqPk3ZMGEy7jB29yOmA2A4j2DeM0IuY0QQjXF8NloeZrt1zQfE0EJYl4DvXH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:10:23 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 20:10:22 +0000
Message-ID: <ea783d46-0ed5-40b3-b0d4-5b4e741bab9c@amd.com>
Date: Mon, 13 Jan 2025 14:10:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] KVM: selftests: Introduce SEV VM type check
To: "Nikunj A. Dadhania" <nikunj@amd.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-5-pratikrajesh.sampat@amd.com>
 <71ed4121-83dd-4b09-b1a0-1f0654512c2b@amd.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <71ed4121-83dd-4b09-b1a0-1f0654512c2b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:20::18) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 65042446-603c-4fb3-ce3d-08dd340e4f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0VjQ3pUZ0h2Z3M3aGEvSG95OCt1SHlQODUzcVV6OXVVa09nR01LSHI3dWlQ?=
 =?utf-8?B?MXROL0R6bTRpZWRCZlJld0dKMTIySVZXVFQ1QXIvWDJCNGFJZXU3TG10bkRU?=
 =?utf-8?B?UTV6eFhTSWNUUFgvWDRVUjRxQld6aDVGT3ZKc05qVHpVTlRwVkQ1MjFCcnlo?=
 =?utf-8?B?TTFiS21yQWIxQkl3UVI1Tll0VUJYRXJUZ21meE0vQWtYbEhUUFpHTEpkZzlT?=
 =?utf-8?B?NUVnUGxZWllqSlBwWlRTaVRQWjU0OHRvRStHYlJNWTJyalhHcDZnVWYrc0pQ?=
 =?utf-8?B?SnV6UmpqaWx3cWthYzg5TDlKWkhEcDBMVGtzelllZU5xUkkyU05kQjRqT1l4?=
 =?utf-8?B?WTBqV29INk1FNGpGQmN3T1Z6UmkrVnpWRkk1Y0RobkVNbEdsL2UvNWRGeUUv?=
 =?utf-8?B?NWE3bUxBbGZZeE5QbTl5YkFCd1RqWVVTRGZWRkp0NC9qVVhpVUxHSE5aL1dD?=
 =?utf-8?B?RVZQWGRwUVFvazgzUG84UGZ2K3FleCtOYlNLVWc1UEEvWWU2RVd5clBsRytk?=
 =?utf-8?B?dW9MNW1TeHR4ZzYwenVCWHVkQ2xrK3JQajA2eWk3V3JNZllSOTIxcDZpUGdh?=
 =?utf-8?B?dTBhTkRlVjByS0NNQTExVXpKTDI4Yk1qVHM1cTlsV0Q1UVRncnF3b1YzeGty?=
 =?utf-8?B?RVp4QnFnZEdZRUtzNmdzSldESmh1VWJ2eGFlOFM4dHJRWGlRYmVnSW94MDZl?=
 =?utf-8?B?YlNBY0p3Z2FlTUZ3U3dXTEQ0RUxBNXlib0JCS1Q1ZWFTZzRWT3JHU0NsRTNP?=
 =?utf-8?B?QURudXRMUkpUTUxqeFRQTHZzQjJxNjN6TDFxRjd5cmhRMm1vWjQvazdCaDVL?=
 =?utf-8?B?TGVHTFE2VjdsU21WajlrRGRtYVRBajVmYnhYWG9zTzl3SnRFQVR6MkhDZ1lx?=
 =?utf-8?B?NEFLNmc2YU11TzN6Znd3cTRBa1hERDJtWjdTbmRzZ1dDdXVac2VGeFQ5aUNt?=
 =?utf-8?B?SGl5bHFrdS9jSzJrZ2NPTUpuaFpEcTBlQmF3WlAxZWE3aVJ2dnNvYVc5cnBl?=
 =?utf-8?B?ZWhDQjZHRUV0aFdzQ0RtdDlWYmtWc0Q5SU1qb29NTU5sUnRLVXRHNmZkVTR4?=
 =?utf-8?B?dmlkM3NmNExFTjV1TnM4R0pHZFZ2QVZwQ2duUjdmY2MweDBuUTBSTThGQkow?=
 =?utf-8?B?aTR5ZzY5ckxqNEczTkZHOTJFeHU1Q3JZUS9PZkJEOTRNT1QxcXp5bEVSN2dt?=
 =?utf-8?B?L3Rhc2R3QWhnMktnM0RQVGNWVEsrRlN2bDF5QTNod1kvOWJRNHlDWUlySkNP?=
 =?utf-8?B?d2lXTWNOQWVrekViK04rbzJ1R3pTOWpLaUZZOGwrUVR6a2xJbDdDTGtjSmxq?=
 =?utf-8?B?UDlPMml3ckx2dFkxTTNrRzNGN3p2SmI0U2Z1ZkwvVzRzZEMwZ2U1b2FiazVE?=
 =?utf-8?B?eFdId0xkUXlkYktXL2tSUzBvWG5yaDVXMUQ2R1ZjdXFzYjdDc1NrWDFWZWJs?=
 =?utf-8?B?eUkydVl2RXpsMlczeDdLVk4wUE9VcTNMbXhUQm5FbXIraGlpUzI2L2oza1J1?=
 =?utf-8?B?eUhmTzc1ejAxSmNENnlKWFY3ampxcDZqQXlVcU1yT0hWUFQwT3dBVGdlVlE3?=
 =?utf-8?B?Nk1wb3Y4aTVrbnpaMWJvQkxrMm42MkwxSVBiazlBRXRVQXBvUnFXNnJ6NE8x?=
 =?utf-8?B?aUk5ZVZCbkxlYm4rWGx1NmR3a1hTdGdrTlVjcUtnZUpzNSt6ZW81NVY5Qm5h?=
 =?utf-8?B?aXRPZmg5RnQ2cjFMMkdHRktzelc4L3JFSGpIdWdNQ0RoQjJxSGhtVG1CRWti?=
 =?utf-8?B?bXN6M1BLMFhFTmFqVUJqYXd6ODF0OHJ1YTZZNDJLOGVMZnJBY01uYkd0Z0dl?=
 =?utf-8?B?S2RZbk9GbG9aZUhWMXlrR0d6OEJmcit1MWtubWZvczRISnU3TmZkSFJCZDU1?=
 =?utf-8?Q?yVR0y6pDPRtAE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3hlczZHM3cyUksrek41cTZVUnlkRVhOOXN4M0N1dzVpMjB5Z0dZRW8zZVRE?=
 =?utf-8?B?SzNXRTFKZzMzZVBPdTdrUHRVOUtCa3lmc0ZNd1FaUTAvYmdlZ2NiRmFyMVRr?=
 =?utf-8?B?VHF1TThWN0lKUXB2eXdHRzhyOER2NTlyVGVKeDhicldDV0tCMmZwY2tENjVj?=
 =?utf-8?B?N3UyajIvZ3dnMU5KTVVMUkFjQTVsdTZqazlqQlYvU240RUdmbkRaNXZIUW5H?=
 =?utf-8?B?K2xPTkNEOTVNS2pwNWFsb0VabFJhMXJqNktKbE9kdnJFUjBNdHJHdEtKYkJj?=
 =?utf-8?B?cGhJU213VFVPQUJwbnNGaHo4WFdsayttbEdRYkRTb2NJcWZvYjl4bktHTG5U?=
 =?utf-8?B?T3FCU0NGcmRWSVZ6NVJzbE1UaTlmZWV6VGV2SUI4aFJWbldOWHJxT2JONVRY?=
 =?utf-8?B?WFdHNUFvSzBwOW9Ob3p5WDQ0U2prQXJ0N21OTmt3K3RuZzVjdUZNZEJ4R1V0?=
 =?utf-8?B?MUZuek1ZK1JlSHJNOGgwUWg2S1BJRkw0aDFRN1ZPSThlYThia0NlcE9BMmZ0?=
 =?utf-8?B?enNHYTc4OTB4dEhHdUE4WDlReUlTTHhRUkdyMWN5R1BlWnZRa3h3RTlneGRM?=
 =?utf-8?B?TEg3dzRyUGk0UTlxMlZPaGlVVVJheXdqMzRKRllOOG1CZ201UEo2aW42Vlky?=
 =?utf-8?B?aWNJaGFLWG41UGUzeUtlTmdJNFdUeWtRdlBxK3FBcGlLVkxGcVcwMy9NaHVK?=
 =?utf-8?B?ZXpXUHk1UUtXT2czWnRadnZmU1l0SzRNZTlxeEdOcFNmb3A0SVFMWFVXZS91?=
 =?utf-8?B?MGg4OHcvcXdMNlIzayt3ajczNmw2U0wwWXB1MkJLejZvZ0VHUFBveUs4WFBD?=
 =?utf-8?B?VHJiZ05pZytlUDJSYkZ1U0NvUVgza1hvNm1HQzAvZWMyazJydnlmdnBzSXlJ?=
 =?utf-8?B?Q3h1SE1mOWREZ2JSWE5WcUx2djNqeHBoODJzYnBvMkxMUHBESGN6a2E4Wjlu?=
 =?utf-8?B?c2hnQmJ4Y1Iwa0ZxN3BjaHBJU2lsR0NGcmhmR3JVazJ4Q0pOcmpsTFNFYk9Z?=
 =?utf-8?B?LzIyZk91NXRWUnpCSmtJbTlYQ0cremJZL2MwTVFHckpiRkk5cURyQXBPVGUv?=
 =?utf-8?B?TWpxZzhRNGlXNUFDMmw2eFBaaW94TkVrZVJhWnphcDg3S2NRNHV5V2xOMzlJ?=
 =?utf-8?B?bytHK1RDNTNQMFdqZGN6YkpWZ1lOYTdtbCs3ampFMWtyOVZmdHJTaFpBeVFi?=
 =?utf-8?B?NU13c3IxczRZeVlZRjVMN0pLeHdQNWJGUXJBZjlaRjB6RTZESlNqY1Y4TFNS?=
 =?utf-8?B?bFI4WW44QlpxQ3JsdkJraC9Xcjk2YmtycnExVTVyTFpBVXJ6SlN4NnRDdnkw?=
 =?utf-8?B?d1ZEandObHFXVHQ0UWplNjF2NVN6MzZJMWU3ZGVkdllVODRVY2ZBVFRmejRX?=
 =?utf-8?B?TWNpd25MU0M0VTZMWFdPemx1UFQ5VDNxcGJtdDI3ODUyMlI2OEZxa0FzTnFp?=
 =?utf-8?B?ZW5tdHVVZXllOXBBWUJUMXQ4ckkyOU1SRzR5dDdJOThIcGozYmw2TFdBZlBM?=
 =?utf-8?B?VmdTMTR0VkcrOVFaT1NBRVhWdE1SVnpra1diL2tLek5sMndCK09takx6UjZI?=
 =?utf-8?B?VERHc01XZ2FYbTVQaWNQdWhmMjhaU3NGN01jU0RGMzE5Rms4MmxmbC8rTkVF?=
 =?utf-8?B?S3ZhNUlRNmJVYi9QVEpBc3dZMkxXU0hUcnkya1I4ZXBjck5DbjdqcUI3MENX?=
 =?utf-8?B?cTNGMTgvaU5IaFhwME14OWV3UEVVWURlL0ZUcG5iYjZ6MHhMeXZLVHRIWmRm?=
 =?utf-8?B?T1FEYmEzSTVGU0x5TGJBbmdoeDM2SjFQclBSd2c4cEo5U1JweHhTeE5ZeG5S?=
 =?utf-8?B?UkNnSGdnNUJseWNxMWt0STRHV05yc2lDT3lvdjA4NytERCsrVldxNGkzOGNQ?=
 =?utf-8?B?Ung2RStUdmdWK3lEbmRlUmVpbHF6YzNGL3pCc2FxTllBcE9adkptWGVCTzhy?=
 =?utf-8?B?OFNQbXBxeEN1NFArOW16aTk3ejR6cUU1cytRdUtaZHh6LzBqejF2YzdIc3BS?=
 =?utf-8?B?TmtROE1maFpNS0xNSFNzaXhBNmNnMFFkUE42K3FpdVQ5TG9CYktJeGxuUUxT?=
 =?utf-8?B?Umw0QjZmMm4wTXp2WHRwbkdKRFVITmpkcHZka2RNK0I5N2MweWdDWERQM1dL?=
 =?utf-8?Q?zEzaffwgi4vJgTaBde1Meu2Iv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65042446-603c-4fb3-ce3d-08dd340e4f5c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:10:22.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95gjp2rC/PemF6+CeqvNMEZIJXzj/jWkId7pZfeCMCRTvoJVwfRVEZYGuObwq42X4mfiCGzYVPKRR1E/kd839A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300



On 1/13/25 2:18 AM, Nikunj A. Dadhania wrote:
> 
> 
> On 11/15/2024 5:11 AM, Pratik R. Sampat wrote:
>> In preparation for SNP, declutter the vm type check by introducing a
>> SEV-SNP VM type check as well a transitive set of helper functions.
>>
>> The SNP VM type is the subset of SEV-ES. Similarly, the SEV-ES and SNP
>> types are subset of the SEV VM type check.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  .../testing/selftests/kvm/include/x86_64/sev.h  |  4 ++++
>>  .../selftests/kvm/lib/x86_64/processor.c        |  4 ++--
>>  tools/testing/selftests/kvm/lib/x86_64/sev.c    | 17 +++++++++++++++++
>>  .../selftests/kvm/x86_64/sev_smoke_test.c       |  2 +-
>>  4 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
>> index e7df5d0987f6..faed91435963 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/sev.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
>> @@ -29,6 +29,10 @@ enum sev_guest_state {
>>  
>>  #define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
>>  
>> +bool is_sev_vm(struct kvm_vm *vm);
>> +bool is_sev_es_vm(struct kvm_vm *vm);
>> +bool is_sev_snp_vm(struct kvm_vm *vm);
>> +
>>  void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
>>  void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
>>  void sev_vm_launch_finish(struct kvm_vm *vm);
>> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> index 636b29ba8985..13f060748fc2 100644
>> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> @@ -641,7 +641,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
>>  	sync_global_to_guest(vm, host_cpu_is_amd);
>>  	sync_global_to_guest(vm, is_forced_emulation_enabled);
>>  
>> -	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
>> +	if (is_sev_vm(vm)) {
>>  		struct kvm_sev_init init = { 0 };
>>  
>>  		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
>> @@ -1158,7 +1158,7 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>>  
>>  void kvm_init_vm_address_properties(struct kvm_vm *vm)
>>  {
>> -	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
>> +	if (is_sev_vm(vm)) {
>>  		vm->arch.sev_fd = open_sev_dev_path_or_exit();
>>  		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
>>  		vm->gpa_tag_mask = vm->arch.c_bit;
>> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> index e9535ee20b7f..d6e7a422b69d 100644
>> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> @@ -4,6 +4,23 @@
>>  
>>  #include "sev.h"
>>  
>> +bool is_sev_snp_vm(struct kvm_vm *vm)
>> +{
>> +	return vm->type == KVM_X86_SNP_VM;
>> +}
>> +
>> +/* A SNP VM is also a SEV-ES VM */
>> +bool is_sev_es_vm(struct kvm_vm *vm)
>> +{
>> +	return is_sev_snp_vm(vm) || vm->type == KVM_X86_SEV_ES_VM;
>> +}
>> +
>> +/* A SEV-ES and SNP VM is also a SEV VM */
>> +bool is_sev_vm(struct kvm_vm *vm)
>> +{
>> +	return is_sev_snp_vm(vm) || is_sev_es_vm(vm) || vm->type == KVM_X86_SEV_VM;
> 
> As is_sev_es_vm() already checks is_sev_snp_vm(), we can drop SNP VM check here, right ?
> 

That's right, thanks for catching that. I'll get rid of the
is_sev_es_vm() check here.

Pratik




