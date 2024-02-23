Return-Path: <linux-kselftest+bounces-5325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8F86088E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 02:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EFF285F94
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CBEB665;
	Fri, 23 Feb 2024 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKFzPN1V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896EBE68;
	Fri, 23 Feb 2024 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653347; cv=fail; b=qZWbBqxc3/ucRi4G6OMiXYSBs86I6zx3VPsxxXxlj4Un7srSHzjCkjWZSb30AzhOc5go0cgEskJVzimxlSrnYTpSdYmNoK/lgDNz7lgy/RheK7/dNyDJTgPexK+wvoKEYpw4Po6/uDIIAhmHLNaPXoLTRW4EOr6UEEF7Cq5iEMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653347; c=relaxed/simple;
	bh=r8J7tzEJa4VhTrsYOG6FXhk4OxbGn+9GWaBZRKl5Ga0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dg/YgyVtNg7gOQ6WoX857Jbj/JCIO54Wuy6KMN+CfIivLO8sisEl0krmvJ1ZR0VhCJpqP/Z95e1XjmdJA1AVSVAdqHtt9NHQhQDuHNkKLtJPFVV6EoTMlSOhkIPT7SCnMkzW4KEpHt9tdR93lPyL4351AzDA2cp2yyQcB2+NtFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKFzPN1V; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708653329; x=1740189329;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r8J7tzEJa4VhTrsYOG6FXhk4OxbGn+9GWaBZRKl5Ga0=;
  b=PKFzPN1VAoc/QPK5ztCWZofEE792GSdszqHqfRdA7E+AEi6QGMNSNALT
   TAE0o+5AdtRmXf21/RWhAxX3ejVsczaD47zPWe7jljv2CKhSm2CdMxxqx
   fi/QHB8CabwS6UCDIVRnIqp6iIAlxWO9Nw+1n8vO4NEa7G1Z7+tcYU7KQ
   nmeyhLTUsTOye853hBEg9NedWHjgGgJ0jv/a4QeiyMUmTM0YX411nO67Y
   TV0nhgqsKjsAuKSZefFDprVlPERuJWMMmySSp55MY2qmCrJjPq9OBS+tQ
   DPN+WG2eP6zmcU7wIpoi6V5nawTCS1GwWxHozu8uT1aONwMs7Vr4JqZhL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13583591"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13583591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 17:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28913572"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 17:55:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 17:55:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 17:55:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 17:55:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 17:55:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogwFVX/+VFg3IEmNdLyGkLeuTyhIO/Y6GOFBErZL+FqIW3HSErrh9vy/oG+aEb+F7MHfnGMCYU+itIq1Ixeje9nbYoz39XzdRBEYYzYeePlXlpDf90YCccxqOJItcxCyM8N1EX6GJCzxsPSjckxrAyP7vkH/cqhdwpq4YpPp1AWXbgs4VTlPrgCByCKYLQAIEdkHeOrXllAwMuSCh1Hx0AncDeUFZKXJzGRvCGZ36q/CX/MprlKoRg5WFg3VQnAOawsqg1ZbTeN2z97LFhHKDzxuLYUMwc6XxIYmK5W79ne4BH5AMkRZVdj/zihbZsq7EvwAB96Rw7SfJkmK9FlcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR48VQNylwVA/julK0fl6GzRCdI7eVwRcEDQkeYEvgY=;
 b=Ll44hLDnrhPo0UkDLdVcFXwOsYRzbJ+B7tYiOdnRbEe7Ex7ZdiRGLh/m3MrEkciXVyXAp3pIaEvUpVqDlElCxVu7hM42PDFVaUUiFqiF70Yw6mx3a8LVS0D7YB50wOcUW3eRVkZk9nUCvVjfOfg7x6oYw/0kHk1+AXxABzxbNNf0n8+ui+qVwBz9Lzqy1/z3VycsWq73JT4mEf7KHKnIxHbjD9qQFnmpMkj4pVAVJsIHq08HfqtgPMqcoEOETHckqED2BD+SUa9PUgl1GFTQiUbbBWhaImI5/UEP5VzjO948WudcNAMjBQvFfhrj2qzvMSXWdEeBBxvI+jAANCLo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 01:55:24 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889%4]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 01:55:24 +0000
Date: Fri, 23 Feb 2024 09:55:06 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, Isaku
 Yamahata <isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter
 Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, Chao Peng
	<chao.p.peng@linux.intel.com>, "Vishal Annapurve" <vannapurve@google.com>,
	Roger Wang <runanwang@google.com>, "Vipin Sharma" <vipinsh@google.com>,
	<jmattson@google.com>, <dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 08/29] KVM: selftests: TDX: Add TDX lifecycle test
Message-ID: <Zdf6+mvU0PqrPt3t@chenyu5-mobl2>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-9-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-9-sagis@google.com>
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 590bdcb5-d386-4c1c-3138-08dc34127fc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnYDK4W5hwRF+2Q8D2kf4Jn9byIIvtPIsYNUTw/CRGwYlapwIC4pSgTICSZZM4/ZNEexFQ8TvrkmX6yXwMLOoJW6GsZFyeaOvHpQsGRX7fMpAWAbD3IhufuxkdD/nKd+TlIwTPiNKI0SsuepDejT/bKdUhMU5i7hPd0rYJTJ0EKU8RtfWUrjKelI9y5SrNMUJyGctR5nLgxuCra+XEEEuFPfEfU1S9eSodw+7TqSHxKiLEfDigp0sgtFnlWJ3R1zhbHr10/TFPIfHo68gDFmfPwyiM1S4Wl7Px9mO3qokf/CECEiGpoTbmmiJB+TgtQ0DTlJfGnwWTYangn7hhdFLjuOz/ZhRYtw/PNBwNR7RUB8+a/1JtvYDTbWXJ5Rm/iWfrBDH5ja8mX/Fe/c7w4vyDgxOXBmmee+QMoyJSv1+wvXXkyRtiuF5rleEIpRfz2oplQWkG3cY+df8MLRl74lKQaYVMieSVJkKSGiNY2oBUq06eptFAa6jRceu1I/iQX8+c1jO2Oau1DUrF4s6mGdxP1x6RqGdJfcnUUTtNwm2ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPDsjZzIbPIeggSMFSEKm+MJSRz44tLE/4HHclyC1604ATq/CH/LZDC/mHF1?=
 =?us-ascii?Q?iTMtc21L0fnZ8/rEUtCpKINRyFtWkdhsRcYCSpqLAntMOwW1NB0MR4m7TEKf?=
 =?us-ascii?Q?YpSe8WKY1ugBTknTq6fk1PiM1e9sstVs9Kk+ZxgpB0ep2MBQ6khuoV23mG2v?=
 =?us-ascii?Q?2EcO+W1uXyqL57Dq1OacQ/9KOaVP09TpChNHljDalqTu+x/lU1FKDTJRY+fO?=
 =?us-ascii?Q?nv+b7XwqQUoaG4oSnTjXZPK81joG1eAZIkjExzdIf+rTTjLwyUV7rksenv2H?=
 =?us-ascii?Q?s/14Ytz1XR4viMrKhV5/svU/g9uODQS7D/OSBORO/cC2k/q7yWfpeEokBLYi?=
 =?us-ascii?Q?TxIdq2Mqoq5RbGrU6uAKkSpz9kLSZ63qOnHj1KLyfui3Km0FLKAhORYhGVgc?=
 =?us-ascii?Q?+gjbV1/FTJHTwDsHWUmMqWSDXGOE6WemAyZHj7Ais7HfPLeQ4llkVgSL24xG?=
 =?us-ascii?Q?rVF8HVzcTR2WbzznipMVLfFapKyx0738AiWEeYB8AUQpnZJhcaFvRNOQEuI8?=
 =?us-ascii?Q?jmTYUT8/rwGJKUDF4o2fLf42pN0UuY7HRR08QLRnG1/uvn9VRz9upnmGuROs?=
 =?us-ascii?Q?9ZPHn+fUQLhnWJ4KATYlI6XOk8XeV4LWIw5T4KnMp9qZ49huyaszobmG8nBp?=
 =?us-ascii?Q?rEJFDg9lKMJlKAicp+Z8R8W9l4VBwAbBe1CwBxyf/UbZ9u8atfms27Dhy+Tg?=
 =?us-ascii?Q?ZzhHF9cL9VDZWSSAmcf4n9Gd4ENtQANZFKBSmx+BtIl6sgqKjsQ52k3gpimU?=
 =?us-ascii?Q?0cRmZwRIrbxl114Jo17Hgwy812IWw3YjyDzDSwi/lA/oUoGZin+3ArfMsz5C?=
 =?us-ascii?Q?iF1YlrRT/VgDzzjTl7VyIH1PejqyLItEX9Eg+scAB7f0wnCew7k21iXarRvo?=
 =?us-ascii?Q?EBTMiY1bgZYLQ0uIefYAx2IeWfzmqNq97UB+9wKdVFIxiO4X3yNrUBlzTEjy?=
 =?us-ascii?Q?pkUwpg4RwEeOaw5ZeeDlNp7iPnP1n8/bi1K7xo5oTRruaGQLy93reL4V1PP8?=
 =?us-ascii?Q?4oinqjbJezg3E8L3LgZ6VbmAXBYVoj1yCxvLfB8C2HvnBmQkLfN7UEqByC4J?=
 =?us-ascii?Q?YGd+b6W+6e2gTOs6RCIOjdonTnAsOOfMYM/Wx5mu+3HErq0Jo9qVuf5q8zop?=
 =?us-ascii?Q?SfAM5LxPTPDTQ8nUzVtyX4jCZ+iaY+M1tK1iP7DkvEQkgSG2C0pIbxHKbUWX?=
 =?us-ascii?Q?2AbPPBhpsP3sHGz7FYhuBXe+WyzhzGOiA4elfsLIyW9VWiSYNA6hD6puCmvq?=
 =?us-ascii?Q?MOBThNjSQTzqHjEIcYCkRekqJJM5RJi2B/wclICPac4jWCP3lM8qAam5MF0F?=
 =?us-ascii?Q?O5M1tP8PRBt56WvhvyW4h90RWcKNpkXnHP/F1vIYNu6qDfH4hanoajw6gVp1?=
 =?us-ascii?Q?B7QxhSYZPV4m8iXa721uH9UruAIrPI5gqhXXbptsEsoHzjB2iXmVSBHszvct?=
 =?us-ascii?Q?9qDULGxon0qb87cyex3Txb2IgPP/nH4oSGNqRoiJcfQutC/1wRbFcXF2dxz7?=
 =?us-ascii?Q?So2qPc/4OWMB8xf/+hap8ioZq4LuGGFFCUryeOAH67QMB+ZOSc4wCL1i9K/M?=
 =?us-ascii?Q?Ql8A3bNFJ1UpGVSWnEmtPQtNwNTlKiA4dc0CYiAt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 590bdcb5-d386-4c1c-3138-08dc34127fc7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:55:23.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VIRAdZ8Lg7b/Ka8r6FRvY0V8JtAV0y9FyIO9S3iWidjmeSgs6PiX0gk5cXP2eCq8o6+hIkITKmAG1t6QAH9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-OriginatorOrg: intel.com

Hi Sagi,

On 2023-12-12 at 12:46:23 -0800, Sagi Shahar wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Adding a test to verify TDX lifecycle by creating a TD and running a
> dummy TDG.VP.VMCALL <Instruction.IO> inside it.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |  4 +
>  .../selftests/kvm/include/x86_64/tdx/tdcall.h | 35 ++++++++
>  .../selftests/kvm/include/x86_64/tdx/tdx.h    | 12 +++
>  .../kvm/include/x86_64/tdx/test_util.h        | 52 +++++++++++
>  .../selftests/kvm/lib/x86_64/tdx/tdcall.S     | 90 +++++++++++++++++++
>  .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 27 ++++++
>  .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  1 +
>  .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 34 +++++++
>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 ++++++++++
>  9 files changed, 300 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
>  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a35150ab855f..80d4a50eeb9f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -52,6 +52,9 @@ LIBKVM_x86_64 += lib/x86_64/vmx.c
>  LIBKVM_x86_64 += lib/x86_64/sev.c
>  LIBKVM_x86_64 += lib/x86_64/tdx/tdx_util.c
>  LIBKVM_x86_64 += lib/x86_64/tdx/td_boot.S
> +LIBKVM_x86_64 += lib/x86_64/tdx/tdcall.S
> +LIBKVM_x86_64 += lib/x86_64/tdx/tdx.c
> +LIBKVM_x86_64 += lib/x86_64/tdx/test_util.c
>  
>  LIBKVM_aarch64 += lib/aarch64/gic.c
>  LIBKVM_aarch64 += lib/aarch64/gic_v3.c
> @@ -152,6 +155,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
>  TEST_GEN_PROGS_x86_64 += steal_time
>  TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>  TEST_GEN_PROGS_x86_64 += system_counter_offset_test
> +TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
>  
>  # Compiled outputs used by test targets
>  TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> new file mode 100644
> index 000000000000..78001bfec9c8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Adapted from arch/x86/include/asm/shared/tdx.h */
> +
> +#ifndef SELFTESTS_TDX_TDCALL_H
> +#define SELFTESTS_TDX_TDCALL_H
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +
> +#define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
> +#define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
> +
> +#define TDX_HCALL_HAS_OUTPUT BIT(0)
> +
> +#define TDX_HYPERCALL_STANDARD 0
> +
> +/*
> + * Used in __tdx_hypercall() to pass down and get back registers' values of
> + * the TDCALL instruction when requesting services from the VMM.
> + *
> + * This is a software only structure and not part of the TDX module/VMM ABI.
> + */
> +struct tdx_hypercall_args {
> +	u64 r10;
> +	u64 r11;
> +	u64 r12;
> +	u64 r13;
> +	u64 r14;
> +	u64 r15;
> +};
> +
> +/* Used to request services from the VMM */
> +u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
> +
> +#endif // SELFTESTS_TDX_TDCALL_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> new file mode 100644
> index 000000000000..a7161efe4ee2
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TDX_H
> +#define SELFTEST_TDX_TDX_H
> +
> +#include <stdint.h>
> +
> +#define TDG_VP_VMCALL_INSTRUCTION_IO 30
> +
> +uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> +				      uint64_t write, uint64_t *data);
> +
> +#endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> new file mode 100644
> index 000000000000..b570b6d978ff
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TEST_UTIL_H
> +#define SELFTEST_TDX_TEST_UTIL_H
> +
> +#include <stdbool.h>
> +
> +#include "tdcall.h"
> +
> +#define TDX_TEST_SUCCESS_PORT 0x30
> +#define TDX_TEST_SUCCESS_SIZE 4
> +
> +/**
> + * Assert that tdx_test_success() was called in the guest.
> + */
> +#define TDX_TEST_ASSERT_SUCCESS(VCPU)					\
> +	(TEST_ASSERT(							\
> +		((VCPU)->run->exit_reason == KVM_EXIT_IO) &&		\
> +		((VCPU)->run->io.port == TDX_TEST_SUCCESS_PORT) &&	\
> +		((VCPU)->run->io.size == TDX_TEST_SUCCESS_SIZE) &&	\
> +		((VCPU)->run->io.direction ==				\
> +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE),		\
> +		"Unexpected exit values while waiting for test completion: %u (%s) %d %d %d\n", \
> +		(VCPU)->run->exit_reason,				\
> +		exit_reason_str((VCPU)->run->exit_reason),		\
> +		(VCPU)->run->io.port, (VCPU)->run->io.size,		\
> +		(VCPU)->run->io.direction))
> +
> +/**
> + * Run a test in a new process.
> + *
> + * There might be multiple tests we are running and if one test fails, it will
> + * prevent the subsequent tests to run due to how tests are failing with
> + * TEST_ASSERT function. The run_in_new_process function will run a test in a
> + * new process context and wait for it to finish or fail to prevent TEST_ASSERT
> + * to kill the main testing process.
> + */
> +void run_in_new_process(void (*func)(void));
> +
> +/**
> + * Verify that the TDX is supported by KVM.
> + */
> +bool is_tdx_enabled(void);
> +
> +/**
> + * Report test success to userspace.
> + *
> + * Use TDX_TEST_ASSERT_SUCCESS() to assert that this function was called in the
> + * guest.
> + */
> +void tdx_test_success(void);
> +
> +#endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> new file mode 100644
> index 000000000000..df9c1ed4bb2d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Adapted from arch/x86/coco/tdx/tdcall.S */
> +
> +#define TDX_HYPERCALL_r10 0 /* offsetof(struct tdx_hypercall_args, r10) */
> +#define TDX_HYPERCALL_r11 8 /* offsetof(struct tdx_hypercall_args, r11) */
> +#define TDX_HYPERCALL_r12 16 /* offsetof(struct tdx_hypercall_args, r12) */
> +#define TDX_HYPERCALL_r13 24 /* offsetof(struct tdx_hypercall_args, r13) */
> +#define TDX_HYPERCALL_r14 32 /* offsetof(struct tdx_hypercall_args, r14) */
> +#define TDX_HYPERCALL_r15 40 /* offsetof(struct tdx_hypercall_args, r15) */
> +
> +/*
> + * Bitmasks of exposed registers (with VMM).
> + */
> +#define TDX_R10 0x400
> +#define TDX_R11 0x800
> +#define TDX_R12 0x1000
> +#define TDX_R13 0x2000
> +#define TDX_R14 0x4000
> +#define TDX_R15 0x8000
> +
> +#define TDX_HCALL_HAS_OUTPUT 0x1
> +
> +/*
> + * These registers are clobbered to hold arguments for each
> + * TDVMCALL. They are safe to expose to the VMM.
> + * Each bit in this mask represents a register ID. Bit field
> + * details can be found in TDX GHCI specification, section
> + * titled "TDCALL [TDG.VP.VMCALL] leaf".
> + */
> +#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
> +					  TDX_R12 | TDX_R13 | \
> +					  TDX_R14 | TDX_R15 )
> +
> +.code64
> +.section .text
> +
> +.globl __tdx_hypercall
> +.type __tdx_hypercall, @function
> +__tdx_hypercall:
> +	/* Set up stack frame */
> +	push %rbp
> +	movq %rsp, %rbp
> +
> +	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/* Mangle function call ABI into TDCALL ABI: */
> +	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
> +	xor %eax, %eax
> +
> +	/* Copy hypercall registers from arg struct: */
> +	movq TDX_HYPERCALL_r10(%rdi), %r10
> +	movq TDX_HYPERCALL_r11(%rdi), %r11
> +	movq TDX_HYPERCALL_r12(%rdi), %r12
> +	movq TDX_HYPERCALL_r13(%rdi), %r13
> +	movq TDX_HYPERCALL_r14(%rdi), %r14
> +	movq TDX_HYPERCALL_r15(%rdi), %r15
> +
> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
> +
> +	/* TDVMCALL leaf return code is in R10 */
> +	movq %r10, %rax
> +
> +	/* Copy hypercall result registers to arg struct if needed */
> +	testq $TDX_HCALL_HAS_OUTPUT, %rsi
> +	jz .Lout
> +
> +	movq %r10, TDX_HYPERCALL_r10(%rdi)
> +	movq %r11, TDX_HYPERCALL_r11(%rdi)
> +	movq %r12, TDX_HYPERCALL_r12(%rdi)
> +	movq %r13, TDX_HYPERCALL_r13(%rdi)
> +	movq %r14, TDX_HYPERCALL_r14(%rdi)
> +	movq %r15, TDX_HYPERCALL_r15(%rdi)
> +.Lout:
> +	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15
> +
> +	pop %rbp
> +	ret
> +
> +/* Disable executable stack */
> +.section .note.GNU-stack,"",%progbits
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> new file mode 100644
> index 000000000000..c2414523487a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "tdx/tdcall.h"
> +#include "tdx/tdx.h"
> +
> +uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> +				      uint64_t write, uint64_t *data)
> +{
> +	uint64_t ret;
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = TDG_VP_VMCALL_INSTRUCTION_IO,
> +		.r12 = size,
> +		.r13 = write,
> +		.r14 = port,
> +	};
> +
> +	if (write)
> +		args.r15 = *data;
> +
> +	ret = __tdx_hypercall(&args, write ? 0 : TDX_HCALL_HAS_OUTPUT);
> +
> +	if (!write)
> +		*data = args.r11;
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> index 063ff486fb86..b302060049d5 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -224,6 +224,7 @@ static void tdx_enable_capabilities(struct kvm_vm *vm)
>  		      KVM_X2APIC_API_USE_32BIT_IDS |
>  			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
>  	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> +	vm_enable_cap(vm, KVM_CAP_MAX_VCPUS, 512);
>  }
>  
>  static void tdx_configure_memory_encryption(struct kvm_vm *vm)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> new file mode 100644
> index 000000000000..6905d0ca3877
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "kvm_util_base.h"
> +#include "tdx/tdx.h"
> +#include "tdx/test_util.h"
> +
> +void run_in_new_process(void (*func)(void))
> +{
> +	if (fork() == 0) {
> +		func();
> +		exit(0);
> +	}
> +	wait(NULL);
> +}
> +
> +bool is_tdx_enabled(void)
> +{
> +	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
> +}
> +
> +void tdx_test_success(void)
> +{
> +	uint64_t code = 0;
> +
> +	tdg_vp_vmcall_instruction_io(TDX_TEST_SUCCESS_PORT,
> +				     TDX_TEST_SUCCESS_SIZE,
> +				     TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, &code);
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> new file mode 100644
> index 000000000000..a18d1c9d6026
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <signal.h>
> +#include "kvm_util_base.h"
> +#include "tdx/tdx_util.h"
> +#include "tdx/test_util.h"
> +#include "test_util.h"
> +
> +void guest_code_lifecycle(void)
> +{
> +	tdx_test_success();
> +}
> +
> +void verify_td_lifecycle(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);

From a user point of view, this lifecycle test is very useful
to me for vm creation/destruction time test, and I believe you
have an enhanced version to specify the memory size. May I know if
there is any plan to add that part too? And maybe allow the user
to customize the memory size rather than a fixed size.

thanks,
Chenyu

