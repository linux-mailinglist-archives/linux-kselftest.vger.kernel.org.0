Return-Path: <linux-kselftest+bounces-24119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F5A0723C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 10:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D003A3AC9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190D9217737;
	Thu,  9 Jan 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngxBxa+d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C121576F;
	Thu,  9 Jan 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416301; cv=fail; b=nKbd6gRmMGJ1IaPpnxNA29+yZ6quiM26Cdvz/V9xY3NEeEZ8A5he0oyJtB4btMmlTCyfaK3+YWQN+PSPeBQEnpx/XmOTZC1QagC+8ceyaMIR+KKkGinE4EEcf+ZOVEGsiiQmNv+feg78Ot2h5K2I/bq85xP/FxY7cmJC5BXNYyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416301; c=relaxed/simple;
	bh=Pxi5FM6hZgHUBQzarG2FV59Cps9cuvAz4xjLgAghO20=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eJ5NME8LA6p7tVU/GXYDdXt5NBWgHycfo8Ta+kkfBIKbl+fm+jHuB9zNccBkDa6hMUo+Kpda3SE8P0FGK3mVTlh5AEeR8TujCSJTNPAaceX702y3Fs/P1afhWsuguKdF1hfUS7uCh+ne55ks4Z2Mu+gaJ9wEVZFyjuzG4TwhcFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngxBxa+d; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z774vnLMhaRvVpXfX8qx2ThDNFMqz+XrHFbFW5bAQYOTLrctx9MLIFND/Zao2moAsjoXYqBioGt0pR+lDJhAE0v1fuVFed8E9XElAZfwPLIBxoKFvi7ABIOzaO3uApJY3rdct3lDcgXJLH1TV5OErTN8unvDM3ByeWdehLSm4UixUilpMZQBjiBbAKTGoyJLyzCVzzzB6aLbSBW/RNR3RR0D0TWN2Nvki7BDEr+fV27ZnTAmdZLIQ2rAEE9fkm1Mger1G47bv76H68GlMH+xHz7KGJ/6lVvdg5EIu6HxW0aYAL6mwujk6UL+7H0r2Ve37m5V9Fcuy+CF/h7G/GlmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONWMGOt9/ezBtzuY8a1TTfDtkUJ7wyd5wiDua0+Gqj8=;
 b=SdbT4X4FLNIS6zvEhYrqokfYh24PAsC421Y1w8ZnKiMkxGGsDPMewaNuwXr/6wVqiFKb2A4f4f21H8AEmwT0dDozpK5beyeakwRAC5dgHmE7mjhtUWK9qVCdIigj1an5x2mEoB1FqEAEcW7o/X+DZyyvjnT7Bsl8fYH7ZneUmBkZAAde9wt3YlsD6BUUQv7Zwu/wbvp9HHifNtdWSlCBKc3yk+8hYFO/zTxdepXD8gs3/bRtOX1Jbx0KMPggL71O34fw2okw3+kfb1h1nXiWCTsHoWashocj8He9jV8sJIcY7V32d428XWZ6n5a+3ooTJh5H0NzmkWmxxS+pMTtg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONWMGOt9/ezBtzuY8a1TTfDtkUJ7wyd5wiDua0+Gqj8=;
 b=ngxBxa+dyRcN3D4XyYXBceJCtRr/uNUG0AkKUMGVWh08CI7vIerPjZjUiZmWoWF/FM7wM6+sPXff0AS5eoDK9hcFb8b7+/3oGtEaIKRv+tpcW4cNhDBEoYCETSMm/fU73PPBZaKMVWO16u90+9tm73lpGZhJgqjs1y6C2J2twsdGkuw33/HBDA+IEYe9lU+ZlpQ2ySolwZ0Y0nZB3aZdwNVzDuOiWX1aQYa8vNBD7W3u1LQQGYK7pXkFqLZBNXAygvBsNHETlZ5bnfj4/Z0QtIE+ZZqeLhWOu+2UlXrGa4534TKyK+bxamqPDgffk6ONsmIG10b8vm5/l9ya1fRTTQ==
Received: from PH8PR05CA0021.namprd05.prod.outlook.com (2603:10b6:510:2cc::9)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 09:51:34 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::37) by PH8PR05CA0021.outlook.office365.com
 (2603:10b6:510:2cc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.5 via Frontend Transport; Thu, 9
 Jan 2025 09:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 09:51:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 01:51:16 -0800
Received: from [10.19.162.113] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 01:51:09 -0800
Message-ID: <b39dfbee-dd80-48b2-b79c-29682269522a@nvidia.com>
Date: Thu, 9 Jan 2025 17:51:07 +0800
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
References: <20241212062734.182a0164@kernel.org> <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org> <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com> <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora> <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora> <e01bae5f-30b5-4ec4-8c4b-5c133dd4552a@nvidia.com>
 <Z3-KxbofkhOrWin7@fedora>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <Z3-KxbofkhOrWin7@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: c57b0d54-694e-4207-3dc9-08dd309333dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkhnSHdCbFpYNHB0Rys4VXN4YUU2R3d3OWZBT0QxSUdTT2hxMWtNSC9aUGxS?=
 =?utf-8?B?YkJ1bFNQK1RjbGs1d3pUUmEyM1lhTTZpa2h5V1ZSMDVselo5QTJaT3g3L242?=
 =?utf-8?B?N09NRWdUa2RlRFhkMkxwd1ZMWlhWdXZiSlVkUHRPQURyR0dkcWVKc01FTHdX?=
 =?utf-8?B?b1crQXZpbFo4N3JOdnZJLytjWmREUTVZdkp2TjArUzUvT1Z2WElyZzEweUk5?=
 =?utf-8?B?V2NiNmMxTnVVc2lMalFNL0xQYU1wVk1KQ2habXMzbUZPMVZyNE9LcGtoVzVk?=
 =?utf-8?B?am43YjJIK2V1aDllWVVXOGhxdngwcTRyeVVoRkRja1V4dEM2ZmlhU1VMZ3Fx?=
 =?utf-8?B?UWphTEJoVEYzbUU0Y3JYSmpxSzdIR3BPd0pSK0VkOGJCN3BiS2Y3Tnl1eDJq?=
 =?utf-8?B?Z2RwSEc1L1d6a0NqU08zaFRCQ1JyUXArU3JUQlNrZVJ3RjhwbjZwSXE5cGFS?=
 =?utf-8?B?SGxsVXBWRnFkYmxoaGNLRzV5V3BsSzBrVVdNYitjdloxN2htSFdwVVFBaGxT?=
 =?utf-8?B?RzZ6NTVpN0VXUERJd3ZZcHZyMDFwdUt1WG4zeUNBdGNIczY2V3NNdGpxMEZm?=
 =?utf-8?B?VGJFdVdnb3ZaSlpHKy9Kb0wzMDNVU3k0VWRUWGRKYmZ1QTM3Wi9TazFuWXh3?=
 =?utf-8?B?cWVQRmFSMkgyYlRScFJkR3lXN0JwcVB2WEMrc1kyUmJBci90MksrTG1EY0Q1?=
 =?utf-8?B?NGg3WXgrbmFoYTRpWmR5NjNXc2FodVh1M1hEemlPVDBYLzU4TEw3VmZLaTRR?=
 =?utf-8?B?TzFabFFlVC80aGlOWWE1c2tudXVySzNnbk5sbDFYL2tGUlM2em1ScFVreElk?=
 =?utf-8?B?dm5pejRTMUdwNlJPWTB4YWN1dHVGemdMRDJSNHhzOUxOTUg4STlHS2d3QmpI?=
 =?utf-8?B?L2d2YWZkSVVwVkpqK3BCNnd3WXFjTVhoQUJJUGI5dURIQWtSZVNieUhiaS91?=
 =?utf-8?B?dFJ2WkRHS21JSkk4TVlUbHBpeDhjMnN0RW84YmFQd3hJY3h0UHZmNHBUd3BI?=
 =?utf-8?B?ak81d29jTENMWmRJSGNmSGhJSEorTWZ2ZTBUaWg5VlFHTVRQN2pPVTlpNEl1?=
 =?utf-8?B?THNKN3RtMXNYTlA0UTQvYStHMUR0c0J3OXpyVU80L3R4d095VmJ2eklrRHQ3?=
 =?utf-8?B?MUFEYktmbDl1OW5Vb0I2dmR1Qk9KV3BCNEpnektJMlplYWVaRnRqSXdwN3J0?=
 =?utf-8?B?bllCYURCUFNRdWRIMGV2NFlxY01ybEo3djYzRlIvL1lFd3pJZTI4bHRKdkN6?=
 =?utf-8?B?SkRyMEQwSm5vQWp1bmdxQlkxNzlkZXhJZUZ4QU4zdHB6Mldlc3FhQWlMVUVu?=
 =?utf-8?B?bGhzcWdoaUpjckZHU01jS1hBM1p6Z2k4MUYrWHhDTDJLZjgvQnUyOFhqWm8y?=
 =?utf-8?B?N0tnUTNFVlI3UXVLdGU4ODhjYU54dTliajFXSVNNYXRLVlU1NllaVWtmYWJW?=
 =?utf-8?B?TEM2cWhZYU4xTVhqekV2a2Qzdk04VXpBTFg4aVhaTy9pZW5HZi9sUG40QmYx?=
 =?utf-8?B?Z08raTcwbzk4YUlrTWMwOXk3cGpmQ0FLNUtES2gxMUo0TVlYYUhaNldxMzRW?=
 =?utf-8?B?KytQWDd6V2M0VjFnaUlFdkkyQXNqV3IyVFNPU3hncHdjTU9zYjc4RjRUYTQx?=
 =?utf-8?B?RW5xQ0x0WDZ1ZUFTU3dvbWYyd0psamIvcXRrV2dJYitjSFpTZnZ1MjV2ZWoz?=
 =?utf-8?B?aVU5clRGcWl6bStXS2FnRldLR0oxVVNxVXZuWWlLMm5jN2NqNFViTWNPVzAr?=
 =?utf-8?B?NnVnSTkyVFM4NURpV2xFZEFkNWJCV2pHY2c4dG9KVVZaUTl0MGJjcXZBUndO?=
 =?utf-8?B?eG1oUjdKSnRBUGE1NlI1dDZFMkRKRXNlQ284bGNVVCtSbTBQV0FSdGRxQVd0?=
 =?utf-8?B?M0dWTEdiSnBlM1hBYm5OZk5RY2w5WHpvYkhpd3RxTEJNdGV4dThZdVFNQ3hE?=
 =?utf-8?B?T2tFdlV4Nlp2WGR3YnBDQ1VPNVZhV1hPeThHVnJiVXRGNDllRmpaV3NucUU4?=
 =?utf-8?Q?aeheEgLwxP3H9Fs1R2eIiXgIsBNtII=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 09:51:34.3782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57b0d54-694e-4207-3dc9-08dd309333dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415



On 1/9/2025 4:37 PM, Hangbin Liu wrote:
> On Thu, Jan 09, 2025 at 09:26:38AM +0800, Jianbo Liu wrote:
>>
>>
>> On 1/8/2025 3:14 PM, Hangbin Liu wrote:
>>> On Wed, Jan 08, 2025 at 11:40:05AM +0800, Jianbo Liu wrote:
>>>>
>>>>
>>>> On 1/8/2025 10:46 AM, Hangbin Liu wrote:
>>>>> On Mon, Jan 06, 2025 at 10:47:16AM +0000, Hangbin Liu wrote:
>>>>>> On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
>>>>>>>>> Re-locking doesn't look great, glancing at the code I don't see any
>>>>>>>>> obvious better workarounds. Easiest fix would be to don't let the
>>>>>>>>> drivers sleep in the callbacks and then we can go back to a spin lock.
>>>>>>>>> Maybe nvidia people have better ideas, I'm not familiar with this
>>>>>>>>> offload.
>>>>>>>>
>>>>>>>> I don't know how to disable bonding sleeping since we use mutex_lock now.
>>>>>>>> Hi Jianbo, do you have any idea?
>>>>>>>>
>>>>>>>
>>>>>>> I think we should allow drivers to sleep in the callbacks. So, maybe it's
>>>>>>> better to move driver's xdo_dev_state_delete out of state's spin lock.
>>>>>>
>>>>>> I just check the code, xfrm_dev_state_delete() and later
>>>>>> dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
>>>>>> checks. Can we really move it out of spin lock from xfrm_state_delete()
>>>>>
>>>>> I tried to move the mutex lock code to a work queue, but found we need to
>>>>> check (ipsec->xs == xs) in bonding. So we still need xfrm_state x during bond
>>>>
>>>> Maybe I miss something, but why need to hold spin lock. You can keep xfrm
>>>> state by its refcnt.
>>>
>>> Do you mean move the xfrm_dev_state_delete() out of spin lock directly like:
>>>
>>
>> Yes. Not feasible?
>>
>>> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
>>> index 67ca7ac955a3..6881ddeb4360 100644
>>> --- a/net/xfrm/xfrm_state.c
>>> +++ b/net/xfrm/xfrm_state.c
>>> @@ -766,13 +766,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
>>>    		if (x->encap_sk)
>>>    			sock_put(rcu_dereference_raw(x->encap_sk));
>>> -		xfrm_dev_state_delete(x);
>>> -
>>> -		/* All xfrm_state objects are created by xfrm_state_alloc.
>>> -		 * The xfrm_state_alloc call gives a reference, and that
>>> -		 * is what we are dropping here.
>>> -		 */
>>> -		xfrm_state_put(x);
>>>    		err = 0;
>>>    	}
>>> @@ -787,8 +780,20 @@ int xfrm_state_delete(struct xfrm_state *x)
>>>    	spin_lock_bh(&x->lock);
>>>    	err = __xfrm_state_delete(x);
>>>    	spin_unlock_bh(&x->lock);
>>> +	if (err)
>>> +		return err;
>>> -	return err;
>>> +	if (x->km.state == XFRM_STATE_DEAD) {
>>> +		xfrm_dev_state_delete(x);
>>> +
>>> +		/* All xfrm_state objects are created by xfrm_state_alloc.
>>> +		 * The xfrm_state_alloc call gives a reference, and that
>>> +		 * is what we are dropping here.
>>> +		 */
>>> +		xfrm_state_put(x);
>>> +	}
>>> +
>>> +	return 0;
>>>    }
>>>    EXPORT_SYMBOL(xfrm_state_delete);
>>>
>>> Then why we need the spin lock in xfrm_state_delete?
>>>
>>
>> No, we don't need. But I am trying to understand what you said in your last
>> email about adding a new lock, or unlocking spin lock in
> 
> I *thought* we need the spin lock in xfrm_state_delete(). So to protect xfrm_state,

But not need in bond_ipsec_del_sa() because the state still hold by 
xfrm_state_hold(), right?

> we need a new lock. Although it looks redundant. e.g.
> 
> int xfrm_state_delete(struct xfrm_state *x)
> {
>          int err;
> 
>          spin_lock_bh(&x->lock);
>          err = __xfrm_state_delete(x);
>          spin_unlock_bh(&x->lock);
>          if (err)
>                  return err;
> 
> 	another_lock(&x->other_lock)
>          if (x->km.state == XFRM_STATE_DEAD) {
>                  xfrm_dev_state_delete(x);
>                  xfrm_state_put(x);
>          }
> 	another_unlock(&x->other_lock)
> 
>          return 0;
> }
>> bond_ipsec_del_sa(). Anything I missed?
> 
> The unlock spin lock in bond_ipsec_del_sa looks like
> https://lore.kernel.org/netdev/Z1vfsAyuxcohT7th@fedora/
> 
> Thanks
> Hangbin


