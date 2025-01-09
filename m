Return-Path: <linux-kselftest+bounces-24088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5173A06A2E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 02:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8461888D0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC174C7D;
	Thu,  9 Jan 2025 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uaHcsCWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE80747F;
	Thu,  9 Jan 2025 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386023; cv=fail; b=low2cvqp2CRQfbzSbLJTRBsvm7BtQXZeEDWauUWt7KL6wxGB/JySDnGjDV081dG/cE5PdM2R/BbFx0sIWyMPOyL2QwH8WwdZlYbQvrWK/PLXlHEp7x3fvjPLvo4OVwFfAK0mfBQmd4o5PtEVkM7S2DxMZd+ok5dGML4wRIAyiR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386023; c=relaxed/simple;
	bh=XQQV2pK78eKnoXdWk43kP0f/AOjZVP5AQ1FJl6rdv/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SUU+cgiCXzuf8oRhJsGrUcq3ZilRH6qReWhR/xZKzu0zN3XMAfH2ubL+tipB18Nrput2ZXUeuA5l9A/CcbA41MM7HxbzwhE6AURc37cbD0cJsMtQUxnr+3WSyROgRXlpIR8Zz4247pyRMMkz32OIErfPtos+BcseyUa3y4rFtmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uaHcsCWD; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZ73ePq9CmWHBXiOmVOIzUKDcmp8yq3/ZHWL43vUUK3jfo1CtauDECeiIwDg/5h59M5hn8VebTJktWCb98CPaFvDDbF+ZNLDEdQf/HGMvjwoWgtGu2j9FtVy3ppZB78dEUY7lbY8OQEWlvPB1yx2IiWlJCUMGU6qMSI7OneuwW4qNtHZctyTE5y3OkhQNr4B5lQ8armxuVDEvNuTxIPtJa5JyZlua5i90zeloDAeIm/fK54fNHiHu4ulADmgYHq3OxfKXkmMayPiZMNDBirJpCmpEzUK2cswYGZ6ayptcXFclPo01+OU2+fbmH3mjTqv7EuTuuOIeAkdswjKxRTOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPqdg5XziSZUDKLJeAqeTi0ww1b0AGKI5lWkElegFyk=;
 b=kHUaMTcUWHGSTphJUFrJzE598x+xvu5ie36z62x+dDaJknbbeo/5MrjykLo4eRpe7yORdLEINKXzXRiiB4PcCEN6RRnClCmx0z1SHzVI+oS0CG88PKJDA+jlpMZpu1UwaKEFxLOCkxSS6AB5mtfuoaWmw/ztO2MzAWCnzTe6fN3nyJyCtet00E9LjqbxM5X26Y5V8MBpTuaob9PS2Q87xcPEYeghM6/WwWOWJCq/mi5cOqN8A7Eu5uN3Ywfe2pBkQyebIWNP4j5ZPTycTtcGPxijPHevjYOxdQIzUJjMMQPtpBgjPzaWlqqSYc6Tw0SjX1Y2Golz1Kj8aCSpJOQOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPqdg5XziSZUDKLJeAqeTi0ww1b0AGKI5lWkElegFyk=;
 b=uaHcsCWDl4s1uf6/G2pAeRInamGOYKch3IeQfsQvn7FOnwMTCnPpRs/lBXm+TCK8YtT4DNQcR1a9SSeK4NYhDkHMsrVBJtb7ZOzGnK35ExzdwQ1vOqtD22hNcvrpaIRUlC6lH4T7ZqQP4CAEpCQpEHOvTeo5eb7qf6Oo6bSMphp0xhus0W9EEz9FqA2sKitou+JAHhj8jtEI0MjdyzfbtqQmlfTb96F9HT5//T/5txKSZx7fy60G3xeBMxJtoAcV3/v3Cl5CT1Xg5VlEAXteu5tti6X5o2Vng4jzYNe/vAu4HV/77jLkcblLCeJuHVndaFg818QbYHDuhM3iNQSQag==
Received: from BN0PR04CA0183.namprd04.prod.outlook.com (2603:10b6:408:e9::8)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 01:26:55 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::ef) by BN0PR04CA0183.outlook.office365.com
 (2603:10b6:408:e9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 01:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Thu, 9 Jan 2025 01:26:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 17:26:43 -0800
Received: from [10.19.162.113] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 17:26:38 -0800
Message-ID: <e01bae5f-30b5-4ec4-8c4b-5c133dd4552a@nvidia.com>
Date: Thu, 9 Jan 2025 09:26:38 +0800
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
 <Z33nEKg4PxwReUu_@fedora> <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <Z34l6hpbzPP9n65Y@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab20df7-bce9-4e6b-3c25-08dd304cb408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmc0SkxXSFdBUTA2eFBvazlkSmdOMnRiYTBKUWZMYnh5bVRoSWVkdDlnZjho?=
 =?utf-8?B?SGtqNFFLQXBTOWFTNEZBVUtTd2NxQ3JzT0o0Ti91SGZIYWtheE0rNFkwd2dC?=
 =?utf-8?B?UXZ0Nk51ZThhTERNRG1kSUg0SWYvbVpGcmVYK3c4Y0R6NlllL0dNbDVINTdH?=
 =?utf-8?B?S05xUVVKcHdkVy9TTTZ2ckw4amUwWmduaFBGNThROWE5SjlHK1dsc0tyazhC?=
 =?utf-8?B?eGJZaXQ0VXJqSUwrbDQxQmQ5WDVuNDdmR0x6U2VNR21wRk45QjQ1MlQzczIr?=
 =?utf-8?B?d1E3YncwVFdLTkh6MHBlVTlodWNHd0gxMUxQaHdiUzdwbytuTjh1SWYzZWRI?=
 =?utf-8?B?ajErVVFsRW5GVjFFQVR2eTVJdklkSjV5Tm9LOE40bkZIUUVmTGtDUXZlNEla?=
 =?utf-8?B?SzNxRGpNUnh2VTJ2ZG1WTmFCR2FqOXlLcWdianBQZmcwUERLdmNpUkNqQUp6?=
 =?utf-8?B?SUpMWFZ1RVU1K3dnN0JlUzRia1IrcE9RL3orTDJOOVJySHQ1RFhJd1hnT1lm?=
 =?utf-8?B?TDdrMXdGbStCeHpyZ3J0M3FoR200VVNwNWlFa1hSdjNkVGlId3F6VDVYdlkr?=
 =?utf-8?B?UEViQmx5Q09zSDFReUN2TmErdmZtcnlhaTdSS1BCQmFSTUhMb1hLd1Q1TlVU?=
 =?utf-8?B?c2tmTTY2VmJ1SkZaSXVEczhmaVI0bllMdG53ZWpzVFNXOVlxMzZUWi9FQ0FF?=
 =?utf-8?B?ZnBRcnhOM1cxWVFPbWRsaEc0TUxaTG91WDJuRTRUK3FZT1g1K05VQVNHUzZS?=
 =?utf-8?B?bWFYbHIzS01NelpJcjVEM1JsdVYwZDFITitkYndwd1pFZG5jdHpMWHJkc3Ja?=
 =?utf-8?B?U1BGcUZiU00vSFhJbHFuZFVMNU9BdTdQQ01XTmJVRHBscTdLcFFsdE1NUnRT?=
 =?utf-8?B?cERCZ29hL044YllGaGErK1lmODkvbUU5N2FCaEp3S1IvYnhrbGpIaTRHdGlx?=
 =?utf-8?B?WklFQ3EvQmJHc1BHSGRZdTVkbEhUWDZNN2NzSGVBTHRuZXlHT3UzaUhVcDZH?=
 =?utf-8?B?YWlVc2M1QjY1R0QycTk2N3hvalZmR2srelVMTytlTyt0VEp6TlBnYjNFWU1P?=
 =?utf-8?B?OG9CdVpHdzZ1M2JNVHNYUjRQT2pDT09jVnhpa0wybDFqdDhXNzJCc25XNDJX?=
 =?utf-8?B?Zkd1bWVBeGloWGRheDl2SWgzVVZPbk9QVlo5aURyaUtQcEE1d0R2NFRYRlly?=
 =?utf-8?B?Z3RhTmVGS1U2UUR5WTVtMGRNMUk0QVR5WHlEVUw0R0FEcUMxWjZjaVhQMDZ1?=
 =?utf-8?B?bnVSZkRFeVVqZGNtdVpDNHlZWVFqOC9reis3dHBWRmJUM2RKUXNMWVozTzdE?=
 =?utf-8?B?T2R0MXE4VitDWnVFTGdzMGZUdnVDNW1VelpucHFqdkhDN012djhER2Q5bTdU?=
 =?utf-8?B?Qkx1b2x0L0E4RC9HaU5YNnFxbE1MUzJwUExab0dwYi9PQy9RWmVWQmphRzdj?=
 =?utf-8?B?TGNCZExCcGFwWE9SWnpaZzRRbFhremN2enIwR0pjZzFnMjBPbTBlVkVENW1E?=
 =?utf-8?B?eVNXV1BKNTFRdmhqTElDbi9kbnlDRTVtNFBxZFJVc1N2TGc4bkc4M3g2b0dR?=
 =?utf-8?B?bHpEc2twMkFDTFhVMU9JWGRzdFdPc2N0aVVSTzdJM3QrMWluWllBRFZZUmRC?=
 =?utf-8?B?UmZpVmRzNlNMdGxacUx2R2ZjZnMvRTJ2TjRVZzRJcWRXL0trb0t2MDRpRi8x?=
 =?utf-8?B?OWM4M09lOUYyYUVPV0dVNW5mZDZiTlMvZ3hFS09ORm51aE55KzNQb000cmF0?=
 =?utf-8?B?VDJWcDN4dEhwbUx5QnZTUzZCMmtpSnRzRzJTRWE2bU9GQnlEWjJtQ3ZLQzI2?=
 =?utf-8?B?cE85VWJxZElFZ3NRSDMvTlVaYy9Zc2V5cS90ZE5oeStXbDRGMGZIN2pPbHNL?=
 =?utf-8?B?WHBIQlRSZkVmdStXaHF6cW5nZ1hWZi9wQkNOdlM1S1ZVTDAxelNLYmNaUjZ3?=
 =?utf-8?B?cHV1Z1ZHSTlGOS8wWlNoT1ovR1VxZXVtamttU3JQTjc1dzNwM2RzYjVsd0ZH?=
 =?utf-8?B?U0hVMFJybDJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 01:26:55.0533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab20df7-bce9-4e6b-3c25-08dd304cb408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796



On 1/8/2025 3:14 PM, Hangbin Liu wrote:
> On Wed, Jan 08, 2025 at 11:40:05AM +0800, Jianbo Liu wrote:
>>
>>
>> On 1/8/2025 10:46 AM, Hangbin Liu wrote:
>>> On Mon, Jan 06, 2025 at 10:47:16AM +0000, Hangbin Liu wrote:
>>>> On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
>>>>>>> Re-locking doesn't look great, glancing at the code I don't see any
>>>>>>> obvious better workarounds. Easiest fix would be to don't let the
>>>>>>> drivers sleep in the callbacks and then we can go back to a spin lock.
>>>>>>> Maybe nvidia people have better ideas, I'm not familiar with this
>>>>>>> offload.
>>>>>>
>>>>>> I don't know how to disable bonding sleeping since we use mutex_lock now.
>>>>>> Hi Jianbo, do you have any idea?
>>>>>>
>>>>>
>>>>> I think we should allow drivers to sleep in the callbacks. So, maybe it's
>>>>> better to move driver's xdo_dev_state_delete out of state's spin lock.
>>>>
>>>> I just check the code, xfrm_dev_state_delete() and later
>>>> dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
>>>> checks. Can we really move it out of spin lock from xfrm_state_delete()
>>>
>>> I tried to move the mutex lock code to a work queue, but found we need to
>>> check (ipsec->xs == xs) in bonding. So we still need xfrm_state x during bond
>>
>> Maybe I miss something, but why need to hold spin lock. You can keep xfrm
>> state by its refcnt.
> 
> Do you mean move the xfrm_dev_state_delete() out of spin lock directly like:
> 

Yes. Not feasible?

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 67ca7ac955a3..6881ddeb4360 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -766,13 +766,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
>   		if (x->encap_sk)
>   			sock_put(rcu_dereference_raw(x->encap_sk));
>   
> -		xfrm_dev_state_delete(x);
> -
> -		/* All xfrm_state objects are created by xfrm_state_alloc.
> -		 * The xfrm_state_alloc call gives a reference, and that
> -		 * is what we are dropping here.
> -		 */
> -		xfrm_state_put(x);
>   		err = 0;
>   	}
>   
> @@ -787,8 +780,20 @@ int xfrm_state_delete(struct xfrm_state *x)
>   	spin_lock_bh(&x->lock);
>   	err = __xfrm_state_delete(x);
>   	spin_unlock_bh(&x->lock);
> +	if (err)
> +		return err;
>   
> -	return err;
> +	if (x->km.state == XFRM_STATE_DEAD) {
> +		xfrm_dev_state_delete(x);
> +
> +		/* All xfrm_state objects are created by xfrm_state_alloc.
> +		 * The xfrm_state_alloc call gives a reference, and that
> +		 * is what we are dropping here.
> +		 */
> +		xfrm_state_put(x);
> +	}
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(xfrm_state_delete);
>   
> 
> Then why we need the spin lock in xfrm_state_delete?
> 

No, we don't need. But I am trying to understand what you said in your 
last email about adding a new lock, or unlocking spin lock in 
bond_ipsec_del_sa(). Anything I missed?

Thanks!
Jianbo


