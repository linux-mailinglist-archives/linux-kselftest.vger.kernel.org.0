Return-Path: <linux-kselftest+bounces-19119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718E991C67
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 05:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF8E1F21E25
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD714884C;
	Sun,  6 Oct 2024 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaMAPRqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B812744C;
	Sun,  6 Oct 2024 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728185708; cv=fail; b=ja2ZGKpYATU/Du+X/mPqepwheXCKnP5/Ehs/3x2rX6sgtf/d1CYuaZV0Xq9RU1RvQIAYLxUhzZDQ+NZ6n+EF1Qv763SGRwnFO6IEF2AxDDRsHSjx8NAwRNMPct++6oKA7LB2xjDebFsMMHvOlsbdRJRzgkme3upDksoMqI6PqHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728185708; c=relaxed/simple;
	bh=IiCOU8mWu+ZEB8mcMPDonthNv7Qpdf9AzOKD3BV06Wg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MmkijtVrP8EcElLHJGr3U1OwHwYMTy9OcbbLs9P1vJijM61hpKUJbNpMqKwhpGJbb7xLnvMIYq+/us/E+KiGrEuq9pMXRtdQpm6+ovL0+4YDN+Vt7s9UejvYEP7kB/9lrojetqEJb9+VG6uOd2gm6HsrTp7B8JCu8xKFJQzXxFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaMAPRqT; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728185707; x=1759721707;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=IiCOU8mWu+ZEB8mcMPDonthNv7Qpdf9AzOKD3BV06Wg=;
  b=eaMAPRqT9krvqslqflNN/2kkT2JhXpPoaxmtEwTkiAX7tdRorqnHlP5i
   oEFK0uXALiLAg7KZ5ykiqdfA+MWlCaJzLAeSajNRtBnZNUIvQDOykXoHv
   EnDdmGVITlUH0d2Oe8PaO7XQ97Ej+IDp3/9ZOIIHrEadIOCc0Q/sjr4lq
   ZYS8tph6KspMAuNeZmu5sk6SavL5J8qJ+Yu68pLN26+r/EAgUDI06IbS4
   NZWSr22tszq4XwQ+aQcmM3evnxf972kTzVuqk6il7Jszl11GfwUkT6tRp
   F+yfARJvtzi7VcJH9IHB0O69XENAoXUkKA/7+6G3O5IpLoeR2VMjBmxne
   A==;
X-CSE-ConnectionGUID: 7GUQnP/9STmViliq1ClcOA==
X-CSE-MsgGUID: ZMynWAXBQOezieQcQniqog==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="37932440"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="37932440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 20:35:06 -0700
X-CSE-ConnectionGUID: +rW0AL4LQiSb1K4NdKD8sg==
X-CSE-MsgGUID: k+44Kj6ZSuOxO2xxu7pK2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="79523306"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2024 20:35:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 20:35:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 20:35:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 5 Oct 2024 20:35:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 5 Oct 2024 20:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYut0HolGE/VCsbbE02cMQbJrQ1BUvyPNBhSnscXcT8NTo6E4VQDvUEnZpzEfb1VGZeRpTaIZ7DSC12h1/aekNmOCnRTzdYYUYgNYvftl4Piz9jiZ1vhTYfbydE+t1Q2tviThxfY2piBlRBwrvvEW6HqF7DqxG7jo5gbxa6luVoeBWI3ptmrXxhUCDwTjbW/FKJEmNvNkbboUVLLwGwXMUY0IwKCN/FiMxqoWM+aeGURnXAhbgpqPeg8TXUtccSa6lue57gedJcENpCehCB0c2Dv6dfGzlJY+Cy0x0SVoXPER2/sI6Fmsc/sCgDZbX8ZW9uthKVI3nmrgFHQf8RZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8lLX/IzJrCnvGzpyQZaDjDY2Zv2ox7jCAa4FNiPVqk=;
 b=x/fWDKa8LCNFrEVtaXHo7UAmwIhbKzMCvurETMHwMxuOuk17WqP1zZTrPmaQbK37Q7hcnG+Ha5j32xFr35581hOe0fW1js7Mc2K1d4Ow2Glmh/oI+J7PeBx5EggFDpnKGiz/rUY+ihkizSVX6Jxqk2lK5isjAsRltMUIw9Dnt3ZNI1YW9duURFi4aMT/PPhugC08pCFGD4hubVwJ1vxLkKZBEo8tmKsUlmMtMZWHMD9/JAXnJEuYX3wn/RLxVYSzu+sc1Od94iHdi58OlbrVYjd0NTa1keagc4+iu5QuJaYsrFbkxpJCF7tZAGVBWtaIZ+9l/7+mrA4kP6DrI9Lq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 03:35:02 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 03:35:02 +0000
Date: Sun, 6 Oct 2024 11:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Manali Shukla <manali.shukla@amd.com>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <shuah@kernel.org>, <nikunj@amd.com>,
	<thomas.lendacky@amd.com>, <vkuznets@redhat.com>, <manali.shukla@amd.com>,
	<bp@alien8.de>, <babu.moger@amd.com>
Subject: Re: [PATCH v3 4/4] KVM: selftests: Add bus lock exit test
Message-ID: <ZwIFWq0Xj/DNM/Kq@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004053341.5726-5-manali.shukla@amd.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|LV3PR11MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: da7f18af-14f4-4343-5f03-08dce5b7dc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e+ZH3rhXK29829Eu1fPCT8yZ0w0ZoNDKAQmgHrCMlScwqx9F4q3wmTyuIK9j?=
 =?us-ascii?Q?hjmJvT4uwoNy88DjOg/WKcV86+JschAzmYpQ5ybEBs/4d4gJGOm5fR7XSvuH?=
 =?us-ascii?Q?EztAE8DlNvocCyvN4Z9GYqZBxqB4nhleqoT2I3rH2WEb3ND7BvAdezVC0qqS?=
 =?us-ascii?Q?+Y/ccWVY806HEoIcEEhkRyftEWn+hnSqgt2ai9lR9YZH6riItJ+eBdydAZu3?=
 =?us-ascii?Q?1L95CQECvmrqaEBu4nNXtYQiqw0aUn6WcESPpFyZTsik33PJJieIFvU1aduB?=
 =?us-ascii?Q?fPdPlV7acMb94ia49uFP+O1N/U6+U2iGYMDGugaWj+jwffzSvMTG7K3ZWXRu?=
 =?us-ascii?Q?12xvQNIrCWy2f5+QEA5zcLKOab3aA19HvBrRQUa/fltp5rEFukNlTyaCA3Vs?=
 =?us-ascii?Q?kCdVgJyfElvoEjYDDQVnyvaUYkLTapNKFAg/wmIYMSwlYQqM8TDUxor187j5?=
 =?us-ascii?Q?2x85awMyZsUMhU1gQOA4smC6IuqMf6zLZh1J4p97mPCGpfMA3pQkGmpChynJ?=
 =?us-ascii?Q?G34h7+UX0huc2AT9lvkw4+kdIr2/esFEnQF0dswK5Qy58mCOyB+nE0pcDegD?=
 =?us-ascii?Q?DjrNWOhI3ACbCFmPEEbp44hVz2BVJSOGFL+YkgCMIGDqNB2lL9M5tIp0AxoD?=
 =?us-ascii?Q?BsIX3MTU1c2Ps/1r+EATytsVAzbFuYvoTpklNRYdMNI+JfwBRd3/h4k0wGy7?=
 =?us-ascii?Q?XPPutuF/aE0yV37A4xN4N9ztmrZWsPMzMYfSD78x8BeLAxNHu7J+bU5V5eNE?=
 =?us-ascii?Q?PqEwEtJ8kYXlN5aRqdMcpCoJcqy7hlIYajEd1c+rIZzjAGDzwC2/GdmcF4Az?=
 =?us-ascii?Q?CsUC2B+/mflQNNVnd9IsnNJNYKoBqAlb9SSeSP/+QboVYAE6IbKgT92fI92U?=
 =?us-ascii?Q?kiRTJSWz1mZ7dJRmIV8yGhW5bhXgpFoDQKC02taaJM8Ijyf7BZ0tpfKDlODJ?=
 =?us-ascii?Q?3ja4Si8ndrhivD77bz1u5km59az6UInlq3XswJfQZHte+DO2rJVJ0XPU0blR?=
 =?us-ascii?Q?JGVNU2BLtbmXrRzJnX0TcjNfz7Q431ga6QcYKzm2Htudl1rXp5ApcMFEfr55?=
 =?us-ascii?Q?T6kF5VUYl29mR0WPHlVBgqFkh2exxbLulREt/W8aa4wnLqfZ3KhFrv5lUmML?=
 =?us-ascii?Q?+1F/vvDX/VYafUYj6MqU9qqGlARLbbmTAp0Hkm3TAMFvjG+GJ9Epbx7FNFuw?=
 =?us-ascii?Q?fMjnkhxqtzIaJq5FgeveG5tphXfvbVDhqis7uhbHjQx0gel7gZ8KuSoKI1g?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7NwYEL/UgPrnmaMzqmeG5khBeoy3dNiTgnWpkGGY//T/y00XfUgWqABiDtWx?=
 =?us-ascii?Q?1SGARaPoqPVJ3o7F6vrhtCC0gX5vkIO7Ol+RX28zJUnE1ZkzDmNJhCeMay9a?=
 =?us-ascii?Q?87F/eBzG7JU2pZ2r5myEGOXqrrJ9z1I2Ut/n/2w+28myoNxsvhUejMH/MRme?=
 =?us-ascii?Q?evcujcEQ4ZruOHr8Ngh4GBm/1X9A461j87m69qN3LYf8uVyjyu9A6CGoieiR?=
 =?us-ascii?Q?mFFKSIg7Lm+8GbiX9L9nUaAftVyOvrvvLTPqZe70bJy41V1Rtzo61uNMUJe6?=
 =?us-ascii?Q?f7j4u8xr6ttta25lOmc50W/b6gr3JXtVP1j8tJDwn0UlF7wRJwmaHAiBmWRD?=
 =?us-ascii?Q?2ga6kgVl9rl3X8zjFL8G9gavyM2dR/QTN878T9qD6Ol/T3D30uXBw75yu3r0?=
 =?us-ascii?Q?HtKkhJjJj6Hz3nKCdQigLqxRC6zfpSN38lvStOyvVzPyloG4wPmWM1C3tyP9?=
 =?us-ascii?Q?vrzLDccs9RDwDbUJ4a5vQ/lzCwLnbZ+WFamgjlhn7s1gvqSx3N/X6qBBxRCc?=
 =?us-ascii?Q?Ri+RpT1xg0osXORrPDWZFAfY6e6N4kvoNkom3pUioRGVjZJ1fMHuqCN8CQt0?=
 =?us-ascii?Q?Wcb5Wt1Fv827JIfMXj6zihDnZDUMm1ztBL6bTTOs4/ocNiWLgnULj+HVHhyL?=
 =?us-ascii?Q?Iq5aVM3TK117zca9PGn5pDmMXuPgZa1wtMjFw04WrJXCi757Krn/RSFbt1ju?=
 =?us-ascii?Q?nDCw6GBQDr3XiTkWJLWq2KL6SXBO78CRyazUnGZ4jin/k/o1kvzuB2kkZ1c/?=
 =?us-ascii?Q?yiI3BqpXSQm8ckOzLN0uzSfJDljffvgyEC4LyzsGl7Qwe9IHMh7RY+zjIoWa?=
 =?us-ascii?Q?Fgc6tMfxEPdjRkv72YROsg41W5xFzxvO8i7bbDlKBY5XVjG0jZ1ldHG4b84P?=
 =?us-ascii?Q?F27A1hO6uK53E5EWlf7nvwdY86Nl6hEBIwDX6pyQqGFRTVnCOCAOVM4ca1KN?=
 =?us-ascii?Q?/9BpGNUrxrhQc3q8GslJRjJ2wGgEl7aJ/836B+9ccEPZ1ChYAr8UvUdujMpJ?=
 =?us-ascii?Q?ZtpP3gFnxMkc7And04FbKGbZvUzbyBfmNe3Yb3AJcRjBu/yJhGDVRAZRAgq8?=
 =?us-ascii?Q?HIrYNnhCQucyxD1Se/WwpdBHjZRK3JECEGglgsEuJiI2+6Y7sFKMeL+xA6jq?=
 =?us-ascii?Q?2p+vLoTHwqXIKHPgUQqVxv4B3PdM2YGiQU0ewfNBqZ2bJCRhr1DRDJ4SJIe8?=
 =?us-ascii?Q?fG/WeK5z/4YMd9JTuQNh/GD59bhBMOVj0vXD5duoV55Pjf+a+fTAlOThvWCX?=
 =?us-ascii?Q?EZC7UIoxZT9WcqQkFhpfUxHnZq3ZKR/qrDN9fmK0OJt3PyKI2E/uxDSYwL/h?=
 =?us-ascii?Q?E+5Uv1VCzCmJvbIp3x4FW3B1xydvf4hI5Dp1lawUq8avGw/Qg0AWB5STz4iT?=
 =?us-ascii?Q?SvC6hUME5fBaIUIfaFKcKTqFSFGFNVO312rx4AydSjavpyWsg0QOtxmH0/Hq?=
 =?us-ascii?Q?h6w+5FcsNOyHR894Ze8lnBNr/m6Bshk0UZ4sfizJNAgiwc6399Me2j8vMsca?=
 =?us-ascii?Q?uPsSp4TW/RmBqpVLhngkO9wz3GpQ4+4RZ9m2qkeT3AYTZq3EzjujBZotfksn?=
 =?us-ascii?Q?s56ePDnxyaoRC2iHGXK13fZWwo82PE3M8grWDlLE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da7f18af-14f4-4343-5f03-08dce5b7dc5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 03:35:02.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiQNit2L8nzYrYI7q0u+nBe8g+fIU6OFWv0WSXXxJ819tMcA8kh9s2AZZZTA729ramTfig7hxQBx8uZ8+qXN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com

Hi Manali,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efbc6bd090f48ccf64f7a8dd5daea775821d57ec]

url:    https://github.com/intel-lab-lkp/linux/commits/Manali-Shukla/x86-cpufeatures-Add-CPUID-feature-bit-for-the-Bus-Lock-Threshold/20241004-133639
base:   efbc6bd090f48ccf64f7a8dd5daea775821d57ec
patch link:    https://lore.kernel.org/r/20241004053341.5726-5-manali.shukla%40amd.com
patch subject: [PATCH v3 4/4] KVM: selftests: Add bus lock exit test
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060638.ZXRqIbIj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202410060638.ZXRqIbIj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   x86_64/kvm_buslock_test.c: In function 'buslock_add':
>> x86_64/kvm_buslock_test.c:36:39: warning: taking address of packed member of 'struct buslock_test' may result in an unaligned pointer value [-Waddress-of-packed-member]
      36 |                 buslock_atomic_add(2, &test.val);
         |                                       ^~~~~~~~~
   At top level:
   cc1: note: unrecognized command-line option '-Wno-gnu-variable-sized-type-not-at-end' may have been intended to silence earlier diagnostics

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


