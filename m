Return-Path: <linux-kselftest+bounces-15925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A395A68B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61B11C2265C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2627E16E873;
	Wed, 21 Aug 2024 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/q9Jajw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545527405A
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275500; cv=fail; b=f3TGdFDIEvTMVCJwRiImwpTdtgiIkMxEYiXAYco+K78uSHhekAHqf/d3J5YHgYHQJ+KQsGMRdcdFzhTd51l3SysN05yQq+Ih73qzpsJmOL60KRaWol+0lPIWsTSDYusu6jq01QhBiuwWfuW3/Iqjbw4ERrFN5I5XUrFhJLqqO5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275500; c=relaxed/simple;
	bh=REnojlVEB1l6iHt+92kgz3+ZdVQ+loGT0uPLcD0o9ok=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JR43hDiGJ4CtBCn10xaM83uBrzQugbW1wAAp+3izEBNhnSeD2JyU52BjhJXav3FQ1Zk1QzSNEzlD+Cs/2PTepnoc6/h0wHhfBDPJ/u8d2Bw6VFRfEayGW5l0SIAh6aXlZYc7e1cMrJ8Oldsr80Uvkds1RZapPJdGkLslw8VLA6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/q9Jajw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724275498; x=1755811498;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=REnojlVEB1l6iHt+92kgz3+ZdVQ+loGT0uPLcD0o9ok=;
  b=F/q9JajwHoEki/T1eSoErKpGn2BzNWTCF9nseCyM2CzNyp/5M2vypOu8
   9aPlRt7TKpSesXAYe+M1Ozi/TU1asILPRPQLPkfYQGT6nNkgJ0QFHm6GW
   67V+udwzqLvcgh45qMj6vWbs1p87QviooaG8cldBGGADawtjtyVzJ801S
   MMFP+opN4ffI/8aCBAwF99fEQSBWJlJx21pIvFVDV9yGHkxy4rBsTxcVN
   7rujCzd1JTAQLZ/5hAgN/G2mC0vbkvsCKsufnS22beK0gtri2/rEo7ekm
   rkdKnNXSbzEgheKw9m/lbFwB+Rdoo03K/NMiZ0odn/eBR8TA1g+o2TORu
   g==;
X-CSE-ConnectionGUID: 4rWqmCjJSsacNU2brVLytA==
X-CSE-MsgGUID: 9fgaREL9T1yztIT0kx123Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22543807"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22543807"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:24:57 -0700
X-CSE-ConnectionGUID: pGzgH9ldQHy5LuV80tLdyg==
X-CSE-MsgGUID: VAtG4weoQiGOQ0M6MgqIPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="65577458"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 14:24:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:24:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 14:24:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwBHyngmGfRdCv6LG39LVZkXua1AOVV6lPOwILwRNHhmNzboplBYd6TXv+xsNKVIq9uglzFXCTtvx/avsYWHc8cIIcCOZoIW2VrTmCawQHxTbn3E8RqrQwT7JC/jldoqHCevPbBUqGkrFwNCmJIe2fO1uDuLVVVLehilr7ROaG5CuG1OfAv/d8ZtsW8Gq+QLCubt47oe9IJD8guSX1ISHXtFewHbtyiP+z5VNefSF2+DooMYvkCnNmYWTIx0xFq4Ae8ZgpZii6UsxafJ8DAkj7bxlVikmhwh2Eyv7YHSB4AGO8tssZZNDnULX8R3hdW5HUyrlT+hd5S7ihOMUYGESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cosa84V0+Wr5CwT3Nc9GbuBHSbSuU/CMrXXmilKNkIk=;
 b=F9JHk6oxW9LlbfAKgIK1rTkcddovrjIEtCOe33RfYkV/RfX6QACMWGaumsqHXhaoyQY9D2aaSBLg2MYVw2+EmxKmL2PhZoi4Oz2stgfNZ0T5L8VA9q10OMRArNR3PfPFTEO1APIA0ET8FGav4DGh1seqKkwvlJ6DCWXg7U1CKMNCdceDJ8zWiqHgUUR9w7GguTBRbGEL2tOZZSIeJ+E+eNzxTycSL0uCMotdleMLnYchfkqg14IO4Gx4uZtQ7GajTAza4Jmlbo8QumW7+ijWjSGSJNU+Jm3IpNQyDpJlIV5kTFKiyVk+j9W2hCF0703hS8RyMEk9GlMtgagKe9yoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 21:24:54 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 21:24:54 +0000
Date: Wed, 21 Aug 2024 16:24:51 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, "Daniel
 Latypov" <dlatypov@google.com>, David Gow <davidgow@google.com>
Subject: Re: [PATCH 1/4] kunit: Introduce kunit_is_running()
Message-ID: <3cbf3ofotcpddsucfycwrm6eln4ritw63vlgpudhp2z6z6l5ek@codhi3kckwo5>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
 <20240821144305.1958-2-michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240821144305.1958-2-michal.wajdeczko@intel.com>
X-ClientProxiedBy: MW4PR04CA0323.namprd04.prod.outlook.com
 (2603:10b6:303:82::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ac6596-e370-4fab-f93b-08dcc227b32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jnXEkRJOR7snPYlh1Qtgy6807mAG3SsZAhaFGhZ31f8+7E+QaZUvtgSrrXWt?=
 =?us-ascii?Q?q6+QN2FQobXd6eUBnewNfv4guCrt0O9vKRKf9O/L76K+WY/Spn9Wv4nHck9p?=
 =?us-ascii?Q?tik8V95j4AyAN9ZAxZB9t6QNcWrEt99u7opFyGNjBXsrOm9zgYDHTiY1rIJ5?=
 =?us-ascii?Q?qq99nyMAfE5uQR3f8jlXTEge+uO3C21y1ti5As+8f/LbEQavNBNQevQXspZZ?=
 =?us-ascii?Q?xiRBCd2ItOI4YZEAcOLjNR6CFwFGzqRbLGsQweHI8iElSKFRy7iR1FWY/G6Q?=
 =?us-ascii?Q?dRT84pdEfck+YUCf1+CYFKqMNyYZI/pCBzpeaO3zsTD3HDFixpJ9X5Yuu3Qv?=
 =?us-ascii?Q?ZlwRLSWsNUDIlP/Ex4RFZKXe5MSE5cjdPFB8PcWgir6smsDW3tbYr9IO8htb?=
 =?us-ascii?Q?C/mDPsrl8V3xDZBBqrMJbBHq5oB2wEgmKUbkuiWq1X4q6W1HM83hHdzLGqTW?=
 =?us-ascii?Q?0WYpFgbKRDhiNJ35ChnZgV4T+MOyoa9o/vwIY9tjPDOsRkx9vz7Of5DK5YIh?=
 =?us-ascii?Q?YeKDTBxnQgZYohs/RB/6P0rNAHQcu5iFk4dlL4Ay4kh/JDk4uC73wQjfUIfO?=
 =?us-ascii?Q?FhTv+2bfuTe3Hk3u+8YTst3pisAv090pFDU1AADm+h6weq3+7g+SuSolw0Kx?=
 =?us-ascii?Q?dWHnAHS+4/yPTQ2zuN+9kjgzeypVH485D6P11ya/KG0XBrDuYbb5VePsXvr6?=
 =?us-ascii?Q?+VqaOfAVpL5HOhG+YZRIxhjQaO237b6r1d9MYxMFtw9UybeZ1VvWegjRy13N?=
 =?us-ascii?Q?G8s5wMCxbWc9KJykgwfw0Dx+W6pN563wO1iHB1C+bjiy442yOqHBJc+r50Ie?=
 =?us-ascii?Q?32s55VieYwDikc6zgfKc7x6LsfqEdlCPIVRzGXYcOQmEFrchseQGz5dQrEnN?=
 =?us-ascii?Q?KthVIAEm4JDZGagOChMKkExV3uzrhMXupTq12iTBWM8QKIQqGrOs0Y5OdaNK?=
 =?us-ascii?Q?ruCrkdDNELXr9jYgxTl/LZC2zLiYnWtEL1UA+1Xg7VpI2NVL6ZRcSOIYHNjp?=
 =?us-ascii?Q?GSzP3zNOPA44Cg1xtp2LoWjdpo7CeI2g+NEgNDThejwr4MrOpDMiBYgmWnHX?=
 =?us-ascii?Q?ZuGs9ktFRXh8C5n0+4fpvWIpC3ikpL3Fq4DT09gjBnwWoREVupYRE9pvUC7u?=
 =?us-ascii?Q?GUxhWB/dw8f4XOcNCtUg4KfjzvHIirAl10EUAm945gGyIWEoVwRTlnBNe4ag?=
 =?us-ascii?Q?9kPzlzyP9ZF4WckrrJUN/MS2fcIZeVZM4TgWYgwIPWqm+J/3YsjUfVo451bA?=
 =?us-ascii?Q?RwEgCHR0sHoK5XhVeg7+qfO/Ftv4OaedR1CiiSmGOgHj6SuSJLUkgw8yvaRL?=
 =?us-ascii?Q?JMhcJWqxJynB1CiHXqyOXMUMVllzv/lXzLMqHeDiZ1nygA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gi2iFPrGDOfqlcIG4VnXaeqg3FQuXwBu2Q3UmKo2SBOMW8wb8gLuR2FjEpaD?=
 =?us-ascii?Q?i1nNOnRI7yKWLKYFpFwEBGjI/oRjKmSuKewYQhF0kSNoA/kmPnjlas9V9iWZ?=
 =?us-ascii?Q?Tkxa0b+sRcTXSB2VPy86bPNew1zyIfHU+rL84viHHkZ794br4T5ojaTc7+tP?=
 =?us-ascii?Q?QL4YqKpnP6bRf4mTuJp4XAiVIBvwzFDRKaU5V5N/28pvnmMNzfEmim/5YvU2?=
 =?us-ascii?Q?jJ58Zs+d31mBPv4CQHGo0pQI19eE0MfV1x2Ef3vBMcSZxMeigICT4jR38frS?=
 =?us-ascii?Q?8lm3SiYTOB6wlVrTK1yUFbrgAD7NAW9s9dz6gKFUsYzEGDfK6kBg28ve5YHq?=
 =?us-ascii?Q?gWKQbxfjrlaAkLuPp4yonZ/UROzCfRqZtt4IjyuuOVFwOSug9uyzhR16721q?=
 =?us-ascii?Q?HPD2mV2xNgQbmhSIjTSHUqLv+UF4SwvgRnoACNFSt27t0aSslN2nj6K512Aq?=
 =?us-ascii?Q?v01nvTcgASFvec208PH7KEddcorgeS+WDgmyavKvKjMEYRiEhsEopXGn3Nae?=
 =?us-ascii?Q?XWuf/U+gsh/5ELcp7Gt0EWSnlnHpqSXsMLtCL7OrxRK4+lS29N1fzIAf/Bai?=
 =?us-ascii?Q?3HeSnj4l81JJojNgpVyMF6t+NkvTJogww/5vm7lX/T/+pZaTD3PKqa443LOy?=
 =?us-ascii?Q?6Rj70Wbd2+ciw/1+ufDpq1u2m4Qz38NXk6w674sMXLtDu5S/toXyELJzZNMV?=
 =?us-ascii?Q?/muPXh8Ye3MQHgbqiGyhnTr6nin6ncM+fCPbbYDY3FxXju/AgBexr7MSAsIs?=
 =?us-ascii?Q?7IlEeTWlwNlq3r1ZhXYoMh+/5WRxeGCnng36yqp6gSrx4VNyQ65MJyASQ1ZO?=
 =?us-ascii?Q?KTJ8cnnW0ioNeL+KlNWIQKReFRDvQB1bRqQNm90WoVNp8wNndIkh38sLNYkk?=
 =?us-ascii?Q?OhIaqIQr9Vrn0z0zRyUjAaTg/oDerk2J00TW1E/WL3uNHrEalhi2IqUb7adE?=
 =?us-ascii?Q?1iGpUeKcUJ5s9yBVqqF6ua8+jo6OA7Vkrl6JA65dI5dd14SJzyDCI5WDTXgv?=
 =?us-ascii?Q?/18ao8NHgBe72Q8NMDoGw93kIiCLrwfxcsdxtVHLVyx80d9+lz2NmEjCXydG?=
 =?us-ascii?Q?R3PB985TWGxD20OzgdEzjudy3g7Dp2g5mrU3qqPWYz90M9ml2Mz2KSzdQRPg?=
 =?us-ascii?Q?0j0OIrKwrtgXuFd8NgwxBYcxT1wBOb0c+dngvngBzVr2Zh7GPhnOFDDpIQYA?=
 =?us-ascii?Q?/SvStrH6PeRQCzgw6sWLh5Jucq/aUg331dSwbC7+HS3LU+NGnza2dpzgrEUM?=
 =?us-ascii?Q?vpdh6Sl2++7zwtbP5+cRZHtk4R1WXr86xlqoNR9WSNHNkbNmjaziT5Qb8Rjq?=
 =?us-ascii?Q?ifiEF/oiiVwumBAn8QkCbq/+TmAbIG/UGhoE5VkwiqNtBdmwAqhU5Hag2xxw?=
 =?us-ascii?Q?DQgxYQWEWFhRg3nJbcGx9X+LGbuQEOL/mlJFPiSo+CtEwx3+xIu30QjqVFqb?=
 =?us-ascii?Q?t2VUXp0ZBeH1PasEGlhLt0EBkxU9f7KH90lQRtuUOVkJDsuw+CFk6BALc8as?=
 =?us-ascii?Q?b8mX0cM6blJErnKEsPHt/swDvCNSVxi8Kg8ZDOPRime+gpMTpyn8tpNCGtZa?=
 =?us-ascii?Q?sQiNCtL7eLO0QmKGz425XiASqVP45EU95HXJD332uu5EctsH7ZIMyxVTbZzj?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ac6596-e370-4fab-f93b-08dcc227b32f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:24:54.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgalEPMKTV6rtyLZHZQ+8jfa2NE3kQtK0/TdrtzOwIFdvsg7YQE7j7kLeaDlyQV0+4Ez0swN//MWGTMGdlCNfqVNblD9N+HZrFOVmUTOW04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
X-OriginatorOrg: intel.com

On Wed, Aug 21, 2024 at 04:43:02PM GMT, Michal Wajdeczko wrote:
>Wrap uses of the static key 'kunit_running' into a helper macro
>to allow future checks to be placed in the code residing outside
>of the CONFIG_KUNIT. We will start using this in upcoming patch.
>
>Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
>Cc: Daniel Latypov <dlatypov@google.com>
>Cc: David Gow <davidgow@google.com>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> include/kunit/test-bug.h | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
>index 47aa8f21ccce..e8ea3bab7250 100644
>--- a/include/kunit/test-bug.h
>+++ b/include/kunit/test-bug.h
>@@ -25,6 +25,13 @@ extern struct kunit_hooks_table {
> 	void *(*get_static_stub_address)(struct kunit *test, void *real_fn_addr);
> } kunit_hooks;
>
>+/**
>+ * kunit_is_running() - True, if KUnit test is currently running.
>+ *
>+ * If CONFIG_KUNIT is not enabled, it will compile down to a false.
>+ */
>+#define kunit_is_running() static_branch_unlikely(&kunit_running)
>+
> /**
>  * kunit_get_current_test() - Return a pointer to the currently running
>  *			      KUnit test.
>@@ -40,7 +47,7 @@ extern struct kunit_hooks_table {
>  */
> static inline struct kunit *kunit_get_current_test(void)
> {
>-	if (!static_branch_unlikely(&kunit_running))
>+	if (!kunit_is_running())
> 		return NULL;
>
> 	return current->kunit_test;
>@@ -53,7 +60,7 @@ static inline struct kunit *kunit_get_current_test(void)
>  * If a KUnit test is running in the current task, mark that test as failed.
>  */
> #define kunit_fail_current_test(fmt, ...) do {					\
>-		if (static_branch_unlikely(&kunit_running)) {			\
>+		if (kunit_is_running()) {					\
> 			/* Guaranteed to be non-NULL when kunit_running true*/	\
> 			kunit_hooks.fail_current_test(__FILE__, __LINE__,	\
> 						  fmt, ##__VA_ARGS__);		\
>@@ -64,6 +71,7 @@ static inline struct kunit *kunit_get_current_test(void)
>
> static inline struct kunit *kunit_get_current_test(void) { return NULL; }
>
>+#define kunit_is_running() false
> #define kunit_fail_current_test(fmt, ...) do {} while (0)
>
> #endif
>-- 
>2.43.0
>

