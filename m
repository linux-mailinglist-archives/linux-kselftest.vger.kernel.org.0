Return-Path: <linux-kselftest+bounces-24042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A1A051AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 04:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C35188A33F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FF19C578;
	Wed,  8 Jan 2025 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cN9k8QmR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28978259490;
	Wed,  8 Jan 2025 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307635; cv=fail; b=nz7VQrL70NFh71m/i05bTl69EDeZR8O/ySJn5kCG6T+T6PDFu6UArGGdX4Ne63Yr5h25vOQTYGvuPmGzTV6QyP8i8dgvjSBCbZwgbiNLW1amHU54N9YdLooG6szunLb5uZ/QBXCIyfonVtO/QNBU9MOLhFBY6H0Ipww++5tIt6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307635; c=relaxed/simple;
	bh=wAyUq84nWRx8HuZouVc3DWwIqBELUOecxVW5FM37mVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M7lGnKvo3ZzWaoSzsYhS0FLm4UZBp79NT0p0QZOTHCg23K9FeCPoBJgX5rnYuWRI1JUtrHzzQ7ynZORKC22axPC5ceFWniEs9XttX5RmR5ptRHMx7jERNhq4HKkr3LhDlMTiBvnnMB2qM1pUcyqGK6HD8D6NbXWM5UTQei5HMMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cN9k8QmR; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DS2CjUIjHicy7v9ZggdBo9sVDk8GixfkXfWxBDM4YJrLM/TKNUde66nr2TF6AglebYC/rE92v0nEFLwZIPqqunO57i9PeFWMvRlIlILosi9MAy7/Mhjp50vCAQGL9FzacADeo4zydU88YHnqatBSv2FWcLeUOAv6YgORSw3stvgaEzKc3bq5ow/7TIPK4VaQWd65gWLxqgQVE9po+7bfq61BrQwI4/Raaiw70Y/qB3lwGIvKFnlcOxIbnRWjIlubsnzwU4Ltd/Ztq5HrfmeXWX4K5fRrv/u5RRo/oyKtXqJlB4if4OcbvJzjtSFIy2b2jq2abP/UY8df44k2xwUnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbOwOIC3FCy8lK1JeL1caJsY9KosPnjjARqmx3prsEs=;
 b=ZGfntyBuNoXrgK/c9/Fm7c6utRqykt2LHTXTMVWK6XRnjtRFM/JkJlBUFsUu1JPio4wyzHhB5kt046wpRYdHpCsJcKr3bQyVXLFEoOlYgi0q8hMocBdn3E7cqJR40saKoGkk2Zi8Jr0HC9OQqda4+KUeQmUrhPQBO9L/iisof7Fl60+chld7sh6kl/qvjWk4RzPn8kz3l5nRDwV3JkHYuKOBkii6CHIGoUTvGMsUlcXRM1b6G6xK47qj/2iQO+4RABuvvlp3QszoLS2sYaVidbycdYaIUmAngfkFPxdGMof+ELpmShNpQfGj0QrwurYynR4tD71576tMsinpTFlo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbOwOIC3FCy8lK1JeL1caJsY9KosPnjjARqmx3prsEs=;
 b=cN9k8QmRzjEkGnQ8qMRSHuPxZ2cmL/yuV+s4wrNvphxTOucU5p26aKBFthanRZeSf0VHeD4kcHnyN/31rUL3r0+LjVMAVUamPrD1l+s6lpYEhF1QeYQXJqC3G7VOt90dwhWRiSBMicnSg0BHYRmwXLvqCwFkO06/U8Nc+Jz868+ouBOEZ62M762bGjUpT8rEAm6S3Vr/C+ekUIJEj4SwaGh//ilnnps9j9qQWanhcPhE1SiCdOyE8K6RS87aw8nPCdiGgZRmRpB5fPcdXTCwt/xjp9H10beT0zRloUrqSpQL0rWyDHjR90WEA3gPvh45wgwvh2O3zf8MYBhhu0aezA==
Received: from BN9PR03CA0545.namprd03.prod.outlook.com (2603:10b6:408:138::10)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 03:40:30 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::57) by BN9PR03CA0545.outlook.office365.com
 (2603:10b6:408:138::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Wed,
 8 Jan 2025 03:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 03:40:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 19:40:12 -0800
Received: from [10.19.162.113] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 19:40:08 -0800
Message-ID: <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
Date: Wed, 8 Jan 2025 11:40:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
To: Hangbin Liu <liuhangbin@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>, Jay Vosburgh
	<jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org> <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org> <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com> <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <Z33nEKg4PxwReUu_@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af15287-8d67-4407-57c0-08dd2f96333f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3VvYnZiK2dJZ0xycCtoOHI1TE9pY1ZCbGFvdzRaRlp2MlhyZCtMcTdQUlUx?=
 =?utf-8?B?OTVvLzdPQWpheU10bHdHWDczLzVmc0RFMHZMaTNWOFJDVEoyK05zOGtsbDl3?=
 =?utf-8?B?Nnpja0EwV0x4dityMUlmaHRYY1ZycDhwVDlYN1FtMVc2QlROODZiTFk2Zzl2?=
 =?utf-8?B?NFkzaW4ycmZzTzVVNUhrZC9kSWNHRmlDc2VWT2RyTXRnL0pBWUkzRlAzNXQy?=
 =?utf-8?B?THV3eFVBNXlVVzhpVWhsSUdyd1RZMlRkZ1RMZjNFUmtUdS9nRDBldXVFSEhy?=
 =?utf-8?B?bW9XemZEYkFQNDRGKzRkUEZIWnJoUUZmZUl3VDQvcGVpdWNVUU1qZnJzbzlE?=
 =?utf-8?B?WUJUQUladEFra2VwUUw2cXByT2x5MWxqQUNta1dmTkVwOTVTQ0FoOFpIUHhs?=
 =?utf-8?B?d2lwTGtwdXgyRDZsVk84bzlWWjNxbS9nYkFwS2RVeTRtT0UxLzJVZ0I0alE1?=
 =?utf-8?B?VU9DOGE5eE5DdWVaVVVCRkY0RWJ5a21WNE9qeGFldHVwc2w1UWZoRjBpL05p?=
 =?utf-8?B?RWNsZEFHV1hPemh4YnFWVWNNa0xxOElia2xIOXNKTnNraTRZbC9iZkVra2Vo?=
 =?utf-8?B?OUN4WXdySlJHdmJ6eUVJRXhpK1JodU4rVjZEaE81S0V0K2llajB6aEJtMHVl?=
 =?utf-8?B?TDluV2xpRDBIOTFnR3JwU29Bb3J5MGpUU1lKTjVxOW1TOGx2eXBadTNibnJO?=
 =?utf-8?B?ZkRDRUxYSDMyRzZrNk9PV1FuanNOekkzOHQ5VG1sU1BIcEp4LzBrYm03Z1k0?=
 =?utf-8?B?SVJuT1VYOUVNOUdHMUtUcG1KMkg3M0p6NWFzb3BCQWV4SzVtL0hNWGVoUXZr?=
 =?utf-8?B?clE0VitqU0liS1o2RWtRSmVqWlVWUHE0WHVFWmFMVnBhVjR1NStFY29DcGlx?=
 =?utf-8?B?M2Z2ZG5QWkxlalN1MDR0OHZFSVdNRXJIU3QwUWl1YnNpRmlPWWZCRmRJb1Yx?=
 =?utf-8?B?d0UyVWQyL1l2d2Jodk9zY3JPdzI0aXRTV0srWFpCV0JLUXg1SVhTSEJuSDJR?=
 =?utf-8?B?QTJCbWdRVTl3Kys1U01ic0ZZUW9VQlZMQlRNOUlpYk9FQjUzV3JlaHZ2N2lK?=
 =?utf-8?B?ek8wbFFvQVIrRFI3RVMwM2lpWmlZTXV3eVRsQ21YT2ZGd3ZnbWVJNWx6bnpB?=
 =?utf-8?B?bFRvQVNOZXZTa1d6QzdnVlNlVVc0VlpBZlU5bXI0QUV1aGxlTnBiU0hDVHBr?=
 =?utf-8?B?RExzSzFPU3JIZDlEZFZFbTBvYmF3dGtsNlFpaEYyTWNyTExWZFZyQW5pcDJX?=
 =?utf-8?B?UzNPek1SbUZadmVlVThNYUo0ZU5MZGo1dlFyL3JKaFBZVHBjdE9VVXRtMHYw?=
 =?utf-8?B?bjJJNS93bnFuWDlIVWRFeVludGV0UzdTUk5CQjhURVhoTEF1VC90engydTMw?=
 =?utf-8?B?NFpPQVB5blRqcm85QjhEWFJyQ21MY1RkK2tISnBybW8razZuZFIycnVBek5C?=
 =?utf-8?B?SURUYW5LaDFMc0R6eFRoaElCVHFNYkhRRGxFQ1YvMlJ6V1U3ZURrU2hqcllK?=
 =?utf-8?B?YnRrL1RrUXJWVVFFcm9iQ2grVzRtVmUwMHdxMkYvZFcvVnlEdnVFM1RLWW5W?=
 =?utf-8?B?VkFCSmtrZ2czTWpnZ1Q4Mk9TVFZXOHB5RGE5NDhDWjlHcUw4UkNYQjdnZlN0?=
 =?utf-8?B?cHVWMW9CQi9Pejdvb2xrTURFNlJwWE1kb3Z5blNQd1grR1N0YzVmZGpIYzM0?=
 =?utf-8?B?amhrZ0lXVHFYY1Q3STZRRGNMUVhxSFlTakdGTTdFa2RUUEk0dDhuMytjeEJn?=
 =?utf-8?B?anNOL2hxSmdsbENnN1lNSmFNWTkyc3BEbFd1ZDhtaitSL2ZhK1BDRU5DNHVX?=
 =?utf-8?B?Sk9uRmtscGVZUnpKblZ3Skk5d2E1UmNtSnVJUmprTWZ5TmtYSzN0eFIwdVVs?=
 =?utf-8?B?RkRwaWcycHdxM2d5bG9JZE1XSFlGcFpsSytYZEI1c1EvNVVwZzByL3dkQXZh?=
 =?utf-8?B?N1dpeTFOdGpIT3hqRDhSb0FKMGpkcFRwcU9LUkJ6VVpEeisxWnJDbkpqMTYy?=
 =?utf-8?B?S2JaVmZhSXp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 03:40:30.5836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af15287-8d67-4407-57c0-08dd2f96333f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262



On 1/8/2025 10:46 AM, Hangbin Liu wrote:
> On Mon, Jan 06, 2025 at 10:47:16AM +0000, Hangbin Liu wrote:
>> On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
>>>>> Re-locking doesn't look great, glancing at the code I don't see any
>>>>> obvious better workarounds. Easiest fix would be to don't let the
>>>>> drivers sleep in the callbacks and then we can go back to a spin lock.
>>>>> Maybe nvidia people have better ideas, I'm not familiar with this
>>>>> offload.
>>>>
>>>> I don't know how to disable bonding sleeping since we use mutex_lock now.
>>>> Hi Jianbo, do you have any idea?
>>>>
>>>
>>> I think we should allow drivers to sleep in the callbacks. So, maybe it's
>>> better to move driver's xdo_dev_state_delete out of state's spin lock.
>>
>> I just check the code, xfrm_dev_state_delete() and later
>> dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
>> checks. Can we really move it out of spin lock from xfrm_state_delete()
> 
> I tried to move the mutex lock code to a work queue, but found we need to
> check (ipsec->xs == xs) in bonding. So we still need xfrm_state x during bond

Maybe I miss something, but why need to hold spin lock. You can keep 
xfrm state by its refcnt.

> ipsec gc.
> 
> So either we add a new lock for xfrm_state, or we need to unlock spin lock in
> bonding bond_ipsec_del_sa().
> 
> Cc IPsec experts to see if they have any comments.
> 
> Background: The xfrm_dev_state_delete() in xfrm_state_delete() is protected
> by spin lock. But the driver delete ops dev->xfrmdev_ops->xdo_dev_state_delete(x)
> may sleep, e.g. bond_ipsec_del_sa(). What we should deal with this issue?
> 
> Thanks
> Hangbin


