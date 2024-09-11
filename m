Return-Path: <linux-kselftest+bounces-17709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E12974A26
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A4B1C24C62
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF974BF8;
	Wed, 11 Sep 2024 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/UkQpph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426A38DE5;
	Wed, 11 Sep 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035149; cv=fail; b=RQkBtPT+v8BP9P/GKFbw4NrTC8nXwWW8PPGfOZAoa825imtnnCXOjtwXzkEfPzrfPYxNHmCarFpamPim0vb+oPFiWbpycTOEagBEpZeLB/3RK4NpcGHkHmk9jUj2SQlFp1GR03FFYcGzG5hIAof0dSbMZ3nZQgy7RaMS3kjiAVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035149; c=relaxed/simple;
	bh=GSLNzXuF+ecEDWH7lyPtpIIlaRCzQdPAnCKMRzRSm0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uh2MVVVkohhNPH1X0u4ggwcaQRASLveRW7bOqVmaKS85AE8w6h1gxqtNy2mDhbd33tXrsbb82wT5PCH0bSEGW93975VtPA2yiKSPmI56iPfv1gnxjS2kHI3NzLA4wDqlbN6k5QfkmCivLSEamwXWuyZeJMN7WKPJc/hSn/RnXfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/UkQpph; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726035147; x=1757571147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GSLNzXuF+ecEDWH7lyPtpIIlaRCzQdPAnCKMRzRSm0s=;
  b=e/UkQpphQ5he5Esymvu1P4hiilS1XrblBVPKS3V0J61Zdv6xHhUE4IAT
   aUamV79/+aItGSj5871wI1id8AaAOBlywdGYpsRQ4VD0r6MtqTNyLowJ5
   MzBwFWJQWIezZEL7EBn5DVTOrefsN60HFudYwqD3UeGS6MFd9TJirxLXr
   0jO4rfi0wkTvRGMa+W6YhQnlDIFYXgwoEq7Ka0S7mC3J6iAUftNjeVz32
   /U3npm37EzcMIh4thisYRKiRQO0TsOvm45tujTMj7l8jlb6bB0Ma0lmCZ
   b0VfNvkVc8uhK58wTHbWWia9/fauunZnz0LfIdP5rsFZhqZD4Shr5LH5z
   w==;
X-CSE-ConnectionGUID: JzuFsLUCRwuHAIHGyagqDw==
X-CSE-MsgGUID: 9M17rvI3RNiMcldE8OQVow==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24691908"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24691908"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:12:26 -0700
X-CSE-ConnectionGUID: 1XbFc5GPRsy5fNl96zuhnQ==
X-CSE-MsgGUID: Qb8AwiYQTSmTjEJk3C5zyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="98083522"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 23:12:25 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 23:12:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 23:12:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 23:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL1KBNSbSYKpoGWhj/wBvb27RIuJn0jwMO86I1OFa9ALdk4DKy/WJq/kVwK0brcg5d4PFxfHN1vrt03KFT6ye3mZO8h763mPPC2OObC1U8jj2G4S4MMK8zRBfEjZvYftPDjRNZQo0YWDOMIN7IseKJ4r+RFiEI6PTTVoU23C0WP+EVxAkU9uTR4m4oJeR2x4e7nvADiDDq/wV3bEm/Dn16Pu5wU8lKrpWR1PNagiw8Uj9mHAh9a2f4L5V+gER5veKJAPnvzEZrj0PLPXfbg71O7ELSRwRZR+f/GM+I+9QFeQaEpzTzcdgFGmkoY8rsiYJlxc8y4jQ8afzcxCQYWcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSLNzXuF+ecEDWH7lyPtpIIlaRCzQdPAnCKMRzRSm0s=;
 b=HHNbu/w0Xovj4SGAyynbIdrvLlmcw5Rk3SnhGbfmk5ka+3/kRlEdi6tVHJfTbANBk4xu36lJZYqnmlqHfYS896qQBkES2sbdzsk4Aws3dzOFMGGyfw74ivKYr1tgxgSKN6uGqq5iauulmBROVB2QbwgJ0myMEDFFBWfLCPvpbD0U85uTS2v2DAVukerEJpXdJuJ29kI4hlnLs9rZ+6JSiD6QO7/W+Zj7xg87CXfu8ftZfwS3HnD54Dh545Xz+Mt2JNSIQ9v/oLP1gh4p+9wzIOhySFkoV0hInULNzTv/jbMaay1ORweTO/ZjlMIHXrEJf/V/lvuLRc1g3ZIB4fAQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 06:12:21 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%2]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:12:21 +0000
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Thread-Topic: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Thread-Index: AQHa+KLdGUnDM+C8EEu4QYu86AlEobJSMNBg
Date: Wed, 11 Sep 2024 06:12:21 +0000
Message-ID: <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|LV8PR11MB8509:EE_
x-ms-office365-filtering-correlation-id: b11d11ba-c4c7-4d00-b339-08dcd228b25b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CPH4vZroYymkNIzS5t6R3Cwtb2wOXcatDJ74DgSgVKaw3n8daTbC928ipMEW?=
 =?us-ascii?Q?0ehhDQm2h1+CqMDYWJ0PkiKTIQn8VHNU5vekg7djk7sY0Sze0uvtvkqhaIGa?=
 =?us-ascii?Q?sE6jGNUF9X96cheBXypVWdJj4VXKVc/XWPi7HdIODFZFq0ksHbiWEMxFBnsa?=
 =?us-ascii?Q?H3spMFwOOs1H300dOMO7Dh2UhT2e81yhJaLDdY07x/4dBv+lrNH5yeWc6DfQ?=
 =?us-ascii?Q?GjQSDINjvy+Al0RXWjTXgU/PI0w4RbS4ltteR1myOEFn6tDqHBie2oyJTyOT?=
 =?us-ascii?Q?vvaoG/4Y/dNJR7cwEYoDI+Sj/os0YUIXfsM75+0mCVrJfj/SpdYv4xUvu7vz?=
 =?us-ascii?Q?tIjSArd+PJbxQ+K0yelowXdtGjxRh9p7LI45ujwHwCjtVmYKmtIvSGvg02xe?=
 =?us-ascii?Q?mOgKaHQdnF1BGhtj8dFP101pMBzQ6K8pnfFWFXi7KQ5ZmyWU41/MBA/I8XVF?=
 =?us-ascii?Q?Wumf+w7z1aWs98M+S0ZlqL+ZR0eQJ5y3jyYzUsthzmqdDfYhNfzmuBMtM9o5?=
 =?us-ascii?Q?HWisnOUq3zNhPH+QNRxx5lA+dH2wGDwmBeAbqIBLeolwXLbgpBcuqdYUUrRF?=
 =?us-ascii?Q?7tqA5tIV/M42a9ca75ptump9LAy7ZkPuafxMwhoECX+nOgrOy/R0DiQ7XUWF?=
 =?us-ascii?Q?AeIbYAIceL+HIOnARimBFavt6JuRybf8YFgftdrjdvuCfP+2J4UTTX+T/x0t?=
 =?us-ascii?Q?1mpsSqRtlBHbVpBBAYLBesiDJP2b4+Gr3gwQiGCn8ppL66A9qa0o0icoGZoP?=
 =?us-ascii?Q?lsJnTw9TzbVws4DC2jFJ9ksmjKxw191kq1hyI8jl+qM2WL2P/f524+u7j2er?=
 =?us-ascii?Q?eNI92rkMIfBkJV10Zm+X9wBZ6yIDWNkIcgfzheGPS31MRKLGMovAxKDqiL1u?=
 =?us-ascii?Q?7ZztYxjpTbvL6cyuumQCd+xRhsqx320mM17+pLCrUjMTgZ3Cq9HJOLzAcMdA?=
 =?us-ascii?Q?anGVFVszos2hTFjsnx6ENpDSCcrZFbYvW9kDjc/KdG2c7ULOiXkdNzItxaN9?=
 =?us-ascii?Q?gmp8S8PCAzTwKghbpui8CZUpIvFydzyznjyi1xsVdNMEu+yGlBaEwJbljxhA?=
 =?us-ascii?Q?nRIQ1yxQVubguxXWkXQHtVtNixk6OXB2tNMssAoElR79W9OsbuOSlwBwLiDu?=
 =?us-ascii?Q?KU2Z7k7+H0EZC4Q2ngnoo6YSnr2b75vf2uA2Nbv5VccL9UZwWTn74haOI4zs?=
 =?us-ascii?Q?laF3kHMf0fZ2hYzKNR4PbpbAIgsaI+U0iGkUnatw4XEgH4/8sYeQ9UCaQPuD?=
 =?us-ascii?Q?ae78obAc6lvHTad9y+MV/YWN9H7Vo24kWOEC4QRNepk4ggs5ECo36bm/5QO+?=
 =?us-ascii?Q?QK2Q3B7RhQuRNsuE2Xxf1yCt3u+7APYLVEnd/EEp7cOV19mqck+S4B6UapO+?=
 =?us-ascii?Q?HNLJzkdHSyV5Je7Vi8yJt/fyvyMgSjB44s8rNlMAItTImDT1pA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZA7N/RgBTShiErSYd29DPGIfejaT/yQqPBwHiw/50578HejJDIcXukFJB+AO?=
 =?us-ascii?Q?tvPHrpgIRLpL97PsUqKXGbTX99uQ8bjQesPD+slF69Au9y4s/zKVZyO6xTkG?=
 =?us-ascii?Q?V2oeLf2JzMfisi8Y9xLejaA5BuK3ylPsy7oJA59ELPiIcVJgFeRnblW/Rama?=
 =?us-ascii?Q?3AkdOTR5bspQD7M4to9VYlR0uV5YH2isrCniwFiFl8LK2EpUT5+YuNtWxUNS?=
 =?us-ascii?Q?C5ud2lcayeuXWbPU1BcoP2D5gcgqHdeRoT7ZFjMzKWujCwpv0QSj5H9J9rl9?=
 =?us-ascii?Q?A5VtanhNGSgZ84yV9bbWrLLLP/oRAw8p0Xnj4p1kvl2WcU8oNLYrql/8KNke?=
 =?us-ascii?Q?BRwl0uGhzQG3GkpPqfMzEbSCfS4CteDxw0I3yE6h+wDEnkM2uJC/6OTTnede?=
 =?us-ascii?Q?OAIh96PxFV3ssG8pJ5gqMPLxI9LtDH8nsodv5EIrcnlSu9VVciItT41MhWBv?=
 =?us-ascii?Q?PL+3YkV6EPNCTNnC2E8GaKdWBxxTykC6lKHn/y51O+2bOe98FnpUWA2VoUAZ?=
 =?us-ascii?Q?8NCEUDJ3QcpQYIgzbjTD3Y4tNcPTjgiHMeM0CiTTJ9BTqRALeGUcYXy9biD4?=
 =?us-ascii?Q?UzxTI1FZcjaB1KPcpOeiVIOgmbvFr/AQaHlJDabjEtm7ktBpI0iNx3C42fWW?=
 =?us-ascii?Q?POIt3r3DSE2jdQ2oeh4ZgbyL5E6Y0fsjlnIfVdp1Tpghdi4j9kT1cFcBAcKZ?=
 =?us-ascii?Q?88YegSCok5GG8RrJ5hFVL05GvgB7+eYR/IYdCICSncoUEQfTE8zufZfEs9kL?=
 =?us-ascii?Q?EsxgZr5Q7grDXICwNnwr8qSOJyN/PneEoT5Ew88H9b62wFDLmkP0jlil9K+u?=
 =?us-ascii?Q?xQ8i3TXKW1s3PZSCiEVDYq9oycoykBdppQTNKVWljySHBCnSGfFjguBNauEf?=
 =?us-ascii?Q?vdfYp7DxS2ntdk/MJ8tsMCyu1U4EGsK6EogAeCN9Wxs3K6qj5PU3IW0e9voy?=
 =?us-ascii?Q?PUKYgBFnXQu+mGdhcUU0cMbQ4yFvbJYCN2gROWdtxJWy1VUA0hQ8y64pXhnL?=
 =?us-ascii?Q?p7EsbqgB+5EIG5OW9lxw7RPnkp1sFSGDsWhVP4GQLbf8Iv+2aMbj2p4Uhzj8?=
 =?us-ascii?Q?JgtbEa6vQK6iNvOnEX5Sz/yRWX4ylSeCzK/d5LarrJXdYZPml5Ue9ivNevqu?=
 =?us-ascii?Q?babfM/L0x+Lw+xMtgVGEVBVzJn1fwwXzs4PYHSzE8/6Wel+6kI87uYsdtpC/?=
 =?us-ascii?Q?c4gQm6kqdtXvU3qj5mCa2J62XzGLMg8jxW5wtzqcCq3o6doC+Kws66trCU3j?=
 =?us-ascii?Q?i4oKgSykSK7tFT3t7DWupH0N2PAa3AbBr459htNk/HKiogfWTO1RB6KUsaO+?=
 =?us-ascii?Q?tOzFiTmyLrXnAN2DSiMXADGj39WeBY4PgaA4XIDHsnv26w8XzRQz2wxqaFom?=
 =?us-ascii?Q?b4adtdkw4/2Uy/wI0M8y0wjxSRcIDPlGmA9ilqCyAuO9HUkBBvlp91kd9JR0?=
 =?us-ascii?Q?yZrkRTrmL7hSk6wkmr18Xok2LtWxP1/V91RI9KlEw7DlnowWU1xcbQDYaB09?=
 =?us-ascii?Q?FISvXQ3VbXCn6Kry3XCZ0HA6fSkjZbbDkQVJn6wrugoz3vzpz7LXl2UtjO35?=
 =?us-ascii?Q?cFWz3+tq/zhzHiedfQLLlLrBTDG6Vsmt/zZcl4yQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11d11ba-c4c7-4d00-b339-08dcd228b25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:12:21.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gfsd6wrqhp76Q4cG6Oem0MsPRUQpjWNA9xiaoIMDCVB/Wv6wiyut+W0jUHPeG6RwZ3czg06K3dpI9z3n0L+biQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, August 28, 2024 1:00 AM
>=20
[...]
> On a multi-IOMMU system, the VIOMMU object can be instanced to the
> number
> of vIOMMUs in a guest VM, while holding the same parent HWPT to share
> the

Is there restriction that multiple vIOMMU objects can be only created
on a multi-IOMMU system?

> stage-2 IO pagetable. Each VIOMMU then just need to only allocate its own
> VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:

this reads like 'VMID' is a virtual ID allocated by vIOMMU. But from the
entire context it actually means the physical 'VMID' allocated on the
associated physical IOMMU, correct?

