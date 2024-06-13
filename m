Return-Path: <linux-kselftest+bounces-11826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7989062A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 05:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9470C1C21EBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 03:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832612F592;
	Thu, 13 Jun 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQrcQAy7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313682F34;
	Thu, 13 Jun 2024 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249477; cv=fail; b=fk9NVK6L+TFQPo5RjgvPrVf2/ELUA65e7FveJG6oLWRESQVZIrag4vy+8BHhVrS5q05qHgxnb7Vz7EaIbeaVY5qBeYk/G9d0NuUrTGuje3G7u4M6bCSbO3AjDxLYTTrCo0nmJzi0515mbMEM+Y4oCNC71FFzLu1YPwdflaDALYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249477; c=relaxed/simple;
	bh=leh18z506nHrxqjsL4EXZ39V6yXoZR8ypbqw8TT/0us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FxX+fXDfZTBSTLJRz65X7OKeMkmHEreeCxRqJ0StzoTM/UbeGBvu+rlTu52cJi8UQeszywZrefncLFVckBwH3UuUQj8BVS3hS2iFG+Q5dqMI4qXc4U7Dlq5fUh3l7sntQ1THxR7BvXL60z2tksF8aiTmmSYaDj9hCXq/9Xg75xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQrcQAy7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249476; x=1749785476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=leh18z506nHrxqjsL4EXZ39V6yXoZR8ypbqw8TT/0us=;
  b=WQrcQAy7yt/7aEsH39rxjrklgBIf8zgIge1Hc0/97otTR6ieqjT6XC4u
   o0h0Ef862LnUXd3A05TnXtXlwJfKzvNEr3YxPzKhyLdGfVLlsSgp74iZs
   1eihFY+aL2MTcM7bLwaKobdI5msBbwalx/UPoPFsNm3H/2ouO8ednc+Ik
   lSjx0xmcpwinTbCj6rGEmBC89HH+5YNb0odt5KvKRxigwuLIK5HlLZpjT
   YH+ZBjPatb9jl33eQXjmYS3Pns4/VD1SFcpBpyKqMUnfs8ROy2dFJQrjy
   heP99t2HeThVZeRmsS87c+9TPcG+WQFlQLEzQTl3pOSH67EG++HxYJgN1
   g==;
X-CSE-ConnectionGUID: 63ShJu1+RCmuTYF9jqaBaw==
X-CSE-MsgGUID: b23LBcajQlCPbOYVMcqh9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18900705"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18900705"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:31:16 -0700
X-CSE-ConnectionGUID: qG3jRu/DThym2DBCsg67gw==
X-CSE-MsgGUID: dKievIWpT7KJl99C63y8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40104410"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 20:31:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 20:31:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 20:31:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 20:31:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 20:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOoZEM33QuPmy3u/bYLtbc8Xi0+mK/sxPMjD3zSMYompM3l03K/aZozRTngD/I9T968UvKHgNtwCWMyxVXxjg1xQNgIXydi3jslnJN44gcvAKwu5zrqOCMWX1g3kFi15U3Ri9E/9nd/p5fnfwL8OmJ7NXredgveUQYeyAh4tsSp28tAfjCm4HJjnXdqmd+rzz+0vElFAykD4xRBQtzNpGIrr5eoF9j32H525v62muHtTtBjfCeFaxB9ECoIrlCsjm8D1LH00herhP2xC6oH8qmkzNIdhKGBeCsz0lmVEG0SNhfNID7wVasAAooZWcpVpQWLPStA4rBABN1TXEGlUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYjIvq0jCsx+qrK/XHhBBKQLgt2G59e8KdmNxnPjVUM=;
 b=IwJED3xfh/PCvOXOUw+p4vfoLBYO3lZkKrWjphWl31tzEzJOt1L3xKqmQLeEVE0Ug0/bUQTdJpmR3PoKubAgXdhOgVR9k/P37ZdGaG0YYny1BWc0wuUo2feHOfIw05Mi1sFdE9Tw+f8ZC4NwZhpedVc6MrpZ8yXtCcx3FwbzD5WHTVGyHpiinNHPT13cPXFATfu+f6MUGh0PuyRaD3fWaDq0YaYugj7TvtGtuJzdMaPNf+muJBim2f6oMO9L8IiBYU5DmWNQzgHIOQrZAKNlP8KdQBA1xPLjDNAITQJPKiU8/NimRxGVXfMRQL8ouGqNEa4HsqKTh0dnU9xw4Qljlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 03:31:07 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 03:31:07 +0000
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
Subject: RE: [PATCH v2 06/25] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Thread-Topic: [PATCH v2 06/25] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Thread-Index: AQHaWe/CSy+dhNd+hUmy6f2DmzWA2rHFaGsAgABnWRA=
Date: Thu, 13 Jun 2024 03:31:07 +0000
Message-ID: <SA1PR11MB67348C0E467D474EF9B38C01A8C12@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-7-xin3.li@intel.com> <ZmoQxjksn5bWhlBA@google.com>
In-Reply-To: <ZmoQxjksn5bWhlBA@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA0PR11MB4671:EE_
x-ms-office365-filtering-correlation-id: 65556e66-d018-426a-8f69-08dc8b594363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?zkygWiy8CGJE1rJKvWwFWuJDr3hyo7a36auOTxwSx+D5ZyhQKsUBgXnctIpa?=
 =?us-ascii?Q?VhilnVPATiFNM1O0CaLAs/sfZkBkqve6UNbMmTLasMHikTlyV/sHuFEzm3jP?=
 =?us-ascii?Q?QTs8hxxnazyExGaCzbO23XFEh2iMX10ybBUfdbKqLq9MdlEasH0f8hbr/3lr?=
 =?us-ascii?Q?JQHmdVLWiQzNigUqxFGOG06g3Y5JL2LQD4OMMszHvdkyh4Y0ZquXXhOFxrdq?=
 =?us-ascii?Q?epdRtRscyf7Z9opgzJ3jH9m8k+A6S+Zq6zm3o0OOZAzRCg/kI7mGSnWYnPZb?=
 =?us-ascii?Q?SLSSs0srfXHSlxAkzCubzueVR7XQ5KNDXSihaLpsVNkMonNnkB9EXzDcbrV6?=
 =?us-ascii?Q?mqF6/xY78rxFOD7mpiL46UnVeUtRG1uJAGmz3+NiVHU1WwcbyacHs1myvkda?=
 =?us-ascii?Q?zNV6vcvs+P/SlWM5Y0jFBUGAY2No4hFIzFfh1evrROBTdQ5ritBu5/OYE0PX?=
 =?us-ascii?Q?hOTyEISzILxyzrVkbDWNTMKQSsVkBUngkt3L1BJzFzfxW4OUA6w45f5ZQDth?=
 =?us-ascii?Q?Xt330hCm061PDsQyGVeNIAIU4ANAFm6N37Momg3Y9tCuavLTnmFWDB3kddtk?=
 =?us-ascii?Q?nM0Hgpn/gbaMDHhnrw9GPEBffVUhcm8sNmWX69pPlbbVFfbGhduTXY4530Cj?=
 =?us-ascii?Q?u+RSOaG/uhvYfnrx4ei6HdUhhAsRxLNjWwjqUIQCnH+AiQiIB7sTpDJRwKMs?=
 =?us-ascii?Q?cT1C3PX5rIOj7RXwF5JrkFV8A4jA05C2mC2ahHpU4sseq7sMtwjCPx4Rtbay?=
 =?us-ascii?Q?fw2AySflDKfG4NcilxXpUmNdk4ZXgiUnBVrWKOgGEpQnIRYT01knQ0NyZdEj?=
 =?us-ascii?Q?Uy3g5kjx0aD2CPY3OgJPCd2nsrkrlFSqiMfog1gdMaku0NdRDd3be5hHgYGX?=
 =?us-ascii?Q?2XctTEsmIOKEb0kdJCSFN/zMD8TXwlvQT+/ZYPLDaFBAYYu0ua96H0oFopAn?=
 =?us-ascii?Q?859Ki/vUs80lkukeBZmcfqbgHvqvS0AKpknklqVb5vrweCpw5+cVg+Ms8Y7h?=
 =?us-ascii?Q?/AxrJbTESF/KXs38ZY13Qq30Ajq0eOveX+C1ZuD9N8jBD+vcWvOnL77/eYJ1?=
 =?us-ascii?Q?0fwMh99d3VAhK1K/nO+8vTCD7VEf2YTRsnrjOso2GudLV1Ub7Yz9Uysju1eT?=
 =?us-ascii?Q?Ba05CdgJSA1RgM3cYwHunJeBgYlHgO7CVAQkAG7V8S3hw1ZO12fA+vgYufGe?=
 =?us-ascii?Q?M8S12T4bPMNctpNgaovnfvm//z+d214FNTn1DCH+Z/cw9JdG32Ofu5TnD31e?=
 =?us-ascii?Q?lkXxGvZWgm8O+aUs5/igVz3Lh+GVNckxlSI2kDzU22Uz7nT0OUDOBN4+Tnrr?=
 =?us-ascii?Q?oltwS13xmHzM7k0elyvcZAQ6pwRPVUpC9BbEsFu6lh4oGWFzBU31cjRqwn5d?=
 =?us-ascii?Q?hizsxh4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TqjdECgO3fl4JZuHTthMzL4gmQEOMpaZFiuQgM6eNms4YKKK9OFI7oS3YLpX?=
 =?us-ascii?Q?nTv8w3I3IWERFAyOKw6nh4i3jZWvSEXck4GOQ3EUnGgByk3q2oGDUO7F4ezP?=
 =?us-ascii?Q?Tc/jvgpWnTK8lbX5RKgONJceTBU+sMpWIvSqr4aT6/nqUw8TfFUQLYmXfHH2?=
 =?us-ascii?Q?XsQio7yBerkSXJciwpdT8E0ENlCPqJZrHtxWsfg5mpsFnm9D7oV5O6ET06gi?=
 =?us-ascii?Q?DM3Su/Vg6BIotPQtmdHw9+GQ+x8hawGFCbCjp6IiaRJXT434ew9ZxMtBahp6?=
 =?us-ascii?Q?u/AssVi2DHrYQ2IkWgBiPgXCHNmuA0fHJaHSi5nURskwgDlJbsFqhFfqhWJ9?=
 =?us-ascii?Q?BmRDWlveC8cptjEyE6AISVqyHeBGKlLTThnR/790uM6kVY1g8rWwI9c3BGR4?=
 =?us-ascii?Q?MUHIjPWtM8c7VgSCkzeQ3u3Gp7HYTiqid+ePbTz4e3XRqgUNBzFeF6jF0R95?=
 =?us-ascii?Q?8NOQUG2lmS0D5Vjr5A5i3TAWkSwg4nw7VLKLRNuuwlNRjUISxK9/YjBrVVCl?=
 =?us-ascii?Q?Z/DF1U7CUEoFPMd/F5eqqvGkVuuDQnjrLXsroSvRIGPFBYK3hR66c9q19+5D?=
 =?us-ascii?Q?jhm9ikcTnI+IlDfDOM65EQXIV0Cun+2ib824DGHLx3iGpzeB94e16tThuB4q?=
 =?us-ascii?Q?mhPY0Pw5A0Vqzk1/Q4AiP1fsvWtJt5NJBC0tsCqK9J6yzaacvtqJUWGghyyg?=
 =?us-ascii?Q?l1uB/mfHrUYcyZjjxn/VzWPJ8O8so5WBZqis9XdXyBOejskASUN/4QrpBd6N?=
 =?us-ascii?Q?nvnrs8AnZKNai4+36vHczdZPLPmp8DuBErhVdZw2TWd5e+wr+ahg9a2EhK97?=
 =?us-ascii?Q?5rw9iAbuB3UVcdPIwkcOLUFdeTAYYHpGIXdVMoLbodh9OFh+cxIwEUDHd7Io?=
 =?us-ascii?Q?wcbiEvUjCr+M+NmCcgCU4sXD5i4tPqeDRVsIUSk0+JWXl8Z9t3o+40NXmuf0?=
 =?us-ascii?Q?+btphHU4xd28xrojfDLs5FxunOSi7Wke+JZ3V43G2ZS7IRc+oamjdcBi8gJr?=
 =?us-ascii?Q?ojSPYtaSEN/VjRJTDeRnqM1hrBJPqNMMbvORDZ01n1ghIbohOhOcxUyfcdgH?=
 =?us-ascii?Q?ZOrTE1e/kyeVqoiYc3mlWrrhVWvIckQbXd/9D5663A8OZKuleGsYpGUVUWB2?=
 =?us-ascii?Q?u3BKBdN5ldEAbnEFaRv4dkcNbmVRV1oTQMAkLbikv6VyZw1YmaqBb/hBqQ4z?=
 =?us-ascii?Q?Tbc5Y8ll3WWn/+Ctn06TSzlbgENRlvbrDEn6hhl4+amBjExR4uNew7T1W2kb?=
 =?us-ascii?Q?FLc30rvNN/w6hBh6QloUcIy+q9EQAr/zu4RaATfWH3nyG6UvhallSi+fml+V?=
 =?us-ascii?Q?lksK2FSeBpUfSnCttwuIAaatDfhrCooXxvFoA/dtudphvRyx+S1zHCKASYWg?=
 =?us-ascii?Q?7RZQKeUqaYQvMImVh1YoTVVFAsluUVVDzqetNiAbHQCPscFId0y+AsXSsaYV?=
 =?us-ascii?Q?M1/VGe8DuvYo7e8zqFkgT0N4DLtjR/RUgV6hbnabe8dB2uoyJ2+9pySI1Qgu?=
 =?us-ascii?Q?hlQRRkHNnr8nmIB19e6Y0udJ9J6Joj036J1/clnIoXAvuXnZWiA3fCddwI3c?=
 =?us-ascii?Q?vjkQV/yONQR1CwRFF30=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65556e66-d018-426a-8f69-08dc8b594363
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 03:31:07.8425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4K/3CV0tAT+8p3dAQB3ldUIwVxnZ5FKOR8noMJh3Ja52x+KngN8ptZOfGhVW1LQxyEFhhaWZQBIt6lP6XtoCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com

> On Wed, Feb 07, 2024, Xin Li wrote:
> > Clear FRED VM entry/exit controls when initializing a vCPU, and set
> > these controls only if FRED is enumerated after set CPUID.
> >
> > FRED VM entry/exit controls need to be set to establish context
> > sufficient to support FRED event delivery immediately after VM entry
> > and exit.  However it is not required to save/load FRED MSRs for
> > a non-FRED guest, which aren't supposed to access FRED MSRs.
>=20
> Does this actually provide a measurable performance boost?  If not, just =
do the
> unnecessary load/store on entry/exit.

No performance measurement yet.  Will make the change.

>=20
> Generally speaking, the only time KVM dynamically toggles entry/exit cont=
rols is
> when KVM wants to run the guest with a host value, e.g. with the host's
> PERF_GLOBAL_CTRL.

Simple rule.

Thanks!
    Xin


