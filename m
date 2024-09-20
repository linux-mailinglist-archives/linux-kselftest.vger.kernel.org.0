Return-Path: <linux-kselftest+bounces-18154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3F97D0FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 07:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8375328194E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE82746B;
	Fri, 20 Sep 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oA2XTXab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE284EBE;
	Fri, 20 Sep 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726811603; cv=fail; b=OgUBKsqsAKIBGK6D0r5IpvMHmCbRue9L7ql4n1WKZ+zftbf2PHcBPSjlxQdgbxAMoqQvYJ9NNrHS80gJR4fUxdXy5tNoOZKNOw+Xxgen/FnKQzOQaQyA5Z3XpI/V+gSkCHikoaQvUvAo7FBE1nkUWK6ADsPs7lb7Hbdcmt10XkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726811603; c=relaxed/simple;
	bh=ollwjnXI54Pb4hEtjkMH4quVFkPZOjAx/xVNovkIe68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XLPyYNa9VELdLB2CPetyp6/qeXlzyrpea8bsjbSY3+DfaJQIpicgL4JkE+3/7K7GElA7pJGoe6ncCMEYnsKF7/kVC1exrUrp5ekJmgEkiquOo3UXF4U0xtFVjK6CF2FgVsyp0dPdp0Z21U9Hfj7wtf/eLusidr9ai2TycE92Cyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oA2XTXab; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz4mp4yGeRK+bkr3DHKDHbiHtoS8WNLApheKc2xq7/WqaaMlKvFlP2R4Y2rx9ClDomGtXu23NrknR1r3UsuqGETpp0VIc6ci+MVwG/IGTNn99DoUPfGsZ0754tw6sawYkluzDFiDoqvKKKmp/if5XgdzedOWMfyxq6XDR/K64kzf3h/n00UaZ0WoVfiFqXA04y+w4hSs+TVMdOJe8TezmZ5pfVxHuMrHmIv0LUVafgodca7kxXk9/6ZlTinwO5NVHdMd55lzw/8wddXDbD5YZRxNeD8EIEeC7x72D91/qr5V3iAHJL6lB5UUZhYyFfa0nrPrI2zcj6Lm/GxaZdWKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVN7TiWKwT2tapVh134qWSfAMtX2A2iIFUbJZ8WM2oA=;
 b=YZqlYGtIDSnIbeoQrqIOTtojRoWU/1EWcnoTsf3KgyFmS8pAg9bjCzcgRbA3WJLchuMjcbyXv/lXiDDIkqoMObVKV0NaqUWIE9wQQZs+UAZrVxrQY1+/pzpN+UCyUFxeZI4M6wPk5RoFYHGniqKp//x4X1DpTO9ktUUKL4SYwU8wLsb3cBWVISIpdQknj77wGxNSEMzMGgXU+alw8SaUaJUTuYdtxqkC1p3yoW7Wn8SGwT2Bk+3Ynv4Mex5DP1MJl6bPtPkq6JrZplqt5QsbEQMwbKwanFv4EZPvE+TYH0d8nq3LNVN/laFTNBT1+5lFq3t09L0TnJEiYdoVPrhdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVN7TiWKwT2tapVh134qWSfAMtX2A2iIFUbJZ8WM2oA=;
 b=oA2XTXabMNuwQqi3OMrPteywX/PdyEZSjEHOqQelUZV/07XCJCV7/GLDyqkqM3cu/s0QmJpf9z7UM4TzN519EBdp28fwyxJOfNgeMfFpSnpwNi/7Qj9/a7YjZaEY1/FfaTj6w7RC5PeRCOUM77SgH3GngcZS34RzIfQPoq9fH40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 05:53:19 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 05:53:19 +0000
Message-ID: <76355a11-a0ba-4a28-bf51-454facfd59e5@amd.com>
Date: Fri, 20 Sep 2024 11:23:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] x86/cpufeatures: Add CPUID feature bit for the
 Bus Lock Threshold
To: Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, babu.moger@amd.com,
 Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-2-manali.shukla@amd.com> <Zr-qkJirOC_GM9o6@google.com>
 <20240829064811.GAZtAZqzWkmF79VOs7@fat_crate.local>
 <ZtFNwOG5oPwNF2bU@google.com>
 <20240830082136.GAZtGBEMyF-MbWXrPo@fat_crate.local>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20240830082136.GAZtGBEMyF-MbWXrPo@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7ecca4-9b2c-4c46-5902-08dcd9388754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmQ4amlraU5senN6QWtWNFQvUWJZY2k1NDN5dFF1bGI0aGlKcUlEOWY5bGlh?=
 =?utf-8?B?NFlUOENqdGtzdWtDZWhnZzh5U2hhN3g2Rnc3VWV1djZ1Nkx4ZmdoRFdhSHo5?=
 =?utf-8?B?YklXc2U2Z2xxc2cwR281SUhBVFBVUHNWVWpMalA2TFVPTmU2NzNidVZ3SHlV?=
 =?utf-8?B?dTRoazZFczRHTjBHY1FzT2hVejViUFVBOE5BZ1VvelRyMU5sL25PcDhEK2pl?=
 =?utf-8?B?ZXM0azJRZSt2eWlJa1IxTlBTb0g2SUZUZzk4bXBncGZUaFJEaVVvaE5KQlVT?=
 =?utf-8?B?SzlzN2Ztc3dvK3RRZlRKQ0hNNjRXOWIwZmluUEhoNk10V24rRi9zWWJ6ZWFV?=
 =?utf-8?B?QlkvVXkyZW1GNmJqRktScmIzQ2hYRXl2NVdQN2ZQeTkwT2wzOC9rVmc5ZHNq?=
 =?utf-8?B?VFppa25WZVJ5S0w2aUZneVB5REttOFJjeWZCK0NpRCt5RC8xTDlDaXZpeVBp?=
 =?utf-8?B?dnZnS2IvSmZ0cklJbWgvT0VtWk50K0R2VW5LM00xMFpyNzEzTU5rczYrUTd5?=
 =?utf-8?B?cEpEb0VPWEFhai9pVzQxRm92NGhSVWEyUEIyYnF5WG9ubElQZUYyb1ZsLzJD?=
 =?utf-8?B?NGZYdXJvY1ByVmsrNVErdC9zby8wM2dKbXRuUzdXWCtYUnNSTVIxekh3Tmhy?=
 =?utf-8?B?T2hqWnY4OWxUL0JDaUU1ZHkyYWJtcjFIcGZEZU9Ud3hnUGloM1VLVEp3NEdY?=
 =?utf-8?B?amJIcTRlVEV3ZW9KcElCWVNWdUJsZDhuY1ZTK292eU9RaFZnUmZvQTQyaExM?=
 =?utf-8?B?cVM4Ry9YTFVZdGVSRUZEeERtVXFsNUxuR3lzYUxsU0dOMEp0KzF6aUk4RzVw?=
 =?utf-8?B?Z0JiclhrZmZ6emFHYjBHb2FiQ1RsSVphU0c5M0o2bklSNGRpUUlUSlBnTzV6?=
 =?utf-8?B?dm1iZVRuUnEzQ1RaZ2tDMW5KK1BJaE5pUnNuMTZoanFHdXBuMnk4ZzVybTRD?=
 =?utf-8?B?b1NIRm9udE43OExkWFhnOVVDbUJ4b1oyNGt3NzZDVTI1TzZFVjZYcXZNcDlj?=
 =?utf-8?B?Y2pNaGt0V2xyR3h3TThXbE5wWEtNaVBMR3psWG56aXVUZmtENk5mOEhseHY2?=
 =?utf-8?B?Z0dNYVovL04zR0FOWlVjeUZuUzdoeWRMeDNOOVZqNjBQL0QzaE9HdHJ5QjJU?=
 =?utf-8?B?VjBYdVZ2Z2swMVNiZzh1KzkwOGhyN25obFJyZXc0YUlBTW1TaXBhVWhqQ1da?=
 =?utf-8?B?bThRQXJkNHNzbWNHOFRpWjlNc1BXbGZDR3YrRlB2V0oxWXRxRVFBVzZOZVNH?=
 =?utf-8?B?SlN3VSt1OVJydkxPVVVRYktPR2JYdmx2ZTJBUzRjTGxOSldxc05SYWVWSVJr?=
 =?utf-8?B?azFRY1VzLzl0N1R6VXN5NHgvRDgyYVB0UUo0alVVSFlqOEkzaXVrMHFKNU02?=
 =?utf-8?B?Vlkvb09iUlRTYjlJVEVXb3kwbUEwa2swY3JiczhMcWJtTkpiRlRLa0tZc243?=
 =?utf-8?B?MXJtMllCY2hiU0JvVlhZUlErTm1yYzZqTGZUWUV3UDVkSmtQK1N1L0h0NE5E?=
 =?utf-8?B?UTZYaU5TTjkyaFpydVJLdm5MakZvZkNsN1pKMU1MRUc1Tm1HTmtMcnovTkZQ?=
 =?utf-8?B?S0VsSEkvZ2h3T0tOQTE5OC9zeG1yMkJ6c05GM0gwS0VzaUd5OGo0RUVnSUFj?=
 =?utf-8?B?N0xkSS9qWllGRG5ZVWZ0Umh2R21QSjNGZ1ozNFN0Y0Y0VXBHdENOaDVPMHdG?=
 =?utf-8?B?aVFMa3R1ODIxSzF4ck5NMWc4RE9XLzVYVkw5S2loOXUwZGt4eHdUWlN3bnZR?=
 =?utf-8?B?OHVFMStSTUFhMVJncGkxaU9KMTlnQk5ab2lNSkxKRjQxK2RFT0loM3FPWnMy?=
 =?utf-8?B?UU43bzZNKzNkUVJLYlpOUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlhTYlJMOHdpdC9lMkl2UFhGYWo3SEZQTW1GMXhBdUFCcTVuV2Q4RU05dkFC?=
 =?utf-8?B?cEd3NnFDQzMvOEI5UWl1R2dyK0VXdk16YUhXRWdjU0M2dlBtckdUVGd5dit0?=
 =?utf-8?B?bCtoK3NuUTM0V2Q1dWJ3SXJFc3B6UVlsbE93UU8zOUFqNWQyRUJGQTdFWXV4?=
 =?utf-8?B?MUd5NW9ET0p0WHJmSUYxYUNJNXI1TnRuQ0M3QlRCWlFERGVQSk1JdkoveERY?=
 =?utf-8?B?eVQ5Y2JvSjJqcERwTkg4S1pUS2hKdkhnMHNjUzFhM01NVGx1eEVPRytTT0c2?=
 =?utf-8?B?cXcvTXFQVU80ajlnTUg1TTJKRlZxeHBYbWphT1BmYWlTb1FzQWJiZFpZS2to?=
 =?utf-8?B?NFRDVzh2NEl2SGdFZmUwTWt4NFdEUWszNUJ0V0dSN2REVXhwVmVMODhZS3Ju?=
 =?utf-8?B?RC9lQ0J1dnJ0WGkzbEtaVC91RTNxbUZIY29yWmxqMElqVzB5b2YzYmFSMzNC?=
 =?utf-8?B?ZUJvbmNSUUVZS054VWJ1NkpmTGZnMWdjekZXTFNTRmhLODMwdWJNcWQ2MHpV?=
 =?utf-8?B?K05BcXJ1QVQ2TE8reTZYdkM3dHlaZjlhOFN6TzIxL29jZkcrZmhocEx1a1ls?=
 =?utf-8?B?eGo4VHgyUktwUDI0WUFlcmFVYk5sQzhKVUxUalhHSGhpOEVtMXVlQUFHN0Nw?=
 =?utf-8?B?eURTNEVWb2V4Vm9KcnVRWUZiTnhSelA0MW5kRjN0bHBJRGg5QzdqRWlVbHE1?=
 =?utf-8?B?MFV3a0NRbG03VDdlbVdKdFFoT25qclNTTWg1NEI0RVpCN3lhTklDMmdYeDRH?=
 =?utf-8?B?S3UxSnoyTVgxZGZBV0VCcDI4OVhwOW01TkthSGhoNGZTZjlJOW83Y2JyRzZl?=
 =?utf-8?B?aFJnWkhDWVlwTWpOOWUxaW4rMHJ5OFBSWklCSEJaTWxRUHJ3Z3pTUHE1RlJQ?=
 =?utf-8?B?RlVOMnBqenREQzkxNE4rTDlVMXBWNWxtczdSN1dvYm83RkhUaWxUM0lPQUo5?=
 =?utf-8?B?TnBlazkwcjFPOXlTbkErMzVGWGx0dDJoUHFPTXZOd1FjTUJHOUZWbU44dnJM?=
 =?utf-8?B?Q0c2Sm9lOEEvK241em9zN1c3NTI0blA2Z3BENU1FeWRtbktjL3UwZE9YVGN1?=
 =?utf-8?B?ZmsvaEZyV3JyT0RhNWVoRWhka01KdldDRERrdHRPYkRIUmZ6NG5nNWhTRzhG?=
 =?utf-8?B?ZFkzQ1R2cTVzNTNGSTA0akVmTWVXYVFRSmo0V0xONjM2WkljVzdaaXpkWjVW?=
 =?utf-8?B?RG5JZ3Nvdkw4d2puU1NiYk01RUxlTTArK1RFbjJmQVRtSUNndnFISUpYYm03?=
 =?utf-8?B?NDZLMCtsWEVZT3YvZ04vZWVxQlVwK3JYTFQwNUFCSDRLOUlNdTE5QStzR0g0?=
 =?utf-8?B?eUxnUno0Qmx5NzRLV2JmQTJUbkRsSmJzL1RLdENZem9vS2VnOEFPQ1I4aEdW?=
 =?utf-8?B?TWZCUGpqdUtnMnBVMjZoZzMrTklvMWd6Z05wditCTnhrRkxrZE4zQTh2Q0hP?=
 =?utf-8?B?V2RBQVN0b2Z3ajUvNUV3aGducGlwbmptNG5BcDJsTkJTYTNKZzFFS1R1K0Zq?=
 =?utf-8?B?MkpvbkdaL2ZPSmtjVk96N2tRSHM2OENvdXYrU0N3S3lGSHlHYkpmSHFEZEo0?=
 =?utf-8?B?WjgwTWlHQTZTdGQ3VjRIMllQRExkVmpHVW5LV3pUWlU2V1JFZ1lEY3pObjFI?=
 =?utf-8?B?a0JuaTQ3RjZyY3pRWHlhbENNMitwaDQyejBuT1lqM1pkdDBSVmg4OXlPVTlE?=
 =?utf-8?B?YmI0STZET2c2VWptaUNZVGVHMGhrY2hYQXJFdEJKR2kxdVBLK3dRclVoTGRx?=
 =?utf-8?B?NXM0dDM1aWdibmpuT1VpamN2MFlEM1hrSmgvUmNtZjVkV085R1FYTnU1ZGpE?=
 =?utf-8?B?d01ER3pUdVlGdkdkZlVnMjdTMG1TNUZIRm9YR2hIZGw4ZmJISUNUT0dYeWQ1?=
 =?utf-8?B?QUxmNFU0NTM4T2t0Zk9iSE9Db1AzUE8yQWRuVExSRmFOK1BzWTJtUVpGZjV0?=
 =?utf-8?B?YzZ1NjVUNktHWmF5a0dFZXlLejhGemkrSWZYL0tzNDhpenZhYXQwUy9MNyt1?=
 =?utf-8?B?bzA1cDFIbmVUTkcyK253eXYzWnpQTXhMdXZ3dzNVZ0liaE1xeStIa2czODBk?=
 =?utf-8?B?N2dCM0JzT2ltdVVJT1QrUkc1aUd0ZE12aWVRNkNmL2d5MlpUZ242UlJ4OWtO?=
 =?utf-8?Q?t3yaE/FCoTOCc3Ik6YQlJFKrB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ecca4-9b2c-4c46-5902-08dcd9388754
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 05:53:19.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edJzIP5E+FE0szqaItMlCI7FTpGXuc7gxGhBrAX8XBDGp+cUSmW6qIiPOEg09qgktrr6J1sYeLVW63VcOccG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

On 8/30/2024 1:51 PM, Borislav Petkov wrote:
> On Thu, Aug 29, 2024 at 09:42:40PM -0700, Sean Christopherson wrote:
>> Ah, sorry, if the platform+kernel supports the feature, not just raw CPU=
.
>=20
> Yeah, that's not always trivial, as I'm sure you know. Especially if it i=
s
> a complicated feature like, SNP, for example, which needs fw and platform=
 to
> be configured properly and so on.
>=20
>> And because that utility is not available by default on most targets I c=
are
>> about, and having to build and copy over a binary is annoying (though th=
is
>> is a minor gripe).
>=20
> I'm keeping that thing as simple as possible on purpose. So if you wanna =
make
> it available on such targets, I'm all ears.
> =20
>> That said, what I really want in most cases is to know if _KVM_ supports
>> a feature.  I'll think more on this, I have a few vague ideas for gettin=
g
>> a pile of information out of KVM without needing to add more uABI.
>=20
> That's exactly my pet peeve - making it a uABI and then supporting it for=
eva.
>=20
> We have tried to explain what cpuinfo should be:
>=20
> Documentation/arch/x86/cpuinfo.rst
>=20
> The gist of it is:
>=20
> "So, the current use of /proc/cpuinfo is to show features which the kerne=
l has
> *enabled* and *supports*. As in: the CPUID feature flag is there, there's=
 an
> additional setup which the kernel has done while booting and the function=
ality
> is ready to use. A perfect example for that is "user_shstk" where additio=
nal
> code enablement is present in the kernel to support shadow stack for user
> programs."
>=20
> So if it is something that has been enabled and is actively supported, th=
en
> sure, ofc. What I don't want to have there is a partial mirror of every
> possible CPUID flag which is going to be a senseless and useless madness.
>=20
> Dunno, I guess if we had a
>=20
> "virt: ..."
>=20
> line in /proc/cpuinfo which has flags of what the hypervisor has enabled =
as
> a feature, it might not be such a wrong idea... with the above caveats, o=
fc.
> I don't think you want a flurry of patches setting all possible flags jus=
t
> because.
>=20
> Or maybe somewhere else where you can query it conveniently...
>=20

I came up with this patch. Does it look okay?

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufe=
ature.h
index 0b9611da6c53..74c52bfd8cf2 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -41,6 +41,7 @@ enum cpuid_leafs
 #define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
=20
 extern const char * const x86_cap_flags[NCAPINTS*32];
+extern const char * const x86_virt_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h
index 734940fdb6c1..20f389ee0079 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -382,7 +382,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_=
CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
-#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "" Bus lock threshold=
 */
+#define X86_VIRT_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lo=
ck threshold */
=20
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector B=
it Manipulation instructions*/
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapf=
lags.sh
index 68f537347466..3671c7892c56 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -62,6 +62,9 @@ trap 'rm "$OUT"' EXIT
 	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32" $2
 	echo ""
=20
+	dump_array "x86_virt_flags" "NCAPINTS*32" "X86_VIRT_FEATURE_" "" $2
+	echo ""
+
 	echo "#ifdef CONFIG_X86_VMX_FEATURE_NAMES"
 	echo "#ifndef _ASM_X86_VMXFEATURES_H"
 	echo "#include <asm/vmxfeatures.h>"
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index e65fae63660e..3068b0a110e4 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -103,6 +103,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		if (cpu_has(c, i) && x86_cap_flags[i] !=3D NULL)
 			seq_printf(m, " %s", x86_cap_flags[i]);
=20
+	seq_puts(m, "\nvirt\t\t:");
+	for (i =3D 0; i < 32*NCAPINTS; i++)
+		if (cpu_has(c, i) && x86_virt_flags[i] !=3D NULL)
+			seq_printf(m, " %s", x86_virt_flags[i]);
+
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
 	if (cpu_has(c, X86_FEATURE_VMX) && c->vmx_capability[0]) {
 		seq_puts(m, "\nvmx flags\t:");


Output for this patch from /proc/cpuinfo looks like below:

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe=
1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc c=
puid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 pcid =
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_leg=
acy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs ski=
nit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb ca=
t_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp vmmcall fsgsbase =
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdse=
ed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512bw avx512vl xs=
aveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_lo=
cal avx_vnni avx512_bf16 clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin c=
ppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decod=
eassists pausefilter pfthreshold avic v_vmsave_vmload vgif x2avic v_spec_ct=
rl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_=
vnni avx512_bitalg avx512_vpopcntdq la57 rdpid movdiri movdir64b overflow_r=
ecov succor smca fsrm avx512_vp2intersect flush_l1d sev sev_es sev_snp debu=
g_swap amd_lbr_pmc_freeze
virt            : buslock
bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass

- Manali

