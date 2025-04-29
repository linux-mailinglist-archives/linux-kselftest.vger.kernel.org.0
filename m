Return-Path: <linux-kselftest+bounces-31865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0EAA0862
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C61480C61
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9F2BE7B4;
	Tue, 29 Apr 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NgNvbXCY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1721C19E;
	Tue, 29 Apr 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922186; cv=fail; b=ibVMDBTj5kqPvkdYTPu+Uf2+SVgJyalPCA/uOMF3lijzVd9dlWw4uGm/z6iJiYk8j1+txS6G6r4oMfy6ajdIZrNGCsf+ZXWprKvTwadOvjmUDtpFqV7KIxvIFJV+oLTRDgbQrWX+lKj2lvzF/ekx3bCJlvCBjCSsGzCGDgbauB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922186; c=relaxed/simple;
	bh=Dub6HPpiqejPx5DwNTTjov1B3jMXDNyPV7viMmpXbxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKd97IJkfgKodwSlLcOBXAJNGe8StYO8aITtUyNmCU4idQThOq2P5qM11/c0igGN+fc0PKfdkCY6d535hbdbdcCK9rBuaT+jN0D8Q8aZ9B6JrQK7EDhbt+8+9wUDT7v3Kvp6ed0Zgbp43cNBnfqWwJqvxNk822T9j/VtZPb/He4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NgNvbXCY; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZ+iq+ZR0jEicuqyvHEF1DlIxRVjba3jB14gbyw/cs8hR252idPpjsfsrNfMnEU5GUcRJZhNOEElpD3rsoA4nX4faBnLxryYHE1arVH7hpidb0UDhcOYzdem8O2e2536aQHl8vdzNGt1Srd7jsFouD0brkf2Qy1X+KOYFrnxa1x3EQiVj+B4O+DVfq1Gw8qNvIGwbDnYG6xgDf8vL7WHCSpfawbmYoixUYuU4DmeU+D1MDpB1JjHjC5kMk2JarDJm7HFDf5EPIJ1qLEKMiZulhO2hLMR1MkptSi2DwnQmdN2FU3LDWLT/AqiAXSSrjlWr4/4br6XrLLwKB0d6CFTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4xZM5q19Gb5/f9GIXDFPRUt9tK8MVxSnG6bTKAzwFQ=;
 b=PG2V1hHrDfC3kjF1CLrY1zvgLm9gYGWA3SIRPE9+6bGQK282LDS3RqYnaJrMhpLTRIhdNxNXSQNJjnzPvySUjl/h9qlKwcIFNX8BksdLQvgrboe8N+DCcF7UhVxauIoc0r2zBNporwL11BXA0kxGCxDvJjZJVV9NKFvkXtFBTOO3UF69kp3YLs+AUENWY/8gDsDJ2z7ZSWpxpwXqYzB/O5+tbS7xhRsUEMru2pKbhdRW1iDHCdPHmpgVA5yjATXEJgiUAFx5IKAIkhI1SQRKRoGHp7E/33iIYmPQJ3w3g9x9KzM61w3V8sxniYUw0vpNOmegmIGA3wpNzLCaeWOYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4xZM5q19Gb5/f9GIXDFPRUt9tK8MVxSnG6bTKAzwFQ=;
 b=NgNvbXCYMGbBXuoS7GHFFG8lcUY6b7PoG5wLWz5AK1iKhpTP2euEGwvz6/vzr0PAsHocjfd4Uo9aeOQD2n+v5isIOlx4kjhFAKqQEO75VGl5Yo/W19psbpuFq0q6mosIGdtEW8sNKJMJJQaCJdExGm/hQlfiwnsuH/aPtOx2ylo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 10:23:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 10:23:01 +0000
Message-ID: <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
Date: Tue, 29 Apr 2025 15:52:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aBB1gLfahnLmn0N1@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fbaf05-4fc4-44e8-a815-08dd8707d1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0h5M3ZlcnRRaWhjaHNGckNKaEliUFc4Mlgxc01lcTdRaFRTZXlDM29udVpw?=
 =?utf-8?B?WVRHM2RtTGFyQ2YyS0h5TlZJMVB0djBhZUxNODY4RlhJS0t0K1gvUEZZQ3dH?=
 =?utf-8?B?UGRVdnVFeGQ2cTRwYmR3OHNJQTkzdTBMZUgzR0Ixc1k2MDZQL2VRS2w5K1Y2?=
 =?utf-8?B?ekQycjUwZ0NqdUZZNnUrK0k0WDBUV0dydjNJdUtCMTkyc05jWU5pNnZqZHhP?=
 =?utf-8?B?YUNyeHFTWlQ3U0ZUQTBBMWkwald4cmRpRzdiQWVxUU9udHE4Vm9MZ1orRFl3?=
 =?utf-8?B?RjhzUWsyckd1U3VxeFdZTkl0MTZ5L1R6UHR5K2t0aFRNdENoS1hnMHRhRlc1?=
 =?utf-8?B?RS9BbUROZzZxNUpuaW16aTZQckJDcUFrd2l0Q0lxcGNQd3hZMEZFMktvUlZa?=
 =?utf-8?B?N1Q5cDUwRU4zb1NtNGhkV0tSeVlpanRKa0ZuQWJiWFhRYVBwV3c1OXNBVDZp?=
 =?utf-8?B?UlhtRDRxRGJTUHNtdHBUaW9TdUx3V3R4MmcwdGQ0MFkrcERqelJuWktiTDVK?=
 =?utf-8?B?bTZ6OWw1TjNadFF6S2JPUVlkTnBGWVBSbzRlaFRpcDJUQ1FnN0wvaWxFMFV5?=
 =?utf-8?B?alJSNkFJR25XcklGdGd2UHR1Ykw0SlR5dy9XQkxyODJEM2hIMExzbnAxZVJx?=
 =?utf-8?B?UVYyS0xmcVNFa0drY3YySXQyc2QvNnlGVHVudEdyUEFGcm85OHhhSmJvKzdL?=
 =?utf-8?B?blV0SExLeWx0UFlrNkVPWmFaMXBYWGsxMFA5T3JSRVJBWUM3R1VxeUNBSjRZ?=
 =?utf-8?B?dDFxMDJnb3BiK0QrY2QxSjR3K3l5OW5qZ000MjJleDUxOWdpc1d6R0MyUlpR?=
 =?utf-8?B?d21pUFlKeTJhaCtlRHhISUxDNVRIbG9mbnE1Z09qYWkyRnlUcWJQVWR5Q2t4?=
 =?utf-8?B?Qk1JVXdFV1BHRGV1MHFPdVJFaWtubHVUMTR1Q3UrYnp2eUROamwxanhyWTN0?=
 =?utf-8?B?azc5eXRmbGlGallNU3FHQUZKenBNeWFuSWd6RTNsQlo0djZKSXFXV20zMGpm?=
 =?utf-8?B?TmtpVmJucWsyWW9YaVoxZ3F5TEIwYjZyMHpZNEhjVXQzTVJlcGlmeTVoTWVF?=
 =?utf-8?B?bEJJQWphVzRScng1OHRrQk5LWFpITjdPV21LU1B5aGpTWCtzZ3hjdnQxZjNP?=
 =?utf-8?B?S0pid1lIZCtFa1kra3Y1RkIrWjBFUXBrdHlLVUxTMGVYbjR1cGJlNE4vUUFs?=
 =?utf-8?B?Y0ZNemp5MEdsbG1XUUpTSVV4SFViaktaS0k1citpNC9sSUJKcnFqZkNqRlJt?=
 =?utf-8?B?c0hDSjB4US9LTzNuQ2ZOZmlhVjMxWmpUbWxhTGhTZnloQlJpQ0cxRXlFNllu?=
 =?utf-8?B?dCtCQmE0cTlZQVpROGkrNGk3OUhzL1ZsR0JLSjd3aVJYOC83dFVrYkFQZ0tO?=
 =?utf-8?B?YkdHWHMvbFp6dXk3V3lNRElBUlFxbmc2TTU5dkM1WWFHeGNvVm5rekd5YmZZ?=
 =?utf-8?B?RnByUFU1TWRyRDRKSjdLdWNhQXlydFJJY2FzSkVicUQrYlozdkk5UFI4WXBI?=
 =?utf-8?B?TjA0RmpKUlc1bHlXSjZ4WHd6bEFFSG9FaEh3U2VEeklwcFRrZ3pheVhJM1N0?=
 =?utf-8?B?bmFQT2YwMk5OUkZabXJpRERmWHgrNnI0WXpFaVFBZ20xUlpaY0tsdUVaTkxS?=
 =?utf-8?B?MGFIRVZkQTR5NDFLcUtCdGtlaTk5YThBVXNCcDVMcmN0Z0VMejdsM2VzOFU5?=
 =?utf-8?B?TE8wcTMxTXdod2hPMDE3Vk1IT0VwOWVLS25EaHVNaGpNa3BHZ2dXdzdPTHpL?=
 =?utf-8?B?eXM1VUVKMTYxaHdTOXB0TlcvZHZiSCthZkx4WmZDd2o1SkxuVmFjNURyazhI?=
 =?utf-8?B?WTd4aWx0TGh0WGRpVFpYOG9IQlY0Y2gvU0NMZTNqaEFhckJ0YmVhS29hR1NJ?=
 =?utf-8?B?Z1Q2anNrYmx6bU55RDh0WkVDL0xhSFlVNXlVQXBVN0RucWkzQWxMNERocUIw?=
 =?utf-8?Q?fbKSc7jozNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm91VGtjdzJMdGgrTnJweE1jMWJTRlc0NjhLaVhWKytlQVZjMzYvelorQkR1?=
 =?utf-8?B?WDNZQnhEL3c5RThvNWtud3RQcldnSnVmUjliTzUwNmdNM0U3SHdCVkpsbmRB?=
 =?utf-8?B?T1NjbHB6NGFIRnljRlJqSWtFTGc4Z2xPR1J2ODRacFVTR0dpSm0ycnVJbExx?=
 =?utf-8?B?bHZ0TmJiWWx1WFhJb050S2JLaWdBc3lNdUZFa2RLWjI3bHh4Z2xiMll6WkNB?=
 =?utf-8?B?bGs2eGZJbzYzSXlKbUhGdDNaUWluZU1hVTQyNk5mdFRXYWpiRk9kWWtkTURW?=
 =?utf-8?B?b082NFQxaGxGcG9RZjdBd1RORStxYzBkdzd3Yit6aTFxS3R2Rk82UzZiaGpB?=
 =?utf-8?B?Y2FEamZQODB5c0VEWXdiN3ZPUVk5SWN4Qi9Ea0xadUQvdlpGSHg3SWM2ZUpO?=
 =?utf-8?B?QjdCalhid01mNDNEd0RTeWNrQVQwVXFQSEhDVHZDeTh4SFZ1c1NCMVZnUGox?=
 =?utf-8?B?c3pEbU1kL1B3YnBKM0RibWpocXlMWmVmcXBjVTdPMk9lZVpOaUR1aGo2Z1gz?=
 =?utf-8?B?MFBkWldWOUtRN0c2SUpKdXlHMytkTTlyQ1hmZjhUbWw2eFJ5WTFIN2FWQlBi?=
 =?utf-8?B?cFZvSXNOS1haSlJ3ZW5uZGE5R0RoakRCNTEwajVmVFAya3I5MWxrN3JVRnBY?=
 =?utf-8?B?T1NkcTMyME9wckJpUS9pc0hSVVJkNE1XM2hiUTdKVy9qdmI4Vkg4TlFTaWsx?=
 =?utf-8?B?OWlVSnlqWXBtTERMZ2liaUQ2UmM0bndES3R1ZW1NejI5R3JHeHRHMmRSdE1E?=
 =?utf-8?B?UGlOR2lCTE5nSndPMG9tc2IvK291R2hsQ3pJa1llU2R1RkZ6RWZhb0NsR3FH?=
 =?utf-8?B?KzNKWVZjYm8xRzBQK3M5RHNxRVF3aDF4WVRiRWt2L2ptOXljRnB3MnpEWFRj?=
 =?utf-8?B?amdJQ0ozV2x2aVo4Q05jdVN6NGNscFNRd3F5ZjRWTGx0VDZjZzZ0bjVnUFNM?=
 =?utf-8?B?TWlZQkN1d0pqaXdkc005SlRLS1RBQ0NVV0xJRTNwK0NmRDdVQTkyeCt2TFZC?=
 =?utf-8?B?RC9vdDN5dWNLdzB2TVJaRlVqOS9xUzN2MVBqNzI2QlJPa2FjVEJFUUhwbURI?=
 =?utf-8?B?WEJrSk5scFZOOG9QYVFMUWlucVoyZEoxemZyWVY3UFJjOFBIZXhFWGVZMm5G?=
 =?utf-8?B?YWJNcXQ5NmhlRG1NR3FjT1VMY2J3ZUJuaDFONitGazNTemVqVE1LR1ExMTdz?=
 =?utf-8?B?ZXBLS0ZFeS9MZi85d0crdmZmSHlNM0htQm9FY1ZQWFRuT2xqR3U5RXdZajBE?=
 =?utf-8?B?dzZWUWJWSkdXWERQeGZYbDRpMkhMWFhrMXpNYVR6L1lhRkU5VzlSM1ZLR3Y5?=
 =?utf-8?B?R3BMcTRMRWtiN3RaS1A1N3BlV2w3MkxnMUlsQXFOaUZSaHpLY1FRcmMwbCti?=
 =?utf-8?B?cnlCL3BpZDdhYjhDWGZsVWY0dkVUN2p4RFlmaEJtMmFrOHRDTTROWDVjTGVm?=
 =?utf-8?B?eTY4eG5PaFRDVUNCZStLcEpjNUdWNlVDRkZWWVhGZTBWQllqNGt4SVFla211?=
 =?utf-8?B?Nlg4Z1U3YXlBSytzd2NLdFZ4UzFLMXdTN0Y2dU44TlcrVWsxSTdMNEw1c3lu?=
 =?utf-8?B?MjA3NElUWGFaZStCVk5xMm4xVEFoMW9XNVdTclRPL0VXVkVKTldMVU1nQkJu?=
 =?utf-8?B?a0FUU1N3ZDZkTWpialhtY09sWEFkbGdYVXBrbkRXTnFOV0l2V3MxMzEzSUdG?=
 =?utf-8?B?dHNsMHFtVjcraFJtNFVLdnJ4c0ZLcXFaK3d4T2tuaGdxMFVTbWk1YmxaS2ps?=
 =?utf-8?B?aE90ekN1M3dRNlhQRHczclZmZFRXZmR0WU5kWEU4bUx2VG1TQ2FLUGs3bmh6?=
 =?utf-8?B?Wi9sdEFTMFdHbWd3TkJ3ZVZraTlPbmswZ2ZpZUVScXUveCtEM0F5NXRhTmV0?=
 =?utf-8?B?NW9lTWdsNWlDWFYvTGlPT1lZdnpwK1lNbWx5WndZcUpQMkc1Zk5KY1NLTzRS?=
 =?utf-8?B?NW5kU3N3aUpCeHZKVXErZlhzZTQ1ekhRRXRaeHFQUmJNZzd3ZDg2ZEc5UVNy?=
 =?utf-8?B?alZuTk9Qd1pINVVIUUJQc2xLVmk4djNZR2UvSFhVNDlDSjZyb3VtalNzWUh2?=
 =?utf-8?B?NE5sZjZ2R2k2VEh6d25CY0huQnBUWmIzVHB6d0Nkc0Z5ekVBOStWTU1JOENi?=
 =?utf-8?Q?2kQ+qHbdxkPCaa0FSQxVBAco5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fbaf05-4fc4-44e8-a815-08dd8707d1ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 10:23:01.3696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRwfkaJU5imufnmSKeYfAWM2VVibl1WtubCxTRCTh0Ahw2ZrwK43aJHnMP9IV7RwRmyp66QvIIjkgtJuplJGoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

Hi Nicolin,


On 4/29/2025 12:15 PM, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 11:04:06AM +0530, Vasant Hegde wrote:
>> On 4/29/2025 1:32 AM, Nicolin Chen wrote:
>>> On Mon, Apr 28, 2025 at 05:42:27PM +0530, Vasant Hegde wrote:
>>>>> +/**
>>>>> + * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
>>>>> + * @size: sizeof(struct iommu_vcmdq_alloc)
>>>>> + * @flags: Must be 0
>>>>> + * @viommu_id: Virtual IOMMU ID to associate the virtual command queue with
>>>>> + * @type: One of enum iommu_vcmdq_type
>>>>> + * @index: The logical index to the virtual command queue per virtual IOMMU, for
>>>>> + *         a multi-queue model
>>>>> + * @out_vcmdq_id: The ID of the new virtual command queue
>>>>> + * @addr: Base address of the queue memory in the guest physical address space
>>>>
>>>> Sorry. I didn't get this part.
>>>>
>>>> So here `addr` is command queue base address like
>>>>  - NVIDIA's virtual command queue
>>>>  - AMD vIOMMU's command buffer
>>>>
>>>> .. and it will allocate vcmdq for each buffer type. Is that the correct
>>>> understanding?
>>>
>>> Yes. For AMD "vIOMMU", it needs a new type for iommufd vIOMMU:
>>> 	IOMMU_VIOMMU_TYPE_AMD_VIOMMU,
>>>
>>> For AMD "vIOMMU" command buffer, it needs a new type too:
>>> 	IOMMU_VCMDQ_TYPE_AMD_VIOMMU, /* Kdoc it to be Command Buffer */
>>
>> You are suggesting we define one type for AMD and use it for all buffers like
>> command buffer, event log, PPR buffet etc? and use iommu_vcmdq_alloc->index to
>> identity different buffer type?
> 
> We have vEVENTQ for event logging and FAULT_QUEUE for PRI, but both
> are not for hardware accelerated use cases.
> 
> I didn't check the details of AMD's event log and PPR buffers. But
> they seem to be the same ring buffers and can be consumed by guest
> kernel directly?

Right. Event log is accelerated and consumed by guest directly. Also we have
Event Log B !

> 
> Will the hardware replace the physical device ID in the event with
> the virtual device ID when injecting the event to a guest event/PPR
> queue? 
> If so, yea, I think you can define them separately using the> vCMDQ
infrastructures:
>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
> (@Kevin @Jason Hmm, in this case we might want to revert the naming
>  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
> 
> Each of them will be allocated on top of one vIOMMU object.
> 
> As for index, it really depends on how vIOMMU manages those vCMDQ
> objects. In NVIDIA case, each VINTF can support multiple vCMDQs of
> the same type (like smp in CPU term). If AMD is a similar case, yea,
> apply an index to each of them is a good idea. Otherwise, if vIOMMU
> could only have three queues and their types are different, perhaps
> the driver-level vIOMMU structure could just hold three pointers to
> manage them without using the index.

Right. May be we can use index.


> 
>>> Then, use IOMMUFD_CMD_VIOMMU_ALLOC ioctl to allocate an vIOMMU
>>> obj, and use IOMMUFD_CMD_VCMDQ_ALLOC ioctl(s) to allocate vCMDQ
>>> objs.
>>>
>>>> In case of AMD vIOMMU, buffer base address is programmed in different register
>>>> (ex: MMIO Offset 0008h Command Buffer Base Address Register) and buffer
>>>> enable/disable is done via different register (ex: MMIO Offset 0018h IOMMU
>>>> Control Register). And we need to communicate both to hypervisor. Not sure this
>>>> API can accommodate this as addr seems to be mandatory.
>>>
>>> NVIDIA's CMDQV has all three of them too. What we do here is to
>>> let VMM trap the buffer base address (in guest physical address
>>> space) and forward it to kernel using this @addr. Then, kernel
>>> will translate this @addr to host physical address space, and
>>> program the physical address and size to the register.
>>
>> Right. For AMD IOMMU 1st 4K of MMIO space (which contains all buffer base
>> address registers) is not accelerated. So we can trap it and pass GPA, size to
>> iommufd.
> 
> Yes.
> 
>> .. but programming base register (like Command buffer base addr) is not
>> sufficient. We have to enable the command buffer by setting particular bit in
>> Control register.  So at high level flow is something like below (@Suravee,
>> correct me if I missed something here).
>>
>> From guest side :
>>   Write command bufer base addr, size (MMIO offset 0x08)
>>   Set MMIO Offset 0x18[bit 12]
>>     Also we need to program few other bits that are not related to these buffers
>>     like `Completion wait interrupt enable`.
>>
>> From VMM side:
>>   We need to trap both register and pass it to iommufd
>>
>> From Host AMD IOMMU driver:
>>   We have to program VFCntlMMIO Offset {16’b[GuestID], 6’b10_0000}
>>
>>
>> We need a way to pass Control register details to iommufd -> AMD driver so that
>> we can program the VF control MMIO register.
>>
>> Since iommu_vcmdq_alloc structure doesn't have user_data, how do we communicate
>> control register?
> 
> BIT(12) is the CMD enable bit. VMM can trap that as the trigger to
> forward the base address/length and other info.

Right. For the control bits which has corresponding buffer we can do that. But
there are few control register bits (like completion wait interrupt enable)
which doesn't have buffer.

> 
> And you'd likely need to define a driver structure:
> 
> // Add this to struct iommu_vcmdq_alloc;
> + * @data_len: Length of the type specific data
> + * @data_uptr: User pointer to the type specific data
> ..
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;
> 
> // Refer to my patch in the v1 series that handles the user_data:
> // https://lore.kernel.org/linux-iommu/5cd2c7c4d92c79baf0cfc59e2a6b3e1db4e86ab8.1744353300.git.nicolinc@nvidia.com/

Right. I have seen V1 series and that thought we can define driver specific data
structure.

-Vasant

> 
> // Define a driver structure
> struct iommu_vcmdq_amd_viommu_cmdbuf {
> 	__u32 flags;
> 	__u32 data;
> };
> 
> Thanks
> Nicolin


