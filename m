Return-Path: <linux-kselftest+bounces-24242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8978A09D6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F323A97F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7775214A61;
	Fri, 10 Jan 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3vBNgRC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7520ADDF;
	Fri, 10 Jan 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545857; cv=fail; b=uTTYKvIXvobyzX1gLZLO1k1JnCeyyJghdz+WPDn28DYO5B6CihxdzKSR59FD2iIktuEDo2tdAI+raV36tGWXou/JwQk9WL2SnjxIkbMVc39BqPkxNoQXJq1rBIHKDRTFZRULmLigBie9ySQALWfJkTDqRvhbo+zJTEpT3UQTMYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545857; c=relaxed/simple;
	bh=JayU//tnYy5k1kDUVRiQFPzCM6Ajumv5VKzuzrrLF2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LpFDI33jQYoUQFF+C/ad8N1GQDZZumkKnUD5YJr5hdG7QAfmgMGxqDROeVUzkTcC7sUFtlSzwJA5AITOYT4mV/phHl2upkQqGUwFKrhjHSzO9MzRBS2MGbL7xgxZoZD6yG3eHmJXAFc4IrKdZQWtfNlOPiD90d9TIA7ivsGvYCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3vBNgRC; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP+0SaNxu3NDIz8q7JqwgeI6Zwv3Wm7gFQ8UgKN3MIVBYF73zNiSZFixkYCPht+o0b1pBJq4IBY3v9N2FJWXYiFG22OzL2+1wa530Cs6lkhRZ26J4u0HuHZL6SqUNgx1uGqQ4Z+5MAXP3Ei+4iCuc4xl5ZtlEFjOyEqmPk4jvuFYkEthNd3RNVSmJol+i9hEBqRy9Xp7yFsdtlVRPY1u7ThClSi1sLOGKdKB7Kxp0ErH0YFmOru1r81B4Rcx6gYol2oyWT40bafZGlUh4BSVBfs1+ZJSg0ivagFcfr2y3k23GHomsBN1Na8hmVqwN7QvhRV4EdYGhOY9+pI3bkJyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ObxngYLjK/SvN+UrUM4IwXqjkCbh4+JdCKZ/juJJ5Y=;
 b=rPi4/aVsg+qDELP4/TscHd5hW//f38/9rmciyw6RyatM43rt6bZmGUVEPiho666V6KfK7uLpOCqldQsIoKr/lKX3vRfry4LdzXPynmSG9llvkCMkwhFJ5LA8tmFUoEhwIXloDSe1luYvx0BLGDmUv9pwKZIvaqvE/8IbRn6ETKXz0omAucwqAAL8uXILBxi5YqWudKwTcvdLpFbTwzueFFk0cimEUbZFm5u4uuik+N3XT5fbOQDWycJblsPnFy4z0W8/3cLeUODnLZaj6NBaEMWL9mwCVdB5HLBC4v4/piKALIuCW6FiezVtPWJ1w9wjNTGoG1RnvxJ8lyF8menZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ObxngYLjK/SvN+UrUM4IwXqjkCbh4+JdCKZ/juJJ5Y=;
 b=H3vBNgRCr/tTC9EZ1m459w3OHhIwOs006RKvKTRcUxw8Syp9Ge+S2qNPPIY+Efuy4Z5OizyLVUsJUxvkhOA6YujIbyEbywe79mYwk9slYIaGpCbWQbM3oSuaufniAP1uPnWWqSy9l1OO12seN0SAC+rR/VYVI9Yg0nHGsbSPzg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 21:50:53 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%5]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 21:50:53 +0000
Message-ID: <44f88f85-b74b-4426-8105-b942e9a854b8@amd.com>
Date: Fri, 10 Jan 2025 15:50:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v4 1/8] KVM: SEV: Disable SEV-SNP
 on FW validation failure
To: "Nikunj A. Dadhania" <nikunj@amd.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-2-pratikrajesh.sampat@amd.com>
 <9b7d7abd-ce7d-479c-89a3-7f305c0e732f@amd.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <9b7d7abd-ce7d-479c-89a3-7f305c0e732f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::31) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb9d53b-b874-4159-ec28-08dd31c0db05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1lZTCtCc2JOV1V6RFA4YjVXVnV2LzltVmx5SVViNUdRUnJFeEY2Qm12Ym0v?=
 =?utf-8?B?d3NLeGljaDh3OXk2ajN2bDhmNHcvUjNpZmtucHJXSVhDMXlzVnNNMExLZzdv?=
 =?utf-8?B?NGxySGgranlQL2VFcUNnZ3IyWUxpUE9Dcm1jcDVKdm5WS3VBbTM0cjZCb3FL?=
 =?utf-8?B?TDlLT2ExQlAxQk8vbVpvMXdLVDdoM2xuZHFIM3JHV1NHVEN0bUxwTHI4MUhY?=
 =?utf-8?B?dG9kRjJmWGNQODNlaVhqdWo4UlZFc2NzcjllVXZCMGlpSTh4ZFVoNG1CYndE?=
 =?utf-8?B?QjRnVmUxQ21pZmZTOVJEQVpKd0ZjZm84UXZOUmhyU1U1elFFUFBqS0VBWG8z?=
 =?utf-8?B?Z3NEZi9ybWkyZ1lnTzVGdmoxdlg3clFJbktwWkZJWUU4ZnMvYXViWTJYSEZw?=
 =?utf-8?B?WmQzTGduTFFvRGNHSE94eVoveVB4eE9ydisyaUVMOHM0ZEJGQ0c3dnVlRGl4?=
 =?utf-8?B?Nm1DMGdpUE5mblEyOE81UFpRcDg3SE1Bc1NUU1c5MS9ScGVQdHRRakZQMWI4?=
 =?utf-8?B?UUNTeVBoakNoRjh0T1FsRXNScHp4QVEyTGZFd2RWR3oxUmRiQXo0SHo2eWhk?=
 =?utf-8?B?Sm5mbU4vMllIRm5kSlJTd04veUJKZmJVeTJzYXVXQjB3Ly9CL1o3SnB2R3FO?=
 =?utf-8?B?V3NwNUk1V280dTQ3SG1ocExxTWFEdDd1Y295OWYvSzNSajdiMVE3YVdzVWc1?=
 =?utf-8?B?Rm51TEQ1c1cvOHN1d25OOU5pMDJYajRyVDRVOE0zbWhhZTI3VnFBT25BdVB2?=
 =?utf-8?B?TE10UmYxSE1BcnBmNi9iblhDSTRvU0o5S1VjdFJlQ2loZ2dqdm1uL3NCV1hW?=
 =?utf-8?B?UmV2dGVSSktUbVpCckxaSUdOUHNkeHh2ZE44S2VIS3lrKzgyRnJOZjQ5a1RD?=
 =?utf-8?B?QnNIM0t3c09QTkdHbW9UOEVXOC80ZWlxY0l2TUk4cnJuUU5Vc282bTJQUlB0?=
 =?utf-8?B?ZzZjWDJjbGVhOUZOTy9hSnpIOHE1NUFnUGRGZlBjZjYyTTBMWC9tN0l3SUcv?=
 =?utf-8?B?YU1PSVhMeGRPUzYrRDhjSjFHek5LcU5iUUJ1cE1GRUxVSUxYcEJmZkVMNmx5?=
 =?utf-8?B?NUdtU3lpZXBJUVBSV3k5MHlZbGYxNlBkY2VKeEQxaEdGdlR4NFB3UGY5MHlu?=
 =?utf-8?B?V2JKMjJ3NkZvQzdXb3FMT1Y3em9hNE50RjBxaENNWDZjU3dMQXMyc3hmTzFX?=
 =?utf-8?B?MjdaWGp5NjFxQ2pjQTlFdHF2QnJsRW40NGlybWZWOC9EdWFRbHo5NFFCSnNH?=
 =?utf-8?B?cjF0Ynp2QzRldngzZkYybmE1b3pZNll2R1ByL2lXSTNNTnI1N3NFMlZiY04v?=
 =?utf-8?B?RmhoU2MzVHJ5anNHTEx1U2pDaFBqc3MvbG9XcEJabi9oMFNHYzdVcEtiejQ1?=
 =?utf-8?B?Ry8wY1RjYnFFc3kyOHptTjR1NEhCcEJtMVBiVG90UFNtVENaejVsZ1RDRUNM?=
 =?utf-8?B?bkEzK0wycHFMa3pac0ZreXVBQjkreDJ1RFhROUtrUklnbnpTVldvTWxEY1ZN?=
 =?utf-8?B?V29SVU9lY3V2SDN6Z3hGVWdGZzNEMkxCN3Z0MHR6WWh3S1JlZSswRDVIY1hz?=
 =?utf-8?B?MmNmU2JNLzJ3aEYwa1hDa2FZY05jck54cld6OTF5bG1qTXZRMDl0VTZ1NkNv?=
 =?utf-8?B?NnM5cmhycnJmaEN0ck9BOEhWNWhDUkQzWTN2MDlPTFVLS0hYN2d6alVFd3NK?=
 =?utf-8?B?dGZFSHJWU3ltalRwdU9jc0UvTzJWTGJhcVJmZjFqYlRWLzczOGovNFpXUjBC?=
 =?utf-8?B?ZzVHQVRva1oxWFpLajZMa3c3TVJaN0tkNk12UEZLaHNQY1grTmg2K0VEbi8y?=
 =?utf-8?B?emF5N2s5TDVlYkZSM3VyQXY1UmxIYytVRm04eFJiLzBUN01ESDY4eDI2aHpW?=
 =?utf-8?Q?uXE1lesMpfeQ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0x0dXZoS3FFeFY0NjRBN1VhT04vTEx1N1JSRWVWelBwdDhvRi9ZbUZnKzFt?=
 =?utf-8?B?UFFROXpKZHppVE5tSEFLZG5hRXZqNldPZ2Y1RHRDYTMxaVNWaFlPc1dEdWRG?=
 =?utf-8?B?dUUvOHNLK1ZnQkt5Ym5Md2I3aCtGVnJRWmcwU1YvYzE1V2Rtc1lNNkRIVVQv?=
 =?utf-8?B?V1hJSUFJUkN6dVFScFFvTU4rNktUWEtReDd1ZDVZVzcwL2ExaHpiTjgwbklv?=
 =?utf-8?B?a2lSYlNjT1ovQWhhTWdma285dTRFWnJCSlVkVVpKZ3VSM25kTTJmYUNySXJx?=
 =?utf-8?B?NkRSRWVpM0NxZi81UjRsUTBJZ1VFKzY2dHhDM0N0cVJjNzhWSjNoeVY4WG1N?=
 =?utf-8?B?VHUzWVVpUXFoWVpCZERjcGp3WTNEeXpzcmg1Z0dZdm0rbUh2UXBHZXB4WjFw?=
 =?utf-8?B?WXFHV1JLSkx1SC95K0tYWTgwdkRsaVhRdWpZYWt4c3dwOVlwVmxNd0ZobDZU?=
 =?utf-8?B?bW8rcUt6bWZxVHdxTjBXTmhPUWdVZHROZmhWSWZCclAvRElmU2ZiVHFxV2d3?=
 =?utf-8?B?NDBYOEV2bThjRG1HemUrZWwrUVVPOExiMEVScXpNeHE1UzJiVkxpOE9ES1hO?=
 =?utf-8?B?akhtY1VlVjdrTUhqc1FOcDBUYkRjUTJXZTBKeWxmMHFPQ0hwQzdtVDlhT1Q1?=
 =?utf-8?B?MXBBalBoNndBVkd0cEZqZElxU2xCNk0wM0ZtdlQ2ZEVtKzAzMHlUTTRWNk5V?=
 =?utf-8?B?Y295Z2dDdHVuVVd6RTVsSGd5dTFFUXc2ZkltSmFzQ3lFWjB3RTlzMGZESXhN?=
 =?utf-8?B?VERmQ3daZE5Qb0lhUlNqMlBmU3ZmbkU4WnBqYzZka2t4MFVzSzFmTFB4Rmc3?=
 =?utf-8?B?cnZCbitGWk5yTzN2N1Nkdi9lQVo1SGFxeGZpQklBc1lrOVZVdWY2VVA3RDBZ?=
 =?utf-8?B?TlVMMHZsaUFzaTBETVVhQUJrTHRDc21mQkd5Nit1MjN4WnRrcFNIYnZZenZ1?=
 =?utf-8?B?cDRNLzR2V3d5c1pjSi9MeFhBeDhoK1R5Uk1rOWtOOTh0N3U4amdPWkRSdU0v?=
 =?utf-8?B?dUN5UWNNVW9pSE1oRG44eURaN01keWc4SVozSmZkbng5cTRrRStVU1hMWXI2?=
 =?utf-8?B?MzNLODJkSkFocG9ocGtXbTVJb1N0SnZOODY4V0hwZ2I5b3BtVlFBUzNCSVNW?=
 =?utf-8?B?cm1WWVpnZ2l3dEFHRDBoOTNXTUh4QVRvM2E4Y1VPVW1acXNLcHBmVm9ubkti?=
 =?utf-8?B?NER4NzVqWW90QWJodXVWSmpTd1RjcFJCVnpXVXlxbkdZcWp1NkxRb2Q2NnhL?=
 =?utf-8?B?UDVlS0thWWR0Q2VtZUhYS3dSWmRnZGJ4WlRwYUswcHdySlUwM1F2dForaGNV?=
 =?utf-8?B?a3NKS2p6Y0F4WlRHWlZPT3Q3N2d4MzVoYk9HQWo3OUNyWU5uUkFvbWpjUzBh?=
 =?utf-8?B?b1liMVdUZ0l2RmwwUWlJeWNXWU1sdGQyMy9mREFjaXpNNVJiem9yVXljT1Z2?=
 =?utf-8?B?b2ZRaTYxQ1BqVHdmSXdpRUJqcXZPbnNCeGVJNS9OSDM0dXBkMlJZMHZHZWZO?=
 =?utf-8?B?amxXdXRxT1lJWnhFZi9GVTdFbjl6RE9maWNNdVNPZE10RXE5NUp2L3RJWFJy?=
 =?utf-8?B?bHhDaHNhOCtPeU1sYzhVRHNoeTFtYk80YzZVU3VYNGt1SmZMRFgxMFBlY3lV?=
 =?utf-8?B?OTV3N3lONHp2bWlRZkcrWE5tYUMyZE1nOXFkWGc3bjdoYTA4akZudlA4Nm9z?=
 =?utf-8?B?by8wa1VxNE9Dd3dRSllYWUhjZVEra2F1a1ZwdVdkWjNmcENzWkNNOFRJeUNM?=
 =?utf-8?B?ZWZzYnNWQ1MzcmEwT0c2dXZHQkZxdXo5NTFBS0tDM01FbXlYMEc0R0ViSlBG?=
 =?utf-8?B?a1JuY3h3ZkdHTWpWK2xHRXVtcklkQVJqNUtaczVpcUNhdWlBTTZEV3hNSUt2?=
 =?utf-8?B?alBTWWRJS29hNXZRSzdoMWlSYmVob3NVRGw2TGt3NUVOYjA4anhsZHNSdTd0?=
 =?utf-8?B?ZzZuS3NUdE5QZlh3UXhjVjhiSzVLT0pNTEhWVmMyN09FM1JTcXZ6RjFRVkJT?=
 =?utf-8?B?OTdOYXVaZWxJSUxwS3BKZW9zc0ptaHJ4S0ZURitzSUJnTGVmK3JuMlMrVXpw?=
 =?utf-8?B?bG5tdHBUSEZyYlg2WkFxbFB0QjU1Qm82ZW85cUtvdjFqWWpTRm9LTWhUdTV1?=
 =?utf-8?Q?AxN+NckhxQtQIa4YToF2P0RYR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb9d53b-b874-4159-ec28-08dd31c0db05
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:50:53.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERQxhdwzUNk6YZbvPjJTqtegybFQdxHCmFMuRNx/tnfy/gYR5Tcp87lOLEg66PRlPWTdMNxVcqt2KM2Bx0WBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

Hi Nikunj,

On 1/9/25 11:21 PM, Nikunj A. Dadhania wrote:
> 
> 
> On 11/15/2024 5:10 AM, Pratik R. Sampat wrote:
>> On incompatible firmware versions, SEV-SNP support is pulled and the
>> setup is not performed. However, the platform and subsequently the KVM
>> capability may continue to advertize support for it. Disable support for
>> SEV-SNP if the FW version validation fails.
> 
> Additionally, can we ensure that if sev_platform_init() fails, we do not
> indicate SNP support?

That sounds good to me. Although if the platform initialization fails,
I think we should not be advertising SEV, SEV-ES as well.

If that makes sense, we could do something similar to before by
exporting another function from ccp that returns whether the platform
is initialized. Then, within kvm's sev_hardware_setup(), we can check
this to ensure that none of the capabilities are set if the platform
initialization has failed?

Thanks!
Pratik

