Return-Path: <linux-kselftest+bounces-44358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E6C1D65B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 22:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2917C1882E20
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CCA3176E8;
	Wed, 29 Oct 2025 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQ+fBzeT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67930ACEE;
	Wed, 29 Oct 2025 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772482; cv=fail; b=Uy3i7CeNxiirSmstCs5PxnCB01kp8wVeW2MxG6XDt4G2ydROwPkKOmgoefp23/HnCzD1bshyndG9jCZ4OJVWeyWhg72nuTr4ZW9cMZEqODtlqC4TY2zaZtBeQ7lYqDKwP+F9SC3ClXbGfYPgnqGaaflDycOVJ1UzZXX/JwU7vC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772482; c=relaxed/simple;
	bh=7Hg2oRrOnS5e46NE+LRTdTUYg/8wzgyWNwdhMdBbm+s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ixd7io96ogwYPaciH34CAQH6xQSfrRbs+utpJrglDItMdHB6/Na1cBZnxu+9kP+Hp+niD+8u04l9Okmq0vDMtZsAkNJXtZ9oWaRsGKkP+nIMc69jtwW/U5c2LbvO2iZ8Ui4S2xvMEC0MGquAKhirbJoDcfBEyfaWOUwVo96EfMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQ+fBzeT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761772481; x=1793308481;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7Hg2oRrOnS5e46NE+LRTdTUYg/8wzgyWNwdhMdBbm+s=;
  b=jQ+fBzeTHDY2Sp8a+QRscUsHjLb/Vu1Dj3/kyyjZg5ERTXYYuInhHL0/
   SNKXbwuN39jggpyyMg/ut3zfILzPAzdflIomIZ/ZSBfuN4bGDNcCux3ZH
   55YSONOuUywQKu9P7CbLVZkv8WwNXCZDXzpVcpDOb2xEKUfZJxzAhOCPt
   oC+szL5kRZghlpGr+q4jQz/E3vT0Ip8B+OZ6Kibk0mhnJ3VNA3GfLi1k2
   c+YA23HfqvM6ZKJy+7NvS/ETbJ/O4X95UGGFWjfMVPTza3PvN7k7KZFUx
   eoQYpcPQS3XWMWOVmfxd/SGb8BJL21bM1XjRP/cCeeHy/0bhsraBflSb4
   Q==;
X-CSE-ConnectionGUID: 9WRVq2iqT0WwafrKlNlmgg==
X-CSE-MsgGUID: 1Lixf7d8SJKtVQc/6Wzjjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63837852"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63837852"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:14:40 -0700
X-CSE-ConnectionGUID: /GtXG99kQ0GWfOprg2b6zA==
X-CSE-MsgGUID: AgWYuTjiSUCRI49BzCIvDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185022477"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:14:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:14:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 14:14:38 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 14:14:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQdidGSAN8LgcCwnJxadk6KW447qGQNUwODfZ/mF61fUC2aq1MbnaHaTe1IazAgl9tKU3z3NUkzTy/wzYalvO+DMT+cKiCPFdczaIt/BWYhBwEjv3fJL57qldVM6R1JmEOxz7e1qJVtFuutwe4xG88GHOVaPdJGsxUpDGTtFFThrlWWPQpQ38BstpACoq0gTnwQSskkOcekgdO6XpiLOPk+3klxTAsgy+RmUsc/A1OSqJB5WJPsE27EB1JKuw3ixRpQnZstutS8LdMb+UxABeevVDTl301Bfy7p9PihtJSSo1oimME36ioqQqc/9u0y3c68I01qp5BLUoRPCPsBrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WH7KhGueB9G1OGVXeocIoh1MLNMnD+dWFSblemR1eA=;
 b=VENLc887gM3RShNOHhHygqLM+aRm9wXRM90pn4J821Qm2sexAJZ8awXqGGSNdzvBwnccg5VP4zQUhqWNoal+Cu/QPKBsXGuEXHIOWcPDq7vc1KtGMzqf+qFnME5VXqYM11ovoNvmqlxkMhmAp7cPTqoWVLeuQC3JIs66aElhFiQJZqW/7u0W78H5/zlqGf8Rv6nczEp6DQAN6dy60wE+Y7TV6gXqzyn8x7XaVIyWF4GIXn2UFlYP/3wxzd1Qu296iJ4OAwcQIXe6HaPAGvPXTri45PnCckGdB/9nzIPdQcmzXr46E8/9mny5AP2Njr3N5cu4tqNCzQ4tAD0oaX2sAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS0PR11MB7999.namprd11.prod.outlook.com
 (2603:10b6:8:123::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 21:14:34 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 21:14:33 +0000
Date: Wed, 29 Oct 2025 16:16:55 -0500
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
Subject: Re: [PATCH v12 12/23] KVM: selftests: Add helper to initialize TDX VM
Message-ID: <6902844729ad2_21ab5210055@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-13-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-13-sagis@google.com>
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS0PR11MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: abe0055f-385f-4b59-1d16-08de1730284f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y1XTcLL/rnc5fuC++GuGKa+UwY8I0oabzkTXBEmBNnviXXh36oXaQUM04N4R?=
 =?us-ascii?Q?xy/x70UTtXe0HAmkmsjK3iq2pvQo4JHBn5aAzbPgXmSc8jNw2fOwPCeaP5pj?=
 =?us-ascii?Q?1Om/cXEAAXydiC5KyJNmRArEl1FC0iq0abd82XujfHetwXKwvfnQZQlszeOn?=
 =?us-ascii?Q?69/A1qRcO7tu2Uza/0rDxAt4Q5nMf7BN+6rdSgRfep90CqTA1830RObr7RK9?=
 =?us-ascii?Q?gSKX4c/cVgUxHXLKHT2Z3CWixYb8TOi9PkjEufi7ItG51XHP/i1lRggC+ETd?=
 =?us-ascii?Q?dpC57uB5YR+4fCcUl6J+a5TEfIzpdUucaP26gNR+Yee95kIcXFshSk8C65hs?=
 =?us-ascii?Q?CxBQnmKR2SjPsgCahBSMGvv5KGfedhollS8BL1cRa7HoZRO9gQQMqI/hJPtt?=
 =?us-ascii?Q?BO2va6o7Xa88na6pyyMU4b/cGLdTKO7dxlMz1pyKITknV+h9XV/IOfmjdGZ8?=
 =?us-ascii?Q?CWSiGbOsBGVVbLakRqQfBLkA0pGRuoqvaZBvv0RA/uX8E0kIKsae9yNyingN?=
 =?us-ascii?Q?k3an0O8L1jN2Q/wK9+BP5+h/5WK78no3IuANWTyZP43KwHJ5ANee40v++3jL?=
 =?us-ascii?Q?/Br05npTlEK1c4bYayHShYyQhtC04D4SNLLZlWaHdbmaizX9E5tibShthi8z?=
 =?us-ascii?Q?TWSupeFTcass4pU+FIsEOCGdbebkLZ6Nv6pdyLwrCRc/zVZ/NiHpRVs9yvg8?=
 =?us-ascii?Q?V8eGvY7nEecvgpJTTAuUaHT96ABrBTpX2VHbfFNUi5+6pQobs4oAKHBplh9T?=
 =?us-ascii?Q?LX02SRh3r0izCJAWZr5YoWwEelJi6TP62colpKu0+DqBAo1CdGLulcKtxqmH?=
 =?us-ascii?Q?1RzBURK458fnJdcbBHl9FbPCJ7vAB6y1zy1QIRIULS90oyB4oMw5oJFevqON?=
 =?us-ascii?Q?N2ohyqyzzC7+rjKRZ1g1So1RpWI2UcWmMaUU615PCnCdzqYLTo6nt47pgZJW?=
 =?us-ascii?Q?qii7lWZZTklr32TAIaxis1BA/nWMBNg+fm4ayBKA6phDIu7SuJmyTkOTaW8H?=
 =?us-ascii?Q?J0pcYODo6U3CMAG0wAipWLAtWHIX4E8IWTIpq5hQvQHCQity/nOXMlSOCSoV?=
 =?us-ascii?Q?FXuR3WW00WMBYCxL+7dN+zEtOEDpjubrtyPx2TkeKeV6I8XKQexdDpnBewFJ?=
 =?us-ascii?Q?U6rZOQRansCCPI9UL+tQQwVOnTO2sNS1Mkofc0SW27n6fA6UH1pgtindDg65?=
 =?us-ascii?Q?ifMYO1a9SMyoXIN+SKTM1H55P5dxveo1MYoOYt6wrXr9SXJ9gKQMcNJMXYQZ?=
 =?us-ascii?Q?UDXMejs/YQ3JAYnmS1TGcUEgdCX1fKBk6Ud1Qwm+qqlzUr+8WN93Ko6zolXR?=
 =?us-ascii?Q?39CwEazmt9JDn91rsJD0SMvL42CDnKJpi76/NB4RFfv8lulXt9qDJ3MZGbOi?=
 =?us-ascii?Q?a4EMO7RERDE0WgimcOEPu0y8npAALkRAdgyRw/ZbwCyIENBIuwyzX39tmtQC?=
 =?us-ascii?Q?WL+xhRvOPlh0bpM2NDEKHQ+lxCoZDsSzflJjOm4JXGbRWLqgLesmODiLfxVo?=
 =?us-ascii?Q?YuTgbKh4qbpc55M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?npy4ygWq3+feOpb0iz4+bLvic7RDEn2JfYMmNbE7vB1WBMDJ2fFOOpG0+mUG?=
 =?us-ascii?Q?h5TReuv8T4uMxuS6Txkx2jfDGQDX6dWIIfOl8VrxoWVOSYqKvuhYJQvgGKqT?=
 =?us-ascii?Q?FlYhNik1U2V4DPTtraOjHOmZNzu2ULc55xUswKnHZxlH7tKO2Uu5QYE3HPVc?=
 =?us-ascii?Q?+PlCBNP996mlNTpc6jWWCxhauRgzwjLLOBnu7q9UqUgzW/qfQ9WJ1+2fQ1/Y?=
 =?us-ascii?Q?MwMYJ683ApNwRnvBybqZJwPjkXUXdOM0lVyOFx27J5FyzYwXdfytqkpONc2S?=
 =?us-ascii?Q?E0OxBPezWNeZX6qfG3xUk9bMwEBeOpKGiIrXfCKJuSRRRlgpFezXttAWnPH2?=
 =?us-ascii?Q?xm0bcewXwjVAejP5tVlEzaXRCGIpr8ivV3WdywiZ+y0hP9MT/dVC+Z0PE0JM?=
 =?us-ascii?Q?AQOpSBca1W70gkNf29rAw/XeyBvEuiPDiV34twKpJJpSngI2Wmhn3LTla27O?=
 =?us-ascii?Q?4pYLFjRFrXWLUd6oYWUcmLaqiA29OAelfGGu3wPzSH6nBJ1mNFBD0m6SIoYE?=
 =?us-ascii?Q?jPf5jB5fSHQdU2ZgACUCWKbfKATboKx45HsRVSmYh4nV9RmVenTn7aj4Lpa8?=
 =?us-ascii?Q?zR/R60XF2PSrF7xewnyVJOHi7Gqm7/L4wdwanolB5uCrscNIcGhFNDf4wjXm?=
 =?us-ascii?Q?NxyCj42WQpwKXCvqjsu7SKKY86vy7SyAQKTykGJOb4QRkM9pPxsMLurH+u1O?=
 =?us-ascii?Q?3AUUMDEpp0iR6p1svFNfaMBkWXOoz3XYUPQw7XbHJQJIdgIljm4ShdgHqS2O?=
 =?us-ascii?Q?JEsr1a2ww5oGkeLaX7eBTmCqeBZifUYte8GXC572yVoCo3lKL/BxylYMTk7m?=
 =?us-ascii?Q?nMHpx8J7zNWd5crNn6fBn+/Rwy6sIFDM6K2JbnY/I3iOBBO18Ri3hl/mZPCS?=
 =?us-ascii?Q?0U7tAFrg4Qi8iAw+RJjm5tOpb4M6WcYi/z5RbKroMoUUEYL1Cc7rJpV7V3YQ?=
 =?us-ascii?Q?BeTPmhighvKc1HK/nlLq91EBDoktAJdobkYGoUkuj0VfzfvcAU7OJalK0Dqb?=
 =?us-ascii?Q?uMzu1Pb1Cwt8dM5GSQVuCLK0XHBICKOGxvpZyoW+hg7YHVGiac5kiI4+P8rc?=
 =?us-ascii?Q?WycG3OzK6P7v0NV9ttDeYtzdglfMrrmEAk0SuwuqgamoCDZvXbQ/MRA1DIHk?=
 =?us-ascii?Q?PDHRZxF9qDr8o7PRshUpDgAbGQWsnUMQgcG1vJ2UIRKwPau7qITEELdajYX/?=
 =?us-ascii?Q?G9WdVLEHZ/fkEIeefZrS5dUxA2xNwalYS96sPVw6hKaMm1odrUn8E6gqMIi4?=
 =?us-ascii?Q?rVPp1KTz80Z271usa81U5G6lF93GiuqUud6Is08g4krMu6sFm9UjQTBirnwJ?=
 =?us-ascii?Q?B4XFLGAOKkrGJ4cmMGFYnO/abJW9EI+6dFhD215Js5iYDTX4dWVocMVQF7Nh?=
 =?us-ascii?Q?eX0ijkxFW7nmCJvPAXbIryibIaCIfOd+8iOS+C7edPa9w8L4QvvlYAgAhDJ5?=
 =?us-ascii?Q?+MCQgyvfZ+HVan1Dsm8vEB+SASDqjiHntXZVIpaZV1yExe52O8XRiJ70PtpH?=
 =?us-ascii?Q?PRgY5k3tXT1zr3Rx9+DHiWze27o1SgWamr4Duwd88oA6TkFq0SFgKvJNNRAS?=
 =?us-ascii?Q?FLN9Jkr0icl3WaB6jiQ5LZJ5y9gaQFV3WnywmwC+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abe0055f-385f-4b59-1d16-08de1730284f
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 21:14:33.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4OTuHz3YuzJXQ/smTAMBJ/v/e447+1o1kvwfNQ7mMWNU4wJT2HjhkscNJAuN+of/ztfOfNoMhHyFwphR3wqZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7999
X-OriginatorOrg: intel.com

Sagi Shahar wrote:

[snip]

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index dafdc7e46abe..a2509959c7ce 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,6 +11,60 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  	return vm->type == KVM_X86_TDX_VM;
>  }
>  
> +/*
> + * TDX ioctls
> + */
> +
> +#define __vm_tdx_vm_ioctl(vm, cmd, metadata, arg)			\

NIT: Why not call 'metadata' -> 'flags'?

> +({									\
> +	int r;								\
> +									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (uint32_t)(metadata),				\
> +		.data = (uint64_t)(arg),				\
> +	} };								\
> +									\
> +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	r ?: tdx_cmd.c.hw_error;					\
> +})

I see this is a common pattern for kvm selftests but I'm struggling to
figure out why this is a macro and not a function call?

> +
> +#define vm_tdx_vm_ioctl(vm, cmd, flags, arg)				\
> +({									\
> +	int ret = __vm_tdx_vm_ioctl(vm, cmd, flags, arg);		\
> +									\
> +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
> +})
> +
> +#define __vm_tdx_vcpu_ioctl(vcpu, cmd, metadata, arg)			\

NIT: Why not just call 'metadata', 'flags'?

> +({									\
> +	int r;								\
> +									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (uint32_t)(metadata),				\
> +		.data = (uint64_t)(arg),				\
> +	} };								\
> +									\
> +	r = __vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	r ?: tdx_cmd.c.hw_error;					\
> +})
> +

[snip]

> +
> +static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap = NULL;
> +	int nr_cpuid_configs = 4;
> +	int rc = -1;
> +	int i;
> +
> +	do {
> +		nr_cpuid_configs *= 2;
> +
> +		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
> +					   sizeof(tdx_cap->cpuid) +
> +					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
> +		TEST_ASSERT(tdx_cap,
> +			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
> +			    nr_cpuid_configs);
> +
> +		tdx_cap->cpuid.nent = nr_cpuid_configs;
> +		rc = __vm_tdx_vm_ioctl(vm, KVM_TDX_CAPABILITIES, 0, tdx_cap);

Why not use vm_tdx_vm_ioctl()?

Generally though it is good.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

