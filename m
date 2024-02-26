Return-Path: <linux-kselftest+bounces-5430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855CA866F7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 10:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EDB1C254EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412455C11;
	Mon, 26 Feb 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYS5/7DV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248054BFE;
	Mon, 26 Feb 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939700; cv=fail; b=nMxJrili44WEmJh0946sGuWbj2TEJibsgDORMjWwxJvGiE9WACmV/UfEo7ee36faYzfMY9ntqQEqEISH5acx0h3Se4yToTvC7Njx/49N11jYt9wYdGxKii0zPS9ZogzjocyHCPV/hX4CNlnn0sq9wBXGJOs08YRFA1d55yHKAWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939700; c=relaxed/simple;
	bh=+OYWJhnXog3/23twSNh5gced+kMO69mLXgQhnV4qbp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qejsri+IqCIwmxo2vgg2WNTifuEDQ7xPUOdqJ5/khkBdS8n1HbxKgbiMiFHxR/iTbl6uSsVBB5op9xgfjoZQd5RjbUvbsK9m5g7v98ClnMrnvM/yRkNW/wDaNVtqK6JgrKvo7sjQmnb+Y6vQqJWWXuA1VB4mVHjj/M5r3WN35t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYS5/7DV; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708939699; x=1740475699;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+OYWJhnXog3/23twSNh5gced+kMO69mLXgQhnV4qbp4=;
  b=BYS5/7DVzQ703WEdaHRZq+DwgMerey07E9m3/DD7osmL4j8t+VXNsaaA
   qiR3xHuf9NGDHjQOB5uXoBHoVXBS9d9sGwDxnLflQLHPkXdGFCLibvOnZ
   DBdqQyv/mP+hrG4uv27HjBpMJifvvLoFCp8DH0s5OTcuPZ3tQcQstp5g8
   U3nyRTqorLBp4byDX0WRBRryE03f/SzXCpvFu5n/hP4hR+/fTYdJNzLri
   hxwnc1PZaDefz7sP64XOpmeU84ERKYIQEYeGOGdPYvK6U3DwcGsViNbO0
   U/Mu8RUN8lV017LOveXl5avwQLq3Maq1Is3fMKnOaupIR4bD6SpO3pY+i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14648074"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14648074"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6534900"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 01:28:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:28:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:28:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 01:28:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDz6s8OM6Tdhln+c35MNZgV0sPrYRAw2vTf/vSGPwM9fa3epNfTChuGutarJQM7G/lbdcs9ncbbpjBTvxUzYaBlKr7vRODM79ve0wqiQhYsjhpK3wbnLO8Qp3iycPrFBfDoFpEnGoMetiS3D0jcCj4OjeodFXDCBmnhM0Q1/tza71cdQx6bACDoGpk70X8iMLlDOkSbgn3LjAxYDAUSwIIwhtz90teCs324uiVlUFQqMhh4XatPdWSgwZF2t/cHTdHzYBQ8RjKvisjeRkuCFvtWx3Uc2wqw4buHmoDcwmBthDQX/eYkUe4XoyXt6Mqa52j/ox+b2lQRX1JBA/4oyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCK5fUFEm+ASXA6lIXZOTf/7rosHm0NZROkWdmOm/o0=;
 b=JAlTXkovmDS0LCSnmEGin+dF7Q0yU0xiFTKQElyPARpa/h8JgCC+vEtJ9q2cRLpiqqWNMeaBUxt8q3Ej2+aW8dKubgir+YMq8qsy99bpdZWc3xTqU5dQjJ68g/KEvFs4qsX5HeCh2TF3DLEa1lIWdUImeLmZBSJ+qRHOB+yqpwl1FZseNdjl+22symxsq7/QIIGvmi+qahaf8mm+ixGCowTdn98jgB/1lV6/VE+Zdu/gEHc4/sO6Vyv+QNHKQ1hZfCsAHZpAygEPUpr5ov0B+yTDg430fPZqtxJxlwRgzHMQcjBQX81/NdaYaeeH1oln2jjwM55XuIYCF3ozvKNUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA0PR11MB8400.namprd11.prod.outlook.com (2603:10b6:208:482::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 09:28:15 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 09:28:15 +0000
Date: Mon, 26 Feb 2024 10:28:06 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, <shuah@kernel.org>,
	<fenghua.yu@intel.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in
 Intel CAT selftest
Message-ID: <beuizmgezzcnd3f74nsmigfn7n5emj43pxaqtyki7bjgj4nqn5@ldpqu65vaunu>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
 <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
 <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
 <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA0PR11MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f18fa84-223b-41ad-eef2-08dc36ad423c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkS9j0PsgLPhkGgG9n8P0yZm6oQhN+7X/GMvaj+ea7eZ3tgN+wAz1HmzkMO22fJuztzIiX1abOD/3GNKvwe/WL0Zd+CtO1Y2iLWpC8BfHykz41wI970I9uG8P5Ri7OljO2wjzCj3Q2WB0Y18BZzi2ga8FZDObKFz04Ow0E8TlYN1hwNmQOKnkhgiDAyTap7n2KfYtJfqy+AXB0Yj/xK32dd1CNm1djJYXpE6aDdjQ1BQ9OSJjS6xcS4g5yDELgPQW3IbX7fUJcKs47mlZhNzy3MZ4jJdrKONWEpxXmKJNMsuVOJKJfZkToFg98j7DH8JG6kh2rOTiL8UfHRR/tflLGNU9WatBiWfb6wdk5WmQ7q0DfbSVAfznBolBFfSfP/Akp26E0IWwPXrSdGG7NSnhSTBgCb8T5/Hg15cR0GvfhECcg1lf9Xb7dY2WqrJc8PU+b5GiOyDaLfv9Pr5eEYG1+7NpVt6jM/COUltmSgyIXuy6b8hq/jg3l2bMA0EAOmRQfgu198u3pVRQy5JRCIbar8D9M25nqDePpCiQbm4Jydyt1ejkWh+aZFIqa1TVdhQGyFolXEN9UHm3mEaCMnaBPmolUlbwASb46m7WhTZA50gtxbm2D3JYpeuZIDPjjakrCb4dwW/IJy8j9YpEV7/sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?erhL7wdl0hLN0UnWB6omJnY2QGVUa6mFJM9uUHXW65rQ7hW+OanmOaxsaC?=
 =?iso-8859-1?Q?j46gtD481prL0qfAd/3ycWDP879+eTtKBJA1YMnuezNNnPjjj+aEjeul26?=
 =?iso-8859-1?Q?j9bXoPOeGb0yqvJ09Ur3CM/tFC/slTGj1KT6rfmPuumScyWk99/JBS3AyC?=
 =?iso-8859-1?Q?zGxaum6STx+xxKkkcZYZakaGiALU2bw0jxKEp0iFzIZ5H5xGrIhmdAy6mL?=
 =?iso-8859-1?Q?kZEbKPA3uYsphWJiu/uJtLWD2lBwMR/MZjqFa8nFvwHoUOKJJE9DeeiSWZ?=
 =?iso-8859-1?Q?qwVCOY3Lq2cV5vK5XwtV/xkUsG0XM43lj+fmHnNAVUhWnzei4801UgTPvq?=
 =?iso-8859-1?Q?EiSfTtsENj5eDT977eCVpftKe7jxcbhPtyQLeeBXkAp2m1R/KDgvBuhCZQ?=
 =?iso-8859-1?Q?30GVD54zUF0CCD1CynvXJFXa9lUPcxSVOzrdPS9SprLHBDSLKxOwFYqpla?=
 =?iso-8859-1?Q?sJErmT/pD7oYGtG0e0vouFBL1/zFP5ujKasJTiEX00cHoHCDq/Q1M3oG4+?=
 =?iso-8859-1?Q?Mh1k0LsmqpBX+z2DEoGKT1uO+CfX3MeHOHKHjEIiXKR1EhTm9GhE6CJ7dR?=
 =?iso-8859-1?Q?nA3wF0+nFeuQ7piWSLc4n5+cduxZpyyOsl98zSRxHLVgiD+zQrhqB8zTZm?=
 =?iso-8859-1?Q?ruO/QmBbI31p22GIsrJ5PZ5tSivBEO9WZE5/DTXrr56RTvKJ+fcmfYoSEs?=
 =?iso-8859-1?Q?wtgk4hwz+tSzILHCXTiGXTRtR7WrS0NvfkeUSSkVGgq+sfX51cKAifMc9D?=
 =?iso-8859-1?Q?v3+1Y7IwIesBqtJYwOAjII6hfzh6ovW99uBCOve6iF4VYPvpDbjFIJfShb?=
 =?iso-8859-1?Q?KcNOhKSxnt6n79uGMHIppu4aO18/+RVC/HfxYj/d4xcwUXtMVp5jUS3ck/?=
 =?iso-8859-1?Q?LbaGKrqXyKl5/LlzkNsxQOvt68Kg5C22qqI15EUndic3qITCnZLJXyoLzO?=
 =?iso-8859-1?Q?RuoNHY46KnMMY1pAAFvbxGuuUrUVcIJbu1wakDNyPGYPcgtiIu6bj6/Eti?=
 =?iso-8859-1?Q?2Es01s2CmLJvWdnHB6YEJSIQS4v2fBgDo0Bzbtq0GaE558fBNd1C67WdV4?=
 =?iso-8859-1?Q?IWDn6TXcn5diw8tetnrXzNc1XprLopydB6FpE27gNux7YdDmEzJWMHyYan?=
 =?iso-8859-1?Q?5Frv+IQMlSLF4VhBviywRf3ka1a0235256tKfVxPpKgZfskKnjeER8sO/Y?=
 =?iso-8859-1?Q?iBfLK1TRGwn7YOTR//l9PqiNd3UVjI6kx3uL6eC8mjWaIUfAYJgvWmOUnC?=
 =?iso-8859-1?Q?AkpjrL03R2lHP/yZ18RuLWO19xiJsWvQrBVogXYrjce2z3F6xClVCBws2T?=
 =?iso-8859-1?Q?XHvxUpBh7aM2qDT9MEKMXI4gi7yQRbA5a4T3ycaK8LF6G6o5Ol+sJ7wpdw?=
 =?iso-8859-1?Q?HA0mIG6aS+ywGkmT8HHa1XwJ+8yx/LROMOJ1KYYwNA2RE9jOuXwHefN1U+?=
 =?iso-8859-1?Q?sWgH/acJ6qImh+Z/PE2T6D2YZt8GpT3SwAoEKl6wZxU5LfCDljklWaRKuP?=
 =?iso-8859-1?Q?JhhvHNhJnZjK9zXKC+LPiDCc0d3oVhKrdOcqGTKKRftUQ0bwUnfDu/hdtx?=
 =?iso-8859-1?Q?bi9CBdSGYm6r9fV5/87nHisDfYYVrC1CrwDQKp7An/Q3SwctK4Sw1KfG/r?=
 =?iso-8859-1?Q?rXgqd6dlWLHM9vRYAncM2NkIXtS8C+Y/KCQS2avN+I5VNYflXTMnN/Jn/C?=
 =?iso-8859-1?Q?eIF+1a6TkM0Ea0zLues=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f18fa84-223b-41ad-eef2-08dc36ad423c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 09:28:15.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Obvy7xl3CG+xb2488ww9e0ilOA9+XWOdMnbmKTDt1qgN6csFzKbpkzzoe/kbNvf2s5Y1pP28LeNzHJ+KVmCPb92BZaCk5e+zP/FVhHBKhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8400
X-OriginatorOrg: intel.com

Hi Shuah,

On 2024-02-23 at 15:37:11 -0700, Shuah Khan wrote:
>
>Hi Reinette,
>
>Okay ran a quick test. Why does this test leave "/sys/fs/resctrl"
>mounted when it exits. Can we fix this to unmount before the test
>exits?

I also wasn't able to reproduce this unmounting issue:
- with unmounted resctrl before test:

	[/root]# ls /sys/fs/resctrl/
	[/root]#
	[/root]# ./resctrl_tests -t L3_NONCONT_CAT
	TAP version 13
	# Pass: Check kernel supports resctrl filesystem
	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
	# resctrl filesystem not mounted
	# dmesg: [   12.502941] resctrl: L3 allocation detected
	# dmesg: [   12.507134] resctrl: MB allocation detected
	# dmesg: [   12.511315] resctrl: L3 monitoring detected
	1..1
	# Starting L3_NONCONT_CAT test ...
	# Mounting resctrl to "/sys/fs/resctrl"
	# Write schema "L3:1=3f" to resctrl FS
	# Write schema "L3:1=f0f" to resctrl FS # write() failed : Invalid argument
	# Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
	ok 1 L3_NONCONT_CAT: test
	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
	[/root]# ls /sys/fs/resctrl/
	[/root]#

And with mounted before test:

	[/root]# ls /sys/fs/resctrl/
	[/root]#
	[/root]# mount -t resctrl resctrl /sys/fs/resctrl
	[/root]# ls /sys/fs/resctrl/
	cpus  cpus_list  info  mode  mon_data  mon_groups  schemata  size  tasks
	[/root]# ./resctrl_tests -t L3_NONCONT_CAT
	TAP version 13
	# Pass: Check kernel supports resctrl filesystem
	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
	# resctrl filesystem is mounted
	# dmesg: [   12.502941] resctrl: L3 allocation detected
	# dmesg: [   12.507134] resctrl: MB allocation detected
	# dmesg: [   12.511315] resctrl: L3 monitoring detected
	1..1
	# Starting L3_NONCONT_CAT test ...
	# Mounting resctrl to "/sys/fs/resctrl"
	# Write schema "L3:1=3f" to resctrl FS
	# Write schema "L3:1=f0f" to resctrl FS # write() failed : Invalid argument
	# Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
	ok 1 L3_NONCONT_CAT: test
	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
	[/root]# ls /sys/fs/resctrl/
	[/root]#

Looking at the code there is an unmounting function called after each test (at
the end of run_single_test() inside of test_cleanup()). The non-contiguous test
also doesn't write any data into a temp file so no additional cleanup is
necessary.

-- 
Kind regards
Maciej Wieczór-Retman

