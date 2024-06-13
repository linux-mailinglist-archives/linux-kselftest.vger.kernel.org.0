Return-Path: <linux-kselftest+bounces-11832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A4906370
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 07:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED23B1C22613
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 05:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B80135A7F;
	Thu, 13 Jun 2024 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwFlX5Xr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BF210FF;
	Thu, 13 Jun 2024 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718256570; cv=fail; b=T4N9yJM270DYG8+cVNUXkSPw5ZoIKf0SADBLqZbyZTPOMDsQgiqzLHnWjy8+M35SR3UWrMntVV26rS0wGHWYF4XDenOsALBu3NpFohil64Ua8DqwwWk9oAee7L/TRWN/n1cLAUkASCcoyHgrYN2EOnPzEgTOzI7jglEH5TSBsCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718256570; c=relaxed/simple;
	bh=D2JIQUqp8sRY9UzsMWoWL8ML+yaA2s7g0QZ1eN5LN/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nVmCNJPz9XJTWSyACp6nv63vIzbo5vW5pHHZ1GhJAlytcSFJjabjrgWnglkp5KjgHKAr0q4nJvv0O7VtUi2yXh9X3XSvfMl8Y/5SrtmIy/bF5mLtG929vMRdbMZ58ojJKXIPcXeyH+lDbdv2hI1ExVEwnR+fQp1BsgD5rVwa25A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwFlX5Xr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718256569; x=1749792569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D2JIQUqp8sRY9UzsMWoWL8ML+yaA2s7g0QZ1eN5LN/o=;
  b=bwFlX5XrRjs5/OCA67Nol2RhNT4Rhi68fxkUYt8eVQXS9w957aL/73Ek
   aE1BNKwpPUBGHkkTKkTETYHsXR5SNUE2pyo5lZRCr4jyVTTCTCv37MV5z
   OFb1gi43lS59VFG0P3SvJJ80CBeG3a1LRMiRq46bY/CDRcMEBuAxL0hsl
   VlPK3kmsGlRGo1JYDExrlYIZ5TGqrOsSUPEVAKRvudlN6YqspizooEIyk
   O0IVeGY5ZXBd9b8zUhui4rjOkTr5DoIZialuSEZHJ2RCr7ou7m43Xpi0I
   zxnLLzkeeAE4a56HBYUzX7uhfOHvLfT/dnjD9axee8NkZWFfPd4CZtQKW
   w==;
X-CSE-ConnectionGUID: ERHg9qY9TN2ZDpsPpX10UA==
X-CSE-MsgGUID: 0wYJlXkMTYGD1sX8eXZtHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25632741"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25632741"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 22:29:28 -0700
X-CSE-ConnectionGUID: LPqBeL83TX6fi2eYW7iSjQ==
X-CSE-MsgGUID: eJLw/JGYRICx31Y4gXeiGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39943566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 22:29:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 22:29:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 22:29:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 22:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAmpon4ore193RrhDPR7Y6Q++gL9ot+fUAzPsa03m309Zc069emwCBJk/8liGVNYnnK4hSDB1ihg7nwnH36Tl7byzCDBSMcxnY/PhNvHONc4TmcObr8TuPOuLoAw64Q2FHeL3Pza6TQnpO2orn4qNUFl28YcliJDJ1XPA8sVu+QlNgmYy4NWSAggQQ72k+xjY7GxCDoOkStcOV08fkExk5iGphTqFd23aeGNbwZIEa/20KrAM2CIZjKAWvXfaiXDdVULCKUbOY9gObarBxkdyPn6rDny5MU5D4vSq37/E6ypjPdCCcBREDM944gObVXHU3jnFN43A/Szglne+HSb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6CEGsdCxkM01RlHD2dzYnAawMyddQaIgwXlqnd6CBM=;
 b=GFJqsBOCGOlnvev2G7xkNEnUkaGHBgHwBbRnLpiRp3nUQDtGXxOAl4RGDdYfo1zYQrSEJbtSaow+cTGmrLbhAjlH5w8e0OgpIzL7e6v3b0OXZbDCAofvPHAhNPXOKvYFVe9aBwy3Jc9FduZpaLy8fjoshYQZyf6SbfBVRaEFwuGnAs2RxMNx+o8wwGO2J344DXxdF/7+k+SFdHDjdiPQZcxC51X8enipG/511A015bslkSVY0uHF3NCNNhIrz1YovlG5LHfqwpdA7Rygx+c+4leydNX+8oWabOkkjhDtRnoufw4Ruu/uTFI76fRhvEDDFHbOrCIT/djkNnRLTs9BMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Thu, 13 Jun 2024 05:29:24 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 05:29:24 +0000
Date: Thu, 13 Jun 2024 13:29:11 +0800
From: Chao Gao <chao.gao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Xin3 Li <xin3.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, Ravi V Shankar
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Message-ID: <ZmqDp/dpCfT6qc3l@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-13-xin3.li@intel.com>
 <ZjBiLDJ4SdQ0p5xm@chao-email>
 <SA1PR11MB6734740F9B6085E0997A4179A8E72@SA1PR11MB6734.namprd11.prod.outlook.com>
 <Zj7f+JWbVfIBIK8h@chao-email>
 <Zmov1x2KFtoMN3Vm@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zmov1x2KFtoMN3Vm@google.com>
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|CY5PR11MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd97861-3c65-4afa-4425-08dc8b69c924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aSy5B0ttSfc6vIFzstluPRv7wI9L8mkS/KHp40Y0fcm/OoWLCWuLCYmmDohm?=
 =?us-ascii?Q?zllQ4wue1YnqEdyJKPfyK5Nt5KYYPQOtdjQ52lA2l9r53rMZAn3XGn4xBLQ0?=
 =?us-ascii?Q?fKCtw5SjvxF7cdJxHIY0AymA7wago+xd2H5h45YECprMwu6AtiAEuLJd9FU9?=
 =?us-ascii?Q?kOS5EWBGWuZk9Ly1tOSYo9o04OZ/pwq2eHOkANBZ3QplQOUwx4ECTJ6jtb99?=
 =?us-ascii?Q?dtdpukEwfNaC0zyEoAPh4+KtXjVK07lgH22ZZObYY+yHQ/iK2OCOGFmtp3q8?=
 =?us-ascii?Q?dFo2kF4JKwAZ95agXayVJQ75Wb17Lwb+NZ47o+k7f7mrJi+NWUuOEQW7p8Yt?=
 =?us-ascii?Q?My4TQtj2aS7b2sqhX1QWtOUA/OAVG31JxXWdS+z9fgrel7OG1qbYZ4FQaAa0?=
 =?us-ascii?Q?8/c15pqmk0m3jNfozWI+/Mc0vnunjN5hHu4H4dMe3c4VUrJsjfRLqBs0d5VW?=
 =?us-ascii?Q?eR94Sfppg6x2GqMwcbQ5E2fjBYwdSLoJbgOiP4c7SOfAJCorjkN0lH3f3Kyo?=
 =?us-ascii?Q?3vrwWSObRPXBzMUszIH+BVfI8Y1WJ5dXMgCV3IO4ZrfYI9Myqqm0C8y+4ZiV?=
 =?us-ascii?Q?71FbhkVtc3huf4QRbzynTT3slurOO0NXtcH0s+uAysYPXXwLcmbk34h5GFgm?=
 =?us-ascii?Q?duaUJE2Yze8e/cc1q20ZziiPD/znjurzmMzpTALOqdLop5V8NieGolg0SeUp?=
 =?us-ascii?Q?FxtLFoQy7+0n9UnnjxVmt1gvQNCS+VwmBWd1fvL7OgrLAxq5lExAp6vc8HML?=
 =?us-ascii?Q?UZ3VXjqUli8QlDrPr46Z2L023CNsBjCypeFOuFQqPQmCkUKSUx6vFjd0cqgd?=
 =?us-ascii?Q?TgyCxZE4jZsGBgIE5b6zUkFlcWtdX03Qt3j1j/wxfxnjIXuQ2fvMc8dEEgtJ?=
 =?us-ascii?Q?uIDhd2KVNNs9Y5LNGvsei+3HrmO6XANbQi4tCf1Uk2JILDSrzZOqlmFAGzRR?=
 =?us-ascii?Q?fncuRi45zNSawHGBu5pgnTJbwel96+Lx7XvIE/gBHVdqLaeXY5E4FJU+/JsP?=
 =?us-ascii?Q?SKOPmkB445kFOWqaAI+X0+1JqEk+t3anbDoP9MFrZ98OOu/uKEgTS3IpDjJl?=
 =?us-ascii?Q?dZ5zSPF5KGme/l5EkKGPxRudVqvFZGkGAo9iTIPKAwwOi+T6FC+hgYsi0ko8?=
 =?us-ascii?Q?1qbY4G5rjl4GmDmS2jDaHDuJStwRHtCsFsfyHgSL6aOPaMYJg8O2dVadNnVt?=
 =?us-ascii?Q?C9avcpgVG6w96etw1Du1BKSNkdm4JioaRVeScqAImtH1+OrxlmMoD+tnd+Am?=
 =?us-ascii?Q?N+q46X2J9tp7LN9UsAzeaIKBUpY+P1ld4fpTxgaKJ1okLaME3EOnSRuLRMGD?=
 =?us-ascii?Q?erYRYrLK2Zyge28+lldUepeA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qWeanwwoyyrxlmUl+XTElRazm6WPXGnvOIXZPJrZRJLTNUpOgO8e45ELkai?=
 =?us-ascii?Q?rSeClNAbGROyMsfbqsy6QBq46wX1pRAzyOr8dU8taBGzLQQ7Dp+E2WhOf+jr?=
 =?us-ascii?Q?w4W/BGYpbkmtMKT2eC7Ofp1f2c8gbK2qnO6rXRrY1+pxjbJ7+UxoKBvPJgCq?=
 =?us-ascii?Q?yRyfRztHxTVngqqjFn4FQBQEP98mut35HeFsNmjGg/fUIeJMz/4R3lxMc/Ie?=
 =?us-ascii?Q?axJbEBf5gmVCYVBCC1P+F10yhej1sKyOOUS29vCSxTGAE8Q2WVvuSwjV530D?=
 =?us-ascii?Q?HnxPlgRFkBfsXGIpDcybE9cnPyFcWIWSkXk1t2pJ7BZsFxtAaTt4MBHBhJDx?=
 =?us-ascii?Q?zYOWMpT6szJrpxcPJWQmzKsIIBzLHTD41v0SlclZxCoSEMtapBxYkOW7czbS?=
 =?us-ascii?Q?esQr3B0iZ+KwS567DuarsO+PcKfSqjGH20NMJQBbRK01raZ/4WvwcS2UGIxJ?=
 =?us-ascii?Q?PfTNNGeep4Evw6vCIK9FR78y9bkJFUnr7S+ZsHXpkgzT+jfxQWA4zq2denET?=
 =?us-ascii?Q?gJYs0rPPy6HKRfLRCVdYFFhNpzJUm5MhElts2mvi1/nywuzA/OhVuHrRzQw9?=
 =?us-ascii?Q?hneKsGRUpO2gF0qMc79gcQvV8aAZi/S4BaL8DkjMCw25DYf9EV/4bA7HPjNR?=
 =?us-ascii?Q?n0AH1gzLAFMa+LUeZ/k308XDrbTKN8bizVMii5EndLmVH9m5QVahiZ1+Rcqo?=
 =?us-ascii?Q?8gT7DiitcBLHgW0sarQRvwP5KKS5KqWXufX8GljN4+J7PD+3l0oo0OEo1SG7?=
 =?us-ascii?Q?uEBnOEqk3B6gbHdK69tRH9OVyrOMEtho+oruS2/4aegBhOPU4GFtLOV1vAbh?=
 =?us-ascii?Q?EJ+IhKZw/FNUkf8jGsp/Y/kk1sZgZw5g/z0dTkH381D5OiPzF8lIbvZqHu2V?=
 =?us-ascii?Q?obtjEJj76G/o3t/Ln4J7bhr4Nb0j7s+s825SFI5Y3dVjNF1U+jkIzOTdeIj7?=
 =?us-ascii?Q?jcwkOjQgq8qJfWqC1LEoz5ssl1wgp6c1vbPxXvZy8u3C3Pm69SapyO87F/LX?=
 =?us-ascii?Q?MSSQpf+zDry7XU/gYF8PT4EE35zKCehQWWOBhSnFhH39AKsns43Cj9EYTwzU?=
 =?us-ascii?Q?9jwQVLQqclyvvfgDA4TroEPtg68OP4Cry8RkfaoiZxYmFbqp/bh/qFV3SZEo?=
 =?us-ascii?Q?Bz6bxBVJMst5jepTjqHFYeFPrGrS9Vv5/0B4xDygU+mPlGeo8R4emIXtWgVH?=
 =?us-ascii?Q?fZH7O/SBHKtRay4AZOAurzHeRFhDDuOIJ4HdyIZJ1s/bkANvPEgu9nhDHa0u?=
 =?us-ascii?Q?lJZGU+U7Mol1UzMKJWQvJe3p7cWogCoYYq2Zh5pgbSzBNGRdT3LAEo9Y9wvC?=
 =?us-ascii?Q?/D+ms6DJL6UEskheSA5spJbUgLS3mz3U2uQ+4Z138WDAMT+c7D3sJblx9pJa?=
 =?us-ascii?Q?pzlUO8XlKlX+3sixFNYn5KlcJ7+7YltetMJ7gqSIhHpRrDxdpNR/hw5e2+rr?=
 =?us-ascii?Q?Zz41iVUTU88iNW/frSLCSUafGkLWX8z8eUIHqE0oLjd5coXwl8QfNENdiFc0?=
 =?us-ascii?Q?vtSlXrAxuoC7vqWyfQcKNeF8P609zQdTiYUKORo/5qti1OqQlmTXEPNjLekr?=
 =?us-ascii?Q?lq+FGXNRq3h75NtydRdva19IbzWQ/5dk2ZV02E2c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd97861-3c65-4afa-4425-08dc8b69c924
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 05:29:24.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRcBffFdfVfqvAqiLBKhNyXJgvgO31ffJPnP1qUyG4YF7KAQwoj+U9VbEpGqsFBGu1DX04yALRkwSZGMybseqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
X-OriginatorOrg: intel.com

On Wed, Jun 12, 2024 at 04:31:35PM -0700, Sean Christopherson wrote:
>On Sat, May 11, 2024, Chao Gao wrote:
>> On Fri, May 10, 2024 at 05:36:03PM +0800, Li, Xin3 wrote:
>> >> >+               if (kvm_is_fred_enabled(vcpu)) {
>> >> >+                       u64 event_data = 0;
>> >> >+
>> >> >+                       if (is_debug(intr_info))
>> >> >+                               /*
>> >> >+                                * Compared to DR6, FRED #DB event data saved on
>> >> >+                                * the stack frame have bits 4 ~ 11 and 16 ~ 31
>> >> >+                                * inverted, i.e.,
>> >> >+                                *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
>> >> >+                                */
>> >> >+                               event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
>> >> >+                       else if (is_page_fault(intr_info))
>> >> >+                               event_data = vcpu->arch.cr2;
>> >> >+                       else if (is_nm_fault(intr_info))
>> >> >+                               event_data =
>> >> >+ to_vmx(vcpu)->fred_xfd_event_data;
>> >> >+
>> >> 
>> >> IMO, deriving an event_data from CR2/DR6 is a little short-sighted because the
>> >> event_data and CR2/DR6 __can__ be different, e.g., L1 VMM __can__ set CR2 to A
>> >> and event_data field to B (!=A) when injecting #PF.
>> >
>> >VMM should guarantee a FRED guest _sees_ consistent values in CR6/DR6
>> >and event data. If not it's just a VMM bug that we need to fix.
>> 
>> I don't get why VMM should.
>> 
>> I know the hardware will guarantee this. And likely KVM will also do this.
>> but I don't think it is necessary for KVM to assume L1 VMM will guarantee
>> this. because as long as L2 guest is enlightened to read event_data from stack
>> only, the ABI between L1 VMM and L2 guest can be: CR2/DR6 may be out of sync
>> with the event_data. I am not saying it is good that L1 VMM deviates from the
>> real hardware behavior. But how L1 VMM defines this ABI with L2 has nothing to
>> do with KVM as L0. KVM shouldn't make assumptions on that.
>
>Right, but in that case the propagation of event_data would be from vmcs12 =>
>vmcs02, which is handled by prepare_vmcs02_early().

Yes. But delivering this event to L2 may cause VM-exit. So, L0 KVM may need to
re-inject this event ...

>
>For this flow, it specifically handles exception injection from _L0 KVM_, in which
>case KVM should always follow the architectural behavior.

... and go through this exception injection flow. For such an event, there is no
guarantee that the associated event data is consistent with the vCPU's
DR6/CR2/XFD_ERR.

>
>Ahh, but the code in with __vmx_complete_interrupts() is wrong.  Overwriting
>vcpu->arch.{dr6,cr2} is wrong, because theres no telling what was in vmcs02.
>And even if vmcs02 holds DR6/CR2 values, those might be L2 values, i.e. shouldn't
>clobber the vCPU state.

Exactly.

>
>It's not clear to me that we need to do anything new for FRED in
>__vmx_complete_interrupts().  The relevant VMCS fields should already hold the
>correct values, there's no reason to clobber vCPU state.  The reason KVM grabs

The whole point is to cache the ORIGINAL_EVENT_DATA VMCS field so that KVM can
set it back to the INJECTED_EVENT_DATA VMCS field when reinjecting the pending
event in IDT-vectoring information.

>things like instruction length and error code is because that information is
>visible to other aspects of injection, e.g. to adjust RIP and pushed the error
>code on the stack.

