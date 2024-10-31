Return-Path: <linux-kselftest+bounces-21217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5D9B7C37
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F761F220BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FAE19F41A;
	Thu, 31 Oct 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vadiW8y7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108F19C56F;
	Thu, 31 Oct 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383018; cv=fail; b=cFDdAVWX4WDkiRHmCkY+ym26bMi6eY/+Oqcp6rJPWmtB/HuhlUtNbn4hEodT9I04TsqpX5v0Y+6392kFiagnun6cs2msGBGdstCy7zlzcEFYIqdB5pzIr8Qo0G8GGNMUkh+CYuJ//eMunetzVrjfeUjk36pqwE1qAnwleH6yQUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383018; c=relaxed/simple;
	bh=ngtdKQrKICrXAC4cC3snB1Aa3F+S0xLvEP7C2IPlfI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EgxjEAbLpI9pfIrUK/drd8fCY9w5aDrFlO8dEJutERRv8zSn0yN0hQEZtC97RGIyvIZAkxtqQ6vlUYI6DmG82VZvNDLOh5e8srBiYWu3dQ+AMEK/rufK993hqJJComDsrrMskdtAerp5ySVTTv05OJcTO8HBZCz1MAOFJ1BM80I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vadiW8y7; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHBu8MsQXV4XvY2HgwDlHO+XxLF57aWChcc5RH34O/Yq0dNztiif/IeJEb5NGtY7thpvjcth8DXF9HyhWNzuvjplXxVy4njiA7Sr7EH0eIBu5c6RbhtE3GFp+Lukid5IdbwSV1CGl9LMwHixZEnQyQdM7T25vS5n/cN4h9A4DsdpzJFcvcVJ07OhqPhp2MwMaH2H8SSqzC2cI67fH1Ce+vUR8wql7XY7qyAGJePQgi9eyrFbzDGwCPLIlgWLHLGddHtAEIQ7ydPxmnmKOyxF61YsViM/vhNpIixcdSFBZ3p1OSQNZ5zrmD6StegUJgr7m/F70KDoRMxOKA9h//xRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnYx3bkfH57vYGto/QIC/BO+o+evdB6Iiobd9uBnTPo=;
 b=b6BJoE6rSbexNcrv/2t4sR6hMLxO/S5ndSb6DxOVh4y/CNVN47usAySyv58jzJqlnWubAea6JPUNSt5L5UHoHY7ar5VfexX9pZiLPO7XPulIj3fJ4LiKsi5vZt8Kc5OP4AufxtTVzaeji/wvlizUnrQqumhc6B+EhTGY4tO1mTniFfVimloncdAXeOcN0OKqbBYWjChbk2iSW77VR+KsA5Iz/zzU45cyGZH02f5P9K9b50RG++aUlYIQIDtbJHaXlgDjg+ImByh0PtIoIGHT6ri7g6t8gUvVrPXfdDTYKrDIEV0lrqa2XOBpRcsElXKyds1Rft55T1ipilnocrUqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnYx3bkfH57vYGto/QIC/BO+o+evdB6Iiobd9uBnTPo=;
 b=vadiW8y7F69UgYxF7EnvHBL0YWXj+zUM/M7PhW9Mo2sV0Sg+o9Jxrj2OX7FW4+yc8Kp8M3u9o7VSQnyv3YwzCSeNCvki//YZMdNxHpZkEHxay1DN7e4iCisXboPhiqnbYu0R9UXK+tt/+g/5wwk1YiReRg8YKQQvgCQQHzseAGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 13:56:49 +0000
Received: from SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca]) by SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca%3]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 13:56:48 +0000
Message-ID: <1eedec63-9a62-49c6-8f0f-8e03a96ae67c@amd.com>
Date: Thu, 31 Oct 2024 08:56:05 -0500
User-Agent: Mozilla Thunderbird
Reply-To: michael.day@amd.com
Subject: Re: [RFC PATCH v3 2/6] kvm: gmem: add flag to remove memory from
 kernel direct map
To: Patrick Roy <roypat@amazon.co.uk>, tabba@google.com,
 quic_eberman@quicinc.com, david@redhat.com, seanjc@google.com,
 pbonzini@redhat.com, jthoughton@google.com, ackerleytng@google.com,
 vannapurve@google.com, rppt@kernel.org
Cc: graf@amazon.com, jgowans@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, xmarcalx@amazon.com, linux-mm@kvack.org,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <20241030134912.515725-3-roypat@amazon.co.uk>
From: Mike Day <michael.day@amd.com>
Content-Language: en-US
In-Reply-To: <20241030134912.515725-3-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:805:66::46) To SA1PR12MB5672.namprd12.prod.outlook.com
 (2603:10b6:806:23c::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5672:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b81874c-57ca-4a6a-6d0c-08dcf9b3dd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1E3Y0R3ZlNsR3I2QTVMcUI5WFpidnZjZHdtRmZlam9ubmJML1BBNElyWkdq?=
 =?utf-8?B?cElnaUoyUFFTaEY0dmd5R3BxZVl0VDZ2SVUwcjVkd0NmRk4vRXNlaGI1dWFJ?=
 =?utf-8?B?cmpTa0EwYzlvYUJtdTZ2aXQ0TWlmdStWOVYzaElqTWNsWnloQndoNk5DU0Vr?=
 =?utf-8?B?ZzZma1AzTTI0K0REaklDQ0c4cHo5bHJaM1F1VDVxSlRIZTJmSXAyRUZaVnNC?=
 =?utf-8?B?NzZvd2NOK0NRVjVmMFhvbk1zWGlVR3o3WjRhbkNzOE5NbWp6aGF1dWFXVVVJ?=
 =?utf-8?B?eFIzOVY5bkxXL1djVUtib2xRZ1ZkVkNCOU5tSk92N3BvUjZLVkM3WGFhNHYx?=
 =?utf-8?B?dTBuOGs3Z2Vncjhvek9LR2JBQzAwaTZLS2phZG5UeFQ4cmNZNW5CY3lacUFY?=
 =?utf-8?B?bU5oVysxdnBLazdpajBRWmJYUnJSRVFuS0M2RHcrN1RjQ3dRSnVSTFdQc0Zx?=
 =?utf-8?B?L2phNE9IbEIwTzNiMksxZXpUMHdBMUlZT3A4VmRKYStaV0hqUFl2MjJJanFz?=
 =?utf-8?B?c2o4ZGJtVTlncndSSDBWNmxyMTVzVVc0cnRuWW16K2ZTSk9td09LQkxkTE1S?=
 =?utf-8?B?eUJFcEM5dVBwN1EwUWhZSnZDVlppWitTZ1k5YStFOGVzNndqUWFFUTAzMGxo?=
 =?utf-8?B?NEVkN21uQ3F4QjFEUThGTU04Wmk3NnZKVXRpbDZUWDdpRitqdml3SWJkZFVa?=
 =?utf-8?B?L2J6YWhkR3pkRVVJcG5PVStZRC9zVnRCM1BsS0JKV0tLamxDWkd6aGdSVU9J?=
 =?utf-8?B?OGZNRnZnbEM3TmplbDVlWlVYb1UwOHNnS3BHWUM3dUNuUnBTdk5VSmRJRzY5?=
 =?utf-8?B?eDBacGRac3B1SUhTdi85N00wQ25oMkRydmt3Q3VBS1JJNmYveFhnZDRBNjE4?=
 =?utf-8?B?dGpua0pYQTdva285WWx2UDJqa3JneWtlRFB6ZTRIbVhIYkdCQUlWUHJpcUNM?=
 =?utf-8?B?NUVkY0ZWNjhXVUVhcEh2NUdZdjU2ZUR3RWZhaUlkMTluVlloeUFVdWFqNkJ0?=
 =?utf-8?B?eTNwVHMvWWEwZFlMQXovMHdWTU04QVI4M1lyNHNvZUE1MjQ2a0MrallBZGM1?=
 =?utf-8?B?UjJZMEN4ai9SdjlDVmhZRm9iVmxTZkhRQVVPVnZhcG9CZHVjTHZIa1pZS3hX?=
 =?utf-8?B?SmJLWTFSSVRHek9pSzZ3ZHpmbHhLMnZCSlEyOThrKzVFaGVHTFcxVkU5SGUr?=
 =?utf-8?B?UnB6SU83ajREbmpoRFkxbFI3WEtPdld3V3JWamNDUnc3QjdCblRWRUZFbTFm?=
 =?utf-8?B?TnRiOGNJOVVyTTJYUFA0OCtKazAyQWNRbi9qWUJYV0tWQTJ3MVdBYlVLbkNH?=
 =?utf-8?B?ZHh6YXZiakhDS2UwSTdVa2dXYlRUSnVaZm4ydlJsZUZBblR3Z3NnU0NhL0Vi?=
 =?utf-8?B?bVVpWm4yQzNFN0hiYjdESHFzV2o4UlVVeFl0VHFxaHZvcDFTc212TXJsZlVX?=
 =?utf-8?B?ZFBzSjN3WTBBNWxyTHVuNmpEY2t0QWN6cjVwTWdRNkV1Umc2OVQxd2hNdTQw?=
 =?utf-8?B?Wmo1Szh6dVdXaXlXNmtYaXRMQlhkZ0tlUEZ0KzdJNUtBUVdzRXVkaVZQSlBz?=
 =?utf-8?B?dzc4T0k5TnUvMVEzTTNmaGpBR1NCamhuTlZHN2grQUJLaHJNemNXdXdEMks2?=
 =?utf-8?B?cmozWktETnRXUUNwejZ3TlM4d3ZVZUZwSVhOL1VKUE55NENsNzFCTEZiUVov?=
 =?utf-8?B?T0ZNNnNQOERRTWt3cHc2NEVmSUdRRlk3Nms0N1F4VHJaV3hLTkFuNVZob0dM?=
 =?utf-8?B?TFZqektJbVhCNkM0SGU4bnhPR0JOL3BNa2xodG1QYkNrSUFxbmc1bWVVVllw?=
 =?utf-8?Q?i548otp9PE8qqwc4vKLUH51lW/T4YL+Z/IZcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5672.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVgzWWVYQmFQNHVHb0JuZ25wWlJMSE9OSW1SbGVwdmw0WXVYaFNLZVhvL2dR?=
 =?utf-8?B?TXQzWGtzUTFRUkJBZkVIK01GL0YxekRJVHpsQWlWcUZsSlZqanRHM00zMzVw?=
 =?utf-8?B?TU4wT2trb0ozMG1tOHVEbDdxcUhST29Oak96SlJlcGNDY2ttMTVkSmJGU0dW?=
 =?utf-8?B?VFhSTndrY1FGOEYvY0tLLzlIUmc5R0pnaTk3SEs3OXdqd2J2V25UakJraG9m?=
 =?utf-8?B?M2ZPVEYzUmNiVFQ0dlB6OG44RjQ0U2MyZjF2RFBRMmZIY1dCcGZ0Wkhna0h5?=
 =?utf-8?B?TVY1d1NnQ0tuWTRQMmEydlg5Rjc2QUE3MEpUTHFlWGZ1WXZvKzl5Ymk5SHd2?=
 =?utf-8?B?R2lTUi9UaHd0S0JObi85dUpNUXhnZTdmRmZoV29SZ0prZEhrQ0RWWWxRb0dv?=
 =?utf-8?B?SVBxeXp3emI3SGJ2MDEwR3NnRVRqNTByMXU0KzEwd011OTVLRzlVbEJQbVFW?=
 =?utf-8?B?dE5MSjlsVjNxbHhtT2dtQklycmVJU21sNFVlL05uV2t0VysrdHZlM0g4Z0lj?=
 =?utf-8?B?cm5IWXVPMFVBZkozNVBTOWZTdVl5SlRrbStYZTgzR1lLYjFna1gyeE1mSlF4?=
 =?utf-8?B?UTF0Qm5jNTFDcGRBQks1UmxaMG5veEFZWFc3Zk9Gb3VyNXRidmtkRnl0LzMx?=
 =?utf-8?B?UWQ1bk9GNEZTWWljcjVvSkNHOFByN3MxTkQyZHVYdWJGWFpReVNsNVp6QjN4?=
 =?utf-8?B?Ums3MjRXLzNqWjJydFNJek9PRUdRdWxHYUpJWDJGT3lXVml6ellIR1BmWG5T?=
 =?utf-8?B?ODMzRFVubkpmelhzckhwMDZHY1VvR0hhTGJkV2tkWit3WW85dG9HZ2hrcFh2?=
 =?utf-8?B?aURieUZ4UnBLdk9relNjU2ZmUk1lbnB2bVBFbjk5OEY4d0NMMldNWTVuOHdR?=
 =?utf-8?B?M2xITVBCM3VzMmZ5MlBFb1A0Q1YvZ2s3SlVPdkUwZEJDTnlSNWRaQWFhQkJH?=
 =?utf-8?B?SlE3R2hMa0pORlBjZkFaUzdXU3BRYVZTeWRxTUdCajR5bUUrVlJXVkMyb0JE?=
 =?utf-8?B?YURBUWFzNEMwN1NMQlFweENPNVNOOXk3bWVGRyt1TlRWU2VSRHB5UCtKenJn?=
 =?utf-8?B?L1VwVTlsbTU3Mm04REp4ZEM3UE5tck8vNHQxNG9QaXRQeTRlRWtPbUFpem8z?=
 =?utf-8?B?bzljcWVHWnNhQzlaSFdLSUhVY1pJMmh4ZVZxVEx3eUdWSGZlMmFENlQ2VDUy?=
 =?utf-8?B?Z1dpOEhlWDRCZDdvRU5HQy9XeVd6QzAvRWQwZGhvVXhjUEVqdGFkaExKNHFV?=
 =?utf-8?B?RUNiTEtDcnVSSGJBem1uUVZyQzN3ZkZSdGwzWVdxY0I3VFNoMGJPVVp0TUsv?=
 =?utf-8?B?VWcrR1orNmhqSzBWcmRJM3ZJczlMTjUwQnhvUUpFR3dmQXNWSVQ5aFV4T3I3?=
 =?utf-8?B?MlU0YXZOUC9SVnZoYWMrMzFKeENWQnlmNVAwYTBvZ2dzT1Z6V2R3UjE1VlFX?=
 =?utf-8?B?dGZPQkhKSUkxSnhta0t5QS8ybEg0UmJxYU1rVnk5cS9NcHBnOEdhTXg5RHZJ?=
 =?utf-8?B?c2Q0RE1HU3dQV3NnTzJJV0xzSkRiS2xGdmMrYUk1WGY4SWRkc2JvMUdGU3JW?=
 =?utf-8?B?dmtCRHJBMXUyWS95dDVYNmxKQzhnYWVSeks0b1J4eks3QiszN2ViWWd2aERl?=
 =?utf-8?B?U0ZIMCsyQjJFa3pZYUFpK1JsdXlYaERhMDg2V2pRbW8rMGZDOFA4SUpOZ0xm?=
 =?utf-8?B?ZkJKZktnNE1ZMzVMZWNQdTc2NVVYT2ZNTGIvR040R0pORi9YTHJ5eEZna3E1?=
 =?utf-8?B?dGx0QzdwcDZzeG5pcXlHUXJ1K0JwLzY4K3lXRWNGTkdmNkpnNTVkNjAyajZK?=
 =?utf-8?B?VWdvSFovL0JuRG9FWlBYczNQTFBYLzdkOWI1WlFxU21zR3NqcWdmVDFrSlZL?=
 =?utf-8?B?NURoKzZRV2xUbkM1OG41Tlg1MmtnNUV3b3FYVjJ4bHd1N2xQaU43ck10UFJM?=
 =?utf-8?B?Y2UrdUNKZ3c5bDlnaHRXSi9KTzg1RmZvZTF5QUFXa0NOTmNxVWlRckNoT0sr?=
 =?utf-8?B?cnd0UTFrcEhDa3lndEFYYW1Uem1ObjdrN0F0cndQdnRTa2kyZTNLR1Vwd1FQ?=
 =?utf-8?B?ZHFwZW16OS9aeUw1MDVQdkxZNUZnYkwrWjBxMlZtelVKNHNEOFNaTTdHSGdw?=
 =?utf-8?Q?TvD6n6wj6crJ3+dzivOqNrNuk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b81874c-57ca-4a6a-6d0c-08dcf9b3dd48
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:56:48.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLuMTvzl8Sx+H8UxE42alsLs0ZV07MW3ByAMK7AuUJbTbEtRiWOxoB2PukFTdnfCzCXSoyLzgDcN440PA5t9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837



On 10/30/24 08:49, Patrick Roy wrote:
> Add a new flag, KVM_GMEM_NO_DIRECT_MAP, to KVM_CREATE_GUEST_MEMFD, which
> causes KVM to remove the folios backing this guest_memfd from the direct
> map after preparation/population. This flag is only exposed on
> architectures that can set the direct map (the notable exception here
> being ARM64 if the direct map is not set up at 4K granularity),
> otherwise EOPNOTSUPP is returned.
> 
> This patch also implements infrastructure for tracking (temporary)
> reinsertation of memory ranges into the direct map (more accurately: It
> allows recording that specific memory ranges deviate from the default
> direct map setup. Currently the default setup is always "direct map
> entries removed", but it is trivial to extend this with some
> "default_state_for_vm_type" mechanism to cover the pKVM usecase of
> memory starting off with directe map entries present). An xarray
> tracks this at page granularity, to be compatible with future
> hugepages usecases that might require subranges of hugetlb folios to
> have direct map entries restored. This xarray holds entries for each
> page that has a direct map state deviating from the default, and holes
> for all pages whose direct map state matches the default, the idea being
> that these "deviations" will be rare.
> kvm_gmem_folio_configure_direct_map applies the configuration stored in
> the xarray to a given folio, and is called for each new gmem folio after
> preparation/population.
> 
> Storing direct map state in the gmem inode has two advantages:
> 1) We can track direct map state at page granularity even for huge
>     folios (see also Ackerley's series on hugetlbfs support in
>     guest_memfd [1])
> 2) We can pre-configure the direct map state of not-yet-faulted in
>     folios. This would for example be needed if a VMM is receiving a
>     virtio buffer that the guest is requested it to fill. In this case,
>     the pages backing the guest physical address range of the buffer
>     might not be faulted in yet, and thus would be faulted when the VMM
>     tries to write to them, and at this point we would need to ensure
>     direct map entries are present)
> 
> Note that this patch does not include operations for manipulating the
> direct map state xarray, or for changing direct map state of already
> existing folios. These routines are sketched out in the following patch,
> although are not needed in this initial patch series.
> 
> When a gmem folio is freed, it is reinserted into the direct map (and
> failing this, marked as HWPOISON to avoid any other part of the kernel
> accidentally touching folios without complete direct map entries). The
> direct map configuration stored in the xarray is _not_ reset when the
> folio is freed (although this could be implemented by storing the
> reference to the xarray in the folio's private data instead of only the
> inode).
> 
> [1]: https://lore.kernel.org/kvm/cover.1726009989.git.ackerleytng@google.com/
> 
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>   include/uapi/linux/kvm.h |   2 +
>   virt/kvm/guest_memfd.c   | 150 +++++++++++++++++++++++++++++++++++----
>   2 files changed, 137 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 637efc0551453..81b0f4a236b8c 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1564,6 +1564,8 @@ struct kvm_create_guest_memfd {
>   	__u64 reserved[6];
>   };
>   
> +#define KVM_GMEM_NO_DIRECT_MAP			(1ULL << 0)
> +
>   #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
>   
>   struct kvm_pre_fault_memory {
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 47a9f68f7b247..50ffc2ad73eda 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>   #include <linux/kvm_host.h>
>   #include <linux/pagemap.h>
>   #include <linux/anon_inodes.h>
> +#include <linux/set_memory.h>
>   
>   #include "kvm_mm.h"
>   
> @@ -13,6 +14,88 @@ struct kvm_gmem {
>   	struct list_head entry;
>   };
>   
> +struct kvm_gmem_inode_private {
> +	unsigned long long flags;
> +
> +	/*
> +	 * direct map configuration of the gmem instance this private data
> +	 * is associated with. present indices indicate a desired direct map
> +	 * configuration deviating from default_direct_map_state (e.g. if
> +	 * default_direct_map_state is false/not present, then the xarray
> +	 * contains all indices for which direct map entries are restored).
> +	 */
> +	struct xarray direct_map_state;
> +	bool default_direct_map_state;
> +};
> +
> +static bool kvm_gmem_test_no_direct_map(struct kvm_gmem_inode_private *gmem_priv)
> +{
> +	return ((unsigned long)gmem_priv->flags & KVM_GMEM_NO_DIRECT_MAP) != 0;
> +}
> +
> +/*
> + * Configure the direct map present/not present state of @folio based on
> + * the xarray stored in the associated inode's private data.
> + *
> + * Assumes the folio lock is held.
> + */
> +static int kvm_gmem_folio_configure_direct_map(struct folio *folio)
> +{
> +	struct inode *inode = folio_inode(folio);
> +	struct kvm_gmem_inode_private *gmem_priv = inode->i_private;
> +	bool default_state = gmem_priv->default_direct_map_state;
> +
> +	pgoff_t start = folio_index(folio);
> +	pgoff_t last = start + folio_nr_pages(folio) - 1;

	pgoff_t last = folio_next_index(folio) - 1;

thanks,
Mike

> +
> +	struct xarray *xa = &gmem_priv->direct_map_state;
> +	unsigned long index;
> +	void *entry;
> +
> +	pgoff_t range_start = start;
> +	unsigned long npages = 1;
> +	int r = 0;
> +
> +	if (!kvm_gmem_test_no_direct_map(gmem_priv))
> +		goto out;
> +
> +	r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
> +					 default_state);
> +	if (r)
> +		goto out;
> +
> +	if (!xa_find_after(xa, &range_start, last, XA_PRESENT))
> +		goto out_flush;
> +
> +	xa_for_each_range(xa, index, entry, range_start, last) {
> +		++npages;
> +
> +		if (index == range_start + npages)
> +			continue;
> +
> +		r = set_direct_map_valid_noflush(folio_file_page(folio, range_start), npages - 1,
> +						 !default_state);
> +		if (r)
> +			goto out_flush;
> +
> +		range_start = index;
> +		npages = 1;
> +	}
> +
> +	r = set_direct_map_valid_noflush(folio_file_page(folio, range_start), npages,
> +					 !default_state);
> +
> +out_flush:
> +	/*
> +	 * Use PG_private to track that this folio has had potentially some of
> +	 * its direct map entries modified, so that we can restore them in free_folio.
> +	 */
> +	folio_set_private(folio);
> +	flush_tlb_kernel_range(start, start + folio_size(folio));
> +out:
> +	return r;
> +}
> +
>   /**
>    * folio_file_pfn - like folio_file_page, but return a pfn.
>    * @folio: The folio which contains this index.
> @@ -42,9 +125,19 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>   	return 0;
>   }
>   
> -static inline void kvm_gmem_mark_prepared(struct folio *folio)
> +
> +static inline int kvm_gmem_finalize_folio(struct folio *folio)
>   {
> +	int r = kvm_gmem_folio_configure_direct_map(folio);
> +
> +	/*
> +	 * Parts of the direct map might have been punched out, mark this folio
> +	 * as prepared even in the error case to avoid touching parts without
> +	 * direct map entries in a potential re-preparation.
> +	 */
>   	folio_mark_uptodate(folio);
> +
> +	return r;
>   }
>   
>   /*
> @@ -82,11 +175,10 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>   	index = ALIGN_DOWN(index, 1 << folio_order(folio));
>   	r = __kvm_gmem_prepare_folio(kvm, slot, index, folio);
>   	if (!r)
> -		kvm_gmem_mark_prepared(folio);
> +		r = kvm_gmem_finalize_folio(folio);
>   
>   	return r;
>   }
> -
>   /*
>    * Returns a locked folio on success.  The caller is responsible for
>    * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -249,6 +341,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>   static int kvm_gmem_release(struct inode *inode, struct file *file)
>   {
>   	struct kvm_gmem *gmem = file->private_data;
> +	struct kvm_gmem_inode_private *gmem_priv;
>   	struct kvm_memory_slot *slot;
>   	struct kvm *kvm = gmem->kvm;
>   	unsigned long index;
> @@ -279,13 +372,17 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>   
>   	list_del(&gmem->entry);
>   
> +	gmem_priv = inode->i_private;
> +
>   	filemap_invalidate_unlock(inode->i_mapping);
>   
>   	mutex_unlock(&kvm->slots_lock);
> -
>   	xa_destroy(&gmem->bindings);
>   	kfree(gmem);
>   
> +	xa_destroy(&gmem_priv->direct_map_state);
> +	kfree(gmem_priv);
> +
>   	kvm_put_kvm(kvm);
>   
>   	return 0;
> @@ -357,24 +454,37 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>   	return MF_DELAYED;
>   }
>   
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>   static void kvm_gmem_free_folio(struct folio *folio)
>   {
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>   	struct page *page = folio_page(folio, 0);
>   	kvm_pfn_t pfn = page_to_pfn(page);
>   	int order = folio_order(folio);
>   
>   	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> -}
>   #endif
>   
> +	if (folio_test_private(folio)) {
> +		unsigned long start = (unsigned long)folio_address(folio);
> +
> +		int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
> +						     true);
> +		/*
> +		 * There might be holes left in the folio, better make sure
> +		 * nothing tries to touch it again.
> +		 */
> +		if (r)
> +			folio_set_hwpoison(folio);
> +
> +		flush_tlb_kernel_range(start, start + folio_size(folio));
> +	}
> +}
> +
>   static const struct address_space_operations kvm_gmem_aops = {
>   	.dirty_folio = noop_dirty_folio,
>   	.migrate_folio	= kvm_gmem_migrate_folio,
>   	.error_remove_folio = kvm_gmem_error_folio,
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>   	.free_folio = kvm_gmem_free_folio,
> -#endif
>   };
>   
>   static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
> @@ -401,6 +511,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>   {
>   	const char *anon_name = "[kvm-gmem]";
>   	struct kvm_gmem *gmem;
> +	struct kvm_gmem_inode_private *gmem_priv;
>   	struct inode *inode;
>   	struct file *file;
>   	int fd, err;
> @@ -409,11 +520,14 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>   	if (fd < 0)
>   		return fd;
>   
> +	err = -ENOMEM;
>   	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
> -	if (!gmem) {
> -		err = -ENOMEM;
> +	if (!gmem)
> +		goto err_fd;
> +
> +	gmem_priv = kzalloc(sizeof(*gmem_priv), GFP_KERNEL);
> +	if (!gmem_priv)
>   		goto err_fd;
> -	}
>   
>   	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
>   					 O_RDWR, NULL);
> @@ -427,7 +541,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>   	inode = file->f_inode;
>   	WARN_ON(file->f_mapping != inode->i_mapping);
>   
> -	inode->i_private = (void *)(unsigned long)flags;
> +	inode->i_private = gmem_priv;
>   	inode->i_op = &kvm_gmem_iops;
>   	inode->i_mapping->a_ops = &kvm_gmem_aops;
>   	inode->i_mode |= S_IFREG;
> @@ -442,6 +556,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>   	xa_init(&gmem->bindings);
>   	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
>   
> +	xa_init(&gmem_priv->direct_map_state);
> +	gmem_priv->flags = flags;
> +
>   	fd_install(fd, file);
>   	return fd;
>   
> @@ -456,11 +573,14 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>   {
>   	loff_t size = args->size;
>   	u64 flags = args->flags;
> -	u64 valid_flags = 0;
> +	u64 valid_flags = KVM_GMEM_NO_DIRECT_MAP;
>   
>   	if (flags & ~valid_flags)
>   		return -EINVAL;
>   
> +	if ((flags & KVM_GMEM_NO_DIRECT_MAP) && !can_set_direct_map())
> +		return -EOPNOTSUPP;
> +
>   	if (size <= 0 || !PAGE_ALIGNED(size))
>   		return -EINVAL;
>   
> @@ -679,7 +799,6 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
>   			break;
>   		}
>   
> -		folio_unlock(folio);
>   		WARN_ON(!IS_ALIGNED(gfn, 1 << max_order) ||
>   			(npages - i) < (1 << max_order));
>   
> @@ -695,7 +814,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
>   		p = src ? src + i * PAGE_SIZE : NULL;
>   		ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
>   		if (!ret)
> -			kvm_gmem_mark_prepared(folio);
> +			ret = kvm_gmem_finalize_folio(folio);
> +		folio_unlock(folio);
>   
>   put_folio_and_exit:
>   		folio_put(folio);

