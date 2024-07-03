Return-Path: <linux-kselftest+bounces-13126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848229253EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94AD1C2228D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D66EB64;
	Wed,  3 Jul 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7rcX5Nr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12732E400;
	Wed,  3 Jul 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989450; cv=fail; b=sS0eYMhLEJtkrdFtbTG1pgmBj30La5JWGxeNm036v1DfmufykaqOmeIzwUnJgnnZxxcJjE+EBWZ9WIh7a3XJCtSmBqFOA6VwpRrppnt0AAYh6ewnt201VRMhIXz8FLdZJ5M5bSqfYkpos1H9+LAX+j4Q/yTE5FItztozUDu0tAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989450; c=relaxed/simple;
	bh=OIRsygT3k3ok6h1NvZ2evymonrKDnt6jsJe6r4e7YhU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aESqqdmCwYnjXVvfZv5Thvj0M21DiNUulLlA6oQMSslTyGU8zG4p8Yg8ovpS6vTGyW7X4jr67JhANeD7FdxEe+gYyz3XY85Q5OkRf86y9+dHCdqogKq6ftGrTcPOBj3v3OH5Mg5oAMxfSGp7tY7Kk8X9ZMTS4eKijUQAWiHZHY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7rcX5Nr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719989449; x=1751525449;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OIRsygT3k3ok6h1NvZ2evymonrKDnt6jsJe6r4e7YhU=;
  b=i7rcX5Nrvkg5zHNupWvceqX6AOLGG6qM+NAt8qbSFLX8VjxWf7Ksb3Ek
   j4l38LoUd0Rv54BZjo8wPXDwLgMRAK2pDi4mSV+3fZFsRECiHFnD3rK9S
   JS+Y6djzCIC8PlmOroM4NwyM4i/mB+UWmCbSllqYDwAVUr3F+lfiCrnbD
   chQPd2irqrvjTqWSK3RieZTgNU3/wu5eDtBxnncqSvBpCldQBeQWhQWht
   tyEWcv/36rz1lYYhX+NkCv4aL6KyImMA5sKglmWJrE6Fj89kVvMDLNiDz
   Ksy5EjUk9GEGIxnQx7aMcZmbpwPsr0knyuFSRlTKl1EUBcK3QTNay1h3Y
   A==;
X-CSE-ConnectionGUID: Jcl2qg3eQy6sRts+YIQ72w==
X-CSE-MsgGUID: QWEaElpCS02Paot2S8EjwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28593396"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28593396"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:50:48 -0700
X-CSE-ConnectionGUID: Tcv644YYQ/WcjhUy8G1lnQ==
X-CSE-MsgGUID: pG/m7a17RoKS9Gjkc9W9nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46129833"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 23:50:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 23:50:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 23:50:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 23:50:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 23:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnm3GBupdQBhlQoUcPzEaUMg463/+RUCGU8kh9PFiLeWct6n2WxPdipG7vsrxo8HVVNR27pffKAk4KlmePDgM5pah2iNom1UdZrfuyOpZp+HMEvYlq2A2iRTni3IX8BwvXlUyQE+513rqaQHXIqcRlUzeTK31dEMNgBV7uln+jgoWzBAb9qlrEOr0wFR3PLWapsgEaMaPileLN/AOY6dg7z4iwdQalnDHGHU74tJ1PCOlJcNwf14jjt3DUZEy9f/t9yory7CMB4Q6/uAeeJBPp/odXDxutcLf/KD1530KI8oHYb8SK+4yUyF8k6pDCkYd7mC2JLla6pqEkmoUSg1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X76pqlHFUGBSk/HeyieInC+t1oO71l9V25ELDrMTbo=;
 b=a9EfWknfMf/u46xxs7rgTmF7ptt1x4gul6OyeNgddF8eKuzUMXH9Q2vNOQTXaTk9gJJPXcJuEpQkUY+q4q4tIOG9x51cexg3CFBpwrWbGQ4Cg7/H6K1uAZabg+LjQcVXZeGqD8SFJlikXdl6CTJPYlXoxCgp0WXmqXKym5uyk2xig8O3GFbbI7j+AaXxPtzRojqQAhb17cccPoNB0n7UNY/hzRkVBmjgrIMKsZNGxDWOXoqPYjaJpliBFsU/23sFCsRM/AGgrOfDJhMYLBVwjINjPUID9qGZtTdPWJEXN5JF6qH1moItdzKgsSDUwuRJFzn8JUSJnq+ZsEJa6HxQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 06:50:43 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 06:50:43 +0000
Date: Wed, 3 Jul 2024 08:50:27 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <evds3zyrwl3tgs7l6ppcg3bnvlxaewcetacuppek4uevx5i7lb@rj7ciugpp5u3>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0641d694-d96d-426d-76f3-08dc9b2c7569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?aLD6xIJQKTZ3sx8ULV/3AHltAtjvlCxSMN8PEj9EE6Zi0ZeQwECy7WVyOs?=
 =?iso-8859-1?Q?Y2k6vpL2p+NXkIMFJS+1UsKKVwxN+zeBU7jai2Z0KOZKqE8Kj6XYjarCH9?=
 =?iso-8859-1?Q?e2mbmxL2mXSve0KcoYXN0kiy4G3ecozjzl4ldaC4xXNzTKDEJlc1f7Fcro?=
 =?iso-8859-1?Q?bQ3k5UxCQujJZfX4qOenaVp7mt5Tqz54BjuhHQ+ZgZeFn3aH9LGYrzpkw8?=
 =?iso-8859-1?Q?/Gm53b8L+6d/AgkMjksCCpBBQzmWmT07W4h7/kA3vWG2jNFYzOV5P72XCA?=
 =?iso-8859-1?Q?HV1z9sgV9mVGUTsvcKpbBxrQtXhT5wWcn4PesS4SOReK47P6HlU3u4nyG8?=
 =?iso-8859-1?Q?o23GeU38oNnPe9zdOjz5A0iq4leQt2xq4WdoV3OGfqFeqHe9Nw50/QD2Ca?=
 =?iso-8859-1?Q?4B7hdofGyE3jeyQeiFQNPaYKvm9gLsV6qEIucoe4aKKnzj6Y/i1eD7NH6B?=
 =?iso-8859-1?Q?ntXxkeMniWRfRC6OYVFiLmwCjL6VY+RWnnuZlFCPGhmQLr58/5H+SIZL4y?=
 =?iso-8859-1?Q?L65CrP49uRdq5EicY6YuglHdNbh0iPcsEHcu63Mr2gCQyX4qosYuCwLGF6?=
 =?iso-8859-1?Q?wFsJTKYwcVHQZDmExiF9wTA9G2grluNGdsyoJuSQPn149VHS7nCLMev11o?=
 =?iso-8859-1?Q?RkY+LFSb62n8vG9+UEi78ASphXrGuLzlxS+rZL/EnaJHbPLcEblFOr1MdO?=
 =?iso-8859-1?Q?vYGfXtv3dSRuSk8//unz+miPzcOvIcah6abxsWHO8W1LbPZKxO3ZqpEQwv?=
 =?iso-8859-1?Q?LiiaLQgfqecdrJ16+2QzQW8/2w8DD5eKfBDKcEF4ubzyfUDxTSO0js/gSd?=
 =?iso-8859-1?Q?Yjosf3hw2OBeF78ur8t/LOZbGkH0cZWlsGHzt6XPmrxot4WGxMisX+1o3u?=
 =?iso-8859-1?Q?Oi9T6LgGKhVuT9aUb9Y6s7fbAQF8bbSlxqZWfBq6rpoZWURmAihhFD8UyV?=
 =?iso-8859-1?Q?EgyJF+WVDWPdbmLnECSIEBVYi9Uwmz+a1sH98miE4aTYNgRhVgUuHLeJpQ?=
 =?iso-8859-1?Q?g+7JoqRKqF+SQgP5NdVsCD+rXNOjF6GBA2SOhjvpwhk35VeiQXmWOv/hww?=
 =?iso-8859-1?Q?HqbY6lYP/4byHRRcvfT6EB9KpdfvEKSKezB6RDA01dOj5F+4inluf0HvBj?=
 =?iso-8859-1?Q?/zep5x6aP4wBi3CFXhK487u478csfjWLLqPSXmX4zUax+Z/XlW3Zun7ykr?=
 =?iso-8859-1?Q?PaZFGyW1qCAvWbYbhacpndFTwpeycwllBwh/zoVlFxim62fmr/ff2YtGEZ?=
 =?iso-8859-1?Q?+h09Cr1LEtujzhytwMVMCFdjjwR1wsoM0olUQi2nQmrDkPCierY/abWt7s?=
 =?iso-8859-1?Q?58ZF3/bG/jmFd9AigGVB0Zai6+mD0txw3DpRFgtc5/GE8qe0HCVwjp6jci?=
 =?iso-8859-1?Q?X9Do2dK41nDRbvtOFuU6/QPXnyqottxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5vq0Z62YDq7vzJFyBgF7abQtJQ0s18CoNVFHp8fsv9yCJQeGQuN3uffZjX?=
 =?iso-8859-1?Q?zxSCJbgkvAhGDj5nfRkdUN16OE+dwypDRTEIuuVBY1qF/+2/KdRMlJ6p3W?=
 =?iso-8859-1?Q?OZqzg+gA0LBM1okTznlVUxDx0hzaB3RWdvWBFkf3/Hi1uccXRADk+Sw1mL?=
 =?iso-8859-1?Q?QB/uYrF+oZhi/5QkmFAsxcWcAo8WbmyoUS5ZukwbVUDjxSgO+m1r0gIXRz?=
 =?iso-8859-1?Q?j/bkTatCPkZxrj/DsxSD+OfAoNjVp1W5Yq7JVDBvf/jW5pxGZvkxppTQ5Y?=
 =?iso-8859-1?Q?KK25Dkq4PP1GsP+j1abtCP8AAxPhcPFN/5Mz4KQxt8GIbUHA2EUu8iNQDd?=
 =?iso-8859-1?Q?gcU2NlVFzpIqGKfplRyZ9luooVsAWPgt83VhSFZjtd+4YwMZZQ4CNQhhmB?=
 =?iso-8859-1?Q?ple+MObNbhXEnuLvKDMDtNzcgFCoxwfkNC9c69KA+y2VAA3SUeYCMIqk7b?=
 =?iso-8859-1?Q?69DwJsuSfwpXjA6Z0mS2FPPOcdJEx39TyRagf1thgnUOrPtMAsbgRj7cZ5?=
 =?iso-8859-1?Q?hubfI9CI/xv3sFst6Kk8urMniBdsMGTRkfzMK6xnCeIeZarVODzd/mOd06?=
 =?iso-8859-1?Q?tpDa2tH+GXksFQJMU1m7SIOWzq/XgMjiytt++QNn+dt0u3ChsS0bNBF07k?=
 =?iso-8859-1?Q?TeibQI23uTCtxIV5D8Hrn62ZWLORqwVF9OXPq7YKuEzbDX3eDaFYHDg1gi?=
 =?iso-8859-1?Q?a0w3uG4ZJRRAK7VnzJ0URFOsSeW52U3E36L47YTTOwxFN5oQIpEkar6c9l?=
 =?iso-8859-1?Q?WIr8AQQjK+tmguaw+wr2aJa6goz5rCYEnXJA9Gt9tr2kE2pY/Eix0iBrEq?=
 =?iso-8859-1?Q?sps6npT7Qb4P1GNM3B5vBBUHXyNseuoZmK+ixBBHdVS8pIqMfQSDo2rHc+?=
 =?iso-8859-1?Q?+XGctQbtbIUt8xVbeywNdFF9wLis1iZ9llE0fy87oTkQpMQRoD1wuLd8wI?=
 =?iso-8859-1?Q?mqKFnschaA/6bEqzaEJ2QgEr7tJTbB3kv2uFmDJ5XIiwh1A6zYZeS3ZEOM?=
 =?iso-8859-1?Q?p9ECwpAOWen65mPptafhxZ/2mFBuD8LGtJciig8gf/YTDMOtZvsg0OhuGr?=
 =?iso-8859-1?Q?4cu8oVpFzgAGf3mBSq23T2/qkxhfFjbImeWiAjfqIotAj16fyZuAfaXrLM?=
 =?iso-8859-1?Q?E6nIil5piJK1szMPTs/vbJKBnDzcHhCY50hLFrb2hzfRZe6Cb9pglM84TF?=
 =?iso-8859-1?Q?ej3pyBsuLJat0WnGaV+7y1TPgzP04DII0MmguPwbNvMPTMPGbomQKlD1f0?=
 =?iso-8859-1?Q?aBeQFKymjwvTfhseA23v8KK0hBWpNND0gG8AVUzIOvyrlxc3PrYxqNSJyJ?=
 =?iso-8859-1?Q?Z8hUb4jlzqO1Y3DosP0T/8nXZLor8OzKEd9XUWHzCrXjqgfvWUnDjU+ERN?=
 =?iso-8859-1?Q?BuZEvVQqTI27e8xLsdSUkogE12huWXZv06AltWHFD5vysp2lJC3i+zaBA7?=
 =?iso-8859-1?Q?2apjDZR+a6rI4LJfsHfgsMXy19O7nS4Ak4QKJMJiNoy2ZqoF8lBQgIyNyT?=
 =?iso-8859-1?Q?CVaUe7iLtvI/92TaNI9MwxAst1s872ol3fZAW7sPKAJ3tfcR+15TnLJUsL?=
 =?iso-8859-1?Q?58p6Yl9fQsg7mATqxIYy1YVNNvVEOdVJiEMQamtt+DtZ/eQpTa2Leh7JfA?=
 =?iso-8859-1?Q?WONK/2y2kfmDSZL2gTeULBtqQQZ/WiuZZ4UQb8qbRCo+woicMAW4IhOzq0?=
 =?iso-8859-1?Q?UX9alnw2f3cQKg+VyaI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0641d694-d96d-426d-76f3-08dc9b2c7569
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 06:50:43.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPQz3kbnFE/SKB+MOj5APnHyEYBJscLY05sxaCkerReHPUTrJTqhMHd92yQarKak87YBc/jQ4ti4Q04tfS2B3URNR+BTQnwxB6iRr2ZIuHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com

Thanks for the review,

On 2024-07-01 at 18:04:00 +0200, Luck, Tony wrote:
>+static bool cpus_offline_empty(void)
>+{
>+	char offline_cpus_str[64];
>+	FILE *fp;
>+
>+	fp = fopen("/sys/devices/system/cpu/offline", "r");
>
>Check for fp == NULL before using it.

Thanks, will add it.

>
>+	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
>
>fscanf() seems like a heavy hammer.
>
>	if (fgets(offline_cpus_str, sizeof(offline_cpus_str), fp) == NULL) {
>+		if (!errno) {
>
>Don't need an errno check (seems dubious mixing errno with stdio).

fscanf() returns "-1" when nothing was read as well as if there was an error.
But when nothing was read the errno is "0" instead of some error code so I could
differentiate the cases that way. The fgetc() you settled on shouldn't have this
problem.

>
>+			fclose(fp);
>+			return 1;
>
>			return true;
>
>+		}
>+		ksft_perror("Could not read offline CPUs file!");
>+	}
>+
>+	fclose(fp);
>+
>+	return 0;
>
>	return false;
>+}
>

-- 
Kind regards
Maciej Wieczór-Retman

