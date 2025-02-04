Return-Path: <linux-kselftest+bounces-25660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE271A26FE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7256188750A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7320C032;
	Tue,  4 Feb 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gl7vfr09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0220B813;
	Tue,  4 Feb 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667249; cv=fail; b=iqKeFCZ6feE3PnHzb//lkCT5c7hsWbuJ3rxRmRVb05Ygj05NqG5WmEAW8gnuD2jKo1JjQKy+tNO/BqfgV5udV4loVfFKPoFMrvGHUzjHyOYnFSaALBEP/tRAOox8S7xwHegLmWO4p5a4+5LSFGH8Ah9ndXhrKIXCnGo+jfYvzJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667249; c=relaxed/simple;
	bh=2z16Z2d59biZpaltvYyfg9wC8hJcGX0R6r0qRZ0U1u0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k63v5XIBsiN54tR18947B9swLmPDBT+nLPVR5Wi/Np1pzU1vQ8RiAk73U1k0XV2WLxmzQ3fs/f44SCZGgQvImUD9wo1DpB8SEKm382sm41YdwatnbF1fPoWoWyQ7jLmSTmxzeADaCNLXu5ktOiRpfOVfu10AypmK7wTJLDe4P4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gl7vfr09; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738667247; x=1770203247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2z16Z2d59biZpaltvYyfg9wC8hJcGX0R6r0qRZ0U1u0=;
  b=Gl7vfr09BYhh7M+umL43E4Ona6MOI6lmzIHULdCmSNOVALY+At84omf7
   QL49AorhXK/n5uMVwyo039GzhCEPKnvFvoAIQ7sTc1rovSZen28mKiqmE
   1/w9Ww4gFSr67E1h9LkBiZfLi3XFDElj6rrkrySl1UTHF299K47rPmGBU
   2nKssVWnL7YN0NVgB0pbltV8h1DadWnoADNIc4ezgfde8u01oP7hYABax
   yrNMaoH+u+4zmK8Yz8N0xlt0b3uXLZRKOkHtnViiN5OOuFcd8dsruZL8I
   nuRFIxyEDpb+BlA3GCzjvv2tZSoqBKZ+/8AipjXuRz7pD5Ji3yDBBKaE9
   Q==;
X-CSE-ConnectionGUID: 9Q8VgWZHRFOsdHfDRf65uA==
X-CSE-MsgGUID: p5dYYVIiQCWIN4lQqgbKPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49803023"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="49803023"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 03:07:25 -0800
X-CSE-ConnectionGUID: e9y+dsz9RrqLFW76VGjLPA==
X-CSE-MsgGUID: UFvyAGKsQXiSP0opw56J7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110554179"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 03:07:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 03:07:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 03:07:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 03:07:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNx7K5DBMIUS+6LakwBUmElNekTbypM7qHXeTOO2H1tUFNjqmgOiOqqdIUu0pzwh6hV5DrKoSdw9RhwhymEW1H1C55BAm+q3tUGFSvIVWvk4Sp8R+5RxIfJIiGNXUskTFZHgleQLgaXkfr8pITJdbzvOocHZvw4oxJiGU42KBD9ay0T37sVqUzOJRpY5hh8d5PXDUnO97skXUX6x1mo1lboZ9Ij7ZvOrsPfYvgYOPvvK8PBM2yhqb3PRtj85cQoqBuIfBlOMhqvGpMuA9m0jDSXvGhs1oUAZ6TNifAJtskwxNA1bV9uHUVNRYy7ZvJOe5594CSM2jk+tlI7o8DW4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8irRDE/oYvy4Oc523V2s8qHrD8ItvIa9Mlv1biUXbA=;
 b=RtOK0TarWbmwodUmc/2goEIhmtdfvCJ/Xdt3ug9ZwD32pNmxikLgh6tnGcZ0n2YBr3PPd8WGuANW90u93bcNJ6zV9OH0ROxdqsgqho+2SrNiAvjrlNFSVF+v907zC2es4VfaYLzG2TcVqOsdLtOanySLFb2ZkSEGF08ZQkZ7g2M4tUFuv5r2XZ1O4XPE4C1GCvT/3I/tCzCP3Y1FOgoo0A+Qw9vqfh/zF2n0Hg89CJn82C5qt7Y69F68nqBO632WFAxsqfTFonvQq/+t874/iMyJAintqYbZnbZ/tui9tCwbs6UqOIbqoroRsyZUCOnfgBJscBZ6FOPO2nqvy7HOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 11:07:22 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 11:07:22 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
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
Subject: RE: [PATCH bpf-next v7 4/5] igc: Refactor empty packet insertion into
 a reusable function
Thread-Topic: [PATCH bpf-next v7 4/5] igc: Refactor empty packet insertion
 into a reusable function
Thread-Index: AQHbdp7rCY5AnKYQ8ka8t2MtMQljeLM25zMAgAAN7NA=
Date: Tue, 4 Feb 2025 11:07:21 +0000
Message-ID: <PH0PR11MB58306CEAFF46FD493030943BD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-5-yoong.siang.song@intel.com> <Z6Hi5G0ngTnb7lb/@boxer>
In-Reply-To: <Z6Hi5G0ngTnb7lb/@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH0PR11MB4806:EE_
x-ms-office365-filtering-correlation-id: 7a306d01-63ce-4ddd-8da0-08dd450c1919
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LD8QeIXdK8T2s2ZzsJVxk2eflFEjThClhtLfZ61hLU1ARadhCqgyW+0uVNT5?=
 =?us-ascii?Q?t2iawRjaS+W+fELUknsNDLOy/V0jcpd8QlKW9n9qvbsZRf1GxkfBzOmcMO5Y?=
 =?us-ascii?Q?Cd5Y8bMyrU5i7zVVtVXxfDqjUi648aeQt4J79a/INz+eb5S9Ya7rkAuSyeym?=
 =?us-ascii?Q?LS/Wauc5nS14lrKk/1dOtIpeaMztH2i3r3BjPg49r6n3v+kmztNy/1Je7Zbi?=
 =?us-ascii?Q?pKTBPRxIPJ6mi6UQD32MWfQH0jE28ISGCWSd4y7Jn3rw2gDSNJJGbVVjrQS9?=
 =?us-ascii?Q?EHMFPBnlwgJFjDuHUjLXKJwAHT/RlI1AI8xrTOSwbTGVikQE6M9Vxax+U7ao?=
 =?us-ascii?Q?FRK0rzwsa8oKyv8A8EXH21x1PBfJfFeJQmdw+xui1EaGVbTATTzB62Cy1JQ4?=
 =?us-ascii?Q?SRmf749PQqsZdlH6K3lnSLjedQ+MPRauV7vM920cAleRr7Kps4C/vWTOWUy9?=
 =?us-ascii?Q?nuz0EhvJA6g5M/AFrb5nYB6FugRwCMylE8CrqBamxbdh3WLP5tleaeHH9IC/?=
 =?us-ascii?Q?vEd0w4TpgnziV2UDshFK79YC4t8yp3F1++Nd3CUTZIm32YTC0R0uH3drNLFZ?=
 =?us-ascii?Q?82VNrDOusHoJx4kWAivnzqWno0/aPFUzkIWwYjxSH7NFbNcYr0MdKYuoE1V7?=
 =?us-ascii?Q?jrRY6ShY7RuXPFFPh98oHiDh+kf9AZ0oFSjNG4NApXA/GeaVFYGlJlIEE68/?=
 =?us-ascii?Q?mBMEwGeQ+KjMBiSJ+66TBx0LSMFLkl1qU331bcqrCLHF0MyK/rgpCO8CyTjU?=
 =?us-ascii?Q?3t6iCWv30TkIBabRlIsr2gnz2rdNQQ7LwZE+cqh0mI3Ea5qtSBs8FASFsBVO?=
 =?us-ascii?Q?5SSJheAZvOQGfLIuR6mfkog4wekUQr6qCyP4je7pDGXSOF3WcyVclDOPKAJ1?=
 =?us-ascii?Q?gel0iUMlrCVZnDGBNfVt33bMjINFDe2ceYCeCFWXlu3cBdyBw0sHEy9HeR18?=
 =?us-ascii?Q?3Yz3eHfBm3SyWoHZGuYhbc4Rsiv1ByWlQ2TUFN/lm7MBjwD2i87tL41ggJg3?=
 =?us-ascii?Q?JIrVUVhKlqZa7qtKltV6Vn3lSo6vDM2fYnI/ufYz9KzEv5J/SnszKeDvxWkV?=
 =?us-ascii?Q?cCoKpkdUDoAW1B+vJ+Uaf30tItabZPZoPuqS0NeTR90JvAPjihG8HKsehxeO?=
 =?us-ascii?Q?1AMOeW1ddccvgGiMlLjw2qT6GAPEhZrgrwTJuD1yCKjBUg03s1t1NeIW2A7j?=
 =?us-ascii?Q?6+neQ8SVq3V9NMkKB24DaocHOInckFerSjCxNqbdKfJBHF3yOenMjJgaPaWX?=
 =?us-ascii?Q?ZlXjcMaQ9dCfzyOaBFHUC2RhgdtgbhbTfOFVJyeNnEd+G62iu5ShN0oZgQeb?=
 =?us-ascii?Q?CZCwnodMqCvkXDayv0V6wj5wnbdiw5r24FnjM4vIDeGQ85JmQj7XUFPhw4Dk?=
 =?us-ascii?Q?ZBTW8GxOxXn76cL2TqBpo1yFh1wNiw+zUVWJ3X8KaZS/Kyx6B+XPsYpigJFy?=
 =?us-ascii?Q?HXEUNwbx7+di6aTermSsPDHGYUAGHeAb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?na88wrrTB26jEis2HCoY7PsL1Z7hKnbZBerWFsYq6mm7idBL19uCEvVd6igP?=
 =?us-ascii?Q?+bAoyw6BJGazAC9KETO78oHqz7/LsF35crNeS+YuAgFoMMOAmtTlh+VekTew?=
 =?us-ascii?Q?4JGsCvtXIj/DupeU7cdRh3vPE/LFjgLPMrecq28UVqmta61b0BjjVWv2HQQ5?=
 =?us-ascii?Q?G49HEQwU47WFx7w13cWqrvfOoKH6rQb3iS1WmOwqCXIpTP40Rc+ynic2wpqY?=
 =?us-ascii?Q?4xGdBHSRxOrVyLYIJ0ROxMUi1HAUvkhVes0PnPmQ5krS2cf7mvG2c0+koM0I?=
 =?us-ascii?Q?8/Y/wFHuJe2EimYmZEt7l5/ma3t9qNS6tCG+U2EY4Rs8WytWPCNGL0Y4J1bs?=
 =?us-ascii?Q?GiPWmVmnpaBkp23Kx4BAOn08w+hurZhFeDFrN/+CaD1D9hMqyz+vt2K2O2oH?=
 =?us-ascii?Q?eucc8hthXIKxhX15teRqFdymps8FDGIKkSRAzjJHrqEuwEr+WW6N3/PzPEhk?=
 =?us-ascii?Q?Tjl8v2ppvfv33vpwSUWcgSt4HKnsjfjdevAAj/Zms52YykQMufkyW8HvjbYd?=
 =?us-ascii?Q?BWGdLkNRBwUE8e/gqD5xtd9ZD4f7z93u0c+8Sl7aYfULZYg9R6PKLLe4nxcI?=
 =?us-ascii?Q?C+OHNEqUuRvQ4PYqFES+p/uqQMAiz/oOsJIqJ/aHE0iWmT9pMCO/5YzZHB7M?=
 =?us-ascii?Q?MSaIhHD1R1p4Fli1KOPbsfzyGIHsrYu/U5xgBkxe5VWqQkYjsV9z90QYU7v4?=
 =?us-ascii?Q?ztVSbZfSw1Ran0WLAhNkTOXHEani9179EELxncMztiCGH4555ukz4pD7/Ofq?=
 =?us-ascii?Q?yQwnpynNYSpR/cbQHdxPoakbOrf+M53loKGy75THpUo4Bmtf4bTLWrSRIP6e?=
 =?us-ascii?Q?j+HFxjtkDAygRWGMcXN+vtgojD22c4cJRTopLMTzwJ6Zk9QEapmzS8PFJheC?=
 =?us-ascii?Q?5A1P4ELcmhozHbCh687wr4tLYBihvPhTw1QKVNYRZm6NX4/wT/GezTbeqP9R?=
 =?us-ascii?Q?FqkndC59d9WoWJpDlYY6jsrhaHx+dk/zOt1m4gTuo8MD2OW/+AT9N+Z0Lc2B?=
 =?us-ascii?Q?Wd4uU6phvKQ1aH0HtznB/6NmBSVn/iHpZ5rfLUMCCZ1pJZkIfMcFvSj4+uWO?=
 =?us-ascii?Q?X00EBmrXr3xVreDkgNe20mYBj3shI1kjZ/Qa0paCz8BlG6N3aO7117dga0jV?=
 =?us-ascii?Q?1leqCZX/WnpRgH+u105krQXPT2qGlhzCmGxmcjiSPKz0qpN96DfLjf0kOW/P?=
 =?us-ascii?Q?lF7+6lngc5/6AlQJSLBNxuWWgBcIaEWbXJX/3W2r34/1dtJ3+ONs5N4bPyml?=
 =?us-ascii?Q?zkWs4juAgM4Q2P85Ydd7LUAXksusYMi9QUxgAqVr/nWabwmugXmSsBCE08jt?=
 =?us-ascii?Q?i+MPQuOY4D1XUfh48QRqpgfTsnR0ep/W9cuTOY9t5qcrg9SzxgWOJkPTrr8z?=
 =?us-ascii?Q?n7ZekIwd3sMLv6KWSWojkduhcsxTZVC2imQaYljV9t+MKR+ShXQUTk5b0lDy?=
 =?us-ascii?Q?oDTVWbGBI2RBubvV438XanjT5shMtVTMi85XxBFV4U2RKZXdaAzCjJjMWZCd?=
 =?us-ascii?Q?2px9VPaLTK34hKGew/TtTx+qxQDH5rui1MZXLVYv8IWnOxYZG4bnEtEh3Rrd?=
 =?us-ascii?Q?eNgLC8dA1Mk2U3fUg+y8uFBNO+t2yEZcrCfi3S8eW8urMH5XS6f2z8a2GsQh?=
 =?us-ascii?Q?Ow=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a306d01-63ce-4ddd-8da0-08dd450c1919
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 11:07:21.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oThDIl3ovUkymA+SbBR87n1KPCrtqG36XvKEzCUIHdRpLxI9ylJ/oQchAPSonKxTfMWRDa0uVxCgYAZLqp1cG421yIYHEAx0iPdglogXhhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-OriginatorOrg: intel.com

On Tuesday, February 4, 2025 5:50 PM, Fijalkowski, Maciej <maciej.fijalkows=
ki@intel.com> wrote:
>On Tue, Feb 04, 2025 at 08:49:06AM +0800, Song Yoong Siang wrote:
>> Refactor the code for inserting an empty packet into a new function
>> igc_insert_empty_packet(). This change extracts the logic for inserting
>> an empty packet from igc_xmit_frame_ring() into a separate function,
>> allowing it to be reused in future implementations, such as the XDP
>> zero copy transmit function.
>>
>> This patch introduces no functional changes.
>>
>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++-----------
>>  1 file changed, 22 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 56a35d58e7a6..c3edd8bcf633 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_adap=
ter
>*adapter, struct sk_buff *s
>>  	return false;
>>  }
>>
>> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
>> +{
>> +	struct igc_tx_buffer *empty_info;
>> +	struct sk_buff *empty;
>> +	void *data;
>> +
>> +	empty_info =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> +	empty =3D alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
>> +	if (!empty)
>> +		return;
>> +
>> +	data =3D skb_put(empty, IGC_EMPTY_FRAME_SIZE);
>> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
>> +
>> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
>> +
>> +	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
>> +		dev_kfree_skb_any(empty);
>> +}
>> +
>>  static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>>  				       struct igc_ring *tx_ring)
>>  {
>> @@ -1603,26 +1623,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct
>sk_buff *skb,
>>  	skb->tstamp =3D ktime_set(0, 0);
>>  	launch_time =3D igc_tx_launchtime(tx_ring, txtime, &first_flag,
>&insert_empty);
>>
>> -	if (insert_empty) {
>> -		struct igc_tx_buffer *empty_info;
>> -		struct sk_buff *empty;
>> -		void *data;
>> -
>> -		empty_info =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> -		empty =3D alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
>> -		if (!empty)
>> -			goto done;
>
>shouldn't this be 'goto drop' from day 1? pretty weird to silently ignore
>allocation error.
>

Hi Fijalkowski Maciej,

Thanks for your comments.

"insert an empty packet" is a launch time trick to send a packet in
next Qbv cycle. The design is, the driver will still sending the
packet, even the empty packet insertion trick is fail (unable to
allocate). The intention of this patch set is to enable launch time
on XDP zero-copy data path, so I try not to change the original
behavior of launch time.

btw, do you think driver should drop the packet if something went
wrong with the launch time, like launch time offload not enabled,
launch time over horizon, empty packet insertion fail, etc?
If yes, then maybe i can submit another patch to change the behavior
of launch time and we can continue to discuss there.

>> -
>> -		data =3D skb_put(empty, IGC_EMPTY_FRAME_SIZE);
>> -		memset(data, 0, IGC_EMPTY_FRAME_SIZE);
>> -
>> -		igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
>> -
>> -		if (igc_init_tx_empty_descriptor(tx_ring,
>> -						 empty,
>> -						 empty_info) < 0)
>> -			dev_kfree_skb_any(empty);
>
>ditto
>

ditto

>> -	}
>> +	if (insert_empty)
>> +		igc_insert_empty_packet(tx_ring);
>>
>>  done:
>>  	/* record the location of the first descriptor for this packet */
>> --
>> 2.34.1
>>

Thanks & Regards
Siang

