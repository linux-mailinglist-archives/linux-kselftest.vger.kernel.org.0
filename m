Return-Path: <linux-kselftest+bounces-5966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F410872C87
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 03:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E107B20CC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CCB79E4;
	Wed,  6 Mar 2024 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euQ/Rn25"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D536FAD;
	Wed,  6 Mar 2024 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690830; cv=fail; b=LkyCJYO9lAh954HgQ5/VxEZPowOwNkM7TAXV69Cy+PCtRstLqqf85+2Hebie63nv2VinlhLM2QdFw51BI95KLinsNxATeu+WenrbunYSEpWBeuJXhIHq+yuvWI/0koPoUEzj0Rz0OMG0XxMYlpuUQphFP6KK+CfgdIv7XOoFzGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690830; c=relaxed/simple;
	bh=jurkydWJDNRJEaV8QAdK5w52CXO6ew0FWF4rF/4wQNs=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n1FrkzEPOtNCJNXWksRt24DYmLj4F9xIcvMP2BTlnMfZg5aBGz4JGGcMb74vgWe4xJ4QU/8YUeHpLTg+U8ru3xBKdyDv5h1fCoPDjfL9IburgApICBE8oEdgKkBkrDyBLVm9qnUMuKEHn0JmUpPXE5Bq0pXVWb5dxH3oNTJWW7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=euQ/Rn25; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709690828; x=1741226828;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=jurkydWJDNRJEaV8QAdK5w52CXO6ew0FWF4rF/4wQNs=;
  b=euQ/Rn25DatgjZ7DBZ7niHpmgZGo+gKvUnHCysWS44yuSz6jxpoqsWl8
   QMBxnx4gKzSWJY5/RkWtMz0R6LtH65jRg+Lvpwfltv9TclcrT+fw1V07Z
   WZQ0WT16NkJeZfuoxn7UcV4pnrMZt6nUXN0H50dEZgLW9g0FWXRuGZ6gq
   AHNtsxsAHFsD/phAx8llTRDL0oLS6oNahGOp9rkv6IVgh2wmM+UVy0kSQ
   S6qbIsO4j9QvyqS5lW26Qx1rrpAUy8MOkJEdcLBJZu4qXDvWfAjfVfZXD
   KCc0Q8QYS1UNugOri0zoMnE4XE6jemDNM1ga/Sc7pei8cJttseKeKJ+ks
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14999390"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14999390"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:07:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9557126"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 18:06:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 18:06:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 18:06:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 18:06:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDz7+s4eeo24+1gb6C++fE84ECARknLs+BHiuRjBcUyXCa8kO3JjgqQZlkADJb189Wn2y88XiqoUAhKs6xR2wrtq4VnQfa2xa+1I1BpXWKzlsMcbOTDtcZ4Zh82gsKDQQ9uNk41Ttk89rAAB37+dTg5wcfy8sllrCFHESUflMCTWuwjvph+pvsqZjTWpGvGU1BEostEgs7RdPUeaODTAA3C3U7NyITdGnuczgoYzGCn5ctCgT10urU8kWJQmUiOh4knUPR/1NnsAoyNK9f+H8A0INo7v2kQPPdClDCqHXU0UA8qV2iiMQc+n7fZBL+MLIXDZyoiEeAc/Fh7abGb4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxdIn5Yhexv7+RqWhNKB862T2o/5rwe/U/eTT04EUwk=;
 b=cpkOUGW9rxxUnZQbt07qqHKnEhntwPiQ/uhdE7G9ufMwfMN1r2AzXUyzy2PIurPEdTT2+F1b8smWdugzobhaZh6qdQZEC5ixav6m93z9e/uXa2jRoAsLSF80YgTfcKjnSOoRUWEyshUuegleFwJnCwbC5HbNaFvo/3r94FioZxmxFad4hljUGSZFep+tpKbolBUA8bpU//tDS8B0Z1UR/KChkOyI2RVzwExcuMRCZfTCuq3mdn/MXtETM8rPziWFtDVbulssyxRIDeDDS42a5VNnlR9NWatH8aC3E4XNcJO9qMUsWa6+ktIDwdFDKOcE0V5AZ5R3OsN0oFJehjWYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 02:06:19 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 02:06:19 +0000
Date: Wed, 6 Mar 2024 09:36:27 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Erdem Aktas <erdemaktas@google.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Gonda
	<pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, Chao Peng
	<chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>,
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>,
	<jmattson@google.com>, <dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 23/29] KVM: selftests: TDX: Add shared memory test
Message-ID: <ZefIm+plPAzUww51@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-24-sagis@google.com>
 <ZeHD44xpj75ixcUr@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZeHD44xpj75ixcUr@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaac369-e526-4ec7-b32d-08dc3d820372
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JBSUg/RrHJLlfsY82GPUne1KmR8zL1wx8r/7o3dUMHWLdnSjRSYKBOkj9qR4e3GXMUdcrECI1bRuFP/624ozOj3sxjxLiiGdVlhFA+q0W4BOK+uic8/LN49eqGUITnCCbDEZp04jEDFlK+kxBQ9r4QY+qDGanZ2Yd6hIuCiVFXN0kmfGuZmlCfYL7ZCYs9zwWKjB81XwNhXCxUbJ94wxzZnMOvr4XUtVyEWXRdWTTPyv+fQbwXu4AiHFkDbrj/dhhynSHiawQ8aychEg+BHM/4szITscAAsRtGMBX5Hj6RCgyqFF8EigAL2vTWnL0MMKwli/H/yw7iNjRy5+uIkRo9jFr3u9t9BmGiWxY+sYuOwrQfghkkOIAFTdsul/AocByYHshJfCbi5IQN+ewYXdWjNaczPR8LbAaPqnvMUvluSC4XsK9+/vnfqO3LCSFpts/L4jt1nD0/y6Gz0l/Ildae8oPtaGnPi7Tb9dkshe1YUlmFyk4N0iqx5bH1f345lt1g7r1PJ/RYMT+a4yvxfiobs3M9I4GM7B15YcAmbHKwqD9N7ZTcw40DLMn0Dcy59pW7unjuizO4oXZGdSiHpVgSN9O7O7LUx7B45WDQc2OX1LfIXNDWr3/ZPNay5DE+TeO7HJHiAM8nBStGHXODaogWXoSueeGkRNbMoSO81D0JFnvH0ZtyJoRsF9cBb8k7meHHjh227NmxlvypdRFbINQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmuXreJk1tSaan9fPPEiqJ+apeii9qigyNbJNTbcS85UexqN5530wRfrk6Oh?=
 =?us-ascii?Q?DXpB0Zdxt1L/mMUNQzyOcSWipzDoV+be1iQFRDcU80DxDjC6mKIcH8W6zsFq?=
 =?us-ascii?Q?5b6H2XvlgCPaPsTxQClsasJ4XhZinVgoNJqFN0hbq+vpU1c50WCe9s84lcpR?=
 =?us-ascii?Q?f7oE987ggKyTn49eNT+vfMlgqI6cORtSfA0Pb/nb3Zzq+c7FgMFZy1JjpjEz?=
 =?us-ascii?Q?ja4yDs0NyDCamDYXuE+4zVIw8gOaUzI3TnA+vLL+ku4IVfZ52u4XP9trNwha?=
 =?us-ascii?Q?EIpbNcg/QdsAF9tiRhp2rD04Y/zfKtzNh8VMT7d0pG6LamFalIF1YJ5+ttCe?=
 =?us-ascii?Q?SSJjqiIMo1Ou7ZTmgeB30ps2GZhlJmWh35iRlppJRxyj5DOlI9oubXdrhVKx?=
 =?us-ascii?Q?U7mIMqfvYRmzwo6PmVfg/BJf6v/KNrIWWlgEn9VPgGMhoZfQS0/DA6Na9fL9?=
 =?us-ascii?Q?r6IEA//yXU7aKAs+H2f5APbJT+d6uT5kSHCUtW+wrNXH8pt3qnuHYuPOg2dK?=
 =?us-ascii?Q?zbzg/lHY29Uk7zb+iTFGdx9NZZijH+a81vqWam7AA54/UsVNubZlpXyrUUSN?=
 =?us-ascii?Q?VkqroTLMiVe5wmqwz0bbP9YZ16tpU3yOm3mI5oWJsbe8yvRddrDhPdA9F33g?=
 =?us-ascii?Q?2h17k1SOIP73ZccmjQZ43ZmMfjANU2F61a4Jtm2C9LlzKDP/+pdga+vljMoY?=
 =?us-ascii?Q?sb9fqVOKqnimYfjh941dycF68bO0uyc4L+TzU40fTqo7O9VOS45wlVUd7W4A?=
 =?us-ascii?Q?hW2BoowZdFCjApv5tcvFzvruk/b4U6CSNL1PArAZwXbUlIlBHowT5pVjE00E?=
 =?us-ascii?Q?mn3kVPw27V0eXATGwjbKqfJW4ZKSmDTBCyLXFX2NSzdlf1Wz/hZdTbAKfoC6?=
 =?us-ascii?Q?5FKoqgwDrr3PwmUIVizKhB2xU++KrjLY8KhXDol8kJ/+ml7kOJ/iW9NMsohQ?=
 =?us-ascii?Q?e0X9SDdKZbep7Oti43VniSVLMa2u2KZ5fYa7T+A6Ux6wFnnQynEnMWXjkpLt?=
 =?us-ascii?Q?AAZPeXMFbdMaI15A+XEuyze1c0ZUEpdRfV9/skNeAR+gsnWJvhy3AAvUGflj?=
 =?us-ascii?Q?99cfhDETVFGmxNigMvdqL1U0wGkTW90RXNOLMMmfcu6h21786EhlArL6N7+u?=
 =?us-ascii?Q?dkUDzEevXgKIgmLPCmaw95uXz8MuqfU3C1ZZ3eRhNXu4TsvXSSYRHCqzfyZj?=
 =?us-ascii?Q?s7YXwvPlsbHpRunkKrlgORV0jZUaYuNNLmNeWIs4HnxmtSG0Eima/E0IwAdQ?=
 =?us-ascii?Q?ZQ0/sqLxh7ZvWNlMOnIX4lGg24EWbSjaFFG5Or10RRZgNwFxY5m0C7J83mgL?=
 =?us-ascii?Q?W83t5N0VueGhMMROl/LA4geNAp+raFCDyUURYyoOS4xYSe3Zr5GJTGl7HKvM?=
 =?us-ascii?Q?UhE5obiiMjqDiGPrx9RAiNSPLiumx7vF3Ka4yYmU18BAqUpEqDuh+ZWgrnr6?=
 =?us-ascii?Q?I3rz0kAbPaU8cgBoE+pKao81YRTn/tHcGnYWiqQL+QR0UTORwCMKYm3k3ewU?=
 =?us-ascii?Q?zGg60kSnj+DXP4Awp8sdsN/Y87eOmPVyX+lUGqk1Gk9G5SiP+QVJjFHbecfr?=
 =?us-ascii?Q?FaZScVMTlu91aFkxZJAcMIqPw4+ElH6ljhLJ8YDn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaac369-e526-4ec7-b32d-08dc3d820372
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 02:06:19.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJFp4SOUeXEBdQIiuoK6yT3kC/zCpAm9YN2TVy3SKrIAI7vrX9r7/g7rPVjpUUPsoaulYhiIZK2XHStS01Phzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
X-OriginatorOrg: intel.com

On Fri, Mar 01, 2024 at 08:02:43PM +0800, Yan Zhao wrote:
> > +void guest_shared_mem(void)
> > +{
> > +	uint32_t *test_mem_shared_gva =
> > +		(uint32_t *)TDX_SHARED_MEM_TEST_SHARED_GVA;
> > +
> > +	uint64_t placeholder;
> > +	uint64_t ret;
> > +
> > +	/* Map gpa as shared */
> > +	ret = tdg_vp_vmcall_map_gpa(test_mem_shared_gpa, PAGE_SIZE,
> > +				    &placeholder);
> > +	if (ret)
> > +		tdx_test_fatal_with_data(ret, __LINE__);
> > +
> > +	*test_mem_shared_gva = TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE;
> > +
> > +	/* Exit so host can read shared value */
> > +	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> > +					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> > +					   &placeholder);
> > +	if (ret)
> > +		tdx_test_fatal_with_data(ret, __LINE__);
> > +
> > +	/* Read value written by host and send it back out for verification */
> > +	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> > +					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> > +					   (uint64_t *)test_mem_shared_gva);
> > +	if (ret)
> > +		tdx_test_fatal_with_data(ret, __LINE__);
> > +}
> > +
> > +int verify_shared_mem(void)
> > +{
> > +	struct kvm_vm *vm;
> > +	struct kvm_vcpu *vcpu;
> > +
> > +	vm_vaddr_t test_mem_private_gva;
> > +	uint32_t *test_mem_hva;
> > +
> > +	vm = td_create();
> > +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> > +	vcpu = td_vcpu_add(vm, 0, guest_shared_mem);
> > +
> > +	/*
> > +	 * Set up shared memory page for testing by first allocating as private
> > +	 * and then mapping the same GPA again as shared. This way, the TD does
> > +	 * not have to remap its page tables at runtime.
> > +	 */
> > +	test_mem_private_gva = vm_vaddr_alloc(vm, vm->page_size,
> > +					      TDX_SHARED_MEM_TEST_PRIVATE_GVA);
> > +	TEST_ASSERT_EQ(test_mem_private_gva, TDX_SHARED_MEM_TEST_PRIVATE_GVA);
> > +
> > +	test_mem_hva = addr_gva2hva(vm, test_mem_private_gva);
> > +	TEST_ASSERT(test_mem_hva != NULL,
> > +		    "Guest address not found in guest memory regions\n");
> > +
> > +	test_mem_private_gpa = addr_gva2gpa(vm, test_mem_private_gva);
> > +	virt_pg_map_shared(vm, TDX_SHARED_MEM_TEST_SHARED_GVA,
> > +			   test_mem_private_gpa);
> > +
> > +	test_mem_shared_gpa = test_mem_private_gpa | BIT_ULL(vm->pa_bits - 1);
> > +	sync_global_to_guest(vm, test_mem_private_gpa);
> > +	sync_global_to_guest(vm, test_mem_shared_gpa);
> > +
> > +	td_finalize(vm);
> > +
> > +	printf("Verifying shared memory accesses for TDX\n");
> > +
> > +	/* Begin guest execution; guest writes to shared memory. */
> > +	printf("\t ... Starting guest execution\n");
> > +
> > +	/* Handle map gpa as shared */
> > +	td_vcpu_run(vcpu);
> > +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> The first VMExit should be caused by tdvmcall map gpa, so it's
> impossible to be guest failure.
>
Ah, if KVM has bugs and returns to guest's map gpa tdvmcall as error without
exiting to user space, then it's possible to meet guest failure here.

> Move this line TDX_TEST_CHECK_GUEST_FAILURE(vcpu) to after the next td_vcpu_run()
> is better.
So, looks it's required to be checked after every vcpu run.
Without checking it (as in below), the selftest will not be able to print out
the guest reported fatal error.

> > +
> > +	td_vcpu_run(vcpu);
> > +	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> > +			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> > +	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
> > +
> > +	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
> > +	td_vcpu_run(vcpu);
> > +	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> > +			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> > +	TEST_ASSERT_EQ(
> > +		*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> > +		TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
> > +
> > +	printf("\t ... PASSED\n");
> > +
> > +	kvm_vm_free(vm);
> > +
> > +	return 0;
> > +}
>  
> 

