Return-Path: <linux-kselftest+bounces-25311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C971CA20C9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA643A1CEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31731ACEDD;
	Tue, 28 Jan 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRIQ96aj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8418DF86;
	Tue, 28 Jan 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076741; cv=fail; b=N1GCGEIm7fMOnBFquuLiAHmB2613e2l/Wnb2VVCA6lJGW1mnO++1N3ZM+7lfEBjpGp0w2yzau6c/GYqKnE+SnWKI0HxAFH+p+vnFe/byZ/2rz828THbDz6VIRW+deKEdh6uvZZFdIzL9Y1bJoKyPHXjSGq4rTuItwzMHqxWNlJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076741; c=relaxed/simple;
	bh=DQZUp2vkYRTJgZXLjszM+3ZB7+ZzDmG1RIF1EyWX4ic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyXkl2/YTHQPjhR/yXZySFi4/ixcux94GSqayz5YWVeYq5Q1qlKvo/0Ut9+kQQvjczy9F8r+jsGU7UjE1RIXB4NNr81jE862LDf/ZZKXumcjAnt5kW+EWA666cyvv5FxwPHKjfpSr2rhsjlOAnIAuG/GVGNFeazlJvzft6oyaEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRIQ96aj; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738076740; x=1769612740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DQZUp2vkYRTJgZXLjszM+3ZB7+ZzDmG1RIF1EyWX4ic=;
  b=dRIQ96aj6h4wkeCh36TZYXRR1mqEXoGSaFE4zfqkexlt1RBMy+3qJoGb
   nGl/PvmSKw3t2afU+RUgTIXvREN+384/T1TyPGSK5zkRJvnMOzk0dWalA
   VBTqNzaVPeoNG/THHGA9KrV7k0Lcgawj3Wj9Li2T5TCA01fW+m2/pRcTL
   3ucJ43EcudPLeA5VZMNUEpZkedTY8yKOkwPxA0iTn6pO07tjhISkGngwo
   N3PeOLtGUhMCmaqGziBH9vJos+iauAVHbGqTNQqFPj00CFK2N6RMq5MdW
   5y73/UGQYd4k53zKvUdY6ZIdb1XOZ6U5UO6HpXXMPzE2tT6IkO6l5NPfX
   A==;
X-CSE-ConnectionGUID: +9L0npZuTTanOJAFLHIDXw==
X-CSE-MsgGUID: LbTfteHSTNa8Ft/RUFzv2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38597195"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="38597195"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 07:05:39 -0800
X-CSE-ConnectionGUID: u4n85xpaQXCtvcMYtpSMxQ==
X-CSE-MsgGUID: q6B9q60dQaGsyKvW4XpWjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="109334292"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2025 07:05:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 28 Jan 2025 07:05:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 28 Jan 2025 07:05:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 28 Jan 2025 07:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6RbBEDL05q3MDOtLI6llYe/28vV+N0U+CgYBellZOzC97on4pHubSTAszl+R7/vvQZrthmkBVZ9LaOeNc+Pb0IiEOoAGAqsr4z/neZ1AROIFNlr6+SR3ZWYRphG6EDq3m+mp9fBTHsNjhRslEbzhDJdnyEIRaSx4tQlP9yNeMwVrNj216poHBTMdbC1dsyJqKsUirxfnm/hUtz/OR6xCDRhCHFnTvzl6xQbJEszaUQFPue5WomtGIXDdI6I63pE3rV0xDSlftsxl2yFs/4L8h2CAGGfUT5BCsKa+oVSYVFjGJY9gMixZY8JjL7QR+e7UDTZoL3CDo9x75o42v8GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+hAtAqcbmw7vzp8y97iM83ShoGsfjDbyPTiURjOMeo=;
 b=Yy8pOcAsxx3ElQ1BsCv1qajZNO3C/64/t7J2X/iJBsvi+vleCb+aAhb13aOdyl0/rDAr9Uiw+mTKzxRGC5R26JkBe0lePf5W2B8V5mpVJmEoDWcTxQRKzz1HJEDwerLXOm970fUTh8cFWIuYDnu532nRNgPN7T6CiNcwzA5HxImte0lrk1H/eEhD9Gw+DUAFSE3+se72NR1MJGY0254GQNo4w4z56Pz7J89tZQCCV+2cB4ZW8Bb+4/b6085UtLj72kwh9CrFOB/zATyVtFFloMQwPbjVX/QZss2+lexJ3Ich+MKpOZirPeTwmyvkC+WlbvvareZHfFVjy6tmIq6XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 15:05:23 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 15:05:22 +0000
Message-ID: <332c50f5-3c68-4fce-8bb3-161f76f2119c@intel.com>
Date: Tue, 28 Jan 2025 16:03:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Fix mix-up of 4096 and page size.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Saket Kumar Bhaskar
	<skb99@linux.ibm.com>
CC: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Hari
 Bathini" <hbathini@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z
	<eddyz87@gmail.com>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>
References: <20250122183720.1411176-1-skb99@linux.ibm.com>
 <CAADnVQJcmyMmxPfSaKgqMiCDZP=Pe8-Jf7NnEdfgxejvZr+44g@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJcmyMmxPfSaKgqMiCDZP=Pe8-Jf7NnEdfgxejvZr+44g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 676e21b3-be9a-4a76-9ce2-08dd3fad300d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VENEUnA4MmJEbjNhdENDQ2k2eFhmVm1aVGgrbEUydU81QnQvUWZTaFowOVIw?=
 =?utf-8?B?cjkxQzB6enZhU2V6bktqMk5PVUNmWUdia0NZcVlreUgvSlYxdlQxQnMxc0xW?=
 =?utf-8?B?YUE3ajliWHhpd1BWVEl5ODBKKy85cWlYRW9IZjFoNmpKTDRSeW1DT0FtWHVR?=
 =?utf-8?B?OTNqR00rZHVJVEpZRFIxS3RyWmx1TWFOdFJYSlJYQThUT3pjSGJvaDlBOFdG?=
 =?utf-8?B?aURkRDBtRUNXZFg0ZlpjbnpnSXZXRTZWR09kWnlUQ1hSNk1sK0FqNkJBdTJu?=
 =?utf-8?B?eXMvMEFGUEVHVFJHU3FITEMweHFVWUdBUWlmTjJPTUY4TWdabURvVElEK0JY?=
 =?utf-8?B?amJDU3Vack5keEtMWnVQRTJpRjNHbjl0bisxdkhLZDZqdzFIT2FvMS95cTVr?=
 =?utf-8?B?MUpkU0w1RmpQVll0Smhrd1JiYmwvTlo0akw3c21DZlBKTVlmb1N1Y25DampF?=
 =?utf-8?B?NEZxZUtWa0RmYlVCME11WEJweHNGREhlSmRidXFXNGgzTmYwVWluWXFTR2FB?=
 =?utf-8?B?ckM2YjhzTUdYV1p0QUdTaDIwY05Dd3U4azAwNStaL1pQZzdiTXd4K3ZjZ2ZN?=
 =?utf-8?B?QUdhT0svWE1wTTBZcEFtVGg5Z0I5WE9YckpOOXcwR05TbENDMUVXT1JWOHBB?=
 =?utf-8?B?WWhQOXhzSzhBRGVtVGw4ZWl5MjJIZ09VSGVNVDBwVE15a2ZCMzRFL2hBWXJj?=
 =?utf-8?B?UmxYMnMrQ0RhS21ocHBSeU9Da0FOSTFvdzY5cElMRHUzREFTSnRCczYydnhk?=
 =?utf-8?B?Q3RNWlMxRzI3OUplMGN6MURoSWhVVHVBZ0ZYNmM5c0NxMFd1YkpUWDcrVFJv?=
 =?utf-8?B?OUNHZ3ZMc2pyTDIvb3RueTRYWC9MTEdnbytCeUJaOUowaURGMWhWWHZWOHRj?=
 =?utf-8?B?NjJIZjNscW1vYlBtMUZDMzVEcTcxamg1Y2RaeTJzSEhVWWF1ZzV3alhIaGJM?=
 =?utf-8?B?Q1hWOW9zcWlDSi92NE9ud25jQU5zYUtWMUk0UURZQndHdXFTcVRDYUcveHFl?=
 =?utf-8?B?bytBb3Flc2VSL1lIQ1I1Zkl6TzVZSjE5S1JrWGhqaFdBOTBPTEtIejg5cThC?=
 =?utf-8?B?eGNqWVNhQjFLUG8xNXNVY3hjcEhIdUU5SStRUHNhdlNlelVVeTgwS0luZ01W?=
 =?utf-8?B?c01oNGowNkhLY0hrNVQrYjU0Y091NG1tZ2c0RUpTQmpVOVdxSmNYOEhFS1oz?=
 =?utf-8?B?eUUyc0FZV01ybVBwRnBLdFA1bkFyUUsyWHhjY0g2SGlWZ2ZBcTlJNXV1VFh0?=
 =?utf-8?B?b0xYS3VGOFV1MHlldFFSMGpYWWtERUdwTC9Sck5mTDc4OWxZbWlVczJ2WmJt?=
 =?utf-8?B?WEdVejNscVkzOHZNbGhYSWZLaGFuZVlJbUwxSS82QzFFazlxYVhzRDhEekxs?=
 =?utf-8?B?dU5nbzQwVXcrOFhOMzBrL3BOWWVocVNIdG1GalUyVk9vS1pkWGx1bTZZVGta?=
 =?utf-8?B?Vzhjb3VpTkQvVVJ4QVZ4RkFzaWF1MUhNRUhqakdDdWFYTUJDV3pkMlVWb0Vz?=
 =?utf-8?B?ZURxbjFBN0JvZjlqSFQxV3FsdFJFa0Z4RjNZd1Btd3R4bDZvK0trWWo3OE1k?=
 =?utf-8?B?b3djN0dTTkI1ZWxPbkFJQ3d5RFFmblhFRE5hR1Z4RTUvUW50TkhLS095OUNw?=
 =?utf-8?B?VzBwOUQraXYzRVZzSE1qNCtoRzcxM2VLRmxNTjE4S2FZa09pT3J2ZTJSUEZs?=
 =?utf-8?B?YjR6cHdoZTBOeEcvcEFZcGdla1IySGhXL29CZWFEclNLK3ZWdXpQTHNiSEQ3?=
 =?utf-8?B?c3JGMjNLbXpKK2t3dHBEbktjcFU1S21NcHlma2VRZGZDbGFNNGF2UGxLS3NE?=
 =?utf-8?B?Z2kyZCtGOUhOeUF4T3d3Y0pVdWxXS1JxZjhZU0lhcThvckZhZEo4ZDh0Y01X?=
 =?utf-8?Q?buyFTFwPaLTKm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2syb3JwTWVvcUdZU0hhdEZqN0xDYjBBTHZNRmg1MHZQYVJPNFNjeXRkOVh5?=
 =?utf-8?B?MUtWQ0p3QlFiYW54SWF6aUVuMjEzUmk5M0hBUUNEQy9pZWZ0QkwyNHNKNkxM?=
 =?utf-8?B?VVBETGZMTE5HZEkzRmQxM3krWFJnNUJpYmxRVzg4OTZNbkpkdmROSERkc2w2?=
 =?utf-8?B?aTdSNG02UXNFYlVZczJHeVZXODQ0Rkx5Ylc3eGo4RGRwTC9KTFE0WHkwd1My?=
 =?utf-8?B?MHJJcXgwU0ZlM2ZFK1JRTUQwN2d2R3J1ZVZDVTdOYWppU0JTYXhFZ0xGVHdq?=
 =?utf-8?B?N2xLU3VyMTNqaVphTzVVNTQxelJKN1hhcVpVSDRDNG1ydWQ0aEdEY09OaWpi?=
 =?utf-8?B?UGNHM2Q2OURLQkMzQkNqRUNFTkxEM2FRR3ZSVDdBcTZ5MzQ5bU9jNXdDenh0?=
 =?utf-8?B?Q2tFbGRub0hiUDVWY1QyV1lSejVzOGxrbmtRTDlKbWVCd3lvYkZVcC8vZEZN?=
 =?utf-8?B?d08yS1BvejRNTVZsbDFuR0pUQ2h3aUU1TUF4Sk8xUmpUUGE0c21RbGV1NFA2?=
 =?utf-8?B?Y2t0YndUZzM5eEc0S2RYSExkWFlVZmhJK1NoK08vODQwVXdTRUZxTGE3TGlM?=
 =?utf-8?B?b3J6RFZNSnovcWp0YmFuV21TR0xOMGtmN0t1Yk03blhuUEk5ZnpTZWx0bkd0?=
 =?utf-8?B?d3pCMC9kdVRPZHJIY2oyR205eEl0akV0cGhudGJVQW1QSjhJWE8vNjdmdlp5?=
 =?utf-8?B?NmYwVnVxbmJHSDdlNEFmOVlWbW5NTWc1WWs5ZkVYQ0djeERWYWcrUUhpVTQ0?=
 =?utf-8?B?Y1BraHdGaDgzd2NWWnJjek55cE01QmN3VGlyOFlKYlBKMU1tdy80WWpneHBR?=
 =?utf-8?B?K2pOKzk4dWZmeVJOUmh0OWxrVlBXZVZ3MGJFajRWYnpMQ0VLU2NOYmNoSk92?=
 =?utf-8?B?UWVqY0pmOU15eTZOTUQrZFdJZjJCUjhZRmR5aXBPT3pHRmRRdE0wVjBZeG5K?=
 =?utf-8?B?TmR0U29uZ2JmOVg1eUUxWUlyaUlSazFJbEJOUnI3cWt4RmJybUVUM2dyNkRi?=
 =?utf-8?B?eVV3ckhML2Z1YzNQdzV6cUpOUE5Kblp4RDJScjNvYUFVMmg1S09SWmhhZGpr?=
 =?utf-8?B?V0trdWtIZWtYYWlIR0o3a2ZkNVNMNi9ZZFIyVGI4VERGY2ZKd2NPdnJhY2k4?=
 =?utf-8?B?WDQ3SlVmRHUxWmk2S2hGeUdwQ3BNU05LU2M0SFZOQlROSWZKVVNhN2pWUGFp?=
 =?utf-8?B?cE1NWEROcmN4bWl0VytuR0lXVGR6aU5QWUJod3RHcWVWejFld3pGSE5meFVR?=
 =?utf-8?B?QWN1ZmR0bnN0aVh1WFNmNENldHV6S1ZKRkhic3MrTFUwTmQxcTV6dU9qQkxo?=
 =?utf-8?B?LzUyR1ZKNExqbXRkODMzbFBSTEtYYThmV2REL245VzdNZzlMdnFWSVpuRzdJ?=
 =?utf-8?B?M2JjMlFzU3MraUc1NnJQVDFVMVV0MjlmbEdvekY2VWs0ZUpKKzc1MkZOZzgv?=
 =?utf-8?B?cnBzTXlEczdNS21uZVBPS1hpRUNaaEJVQmxsRExsa1duSDVhTzdpNWwwdzJ4?=
 =?utf-8?B?MnRIekduUzRxRXhPU244OEh2S3NHQ1d3dkJRbGZpb0JxUDMrZ1pSRTlWazZL?=
 =?utf-8?B?bUR0dHVFVWZPUXFaL3Ivb05xUzYzVmJtTS9NWENBTUF4OG9WckpPQ1NyMkg0?=
 =?utf-8?B?WlVMYlJaQkd4UlA0aXVGcVc0WUtLdnVVeGd0dHJNNmk3SVErUGxjWTBUcHdj?=
 =?utf-8?B?c2dXZ0RHS010a3NQdWxISnlJelZDd1V6ZXc4bGpNV082eFVScEU0OUg2OW42?=
 =?utf-8?B?NGtnTE53TXBrTW9leHVwZTFlY3pybUJsSDV5YmhYdjlETGNjeDhpTGNXRm1k?=
 =?utf-8?B?d3FrWlZiN01uSXR6dThoZmx1K0Q2Vml4Qnlpclk3dHFqMXNyTjdObmMyci9R?=
 =?utf-8?B?NmVudTQ4SSt2SWtFS2JFMnFTcXkxbyt2VkQ0em5qcVdqQTd3bDdGTEphUzBz?=
 =?utf-8?B?ak5GRE5wTjV4Q3ovcEp5ZkR5RS8xQnNCbnZOekpGamE3amNER0lVdm1wSURp?=
 =?utf-8?B?NUxMTC9BWkhjdDdjclcvOW1OSGxmTEM1UldPdmQ1VnhST1VYamdLNUk3N25O?=
 =?utf-8?B?Sm5ScnExeENxdEN6eE5aT2orTllvdlZWNGdhckloRHZSRWluQmtvZmZqV3dU?=
 =?utf-8?B?dEg0TEwvRkhuV0NxZlA1VjlKOHlWMmFST05TMTl5SHQ4L3NSSmltQkwvc1E4?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 676e21b3-be9a-4a76-9ce2-08dd3fad300d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 15:05:22.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7kqqjreIxkmOq+Cgs/SqZ88/EGWWh5vPglxYZ8AQpm33qShUGmWf/1KzgLgJDbceat6dqTA830w0Pe8T+ijlEEAyBfQY8Q76aOseSsFTr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Jan 2025 21:14:04 -0800

> On Wed, Jan 22, 2025 at 10:38 AM Saket Kumar Bhaskar
> <skb99@linux.ibm.com> wrote:
>>
>> For platforms on powerpc architecture with a default page size greater
>> than 4096, there was an inconsistency in fragment size calculation.
>> This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
>> to fail on powerpc.
>>
>> The issue occurred because the fragment buffer size in
>> bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
>> the fragment within the shared skb was checked against PAGE_SIZE
>> (65536 on powerpc) in min_t, causing it to exceed 4096 and be set
>> accordingly. This discrepancy led to an overflow when
>> bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag)
>> could be greater than rxq->frag_size (when PAGE_SIZE > 4096).
>>
>> This commit updates the page size references to 4096 to ensure consistency
>> and prevent overflow issues in fragment size calculations.
> 
> This isn't right. Please fix the selftest instead.

It's not _that_ easy, I had tried in the past. Anyway, this patch is
*not* a good "solution".

If you (Saket) really want to fix this, both test_run and the selftest
must be in sync, so you need to (both are arch-dependent): 1) get the
correct PAGE_SIZE; 2) calculate the correct tailroom in userspace (which
depends on sizeof(shinfo) and SKB_DATA_ALIGN -> SMP_CACHE_BYTES).

> 
> pw-bot: cr

Thanks,
Olek

