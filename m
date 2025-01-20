Return-Path: <linux-kselftest+bounces-24781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3AA16A76
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF837A05D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B951B4F23;
	Mon, 20 Jan 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBMr2UuN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AA1B4F2F;
	Mon, 20 Jan 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367610; cv=fail; b=QYWGWC06dkolgaKHkyNLORTkeW/0Tjr4mNFQlEvwQTwLIi5QHf07WZDVADqrUXg6DH04wu3eByOuLupdZATqTJBsOLzCS8aZmJppQAZCQ8+2Sp5Z49M/YWdnqIqPwox/DyKoK4F4HD2q5iBP1FEntoKHvH8Aj9T5ZmJrn7ibwJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367610; c=relaxed/simple;
	bh=z1pJoTZp3iVG2ZEUmyVpgWOgTJniz+HeeI9Z7Ve+QFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gzSPxaE34d5BUwjFhVga3AOEwEoGwlikKI8G5T1q6LvfX6Pfn6MYodAw0jKUF6d7UpOUXGlNF5NIz/p+m2KKvY0Exv8mI6NTJRLagnix7Mc3L7AmaijcSAu504w51y4CAStAHwPTUYcaKvYqOvEHlosgOaWSPcZYfEij4xNyqCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBMr2UuN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737367608; x=1768903608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z1pJoTZp3iVG2ZEUmyVpgWOgTJniz+HeeI9Z7Ve+QFw=;
  b=ZBMr2UuNUHInpgdKKiKdr82SP/FFI9kDLGDjy1zxOW2boEDPKL7wq5Bp
   /fUhW/ly6S3X1yGn5BDdw4bsh3PVIKV8OM1uQHLW+PGqoqE1S+dBUbxo6
   3pw1k55M+GVehz79pSxJ+lEhaQkzMgtR01vOTeBLW4nrrYNPAfFy4iSlV
   XWDsqlAM/rDkv+mKnp4ExklfUEFo3QdlM1S7JHH1mm9WSydkIuedeoRyX
   zQGlLO6xwQO7teLXnJk0KHnD8PxRzpX/TNfPniBY9l3B6FCUpTH1njQLi
   OJqenQi11w8rnPUBXpCIk0oIcUqXbzyiKKMhNME+Q/wp9z0/ukea9GH39
   Q==;
X-CSE-ConnectionGUID: tejzB5e2RoOSerhMtrPgYA==
X-CSE-MsgGUID: eQf2xPGKQ9mTlj/8e0Gzcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="25346646"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="25346646"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 02:06:44 -0800
X-CSE-ConnectionGUID: wzz/i/yKQO+9MTEy71NuWQ==
X-CSE-MsgGUID: qLjz9ApMQGq6YVuoRDlD7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111082926"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 02:06:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 02:06:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 02:06:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 02:06:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFuhOSTG9f4EIegeCRXXF1MCIamzb/iMIyHa1lH7IR0ofRUqIM+xHDovQNq1OF8ZZOJlIAjv3TqQEaBHo0WtigZZgpf9bredMqbiY/nBiSx4d1AAhwcB8iaqTrVdn/rPGb9Iz6GrUy+cUmgKYzWMJXpA9bX1DI1WX4vlG+AD8Fm4TQ4PKIdOU/EVyqh4KGnkcg7IjVg+TNX2PEyLAcSCViOZfDMJQiY+QSgaJ49AFA6x5EsV253vLdkJqB4+Zw+V+DlYTjBqgOnUnoH17Rn5hvgGjNrwxKoiPt7L6UdzRJKtfMN1rNlM1eZeHJBKGPFLYqb5UyHzmpcPlYrOJpBknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1pJoTZp3iVG2ZEUmyVpgWOgTJniz+HeeI9Z7Ve+QFw=;
 b=oC7cjR0Egn7RxEvnYv53lnKZeNKQGTVtIVcJpSqmPrIF1wYw4rWoEwh5XSwYZ0EsvhCpFofUE30URtiahQCfc9sVbToBweihe2hVvln+bY9qgZOIgplDmUMUym9c32ZaDH1IfdyqLa7/NJAeF4X7XMp27ulk7gyvW91GICQ1fqnIWyxYRm9DVyViHc7sRi/xO3kYPyZ5FjGFaEIL0CANdmIdaf/fejSJWUp9DZNCITTwFFQTF9eMPKaNqgyXbH4mPbwRS+InT1J18WDutmLMAbUbcHq2+ZR7E5z7Vsio/nHJhP6kB+LTIg5hV8/k0N9Sca6zumvOYVzdKQW9c4+wLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 20 Jan
 2025 10:06:25 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 10:06:25 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
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
Thread-Index: AQHbaC8B2aD+Y8oJSU6tHVAr+g1K37MfN+iAgAA5yMA=
Date: Mon, 20 Jan 2025 10:06:25 +0000
Message-ID: <PH0PR11MB5830CB1F9EC76D45FA3E0C56D8E72@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-5-yoong.siang.song@intel.com>
 <84770113-2546-4035-8bd4-bf9cedcfb00f@linux.intel.com>
In-Reply-To: <84770113-2546-4035-8bd4-bf9cedcfb00f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SA2PR11MB4987:EE_
x-ms-office365-filtering-correlation-id: e696855d-f435-42ea-2b23-08dd393a1954
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TUlDNnpYRWdhSER0Sm9OblVqMVNEcmo4eThnMzJiQ2p6VTZuSU83Q0I3MHpI?=
 =?utf-8?B?TjlYVU9EcndKTS9LdWJJK2pRMVpnL3NNVjlBNmxzQmJUeFIrakZ3WmVuS2k3?=
 =?utf-8?B?eHAvK20wTmRoRWMvVDRjYUh5V29LRTNXSnh4Z3hIYTB4cnNsbXQ5Zy94c0JO?=
 =?utf-8?B?czBmaTBYSzhUU3hVN2NuV0lsV1FySFpRRWN0dkJoZktuL1pEeFIrcVlIaUI1?=
 =?utf-8?B?cDBBM2pleGlUbm5kaXhLYTcvQldiNjhRZEphMkZNOVNuRi9RWkNBdlNYSG9t?=
 =?utf-8?B?WWplajhYc3E5blc0S04yeW5KMGxwcUt6Ky8zNHpUUlAyTUh3SHdtTU9Md0JL?=
 =?utf-8?B?K0xjVEVSYkM2dDZ1MXI4QWpDTmUyM0tVSTFjS0pON1ppZHVJbzB1YVZVOHAv?=
 =?utf-8?B?Wml6VTBBQlYxbWhhVCtFUC81U0ppNE1yQXZGZU5kOFpLMWtaUE9hVVV3TE1I?=
 =?utf-8?B?U2R4bWZJWTRPaEgvbmk1eVZjRzlvN3RkVEdkci9vN0dEWllQMFllYnV6VUND?=
 =?utf-8?B?aXBhRUhNM3QweWVJeFM3UkpXQVQ4TzVQb1ptZVhuUU1nOWMrcEZBOUl6d1NP?=
 =?utf-8?B?WXJKTi8wY25ManczSmlrTXpnYXVaK3F0amlpS29icVJRTWNYVUt2YXNzUW1W?=
 =?utf-8?B?VUlHL3pHMnpYakl3b2l1RnJDdnEvZWZNcDN2RHRjQUdlZmI0YlcyQzNiTFJJ?=
 =?utf-8?B?d0RzeDU4MmpmbTAxS0JnaEtYZVRDVW10K0RNdGtYUXhzSHFpR1Awb2hWdXZL?=
 =?utf-8?B?OTR6K0V4aUtOWDVGM1ZwcmtoOVJWN1ovbVg1b3BaQkJQTmVMSllueGRkcUln?=
 =?utf-8?B?bkpxRGVXRithSVJrMFlCcS9CNnNPVExxWDMwanovbk5xZ0NyUWlrOUMrZUZP?=
 =?utf-8?B?M1FaM0M5TTBXWW8rZzFyRmNEdDVPcFNDa3l1SHVOQTRmQ29OREtRZU9QTnlC?=
 =?utf-8?B?d1VZUUR6T01hK2IxY3Vua3UyYWpTSkhCa01mL29CdldTRG9ySzF3cnd6ZDJv?=
 =?utf-8?B?aDRFYTJHeTloL0VVRlh4bGhPNlV6dmtWMklSSGpLMmRtS2g0MW5KMWdVWDU4?=
 =?utf-8?B?YTVpUkRLckZYUmd0eHZMcGVPOHBrZFk2ZTc3Z1d4UkE3U1R2eE8zUkd5RFRt?=
 =?utf-8?B?bTFySTZUVm05Sm9yYlVaSm9nZHkrTEg4dTVOMFNDN2NmZzVJQnR6a0l3Z09r?=
 =?utf-8?B?VXJUUFhMdzhDUzczaXg2MmVVT1A2UitUMEtsSWxreVhWN1hMTE03eWk4blg4?=
 =?utf-8?B?NVpFa0cvb1hmOW84OW9EUVF0Y0NlNGFsRFRYWmtRZTcrakRQTDZSU2NwVTQ2?=
 =?utf-8?B?MWdDMjNDQTJlRXlKS2U4Z1Y4a0tLeThJa2dLbnhWMmF6L3A3dHZvbHM3WFZj?=
 =?utf-8?B?UDlCK3lBbW04Z21xN01SbDdTVFNIRzh0S0M0SEFwZHluYkRSaUxUVUY2U1or?=
 =?utf-8?B?MkNXSU4zVnFGWWlvSGpTUmhCZWlZZ29TWWRtWkNLcGduYUdpTTMrZ3hQNW1l?=
 =?utf-8?B?K2ZEUlk3SUZsN1V1Y0ZSSWZZcnJuWG56Y2lZbXEzZkNtTWQ3dWluMEk0K0hr?=
 =?utf-8?B?VW5DM2g3L3pkYytWMnlKdU1WTjRwRVBtWHVVWGVTQmJLd1JORUNheXJQM0ti?=
 =?utf-8?B?UVlXWXJUcDhITVVLemZpN2tUV2hKSmFXR2ZPZThhYytkcDJqQmFVTDJMUTlJ?=
 =?utf-8?B?ZUZQVDRwcTB3RW9KTGlnc0lVVm52MXViVEZzNFJIR3RFT2F6b0J1UlV1d255?=
 =?utf-8?B?UEgyekNqaHQ5dDg0Q2NoNWRncHdRZ0pMU2swUTVvYmtkMCtkQkxKTU9SQ1Vr?=
 =?utf-8?B?Y2p0b0hLOEpFbjNUWmZ5OTJSRHhoNVhwWEZZTzZSSExROGlrVHk2S3VGVFBl?=
 =?utf-8?B?Z0ExanZSclFoNHlEUHhDdXluL29EY3pmTGdsMDUzc0JISWV6TUFOcnlWNmND?=
 =?utf-8?B?NHN5STI3bzVhYzA2bDFIamxxamNka3VBaGhCdFZhUlBmVlQ3UVBrUU9CZTk3?=
 =?utf-8?B?c09ZRW16Qk53PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGcvZWdrMk1aTzR2WS80OU1wV25RaTZNZEZpQ3B6WllJVk1Cbm5wYnBSdlpR?=
 =?utf-8?B?akZzUGlEZVArQWZ1MDJIbHR4alU1eXZmNG1xZFZwSlRIMHE1YzlVaGZpaER0?=
 =?utf-8?B?bWpFMnZrcWs2Nkt1RzlmV0w4TndyNGdaeHJTRDU2RmJEV2xrYXFrT1h2Zy9M?=
 =?utf-8?B?WXZnclRXK016a2xScWdTNXErc1BnNFdTZG9rRDBNMmtxd04rOTZqU0pXVjZp?=
 =?utf-8?B?MkkwWUIzNHFvNnptVFBSL1RIRU9oS1pHdjVXcC9kSXVKUHlJUWF3eTZQdUN5?=
 =?utf-8?B?Nk5LalFvTkhCZU1FV245T2tlbzNacXNCUHFWdW1pMXF1UHRTWU5sd3M5S05h?=
 =?utf-8?B?a3VlWkJ0Vm9QQVV4azJZNThZdXFFZCtoNDJvT3U0TG1kU1pDMkROV1B2eG93?=
 =?utf-8?B?ZE1sUFhUMTJWSEVkSVlDdnM1VGFQdnJLNFYxZndjbUNpYjJIZkZSWjByTGR0?=
 =?utf-8?B?Lys2NDEvSU1LdTJwS1RneWdrMkxFQW1PN08wVDkwb0R5QlZJaXhiVzBMQ1BP?=
 =?utf-8?B?QUQ2TmVtZUp4TEtpcWhEMnhNV1FwRE1uYkl0WUJETXdYR0t4aldtdk51RDZC?=
 =?utf-8?B?NE5zVnJ2R0ZCenlCTlVJQTIrcEs2QUhpcHQvb1Qwd1BXelJlNzFiWEJrT08y?=
 =?utf-8?B?eGx0cmY4NkdFU2RXMEY3QVRPOGRQUEV3MzUwcVNsN3Z5dUhRSjhTa25nUmsx?=
 =?utf-8?B?RTBObE0zOGMvSHJJT0hQU0xjRmNwZGdtVlhlOGRaTk1qSHRrc3hhUlNLQmJR?=
 =?utf-8?B?M3ZhNzd2K3d3WG9EYTR5dCtkV1EyZW80OVlqTmNKTk5jbU10a2ZHMmg1ZmlL?=
 =?utf-8?B?cnZFWXgydlQ4cjRQQjdFNUo1YzJIMnA5OXdZNW5wMUd0OGN0TTZSZzcrcU5y?=
 =?utf-8?B?NzhIR1FEVkJQT09IakpFZlZ3ZmhzbE1udFBCWFlaZmJhU2ZPMkVDZjQ0c0px?=
 =?utf-8?B?YUtiU2dzZW1XOGVMOFVITGRMRmM0TnRRQnV2cjhqRjlvZnMvdTJwMU1wd1Ro?=
 =?utf-8?B?THpvNThGTWxjQjdhVUtibGY5QVVNbGNlcVJSTGwyR3hlSUFRWFRPZG9leFly?=
 =?utf-8?B?d3BURHhHZWpSK3pWdXRrMExJb1h6dXhyRTN0S3ZZNUdXRE5XTXdjeGZTK1dp?=
 =?utf-8?B?RkRSd2hFWkpPa2xUQmJFK25TaXVkQ0pTRnd0dXRwMkpZeUtuUmlwbG9WL2hI?=
 =?utf-8?B?ZnpRblhyQm5CVUNvRkUwQkhyV0loWDVSMEwvVHdNZGZXWFYrQ3k3eWdDTWJF?=
 =?utf-8?B?bWV0RE8vbzh2a1BvaDAwSnBwM1QvN0dkQXlneW9pQ1JTT1d6cEN5K1FUWHN3?=
 =?utf-8?B?ajBYem9WUjJnNS82cHlKQ0hlNTVRbnJwazIzQ3l1Z3lUR1k2OU1TMVBaWEhJ?=
 =?utf-8?B?MlM3SlZUOVJLQzVXcmwvQUY3NlZFTkpDNkRyYk1wNUJad3dmdXBVKzRkb2NZ?=
 =?utf-8?B?MHdwQ1pndndlS1VidEdoaTB1NlJISGhXeGtKMjJvTDFDR2M5SHBIdzc3U25G?=
 =?utf-8?B?WmJYSzFWS2dqZFRrdkRlM1pZY0xudCtxMFFHUk1BaFdSb3hQUE9zTzBRbnhX?=
 =?utf-8?B?OWZ3NmszRlBRbVkvSXRmaWlYb2x5YmNPWElpM3ZyZ0hkWHArUFgydlVqeVV5?=
 =?utf-8?B?T0JXTEpPbjluZE9GL3BoV2FibGRidm9KVkVUc1RWZVFyWmp1NHN6VkthblZv?=
 =?utf-8?B?QTNKK20zc2RsTU1oR0VJcXI0bXRLWUVKMzZ4SmxpWWZpYUdpdlgyNXVKQTJW?=
 =?utf-8?B?bzNhUFJRbzFIL0ZoNitaejh6SDkyNk51bFRrOXBEU1VzY3ZOVWtoV2REV0Ja?=
 =?utf-8?B?SHcvQ25hOXhEQTA2ZXFMck9MVThQaVVTaUlNVzdEemUyTGJqalFIaE92emx4?=
 =?utf-8?B?bjkzcFB5bjVnU1RjUXFTMHJlOGJPbG1kWGR5dnUwSDI0WFBBSy8rTHJPZFNO?=
 =?utf-8?B?blhWdWo1cTRKeHZ4RU96VFlNWC9tVGZoSDMvalBBRzY3dlk3WGdWblJqRTRE?=
 =?utf-8?B?RW43aFJqWFRKUUFoQUN6TmJ5OExVclVJc2lqancycnovSXRnTzRUTW9LaUZU?=
 =?utf-8?B?a2xtbDVIdDlXNjc5Z05rNjdZZ1djcnJ2S0JGeW1lSXEwMGhEL2RxY1JoaGU0?=
 =?utf-8?B?L1JveFR5dUYrYzNWaXBpVGxicEF2bU1zYzFKdVkwNjBvOVpaUVhrRjVsTUI5?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e696855d-f435-42ea-2b23-08dd393a1954
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 10:06:25.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0oBEAu41yWn7ucu6ZqC5MmG1lSu4UWXZLTqZt3FyD0WTWqXf+Dr+1U8ojr43KtKMyhl4ebxNKI/c7dFlBFvdJmRipPUuuPjcx3qii3qKvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
X-OriginatorOrg: intel.com

T24gTW9uZGF5LCBKYW51YXJ5IDIwLCAyMDI1IDI6MjYgUE0sIEFiZHVsIFJhaGltLCBGYWl6YWwg
PGZhaXphbC5hYmR1bC5yYWhpbUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPkhpIFNpYW5nLg0K
Pg0KPk9uIDE2LzEvMjAyNSAxMTo1MyBwbSwgU29uZyBZb29uZyBTaWFuZyB3cm90ZToNCj4+IEVu
YWJsZSBMYXVuY2ggVGltZSBDb250cm9sIChMVEMpIHN1cHBvcnQgdG8gWERQIHplcm8gY29weSB2
aWEgWERQIFR4DQo+PiBtZXRhZGF0YSBmcmFtZXdvcmsuDQo+Pg0KPj4gVGhpcyBwYXRjaCBpcyB0
ZXN0ZWQgd2l0aCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveGRwX2h3X21ldGFkYXRhIG9u
DQo+PiBJbnRlbCBJMjI1LUxNIEV0aGVybmV0IGNvbnRyb2xsZXIuIEJlbG93IGFyZSB0aGUgdGVz
dCBzdGVwcyBhbmQgcmVzdWx0Lg0KPj4NCj4+IFRlc3QgU3RlcHM6DQo+PiAxLiBBdCBEVVQsIHN0
YXJ0IHhkcF9od19tZXRhZGF0YSBzZWxmdGVzdCBhcHBsaWNhdGlvbjoNCj4+ICAgICAkIHN1ZG8g
Li94ZHBfaHdfbWV0YWRhdGEgZW5wMnMwIC1sIDEwMDAwMDAwMDAgLUwgMQ0KPj4NCj4+IDIuIEF0
IExpbmsgUGFydG5lciwgc2VuZCBhbiBVRFAgcGFja2V0IHdpdGggVkxBTiBwcmlvcml0eSAxIHRv
IHBvcnQgOTA5MSBvZg0KPj4gICAgIERVVC4NCj4+DQo+PiBXaGVuIGxhdW5jaCB0aW1lIGlzIHNl
dCB0byAxcyBpbiB0aGUgZnV0dXJlLCB0aGUgZGVsdGEgYmV0d2VlbiBsYXVuY2ggdGltZQ0KPj4g
YW5kIHRyYW5zbWl0IGhhcmR3YXJlIHRpbWVzdGFtcCBpcyBlcXVhbCB0byAwLjAxNnVzLCBhcyBz
aG93biBpbiByZXN1bHQNCj4+IGJlbG93Og0KPj4gICAgMHg1NjJmZjVkYzg4ODA6IHJ4X2Rlc2Nb
NF0tPmFkZHI9ODQxMTAgYWRkcj04NDExMCBjb21wX2FkZHI9ODQxMTAgRW9QDQo+PiAgICByeF9o
YXNoOiAweEUzNDMzODQgd2l0aCBSU1MgdHlwZToweDENCj4+ICAgIEhXIFJYLXRpbWU6ICAgMTcz
NDU3ODAxNTQ2NzU0ODkwNCAoc2VjOjE3MzQ1NzgwMTUuNDY3NSkgZGVsdGEgdG8gVXNlciBSWC0N
Cj50aW1lIHNlYzowLjAwMDIgKDE4My4xMDMgdXNlYykNCj4+ICAgIFhEUCBSWC10aW1lOiAgIDE3
MzQ1NzgwMTU0Njc2NTE2OTggKHNlYzoxNzM0NTc4MDE1LjQ2NzcpIGRlbHRhIHRvIFVzZXIgUlgt
DQo+dGltZSBzZWM6MC4wMDAxICg4MC4zMDkgdXNlYykNCj4+ICAgIE5vIHJ4X3ZsYW5fdGNpIG9y
IHJ4X3ZsYW5fcHJvdG8sIGVycj0tOTUNCj4+ICAgIDB4NTYyZmY1ZGM4ODgwOiBwaW5nLXBvbmcg
d2l0aCBjc3VtPTU2MWMgKHdhbnQgYzdkZCkgY3N1bV9zdGFydD0zNA0KPmNzdW1fb2Zmc2V0PTYN
Cj4+ICAgIEhXIFJYLXRpbWU6ICAgMTczNDU3ODAxNTQ2NzU0ODkwNCAoc2VjOjE3MzQ1NzgwMTUu
NDY3NSkgZGVsdGEgdG8gSFcNCj5MYXVuY2gtdGltZSBzZWM6MS4wMDAwICgxMDAwMDAwLjAwMCB1
c2VjKQ0KPj4gICAgMHg1NjJmZjVkYzg4ODA6IGNvbXBsZXRlIHR4IGlkeD00IGFkZHI9NDAxOA0K
Pj4gICAgSFcgTGF1bmNoLXRpbWU6ICAgMTczNDU3ODAxNjQ2NzU0ODkwNCAoc2VjOjE3MzQ1Nzgw
MTYuNDY3NSkgZGVsdGEgdG8gSFcNCj5UWC1jb21wbGV0ZS10aW1lIHNlYzowLjAwMDAgKDAuMDE2
IHVzZWMpDQo+PiAgICBIVyBUWC1jb21wbGV0ZS10aW1lOiAgIDE3MzQ1NzgwMTY0Njc1NDg5MjAg
KHNlYzoxNzM0NTc4MDE2LjQ2NzUpIGRlbHRhDQo+dG8gVXNlciBUWC1jb21wbGV0ZS10aW1lIHNl
YzowLjAwMDAgKDMyLjU0NiB1c2VjKQ0KPj4gICAgWERQIFJYLXRpbWU6ICAgMTczNDU3ODAxNTQ2
NzY1MTY5OCAoc2VjOjE3MzQ1NzgwMTUuNDY3NykgZGVsdGEgdG8gVXNlciBUWC0NCj5jb21wbGV0
ZS10aW1lIHNlYzowLjk5OTkgKDk5OTkyOS43NjggdXNlYykNCj4+ICAgIEhXIFJYLXRpbWU6ICAg
MTczNDU3ODAxNTQ2NzU0ODkwNCAoc2VjOjE3MzQ1NzgwMTUuNDY3NSkgZGVsdGEgdG8gSFcgVFgt
DQo+Y29tcGxldGUtdGltZSBzZWM6MS4wMDAwICgxMDAwMDAwLjAxNiB1c2VjKQ0KPj4gICAgMHg1
NjJmZjVkYzg4ODA6IGNvbXBsZXRlIHJ4IGlkeD0xMzIgYWRkcj04NDExMA0KPg0KPlRvIGJlIGNh
dXRpb3VzLCBjb3VsZCB3ZSBwZXJmb3JtIGEgc3RyZXNzIHRlc3QgYnkgc2VuZGluZyBhIGhpZ2hl
ciBudW1iZXINCj5vZiBwYWNrZXRzIHdpdGggbGF1bmNoIHRpbWU/IEZvciBleGFtcGxlLCB3ZSBj
b3VsZCBzZW5kIDIwMCBwYWNrZXRzLCBlYWNoDQo+Y29uZmlndXJlZCB3aXRoIGEgbGF1bmNoIHRp
bWUsIGFuZCB2ZXJpZnkgdGhhdCB0aGUgZHJpdmVyIGNvbnRpbnVlcyB0bw0KPmZ1bmN0aW9uIGNv
cnJlY3RseSBhZnRlcndhcmQuDQo+DQoNCkhpIEZhaXphbCwNCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldyBjb21tZW50cy4NClN1cmUsIEkgY2FuIHNlbmQgY29udGludW91cyBwYWNrZXRzIHdpdGgg
c2hvcnQgaW50ZXJ2YWwgYW5kIHNoYXJlDQp0aGUgcmVzdWx0IGluIGNvbW1pdCBtc2cuDQoNCj4+
IFNpZ25lZC1vZmYtYnk6IFNvbmcgWW9vbmcgU2lhbmcgPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwu
Y29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFp
bi5jIHwgNzggKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDU2
IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPmIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4+IGluZGV4IDI3ODcyYmRlYTliZC4uNjg1N2Y1
ZjViNGIyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2ln
Y19tYWluLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFp
bi5jDQo+PiBAQCAtMTU2Niw2ICsxNTY2LDI2IEBAIHN0YXRpYyBib29sIGlnY19yZXF1ZXN0X3R4
X3RzdGFtcChzdHJ1Y3QgaWdjX2FkYXB0ZXINCj4qYWRhcHRlciwgc3RydWN0IHNrX2J1ZmYgKnMN
Cj4+ICAgCXJldHVybiBmYWxzZTsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgdm9pZCBpZ2NfaW5z
ZXJ0X2VtcHR5X3BhY2tldChzdHJ1Y3QgaWdjX3JpbmcgKnR4X3JpbmcpDQo+PiArew0KPj4gKwlz
dHJ1Y3QgaWdjX3R4X2J1ZmZlciAqZW1wdHlfaW5mbzsNCj4+ICsJc3RydWN0IHNrX2J1ZmYgKmVt
cHR5Ow0KPj4gKwl2b2lkICpkYXRhOw0KPj4gKw0KPj4gKwllbXB0eV9pbmZvID0gJnR4X3Jpbmct
PnR4X2J1ZmZlcl9pbmZvW3R4X3JpbmctPm5leHRfdG9fdXNlXTsNCj4+ICsJZW1wdHkgPSBhbGxv
Y19za2IoSUdDX0VNUFRZX0ZSQU1FX1NJWkUsIEdGUF9BVE9NSUMpOw0KPj4gKwlpZiAoIWVtcHR5
KQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwlkYXRhID0gc2tiX3B1dChlbXB0eSwgSUdDX0VN
UFRZX0ZSQU1FX1NJWkUpOw0KPj4gKwltZW1zZXQoZGF0YSwgMCwgSUdDX0VNUFRZX0ZSQU1FX1NJ
WkUpOw0KPj4gKw0KPj4gKwlpZ2NfdHhfY3R4dGRlc2ModHhfcmluZywgMCwgZmFsc2UsIDAsIDAs
IDApOw0KPj4gKw0KPj4gKwlpZiAoaWdjX2luaXRfdHhfZW1wdHlfZGVzY3JpcHRvcih0eF9yaW5n
LCBlbXB0eSwgZW1wdHlfaW5mbykgPCAwKQ0KPj4gKwkJZGV2X2tmcmVlX3NrYl9hbnkoZW1wdHkp
Ow0KPj4gK30NCj4+ICsNCj4NCj5UaGUgZnVuY3Rpb24gaWdjX2luc2VydF9lbXB0eV9wYWNrZXQo
KSBhcHBlYXJzIHRvIHdyYXAgZXhpc3RpbmcgY29kZSB0bw0KPmVuaGFuY2UgcmV1c2FiaWxpdHks
IHdpdGggbm8gbmV3IGNoYW5nZXMgcmVsYXRlZCB0byBlbmFibGluZyBsYXVuY2gtdGltZQ0KPlhE
UCBaQyBmdW5jdGlvbmFsaXR5LiBJZiBzbywgY291bGQgd2Ugc3BsaXQgdGhpcyBpbnRvIGEgc2Vw
YXJhdGUgY29tbWl0Pw0KPlRoaXMgd291bGQgbWFrZSBpdCBjbGVhcmVyIGZvciB0aGUgcmVhZGVy
IHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gdGhlDQo+cmVmYWN0b3JpbmcgY2hhbmdlcyBhbmQgdGhl
IG5ldyBjaGFuZ2VzIHJlbGF0ZWQgdG8gZW5hYmxpbmcgbGF1bmNoLXRpbWUgWERQDQo+WkMgc3Vw
cG9ydC4NCj4NCg0KSSBhbSBvayB0byBzcGxpdCB0aGUgcGF0Y2ggaW50byB0d28uIFdpbGwgZG8g
aXQgb24gbmV4dCB2ZXJzaW9uIHN1Ym1pc3Npb24uDQoNCj4+ICAgc3RhdGljIG5ldGRldl90eF90
IGlnY194bWl0X2ZyYW1lX3Jpbmcoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4+ICAgCQkJCSAgICAg
ICBzdHJ1Y3QgaWdjX3JpbmcgKnR4X3JpbmcpDQo+PiAgIHsNCj4+IEBAIC0xNjAzLDI2ICsxNjIz
LDggQEAgc3RhdGljIG5ldGRldl90eF90IGlnY194bWl0X2ZyYW1lX3Jpbmcoc3RydWN0DQo+c2tf
YnVmZiAqc2tiLA0KPj4gICAJc2tiLT50c3RhbXAgPSBrdGltZV9zZXQoMCwgMCk7DQo+PiAgIAls
YXVuY2hfdGltZSA9IGlnY190eF9sYXVuY2h0aW1lKHR4X3JpbmcsIHR4dGltZSwgJmZpcnN0X2Zs
YWcsDQo+Jmluc2VydF9lbXB0eSk7DQo+Pg0KPj4gLQlpZiAoaW5zZXJ0X2VtcHR5KSB7DQo+PiAt
CQlzdHJ1Y3QgaWdjX3R4X2J1ZmZlciAqZW1wdHlfaW5mbzsNCj4+IC0JCXN0cnVjdCBza19idWZm
ICplbXB0eTsNCj4+IC0JCXZvaWQgKmRhdGE7DQo+PiAtDQo+PiAtCQllbXB0eV9pbmZvID0gJnR4
X3JpbmctPnR4X2J1ZmZlcl9pbmZvW3R4X3JpbmctPm5leHRfdG9fdXNlXTsNCj4+IC0JCWVtcHR5
ID0gYWxsb2Nfc2tiKElHQ19FTVBUWV9GUkFNRV9TSVpFLCBHRlBfQVRPTUlDKTsNCj4+IC0JCWlm
ICghZW1wdHkpDQo+PiAtCQkJZ290byBkb25lOw0KPj4gLQ0KPj4gLQkJZGF0YSA9IHNrYl9wdXQo
ZW1wdHksIElHQ19FTVBUWV9GUkFNRV9TSVpFKTsNCj4+IC0JCW1lbXNldChkYXRhLCAwLCBJR0Nf
RU1QVFlfRlJBTUVfU0laRSk7DQo+PiAtDQo+PiAtCQlpZ2NfdHhfY3R4dGRlc2ModHhfcmluZywg
MCwgZmFsc2UsIDAsIDAsIDApOw0KPj4gLQ0KPj4gLQkJaWYgKGlnY19pbml0X3R4X2VtcHR5X2Rl
c2NyaXB0b3IodHhfcmluZywNCj4+IC0JCQkJCQkgZW1wdHksDQo+PiAtCQkJCQkJIGVtcHR5X2lu
Zm8pIDwgMCkNCj4+IC0JCQlkZXZfa2ZyZWVfc2tiX2FueShlbXB0eSk7DQo+PiAtCX0NCj4+ICsJ
aWYgKGluc2VydF9lbXB0eSkNCj4+ICsJCWlnY19pbnNlcnRfZW1wdHlfcGFja2V0KHR4X3Jpbmcp
Ow0KPj4NCj4+ICAgZG9uZToNCj4+ICAgCS8qIHJlY29yZCB0aGUgbG9jYXRpb24gb2YgdGhlIGZp
cnN0IGRlc2NyaXB0b3IgZm9yIHRoaXMgcGFja2V0ICovDQo+PiBAQCAtMjk1NSw5ICsyOTU3LDMz
IEBAIHN0YXRpYyB1NjQgaWdjX3hza19maWxsX3RpbWVzdGFtcCh2b2lkICpfcHJpdikNCj4+ICAg
CXJldHVybiAqKHU2NCAqKV9wcml2Ow0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIGlnY194
c2tfcmVxdWVzdF9sYXVuY2hfdGltZSh1NjQgbGF1bmNoX3RpbWUsIHZvaWQgKl9wcml2KQ0KPj4g
K3sNCj4+ICsJc3RydWN0IGlnY19tZXRhZGF0YV9yZXF1ZXN0ICptZXRhX3JlcSA9IF9wcml2Ow0K
Pj4gKwlzdHJ1Y3QgaWdjX3JpbmcgKnR4X3JpbmcgPSBtZXRhX3JlcS0+dHhfcmluZzsNCj4+ICsJ
X19sZTMyIGxhdW5jaF90aW1lX29mZnNldDsNCj4+ICsJYm9vbCBpbnNlcnRfZW1wdHkgPSBmYWxz
ZTsNCj4+ICsJYm9vbCBmaXJzdF9mbGFnID0gZmFsc2U7DQo+PiArDQo+PiArCWlmICghdHhfcmlu
Zy0+bGF1bmNodGltZV9lbmFibGUpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCWxhdW5jaF90
aW1lX29mZnNldCA9IGlnY190eF9sYXVuY2h0aW1lKHR4X3JpbmcsDQo+PiArCQkJCQkgICAgICAg
bnNfdG9fa3RpbWUobGF1bmNoX3RpbWUpLA0KPj4gKwkJCQkJICAgICAgICZmaXJzdF9mbGFnLCAm
aW5zZXJ0X2VtcHR5KTsNCj4+ICsJaWYgKGluc2VydF9lbXB0eSkgew0KPj4gKwkJaWdjX2luc2Vy
dF9lbXB0eV9wYWNrZXQodHhfcmluZyk7DQo+PiArCQltZXRhX3JlcS0+dHhfYnVmZmVyID0NCj4+
ICsJCQkmdHhfcmluZy0+dHhfYnVmZmVyX2luZm9bdHhfcmluZy0+bmV4dF90b191c2VdOw0KPj4g
Kwl9DQo+PiArDQo+PiArCWlnY190eF9jdHh0ZGVzYyh0eF9yaW5nLCBsYXVuY2hfdGltZV9vZmZz
ZXQsIGZpcnN0X2ZsYWcsIDAsIDAsIDApOw0KPj4gK30NCj4+ICsNCj4+ICAgY29uc3Qgc3RydWN0
IHhza190eF9tZXRhZGF0YV9vcHMgaWdjX3hza190eF9tZXRhZGF0YV9vcHMgPSB7DQo+PiAgIAku
dG1vX3JlcXVlc3RfdGltZXN0YW1wCQk9IGlnY194c2tfcmVxdWVzdF90aW1lc3RhbXAsDQo+PiAg
IAkudG1vX2ZpbGxfdGltZXN0YW1wCQk9IGlnY194c2tfZmlsbF90aW1lc3RhbXAsDQo+PiArCS50
bW9fcmVxdWVzdF9sYXVuY2hfdGltZQk9IGlnY194c2tfcmVxdWVzdF9sYXVuY2hfdGltZSwNCj4+
ICAgfTsNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIGlnY194ZHBfeG1pdF96YyhzdHJ1Y3QgaWdjX3Jp
bmcgKnJpbmcpDQo+PiBAQCAtMjk4MCw3ICszMDA2LDcgQEAgc3RhdGljIHZvaWQgaWdjX3hkcF94
bWl0X3pjKHN0cnVjdCBpZ2NfcmluZyAqcmluZykNCj4+ICAgCW50dSA9IHJpbmctPm5leHRfdG9f
dXNlOw0KPj4gICAJYnVkZ2V0ID0gaWdjX2Rlc2NfdW51c2VkKHJpbmcpOw0KPj4NCj4+IC0Jd2hp
bGUgKHhza190eF9wZWVrX2Rlc2MocG9vbCwgJnhkcF9kZXNjKSAmJiBidWRnZXQtLSkgew0KPj4g
Kwl3aGlsZSAoeHNrX3R4X3BlZWtfZGVzYyhwb29sLCAmeGRwX2Rlc2MpICYmIGJ1ZGdldCA+PSA0
KSB7DQo+DQo+Q291bGQgd2UgYWRkIHNvbWUgZXhwbGFuYXRpb24gb24gd2hhdCAmIHdoeSB0aGUg
dmFsdWUgIjQiIGlzIHVzZWQgPw0KDQpJdCBpcyBiZWNhdXNlIHBhY2tldCB3aXRoIGxhdW5jaCB0
aW1lIG5lZWRzIDIgZGVzY3JpcHRvcnMgYW5kIHNhbWUgZ29lcw0KZm9yIHRoZSBlbXB0eSBwYWNr
ZXRzLiBUaHVzLCB0b3RhbCBuZWVkIDQgZGVzY3JpcHRvcnMuIEkgd2lsbCBhZGQgZGV0YWlsDQpl
eHBsYW5hdGlvbi4gDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQoNCg==

