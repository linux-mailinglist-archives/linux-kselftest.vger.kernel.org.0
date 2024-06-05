Return-Path: <linux-kselftest+bounces-11258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3128FD766
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFD91C21FAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8EE15E5DC;
	Wed,  5 Jun 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jM4QOgN6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434C38FA6;
	Wed,  5 Jun 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618724; cv=fail; b=Ubb/kaqALgyoT+pwQpx2wvi1JIjHvLw30LsBc8VgiuS5lLAOkzU78km/jDU67/p6LuLVY8NA0Wmw9N1Jy+8IoqvKhGT/VB/Gp311GqeDmdAP4oe7aWXSroof5IgXyjJM6FWslHyie8YWmTAU/HwU2OtYkaXi0ljbZcF8vbSNhkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618724; c=relaxed/simple;
	bh=jzVvUmZucSmVIPDWgeDW4QB8FJfrMxBIZQqFQePUi8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KS83c1ndtz7te9d22YIgqHJvw4irH8G5ILj4cJzjTd/cnHdtFCl2KqHE7XW1d4spZWKolV4aSTO99UIKmepFX1GUQtqVc+PXj6ddd6nr7luvsNYOnhYpHc3xDTZdpU3xRe1/UlkrXhxdLz+ZvZl7RHdherP2dX4U/YVVZX9ArdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jM4QOgN6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717618723; x=1749154723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jzVvUmZucSmVIPDWgeDW4QB8FJfrMxBIZQqFQePUi8w=;
  b=jM4QOgN6MufDpJ3cwAQekRy9yM/G5oYARJirFFrfoKZqyBCtoARtxmKN
   95AKMOnu1r/LjpneWby4vs53QICQfDHs0aro2gcoYpoOA6OtJMcoECwu+
   dBb3nXvhnLGjl8KH2wjbijqvhfPE8o4l37m3Mpj1AvzYCmjZgLax/29aM
   61tICMEOVDOqLCz4SAuNIFLD9uTruwUz2JGdtUDRpJpZEBTwngmsjVy9s
   TtHWrm8ukBuesDWY6EkgM6iUHyZkV06jAnC+q6GQR3xNEgMGUx04gj9fx
   vdiyD9YFNxpBKSeXY8ScLBPppYh2RDnCyoSBXMif695xILfDKX6v9JGXb
   Q==;
X-CSE-ConnectionGUID: 5oyj+aHgT56DiRZAA5Fl0g==
X-CSE-MsgGUID: yWsAAzyHRGepzeMjJz85Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25653977"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25653977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:18:42 -0700
X-CSE-ConnectionGUID: z6crZu/SQtKV+qk1dcnQrA==
X-CSE-MsgGUID: GFHyCLpCSKSl3zXpQuitxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42637457"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 13:18:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:18:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 13:18:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 13:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv+04pLdgKDvhGwB9iHmUKVUA4VMUl3tTMLf3iJYLTVhTe9jlqJbfV1HM68ttekxWvm6h/WHRc10LujbqpIcRlRHj/2BVXyHBZ2NAgjVKC2WZBhGmlhSbvMzNihaDYilmSebwv6oD3l1trgOj1eEQFpLha8vwx+H9AUKXw+B7qZGvU74zI9cZOpfP4qXuOGHgc0rYwe78hJp31dhGQF90/frbbiC/FcjCy+8V4+bzDTCDmsWjF3j5KV4ampin+ixFDKR4WAY7f7FIDpEdbhdEV7/aRonHmOWqJnkUh0V04GHWb4+TDWFXlyg4dRtkYdJNzmYlEYW56PIOHUgRDvqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzVvUmZucSmVIPDWgeDW4QB8FJfrMxBIZQqFQePUi8w=;
 b=S5TgCPADgdkLQMlqdOCO2ePVA/hZrVzYELQHio+JyC6i4nFct1wCn8hvISimS//DVYfJCNeciMOrLQAKZdrT2TXu5RN76npvcSvRfGQL8CRVEmeoMBZvh4jnD5Dnd8rb1sVuGp+YGEq+gmKs84AjM0fqYRV/XcE+C06EYF7PEKl7Nk+hMpVYmO2DTaX7eXdSKHOct531o5ErzKDn4ZI4agw3vW4s1Obhz6frYW8gZFOEjzz0tGe/69xbjyS3LJISTypwrTj33ZTBVt5OFBUms653SgC4ZAPiLE5u7aYHG661jQnyoXkb08I2pOHSuh6cdLefu/HTK1tvk2oOJQM+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 20:18:37 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::eff6:f7ef:65cd:8684]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::eff6:f7ef:65cd:8684%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:18:37 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "sagis@google.com" <sagis@google.com>
CC: "vipinsh@google.com" <vipinsh@google.com>, "Aktas, Erdem"
	<erdemaktas@google.com>, "shuah@kernel.org" <shuah@kernel.org>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Afranji,
 Ryan" <afranji@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jmattson@google.com" <jmattson@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "runanwang@google.com" <runanwang@google.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"pgonda@google.com" <pgonda@google.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Topic: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Index: AQHaLTxo7g1LHBoyE0m0HNgVI+vn07G6lI+AgAAZvQCAAAF0AIAAAN4A
Date: Wed, 5 Jun 2024 20:18:37 +0000
Message-ID: <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
	 <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
	 <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
	 <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com>
In-Reply-To: <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.1 (3.52.1-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|IA0PR11MB7212:EE_
x-ms-office365-filtering-correlation-id: c41cbfef-f84c-42f1-449e-08dc859caf07
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z3cxOExqZGdDU0luRUJ2VHpVQVh1a01pZGh5UlloL2x2UkV3eVQ1WTFoMFlz?=
 =?utf-8?B?RTRUZEtmTzl2eEQwS0xyMU5CTWFUK1dJQVlhc2N5Njd2TkVrZy9VNFE3OTQv?=
 =?utf-8?B?bzZCa0t3d3JFVk82SzBXR2VlM1V2N1NybkQ4L0FTUmFoaklHRHBqOXpNdnM0?=
 =?utf-8?B?TTY1MkRtR1ZTTTRIL2VIdmJ6dEFyZHFwN2QzZkppcWVTL3NoSkhDQjVSNGQy?=
 =?utf-8?B?ZXpyOHdHcWg4Ty8vUEE5MWZzS1ovQnN0MEhScXhkRFlHUTAyU3FMNk9FNGZO?=
 =?utf-8?B?TFVKWEZNMWRTUU05ekpSd0o2UmZvaG9WeHRWNVk4SEYrdW9rQ081Uk5qczNl?=
 =?utf-8?B?Z3FuVllEdXNsRGtPenlORndJWC9neDZWYitRSzN0ck1nU1hIUC9JZ3A2YjVO?=
 =?utf-8?B?OUYwU1pxTHd0d1VlYi81YVljMlMzVFA2UGViS3A2T2tTMjBrdHduNjNOWFhu?=
 =?utf-8?B?eDYybithK0U4UEk2a0c1cVpzTWVWSDdsUGVQYlVtd3hWdHBOeFZaKzE1M3Ri?=
 =?utf-8?B?dllpdjFhM3Z5Si9ONjRZcjRPSUJvOE5kMTdxYmZFNDBDdnkxYXJVK3BvU21t?=
 =?utf-8?B?b2xHK1QrRFc0UG1PR25PM3JBWEhnaG5TY1BIVGgzVjhmamF1ZVdJQVZoVFR4?=
 =?utf-8?B?NGFlUUc5TGY5b21DSENaL04vZGxCMjZLNkNKYjN5akc5cUFlOWhtQXZSbjRG?=
 =?utf-8?B?SDFjTnR2dzVlWlZYS0JsMDJPM1B3VktTWnBqd0VPNnJBUHVMUDMrdDZEYUgx?=
 =?utf-8?B?UWRUWDYyVi9NU1A2dmhmdG1oRkJJL1NlLytOeGMwVmR2NjgxQ21RS0piKzBx?=
 =?utf-8?B?eEVnbW9mNnpTQmdHaFY1ME9xalBZS1RzaFJ2MWFaL3dFQ2U1cDlueU5OWnIr?=
 =?utf-8?B?cjJZelR5M0tDd0QrUTdCNWRCZEI2NVdJRjdVaEpEenJRcFRob2VzbEp4eFRa?=
 =?utf-8?B?aGRxU1Z0K24xK21hNXJuOTgxV0V3Z3F2blJraFBEdnkzYXdyM09KWFl1cTA2?=
 =?utf-8?B?R1B5a21wRDFKMTRjTVA1U3lQcnh2bXk1ZDFzQlFnMkZyY0VUM2x1UC9nSG1M?=
 =?utf-8?B?dHNtY3RtRmwzUWxMSlhQalZaNEZmYmYvNWo0MWMvN1p1cXc1TEtEQnptdHA2?=
 =?utf-8?B?VE9qY3JkWUg4YnllMkpNWEJiNjlmN1ZrMGN2bW56c2wyK1pzMGR5SkhwTWRR?=
 =?utf-8?B?QmpvQVhpRzNxalowUVNqKzdKMEd3VkZKa0d0WTVwMVpZQVNwVWZBYWFuWlhC?=
 =?utf-8?B?b2YzN3EvVEN3MEVwdENrWG4zcG93WVF1STE5N3JzQVFOdTVOVXp5QXNxUHUy?=
 =?utf-8?B?WUFrUTBQaTZtSWpRWnlpckFXUWZCRW5TQkNQOGQ3Vnh3MGVHK0w4b0RuMnht?=
 =?utf-8?B?eG9pYlRSczBxajZtUDNoOUJFRWRadU5BTXNPSHY1SnkzMFhEMnFOMlQ2V1hy?=
 =?utf-8?B?NzZBQ0xGcVN5bjdycTRHVnV2YkhXZmJaWk5pelBpWUZtYTRjclUrbGl5T1pH?=
 =?utf-8?B?NlI1bDIzaDhXU3lpOHhndEEyMnFXMmZ4bUxLTDlNNUtkVGQwSVF5dG8weU55?=
 =?utf-8?B?OGF6bWRuZk1qNm55RnB3OUtzNHhVVWZCTWc2RTN2SnprUGZBK3FGNnNsK3Bi?=
 =?utf-8?B?cXFJeUl6WktRcWkzSU9aNGY2K2YyK21wVmVFRGlSRWpidXYyUG9ybEJNd0hO?=
 =?utf-8?B?K2orZFZrSnZrNlRiWGtxRllEOXNhUHVRME9ITDU1bzhyR0Q4V1hlUU1iUTVU?=
 =?utf-8?Q?gBeWcxkhQGQyLu3LoOskXwIO1rFOwyUZdgdHN1f?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2pKSUtTN0c1MzdUOEo3dFg1b1R3bm1GZnRFMWQ3bmRkRXNsdGVDZGxWeWc1?=
 =?utf-8?B?MFVFM0F4NlpGK3Q0N1FUN0VjQmRweHM5am5oN09lS2xWSFhFVWhlbDUzUS9Z?=
 =?utf-8?B?cTJtU0VXSC9HeHVQUFZFb2FCdUJQZGROOHpybkdCUGMvaWQrU2pkZlRpN1lm?=
 =?utf-8?B?SFBlUFExeXFZZHgxbk5tS1pFWmFkVmNVMWFFVnd1TTVPRmlFZjJsdC9yaUlp?=
 =?utf-8?B?TTFsYkk5NEJQZFBQVUc1VWZDZDEvVFZ6ZDk3M0FBTHFaU2JGZTlYK3crQ05p?=
 =?utf-8?B?Zm1vMzBSTjY3RWUzVFpDQm9adUZYakpyREc2bzh6YjNXWVZhMmE2SDhvQnMw?=
 =?utf-8?B?cFlPZTVXMmdMcDF4cDlyek05dDhNR3RZL0Fxb2FBN2MwUmpla0xsWkVyOEsv?=
 =?utf-8?B?VjF6ZVpDRk11YnE5bTVwc0dubHM3clppNk9OSmFHNSs3d1BNV2YxdG5qMzB1?=
 =?utf-8?B?ek5TZnhnQVRpNnVqMGpJWGdPcmJGVm5RSm5VaVJEMC9KRzBPdEtGZVdNWjZr?=
 =?utf-8?B?ekFvQWtrcTgweTBJbzY2THBabTNLZnVDZGovd3FWb1ZRZkZ1Mjk3b25VVHVL?=
 =?utf-8?B?ZE1xS2hEUkFkOHRWR2Izd2J0eW85UHRIK3RJUlgzSVVrMjV6ekZ0YlZqaUxk?=
 =?utf-8?B?d1phdWpwcHBzK3ZYVVExdW04Q3lMdDFQS1ZNckZINkdJU0JBUCtHNlpDS0Rr?=
 =?utf-8?B?aDd2Vld3RU9pWWo2azhEWnpJaUxCSm5TemdDVlBKRVFuV1VHdUd3Y0xRSWxo?=
 =?utf-8?B?RW5VeUUxMURwN3pKTmxzYlE4ZXdOUTU3OXNRT3p4WFFUSWRzK0ZEbC9hbEY3?=
 =?utf-8?B?NW9URmVndFpzd2paUzFhdW5HKzdpR1paZXFGY1puN2RRNWd1UjVaNFNhSjRy?=
 =?utf-8?B?RFF3NGM1MVZmajMrOTZJVVN6SzFjZ29vVktNbHJWd3pWWUpFWkFkQlhqbXJ5?=
 =?utf-8?B?NVNoTFR4TFNyaVhWYkJ1enQxQVVpeVFhdkhuYWpnZE9Hb1dXT1FHc2pXV1k5?=
 =?utf-8?B?UUhqTjNaRm13Mlc4dDh1QzRObGplc1YyL3hRbUUzQ0syTzBEZisvNjRPNWkx?=
 =?utf-8?B?YkdrbTVFZkJFd0ErYS80Njk1ZWNPRytyRElkTkZaVXNDb054SmNzeWh3Nyta?=
 =?utf-8?B?czF5ZnpHTDEvUWhDMCtaZ3dUNzFOa0MxdVJRb25aUG4yUEU0OStDY2ZNenE2?=
 =?utf-8?B?ZEkwcnVZTGMzQlNXeFgvZjdIUTNvenFsKzVBbzNGSnFRcjRnQjB6TmphUkw3?=
 =?utf-8?B?MUJOY2pDc2o5WTBoQXRyV0FBL1dIajRueG1IWHllK3hKR2szK0FLdVRYS3A0?=
 =?utf-8?B?eEdGRUtMYWVwN0NnQjUrZU9DTWRRMVRlME1OMXBRMWZSaW9aOGZQNDJ1YlhE?=
 =?utf-8?B?Y3A0Mm1POXRPTXU3WDRlSGR2dTBvZWptWEFwRzRMTDgvWXV5ZmhDUGRETkZa?=
 =?utf-8?B?R1lZbXk4Q1hFaWJ1Qm1vaHREcjZYaGM5ZFJ4djdZRHRvbVJCcHJQb2JHM2JN?=
 =?utf-8?B?UkFNcGFoTzJrL2J2OHZyQ0M4ZTFrR1RKaFRTbXlMb3FFeXhXczJPbm9tTzRR?=
 =?utf-8?B?RER1S3Q3clVlQ0JlMExXREJpOWNCSTVhekpoOEpKeDhEcXZRR2dQNHZkWWl1?=
 =?utf-8?B?cDNJSEt2bXpzd2RkZCtoR0oxajY1TzdyN3RpamtvMHhZZG9vZmc0UklwWGFv?=
 =?utf-8?B?ZldDY1dsVC82L1pmNEdqV0x4V0w0NnA1RGMzcy93cFlDK3U1T3lKYWhtRlJt?=
 =?utf-8?B?TGxOOTRnSjVuYkZrck9LcTYvMDdxdGR0aVJ4bUZZcG1WN2d4aTNzMWROWDJM?=
 =?utf-8?B?eGlPSWFtYThqWDYwV2ZzWjM4ZXdkME05VHM2WWFwZGdaTEY0OXp4SElhT0py?=
 =?utf-8?B?eVhOMngwUm9BNWc4ejVGOEdaaEZXOW8wWHpvUHBSaTlnNkUxUXBSSTNORjNi?=
 =?utf-8?B?ZWRDbW9KcldsVERIRFdyREIwZ3k1OUlxc3d0aG5MSmRnbHFGWEZ4NXNrUDNL?=
 =?utf-8?B?YlJnb2U5RjM2N1JkY3ZPNk8wNmhKQUpBcDcrR3IvRWRUczFTcnY1VDh0VUZu?=
 =?utf-8?B?Wi9FZGNBVmRRQ1QvT0RhT0NIWlBtRGVkTW1yYWFhTS85T21ORy9ZZHZNTmhG?=
 =?utf-8?B?d3czQjFLVHMzVnBnYkczSWdMM3ZkOFNkZXQyZk5zeng2M0laQXZCbEtKWUYw?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E004439CCD0B040BC491A0A989D120D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41cbfef-f84c-42f1-449e-08dc859caf07
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 20:18:37.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjAfJGZZ3ewF/7wXM5/ugpwnFC98opDXY6pzPhsTYG/kqUr83mBpNdNMLkEn9qpNGSx1ToH+EO+7aasUNSB+OpR/7nLRDMGDyWT3Jz6PBsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA2LTA1IGF0IDIwOjE1ICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyNC0wNi0wNSBhdCAxNToxMCAtMDUwMCwgU2FnaSBTaGFoYXIgd3JvdGU6
DQo+ID4gT24gV2VkLCBKdW4gNSwgMjAyNCBhdCAxOjM44oCvUE0gVmVybWEsIFZpc2hhbCBMIDx2
aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBUdWUsIDIw
MjMtMTItMTIgYXQgMTI6NDYgLTA4MDAsIFNhZ2kgU2hhaGFyIHdyb3RlOg0KPiA+ID4gPiBIZWxs
bywNCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgaXMgdjQgb2YgdGhlIHBhdGNoIHNlcmllcyBmb3Ig
VERYIHNlbGZ0ZXN0cy4NCj4gPiA+ID4gDQo+ID4gPiA+IEl0IGhhcyBiZWVuIHVwZGF0ZWQgZm9y
IEludGVs4oCZcyB2MTcgb2YgdGhlIFREWCBob3N0IHBhdGNoZXMgd2hpY2ggd2FzDQo+ID4gPiA+
IHByb3Bvc2VkIGhlcmU6DQo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zl
ci4xNjk5MzY4MzIyLmdpdC5pc2FrdS55YW1haGF0YUBpbnRlbC5jb20vDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGUgdHJlZSBjYW4gYmUgZm91bmQgYXQ6DQo+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS9nb29nbGVwcm9ka2VybmVsL2xpbnV4LWNjL3RyZWUvdGR4LXNlbGZ0ZXN0cy1yZmMtdjUNCj4g
PiA+IA0KPiA+ID4gSGVsbG8sDQo+ID4gPiANCj4gPiA+IEkgd2FudGVkIHRvIGNoZWNrIGlmIHRo
ZXJlIHdlcmUgYW55IHBsYW5zIGZyb20gR29vZ2xlIHRvIHJlZnJlc2ggdGhpcw0KPiA+ID4gc2Vy
aWVzIGZvciB0aGUgY3VycmVudCBURFggcGF0Y2hlcyBhbmQgdGhlIGt2bS1jb2NvLXF1ZXVlIGJh
c2VsaW5lPw0KPiA+ID4gDQo+ID4gSSdtIGdvaW5nIHRvIHdvcmsgb24gaXQgc29vbiBhbmQgd2Fz
IHBsYW5uaW5nIG9uIHVzaW5nIElzYWt1J3MgVjE5IG9mDQo+ID4gdGhlIFREWCBob3N0IHBhdGNo
ZXMNCj4gDQo+IFRoYXQncyBncmVhdCwgdGhhbmsgeW91IQ0KPiANCj4gPiANCj4gPiA+IEknbSBz
ZXR0aW5nIHVwIGEgQ0kgc3lzdGVtIHRoYXQgdGhlIHRlYW0gaXMgdXNpbmcgdG8gdGVzdCB1cGRh
dGVzIHRvDQo+ID4gPiB0aGUgZGlmZmVyZW50IFREWCBwYXRjaCBzZXJpZXMsIGFuZCBpdCBjdXJy
ZW50bHkgcnVucyB0aGUgS1ZNIFVuaXQNCj4gPiA+IHRlc3RzLCBhbmQga3ZtIHNlbGZ0ZXN0cywg
YW5kIHdlJ2QgbGlrZSB0byBiZSBhYmxlIHRvIGFkZCB0aGVzZSB0aHJlZQ0KPiA+ID4gbmV3IFRE
WCB0ZXN0cyB0byB0aGF0IGFzIHdlbGwuDQo+ID4gPiANCj4gPiA+IEkgdHJpZWQgdG8gdGFrZSBh
IHF1aWNrIHNob3QgYXQgcmViYXNpbmcgaXQsIGJ1dCByYW4gaW50byBzZXZlcmFsDQo+ID4gPiBj
b25mbGljdHMgc2luY2Uga3ZtLWNvY28tcXVldWUgaGFzIGluIHRoZSBtZWFudGltZSBtYWRlIGNo
YW5nZXMgZS5nLiBpbg0KPiA+ID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2xpYi94ODZf
NjQvcHJvY2Vzc29yLmMgdmNwdV9zZXR1cCgpLg0KPiA+ID4gDQo+ID4gPiBJZiB5b3UgY2FuIGhl
bHAgcmViYXNlIHRoaXMsIFJpY2sncyBNTVUgcHJlcCBzZXJpZXMgbWlnaHQgYmUgYSBnb29kDQo+
ID4gPiBiYXNlbGluZSB0byB1c2U6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNDA1MzAyMTA3MTQuMzY0MTE4LTEtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vDQo+ID4g
DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgb25seSBpbmNsdWRlcyB0aGUgYmFzaWMgVERYIE1NVSBj
aGFuZ2VzIGFuZCBpcw0KPiA+IG1pc3NpbmcgYSBsb3Qgb2YgdGhlIFREWCBzdXBwb3J0LiBOb3Qg
c3VyZSBob3cgdGhpcyBjYW4gYmUgdXNlZCBhcyBhDQo+ID4gYmFzZWxpbmUgd2l0aG91dCB0aGUg
cmVzdCBvZiB0aGUgVERYIHBhdGNoZXMuIEFyZSB0aGVyZSBvdGhlciBwYXRjaA0KPiA+IHNlcmll
cyB0aGF0IHdlcmUgcG9zdGVkIGJhc2VkIG9uIHRoaXMgc2VyaWVzIHdoaWNoIHByb3ZpZGVzIHRo
ZSByZXN0DQo+ID4gb2YgdGhlIFREWCBzdXBwb3J0Pw0KPiANCj4gSG0geW91J3JlIHJpZ2h0LCBJ
IHdhcyBsb29raW5nIG1vcmUgbmFycm93bHkgYmVjYXVzZSBvZiB0aGUga3ZtLWNvY28tDQo+IHF1
ZXVlIGNvbmZsaWN0cywgZm9yIHNvbWUgb2Ygd2hpY2ggZXZlbiB2MTkgbWlnaHQgYmUgdG9vIG9s
ZC4gVGhlIE1NVQ0KPiBwcmVwIHNlcmllcyB1c2VzIGEgbXVjaCBtb3JlIHJlY2VudCBrdm0tY29j
by1xdWV1ZSBiYXNlbGluZS4NCj4gDQo+IFJpY2ssIGNhbiB3ZSBwb3N0IGEgYnJhbmNoIHdpdGgg
L2V2ZXJ5dGhpbmcvIG9uIHRoaXMgTU1VIHByZXAgYmFzZWxpbmUNCj4gZm9yIHRoaXMgc2VsZnRl
c3QgcmVmcmVzaD8NCg0KQWN0dWFsbHkgSSBzZWUgdGhlIGJyYW5jaCBiZWxvdyBkb2VzIGNvbnRh
aW4gZXZlcnl0aGluZywgbm90IGp1c3QgdGhlDQpNTVUgcHJlcCBwYXRjaGVzLiBTYWdpLCBpcyB0
aGlzIGZpbmUgZm9yIGEgYmFzZWxpbmU/DQoNCj4gDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgYWxz
byBhdmFpbGFibGUgaW4gYSB0cmVlIGF0Og0KPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVs
L3RkeC90cmVlL3RkeF9rdm1fZGV2LTIwMjQtMDUtMzANCj4gPiA+IA0KPiA+ID4gPiANCg==

