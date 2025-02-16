Return-Path: <linux-kselftest+bounces-26723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13EA371D2
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADFE3AF464
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CFCA6B;
	Sun, 16 Feb 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARbBsmuC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307433207;
	Sun, 16 Feb 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739672600; cv=fail; b=grdfY0c7UEDqkdz7y7i/PDVBqt8QM8A4pchEZxYa6YF/H9RVz5VUfJ2cKE/WBZ2y06ol0k7lJhYr99y18p5oMt0AehFIANE91FFw17F+ol1Biu+gcY+bscIHvCJvZheERwOLrK179Q2g0pUU41i6ppGYY8oh8KL2UfGSNoB9MxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739672600; c=relaxed/simple;
	bh=HhNbYOLmRmBiTQ7WOJN0lagcRecb8+INtDlB1mc3bzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ap7nYK1SQPM6HE/ifQ5l1nrRT67axcINwzOQsLHDrBtt6VnjJMfS0NPJLFfvVOHSqL7dVzG9+Kcfn1J48hOpEmW2OvWBzUq2EkFvTPVwegxR7tjKWBP092slr/P6cLYWtwQHl2arK0X5yxK88XbwKNsqgTfuBdJrPqjuQBs+lpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARbBsmuC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739672599; x=1771208599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HhNbYOLmRmBiTQ7WOJN0lagcRecb8+INtDlB1mc3bzM=;
  b=ARbBsmuC2+bAUUpsU+PDbgZb5RXjUpfeBuVmC0Cfj+bq++4/tTuTLT/Q
   f0LG/gX4yhM8lk+OiUKU7dwYx2ZhuDqe48leF78bxYn7OSvh+CQIF5e3c
   1SD1ZddP+k48XHPXfhnYvz3rLgTad4fdy0/AXVqEAn74Cd7lCPasTIn7y
   IoBQejRPvnrHteFl6rXMEBnYerhbuD9FDbyAzOOdaGF4dICYITQoi0VlP
   PR9RddFagvuUux12W2YCEqB4YFrkVnXYUcrodivO48QipellulNRVvVEv
   pmoRLPBsTDNpnQ2PPDwKtSXUgrfixcWekJUkZmP/6UbDq82JUM72fsLKL
   A==;
X-CSE-ConnectionGUID: bC+M7Z/eRG+EkiZBjTD0qQ==
X-CSE-MsgGUID: P/476CTBSFWxWP2JgetWRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="27984606"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="27984606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 18:23:17 -0800
X-CSE-ConnectionGUID: Im3xGEH2RRe7nqErZwTPCA==
X-CSE-MsgGUID: W2y59sfTQG61xXec+dE61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117937531"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2025 18:23:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 15 Feb 2025 18:23:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 15 Feb 2025 18:23:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 15 Feb 2025 18:23:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZE8khjLAZaaPABqX290VUZnScNYgK1FY8iRQ1kncWs2vK104CM7kGs/hcDRYMmACsh5uJsPozwI13jNpaMmt4nVtjHOiYaS+JK0AkiyI14uV0oVgtj54uRKzcV6TLcADeBkGfMzXoPB2/SlQiY/jWdTTENnvnxp7256lVTZAdWi64ae0ytgiYm9nnwo/pEuDLS5mzHslZ/OHqN3InTrpqK+y+89Hqwq0pQho0RbHJxU3F/rVBThXtN2aC+Ch27oe5xN1lKBEmw8ZRjummkHDYPfzMzqsVLwwXq+wixR50NE/ieXHm1PpkYF2m4G96ztjKrS/IqcG3ww+UKDx20nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0IurG1eYaJVWJGir7LVT/4JQ6iebBV94B6mTsG0A6U=;
 b=lqd6LK6+Q6xctrSMHgECofz9z9YPy3LcpAfUKAqb8ssl+pTTTYXZiVVSOCD7BpVZ1mEc2WWojz5FwFyCIS4o+OxupfYKZtZ7Yxsrq3aMRvaHjfHKmL4hWXqAFCjz8M5UzkJi/wPFUZsYYTjzcartQLt30nNuj3f9sqTDl/tSUPvt8mg5J41bFViokT/zrDEvEh8Mp+4KUR+6WKFkRxCX6eZDcW8bPVqL+pDA2JOdv3ecOxUpPq6fjbfIVDzBmKtRNM5U8nXUWJ8kTcXveoGxj0jhBYP1FPb40JZWWq2XNyOdBphUMDoX+/ryxSxmxWMThWLn2SvR8626oe5wWf2PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by MW4PR11MB7005.namprd11.prod.outlook.com (2603:10b6:303:22e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Sun, 16 Feb
 2025 02:22:01 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%4]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 02:22:01 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
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
	<przemyslaw.kitszel@intel.com>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, "Bouska, Zdenek"
	<zdenek.bouska@siemens.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v10 1/5] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Thread-Topic: [PATCH bpf-next v10 1/5] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Thread-Index: AQHbeQbXmIO6gLVD7kucr06l5UZvd7NIxh+AgAAAsgCAAHj4EA==
Date: Sun, 16 Feb 2025 02:22:01 +0000
Message-ID: <PH0PR11MB5830178A14BBAB8B65B97A37D8F82@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250207021943.814768-1-yoong.siang.song@intel.com>
	<20250207021943.814768-2-yoong.siang.song@intel.com>
	<20250215110159.0c1888ae@kernel.org> <20250215110428.68f25c5e@kernel.org>
In-Reply-To: <20250215110428.68f25c5e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|MW4PR11MB7005:EE_
x-ms-office365-filtering-correlation-id: 82f9fd45-d867-493e-cc22-08dd4e30b222
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?20KebnkkTY13JuMqSLje6wMPD8lYw4o8J0wcqWUJ3txMqUU3Y0bpp2Whu/6d?=
 =?us-ascii?Q?wP8wwSvO5cOEi19+2K3RWwuzAHKolILlCEmLmqORKLn1Wf7mtjozJuNEs4rJ?=
 =?us-ascii?Q?/1y2vRGE79T6dBM/DVQE4QaMUTjzLXXbgsoMbZlozBIio8HF8UZcQG3RCLtW?=
 =?us-ascii?Q?YvSyvo0TtQ9Ayrm71dX5HqSc5CdXg1xDKfAtNyQNQzPGYLJupmeTS30QQ9bH?=
 =?us-ascii?Q?+xAiye0ZRfbHJC5xGm3Yib+zZGfD0JLJbp6lcxUCtLj/oQmDOKuzGswCj0TN?=
 =?us-ascii?Q?bIRtAs1U1ldeXJi75sbENBJOijOFlK+wPZVRpI8ukmjwYRB85iAaiqM+fuDd?=
 =?us-ascii?Q?43qvmeNiLBf7OI+MGrM6puGtAQDnniVLzAIJh6qX3hruJu2UiBU0LQukZjUF?=
 =?us-ascii?Q?nNE75//fSL+T/LwHWzzIG+60ZPJPUMeWYK6BADp2CS1tc18QOfYLNAsIjujS?=
 =?us-ascii?Q?yyvDummojrh/cIC8nE/0/151KieBiGZOPBqPbb0EgV4Ym0fKfbEiIMYGRaBR?=
 =?us-ascii?Q?Go8apqtbXCYKxkSgR0okW7xJQ4x5d3d+AcCZ+Qbg4sLS+lqKsYKyvK2DNU8J?=
 =?us-ascii?Q?jdtLnJpZkiUHk8heAe724bSt1DzqxzKzBHmewR9ijJJR3tHl/NhteqbSASlK?=
 =?us-ascii?Q?AGUg0jWv+1TPvKEDp+IDvG5A+5mHh1q0VbJjlKbcmufH5HWy+K0YAWB29/gP?=
 =?us-ascii?Q?H494IWNam1D+5buiHNNQnb7gGvF4vPmYzDgT1QbyD1DMiLl2rWXDihev7SQj?=
 =?us-ascii?Q?vtdX4/63uXHyg4lEiXbERx0pQB72OJTHfwwv6LfIHpI0w6hTs4wxx4JIlXU4?=
 =?us-ascii?Q?dR+PNL0xd2OrKf0oykAMF25/xpsqjTEtdZYL7yW6tmuN2B1zlQR0T087dTfZ?=
 =?us-ascii?Q?SmUTKawFHthehPlwZjyVPcvwjTuQ73HCA4R0/8Y9eU//3tbv7m8IB6zZV8bZ?=
 =?us-ascii?Q?Zmzo7KT13XiAFlT2fJgd1bhyZimeiGbsCk/S+e52dRXHXBcwXPH6jome89D+?=
 =?us-ascii?Q?oLda4WvK9K+MomC9oU80axKcGkChRNRLQxdOv9GGo8wvpEwBSZeN/bWVdJSZ?=
 =?us-ascii?Q?Bv0l+uHoCM4ob+VulolRCm5NF5dmx1Oq9c79DN7bMROaQf8KNnfOHYoETOkq?=
 =?us-ascii?Q?4M13XN4ADAHn1hPBvdaeckIt78ddItA88uOWefxXFygLb++fNBlDjt3KbosC?=
 =?us-ascii?Q?SGyVR7Iu9vewbRkxuKHgo4k4sj58Uy3g5z1vsOC8xVVWT2AlsZ6wrlk6iwH9?=
 =?us-ascii?Q?kikj4ZiNx5DG9CVWPOnNG91p6zvoUcSFPWhdqwqisZsPkoK+WQzaQxMz7hWM?=
 =?us-ascii?Q?p4ZHsuTQorsHrNsg6tHoG3MDBlvM9SpQw1ix4UlsVCK84zsmu5uO8vJaW2uL?=
 =?us-ascii?Q?SJoO2gfVp2+JQNpYUG7Yrgs/L6vO5fVmGPW0XAxtOVFjcgRliYxOzSaBWR/U?=
 =?us-ascii?Q?PTp2QkplGKA+guhlnz0ScGTOAHCoDqR3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TqFIEfImnyTJ8It+CBUCK1L8rDbgRUsg2xRA4NqBg+6yAMJEh8vwHt3Fqdan?=
 =?us-ascii?Q?15atzTPWdTsEEvOkQBi3/6LmwOpu5yqr6Yt3F3LguLaONL/xV6fNzlNpL503?=
 =?us-ascii?Q?uWTbus2FULluqi5NZqzjOGdTds9OqHbcy8jkmCqHcQ+NkNTnw/axbMcPDKP+?=
 =?us-ascii?Q?aVHTZ3IXSMKkbaOQm8YOpyVxGoNfXb+aT51yQfWz4TtVybnWvsSP/1S300ex?=
 =?us-ascii?Q?pzo0AvTOJebd7gBySy7l9Ap0+lXbcdiq+ArIUOzK++5IRZ1+cHjopj0ga1g9?=
 =?us-ascii?Q?36q7jF87KpfhpkIpipvwYmQHnqnNccC06a29xrWrhdspL9WRxXBaEZVRtjO/?=
 =?us-ascii?Q?O0iyU3FN/01jKbmH9XPVWQ4QyHYG3Yz6HiRSPA6+alaU4Ux4iqtPBCcSII1h?=
 =?us-ascii?Q?w1NteIKNxObD+/TaGBL0+kYohg6g+0yo5q6WYPEQEFkriztAKMEkLR3nsN2B?=
 =?us-ascii?Q?enEmIDKA+QUceKhuiZ9KI8PAQFMblbFMWRTwevbScdnlKgpyUHtWxSeRGDjc?=
 =?us-ascii?Q?Eo/hKGoTvkvue+LyAi+H7XrHn7Dg2tW9sAshZg4bdTwzUR06MB9gKvz+XS1O?=
 =?us-ascii?Q?xhk3eu8Omp+hfUZdl4ptOqeK0ndBsbmFBnPFY3rLvKV7VqfFCEW+tDsiRmFk?=
 =?us-ascii?Q?DD1dr5v4slPUkog1scV7W899oLq729cizrvm1U8zukN8gRkBlydYyvTGEYHD?=
 =?us-ascii?Q?49gVGnVHe+GSFHTbE6Y0NM1hNmcEQBaA3PNDflOdnQP3sNh45eM2qAXiQKUC?=
 =?us-ascii?Q?An9ZhjGVICqE8TQZjQ5ouSCzSa/kyycTzStvD5Jbz3DrQfWv2hIp8FknFxjx?=
 =?us-ascii?Q?+/9iFWIZTDpMk0FekYJRh8t9iJKHHHn17r8UIfprj4xd6Cz7RAMjSlliRpFc?=
 =?us-ascii?Q?e6cGFJuHCdoWR6Gd2M0ek8i6CwWN/UOgrWMVu+ToWI15t6GLssFB6KjSq/E8?=
 =?us-ascii?Q?+PkRIpogf2tHLDSpd54mnBE5LMxn1rqIFkE/2tSYIST4GrIIFbmJpsrgtiHB?=
 =?us-ascii?Q?SmRlfuGBJEw/2zm4xyXl29Fx3ynWVjImPGjLV4s5wJEhVKXAJo5JQ9KMQ0N6?=
 =?us-ascii?Q?W7pDRPaU16o+exaewLpnyd/pp2P88TBdBMqvevDgt/6yS6m+3rpWxZidwvX7?=
 =?us-ascii?Q?9wsNSHwkVQy7e7G1NseOAuK85OClc7PXVPVG6ttkrz+G2ftc1ApHZz+buyod?=
 =?us-ascii?Q?ENzKqdNPKmZGm5PF3gBxpQxrBht8Fb8eyMOawPYtI9CGchcKbgFvNR+WCk8K?=
 =?us-ascii?Q?V731yvl1sm+176ct2X4+Go9XbBi2W4w15fRU1imFTmQB7m8uEaex7CKrWZ5I?=
 =?us-ascii?Q?pepC0lUWt+pzBfvBeSAdD1UnZlQLzlYMyrZpMcCfSkYbnp0mGPB4KqbaNwvl?=
 =?us-ascii?Q?QXOKQMK7MA+yt5JEok2F4a2hKRLGqSGmdWZzM7fc6ofh6hUJmPw/VTgHMLXD?=
 =?us-ascii?Q?bLSsvZxeQnqaZWCX9gB+7iW6ejBrK6ywxEGL1g0FJskE7o575B1yrSO1llCB?=
 =?us-ascii?Q?XrRTPUQb68JegKC4SQv73U97xSeCg16vq/quUylNy4dv4mU888gCNlQLFU3O?=
 =?us-ascii?Q?rGINGKBJtg8dm5AA0BUBC7gOfklvVThShjD6FtTEgm8ot2zXm1WI/TPm1f0+?=
 =?us-ascii?Q?Qw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f9fd45-d867-493e-cc22-08dd4e30b222
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2025 02:22:01.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNV2xheloJSSmp97B5qP8Fs8gei42EXLGxio/Nn+XzkmPBVHsoL4xkOHxcJT+f86Sjppr90vVIUD9j+luj7WuCi3vRzAVq77rLHiViwt05g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7005
X-OriginatorOrg: intel.com

On Sunday, February 16, 2025 3:04 AM, Jakub Kicinski <kuba@kernel.org> wrot=
e:
>On Sat, 15 Feb 2025 11:01:59 -0800 Jakub Kicinski wrote:
>> On Fri,  7 Feb 2025 10:19:39 +0800 Song Yoong Siang wrote:
>> > Extend the XDP Tx metadata framework so that user can requests launch =
time
>> > hardware offload, where the Ethernet device will schedule the packet f=
or
>> > transmission at a pre-determined time called launch time. The value of
>> > launch time is communicated from user space to Ethernet driver via
>> > launch_time field of struct xsk_tx_metadata.
>>
>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>
>Sorry, I take that back, you haven't regenerated the code after
>renaming the flag:
>

Hi Jakub,

Thank you for your review and for catching that mistake.
I will rework the patch and submit a new version.

Thanks and regards,
Siang

>diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
>index fc0aa971d276..b97ff8bbb0c6 100644
>--- a/include/uapi/linux/netdev.h
>+++ b/include/uapi/linux/netdev.h
>@@ -59,13 +59,13 @@ enum netdev_xdp_rx_metadata {
>  *   by the driver.
>  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by =
the
>  *   driver.
>- * @NETDEV_XSK_FLAGS_LAUNCH_TIME: Launch Time HW offload is supported by =
the
>- *   driver.
>+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is suppo=
rted
>+ *   by the driver.
>  */
> enum netdev_xsk_flags {
>        NETDEV_XSK_FLAGS_TX_TIMESTAMP =3D 1,
>        NETDEV_XSK_FLAGS_TX_CHECKSUM =3D 2,
>-       NETDEV_XSK_FLAGS_LAUNCH_TIME =3D 4,
>+       NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO =3D 4,
> };
>
> enum netdev_queue_type {
>diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/=
netdev.h
>index fc0aa971d276..b97ff8bbb0c6 100644
>--- a/tools/include/uapi/linux/netdev.h
>+++ b/tools/include/uapi/linux/netdev.h
>@@ -59,13 +59,13 @@ enum netdev_xdp_rx_metadata {
>  *   by the driver.
>  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by =
the
>  *   driver.
>- * @NETDEV_XSK_FLAGS_LAUNCH_TIME: Launch Time HW offload is supported by =
the
>- *   driver.
>+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is suppo=
rted
>+ *   by the driver.
>  */
> enum netdev_xsk_flags {
>        NETDEV_XSK_FLAGS_TX_TIMESTAMP =3D 1,
>        NETDEV_XSK_FLAGS_TX_CHECKSUM =3D 2,
>-       NETDEV_XSK_FLAGS_LAUNCH_TIME =3D 4,
>+       NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO =3D 4,
> };
>
> enum netdev_queue_type {

