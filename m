Return-Path: <linux-kselftest+bounces-26698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DDA36830
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7753172025
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1CC1DB548;
	Fri, 14 Feb 2025 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JjjR14ht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7F1953A9;
	Fri, 14 Feb 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571502; cv=fail; b=BK/Z609ep/E+y013eSPNYAaiZcJN28yzhkMvG/sHJ0Ab7oSbe350gLBOPAUAsk4KO37KTxanq6Hf6+UdFPITbrrGBA08bSu1RGytnCkc8Bl6oa+CKLtaspf8xdtejnonwMETramKo+eCh0hkrkcPS617I17IONZM9vkk4OLPQng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571502; c=relaxed/simple;
	bh=zsiS6kz1LSZrpBUf4TeUI0CwXC3NLbvQu5JGRDi+NzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wnds45xRzOdUVcdCbPtCtpPrWY9A9R+ZMXvoondpg29ZLOpt4XPyyZ2mPNqH2ujaAPhCA1sIXrMiKf8fn7HElPMmo0/HVitRMC0T8PPp1lWavEQHyL0EfdeAJTA5//i0DWS9sGFBlEGgmOeR7QBAiHeOAYG1Oj5ismae75s6Erk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JjjR14ht; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUxdMiLzBbaEld4wWyFbINwY7JIcWwe/xXJfvIlfqrgU6xkuUOJCmzPSY2YW9zeGlQps7c9gtQVlRKZUki2vC2i/af0VCn9U4J29usTm5A6PMYoitn42H/OsZ+ED4dy3I3+ubu3Jnjojru41j2uO65hA2bm9IWBKhyhBrvnKc5VgocJDvs19x/0qOxMtN3qtuWSHnctF4OAWPYyvyID8tEdsNwacR87Ez24F37GCL15oKCywg95wGbs8iQFDM/hKwfpQYRBjtVHvxlT3Sgy6W9Fu+WXMMiauysCWgMR/lkVXbBMF0Zokccqncs76jWzKrWntnqZ+uXg7Km5d+OmrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvlPXZlyQDkkKxR7JLh50CjjR6NlDERQN17guBQlB3s=;
 b=GTACiQwJXfVFZKA/dUFIUR69tlU9H2HbALHpeznDr1ozemxfpUl6eSTTys3mK3H5omonJLbT6G1dHcIGYECPlgE+FAuNDwjCE1GFokHC5UlalSAhBsfwtmBy/HDHc+SL2gLMFz8ttAhtAeLU/bFC1tJyE7ysEcPrhgNUEKS+bynSHkimP9mRfmyToCwBbmQzXOWNcN2P0v91fOr3BNVxSaeGpUP03gdW2ReLgUHx+YfRdNNr4z8jK7aWxvi9RiW0kc88AZ4FlDOUgLaXWzdPgEElNUadF3MvFnZ8vDYbZl02WsfpCAHhnUNrU+Z7ZoFARs+xrU273psiYI+JuzOujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvlPXZlyQDkkKxR7JLh50CjjR6NlDERQN17guBQlB3s=;
 b=JjjR14htp2UOylASsP/nVe79tNSZRBmwZecFeSYTYinao0IoXQATlvvWuEOg9nmc8QmC+5/qJfuY+pCcg4eymSgMV4DfDJHn9kwkl8YnPWTM2OT7j+vsZLXPb6/f8X3V9i4Qs0qMqgZK9Jlzt0lnysCTSVmE8FfEkFlJt3I2H/rRc02px2kA0exzJEjwCsq1GF4ebTvdi5M4YatarjhqDTp5ROhO4460XuEqtXsD1IoxWveGL13sN7uEBpyRwE1p0PamVW56NVlEh5sgAfVwi5jAym4u0DL/8E035KlTJShV2a3KJvOWCHtV6XmofYqiaxU0RcSnNGtuyQT8qdZSag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 22:18:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 22:18:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Fri, 14 Feb 2025 17:18:09 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <35A53124-3A8F-47BE-B5D6-59C1B4378A76@nvidia.com>
In-Reply-To: <d989ef66-4a4b-4679-b2e9-f05916ca3672@redhat.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-3-ziy@nvidia.com>
 <db77d017-4a1e-4a47-9064-e335cb0313af@redhat.com>
 <03F6CCF4-EE7D-4259-AF85-455DEA721098@nvidia.com>
 <d989ef66-4a4b-4679-b2e9-f05916ca3672@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbb25a0-1fda-4875-b543-08dd4d457b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHlhVWY0YnBwRTEwNzd1QXROTzYrMWpWQ1JMUEU2b3B5WFZaNlRndjREczhF?=
 =?utf-8?B?RGlsdFhtMGFpUytSbjBVVklOdy8vWko2YWozY3hkbEhHNEVlRENrK2FNbVdV?=
 =?utf-8?B?V0tGcTZMMzc4MmdVRmZhU25DVHdQRlA2YWdpV2xIWTZCUHR0Vk5UMTR2N2RQ?=
 =?utf-8?B?bXpXSWZsbzBMMldXQjZDK1BqSkRlbFYzY0FGYU5HZ1UycTJVZDh4L3NaQmlv?=
 =?utf-8?B?d2tBUFh6WWFFUW5MenVwQlpiY0VFcnNSSFM0b0w5b2QwYmZ4b05hNm1WdXpn?=
 =?utf-8?B?WDZOOXpFSW1DYVpWNjYyOUtMUWg3ZkFzL3V6NFZtRlBwa0xNeGcxY0NCbFEy?=
 =?utf-8?B?cFZzOG5sSTFMbjBpZGNNclYxVm1QaGZkaGY0SzZqTkZWTXFxRzlmL3lzNkhK?=
 =?utf-8?B?S1lvWFh1d2lYZTdodWxodTQ2alhtbFp3MmYxcjUvOUZaVGlnZlZNTmpneWZL?=
 =?utf-8?B?NnFWMHQ1aVJ0dHY2NVVZUjNMaElDS0QxV0lzZlhEdGNHYTZxb0c5M3RHWlVM?=
 =?utf-8?B?Z09RUEE1QmwwTHdmK3NLMTM0L0hTblArdU5jdzVrWnNCQitGTUJwRHBzdTNj?=
 =?utf-8?B?S2NTcW0wUDNMZTlMRE5CY3dwbmlCY3pCRlcrQWVDcGRFNEh3MmdYeW9VdXB5?=
 =?utf-8?B?clVPQThkNnYrbDBnbUkrSG5IRWNVb2pIVS9RRlBpMWV4N1NoUTJTdXdub1h0?=
 =?utf-8?B?WnBSNUZmdEVnbG4xOFNEYTZXVWM2T2xqdGhzY0VhYjJXZ2Jkb0RKbEI3Rm5m?=
 =?utf-8?B?U3dRNmJIRWJhcHJ6SFU5cW51SDdnRUNHWjhzYmQweEdlOHNXMFFjd1N6SVYr?=
 =?utf-8?B?QkkydVo0V01DQUoxbEVwckdaV1FqZUplalpPVFROMlpOVjJOSmYyMjk4dmJX?=
 =?utf-8?B?NFRmZEN4MUxCR1FLQkxuY0RqdXlxQlFJK1daVGtzK3BaVitBbkswYTdCODBU?=
 =?utf-8?B?QS9QeFFpOVhZYjdXSWpLRmh3MkdZL1R5VG9VOXN0VWxpZnM3Wi9rL0ZhcUI0?=
 =?utf-8?B?akRhcmhmWEtqQ29BRXpPMEgvVkowSklMQ1dZb1VUTlZiYUFPc3FJYVRSMlJz?=
 =?utf-8?B?eWxhaVNaVEUrVHhqYzgxOXRxNjZ3dVRTU3V3OGczTWFsTE1Zay9VMDEvMFVt?=
 =?utf-8?B?bkRJcW5TUFVSR29OM1E3RDNMRm0rWWxleUc3M2Q1eHltNVZxNHpPaktya0RC?=
 =?utf-8?B?NXZzVy9IMjl2SDVXZVFYcU9uZ05aNUFpOHhQa3I5ZXZlQlV2bVBXeStnSEMv?=
 =?utf-8?B?WEgwOGlDejAvZWYwTkNiRmxBRy9JRmgwOWdZdCthd0ZBSS94SjJHUndaTHY1?=
 =?utf-8?B?N1BwMHZaY0t1dXJJdWt0T3RnUitSVE1pNXBqc21YTHNtYmg4ejZQSTB4Qyt0?=
 =?utf-8?B?UEVrR3FNL2RjMk9VVU55TGY5QW1JUys3K3BVY1l5eWI3eDdNTEVncUxwbzQ5?=
 =?utf-8?B?YWt2WVVoWFpzUlU4WG8zc1VBdlAwaC9oOFJpMytkVUpTZEVoRC9VVXpET1RV?=
 =?utf-8?B?ajM3WmN1WlZLVkxkMk4yQktDOXVmckFVUXpNcWpRTDR3WDdaVEQ4QTBHNzJH?=
 =?utf-8?B?Si9Xcy9rbDY2cmNtYmdxdWRSTmYzaTBzakNzZFVqQXd2bkJlT291NWdnWXky?=
 =?utf-8?B?WTFaZUxZOGJmOHdqaG93M2tSRTZFRkdEUzBHMlFBdFBFRDFYV1I5MFVCNHNN?=
 =?utf-8?B?VUNZSUFUWmtDK1VtSFVKKzJ0OGt0UTRpK21oUitBNUNpTFZVdU10SzlLNlpG?=
 =?utf-8?B?VDltUldWa05nUnFLa2lLd2VTQkpvWjg1eFFIbk1UaDRHRG1Fd0dNWGtwd2h3?=
 =?utf-8?B?RkxEQlQvcUp4NnF4eTBjQzVqdnc3bWdObnJtR0NCMzI4cjZUamN1ZzF3NmdL?=
 =?utf-8?Q?YlgZhd64u4EKP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjBpTTBZQVVucGdlVEtPTDVqcFRoay84bVNuT0wrMTJybnZ3TTNYcFBhOEs5?=
 =?utf-8?B?c2dvZXpidGg3YnRwdklFd0JteXZOUG15NDY0Q2JJQ3dLcjdaWGpIMkdWSkh2?=
 =?utf-8?B?Mlpzek83czBjZmtzMnQvWGYwT0ExeUdoaHB5WkxubUxOckJSRVdpVmtIZ3dp?=
 =?utf-8?B?UkwwRks1NFdHSXU2YU1tZW1DN0NzdmhaeGhnOHZZVkpDRXRHanpnZlp2VEcx?=
 =?utf-8?B?ZWp6Ynk1QVM1b1RqNk8xRndwVXBqNXFHNStUdzliZGxNV01sZ1ZSN3RYVDlG?=
 =?utf-8?B?UWZDWXpnQ0ZrVFN5VDRSNTB0NTNReEI5SDRRdkgwaUVVQm1IenJNcUNqeFJh?=
 =?utf-8?B?TVlVNHdYWVMyR042Y0Uyd3FVbVM1czdBaGtuMXhKQ0xRMGdWTEJ0eFJwTWM4?=
 =?utf-8?B?UXVaNlNLYzNBTTRSZFJtaWU3bUVlbFZaNVBKVE5EYm5wREI2eU9IVFlzTTFu?=
 =?utf-8?B?K0JoUWJHMDlBT1pYSEZEOHBrL1NVbUZLaXlHaWFNWGVDc1lhTm1qbFlhTEY3?=
 =?utf-8?B?NWc0SHJwcnFNcDNjS01mZ1Q2RXpJaWNDSW4rMkRpRUxiZ0dVSVpTRWJjQkNp?=
 =?utf-8?B?NnpLZm5ZRTUrblp0bFcwUThoWTZNYnJDeFdxQzQ2Rkg3U0dSNVBtT283T1Yx?=
 =?utf-8?B?dGV5bnA3Wlo5aC96cWlOTTR2dlMrRXZZZU90aW5jV1R1dVlQWDZaT0xwdXQ0?=
 =?utf-8?B?VCtCMUdOK2NFZ3A3a0szRDNlTGoxd0RleHNTMDYwSDlTVjNPV2VHNWw5Y2Y1?=
 =?utf-8?B?cVBrK3p5RFZReGdhaEVKb2dpaXAzclJPQldmOUlPWkxORVdvSDFaM3drc3J0?=
 =?utf-8?B?UUp0dlNtTTFCdnJMdW1ydk01cGxFcGhoRXl0TGRqWUsrYmFzZWpqakd3VDlW?=
 =?utf-8?B?d2U2OXpUa2VQYlovbCt0YlR0Smpna0IrOVprS3VJQ2NzK2ZpR0FtaWZSbW9i?=
 =?utf-8?B?Mi9SYlovR2Zqdmt5aCtWS1dNZWJ0NmYzNzhlNG91d0FtSVpzU1FtcHZPdHo0?=
 =?utf-8?B?YTA5ZDFGNmJjaHRrOWF6dUMvZUFnL1VMUExuOUVwb1J6cHQzb3VHSnJIZTlw?=
 =?utf-8?B?Z1JYQVA5ZzFadlExNTQ1TFdKWndoQm8vL0c2Rm9nY1JTc3pOVHBoeVRhcGZn?=
 =?utf-8?B?KzJhMUxnck93QTRLbGFaN204QndQZTdZVG1wbk5mZnpuSnlEdHJ6azhTVDV0?=
 =?utf-8?B?b3ppRXVEZDE3YW8vKzJOTHVDaGMvNkZmVWtNWEJ0Wm5CSTU1bkJ4WEF6R1JF?=
 =?utf-8?B?YmVpQjB3cGVTRzJRcEp6U2IwRlRBSlVaTGFtTnlnaDYrSVYyTU9DSXZrQUh2?=
 =?utf-8?B?L0tPZ0NuN2FDUUtvM1E1UlNOOU4rYVllNklaWWF0Yks5UVZDZCs5VXZSV3N0?=
 =?utf-8?B?TzNEU2FudlN4TVorUmxiWlBtWWE5RkRUQ1lxU2JzalRKREVGOTM5TGpkRUdL?=
 =?utf-8?B?d1RFQU02ZThPbDdLVzJDZEFnc2JRQU44WGI4bnhDMzdQdTJZM0EzRHFDaEtU?=
 =?utf-8?B?YkJiZVFKbWwxUmlPQVowWFgzWmc1UUdReHBuQmZUYnlwNld4MVlONWNXeGNY?=
 =?utf-8?B?ZVN5c2grYnBuZnorekllcnJtZVkzd2xHTTdTV3NCcnZVbUlaRm1HMHhkVDFt?=
 =?utf-8?B?b3pnVDd2Zkh6UklLY1hpMmFqUEdDbWFBREkxZ0hsdlZkVTBNT1crSEk0aUtz?=
 =?utf-8?B?NFY4T3VIOVJ3TkloR2R0cHYyVmQyeHhlNkpXZWFiamR5NU1RZ29FcFRWV3hu?=
 =?utf-8?B?Z1lTWXBQWXIwMGxGMHpmSisrQUUrQnZJVXJpeFBBcFRSbTdkQ0ZCZWZ5cTBO?=
 =?utf-8?B?QWVHaUgwR251UmRHNUg0NGVVVWo1czJucGcvbSsvTDJxWjdISHFRTzFGd0pl?=
 =?utf-8?B?d1pWVENRS0NUTUFxd3MzVDRBR2hqNDEzcDhyQVpGTHY4SWdmL24reHdvMzdm?=
 =?utf-8?B?Qm5OR0FvZFpxQWlxSHl5TktqVWxJdnpWdnpQN29tU0tRcDlLRTArbFZsMnRp?=
 =?utf-8?B?UElnVmdkemRHRDdXcWY5WHFGVTNvWVVLcThQUU13WFdVVG1zMjhOOXVvL3Qz?=
 =?utf-8?B?TFYvVGxRNlpDUFhpTTBwZmVsOXIxZFh2Q0NScUVXYUxrdHhvZWpwdUs3MjBn?=
 =?utf-8?Q?DMFiuoOpodpzDOn2hW36OgOgl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbb25a0-1fda-4875-b543-08dd4d457b1e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 22:18:17.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPCCCmo/X1cWZxR91wbIH+0vWplpFsw8h98WVQDTXWOguaOwy3bNiIgxviqz7w/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093

On 14 Feb 2025, at 17:06, David Hildenbrand wrote:

> On 14.02.25 23:03, Zi Yan wrote:
>> On 14 Feb 2025, at 16:59, David Hildenbrand wrote:
>>
>>> On 11.02.25 16:50, Zi Yan wrote:
>>>> This is a preparation patch, both added functions are not used yet.
>>>>
>>>> The added __split_unmapped_folio() is able to split a folio with
>>>> its mapping removed in two manners: 1) uniform split (the existing way=
),
>>>> and 2) buddy allocator like split.
>>>>
>>>> The added __split_folio_to_order() can split a folio into any lower or=
der.
>>>> For uniform split, __split_unmapped_folio() calls it once to split
>>>> the given folio to the new order. For buddy allocator split,
>>>> __split_unmapped_folio() calls it (folio_order - new_order) times
>>>> and each time splits the folio containing the given page to one lower
>>>> order.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    mm/huge_memory.c | 349 ++++++++++++++++++++++++++++++++++++++++++++=
++-
>>>>    1 file changed, 348 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index a0277f4154c2..12d3f515c408 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3262,7 +3262,6 @@ static void remap_page(struct folio *folio, unsi=
gned long nr, int flags)
>>>>    static void lru_add_page_tail(struct folio *folio, struct page *tai=
l,
>>>>    		struct lruvec *lruvec, struct list_head *list)
>>>>    {
>>>> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>>    	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
>>>>    	lockdep_assert_held(&lruvec->lru_lock);
>>>>   @@ -3506,6 +3505,354 @@ bool can_split_folio(struct folio *folio, in=
t caller_pins, int *pextra_pins)
>>>>    					caller_pins;
>>>>    }
>>>>   +/*
>>>> + * It splits @folio into @new_order folios and copies the @folio meta=
data to
>>>> + * all the resulting folios.
>>>> + */
>>>> +static int __split_folio_to_order(struct folio *folio, int new_order)
>>>> +{
>>>> +	int curr_order =3D folio_order(folio);
>>>> +	long nr_pages =3D folio_nr_pages(folio);
>>>> +	long new_nr_pages =3D 1 << new_order;
>>>> +	long index;
>>>> +
>>>> +	if (curr_order <=3D new_order)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/*
>>>> +	 * Skip the first new_nr_pages, since the new folio from them have a=
ll
>>>> +	 * the flags from the original folio.
>>>> +	 */
>>>> +	for (index =3D new_nr_pages; index < nr_pages; index +=3D new_nr_pag=
es) {
>>>> +		struct page *head =3D &folio->page;
>>>> +		struct page *new_head =3D head + index;
>>>> +
>>>> +		/*
>>>> +		 * Careful: new_folio is not a "real" folio before we cleared PageT=
ail.
>>>> +		 * Don't pass it around before clear_compound_head().
>>>> +		 */
>>>> +		struct folio *new_folio =3D (struct folio *)new_head;
>>>> +
>>>> +		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) !=3D -1, new_head)=
;
>>>> +
>>>> +		/*
>>>> +		 * Clone page flags before unfreezing refcount.
>>>> +		 *
>>>> +		 * After successful get_page_unless_zero() might follow flags chang=
e,
>>>> +		 * for example lock_page() which set PG_waiters.
>>>> +		 *
>>>> +		 * Note that for mapped sub-pages of an anonymous THP,
>>>> +		 * PG_anon_exclusive has been cleared in unmap_folio() and is store=
d in
>>>> +		 * the migration entry instead from where remap_page() will restore=
 it.
>>>> +		 * We can still have PG_anon_exclusive set on effectively unmapped =
and
>>>> +		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>>>> +		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>>>> +		 */
>>>> +		new_head->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>>>> +		new_head->flags |=3D (head->flags &
>>>> +				((1L << PG_referenced) |
>>>> +				 (1L << PG_swapbacked) |
>>>> +				 (1L << PG_swapcache) |
>>>> +				 (1L << PG_mlocked) |
>>>> +				 (1L << PG_uptodate) |
>>>> +				 (1L << PG_active) |
>>>> +				 (1L << PG_workingset) |
>>>> +				 (1L << PG_locked) |
>>>> +				 (1L << PG_unevictable) |
>>>> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
>>>> +				 (1L << PG_arch_2) |
>>>> +#endif
>>>> +#ifdef CONFIG_ARCH_USES_PG_ARCH_3
>>>> +				 (1L << PG_arch_3) |
>>>> +#endif
>>>> +				 (1L << PG_dirty) |
>>>> +				 LRU_GEN_MASK | LRU_REFS_MASK));
>>>> +
>>>> +		/* ->mapping in first and second tail page is replaced by other use=
s */
>>>> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping !=3D TAIL_MAPP=
ING,
>>>> +			       new_head);
>>>> +		new_head->mapping =3D head->mapping;
>>>> +		new_head->index =3D head->index + index;
>>>> +
>>>> +		/*
>>>> +		 * page->private should not be set in tail pages. Fix up and warn o=
nce
>>>> +		 * if private is unexpectedly set.
>>>> +		 */
>>>> +		if (unlikely(new_head->private)) {
>>>> +			VM_WARN_ON_ONCE_PAGE(true, new_head);
>>>> +			new_head->private =3D 0;
>>>> +		}
>>>> +
>>>> +		if (folio_test_swapcache(folio))
>>>> +			new_folio->swap.val =3D folio->swap.val + index;
>>>> +
>>>> +		/* Page flags must be visible before we make the page non-compound.=
 */
>>>> +		smp_wmb();
>>>> +
>>>> +		/*
>>>> +		 * Clear PageTail before unfreezing page refcount.
>>>> +		 *
>>>> +		 * After successful get_page_unless_zero() might follow put_page()
>>>> +		 * which needs correct compound_head().
>>>> +		 */
>>>> +		clear_compound_head(new_head);
>>>> +		if (new_order) {
>>>> +			prep_compound_page(new_head, new_order);
>>>> +			folio_set_large_rmappable(new_folio);
>>>> +
>>>> +			folio_set_order(folio, new_order);
>>>> +		}
>>>> +
>>>> +		if (folio_test_young(folio))
>>>> +			folio_set_young(new_folio);
>>>> +		if (folio_test_idle(folio))
>>>> +			folio_set_idle(new_folio);
>>>> +
>>>> +		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
>>>> +	}
>>>> +
>>>> +	if (!new_order)
>>>> +		ClearPageCompound(&folio->page);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * It splits an unmapped @folio to lower order smaller folios in two =
ways.
>>>> + * @folio: the to-be-split folio
>>>> + * @new_order: the smallest order of the after split folios (since bu=
ddy
>>>> + *             allocator like split generates folios with orders from=
 @folio's
>>>> + *             order - 1 to new_order).
>>>> + * @page: in buddy allocator like split, the folio containing @page w=
ill be
>>>> + *        split until its order becomes @new_order.
>>>> + * @list: the after split folios will be added to @list if it is not =
NULL,
>>>> + *        otherwise to LRU lists.
>>>> + * @end: the end of the file @folio maps to. -1 if @folio is anonymou=
s memory.
>>>> + * @xas: xa_state pointing to folio->mapping->i_pages and locked by c=
aller
>>>> + * @mapping: @folio->mapping
>>>> + * @uniform_split: if the split is uniform or not (buddy allocator li=
ke split)
>>>> + *
>>>> + *
>>>> + * 1. uniform split: the given @folio into multiple @new_order small =
folios,
>>>> + *    where all small folios have the same order. This is done when
>>>> + *    uniform_split is true.
>>>> + * 2. buddy allocator like (non-uniform) split: the given @folio is s=
plit into
>>>> + *    half and one of the half (containing the given page) is split i=
nto half
>>>> + *    until the given @page's order becomes @new_order. This is done =
when
>>>> + *    uniform_split is false.
>>>> + *
>>>> + * The high level flow for these two methods are:
>>>> + * 1. uniform split: a single __split_folio_to_order() is called to s=
plit the
>>>> + *    @folio into @new_order, then we traverse all the resulting foli=
os one by
>>>> + *    one in PFN ascending order and perform stats, unfreeze, adding =
to list,
>>>> + *    and file mapping index operations.
>>>> + * 2. non-uniform split: in general, folio_order - @new_order calls t=
o
>>>> + *    __split_folio_to_order() are made in a for loop to split the @f=
olio
>>>> + *    to one lower order at a time. The resulting small folios are pr=
ocessed
>>>> + *    like what is done during the traversal in 1, except the one con=
taining
>>>> + *    @page, which is split in next for loop.
>>>> + *
>>>> + * After splitting, the caller's folio reference will be transferred =
to the
>>>> + * folio containing @page. The other folios may be freed if they are =
not mapped.
>>>> + *
>>>> + * In terms of locking, after splitting,
>>>> + * 1. uniform split leaves @page (or the folio contains it) locked;
>>>> + * 2. buddy allocator like (non-uniform) split leaves @folio locked.
>>>> + *
>>>> + *
>>>> + * For !uniform_split, when -ENOMEM is returned, the original folio m=
ight be
>>>> + * split. The caller needs to check the input folio.
>>>> + */
>>>> +static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>> +		struct page *page, struct list_head *list, pgoff_t end,
>>>> +		struct xa_state *xas, struct address_space *mapping,
>>>> +		bool uniform_split)
>>>> +{
>>>> +	struct lruvec *lruvec;
>>>> +	struct address_space *swap_cache =3D NULL;
>>>> +	struct folio *origin_folio =3D folio;
>>>> +	struct folio *next_folio =3D folio_next(folio);
>>>> +	struct folio *new_folio;
>>>> +	struct folio *next;
>>>> +	int order =3D folio_order(folio);
>>>> +	int split_order;
>>>> +	int start_order =3D uniform_split ? new_order : order - 1;
>>>> +	int nr_dropped =3D 0;
>>>> +	int ret =3D 0;
>>>> +	bool stop_split =3D false;
>>>> +
>>>> +	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>>>> +		/* a swapcache folio can only be uniformly split to order-0 */
>>>> +		if (!uniform_split || new_order !=3D 0)
>>>> +			return -EINVAL;
>>>> +
>>>> +		swap_cache =3D swap_address_space(folio->swap);
>>>> +		xa_lock(&swap_cache->i_pages);
>>>> +	}
>>>> +
>>>> +	if (folio_test_anon(folio))
>>>> +		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>>> +
>>>> +	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>>>> +	lruvec =3D folio_lruvec_lock(folio);
>>>> +
>>>> +	folio_clear_has_hwpoisoned(folio);
>>>> +
>>>> +	/*
>>>> +	 * split to new_order one order at a time. For uniform split,
>>>> +	 * folio is split to new_order directly.
>>>> +	 */
>>>> +	for (split_order =3D start_order;
>>>> +	     split_order >=3D new_order && !stop_split;
>>>> +	     split_order--) {
>>>> +		int old_order =3D folio_order(folio);
>>>> +		struct folio *release;
>>>> +		struct folio *end_folio =3D folio_next(folio);
>>>> +		int status;
>>>> +
>>>> +		/* order-1 anonymous folio is not supported */
>>>> +		if (folio_test_anon(folio) && split_order =3D=3D 1)
>>>> +			continue;
>>>> +		if (uniform_split && split_order !=3D new_order)
>>>> +			continue;
>>>> +
>>>> +		if (mapping) {
>>>> +			/*
>>>> +			 * uniform split has xas_split_alloc() called before
>>>> +			 * irq is disabled to allocate enough memory, whereas
>>>> +			 * non-uniform split can handle ENOMEM.
>>>> +			 */
>>>> +			if (uniform_split)
>>>> +				xas_split(xas, folio, old_order);
>>>> +			else {
>>>> +				xas_set_order(xas, folio->index, split_order);
>>>> +				xas_try_split(xas, folio, old_order,
>>>> +						GFP_NOWAIT);
>>>> +				if (xas_error(xas)) {
>>>> +					ret =3D xas_error(xas);
>>>> +					stop_split =3D true;
>>>> +					goto after_split;
>>>> +				}
>>>> +			}
>>>> +		}
>>>> +
>>>> +		/* complete memcg works before add pages to LRU */
>>>> +		split_page_memcg(&folio->page, old_order, split_order);
>>>> +		split_page_owner(&folio->page, old_order, split_order);
>>>> +		pgalloc_tag_split(folio, old_order, split_order);
>>>> +
>>>> +		status =3D __split_folio_to_order(folio, split_order);
>>>> +
>>>
>>> Stumbling over that code (sorry for the late reply ... ).
>>>
>>> That looks weird. We split memcg/owner/pgalloc ... and then figure out =
in __split_folio_to_order() that we don't want to ... split?
>>>
>>> Should that all be moved into __split_folio_to_order() and performed on=
ly when we really want to split?
>>
>> Yes, or move it after the status check. In reality, __split_folio_to_ord=
er()
>> only fails split_order is bigger than folio=E2=80=99s order, which shoul=
d not happen.
>
> Right, I was wondering if this is actually a WARN_ON_ONCE() kind-of situa=
tion.
>
> Probably  __split_folio_to_order() should never fail, and that sanity-che=
ck should be done before that splitting code here in the single caller.

Right. The check in __split_folio_to_order() is redundant. new_order
was checked in __folio_split(). Let me remove the check and make
__split_folio_to_order() never fail.

Best Regards,
Yan, Zi

