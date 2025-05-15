Return-Path: <linux-kselftest+bounces-33044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6300AB7F6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6584716CCC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B672820DD;
	Thu, 15 May 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+YuTt0w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A411F4CAA;
	Thu, 15 May 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295837; cv=fail; b=kX9Rv6CLeWrltTJaKEeVJL9jQvy2iMqmqJsD10r2HpjINIFTDF7g7eb0LSjHoBmsiQgsUxINd07h26Os3AmDzK5M26EUFxDYmq1DWKR/3doRE5Ek4/acq5kxM/drwBEiHirD3p4he6NJKdkDQ6IKLA7pfbH80ZMwLt1O71tUSfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295837; c=relaxed/simple;
	bh=KwSyvlzFSb3JYbKD/UpwvISG2kOZbkh9199+eBQAHP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uRUhgKrl7obAoM37aVc6b24vXXr7rONttaugkzBAxqZXQ5JA+Yskd5p8T2LkyxoC/6t5F3VfKVXHLIRPz+hWWPN0idSWNY4zm43yqxKxlUfu8KXT5RcInIwAd0HEM5N6O84HI+94BA0Hh2Ej6XoRmR75igHUK6oFA8eZwysHrTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+YuTt0w; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747295836; x=1778831836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KwSyvlzFSb3JYbKD/UpwvISG2kOZbkh9199+eBQAHP0=;
  b=H+YuTt0wzfmJOJYPG934p4xX0manbbst5dfaXkpvDYdPzixg5CFT9GYR
   ZmAMkHtmlXWGjF9MnxPIY1HAPjTObrKY50ytnMihlDFt+M9YFu5injFv3
   2b1Uy7LkJJU+ArBPLrmXjzam5oRK+QBDP82ViUBbK7Evq/QFgRuu7+BLO
   N18FXyNLjGVpbClV4mDnentCvoeZpiVoYaNmwa10I7UB220rmdf9HNMYa
   qCBJGbq+VduM49VzKmyGuyWb9Eza+UxicnNhv89k8d4Lg1OrxsklhDadj
   AOOnppkpTCsWCdFCJ2ptZM18hAmnTDNPAbi+7N6fUq3hdNTKvyvlBr0nr
   Q==;
X-CSE-ConnectionGUID: ugYm2zJdQMm49sx0krfMCQ==
X-CSE-MsgGUID: 9X2TbBXiT72cdHbbwyktSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52892943"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="52892943"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 00:57:15 -0700
X-CSE-ConnectionGUID: FmJdB4KLQ6ySrkxIDDpvwg==
X-CSE-MsgGUID: eUXkO6B6SYWYkRAXUorHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143485716"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 00:57:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 00:57:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 00:57:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 00:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0v1AteHQdov/8YlX/lRM+R6WjOlmSiQFEmob2gQV5Y34oM09Snqga7/cYwEOAvfSv2zJ2F49A4qSXk/nG+Lw5jbi9vNHZthIF9eDKUUt2jAwA2SJueNG4OiUowMPNy3zNojs+NkKFFaFD8vqnh2Fq6sXnVDnFHXcTknFFsubXxkMhgRCS66O9RsmXx8fgJgZpkuIHHocRg2tcBIZL6vdAsdVtPJNJvMg5cdifKXkndngkz8gtmJAgPIFGe1qlZwXU8WdRwnSNQtbsQYxqGqQ58RG0EO1GhQ11Xv0g+1UK6xQ/QV3A1HZxm508h1o8b2Btp6gYqysPE74VDbeQR5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwSyvlzFSb3JYbKD/UpwvISG2kOZbkh9199+eBQAHP0=;
 b=uhfbLrdmbuQmovOAInP+598Vn3sxt0wmyBor7bPYczs4UbSee+jEx4FUZWINmIYGytxDUjC3BJBntP2r4RPDNb4f3qqpRjYAT7fNl4W5HXHoontkfu14YS2kpT+w7XeqYfIMAxwM2Zw5GAooA0eVS3gBW5krmbLIiu2Fnd/WlxEgY1xvaeEvGweEgP/GwMHtfWP9y6ihyDYE23TfkP40IPDifBPi9VBuzLv5a5Xf5E7MGDZNFEzQO/80bkFiS/MezVVm3p1DOoaBzUF2Fjn0J4rcG6KrnImteo3RECQTCEO2KEV4FMOISYbrrOBd05kv4Ue3GRxslodi5qLB6DTyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PPF7C7D8332C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 07:57:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 07:57:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 19/23] iommu/tegra241-cmdqv: Use request_threaded_irq
Thread-Topic: [PATCH v4 19/23] iommu/tegra241-cmdqv: Use request_threaded_irq
Thread-Index: AQHbwI8JGkFmUz6W2US06/IGoYbxvrPTXLiw
Date: Thu, 15 May 2025 07:57:09 +0000
Message-ID: <BN9PR11MB5276A08F82E6E2F55EBE1F5D8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <e653cf3b204b97eafc40e40606ffdcfeec8a9837.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <e653cf3b204b97eafc40e40606ffdcfeec8a9837.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PPF7C7D8332C:EE_
x-ms-office365-filtering-correlation-id: 789d23eb-b248-4541-807a-08dd9386182f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oBA7CyA9le/20NjnOscEUyjNOSnySLus/n90Yb96oPw5clo4QbZRVXEe7nlC?=
 =?us-ascii?Q?36ExIWlaPlXUSPQvA5PWBG7dEHVaP1di90a5lTtkPxnTko25NXJdCvbrR9wF?=
 =?us-ascii?Q?j+rdfU/q33RDZsPnupwUGAwIdiRl22XugpNzrBM6YRbcXvX0/RFuOhR993gi?=
 =?us-ascii?Q?QEoKPCDpAQ2LSjvjnUrNofRStyFTgvtd/l4RuE3bUtp4V9BiyEGLfsRPsm3r?=
 =?us-ascii?Q?ADZ1nWfg4vH5ereQBDGhWmCKN5XuwqhBnErXXRwqg5MHmfifkkqY2bA5Enl0?=
 =?us-ascii?Q?EqJ/199x+hMN1nnByMgVXOmoojPHhMKS6MereneD2swDIiK9MaEiaxCzGj1s?=
 =?us-ascii?Q?9NArsVq7cvKVLevxcnC37dQnem3JfXLcUz1R4tUe8vNRYlbVvZghCMYSFTd7?=
 =?us-ascii?Q?Uaqa/S95Z8wAiEE/ZRkmJRZzO8KxuYURFfRBqESSfcC8uOBIrlP3Orp2ffU0?=
 =?us-ascii?Q?Cb4yeoezhJVso1y8Scxg0F71Y0hvpFtt2V1G7XYJinDDzWkTgz/5PZEdNNye?=
 =?us-ascii?Q?05Vy7XpoL/69Q12DqN6zpx0QtQDpIBSRJJ88YOWjC3UXajPCvO3jrlVrnAgE?=
 =?us-ascii?Q?bUqfB3iyimuX+lrXc4ju7bdDWuwC75wjZhnmhnHo430XzLQbHfo2G3/aKtcn?=
 =?us-ascii?Q?ukyA8D4BcoTsx3NME9QaRnu3maX8lD38YeeVsXPhFwb0Xgs8YmhFHGlMhLEg?=
 =?us-ascii?Q?ET5J3G3qE4QXg7obAOyJ9YwkjQz5B/UbGr3yYQefrD5kvl483v4guV+vwnk6?=
 =?us-ascii?Q?lU1svvS5p79PZNmw5XaqI5cY7asFMLUm0WP19ERgmvyvUsP2Yf2H9MlFoLVD?=
 =?us-ascii?Q?4d37mkjWmg6ssQ7fM+h3ThBPfVs67nq7jNNoF8IVj0UL6ynsT8FcIG8YMX9E?=
 =?us-ascii?Q?rUwdZADeFDdaKvzxUW7drRiEweMVWfFpganByYIb6kabO9vss9hgMFCf/ayF?=
 =?us-ascii?Q?W9kZ/+FamF4gaVT+OHZmd7YYbDL1bSEBJl6ZB0g4w2qJKvmbP11tVNq+m0MK?=
 =?us-ascii?Q?I3YkL+OFmdLJ9UMRrGCQlaiIaDmOyO+D7PvneLANVQrEXL3PaZ+8ByUHvvQ0?=
 =?us-ascii?Q?Qj10oZzsQOpDxet/7BKWsCgxR8b1HD+o3ERiko7zpTmL4S8tjo1BUHDCPZM3?=
 =?us-ascii?Q?7kHg4X+0nQSggj2l4KSXCWgmS5/t0TOpQunllaJCfY2UGZengqQ9ZUeYgc9T?=
 =?us-ascii?Q?CSXjv/TON9rPmxRJXbzUb4JsmnCVoxK/oRdCUrvDbZ0OZvyBRbO03gGB2AaS?=
 =?us-ascii?Q?EGHHFxbjjQzhClBpz3Zc5Xe9tH803wwLDKVxWgGO/TLaclg+2EGWpPf1WgyY?=
 =?us-ascii?Q?gt0v4Yl3Kt3guhVOr9zsk+WpGNH2WsGg6pBVHigaKCtm/xMM8diGOGds1oKp?=
 =?us-ascii?Q?KAb1PlYsK4Ceiz9zj8nTVyYP0MFsUq2Wa8wP7JYjzbhT25jKid06nBB/2rzE?=
 =?us-ascii?Q?ZbptDTUdykxGRSdN111GP8deToFopW+NSAlnKKyQttLwDEZyDGHD0Gs0I4iW?=
 =?us-ascii?Q?YhEqmZBCmdTqRWg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u6gV7//OdqaKthCW+oIRNJhREl/vKVIzhJ85OJ37DWU6gg3FtUfmbiZnKADl?=
 =?us-ascii?Q?lBv/LyzUzcT2we0JToiiW2V1HNDgt+0lFw9CQaaduEtRSVw/uGdrcmuVkHOT?=
 =?us-ascii?Q?15A9lIq/3kNkTN9AUTilD/wFiq0bGjsxyE2gdlaqDbSCcLOzY13RVeZFHIRG?=
 =?us-ascii?Q?lwsgfiXGfonsL7busYDbZAe28X8r/l3GvXw6t+cDPDTsz3FLnJWzqjYu2Han?=
 =?us-ascii?Q?J5m9XtEkWMJUDIgl3apbrbQ7SHLIkAFCv3ztf0DGxDFxyVZKirinJ0okMPsy?=
 =?us-ascii?Q?G88zXVSsQqJVyyjx0trg+P7k8h/V9VEmD009GDQidv7rAx/F4hr+c5zCkgoV?=
 =?us-ascii?Q?NaMSCILFIBWvzZmaErfXZEtlCB04bcjSE5loYtcRrnxN+NH6mgVCpHzZ5hv7?=
 =?us-ascii?Q?LDC3abvfyGvEFWm4nOyiLsh7fh1f0enUCpCLHfgFjNv2Vg7jo39g8OdO9MAg?=
 =?us-ascii?Q?Oz11JCEg6EpQqpfkGxAfzq3Qwwj9YuucWQVmVVZZUE2SvYRUo0ulDrHmwZGs?=
 =?us-ascii?Q?JVEx4hKdlLeqRuaFopursHK6TozdIWLzK778PUKZjUZ0eGyw0Ct9u2HslxdV?=
 =?us-ascii?Q?tF8i+sjnMENaNjduW++Yr+WACNKcEqT6M8Ogw6vzgjLI4uZvRQhEwke+jf1T?=
 =?us-ascii?Q?OXzeSsof2alZn/4EEaZwA4A+13v4O1kp97niVQ329H/1ndxd1KU6jya8mHjb?=
 =?us-ascii?Q?pUYw/TUUhF9Y8URmEeiay1pbOz0/9Egsm4H+kuGIG39IxfSSvNKAyWQ5y9vB?=
 =?us-ascii?Q?Oj1AzyHRxXu9GJyISt5rsiRcGH/p0qIG2apEvxi6ep0f5eJyOYF5RU7Xhz3l?=
 =?us-ascii?Q?PY6YozPV5N6MgMfGZ4fC6A9aqBmsbo275wA6TxAx7ku0CnMefYB3DR3YNPqt?=
 =?us-ascii?Q?hkI9QAbIa3WcAMU2y3PySOLDB0kwwq0/AQgGSLcghogRTaqLlPEX8m2ofRgj?=
 =?us-ascii?Q?I0MnPuEA8dhK2FSm+lYCzsOC8MBJ0FgZQ8hlCTHvZYFXCY74K2h3ANmanjb1?=
 =?us-ascii?Q?2YDCinpENbsPqGFRGb1qQaz3qa8zZJ1iHADmQD6P6GyE4hZmfbsc+fn4H3hM?=
 =?us-ascii?Q?sJ6iAJVr37lqJqqPMayQ7V/nIb9LbDdBTASesf3v24uOJn9jue4+B33XFKAT?=
 =?us-ascii?Q?ZPXvZJkNmMcTVq2BJKYPocsqJN4aXBzwkzN0AeoEC9IpjJaydoBPuoJnFMV4?=
 =?us-ascii?Q?P4kN/1xw+2JNr1kes1GGP0Le5Hdp6w0RVBmvoSksdOYkmqyEMYBWvdlBBtQo?=
 =?us-ascii?Q?xOewkIRSan8H9PEBbSn/7wvCSr10Bo+A/TpCM6GIYkwGvnJHSObyVwLpIHdh?=
 =?us-ascii?Q?uuvukDmLFgbKfgv8iPmh2hx4xiLWQ/mS77lWYK14OeqhWFzkGmAgBc2E2kQq?=
 =?us-ascii?Q?q7G5ds45DNvd8KXy8NDMw6VcKXY/ZbC0xNJEFfjCp1M2hIrWJT95ReQagnlw?=
 =?us-ascii?Q?L2ocoSEoW5637sQ6dNq46IgstCKpHBOjd5Oaaz0DqxlFOGhEB4rjf9CzeVLC?=
 =?us-ascii?Q?u9h/Wh64q7gjxkdqr+a02dwsnQ6OhmBrgmn82MOFixTbbIaWxazzEBd8M/mB?=
 =?us-ascii?Q?eQyowttwF6quD3d+ZSpQt1tY3w73iK7aNfegjRmt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789d23eb-b248-4541-807a-08dd9386182f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 07:57:09.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocOfG0PNQiO42vm0UWH52F7+vFVK2d5AIsHV23qTl717/pO/rfFhuRI36NSH1XLLMJSNALpxUY21Qz4ymu+gLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7C7D8332C
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> A vEVENT can be reported only from a threaded IRQ context. Change to usin=
g
> request_threaded_irq to support that.
>=20
> Acked-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

