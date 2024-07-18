Return-Path: <linux-kselftest+bounces-13891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEAD935150
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B02283C37
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE944144D3E;
	Thu, 18 Jul 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fld/zSP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0763A;
	Thu, 18 Jul 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324682; cv=fail; b=DZKvw06iXLHkngZsh/fKl7cVPT/BMkaZmLsViz+OHedM2gLwxBL8bl8epDtnySY9CTp2oDmAMhC69IXacbvVuQv+MkWAoJA0k4o0cNAjs3hev7VPfqbNKYFOpeMztcyqePv5MVnn2Xt2TKi1hTPJEWtUjGdBQ0DDpiCuHASEWI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324682; c=relaxed/simple;
	bh=45jYPxISLzq9B+bq2uQ1F86y2mQGFQ9hZxu/w6npBbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7+S6JmeF4zYqiI3heoecqgiQS2BTfMd4XbH2srUm0CoHfVpj+FJfclqn8j1Em6Ki5M0Mm9xU6LKjEpYRqhurW2P7WLQooq0h31esL6/Vk7crwj6oduZ4gN0f8b0p3fLZb1jmOXujsfXiR4PpZ76gsfHvrv3FYOIWJ3La/AzytU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fld/zSP0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721324680; x=1752860680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45jYPxISLzq9B+bq2uQ1F86y2mQGFQ9hZxu/w6npBbQ=;
  b=Fld/zSP02wFzLXJSR8SQ0wAh4u9t+gH83cuKCh8T39oV459XqP5R927t
   1+TNX//hhqQjEar+PPdx82evMALAZXTg3IuAjpIAAERuYFd9SZpqmlGNm
   hu42JWXgyN903RcpDkMrQc8Y1gF+/kx+UaQzneEGc2cVfEjz+CQSTTQxx
   7VUd9dHVvWBB4zTTf3oPriQRbktS+z6MIQGzXWlArKBas6Re8OOyYjvDY
   Z0JARWeRK3EzS2JRD6fI1YUU0rU3lVvI2HrnYqTdKGI2FJd0eGxgZsb09
   Zr4LEPS6G9GrZlK4wLbmYtrYFdpD6w1tx205EfyXETpLb0EYJhIgO/QlY
   g==;
X-CSE-ConnectionGUID: 5ktWP3NSQou16myi+e7k+A==
X-CSE-MsgGUID: oHTvFjRbQkuq0yLG0hyHZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30292213"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="30292213"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:44:40 -0700
X-CSE-ConnectionGUID: 15PrxiOATCWiEBpWeBNbMA==
X-CSE-MsgGUID: 1388tz5YQ82wIzgy4Da6Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="81473534"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 10:44:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 10:44:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 10:44:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 10:44:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:44:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf404wtd7SpntjjL//BrV9agvZwqCt4VRvUkqawIsnclhQImXxyk0hs04yroAUrqWyEqOOkvNTGsl/0zbrQkxtq8TwZzQVbZ7m6U+BI92pzS9VyTgjl/VCGWjWqcC8Ndi+qXI1p/sY3n6qsxRKa50L1lX8aooSqDBCPPBhS8LWtIaktFjhRQsxWpbXktuOv2cd/ckolob20+9awM3ZNgQVinsfYyffv/D/w2w+QRlJHZ5ECG0KpseBzZFoRRadDnSuZrTDqamF2RjkhZmu8hc+z8A4NVu2u/NDE16zcjXZ4gLYFazRhksabTfow0lViub50IbjVNZF6ET9pX/yH3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kaUyuJjVtmR8M58p4yQEiWJuIVcK2s7dcMlYtujE50=;
 b=fFyqdbGlay4AFVUY5TIjPBYqDYSZGuwc1glXH+kmNBQAh4hKYwtTVj67I80AlkIueupKfRMr28h0ekSQveSFWWx4QIpHVLwThcy1/YhvUB5c2G3HiNuFXWiGdsCmSjnKRarD6Zi5yX+ySAyl44TfKjAbeZGHvBWXFfg1AvFnGeKB6JadLxCwOeftz6hXOuXX7n0VH4VG5pb6cBM6o/625lnMzHEYa2o2X4I09aZ3cY/cIMD7AvsAZkvnZtqWqBpVzlKdFKWWLvbal0v5a0UFIx8gbDBRliLVQslKJ38700EXIpOhbp3ijpmxsbGGRQ0PKmCaefnR7li8PDh06+PdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by MW4PR11MB7163.namprd11.prod.outlook.com (2603:10b6:303:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 17:44:35 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 17:44:35 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
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
Thread-Index: AQHaWe/p8mDo/Zfb1Ue0O++EkKDe07HFceqAgCsrPICAA4rmgIAADUkwgAAHp4CAAADDQIAH5h3QgAFdn4CAADW8IA==
Date: Thu, 18 Jul 2024 17:44:35 +0000
Message-ID: <SA1PR11MB6734AE7A4969F8AEEDE30B75A8AC2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com> <ZmoYvcbFBPJ5ARma@google.com>
 <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com>
 <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFZg-9MTveHfn_4@google.com>
 <SA1PR11MB67349D5D7B0E26A49B8A1112A8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB67348CCC02DE80B2DAA4C7A0A8A32@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpkfkSMPiXrS9r2K@google.com>
In-Reply-To: <ZpkfkSMPiXrS9r2K@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|MW4PR11MB7163:EE_
x-ms-office365-filtering-correlation-id: 73a441b1-1315-40e8-448b-08dca75149d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cCMthJYv3Qk/Bsc05eeb9DqKYGDd5nEgIkg+cI+j1P0iiYcz6UXR7XuAxhXg?=
 =?us-ascii?Q?lOjQvm9r7+g9Y1KPTJTSDHElKLmSmIrgjGweEeF0z7N9lY9g43KnDmoJtpPN?=
 =?us-ascii?Q?f5cgHHeqhsE7FA6zVrlX936Ji5bEszeCog3BWphybasz8UD5D3dnyL2Gt9iZ?=
 =?us-ascii?Q?G/MNJn7Um+gd6nQRWd92zKCn6UmMpGZ6D/mDDVKlGXqpqO5p3DX3ZCUDgSUM?=
 =?us-ascii?Q?dZlz5squ1sTg6G7Q8u/mufpzAUuORZvU4+U/+Hlj1JR7wmxfIhz+d1PJ3lmq?=
 =?us-ascii?Q?V26YYOhLLp0CraWFUHzIbrt0tDfMtxm+PZJTFPY/RSq2Ejkt9Mg0KlYkcOV2?=
 =?us-ascii?Q?VUnlocnAYW0Cciw4R/noHLgRV1ISC8xWkJFgbbO8uqUotLS9okRivFsA+1az?=
 =?us-ascii?Q?6nWsvH3c7fUHeiwHRSPc4bVeT6VNDeWcJkUsSwjDLU3oltOY3uYIXu9Io6J8?=
 =?us-ascii?Q?uxdzCc1HFb9bZQKFCIvFRrxFHfxLl5lad4K9FX9pdqnsf+jNonV/6GD0azfo?=
 =?us-ascii?Q?EUrFBXqFcEqUMGFFPowBVD2eqEdrzDF7ALqOmGoELQFFAKpEbbGP89BQwN6A?=
 =?us-ascii?Q?+Y9kLBQH9WxGdUx9oMVYFvShgGHl5Y/Ie8VyBTBm3WxPlKlygpX0lGPmirWe?=
 =?us-ascii?Q?ifKi4kaifB3PNJ+iRD+nY/j3C48gfvcxhQVwbFezjzp/GlzbB43zNZeH+XmS?=
 =?us-ascii?Q?FXNZTXYKHmwfZoBCpJJZ6gEQ2/rvEKQXtmEhj41D65+QJ01thBbxc7GeJw2p?=
 =?us-ascii?Q?UivodJhmFeoSGKbjUX6j04+r+s35VNy3kGOZJY93+WDrSnkpyFmfKOWQPZkY?=
 =?us-ascii?Q?2KiaSUi3izPZKu5/jiqe4jFDd/3oLavYDKLCVOMo656ECsk2urvY2lQbAtnF?=
 =?us-ascii?Q?2nWsdM64k71azz2FPf2QNqubLjtdngcXyJ5/nISHab4RSJoeEvqb3qt8xmcM?=
 =?us-ascii?Q?zq6ilXm9ftdP1YTNmogeZzZnvr68SihFmmvLECmHTdLi147Lama+RZporJU0?=
 =?us-ascii?Q?FKPgnzAibXi2yfAZnc5Y6Tl7VNv34iuRS393bjRS/Ub7ksUuI/p3K/dCeVNt?=
 =?us-ascii?Q?o7DxRGJ/sB9NzGWCHs5FGTHasJIawOnFdsFMvTInQFhEU47YOxNF+9HL8VD5?=
 =?us-ascii?Q?OWX01mhn1pK1LPYw9wloDzASy3oyRDqdFlw2eIuT7vhCSCeD1DoWEF+p2P6x?=
 =?us-ascii?Q?Fo2stjE4tMyfzg+Wfk9TyOv2vRBYRJJnq25mw85XVMprhetdCBai+7o7z0No?=
 =?us-ascii?Q?785NnO3sri2yv6IHPAc9Twbxr+XR+MYXwKrdRAA6mMyINn/usEIabq79LJC3?=
 =?us-ascii?Q?1Kw6OwHvvUh1pLEr++Qs56ezpoVlSAjvCIz2MtAYtzPE7SeS5eKYaWp6Sssa?=
 =?us-ascii?Q?De/bN0vPFgUIzuWeU4WmJQhXDnJAWGSUZUxpMSJHOkqy8+1jrA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N6AsdsaksQDzac6caGaoM9RPCN+bYbfXrn3BBzEC4uauQVbWSwETpyE2Lkdy?=
 =?us-ascii?Q?7zos5PTg2ydvLi3oHV3KXm8zaopjgEzoOGjG1NVUYovwaeF/dEdXTpyyWbA4?=
 =?us-ascii?Q?jkRLqXBG/WOoFKyBkh7GCtjiEe8OFUDnsugMJvW7bt2VXwHwTN4B3TfetpZB?=
 =?us-ascii?Q?P1yJs6AwbtdD3tRd/hKoFDJEjFLOiD2kb9q+ron3MBGGIFiQVXp2P5z+AGoP?=
 =?us-ascii?Q?I6XC/mwTkvoqv5itTl4vd/+Tslj5P90K5jdh+Uyr7+3smuv4luNzjBzjajTh?=
 =?us-ascii?Q?OnyK20GnRE/UxTNzZiRhXVa0R5hqKnsXizWyCzk8GbBr6XfAP6TQ6qAawnDi?=
 =?us-ascii?Q?evRnPVUL3I8FKWp5fHsOQ7JMo+Jygzq7GPYXyb06p04v1nrUh2iWpWhSrGl/?=
 =?us-ascii?Q?tWs6ADb+ab6L4QiZhd8LZKHdsCgaCIhnluh7Rh5cK9IEAi+UtTICGv8ST8AM?=
 =?us-ascii?Q?5+SxYdzZzvcP6gN8f5HYkSxBO0nhHrVfX9OPy7nn/oIxKpPOTGXcOsAYGIsY?=
 =?us-ascii?Q?1VG0hu3G+vgoa4862cZA6MrQ6gFNE5Q3ldXj6XtA1TTl1LcAVoNEFxXAdY3U?=
 =?us-ascii?Q?Hqqo+3e+z52GSqcAuqxjRnTR6lV1c/4FoxWSp2D6YoTatwUyZJD8lkyRDKrI?=
 =?us-ascii?Q?R7W05gYpFiLXxU6+pM1Qo4+2U4Ji7OY0xpW3iw/Vcik1P43uG6fpu3/v9W0i?=
 =?us-ascii?Q?FgVZ8W1jWqhVboe4dpLqJJ6waun8CajqQF4Cj58vddQ+D/nghZ+JR2OhybpQ?=
 =?us-ascii?Q?IhWB9Jmfgf1IVtJU9jz7lOfu1Um/Tc/kSO8X6JqFDX0RqTabj2CVbltKHmSb?=
 =?us-ascii?Q?Dmc4fXJkK/ETkfOHgCWa6/yUDS9sGYDPVYHOB7zJBX7H/YOkn4VXiHPvjW2j?=
 =?us-ascii?Q?kZhn/kQAdCy7T3Y0qIdwqzZOumEldEuiejEE88ptjxtbffI05T4H1vPL0ulx?=
 =?us-ascii?Q?EbIiJcmkXXx3ZAoo1TMPs6Qxsz/HxA4XxabyTqKsAluY47HoqltG1OrWB3vc?=
 =?us-ascii?Q?5UD495UBq5k4BWMXilyFBvXE2/O/HSlJ2czmB6a8OaaKM4gFLAOpUcAM3fSq?=
 =?us-ascii?Q?tqe1l7sAVR9fFgCOPkNBv6NdhMbGTsWrUjCZkzr6UYh0DCM8w3Q1m0JwKENZ?=
 =?us-ascii?Q?8uR29BaCv6gGOySH5pJbkxZWO6yADst9dDqLd/+V7omBWGi8PEHwpuNbQeUM?=
 =?us-ascii?Q?fbZ5RbNS+CbqfTwcba1d8bm3+Eb67JnyFf7vQpbgyu1tPxzTpZP6uA5q7BzS?=
 =?us-ascii?Q?KtyYmUQuBByyRpIoepzQehZZapRnCbVYUKys4TdCTvMrdREorElPT7nTkBV2?=
 =?us-ascii?Q?5lmvryg+JXcxolj7B0vc43VEzMR9zbqqRMGTAcvi04OWp511IV9e1KmZgO9E?=
 =?us-ascii?Q?Y3x/44SA1v2Sof2IIexKQVlee+RXYrpxkAWI82LitNZD9AiRiwPRQomV8zpj?=
 =?us-ascii?Q?s9W2w90GwlogYEH3b/9HOGjutnvVF4cG6SbgAIEk1Pt4fCykAN6it1RJB9eu?=
 =?us-ascii?Q?Ea1QaA4LbmTPaPcJcFAMcBfRjzdpdLGAB+zBs6Y1klHSJjrYL+ay85RFBIBR?=
 =?us-ascii?Q?UDVHF7l0oIOsWWvnztg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a441b1-1315-40e8-448b-08dca75149d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 17:44:35.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2y9dQiYCh+jek1FA5TtGintgmx6QF20y3XO1ReP6r6YIMPO/mUdTk6plvvo2uci+l/Mrm4dagYebPIm1eap7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7163
X-OriginatorOrg: intel.com

> > thus we need to:
> >
> > 1) *always* save guest FRED RSP0 in vmx_prepare_switch_to_host().
> >
> > 2) *always* restore guest FRED RSP0 in vmx_prepare_switch_to_guest(),
> >    because sometimes context switches happen but the CPU does NOT
> >    return to user mode thus the user return framework detects no change=
.
> >
> > So it essentially becomes the same as what the original patch does.
> >
> > I guess It's probably not worth the change, how do you think?
>=20
> One idea would be to have the kernel write MSR_IA32_FRED_RSP0 on return t=
o
> userspace instead of on context switch.  As is, amusingly, there's no nee=
d to
> restore the host value if a context switch occurs as the kernel will have=
 written
> the new task's value.  RSP0 only needs to be manually restored if the ker=
nel
> returns to userspace for the vCPU task.  Using a TI flag to track if RSP0=
 needs to
> be loaded would avoid a fair number of WRMSRs in both KVM and the kernel.

I also thought about it (while in the FRED ERETU code path), however
we will need performance data first, even an extra check
(ti_work & _TIF_NEED_RSP0_LOAD) seems neglectable, but both return to
user and context switch are hot paths, and I assume return to user is
extremely hot.

So let's revisit it at a later time?

> diff --git a/arch/x86/include/asm/entry-common.h
> b/arch/x86/include/asm/entry-common.h
> index ce8f50192ae3..76724cc42869 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -57,6 +57,11 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct
> pt_regs *regs,
>         if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
>                 switch_fpu_return();
>=20
> +       if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +           (ti_work & _TIF_NEED_RSP0_LOAD))
> +               wrmsrns(MSR_IA32_FRED_RSP0,
> +                       (unsigned long)task_stack_page(current) +
> + THREAD_SIZE);
> +
>  #ifdef CONFIG_COMPAT
>         /*
>          * Compat syscalls set TS_COMPAT.  Make sure we clear it before d=
iff --git
> a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
> index c3bd0c0758c9..1674d98a8850 100644
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -71,8 +71,7 @@ static inline void update_task_stack(struct task_struct=
 *task)
>         this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);  #else
>         if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> -               /* WRMSRNS is a baseline feature for FRED. */
> -               wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_pag=
e(task) +
> THREAD_SIZE);
> +               set_thread_flag(TIF_NEED_RSP0_LOAD);
>         } else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
>                 /* Xen PV enters the kernel on the thread stack. */
>                 load_sp0(task_top_of_stack(task));
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c index
> 5c6bb26463e8..cb7e3bcb001f 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1338,15 +1338,9 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu
> *vcpu)
>=20
>         wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
>=20
> -       if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
> -               /*
> -                * MSR_IA32_FRED_RSP0 is top of task stack, which never c=
hanges.
> -                * Thus it should be initialized only once.
> -                */
> -               if (unlikely(vmx->msr_host_fred_rsp0 =3D=3D 0))
> -                       vmx->msr_host_fred_rsp0 =3D read_msr(MSR_IA32_FRE=
D_RSP0);
> -               wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
> -       }
> +       if (cpu_feature_enabled(X86_FEATURE_FRED) &&

This check seems unnecessary, I guess you add it to skip the following
code when FRED is not enabled on host?

> +           guest_can_use(vcpu, X86_FEATURE_FRED))
> +               wrmsrns(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
>  #else
>         savesegment(fs, fs_sel);
>         savesegment(gs, gs_sel);
> @@ -1392,9 +1386,10 @@ static void vmx_prepare_switch_to_host(struct
> vcpu_vmx *vmx)  #ifdef CONFIG_X86_64
>         wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
>=20
> -       if (guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
> +       if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +           guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
>                 vmx->msr_guest_fred_rsp0 =3D read_msr(MSR_IA32_FRED_RSP0)=
;
> -               wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);
> +               set_thread_flag(TIF_NEED_RSP0_LOAD);
>         }
>  #endif
>         load_fixmap_gdt(raw_smp_processor_id());

