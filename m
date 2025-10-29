Return-Path: <linux-kselftest+bounces-44299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D772BC1BDED
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37BB66048A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7B2ED154;
	Wed, 29 Oct 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BATLnvFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374C2EC0B6;
	Wed, 29 Oct 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751242; cv=fail; b=hHNuEz/N7Sd286iZag943fFPmvPby966UgmPyeHs5JuxkXay4hi5f1EkDpMhfdg0Jnnw4w+7V/P04GuTt/ARsxCpeIZfTtkb7wfIjxR7GAoQNKOBpiYggVLeGMTg7rLlMq5kVcrOAgxjsuFsAQnP6mjKOjyWiw0Br+Juk/hkbhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751242; c=relaxed/simple;
	bh=1XSaovdaV9xo63BfqSb2B5W6C9OsUSdItA0/uy1UQhQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bE5Oif84GfEnhqs8wmVZK+Pk0JJKuWDDuhBKIuKah6p9hifk/9A9EG6LCcxVWrnlcb4ABCXSbpSWVfKcvFtEQhlAqP06QylozPHfoxP8joUFVQ8kHaWoGm8urAFsgR9I97Hhr7bve8H/6UKG4Z9iPI+tg6KUyxl+RxcQGIwqK/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BATLnvFj; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761751241; x=1793287241;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1XSaovdaV9xo63BfqSb2B5W6C9OsUSdItA0/uy1UQhQ=;
  b=BATLnvFjB38VxuETwluk8fE0IdJXrc4cBUOU1LeWcWlZk9Ut9iO5lxdn
   jilV1Eb+2UiHpriJOjJjVkBf1m47/jRYCLanV2SnEGNY1d+o/T0i69KQR
   r7Zxk+UKfPaJ3cbV52QHXD3Mep8azP8IdFflc3NtuSgVTS5fWu6bpcM0P
   hdmxk6xCXRu8h9WLnuRsVan9zxgB6it3f7c3BRV71mc2HWDQ/wqQHXZJv
   Y0wBUkd6qkMWlwLn/Ic9Jjp2QvLkG+8W6BOyUz+scvMb4WvRvxk5lDk5a
   UqD+N7XhRaixSff3008kFjD83GWiZOw/7dzo+F9e1N78XjrVbwlfyPCvy
   w==;
X-CSE-ConnectionGUID: qXrLpwp1QPq/AvtlcngWlw==
X-CSE-MsgGUID: Shr1ZIXqTj2/F9OR9ug5FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74475309"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74475309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:20:41 -0700
X-CSE-ConnectionGUID: 1tNtBHXKScyHFSXqV/Q4MA==
X-CSE-MsgGUID: JgFdJnsiRpKt9VQFyUVK2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185333512"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:20:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:20:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:20:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.58)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI1hGVEjJmERrDDxufpinqg4/eFvuxscBSPt8P0D0aX2Fj3Y7YhGKAhpSSFRJ8VUGJqwsicx21//NwwjTR6aW4MyD2jKLuKhIrvEQ1yxut0ie1kLkM0n7EvXauNHv08F38HQMTVRY7eSrNBP2EgpAw8/BnROr+wkTvKFiNzniQk5xnwDnVU5BDoeU/7Yfz7VIHKwAfOfwsMml1T8oEEvmVth0W8BxOD7M2EPLnYNAGbL+HsTEg4BIklGZk53ZOyR6B8LVjhGChLB/kNzNt2ZOik9TnJclpuE4o6RggKxZoZupQsXRfOknhKNWV4ZO0qO74CW1KoZqUOcmKpipkrarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCmuDQsWDbIytniE10R43xlVRusCgHq86tRKsGY4rUA=;
 b=y4/5TeJwaWDfV+xZrm6JiqyxLlRRwVZGRTa7uc/P3tqsL4haAD2aNXoeo9MSbTnbWdtn3NtOKkYLfzWZUUyY6WlWCbEVK7z6oKkJT1GSRu5l7t3GHI3WvbRBVXYasJYsUtFPh5Gp4OYc2C6HU8aU4NK4VfNp5RDGG9e0S8+uXVkpTEUXgS1XUyf0jFiVe+XeYxw38XbzPRXyt81V58hR9vMdxo9/lQhmt9CttwoGraGNaDEb7uOmx7kRHNv6tmDJMoxa+1A0E9pJi8aQjpobriRnqeRegsfxySx1CCeQ0325WbpEQ/TxowO6GzclGzwOuvo8MbuZaH34lhCrk0M0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SN7PR11MB7510.namprd11.prod.outlook.com
 (2603:10b6:806:349::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 15:20:32 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 15:20:32 +0000
Date: Wed, 29 Oct 2025 10:22:50 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>
Subject: Re: [PATCH v12 05/23] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
Message-ID: <6902314aac689_20bb411007b@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-6-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-6-sagis@google.com>
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SN7PR11MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cba0ff-cfb9-4955-fbfa-08de16feb32d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqDuSBck+0nd/rpliNnWPei0ujgiWS1WW0nbMPK2RLnJ6VJKy9kDv2Thmi5J?=
 =?us-ascii?Q?4nG5bi2dkjGnO1uXvgRf7VXPi0vsCqvPHzmigCiiBMqITnSy8b1M5I12TZ5B?=
 =?us-ascii?Q?yGA9X4tdAmwFfVdwmnjFu+cOACOjjE45VrBMxFy56GWnrtV+9IpL+FsiVjN9?=
 =?us-ascii?Q?6I8wNUbzIpbxwtoynWRpABI0iGPS7NytCMjwWDH02QfIIFYpzeugsdew9YCn?=
 =?us-ascii?Q?TWH8/1JID6YG8U/YMPITXOTj63RONIC2ywMPvo3WT0NIgsTeZ5UvX6rVgjYG?=
 =?us-ascii?Q?jyNuKFfQnm3Qlnh0LS/awpGFMFbS1vAEzRUtVqub+EmR2UyFrJ0tk0DpnZ9n?=
 =?us-ascii?Q?0dDJoNmhsxqYmY11jB7W/0L8m28qScvcciy0gdf/UjNRrXAagJaB2CaJc7vF?=
 =?us-ascii?Q?h8+WSG/3LLswLjaHhV6y4S+grW96+rmWA8wY5uyfy9Gmnr3o00OWFncrxvmF?=
 =?us-ascii?Q?211KQOq8aZFS6mfnTTzGkz4QvH4bOAxOoQGg08dtj924KBePDEanNHrjGOHw?=
 =?us-ascii?Q?ZoMk5SeJoHoJwcyZRnPGTY6g/u/6vTXWCFkzrEJLZlxfcAryyd5iIyDN3/dC?=
 =?us-ascii?Q?2zL3jUlKFAmKVR2Vwuz3sfljo3sZbHDCsjcaXRQtkz+NSBPvPgbaWsxN05bH?=
 =?us-ascii?Q?UHAgPAB/M6y31OUsznFYcNX5TUGGH3b790/dkCP8jzwz6XzbW4huoRU0pKEo?=
 =?us-ascii?Q?ED1hGrvolOBC+v8ugF9X36QtqhmheHSq9R6v1YUSXCOKbBAwM30+5LgJWzUu?=
 =?us-ascii?Q?jYBqjdutU96r6dcSujIXTkrQk9aQZdmz1s/ickd0KGH0FLZqIxcJWCY93sf5?=
 =?us-ascii?Q?LfKUVPylGHhNhaiw45TyCVBUTJx5XGhAHLVClrqyhZm73jbb5k0QvjU9YTJA?=
 =?us-ascii?Q?HQQQpQIOuLI+QMFhyNnomz3jU0Ar8nYbexwQdVdUjd3rNqVaWvgDraV0zk4t?=
 =?us-ascii?Q?H/Wx+4VDOoioZg17MFCzwueWYalj0C5V3F6ZsHnvGqIZMdhhGizC+tC/ipUs?=
 =?us-ascii?Q?TATCzFsVtGW3WVVXdPXnJgCmBWSChf0Fq07mzfOPVOfYskiq+gyZOI8OeAZ1?=
 =?us-ascii?Q?oTOsHviEyVCzkeQm5JtlmV6JpXkDPeyPsBpUJ/kIyr1cF5uYatl8j2Wbt53c?=
 =?us-ascii?Q?sjf+dFKeW//kSjg+S3J+vfZ2b79lAiVnu1btLClhrARW9lhgmcNEeB8Q5eeQ?=
 =?us-ascii?Q?fV5JLZ7681803Xgbk4eijIJjNyGeiTud8PEVPYad5B8GLqR8nc081W83UX79?=
 =?us-ascii?Q?0dGxE4HGVs6fGI9i1SOaS4jy8bkn9J7MzfWTMP47ML2QfqYdWSUlcLa8cF76?=
 =?us-ascii?Q?dflkaGyi3dMyRor5ElxVn4LpbYYBjWBuKKELDFX4JOVlZBj8weJPe2+bLuVT?=
 =?us-ascii?Q?hh+6BoshLQ6jFRZ+SbQyYoDU+RSnt2iZkKoWd35tWzFsQ64znGXOsBrqVKT6?=
 =?us-ascii?Q?DhnVxKQIdy1BT/K3XVcyM7LvyDg5FKRvtbBnf/QqrtI0yG+gKCxTtD4OMRzi?=
 =?us-ascii?Q?a0ogKwcsmvsghWs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kN5JHQuLV6H93QiQ8a3FpDgwkwcei/USe827JVX/mcM6k13Qb41EjD+TicY9?=
 =?us-ascii?Q?hUlqHHIBlc2sBcT0SZq7d8H+9/CCZbSKITgaggsKpw9560EaRMMRp9pFx0GW?=
 =?us-ascii?Q?+n8TSqzD5nRIJ215BhVdVB0AW4usqNFZRlinKXdFqDlnJzyl4SbH2HBYJiwi?=
 =?us-ascii?Q?ic1POp1rXPAaG419zLG47UZ0Kwjd2thMP+4/YMqrSG5AzgyxLu3xiG6dqYdL?=
 =?us-ascii?Q?2MQbCul0OU/JjNNJnrmznRkjeiWGhdAgGWtCx4v+2KyjGQzaiNFGbuFdVccd?=
 =?us-ascii?Q?ksBB+oavhKWIzP3FV3SOqouO04x0ump3pfHYGp8zE5poVg3Tq34tNhDkNHr+?=
 =?us-ascii?Q?FAGZQXDIgtsZMkMtZf8VCg/oismmaJ38cZe1C84mmBWR+sNdqaNyTRo6W14Q?=
 =?us-ascii?Q?10/+XNyxJKL5O/o1gBbmfrUd2OERToTXhQaKY5RbviVo53Cxky+r9R8dgQ0H?=
 =?us-ascii?Q?UxhKcO7my03mDl8LuAWSjUZ1JUAzKgLjDdel/ysUP0s5ox93lTUaCOp8yb/y?=
 =?us-ascii?Q?OYLnbusPH7QUWm/c1yZAcewlmDa8VdekwuaeUkFj1ME2dJcPr0/O1LpWn6mQ?=
 =?us-ascii?Q?zvQXjxHzbYghRaq/KMxqipMaaYnUxQz7uoJL6xwECsnOztzbGlLHaUzmJZet?=
 =?us-ascii?Q?3Pe/jI12F+ngjkyq6b/cVDI1oKW99R9DyPw7eGl5aMOcodGRWtxP1nOJ6p3q?=
 =?us-ascii?Q?gumETqxBHsYZFy4wb5c4gwJUQ7sYsXxJHHZP0kDSegNJA4/4BXcqPGFqXE2D?=
 =?us-ascii?Q?pcrl0RzqmGxex4dwt8N7HNjmYaZgDGjP1siLlAq8lYuqAznvFGhl7JouPAQX?=
 =?us-ascii?Q?786yeAWYY++KYweockes8HGAScJblD7CdNHExRCWtO15NT+yYNPuFStDoTlo?=
 =?us-ascii?Q?YcnXFd83QKoPRJh/EcjQrf8hazV+tXMzlPGLc20RH2yZyHfSbVVRv9uc2Mds?=
 =?us-ascii?Q?3SkoaOUUDZLZbpzIZ6+CMsfjkRx2BRTcLoV+DAp5dSQoQTwM3h40uujuy1P4?=
 =?us-ascii?Q?2d1+vJVuqmOFN3iVIgMjugUNJurwmo7EOn+ldC3aqXaTp/NuX3BEHbkZ8YJC?=
 =?us-ascii?Q?X55HlZxZWKvOL5HZ/NJYOpfanvAINNUK9SVNukAchluQjojEk/Eck5D77Lc7?=
 =?us-ascii?Q?YZanvBqlYYx/fGUmORaThzOzNx+oLxvFCo0PVJ/6Q4DZzdtyJlrVckk8Fwe0?=
 =?us-ascii?Q?w6LJCdeLJdWUtC8Bcqu/LoMofZNAWRN4HG0thaDRpEZL+RJfhSjCHfKVvM3K?=
 =?us-ascii?Q?7yEKtcj0d3i0rtBaoNUWj+nxTcWfsERIQewdoXOQgKkwVkllOBxDeVMYLsST?=
 =?us-ascii?Q?AwJQ5NYoHkuYzq1Gru9qHl7kG24fem0EIymOvRN5Ly2PuH7iL8+UzSEX7xSu?=
 =?us-ascii?Q?dj/hx+2OGfSEBxNH8SRp83UuW8RoXC0usTfagJirBH1mkoIIyxbjj2FoVpB5?=
 =?us-ascii?Q?lkOn6qxPXOHOTIIA5V9pilt9XEx2z5KWieV71/pfcxpmG8U4kNaCtfgZB/pu?=
 =?us-ascii?Q?V07w43hd0+/PTv550Vgtmj8Ls/nCrQZSBxNJ73gbIBtsVh0Q7tW2eikuQ8o/?=
 =?us-ascii?Q?sKJggrhrhQUrx7r1B8SsXbVSSdbvUO7Ai5syp3Ao?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cba0ff-cfb9-4955-fbfa-08de16feb32d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:20:31.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5t8qzBayeF1QsCXi06roHx0pbYisFK7+KBeXjcI+GDKbgVlbFnn8PeR5My2OY7YdBKxTdL9D18uoC8YDphZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
> similar to SEV.
> 
> TDX sets the shared bit based on the guest physical address width and
> currently supports 48 and 52 widths.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

