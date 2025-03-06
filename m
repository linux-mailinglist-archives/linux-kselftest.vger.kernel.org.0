Return-Path: <linux-kselftest+bounces-28368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7364A541B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 05:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096971891B19
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 04:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948C1991B6;
	Thu,  6 Mar 2025 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LlO46Of4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6A10E4;
	Thu,  6 Mar 2025 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741235921; cv=fail; b=mRB5jN1aDRVIiRp90sLJ315s5Y4RiZvK0PiTmNKCkpxkdsdafpM7VpscX0OWvvXwXE0MhH0xsP/jzQY65kxQx3ztd4bCK9ptOldaYix/yJXUDBb1zesWH10oLkyxoe1U8bSdb54ncKuINtV8J83Mtvc8Tukl106yhYST7A4JOeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741235921; c=relaxed/simple;
	bh=HUZ8x3Q+3+XD13zQTckdPm7Ks5r5GCTdG39Z1hm84HU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q+4+1JumDipv/LQF/Qu4roHECOPhjLiXvUlLkkVbNt9/7FtS6454M/ZjorjGUe3IKZR8oP29xgCgBzzIiUL2o0AXOFctYnrlCh7hg8Mms0dM/0158LhQS/n3Tk7tFpTir3tyPYPPMZuNIcYmPh651lgU0ettBV0yH8QJvor15Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LlO46Of4; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT7W+VTS/xz/YojIJ553LlzgDcBVGB58hpsmunvWi+jHnT5jh/R7pApJJqmDmCqf4ZNSfkIqi6jKND+6di96/kv+cs1331/TELF9nsS3NRzNPO1dKgiCtfEv9PlaKj7SvqS3ZAWcK/m5MScoyLV8usy5pAO6wq3noT7WhjN7wPczoEDYQs0lasXUuWJYtfYW9+9V8LQBRtuR6XFZmG/lfeWHgZRF7M+LGtc6miNrEvM3txEe+N0HuCEuZwSDZdAWVFSh1pNbdD1LxeXV0PtxbHRRiXZUE+zwa2mOrqvDtBL/rNyJcGJ3iKNyqMx5Fes2Xb77/+VnoCX6Jq4iGbmPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWUDF/Io9+q9IalTTht+IvGmPZPRdzTgExgzlbkUSFA=;
 b=hWZbLBLn8oFpX1Nz5xRdCORIYVfCtZO8j5Ol7HqGowXXDFjP9K+b8d8YUKLxtxlWEfY5fCJyPCw5UE0dQXwLY0rS5lEVHnFSEZMgV94o2v9PTRmJVJFnIKL63iqbell/U/uZYed4pmSrbArdXex5c+gWflWPVeV7T9ynie/aSRUCcpSEGtnfQM8ZaYNrzNJgPN9+4fN0VwrUHAT5JRUuY+AcPgS6CIZQ4sLnejvQhOzbDmC6CalTwIEnX6seBlU8Q9DtAhBCe+gAqlHx4rzplfGI01b3tqBMljEgyHeguyki/2MIgFTHJK1diHe8R7bSD3+QBAZupEK2/eaj5xPbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWUDF/Io9+q9IalTTht+IvGmPZPRdzTgExgzlbkUSFA=;
 b=LlO46Of4ZoBDNqldRGbDojjQM1nOVIs3AnX8D4zSXhHb3/GZX1eVVWR21rexT78HnXEAEr9uY6UGOtHGryCoRCA5/qZ5aDVCwsVls3LdjDIHXKO3ta8hitkFAfpTNm5QRa300wvPTYWKtd42N1PL614rjabsHqnJRXssL96HNOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 04:38:37 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 04:38:36 +0000
Message-ID: <6e342579-efed-462d-ba2c-c844e0d614df@amd.com>
Date: Thu, 6 Mar 2025 05:38:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] KVM: selftests: Add vmgexit helper
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 ashish.kalra@amd.com, nikunj@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250305230000.231025-1-prsampat@amd.com>
 <20250305230000.231025-4-prsampat@amd.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250305230000.231025-4-prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 20dc9949-33cd-48d0-c4c8-08dd5c68c236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UW1XdWpKSkVRRkZzdklrS0JlbnIvcjZjWlI2UjFweWVYQ3k5TmFLbGt1SE1a?=
 =?utf-8?B?TzNvWHh3cmY4UXU4RWwyUEJFOW15enAya1pldmJUTmtkWlpWdVg2aFI3OEJr?=
 =?utf-8?B?cHlhNFBpUXdqaTBmTnNHSTB2QU1OTmRsclBFVXg4OHhmRjRTajhLQWowRVho?=
 =?utf-8?B?UWhRYURmK3hCbkd3Sk1YeitsenkzcXV0WnVqV241UEhqeFR5cDdPSHVFQ3ZG?=
 =?utf-8?B?NW56N1M4NFkwemJnOE10L1U5bzZTQllVVGsrOSs3ZlUyWFdBUXJ4dldBd2R6?=
 =?utf-8?B?TFdvMHBac0pGRzgyTWxCa3FFUmF4RjJSMW1vV3VXUnJsRS9URVI5cHdwZ1dE?=
 =?utf-8?B?VW04SlYwcWJndGlWS1VKZDNNNVpUZ2xHVzR2L0pIdW1pclhTb3RpSXBCL2ww?=
 =?utf-8?B?dkxuMFUxTXQvcmxnSHg5TWxnQXgrMVl4dENkR2g3OEtxaHU1OUZ3cHQ1dVJx?=
 =?utf-8?B?NVdYekVuV2M5TkdEelNqNDZwNG5FSmxCVFNSY1FTL1YzTVd0cmRlQ0hnamlH?=
 =?utf-8?B?Wmlmbm94akF3Q0ZPaHpPVVUrQmtjUUN6WDRsbEF3S3QvTm5tUko5K0xiYjFC?=
 =?utf-8?B?aFVrMkRUazZKdmJXeTk3a21YQ2pRalp4M09zY3VwZnpTcHJFbXZuc093NW5i?=
 =?utf-8?B?TURjclpjL3U5Witxek4zSXZKbkJsR2NOTUlzc0JteHQxWDBIY2cvWW9QTXc1?=
 =?utf-8?B?eG4vdE9FMUZVbXNvVEhMWnBPbExtT0wwbExOUlZTbHEvQzlESjhTa1hBT0lt?=
 =?utf-8?B?WXgxNVRPWnJ6MHJ4MG4zKzdSOVozVVdRMDZPVkhKa1ZZbEYyd3V6UnZ0VU1T?=
 =?utf-8?B?QnJXK1k5ZkZnZjQzMkh1L0tFajhSaXJUSE9zeGg5ZDNQMGhTMWRRY0xua0Zy?=
 =?utf-8?B?czJrQ0VuNlhHVi9TTW82RXBZYi85bkp6WVR5RnplQVVXVCthZjlWVFltQU5Z?=
 =?utf-8?B?SWVwVE5GcEdSeXlyU2pyVzdsTWNWcnBnM0pmRXZzMVkwMlI1SC9CZ29kM1Yv?=
 =?utf-8?B?eDJHL2hvemdqMjgwdkttRW5wN1lUM3FHWUwwTHp1cytVQURHZk02b21qZnh1?=
 =?utf-8?B?VmlPRkpZS1R5dGN1RFFWVnl1dWJEQzUvYVZBVmVnbEEvamx4VUl0cnVVUDU5?=
 =?utf-8?B?dnIxRURFckEvNzFnTXkwWVkrQzZQOXFzT0NoUVJHMlJJL21qdEtCNXJDYStl?=
 =?utf-8?B?M2xsYkdyNnFuR2tIWlQ3U1lXT3NySVJzYWRYN0tQd3ZPTVFPRWkraXpYTGht?=
 =?utf-8?B?TUZpNk9uN3M3NTRSRjduWVFkc2hNbFZqTStYZWxUeEI0ZWNXMmlrTjJrR2Yw?=
 =?utf-8?B?bS9zTFBWN3Noak9oT2g4dEFpSkRqUDNCMnJ6SW1Wa1dtQWx5UUZEOVBxYXFI?=
 =?utf-8?B?bk5BM2NnUStkb2dnYmRHY1lncXloK2NzYmIrNVZFRjY1UHFqRmxZaVdZUlBm?=
 =?utf-8?B?K3k3blRaSHNJVllWNk53UnFoVU9xcURFdVJHQVBXbTFtR3lmTkJxdUI5Mnk4?=
 =?utf-8?B?ZngvZlV2QUd4Szg4V0VCN1FvbFluOUR3T3NmRFB1VGFWNTB2dlVNbnRiRVgv?=
 =?utf-8?B?Q3gxMC9mSkd0RjlXc21WRkYxYXhGYW1oYVJJdE5pYmxsOC9BV3l2ZXJoNllL?=
 =?utf-8?B?a3dZa1V2VERwZVFickpZNFJja1BIN2xRUHFJa2l2V3ZXNit6QldXb1VTQ28z?=
 =?utf-8?B?VDg4QXhRTDV6RVoxeG9IelNjU1MxY0pJUm1jYXZDbWZuallQMzJHN096VnZl?=
 =?utf-8?B?NnlvM0p6YXh4cVlvdGVjR0swa2pzUU53K2VCUGNQWHZFNFl3VXVWSGt0Wklx?=
 =?utf-8?B?QjhWUGNIUnVnVUZ5MjNtYUROb01EeEJsVm1rMS9zL25PMVNXRUxUTXBJaHlF?=
 =?utf-8?Q?ONDAc8tXQpxl2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlFsQUY2NDRqZWdna0U1djAwWk5XOU5hUVJYWU5YQmFKK3FiVVF0Smg2dE4x?=
 =?utf-8?B?RThjSFhMQTA1ZitRdVpBQXk1SjBMRHk4ZUljN09sa2swekdJWFNIZ2pyZ1k1?=
 =?utf-8?B?dlZFSTllRzMrTGZySWlJV3ZhMlRNYWZ0ejMyaVg2YlJ1YWF1RGVYYkxNVi9q?=
 =?utf-8?B?WklVRFMzVGhOL0kwOVgrWVFLK2IxTk9jb1E5R3lheERmalFnTVgrSEdnYVZC?=
 =?utf-8?B?TmNhdDJUNjZSQ2tZa1BCbXJLVnJiZ1BuTGM0azY3dXZWckRGU2hPSXpBNzNr?=
 =?utf-8?B?VlJEWGNRbFJSQkU4YXRPbjRXaW5hT3lNcjluOVh2RVBSMlNPOGFtaDlJTkxK?=
 =?utf-8?B?OEszRW5jZ3AwWG4wQ1JtUFdUZlkrNktRVWJBZWhjdkJzY09IUWl4Vm5qZko0?=
 =?utf-8?B?T2lPNDJnSlFNL0VkdDFHaTlqM1lVWHBjaEoxV0tReEpuQmp3S2szbTdVRnpq?=
 =?utf-8?B?NzUwUVF4RHp5bEpsVWRBUVhDT0t6dEZ1Zi9rYkFUMFFtZEtiU3JmaHVpcFYv?=
 =?utf-8?B?M0RkQlc3eVRsMGJyUFVBZ0k1bEFtRTNDMGFaUCtxVnBNOHNQc1l5ZlB6R2p6?=
 =?utf-8?B?NWVpYm1MM2duaXZ4S0o2S3R3VnlyTDhJZVVWQ3pMNXJDMDlBN2tFS2pNSHd6?=
 =?utf-8?B?bDFoTndXQlhVY1A0VE1oZEozRHJwM2pCZ3JSdTEvUUFHYkxqKzRIRlB1U01T?=
 =?utf-8?B?dTl5MVIxYWRvSEdkZE1HRzlTTStweWdDcTluMFRwOGhkY29tbnJnMTQ0eFRX?=
 =?utf-8?B?RzVhTTNydDJab2N0TE9Mc3hrTXBBZWtwTkhSMTVBeFZXbCtQSkhCVzBvb2xI?=
 =?utf-8?B?MnMxS1dlMyt1RDlkUTEzYXNXclNhc1U3ZHdMVTFIRTRnaFQyMWdPV01FejRu?=
 =?utf-8?B?V3VsTDBBeWR3VXJVdm8zbmxrQWUyZ0pBbUNFOUtNTHp5MDE0eWhOWHcrUUFm?=
 =?utf-8?B?M2tvT3kyNnV3MkplVmQ5bGR6RVUrSkIxa0FQa2QyWWlUcWlJbis2Wm1ZR2Vt?=
 =?utf-8?B?Q3dQM1lxS3hVUHd4ZHVFZ21rRHhmbXJCUHcxNzRWbEpjNWlkRlRtWXpPeVRr?=
 =?utf-8?B?MkYzaFNtZWZoeXBpL2UyU2RLTWNkOEVtZDlJVFpoa3VzMlU1bVdEdzRiRW9w?=
 =?utf-8?B?Q1dhdG1QT1haLzJZVWJTUFRCbDY0ZDBBU2Z5T09FWGJ1ZEFZNktyQStiQk4w?=
 =?utf-8?B?SXBjL0R5R1BvUi9HSGZOOXduU09raWdFVVZxZWYyRVQyV2Z2dFBVSENZb3Fq?=
 =?utf-8?B?cXBPTVo2Qk1RcjlIWTRVRjJiMmNSNFFNTnlvbkRGK3BSNytPWUZ5SW03OFJQ?=
 =?utf-8?B?dG04WnZuRDR5UkV6MndXdkttU2p4SnFkQjJERFRycFRrTzNIRUFUelJNeVo1?=
 =?utf-8?B?VW5HcElXdXJDZUJYa09ZUTk4VkkwVWkzbnZMbTQ3TDFLL2FnNnpYMGRDRGxn?=
 =?utf-8?B?cVZsMldVK2IxSmJ5WkQ2UHNDNjBCRUt6akhGMzFxZC9XVHZCQVNQaHd6aytZ?=
 =?utf-8?B?VEcyNEUrR0Y3VTlkK0FtWE1RUUx3TDFGbUZHaEtDZW9mUElyTFRVYkdlb00v?=
 =?utf-8?B?L0R0YWF6cXEyMWJWZEQ2NnNDa0pzK01qU2xKamFiajYvMjZId3lTcW5pVWZO?=
 =?utf-8?B?UXZLRmlOYWRFMUVocDBTL1lSaXF6MTJna0RJYkpiMFhXT2k4djJnYWdVaEdC?=
 =?utf-8?B?MDE0aGR5Q0NYT3ZqNFhxREpFNU4wWXptUTRCM0NkQ1N4QlhYWk1YVEpPcjRS?=
 =?utf-8?B?ZnUxV21idFpGaS83OFFNT2Uvd3gzc2YwTDNCQmNqSThXVGYxbnFZZUNqeHR6?=
 =?utf-8?B?YlkrdlJYUHdJbW10Q0xrdGlPOGk0bXFEQVFEc05HUGhzY3didC9sL0tsL1d5?=
 =?utf-8?B?OFUza1ZTWXA0dVVvL2NVQ2Z0Rkl4akdzeDRGQklNT0VEdlRsUTA1dU1YNFl1?=
 =?utf-8?B?K0J1eVRHcVFvbmd0Mm12WlNkVjVNRytIVitweTAyTk4yTmZBOWRYZCt5aHc1?=
 =?utf-8?B?aXpXdWNXQU5qVWhiOFE3NXZDa0crMEFQMWdEMXRCeFdLbUdoaXN5RGFYYnVE?=
 =?utf-8?B?Rll4ODZqSDFXU0JJT2xRNExoaFhOcWtFVXZkTStteVdSc1FYTlV6Y0RXb1BN?=
 =?utf-8?Q?uWcuWZQ3nufyDSnTDUcOkcTc+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dc9949-33cd-48d0-c4c8-08dd5c68c236
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 04:38:36.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0DmD1V4vEHpyuP/Yb4mXDVz3lKqee2Npjto9qXfZ7BRKXXXMoIHtblvlh+DaNOj/eRPUVHnc3SF/6RGAXS22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898

On 3/5/2025 11:59 PM, Pratik R. Sampat wrote:
> Abstract rep vmmcall coded into the vmgexit helper for the sev
> library.
> 
> No functional change intended.
> 
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   tools/testing/selftests/kvm/include/x86/sev.h    | 5 +++++
>   tools/testing/selftests/kvm/x86/sev_smoke_test.c | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
> index 82c11c81a956..3003dc837fb7 100644
> --- a/tools/testing/selftests/kvm/include/x86/sev.h
> +++ b/tools/testing/selftests/kvm/include/x86/sev.h
> @@ -71,6 +71,11 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
>   void sev_vm_init(struct kvm_vm *vm);
>   void sev_es_vm_init(struct kvm_vm *vm);
>   
> +static inline void vmgexit(void)
> +{
> +	__asm__ __volatile__("rep; vmmcall");
> +}
> +
>   static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
>   						 struct userspace_mem_region *region)
>   {
> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> index a1a688e75266..6812b94bf5b6 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -27,7 +27,7 @@ static void guest_sev_es_code(void)
>   	 * force "termination" to signal "done" via the GHCB MSR protocol.
>   	 */
>   	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
> -	__asm__ __volatile__("rep; vmmcall");
> +	vmgexit();
>   }
>   
>   static void guest_sev_code(void)


