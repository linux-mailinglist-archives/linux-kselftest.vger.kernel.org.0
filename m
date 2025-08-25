Return-Path: <linux-kselftest+bounces-39819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56708B335CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 07:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFBA3BE66C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 05:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BEC247283;
	Mon, 25 Aug 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfK+qefG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BD19D8BC;
	Mon, 25 Aug 2025 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756099982; cv=fail; b=r9lfjWUsY5vknd2kPhMbY+YNLaBmr/u6o5zxYODCkFfLadqnZ/qSVMwj7ghPRm1Z2yuZ1vgFma73KMSSDqIRUGRpXzPSgL3V8KIyYQxfmJLMCVaXk1Zmtc+hw8ffhIgbeIgYR/5AlshGPFs4OCEuKMNd0IV3XCT7KvLzSU+QRGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756099982; c=relaxed/simple;
	bh=+ow4Cw4k/PUIPJToQstPbk33YD6vPT/9iTHu30x4/mQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DAfoVT8MYzxoZS5MsCQ5iABBsf/PTZb/Me8kXOI7+ij3wtQD2KC4c0fAPPx6xe/jNgqWSeu5lhXxEV6HSdw5ncvlQHvlqiFP7FtNKJaiTQZgjUhoKTr59i2jZYeQBPn9yq9EHigX0/lk/gYYenC/wnB9Q3iVZRLV3QKU6y0K+hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfK+qefG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756099980; x=1787635980;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=+ow4Cw4k/PUIPJToQstPbk33YD6vPT/9iTHu30x4/mQ=;
  b=ZfK+qefGYSff3C0aGg6bLWgogtEhZhgbkEivTHEyj86iKE6FC84D2xG7
   50CG801nZk43VtG44NMhDchjCMnTtZoCVyDzZ983GNVB4pVQOVLCLdmOJ
   16HSZFshOemdFx3yONbysQLlEU9RksylYgEZ0W4Hd2ejK9gz3oARvI2gX
   L/m0+HguNlibqAIRlW8ABpkDULPrMYfbA6tyva+4QSeqNxhm8YQ6dneNl
   mnzFsMa/4J4/OxZ9xzXdFphhI4dZ3bNg7xhXhota4vVRz2qLRHcPqA11C
   ERmx9qLuf1k7wAaR05uMep2deCqe7eag9gHOkLFY4NHQ0wzukaQ7NTzui
   g==;
X-CSE-ConnectionGUID: TaD0RpFHTRePmi21Xf5tvw==
X-CSE-MsgGUID: vGu7YrTPToCRCDj0ElWlPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="62121691"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62121691"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 22:32:59 -0700
X-CSE-ConnectionGUID: BjCDctNrRnyM6F3yXQccJg==
X-CSE-MsgGUID: cTZ2y7Z+RTS+iFrej6Rblw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168444755"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 22:32:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 22:32:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 24 Aug 2025 22:32:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.75)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 22:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwP3oC/EwgzC9l6XkkeDJMmdsEjUs1D5l0d1WKLKqwzn9AL2Oi5JWDtcYry2kH6K8DHAkWbXT/CSIJ3u0e94MZkOdn23Hnii0YK17mqHNIGIjfwRXFegXqf/9Gt6CYVYwLyWej8ALeg8i40WRxkuA7+XAFq3KbWbnjXbzHR6llThax6KkD09NvMabphY2/RIzibL5WVI2LcBAt5Cv1ajBgaatRt9vBR0N5LLqxMmKJIifEr0HvKT4p/DjbNEaFUNoCP51S7higXXvi3xUG3q0NL4Qofd9TLhbjtYcpcSrAA+HCl7VYeqiH59gFSND0i56iwy+jFE4137eTdGD0XiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6/NBISEvZaSerEZAquKtbVxMB9f2HlR8STZv6/A/4Q=;
 b=xCMwhH6ZTM+L3K5XIFJ9XwQBIku06JvzM1StRDkLSeJJIDKYaxRrYFMdLrc9ro4d/t8y4nuLzkc3kKepeSmDKIC0r7/pW9sRACVbn9EfmbEXfqkCvjWJWB0aaeYOdjx8dPf0cxNV/CcPrQ0BJa2o3RBaHZuAsmjdYqvRwnjKgB0i2hOPCse2k/FVIt5l9irMpwAOJhLo4Wf0DaNK0C40vOgJC7qpKe5mZ07TCJq3BlUl7I1BBnedwDthO3Wl40aFe0HHVkRvW11Y5eBYhXuO0e3Zx62vdfNSCyG09/bGVvevaqSiTgZckDwfhFWs5F0GmzuKssp5EPWW+loamZd8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Mon, 25 Aug
 2025 05:32:56 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%7]) with mapi id 15.20.9052.013; Mon, 25 Aug 2025
 05:32:56 +0000
Date: Mon, 25 Aug 2025 13:32:04 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 10/19] KVM: selftests: Set up TDX boot code region
Message-ID: <aKv1VNFiOPJZBN/T@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-11-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821042915.3712925-11-sagis@google.com>
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbe3e4d-e15d-4d77-e5bc-08dde398d80c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?isoyE2Q2FjJonMjBpuJDmJgTr5JE5+P1FodtURQw511MGO5pabQeu5S0YZWE?=
 =?us-ascii?Q?IwoVtVzJMKQ+TnXl4KyNDABPAYTjwQzZzU/F87ZJ6X12n3Pzite60INkc0hQ?=
 =?us-ascii?Q?/EIoVe1Vq80ti4OIwg79sYIxhJfneQxagfM55UtxNYGpwa4rQ+WADzk3NgxV?=
 =?us-ascii?Q?ujfymyQ/nEjNg5+kSaKgnbN5Y0r++i55UTJAdmkfRWBKl6JcWr4kAyAojfvX?=
 =?us-ascii?Q?e1SK5kLuKjnOoG+1yAbQiiBbLPxU3DdxrQSoCaxgIB933L5mIYlRHVEoYiQk?=
 =?us-ascii?Q?LdSeMz1t6v5MRLfGIJf/3SiZp+Meh9c4cBjG2bySqMjHKoOEkwyGPPA3HFOK?=
 =?us-ascii?Q?9KO4hTxgly5r8T76nF8Sk1LENnIV8uOYavp+7YzFXSkWSNG1h79OOGOcAzjI?=
 =?us-ascii?Q?ZYC5tZ69+2eAKmeNz/ie3ZP8gFEu1W4L0v9ks4eqaoJDadGoS+MakAX5rWk/?=
 =?us-ascii?Q?STUpJeTqfV8MVDJTkZOw+Ra8M4OC//+Zp+ReZGfBhYVduk8BvvDySFuvwx6i?=
 =?us-ascii?Q?xpQi00lYp1cngGa7D/wI3nJjUeXIfgDNRmc07RaVLTFmPvF5u/Rb2H0MX71t?=
 =?us-ascii?Q?MVEDhl9vUYEfO0d7Mr7ESqqF0fqggpcpsT7et9IalvEa5Q4A7YOWvDVa3YeO?=
 =?us-ascii?Q?8IGxAFZl8b7vEboK7MB+Za8JdO4vMLjZ+G0mx0AVrD37VxCvnsT4I8kSyTkX?=
 =?us-ascii?Q?MIsUigZNSpQ1sx6bPQpd6BZpudDH2RldKKTK0xq1t4Z0L4xOu0I0AyWgYlRN?=
 =?us-ascii?Q?mdHFQgbcS2t10NbWJqFuNK+C55JnPFzcZ+Or4nCAtilOiWMWmL5UszpFt+HO?=
 =?us-ascii?Q?Kb2OxQiPJDParSn6/J2qBCsQWe31DW20jeWyn4vSrO4A3I++xlX0caAmMibB?=
 =?us-ascii?Q?Hs0KxoOPWpR0w7A/8JyLoxLgs1byzbMXCsXFIT13kFb9WF7anyuBkxA+eQvG?=
 =?us-ascii?Q?kMiNcmMmDlujM7YIl9aBPqNA3jZFNvTEUZ4mE8uy8w3UVHO2VsHLK5Y7QEeF?=
 =?us-ascii?Q?VDTtYjcGBW/6NwIVFQhg0mvp+48tghJz8B9KVqmgqbSb4wdcb+QAnm6wFEl+?=
 =?us-ascii?Q?LZzs1CPLtpOTyDIjl3j9ZegAz5CA5cqi8mT1mxdkTmnf+qwD8YsEy17P432A?=
 =?us-ascii?Q?Z1/IcMQu08XoCeCkRie1yu0U2PPuNQqzxZjeRdKA3IXmGwNX+ZE/Shz+oBTz?=
 =?us-ascii?Q?GgGX6b9p1ZAT8Jktxe66rloHEDr2gm/BWw3sZ65xgs2Y/Q/APZlfNN880doa?=
 =?us-ascii?Q?r6pCSmmhs4TPs0O6NzInol8lrr/67IxteYxDt23jEhxOfcUJaLvz2DjjGmux?=
 =?us-ascii?Q?nu8AuJGpDv4DnjVmBxuEv5jnQ2/uqEFoT5ocTtjRKLhvmpXB4sY//7iq80Z4?=
 =?us-ascii?Q?loJuYURHg34mwjXRipWdhWQoSiS9o4/KYcbul30tZSvMXCqrXxwh5+KHf+aQ?=
 =?us-ascii?Q?RkwOxuocnMQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0P7jpS8uGMlzOAd45TyMRgNVlVYmBuUCDYbtWgGjfVB2p/ROA0zN/OcLVtvQ?=
 =?us-ascii?Q?fwDlS5Rdh/zOr89xdxslssjq19SjLYbSE6OT4wivUs6VseM9MDuhJtsGRcqP?=
 =?us-ascii?Q?bTYdaC/DQ94xZ/PTkQr8MD85x9/7adAdpTmjaNY6qhP5fgrpzmYV8P4r5DnM?=
 =?us-ascii?Q?RfDIAXfTbkAdQzEX1sOOQ9L7G2R5wnM7BGABrayM/PywRYJg1DYS9HweAxxl?=
 =?us-ascii?Q?zS1TYH9TJUHL5JzYwpDblzTLlM324F976/7mTKh44PPAdAnsX5BSBBEZKzP2?=
 =?us-ascii?Q?MmD7LI7I2iE9mjQY2EYAGfjN+/PM3CMfNe3FCKBNu6x2WkNR+D69wN3wiKUU?=
 =?us-ascii?Q?uCCzhE68vtwThIzCrfR5pTliGQk2ryopwUT3ypHIi+DuR3tfu8oei+9NKD7c?=
 =?us-ascii?Q?/s6TAAzRaihticJc61zPboBCC7RIO8aOtvPSnJU7WSqfgoU8T0M2Ai4yQUsG?=
 =?us-ascii?Q?gsYWB3VdBnCC7oxmIvZ/T7yWZ/mJczhXqkKzouOowXdZsXLxzJlztuWXKxOX?=
 =?us-ascii?Q?n2ZEKUHTSg/xUDqO0UGNrvwUHTM5ynufla2CcqrzNpm4EEcgT8d6t1odjrEv?=
 =?us-ascii?Q?oEUkZs9DFJYrUb1QFUHOzwUKC75OALvyFXGKK8beNNVUMjVOh25CG/qyHMA/?=
 =?us-ascii?Q?tCY5mg9z7xjpdBlwmhaWsjahGhmrMWA/vZjYUjCFgJaEnWXnmkKh2F7CJ+Uv?=
 =?us-ascii?Q?OiI27i0sTM/+5nb4ptlUGA2Zt4EELRc7z69s7oXlHQ5+1znxurwqZPkHhWCv?=
 =?us-ascii?Q?K9OIww65yuD3xPcfuZd5+lM2Sh2bsxhURkIooZC4DejLO1oqqBmLLuTh6Nxs?=
 =?us-ascii?Q?4lGOlqpnV00xALlyxhb/Uoztuj06Q+buyLUaV+FWzY+VXMHuUD9/310dm7TN?=
 =?us-ascii?Q?1i9chNhWD+bA3JItHZWDcfi5AWn7ue+E0AXoieJLKk+hwTarnUqj7W+zSmxY?=
 =?us-ascii?Q?mWAjRA0BEJ47rM6u5XklhKuGVN5RuJM2u8WfYdkh23KzH3v4meKIC8k/K2qa?=
 =?us-ascii?Q?SAgBqc9iSMI2qVksYC3VQTQ2neYAO7oZiFH+nAqWEXcrr4lsCh37ROPmmLjP?=
 =?us-ascii?Q?U5mRsz1d9/XixkSJQPz4HPKcTtWegLyg7AR6oNNKLJoXPEfFULNRrHN47qFr?=
 =?us-ascii?Q?e4QkZcAi4bo6sNY9huDb03XkPl3wXwFkh9GM6oSh5iknDdvCsqQXt9GFE3aj?=
 =?us-ascii?Q?7NE5AT7GOX6Qy57zmTCFkAfx8DXI9gRLNlZnTO9AGSC1Ux4gZfHmGRQshg9L?=
 =?us-ascii?Q?GgQLJ875ME9FqfXfjy+hIvgga4B+dBuWODNpFzCn/8Gat5uJ5NZp4upmp/FI?=
 =?us-ascii?Q?6AqzuW3UZf5VpMSQp7TFQRbKdn2iNHI7TARc84twl9LuKTcOpvzQCnUvP9K3?=
 =?us-ascii?Q?OSr0zg/rjiWSh5dyyi90bMwvW2erVAfcSnblqWX825Dn+P2DJv2cs/p9IxFG?=
 =?us-ascii?Q?VH+JS1c6ObN8lFklWcPEbdAIRUpHo7G27IAwtoc9d4Dh9fuTttSXF68Cmon8?=
 =?us-ascii?Q?XHUtbbJROxQon7mD7cJ3fo5xvUxUurH8wMZWvmvT/P4csJp20RKaLoaJWh73?=
 =?us-ascii?Q?s0ob3IfyQ+kQ8w4WbLfftRT1suduP/HbcpGzBXMz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbe3e4d-e15d-4d77-e5bc-08dde398d80c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 05:32:56.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0BSEy+xPkpg7bFjX3he0V5P/WKast/3itKssfVSHcvKmULzsfxn/nTjzJEl/tGpYSCcotk/iJWphgljhYTp5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com

On Wed, Aug 20, 2025 at 09:29:03PM -0700, Sagi Shahar wrote:
> Add memory for TDX boot code in a separate memslot.
> 
> Use virt_map() to get identity map in this memory region to allow for
> seamless transition from paging disabled to paging enabled code.
> 
> Copy the boot code into the memory region and set up the reset vectors
> at this point. While it's possible to separate the memory allocation and
> boot code initialization into separate functions, having all the
> calculations for memory size and offsets in one place simplifies the
> code and avoids duplications.
> 
> Handcode the reset vector as suggested by Sean Christopherson.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>  .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
>  .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 54 +++++++++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 03754ce2e983..c42b579fb7c5 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -31,6 +31,7 @@ LIBKVM_x86 += lib/x86/sev.c
>  LIBKVM_x86 += lib/x86/svm.c
>  LIBKVM_x86 += lib/x86/ucall.c
>  LIBKVM_x86 += lib/x86/vmx.c
> +LIBKVM_x86 += lib/x86/tdx/tdx_util.c
>  LIBKVM_x86 += lib/x86/tdx/td_boot.S
>  
>  LIBKVM_arm64 += lib/arm64/gic.c
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 286d5e3c24b1..ec05bcd59145 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,4 +11,6 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  	return vm->type == KVM_X86_TDX_VM;
>  }
>  
> +void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
> +
>  #endif // SELFTESTS_TDX_TDX_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> new file mode 100644
> index 000000000000..15833b9eb5d5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <stdint.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "tdx/td_boot.h"
> +#include "tdx/tdx_util.h"
> +
> +/* Arbitrarily selected to avoid overlaps with anything else */
> +#define TD_BOOT_CODE_SLOT	20
> +
> +#define X86_RESET_VECTOR	0xfffffff0ul
> +#define X86_RESET_VECTOR_SIZE	16
> +
> +void vm_tdx_setup_boot_code_region(struct kvm_vm *vm)
> +{
> +	size_t total_code_size = TD_BOOT_CODE_SIZE + X86_RESET_VECTOR_SIZE;
> +	vm_paddr_t boot_code_gpa = X86_RESET_VECTOR - TD_BOOT_CODE_SIZE;
> +	vm_paddr_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
> +	size_t nr_pages = DIV_ROUND_UP(total_code_size, PAGE_SIZE);
> +	vm_paddr_t gpa;
> +	uint8_t *hva;
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    alloc_gpa,
> +				    TD_BOOT_CODE_SLOT, nr_pages,
> +				    KVM_MEM_GUEST_MEMFD);
> +
> +	gpa = vm_phy_pages_alloc(vm, nr_pages, alloc_gpa, TD_BOOT_CODE_SLOT);
> +	TEST_ASSERT(gpa == alloc_gpa, "Failed vm_phy_pages_alloc\n");
> +
> +	virt_map(vm, alloc_gpa, alloc_gpa, nr_pages);
> +	hva = addr_gpa2hva(vm, boot_code_gpa);
> +	memcpy(hva, td_boot, TD_BOOT_CODE_SIZE);
> +
> +	hva += TD_BOOT_CODE_SIZE;
> +	TEST_ASSERT(hva == addr_gpa2hva(vm, X86_RESET_VECTOR),
> +		    "Expected RESET vector at hva 0x%lx, got %lx",
> +		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);
> +
> +	/*
> +	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
> +	 * code, as there are only 16 bytes at the RESET vector before RIP will
> +	 * wrap back to zero.  Insert a trailing int3 so that the vCPU crashes
> +	 * in case the JMP somehow falls through.  Note!  The target address is
> +	 * relative to the end of the instruction!
> +	 */
> +	TEST_ASSERT(TD_BOOT_CODE_SIZE < 256,
Looks TD_BOOT_CODE_SIZE needs to be <= 126, as the jump range is limited to -128
to +127 for JMP rel8.

> +		    "TD boot code not addressable by 'JMP rel8'");
> +	hva[0] = 0xeb;
> +	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
> +	hva[2] = 0xcc;
> +}
> -- 
> 2.51.0.rc1.193.gad69d77794-goog
> 
> 

