Return-Path: <linux-kselftest+bounces-9996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F538C210E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519C31C21824
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EFD1635B7;
	Fri, 10 May 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNmLrY78"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F916191A;
	Fri, 10 May 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333771; cv=fail; b=qDz4jELyHd1KMEQVHNonPhixCsTOZr5uATfgmgISVtpzjuf59ad+0w+OyqdUpc7uxMUVLj6yzahoYEDeE1WDOU8ITBG/7GQouSkQ0/FuiTOHGDGpR0J2Tckxt5leHenT4k6ymmNT6uHzT3l1BpEqX9DaBBiFtFJOim6eKrzymFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333771; c=relaxed/simple;
	bh=FH55o4HdWNK0UbB+wu1f4cG0a+XoC1n987x2Rg9UvRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gdm2F66Mr+x4knevgvSlbCp6caZhwFgbi9b8I/GnueZzkXKRwsEUTTdcvm6NnMUr1nx3nOovVRYDji/LiVmHCL6tMTMJPnhxAZHDBEYOH7SKzfLlHYsMBT7Z7Cpx2MrBZ3vQCDXzJ7DfPYRmYiqWX4XHdmIKUNCCEwrt+EVH3l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNmLrY78; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715333768; x=1746869768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FH55o4HdWNK0UbB+wu1f4cG0a+XoC1n987x2Rg9UvRg=;
  b=eNmLrY78EI53g5Or7EmTGBklT4ntkbXNLCsdSpH3qvKtcjc57VUFjhtM
   KzbqUP+XU42ine9ESbhKJ7lWilYnYByiXg1i3f9IAhI295ujQqlxJLKB1
   Q7JlQC8q6OHHCNkIWpsVOr8jQ81FmRgv22cSDQf16K2Zhq1hCn7v8q3/n
   NgLrd3uOgw9bdZWGlV/UJ8Eqgn5bhxSIIF/AsJHR89d3QhcQV++P7r8Lk
   yU4EbeiggOk82fTldm/wsw7IT1+5VfZryJ26oh3w8LeiEy/xEOB6CeGg+
   aAoHrp1CUqHyXKqJn/QynYRP4YEgaURqiLGbJ/bYnPmEEFoaMTo7Gy71l
   w==;
X-CSE-ConnectionGUID: QsdKcqVwQcydLAj2ru8zWQ==
X-CSE-MsgGUID: /YPn8bR6S4+sj39GxAuY9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="36684480"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="36684480"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:36:07 -0700
X-CSE-ConnectionGUID: yJSAFGwqQbSXUTzMP7A9rA==
X-CSE-MsgGUID: dvdRJEO3T/ilOhhvDDre+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34074651"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 02:36:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 02:36:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 02:36:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 02:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkQxOWBBiVLUdmfnTn+szqffuuFYAPtrCpPx7fxgQbBLz2/IHaMwF31slCGG2243qj9PnbjUpIGu+p30pKuHRkGk2qZpoZK/uu2owt624OAlktOqEZMOmERk7jmEnQLY4Kz5P618V7vsAf2j6kFE5NumpmDfR7LMH2kfs77Cjn72pEYNnLBWjt4J1Dqfdlwhiti2hSUDnlOT6mV/7Y72z7ALWToLE9zFOScrJrr+SIk7Jz9ZTFqzVydEPw3JdUNmzRWMnkwoNsq/3fIpTewAEKW5QI5Io3gTpwYnW3mdhI4jdulvCTfshFm5EA2vU7H6WYk48M5V9ZlLoGR+D9NPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy4O2LfpRlSQC1P/mj3qa25cMYzxb+DaorzYNobl7xw=;
 b=P0vLWAe7dK7EEwZouZCoeJSmRcB1saKcEpc2T+P/yAeO4nFaRKzhyeGefAwJmsjjPaHuQGgIV779PEo1sm3ZvQ4GneHaA/KYwU1YI5s0mNsJikWZf/aez4U1cWAeZ91fiCG1DMdFtOV/RBJOsPHRmwJsWjSOTsudfEbBp5EBgbQgn5Rnq2sDBAtO6D/zypa8AD4tgmMuzb5eGo5IIThDFyUHI4IShz7ucIZsC3srf+Us8GuSDFcrb4unF56vJapZWTH0RSu2zu94mvMS34EOLWI/cRHAdrFY7zezbOdRUIoXfmq+z1yJ9UI6JrwshaSZXktHPJvLajWbkgDY2LChHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Fri, 10 May
 2024 09:36:04 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%3]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 09:36:04 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Thread-Topic: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Thread-Index: AQHaWfA7ZVshGt6l4U6e8iRthcdnlLGApUEAgA/9uwA=
Date: Fri, 10 May 2024 09:36:03 +0000
Message-ID: <SA1PR11MB6734740F9B6085E0997A4179A8E72@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-13-xin3.li@intel.com> <ZjBiLDJ4SdQ0p5xm@chao-email>
In-Reply-To: <ZjBiLDJ4SdQ0p5xm@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA3PR11MB8118:EE_
x-ms-office365-filtering-correlation-id: a38be1dd-557e-472b-bcb3-08dc70d49c74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?PEZ12CEyMSY6wo4DWfD38Pq1NC0vvpbLyci3xy0q2q2BF6re0OqfQmbaptTY?=
 =?us-ascii?Q?gIBTf1DSlD07pGZ6s+QKu3c6k63B9k2zqDo4Qa07KT0lVvdarrDqnvGtN3ts?=
 =?us-ascii?Q?aHT7nvgnXZpbaCf7BDYvtzR3bTTgacVg8T85VBv+BsApat+TMksUcz4wdabK?=
 =?us-ascii?Q?BI++J4eMK/31XlYXbm/RfoXfsCLPzNWuEgcudJvO4tcjgM2Q4fDi0LJRWqTR?=
 =?us-ascii?Q?mfvYBwsnJPUcNwx9QM011bcA78ZQlSJ2qJo7BYEaNugjOWcDaNVVqeAoUcF9?=
 =?us-ascii?Q?W85yo1iPYL0sHQqPzNn7KjQ5IEb0uYNlwa0XXlW/GoBNLJFl9qaIfBRiZz/k?=
 =?us-ascii?Q?2YiMVpYkn9LoehdW/7aDAFK1kUVRbjQlq03oMmiDordUQhYOSTpqNQQrCPqI?=
 =?us-ascii?Q?y1Ag3XZOsPmnn4iDY6N/03fxwARS4KSmkLqO4FsmZcvCvi0dGtC6PXT7Xa99?=
 =?us-ascii?Q?IsuZCGnaA7T0qOrgq6hloz9NeFjXIzJEMXY5SardR70QxjG7nRXCphifFcyg?=
 =?us-ascii?Q?WfXwE5X2PZjn784g7CRjsQaS9cG/ucvrSm/OEkIbQTw6UU8SypSV54JLHKLX?=
 =?us-ascii?Q?Y5lgFhYJDY/ygJRuSgQE4xToBgxcv6RUZJJw4B4ZFTpySZsgKiiBpZt2q1wN?=
 =?us-ascii?Q?XIkhayPVf+XmOVDNR93+YVuy/i6VDsz4o/GcS0+gZRMF7DVLKG6L9yanRkRa?=
 =?us-ascii?Q?12DWLZoux51Xct9PbRoOZQz/lH+jEnyJOEBibEMktMzqOFkqaGBDYfhWJMOj?=
 =?us-ascii?Q?h3jLVBd1HtwS9mT6fyAyI+/nKfQCKbLJWEPREQGxoPRxjiWu86tQmbpEKvt6?=
 =?us-ascii?Q?kadTYS6yNy26IM9rYGqZXGpoJ61d6fEI6FLEHaKec/aWhchImhsmhKEoZ5bQ?=
 =?us-ascii?Q?nWiNbjySeS/RNh6a2bk7CpWD6z8Bjupy/0W5CGGnszcTjYQ+712BQYOqCivB?=
 =?us-ascii?Q?TvsmuMrE8nzq37sL9akUj/ZeQ7JH8/da7xYtyeapyLfSZVm16Ng4b1PTcQhz?=
 =?us-ascii?Q?72CxAwclDavgqH0I2LhY4HmLmyTXPJhLcNN/+eurctbZ5L3LLSEhWPNcWV1y?=
 =?us-ascii?Q?HLDIbaZYuuxJUfx3uFMmJcggSPYhC2SuXoRHbZSyi6KJc1cUN5rpuotK1uT1?=
 =?us-ascii?Q?S7W1EE/3oBP+O2urxNf50KFY0rI/P4E9htn5kg7rLQSa5H90Qv78YuWzWkOX?=
 =?us-ascii?Q?PvqI8RIofx0OEvFAju8fQTVtw1LCn5r+wmf42Psl9ctSnpXIIZVcg/o3U3zh?=
 =?us-ascii?Q?f8d/+6A8niAqRLhtWgEwO2rWmfsDUM2KSSwvpph5sK9BErlVLuTF1lTphrYt?=
 =?us-ascii?Q?wvnTWtAad3i0sRW1OcRinHuhkNGX22AynUQpcdUXLBTZRw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bu6y4b37yLEj0XLo3Yv+m2XgqltwgRuCwVFjK3OhcRW4tsY5HqyJb1yMsYAz?=
 =?us-ascii?Q?rmk+qH5FrIzUSdACu+OR9M1in9T2REO6IA24TdwlUrCeIpzSGyxjvJtQs6nM?=
 =?us-ascii?Q?SerjWAsfmoEIbFKIC2RCj2qrnswyYyYQ7j6fmq3d3JLOTUaBkwvosYN8G9RK?=
 =?us-ascii?Q?0vzPC8BBs6MekB4aM84IkpA0hwloGgsmkYw9ahOnYrXq5s1PW8I93FHccZLP?=
 =?us-ascii?Q?Z8zPsYwFADGHvLH2XQFLgTh3VRQrkG6yBF4dEkx4mYgay1p9eSNL0cKCoLzc?=
 =?us-ascii?Q?Gvus3EMIOihsQCskDAPRMNLb2TteJIYum3s0dqwDERFWnbXwJeJY2WH+kD/k?=
 =?us-ascii?Q?Jj11YRAc2qAlruTymojN8R9DqeT2jYSxFYr5gFhRjDxQ68yWSlxCumZSCciC?=
 =?us-ascii?Q?/oGo3ODHndEY9Tf0PiaweVfDD73+gPP39Jbsp59kYc+TyclFFDiS5tG++zh/?=
 =?us-ascii?Q?Zthqn5ggqeLpDvo0bv76ZiVjxmo9gWnaztG1MvwkW3JlLnFBcUtwf1tIDDQh?=
 =?us-ascii?Q?sRTpEoEo6+1KlkbK7v6CEjVFdZ5d7QdiU2kLJScLkUevYW+39121bWShlRiq?=
 =?us-ascii?Q?X4CLABLgft8F+NJjSUXBH1LxLZjrxB9IZ1nKXQ00Ljmft5JyJIJhBK1kz6KU?=
 =?us-ascii?Q?p88vRR+2DHzR61gdvnkN6tUNudXe9sw0KXOPTg7FLxn8CwypYE4q0qnj5GPD?=
 =?us-ascii?Q?438t8/jX4uqLjzN5xuHp+cLi+D6dkpKF5BbEof8o6eYbfuKOOzCqZPSf3ASI?=
 =?us-ascii?Q?YgfmjJKjzZVC5Iyhl6gPcveZ4p3FcWDC+ZAm0rQswYissGs92SNGH3WfPsER?=
 =?us-ascii?Q?BQ+zos7KOmXrsGe1WMAgu+SD8vDL1tRa/oI/dO+PlWYbU6kBkGQSNQ4BCh6d?=
 =?us-ascii?Q?Y0P0wrphS2U5CiAm29vEwDpg6r+6yIvS9670/mouemtkzR61UT9O1s58Zgwl?=
 =?us-ascii?Q?yPDZ9SW9w469o0opM1N7kCVVHrfmRMmck0T29z/PAp8wsFYbghKyu5A0B0qJ?=
 =?us-ascii?Q?Qdy95nhJmrzYuwk+cxOfnyXBM2pEnXwbWvD/HpzOYhY8feVysodCtsibx1Rq?=
 =?us-ascii?Q?zvId3PXZyYKAgX+tdwuBDe6hn+RjYC1TwNj0qE/ClyGlkY8yiqZRa4sfaqtG?=
 =?us-ascii?Q?JkwzuPqhtxAw+wgFcU0Kvo9biUKZ/ITa4R/Y8fo+N6RdsUjehWlsP3igqx26?=
 =?us-ascii?Q?Sq1D39hbqXXZtu/2bMYWEnoNgcZMDOVvSThuPuJci9D8Uy+lk7BrH2aQokDv?=
 =?us-ascii?Q?m9JMwuyv5VWWJrZ3QNVRd8v9PruYYe/nY4IUZpgyokeqDRNNXbobyrh7oZM6?=
 =?us-ascii?Q?r20AwOaBf9yL+dL6iJZNTnhsqMcnCpNxS0qnbOAQ2Psrv5qXx7pcNuONFsZQ?=
 =?us-ascii?Q?ohjMueAI1GJkZYmKwjy8lYP6qI7ZAxhdD5+DI1XiPC7q86SOJ3QJeJaTaYp4?=
 =?us-ascii?Q?CNmpNL0RzixRbHk0KZSNiWhiAUHKbkSQ+w3j/RMUt/hacf/QycqZvwi4sXnr?=
 =?us-ascii?Q?Kf+GaElN2X8RCjdHDDzLgUIj5Y52auv637WiU+hp+gdV+W4fd6833b4kb9tn?=
 =?us-ascii?Q?AlAjHzqbLitGpKRlC8s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a38be1dd-557e-472b-bcb3-08dc70d49c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 09:36:03.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uv+6LrdFJS4H3QUNwppUNUMxqkTyJZElP+sdcxPx/19f3D8svhtAguFouxi5X9OKqWg+8YzmTjfBHFGA3YBZMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
X-OriginatorOrg: intel.com

> >+               if (kvm_is_fred_enabled(vcpu)) {
> >+                       u64 event_data =3D 0;
> >+
> >+                       if (is_debug(intr_info))
> >+                               /*
> >+                                * Compared to DR6, FRED #DB event data =
saved on
> >+                                * the stack frame have bits 4 ~ 11 and =
16 ~ 31
> >+                                * inverted, i.e.,
> >+                                *   fred_db_event_data =3D dr6 ^ 0xFFFF=
0FF0UL
> >+                                */
> >+                               event_data =3D vcpu->arch.dr6 ^ DR6_RESE=
RVED;
> >+                       else if (is_page_fault(intr_info))
> >+                               event_data =3D vcpu->arch.cr2;
> >+                       else if (is_nm_fault(intr_info))
> >+                               event_data =3D
> >+ to_vmx(vcpu)->fred_xfd_event_data;
> >+
>=20
> IMO, deriving an event_data from CR2/DR6 is a little short-sighted becaus=
e the
> event_data and CR2/DR6 __can__ be different, e.g., L1 VMM __can__ set CR2=
 to A
> and event_data field to B (!=3DA) when injecting #PF.

VMM should guarantee a FRED guest _sees_ consistent values in CR6/DR6
and event data. If not it's just a VMM bug that we need to fix.

>=20
> And this approach cannot be extended to handle a (future) exception whose
> event_data isn't tied to a dedicated register like CR2/DR6.

See below.

> Adding a new field fred_xfd_event_data in struct vcpu has problems too:
> fred_xfd_event_data gets lost during migration;

I'm not bothered, because this is not hard to fix, right?

> strickly speaking, event_data is tied
> to an exception rather than a CPU. e.g., the CPU may detect a nested exce=
ption when
> delivering one and both have their own event_data.

No, don't get me wrong. An event data has to be _regenerated_ after
a nested exception is handled and the original instruction flow is
restarted.=20
sometimes the original event could be gone.

We don't say an event data is tied to an exception or a CPU, which
is just confusing, or misleading.

> I think we can make event_data a property of exceptions. i.e., add a payl=
oad2 to
> struct kvm_queued_exception. and add new APIs to kvm_queue_exception* fam=
ily to
> accept a payload2 and in VMX code, just program payload2 to the VMCS even=
t_data
> field if FRED is enabled. KVM ABI should be extended as well to pass
> payload2 to userspace like how the payload is handled in
> kvm_vcpu_ioctl_x86_get/put_vcpu_events.

Yes, it's very likely that we will need to add a payload2 in future,
but NOT now. 2 reasons:

1) The first-generation FRED is designed to NOT go too far from what
   IDT can do. And FRED event data is conceptually an alias of CR2/DR6
   in the latest FRED spec (not considering xfd event data for now).
   And the existing payload is a nice match for now;

2) FRED is an extendable CPU architecture, which allows the structure
   of event data to become way bigger and complicated. Let's not assume
   anything and add a payload2 too early.

