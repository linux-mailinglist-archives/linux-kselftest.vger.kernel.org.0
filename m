Return-Path: <linux-kselftest+bounces-3144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA77830323
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 11:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D064B247B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626714AA2;
	Wed, 17 Jan 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAxr1W1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990B14270;
	Wed, 17 Jan 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485605; cv=fail; b=Bt+n+rwcpGYdsYtNb2frTGgkNrkwA+2xkmLj9vsi5JYXBXwoMIflqTS3hanY+MW9arYcUI7AEZAv99nTPi5OmlcLX/R6hLwO+3/TeGwaQ/fUJLrm72n1FKg+NSnP+mg0VSAi62K38Nci8okGTCM9c1fV1Lr+s5cr2fNLe0GXNQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485605; c=relaxed/simple;
	bh=hR8VvzPWz5udnZsf5NfFMboOzWhO/RnoCa/uzeTBpj8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=rl9w+i5pnYO5oALvqBUD4L8e5HMCDLXNJbAiuaoiiyqvu8M5jffQxfuFq5N6+Msa+J45tgaUcJ8pb08+mVPxaAhbi2RqWkTYC71kxGV8psOJ9V4ORVqMIv63qIA85lwAUYxPHMv2B7GDR0q5HSwlarxccbvLhNPropYPQGr8GzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAxr1W1v; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705485603; x=1737021603;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hR8VvzPWz5udnZsf5NfFMboOzWhO/RnoCa/uzeTBpj8=;
  b=IAxr1W1vD94viYQsJYIAoP/+DE/VzbEfw13u8F1xhARkNTdtwc6DvkD7
   dAS6ei4DKqX5yVejYgPSD3eJrCiWFa42kvhNieTUflOD8PTYydjmSz0ej
   y0T2f3OzQdsvqSVqtivhp3YCe2Efw6zIk75FqfEbSncFdLaBCVOmQlyqf
   MouGkIz0aKXLJSiJNwz5xuUETHSoliXL+COecmA++VIPBHWiStc2ZWkFP
   ISKIQqBw53VQSDRAnRcryqIaOeN6M2oPSwaMa6TwioY0wn2qPGVcwx3Ka
   PVylnN8Z94mZW0oDK9Sgc0/KiG/cvfQr6iXGNUyB0RtNleV9UDvVpunFh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="390576294"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="390576294"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 02:00:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="26134800"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 02:00:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 02:00:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 02:00:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 02:00:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+HV+y2kmw42vyVt4DT7adie2vUIDqI8eFMDKjw7/za5zmrdi70k8EOqtcZLOVMpFj0abQFaZGBHroFuqWb2Do8FQf/FSTEwso6WrH7gYAJAn88JcPA/3Ta1hmafBOBbPnch18HTNVfRQiklrxqeshJQPdHELWbdA4grakB1QTE1L7LB5tpM/32H9XmQQ3KcuUUzwlBcN6OmHr6HV6ttQhLulaX/caPi00fji6ZiIwcVuhgJJn7k7INvzo/PAQUTZ6PhrsA7ZrNvOfKY2bOHkd9jLEm+coYQ5r/ELZmDmov1zIQVaCl0JajZwNaGMWqxZTgcANqfdIZiwioj7KbMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YME2US3UAZ9rALVdeFSpxYzu+O9QVBznHVk+WLqSNWw=;
 b=DemVsCGe5mYax85gY7uRLI7ZOaTntyMN3yn/7DpE5tm5HWC+Fd59WunMBjgMU1S3q4PcNU9tqY0f0mlM8ZxF2fHKTP2z2xupJ4tK73NELJ0v6YIZ1jhU1OsB5YCoeKg5euttU7gPLxPkSEdkW1XGkYz3VP7v4+FLbYJqLPADgLUSE/ol3cFP8tyWOaSgrK+mLI+Y0EdgAeMnYtuWvDN4Qe/5BzReOUfgh0S/QRMF1fOXQ9+HtDj8nNDfn6tUH/R9dfGsJlUBv1MT02UZrAO87CvEQNJcDvmuXl77KSlpEUOENEIfXkCH/wNVj+1TFMZ08MOYUWTkPhUdFVnQI/1RUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB6555.namprd11.prod.outlook.com (2603:10b6:510:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 17 Jan
 2024 09:59:53 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Wed, 17 Jan 2024
 09:59:53 +0000
Date: Wed, 17 Jan 2024 10:59:46 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] selftests/resctrl: Add helpers for the
 non-contiguous test
Message-ID: <v4phdq2julcydn4wxj2rzsacjp6sqyf6h5w7nzyc436fwf2spy@4d2fal3jk2g4>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <c7b66a4682829894ec72d8a1f78e324233ef0535.1702392177.git.maciej.wieczor-retman@intel.com>
 <ddc900a6-7337-4721-ab0f-917c32e917ff@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc900a6-7337-4721-ab0f-917c32e917ff@intel.com>
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c379025-2e1e-4729-9d60-08dc17430d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0/t61Liy8YoDN73UNnGGgIG2cbo6CxsJG2ALMT0H7qNp7YH9f2hXTUCmmSewO6YeaEZ+HYnrx8kWkFi/fKkuDqoBVoyKOZf/e4i+ufzkChrwuQfRD+cGJKjxZTNt7aVVgr30Qw3QasfyuXSleN+NKnjrJDYpS7QRlPPCrJ5/sjCwNKWzCvHyZ8dv238mAYQeRBhail1JPfm3+URuv4Nk4cCppKhwgukSZyCkP2XOo6REhWCtYLIuCzE8wiFX+lw9QvC4OJjBhxxe/OkVNAPR/OiEKeixABqNDPyzW5wj1n0//Sml66CaXndSaR9cZrycYYWzKAnvHGmBipgnQCsDqLu2APP8imXqbBCvwVpB3WVHzYIL9pMAta6VtxMitkHllWHB4l0SB5gjeqDng96epTlEEJ0ODZ/CnGxaPsPZv1nTHfbIdRJKz64FAR2lbAN2ang8C3OGfA0jpnHKdcM3LBxyN7ZZtAV0z0kLMNP5ALp3oJNekvOLhSrjx1whRQ3BKkG0sCmn4Z8AYcM2NImNFkotF6sqCW2Cfbh/67svR1YbLFXIJKRp9y3PeMevlVv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(66946007)(82960400001)(86362001)(41300700001)(38100700002)(9686003)(26005)(6512007)(8936002)(66574015)(316002)(53546011)(478600001)(4326008)(6666004)(6636002)(66556008)(6506007)(5660300002)(33716001)(6862004)(2906002)(54906003)(6486002)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jwpS9lrcSv8mUB4m38lc7EELIu0v+jpom8Oj0YcUeG90yg43yy6bdumG6q?=
 =?iso-8859-1?Q?Te8l59n/EhGeJj7ZuR2VTW5Smm6R91sKMm166tCSh6008cN88iAiWz7Zdb?=
 =?iso-8859-1?Q?13MgvdhGpHtaeGuQtcDb07TCPsDHnJhUNoF/1VXSyLLN/taMyoezJzHnAU?=
 =?iso-8859-1?Q?AVhujpAIL/GDemRGg24YoP5SrPbGfsaFme/VgzfN01vBCVkaoqFqfCIE+6?=
 =?iso-8859-1?Q?m2Ci+hpg6om82YqgxeyxZUMZL5k8+AJBX7lzj7pnLLvwtSByDQvF46MmE2?=
 =?iso-8859-1?Q?zTaQB79tw1WCN/fkNGf9MNt/s3xU4Z/iQT0CVh1tLtkn3FAl771iO/9N7Y?=
 =?iso-8859-1?Q?URFRRr1ZImHpxY+orcwQq0nvBsWExYAr8eLEVeuS8BkUqxgHVwHKFcL6JM?=
 =?iso-8859-1?Q?D7CjTDMu5HWfUyBnBPCfWpQoPJVvEna0a42+cwzWCTw9HZwI5QhnGniUY6?=
 =?iso-8859-1?Q?Z9mXwxRS5FV/O2eiOYX8injpSgttWttF52O0ChIeuWH64Khf/Hyn3AJU/y?=
 =?iso-8859-1?Q?g8RHlK99Qas6rmBgixikiqGuXAc+mQcsPT2m4HVv04zGqCn/mWw4ukCKsk?=
 =?iso-8859-1?Q?/emV52oeBedmgIqrbC/0kOHEw7TPKrmZZYWckXjgpoOpkNBL6DsYeA80TC?=
 =?iso-8859-1?Q?lROxosnLi5lxtaCbQ7IZXIHAm+2cImVidyqBgPz/XX6WEqJUVXzNSSVt2/?=
 =?iso-8859-1?Q?zepwa7dyo3NHghvIp2tFI7K8felwwxOC45082U5VFC3jQQl+3f0fQYI3K1?=
 =?iso-8859-1?Q?KQqvNrJRpeH0E86PKCmFpr55aB9OWUg729wlSBWo3eU6VLAWqu8qKgOgTk?=
 =?iso-8859-1?Q?PSqlGYLLf6H7dXJo6sj2DNKtcmcHE/P77dcE6BqtSKDXvYmItVDjFy0kFi?=
 =?iso-8859-1?Q?KJqcra/t/wOBBtkBng4hgtXtIyDWOpoFdUfFnbTEVMgSr9sn/tOiw/L4Gv?=
 =?iso-8859-1?Q?HL5/R/K769tEvR+0btP6Xbctox0+v8j/e+nQuuF1pzyY6/HhCFgA4WOz1i?=
 =?iso-8859-1?Q?po1cMPZKYNXaXxPwJxz+uYh66IildidBKnKmcoDsmPpIN1AONyLItAtQTI?=
 =?iso-8859-1?Q?cF1V86QAPAqXe8B/a3B/S0VlKBt8otdZYGUGk6BsrAJqhQkLA0mBtwa636?=
 =?iso-8859-1?Q?0KOmbG6gY4QY93q014Rg0jGQG1fXD4CwxhozV2kF7uFe3ZPdo2+SFYVJ0S?=
 =?iso-8859-1?Q?+wOjHGjeuSbDwAz6wUmUMGh29dxxGZUYrbNEbi8f7KnvWpkXXzJvhKqXEh?=
 =?iso-8859-1?Q?CYfIWLd4RCLaF/+16JF0RCtqWeXqEqkFCaP6PE9Mx5yuunZbtMzvrHzuO9?=
 =?iso-8859-1?Q?YW10P36ow/w1LYCQ3jDYTTxD/6nZQzlioAUhOU4Znhwq4eyhfL+5AH5Rdj?=
 =?iso-8859-1?Q?hYpRAZECV2WgI5ACYw8doRf7DIgYdFttlSmzc/aZA3I5p1vlRflbb8oIsZ?=
 =?iso-8859-1?Q?0es+C5WFj3IQKPJ8YsHEgaggN2g30ccE2ExycwE+lucNM6LkV3uMxWIdYG?=
 =?iso-8859-1?Q?qF+/VfcJMyE94G8Ht1e1cG+hDAIkgTm6ZqI9Z+kCoh9+GkgwS7FR/3U6gI?=
 =?iso-8859-1?Q?J/P+0F8RicxoTpSYzfCd3NiZjc6eIXjdeOgOjkYINxsnViZimQMOkbblW/?=
 =?iso-8859-1?Q?HHZVqCxKLh9EvuaB+HY7y0biUj38M+X0WKwHMNXBZS7xFyizJnuxP1t6Vy?=
 =?iso-8859-1?Q?SOs6/kN8ZatpX/L9mFk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c379025-2e1e-4729-9d60-08dc17430d18
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:59:53.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCL7D/TfohzcOZfi+/7U2La+0hnoxsoMEm4FziaYOY/QwGa+G66v39HE6fWj+Tt90uCjfVZbxo66L45AHy7EknfEjMctokzunmvyF0BO6Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6555
X-OriginatorOrg: intel.com

Hi!

On 2024-01-08 at 14:36:36 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>> The CAT non-contiguous selftests have to read the file responsible for
>> reporting support of non-contiguous CBMs in Intel CAT. Then the test
>
>"in Intel CAT" -> "in kernel (resctrl)"

Sure, will fix.

>> compares if that information matches what is reported by CPUID output.
>> 
>> Add a generic helper function to read a chosen functionality support
>> information.
>
>Since this is a generic function that just reads a value from a file it
>cannot be assumed that the value represents functionality support.

Right, I'll rewrite this.

>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Added this patch.
>> 
>>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>>  tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 739e16d08a7b..8f72d94b9cbe 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -161,6 +161,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
>> +int read_info_res_file(const char *resource, const char *filename);
>>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>>  int signal_handler_register(void);
>>  void signal_handler_unregister(void);
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 0e97036a64b8..70333440ff2f 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -249,6 +249,31 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>>  	return 0;
>>  }
>>  
>> +int read_info_res_file(const char *resource, const char *filename)
>
>Considering that this is intended to be a new generic utility, could you
>please add some function documentation?

Sure

>> +{
>> +	char file_path[PATH_MAX];
>> +	FILE *fp;
>> +	int ret;
>> +
>> +	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
>> +		 filename);
>> +
>> +	fp = fopen(file_path, "r");
>> +	if (!fp) {
>> +		perror("Error in opening sparse_masks file\n");
>
>The error messages do not match the goal of this function to be generic.
>Also, please note the recent cleanup done by Ilpo to replace the perror()
>by ksft_perror().

Thanks for catching this, will fix.

>> +		return -1;
>> +	}
>> +
>> +	if (fscanf(fp, "%u", &ret) <= 0) {
>
>I find this to be potentially confusing. The function claims to be a generic
>utility to read a value from a resctrl file ... but hidden within is that the
>value is required to be unsigned, which is then cast into an int. This could be
>made more specific and robust with something like below:
>	int resource_info_unsigned_get(const char *resource, const char *filename,
>					unsigned int *val)
>
>The return value will be the result of the request. If resource_info_unsigned_get()
>returns 0 then @val will contain the value read. 

Right, that might be confusing. Will fix according to your comment, thanks!

>> +		perror("Could not get sparse_masks contents\n");
>> +		fclose(fp);
>> +		return -1;
>> +	}
>> +
>> +	fclose(fp);
>> +	return ret;
>> +}
>> +
>>  /*
>>   * create_bit_mask- Create bit mask from start, len pair
>>   * @start:	LSB of the mask
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

