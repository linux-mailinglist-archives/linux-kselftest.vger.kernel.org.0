Return-Path: <linux-kselftest+bounces-13844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C09934180
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B972FB21610
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8E1E529;
	Wed, 17 Jul 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hufKk5fN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69381C17;
	Wed, 17 Jul 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237520; cv=fail; b=eLhd5v+lalNlVisPhfDsWWX3pgRIg5pcN14Pf23B9towvE2MHvLaTcxpprFzL2cwS2PmX+ZYGrACyKxCOxGPVHOL6tye3+fQlFrhDvpZ1w/untf0I5zLzSjt+hbG0i3OqWY9ZKb3HZMkQRskDN1sKFheYQVia0aSehoySR8gYY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237520; c=relaxed/simple;
	bh=D0+sHkDpt39njpEE6BksiYc346BEv1giz2aTXCChEZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHQ1Ha1sr6LMF0NMG9vsg4NTSFc5i1VILPoHoFZ8Af4dq59j1WXwgHR8MWNIIkrA+xMCjyrhFZQ+M2r50yChxwCePT7dznnTHXzXgMrpBk66qtd1Wx+hQBanYOMHdtlLXLBBvmSfIVa9VbpAdTASkfOLCjNJO2OY7bMRKi5cd70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hufKk5fN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721237519; x=1752773519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D0+sHkDpt39njpEE6BksiYc346BEv1giz2aTXCChEZ8=;
  b=hufKk5fN9SmCrD2+S3B4aDP6YhWYyJc7HHN/mKjCoiY2Q0kFAk6Aon6U
   uz+p8DEYSIFA+JJjbR99oGnEZtqpzLwMq0bRRx/qP17SLLJbjiy62MOA4
   yFgXXpaDqtlCYrDM3jAMfek7Wpq+rWlv1BOoeMwE1RYQpGIUhpHLSqm+R
   iZJ+k9SCN9RDsS0rOvqKOC6iRtD8T+jWTpnMq6b8tW2lvlIE8W8/t7M6L
   gqI2S/FeifTEYqNGrobdPyh0lF8T3wdTQsZrc0gG/hLu8WQOIxfPMf0Fr
   a0WmevGsvgAfhA9Zej0OPKRK5gLJ89gNT8n7hntgK9qXiS+f7Caco3xEb
   Q==;
X-CSE-ConnectionGUID: 9aog1DVZTYC7m/2pa8BGpQ==
X-CSE-MsgGUID: umOxWvmcSguRBJCoa9rRJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="36295568"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="36295568"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:31:57 -0700
X-CSE-ConnectionGUID: pSbJ3SU3RZeDZIuTL/gvzg==
X-CSE-MsgGUID: ntPhNocISP2rZjHU4Zxxhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="51178714"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:31:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:31:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:31:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgAHXQlYvekBjfBobO5n7N2Ahmj6mg+hhuvPWDvaRLEnIImf9hksOq1Umy5iqhf8ddh0FGhmeGBDqVIMUFHpz6jB/9LMXkD+bJdev3eMcejm8g+T8RIPEBaoly822xNOqZYuy4uk9E+AAQ015Rh75+0UojBsT9fiIZ0KhVRYBaDxd2DkO/TxODvWGWvvFClbTaRsASFe+uYItjYJbKmATyvl016t9gcFoDRCgcLJSlMqMINuGdCPQabQ8m9ehQfUyY4Hr51suWEhxFjNVi3Y2vY3aPGUzZ2HlfLBs7T0Lqjm7I49DprT8cNPvRvRqoQmz04y1Viq9KMUSY9kecLFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR6tp6y/8SQh/KCEzEQqzz+5c0rJdFGDCNc38nXPujE=;
 b=x/Vcp/3hMn3GT64sFwVan+uTPYt8Z/evXhGyGgkmN2vyw3wT1yxgHBvkek1yF3RwxyH9t/lAqI0LFT/1Q8Sll7CoqC3sE8zlhQjV2ahuXXuG7OIWTiKyB5Blze8Mf1ajU7Zx+FjSe80599YXRg2HsSgZqaAk6+SVqDFaXCDj36NUhw8N9dDuSVVLvnY2jyL9xyFT/dmk8n9xWFAVhMlpKiPyamZwAh4wSPMgWn2WCXPXGg+sxKTpzAOBz7chzTKG8s+v5pCyjkaN/uAqPhJG3zNWq+4MJg6niCfU3OTx9DFDomLciPTGs3ilKMhmHZ/Ri6TJRA+yjInLuChxcCkq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by MW6PR11MB8409.namprd11.prod.outlook.com (2603:10b6:303:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 17:31:46 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:31:45 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>, Sean Christopherson <seanjc@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Topic: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Index: AQHaWe/p8mDo/Zfb1Ue0O++EkKDe07HFceqAgCsrPICAA4rmgIAADUkwgAAHp4CAAADDQIAH5h3Q
Date: Wed, 17 Jul 2024 17:31:45 +0000
Message-ID: <SA1PR11MB67348CCC02DE80B2DAA4C7A0A8A32@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com> <ZmoYvcbFBPJ5ARma@google.com>
 <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com>
 <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFZg-9MTveHfn_4@google.com>
 <SA1PR11MB67349D5D7B0E26A49B8A1112A8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB67349D5D7B0E26A49B8A1112A8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|MW6PR11MB8409:EE_
x-ms-office365-filtering-correlation-id: 99994040-73ce-411b-def4-08dca68654c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Dec9X4KjLqsNUuUrc0wuj/CcjqeYo3Cyvaf6dWUv2CiOXwQfhATli1PPKpTQ?=
 =?us-ascii?Q?WeGc1fEMXsCY2Cyt/d7XxbnR4fCXaJ8l5Mpu0yOwdl18C5pBJoV5unpIbeqS?=
 =?us-ascii?Q?mJITtgUZyg0LdfuShnlavzrRlhUl5Dxv/hsalB3yhqFjkrChenIUW+a5rmEt?=
 =?us-ascii?Q?zJph9zVTsmv1gB3kZ1NSLJnL6OnnQoUrj8yYXcVwoYWNukyepoHkYXK9ub99?=
 =?us-ascii?Q?KHfMDEjcdGDXxknDXr8lFOWSy0RJ2d843YB8tbZPSNQR1nFo/Xb0vz77TwlN?=
 =?us-ascii?Q?kfgmPWo7gUi0PykyfPgrYncwpCc8HAWpdxsTI0Yo/rkNSNK9Epw6408r1VU/?=
 =?us-ascii?Q?vDsTRmPKbqPAZbhsCWs7GMy3xPUqKdb7ShOAJdt8X3HEsiL9mUtMIkJBmUrL?=
 =?us-ascii?Q?cTzNsB4IGpsiiBsEa0AIN8mGOV0kauzQdxcjdVnPa1ko7w+i+3WlCxRsCU0r?=
 =?us-ascii?Q?JGiMnJBZ+rkL229k032rdmW2RxcuwLx4ma02pjJugPAyUPjMXK36RmZAs1G6?=
 =?us-ascii?Q?5F2f5BZwtqRjH0nteH7wxXS5pu9yP9w+LxQWIggpgHQVT7luu8uMByPpI5+j?=
 =?us-ascii?Q?svnUlhltbdqiVm/pYfjXOvKQelNv5Yg7u6TExP+8O6PvntYbdQvj8olJwihh?=
 =?us-ascii?Q?EK+0GgvHqZUFzEucxZ1/+/UjhJbAf6UqKiyfGCcmyLkrxk5NGeaGAUhQvgne?=
 =?us-ascii?Q?hg8mz0jaR8pDmVDS52NH5RC+Xbgh6o8m6gBEhJPB9SOJtLYyhyFWvXMe2w5b?=
 =?us-ascii?Q?K+1ZGDSUiZ8zSwmg7Ac2Y+2CsDBVrTHE+yovZx9sXpYWDzTU9HsRJSc7ljat?=
 =?us-ascii?Q?r34mDY5OMElrcBrlfu6w0AyLSn57jPWWLTYwwOsbjn73ynkzjPcXAosb47v2?=
 =?us-ascii?Q?FQ+7GYOiul62CpUPaXQMCur4a0fZVOnPXklNedjdaRHLXidtDGuTdW1rHh1N?=
 =?us-ascii?Q?iE+5m/I9VAO0n73lE5/ae2oOY0KGImEeA5zBYm6xeRt5wgd6A1coUsleZ0c1?=
 =?us-ascii?Q?IYnuCEtrVEEFSSmj5DbB2HXTLbDaZNS2D39m3If188l1Fazc8R/tKOaM1ZVO?=
 =?us-ascii?Q?Y+hu2ANxhZ2YMzGagrExbNU/+SNK9TRWIHUD5GDmXYZJCryxxlrX804UswMm?=
 =?us-ascii?Q?6vDNpDAkoJUgS1A616Dem7VsnmSSGnrM3Tm/2ww8xqdMEuK2YU0XXGd0v3RJ?=
 =?us-ascii?Q?QQYeQSxxGJg4Y7NmQ+0Jra8q4XsLRFN2b11JTiOARZgsS8J2LOhrjaV0zngs?=
 =?us-ascii?Q?U03aOQinw/uqTt1nd5sO+uFoGE/4XntSXnG2TVm+K/sr6VNWR0boWjrHte0Y?=
 =?us-ascii?Q?JMuSZdnSnf3pHvISn8Z2yQ0omDk2YnQy3Xk2LpBopvUomdlntb80P6IAkvAV?=
 =?us-ascii?Q?ozrcyj8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JG/daUpWJk1EKGu2/Rq5egcz3mln4963wf8PN9Kw3PWOX7D+e2bueIAkbDai?=
 =?us-ascii?Q?mVqx++az0e21ahZp7FL1Iujyun2I38q2neyRMdgfgOnB11baqjatVNzMzpig?=
 =?us-ascii?Q?P/DXZKccW+BZ+YWIp55qb2THNRXR17y+Rpa/lgYMwlg5VUIW2CjQbTiNxGPK?=
 =?us-ascii?Q?o+7/OBfw2WZIbgejDUV1IeUMIBEeZ6oRnmIE2ggboZ1VK6/T4LISOoshyiNJ?=
 =?us-ascii?Q?utmqaTZtK3grYhRUOisuVBZnp28jtqZF7rB2UA0MHTSEEAKNHy4RlIvQM6YX?=
 =?us-ascii?Q?8rWq/Q43UkJ3n8NfyFiTDHbF2PTzLye9xP7q6kU0QfD5pwdC0gVzhYymy3lE?=
 =?us-ascii?Q?FETml769LoiibLcU92gVNgMjaM1EtHzvirnyfkbsLflq582kUD+tiO3f/gYO?=
 =?us-ascii?Q?PXetKJxywv+drXD6MabmOQkTsSTbh+2O2jrLScrbUkZNNnJmW+062S1j1dXp?=
 =?us-ascii?Q?hdeN3Yk+3Zbi32idIwGObBhZf/CuRil6qJ3joJBm4R+rVZPQuDN1fbndKAB8?=
 =?us-ascii?Q?dfhhvNMK5+iuCFOJLKmKci92QWIfbIxXQb08BKNWbrwpln7JOpGp4aB8RAuE?=
 =?us-ascii?Q?rBmOSiS9FjOGTjOMjCjHF1eR/zi3kjVQ5dvtxJXlmxoZ+EK7NkM4dDbCRuxI?=
 =?us-ascii?Q?NbJH5x5bo8CQSsQA6OpKqrDTYrYO52ENkY6pua9aCvwVAxQwaTo7LIl5QifV?=
 =?us-ascii?Q?H5TS91pw80Nln1IfVNQOlg8WJfPn1zz0NZTtnbFIG2OovR1R++tcKUiuNAW5?=
 =?us-ascii?Q?wAAZ8rji9+2zt4mSDb9oScqBU4Gywd/FlAOFEnyIrUrNln+TrdpZHWSZjJPV?=
 =?us-ascii?Q?ChSNXjO9iGkX5bqN96y9qeE4n75u813DhHrg9q5emGt9JgJ1LoEfrFy89muZ?=
 =?us-ascii?Q?55ne6x1m8xbXnDhQ/fPI8eyJZJ0uIytCQYOH+EUfMcCiJ8qTmWr3O4KMUhlH?=
 =?us-ascii?Q?xijPXt6G8btQXNm15ZI1Qjlz+ZWdNkO0212OPi0uN6R8ZlCDbHI1Rpb1/2nv?=
 =?us-ascii?Q?z4GSSjgqwko0MZT78JV5lop2Pogsjdw+KedV05DPts0jyjGmgkoxytgzTkoF?=
 =?us-ascii?Q?NrGorY2wOLMYHLPzEzP75rl7hCwC6cyEhlJBw6JfPTAEPNj8gSu3+tXxM0CJ?=
 =?us-ascii?Q?HV2JJkPgnPXIKKwdsv2T3XJnnStddHROsCiIuw/f14iN+YuXrQMOXhF7GUZG?=
 =?us-ascii?Q?mjfnawhWsnr5Al6mUVAF9ylFusdVGI71NuuEaEqMXd18InRAEp3+yB/J+Fgp?=
 =?us-ascii?Q?BsJtsHYzGO16rvt9yn+fHdbFD72eWahp3lZEnGC4hGNR0zSSbWU+7UoIjLAI?=
 =?us-ascii?Q?K1T2qcYU+b0WVz9nj4vOQV/rt/RyoQwCcBYfyqiT8JDmdH1xpR646xiVGV4x?=
 =?us-ascii?Q?h1P5jgNZghFT756/5PETTuVB8P/9jUUa891Rudzal69i0pZRVQBzdkXc5dUG?=
 =?us-ascii?Q?HWUKm+yWxesG/Ey7qJA9w5iuoyZLIo1R07l2WL8FQMnDZpCDMBQc3Xm27JtA?=
 =?us-ascii?Q?QbWD7i0zWqFW0aPWkiDYPl+UT6Sekdqwu4c/jg9lczX8mXKFy1p7aLfNBSVO?=
 =?us-ascii?Q?LPmikP2gsSE17FZ4sW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99994040-73ce-411b-def4-08dca68654c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 17:31:45.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFRfxGMpYWxkhvc2bjXrgP0p+iqpar62neUWbFI2einyngAlriM9euqDenbdQPkPXxA8VCKEqt8WfdrE15RaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8409
X-OriginatorOrg: intel.com

> > > > E.g. if it's somewhere in task_struct, then kvm_on_user_return()
> > > > would restore the current task's desired RSP0.
> > >
> > > So you're suggesting to extend the framework to allow per task consta=
nts?
> >
> > Yeah, or more likely, special case MSR_IA32_FRED_RSP0.  If KVM didn't
> > already have the user return framework, I wouldn't suggest this as I
> > doubt avoiding WRMSR when switching between vCPU tasks will be very
> > meaningful, but it's easy to handle FRED_RSP0, so why not.
>=20
> Great, I will take the patch.

I tried to make this work, however because FRED RSP0 is per task and
keeps changing during context switch[1], we lose track of FRED RSP0
values from both host and guest, thus we need to:

1) *always* save guest FRED RSP0 in vmx_prepare_switch_to_host().

2) *always* restore guest FRED RSP0 in vmx_prepare_switch_to_guest(),
   because sometimes context switches happen but the CPU does NOT
   return to user mode thus the user return framework detects no change.

So it essentially becomes the same as what the original patch does.

I guess It's probably not worth the change, how do you think?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D9356c4b8886c4f7d3436c3f7fe31715bdcf1c79e


> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c index
> > 1783986d8626..ebecb205e5de 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -352,6 +352,7 @@ static void kvm_on_user_return(struct
> > user_return_notifier *urn)
> >                 =3D container_of(urn, struct kvm_user_return_msrs, urn)=
;
> >         struct kvm_user_return_msr_values *values;
> >         unsigned long flags;
> > +       u64 host_val;
> >
> >         /*
> >          * Disabling irqs at this point since the following code could
> > be @@ -365,9
> > +366,15 @@ static void kvm_on_user_return(struct user_return_notifier
> > +*urn)
> >         local_irq_restore(flags);
> >         for (slot =3D 0; slot < kvm_nr_uret_msrs; ++slot) {
> >                 values =3D &msrs->values[slot];
> > -               if (values->host !=3D values->curr) {
> > -                       wrmsrl(kvm_uret_msrs_list[slot], values->host);
> > -                       values->curr =3D values->host;
> > +
> > +               if (kvm_uret_msrs_list[slot] =3D=3D MSR_IA32_FRED_RSP0)
> > +                       host_val =3D get_current_fred_rsp0();
> > +               else
> > +                       host_val =3D values->host;
> > +
> > +               if (host_val !=3D values->curr) {
> > +                       wrmsrl(kvm_uret_msrs_list[slot], host_val);
> > +                       values->curr =3D host_val;
> >                 }
> >         }
> >  }


