Return-Path: <linux-kselftest+bounces-14833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BD948A4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DD8285AC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DA166F0C;
	Tue,  6 Aug 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V3W3gljo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC21547DE;
	Tue,  6 Aug 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930043; cv=fail; b=D4DUiE+ZyP5kScLu7nbEEfveyx7n1xXGn+V/n53o9FYtTuEToShHhhJGUu9klo3lXtiY/wUZTPQDEO6EJgncPgKBJ+3Um2AB5GFoEoXDLhlKdrLdI6nRzU0kFBOFoy+T8pQ/2s9xo+v3z/WOLka++QnEhZH/iDxzqAcPhgNK7fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930043; c=relaxed/simple;
	bh=hDFv1nVCOP/YwNe51Z66JqJmsvPAuGOVflv/XABo7Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q1Mrvz56p5dIA+plYRXuGaPx7zzZM0xgedl4WoO2+xU2mrheAULUUGViB7SvH2vpkKpwEEDWt3DOi/Ma5nka4KQyWORWPEfajMduCyfvNNrGimU71BRDyQ569duYL+nG/+nZml6iHMT4tSL2BLUi7G1EQvx3vbcoRjKYESP8sSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V3W3gljo; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+T03v205ImglGDhz+jnmPfCyK2R0jZ9tLX7yar9NfO81kFg+MitFN/ytkZb20b1jLg9swAiFLoCtMC+C+4dKDTYG9dEf5VluOquzyut8xZhvUQoJbuYbeunsBeCldz5Na8aauEJdvx8mEVSoDR5498UnEwLsedDrvRFVfSnG/cf0S7s7F/pqD5Z+p41OvVv689hXhWtNyIN4+f9Hw0eK5raA2rA7lHBao9cySvSACr/GXNwX/J4IOWn9mWErrXPACongAWfpdprH1gx8aEPzjssp5inbQufdebXIRu+1ITy84UqW7axpeC3RSufFEWHDHycVoD+tnFkmG5ZtDCevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wJMT5gwTVD1OhFdmDLf7iZJBWWT7LPDnAguxkwRVu0=;
 b=XcZvO16dVmgWSHRb1mfQ3fh3JeH0+lx9psX8mcw2e2G/uIZDgETIwbqBBNxujGip2FB4X9cI6syXixLtMxlejpybUal4NCn6ofFLXuEPFmmK6o3gEqo8MioghDWxPsYKl2aHB5L9g5UlA5JJ2GEf7ifnxuM1G0O1jUIliiVH+yAtVo2CQUUJSj33I+XoSF62yZi1eib2UXqHL5efD4UpouyfS35cU0OEQjq27KO6D51o8rkCZrbvZVm+wUC0jrWEqJgiEw2V3xtn/XYT0bC5tBZ/E8tJFeMNmRVj5JqjIxPOLILbfi5dJkOG6qR/rEtCZoZAGfVzplAcE/RQRSdF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wJMT5gwTVD1OhFdmDLf7iZJBWWT7LPDnAguxkwRVu0=;
 b=V3W3gljo1tjoW4wS8JBUW5d0NnP2AfLjYcfIq/nrjq3KhyqsZqQ6o0zpzzk6Akl9pmYkfGK2TEwLJOGBYyC0a2bRxpIlJxHURUSJqQ4oAj8le9VTfJiRVucXBofGOzteYNS9EIql3hNBbYFwwjI7Vc8KwZ33bI/5T8Z+nxUBwJTuRDf8l8EadgzIMZ15FaLzP022hfobB3sHHzEr1jL7ZwiRDr694eoKY8vF/vleMoq1c/pX7aXXlxSCE+2kqoxBQo/kOg9m6DJlPb8EJg7HNXwx277W8Rk9cILmjQl2VgacA3ssaOQIekWzWfLzaH495G+4bUvxt0WSbwjHAwwRKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 07:40:38 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:40:38 +0000
Date: Tue, 6 Aug 2024 10:40:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Geliang Tang <geliang@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: lib.sh: ignore "Address
 not found"
Message-ID: <ZrHTafNilRs6dx6E@shredder.mtl.com>
References: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: e837a245-edc0-4798-d00f-08dcb5eb10a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CogEjQIPgN/EaGUfpoqd7IUIavjugSlR57cu/r/dO30zpa3yBpgf9bHZmcsq?=
 =?us-ascii?Q?2aVxBRtg1N7wUcS1iOrpNWyvdEQn4cUlEkz1skLFo8cKrfAy/Rx/elMZKsRW?=
 =?us-ascii?Q?PF3MC9TpwApERN6EZQlE/F22L4bCrswFBnCq5Xi/T+vz26tsqMjNGiT4YU4r?=
 =?us-ascii?Q?4RYlTtiYNw2TXxxevI7UXFwq0uo6XdYNacWhDf216ZCj3y2RzfEaVG6ziI/a?=
 =?us-ascii?Q?jS3eDcp9PcmFMp7tcbe/tDzLy3LVgzsLVah9GRWSlI2w6MtRhc/sq+4ttrgs?=
 =?us-ascii?Q?tzjW0HHsVfVfrtxQJQVABpFEi9iEbEcvA8GkJwu7I5VNNxyyGVS3vxRXsoXi?=
 =?us-ascii?Q?uQfPUtqKCJVfXXPrOMxvU+3uRTGtebcga3ecOmDEIbLYwC5d3bUyDtx4k2Wn?=
 =?us-ascii?Q?4t3PoGH6Nz3bx64e83BHYj9yf31GRkcle+QTEOOFFKRT/Bi/EJDCXwqkRqes?=
 =?us-ascii?Q?uX0xX3xlGqOfP7nH1aEJFAFivr1q4Ch8EyWHuzVZ/i44iEtncgWINwyeLY5o?=
 =?us-ascii?Q?MHuIHnyywpImIGjWBDD4SrYSFpmqe+qqVIw63vHZ4AtvOPqIUJkpld9HwcO5?=
 =?us-ascii?Q?TWi+FNQFCbUk/GyVju5IoaVoLxvGVtw1wC3nv66VZ5s/B4UAZ9dOWtzE8tSR?=
 =?us-ascii?Q?IaiIAv3J5SDb1x7LcgTtiEGUGa52g3Kd7hgyKPtKnHdUajBCXmpezw/z/80a?=
 =?us-ascii?Q?fIasNehE71J9tvXlsvUxMGylx455XsHsyAa5zI4zLBfhZdgSFXo5CKFfwFom?=
 =?us-ascii?Q?xeEOvZO+7xfOmQ55GDlO2BoZ9TSyjZv115TffbbcicIX74cpapAXYiY+rgdw?=
 =?us-ascii?Q?ubI5AGUlmaD0jNoWWjWYBtKV/ZeWZp4yD5RnNAaP26Tfjb+mRt7qF9+d8/Mh?=
 =?us-ascii?Q?c8jo1R0I+pMgkTkHvSx6DR7t89BmjDtdGXwDzbVaK62e8HldEYP6if0ECiXp?=
 =?us-ascii?Q?awKvmjpTAqzz8M84sJ5Q/T7lo9izX8/3UnwB/LUjsMr4aFeN3OZOKGtGIJLQ?=
 =?us-ascii?Q?p46KJKvJQILiyiYTighcfrzi8LI/FEot1hkWV4UC1DPQ9zRhCGkrBqH3QMPU?=
 =?us-ascii?Q?OSQSHGLwRvi9FUrT9Fc7cuwSgwrPMPvRBnczrqf1dX5KCI3yKkch33O4D34a?=
 =?us-ascii?Q?+p6Hlnb0Qh9M3vFr+FkZk/YeLlaGhH2KYYL6Pw+wg7sgmvhRQscHd7Blfoc8?=
 =?us-ascii?Q?wBLcivYCrbcGPkTKAcjvI2CQiF8WJTcYOyjx9iWsJ+Ysf0fY8CWbDSlSKESE?=
 =?us-ascii?Q?EJhyIqUB8cBAUM1DkoZc/tB07ty4b0bh2ChtQrjPz074n124cgVjOY5g9jLg?=
 =?us-ascii?Q?08/Vk8KiFreY1qgZSh30frf41YcHn0YpgVg/nYl9ENCdHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y4pXrkdjIqg09aqQYZ8wSxxjozxMwbPsZCkLxO3lpJbcZ1U8un5cTQUAuPQI?=
 =?us-ascii?Q?bzAAWEDmuN9kt44KdkofxxPX6YK5x7HtQddcE4QnmD5t3M/MjmN1HLmOhJ7O?=
 =?us-ascii?Q?ZyZ41ifmtlMT/MV1dBSUR06/bjmmhVJul4bORTr/HIEyVHhB45mIJCyoAzLf?=
 =?us-ascii?Q?mnZF9+q0vdT7FpC2jiZR4/pIltHM7QytDWHKwcaqdfTT5jPmsYPeV/g4F7dl?=
 =?us-ascii?Q?yNGeYUz6y+miuvYC5UonjlWvZmeyDXln3STrRUjT5ZkruqyIYOennxUgauuZ?=
 =?us-ascii?Q?m1tS2M0QBNWOKlztJjkXdtFNhZpZEvm6oPycsqBwoLwNjCdPGV2bTugPRLKS?=
 =?us-ascii?Q?K3M4CC4VUIOM7X1ULe1C9MY4ObdobdgxwsQGs0ig7rvVtxqC3CPbCKsLTq6t?=
 =?us-ascii?Q?Ddnzz+RCHab6n8VNRV2C0GAhEekBwcU6Cbtczst+n3HrCwH8aGXYIqtXlBTZ?=
 =?us-ascii?Q?+/XA3lDqX0LvNDr4Px0Lhm5uCDOwoby1NyOxdK5P39s3nM3Mx6PJdYYx6y/i?=
 =?us-ascii?Q?45L/wBJ8Iuxh4vOmyNPsO6SudWe3LUclW90mDydCNVZVi3xjD5ndDclbPnWP?=
 =?us-ascii?Q?c+rrM4+BsQxHe/XAm0MCe8KU3udfH5bqhDDDLy3soAy+0a8cxuLwdWpHhZ/k?=
 =?us-ascii?Q?v7W/UYzRhDjdkPYjdHjCW7eCWIahYd3RNj2x7A4CpwHvn6sFbA4jxWnn6hEY?=
 =?us-ascii?Q?9sR3GEBh2GBT78k3Lo1cOdjXBSv8WMMGpeYZLguh1X5qMi/jSLKedRo3iLq9?=
 =?us-ascii?Q?tUfrTbmMVF3qKk3Hvhsbrwc3U6ilMmiD0Lb/F878IacY7PkWpRX84DL7jGiZ?=
 =?us-ascii?Q?ipVeXUUVO46jV70glJdHC6aQ1P0pxUn0tRUBOvm43y0Sv9wj0ViAMEaW1onu?=
 =?us-ascii?Q?mjW4ASNwVzO/d0MoCpVc/wzVeLbHpO+Kadi8LcW7Wm7ZQhlbt8rcreLQLNVz?=
 =?us-ascii?Q?qnTcAFtMv9Y/Z3hOlHdhtWVWxuBGOoTd1mtlrA9gnkiyvjwpYtSD3XretPKe?=
 =?us-ascii?Q?8jMo5AOr7iCOZMkPNlHu6jDMMgV1HOL+zygvH/jcOYP7S3mOJ0SfVzOmS0wL?=
 =?us-ascii?Q?f3jv/kUS+48SHTKQBqOyIRGAoawHmoTQ68VsLyZ6yNJlh+JHN6jrgkvwZAod?=
 =?us-ascii?Q?aLk1JvESowA5jJE4FZ1tzjs63SryGcd6pUuwPEsrO+kun6Kru1mnzBoC1E+s?=
 =?us-ascii?Q?IGUJLcMw5FIhFKwq11rGDYRSpI7/uuUvd/ymT55/w/kw1ZBl8jLdqUgLfV7k?=
 =?us-ascii?Q?gN3Azn/Yos4Ac/xbpLotqS/deAdsKqXs/0tJ/SYs9qRp1CmX3sdhkN2GHPvw?=
 =?us-ascii?Q?R2l9BaXMd1E0E0AKWH0UKq3DRo7fTYTFAO1re/ZLJHZ9sD3Osa9TvRp6Okuf?=
 =?us-ascii?Q?xzqN1YDkMLvfCUNjCY0vFdhLuRiSkBiKg8MMQj+99TD5YpfuFkDmzWu2f5bY?=
 =?us-ascii?Q?u8nFtgBXDeT73NsbxImUWqh0vKsnAxuyLV5cXW/6A9JA2Ii88+gpfM05gGna?=
 =?us-ascii?Q?xBxL9uRG9U4BngFgmj96X1vMNWdpto5Pfhxy4c89qIlo2OnCCrFdEy35bjLr?=
 =?us-ascii?Q?UnXdDXKJvFOz5GnHbBxOO5L9KxioWES9vxujpgU7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e837a245-edc0-4798-d00f-08dcb5eb10a0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:40:38.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lluQcYwquDPEb5vl5aWESdBy3yuQhhIE7YNY1xmRNKNqnXJRWjT/J0m6xwFOVFl5YresrlqiQJOCRjcRCdAFbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027

On Tue, Aug 06, 2024 at 12:20:38PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> So many "Address not found" messages occur at the end of forwarding tests
> when using "ip address del" command for an invalid address:

Can you give an example of an invalid address that triggers this
message?

> 
> TEST: FDB limits interacting with FDB type local                    [ OK ]
> Error: ipv4: Address not found.
> 
> ... ...
> TEST: IGMPv3 S,G port entry automatic add to a *,G port             [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> 
> ... ...
> TEST: Isolated port flooding                                        [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> 
> ... ...
> TEST: Externally learned FDB entry - ageing & roaming               [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.

I'm unable to reproduce these with net-next and iproute2-next. Please
debug this to understand the root cause or provide more details on how
to reproduce.

> 
> This patch gnores these messages and redirects them to /dev/null in
> __addr_add_del().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index ff96bb7535ff..8670b6053cde 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -839,7 +839,7 @@ __addr_add_del()
>  	array=("${@}")
>  
>  	for addrstr in "${array[@]}"; do
> -		ip address $add_del $addrstr dev $if_name
> +		ip address $add_del $addrstr dev $if_name &> /dev/null
>  	done
>  }
>  
> -- 
> 2.43.0
> 

