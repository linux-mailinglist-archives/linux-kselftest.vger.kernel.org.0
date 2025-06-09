Return-Path: <linux-kselftest+bounces-34514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C1AD263F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 20:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD04C3A3B2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2321D3FD;
	Mon,  9 Jun 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXkZHJGg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D217BD3;
	Mon,  9 Jun 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495369; cv=fail; b=REgjejYD2aUlQ11lx3X9yMZy5/y+meMQEkNOKUnkAQ4LcqUXeWxOHRgfDWBDdpSSt+bkEwquNTcWUEr8SFJCnZW4UW+ZleN3BzXibFdL90ulHlWaxg6WwxGDq8IPll8eYk2WEJ2RBYSPB9WCZNZiRosTvZEAVmP0rcxxM0T17ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495369; c=relaxed/simple;
	bh=xlqFfQSvj4BIJk3q7mG8XKgFEvtQY+gciXM5IE6H5M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m705rsEpEpZuV0vztKlRQfqOXf7F9x91w6zv8CyCGH1FD9J6kSnkCC/9YYx2/8sqKtpoOP46IJtPF8WsCFQdpZA0yvNzDUUi+Sfxz6k8Dx+EOfJWjUVqpI4Qx/YnrKp6CaMWFZL033mcF5Ja5gtXD0XYiZ4YodIHyyF4wcxL6Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXkZHJGg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749495368; x=1781031368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xlqFfQSvj4BIJk3q7mG8XKgFEvtQY+gciXM5IE6H5M4=;
  b=JXkZHJGglmmbOLdeuNTPg/jOpenQb7u1tqjFxD8PzkAS4HEiPO4FvpU2
   +93lVjkFLug6k1rN1KlVQd2rgl3J+ByVLiK7Bjpq0slVmRYud0zcEfGBp
   yieyubS7qNp9D2tYIA/qb9utJQbYzlP5hW4sW+/944YpsRpmDOLU3LmeA
   ldpto/l/3JRcIDnum5K5bR0NVthTNWrh1RMWIS4eTPOfFJNY9xVjLA1tw
   WG73YA4bM662D7x6bTL11Qx3NoGoIFKZlvZpg5DvXqhgSJqj0LuR7nbP+
   UcSny51s6pR9hc3d9/SIoU2zxKBhZ0xjYzy31BY8tYHgrQSWC2/kV56dT
   w==;
X-CSE-ConnectionGUID: eMgSl0hmTiuX9656xny8KQ==
X-CSE-MsgGUID: GgaUz7wETeurR/Hxuu2Wzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62938786"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62938786"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:56:07 -0700
X-CSE-ConnectionGUID: +suP6i3aTOaWlKvXPrlAfg==
X-CSE-MsgGUID: SNL8cN+xQYCXKZ1YOcVrtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146495335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:56:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 11:56:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 11:56:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.60)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 11:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugLLREuq76q1yc7B8rRIO8sm6O8DjkFNptawnGqY3oYABPVuZeKGFwAQXKbCHzHhWOtSnbVsEBsbZ1LlJJ2OjSBPAC2+o7NB7uKEyxzH5h5T4NqJ6SFeULnGV0rwCzcOiAT6BOrfWFC5LqbeheuAnpo0u1EDvQrlXB0/UXfxaVhjz779eVi5RvVQgvnfpP/q3UE4mJC0KpkwkEyW4stP8Zp2Y6Evh0FIkeT4L5awqnIM3goaRJOm/oZWEIbKzchq1SOSMX8IvPb+Jko3mExG/Q2Q+iGNDmTb4hD19Yiwe2FrgO9jZcEa0XBrS7AQi3fQ1b8JqoiE/4B6NCmG/rUMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i07Tqlq+2O4rKpv9s1E/MpRhdcf40pVLFR7jWhKGauU=;
 b=g0i5/gVFpshG/E3xLzswbGE2gZhVafhlU84WPYGzlHAPt+6F46l/F9tYRA8ncax0OcLL/VXFlEM6AqTDN2x9nE1FPnaQtsKG2fjG6wWFx53PPY5ezQbsOWC0a6s9ce9+121X/dY6LxJns7By9dAUJnxu8ffm7gTI+pYHeUcosK9MT9BE0QUdxVcmXA74g6dEWA0YNmetPuaYPrBiqEZjOHTGQGKsIAEL0M5+3mBUeFoKqlba5ZwRd3XFd5I8j0v2LAD59JDFTk3pVYjlZDnHmpBYRQmHe86XrUxVpW28Xe2ADAUAJ5xYO1uMRqfQ96lxtXwY8HA+uCB6VnGg//RPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 18:56:02 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Mon, 9 Jun 2025
 18:56:01 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "skalluru@marvell.com"
	<skalluru@marvell.com>, "manishc@marvell.com" <manishc@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "ajit.khaparde@broadcom.com"
	<ajit.khaparde@broadcom.com>, "sriharsha.basavapatna@broadcom.com"
	<sriharsha.basavapatna@broadcom.com>, "somnath.kotur@broadcom.com"
	<somnath.kotur@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "louis.peens@corigine.com"
	<louis.peens@corigine.com>, "shshaikh@marvell.com" <shshaikh@marvell.com>,
	"GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
	"ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>, "horms@kernel.org"
	<horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "mheib@redhat.com" <mheib@redhat.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"linux-net-drivers@amd.com" <linux-net-drivers@amd.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 3/4] netdevsim: remove
 udp_ports_sleep
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 3/4] netdevsim: remove
 udp_ports_sleep
Thread-Index: AQHb2Vs+vvxRuHozsU+/NH0bGgPxDbP7LXIg
Date: Mon, 9 Jun 2025 18:56:01 +0000
Message-ID: <IA3PR11MB8986C1AECE9F09A36FB37D3BE56BA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
 <20250609162541.1230022-4-stfomichev@gmail.com>
In-Reply-To: <20250609162541.1230022-4-stfomichev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5865:EE_
x-ms-office365-filtering-correlation-id: f7f5dc51-5d50-480e-ed38-08dda787476e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lgM0j8hgoGHK8Bkxbq22iHV3TfKdB3LEgq0yZG+4fCTKGbgbiyvkM39IEY8f?=
 =?us-ascii?Q?UkyZrXCjyZ0Mf8ah/wyK9XW+sJ0ncfz/Fkf7r0Z3Mb/Z0i6EJq2r15yUmOMV?=
 =?us-ascii?Q?IExCmKl6v2zP5x5/yMHOGVKFuJGrNJnszJ0V90x4wpYAf399mDBRiLtPDm/7?=
 =?us-ascii?Q?Hh7QDcENJPrDPLnA/MyDHTQY0wEGgC92G0S6PHJr6UNOeKwnhc9wjh3mZNde?=
 =?us-ascii?Q?ToQxEzL7ugLjYCuZORAkogB5/9N2/jDm3ii4CPk7gjt2uGlmae+fgfOp55vD?=
 =?us-ascii?Q?2PeN5ALJR9CmdHW8oiBF4/hSXUUuvZLWsy07DiTejRHJO4msS6zZy/WIc5KF?=
 =?us-ascii?Q?DbHkJBst9OHMLBfhn/v6FdoP0UAIWNmXPVNwyVx5RBtC003b7tq/m42Hkdf3?=
 =?us-ascii?Q?FFFv1JQ1GIguhRSJFVNsIce2VVNG5Y5LzqXptwUserPSvf93xU8SVaTpO82i?=
 =?us-ascii?Q?RnqUxo1Lc/3Z9Fg9q9GG8XQIGOtxy78aN4tqQjiIYGKBn27iecxMe/Pnt7b8?=
 =?us-ascii?Q?2JGw+s6YI7gwZFE27mh7iaie9V3k1+pl4tGw2qFVGpJ4xITKr4yQpCfAE0jg?=
 =?us-ascii?Q?sYdYvmaJmaiitpKlG20qr4y9XO8XomybxfJ+X8HeAkU4VR/ZyX/aDDfdSV5v?=
 =?us-ascii?Q?73fevi+WPoYaP6ooSSvzArr1y9xIpFYTC3a0dr4dz2daEQX09s1pmrXYx1T2?=
 =?us-ascii?Q?QVa/Aud2ZUoLLugsroApDG/Xaff9g65Dvxj79iuZ2PudvvnktaUPTPw9Rynb?=
 =?us-ascii?Q?Gj2IFyJujVukzgq+QD2ATcZT1SZkHZ1oM3GtyVQND3TJ0ocPPizf6roHo3ia?=
 =?us-ascii?Q?sFkAEuxuaq+BA5zg9YFrnNgxK66i6M9/BPFq+Z5GbyzmVYIqtwssCTMK8/mq?=
 =?us-ascii?Q?4px74yC7aR8ZVqQ28QJtMV8X1JAsAntL8CapaxbZfvvaMmaDoqzSj1cLbzLK?=
 =?us-ascii?Q?RB5I1JvMPh/EqRnKZN0EqDz0xraLJozUvtq67RFPoinOG/bd2dU1ULSev7S1?=
 =?us-ascii?Q?JSmLdVAgmPo220srhoAj34prtaWBVE3MdngoGFvROFkiEzoB8N4e8oRpMY8P?=
 =?us-ascii?Q?H4YRiqyPf+1kzjiQA8SWzECj/IiQRytIqW/8JSkaTialfIeGmKSbJSxMTTdx?=
 =?us-ascii?Q?mGXDoxZTdu6v6u2QLnXrbf8yWeD399XYNLon2kuPveOOHh+2RwdyMBnqQbDu?=
 =?us-ascii?Q?uZORjSXVJ1UvxcdwS+7wV/nb7NehrhzQ92zVS3l9AnBf71pTJqMFzBFKD+ZT?=
 =?us-ascii?Q?mMzwU941igIpI8984Ju8WUJdVCCjOoFZBAVab6n7jSyxjAsY8YiRM1ynRpU5?=
 =?us-ascii?Q?QDEW/sIAfn3bLsbzXkuszPjPSqpIT6fwFrSCVAqHGUyLWyih4oy3TZNR4y2Q?=
 =?us-ascii?Q?wLD/C/BDTbwk3aOHHLE9cnPLOg9CJOAVudPXISGZTD3nnFiW3ex8L+KVLAYG?=
 =?us-ascii?Q?rl4RFVyBmRcnGpo9v+f1zCpVC2gV7sTiOX+ZdFC/NmDOJfoxSni6yw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sAm2Hrofu/zKbqWOuLov1MUGGkL6RegKnfS7xJpDL9XMf0Zp51e1d07ec0yY?=
 =?us-ascii?Q?aoVxrvyzh7lFW4c6dIAo2ApVH52A9FsOe272M6eq5t70h6JeJ0/SvW5P6BzW?=
 =?us-ascii?Q?bbO5UdP1Fq09LpPuG+tQsx5+Sx/dGkj9VmbKhUApNkpfRs3N34xjEzg8ZiHb?=
 =?us-ascii?Q?7Qdy8+MFsrs59StNBpGVwkDh0EuauqjzWUAEF7TU0CucB3r9eQTzSf9ubD6s?=
 =?us-ascii?Q?AzG/GTjUVcLGzRrDwlTiwhaGJnvHfAMjLR5/bYZQjqqKM+tyLZTi9Y/jUn5x?=
 =?us-ascii?Q?KRh+FX/Jwh4kVkBWT5qbI7oGsDrQPVXD1Gf+dflvfuwpUnQZUhilAAdcWrdT?=
 =?us-ascii?Q?Ne3GkvVeJ8fxKIZ2Ekmfd0Pho+VeqL9LH5QF9g+OMzy8ZCtytq+jFwDO/3Or?=
 =?us-ascii?Q?5pfmdlXyMOONlTXq9nXr0Sby13MPMnme1jpx6n+eFH6FP/ZMOHGP1S08nEyw?=
 =?us-ascii?Q?A6gk8/IZ3Yd10yCLn7onmOVHDdcwEBUrbvm1sy8SUPCOa/BDoEhhBZrDj7iH?=
 =?us-ascii?Q?ZJDpdf3AY5YcjZfEoCKY11yCHaUba5Pkdn7fZcqBp+VK+/G0ldw8B+bfZS5+?=
 =?us-ascii?Q?WlTv/D9m2hwvF1jL+ji0M0iEzTVecX4MJsflwx+4ss61jkjIMAna6g2s2Prj?=
 =?us-ascii?Q?J7j52qnciDsuGpPwWFgnnX5krUnXpitd+mvxvn/cn/DIu7q1iXqQoD24W/gP?=
 =?us-ascii?Q?DNX4nMMzS+e6PuPuUcGS0apTLGugmbfoPR7U8Mc4tmDjTJgDXG662kTvkek/?=
 =?us-ascii?Q?SwJCT1Plt8UjNMfY5NoEHuqno4IV/roa8pGcYGVz7U4RUD9gE/j2ePpB3Z3Y?=
 =?us-ascii?Q?4pU5ERSgAjKa53jfV9bTZf9Y38JgqfbLbLUN8nvPbrgI03v9GWGcHH01Hp2a?=
 =?us-ascii?Q?97v3yhO3e9mnrSj/w1WjWN+AEr/pgPpCrZIN5qnGt0k7J3PL3dI3bFQqafLk?=
 =?us-ascii?Q?AIY7jXlcbZsgSfqSeIK2DpmMh7dLAypHRtCXrKc54c/7IvFkaaCsh/1IJwlz?=
 =?us-ascii?Q?1T9ewjypdSV4liimP6RODUAB6bLMqCKKGQ+c1emaopsi8UzuZ+XnVNk2iVwl?=
 =?us-ascii?Q?9coIf4D/VWzJhbjtWzk8Qu9oHsZJnMfIJfWUpx/Nqgv+YU23boFSlQSq6CU2?=
 =?us-ascii?Q?x0LTBD8jsURAa2sNJg01vECf5NYMPQ5rV2jl9zk52OGjSOF6lgOS9r7MOkmG?=
 =?us-ascii?Q?mIgVdQJ/oTRqUHuXFfnDqc38EFNtBawOk2SLVWBanhxf+jgLV44LUFHK00Ew?=
 =?us-ascii?Q?N6Gs7gBXSps6U6yJ+fO5PxKDNJRb8gVqTpTVMYhSJrm2HwNIBeCBgUoFyJy/?=
 =?us-ascii?Q?+g6uhnkQx7XlqCfuZzExHLK5GOfDjU5MIldOI+YJsF+Nnu3gQ/O9ytnnOkER?=
 =?us-ascii?Q?6kg8yQxyhrwyv48bJXNqFfwjZO4fLGFNZqV19J1G4iFo0RpaCralbaQrSiuj?=
 =?us-ascii?Q?yfJp50suQ2cOC1vyuDNmptFEAu2vq8J6KdSOI15NSYXRoM+1TNpjPC+zphIO?=
 =?us-ascii?Q?p8b+qDAMSJhinHwO1XQ0CwvX/fmKY6Bl//Rb94NNIi0Y5Im1Zgln5UrDaR/s?=
 =?us-ascii?Q?JuPOrVclW0Fifb3HbLjjA9gcFNPbRFC26exeuBi6osv8/8cV9moZnmlvCPYO?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f5dc51-5d50-480e-ed38-08dda787476e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 18:56:01.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KMRrOkDnZHf/RPcQPRu6ymh3qbo8Og8hEd6FbEGM7ZcDXLNh+qVd334gT4h3rKOwAdcmJc01pO7J65UYMDxv2hsdY7ONEzFzQ22fSyJhpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Stanislav Fomichev
> Sent: Monday, June 9, 2025 6:26 PM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; skalluru@marvell.com; manishc@marvell.com;
> andrew+netdev@lunn.ch; michael.chan@broadcom.com;
> pavan.chebbi@broadcom.com; ajit.khaparde@broadcom.com;
> sriharsha.basavapatna@broadcom.com; somnath.kotur@broadcom.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; tariqt@nvidia.com; saeedm@nvidia.com;
> louis.peens@corigine.com; shshaikh@marvell.com; GR-Linux-NIC-
> Dev@marvell.com; ecree.xilinx@gmail.com; horms@kernel.org;
> dsahern@kernel.org; shuah@kernel.org; mheib@redhat.com;
> ruanjinjie@huawei.com; stfomichev@gmail.com; linux-
> kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> rdma@vger.kernel.org; oss-drivers@corigine.com; linux-net-
> drivers@amd.com; linux-kselftest@vger.kernel.org; leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 3/4] netdevsim: remove
> udp_ports_sleep
>=20
> Now that there is only one path in udp_tunnel, there is no need to
> have udp_ports_sleep knob. Remove it and adjust the test.
>=20
> Cc: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/netdevsim/netdevsim.h                      |  2 --
>  drivers/net/netdevsim/udp_tunnels.c                    |  8 --------
>  .../selftests/drivers/net/netdevsim/udp_tunnel_nic.sh  | 10 ---------
> -
>  3 files changed, 20 deletions(-)
>=20
> diff --git a/drivers/net/netdevsim/netdevsim.h
> b/drivers/net/netdevsim/netdevsim.h
> index d04401f0bdf7..511ed72a93ce 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -131,7 +131,6 @@ struct netdevsim {
>  	struct nsim_macsec macsec;
>  	struct {
>  		u32 inject_error;
> -		u32 sleep;
>  		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
>  		u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
>  		struct dentry *ddir;
> @@ -342,7 +341,6 @@ struct nsim_dev {
>  		bool ipv4_only;
>  		bool shared;
>  		bool static_iana_vxlan;
> -		u32 sleep;
>  	} udp_ports;
>  	struct nsim_dev_psample *psample;
>  	u16 esw_mode;
> diff --git a/drivers/net/netdevsim/udp_tunnels.c
> b/drivers/net/netdevsim/udp_tunnels.c
> index 10cbbf1c584b..89fff76e51cf 100644
> --- a/drivers/net/netdevsim/udp_tunnels.c
> +++ b/drivers/net/netdevsim/udp_tunnels.c
> @@ -18,9 +18,6 @@ nsim_udp_tunnel_set_port(struct net_device *dev,
> unsigned int table,
>  	ret =3D -ns->udp_ports.inject_error;
>  	ns->udp_ports.inject_error =3D 0;
>=20
> -	if (ns->udp_ports.sleep)
> -		msleep(ns->udp_ports.sleep);
> -
>  	if (!ret) {
>  		if (ns->udp_ports.ports[table][entry]) {
>  			WARN(1, "entry already in use\n");
> @@ -47,8 +44,6 @@ nsim_udp_tunnel_unset_port(struct net_device *dev,
> unsigned int table,
>  	ret =3D -ns->udp_ports.inject_error;
>  	ns->udp_ports.inject_error =3D 0;
>=20
> -	if (ns->udp_ports.sleep)
> -		msleep(ns->udp_ports.sleep);
>  	if (!ret) {
>  		u32 val =3D be16_to_cpu(ti->port) << 16 | ti->type;
>=20
> @@ -170,7 +165,6 @@ int nsim_udp_tunnels_info_create(struct nsim_dev
> *nsim_dev,
>  		       GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> -	ns->udp_ports.sleep =3D nsim_dev->udp_ports.sleep;
>=20
>  	if (nsim_dev->udp_ports.sync_all) {
>  		info->set_port =3D NULL;
> @@ -213,6 +207,4 @@ void nsim_udp_tunnels_debugfs_create(struct
> nsim_dev *nsim_dev)
>  			    &nsim_dev->udp_ports.shared);
>  	debugfs_create_bool("udp_ports_static_iana_vxlan", 0600,
> nsim_dev->ddir,
>  			    &nsim_dev->udp_ports.static_iana_vxlan);
> -	debugfs_create_u32("udp_ports_sleep", 0600, nsim_dev->ddir,
> -			   &nsim_dev->udp_ports.sleep);
>  }
> diff --git
> a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> index 92c2f0376c08..8c5fe7bdf1ce 100755
> --- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> +++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> @@ -266,7 +266,6 @@ for port in 0 1; do
>  	echo $NSIM_ID > /sys/bus/netdevsim/new_device
>      else
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>  	echo 1 > $NSIM_DEV_SYS/new_port
>      fi
>      NSIM_NETDEV=3D`get_netdev_name old_netdevs` @@ -350,7 +349,6 @@
> old_netdevs=3D$(ls /sys/class/net)
>  port=3D0
>  echo $NSIM_ID > /sys/bus/netdevsim/new_device  echo 0 >
> $NSIM_DEV_SYS/del_port -echo 1000 > $NSIM_DEV_DFS/udp_ports_sleep
> echo 0 > $NSIM_DEV_SYS/new_port  NSIM_NETDEV=3D`get_netdev_name
> old_netdevs`
>=20
> @@ -428,7 +426,6 @@ echo 0 > $NSIM_DEV_SYS/del_port  for port in 0 1;
> do
>      if [ $port -ne 0 ]; then
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>      fi
>=20
>      echo $port > $NSIM_DEV_SYS/new_port @@ -486,7 +483,6 @@ echo 1 >
> $NSIM_DEV_DFS/udp_ports_sync_all  for port in 0 1; do
>      if [ $port -ne 0 ]; then
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>      fi
>=20
>      echo $port > $NSIM_DEV_SYS/new_port @@ -543,7 +539,6 @@ echo 0 >
> $NSIM_DEV_SYS/del_port  for port in 0 1; do
>      if [ $port -ne 0 ]; then
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>      fi
>=20
>      echo $port > $NSIM_DEV_SYS/new_port @@ -573,7 +568,6 @@ echo 1 >
> $NSIM_DEV_DFS/udp_ports_ipv4_only  for port in 0 1; do
>      if [ $port -ne 0 ]; then
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>      fi
>=20
>      echo $port > $NSIM_DEV_SYS/new_port @@ -634,7 +628,6 @@ echo 0 >
> $NSIM_DEV_SYS/del_port  for port in 0 1; do
>      if [ $port -ne 0 ]; then
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>      fi
>=20
>      echo $port > $NSIM_DEV_SYS/new_port @@ -690,7 +683,6 @@ echo 0 >
> $NSIM_DEV_SYS/del_port  for port in 0 1; do
>      if [ $port -ne 0 ]; then
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>      fi
>=20
>      echo $port > $NSIM_DEV_SYS/new_port @@ -750,7 +742,6 @@ echo 0 >
> $NSIM_DEV_SYS/del_port  for port in 0 1; do
>      if [ $port -ne 0 ]; then
>  	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
> -	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
>      fi
>=20
>      echo $port > $NSIM_DEV_SYS/new_port @@ -809,7 +800,6 @@ echo
> $NSIM_ID > /sys/bus/netdevsim/new_device  echo 0 >
> $NSIM_DEV_SYS/del_port
>=20
>  echo 0 > $NSIM_DEV_DFS/udp_ports_open_only -echo 1 >
> $NSIM_DEV_DFS/udp_ports_sleep  echo 1 > $NSIM_DEV_DFS/udp_ports_shared
>=20
>  old_netdevs=3D$(ls /sys/class/net)
> --
> 2.49.0


