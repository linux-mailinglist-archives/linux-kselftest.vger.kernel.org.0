Return-Path: <linux-kselftest+bounces-44395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AFC1F808
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 11:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0402D1A21263
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF7354703;
	Thu, 30 Oct 2025 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vtdU52Ku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1E351FDC;
	Thu, 30 Oct 2025 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819779; cv=fail; b=qVocpmJQVollDHrbf9JH+vKRI6v9ndfIk5z9earGdUvfGoui27rSqZjLJmRA9CANfxZIBeAuvcbfbC2jsPRT/zza0cKzSiBXCRcOn0opcit1kCDStehNaa7f0XMBG33heUsBnG6iZ92GXLpbspwmN2S5dQeX1GD5tTcAPX9M0Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819779; c=relaxed/simple;
	bh=6rL9iCoGvfmXLkT5vczmpPvUZuuXPJ4JWS2JXtJHyDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMfJseqZdcHM+E53+VE+9VsM33iswq3m6Ygyxk97jgJ8WzwoaaPc0uGwnCjP9SijQFc3UQCwg1cY+JY4M34oQjfsyX7RmMJyVk+htg/GGY11wP19sWodRqlpo+OaJMxPHUHgFlh4U9KzqiRoweKN43YqOuiU6rjoFLj4GEiE+8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vtdU52Ku; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiDdAH271U9b9ImY/8pkBSIAk/PPQvcJWPBfd8f9dRq1XbvdgRJBUqhU6VpTi7RMSvVN1OJ3pN0aBSPOe6tmmC1EkPEAfdAwzpq4zejahMzYJvF+yae8jUA0/90kh6xPCbfkbEyrGMC2S4gmsY04SECvN0LFNbvUqkOdogYO16Hc9Ps/X68NbIuRUhXmszfVGsohyXak/HqU8uRErcwB4sf3zFMo6pbXV95jgBjJ4PH6zf5J3W2sfHlUXYcJltSbmQmR9/RtKuSQ9Nq1Rj14QvwaJ8PiKbezfQ7bBG/rsudMWo4NJ9sgTY7S8+38So6jOFx+aDOHKKvB4us+MCy7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GslrXl2KSzkfz8y1KJaNFOJxYHSrZut4UeTuLS9zg4=;
 b=I0W9mCVMRZVhlMdCGIShEjwCl66G+g0CLURhorSHMpt34VtnNDzcObV6KGlDLaIjhhcgvZCNX6za7ApOsNkrC6FBNO2XA+bmbeeB6jBLzXY2JdVlwZozwQ4ipYlZjO+tWMt+h9aS4dS07EmRGk5UEiatGrRQ+DxpGkWfNWKJb86e1wS6M3W8fS/H7pIQSUKQBEUXX+YRu3/IoBMlGQCnw38MKMSpoGmSM4QEatw1CaHftxFxFB0G6EqSvtyPOhWcO8vToZx9Doa3YW93Lxc1MqNfgA8iAIeig1SgP2eBfTrWpWPG3gah62UkBYsxF6oacbl7LXk+hEx7GgkVq0BYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GslrXl2KSzkfz8y1KJaNFOJxYHSrZut4UeTuLS9zg4=;
 b=vtdU52KuuUTZ2ZXWl7XrbbGAf42lPbXqCHvnq+tgjhLCNBFj2qbaJsxyYPIZBu/bs1LYIZQzcrTPzXGkqwTnrAdD9rNbHiPkTvvq8bSDG6dH41i8mzzM0EGNcove3rQEsQro3rc+bqXEk2gAzj3EjYOawrbEZBZsauk+I4Mufuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 10:22:54 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 10:22:54 +0000
Message-ID: <ce1af711-dbb9-474d-ad11-66018cdbc29b@amd.com>
Date: Thu, 30 Oct 2025 15:52:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/15] iommu/amd: Use the generic iommu page table
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <13-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <13-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 33783d6c-390c-423c-6296-08de179e49bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2ZHV0NJSFh4MWdpaTllT1liZkxuU2lnbzIxbnRIclV1Wk45Y2ZsMVJMS0Zw?=
 =?utf-8?B?N2ZEZithZ1lhTXJDQ25vaWpudjh0OTNtMEVTeE9KSnA2TVExVUlVMFN5ZEFW?=
 =?utf-8?B?b3UxTmVVWnRwOWlPWW1XVUhqTEphZXdmQjZmNlcvd1Y4eTFwZGtvV0ttNkxE?=
 =?utf-8?B?LzFHVXc2aFBYQUdwdk9XSVFCTlRqcGF3MytaNSthVXdwWHVyYnVEdEdMckNs?=
 =?utf-8?B?Vkd3QmtIUGh6QlVERENSMGIrdER2WDlGT0NhckN5dXB2elZsQmVPUWF1TG8r?=
 =?utf-8?B?N3IwS3JXRFhlamJtMC8zdW1VQlFPT0djOEh0bTRNaGFOV2VydkVxZERIVGVm?=
 =?utf-8?B?UnB3Z1lWcXlwQUdZQkkrUmZWbjhKVEdmOVNnT2FtNXJqY2pHVWpjdW01K1B0?=
 =?utf-8?B?cTJsMFlJSzc5eGtvalJ1WlZSWCtlTGkvSE13cEE2cml4eEdLbVZ3VFNHUTZC?=
 =?utf-8?B?bFRta211VzZwYitwQWkwTUlObkw0SlR6WFdna3Z5TWpHU08rMWN1amFoQnJu?=
 =?utf-8?B?N2p6cEgzd3JZNXZqMW03ZVNqM243K3piOEZrNkRWTWRFWWZSTWtlVkt6bHN1?=
 =?utf-8?B?bEFqblo0SmtBU2Q5UnJhWkx6aWZuaEQvZWRqc1FRQ2t2dWx3U1ZINUtCbHU1?=
 =?utf-8?B?NThONmtXSUpKaXlIdHh3bnVwVXdDZUN5aEthVnYwcTBGdjhHeTNwbW9kL294?=
 =?utf-8?B?RjJxdFZYdUFhUEx2WmhSWEFkTzJOaHlkeFBGUkVrdlp6Y3NBRCtnZnR1cTIx?=
 =?utf-8?B?aXV1YUlJRnNNMGpMaS9GOEJNc24vcURxTDRGZHJBNWNxWk1MMzhVZkhRbXk4?=
 =?utf-8?B?UXhIWkdHRGk3eFB3Q2hwcG5Kc1hjRnJ4Rkt4RWJaaEpCZjZubjdtVlJvRk9D?=
 =?utf-8?B?VWlMY2RyZzN1dW5JT2I4c1FFMG1FZ01ZNlB4c0FPWXVselFwcGZSOTY2Tk1U?=
 =?utf-8?B?TSs5bkV3TFpKMzRkeHdBSExpdDYvMTF3S2l4ZGRkSkJPWWRmSzZmYWp0T1N2?=
 =?utf-8?B?MkRnTU9ER3plY0tsV2dZelhuVEIvOE5CSWgwNk5ud0FiWndhOEZnSzRidjFB?=
 =?utf-8?B?eDBZYmtGTzJtOWFJbE01NVB6Qll4V0ptZm5xc2RXNlhHbVJKekFSWm1tNkcx?=
 =?utf-8?B?UWJaV0JlQnVHV1ltQXA0TkthSi9hMVpETXFaMGVmNys3TGR2OGxUenNubmE3?=
 =?utf-8?B?blVSRjNWbGErVkpBRTViTkxpV2dPQXE1WkY3S0xkcVg1KzNreWlhb1R2UUcw?=
 =?utf-8?B?SnVpL1l1aGF5NithTlZjbi8zcWdnWHVFSVVTYTY2QnZ1Skh4THVTRUMrbm1h?=
 =?utf-8?B?T2IwMGhMdXJ6aWV2Q2Vvb3J1ZGt3eXN3OVFXYkJJYjhwUEVaWlBXSDBFUUxC?=
 =?utf-8?B?R2dDbVE1SS9uQzBTY3hPblVxWXM1dVJ0dkJuQ1dNS05EK2FTZURPRzByemd1?=
 =?utf-8?B?V0t1dlo3YTkvczJIeEtsOVh4OWtnNURtYmxCeVV0c3dOT1lCdEhEZ2twVnpr?=
 =?utf-8?B?ZDFDeEhReDFZV1djbG1wZmFEKzFNSEwzcjNzcjd1UnViMVR3TGFHZC85NjJC?=
 =?utf-8?B?SG9udzRqcStTN29OYkFtNlNDcW1YY25oVndqa3N6U1NndTNTR1hTSmErWkNl?=
 =?utf-8?B?Z1BRN3Q0TW5iUU5OdnI1aVZUR0V4U2h0cFZieExtTzZuOTVvcEp1VlpZT3Zh?=
 =?utf-8?B?ZERBcjhNb1dLdUR0ZmxmelRybXlBRUxMU2NnSEpyZjhTQm0xQkgweUx6aHVt?=
 =?utf-8?B?dE1BYTZYVUpWVzU4MDNZNmMydXAxTHdQZG50N043aGVDZWtSMUU0SDFKaW1H?=
 =?utf-8?B?NlFtKzQrZjgwTG9LYmtBZnJkYmdHdnVmWldESzltZ1F6anZmMEE0U0p1N2U0?=
 =?utf-8?B?amJKZTNZYVNZYXZzdjh0ekMxWG1NTVpjbnl2M3dsMis1YUZHeW9HMGR5Myt4?=
 =?utf-8?B?MG1HdWFCNzlieTlYeXJBZzJPOGFKa0tMREE5SkQyYVVxbkZSaFF1ZGNOTm1N?=
 =?utf-8?Q?ulwbnM3qdgY38TSd7wrFoz4akxPxpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3JySTNDb0RFRXdWeW9rTTM2cjg2Z1Z5eWd5WjZHQndiQnJITnZtaS9vSC9t?=
 =?utf-8?B?aFF0N2RDT21oUVAzaE52TWlqdGR6eEFoS3lBZHE3ZjBqekNCSFZHR2svRE03?=
 =?utf-8?B?dm1aK1hmNnFGdHo5eHBlVEFEUDFqbWVDZkExSE9odDFpcm9oZERObklSUkl6?=
 =?utf-8?B?S2FIRXEyOFoxaE1Pek9zUElXTEdBbVROT1czenU2OFNsQTdxZC96L3dONEpu?=
 =?utf-8?B?cU4vb29vS2dhOWUwaHQ4R2ZrWkZEaGhCbFpuSnMxNlF3TlVpdlJZRVBDL1RJ?=
 =?utf-8?B?Z2Zab2w2cVlzNHBVUGZvYjBrenljNkdPK1k0V3FJZHBjeTRndHNUcHhTb3ZV?=
 =?utf-8?B?WXF0N2FwYlFudkRZb1kycEdWNXh3Vzd5czcwTUlPaWxEVlFMS3IvZVhraVFY?=
 =?utf-8?B?KzJMRTRxejFPR3I3Qm5WWENiYjlabXZJN092NmdORU1GZ09nZ1cxS0RFa3Ix?=
 =?utf-8?B?Um94SGZiSUZ6MnhPellrcTVOZkcrRmNNOHhSd3ZRMm1MdTFQKzYrSUh6WWFm?=
 =?utf-8?B?ekU2VzM1YVVzOERrd1M0bERlc2dQYUUyL0hpcklrbm5KZ2JnYkRacmF0VUg0?=
 =?utf-8?B?TEtSOHhpa3kzc3VQRkNVV01RRS8yaUN1dWdRT3E3djhMWVJaSFQ2eitMV01G?=
 =?utf-8?B?RzcxeGtpbFE3V1pmeURrSCtrYkZMNFIxQjVJNW9LYUhVZmtzakU5cU50TVZp?=
 =?utf-8?B?QWtsNmpOaDFXN1duN1BpRUVlU2E3dFczejhxSDdPUlF0cTVlK1dDeVJabFlE?=
 =?utf-8?B?dzJ3czN5VW5QZUZFWC81WHZMdDBJbkswTkRrWDJ6U3dkRUlOL1hMeHFSclZr?=
 =?utf-8?B?S09kMUFqcXZ3dzI2WXVyWHd2NkNteTJzclVQb2FSVWc0WjZ3dExUbDVyTy96?=
 =?utf-8?B?TXJMcWszTFJDdWlSYk0rc2l0ZW5ra1VZVzhTdDIzcThFaEpUaE45Wlk2TEo3?=
 =?utf-8?B?WEpDQlFhZ1pIRXBZVFVuQ1Y2WWFpMTJnTjJIVHlzNUdGWXFFVTBHcWw1VnZs?=
 =?utf-8?B?cmt4TGZNeU50U3loWlBwaHhMVGp5NEV2VXpPNzR1ejl3aExpNEVhc0pLZWli?=
 =?utf-8?B?VVdiZUh4YVROVnIwTVZWNENKZy8ybHBFcEJ2SjNHRG92cVlOUjk3RkRKS1gx?=
 =?utf-8?B?RDlmbC9QYjM0Mmg0Y3I1bmVXL29RN1JwcWNwYkFEQllOaFZPVkZPb2RvSUcx?=
 =?utf-8?B?Vy81aXJkNENIbUlGZGZJdDBKRS8xNC8yaDc5bGdTRDRBZ1BjQlFHS2NFREZN?=
 =?utf-8?B?aHh2aXduM2FUL0NsTGdLMU9abUtsbUxYRUFWTUluTDdDWGhKNVJxa3dUT3Bj?=
 =?utf-8?B?V1ErZXh6S0Zua1pJRng4aEZEakZTdGZZZ1R1bnFXMGpINTVtMW9qdS9nOVNx?=
 =?utf-8?B?QjdjUitJR3BySVVscjJSeC93MXUvYjFWMHdMUkxrZnhBME1wZ2FXT0dmS0VV?=
 =?utf-8?B?NzZQbm1aczBzNE96ZWo5dDNOWjBBdHpXOWtoNzgyNW5BMWpwLytzbklSZkNN?=
 =?utf-8?B?TEt2d2pCODk2VXhBd3ZXZ3ZBbGI5Y1NQb1JZQTFPZ2NuVUl0VHJYN09lNUdI?=
 =?utf-8?B?dy9hS2hxVjNyVURrTGZDZVAvQkp0YlViSEs2VmhpeTJDTC9yMTJYRUwvQWhX?=
 =?utf-8?B?NlFNRzZjS09iQUFXU1VhbjlaeGVWTjduMFAyUGREWDVuUloyT3lCQVFjWkJr?=
 =?utf-8?B?MUFQdEgzRTVWQ0ZmTng4bEQyeHJPQ1pVS2JnOElHcFNWamRKejh3YWdOQUZE?=
 =?utf-8?B?NUhBd1lGQUZiNjVMSUw5QmNhdlM5T2kzMFY2K3c2TEUvQUVGUnV2NFhuYTRW?=
 =?utf-8?B?eTNIVW5NcjVUQWdPa3lvL0FxOHpSNldsWm5tc210T1l3QVBlUDRjVkJZbHNL?=
 =?utf-8?B?aGRld1JHa3ozOTJUWSt3aXJOdHdHbG9PcVBpVmNmc2NETVhLR3RUa0VZaGtR?=
 =?utf-8?B?RmN1TFdTZW1iRTE1RVZsMEloMHlFY1FqbDdqWmliRTF6Q3ZNdHI2UDlFRXRG?=
 =?utf-8?B?Wk5uTWRsYjlKcFVxcTNFUkw1OXg1QzluU0R1cEhhUCtDVnhQaE1CNzZPL0s0?=
 =?utf-8?B?NGdWb1dJcm9WSE5vYU00ay9pV094UHFtU28zMEVHcDQzZmJ6TTl4eFZ6SkJm?=
 =?utf-8?Q?15FD4vs4POtleMc5688HT/1dH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33783d6c-390c-423c-6296-08de179e49bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:22:54.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kFCgOxKIz9kuE74Inge9rdSxzHjSK8P0Aqat/Kqay21WaEXtiMrTIM/y46DO1LZ2Ozj4qjQDdqCT7v1CW93QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

On 10/23/2025 11:50 PM, Jason Gunthorpe wrote:
> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> Replace the io_pgtable versions with pt_iommu versions. The v2 page table
> uses the x86 implementation that will be eventually shared with VT-d.
> 
> This supports the same special features as the original code:
>  - increase_top for the v1 format to allow scaling from 3 to 6 levels
>  - non-present flushing
>  - Dirty tracking for v1 only
>  - __sme_set() to adjust the PTEs for CC
>  - Optimization for flushing with virtualization to minimize the range
>  - amd_iommu_pgsize_bitmap override of the native page sizes
>  - page tables allocate from the device's NUMA node
> 
> Rework the domain ops so that v1/v2 get their own ops. Make dedicated
> allocation functions for v1 and v2. Hook up invalidation for a top change
> to struct pt_iommu_flush_ops. Delete some of the iopgtable related code
> that becomes unused in this patch. The next patch will delete the rest of
> it.
> 
> This fixes a race bug in AMD's increase_address_space() implementation. It
> stores the top level and top pointer in different memory, which prevents
> other threads from reading a coherent version:
> 
>    increase_address_space()   alloc_pte()
>                                 level = pgtable->mode - 1;
> 	pgtable->root  = pte;
> 	pgtable->mode += 1;
>                                 pte = &pgtable->root[PM_LEVEL_INDEX(level, address)];
> 
> The iommupt version is careful to put mode and root under a single
> READ_ONCE and then is careful to only READ_ONCE a single time per
> walk.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

I have reviewed and done some testing. Looks good to me.


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


