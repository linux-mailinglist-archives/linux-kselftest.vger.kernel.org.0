Return-Path: <linux-kselftest+bounces-33322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D91ABBCE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4C1659FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098F20FAAB;
	Mon, 19 May 2025 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3L6zwXiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDD1C700D;
	Mon, 19 May 2025 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655135; cv=fail; b=hi34PaVeKpWiRzM0JcWMezzQFVUwsUFDSUA9umNdoC3SbgPG2vbmamozE5/+bnFq3St/oVWu8FkZ3qOF+E11R+a3Pm7K1oEcSgGyhDNU8Dad2Io4V5xXuKJwq8AX3IyJPYw5YMfcHizh/cgHrG7nmlmwC5uFRCL81tECp00t/Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655135; c=relaxed/simple;
	bh=a2GAXJTWteEJGYHMvWN2ZUmPwVYCBFXlPgt/sLBEecU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z++HOrDtlkfwzSgD9xhGYhynpeQZg4CP9nje43jiz1hlIKv2LXqwg4VPF2bxrGfAy2GTp/KnWfZ8N2K4j41ZBD8SDaf2g0i8ulDghsUrd75yDs2aPfpFxJKE0098pYuhWMhkPXM7RQKjsHbnakdO38GpWp1+0+6hvCtnaUnLVHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3L6zwXiN; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id1ryFkFdc+HHUzA8C/zwShgQncj6nKW0czGxE8eh0eQtUbDV1y5414TAx5XcaHoxS1GGtYVgmuxViVs2h4cZKgLr8qG8Imw9b24U9vVywhlErbPUEl3md2z8kE61LE35xNPit9I4yn2TAI4M6TQbzuSEDr4FvDSPffBm3Rf1QVKVjyzfitXwuj+rrS4lDWsPp9VuAddC2OQ7uF0uuMCdgW3cw3ekVpjWzyW5Osegbd2AegAYVYmLOHMNwaDhR9nLzYC7zrr0Ek2vCi31j/bL6pftqPe2FcS8vGEfd8hhsHCWqY4KSKnQ8U346T9Dfx2q89HX3OusndsYIrNGlOYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Db8k5oQapz7gSsrZVxFU3+caJylwGvG1VvO/gFpmo=;
 b=GQtbCZ9m/GTyACh38tCI8QM6MA+I9eYjdyVNfpvwMUs1Ml1T33yH6XuFWzMpuRD7p3SfgpszsRy4hjDp+IcKul03W9W9Tzvnm+QzEUdAFkIFiMp9jq5FzHR6+iT/FXkMEB4ySbGpuTBsbbKeTGVxSex3T6A9OpELOsjXTaOt9Y+mSkFA4lD67WutmrZSxL2xE+V9YRnshllyQ7UAqHH4RXRDjHaUvDIWnWWZwBB2eg16JV/56M6WLTv+55AB8IdUB8qg7CtiiIfkumC2W/8cIX0laSrYXQFYxkE13sNaUTHVHIjK1H8WnG6HTTeqMT+QkzNweiTt9/rB0nXsbhM0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Db8k5oQapz7gSsrZVxFU3+caJylwGvG1VvO/gFpmo=;
 b=3L6zwXiNAquvdkZJ5JzhSgVjyKx1CYeOh1c9kzp9OXInzpaM5zDCBbtoVBZ/eW9eXCmi/qfPc08MMzXrRwRleHuXancufiBrvQPS1DzOedSn7B3QADI0zPI+HbreulzLA3EexG4sE0NplqCAPCQ0oS50gvKXnl1/0A1UPd0+ETM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Mon, 19 May 2025 11:45:30 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 11:45:30 +0000
Message-ID: <e77951e3-8606-4935-a05f-88b092d5771d@amd.com>
Date: Mon, 19 May 2025 17:15:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] KVM: selftests: Add bus lock exit test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, nikunj@amd.com, bp@alien8.de
References: <20250502050346.14274-1-manali.shukla@amd.com>
 <20250502050346.14274-6-manali.shukla@amd.com> <aCeR2TjPzC_OYBfG@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <aCeR2TjPzC_OYBfG@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::16) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 266377fc-a00e-44fb-08ae-08dd96caa7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWZqM2RNWGhpd2JDd01UTjdTUmFnQ1YxK3o5Q0hKRUdKK1hZRDh4cFpnQWh3?=
 =?utf-8?B?T3h5VU1jelQzZjBSREE3WXVlbktvb3lobzR4VmwzUlp4VHNCb0x3V3M0QVVZ?=
 =?utf-8?B?U3FXWVJiUDdHWWtCaFZpUERYNFFrSTlndnFRdWxBVjJJSk53eFc5eHlabTRQ?=
 =?utf-8?B?VzRWRkFDK3kxUC9iTWRqRHI3MmgzZDhSenNQdXc5U2ZoWlRHYkJUZDhNUEhh?=
 =?utf-8?B?LzJCVnA1WE95OXk3aFJ2K2pXcUgxSzNZRzJoc04zMUIrMWQrY0VLZ3I0TGZ5?=
 =?utf-8?B?UzZpTnFCK09BbU5QajJsdDhmQkpDdWtDWHd0OUh3ZlRNVVpCMVZLbWxWSzBz?=
 =?utf-8?B?TS9rNk9wdkRmclR2a29IbzA0U2tiTmQyWmpKRjZXYXhCdGI2SGJHNkdrYlY2?=
 =?utf-8?B?alZKTFBZWGRmeXZocmhYY0pESmdvU1VsVUtleHpjZ1NxdjZTMFAvYnVQRStt?=
 =?utf-8?B?SGdiY2psWWFZZDhLNk1sYWRQRnRsYzFEeUs0T1llNEZmcmp0OVdodTN2Z1hi?=
 =?utf-8?B?dUdqOWRmbXBaMFk4NnNwa1pmcHB3dEN0Mmozais5UVp1dnVmK0FRUnprYjdm?=
 =?utf-8?B?ckV5bGd5ZGFtcmwreUNiNTYvQXdyWTJwQ3dUdmxheVM3V1Y5U1NWTGdTdFZC?=
 =?utf-8?B?a1ZEY0lSYTd1MWg1N3Uybk5UbXhycFNDSUM2M3ovZTlITXczWGUxbzJQcWtL?=
 =?utf-8?B?TGczSU1xdGVTSTd2Rk9aZitJRS9xZlFaeFhkVXZKdDA1cURUb2hDcmN5c1Fl?=
 =?utf-8?B?S09ualg1akQvR05oc1JPUjlRd3QyVm0yTTB6REQ1WFh5Z3BOanJpN0Z4cUxw?=
 =?utf-8?B?c29mRFNWaE5BbmxvZVNSRXI3UHZiSmZJMkhhSHJUVG5NSU9yQlgxdWI3b3Nz?=
 =?utf-8?B?cklXWEkwVWJWL0ZHRUVnMjFUUmlWM0U4d251NFZGQTZhVEQyRlBLR0V0bHNR?=
 =?utf-8?B?T1czZ2drTkhjQllsVytGeW5MNnM1dHpzUW5uWkc3aVl5L3hWQ0NpL3crOGpO?=
 =?utf-8?B?K0lRNHZndU9mWUY5NCtsNUFpVVNqVmZMbXdsWW9Ea1h3QXIzQ1llT0pSRDlN?=
 =?utf-8?B?TWYwdE9xVTdmVWhyTjJGZXRpNytlTUVkZExWSXZFUERHQ1BiR0JmTTg5bGxU?=
 =?utf-8?B?OEhHTTdOTzNEdHZ1SmpUd3RyZzVWYktUdVFtbXV3eUZ6RDVFekVtaDVOQndq?=
 =?utf-8?B?WGVyMEd1YUpyWThCdm00YnN5UGV1Y1c0dkZFWTFPOTVqQk5GTzE2Wkl6bXFm?=
 =?utf-8?B?OFE2VVdycC9HUE5kMkhMaDRUUDYyVzV5b2x4bVU5WExIV0lKVUdueDVMWTd1?=
 =?utf-8?B?bk1ZY1N3OHdXdDA4N0szV3g1bEovTHM5WFZNeGxGMTVodXNBbmdnYWxVTjRx?=
 =?utf-8?B?UnRsTm5WSkVhV3NmVjc4a0dUSmpmcnU5a2lSREVlNW0wRWo5dzlMYmxvTW9j?=
 =?utf-8?B?MmFVTEpyaktPekkyRlBxZEFBWGZIWEZvNDJvSnI1K3ppeHRBUGd4bmFteFBE?=
 =?utf-8?B?Q3kvRVJoZ2pZVmxwZi92V0JoK25hVTlWL2doMjRMSGg5RFBjakFuNHJMaWFY?=
 =?utf-8?B?Z093V3RxYXNwWlF4UytSc0tIeVNSLy95YTRpSllPVUx3N1piQzl1NS9XWXB6?=
 =?utf-8?B?Tms0UzZmUEt2TWgzYi9DOVFlU1BIcGdMdEo3Q0ltMmE5V3c5bXJmM2svZ21m?=
 =?utf-8?B?R2p0VDFtYi9Qd3VzdWc0a2Z2WnlYY3JKd3pzNmF3NDVkVFRqSXFWdStGYjBr?=
 =?utf-8?B?WllxYXdaN2U1b1l1VE1XVDZCaUdxMjFuc1o1SFNlR2JIa1dxRkd0eVNIbTFs?=
 =?utf-8?B?VG15TFZ6QWVDQWRkNUpZdWs3MjdEVTBSb3pqNysreXdNRDU1MzlkUGh6bmt4?=
 =?utf-8?B?N1dKaG1ydFFIdDhHdHBoUlhUTU9McGgxVm01ZEViMlJrL0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1VscFVsYll0eStyQUhiUnZTVloveHU3UEdXQ0xpdmVWdWxBWnBpQ1RoR2NM?=
 =?utf-8?B?MEFpME9QT2YvRVE0TXRJbzAzSDdCZFR3VnVVRWIraVNiTVFPRm1lN3JrSVNV?=
 =?utf-8?B?UDRzNGZ2NldaNGZWMXlZVkkwMHpWMnhyVnRWZkU0RU1mSHJQbDQ2d3RnbElv?=
 =?utf-8?B?bUdhV0RiMTdxSFFranRhdWxjUmtwRlB4T0FpZlVWYTVGeXM1NW4yZ3ZWK1c0?=
 =?utf-8?B?YWF4MmtaRUtWSGMrTUhwSHZsamRJUUsyY1kvOGN0SmR3Y2MyUHZUcGFlSU9E?=
 =?utf-8?B?MitiZnhvVHpwd0Uxb2VjcUpkRjVNZjRHQlNEMW1nOVR3a0ZHemQxalczeU5I?=
 =?utf-8?B?OTdVNXZROUtmV1hvVldUdngvTVpsdVlFQ3RHZTJHeHVYN1BpVXl2NHY3djB5?=
 =?utf-8?B?U1RpOTVLdVZWSHZweUZhZEs1dmNyaGVOdUVKcW1VS0FLZjhBZklqYzBPUDdC?=
 =?utf-8?B?cXY0RFNNeVFMYlZqbmIvQmVnM1ZZMXgwWjVoMWV6TkRqL0g0WUhCTVY2ekN3?=
 =?utf-8?B?RzAxTEcyUmR1ZHM4bkNQWmlWOTlHS001WUFjWWFuWE1PbFRiaUJKSVdJcEp1?=
 =?utf-8?B?UW9ndWlzMUhicWhZK2h6dWkvZ0ZzdHdZcDhOdndrejNraHVoRGtJaktxZ3NG?=
 =?utf-8?B?TGNwcE9IaEFMbkxlWWFOeEwvKzVuM1RzK1lCejFzSmNOZG90TGJKb2JKOGZh?=
 =?utf-8?B?NkhqdWxYVDJlYk5ZYTh4dUpuUHpjY0JZZDhqcDdWeERXTG9RcWF4V3lWa1N1?=
 =?utf-8?B?bGZvbWRFSXg0UndVLzVKNzkzK1Y2Qmd4QjdmVHNmeGIza1ZnMXc4bjdtM3JQ?=
 =?utf-8?B?Slo1ZDlyTTFoOXNhT0Q1dkxmaG1PRy9Ca1hVVkpBdDV1SHFub1JXaEhLa1hG?=
 =?utf-8?B?S3k5VTBjK3EyNjFlN3Nld3VzNTI3WTVlYlFYSkpDZjFWWXRoSldxTWo2VUNq?=
 =?utf-8?B?eG9PbllmQi9iNVhSTHd0ZjN1c2hIVzNTN2EwY3VVUEJnUThlcTgzVFU4Z3Rz?=
 =?utf-8?B?cFpLVDh5YzZ3K25UWXA2TVRTYVVTQ0pDUk9raFBjYUZqNTJRY1A5bTNtOURj?=
 =?utf-8?B?NkxLY05nUGpHd0lvTHBaUUh4b2U0MHhnTnBERHBUT29mUjR4YVBKTStmQTV6?=
 =?utf-8?B?cUZnZXRrRm8wb1hsTnhIVFlrc3RSWWhiNWFtSHlVV2VXU01rT2tRMnVCaFFJ?=
 =?utf-8?B?RTNuRkR2VTBWL0I0NHFVaW4zejMzOEsyVDAzeTdhTlZUMjZmT0xNTTMyMC9G?=
 =?utf-8?B?dUFsYW9JOHR6emJHZWtHNjBwQ0VSM3NySlRKUHEyWTdjWC8xcnloTTNNTi9G?=
 =?utf-8?B?WTdtSnlTTVcrMEl4ZmdFdVovaUFwSHhVSSsrdWEvSG16bmFkMU9VMnhYYjRU?=
 =?utf-8?B?aVBDZXlIL3lOaWRpVitGeXkvYkVUaktwaGlPU3ArZkluaGliV2VHbHgxWkx5?=
 =?utf-8?B?TDRua2FuQlZIRGhqdThGRzJXQ1BtUHMwamtNRFZDZlRHK1pYOGlXL1FXQkhm?=
 =?utf-8?B?djNnNHA0YVNRTDMwYWF4VEpuZnFyeTFJQlVhVm9YODdhS2FOcDh4cDBleUJm?=
 =?utf-8?B?UXJKRnhRSFd6VlJKY2RNRUNEcHFScGZlYkRSTEM1T29qdU1xS0c4TE1pbklC?=
 =?utf-8?B?dW1vc1RDMWtGVGtweEdIZWxkT1JrMjU3R0ZqZ2ZVaHE1UVhmZTl5VzNvZ1R3?=
 =?utf-8?B?aUpvL1gwMDdNNlNnOVFrbVBuYUR0SlFkZFUzOUlHMCtkemU5Nks4MlU2OVR4?=
 =?utf-8?B?REdiV1k4SFUxbE9ZUUNLMkhrcUZnRnJ5em91cFp4RDkyNlV5NEQ3ZnpEaFZG?=
 =?utf-8?B?UHpiMTZZdnRDME0yLzZ3UVliL0ZIbjRCMzBCeUF6Z2t2QmpVOHVVeTk4aFMv?=
 =?utf-8?B?cHpSRzVpWjIxYVhaRnluaUk1OGdtSnEvWTUzVEdnYWNGVnVaR2FkZkt3ek1D?=
 =?utf-8?B?dGRxck1pbURPWEVPQXRYYm9RYTcvd1VSY2tiVWtpUkpraWRhRS9tYlJmbXJs?=
 =?utf-8?B?aWJIbHBXcGdIdW5yRS9saEJpN1o0M3UxVGdRS245U3o3VEtzZllHd2xtYnlI?=
 =?utf-8?B?ejNnWS9wb25DRmlIRkltbU43SVozK2ZKR2c3dm5CdGJWR3VYRXF5Qi9BZDNi?=
 =?utf-8?Q?wNN8yRI4U68Dlyvsahig81AIQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266377fc-a00e-44fb-08ae-08dd96caa7e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 11:45:30.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce7a7YV73QH26fNTrQtOmNUaQk6cicOzIKY+F7KGF09ExWAQI9/yZ76K26GiHc8dDS7wYxfw2WAaEQVb5Yj2Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

On 5/17/2025 12:58 AM, Sean Christopherson wrote:
> On Fri, May 02, 2025, Manali Shukla wrote:
>> diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
>> new file mode 100644
>> index 000000000000..9c081525ac2a
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
>> @@ -0,0 +1,135 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include "test_util.h"
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "svm_util.h"
>> +#include "vmx.h"
>> +
>> +#define NR_ITERATIONS 100
>> +#define L2_GUEST_STACK_SIZE 64
>> +
>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
> 
> Eww.
> 
>> +
>> +struct buslock_test {
>> +	unsigned char pad[PAGE_SIZE - 2];
>> +	atomic_long_t val;
>> +} __packed;
> 
> You don't need an entire page to generate a bus lock, two cache lines will do
> nicely.  And there's certain no need for __packed.
> 
>> +struct buslock_test test __aligned(PAGE_SIZE);
>> +
>> +static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
>> +{
>> +	asm volatile(LOCK_PREFIX "addl %1,%0"
>> +		     : "+m" (v->counter)
>> +		     : "ir" (i) : "memory");
>> +}
> 
> If only there were utilities for atomics...
> 
>> +static void buslock_add(void)
> 
> guest_generate_buslocks()
> 
>> +{
>> +	/*
>> +	 * Increment a page unaligned variable atomically.
>> +	 * This should generate a bus lock exit.
> 
> Not should, will.
> 
>> +	 */
>> +	for (int i = 0; i < NR_ITERATIONS; i++)
>> +		buslock_atomic_add(2, &test.val);
> 
> Don't do weird and completely arbitrary things like adding '2' instead of '1',
> it makes readers look for intent and purpose that doesn't exist.
> 

Got it. Thanks for the feedback.

>> +}
> 
> ...
> 
>> +int main(int argc, char *argv[])
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_run *run;
>> +	struct kvm_vm *vm;
>> +	vm_vaddr_t nested_test_data_gva;
>> +
>> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
> 
> There's no reason to make nested support a hard dependency, it's just as easy to
> make it conditional.
> 
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
>> +
>> +	vm = vm_create(1);
>> +	vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
>> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
>> +
>> +	if (kvm_cpu_has(X86_FEATURE_SVM))
>> +		vcpu_alloc_svm(vm, &nested_test_data_gva);
>> +	else
>> +		vcpu_alloc_vmx(vm, &nested_test_data_gva);
>> +
>> +	vcpu_args_set(vcpu, 1, nested_test_data_gva);
>> +
>> +	run = vcpu->run;
>> +
>> +	for (;;) {
>> +		struct ucall uc;
>> +
>> +		vcpu_run(vcpu);
>> +
>> +		if (run->exit_reason == KVM_EXIT_IO) {
>> +			switch (get_ucall(vcpu, &uc)) {
>> +			case UCALL_ABORT:
>> +				REPORT_GUEST_ASSERT(uc);
>> +				/* NOT REACHED */
>> +			case UCALL_SYNC:
>> +				continue;
>> +			case UCALL_DONE:
>> +				goto done;
>> +			default:
>> +				TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
>> +			}
>> +		}
>> +
>> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_BUS_LOCK);
>> +	}
> 
> *sigh*
> 
> This doesn't actually ****VERIFY**** that the expected number of bus lock exits
> were generated.  KVM could literally do nothing and the test will pass.  E.g. the
> test passes if I do this:
> 
> diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
> index 9c081525ac2a..aa65d6be0f13 100644
> --- a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
> +++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
> @@ -93,10 +93,10 @@ int main(int argc, char *argv[])
>         vm_vaddr_t nested_test_data_gva;
>  
>         TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
> -       TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
> +//     TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
>  
>         vm = vm_create(1);
> -       vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
> +//     vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
>         vcpu = vm_vcpu_add(vm, 0, guest_code);
>  
>         if (kvm_cpu_has(X86_FEATURE_SVM))
> --
> 
> The test would also fail to detect if KVM completely skipped the instruction.
> 
> This is not rocket science.  If you can't make your test fail by introducing bugs
> in what you're testing, then your test is worthless.
> 
> No need for a v6, I'm going to do surgery when I apply, this series has dragged
> on for far too long.

Understood. I agree the test should catch such failures — I’ll take that into account in future work.
Thanks for the review and for pushing this forward.

-Manali


