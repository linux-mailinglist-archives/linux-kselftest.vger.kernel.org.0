Return-Path: <linux-kselftest+bounces-39487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838EB2FAFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB39617AFA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779F342CBB;
	Thu, 21 Aug 2025 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAiWDRlP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C234166D;
	Thu, 21 Aug 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783369; cv=fail; b=RcJNlBwelCrNo2c9HxXGx1efx0ZosgOgljiF2VJAAViHEyxyGE26viBVAojiZWSKvWmGyzX8Rw37PcwE/4DBNrrLbRYolPOe3QIYhCvPvOmqTK3aWt4Q+2la5B+KCDygOb8ui6hzpqgA/YkMF9gnRy+pyU6VcufP+lXfhIsA77U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783369; c=relaxed/simple;
	bh=nrkUg7k/1w1yOvxgNi7m9nf6aJ817Bqe/LK4NdZJ75A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SaMsUXp9ntq/mspQks7pcyv1Gt7b+dJHCsvS+urpu+5qJCnkqN/75Ahu2/+U1Gf1qu0nq9i4cqJRimRDfLfiKErMbGohCTJQVbndZoBEAGByWdwdil/Bf9zV+hEsOPwv1CZGgA3Cej7Mh2oNPdnkBb94bfK7PrL82AdK5MvBGq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAiWDRlP; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755783368; x=1787319368;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nrkUg7k/1w1yOvxgNi7m9nf6aJ817Bqe/LK4NdZJ75A=;
  b=fAiWDRlPNhavGvMmMQoxO2GKEE+wVSqv3OGjbUc93AXNAfJM+GLy5KkK
   uff9mWiNFMSpdQTrYVTs9861DkunBPVcN9P9EKA6miHkgXs4Z5ROshz4J
   7oROelSA9TgNqOsDDQCpxmxuYNQb3zLec0/z9zA1FWBBekC35ASZYu5XU
   Zt1S+5Z2HRXu6O03MAD0D0c8yBovKbVAPCj0XgI1NBQGJe9Tdtlhj1nkS
   1Q8vdBPMuv/ozkW8v6AN2KnOvyzGps44ttcP7WSAFcmJ4dBYSa4Ahp1zI
   Qit9Ty6SM5vPJ+W41oOJKIwpDJ4B5FgqNLq45prO5vgw9F0WrimwajcJ7
   w==;
X-CSE-ConnectionGUID: PluM3tk3QN+X5tOkwHAZSg==
X-CSE-MsgGUID: QpDVJWD7Q8W03iZjNX3xqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57932874"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57932874"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:36:07 -0700
X-CSE-ConnectionGUID: JCY+rrP/QsKV5UV2lMzh7A==
X-CSE-MsgGUID: l2cgpohISz21MszL5tGiaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="169219136"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:36:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 06:36:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 06:36:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 06:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnapgLyGNMqOZmnZ0idU63MWtMZk/AKYVvHi8bOjlrMgun2Til2LQeCvhGXjQz37x9EbqkRLFGccf8mk5ll58gjSVb3IHFRhMXL5p6Sm8wvAE3q1+we+Mp9a1537vgQRzQ7Mh87UQPrY1FfKx8uhCqSM2xfOKxQtrZBKmZ6BAt7NX92HgRvDpruLEKCQizs7Wn0GuceE5qL3jFM40qFsFzf51EsTpSMB+CD74/vZGW3UVOKbeQ3kEcNDInI4Cv/LXYZQQWEsEhDalvBjlAN9Hf+Iy7Dwo3fqAYa4QK57ewbaEj0BJXko/T9TJpCoqA3wNiAHb4GyuS5E7bmMC8T7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liFMShFgpZClD9lOv0W+mwgRT8PTWYP60G6UAQUt47E=;
 b=Dum31JP69NwxWKFOilD+CCNhMSQu40YyH0a/InEkc0LTPXavyx5ZV62P69Alf3/Hf2DF5mi6D16plQb6KvmyJGORwvleOdgEdP7el0EUYyPiJI3EWqTZBLVDa5Z+kIOlbpk8jvqxCi3YCT9Glz1FoyJvhxfdsfOa0+Ggebf/aGm8trJ/rDn48Ksqveh24XtuO/hmRputRI8/X5brhRa9f7voyNpOHrX7eaCWydtR/duY+xtKGlkevCf/DaFtcpS3yKqIrQpwvCCVZ3nbSFTRgfwm4h/yGLINF1YRFt+6PYxl/d15xYhymXlQEwCckombs/133S5kJBMeecDtfbxazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH3PPF9D9CDC305.namprd11.prod.outlook.com (2603:10b6:518:1::d3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 13:36:02 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 13:36:02 +0000
Date: Thu, 21 Aug 2025 21:35:49 +0800
From: Chao Gao <chao.gao@intel.com>
To: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<john.allen@amd.com>, <mingo@redhat.com>, <minipli@grsecurity.net>,
	<mlevitsk@redhat.com>, <pbonzini@redhat.com>, <rick.p.edgecombe@intel.com>,
	<seanjc@google.com>, <tglx@linutronix.de>, <weijiang.yang@intel.com>,
	<x86@kernel.org>, <xin@zytor.com>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, Ingo Molnar <mingo@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, "Pratik R. Sampat" <prsampat@amd.com>, Shuah Khan
	<shuah@kernel.org>
Subject: Re: [PATCH v13 00/21] Enable CET Virtualization
Message-ID: <aKcgtWhD/4qz4jDD@intel.com>
References: <20250821133132.72322-1-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821133132.72322-1-chao.gao@intel.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH3PPF9D9CDC305:EE_
X-MS-Office365-Filtering-Correlation-Id: 306115b9-8c29-48e1-3c21-08dde0b7abcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fni8W2PF1qrt+5XK4vvyW7X1gSQtnWosWPKlAuuxDLvPRPoRNSxnmubqRDJp?=
 =?us-ascii?Q?W5eY8W0DF4ZBSaW5Y+eV3JKWIp6Q6aBOiKKOQpJJJvaFuQ1pRTF2oqKPqiAf?=
 =?us-ascii?Q?YHk5z6+LEv2zWYFeXZ4E8tLlijraj0IaGKxSVPIPb8E3JQRqvo3myphCGtva?=
 =?us-ascii?Q?46C2l9Ai4RwriBN7hchvzdLdejGEASOWQq+/UCd9V7omlrQKF8y9A5ji2DdL?=
 =?us-ascii?Q?sLbbo0nolp5e0cshNhOmV9AS68WatUyH0q3ZmvNPg1pHSxO2mPLVWYWH+Gl9?=
 =?us-ascii?Q?KdJfNvp+lT0zPZ/sMHaHWsgXfS6uu4X8DboBeGSgzScJT/M8A2kSH0rNqefv?=
 =?us-ascii?Q?qOMZAMe8Nfw7LSNJw6AJtuqkfKedMOW0HII62Ms6/zReH7r6OBfppWpi+Ai0?=
 =?us-ascii?Q?xKtPtBK6uK5+/hRyk3FxMX7kSqlNj372UsnhyEpwl2aCCKKFjbnaBObLubun?=
 =?us-ascii?Q?uUtDknnunGOUxt0GLwbfH2J/Eyy6YvrHIK6GCCFzMCKwe/FT43yY/cXf0P9X?=
 =?us-ascii?Q?BcWdweEYF3QZ42lU9g2YhHyI6gO3B1M+x6TKwf00aEoJLg3LYo/CCfov5iF9?=
 =?us-ascii?Q?iAo9h2I5QF2N3tK/2bu9iu93fIo0ZiOTSqC3BWm1i6seH/FhzuCvrlK72Q/b?=
 =?us-ascii?Q?1dJyRvnyXOC6rZqLQT/EZhBgJmqZD1nXKFXenwUlPnD0Bu7YLARYyQ9JeXZV?=
 =?us-ascii?Q?l6E4gtHuj1USI7sHPTJmLLPIiCRvPaDhZWFxM1pTaXyBy9b2CD552KLCydwm?=
 =?us-ascii?Q?mqqYX5qdX7o9YZZuMKEthVgIPtmqz45OJq0xivnVuWmk9o8uwTFUbaYQ+xcp?=
 =?us-ascii?Q?hSmzNB103aixi5ejv3o3Zc2PWLRpauU1L6tS/BIOtkErp4wkYCd1KUghPG5g?=
 =?us-ascii?Q?XDsSJh0t8baTmBhtxosUKMe9i+/Or6SUPkp6r0GYjBEGECGRwcFvIUvVEM3r?=
 =?us-ascii?Q?w1slCg3Iz7A/mYGKxr0n2fdc3LwZp0asnV7/Yjfgi6MuLsex10T1q74P2tfX?=
 =?us-ascii?Q?MEUPY6HmADzrymwo/O+w3/go8tORZqD30fn21bGCqHKTxBrh6S13rpLHDS2/?=
 =?us-ascii?Q?nxC1ffbNZG6IBlrhNfl8BH4gv5ggbO9evgJ/zlahRr/mm98sFgtstqHrbi4a?=
 =?us-ascii?Q?2oYigU5jcwdS0iXQTFYz+KmeZAbRP1Od+Zwt7UcIvYs/lQoX/zNYkapzoHo7?=
 =?us-ascii?Q?ahzIOQZZDR/ww1xBL2o0U6kfzbnfhp/OO8blIRqaG7dr5wu1Zv+f5L0oxJU6?=
 =?us-ascii?Q?oMsVTcawMNgt0Fb2nNxyaRblYR28LWHo8dEUMzfTA6waGRgtHrJ5y/VBdt6L?=
 =?us-ascii?Q?/5sH++exdOvJiw55e5eu77UaTYd1DXDMqPazXISMlHkYffWwsQ260t015TpU?=
 =?us-ascii?Q?BNk5EvZ2p6Hzw3EiXlmPJitjUwTiuH59kEttEQ9gqVOFH/ybOFzvZRvPd0kA?=
 =?us-ascii?Q?WB2CJZ5jaf0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SN5BPIhBR/1GMmjeKXrjQIsIJQPAtqtjQ+GxPgzSc2w6HqzdKZmtA/P1P07G?=
 =?us-ascii?Q?P+o6mavWOfGmKaOZLaIbexrbrTSPkNwDEGvCH+vedggH9JX9x/auz+DQrdwX?=
 =?us-ascii?Q?16qNwpTl1ntiz8lYudqZ1aBDuqtKQU9pE0AdanJyr+S+Y+3IDuorgZjgukHY?=
 =?us-ascii?Q?Gqaebt4BI+OqQ5THptTX4Ru1XIYWkJBpC6mgEZOLGB9cpmf1URvvS9YxVq2n?=
 =?us-ascii?Q?QRAUxCLlVO9KjRHs9i13za3jb+CuT+Y9ecHalAhrHwVh7wwLEW6FglbnjnAN?=
 =?us-ascii?Q?S15bM1hELBCyhMHZtk309aT5pvZp+Xzfz74bdRLFGSoJbilU+bK+pbdK9pMV?=
 =?us-ascii?Q?flV0EADzdUMqLx88zHdRyUDXQ0XJ8sjwWLMrudw8xlX/V9tpqy95UuDyb92t?=
 =?us-ascii?Q?tJhjqp7lt/JMpcKgTi+v396AESPaq+2cWfTagCHDF5hkkwxybHJz/kRVWY+a?=
 =?us-ascii?Q?bb34nHGILp+daCoV+/9k2S/eT/vGN9V5O7bKFnake8Mi8Zr35odd4Gu8MhTz?=
 =?us-ascii?Q?E1ZPl9Me0FwkC9mgvLohYR3xIrvhzERUJJ7yWSZa2d7pUoUIVd6+ZSd2rh/C?=
 =?us-ascii?Q?/qAQgcRHbLKCFM8VnMUjknJYzq06UwhF3qunFqwJNg+rl0zOfr34aZkTsVT7?=
 =?us-ascii?Q?OLkugF1oMxShuGFDs3hMN2i5p/07URSLUATdI3avU/8vrh/aVDMw8O0TJLs1?=
 =?us-ascii?Q?E1DBsCom7NXPtRx/BmcsChvSw75emJChkLiicnptxocH0DPoDQuFbOvJN2CL?=
 =?us-ascii?Q?67bz/dY+yZcvvwI/A02Na1Le5+0LT0kIDTba53OXtZ1MoqtG0HmeCt3j4Jzw?=
 =?us-ascii?Q?S1j/SHbY6jhai98mt9k1D7iT8DTV/UTGW+y1pA5/m5nIIJVXIncVf8vh0Dje?=
 =?us-ascii?Q?Usu13z6zv6W2Q0Xic4bgMEL+eWjjdoD6/gV4+2WvhSwSmqfT4fws4IQ5aqmW?=
 =?us-ascii?Q?KB+R4ti79jYkXAkevFvtk/ZvtkVNAAaGuTURz9gXtd7XV4nfMWUaV7iPDdY0?=
 =?us-ascii?Q?r3XFqaqlL0gyNnBAFBUb30RjfYy7KgrOEqbW5+ukgP6uIja9c5Z4jaE+4i71?=
 =?us-ascii?Q?FOIjDIOChr6WBKtxWtGLqt85C61VWzKzPX/GOs5idyK/NlyY/k/qg7dIzbeW?=
 =?us-ascii?Q?CD8Y1KUNN8XMoj4fr5JbdGmMjAw+Troe1qcvSlUmEdlnBZHFMwEye1J5S1zI?=
 =?us-ascii?Q?343eavXgL/G1UUny2jCumLeDgsoveR9PAHnrFcygbVA8iQboV+ToBA5ruMoP?=
 =?us-ascii?Q?liFDHqidTE7UoszG6RZN4t9RnulAqkZs4kNWuDEaaBG8T81qJqGGVCN8rQau?=
 =?us-ascii?Q?JEElamrKSMaNtFDrX4ZiScA1Ri+MPoOinscqPLzYDdkX/EsM665wUwGGeD0c?=
 =?us-ascii?Q?SZF/Kz4H0JoGUo2YlLCrJbuXvDSEEKOJEqGj7x+t5MzjK3zc4YLiZL/kgPoU?=
 =?us-ascii?Q?JA35LGug24Ua++Kyp5aFfmbqzxVejdpNbatCrRkuigewipeISyBXoLMUYObc?=
 =?us-ascii?Q?GUtxbjsXsWZBiZqRCriVlw/ltVL9zw+5P2S6sXdDy4cg8uvyOMrsqeMGuzA+?=
 =?us-ascii?Q?9G73G/BUmAXeRzcOdk9/5Fwmu31iHj0hwVVjudUI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 306115b9-8c29-48e1-3c21-08dde0b7abcc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:36:02.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEW7hqgD5GGcFuIslcP/1tvLqUpZPcUup72SfvhQFMzR/WXRI4amtO3b8lvfGJbKOGQWcpuYRrk3CQZJ+Bjr8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9D9CDC305
X-OriginatorOrg: intel.com

On Thu, Aug 21, 2025 at 06:30:34AM -0700, Chao Gao wrote:
>The FPU support for CET virtualization has already been merged into 6.17-rc1.
>Building on that, this series introduces Intel CET virtualization support for
>KVM.
>
>Changes in v13
>1. Add "arch" and "size" fields to the register ID used in
>   KVM_GET/SET_ONE_REG ioctls
>2. Add a kselftest for KVM_GET/SET_ONE_REG ioctls
>3. Advertise KVM_CAP_ONE_REG
>4. Document how the emulation of SSP MSRs is flawed for 32-bit guests
>5. Don't pass-thru MSR_IA32_INT_SSP_TAB and report it as unsupported for
>   32-bit guests
>6. Refine changelog to clarify why CET MSRs are pass-thru'd.
>7. Limit SHSTK to 64-bit kernels
>8. Retain CET state if L1 doesn't set VM_EXIT_LOAD_CET_STATE
>9. Rename a new functions for clarity

below is the diff between v12 and v13:

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index a4870d9c9279..478d9b63a9db 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -411,15 +411,26 @@ struct kvm_xcrs {
 	__u64 padding[16];
 };
 
-#define KVM_X86_REG_MSR			(1 << 2)
-#define KVM_X86_REG_SYNTHETIC		(1 << 3)
-
-struct kvm_x86_reg_id {
-	__u32 index;
-	__u8 type;
-	__u8 rsvd;
-	__u16 rsvd16;
-};
+#define KVM_X86_REG_TYPE_MSR		2
+#define KVM_X86_REG_TYPE_SYNTHETIC_MSR	3
+
+#define KVM_X86_REG_TYPE_SIZE(type)						\
+({										\
+	__u64 type_size = (__u64)type << 32;					\
+										\
+	type_size |= type == KVM_X86_REG_TYPE_MSR ? KVM_REG_SIZE_U64 :		\
+		     type == KVM_X86_REG_TYPE_SYNTHETIC_MSR ? KVM_REG_SIZE_U64 :\
+		     0;								\
+	type_size;								\
+})
+
+#define KVM_X86_REG_ENCODE(type, index)				\
+	(KVM_REG_X86 | KVM_X86_REG_TYPE_SIZE(type) | index)
+
+#define KVM_X86_REG_MSR(index)					\
+	KVM_X86_REG_ENCODE(KVM_X86_REG_TYPE_MSR, index)
+#define KVM_X86_REG_SYNTHETIC_MSR(index)			\
+	KVM_X86_REG_ENCODE(KVM_X86_REG_TYPE_SYNTHETIC_MSR, index)
 
 /* KVM synthetic MSR index staring from 0 */
 #define KVM_SYNTHETIC_GUEST_SSP 0
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d0c08aab3e3a..ee05b876c656 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -944,7 +944,7 @@ void kvm_set_cpu_caps(void)
 		VENDOR_F(WAITPKG),
 		F(SGX_LC),
 		F(BUS_LOCK_DETECT),
-		F(SHSTK),
+		X86_64_F(SHSTK),
 	);
 
 	/*
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 092c91af8f0c..d7e2fb30fc1a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -739,9 +739,6 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
 
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
-
 	kvm_vcpu_unmap(vcpu, &map);
 
 	vmx->nested.force_msr_bitmap_recalc = false;
@@ -2542,8 +2539,8 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 	}
 }
 
-static inline void cet_vmcs_fields_get(struct kvm_vcpu *vcpu, u64 *s_cet,
-				       u64 *ssp, u64 *ssp_tbl)
+static void vmcs_read_cet_state(struct kvm_vcpu *vcpu, u64 *s_cet,
+				u64 *ssp, u64 *ssp_tbl)
 {
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) ||
 	    guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
@@ -2555,8 +2552,8 @@ static inline void cet_vmcs_fields_get(struct kvm_vcpu *vcpu, u64 *s_cet,
 	}
 }
 
-static inline void cet_vmcs_fields_set(struct kvm_vcpu *vcpu, u64 s_cet,
-				       u64 ssp, u64 ssp_tbl)
+static void vmcs_write_cet_state(struct kvm_vcpu *vcpu, u64 s_cet,
+				 u64 ssp, u64 ssp_tbl)
 {
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) ||
 	    guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
@@ -2685,8 +2682,8 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
 
 	if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)
-		cet_vmcs_fields_set(&vmx->vcpu, vmcs12->guest_s_cet,
-				    vmcs12->guest_ssp, vmcs12->guest_ssp_tbl);
+		vmcs_write_cet_state(&vmx->vcpu, vmcs12->guest_s_cet,
+				     vmcs12->guest_ssp, vmcs12->guest_ssp_tbl);
 
 	set_cr4_guest_host_mask(vmx);
 }
@@ -2730,9 +2727,9 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 
 	if (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
-		cet_vmcs_fields_set(vcpu, vmx->nested.pre_vmenter_s_cet,
-				    vmx->nested.pre_vmenter_ssp,
-				    vmx->nested.pre_vmenter_ssp_tbl);
+		vmcs_write_cet_state(vcpu, vmx->nested.pre_vmenter_s_cet,
+				     vmx->nested.pre_vmenter_ssp,
+				     vmx->nested.pre_vmenter_ssp_tbl);
 
 	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
@@ -3106,7 +3103,7 @@ static bool is_l1_noncanonical_address_on_vmexit(u64 la, struct vmcs12 *vmcs12)
 
 static bool is_valid_cet_state(struct kvm_vcpu *vcpu, u64 s_cet, u64 ssp, u64 ssp_tbl)
 {
-	if (!is_cet_msr_valid(vcpu, s_cet) || !IS_ALIGNED(ssp, 4))
+	if (!kvm_is_valid_u_s_cet(vcpu, s_cet) || !IS_ALIGNED(ssp, 4))
 		return false;
 
 	if (is_noncanonical_msr_address(ssp_tbl, vcpu))
@@ -3665,7 +3662,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	if (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
-		cet_vmcs_fields_get(vcpu, &vmx->nested.pre_vmenter_s_cet,
+		vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
 				    &vmx->nested.pre_vmenter_ssp,
 				    &vmx->nested.pre_vmenter_ssp_tbl);
 
@@ -4596,9 +4593,6 @@ static bool is_vmcs12_ext_field(unsigned long field)
 	case GUEST_IDTR_BASE:
 	case GUEST_PENDING_DBG_EXCEPTIONS:
 	case GUEST_BNDCFGS:
-	case GUEST_S_CET:
-	case GUEST_SSP:
-	case GUEST_INTR_SSP_TABLE:
 		return true;
 	default:
 		break;
@@ -4649,10 +4643,6 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
 	vmcs12->guest_pending_dbg_exceptions =
 		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
 
-	cet_vmcs_fields_get(&vmx->vcpu, &vmcs12->guest_s_cet,
-			    &vmcs12->guest_ssp,
-			    &vmcs12->guest_ssp_tbl);
-
 	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
 }
 
@@ -4759,6 +4749,10 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 
 	if (vmcs12->vm_exit_controls & VM_EXIT_SAVE_IA32_EFER)
 		vmcs12->guest_ia32_efer = vcpu->arch.efer;
+
+	vmcs_read_cet_state(&vmx->vcpu, &vmcs12->guest_s_cet,
+			    &vmcs12->guest_ssp,
+			    &vmcs12->guest_ssp_tbl);
 }
 
 /*
@@ -4884,9 +4878,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	if (vmcs12->vm_exit_controls & VM_EXIT_CLEAR_BNDCFGS)
 		vmcs_write64(GUEST_BNDCFGS, 0);
 
+	/*
+	 * Load CET state from host state if VM_EXIT_LOAD_CET_STATE is set.
+	 * otherwise CET state should be retained across VM-exit, i.e.,
+	 * guest values should be propagated from vmcs12 to vmcs01.
+	 */
 	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_CET_STATE)
-		cet_vmcs_fields_set(vcpu, vmcs12->host_s_cet, vmcs12->host_ssp,
-				    vmcs12->host_ssp_tbl);
+		vmcs_write_cet_state(vcpu, vmcs12->host_s_cet, vmcs12->host_ssp,
+				     vmcs12->host_ssp_tbl);
+	else
+		vmcs_write_cet_state(vcpu, vmcs12->guest_s_cet, vmcs12->guest_ssp,
+				     vmcs12->guest_ssp_tbl);
 
 	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PAT) {
 		vmcs_write64(GUEST_IA32_PAT, vmcs12->host_ia32_pat);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 294a294f0d0d..989008f5307e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4102,7 +4102,7 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 
 void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
-	bool set;
+	bool intercept;
 
 	if (!cpu_has_vmx_msr_bitmap())
 		return;
@@ -4150,21 +4150,20 @@ void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 					  !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D));
 
 	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
-		set = !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
+		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
 
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP, MSR_TYPE_RW, set);
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP, MSR_TYPE_RW, set);
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP, MSR_TYPE_RW, set);
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP, MSR_TYPE_RW, set);
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW, set);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP, MSR_TYPE_RW, intercept);
 	}
 
 	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK) || kvm_cpu_cap_has(X86_FEATURE_IBT)) {
-		set = !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
-		      !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
+		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
+			    !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
 
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET, MSR_TYPE_RW, set);
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET, MSR_TYPE_RW, set);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET, MSR_TYPE_RW, intercept);
 	}
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f2b89190a200..9930678f5a3b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1892,16 +1892,33 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT))
 			return KVM_MSR_RET_UNSUPPORTED;
-		if (!is_cet_msr_valid(vcpu, data))
+		if (!kvm_is_valid_u_s_cet(vcpu, data))
 			return 1;
 		break;
 	case MSR_KVM_INTERNAL_GUEST_SSP:
 		if (!host_initiated)
 			return 1;
 		fallthrough;
+		/*
+		 * Note that the MSR emulation here is flawed when a vCPU
+		 * doesn't support the Intel 64 architecture. The expected
+		 * architectural behavior in this case is that the upper 32
+		 * bits do not exist and should always read '0'. However,
+		 * because the actual hardware on which the virtual CPU is
+		 * running does support Intel 64, XRSTORS/XSAVES in the
+		 * guest could observe behavior that violates the
+		 * architecture. Intercepting XRSTORS/XSAVES for this
+		 * special case isn't deemed worthwhile.
+		 */
 	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
 			return KVM_MSR_RET_UNSUPPORTED;
+		/*
+		 * MSR_IA32_INT_SSP_TAB is not present on processors that do
+		 * not support Intel 64 architecture.
+		 */
+		if (index == MSR_IA32_INT_SSP_TAB && !guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
+			return KVM_MSR_RET_UNSUPPORTED;
 		if (is_noncanonical_msr_address(data, vcpu))
 			return 1;
 		/* All SSP MSRs except MSR_IA32_INT_SSP_TAB must be 4-byte aligned */
@@ -4852,6 +4869,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_MEMORY_FAULT_INFO:
 	case KVM_CAP_X86_GUEST_MODE:
+	case KVM_CAP_ONE_REG:
 		r = 1;
 		break;
 	case KVM_CAP_PRE_FAULT_MEMORY:
@@ -6030,11 +6048,20 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	}
 }
 
+struct kvm_x86_reg_id {
+	__u32 index;
+	__u8  type;
+	__u8  rsvd;
+	__u8  rsvd4:4;
+	__u8  size:4;
+	__u8  x86;
+};
+
 static int kvm_translate_synthetic_msr(struct kvm_x86_reg_id *reg)
 {
 	switch (reg->index) {
 	case KVM_SYNTHETIC_GUEST_SSP:
-		reg->type = KVM_X86_REG_MSR;
+		reg->type = KVM_X86_REG_TYPE_MSR;
 		reg->index = MSR_KVM_INTERNAL_GUEST_SSP;
 		break;
 	default:
@@ -6170,22 +6197,28 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			break;
 
 		r = -EINVAL;
+		if ((reg.id & KVM_REG_ARCH_MASK) != KVM_REG_X86)
+			break;
+
 		id = (struct kvm_x86_reg_id *)&reg.id;
-		if (id->rsvd || id->rsvd16)
+		if (id->rsvd || id->rsvd4)
+			break;
+
+		if (id->type != KVM_X86_REG_TYPE_MSR &&
+		    id->type != KVM_X86_REG_TYPE_SYNTHETIC_MSR)
 			break;
 
-		if (id->type != KVM_X86_REG_MSR &&
-		    id->type != KVM_X86_REG_SYNTHETIC)
+		if ((reg.id & KVM_REG_SIZE_MASK) != KVM_REG_SIZE_U64)
 			break;
 
-		if (id->type == KVM_X86_REG_SYNTHETIC) {
+		if (id->type == KVM_X86_REG_TYPE_SYNTHETIC_MSR) {
 			r = kvm_translate_synthetic_msr(id);
 			if (r)
 				break;
 		}
 
 		r = -EINVAL;
-		if (id->type != KVM_X86_REG_MSR)
+		if (id->type != KVM_X86_REG_TYPE_MSR)
 			break;
 
 		value = u64_to_user_ptr(reg.addr);
@@ -9862,7 +9895,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_SHSTK)) {
-		rdmsrl(MSR_IA32_S_CET, kvm_host.s_cet);
+		rdmsrq(MSR_IA32_S_CET, kvm_host.s_cet);
 		/*
 		 * Linux doesn't yet support supervisor shadow stacks (SSS), so
 		 * KVM doesn't save/restore the associated MSRs, i.e. KVM may
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d0b91e3ad9ec..d6b21ba41416 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -744,7 +744,7 @@ static inline void kvm_set_xstate_msr(struct kvm_vcpu *vcpu,
 #define CET_US_IBT_MASK_BITS		(GENMASK_ULL(5, 2) | GENMASK_ULL(63, 10))
 #define CET_US_LEGACY_BITMAP_BASE(data)	((data) >> 12)
 
-static inline bool is_cet_msr_valid(struct kvm_vcpu *vcpu, u64 data)
+static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
 {
 	if (data & CET_US_RESERVED_BITS)
 		return false;
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 6f3499507c5e..590762820a61 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -411,6 +411,30 @@ struct kvm_xcrs {
 	__u64 padding[16];
 };
 
+#define KVM_X86_REG_TYPE_MSR		2
+#define KVM_X86_REG_TYPE_SYNTHETIC_MSR	3
+
+#define KVM_X86_REG_TYPE_SIZE(type)						\
+({										\
+	__u64 type_size = (__u64)type << 32;					\
+										\
+	type_size |= type == KVM_X86_REG_TYPE_MSR ? KVM_REG_SIZE_U64 :		\
+		     type == KVM_X86_REG_TYPE_SYNTHETIC_MSR ? KVM_REG_SIZE_U64 :\
+		     0;								\
+	type_size;								\
+})
+
+#define KVM_X86_REG_ENCODE(type, index)				\
+	(KVM_REG_X86 | KVM_X86_REG_TYPE_SIZE(type) | index)
+
+#define KVM_X86_REG_MSR(index)					\
+	KVM_X86_REG_ENCODE(KVM_X86_REG_TYPE_MSR, index)
+#define KVM_X86_REG_SYNTHETIC_MSR(index)			\
+	KVM_X86_REG_ENCODE(KVM_X86_REG_TYPE_SYNTHETIC_MSR, index)
+
+/* KVM synthetic MSR index staring from 0 */
+#define KVM_SYNTHETIC_GUEST_SSP 0
+
 #define KVM_SYNC_X86_REGS      (1UL << 0)
 #define KVM_SYNC_X86_SREGS     (1UL << 1)
 #define KVM_SYNC_X86_EVENTS    (1UL << 2)
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f6fe7a07a0a2..9a375d5faf1c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -136,6 +136,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
+TEST_GEN_PROGS_x86 += x86/get_set_one_reg
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/get_set_one_reg.c b/tools/testing/selftests/kvm/x86/get_set_one_reg.c
new file mode 100644
index 000000000000..8b069155ddc7
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/get_set_one_reg.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 data;
+	int r;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ONE_REG));
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	TEST_ASSERT_EQ(__vcpu_get_reg(vcpu, KVM_X86_REG_MSR(MSR_EFER), &data), 0);
+	TEST_ASSERT_EQ(__vcpu_set_reg(vcpu, KVM_X86_REG_MSR(MSR_EFER), data), 0);
+
+	if (kvm_cpu_has(X86_FEATURE_SHSTK)) {
+		r = __vcpu_get_reg(vcpu, KVM_X86_REG_SYNTHETIC_MSR(KVM_SYNTHETIC_GUEST_SSP),
+				   &data);
+		TEST_ASSERT_EQ(r, 0);
+		r = __vcpu_set_reg(vcpu, KVM_X86_REG_SYNTHETIC_MSR(KVM_SYNTHETIC_GUEST_SSP),
+				   data);
+		TEST_ASSERT_EQ(r, 0);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}


