Return-Path: <linux-kselftest+bounces-44278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1EC1AF92
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5AD584DBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E86C2BFC9B;
	Wed, 29 Oct 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luQPWC54"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3737A3C4;
	Wed, 29 Oct 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744124; cv=fail; b=aPZqyNZfTqC0WZRbiHFX0LU/KvBsezGrxr9XF08IYBrb5c5WwRX/cP5nkbntozo+xFMaObE62ukWpJmx5BWqnXIc0GkythheFD4vs7t79NDhhx4N11G1zDYgK7taU3iQRd4aDLohiA1P4MhOSuloobUUeGkHKIL2IixNiLxkIq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744124; c=relaxed/simple;
	bh=Ozx0e13QYu5lJLwoFB6p6xGVqW0Vlb+mtWgV5P5wTR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZs3BLIwsCxlIimvYFH6O9yXRt4q6zyGpvrJWhII7TV70IdcKcAZ3qQPCsTEO6dfNCpdTa88Yi8JK/MUTE3pek1xetQ9FrG7JSdvGvc0/Obn76nyej1Lqe85qYdlwfvpiNmKAKGaRToaomAnbiaemZMtg2TgBO0aU26jU+2kxDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luQPWC54; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761744122; x=1793280122;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ozx0e13QYu5lJLwoFB6p6xGVqW0Vlb+mtWgV5P5wTR0=;
  b=luQPWC54vmdzVXlnwpsBk0NTO5+LsYZsriZLHgboqfeN0vWHw7OeOiPW
   o4pTp0FIwuwT+as3NXpoisBA2k5fNIC/AHOWFTGWWV/jmXdtmKzUMjsIa
   mOBrTJmVM4Cfrafs6wmZTMkre9TbCJhcbNTa9DyQcvjEpdLlfJttqs9da
   ROGzF+z1Vmne1rFSXKSYYEGBI1Ti+SncPxEolqd/2KGBfWSL763k725QO
   AEi59ntyndqOZfZKrvzfCuqTXzyOAGo/8WbDbRBMuNY20SKzWldFPJnmV
   +x5Fv/MJKmh6Lo2D5HDgp0ftjwm9jX0r56f9UPKJUYcdD3LpwHJlpgPRA
   A==;
X-CSE-ConnectionGUID: 87kudqTfSxSkdJvJ3GsHzw==
X-CSE-MsgGUID: JFuS6yUlQCyDPnOEbaee3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63772719"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="63772719"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:22:01 -0700
X-CSE-ConnectionGUID: DX4jf680SgGkaKJPi2hukg==
X-CSE-MsgGUID: HmNlQe+rRyqlSISTyCwrhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="209262187"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:22:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 06:22:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 06:22:00 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 06:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+PKOy5PyuqQzz7e6rBa4mqIWhRWg+emXQeXFap+nXkfuHqv9Tod5S+bdtYVLy/LudJECkXPq774o1mN+95B4nNkRonhttk5JGkeLGTBxAzswVV3Q/xS/an2hnk8acBm/3TdUf6FlGesNc4zsCwMe12Upb3iEE0QFRYsi9J+KWY+2DJjrYNQE8Mxteq0f4U4/xxVO3an6wNNW+GUrt8MAL2liKy6viRYHtN4t6uu32G91+KJNUc+9fmW9UQNmsNEvQ6wOa+1Y2zaqGyFxB84ob9NttmZcnXjZoz2SV/cuchGby2SiROIQVRS2lU9bdr9b3UgjGZFDl+7magh5zfV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iXjkbUIuo2dOvYllZbPijikx8TYwv/+8iZOiPcWgLY=;
 b=ot8tU4hyScUORFKcz/2Hmbi49r5TWaiPL5p0H2Nm1zIurWyJ0pH3nd+/LOdAI77i3jE8snNGz41FBckjCN4QCQumnO1OeYlgkhPIo9KUcUA/CGrELTWJqSQ7+gEv5AxLxKrf3YCx/El+TwJWuJGmp6/R3zQkQKyLY/8h8GuljfHnNnr+5GBL+NZ31NIlX2TkLJtU9gsgRinXg/gsa4WmpxXn/oIcR7ufmjf9NseZxYxTGFoAd7kBjPalBLZBKgg9jY7608CJ7y2W22RKGd8EXXzDkfVzA48YzmT43Pzul77zDhpI+rJBOGzTuNSqcz2DHAw2m0Ae0dddp6h83/YChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH7PR11MB7570.namprd11.prod.outlook.com
 (2603:10b6:510:27a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 29 Oct
 2025 13:21:53 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 13:21:53 +0000
Date: Wed, 29 Oct 2025 08:24:14 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 04/23] KVM: selftests: Expose function to allocate
 guest vCPU stack
Message-ID: <6902157ec3cc6_20bb411005@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-5-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-5-sagis@google.com>
X-ClientProxiedBy: BYAPR06CA0067.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::44) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH7PR11MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d128063-301b-411e-58ce-08de16ee205d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vx4vxmYIqBn3BWt4KVWM/cVuE6ZZctKUX/uPpByFOzOV19igqEMt9nMLvX+9?=
 =?us-ascii?Q?SakJmR+7SomqEp+xyFUHSoxJY5FgpmLqiGVBINkQZt7jVnciPJv0PD0rS48j?=
 =?us-ascii?Q?fToIuDwaUeDDKPqB3/R+Z6NKewCWieH6zjZjnRRRNnxelljCYpQu0wXLiWWu?=
 =?us-ascii?Q?M3CWjoyrKijjs2HEh6rOw7xI2zbwIloROybPDYIdU21Scpc9a25cQugkKNRB?=
 =?us-ascii?Q?qdGISM2dF1jTuOMXgziefWZIztb6F5Jq3lQQxwQlYq9rvQzIYNuOaumcpzhp?=
 =?us-ascii?Q?Zb84jBGGw7FraHgdxbZ2lNhEkAgiS2R2DpoyLKk8EmawplE9QqkrsRjPMFPM?=
 =?us-ascii?Q?YeD1D0We5V1PC5pCQPy5VjjuYHdnQ5SMLNS1mX4WwIbmFEHcyZ2aFSSl6DNt?=
 =?us-ascii?Q?7Q+F6neRVNUiBboyj6KyqzIQu97bgHkFcGeZpZXlaG9eYQZk8SbXZ+2oYCpb?=
 =?us-ascii?Q?fLR9ZSEz2w1EvUQiscH6Paoag2XeL/mu08MvSiw7kQd0m3nKEpLg+ToTb0sX?=
 =?us-ascii?Q?sV+xYwFe6lHnIffIyA/h7RVfkvvfBJuktE6PhVcZ4Xr/1g40A+YxN/uTebEj?=
 =?us-ascii?Q?N8HAaBYQUmeYXsJ4d4UAaMIGooq4Yi+Hz4qZcU9n+uSJ0iBD+HN8+oi7hn+0?=
 =?us-ascii?Q?nff0qbHyb/faIqxSA1bbIsb0bAfSYd9GHum7YXUGAHo/n2Jov47ovjBSSIlF?=
 =?us-ascii?Q?K+AzghMBILlzh8vQvYEcpyy+Dg7Qmmhz1xjc9WxE+PTo5/o+AG62XNh5pusR?=
 =?us-ascii?Q?mX1mzSMytbox1rFMJmxrs1ti3PHhjjUldb3H53D69XqtA5+1ovAhK/QpRtmJ?=
 =?us-ascii?Q?Lb7/HAdeBfsyenAowalT3/BP5qqq0JfD16T4AOPoD2n2whSjFJqxWW/c+g0R?=
 =?us-ascii?Q?iyIOoYtifMEep7YjmsQZ6rjbOKU90qgTGYctrxaQ9hp4ghlHbeqTmLUOyFmg?=
 =?us-ascii?Q?VJy4IVPZGeaIiL+z/HzxkvEC51l/6Y4zkty0RCDhZa5IQf9HDuC1Ob1apPii?=
 =?us-ascii?Q?P9EXD/WUt1+EQJ/FCcLuWsrwkQso9uck/ZHQGxlNK3uDMKKMBDMfs3DaN0AM?=
 =?us-ascii?Q?XoOJaymQTDl7jYXShLPKjcTxKK/6holh5kpBcNIFCiH8kxobbCXJazrTZNRK?=
 =?us-ascii?Q?XzGqw1+9vJl0f3e7ZlhvDIf12qIW8yAN93bW/7ruNmGeV3srmWJg+UK5kNo5?=
 =?us-ascii?Q?QglSOXKjdJNsXWgsiq//y1ELI/pNr3X0YeAcCfK1zuQEfYFutjwOiMhkxbdR?=
 =?us-ascii?Q?UvCH0inAbe0JsXArh+Nd01TAUDLdy8GMZevB1FDhasV4ZVkzP/97KPG6KNsr?=
 =?us-ascii?Q?GPkdn7lHnpDM9T/cv+MQVQlDwatfg3mdGiUmf/GXs+46auJkVOLZv24zPq/O?=
 =?us-ascii?Q?7gE35UcG+Iwsu/Iw6j2JPX1Et47FolwwI33ahUxFPRkWqSZl1sGavkQQ9LUT?=
 =?us-ascii?Q?835q8YXb2/hOLhJs0BHtU5NA+E3SCMS5UqQZkZgq/DTK6RMInNvdbxIqz/ip?=
 =?us-ascii?Q?A/PJw9HCMgdtGUQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+bPPzLA4VPKvuheK3eux0UJ+myyz+C+R+ZNQpRHDpJNVu0LWWLzwPyp2eTc?=
 =?us-ascii?Q?kHZTZSwdaFd5fa1xaS+FV7NNxAmpJoE2+vWBlELemj4uA196+fIWJo7jP1Pl?=
 =?us-ascii?Q?U5qwCFt1uDmegoNq49u1LWKeILNm32ndRwLA+OibR2wsmSwwlXuby9aMIPXG?=
 =?us-ascii?Q?BlXoJ1t7J1aP4JyDC9NUKrOY2c5io1DLFslsJGSTeLJGTtYFHHI9Ug9KVLwB?=
 =?us-ascii?Q?I9TbYYyMin++rIuVtOktYe18eIz2UtGxeuwlm2Rix6e/PTmS9kgEqyQ9E07a?=
 =?us-ascii?Q?0J8H/Mbl+isAl0GRaVEWlwoikBx+plctEY+4fqNAiu1wcF1oTtGJLVtrNVvz?=
 =?us-ascii?Q?UuBxXSjeFWLEKKJIenauQ9oM2SWLxyzji4PR57ojGuNVBSiIJVktUymczp9q?=
 =?us-ascii?Q?M98hG+sq+inrFt+EdHpl7woIVFPzwb29gmLv3M5n2JjEreBupeGgA5jzQYoD?=
 =?us-ascii?Q?qSIaZprFluFIgnceZff98cCGkf25cm965bMDT++nYUHNxQEDHMzULQGJ5qEc?=
 =?us-ascii?Q?cIsfKlb/8AFFRkiHOPeP/eetHirHK9n/hiujX+zG7IMdaiFuMY1vU+EBkleT?=
 =?us-ascii?Q?UDfwELm0iSD8yGBp1ZiAn9OqMhrWw2K+Vuqc6QBkCWlCRfpLm/rS5uM6IGSS?=
 =?us-ascii?Q?iztroXoNyNd0S5iljR1iIxRnLeSwpsKMGvD+V8OxG8KOH52SkCShZhoraMIN?=
 =?us-ascii?Q?59qEcu2uXhaQdpX2VyHxY1PTUmH39vNhwrH1Rc4lZ42L5tPaPaARBb+356T3?=
 =?us-ascii?Q?0LT5o1uSSHsAGeoAXPxxoA/YTd+116a+OBS272aD9dFW6pGyOmEjZ47CU0XR?=
 =?us-ascii?Q?WQ5mOSlLQK2xPJGNvIgdgQ4ga305yX22z4t7hDZkY4b7f6r5HvKp8hw0lQXw?=
 =?us-ascii?Q?Vx5yfz8JBYf6tOAiButX1D/hkRhOHKJxxT53GMTjPWA3klMmaD239tUzGfpY?=
 =?us-ascii?Q?jrbIZVJUvaRXijizIbV+LXK0z+fOr6fhHlr9SShARhf6xzKiEJPaGqkMqGi5?=
 =?us-ascii?Q?G4fGIZ0MQpPDbbbQzuLYiyQOZvOsLm1Uq/PQrjFayrUNe3+LapoTY47ZnN0V?=
 =?us-ascii?Q?SGWnJCFMSe880BOcspdlnDHZhyw/H2ybSG9VVcSLkhTaS1Qswq/qJIwW697o?=
 =?us-ascii?Q?YIMYOA2q8BOHn9AaLIHRlDAsBYHPRvH5g7uNsc1Ur7DT0I6FOIUkjaBucy7A?=
 =?us-ascii?Q?GkqPGkfeedYzg+nqAvrUsCROlUNRuVafRCFmhUnY/AE4pJiZrqThGsDTTOwp?=
 =?us-ascii?Q?gyfLMpHl4BjGIDDGLKO70/lkuaaEXF60v/taGQdztsyydJ8d1hU6bsAOldSx?=
 =?us-ascii?Q?CNkzw0y2dQu3hQ6uawSev3Edrm4cfPxCymWfu6WIxPSKgm7vLcfbsyhjwqOm?=
 =?us-ascii?Q?AyR9g7Qm1Tykk4Ms0NRWsILjpfKZGvcc5SQHAzdntyhrxajvwx/cS42ivUio?=
 =?us-ascii?Q?J1VV77l51mHxUI+4xvC7LJ56PRiAXw0nMCKNZPQCOx/VIwTiBD73sS3thwsV?=
 =?us-ascii?Q?+Q7/6ncm/hBnZOri6nRewiUZZXIJBI+agigR/ZEthItr4vZbjTbpK4zdUIqa?=
 =?us-ascii?Q?64Wzma3MSI5pY3ybUxo6785DiZGtNS/NzfBpnsxH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d128063-301b-411e-58ce-08de16ee205d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:21:53.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa1msLD77BZLRvszWtjOKCz5u4p15FKSzFAGyrnjV8LSHWZ9BLchc/R3pOfI3NHbgHJCzMxlK1JPsUnFRXU4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> TDX guests' registers cannot be initialized directly using
> vcpu_regs_set(), hence the stack pointer needs to be initialized by
> the guest itself, running boot code beginning at the reset vector.
> 
> Expose the function to allocate the guest stack so that TDX
> initialization code can allocate it itself and skip the allocation in
> vm_arch_vcpu_add() in that case.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

