Return-Path: <linux-kselftest+bounces-4149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5FF849C64
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 14:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7083B1C243E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969322F00;
	Mon,  5 Feb 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXj71xGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11624A0A;
	Mon,  5 Feb 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141412; cv=fail; b=t9o+VbCoH+v2vCwB5bv8T32BghOpVTmMvUMCd8EPw65tmzXCvYxb1Nxi0PnKlZipZym3F81O6qU7ZFhzk9CdSUgkyH++oggPPXWWWbrmePy3RMoE8rhbTBtajC0FM2eJWl5cOG2wO5HBcRoAerkTHh2l+4++ymDnCE48d5hpleo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141412; c=relaxed/simple;
	bh=mqDz7jloT7Zp1CLgnWbP7IeJS6wSo5TKJtkb02b9DAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ug+WVipiyg5nmLn9pnpnUBGZh3b1nIQNX/p1MV3wlfZsKspqhoflmwqFqKdqBjdXYIAHIrh3Q+LcARkyDpBq0FmNG7lWLg0gxo10H2uRHtLIvSyliwAvs16ox7FOM6tvn/FLEJIKLqUYzUtc/dydM5pot3j5X4MbB4ZjJ162hic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXj71xGi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141411; x=1738677411;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mqDz7jloT7Zp1CLgnWbP7IeJS6wSo5TKJtkb02b9DAY=;
  b=LXj71xGiz9J30tyrXW3QbTMmdylclMvIYHLwlsuiEtekoyOAi9aYkBJb
   Pf/MJqi/Bk3NE2HbtNii7qV0BPOBUyLsKJ+qcYwVI0iTIvUQZ5oOQYPnn
   VFWacGUKiqgqQf6mgx9GQqpo9eiJD9xcYyNrLKO7XUa7MC5vjW/+I9+ba
   fk9HgS4lykGYl34kSRMbtrtnf7gqXSeFPHuLRYWeKVRE5+x7kCAZbNg2O
   mMiZ7GaHg/9aZzjIvwMZoiTRzJVAcuXy4ii2D1bj1vQgy0/03ziuye8H3
   nwSYlkARnBkbP3UlrKBVhwbn3h/O8DNdQ/xiZkwArm14sQrkALkUk5iOf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11261479"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11261479"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="717333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 05:56:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:56:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 05:56:35 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 05:56:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgpxPN9bG4qzDMSlD8HkrpEecR1Rwrb81f70dK6WRmypezDPAlC4p3wXQ86ZoP6Y8KIQmVKAZcwoJ/C1fM8fqZZ6fBf0ALodzuoWY4zkxFc1b2nPGIV155O5TgVHZ5uzuNI5Ckyg2S1WkMeo1Ol68BnD7VqsQdPxRK4bndxTE+WMrEp6APRy/FqOhnTJfTOSd5P504yxJFLltcMqXZDhYO64WZRaDwgzEoC7N3+ZpQ4cOtxcahFZ4eiU7RW3uHKm/vkfmUlK8XcP7an7YXgqAvTDet1pO5hdq1B+/gd+TnGnck+vlJDNmrYSlJkT+DSmixOgxy6vVZp5LWV2tDvA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPPeInl0t5+ESl/Bo3xCxbGwOOrthZ6nOp1DSgRYFKo=;
 b=RuxvoRis9YrzVeZUA48yH9wt2E9py2xyYW6OSMl97M4MXSjitFFYumzL1PzaQxri1co6i7wbKyXsFID3s02T+mxOkCrgpyLL6lvn5UwUvfCrd0A6aYfzzjSKqW1BxKb+Z28VRK6yYKAQ7F+9AD8TNVR/57polDJ9lpL0y1X5dt48EGkN/ZrWAc0P7O/Lh12YAcPf6MqhXbjomF97KN7XcHIRF7nKwY/Aj/4P+7z3iSss5ZvcoRbl8ZgHMu16vpOzFT6PyXHZXbyH6Z5g7lPvbJGm3jNZtdIfzhwZuQSW7lc4W20nKgxp1OuUkvc+1p4o5L2F6d/aEkKHR8vCYh5o5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 13:56:32 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:56:31 +0000
Date: Mon, 5 Feb 2024 14:56:22 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] selftests/resctrl: Add helpers for the
 non-contiguous test
Message-ID: <aavahod3ehdj62egrxzqqz2qsa7nwxat72kj3gufeqckckn7b4@amwmn7q52z2z>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <89b8965d563e4e61b95b20be55c26475d830b245.1707130307.git.maciej.wieczor-retman@intel.com>
 <7cfff3da-b476-4f24-aa16-428c79bd81e2@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cfff3da-b476-4f24-aa16-428c79bd81e2@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 380a84b3-7822-4782-6cca-08dc2652418e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiXT/v/IF1/eevoRDPcpZ7j3hY6FXhTFaNorBaOrXmHGPrFNgzOtUFJQBtT6pkkb7YWYdZViDWfI1K4nHAAv8BNl3AqbBCfqWAoGjxfnYArlWfCNpyz0i8NabpI3U6gVgqajUxvSz233m66prBWUMpwwzgHeFDwmX92eS6uix+YM8pvqDHXsekysWiBfSALfTsB9mRV0KoSwECxJ4OIbQXIQmhFDBZItvuVUtPgOmQ/Th9C6B1x1rxA522H7eKyPJX379oHoUvaAMaNVk4MTsu57iVbadsz0Dyf0tnaJ6BZeENmLVXsBqE0/lLNT5oZUt4D02hFT6Qx9/SMES4cJuZKKOxmfJuCt8hlJi8MQa3O5nNHRD7IuAO/dwaO023KitlFeuGmRvKtD/3aMpkb9i/7RgEPxDnNadyQY+hsSWwkDnBRwaMIWStGl6n+ljVacRF//1HpTLSf/8AZ+5ygE2kSgFDazhbElSCpJFxHLeyPLSLpJyKijuHTcrWfwzuIGlX6omPr9v4cQZNmJ4ZMaLrzp4fHgOIM1cLsfyhMm8X7ZOF5rUOGFjv9puPCtMVrW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(41300700001)(33716001)(6486002)(316002)(6916009)(6506007)(6666004)(53546011)(478600001)(8936002)(4326008)(8676002)(82960400001)(66476007)(66946007)(66556008)(38100700002)(66574015)(86362001)(9686003)(6512007)(26005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yUc+cVQrifvxZGGrRmA+ZrujrI97z2mBPY8E57nI+WEPgVRDM8qvzYMpjF?=
 =?iso-8859-1?Q?9quWlQQp/4lAL+RMwMkWngs+lwa45x/jf7L+6YV1O6CoWPBoA0+cFCXKKN?=
 =?iso-8859-1?Q?fl9iTen2nQPGSvTxa87uSVJwDREQ8l8DiQ48pTHUL/nv3OdPHS4Vya+xjl?=
 =?iso-8859-1?Q?YEPC76NHolmLgHCXbupaHoW9sPOnj+MGIMxO8eUt7PYa49lZT1IYQI8Ezk?=
 =?iso-8859-1?Q?dtoNXlLs228AFXh37CX+rqSZasvTyyPyocgwt0vf1te3bnzNvWnFucqmdW?=
 =?iso-8859-1?Q?6MT08CuN/hwy6xaNIcsftCVpWrPzcMTptz6YclD7jkDKlpLilVkZvXReKO?=
 =?iso-8859-1?Q?LaCZBSPZXbST21uPguIfrOxDpGjAr/HxgzcZz1TrD/MSe2sY2eunw/Hwk6?=
 =?iso-8859-1?Q?n04yP2w6nT30uI8YM0vlflm3oafsi5cUACfFpur7LZHDUEK8wXrjSGCc75?=
 =?iso-8859-1?Q?oNGZPdWfRx7u7Y6EYtHaTjjK4RSF2ny7mg/8NWYL8at/rACpi1nNZQsTxm?=
 =?iso-8859-1?Q?UEZDrHT2lVQZxTM6fMnZ3w6j4oEMhxDKmdT85OQhH+doQyJlGAeTFlvrnJ?=
 =?iso-8859-1?Q?1gtKL49cWwVMlBSkMb+LV6rohLIxEzfjs6AHBH2JCLbsjleG4KB0k/UAFf?=
 =?iso-8859-1?Q?rNNbmYJflB+oMpTLSN0KRudxk1c02m3OSIMm6WaNw/s0OHcxsDYWrLifHQ?=
 =?iso-8859-1?Q?AULTnf96x3qXVEbs9pu9eJ3cGZcMWeRLdYCMHKcl6kzpY/gphlUty5iQ3a?=
 =?iso-8859-1?Q?FL9Ki3caEeW3f9k411Ur/dINbH1ZeSQ47Kjgn5HQuNsjXbzZ0RQW4WqLMw?=
 =?iso-8859-1?Q?PuM8fciX+SWjMwdx9Z0cLzFpiKWsFkqhgOBzztBuOeQi3Liop9NGPd6soj?=
 =?iso-8859-1?Q?g2aVfvLH0LYPc6nMvwyADoAmGS9jbpOVZMXBK3Z9LFbCwftE4cU18P+++h?=
 =?iso-8859-1?Q?0R2GLtJ8F9Krcwp577rXAHmTlx05GyC/ofKBPTEK1B+ZcALEOmFtRUdLAb?=
 =?iso-8859-1?Q?ShoYX/rlu1tpqnWRMJhhRx3ID+VIfhfD/KGqr1aKYgmOGkEFsnuuvHt1mx?=
 =?iso-8859-1?Q?WLlyDzK9CJ7s4mKehjV+hXgYTNmN4LY9ubqrfgZtJUkQI3rdK2YG1fZw56?=
 =?iso-8859-1?Q?vXNcHmSkuTDs0vZPbvzsDKRtEm9QKMKvxT5avP0Jgk9Al/didLAS/Mb0s+?=
 =?iso-8859-1?Q?VlbKI8I056cdbVvJgUm8h0L8v15mPyLyAVSPfdZqOWP7Dy+4uHLAW2SVmV?=
 =?iso-8859-1?Q?fuTChTymfBbvSxwdjZ23GuTPVUyL1jSdWBMhQH1e1qO/JRbMm3fABUyB6t?=
 =?iso-8859-1?Q?B5ayJQZ3t/WbyUL9N2PiSBYlMdWYsgRwTA98OG5pDDGWRM5blyAGtRNBsa?=
 =?iso-8859-1?Q?ZftV67p1oofKciIpSSW84SqK2yo9TxXqzC/Ycv/Ac3EDBcgv+h1URpiD5m?=
 =?iso-8859-1?Q?mVkIpYy3YMPKs29MtQMY3ff+AJJQjT7wc53F9JXnWuUdg9rdJkWRkm61ww?=
 =?iso-8859-1?Q?ZHYjQgDlvA9ZGEeb+YSNy3QgwCSdHzwGr0WIJ/Vh50n3uZVkFq/XelLO1l?=
 =?iso-8859-1?Q?2SXHTcE2x4SqHyuKcZNhVlM16rQiJhvQI47FtHgIDPaEss8WnQkY/afv+c?=
 =?iso-8859-1?Q?RDlMJ0VYnRFoWWrOAYtl9UPnYLHbjq5RYKb1nGlfpt3dpVK+U6s8Y9nCz9?=
 =?iso-8859-1?Q?m9yhUbqj5ICROPuTGkY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 380a84b3-7822-4782-6cca-08dc2652418e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:56:31.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KxACUwpFKGrtrgTfvy4mKR8LTx3EYf9UyEb/w2xRkt5zIlBIB/LP8Q0xBmGgZ+/IUjGuuzCI7tgt4Spz5IDeoiBcrqcwXyIuRt5Aho+fG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
X-OriginatorOrg: intel.com

On 2024-02-05 at 15:16:27 +0200, Ilpo Järvinen wrote:
>On Mon, 5 Feb 2024, Maciej Wieczor-Retman wrote:
>
>> The CAT non-contiguous selftests have to read the file responsible for
>> reporting support of non-contiguous CBMs in kernel (resctrl). Then the
>> test compares if that information matches what is reported by CPUID
>> output.
>> 
>> Add a generic helper function to read an unsigned number from a file in
>> /sys/fs/resctrl/info/<RESOURCE>/<FILE>.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v4:
>> - Rewrite function comment.
>> - Redo ksft_perror() as ksft_print_msg(). (Reinette)
>> 
>> Changelog v3:
>> - Rewrite patch message.
>> - Add documentation and rewrote the function. (Reinette)
>> 
>> Changelog v2:
>> - Add this patch.
>> 
>>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>>  tools/testing/selftests/resctrl/resctrlfs.c | 36 +++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index a1462029998e..5116ea082d03 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -162,6 +162,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
>> +int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
>>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>>  int signal_handler_register(void);
>>  void signal_handler_unregister(void);
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 5750662cce57..e0fbc46a917a 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -249,6 +249,42 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * resource_info_unsigned_get - Read an unsigned value from
>> + * /sys/fs/resctrl/info/RESOURCE/FILENAME
>> + * @resource:	Resource name that matches directory name in
>> + *		/sys/fs/resctrl/info
>> + * @filename:	File in /sys/fs/resctrl/info/@resource
>> + * @val:	Contains read value on success.
>> + *
>> + * Return: = 0 on success, < 0 on failure. On success the read
>> + * value is saved into the @val.
>> + */
>> +int resource_info_unsigned_get(const char *resource, const char *filename,
>> +			       unsigned int *val)
>> +{
>> +	char file_path[PATH_MAX];
>> +	FILE *fp;
>> +
>> +	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
>> +		 filename);
>> +
>> +	fp = fopen(file_path, "r");
>> +	if (!fp) {
>> +		ksft_print_msg("Error in opening %s\n: %m\n", file_path);
>
>Adding the extra \n in between there will likely mess up the test output 
>formatting (the expected prefixes will not appear). Therefore, manually 
>adding newlines should be avoided.
>
>> +		return -1;
>> +	}
>> +
>> +	if (fscanf(fp, "%u", val) <= 0) {
>> +		ksft_print_msg("Could not get contents of %s\n: %m\n", file_path);
>
>Ditto.

I thought I've seen some other error checking paths where '%m' was on the next
line but I couldn't find it again right now so I'll remove the newline.

>
>With those two fixed,
>
>Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>
>-- 
> i.


-- 
Kind regards
Maciej Wieczór-Retman

