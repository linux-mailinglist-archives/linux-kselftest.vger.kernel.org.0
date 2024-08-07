Return-Path: <linux-kselftest+bounces-14917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773D94A145
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 09:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB791C2514D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 07:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC6A197A97;
	Wed,  7 Aug 2024 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bD7XIhQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C917ADE2;
	Wed,  7 Aug 2024 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014014; cv=fail; b=D2cZRHTmLxSPFJaoZw6mXiu4Rz4V0ZHEku3UCoXIQo/DgMTKrh3hVktyRMOJSN1CFTbeIY+QFYkNkE0scJqbdoe64q/k0fZTTIap/THEOoQW56qzjGVXdqxXdsWPYHZexRHh1EAigxu28OufKeNCL9ysa9Tk3DWa3njyNIchNKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014014; c=relaxed/simple;
	bh=qKGotrXjiY119mKCE799NOwZm5vDFmPXVYxxTcYMOXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8SLgA4T0irH3LHmE2TiGXd9zZ56NTU2XwXDAFmFaNnbosJpCJsgm36p0LmD0+5rIpP4ts527aFN9YI79thEw7yDdjwa4vO+Ky2nvL2CKSCc8T0uPdiT+F+QdliuUh5PZcpWeRRFFeLN5GDJQkh76DjiAa0faiBMyullqFOGvTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bD7XIhQQ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u483L3dORFa2NM6Q42zmQwvZWG5JyAMn7/Fu2AxSe6ci1cRNsIj6xND7CpIMs8+D0cDEjQA9xbxEmpZbO4BLd0qDgh3dLAKLxKD+OOwdOT0LRlLdRzkLPK9vli45HCWJPNqV9GALWTDhujJpI4rppEiQwki7rkafkrkDarMsQgBEkeQJ/oLvVTL+pTzFCO1vUpIn6GgmC5nYDUiKgys7FaT5oF4EY+ShxD6o12tkfKkpAYVCosQu2VombIdUPVYYSALSIwWnlF17CxpWSq/xXWnqtnizZdJDDof5wxAZXk7PJBlaPePY02Rfc65RBCIJUgixmTsZ6CNvqwV8v0QRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGpv/NEnr+OvOTzbMrPAADXwWZRW0T9pviqYjD4JRoc=;
 b=kwvMi20IgCeoI4+ANyOF9jFm/7JVA5B+ToUScgSlnvttMg6cmKudO0gsJ+/iECxYPCQGT2nZdWXEBcYM6mkYiuqS6mDZqs9JU6NqIQsT6UVWrlaYUr/OiTVuxwuQAASaxzoySLMuaBmb8PXB/K/gKGH1OVWFcpqAQ2gQsgCPYnrsyVVkvZm8Dsb9yGhIif6RtEZUUsCha6jqFFTw2W0WLXeNPac78IVYrj95Agytju3qtaUsduyho8dJiEUVUan2h5CeR4xvYuw0tNH6sVdG+7qEG3G8s/xIUulym0J6ZqXFYjlTW7S4LMJwOrWDUeqgOAED6kKu6eVd4t4ZgvBSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGpv/NEnr+OvOTzbMrPAADXwWZRW0T9pviqYjD4JRoc=;
 b=bD7XIhQQIu2SLDMqaIYbGL1/uZKh3FpicE0D4seZz9zgkqFvdaPSlwg3Mhi73MVPR0/mk3syWyJOyjcji2VuhjUdAQvBczqdEZXJYOV3yHkpYNil4T2XV42nVvTO6V/mwauLIDWQ9IjMRlXceYW69OK5tvIjr/fjQ8A2L+zLoM22slxo5KGybf4estlJkRikHzVaUSx+fnOZaanxPuXEa9bEQeAeA5sAZLAz+BAGfcOOy161Kngp3+zZukxYrs5iGDPVRSojn9pzydg7tbxE+Ha5Ie7gD8AnezVqbcDztBbJeIgGPymO91rrYCmTKjXviAZTUkdCYxa4+BGdVuF/8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 07:00:09 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 07:00:08 +0000
Date: Wed, 7 Aug 2024 09:59:56 +0300
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
Message-ID: <ZrMbbIrNpCISI63I@shredder.lan>
References: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
 <ZrHTafNilRs6dx6E@shredder.mtl.com>
 <a22d9e0eb835e40000bc1955b57ae115ae44353c.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a22d9e0eb835e40000bc1955b57ae115ae44353c.camel@kernel.org>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: c2581b88-75e9-4f71-93f0-08dcb6ae92fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?s/ALGVfOripf5rYHw6t5SxeTkqAyR5XMZBSkeZWDK8c0EhVTKLhTkZZEct?=
 =?iso-8859-1?Q?McHl1pp7HpiL4F6wiOfUPtVEw0SD7XXriH1GBqMzx0pi/iiELh7n/xQRmT?=
 =?iso-8859-1?Q?p4KaJpOWZ+vPv4tRjfO2NIQoKXmOtkv6mjiMAOdUhZNsVZXFCCy2ZGiESp?=
 =?iso-8859-1?Q?BNzQawynITIdta0zrAWM6FyQmdHx/m216+p5mx6VRwzNpx0YGp5zhrvAqI?=
 =?iso-8859-1?Q?eBCyWD5TM0/FtB3hHjcDJv7s4FI/AtyduM/cuCB5lx67G8eIW+bMW6mVNb?=
 =?iso-8859-1?Q?3sVZTz9kXrL3E2vrkHoNQTpvclryroL/JjwoTuWV78HaHV/D452dygK/BH?=
 =?iso-8859-1?Q?rIQY1YnHpJJniYrsFbRBAN1sD555BEyVMG+8O9rOHccpsu5FZgmxzRmmlM?=
 =?iso-8859-1?Q?u8BRFoz28/zXW6DGVotIwjPqj/JdSfhikExOJyOIOcZJsJSRTJi+TGP+oA?=
 =?iso-8859-1?Q?q2wXx1M9MZgHR29EGQmvp2q1Ooxevh34zLw3/U6mOt3sA7aARqnd9EuAbn?=
 =?iso-8859-1?Q?F1GsA2KPPuI7H+8jW9dpduFpwsJE+ExLpCEDIvhMIKoYoAANqIfdP2526W?=
 =?iso-8859-1?Q?QzZqEeieggqsJYKQ6QLW1DNgL6gGdq5Ksg5UmLbKXAflILg5SnZb6RaLcc?=
 =?iso-8859-1?Q?UGMB5LsinQPU+zp081Ti/Y1Udk9BYNUwiqOflzlzb0MK7QnXOMAuwWPf0G?=
 =?iso-8859-1?Q?TinY7PzqacKt4YzQqEqUM4w2UufANdd2bjM5i26AR7vb7SN3nSKZjgiUem?=
 =?iso-8859-1?Q?8Mf1g3qBZgvLpj26alFAw5/OF2vQCiTUeMwm3YjeuzmiyOWYSlKuIDIw42?=
 =?iso-8859-1?Q?1eDW7ATx29ZzG25CWVV1isCFvmLF4T31X7ruJWDvOz/8/6KbRTWVCaz7XI?=
 =?iso-8859-1?Q?KMA4qiBhyhIJ2wigvOilnuieZhDIoGsQQyx6ug8SLK6tKBYLLDy2Cus9c/?=
 =?iso-8859-1?Q?n25qDxOSeTWLtqPhKbARWX5lpLJyJPJl7AXn3hBsZZJjLIKW8UEvomaMXa?=
 =?iso-8859-1?Q?x8WOxC3u+yAcjqKSdsnRd+Ly5oRZ+aC+yk1kiT+ol93XishhY5QBbV/h/I?=
 =?iso-8859-1?Q?msyIBGgFzH3Sn2JMbAcTCOR1c3kfXrnabnx5cH410ZspsrfWMVFwnd8FiM?=
 =?iso-8859-1?Q?rul7KrSLl+kE9hNt82AlbHqDv0wtVyPorQkPQmumZ5x6hPJGqF7Hs+sAAD?=
 =?iso-8859-1?Q?ZPVmAELpW0bDJZWHFwqK8b+ANf3i9H5c6g4lGUwzlCM3NJkKV/9Y1FZT2s?=
 =?iso-8859-1?Q?GojsSX5nXIh4VGrn4qRxZBfdu4P2pm5QP1dwjhBxzkaWjEdRtg1SBGH/65?=
 =?iso-8859-1?Q?NLPAIjPWOrClWYB7FCku0brj7mvL0JHYY999q9L+5OReJLlNyRrCZhKfQD?=
 =?iso-8859-1?Q?UT0YyRuRJvxzTCWTq19OKAMY4AacMHDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?yUtGmsR1ODS40pOHksWKUpwRmuORO/xkLsw+jzESTa4k+vqWn43RSrsGFe?=
 =?iso-8859-1?Q?mVQEKhOAeeYvfamUgTk195E/UXf/EQSGumPTSN+lUc4k4pvE++bowiQ50e?=
 =?iso-8859-1?Q?XENhohJL3aoiyfRGnjVsnd7QKV4PsREmTjDxWRbSnuoQZyfvdyv0DPLepX?=
 =?iso-8859-1?Q?dkbQIIPoVvatFe3lw16LNQsiGiBXSUH/VMqcywnIsNLnBQOtY11PV7XF3/?=
 =?iso-8859-1?Q?q5zaHRb64qVj4w2e33X0n0E17exFpr4WaxmR7hGZbKv1vPbs93WT7HLpJI?=
 =?iso-8859-1?Q?cTb19qXeLn1UDY9vNwGhwQ9dexfWOGg6vyEDxK/LGUfhka5QV6jELxnnp9?=
 =?iso-8859-1?Q?cvoYwPR0v8vwAypRa9VvhTnLYjk7uCTw1y9u3H5euF10BM6kZSe0mQFfX5?=
 =?iso-8859-1?Q?SWpJWVkjuRG45KkZFjCiwASg/r9cMUS+6iS4mkVb+pf9Bzo7woDkOd18a1?=
 =?iso-8859-1?Q?ShAaR1efIr5Z6Fu+JNhYxswvuk5IzbdcMzlHkIjjlIIKiygiHa6TZtpMMA?=
 =?iso-8859-1?Q?GbaBhnKwZV+HX3/d/SJlMkYdShNHt2ap9vYBm/sbxETxF07rK5efpxsPMR?=
 =?iso-8859-1?Q?vPIhrYjM/NsU9YOmnVJ1+54vToclRR7XGJDKtw4Af8Uu/Epu1FNj4xnWnM?=
 =?iso-8859-1?Q?L8cy9vEaQuXZBOto7TPq3CvDA/JNxLZLiC4bcPbtQBBaksQGi8di8KAlQm?=
 =?iso-8859-1?Q?VmI1eCGthLsvAs3qqhkTdtLhlGBd7bmtcLkKtlE8+HfMljZEapW1yrJduD?=
 =?iso-8859-1?Q?JKEjqTVTWPqwEJe7NjdAMXN5JnYFmZarBnPPOZBGdDLPtG0CZWSV5eOFLM?=
 =?iso-8859-1?Q?q+c00ss1VcxpwSdXbufDNoS0GN9McLbl2LDgvQ7x2SvwtcC9PQX1ym7Iwt?=
 =?iso-8859-1?Q?xfeN2jtICKJ7WWyn/xaJsHzV6lb2tkJefylHcDSA02YsOy009TNPHJ2nye?=
 =?iso-8859-1?Q?gohFd9t5Ax3yvxPcdWC+vxKIrp0/qax0J/idcSSAr4SlrILbSKHDyzIC8P?=
 =?iso-8859-1?Q?7DqwiUjTvNDepIpaSSwoatOivSS2i6g4V99ta4ZesaDbhTc2XF2Js4mt4L?=
 =?iso-8859-1?Q?8xwV9tRnHBrlP90EHOvGq9XTwEjiC8+DhAGOmk6yD0UvndiExV/6GfPhj1?=
 =?iso-8859-1?Q?IE2iv+jToauLTlvb5t6WrREWDxGMn260/DtIGWhJADyCWlGFCbheu2htM4?=
 =?iso-8859-1?Q?dBD8SRUjpKTLAyj5Sdj6NfjPria6DPH0e90Ovw71Te0FnCuDW5GOjDX64W?=
 =?iso-8859-1?Q?hEIrF4QHehw46hw4MS2FDidXcHh/sQY/KxjjhpLaQ7nWSUWZ6/K6ZWoZZv?=
 =?iso-8859-1?Q?iVOXyPV63yVlS1UxJNMalnEc6UhkVGaKoiDX6mTSpBZ0Dz3MqLSHSRBVS0?=
 =?iso-8859-1?Q?q+85gvGtnd52dAgIq5IUagQlPv+k/Jo+p60kjSKM3QInN8scYce+Ox7kkf?=
 =?iso-8859-1?Q?qAuDIBAOarNEUFXowW/K1oEt027ckQ26h0HmS2x1ex1C5QFNejL49Xsacs?=
 =?iso-8859-1?Q?W8DAwyDUB+RxVlyYsX0FzBLJOG/zODvB3YpQcEdgHzUGAF/CBMa7IW3FqO?=
 =?iso-8859-1?Q?PZsGtT2TXA8PcS30OxnkzTeC8BTsKYJ63nTorsYXrO2PbaTW9OCcZ9DEZK?=
 =?iso-8859-1?Q?J4uuJJ4GR0acLyPVBPjO8Q9rpwVVGsiyn5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2581b88-75e9-4f71-93f0-08dcb6ae92fc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:00:08.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXlt8fGJZ+uwOc9pHJZheh9NC11Hs4hXjQrOikIVqNpv7c6N3rcg1vooqTmO/1vHgFt28lrPOsKljRSs39fhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086

On Wed, Aug 07, 2024 at 12:08:15PM +0800, Geliang Tang wrote:
> On Tue, 2024-08-06 at 10:40 +0300, Ido Schimmel wrote:
> > On Tue, Aug 06, 2024 at 12:20:38PM +0800, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > So many "Address not found" messages occur at the end of forwarding
> > > tests
> > > when using "ip address del" command for an invalid address:
> > 
> > Can you give an example of an invalid address that triggers this
> > message?
> > 
> > > 
> > > TEST: FDB limits interacting with FDB type local                   
> > > [ OK ]
> > > Error: ipv4: Address not found.
> > > 
> > > ... ...
> > > TEST: IGMPv3 S,G port entry automatic add to a *,G port            
> > > [ OK ]
> > > Error: ipv4: Address not found.
> > > Error: ipv6: address not found.
> > > 
> > > ... ...
> > > TEST: Isolated port flooding                                       
> > > [ OK ]
> > > Error: ipv4: Address not found.
> > > Error: ipv6: address not found.
> > > 
> > > ... ...
> > > TEST: Externally learned FDB entry - ageing & roaming              
> > > [ OK ]
> > > Error: ipv4: Address not found.
> > > Error: ipv6: address not found.
> > 
> > I'm unable to reproduce these with net-next and iproute2-next. Please
> > debug this to understand the root cause or provide more details on
> > how
> > to reproduce.
> 
> I did get these errors with the latest net-next and iproute2-next. For
> example, I got these errors of "bridge_mdb_port_down.sh":
> 
> $ sudo ./bridge_mdb_port_down.sh 
> TEST: MDB add/del entry to port with state down                  [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> 
> These errors occur when using h1_destroy() and h2_destroy() to delete
> the addresses of h1 (192.0.2.1, 2001:db8:1::1) and h2 (192.0.2.2,
> 2001:db8:1::2):
> 
> h1_destroy()
> {
>         simple_if_fini $h1 192.0.2.1/24 2001:db8:1::1/64
> }
> 
> h2_destroy()
> {
>         simple_if_fini $h2 192.0.2.2/24 2001:db8:1::2/64
> }
> 
> It seems that when invoking h1_destroy() and h2_destroy(), both h1 and
> h2 no longer have IP addresses.

This is unexpected, I do see the addresses on my end. Maybe you have
some network manager that is deleting these addresses for some reason?

Try tracing __inet_del_ifa() while running the tests:

# bpftrace -e 'k:__inet_del_ifa { @bla[comm] = count(); }'
Attaching 1 probe...
^C

@bla[ip]: 2

> 
> I added "ifconfig" to show the addresses of h1 and h2 before invoking
> h1_destroy() and h2_destroy() like this:
> 
> '''
> @@ -105,7 +105,9 @@ cleanup()
>         pre_cleanup
>  
>         switch_destroy
> +       ifconfig $h1
>         h1_destroy
> +       ifconfig $h2
>         h2_destroy
>  
>         vrf_cleanup
> '''
> 
> And got these messages:
> 
> TEST: MDB add/del entry to port with state down                 [ OK ]
> veth0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
>         ether f2:ca:02:ee:05:19  txqueuelen 1000  (Ethernet)
>         RX packets 149  bytes 17355 (17.3 KB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 81  bytes 9165 (9.1 KB)
>         TX errors 0  dropped 12 overruns 0  carrier 0  collisions 0
> 
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> veth3: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
>         ether 92:df:97:5c:98:7e  txqueuelen 1000  (Ethernet)
>         RX packets 67  bytes 6252 (6.2 KB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 39  bytes 4997 (4.9 KB)
>         TX errors 0  dropped 56 overruns 0  carrier 0  collisions 0
> 
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> 
> -Geliang
> 
> > 
> > > 
> > > This patch gnores these messages and redirects them to /dev/null in
> > > __addr_add_del().
> > > 
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > >  tools/testing/selftests/net/forwarding/lib.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/forwarding/lib.sh
> > > b/tools/testing/selftests/net/forwarding/lib.sh
> > > index ff96bb7535ff..8670b6053cde 100644
> > > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > > @@ -839,7 +839,7 @@ __addr_add_del()
> > >  	array=("${@}")
> > >  
> > >  	for addrstr in "${array[@]}"; do
> > > -		ip address $add_del $addrstr dev $if_name
> > > +		ip address $add_del $addrstr dev $if_name &>
> > > /dev/null
> > >  	done
> > >  }
> > >  
> > > -- 
> > > 2.43.0
> > > 
> 

