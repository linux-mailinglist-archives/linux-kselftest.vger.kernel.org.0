Return-Path: <linux-kselftest+bounces-15591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD5955C10
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ECB1F215AB
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6148217C69;
	Sun, 18 Aug 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0YZAfP+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7A17557;
	Sun, 18 Aug 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723973341; cv=fail; b=dsY1n7wa52IU8QM33yn5YgHCKWvi/Y3tRXopbNvbbVAqEv0RWympv5R3JIFSlgtR4lkZvX0g1s7X07bSfB9tS4NvlPm7l4ADEBZgX/jXMFO4nNYK8BxYZJJU13+1Q5ZFMCQkoNiE/lbNO7LBxi8Wl+c3asQY0KnJrhn806FSBn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723973341; c=relaxed/simple;
	bh=uxwncgsWilsdo35xm1vMx40JoCcCdR1MMoL3oMwFQrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aj/VmrdZOg4ZLBoCwJkhyZSyTj9jTL0hD1llLawMTxOk4kS3ZNxYoCWnaXjsecrlU4A3SAle7G98PEPKCuQVjynHPamEIbFG5PCgR0LvuRKGZ4b+Thv5me33r4ck4ljpwmpYnIPSBbMJeGbO733HpzzYrJpjZH9gWqPKD7mELNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0YZAfP+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723973339; x=1755509339;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uxwncgsWilsdo35xm1vMx40JoCcCdR1MMoL3oMwFQrg=;
  b=H0YZAfP+DZs0JaMj25IOBfPmz/HL7cWLAl+wyrvm/DE1VG4pcxP8J66r
   3nGN/+jYDG43wmRu9gDzaCAliifpvnDrTJ8vGGighk8nPcoLTqcvN+xno
   xomhOzMXnPR0CDiF8NrY1Aub49bSG5ajIWrFefjVvnQxg6Vc6xXrQMeK+
   QAj2vZ5wqsNSMNlYd15L0qjRaztGssyoP0PpR9NKVG1XYWKNrAzMyUFwX
   WhnwHai4zS3pPT4X70BiwN18QEVoHZju/oL2yfhCNJ+M/CdBkQWk0QLeI
   1veWeSnptvVRYy0p4yaS0PFhzmAlEL31wJrOwqElpHw/FIVuKbGlSU1eE
   w==;
X-CSE-ConnectionGUID: Zl69FnHjSaay2AgjbZCmDw==
X-CSE-MsgGUID: feWVlW+PQbKVsxljeE8tuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="22368902"
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="22368902"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 02:28:58 -0700
X-CSE-ConnectionGUID: a82Hle/aRIis16FvjK8Hmg==
X-CSE-MsgGUID: YEB1hKOqRk+pQyUNZa9+zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="59796593"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 02:28:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 02:28:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 02:28:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 02:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJ80IOJqeVdjAMUtYS8QbE/NP6fy9FUKzhkIp3szrwQRTmgWsleK/I84NWmbIbMz35FUikzX8JqWO1gVVX8XqTRHz/vUVAX7fYMxVtFWye8dY2DbCfZ1X0akU1kREUrWN1iDe60HiJlaMdjASlxxRUKl88vWAK2j7XoY6lmfxX4eEc9zT8xZ/ve1Zl8v5l45RwmGvOEK8QK5LKKESfheUOSW9wm+P3n8tYATwRtOAAxWVc67HiHa6Z0VRFJCrXG5+inWXYaSxnt1vZRGVZbXhCNnAence8CCRrj+VnGHbw2Bwmm2Ke7/CiZVbKMUzePvxxho5a+PvN4igaWXAaSP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1pvjqbdsouKT2Bmp2RoGDcqkmxaL9prHHGKmxYelfc=;
 b=h2EikCLObQwkYhzOlaSdjUmFXl0yw7Khc5VT4gsa1yH6jUnXk4mIRl0uhD4AjM4/EhH51ncNQoAtrGq4b9JXuIg7xU3KpmS7c0bOTncy4Xr2RJgem2QVWVUQuXPh9iJo3Sj8lMaWKAtSpso1bQ3ZkFHqP44H02/RGcUm1f99287y3AbTeI9ZEAI4ASQ4bgNEV1GmP2NkbjCaBiMxNzFEMwtuPDJJP4czenSwoUXpvnT5pRgxJ6mcx8CjP0WDBRl3mtnvSIiNRZEOL6hf3hn/ZTMnvsf/cH0+SOAsidI8EOxKHIPBhEhxE9eH9unFrW0w6ZLqNi0GzgndRPJdo1VXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Sun, 18 Aug
 2024 09:28:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 09:28:53 +0000
Date: Sun, 18 Aug 2024 17:28:41 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jeff Xu <jeffxu@google.com>
CC: Jeff Xu <jeffxu@chromium.org>, <akpm@linux-foundation.org>,
	<willy@infradead.org>, <torvalds@linux-foundation.org>,
	<Liam.Howlett@oracle.com>, <pedro.falcato@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
	<lorenzo.stoakes@oracle.com>, <mpe@ellerman.id.au>, <vbabka@suse.cz>,
	<keescook@chromium.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <ZsG+yfTDCQSd1Lh7@xsang-OptiPlex-9020>
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
 <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
 <Zr670gX13gKJOtG9@xsang-OptiPlex-9020>
 <CALmYWFvEaYZHBDy74V4gmEExTuMpYg3G+qGUvjL5WtpSVrVqRg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALmYWFvEaYZHBDy74V4gmEExTuMpYg3G+qGUvjL5WtpSVrVqRg@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3e301f-55a7-4522-66db-08dcbf682cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UamWAMfzHXzUv0XZjwllzD/fN35fDjThdPQA0hcMj0Y/DXeZtsJ6xGUrDCQj?=
 =?us-ascii?Q?D7qJ8ZZzr7xmy0YLWQcnEYdHrEpovLf7FBV+i2bziI5Rf3Lv7oEa9mFMT576?=
 =?us-ascii?Q?TB9QjTFDMdHtzjfvrgUUpOaegpw8uokApkzDN6K5/Wo1ZQMOOIvYmJ7ZCAfu?=
 =?us-ascii?Q?n6OTl/PdwSLZFpxMGnAdWqdlLoPGdj1on6KGy4uCKwdpDXitVBiTnc0NoXA9?=
 =?us-ascii?Q?0L3jV1XQSpJZhlIVFqeTCZE+Lyan+gyNuB1jMQITFBRyG5PuQJFsKBXDpH/R?=
 =?us-ascii?Q?W5AalVCozdoAtHCn89d7uDQxvSDnR2co0AiX5qnT+LWtwYYsmiTraqqYNk2r?=
 =?us-ascii?Q?IZ+UA0rLM9tGNx2fvMwLrE9TSe0nKqYijLA4wB/EXtVT5dFAVNfApsv5uzAZ?=
 =?us-ascii?Q?+r/vdC+mD9f7rY0otlhBeqkqxPbjT981sIyJIr9k5gRmFAPLjwc5HStwvCIt?=
 =?us-ascii?Q?XRzIjp0fAiezkHkpy1jhY8na+rLQlqPvoWIeuP7Ijauj8m7b452pumx/kozG?=
 =?us-ascii?Q?Bsd5sKcHMOEnZj+PV4PpN7/nfofy+vmvR/aDWabkidW20ZfwQmSdfcTxAbNQ?=
 =?us-ascii?Q?5qXenU8KRnSRznhUoncIOJVtV0c/7beHH73xtPfDKX2prefDg81/B6azNHYu?=
 =?us-ascii?Q?XuYbZT5IXUjYgEOCkbdfp2cVPCOfxMuOfNORr3Og5Q2nSl68WORHUT6Wajpk?=
 =?us-ascii?Q?aQwperSJAcEDT0u+Dl+pOe7SX2/AOI1e99Zpm/zNasU1yfOVDmlRRgylJ+W1?=
 =?us-ascii?Q?xIcUJEyfdEKJ10aMkEdLkCYs3coMbL6UYK8GzIs2ixXuuekf4eVRIzsIz7XQ?=
 =?us-ascii?Q?TnfjImcDr4aa+YM78ryZTwQNjFB1ZB81itE4820BzJXU7kS46rLioP3Yp0qD?=
 =?us-ascii?Q?eR7P9HUh1py4yIRbE0xtE+uJAo/bbnYrfCm9gHS5PBopfAEVRHRsabAvZose?=
 =?us-ascii?Q?7MPe5XxWedwLDY7/7G7CMA20eX5+Vqv8WUftOBAcbcc76NMyD5JiUyfW6nT5?=
 =?us-ascii?Q?Rf+w4d8DLdqyDuEnL954Ycvr9CIPh5rCvlj/Nw1mWB8SQCTKpLXq/TnipUyJ?=
 =?us-ascii?Q?bjL+4GMxcZoDh9A0hbU1t/fK7WGBjmP4h4W9yqL4m51yd7bH1MK9b2utlwW6?=
 =?us-ascii?Q?3IxxJ3ZwJzRyKcrtUmMkw9WVAkHRabDa/qbK9gMHrGC74pOBE6toXwh7XdoN?=
 =?us-ascii?Q?IrxI6fzjYDfJGBCqCb/MWCEXalkm+2c6yCyP/j143/+es8spAydYC1EWC/th?=
 =?us-ascii?Q?AUqmQW3V4LE7No9gMtdW0AzIXjfbGrDvqu2nzg3GfUceWCgO2xeRCQWGSEtJ?=
 =?us-ascii?Q?Vf4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?417wXP+Yul20G+QeLg9svGf8GjuhocB0/DDMojejWs5vvRrSn47oc9Q2Z6BC?=
 =?us-ascii?Q?7HE/MBKcDjPcf+VjxMYePJPYNq64Te/UJBT/bGGx8lRO7I2QzZfGDGGJZ5ys?=
 =?us-ascii?Q?92ktCOpKLXMib3Ufztpjm2ePsVAtLiz8RDACJ2IPwNfVV40dO8D1GxcZ2PXe?=
 =?us-ascii?Q?F0PpFA6FtxIkP7aJBMqsbmxL/K7v2BnQMjKoQ+qFFA1yGM8hKrIjhzdAVlih?=
 =?us-ascii?Q?gDrsUc7pjTPqMx0rIgTv+vk/htiF6gU9Uzu7Es7YiUZD3kR8e6wGow5AzHLO?=
 =?us-ascii?Q?ewRQt+NJqvvEdLN7GNr/lqacD4upfkp6kj7DZl3gh3sVJuPJRkxitPJ1nVLd?=
 =?us-ascii?Q?MkWNYIPM0Os5z1Ftk4MBvWasajFqSEBKbTRZ3PixUxtolnytKoGMcWJVlkfO?=
 =?us-ascii?Q?kPip/nsesUdJmGzAFYQURdGv93Ez+sepxQIDOoiQcVeT5EY1q5pqlaN7k4+4?=
 =?us-ascii?Q?ZpRqHRT8IjeYqaccX2VJTfhM3jtfw1upv+CyC89GZsGTXqbzFhmFreOI1ViW?=
 =?us-ascii?Q?ft8eK1hBBt1XC2HlrUfuTYcc712oXfzc8nAFgq393rz98MEB0JMmyyHXNS5v?=
 =?us-ascii?Q?wUYn5XlFrUkCzeZN6x4tzP1FMQxUZocUH+uRvlNtmmxY3zL5OVHQErs9uaPv?=
 =?us-ascii?Q?C9uAglPWvBxosgw/3X+aWO1rUL05UspToeY8roojs93TLwPUkRgQsVz/Ed65?=
 =?us-ascii?Q?cCQ+a0/GkDNs2ZchqPKhuR9fnFQ65b7YjzSBuuUsxnRtVQzAUTXI2Rz6mI3A?=
 =?us-ascii?Q?FdLRmrb1lcDN12iiIuuXHstpS/FZQzeYZ1IES0c62MO75FdUTmVLMB+MHjMz?=
 =?us-ascii?Q?7TdPAJqVYoTOjxAb5WomkqWb3HewKx3SE9HNCkUl5GABEynqKCUsJ7qQ0BmG?=
 =?us-ascii?Q?9RJTMwJTf8KN2BphFdgFHd14c019XbyN9gqYhJaFmDj9SRT/tci7m3aDxule?=
 =?us-ascii?Q?v3kMcjLvZPsgXFFi2otGxtM+1zBE5fAxm1Nl82QHfM53X9cRNl1WFDHP1ehn?=
 =?us-ascii?Q?6CHbmOt4VZkBjtjjij1Ta8eq6F1y9Jw9KhmMdrV6tn07cvVAueUfkmSGS6Z0?=
 =?us-ascii?Q?oskCkN/2TtA6Dvr4OPu/Go2Wl2kr0MBVtbb7p7AjHPFJX02xiqskZkTk/Ghq?=
 =?us-ascii?Q?cnNWzm+KaflojPtk1rYhAquG1FroWOSF7eWxTlpQvKGlBAuC6Ux92KyPRq7W?=
 =?us-ascii?Q?qW6VLcYgOZhYHfNOP/w5XOUkYfc+Qcjzy/gfWCGknpwm7KDq/U5ohEtbMmh6?=
 =?us-ascii?Q?02CBdmpYCOOTzMt+GrtWipPzrnEu6owaU1rbv7H2awRNgmhGYXHS0JPAOqNK?=
 =?us-ascii?Q?TyWZRohHvDqE0EKRyMZ/VQdl5wh9eayKyrq9GJdNspr+4WXIEmhFvshzRrU+?=
 =?us-ascii?Q?syWjby7kqIVW/NN7zOs1AeVdQlrMHc6+sTk3trzxjCrC4YGrTzszjYrG4GQf?=
 =?us-ascii?Q?Kq67NXucDdI0oI2Bn9UGCc0zn37zp8PC9nAW8F3RZSjf9fwKyn7qNRqEbe8F?=
 =?us-ascii?Q?ObKOANxazwpoqLIUSJ8CBevoOF2kY7CFFJ+TR/wl/oMZXYlKRkYxP7GX7JO5?=
 =?us-ascii?Q?q4bD+e9k+KUZlEjL0e0CEKCs4zKmA7fWC13iP4RKN/Hm1oPRt+VOF1HhNChM?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3e301f-55a7-4522-66db-08dcbf682cd8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 09:28:53.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj+zBM02KB/RTZIYpItmNiCqO8g1ODDzw4wrrhGt8Trol+ztiXOzgJTrI850SIQNyTqeIBJYJGB2xunCds0UXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

hi, Jeff,

On Thu, Aug 15, 2024 at 07:58:57PM -0700, Jeff Xu wrote:
> Hi Oliver

[...]

> > could you exlictly point to two commit-id?
> sure
> 
> this patch
> 8be7258a: mseal: add mseal syscall
> ff388fe5c: mseal: wire up mseal syscall

I failed to apply this patch set to "8be7258a: mseal: add mseal syscall"

to avoid the impact of other changes, better to apply the patch upon 8be7258a
directly.

if you prefer other base for this patch, please let us know. then we will
supply the results for 4 commits in fact:

this patch
the base of this patch
8be7258a: mseal: add mseal syscall
ff388fe5c: mseal: wire up mseal syscall

> 
> > >
> > > Thank you for your time and assistance in helping me on understanding
> > > this issue.
> >
> > due to resource constraint, please expect that we need several days to finish
> > this test request.
> No problem.
> 
> Thanks for your help!
> -Jeff
> 
> > >
> > > Best regards,
> > > -Jeff
> > >
> > > > -Jeff
> > > >
> > > > > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.com/
> > > > > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> > > > >
> > > > >
> > > > > Jeff Xu (2):
> > > > >   mseal:selftest mremap across VMA boundaries.
> > > > >   mseal: refactor mremap to remove can_modify_mm
> > > > >
> > > > >  mm/internal.h                           |  24 ++
> > > > >  mm/mremap.c                             |  77 +++----
> > > > >  mm/mseal.c                              |  17 --
> > > > >  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
> > > > >  4 files changed, 353 insertions(+), 58 deletions(-)
> > > > >
> > > > > --
> > > > > 2.46.0.76.ge559c4bf1a-goog
> > > > >

