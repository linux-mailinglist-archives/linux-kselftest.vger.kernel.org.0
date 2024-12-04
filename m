Return-Path: <linux-kselftest+bounces-22824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0D9E3999
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 13:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7635CB23DD2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328101B0F18;
	Wed,  4 Dec 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHM1s3UB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044F192D68;
	Wed,  4 Dec 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311865; cv=fail; b=OFHo7ozZ4GhXJxUx+a6kYIU2Fl2dnFlaELG8pqxJNMZ3GUKy+jce3JfVFCbxOIYHzFWk6ewU1gCBFGwbsRY7GMKGr/s6FOrxOrhUuMDETowEQSeWfGE3Cw7VCdYJJFYG+jk8pMywcIOFkEBkf7ueaGxgWxrh8j6zwDdbZ5o7dvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311865; c=relaxed/simple;
	bh=d/D5fkxDgnu511DHfOIaQwg8fo3bWq10eK1BbB8mCjY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JywW2bulT4VJpxo4hMhzol4QFVrXeBz7PYH7OmAOnAfHAYI6ZXzER90LN5/pm14JJ1eZtxKD1cT1EFZOlFeI93mSjZRjnVsJMJGyyI9rAK0HZf2IKX1XI//eR7sLg+HPaP4XjFo5/z6VXp1bAwz0gVxLLb2kGzyn7U+FMEA2pLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHM1s3UB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733311864; x=1764847864;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=d/D5fkxDgnu511DHfOIaQwg8fo3bWq10eK1BbB8mCjY=;
  b=lHM1s3UB1Q5RPIXmgKZifOvf2cn7n5JjuxNEr3RR3InwJH/TaznHtK5E
   YqMnioW6bKNjLMqRR9WGm0o4Vm3wbODq/RbLo2UTJe8H5XpRLxSA3pItq
   yrAs7+fVRtRb7ZIqQwrUjO0nsrbbgefxndhc7N7H1Y+rE4gX3Pu115yNK
   egC5iVsLEKI2BGJOmaX8m3beVaxayEFmQdvtqZ430nZnHfhqMJC/Li0Qk
   0j/najjtTxvmq/u464Nraj2TdE0VvLwjaklElZ1HMtCyFpdWUyyqMw+rN
   hxX+F9MNiaUneHYqdVW1ibuh6NQrx9SKckDOotL+D7fj/Hwg/S0LIB3qV
   A==;
X-CSE-ConnectionGUID: eLJCVo/tTp2N2KZ17U1RRw==
X-CSE-MsgGUID: UEujlmi4TxSYZjCyjJr8LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44235822"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44235822"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:31:03 -0800
X-CSE-ConnectionGUID: B2zoevylRx6U/cHnNAuZ3w==
X-CSE-MsgGUID: 0ijzmGoBTrqUl72vp/+m5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98558536"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 03:31:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 03:31:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 03:31:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 03:31:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TagVh2iwipctN51X3AzS87K8BqIys9mhivdHXPQErB62ikjZz08oD/b+xe/QpcDLpc5lTz52aDXfPpN7cSNbZuMv5FP8ZIKPlgrZ3PbvjXmHPhoKDHMtvFZuzXWc9Q1A+tqiEBvFIQ3EZVK85gNakR6UMo+sPAWOE1M9wl9RYkYk4VK7Ux8VGXG39dueSRa8BV1pC+G8tvFO1Nx1+qewDTLODMATUeAJRdPeyc/GnBFDU/dlkTKGdnT47IvZ7JEvdtDMv2L63W1c4yhwutRsEejSR461lwo/DP/8fvn19XQI39iAy/817NwSCnlsn9CUBtXvpLn/7BfuFUZU06MuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JJ5qPIHAreRUtyQMvYo+Gnh9smjCJlVbaL3lmdwcu0=;
 b=FG6IqPRHjJ8pK+BbWmDSSknhOauK55/ecWpFUeyx2BrMbVRgyLf7CuUwiMoSNbZWE+4Qs9zMvGwFIedy6vMkG3DtpJ4PQ7kgZKDOuByq8KeByRmbzgWtR2Sl9k+uB0Rq7m3ZJF2RjDByqvcp4QnoNe4bHWZzsFDAQmZNkkl3RJUqvSIU3SeFRidrTTrFCilGZiVYQcIOwdkAiLQ6ZXLAKBpya4TVj0T6czrd8Ki7DzMnfQz+EeqeGVBcdsTCr3S5/C2ZGs8AvBC8R2jBsGlodsMODM0IUBbhqnAY8xz+/mpi//vipBfbGZ/ffoaT7CecpOTid5j/APnqgsSlA/ZZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 11:31:00 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 11:30:57 +0000
Date: Wed, 4 Dec 2024 12:30:53 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v6 2/2] selftests/resctrl: Discover SNC kernel support
 and adjust messages
Message-ID: <wwkagup7s7xgwiwz2cto5z7zwi2z6qqjz2mrdolq7cghr5w23y@edoefyeytrvz>
References: <cover.1733136454.git.maciej.wieczor-retman@intel.com>
 <6b0fee7f5d97f8140442a73ecdd50429cd697938.1733136454.git.maciej.wieczor-retman@intel.com>
 <d89e6cbc-c0fa-40de-99f0-34a3095ee296@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d89e6cbc-c0fa-40de-99f0-34a3095ee296@intel.com>
X-ClientProxiedBy: DUZPR01CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::8) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 060b69c1-106d-479b-77ed-08dd14571f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YDDXJOTzmMenfiDuwHR8R0EgwjzasqeljHTqRQMimcCZWioDcC4BW8nYfN?=
 =?iso-8859-1?Q?BX4RgrbXnmSVWHKMW8EjBcdo+bsXZWIoUxoOGYJy+3HRgbJ1nXTTqWebvf?=
 =?iso-8859-1?Q?W+Vr9V+zCQ0cfU/uO145MFcUYZJYqoKitpbPKH1w6uk9z6Emi7kIEtw4q7?=
 =?iso-8859-1?Q?d/nJPfbm0Jc+KCq5FN3Gi0FrzaugUXGUZtR2wTrSeQYfLdFk9FyDwuKfXv?=
 =?iso-8859-1?Q?FTfyv/o2Cg9Qa5stbYuApKJ7+at1f7aYCm+PMEO6FUBc6Gomhh0j8dFz0Q?=
 =?iso-8859-1?Q?jHQSubJSN/xl41gK4Cqdmw2A/8s0SLgVrJ3wA5blbLiqkA7gA69RJnUqdC?=
 =?iso-8859-1?Q?ILnyAvOArO6THNl/TQdokV6Huz9LZqaMQ2VgewTW39Ti75shZBtu4/1FqK?=
 =?iso-8859-1?Q?JOCiZGkT56sp6Q89gm90CnR85dmjeB4RfQbI5xo9BRJlAv5NtivZtUpNIw?=
 =?iso-8859-1?Q?4Wq2raidEXNK2QqmQL46kK9TfkF8Uv+9iUe1RNw08MAUwOqnUWrZSD5x+0?=
 =?iso-8859-1?Q?9H9cn1M517YXtt2HrlzmEl9Ev+1gsLTKwOUS+kY+N0C2JCJsGzBXTBma50?=
 =?iso-8859-1?Q?C888qRYcHvXEN5+8blcFma5OTZQtmVWvw81LbAvHxmw8eOrqpECoghj8uz?=
 =?iso-8859-1?Q?kGNVzYMkZQ5fqFJI381ocYCcla0kLGCJbg1eoH+fJtjel3e+zrtUU+IoC4?=
 =?iso-8859-1?Q?LsOVC9PBVZ3C7WDOdtxp2won4ZBDkTsADN5UaBFrytO93Nuu/mYnw1fVZi?=
 =?iso-8859-1?Q?E4WH8YbdNbqOHjcMcgBsD9b4j9GygOksQyYcTMv0bUJWhFVUbSz1C20UAN?=
 =?iso-8859-1?Q?1/l/g68nHlUp/yJz41i50QGkTwizEi7LBMMUK7ST+u1Z8ug4PKx8UdQ9Z3?=
 =?iso-8859-1?Q?Qn5wWSkxGpN5J94eqAMwQ+m+V/kBqhx9vDxxHMSesQXgE7petz/IVBRJTB?=
 =?iso-8859-1?Q?Bd20XW9WguXQ4hMogyjDQ8DgFSBQUf+7RcGvfCqNNzEFJ3JjVhzUTpwnac?=
 =?iso-8859-1?Q?WuUvl0yWXxEa7VrZ6r+0Zh8BwOLtMfAUHYM4r96JZi9iz/83Wc84tiHjw2?=
 =?iso-8859-1?Q?jJSG7PesQbnXyFo3SPXCfJQJVJye2EZIB7tKbrGgYeRcWp4Aiv7GipJFMU?=
 =?iso-8859-1?Q?sY8hpedYxyLM0HSFS1p0yMmbA62mKNho8icU3HDcYdFVRGmhC8G4heV5wv?=
 =?iso-8859-1?Q?QtSHFVzND849TvK/rFU+k1TLE6gz5Q6iaIOJMVy9ZLpRKEbProDt2MUCW3?=
 =?iso-8859-1?Q?/K00bZja0swhEcLPc0tKtlEnmI6Og6pKC+BMznruySIrqE4Md92hUVhaSB?=
 =?iso-8859-1?Q?9REtDxsxTYjA+ZtMhfOK29WxtvPfMVM1qYshoi8Ch5L4pVSgvkIwxI8BNa?=
 =?iso-8859-1?Q?5PET3r3GIfVp07s2Wckym/2KWBzlsFh4WiJ5o+kVGhVtpEXDhfobQnia0g?=
 =?iso-8859-1?Q?4C2d7TXgaGOs4/ivmgcvQlpMt5kwPFSvS+4DgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xboWpWQpP+CjpgdaSpjTuEXynJxvs89VOnZnUhFxvnK7FTJx4EDuZ1PvvS?=
 =?iso-8859-1?Q?ROVUwBdy9YtbdZwQp05kj+AuMfN09ubieSZPZxdF6/4zhRoLIBFrGa+ZJd?=
 =?iso-8859-1?Q?YeXsfgRcXMXS3M53/xNt6umQfSJtHR4ROotKmKSRmoaTwzEsiuuSdtUPOG?=
 =?iso-8859-1?Q?4cZyL1nsFMFepbv1nEslEugYRaPwlUCZl/uY17bWLRyihLs1pbB83IxTlg?=
 =?iso-8859-1?Q?uKmXc5zRuISO1Y7kZkEISu0/+ZJe4+RUv/6G0mRISaJCDnfAXSTLjdiLoI?=
 =?iso-8859-1?Q?jJT3Huy6OeWlJnrMsTUd7Ps/L6uUY25k6BNLnKAAbYZHZKTLTs33sdBwWv?=
 =?iso-8859-1?Q?l269CzwTFeVBQIE7c33IvBTnrrRQT6u9SBQZsIm8XSWy4GfexUqDOMn/eU?=
 =?iso-8859-1?Q?+p9jfaIJeqVKCUuF7k/yCUk2xNCN3JMukjEKulHnR3UpuGhBfaQPrux1Bk?=
 =?iso-8859-1?Q?8YHPrPHmwOWgQgjYHjd0RxIzjgNUhR5278Lu+nNpJL0fpk1ksf3sE+Qzxc?=
 =?iso-8859-1?Q?Dj4cKjLX/6+mkBdy4ZE+vB0WlcXmhgj4sclaM2I9M3lKTQqLfhWcUOsWj/?=
 =?iso-8859-1?Q?JEk6eSwvPXGee8TimkYMP/jotTzXGoMg2GyxXamHRLW4QPROwdLqLsTSXx?=
 =?iso-8859-1?Q?MzSfZhQX5kN+yF3g93jEVW9DEiJ6YeG1sc26ZKHmVFaifpJjtEDz5M1D9W?=
 =?iso-8859-1?Q?iX7X5aFOYCXh5L+CDYf2h1A/27xDU8lOGhrvcqn7C9eNVqPrFdTy+pgB3c?=
 =?iso-8859-1?Q?uAr5ZxkhRbBHHZhkrXD8EH/vcOYmkEMsfbEu17bbpark8dCoK5RIHxepqy?=
 =?iso-8859-1?Q?g8sMR7SS2sXP5y9ufo/uxO4iHRAJ1FunZfSMXgftGtueUfx1bhZLl2PYJU?=
 =?iso-8859-1?Q?f2lEwRBq3mhMePe8HoBdkbZdmZ/E04KocmcqxvcKatkLG1AykvLRY5zGuc?=
 =?iso-8859-1?Q?+4rW6Ow8QhPhQzIvTEZlsBvBkgVDwKuwgPF8jglZBzPYkni1R7nNux4i/D?=
 =?iso-8859-1?Q?nQxXKBNEXR2dfRnqbI9Fn6+s8DNy2hhY9cbr0NHysyLfVemTaxOq+3pHcL?=
 =?iso-8859-1?Q?lU5OilceoSM5cgJu+OMHZRx/V9D+2kNERcZDdURJ3nB/DElzU2vl4wCdRE?=
 =?iso-8859-1?Q?SdK+lYkwN6C45fuN2nwgZG5SmGrdvfiKxXBOHfs9YbFrC8ZHwFzMSGqsoU?=
 =?iso-8859-1?Q?tpLbwRNiL246T5ARE2ZNlh+oZhs5wLAwZ3BPeP4P98kPsjjiPHktY7fkJ+?=
 =?iso-8859-1?Q?Fm7IXcGmJwk73r9M7avQ+AWEY0Bs98Bi5HwCnpsn0GWdm+Fzij8xhTrdGF?=
 =?iso-8859-1?Q?LvCkq87gY8XWlUL8HXFb+lEFda6ANsPj7BVzVEZZj4QI1sP2oEHmomrUPo?=
 =?iso-8859-1?Q?dw/j86MLsgM6Wj4TjIJzEhXho5Tq39klu6IqCZMrTj94uuObz6XL4FrV/d?=
 =?iso-8859-1?Q?vaqY99HjdplPIw+imtd267uhQ4wWuxElLxVuE+lzlFxhSL5bBOSQnC/yIZ?=
 =?iso-8859-1?Q?u5HLmSOgZqWqR1Yaiy5PVsQQlo9SqQpQ/cd7lmoQOzoPDrUgYrzTD8hWdy?=
 =?iso-8859-1?Q?UTiINeQtDe/eh9ZfLa5Y0UdOSbj4NpYYqn5lSzyD9Zd07ZKXj5hMcwG8L3?=
 =?iso-8859-1?Q?MpbzsDJtn4IbKdbJlStBrZ0OGQyN9tuWxn48VnfnirBapQjr4XdSESNOmC?=
 =?iso-8859-1?Q?irq6+nVULrV4tsEIgcs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 060b69c1-106d-479b-77ed-08dd14571f31
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:30:57.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGXyvzCIJIJIgHb1uv4gTdB+NQkkjt9YXmpUsh988/sGRmkXhDguREbwYE2mGLXkwYyhuGHK8Ew0HW5g5gOhDK1wDQrfwNKMRLMuq+EGv8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com

On 2024-12-03 at 15:30:56 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/2/24 3:08 AM, Maciej Wieczor-Retman wrote:
>
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 50561993d37c..d0a5c0f78397 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -949,3 +949,35 @@ unsigned int count_bits(unsigned long n)
>>  
>>  	return count;
>>  }
>> +
>> +/**
>> + * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
>> + * SNC resctrl support on the kernel side.
>> + *
>> + * Return: 0 if not supported, 1 if SNC is disabled or SNC discovery is
>> + * unreliable or SNC is both enabled and supported.
>> + */
>> +int snc_kernel_support(void)
>> +{
>> +	char node_path[PATH_MAX];
>> +	struct stat statbuf;
>> +	int ret;
>> +
>> +	ret = snc_nodes_per_l3_cache();
>> +	/*
>> +	 * If SNC is disabled then its kernel support isn't important. If SNC
>> +	 * got disabled because the discovery process was unreliable the
>> +	 * snc_unreliable variable was set. It can be used to verify the SNC
>> +	 * discovery reliability elsewhere in the selftest.
>> +	 */
>> +	if (ret == 1)
>> +		return ret;
>> +
>> +	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
>> +		 "mon_L3_00/mon_sub_L3_00");
>
>The patch looks good. I am curious why the string constants are split in two and not,
>for example, a single constant of "mon_data/mon_L3_00/mon_sub_L3_00"?

I think I introduced this inconsistency by accident when trying to follow the
example of other snprintf calls. You're right, there's not reason it can't be
just "mon_data/mon_L3_00/mon_sub_L3_00". I'll fix it in the next version. Thanks :)

>
>> +
>> +	if (!stat(node_path, &statbuf))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

