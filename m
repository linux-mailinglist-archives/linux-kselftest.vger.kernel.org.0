Return-Path: <linux-kselftest+bounces-20774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1809B2319
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E2D1F211DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9638156962;
	Mon, 28 Oct 2024 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Av/t7t+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF52C697;
	Mon, 28 Oct 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083656; cv=fail; b=ZOS2J9+eXKJ55ZvSN3vWx2vzd4K9P9wESGmF/XnpweFY/CbhZbYxhx93AKSQGzRuCO3QxXEf+LSu3eKBgP1+Pes2dEgqj23jkq4TZpWsoNrmgRRrGhlLDH83/piS0NDsntkELoxUIuPdlWxU5mUU6Lb/XH0OIY8zHURZEVMcwFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083656; c=relaxed/simple;
	bh=q+fp3xcXPEGzzLntXmtVG69/iCzU8zWpBwQhmrhIa3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErRIRQmDq6VqyRxjhzprpjr35UqY+c1XT4qVZHErf6CQIC9YmtE+UicEm4DWAQKdIGUmgGWcYmj/DseJsUsR5FtLzB/oTbdJjnZItVgEnt+KEkR6uGdZ6qTLTmgoAe61OjZPIeD8VwBvxunPCPuQPyhBoPoSGSokZsr+mC9g+qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Av/t7t+w; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083653; x=1761619653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q+fp3xcXPEGzzLntXmtVG69/iCzU8zWpBwQhmrhIa3U=;
  b=Av/t7t+wZv4sfnBB1xH9Kzq2HecJtL/NWvk13J5TxPRz0rzDLzz1liCH
   eznCZFmTZ9HEygZ/ynEWf+PBUd3Cx0vIaB0wJqr+sL7OOld3zccBV6MD1
   HLuzzavIOcX7jiCCepRoctlFM4Z0SIkDL67zSCoO6v8LmwakeWO9Mzq5f
   oT0PGDbI39ZLTKvTrLLrnQ/qZEH+NO1ybkTafVlSY/OBQiL/DbHE8/zHw
   icyx6y/lybFA9GkZRE1PZ4BEGp7B7GHNeL7MJj3UdYa51HzQn/2Cf4QWM
   5ccvyK4UpRSPb8AsvREtGjHEwVzthqNNlZCDt6+F7tIM5p7dS5kIU7ecM
   A==;
X-CSE-ConnectionGUID: uZtQqfDSSGa7hQGFW1bupw==
X-CSE-MsgGUID: XUSiFGW+TWCJXHvQGTpStw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29781883"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29781883"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:47:33 -0700
X-CSE-ConnectionGUID: Vc9HmK7WRl+oSMbW54kAsA==
X-CSE-MsgGUID: TBLXB3VFS2eEX4D52Xvzrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="104799903"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:47:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:47:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:47:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:47:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9g2NKUW5dwp81amxquMwjYpHPjvHtjg+y/cyWcpSb9so+v9fbCK7bhfd7OIZb9d6XRmGORLS0smyArZkUsJUPWju+wPRNbfL1pPutHo9aezwCSwsbm7NB3vNo95mxXo8B15ZQDBDLYdEiHb0wbcVfynqssdG0ZaeyTwQZkLGoc+uFKAfMtIrW4AX0SezYO5oncuMvWzah2pt3fyiAQZAducBRsv9mj48/beY8hnK2QpDl60ne1badeeKE3ttr+trKp3bjhmb+L2kGC4sI0lMTCUcNExQnLBEwQ49+Q7nzB23bXD89P/lmKRH4XsMD/jPTIT349xKtJIdWzC4JtC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+fp3xcXPEGzzLntXmtVG69/iCzU8zWpBwQhmrhIa3U=;
 b=Pg0T1V9GrovtIuUYBDbfs/a/Url3FtldbObZBJKMfKZGjn+Zcvg3M2AD1g4XG/HO9E18JwIr0GjhmRDxtI4PderSoGp6S82C59CregtHVrUe3AEN3UUkMgv5qlWk8b50hbEpS24yEdOrg4MTfUiD6uXs8oO+kIxPuTH9vkwAQKz5pNjyDrT7XdVOs/6fPBI8uYoZY5RIGWciI29yTq1fguWCd3xBfpJUcnm5KDqzJDyJxp7vwOZZ1okAmj6OX3zNuyrCWHh/erJjFEWgRH+ngk7LiQeOcd+WD5mk4npp/LMTddrukKPah1aShTLvCNKdag4Bm17ZTHFWQMkBCogMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:46:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:46:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 07/13] iommufd/selftest: Add container_of helpers
Thread-Topic: [PATCH v5 07/13] iommufd/selftest: Add container_of helpers
Thread-Index: AQHbJzisH4eAHPXZxUOEysJcqlfZSrKbeMSw
Date: Mon, 28 Oct 2024 02:46:56 +0000
Message-ID: <BN9PR11MB527656D58F49B609137A271B8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <53484f80a671edcf337e93b2e2292f318eefb540.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <53484f80a671edcf337e93b2e2292f318eefb540.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: 5351c788-60c1-44ef-8c5b-08dcf6fac964
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?V4boVHmj5Qnv3Lh3bj7bK/B1ZOhEbHdaNaOLyzN01oeJybNS7Qa1A4b3BsIj?=
 =?us-ascii?Q?Z1vubysQH/gSe4gB7uL2RkWve/hruQal53/bgBND8rLy40o0Rm+EcDMtbcvM?=
 =?us-ascii?Q?73lhTaCiXSmR5Pll6Zyce8ZtPIbuU3e+YOv1DzPaZGEXV2+32UDs2X7CL3in?=
 =?us-ascii?Q?R0ZzIzjdBWrUjXHyFPB38b2C/+H1+rtWLBtEYyR4cuGs00ikNO3+DKRVdUFW?=
 =?us-ascii?Q?P83uESTDUgfZuA04y3tBnDRAkCHUYd+GhGsGV12fCzLP8F8aiHHynBm/HcSp?=
 =?us-ascii?Q?Mkflh8AxY27qpl5epWb8JZ/E2cVrkZCF6bvabtbI9BIq/mtKmB6qPIP9TgCW?=
 =?us-ascii?Q?/llNI6wdkZ49jkzNHbXHDS7ptLrHHvdRVm6xNBavoR25686xxtZbsk5kmygS?=
 =?us-ascii?Q?q1LJ3AP+qGqGzI2Uldo3481ibBf8/G4b4qQbdN88uW1K7qz4E2DVCjnFfBIx?=
 =?us-ascii?Q?aRw1SLwyaUJ2Awyh9EwO6wSpxUtZnyDtaZmTFJ4rMOHZr6NcGp4vyVeArM6R?=
 =?us-ascii?Q?cJPk0ZaDpc3KXjKhXE3oEuWtZS7ULS0izcdkFQ6iQt50eMWHZ0LE0kL11jRF?=
 =?us-ascii?Q?kVZf2fVmdW75lhFD+0J4MTRElPQae5tVrxF67kr4ZQDzL0jTSFY+a9Sc0+oM?=
 =?us-ascii?Q?Fxl734/HVJ86qOcFIa2M5odOht+hSyzO+wjyWr5NrmEglTefd3Igr2ZfaY/d?=
 =?us-ascii?Q?LBDsqWF0z9yyZzkGb3kObqnu0xXxx/IUdUKyR3JoiNeN+AS2KO9qBLyOhoJt?=
 =?us-ascii?Q?acE/gZ9vVTrfVWzx82ojOeH42sNyTJyCTKdlenC5jVNc+Nh1OOqcsYuiZAPd?=
 =?us-ascii?Q?nkUhoLXJGNzCrZzr1chVgVEcHuHDTrT1bsG9LQXz0rK3oBgIOZDQTVgozSz2?=
 =?us-ascii?Q?tb7QAXkQFfQUzQhGdRRwhjKP5SjeoYR2e4J1+Vuzrt9piY8UtSGkshNYH1tR?=
 =?us-ascii?Q?jddo7HZXfqK4NSlUsjvYd7cd6fjL/Inh1rPbgJsW4T0gEvreKh1B9g94t77m?=
 =?us-ascii?Q?06xLapoj5eQOLvQH0dpZ9bOMCtt5gD6SNdlXZepayekEgq30UJeY2w/MqEYM?=
 =?us-ascii?Q?uinPzRtMazxTUzDxERqzfp1y1/f/puAsUBepo0Y7hdZ6UG6Wf5mJrLP2ycax?=
 =?us-ascii?Q?GniLd2mT8BaGXYJ4+mHi2In5HR9bpTuR2nEniKmCV57PqdXZ49hAVl+Vq8/t?=
 =?us-ascii?Q?ni4cja4Rt4cwefrWSVd5apevHKldNfm/ZU9mwn+FiPN3JCuS751xtqLuqX5c?=
 =?us-ascii?Q?/fZ88IjuesEGn3jBy0dybFjjj2K6+pok8gkTNRxz8zfB4nwtM+O2nenk8Uff?=
 =?us-ascii?Q?9WJbGGtxTmw3dFSrZg4ziipc41SzYWV2kAObq6fo+tJHnMDYbE7HUVhxWlwN?=
 =?us-ascii?Q?rOQsXpw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BN7EIiDyRmU2zUJ74E2Lt9OfyDWMK13uLyV18gl8NxcMsiMe9iwe/b+ot3qr?=
 =?us-ascii?Q?Z0owXJK8VAQa99KQ/7Cnp+5R7dr5obv+GqEZOm/DdqjuxaYfZoHL7I02rRuR?=
 =?us-ascii?Q?bVAvPCvOCJMQb//nDnsw10Wf1eD0kYQOgY14A8m/blAbYXIFf6GFsHc4DFk9?=
 =?us-ascii?Q?+4L5OoHYVf1cZLvjNYOUklhpEC4OaIUrNN+5iTm+piyphSvwzaWuZEn1R7sE?=
 =?us-ascii?Q?yBBlhenMzoU1R5MbsAxK8g3yqg4bPfTNjTZRLbh16ubypVY4CfopFk+jSCQP?=
 =?us-ascii?Q?E/OnQyoqTbaFb4k3a82Apl62jWAV1wwNCio6ctaqmD1Cj+RRmntKhwmzP5cy?=
 =?us-ascii?Q?Z5EZIlVHiuxyJmfxZxCsVCSUFcG3crFQGGqIxK+X/QyupsksvTmUxQo9IFwP?=
 =?us-ascii?Q?rnxy8+GwPsAGwiku8+hdgaX7f9mXUOfELm5y8FbzBJDpMW487Kq9hzg6YMZS?=
 =?us-ascii?Q?hRloyR2rKfmE4u4x3BQRoV4zgpwHMsbKnkNPwogpC3WcE02U9IPYZ9mh6Cvw?=
 =?us-ascii?Q?9WXVevEIUDNomBwe75vjNp4ZxBuMNZHJtWC9IMsw+Chal8Z7dvNeSs8M409z?=
 =?us-ascii?Q?E89eC7LgvNS56XypfERGYdZ3c+b188cnLepOmxGNlYtVIkPXWUu4802hmdm2?=
 =?us-ascii?Q?qZV4Mu3IFMIWrFiV2j3rB9tKRWvAOTFR6OZRgHWjA6R/caV8aRq6mXzEQsDo?=
 =?us-ascii?Q?Ks91QIfh3zW1I323g86lzyqB/t6xo7ZtirUlPXtGps+ZNoYescKws5jA9vnN?=
 =?us-ascii?Q?6RH2M1j7IKfM2D6JT+1XDM/KQtVlIO4JhC4SNZkCzfmrZ8OYO2CbgMfSPhUp?=
 =?us-ascii?Q?rZgib1oWLby/rDAe8MZyeCX/3Z9FeMLizaTi1zcjrHPyBN39iPA1cRCn27AF?=
 =?us-ascii?Q?Wr6Wd5TIFUQlpLsS+QgsDxrEanEv9KhoZ3TfVeZZntcJTbaVrzsqRqKzuXdD?=
 =?us-ascii?Q?9d8xG5xnx5fAg7rEFlhJEaWdmOpeo6tIo+ByYuw6KXJUwz2wy2M8R05W3krb?=
 =?us-ascii?Q?XrN4+0eoZIO8PnqFsNXhXZS7pU/2RC0QQiP7+ZQXQhrr62fFIRLHWbuvFo0k?=
 =?us-ascii?Q?/Xuzla+dJcPCU51INZD/r5kEelHl4gwAGEUu5PPUs5274+lFRLlaS2E8bx2Y?=
 =?us-ascii?Q?PshGCXwb6sLDn9y1H4GPpiLL6n8bzAcPycR1hfP/hIYiSozh57xHrDoAIEMa?=
 =?us-ascii?Q?NE6Ag/0hpT8+L4NFpg73foFYZkP2GrSLUhR9W70Aw+5u+DY9eiTretWoS9G9?=
 =?us-ascii?Q?Ob46And57rufU1MICSw/OSmFjAhJ/DM2B7kJGER2vDTI5guUGyWstK9IN7Ng?=
 =?us-ascii?Q?OnzVX6SPNTFGj4BRCt4ibQnbfHJhphWp6HrIvxIjh1fB9HPHe7T8OvcTdyvp?=
 =?us-ascii?Q?lxhp3ypzzZTvL+R2/qJazvMAN9DWborgn2FVkvgjWjxBjmvH8AYNypJtVBCI?=
 =?us-ascii?Q?NAbNbIsue8NtAMW/POkdVXOg3Y4W82Gv2hZVISL+SpSp6CuKUYvPYFEYcmXT?=
 =?us-ascii?Q?waXh/UqsieZGfjFZJ1W1XNeAN9GzyuaLeJQ69IsY3bZRsIQ3uRdSggnpcWXq?=
 =?us-ascii?Q?RjqIKnySAnybf/dvKMcW/PHwMMGGtGzYJ8rPOrpH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5351c788-60c1-44ef-8c5b-08dcf6fac964
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:46:56.0210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2CmssugDEPYFwT8B4Ns5L+XXAYPSEpNrcuG/QsKARUP7/Ds79LrG67ei0ZVnoleVi3B810/DArfjjYxzPWAEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> Use these inline helpers to shorten those container_of lines.
>=20
> Note that one of them goes back and forth between iommu_domain and
> mock_iommu_domain, which isn't necessary. So drop its container_of.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

