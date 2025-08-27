Return-Path: <linux-kselftest+bounces-40023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE20B37715
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 03:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14C61BA0F67
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70337212B0A;
	Wed, 27 Aug 2025 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hk3ScTe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAA20C00E;
	Wed, 27 Aug 2025 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258626; cv=fail; b=SAXm4EYRxXulsAhJWqYZWfsdl+ipJuCnJlLopjhufykjsFNDBuoYSl0wU5QcpXvJ/K6sj48GpKeqCwnLDLCDGLWrQIPCbwcMFr+tNXmDFwUWC6ZnxmzkROKvFpwbClShd8u88ZxbqSYtfE1kKtPXXcnSGSMG5GmKg7qqt8G2x6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258626; c=relaxed/simple;
	bh=eRDVH+isWMA4S+g48p+OWeFUQxM5geQy3P+94F8AJ4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZKjELHGc6DgUEplryNSvF35o+GlqVuF9s9PwPGKCV9ugoufHt13nxIq3gAsmFi200gVDYCqRtvoN3urJMH+7UpOXvI+GpFs8L4r43Xu5r4gSaM1GDhaX0S25jDxNmFU+F2MI+O25dmmgzVUahh0Pe0tZe5Gh7oZrEkJEIjLKwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hk3ScTe6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756258624; x=1787794624;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=eRDVH+isWMA4S+g48p+OWeFUQxM5geQy3P+94F8AJ4k=;
  b=hk3ScTe6+D8ZE3zjsF6BESekTlM0MXIWUp2Apb4pDOuEXy9eASJMEBeb
   6S42ypbAMbk3ULk1LSb9iucIx9G7htSvDX1MghAoPmIPNJLFUzM3Sc5lY
   18DbSZVnkfQD5szlms25h6W2+MIawNZSroc60113pB5GL08hSBhS/r/sd
   JCxmRIvrezdhz2js+AlysL5NrHq3bCXAYI/jlqGdZBI/dWWblF+ZSElnZ
   hNfNBTVZMCZAX9X/S0hKG3EZ3cCXgwBGzTyFeoGKaD3Mp9KV4R4MdLV2s
   r+8vSWLRB1Xal3qhaSU/dq6MZ4YyUYostQic1AhobVLgQjYGUMxKqeIVu
   Q==;
X-CSE-ConnectionGUID: e0F7sM86TAmNetftKm+ieA==
X-CSE-MsgGUID: Xu9ZOaGYR7CiYB8MT/A3UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61143459"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61143459"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 18:37:03 -0700
X-CSE-ConnectionGUID: +SCTxSdRRtutEJKrnEtJQg==
X-CSE-MsgGUID: GaLMQ+UGSY2lKWIRDComag==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 18:37:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 18:37:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 18:37:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 18:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbCHyv6uF82c5uGylDEIdA+vQHQUFsU0tKGkXDQoayiuHiIY6B1Ky1I7t7HTApdLWTHrqrrhz2ylrDbcRYheXLg0hsWui/1cDcppFAFBFlnV+kTzFulLUndVKuNIUKGsiojzAKsRgpRsJu6hc7SXD9rP3AIgakVl6S/bp2Lw4FKWcBBXcqfPFrnbJVXbPJjIldygP0NGUbI6a4ow40/SjSreFEgIbxd+K0tgJHW2XYMdk6vNyDxyE8nlATVwHJyq+SCCxVfyIttJuW/gSNJ8qR1PkyWiPHpWLQ8IkOr0rWiRDDWlaXrp27PsVVGaj1Fm2n2+WM2HT8MGMmQbFje5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riDGbDK/mGO1NiNxYWhLWe+RzLtBZt83HLu/CeLvDUM=;
 b=P7iyYt/+51hQo6spLb2liJhH+YRCKnh9saYCMy3N1KsZ71+ujCPRQjDecORAyCqRn62socwcNk52IUr+X8mRnglSxEGekM6iHlWfZeaDwDDNY32TMTRCdQYD8IyTLbCyNufvx8xAResEqxqZt/qzaxIKO6MF3ldBrEd+ichI1uZqP8ESlyqCo7R0LFwfwUK3558NR5H1rOYOmmJyAZGfFCdD2mYhXCGI6DFuXz6apTl2TWDQoECu9BBkFRNKkSJX8EoylMPhi3Zs0aSpctqmbSCf8l4JrvGGD3S2yqnFMCDqAQfSkB4U2X+/4GAgVgZoBh//TwZYzTLn1INUygbWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 01:37:00 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%7]) with mapi id 15.20.9052.013; Wed, 27 Aug 2025
 01:36:59 +0000
Date: Wed, 27 Aug 2025 09:36:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, Andrew Jones
	<ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Erdem
 Aktas" <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v9 10/19] KVM: selftests: Set up TDX boot code region
Message-ID: <aK5hCCbIsxRJEUe2@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-11-sagis@google.com>
 <aKv1VNFiOPJZBN/T@yzhao56-desk.sh.intel.com>
 <aK3i910ghgsaIkir@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aK3i910ghgsaIkir@google.com>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|MW5PR11MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: a14918b6-7c8c-4e31-f138-08dde50a3755
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C0kRYhHYvO+polAu8sG7paa+GYMufuHoabszDadx4LPQZs29OCaNVMk21fRQ?=
 =?us-ascii?Q?8V561ZD+MztEDWfuKeHCRhsvonxjFUAn+CCp1tAKzTi+bGstxu4cti7cJWHC?=
 =?us-ascii?Q?+0BRRCbK4G2oXhie26OkgipWtFoZV7YCa97eHJNTqXRtsISgREB41mvzBu0R?=
 =?us-ascii?Q?z6X4l5AN9MKXSdXca21xnxTR8ggzuVkltHLqndw5mVBEmqiseW630QqyJRJd?=
 =?us-ascii?Q?vzWokaGlIBQZbghewq1M6Ozxlb4eR/moGc2U6DXuOBUzcISu3BBVEv+4ZA6k?=
 =?us-ascii?Q?hmeJKlTdtFCR1HbgtOUQWGHNw/qUD774THrH67BhXQwmNat6svNkdTG6kd/G?=
 =?us-ascii?Q?FI/XO7NvGlf74+XSMdHrrpDsuMw0sxfG9002Mp6Ok2Lp9BOsr5MnEGRBlN94?=
 =?us-ascii?Q?5s70gnqlCKVUAGMdd1bLtmoKM8IOh2DL6TUf/F3FekiR5C/d0Lqcj8S4BwsH?=
 =?us-ascii?Q?ANPnuAkyM1uOsyl3PUos+B+tH1VnoJWv+PuqwnSl+SGv1WahU0pzt+aGHohG?=
 =?us-ascii?Q?T/Ha/zerfcFo+3GGxcYfteUPa83TttDlI70b+65VjlGLuYq4eJJyqkWnW/BO?=
 =?us-ascii?Q?cRbTvIVm/1j5T9oN159aGOXUfHPLratniB/qrYC7It8pfAPlO9DWfduBr9mr?=
 =?us-ascii?Q?YHsZmQNmdiXgSbZS3Reo11g0OvPbpljhPJ12z+5/MOVSXJySMaTX7/FTpYS7?=
 =?us-ascii?Q?YBPRe1FYa6I/WJ82MlotKEyK+Z24Bs76yLRZWSDjzDo/gw4pmI7hmeC/03EE?=
 =?us-ascii?Q?i3u8z+vYS+eeNQ9dNiVN0EbiHfptENy9gtKCtLqmi8gWuYYNZ6aSQTLOmhpv?=
 =?us-ascii?Q?L5btQrvnw6lj4vVYaDPBXQyWP26gIDF3dAGLXND7YXOHihWFUniX3fPlaiwt?=
 =?us-ascii?Q?AKhLr/IglOTFjR1Eq2SZaX5SY3GU2KJVlsXuwuskm66Wx4wd4QI+Sx1xIOCf?=
 =?us-ascii?Q?B78eQHqh+Bg6W8w2HdKcwmp7BONuT2+TCFtDRM0mAw4ws4wgkQJsIjb3A64K?=
 =?us-ascii?Q?MX9KrtrzWqaMPVsyk0Ndpab3xNiFLfryUhivo5JosiuJw8OBohKQVuHWHmnE?=
 =?us-ascii?Q?/Geg0JjD08xiLkWfuJgJFlU+0gVCJZ02XAogK8D+xig+Zd5vpC4T8tCLWZhE?=
 =?us-ascii?Q?fzouab2RqUPfnzG7E8j/VvTy+rpN089m0nYwoUmat8uXzzxy7myZVtbX/7Nx?=
 =?us-ascii?Q?w61htO/Vjt8ILwwG0CPJoXBoA8VNYi2MdZCn4TbM7MF88rNAMbLfGjYndRLy?=
 =?us-ascii?Q?BAb7a69vvN8emrS9tqG2KYj95CfqZowshLVtcfXkZLv7iCYNbTbvOGxr45e6?=
 =?us-ascii?Q?IVoIN3/UeBMHjb2WmARnOmX5xhfvaP5h8Na/QCSsO07JNw0A8JlXqsBPDvmO?=
 =?us-ascii?Q?LXFNIRTn4yytR7bocEhmSmqTgjCpiIdDodD3i6JFozmlLLsP+0Cvlkh1TBEM?=
 =?us-ascii?Q?pNWoe0KSwKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qz4hm/ts7ZpNQ+MtdWEuc2g9ioVFEKfB00l888lTMvIwgzF3k3OKy5MB0rAF?=
 =?us-ascii?Q?j5/gZBDJfvK+E+8yd8cY3afbiOTYVkAJGC2NDjeDc6aH7Ma0jtQP7GGkNZF1?=
 =?us-ascii?Q?A/dpckwusyMDvEPGfaEbp60h+46jixBYBIpEJSJv3lGjP4MjwdS9GKeo8yrx?=
 =?us-ascii?Q?8I20VzXMAtpgVjTt5KRg4VLXW4qujbFOOvb1cTzRU+J9GkQpoXPwHAf9pSgM?=
 =?us-ascii?Q?x8qZY9yumsISfzJYdqhepSP4rWHzLmFYIB7nwwdkZyXwe0W2dV8qD55eM2Wl?=
 =?us-ascii?Q?Fnq3rUyqGUiyKCxYofrmstXtLUwNYG0oyA3JDvrTtFdZYAkYkSBYG1Tr2H0I?=
 =?us-ascii?Q?y+nGuc7uvwjKl5b5kEj/EQDJ3dhX/m0G2mYFF5koPy91EW1/PFA8S/tOOUkx?=
 =?us-ascii?Q?ATKnwC5N14U/Ur1jXLX7es2BvQRqFXL5z8G2Q4gUDCXPoaN5oxVkCau0tDuT?=
 =?us-ascii?Q?dsDSBj0ktu2epeoVhGcekW+J/epPZVAZfLRVRM8f7O3SWkzdtlfys7LcrAeh?=
 =?us-ascii?Q?pdsSnIfybsxBwLkXnSHRjB8A/P5az9+Gh2uNAF+GZ3ZbKePRnU/Bw9gyEZLM?=
 =?us-ascii?Q?ngcxMrzG5A71LH3VFu8snJWurIAr7Q6cxRg9ITmke02RazXpLQuHsQPIT+MV?=
 =?us-ascii?Q?9NT5OgZowmUd6UgUUod9wcunQvVzY0Zn5u+A2MBHehhK71U7z91fGlD7sFEK?=
 =?us-ascii?Q?TzWEQOp4/Tu0WQtKBpcmgHNVb9vDDXvW/f/i0ty+Vqz5XK+2wMl/i3dt775s?=
 =?us-ascii?Q?J/hYzJYIbsqJEoRa+9brqNgTsMaCHiRWSiRiQdBcj20LyEKUzQy4YlDAK74n?=
 =?us-ascii?Q?yBWYP93wOQTyjafXcQT2z3rGzyPxFObcNUNPcTqdaAg8fl2TXprOsBrW7qM8?=
 =?us-ascii?Q?s1HFvOHNZwTz1WWY2O4l+eMkRATJiTL3aaKEst9uudFnixRryE14umuYEIUY?=
 =?us-ascii?Q?HuDk55K6P58vAn/fut7qfwZFrI2cwK/Yq6q6Jl9VaOWhweE2CR/RHJJjjNUq?=
 =?us-ascii?Q?wUqSXKzrCXkraqxmNRIoUeG0ZeKHOA11ip7RsSY00/Eb7xXp226yj243qJEX?=
 =?us-ascii?Q?pxi6sAdPllDoDU2LkSNZ8tt2/c0WAdQ4/Dt54T6kzNyKmDboRe+QXdpX5sCN?=
 =?us-ascii?Q?m+4iCnPkULOtTPxxQXu5xGkGubfDy9VpsyhfN5I4a77hrUnIvLnawxlfj2nM?=
 =?us-ascii?Q?RyEQ2gaNWfFQ0IKbH5dNT80uk5CdSZgWQl1KmgKoEFW4neljcu5RF02HYWQ0?=
 =?us-ascii?Q?YWhcsZ7NJWF6SAgjXHH7xS671Q0XnIHWNpumEjvfdCXcDTTJpKIqmrHzMKqn?=
 =?us-ascii?Q?xsXs10yetnM3dC+mPwB6Qb4pGHG456fjrHaq4Ot4I21zrqzo/ZLTA5aCuFwm?=
 =?us-ascii?Q?y/HGwCjXQbyJGiD/Dp9vPGhqjpWQXgOezdiXDBTsOK6wMqrPLDfutwRy+pLF?=
 =?us-ascii?Q?FoHpri/mhebH1ZF13kz0iPgrtmogtbxopWB1E7JqHv7E8JZ00j7msZiBR386?=
 =?us-ascii?Q?xhLY9l4iIE3K2h81R/HY7tBewtEs8khsx+nImDeEk3HDcRWH9Y7djDJZXztW?=
 =?us-ascii?Q?7F9NoDXKS+Z/wWwlP32++NCjz1u8lhBU7O0F/tgn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a14918b6-7c8c-4e31-f138-08dde50a3755
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:36:59.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gS/7jOPNejmMTp6+sZqTWKLokcJPlsQylpYDUmmKL+ciJU9GOCZ2KAYpco3ZbMfgdr1l1aUczWaldlLM56jFjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
X-OriginatorOrg: intel.com

On Tue, Aug 26, 2025 at 09:38:15AM -0700, Sean Christopherson wrote:
> On Mon, Aug 25, 2025, Yan Zhao wrote:
> > > +	/*
> > > +	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
> > > +	 * code, as there are only 16 bytes at the RESET vector before RIP will
> > > +	 * wrap back to zero.  Insert a trailing int3 so that the vCPU crashes
> > > +	 * in case the JMP somehow falls through.  Note!  The target address is
> > > +	 * relative to the end of the instruction!
> > > +	 */
> > > +	TEST_ASSERT(TD_BOOT_CODE_SIZE < 256,
> > Looks TD_BOOT_CODE_SIZE needs to be <= 126, as the jump range is limited to -128
> > to +127 for JMP rel8.
> 
> Gah, I managed to forget that relative targets obviously need to be signed values,
> and I also forgot to account for the size of the JMP in the assert.  Go me.
> 
> Maybe express this as:
> 
> 	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 < 128,
> 		    "TD boot code not addressable by 'JMP rel8'");
I like this version, which's is much clearer than asserting TD_BOOT_CODE_SIZE
alone.

nit: TD_BOOT_CODE_SIZE + 2 can be equal to 128, i.e.,

	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 <= 128,
		    "TD boot code not addressable by 'JMP rel8'");


> > > +		    "TD boot code not addressable by 'JMP rel8'");
> > > +	hva[0] = 0xeb;
> > > +	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
> 
> I think I lucked into getting this right though?
Yes, this one is correct :)


> > > +	hva[2] = 0xcc;
> > > +}
> > > -- 
> > > 2.51.0.rc1.193.gad69d77794-goog
> > > 
> > > 

