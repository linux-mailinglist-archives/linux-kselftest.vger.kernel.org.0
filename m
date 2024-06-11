Return-Path: <linux-kselftest+bounces-11647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50C902F93
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C30AB20E4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03516FF31;
	Tue, 11 Jun 2024 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H7XwR/gG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B48488;
	Tue, 11 Jun 2024 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718080521; cv=fail; b=q79ah2Ua07bMbBtvcrXhnflPZhIVxvdTPQftLJWc39NkOYgg5j366vQFNzprYv4LV94vz6SZi5pkfYDCDKJ0GKktkPciiXZuK/NaP407QvN3WZ3zSW/ZxR8bdnBcLFKzeQQnOO/XLbnqL4eufY+eYrbhC4qlgZHXuFdqvePXULk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718080521; c=relaxed/simple;
	bh=DahyltAagJHKEVySmPuVayU1+9A8z0TNv5PRr6VvY0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qnep8KMOzPHrAfS5x+QYp42CclozWT7Nk0jGEm28nzPYzyAMNkdhf5OA3t1PeTgRummNR13zYArK7/N3XbhPSZwf2YN3CZrR+4uOF/epxRc7WPi7xbFD9oW9czrYDMWsIRZMbv44JAW8lfTij1Cgt8rwuFNqfNRL0O+QabvH39M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H7XwR/gG; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8xET82TLaQXFQf4Xbbiu6RlxnzBNLAlt7EpxnGLnouKqmHEEqkyIlXJypMCCEBVjmbgYvrlLD6rqPNVg+AATUyCK8qkgeZwhXazuFokCDgm2wVK1TEUwwpeqjIA7Hme02Y/zUUOfxav8gtVl8hXhUW7Yq2mJGQIyOlezxmvCCyqRDh7QEhN0wWMbmiP/ftJgFiT50Tiv8FOeah1VvKq6UxO6CBHOMJmbt3sjrqJyXprwXCHxqdxlacDchJ8LbqOAJLbFyCrC3AYaJHJVcuncNkUWmTm+gOx6cKlLw638FSaHVxmlRubfIvhWsBE9c5FiKPGwutjPih66Tcp6xlrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXl6W6FavZYn/6QLbMn9VYV90bHuRaF+0BQN6Jv6N4U=;
 b=ayaoHLjrSs0MSmRjR+PJAWQ6OEAhZpnK6z/KkEMeRLBZED06A4ZMUjAO+zd3NdRObs0Z+eZexUKeyPjs7g3GRifaBL325RMOMFDJJtZRb/w4+OFzn6DdL9X3vYtsq9wvHUJgDq/IAOzOaXIhmox6CGqPI7VpBYbCzggvvjGkUnHwRONAdMcLVQd10qw80+zxsZXb7Nz+80bWAfKC7PwIe5oXQKzmWtOwVlsUe0+DRLdmgt4XgUR5vbA1oeDE331lEi7kwTp3QtrcFcgfo3zq1QIWnd6HGmYfPwx6nLCFakFHj7OuPEw3sAoN+xUDv9ScuOOgWp/a/ZX/D/4qz4sCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXl6W6FavZYn/6QLbMn9VYV90bHuRaF+0BQN6Jv6N4U=;
 b=H7XwR/gGmdrVqg6mIqcT8nv3ZhgWZ9sHCP2cQytSFlJZuKo5GdboZUL8UaHRQalSjSlD/J+JGrTp4Cf5sfFRDL61kueNlj3ldgDXccu6Q/1rUGjs1jl0D6w6qIZelOAVyt3JAvo03rgdxstEqny0bn97Yq5Gj7cmSIm1IN0dWszJ9gtqT+rONGp1VBwyBgC7YfP21v9B8+hPkIWW/Nt6I4U7M8+6vDX0w6WBx3GFrFAqo5FnmxJbXaUDBFvvf2VUYTkIiR8n0S3Q3EXQiVA0ghQyHK8zQgv5pgzW+4+HKD56IIKNoHfotYX5oqPmC9f7lUNaZKn0ajKp9KmPZ6S92g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 04:35:16 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::657e:28eb:3569:4f91]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::657e:28eb:3569:4f91%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 04:35:16 +0000
Message-ID: <08bd092c-5357-4c14-a52d-c234d51cd95e@nvidia.com>
Date: Mon, 10 Jun 2024 21:34:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests/mm: mseal, self_elf: rename TEST_END_CHECK
 to REPORT_TEST_PASS
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <20240608021023.176027-6-jhubbard@nvidia.com>
 <CABi2SkUnQQC4cXhwV6BN==umEFsNpFRptxMKy3bHthPUv+pXwA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CABi2SkUnQQC4cXhwV6BN==umEFsNpFRptxMKy3bHthPUv+pXwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: d1933c5d-6715-448f-d8c4-08dc89cfe443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk5GL3gyQWJFcXJ0cTNoZENmQUpFYmdkN3Z6akN2Q2hNbW5WeFVnelpBUjM3?=
 =?utf-8?B?Z2ovZlJqYkhDWEU1eTh2c0JacHM2ajNsZE9SbTBCcWZBZkgxOVdOeUdVMUVW?=
 =?utf-8?B?MmxPTm9xUitaVzFtbzFFMmt3WlZHbHpPak5STUpXOHY2bGowazRocUJSMmp3?=
 =?utf-8?B?STYvaUQyNTFCMk8rUThETFpOREVJR2ZnZUtTaU5TR3ZZRm5yK2FHbjNoUmV2?=
 =?utf-8?B?YU16TEhuZkRGRnZMZlJUQlJucXRacm42enVOWUhyK1hyQmhhc2l1WEJSK0l5?=
 =?utf-8?B?RzM2UXFNd2dkU0YwN1pJY2NWRy91MDRwSTlvSnlRb2crZkZkQjVmMCt2WVh4?=
 =?utf-8?B?NGNzSzhCSjd0YnlRdUdwU0x5aytQZ0hQV0JNbUsxYXhpTkVKOU9GbnBDVW9k?=
 =?utf-8?B?QzY2b2lxSllNLzdpdUhPcTFFQmFVSW1iMVk2VjNmK0NPK0lJWnJaQmIrT2to?=
 =?utf-8?B?MDBTK2l4WXFSU3hHNlR4VzJSWTZFRlZlYXNMT2VHZGViYU9yc2NzODdBNDRl?=
 =?utf-8?B?d0t3SDhWVTV4YXViRVFGRFB1WG9CY1cwcWhOMFpuTnJic0laSjRERlRxSk02?=
 =?utf-8?B?TCtwbmVJS2hYZyt2THlzQ09Mb1Q1aG81ZVNMcWg5VHQvalJ0dVJzQ3ZMTU5V?=
 =?utf-8?B?UUZaanNxMHFjRUVzWW5rc0JQYTRKVFR3d00xNm82WWozaFVLcGdyejRkTzho?=
 =?utf-8?B?SWtuYlBGb2w3T2ZpVk5sWjBwK2NmazlLdGo3Mzh5UzdxdTk1Mk95N0J3TXVx?=
 =?utf-8?B?R1pGYjRlSFlIaVNnOTI3ZFZIaVIyS0xlTHdvKzJCOHNnYTllSmlJRUQwMVJx?=
 =?utf-8?B?Rm40U1Ivamp4eG55VHZpYTBkQVZ5NjloNUZQK2g4S2o4M0g5enhiTnlMSm10?=
 =?utf-8?B?TVpPRTFmOW1BOVNCSXliQWdFT2J6eVhFQ01ITjlqRXRzODZUdFJSRGYwbjRt?=
 =?utf-8?B?c2J5cDVneWorS3FITjdOS1UraSt5SG16VVhIeDhZYThrYXVNcHFwM2Rzb2JQ?=
 =?utf-8?B?bGw3MDJrOFQrZE9rQ3VhV2p6YXdMdlpBazQzNmZCMWRYZFRmNGhRS2o0Vy82?=
 =?utf-8?B?RVE1cEJjTTE1UzI4TVdERDR4S0NXTkdRMW5pS1RKaUkrUlZ0bTh3Mkt1RHVW?=
 =?utf-8?B?ZTZFWHpwd1ptaUQvbE5ublBWcDB5dk1QYk5wdmR4aVZaZ2lZS09yR3k1ckZq?=
 =?utf-8?B?Uk9yTEl2SWk2ZGFXZXRoYnk2OGhkVGdyZjVXUDc4U0VXVzc1Vk81WktXRk84?=
 =?utf-8?B?ajd3OXV2d3RmV1lxb2VrelFOejBGeG5NaFpMRkFjSGVBRmFVbDNmZFduMGdr?=
 =?utf-8?B?UVl0TlFZMEJ0UnlvU25BRFhkRHd4Ry9sVThRZTF5eUVtWnc0cThBcS92R0da?=
 =?utf-8?B?b0l1RnR4VHhqSThTUUxwcmRGOUxDYWZzNk5MYTl2T0IydU1PQ1pCOXF1NFVN?=
 =?utf-8?B?Rkpzb1BjcHpKMW50ZGFZRURMRFlTTGZWbGpCWk1NUnY0WVZIRk5lTUJOUHEy?=
 =?utf-8?B?TjNEZ3U5VnA3R2VCVGJuWGxIWHU1OEJjdjR3WFMzV1pUSSswdS9KeDRZZW4r?=
 =?utf-8?B?V2Y1QzZRZmlLWXRZa1FhbUVXODZPdkUzUWZkQUlKd1I3UWd6WTFGYVV4Nnpi?=
 =?utf-8?B?aDRCQjRtNzZDeDhiRnZ1aDVhTm9Ueno3MWJ2bjJQL0FET3p0bFE3cUxEODFa?=
 =?utf-8?B?TStQNk1Kc2lvOWN6T2pweU51MUdrQXNJcmVibEM2ZWYyd3FVNHgzZlpmcHE4?=
 =?utf-8?Q?kdzbcp0otRIQx5Jd5ZrH4Wx1USvyx3JY6cc2B01?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2dXT3Q5eExFcjlGdXJvUER3ckRKS3poVGZIWVh3ZjZxVHA4dnk4d0E3VzdW?=
 =?utf-8?B?akJMakxXV1Z4N0c5b2doT0J5YVlCSUgzVEg0SFBWUWViQUVqc3hmVkV4aHc3?=
 =?utf-8?B?TGRMTVUxN29mOUswdlRQa2VWeE1hanJLWmZRTW5WckRqSlhnYVBQNXo0dUt4?=
 =?utf-8?B?THR6VU9mNCtvVlBvekxqb0UyeGdKRDJRZEtqOVVCNGlBOTZuVGlndytNNHdB?=
 =?utf-8?B?dFFheWFsMEQ5QzhKeit2NHRqcHVJRkNFdndEV2hFZHdLRG15L0ttYmhidUlX?=
 =?utf-8?B?ZDBCc1V1RHArL1FDcXRxaHBXTW8xcVRuVFluTUJveVltam40M1RmWTFFcWNs?=
 =?utf-8?B?U0hjNlJ6NXJoZ3NVRGM4eGR5TFBNWmYxdEdJMFArVGxLOFI2WEd5Q0o1S2x3?=
 =?utf-8?B?MlVjUFZsTWxrajQ3NUNHK0lwZ2FxamZ4SkVjZlFza1VOSU5nVStVcU5tcjA2?=
 =?utf-8?B?NU1pbWdOd01tQWdxMkUrRGNkWUsydXJtbG44eWFUcmdFeDhTZ0tjMTZKSzZM?=
 =?utf-8?B?SW5ZZXhWazd0bWxkWlh3c201bWRrZHJTd3dpMHp5MlBvQkZYZnJ0NmRoWWh6?=
 =?utf-8?B?cVY0cU0yM2ZyaTllOVpFRFQ5d0FhRmFRSWZUaHBRaHRsT1BFRVdHMjRjOTZl?=
 =?utf-8?B?c1ZFajN6anhpMDB2NkU5MmFHUWxWM2gyZ0s0bmlIQWREWEwrR1hVc2lMbitt?=
 =?utf-8?B?S25SZzRjL201ZzloM1BjRTNRUFh4ck5zTW9wbzM0SGIrUnh4TFFpd1hUMVVB?=
 =?utf-8?B?UFdaMWY1REtTWWNyVEdXcnlKckpuWndWNVBNWU15aHlMaGZYVXd1ZEVra2Q1?=
 =?utf-8?B?bUcyRDM4SlJnUWJwM2ptclg2a1djTWRJWlY2bEprRnM4anZmay9ueXZ6U01Q?=
 =?utf-8?B?VDhuTlMvSk9EQ2ZKQUc1SWhXT0VhaXJWN2FkLzRINlpZSnl5R0U2RWJVSmNR?=
 =?utf-8?B?S0s3WlU1ZTFWV1B5WHE2TlpFZk5WVkpsWjRVWEJOVmg4UmszbFJaY3FaWC83?=
 =?utf-8?B?dzdsNWdLVHc5QVFDR0YzSGhzTUVjamhMUWxhMW1icHNZUHp0YWtNZ3Q5R2px?=
 =?utf-8?B?TUg0U1ZmcXVReHFRdmJiT2wwVHBJbTRwVWNhdStrUFM5eFlyaXJwMjJKWWU4?=
 =?utf-8?B?S3p4SjZPLzFpNU5TOEpoTWtrV2taME9FVTgwam5XUWtjdndMT1ZyUE1RbmJN?=
 =?utf-8?B?Z0drZ1F0ZTIwbkZIeUVzaWpQMkkxQWNNeEhLUFB4enk3ODVOWGwvWTlWOTNm?=
 =?utf-8?B?YUFIampxVmdZV29yN2ZBUzVUWHptbjE1MVZ1S21HZ2ttNERNVXV3RmEvVDAw?=
 =?utf-8?B?ODBwZnhpaU9NeTNOZ2d6d3EzYmxpMHM5M0NnS0swNFV1OGhYVDUzZXk5bG5k?=
 =?utf-8?B?cy9tTmRSOHdzUmQ2NXI3eno5WXJnTU8yaklneG40TWxScWtTQ3h2WFR5L1ZR?=
 =?utf-8?B?Yi9FN2xManl0bjdaZHZpM3czWVpnWEx2LzR4MTIra1ZyYysvTEhubWY0UXBM?=
 =?utf-8?B?LytRSWJpVkZwVERNanNGdGpBQUdoZGhiUFFlR3IvZGtNRC92WldIaDBNWlNS?=
 =?utf-8?B?UmZPRkhjbmdRdW1hQ1VnL1V3VU13enExSGlqQU0rTkgrVGViRGozMVp3RlVQ?=
 =?utf-8?B?VnVrTEVMTnVTdW1sMXU3SEdIS1FHY0VMa2ZnaitjSGZHNXpNcDFVU0ZDRDRa?=
 =?utf-8?B?Z2JkdzlYQUpWRVdCSldxRGNuNm0xSENFWmxWblJTT09zT0dmQ0dNN2NQOUZY?=
 =?utf-8?B?aU1xc1J2NVUySGxaVFB6cHMzbFpCU1NQSmxCTWh0RXd0QlFpWVNWaUpRZTBJ?=
 =?utf-8?B?TEhFQ3JkUEYyUzU4M1BGRDd6Rmx2TDBkbnhhaGoxVktuTThNekZuWFNwQ0lo?=
 =?utf-8?B?NG95WHZiUE52cmlRNlhhbjhBbFF3aFNSRmM0RHpTcE16WnRBc1E5M0k0cnk3?=
 =?utf-8?B?ZkxRUG4zS2MrVmx3SzhmSTVBd3ljUkdtL1BkYzVzVFBWK21qYk9wckdWMmNF?=
 =?utf-8?B?WGxWVlZTZjlvREJ6ankwUHpBOFR5OENzblBaRVg5NTY0a0hXSnNQRTRjTHZC?=
 =?utf-8?B?NEEwQmlKanhyODhTeGpneGtPQzFEQ1pRUVN4dk12eHk1QTBOeE9vc1kvZjZt?=
 =?utf-8?B?bkFmNmtJVWE3SVRzWmdGbFZVSG9YamtYNDc1SnpFOFJOaWZhWW5zM0JHMk9q?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1933c5d-6715-448f-d8c4-08dc89cfe443
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 04:35:16.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYkm79Cz+tEHJBgk5EmZBied0IQTR2I5eB5VuySDnSLcO+RcQ1n1pxsI6D6whezOwa8E4koo183OvN5iMf8+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

On 6/10/24 9:27 PM, Jeff Xu wrote:
> Hi
> 
> On Fri, Jun 7, 2024 at 7:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Now that the test macros are factored out into their final location, and
>> simplified, it's time to rename TEST_END_CHECK to something that
>> represents its new functionality: REPORT_TEST_PASS.
>>
>> Cc: Jeff Xu <jeffxu@chromium.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Reviewed-by: Jeff Xu <jeffxu@chromium.org>
> Tested-by: Jeff Xu <jeffxu@chromium.org>
> 

Thanks for the reviews!

thanks,
-- 
John Hubbard
NVIDIA

>> ---
>>   tools/testing/selftests/mm/mseal_helpers.h |  2 +-
>>   tools/testing/selftests/mm/mseal_test.c    | 92 +++++++++++-----------
>>   tools/testing/selftests/mm/seal_elf.c      |  2 +-
>>   3 files changed, 48 insertions(+), 48 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/selftests/mm/mseal_helpers.h
>> index 8c3bf77dcf19..65ece62fdd0c 100644
>> --- a/tools/testing/selftests/mm/mseal_helpers.h
>> +++ b/tools/testing/selftests/mm/mseal_helpers.h
>> @@ -22,7 +22,7 @@
>>                  }                                                       \
>>          } while (0)
>>
>> -#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
>> +#define REPORT_TEST_PASS() ksft_test_result_pass("%s\n", __func__)
>>
>>   #ifndef PKEY_DISABLE_ACCESS
>>   #define PKEY_DISABLE_ACCESS    0x1
>> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
>> index a29935d82027..f8e1c59f298e 100644
>> --- a/tools/testing/selftests/mm/mseal_test.c
>> +++ b/tools/testing/selftests/mm/mseal_test.c
>> @@ -240,7 +240,7 @@ static void test_seal_addseal(void)
>>          ret = sys_mseal(ptr, size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_unmapped_start(void)
>> @@ -268,7 +268,7 @@ static void test_seal_unmapped_start(void)
>>          ret = sys_mseal(ptr + 2 * page_size, 2 * page_size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_unmapped_middle(void)
>> @@ -300,7 +300,7 @@ static void test_seal_unmapped_middle(void)
>>          ret = sys_mseal(ptr + 3 * page_size, page_size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_unmapped_end(void)
>> @@ -329,7 +329,7 @@ static void test_seal_unmapped_end(void)
>>          ret = sys_mseal(ptr, 2 * page_size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_multiple_vmas(void)
>> @@ -360,7 +360,7 @@ static void test_seal_multiple_vmas(void)
>>          ret = sys_mseal(ptr, size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_split_start(void)
>> @@ -385,7 +385,7 @@ static void test_seal_split_start(void)
>>          ret = sys_mseal(ptr + page_size, 3 * page_size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_split_end(void)
>> @@ -410,7 +410,7 @@ static void test_seal_split_end(void)
>>          ret = sys_mseal(ptr, 3 * page_size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_invalid_input(void)
>> @@ -445,7 +445,7 @@ static void test_seal_invalid_input(void)
>>          ret = sys_mseal(ptr - page_size, 5 * page_size);
>>          FAIL_TEST_IF_FALSE(ret < 0);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_zero_length(void)
>> @@ -469,7 +469,7 @@ static void test_seal_zero_length(void)
>>          ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_zero_address(void)
>> @@ -495,7 +495,7 @@ static void test_seal_zero_address(void)
>>          ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
>>          FAIL_TEST_IF_FALSE(ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_twice(void)
>> @@ -515,7 +515,7 @@ static void test_seal_twice(void)
>>          ret = sys_mseal(ptr, size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect(bool seal)
>> @@ -539,7 +539,7 @@ static void test_seal_mprotect(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_start_mprotect(bool seal)
>> @@ -569,7 +569,7 @@ static void test_seal_start_mprotect(bool seal)
>>                          PROT_READ | PROT_WRITE);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_end_mprotect(bool seal)
>> @@ -599,7 +599,7 @@ static void test_seal_end_mprotect(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_unalign_len(bool seal)
>> @@ -628,7 +628,7 @@ static void test_seal_mprotect_unalign_len(bool seal)
>>                          PROT_READ | PROT_WRITE);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_unalign_len_variant_2(bool seal)
>> @@ -656,7 +656,7 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
>>                          PROT_READ | PROT_WRITE);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_two_vma(bool seal)
>> @@ -691,7 +691,7 @@ static void test_seal_mprotect_two_vma(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_two_vma_with_split(bool seal)
>> @@ -738,7 +738,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
>>                          PROT_READ | PROT_WRITE);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_partial_mprotect(bool seal)
>> @@ -764,7 +764,7 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_two_vma_with_gap(bool seal)
>> @@ -807,7 +807,7 @@ static void test_seal_mprotect_two_vma_with_gap(bool seal)
>>          ret = sys_mprotect(ptr + 3 * page_size, page_size, PROT_READ);
>>          FAIL_TEST_IF_FALSE(ret == 0);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_split(bool seal)
>> @@ -844,7 +844,7 @@ static void test_seal_mprotect_split(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mprotect_merge(bool seal)
>> @@ -878,7 +878,7 @@ static void test_seal_mprotect_merge(bool seal)
>>          ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
>>          FAIL_TEST_IF_FALSE(ret == 0);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_munmap(bool seal)
>> @@ -903,7 +903,7 @@ static void test_seal_munmap(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   /*
>> @@ -943,7 +943,7 @@ static void test_seal_munmap_two_vma(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   /*
>> @@ -981,7 +981,7 @@ static void test_seal_munmap_vma_with_gap(bool seal)
>>          ret = sys_munmap(ptr, size);
>>          FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_munmap_start_freed(bool seal)
>> @@ -1021,7 +1021,7 @@ static void test_munmap_start_freed(bool seal)
>>                  FAIL_TEST_IF_FALSE(size == 0);
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_munmap_end_freed(bool seal)
>> @@ -1051,7 +1051,7 @@ static void test_munmap_end_freed(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_munmap_middle_freed(bool seal)
>> @@ -1095,7 +1095,7 @@ static void test_munmap_middle_freed(bool seal)
>>                  FAIL_TEST_IF_FALSE(size == 0);
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_shrink(bool seal)
>> @@ -1124,7 +1124,7 @@ static void test_seal_mremap_shrink(bool seal)
>>
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_expand(bool seal)
>> @@ -1156,7 +1156,7 @@ static void test_seal_mremap_expand(bool seal)
>>
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_move(bool seal)
>> @@ -1189,7 +1189,7 @@ static void test_seal_mremap_move(bool seal)
>>
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mmap_overwrite_prot(bool seal)
>> @@ -1217,7 +1217,7 @@ static void test_seal_mmap_overwrite_prot(bool seal)
>>          } else
>>                  FAIL_TEST_IF_FALSE(ret2 == ptr);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mmap_expand(bool seal)
>> @@ -1248,7 +1248,7 @@ static void test_seal_mmap_expand(bool seal)
>>          } else
>>                  FAIL_TEST_IF_FALSE(ret2 == ptr);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mmap_shrink(bool seal)
>> @@ -1276,7 +1276,7 @@ static void test_seal_mmap_shrink(bool seal)
>>          } else
>>                  FAIL_TEST_IF_FALSE(ret2 == ptr);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_shrink_fixed(bool seal)
>> @@ -1307,7 +1307,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
>>          } else
>>                  FAIL_TEST_IF_FALSE(ret2 == newAddr);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_expand_fixed(bool seal)
>> @@ -1338,7 +1338,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
>>          } else
>>                  FAIL_TEST_IF_FALSE(ret2 == newAddr);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_move_fixed(bool seal)
>> @@ -1368,7 +1368,7 @@ static void test_seal_mremap_move_fixed(bool seal)
>>          } else
>>                  FAIL_TEST_IF_FALSE(ret2 == newAddr);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_move_fixed_zero(bool seal)
>> @@ -1400,7 +1400,7 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
>>
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_move_dontunmap(bool seal)
>> @@ -1429,7 +1429,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
>>
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
>> @@ -1463,7 +1463,7 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
>>
>>          }
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>
>> @@ -1556,7 +1556,7 @@ static void test_seal_merge_and_split(void)
>>          FAIL_TEST_IF_FALSE(size ==  22 * page_size);
>>          FAIL_TEST_IF_FALSE(prot == 0x4);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_discard_ro_anon_on_rw(bool seal)
>> @@ -1585,7 +1585,7 @@ static void test_seal_discard_ro_anon_on_rw(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_discard_ro_anon_on_pkey(bool seal)
>> @@ -1632,7 +1632,7 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_discard_ro_anon_on_filebacked(bool seal)
>> @@ -1669,7 +1669,7 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
>>                  FAIL_TEST_IF_FALSE(!ret);
>>          close(fd);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_discard_ro_anon_on_shared(bool seal)
>> @@ -1698,7 +1698,7 @@ static void test_seal_discard_ro_anon_on_shared(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   static void test_seal_discard_ro_anon(bool seal)
>> @@ -1728,7 +1728,7 @@ static void test_seal_discard_ro_anon(bool seal)
>>          else
>>                  FAIL_TEST_IF_FALSE(!ret);
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   int main(int argc, char **argv)
>> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
>> index 0fd129259647..131fc13cd422 100644
>> --- a/tools/testing/selftests/mm/seal_elf.c
>> +++ b/tools/testing/selftests/mm/seal_elf.c
>> @@ -127,7 +127,7 @@ static void test_seal_elf(void)
>>          FAIL_TEST_IF_FALSE(ret < 0);
>>          ksft_print_msg("somestr is sealed, mprotect is rejected\n");
>>
>> -       TEST_END_CHECK();
>> +       REPORT_TEST_PASS();
>>   }
>>
>>   int main(int argc, char **argv)
>> --
>> 2.45.2
>>



