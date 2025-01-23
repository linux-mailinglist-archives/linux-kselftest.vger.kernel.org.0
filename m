Return-Path: <linux-kselftest+bounces-25021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461BFA1A7FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 17:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07259188B5E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF52135B7;
	Thu, 23 Jan 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJkGRpmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742F17BA5;
	Thu, 23 Jan 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650475; cv=fail; b=HGA2d+Zpvk0afkihLDlTsblMtvQEU3vZ4rvck3BWfXGL9cjJkr5jMY7UOVV0m/pXC/Q4yh4GJmxj8uDJ1kBpEoZpfUJ/E6gAeIK21knVXupxMPfeGG4jqPhMNup5ZsdWznv783Yf6M0EMIq/KuuPqu6RT3K58816TEC1qUhuqCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650475; c=relaxed/simple;
	bh=cppfD8LYJ8+RDMdrTdPCb4Tz93zM5wZs+tqbp9zqyTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YV/ijLc4esNtNuHyXOa8U642P50bzdlah/XIifOBIyVF5jPVHCD7sTr9CmZ16/ygFGvYFS7kyhQB4rbF9HHOkPgJciqxElRUqHc/g4Hza9SkSktLGamqf/6KMMe0sdN9qpTWae4DCW47RY4icoYnosh/kNAoH7azaQoYjYLvXyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJkGRpmW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737650473; x=1769186473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cppfD8LYJ8+RDMdrTdPCb4Tz93zM5wZs+tqbp9zqyTg=;
  b=UJkGRpmWrtTTVAy08FfV3Mm4cZUs64+W4UeYLRraDHrSDztMbYukvM9H
   ciTjrzkP7VXLQ38psRGoYkFlm3PhuPKIbb7g7cQBx0XwU/4y3F6w6/gti
   fF8sJnwJBt0F1lTggeSFG0heZrsfMFciXYNC/8uYhVDAC6qvnafAb/HCh
   mKTnNktGUIE1fcJd+k8sZkon6qOdAv57Reapa0OpNtVlC+J2ZXU8TAXWc
   MDByXBBttQ7qYaEHPliKic+/YtWOlpCAp27I7MgffOJF8aNj7GVPsYtlV
   kwlU+19SZ7qAfdYXLEU9EerP9loV3qyQJS3Qhe5sg3ECK0ZekdKjYCBBn
   A==;
X-CSE-ConnectionGUID: ybcH2lB6T1eUsrj0ua6pkA==
X-CSE-MsgGUID: a+B/+E8SSLqgOIVgy4vlZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="55576254"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="55576254"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:41:11 -0800
X-CSE-ConnectionGUID: bZWx12lcQfik4AsBvx+xQQ==
X-CSE-MsgGUID: vXqsIPJxTNauTQ+K1Pw5Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107631946"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 08:41:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 08:41:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 08:41:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 08:41:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1zdCylRL29+2AFCENJENUiCNnSrzFWUg4oEGQkMRIZ5xXfJRnThIKnIxEiCnhV8AkHq6aGiLLS6lleX7sI5aEYCb1dIydoUIeX3JQM6ffCr+WhLE3KLmKAZtjcWc3oDGfmBQjnct0JCXbXoRpZkYmsczy1Ihtplm+FJGSpPEHbvIsuoMxruExCl2Qx0ZhvfUMnltQ1kxOAQe9co6s79xxYa3aN6eNXm8a1bm5ASnPXV85k1GiFui56AhrUfZqxg29vgSq9+Bw1Uyd/IYVl7nQ5x+OOlcExm4DMaTaY0zev7n91GjXTO9ix/GfqHr0ybRQR9PyPz3wYRs2ohc3KbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvCB211DSi8toJrUvWNjgaCiJ5NtA3KfshnDE/LSXyc=;
 b=ImPXjFv/t4LhHymJw7by+nUMBCZQ0OkX5gahIJNkS8ZjWnkKTyDhLKXcaxFm0FmGs4xOll2ueDurPjzoIUW5khjKwMRhlf1LWVCcLF3f9SuZPkSuwyYZlzfFLjEXjLdQwgWePOnFAuAx3wDbgbJHvt9AmjoSyiqcis1RpaFbWgfnGunbN1Dfrz4POjAnDuF+iWO/KPG1zNzTUSg8L/hCReig8YFJVFHfuhUO3ZCbBsRjyegVILF8BtX9bmQ8wtkJNkyxwY47C4pTs4v0FTR4VIqPTlYIm9M9Hi5zMXpsu4Duzx6vV85bs60VjL4K3Y7PK0Mn7iMAJ0+6p04LtIRy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 16:41:04 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 16:41:04 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Bouska, Zdenek" <zdenek.bouska@siemens.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato, Joe"
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, "Jose
 Abreu" <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v6 4/4] igc: Add launch time support to XDP ZC
Thread-Topic: [PATCH bpf-next v6 4/4] igc: Add launch time support to XDP ZC
Thread-Index: AQHbaC8B2aD+Y8oJSU6tHVAr+g1K37MkidWAgAAKZBA=
Date: Thu, 23 Jan 2025 16:41:03 +0000
Message-ID: <PH0PR11MB583095A2F12DA10D57781D18D8E02@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-5-yoong.siang.song@intel.com>
 <AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=5346f792-2728-437a-af4f-d8df71fd3714;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-01-23T15:32:06Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|MW3PR11MB4714:EE_
x-ms-office365-filtering-correlation-id: 51d8393d-a787-4f87-19d8-08dd3bccba37
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HaJUVV1/yEsqMHDAfZDyORkZve+F+SBhAZWthwAVgNmxYllJ+G6eeZihVyF6?=
 =?us-ascii?Q?AaTWBcemyfb+OdJajnJlq1TwI3DnagPVy0Mexd6ZkYeGf/Ku99z/4yaPWmBJ?=
 =?us-ascii?Q?aq2RhODldqPkoCtCccLjJAyjkF94pLgMtIKEZ58fq0W2GyzGUJNysh+ugoiN?=
 =?us-ascii?Q?7esIrmUw4DI9XqGL5cnaX3m+a/F534/JoLCH19OI6O121Plkuh/ks1/r+sSU?=
 =?us-ascii?Q?+h6PIEZEIBTnHHpbyVWaGWMLgUVDXvwFushrZZeSg0Sr1F9Lg2w/qhuMOtz3?=
 =?us-ascii?Q?R9vwUVeFAi8JQC6DRqd153YaYYMJiErWMB/yoC0qcTCwKSGopFtlqZKFl3un?=
 =?us-ascii?Q?AgvKcJak/sTKY+h25nn02hYEAZTibHfRMJgtrDim4LCaSAxGjDl4qt7L0Z2C?=
 =?us-ascii?Q?YzCEUiGwhsf2PGUwIoUN8aqmpEOfBm5ZDUwJSEHYBEK1t7ORGd4PdddX1v92?=
 =?us-ascii?Q?k8NS7AIlC9A2AZNOMznvq01yXOJcRONUl00Ad38AqIvabwfyRuDohxKyW8YI?=
 =?us-ascii?Q?j+gINxuo89HPDr0vGg5V4G79dWxaL9B+UiE4ApJJEdvvJUlzLP9Nk4E09ezl?=
 =?us-ascii?Q?YnGpkueh2Ga4etKWkJxSooNbbPruwg3ddQW3lP65AN6wHxVyOAwmQZxoiZuQ?=
 =?us-ascii?Q?BKAkYxq+biTf2GHfnpNh8/EBirh40mq+a6nYYNIj4voDcDi7Ankx7Um7ZMnx?=
 =?us-ascii?Q?xyqL6cImVEIlAcshIyWPQbhtJ33Add/HaE2ko8JgmCP2iwchbA74x0Dg6qu1?=
 =?us-ascii?Q?sxYm6AiFiITyLxydN14jmEzsk3ah66gFtau5Wn5uVBeW0KjmmkqniN+fA1oE?=
 =?us-ascii?Q?1DgtlRJFb+mpsVZ4x/jokNj+X+gxu/ksO0k2P+F9QRKMrC/SVu86VJ/rpw7i?=
 =?us-ascii?Q?hIJP1oNSc71RSYCzDfnABoNAkQmeFAHNljUhQKzEZdhaEqhLyGbG4JhiYWfl?=
 =?us-ascii?Q?MwACHKHWoyFNbLsK85Njq+3PQkWK4frTffdPNS2ouPt7+coP8rCVoYnGsa/n?=
 =?us-ascii?Q?po0TRdZpR1RFRWk4BuzGfF+4wGzIVllndHDKdzn01ZUaAJdtreH3jowPOQTC?=
 =?us-ascii?Q?8PtvxEes/oL1GvqxF4U9YvGpPocnPNATzNmwhJUwxZPwJj68rwhFE2F7b5HY?=
 =?us-ascii?Q?3FMjSaSzcIapu/NuGFHBrfIry2xwB58dXnzwHPaYygw+MMN/0GYbWfnWwlt5?=
 =?us-ascii?Q?+Y3kY/q33cpamxVQMEo5MzmlaERqnY1SLSrI+DU1FEedB6cbgkkWYU7L9ks2?=
 =?us-ascii?Q?OAWIWm38bZSmpAujhhRsMLgpaV7NzQRXo2Fa3aoOIEiNTxymTVGuMMMshOCa?=
 =?us-ascii?Q?ill4nd9J0cTxWXh4gfkZRCvenN04rNJBL5QBbPEDviknfkGlbcTgIwJbowMr?=
 =?us-ascii?Q?+RqVlOFO1DoLKK0/OSJiEIH6UrGdsU4cKJlt6tlvV8E07mey23/1apPb1lby?=
 =?us-ascii?Q?kEfkqGKjqEU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q6c2Al7pY0dLeJd8oxzU3Yi9y6X66V/YYrKhs+STyFBETAsqFnPj8qNB6Pwg?=
 =?us-ascii?Q?6ksAzkWGw19IbhrZtgPwPUkg2mK+DPt1azxJ55M5fx2ACDM5VqCYKdZFoEfs?=
 =?us-ascii?Q?zqN2a6AN3C3eU0l427zK6WN78X98j0D6XOnTrpgSCOCgKj/Y3tmI69hCmWbl?=
 =?us-ascii?Q?v0mzk4PZvOm+zfnBFZS58VP3Q55AtwXqRQITDpKKe2hvPaVI0XmiIMqjbBo+?=
 =?us-ascii?Q?2P9y4/8MA+pfJvGvq0AhQm/Aiy+bPTwOIc4/T2Dh4pJURlb7J4p1ekJZQ5f2?=
 =?us-ascii?Q?aly87pGjMQ9uGNGOimt9OuWUHt5KVusM8wqIs0RCLmf4hpQQcvhdj9SgJazl?=
 =?us-ascii?Q?jB2Tf1pYMkzaOk72SAgHLiuARYobGww6KrZOdzr6JeeeU6Bkbe1WCAx62nkt?=
 =?us-ascii?Q?l7FABjWDGgNheHJrRt9iBQsciBOM8APbzwUrKpqeKJp3nt5fYs8K/yzGdeYW?=
 =?us-ascii?Q?ZO3Xz2nsHv6n1TkvNcXOKBrPActKX1dmfinb3tDRTR6S3iatL6Z2pVfom1I3?=
 =?us-ascii?Q?mxjRT73IeQetYVZBTykiweIJYckYUrV9LzrH0T9QXXsXHnlUw8qlMyAee81b?=
 =?us-ascii?Q?6fopCCebuDx1Qj3DYVnuWgAwBJueZEAowKdVyj8wwt+xdjQ61LhTqw7hsbdP?=
 =?us-ascii?Q?nEc1TBnNeL1781KFOlrd9KplQuHHYU+a1Qrhlh9iY3KIybVrSAKm7GhJpF90?=
 =?us-ascii?Q?1O5eWaA3DJxZkU6j07Bzvc1uvXjOSLlrdBwuXts7NaupbKl6qbeqb3KGfWM9?=
 =?us-ascii?Q?kgdg3Me+Ibnlj0Gt5hxJK9psZ2rxrbwwkRE4p7yMmvEEmmzLzxR3vcT7XXYy?=
 =?us-ascii?Q?qozIO6sTlIDX8kO9rR3ARFF9IsvPS23kp/3JlBt6yxfT0Qlro/ycXq+dFtZR?=
 =?us-ascii?Q?ikzPmefmDGCIodwKzPcLCV9wmL9vG9Yp6mbDlbhROqx4isFiCv6TzIIKm60L?=
 =?us-ascii?Q?Fo2XaAttcu9/8o3np9wrTV6kxtTLT+jKBnDAIY37EFqbOMYU4pKWS9FkBZF+?=
 =?us-ascii?Q?lyUtbhG4ldVYGUUHXRyEwLRrE+k6QjcyBvcCg54Vn2fjV6/wSVTMpiFyCXkw?=
 =?us-ascii?Q?Wmc2s/+XF0Mmq+oHnfc6qDd/b40Mrxq0gtHsdaZFiPvsnifh05aTRdUJD+Gl?=
 =?us-ascii?Q?MmKcYcWnMWfNc1GVYD1bJ9Pa2+YFBUfyB90Ekc0GogoOAG83+mmsEL5HNzS5?=
 =?us-ascii?Q?wirTfWAS+4iaQL6fS0QGp+fPQyIAt3VMkUSBJ2siZ1bzpRAdWz+tHJscy+5e?=
 =?us-ascii?Q?FNW9fkE0xBd0w4FJnXdeTjieF0XkX00wrrsW63yHtRP/NRxuIoF0smg7AoEt?=
 =?us-ascii?Q?atIPYj2e12ycFE/SsCssTKhX95UlnPGTlB+9tmLnMTZ4adLDUt/FHubsyPIe?=
 =?us-ascii?Q?+mgMv3m6mZAbfrHe8oF0O2YxIQnWQ6vySrSMXE2UrFIOLHJHZ82CGurkfPul?=
 =?us-ascii?Q?+7/WUXlGeWrouzBv2MSPeK4wysIbLvQ1EqUglqcycsTWUp3oz1qN/ujFn3Z9?=
 =?us-ascii?Q?c1gt5SYtbKzZkbaHPX8uFb7fCSQcTdZ55JOBLHWvZ/MjueLcwx3qPU5CzWk/?=
 =?us-ascii?Q?cmqjfz0lRoVoWZdODhxy5MLCWvE+NGLdisVYqv30XuyUaSp3+3UtcvW/6Bq5?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d8393d-a787-4f87-19d8-08dd3bccba37
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 16:41:03.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hM1fNSix9Ka6dtJTW6DWyUPOb4L59Fml55ulO1RyqXMLgJaQVSO5sQIuBec/9Qg3ebHMWS14ZwVpTAYrANgDxBG2AK8ArHwZUxWYbSpPIlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com

On Thursday, January 23, 2025 11:40 PM, Bouska, Zdenek <zdenek.bouska@sieme=
ns.com> wrote:
>
>Hi Siang,
>
>I tested this patch series on 6.13 with Intel I226-LM (rev 04).
>
>I also applied patch "selftests/bpf: Actuate tx_metadata_len in xdp_hw_met=
adata" [1]
>and "selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata" [2] so that TX =
timestamps
>work.
>
>HW RX-timestamp was small (0.5956 instead of 1737373125.5956):
>
>HW RX-time:   595572448 (sec:0.5956) delta to User RX-time sec:1737373124.=
9873 (1737373124987318.750 usec)
>XDP RX-time:   1737373125582798388 (sec:1737373125.5828) delta to User RX-=
time sec:0.0001 (92.733 usec)
>
>Igc's raw HW RX-timestamp in front of frame data was overwritten by BPF pr=
ogram on
>line 90 in tools/testing/selftests/bpf: meta->hint_valid =3D 0;
>
>"HW timestamp has been copied into local variable" comment is outdated on
>line 2813 in drivers/net/ethernet/intel/igc/igc_main.c after
>commit 069b142f5819 igc: Add support for PTP .getcyclesx64() [3].
>
>Workaround is to add unused data to xdp_meta struct:
>
>--- a/tools/testing/selftests/bpf/xdp_metadata.h
>+++ b/tools/testing/selftests/bpf/xdp_metadata.h
>@@ -49,4 +49,5 @@ struct xdp_meta {
>                __s32 rx_vlan_tag_err;
>        };
>        enum xdp_meta_field hint_valid;
>+       __u8 avoid_IGC_TS_HDR_LEN[16];
> };
>

Hi Zdenek Bouska,=20

Thanks for your help on testing this patch set.
You are right, there is some issue with the Rx hw timestamp,
I will submit the bug fix patch when the solution is finalized,
but the fix will not be part of this launch time patch set.
Until then, you can continue to use your WA.

>But Launch time still does not work:
>
>HW Launch-time:   1737374407515922696 (sec:1737374407.5159) delta to HW TX=
-complete-time sec:-0.9999 (-999923.649 usec)
>
>Command "sudo ethtool -X enp1s0 start 1 equal 1" was in v4 [4] but is not =
in v6.
>Was that intentional? After executing it Launch time feature works:

This ethtool command is to use RSS method to route the incoming packet
to the queue which has launch time enabled. However, not every device suppo=
rt
RSS. So I move to use a more generic method, which is vlan priority method,
to route the incoming packet. Therefore, you need to send an
UDP packet with VLAN priority 1 to port 9091 of DUT.

Below is example of my python script to generate the vlan UDP packet.
You can have a quick try on it.

from scapy.all import *
from scapy.all import Ether, Dot1Q, IP, UDP
packet =3D Ether(src=3D"44:ab:bc:bb:21:44", dst=3D"22:ab:bc:bb:12:34") / Do=
t1Q(vlan=3D100, prio=3D1) / IP(src=3D"169.254.1.2", dst=3D"169.254.1.1") / =
UDP(dport=3D9091)
sendp(packet, iface=3D"enp1s0")

Thanks & Regards
Siang

>
>HW Launch-time:   1737374618088557111 (sec:1737374618.0886) delta to HW TX=
-complete-time sec:0.0000 (0.012 usec)
>
>Thank you for XDP launch time support!
>
>[1] https://lore.kernel.org/linux-kernel/20241205044258.3155799-1-
>yoong.siang.song@intel.com/
>[2] https://lore.kernel.org/linux-kernel/20241205051936.3156307-1-
>yoong.siang.song@intel.com/
>[3]
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D069
>b142f58196bd9f47b35e493255741e2c663c7
>[4] https://lore.kernel.org/linux-kernel/20250106135724.9749-1-
>yoong.siang.song@intel.com/
>
>Best regards,
>Zdenek Bouska
>
>--
>Siemens, s.r.o
>Foundational Technologies
>

