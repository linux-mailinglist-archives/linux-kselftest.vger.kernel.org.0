Return-Path: <linux-kselftest+bounces-42904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E7BC6DD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 01:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3086D189CB2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 23:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E812C08D5;
	Wed,  8 Oct 2025 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dovk8p7U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080C1096F;
	Wed,  8 Oct 2025 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966294; cv=fail; b=elloltsfcY8zc8SJKyFdBdWBDmlzHR5qaZniBX/ZFp6vzu1MJKr5dvUENvEEZeFj409rc7WhZb9kT5JKH2FGKwzneQBgDeszhevQGo+sXdYTpvZZFnOXCERbA9ItAJj+9nKMtmULw4ifAnMA2pdTZbaBkZRdbGYJ1mcLJ2sVsLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966294; c=relaxed/simple;
	bh=X1eWBC7COmxcN7FM8FJ96U5ZoOI71K8quy1Gs8crvho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RPmd9rUvEiwGwb/OPexBEOdcF3mUsLjyvtWJZr/53TAZbKfCoZjUPgljaf2bEEga+fwECuFt2VAizuXHGmvesej2Hl3cQcGiwwm5ST5qyJjTgrC55+ZImcq9aGclCp1aw3YIcBeetwY+s4KTH2q9RHEIf4oZO9KW3jr/D/Fe6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dovk8p7U; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966293; x=1791502293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=X1eWBC7COmxcN7FM8FJ96U5ZoOI71K8quy1Gs8crvho=;
  b=Dovk8p7UKARwcE84+evzcQTEyd79SrDRB6Fn0zMNkochMXyPl/1FBGqT
   BPERjxQqSKwLE7M7MjintfUIIHbslz0SyUYBvHy//jsKXpisESxl2ovdv
   2uzg+zQfomJ+g9imJZJPfq11g8tZk1bSvybGHayokOklvBJ5iSUjC2eqv
   qeUvVaYa/k2PL6OLXyi6EKbscoSMEerpsZ/c1oK+4zPBy5JaYWPKTs7Gh
   r1R0cVurXRpnEyrtoQpIVI+m6JpSFJwCzBytPQUK/23UeCz4RRMynQSoj
   rFVmTeEnPEtTS/jYujWshbJxIL1tRbkNLKlowYNSzwGOPH2suo89CgCok
   w==;
X-CSE-ConnectionGUID: VGCRB0sPRumEzi6M7fR6eg==
X-CSE-MsgGUID: 8tsJAN2/THyfo9LyPIylUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62201911"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="62201911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:31:32 -0700
X-CSE-ConnectionGUID: Wwxc4lYZSJinMVVeGJcAGA==
X-CSE-MsgGUID: Fl/7mBOgT7+eSPpnLGX/PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="185687833"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:31:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:31:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:31:31 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWVIkBtpxaku9i/F4I1emr8wHH5TXxGek6dsQnS8iCl5NH7+95/OnubtHCcADVP/S/z59IkltUsE2SAOEGBwflFDfCGS+vwF+c4VqMp6ZcpoB5hqE3/pfj4ZAL1XockUzoUuZnLR52bJZcYGJxj9SEG6Bx0l/Gmgm1dUosfhFxHzSVeHSaHm2UBCTgLeAqqsE9/7jsiidJodGKrf7E00kS8JXszMARaRsr8acsYFSG4e5ENiryRUf/HA16Pf+TxiZ5KYLPAaML9enRDGIpjLEizez+vukuI7rrgKX4H68pakHVCJNMvkTItC6PzX2gP/FtPKaoi4UJtOsfWwwjQN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1eWBC7COmxcN7FM8FJ96U5ZoOI71K8quy1Gs8crvho=;
 b=QH7+qcUw55bYyyLWLZcyb8Dd7Tj0DJ7dOS0T7JY0U3g0gdD0x/0tPzHLCz0TKGJkK2bHOGKTODwyp4u6D0wyUfp7buTxPDINah5pzol+skt4VAbaHGwf0/496FqaTKGdG79yFnxg3dc6YRZ6LAlnzZLeaRsAMvLyegdgo6k8WaKWXejisn4Uw9A16A2enFoi40Pr4Z85i5vrwi1/r2+r42iHShtcHt+gfwtXA7dCxxV+B+Te7Ze6BFFAw0zvuw+kS4JcL1pR1RUfS4UKtYiTnLdDlyS4vJgi77/02V9vKu407wLAKVAWJvQ+QJqSB2uPj/NkQ+6YutpP2Pt74YDNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 23:31:23 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:31:23 +0000
Message-ID: <dcb0bfe2-0ff8-4d97-9e15-e04e3e3cc62f@intel.com>
Date: Wed, 8 Oct 2025 16:31:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/9] selftests: drv-net: xdp: rename netnl to ethnl
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<shuah@kernel.org>, <sdf@fomichev.me>, <linux-kselftest@vger.kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-5-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251007232653.2099376-5-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------hjpELpeLIEdOw1tIcyhRiN2y"
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: bade922e-bb3f-4b3a-1929-08de06c2cb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG8xOTY1UEZpcXd0VmUrT1cvbGs0cW83eS9hdE1SODBtWGtKdUoyY2JYeWhM?=
 =?utf-8?B?UWhpZGxXWk9zbDJzcm1ZUlpxSmM4VnBEdzVPZ2RUSDBSaThzakpFdUdHMWhH?=
 =?utf-8?B?Ni9OY3VNaUFPYW9XVGhHNUl3Y3VqY2VkYkV1QVdwN0w4Skthc1lZVnZFVUJk?=
 =?utf-8?B?eU5TUzRHL2pxQ1VwQUdPSUU4aGVmZFU3SnU0S3liM2EwRmcyZVV2aXZxMmhp?=
 =?utf-8?B?RkREWC93YkV0QlRTa0ZyOVpveVROcmNBSXR2TVJHVnFGbXpJUFk3K2hMMVRi?=
 =?utf-8?B?aXFIaTNNYURWd09ER0FwOVAwMGhhaDlieTc1L3pjdS9pNHhKRjMrYTQ4bS9S?=
 =?utf-8?B?bDU4ZDFhTEE2d09ab1NTTlpNdmFpQUN1My9jUjZvb0U0ZHV4R0ZOVVNVejZl?=
 =?utf-8?B?bjJOZ2MvZEhnMWkrZU0yL3lnNytWZVNuV1p5S09RaGhtandJK2hzbXhyVkxv?=
 =?utf-8?B?eHNhSmN6cVZRVzVKZGI4Y0xCaWx4Rm9JT3NkamxaeXlkV2JIMXRWZ1BrN2J4?=
 =?utf-8?B?UTBhamlQTE4wMG4vTEVoZ2lGN0JnOGZtTW53NW9OM0hHd0ZzOStuWjVQOFdZ?=
 =?utf-8?B?czFDR1VncFFYWURUai84a3ZaYWkzd2JhRDVFRXQxMnNyVWZ3ek9TaFM0VGdt?=
 =?utf-8?B?U1BXNzlpOHlZY2xCMzczZTJndkJ0Vm02dlJlOWhHTmNtNXIvc1hCM3BGL0FF?=
 =?utf-8?B?cHNqaWY1b3hGS3FmQmREZnZHblJ0Yy82dmZVQThBdG5BdUsxZ2tKZnd6TlU5?=
 =?utf-8?B?WmVXL1Rxa2x3MFFsZnY1WDU4aUJPN0wrVmJhbUpBUzB2cFZPWHBIUUJxTTFm?=
 =?utf-8?B?bjBNclMvM2hvY3VoeG9SL09nUkl3S3R1SzA2c0RSNXBMc0NTcmx2RUtWSEc3?=
 =?utf-8?B?dUVQNFFNUHQraTFoaDdIL0hCTVk1d2dZb3RyT2NBbDVudjY0bC9iWFZSNjJ4?=
 =?utf-8?B?bk5BdG5rekkwMC94K3kwYjlDVmQvUDk1QWdrNmdmYjV2YThQTmNrcWNwSm1O?=
 =?utf-8?B?Q1RPOUwxVmxtRklJSHFkYW9UZGdGdVo5Tk9MNzZJTDlTdk96a1FzTUtJMktM?=
 =?utf-8?B?YzVEU1VJRWo1UVRua0hyRW54T0hkUS9MY2ZpM1JONmsxTEtibnFBaFlhN2tN?=
 =?utf-8?B?TEdOaEhEVlQ1Q1ZjaXBOSEZkMW5HdXk1aTJrYjZ2Q3c5clZjWC92U0luVzRp?=
 =?utf-8?B?WU02WnBLODJpYi9IME5xSkQ0bDZ4Y3BTeWQvVy9CdXV6N1gySzJ0M0pjaFhq?=
 =?utf-8?B?c05lSmtRLzVCN1FkL2hGUnY3Rm4zTTdWZzdpUzF1aFpEVHN1cktxM2VpSncw?=
 =?utf-8?B?aTU1cVkrWjJxSHNKZVlaczlzWFNSdGVUWE1OTjN1ZmFKUFhMMmcrVVl4d2JO?=
 =?utf-8?B?ZXArQkZiV0dTRmE2K2R5V0RuNXhLcUhuRjNHakNFbER3MDdlTEN4UXhOeEtH?=
 =?utf-8?B?M2JpdmtpQVgzRCs1TkJ3ZWZxTVlUREFxbHN6MmRzL0xZRllaeUVqM2dyUDJL?=
 =?utf-8?B?Q0VsMVU3SG1mcmdyRGpZS29Kd2U2THNYVnEvUytCUFlGVFkvMWxlUGV4WFNY?=
 =?utf-8?B?aVpINGVreTljWGc5WnJyRHB5M3FuRlVJSEVtSXlzOVFiRE8vWmx1eXh3UVA2?=
 =?utf-8?B?aUk5ZDZnSUFma2RlaisvUzM4bkhxZDcyT2gzSEdiVVgzcldZdEZXbkt4ajZm?=
 =?utf-8?B?NnhQY3dIR1lGYTNVblFVbWVpQXQzaUJoR3ZnaVJwaGp4UXh0NHNTajVNOW5S?=
 =?utf-8?B?WlZLbUo4NUx4dGdlR08rdk5wbTRwMW5RNU9nRDczRXZYeXIrU0lJTUo1RUZh?=
 =?utf-8?B?Nmc4cVI1WGYyaTZ4cGtoUkloeVNETGtIcU9hc2RVS1ZUMXJMMkRWOVQ0Nnc4?=
 =?utf-8?B?alJqcDEydzZhZUtIMVhNOWk2a0pqRmRyQ1FqcUxXcW0vNUNTbGh2a1lLbEls?=
 =?utf-8?Q?470w1E5oZvozO461SJYFcHeWY7hCvjMY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FJRjU3dkdzTnEzbW9KNXp3SmxWZWlqRVllalk1ZmxpRk0zN2JmOUNSSmU1?=
 =?utf-8?B?QUxGcld4ZDNObXkzbGhybm44Y3BMeHUxbGFidWJvaVJEeGFXWG9EanMyZlpx?=
 =?utf-8?B?eUlsMmYxbzF3Tm9DZldTZHhVK0dPbWpMY1pRVkgwaFUwVUp4L0x0UjdtV1hT?=
 =?utf-8?B?RUxiYW5MNktzQjAzZkFrSTN6dUNLVE8rS0tOa1ZUNWNCdWRVekVLUWY0c3Z1?=
 =?utf-8?B?aXV1bWV4NndLYWlPZStSOEhHa3Y1RGJpa21ieWRJZzV6RkZoWjhIQUMyRmZT?=
 =?utf-8?B?bWtwZmU0QU5FcU5iWGtzQU8zRDV5ejBHM0hoRVpMK1M1QXhobU00SDQwL2hB?=
 =?utf-8?B?YldJb052M0F0TnNROEQ0UGlXcG1TdGI4WmdyQXZGUnd6NjlycFFKdjdYUjBY?=
 =?utf-8?B?R3QwMnhFZ2FWTUp6L0Jlai95QkN5cGM2dWF3VDV0eVdDTWcxeFdFNkp0QXkz?=
 =?utf-8?B?UDdwQmNHanc0QWtyQ0kyd1dlYzJDMlF2c3VHd0p6UWhCZmVGWjZiUmRKcmN5?=
 =?utf-8?B?Ri8za3RiRDlrQm12bzBIa3dxOFpyelExUkdsclFzcnNhNzhkelZNN0Y5UG5G?=
 =?utf-8?B?cjU0Ky85b3BCbURLdXVicG5QaG83T1pLck8zb0h6VjJyM2hZOCtVejRiUity?=
 =?utf-8?B?TktoSEJQZExOaGtxMnBvMEZZL0FLSzNnaDNLTUwya01DWE9JOEdjbXZsMHRk?=
 =?utf-8?B?dHN1c3U1YWlWbjU5K01wQU1GbnZrRFlCVHI5TERCM1F4ek1PMFRnSzRNQnhF?=
 =?utf-8?B?UnAreHBNS25oRDZ5OFpZQ3JFV0FzUkxHMGR1WlA2TTBLVlI5RjBhWEp4cHRs?=
 =?utf-8?B?aEN3byt4TXdNZzJtOFFtUXFmS2xWNDVDcW5sRFgrUW1waHBUTTZxRlovUTFR?=
 =?utf-8?B?WGMvRUl1S0ZXUTVoN1FvaTZDVk1CRzc1OHNBSEtRRHBHRzNHMmkxb0c5ekw4?=
 =?utf-8?B?NWJLZkdxTTJScmpVSlBvanhzWjBOc3V4d2lpMlpOS1RkeXlaYWZGYTlLMlht?=
 =?utf-8?B?MUJZZEpVY1BHYks4dDlDUi95bUtlWXdpT0lmRjdPUm9NaGlBMkxPb2h3UDRW?=
 =?utf-8?B?dy9hc1A5SGxhQ3R2cVpZU0pIeC9OSXNtbzZBVVg5OHZ5WmxHc2lqdnZ2cjl3?=
 =?utf-8?B?bi9pa1gwQ3BEcERTeGc4U0dDZlo1OVZraE1GMk50V1pMalBjQzA1QTJwdjlN?=
 =?utf-8?B?UjhBZVBhSUVEMStua1ZHa1BzRDhEdVJFaXo3blFDSVNBM1RwaHBJQS9IT0lr?=
 =?utf-8?B?a3pFVU43R0dtYzd3eGtmYklJRE1CVFVjYkVZU2VPWnozWWdINU5OSlhWclVN?=
 =?utf-8?B?bEtKLy9hL2haYUNtR01BY2RyYXVJdDFKVHZFUThwNEMycCtRMitUUjVSYkll?=
 =?utf-8?B?NDBuSHNac1IxdFF2T05UN1NCaGZmMS8zRmg5aXQ3aFI5bUxQUHVGV2kraXgv?=
 =?utf-8?B?WUV3eGR1NDdaWlNsckpDaDgxVUQzb09hSXFGTzViVGpnU1JQbmFIdy80WGw2?=
 =?utf-8?B?bXpNek45cW1DVitJOUtlSUh5a3I2cDhHUDhOWm9vTnBKbE9LajgvSWppZ0RP?=
 =?utf-8?B?YXR1VnEzYjQvSDR3TmZnblIyWnVkRk1wTXRJNm9MZUd5RU1tZHp3YUp2MXcy?=
 =?utf-8?B?Z253MVRCRDQ3WHZydlV1T21hdTRnSFNBblN5NFhDejRmMTM4VWFxdFN5eUNV?=
 =?utf-8?B?Z2taQjhSRWxpMU9tZjRyRlhyRGVnNEgzTm9XOVRycTVVS3FQc3pSb3UxRGk0?=
 =?utf-8?B?RXV4dW9tcUo0MlJubmlYK1JqNEdwOGZMekN0SDFKUjhXVWI3WUhjZmxBbzg3?=
 =?utf-8?B?cWRuWGZ5clh0RjZYcGdveHN0L1dFbW1zL0Nqb2pxU2ZLZ3ZMQU9adDAwSEFy?=
 =?utf-8?B?SDJUQnlFWUgyaThNdksza01xd0RCOS9VejNRQ3NudThZZCtnM2tud1Y2N0M3?=
 =?utf-8?B?NHlLZTYvQWJLT3JXd21YajdOTTdJcUhKWTBaekorVXcvSUlyZjlJeE9PcFRl?=
 =?utf-8?B?RUVDSmM5dCsyUkhVNE5zWW5WMmxaWm5iZWkwT2g2blVtMTdZSlAzL0Z6Sy9H?=
 =?utf-8?B?T0RhWk9sTzQvUGtrSDFqSmtmL0dRelVFaVBNdWdiWUlWdHBxOU5xQ3I3OW4v?=
 =?utf-8?B?MUE3ZUJlUE90dlArYVRpMEhKMzdCaWR6Tzc2NmJwVGx1MW5FbUZuT0tqWTE2?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bade922e-bb3f-4b3a-1929-08de06c2cb39
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:31:23.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CW24gGWy4iw6gOOpWNPZippn894A8A5scP94G6pcdKK1JlKBWMV16nGzfJ5DQl1S8FDEXW2l8kXeh8ScXWTwz0nLS3InbK8ap1mJz/LEK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

--------------hjpELpeLIEdOw1tIcyhRiN2y
Content-Type: multipart/mixed; boundary="------------QW7S9Drl8iJ8Efz24B8iBnf2";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Message-ID: <dcb0bfe2-0ff8-4d97-9e15-e04e3e3cc62f@intel.com>
Subject: Re: [PATCH net v2 4/9] selftests: drv-net: xdp: rename netnl to ethnl
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-5-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-5-kuba@kernel.org>

--------------QW7S9Drl8iJ8Efz24B8iBnf2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> Test uses "netnl" for the ethtool family which is quite confusing
> (one would expect netdev family would use this name).
>=20
> No functional changes.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> CC: bpf@vger.kernel.org
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------QW7S9Drl8iJ8Efz24B8iBnf2--

--------------hjpELpeLIEdOw1tIcyhRiN2y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOb0SQUDAAAAAAAKCRBqll0+bw8o6N5Y
AP402E8zDfWkKJwJ0+/OFibbS1ERROIK2MfPa73pVK15wgEA16yR8DyP79vq9s5meviJxxKZn2jo
fwCiSF09GfgXLAc=
=vvtQ
-----END PGP SIGNATURE-----

--------------hjpELpeLIEdOw1tIcyhRiN2y--

