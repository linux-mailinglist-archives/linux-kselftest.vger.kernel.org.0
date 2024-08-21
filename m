Return-Path: <linux-kselftest+bounces-15928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50495A6CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19B5283556
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1143175D4F;
	Wed, 21 Aug 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwrJJnXX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FC13A3E8
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276299; cv=fail; b=IbFtrzzOfWV4J7ULudtPZsCsgMgZ5wW15qsiJg3mG+kfUNA+7DHzmKTcfqtOySIY1Rg8XFzpXTjgZwt8pxAVi+irUv3JHnX+yXSvYxtC2yKY5uuU4VK0SW75MdvU4mgVHFBfG/MdslrM2c/6owFA0v9SBLJA7fJcNobCpBKHjr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276299; c=relaxed/simple;
	bh=b61wxgBmV/n2CjrCDJNueot3eVUJJX0wS0hHOQLYf6A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g1egX/rGnAyHzP5oSvAoPWP31XHwlnlYWmRLXPf4BpJJAsbOav4RW4+AE0GMxfMwfHX6nBm/Ayg4ptCoVgdtruqc/RAs4Brb0VEK4J+aski6aNlCSxtWdKBxnmIuTD7vM8xG9burvF9jho2cP5H7O28XSEDeWci0uXSPN/GrHOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwrJJnXX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724276298; x=1755812298;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b61wxgBmV/n2CjrCDJNueot3eVUJJX0wS0hHOQLYf6A=;
  b=mwrJJnXXCM+LOVjkJEFw1e83V9VAE1xNFdRvJ+W/6OThpxmnnlOxTD8W
   JAQcoPR9sRxkse4s0jIk+hs+xIWaZXcDaDuY/89AVrPvHTmgirV/aI+F6
   Mk6OXkUZNM+uNFNCXnHoynWAg6w7DSq+Z1Fr9XAkQp87emCJSGKy43oOH
   ZWK61NWdXtkpQfd/2XN1/vnTQHH9m5aH3ZinIa/CNlNtOndC6/EBoq5kG
   Rx+fdyGKkIn3uzfdscOWerA6RynBDhr/AZsxbYeqdLOLoxr1jAoSYxi8H
   i7Tsn4b5XaqyJCAMLCVQTT0DUYnRkBJpNlya6il00ZIyBJzuZf5lolDE5
   A==;
X-CSE-ConnectionGUID: tlRRHIQpRfSyXFgFe6vNLg==
X-CSE-MsgGUID: c0qNjAtcTTOAINhkHq9x3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22812639"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22812639"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:38:17 -0700
X-CSE-ConnectionGUID: OaEoG24OTYORfjOtakFSFg==
X-CSE-MsgGUID: crMRXelHSuqPjC1JnA7bzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61755263"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 14:38:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:38:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:38:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 14:38:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+H9a6ydE5beu/w5RjTe7XFBU+9i27cNOVAP8TlNosRzrOKagEBD4tEgfQk6CQjcpd8N1VZqCRFopbwa4coCFS993Uu27/pEgHc2X5XcFbIrBwMHaL0dxDaZXYLlrssEPIWG4WUqSuhCXyk2kLx8jtBO/WSed6SYWmdVJJewaeikI7qqG2/yF0ekWwdgXSozH7johw9h/2uhVZ7KfAgwLJwESzWyLfQBiEN+e28ISs4XEe0nSL9UoWRklvn6PohuuTbqszkG93vdt4N7YMKEk34g3zNEkjn9doUsmM72Ogse2258zlFqoLqX0+Nx+i+9TFKD8aJIlcbuVMOAh1JXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSjQZzNOWNbKc685zP4HQZcZUaqo2iactc/w14G1d0Q=;
 b=W8s3ed/JvTbL3Wg5hdluh5btNwouOzyBvmMB0RhbAujemeAyyegU6E4f53K0jP7h80CX7X1mJGjwud+Qpb+xWVh90QJPvl4Ef8GYGzF9Auguuy6MnxGYFwv+yi/IEzM6vjvNOx8nCovGIMilSqBlXM/B1Q6n4AW6gwoY9lrXjk5h3e7buh/xTDS+WQ0g06KVgCsmmfmktVEdCXfEzgij0qWkM6Y4X7Nerm220YDaO4f9IDV4M6Dut3/+D+LhiY217YXI0IYNZvguOpGmiKVtiyzIBSPIUxZIKlxQuUYGutH8BhS5eNZmWkZZWL9ZdY70w8ykyXV9IKsUbuD2Xub+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 21:38:03 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 21:38:03 +0000
Date: Wed, 21 Aug 2024 16:38:00 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, David Gow
	<davidgow@google.com>, Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH 3/4] kunit: Allow function redirection outside of the
 KUnit thread
Message-ID: <v2fowtjqftsv25tnbtaooi72chhjo3rsw575vc5wkag5wpw35w@fnz3td42tb3s>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
 <20240821144305.1958-4-michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240821144305.1958-4-michal.wajdeczko@intel.com>
X-ClientProxiedBy: MW4PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:303:dc::29) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: d634879a-309d-4177-486a-08dcc2298940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xr6MxKkUs6JljJa7P3iO6O/TYMEZhtPF/bK5HSmNNBjEjm6TjEyI9Pyq3DP/?=
 =?us-ascii?Q?Hvs4CrzO/BnxBo91Oqm/iwpLBxM4dOJ2VZ2p7RranwNVMU+PHEOtSC7ZaZKT?=
 =?us-ascii?Q?0PgbsrTqqHhcsCapdajPXH/JQqDfKcAxW0H3Qjr38mOhzwVesvEPx5no/PzZ?=
 =?us-ascii?Q?SOHiccAdF3t8ousNS+M9t7y63nD71I3RehZzn+h50RduKeOOlAZkWI3Dr4Dz?=
 =?us-ascii?Q?2aUXTN1Sw6eneM8kjrFyQmlpANaezfbVlNFrzgpkyT1LI1KD7mz/aM8nw48F?=
 =?us-ascii?Q?ousTq80qrtrnIjStSTKG3lJSHY1SpFYKSDaCr/8MMJ3eplV4k9uCEHqglwTv?=
 =?us-ascii?Q?WFTR67bSqohH4AO4M/ALtUpeUIOV99ibwAmsJkhIV5RgMtoJGPLtFBpOPMUS?=
 =?us-ascii?Q?vEjRvzePqQrahAD14VXQN1dOyBPu4lWq9MKEp1uoxCbkf3hxXmX5z+ENMiPr?=
 =?us-ascii?Q?r+thTv31U/vkDKZMx9E7OYcUqiJmx6KyZkuixLJb/6jEC0G8n5Nwa7AVccCY?=
 =?us-ascii?Q?F8webiwwEFhb1KPu8jf76nvzCunjX2gjajKXUBpLOCGauDg87SzLS2WS/wbz?=
 =?us-ascii?Q?p6qvNZyVc1jCv0RZ5Tt58ujXzCxAFDrSzn5SsrL1VF88ordUnLN0VodfBAB2?=
 =?us-ascii?Q?TU5xMuUJKOrbrTHMuqz4mwMhhh5Cp3HS+aSYzIIsEE3NQH0wAR34iN0FG9CT?=
 =?us-ascii?Q?/SK9SBvUVmFWk50+wBxJAAaSKQcn0mhE1G4LwroYJSAu83Wze6a1xOrgMlPm?=
 =?us-ascii?Q?6zqRqPMDfTYoOOgEwVToUmSkNgh48dTs+lhpF1qZgDr76qycV7wrHv378a+k?=
 =?us-ascii?Q?PYaQmTaltpkfDDsdbWSR6SX5kXimyWF2RdqZNhihoLyluuJXU0sq5UjgruRT?=
 =?us-ascii?Q?+ZNdf03zybvtSKbcHTiJqoKHLteYkO6JzvbwSI+DsqZlIcVdFewobj8hKE7J?=
 =?us-ascii?Q?chGxcHBN3Gn/mzXzdQ4H3smaBMVStZFPSwNfdkYT2BxBhfCuZ816DBnSneqS?=
 =?us-ascii?Q?IYix4vuT3Sh+ehPkEybqzsNc2zMJVKoeN772ZP/0WFru0D9u6dNKPGuSzjdz?=
 =?us-ascii?Q?nLmmaq02EZ4Pba7BBBB0zZHd0znQnE4bNKeZNWH4/tJNmg3KnjiRz4vh5tbh?=
 =?us-ascii?Q?PR3WuaXZpxhQHOwW2XMNKfn3PwNC8IQYlIIZgONquLDH9tvcvHK6zLRbcH25?=
 =?us-ascii?Q?JzmARqjaJv+L1fZkNmt65cp7OfXe48FtXJF68/sCwHEI34nN6Wj0I1v60gVP?=
 =?us-ascii?Q?vKdKv6XnpiC7y2Ksd/vMzuh1Pz/A+AN46k79ukZTyNp400EitUFEdNU1K757?=
 =?us-ascii?Q?CYpwKroCkzqaoc59PSb0TR48qX8zRaPMRv3sTNbY/OI+eA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOivPZdRmetuXdokWwRYVTSzD+DVYmNOVeXviKFDVBNKJvnBC2fk0q47nH5l?=
 =?us-ascii?Q?YOF3tpOFSHTOM7CgOCtO75TDknyklkAMsgwHVO9EQFHfSeN+On9MFCEdy0i9?=
 =?us-ascii?Q?chljUcn9F8sUEt60DILZYwlvT0k2ioyfqs1Tiz1nRvEoQYie4PVhr2IKv/B2?=
 =?us-ascii?Q?hJ4m7oO6RCXW+gjhZ7RPv6jJr5ghE5EdVrCCqLgAfL4Ptt/gPcKP1r3rgtBY?=
 =?us-ascii?Q?U7rlsVuLdiV577kpClR6SXeWChEjBsgIA00fRMZqfqLVYJhi43B5LpjfEEhd?=
 =?us-ascii?Q?qMqErvad3W5be4mp53aV7vuptxqpTRiaR0YmHS4p93HZ3j/8/yLVpjYH9vbV?=
 =?us-ascii?Q?/3S0F0uOQ1zA8Di1Ku9JAu7jA8gSehtD3gyJWktTboBHVbRBPDQt1QPlXi1g?=
 =?us-ascii?Q?uOuX17tEW/R0qDY5+vTt71GqPd9CPn64typ7EvyAGrwkDpsCZEyNRDnHM+0D?=
 =?us-ascii?Q?mgugGqoI6SoG+c1di7dcq7D/WdEUvAHft3yS5nLi49XqYU1mPjKo0eWvMxzL?=
 =?us-ascii?Q?knzRgfuaS7euvFiGSPDUZAl2KpettaVi72yqa+RlxFadXmp7AHjPyk8NAP3m?=
 =?us-ascii?Q?1mf9daXiuJSx+V53r50rAYtOHW0cq+m8WviRVEeuCVACbpm066vSnu5SPmMo?=
 =?us-ascii?Q?tGPEdut5qMCuS9uYLxZOkJklb6T44hK0TSuZIWBZJHuSXvPlc1ibuOK/k/fq?=
 =?us-ascii?Q?H4kzyyO6jrIBIcT1ILaCkgtWCt21zgPP3N/Byiom3MZznTOcUSELGmQ+lrJN?=
 =?us-ascii?Q?lGsPGthOLI7nElrHnposDd6m70man6RQcwcOpz2OA/FN6nlsl7/226phNx/P?=
 =?us-ascii?Q?uNH01oSH56+mWVewe67Rin8YNCNf4TB9qys6k2rkCopxCnO7qeRoNl5x8ebw?=
 =?us-ascii?Q?4V7qbiNqSVYaCQjGnh1GXARNdp/cT9KKxPL2zPQTeDC6xBetjSjmple+6kKX?=
 =?us-ascii?Q?gbxPKPomyZM582dXS4WNO2BHOFEUJGiErO8LC4yUHovpHJmEn5Fw3/o1IHQF?=
 =?us-ascii?Q?5kavNMMWcM9NIiMU/hULGZtj3pIFuaMefK2ELZaPO60sYFpzg37+J+2OgC4Q?=
 =?us-ascii?Q?MnrXElVlWZ5MpkNPNbiBbFJhcw39u6g7NM1P2seCbGWKY9z05+SyHVVt6x+n?=
 =?us-ascii?Q?bW0DwzpJMyl3LMslHltwpctFL/W/JnyTmUI0ZliLcmQkHAagpuxQRxfDGFQS?=
 =?us-ascii?Q?X9uzVXR987KnaT4Nm7pp9EvxtbsAo1eIrTARrAP5LqUSsNNwILn25Onbr5+7?=
 =?us-ascii?Q?+WnlvFARoFYybaAHpwrxKjAdpA+gWOwfUISo+t2HFdL1Vk5K3meh9cCCKwN6?=
 =?us-ascii?Q?JKLSx5bb91A+S5SC10qaRP6Sog5Ja32rioY4NuF+UkTIL/0iXP14rvZdIDfi?=
 =?us-ascii?Q?EKwkQSDS6JgaoU5rYdKjykPe7Awv9zmDucKXtXnsyCW+vXdCNetrDyw5jGFK?=
 =?us-ascii?Q?qSwfnEqcAHSDiOuOZQ1mpYCd8P7FWCDipcDrytEVRMjz85BoIt7FkgKmeazg?=
 =?us-ascii?Q?oO4Llzv9bHHH88AoyE4Y7+0zKsuwLYrUz7oaw26DCoAzPXqjxNNCbjz5NBQk?=
 =?us-ascii?Q?aFQNxuguDNtVzAOE6yhtqXM5/VDAAe8n+3EYHrzJn+yJj//ecaPMvVYRxd14?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d634879a-309d-4177-486a-08dcc2298940
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:38:03.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9I8IdHL/UQiUBdm6VfOIc+E9AtqAfLgS7fSqebbs9/V/76U4fNjLY8Qxj7hTzSUAk3gQDkEEMxr9GjHwpR+KNye+ykN0S3VMyIyWC8X4SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com

On Wed, Aug 21, 2024 at 04:43:04PM GMT, Michal Wajdeczko wrote:
>Currently, the 'static stub' API only allows function redirection
>for calls made from the kthread of the current test, which prevents
>the use of this functionalty when the tested code is also used by
>other threads, outside of the KUnit test, like from the workqueue.
>
>Add another set of macros to allow redirection to the replacement
>functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
>affect all calls done during the test execution.
>
>Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>---
>Cc: David Gow <davidgow@google.com>
>Cc: Daniel Latypov <dlatypov@google.com>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> include/kunit/static_stub.h | 80 +++++++++++++++++++++++++++++++++++++
> lib/kunit/static_stub.c     | 21 ++++++++++
> 2 files changed, 101 insertions(+)
>
>diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
>index bf940322dfc0..3dd98c8f3f1f 100644
>--- a/include/kunit/static_stub.h
>+++ b/include/kunit/static_stub.h
>@@ -12,6 +12,7 @@
>
> /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
> #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>+#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {} while (0)
>
> #else
>
>@@ -109,5 +110,84 @@ void __kunit_activate_static_stub(struct kunit *test,
>  */
> void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr);
>
>+/**
>+ * KUNIT_FIXED_STUB_REDIRECT() - Call a fixed function stub if activated.
>+ * @stub: The location of the function stub pointer
>+ * @args: All of the arguments passed to this stub
>+ *
>+ * This is a function prologue which is used to allow calls to the current
>+ * function to be redirected if a KUnit is running. If the stub is NULL or
>+ * the KUnit is not running the function will continue execution as normal.
>+ *
>+ * The function stub pointer must be stored in a place that is accessible both
>+ * from the test code that will activate this stub and from the function where
>+ * we will do the redirection.
>+ *
>+ * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
>+ * even if the caller is not in a KUnit context (like a worker thread).

not sure about the name FIXED vs STATIC. What about

KUNIT_FIXED_STUB_REDIRECT()
KUNIT_FIXED_STUB_REDIRECT_ALL_CONTEXTS()

?

>+ *
>+ * Example:
>+ *
>+ * .. code-block:: c
>+ *
>+ *	static int (*func_stub)(int n);
>+ *
>+ *	int real_func(int n)
>+ *	{
>+ *		KUNIT_FIXED_STUB_REDIRECT(func_stub, n);

what I don't like here is that KUNIT_STATIC_STUB_REDIRECT()
uses the name of **this** function, whiel KUNIT_FIXED_STUB_REDIRECT()
uses the function pointer. I don't have a better suggestion on how to
handle it, but this looks error prone.

>+ *		return n + 1;
>+ *	}
>+ *
>+ *	int replacement_func(int n)
>+ *	{
>+ *		return n + 100;
>+ *	}
>+ *
>+ *	void example_test(struct kunit *test)
>+ *	{
>+ *		KUNIT_EXPECT_EQ(test, real_func(1), 2);
>+ *		func_stub = replacement_func;
>+ *		KUNIT_EXPECT_EQ(test, real_func(1), 101);
>+ *	}
>+ */
>+#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {					\
>+	typeof(stub) replacement = (stub);						\
>+	if (kunit_is_running()) {							\
>+		if (unlikely(replacement)) {						\

probably better as `if (unlikely(kunit_is_running() && replacement))`?
Because we are likely to use one specific replacement in just 1 or few
tests from an entire testsuite.

Lucas De Marchi

>+			pr_info(KUNIT_SUBTEST_INDENT "# %s: calling stub %ps\n",	\
>+				__func__, replacement);					\
>+			return replacement(args);					\
>+		}									\
>+	}										\
>+} while (0)
>+
>+void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, void *replacement_func);
>+
>+/**
>+ * kunit_activate_fixed_stub() - Setup a fixed function stub.
>+ * @test: Test case that wants to activate a fixed function stub
>+ * @stub: The location of the function stub pointer
>+ * @replacement: The replacement function
>+ *
>+ * This helper setups a function stub with the replacement function.
>+ * It will also automatically restore stub to NULL at the test end.
>+ */
>+#define kunit_activate_fixed_stub(test, stub, replacement) do {				\
>+	typecheck_pointer(stub);							\
>+	typecheck_fn(typeof(stub), replacement);					\
>+	typeof(stub) *stub_ptr = &(stub);						\
>+	__kunit_activate_fixed_stub((test), stub_ptr, (replacement));			\
>+} while (0)
>+
>+/**
>+ * kunit_deactivate_fixed_stub() - Disable a fixed function stub.
>+ * @test: Test case that wants to deactivate a fixed function stub (unused for now)
>+ * @stub: The location of the function stub pointer
>+ */
>+#define kunit_deactivate_fixed_stub(test, stub) do {					\
>+	typecheck(struct kunit *, (test));						\
>+	(stub) = NULL;									\
>+} while (0)
>+
> #endif
> #endif
>diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
>index 92b2cccd5e76..1b50cf457e89 100644
>--- a/lib/kunit/static_stub.c
>+++ b/lib/kunit/static_stub.c
>@@ -121,3 +121,24 @@ void __kunit_activate_static_stub(struct kunit *test,
> 	}
> }
> EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
>+
>+static void nullify_stub_ptr(void *data)
>+{
>+	void **ptr = data;
>+
>+	*ptr = NULL;
>+}
>+
>+/*
>+ * Helper function for kunit_activate_static_stub(). The macro does
>+ * typechecking, so use it instead.
>+ */
>+void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, void *replacement_func)
>+{
>+	void **stub = stub_ptr;
>+
>+	KUNIT_ASSERT_NOT_NULL(test, stub_ptr);
>+	*stub = replacement_func;
>+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, nullify_stub_ptr, stub_ptr));
>+}
>+EXPORT_SYMBOL_GPL(__kunit_activate_fixed_stub);
>-- 
>2.43.0
>

