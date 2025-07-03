Return-Path: <linux-kselftest+bounces-36451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038FAF78C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3E4871A7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072BE2EE996;
	Thu,  3 Jul 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="atBALGZ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F522E7BBF;
	Thu,  3 Jul 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554360; cv=fail; b=Qbc8qDD/daach2w1XYG5Q+4qq09z9pXFTR5fHT2LnRxWn+c0GtzZfjn9TZ15o+4n9qn4AJhOWBWiq9+LW2hX14jXMcsCvRlTSHF53jOCY9Z75lqLwcDR8qR2ZipHBrG0314Jrq3Oq30Gn2mOj8QRAxksAzii5edS1j7AcpkblpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554360; c=relaxed/simple;
	bh=BX614zNm/ZxvET97otfBIoJBLziOLwvRcoWXDYMFAns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+EUo4E3y1CvZugsP5PMA+T5H+zg71AeustQ+qjgHNwSkAX0xYx7Qx6tzTlSGdI1ogFXEw4F17aA+nNYiD281KJnnGPhucfmopAW3d64aKm8Ev7oosF3PKQjPY1BaaX5wgFJR/cPX/DmZ8ve/CG31cBixR3Pf56GwFvOc7VdXpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=atBALGZ+; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6Y+wgFIuemcv1nls9DZENolykC5CLBENM+6Dz2CCe96ImiXwrsDod1dAuZUKGy1QamIJyYTsVqREijIFuQNIJn03mbheindk0SqMpkSB9rRvIdYgChqqNj4iXtVA7Wsv2zsHALdvzXmEc60wehZVxr9+gu6KALDpW5nHFj8bCAHpUGXXtf3MNkxdak5pqwWi3y7xP0Dq0USEMY+mDTufdZsqsAycPLPcQcUr+r6lEz9P1BGdwTfqBvv+gMkQWVW77zNjmF3W1zLB9VYYJ6f0FWfo+jN8Go+hEFpJjWvEOQcB7Whl/qeT8+tsLnC9STSRTo8mE6zwx05Iv+kYLT4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MU8mG7qC+mz9cA1WhCyaxGJM9JDklOwSIVijGPGkd4=;
 b=cZGxYQskCLPF61Hjzzo/tqglxtM3Cu7nNWHVf0E6oIaMaymz5bGQ53ARPDM2ST9D0OdUEiyXdNZH38606Y1+/npwg1yCBWw58wSKottBMSu03g/w+5M8ahJlcDVZ/nFvD9gO1QGax7Ta9Ae/KCngyat2cgTnWnGFfuYqX+W3cAiRTzbpHRrXZIUFqlE7n2lBbNjlyLIUWG8GVkCI3DVnymhKHWSu6yZuh+buBxQcozgF+Y14XHWUFUjs0AFkx2CjJdcYQy+crVfa0fTw8RAadUgEmaEr3IAgiWG2NQdAOID+RU7lF+9nQyPZWI5UKk9j7RSS+V5lwjCGJEsqdpKk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MU8mG7qC+mz9cA1WhCyaxGJM9JDklOwSIVijGPGkd4=;
 b=atBALGZ+OsprpmGmmBCkGP8TdwI4GqnZA6JXTi07wwb2mvxcN6It12b+DTH68O1b2q1nTmCc4LZUEdI8LAF9ot/asD57RJkZcdFxD02mV1vHPPDN3IOi+jMB1Z5zuhLU5P1RWqubzRelLHmW637xpPkxXjnusAxOS7UM7KYE+BB5HYf5c9z/tf/8GSCMxgJcDlRjlqK3UratZiiAVufyVFoyJfG+hCyMR9jQpjM2RivLv2pu7Q4OUdeoUqyAH2JDndI9VPnB1UKHhoO57MJLBuz3uPhAyppl/UPptufjGablYokU+uTmO5f3bXZgcGMcwg9YO1Sic69fN9454f3+/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Thu, 3 Jul 2025 14:52:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:52:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v2 7/7] selftests/mm: Skip hugepage-mremap test if
 userfaultfd unavailable
Date: Thu, 03 Jul 2025 10:52:31 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <4D78BC13-74C9-4570-A81B-B7094B16A336@nvidia.com>
In-Reply-To: <d6ded113-2fab-45a1-94dc-5cde0c9f9006@redhat.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-8-aboorvad@linux.ibm.com>
 <d6ded113-2fab-45a1-94dc-5cde0c9f9006@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:335::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 2947e06d-4794-4906-8494-08ddba413ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZThsRlBaNW85WEwyNWZ6TnBkOUdUUVIrL3hFa01ZL0krVWF1dExSK3V2Ymtn?=
 =?utf-8?B?TjIzNkxvNHVlRTFiUjc2YXY5dUhmRVArT0tvQVJIRzF1dHNzQmM2ZlZraUYv?=
 =?utf-8?B?em1ZVWdoem1ybm84NmdORVFWSi9ER3VhK21jb3Vvb2pkd1NkekxrbUJwRWds?=
 =?utf-8?B?cFF5ams4QVZ2TkJ1OTQyTC9wQk42OUNUc2pqUEV6RHNhMElPMk1Ya3RSeWkz?=
 =?utf-8?B?eERrUGhVcVN2UHp6aW50SnNNSzNYRWVxa09NcWdZeC9WVDVrbzFtUURIeVFH?=
 =?utf-8?B?Nmg0aFNVQUMyZjdZR1dpWitGWmhGL0d0QTFVMkpTNC9HWkx6OEc4eTFrYnQz?=
 =?utf-8?B?d3c2UW9wQWwwSUd5UGZDYkJNa1o4SXBhWVBLWFdTclVQb0wyaFViNVZjZzhY?=
 =?utf-8?B?MVg0MkpmNHE0ckxjZmZMWGVpM3QrbElqT2E0bkNKRDNhaktiUjcwOHZyWXhs?=
 =?utf-8?B?WktnUE1YYnJ5NTBpZG9MNzVVakFGMjRyVDNORncwZjdQOXU2VUsxUFZwUkx1?=
 =?utf-8?B?WHVSZm5tN3dNNk4rMlBwaEdPMFkvb3FHbG5FNFVNOEltWVpma1dBOWdHcmU1?=
 =?utf-8?B?c2Z5WGZnRndsTWM0bXRHdkZHUEttMkFUTW1mWWpGbDJXSFFGdk1zQ1o1TjJy?=
 =?utf-8?B?VEw1Yml3UjNXWGMxWGUzYnM0dDNtMUM5TFo5VkZFSzhSTlcyZFNuLzhiWEh2?=
 =?utf-8?B?dHRCb25XSXJKdVpmM05uZGNYV3l0Y3pWRXZBejR2MmxhKytlTHBRSjZVN3Mw?=
 =?utf-8?B?TUc3ZGYrM2M5SFk5Z0F5c3A0T0xuWnNjY3ltVFYwZEtIdzVzT2pIcVFVZEMz?=
 =?utf-8?B?TXo1ektxMEtYNzhRQXNDM2hzU3FiUGMyZGdYZWc0U0xJYjBRd29Vc2tXMDh0?=
 =?utf-8?B?NzlmNGE4ZHpXU2x5UFBEcDF5UnZHWDNsSzM4UVI2dDhZK25rOWRuZ1lpNGlN?=
 =?utf-8?B?RWFNdUgxcWJ2UzhwZWx6STM2REl5ZVlHTFk1L3VqcjhWM1JMc09JS2ZoYUN5?=
 =?utf-8?B?aUlGdU94WDdMSU44eS9jditub0VHbWROc2VnQWxIME1vVmhpTURCczdGTXZl?=
 =?utf-8?B?a0lvc0k4dVFHZXRraHJPWERDdlBFdEZsUGJXZFRXQ2pPYkh4SzRuQ0RVdU9p?=
 =?utf-8?B?QjFIYVo3emwrdmhNcW9qRjBXczlBRFFWbGxsK0pCM0RKRlQrbUwyd0IwZjEr?=
 =?utf-8?B?OUZsZXhCWmxCOUREVFc0WTJaZlZRTXh4ODVYdmp1UmZHNzI2cmZsZVVGYmpq?=
 =?utf-8?B?UXdjYndXZkJzenZyT3pJZ21IcWZkc2lJY1lUMkZaaSs3T3BGYUhsZEVNYXNn?=
 =?utf-8?B?bW1Cb3pQbFJyVFhUeVFQTzFMcDFaT1FyeDRKNUxCdTlOTC9LYTE5emdZVjdV?=
 =?utf-8?B?TmVMWHl2WDJzOVgwWFo4c2xhbVNYUGNCRGNDWVJrNWtuSitCOENvMUxtMmZz?=
 =?utf-8?B?Z3loTm85Y2xiOERoS09tMlVvdTlpMTlMbmlpK2JuNjlvNkRaS0NkVGJPR0hB?=
 =?utf-8?B?cTE3WjV5WWJVQk4xL3JmMXh3WWtyUlVaVmlVL2l1TUE0U2VjMFNvcmZlMEt0?=
 =?utf-8?B?akFsOVVZbURrZmZxMWxGK2V6UjNHMTZueXMvRUtSdUVLYkNGMHliK0duOWlB?=
 =?utf-8?B?YW1RRmE4dVgySHAzRHZvRG1pRzJJK3drUUkvaWR5S2ZRWmtUTVI4elE5QVVl?=
 =?utf-8?B?R3UyUjEvK2krUytIaFpwWXlTZVRmWFBFdEJ5T3dQSzZoa2MvTCtVcllkQUll?=
 =?utf-8?B?L01XTWwySFRvcnUzblVra25VdlRNRGJoS1M3dHNjZlIzUUU1ekZRSmpIN1cr?=
 =?utf-8?B?K3BkN2QyQnpGU0xsOVBMR1JIV0ZLeVdCa0Vrd0NvN1BaNzBqYTcvdUFQdWRQ?=
 =?utf-8?B?N2hBeUUvVlJzdnBTWG5TV25oOTJ5SXJNaUlKc3hUbkErTXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHFOcm1rZVhneUphMFdFZWwyb0FuaFBKa0k3a0FWR2I3c0tQaGk1bkJhSHVs?=
 =?utf-8?B?M29GWXVTdW5jVmxnYUFWNHhHNUNqQVdKL3R1eDBnemVvL1Ixc0E2SFl2bTNU?=
 =?utf-8?B?WUN1TjdYUDVqQitDWHNsbHdCYmhReC90cmxqbUtDbU1lcngxczkzVVo3R2dZ?=
 =?utf-8?B?MCtLTG5XSGJHNHVXeTkybEZBK2xOeHUvRlc1TkIwTEZ0ci81OCt1MnZBNVVx?=
 =?utf-8?B?Y1k0ZjRwWkVXUWNsdDhEL21Nb29BZnRLb0FSWlBzQ0JnWDFhUEJBKzV0NXZp?=
 =?utf-8?B?a2h6ZG1mSjlzbElaaFNmYTRhMW5mR0xqQytKanNyRXhzWXJlRHE0WU4xMEFH?=
 =?utf-8?B?ZHNXcERkV2RPTEhmNHd0alIwRG0wZXVNMEcvYzU0aWg5c3M4RVNHL1ZhVktt?=
 =?utf-8?B?eHh0eUhJa1F1ekZ0ZFh4UlNXQ1VrRUxVM3JnYytJN0dZS1l6T2NWRHNKN2ZQ?=
 =?utf-8?B?QlcxWTMrSkk2UG90UWNCNmhtcFYvMG1GM1I0aFUxaURoMHpYT005aVlEK0pj?=
 =?utf-8?B?b2dqTGJNOHBkbUFKdmhsRFJHT0J3ZlpaWDVoczZta09ZSFl0WkRjTXRXUzBK?=
 =?utf-8?B?MmNlN2xYR1pOd1NFVjVyc3Y4TjBpdFpuMVd3ajA0b2hXWnJMYnU3Qy96YWU2?=
 =?utf-8?B?TTZWbXFCYlpxWTVXdGpQeWs1bGdONllIa3NxcW1GdVFFdlNIMWpnRFhXZCsx?=
 =?utf-8?B?USt1a3VjSDI3WG52QkZic0RWQ2oyVTdKU3V5VVJzOTdjNk5xbEFyd25YT29X?=
 =?utf-8?B?SitEcnJyMWVBcEw4cHFXejljSGFGdU40S1J4TkNva1hPRDNQYTRqNlRLT2Q2?=
 =?utf-8?B?UEFnQmNvUFh3V085Nk0zTW9iWkk0ZWVQcnBSV0M3bDFtRG1yZmJMMklXSkNY?=
 =?utf-8?B?ZTE5eTZib1EvZzdnN1Q2NVpoS0JQQlozUmgyTElQRE10Szh2YktYc0orTzdU?=
 =?utf-8?B?K3d6MXpZYUpaWVI5bDZ0ak1xbjBablJJUXRCRUpYeEJCekN5NE8wSkFiUXRS?=
 =?utf-8?B?cWpuN1A2QmV1OFFzSVVZYjlYR1VjVEFEeEs0MW5SYVFOQWxRYmxGOStaUTdZ?=
 =?utf-8?B?ZHVLeEh1YzJMUFNtcC8vTGlJNXJWTjcxUjlUdE5VWjYyUHRyazJxWFRWSlBU?=
 =?utf-8?B?TFFuM08xMHhYWm82Qm9wZ2tXQ1hCeGZjY2M5dkhRQmpWODVIRmErZ0duWldv?=
 =?utf-8?B?MWdWK0hQbGxQc3BQRTVEd0xOWEdhSCtvS3d3aloyczczdmswb3BxbnBiWXpD?=
 =?utf-8?B?Q0FSZXhnVk9xMkhMUCt0ZWt0UVQvcUtaVFVRSzVNWk83S0ZLR1RRcHFjSldw?=
 =?utf-8?B?TjRhNDhrOGgyeWtqMDEzZGJYNklZUjdQVEphUmh2bW04QlhtVEllNURmNlBo?=
 =?utf-8?B?RDJqdTdqYU5ZRk1yNzJoNVRQT1REenNqblBHMW9DeUgwbnd1c2xIMUM2MHBG?=
 =?utf-8?B?bmE4UkxVbEJ1c3V0ZnZ3MVhBR0NnZGczcGVEWHJTc0svbC9kU21pWjFCdUlH?=
 =?utf-8?B?RXpsRG4zVFVtNlJwVTMvcHhvU2E4SzRDVXBmT0RUR3loVldDc1BRNlZySXkw?=
 =?utf-8?B?OUFhb0dPUS9iOThUVVAvRlBzeGFUTjJQc1h2VEttZG9JZ09heHdkT1c2QkVy?=
 =?utf-8?B?WENjTTZablZkMnR1U1RQb291MkNGZW4zY2xGZDhLOHlGNlY3SmtwZ0RlU2gv?=
 =?utf-8?B?VlRnK1NYdS8vcnBKWGlRYXVlOXpTZ2IybmxXcDFwRGRIQWF5dzZhU05HLzdK?=
 =?utf-8?B?YXd5ZmIrNUJLTUwrVUp3TkdkcWxCbDRDTEpzTjRtMDVDK0o0UThicWV0UjFu?=
 =?utf-8?B?N1RRMDIyNXhNY2R1VG1NeURxeE5hZWlOdEZzdTJNdm8xbFgyc0FlOVZsT0s3?=
 =?utf-8?B?NzRhV3VHckF5NWxBbTVsRjJ0WEdhRS9pck5ycUFFSTZYazRBb2NZcXp5azZS?=
 =?utf-8?B?RTNDczE1Rm1VcEphWWVOQUNNMVlGbVE4YzhRMG9Wdkcvd1htOE5PY3YzZ3gv?=
 =?utf-8?B?dkdOVmdIWDY0M0RybTFnZXhhUnRYbGZVL20zRndwUFoxdysvY01pWURtVys3?=
 =?utf-8?B?RFYrWXNmc2VZSTEvdmU5cjVYUjVkTzdXN0gyMUpzWVhzUFNOdnJyV1U3bjJF?=
 =?utf-8?Q?HVLC1ldb0QMGR4iOkI4zyTmj/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2947e06d-4794-4906-8494-08ddba413ebb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:52:34.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02506+4Ib0zrh8W8SDqGpObvzDPdkgxWYy+ozzB4hPxK8+KsXKMxVuzAeaEbtvjj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

On 3 Jul 2025, at 4:38, David Hildenbrand wrote:

> On 03.07.25 08:06, Aboorva Devarajan wrote:
>> Gracefully skip test if userfaultfd is not supported (ENOSYS) or not
>> permitted (EPERM), instead of failing. This avoids misleading failures
>> with clear skip messages.
>> --------------
>> Before Patch
>> --------------
>> ~ running ./hugepage-mremap
>> ...
>> ~ Bail out! userfaultfd: Function not implemented
>> ~ Planned tests !=3D run tests (1 !=3D 0)
>> ~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>> ~ [FAIL]
>> not ok 4 hugepage-mremap # exit=3D1
>>
>> --------------
>> After Patch
>> --------------
>> ~ running ./hugepage-mremap
>> ...
>> ~ ok 2 # SKIP userfaultfd is not supported/not enabled.
>> ~ 1 skipped test(s) detected.
>> ~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>> ~ [SKIP]
>> ok 4 hugepage-mremap # SKIP
>>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>>   tools/testing/selftests/mm/hugepage-mremap.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testin=
g/selftests/mm/hugepage-mremap.c
>> index c463d1c09c9b..1a0e6dd87578 100644
>> --- a/tools/testing/selftests/mm/hugepage-mremap.c
>> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
>> @@ -65,10 +65,20 @@ static void register_region_with_uffd(char *addr, si=
ze_t len)
>>   	struct uffdio_api uffdio_api;
>>    	/* Create and enable userfaultfd object. */
>> -
>>   	uffd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>> -	if (uffd =3D=3D -1)
>> -		ksft_exit_fail_msg("userfaultfd: %s\n", strerror(errno));
>> +	if (uffd =3D=3D -1) {
>> +		switch (errno) {
>> +		case EPERM:
>> +			ksft_exit_skip("No userfaultfd permissions, try running as root.\n")=
;
>
> "Insufficient permissions, try ..." ?
>
>> +			break;
>> +		case ENOSYS:
>> +			ksft_exit_skip("userfaultfd is not supported/not enabled.\n");
>> +			break;
>
> Note that we have in tools/testing/selftests/mm/config
>
> 	CONFIG_USERFAULTFD=3Dy

I added the same fix to guard-regions.c since I did not know the config
file existed.

And from git history, I learnt that I could use the command below to merge
these config to my local config:
=E2=80=9C./scripts/kconfig/merge_config.sh .config tools/testing/selftests/=
xxx/config=E2=80=9D

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

