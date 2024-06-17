Return-Path: <linux-kselftest+bounces-12043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3098290AB4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967BFB28416
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229821922C7;
	Mon, 17 Jun 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWOM7cC3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70A188CD0;
	Mon, 17 Jun 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618722; cv=fail; b=klDDcaSCa//F3wcoDsg4p2qQ7MJLIgsS90JvDSti6L3QaOAmnS+BfiGHd6MlYpb/88qfQdB9pkKu9D+tkcPRhr0FGLOHoRiX4CnaVnquTyR17g4j1+p8mx7/TbDG4Im8jfPl/bhZvlqCqLES2pWLN+BBzD0oGC5c9q9AXb4Rbpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618722; c=relaxed/simple;
	bh=iT+wXr9uz5Vfh3HavslEd+WzBnzCPO41aI6Gnd/4Oio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T4m6LkG+pfGEutErXqDdVljwA5a+HC4PEn6n6BOe5+mVIueidb1p9Lds0uyAtMXOC0cLZ0Oq1GnkgRcZ6Yy6+K5xib9XcdR1Z6cpHtZTeEgnuEc0FUH3R2Gu0TrSryI+sprH3UPXTcvx9dCPZw8YUvqmwuM7z/xk4J9nzLgwS1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWOM7cC3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718618721; x=1750154721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iT+wXr9uz5Vfh3HavslEd+WzBnzCPO41aI6Gnd/4Oio=;
  b=IWOM7cC3sGLdQZTXsV8utfXdNw5RqeMrPmhhWhYqX5BzL+iKiJGG2sOb
   ZJCJiMmPnwjfEuhuV3lVDPjFnes8jiEOgjNXqccJaToRQu6iNjEEdXY6D
   sxMdnMYZnJ1nW8z0O3m8/z2uLkDPs3BvC7BjHp7o/ofdrWsF0j+myuaf7
   zgsV5gEmPNhOufkUFe/UmsNV7KBRyMtjDZecpXnodDvtAoH+IAGYQGMME
   SZU+mN/VRl9biBjsmtfDvZqbT7s081Xdi0+OTATO9efU/5Gi/Z7G0yzxp
   fXD1nDoxYaJEuNk2+Un2t5gJVUyDn76dSxEY5/OYPDxK3CqSlfQE5BIcJ
   g==;
X-CSE-ConnectionGUID: gE3u8ffNRxOeA80vinfFyA==
X-CSE-MsgGUID: Bi5ytLPNR2+jqsw6QNb1zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15274480"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15274480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 03:05:20 -0700
X-CSE-ConnectionGUID: 5p88ODgPQnSyVpCGHkv/cA==
X-CSE-MsgGUID: Fd9UmHb1SIi/Ey08NxaKYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="46104429"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 03:05:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 03:05:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 03:05:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 03:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxTvu3yzC0+Z48EhLX4Low5isQIkX1ZkoyTxtAokpfA8bUyjw2j2u+FjSdvD56wUZpxcBcXu/G2XutjGpgA+I/FtdwPjeJb+hGa9LFwjY+M4+b5aRTyxgVL5hBbCNdUiocV0joCZwMqVOjLTyn+W9ehcspABRzuQ5d8UgCj0dVz38UYeSbnNxCaAdqFw3g7xpPVuJnD3EVdmflEqYsVjLDybh+QUW7IaETO4pPbdbnVnom5DkXsDCqY8kGDfOFXOkRQwQe0u+mSFkBvYKK/VkIdVlnuX6f02L4JMxBxQuH2z+0n6CztqwUjoq1J6eX+BbZa/7Mpu368YZwttDFoXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3wwwoaGADXv9OK8bQErr8BtEMePn7UryyZDSsKRAgs=;
 b=fBWMJhroX17scAXZoBmNpqGIPzs/GUWoaEiGO+NxRa3MG/zXuOP+/kQuMoxgQ5t11jwBYpv96XXb/FJbqE0cI8KyZMAaE6QaGbwwVVgSWYc1rwhJkEchDpRbJZOaAY25IfsWO9JP1jW3SJM+vcwNec2anlHEz4k26jFiQPcwNJ6ax0vtApW3ugM2hOiyrSj4JNcGavE2RNGloHVtvdxhIE0VyxM5GkcyLSZKhiqEg9FdYy373hern+roNDA/GiUxZdJc1gl58YdwAIqRD/I7MQVyeh+2jynls/LarfUaJL0rsUsNh753uQ43cyryYqVpxQgOCGpyioxyLVki4tdR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB7095.namprd11.prod.outlook.com (2603:10b6:510:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:05:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 10:05:18 +0000
Message-ID: <594b79b7-452c-488f-8a7f-4ee95698bff2@intel.com>
Date: Mon, 17 Jun 2024 12:05:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: openvswitch: Use bash as interpreter
To: Simon Horman <horms@kernel.org>
CC: Aaron Conole <aconole@redhat.com>, Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, Shuah Khan <shuah@kernel.org>,
	<netdev@vger.kernel.org>, <dev@openvswitch.org>,
	<linux-kselftest@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
References: <20240617-ovs-selftest-bash-v1-1-7ae6ccd3617b@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240617-ovs-selftest-bash-v1-1-7ae6ccd3617b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0196.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c547680-86ef-4984-3490-08dc8eb4fd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWQzMkkxQi9KWVA3WlExRUgyRXB1azlQMzU0aDdKalFjRFdjZ3JaK3JPaXQr?=
 =?utf-8?B?aVE2dzFpSHg0ZnJtMHQ0OGZ5OVl0NHo2MytGeDR2RTJIQXNDT2QveVJRajlQ?=
 =?utf-8?B?Z0hMdG1Ec2hreSt4L3RIc0cwc0VXaW5Sb2haZTFjNncwKzVXdzFIQ2hnVE84?=
 =?utf-8?B?SFg1TUZaeThIQ3dCMEp0SllxL242eFVUVlh2RDZXdEpnUzlxNFk3YWxKK01M?=
 =?utf-8?B?UTUzenIzRmwxMkRodUYySktYU1JHQjdQNlZMU1JGTFZKbEUyY1lZYVVlUW1o?=
 =?utf-8?B?c2ZwMWhuWC82MXkrRXNXNFJSdmpZMjBVVXpNYTVJcjhpRzFlUEFLSlhyNGhp?=
 =?utf-8?B?aE9ESFBuZVUwV2VqbEU0Y1FhUHBzOFVrN3MzNzU0M3hmZVNXay9CaW5KYnI2?=
 =?utf-8?B?RGF1b0NkRUtSZjdKMEpFTUQxL1ltWHlucGJrT3RCU1NjNHFuQ2JpVk12c0FC?=
 =?utf-8?B?WWZGNE1nVThFdTRiZENGSTJrTCtydFh6dDkrYU5OVWxmQUp6VFlCSkZUeW94?=
 =?utf-8?B?bEZHTlVBZEhOa2ZBMkw2a1pLd1pGcXJIRXRodlRFZkJ1cGlHQ0g4a2FzbWJi?=
 =?utf-8?B?dVRha0VxUFB1MGhTaUVraXdDRitJWWlxRklHL0JLK0thWlBGV0wyMjRrNEVH?=
 =?utf-8?B?WGJJM3dOYTBuY1pmcjF6UDZ0dXZDZVJTRHU1alUvQmJubGhVeS9GVlU5cGJL?=
 =?utf-8?B?aXBWcGVCREhOTlQ4UmZlMmJWMnVKVnRnNGhVcG5Mb2l6b3N0T09EaHprdjA3?=
 =?utf-8?B?SHlTTWkyK3lZY2U0bjVYVWlkOWhrWnN6WmNveE1uaGJiNWp1ajFUY2Z1a0xG?=
 =?utf-8?B?ZHRab25zdmFhVkpMZjYzWlQyS3plcGpNd3M1SHh4YTNiaGsxc01RMldCbEpt?=
 =?utf-8?B?UXVDS3lOaVcvbTBaSHgyMGpWb1ZHbVJLWGN3S3dqY04vNlhZcHVPVjl4dFg1?=
 =?utf-8?B?SUxBRVVDRTkvVVh3a2lmTzU3WVNsTDRERXJGazdBbXdveG82bVA5SHJxeStZ?=
 =?utf-8?B?ZEpnMjd5ZDVIY2ZLc3FFb3U2NGdSWkh2Qit3YkZ2NE9BaWJWR2tGVEJtaEo5?=
 =?utf-8?B?dEM3NW1xSTc1TFFHLzJLRk1ld0lpcXhZSjdSeVBmcFNITlptc09SOFlMR3BQ?=
 =?utf-8?B?bWxQeVJVN3lSa3IyellEc0hweU1NbmE5bTkwRG0yMkZzT0FwdWk5QXBYaUw4?=
 =?utf-8?B?dDlHaVhVSVJTOFJyUHJ5L0dSU25IWkxLcE1FaXkxRFp2cC96RTZyVGlsRGtQ?=
 =?utf-8?B?NE5JdUs2bVc2TXBDb1ZxMUdvMzA1QzYwcUJWcEdydDh5bUxxcWFaV0N5T1A3?=
 =?utf-8?B?Rys1YlUzMDRLMzRCZmhLWXR4eHB4dTR2LzJ5UWx5L0swREVxRTZlY096MXdn?=
 =?utf-8?B?R2NaY254ZmpEdEhlNHFXMjBQbUF6MUFTMGxINlI3TFNSSis1aFRrek5mbzdT?=
 =?utf-8?B?c3lMZFNKMkxxODQ5VzR4d0FqZXhDQ0RPL1cvTmF4VHZZN0paZUY3MlYxcUMy?=
 =?utf-8?B?NWhFclZ6T1hzRFdRUTdPaDF2bzRWanVKS0JRc3BKTTBLMUZpWWY2RzZzVFBo?=
 =?utf-8?B?eU9UbzEzbm9GczRENVptZVJ2RHBZRXV6UE1STDUweFpadEJwV1A5R0tDMk54?=
 =?utf-8?B?ejIxa24rQkRoVjhOSWNSYnB3RDRlSFFtZmNHU1drbWRnU3hMaHdvSHJaaE1a?=
 =?utf-8?B?YUUxOUphaS8veHVucHRwY1ZKYVlvSVVlOS8xQXB3NTc1Wi8zbDd5K08rM0hK?=
 =?utf-8?Q?YT8Sw0NmXrU/AZVHvJBrfy+cALc7iTBgaOrCsN2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJrYk5XRmxLL0pKeVlaUDcwR0dkeENWaHNjRGdyc0dvOENSZkdXZi9JNmxJ?=
 =?utf-8?B?eHNiZTV5azJPWmU2cVhWbk5mWVhyeG9JRmk0OUd5Z0hTKytwbXhseHorSS9Y?=
 =?utf-8?B?clBwMDVhOGtJQ0pJL1o2QithKzNNQTg2ekRvMHY1K0hpNzhnOXdqMENmcGVv?=
 =?utf-8?B?YzRRUjlyWkk5NWN0SW9MejVUd3ExYzdZYlZrZ25nZGlLYUp2bk5VUnZsaVcx?=
 =?utf-8?B?Ynl2akVDYkpmK2xaaVY3NzJ0VVhDeHVFcWVBVmVObDJrK3pZdHl1d3R1U05o?=
 =?utf-8?B?OHRuY3RFOUthMDBMckZaVkdESkRBTi8wVmVNVjlPY0h1S0lmTlplOER2c0Y3?=
 =?utf-8?B?aFhmK1RoQmJLR2xIMmVZVk45aFMyWmt3RlpoUUV0cWFjTE42VDgvL1J4Mjh0?=
 =?utf-8?B?NTZOSjFFN0g3NFpVY3ZBeklIRWNmVTR2SmM1bm4vZWovdHZCUTlYejl0QXhx?=
 =?utf-8?B?V3NRa0k3K1hXZUJpRmlIcURsNlliRkZReTFPZHUvSm5zR2xvNTlPOUc2WUhR?=
 =?utf-8?B?QU9UVmdQdlFtVGYzd2FGbXJFQ2dEOGZGT2h1WkNzZ2ZYOCtoZ2RTbHJNdDVl?=
 =?utf-8?B?V2t4bTJlK0FLcEZhTXRjKzVSL09xSGtEa0RCNng3MDZEdVpmK2FtdDEzVjNM?=
 =?utf-8?B?VEhBZ0VKYnd2ZG9ubTdwdzlkVytvb1g4WXEyaDNJWW0yNWk3eEhzeVdaaDRG?=
 =?utf-8?B?bjZxTWNLVThuN2dTaEZGTW1HeWFQakZ3Z20rTUNmMlhzTUpEMHI1SjZSMGx2?=
 =?utf-8?B?Qy83bWNMWGtwcU1aV090REQwWkhOeGJ0ZnQxNUZFLzRDM3RvYitGNS9ieFFZ?=
 =?utf-8?B?Y2s2ZkYweWFndm9IRHlPdnhsWFZIWk05WHd1VmxvNFA2QXM5KzNmd3c1bkVK?=
 =?utf-8?B?VktKVWowem1oYUpJaktZZlhHNVV6RzcwUGtORk91d3VRODI2VVMwOXE0TFNL?=
 =?utf-8?B?VGVKWkxUQ09yQ2N6SVZzS04xOVpJV0UzR2NZcy9DQTJoUnRpOW52V2RWYmI3?=
 =?utf-8?B?QllselpPZGp2cUE0NmQ0dnk5QzR3d0pmQkZGayt4K3dhVVpWSXhKcVBZeWJt?=
 =?utf-8?B?RUhuV1BvMWZjTnNmOStVejduYnlnRXJWeG5Ed01QcFI1QVVPNGtkK250c25T?=
 =?utf-8?B?Zzl0dkQzQXFwSmFPZzI0ZGpOUEZoNFh6UkVwWUNqSERrMm9na0N5b3Z4YzNK?=
 =?utf-8?B?bzJmb2wycjMzU3EvZGtjM09NbUFnMnZwczE5Rlp4bTcreG9iRm43M1JTMDI4?=
 =?utf-8?B?dXQ2K0dLNjVGUkppREtoU3J0REViZVpLdjJpVnBWUXhQOTNpeWJFTE9PdHlm?=
 =?utf-8?B?R1IzNTBUTkR2eHhHQXAyd2V1OE9GSFd2R0d3SDlRS1k3dVYzVE1IQk5OSzVZ?=
 =?utf-8?B?NDZqVXdubWNNTGdTaFFTTjcyUktlUmpBNnRubUZERHA1WUxySHhzbmlzSDl1?=
 =?utf-8?B?dCttbTZuejlEdFlwMkx3UXVXUnNtNUJzSmo5MlBxWWVRRzRjRE8wckdCK29R?=
 =?utf-8?B?c1pJbkF2cldaM3NLdmZEMWxSWEYxUGZTRHlMY2lVKzhhS3JPL0hUWXg4Um5H?=
 =?utf-8?B?blVXRVBZZGpnc1lVTDRmQlpvYnFSMmRkWjlwTDBVbkpnT2w0YWtsU2dQRG5O?=
 =?utf-8?B?alpIVkxycmJIOXhRRW9zTHhZdzViNnlNU3M3TjhRVVlJaDlsYkJBK3ZuQy9o?=
 =?utf-8?B?RWEvSFQrVkpHZzRKV0NEa0RTOUc2aEZ3Yit1MjVmNmRaOXUvT0FFbU5WSVlO?=
 =?utf-8?B?eUx1b2orcklLQ3hmNTlpdFgvSmhSNHRrWHovWGY1K1lwcExtNDRtM1BxbUIw?=
 =?utf-8?B?YjZ6UEZlM2Vtajgyakg3QVc1aC9JbDdIdVBNZWFKVTVYdFJmeUo5aXZkQ0Q5?=
 =?utf-8?B?TEE5eHJCWjlKZlkwMy80Tm84dTgyS3RLemlKT3FBSjRmSGZzRzRDOVdYMlcx?=
 =?utf-8?B?UjB4bFZhQzZ1dEdWdmdxSXpyOUpYanJrK1N5UjM5NmU3NlplekFkQ2ZzTWU1?=
 =?utf-8?B?dmI1elhoeUVuTnBxYTVvMExLNXFoVFkxcHBGRHpJQXdzQTQzRWdaT0hmaS9i?=
 =?utf-8?B?bW1MblRTMUJ0N1hEMFd2NDUzaXpRTXZBSXpOem0zVnRQYTZROGdPbG1mTFNR?=
 =?utf-8?B?aHE1ai8rODQwTlJkYzl0OVcva2Z1OXl6cXNDR1o5NmgxVC9iS3BucUtoYmNk?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c547680-86ef-4984-3490-08dc8eb4fd90
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:05:17.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4laMILkvK9GtUR6CYYc9VHKPz7FKUCsLlIV+IeI4yckEQtSrIh1GlTEU0j1mI8UfHs2/X+HrASy2A6KL+t57a14FRE2KWFLsxD0ZCTpKRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7095
X-OriginatorOrg: intel.com

On 6/17/24 10:28, Simon Horman wrote:
> openvswitch.sh makes use of substitutions of the form ${ns:0:1}, to
> obtain the first character of $ns. Empirically, this is works with bash
> but not dash. When run with dash these evaluate to an empty string and
> printing an error to stdout.
> 
>   # dash -c 'ns=client; echo "${ns:0:1}"' 2>error
>   # cat error
>   dash: 1: Bad substitution
>   # bash -c 'ns=client; echo "${ns:0:1}"' 2>error
>   c
>   # cat error
> 
> This leads to tests that neither pass nor fail.
> F.e.
> 
>   TEST: arp_ping                                                      [START]
>   adding sandbox 'test_arp_ping'
>   Adding DP/Bridge IF: sbx:test_arp_ping dp:arpping {, , }
>   create namespaces
>   ./openvswitch.sh: 282: eval: Bad substitution
>   TEST: ct_connect_v4                                                 [START]
>   adding sandbox 'test_ct_connect_v4'
>   Adding DP/Bridge IF: sbx:test_ct_connect_v4 dp:ct4 {, , }
>   ./openvswitch.sh: 322: eval: Bad substitution
>   create namespaces
> 
> Resolve this by making openvswitch.sh a bash script.
> 
> Fixes: 918423fda910 ("selftests: openvswitch: add an initial flow programming case")
> Signed-off-by: Simon Horman <horms@kernel.org>

That's good fix,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

sidenote: I like very much the idea to use the least powerful tool, like
sh vs bash, awk vs gawk, but it breaks when we forget what is outside of
the scope of the former/standard.
Perhaps for shell, we could convert all the selftests at once?

> ---
>   tools/testing/selftests/net/openvswitch/openvswitch.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 5cae53543849..15bca0708717 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>   # SPDX-License-Identifier: GPL-2.0
>   #
>   # OVS kernel module self tests
> 
> 



