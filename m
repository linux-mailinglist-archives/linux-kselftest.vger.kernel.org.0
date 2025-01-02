Return-Path: <linux-kselftest+bounces-23811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B09FF5CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 04:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03843162351
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 03:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22617996;
	Thu,  2 Jan 2025 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fqoFUtW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D7B652;
	Thu,  2 Jan 2025 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735788838; cv=fail; b=ED77Sikd4CP+nAflF25BZ/RiX9j7pycsSuh6N6vFvvoWsTs3aIrIsj+6rvH49QsPL0FDULsZVkmP/QUh6fKf+LdpNXQt72EilYX7o8LCEt8223S7Qx9mnNDu/QUcUgWZzKQsPkQKVr3CNd22ZijKRbpYuix8vVyAjIC6YmpA60Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735788838; c=relaxed/simple;
	bh=aTst4+TJ6HMik9BbQrbtdCn7YEV3H/8XnorW0wHchUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8OETqqy//l/MEo/BUidRSveyTpQRCmP8NltjVO/xyrCraAZtSqPNWKf0hMYkTo6c5QkGxezo538cnP+rsbURJV8z8r6dm82lUZThNNmF7oG5dTH1IiEYvDh1VUJ5WeSJQ4o6K0mVCjiPFH/RCFEbzB1JD92h54mQ+3ASZXBw24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fqoFUtW5; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciwKkWRTjfzcm3hEwI6lm5l0S2/eYw+5A2Sbgl0hqAN8a7IMIqm3xwH3fXuR+uMUjmgpqvXpDyZu9bcW2l4Ldh0B8jS2Z9nTXsGa51nRLSZ1lpsJcb3BAhxwl9kgbAmgrJKSJYQAlc++U2aO482nZTW6bcQw7Ff7urI5Gjhuj8oZnYXsdUaMcOu7Apn5IOlzoVzYEx0AH2cMzlD5ndKaR1/Y3M4TwYiZ2Yy6Zee3yEpsbLOfOLm6otqmB9Gy/cMbaN1MoLLv2DZHe8L5uFdo8nE+V7KfoyW2IIMSsS3sm4uRdnO6pN3e72smZM4OldrzvXZdUuvBYpHVjnzpc1zyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO285xg+o5Atvvw8XsDyRUaX50+Jj75H/b6kVPLuTDY=;
 b=LqUJN3uHUiHRYlS0owl9yeTAQYRBK2SK3LFhhRWnlwhkt1YkukZaPYdE+O7wx+GgVVp3JfjJmmORm5/I/IqQFBwL4P8LmfZixYM1FIU3Xg1gWwlEkZGN6UERDyItTmZPEPEsDWpeT3bTKtIbsg3bj4cNOI9Nl0xnlhiWkhFgfyjAHDmP47EDVUAE4/yXzg+la5ZBr09hP09/JWAIe/w0W29wO+UzzOgJ6xj3gHyqWN0Kwpx5mBQDvHCWtKn2N4/3u7faA3Ttou45QvGUTo3vayeLghGTpSxz85CHmFVOJ5EzO/v+wTf3WPKBp0B/bSMvCcebY4uNC3A2nCcMCTYDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO285xg+o5Atvvw8XsDyRUaX50+Jj75H/b6kVPLuTDY=;
 b=fqoFUtW5MIonHq3+PJ3RTYEkcdTrEwz6EGaVRueTej68jBj6lov2Be6CNTr4OCBQbYgfvvKub/imniJkARhQlj8RVQOlX0R00lCanF6oMuEQv5VdgwNoZzCm8yXQ2liNgKZXCGG8R0rXzs7noWDi0Q3j1X922/WWaEMiCZWcR5HTf3CBN6IiEEj+0avVYRqX5xyH1CnD8vLtfaCwWJche40qaznYGjWwTjV9h5uDLViWwEvlEa1udxkrF3S500FJzh47ijHxnA/wBPUplufqoncOT0qM9SEfl9d4oHYgUxVf2EzjlEtFr69eZLY7zC65Q9LdAmPfiQThuCcJOEn7TQ==
Received: from SJ0PR13CA0155.namprd13.prod.outlook.com (2603:10b6:a03:2c7::10)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 03:33:49 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::90) by SJ0PR13CA0155.outlook.office365.com
 (2603:10b6:a03:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.5 via Frontend Transport; Thu, 2
 Jan 2025 03:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 03:33:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 Jan 2025
 19:33:38 -0800
Received: from [10.19.163.254] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 Jan 2025
 19:33:34 -0800
Message-ID: <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
Date: Thu, 2 Jan 2025 11:33:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
To: Hangbin Liu <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Simon Horman <horms@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org> <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org> <Z3X9pfu12GUOBUY6@fedora>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <Z3X9pfu12GUOBUY6@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fcc55a-1fc3-4992-29cc-08dd2ade45a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitvRGxzMWpIWGpteWZOZEZmcGlEZ3RzajV4ckNBaHBqb0xPSzdHSlhCY1NV?=
 =?utf-8?B?YmVoUk5MZUwxaU9LRElxbnF2ZHZyOUwzUGo0ZTBIL29sN1hPdjJ5Q051RzBm?=
 =?utf-8?B?R25SRkxUSWdpblczSFRuUnpLa1l2Q1ZYaC9WRElSdWlQam5QL1k1MzBkVVBm?=
 =?utf-8?B?M0gzcW5VTjBSVE1tL2s1UllmdWtMWkxnSEpkeVRNcnA0ODZqZmJJTzFHdVU3?=
 =?utf-8?B?aDZMVTJrVWgrZ2hxb2IzaDZ5VlhxcWxRYi9WZTZHWjI2WjFURU91N1BrcTg5?=
 =?utf-8?B?S2xheklvb2NCVDlMSG54R3ZkaGNXa1l0cjBrWDZWRkEwMU5QcktUZlhhZGJK?=
 =?utf-8?B?SzFyakM1K2l4b0ZNV0lSTVVvWGtZemxaY3BIVEtIby9LOGt2bFFNVlNaZlE3?=
 =?utf-8?B?b2pRTnFCNjAvTDAvR05mKzY5djY3ckg5RnZqRVB0OENHcnE0cFpTTGovMUhB?=
 =?utf-8?B?cExrT3N5c2lnd0RpdUhrWEQ3NzBqazR3ZjlZcFpYRFE3N3pIU2l2bythRm1Z?=
 =?utf-8?B?NWs0dVJOdDRnY1JCQ0lzZUNSckQ0YlZKWis0MERTWlNWQ1gwRzVhby9lOS9I?=
 =?utf-8?B?UXAxdlgvL2xYQnZqU0tYTTU0MUZzeU45cnRLbEFvRkNacWNiL24rMVlZaVhR?=
 =?utf-8?B?OWZrS29KMWMrRVZaOE1xWWNLYVZvSyt5c2xQZzNMWDR1Ly9XZDlMZlQyVW5C?=
 =?utf-8?B?N084RW42OGhFTCtGaE0xMVF6Znh6V242aEwwK2doZGJFS0dXUjhsMXRLR091?=
 =?utf-8?B?UUlmRHpTTDlad09udmFoMVFLV1hyL0Y4a2YxSzZkbTVJMDVlYUprczdJWS8y?=
 =?utf-8?B?c0Z2aXNaY2R2Z0xqS1dGNmtocHdmOEZlU25LaVQvdm1Nbkpha3h6Zis0WU12?=
 =?utf-8?B?KzY3YVhJNzNXU2VnSlEvSUczOTFRQXR6THhzeVBlSExsNFN0WGY3UjNTQjBT?=
 =?utf-8?B?VDVSamtKRWdKY0JxZXova3dKcjI2VzNIaDRKRlNXZVdQanFjblAzeXhGeXhr?=
 =?utf-8?B?Q3MrZ2ZTclM1THE1WmpKUE5pOU10clVENThRalRkUmpjV3VGZTJxOFVBZ21u?=
 =?utf-8?B?Sk54bDM1di9VdkJ2SEplbUtvN0lnOHlPWDdlek0vbkxlMmI5c2M5b3k2Nk9F?=
 =?utf-8?B?b3F4UWZLcm4zaG5NZ0ZhOUhyZ09qZ3NuZ2xSRXQzclJJaW5rQWNMZ2cxMG9o?=
 =?utf-8?B?RlluOFRwMnR3b0I2MTE2YmVLUzdELytxaStyZVBJMzJwVWpja09zYUVUcDNq?=
 =?utf-8?B?cThZTzNURTlhc0F6NkRxQ0QrM3lyd04rV3ZVRmVSSkdjdG4zUTdieHRoSjRx?=
 =?utf-8?B?KzBHbVJjNWplNWZ6QWkvdTBXMXRXdEw1Z2tXZWwyajQ1UXVUVTludEl3eFhN?=
 =?utf-8?B?UmtsUmNhVzEyaTBVa0F3eFNOczRpN0pqWklSL1hTK2ZPYVJXejZ6K3BuYmNL?=
 =?utf-8?B?UytuWG5aTHFaRTRZSENRWUN5bDJQQUZ1a3A4dGZjRW5qbytKRy9YOFF5NWU2?=
 =?utf-8?B?REJFQVZWVlgvTGRIeXQzLzBLeUlMRld1RUoyMjRnVUk4U2tGYUN3WkdEdE80?=
 =?utf-8?B?RVMyRUVvRUJhc0IzNW1Qbm10eTR4bEhOZnV4K2doU252dW42bG14Z2dSQTZw?=
 =?utf-8?B?SHBPZVBiRVg2UVNrb2RuME03Ui9wWnlQTWd3QUhqUkZMTW5PWU54RmtZWjRy?=
 =?utf-8?B?VGdxandwMWdwR2V5bGFBMTlTcmRzdlNYdzFDUjhTdXlxWFlRelJGK0E5U09Y?=
 =?utf-8?B?WWxEZUZLRTZwdW9IUTFZditWKzB3TEVmWmdqNmh5NkVxMG04MnlOYUtvR1NO?=
 =?utf-8?B?d204WWhQbHdEWU5aY3grVmh0Z2ViZCtRT3h5dVNSZkZsckZIYVlrMFZSWTM4?=
 =?utf-8?B?ZjJlaEZiMkgyaG1mSzV2VE8yRVZuS1d6MjlOOHRlZVRmMGI3bkRCaXRrYnFY?=
 =?utf-8?B?Y0VxWHRIZ2tHR3I2UU5mWlhuQU5Eb3JMYno4RHRQUThnb0l2MTVEeWRUOVgz?=
 =?utf-8?Q?o+B2Rv4Bdqk/sxWESVpCazTFPIAtuY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 03:33:49.4459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fcc55a-1fc3-4992-29cc-08dd2ade45a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816



On 1/2/2025 10:44 AM, Hangbin Liu wrote:
> On Fri, Dec 13, 2024 at 07:31:27PM -0800, Jakub Kicinski wrote:
>> On Fri, 13 Dec 2024 07:18:08 +0000 Hangbin Liu wrote:
>>> On Thu, Dec 12, 2024 at 06:27:34AM -0800, Jakub Kicinski wrote:
>>>> On Wed, 11 Dec 2024 07:11:25 +0000 Hangbin Liu wrote:
>>>>> The first patch fixes the xfrm offload feature during setup active-backup
>>>>> mode. The second patch add a ipsec offload testing.
>>>>
>>>> Looks like the test is too good, is there a fix pending somewhere for
>>>> the BUG below? We can't merge the test before that:
>>>
>>> This should be a regression of 2aeeef906d5a ("bonding: change ipsec_lock from
>>> spin lock to mutex"). As in xfrm_state_delete we called spin_lock_bh(&x->lock)
>>> for the xfrm state delete.
>>>
>>> But I'm not sure if it's proper to release the spin lock in bond code.
>>> This seems too specific.
>>>
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index 7daeab67e7b5..69563bc958ca 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -592,6 +592,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>>>   	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>>>   out:
>>>   	netdev_put(real_dev, &tracker);
>>> +	spin_unlock_bh(&xs->lock);
>>>   	mutex_lock(&bond->ipsec_lock);
>>>   	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>>   		if (ipsec->xs == xs) {
>>> @@ -601,6 +602,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>>>   		}
>>>   	}
>>>   	mutex_unlock(&bond->ipsec_lock);
>>> +	spin_lock_bh(&xs->lock);
>>>   }
>>>   
>>>
>>> What do you think?
>>
>> Re-locking doesn't look great, glancing at the code I don't see any
>> obvious better workarounds. Easiest fix would be to don't let the
>> drivers sleep in the callbacks and then we can go back to a spin lock.
>> Maybe nvidia people have better ideas, I'm not familiar with this
>> offload.
> 
> I don't know how to disable bonding sleeping since we use mutex_lock now.
> Hi Jianbo, do you have any idea?
> 

I think we should allow drivers to sleep in the callbacks. So, maybe 
it's better to move driver's xdo_dev_state_delete out of state's spin lock.

Thanks!
Jianbo


