Return-Path: <linux-kselftest+bounces-32554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2DAAD7E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 09:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A61B60122
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E6219EB6;
	Wed,  7 May 2025 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7xBUg2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A862165E9;
	Wed,  7 May 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602769; cv=fail; b=Tojcc4V/QmznP/oD3lFWtjOPsi7aQr2ua+keSPj3PyHEjspf4dtVx1EDFPIzBR72VFXKPS3s8VgYeXxMTSCj8IllVFGFLow4oY19qpn9nychrYw56yILdEW4P7nRqG43yC0qGVz72ngarxOB7F3ENB6KiUsVuoT12d9ypYsfM6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602769; c=relaxed/simple;
	bh=inNimk9soO3x8lm0sb40SwcX2iuQyDU/EMYPTEdiyY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jdEzhHk+NTn3fjTyNVc0hYGrKlbgeIvVBVIfOUa1rKHQuDKDw/tEuihBwVzG42jSwcWzuPbsLURDAZSpmnSTuf94u6JJo/B0UTWd/BZNWOC2uphzeFdVtgfNqOLM9OHywGRGZouGq7orK9TW05oRBQNWvlf2WWVy+h4g9TIoMt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7xBUg2+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602768; x=1778138768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=inNimk9soO3x8lm0sb40SwcX2iuQyDU/EMYPTEdiyY0=;
  b=X7xBUg2+vjCPso/j6A2xhc59DdgY51TY4saXD4iilp9+6+QlRQRRk01+
   paja78I5GkiKppthDQLqQiZjsbaC0U0pRildsKMydGIdBLfoE8/jnGoOH
   XCSz5k/tY2XtRWW9CFBlwpchxQ7dnwPb5Ta05RgQTbOX955RuloYdSwUY
   p4kBB18vk1WXz8iSX/0MPTwV9bPK5lW8k1K4kmLEtCszZCmGWFGAakBl5
   GdMsLxf9qP8xuMH2Z+xoYuUQzyWSx3ssrcjzvqFujWK6LDPzdqaqTpTMU
   TyAqLzJWgPETqv3I/I5MJhgY/J3X36Qg9/qFX8ZYOyvPegGYsEKaQ+uWJ
   g==;
X-CSE-ConnectionGUID: 2DjkWITXS1mMbTF7wZsVYg==
X-CSE-MsgGUID: hXReiOVET0OMc9ISNUlb1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47564681"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47564681"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:26:06 -0700
X-CSE-ConnectionGUID: ONSrJwpQTV+hFeTYRsmuIg==
X-CSE-MsgGUID: 7ykvMbHFTOqxhOTvKxpQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140985376"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:26:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:26:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:26:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qur0g6GziJjnFLUtk5NuyK373haPUmWUXn0pOjnTAJWBsrFv+xdLWxkwH3Jqu62zEYp4eYiPVk6V+gk5ajNISOhkaIqsJouNlkCbrzuN1Kjx2NoqeYQNNboKEXW8SGPwod7MVrXpbv+xcCe0fXOU5G0hMJ4h6TcsMrg+h/rTji+PQ+KN9yhLHWerpx25xY3pNDYq70k3cTloFOhz4PMgkPzC7eQQb5gOW7yw9t9qBhaD7wGpOAxOV4ySUx/xzE0SbaMzu269ldumZof6E7KsA6pbgHKkDYM77D4v0ngOUtcOCZlwUKC4XqCElPiCOvT1GpIeFBSVJ/Q6WrfA9qHLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRXg9uEJmxg5rCWDsobFVOag0j0/tPfEYQoo/AeLDws=;
 b=puINF+GPNk/sTAP4NBR7j+Xc7j4DuV9bafhkdMwx6B/vF30cLTpILJqg6R89i+9ZEqZWzMhQu+RG+bOpqwqV76ALqoxvAV03X3/jMYXqlY0fTTuAIPZ9aibqWGcqUCFiBSnLJkPzk+p/DzFRRW9GUvnsyfDtxpFRZrbTzJWka2/hyAv4btPQNfsCTlSW2S7Krnnm3S5z7p8uPJ6xMm5VYwH8j5psWLPigslgwf2SYNLrGWM637I8z+PYwW5BdOqh+9W/Or2QtMtLkmY8oNMJbZ9B9LHl/zhhFHa+jXbHLBrAAc9MYHwumG8ruVtQDShYxysWK6XkxvoXDHiueDo8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 07:25:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 07:25:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: Vasant Hegde <vasant.hegde@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Thread-Topic: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Thread-Index: AQHbtnBgWiXEiZpdnkyUfZOQGgZNUrO5ALyAgACDQoCAAJ/GAIAAE+cAgAA8wwCAAHMKgIAKfNsggAC1RQCAALuRcA==
Date: Wed, 7 May 2025 07:25:41 +0000
Message-ID: <BN9PR11MB527651D1ED8E6CA4677FD7678C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
 <BN9PR11MB5276A00FDB2685B394FB9D4D8C892@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aBptQO9VBnO2AG9V@nvidia.com>
In-Reply-To: <aBptQO9VBnO2AG9V@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5044:EE_
x-ms-office365-filtering-correlation-id: 3e4188b1-fdaa-4af0-ac7e-08dd8d385f2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rDpFJoXpM9SdmMZPRaCHFd04iSovqi/e0egck7DYvlspVukDmuOOqGkTiYzD?=
 =?us-ascii?Q?lLEc7FI1bajH4tZMRDvMTA7eJUx7RYRCR82bHkg80W2pURoCAUuibD4EdcN2?=
 =?us-ascii?Q?9Nqm72lbdqAKXyvFMcK6wFVZNpcrod4hCxvbsH50K1beQUCBxtG+vYFC3Neg?=
 =?us-ascii?Q?iMZpVDuLvosFJBk4doACEAMZLFLlRHRIq3ZPKstMpbZr82K7Hrn+5WL3GzFi?=
 =?us-ascii?Q?lZZpfx4KX8EDDAKSvfMe/9QuO77YpdouCKGBBc7MhgxDRbZGzSvOyA/0BviQ?=
 =?us-ascii?Q?MLzEI/2I0MTi1iwQm6A9xnIe3D/DjPY5cRTybi0Ip/wyxAQL4v/yvI7CNEpp?=
 =?us-ascii?Q?n6iD9P0BV0JRJ3pxD5k3ATr/mnYkrEM+yIbj6h/wqGzQG4B25ygJ1Zjm2gbn?=
 =?us-ascii?Q?H9WB6u2q3RCfOjoMKWgShSPIArnZsGkLIzssLIqwS29W6oXowtWuuD33jTmW?=
 =?us-ascii?Q?/gGCFfk3iX83mP9I89uAtzZHRyRZF3hD+vjKsH5++VYBfDMdEMifFb4KuMhe?=
 =?us-ascii?Q?wbdVrF83k2ej1mbGTp0CAzsX/1wfZaOBeEUM5tXuJGgz+c9XdAFt0LxH192g?=
 =?us-ascii?Q?Yu9U998k2LRZtY65zMMeg9VSe1NZAOx6XKoQliGUjvsauglsxHa0wJ45B6wp?=
 =?us-ascii?Q?l4E4rLAmGeJuCh5ZLv2R19teM52I/g8D9oxzyGNtYyDwukxiFYEMegXv+kXI?=
 =?us-ascii?Q?/c9/oQYA4NAHXX9icAzgX8XAvmH7FdTl3VUf0OeNpnKsaQ5TO581LBYjYbDr?=
 =?us-ascii?Q?lcJgbLPlioXDUc0TXkOVUlCIO9bPJXnafhNBiROfKqK5zR/+cKfPM9BaACHt?=
 =?us-ascii?Q?fwGVJOFsnHl2OWTHDQfeQ4spEWNWCF6rvRfmv2lsF3h3jVwbVgI9mhJaeqen?=
 =?us-ascii?Q?pLvyOukA2pPPE9MTAHSN0npLDiWRx2/lO1NPvph37vOLrEn7LfVJbclxoe2m?=
 =?us-ascii?Q?KOpCzL/tCps9zga+wQD4LRrjCHxa9QjznvIFjDeIRjfVVEAKF64vKJYUQm38?=
 =?us-ascii?Q?BAtkxmmVKP3psUOGv2JZ40RrcKx5sxKo+A+IT6FGftIP7FKoTf8POMa2cIrV?=
 =?us-ascii?Q?pGiJukLfBdQV+lTUpruI5nZapmn+3YBLI9KQb/E1XYuf7obd4wQRXoqR9oJh?=
 =?us-ascii?Q?AVVYlBDdmL/lMJxKeFji93cbF18XuXCS0w4Vd7jjLuQxgRfXMdtR72IMH1BX?=
 =?us-ascii?Q?Xq/h7bCmzLi+AJfOZv1E5ATcDQ4D0Z7ddgRx1M03b3L9E+y0f9TT7QvGFxdP?=
 =?us-ascii?Q?lt2z4vQEvnlnubh0WmqP2soZkzHb402t0LCxENhGwhmzFcgUhPm381sE0GQC?=
 =?us-ascii?Q?g14Vwxj3Xqab5kPl6H9zRz0CJ4EuYnpQp2cx+/bKduhO7wkdHzV0I7yltDQL?=
 =?us-ascii?Q?OSpN03UVAU994ubYebEAnMzR9qsVOHOZLWEEw+rhgMIbz2iKHPzTFyIXHmBV?=
 =?us-ascii?Q?byVYu3jFfvNGew8jg3l8wpsAQOHIhCJhbrlilPEQkqGqSj8v/ihRgkOvmHB7?=
 =?us-ascii?Q?KokzZo5tPQ3Qmm0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cYvxTrofgL5uBpsaG33gHRfLPqBI7VDOzwraknlC2Fx8b2U+hThLeOL/5OL1?=
 =?us-ascii?Q?x/IMexCyd8A+zr1LcHSy86bi+Fi6k26BVpDROFW8w6nLwG4XOSoBJR7wG57o?=
 =?us-ascii?Q?R4kiEQ+qWvie1BuXMt18cS9LCEufycgX1Kg9uqpdHs3NpQUzs1OdSCe9mPlY?=
 =?us-ascii?Q?/rJI5aeDktsyLKUvIECrZBC+SaSEC9zNzphiWHRLUD8jP4vXLRRtPovvmO9y?=
 =?us-ascii?Q?23DQxo8tGr2JsBI5vm6G4Jd8O1LAIs5uhoqhEobDdAKmCDGGXmkLfvo6NFXF?=
 =?us-ascii?Q?FDrKNbnMZ5MqIJhBpkPIFcHARU2JCeoPgW3TwgMDP9pA1T9Y/EU/aseyMkHR?=
 =?us-ascii?Q?BjtR/A9gmTnWoNLTiZ9aepv0b4kx4jnF4NWbt8igWagpk13PL5/ch5gVl0bN?=
 =?us-ascii?Q?edgYA9PrNuO/s7v+egfJXf9Ntn0o1JZ3WCCchQ4uwwKNz+6MUyL26muQPlyd?=
 =?us-ascii?Q?u2pwU0rlqGlHTcO0+cWq3wtIA9ozdQVl/jaRv/9RRkW3Y/fkgI0HxcJX+q04?=
 =?us-ascii?Q?/p8rj0C/JwlETyZwwCllMfZolc8L39D17FZYDdhgWdTdswCMjmgVbRDBnFB4?=
 =?us-ascii?Q?O6CIDDZCrUn64jojPaWYGW1nrKJGi5Du8LyHqXsDyv8qUE3UXASfHzh6NB7J?=
 =?us-ascii?Q?hA13MclK31fZpEDrkxV0CAY5joRgqCliZ6EuDqC7mL5gAtAJTUN4s96iDKcy?=
 =?us-ascii?Q?QGjEnLLp9UOUsE47HD0QiDadgWqk9USS0SJ2W5RWm4lMSJp1bxn4guXxWnGZ?=
 =?us-ascii?Q?ymgYLSFF9FuqduoNBS0T2Zx0iF4ybMwXSZuqAM+LNlrjA4HclPTvk/3tEyRe?=
 =?us-ascii?Q?Wda42axmUdsy+Cjl2ouIFOg7Kk7offWUbNq3NqgPNcLH84oCmI24AkOKxVgh?=
 =?us-ascii?Q?c8Llm1H1LXtEmgFEtb2mcNNjodkcAURJRWVTdWDn+/dFo5Z9wLF/23o2ARmZ?=
 =?us-ascii?Q?WZi+E0ovP6vlaFa/9OBdKmhTdtVQAmHgWTd4PcSceCtkh0M88pKKAGiFC+2/?=
 =?us-ascii?Q?9KE/NaozAOQoqZerRbVBnK+XxQf4vpbb7Mzc1IbxeLXAfaO2dgbgmkaIlPzv?=
 =?us-ascii?Q?cPQeKUJaAES9uN+GXr0Cip6PbK3S1YqQdN6FFCLvcf/OMyheVdk4VHeZdv+b?=
 =?us-ascii?Q?yoJkDtNKqMurvCGGR58+5Yk7IFW2qys5SVZGJAvcorg0KjQFB+MAGCv8vBqr?=
 =?us-ascii?Q?I3yEbwibkCtQoptR366lmbdH0po+4PeIVKAOg/lUSid+ryMoX9lLCpFzDu81?=
 =?us-ascii?Q?veJ/vkFuyQbNISczxBRCZ0BMquoX2q9nlpvxVT4geVKEUXG8Qx3uIxb8J//9?=
 =?us-ascii?Q?xVuL/jJoi6Il/ENPbME3GEYXbov/qBMx4IqnGEf1/OHfqeDibnXigucBfKWA?=
 =?us-ascii?Q?4a1QpwWXjDnbHeeCxRNwH7RTqozVVXlwZ7obNT5doDakcZWeX2K6ozZv9I5Q?=
 =?us-ascii?Q?A3MTd+8BNTR+ew6FgwDi6gaJri+lBEwArjmxy+riYvMJNIvoEbQCprTWFqQJ?=
 =?us-ascii?Q?ZVw12F/yowtelg8FHkFw23Vs7sySMtW/4ThYpJPtPCqxJ9OKTJ/koFo75CEB?=
 =?us-ascii?Q?wMfEmT0Zv3cjf/wjo0Zfi8pJaNoL1M/R27Bpmjxo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4188b1-fdaa-4af0-ac7e-08dd8d385f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:25:41.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVO7AvE0boE2TZi2lhw6Ik1wOaMiIGmLoCNXaiEW9zT9aJ6qaYwWZUDUrsonynQhFJX45utGa695/cQWK+RyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, May 7, 2025 4:13 AM
>=20
> On Tue, May 06, 2025 at 09:25:59AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, April 30, 2025 1:15 AM
> > >
> > > On Tue, Apr 29, 2025 at 03:52:48PM +0530, Vasant Hegde wrote:
> > > > On 4/29/2025 12:15 PM, Nicolin Chen wrote:
> > > > > On Tue, Apr 29, 2025 at 11:04:06AM +0530, Vasant Hegde wrote:
> > > > >
> > > > > Will the hardware replace the physical device ID in the event wit=
h
> > > > > the virtual device ID when injecting the event to a guest event/P=
PR
> > > > > queue?
> > > > > If so, yea, I think you can define them separately using the> vCM=
DQ
> > > > infrastructures:
> > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
> > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
> > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
> > > > > (@Kevin @Jason Hmm, in this case we might want to revert the
> naming
> > > > >  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
> > >
> > > I think I should rename IOMMUFD_OBJ_VCMDQ back to
> > > IOMMUFD_OBJ_VQUEUE
> > > since the same object fits three types of queue now in the AMD case.
> > >
> > > Or any better naming suggestion?
> > >
> >
> > What about IOMMUFD_OBJ_HQUEUE to differentiate from other
> > pure software queue structs? 'H" stands for direct hw access to
> > the queue object.
>=20
> I think it make some sense. There has been a concern of mine that
> some day we might need vQUEUE to deal with some non-HW-acced case,
> given "vQUEUE" is named much wider than what it actually supports.
>=20
> Also, vEVENTQ and FAULT_QUEUE fit into the "QUEUE" category too..
>=20
> Though "hQUEUE" would break the naming pattern that we have,=20

what is the naming pattern here?

maybe
> we could try something like: "HW_QUEUE", "DIRECT_QUEUE", or so?

HW_QUEUE is OK to me.

>=20
> Jason, do you have a better idea?
>=20
> Thanks
> Nicolin


