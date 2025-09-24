Return-Path: <linux-kselftest+bounces-42174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6697B9916A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D8317400A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9A2D6E7F;
	Wed, 24 Sep 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXHikrCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E528B7D7;
	Wed, 24 Sep 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705838; cv=fail; b=UxqR1jltvPjYtUJg8ZKUoCxSKi0XtequXjpfkggC7ec98ZhffIpc1MHkiKZ4BdqCbz2BXaWY/3PjXbgD3qrf9uqHjsK2ckAOp1faLfVbZDTMWX1Hm2VLHPPZNoJaQDzZ6o39snNOs2wGGUCUdLtdOwJsjd7dlUnZakUN3THOZ+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705838; c=relaxed/simple;
	bh=SqrSM+QMYNk4eIStzNbsjup2rLfAPeZwZDDlQDh+s3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JKqjnqJuxsefVvnpXowUT/kpUY8xzUKhea1yQWUrNcsNPJAatFnkN79UVMX/wUu41Pc+rReAdk0jyFzBKwuYR+WStqP7KkQf3eSayJc3cmkS/papu/7oMYZS11Yap47f/gw80dxOx1Q6M0HGkXotTyms+V9ns+xeQpDm8wiwzvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXHikrCZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758705837; x=1790241837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SqrSM+QMYNk4eIStzNbsjup2rLfAPeZwZDDlQDh+s3o=;
  b=BXHikrCZGMYtHzde7JbMDL01tvrUwqz04DWAYKBWlqCQubvaa+6d4Eq6
   wSAsVjmIyIIrDDxe77PXuwLDapWcONw3TIirm+FGgJmjYhAy7tIMTsM4L
   3x8MTipVX+gfi/zjXX1WeRs2Z/KUoMc+MxiS/j5b6mbTc6HqUPw9vqt1m
   khA6m0w5JxKKv4jAtL/Lg+0/v2eJtH+OwuCbO4IIvKx+vwNm+M6zsWPQL
   U8qBJgffNL/31XX1pzYz9MLjzKm8kvGqjzwNt8IW5nimA1PXbB9RUok2I
   WRLQ7AKmZdqek1hgCT4noUcqKnD75Stxdfna8ZOdVCWyt2FjVb9RauGrn
   w==;
X-CSE-ConnectionGUID: KXwlOwv1QXul4nnRJRgxRQ==
X-CSE-MsgGUID: bnoMXZoKQaKEVAxnQrnKtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="78625678"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="78625678"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:23:56 -0700
X-CSE-ConnectionGUID: Gg08DMaHShCJ/qWiFLnWdQ==
X-CSE-MsgGUID: ojYRKtuKS/OqZdbxAlweHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176822012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:23:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 02:23:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 02:23:55 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 02:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLCPZ2D8FbBMjYlZ2azWqPKZqU7cRtrJGOIyZfNz0glVMdENVSfMsrnmcE38noGcX/Ai8OudQIrzGqqljraqEJ+xlCYiyuMNXkTagL3Uqm0JvGcM//Sg3lTKBVKZi+zXaS2eANjUo0leiPBrKh/bUyR6b9Mj85L6fAaXgXPMQt+7j5PvPfBJvX2X+MJquL0max4HLJKQoj2chz3OxxHLZBfplqzrl8XdMWi9gE2BlYWZwX6ZPkf7DUPA0ZqpTN1Nj+SV0NhDqR4Jsxtyt6wffvmTicq9VJQrdQ9HGs3ZU1wlP0UXcCGz/ugMZytdv6V6OmuAmR9RmTGUSnIUm4AXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqrSM+QMYNk4eIStzNbsjup2rLfAPeZwZDDlQDh+s3o=;
 b=kaj6b7AHwnFAVWFB83t4ep9KKxno0TFma8HdkTYxEdmQX2GhAnIJyUMFFzKeGsSN6tG+Z8g5sfANiDyrJAGyqj1kOtYDuWbVMEBF2PWK9G8pXF+8DNKhPTkG1o/LyGsJshihFx8eGTgnDDQDzZKAg6zDhDaO7u32fV0LooJjZuPnGJ9CghSBXowIKIfeejV79VF42240RL3xG8nOurkbOsU12kk04kuns6UiIllkb3s9FKMhqpVL7a1Sr0VNg7RnZ2PCjU0EMS8gCYHktQqVyEmS3tQeWgnF7FTnMbzx2bX5t7q+ACVGNfVEJBMYk/xCya9v+JbSLt45QmgIMGwz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7899.namprd11.prod.outlook.com (2603:10b6:930:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 09:23:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:23:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
Thread-Topic: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
Thread-Index: AQHcHPrPMyzf1al9LkeBGiVdXYVZSbSYmUxwgAJQtoCAB0V5MA==
Date: Wed, 24 Sep 2025 09:23:48 +0000
Message-ID: <BN9PR11MB5276EDC94B78F213234B611D8C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB52764CB85A0C6814797DE6728C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250919181949.GF2132010@nvidia.com>
In-Reply-To: <20250919181949.GF2132010@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7899:EE_
x-ms-office365-filtering-correlation-id: a746caa9-010b-4add-55f1-08ddfb4c117e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?a0hkemNqTlp5R3lxQllwL2JqTjRVSTJqVFIySlFkeHcxQ1dwR2ljbGFoeklG?=
 =?utf-8?B?bnNlUis1bXpDUllPSitGSExySUZLaDVVTjFRaDhwbnd0RFkyTEVvcUNhVFd3?=
 =?utf-8?B?SnZ3RG9nZ0lBWHdYaXZZU0RPRWhRYlkzN1M0SGJSSDc5N0QzZkQrai84TWl2?=
 =?utf-8?B?RUhpRGNPdjZJRWpsSzRCdzNGK3o3bTViNDhoVHg5eTJvS2Z6ZVV1YXdUNFh3?=
 =?utf-8?B?a0Qvd0FycWpFZ0lBOVgrdnE3Sy9uOWhwTkpNWWFFVzJCVmxYQk5XbkRocFNJ?=
 =?utf-8?B?U1pVN0JqZW54NUhJTHo0MW9qdWxGVVN1emhFc0ZlWmYyNzRvWGo1SUo1eUJY?=
 =?utf-8?B?Y0oxQVVvekZ0bGlYb21neUFUT1gyY2RLK2xOZVRtZllWeE5FKzQvaHhQb0xa?=
 =?utf-8?B?a1pJRGFYaGdObmJ0RFRmdlJLd1BwR0xYWVlKaVJHQVNuVzNuenk0cTU1anlj?=
 =?utf-8?B?anJndjBRZnY4RkJ1VG44cmRUQVUxcXNCeVJYVXNvY2ZORFVLNVhDU1NxZGM4?=
 =?utf-8?B?aEFTQjg0VXRxUjh3RitiYm00UlZ5MGtLSHlraEErNlE0aXYzbDJ5VW1oVnBt?=
 =?utf-8?B?WmVacWpKR1ZpN0txZ3V2ekJxZ2RJdVZnNUM2b2R1SlB3WlpzSkJkVFd1K2ZG?=
 =?utf-8?B?c0pQTENsTE0wUnNjYXVjSWVRNFlUdHRMNEs1Y0VwbUdPN1A1aWFOTFlxMTYz?=
 =?utf-8?B?K3hzaXZNRWxwekZIQ0tDcVo4clBTRTZRMUpCYncrVktqRmcrelpGc29uVHA2?=
 =?utf-8?B?bXJOOHdwMnRNMGlBeW14cXU4VHFCWUhaUXdVNUROYThJL2lYYzJvNnhLY3hK?=
 =?utf-8?B?TllyeHBNSC9YSjJaaTNwWkNtQlkvSVUxNDMxSGVmWU1kSzF1Y3R6cExneHpU?=
 =?utf-8?B?a2U3UWdGUU8vOUFLWGZKdlNKZ2lLcXR1bjZsR2p3eWQxME4vQmFGTU44Njk0?=
 =?utf-8?B?UWxJcWxjbFpXL29TVHgxQ2ppUmIyU3lLVjFJWHkwZDhQT1Jmb0hzNGcvVzgz?=
 =?utf-8?B?TlI3NHUwQTV5N01FUlNNRFJsYjFTQmtUL2hXcENMZEVhbGliYm41SWpKUkxD?=
 =?utf-8?B?NURQV2xaQ28xUzJxZDhZcEthejM4d3l2S3JXcHkxTkY5YTJ0TklYRU5rOXRH?=
 =?utf-8?B?M1hyQ21VeEx2WUJSeVQzQ1VnUyswZGQ0V2xHUTdPUllmZkZldjVrVkVKd1Yy?=
 =?utf-8?B?bitVbXViSGZ4L3RDYWRtNkpvQnFtcERnSWlCTEhsK3R1WmJmSVJXRW5OaEtI?=
 =?utf-8?B?REFxeGZvS2N5TVpoWXFoTmNrN0ZmR282WG1WRVM4djZqa09yNFZOVUVOS0VY?=
 =?utf-8?B?K3c0eWw0UGhNQ0xXQkdoUFBEQS9KRjY3ek8wdERZSXcwNjQ1R0RuaUFXeTRy?=
 =?utf-8?B?ZWtmRklTMVFtWElJKytrY2R5QWpKSVcrR1RLcXFiWWlDRmJZWitPQzIzMmZH?=
 =?utf-8?B?VUhNakRwa2sxZS9wY1UreXcwbitqTUZqMG1IN0F3cmZCWElob2tFNUZsTzZ4?=
 =?utf-8?B?Mk05S0RDMnJ6YUtRMjQwWjJiR2ZvTWR0cWViZFhUMGxnZGczWHFEWEZ6bGxy?=
 =?utf-8?B?amxGZGh0NzB0b0JSTWdOSXdjTUFwMDZTYjM0cDdvSjlOclN5eG9ySmRudThE?=
 =?utf-8?B?cEcxc1U3cFdUclVLWDhmakNKVXBpYXhCamQrckNWSFdub0lLUHloL1BaMHo3?=
 =?utf-8?B?R3hidEdKVjdMRitmSGhFMHd5U1VrNXdXS0FoQVl4ZWxOdUVTeFp0ejdtcTJU?=
 =?utf-8?B?ZmJsVmFJRVFCSDY0TmZUQlZsVWJqM2Rjbjg0TXFnSnAwNERyZS9sdXJNMGhr?=
 =?utf-8?B?WFYxem5MSmhTckRmUHdId3FRNy9vamlDQkM5Z3ZFNXdCL1U2b3ptNzl0UDhi?=
 =?utf-8?B?Wk43S1YyTFp1WnoxSDBvc1ZjTTVlUUJXRjM1OUgvOU5lMGYvU0xZN3hvUGNx?=
 =?utf-8?B?NWJDeUtDTnVRUWFnZHg5NE9iQ2lqdTVzRHg0M2VtTlJLSy9WeGJLQ0lKMVlx?=
 =?utf-8?Q?iFSk4+oi3sAMB7Dv4Y7MkwqGFJs+II=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmR1T2hDa0NWNUJ4Z1NjeVg3UUNkOXMxUTZTdzE4UTVHdU9tQUtPaG1rdGt1?=
 =?utf-8?B?aWU3OVZ3aDN5SFVMRUZ5Z1lLZ2ZVdEVRK3hWT1J4VDZuQW1YQkMyTlArYjhh?=
 =?utf-8?B?ZlVUVkxiNG8yeEpXSE1VOFRqQVNtYmR1eVlNODRHR2llMlk4K29oUzlHcjRQ?=
 =?utf-8?B?YitDdGNvcm5oYWp4NVY4WU9MeTV6OE4rSHZyWDdtSWxNMVhMdzhicks2ZWtM?=
 =?utf-8?B?SHNZNFR5SW94ZS9ZNDRTaEJ3NE80ZTBPcDE4VXIzV0VNUys2TEI0UGZ6SXgx?=
 =?utf-8?B?L2ZnOHdwTVpyQUlHbXdmL0E5UmRvZFQwSzg4RXZOdDFJTVppSWJRbnA2cGJI?=
 =?utf-8?B?K0MzWXhEK3dPaU1uSEc1dlBMMmFPNTZjOHNZRU5WbjJZVUZKNE5DT2NvVFYv?=
 =?utf-8?B?NjlOUHo1Tk9WcHFVMmwycSt3UGh0Sk5MMExLRHk0NVRYN3loK0p6UWt4VzJQ?=
 =?utf-8?B?a01rOTJBVEg5R05ENm1hK0xNcWg0NkQ2cm1XekNzNjROc2VsYW0ranM5WHFY?=
 =?utf-8?B?bXdnSm9WcWlaR1Uwdm9OVE1MUDdXSmQwMHBEVjNuTmpGNHVsUDl5L2R5UmR4?=
 =?utf-8?B?dDZGdTAyTS9sd2VubXFhU2EzSENHaVNvOWYzVjZlN2xCMjFOR0Y5KzE1VlhD?=
 =?utf-8?B?cGY3UDVXVFR4N3c2MFB3ZFEyc0tDM25nTkVFdTBzQzEvR3dJUUtzUWV2V1NX?=
 =?utf-8?B?bHdkbGtoQWEwYUt4ZU9XbW90eGVvVDc1bUIrM0w0N0ZKWTRoSjI4SlNPSStQ?=
 =?utf-8?B?RTN4aWZMbEVsN3ZkZXQzNGFXR0NWR3BXMWlBVGt2VEs2cnlKUGdNV3dOZ0Nq?=
 =?utf-8?B?LzJrK2hUaElYdFZJWmF1UDhhWENneG96WWdPaFF1OWhHRUZqekVLV0V5K0Ri?=
 =?utf-8?B?TzZ4UzErOURNMjBKUE40N3NlMWt3R1N3QmNFY1oxWlV0MWtJTFBUcUc0WTF4?=
 =?utf-8?B?THFiaEJaSFVpWVFiQnYwU20vWE5aMUhnYXdTM3B2bmpKK08vRVZlcHhMMys0?=
 =?utf-8?B?RGJCcVdpenFRc3NhZDFDOXRIZUxBVUk1dEFLR2cxVE9wMEx2aVliWnkvZTNO?=
 =?utf-8?B?NEVYc0phbFFQenp6ZzZpSkJXOGdxaTJTV05WTTJnS0VhT0lISVkzNzd6Lyth?=
 =?utf-8?B?M1ZGT2tMQUxpbEhNOEFXdUFYSS9GUnloM0NPVmdORXRnSFFnSTRncmgzeG52?=
 =?utf-8?B?blBqdVdMamV2RzIycEErNFA4WFlQWWx6aVZNVmpQWkk3dVo2dVdsQXprUUNp?=
 =?utf-8?B?Ump0SDk4QkNSa1lEa0E5dHlMbVFQWGZDVVBpdU9sOU5wUERJcm5qL0VIcXla?=
 =?utf-8?B?c1pIWDZpOEQxZ0pLMSswY1RjTytpeTBpWmxNMXZzdzRod2xzTE9hNDVxZXBJ?=
 =?utf-8?B?WTNicGN1SE9WQ09WL01ackRSVkk5amlqVXVTTy9BRnkxMGNtYUFhWk9VNWlQ?=
 =?utf-8?B?dW8wNG1sblBmYUpJNm5rcnc3cSt1TmdZR1c0KzBPdHRHTDZQVVBrc3BEYjN0?=
 =?utf-8?B?TVlHdm0vMER2Wmp2enBjRXRsUWhYQU9wQ3JDWndRM0dZMERHUE1BQVhZdXJt?=
 =?utf-8?B?RXhPK1QranZkVHhScHd2MVR4RUppb2pOT0NhNnQ2NkNaM2QvMTVBSGFqQWhS?=
 =?utf-8?B?QVQyREpBb1lKTTZjR2ZCYXY1ODhxZ1ZJSUJZekw4cTFSN2NXdnBLUnF4NW5W?=
 =?utf-8?B?ZGNDUjFITXRFdHpWUDBHWkkzSkptM2s3NGhkTkt4ZDBMT2s1alZpOW5SRzFk?=
 =?utf-8?B?Q1l5VWtYUEgzRWFJWUlhTXJTRGs1R3JSL2I1SVhUUGpJNXBEVWUrbUhEV2Rj?=
 =?utf-8?B?ekpYa2dZTzltdjd4VXFjTGJxV0EvVmxXQUZJRER1NTBScG54c3liRHBBV0pX?=
 =?utf-8?B?R2pSaEtFd2sxMHE3S04zanBRbEgyNnFOU25JZ2J5UDJLbmk2dWxNUTZHcWxG?=
 =?utf-8?B?UVJRMTEyMG13UDlRWlVndTBBVCtVekMvZCt4c3ZtZER6WDdaODZ3RmhmUklW?=
 =?utf-8?B?TWQ5cTdjTDhvMkVaZGdWUjZWdiswbU10R1hpc2hEK0gzcnNOcFNlSis2UTdO?=
 =?utf-8?B?R25FN1ZlZXphYldxSzNPbU9GMzl0bFE2M1gwalBpb2NvRFlnU0RnRG8vZkNi?=
 =?utf-8?Q?oLU2L2NwYHtWE293FS8c9ExxR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a746caa9-010b-4add-55f1-08ddfb4c117e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:23:48.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcpoP20aA8RZ69R/zyi8fUTaOJb8veTPfSJ0TZowQEL6D3ILQDY3dpAs0gaovN8Tf1HdKmiZhlQiTJqK+eAzlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7899
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBTYXR1cmRh
eSwgU2VwdGVtYmVyIDIwLCAyMDI1IDI6MjAgQU0NCj4gDQo+IE9uIFRodSwgU2VwIDE4LCAyMDI1
IGF0IDA3OjA1OjUwQU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gIDI1NioyXjMw
LCAgICAzOTYsNTY2NSAgLCAgICAgMzg5LDUyNTggICAgLCAgOTIuOTINCj4gPg0KPiA+IGRhdGEg
aGVyZSBtaXNtYXRjaGVzIHRob3NlIGluIGNvdmVybGV0dGVyLCB0aG91Z2ggdGhlIGRpZmZlcmVu
Y2UNCj4gPiBkaWRuJ3QgYWZmZWN0IHRoZSBjb25jbHVzaW9uLiDwn5iKDQo+IA0KPiBJIHJhbiBp
dCB0d2ljZSwgaXQgaXNuJ3Qgc3RhYmxlIGluIG1pY3JvIDopDQoNCnJlYXNvbmFibGUsIGJ1dCBi
ZXR0ZXIgdG8gdXNlIGEgc2FtZSBzZXQgYWxsIG92ZXIgdGhlIHBsYWNlLg0KDQo+IA0KPiA+ID4g
K2lmIElPTU1VX1BUDQo+ID4gPiArY29uZmlnIElPTU1VX1BUX0FNRFYxDQo+ID4gPiArCXRyaXN0
YXRlICJJT01NVSBwYWdlIHRhYmxlIGZvciA2NC1iaXQgQU1EIElPTU1VIHYxIg0KPiA+DQo+ID4g
cmVtb3ZlICI2NC1iaXQiPyBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGEgMzItYml0IGZvcm1hdCBl
dmVyLg0KPiANCj4gSSBhbSBtYXJraW5nIHRoZSA2NCBiaXQgdnMgMzIgYml0IGluIHRoZSBrY29u
ZmlnIGRlc2NyaXB0aW9ucyBzaW5jZQ0KPiB0aGF0IHNlZW1lZCB0byBiZSBhIHBhdHRlcm4gZnJv
bSBpb3BndGFibGUNCj4gDQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBp
bnQgYW1kdjFwdF90YWJsZV9pdGVtX2xnMnN6KGNvbnN0IHN0cnVjdA0KPiBwdF9zdGF0ZQ0KPiA+
ID4gKnB0cykNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiBQVF9HUkFOVUxFX0xHMlNaICsNCj4g
PiA+ICsJICAgICAgIChQVF9UQUJMRU1FTV9MRzJTWiAtIGlsb2cyKFBUX0lURU1fV09SRF9TSVpF
KSkgKiBwdHMtDQo+ID4gPiA+bGV2ZWw7DQo+ID4gPiArfQ0KPiA+ID4gKyNkZWZpbmUgcHRfdGFi
bGVfaXRlbV9sZzJzeiBhbWR2MXB0X3RhYmxlX2l0ZW1fbGcyc3oNCj4gPg0KPiA+IHRoaXMgaXMg
dGhlIHNhbWUgYXMgaW4gcHRfZm10X2RlZmF1bHRzLmgNCj4gDQo+IFllYWgsIEkgbGVmdCB0aGVz
ZSBiZWhpbmQgYmVjYXVzZSB0aGUgb3JkZXIgb2YgZGVjbGFyYXRpb24gaXMNCj4gaW5jb252ZW5p
ZW50LCB0aGUgZm9ybWF0IGl0c2VsZiB3YW50cyB0byBjYWxsIHRoaXMgZnVuY3Rpb24gYSBmZXcN
Cj4gbGluZXMgZG93bi4NCj4gDQo+IEJ1dCBJIGp1c3QgcmVhbGl6ZWQgaXQgY2FuIGJlIGZvcndh
cmQgZGVjbGFyZWQ6DQo+IA0KPiAvKiBCb2R5IGluIHB0X2ZtdF9kZWZhdWx0cy5oICovDQo+IHN0
YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHB0X3RhYmxlX2l0ZW1fbGcyc3ooY29uc3Qgc3RydWN0
IHB0X3N0YXRlICpwdHMpOw0KPiANCj4gU28gdGhhdCdzIGZpeGVkLg0KPiANCj4gPiA+ICtzdGF0
aWMgaW5saW5lIHZvaWQNCj4gPiA+ICthbWR2MXB0X2luc3RhbGxfbGVhZl9lbnRyeShzdHJ1Y3Qg
cHRfc3RhdGUgKnB0cywgcHRfb2FkZHJfdCBvYSwNCj4gPiA+ICsJCQkgICB1bnNpZ25lZCBpbnQg
b2Fzel9sZzIsDQo+ID4gPiArCQkJICAgY29uc3Qgc3RydWN0IHB0X3dyaXRlX2F0dHJzICphdHRy
cykNCj4gPiA+ICt7DQo+ID4gPiArCXVuc2lnbmVkIGludCBpc3pfbGcyID0gcHRfdGFibGVfaXRl
bV9sZzJzeihwdHMpOw0KPiA+ID4gKwl1NjQgKnRhYmxlcCA9IHB0X2N1cl90YWJsZShwdHMsIHU2
NCkgKyBwdHMtPmluZGV4Ow0KPiA+DQo+ID4gY2hlY2sgdGhhdCB0aGUgaW5kZXggaXMgYWxpZ25l
ZCB0byBvYXN6X2xvZzINCj4gDQo+IEkgc2VlIHRoZSB2YXJpb3VzIGZvcm1hdHMgaGF2ZSBhIG1p
c21hdGNoZWQgY29sbGVjdGlvbiBvZiBhc3NlcnRpb25zLA0KPiBJIGFkZGVkIHRoaXMgZnVuY3Rp
b246DQo+IA0KPiAvKg0KPiAgKiBGb3JtYXQgY2FuIGNhbGwgaW4gdGhlIHB0X2luc3RhbGxfbGVh
Zl9lbnRyeSgpIHRvIGNoZWNrIHRoZSBhcmd1bWVudHMgYXJlIGFsbA0KPiAgKiBhbGlnbmVkIGNv
cnJlY3RseS4NCj4gICovDQo+IHN0YXRpYyBpbmxpbmUgYm9vbCBwdF9jaGVja19pbnN0YWxsX2xl
YWZfYXJncyhzdHJ1Y3QgcHRfc3RhdGUgKnB0cywNCj4gCQkJCQkgICAgICBwdF9vYWRkcl90IG9h
LA0KPiAJCQkJCSAgICAgIHVuc2lnbmVkIGludCBvYXN6X2xnMikNCj4gew0KPiAJdW5zaWduZWQg
aW50IGlzel9sZzIgPSBwdF90YWJsZV9pdGVtX2xnMnN6KHB0cyk7DQo+IA0KPiAJaWYgKFBUX1dB
Uk5fT04ob2Fsb2cyX21vZChvYSwgb2Fzel9sZzIpKSkNCj4gCQlyZXR1cm4gZmFsc2U7DQo+IA0K
PiAjaWZkZWYgcHRfcG9zc2libGVfc2l6ZXMNCj4gCWlmIChQVF9XQVJOX09OKGlzel9sZzIgPCBv
YXN6X2xnMiB8fA0KPiAJCSAgICAgICBvYXN6X2xnMiA+IGlzel9sZzIgKyBwdF9udW1faXRlbXNf
bGcyKHB0cykpKQ0KPiAJCXJldHVybiBmYWxzZTsNCj4gI2Vsc2UNCj4gCWlmIChQVF9XQVJOX09O
KG9hc3pfbGcyICE9IGlzel9sZzIgJiYNCj4gCQkgICAgICAgb2Fzel9sZzIgIT0gaXN6X2xnMiAr
IHB0X2NvbnRpZ19jb3VudF9sZzIocHRzKSkpDQo+IAkJcmV0dXJuIGZhbHNlOw0KPiAjZW5kaWYN
Cj4gDQo+IAlpZiAoUFRfV0FSTl9PTihvYWxvZzJfbW9kKHB0cy0+aW5kZXgsIG9hc3pfbGcyIC0g
aXN6X2xnMikpKQ0KPiAJCXJldHVybiBmYWxzZTsNCj4gCXJldHVybiB0cnVlOw0KPiB9DQo+IA0K
PiBBbmQgdGhlIGZvcm1hdCBjYW4ganVzdCBjYWxsIGl0Lg0KPiANCj4gTWFkZSBib3RoIHRoZXNl
IGVkaXRzIHRvIGFsbCB0aGUgZm9ybWF0cy4uDQo+IA0KDQptdWNoIGJldHRlci4NCg==

