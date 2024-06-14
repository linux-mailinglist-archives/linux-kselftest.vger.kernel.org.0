Return-Path: <linux-kselftest+bounces-11974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8F909218
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 20:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EC3283EE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FE18130E;
	Fri, 14 Jun 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nHOzi5Oa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CCB646;
	Fri, 14 Jun 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718388197; cv=fail; b=DWY+UETOCBHHXH1nb6RF1UAUVLgb0ECaygKoYR/ub4zxN2gtoV73XpEEXSEJtakoRBwR0l5GHLYTbtnr3Va7GFyQWnUklhrYRzcTdtTIimMi1VLmaUx0Dsg/AFtaYfXxNIywgkHLpoCVWWSiqzjc4EAD6mvYYv3FB+glk06u47Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718388197; c=relaxed/simple;
	bh=kc/eNHbfgJwXplbrXRKRLmE2GBmd22c//iTIUPY9xKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sx5UH6Zi2x0Qx4HfvZMcafjkPP7CZoK2w2vheze0BxSwlvhlpo6OjKqEQ54yQTszY75jGvO0XGol4PDNSc8SJITAPAG/XcsqODnWK/1Y/G/pLhxPQ6I8QJzrk8P05jj8+xOx7OTZhdshd7h0FT3CmNhBVeJQvNQPB+93JSmiQxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nHOzi5Oa; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeABQBMX10ORnGnpfK6KRBsdBDmfDCxPsvnFESbAJ5Jr1TkKg1qAE0eqaqYZPCKeQz57qgPM7gHGuWKRsoGCKJp0ia9/Nuf0ee+LKkXBny36QoRlBjsUKXxJrR9sPprQDNiIE1PZDpXBXGj7DbthWmNuA7mOvEjV34tC7xG7DTsocNVemzwBGuVvdwUHtVWgh7n8sBAgAsvp0u8Vocxm30rfH6iHA+F4WHuIQwOWtkUgRymyc3qiKHuNGxbP3vBPajU09C+Qa9Uhz8a2lG3UrEhkJh32coz7UGK8I/kJJvcS96+iRMv0bNWh6+/p4w+/fEDXP6Ml/x+uKzFUpBevNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FWxjd2csYPZgV+iUA1RUi9aLDANBMpNfrVsIR//u/0=;
 b=hXmq2RhcSQPuFviRw0Oj6QSY+H0DP95xxfQ8Nv0+jHaE5fxxcbBQ/7M4ZxlsgPpQbyUDrXrGyL5kCSQqRWm78/JvEb1Our2Yx+zFgsWM8vKZokQCDKdy22G7NFo5kzCtx/vYsbsZIGGfYeLg4VESTdUM1TWs2xqaRaJHPwcTsP1UbCfE+P7jXYYTRvx0LM/L8kss21LjTI7G/T+ZZKiwQMhoB56fQdx6YKNTkVIO50quWXSi09zd92llAWobkXj+Bv5qwxK5q/2frJPvHtnP7EVLLEwe8BsnNLKUuLg3sorum3VHXB1iRmLUNeP0eb23Vga45S8xNQ51OkIA978Jaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FWxjd2csYPZgV+iUA1RUi9aLDANBMpNfrVsIR//u/0=;
 b=nHOzi5OaOythIny6eeztDwL5aywAE4teYBg+EU1pAwq6qrgbOFN//QqMz6QO1v5w6uS/b5OHGchzJGbTq8nGmdUTmf8jriE2z0PCJb5VhDueeze+80Fc61x5wQAnjVRY1kXPfJgbn9Bs7Z+XtHi5d8twyISVIW9WKxSk1yhUk5u668Ap3bueEO/A8bwvVnwRpIL56Rj8FV+XUUvws5IXpqhr0OkLSDhrTXaDMKwPs71qGW37J8v277MkZHSp1Zs2ON3lJ0B0hGAWY3Aa3R8f2H9+q5PoBGzydAXiLGsoi8JR51sdML0nZV/7ttBdAbj6FtRBw6mQ4zWhmnANmiM1Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:03:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 18:03:08 +0000
Message-ID: <9f3d50b9-6acf-4bab-b6ff-cd524ad0a2c8@nvidia.com>
Date: Fri, 14 Jun 2024 11:02:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-2-jhubbard@nvidia.com>
 <1ea35568-bfe5-430e-9f4b-edef17f0b22b@redhat.com>
 <e6378446-6087-4ffc-9ce9-320c5e128bd6@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <e6378446-6087-4ffc-9ce9-320c5e128bd6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdaff84-dae8-4621-5ead-08dc8c9c3f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDBZTENIQjRIaG5QUEVINmZKbkowa0Q5V25OcWRKSW4rQmgvci9FOXk1Z1JS?=
 =?utf-8?B?VS9rcUV0RDRyQktoVVNJRC9abFU3QmZ2MEtmdHlXZUxKTzZTNmliNXl5Mkt1?=
 =?utf-8?B?c3VkUlpnWEhvK0xqazBUTlZQdnNpRlRRNjdRUi9oOUZ6SEF3dUVBQ21nc3p3?=
 =?utf-8?B?T25Fd1NFRFBzMDdNWjUybkoyVG1ELzh0azBmckJIaFdvMnQrMGhFMVlQRXpN?=
 =?utf-8?B?RisrZ2dKZzZwUzh4aVM5OThPeWR3VTJtenArdW1ENjdaSVBPZlJ3TmlXUWJ5?=
 =?utf-8?B?eXJOVGNpdFJEMHV4amxOQW5abmlNamV6Q2ZqQ011WU9Ga2pFN0ZCN2VwMmdD?=
 =?utf-8?B?akxNTGZjR3RzSGJMU21yRVN2djNTM0cwMlZkQ3ExTXBINmx3TWpwV2FqODU4?=
 =?utf-8?B?R1A3a1JDSGJiK0wrb0lPclFGa2NXeXNVb21DS2w3eUpwU1Q2S0JyQWorN2Nr?=
 =?utf-8?B?MDRBTUo4aktUbEV1cjUzUElpaVkvcUxYVy91SjdSUHFlSUY4NE12eFBtOW50?=
 =?utf-8?B?ZzdoTnZDTzRpdFRkWUtnSmFkY3BDQ1VDYTZRVEZoZUczZUx4cVdmUlc3cWpi?=
 =?utf-8?B?U0VGUzZiVUVGempKdkNPeVZhUTJEUnFFT3FBZ3JmQkx6WXRlN0VKRWU3Q0l0?=
 =?utf-8?B?VWVOSExkSzZwTGNQSXdvaFZRK2RVU2NvKzFPUGpQekh0VGhFZkZIRW5zTnNx?=
 =?utf-8?B?RkFXMDlzbVhXWlZFNWZiMEhaUGpHTVNaa2hCR1lQK090VWkzRFhiYXRUcVNh?=
 =?utf-8?B?V2xiVXVkejFQNUF4MjhyM3FmdWZMY2Q3RGFOdjNuUU16dWNodVR1aG1CQW1Q?=
 =?utf-8?B?aUI2L0d1YVp4R05xTjFtTFJGemM1aUowOFdlcDV3b2JUczMzU3pUVkNCSTRZ?=
 =?utf-8?B?R2grRi9kZzV1T3Nwc3lHYlJJdWVhWGwrVE5KWDFTS2k5bm4rS3ZVb2xPWmJG?=
 =?utf-8?B?b2dRYVpub3JkVGxtRzdKYUtFNVdOeUpIT1NsbStOeldWZW1PbGFudFhxREdZ?=
 =?utf-8?B?dnMwZWlQSUhMNGpHQkk0UDZKVmsrNXByVUVYbGc2U3Y2ampoSVpvR1VRR3Zr?=
 =?utf-8?B?eEkvT2ZHano1QmpHaTcrZzlLczZoSXZiUFJzSStRNFZ6b0J6anMvb0FiN2wx?=
 =?utf-8?B?UmpxUk5NalFabzZiUkc2RFRIL3l1U2lEMjFPamptSXdBUFhVZkVpZTU4MVJN?=
 =?utf-8?B?S05WYWVjcWtYVlI1VU9YNTBXY2ZiWkUxWlg3aVJ2ZW5ld2cvREZIQVBRdGR5?=
 =?utf-8?B?Y1BmWDlOQ3dRQTlmSVgxeERPT3pUak81RnVKNzdCZTdkc3I1NFJhSDREc0k1?=
 =?utf-8?B?U0ZzWndqUndMZ2FqZklXVFh1RzNCaTY1OFJBTjVhTk9yNGpLbkNDdWY0VGhY?=
 =?utf-8?B?MkgxSFd1YUk0dTBFNXZacXRXZ0JEZm1QYkZUK1JlZTFpZDU2eUZtWDJ5Y1l2?=
 =?utf-8?B?T2hVRkhCRFFmQ1FBWmJuUHgvWlZVMTBmcnA1djExbHRIRlJKY3dUbG4wNERk?=
 =?utf-8?B?ckkzdmlKWHdrZ3pqM25lVW51VjZXdkdFcU92ZUdJTE92U2Jlckczc25Uemx1?=
 =?utf-8?B?NFIzS25LYWJCSnJXcGNBSlUzOEtSUlpRMEFKOVZMQTNhbXd4a0kxQXk2NUZR?=
 =?utf-8?B?WUpnK0hMUGZYYlJmKzREVTdxWldtckkxTzBrTUxWdWJRN0U5WHljSGdNSUI2?=
 =?utf-8?B?OXF4R1hnaVR5K2NLQTBMMUp5ZGd5TGE3SDNvRG9kWUlQRTVnL3pVYW5ac1Ez?=
 =?utf-8?Q?Zi8tsgbiVmCeHBSgFnF9VZxoogAH9D3RJ7/1WcE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTBGc2xJT3pKaGhwOEJpT1ltNGxqNTA4MnA2bVZEYlZtMWZyNWRheU5pd1lG?=
 =?utf-8?B?VHJIcWJmZmh3N0ZlN2c2ZmpSTjg4L3VvK2luVmdTTFc0RUNaYjBBalpxSUVa?=
 =?utf-8?B?RVhPNnRBZFIrN0tlbnNMVmhRandra1JORDBnWU8zdEZVZTE2UWhyL01lTGdC?=
 =?utf-8?B?RDRXMSs2ZjlzVkNYZmlYR0EzalowTVdqMU5CbnhTeng1bTBCWDhJT1YrSk9O?=
 =?utf-8?B?OXk1N0Y2SmtlcFgxdEhPWklRSHlNaHh6VHQvY3lqYnJ4WXFyT1RWVGZUdkFD?=
 =?utf-8?B?aFlpakx4ci85L3Vma1J0N0U2MG5YQ1pmUWJMNDJHSzBIQi9NbTdzWnJlb0RQ?=
 =?utf-8?B?WlR5bVVzTHRCMXljSXpBclkyYTFIVjVLZjVrVEJDQkdIbG1CY05nZzhDTncv?=
 =?utf-8?B?SEZLcTRqSm9IRGdzZzN5T1RzUzR5S0tDR21QWGNSTW4zdEVSczFlMkE0eG52?=
 =?utf-8?B?R3Y4TGl5QUd0NmhSanpCUTA1L3MrMThHK1dnSVo4aHkrQ1FxWEU4Y2E5WDRy?=
 =?utf-8?B?RTVrSGdNWStYeXJHUE10ck1ab3ZCY2Q0SnRJUTIzTHpxb2JmUHZVMGJwa2JG?=
 =?utf-8?B?cjRFRzlBb2lhNXgzbzkyc3VYd3FKK2k5cDlkZm16T0svK3BOcVZNNFlxVjZE?=
 =?utf-8?B?T0hoaTd5U0Uybys2TUo2RnF0Y2tSeTZ5bytZalIxemhRN1VFL0FEcFI3MW1C?=
 =?utf-8?B?Sjh4bEp4ak82NFdkMnhKbmRwNXRiVmUycUJNTW5majl5dklJa0tWZ1hnY1JN?=
 =?utf-8?B?RWdJeXVTNHF1bW9FcDNhanBFcjVqNU8wblZPeHJkbjNkaE1CamJvUmdkVUVa?=
 =?utf-8?B?QlJEdmhGTUk4V1dMZGV3VDA0cHRMY0NiZHR6QnU0ZTBYc0hZcVdQTk5FYXZQ?=
 =?utf-8?B?eDFSd0t5Q3VaZFB6SngzK1lPa21rSm9DTFBzZmdJdUxqcFpMZ1lPYm54T0R0?=
 =?utf-8?B?aWZmQUp6aTdobW9RRGRDWGw3NmZzY2NWYUR0Q05wVlkzQkMvTmppdXA4bUlJ?=
 =?utf-8?B?QlM1Q00yY2ZnQXN3SkZYZExDdGtsS29xOGhHblQ0ZGtnT3BncDFGNFloOFlr?=
 =?utf-8?B?ZmM2Y2pWNzlOcnJWS2tCU0trWkRyVURPaG4vVm1mWU1EdVk3ampzem0zNmhF?=
 =?utf-8?B?cjVTbzFNbXVSTXJmdHZZUnVKTHBCOU5uSEJwc0FFT29iNGlkSEEvY0QwVTNU?=
 =?utf-8?B?aGIxZ3lJOGxtd1BiMW9zZEE3UkxsRWpXdHZHOHREbzRsdGhWTlFNbGFZZWt0?=
 =?utf-8?B?Zzg3MGIzRnRqbkhUZnBTTlFCY2luZGJOcWtOVTZ6REpBWklsS1Z0SXU0R09V?=
 =?utf-8?B?UFJXUFpZblMvNVJzQThucVNoc1hsY3d0MHVRT1hFdG42bGsvSXQ3WnhXUWIv?=
 =?utf-8?B?RGJPNWgxRVRhenpyRDlvVFJhVGdpSVhYaTdzOXJPakV0eHVVSjRzR0RTcXpL?=
 =?utf-8?B?VUNlS2pxcnBEdjhrQTBLa3ptMXRySnYxODg5dS9FRUhEK1IvN0x4SXZOcXRi?=
 =?utf-8?B?SWxmTG5FV1Mrc1k2UDgrbG1Wd3JqYUQzRjRnTVF2R3ZjOWhKdVIra05VRDdX?=
 =?utf-8?B?NzJmYXhxc1ExSTVjb1A1dmhSTTFtb1VEM2hQU2dza3lDUC80YkVjaVpHZEN5?=
 =?utf-8?B?SUZPS2Q4cmJpTzRmOEdTQVIrZU11b2lvYkdQaHZEaC9rc1BLdGZseVFydmpn?=
 =?utf-8?B?VzBydnNab1B1dVhkc0hzcUIyTVZpc1lnbUVDOEJaZUdwQWdpeGNUd3MwQmVF?=
 =?utf-8?B?VWNKUnE0d2xFUFk1VWZPblhiQVlsTG1ST0plNXhSbUt0Y3FCUHpJM1pxdCs3?=
 =?utf-8?B?TjhXZXRJa1NYUUFFUnNWWk44V0hTc1RHZWJHOHNqQkZXQ0FyVktEaVpZZ1Zx?=
 =?utf-8?B?OTM4d1JKU2xycVN1T0ROSExBNnFLbXIwWUxsVnVubHNLU044a1RIMmpPMThR?=
 =?utf-8?B?ZUVjSWM3WUNBaXh4SkNrS3hFYXl2OHhqbitrRWg4MzEveS9YWWxETDdmWisw?=
 =?utf-8?B?Ly9MRW0yOGZoa2NlOUUxRXBqcElFcEhPTldmbzdRYmd0TUYzcXVRT0Qzb0t3?=
 =?utf-8?B?dE9UN04xdnpCN2liQnFzUGpqMEtHdFN0OVNCTmthWmdWcHE5bjFsOTRZdjMr?=
 =?utf-8?B?anI4OVBPQkVOa0FPYUs5VGNqT3gwalUvaFVxYzEySDZXSWUrUzNJTjM3c3E4?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdaff84-dae8-4621-5ead-08dc8c9c3f77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:03:08.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NdWvyTeoaMkd53vuaeuYD0jjZGs4NoyvbsLuhMAS5qKAVXTNmg+QAXSmIYrpYaVu/rKb8JPFANLc+iEk58TEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

On 6/14/24 5:41 AM, David Hildenbrand wrote:
> On 14.06.24 14:28, David Hildenbrand wrote:
>> On 14.06.24 04:30, John Hubbard wrote:
>>> The selftests/mm build isn't exactly "broken", according to the current
>>> documentation, which still claims that one must run "make headers",
>>> before building the kselftests. However, according to the new plan to
>>> get rid of that requirement [1], they are future-broken: attempting to
>>> build selftests/mm *without* first running "make headers" will fail due
>>> to not finding __NR_mseal.
>>>
>>> Therefore,  add ./usr/include/asm/unistd_[32|x32|64].h (created via
>>> "make headers") to tools/uapi/, and change the selftests/mm files that
>>> require __NR_mseal to include from the correct location. The way to do
>>> so is to include <linux/unistd.h> instead of just <unistd.h>.
>>>
>>> [1] commit e076eaca5906 ("selftests: break the dependency upon local
>>> header files")
>>>
>>> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
>>> Cc: Jeff Xu <jeffxu@chromium.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>
>> If it works, great
> 
> ... thinking again, are some of these headers arch-specific (IOW, 
> generating them per-arch would result in something slightly different)?

Oh wow, yes they are. I'm guilty of x86-centric thinking (again).

hmm, this is going to make it really a lot of trouble to do this
approach. But there's no point in turning back now, so I guess I'd
better fire up the cross-compilers and generate for all the arches.

> 
> In tools/include/uapi/asm-generic/unistd.h, we already do have 
> __NR_mseal ...

Yes, but it doesn't get used in selftests/mm, with the way headers are
set up right now.


thanks,
-- 
John Hubbard
NVIDIA


