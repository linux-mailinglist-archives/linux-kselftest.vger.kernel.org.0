Return-Path: <linux-kselftest+bounces-13078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C448E924842
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 21:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E0BB2793A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BA1CE0AF;
	Tue,  2 Jul 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4gPI8WY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA781CCCD7;
	Tue,  2 Jul 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948318; cv=fail; b=Q1Oo77fMls/Yj6fpOJUcigZTjMYKu1Z0XQno2f9JiWFVsbWZ7IyAkR49v5VuXUFnPHhDnQaaZ+/ExtYrEwpFDnUWFdI/ekYskkVz0vTrtXvQWxlN1qQVgxhC+8EilL4ijoMRmwSECyaGj+GM+FXymQ2pzj0Nkb6f7q23tBgrUNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948318; c=relaxed/simple;
	bh=popCVlFtuZmNetK7yUn8DES61Ygzj+NzaBjzz5B+Wko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f4SetD7UCIQ7fmBFdX7+ER5m++Xnd2zwG4z7/raTrWUpKxnIlpwRp+bPshdWobzYlR9tAsOJ4l7nrPuvwFZxQhKLk+OGyPuKDV+3Pc5prVQa9SnPUBUT9jwRqrOEqM3MN3Jybuak3eWko0FvHlisYcTDRLbc0szB+e715ewy88s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4gPI8WY; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5sXFQP1C24ikj1vhzluKYH9nN/CtFTd7CH15yJ7u2ov30XANoCLVpitHsEslwKxFKWQ6LzdEC8bG1ZD1Wj+h2004veatQbdxi53YfnL54kP7JmXZI2LrLx77W9WOneySZtnIv83hFPkaWJlgQbl7MlWyAstom3B2UllZI6kL0q7VWoZa/BUdqkativbNK1a//5dvoH8WqULLLuokPq5Pcx32MdrfeoT5nD0Uwf418bQ5spC+qLbeeqDxRS0u68shlTCGgonKn9obqePFUcnfjSuQp9XTWfBIfTp4zx0qeTx1vU8wkOdEVxzboezNBWBfWjHyPAUQYEdQ9sZ7fh3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aNIHRp0Np8QZ0s8Brw1FplXKoeb7qOeqUOlIRwt1d4=;
 b=fUd6AJ7gPuT82tYMxEERMeaduoL7mQ3xk4EFW6d+h4XSGHTjLmSwUjaAW1s3jTeLZ1biR6ilFDzARp3NvBmRyBVQ54uHPUZ+yQwIH8Lo3RCkw4STt/DClAVsYWjJ26hC8wgJ5Be2CU3d9KxYHoS1dQJ8uB697Z76BYpZHlxq8ywcIr039x8kF63zfC8hsGghu+IUn3lkB5T1S0cwvrtgOO4zymPA23dBghBcvz2Ad9DJ+TNRYjKR32ugFjXP+jNeoRpB9Z6aoyIeRL73+x+CDJTzNzxirW9vKKhiP45iOqvnpWrugdAl+SkfzvFtDCIT+ZqOpGbjjajLXnzHdcIg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aNIHRp0Np8QZ0s8Brw1FplXKoeb7qOeqUOlIRwt1d4=;
 b=Y4gPI8WYlrzw/IELIolr2E7YiceVPO5ip6mScCQucZIzPiI1x/J4QrtWzgWaU4PWbPN+vNvh54ZiNH0RUbDpgQ/FCRRKNieD63dB9btHeYcITweEnAnI9va/DnRcFPkIOxhDqtYQXoCRWJ9uMaEwpOxlPKO50YN1+W1SsXFdVNanvyJuTaE96LotSijr7MmNhRPJSNzJXI9nFNpDpzQazHKrzcZ5Hw7ruL8Oqdtzd18qgsLteK4EVqr24ZdwFOaNtuVXj/HTQflMzPiu7xGMBOk7vwhmYV+31he/EK3ixHVIFHEAZttVY7WWk9s9Qc9TQY+HSHiEqdFUuh/eQvQzCA==
Received: from DM5PR07CA0116.namprd07.prod.outlook.com (2603:10b6:4:ae::45) by
 BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.23; Tue, 2 Jul 2024 19:25:13 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::4) by DM5PR07CA0116.outlook.office365.com
 (2603:10b6:4:ae::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 19:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:25:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 12:24:57 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 12:24:56 -0700
Message-ID: <779d0e08-216a-45e9-991a-80a7ec23280d@nvidia.com>
Date: Tue, 2 Jul 2024 12:24:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] selftests/vDSO: fix clang build errors and
 warnings
To: Edward Liaw <edliaw@google.com>
CC: Shuah Khan <shuah@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>, Mark Brown <broonie@kernel.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, Colin Ian King
	<colin.i.king@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Carlos Llamas <cmllamas@google.com>, "Muhammad Usama
 Anjum" <usama.anjum@collabora.com>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
 <20240614233105.265009-2-jhubbard@nvidia.com>
 <CAG4es9WQOOga8Oh9BOjr_JXy5gcUzVN0iTtfjN_HVdRj7_G7iQ@mail.gmail.com>
 <b4720a40-6e74-4b1d-93ca-a3444e400a1a@nvidia.com>
 <CAG4es9V4EiVBi08X7xNrEpCd5eUum1-5DrYV7+52BB=OP_4DKA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAG4es9V4EiVBi08X7xNrEpCd5eUum1-5DrYV7+52BB=OP_4DKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: b43e99d9-edd0-4c3d-0eca-08dc9accb209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2VmQVV2dWNUSWUxR2F2cDA3QmtUTnFaRlVjekxGcS9TbjBLMkRrYU1aUVVJ?=
 =?utf-8?B?RGptQkd5UG00bEZpSmRCcHlpSExDcDVtRHhCTHB5bFFwRVpYRjQzWHJoZE9N?=
 =?utf-8?B?TUV3b3o5MktwY1JVSGwwMEhITUVTL2ViN2tIcFpBSS9jSDc3TjZnUGNESS8x?=
 =?utf-8?B?Y0NhcS91eW5iVkJYalB6ajJUZXNuK0gzWWpsc1psTTNmVEFiSnNZL3ltRTdO?=
 =?utf-8?B?bVF4VXhFTlJKMkF2V2h2eFk0eVhZRlZoWm1yd3NEUFJiaXFaVjlpem0yVHUw?=
 =?utf-8?B?Uld6S0NtTC93aEhsdUJJU3ZHdGxoTXRTN29YVkRPc0dlRVg2SVRmN01SSWZR?=
 =?utf-8?B?emN6aC9zZkpUQTZWM2Nxdm5qcHRmN0RuaXFGVGNOcGtTcTF2alQ2akJhQ0xZ?=
 =?utf-8?B?bmROSkJNU0hqY1NaT3N5VlViUXBzNGRJbTUvamV0bDJIUitRSUdxcERDZlpV?=
 =?utf-8?B?VFFnVEViQUZRV3hGZ0tnYzZKV1owMG9ON01tMkVzRmR6VkZMc3hRVGozOUkx?=
 =?utf-8?B?UDlhYi9ncFJTeWV2RDU1cVFRcW92WlBUVER2a05BMmFoOElLUkdSSVRXTVNr?=
 =?utf-8?B?YVRWNkZmTUNMRW43SVZIWjBlaU1JalBiRW1Vc00vSXovbnVGTjZJUzdNaTU2?=
 =?utf-8?B?RmNUN0RVR0tNdU9uYWVUVURpb3RYVG0vcGQzcjArWjEwaWJDZEZIOU1Ba21Q?=
 =?utf-8?B?RlR3ZmN6dWIzRG05OUJYMHAvUUlIeGtjd28yampKSCs3R01uYURCUmtwZ0lC?=
 =?utf-8?B?WHgxcTkzZmNmREphd1Z5cGE2TWFwZ05uRThWMk9VVytaaVZod0FOUFNKdUd6?=
 =?utf-8?B?aDVlb2p4SDF0WmhRU1pEWGdpa0s2dDBnUDloZzY1N1NZRE1IR0hxTlRpNHRQ?=
 =?utf-8?B?cEUyWUVVY0VCbzUvMC96TkVNbmVWdUhFUDd2eU9LK3FhS2xhbnBJMFhXaUh0?=
 =?utf-8?B?QnQzQmNlRFhlZGhPd0t6c01xSXVTRTBiNXFzSFlnVU9YUXRxNjAvQzVZQTkx?=
 =?utf-8?B?U29qYXdiMU1PZ3dwMUVXS3VNNWNRVjJXSFM2N3JTRHp4ZGRYbGd6NDR6UElU?=
 =?utf-8?B?KzZtSUNidGNzVURlRHEzaVVLVTBGc3dtcXpseEN3eVpWdVRqak5WaGFvVHV4?=
 =?utf-8?B?RVNMY1ozTWZEN3J4a3FnL21iR2N2ank1TjRseUpmc2lBb2hBZHJYYlVQR1R1?=
 =?utf-8?B?eFJySWhESStkaXRUeVA2TXpwYmh0UTQwaHgvQjFBY3lZczc4UlBGZEZncGlB?=
 =?utf-8?B?cG5FV0JIc1VhQWlJSkR1WkFIYWUxbWZqdGljMDZndE5kMkQ1aEZ5cktYREZZ?=
 =?utf-8?B?U1BWSERyQ1FOLy9od1k4VXpYZ0J1SkxCbm02bDd5MlgrYm8yUkJjKzJnajFp?=
 =?utf-8?B?RXQzOUFIb3ZzaWdHblpmeHpzalhBZ3N4UEUzbWtQN09PYmNvYmxraVJ6Skc4?=
 =?utf-8?B?S05GU3NXZEZBeDdkcTRuUXQySzRNNllRZkRCcldUSld2T0xaT20vQVBudnlW?=
 =?utf-8?B?eFVBVlBxRDBiRXFNUG5FQzVTNGdZL2lVcXd3cHpkUzFhQ3VRalczTFYxLzBX?=
 =?utf-8?B?OUo5OGQrc1Z5RG9aZE9Sb25JRjZaeUNJRGt2OVFrNHE1M29nbmRDZk44eGY0?=
 =?utf-8?B?N0t0enRycTZtbm9SNWszdVFnNXNVT09KK2pJS3hzSDRqcE9hbGFQK3NGbnAx?=
 =?utf-8?B?ckIzQ2dMR0s5NGlvS0t3TTBmMEpkZ25lakhtSk40VDcrL0N3cXc5TW9oTFc5?=
 =?utf-8?B?T1hJdDgxeHBLRU9tYllJeDVxZUhiRmNuT3lsUkQ2aUdjcUtaS1hSYUZTZWlv?=
 =?utf-8?B?VUxsTW5GbHFFQkZuL2ZnTlhnUCt6djJTZDA2MktCbzFXcFFhQ2U0M0xXeXZa?=
 =?utf-8?B?ZUlYL1ZQTmxIdG1wMHJRZDlpSmc3NlkrZjhqODF5WUVtODFjbTNRRytkbkZI?=
 =?utf-8?Q?0zBIkOBCGjOjDKCSQi1mi/6i41A1haSz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:25:12.9149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43e99d9-edd0-4c3d-0eca-08dc9accb209
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241

On 7/2/24 11:49 AM, Edward Liaw wrote:
> On Tue, Jul 2, 2024 at 11:26 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 7/2/24 11:12 AM, Edward Liaw wrote:
>>> On Fri, Jun 14, 2024 at 4:31 PM John Hubbard <jhubbard@nvidia.com> wrote:
>> ...
>>> Hi John,
>>> Could you try re-submitting this series with the RESEND prefix?
>>>
>>> Thanks,
>>> Edward
>>
>> Sure. Is that the key, for kselftests? Because I've got 5+ small
>> patchsets that are languishing there, and I'm at a loss for how to even
>> get a response, much less get something merged.
> 
> I don't really know, but it was suggested to me that it can help to
> point out that the patch might have been missed before.
> 

I wish. But we are three versions into it, plus a special email [1]
specifically to point out that this is still pending.

I think either people are on vacation, or these fixes are not considered
sufficiently important, or both. :)


[1] https://lore.kernel.org/e9de90dd-c541-45bf-a364-0e7aaf320314@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA


