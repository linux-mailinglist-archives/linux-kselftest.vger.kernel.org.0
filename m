Return-Path: <linux-kselftest+bounces-12008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C17909863
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 15:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D451C21212
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861574776A;
	Sat, 15 Jun 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GH4Ts1WW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9471182B3;
	Sat, 15 Jun 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718456534; cv=fail; b=tgm6kXLmsbncl2SBKeIHw6tloQ/pYAAQL6Ifxuag0wdvO3BeuMZlbuEa5oNktVrNWplDdgsfwEyZoBOq0SOHh650XabGK5Np/slwHMfgoHvrdPJhxogtPciEMe7TLMy0CojgaGEISDGoZp7KYgHpoOIFnJucXe55MH7eEZVeups=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718456534; c=relaxed/simple;
	bh=F8szjrvwKFEwxui00wxl5AWabaOhlDex39BLONG1MqU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OaUR4Q7Nl8AFZYYysLlbrS9uQYqsOXTMsLb4gKEbrLAeg8hPocupxyCc1XtrgTjjTWVuKtRBVt2Hrb2y6iI1oypKaNplpKXGODQK6Dx6vRExok1DVFz6gCPPiULfSPWHGqv2K6rX0tqqlF7/sOXNWuWi9bRhU9wcVXfXq6wuEP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GH4Ts1WW; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718456531; x=1749992531;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=F8szjrvwKFEwxui00wxl5AWabaOhlDex39BLONG1MqU=;
  b=GH4Ts1WW8Eu1LIwnxkzS/u7Zyi9uxJtN+ZN02bjWR/+xo/Wl0GFeNVOr
   QUpo0Ma1zUNTFVOLD6Q7oLTe6UWv31FnLUFX8kFKDpnjnUFBypy1CgGx9
   lP/sAIgA3VppxMt12n+EYJo1b/UQhs6k4irzs8n8NeZGsqJ0WJ/W1H9Is
   JGe4Qk8v0JdWfxtjG9iIIBJJs+fUrTWQwHXV3Jh+4nNfw/0ZFYs530i9o
   5d8ZaOF2hbnFX+muCbS21TIJp3rbelLKrbI1LlRs0fzh8fv6a1+1omJCY
   zJbM+/nL5M4vim3ldfSX1hmgZ/RlcCKXsU0+xbQ9ztKWV+4VmoVhF4vII
   g==;
X-CSE-ConnectionGUID: qCV7xXKHSWC+Ci98nq56HA==
X-CSE-MsgGUID: XVv3lKgUQziXV7IRcActTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15500213"
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="15500213"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 06:02:11 -0700
X-CSE-ConnectionGUID: G61X0edvTCyHPsP8LW0vOg==
X-CSE-MsgGUID: /EzuA4qHTUCEGjtOFEf16g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="40876320"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jun 2024 06:02:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Jun 2024 06:02:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 15 Jun 2024 06:02:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 15 Jun 2024 06:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM1WQTrFaUhO75JVWvvEv2i9tjQZ7Ay0lPY5ubynS/UjEQyfvTvWrY+Vl0GPjPNTRUu2KLVflHIVABeTJTPe+tbEY4pYl4NzH4pLFX2aUPKG8xqLYaioY6NtCwbDLQp0UTgU3RNZkzLVahobhdNHFhsPwpmxzbxmvJ4557PU73MsI86xPjbjyPHmc3flpNm+RJVQAqXmnTS0jNcvKDloKMHB+GkbPqMEYTPMN/eq4HbWXwvpNRnZB1mV3L4kHwtjdc4N5Q/ls57DJj8hKWa7LzDFXgv7lBuHPgY7kHlEghkYlNdD+MhIXXGCyPKGjD4Qy++P8fsdrbOpXNOV48/EAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwZrqMhF3fMhPTaNalWexbs81z2Dq2jdaaXH8Z4hzcc=;
 b=Zp2Nt+9/gE5aWUft8gVYicfVTQvdybLBrf3qCyx9bTz8MYaPFG8lyjQ4/xQg5dU0UFnsGuW+UIUdxcblGh5/Y5TJsgRple6OTLvBHzhXt3DUpoPNOhMWKLgAXvPQc3oA/82CSfgwbdDKHF5uPfoIraYsKjDnsSu5CBIT1gz6ZVYCh+wbpPaak3jiHVj0nrJ+T6m8bQOEwyCCrfDF39N7z3aIsdHUxwygtBy9TlzkpdsI0dmRMxqOYxoJjSP3p7E6ISUm3Ycs36DSy/x2LxD1uCDVBs/T+xHm1Ca+A88VzBKpgTLXNqloMyv3F882RxfPQy0CkE6lbnvPnFlp2gabkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by SA0PR11MB4768.namprd11.prod.outlook.com (2603:10b6:806:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Sat, 15 Jun
 2024 13:02:07 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690%5]) with mapi id 15.20.7677.027; Sat, 15 Jun 2024
 13:02:07 +0000
Date: Sat, 15 Jun 2024 21:01:52 +0800
From: kernel test robot <lkp@intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
	<james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
	<yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
	"Sean Christopherson" <seanjc@google.com>, Haibo Xu <haibo1.xu@intel.com>,
	"Anup Patel" <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>,
	"Aaron Lewis" <aaronlewis@google.com>, Thomas Huth <thuth@redhat.com>,
	"Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>
CC: <oe-kbuild-all@lists.linux.dev>, <kernel@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] selftests: kvm: remove print_skip()
Message-ID: <Zm2QwNoJM2/GHy7Q@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612104500.425012-1-usama.anjum@collabora.com>
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|SA0PR11MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: c900d1b5-aca9-4c0c-4f52-08dc8d3b5c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V1XjfHpi9cR89MtvLFIN0+/wumeth6Si0bdKuqYZmeAwUlP8169qarHIgjtj?=
 =?us-ascii?Q?9kbKMFSqHjwvSXQe3mcstuH29YRkOnc3V4+7190YzkR0O0yRjxLWKl7BFbyH?=
 =?us-ascii?Q?UHqBYv1Tp6rvqpT6VbkvwGZBpRqskbOAk3qK5DLJwn2urVMwlOT4p1roXG8C?=
 =?us-ascii?Q?SH6DlGF81O+HwSlwMswq6kywIr5edLZIfSTbH0IpHq5/BY7pwU64aD+58cxD?=
 =?us-ascii?Q?4DO0rdAPQ6zvjLVa62QkNO38VA3i7SzPva/Pdj7vsmBjKoWM5ozzEg3VgXPR?=
 =?us-ascii?Q?CKqZL31X+xOaWBjl7UW8U2XB3GaixiqqWwLWbDZbF5qM8zSYcvx1LgAhuSeO?=
 =?us-ascii?Q?gHQ8Yg3sHW2HexhLtohWkl0j/P0ONIkQkWLgxMmtv9boqCKI/7Aca2UhjykZ?=
 =?us-ascii?Q?Zu3OjcbN5ykmkzIk1pQy1CLTn+Ear+hj/pXKh60vjfuX+R1iilvgO0DsK0VE?=
 =?us-ascii?Q?wzwODTybIUsADiMgZJJFxx9kyOGq20XyUGy32y2WZQ2F5UrV3Y4umaCX3/CG?=
 =?us-ascii?Q?USFnofcce3H2gxCsAdq0TBwg2cPH+re8QY/kovRq2p0eNgm1hf5WwD+eLAuo?=
 =?us-ascii?Q?4bKv5DYdH+Huf7Xzl8TdyiFrXglmTOE9jMepbq8UdLVp1W2lJu17Iec5z252?=
 =?us-ascii?Q?Izaubg7ow42V0fdWB9htUXmH/TMYHVB8pWTKI1I4XJOCgnKtgUEfSWvUEJYW?=
 =?us-ascii?Q?DgFyxocIDmAQPYL+1ztz073S2YuAemweApyChIaJdZ7c6AUVLnnGVxBfusqX?=
 =?us-ascii?Q?bvgCXlVaLONgFaepQFZ80RjZAA/ICbuY3IvnM+DAEhsPiAoqAy3wTJs8BV9q?=
 =?us-ascii?Q?0PSivbLQt5nKcSIzWbNHlJGXgE19a+LqnVRDjkXOSK/jLDdpNRLBCNzOjFPf?=
 =?us-ascii?Q?yIGiYl/rNXwgUpa+4GNVk9MQ/PPAE6t55WWNoKQseBqzRyTC9MQk1bd2w7dr?=
 =?us-ascii?Q?Ve8Kw3b27NG/U7J47JmpssjG7C/MaNM/o4k0NCEvjUE8bMLo4tjfnJkVxdW2?=
 =?us-ascii?Q?ExUkRtBvyXRuO1bvZAHYhx2cubU9GBnWAc1SN6f/FIKe3ZzuBBemuY1M/PjD?=
 =?us-ascii?Q?AbecG1qH+hx/yMay1N5xOkhgbnNR3CQcmhKXFpB3RtB5YZ1LP5v8sKDdz7mi?=
 =?us-ascii?Q?7L1PNrOorBaLHnPyIDmK1FGvWbiYnDKfr4sA/iFkKcCCYxnGqxRIi58wpcZ7?=
 =?us-ascii?Q?9g21m+0mS5e5omnc4pcXPKrWzGXvJFZNK96nSrPK49pqsGBcPsont+COdoiH?=
 =?us-ascii?Q?tFcPA3NMKKdth9aen5h9+jlPry8Hc+h4fXH8CZ8vVxqwwcR2Wg043Xatt+Ib?=
 =?us-ascii?Q?3Q0F8+Wiw6F1WcwgGJhSJplO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yy5PkxEuVyOMy31uucok2iB+KJYbAEDDKnR6zvLBUxDosnl1ni3/tOYjcCWC?=
 =?us-ascii?Q?ZmJeVNacH5f7JPEVRLNYYN7Vvu4TLR1H91cJkwlilhlzhFeTgCDTkO77Ujrw?=
 =?us-ascii?Q?rZBD+inHsiPvLCCyczpJweJ0GiVZ3MKsVgvS+6z7dPNoHE5le8Xn1ikLpw6l?=
 =?us-ascii?Q?okpdSNArxPgpK6WL65qoxHwGxo1VIf0tCHMA0rQskdbLNgG+clCRRIDF44Sn?=
 =?us-ascii?Q?EaPTFcfOxq2rCUPr56RJyt+vzFrxRpM6BF7ZQOZQI33ytrCXwvsTGl/Q0ekf?=
 =?us-ascii?Q?1y5+cETM1PBxhoAeBHK+kJ4cybbYBoIklEbigkiCf+5jaAbC7ipcMZg+UmqI?=
 =?us-ascii?Q?18H11SJNYLQvFQltHgTUTJLbY6GaJmRGYFZvbOs4BHMGQeoUyLiSyG1xxjEG?=
 =?us-ascii?Q?NKAgczpfsuSIkNjTLEz8duyUS8SnyF7jRsw62vJvVIsoR5pbjt67Izh0RGBb?=
 =?us-ascii?Q?OvL4uFsWrRNXbjatVHrzKIaugrpIzGzpRa9hB4PqfXH85mVqHZbcnjy+LCcQ?=
 =?us-ascii?Q?4rYfF2d8Tm+1Rz30MN+umMt9Uo2U7FMiYYlXDLSmszuqwJ/YQ2rIakP0U7a7?=
 =?us-ascii?Q?/0s8yV2MlC0cTvcLNXURvTwwnF1c2ZjuJihmVRyDI6/V9SbNhq5kLO93TqTj?=
 =?us-ascii?Q?mByT4vJMri5k4KcabdHOjPcmdynmfkQCvZTvhVAy6mmAUd79KEe9z3rEdMDE?=
 =?us-ascii?Q?R5kpnTgLi1Pe0ZdIfBKxUaJbT3qNzoOTcg/jGJ+VmZ697w6Ma/P0aAzoVA5w?=
 =?us-ascii?Q?ud0oyblbprful2u8KcBp1O6IeoXU+MGkKNI3mk7XD7SVhx56xSSTnthi//jS?=
 =?us-ascii?Q?FVS5uVhlVN88uSqWR+56iTf5rMPHO3+54pZ425L2KwmW1FVeZr4ogu+K67zV?=
 =?us-ascii?Q?9JCEoAIBIMv0vFl+RZFokZzGXm8pAg/YuSmnWRXIpaXSn/4WM5fVV69K2YsF?=
 =?us-ascii?Q?ylb5837eXDYfeqhA/j7TuXzumpNOWysPQWOvgceY1kl9g4+sLJtOLPuxB2+L?=
 =?us-ascii?Q?8PHEPQx+8iWIwO+g9nPTCJsxDt1RYcOdg8vb3vKfE34vKVf7HIH0iN/ikKwT?=
 =?us-ascii?Q?w2fR1WXpCjlssBW1e/4+/1HKxN4F2MYIjfeDJ6OveuftVnE4o5Im493jj5Az?=
 =?us-ascii?Q?Fl6/dV7qzKVJH6/pH4N4hBmfvop8/1JAQibuNt+SwUCA8tLF/zx/jDSXMDPO?=
 =?us-ascii?Q?fIuoLF38XwaHzoqZATBWXQgLz+wNmnZYfOjhsUwANUx6bqC3AJs69MY78wO1?=
 =?us-ascii?Q?vC0ObPZJ8v5kPTemxTuDpVIUlxE731NNFq6x4qhX+5jC09jvhgjNtPiAIt0J?=
 =?us-ascii?Q?aKVwZOwk4KMoHpArLcHMoLXP569POZ6PxhGhJZfP3huwXeShCHoppC/Elp7W?=
 =?us-ascii?Q?RL0YwlriD0sy6tfqUGfDVvOA6XcGjpZfvglwgmTj92HVPhg1CNZiKiMdq3/n?=
 =?us-ascii?Q?D8F8xAq+ufAMorsm6Pk7R2zIgJzf8nzfP1n3Ca4ACyoWSbcpi8U3XqwidCDg?=
 =?us-ascii?Q?79cxJ1N/UzQw95ylnJBWSJitXbcXerwriL6QQUuEPl3wb1SF3vVzFjM9oExI?=
 =?us-ascii?Q?MZYRtGe+YIKHQWaTD3d7HRjCkIU7ApPOWXLB1MkmyxzQc1WuXu3O7dTqnrHB?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c900d1b5-aca9-4c0c-4f52-08dc8d3b5c80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 13:02:07.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iX2tMA3dqpV6q4stj5dkAos96UcgAOdmwrkxz+l4r1hN7NdgVZLh/ewl96qN3kLlLak6zgj91973PjTeePxMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4768
X-OriginatorOrg: intel.com

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvmarm/next kvms390/next linus/master v6.10-rc3 next-20240613]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/selftests-kvm-replace-exit-with-ksft_exit_fail_msg/20240612-184820
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20240612104500.425012-1-usama.anjum%40collabora.com
patch subject: [PATCH 1/2] selftests: kvm: remove print_skip()
:::::: branch date: 3 days ago
:::::: commit date: 3 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406151641.BjqL765q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406151641.BjqL765q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> x86_64/hyperv_cpuid.c:155:1: warning: unused label 'do_sys' [-Wunused-label]
     155 | do_sys:
         | ^~~~~~~
>> x86_64/hyperv_cpuid.c:165:1: warning: unused label 'out' [-Wunused-label]
     165 | out:
         | ^~~~
   2 warnings generated.


vim +/do_sys +155 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c

7edcb73433276d Vitaly Kuznetsov     2018-12-10  128  
7edcb73433276d Vitaly Kuznetsov     2018-12-10  129  int main(int argc, char *argv[])
7edcb73433276d Vitaly Kuznetsov     2018-12-10  130  {
7edcb73433276d Vitaly Kuznetsov     2018-12-10  131  	struct kvm_vm *vm;
813e38cd6d7b42 Sean Christopherson  2022-06-14  132  	const struct kvm_cpuid2 *hv_cpuid_entries;
5c6e31b3bc4b52 Sean Christopherson  2022-02-15  133  	struct kvm_vcpu *vcpu;
7edcb73433276d Vitaly Kuznetsov     2018-12-10  134  
7ed397d107d461 Sean Christopherson  2022-05-27  135  	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_CPUID));
7edcb73433276d Vitaly Kuznetsov     2018-12-10  136  
5c6e31b3bc4b52 Sean Christopherson  2022-02-15  137  	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
8b460692fee46a Vitaly Kuznetsov     2020-09-29  138  
8b460692fee46a Vitaly Kuznetsov     2020-09-29  139  	/* Test vCPU ioctl version */
5c6e31b3bc4b52 Sean Christopherson  2022-02-15  140  	test_hv_cpuid_e2big(vm, vcpu);
8b460692fee46a Vitaly Kuznetsov     2020-09-29  141  
768e9a61856b75 Sean Christopherson  2022-06-02  142  	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
8b460692fee46a Vitaly Kuznetsov     2020-09-29  143  	test_hv_cpuid(hv_cpuid_entries, false);
813e38cd6d7b42 Sean Christopherson  2022-06-14  144  	free((void *)hv_cpuid_entries);
8b460692fee46a Vitaly Kuznetsov     2020-09-29  145  
1ecbb337fa107c Sean Christopherson  2022-06-14  146  	if (!kvm_cpu_has(X86_FEATURE_VMX) ||
a9af8b5d3d419a Muhammad Usama Anjum 2024-06-12  147  	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS))
a9af8b5d3d419a Muhammad Usama Anjum 2024-06-12  148  		ksft_exit_skip("Enlightened VMCS is unsupported\n");
a9af8b5d3d419a Muhammad Usama Anjum 2024-06-12  149  
768e9a61856b75 Sean Christopherson  2022-06-02  150  	vcpu_enable_evmcs(vcpu);
768e9a61856b75 Sean Christopherson  2022-06-02  151  	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
8b460692fee46a Vitaly Kuznetsov     2020-09-29  152  	test_hv_cpuid(hv_cpuid_entries, true);
813e38cd6d7b42 Sean Christopherson  2022-06-14  153  	free((void *)hv_cpuid_entries);
8b460692fee46a Vitaly Kuznetsov     2020-09-29  154  
8b460692fee46a Vitaly Kuznetsov     2020-09-29 @155  do_sys:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


