Return-Path: <linux-kselftest+bounces-15056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDE94CB7A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B5D285B88
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797B3175D2C;
	Fri,  9 Aug 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKp5CUb8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F712FB34;
	Fri,  9 Aug 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188901; cv=fail; b=sXe9pUQenQYkIkGVTxGKBuWqgovZLuLZICLC+SWpCN7d4hOXmPcKSUvuNOmieRuvHMXHYEKHg3bQneRLX4OeoKtrbInf46ivYQ4w55XbOQwee0LNdXx0YhlJ+6+eD4/blvWaQngDoMNbys04ersEfzoqPt0danPzHf4NYo4twCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188901; c=relaxed/simple;
	bh=1DbMMhv7J+mYi2ipAq3XbHgEosV/RYnZeDGSh4ViA3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o3uFw3HQdiBW9xgtCG89mlgGWKB5czFiL9LKAV5X4DCZwP1YjfYM0679L5HU9w+Z2zLoDuKbkKYhBmKcbie4yQg0s4dNilyzVbe6AcxhlqNG8LNj9IyDkokLbtooCTgVMdO0Jxq1r6Fwob5bBpvxVCv8+0BB9Dyxpcm3tRYBkck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKp5CUb8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723188898; x=1754724898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1DbMMhv7J+mYi2ipAq3XbHgEosV/RYnZeDGSh4ViA3M=;
  b=dKp5CUb8eRbB2wH6ePg89T5lQZV9QZu2TyNMIkQnb/RiT/VP71Tz65Nt
   SZJg1Iiqb0OGRf2GMydo3mnZyDL3QzdBQvAF4ZgrDhXcNqw1QeCh1vOHF
   A8eUp++qL2+xC/1zCIPMnWhtU63Wmf33RFtWcKbXZmEMEQmI3J01cNRwc
   Y7kcZzgbtMjVOPu0a7Pcw2ytBWak+/Oiejs+P2Dg+6uB4QQ61fC3YjK+p
   9nnJGUrquW3JiWTlm/aPSvgZjo1qXbrriOplCQ08B1moOh9kjojuUH50X
   bNtiP8WiSn0X5gWeMMnuSrvLxt9OjKI6OkrNclBu0+pFOXu+b3raMA928
   g==;
X-CSE-ConnectionGUID: bYQolEh2RtKkTBiogI70yw==
X-CSE-MsgGUID: H0kbZMhURVCGdFAxiQD2YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21212216"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21212216"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:34:58 -0700
X-CSE-ConnectionGUID: iHURTyiyQHq9RU4iLnv6MA==
X-CSE-MsgGUID: 4RXUeAr1QzKGWxJYQnv1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="95002380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 00:34:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 00:34:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 00:34:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 00:34:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 00:34:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKDLQXMwO/NcNTafit9xrXVYR+yIoYP6n3Z9CPJhgA9n7DcZOpUzYj2i/blzY2+YGTVk0DRNZXVI0y0AXMc7XA82OLRvMHAxINOdC1vl6ylqiNrMOKAIjYUxqbV7ecFC8N7UvRlnL8Dj/JoFOJDZFleQ+nb8qjFS9fAGSyJVmtORbDo8zJJ4WwQbO/BKd8X+aBLWR0LzBs/8+RQ4Vjn0qGozZQO3ZdPhKSYksmRM5+jH+8n1khZ3SWPQ6ooHFACS7F/eqapRiwWzPAzf+yLbQA3sKKftuOrQXmrN6/DqnBOYokhxT4axjfHzUCEb4E+K1WUDxa1cWOc0dRou7HuB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DbMMhv7J+mYi2ipAq3XbHgEosV/RYnZeDGSh4ViA3M=;
 b=JWBSxMhiXhORq3KvT+uERKnyp/vNw0kSQ5V5fg1pssDoSDoETNB9ES8AQ4Z0srM49J8Lr1+YDJJCwEne8zO0MiiLDL3szd0/gZa3LZA1eWJUCvZaaM5H9aiJG6Kg7V1wHLb5MG8bVziMzuBZ0Hz00WwgkF4xSRC5vTKVTPqX4zBJIcj2CqbvRq9HsSqE1AwTpDwA79etUeQzWNwaBX+gl9ifAJXih4g4Q+lbog+txvMf0//EIC1h2NHI13kmDQkw8+8AByaSQWd1prZbbd4lxPRYlpTxWSA7gnuOh+sna+MM2Bmf+lPr9pu2zSCL3ULyFM8SAPUcv2g05L6gKdkfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7525.namprd11.prod.outlook.com (2603:10b6:806:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 07:34:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 07:34:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Thread-Topic: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Thread-Index: AQHa5Tymvv0QPh+hX0iHTvry+ddr+7IZ6L5AgANsmACAATvmkA==
Date: Fri, 9 Aug 2024 07:34:53 +0000
Message-ID: <BN9PR11MB52767A327C11601AEA7E33398CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
In-Reply-To: <6da4f216-594b-4c51-848c-86e281402820@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7525:EE_
x-ms-office365-filtering-correlation-id: b66e095b-016b-40ae-9f74-08dcb845c26f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y3lYcEhYb2VnOUIxZ1lpaUlEdEhzN1QxSnF1dmZEN09ER2RBeEZUcU82cjNj?=
 =?utf-8?B?NitNcTBGQ3UxWWhtSDdITWJIZzVMeFJYZXVSNTdmSmR0ZHBOL0k3cHdxWE4y?=
 =?utf-8?B?QlByZjZRdEh2b2RUSjgxSU00eTlxZkhhTU1vRXZaakhpT0tiZnNLMDdueEcy?=
 =?utf-8?B?YWJORDNDcnBMNXNRMmRTU05ZNVk0YzhFeU85REo0V2tKYW9PNFFLSUpueVhZ?=
 =?utf-8?B?Z3hYdTRIaExtWW5FeHVadUhFSUZRcTJaQkwxZ2F6SkR2RDZBQlY3a2g3c21J?=
 =?utf-8?B?bFExdUoxS0RyWTZxVERSeWRUZ3QwNjFVQVB1SnFsVjhWTEQrSXpPZjF0VWlG?=
 =?utf-8?B?NHVMOFBqTDcvUG40OG5aUTdaT2NHbDFZdVNwMzV0bDArQ3BiQ0ozdUp2aVUx?=
 =?utf-8?B?azYzN1o2RkIwK3JpRzk1M3BxWm9FdTRLU3NHamw4MXJKMDlXZkhNcHVjd0F4?=
 =?utf-8?B?dXJZM0Y5dko3Q05kYSt0R1hPbm45NnNYakJ1THd3VXNsejQrL3gyN3grRjNR?=
 =?utf-8?B?dzVuU09kQ1g5dGxkc3N5QkZ5Z3pOZlJoaWtwYnQyOG91d2VuQzVXVTFYS3p3?=
 =?utf-8?B?T1cvQnRrZ016T0l6czMyY1dkeVFPdGRiR0tTbFc2dDdhUFlHejVFelZSOStm?=
 =?utf-8?B?UDB5Y1VHbWNyR0lEQVpxMCsvUk5KMEpWeitTMFppditvZHFDNkxSZ09NZXd4?=
 =?utf-8?B?SHVSU1FjRXlzR25jZ1IrcHV4NEY3SUJTOUp1ZTlFeFd4RFJJMVp0NERwTXFI?=
 =?utf-8?B?OThmc1Y2b3NSRUp6VWYzN3NYQXZ0ZVRPVjlSckpLZlo1dmV6RjNjZjRzZkNz?=
 =?utf-8?B?aFlIUVM1c1E5T0VQT1ZRM1BQakpJcEhjdmNrUUVVNytyTTM2Z2dHR242SDQ0?=
 =?utf-8?B?dm9hQ05Id2FoWDc4ZmZ4ZTFSMlhINUhzank1VWhJMmdJVTRhWmIxTWVnR1pG?=
 =?utf-8?B?dFoxeVIxNDVhYVN3VU1VcWlLSy9LbWFPbjFLa0VGcndCTEpGN2xTNmgvOHV6?=
 =?utf-8?B?andvMGlJYUZZcENPVElzeEJMSGJwV3ZKRUxHcGY5SEtrNVBIM1JWRjg5RGFC?=
 =?utf-8?B?eVpsU0Q1a2loM2JCOHlJT1pWaTNnSGJaYVNjQngrTjdzSGVoL2pHSGthOHRm?=
 =?utf-8?B?U1pOQTZaTXZRRmtZcnVhUldyMzYxMW8xMGFFY1orbTUxVDBjVlcvRTFWUDhP?=
 =?utf-8?B?WlZzb2ZKbjlLQXhpZjZrcWRUOEtCdzdHUU9lUjU3akQxekJXcW84L2pvdjJR?=
 =?utf-8?B?UmtlY3NCSVl0N0l5MnVvNVlndFpHdFB2WmRab2FZU20yekIzdzc3UzQ2alI2?=
 =?utf-8?B?Z0pEbnJzS3JsMUhab2VHclBOQVViTzR5YTZoT0RLNlJVL0lKTjZ2dUYrL1hr?=
 =?utf-8?B?YUk4UzlLb1VGOVF4amdOY3ViN1hKaDB1L01LUEo5cGNnb1pTWnl5WDMzOXA0?=
 =?utf-8?B?MFBpVC9UMFU4QytOTU1FcFVPSjVEalpudnphZFZQNldBdmZlemdIMitIYmV0?=
 =?utf-8?B?MWh4YjZDN0VHSGFFR25qL05LOXVuV1IzWlE2dXFGTmsyR1BYaGNQT21QRjRH?=
 =?utf-8?B?TFZzN0pyU05HbUhRTzMrdnkyZm9rRDc0dVdzbkpjbG5zbTFuQkxta294UWhx?=
 =?utf-8?B?bDFxYWlZYkJaaTNnUHpFQUdjNklObVgyTjNHUERwL2VLK2VDMUpxc1JTbkZn?=
 =?utf-8?B?Vm5PK25iLzg1QUthWEJSd1JFR0hMTDdub00vOXl6TUVqMnhpWEF5dENuOE44?=
 =?utf-8?B?SmQyZnFEbm53SDNGTkQ5aWhJSXUwRnlRNTIvcEZrL3IvUEhkeUl1OVZyVnRr?=
 =?utf-8?B?dFFEQVNhQ1B2K2ZBVkZJTzVuSHlnNnRIemE3cEhpT28vaUZybU14a253TDNP?=
 =?utf-8?B?WW9LMFExRmQ3VnMybWpVVDNEUnE0ZHJ2SXBJRjE1ODdhNGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RExLU3JsQko4aUlaRlAva3M5c1NnYUhTYi9TQzFHaEdZZm1YWCtCMFZZaUl4?=
 =?utf-8?B?VENOTkp6N2dWeUpBMXVMeTgvUlNnMWQ2bnVTbURCWjZGeUo4NmdEZEYyM29a?=
 =?utf-8?B?MVBtcmprSXRNZFp0YlY4TzJjSG9GUTZjUnBDRVhReEZ1N1Jac0JISjF3WS9L?=
 =?utf-8?B?aVJzY1VIVUI3b2pqVzBpSWFvK0lqR0JkWjJPLzhzM0d0ZGRGdjR0TUR5czll?=
 =?utf-8?B?UTJyc3JmZERZUS9FOGcvMy9QaVdrSW5mNk9pMElYMGw3REF2OVdubWFQTlpu?=
 =?utf-8?B?WDR4akxXQ2szbXFtSHJ4OXJsM3owSExxMzZ5NXBNQmlqZDRIcVpPR1E0bi9G?=
 =?utf-8?B?Zi9BUEl0RCthTmVnRHFRaGNsWE5NVjIzS1dvNi9rMXNMMk9IYWNMMlVuekNB?=
 =?utf-8?B?NVJRYk0xSmtkRFNFUFFiQ2lIOEY1TlNESy96YzlINUJ3YzhmZDhrSmVkOWxX?=
 =?utf-8?B?TWtYUjdKVVdSRzB3QzdrMWFJaGFRVThOL005M1FCSy9tV296QXBwOWZSeUFH?=
 =?utf-8?B?SEpjRXJDUUZFNThyT3pjV3hYMjFSZEZMeTE5NGdnQnY4dlgvRlhjNUo4dGdL?=
 =?utf-8?B?Q3ZBTmV6UThaSEtCY29QcUtQQXlxSXNlOC83YVVsTCt0UnpIMFh3QW1ZM0xO?=
 =?utf-8?B?eTZpL3Yrbko5eitOTXdHZVpRZUFNWGl5ZUJ2UC9LYVFvTzNrSDh1WTdwTG1o?=
 =?utf-8?B?VGhVZ0NDWDNTTDBiZW5rQ0lsbC9aR3MrTm1kYWNIUFlVcElkL0VacUZLejR3?=
 =?utf-8?B?cUd2MWlCZnpGSHQwSkRjU0hxUXdMZUdhanRlWTJKVUZBa1VvREczNHBQdG1v?=
 =?utf-8?B?WTI2VTViUWRBY0NwRU82UmJlejdta0xvak9TSXowU2RjcUowV3Y2ZGVJR0Js?=
 =?utf-8?B?L3lFVlE2RkxoY2N4RGh1TnM4NWx4N2FQQ2pPTXJJZUwyT0cyNGkzNFpwekxN?=
 =?utf-8?B?VEU3NHh6bER2Tlg3VDU1RjdlZjIycHVGTlZzQVYzUFFXRlhVMGxkY0piZzlL?=
 =?utf-8?B?bVBOZXliK3BYclFQRXRIbFpKdytxai9DamFaaXR3dFJMcDI3MXRvaFlLNWNt?=
 =?utf-8?B?eFJUS0J3d0JDajFxKzFGNGpJTjVJM0VvWnJSa1hpTkpNOXkrVVZHbVdQTFU0?=
 =?utf-8?B?SmVhTVJleHp2WUpsdit1bFlOdm5uVzlCTk13UThDQ3ZwdnFCSENUUmRieVBS?=
 =?utf-8?B?OUdRYkdoR005VTNHckxHbHVsUGgvNklCQWF4bzNjL0M5Z20yL2lySmpDOGdk?=
 =?utf-8?B?eXhwUnFOQjI0RGw1azNVcDREaG9ENFEwVmZmZ200b1ZxdTZac2pQNW1pZHVQ?=
 =?utf-8?B?bXIzdFMrVjJHQmdsM2ppQjNyMFRURDNnSFk5UVp6anZVQW9qQ3phQTNHRjJY?=
 =?utf-8?B?WmI5RVNuUG5ZY3JBOW9yUjAzbGZmUVpZVG1RM3A5WDd0RzB5RmtTU0tWS2t2?=
 =?utf-8?B?VnBNcHhING50MzkxdnExcHgrUzVQM0J2SWtDTkJTcFV5VDhGWUFxVnFaSk5J?=
 =?utf-8?B?dGw5ang5WlJnZ3lPWDF4NkVMSE1FczVyNlp2V3lKSXo1ZGk3Uk8zeHdhZ2pw?=
 =?utf-8?B?dnJDRG9UNWxuckdTZlVpVEdyQ1B4SS9sNVlBbHo3R0pSNFpYNVVyRWpLaEla?=
 =?utf-8?B?Rjh3eFdQdTVrVVNSdTZkV3BvTSs4UVRjTThndmhVdHNCTXB1aE84czI2ZFBG?=
 =?utf-8?B?L08vcUVCSjBGOW8xK2p0cjhKMENpRzBkb1RlYXdCbUwzSU5QSVhlRU1RU1Qw?=
 =?utf-8?B?SEVpWklPa3VmNWIxRThqTEFoVmRvTzRPaGE1MUliYUJZaVlNMEpjWUtXYUg5?=
 =?utf-8?B?aXpjenhKTU15WkRwVDJjQWN1KytPbXN4OG9OcDVEcVdZSHFmVVRRNlpQNlNU?=
 =?utf-8?B?amViaGVEZTdVMXJJQmlRTkhWWTkwWERRTGRGU0Rpa3M1alpXMTZJYVI2ZjNL?=
 =?utf-8?B?ZS9JSElTejlDWUE4cVJLQlpRalpwSTUvYklUZFdzaExvaTMzR2NIaE9QQ1Zw?=
 =?utf-8?B?UDRNb1lONStOcHhMNFovazhlOHRWT2NKMzg1UU4vMUpmQm5TNWRmbFBWeThJ?=
 =?utf-8?B?TXVKdDExS0JXd1VRazhlTGJuanRhMUE5QTN4YnMweWZNNlpEWm9kQWVzWnMx?=
 =?utf-8?Q?h8IGXknB3cyv9fbt/CXX9vIJg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b66e095b-016b-40ae-9f74-08dcb845c26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 07:34:53.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TntC3H7EGqS9mE7H5iRcBDztx900dp4qQmad1HmiLuMO5sMwEd1X+QFtcLxKflZ+I6aKVCNBZ3J7EnVv1tK3cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7525
X-OriginatorOrg: intel.com

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDgsIDIwMjQgODozOSBQTQ0KPiANCj4gT24gMDYvMDgvMjAyNCA5OjI1IGFt
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Bu
dmlkaWEuY29tPg0KPiA+PiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDMsIDIwMjQgODozMiBBTQ0K
PiA+Pg0KPiA+PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiA+
Pg0KPiA+PiBDdXJyZW50bHksIGlvbW11LWRtYSBpcyB0aGUgb25seSBwbGFjZSBvdXRzaWRlIG9m
IElPTU1VRkQgYW5kIGRyaXZlcnMNCj4gPj4gd2hpY2ggbWlnaHQgbmVlZCB0byBiZSBhd2FyZSBv
ZiB0aGUgc3RhZ2UgMiBkb21haW4gZW5jYXBzdWxhdGVkIHdpdGhpbg0KPiA+PiBhIG5lc3RlZCBk
b21haW4uIFRoaXMgd291bGQgYmUgaW4gdGhlIGxlZ2FjeS1WRklPLXN0eWxlIGNhc2Ugd2hlcmUg
d2UncmUNCj4gPg0KPiA+IHdoeSBpcyBpdCBhIGxlZ2FjeS1WRklPLXN0eWxlPyBXZSBvbmx5IHN1
cHBvcnQgbmVzdGVkIGluIElPTU1VRkQuDQo+IA0KPiBCZWNhdXNlIHdpdGggcHJvcGVyIG5lc3Rp
bmcgd2UgaWRlYWxseSBzaG91bGRuJ3QgbmVlZCB0aGUgaG9zdC1tYW5hZ2VkDQo+IE1TSSBtZXNz
IGF0IGFsbCwgd2hpY2ggYWxsIHN0ZW1zIGZyb20gdGhlIG9sZCBWRklPIHBhcmFkaWdtIG9mDQo+
IGNvbXBsZXRlbHkgYWJzdHJhY3RpbmcgaW50ZXJydXB0cyBmcm9tIHVzZXJzcGFjZS4gSSdtIHN0
aWxsIGhvcGluZw0KDQp5ZXMgdGhpcyB3YXMgdGhlIGNvbnNlbnN1cyBmcm9tIHByZXZpb3VzIGRp
c2N1c3Npb24gaWlyYy4gSnVzdCBhIGJpdA0KZGlzdHJhY3RpbmcgYnkgY2FsbGluZyBpdCBvbGQg
VkZJTyBwYXJhZGlnbS4g8J+Yig0KDQo+IElPTU1VRkQgY2FuIGdyb3cgaXRzIG93biBpbnRlcmZh
Y2UgZm9yIGVmZmljaWVudCBNU0kgcGFzc3Rocm91Z2gsIHdoZXJlDQo+IHRoZSBWTU0gY2FuIHNp
bXBseSBtYXAgdGhlIHBoeXNpY2FsIE1TSSBkb29yYmVsbCBpbnRvIHdoYXRldmVyIElQQSAoR1BB
KQ0KPiBpdCB3YW50cyBpdCB0byBhcHBlYXIgYXQgaW4gdGhlIFMyIGRvbWFpbiwgdGhlbiB3aGF0
ZXZlciB0aGUgZ3Vlc3QgZG9lcw0KPiB3aXRoIFMxIGl0IGNhbiBwcm9ncmFtIHRoZSBNU0kgYWRk
cmVzcyBpbnRvIHRoZSBlbmRwb2ludCBhY2NvcmRpbmdseQ0KPiB3aXRob3V0IHVzIGhhdmluZyB0
byBmaWRkbGUgd2l0aCBpdC4NCj4gDQo+IEZXSVcsIGFwYXJ0IGZyb20gSU9NTVVGRCwgd2UgbWF5
IGFsc28gZW5kIHVwIHdhbnRpbmcgc29tZXRoaW5nIGFsb25nDQo+IHRob3NlIGxpbmVzIGZvciBB
cm0gQ0NBIChpZiBub24tU2VjdXJlIHByb3h5aW5nIG9mIFQ9MSBNU0lzIGJlY29tZXMgYW4NCj4g
dW5hdm9pZGFibGUgdGhpbmcpLg0KPiANCj4gPj4gdXNpbmcgaG9zdC1tYW5hZ2VkIE1TSXMgd2l0
aCBhbiBpZGVudGl0eSBtYXBwaW5nIGF0IHN0YWdlIDEsIHdoZXJlIGl0IGlzDQo+ID4+IHRoZSB1
bmRlcmx5aW5nIHN0YWdlIDIgZG9tYWluIHdoaWNoIG93bnMgYW4gTVNJIGNvb2tpZSBhbmQgaG9s
ZHMgdGhlDQo+ID4+IGNvcnJlc3BvbmRpbmcgZHluYW1pYyBtYXBwaW5ncy4gSG9vayB1cCB0aGUg
bmV3IG9wIHRvIHJlc29sdmUgd2hhdA0KPiB3ZQ0KPiA+PiBuZWVkIGZyb20gYSBuZXN0ZWQgZG9t
YWluLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBo
eUBhcm0uY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52
aWRpYS5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgfCAx
OCArKysrKysrKysrKysrKysrLS0NCj4gPj4gICBpbmNsdWRlL2xpbnV4L2lvbW11LmggICAgIHwg
IDQgKysrKw0KPiA+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11
LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jDQo+ID4+IGluZGV4IDdiMWRmYTA2NjVkZjYu
LjA1ZTA0OTM0YTVmODEgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11
LmMNCj4gPj4gKysrIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYw0KPiA+PiBAQCAtMTc5OSw2
ICsxNzk5LDIwIEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG1hX21zaV9wYWdlDQo+ID4+ICppb21t
dV9kbWFfZ2V0X21zaV9wYWdlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4gICAJcmV0dXJuIE5V
TEw7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiArLyoNCj4gPj4gKyAqIE5lc3RlZCBkb21haW5zIG1h
eSBub3QgaGF2ZSBhbiBNU0kgY29va2llIG9yIGFjY2VwdCBtYXBwaW5ncywgYnV0DQo+ID4+IHRo
ZXkgbWF5DQo+ID4+ICsgKiBiZSByZWxhdGVkIHRvIGEgZG9tYWluIHdoaWNoIGRvZXMsIHNvIHdl
IGxldCB0aGVtIHRlbGwgdXMgd2hhdCB0aGV5DQo+IG5lZWQuDQo+ID4+ICsgKi8NCj4gPj4gK3N0
YXRpYyBzdHJ1Y3QgaW9tbXVfZG9tYWluDQo+ID4+ICppb21tdV9kbWFfZ2V0X21zaV9tYXBwaW5n
X2RvbWFpbihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4+ICt7DQo+ID4+ICsJc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KGRldik7DQo+ID4+ICsN
Cj4gPj4gKwlpZiAoZG9tYWluICYmIGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fTkVTVEVE
ICYmDQo+ID4+ICsJICAgIGRvbWFpbi0+b3BzLT5nZXRfbXNpX21hcHBpbmdfZG9tYWluKQ0KPiA+
DQo+ID4gSSdtIG5vdCBzdXJlIHRoZSBjb3JlIHNob3VsZCByZXN0cmljdCBpdCB0byB0aGUgTkVT
VEVEIHR5cGUuIEdpdmVuDQo+ID4gdGhlcmUgaXMgYSBuZXcgZG9tYWluIG9wcyBhbnkgdHlwZSBy
ZXN0cmljdGlvbiBjYW4gYmUgaGFuZGxlZA0KPiA+IGluc2lkZSB0aGUgY2FsbGJhY2suIEFueXdh
eSB0aGUgZHJpdmVyIHNob3VsZCByZWdpc3RlciB0aGUgb3ANCj4gPiBmb3IgYSBkb21haW4gb25s
eSB3aGVuIHRoZXJlIGlzIGEgbmVlZC4NCj4gDQo+IE5lc3RlZCBzaG91bGQgcmVtYWluIHRoZSBv
bmx5IGNhc2Ugd2hlcmUgZG9tYWlucyBhcmUgY2hhaW5lZCB0b2dldGhlcg0KPiBzdWNoIHRoYXQg
dGhlIFZGSU8gTVNJIGNvb2tpZSBtYXkgYmUgaGlkaW5nIHNvbWV3aGVyZSBlbHNlLiBUaGlzIGlz
DQo+IGVmZmVjdGl2ZWx5IGRvY3VtZW50aW5nIHRoYXQgaW1wbGVtZW50aW5nIHRoZSBjYWxsYmFj
ayBmb3IgYW55IG90aGVyDQo+IGRvbWFpbiB0eXBlIHdvdWxkIGJlIGEgYmFkIHNtZWxsLiBNdWNo
IGxpa2UgaG93IHRoZSBtYXBwaW5nLXJlbGF0ZWQgb3BzDQo+IGFyZSBleHBsaWNpdGx5IHNob3J0
LWNpcmN1aXRlZCBmb3Igbm9uLXBhZ2luZyBkb21haW4gdHlwZXMuDQoNClRoZW4gcHJvYmFibHkg
Z29vZCB0byBjbGFyaWZ5IGl0IGluIGJlbG93IGNvbW1lbnQgZm9yDQpAZ2V0X21zaV9tYXBwaW5n
X2RvbWFpbiBzbyBkcml2ZXIgZGV2ZWxvcGVycyBjb3VsZCBjYXRjaCB0aGF0DQpyZXN0cmljdGlv
biBlYXNpbHkgdy9vIHNlYXJjaGluZyB0aGUgcmVsYXRlZCBjb2RlLg0KDQo+IA0KPiBUaGFua3Ms
DQo+IFJvYmluLg0KPiANCj4gPj4gKwkJZG9tYWluID0gZG9tYWluLT5vcHMtPmdldF9tc2lfbWFw
cGluZ19kb21haW4oZG9tYWluKTsNCj4gPj4gKwlyZXR1cm4gZG9tYWluOw0KPiA+PiArfQ0KPiA+
PiArDQo+ID4+ICAgLyoqDQo+ID4+ICAgICogaW9tbXVfZG1hX3ByZXBhcmVfbXNpKCkgLSBNYXAg
dGhlIE1TSSBwYWdlIGluIHRoZSBJT01NVQ0KPiBkb21haW4NCj4gPj4gICAgKiBAZGVzYzogTVNJ
IGRlc2NyaXB0b3IsIHdpbGwgc3RvcmUgdGhlIE1TSSBwYWdlDQo+ID4+IEBAIC0xODA5LDcgKzE4
MjMsNyBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2RtYV9tc2lfcGFnZQ0KPiA+PiAqaW9tbXVfZG1h
X2dldF9tc2lfcGFnZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4+ICAgaW50IGlvbW11X2RtYV9w
cmVwYXJlX21zaShzdHJ1Y3QgbXNpX2Rlc2MgKmRlc2MsIHBoeXNfYWRkcl90DQo+IG1zaV9hZGRy
KQ0KPiA+PiAgIHsNCj4gPj4gICAJc3RydWN0IGRldmljZSAqZGV2ID0gbXNpX2Rlc2NfdG9fZGV2
KGRlc2MpOw0KPiA+PiAtCXN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiA9IGlvbW11X2dldF9k
b21haW5fZm9yX2RldihkZXYpOw0KPiA+PiArCXN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiA9
DQo+ID4+IGlvbW11X2RtYV9nZXRfbXNpX21hcHBpbmdfZG9tYWluKGRldik7DQo+ID4+ICAgCXN0
cnVjdCBpb21tdV9kbWFfbXNpX3BhZ2UgKm1zaV9wYWdlOw0KPiA+PiAgIAlzdGF0aWMgREVGSU5F
X01VVEVYKG1zaV9wcmVwYXJlX2xvY2spOyAvKiBzZWUgYmVsb3cgKi8NCj4gPj4NCj4gPj4gQEAg
LTE4NDIsNyArMTg1Niw3IEBAIGludCBpb21tdV9kbWFfcHJlcGFyZV9tc2koc3RydWN0IG1zaV9k
ZXNjDQo+ID4+ICpkZXNjLCBwaHlzX2FkZHJfdCBtc2lfYWRkcikNCj4gPj4gICB2b2lkIGlvbW11
X2RtYV9jb21wb3NlX21zaV9tc2coc3RydWN0IG1zaV9kZXNjICpkZXNjLCBzdHJ1Y3QNCj4gbXNp
X21zZw0KPiA+PiAqbXNnKQ0KPiA+PiAgIHsNCj4gPj4gICAJc3RydWN0IGRldmljZSAqZGV2ID0g
bXNpX2Rlc2NfdG9fZGV2KGRlc2MpOw0KPiA+PiAtCWNvbnN0IHN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbiA9DQo+ID4+IGlvbW11X2dldF9kb21haW5fZm9yX2RldihkZXYpOw0KPiA+PiArCWNv
bnN0IHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiA9DQo+ID4+IGlvbW11X2RtYV9nZXRfbXNp
X21hcHBpbmdfZG9tYWluKGRldik7DQo+ID4+ICAgCWNvbnN0IHN0cnVjdCBpb21tdV9kbWFfbXNp
X3BhZ2UgKm1zaV9wYWdlOw0KPiA+Pg0KPiA+PiAgIAltc2lfcGFnZSA9IG1zaV9kZXNjX2dldF9p
b21tdV9jb29raWUoZGVzYyk7DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11
LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPj4gaW5kZXggNGQ0N2YyYzMzMzExOC4uNjll
ZDc2ZjljM2VjNCAxMDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+ID4+
ICsrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaA0KPiA+PiBAQCAtNjM4LDYgKzYzOCw4IEBAIHN0
cnVjdCBpb21tdV9vcHMgew0KPiA+PiAgICAqIEBlbmFibGVfbmVzdGluZzogRW5hYmxlIG5lc3Rp
bmcNCj4gPj4gICAgKiBAc2V0X3BndGFibGVfcXVpcmtzOiBTZXQgaW8gcGFnZSB0YWJsZSBxdWly
a3MgKElPX1BHVEFCTEVfUVVJUktfKikNCj4gPj4gICAgKiBAZnJlZTogUmVsZWFzZSB0aGUgZG9t
YWluIGFmdGVyIHVzZS4NCj4gPj4gKyAqIEBnZXRfbXNpX21hcHBpbmdfZG9tYWluOiBSZXR1cm4g
dGhlIHJlbGF0ZWQgaW9tbXVfZG9tYWluIHRoYXQNCj4gPj4gc2hvdWxkIGhvbGQgdGhlDQo+ID4+
ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgTVNJIGNvb2tpZSBhbmQgYWNjZXB0IG1hcHBp
bmcocykuDQo+ID4+ICAgICovDQo+ID4+ICAgc3RydWN0IGlvbW11X2RvbWFpbl9vcHMgew0KPiA+
PiAgIAlpbnQgKCphdHRhY2hfZGV2KShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHN0cnVj
dCBkZXZpY2UgKmRldik7DQo+ID4+IEBAIC02NjgsNiArNjcwLDggQEAgc3RydWN0IGlvbW11X2Rv
bWFpbl9vcHMgew0KPiA+PiAgIAkJCQkgIHVuc2lnbmVkIGxvbmcgcXVpcmtzKTsNCj4gPj4NCj4g
Pj4gICAJdm9pZCAoKmZyZWUpKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbik7DQo+ID4+ICsJ
c3RydWN0IGlvbW11X2RvbWFpbiAqDQo+ID4+ICsJCSgqZ2V0X21zaV9tYXBwaW5nX2RvbWFpbiko
c3RydWN0IGlvbW11X2RvbWFpbg0KPiA+PiAqZG9tYWluKTsNCj4gPj4gICB9Ow0KPiA+Pg0KPiA+
PiAgIC8qKg0KPiA+PiAtLQ0KPiA+PiAyLjQzLjANCj4gPj4NCj4gPg0K

