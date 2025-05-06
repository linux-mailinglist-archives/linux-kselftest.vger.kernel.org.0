Return-Path: <linux-kselftest+bounces-32479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A7AAB944
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDBC3A87E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA361A5BA6;
	Tue,  6 May 2025 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKiHRb4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC41FF1C4;
	Tue,  6 May 2025 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494800; cv=fail; b=bkov4hFEIyjSoILmg+IPfdFZi9w0CSx4MrFkCMD9lAmaLhNCDynPTZAIhsmKlIUcwNpP9rpy3sTCIaDiw10yrByjx2A/ZSDcarhKZ1iXhdmnaivHoJ2+hxOsfaHayfWOlnp1fIOuPMPSrxXgHhU0io7A7+YJdc/BJTwrtLdKuKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494800; c=relaxed/simple;
	bh=YpbcJPSlq4Glc/UhKkGm1pml17/YqiSr/qCh6Dc1on4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9gE2k0uruJmrnyNdMEUiZA9Q0G2ZieFde1OcO+T3lNYnwExnuWaRkVnYxuGFtHWg5LK4GFVZtTR3hfFhIfwxM6dBd9eiNnpUFXRaX6jK+JPZ4l1vkzrvNFDsS7v+PlB7sHBGHp/mqTQKHPakLRKo+o6IdXkRVgKyOE/VVygJ84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKiHRb4k; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746494798; x=1778030798;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YpbcJPSlq4Glc/UhKkGm1pml17/YqiSr/qCh6Dc1on4=;
  b=PKiHRb4kXu9PkyDCaMqZOJLtPvyYq+uD2pmra/fF2k8kIIMmyWXXYi4T
   gIIyLLVKMmBZN7JbZE2xzmKOfyLHGKxptV/kP4n3vlEVzVd1g+DFk/jJy
   NUxNVPqZDJ4pFvxUyuXm+3eb0L6+swboUXgK5SUh6k6rL5avKZtok9DSz
   BlP74OahKP1Ft9/3ygKNatr45QjT7jTxyWeip6/fMxi/BRDDg9O7ajDQU
   8nirx2p0ftDta4qU5sk68+AQ3Mt+BPwq2zz+JIR/SC0+6Bgv5+KWaG/VS
   nDkwSuqIYyJyMQSj11AhBBc0Z+Lwcrxtyn5MS3Qf/lO9jM4SGEiguep8c
   w==;
X-CSE-ConnectionGUID: nx+042qSRZ6z+R75tsZvxQ==
X-CSE-MsgGUID: /36JqWoQSOua9i+gTb4SHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51949932"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="51949932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 18:26:31 -0700
X-CSE-ConnectionGUID: 6DvbSKFeQW6T8J5g5FOmTg==
X-CSE-MsgGUID: SeW4nbq7SIyJg4ARLkOP6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="135159529"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 18:26:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 18:26:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 18:26:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 18:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA3Q6AUxCsALtSutJ67vrnHuK8rbm0rOj/T7kdSkqnyzCtJKS0uPhFDLTzGqfC7rJp0nCL6LuPtoxU1OCS0fM/aOHjj7G9vaBbu2h8WutlxCuDP7KWTeyE59BTndBvpMosNLj2XkLyVPfSs0vCvoxhBVz12ZJX59Y9aIVO1uL62f6eL9itBUgjfdIrzCGMzKNzqsSwmsFsUy1YmptZmmmKCjUebx2SaPyEDGOPaix1CWZ/z4FDlxE53OCsFboZ9Boe/c7dGpJT/RgVvsAzcgQKqLK3eumEv0m1hh66sqZD6IIyYgA2sNpq4z9m+sOfiK3fNj0qrT3SwjsInxxX3p3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn+cBo80vZEQGYcgtUs+35ykzYzMa6KlpUKk6p556w8=;
 b=iX/zoQOB4/MiCXaW0oymA+2qJZWwz6j6dlUb917laE5xn/NcJbtBALqDt1xKA/DohfZZsd44NLOeouabUW9z1EK3IPJ0P8B97vCbtrPtD0KP1Ic2FmpB3CZn9HwaPuKbx3Y6WDGA9TENiT8GnQSnELCTGOJ7cQD1ornAZgaHx8qMOvEiLf9TC6IwDAat4SiCroDREIISoToUSggntZe+Pi0metqMR4M25V4HAgbJ9rlFCDF0LaPXFgwJ25z307+/BNiUoj2ydVyV6hAnZimIEh4IuTxqD+meWnmYyhM5RqDmhoGPpRB5hiJzd0guT6M6RPgUwGIMqC3YY/Hwq67lVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 01:25:59 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 01:25:59 +0000
Date: Tue, 6 May 2025 09:23:50 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <vannapurve@google.com>, <chenyi.qiang@intel.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <roypat@amazon.co.uk>, <jgg@nvidia.com>,
	<peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
	<fvdl@google.com>, <jthoughton@google.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
	<jun.miao@intel.com>, <isaku.yamahata@intel.com>, <muchun.song@linux.dev>,
	<erdemaktas@google.com>, <qperret@google.com>, <jhubbard@nvidia.com>,
	<willy@infradead.org>, <shuah@kernel.org>, <brauner@kernel.org>,
	<bfoster@redhat.com>, <kent.overstreet@linux.dev>, <pvorel@suse.cz>,
	<rppt@kernel.org>, <richard.weiyang@gmail.com>, <anup@brainfault.org>,
	<haibo1.xu@intel.com>, <ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <aBlkplRxLNojF4m1@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <aA7UXI0NB7oQQrL2@yzhao56-desk.sh.intel.com>
 <diqz4iy5xvgi.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <diqz4iy5xvgi.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: KU2P306CA0017.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::6) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CH3PR11MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f7cdba-fdd0-49bf-1187-08dd8c3cf465
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V25UK3QyWkZ0V1psUFcrNlhjS0JIQTR5RWEvdldyRGI2a1ZUTEhaaWI1aVBn?=
 =?utf-8?B?Y09BNGlwcFNQM3ltcGZTcGZIUEVzNWJteFBSeDIwSjd5YmdwK1lydGdkT2hJ?=
 =?utf-8?B?elkrNUlIMVpEQjBDOW5ENnE4MUdRWTJSd0RGYzczM0xnODloWEVzT2VydEZ3?=
 =?utf-8?B?WGhaWW5Oa0NZMWJkREtPdTc4Wms3ZGxCVUJyRk1JZktCeFF0cUZPak8waGlZ?=
 =?utf-8?B?cFJjMkJiS2Q3Y04xb0lhYWo3ejRtNjdqTHJBWk9BbHZMZTl6RmtqdHppWU9G?=
 =?utf-8?B?L0xMeXBQMmlTT29WU3gxR3ROWGFZb2IvU0JsNkZwVzRmbmtXMjlQZGxDV25u?=
 =?utf-8?B?aTZNbTU3WkVYNm5CTFVNK1drdzV2R3Zja0dVSmhzOGZaTEVZOXhEa1hmRExa?=
 =?utf-8?B?TXY0b1VOUGZGSWhCYmg0WUtYZjFEQkFFSWJaRFpBZGs5alhEQStmTi9mVUh5?=
 =?utf-8?B?TnJpYUpxZzlKQjU2SVU3THRZQ0J3MHNMRHNXL21wMS9KUGs2WmJraURIZ0Rt?=
 =?utf-8?B?YklMNitoN0puSmg1eTl4OWRhOVRCbU1KZlBGc2krQ2JjQWFRSjlVZ2EvRVIr?=
 =?utf-8?B?ODQyUFpEQmMvRFdURkRGRHcvS2lRUEJ4UDhqV29DYm1MZ29nL1ZCc2lPUGVx?=
 =?utf-8?B?NVZwb0RFR0xQRVlaTWhiTzB0T0ttVy8vRFdCOEI2LzJxOXZYZ2c3V3FzQTdQ?=
 =?utf-8?B?NlI2b0h2aVFlSjhoMGZDY1dPWUUzYW4xejhpV2FKVXFKQVA5TTlNS3pIWEpL?=
 =?utf-8?B?RDdkTHlUS3hrejF1ck1HUTlnY0hjZTdEY3RFdFlRYnorTHJMVEkwbWR1bC91?=
 =?utf-8?B?WjJlYXpNYytSNEVmRzNzaE83U09kNlZqMEhhd2hyd1hDTW9uNm9EckN3SG5i?=
 =?utf-8?B?Rzl3L2tMdTd5WnI3c1BGbzhzZ3ByNjQ0a29tbXIzVitZc1Araml6R1JhUGQ4?=
 =?utf-8?B?NG5GK3Z4Vk1XYXRiR0Y4allUYldKcHVjNlBVTml0cHdqUE05czZZc1J3T0lJ?=
 =?utf-8?B?T2NNZWZGdW5mMkRlU0lQRktYZ1hBeHpUb3l5ek9NZ3FoNTUrQ0dKRWpXQjFq?=
 =?utf-8?B?SVh1Qm1kRFhrTXZxRjMvMFBUSEVYMmtjZmhWVEVSZHN2TWJJZmFaUFpEQ0Ez?=
 =?utf-8?B?NHQ2Tm5EMXVLUktycjNyQXBycnB4aVRiS0xIUWQySFF1aFVlWXdvZ284Nzdi?=
 =?utf-8?B?UlRJUHd3UVJzWXpGMzF5NC80cEtLNCtHbG1tUVFXbzNxZDBueVpNSnZBTEMv?=
 =?utf-8?B?VVI5S0dKK01KUS90UFk4QUV4RHNIbWtjckVOc001dkpKZTVCVlc4SnVGamtI?=
 =?utf-8?B?KzVuM28vNjFPSlczQ0ZMZ0VGZzJyRDJsSkhYSFF2MlBEWVNJNmtXbWZVSmpy?=
 =?utf-8?B?aHdXbHVZR09OQm55eXZFeDZ4SnhoL1gwYTRJdGhYY2lJVUVnQk4vZndndkdC?=
 =?utf-8?B?VDdjVGh2OVVMWUM1L1lMbmtsUVAxM2NXWkNkTXVkTmZVa0FLU0ovZVpHbFFk?=
 =?utf-8?B?QkkyczVqU05uWXBCcHlDMTNLYTNleE1LZkFpTTNVNGNJaTExWCtGSkdIL2Mv?=
 =?utf-8?B?QnNzUGJQOEY1K1NyTXhTTUxtY2RQZ1FHa2tVRlVyaG14Y05yUXdVUmRoUXNO?=
 =?utf-8?B?LzdFbmJ6Y2x6MXhTdGE3RTdsVEE4UElDc1pJaWc0R09aV254M2VwK0paN3Rv?=
 =?utf-8?B?a3JaQVA3bkdVUWRmOTF6Vy9lOWJ3amVuOExRcW14VFRXTDgxTFF0MDZteCt6?=
 =?utf-8?B?bDZGNWxDa25OSGdLWC9mNUpHN2k2SEMxRGxaTjlRM1k1RHowMkVLM0VuRmh3?=
 =?utf-8?Q?kaXK4xko+NuAX47D7l6BPPVVpOFwUDs331s1E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzUxeGMzcURkR2dNNVRPYUVxeWV0QjVJcmJ6V2hsVjdZMm1MbXB5S1NzQ0lV?=
 =?utf-8?B?SkVvb05hNXphS21TbHhsQzJjVWJZbDFGeXhpSS9YWWJrU1V4T29iQjFPNU43?=
 =?utf-8?B?YzNEMFk5RWhha0E2d1ZiMHdKUklpaHgrK1BZMXZIZlVSaVU4MTRXOE82SUp5?=
 =?utf-8?B?LzBVdjBvbkRaMjh1Q0lQQzByVE5iYmlSdmVQQVJNd3YyWHNZMEhlZDM1emlP?=
 =?utf-8?B?SmR4eXRuNElWTTBPVUk1d01ib21KYWRWMm55MlJEa0ZKdDZsY0FReUZWL3Nz?=
 =?utf-8?B?cHRwc2cyM2dsdmlpTGVHQXozRURqVFU2NVlGdktxdkhVWUM3b1p3OW44OFdw?=
 =?utf-8?B?bjJFaXlhY3Q1ZmI1YmZzd21jQ2YzdHBodVlNWTZxLzJ1OHpPbHgwZjYxVmZZ?=
 =?utf-8?B?N3VLZkpBUVpISXNQUEdrZklSZlJxQU9sc3FxYXZWSm0xSVdZbS9nQnF3WElX?=
 =?utf-8?B?VGg0YThMNTRXOTdYZm92blkyWURVSDJ3VVZwWldKTWdVdS9qVG9YOHFJOWQ1?=
 =?utf-8?B?alVJbjRIeVhoMHhiTThWSzJ6SXFhYXRqTVZkTWF4bEVGNDk2R2tqdHNSeklR?=
 =?utf-8?B?YnZsejJWVjZHQzU5cGd1aElCSG9oVkFmejZxNGhWeFNSY0ZUeFFDN1F6NmJw?=
 =?utf-8?B?bHFRNUxVMnhZZzA0L2Z4SU02VmJGSTJ3YVJ1RCtlQy9zcHh3N3AxMTRBWXVR?=
 =?utf-8?B?N0NDZVF5SDVGWjZCWEttaWZMeXFuNVJiK1c0UTNoSm4yMWZYR0I4UzBCMk1Z?=
 =?utf-8?B?NTNBaTVyc2k1aEdJbXd6d3ZVN1BYeCtaVGRqb3ZiUVdVV2wwV210cERYVHVB?=
 =?utf-8?B?YXAzUXhrdGFFR0JwQ3BtbFhYSDZScFNrQkxSL2kwN3VqS1ZRMDJ2ZFQybGVF?=
 =?utf-8?B?Nk5tT281OEFqdjJmTW5nbHRlUHJEcGFkWWFJY3JLTEVFbXU5NDAyUDE3dURT?=
 =?utf-8?B?V3VuN2s5aXhsWlpzU0g1ZE1uWGREME91WFVPb2xWK3VpclFUVjB5aFNVS1Zh?=
 =?utf-8?B?aCtyQ2gvUnhFNzhJN28wSW5QMXI5NXhwQzRyUS85d000TXliNkx5NFo2TEx0?=
 =?utf-8?B?VWYyR2krWHJUVzRBY0dpYW94ZEF0UzVxWWdueGVvRlVFenBLNzY2WXVFbStN?=
 =?utf-8?B?cllPSE9GUGtFYklJcGpVZ2lLVWVDcXIvai8zZnlqR3E1MWhuV2JmZzl3Titi?=
 =?utf-8?B?Ly9jSmkzSnA0ejlkcjZiUzBBSnU5OFNIekl5ZlN5UkFVbUJ2dndiMHYycFlp?=
 =?utf-8?B?T3JtYTlCcVJ5ZnZ3THRSR25CWU1IazUyOEk4Ym1NdGRRSGlkUzh1WkVoQm53?=
 =?utf-8?B?YjFtWkZJYXVrK2tuNFI1STRQRXBGLzVob1hzVXlwL1IweTNGd1lLdUlCRmZF?=
 =?utf-8?B?N2RMTzR5Uzg2aTV6MXdqdHBYTGZGWGtrNUtrbGRXaTE3aXFuRjh3aHZ4Wjd3?=
 =?utf-8?B?TUxnSVlkTnBDZFRyZHVrQlJLUVNxWVJocVdweEtIdHFLL01TVXJkdkhBNDZU?=
 =?utf-8?B?dVVEMmk4amtZaFZpeXVpbFdubWtsRXNrRHpDbEpaamlQeDVGWTBNNS9vZlc0?=
 =?utf-8?B?Tlk0S0pmdjNLVDVhOHBQdDlzKy9wNHZjV0hYNlliMEJ5ZEdNdlVJekFpVU5D?=
 =?utf-8?B?bGpsbmdxL25YcEtmeUF2Rjg0N0dRaS9na29sTHd3VHl2bU1JNlMwYitSZ1ZK?=
 =?utf-8?B?NSs1YkVnMzRnUVhGUEcrZGZHdkhMaGVEV1Irb1lnRUpDaitVdmRGWHJiVEdK?=
 =?utf-8?B?ZS9ibk1KNHlTZG1VV2xjYjl1T2p5VGl1YXBHaloyTVZCVXQ1L29Mc2JzRG1s?=
 =?utf-8?B?YlROQ1M2WTJWQ2U0MzlPQVdoMWtkcXMvNCtpa2lGdmh5MThmdE0wdG56Qm5v?=
 =?utf-8?B?bXdsd3A0aU4xbUt0YmVXRHpQSEt4UkpoM0NTZlRwcUlUQkRFaWRCSmRRT1dO?=
 =?utf-8?B?WGk0OSs4T0kwSTJXbTl1c1cydnZxY0lTY1kzbSt4RVRDMVpSQS9oQ2oycU0y?=
 =?utf-8?B?S2hYdm43emFINDBpZ1Zva1NsaEl6dStvdWxGU3VBTnV6cUNwQTNwczBDK3c4?=
 =?utf-8?B?MWRPMW1UN29PVXdHRW1KS2dOTUhuclBCQnR5Q1EvSm0wblI3OVgwNlpOUERo?=
 =?utf-8?Q?s96U/6a6lZOB7K6/ifV7QU4Wz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f7cdba-fdd0-49bf-1187-08dd8c3cf465
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 01:25:58.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEwXmNQkLirxQTrKC51mlFDPkTUR4h7+hol7xFs2FeVT14YnjSPoWKMEcGAXOf+Ua580lROKntsiSiOPfkL5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
X-OriginatorOrg: intel.com

On Wed, Apr 30, 2025 at 01:09:33PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Fri, Apr 25, 2025 at 03:45:20PM -0700, Ackerley Tng wrote:
> >> Yan Zhao <yan.y.zhao@intel.com> writes:
> >> 
> >> > On Thu, Apr 24, 2025 at 11:15:11AM -0700, Ackerley Tng wrote:
> >> >> Vishal Annapurve <vannapurve@google.com> writes:
> >> >> 
> >> >> > On Thu, Apr 24, 2025 at 1:15 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> >> >> >>
> >> >> >> On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
> >> >> >> >
> >> >> >> >
> >> >> >> > On 4/24/2025 12:25 PM, Yan Zhao wrote:
> >> >> >> > > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
> >> >> >> > >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
> >> >> >> > >>> Yan Zhao <yan.y.zhao@intel.com> writes:
> >> >> >> > >>>
> >> >> >> > >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> >> >> >> > >>>>> +/*
> >> >> >> > >>>>> + * Allocates and then caches a folio in the filemap. Returns a folio with
> >> >> >> > >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
> >> >> >> > >>>>> + */
> >> >> >> > >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> >> >> >> > >>>>> +                                                           pgoff_t index)
> >> >> >> > >>>>> +{
> >> >> >> > >>>>> +       struct kvm_gmem_hugetlb *hgmem;
> >> >> >> > >>>>> +       pgoff_t aligned_index;
> >> >> >> > >>>>> +       struct folio *folio;
> >> >> >> > >>>>> +       int nr_pages;
> >> >> >> > >>>>> +       int ret;
> >> >> >> > >>>>> +
> >> >> >> > >>>>> +       hgmem = kvm_gmem_hgmem(inode);
> >> >> >> > >>>>> +       folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> >> >> >> > >>>>> +       if (IS_ERR(folio))
> >> >> >> > >>>>> +               return folio;
> >> >> >> > >>>>> +
> >> >> >> > >>>>> +       nr_pages = 1UL << huge_page_order(hgmem->h);
> >> >> >> > >>>>> +       aligned_index = round_down(index, nr_pages);
> >> >> >> > >>>> Maybe a gap here.
> >> >> >> > >>>>
> >> >> >> > >>>> When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
> >> >> >> > >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
> >> >> >> > >>>> corresponding GFN is not 2M/1G aligned.
> >> >> >> > >>>
> >> >> >> > >>> Thanks for looking into this.
> >> >> >> > >>>
> >> >> >> > >>> In 1G page support for guest_memfd, the offset and size are always
> >> >> >> > >>> hugepage aligned to the hugepage size requested at guest_memfd creation
> >> >> >> > >>> time, and it is true that when binding to a memslot, slot->base_gfn and
> >> >> >> > >>> slot->npages may not be hugepage aligned.
> >> >> >> > >>>
> >> >> >> > >>>>
> >> >> >> > >>>> However, TDX requires that private huge pages be 2M aligned in GFN.
> >> >> >> > >>>>
> >> >> >> > >>>
> >> >> >> > >>> IIUC other factors also contribute to determining the mapping level in
> >> >> >> > >>> the guest page tables, like lpage_info and .private_max_mapping_level()
> >> >> >> > >>> in kvm_x86_ops.
> >> >> >> > >>>
> >> >> >> > >>> If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
> >> >> >> > >>> will track that and not allow faulting into guest page tables at higher
> >> >> >> > >>> granularity.
> >> >> >> > >>
> >> >> >> > >> lpage_info only checks the alignments of slot->base_gfn and
> >> >> >> > >> slot->base_gfn + npages. e.g.,
> >> >> >> > >>
> >> >> >> > >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
> >> >> >> > >> lpage_info[2M][0].disallow_lpage = 1, which is for GFN [4K, 2M+8K);
> >> >> >> > >> lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M+8K, 4M+8K);
> >> >> >> > >> lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M+8K, 6M+8K);
> >> >> >> > >> lpage_info[2M][3].disallow_lpage = 1, which is for GFN [6M+8K, 8M+8K);
> >> >> >> >
> >> >> >> > Should it be?
> >> >> >> > lpage_info[2M][0].disallow_lpage = 1, which is for GFN [8K, 2M);
> >> >> >> > lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M, 4M);
> >> >> >> > lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M, 6M);
> >> >> >> > lpage_info[2M][3].disallow_lpage = 0, which is for GFN [6M, 8M);
> >> >> >> > lpage_info[2M][4].disallow_lpage = 1, which is for GFN [8M, 8M+8K);
> >> >> >> Right. Good catch. Thanks!
> >> >> >>
> >> >> >> Let me update the example as below:
> >> >> >> slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)
> >> >> >>
> >> >> >> lpage_info[2M][0].disallow_lpage = 1, which is for GPA [8KB, 2MB);
> >> >> >> lpage_info[2M][1].disallow_lpage = 0, which is for GPA [2MB, 4MB);
> >> >> >> lpage_info[2M][2].disallow_lpage = 0, which is for GPA [4MB, 6MB);
> >> >> >> lpage_info[2M][3].disallow_lpage = 0, which is for GPA [6MB, 8MB);
> >> >> >> lpage_info[2M][4].disallow_lpage = 1, which is for GPA [8MB, 8MB+8KB);
> >> >> >>
> >> >> >> lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4MB and GPA
> >> >> >> 4MB+16KB. However, their aligned_index values lead guest_memfd to allocate two
> >> >> >> 2MB folios, whose physical addresses may not be contiguous.
> >> >> >>
> >> >> >> Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB and GPA 4MB,
> >> >> >> KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), [4MB, 6MB).
> >> >> >> However, guest_memfd just allocates the same 2MB folio for both faults.
> >> >> >>
> >> >> >>
> >> >> >> >
> >> >> >> > >>
> >> >> >> > >>   ---------------------------------------------------------
> >> >> >> > >>   |          |  |          |  |          |  |          |  |
> >> >> >> > >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
> >> >> >> > >>
> >> >> >> > >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], huge
> >> >> >> > >> page is allowed. Also, they have the same aligned_index 2 in guest_memfd.
> >> >> >> > >> So, guest_memfd allocates the same huge folio of 2M order for them.
> >> >> >> > > Sorry, sent too fast this morning. The example is not right. The correct
> >> >> >> > > one is:
> >> >> >> > >
> >> >> >> > > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. So,
> >> >> >> > > KVM will create a 2M mapping for them.
> >> >> >> > >
> >> >> >> > > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to the
> >> >> >> > > same 2M folio and physical addresses may not be contiguous.
> >> >> >
> >> >> > Then during binding, guest memfd offset misalignment with hugepage
> >> >> > should be same as gfn misalignment. i.e.
> >> >> >
> >> >> > (offset & ~huge_page_mask(h)) == ((slot->base_gfn << PAGE_SHIFT) &
> >> >> > ~huge_page_mask(h));
> >> >> >
> >> >> > For non guest_memfd backed scenarios, KVM allows slot gfn ranges that
> >> >> > are not hugepage aligned, so guest_memfd should also be able to
> >> >> > support non-hugepage aligned memslots.
> >> >> >
> >> >> 
> >> >> I drew up a picture [1] which hopefully clarifies this.
> >> >> 
> >> >> Thanks for pointing this out, I understand better now and we will add an
> >> >> extra constraint during memslot binding of guest_memfd to check that gfn
> >> >> offsets within a hugepage must be guest_memfd offsets.
> >> > I'm a bit confused.
> >> >
> >> > As "index = gfn - slot->base_gfn + slot->gmem.pgoff", do you mean you are going
> >> > to force "slot->base_gfn == slot->gmem.pgoff" ?
> >> >
> >> > For some memory region, e.g., "pc.ram", it's divided into 2 parts:
> >> > - one with offset 0, size 0x80000000(2G),
> >> >   positioned at GPA 0, which is below GPA 4G;
> >> > - one with offset 0x80000000(2G), size 0x80000000(2G),
> >> >   positioned at GPA 0x100000000(4G), which is above GPA 4G.
> >> >
> >> > For the second part, its slot->base_gfn is 0x100000000, while slot->gmem.pgoff
> >> > is 0x80000000.
> >> >
> >> 
> >> Nope I don't mean to enforce that they are equal, we just need the
> >> offsets within the page to be equal.
> >> 
> >> I edited Vishal's code snippet, perhaps it would help explain better:
> >> 
> >> page_size is the size of the hugepage, so in our example,
> >> 
> >>   page_size = SZ_2M;
> >>   page_mask = ~(page_size - 1);
> > page_mask = page_size - 1  ?
> >
> 
> Yes, thank you!
> 
> >>   offset_within_page = slot->gmem.pgoff & page_mask;
> >>   gfn_within_page = (slot->base_gfn << PAGE_SHIFT) & page_mask;
> >> 
> >> We will enforce that
> >> 
> >>   offset_within_page == gfn_within_page;
> > For "pc.ram", if it has 2.5G below 4G, it would be configured as follows
> > - slot 1: slot->gmem.pgoff=0, base GPA 0, size=2.5G
> > - slot 2: slot->gmem.pgoff=2.5G, base GPA 4G, size=1.5G
> >
> > When binding these two slots to the same guest_memfd created with flag
> > KVM_GUEST_MEMFD_HUGE_1GB: 
> > - binding the 1st slot will succeed;
> > - binding the 2nd slot will fail.
> >
> > What options does userspace have in this scenario?
> > It can't reduce the flag to KVM_GUEST_MEMFD_HUGE_2MB. Adjusting the gmem.pgoff
> > isn't ideal either.
> >
> > What about something similar as below?
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index d2feacd14786..87c33704a748 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -1842,8 +1842,16 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
> >         }
> >
> >         *pfn = folio_file_pfn(folio, index);
> > -       if (max_order)
> > -               *max_order = folio_order(folio);
> > +       if (max_order) {
> > +               int order;
> > +
> > +               order = folio_order(folio);
> > +
> > +               while (order > 0 && ((slot->base_gfn ^ slot->gmem.pgoff) & ((1 << order) - 1)))
> > +                       order--;
> > +
> > +               *max_order = order;
> > +       }
> >
> >         *is_prepared = folio_test_uptodate(folio);
> >         return folio;
> >
> 
> Vishal was wondering how this is working before guest_memfd was
> introduced, for other backing memory like HugeTLB.
> 
> I then poked around and found this [1]. I will be adding a similar check
> for any slot where kvm_slot_can_be_private(slot).
>
> Yan, that should work, right?
No, I don't think the checking of ugfn [1] should work.

1. Even for slots bound to in-place-conversion guest_memfd (i.e. shared memory
are allocated from guest_memfd), the slot->userspace_addr does not necessarily
have the same offset as slot->gmem.pgoff. Even if we audit the offset in
kvm_gmem_bind(), userspace could invoke munmap() and mmap() afterwards, causing
slot->userspace_addr to point to a different offset.

2. for slots bound to guest_memfd that do not support in-place-conversion,
shared memory is allocated from a different backend. Therefore, checking
"slot->base_gfn ^ slot->gmem.pgoff" is required for private memory. The check is
currently absent because guest_memfd supports 4K only.

 
> [1] https://github.com/torvalds/linux/blob/b6ea1680d0ac0e45157a819c41b46565f4616186/arch/x86/kvm/x86.c#L12996
> 
> >> >> Adding checks at binding time will allow hugepage-unaligned offsets (to
> >> >> be at parity with non-guest_memfd backing memory) but still fix this
> >> >> issue.
> >> >> 
> >> >> lpage_info will make sure that ranges near the bounds will be
> >> >> fragmented, but the hugepages in the middle will still be mappable as
> >> >> hugepages.
> >> >> 
> >> >> [1] https://lpc.events/event/18/contributions/1764/attachments/1409/3706/binding-must-have-same-alignment.svg

