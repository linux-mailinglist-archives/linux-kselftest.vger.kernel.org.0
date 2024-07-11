Return-Path: <linux-kselftest+bounces-13531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E842492DE1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 03:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8CC282754
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24B321D;
	Thu, 11 Jul 2024 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwFZuUtM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A396D30B;
	Thu, 11 Jul 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720662183; cv=fail; b=jX0SHQpN+0BwyrAiZlTDFGFnYIJ9zcRb9YSn5Z7I5VcNBJLM13zp/LkY/Shv3QRN1v9XNUbD/NPxy8Kp5sdWEAIKgy3T4YovJxxSJqVfbZo6FhmjoipNjj6lwUyMbzEAiUNZtQnUES7fkLyrDhXmupCbii4y5gIU0bJCzKjbgEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720662183; c=relaxed/simple;
	bh=GDL0OI0Xd1Gy6zM8AfpokgPgCNokaFjTecKJDIO5f4w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LE9SSvrw7qUP7PUUUhACkiJZVSvo+3AH9PEna8db1wPkyMGt5ZI4cGsNRdvQoI0zqNTfvmfdHufgdDE6mpsegECcVSNVhZlW+Yva1anBM9eboYFEL17NKoxlsjGG1M+0SNGCp4hT79OJiCsGyO0biM/PLjjsrPgqgZDyjWg5GEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwFZuUtM; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720662182; x=1752198182;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDL0OI0Xd1Gy6zM8AfpokgPgCNokaFjTecKJDIO5f4w=;
  b=MwFZuUtM2wbCvB3J5+fZORguhooXZWWM1Z4CQ3EIgtRTv0JECSC9CDLH
   Yxov4UnNbWKavrDjwyPpSQtdgJU+9Nb/iZ/147PwJ60ODA13D1hO2Mykm
   utHzrap8yJN1N0G3/IsRiPFVlC0ZiZzRNAxTRc5T/JEu1vGCIbzX4hi2V
   RkTNJAGNVLXLCz7eWPtLs65uA3eILDAttJ5cKyK843yFTIMuGjW5E64UV
   lwvSugQpLhReh+4IbhzB0V82PROYn7Xyi2MvAmvaWwn/YXW3v5qJMtGZm
   BLBPqWy1FYi/HVWScDIpSjo3KOdck9OdWRNwqtbeGMRdcUeylPEMzkTlz
   A==;
X-CSE-ConnectionGUID: DghwaCqiSUilZIRQUZ4m7Q==
X-CSE-MsgGUID: FlB92zJUTy2Znqbu232fdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21893248"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="21893248"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 18:43:01 -0700
X-CSE-ConnectionGUID: 8K28g0fbQXOeohyhPOTBIg==
X-CSE-MsgGUID: khr2c1X/TZagUt2Yjp+irA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48292470"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 18:43:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 18:43:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 18:42:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 18:42:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 18:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3rAypRJAv8yfDVKKJjArgQFuNP+cBpdC0i6YGh7g4LiyFynCGd58c2pwlFlRRU66WK/GvaM3ABDPFXyX9TaAXXNACoX/K+R4qQo3JIJ7xhwZ6k+6yYH2ZWMM/XUvEs/Nq5XdqcdFJegVwcKMmxkvbF77eTrSaTSAr5IHf1ccNkSnIxiQwM6biAk7mdqOYbiRzAiDMChvOXU6yNrVlJ7GeAM/K2iZBtijeB4lCuAH8C33tq/JcjFO9ohCxX4KWKrMVEiK+t+Ikr8URFLMbn9cc+KeCWub6PMvcN0Yn4mJl5tXTmj9c5zptE3YO2jHCC9WqQe1UL/+6HNILbJ06Kp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxAUe3K00n/uVDXK8N3jFmcmvqhI8UsX27Qb7Lv11QA=;
 b=ezWm7rygssPSGysyqh0HmnYo42O8rHfk3DEghcje2LslUvEif3kAspTKOtLT+9GgzVlb03mFLAuWiuHWX7f88Wt58YOIW65PwbfqthXmWQbUZ3EunGa4/qq4OcJ0W69DQHAHUtDqweVSjGbaXqYikQUVSjga2zGNbaWXO0dvJDLlb0NP0NZkGKZdR/UFlBdgaVgrpUFKftseaIdtbmxwaqekhV7uPY5rvr18ikxTddDTCNIVMq8uw5RyBc5GNhuY52AsU/S5QhroKC03Thcarnra5MmgukIIFmQFa7jmf17AMG7051xiZlp5RVTWwQ1J0GNPacP5TTRW/X46HCxIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 01:42:52 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 01:42:52 +0000
Message-ID: <097e26f1-bf30-43ab-a65b-25a3062f92d5@intel.com>
Date: Thu, 11 Jul 2024 07:12:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
To: Pengfei Xu <pengfei.xu@intel.com>, Shuah Khan <skhan@linuxfoundation.org>,
	<shuah@kernel.org>, linux-kselftest <linux-kselftest@vger.kernel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>,
	<sathyanarayanan.kuppuswamy@intel.com>
References: <cover.1717137348.git.pengfei.xu@intel.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <cover.1717137348.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|CH3PR11MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 2067b835-0223-46fa-aa4d-08dca14ac762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG9vbisrOWkxVyszRXBQeDVBcUNTcG5mNFdWdlNQUVhhZjNSWjY1R2pxREdH?=
 =?utf-8?B?aXk4cThFandXS0lHU1NwenpPQXJZZ1gvQXNxN1pkRXovaVpDcWQwZ3RHUGZa?=
 =?utf-8?B?dkcvbFAya2gzZlNoOXZtM0NhWU9Qbjdad1hadnJUelJULzNaajJEMnRBWnk2?=
 =?utf-8?B?eFpGWDZ2amYxcnY0VmJ6bWt1RkJHNW8zYUF3dUd4S2tJMnFlNDg5aUxjZzNu?=
 =?utf-8?B?eU91dXJaOWVuRTlIM2dUVk5VQnlJQXpEaEZwRmVFOEVWZGlXTDhHdTgwN0FT?=
 =?utf-8?B?SDhnTzhGMi9oRkMvckpGUEFwWDIwZUNXQTl6REc2UC9ka3ZDSkhzOVphTWJT?=
 =?utf-8?B?NkQyaVVDNGJjUkdSZ0hEN3NQRDNsSG9tTWFBaXF6a3hZcVVPdnlBd3hRNFF0?=
 =?utf-8?B?S05rNFk1czBmVGxWRVpCNlp6dnNvazErVFNOV2lmaWkwZy9CSkVPRk1qQ0ta?=
 =?utf-8?B?TTRoVWxzdCtlY2RSMWNwTUM2Q0I3TkdzWmM1NmlXOFh6SzZYVG5SOHRHMlF2?=
 =?utf-8?B?aGhkaEo1OVlGUFF3NU5scE9obGxDZ25HWXlWUHE3MXJxRndqY2VLTWEzN0Jk?=
 =?utf-8?B?S1NhVFpNcmdEa1NPNENPQ1VtQ2pmNGRaM1pkVngvdS9nZGJQOEJ2RjdaOWlT?=
 =?utf-8?B?c3pVQTEycEN3RG01REhnSWtsU2V1WmxLWUo2OW1uT2tNblNCamJyY2pBNXZ4?=
 =?utf-8?B?dmtIMlNndjdjWlA0R0YvMGZ0N1BUb1FRZ0lhdXN4TjIvVmtINFRIR1BRSzFV?=
 =?utf-8?B?cGdKQXBWbHlGaGRTZXJ4d2xEVVJSR2M4eG1iSSs1WmVRL3VZVWRCdTBWb2wv?=
 =?utf-8?B?NUJUMUc5cjFidUlYeUJRU1dhQ28wbTFyQndINEt3Rm5ZcC9WL014L2pucC9k?=
 =?utf-8?B?bjQ3YTRJYkhYNktUdXNjS1l5ckJxUlduTWNxQWxSd0lyVUg1bGpGLzluVERH?=
 =?utf-8?B?WXRualFrbkNsakpwZHluVWZEYTRuTGc4Y3F1d2Z5enN3aVJBRXV0cllDWUtj?=
 =?utf-8?B?TGxueG9KNnU2L3J6aU02djllaEpyS1dxK2xpd3lPcVVBQ0hIUFVDQlhKeEpo?=
 =?utf-8?B?ZXB1N0w0WHBad0MrUUdzaW5leG5qck5uTHhIT0NFc3dlaWdZWGpvT0lrYnNy?=
 =?utf-8?B?cnBaN3d5Sy9wVTVGSFQwZlhtUWpvblk1bm8rbElQS3VBVmxJaUtPTVlnYTRW?=
 =?utf-8?B?WXJwdkg5QXBZYXBGcVJzY05Bc2RlcW1Lc2I2N3Q5T1R4UWZKNitNYXNaRzg0?=
 =?utf-8?B?M2x4cGh5ZUFwUWhFQ1p5Z0xBZ0RjTzNGbzlYd09mTTNjd2lrNWM4M1VaQ09Q?=
 =?utf-8?B?WUJXRXM2T2tXa3NENEhiUk9PRWVkSlNwQitFRDI1SFd6SHE5dmtHeU5SNjl3?=
 =?utf-8?B?Z2pHUlRZWWswUTVEM1dhaDR5ZVhqM2lNdGZVL1U5SjVKRVFmWGNCUmVIRXRX?=
 =?utf-8?B?SU0vVjJ1dVFCa2sxMWVnVU5OYjJKUEdoZHVJOXpwNFFTWlZvR0pYaUkzZC9W?=
 =?utf-8?B?NXFGR0xRSllHa0NmMSt6YUZWeTEvdE8zdFVLY0tkSFBuTzhTTmVoU1Z3UCtk?=
 =?utf-8?B?Vkl6U1NUQWRSSHlEWVFMZGV6SVFrSzYvMEZ2ZDRydm43YldmOTliZTRYTjZ0?=
 =?utf-8?B?TzJFUkdLSmpvOVNWYURGZkFSOFYxVHRPWHBFZnZJRzkzUzRDOVJERWZ5TzBE?=
 =?utf-8?B?VzA2eWJvamNPZ0x1ZXFUSFRsMzdkZ2R6OGc1czNaU0t1OW9WYVEyY1I3a2N3?=
 =?utf-8?Q?gcfxIjRLu8cV64inuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVJkSmlWRVJ1ZmhYU01sMUQwM3V3T04vTmw1MFM5b3lZTXJNOXNUQWxpYm10?=
 =?utf-8?B?ZWI2SXRJM1VhcFEyeVNSL2lZczFTcGU5YlFqZTJRSW4vbVlvNFoxT2tZeTV5?=
 =?utf-8?B?aGJacHhJYXc5SWFIR2ZRekQwcWlRU3hON1oyVzNBN3F3UWlHSHZTaGd3OWha?=
 =?utf-8?B?czd4YTY0SGp0cEFHV0dHVUNNNjNsQXdTMGlsOG9VSk1rcmJzU3NXTTU3QVVT?=
 =?utf-8?B?eWlhUHA1cUorTlZva2IvU3g2dkMweHJMOGc1cTdQQUVEYTNOdXJCVUpFN1NI?=
 =?utf-8?B?S00xVmhHREUvdW0rYjk4eDdwVE1aZ3VTY1prYXFndU9tNklZc1pHRDdBWTFG?=
 =?utf-8?B?aFhrdi9yeFArOEVaN1NpZHVEZWp3V1F0VFowY1RxdTFRNEt0WFh0U3oxbW9h?=
 =?utf-8?B?d3krMTFETWpOYWpYcUVKNTVHL3RibDVqTXdtbm1pVTFQcmVSRUgwUmRsbjNu?=
 =?utf-8?B?eTNYYnZKTGsvYVI3Rmsxd09tV2dzWW5RTElPdWFINGcvd0VmT0xLUlVDdXd2?=
 =?utf-8?B?MmVMazZVcXNvTk5xSWFsLzhRY3VmUERjM21LdmhZRUJCZFovVUJhd3NCMWZ0?=
 =?utf-8?B?MXo0TFhVV3dxOFpKT2czZ3d2VnBDdkFQMXBtcVRBUjZIVGlPbUpLTi9lMTU0?=
 =?utf-8?B?enVESlg3ZWgrUEI3Y2QrVXJYWXgwcDlqZlZjZDFvUW1EUi94QngvVmNyMUVO?=
 =?utf-8?B?SUZVRlh3cFNhZUhtNUJtMjh1eU4xTVJxMjBpOWt6SzNpN0xoTjFsakpEUDlq?=
 =?utf-8?B?WSs3YnNDeGJ5OEYwYjdkQ1hhZjZEYlFwRXhIQVBMUDNsRUx5TCtreThPblhT?=
 =?utf-8?B?S1h0aU9PNWtZamVvU1VRbmo1clYreGFsTnV1RXgxTm8xNVpsNzR5WGRZczlE?=
 =?utf-8?B?OG0rcmFBb1JucTIwTXNTWThRaHhGRTlCYU4wN3ordHNxaFFqR0dPc3ZpUnBJ?=
 =?utf-8?B?MkorckdyWTYrSjhXWnZQaG9qSzVmTGQ3TEJDSjVsNHRYZmgvUW1ZYzFOZlVw?=
 =?utf-8?B?Yk9TbVhlZWlEbHdUZkowY29kOTI3V3N5QUpaOW02ZnNJaUYva0R0aUp2cmRY?=
 =?utf-8?B?V2xaWXJMWFdCS1pTUTBiTGo5V3NwU000d0NVMHpGTWdJb3NYNkJtMk02dFNL?=
 =?utf-8?B?TmtuRllDSFVQSnJKM3pPZ1Q4aXRGMVhHMWZBSzRkUkVnVk9Nb0FiaFRHYkhS?=
 =?utf-8?B?em9HMXhFdWVPY1FkdG5TTFNLVnhEYmVkZUlkb3UxcnZwaVdiS1htNkF3M040?=
 =?utf-8?B?a3ZNbStvMnFJYVhVRE0wSW1QTEdMcFdHQS9Qc1RKZHc0Q3I1VzA3eXZBNVRr?=
 =?utf-8?B?cGMwM2dHS0NLTnlCZkYzb09SUmxQaHVLK0J0d3RySVROQXVEWFNQZm8xL3gw?=
 =?utf-8?B?Q2pqY0hRWmRwVG95eXBUYWdwU2lBMnRZWSs0ZkorVEFwRnlLOXVSWDBld01D?=
 =?utf-8?B?bGhLVFI5U0dhZ2J6TUFvU0lwbGFLVzA2a1pkVURhU1pMYnYxL3BaUC9scGlD?=
 =?utf-8?B?OVF5aUkwVWZydFY1RkNLTU1GSWlGZ0hhTmJHUHVJZmJXbHRjYmpNeTI1OXVM?=
 =?utf-8?B?U3VPRXFiK0xpWHRlSVdyaHNtSDNCVTh5THVqSkJEUWhBeEF4alloU3lwM2pV?=
 =?utf-8?B?bHNVVnlQbmZlVzZscHA4OXpCUDFhTmFvQjdvUndTNkg0UXJObmZ0RWVWRkZp?=
 =?utf-8?B?NTlETnc0MzlqamlVN0RXdmkzUXJFam04RnlYNlN1WHFFemVSOGNTTmNnWWJh?=
 =?utf-8?B?aGNNaFpnU3dtdW51TEZFeEF2VStsNGlFZ0hPN085cTM0UlFDOUdDczJrM2VC?=
 =?utf-8?B?RWJyRDdMckMxR2lBWWJLK3lPOU9BbTNsaVF2bFFGb3FMbXgwcDBKcEFYUGRL?=
 =?utf-8?B?dkJPRnpwb2xWaFpxZzV1L2YzLy9OYkhJbWI5UVFMa0tLcXBVTURDNWdDb2tr?=
 =?utf-8?B?TGZLci9YVGZ0dzZHV2EybnVqQlNLaTIzSGZJbG5lVnJnTUpwWWx5SzdTU2N2?=
 =?utf-8?B?dHZHSStoZzhOSVRUdklLaVJZeXpKdldsK0wwVHlCRnhINFR4OFhINitDdzh1?=
 =?utf-8?B?VUtmTURxaTVpcG1IWm9OU3FHZWY3QkNzbVNvaHlsTzUrb0pwZjdybEtBdXJY?=
 =?utf-8?B?TUFCaXRwaXZ0WTVIUnZJVTVqMkxzMldWeGdnRlFGa1RocmtDZlVpaEJ5NVQ5?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2067b835-0223-46fa-aa4d-08dca14ac762
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 01:42:52.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txkKM2tYpU1z1AuLg7zUFyTme2AXfF5eRlDKTyE5VCajtyRWbXQY/3PV6DTtvtCnMxiVapM4m1zPJLxTOBsxBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
X-OriginatorOrg: intel.com



On 5/31/2024 1:23 PM, Pengfei Xu wrote:
> To verify IFS (In Field Scan [1]) driver functionality, add the following 6
> test cases:
>   1. Verify that IFS sysfs entries are created after loading the IFS module
>   2. Check if loading an invalid IFS test image fails and loading a valid
>      one succeeds
>   3. Perform IFS scan test on each CPU using all the available image files
>   4. Perform IFS scan with first test image file on a random CPU for 3
>      rounds
>   5. Perform IFS ARRAY BIST(Board Integrated System Test) test on each CPU
>   6. Perform IFS ARRAY BIST test on a random CPU for 3 rounds
> 
> These are not exhaustive, but some minimal test runs to check various
> parts of the driver. Some negative tests are also included.
> 
> [1] https://docs.kernel.org/arch/x86/ifs.html
> 
> Pengfei Xu (4):
>   selftests: ifs: verify test interfaces are created by the driver
>   selftests: ifs: verify test image loading functionality
>   selftests: ifs: verify IFS scan test functionality
>   selftests: ifs: verify IFS ARRAY BIST functionality
> 
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
>  .../platform/x86/intel/ifs/test_ifs.sh        | 494 ++++++++++++++++++
>  4 files changed, 502 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
>  create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
> 
> ---
> Changes:
> v1 to v2:
>   - Rebase to v6.10 cycle kernel and resolve some code conflicts
>   - Improved checking of IFS ARRAY_BIST support by leveraging sysfs entry
>     methods (suggested by Ashok)

For All 4 patches in this series

Acked-by: Jithu Joseph <jithu.joseph@intel.com>


Thanks
Jithu

