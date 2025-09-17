Return-Path: <linux-kselftest+bounces-41657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD429B7DBD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E198E1642D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 06:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDAB285042;
	Wed, 17 Sep 2025 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbMJ43UE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8F26657B;
	Wed, 17 Sep 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090925; cv=fail; b=jkpR2qThixcMZ6UAC/re/YWFNLdD0mU5+uth+ioPIGYLrEJC4/nTQUOnGjHkekFOg0wG9PpCh0tHnk8mgDPAmakr5yjIPV4HHMOCWdJ7zawW3yvBbhkVJj7XIlkz7nb8X330mFMU7b9JUFHUtPegDAWzcKOdNhmJH0ptR+SZR+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090925; c=relaxed/simple;
	bh=V264cfGZY+YmBkPbOzyg4VoZVXEZ9n7XD7BOwbc3H08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KkvHctezug+7Du4fT0j2zB3yDb2VJNhidSEaIy9aGQetWVvfmP74NLCDz7/9Svy5+QZycFPRx5+r73uBbpvg0JSPkdQNC8m3V9dMnJXi0A+LqX6qen2y0O88w5TioSmhK+jJ3dKMpx28Spbys0Ql6HIZz4i6FOaP++NaT4xNuXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbMJ43UE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758090923; x=1789626923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V264cfGZY+YmBkPbOzyg4VoZVXEZ9n7XD7BOwbc3H08=;
  b=BbMJ43UEbn7aMp6vDF7MAkCh9+c+ZN4Wn0QaDggSy9YZajNIS2eDSo3o
   GJjUhJAdpwYruHnSMb5HvXy2pMRCYeBBxSq8RHAraPwJ/PisI8ZGXt0No
   mzxdbLEoY8oMVdYAJq1Or0DVEFe8gRapxFrwtfJraqHclJrNuPlCZ3KF6
   if1tgyeqiXWudVDBFFWmCG1/jfxKgVP+Ona9QjzQAnLbNL4u6iNFOTabT
   1sMLmHEUsWHzqNGk7U/olQhyCrD4TQVWSELoXnFLp5KuWh3/BpNzlIrXK
   0k218t7QVXRGN6KMsK9blHKP8ZluREaqjJ0uI6e8olNiW0u8ZsF2gs13v
   w==;
X-CSE-ConnectionGUID: ICUztlKDRuWP1Hz0ciiA6Q==
X-CSE-MsgGUID: 672a773zREekyio2NEdJSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="63021042"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="63021042"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 23:35:22 -0700
X-CSE-ConnectionGUID: OLYoAEuJS5OVVB9NX9WZcg==
X-CSE-MsgGUID: QjZpTHkcRKOL/wBeVlohyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="198837035"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 23:35:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:35:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 23:35:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMQ/8aJRRcGNmrBvEbgypAjKADPsHyaudGOiRBPSWaDNzjP38A7WZc7mjJ00xek1Bw0P+nwNV17CtRDiJoGr7aN2iblVzuXDLbNSSICjuI0M4bSq2KDvI8qF0ds1YDS/bZ4280RqZC3mmO+BLHX0pR+gCAj9LKHVFfqlwk8hujv+/lAZBrOq0jHxaz3tYsFHWnvE0XI3CYY1f7mzxoRUPDjL1S8I57asBUP+ipiPyOnWthnv/DzUrIDl77jmLhHOZMhRfZ3gg3y80eGtdhuiXvmqT7JfpmZHil7kES+y5mBlk26sy4ckql8kWjgv/KuufuS6ZWJTRVYfGF2Hc7NZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7lhEpLPYz+n25GRsn4lx3JavF8+GDqNv1GH1BPtjYY=;
 b=gdMhAXo2LlAlbnythbO8YQP4/jItN9ksyqQHmWCM189NMtef1Mldn3IGFe7niAFRF4WU622Au3kMeYpszj1vUhFbi4+OD/d2z+/B5QYrsgGpEou26/O6Zj5ecsswkTNsqIHI3AFK/VCmlulASnbrTJDNm66NfU/4SBlixfvQo/mX5128lRbgnocdvupPjcxVWonI2rpY2JoaLhQGxYVpyfzJB3qvbyJl2tWjcAUNNhQuOygjHQG3K2uLoQZBd4RkWwJ5rEICDcW8P3LI5CJiyhtFdFaQQ97lwhpl9yZ6rvuywSYEnlXuRP3/nEAzsVNYUlgWpe+Cvx7yDgkKIQGoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9513.namprd11.prod.outlook.com (2603:10b6:408:2e4::13)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 06:35:14 +0000
Received: from LV4PR11MB9513.namprd11.prod.outlook.com
 ([fe80::4b22:5191:6146:5b5e]) by LV4PR11MB9513.namprd11.prod.outlook.com
 ([fe80::4b22:5191:6146:5b5e%6]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 06:35:14 +0000
From: "Fan, Shawn" <shawn.fan@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Meyer, Kyle" <kyle.meyer@hpe.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "david@redhat.com" <david@redhat.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jane.chu@oracle.com" <jane.chu@oracle.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "bp@alien8.de" <bp@alien8.de>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "jack@suse.cz" <jack@suse.cz>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "laoar.shao@gmail.com"
	<laoar.shao@gmail.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "mclapinski@google.com"
	<mclapinski@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "osalvador@suse.de"
	<osalvador@suse.de>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "Anderson, Russ"
	<russ.anderson@hpe.com>, "surenb@google.com" <surenb@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Thread-Topic: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Thread-Index: AQHcJqDeXhOP3dRkWEWcaj8hLYrfZbSVI0cAgABCfoCAAIfvgIAALFkAgAACgoCAAM9fAA==
Date: Wed, 17 Sep 2025 06:35:14 +0000
Message-ID: <LV4PR11MB9513A6EFA88B082E554CB8D6EB17A@LV4PR11MB9513.namprd11.prod.outlook.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
 <aMkOCmGBhZKhKPrI@hpe.com>
 <SJ1PR11MB60831F028E2FEB6B5A3390D9FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aMmlhPghbpnlCZ09@hpe.com>
 <SJ1PR11MB60833884799B6AA2BC18ECE7FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60833884799B6AA2BC18ECE7FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9513:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: b4b61311-7b0e-4ea2-e0fd-08ddf5b45c27
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?lmDjYsjwQT8X7/jc+AgbcslArs0VNkzY5n36O+X5I1I7xkGHeHQf4u5HCwEo?=
 =?us-ascii?Q?B3gZ6SPU8AnwdH08T/opdgsLFDCDbiRk6Mhrg4ISo/mWA46DKlHL1gsYdBTo?=
 =?us-ascii?Q?+gyzAYUTH9GV+tQvzDRhCQdXH/tMP7g4MrWzCJXKDukwEQMBefhjtlCSdY7R?=
 =?us-ascii?Q?0AQ4v+Sed4UKoAnX+aZznPLvTiWD+BY1SWbaTLK9Q6uv4eenf8CIV+Np9FMJ?=
 =?us-ascii?Q?j6WIDC9yaEkvHfGfr6bXCmx8FM0wJ4Otigy0XA3796Ig7XZcxQjoYYVGj/B6?=
 =?us-ascii?Q?U/nJgpspRS6GUm05m3LuW/C8/vN9EPGKKFn4gItjqf1ZLBgxoOwIDHQu76lF?=
 =?us-ascii?Q?rZ3aBsMgsDtVyfMxy0wBvNHtsalwMMfMbCckwH27TwXZ4KbRAqCfSUL3u6RA?=
 =?us-ascii?Q?5p5aVJ1GjKAwAqhD5rygRJkwx7k6yiXdngWNOeiFbrj8G3LK90j36TRTCDk9?=
 =?us-ascii?Q?R63qpX4IP8Tc/5PiBgfJxGcwzPRXsW7GR3IyUpl0eXWr6Rzg9/0JdKL1o6Cy?=
 =?us-ascii?Q?OrFyX7/tTWP0pukkAFZxuhjA/QP5SNFZSSq4zMEARvwpBe1xOxA5hQmeObS1?=
 =?us-ascii?Q?jLz/adkv9BKTX94MCIRz82PzexWmJZGis5PxxglGia8BB6FMH6zL+S+BGp4W?=
 =?us-ascii?Q?bM+6SMqfcwORziWFUfBJSl5gNVaEVUjkFnCWuQTOD/PEvz/Iwl3+6gXPtt81?=
 =?us-ascii?Q?uj8t3G3mtiwnlRZVOUdAZxCIrP0HgvHDKt7GqCJqM0FUQxnj0ajAbpjiOLE9?=
 =?us-ascii?Q?dQ4HnrFKJkrZp2MLCvzR6LFd6+8JdHRHR93r9gmUTc/5r55VVfRii1Lcaokc?=
 =?us-ascii?Q?1h4iFq8kzYXchw/SbZ3W3+35danhNWnoyKhqIxRqgCS+dav1dePu0gYZkJ/j?=
 =?us-ascii?Q?wRV8zHf0q4+/ScBbbIWVqX12b5TVgSk4+/4pcxGuXGb+FBAWybWr+aK1fR/S?=
 =?us-ascii?Q?EWp4Zt7/W6/SXvPt0AyzFh/OVdFPamIHf9btcxjuSG5z+EaP/v35gxvHjJ+J?=
 =?us-ascii?Q?g6HBhMPMwJEc/2xE7QE6BvCCyZ/Qb1dFPoOYZv1JdugljBXwBLAErGLpeQqO?=
 =?us-ascii?Q?wQEoRohVQ+WrFl/Fnufr2TlVvGsZK/RV1xkaQZcTE+DF8czRtsRdxkJyuDUB?=
 =?us-ascii?Q?UuJWhP8A6s1hXD1j9y/0HhChHADH/aUdnFdHfJGJs5SWK8akboUWBll+rqo5?=
 =?us-ascii?Q?CjC2vL/BRzInNtV0f4NeBa7bNcNtZIxWjmyxxCG5Z9CofzCaSpetJcs9VGsi?=
 =?us-ascii?Q?wm7FJ2ZBE8b04JWrH1dray49jof/PX2WpxX6hgCA9vj8sn20Hb2lRzMAotyB?=
 =?us-ascii?Q?yntqQMot0UK/oEfifYhpU+5ZpoEsXeG6+YvFxEWRRuvLZAuOrm9IVYWBQje8?=
 =?us-ascii?Q?fvw9fSvmOa21+V79LvI3oAD1jE5ffk4OUfoy1ZqUJK5PVHH6NrYTGXZlQSgY?=
 =?us-ascii?Q?Eb5UoILRKlBZroxBkayI31+XIdaQFPjsrOVEWbgHO1Z3/AgeEdPnIg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6xUny7isol70Kdz6hSSCc4EjaWImpOVXKUMs08/8ku8QBuYDy5RIWDNd4QA/?=
 =?us-ascii?Q?FJBItaHe8nBM7kqgbhzhVoe4mo6bweg6/V/pyEXFoRaxH6WwaFHiKd0PN6Hw?=
 =?us-ascii?Q?nCMSLBcNOilWDHgHVY2KJQEj7L1Nvl8VaSRc/G6cxmlpomFVGqoHE8SgYe7u?=
 =?us-ascii?Q?nRobYE4dLRiLbVTIVbHwuZ7RWrpPIfkFBZ/gVicj5Zsro2I1wvVwfkqY77B9?=
 =?us-ascii?Q?Iezt6Tmfk2hVhmR8wGu9fUgUI2Z2qBX6MAJx6WedsSIPLrFL1/H+PJaIiV1C?=
 =?us-ascii?Q?4Wv9rSWRAKd//rAxpJREAbbOCInQF0ik6k7QQdmx70cC8yfuwsPkhYembyRn?=
 =?us-ascii?Q?CkLFlir9tr05/EMC9UDihLa+AaZcD9ljxdqTErcKLGM99o1WUf9OA+WjS2rs?=
 =?us-ascii?Q?fI0DACfEDFRuMzUfBFQ3MHRs1A97f+gbjaF6mSxhFpuaxMeRBahK5iFPrby4?=
 =?us-ascii?Q?zDchpJeDGCh/vuTStsmDE6UdGNjkBRp8YrNOptk4YdAt8n2a+0b/SDysidpw?=
 =?us-ascii?Q?GUw8TDN8bXyV3wSvtk2CXsNvlz6YXeqtVVpOkB2fe692meu3/zPEHWNVIPAS?=
 =?us-ascii?Q?KaMj98ly5PiHPD4hsBPd4HNHK1IK6zMhQrl09aLAqfAe+fHVyI1UKVFhDXc3?=
 =?us-ascii?Q?tBfl1vgGA8EDQPTqaUUEe/4+HN8RExou86u6PlIVqo0K4sBnKKNT26ykwWQT?=
 =?us-ascii?Q?VGPaIVuYzSSf/zkpgTHnOMQTYr8L9n1Oy0ZzrAxsQHkx6in+6iareWG6gzvx?=
 =?us-ascii?Q?52BcI8+Xkp/KCVnuCV5H6CCQjhN4R+KH30TiHFzMpGwl8doYHm0R3HS6nzd6?=
 =?us-ascii?Q?Dus/SdmT9T8ZIXxTaLCv+PXhsor9zw1gkvmUpEKqZMebhcoWUKn3h01HP9W6?=
 =?us-ascii?Q?NH2AAUkWAXsT357DxOEBWSSdV1S+Ry5JDxV1jGkA8Pa/+lcqrXhODkZ3dcln?=
 =?us-ascii?Q?ZuLGzGAEz+v5FCne0XdBgUTgtlo44szSmMGyyYy6ttw+k7yPnvMNXO1oaM4X?=
 =?us-ascii?Q?kffnLaBmZw14XNPpWaNLmP85q41QtoJnfC6lW6YAktCutx4Z1S5qZTt25TRx?=
 =?us-ascii?Q?mVSOs5LdpL4rf/SuGIVolwNvJ7B0ZipK+xXIO2DcKa86Bb87iOyxNwCd8nbQ?=
 =?us-ascii?Q?9V00hiBB/Ki1YnInT6jJPPEL2vd5Mg80druz6J6pIiYMED6ziU49hGW99gV6?=
 =?us-ascii?Q?3/ksf895EtfC+kHkBhNr5QaY89uP1SeNUbKs8Ukauu/d/QwJthA8FMyk0ggi?=
 =?us-ascii?Q?J2iPKk4yE/ixcN38uiQ7baIR/4sR1oRQtydYnlYMnhXFwYxxwicsvWI5Ue44?=
 =?us-ascii?Q?0a7iTV4XccaiPfiqgLKtuL1Obh4VsCsHTQ7zHYOHQIL8JWvU09FX9CHuuSTl?=
 =?us-ascii?Q?4pUZWjHechK3pdZv2yfQhwsBZbGGiyjmp/WkpibLjj36Az80EnukPmZObdwq?=
 =?us-ascii?Q?UH5s2VGNcuYczY8ry1+tGghOqi2VeYgrRSF4lFvJuKf14VxtPbEQkTM6NEgW?=
 =?us-ascii?Q?v8aJ0QvDzOZZmDk1nygKVwfkizn7hGdTHR/2RB7MtJMZCHEMssJtg30aUrcH?=
 =?us-ascii?Q?EEXFMhagBuXUj96Z453MlvMmISkLC6t+F3/nf4fZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9513.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b61311-7b0e-4ea2-e0fd-08ddf5b45c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 06:35:14.4986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rOH1eAnuwlj+dwFVYpkpZDsIjR5ShHMhwanROKna/grBZAFXvNon5wGGIs1KbYequM+7RJ47SdIP2gA5cFksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com

>> My original patch for this just skipped the GHES->offline process
>> for huge pages. But I wasn't aware of the sysctl control. That provides
>> a better solution.
>
> Tony, does that mean you're OK with using the existing sysctl interface? =
If
> so, I'll just send a separate patch to update the sysfs-memory-page-offli=
ne
> documentation and drop the rest.

Kyle,

It depends on which camp the external customer that reported this
falls into:

1) "I'm OK disabling all soft offline requests".

or the:

2) "I'd like 4K pages to still go offline if the BIOS asks, just not any hu=
ge pages".

Shawn: Can you please find out?


-> Prefer the 2nd option,  "4K pages still go offline if the BIOS asks, jus=
t not any huge pages."


Shawn


