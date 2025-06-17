Return-Path: <linux-kselftest+bounces-35237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E887ADDF51
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2991C17DB5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92775285049;
	Tue, 17 Jun 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQPaQMnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112502F5324;
	Tue, 17 Jun 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201302; cv=fail; b=ThWvP6LpVw344AEEPiBRxzUROgAo3bYei0ZyVLAtr33MtxH4IWK1dDKkaiZmC2ooLbVr8KHy/OFa9n2vbnBKGLfhSQPS0hA1pKe87h82BgaQd9OYt/LCwfbusoU9hTU8fMwKf1IbCvt6yrc7TwjHKNqMzDIa9Spmh9R8XKJZ3cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201302; c=relaxed/simple;
	bh=Qev6shOCOpZCi0d+6WYnAYDZwRV6H6UJ7BxnnKcJBjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ApW0OB8M0xMGLVUn2NQlR9LJIedEOSDEOtjEELAEn8udAcqTJifzlo/1g4ZYw+jPAgWepaqdijp9KpjfnuAz7pVxi77cdVZ3mNkJPQeaMIUHLmzYCz8zqr49i42UWhXJRwQXCijNtZNMSchl9RtYGmumMONBA5ySOdTVVoF1/f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQPaQMnX; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssjxP9oEPfHc7ZYfWP68G+yjvyrSoG3vkiILXCcisGgCmqC7+ltLVRR9HQybOabnk60Q6ZsJQ+evFL8HDp9E8VVdx1EzxGCHdTLi2tw/HXp6O5x5MCEc/jKVoGMyqS/LksThcupJJpAR5GWxc9WMt+ifSUdrv3c/+BIWtmT4gjTyNsYUnBVPahzdmydaXM1GnsLilMhpQdHwaacd8AGCdPYN0eK/k8AkVejRxIRU7yduSsu1tx0ktpJ/GQ2fpTwjGd+jvMMK6r1fvc4KoqaNj4G9yUPUPumfE8RHLHaNcMa3pLzGqXS1+WIwpOIB0TJdlal4N0gTLZfjfJIcyvU2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NgKVUAZAA817jRPRItAXiHC68L9veSxAey1HlPvLwI=;
 b=tEA6j840dgKsMqKEFMzJC2QCK6qee/pGcabqpmk/N2duuDoT8dVdOZuRgYGRu2onD0jmnAj0ySsn7MFBEzmNAlpny6ji1PuJLl+vR/RvIE9CZawAW3pY9CpfdUCgebMTpSCYPo610piyTqJHhfzDllrgKDnYW1mmtngd/BkKME7F59lHDuqlkIigm8vgpwxTX+QuJCZkpQzNIyaK5w+ujwkfbwCCZu7h0JrGgV26ma/HfBgudRZKLStg43Ek63IcQqAK15IevH180ZlfG26kRB6LVIvC7AzPkfZ8Zkfy+xKUlFvk/f1rPfsubb5mc/lNKy4HZIZVOmCttSqXIVllpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NgKVUAZAA817jRPRItAXiHC68L9veSxAey1HlPvLwI=;
 b=nQPaQMnXMH8+tCHaf84kLVVZQIdXMSSEyHq+u+pc7awqvOtER8EEJO37db7gldr2/YJyA6q756pczLyBK5UcUSWlbQZvIHdVyL7rEaRk00kGQoBCx4EEmRYVoHDP26VJRvIfG7fNE+cZd+uIY9rj6dwrQCnC7lelFNKToO7vTbTISJLL/NLlFJWEYSNrNAICj8o6XIAaHtCvf6RHH0Dl2gdnnmkA5RnlfAdm9pQdUpg8f6zjbkznCHXnwqLfroe+J85PA/Sdtd+tjl5Ztm7AOmLX3r8KUhiD+RwgocTXvEG7l2aUvh7HS0SctlzhzcIurjImyWaCi4Ue57E+N3+DIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 23:01:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 23:01:37 +0000
Date: Tue, 17 Jun 2025 20:01:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with
 large hugepage sizes
Message-ID: <20250617230136.GC1575786@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
 <20250616162501.GN1174925@nvidia.com>
 <aFDMoMX8eL7azoUL@nvidia.com>
 <20250617115948.GV1174925@nvidia.com>
 <aFHc3UujzDIfmKeT@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFHc3UujzDIfmKeT@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0231.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 7981b711-9c73-4762-8f22-08ddadf2e998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVRQbWE1OFd3RlZYWWticDlnWUM3TW50cTdnU0dyQVdjWWR5a01kWlErODRO?=
 =?utf-8?B?UWcxeE5RUmRoNUVUY1dVVTFUVE1QUklBNmxlTHgrcFQvYTRTNG4va2ttcEVU?=
 =?utf-8?B?eEZlUFV2Z0lWamZKVGdOK2p2ek5CSEs2anh0cC9Ib0JZamwvNmNEdEsvd2N0?=
 =?utf-8?B?ODkraTZDM2F2V0cxRjlJNGNLUnpkVi90R0JtbHk5TFU2b1dBdHJqWGcxRXhk?=
 =?utf-8?B?TEV2V3poN0JjbXRDSy9ubnZoWjBLTndZMTUwdHY5M2IwWnZpNmM5SkJ3MEha?=
 =?utf-8?B?clNKSThCeXFBaXhmY3BXSlNjNEZSM3Jtc3VtMHRWemY4WjVOM3dqTEM5dGkv?=
 =?utf-8?B?QTNBd1laM1VId2llMEI2cnZ3Tzl4eTkydWM0YW1yb05tUHFPaXlpdFliMkQ1?=
 =?utf-8?B?Qmtyb0YxWGNpSTJRbyt6TUtiZS91MFI1RVJPcGFpK09zeE5pcUE3dytLRndO?=
 =?utf-8?B?QUl3endIQ2NjRUl3dFRXWnJOTklQQTBGeDRZTWVNTk1OaDJvWHVsZi8xaVBL?=
 =?utf-8?B?VGJEZHdqM292SFg1TnZpQkpmZzBBSlMrZWN3M25GZnhhalFoQkI0WEdQNXQ2?=
 =?utf-8?B?RlVGWk5CL0g5elJIZUZ2V3EwZkhuRm5lakdvSU4zUlhzV2FQR3RvSHRuQkRv?=
 =?utf-8?B?ZmVZYktVR3VVUURzQXBEWGZWaWhsclRlK2xNS3ozZmwvRnJ5WlFaMkc1dDcx?=
 =?utf-8?B?bXBaZktLSVJ4Qk8vQ2dybC9oVytQaHd5RkFTN05Kb2I5ditKWjFaYkxQU2xV?=
 =?utf-8?B?d0Y1a3VnNDR5RU5EWUxncDRPd2xxZ3FDUGNFR0VjcjNaRi9aUlhmTC8xcGhi?=
 =?utf-8?B?VDRiTnpXaGhQWlJmYjVyN0hkdzdibHhqMnhlTTRhdGVKMEVnRlRFbkxwZjBl?=
 =?utf-8?B?cHQvOGE0czdCWmwzdkQ4d2ljeVJWaUlJNHJlYm4zSExkaXVwWnh1enJEdlVD?=
 =?utf-8?B?M0l2YUFZUlpVckFwZjh2bG9vSzZyRUlkeXZ3alNKL3ozL2VNZ0g1ZFI2QnZR?=
 =?utf-8?B?ak43dllKZ01EQjE3OTdsSmlrc3hNWEVXbS84c05KRE9xbDNteHY5UlkrdGh2?=
 =?utf-8?B?S1NsRk82RmZ1ZU9LYjdPRSttemk2bGVSL1VOd21IS0VsTmxVZHJjQUZXU2hl?=
 =?utf-8?B?Skh6UVMvWG5TS1E0Q210VFc1bDNMK3IxdzZqNm9jbWFjSytMTXhEalpQNC80?=
 =?utf-8?B?LzdxTHZ6enlLOUxZZU1IT2x5Q2tYTEVXdXVubDFlSERZN1N1VkRkazNKbWNw?=
 =?utf-8?B?OUIvZ0E5ZzZUOFYxVXlZaUZhMHovbWRMUVhGM0YyRlFPWHlFQ1NSMEFTL1Bt?=
 =?utf-8?B?WnpTc0lFajJiUEJxTGlhZkJFa2R5MHFGZkVKaXJDZjVUaDB0bVFPSWFWcFJo?=
 =?utf-8?B?cEZXa1RSdFdITE1uOEk4cndvTlpUeCtTTlo2T1g0MlFmZm4yOTJUK3NHcjFp?=
 =?utf-8?B?NGRteHh3VEpmS000YW9tNFMwWEp4K0dZdXBobzlhR085L0pEVnV2UW05K1N4?=
 =?utf-8?B?Q1IvMjRUbnZ3YlBxTjBFTTFJc3pxc1F6bXJUTFJLL3Y4MzNHRzRvaWltcnZD?=
 =?utf-8?B?TTNkby95bGNoRGVmaXdtOG1LWXZ2WncxaU1sbncrL2FCRnBTNUZCazQxL2RV?=
 =?utf-8?B?akpjNndQQysyTXpsTTgrcEFPQ3h4aEZ4Y0ZxSmxLaXZYR1lvZkpxWVNnaEU2?=
 =?utf-8?B?d24zeStJTk5nb1RQNHRxUmo4TFJCWmw2QUpVaXF1ZEtwemJxYUtFMmFtVEtL?=
 =?utf-8?B?VU9ZQ3ZCaWV3UlU2SmdBR1kxZ0tvcHRjak5LT1FqK2dxdmVST1hpYzJSK0ND?=
 =?utf-8?B?MnlxZzlwOUwybmR1QUpwa0V5d0JHaEhJUVRxSmRRbEU1dnYrMmRXY3ZhYzB6?=
 =?utf-8?B?cWY1MGhOcHZGVk1vZFJhZ2lpdTR6NmFuZURsZ0ZwQnNrR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmladS92TUhzTEl2OFVNcFRJbnFsVXVFWUMyVEtnRk54bUp2cklOZzJLMWRN?=
 =?utf-8?B?T2MwREhGOFdweldUYzZPa3BwSm56UnVKZCs2TlVkbFhPZVV3U2ZraSs4V1Qz?=
 =?utf-8?B?N2RUQkFIQlZXcndGVEtjOGkxM1NjRFQxNHBZd1lTTU9TZDVJV0lDS2dsOS9s?=
 =?utf-8?B?ZExRSXhiWVR3b2lkbVdvSGk2alhLQm9YZ2lPMUpzbXhEYm9pc1JZVHlldWMv?=
 =?utf-8?B?SGNwSWx6UHB6VCtrU1p6cVAycFNtL2RnT3MybkJ0cHd4ZW0rM3lZUUFlWXRh?=
 =?utf-8?B?N3lnTW4xbDlyQURMVUswNk9XaWhqc2xVeldLbHBZMVppZlpZL1JvYVBGU2FT?=
 =?utf-8?B?MEdxTWhUdmdQN1ViNXRHYXo5ZUxXR3UwbFFxRHhTdUtWb1lsd0huL2Y4eUor?=
 =?utf-8?B?TnhWVkE1THlPekNrbTBQZHJJVzVVRE5KcEY4SUw0ZzVoN0kvMjZPUUEwMVFO?=
 =?utf-8?B?Vm53WnEyNGhiWFVJaUFub2paL05xVS9tL08yNzBYallFeTZsOEh4UzN2UG8z?=
 =?utf-8?B?T1BoRy9CK0ZBb3pWZXo1eHFTNXh6YThLMFh4Uzg5MlRKeWpNYXcycDU2TWpO?=
 =?utf-8?B?T1lEdERaZndFdjRJZkRRalZtMWNIRG92K2JLMmRnWFVYYW1Tb2FpRU9ncklv?=
 =?utf-8?B?SU5BUFNEUTBjaVc3T1NpYy9JQXN6cnpRd2dOQWNJN1dXSG9TUUFkTWNwdWoy?=
 =?utf-8?B?VS9HQzlHVGYzM1NOVkRKZzV6cXkyMmIyRjM1UHhManNUL3ZlZDMzMWY0Nk1M?=
 =?utf-8?B?cCt4QUwzNDBrUENFTVk3dk9BQUZFUEpVdXM0TjZiNFc5UjcxVHVnN3VyZVVw?=
 =?utf-8?B?MFBBNFR3VFhuMGlXMGlodzNmMUxRL1U0R3VwZTM3VVhlMXVMemtKbDkyNGM4?=
 =?utf-8?B?SExFY0RyVVA0M3Z0bmtUbmtvV0FCVmNLaGZ1ZEU1eUEwMkxqaE9BN2pKQW1s?=
 =?utf-8?B?RXYwRnlIUzVzRTFId3d3SVpUbVlKOGNreitBZVJka2lQdk1USnFPT09YYjht?=
 =?utf-8?B?SlN3YjBMeDBnWlI0MzZhYXpHV1J1V053ZGZES3hpMi9iVm9mQjlXSllJVTg4?=
 =?utf-8?B?MXQyMkFpM3NOMkIyODhNYzB4dm0zNjNveWRsNUx0L0g1ay84bjBMQmtDelVZ?=
 =?utf-8?B?azFvczhuaHBjSlM2N1Y5Z2ZRSGZJUkJqYXFpV0twWVAxV0t6K3QxN2gwTGxZ?=
 =?utf-8?B?WXJuUi9oTWlRSUdkRDAwRzlrS1h4VDNtemZQY1JPZHpNak9RWlMvV3FRczVS?=
 =?utf-8?B?ekFZcjZxaHdZcWc3dkE5UDFpbTZnNEFHaHJMeVpjTmFSUFNWazlnOUk5NWdt?=
 =?utf-8?B?UFEzWUsyY2ZIa244Q2ZIbXF3YWZHM1JuVkpGdTVBT0dNVHpVeHY5RG1MRFgx?=
 =?utf-8?B?NFgxM2tNSjlaeHpnaUV6Zlo1dWxSd1g1WUxpM0VvNnZhN2kwdHJ4bWtUY2Na?=
 =?utf-8?B?cVpueGVJTk4zMmFoTmNYRk5MMXFTZWJrT0E3RVdqd1hRWThpWDFoWVlmVzJE?=
 =?utf-8?B?YmhkTEI3V00vd1RCbGRvY2d1QnJjUU1kdGlVbmxweGhBSE9NVkpHa0svUDRJ?=
 =?utf-8?B?blhDakMxaWZqYnZsV01lWGhZaXZhK3BhTVpBNk5pM2NOb1pTT0F5NEN4UWR0?=
 =?utf-8?B?UElSYVJrYWs4eGlHeGM0UDlyMkFsM05yYkZlTTRMd0ErZVluTisyYzQ5U1BZ?=
 =?utf-8?B?azVhZXQ3NzdENm9HUUZIdFdHcXUzMEU3eEVDeXpHWGVNZ0s1Ty83TThvWG1J?=
 =?utf-8?B?OStQNk1aTDNBRk55VjVvKzNMaTk4YmJrN2pEVnR3UklqT3drdjFFTHNISXlv?=
 =?utf-8?B?aHp3b003UzAvZEFDSE5kYm5Ybys0WWxIQ3YramJMYnhrTlQyNGFYRHRPcmQ1?=
 =?utf-8?B?OW9UaUlHVHlxUTRDSVd1ZFJCY2V1R3lwVXBrMjk5eHF3cVdDaWNoRzQ2QUZX?=
 =?utf-8?B?ZjBCR1dQaThNS3hnd3ZMTkxsZjRYZ3hUcVVQcEM2SE9WS1pkMDkyYTFGSkpz?=
 =?utf-8?B?azRZV2t0TlZIcXlFOWJWSDdFbjdmNWxmOFBZcWM3RytIYTBKY0QzVDNoc3lB?=
 =?utf-8?B?NTVHUE9oaWxMeFlMZmxOMldSMEo1eFlaWUlQQTZZSDU2c1V2MGkwdXRSSUNi?=
 =?utf-8?Q?48unQDzV3aVSnF0lDH44YMeVQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7981b711-9c73-4762-8f22-08ddadf2e998
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 23:01:37.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuZWL9EfdmsoXM20nXHRkM4bLEvQRzWI8oeI9eUWmpaIWh34VjZe6IhwzQhsRSMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141

On Tue, Jun 17, 2025 at 02:23:41PM -0700, Nicolin Chen wrote:
> On Tue, Jun 17, 2025 at 08:59:48AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 16, 2025 at 07:02:08PM -0700, Nicolin Chen wrote:
> > > ---breakdown---
> > > After `posix_memalign()`:
> > >   [ posix_memalign() memory ]  ← malloc thinks it owns this
> > > 
> > > Then `mmap(aligned_ptr, ..., MAP_FIXED)`:
> > >   [ anonymous mmap region ]    ← malloc still thinks it owns this (!)
> > >   ↑ mapped
> > > ---end---
> > 
> > Yes, this is correct and what we are doing here. The allocator always
> > owns it and we are just replacing the memory with a different mmap.
> 
> Hmm, if allocator always owns it. Does that mean the munmap() [3]
> will release what [1] and [2] do (allocating and replacing)?

No, munmap doesn't destroy the allocator meta data.

Jason

