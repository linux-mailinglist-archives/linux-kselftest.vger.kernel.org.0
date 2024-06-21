Return-Path: <linux-kselftest+bounces-12393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6229118D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43863283D2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0524F83CBA;
	Fri, 21 Jun 2024 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cg+x2gW0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDB224DC;
	Fri, 21 Jun 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718938270; cv=fail; b=ZfzUCURgJbhhe9DXRSmf/KjnqRmTgKUovoEqiXYu2CqFBKptOJbggNjehg9o/rdBT17Hc4uo2UeruyNqWOv7C8ZvQP/oeNr6xDyDZnTp1ZPTT4vV3mB8EUhk9K8qRaYhwpd7uzNAXhbdbRdAw135CKc8tUrjJD+clifPgjUggp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718938270; c=relaxed/simple;
	bh=DW5CULMFODhxO1+0Ei/OjDby4npC0R+Rr6ttlm9C1gU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dwipyTNBu1fTgLmRQBgRRkyoAUBgg3UEp5dCSYa6iqVpeW4Yx0ykoK7WvpwPk86WOjLTWYHmtB6XAbJYqMeVOU+5vpmFK88LIQDv4sCvNxuHBF0nucHceN+tqsnY5oTRDbgolbUVLr2ijtS8hMnMK+hR1E0pj4T/k/Zyi9ZAfHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cg+x2gW0; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718938269; x=1750474269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DW5CULMFODhxO1+0Ei/OjDby4npC0R+Rr6ttlm9C1gU=;
  b=cg+x2gW0NC1s/J4BAXgJm7OrwOqVD1HlSCSbeR+3Ypo4f/k9kq4LfRFi
   EiwNbD9O7P1Y01vJBI2H1hHtShlzXNm72t2EfRWoCLgGYhMFtn6ABSe3i
   E/0vlyUXoKlfg2dbG29Sw+H4by5GTz7fA0Xo3UAmaAbvb0VQTGZbHifGW
   NyZU3Cf6/vGAg5KS1Wyedwh8ONt+3Bf+YEgnS9LfP3k767+D+32zSRRAh
   SRtMQ52EMm8SvFlquiO5+x9ivo+Qw80eLAsLPrwMvKq0iKhZhJDAxmxbX
   HGBOIl3jHAKxSiL0vLglvZDxE2FmUUE7op31EJd/oERJLpV3gN4rdDmtQ
   Q==;
X-CSE-ConnectionGUID: Wn2GHjAYRfKcx+vGtrXooQ==
X-CSE-MsgGUID: fxmk4mqbTmGhqbInuzhWUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15788009"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15788009"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:51:09 -0700
X-CSE-ConnectionGUID: MvoODmY/SHWahRH0gOcRcQ==
X-CSE-MsgGUID: 2dorpwfPQ+GQ2n2thD/z0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="43128698"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 19:51:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 19:51:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 19:51:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 19:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2kihsaUVj/Q807weWMeRSew5H9OaoVj9cE1hygHCGHdC2vj9ohN+cR1KGFnuwA8Rbz/pJXNJcnSUFhGuJ/1QM6cqvvpu24d57UB6ewudCLM48VAQX1jBhuNJgybje6sTVZzg8wzj3y+mtzWunFNh+VLEv+lHirMkKoxpxx0Poh9I+4CI9TYiKvtL4O37w8wQh/XZ5TTVcmfVIdpelZm2JRncWAnuZJgR+/gex5cDIJEzRnO1e5tE0FlAiG/sXEsCX5qqHHZUqqG0ZwzTjbrEhOz2byzWobzA8rwd/8qDOjw7nmf7UDoBL8rZhF3NJhx6XdmUD9IlHOEwbe954sg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW5CULMFODhxO1+0Ei/OjDby4npC0R+Rr6ttlm9C1gU=;
 b=XzeSgVw4sV/yY3RClSpSmnW1tU52uY2nkqUO3LZH/NhJZwK+nemBsv7+4QuLa+HlJvprsjL/h1dw5k+GhGyuDX1pbimyLGWj/dV/jQ431TdNXDkn4SenTcSd4R9bpSFPCZrTRoWh8uwA/9+lFChgYlThQwDz5D/D62WUt0O5x2GMEvtTwcAk0Tbb4v6o3BqAZ1RzAlpjOmA6Rv3ur+PGKxr6G4KXmdhKsqrjcrYvZYGx2w6P02sQpzlde29NLLFbxi83cDpLfxw6rVyfIPF3L0nR3Ul4hv3cVZu4wOKRPlrkM0XLW7DvwOMEvxklsjPr3luVKe9KDqmmKL/Qu/T76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 02:51:05 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 02:51:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sagis@google.com" <sagis@google.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "Aktas, Erdem" <erdemaktas@google.com>, "vipinsh@google.com"
	<vipinsh@google.com>, "shuah@kernel.org" <shuah@kernel.org>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Afranji,
 Ryan" <afranji@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "runanwang@google.com" <runanwang@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"pgonda@google.com" <pgonda@google.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Topic: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Index: AQHaLTxo7g1LHBoyE0m0HNgVI+vn07G6lI+AgAAZvQCAAAF0AIAAAN4AgAAGnACAAAQQAIAACmaAgAADAICAF+iOAA==
Date: Fri, 21 Jun 2024 02:51:05 +0000
Message-ID: <271e9f4168175f36f90c91fbe45e6e628e157ca2.camel@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
	 <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
	 <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
	 <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com>
	 <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
	 <CAAhR5DH79H2+riwtu_+cw-OpdRm02ELdbVt6T_5TQG3t4qAs2Q@mail.gmail.com>
	 <e161c300e9c91237c5585fab084101a8f46768e2.camel@intel.com>
	 <CAAhR5DF=wAVsshyX-JqcPhhrVp8rEF11uJkB-OSEUM-B-oEZoQ@mail.gmail.com>
	 <262ee73f23445fea7129a784ff3d6bc4294c25c0.camel@intel.com>
In-Reply-To: <262ee73f23445fea7129a784ff3d6bc4294c25c0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: 314cb890-7ffd-4e05-6c59-08dc919cfed0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?S25hdmg0NEFFZU5OeVdBczZUWkJkZnRrQWFnYzI2bnpmVGxDZTdCRHJMRTd6?=
 =?utf-8?B?Qmh2NHhWSzJuNTN5bzMzdUdleWl1cElEZDZxeitSdkZBQ1BtSUVjVWVJWWln?=
 =?utf-8?B?SVl2VXloYzcwSi9oZGc0WkdNV0IrWWRZWDZORjhFNGRZb1ZVWEV1dGc3SE9X?=
 =?utf-8?B?L2JxL0F1Z1JUbDVWMDUwSlRxaWJBd0tybkpsa2J4SzFoaDBnbnhHcGhWa3ph?=
 =?utf-8?B?dGNyUXovbCtaSjVXVjd2UlNJZ2JJMVBieVdwU1dLZ2pwRGtzT0dOUDB2SVI2?=
 =?utf-8?B?V2h0bnFIaW5ubG9VakpyQnN0QzVCY3FwdzU1bCszNXFieC91bWJjTkJTb3RB?=
 =?utf-8?B?SkNBNVg2ZTFieXd1aTRNamJ4SlZtMHNDdUREUXV3ZHJ4ZFpuT3ptOEM3b3Mv?=
 =?utf-8?B?c0ZvOGFJZHFBMW82ZWlHQVNuTkR4dnMyeDF6UzdTclJDU1FtbEUzT1JWbUxI?=
 =?utf-8?B?dXptQXMvU3lGV2dMbU41dHRjeE9ScTE1QmtGVElnSmtoZVd1dVAzV0FpZ2N4?=
 =?utf-8?B?ZHBIbUNySkN3VHE3b3Y2blpjRElxUUMxbEx5cVNuUlAwbUtKTnIxenhKYXJX?=
 =?utf-8?B?WFhMeWxDc1hNSmJiYmNaZ3Y4clpYWDN4ODdjUktIVzROSFlUcUc2RUJydlk4?=
 =?utf-8?B?RjRIQzlPRlBpaTNycUVyVzhLN3pKNHVmWFpFRG9RUHZLYzFZK1hYQjViM25w?=
 =?utf-8?B?ZFpySElwNXg5dW5aV05jSzlpMUJhVkVKREc3MmFKTk0wbUFwTkxZYVduRWNi?=
 =?utf-8?B?MjY3UStialdIcmJPVDFBK1g1SUVmOHlEZlZqQ2dFOTMxU3J2cm5Ba1RtZG9G?=
 =?utf-8?B?UXd1dUpGRU9yNWszbE1peXduZy9UUTlOMWNmdDQ3VTB5RzB3Y3FnaHk1dXVD?=
 =?utf-8?B?OFQzL0w1Zk1zU1BqZmZPNlA1dmF1emRxVklQQmtlV3lFdW9nUldxejZWc1NE?=
 =?utf-8?B?U2lUN290MVp3RWo4bmx3eHhDemp1ZnVRNTFVSHM0eDZzTGRBK1BQVG4wK3N0?=
 =?utf-8?B?ZmlveVJmUitROTRpbWJtOUhUTmFRbEdLTlJ5bzZZWXBBNnRwcDY3Wi92clZE?=
 =?utf-8?B?Z2xjM1l2NU1OZWlLaUVsTk8xOGdOTjBsNEViNVpNbllTcTRkNkZJbGx2SEZz?=
 =?utf-8?B?QWMwY2tOZVN5OHhhOHI4L0RSZWtkTFhTaE15T09yQ3lLZFIzZy9QaEQ1aUlv?=
 =?utf-8?B?UWU4SmlRQTZzZkJUTWNtRnB1RnpPN2xEL28rU1V3aFIyM0IzTjV1SHk3M0hG?=
 =?utf-8?B?S1FoQXJGMlVCNGN5QjVyZDh4WGpIcjhqQldPVjh2TTg0dk95cWt3dkFsSDN5?=
 =?utf-8?B?M1dIZnQ3bEZ1R0lLZENLUFhJb3RZNW9hUUhlS0k3VWFxMTV2WThoK1c0YVk0?=
 =?utf-8?B?QlJtZjJQVmFvUEtSYmRacXMzTk05OVNac1dhVWlHTG1IQ2ZJQ0tuYXpOWkwx?=
 =?utf-8?B?VnJtOFZMZ3Y0amtXZUR3Zjl2a2tvVHN6ZnY4SXl2ZjM4U1NmUUVqRkU2ZDB5?=
 =?utf-8?B?VEhVN1kvRWQ5b0JNUE9mdGRUTDJuZlZ6UkVmNnFQbEphbytLSzV6TnRmUGkz?=
 =?utf-8?B?N3VUZW5IbDJGeVNpWTVVS3p6RnJwNU80N240cFQyVFhSSzY3My9meS9uc2NM?=
 =?utf-8?B?Rloyb3ZGeVRSQ1lyVFFMNUdiQ2ZrUzJVeUJRRGs1QjVRcnhnbXNJc0ZnNHZR?=
 =?utf-8?B?Ym0yQXQ4SG5jSkN0WWZFa0ZFZWx4aERkdnNuYzhZNzFoU0kyZ3dOK2NMUW5K?=
 =?utf-8?B?dFg5VjdZTlZCZCtyVmhKY29zOGpSZXdKWkxjdVNPWDRnZmMwTVFKRk5pSGo1?=
 =?utf-8?Q?X8ks3lDqzZnZwyBVO5k6FuUQG+Px1KRSkn8Gk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NOZTFDa21KZFpqSlhzNHhSUXdGZUo3S3JLazdYOTF1c3RyQk9ZT1pDQ3dD?=
 =?utf-8?B?WWo3Y2JkNFFpR0xWMm94SnFVanVRbkpvQmI5Q3lhVG56VDliM3prd09XM2hU?=
 =?utf-8?B?dkxuVGQ4UjczdmJEb3dKa2ZELzhlL3RDdlVla1F4T2NtMEl3OVlFcDkzOE54?=
 =?utf-8?B?N2hTQVRoSjk3OUdaT0RtejgxVFlJNHFMWE1kVEt1UEl6b1dZZEN0bHlUNWRk?=
 =?utf-8?B?NngrdUhxVndzTS9hdGlaTVFLZDJJTlpNenBUdVNTQkhuYUZRU3RvT0t1TU8z?=
 =?utf-8?B?anpReXo0eEdiNG1tOWhNbCtHUW90ejVma0l1aHUwMGlxVDB4OEEzbk95UkVC?=
 =?utf-8?B?THp3MnFxREdKUlU0Skc0dUFJMmJoUHNpY0Y1Nk1zQ3Y3M2htYlVyY0xFZVJW?=
 =?utf-8?B?eFFYM3czcU1KaXhHQWJkblgwQm1yUzI0bzRmcXk5NGFKUnlUYTk5c1MrdjNJ?=
 =?utf-8?B?eFgwaEdJdXNjeG4rK0FRcEVwSkJsYmJvbTk4QmljWHFNemUyTjZUVkNmcUlM?=
 =?utf-8?B?WHJlRXd4SWp5b1EyVlQwL1VQbTNoKzJ3VFJXZXhJeGt4TXRhbGsyU2tWTDhB?=
 =?utf-8?B?UnBRUEhTNitlelhxcDFCTHZoK3RlemVkY2RWS3QzRytSKy85cE5LOE9YcEt4?=
 =?utf-8?B?Vk0vZENBaHM5OXQrR2FPczhvSVBFZTdoWUcyK2QrSVlaZWRuRjhzRWZyVDBk?=
 =?utf-8?B?RDJ3dXhwMHBsbXFiSUZLMEhmWHc2U3BsUGhQenhqR1MyODMzMnU3aU9SaW53?=
 =?utf-8?B?LzhLQnVGVFdEK3hTekVQTmNGbUhKb3dCRGFqOGRhV0R1ZlFEcmNyT2twc2hO?=
 =?utf-8?B?RmdhVnRWYUZFZkRRSDhOOGhGS3VtOTZTNFRoeUQ0VlJtWmRHS054bzF4YnlW?=
 =?utf-8?B?ZzIySWdxdk41ejFXVDVJNFhHNVFsOHZFSEN1ZzRPcjlrWTNEQVpjM3lsSzlv?=
 =?utf-8?B?UnNNSTJ2OHQzVXgyN09kQkgzcElBZXZPbCtWUGgxRktWTkVZWWM0c0hSUnJn?=
 =?utf-8?B?Tkpkd2VkS2dYSndSTHVoQWlmRmRVc2ZrM1ZKTlN2Skpva3NIczlMcEV5ZVFR?=
 =?utf-8?B?blhRN0hyT0ZMV2Rhb28vdjNUNXpXMURMdDFSejZacjRNV2kzRGcwbmpPT3BR?=
 =?utf-8?B?WGVnSkQ1OEwrbDUrZlhPY1JZTlVwT0xXZWFrbXRqSUdIVEU5eENzaWJhL3RR?=
 =?utf-8?B?UWpUSStCR2Jac1ljSGZYOHJ0clY5T0s5ZVRBL2pRYVVhNFZvYmhUaHByc1hU?=
 =?utf-8?B?bUVkUEM4MmlPYkR0MmIyZ1U3dW1xR2J2dmtXSFQ5aDZLTzE0a0tieXlNck9i?=
 =?utf-8?B?VWpadFlZU0FLWko3djhVaDMyYzkvYlBoYkZWSGlrejY0WERFNnR0dkUvQzVk?=
 =?utf-8?B?NVpwU0Q2Y2NpZzdHTEl3MFFEL2dFQS8yNXdXU3E3TVBROVBwWDdBSnJjd2dC?=
 =?utf-8?B?LzMyV29peVpaSm5tc0ZXQ21TRUY4RFVWdGVDcTI3OGNCN1RZZTR2eUJQaXBp?=
 =?utf-8?B?TTQ3dkJoQ3E0L1JIODE5cU9xN3NEV0xqQnMzODJ1N2loSG1VdytCa1gvTzVS?=
 =?utf-8?B?TDZteFBQKzVmRkRidnoxc3Vsb0hYeXJnN0FyQzNzZzJ6WjRIY3pVOVpuZmcv?=
 =?utf-8?B?YlUzZFgwTTRTQVdONS81MzBvZWFpQUd2WXVXdUZWMThodlppalR2NnhyRmpR?=
 =?utf-8?B?bXBWd0RQcGpmdVRSNFBKcjVCbFpHMW43NVA4RXUweFc4b29IYVJhNTNKQmlw?=
 =?utf-8?B?clBwQ0xuaW45S2VXVmhYQ1pBVm5Oc0NvU1hnOXpqL3RPdVRPc1htb1lKbGxk?=
 =?utf-8?B?R2FudU5aSzZDMEo3VjlwT3Q5REhlZzRPUkVDRFpTZTVjUjJCa3pYMmdXMmtG?=
 =?utf-8?B?RU9ML210NEJzeWFGYmpLaVRvZVJjL2ozR3JUWHgrN3VQWitFQ2U3RlFSZHg2?=
 =?utf-8?B?QUM4YXc0eTY5Zk4yRjNGNG95MEVKUlRDUWliWEZCQ3ZhbURoM2ZHSTMwM0F3?=
 =?utf-8?B?NWFUUytaN25xaDVtZlRGc0trbkI3RFVuK1dUVmJTUTFhb3VLelZoa2JBTjJy?=
 =?utf-8?B?SktnOG1ZQkdqeDZoYlNDMGRFRk5IL3FJdzIycEIzWGU3VFZVdnp3dG9tbi9j?=
 =?utf-8?B?R0crQ0dJYlhpYzhwYS9mRTJLSUIrWmpOSkdwbFErdDhROXZIU0gzYjJSM244?=
 =?utf-8?Q?ylAt+0CWu3SRMCr2mFp/bhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB34C6FCFC49F047A39BE550DF5D7901@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314cb890-7ffd-4e05-6c59-08dc919cfed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 02:51:05.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYbKIXQYyqUTLG1ySUU3WXuM+rHr2/jGZSqwh6KpbB7IkfVs5pA6LMzuHsMb/Rqe7nYmp/CXFf/D8Dnp4dcAXiEAqh0LNQv56lVegCeR1Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com

K1lhbg0KDQpPbiBXZWQsIDIwMjQtMDYtMDUgYXQgMTQ6NDQgLTA3MDAsIFJpY2sgRWRnZWNvbWJl
IHdyb3RlOg0KPiA+IEkgd2lsbCB0YWtlIGEgbG9vayBhdCByZWJhc2luZyB0aGUgc2VsZnRlc3Rz
IG9uIHRvcCBvZiB0aGUgSW50ZWwNCj4gPiBkZXZlbG9wbWVudCBicmFuY2ggYW5kIEkgY2FuIHBv
c3QgaXQgb24gb3VyIGdpdGh1YiBicmFuY2guIFdlIGNhbiB0YWxrDQo+ID4gYWJvdXQgY28tZGV2
ZWxvcG1lbnQgb2ZmbGluZS4gV2UgYWxyZWFkeSBoYXZlIHNvbWUgY29kZSB0aGF0IHdhcw0KPiA+
IHN1Z2dlc3RlZCBieSBJc2FrdSBhcyBwYXJ0IG9mIG91ciB0ZXN0cy4NCj4gDQo+IFRoYXQgd291
bGQgYmUgZ3JlYXQsIHRoYW5rcy4NCg0KSGksDQoNCkFueSB1cGRhdGUgb24gdGhpcyByZWJhc2U/
DQoNClRoYW5rcywNCg0KUmljaw0K

