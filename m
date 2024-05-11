Return-Path: <linux-kselftest+bounces-10089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD08C2EBA
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2B01F228C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4AF12B8B;
	Sat, 11 May 2024 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWSmZ3w9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084612B77;
	Sat, 11 May 2024 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392444; cv=fail; b=qQ1JrpFK2i4xcEmDzdj1mMafFwK29DPmimbEcFS5116yup/1ysNxL2JvxgboFzlC4b2YhoH+ZtN24nR/eH+i5LD+oDiP9nbPtowWiNxN9TXYCr0Lwzn4dMUEGJZk8tsZXNZ3UM1ADEl6tDFYto/zY+dAvCmrJ7o4wB+bBQTNyAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392444; c=relaxed/simple;
	bh=gdejX8SUzOeLUTeLilguNYmFLogZJLv+8yC3AAXRyz0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VUbmhBIYU96OWpeewa0ElFyvRNdP7MsHjNpdRb1LZwxolb/NO5Dihbgi/jxfhEfXe0JKsPdgwBFys/YRipfrJiUnd6LOIaikRq6VYYZwJFe1Gz7+KFbEOmRGzrTajSJgA/GMb80g2m7M3/8jplJGKQdyAQGTFrzDPL2Zd+a6yF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWSmZ3w9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715392443; x=1746928443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gdejX8SUzOeLUTeLilguNYmFLogZJLv+8yC3AAXRyz0=;
  b=BWSmZ3w9i7CVB4FFOYI7fyUcygMGnsSI1xgc/9b93j+0qmozJ4GOJnZs
   cML/xR/OSj80GfsEmfnlk/epgs2CSP1HvRiFjWApVQG/GPiKrsrrwS1P5
   6HpNRXGEKoYWp04d9ykCpQSFaeShLcBRs4qPY1cdcOo1a2JGnUN/P0JPy
   +xMk9pSgL85OiJZCUQtIhTgELKNbvlzIzwO0tp+iP1IbvyGIPnbF3pm3F
   gKT1gpr2c+/AXRc/cSEF4NsLAiGgvprYsoIF1rOaFzwY4F0cmySdd10VW
   ySjo/uqgPnG7dKu1RMM+b3ubffCgvdUyHCCZwiUEeccZinHlnNTN4mQ7t
   g==;
X-CSE-ConnectionGUID: F9/q9wFVRSWKsa4YZv/KYQ==
X-CSE-MsgGUID: /ZUGVLlLR1ijpaM/iGf1oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11477849"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="11477849"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 18:54:02 -0700
X-CSE-ConnectionGUID: yJTFJBqrT/2ekW/s6M9H7Q==
X-CSE-MsgGUID: M+PCckkeQvqAQER9SmJdPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="30355474"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 18:54:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 18:54:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 18:54:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 18:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXpdk0deBhHDsgqLdlikNybpoq9ewp6qjLu+LW4A/qdekPZo3wNqXx3WFJNR7PjqH2P2ci8MVZ6KGmvo/TERa3xelUaG1DMMw9TNojnhilYO60ucqVtzqm+0zU6ASO3bjYvhNxrdAMK0z17R3Xu4fGwMtoWioTn0dt2ylbZ6ekN4y/n1sra/WI+puLMFD+NiQFplR1Q3Dt7oplLb1f/XGJl7vWcqxZ/tkSAha2WEejo1CO4L6cBpYO5wqkCr/G4e/B5e45a2071rSTR9NdAszZCHXtK2xCycVV0KHZ6EcfHs/CK55Qbzyo7+P489JDB1q8KMlP+vlzz20RjnvmIOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uisrQd8By2W1VxCUCyKpuMVa0n6mTqE4LJefoab0B/Q=;
 b=kwvXYijgn/BrX8/Xh2OpT44kO18iI3tG7dBywW/Z3xW5tVmrHwgnnrALl7hrAw4fb/2lwtqtY+OCE1MfoesuI3Lb/4C/pdTndJhEBUTEF14syHDwVEMVyvllJNQzGgVqUSzYmuNsZVy3qGkWKXHvQt1oRHrIFcA2FmlvPGdTsNnf4qZjVmEC2U82bT/cyXnakeTY90o6nckw4L3UfzQ+zSDqaikA/XjDP/k5yKq9noY8sqrH9y6VKhdrUpYgh7fq2gtlNtOrvSDvaZ56bEtVxburFDwVrY9ACvXVP+wpbPw5UYYR0H/albN6kK9eHcdTLyfize/j8s3vlNJWrt0Z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB7075.namprd11.prod.outlook.com (2603:10b6:510:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Sat, 11 May
 2024 01:53:59 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 01:53:59 +0000
Date: Sat, 11 May 2024 09:53:47 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 11/25] KVM: x86: Add kvm_is_fred_enabled()
Message-ID: <Zj7Pq2fnU+YcNu0x@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-12-xin3.li@intel.com>
 <Zi9ZSuwQXl8/Ncs/@chao-email>
 <SA1PR11MB6734D9EF8C2D9A762CBEBF07A8E02@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734D9EF8C2D9A762CBEBF07A8E02@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f3a90d-1202-4114-7a4f-08dc715d3964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?26WOz9st38s8NEeF/BzRXfDrM4WGMfO03TIq3ZYVZuNm1hwT1l/r/Nr7mHqF?=
 =?us-ascii?Q?wYlXM0dMUkh3jFjjbDaSeMLUOLG7U8vWN6Nf5HtGC3be8G+0ucvq+9G9hhcN?=
 =?us-ascii?Q?322hWaKix6I1ZsVYS740XEeknhuPmbJzispQJKnegVWQZw+jq69RWuvzWKmv?=
 =?us-ascii?Q?GAboEv8EDAQBipGc28g1keprV8XMfcfhBEY0+OpYMq8aLgnWXqC7vb2GAGi0?=
 =?us-ascii?Q?hK9L+DqX5HrNXZdwrpl6VRx4B/jPi8xgDNy6Xns1q5xoHk332UqHkXgJjSCy?=
 =?us-ascii?Q?1bePUJOiF+ICYNhQISOJXZj9XSLy6c/DMVS4QHv3m+1g9bgtUeBMcqqqT8Nz?=
 =?us-ascii?Q?084SRvhe157giQAXzGDHdBumDmBy5xiwXRPussHUrdpVXLTdsNPiqBD/fDr3?=
 =?us-ascii?Q?m/qXKtmOcQmnCa3QDch55BwW1QE2x7TBAmgv1NKS78vvevklaa81ot5h/kS0?=
 =?us-ascii?Q?VxJ8J/G7kSyaH7TrtZ9h/SV480eMyJsXdmlZ6gykfdwQjd7nmTm+qZdWP6ww?=
 =?us-ascii?Q?A5Ii5k4y/3REuH06IdczTas1Y/NTek2+AIBWAwSbyKecXKdVWeUjIP4pYDmH?=
 =?us-ascii?Q?njGeDvROAetVC8OFP4uslTlXFBPrH42AgSerA2xIjp7jUnaS8DGDRSShNL1V?=
 =?us-ascii?Q?dHzRyPAb9XYTH9FClFA7marNYwKLZql5iI684CQPtthYlaidTBwzTI+bCsSY?=
 =?us-ascii?Q?nAY3A9Fa641LBWIovRf3dSfwHINRHGnHEw0nUFNwjrft8nXZ10CxcBr9dGcZ?=
 =?us-ascii?Q?Pm/NOJFfRg0DSHTKpH7fv5fa0/OZnGyoJC1OKC7LR7bXej7UA9EsnLBuJpUG?=
 =?us-ascii?Q?d9FU2ngluNi1M9gIoiWWGgjWPCg62X7+Gif3xYrktCZjvPMNpdKqG3yH7CLe?=
 =?us-ascii?Q?vSTqBH5D4IXp9+LVByfE0kjNxIp3TE4X3Nr5EFLTdFJ9GddVU/Lfhs/UuonZ?=
 =?us-ascii?Q?6E7j8/gqArpLAM1AE2AduQTkkNPVWnrildhMUH99Ut/K74ZmHAA7UgN0WJm6?=
 =?us-ascii?Q?RMTacbRumge/iUHDh4vZy8rOAgTfbC29LTT9j3Tfre736TqBoxw7JOMK7Qio?=
 =?us-ascii?Q?DLXKmsjf3eFNICjGCOPTZMF0sYW3Cwa7aFFVoscWMKBAkRy6W0ZGezaRVlow?=
 =?us-ascii?Q?tpPYNH08N8KFgBIDueY2aE5PQK10bDOcNFvIxbODR1ctjapnY99joYvqfg73?=
 =?us-ascii?Q?mZIc5jraN2+NXZGqw4f8DTNnTb89LSAXQdKaQSkzFvugk5WdoAQkhgktSVCs?=
 =?us-ascii?Q?DTVkASSodPI+hsWbqETu+rhpoKS+WwfcHbrJfy6Vyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vLJh8wakBp7RN38sDT2DrbdDacjxL2UCmznyu2huLxh0jO5a5qHFyVfJrvu?=
 =?us-ascii?Q?bf8fBL/gUA/ufaB/urXon3GZx1YbkPb/IZ0dl4ob4sdUNgBU28g3V7raf29u?=
 =?us-ascii?Q?F+xM0h7ECXfprNs4XyINsBkyAH5ChdJmzGQ3tkZNiQXxnztRHvfmB13coW0q?=
 =?us-ascii?Q?9r8P/JZchk6wgiPdDwFGF5cNJWXZiDVmrLEFpFxaNFED2X6uGbjK20KFTemy?=
 =?us-ascii?Q?4bAKh/KrNPSEoWesQP53TOzfGbqfV81EeqKmEAiV34fOwKoJxDZE5uud2ZJX?=
 =?us-ascii?Q?rqGSJpD8pMW6cSQg5Xs09/57KUer/07xcOU5KMCYXASRx72TW9QX4CCCR8Ne?=
 =?us-ascii?Q?vixCbj3v/nux+KsKo5A+lMjTHOPFJgNawhbQzw3rTEGA1XBrO1W8/zH7wdg1?=
 =?us-ascii?Q?gcwuVm9tz3WVfhvU0xLwyGVKzwd3q0a55tBxYfYhczMzN2tBHm+9Z+pq4yxl?=
 =?us-ascii?Q?ofWSus0naYyYph7EGJDWN7szFTJW4Gy9q53HqFJdCIa5LgKTNaq/9mh0cy7p?=
 =?us-ascii?Q?01rRUVjT0FlslDQ2VwonnHY4nfKoEdZ2Mt4IIlG3tpPXp7RMS5CzXAwbMnL1?=
 =?us-ascii?Q?XEiwYtYw3aLlJ3Ye1Mbi+Gw+srYPE7cmEOIaPT+RigT1Q7PZTOAUsUrma7A4?=
 =?us-ascii?Q?WYV9bqzosxTHM+Thg6+h9EJvCjA6/q33O/tt24EbUtyAZhODXakMrmV1HkgV?=
 =?us-ascii?Q?tsZ1UDasyR6cXNozfG26Kg+NZ4qvrPiMZ8RtIALtlYdWtVQKOLd++k1U2jJL?=
 =?us-ascii?Q?mXx9g7OoyVDL4qApuLYC/RS3hyl+rI83eiAqMv2gelATbu5Qlluyr/qx7ax4?=
 =?us-ascii?Q?RZCrlofPzebZBa0ckWZFAevTW9ioL7rJhvkaA1xd5CeX5o3Ql20W6VTUCw/G?=
 =?us-ascii?Q?/odC9EdvWilOezyKzomQjJGqi1qQqMzv8GiQ5CRpo4/Y5SvFzntdVNBDd/fF?=
 =?us-ascii?Q?xrGQCLaa5zdHhzOLmFD7HK5asdJp67/C/4mUgJEdLJQKD9zfyObXcpDSmYC5?=
 =?us-ascii?Q?BOZEOGBBnM8VfV2VwlDd9p846NiMlKa6sN28l+B1JQG0Uwmf+QZs18WMM8dl?=
 =?us-ascii?Q?pI5qUUlh3axjswlRvmUXPc0rj/Bn9Oz9EaRhNkD+uOQrQglJXUhLj+FByKzN?=
 =?us-ascii?Q?Vb0RDzPOKSCVpJOTxuMC0/xwbJXlrfgA3YFog7QDdVCRp2IHoKJkzIvzc6I8?=
 =?us-ascii?Q?/6pL3u0aN6CxGgK6PAqZ46Nj0AratSB0NN78NKQ7xBeZus7HmQ7AGWxs53jI?=
 =?us-ascii?Q?DvYaJhaz44SeBqeJkW8kTe3lcduYCQ5sUl/Ui+0ZXYcqUHEM2X64Mse3qEl7?=
 =?us-ascii?Q?vHLtg9FNYOCzyhc+8PV0rb9VaGDoF2yAfX6QRbUuE4i06OrtD8kBs9j/lWRK?=
 =?us-ascii?Q?5ORtwW08funRL5H1vZlXGzyIxTTVSWdri+XNQYLJ2u/mQuRZczjwIULn0F5n?=
 =?us-ascii?Q?micBz7oRSi89qpjxYhEJ8QPBsTjvyESfezAtWgigW7yyzL5GI0sr0O4Nzm0D?=
 =?us-ascii?Q?WshIuLF9gj+GDU4/s1ZgFt3YuLt0qNQv7Tv/0+nLIN5kpBpMu/AwIIp4K6L5?=
 =?us-ascii?Q?oScIW22BE9LVzXCLfgLU0L8UT1MgiaSVlIJW7pSE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f3a90d-1202-4114-7a4f-08dc715d3964
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 01:53:59.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqnPq9f+WRd2mc1LHm2aAthbEg+fauJYVqJ5XSDRFjh1cxaCItVJPDebySSJJsX8OiVfMpKjtfAukNHAe5b9Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
X-OriginatorOrg: intel.com

On Sat, May 11, 2024 at 09:24:12AM +0800, Li, Xin3 wrote:
>> >+/*
>> >+ * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
>> >+ * a vCPU is running with FRED enabled, because:
>> >+ * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
>> >+ * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
>> >+ *
>> >+ * More details at FRED Spec 6.0 Section 4.2 Enabling in CR4.
>> >+ */
>> 
>> I think we can give more context here, e.g.,
>> 
>> Although FRED architecture applies to 64-bit mode only, there is no need to check if
>> the CPU is in 64-bit mode (i.e., IA32_EFER.LMA and CS.L) to tell if FRED is enabled
>> because CR4.FRED=1 implies the CPU is in 64-bit mode.
>
>What is "more context" here?

e.g.,
why IA32_EFER.LMA and CPU mode are related to FRED here?

"it's enough to " implies something else is not necessary. what is it?

I don't think the original comment make them super clear.

>
>> Specifically,
>
>

