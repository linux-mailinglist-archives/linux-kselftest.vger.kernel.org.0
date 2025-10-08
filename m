Return-Path: <linux-kselftest+bounces-42906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87438BC6ED0
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 01:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D559434C103
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 23:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB12D0602;
	Wed,  8 Oct 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffxSjPsF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19642C3770;
	Wed,  8 Oct 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966491; cv=fail; b=Y2VQfJy7y/gPshqU3HWS4yAeDGvxLOhg20u07I31b7Ot3pwiO72RMoq6XxFGEoTABVUZ1Cleg3Bc1WGysZKmK6HRpQgAzS+u/Q21KQhlB0hDUaJHtFBz+J9emosB5EMUcHC3mpvQjSSmaRI31CgkGg1hqb+32k0ut0z1nDNQSQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966491; c=relaxed/simple;
	bh=zc7CHKdIQ6f33uz3sQXfaitcOfZRFexD5ILtwZBrZyc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HasREb3SGXx2+lfiReFDtzEieOsb8Uc7ehz1AAW2xFBWqJ9uQbvxdr07G7FOC5borO9JEZ3KJ+h0m/OP02i548xVtAm5rjX/4DRaCRjMIPcjmmJToPsPGt8zWp8dVRrBdKu+Vz6i5SSbdcbAE4PveaJBdaNj3nrf3SskPJYe+GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffxSjPsF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966490; x=1791502490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=zc7CHKdIQ6f33uz3sQXfaitcOfZRFexD5ILtwZBrZyc=;
  b=ffxSjPsF9q49eC2GMSkK5bFpvUdw0/D4GmIb6hjPJNZ+6opQOPCs348M
   RIuYzY+pZjLRUDe+cmA+ccWUXZiutPXR8xv1b9OZ7kbbQXH5ckkhuyypM
   mAOucJKjUMFMBQ4dN9Md85P8ZW8rCr4pUw9p6GMMKzQ3eLQAcMNJCV8Bq
   1hZGKekj0lRlfAI5YcG0ZF56hnt6je22rlHKsHINr39swAgnH6loOTZgO
   BqPnf6WR3fnywp3wEjUp5Hxg/FaNzKGNJUtkfWKqv2TC+zj3dMQHn7leB
   S4bkQY473vCHycZuzr+48I5W36Ji7stBaaYLMJ8XgA9XsJoBffqfhYmMD
   Q==;
X-CSE-ConnectionGUID: TlWU0AO/SRSyoJNVCSLdCA==
X-CSE-MsgGUID: lsXWmiVESsmNJFHerbIcXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="79612082"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="79612082"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:34:49 -0700
X-CSE-ConnectionGUID: DGXJ1QheSImGnkit6d8Vww==
X-CSE-MsgGUID: 0od33EtrQcapKNsdPTobYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="204279021"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:34:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:34:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:34:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7gdY7rTzE/EmZ/XhmVZezIMgc3183waMAmrBh9FWNWEXXzWB992rnpjusUm8Ke/9nLLS0+pt+Fv7GkH0qMth4zPOtztob6sPLTFcNQZiQ0vxzGwdlO6o6Aw1H5wHqCUj+5YuGpJ4DxO/pL2mXJfuwJs1xu3OIhT8U7xYfI6E5tEIWNROSWlA7HAXo/Hh8YvWNw0DFqwjvcDdNKVErmi6D9dU2/iVT8WPYVFfPzs9s5ub9tD/+/JDgGJVyhXWilK7xVzXno4BvdY85D26ypjSCZagcXbCQFwSR2J3ZVb5YqULVGfXMxO1MGEeM7YsV/fmlBafQ7/lsoklVmLsGiAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v12KS0VeDgKG3kBodMHfG0ErB09HafVgXZgrMeMk0EI=;
 b=YYa9DstYqilHHrO+ddH5M5kVHdTLoOIdCQFk6lzTm2wM5SGQEYR64bxAzZ+Ph2zjp4Hw16xU7uP3ruysWPuuB8YhtNZa/zN32Rld39rCAoMFdptb2JldpTYdplpco85Xef7iO8W3xes1MNahHDQ10MXQH1ABaR4CxLQkP2m37PLAH3V1r+ozRdfXcfxA5faxi/lbfnfq3+l4x7Nvu1RLoPOjggk18a1Jdt2iXbDEh0Bd6uOpYbds6i+iBtWuDbjRi6OUB0o1GRl69swh3K5I6XOcVJJADm6cH62rria7hrlccHF0a95OFlvZ+SvC6UoSO5r3BEkANyahtw8dxAjVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 23:34:42 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:34:42 +0000
Message-ID: <b00dc64b-d760-4c27-891a-465cd3c25d9e@intel.com>
Date: Wed, 8 Oct 2025 16:34:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 7/9] selftests: drv-net: fix linter warnings in
 pp_alloc_fail
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<shuah@kernel.org>, <johndale@cisco.com>, <linux-kselftest@vger.kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-8-kuba@kernel.org>
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
In-Reply-To: <20251007232653.2099376-8-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0BXIiA9g25cCLmltZ5QR3mSq"
X-ClientProxiedBy: MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::13) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e6d07e-7f36-4261-468d-08de06c34170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlorK0FIS0ZadFU0aVlTVk5zL1daVHk5RVdoQmRMdkh5dU12dzg2a2RZR2xu?=
 =?utf-8?B?OWVYNk9LSmR3L1l4d1FFY05oeGFITzBlREdxWC9HNkFGUEQ3UERiMTUzc25K?=
 =?utf-8?B?R1dnRmRvNzhkcFo0U013VUp6OUJ0Z1ptL3hYaGM2Z0E2dWlVZGhDakNNakFm?=
 =?utf-8?B?RmRmaGtCNS9lTlF1UWx1emhIUTVGc2FoV2xUTlhLYjFTNENKdmpNaGJ5UU5W?=
 =?utf-8?B?bWVRbTBwaXNxQXIrM2RNU0hIZi9iZmxYZHUzcHkwOEUyWU91MkRIajdKNytF?=
 =?utf-8?B?MTVIQlVuRm9vN3cvZFQwOHl1b3EreURLNmVBaEt1VFBMbERPTmFDZU5xQ0x6?=
 =?utf-8?B?V29XYVAyTlkvUGpoaUJsdzllelV2MGxuaGV2T1htWjUyai9Bb0ZHOHBnZXBQ?=
 =?utf-8?B?ZVA1TXI0ZFJSSm93Yk4yRCs1aysyWjloMnltamMzNzA5MGVQSElOWklFb3Zy?=
 =?utf-8?B?Y1RjdWtmazQzaXkxN2cwTC95ZVl6K2RQVXhOeTRHOEpSUmRkTnlPNzVPdjY4?=
 =?utf-8?B?TnFxUzgrUWlRM3lPd2NBQ1dUN2lFSzZxNlZFWjBBbUw0VWpzOXNYQW83VENF?=
 =?utf-8?B?YUYvaW9xb0hJZmN0VW5Ka2JiRnRnc2ZpVjl3dy9QMkNPZVhkVjRSaU15Y2dq?=
 =?utf-8?B?ME9UNXArVVdzblFHUTQ4YlhjVVh0d005VzgzUmQwWTJHS211aTlnWVMvOVZK?=
 =?utf-8?B?L0FFTEREaVAzeWNpOUp4WTVvbG9zMXFBVnJJV1RCTzZSRFBnQllKY20vc2Jv?=
 =?utf-8?B?SStpeUhPck9rdnU5R1VUbkpSSWx0MjBOYmJqYmRmUmxLNXVwSlU4QUd5UjlH?=
 =?utf-8?B?b1lGY3lYa0F1b0tUQ3c3UnJSRE01bjZRS3FDMGIweUFvRkhFK3R4ZGhjVFZj?=
 =?utf-8?B?c291K2xpSnRVUkZ5YlpaSlFnR0VDVzBxMVB4ZXRlSUV0RW9US3dWTUttMmd0?=
 =?utf-8?B?cFhab1pYL2ZzLzNGL3FnUUlJVEUxVmFQbXdzenlEZWFnNEJZdlQyUmF6akwx?=
 =?utf-8?B?U3VUK1daeUdFNDJPa2FybFM3N2hvQTFGaFR4RG1uYVBqSnN6TkZXMVJqaVFq?=
 =?utf-8?B?SkJHeTFzNjhrMlJxRjk4WDFUYWtTSXErS2tvRXErZHQ4aGdYeDJzT28wYUVK?=
 =?utf-8?B?Mm5oOURwbDNGL1lwL0xlaURGR2VqeTFMNzdTK3V4SkF2dVFSL213bXZMSldR?=
 =?utf-8?B?VnlDK0pOTnFzV1l0M0t1bnkwR1hPZlZwd3pRMmxON3Z5Z00vS3VaS2N5UEg5?=
 =?utf-8?B?cXhZb1ZYa0NKUWZnbEsxdWcrdkVsSGlFNVI0dkxuR2t2b25vK1lpUlc4blIx?=
 =?utf-8?B?c0Jta0tLNkFoQ3YzVGNEV2xKMlBucmlmbkI1KzhzQXBxY1NyK3M3SVVRU3Iw?=
 =?utf-8?B?L2tOY1ZiNnBSMnlEZ0ZQRmI3ZVJtU2V5dnZYaDVNTS9yU2lLK3c4aS9hSzd5?=
 =?utf-8?B?MmVSbENWWnRFakFMOEloTldXTzc0emhlYW5nMk1CK2VMS2xqR1h1VGdiNEJm?=
 =?utf-8?B?L0w3TGd6dHNHMFE2ODdpT0VNMFBIZkxCVzlYZUwvUEhnbCttRVNCbzBEWnNz?=
 =?utf-8?B?a2VPdyt2TkhMemFUemtHS0c2cjZjaG0zTGcxd1ZXbzBYZldia081eGNSYTdq?=
 =?utf-8?B?OWp2K0x2cjJ4ZjdTV2F5bXBZUXUzcEpaQ1NMYml1WU9CZWo2ZUQxQUNEak5v?=
 =?utf-8?B?S2l3cVhGOTRleHovVk9BbFhOVUU3ZW5TY0oxQnlCc3E5NzdzejNTc1NTSTJx?=
 =?utf-8?B?bkZtNnUzdytQYkV2UE4wUGo0Qy83RmoydTh0eWhCSUJUTHFoejFXNkxUdWF3?=
 =?utf-8?B?SjhyTEZEaDdBQjRVOUlOeUsxUWIxSnpXOUhhS2dDckpzNDJBN3BzZGNka09o?=
 =?utf-8?B?QUhYcDdnZS9rRjM5U3h6ZFJEclliTU1lNFRaZlhvaFN2Tm8zcVVqODl0MHFk?=
 =?utf-8?Q?9rv3cX67sH590ApNI5mUT8eiJVKZy2UK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUgzeWR1VFlvbU8vMSt5OWlFOEZyeSsyQ0NpZkZMdWVRc1NHL0YvK3l0cGF0?=
 =?utf-8?B?OHFUQW1OR0dLeEE5WkFsemZaaWdEVnVKeTNnLzRTenJYNGxRdjJJWi9RWTRq?=
 =?utf-8?B?WkN1Um1PNzYvZTQ5MU5QL2xyV1pZQVRtUVFRT1A2RlRLci9ZeUdtV0RFZldv?=
 =?utf-8?B?VTl5WG1SbWNjTkwyY0FoMjdjZ1NvU0pkZ2lRMENCTkpWZFJOczl2ZWRaRGFC?=
 =?utf-8?B?dGtPL3NXVkZtR2JqS0ZFNUtjak5Nbm9QMnQycUxkR2Q5cHFtRUVuYy9QY3Vy?=
 =?utf-8?B?ZXhCajgwUWxnMG8raXFMRWtJQloraE1WUEM5a010djhFbjJsa09vZWJLQXNJ?=
 =?utf-8?B?K1ZsVWh1b0lEOExRbkg2SUtqL0tBTGF1aE9ZWFZNT1FxUmd2VTNZclR5NUNh?=
 =?utf-8?B?WHFHa1EwMnhQeDdINzJ5YTdaV09CengwUVgwT1BvT0RuSmJuZ0xEMEdKZlNC?=
 =?utf-8?B?em5Jak1leCtwUmU1ektIU1hwYUJzT3RINTUwUDRTeGtNeTV0elZaS3VlU3pY?=
 =?utf-8?B?T1hSc3pJWDVXTmw3NTE2VXhDSXJsRGlUeHh3V2FXdEVxQ2FicVU3UDNneG5h?=
 =?utf-8?B?cXdzMzRlM0dmeFJ2VVZKbnkrbjh6R1hwNzYwaTh4SmZsUk53bHlZWFhqM3hS?=
 =?utf-8?B?TnUrQThhZmtoMmdkM2ZZZzBCM1pYTWdXNnlDUEw5SE9UTGR2bVk5UE9IdEp3?=
 =?utf-8?B?U2hwK3FqMGdmcHN6WFdYVkgzam05WVhSSWVxRVZURitZczRqakVaZVJtUHJj?=
 =?utf-8?B?cTk1dkNMSCtzaHJzV2xCZ2t2UUNRUUV3WWdLNHhoY283KzlqVVJxZGxIbVFo?=
 =?utf-8?B?K01BSGtzYTlZa25PRHVnSEZTOCtGUGNRdGVhcHN4MmZ6L0FJVnZSdmJPRnhC?=
 =?utf-8?B?NktGUFJxS0R4ZFdTZnRmVzMwcWtscmZSYUliTDQwRU5pYjFzWlg3enNxTWNB?=
 =?utf-8?B?K3BnV3FNcVFpTzVwY09VL1U5di9Fd0JTSWpLSGJhcWJjZG9FamZtVmlJVHdF?=
 =?utf-8?B?cmVBVVBpUUxtanRncGhSck5kdGRsRUJaSGs4VTFkNVV1eG11MXhDM3BFNlNo?=
 =?utf-8?B?OG4vRTlxenhTWklIS0lLLzFvd1R6NENDTm0yNVJTbWRaREZzeVJuRmxLYnh2?=
 =?utf-8?B?WDZOaXdET0h0Q2tPR090SnNzV1hBYndIdEZqTHdFSmlCenpjcHNwR3pUcnI1?=
 =?utf-8?B?ajFsaHRDWXY3dEdUVnFXN0NQT0Exc1hORzdkbTl0bm1qTjduYVNaTEtZS3E4?=
 =?utf-8?B?ZEpEOHdSa09rR09QQUhMY2pvSzNteVpFWGk2MnltYmtwOFFiR2dhb2FKTkhB?=
 =?utf-8?B?eFNJcHE2OWJmZC83TncrTHVIT2o0bDM0SDFrTEVWOTZtdGhJYm55RFlZNGU4?=
 =?utf-8?B?clR6UHN5djBOWXl5eUlxSS83WGNhVXBEZkJZbE5OSVNZZzVLVTVlZWUzMTZL?=
 =?utf-8?B?ZFVXMURnaHA1eUxjVXhEUy9iQWsyR3JVSVJmcHRDYVhwWEg2SGx5ZEcvRUZ4?=
 =?utf-8?B?dis4S2ExanpveHkycVlqR0tHeDNPdWQ0citzYjBaVnFXN2V1Tm9SbXozR0ky?=
 =?utf-8?B?Nm9NUDUxVmZoUHRCV2xyc1owSVZMRHg0dEdlRWkwQ2JpZFkzM3ptVHozTHVz?=
 =?utf-8?B?eVRoZTJiaFYwOW96RTJGTlRXZE1BZG15L1pmUllMNzd2MytZUHRjM1czLzI1?=
 =?utf-8?B?Uk40aHFQeWdUVE45V3A0WHZ1bTlVS1dHZkFKTGlnSUpmcWRhczV0RnYzcFg3?=
 =?utf-8?B?RE5ETnRmaVpBRmtHaThJdXB1cG9WMUJ0SjJIVGo0UmZBU2dZbkJFaDUrLzl0?=
 =?utf-8?B?LzRkUXI2Nzl1Smd0NzZ6UDgwc1RJbjVyUDdpWlNhanU2eXZlMjNwWVNURVF0?=
 =?utf-8?B?ZmI0WTQ5MmU0UUR3VTRsWHNGSVJDbUxkSmtsaCtMZHBYa05Gb3BBVG82Q2Ri?=
 =?utf-8?B?MmRkT1FJZ09ycWVTUW10Q1BiaEs0RjRLT2dPMmxKYkFXQlNxQnFsQUtjWFIz?=
 =?utf-8?B?Rk1DZ0dEMlRGUjAxR0VGeWVZNTdoYTJWU0hrcy9IL3lRNFE2dk9LaTJnMUNq?=
 =?utf-8?B?ZW01cVBVd2dFZ0ZJaERaN1RYejRwQVpxbDVqTzRDSnhWdFptY1ZZd2ZpdUFY?=
 =?utf-8?B?QmpyNE5oMENRd2hKWWFWdC9NazhjZVBDT3dyVDU2NFA3eXgyMmF1dGxTYTJO?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e6d07e-7f36-4261-468d-08de06c34170
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:34:42.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXWJpyaS1EYeNMld7OKqQDcB7juh9rdsXBYGXQTF10l8BeOYVOiymW09/lhKR9pKfFx8jZS2YsmMSJ+QOvQ257Ns0CA9Q3bzxfAG89TQb0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

--------------0BXIiA9g25cCLmltZ5QR3mSq
Content-Type: multipart/mixed; boundary="------------WIWl1ws2FRV9Bmkj4CbxkDyT";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 shuah@kernel.org, johndale@cisco.com, linux-kselftest@vger.kernel.org
Message-ID: <b00dc64b-d760-4c27-891a-465cd3c25d9e@intel.com>
Subject: Re: [PATCH net v2 7/9] selftests: drv-net: fix linter warnings in
 pp_alloc_fail
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-8-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-8-kuba@kernel.org>

--------------WIWl1ws2FRV9Bmkj4CbxkDyT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> Fix linter warnings, it's a bit hard to check for new ones otherwise.
>=20
>   W0311: Bad indentation. Found 16 spaces, expected 12 (bad-indentation=
)
>   C0114: Missing module docstring (missing-module-docstring)
>   W1514: Using open without explicitly specifying an encoding (unspecif=
ied-encoding)
>   C0116: Missing function or method docstring (missing-function-docstri=
ng)
>=20

Everything seems reasonable here.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: johndale@cisco.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/hw/pp_alloc_fail.py | 20 +++++++++++++------=

>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/=
tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
> index ad192fef3117..fc66b7a7b149 100755
> --- a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
> +++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
> @@ -1,6 +1,10 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +"""
> +Test driver resilience vs page pool allocation failures.
> +"""
> +
>  import errno
>  import time
>  import os
> @@ -13,7 +17,8 @@ from lib.py import cmd, tool, GenerateTraffic
> =20
>  def _write_fail_config(config):
>      for key, value in config.items():
> -        with open("/sys/kernel/debug/fail_function/" + key, "w") as fp=
:
> +        path =3D "/sys/kernel/debug/fail_function/"
> +        with open(path + key, "w", encoding=3D'ascii') as fp:
>              fp.write(str(value) + "\n")
> =20
> =20
> @@ -22,8 +27,7 @@ from lib.py import cmd, tool, GenerateTraffic
>          raise KsftSkipEx("Kernel built without function error injectio=
n (or DebugFS)")
> =20
>      if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_a=
lloc_netmems"):
> -        with open("/sys/kernel/debug/fail_function/inject", "w") as fp=
:
> -            fp.write("page_pool_alloc_netmems\n")
> +        _write_fail_config({"inject": "page_pool_alloc_netmems"})
> =20
>      _write_fail_config({
>          "verbose": 0,
> @@ -38,8 +42,7 @@ from lib.py import cmd, tool, GenerateTraffic
>          return
> =20
>      if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc=
_netmems"):
> -        with open("/sys/kernel/debug/fail_function/inject", "w") as fp=
:
> -            fp.write("\n")
> +        _write_fail_config({"inject": ""})
> =20
>      _write_fail_config({
>          "probability": 0,
> @@ -48,6 +51,10 @@ from lib.py import cmd, tool, GenerateTraffic
> =20
> =20
>  def test_pp_alloc(cfg, netdevnl):
> +    """
> +    Configure page pool allocation fail injection while traffic is run=
ning.
> +    """
> +
>      def get_stats():
>          return netdevnl.qstats_get({"ifindex": cfg.ifindex}, dump=3DTr=
ue)[0]
> =20
> @@ -105,7 +112,7 @@ from lib.py import cmd, tool, GenerateTraffic
>              else:
>                  ksft_pr("ethtool -G change retval: did not succeed", n=
ew_g)
>          else:
> -                ksft_pr("ethtool -G change retval: did not try")
> +            ksft_pr("ethtool -G change retval: did not try")
> =20
>          time.sleep(0.1)
>          check_traffic_flowing()
> @@ -119,6 +126,7 @@ from lib.py import cmd, tool, GenerateTraffic
> =20
> =20
>  def main() -> None:
> +    """ Ksft boiler plate main """
>      netdevnl =3D NetdevFamily()
>      with NetDrvEpEnv(__file__, nsim_test=3DFalse) as cfg:
> =20


--------------WIWl1ws2FRV9Bmkj4CbxkDyT--

--------------0BXIiA9g25cCLmltZ5QR3mSq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOb1DwUDAAAAAAAKCRBqll0+bw8o6BSf
AP9LSYGxRcXBzjDU0N4OaEX8j3H7CZaIU1BdO0N3Vj7ZSwD/dkLsO7zyofb2B/9wEQVD4u9QcDCt
8kBAv714dS4vTQc=
=kqFn
-----END PGP SIGNATURE-----

--------------0BXIiA9g25cCLmltZ5QR3mSq--

