Return-Path: <linux-kselftest+bounces-11883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC5A907A8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B011C22F3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57F14A4D4;
	Thu, 13 Jun 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PB2+PdHV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCB12CD8F;
	Thu, 13 Jun 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301782; cv=fail; b=KwuW1s4bbNswhX8n5lemJVfeo2QTd86v5SYvZycevEjkoM1+iiFTgjI3IJ4gNx0U4FXx0+dw1d5X1AMdkXZPP6s/VAVMq0JSTcF2Xq5MvkcyBdYZedpZatSLZ0gENBgeT/clF/OCfIsyU8xH+hw8jcPsfOamfn0lKRBvCjiXNe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301782; c=relaxed/simple;
	bh=pBkW7hXdvnPMiCRbMgjJ4T+SMW1oosA/snoO206fYBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upA0uF6jrcJ9Zgztzh5loLGKC3PFLrMcHm7Cs01z3GPbO1+FzfJ5QDeLdbn5KHUbtV7YamrEAeqX7X0hCV3/qlb4XBMza8TMYrGWvs1l519f/cdexjDikS4qKIDjGOCnjrBYH/bG70MhtysptSU2dXGIOtE+CafpblJuGcs0ECE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PB2+PdHV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718301780; x=1749837780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pBkW7hXdvnPMiCRbMgjJ4T+SMW1oosA/snoO206fYBQ=;
  b=PB2+PdHVyMoSAS+awTFMRcO/Njx4UI0eRFt9A/buoomdZYUBWpXu14Km
   jxWxw71+C+SmZgcpuYdVtuQjHtPIL/4XpJNK9yZGejS2T1werhWhwUuwA
   Q6hWqX9EyRMHHwNh3EVrKtM1Avg/OQ/QVR10heMlbKj2d1aX6+M3Cnyio
   axmnhn7M3uNpAUkVoGHr7pAiVv9jD96Xg313EqRh8YvIhTelZHENlUA7R
   T2e8ZmV3QnuSZy1aXULFVEZnePD/uxMriTaty9yl3t2Wo8PkhT/nLLPC4
   kQbtoTixHDrj4PO8SJD4VVbQdZrDO2psn4WhHLd923AUxTuIaMSQdRNZd
   Q==;
X-CSE-ConnectionGUID: 8iuaQQb0StOzk3rHszPE1A==
X-CSE-MsgGUID: 6/4IEL8tQZmFOG2Ik82u9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25825591"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="25825591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 11:02:59 -0700
X-CSE-ConnectionGUID: YIC3Cb7WROOcexif4IxbmA==
X-CSE-MsgGUID: CpJ0dBTMQKGrod7M+p1Sww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40351122"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 11:02:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 11:02:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 11:02:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 11:02:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 11:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2cgdA8tkUxTaMOX2i1M/wgRRfO7GVK7VJvqQ/fRk6ooR5xyhy896u9Za+jHRAqa8Mo92ghreXN5GaPnurXxuZH6rhjhE3kh6MWu8P3LswTtZpU8boYfHePRMqTsawgX2O/iBYFNvWOI9mSkr99OczekaK4klx/qOL1TqvYj2M5s5+BaIKb/2S1J6y56i91HKVf1PYjjF8Y2xbAYeCYr42IP4vxY/H9FGr0RRNU/chDeXa9qGuSAFUCdV+NSqhB5ZEXTO2RKgpK2Ona74ntLadPYRP0h7EP4sAcJBJWho7m6YnWjoOEXWqz/guMqgc6nvQR3aK0t2v1oWVXxMXAD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dj02pn4mphZ91kDpBxTpcgiQDNluhIjnyAB484u7Cg=;
 b=NE1/ZCSPzaTe/lbmrvA+FJaDJiTf7VoFrd4e4PZyb3CRBUWApVhr0f8yt+nbSJUBAD2eoKQk1kUqv+a0KNVPsFTnOnWNeT8AgXiFJunXUDwkxQML5RMMziIlZ7TPSm1HtgCZe6qmY1Lc6KT7RDx9mEsmIqjf4Nddj2do7YeB+FWmnOfJv/xqRcZ6vKUlkGEE/1YuEd9lz5eOuRNjcKMRHS9zd1ojx7WhjpKBy4r1OG2CQgOG4hUezGMl4OftjclnYLP1bdSEh9CwsTnkZ6SaBAwU8/Sr+rdbZpWG/NhDDsNPjcpuQWe/z0U5F81ajDRzBscPJHWv8+yYSAtTQO97MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 18:02:56 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 18:02:56 +0000
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
Subject: RE: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Thread-Topic: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Thread-Index: AQHaWfA7ZVshGt6l4U6e8iRthcdnlLHGsbqAgAANdMA=
Date: Thu, 13 Jun 2024 18:02:56 +0000
Message-ID: <SA1PR11MB673412E7813B659F16284B74A8C12@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-13-xin3.li@intel.com> <ZmslBVWkRHAjIXrE@google.com>
In-Reply-To: <ZmslBVWkRHAjIXrE@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH7PR11MB6006:EE_
x-ms-office365-filtering-correlation-id: f505d74f-590f-4796-d3f8-08dc8bd30d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info: =?us-ascii?Q?/agGxY/pEpcc7Z2Wzxuzxl5MZUA4mxLet+4NAk9yMGR8ILgrNGpcIHVFUxkA?=
 =?us-ascii?Q?A4H35wpJF0eGMq9F388Lsize0UeHVMrg2V0tyF54Q6mqFSdve7O7918k3qJZ?=
 =?us-ascii?Q?BamJhifLRvkTfPiIcHB5BGQYY4Yl9Ljl5qaWRHNANe0zelSdP6FYmcNBiCwk?=
 =?us-ascii?Q?gwJKhCOCxemrK2CinLWjLfShyuZvBUiw4zrzeQ+WC8DcE73/ZgJozTTD1L7v?=
 =?us-ascii?Q?RuZSfQTs6Fw9PPSYpxpyPk947LTBf3pAORKVY43CWR6dfTZnNL2e3xYHFdaB?=
 =?us-ascii?Q?JdxeH4gOtk6nLNtWCSv5LNAQw39FcDJgBPO35kaDEBEtbT2eBbqVNdaidUVU?=
 =?us-ascii?Q?wNhT6HRxf2pjQWJ3mlZTNwl2x/opWjmBNMHp0nn6q2Sskt1oBwstCk/PVbvb?=
 =?us-ascii?Q?MAJnRCxsgBC8Jlo0qzMH88Dx+v56HsHDai38K5UI7X5KK7cjCjtKwTuVDxgQ?=
 =?us-ascii?Q?QPSQeSfDUQBBNmSuDE20pIBfkLz30R038vNM38/ghhPYngBPzh4FU2dVpxAx?=
 =?us-ascii?Q?qhC6J7RTXNd/tQYtLBtgFkQ+/B+Wo0/SrPJ3jtCJS4iB7ZnyzJvtd43nbVKe?=
 =?us-ascii?Q?XWMkTd52HOm1VNKNPdAfYkZL1a1bS7UBz61KV6jqZhE0eJjU4oX6fnJy0rrb?=
 =?us-ascii?Q?nWPqbjMhF+yWUnV6Pa+tyouwMwH/84F4G+A2F6ZNPbg+q0vCdXMqWlFZ0+aC?=
 =?us-ascii?Q?2yvViNaKvhIlHdB7d6F92Ngtv1mzbPJ9aOyoA6M16/CvY+AKlrA24hNa2icD?=
 =?us-ascii?Q?NsG8Z/qOXo6Ziujg45byaKOeFZ2APS1jtDHjho7aYRZdsdPrNd/mm9cjqiUd?=
 =?us-ascii?Q?LC3dObFWdBJhnMf2KY1wMrGRbhExELs8hQgW5/Vjsp2zW0vIqd8DUAcTHt2v?=
 =?us-ascii?Q?VYURgh8KJe42SZgkDpgVKWyJwgNue/2ulPkM9ZVRDBO9hc7Ln+gavPggOdu5?=
 =?us-ascii?Q?BBigHa9BW+sHJlWnSS9/jGurndr0osK4Wif0XerpvQF2yoN245U6JriRgEBs?=
 =?us-ascii?Q?aIH76COIx/aZIj3u0MwGjMiOv2l4Y2mQAWwy8Qh0L+rCT/79lIdHx7pxVzPv?=
 =?us-ascii?Q?7YItGCUGoPdSlf/KjzHL978pY8UVddyQ8J2T1dhGt4ziGp0ZO1fVtnQy8xWD?=
 =?us-ascii?Q?umOBR/NWS0ac25TlZwNVk40YQtFg39/m/a84sOC7eafL4Eomf7+urA2YIGba?=
 =?us-ascii?Q?mgcCojgqjgudASt40dcFXdkBsBkTwEmWOW2oFN0RfbL9teQlMn/9ewVNHjP1?=
 =?us-ascii?Q?+V8MehnfaviNcp3sbxttqc4pmlgo5AJNRLSgMP3w807VjbQPUPAo2k9DFsaf?=
 =?us-ascii?Q?ldOS/zgrlukXGz/OZWwU3kb+QbWFDzYaxfgEzQrhtEJShPhswFdOEgXef9qN?=
 =?us-ascii?Q?zvTJW5o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kAMvL502CkZ398Xe4sYBCjNZr0jFk+KtOz9qWtlix9mydV0NdeIvarz8cPEn?=
 =?us-ascii?Q?w9zF61FqpZREYzc035aY33mga2E6vxMi62vX6IyED4Lkcmg5rbsaLSa1QUff?=
 =?us-ascii?Q?qAZOYyNGpzh9R8YaemDE6l+ghMhoiqQmhFhu9lJ89Ri+FgQS44JeYihCpNb8?=
 =?us-ascii?Q?YncI5kOqkJe6PFtCCYHF5Ieo9LV/mYaFV3bnuMZLID1DUlfLZUKjUXIc9VZ+?=
 =?us-ascii?Q?U5PI0VE0TBialoOj6mCEnZyTY9jsfUOMo0DXRA7oNnwlKGDmcZOKZVX+EMhA?=
 =?us-ascii?Q?cMD8wzr17giV+syVrsW6XHyzOd5EVBsHAtiYFTHHApMuf0JdcrqMuk+7GgSA?=
 =?us-ascii?Q?8fU9GYBjvJjl/oQf1HsR89aMEEw7n3GwQcYDTbun3rFIzs1x0LY4xAcOwJdw?=
 =?us-ascii?Q?p4w0Erxn7md1JPz7vKRPDuOsyViNrweArhLLvMw8nNN7qCrh+PcYT8bPG0l/?=
 =?us-ascii?Q?lfUe9wYI/DAZX6Z2Qm2LNyMJ97FbAiiEQ5yzIg0jj114FQgNGIePjFwc7zcZ?=
 =?us-ascii?Q?5b2ZGlyDcia6C+cntnUPLZNOIWbRlloXSWqtbwh6c6r7RW5D98hc9lYWa7du?=
 =?us-ascii?Q?arCLq2KfvuTMwRqU5M2eJ5OphnFAZdcVyT6wNTH3XO1sbN0zLmpCJJ5smb9B?=
 =?us-ascii?Q?sppE+AmZbkhQG8pvDjJOCS54fyw0wP2ToTO5m5Bu0/h7oQ1XHXBft82GEdUu?=
 =?us-ascii?Q?1/PhL0r8XP7NS3yEGHcWwOpeW+3ue31AMfvrxRPV+I+ohMegJMj5Xo1EAK12?=
 =?us-ascii?Q?jfJJVhoEkIBDbp6eqhcLLiJzXUSQd4XzkuLylvH1kI7D1xdUczxx6RzWpjXV?=
 =?us-ascii?Q?VWLPxWozkT2g1ZTqIbmVrm/1yzvkM7YKPR2RqXIOCxg5EH//4AP66/OG6Zwy?=
 =?us-ascii?Q?l793yICPjxvm/7OYhxQOkIYk4irDn6MzX6Td7+Oj/a+3w8aOBjDPbe9MH/pY?=
 =?us-ascii?Q?nmm2J35vjH16axALdswpTKxYVVKiqlsiJ6hefLXizaNbgg5Ha/K6E7hwP+pu?=
 =?us-ascii?Q?KHqqTiiGD9DpLw9Z+U8UKwnrDBoxlvZON1tw2kE9kjsxHVbiBWNTx/c19UHx?=
 =?us-ascii?Q?zF6jB3GklK7LzyHIttu6VadL0Holctq/KEfjl0tdJz4i8tb2r8x7D83PNuyr?=
 =?us-ascii?Q?scqB+NkSTxf7FOnInhtXOPJoyv8EWoU5C4xx3g439u9uTlTgrDKfh3NOZj1I?=
 =?us-ascii?Q?HPOMweZmrkbjgNrrdFjCr5RkufIOmUkICLOopBnSd0ZgH99MBMgtjQdhKTou?=
 =?us-ascii?Q?GB5QnqS6Omg9vCKS9MdsTS5l7Pn1EiVyN/FE9e+uLYhn/9iBnp9RC2NR+Lbd?=
 =?us-ascii?Q?lUJxpQ+Bt8AoMoivNyIFdzGpGmVp/3vdghMr5pCSO5G1FnWSOzTr4j29r5Uv?=
 =?us-ascii?Q?K4ukzuFgXpdUhRnAqcSBH5/lLTdRh1EPXMk7spQKkXiFYRJPmUXvCB88oQNb?=
 =?us-ascii?Q?4pJ5OlRGDeLHVK5pzcvj2tSJONOv1xe9Gd8xHJ48+GQQeUzoutmKrcLYUVKd?=
 =?us-ascii?Q?+E2SwPOEpEEH84EmQCLfJBc0AN1AwmNFYXPy6k2yY97DLIDHK31hPJ/9+tNG?=
 =?us-ascii?Q?yruvBp8eoovvUAfAsHM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f505d74f-590f-4796-d3f8-08dc8bd30d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 18:02:56.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tJuofnfj/Z8lPSyhGTtvB9mcXBUj2hVJo9hiFzUqd8jnR2TeCmkhkBx4I87Od01lN7P6jmZCHVZrcdjyLP2vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6006
X-OriginatorOrg: intel.com

> On Wed, Feb 07, 2024, Xin Li wrote:
> > @@ -7382,6 +7419,24 @@ static noinstr void vmx_vcpu_enter_exit(struct
> kvm_vcpu *vcpu,
> >
> >  	vmx_disable_fb_clear(vmx);
> >
> > +	/*
> > +	 * %cr2 needs to be saved after a VM exit and restored before a VM
> > +	 * entry in case a VM exit happens immediately after delivery of a
> > +	 * guest #PF but before guest reads %cr2.
> > +	 *
> > +	 * A FRED guest should read its #PF faulting linear address from
> > +	 * the event data field in its FRED stack frame instead of %cr2.
> > +	 * But the FRED 5.0 spec still requires a FRED CPU to update %cr2
> > +	 * in the normal way, thus %cr2 is still updated even for a FRED
> > +	 * guest.
> > +	 *
> > +	 * Note, an NMI could interrupt KVM:
> > +	 *   1) after VM exit but before CR2 is saved.
> > +	 *   2) after CR2 is restored but before VM entry.
> > +	 * And a #PF could happen durng NMI handlng, which overwrites %cr2.
> > +	 * Thus exc_nmi() should save and restore %cr2 upon entering and
> > +	 * before leaving to make sure %cr2 not corrupted.
> > +	 */
>=20
> This is 99.9% noise.  What software does or does not do with respect to C=
R2 is
> completely irrelevant.  The *only* thing that matters is the architectura=
l
> behavior, and architecturally guest CR2 _must_ be up-to-date at all times=
 because
> CR2 accesses cannot be intercepted.  So, just say:
>=20
> 	/*
> 	 * Note, even though FRED delivers the faulting linear address via the
> 	 * event data field on the stack, CR2 is still updated.
> 	 */

Will do!

There is a reason for this comment because it won't be architectural:
https://lore.kernel.org/lkml/c0c7c605-d487-483e-a034-983b76ee1dfa@zytor.com=
/

FRED is designed to atomically save and restore _full_ supervisor/user
context upon event delivery and return.  But unfortunately, KVM still has
to save/restore guest CR2 explicitly due to the issue mentioned above.

Thanks!
    Xin

