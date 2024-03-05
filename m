Return-Path: <linux-kselftest+bounces-5890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004538715B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 07:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7652CB233D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 06:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB227BAFE;
	Tue,  5 Mar 2024 06:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8CfdxKy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF03398B;
	Tue,  5 Mar 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619048; cv=fail; b=W/9ix409zDrxat107oy9Dk5yASnGDdzFj2ERrmwaztJfhhemXhEnpqYeDbCTBsauFauAhZHSMxJuIG4g9pbSdP4yB0jc34hoBaGZ/i9VeKKN/Y00JdtTbtrIO2qvz5+NDkLxMelV79p4jwgp0tWvsxSKmn2FUVPd3+COXAjRX5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619048; c=relaxed/simple;
	bh=iW+gHiz97dUJYQAYk7XIhMv/xRS8y9W+4SguMPbSbfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uD4+d4sZ6nXpGSg+qkkLv5d/g1GxfVMC9sYh/szXlGKL1tnSI7XL1PX56lLiM/nX4yRUfk13MirG0meayZAoq+rAFQsGLXaZxMQaVecy84DfXGzEYv04i0sTT8OCMSl1hBNplAo7hNjOCbQbbVQ/Lrb9Wt2MbZVq9SN8v2S7II4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8CfdxKy; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709619047; x=1741155047;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=iW+gHiz97dUJYQAYk7XIhMv/xRS8y9W+4SguMPbSbfg=;
  b=R8CfdxKyluzmJUtZJiJhBZQ3rrBx+fQXEkfx3Z9k/7hxVRToubffps7Q
   pcJSnOxCZUbYcFBBtTW9UzrBwWU+U9iCEk5iKmwIDYf6nZDxmZQwhXF3F
   TIzuPbw+tKXdx7IX1HOs+5c9onPbQfbi3ffxmNKla/O/53p8IWaV/BgwY
   Zxl2EbGYsZzMEryIsyaFzRNYwvDc5BuegkOIeY26wo7y6jvA6HhsgMAiI
   XFAFimhxoRdhXjbtTcHaBmDqM5a2t9KewaAvSV20c9fN1jK43ssGvxPhI
   nQGJd3yZgHn9+Wgit2Updbv2GUi6dSjrOOYdS8NSA3Q/Zs3pYBWM6iqAd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4734876"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4734876"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 22:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9210199"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 22:10:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 22:10:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 22:10:44 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 22:10:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XERzQoByE7JN17RpN0kzbWXY4tf7cLHZvjO2u39VG2LY8wrcgQX7ENM2zXDN5BZ4gS+JUWYQHM+pPf1GdNaiPx0eT07niXNhepGx5141lzAf6iLEn+DpuNATzL1R0VpLGJXSGQjvYtmi+c6Nu0OoxrpFdmBOxPf2Wj5oAeUPTt3KvxirAMEE0E5qAoR6pvL1mHaAOwfdVmYluJpUGh6O9t4uV7/56RJ0lF29lRiVIEDh4kKaef7Fo9hjyO4gXO4TtnXVaIqZiuakDFcTwlHMMp5t7oo/qQGK4DGiiqrEKbNruo156wvpzrjBr8FA8G9EKlvI+EqC88Ty32UTVE8YjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvc5HZM8z9+WRvNUROz2fsaP6vyZVdN9BcHM78cOacM=;
 b=bXlouWvAk02B/ZxAjgcHDVpn8AGJDZjd8Wr942AT5XMQqYF507mwClpgM9zEfOCfmq6eGosrT1h5wIzpBwFJSZC7Pbkx30TJMo9h0QiszJbOx6pRu0NFBEobm5kPL+4jFjsx1YWhQ6XbZLNhyHt8swWIU71z42TsS8Toya39SrBPnUk1xCPyzibhrGNo9pTUfCXHyWkgicZVSGCq/p2Nt2JxCQvsJdXYVBthWfs+OS+QpO1w+PGdq0leXjzFV3Ay9DK36DKbitOYDO4AcaZs3+H2gWHEChRwmDMyOesHrJHB9DNeVAtq/qUe6PS8gTbM5YwnFA2XLxDYwOV4cMJ62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ0PR11MB5181.namprd11.prod.outlook.com (2603:10b6:a03:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.14; Tue, 5 Mar
 2024 06:10:36 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 06:10:36 +0000
Date: Tue, 5 Mar 2024 13:40:42 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Erdem Aktas <erdemaktas@google.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Gonda
	<pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, Chao Peng
	<chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>,
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>,
	<jmattson@google.com>, <dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 16/29] KVM: selftests: TDX: Add TDX HLT exit test
Message-ID: <ZeawWs9cAhjLb/YO@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-17-sagis@google.com>
 <1f9d2b41-95ad-42ca-b1e5-70212b93a9c1@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1f9d2b41-95ad-42ca-b1e5-70212b93a9c1@linux.intel.com>
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ0PR11MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: def2243a-072a-4b3e-4ead-08dc3cdaf8f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYWkb4rQEmXECL1SfjAXelbyvCbfhJU1mccP/4mV5+kSDOtaDNJNPemDFv39HVHsvpmVDn/5VFNDrfiIPgEHe0EpItz32DmFn2s1a3ZyT9zlzkzfuIY/VANEvCNCxN2EUmJYIS0HVgPiJ86HVGGLEDsHA1vuiJFbUeJZ9G1HDPjLnvHb5NdauRJiOf7ZHXGNJJMxpZbnhb4EbQM5k4MmhIEfjngwWL/MAPGB10z0c8kIxWuCTJRnc0xxugN9tIt6Rr34xuszqjUY5DzE/AFmL3IFXxfTR5/crWe5absdGZ4QyjzwC3W8uOV/oMVwvsDMC1wdjzdI2WcEE5sBtuB7mLuOwWlXto/FQP75TUHXmsxWhv/OFD8Fu2GZNDGAZDkOGmDJcxU4F7nHCW2tqQo2tpIiXpn00Sxg9vAqv2iPw8+hoor33k2G+Vj9+iuZhf3jAEflgWENwVIk3spsmtWhop2wy/1CN7MbyEZJ2cDwHwg5Ezxay052LYchg62YiIEAZA/dKQZaOKzzCUlpSLye1/oqwMLXaIxv/JoTZvc6sdnincsfv5YzCzz/A45vjkcuSTudcqt2mRoEsKSQZ9BUL6jSR52Q9B6xvzqfndz0aRw/AlAJ4eL8apzVf4QO7Q1j0dqUYQlzmFvedQcALjq3XeqIw1osDsm0oSi6TACNii0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMAiYS88n6O4VC5EyVEBtZ0JYC/HBi/R85TjQCv+na18Fs7OtzUXpgZrFPUQ?=
 =?us-ascii?Q?r/Seo9DvSIep9lJMaaPPbfsNOns4owGpWePbghLPSNq19wXd4lOXfUP+YYcP?=
 =?us-ascii?Q?CXg+IQe5s/izBVomTYZw7BsyEDsQoBrYxV8xz2meCERPuqq7CDEizKBEeDxU?=
 =?us-ascii?Q?al4ssKRpfc5gGaSzf/WVSq57OlNQdLQwxRa9e6YEwHMlWbsPuIra33rBTKjE?=
 =?us-ascii?Q?0I0DjguqHPiud9OLLJ4dn4l2ksjgEx5PzJfI8sMkWJ1/6CTB0mJWmtKku9Em?=
 =?us-ascii?Q?yCJ15IokDWCQRmOcOsr0i5cg04O9oGsePzu56mLdhFSObiLj4GPhM3W7MJIA?=
 =?us-ascii?Q?ZoQUFqn/iiFghJ29JayLsHl9Al873/yYvae5m1GDx4ycNUybPlSB3jxdXuGI?=
 =?us-ascii?Q?tvONygVl3ykO3y+Ylc4YtSK5DukZFltxi4TjroNBJPq7KfVEvEtT813PZ9zt?=
 =?us-ascii?Q?KiuFHVxQj4eMsE+jTaqeABvUr1vHOuhJcO6mQRqsbD6X8gGJhJxVdlMxx7E8?=
 =?us-ascii?Q?9CuzbofhCaxuAysSmHT8RSGOJJPzPVMh4Y0TxsmGK18nYTbC/WHRBWGhSddb?=
 =?us-ascii?Q?k+Di10RpaumKzEdGJBFBSY6QS+FEDTeVhqYKcTuVFDJh2NHfmn56o/5xJsZi?=
 =?us-ascii?Q?dV7wSamFxFIita9oarli4zPVfCdBU6AwpWdlBJNp+J2swpiihQS9Rxz3EN6m?=
 =?us-ascii?Q?RoaHEeh6XBjgtMnRuSzFOvaC977gG0qz2IkpfTiBA2iDcrJOgmS2s+a/T0tw?=
 =?us-ascii?Q?NrSa51cdjlVX5Hq+NlvvR1X6fS/zg/nJYFfDWSSWKFXs4nMzqj0cKHmznWjR?=
 =?us-ascii?Q?bUj1KeWArn3buMd9uWN4qnlisDWaobEzZPrVSL963MFBUDD2d65hYXK3eoov?=
 =?us-ascii?Q?JkrMYC5DYOmZsvFBuzGtcJMo3XPa5V7j+NA4wucQkqP2MjnWjKMSN6I1TDjg?=
 =?us-ascii?Q?Lkq5s8Mp+UplFP1MU0xncjfcJrnrHLo+nc8jTcqQ5TvxBmDu8MJ+IuawBt2h?=
 =?us-ascii?Q?YDZsp9fSc1A4W4yZdKFlbmSmxKv03wMDVW2oFsmypiR+MR7lCLs3RHokRYTH?=
 =?us-ascii?Q?FqmDo7uix4cC8aok5Pm5ToRI7kOSoA9wTKA1IvndmqJWRyqpFAppGTUGUwbj?=
 =?us-ascii?Q?PkNIxzDUKvZB8xo+jSsjf3RdVgNUHTZlQ9+tyyXe8TiDb6QbOY4BtsK1hz0c?=
 =?us-ascii?Q?KrCGAyvcoA0Rd9xvNhYyDDsgMZUZSRJMt9GwvBdbbmTPDqGi0zERyb3YudTr?=
 =?us-ascii?Q?PvrjhzlN8iPZxdlY6rduHN4Eb2ewDOTuDJ2Kgsz91gT8b9rihxr5ApHsy7Er?=
 =?us-ascii?Q?iF9N6tAfa5TQsJgO+Z/YWKWsaGTLsom1qGz4KZjWIx3BPDE2MMb+7cAa9kX6?=
 =?us-ascii?Q?HoPaFf4s3BKvZscQBwukpmgW/wIM3Rrnh7pCLlNe/qmzYwTrXAv3AW/ehuz5?=
 =?us-ascii?Q?T9DoXVnHsLWOSHe8UE2G+VyHvpnYkdv/pMyr+zs0VYxV+ItpC3QSZgEAnHMm?=
 =?us-ascii?Q?MvbIR/ZCHoJvaw3dMM6tXFA6Toqn2cwnLK7WuxIv21norvqy6DD1fnBJVZT1?=
 =?us-ascii?Q?GoWxnhKLAcYZkqoQc9QXk/5IGErvQ+NYybVvISSz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: def2243a-072a-4b3e-4ead-08dc3cdaf8f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:10:35.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yewhIxjduZCRB+SYhhp1l1YQjF2j+BYQt/Zh5qlAXn5J/9WshpMNg6FITvOjARadsf6TTjIxSZaSl4DsOEHEEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5181
X-OriginatorOrg: intel.com

On Sat, Mar 02, 2024 at 03:31:07PM +0800, Binbin Wu wrote:
> On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> > The test verifies that the guest runs TDVMCALL<INSTRUCTION.HLT> and the
> > guest vCPU enters to the halted state.
> > 
> > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ryan Afranji <afranji@google.com>
> > ---
> >   .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
> >   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 10 +++
> >   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 78 +++++++++++++++++++
> >   3 files changed, 90 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > index 85ba6aab79a7..b18e39d20498 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > @@ -8,6 +8,7 @@
> >   #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
> >   #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
> > +#define TDG_VP_VMCALL_INSTRUCTION_HLT 12
> >   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
> >   #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
> >   #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
> > @@ -20,5 +21,6 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
> >   					uint64_t *r13, uint64_t *r14);
> >   uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
> >   uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
> > +uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
> >   #endif // SELFTEST_TDX_TDX_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > index 88ea6f2a6469..9485bafedc38 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > @@ -114,3 +114,13 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
> >   	return __tdx_hypercall(&args, 0);
> >   }
> > +
> > +uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
> > +{
> > +	struct tdx_hypercall_args args = {
> > +		.r11 = TDG_VP_VMCALL_INSTRUCTION_HLT,
> > +		.r12 = interrupt_blocked_flag,
> > +	};
> > +
> > +	return __tdx_hypercall(&args, 0);
> > +}
> > diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > index 5db3701cc6d9..5fae4c6e5f95 100644
> > --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > @@ -721,6 +721,83 @@ void verify_guest_msr_writes(void)
> >   	printf("\t ... PASSED\n");
> >   }
> > +/*
> > + * Verifies HLT functionality.
> > + */
> > +void guest_hlt(void)
> > +{
> > +	uint64_t ret;
> > +	uint64_t interrupt_blocked_flag;
> > +
> > +	interrupt_blocked_flag = 0;
> > +	ret = tdg_vp_vmcall_instruction_hlt(interrupt_blocked_flag);
> > +	if (ret)
> > +		tdx_test_fatal(ret);
> > +
> > +	tdx_test_success();
> > +}
> > +
> > +void _verify_guest_hlt(int signum);
> > +
> > +void wake_me(int interval)
> > +{
> > +	struct sigaction action;
> > +
> > +	action.sa_handler = _verify_guest_hlt;
> > +	sigemptyset(&action.sa_mask);
> > +	action.sa_flags = 0;
> > +
> > +	TEST_ASSERT(sigaction(SIGALRM, &action, NULL) == 0,
> > +		    "Could not set the alarm handler!");
> > +
> > +	alarm(interval);
> > +}
> > +
> > +void _verify_guest_hlt(int signum)
> > +{
> > +	struct kvm_vm *vm;
> > +	static struct kvm_vcpu *vcpu;
> > +
> > +	/*
> > +	 * This function will also be called by SIGALRM handler to check the
> > +	 * vCPU MP State. If vm has been initialized, then we are in the signal
> > +	 * handler. Check the MP state and let the guest run again.
> > +	 */
> > +	if (vcpu != NULL) {
> 
> What if the following case if there is a bug in KVM so that:
> 
> In guest, execution of tdg_vp_vmcall_instruction_hlt() return 0, but the
> vcpu is not actually halted. Then guest will call tdx_test_success().
> 
> And the first call of _verify_guest_hlt() will call kvm_vm_free(vm) to free
> the vm, which also frees the vcpu, and 1 second later, in this path vcpu
> will
> be accessed after free.
>
Right. Another possibility is that if buggy KVM returns success to guest
without putting guest to halted state, the selftest will still print
"PASSED" because the second _verify_guest_hlt() (after waiting for 1s)
has no chance to get executed before the process exits.

> > +		struct kvm_mp_state mp_state;
> > +
> > +		vcpu_mp_state_get(vcpu, &mp_state);
> > +		TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_HALTED);
> > +
> > +		/* Let the guest to run and finish the test.*/
> > +		mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
> > +		vcpu_mp_state_set(vcpu, &mp_state);
> > +		return;
> > +	}
> > +
> > +	vm = td_create();
> > +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> > +	vcpu = td_vcpu_add(vm, 0, guest_hlt);
> > +	td_finalize(vm);
> > +
> > +	printf("Verifying HLT:\n");
> > +
> > +	printf("\t ... Running guest\n");
> > +
> > +	/* Wait 1 second for guest to execute HLT */
> > +	wake_me(1);
> > +	td_vcpu_run(vcpu);
> > +
> > +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> > +
> > +	kvm_vm_free(vm);
> > +	printf("\t ... PASSED\n");
> > +}
> > +
> > +void verify_guest_hlt(void)
> > +{
> > +	_verify_guest_hlt(0);
> > +}
> >   int main(int argc, char **argv)
> >   {
> > @@ -740,6 +817,7 @@ int main(int argc, char **argv)
> >   	run_in_new_process(&verify_guest_reads);
> >   	run_in_new_process(&verify_guest_msr_writes);
> >   	run_in_new_process(&verify_guest_msr_reads);
> > +	run_in_new_process(&verify_guest_hlt);
> >   	return 0;
> >   }
> 
> 

