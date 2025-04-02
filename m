Return-Path: <linux-kselftest+bounces-30007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5064A78701
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 06:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD24C188F3A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 04:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED131F8756;
	Wed,  2 Apr 2025 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StBs+sA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026132BD1B;
	Wed,  2 Apr 2025 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743566626; cv=fail; b=NfHL5BuB9/EIkobDWW7ZE4zvgyqE2gbD/Mc95NQEs8waaISH1fdA2BPZ3sDmKAUPY/psRWwFalPd7m3nAY4UgeNypmnMpN7j3ixKWf+rJGTT2oXI7Twq/F/py/+4Y5TucTG5W9bdEF6SA0PIm8Ws2btDRja89yfE0yuGCtvJ5Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743566626; c=relaxed/simple;
	bh=HQvHlTHpZPC+cfqVpclDll00gY30nql94j0wkybu/QU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Munlc6ywI+8js0MhsWskhjdCpBCI7djb4iawUX+M5MexSHMtattN1j+VQP0Avh2PKTogNw6ZSeOl9SYcnrjn7s5Yt4CNazYZHkpv2jV4maqLkBX77XiXfOqvYEeX9dCegJE5ODB75oV9HvS7Bx+6jp1ABgh0dHMQeATYXiq0X1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StBs+sA8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743566624; x=1775102624;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=HQvHlTHpZPC+cfqVpclDll00gY30nql94j0wkybu/QU=;
  b=StBs+sA8q+jDMYiDkgGxshkiFbz/ix+MS4lHvoT6SomzEagngsHT4zVf
   Ucl3seAi8Cdbi1IgPiDp2kCPrefS49M8Kw33yv6FLqUp3FejhvRv0BI9b
   EIY1ff+mzAQZQqO2ouaupbj0SU9NV5j28kMEOE6+jbi/GK/E+pR882QUG
   kNNinZnqj5LBEEUXo/vtC9WSoUJHWj9PcjRCYSlRbmfTyMZ6dcTJR3Phq
   4hu0CLnP4/dUQPv9wRomk1Lhpq+043769dz77gSQeRI/mU2DoQx9YwM8M
   uqrgRj1wsQVGbPY/Lkd62sVOcUTjlUwTUcjyAmfD5gSW7Pkdc52bkQsSP
   Q==;
X-CSE-ConnectionGUID: QbHJBt8CQw6geLwHh09JDA==
X-CSE-MsgGUID: l7ty6kSZSnyJrAnsS0kZJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="45035470"
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="45035470"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 21:03:43 -0700
X-CSE-ConnectionGUID: nPx0QAbYSRKZ4F/LcW5e+g==
X-CSE-MsgGUID: VMGiRLyTSLWJgclwvI1BdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="126558431"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 21:03:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 21:03:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 21:03:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 21:03:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmILxfcwxi93paDR/697bHZSI8wLYV1OTkyaBJOz5KSXVK21Togrm7+ftxip5R7RZurZfDYvkOiQJnWilY8egX8c1gw0Yq8ieqgV1sXVDUvsSXwRbey5zSpjROLGHt9owwdm+hBNnmsJvMI0AG4GHvbLtFTbTEfxFJE/O/GKXieDZ3GtOSLMtQUYypqn8Y9LI1gRQ/fa6+mPD6we+cedo+Q2zDlp2nuav3CAbT8VCx5/nouBnnBydA1wao4mbkkf041/w9P80gkOqjDJOxZd3t21b45OwXFs9B/U97RgEVPD90Pg8kW3Qtbmbopo4xpbERnYnJzeeIg0C3yHOuvK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83ZSG4HIQm8maPS2nuj0za9TA/Z8SPhs3dA87D/wwbs=;
 b=LK8ZgQjGqRXeQTgup4GbLn32B0u4FfvW5t1ILyVo8QkQXllIyg7ic20w/NRfvyED83FP41PH/v1CSYdJcbxm4TE2+rKNCE3h0Dq2ojrS2ftGD4gJEm4zl9rZ10xnab+7toZ/dRbs9ckBlxRUs/lKo0pd3/8RTyt5rwMwpo+E5fR+oGIjIc2n29GyEqwpY1SFfqVQub/93RqxevSR462wec1Casn/ZtrmNbNl6q07ZxL+6dpWAkogj/d5VwAWAuN67xyd19hjZmDVtUr/kctiUvLk0vgQjVCaC51b2e/rh+dlOgKqDetJ0chvOJeyPXtg6TAvLcQjWKZlUbNz+yGpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB8863.namprd11.prod.outlook.com (2603:10b6:208:598::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Wed, 2 Apr 2025 04:03:21 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 04:03:21 +0000
Date: Wed, 2 Apr 2025 12:01:33 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <tabba@google.com>, <quic_eberman@quicinc.com>, <roypat@amazon.co.uk>,
	<jgg@nvidia.com>, <peterx@redhat.com>, <david@redhat.com>,
	<rientjes@google.com>, <fvdl@google.com>, <jthoughton@google.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <zhiquan1.li@intel.com>,
	<fan.du@intel.com>, <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
	<muchun.song@linux.dev>, <mike.kravetz@oracle.com>, <erdemaktas@google.com>,
	<vannapurve@google.com>, <qperret@google.com>, <jhubbard@nvidia.com>,
	<willy@infradead.org>, <shuah@kernel.org>, <brauner@kernel.org>,
	<bfoster@redhat.com>, <kent.overstreet@linux.dev>, <pvorel@suse.cz>,
	<rppt@kernel.org>, <richard.weiyang@gmail.com>, <anup@brainfault.org>,
	<haibo1.xu@intel.com>, <ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-fsdevel@kvack.org>
Subject: Re: [RFC PATCH 13/39] KVM: guest_memfd: Make guest mem use guest mem
 inodes instead of anonymous inodes
Message-ID: <Z+y2nU7KDmRpuISM@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <d1940d466fc69472c8b6dda95df2e0522b2d8744.1726009989.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d1940d466fc69472c8b6dda95df2e0522b2d8744.1726009989.git.ackerleytng@google.com>
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6572a3a6-457c-4ea9-e059-08dd719b4eb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MyAD6eRu1rVDAfy8AHeaH6wv0wQmUtUKED882l+rdx1noe1mCtXC7omZsPEs?=
 =?us-ascii?Q?3pYJ25wOU61atCH4uo4Y/L5pAvj3JDRmFnI53HNmKUfpIadPsnm/yZznx1ey?=
 =?us-ascii?Q?qnrLS6OZqgUbcLfzRgePu2CA2ygr1FmDfwd5PWk9NVbBN46bsDj1OBFO5Oj9?=
 =?us-ascii?Q?6WAqS8iUDxn4Vu43yY2sYT60ddW17sbjt8QTQh6knpcLI5xgOmfEL32ZzewG?=
 =?us-ascii?Q?jyrQ8NWlTJor9A+neO5YXusEtmovXTAiVMjFRs89SNvPWF/iI1Z3bW/M4GS7?=
 =?us-ascii?Q?tgERs70XCpqWMizS9nH7t5dc6JXRYrqWtZENkIjHQudn5wMvz7uPJdGo/1lt?=
 =?us-ascii?Q?/Q3SB9YE0f30P6dEWEbFS8AB2pL58Yk7NK4vWY2N8VPbHQYIVDvBGaJ019Cc?=
 =?us-ascii?Q?g7XXylMOeYTd6auYxCqdGMK65joJwKz7UJAUDmoWdpx0s8Ui3uh7SQhhFQ9C?=
 =?us-ascii?Q?hOQl3qtoZ1xBkHWYAR2q/C0YkDZaIi4aZD9KBzUlfje3sFC7nGP4tmHDBYSC?=
 =?us-ascii?Q?Tw8W0IB/lxE8/4rvT/zbyv5qq42W8lMoavu8CV9u+6X0WxE4mLxYQkOY1HEo?=
 =?us-ascii?Q?4RAvifKQLdG0FA09kf+zZweWokkMC4Znq6/CqFiL4P0EyKGsL0LHVr9+acSo?=
 =?us-ascii?Q?fH8RGdKVvhKK3ezB0oV68ZVVGxo0unv2eR2SjqQh92gL25TcvgLcxHq5frl2?=
 =?us-ascii?Q?0sO248b+AHemcq69TsZ6B9c5+2fyvWPJ8LAo3xBuhxqZ1apcs2pO8qRxnQ88?=
 =?us-ascii?Q?MBdHetBmGdObB2+LehaAVGxP3hBCYfA+pDX+fHItgf0/QRrMy+j5WPtN+XmS?=
 =?us-ascii?Q?qnq9JKc1jpIRZ9VFwyW+12Atf50Klk7reLb/9itHXT/Wv04h4xUcvUukcYKf?=
 =?us-ascii?Q?emQNv/BGoJD2Z5Uc3KEIFeJcdgDi6wo5zwAEWF7xMcoj2qT4onnqq5uQgpM9?=
 =?us-ascii?Q?InB82/S2zrVVdf7P919gzn+9mgfWEaxtenX6RvxHT75yg1jdruWQoBDt1i1J?=
 =?us-ascii?Q?20z3MDlPg8qoElewRnfWbtaBlvTWJ78Ty0CJaj4qVK42CVFchYTa7UIbfWZg?=
 =?us-ascii?Q?bfE4FKUKOeHV+InqcEzAwDcg21+uHxCN9mExTtqcUw6k4771HzNcTWeuXKvo?=
 =?us-ascii?Q?KNP1p/GxT+0c7vRgGccDaOWCzdIUcpklvO2icQMVycogBtNNpwNGvJiUQnhe?=
 =?us-ascii?Q?TWuolVOA/pNhfCymmzOQIoIg6jpmBGmrgA6ZMX30+n0BW6WKtCU/sc10D/yV?=
 =?us-ascii?Q?PdIPV33ihSgte8nXU9ogU9eH+WYoSigopDtZuijgI1HdxakbbAmTM77Q+GbY?=
 =?us-ascii?Q?y0i6YjmEpNQKR8BW16FI4clc+BkAmeLNX7BBFwjwThR7X0tfKiVnEgTX2WVK?=
 =?us-ascii?Q?qylAPKq9qxnzvuzhwBps5szdzMuGs5zc4cxzTSArkkbCNPRfiT1ROMKyzaOp?=
 =?us-ascii?Q?ogbGLpvhwk4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AY5qZ+oFlGPu4cXON/amNgF/P/eZNiWN6MKfSq+bOV9/zHXZluHDK55V/695?=
 =?us-ascii?Q?gw6+unqojZnL8qj8JB/GYNDXTo+71pGrC/YGfah3UEg482IeIBBwDrOMdTnW?=
 =?us-ascii?Q?1Qvysvp36IaI9q9CnBmsvMLO1b4H9RB1WNbJdKkMx/fH6goY3LEyow4JjKls?=
 =?us-ascii?Q?sDZ8zEiw2ST0XYEXgTXPL706xYLbrtxnZO/5imBm24t3qzTw7bd2fvlxMrR0?=
 =?us-ascii?Q?vKHGJVbkIDyxhbSnlcmL6VG/A/RqCduK1Px2BBad14iA8Y4yewWAFwlquokj?=
 =?us-ascii?Q?g18H5fSkgEGx2Q1hfalUKoSv+evTXq2Z5fag7HjbnffAN6mMVKUy4HjKHn7V?=
 =?us-ascii?Q?x47Eq+MrKt2YDOEFYQ+sRsriLMwhoBquHoZDq+VI9G63bcWmSZKgFBXtr1QC?=
 =?us-ascii?Q?hqC4mDNxNhtdOkL69qsh3hMOOPjpZBbba0oI9KGt7rmT89b/E09kdZWkNL48?=
 =?us-ascii?Q?WdUz6QAsMKlplAgCbsArcmGjWW311ydnqW1jqM4+RN9pxYcvC+ukXlfKtMmE?=
 =?us-ascii?Q?QdbhPtS6sET5uIoKXEBHZJQLXWWUjyeFyvT1BEkZw7+B1zSvuc/YSOYKruxI?=
 =?us-ascii?Q?lFEVsSnuRwz+S6dtejBZnyXIc04cBe4b4s4d3kcjL4yTijq34JAS3BexWa1e?=
 =?us-ascii?Q?wKTMNRwW1dm9rzTThALs9F2TZe70BYXatMBkIZhajCyMpWtJAm3m4XInwuqb?=
 =?us-ascii?Q?HVaqyMW5Mi4aM28uETwaoWJ2/O0BHyHtW9DRQbLjFIuE/kB6K9dyX1vf0eqd?=
 =?us-ascii?Q?BXpATbfHaADgcJmLJ9VxixlXSeSCTvBEUoeEttxk/7ccif8tG9F1C6f8xZmR?=
 =?us-ascii?Q?K4ZZ7d7zGSuXVVpBNXD0KvMj2zT3Vd/9QSgntmdKnAPy+pq3pQY/GykFqbVW?=
 =?us-ascii?Q?0DPdMfUdT3aSs5pBfONVHh6BuVtTklrM0xK1AtuXTDQTDvg4MvbDmNFmsC0J?=
 =?us-ascii?Q?Bb+sN7YRsUSRncZfkA+zIUtvqHaEng0OihE5r/zSMg5Th+M7vWTaTbEwSSIK?=
 =?us-ascii?Q?hEW9EGN5nWIBxelkk6LmzNpZ56CqwIlTbZo3YfSTnQhtaCn0EAqjmrAHaQNw?=
 =?us-ascii?Q?xuIOhtwTGChiHKLql/erhC35N7iKxW0YJT7rq7PYbKIR2/wL+4KOv+/+hYQJ?=
 =?us-ascii?Q?dYmCVkY6TdCm8uKuALrfdLy6HJESoqf4a0O9Gs5+7nN5CLbobfgeA6epNitD?=
 =?us-ascii?Q?ZGKFEWPyeV5FL/MnD4oZry9CgKBFCqKc1l7IYhMpWvwscQI/OIBb2kOHcz6b?=
 =?us-ascii?Q?WvRKC7yTVuH/qudz5TLKATx6gW5IXO3bOZyGZmxip60ktX2YYatSDTmeCDaa?=
 =?us-ascii?Q?W2+dwV0IkgWB3ryyYmm8lY28vmLepJSkiYF5Ko0EUgvB+YPUQavTrjmE1eIt?=
 =?us-ascii?Q?YJHM29OFo9mowNJ+0tE9OR01MJIxJKN7huII/IFplJl9Z5nDZGGuvH8sN9YV?=
 =?us-ascii?Q?rnMOGfUb9Htw3+lUQ0hbwmYfgCV4WrvZ7/ifqsWX2Xm4iO3XHGWW7rcNTExo?=
 =?us-ascii?Q?vgMuSHEMFBtikwbTbf333eGotmCof/WXAFYeg3C1YuTqE+cON1nS/Vq9GlaI?=
 =?us-ascii?Q?EOpMgm+D5jN5yd/rdD7UX4it0GopW8x7o5clE4pI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6572a3a6-457c-4ea9-e059-08dd719b4eb2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 04:03:21.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bChjQPRGswoCu2PGpH4dLiJGUMLy1U0yQgfDoIaZRV1rilOcHsCVN7E6ZXw6SOLWA5R5rl3ga5rt8q1ats0Qdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8863
X-OriginatorOrg: intel.com

Hi Ackerley,

Not sure if below nits have been resolved in your latest code.
I came across them and felt it's better to report them anyway.

Apologies for any redundancy if you've already addressed them.

On Tue, Sep 10, 2024 at 11:43:44PM +0000, Ackerley Tng wrote:
> +static void kvm_gmem_init_mount(void)                                         
> +{                                                                             
> +     kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);                                 
> +     BUG_ON(IS_ERR(kvm_gmem_mnt));                                            
> +                                                                              
> +     /* For giggles. Userspace can never map this anyways. */                 
> +     kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;                                   
> +}                                                                             
> +                                                                              
>  static struct file_operations kvm_gmem_fops = {                               
>       .open           = generic_file_open,                                     
>       .release        = kvm_gmem_release,                                      
> @@ -311,6 +348,8 @@ static struct file_operations kvm_gmem_fops = {            
>  void kvm_gmem_init(struct module *module)                                     
>  {                                                                             
>       kvm_gmem_fops.owner = module;                                            
> +                                                                              
> +     kvm_gmem_init_mount();                                                   
>  } 
When KVM is compiled as a module, looks "kern_unmount(kvm_gmem_mnt)" is
missing in the kvm_exit() path.

This may lead to kernel oops when executing "sync" after KVM is unloaded or
reloaded.

BTW, there're lots of symbols not exported under mm.

> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> +						  u64 flags)
> +{
> +	static const char *name = "[kvm-gmem]";
> +	struct inode *inode;
> +	struct file *file;
> +
> +	if (kvm_gmem_fops.owner && !try_module_get(kvm_gmem_fops.owner))
> +		return ERR_PTR(-ENOENT);
> +
> +	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
> +	if (IS_ERR(inode))
Missing module_put() here. i.e.,

-       if (IS_ERR(inode))
+       if (IS_ERR(inode)) {
+               if (kvm_gmem_fops.owner)
+                       module_put(kvm_gmem_fops.owner);
+
                return ERR_CAST(inode);
+       }

> +		return ERR_CAST(inode);
> +
> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
> +				 &kvm_gmem_fops);
> +	if (IS_ERR(file)) {
> +		iput(inode);
> +		return file;
> +	}
> +
> +	file->f_mapping = inode->i_mapping;
> +	file->f_flags |= O_LARGEFILE;
> +	file->private_data = priv;
> +
> +	return file;
> +}
> +

Thanks
Yan

