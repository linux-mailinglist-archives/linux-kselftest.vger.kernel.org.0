Return-Path: <linux-kselftest+bounces-8473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A28AB41E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7166A1C20AB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AE13173B;
	Fri, 19 Apr 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7+fIPIi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335483A07;
	Fri, 19 Apr 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546415; cv=fail; b=YCNxQ1tN1tpSkCUCZ33EiJy4X67PRCuz8DcNkxqaU0nBgpdrkh7H9J6gfoM2rIznGT+ckihbNyAQChgviHUZUoJPq/T+NIPB2/R/fFfRG4i5UrxJicKoJLYulNn0btRXvOSe0R0caxMsbuyJ6pqJPwQYsIdTIAs/cQi9+C6DY+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546415; c=relaxed/simple;
	bh=4Ma7pAgCK222Ua7jyobfOoaewHvtMiRXTvT+Lzu6WAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxA8pO+XgitRnlJOxvhzvayBR5KHMg5ac/2pu2ZlxsmJMaQbjHDEWUNqLiNLTQYsKQrtvemp+PdYLlkfuV4fWR93Yy6hGyDuwOElOi8JcklYKh2sxwufmbrKL0/NOH3yGIUsZ7uHz/8leotRzd6KkS1qCc6uEqVPZFVWJhrYa6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7+fIPIi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546414; x=1745082414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Ma7pAgCK222Ua7jyobfOoaewHvtMiRXTvT+Lzu6WAA=;
  b=Z7+fIPIinhBcLWVgYKF0SpvRVPsur2QvUO1mODdKNp/L2OH+t8BlTRkT
   n794ldoXsAR/pzNcrgp4fYmCViObxpJrA8BPM6lbS0ob2GH1ij3XPYlcP
   C89qLBV/2809WvAlcjycoCNpczx+tPhKdmoKgj+L1bIGPAbsKX5iFBCCk
   lKhs+noxHcskZnfzKwq6ZxKl+LEVZVXwQs42ACMZfu8eCrDhXsnjbQNKy
   2lDFcjRMp/6nmHWuncGa3AXy82dK1Svy4OwfX2NP97mRDMH8Q8Yc4IjjW
   WKM/fOAZMdKpJxBLWcZ5ujwqitQg9dCXKbkUNrUljSQVcFTqomTL4bc+j
   A==;
X-CSE-ConnectionGUID: lJteGdbmQMSXSS4dgaVFGg==
X-CSE-MsgGUID: 3CTsDTyXQnOPimUp0TPG3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9329807"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9329807"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:06:53 -0700
X-CSE-ConnectionGUID: qROVvFs3QAiJqxCFdR399g==
X-CSE-MsgGUID: yyhcPkCIRgiYDBiezg160w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="28206845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 10:06:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 10:06:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 10:06:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeV2BP/KjJYrvkuKpfWbwo3k59QVG/66nudkw0h6ZeP39c5u+lRkmEmJ7bSrwLGysM1s/48+uY0aH56z90Z1m34Bjh2xvIm+2ONmpRtnRn3G4CgGdjlb0+uUADgpbAwJSryuP8S3cWGXdIcHPjoYrUQCf3DqrHmFbqafO5ADqDzAD12w3wTEuUUgBlPE1RtCnd/hnayGJVXlUg5d7/+rGwZJ/EOLJxNtt58bCRWwCHDTqv+GjwcEhW1017W2r97oth8kDDGhkflYFZd2Pq7sHBcEYsoJpNo7uQTePUWkN4UvAhW9HQ+lpzjqR2uTzcw3P1zD2xnHJUTDhLHon6YNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ma7pAgCK222Ua7jyobfOoaewHvtMiRXTvT+Lzu6WAA=;
 b=KB61NzGJyUKOv1PfKav8+J2PQhXD3pD0SKnBVyrUdeGucjAI0KenTzNA+JL7LW5Sr201uToZtpJy9cIiKi4ja6fXB+OvB+TDxNsdSSpC5yAS/s24SRHfD7JjbMBiu11EZhTTTxNjnfWst2ZW/JwD7W+9PkW7R886dZM+42MiKt4loqAJlG01Q57lt/R+HJKOU5asUiMAnY8+dr5c2MPJoLZ9Wh0w3Yzny6di07Z6pFCtDhlbuMg/4wOu6nFmBoDESc0ETVxS6GajMiMNKbmOSddE5OJsGaSCosgBLOonvaXp8ilqLZLjY71ksXPdPEbZ/4q7tzwH24lxxiSPAMhbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11; Fri, 19 Apr
 2024 17:06:49 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e%5]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 17:06:49 +0000
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
Subject: RE: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
Thread-Topic: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
Thread-Index: AQHaWe/VaftQRTop20KuS9cgf/Lf/LFwCPYAgAA6pYA=
Date: Fri, 19 Apr 2024 17:06:49 +0000
Message-ID: <SA1PR11MB6734ED2F23047E8780ED07C9A80D2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-8-xin3.li@intel.com> <ZiJzFsoHR41Sd8lE@chao-email>
In-Reply-To: <ZiJzFsoHR41Sd8lE@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SJ2PR11MB7428:EE_
x-ms-office365-filtering-correlation-id: e784dd67-92ba-41bf-e0a5-08dc60931a4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: pdgp5fjjTaYaxozV1DwfzRCBVWqz+urf1ImoyyMnMkS58+ujbcBY91nGGDB2j2eXtdWEUIwXp6JEEtXODJ4sdp297IfwFEbmlf2IiqYGP/Dgb3WXbbmxlbniq53W8Ozq2YOMJ6uRKId6k7QEOPETYXpWi43u//uF514QncnQa22pQxRLiWP6lZ0YjwNvhmtDap1SQXYAjyO9Sq4EW6w1VfvyQ0I2nGlbKgR/coaUNk4AY6WvrwCqgWjLHUanMsEgLoouz80lPkZmQ9dLTJYY+QXbpgzuLyupi40qMbTUT8wcrTAIhYSeCOqkiZlHNQ/Gld4B0CjQtloH9JeAkRN90vAEn8p72XgPgwMYhNvlPbPxWoBYZsqHAe5YILdel4AG+43nR2/N7bPm/yN5hMMKsDPgGc+eA4wGIYWeQx2rOFnSOPbdo7efZFKbD+w56EW8lU0hvJ4umwsAqeUU4pfw5BOOc1qcMwQNQnVbiVK7GfN/kZtwUe34DKSPC+zTyEonsdcOMqhaAkWPO3QhgXt1qBmoChOTjUFQ8ZaHBo1H+yKJQuoRQES1b1iVHSreWmRexwNLnxCBnkxD04xN1bzqKOna9ZQ41J9OzKvFMKE+y7VQtVbEur/c5vRHtSJ7x69pIGC01eWrNTzZ64hd6dYvG6h+KxMGwRtjWplBEaOGPIJG0ofasFg7EbWYQZ54lwcT1OhcLWaiZL5MSZ3hvvdzzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDNPYkw0SC9ackdCbjZMY0hLbktKSUg2MFEvUFl1bXVlVVdHanRFZ2ptQkVL?=
 =?utf-8?B?eHlrRCthL1JBMGNLbUNGTGFjWWd1OUNmSkd5NGRUVkRHclg1K3cxdTV4MjY4?=
 =?utf-8?B?dm1ZNnVyN0tDSWMwRXhTVlRlcC91cTBNT3EwKy9CY043VGtXQkpIS3R1ejJN?=
 =?utf-8?B?TTlBdm5kWmxKcmxEUTBJNjN6Q2RwWEl6aWpQazlhR0krcTNjRURFa2dyZjJJ?=
 =?utf-8?B?ckpQbllkSWNwSlJ6ZFlnQ0syMmY3MGJQd0dLcE12RXN1YjUvWC91YzMwa1Rm?=
 =?utf-8?B?dWVOZDVORU5nRWNaTGU4TitkRDZkY2RXSEJkVmFSbHRXNzFLT3hUb0dkK2Ft?=
 =?utf-8?B?NVZJVmhjZE5UNDFXVDlLYzVQekpPU3d4YVVZNnY0NzJPc1RnNnZyWlMzSk1H?=
 =?utf-8?B?dW5oSi9OMHA1OXh3Wi9SZXo2QjcxbEMwMWo4c2xST25FQkcwb2w0NEpmZ1h2?=
 =?utf-8?B?bmgvYWFZbGZyQk5PQUYwUi9ieXhSZnhpcmVjUnl1ZzBndmN4dUxOd0t0Uy9T?=
 =?utf-8?B?UTF4UTg1N0ZWQ0VzSWRoWENDQXR5WDFjUmozQmdjN25oZVR2SEhyR3ZlNE95?=
 =?utf-8?B?VkgyR080T01qQ282c0wxY3loUlNjVGtVT3puSkx6WEVSTElMdWZZUjNYZjd2?=
 =?utf-8?B?SGpiUE0rTS81TWYvUHNQYTU4NGtUTmZjbWx0NFZlYXZIQm4yekUzb0wxazBE?=
 =?utf-8?B?WEtJV1hNRUpmSkozZHhIRW9zT2lHNjY4MDRUeWcvQVhUaFZ2aE1BdENtRENw?=
 =?utf-8?B?dFh6WjNPbnVjSTBDQS9mWkxTQWI0WTBYUnBXN2Vnd1FMbWdKZk00QmtCUml2?=
 =?utf-8?B?d3Ixd2hUTTQvOUZUaEYvT0hqSE5JOWNabndxSERzN0JrS3ZZdWRLaTV6N09X?=
 =?utf-8?B?QmRWZ29ud3ZjWStvTG5UbURPMjNCUUdZdm5mWkJRd2lyZHJWYW5IaVF3dW1w?=
 =?utf-8?B?M3FzMXBpcmFaSTUrbm96RUVCb2hxTHBPUXptd21jSU1QVDBMbkRSZitad3ZU?=
 =?utf-8?B?TktReU5yRmNrcUp0RzV5UGduTnNGRVBOK3ZWR09VV2pJdnRFV3Rad244V3dY?=
 =?utf-8?B?ckg1b0d1RC9ISXdRNy9uRVhnUzFIeW9DWmJkS044RDNxbXJURXRmQktMQWIv?=
 =?utf-8?B?dWxza2FMNFhOZGNuVGFZUWJtMUJQbFkzK2xrcFh4L1JDV2FvaXhGU09mTzE3?=
 =?utf-8?B?MXdDTjcyWXB6MDRZNTJMQWtJQzZ5SnQ3U3U3TzdvNzhpaVBQTXY1TGtYUXQ4?=
 =?utf-8?B?VnV3dUlXWkRjYTc5RTQ1M0E5bjdrZm9IaXpCQVRGNUs0UFo5RnZFQzlwOGlu?=
 =?utf-8?B?ZzgvZmQ4bHdGdzdaQk5oL3JVVDhvb3pmWVBNZ2ZDcWI1VWNvTGNsTEdrSWxt?=
 =?utf-8?B?Z1RvUU9sNHV2ZllJRSsvMkRzMUwxa1QyRjRyTXdaUVhEVzhPTkxkTldONmZH?=
 =?utf-8?B?Sy83ekRBWkZ6TFlIKzcyYUpvREg1ZGJ6V3R4U1RnbEJpbENPdnZLSXZhT3Ar?=
 =?utf-8?B?WGFibVlhcGJKM3dKV2xlT2doayttYllQNlo4ZTE2TTlNNmJpMEZtZitqNnRT?=
 =?utf-8?B?UnpETFQ4RG00cmJKMXBlRU5kYTB4bnM4Skx3ZUNJRGsvM0xld3lSd1BtdTMz?=
 =?utf-8?B?cU5YckZKL0pxSUppcWNxK3prSXVNNFRaSWRXaEJVWGwwQzR3d1FGRjR2QXlZ?=
 =?utf-8?B?ME9hdW5kN2JIY0RmV2E0UzBybllwWURrN1c5Q0o1bDJESnpmQ1h3MEl3Y2h1?=
 =?utf-8?B?Sk1vZkNKcVlnelc2cy9zWG1Ba2V2R0dua3VIdHpTNU9rZ21CbzRwMUVUQ1RJ?=
 =?utf-8?B?RS9ESFB1YmRCZzJhSDBjTVNRYXpEOVVEL3N4a1JWMzQvNkdHci84dUdkRGMy?=
 =?utf-8?B?NWJGUGgrYnNEQUhSNU1ZYnBUZjhYaW5vMGJYTUlsWVFvMkNkT0pMU1RSRDJT?=
 =?utf-8?B?elUyUUZXTXA5YXNGUmdQeExmMjBValJiRzcxaklDVk1hYUhBdEd3aEVqcW13?=
 =?utf-8?B?WmxVaHFNVU1zdGE0TE9UaVdmSmFIeUM5Vnc2Vy9jdDJmR0tRbnpOOU96WEM2?=
 =?utf-8?B?YlhHRHRpU3dneUdPWllsQzdXVGpjV2RTOEhmMTk5TDUvcnFSVVl2RGJCSko5?=
 =?utf-8?Q?VpUs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e784dd67-92ba-41bf-e0a5-08dc60931a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 17:06:49.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kt2XhbzPkfeQwfgC+4+Rv5rIg64e4QbEzBlDrNMnSdiOq7gKigE2xGJTicKRg4aLoqZW+JEYrelRO6QPF0g/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com

PiA+KwljYXNlIE1TUl9JQTMyX0ZSRURfUlNQMCAuLi4gTVNSX0lBMzJfRlJFRF9DT05GSUc6DQo+
ID4rCQkvKiBGUkVEIE1TUnMgc2hvdWxkIGJlIHBhc3N0aHJvdWdoIHRvIEZSRUQgZ3Vlc3RzIG9u
bHkgKi8NCj4gDQo+IFRoaXMgY29tbWVudCBzb3VuZHMgd2VpcmQuIEl0IHNvdW5kcyBsaWtlIHRo
ZSBjb2RlIHdpbGwgYmUgc29tZXRoaW5nIGxpa2U6DQo+IAkJaWYgZ3Vlc3Qgc3VwcG9ydHMgRlJF
RA0KPiAJCQlyZXR1cm4gdHJ1ZQ0KPiAJCWVsc2UNCj4gCQkJcmV0dXJuIGZhbHNlDQo+IA0KPiBo
b3cgYWJvdXQgIkZSRUQgTVNScyBhcmUgcGFzcy10aHJ1J2QgdG8gZ3Vlc3RzIHdoaWNoIGVudW1l
cmF0ZSBGUkVEIj8NCj4gDQo+IE9yIHRvIGFsaWduIHdpdGggYWJvdmUgY29tbWVudCBmb3IgTEJS
IE1TUnMsIGp1c3Qgc2F5DQo+IA0KPiAvKiBGUkVEIE1TUnMuIFRoZXNlIGFyZSBoYW5kbGVkIGlu
IHZteF92Y3B1X2NvbmZpZ19mcmVkX2FmdGVyX3NldF9jcHVpZCgpICovDQo+IA0KDQpNYXliZSBi
b3RoIHRvIG5vdCBjb25mdXNlIHBlb3BsZSBhdCBhbGwg8J+Yig0KDQo+ID4rCQlyZXR1cm4gdHJ1
ZTsNCj4gPiAJfQ0KPiA+DQo+ID4gCXIgPSBwb3NzaWJsZV9wYXNzdGhyb3VnaF9tc3Jfc2xvdCht
c3IpICE9IC1FTk9FTlQ7IEBAIC03Nzc0LDEwDQo+ID4rNzc3NywxMiBAQCBzdGF0aWMgdm9pZCB1
cGRhdGVfaW50ZWxfcHRfY2ZnKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gPnN0YXRpYyB2b2lk
IHZteF92Y3B1X2NvbmZpZ19mcmVkX2FmdGVyX3NldF9jcHVpZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUpDQo+ID57DQo+ID4gCXN0cnVjdCB2Y3B1X3ZteCAqdm14ID0gdG9fdm14KHZjcHUpOw0KPiA+
Kwlib29sIGZyZWRfZW51bWVyYXRlZDsNCj4gPg0KPiA+IAlrdm1fZ292ZXJuZWRfZmVhdHVyZV9j
aGVja19hbmRfc2V0KHZjcHUsIFg4Nl9GRUFUVVJFX0ZSRUQpOw0KPiA+KwlmcmVkX2VudW1lcmF0
ZWQgPSBndWVzdF9jYW5fdXNlKHZjcHUsIFg4Nl9GRUFUVVJFX0ZSRUQpOw0KPiA+DQo+ID4tCWlm
IChndWVzdF9jYW5fdXNlKHZjcHUsIFg4Nl9GRUFUVVJFX0ZSRUQpKSB7DQo+ID4rCWlmIChmcmVk
X2VudW1lcmF0ZWQpIHsNCj4gPiAJCXZtX2VudHJ5X2NvbnRyb2xzX3NldGJpdCh2bXgsIFZNX0VO
VFJZX0xPQURfSUEzMl9GUkVEKTsNCj4gPiAJCXNlY29uZGFyeV92bV9leGl0X2NvbnRyb2xzX3Nl
dGJpdCh2bXgsDQo+ID4NCj4gU0VDT05EQVJZX1ZNX0VYSVRfU0FWRV9JQTMyX0ZSRUQgfCBAQCAt
Nzc4OCw2ICs3NzkzLDE2IEBADQo+ID5zdGF0aWMgdm9pZCB2bXhfdmNwdV9jb25maWdfZnJlZF9h
ZnRlcl9zZXRfY3B1aWQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiA+DQo+IFNFQ09OREFSWV9W
TV9FWElUX1NBVkVfSUEzMl9GUkVEIHwNCj4gPg0KPiBTRUNPTkRBUllfVk1fRVhJVF9MT0FEX0lB
MzJfRlJFRCk7DQo+ID4gCX0NCj4gPisNCj4gPisJdm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2
Y3B1LCBNU1JfSUEzMl9GUkVEX1JTUDAsDQo+IE1TUl9UWVBFX1JXLCAhZnJlZF9lbnVtZXJhdGVk
KTsNCj4gPisJdm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBNU1JfSUEzMl9GUkVEX1JT
UDEsDQo+IE1TUl9UWVBFX1JXLCAhZnJlZF9lbnVtZXJhdGVkKTsNCj4gPisJdm14X3NldF9pbnRl
cmNlcHRfZm9yX21zcih2Y3B1LCBNU1JfSUEzMl9GUkVEX1JTUDIsDQo+IE1TUl9UWVBFX1JXLCAh
ZnJlZF9lbnVtZXJhdGVkKTsNCj4gPisJdm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBN
U1JfSUEzMl9GUkVEX1JTUDMsDQo+IE1TUl9UWVBFX1JXLCAhZnJlZF9lbnVtZXJhdGVkKTsNCj4g
PisJdm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBNU1JfSUEzMl9GUkVEX1NUS0xWTFMs
DQo+IE1TUl9UWVBFX1JXLCAhZnJlZF9lbnVtZXJhdGVkKTsNCj4gPisJdm14X3NldF9pbnRlcmNl
cHRfZm9yX21zcih2Y3B1LCBNU1JfSUEzMl9GUkVEX1NTUDEsDQo+IE1TUl9UWVBFX1JXLCAhZnJl
ZF9lbnVtZXJhdGVkKTsNCj4gPisJdm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBNU1Jf
SUEzMl9GUkVEX1NTUDIsDQo+IE1TUl9UWVBFX1JXLCAhZnJlZF9lbnVtZXJhdGVkKTsNCj4gPisJ
dm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBNU1JfSUEzMl9GUkVEX1NTUDMsDQo+IE1T
Ul9UWVBFX1JXLCAhZnJlZF9lbnVtZXJhdGVkKTsNCj4gPisJdm14X3NldF9pbnRlcmNlcHRfZm9y
X21zcih2Y3B1LCBNU1JfSUEzMl9GUkVEX0NPTkZJRywgTVNSX1RZUEVfUlcsDQo+ID4rIWZyZWRf
ZW51bWVyYXRlZCk7DQo+IA0KPiBVc2UgYSBmb3ItbG9vcCBoZXJlPyBlLmcuLA0KPiAJZm9yIChp
ID0gTVNSX0lBMzJfRlJFRF9SU1AwOyBpIDw9IE1TUl9JQTMyX0ZSRURfQ09ORklHOyBpKyspDQo+
ID4gfQ0KDQpZZWFoLCBsZXQgbWUgdHJ5Lg0K

