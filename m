Return-Path: <linux-kselftest+bounces-6043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD18874AC9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 10:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8306281619
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80217839E7;
	Thu,  7 Mar 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c87OaK/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6663409;
	Thu,  7 Mar 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803561; cv=fail; b=J3mnWl3OPXiBQ1jSiN2veRhZdcgRb+5IyqKyenV+UMHFIurD6AT56I5L8d0EYeFEPoFlhNO789Fpc0ME1todYBSh2XLCp5escf2jfyOggwhuIITakeVNakbQrvbKzimmAcBDuuBwzuvI+sHfI42ZMQD1wcsw9UkWbPkXwr/hUw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803561; c=relaxed/simple;
	bh=0V02cCzJ/ruMawYm2M5Hto+C9nbP8EPz2ERKyaUol0g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A7f1ZpRtAUeIGGDsiEzNbsC1cglzHxynLbSastazEWJWVER0z5Cxg17KdARkCVcA8lUVLTOFCYq1pL5zei/6vzLj1EiPtAPf3vzK++y7fqZ14cVZ2UYZZYgliFOgK7bQUT2LiHhwd/a7CzVUPHQdpxB7jDRItOdGN371m7I9Ma4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c87OaK/i; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709803559; x=1741339559;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0V02cCzJ/ruMawYm2M5Hto+C9nbP8EPz2ERKyaUol0g=;
  b=c87OaK/iaBoeh2ejY55akIXrzk+81DvcIUGLu2zzZsid3LhtAv2H7Vcq
   uoYZmp7onRYMuyVGH5vlvybStv9A/pOfJcUxUyfvx4/K4LrzSsy4e5YSJ
   IVjLevCLu7Ma0MN3mZiTiGipEM9L7BrkIP0GhY0BuDS4oChhbBZWh/Zgr
   oS/CywQasVYhkdEEH34bNGIeuaOQwMqCubdzeKixF4gnC68aAMO+6logL
   NsnoT5LIezTHqjfIHiPaoXzKPrfLki72xcz5OgaFrjce5XFc3ziPJ4KsS
   fjxkoXSMpTqyhsD7B5chCFGyUv+CO9k4jFZfQcubtM8U7kcmdLT9Kd/RM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15184423"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="15184423"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 01:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="10493779"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 01:25:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 01:25:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 01:25:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 01:25:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 01:25:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNmKa2UPL7QuoKGTHsgPSlrIy3QaiMNMOmNUaiZHm0rYywKjSVoJbtyg7rLc+AZW9IWVohvBB193LsNUaonmf6RTe5Y/hTVS9AjbYrP2chaq0Tu9khgj4w9rj4wE304tlv/KpKFwhF7MPU1ch6ScgAMYJO94R0MVSYSXAbrJQYa7o2FHDsckLy9wfD9qUIO3/RNcisuNSa7DS/Ng+G6sZGpXSLiEA3haklv2FfOMbCGqlAma9M4GDRy86qP0co1EmI4A4sXWRJmcgdFTKbp6uTlPF8JWvhEYnmEgWnolW3C+ZMxYyv7Rj+7yMNovvDi5lHw28wxqMMsw54Xv1BLX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xmSdBEBEoJqGr9KTe7QxH+1tQkOc1LPuMOAjbG/eYg=;
 b=hOGlJZygfryw1JDDaupRD1nCbq/WXRtYfzzIkuzN3k+EUpFs0+UjjDBmDZTls3M7o8ikiwQ7sPwcNdiMxTUpKeMx1jTuunSUH0sGAbzN0u+EMu3KkqajG+UL34bV2Rt9hk3zXa0hTrjdM0WI8acAZcdUUO9zQODKyFu96KoCemJzXtqn7O1875YCCgmEFUmlEAh4RcChyaVoyM1O9bY+yjBmepm+59n6MTiVZCynIXBtBvLK5aBshqxSaJtCou2imhspaE5KVRxqmdYyjwNPoQIll+5YEjTaJX7jC/C6vuiry4x6kKByEW3yW+GTxP8eh122b1AMZm3YBapjHc3uPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 09:25:55 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 09:25:54 +0000
Date: Thu, 7 Mar 2024 10:25:45 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Message-ID: <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: WA0P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::16) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY8PR11MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0f0e61-dbfa-49de-9da2-08dc3e8896c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JFNfHWOuH1feTGzyUMQms2z0paVjUrzRTJGRhgmiSJN297tNK9CpgNEmMlV1FxP2h108aQgQEXbZMZ19fjY0GPpjbf/uJ3zIph5fFIUW5HXEG99Lw4KcfnPhPKUbwfPb/EG2Ru7xstCGyLvuvc1MdXLUmDjMNrsuZx0+oRSQ9gosWVuiojdhYetOZiX8FTIDmuA0SaECxuzhEcdAcA7gpd3KnfMO6/LE42phsfYjp4H2sH/5XIzjXrLZsB9ddr7Le1D0HUNh17PWe1mrvnp35yEkDkB3P03BafG06Hk9IrcHw3lcqYuPAP0GuHLcSgCcVSeD73U9WZ9unpN1o4lt81DW904K/uS4D5RgYO9tD5KrjtDbLr2qR5/MHADpthUYQzcovtECbdMYgpZD3ujCxTZxXnxbmgNbhoJofh4aiFJq4ACL8WfoKpcN9pnh7FD0GzC6UHfvmlEv1+iGD/NV/PGe16XECirlmzijA/EN2SqKcLfxd/UuWFu1j9h2Q+MnDzDUnXqILFbmAfygaqCop+nf2jajU5QdO4RmoWrTfKyqu4lWRqZAOErzjuyGi+eX7l4a66GP55RvT4hzWMiUSWip5gDwX3Gw6iIa0325B0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pg2Oz/fQ6zEmu17A8snpTzgw+ja+Sfl/RWT/H6R8sX5fyjUfdbwhhSQH3X?=
 =?iso-8859-1?Q?fkMbO7NUHz3O/AGLIu8/PQFt68c+DO1680hZuRdp0qVohBKmf9grt3PEjB?=
 =?iso-8859-1?Q?0h6n7+irmrQTeT2g//PJIUi2qis/1hIMa3cuddzed+BHHE1eOFE217by30?=
 =?iso-8859-1?Q?Pi5vfe9opTLeCTaG3SWnk8Oe2JN1GnwSVc8785geMS1f5N692PZwsN2xE6?=
 =?iso-8859-1?Q?6HSZCu80A1H343vpC2Pja8gv2LSHy/bLPV5bHw/l2MKUdbtMRtBYYJiIZ6?=
 =?iso-8859-1?Q?IJm+U8Xdug8uz2Ty2tE9WgXQJntrf3t9WEdbpMxU6w/2fCil0Qncia+PLc?=
 =?iso-8859-1?Q?vip6p3y1q4hNIRbNbBEmEFYkv5oMOZsfleuF2l0UlclzPgEfjUIvokPWG4?=
 =?iso-8859-1?Q?PwlGwQHcgQ2RYlyqSJmKPI8oaLtJoMPTCXaWiD5bF0XGIBsVkhrJ2cZaqE?=
 =?iso-8859-1?Q?ODraAPB1krIUQPSOnlliLd2B9HfNsvCKFU0R5QtsNRDbNziE8LyzPhCZjR?=
 =?iso-8859-1?Q?HVzlRAqpeyfd1EnrlNswdPAQdL4lbR7AX8SVYyrCqEls1lNW+qiBX9LvGf?=
 =?iso-8859-1?Q?BSqgSeb6uFT8iNjVCfFYTY1n4EUP1VaMle6uegJV0ceQOif1vhnK3giEq8?=
 =?iso-8859-1?Q?hs34oC3pd7hoigMuDrtyI958E91KDVyupu9dBPfIcgID/gMibxIyfCmDyQ?=
 =?iso-8859-1?Q?+pRGVXLLOyUKGPhtxR7brOnPZEsFzuEDVOiDzdGyIN/vlryTPgUd8HPVRA?=
 =?iso-8859-1?Q?/PGoLjtU5X9XUZcm7rp+DjSELZzATn7veMDB+c06ZM1z7x7xGTrudvD482?=
 =?iso-8859-1?Q?w/fiNiATMdTBmfy6QWvYhIZNFHcYjy34t0ytHA565WatEvz0SmH4gGIDBG?=
 =?iso-8859-1?Q?2mCkMkd0VJnybDaigMqIUbNXhy9k5KjtkpazDpkRX5Z6neuLyGtB5DPH1E?=
 =?iso-8859-1?Q?R90GyzD7CP4Vkn28WQld+794KAeTEGe2QKQaVbaUsrJgxS2ebl+ciJgvcv?=
 =?iso-8859-1?Q?oK0AQKMz3QTfyE4u5jtaluqFJG+Ya747kv1yoPvrzusLTWS+LSgTGXQ421?=
 =?iso-8859-1?Q?X40lRv1oScAwJED1Hy+4vp4SfLEKKI5WFSLMmjfNsMXzI3e9VcyhMx4cJX?=
 =?iso-8859-1?Q?yMHU1k5JaKvU90/FSliIWAanOK1FLkQqq1CFdHzWAtXRd6d9dyUnIoemIo?=
 =?iso-8859-1?Q?esAllQ4QFaeuWIgL/hUd0wsbgW48U+nn+0Nx6DaqXEXk6mE8Jodh144J6R?=
 =?iso-8859-1?Q?ZWIjigTydm/JUreGF/S6Z6cNnrehqqJbZ4idEQKqm8vPDRzike215R4kyV?=
 =?iso-8859-1?Q?2Y7NhtUeOVToVpaACuMhTvxg5tHq8QIFkAirzJjLbi4RFQysXYqBXh1dST?=
 =?iso-8859-1?Q?JzAwxSmhDQsA6tUUt+6eXCKbNGjSbdjlgLFThgRRdSoWbyZB1gyhZYT0ca?=
 =?iso-8859-1?Q?lMZhIdZNtQx0HTKdevVU86lzU7ARlaF0wAjuZz5XHIyfnfrDkADkGTFjyD?=
 =?iso-8859-1?Q?9K1oiifKzhy4Ol9/MTVAJ5l4lPJmJ6TSuCfWksUe29s2WQWDY9amM0gA19?=
 =?iso-8859-1?Q?bTqO3PW1cc7lh7kCUE5qptW8FWDTyE8zy8qF4uSl7QBw5WugXzyVMiJTsy?=
 =?iso-8859-1?Q?vO6ZzeNti5VELC4fDDIve9lS6rSrmgFjFtucil91+ByVTeP0ai9bjii0Lq?=
 =?iso-8859-1?Q?VG39672gEj8+Re0e3l8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0f0e61-dbfa-49de-9da2-08dc3e8896c8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:25:54.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQLVdra18MPK+V7GW9LT8jBvxXihA86YInTOyC1KjNClXkpW2zeAzsTGS8LAHfNOOZ+yOmSaXWvdjFIk6Wkixsw8YTZIjhWtuz1rvq01V9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com

On 2024-03-06 at 21:54:02 +0000, Luck, Tony wrote:
>> Figuring out if SNC is enabled is only one part of the problem, the
>> other being whether the kernel supports it. As there is no easy
>> interface that simply states SNC support in the kernel one can find that
>> information by comparing L3 cache sizes from different sources. Cache
>> size reported by /sys/devices/system/node/node0/cpu0/cache/index3/size
>> will always show the full cache size even if it's split by enabled SNC.
>> On the other hand /sys/fs/resctrl/size has information about L3 size,
>> that with kernel support is adjusted for enabled SNC.
>
>Early versions of the kernel SNC patch series added an info/l3_MON/snc_ways
>file to provide this information. I was talked out of it then:
>
>https://lore.kernel.org/all/f0841866-315b-4727-0a6c-ec60d22ca29c@arm.com/
>
>But that discussion didn't consider the question you discuss here: "Does this
>instance of the kernel support SNC?"
>
>So you have a clever solution. But it seems like a roundabout way for
>an application to discover whether the kernel has configured resctrl for
>SNC mode.
>
>Should the kernel provide an info/ file listing the SNC configuration?

I suppose it would be a benefit for other numa aware applications to have an
easy access to this kernel support information.

>
>If so, what should it be named? "snc_ways" as a kernel variable was
>later replaced by "snc_nodes_per_l3_cache". Is that a good filename?

"snc_nodes_per_l3_cache" seems okay to me.

And I understand that the file content would show SNC mode and the presence or
absence of this file would tell if kernel supports SNC?

>
>-Tony

-- 
Kind regards
Maciej Wieczór-Retman

