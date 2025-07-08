Return-Path: <linux-kselftest+bounces-36736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC27AFC009
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 03:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3114A5CA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798BA1DE8B5;
	Tue,  8 Jul 2025 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3H25jfB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29D186A;
	Tue,  8 Jul 2025 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938460; cv=fail; b=qWoknNmQzIOIL/xOtJyM9eRGybBsDAVk5iUsLLTB0PdBHixWG5fT6o81ib6MZ6ko0IO7lFnYzNpImyzKdelI7oux99isHs3rXF7TN3k+eD+AbO99EujYr02AmJOpUzs6u9ZpQTq5c4LmZ4+UPM7rh/0NqMOUmpsrxvlOSXT3qnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938460; c=relaxed/simple;
	bh=jQ+RFx+xGa2Ii0UmyiVIMe2HLg+jYva0kARiyA4Fbz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6KovPRijGCpPXND8+ZuJHu9XsmonSP33wD2ghE+1KA45pbbXnJOWcZetXyeita7b/qZtN2gMFboqpbRVMuLK1LwWALfNiM1UdAQNY+YwhbWMHRYNd3fZb0eurhbU6nyb5CHAuCDN3yGf1TfwbQ/fuX3U81/MoX0qJl32MNB//k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3H25jfB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751938459; x=1783474459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jQ+RFx+xGa2Ii0UmyiVIMe2HLg+jYva0kARiyA4Fbz0=;
  b=E3H25jfBpYDxfOluHxzTkMXWxCK2cVXA28+qxlfU4sPrlEI1n9Mibz1R
   pJcAMmAtn9IVopuABMS6qgLxsS+GJrAThITweXYGD+qm6S9/T3ytXGMrk
   ZIW7VbPaKNXCdNiT9O1kiJ6PuqLEy+SKtSHMvLPRltHys9MkxKGJrI8zl
   WPPjtafRIhFOYB2sJEjEtBSdfQzifIIQhb8rIqBnOjD69O9k2ilFekqYt
   pCBGd4bzKc+2xHBEyr9Rfwxylwqw3Ae4Pr5QNz9PWdkRX1uYugoVpCwjf
   jLTXoHh7WWSj4lTrvaO4RibPk4aritFmF/JHQdi4Q2G7kjlX4z9Z764H+
   w==;
X-CSE-ConnectionGUID: TJ3csq1USdqE590UBh5cOA==
X-CSE-MsgGUID: XvmyNnnuRYWVJZJuMqWbmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54140609"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="54140609"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 18:34:18 -0700
X-CSE-ConnectionGUID: NcBFz2YgTNmEH6/fzLy/qQ==
X-CSE-MsgGUID: ijz2RVP8QnSLfyoLc4eYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159402257"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 18:34:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 18:34:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 18:34:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 18:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uysph329DanLkJm9yS7AJ1csfNKJVBURmwdmmO/UTvBBZiX4ki5wqMoTtWUJr/rOpdZac24vxy/Wnw5+DIgjFy49yn9xOBSiix0UBqEe+wyNRFJ5yp1lSj66DAqA0iFLUXrgZeqSXeOsK6dae+sARXnuOvrxMmJ/yfUoQ+ebfvLu/uAOUpR2O2PFSd/PetswP8nOCByWSy4hOW7kYUJZgYOrVRSkW5I6Q/qxHOKxNhyS/IQlD3UncwigZY4hI8Ldlh6arHoo5zNpdMgKEXmB6usUicsUJKjzM4kdQXuVJAwBsCc0M8ijfy3Lf03eCVDdEEkSjODaUvXIXCgSTzaUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eECsTix93F+S772quWVXAIdYD/XbEffUba2jONchLH8=;
 b=R53VTcVsn9Gp1IE6LLdrPAHSzL9m3+XQsvW/DzVt7WhMTGBvKuJ4IIjU033udKowyPzCOSQVj3Vr5cb681x2tu1pJX+4RwmZloROdUPwrJ7+40BjVdyMHm9YNcgOg1SpMvGPbeevVJw33zBRjHs0gEafBc4kJTAxYp1MZdblG6P++AMWdwpSwzmBmEkI+I/GPpgSWNzz7mzofN+fyvMf2EhwmvsUNxBxVrqqltvc+hMrZzHEOM2iJJW2TglvlyvXJF4my5ofcwqLRUJNAJ3CYa2vlqw9KAzKKwYdp9TTjT8D+gjp9jx4go5e0cWSzzBrkjJIK8VwaHWtInwUv716lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by PH3PPFDC3198517.namprd11.prod.outlook.com (2603:10b6:518:1::d55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 01:34:14 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 01:34:13 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next 0/2] Clarify and Enhance XDP Rx Metadata Handling
Thread-Topic: [PATCH bpf-next 0/2] Clarify and Enhance XDP Rx Metadata
 Handling
Thread-Index: AQHb6kDv34r7CwtKZU+M/H+rEE6nILQnLlWAgAA5NRA=
Date: Tue, 8 Jul 2025 01:34:13 +0000
Message-ID: <IA3PR11MB9254DC4B7984E014206A1FBFD84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250707135507.29cb55be@kernel.org>
In-Reply-To: <20250707135507.29cb55be@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|PH3PPFDC3198517:EE_
x-ms-office365-filtering-correlation-id: 32ce5af2-de40-4292-953d-08ddbdbf8bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?J3uL841EUBpgzGvI3jcm4zY4YXsvPKWvyIjRcJu3ZWwMtadGfqCREuoP3ja3?=
 =?us-ascii?Q?i59csquJ5RZKm1h0jQAxCbMu6HNmBGixmGFUMkTJ7wHUO6tQKT61QYcifD7/?=
 =?us-ascii?Q?fSJufrhiEF5yfJfsZFZOqvpYMDZ2jNHFS0n4yIGZGAhSKTkDg3UeUGfZQPPX?=
 =?us-ascii?Q?BVlqI59tS0aPW+AY7LKtpwrLLdzeDRxZRu/XyScku+3CQbPYTFwi0aMxLGen?=
 =?us-ascii?Q?mER2WxjbHimrdo9Itz5RUdJRQs0ai1ywbj+OfGEyf70lSryOkUwvkMXqhJUi?=
 =?us-ascii?Q?QLmIB+LJETZtMBwb2qzWMoIQesTzbbJNeSn35rDIUHA9+F/gIFKy0fslzq2w?=
 =?us-ascii?Q?EAb6BTDA+y45dIK/dp/vw8Yw9j9vUhZF5Uphvkde71yAz6QoLzv3c9MnpsRV?=
 =?us-ascii?Q?LHbLovv4IyIHE0ebXg96o2Ksg8HX+9ickSw+X3a3fapJHkx2IPej+LTaY7YK?=
 =?us-ascii?Q?d8WtPuukgeOgXp6/LLhmBgD4z5JijpgEfV6mLNQNDwPVw2F8tXfqT/f6MAzr?=
 =?us-ascii?Q?nTIaZuCrlXihUO5RfNVkhJ9XMCdicZ2uTzyHbSIPk35ZBnbEKEWL1rQyCNBB?=
 =?us-ascii?Q?UmQPcfvJsTDVqfmuXvIjfc2dBuywNBoz37LK4zks2vkrPEotr/n1QNw0d+EJ?=
 =?us-ascii?Q?ObPFczCDurn3Hse9vJ1mfvGAiS6I6lOGunSPgjoe1tCDiKtRAS9+70sxMIv5?=
 =?us-ascii?Q?xBT+y7u+e8QDGwACSkUBn+/whTYryjiTY7zZQELxTiM6mRjaU+9+7lXRUzZU?=
 =?us-ascii?Q?Yq6LqSQ8Vtf44T0RSGd21t1dD9YEgp5zX/gUyKYQnDuTiO87maWHb0EanjQo?=
 =?us-ascii?Q?TE8qwkhZJS43w8sjKqf2jHJihRo7pBgCPVstPy8D8W43vt+VbujrjjP9hzEp?=
 =?us-ascii?Q?+2V3ZnF3YesOfHVPkHfg+jB3c2/J6x7oXXBr2TWefJbWagLTDTrumga16GHQ?=
 =?us-ascii?Q?qurHL7w5t647mSn6qGlr5lyvP0lQtQDJbnx/sCOjOHeNXDW9TAnq0zMTpfMX?=
 =?us-ascii?Q?ClLyFO9nHnfNiDedL5rfmhasrOWWa+js6kq7KhznIbtEGD6udG4b5M7kOxGx?=
 =?us-ascii?Q?mxmRe2AFUKFZVE8lhNeYibir8VdhSj9KJtO9DwGdN0FDuG7UwXgnhWHb4DeF?=
 =?us-ascii?Q?6yPmt7o85seFOJvPv5Fng024KG5+AVwViYLQ8ADzHaFIl467CZ43P0X42t5X?=
 =?us-ascii?Q?GLEdZnfxiymAYxu+RR7ikz2qXhaaSS4hqGZiWqcsPnURcRT1VBxeP6TpJw2F?=
 =?us-ascii?Q?m9ZyhsXn6VgUTMz/8OpMR75/l3nLxLKELwBxfS873oxniGFfgE1WiX8ScTom?=
 =?us-ascii?Q?STogg0CuLngIBJAA6U/dZoeoiCcnw3mlBZDMT+5IZkHSIFyIDfrOxdlOtoiL?=
 =?us-ascii?Q?fJciwQVHvn2SORI0DS62eRQv6XkEvqrgAveHmxbD1QyvFrDw3XQrK2+Em7Ss?=
 =?us-ascii?Q?OIEQxOz1419++ALCWgzoU2+MdiNsgz2VAwmewGD4lYHaER6Ye2cVMA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rJQfzmRXEp8leH81wLp2fFUTsZx62sLAFxPo8morAiRdM6RmhRDUbmiAp/5Y?=
 =?us-ascii?Q?QgyFyS4tWvNuwq/v9ykiQyTkEyrC9EGQYERZDRSqMEee4GqXqNZaboOD/eHs?=
 =?us-ascii?Q?zC1T16pMxqaZvO+L9bN/cpf0W80XdKCj8JuGyJ82aRInyXU92xzsDDNqn3PH?=
 =?us-ascii?Q?Dsao3CbHBWu7N13rUOp+OL3+8gyRVCPKREtmsQaxMVKW+VOORV8w2TQyDrL2?=
 =?us-ascii?Q?TiHPm366JsolU8IUrOSUExvSGXvhJ5f2z6/xejoCLMG2hOokMxQKxzYfcruI?=
 =?us-ascii?Q?uRbJobw5u+ht9ImHop+UDBpB4m8yy6VbAQdRM7WPLjHDjFwT3WBOMohdX0jK?=
 =?us-ascii?Q?k9hGkrxnFowhy39ToC4+JjQDOyxVfgz7WpzsdzysWmIIS0LgJMAXpcZ1exZ2?=
 =?us-ascii?Q?DJFnhHutP8vp+ec2Zg01ybXPGdVcu5eFWqG+xjF81wzXvADpYK0Bhe/dRmGs?=
 =?us-ascii?Q?Znw+M/AhUPc7NUOeQOx4k0OkQOJa4xPu6xU0EiVXnUHFNkvu1c9fcpS9mmzX?=
 =?us-ascii?Q?rU4IEheqp9EiU6YfaE1EjXfmopLryrxmA3KliHrYbL//Dsh3ZKD+ie7cV3L1?=
 =?us-ascii?Q?QKTpyn8G2KsuAeqGHu2ltYSz1T8Ky9bbP3gQbIqq376BPhy+Zx6AdpLoGj/1?=
 =?us-ascii?Q?fucUdrQZGuGD4pEASJyPWKPmQI0uQX8Xw6Rdzn231AxgFb31sZ39K342/JzL?=
 =?us-ascii?Q?1MM4PVvPlwZk5fqgL/WfnTd/QFxgA/yEyR+qfRTAPOVyWdxW6bYRCRkiY00t?=
 =?us-ascii?Q?WZ21CZUVqcdBSRPlZWkG6BYxZfBHjoXxAZxPtmtcxOXPpYWzwLwjXxEGs/iN?=
 =?us-ascii?Q?OEaYQ+99aZ+38EYHhc07+A9m28yZhzP2j6FiObhhkC+iNSEl8g7I7svDYd6Y?=
 =?us-ascii?Q?gEAZy+Iwxn7mYzzdzsGx5qmMT5Pz/BnitZ7oRzfc2nnI0dDSC4/0E+sYUNLR?=
 =?us-ascii?Q?jEc6tfso0Lkf2zbL14m1kMOdGm/ES3CRrw7BVRN5q81i1GMQaf+T9uVjWr+Y?=
 =?us-ascii?Q?B5RAJQTnwsthwXv6v76nz2RxqM/FFBnG1XOk7lsd84v/5gzFNnq/V2VC+Wil?=
 =?us-ascii?Q?w38dX5tAdRcK1aALtPgr5AWDUK3fcdetbsj+YgrNC9KT7+GuhQs6EwSRe+4h?=
 =?us-ascii?Q?FCkTsvDOG8kr3WjilHLhVcyZqgOny/Khew35y8dKeIgONczdM45MYS+uls/z?=
 =?us-ascii?Q?aicOVxqHCvdFIFW7by+mLfhmoHNK0knrdcLs8gq/Hh9zR+6fosFWqnV96nSr?=
 =?us-ascii?Q?+XtSvmEkirOGcIMNAIFj4WeXl1r6e9KDOV05qyLMjxbu+5vg5+QEQevobnzD?=
 =?us-ascii?Q?+m3bwrxfdJkA/M5TbYBfgnUS+N3ILPizybmTfafQaKF2FgDmlkxU5f/oWx/4?=
 =?us-ascii?Q?ERA45l72HwRESU028D8vvMCj3OXIR+r8DAvzss8sGBDk3mZZ1XsUjosDSndH?=
 =?us-ascii?Q?19hd+YakhYvQuEDYnB5VtYjeo1cITMjyulV6ZSq6eaFFiIPct9Ep9IJzzn5F?=
 =?us-ascii?Q?T0VHPcP5p2++wP/c16Rn6Ow02dqnYpLALLGjSfYap1qzSsKwXzl9klUxwPp5?=
 =?us-ascii?Q?xgdo33jtiWQ++qnhihJWPXzfYtGMPsFQkpN6rv6VgTu+1BQ4BoB4Ztl18Gyu?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ce5af2-de40-4292-953d-08ddbdbf8bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 01:34:13.8820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtwxeiKFKvbhHCqVYu6XIyT/x/w/5pXzhXdlZSkVszOkmYa6s0G26roefJKjDGs14m9uJVcfRz8jMkl8TQYrqqQqp0oQT8jx/Q3p+M+Zb9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFDC3198517
X-OriginatorOrg: intel.com

On Tuesday, July 8, 2025 4:55 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>On Tue,  1 Jul 2025 12:29:38 +0800 Song Yoong Siang wrote:
>>                         |<---sizeof(xdp_meta)--|
>>                         |                      |
>>                  struct xdp_meta               rx_desc->address
>>                         ^                      ^
>>                         |                      |
>> +----------+----------------------+------------+------+
>> | headroom |    custom metadata   |  reserved  | data |
>> +----------+----------------------+------------+------+
>>            ^                      ^            ^
>>            |                      |            |
>>     struct xdp_meta     xdp_buff->data_meta    xdp_buff->data
>>            |                      |
>>            |<---sizeof(xdp_meta)--|
>
>Huh. Did AF_XDP maintainers explicitly sign off on this or it's just how
>IGC implementation works and nobody noticed?
>
Previously,  IGC do copy out the Rx hwts from metadata area,
so no problem when implementing XDP Rx metadata.

After that, net_device_ops.ndo_get_tstamp() is added into IGC to
support timestamping from both free-running clock and adjustable clock.
The 2 timers are stored in the metadata area, thus causing the issue.

>For normal XDP my understanding is that its the driver's responsibility
>to move the "reserved" stuff out of place before presenting the frame to
>program.

Is it means that driver needs to move out the "reserved" stuff before XDP p=
rogram
and then move back the stuff after XDP program for certain situation, like =
XDP_PASS?

IMHO, if driver is allowed to use some portion of the metadata area, then
the packet processing will be more efficiency and also align with the "zero=
-copy" idea.

Any thoughts?
 =20

