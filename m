Return-Path: <linux-kselftest+bounces-13686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F54492FF9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E932814FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400917BCD;
	Fri, 12 Jul 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FG3pFX/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE2168C4;
	Fri, 12 Jul 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804705; cv=fail; b=AJRItcfXVZLEn3jgeB6IYCPPYD1lZIfJ1GiTQjQfYdSzym3efP673DhXFCS2fq6VkwMkwbx11p4CJSRixE60CXYWB9RAD3wto9aL3NvsV6qhKXMv//kDZa7rNetGXkE4qHUCsqi08xFw6+QmV6NecSjdnyC0n+smGGlqPu//gkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804705; c=relaxed/simple;
	bh=S8Z+kXUFC72/UyUQICqiH4MJvAazBAdICYpn+vSphEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1ltREfs1sePGoBc6g25fhyLlwHonxeHHk7mGyHQsHl7iuZMsOBj6G69mqZrRE7aoeZi8MnjWVL4MmBgzRpnebhdfdnrzsgM9h+h7zM4Psx3WqjLVM4fe6zCVHJVu0HLyK7+YIO5SQZrRTILULd+HoIzbMA5sfvPaRpx2c0xqyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FG3pFX/v; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720804703; x=1752340703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S8Z+kXUFC72/UyUQICqiH4MJvAazBAdICYpn+vSphEE=;
  b=FG3pFX/vxWqdbEzw69TjzlgSOYHiMPGb3UB0fveKaoA+OBT7ix8XVRx/
   jPnw3cblwr05RKEuR9b5Yhjn9JzWg1rOUqkbZY8vaTMpnF/FYBOB68kKk
   xvxk2FnfrVw2BzYjPLOZgu72LwytgHLR3fkXysupmsvqPOP4WSo+EORyd
   8dKgRirnNy21X9+42itf5bJfQTHMgBU2RffpdzLd2Akad8FrEMP4y0oUj
   4tsiGkfQkjwYvELPxyMSlMwIjbT3Q1cFTPzfFcU14UTMAxxMQF6V9u8G/
   WSrAZVPqDxQgAXtdu26PpmdjA5n8jvtESxYCzBaBHu6n9iQioMNrwa5Z9
   w==;
X-CSE-ConnectionGUID: u4vXKxuzTPa1kSi4zcf2nA==
X-CSE-MsgGUID: yMuYqZ4yRbqmi/rJ2/HoZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29406103"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="29406103"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 10:17:42 -0700
X-CSE-ConnectionGUID: yxLlpiBcSNW7cN2HXuoIhg==
X-CSE-MsgGUID: /QI4qReeRKGxielYPIlIHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="53544866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 10:17:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 10:17:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 10:17:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 10:17:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 10:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAx0896miiQiY8YmYe6GbqoG5xAqb+vxKfYcNzmIRD146Q6c6EonGtFyIar++8buFyfw8ZsvTo4i8hXsJjSD+h93zt7raBdNUrzohnMNdG+rGopNCJUrFEz6devrsZhaJyF2CyGNv4wjUfb9sQm1rNJaiE3rfu4hfPpMwWQCeHKl4zB7mYAcQoP5/LDiI+J0jpNFm/j1p6rZtIuNsL6PB7f91r1mIIYwukj3ocVf8KtNsaQQCostNXf0rLKccpAnIHmGX5Z+h/tD/uhedjTL9tKwOrTjXAWT6z2aiBoF/MVGDKHtP43EFvJlEB7HuOdeHu5Qun/f+1lCWWL+Yb8oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRyFAwAJDoKBxLjeiRBFnKvqBA1zNr8RcA1WUm0E6h8=;
 b=KPoKG9vRZxaVy9jtnzGUGSWG/8AIQO7eMkBu8Voak/IvOmbAH8v503C0gOcn7q49PQ9xYaB3b4ZBlV+cOqrMd5e0zVI0TXWz5qzOdzAEPSxENewqEwHDL5zyykBKOUdB3dPJtCGTlaRa8guyWFbcQHzt77v8W2T8ur/oYhj1QB4HmnU2hKlyC96gAmQa0/QpUCvcR0MdtaTyj+Mm1oagX/ekooEO3A6lpFDcETLk0R+Ha2xUL2FWv7MhN50XC98bEMbFl2EtONLDr/yIJq7ATYRXib9upbcGGCQ6/vO+1t+phZnqAvBV08iC2znTMWc+4vKH01QPDt/DFAkGkhP6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Fri, 12 Jul
 2024 17:17:37 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 17:17:37 +0000
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
Thread-Index: AQHaWe/p8mDo/Zfb1Ue0O++EkKDe07HFceqAgCsrPICAA4rmgIAADUkwgAAHp4CAAADDQA==
Date: Fri, 12 Jul 2024 17:17:37 +0000
Message-ID: <SA1PR11MB67349D5D7B0E26A49B8A1112A8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com> <ZmoYvcbFBPJ5ARma@google.com>
 <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com>
 <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFZg-9MTveHfn_4@google.com>
In-Reply-To: <ZpFZg-9MTveHfn_4@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB7443:EE_
x-ms-office365-filtering-correlation-id: b43710d9-23d5-4e5b-7334-08dca2968700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GzupyUNsJPdzldmlbwYY+jMPlnTuahmbs7WZrYtQIWy2OmGfU7CeFvyldiFH?=
 =?us-ascii?Q?zMKnYC8eAZ4F9pHnzN0whbcL20lhIm17f0TFqnHNimVuJivXKwly1Pm0oeYU?=
 =?us-ascii?Q?1FnpNUYdUKvI4IaTmHIbHGer/OFW0/tIuBXEREnHTURtpIZ7OcowrG6iwDXi?=
 =?us-ascii?Q?/wfB1e7pLuFoO/+qA7YNTqT44gjjlX0Schv2OqBUg5DmoMLteggKTkgbb1yE?=
 =?us-ascii?Q?qjBxNX5PcGPm2fFbEslMVwuzjJcnnivMCCurV1bs3Eh4fscyipFPgPImSzsg?=
 =?us-ascii?Q?0ClxN9HBYIPkIl7O0Yzx02MIvzykfrV1NiLj4MTnutiZAErx8iX7GGDMKlXv?=
 =?us-ascii?Q?nFfxrUUa7STITOV0eHOrkqEGtfTGrqIlm1EkIK3vXAymVTxo0MFjJbh3g/RB?=
 =?us-ascii?Q?OtIwkzKNob/3BQ6OvrAczGKQApPHc4AhLg0AeZzxbcVjj+ZDMEyZhw9m+cOc?=
 =?us-ascii?Q?EYd/4Y0OICxUzWh4cIbUPgib/9cndmzeMyICsoT90MeUOktxWr4D8IwbjT4P?=
 =?us-ascii?Q?M31wh9uLP/70DCUz9oVC5TpKkuIz2GGU2GVa2KIJBzRxSJvNyYw5252sG2ro?=
 =?us-ascii?Q?PPKvJ0RzoAoizguLd0TOgwVr6GmzM3Bpjx3xm/gOfszN/iNZKW3yCn5dSwjR?=
 =?us-ascii?Q?XEGo6GhZz9cRUFo/3quwQBxjamXLb66hdb5OOj+6WIVpWQH8XyRxaoAFOUq5?=
 =?us-ascii?Q?aiW27qkbW9dbG631CTfhiEish9ZwciN1tQWshrmkRwhIq5w/KsrME6zk+iCA?=
 =?us-ascii?Q?GNdXZamW36AiWwaYVuWnN/v+vdJaB8aLOaqs7AURnjgnSIuZd0QHwTWhW3Mk?=
 =?us-ascii?Q?bGMwDxsuZ3+uMzbKHLhXkskZHmij0dSKjgH81k5NqZQMWWyKLFbAbkQVSujP?=
 =?us-ascii?Q?C2+N3lzKpmf5sNKhKO74tG3MlchyxwtzVRlCdJ4Cih4k37eDebeSuYUWSBtX?=
 =?us-ascii?Q?RuGLGcMcCPfT6WetRa8yWoX9Ug8imkFJzHBw3/7Wm477JIvYJDhVnkpgfDU/?=
 =?us-ascii?Q?NTNL6H1E0VnBb4OtW3A9puHL1+h7duOK3pqY5V+3hpu/wTmMHG5/tDb9VcSf?=
 =?us-ascii?Q?kB2pJas3aNq/LfzcM3y6mdQYxgPnRe+/V0XJsjRbJeM7T3rlnBixumVhYY6G?=
 =?us-ascii?Q?OvRQF+YXg507/HOyPXq7VFiM7iqw1ZDL4IQJ8SIXRGLNNInqo3/lK3/i9Pjr?=
 =?us-ascii?Q?soSblb9v8YWAII7B2uoL738cVLyk9QIPvTQZF34IITsyUxLZE9BHxY18zwul?=
 =?us-ascii?Q?Xc/aPFNQHHf2aFIffSOJeQtJ+UbPN+fZd1kvYORrBmA2/RGzLC5xSR13s1qF?=
 =?us-ascii?Q?IZriHNqntkRkA9Z+q+G7Gg4Z1Tvu02mLwlHrxpD7d1opKm/S+KIKxj560kxI?=
 =?us-ascii?Q?UzW/8avq7C6H8/G65/SG/hOi4zkqvnQFoSNI8czyCo8OnkrC4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nIlXcm1AmTwQV6+//6mx5eSzlmcdRWg/yp5oEKBynIoaOSB9SJCDOVpL2box?=
 =?us-ascii?Q?AHWslguG5t9YOjaBhQYhRDYO9b9803DbZKML+8eIEy7XjjvOKmQFheiVhEJF?=
 =?us-ascii?Q?TzQksbjR+QBRphBl0YbjI2S+e9RCyZL5fUKNTv+agDCAyU3YXv+6G/JAHRF8?=
 =?us-ascii?Q?WkYzOCOreFp8LX2AuoN21zC+Uf9xf3rLQdPdhK0XOstaXkoYC3lpW3XMU70q?=
 =?us-ascii?Q?8IgI6hHK6w2KkglnJFVoppwrYBzUofPz1nqnZ6XMbIC8JuK24EFZKEVc1PbH?=
 =?us-ascii?Q?YMdWwPFQDnRT4hM4Qr6oiU/tEWEJGt2Lsn8ICtG9lcH1FDO4S0P/TsswtdfB?=
 =?us-ascii?Q?q2tYv412hm4QnizxN5p/I4BmSkd6wHwIWJ4BAi9mfw7cB4G97INvZEopVm5L?=
 =?us-ascii?Q?eqBKuSKK0k2mnc38KXzEcmKr2DqocRenOhMv7Y20HcPiWDFxDO5i5p7WCQls?=
 =?us-ascii?Q?+EpRLShDWW+VGm3yTduZ9nyg6J1XFvxiXgwegPDUKhjB1vCe86A2GgyRWCwo?=
 =?us-ascii?Q?NdfD7XX/fAbrUWT5eCvikaLx+HFdvBXvXlLXy3IpxUJtjBkYb3M0I4b6CPA1?=
 =?us-ascii?Q?3ZzgXbeNG+q3YfbAEGpb5AoWktEI5by2U+aHXFl7Ib70e8RAt1hxrGJKpBCm?=
 =?us-ascii?Q?PLF/KiOxk1a+zQ/Vdf+4mnfoRLcKkMB8k9rxK4l1Lojzv6kyJpV3zuSn/YBM?=
 =?us-ascii?Q?kZE1Qvd0u0EFYGdBLq+okgbKQeEkvsMAC/GdgM+e2bn/igiE+5Rc14+nMh4n?=
 =?us-ascii?Q?JkHhKBu4vrZbZUfJ9ebRWgg2QIP1QXy9VO1QejuupiTFdY6E7/T+8oL9bh2t?=
 =?us-ascii?Q?l0DYaCBZVpVBVSAdJn83qEpCY3bmKHumIxI232rn+9ASjMEydSXUzPxjLCvX?=
 =?us-ascii?Q?FYWzzkcQoSgkXnAntLJQeXGtZy1MMwKsodU+dU1H44w0WrAT3n44uL08LHGJ?=
 =?us-ascii?Q?ei4uONUigxfp3pXVMwbVgCCl67aiu3lnzI7m1oMNDNj9/DgppH4wQ8XIAaZT?=
 =?us-ascii?Q?EwszLiiDBtw9F346yL4gvWNzIQJwoxy1luK0agZo/1EKAC2QxQqnnpJon4Gk?=
 =?us-ascii?Q?kiiYU363yGOWiLSL2YlXSA8nHWTHE3te/TdbLKXJEL6YoBzfKwVLzygYddIa?=
 =?us-ascii?Q?7KF/JerT2EyqplNPIroCG5Y+a1qz1vs080d7e6OmL5FwR/YwEGFY9U466SSI?=
 =?us-ascii?Q?y/Pitg4uaMGAHWpHtvMUln3p+CmAb1kAwAoCZ3jBKFiicEulOe4D6LdJqTGi?=
 =?us-ascii?Q?jdFLNXSj8UKR0aS0SfFJH2n9OUC0aJM59jX3CgwGQa7QBMN+vnRI8JO1WwWI?=
 =?us-ascii?Q?pgqQc1qRTt2MqtV2JtQj9x1hrJnvBkco2A0XI48EgTL1K5rDKBLUNA7gP7Nq?=
 =?us-ascii?Q?N5YQmPPh3hWxUsP7BJlusdX+irlvLKIXPgdvn4a2xV1GZ3JaPJpjZirOh4Gq?=
 =?us-ascii?Q?g7PdXhlULqnAjrI6Fr0vddeOqXabtF+1IqQ4XYvC7N+8agIx99iEUHZsHMY2?=
 =?us-ascii?Q?abKGnQ6wUGmS7txDX/uXd3WcFH+QUE+DOAanFbo7/7s0WweGSwtSGdTDf6ht?=
 =?us-ascii?Q?4IW0FlIjSRa9FXQlYWU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b43710d9-23d5-4e5b-7334-08dca2968700
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 17:17:37.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZN8+v9FC61Gr+iOCM/ipbsqXgE8F0sQ2jkt9i8LCTnfB02HmSzqe8B5E20SbMxG/Av5H+ZFMv6YQMIMpz3mJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com

> > > E.g. if it's somewhere in task_struct, then kvm_on_user_return()
> > > would restore the current task's desired RSP0.
> >
> > So you're suggesting to extend the framework to allow per task constant=
s?
>=20
> Yeah, or more likely, special case MSR_IA32_FRED_RSP0.  If KVM didn't alr=
eady
> have the user return framework, I wouldn't suggest this as I doubt avoidi=
ng
> WRMSR when switching between vCPU tasks will be very meaningful, but it's
> easy to handle FRED_RSP0, so why not.

Great, I will take the patch.

It looks to me that this also works for KERNEL GS BASE MSR, no?

>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c index
> 1783986d8626..ebecb205e5de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -352,6 +352,7 @@ static void kvm_on_user_return(struct
> user_return_notifier *urn)
>                 =3D container_of(urn, struct kvm_user_return_msrs, urn);
>         struct kvm_user_return_msr_values *values;
>         unsigned long flags;
> +       u64 host_val;
>=20
>         /*
>          * Disabling irqs at this point since the following code could be=
 @@ -365,9
> +366,15 @@ static void kvm_on_user_return(struct user_return_notifier *ur=
n)
>         local_irq_restore(flags);
>         for (slot =3D 0; slot < kvm_nr_uret_msrs; ++slot) {
>                 values =3D &msrs->values[slot];
> -               if (values->host !=3D values->curr) {
> -                       wrmsrl(kvm_uret_msrs_list[slot], values->host);
> -                       values->curr =3D values->host;
> +
> +               if (kvm_uret_msrs_list[slot] =3D=3D MSR_IA32_FRED_RSP0)
> +                       host_val =3D get_current_fred_rsp0();
> +               else
> +                       host_val =3D values->host;
> +
> +               if (host_val !=3D values->curr) {
> +                       wrmsrl(kvm_uret_msrs_list[slot], host_val);
> +                       values->curr =3D host_val;
>                 }
>         }
>  }

