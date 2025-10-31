Return-Path: <linux-kselftest+bounces-44523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF3C259D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEBE1A64177
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8BC34C9B0;
	Fri, 31 Oct 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSaBPu0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9934B430;
	Fri, 31 Oct 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921378; cv=fail; b=DN7FKaYP+2O4RjcQ0pG8hFJVbj6Fo4HCUYNU+76pvQeKxvKKOjTliW2GDjWzpOwHZxThzejS+KLU/Jcr0rstLINsyrld/QBK5mTVL2ZUuJMsPbg1QEBgu2CZZmyGvc5FOOrL9zsdB5B551QuGUC4XWJA8W/Y/QOM+Fzki+4nH64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921378; c=relaxed/simple;
	bh=G6KU9NFRSLdIq8IbgY6vusBSz97tLJpKh6ew1ka8HVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fpmrqjIL0vklDRpN5z114TmtWbD3rW4d9/FpVkCyTL/iB3eKZh0xY2q9kLho06N4tdlpvjw1eMlOTbZ5bcLEQkAPoyAoOnk06oZNzj9cgEAiIBb7F6QlFmZr3A6B3tdlfqZilkvVPonm2BFvau9XapN8Gze3bolK90j/P9kWB1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSaBPu0E; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761921377; x=1793457377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G6KU9NFRSLdIq8IbgY6vusBSz97tLJpKh6ew1ka8HVo=;
  b=BSaBPu0EUtEBHZezMYpTF4HWf8I2NMV/01odmHd0hSeuMqaPwwpObwV6
   fAWSxxtuVYJNhbxUaj3CuDz69xl8hCJUSL9gh7rO6qZd4uM5jqXhvgeay
   HfdbVBKwgUy39mw5T/ysuKGv9lMNKdEYrN0iDPzL2QsxlYB7M4EtKLrtN
   Mj38rKNJgHOnJqCdIJMoa0cXNrqcd9R5lxnOPIVlDNvEcs02+sN7PvTXY
   6O74hwPZgLUj0iQjUdi9vrI49YXT9qe28W1HGexFjX5xjgndAU1Ru00vO
   i4TuSZhUPr8sguMs33LaDls76FEWNVFXvRWx1JP5gzrliQ+wuHyColJj9
   w==;
X-CSE-ConnectionGUID: i1btyuK0Qqek7PZRZmydCw==
X-CSE-MsgGUID: M03ZrMAzR3a66L2avyCYxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="81494338"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81494338"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:36:14 -0700
X-CSE-ConnectionGUID: AviGsDi2QHSrx06HdEl03A==
X-CSE-MsgGUID: WUuOKJ/KReKReaxq2DJJlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="191396468"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:36:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:36:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 07:36:13 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:36:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0O8gb65d1AYOBYkwVo9y8dIJydJx+ptwU2ZJCpDYAI+T70g1gH+fuL1p082ApD30XTmFRGogFES2ONbREL1YC6QREfUATvMBAyfGoQQMTs4GV0BfzLp9HBym5gRmd2PX8U4kikLHMoNsTDAZlyB1wkpa2g6c+pbecl6jCmnMxfwNGea7zorRUk/7oLvHH/pAT9FZ0ZS+ZXM/2hmPUXEdZlUv5DjoBINfKB6QEf1TwyhgJegQurMcy5vtpO51Md7cRGEHBic86UF6uQNCmlGK5VoT0aku2J1qx3MibIR3Cd51vSsFVUWDJW47MCmixkiRTjjcwyF+y1tjSfFU5h6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq9AOdQymvVELX8tIX4/Cka5ZnddhH6uq6zfnrlkJDk=;
 b=ryozHvtdAFUoccMNPgTfOVf/V9+M395gaf0ub4/C1ZDZgDFKu/y7qpfqg/VtK0JgVXXhHpV1n5ibJ4q6An8JsUIWYY1ETeZzwzygcFdQQAgfE6rf8jAIbvDd5wCj+rXYl2amiMpiWeNkYDG9ZXYmsXHwyIf6oIlyjOCtidia13J0TN042JSWf/T6zUTFTKE1yy0IrOXP8v9rOzkMcz99X8JlSQ2GTFu98ZYQZDHZluTnAaqeL7kMzZA7XYxv7AIM5/7pW4YEwKkBahuGBXHDwAK4J2rRTHKd0/PIECBVYJrbK2sCDNaNthZ711ipin7P0iYS4gt2/+DM+/bYbAMM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CY5PR11MB6320.namprd11.prod.outlook.com
 (2603:10b6:930:3c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 14:36:10 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:36:10 +0000
Date: Fri, 31 Oct 2025 09:38:31 -0500
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
Subject: Re: [PATCH v12 22/23] KVM: selftests: Add ucall support for TDX
Message-ID: <6904c9e7a7090_23147410037@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-23-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-23-sagis@google.com>
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 003aca09-d459-4750-b681-08de188ad5a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GcBanMlwuPSgo9b6l5TENa7usFM9MJwBxlK+QPjCF6zrG+crQbypsFIXrzDU?=
 =?us-ascii?Q?WmuIjoLXWtp+ohlJT+vc6Z0g/PrN3JaNbNihw/+htrMWug2ITy6jRDrD5Vaj?=
 =?us-ascii?Q?p9Xq8bZQoHkLv/P12e4Z3JgTZzRRpqwLevCadN78/rZfaKVG9gW9VvaGCt+f?=
 =?us-ascii?Q?Jf1SksYf+6P9yhDl1Kh64SHB9m1/T4bCbtIM+WaiTFmu95wXj39zm2uUwbdk?=
 =?us-ascii?Q?CtKAlI/pNMYUGwD9KooiW6CmUku8JxLoizXzZ7RCk5BQeUkPblmAgTt8QwSR?=
 =?us-ascii?Q?89iUUBXt3wD5kwLevRiKeeY1kJWsDXuyrHLupWrorEQWMoLT4pMhpLrvoSZk?=
 =?us-ascii?Q?8QTKFsj16lG66JIn8IQg4ckBaRkpyhuRq0NHNcLcj1q0zVGQ+BVxd3V+mejS?=
 =?us-ascii?Q?JOXDHXxsjEmCJwJvt1IMi231V3z/sH1KZ9UVAvqxsfMUIydiESM0KH2VPhKd?=
 =?us-ascii?Q?a0BS49GHZi9jcad5yFnWPM328GjJyzeP2IAiix/u6r1666LDVlnkxkvE5k/4?=
 =?us-ascii?Q?fXf9XAHRygkRoTrUu5puWw/MKIUNZlREX67n3MK8VTk3zqddlwQO18jjFI+8?=
 =?us-ascii?Q?VwEZPtLW4kbt/OAaYLGApJlH89C/rL9OMsBWoV867tZomYUvOLib/7kiKECT?=
 =?us-ascii?Q?cleiT6bd16BLGRXJ54LN2M3+ztLf/Os6KekRlCdcCty5Is1HhTHZW7prR3o7?=
 =?us-ascii?Q?3OLTaNxW4YN2UCjFankn+C+KFPziQyzC8fX9uFh6nyvZ9sR4gRmRs7IbQwTb?=
 =?us-ascii?Q?kGpxLpl+loWo9jyDG6FJDnrdpELHxFQ3zX7w8uevdEGPHJWuFAeE8qw20Ait?=
 =?us-ascii?Q?GqKihXlD8kZrGVav2gQHDT6ycmJJz8vt+D2QfFMbD59QSELS7PEzjn1NOh4R?=
 =?us-ascii?Q?Z7L0437yk4rB4Th2Y3ic2EpmBcVQ/+1kbP75ubS5oMEQMoPKEekNr6dWzYvv?=
 =?us-ascii?Q?ZSmM/7ZiZFfZF9ZvQuGCGykkJXpjPm/jQWceKTCoeIfOa0s/qgIAI+hnAW/q?=
 =?us-ascii?Q?zXcDiH8uKuF/gM5d0FIGiTsVCmo23d6/kA0WhUKBz9/8srdbYLJk49WfrOkv?=
 =?us-ascii?Q?GD2nskbEZIrEQiuH5Co6fV4dVxGhV8/YdIbPGhqJwoZAIF7/iiRQrh8N4vmF?=
 =?us-ascii?Q?yn+qPZwbpiGBkhRGn5sF/ziAxWGeB+lIZbCAD1BTTUQwoE1VcDFuV07l7qbr?=
 =?us-ascii?Q?e2/1aGXCfQFZ8DXt8IJnPKQTn6ZAKzacbdzdJQVWbrSCmCTjCuwRn2vxQDXr?=
 =?us-ascii?Q?KWAr2fMVTRCNuRxKnE8omK5ld3O2n3EYm2KCVf7au5/YROs5TmZH0I42fJWT?=
 =?us-ascii?Q?xKrkAWD+ZlkeGQoiOxa+FI+Q4m7GLYAj+hFmWXjZ200mU29u/+wAlcONUVso?=
 =?us-ascii?Q?6d4F2osdBiGfooHYSNK8AZ+CLB2WmrQq152rkpyimusNrSBSJEEN8gfcdHxb?=
 =?us-ascii?Q?yuDk8LE1mRVzjqjy8Tln5bWfM2gmW3o6zelRcHjmTzSE/hGJXUjmRaL1WhPW?=
 =?us-ascii?Q?LFtCVeVJrRH3JTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTErUes/h0eY9euDWYK9sKHloJvrVtnHTckg2W8gbRgKDughMfiH+7iBc33S?=
 =?us-ascii?Q?t/6u9bHDj9nl/0MqnZJCNpEFrdRb3pqVLy9s8V8TVukme0VQsLWbBhsaXkuw?=
 =?us-ascii?Q?wCf7qn9OLxjqupVvTiqj9/tpgpQTvZEWLTTjOkG8Io6tx6kPfnvr+PLHgCin?=
 =?us-ascii?Q?Hmd27Aq2R43le35gvrcXaZS9ryvf9PcWx3lP3kSyK7GyShnV3jPv9qLm/Z88?=
 =?us-ascii?Q?5lOyLzOvcN0CJXhGP2xJkuOXHRZzO7wdpqe6oT+Co3je+uVEHIlY7o9F39xm?=
 =?us-ascii?Q?B+F7efo0OfwNDblp/tHvk8Y61bqovm78Q0nML0QLRrRY/B9sJN7hrjdBO9EX?=
 =?us-ascii?Q?qlKPGTYnjx4XQeldAXtBy1gsrqmcdEeFdZ4GAQ/XmQT+k/oTlhnaoV7eBCxj?=
 =?us-ascii?Q?h5jKcxfWhF9Gq/bS1eOrn1kZ0SgBuKv71eCBU5fN6IbBdXlpJXz6aZHtLIhl?=
 =?us-ascii?Q?gNmnzWsHlfGJt8kUci/YhYrVna1KqbVTItggwxcM4anIhjpTOfqCU2p/FtHg?=
 =?us-ascii?Q?yWwvPGyGiFx49p3bF9oq9sSHPzADf3lnLNdg4k6Z6fYMv/slkyZs0YcrjAEE?=
 =?us-ascii?Q?k2IXN4U3G86qRPsDC2/sbilaISaBhtg2KPef+lQ1LFJXhChGoL5a9Pl2uCy8?=
 =?us-ascii?Q?hD2ORTkFV6VTMerXWQhAwuGfXkr0oq+dMRQr/JC2An7zF5xRCJij7MFzBNwU?=
 =?us-ascii?Q?2a4YwTY1/cvAp7wb6/acJypnERVfMaF1zQGISnw0yZ3iGyodyrWpEpwlLv7/?=
 =?us-ascii?Q?yEE1yqyQhPx96T+2JTsJg5p2CFJgWHX5a/6zSnznrlzHJwAt1G037xEv8IzE?=
 =?us-ascii?Q?BluOULIukSfh+/BKNRG3oERpMyboQ+5N/oag/nzNSwHOvuTvalm8GUmsQi/l?=
 =?us-ascii?Q?bYXF78FTMVeXC7wVIM5urgFuEJi5RmilP8QtprEPTtXr+KBzKDJRTtwKZbps?=
 =?us-ascii?Q?BlUQJgKURF5LfKCSnnledlFcwkStrNetCrgqbjRPnBVw1SvLNgBEUEOcbRWS?=
 =?us-ascii?Q?9fTmD2ilbkm+85TDMNNNnkEHXoMRsJ2bkdyd7Zn7Fryh1cRty+H/YBBj51TL?=
 =?us-ascii?Q?RD7KNWnYu+jWR7xFBR7yXPqWLXnJHSrK0nr91GcUNUWqtCPnTKDL19xOB0W4?=
 =?us-ascii?Q?CoOqLSX7mF/IXTf4Y8UnViYljAW6h2jgEg8Ppn2QDWDtKfZX21z7fcYNUGVZ?=
 =?us-ascii?Q?VZXtDweV80T4KElZNPM+3cDqfRHa+mEsmxvWCAhXY04N9g5BdvtkDC+kF1mG?=
 =?us-ascii?Q?8qQGOdqiUBhFokyrFjmsimbEbei6KczifBK//YXitSM5ouDgPZWQCMYoLF7Z?=
 =?us-ascii?Q?fMa8tqtFeoeQBE92/Aps33TXDIad+3JjtT5HgporLP/mTI3IAeLU4KO1zG0Q?=
 =?us-ascii?Q?yb7W0kQ9I9+HUQUUO839k9RWEkgL7NAt/iZu7mI1srF0pSwxEv26a0gZITGC?=
 =?us-ascii?Q?i/Tlkhv9oFOwfeX+XjvSawY3hF2lK0NDR1HxFwmUzRETpeve7lmVCXYl8K4u?=
 =?us-ascii?Q?mAfFl00+QcnSxTCpJCJk75Sl7M6RZ90hKnvEC8P/FqjvEYUbux7cXFs+cYMY?=
 =?us-ascii?Q?ztGMnUjB5IEfkFiDm2h3pNe6+PBLRyWXCNAoyhOn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 003aca09-d459-4750-b681-08de188ad5a3
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:36:10.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hseAEnkrhwlyjMojkxOiiQLBmm5DB+hJAWygLpUnkwhSjnJONkfHCL5TKi9krU/qFENSbtUYmxaoK+mr2Xp/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> ucalls for non-Coco VMs work by having the guest write to the rdi
> register, then perform an io instruction to exit to the host. The host
> then reads rdi using kvm_get_regs().
> 
> CPU registers can't be read using kvm_get_regs() for TDX, so TDX
> guests use MMIO to pass the struct ucall's hva to the host. MMIO was
> chosen because it is one of the simplest (hence unlikely to fail)
> mechanisms that support passing 8 bytes from guest to host.
> 

[snip]

> index 1265cecc7dd1..fae6f37b0bcd 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -5,11 +5,35 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
>  #include "kvm_util.h"
> +#include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
>  
>  #define UCALL_PIO_PORT ((uint16_t)0x1000)
>  
> +static uint8_t vm_type;
> +static vm_paddr_t host_ucall_mmio_gpa;
> +static vm_paddr_t ucall_mmio_gpa;
> +
> +void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
> +{
> +	vm_type = vm->type;
> +	sync_global_to_guest(vm, vm_type);
> +
> +	if (is_tdx_vm(vm)) {
> +		host_ucall_mmio_gpa = ucall_mmio_gpa = mmio_gpa;
> +		ucall_mmio_gpa |= vm->arch.s_bit;
> +	}
> +
> +	sync_global_to_guest(vm, ucall_mmio_gpa);

Is this needed for non-tdx VMs?

Ira

[snip]

