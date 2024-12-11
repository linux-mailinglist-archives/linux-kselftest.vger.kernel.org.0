Return-Path: <linux-kselftest+bounces-23167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974789EC6FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC296284C02
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2551D799C;
	Wed, 11 Dec 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Roma3w8E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9742451C5;
	Wed, 11 Dec 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905342; cv=fail; b=NshNiwzol/RvdLC7PA6kK5tZmWRdP0WebNrbe2h8dYH3muE1kGRAWzptuBHz8ZKDKWGvhwUjs3zcjeOKqVIcJ77LA3RmZsMBAxcb22LdMWqXRa3LiC7N+Yo+2yVNgRjhFNAI8Aryc148dqXyL8Sxg+vWZYpHQGk4gxbGZ7JR+ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905342; c=relaxed/simple;
	bh=tl0TWJAVIKVRn6N5RWCmiRXBCwaroQpcQc+FD61fv80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eJIRUI7tfgdTl2afLAqBQ/BeUyRN0OdgLcS7qfiQnw/tuaoRDtG3D9yf8Bku2fxeu0xf6LXsPGz82RRTn+WrfYUrT/rimo+at5bUsIB1soZ8fT7ViuUpqhWgiTkktlQjdlz5Isv+6/aqFMuZCPLY6SvEu9hxgvC7/XIxKOFpgQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Roma3w8E; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733905341; x=1765441341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tl0TWJAVIKVRn6N5RWCmiRXBCwaroQpcQc+FD61fv80=;
  b=Roma3w8EuDtkPK8i0fVH1SYkSRr+CV2RXilt1F2lnmUbchJIZF73Broe
   BNTMf3WsAnHi7rO/K5rbpvZf2m3pP6ekK+GjO4lqABoDRfJiSzfvPxuDE
   rU2Gp3Vnher8uqUQjQRIVdjg8He5Kdh7STegjMJ2QmxwrezfQMGkFduTg
   4tOK+RpiB8gpwbgExhq2STZNcb5W67nmgU6dFqzCC1h3Q7noD3aFXcxCD
   039M+Be0YTEOP1E0IgxQd90OlPBfwe28PzT1SxZG4rGBXtx3jzJrnogrR
   gtzHX1bX3N6IyT3Q+pL/d2sPKZdnAo24YA5Tzv7K9Z0YhVTg88JT85RYF
   Q==;
X-CSE-ConnectionGUID: px+pYeysTReNxy1GosHdUA==
X-CSE-MsgGUID: Nf72nae5Svuy4HnYLdBZKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33594293"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="33594293"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:22:20 -0800
X-CSE-ConnectionGUID: W5RWJm5kQ9uaFaCCy9lcYw==
X-CSE-MsgGUID: MDtSzZcAQcGtECsD0RUJ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95547037"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:22:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:22:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:22:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:22:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ecaf/1i5pBXcoPedgQZcQUtkh9GxptuzFxhf67y5S3xeJwCa1A9R3+QRqjvVg/cotXM5g5ZsMbvBlIHaZwnPBqsVuKW32Tmc96vF3aJcHncDCRbu1YS8s7UINIgZrY69Vug7IcnFfz8RW2l1po3WPQOWwnEXHyHSWGKFDfGOQ2WR5NMSbXde4SFshUIFwvzO3GHx1jWKDMhrkJOZ2n4TDqOJYhhZivfuLzLskkZkskEsjCsUPQ7EviiBt7ZOmOeFryr4i3J07Yhq05gZQ5/xvGxrMQVZD+G3gD9Wo1NCKermQjWh+Z/SVBQpHmveTw/BIGsiE3SaFg4nrs6yFgouEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz1SzpjgOxWBQJuo7VY2xTe9/jt61Hd+6wu+ciYV7fE=;
 b=mfyTNPyHplBvGweazvkZKBJlWztWv/B/pwFzDcGO/N8fXOmw42GeoTzHqEFftkzFrSfJTLD/HRkKwrOQvYmFgPdV9puEmKzDw5Ffpv5y2In1kgkqJaWUkg01npa6AyVNieJqLyIgiD72MnakXFgRdfOx5O20AhD3DPsX+x7GS5ZJ9PXE8w2o1UubsRojjBdxmroDwXd2B8KX++jwQlmJx20IndJkPHqKWkQZeNQStGW0mue4DM4vb+IzNhJ4D19pL9r36hr/yakQMkKvjuMMlcWu8lX07XWcsUuCy1uA2OM0RJ/8BZhfXos58Zl5tu6RkIbGNykEYqstyQd+OgmIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:21:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:21:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 13/13] iommu/arm-smmu-v3: Report IRQs that belong to
 devices attached to vIOMMU
Thread-Topic: [PATCH v2 13/13] iommu/arm-smmu-v3: Report IRQs that belong to
 devices attached to vIOMMU
Thread-Index: AQHbRdBMYsaoACTJe0+K7DIsnrAlqbLgvvQg
Date: Wed, 11 Dec 2024 08:21:42 +0000
Message-ID: <BN9PR11MB5276EE81D21EC5E4156EB7D58C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <d335936fdeccfcf785589800b7e5d9b1b26a766d.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <d335936fdeccfcf785589800b7e5d9b1b26a766d.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6436:EE_
x-ms-office365-filtering-correlation-id: a684a442-3847-4fa0-5ade-08dd19bcd7ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iWuEKTbZdqEJqwzI7ViBfeGNanJ4RyiFsvNpFryjwENHM2trmSNR13VdmyHz?=
 =?us-ascii?Q?ghzWWPqBYxDoYOTN1Rr04PeXmB16M7LvR1Cj4RornnAfDY1TUPr7/S+gckyH?=
 =?us-ascii?Q?9H2N0ciL9nPvlXet22T43fz6ddPZt8ASqpa5Uw7r/gSqC+mICTqgRl7DEd3A?=
 =?us-ascii?Q?p3H0MOpTCUIW1D7sDgNCG9sej1MDsZ694RYSN+nzKRBqCym2krT/jjOFslfS?=
 =?us-ascii?Q?zDKqZ44HS64sd27ne2Ja4my96avno20545wJHO8f93exS/lX7igPH17E1FmL?=
 =?us-ascii?Q?+893eIjoe4kSMAVLsxMv68C+Saqx9+CTEv1513sWH5gOlO9fiZRBhyLTFmNk?=
 =?us-ascii?Q?JOvkr78kKHjoTH0Z1Sge6ZvWkcN+rDJzdmxb/BvMGAqUhkCYC1LXtuhiB4ga?=
 =?us-ascii?Q?nWWNgmce9jJ+Bo34l98RR6MyYFijiLAi4jyo4fUe6+Jd3i57dD302x4iSqEa?=
 =?us-ascii?Q?LmBLENpIq9AYzqhZuyIPd55EZnwQEoraf4CFhrMAFVzfAnG8eYjg4RzQfGjH?=
 =?us-ascii?Q?Lldb+DocvGAmFJNfFbm80hO8hxFETsLVW9C3txfDz34858h/mubXAa4M+4W5?=
 =?us-ascii?Q?20PD+LPgdTMHKYU+qFc3HxWKxFfkPZpLxUu1Wk3RuaBjNtpKF7LnM9Hui7Xc?=
 =?us-ascii?Q?kFw8DtSZmPUjrBESZxCg9HgX68gFAcIq3NwO8DwJmAouw1UqtPE5JirzazsE?=
 =?us-ascii?Q?fU8OiL2naDNZtFIk/sm3VIsQ6hR+ms1tepm2BXHLoXBzt49OsgWxn8hPTheL?=
 =?us-ascii?Q?HgESc2ubTmritpoVvyIwd/jHodeuMbZOkn4j79v0SP94GJBkc0ng/GOCc9wC?=
 =?us-ascii?Q?IW0yx2MW/sNw+771TRFjcn5KSY+mwLGhKKTfHjVVkSt/UDynz+J1Hlh4qYxD?=
 =?us-ascii?Q?24OF+waFDImblodfPGOAlWtJGvBlyt55b3g7WcC+Iz3h6xSgiVb4wJ9lmI5C?=
 =?us-ascii?Q?5Os1Z0W/AsKvhFcfm56RYUtuMWuabPoKFZ4CDDr3dqzaaUp4+iT6OimhwcnJ?=
 =?us-ascii?Q?VGcRBux5ReSIE4fW+rrvZbrWok955bD5pMou8SJjyx7ayb6olOKM1cDgAxrA?=
 =?us-ascii?Q?mzqLvwu/NZxS6DBYfoUOe4WQOXSVbT5dLqKvP0pA/l1dMg9EgqMwgjjDaNOv?=
 =?us-ascii?Q?fJYx9v+Q5bj+6wS5n/tN1pdYWtm6hVxF1tTSNK/wM29gUrv7EKqbuN8ps4rr?=
 =?us-ascii?Q?q4bovy7UnSjxDQxsZXwIW2gO8jTiYHxkgxeLa9b8egj+6oVDhaIy4Ac4dFHl?=
 =?us-ascii?Q?FT83OGqUnPBXhO0EeRlnIAWGu4f3e61YZ9j0+NxZ0w8UHJ4NGc2p3ETfwCRQ?=
 =?us-ascii?Q?lta1KIAaUWinC/sEIBZ/c3AcOBosHZkNCgWod1+3jjNHdIsocgbvTfOTDIix?=
 =?us-ascii?Q?KRj85RxlZ38RzdUKFPzQ0Zu59iuAq0hI8B05mp6BdmiLJz6dVQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zMTOr6kOZ+8/IolbnyFGiGh1ATlUGOHjAbmG2LDAJGGofaB4Kb/dN7nMcRg+?=
 =?us-ascii?Q?vQuk1My342naTlFaoWXNDTs35o9si+uI0CIpThqR9FuSDdSAdtoIwER8H5HQ?=
 =?us-ascii?Q?qJXhb7Si1q37HalvL3sxQIEIT/eqpF9Ihc9u4Th4KgjmB/2VJZqMgFSaZa8+?=
 =?us-ascii?Q?aZwYoym6NrKI11tpg33TyaCWH+QJngHxYgpHc05MU9Essw8eX7X0nPWDzM54?=
 =?us-ascii?Q?Qddb4rz73d/+13BF/EiLamuehtyow6zHs0cUsZi1n2zBbpDkNfFGnsSVOygN?=
 =?us-ascii?Q?JeuEtUW2TN01dfbS0wVu2MHa5Gfqc/rlgE8d2mhAne01A13Ca0zhsAVQpyh/?=
 =?us-ascii?Q?RNnGneEOGbwwTpzQ9khhguDUk1yoBrM290xmcujboo4IBVN0nGOkdT7JS3lI?=
 =?us-ascii?Q?ZuhTMIK6eRH+wqcK29HDkhylh4yOXw6N5/zU1TkAWJQ2n4VkNHwZ8UIF65Oi?=
 =?us-ascii?Q?0l8UE2jP/SsCgFqvNf3gzxR5eoma0kUyOoRkBu/w1xpmMdzp2fyH1Lts4yR5?=
 =?us-ascii?Q?T9RyBUS5eiupXY65vFBmkXWUYvahpwjPz5tUsf6B+agIuPoxYDOSq/m62duw?=
 =?us-ascii?Q?162OIVLufj/LcTvBm2fnOktuY9n87xWv19yh8Nlr5gnEoNFXLCUUKZKxM7Fw?=
 =?us-ascii?Q?txCv6bxQgTUE89IoCv8iyLk7+6e3umU5ICPfPN3a3k6UvstjzxAQbpHfc3/3?=
 =?us-ascii?Q?zki3kiaYPOdyk9eImlgDntViMU6z9refUEC3HGPGaPSPOk8UNPRDr+A1PAMa?=
 =?us-ascii?Q?OX6OoNCveMeHYv8MijSaqeB5iH1ELKS7pg6p0fFZzYTLfOFe26AlP9M2dx6o?=
 =?us-ascii?Q?c23+s/cqJiiV0GWngJWf1Uf3qMhLL67sSPswm1TBX7yEB3dhydkdqbS2OZWn?=
 =?us-ascii?Q?azli++wQj56j/lia9WNXN3xoy9ffIt9aM5cWua1227VHxK1sr8NJoSmsHpSy?=
 =?us-ascii?Q?GEF9RFcAG1Zbu0CQQPnPZ0ghosCxvZvfvIg24NnnDU4CHZ4FBs02ncNmdO3p?=
 =?us-ascii?Q?LUJfYPIhXsW8zb6hnhmzUjaxXxAnH7cPDe1BEGVLPR8GzB9OI2kwdwGNS6xI?=
 =?us-ascii?Q?9CpsX/2K9zF7g+LrCLsdWcM6TmomAhKgYQCG5hoZAm0VCX/W7YzI4mx2tVlA?=
 =?us-ascii?Q?MdIuVzjkDawYVzaWz0Qse70PUu6J2VMHWPFlN+RAxuygxjSay/bYX7OhsR3m?=
 =?us-ascii?Q?RLfdED/7O6aBKjPMC3K6wk8eriQLpa+GK1gs8He1/eBx1fKKxZNeAdqGv1sM?=
 =?us-ascii?Q?U/cQ8dODfF32f/mJVy3gKTNXT8xLoZpoQkyMDJNklVe3nPhqXjAns3XSN3SB?=
 =?us-ascii?Q?m/D+Yf2SSc1htFekLws9Xyzd+IU7vZAj3p7Tlu9C1/JmmpBhC4ll5EhYomVl?=
 =?us-ascii?Q?ff7kD69zpYN+VGI+PsCtim0UMASFvLND7l7EnmSmICBnBDwwQfv3ZnlInty7?=
 =?us-ascii?Q?7Ha0nv7db3eiMxXP8uKQLqiWHZpuEPm9HOqTDuaUmhD/yIi9HYxHC54lDq1A?=
 =?us-ascii?Q?+rysrmrBPPx0uyCDVs3CjJWeimAHDYdLj8tDegatNXjw1Hhj4dbf4jLbI+6N?=
 =?us-ascii?Q?UVKxfHIk1pusx4qK+RV3Fe+RBb7bBYe1H435wUqZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a684a442-3847-4fa0-5ade-08dd19bcd7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:21:42.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAtpm2Lj8OjYCJhqQ4qJ4zS+dwxwAqkiToWN6PmsP0aoSnlEj8vzToOiLo8u89SjhSsBlYfVJID4ti95qPnIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
>=20
> +
> +/**
> + * struct iommu_virq_arm_smmuv3 - ARM SMMUv3 Virtual IRQ
> + *                                (IOMMU_VIRQ_TYPE_ARM_SMMUV3)
> + * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> + *
> + * StreamID field reports a virtual device ID. To receive a virtual IRQ =
for a
> + * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
> + */

similar to what's provided for iommu_hw_info_arm_smmuv3, it'd be
good to refer to a section in smmu spec for bit definitions.

> @@ -1779,33 +1779,6 @@ static int arm_smmu_handle_evt(struct
> arm_smmu_device *smmu, u64 *evt)
>  		return -EOPNOTSUPP;
>  	}
>=20
> -	if (!(evt[1] & EVTQ_1_STALL))
> -		return -EOPNOTSUPP;
> -
> -	if (evt[1] & EVTQ_1_RnW)
> -		perm |=3D IOMMU_FAULT_PERM_READ;
> -	else
> -		perm |=3D IOMMU_FAULT_PERM_WRITE;
> -
> -	if (evt[1] & EVTQ_1_InD)
> -		perm |=3D IOMMU_FAULT_PERM_EXEC;
> -
> -	if (evt[1] & EVTQ_1_PnU)
> -		perm |=3D IOMMU_FAULT_PERM_PRIV;
> -
> -	flt->type =3D IOMMU_FAULT_PAGE_REQ;
> -	flt->prm =3D (struct iommu_fault_page_request) {
> -		.flags =3D IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> -		.grpid =3D FIELD_GET(EVTQ_1_STAG, evt[1]),
> -		.perm =3D perm,
> -		.addr =3D FIELD_GET(EVTQ_2_ADDR, evt[2]),
> -	};
> -
> -	if (ssid_valid) {
> -		flt->prm.flags |=3D
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> -		flt->prm.pasid =3D FIELD_GET(EVTQ_0_SSID, evt[0]);
> -	}
> -
>  	mutex_lock(&smmu->streams_mutex);
>  	master =3D arm_smmu_find_master(smmu, sid);
>  	if (!master) {
> @@ -1813,7 +1786,40 @@ static int arm_smmu_handle_evt(struct
> arm_smmu_device *smmu, u64 *evt)
>  		goto out_unlock;
>  	}
>=20
> -	ret =3D iommu_report_device_fault(master->dev, &fault_evt);
> +	down_read(&master->vmaster_rwsem);

this lock is not required if event is EVTQ_1_STALL?

> +	if (evt[1] & EVTQ_1_STALL) {
> +		if (evt[1] & EVTQ_1_RnW)
> +			perm |=3D IOMMU_FAULT_PERM_READ;
> +		else
> +			perm |=3D IOMMU_FAULT_PERM_WRITE;
> +
> +		if (evt[1] & EVTQ_1_InD)
> +			perm |=3D IOMMU_FAULT_PERM_EXEC;
> +
> +		if (evt[1] & EVTQ_1_PnU)
> +			perm |=3D IOMMU_FAULT_PERM_PRIV;
> +
> +		flt->type =3D IOMMU_FAULT_PAGE_REQ;
> +		flt->prm =3D (struct iommu_fault_page_request){
> +			.flags =3D IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> +			.grpid =3D FIELD_GET(EVTQ_1_STAG, evt[1]),
> +			.perm =3D perm,
> +			.addr =3D FIELD_GET(EVTQ_2_ADDR, evt[2]),
> +		};
> +
> +		if (ssid_valid) {
> +			flt->prm.flags |=3D
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +			flt->prm.pasid =3D FIELD_GET(EVTQ_0_SSID, evt[0]);
> +		}
> +
> +		ret =3D iommu_report_device_fault(master->dev, &fault_evt);
> +	} else if (master->vmaster && !(evt[1] & EVTQ_1_S2)) {
> +		ret =3D arm_vmaster_report_event(master->vmaster, evt);
> +	} else {
> +		/* Unhandled events should be pinned */
> +		ret =3D -EFAULT;
> +	}
> +	up_read(&master->vmaster_rwsem);
>  out_unlock:
>  	mutex_unlock(&smmu->streams_mutex);
>  	return ret;
> --
> 2.43.0


