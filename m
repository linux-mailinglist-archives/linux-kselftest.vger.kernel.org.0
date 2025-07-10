Return-Path: <linux-kselftest+bounces-37019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D8B0086D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0070B1C21D27
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601392EFD80;
	Thu, 10 Jul 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YxEhhs1G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A627145E;
	Thu, 10 Jul 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164507; cv=fail; b=Pt8SIbTmaqmbce+AcLi28m2pOzeXgaKsIv+/UNDPNk3wWaUhcN35TSY8+JwThffnI8uk8Q1TGCj1P6jpbiuHi2r5SwrIjsLvi8t+wVvsHbEWAGHKXDpnJAER8AnsIm1p8L9vX3yhFdJ/uJ4hCWaaJtn/32vWZ4084bxnDwppAUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164507; c=relaxed/simple;
	bh=1lt3EMccUtOQmXJ35IVtBl/F1flZj2sth1Wf9ZPW3PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BI2oir9Yrq2zeZjPulCzy8ljCZmiD6JjQTnP91uYSKImuiiK6rmhJFEz0g0ybgiYNwOH9szkS13mcIh6beLl/h2o1KCd4jIO+ld+/d0dAA33AoAi0qAHEAYHloXYjPPo5bpMjgRckb9RebKSuIFze15/BvQbCwQkphwcWeWngw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YxEhhs1G; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw7w8AOVWuwpwQmTb3U+vGE53vrShmpw6mpTtHVN2gnKWuYycV/lEBEDMuuz9m26E4GCSmSVAwu+WBZe1CRwTBL1YapPu5m2FaAyeEHlsF0zPPPGn+sCsT+cGfgbwA/WmBYWtkwLGxsEeYP3LGrLTu3wGLma3ANXcXrS5HUlbZE3HGz+7J4LiAuV8kbm4X7eAUWdgSEs/leFk0TU+tcu2/X81Q57rdlnVMHyG6gFny4EJ2GEO3DUaa+8a0lSuSyL8P5tuE9AYwx4xP2Pu9ItyM0R13c+DC/8s+zakoQaMi+tkNfTHcSoRc84kF0AXhjoQUaEzgBFm0Rr073Mn0GxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBWua+VGuTU+z2m+P5zHdspyDqo/pPsHiurRtojEtiI=;
 b=QmBTGS7YA/jNesNsC9Y05TBexolmA19U6u0FC4jMFwmInOwAvE8cJ1fPisR7qIiCSpSJ84beb7EGWUosY2K5TyuPTJCS/0/SaQi7xXSLAmUr/GuC4yGCDpndwtyKMjZcSI3TMYcDaYGyooCKyTeQNORm3Zo9YeWziIIsC+rjVeqyqakhW2HdjCASqlusGMr9ZikcheCVbFIAOTCxH+bWVoDhk8ampB8EERAYgqbXa4/zWeJBZbkp+E1B/Pz+j5KmusfpQGPA2S8wOTS/oCXPkGXWOCpNf4kBhpPwn7XZYBO5hruUrazB4hRTkzz5ow2fS7nCuNoSv/MpYpHiwiGAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBWua+VGuTU+z2m+P5zHdspyDqo/pPsHiurRtojEtiI=;
 b=YxEhhs1GiRynFybH3atHi0+tezj+GrYeSr7E+l0/gGk3eOmP0TDtySUPkNueTYHaZqoP5ue1PA4oUuH0bACEpGXx3z4FtH+hZqVU3RCpmCEWwBQbec36zVUsPhtcRpECiVSZ5Gbo27dtbEo1sS7h/+rUCOMPf0ousZcQ6vBPzzBj1/Rp3YYhC2QhHgoKfSqEdqI1jaESFSpNqLvuud2rqGJviAn/dbGedDnn/2H2eGCpfhmrWWsZdmLEMQQGq5xjNm5yJfHrFnw3Btlpat+q8aAERAlaFHpkP9NY940JL7SNvpsz3qVkpMEHfNu4Upf95wOKWpCnUpd1ByGOFD850Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 10 Jul
 2025 16:21:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:21:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, david@redhat.com, sj@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, Liam.Howlett@oracle.com,
 brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
 p1ucky0923@gmail.com, ryncsn@gmail.com, vbabka@suse.cz,
 zijing.zhang@proton.me
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Date: Thu, 10 Jul 2025 12:21:36 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <1C943CB7-D63C-41F9-B676-90261E26F049@nvidia.com>
In-Reply-To: <aG_DPLhtZ5qDuWHY@finisterre.sirena.org.uk>
References: <20250710112249.58722-1-lianux.mm@gmail.com>
 <aG_DPLhtZ5qDuWHY@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 99177d6d-a5cf-4df9-e1bb-08ddbfcdd989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmdvK0ZKTEJEcGNRQXlIeVVqYWlGekdXUTRhenpSZkt3Qk8wVzR5c1lDMG9i?=
 =?utf-8?B?MGNraWhXTG43a09mYjU0Tnl5S21XRkc3N0t2VjVPM3JSWjRmODRpSUp4aWlG?=
 =?utf-8?B?NlliM0czUGxIUXdudDBxTnlBcWxLeXlmaFlvTFgwMFgxc2krTlE4cWJPbkRJ?=
 =?utf-8?B?OGZjMGoyWlUzSXZXaW5EUzlGaldtbG41VGR3dnhPb3d5ZDlnanBzaE1TZ3FP?=
 =?utf-8?B?dmVBUVpVTkt1N1M1SllybXJiM2xjcFZZYmNVaEFkQTFKVlp3c1dzVHF6WGdt?=
 =?utf-8?B?UlNMd3dQakVOU25TQVVlUERmNUlDNkxiMTdGeFc2QW9LSlhpVmF3cENEVHBm?=
 =?utf-8?B?c0phUGhWNUJocGxWOXlkd29wMmUxM0NLenJlVGswRytzVlp5OUh4NXRJZTZY?=
 =?utf-8?B?TXM3amxCdWxKczFNU1VDN29nYU1rTnpoaENoZEhKK3B1OWk4aEszQ0sraHBm?=
 =?utf-8?B?NjVZbm9ZNk5MY0ZaVW1YK0NrVWVKSzFvcDBNWThscEhYVWVQSlN3NGFvY1pR?=
 =?utf-8?B?a2lIR0RBMTZyUlJYRlRlNEtGTXNLdVpPR0FMd1c4VnI5S2dtWUI1aTNWQ2Mx?=
 =?utf-8?B?QjlvTTU5TW1HR3Y4RndiZHVPY2lDand3N0J4dUVVa3lXMHozdFdsczlxQmdv?=
 =?utf-8?B?aXlqTU1IUHdmeXZWancxUE5jTHVxYzdGTm03cjVyTDVwTi8xRDlsb3NNY0pX?=
 =?utf-8?B?eUc5ZlVOT2p1UmEwNk1iekxiN2J2NEFRam1UMGsrSHgxVWlBRWs5bzREV25P?=
 =?utf-8?B?dWlxQUxYWlpLN3hERSs0YWJ4bDFuU0FVWjVYQlAwbkNVaXZvSFl6VmFoTUZy?=
 =?utf-8?B?OU1says1Z1Y1QXF1U2tpaWU2Ty9RT3g1c3Myb083T2ppdHh5c3k4WjNLTmMz?=
 =?utf-8?B?QThmM1RmU0RxSEFDa25FSHFjODZITzdXenEyajlacEhockNDL0NaQXVhV3RK?=
 =?utf-8?B?cGVRc3Q5UHpYSlVxRmlHOFNtblFiMlJKYTlRQ1BQU0IvbE92MGhURnZETEFJ?=
 =?utf-8?B?N3JERVdlS2tIZHZHa3dGWXhWSXVNZHRJSVNMd2wzaDZnWmZOUUxtNklKZDBm?=
 =?utf-8?B?WWxJZWMwRFVBR3FoSnFBK3NhOWZOMEx2T0cyMUtZYjV1Z0RrdXdTRjd0NHhO?=
 =?utf-8?B?MXNWMVBORWdIRGhLUXFvZ3JXTzJqT2ovOW1wekV1ZFJDanVUc3l3Q0FEQ0hu?=
 =?utf-8?B?TjBSdEVjTTZyWmVuRDdTdHlqQkdXVy81YS9JY0VFcnFkUTdsN1lmem55RG9j?=
 =?utf-8?B?dWNFS3ZjNGFRTGRSdUlQdjBodW5ONVdveXF2Myt3SHlrKzl6NEhjZWFZTGU4?=
 =?utf-8?B?ZEc2MkY2Y29wU1JHQVF1NHgyQmg4clhSaGF5cHM5VzljS0Vsc015UFFQMXJH?=
 =?utf-8?B?c0ZHc2liOHEwV0VmNGdOeDNvQWNlakpvWlRjT2ZsU3Zwb1ZMcWZYTHJlRVJH?=
 =?utf-8?B?ZVhraWl4ems4cjZhQkU1Yk5sL2Ric2diQVpGSWpZanoxVVBWTXJKWDBTVm5G?=
 =?utf-8?B?bVJWRmdYRURuZzh5aG5XenBjYVVxdThZZldsNkNIelFvZjhUclB6aCtBZFNp?=
 =?utf-8?B?VUNvaXlNWTh1T3JJSzNUWmk1ZHNxR3UyeC9OVDl6T1NhOWtUZ3h6bkNJSk5P?=
 =?utf-8?B?QnphRm9SODZVWVF5NWJwSGh5U2hTNjhhclZtRUJ1Ym9aRVV3VUtqRk9GbTNw?=
 =?utf-8?B?ZmI4eEVmaGtoVVV5U1lHbEg2ZFdGL0M5T0cwdURYbHE4djcwZndCTWRVZDVU?=
 =?utf-8?B?Q0FSK3BwUEx5STRvSUg2VGZxdThrbXdJdjJqT1lGQ0FsTkpPZktnUFhkdDYr?=
 =?utf-8?B?VkZ1RWdsSG8vNVlpVXB5K0R2bXFVbmlhMCsrWWVJWWduaDhuNjRLZFo5ODBY?=
 =?utf-8?B?UGY0WWwyb0Z3U2JHcG91YVNubm5BL2ZiQ0dLTmtJc0lidkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0VPcklTMnJCemZTRDZ0NGhaNUltQi9obzJYcUNKVHlrQ01TN2cwV1lmcDJW?=
 =?utf-8?B?S0FsT0ZFNnVpZjF0ZHdYNExUSExXVTlrMkx5cG5uTG1jZy9yUnVrVUJjK0l6?=
 =?utf-8?B?VXFZNXBGL2NTWmxlYW8rNXZwNmVMRVBmd0syZ0d4K29hZE9EL25YMVBPMFZx?=
 =?utf-8?B?S01ySGlhY0prdVgzajFWaTJsb0l3aG85VEl0NVNnQjN5RFNZSjdpenkwUGJq?=
 =?utf-8?B?dnNWczJCWWJmcytzZ25PV1FDek14Wk0rSGEwdG1GWXg1bHVWeE8wbDFZMnBw?=
 =?utf-8?B?Y1dzRHNybmI4aHdSM3NZbUptSUh4bXBUT2xhWWtOcWl0ckFUVTVrM1dqaE1W?=
 =?utf-8?B?bWZnRXk0ZllXeW1VK3lSZmdWYkEwdUtBL1IzdTlDcm15RjVWcVBvdlhCVy9F?=
 =?utf-8?B?RDFqemI2T052bHlLaEppbldKQllGL1BIZCs0TmhPTnNvSElxY2RmZzBrek5W?=
 =?utf-8?B?TWRVZGRRL1d5V0NkeXU1KzBEZ3gvUEEvNWlDc3dCVDB4bWR3dTc0QWI4SlRl?=
 =?utf-8?B?VEN1bnQrQUk0RlpTalhEb3JGbVlIRVFaclFkTzIvRk5hcGVyU3lteDBJVzUr?=
 =?utf-8?B?Y1RyeHZzYzVXUWlXVWQreTkvVC9UTjhrUjVtUkJhWVhLRVpyall2YTM1Z2xC?=
 =?utf-8?B?a3hvaGxzNE9BM0xpdk5Qc2hrNEMwbm43M0hZdXJleXVPSFFtWWE5cVNtZGF2?=
 =?utf-8?B?Q2tGNGszUENsVlI0SGxIUmJocUt5cXQwbDZNUjRWUklxMmE0d3lpWXJLeFVT?=
 =?utf-8?B?L0NTRXcyZzV2bHNxclE3UFhaK2tVN0RJWnk2WWVuZFdwUHFJSDQ4aDN0Rjk4?=
 =?utf-8?B?cllWQ0lLMWRzWWk5b2EzRXBOdUlLaUlzL095SlF2TUdKbExjd2xCSFZTNXlN?=
 =?utf-8?B?MGVOdHB2VWZISktMcUpKZjI3NGY1YlhPV2lJM1VvV3JFR3JLOFJvc1czb0JN?=
 =?utf-8?B?cXJkYjhyYk53VDh1d0FFS0J3SWZNZjFPY0JuUERQWDZ0S25OeVNWQlJzMStJ?=
 =?utf-8?B?WmtKV2NjNElUaW1BQ2JlYWJmMDR4V2o4UUtEK29kWk81cENzMUs3L0Npbml6?=
 =?utf-8?B?dENPY2l0RXgvcjc4bTVQRnc3WGRFM0JkbkZxTS9WMUpsbWlmSEFMR2N4Y1cx?=
 =?utf-8?B?WTM4RzJvb2lYUVhQcENJQVd1MEZZNGtkUnpVaUl6L2JuQmRxd0Q2NEEwdm9H?=
 =?utf-8?B?d2JSdnVCa2crNHhNZEFkVGM0STI2UkNqMkhtYWJKdXpOQ1NEYzdkeEpPKzRX?=
 =?utf-8?B?K1F3NzdPUHhWcitnOW1PUWgxV1B4MzRPQVlLdlRXM3VJLzcvbThpRTBsWWZF?=
 =?utf-8?B?a2c1MVk5TWVRZVBFdHJjWmMyWUJEaGpqelZGVUUzbHoxMVFlaEJpeFZOUGFl?=
 =?utf-8?B?TDhDb3daTmp2RDhkWWordUhaUGRXNHVqQVh0QURIQUVBc3FKWXpyVm5TNXpi?=
 =?utf-8?B?aDVyY3FiUEdjOG9nYngrTCtwMUFabU9Na1hIamt0UWN2K1p6REhUMkMzcFZM?=
 =?utf-8?B?T2ZMa1FSOFl1d2M2YklmdHpKMjdtZzdTQXM2blZmYU54bEFCbEtJUmNUQ2gy?=
 =?utf-8?B?VHRwQnN5bVFSTVFaMmkvWXk0Y1lFR0VxVk1kQTdZRitjSngwRDMwUW43VGJH?=
 =?utf-8?B?ZmVSYjNIdmNzVVVFd0t0S1ZWTEtqWXJSeGdONC9PTTZBNkZSVktMWE9TMWZH?=
 =?utf-8?B?QllFbnpCa1RabU9ORjNrWDArcWliWDlMMDhFMlhOQmtVKzFoVGlRb0pyOGdo?=
 =?utf-8?B?K2N3Q1YwV3VacktFMEJmMXhrRUZGdksxcHVKVmR5UURIcFNGbDk2dUlKTTZj?=
 =?utf-8?B?NS9qWkFvRFpCcUYrVzFVdVVncGtFN2dCUHAybWxhalJUZ1E0VFZncS9zLzhP?=
 =?utf-8?B?U2oyRy9ZUHdLYmpCTWlvZHRWOXRMbTRmWFpOT0NaeSthbi9ETEpXczV1dXNT?=
 =?utf-8?B?TlhUUGh4V2ZVb1hSUHlnYThTUnZCSDhTaHRyUW1oM2Z0d0hwdDh3SjcxUDBo?=
 =?utf-8?B?Q3g0dGhhNWZONmFUem5BcU1TVU9xYVdoMk90QW5palFiRzJwL0lnY051U3dD?=
 =?utf-8?B?bkYwUlkvenhnL3FZRFMzQXgyOXZlbWNzYWtSaE0zMzV6WHpBUjJGVnc2aVdx?=
 =?utf-8?Q?EPFbP9MI6TP0djdtVShw6s0wy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99177d6d-a5cf-4df9-e1bb-08ddbfcdd989
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:21:39.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YP9KyMELqHGtNEEshTlBQjfqeORkXlebz/71KGKDrjF2fgGx2mrj1yYIW4QHDxNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

On 10 Jul 2025, at 9:42, Mark Brown wrote:

> On Thu, Jul 10, 2025 at 07:22:49PM +0800, wang lian wrote:
>
>> Add tests for process_madvise(), focusing on verifying behavior under
>> various conditions including valid usage and error cases.
>
>> --- a/tools/testing/selftests/mm/guard-regions.c
>> +++ b/tools/testing/selftests/mm/guard-regions.c
>
>> -static void handle_fatal(int c)
>> -{
>> -	if (!signal_jump_set)
>> -		return;
>> -
>> -	siglongjmp(signal_jmp_buf, c);
>> -}
>
> I see from looking later in the patch that you're factoring this out of
> the guard regions test into vm_util.c so that it can be used by your new
> test.  This is good and sensible but it's a bit surprising, especially
> since your changelog only said you were adding a new test.  It would be
> better to split this out into a separate refactoring patch that just
> does the code motion, as covered in submitting-patches.rst it's better
> if changes just do one thing.
>
>> +#include <linux/pidfd.h>
>> +#include <linux/uio.h>
>
> Does this work without 'make headers_install' for the systems that were
> affectd by missing headers?  Lorenzo mentioned that we shouldn't depend
> on that for the mm tests (I'm not enthusiastic about that approach
> myself, but if it's what mm needs).

No. “make headers_install” is still needed. I tried to get it compiled
without it but failed. It seems that a lot of files will need to be
copied to tools/include from “make headers”.

Best Regards,
Yan, Zi

