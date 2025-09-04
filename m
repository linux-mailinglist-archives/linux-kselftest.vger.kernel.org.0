Return-Path: <linux-kselftest+bounces-40782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C477B43E69
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4163ACFF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1122FF166;
	Thu,  4 Sep 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PskcboAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D441DDC23;
	Thu,  4 Sep 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995438; cv=fail; b=Kb9kqcqw/i0eOzO8YO7CqKVbPyJ4UqpnZGHGYp7jN6B2nR4nxnPvnx9vXVtl8jQMlDatgtaQu55INKLqtdO3h4T+9WjxIqnXihPU96nFTKlKHXAYWFcCPrdYdsF5Re/5asnJlFNHX9ueOHCX+pA2Zd41MbtbO08WqpmepY+3BWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995438; c=relaxed/simple;
	bh=4PABV4anIOdr+5RIW+WQ5YD6GzSWL0f6vp05jvoQffQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=je93b2LVOtk9gjCn3kUm8hzrPjSP7hH1hqQLHXM8uGhSzAsQw3I1rO8lAAboUU35hYX+6c43yUUELzsAk4Bd4a0O2ChU0w4kms+rmSM8tkQQQKufM6qhKUzD3NCxch+l0Z1ThPNFJI1PQc8ES0RYhTGpmgGYtZb1B8GTXlJVjqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PskcboAi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756995437; x=1788531437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4PABV4anIOdr+5RIW+WQ5YD6GzSWL0f6vp05jvoQffQ=;
  b=PskcboAi/OfvJcZIBuAE2yydbqloWH7lUXbjAgLJUFKJJg9YiZPoWOoz
   VX+kmbyOEUbwSgScdRmjLPwdIjqQAkHJXFjbkpBTZ4RLJ8LJgthmDSXSE
   e+h6LNrwK72duQda+9llHG2NX6zoSKFI7CO5DKVj+gbIS789WsOgovky5
   /LQgUbkI5QVIi2ftysLF4A6OK5mxlNXm+rcNIdjgQTCSKRrkPOhXfkwRQ
   h1ShnYRJR31nHWmnasNm7YSgxw3my/95dxdNEt2skjO73ZHVq89SbilXv
   C0wzMYIdRsYfi2Akx2PQDD00fM1Dr1VC2McV7lTuOaQvvR21e+LEtgdwz
   Q==;
X-CSE-ConnectionGUID: GbbiHiYtTx6WAQKRVHKLtw==
X-CSE-MsgGUID: Jez5pHgzS7auPYupB4L2Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63164241"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63164241"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 07:17:16 -0700
X-CSE-ConnectionGUID: 5KQgpav5TnqdPsXs29KV2w==
X-CSE-MsgGUID: t9S2PxjyQAOoYhCn9nGl+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171193315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 07:17:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 07:17:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 07:17:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 07:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBdAqcfkWKzEWa2PYDu7zeC0CuuXt8rwqC0rj0YMNzuJhy3tZKL/VFVbe6ieLtaO8EDpBWs8GP1wwfYQ0/1XbfUCkeUzIxIg+S03MelGJTBRyn5tn8DY5Qy2pba8KhXjK/g4eDbc1WxOPhe8piIWeQAPuGDXgohjfdY4z4mfHU9SMS+TFtO7elcpAJMpyu5CeRZCj+u/DGvUYX3tzm2h3pg53tvfCwPwNKxz28yNvs7i12uIGRna5TFwfF2qfzbDkjAN1lOQjbXPtjyA38XKhVmsCspVe2xy5DFfvT4G2aC5/UtVQCJi8KKSrWaalt40G9+CtqUK6DvxFlpZwyovyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKP3xzqe7KSRX/0NVTL3HmWfgSRSE6t62MtuF5GC2G8=;
 b=rZxAG7pmThpLaaj7HouRXFokEzzuLOivvsWCP+3FijgfHmz1bcTQ4JvBVKU7OV48Z9vct0s+zA+eE1zOU7z9OJpptONECatTnBcaOHc0i8ZhE0jK1lw44RT2LgN0JdBs4PYyXlESPm+6FyL9A8uCpRyqr8NVSu7g6/DRrSGUWerLBuYrB3h9pfBcvnwkrBU0blCi6sp02VeJj58xnkZEqZks69Qk/do/Re0WM1Y4o56r08qmqee38nZnq5xWgUM/Derz6XmZtH+LrJrzkKSV7f2OMyZZNRr9jkwiQbnn/4tKzQ7lJNtJe+5BQO3WoFot0gOdulVSq65rZJ84W7uQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 14:17:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:17:12 +0000
Date: Thu, 4 Sep 2025 16:17:02 +0200
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
Subject: Re: [PATCH bpf-next v3 00/14] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Message-ID: <aLmfXuSwtQgwrCRC@boxer>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
X-ClientProxiedBy: DB8PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:10:110::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c357d14-29c0-4773-7e80-08ddebbdbd12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OmWj6Xb0jHvtsotRteXzvkFQdtOccWzY3nx8rEDNsiySD0Xepa2psg95TOv6?=
 =?us-ascii?Q?KToP6TmXRzp2cgMqnA3b/FA+HmeA6loluZ8NIT9kVqGK+lyrBwzj45gW41cD?=
 =?us-ascii?Q?W91vapdZXk6kPxOhxWfv1HW0+1NscF0rpq8OSVb0mbHS0U+JzVG8ibvtybGe?=
 =?us-ascii?Q?9Ismj8mRxYIjgNDc2z29SkOmknS3J1EZvspPHrhVsiLXIsmQQDPESou6th9V?=
 =?us-ascii?Q?PoRCxo2m2aWopKFhH7LTt0x31MWR3Gqui26hU+gXOOrqQxhsJ0nNyo7X1Sqb?=
 =?us-ascii?Q?tcm1320jpoJ21fc+aYUZmp0SvjtJ0Y657DTNSDxXjQ+Qrwa1x6VZKETc+97L?=
 =?us-ascii?Q?7ODIkw5O1LEwjUTBviiObD5EjkNnfKgdMT6HaymOLLYKktfcBaqHglwraz/h?=
 =?us-ascii?Q?gnZZWwmZksIkj+JogX/Xv+7OQCLvOe5NmgAHP9N7/2N4qd+z4l/anV22TE00?=
 =?us-ascii?Q?8nSIoI4y+nZzqZxvsSd8rKO4xlTCrcJp/cqATR+zxDDxw5gRTyPxBzJSJRY3?=
 =?us-ascii?Q?/E75XLQ5M3P4BYG/wcQPUPwiFRWoocZ2EIOYJuDZyt6LsL7AfCFxufacMTyd?=
 =?us-ascii?Q?nGkDMKWYgyFhNNd937QJLRS15Bi0gKRXVoqXbYRFRaHYtS7A7Fcj/T6FsjvF?=
 =?us-ascii?Q?KRq7MO7xTs1S87efOY1EHMa1eUqoUvug3yk61H4pHscD4duK1Re2jfPc5Omr?=
 =?us-ascii?Q?UXt5BjTBMedoxYtzk68Nd1OaoaRfzkUtXw8huG89iDeOqOA9BM7nOBlum1lw?=
 =?us-ascii?Q?AU0vDyQA2dAl1bZSzjiTdnbrCQgOtai+Z1+U1g/4t4gSdbGV3jzNKdcGo6PN?=
 =?us-ascii?Q?nHQPSMbv9wZQROn+dq+/54+Hpm8QigSI2uJ7d7e3MsufN8BaX7uPikD02qhS?=
 =?us-ascii?Q?dkabVS2uuPTPdpFQLGiGd2PNcIxJyNtOIa3mdLdwbk6IG90ixVYESdl65lLQ?=
 =?us-ascii?Q?v3W/wBRlxUk5BnWT2St0xlFGor1luBRidC0zaGfLPEjgCK45w8WyGzc/+AJa?=
 =?us-ascii?Q?zmdixIi25Ff/r2jntRoMxZRUvkeOzamfuyDRV4SENUgjVr8Z72BQvg+DHYmZ?=
 =?us-ascii?Q?Oc9fz/sXU8hHcGLyk0aY/GFr3Q/eK+mWP9Cpqq7gDFzx87JleuCrmRaLHhj8?=
 =?us-ascii?Q?LK/YePKJyGGoyYXRPvpb8lW4q+9obEh3beG8VmeHQGV56BZyOnhwUc5HS3X+?=
 =?us-ascii?Q?q4oZbb270puKN6zt5aHu+9SNfIp9IcjXiIUxbdEKM3Px9QVH9HEhVIQ9nr7n?=
 =?us-ascii?Q?CJ2z+H0rQBrHKWRTGWiaxx9104lJ3WoU2FIYjJYm2dnVi2dTfegHgshIfJPe?=
 =?us-ascii?Q?M6/oIzavCS/6o28J5Ct0hyc1I0L7xlwZYspzwjRsXuDiptSQpoas+joCDv3G?=
 =?us-ascii?Q?bhU1yb7hUqVN5hL4YZDkPRsmvXFb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kijkJLIKzmW9EqZSdGJA6AM7BzATV8wJ0Q+ISbC0J6APMPMLF9Oe5CbQ+pCh?=
 =?us-ascii?Q?LzbnBQheWsYW71ciCADC/bvbM20rxBziu0YDNHoQ+eh6TX6/ZLsILw3kQuS0?=
 =?us-ascii?Q?R/eat9j6fj7PnRDDMOe25VsAOF2OMzoQ8j11skSdSkL0+DWewnGZB9gCqqaF?=
 =?us-ascii?Q?0hep8NDEaxkZN0/RQln0w7gHsLLSxNql/VxRVXALjMU8GYCkdJvQyLTE+OQg?=
 =?us-ascii?Q?ZGTFJR5hYgn/x+mFwV2xlwM+KpUJ2tcqVjyGS+lAAqmQQoY0HRleada1JczY?=
 =?us-ascii?Q?KBtrlkERrO/4TkcGZKSEcAIobqiPpvATw7scsqIzDbgHl0ki6yxZuQqMhOXl?=
 =?us-ascii?Q?INVhAs8mda1NXQTXBFXrO+IzmuIHPgy+JnyhS6HNo9p/EgbNOoiYJGy3Qfu6?=
 =?us-ascii?Q?CzC9DBrjfIW/ZRtSMjunGdSj2mzdCgEOJ0aOC68LyivsbCuJ5L9Lz4nTA5hI?=
 =?us-ascii?Q?qON2gGpOnDVesZasM//QBk/tCrQtvSJiKIBHtvf0VxvSWlqRXSOtKce58xAE?=
 =?us-ascii?Q?eMiUb9sab3mf0TKpm9zb3XmRWxCe46mwRVYXkHJBPyybGJ3oVz3kWc5NW879?=
 =?us-ascii?Q?/+Yfhe/JpYNR4QCUlB3ZlRD8Ua3mfTAr6Dq4Wuf4vuVbrLbF8EL9F0Wo0cpZ?=
 =?us-ascii?Q?XFIitpckfiyF5cZcis3oksbq+4OpubBUyvoA28oltgX1PXCBFP+Q8AqDyaJf?=
 =?us-ascii?Q?fzcI6b0NmXJ3iagGbFpmFAWl0Eoin6xM+WrZ9ctgd9ZQFyAHed1flk9c6zwI?=
 =?us-ascii?Q?F9nNiyN0eF5laSlzRfy1DK36OE5PRx3EoFlVkOJL/enSRLwvNuUn3Oc0gRDg?=
 =?us-ascii?Q?n/BawK656AUV4J/9euRwzuAKFS5/Wei5hxfxY7QGybqzEijHptCa1gQ+FBft?=
 =?us-ascii?Q?auuHHHtyxZ8s/bCVwmBgW+4S9Nmry4xw3o6YS86asUd5gEAcGZz1SekB9JD0?=
 =?us-ascii?Q?FZv4kL85HdN2wzgXrspI9RKN2YfMBnYSQkfVyW/TSB6OSrH+yEEkdcldkubx?=
 =?us-ascii?Q?bOJVDmcy4o/H0GCXBxVe1SDXCD0/rmN2Hi2yf9oLNti9cIrs2TSedagURQms?=
 =?us-ascii?Q?qABVCKGACl++2bJvqGHFPrTCH8/sXDoth1B/e8JKlBczw5wYUle3nc5VwjNS?=
 =?us-ascii?Q?/zr4PFopRGdpwohfbevb2s8HBxBCZ1pZZpzwUPafDfu9xRcrId5rlL2k10DL?=
 =?us-ascii?Q?gXnA+yb3W2+TYGUMFAyLnt3z/dzVlwUJjyheNMKNAsy7Pz90w4AznEdzCfin?=
 =?us-ascii?Q?w4E3hYE4svo4RoMCXPaFuBynoKJaDnVZZ58MLkCo/WRl7oPrFPl8/30vEiaU?=
 =?us-ascii?Q?JhXWchWCiHzQoHCjL+lpaj8YVlJZgOajER53ruGzcTieBHS+U+3oZANFkpg0?=
 =?us-ascii?Q?6S/2mTORLBrNnMtAQWmo3ytFp8dXWHRgHIUpEV3c67iFHpvTtPrdEwvGFPLS?=
 =?us-ascii?Q?/WsWrcPv0yDgAvnWNTo4NwZS2QEWL7o/P48bVIPMHIwzsxAjl4ftUuQvjnCQ?=
 =?us-ascii?Q?SgvEnkA9gciPZfS9BiVWunitgwq7Z5oawMFbRODlkn+YjS8aUKKPyiu3rj6V?=
 =?us-ascii?Q?Y+0n7Z/sbA/Ywtms+FGSRlU0gDPhADB0lrXKgxF73aOqpiN9s6aJgiuhTape?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c357d14-29c0-4773-7e80-08ddebbdbd12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:17:11.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9BLqJorivpEiV8I4q3k3qSl2f2gz6ejNqaYq2RA2/uGfl3ZHnpAy7lKfh3CxIgihabntTfX5qWgBYOwcTBcz1V0G2syZCEkkMuPMYMocpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com

On Thu, Sep 04, 2025 at 12:10:15PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> This is a second version of a series I sent some time ago, it continues
> the work of migrating the script tests into prog_tests.
> 
> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> are defined in xksxceiver.c. Since this script is used to test real
> hardware, the goal here is to leave it as it is, and only integrate the
> tests that run on veth peers into the test_progs framework.
> 
> Some tests are flaky so they can't be integrated in the CI as they are.
> I think that fixing their flakyness would require a significant amount of
> work. So, as first step, I've excluded them from the list of tests
> migrated to the CI (see PATCH 13). If these tests get fixed at some
> point, integrating them into the CI will be straightforward.
> 
> PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> tests available to test_progs.
> PATCH 2 to 5 fix small issues in the current test
> PATCH 7 to 12 handle all errors to release resources instead of calling
> exit() when any error occurs.
> PATCH 13 isolates some flaky tests
> PATCH 14 integrate the non-flaky tests to the test_progs framework
> 
> Maciej, I've fixed the bug you found in the initial series. I've
> looked for any hardware able to run test_xsk.sh in my office, but I
> couldn't find one ... So here again, only the veth part has been tested,
> sorry about that.

Hi Bastien,

just a heads up, I won't be able to review this until 15 sept. If anyone
else would pick this up earlier then good, otherwise please stay patient
:)

> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
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
> Bastien Curutchet (eBPF Foundation) (14):
>       selftests/bpf: test_xsk: Split xskxceiver
>       selftests/bpf: test_xsk: Initialize bitmap before use
>       selftests/bpf: test_xsk: Fix memory leaks
>       selftests/bpf: test_xsk: Wrap test clean-up in functions
>       selftests/bpf: test_xsk: Release resources when swap fails
>       selftests/bpf: test_xsk: Add return value to init_iface()
>       selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
>       selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
>       selftests/bpf: test_xsk: Don't exit immediately when workers fail
>       selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
>       selftests/bpf: test_xsk: Don't exit immediately on allocation failures
>       selftests/bpf: test_xsk: Move exit_with_error to xskxceiver.c
>       selftests/bpf: test_xsk: Isolate flaky tests
>       selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework
> 
>  tools/testing/selftests/bpf/Makefile              |   11 +-
>  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2604 ++++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/test_xsk.h |  294 +++
>  tools/testing/selftests/bpf/prog_tests/xsk.c      |  146 ++
>  tools/testing/selftests/bpf/xskxceiver.c          | 2685 +--------------------
>  tools/testing/selftests/bpf/xskxceiver.h          |  156 --
>  6 files changed, 3170 insertions(+), 2726 deletions(-)
> ---
> base-commit: e4e08c130231eb8071153ab5f056874d8f70430b
> change-id: 20250218-xsk-0cf90e975d14
> 
> Best regards,
> -- 
> Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> 

