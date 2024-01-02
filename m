Return-Path: <linux-kselftest+bounces-2551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CE821789
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 06:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941371F21755
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 05:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD631110;
	Tue,  2 Jan 2024 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuT7z4ut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277715BD;
	Tue,  2 Jan 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704174988; x=1735710988;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fHd6/+hJ3qikm0o7NvmxSCDuhGqcA6NhgUHExC2JqI0=;
  b=EuT7z4ut5bBTHLKeIhMkPoNraqKe/i5hNoeT9tTze5SKxXgHeKLh5jbc
   /CTMy9ALQYwQW2TmhyGwUSyrYxZhH6thZe7KjEha/lbh3NDntLjZuccCV
   yIAA1TvePD2Q5GQXJOvDjzpqoz+HMkwVA2nhJzftMBIDWkKuMiTIDJ6jP
   4x4qGGY8SGwuecVe0+7Ya6JACPtOs9zFMctU40MEl/hBTYddwfy6SioyC
   1vENLUeAf9Dk0qi3xmkF0NT0DZ2pAUdhMYlBSZqCgFryUz1+eiifQKhO0
   hmIjyaW0vAFjVvevDUK1JB2vU1fu5CqFYDk9H5j86dcg/IOV2uDK4nUtC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="461149132"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="461149132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 21:56:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="923126763"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="923126763"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jan 2024 21:56:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 21:56:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jan 2024 21:56:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jan 2024 21:56:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS7ulhkqAHF28+TQQVm3QRJUcx19oqgKuQUqAIBgf5nYKQBUAdPspAVV8TjWlKC6NysH/frP5m7C0h7qzMsdNC5aA9vMAq/aqWDBliusA4UVgZN3rUe/s9J+qsImyAcwISZpRXC25C5OiUAOS53VLDT1Pvkag5Iaegzyo64pmydMTxL7VsAjJNITv5YibsF9Q4Xs03cL+glanuzSoiSD6dlL4+FfJFLSr9KBq4NoIxCNHN8XrMCYfUPMJmxyauBuWufH3vA4Jb/GoQ/KQxKOnzFDAVjsCTiN7eHjaDf0ckkfcdXsLe1MlJEkbKfA3omB+rZMDFcdd27LtU47v30iHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Chpi6GRwZgP2jlYMnYkA7rBboljRTkt1E6ha4GkJIHk=;
 b=fuhToR55ekPKwzsZA50JlaD1peK+3ViLTHRcclXe/CZ3ZSYW+fWfMEoAELILijQwGxjE6f2SY1t3EqvPDl6PXFB0673KCvSUWQMTPwdu/B5NpiFG1wHN61qqvutJdFg+lW/yomlNpR6w7V8IZsnVOWkxDpqP3grmACLIX2KwA4YGzVQZC0gZfhe/IkiyfyiSqJEnIes7+3qv3gzUAK/aMB44+POCxsL9gtuSFzjCnBvQR9Rit7AQdGosVWFrmKT39cVhH0qvdDI7oT+lQfEHZDb2Mqn1gynxnvEozTrnnB7ams0KthNqqcW5D18X/FbUsPqyxLs0y0D53Vm1h/FzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 05:56:23 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:56:23 +0000
Date: Tue, 2 Jan 2024 13:51:56 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Guillaume Nault <gnault@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Message-ID: <ZZOkfPgs6T3ujpJo@yujie-X299>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
 <ZZFbxyQeHgf3UQrN@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZFbxyQeHgf3UQrN@debian>
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a0c718-6d20-40de-8c82-08dc0b578cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pR5SrzW1/8dPTZZ8cjk3iZjSZDBfPX+PfGwqoL6H5cdm6oe8XbJWQ5on3351alyoHkfhaMkXpgGoTe+wL7PvLJGOOXV8kwDAD6Epd8M/Sjwb8GP3fXvP0IL+BFfY/+TlibzGXqHtRtv2HeyMycSwsJQV1Lx5pjVY5JYUMComrs+wtOidagNWoKJ5EZp07dc6JKk61Vb48icimohvUTTb+L6LwOCVxLYGyTWQOTwHavLZlcmalVVpp6uQP4k+M3lr+0SodhtTi2IjxrTm7DDfxfNuD0+XNOuCQ9RiPLGm+ygHLjOv+D0YihQyI/qnR10YssonN0pspduiE8V6G5pqc09LNHrkjOZNInqGbixr6MYmwU2xbmky9thPRGqrCFFqQ3hisusmfbl1uTR9KbBc9F8WP/j15CR6CgkK+hNQaNSWUGWSQ+9VOwOLGO6oh3VkmNyK9ZJxBfdf11Jv/UfCnP6ChO4BWB5wDB53F0cDKrFwT9mySRatH3GvL9UuwGWXUVAlmITgE0FXx9PvC2SNp/z2w1OsDyxIKiRESnP+IHH+OzreWBpSrZPnDQYYchY5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66476007)(9686003)(6512007)(6506007)(66556008)(66946007)(86362001)(6666004)(33716001)(38100700002)(6486002)(82960400001)(107886003)(41300700001)(26005)(2906002)(5660300002)(4326008)(478600001)(316002)(54906003)(44832011)(110136005)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s38ERXWAh4PildIuRaXmCFAWSgjwcNBz4slEWL1k5U3+uX2Sk1i5XgJ76V03?=
 =?us-ascii?Q?IGFIfuL9PBfsWE/M+kDX1kvlxM1NmZb/grLnzQ0gaFvdzM6D0Eo57dohlPOe?=
 =?us-ascii?Q?Fq71YQmbaMYwl6xnr3w+bVhF+RtNsUXpuWb4EPewVrGzbuLDdCnkTuSE91ks?=
 =?us-ascii?Q?dQI/mrK7VKt+03r8v3LVf23KPI/zgAI7jl03awef6J35ct4Ed7vdNT2MmRI9?=
 =?us-ascii?Q?cUqtdsjIyJ89aNhUVV2S4whuPf/dGTfrsRxxOHSYLgqLcwwmFJ2/KO5P+DzX?=
 =?us-ascii?Q?UkKssJaNuMdOqCw+Y9epHN2TLmlw4YfBmefdpfQWtMGEhNA6Z12iK56kumR2?=
 =?us-ascii?Q?H1Ewp5fY9aDDG0q1dlLCYYE4P5UbQdMLtF7ose9sD7dr03AN5AuoRxs+dXi7?=
 =?us-ascii?Q?cXQTaBgbzxFYySwncmX6Ufa7mxI+9UoTvx2tCpjxccMT9GpXpU5ZuwiSEVDC?=
 =?us-ascii?Q?P5sK8Xa/os7CfUPZdhEKjNxEWQBsW1peWw6nzpAlib/3Az488DriE2xtsKxe?=
 =?us-ascii?Q?IfqJAGohftsxZsR5cNu8n6FN84SdKRSWOLbMZYPZ9OcBVlS3qY9PBvqZYZOe?=
 =?us-ascii?Q?qkRaGM6mjH9jvhmvtyovZGrO6wyV2tvKb9tqQGJBubEvFiGsqnWICl/YvsZC?=
 =?us-ascii?Q?oaIyKQjb6wV1fjnsv6rxQ9Erxhhe7OiYytbuiCU5Qd4LfAk00vtnoGMhHiW8?=
 =?us-ascii?Q?uey65O1l5zmhjWAoamgUPih5Yrl2cQrWHtaVyuJszoARA7tYe1+wET9t0x9x?=
 =?us-ascii?Q?tApHjhBgVNKyTHfb0UjOY+QRJpUf40/qQ0+Z3wo4Yczy5O4yHctNaLcsnv1E?=
 =?us-ascii?Q?xoUKW3ZLmwGWBdopONh3NldrZH0Lwo9VN5AapU7TX3finIIJhfUKntkTMiZH?=
 =?us-ascii?Q?8xO/Rtm8wOMtIbeSO3VFSWf/J8Q9OVQyIj9H5pr6Oy1PvpEJ9F3F+x6KzzLz?=
 =?us-ascii?Q?uYo6PQNp8es9igTW0j6rWsMIet83GE3iHX6LAV16gcw5PXYVm3lKMu2eFuOl?=
 =?us-ascii?Q?v2EchTazLPXFMqOR4crvvWhf2I50pUx/bZChHFHwE7wIG/Wma7x0ZMpoRk6D?=
 =?us-ascii?Q?TprbLVNmqAhTIlbmXOfiJFlKEgdsYhTSwNfGUP8Iz8iEj94j1hV71L9FUTuW?=
 =?us-ascii?Q?Ld0N8Qb4+opyLP1YIV/BxYoRmcQJ+llP7tHIzqzis1+PJWWbwcXGbZe7rFT0?=
 =?us-ascii?Q?ZBAB7UFYMFPAqjrjMFy4LF2htwWAK813ftAnIK89oT5w/Wz2ZdYfBvd9+9oO?=
 =?us-ascii?Q?S0+n9IDnGPiB3aN50fuPBmZSiYoXtV3PRAYnW46hOlRRP1UfvUJIQU47vdNX?=
 =?us-ascii?Q?S756kpp5MfQ6kb8mZPLvDyC+Kg7Ea6Hwrx5/7Qs3TG9BotjbqA9ruzoDk8k2?=
 =?us-ascii?Q?5GyvqdWUNXGHdM57RLACra0+joCOnQ5WiTCj/K3PunKN3WKse995PUEKesNj?=
 =?us-ascii?Q?1DS3qZFsqNzEeoEyu3CBFjH87TE41yaqqSi4byFpceelKYz5R5N8vwx773mL?=
 =?us-ascii?Q?r001ZSL0nN8h6pAVsy2bMGdNL+SHZaM6XCNmHD3fKhmxNadR1JjDR6Uhzwn1?=
 =?us-ascii?Q?gRDcxDlKnwbO7OT5J/cLHrxeQJfro7fuyZKMda3G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a0c718-6d20-40de-8c82-08dc0b578cca
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 05:56:23.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RW2EUqFaqOAGlo3pBneVSmaUZAxAfexGEvghe4JON3ox+m33EEVu88jn7JqWzNwklgcd5un0Kjf6lr89VokuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

On Sun, Dec 31, 2023 at 01:17:11PM +0100, Guillaume Nault wrote:
> On Fri, Dec 29, 2023 at 09:19:31PM +0800, Yujie Liu wrote:
> > The patch set [1] added a general lib.sh in net selftests, and converted
> > several test scripts to source the lib.sh.
> > 
> > unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
> > have a /bin/sh shebang which may point to various shells in different
> > distributions, but "source" is only available in some of them. For
> > example, "source" is a built-it function in bash, but it cannot be
> > used in dash.
> > 
> > Refer to other scripts that were converted together, simply change the
> > shebang to bash to fix the following issues when the default /bin/sh
> > points to other shells.
> 
> Looks like it'd be simpler to just replace the "source" commands with
> "." and leave the shebang as is (unless there are other bash-specific
> constructs in these scripts of course).
> 
> Generally speaking, I think we should avoid madating a specific shell,
> unless that really simplifies the test script (which is not the case
> here).

Hi Guillaume,

Thanks for the comments. As this is related with a large patch series from
Hangbin, and other scripts use "source" during the conversion, so we may
need some input from Hangbin.

Hi Hangbin,

Could you please share your comments on this? Would you like to replace
"source" with "." for these two specific scripts as Guillaume suggested,
or change the shebang from "sh" to "bash"?

Best Regards,
Yujie

