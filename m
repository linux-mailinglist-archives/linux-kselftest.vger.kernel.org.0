Return-Path: <linux-kselftest+bounces-6749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022788F29E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 00:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDFE1C250AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99B15358E;
	Wed, 27 Mar 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ae7L21wl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419FA1DA4E;
	Wed, 27 Mar 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580945; cv=fail; b=repV2wWUiZGOQ3pUO6VAjkwyMnWOrME7Ug60r6l4C4w13e68BMsqSLNKaurYnyzcZCgXNZrnOXeNeupzD/XJ5l29q0z+qVclreOJIoxmjrDdrUPnaK5V8b8Je3rk9S3y3uZ2qDA8XjqMXr6AIri5jlpzCu7saPBS/Odi20QWOb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580945; c=relaxed/simple;
	bh=slWWJqr3HdrfgTOoBKXXSKwaoX+xeO7bPQT8C+NkBuQ=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQQJy91A8cta0gd455VTIQBuScQYwVkMSoykOnDbrmPK/8LpuNL43DJxdfuv/zuTtA1thcvDzVNJ7myqgzeCmJauDbTe83Di8OmP/6UpaeihLIuv8pbUFN3Br96Hqw9lOX4kaO/YHSUlJVw9gDoPO7Z8eHbxvSWQJXZBRPtVOB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ae7L21wl; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711580944; x=1743116944;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=slWWJqr3HdrfgTOoBKXXSKwaoX+xeO7bPQT8C+NkBuQ=;
  b=Ae7L21wl7Sp/GZnEcygF2kNttHhQU2GtzywaZ8o613f9C6uo9KFxHUzC
   1iZpBqMAKvTK2EjkdGcLdQQ4TEIcKHDQAPZ+vx1jFYZ0H017IVMBWNmiH
   5H7WoTkMU4HoGUKkartA1ZLvPMhPQdnBLKMsa55FHCx995BBOVA9oSukK
   YBFDhBtcxDwYV+RB7YmdMxmGpXwQI05c/pmy32DQ2YlWv2iW/cOWD7tTL
   3VEEf+DITHzyexBSV9Y0t6TNkzZOPj++/knY02ZOCsE0Oy2HGIU1THxRx
   aoa0d3IMP0L8m/Vq1dyCvrKuFyOW6bGCcP4IZQgjPYH1WlaOZfsS0qH4R
   w==;
X-CSE-ConnectionGUID: 9vwwDVT0SZyGTzaMw9r75A==
X-CSE-MsgGUID: JJcihuxqTMO5Nrvv5jiIgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6574760"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6574760"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 16:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="20970593"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 16:09:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 16:09:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 16:09:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 16:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/EMs9dZTDWexRAW9+riba1ISEfiXOJPxy0Tfn/o2FDyfvwPDzKh5kLuSLNj/rrPI/em+eQxUn86a1F4qHJZBw4iPeGt/Z/4VVXcRMIWvfU6vKIebRljsTT8cmUMnFmvn80eJw+X2vOBi0c8tR0HA9PhCZrc+ZJcC+mqkIkA9EdLrWfRvSotZMObME9Nxw+maHg0y5xuPzkhFxYfQGzezKLRnSjFq3R397xU3sXcXSSUi0oh8ZjXsbUUaBpfehaTL0Cd/LBi72EMwAqYSWmHettFBMlipD2sQsf02sYEhNkNoVJO+VUgpjbc9YPq5CUxi7GOzf9mjBFzkhqBMaQknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bw55YKjtzJ+OL4vVVpt6aG7zylNbxoLGN6+ooqp4ww=;
 b=lemjtm5iajtxHpkk8MYjmiufDs0VxhsMe2U6giL1pdumwJelqIw6D0+upwlXNdVXpQS5l9om0uaSNVje4uu9AvVr3dv13qU+KbGTYVl8vR0a+MY5et4GteKVvbY3XZ9/nE68vdW54gOMMUb4s8gND3AJ+aQhyrvkICD9uCNZhG6eKvkJVf126pUVw+iV983agcCRrKSMnE7+IYHmJv1fYpKyMFZFd9cpvGN794EHDItvpCEt5sYzaKq6H64xe+OcmVnz275O0UHXE015FyKMiBeCVJHC8QdCwF0XFjk48XAC/2IVZeg9vK5gEGtt1jHNibILHmkLGMiKMwcFOKEvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 23:09:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 23:09:01 +0000
Message-ID: <f7a81e14-7fb9-45bc-9885-383ab7a2e708@intel.com>
Date: Wed, 27 Mar 2024 16:08:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] selftests/resctrl: Simplify test cleanup functions
From: Reinette Chatre <reinette.chatre@intel.com>
To: <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>
References: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
 <ac887a4a-5647-468a-9696-4a3909e42561@intel.com>
Content-Language: en-US
In-Reply-To: <ac887a4a-5647-468a-9696-4a3909e42561@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4051a29d-cd56-46a7-b7cc-08dc4eb2e39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZO9eOZITtm7SWhSAH/7ZxTBywF+PNttw1PdSiaJGOV6RpUG6R7XpMJMt4saNWA7yVaWONKPVuBq0g/Ox6X0XwWe0QoALy3vDq7vWXFeLDm9sxqQSs3QOuxDsYY26JDePU+KEH3hjMKmFi6PsdleNjHhrbW86qeuRWD02dGKo/hh8RYFRrmx19z9uuDSdjr3cG2EcjgooJQKsK4Esn1T4bbEMnfv95FusVnsqbR5lNwwJNX1iN3Dq8mj0SHE3lHr/t5T++9v0OWL4TUfF/UQBfL9pbTK/pvn8fQW7Oq6hM27RLiSkeeUXS1drnUz6DW2IK0NdHCMEtYYrvKdAL3qcAK7Fgtcdl3Ee9OGtEW9O2rKfKYO91Xym2T0xo8USwqqr/np4WxxqirUChCRbAZwUy7Tkdd9UE3hk0Pz06U4iQu+5dAeVxk+7qkz4Ca/H1h2j34PZOn0K3mLDD35HjyyT9dWvx0QrmrhlMuDRi7figcWjnI/Pd6IzNjHtzmJ2gEqYSOJBNVmvUZec1uAhNQ841FgaEMhqnyb4JyIqgRT0L/7UfYkM4fwyEE4Itt8ej/jBu5L/Nrx8c4ROwKhn+dj/mlueEd9HuYONP55vUCMyQHTRxQPZ8blXZDac0UnsaUdbCy4oAV6rpP4wEW+WRIIeCOBWYPtEn9ZCBKTXCMApho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkEwYVpZTnYzK3lmbjJsa3ZBajRTcU5abkZuWVNwU2Z5Y3lHc0dDUkduKzFW?=
 =?utf-8?B?RjNYeGt6cmFrNVA5aGJHdGVYdDFQVU1UTFZWcmZPS2UzeU5hVlkzeG4xb2Qw?=
 =?utf-8?B?ZHZQRCtxMnkzMmkyMGpMeDNJYU44NDFKOVk3RDlrbi96TFBDdm1zUWNZbys0?=
 =?utf-8?B?L0RXSG5NUEM0ZG5NQzIvM3ZTWW1LbFJIcmdpQUorNndoWWRKL1UxaTRxZUc2?=
 =?utf-8?B?ZlBRWHAyemxCRWpRTGk2b3pUQzFLWUp5OWNQZ2R2WitiOHdoZmhXRUNsMFVK?=
 =?utf-8?B?NkV4aUVLd1dMUHFMY2lBOVlrUHkyQ3ZQeGwxM2dWRXlidERVZ0xkb0twT0N3?=
 =?utf-8?B?ZlFyMFlnUW1lRkRlblNKN2pFYlYxZ2lNYWd4em5uNHJJaXZBVEpyUTNIcDZN?=
 =?utf-8?B?N2F0cVcrYXh2NnBjOUpzaFowYnZUVDZOcFJ3SG5oUXVyR2d6T1owUnlBeWw5?=
 =?utf-8?B?VE8yT1NBbzluUEFXUEJCZDBzZ2dwZ0pwNCtaVUY4cUh6VXE1MEVhc3BoSzd5?=
 =?utf-8?B?ZUQyY3JOUVRHQ1ErZFg2aElheHZIeURuQ1RHUVUzU1J4MGhLUzg5Y0dpUHow?=
 =?utf-8?B?N3p1cXVyTit1YWswaG11WHRTWHczMEdScG5xdkI4OEtiei8wV3J2NVNlVklN?=
 =?utf-8?B?L0ZUODJYTllFUjVJM2k2VC9oaWpvbnlGTFczOFdyNjFyMjFGalMvZzhZMGhS?=
 =?utf-8?B?Q3VoUmwwOFhEMzBsRTE3Ym1XWGpWWmlPaS9wMTE0RC8wYVZSc014MGtUUi91?=
 =?utf-8?B?dkY1THlGd2E5cUsrY252aFdDenl0YnVtUDFzcFZJUWd5SHBYUkdMQ3dJWHFa?=
 =?utf-8?B?OCtuM0Q4bDZmbDlvaktibC8rT0hVbGF3NUtSUTFOQTFycjdLb0E0VFUwUWdH?=
 =?utf-8?B?OUo0b3NSY0NJV1hPazlCaDJvVXlwK1BUcHM3WTlCMHZtME9OTDRVK2cvWEV0?=
 =?utf-8?B?dzJFN3MybWduSStDS2lDcmVXajltNWltdFhKakFMbXp6SUZnNEpRUHQ0RXdI?=
 =?utf-8?B?c0hBU2d1NkE0aVBLQUlDakhRejFtaFc2N0h3bHBSdDhkMHZaSit6bktSU29r?=
 =?utf-8?B?ZXFWWG9PV1Zsa0lOSDFrQ2Rodk9Na0FncnBOaElsaFY3TGx6aUdGUWN5czVv?=
 =?utf-8?B?emU5RkpPUnZBZmxLc2l1ai83TGp0TTQ3Mmo3TlBIaFBsZmEvOGRsMUlvME9p?=
 =?utf-8?B?UjJRb0ZndkdoWGlSK2tnU25oY3BNcUp1cFhERitKZmhrRmlYTFJKUmI0WUVt?=
 =?utf-8?B?bVN1QXNpRVZkZFkzaFQ3OWJ0NFJldW9HclM5ZEM5UmsyMDJmRWpUbVhTZjcy?=
 =?utf-8?B?cXVoQWxFdVBFMFRmbzJLd1l5NFB4TmowMVJkTGs2aUlIQ0ZOc0gzanc3ZjlP?=
 =?utf-8?B?ZUd3Rmorc1RVZmpZdWdrVUxZbUFuZkREZ2lIaHdqOVVncC8wcVNXVzFFUkZG?=
 =?utf-8?B?R3VGd01yV0tPY2Z5TzUxTHhZZC93bFpZSzNWRnBDOHRhTXRWZ0NEbU56WUo0?=
 =?utf-8?B?U3Q3Qm5JWVNRNElMQ1FsaXJFa0Y2bHJDaDRyWHhPeEZLbjkzVlJON25hRHVr?=
 =?utf-8?B?cDVZV04yMDN4VEJUZG1qT2M2MzNnUjlTSTBGRDNQU0JseHBPbGtJaU9iV0F2?=
 =?utf-8?B?S3QwYnFpR3QxeU1QcVZPWS90bk5zWHpPNmdxS2tpL0FSR2kwdzFPQk1hZERt?=
 =?utf-8?B?aDN3R3JDMUlHTk9ubStyeW04Q0MzRHhXUmxvMjlJWkp0bCtscFZkbkVCa0Mz?=
 =?utf-8?B?U2JkdEkybytYWlQyRFB1KzFjOXpqM0hYRXdDWnZHZThGOXB1Uk9xWlZ1c1Rq?=
 =?utf-8?B?dmRsWk5YYWFna1E4RkNHdTFmK09XSFQxeFNRLzdIYzNFbkFkTGIxK2RkdytW?=
 =?utf-8?B?aUl0NEppUkQybDg0ZHZrTERBTmpyWnNaVU9weGRZK0IrcFkvSU51RGVHOU1V?=
 =?utf-8?B?RWdqdzZIRjVPWnVJdnpEV3ZsQm9SODRkOUp2cERwYUFkdUZBamZFNUQ0Mjg0?=
 =?utf-8?B?eVhIVjFPd21VQTA2Z01XanpnREJ6U05xZHRBZCtpOFlyck1jLzVleTY3cjFl?=
 =?utf-8?B?UW1RUHJnTllRbWk2SXVGOUNxaThVK2NSM2szWWp4NmR2V29pZy85U1J2Y296?=
 =?utf-8?B?VFB1Rk93SGsyb3k5dzV1QWtDQ3ZBOFc5MmkzRFh5TmJxNWxFbEhKSGI4QzBo?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4051a29d-cd56-46a7-b7cc-08dc4eb2e39a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:09:01.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfo5N3n/ehXbAb7bhxZ1o9FkOYvDvY6DGkKZZrYyxf4UNdQZ2G7bfLTNp/z1YpD4fmLgP0ODJa+whCPGT0w9iTs4GIHe58z8P8Z6ut4mudQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
X-OriginatorOrg: intel.com

Hi Shuah,

On 2/27/2024 8:36 AM, Reinette Chatre wrote:
> Hi Shuah,
> 
> Could you please consider this series for inclusion? I do admit that
> there has been a lot of resctrl selftest work recently. This should be
> it for a while as new work is still being worked on. 
> 
> Thank you very much.
> 
> Reinette

I think we missed the cutoff for the previous merge window. Could you
please consider this series for inclusion in preparation for
the next merge window?

Thank you very much.

Reinette

