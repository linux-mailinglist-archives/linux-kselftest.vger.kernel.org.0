Return-Path: <linux-kselftest+bounces-30324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E214A7F2C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 04:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABEA16A925
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15F22A7F6;
	Tue,  8 Apr 2025 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRbtPd01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC179CF;
	Tue,  8 Apr 2025 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080179; cv=fail; b=DjUQuExSI6GFGTSiRKS8RgtPBmfuLDTUYTA/qpBHdZL8yYXaGGejusW7BfqsUSwqiAFmuQcuhQ5nw8nTOpO706rRdwDiV58ontln/hmsEIjjEONWXzl8wLV1d6PhaJIsQthY0ViDp/GGjLWf8AN5Vi9YKWVAGhoe6+E6OAo/dHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080179; c=relaxed/simple;
	bh=3Aevp/gg14K3OnrT4hB64QNpDMAD1Fv4cCJ51kRNyMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t6tHMTd5s4Er/cco69Pf8+gHtqE7jpeZbNuro5a/3J4jQjiWOIS62qcgnnUsPeDXmRFH/+kpFqAP/+qVXz5LSCW1MOT7Yx0qPDpCUoTFhJ1XYazsUbX6GmFmIyDbMWZg1Eh9IbLorPpKgnkdTHiHeR4eTFaL7570LXRv1Ws0KwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRbtPd01; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744080177; x=1775616177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Aevp/gg14K3OnrT4hB64QNpDMAD1Fv4cCJ51kRNyMg=;
  b=kRbtPd01mrVjx1EnEzQGV1+0ZnK3doogA0UGaxCzSbTnOI32iZlHFAaJ
   3SJ7cQP+6opZCJfGfuXJa+E7q12Ditjo3eblVTpso/c4veFtB4T/lmYhW
   fm4CycZnAPRJSvdknSRJL+JjzWkCFpVUsJmGGU9Mloo9oUgrWWGpnWDXI
   8ejOs0gYukJm48TNLmIZBV9ApUA4K5S8ZZcN5+d1vt8d76qo3usQ7b6aT
   iAtYrUYl/Vy94jg3IcBrlHnmNADMOpG0t+4h8nNp2coQul6YDAB6aRYqI
   fv+QigIvH4XF65QpgHyUHhoFrifIHi6vefeHyWnzpOV8z8+oVL/XSstX2
   g==;
X-CSE-ConnectionGUID: /aRa5dueSFWByMFXmZSazA==
X-CSE-MsgGUID: OG89lBu3Qb2FNvEnIUE7CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45379145"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="45379145"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 19:42:57 -0700
X-CSE-ConnectionGUID: AUSg1cKlR++Rx1MeOrq3KA==
X-CSE-MsgGUID: 5q8f6rCQTqOCA2aicNEohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="128987699"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2025 19:42:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 19:42:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 7 Apr 2025 19:42:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 19:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEd+wCdBUxcky+YJAU8/xYaodFpgrAvUBjB9JhX59PxEjam7UvlAUFU7fnUnmJqW9ff2vMM2/a1m4oM9pPPTqJNhnNuYBh6ZW0rPIH3tYk6cX0dsCCLbwhm6vuUP75PNFokCQESjysBammTEeW3DQki6zvCR6kiudL81ojWzfbR0kOHBzOI9Zqjx7NWo/O1wxlAk7eICwY4d9avgbNeHLAmi0cw1Xxmryxo3Izj1s/06GH8CB55oAc1tlx3zppbiHGD0VtIJ2lh+4aQhrUh3SAEeb1ypvEJQSwAfCZ+pQ6TRxNde7K6+2JvEqHSPL5ReeoCgzEZXdzfWT6+XAN3ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYqebnwHbSDKLiz3bEqMDD6JlvxyDSIzC/qcquoCFwo=;
 b=Jtzd3J3KcO2ClBMuXm0VXRjXBOjf24LtLVDq1lxx9N/UvaGpSON/x7vclggxZ2xRSO4Rcr/O7kD8uBS7fvAe2XvBVsAHA6JjqR9ihnmuM7LpHnd2bQo5Ph/ChGKNcj5FeL7RFiZVpDbTWlbkNq/88JnKEeUzO8As3lIJA6c3CKxwbe4ryjaSyiABZ0ylBFBHLdIfYX+j8nWX2MbJfYjugVvMYJBbexj5bRZ1BuMoDzPPpHcPsaLERE5PvEcUkQYlXEF/2BbJ2yo1A4JK46fTaOFDYiyWAnz6VDzmCZU+lBMv9f4cviNpUKxaG2ib4uktNpxiPfvWmRdcduegObkxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 02:42:38 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8534.048; Tue, 8 Apr 2025
 02:42:38 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "shuah@kernel.org" <shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>
Subject: RE: [PATCH 1/1] selftests/mincore: Allow read-ahead pages to reach
 the end of the file
Thread-Topic: [PATCH 1/1] selftests/mincore: Allow read-ahead pages to reach
 the end of the file
Thread-Index: AQHbkl64scjyriwM/EyQFUCE8lfST7OZOa7g
Date: Tue, 8 Apr 2025 02:42:38 +0000
Message-ID: <CY8PR11MB7134D020E20B290625057A4089B52@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250311080940.21413-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250311080940.21413-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB7252:EE_
x-ms-office365-filtering-correlation-id: 4a3c93ef-c080-47d9-76b1-08dd764706e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xpwJhSY21T3yb5jak+bu4/zZptse4M7xEYGVn57kRd60CKltrw12OEbIPxvU?=
 =?us-ascii?Q?hL7QzNtXegCBZH93E03f7J0qEPbUkQefp4d6OCYLGnVpyjcWZTquo5fvDFkh?=
 =?us-ascii?Q?SF8mYuhBOh1BA/W0bMWqoclR7kE+xLp/i/p52a0IZMs7YQrDyOgvEqwzVtQm?=
 =?us-ascii?Q?YdYsD+oeCpUOSfL9C6u6qSeX5HBEkEJu6jv/yBeNtnho1DSlb5nf/TyJ7ygh?=
 =?us-ascii?Q?F2hkMiLDlLdGNTJoI2/MuxMmJ2rPZTkXl8jpcgfpGnmw0txd93XQhx2GPrex?=
 =?us-ascii?Q?F2gMglc7CEwWj97AWtedfCR9KBpXYEhKaWfvZvbq+IVKKZcoOrO2tzC9K2CU?=
 =?us-ascii?Q?iPQ5/HRzJzodnitfM9UvGuJ3kmwSamMqNPevr8fidEkrzdWSIb++Cw3O/3WR?=
 =?us-ascii?Q?JU7Od5RVet2Aaf/5lu38qPHguOZAEPTQL1F8loEJTKYSst6ulac+k2LFFHrG?=
 =?us-ascii?Q?kNOcFmLREZv7Z6fJ8YLu1+ukPKln89K+LX2TWGKQGU3nNeuQZmVJ+1HZE3PX?=
 =?us-ascii?Q?lZTRrm4kaI0gNvW51ccYtGny69QIIg5CwOHjuPFMl/C2vzDjOJclHF3Z48kd?=
 =?us-ascii?Q?BWgEKFEUv8WUG/nvEp2PONpvPIwdxMCuT6e5/QeuKLaW+mqsganx4yX4CNkX?=
 =?us-ascii?Q?ZHMfNST6iHPjpzY3kyCLoO4YOuDyYWCnfF/UZfbF6d2NcAWpHqRduUlgRatW?=
 =?us-ascii?Q?0ugL/zHx1S2JAyvSw2pzQhVD0XobaEu4JHBlTMxGAElVTZ4cxamJOx+M+yH1?=
 =?us-ascii?Q?h88ldfTaQfwghZOQG9PkK/8UeiuabOMb9dyS//nh+jPO6Cnm+IMA9iQoXpRR?=
 =?us-ascii?Q?HmQaO045nyWEmqL6N1Uhx+vo2eFj534HAqz8v6ojfq7XKD/uWnth7dCzyET9?=
 =?us-ascii?Q?db7KWIKzvD1bBaPxfzNxnpST0YUwsTsmTN1807ybUHjSoCeUUNXRtDQX5Kfg?=
 =?us-ascii?Q?29GYe+EHlGuv0LYNN6bm2tvzDB6w97eE4P0T5d3R+7gYctEGhNcUwzBSNsmE?=
 =?us-ascii?Q?g8V4D7ugJXU89nH7PQtm4e5YTeMUOc6oy1IlVrWxOElET55qRJXneoF53y1n?=
 =?us-ascii?Q?8CeMxazg0Agb4NoeLSXUqQRQCrvb8XAPsjn/AlbLFUpedzqtsjlXuL7fqNvx?=
 =?us-ascii?Q?5CJBwo6ErnBKjEXJWytM02FYA6hG7VqAHYDHMJrMOE8qbizq/doesKCrnfzY?=
 =?us-ascii?Q?m1CKvt8NRp6OVqQuDfIl7H4VFUYuSPw2HmPUgLFj6Fjh05r/KC8nuoWiq2h0?=
 =?us-ascii?Q?GJOF4u/cAD98V8bl1v/Buz56XTzGLdrTn4ZmB/CfNbC08g2iVIHYe7bPvQcM?=
 =?us-ascii?Q?zKQgdaZpWXSEIx6bZD10mtfDg5riXUBwU03zTouQFMHhwehaFhUR+vLrpq28?=
 =?us-ascii?Q?zq5qghVqrNDlckAQpbmQpaR2JiplZQ4A6K7xGjLL/RoQRtrFWeC2Q6a8/YnY?=
 =?us-ascii?Q?WQl82uAaZNGbslB3JTN7R8dXdS1z9AkB28JusP4+bk+pMnBikkW1UljeLaTm?=
 =?us-ascii?Q?IvSWip1LF2oNasc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?80rR7I2OCowsyzEasGJ7YQEbjyL+jd+Ex5xPCnGUOCKCjQ4mGw8ip8uLHZFh?=
 =?us-ascii?Q?3R5cMFn3DGiP10WNSoJxhDL9wmCoTWP550NRP8ZeLVbBCzXiTBo/oOtFEwxh?=
 =?us-ascii?Q?FM5sgtHb8TR7wBul9CD9scLSAfbh8+MZFePLKX2/wJtQDad29LH60rs2PrKs?=
 =?us-ascii?Q?u6+vNK59Ndudo4AXYvwOtBYSo/LU+SaR0CYUGRNpoqaUKBOpKkR4LE6zxsCy?=
 =?us-ascii?Q?r+FGB54I+gcbE2U+8lZzvb1zqiS0J23uHpMycKhodcw9PZpyHvoGRXtjdpPW?=
 =?us-ascii?Q?Swc71FkgtNHS5rM5qCcYZ3mMJ7NgrkIGkTyHnmIzFXt1kG/zK0P3j6zDd5Az?=
 =?us-ascii?Q?bzCNmHcqbuq3bhlD1nT5Xgwp2CRkKBB3KEy2Lw3X4/Cu/TLEnv5R5gEdBZEg?=
 =?us-ascii?Q?38pz74hTaIarnoF5JACRgiLTULZ1TbcXHlWG5KuJ1ZmdG8OACOqCpTaeeOMK?=
 =?us-ascii?Q?T5ugwI85ayyP+x5mZwKhOf/7rlWHb81Xm3Xyj8LoJzli0ymFK4tlIA13xr49?=
 =?us-ascii?Q?140lneQol0vFrgDImNLGyJiOjcQ7EZeCtfXGdRNp0T6wk+L4sQ+zFKVRU3tv?=
 =?us-ascii?Q?eLXbUroA6Zg8zp2yQ/3aTdIeqo+H1FfpGEI/5iImm4awyTtRXCMt6mBRvKv3?=
 =?us-ascii?Q?wHMJGiFPCFtm1TOlT74NAVbKhm4KNhqOkpn6UebCIrjlUB8ErdNVHm1RxPQj?=
 =?us-ascii?Q?6BgrzpGk9NuOSvqIHvObVy+KpRiHLllCY7uFE9YP1M8fr1j/n61OXmVjvr47?=
 =?us-ascii?Q?fbOxWszGoEUlofRNeGKqyS+mDKEyWPCi9NgIkbdUi+H65Rq8hm0tBWcWrjBz?=
 =?us-ascii?Q?3OT4OTJgRpZC8yvXKH7uJQ+QLVD0p8UEpIzqL5iTkd90kB3eNiY+vaHAzC3c?=
 =?us-ascii?Q?orYS3ShID2shJd1RD81fBZiFBopSlpBvBePPi+2G+ucL+v/bExH4+8x8GkHU?=
 =?us-ascii?Q?Iaevq23TBDyQU3bdAk38hGKjTTaCx4JzBOjXRqmfZwonZPb3TtaZaOCkyv3p?=
 =?us-ascii?Q?+zPabIQ/9OLxFzdsonhz/86rKxMBK/7Vr+IaAhMeZqEWzH/2IUY9Ng+1GdyH?=
 =?us-ascii?Q?sSS2fPGC9QYidoSC81PzS3pFm1jN033tr3BDyDrgW5/J0Dy+j3MtIVc07+73?=
 =?us-ascii?Q?jX+QKsg0Rv3Mh0Dx6ucztz8f4Zus0g19Rr4a14VAfuUgeg/QGZmAjLRp9Jvn?=
 =?us-ascii?Q?COf+e8Usmhxu4ah0mv8HLDtiwLFXERyLc9vhxAkUA+lkfXAnUzzCw79jLozU?=
 =?us-ascii?Q?7Xj3GOnaie4rlUh2H2xRYwYMOdtH3aiITi7dFsMKynwY1k5ABdnYbyCUlqwR?=
 =?us-ascii?Q?ix+Q2WQhvPSANFTLQ5cmLJGnQDlPz1pBqpMcmU2Rr2i3CDiY5rrgAgdz2HUI?=
 =?us-ascii?Q?RI8Yy9ZQ8HNLoEH5SP/oHeRu4fgLmM98Gry5KfnkVyNQXE0aizVLBNTnSt/m?=
 =?us-ascii?Q?CWt/UH6qlAOkHX23Ikk7lKk7Cz0R2uCTqi7PmDgLI4FBW4InQ3YWXNrcnOCr?=
 =?us-ascii?Q?MpSk4fOSYddglas5dEdFLtXcZVWfzk/kqIskME6OeYrNWRF0vLzVb79PCvIN?=
 =?us-ascii?Q?b+3OXnO79Q+MW93gg3XRlLh3zm450yyQ/VohZ8kS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3c93ef-c080-47d9-76b1-08dd764706e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 02:42:38.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOxCtZeSjiswuYuCqBfiIC0ci5WFhCpb90Ty3i6S+2muluJq549lD7+CXdH4XdMV886KUwwycYM5eDv7xQq3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-OriginatorOrg: intel.com

Hi Shuah Khan,

Just a gentle ping regarding this patch.=20
If you have any questions, please feel free to let me know.=20

Thanks!=20
-Qiuxu

> From: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> [...]
> Subject: [PATCH 1/1] selftests/mincore: Allow read-ahead pages to reach t=
he
> end of the file
>=20
> When running the mincore_selftest on a system with an XFS file system, it
> failed the "check_file_mmap" test case due to the read-ahead pages reachi=
ng
> the end of the file. The failure log is as below:
>=20
>    RUN           global.check_file_mmap ...
>   mincore_selftest.c:264:check_file_mmap:Expected i (1024) < vec_size (10=
24)
>   mincore_selftest.c:265:check_file_mmap:Read-ahead pages reached the
> end of the file
>   check_file_mmap: Test failed
>            FAIL  global.check_file_mmap
>=20
> This is because the read-ahead window size of the XFS file system on this
> machine is 4 MB, which is larger than the size from the #PF address to th=
e end
> of the file. As a result, all the pages for this file are populated.
>=20
>   blockdev --getra /dev/nvme0n1p5
>     8192
>   blockdev --getbsz /dev/nvme0n1p5
>     512
>=20
> This issue can be fixed by extending the current FILE_SIZE 4MB to a large=
r
> number, but it will still fail if the read-ahead window size of the file =
system is
> larger enough. Additionally, in the real world, read-ahead pages reaching=
 the
> end of the file can happen and is an expected behavior.
> Therefore, allowing read-ahead pages to reach the end of the file is a be=
tter
> choice for the "check_file_mmap" test case.
>=20
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/mincore/mincore_selftest.c
> b/tools/testing/selftests/mincore/mincore_selftest.c
> index e949a43a6145..efabfcbe0b49 100644
> --- a/tools/testing/selftests/mincore/mincore_selftest.c
> +++ b/tools/testing/selftests/mincore/mincore_selftest.c
> @@ -261,9 +261,6 @@ TEST(check_file_mmap)
>  		TH_LOG("No read-ahead pages found in memory");
>  	}
>=20
> -	EXPECT_LT(i, vec_size) {
> -		TH_LOG("Read-ahead pages reached the end of the file");
> -	}
>  	/*
>  	 * End of the readahead window. The rest of the pages shouldn't
>  	 * be in memory.


