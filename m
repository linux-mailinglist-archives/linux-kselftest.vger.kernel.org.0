Return-Path: <linux-kselftest+bounces-42463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59FABA38B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D636280B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADB2DECB9;
	Fri, 26 Sep 2025 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGFZfc9e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD02D7DC2;
	Fri, 26 Sep 2025 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887381; cv=fail; b=QN23hkab9nDLtNcohe/uslpaCqVpN/rKtwD0w7VxYwB1KkF1SEIm0bZm+MJQXEXL8W0O4hN1OMFIE84o6shK7nkyejnQBocOihAyng+wmmfwCBJIit2CdF5NecpEHFkzcCs2Ys1yIPCTajjx2alGyOeAT14dHujZwgp2ZrnKXJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887381; c=relaxed/simple;
	bh=+Xs/V2QHvRiZpOvnoX3tkvNNke8pyEZDQDhKIxV+quM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LP9iqMSCXQGr6dhQ+Hpbhur1wjnm+84AZqxjWGBemdaKEtzPNbob4TelwdJEg9Kmghp3szQRDqOnXb6VZmtpE7Iv3h4DBGdTICqj8fGoAeDsQb4XJvVSYqGrLNbgFKoSaOMLkIJRV7YamxnfxGhtN6caKIISBQd7THVbw3yS1aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGFZfc9e; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758887380; x=1790423380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+Xs/V2QHvRiZpOvnoX3tkvNNke8pyEZDQDhKIxV+quM=;
  b=MGFZfc9euvHcTnFBOq9DWzEbYQ+byMu8wqDgWLUtt40OHhWtke5++Ud8
   faBjOqTUP58WXMXiz/5XptGYSOkG6s4ESnjy+PhMeILF/ETn9EyJLp3uT
   R7sWhn+NHZ4rsItXX/ko2rPsQUKrPqwmN7by4E6Lm285Ke2cloBYBHrxt
   fMPjOpOYetdbeTkDFeKECFqWePoI5jnuqxobC7rX+mE8HXUkKmF70f9UT
   m9EDwUcsSeqoIhUaEiXc9/IYEmDQrF1Tdu8gYCPYMKiO3/iN/Qu6k00EY
   ZkDETAqyUiompEe/Vz/OFKTTXj/WAAgr4O/1ktB7dUSdxcIMB9+RU3QsN
   Q==;
X-CSE-ConnectionGUID: 4ax09xRIS86C+HAT8P+zPw==
X-CSE-MsgGUID: knPsyXDtSKytWyoE9Kb/ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61388035"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61388035"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:49:39 -0700
X-CSE-ConnectionGUID: 3+SYlcWSTMmUpwOfaFQNOA==
X-CSE-MsgGUID: wBnktGNnSrWGEilmjDsrRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177194273"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:49:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:49:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 04:49:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIl1g8jf4KgGza9STv1hS1L0oeISIVwxY5N92ikEMa91TILMR8Gl53sUsoXDABEG/8Qe3Ubt3gzNEEh0kBT4//1x+QB4p1A6BU/hIgNZI3JRkTcqKfNUQXOjPUp3SfAFSpcTbyt0eeb/1tJNxR0L4Y1XBd5S32V8cTaDZDP9oE1EESgcBdE1r3a8L7RXVNFSMDqHgDGxbDRxH5GOMOIobtuGDoKTniTDFp3EGSMAdn7FMGGHSTTXuJFpVzu8tTzesXfR4VRrZ62I4gaoGY1I3ecksn47WXJaWlNfZTu2w/wVF6NLx4hszfNWnc22o/Lvu2Gfge/bN9iRAU0veeIL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erVT/n7SQ9wpiWNl4bHiFoS0r7CyIPILPCexinmiqOI=;
 b=LRmFey3cJwK9ZLbHVi6biRlWg6r9noZrTaU7VmlfHMjv2RCdZRuH2bFl/xmT0pj/avQpKjhm8KTfFiZMFL0Lg7X7AEMCDxhzHk8iCrElTnz3T/yio5srOo09V5sFGppnRjefpNkn1gmsbbs/kM5oBFxD8eRoq+oetM1le+PKkipz6yXj//7F+1WqWG6iIpVkygCNxy7OLGJv2w1rWGYcUr6LFfDJyKsB5q4pXj97nbus6Uh35w7ZnWsw0jXsdQwQYDo+nzfoBGR2Y4JQs86hzSLX8+k3gvlisVTHEA2NSQ5+2p2jTtO+THEW0vJ3FtbkToIMpN1dPUticKDt+rCxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 11:49:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 11:49:35 +0000
Date: Fri, 26 Sep 2025 13:49:27 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Message-ID: <aNZ9x5s0zq9zahLS@boxer>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: b35c7fd2-c389-4a2d-4083-08ddfcf2c3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YG1szA0tDsS1QePUFUDkCKMDnvJDTDQAZidxIPciy+3kEcP4W/CT5FWzibl+?=
 =?us-ascii?Q?PE1hptbuc+GDv+oSM50qBxxQR1Bqlj5A+iM9CEA+sDyXAmTfPWuFp2QN/yTP?=
 =?us-ascii?Q?BaYYs6ui5M5MtlGRzoaIzOf0/9igTyz531jRlUlCMZpwkYOPOQdzcvYjl4Wx?=
 =?us-ascii?Q?yloxcYHHX5cDNMbOnZ57FAtsSYvyu8OO2jvFgNQtA8Nsq8r/jU2AvYYzmQKd?=
 =?us-ascii?Q?Amw+uol+rU5nh/8pEnDMpX0nckESXPJqEkudtKYEdwPC5jeHqy6oSlFNhGWI?=
 =?us-ascii?Q?bdWj695BFUrX50r/moRR0ByZIh3RBiVLzJMAzFtaK04CPRMC4Wy0SN+eUeuB?=
 =?us-ascii?Q?LyU/lFgRgNfXi2Pg6JH6dbHNPUCS5nRD8ybd1JzpeXOCwG7WO8AAQlmZMR5C?=
 =?us-ascii?Q?wRRKGhE2YFBFiHxhXzIvRTMGH/saTmC55oKePpPtLcIONrDej9wH/aVxCMj6?=
 =?us-ascii?Q?BBExgOosi27QkFOnZ/SyuF/KJP2dBjamdzdovoXQ2NC6Vsl3BZilMHnDJ2RY?=
 =?us-ascii?Q?bsNd9i5wV7FxLEySaOYF4WDesGIHFg/4eOytXpVTCrjClS8Bqww9PR+hHzDT?=
 =?us-ascii?Q?pJ+nAleDY4CqqI1ai9XHhLsYwUoCwnUUdUqJZfPryvTasYjZwLGTOIMJkMH0?=
 =?us-ascii?Q?y5LaBhQMV7uoc6OCNRoJKPQ/zuCLr7QgM6W+kGmdPfjliNumSJCLGQbLEoXz?=
 =?us-ascii?Q?+4N7KFqYAQ95DY+A3IRkA3+0QoPUu/UZjc4I2gsDj8qWi6JsL4u5pPs8N0WK?=
 =?us-ascii?Q?HUrFGvh0d544Uk0llVQQmrV+jBuXMJdtPFAXRXZ5xdVwbfoTmbcgH5rW6dyJ?=
 =?us-ascii?Q?F4gn7/EgmGCoy+Uy1GibNtNzcYiGmKmmLlWfjFGfsh9Bt1kQiZHlAOsiB4bv?=
 =?us-ascii?Q?4RL+JPCD0bFYH2dtTd9i/MEpncuyrrY9BwyrTIStp+3jp0E9yWLds8nrBUaK?=
 =?us-ascii?Q?BdCwZT2tIDDGVpT5XrBbSf3/Cfq98Is5awx1yJIxBMMHlQGvcSBQIgc6dXxy?=
 =?us-ascii?Q?gBc9xzELFqLIV4yVDJLqXLLd6IHcbYFUoNzTydzHktHN5EQV3Q9n0g/nYpoh?=
 =?us-ascii?Q?wjTIQlr4lYAOJ4uBusZ1vrY3ZUsRkkQ15sXt+AMt0oPWw7fuQMmDMIIAPF2b?=
 =?us-ascii?Q?H+OTZ1QH+LaaaExch4XfIE1VErqCwy9gl4slo9w9IQk5qxNhXpzrUM9gUnXZ?=
 =?us-ascii?Q?wAIjkusyj6H4By49TpCw1XpiWdBHZqrw0Ta5tTeUXPEEe7XWJKuEUPkCr5Wt?=
 =?us-ascii?Q?vYtrYENiosrw7IiRgsWB/SS+E+I8fx3Ksw/mgYpxRdvzzHougrTqxrasCW24?=
 =?us-ascii?Q?GUrs9KKOijqBsdW+LHNlvStYxYu8sVH7nexDheM7V3ZfXFnc7GyFJfQRgApK?=
 =?us-ascii?Q?zLxb8b6rSwF9RMeWyd5DknfYd1UPborFeON9K+zI/MLRaaKst9bFAkVQG1EE?=
 =?us-ascii?Q?Hjwr4Pus/IfeMJtX2NeqyIVMcdqt0fA4w0kpes4K03eC2zYRF2shfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/vTchzyrGfGuM7rD3WQSXAYr6TZnFKDMc+eOWxYbH3dsp0vfy/wkO5PyucPs?=
 =?us-ascii?Q?SDlQFxuxCG3TLzwy77QJaWb2CTpkiQQDuXQSpOA3WmkHd4mWwpcQwW1g+hvl?=
 =?us-ascii?Q?Pt4zzPa/AQzx5zwthrtRnkiO36C7PDCPFXPgRvOwNYI0vDADFd3WOxBYGrMZ?=
 =?us-ascii?Q?XTUZ1PT2P76XhhPZejDoyC+uLt3qhEyBYvcWclTVs2nP/IJOJ6/srpx8IRiH?=
 =?us-ascii?Q?e7i+tkk/5NyIa5BsN77UKHV+YSuz9l4oGaOnCC0tOphR2M9jUBidPUbZFywm?=
 =?us-ascii?Q?7WX+k9eKT9VUtBqoXRK/N71ZWpJjDiIa11tFJYaCBJNB1cpUXJZ5joPterXm?=
 =?us-ascii?Q?i6Eltv10GTh0XLHygALop17RU9kVIWep1ucvQq1Hc7yRYr8F+7glUY3BvRxU?=
 =?us-ascii?Q?lzlvgmBdmMVn2psSLIHRMNgW3KlKLfh3WdyxA7I5e8XyHoIWXvLW1T+uhyoY?=
 =?us-ascii?Q?T2NQOTKGJ/voMoNM/u+jMIx/O+CacGvqI5z7qKQISzLVAxTxkD3y377cQ0Im?=
 =?us-ascii?Q?ItfWr9Itim+t3it9NJ6SjI0vhP2dby5/1Z0TAt5m9gIKPlsfg7BPjtmlxsai?=
 =?us-ascii?Q?Ws8ZSXLQMWgH2PksISnwzhcr1RssVYWIh5dQsoK7jAPSEO75qHG2gYdzLE1P?=
 =?us-ascii?Q?71qcUjq7FBndUtohg5zgGYQ7k+oXh1NijKArQCE4vnkowVf38pA3fU30cgrq?=
 =?us-ascii?Q?CwoqZ+h9hiG6QRhrqkvxHkLltXYRTHCNoYxoKFWxBkKnci8EhkG6/ICps1Do?=
 =?us-ascii?Q?qGnvCz8ctFEPQOs/7sAXzw14kG1k9YkEDwkBt2m/VWsZnSpdQECwLYi7d4Ek?=
 =?us-ascii?Q?vHBjg5ZbnO3vSvfuYOrLBbox5zEw9d+AlE3qOIGFe8yWWmeMbF2n5mu0i8ei?=
 =?us-ascii?Q?7qtuATSr4gUCYCWfDU+Lz0fcf4BcSewaTLhMlZK0aKK7Km1a0y9/noDFXhti?=
 =?us-ascii?Q?H2ZFFUwhrUWxuTPsLgOeUyLEoLbF1Ke10Axeo+EsLX8sw6mTqtMk58mwRTtY?=
 =?us-ascii?Q?zMwIBtWh4u9ITf9vkROmmZb456mXeDQzhxrXpzXn4TrAGlk8hX05gHVSqGXm?=
 =?us-ascii?Q?6qMyRNF3JdM34O7kzfnOm6PrRpLx8ZzM7biJw6Y3TWKC4A6mqMXQSvImjR9u?=
 =?us-ascii?Q?QjC1bJyCmgcv9uiP/EdiU1+0ooXmZE+nlj+erxzG1J/4EyxUknKNoDDPqlsX?=
 =?us-ascii?Q?RMSudJM/fqZFehOp1u9qGZQOtUfP2o8YjaxhlwrbifCBE93EpB4GvTBhhDhm?=
 =?us-ascii?Q?NNsPpgbXXShwWcAoq0Q2vPe4h2bdkaxl4fHxw8i7ecMtCdh5nDYZn0xFysqW?=
 =?us-ascii?Q?fVoEGBKdVPfZ5liakhvM4dB8IoSOp3KclbyYoI6UWOfNNSnzrUaTM32+gLbE?=
 =?us-ascii?Q?Ppp+l4qx5euGyWMAPHKjDhKscPiFcKZFGwvNMoIrvgl62d2Uyx2IeugrONsS?=
 =?us-ascii?Q?ZwxbZ4kqZbjTfUz7xMcW1ktpd4wOS15P2cUSIw6UfQWPQmXnF0LvA/GIaZdE?=
 =?us-ascii?Q?kKZEL130NxHLvgZCvvM3eZl42uKxVTicUGLvvASfwwXApOTB0YweCD+7fRgC?=
 =?us-ascii?Q?r+kKeIWHYe/yqZSPYyhgByaIxCm1afS9F+syYiI3wq6QPgmYIVnGovPETUSt?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b35c7fd2-c389-4a2d-4083-08ddfcf2c3ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 11:49:35.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3fQcxxbEyUXTXQw8cbfeOO8w4lwx95giSB1mAercBuu1I5UCEO5llZ4zwytWukiQPwOlpWo9GYJ7xzZpVvS016cIPxFgkY8HFRM1P0F+a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com

On Wed, Sep 24, 2025 at 04:49:35PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> are defined in xksxceiver.c. Since this script is used to test real
> hardware, the goal here is to leave it as it is, and only integrate the
> tests that run on veth peers into the test_progs framework.
> 
> Some tests are flaky so they can't be integrated in the CI as they are.
> I think that fixing their flakyness would require a significant amount of
> work. So, as first step, I've excluded them from the list of tests
> migrated to the CI (cf PATCH 14). If these tests get fixed at some
> point, integrating them into the CI will be straightforward.
> 
> I noticed a small error on a function's return value while investigating
> on the report's summary issue pointed out by Maciej in previous iteration,
> the new PATCH 3 fixes it.
> 
> PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> tests available to test_progs.
> PATCH 2 to 7 fix small issues in the current test
> PATCH 8 to 13 handle all errors to release resources instead of calling
> exit() when any error occurs.
> PATCH 14 isolates some flaky tests
> PATCH 15 integrate the non-flaky tests to the test_progs framework
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

For series:

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> Changes in v4:
> - Fix test_xsk.sh's summary report.
> - Merge PATCH 11 & 12 together, otherwise PATCH 11 fails to build.
> - Split old PATCH 3 in two patches. The first one fixes
>   testapp_stats_rx_dropped(), the second one fixes
>   testapp_xdp_shared_umem(). The unecessary frees (in
>   testapp_stats_rx_full() and testapp_stats_fill_empty() are removed)
> - Link to v3: https://lore.kernel.org/r/20250904-xsk-v3-0-ce382e331485@bootlin.com
> 
> Changes in v3:
> - Rebase on latest bpf-next_base to integrate commit c9110e6f7237 ("selftests/bpf:
> Fix count write in testapp_xdp_metadata_copy()").
> - Move XDP_METADATA_COPY_* tests from flaky-tests to nominal tests
> - Link to v2: https://lore.kernel.org/r/20250902-xsk-v2-0-17c6345d5215@bootlin.com
> 
> Changes in v2:
> - Rebase on the latest bpf-next_base and integrate the newly added tests
>   to the work (adjust_tail* and tx_queue_consumer tests)
> - Re-order patches to split xkxceiver sooner.
> - Fix the bug reported by Maciej.
> - Fix verbose mode in test_xsk.sh by keeping kselftest (remove PATCH 1,
>   7 and 8)
> - Link to v1: https://lore.kernel.org/r/20250313-xsk-v1-0-7374729a93b9@bootlin.com
> 
> ---
> Bastien Curutchet (eBPF Foundation) (15):
>       selftests/bpf: test_xsk: Split xskxceiver
>       selftests/bpf: test_xsk: Initialize bitmap before use
>       selftests/bpf: test_xsk: Fix __testapp_validate_traffic()'s return value
>       selftests/bpf: test_xsk: fix memory leak in testapp_stats_rx_dropped()
>       selftests/bpf: test_xsk: fix memory leak in testapp_xdp_shared_umem()
>       selftests/bpf: test_xsk: Wrap test clean-up in functions
>       selftests/bpf: test_xsk: Release resources when swap fails
>       selftests/bpf: test_xsk: Add return value to init_iface()
>       selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
>       selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
>       selftests/bpf: test_xsk: Don't exit immediately when workers fail
>       selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
>       selftests/bpf: test_xsk: Don't exit immediately on allocation failures
>       selftests/bpf: test_xsk: Isolate flaky tests
>       selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework
> 
>  tools/testing/selftests/bpf/Makefile              |   11 +-
>  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2595 ++++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/test_xsk.h |  294 +++
>  tools/testing/selftests/bpf/prog_tests/xsk.c      |  146 ++
>  tools/testing/selftests/bpf/xskxceiver.c          | 2696 +--------------------
>  tools/testing/selftests/bpf/xskxceiver.h          |  156 --
>  6 files changed, 3174 insertions(+), 2724 deletions(-)
> ---
> base-commit: 1bd67e08d0f3fcb8cc69a73fb7aab9f048be4b8e
> change-id: 20250218-xsk-0cf90e975d14
> 
> Best regards,
> -- 
> Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> 

