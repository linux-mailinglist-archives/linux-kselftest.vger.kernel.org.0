Return-Path: <linux-kselftest+bounces-44248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12949C17C92
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 02:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2FC3B5104
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 01:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3F2D7DC2;
	Wed, 29 Oct 2025 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmhxA6eM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159318FDDB;
	Wed, 29 Oct 2025 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700259; cv=fail; b=JlPa76KJOILoHOJTRqwrwPGPeqcK2e9kja1JC+/gPpuC6EpiyP1g+PWlE1YtSzXgOFodp98jrnj8rddgJGq4+J4PNK9u6Uf6is1TrB41O7XTCn1ntryJZPwjlsZ4BB+UIScF6ku3R37+jHxCrEH/IFjoTdu34V714O2mCBuQg78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700259; c=relaxed/simple;
	bh=qcc8w3j6yQ/pFD7K4wg/7gW1yr1Z2ULhBFNAyVjNHEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HQvUypSaSzIaKRVVfQD0Ero7gqcvMQhwcArpSQnic7v/J21SiwfAqevplbxyUqqW2w8iky0/wXYu7tTfHtbyeUpl77A94lr/GHjpq5RzH4MR7wpavq87cJY3tc/K0p66PNSjTFzfPoVfThA3xmZIpX5+bctnJhs0BbbQiRC2JYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmhxA6eM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761700258; x=1793236258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qcc8w3j6yQ/pFD7K4wg/7gW1yr1Z2ULhBFNAyVjNHEA=;
  b=YmhxA6eMrN5IYA9oaWolYTxMnK6ewhQKRKe3T1LpbWtWYXeYwjD9fSKv
   CryU+DHYh16cx/db4GP1Aj6qZg8C3Q2AmVQscN1Tp80PyHwt0Ot/aMDjO
   HeNNQTHTN/h/Bg5YkWQ0VnA5zhofng7ee1ZohQFwVYwEc7JcFxheIgUOt
   zMgodIxtuqd3C9dhhdc2w5WdY7ncaXE8lGmzDVQT/ImgCUz9jjKYYwmYp
   kkIf4rJK3k1pzV3razXInzIHCQD0J/Vs5kc7gzac5uXM/c71qV38LS3wO
   DGtb+HMDY6AScUwo7i+Zw2mLKwk481PBhXB4Tm5NzjtmmfYnvAbzo7W0n
   g==;
X-CSE-ConnectionGUID: C8yX9eQJS1+Ysbrl7qr/DQ==
X-CSE-MsgGUID: /Nv6Cq5rQ5iMdrfRCgpVPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74103581"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="74103581"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:10:57 -0700
X-CSE-ConnectionGUID: F51SaAKmS+KMOyXw5bACeQ==
X-CSE-MsgGUID: GoU9FFcLTquUd8c4p8T9hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="216160260"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:10:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:10:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 18:10:56 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnPCWr8CrcvZMPvMyTZ59wy9kkUGNVF+Bt6sbSFbgX1KN5QEBqP+0sakCVkmH/GdIX2i5OmlbJqgnq73U6LwbDhzgJpXeeoTOOOnY8+AyWscGgTixNxZL2nIMm1QtmZLuqB7agCNTrrMbMgMVwcadOckVQlmlA36j5GwyVcCbVWUvD0WfPftzVL41nw48f1s+2zcaBIx3QC3yxZOwXf/BNBr3F0HLtOMno/n4L7djlQpUm/cbv6Np+GMUjND+YFpgVxjgAAK/ftWU6rscBZAQ+h4cX+MRLD0pQwyIaqHdue3jkTWtkrEAJvHd3GwnfcPBmXQSTKwISEdjR8tt64k/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jesImxABuu5wg7SgbiYOcUb32opxe70nFe+/8+trM/8=;
 b=C9fwXmSVzNUW1XFFXvURMSaj5oa/br7mLnSxMxrYzLddP81VqQVOeb+ChcrGRB9vm3VTSZ+j0sFCQQyRnvbVvzbbf5Jc011vTCYuqoB3QLZ54YquL3EzildBRf8TgKHbVqIlFmrNU2hWY9lwdMmmKusDHV8+YtGv9mseNkiDFv5uKAyMXCLedGyn2mIF+6IXGwIPxLbsArUnp6AcUnxYNgn9+oucTYtXLI55dtgeS5Cm28My89j9DwTLkDTebxMqXB3aSBUQMqLDQ/t9MpXEs6VGomk77dpnyyIn0t2a7nA/UPUQkkfhbQDMV44noa+hGED9CXTT0OWnnibo24ta/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BL3PR11MB6412.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 01:10:54 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 01:10:53 +0000
Date: Tue, 28 Oct 2025 20:13:12 -0500
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
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 01/23] KVM: selftests: Add macros so simplify
 creating VM shapes for non-default types
Message-ID: <69016a283e832_206050100e0@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-2-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-2-sagis@google.com>
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BL3PR11MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f0621f-e08e-4696-0348-08de16880182
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YfjM+DW9Whb46P6tlNcYN4viDj9k5in+vVjwh3XuPEafM+AUwru2x+UMXvWg?=
 =?us-ascii?Q?9nkNhnSLWB+00k4QQxP3CKCFJEkX8DH80SY0bZE4IRhik7HzqGAg6kCsSD+3?=
 =?us-ascii?Q?Pi/ED7OnC4PCh0Az5z0ub3kQwWAxJjB3GVnWPwpNdE/w7qWRZzw9Y5wV5qtZ?=
 =?us-ascii?Q?Ky0THFqdnClLefVQKRUoA5Px0i7wu6ySalpoI0WdUrT07MP5N2wlkI12QUuC?=
 =?us-ascii?Q?apTlJh1Zq8EA7Vh3nHtqd0BlRn4HcN85k8JYnmcdHaG0tnqYnQW6RXXS2Xr0?=
 =?us-ascii?Q?UnXMp2bKY+EUdQ6zw/Kgrj6C6F+D+/65+VeRZ7rrR0wDnjX+Ym4RfgYS5Pma?=
 =?us-ascii?Q?shUfabqmYCAhG484lerIIyDdVlGGrP1dlqUOhHIaLgOkEnkNU6Y1jJekEGM3?=
 =?us-ascii?Q?hJx1/JwCjNwJk18azmOWb6908Q9NVF2/2qMo7aW3DF4WrZo5i0Owbp+2nUX8?=
 =?us-ascii?Q?BdBEp6xaRYqRmJT5FfPxjPQqBYMgJy5cDL8JL0nGuwv103imgp7vPDbFQ48t?=
 =?us-ascii?Q?At7yXLmsw0+k3UVf3fd1VDzZAJLW31yKmb5DDO+K5pTOOESNaLWLoPSBXs2t?=
 =?us-ascii?Q?hfvOb0IruuqKjIcF3x6y1bAo/nHPNOxJ0lrw4yZe7Gm70lMaxVzFjH/DDi2q?=
 =?us-ascii?Q?yyoSlTqL94Bge1yS0PJGBa436khbZI+AGRxTtcH40++1mCv2R76mFi+zReB3?=
 =?us-ascii?Q?TSbGwXingQi1XOxxZPkdc90Hx46T5aj8w50zscNJkTLul/RlDiaj+Vb8wxFV?=
 =?us-ascii?Q?fRMkLkJ9e349L9Uin+QalgV0LkXo6Gm2UzqRj6+X5yfzY43GqtLToIVFjY/s?=
 =?us-ascii?Q?pCWZwMI+Zzx72kRxJQsvPQfrnM4Q1KYI9nLcedsToLMFNK9bzONwtltaLEqt?=
 =?us-ascii?Q?uupbpJXnTOjeE4djTtcJRJtZawyG8MHiDAV9B3A2bZDGM3xcbGII+Dq0p9Jb?=
 =?us-ascii?Q?EypfllYE026jdLHenk9H/DxS6EWNPZi0RooFwWSAPrkrvGvq+MBZFJ0l6ezt?=
 =?us-ascii?Q?nAzWvdaaLGU9SAMS8Ky00ZwrIfgevIYC0RZm/AXHvn3xb1dVf9KXRarsB7FJ?=
 =?us-ascii?Q?G42L1mD917WkTt6HbXtWHPu+cu7+0yG3nuU3vayFmEZusgMkLkkGPvggNMw1?=
 =?us-ascii?Q?rF17tI4udg2eD6uTNWEn8BAk1Bc4KoTMPYPc0Z5nKgcCqeMYOG+N/sKpRU97?=
 =?us-ascii?Q?1gtOdLIjMbWhj3yiK3k1JDCbGzZP/ubcKWTJZubnG5s7B+0XNKAkexzA6Hu3?=
 =?us-ascii?Q?dC4JN1ToXWwOyDKp91j7Kjrtwr3bjUS58T1W+ZxuBrMD44sFRH+aPhFGtKfG?=
 =?us-ascii?Q?yQO4UB9cb0zLneaWqzb6GgMz7JfwACK8UfRUf1rgDoFjfCroZIt3+FaroNZq?=
 =?us-ascii?Q?S59399emrJd6RkJQa7owDsF3HjjrphbUyBXgigZb2zi59493XYhV8ccmVp7Q?=
 =?us-ascii?Q?/9d92L7lO9TmtNFOZCSlka7oCEkzAPtSjqT9SDHfxDVgz7nQ0SHUOItJsjoP?=
 =?us-ascii?Q?/Mj0U3iR9odz0Z0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RW3CsbUcgpTI0n++oS0mDKKx020BteUtxfkUBOw2mBV7VPrfg6Nf5rfxslHy?=
 =?us-ascii?Q?dvdvG0Y/n1VAdV+i2uVp6Y2z6m0ugI/LzN5BoxDDQv1BVnzgiOumgSj0dJ9S?=
 =?us-ascii?Q?vaA0XPUDt4dGHFjqFA9rnsHlRrNMK2LDoL6yK0kscwug27YutCfDEimFWetX?=
 =?us-ascii?Q?unK3sg1+lrcdtZiqIGRKL2qh3bSLylHVI2SOkE56byia/ov6d3PxufOO4lwA?=
 =?us-ascii?Q?iYUG1w22AsIs/iaF/OZUj/N8MS7ggTYKldruFWF80nbPCE4MEFH6zfdWC22e?=
 =?us-ascii?Q?KAs47OdXnk4/VngoHbdsGVieaoDcRtFi9aBdj65k9p7LXOLBsju5uilo8FSc?=
 =?us-ascii?Q?r26a+ZqirAJLFu0frj7y6Tj1TOY0mz56JI44rNkEPtrmBDJM3/rgRnrzxJeO?=
 =?us-ascii?Q?w1vuL3hcdPmRJ3ihFgs5encjedhszcUXX0Mfq7M8WvMGk5T14gtWD4/shRu7?=
 =?us-ascii?Q?LtY2gnlbSij8JhbfhRLikrKoPVxzxLSDLvcTSwf4y+wfk4B5y6RMtdYNXNFp?=
 =?us-ascii?Q?uYCafxCPRMPL7r1NhnEqTlPY7ZjHqsJ0vCu671stY33iFe1OXP7hInOWgt10?=
 =?us-ascii?Q?/mWHiZSXOfyE2IRh41TQOftwTNx+HShqY+12sYRoCAS7D9Syu70SbfBUdDUG?=
 =?us-ascii?Q?KajZ9w60DuvgdiXZhzsk37b15nUViCPV9C+iy8cPg7biHWW06zWSINBDIO0k?=
 =?us-ascii?Q?fCUBROQNshi2gP4Eho07m+Z1SwBcdJITfIS4wrFQGzyVcIGisjzQUjF3FiGh?=
 =?us-ascii?Q?ojoSs67btNCMLigqXPjW3kEEesq6Zjjl3WK2rQk5/x+JTOzBIkauE/Ir93bt?=
 =?us-ascii?Q?jBmu+0EOEOUMxorPACqcFfk3RyjdPA6qxdY0holu6jES10wfReMoNGO/mq47?=
 =?us-ascii?Q?as8e5pN0haGlODiRMXIumXgrNpNbvCmH2OTonzMGflPkL9gcieJ3uyIF4VCP?=
 =?us-ascii?Q?+m7Yfun9NBXMa2lm29oHTJ7T4BxSksrUWArtq+2pq6RzqmvmSkAZxPJygMsZ?=
 =?us-ascii?Q?aDczdpBFrV0Haxe7DOcX49Imbv3oKipamarKX0fG28J4B9aGZLN+d6nFdqU0?=
 =?us-ascii?Q?FykK9FBX4TwZIHcFa/nx7q8xPh6MoxGxJe+ErCCZC7NCi9B0pg4zD/zYJrR1?=
 =?us-ascii?Q?rIk7YKdCMwDXxu84ajxHNl/e69eA7QiF9X3CuEuO6saLx9QLWaw4pRx3fJn5?=
 =?us-ascii?Q?L5Mdp62ZpXdBIK+b0rJGoYXWfEqkIQPnQplGqjAsfc8miJNZi/psfU0dbe5h?=
 =?us-ascii?Q?RQ3yMJhMihJFygdOrPuRyKBfj/dLxoxmjqMlp6KVW1YVYPFbDvFfo7zsP3O0?=
 =?us-ascii?Q?cjn96eFX3gBbq8xqhAWmvX6pahPBUvsxp6Xop4FUIpbVvoIVJFfufbf05u1y?=
 =?us-ascii?Q?HFpA+UG/t+RSoHgHEh/CXLFvybYlQr8pkp0DsB7FQeRNHmwqZv/Awe9R0nsx?=
 =?us-ascii?Q?fsDBrLE8N5O+UIR/UDJvMb3p0x+wlTQ81D9rVkSPpbZCOndqJsMpT3GGVJw4?=
 =?us-ascii?Q?gTalb39mp2sdHAOEh0Kxems9h09aaARXjvQwBGx1pS72MdLme3/PpnrRSrxd?=
 =?us-ascii?Q?wr2QfJB9u+wl27tur1lwou+h9zrQJe5Wwce5X8l8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f0621f-e08e-4696-0348-08de16880182
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 01:10:53.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9dwjiWhOElho3G3Stxa5NyTk30FctFra7Sw+e1TOFrnBvD99paX7qRdSwA0s/VkHfMe5SeoUI9CdqHpVn+KXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Add VM_TYPE() and __VM_TYPE() macros to create a vm_shape structure given
> a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
> shapes for x86's SEV family of VM shapes.  Providing common infrastructure
> will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.
> 
> Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

