Return-Path: <linux-kselftest+bounces-17717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA9974B19
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1980C1C23EB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E47E583;
	Wed, 11 Sep 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7Yqb7BZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98D78685;
	Wed, 11 Sep 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039138; cv=fail; b=DkFvH/C/PG3Hwier6V8Qt9z69QtKLgWnK+ZZPGYNOrUoue2L6aEFIfEimZP3aUzSerycmf9XzUNGu5QNuq2lJQHph2IvL323nTxNy2bgOfWGDPhXgzPO59X85SIJY36in/KY/luXxeTuAiGHoRCZo77BiszmriiHpb8DbLVsmnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039138; c=relaxed/simple;
	bh=2/Trgyf9p/QYcxDdOUBF3XdiCNeJ9qN7gTJqJyN+gJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+y2Oe0lKRcIyXNzgNI6FpQ1DF9juYZEnG6RkUvlrpEzZXdKFaOG+A5U2M1XimS9poGX2XDG9eZOOV9GBhTbU8s+itOrSjLIMFOiqE0Ha8QuAaqx6dsiR2u26UTTGtXs1y4KVgZM8puRBGnYQKQWS4qiwa++Qb6JMxkgqAG3554=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7Yqb7BZ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726039137; x=1757575137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/Trgyf9p/QYcxDdOUBF3XdiCNeJ9qN7gTJqJyN+gJY=;
  b=B7Yqb7BZw9EXWthME04+N4/Vt1gOXCx+CYdSZznEf4P17S41Fqo785Y0
   6dk8/H+bws9dZuhm8MGWzqR85+EStSMNsXd/VI1hsawCt5A4AW28b6I56
   QWNy3JkVuBTQwxmYKe4eQw6T0JBvp1iqB2bIUEAl0chFnYYpegsr4Nuyo
   4e4UY1qEWE+rEStri6xN1i/xdPsJSD8KHrEtHVKKrln/nWhZ2akVElyXv
   +Ms/9Le9bPTF0AYuVqmBB1b95at8a1Bx9BTtOR9dPORQhtanGYNqFtqXh
   Qt4eg/5bKUpEHntUU26nVJqqJ3MymkHcZq9M9TTOdQeqPlezoHAijdVUo
   w==;
X-CSE-ConnectionGUID: y4nYNnj5RFKHP8dugW1boA==
X-CSE-MsgGUID: zbMitVo1QjeYhF4x7QwnKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="27741564"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="27741564"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 00:18:56 -0700
X-CSE-ConnectionGUID: 1cUo2SB0S1C+4eila5pJoA==
X-CSE-MsgGUID: KiHyzNtMT4yf/u+74hp5aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67562147"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 00:18:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 00:18:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 00:18:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 00:18:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 00:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkz1Vp8eoESg8e0G5hMJq/b8/Kj3bPcTJo1uO8u9gsh7zpYq8b70LIWwBchSS3tchNwFd/obPZJ6W6cTNK7vW5J9LFQI1XilnP+FOI56F9OSKOi6GF7D5TQLeqsv68iIYGY+WjpKFm9/ksWvih5R2JJLxPYppUrJoGtUlaDDdrPbAUfNduyH23jdlLq8V/bA6gQUWjvFE6E0yz+HCkq7YJxwdS6LLzrqlpWou+1M+XeD4XYiaqQsoehI6Lkb/UgBhLqlsSsX4ni8k7cyjt9NXaRJnF7AzEHhPzJxIIC2/NhNuxDgq7wJ8u0zsn3zlfzNiuvqpDEJr+isTYgKL9YEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/Trgyf9p/QYcxDdOUBF3XdiCNeJ9qN7gTJqJyN+gJY=;
 b=qzcevnhjOjWS/8o/kK00yiMQS4bt64rdKVYYqXfHgQ4FS0Nfga3BJIzRDhSZRij512ytW8n3XpsMH9zRzjMaPQ8mcE8l0oNaGR5jjy208R8niiPktM+VyytiE0HzcV3FlCzsUG+f/5/g15qRpBJmEy7ClBfOsRXZ8ZDrWw2gOWWBG32vd03HB4dDRk+GNDEP8FkyNvzr14W+Lxe6PSt6iVfttptFvc5OFMuAwKmXIcoI6kbxpbn4pivFOnSCz4Als/7qqjgTaUU+TCD36FR2UnxxufwHTx9sJX2udKLM2o7sZpuIxYPrltZITr2E+cAV/TjR7ThAecv/i/kVjKB3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 07:18:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 07:18:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Thread-Topic: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Thread-Index: AQHa+KLxhE3fl2HTskGswxeJI90kSLJJaSKAgAAaOoCAAAGWAIAAKj8AgAiDehCAAA/KAIAAAdmw
Date: Wed, 11 Sep 2024 07:18:52 +0000
Message-ID: <BN9PR11MB5276EFD18580E4ED3009BB478C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com> <ZtnsaWgeuuy7+cJG@nvidia.com>
 <20240905174326.GW1358970@nvidia.com> <ZtoRLlk3hLlP1c9Y@nvidia.com>
 <BL1PR11MB527144A489C069EAB8FB99578C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFCtKoE/xbf6i4y@nvidia.com>
In-Reply-To: <ZuFCtKoE/xbf6i4y@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6681:EE_
x-ms-office365-filtering-correlation-id: ebebebff-b6b1-4bd5-ec25-08dcd231fd6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?leVCU8pqBPEau+lubOApZzeng7HeNz7BNpHr42uI86V7TziQpMu/50xzY3Ew?=
 =?us-ascii?Q?mGaYQ1Mqj7I/OZHCDyyTeURfMgvAWnoTpljXMwvOnOgwL70qUKSKiNEyNtj4?=
 =?us-ascii?Q?i2EtOFCfZPPywKU85KdgZVBSuQM/EF9oals8CAmBtPRkip95SwkN/I9q+KXB?=
 =?us-ascii?Q?pHQEVDs89fC92iKMGsuAIe5xLhaVa7gFYg3NHTNeiWOv04QFikxpO797czKO?=
 =?us-ascii?Q?MKoVyJYyR9Y2lQu++2J6bqoQqwPyJMPc98rVL7IrxDwFLMTe7ruE6O7CO2Xo?=
 =?us-ascii?Q?Sam1oLltPs+Wjpyi2OGyUdQLpgQs/6+krmuH6Ch8pDPbrvcS8s5rrj/0iovE?=
 =?us-ascii?Q?0eFlr0sSpvCBWHDROyFrScfRuNNILLUk9FpsZQOU+g27yQlsfOox5ilPzJnm?=
 =?us-ascii?Q?zcllvR2GAOCTzo7vA2NjwyV9vd7j+r51KFiJgqW+K5jHuLkROBE9K6We5byW?=
 =?us-ascii?Q?f8Gf7KSFy7Hlt9TtAxkhswNDreHdi+3zP/nKHxQo5fg5VFFcTpOwGsBGmkWh?=
 =?us-ascii?Q?Hnz0sRb9ZGXlX9pzhJfDzTEQbOQj8EaPb2v7+aHYvnbtFyBZgQQ0L4vfBcmM?=
 =?us-ascii?Q?+R7EyDLNOSVIeNBH5AVTWfrpmjP/ZPm8q3lzeyYWrEOsZttrqiehGMdZlvEw?=
 =?us-ascii?Q?2tZFoMm98yjMVnJp+hGh0nuO/C42Fb6ZPHLCJQgasYdwROU6VH61+iz8hmpe?=
 =?us-ascii?Q?+gvcBHetkGg3RwBaXYo4D8xOC5SUQeEu0T7HhVOFBYU+SRwlGFpA4qg0j6Ry?=
 =?us-ascii?Q?d0JRzdVa1ynEN8xOelLfBwIA71UYCBYkymQ0VN7PBc2Fj0MA7UYTmfdYe5/V?=
 =?us-ascii?Q?AxiM3tuTsk1QOIVNU1b/+gVVBGEg0B6t5HL+u/Io2Qg2myQ+pPA1vDKuhkcE?=
 =?us-ascii?Q?55BZanCltwu/CyWpPR2py25eavJuK1G66UgRSFKXb+HxI2F/PliWneZ4d4zl?=
 =?us-ascii?Q?O7U9o5GFXsYTBkuZFGtgfIlsXrFyBTG1CgTirHj9fPOfaJ0alkcmaoy3QghH?=
 =?us-ascii?Q?az3QpTqii+IUIi0RwJzkt7xYsxpf/ewGD9RrG6qxLHgN2IDeQ2taiadHVgKi?=
 =?us-ascii?Q?B+iNDAiL2SGuatUzosGdYiTPn41DeF1A99+JC8WgD9daUBSBYaDpmUkYjO1x?=
 =?us-ascii?Q?4UNIOVklQb6ngBSa1KlFgFEbkiJ04SPck5wWLasku02sxtpBvnEOOJsm5oaj?=
 =?us-ascii?Q?8GNGfJWzTyccsvDH4ggeypGIFe7K3lSqy46WFgc1ljAF3FYF8zqNECXKeo7X?=
 =?us-ascii?Q?NGq8rAM4OWToFdkaLjIcGDHcXRZQtLBVOJESoMd49mPSE2EngZqFgLQZtzXO?=
 =?us-ascii?Q?7DpwWn1AL4JaJW8pIQS1J1gfEzrtcnAg53yyK4ExPZvBRh4WSENAxWcWKUTy?=
 =?us-ascii?Q?0VYFkrGjtJ24AkpW1vsfFUFZQr6WPJOaJa8jiMx05eej4DiYDg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DVToE8sm3cSRXpJfx+xQGoEm404HYqmcm+wFt7211PDeJ9s8Cv0B+BiCswqu?=
 =?us-ascii?Q?/DYjcoFmDOtJjuSHUi4bIqssIEfTHYZ7rnUEF1dIJ3Z8bxyv4MuHfC6NiU32?=
 =?us-ascii?Q?8Y+H5CpalnBJja67vlmpVmiRNzsb57DMnPUq87pNOKvCC5fPqQBNqMvpqPv5?=
 =?us-ascii?Q?YndM+9QxGjXRmX+IBbS3fgAaZ6SZSKZQsvnlyDPqVLsZS27AaxC0v05y20FG?=
 =?us-ascii?Q?7vEGJZarOxHuNBoLDH7sRNLJ6mQDKycHh1MCTIe7QFpTdgQfxHCx/aDKtYlz?=
 =?us-ascii?Q?KXrqgMlD3xDK1j4q0XKHXvoildmq7gph77LjUHBHktGF0W9JPJeQZmirnrHa?=
 =?us-ascii?Q?rY9gTdGELA0mQSR9cJ8dTgTsw1hkJqX0DT1P3oP/qYkenx64nbwa3u6xBMZ6?=
 =?us-ascii?Q?29fFqgCU//Yeqmb2zhMPxYPghQi3yUKVkwmpym3/vG6ghVL2UhPJXUMJTPmi?=
 =?us-ascii?Q?r3T9AE2NUO++W95gQhp+VXTC/u12z6EOkkuVbl8U5XkKRtQhFqY26jZBjidn?=
 =?us-ascii?Q?hwIXTCJuHuIzf8FS4AD45fDsbx5t7SIVg8BmzzLGLJ5ly4yRyzM/FBi7Tm5f?=
 =?us-ascii?Q?Yp7/uucTkkIEkspgiGUef0ijhaDtE9Sc9/zy7VBeBtDnZyf7tDaHlNsxnp7K?=
 =?us-ascii?Q?WVGoS5fWyAmJPo1Ztyq/v3WZgf8CRWsSBMMOaP5utjo8bueOqn4G21nnuiix?=
 =?us-ascii?Q?v7KZkEugvBgcViuxISAJK3k+0wAuBOID0DSScMV9sXkpA1KQOrjMfJsO3WwO?=
 =?us-ascii?Q?jMuJuK8i7HcAj5xrmMBTiLswTdOiXkuTBOaWdYvhEUXotfuRppqDJ3Xo2zJE?=
 =?us-ascii?Q?hG9VzbRi/H7DTg43DxUo6pPuovZtfUBE1Nx8a28SMO3BpyRwzNOSnmuUqUrG?=
 =?us-ascii?Q?UupvtjpA75JE6o3tHePvDNjALFTGfbXiZ8gLTtsr3ESXJBPymacZRD4qOPmD?=
 =?us-ascii?Q?FgOWyRxtKHHXFj4AQLws163DV7zJBGTUWo0awACOx5MYhwKXmk2F1nZCKmMV?=
 =?us-ascii?Q?5TbxsefepQUFpVAhT3Z88UeIVVg6r/nJ0kgMcIHBAe4JSoESrhDGHwRN+mog?=
 =?us-ascii?Q?zY2K98/N09tQEwPdyyC68UwT0Ow0QSK6VyOQCmo83yY+zhyDqRONq7d2+rAY?=
 =?us-ascii?Q?/UIwaYxn6u6OKcsEKuTCpeySNII1Jd9Ffc7w9Y+04j+Bty6hGnzFvOB8YCmO?=
 =?us-ascii?Q?2wAt95Y/FFBptTDV60njYnSPtgl9bQqSxXZf5hw27mZWj0qRzkbQKqzdNCX4?=
 =?us-ascii?Q?8zscmnKaXZJRLDgcNVZZkymd0GiscPVM8nCUyrTLUaDcHJWggRry55GtSd5O?=
 =?us-ascii?Q?uXQTSaQrezDfCgvPTfQCryHNxMAlbRTl1oAdxC/tXVXKmb7TQuuXs5i3BP7u?=
 =?us-ascii?Q?lBp9k0/Awkn0chyGmR0nSYd8Zv2eFO9/LU0z4PoDq3pVjHwAxsZRp3z4ES50?=
 =?us-ascii?Q?rK++GU0M99HC1GkwcJb2dFisKqmkJUtTRnHhge0jJqE6NATjbaaO7tXYULbp?=
 =?us-ascii?Q?5nqS5FsczTMIdnLt+9Bh8PPOMZ2zVIN7WMnbXWYEWBbh+QTtctT/l5hwOi3P?=
 =?us-ascii?Q?xkDhBxOzFoPJi3W1qwBTvNfPsBsZNt9jCtADHmzv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebebebff-b6b1-4bd5-ec25-08dcd231fd6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 07:18:52.6762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfSLEVV9g1Dy2nGolh41fT/0jgTiNklbqcAugTVBv5NCRRDbVzR+MYy/szl/6J+4mXDZVTSr1+z4zMqmp7mNTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 11, 2024 3:12 PM
>=20
> On Wed, Sep 11, 2024 at 06:19:10AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, September 6, 2024 4:15 AM
> > >
> > > On Thu, Sep 05, 2024 at 02:43:26PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Sep 05, 2024 at 10:37:45AM -0700, Nicolin Chen wrote:
> > > > > That being said, if we have a clear picture that in the long term
> > > > > we would extend it to hold more information, I think it could be
> > > > > a smart move.
> > > > >
> > > > > Perhaps virtual device can have its own "attach" to vIOMMU? Or
> > > > > would you still prefer attaching via proxy hwpt_nested?
> > > >
> > > > I was thinking just creating it against a vIOMMU is an effective
> > > > "attach" and the virtual device is permanently tied to the vIOMMU a=
t
> > > > creation time.
> > >
> > > Ah, right! The create is per-viommu, so it's being attached.
> > >
> >
> > presumably we also need check compatibility between the idev
> > which the virtual device is created against and the stage-2 pgtable,
> > as a normal attach required?
>=20
> If that's required, it can be a part of "create virtual device",
> where idev and viommu (holding s2 hwpt) would be all available?
>=20

yes

