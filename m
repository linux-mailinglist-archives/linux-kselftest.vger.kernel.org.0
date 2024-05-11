Return-Path: <linux-kselftest+bounces-10090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3319F8C2F32
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 05:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49D21F2282B
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91124205;
	Sat, 11 May 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrtRSc5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84C17991;
	Sat, 11 May 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715396626; cv=fail; b=fCjZ4VNJh1j3fTAvqhkU45P2nC/3zdzJeAowi1fzXwUTNbTyF+GgYrN3Pxlr7FM7Pj/EMUekI+w0yrRMqINCtPNf4JnRr/pnOmT+gzvTuOShCDfp/nrRSZ0QPwrXaBIqSmeHl9Sw7Zc4MNtz7ymvwsN0HDPvxU88ZAm1lGTKNQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715396626; c=relaxed/simple;
	bh=KEu9KPruJS7aILqBRpJCouKhzSPNi9LQmjahLrsAN5s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z2ylFTiqD20pw85qRxh5YO2Y4ufMipp85+XPpF//MTf0x37+yIr8Z45KEj6rW4Sui/o9tUSO73CwWCZl+r9bIpWPF9DSAwv938S42NwCanytbWXDwU24f9ZtpE2IMgFrgn+GJy7dT35uNb3wLxSMwBHntMj1YvlqShejUjnuBUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrtRSc5R; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715396624; x=1746932624;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KEu9KPruJS7aILqBRpJCouKhzSPNi9LQmjahLrsAN5s=;
  b=TrtRSc5RoVWZjU/2qSNOBQnFKhVpVyZ7mJqwIpW3v33DwhurT/Mq1jNR
   xoDNw/xIv7AQSbwR721TU+0ZJtoQ/PMleUGuJ8kfb1GkICd6yMQhGm8K0
   F5Wf1g9G+l+xhiiqV6pqYjven7q/UzLjAVBiO1/pr+LrTL6Ui8g4qTsPY
   qMREVFKZ3CdOVmvbceft6pUzjp8+9CRguiWvNGZHz5SvC5eErAT7R51zT
   KiNcCyJxNVSDKy/uwdDoltLSLJ7tTdcg9WP1llSjwXRu95wa+g6uLe6oc
   gz6hcJLoY0hG4vSDePv19RWtX6u/KUvA+da4LlWj7Vb/9lXrDBGtB/8f/
   A==;
X-CSE-ConnectionGUID: VOGWP5rcQ/uxolBCSDxpRg==
X-CSE-MsgGUID: U0Bk6jmDRPWElPHT3KYTDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="15210565"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="15210565"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 20:03:43 -0700
X-CSE-ConnectionGUID: RbxzKIwlScG3WaTbHuyWxA==
X-CSE-MsgGUID: cft/hT7mTNSAJv9GzgVOaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="34244226"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 20:03:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 20:03:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 20:03:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 20:03:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 20:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihq3/HfA3M/yLXMf/V7ALqB7/GFXRiGHWiYPrS540vWtaILHxIypeaOeU2/9DpA2oAvew38EdvMxSPYcgGsgk951sAeIeLjQM5YQFs4HMApAxonEzhe4s2YpO9PO28JZrzuqxSEx69gFkNDT6EyZqAof4dh4S4c9dOqhq4kaHphraDLiF/wovyUNPfjYvpnPF2RG4qeWho7UW47LkLmJkLUe859oDErQuTlhUwqOG8oEN1GZ5YlmHsZYHqFr+lT0JrA1RoBMoIr5KITH7WFeJZqBnAB7Zvkc0gJQEY7n77I8E4aOdTd/1A3aAdGsXb5K4gBvEyJfij6YNCTBDoNDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqy1IOOM+qrmIBLqN8Apo4DdPnVHyw10T6N5tx22puQ=;
 b=mInQVKykCEA4w2M/kK9UfK+APjpoXmV45KTB4pkOXXxvi72P8ej4yAWg1gO3AwAOda9bV8riyE8z+pc9g7aT/tZMOnTCseW3zoW7JF8WWDiXrcbOqURymuMC+f36V3vueRyaZoF5EbecGUw7Wa3W21F6Bq+gN3X4z5jCCFvfVpY25+/BblxUkMUrWqzFw00cJXTkuS3LHMfLVduopKRKq00A8QkNTY7L52OzCB9cKYMnlQFOzCq8NcjEaVRmrY7Ld4kDriba4gqnDljFsABKLoIrLxBH020Kx6+KhoNBuvVO9HMOXt6a88TDbGqxqTeAqGdKX97O01HaswMrO0p+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 03:03:32 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 03:03:32 +0000
Date: Sat, 11 May 2024 11:03:20 +0800
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
Subject: Re: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Message-ID: <Zj7f+JWbVfIBIK8h@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-13-xin3.li@intel.com>
 <ZjBiLDJ4SdQ0p5xm@chao-email>
 <SA1PR11MB6734740F9B6085E0997A4179A8E72@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734740F9B6085E0997A4179A8E72@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: KL1PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::36) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ccdc53-9d5d-4d37-685b-08dc7166f109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bg8jt4b9mvDHld9qnpRgEI/KJASmV2xDXEm65J8j+jIxXigF+ZFbwbC8j8BY?=
 =?us-ascii?Q?Fq+XJ9iRibKyCFTe7REeEBboArIdxRcKDpth5/SyUljAFgrGltMSiJmpCB96?=
 =?us-ascii?Q?d0wj3rcQ1zw4aKWhoF6HNl615XWBSZ9os391DSsl/0Y5CMGQJjxGwYKe8ppQ?=
 =?us-ascii?Q?uqjPgB/39w/njVJz2sqwc9Sv0YwjXGXbNlViV0EON9Y/KDUd3dvLxndZKxsj?=
 =?us-ascii?Q?ziLDJEn4PHiyPd9E8dQuiy8EGC7MwYtIbaLhncwlV/J+dYx3mKW0YAMp+kbw?=
 =?us-ascii?Q?qq6dnzehXRvdHMAmHd2myIDumg5SvmDI1Vk8yBaIRRSMrhyOt6x69DxJPVFB?=
 =?us-ascii?Q?eMr41ldDQl9XlOT8a8k6QRBxBf6Y5N2mLgaYsos2HfDkvcV8RlnLtpLszPi6?=
 =?us-ascii?Q?/ocBruf+uejW7qfpB0mcWPE6ukQrpC+Z+t0Q0eH2YYy4pdmvbU4xoUU1bvPr?=
 =?us-ascii?Q?3ulnc6Roj4hTd1wbwpRhDmcSEomCCg4dMbi7hiqZ62VzN2abeRlDND0i/DOn?=
 =?us-ascii?Q?9NsMR14a9N0WGM1zAz7cTjs8N2jNl48LKq2hwTEkliF88pqhKQOhPeY3GK6h?=
 =?us-ascii?Q?YEGcGtddPiE7tm7gyPKmAe0svs8KUzc3mfwNg64PUg4EwVa5L14kfo1bo8lR?=
 =?us-ascii?Q?o1gJC4Jtj7GMFWQTZ895yeLt4UqhWC5aTjNLKrbdxsASbsSQNDqhHzXYx7OF?=
 =?us-ascii?Q?b2GIxLCekpN/ryBapn8jzcD+vuICt89LbAASSSVWB6sJQuuTx+dr6Ml1zpEG?=
 =?us-ascii?Q?7uWkNwFDOY6ivmmvJVGiQe7qGJa9t7HX8H7ruQknitV0QmoLaS4Eqi6jwhS3?=
 =?us-ascii?Q?8StrBtHfUsAYZyzsV9r+jsMi9rvPztqnprtDwgpwlu80FlkbgJHH8NloG0PF?=
 =?us-ascii?Q?kpsKU8usV7eTZzYpZeelGxIw2Bp1qp25l0U3cPuxzT8vjF0mLOEr4S0iCiSd?=
 =?us-ascii?Q?jelMlAiaGspw2w0yqkbDq1vsTdm8OpIT4CAdsWiTtThCJImYJT/psXKQPSXd?=
 =?us-ascii?Q?uKTiVUutq2NDVLZzrB4kwOOAyDNOYAW3Z7fDZt/iWmuim0j3xjue3Lsb4nVG?=
 =?us-ascii?Q?hqPj9eceXGTvBIs73LTogUuIBOi0MaNhBeq1UjlhDSA4CUG03iLogPvRiCf/?=
 =?us-ascii?Q?9oWcVsJNjmnsNmEz4ZiBqBgoi9yya1gUYZJow38bV/oaYSKWteiw4ZpTMgBr?=
 =?us-ascii?Q?z5sDU21ogKuLy+94NrBMBzDnV+glMEy5o4FP9AQvLZTEmsbNM5D8/5EFTUo5?=
 =?us-ascii?Q?7CFr0ptLu3oYsG0ieqRdOMtV61qnHb1azK2RH1cHqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AURRhxvqiFQOes+Ow/n/IoalxFlF38nYWSE2X2pRYmOIS2JWuVxfNkWO6nob?=
 =?us-ascii?Q?ZM+QXtOipQ5b17765gHAwwgJz4D85nIzXcLUdSpB8zHBJ+E8NP9dbG9my/FB?=
 =?us-ascii?Q?Sl6oU41574Wpe+ZsJpP/tdm5HIMI+V7oLPQ3mvus8kgh9eI6mms+KCyjrpnZ?=
 =?us-ascii?Q?UlPWnfuVE8WJWPsGQ7hVzbyJ7eFmfSrmf2PP2yjDKxOAATPk6hevH4mwdtyL?=
 =?us-ascii?Q?jHHTWoYzdWkUt4+6hMEuCe7Jli1mepzsjYR3Vul16rFOb6+dd5XkB9Dm5XN6?=
 =?us-ascii?Q?+C0/pT8DM2y+VBYXABPVfAj9rLwGF91nSXXD/g0yw3XpuVfBcEOySN41c65x?=
 =?us-ascii?Q?ewCvO9gWJMp76svOtA+LGgdBtxf36Ysu9z0w9Qos9cbpXGwKUnqGMUOkfyYu?=
 =?us-ascii?Q?wy2YhTXQ+g18VRiwoVqmMrSESvLtxyk8x0GODrJjiOm45hYXmy6xrmdbFuw0?=
 =?us-ascii?Q?V+Sdty9wnYIHkwME2Gp0wPLdrIxUreOrPzu/iaffR9IfGF00rgwuufHhCCpJ?=
 =?us-ascii?Q?sdxmB60+ne4aUq199C2P2Z8FUdmM8DZ4l3M73nG86ROzLpDUbcHa7VX1+uBA?=
 =?us-ascii?Q?TZXfVNhT8EkIlCWrcafzJQPLuftJApQ2BirnRaQfLUKeNV4dNDLqSZ/ocWu3?=
 =?us-ascii?Q?fKtxS1Of9bB1Mq8hFZqwR6twYg3UebSh6IlkAynhoZnXa5R/hy24cUveBUt0?=
 =?us-ascii?Q?gQaowR6+USdXlk+aWWYkm0bdAtE4qEqNi5/atmnd1bqH8o6+6iBFDrbAa5+S?=
 =?us-ascii?Q?QtYQRK9vvDSqNoqYzFJy+T5/DVivsqBAnRCgafiuRZvnSOXX8xkQpx+M5yYp?=
 =?us-ascii?Q?iWUkloo2EX+9GF/UiBEBxJABmECFSYFTUdmx583NEDdnaWPyYCBjEjBsA6WC?=
 =?us-ascii?Q?HG2uQdu2wP9YYyYvRZZYB2uPrXZHxRnVQK6J3XyySB0eUhe1tOsf0BPbOHqK?=
 =?us-ascii?Q?aTHZ3b3EqqDzsD2CRIaYQ3ZtC2KcRE0GgIhQgcVBG9p5uddTC3W9DsVlW57K?=
 =?us-ascii?Q?xkAjyWZoniDg8ixAjPIFL+GbNcB4vMQKV4p2YHNOSPIMTotkMZSgZFIY9lQ5?=
 =?us-ascii?Q?DbZuBq/MQwLFG14f8Tv6oKygZoFePKKmuE0uA6BWe7eEUaHtTwZMcxYkXcMu?=
 =?us-ascii?Q?mNzFKChc9tMq/SuS14h1IkxOPsSEz7Scf2Sh4d76AIdDGNOBQ+R6luS7VyI8?=
 =?us-ascii?Q?R8+QiJUn2WMU3Lzv1NugrvDolcfiAw1X47ovZnW9BBmI7jLC33Vdzw86GlZc?=
 =?us-ascii?Q?VkyHjq1jeWwQR7728CH8En6k9FhnYsuQae3AKEb3sl0hAGQbQvJYBokuCgQ+?=
 =?us-ascii?Q?ukqBBT8pRQ3kO7JJiiyh7NCOaLUkn00CunSXdDzL45AfXj+NDwBzRJAwruI8?=
 =?us-ascii?Q?PP/twalpL4VLq1iE7aBIVHn02yZA/9UyzYQzqvOcFEid6SJXeTh9+71GxNmA?=
 =?us-ascii?Q?lzaP3UVRrkJK2hFZuQjwUwLFznWXoVMYeX6o1FrUmC5zeGGE9EpQnPbCD/3n?=
 =?us-ascii?Q?GMy2KB55Nr1s6LQ7rl4Eme/SVJh9FNwI477cuF2stglxt6PRvbFjtf25K3LS?=
 =?us-ascii?Q?PEY/+FVB5nlKxhPcRmmh8zHpb8YpxHWunMFPFi/X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ccdc53-9d5d-4d37-685b-08dc7166f109
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 03:03:32.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ///kLhseuTSQ0RPy/moUnXDJ6iRiKrBnqVOAohLQnGAgxcKdBWLWU3cbKGtfyQH2UiShUe8yQOWK3ueZ1D+1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 05:36:03PM +0800, Li, Xin3 wrote:
>> >+               if (kvm_is_fred_enabled(vcpu)) {
>> >+                       u64 event_data = 0;
>> >+
>> >+                       if (is_debug(intr_info))
>> >+                               /*
>> >+                                * Compared to DR6, FRED #DB event data saved on
>> >+                                * the stack frame have bits 4 ~ 11 and 16 ~ 31
>> >+                                * inverted, i.e.,
>> >+                                *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
>> >+                                */
>> >+                               event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
>> >+                       else if (is_page_fault(intr_info))
>> >+                               event_data = vcpu->arch.cr2;
>> >+                       else if (is_nm_fault(intr_info))
>> >+                               event_data =
>> >+ to_vmx(vcpu)->fred_xfd_event_data;
>> >+
>> 
>> IMO, deriving an event_data from CR2/DR6 is a little short-sighted because the
>> event_data and CR2/DR6 __can__ be different, e.g., L1 VMM __can__ set CR2 to A
>> and event_data field to B (!=A) when injecting #PF.
>
>VMM should guarantee a FRED guest _sees_ consistent values in CR6/DR6
>and event data. If not it's just a VMM bug that we need to fix.

I don't get why VMM should.

I know the hardware will guarantee this. And likely KVM will also do this.
but I don't think it is necessary for KVM to assume L1 VMM will guarantee
this. because as long as L2 guest is enlightened to read event_data from stack
only, the ABI between L1 VMM and L2 guest can be: CR2/DR6 may be out of sync
with the event_data. I am not saying it is good that L1 VMM deviates from the
real hardware behavior. But how L1 VMM defines this ABI with L2 has nothing to
do with KVM as L0. KVM shouldn't make assumptions on that.

