Return-Path: <linux-kselftest+bounces-20780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDA9B235D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 04:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91311F210FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB1186E56;
	Mon, 28 Oct 2024 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAl9Zl0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52E170A14;
	Mon, 28 Oct 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084611; cv=fail; b=X4xN6b0EcqLIYIyPJkaFfoiKojqfQKtW4Qkq/pFxs4ecmNYxaWDchKVFuz8E49vx/xVB1V3HHfW98RrwoGWWSE1hshM8h+lcmOJGIkxkcCewwSd+WRV62+P9G4WfBYEqMvEVy6L2e1yc2EHSsUOKdJ4Fe1sS8RX0eugLMkJefQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084611; c=relaxed/simple;
	bh=Vfg0MPbg74XP4Pa2LAY3PNv5Ub2mykzK8ACXB0Jcftc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OIITfKe/x6La0HFRtqEKZAsLiAJWz9aDl2PVuLVI9eVBMEG47+vptF04BTYIqm9+idaLLQBeLtbRT+bwOkdd2xw7rxp68E1jFz4I88SoPpakSF737pOYYngQlLDq1VSMZSyIKCD8wPbJ+xJoDIdfjA6Fq/m3xrR6Z6w0sBo81Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAl9Zl0J; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730084609; x=1761620609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vfg0MPbg74XP4Pa2LAY3PNv5Ub2mykzK8ACXB0Jcftc=;
  b=KAl9Zl0Jt1YfQ2EInitgVREYAUrXNkfwNKh1c5e9IRywWs9yWOz1E+hu
   EAcT3bMsXbUJ1iln3LUKGv4MexRnqrJ8xTIqvE7E1gAspbijWdRKePFwn
   Di7tXKYq7TLqG3ac7tZcAI2EIUXMbO9srWaOHlEwpP5wAfQ02Bn86NnW+
   Q9ldyvaMF5+i76T2OCFFKHgYXG7Rdk28MOftBomc7r6Hbx63B6M1L0THn
   /Y7Wspmw5G3TUIv+i5Sefk2U9eRJNBXEzI4LIzmJU/kL1sFvyMLg4Vj7K
   vpeuCLGKx+NGkuofbvEWyruYSVZrTBNNNfkhJ8FFNL+6EWvrnTZI7BVvV
   g==;
X-CSE-ConnectionGUID: icaohRvSRUup0PAwN4jQrQ==
X-CSE-MsgGUID: RB60GbmMSpuNlp1dmYYn+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47131123"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47131123"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 20:03:28 -0700
X-CSE-ConnectionGUID: 1Rs8G2t5RPyiYDO++0opAw==
X-CSE-MsgGUID: X1UV1P5DSLWIFzvEhFQ8GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86584931"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 20:03:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 20:03:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 20:03:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 20:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoCSCJGEqcCHeo+IYci7uEN4mDRDnED/wKIzpW9NrDSs55hL5CxzI0UxAq3aV40mCYDpUK6FwCIZpQJBe+lpoLY2+uilCKk+wasmspBD6qQQXGCAzSqf6WmAOvQ5wiUEPYW4zb2orsO/0RLOC/kcSkZXofqJ844dVVCuFmV2jHoe4dVokg0YfKxCP6KqhPOVV5/eC2Pl3HEfnr5UTFF38j/x8uUEsmV2PQ+WOrUdpUPNHnZ6Umu+kYUw9/bgMeWE9ZC3ILjvz4zq4FBoZtdZMESoSEGwgTESD/Bm0zotsQR9ej8EUZhxpq0WBnMPhUc/j6m5sbR4vg7/Cj/T6cF6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re5ITpxbbHFi1My/X20g799ii1+qJuKqzXe3DZHlmQo=;
 b=P1k97jZZf5ItBbrFgOLAbzhBwkXW5Tp2FGgska3+xH8ipLlRcwzwDr8oDNauoa4M5gTSe4coXm7wKZCCY6lAeTWqOYkMdJAX2tAukUczbXWlTL+YOGX3CfHAwNu8FdY5z0VqEudRxbSaUrZXmYL0W3W7idGMx4CqAC7X67sbJD09FkyVrHKW7d6MVEFM8w/3Ooa7oa/Sc8LyYgO6lgq7wSJY1vEYKOozmgHtdmhrJb4MM3GHp5SY9sBgWgG2Y60qq4hTdHuoH4WdRU+occI6tgbyx5yE1p7Xhn4gDoxCaak3cD4mAEqyLbjy+E50QJ3sphu057yiA7lzDmHjh6bIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 03:03:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 03:03:24 +0000
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
Subject: RE: [PATCH v5 00/13] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Thread-Topic: [PATCH v5 00/13] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Thread-Index: AQHbJzjDl1+fCVXsnEi2WCoYqtSYK7KbfMYg
Date: Mon, 28 Oct 2024 03:03:24 +0000
Message-ID: <BN9PR11MB5276FFE90D75B2146674E0BC8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4611:EE_
x-ms-office365-filtering-correlation-id: fac068a4-c8d5-4fe4-40df-08dcf6fd164f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WvoUGudwmJf5G+FiO1xi1c+VKYTpjvmOUd3wOIN7ZPcq7IE9uXk3Zgnfsvro?=
 =?us-ascii?Q?lQqaLzLaqytrL52EDZZ/oXxPSA6uzeJ2q83PG6sMhRBf7UVrGcPjSfMDGVQD?=
 =?us-ascii?Q?m0Z7opZv6Pbp8X/+bCzPt4utypG+80SKxdteHxYKphonTJt50JHvTw9mb72E?=
 =?us-ascii?Q?VsQAKILmveeJQki7UxLyOiODCjj5o5tG9Sp/x0Ui9G9hz5JN9M3z4SeuksTN?=
 =?us-ascii?Q?yCooAZkauBTz8FHkkudaAItv0UhsWbDPaspk+32UypJJRCS4Sm5mgyLDtnfh?=
 =?us-ascii?Q?I34TWQOoY97AzmCqNFl2azuyJLYWEh6g8Eu8kQx2g07CospX1A8GlKR8ehz4?=
 =?us-ascii?Q?oi4suiiqwK+v+ImgZc7uWY539sbA2JIJJr+RdhvXMYd+JhOqDnjeesJ2PAUV?=
 =?us-ascii?Q?ewWPgeTAV6X2sSbev4aDsAIqncFu6BvOyqegZpTW5wmGV0d5k/Qqm9Bm8Flw?=
 =?us-ascii?Q?iblxcYVhuk1Tmm9E7NcNKOq5U1NTSgSrzC2bQlUGWC8GqmqCCJD1nDpxXzmd?=
 =?us-ascii?Q?cR182vlFzCoVznID28gpK4OZ497xjgEejfgbDRExi/dJMWGZJnHCOhVE5z+F?=
 =?us-ascii?Q?aN9gE/oe82OH2j5oCkfQl9cr/xLLLC84h4e7AaHrAlZN+2FzbANqD9xAN1mY?=
 =?us-ascii?Q?MV46Ex8Wwal56uV5NvpW4uZr8U6BmI6sVAbqS8QOCmzReM1/GPBW93cvalpA?=
 =?us-ascii?Q?Z3XSsjFBK66Obd1k25ngyOvDlfOybxUgNRkxGygg5FqAEea+viM9K3GdUDh3?=
 =?us-ascii?Q?a7pr2AEv9c2v9Wddp0/B8SdwG3oXRdc5qI8hlxQklFUKxl+p6B3DY8p34T1b?=
 =?us-ascii?Q?YcNlW4Ejn2gqeRMRIAVgAgcoIUqi/gWpK9FIR4GYVUVWqrmKAnofNtmoND9/?=
 =?us-ascii?Q?4mV2CS8iU30gI4Rc0YLjG1VJJ+ImZ2u+ljcIpeWuSN1aUFl7gHkqofre3OOD?=
 =?us-ascii?Q?M+vP3UcJjTqy8T5w6z/uZNEn5JhCDaVTkwzRQh+q1XsRecn2j/JcpgUiCOeg?=
 =?us-ascii?Q?jhlPT+lN7XNJG6pTWgRb1dB5HQUf/21rZWSrNDY5hfcF1Dz54lskfjAuS06m?=
 =?us-ascii?Q?CR23WIZVO1/O4Gh+I3z0jyR1Qvr4VbtTD+nXnzfVR+RoEJtvCfjVsWmrA981?=
 =?us-ascii?Q?xhr3WuWUSZ33q6+APZwrWrHTDKMICX9Dzl1pMF5GglLHcdF1jISj5sTqmB9p?=
 =?us-ascii?Q?vde21gpBP5P/zgPDMa7D1+ge47r53iv7EHCRzhr6zBd9Apj7y0IWqYCtMdkD?=
 =?us-ascii?Q?c3gqiLHtwrX/T5BCgcDzqX+5VPFdhxkYo27oz8ITw0j7ddwIJiIQaCx5GD5B?=
 =?us-ascii?Q?83EsH1jhX3QtWHVAwDpUUkWhUb1f9VQGMCyJaTXJxXKgKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xp9nEKJ02v83vuEAESMNQ0FfamHERW6NV3GVNxMy+QvfjOmWF0Sak8PUeg+7?=
 =?us-ascii?Q?Us4YHIhvShMSgM3Jdspl0YaVkl7ySk0vCR0wJXyJJjvuw3iyC2uZUcAL50pw?=
 =?us-ascii?Q?ypdSgHs3qSXFVKX/oxF4olY7mFEfzIWrLJen/IPt4jTIH8DZybZ4+sL+mAK0?=
 =?us-ascii?Q?2Mfelvv8Dx4Q4WJD600DcbDm/0s+ueC4/djERGHPH/xVK85w0mZ4HbnxBEHZ?=
 =?us-ascii?Q?/EWBYNFM7X/eT+SdOCVAVdB3HB68uRj7sWyWxFkqZHIdBwvQePehqN3eFgRz?=
 =?us-ascii?Q?6ILP9FYE6JzALISWwcs5Eo7F6sST92XJuRXMB8xtDMrKSy7PO5TybUgL6/co?=
 =?us-ascii?Q?pyBWWU1sy1EgXhU4azNnJiO0qcjExtoY5QR3mRBqUX6cJLEYx8t98TT2yz14?=
 =?us-ascii?Q?jK+7oTlDhNrptoEiQMSN5ctpcCFkspu1ftSEPan0ZEYWiU3zZEMn9Y6v0EkU?=
 =?us-ascii?Q?or3Y0nMA7pwPh11S7Ce5dkzGK+Fo/KZaPbr1SqDH+3azuTeHK4oi42c3J3SK?=
 =?us-ascii?Q?XA3vxGcWhoQJT8AYMp+3JriN+NVY3z+Ff+cYsS9eoMUGU4b9RV3Tj4GiwyUJ?=
 =?us-ascii?Q?n44ATpXMAhuISjN21mTatcPCQGM3FR5xNI5i0GRT2z674rV6fpFMo5pjZgfw?=
 =?us-ascii?Q?41Eekjzj1iiw8V8PdrBQDyoJR+zbEpqjCWu7R60Ow9BuLlPUzDV3GfCmSQ3v?=
 =?us-ascii?Q?uTzpVlteqVuLSD5wiTwObMHP930kdafLKApYEHAl3v+8gGzMIRcU/zsSCq0s?=
 =?us-ascii?Q?4sEPAaLNM36Xpt7ESWUVeQIJsdTDIf0iJjCMMI/YEtTJX0Ruaq8daoFRDmc7?=
 =?us-ascii?Q?Dh5nf/S0X32bIxsfcRaoxR1OquFt93YvmX3L5jUs9LXGq5Rx11kjem8knhh1?=
 =?us-ascii?Q?utdAgcz6vBUTdUcwuUA7OfCX/kYESKcJufG1E+uMYOgT1G1JiI0GSULKWhhl?=
 =?us-ascii?Q?cxTWcTLakYUBumqPTnz/ElXCR+B/+v/ovQIK4UqjuFeaZepnyD1qdwkARymE?=
 =?us-ascii?Q?Ci9/WU17reNY3+HYSKX7NVl7enWOziVWg5qi2cmqQGmIwAscjhcYnHVkLd6I?=
 =?us-ascii?Q?A78+FpRukWlM7X6JuRC8kvXa4/y9TOg7K6ehBN3jL1hN8soHSgU9MsCwp+T4?=
 =?us-ascii?Q?CVi034oZjZf6yOI9WrP9jfHyTogidJYwn9bQ8ID700dvCRI8ZHwiHp8wdGpC?=
 =?us-ascii?Q?rDQOOkn0kR8mHpbH8NIDQ1q//peA0ztZvr9kVoOyqxjvLZnCKVfFJ3sL2mBs?=
 =?us-ascii?Q?Pz0mS9Pr799BPQHoYZxip4cLT1+MsozYKBi8/y5IxVaZkixaBL6B/+38jlS/?=
 =?us-ascii?Q?Icw9TvZ3MkuFMj+AGyjBidWN8JXSgqsYff0RLjFRiq6V7dis7W9MZUSKho1z?=
 =?us-ascii?Q?YPB6sY2DX7SRRI8TX8+qNOIZ4tMaA3xhUxJlPDfRfsCbjFiGClXZscDZPGzg?=
 =?us-ascii?Q?ouikmrGot2lHHqIFPWo37lhC8Niz6KCtDsu5j2IEQkhZMDoaZUj3N2hiYyMi?=
 =?us-ascii?Q?iAkgxc3XNvuC7jWnxUL0aAEzqmISv2uR+AhI4HuHRdqxpC+KBVOeXuCYpha0?=
 =?us-ascii?Q?YPf+a/x5auTth37riE9mmwRppFc9jpOK+CQNxGVc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fac068a4-c8d5-4fe4-40df-08dcf6fd164f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 03:03:24.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHhQYlwsZog5/K4dQFcacLLLzy+FMZDu1CIBaLi33CcCz7QNPYhF6qttV9D+e5GyG6Sfa81dCbdCF4PH6UrFOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> Following the previous vIOMMU series, this adds another vDEVICE structure=
,
> representing the association from an iommufd_device to an
> iommufd_viommu.
> This gives the whole architecture a new "v" layer:
>=20
> ________________________________________________________________
> _______
>  |                      iommufd (with vIOMMU/vDEVICE)                    =
|
>  |                        _____________      _____________               =
|
>  |                       |             |    |             |              =
|
>  |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      =
|
>  |      |                |             |    |_____________|       |      =
|
>  |      |     ______     |             |     _____________     ___|____  =
|
>  |      |    |      |    |             |    |             |   |        | =
|
>  |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | =
|
>  |      |    |______|    |_____________|    |_____________|   |________| =
|
>=20
> |______|________|______________|__________________|_____________
> __|_____|
>         |        |              |                  |               |
>   ______v_____   |        ______v_____       ______v_____       ___v__
>  |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
>  |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----
> |device|
>  |____________|   storage|____________|     |____________|     |______|
>=20
> This vDEVICE object is used to collect and store all vIOMMU-related devic=
e
> information/attributes in a VM. As an initial series for vDEVICE, add onl=
y
> the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
> e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d

s/vID/vRID/ for VT-d

> to
> a Context Table. This virt_id helps IOMMU drivers to link the vID to a pI=
D
> of the device against the physical IOMMU instance. This is essential for =
a
> vIOMMU-based invalidation, where the request contains a device's vID for =
a
> device cache flush, e.g. ATC invalidation.

probably connect this to vCMDQ passthrough? otherwise for sw-based
invalidation the userspace can always replace vID with pID before
submitting the request.

>=20
> Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
> by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to
> flush cache
> with a given driver data.
>=20
> As for the implementation of the series, add driver support in ARM SMMUv3
> for a real world use case.
>=20
> This series is on Github:
> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v5
>=20
> For testing, try this "with-rmr" branch:
> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v5-
> with-rmr
> Paring QEMU branch for testing:
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_viommu_p2-
> v5
>=20
> Changelog
> v5
>  * Dropped driver-allocated vDEVICE support
>  * Changed vdev_to_dev helper to iommufd_viommu_find_dev
> v4
>  https://lore.kernel.org/all/cover.1729555967.git.nicolinc@nvidia.com/
>  * Added missing brackets in switch-case
>  * Fixed the unreleased idev refcount issue
>  * Reworked the iommufd_vdevice_alloc allocator
>  * Dropped support for IOMMU_VIOMMU_TYPE_DEFAULT
>  * Added missing TEST_LENGTH and fail_nth coverages
>  * Added a verification to the driver-allocated vDEVICE object
>  * Added an iommufd_vdevice_abort for a missing mutex protection
>  * Added a u64 structure arm_vsmmu_invalidation_cmd for user command
>    conversion
> v3
>  https://lore.kernel.org/all/cover.1728491532.git.nicolinc@nvidia.com/
>  * Added Jason's Reviewed-by
>  * Split this invalidation part out of the part-1 series
>  * Repurposed VDEV_ID ioctl to a wider vDEVICE structure and ioctl
>  * Reduced viommu_api functions by allowing drivers to access viommu
>    and vdevice structure directly
>  * Dropped vdevs_rwsem by using xa_lock instead
>  * Dropped arm_smmu_cache_invalidate_user
> v2
>  https://lore.kernel.org/all/cover.1724776335.git.nicolinc@nvidia.com/
>  * Limited vdev_id to one per idev
>  * Added a rw_sem to protect the vdev_id list
>  * Reworked driver-level APIs with proper lockings
>  * Added a new viommu_api file for IOMMUFD_DRIVER config
>  * Dropped useless iommu_dev point from the viommu structure
>  * Added missing index numnbers to new types in the uAPI header
>  * Dropped IOMMU_VIOMMU_INVALIDATE uAPI; Instead, reuse the HWPT
> one
>  * Reworked mock_viommu_cache_invalidate() using the new iommu helper
>  * Reordered details of set/unset_vdev_id handlers for proper lockings
> v1
>  https://lore.kernel.org/all/cover.1723061377.git.nicolinc@nvidia.com/
>=20
> Thanks!
> Nicolin
>=20
> Jason Gunthorpe (2):
>   iommu: Add iommu_copy_struct_from_full_user_array helper
>   iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
>=20
> Nicolin Chen (11):
>   iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
> IOMMU_VDEVICE_ALLOC ioctl
>   iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
>   iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
>   iommufd/hw_pagetable: Enforce invalidation op on vIOMMU-based
>     hwpt_nested
>   iommufd: Allow hwpt_id to carry viommu_id for
> IOMMU_HWPT_INVALIDATE
>   iommufd/viommu: Add iommufd_viommu_find_dev helper
>   iommufd/selftest: Add mock_viommu_cache_invalidate
>   iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test
> command
>   iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE
> ioctl
>   Documentation: userspace-api: iommufd: Update vDEVICE
>   iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate
>=20
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   9 +-
>  drivers/iommu/iommufd/iommufd_private.h       |  20 ++
>  drivers/iommu/iommufd/iommufd_test.h          |  30 +++
>  include/linux/iommu.h                         |  48 ++++-
>  include/linux/iommufd.h                       |  21 ++
>  include/uapi/linux/iommufd.h                  |  61 +++++-
>  tools/testing/selftests/iommu/iommufd_utils.h |  83 +++++++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 161 +++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  32 ++-
>  drivers/iommu/iommufd/device.c                |  11 +
>  drivers/iommu/iommufd/driver.c                |  13 ++
>  drivers/iommu/iommufd/hw_pagetable.c          |  36 +++-
>  drivers/iommu/iommufd/main.c                  |   7 +
>  drivers/iommu/iommufd/selftest.c              |  98 ++++++++-
>  drivers/iommu/iommufd/viommu.c                | 101 +++++++++
>  tools/testing/selftests/iommu/iommufd.c       | 204 +++++++++++++++++-
>  .../selftests/iommu/iommufd_fail_nth.c        |   4 +
>  Documentation/userspace-api/iommufd.rst       |  41 +++-
>  18 files changed, 942 insertions(+), 38 deletions(-)
>=20
> --
> 2.43.0


