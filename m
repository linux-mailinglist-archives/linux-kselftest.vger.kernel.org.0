Return-Path: <linux-kselftest+bounces-36492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB6AF84DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 02:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD863AC1C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B18F6F;
	Fri,  4 Jul 2025 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZ8KtGcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB84F9EC;
	Fri,  4 Jul 2025 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589208; cv=fail; b=qjpHF9bXLsBRXDPls0UnHX/H3TZoRGxsumF+aYF4pdCLoNaWeF6AH8oApC81xdDyKOT03taHVPjuIE3ZtSkzwM3zhl1ncNYYngYkcxlQMkYDvYwkrRHKaQ6MJgPlE0UOs9xFSJRQHtOUqpEXS93jgAjSBlXKGKSiM+P2qiJYqKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589208; c=relaxed/simple;
	bh=qhNA2A+3lrdRtL7DsgaWuncv9ATDgZszsNe3AitgUcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIIuysYtVqUOCVLmKASTfV26j4dc0JXtbmzE50ytqgO7Lp5MjVOC5tUw4p2YU65U+tHd/bT6o2vEJgomMGT4u4fmREcmF588kTYYwDtDVZGhWZT/fVdczL2LRp6VECCY+qX1yptfAWajLxAMmpFwh4wmHptef8Fo4uWP+yZ4+OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZ8KtGcg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751589206; x=1783125206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qhNA2A+3lrdRtL7DsgaWuncv9ATDgZszsNe3AitgUcg=;
  b=EZ8KtGcgyA/718CPj8sTHYcGOsXtFf20hyvhmNXP2/uUqV3q+ZKQBc6F
   4l1ebSPErUtU0wrO/XiA1k2yAnJn8PQNlAYLG+6LFnzZjmZ1VrC3dR+4/
   v+BqcgR/AgrKN0cLP9KbhC4nnSEvBAUyQqvvGq9DIvXOrMN+xPPeXIU1X
   P1YQH4L8qhf0I9WMSOuYF0X6b6vv2pOBPppup3ve8uhSheM72d3QNpAao
   OanS5QmU906XHoKuJi1ErfmxjoCzMDvH8nH9bYdfdAvwwzbGA8Hn2l1/4
   onVuQD/lQuqI0VQALsSQyvxbF6WWJ84h3O9Bs75Lws+cMVxfneBgVpSbz
   w==;
X-CSE-ConnectionGUID: bCjte9JsSeieUWELvPgVcw==
X-CSE-MsgGUID: RJ2zkA/cSwqBX5RNEqSmfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64173758"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="64173758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 17:33:25 -0700
X-CSE-ConnectionGUID: b/mdZz0tT+u4fiZQRPw57g==
X-CSE-MsgGUID: NXbKmTguSA2kq05VsyUZGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="160025792"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 17:33:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 17:33:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 17:33:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.72) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 17:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRHrC6tAXr9/8yDzy2RHMatsiqrizR02svMIMdOTXQnIjzhOhKFj1XY2SvNi/Of3j99slb8Uu2BAGNBWYcwrNEvGV9cJ+tJKyoavWqa+aDBt/pCD8fDUqPPjnHhxjlst4yQ4kIvis1d2V2YtXxk5q6EinmnfGBoGv2IcqNQdTCiKF9tl/4vY9krvF6QDulAsjvKH/qnA/MiSYQjImRb7eJ9M7iqW2fz0iTYCQ6tQyTXo1GF6WWhHBulZYlQzz2vPPMASazk6nNexZ58DAnxLHUUYCD85v761moeXQOtluxiWc/bhd1WIUmZKAPP7WestdWoFng0J+TqDHU1wfsB0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhNA2A+3lrdRtL7DsgaWuncv9ATDgZszsNe3AitgUcg=;
 b=UqtcIlwlgimFAkFtc1TLl1Hspj/ojgp8SS9FW6t6xDQ4xcfXSLkFTQ6UJn4dL+8PcgUohwxhCGyLR3CPTFmfyK0Qj/FY+KzImUAUXlTYhtZScnduKQJg1dFXMcZ8TZv58YzpkVZKvLXO1UFXIP6+YmaNC0A1Nht6iMitzWtg2OpNvLEtzZOa27eBOX1FBSMNFhvsTwaYYIEKfnfSqJeBiBcgvAwzGGCowzpjhvhL7ZEk6C5X+q75fYWCJAw27xFN610ryFefk8CUEgti/09mF//YyHKh6FMK/W9BtDaNW8guL9z4ZQpjuYdaRLqg6ITsJJkFMDgTlNchkgYBpAfbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 00:33:21 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8857.016; Fri, 4 Jul 2025
 00:33:21 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next,v3 1/2] doc: enhance explanation of XDP Rx
 metadata layout and METADATA_SIZE
Thread-Topic: [PATCH bpf-next,v3 1/2] doc: enhance explanation of XDP Rx
 metadata layout and METADATA_SIZE
Thread-Index: AQHb63KtmVqcRniHE0SYkKXjYTh6CbQgj3kAgACKtnA=
Date: Fri, 4 Jul 2025 00:33:21 +0000
Message-ID: <IA3PR11MB9254E3549D984FFB1305C01DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-2-yoong.siang.song@intel.com>
 <6d147702-d9be-458a-b79c-9b4269817d43@iogearbox.net>
In-Reply-To: <6d147702-d9be-458a-b79c-9b4269817d43@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|BL1PR11MB5320:EE_
x-ms-office365-filtering-correlation-id: 9af1d271-b005-44d3-cd1b-08ddba926154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?UGUrY0RFdlhPcUIzazJQdEFSdWNLSllOUWt1TjR5NDJDSXlKYzBWemdkRFZr?=
 =?utf-8?B?azZHczFxYTZtUEVDa1dkYUcycTMvd1ZGUnhuZ0hrTDZISDJTZ08wNGxXc2sw?=
 =?utf-8?B?QUZPd1lLRzUzdFRzalVqS0QwRmdWTTJPaDVucGFTcnJyYzhORFpUZjV6S21q?=
 =?utf-8?B?TDBYS3NaR2h5VUVua2RSMkhraWRxRFVka1BCZFVMbFZYNUFDNlA3dVhjRXFm?=
 =?utf-8?B?UVRwVmJqRm9YYWJDS0xOUDFFaFhkMUN3ckwyYU9IMWZmYlFnb2NZanhBZzdi?=
 =?utf-8?B?RklNdGJNYVErUDAxdmd2UTRzbzJDZzFwME1yL2I3bDdjM1NURlF1YWVyeVRv?=
 =?utf-8?B?MnB6MDFPckRYT3hsM2VrcDE0aERxc0JNUVFqakpYU2tZV3NLd2JVcEEwcHox?=
 =?utf-8?B?N1pRelhiMGtoa1JBaitsZjhkek43M2JqREhMRllXbHpubkJFYnNsa0JXVUxK?=
 =?utf-8?B?cVl2WXRYbjN1TjlOZkZYd2wxc1lkY3pUQ3JuQm9LbEJwWG1iQUhYWFU0VFJ1?=
 =?utf-8?B?MUJpL2NDbTZMaU45dnpvV0dlODdJMUhUMU5scjU4ZWZLZnE0MlluRzYvbkJm?=
 =?utf-8?B?RVVJL0tHREs4UmJJc3hBZjc1OTJtVE00R2Y1SHdCOXVubTUvems0ZFk4SFNk?=
 =?utf-8?B?YWsrN3dBM3NFNW9UQUhNSDF2WHppYmFrbEtyUVduOHl1RUV5c2tDcUdUMDdQ?=
 =?utf-8?B?dndONGxJTWR4UERIYUdzWGwvU1h4bVgrU1JkY1Z0Snc3UmRTSkNzaFpLTzlk?=
 =?utf-8?B?ckhFd0tTTEkzN2JVY1ZLQkhXS0JxRkI4M1lJbVVsOFo0eG5JelJlSVBDVHRU?=
 =?utf-8?B?RnR2MTdEVmpuVVZDclRCYVhpNy91Nkg2QTR6NkMwQU5WYkpNaEpNMGFwVElm?=
 =?utf-8?B?TG1YVEtoU0YzbHQ0ZXZTc3VNdDFGWUl6OHpNV3hnVml3MmxLaHpuZ3VtTThT?=
 =?utf-8?B?NDM2QWtxWjIxYmNWazRtSHU1ZGZpb0pRWWNXUVhadkFnYlhSNW90VVBKRVQ5?=
 =?utf-8?B?aVRlc2RIaFpBdFpXeTRROHpKMEVWcjBJRFJ2RW8xMFM2aGhON3drcGdNSE9P?=
 =?utf-8?B?MjZlWlMyYzNpSmJFajdwQlFpWGNYZytCRmV1S3llQURVUW9MZ0IxbVk3NmVV?=
 =?utf-8?B?NHJQVmdiUlVFdW5wZUJQc2pxaHZlUTkrWk1UdjJhZDVqL0NYUHc5OUQ1U0ZI?=
 =?utf-8?B?L1BWd0RxUXBPTGZmVE0rTEMxcG4wSkpaV29RUGxaL0FaeS9wUUUrZEtIdFVh?=
 =?utf-8?B?VjJvSWlhTlJUU2FzcjIyWkZkNFdsWVBnT2h6M0gzUXZkcDBvY09BcXVJM1Z3?=
 =?utf-8?B?bEFDMWVGNnc1YURGVkZkMC8ybFhRcDVYZFVLNy9UQTFncDBxUzNMZ2hxa0J4?=
 =?utf-8?B?YU5HMFBQUStEQ2d2VG1NZFV3N3NqRjBQT1FvKy9CUDBSVGd3dE1Dd0N0a1px?=
 =?utf-8?B?YVRzT1Bvb3BoRFdnQ29WN1NxMUo5OUFQY1J5WkdDTTdrem12WWR5eEZaMlhX?=
 =?utf-8?B?ZGNEdDVzakI5UFRQN0V4Rm9kZnlRWXFRdVFDcFpQZzB3YllJMUk2RE9OdjNI?=
 =?utf-8?B?R0dyVnpIYW1uYmZqVTVWSFF1VXZyTk5zOVA5bmNDQ2pSdkVpU3NJMjZvcjRY?=
 =?utf-8?B?MlJJbEFFZWR2eVBBbTI2eTZDU09QTFByZ3JlaFNyOXhuMDdWM2x1MkJUdlJx?=
 =?utf-8?B?VE9PdmZtUmlydHcwdGYwL3hMM2hnY0dISXFiWk9QVjFuZXYzRmtIUXk3cm9v?=
 =?utf-8?B?RnRIR3ZTa0plb2xJdlpTVlNHUnFMSnJscjg5dDFMMlZHM2ZTbWVWcmNjUVg2?=
 =?utf-8?B?MVI2WW9FemkySE04Vm14ZmU0a1JIMHNtZnI2Wm5YcDB0d0w5ZE85YlN0Y0lw?=
 =?utf-8?B?Z1dRNjUrSFovaXlqYVVpN05xeE5pdVc5QzNmZysrcGpwUGM2bUJ6eGhaTDhV?=
 =?utf-8?B?cFdtNzBkQnhMQmJNVXJiS0U5MzM0TkFJRDBUdUVGb3FFUzJMSHZUMW1jL29C?=
 =?utf-8?B?RUVFTWkxdkducmliUUExait0N1MvSVVUZHN2YnpvREdtUHhyNm9jbHhSZVgw?=
 =?utf-8?Q?bweP/1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUVPb1FMTitneXRScGRJNUJIbi9nT083NnUrUW5YTU9XYTR5UVZIdUVUQTVj?=
 =?utf-8?B?aVdnVSs1eUJZRmExZU5IajYrUGlQS1JubFRrSXFkUFBXUklaZytqeGo1QVNB?=
 =?utf-8?B?dFl0MGkza0trQjFYZEJHbHJDdjJ6T28zeXF6Tng2RGNTTEhSTGhZZjFlVjdO?=
 =?utf-8?B?ZHZhMjBxcEFSU3YvRFdkMkd5OENxY3lCZi9iLy93TmZ1SFEwTUdlTk1kK1l4?=
 =?utf-8?B?SnQvOWNwWlIvbGNoLzBjS3dlT3hQTWZpZWRzUmQxKzRlbkRUSUtHRXVEMnRB?=
 =?utf-8?B?OVd5b2V4VkRaTDVqQVhGcWJTcDR3d0hOMWJCajM5VlZqUFJTTFdmUWRDOXN3?=
 =?utf-8?B?WVRnTXFyYWdIK3NTWXVpMmpuWXlJS3ZyS2ZNTlliUm1LaGtyNmp4YjZUR0ZS?=
 =?utf-8?B?RE04N0U4UGVtWlZvdlZFRkFuQS9yVTI2SzV1Zm9JWXcyZnlZclFmYUlrR1d0?=
 =?utf-8?B?RFFJZ2Y5VUZOQ1hQdXFMTmU4TGJ0QVZKNlQxTmxzUmZiSzM3NVlOZ0pXckpa?=
 =?utf-8?B?MWROT0NwdlRDaFdIZ0VMaFVVMWJJeDdmdktwTkxJRktTSEJqWkVsb2hrVWNM?=
 =?utf-8?B?NytZU2djRW5TUVdsaTA1WUcvMjF3YzJMeU84bUJ2Z2wwTDhGOVVnT1M1bkVa?=
 =?utf-8?B?UFdVVVJ5NkRXMm42Ky9DTWhVa0Q5bFUvaWVma2lFdEVKRmJJSE1DUHZTekI1?=
 =?utf-8?B?V3BuU21hZEVQL21qcmwwak9CMFQ3ODh5cUNsODlmTG1aNGRhUVdUejFhRnY1?=
 =?utf-8?B?UEpqTTZwd0xUMlhIZXZVV01Bd1ZxRVZKSHVhZnQxdk1BdXl0KzVaTEV5YUZM?=
 =?utf-8?B?R29OMFNxekNROXVxMk1uS2syNG5hUUFkNEdPMXZtZUkxNWhZYUZzdExsWGlZ?=
 =?utf-8?B?aEZjejI0TUlhZTMvelJNRG43anRBUlZ3bEswemJ6ZWRJQmMxQUwzY2NLb2dU?=
 =?utf-8?B?dlRpWUtFQXdKeUpid213a1hibzE5ZFpvMDFtSmxCcndORGk2dlFOSXVIZlNZ?=
 =?utf-8?B?RmNQdVhTOEdHTWFLRFJBK0FQQ2V2V2prVDJqcGoyZkx1UXd3NWMxelRNcEtF?=
 =?utf-8?B?b0pob3lTREdsaXF4ZkIweHo5TDF0czJRV3FlTmcrMHduc29CSXMyaUM2ai9T?=
 =?utf-8?B?SFJpWXhBN0xHMUdNRWFPSkt6Y2dmV2h0U0tuZGpQdDczK1BMVlk3ZXQ5ZEUy?=
 =?utf-8?B?RTRFR2RDZ05YN2xPc00reTBhUkwzRkVOYS9TZCtPUUFSWk5yQ0RvYWNNSmRl?=
 =?utf-8?B?VkNxRTZOZFg3REhzVWx6QzZMWldqSEtReEVFM1F5dGIxaHdyK1dDVU9ZWW5M?=
 =?utf-8?B?V3Vna25tVDFES1FtZDg2OWFzQ0FyZEhwWGFMdWp1SXFudnZoUW04Q1UyMVZW?=
 =?utf-8?B?TkVScDRkc0VVNFEwcGd6eVZwcTV5UHBKSGxJVk1GS1ArU3IvQkNJSmovUU42?=
 =?utf-8?B?a2lkWGZHeVFwbER5UDQreFpjRi9wTFFmSFpkYmMyOFcvWWh2bW0rSmJuT2FD?=
 =?utf-8?B?dG84aFNJRzBWSHNrd0NSNWtsdzJBaFFRWWhTQmtzeklCU1k3RkFHNXd0a0lY?=
 =?utf-8?B?VmhGMkwvQXJEUEhZb1c2WVk0WmRvV3hTMG9NMUZZLzk5d3paWlhMUFRSR1N3?=
 =?utf-8?B?NlNXTXhRZGROTFpsdklqQmZjY3BXT1p3V1hNR2J3U1RnVE95VFN2MjRGcE5y?=
 =?utf-8?B?amV5QU5wZkdZMWxsMjNWcHV3bXdDMWphQTAyNVUwek52a21MeVpQVURkZGJ5?=
 =?utf-8?B?Rk5TZTBnZlY3TFB3K3p0UHNjQU5BcHFDUThjQ3ROMWFjcXFxVXhnR0ZWVGt0?=
 =?utf-8?B?bTBYTGh5MTlhdUlkejFxSlRST1NLM1B0TTdtamY5bDl6bTMzdHNnWlA0RGlU?=
 =?utf-8?B?NnQ1QXpvYmF4YzkvU1k1S3AwZXF4YUJuL2FXdVZwb1dVNkIyT1QyWDZ4SzVr?=
 =?utf-8?B?aUFLMVZNM1psYWdJVlRieVpobUxtU3hueS9KNW1hWUdzNTZ2VUdTdlVrSDFI?=
 =?utf-8?B?ZGk3ckJKdXNYUHNpdlBRd2QrZm14cHpDWDV2SjBPbmZrWmZtUk9RQWswOEdp?=
 =?utf-8?B?RVpHQXNnell2WG5renI1b0tYTTJqa0xvMGp2RlhWR3JFRTNmQlBsRE1pTVBU?=
 =?utf-8?B?dGpUNWtRYXE5VHJ6am1rT2dHUWpkNHVoUmlKb0orNngrdEFTVFVZUUZhK2Yv?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af1d271-b005-44d3-cd1b-08ddba926154
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 00:33:21.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esYWvLsKv5ZsicQekvwmrnz22E0lBqxSzwx3+tGpSGMFsBn1S2KXsBJ0BTqrAWsM+3nayFQyVMU/YAdF1BZPyShXwFJCRiZ5VyZ4sMwEP7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-OriginatorOrg: intel.com

T24gVGh1cnNkYXksIEp1bHkgMywgMjAyNSAxMTo1OCBQTSwgRGFuaWVsIEJvcmttYW5uIDxkYW5p
ZWxAaW9nZWFyYm94Lm5ldD4gd3JvdGU6DQo+T24gNy8yLzI1IDY6NTcgUE0sIFNvbmcgWW9vbmcg
U2lhbmcgd3JvdGU6DQo+Wy4uLl0NCj4+ICtJdCBpcyBpbXBvcnRhbnQgdG8gbm90ZSB0aGF0IHNv
bWUgZGV2aWNlcyBtYXkgdXRpbGl6ZSB0aGUgYGBkYXRhX21ldGFgYCBhcmVhIGZvcg0KPj4gK3Ro
ZWlyIG93biBwdXJwb3Nlcy4gRm9yIGV4YW1wbGUsIHRoZSBJR0MgZGV2aWNlIHV0aWxpemVzIGBg
SUdDX1RTX0hEUl9MRU5gYA0KPj4gK2J5dGVzIG9mIHRoZSBgYGRhdGFfbWV0YWBgIGFyZWEgZm9y
IHJlY2VpdmluZyBoYXJkd2FyZSB0aW1lc3RhbXBzLiBUaGVyZWZvcmUsDQo+PiArdGhlIFhEUCBw
cm9ncmFtIHNob3VsZCBlbnN1cmUgdGhhdCBpdCBkb2VzIG5vdCBvdmVyd3JpdGUgYW55IGV4aXN0
aW5nIG1ldGFkYXRhLg0KPj4gK1RoZSBtZXRhZGF0YSBsYXlvdXQgb2Ygc3VjaCBkZXZpY2UgaXMg
ZGVwaWN0ZWQgYmVsb3c6Og0KPj4gKw0KPj4gKyAgKy0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tKw0KPj4gKyAgfCBoZWFkcm9vbSB8
IGN1c3RvbSBtZXRhZGF0YSB8IGRldmljZS1yZXNlcnZlZCBtZXRhZGF0YSB8IGRhdGEgfA0KPj4g
KyAgKy0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rLS0tLS0tKw0KPj4gKyAgICAgICAgICAgICBeICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeDQo+PiArICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICsgICB4ZHBfYnVmZi0+ZGF0YV9tZXRhICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgeGRwX2J1ZmYtPmRhdGENCj4NCj5JbWhvLCB0aGlz
IHNlY3Rpb24gaXMgbWlzbGVhZGluZyB0byBkZXZlbG9wZXJzLiBTdXBwb3NlIHlvdSdyZSBhIFhE
UCBwcm9ncmFtIHdyaXRlcg0KPmFuZCB5b3Ugd2FudCB0byBpbXBsZW1lbnQgYSBnZW5lcmljIG5h
dGl2ZSBCUEYgcHJvZ3JhbSAoaW5kZXBlbmRlbnQgb2YgdGhlIHVuZGVybHlpbmcNCj5OSUMpLiBE
b2VzIHRoaXMgbWVhbiwgdGhlIGV4cGVjdGF0aW9uIGlzIHRvIGRpZyBpbnRvIGRyaXZlciBjb2Rl
IHRvIGdhdGhlciB3aGV0aGVyDQo+b3Igbm90IGEgZHJpdmVyIGlzIHByZXBvcHVsYXRpbmcgYW5k
IGhvdyBtdWNoIG9mIGl0PyBXaGF0IGFyZSB0aGUgaW1wbGljYXRpb25zIGlmIHRoZQ0KPmRhdGEg
aXMgb3ZlcndyaXR0ZW4/IEZvciBleGFtcGxlLCBpbiBDaWxpdW0gdG9kYXkgd2UgdXNlIHRoZSBi
dWZmZXIgZGVzY3JpYmVkIGhlcmUNCj5hcyBkZXZpY2UtcmVzZXJ2ZWQgbWV0YWRhdGEgYW5kIG92
ZXJyaWRlIGl0LiBIb3cgd2lsbCB1c2VycyBrbm93IHdoYXQgYnJlYWtzPw0KDQpUaGFua3MgZm9y
IHlvdXIgaW5wdXQuDQoNCkEgZ2VuZXJpYyBYRFAgcHJvZ3JhbSBjYW4gYWx3YXlzIGNoZWNrIHRo
ZSBzaXplIG9mIGRldmljZS1yZXNlcnZlZCBtZXRhZGF0YSBieQ0KImN0eC0+ZGF0YSAtIGN0eC0+
ZGF0YV9tZXRhIiBhbmQgYXZvaWQgb3ZlcndyaXRlIGl0LCBhcyBzaG93biBpbiBjb2RlIGJlbG93
IGluIG15DQp2MSBzdWJtaXNzaW9uIFsxXS4gVGhpcyByZXF1aXJlcyBkcml2ZXIgdG8gZXhwb3Nl
IHRoZSBtZXRhZGF0YSBsZW5ndGggdXNlZCBbMl0uDQpIb3dldmVyLCBJIGRpbnQgaGF2ZSBnb29k
IGp1c3RpZmljYXRpb24gZm9yIG1ha2luZyB0aGUgbWV0YWRhdGEgbGVuZ3RoIHVzZXItdmlzaWJs
ZS4NClNvLCBJIHN1Ym1pdHRlZCB0aGlzIHYzIHRvIGtlZXAgaXQgc2ltcGxlLiBBbnkgdGhvdWdo
dHM/DQoNCisJbWV0YWxlbl91c2VkID0gY3R4LT5kYXRhIC0gY3R4LT5kYXRhX21ldGE7DQorCW1l
dGFsZW5fdG9fYWRqdXN0ID0gWERQX01FVEFEQVRBX1NJWkUgLSBtZXRhbGVuX3VzZWQ7DQorCWlm
IChtZXRhbGVuX3RvX2FkanVzdCA8IChpbnQpc2l6ZW9mKHN0cnVjdCB4ZHBfbWV0YSkpDQorCQly
ZXR1cm4gWERQX0RST1A7DQorDQorCXJldCA9IGJwZl94ZHBfYWRqdXN0X21ldGEoY3R4LCAtbWV0
YWxlbl90b19hZGp1c3QpOw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIw
MjUwNzAxMDQyOTQwLjMyNzIzMjUtMy15b29uZy5zaWFuZy5zb25nQGludGVsLmNvbS8NClsyXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTA3MDEwODA5NTUuMzI3MzEzNy0xLXlv
b25nLnNpYW5nLnNvbmdAaW50ZWwuY29tLw0K

