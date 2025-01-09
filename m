Return-Path: <linux-kselftest+bounces-24126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF12A075A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 13:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2982160BAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3D21765C;
	Thu,  9 Jan 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OziUo3qz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68721518C;
	Thu,  9 Jan 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425344; cv=fail; b=E+xBK0jiZakmxYTp/FyXnSsfC9DcutCpQrkI7iYNajeZevc9nqc+f8ziCYYhZjTupufzOSUChsxLwNjlcFt+v17gnrNjpG7mkyLA54OoBUbJ/fsxCx/EVC1qqIIAbZNV+R1CQkwjrRyOjxxCeTpqE44k0X91/Y1/N1BttCipU6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425344; c=relaxed/simple;
	bh=3JIjvlvvhfm+873yladaYZTl2VsR4hfg1o8wTyY94/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RLVOOkcAlBLZw+EXkA7+YOQgy1VVXgJOUFqw/ku4WOp2ut9oHRjIguUb/oxophobtQENCbUzGXtDX5WHCLlfLmdBwpfGL12yWH60kxyZoYlmO+Znr6Pt3ejRPWqmmerzl8gr1k8Ia/pR+hrC4gx+Fimp1f4/9Eu0OkU0IR4vD04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OziUo3qz; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma8vcSidbSvWbCaKP1IMv6xP3CSj99o4K+bOmtEY5nLKBMASb/dpF0gOFUkM4hpr1689t0RUUF7WZxOFZhfdfVxzlXqdE4BBsiTexIxSqgPcI3z3uQy4FfFyJ+61jOSb0QpTNsL0uhZwBqc9BVv1U/jVU8ZHUvXjPL3qW4ywmeiEn0GX4jeE5u/1Hvq3zrvcFf3Se82NuPba3AizbLMg9/l0INzXIum9tZYmrZAL+y1NnHD/d1tB3k5A01mJYomYA+Lahk0skylv6XpzNvnU8DbZdE24a5rZLm0R5N4vKr6R/QreEzRYV8h1DifHfQkdqvAubh08Blowp6FC/LijtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6xRdghBMN5Fqvus05aVptthwo+mLUeHKrZrjYVc3NU=;
 b=hPO6bPX9biwBn5MkZqJ27m7LuOAGxK1I8/eIa/2+FoI/nG2RMdCYeA/mXcW/FoahRbRh2vvy6TBbGT6SQdp4ZFtHSS3mvxVpqtuEGhFbp+tXejURfdYBQjYdnI64rMf+e5aKKp4Js31BIHHkJ+d1IRQvF/Cc04Qw0wXcgilWH3EdOba/SibXQoipQx8XphR9DQEA1S+g40ARel0iex/+E+QziQ+DMa/UndKEycdj6eCBR2T7NmdprUSB3Hm3xYYte4WeKnn4AqCqRWRpXRty4iTNaGk+1nMmMpRxkJ2hdxDzoLc6OXkUPuz8Q4C/zpkis+g28Au0P4ZS2sHn7ZClCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6xRdghBMN5Fqvus05aVptthwo+mLUeHKrZrjYVc3NU=;
 b=OziUo3qz6LSjh28FcgrpvdNWzTlkHSWKdOuhd9+GDO7CXPd0LUkSHezzDJeIQng4zfj2y1ONDSh/D5LpI+TbI5H/QUDZbyir/8t5XrD4Pd14RFt32GcrZ/+kqs/DQQKflgeiSMNURyE7reamwSokB++Tbmy5ADLMHspk8oOXnY7y9pZksGcg4XhSBQIcRAQU61fcIZk1u3MEquuL0IMxByE4fge1Xh+4X2+DGimina77b+hTatWudruf+4g836oSfgb0LbdKIWBLrR7OEgKybCRdWJdh3XzndvKO1ewe24jc/LMNuI1Xw1KTP8f998BPCnHvUSNc4N/VWbA2yr5ZmA==
Received: from SJ0PR13CA0162.namprd13.prod.outlook.com (2603:10b6:a03:2c7::17)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 12:22:19 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::43) by SJ0PR13CA0162.outlook.office365.com
 (2603:10b6:a03:2c7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 12:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 12:22:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 04:22:04 -0800
Received: from [10.19.162.113] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 04:21:59 -0800
Message-ID: <459337c0-c625-4c5f-b668-19f24285ff19@nvidia.com>
Date: Thu, 9 Jan 2025 20:21:57 +0800
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
References: <20241213193127.4c31ef80@kernel.org> <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com> <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora> <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora> <e01bae5f-30b5-4ec4-8c4b-5c133dd4552a@nvidia.com>
 <Z3-KxbofkhOrWin7@fedora> <b39dfbee-dd80-48b2-b79c-29682269522a@nvidia.com>
 <Z3-iHO1gqQt3T0Tl@fedora>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <Z3-iHO1gqQt3T0Tl@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fd783f-fb60-434f-566f-08dd30a842df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFc3c2NxZENMTE1XN0hEejkwKzBMTjdObmlWNGlxeGFxWlg4VitLMHoxLzdS?=
 =?utf-8?B?MG1IRWtKaTlCbWUyQjNhbUZZN3NlbDFMVmE5d3A5THE4WlVMWWRVS0doU3Fu?=
 =?utf-8?B?blNtd1RpanhsaE50WmRSUGJ0MHhQdHAzbkFKVm1pbGkwQUhVS1VDdWs4TUVI?=
 =?utf-8?B?R21SakJLK3BaN1o1dDJZYnliVGZNNlNON2xUVWhEQVltd0dFMjczVm5wM1Ex?=
 =?utf-8?B?ZUJKMUQ5c2wvaDExbFBJdmR0cnhxL2JhUlZZeUxyc1B5bWh3V1BEdmhBSzEx?=
 =?utf-8?B?b0RuQmlUeWdTc010MHJJWmRONWhia1dtNDF5NlVTa3BITFJkZC9ZYUpLa0xO?=
 =?utf-8?B?akV1dXFWMm55Vk8xUzhQNTcvdGpIMXhiL2dscnBMNG44TWxYeklYUGhETndE?=
 =?utf-8?B?TUlCaVVZUTAzczR1ZGptZ3d4b25tS0tMZWFobXJxMTMya3VqWkZXbUZ2MXVU?=
 =?utf-8?B?cVFCTTNhclV1ajdoK3EvVExSQmlIU1VQNGN6eWdjUWRrUzQ4OVlKZUQxbFVz?=
 =?utf-8?B?WnBSTnhXandjaGQxdElFbGVaR0VXemdSMFU5U2lxWjVYTTllMFM2K1cxNjdl?=
 =?utf-8?B?Z3ZpVTdSWFdnbG5pZW5SaFZnK2VwdFU4bER1WTBjNEhkM0prOGF1WGFwbUxV?=
 =?utf-8?B?MDViWG1ERFdsUG0zQit1TlY1WksvN0pnaU44NGJSY0d1by9FVk1SbmQyZG5a?=
 =?utf-8?B?SmZFakZmUFp2SHdUcG1sSGpGOW9DL1pyUnJaYjZkUkZPSDR3OGNkSXc0TFJj?=
 =?utf-8?B?bVNaYjZZUlVUS1Z4emNVMUR0ejJBTnhOTll2aTlXd05udjBsSlRlbHo3dCtz?=
 =?utf-8?B?M1BENnk0bmp3a3p1WXF1VUhGWDBJWmp1b05yVVlsZDM4ZEdKVGVaNmFvZjZ3?=
 =?utf-8?B?TXBrUWM1b1A1ZVhhRDFCVUFyL2FuQ3g3LzhLZG1oY1EzMkZpSS9YRFJ4ZWFC?=
 =?utf-8?B?Z01Ibk9vejgzRkVnaWlQaHltR0ltSXluVy9rT3NpTHNpT3Q4WUJEL3Uzc3ZP?=
 =?utf-8?B?Qyt3UDlQNEd0SFRtKzNmUHpCQmRucjZNWUFqclBGbkdScEM1ZEp4Y0RPRVh0?=
 =?utf-8?B?bHNyalV2S3lIN1lsSGMzaUVRdmpic1JvTGhEUksxMFREUWVQaVdIdm9Fb2V5?=
 =?utf-8?B?bmNMOG1vYVZDTDA0RFRGM2luaWtiNDlOVDY4d2RISXRjYURzdk5NKy9OeFlY?=
 =?utf-8?B?NHdYaTNjQS9TVUdoOWtILy9mQTZwb0x2eEI1dGtNWkdKSjNiUFJRYk8wOUpN?=
 =?utf-8?B?UVJmYXBpczhSc25PbGNWUFFNZkUrVERXbm94RlNjUHlkeUJLdXhPL2g2cUtO?=
 =?utf-8?B?UmltclQ1djY0TDhOYmtuVExmVm5FUVArT0wvVzZhT2VjNFNGUmhPRHZIUXZG?=
 =?utf-8?B?NENEV3pNWEZYV2VJMHg4aVQxSFdGN25OOXpaL1VDUHNHak05dWR3ZVpYdDNU?=
 =?utf-8?B?YmJLSk1DT3kvTG11MHY0N0lQYXhid25vSWhXelFOQXl6Sk9jZzdrdk9OVjQ0?=
 =?utf-8?B?WDB2WWR5bUd5QlBWVEs2QVMwUFFLakR1QUlML05qclNEZHYxZjJpUzVUdkJO?=
 =?utf-8?B?aVVjem9MNDJRU3lRb2xGYXo0RU51cVo1YzEzNVNEME1EcjNkYkpUWUVIMDBk?=
 =?utf-8?B?WThMcGs3WllhcVhsRFFuaXUzVVpTMU1YNzUxVEpwWXErZnp3T2dyNzB0RmZq?=
 =?utf-8?B?VmNZR05MVnR1Y1NOaytDN2RXYUprZlUyNTRqQlRDdkNiVWRTT3pSOURUN3Nl?=
 =?utf-8?B?cittNmVGQlBYdE5zbVZVM2RYQ2E1VmVpM2hGSmdYV3pqaDJGdkZoWHNMRURj?=
 =?utf-8?B?eTFJOE5lZW1Nc0k0cVkybHI5cTU0dXU4WU80ZGxqTXdnMVRMbkIxbnEyMGJI?=
 =?utf-8?B?Nm50dkNwSE9QOGU4Z3kwZUMvQTBJa2U0N0VFNDJYZzFYZkVEajhOTzBmSHpS?=
 =?utf-8?B?dS9xL3BuTllvRytLRVpxRnE0YldTK1hkUUJ6VkYydVQ4eVF1MVNtaWtqVFRR?=
 =?utf-8?Q?ND6o1T1Fk2m0PEVMosomOvQexM0joI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 12:22:18.9487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fd783f-fb60-434f-566f-08dd30a842df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371



On 1/9/2025 6:17 PM, Hangbin Liu wrote:
> On Thu, Jan 09, 2025 at 05:51:07PM +0800, Jianbo Liu wrote:
>>>> No, we don't need. But I am trying to understand what you said in your last
>>>> email about adding a new lock, or unlocking spin lock in
>>>
>>> I *thought* we need the spin lock in xfrm_state_delete(). So to protect xfrm_state,
>>
>> But not need in bond_ipsec_del_sa() because the state still hold by
>> xfrm_state_hold(), right?
> 
> Hmm, I'm not sure. If xfrm_state_hold() is safe. Why not just remove the spin
> lock in xfrm_state_delete(). This is more straightforward. e.g.
> 

We can't remove the spin lock in xfrm_state_delete(), but I think we can 
access the state while holding it, for example, checking (ipsec->xs == 
xs) as you mentioned before, because memory is not freed yet.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 67ca7ac955a3..150562abf513 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -784,9 +784,7 @@ int xfrm_state_delete(struct xfrm_state *x)
>   {
>          int err;
> 
> -       spin_lock_bh(&x->lock);
>          err = __xfrm_state_delete(x);
> -       spin_unlock_bh(&x->lock);
> 
>          return err;
>   }
> 
> We can even rename xfrm_state_delete() to xfrm_state_delete() directly.
> 
> Thanks
> Hangbin


