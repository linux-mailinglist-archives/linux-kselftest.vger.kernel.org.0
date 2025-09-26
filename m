Return-Path: <linux-kselftest+bounces-42449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F8BA2DD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9C6625EB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2AC28A1F1;
	Fri, 26 Sep 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDiy/sEF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8F2836A6;
	Fri, 26 Sep 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873438; cv=fail; b=Q7Nzhc4R5JWGP5TjRFGwoI8Tfigulw5zQhxx6WxOdKJxoMIbN7xCOprggMStRXkX9rbraYPoZDpWc1OL+ANr9HqiXRAy9XL1l3VrUYDm33I8YJDDYvZ4GEHQQlyULhjjrLjhQpKlctAyvcBf+2e7eBAqQ94spAukDkl74XHIOMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873438; c=relaxed/simple;
	bh=8Jlhv9iNTSB/ktdugfpChhl9tkdcI33k6S45PA6hbXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i17ODUVtZo11e3R9r8REiFcp5NxggoYIPkf4WhR7HUdl1VRTow0OeoQKQu4I74/O22QHu+yer3KOXztuWo4AL0GrWCYQP6m1lApm9aV6PILTDoRs5hYubkqMUFN8X1pK9U5ysQilCe/EVw3ZpMr85r0ovFTFJnFYZXYg+JCVngg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDiy/sEF; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758873436; x=1790409436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Jlhv9iNTSB/ktdugfpChhl9tkdcI33k6S45PA6hbXc=;
  b=WDiy/sEFX5AmznOs4Wp9AR8gAdx9BHQEEY8uVwPwZIpPuvN+AncUmipA
   p8+rFmss7SfDYLGCrlCW+yRCERFja5SPzRZFJ9AbRaYhsLpUrAeWmLRtY
   cUFfclhXO4vjlTBmr1ZYmHdPQMyg1XnpNuWYSmXcxMSZnkx4DBRWqNl9r
   /mzmaQIcdYTagEwkzunonrwhdkZ4/a6I+SIsZTMGhBnER68eGbXUAy3mT
   B1XzU/fPg7CGXlv55AKgSZDz5u/dwFi1LxsttN6e5A1VQOoTBGQ+vnfwY
   0qFPptn04gqSasaizx2yKrXa7vTmFxPmoEUnsDZvMnv1MunlF8XK/oGer
   A==;
X-CSE-ConnectionGUID: NFd7XG1KT2+jwtMH+ADNmA==
X-CSE-MsgGUID: vucuj6+bSH2BBti/DzP5NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71891842"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="71891842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:57:16 -0700
X-CSE-ConnectionGUID: WiliIfLbQdWxZ6TIanBfew==
X-CSE-MsgGUID: 5v3ycnLmRzabQhoESOStDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="201237129"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:57:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:57:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 00:57:15 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:57:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxWl/EMF9orV0+zeKZdwn7lPZh67j9UJFPyVrFX8eFN8dcvhZ9Y5N0gkLmUsk5P7VAN3PZ8S03O/Clb7AcbHd1rjXAXuAA6U1gsw3psN5X0WwEiKmZposGcrpqFXgGGgNjvC31H10pyPaA2AV9kjOK0KSEE4a2JW1lu74j79FQKdU8p6sjiyyAVPFjfCad3iT5TS9fkC7GlGvJHU+EFs8VwaYUiQrnogem031YLClOSM2ax8Qbq615rfJY0OXGhkE2i3zRrR+WYjCQOQDwjPv1+yC0FAQdRXY/I6EWEpeb5U19u1VWC0ZinE34ZCvC4nt0M59pKhEtuu3XRZ+foF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLa3PkTs++BxT1b/uSjpneQj5vFJhsHdDabyI9Nva6U=;
 b=jt5kxyARkg5mVdywGuCLi7HmMdg4MlguQ2Etl5C9dYmNzC+i3tEt/p8gLYm32dMNpTMEuNH4IvMjtUhg/M6NjGjDNEqjEybx6E2CDPhb6BQqcmJ3gturWP5urQyp+uuB+VHgp8UKbtygdzt8Cjv3oFwaRpLBAjPrW95rOXcQDlhBVfwg0hq1NiDQZ/OgZr7HQ9p4/ibn3MdH+5KwQPIUZ/fGuUH4uCPA8Au2HCqyzueJ+PO1iPuRH0d8XKINI2SE9sJDzlfZT8KoZj+5kzJr1qUVSvCLvuJuPEqxog912Uyq5OJN4Hyl0wpuDD3LWlXbQyjeS9Ogo5q15h5NNyLpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:57:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.013; Fri, 26 Sep 2025
 07:57:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 12/15] iommupt: Add the x86 64 bit page table format
Thread-Topic: [PATCH v5 12/15] iommupt: Add the x86 64 bit page table format
Thread-Index: AQHcHPrEaNL9nJm4FUSD/N4Yn9U+WLSlPAnA
Date: Fri, 26 Sep 2025 07:57:07 +0000
Message-ID: <BN9PR11MB527644A664DC4EE3352D1C6A8C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8543:EE_
x-ms-office365-filtering-correlation-id: fce9271c-429f-4ad7-eeb2-08ddfcd24a38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?b7olpBqyUqhPowtPhxj3yS4bZc1fM377E2b44wHJV9wTMGQXYLm/wOPuXibQ?=
 =?us-ascii?Q?HghZA9rBX3cecRn1m2BqstEHiUN+/QAU/vIx5K3Q/eSTQCPLnW/q+wqCnpux?=
 =?us-ascii?Q?b7tASBrXlHLastLc/6iT1KDXKjH9q3BInJKulIEZfV1nVD/mnEuVJAB3aZtM?=
 =?us-ascii?Q?3LDt2WMgRGyTchN4vTkbbxkYqdLDIqfBrHpaA9GHHNfHKgiCeFuy5AahRznp?=
 =?us-ascii?Q?+nnMoUl8iRV44Zh0VOEeFRsEZGDA8XSRozUr9OTvK9tCcFkkZIEr5XyZEKYZ?=
 =?us-ascii?Q?cvb3AK+WNwzfJCl7PLSL4YKNXVFUYnpXT1TTZpzC6VhCFtxWfIrkXRVUG8j7?=
 =?us-ascii?Q?2UtJHneTtVb8+MAXsCyPpb7ydRCVtPYHMS0wPd2ZJl1KmP5y7/8QFddmfbep?=
 =?us-ascii?Q?bqeI8bQJNa142WQUrGNmfB9XqbmYnGCPw9wQAXcQvIpAk/7hQZp1gZWjFvfL?=
 =?us-ascii?Q?jg1kkP3b43uqlUH2bPNggx6rxbdzUnNUZ3nJKDVlmj99Bpxo2x8hqj63Jrn9?=
 =?us-ascii?Q?3U7BjwKzMSYgxioVB1E7JVVZvnPgiTLmF3plhi39Sd5N/W9CypaA98gQATUP?=
 =?us-ascii?Q?jwfJjlufXwnTRYf4L1ZAnbWAnsZgpHS5LQHMhfwxsjHoLCNOofU/Tf32anQE?=
 =?us-ascii?Q?ke5K63lXK8RRyiJwxO7knNePTPh6DZnXSyXAeZRN6lQwDl7MmSbE2flObRW1?=
 =?us-ascii?Q?fBW//ETvVsFS5t0JbHx4VSqZiJlLr3cOkIfJQ/Ef+ihhaVqgj3YYprhF4FfP?=
 =?us-ascii?Q?MDTjncYlhf4NKB7hk/fwWG1zmZs7Zly4DXs58JPajTjTJbKHwHLbrMQY3jb2?=
 =?us-ascii?Q?QEdLAVcb3Vsl3awOdAQInhVOu39oywYwIZhjX02+3+Xev6sNY/BTSA+SEKtg?=
 =?us-ascii?Q?JPh/zzCTDxei4yqP/zgWvcXEe0OFPWxU8sKLaRsb6B3wOi9wLLVPPWZZVV7n?=
 =?us-ascii?Q?0herRYxcIrg8F9+/lT//Kq3KyPagadrXmcolurFvCEhgQa8Q4WdiHOxeitIv?=
 =?us-ascii?Q?epr4umix14BiyrHGjABz6noKmsSLU92XmonHhNWUxlF384Sko1tnzUDmNUZg?=
 =?us-ascii?Q?Oo2umsdn5p9d03Uadv1FpARVHXuqsgoOs9flNVlQBGL0XktWP/G3WXS3uwzP?=
 =?us-ascii?Q?/MEmTVQTHLABig4v979WO056xQvALFU62Cu1gU55IJXVypE1dsqasBZWyKgG?=
 =?us-ascii?Q?N1qbzvRp6xehlssOlMgSKTB12eoH7BAWK+uO6IHjUsUJFgPd2HVfuMLhS2Qe?=
 =?us-ascii?Q?aMspjFT5ncebilOKVCeUOkNgsV1kxxsELnKExAcVNWEwdYWbiZgHMSpQ7USG?=
 =?us-ascii?Q?SCGTUen3vLL5IAgFxdDHQaDewfl/8ReSNCjZrVnX0RjTGt85qOKEmhFeSWOc?=
 =?us-ascii?Q?BWKdznyPsk3Fq0azr9rx27fTEMbRhBoFmhpD54EV+QgWlMBR0Q3FemiC2N6j?=
 =?us-ascii?Q?7zFrLKqVOsBv88a9zVgxG+1d5hUV/GSooA2meHjHeCPpzY3Sc1ec4XEcQ4Bq?=
 =?us-ascii?Q?Pck+J5kqTGjjyG0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0MENXXmLDhmTwkXHL4W26aiVOHacYGJ9ipQ9j3FbWoHOSEcAa7pn84sJt4NE?=
 =?us-ascii?Q?QIHptDg7b5FGxG0pthBAsTqsTEcuSQaBIj7BcBSt6HOv3fKSQ/fqQYamgErS?=
 =?us-ascii?Q?Wly4F18qQKf6QhWCmQD6/U182tsxtvPgQGhmig6drCGWcTuYZU0MmXOv1uSW?=
 =?us-ascii?Q?kZQ8n+ARxjWBHldOhbLwveupQ2pWi9sf+KnoMZcvEaoL7VGWG3dz++K9Qjil?=
 =?us-ascii?Q?Lq1sEmh7ZLZZhCc1DzU4HvaKVcSKmdtgIEtYLH4XOuREEgRSSo/jO64bWx0F?=
 =?us-ascii?Q?UgBepXT0m7NWVekAdCi5PUkqqw4u75LmsiwCGaQZQS8bKEJO8dtkn6mQ9R2w?=
 =?us-ascii?Q?cXtrJJLg2HeCE6brTbqKkgqmxxP+1I00+JAO745hDq7FaqDSC837+QX5A6gu?=
 =?us-ascii?Q?kRSxspubMOwaX5gEJZ8Jp4CCIVtxN+1vRBJPpuDcRRoBgp7pIV98ZK5g0ofM?=
 =?us-ascii?Q?C4gqVxOa+JNQz3/Xg/SW9ol+Z/D9CCVF6GbTXUAPhDPImfsJrzMCAawYlm2r?=
 =?us-ascii?Q?+FC58hoBdXIdNoIe7Uu71sVxoTQ919DivUYbYmVHbABhJz02MYPepLUpuL/3?=
 =?us-ascii?Q?ALBTpjbBAF3EopNJ794RP9L6l9M5cvXDr0sHt4baf75yR+RuLVrPtl3Ak043?=
 =?us-ascii?Q?0DMFkIwUahgLXOroAIX+JUq9/7B6vHbMbqWjcXafSc3dVfTt+1oi1VheFLLh?=
 =?us-ascii?Q?UHgxYTcJ27PqR9m1ByJbDAi0d54+nUg+EdTw4ZgcDCQf8MuOQZww3ZffhGrb?=
 =?us-ascii?Q?93H1jWKsJw01s6YuZcS0lLM9Zwh1hlWMEAqb1H1nB+T1bICpX1MwX2DbSoyr?=
 =?us-ascii?Q?1QdFp9e9blqGSV6uOe+5mRqwk1jCLEIczfurUOhyqrbGl43Qdw62bjvuF4Ue?=
 =?us-ascii?Q?8gst0ZAW+/ZNgJIEF53p2akovjPaPqsqFufH+6thIDk2Zw9SNov4u/ch5s4H?=
 =?us-ascii?Q?bW76vj2D3iGXIGe0f10OCF+QOB+zp9Fi2CCdCwlD1GH7HMlyqXVOrpSaLd4d?=
 =?us-ascii?Q?jRPm8KdLrEVF2+XXZakfavittGC+uonXYU6cyqzfQn4dI+M1v44/kuXHdHx/?=
 =?us-ascii?Q?MDrN6cDwHSM2UjKukyFxIZeSwszd6PYHhQ4JaOgE9TYJsl066gBXDL4WKbhR?=
 =?us-ascii?Q?IiK0aVSancQn/lIIfOLIdSmjYVkKFt1fem9F/QZChAMmN2DdYCFxFY2xuHp9?=
 =?us-ascii?Q?+0ANbLyOjO3FQPiZ22AhfnlPxjzhtIKc6uJpwf3rOglDroe9EZdO7R30ji4J?=
 =?us-ascii?Q?+T7yt/r5S3Vy76fIGEZkiiD4giS7zTuP1VVO62O5Kp/rPhBtmMdvxWNUtfJ6?=
 =?us-ascii?Q?M3YxIXjlOVUsJhhArhGoLwbgKR00sTwTlSiIXf8LPaMoEvSnfwbp/mdorPO/?=
 =?us-ascii?Q?eVF5doKmvWZ6wsGQK62etFs4i21RK4TZOHc2HY/brQhzj7Ax76qzj48TZITH?=
 =?us-ascii?Q?t/vXubNhTG3AY6n3V9Puigq3u1rGEjO5+z582JXrycrUhfPGYhND0OjQ3iAf?=
 =?us-ascii?Q?tIY4JNswUJ1H/fzI9YhUCZyCe9YNmE0TvvCwrPYBniKLFht2RxQ78OH0IcWv?=
 =?us-ascii?Q?y8/HBnwmmZxsneYFJT/Aqh1puqjn+UAbTX4kY8sm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fce9271c-429f-4ad7-eeb2-08ddfcd24a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 07:57:07.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlFa+VFLoHkustkV0J5TNjbXuqRE6QVfBGXgn5oc/HB/2ASExm7hILrDtVQyZnRH60ggPEW/tnJkr6cxLzEmmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:47 AM
>
> +#define PT_FMT x86_64
> +#define PT_SUPPORTED_FEATURES                                  \
> +	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
> +	 BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) |                    \
> +	 BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
> +

iirc we discussed that FLUSH_RANGE and FLUSH_RANGE_NO_GAPS are
mutually exclusive. so it's a typo to set both of them here?

