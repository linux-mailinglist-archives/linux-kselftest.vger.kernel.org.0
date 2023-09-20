Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED4B7A78D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 12:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjITKNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjITKNv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 06:13:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74794;
        Wed, 20 Sep 2023 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695204826; x=1726740826;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MXZsMvfM/PTS1OqKKxUeKKs73pl+BDqPGUkQDECMhTw=;
  b=WvozUsUupP6H0fnU3C8R8RzeqTx8RJQPS4iUVFVEImA3WPvYfOzy5fK/
   AvIWRce/dMK6cBpIqcI5rocQciS+GFGdRu/hLBzc7FUJEf5xJcpWTmTjz
   Z/30wkETEgU1yC2+itX3GR/EUte1a3x7zQmvzJRf9kxt7n9TO9z+v50l3
   ybuZ2oBt3S0OhO/IAXefrvjDQNderVOw+Yy74QW/BJCxpT1XyQYjELMPJ
   oA6EuxktvX2ToeweQLmxLOpGWKYueGyVtpW2esdErBFEzRlIyA5bXLbjv
   fHAkmg0cHjuVWnJGeY+XEV/wUzIh/DG8mtz1W6lEViriRP3I+FpIEDj0D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="360440962"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="360440962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920229680"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="920229680"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 03:13:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 03:13:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 03:13:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 03:13:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 03:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMRPg9vzh9dg+byx+2De4Imdtg7BVOE3Ohu7cry7cHrtQIVfPxE0RIANstattdRBIQj3Yw4iUtxvxYxMdegHRQpaWj8IPeAe0SoJ7euL8EzLllVBAXMEMotdG96Pt1RnipWYzeKldFLh8q+6bxgVd0ptZLIS7Zn/zeCfVgm5ukA7BK83Rz+1/gsC1Ww23a6SmUwdQjqrokodp4sTRiazFo8YeSBavQchWdOaPr+dFaMmA4znuDrpB2ejSy2Ie6Yk2QCKm3p3W1WRSGzdq0yzFog4lNlhMpdTSv6kfkQDucLaqWw28cnQDVBngyUMsPeYMauSM6cPV5P865eczyyDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BWxV+43FIjRAhds4nA0W+YISl9t4Ody4x30WuynfTE=;
 b=gHisycLHMy7QvpDpPH4Bb0Wwhv1bddsWDi/YuVDO8Cvg28RaX43FtFe3Bz/nZtMEEQq9jF9k/lv+gYWrH2pJ6I2D8r89k06e9xTetoiofd9MIR9HRNY+l+uIgmtol6vBQwwxw+C+MB9oEq4yKK48ZpBMF4BbDpcSqjm9umPqrp+I9+l5WsXHoyjCbTb4Lxdmm6dIg2TvntXraaJGjz35efOTYBc7f9borvpFwq5xWk+8duiZYi8EcVO6qyl7Md+o4Bl6QfJYoMnXhVY79Lu6sLEecAmHb1MMkMT9Q5YKwjscPNKDElooTxZzW0eUM9csSVNyE5x3oSnvqrDoJJeElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Wed, 20 Sep
 2023 10:13:42 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 10:13:42 +0000
Date:   Wed, 20 Sep 2023 12:13:36 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] selftests/resctrl: Fixes to failing tests
Message-ID: <4dbp2pvuckgbphc3bgwo5xxe3tbpwtibhqd5aykotbjrzaro3q@gcu72ie6zs4k>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA2PR11MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b26454-7f28-437e-963a-08dbb9c24461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4kPL5qF0NjW0FW5t3xwTc9ZLCSOUZvq4eXdyOxWPYdAdI0/A4Y+czZ+4YwKpqBr18W7EhT0cRcKi3AQdRjdv61/FWvoCzyVY5bkCp6Anup23SR0uAQcXJgt/QqrOZ/D4yW9qYatEkBQIpbvmt8SW+SObSH1OsOi3TYWucN4cQQO9kLwIcEWOZDHy7mSgZ3zZddIhYb24MGSbAUSKJN0LXJSxFUUGs4g5UrRWKEad5lPkjGGcOyFORPHSpiFWO0VW8QAL3VDAtY/PwgiiwnCAOnk4hlOPpCEncnyaodQcOns/zCiKq2kP4hhtBTYaOxgg3rxtu7nq2GbadhfGTITtovzDiRo7Vel54iV4xIneQflL6BivWTX7gGazuHZbiCLdBS7X0EloYCpGk29rc2weaiDOTU4o4HOiy712vd/rO5+lezhrHdb5KWz/DYtcfY5PIv3ZfN4bbIZnDuxsaOBN+/0fLB/lCuRdwQe+6a9Nkx053GCznu8hdKvnfr0fo5jIURy8EYiHaTRP0YB2Cv7DVlY2SxWuM3OjWbe4b3bMyFGiT5aN5w3DUskmINY9ZQa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199024)(186009)(1800799009)(6666004)(6506007)(6486002)(558084003)(38100700002)(82960400001)(86362001)(26005)(2906002)(6512007)(9686003)(478600001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(33716001)(54906003)(66556008)(66476007)(6916009)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uYczgOyhury0dC/r2a6kRil+wvKGO9psCfVMrSAz4oYgp8hiDz6bH0tK37?=
 =?iso-8859-1?Q?7+Att9NhoNAazd0RwiK2LUunUgm3ao4zNaa1xQJkftqnQRJuFRz1BsqxKL?=
 =?iso-8859-1?Q?pJ2pkWmVps1tqnCrzNGurBxw0jQiK1QsYDounkDYJgiGP6XPP/nOQ2CkmO?=
 =?iso-8859-1?Q?AsbH6Ld1GXRF/zVp7a5w8wHOLQTre1ZatqFmCNQkm9wMIUB4sCBtzxw1YV?=
 =?iso-8859-1?Q?HGPWqgTSmtz8H2FhTAHVZcy7ieBizPBFVtYcO7WjxT6sILgGEAOv0RbfWH?=
 =?iso-8859-1?Q?knnwUTe43j4lf64a8S9bBaalP6gbXgAVv7arEzsI0Gj2uZ8Phvp0nagI0G?=
 =?iso-8859-1?Q?KV6Lw3j0z2tgDnCspz6kxF6IC5gUc/CmHKNnSoe+j3Zg//bLXr045oKL7V?=
 =?iso-8859-1?Q?0WYH4bafF3tmIw8wo+e/HT7AY+laFcr2DqT+1fxqVL81Sdde6JiPVhGPVG?=
 =?iso-8859-1?Q?iXzTvH7JIdLc4dQxVMr0j+lwN8gL14kU7Q7loRKl5pFYdwgspyFbZphj6L?=
 =?iso-8859-1?Q?hPHLkAKOU6c/a/Hs8OqCEZdKXJlKkUiWXilrMXfKspMNchf3Itlj7w7im3?=
 =?iso-8859-1?Q?S4oi1NNn9EAMFlUmRQzxoisawStDdsKL7Ga50GtWKtposhScITgARp51QK?=
 =?iso-8859-1?Q?f2WthnC/wIjRiUBVr2Bs5EG9dBO0Sn6S0TU7GFm/koq/cAfkesysmgNwfR?=
 =?iso-8859-1?Q?5zlDKCDMViluM/KGUKkStlcPwG3TZfghVQv0ghgs57lstRvXxNGi5yoPu3?=
 =?iso-8859-1?Q?mcYecqDwvfNpqWxN+985Uhw1nYX+HTbZglk/EozTgJIe/k35wlOrw5oT80?=
 =?iso-8859-1?Q?hlwMym8Ps0m3h3mwAC79BqyYxpAoSz+aHRhy3jl8pCIPNWoTRSkfMGuu1N?=
 =?iso-8859-1?Q?JBjs59X94a62XomVGBmTIl9M5ImEEgmBPbI+L+ZrcctGclNxjYtLgRXB39?=
 =?iso-8859-1?Q?PqAd84havuGNkWvUofOGt7QPJ4nwRvfFCcrz2SzBn3XaeKrBe8kvxn8wo3?=
 =?iso-8859-1?Q?7v49MzMuxqTBwhE/cS/kf2stcydrfzHuN/cCUyXnI/0Kf9tOE7fpF1sYA6?=
 =?iso-8859-1?Q?q2mN37OXoadg4s5TItNMgLH05h16Fv//2hnVyNMXTFV5GBaFvcaJAmtFuD?=
 =?iso-8859-1?Q?Utp4KT6jfQWLLw6PRxsl0Q5jEf0Fg5vJLObVXdg0VYHvQNl7w7raVG/PgX?=
 =?iso-8859-1?Q?ugSOP/apekUrsteYJWI27hIOE5R4vj8FDfwlrSUVdCcLM/MPFHLTeosq+w?=
 =?iso-8859-1?Q?oZSHbJQ5bF+INwhTJ6Jor9lCTOLZOveYQUF9efvTW0Le+Y4TEDHqKnSxdb?=
 =?iso-8859-1?Q?76bED/fWqnI4bm8lJxj+0ICwUrTg6ecZlx6VrSAF58bz0l8hoDlWMHUuh9?=
 =?iso-8859-1?Q?2rjTy94mtA6AIwxFLKlMZSf/ZAVBC+WjM3pgVXi3aMYW5pntK0dC8CFxuw?=
 =?iso-8859-1?Q?pOJSCbzvkfza+trl/UWhw84dBzndhB2iWKHXygu57EivuyBz8Jp8XjliEm?=
 =?iso-8859-1?Q?flZmKD6FclmGAaOjspA37j6BoXaEaD1a/Ri5KpEsb+Tb2dafLDqa9DbkJT?=
 =?iso-8859-1?Q?7tYDSGygKZ4bjqEMQiphiDO31xMVmT5fEL3QhY1WV5xucNR7iB/ty0eJzL?=
 =?iso-8859-1?Q?1JsoBkVPYDSpUTDHbryIw82Vc6ItBJij3bDlHq5BroS8XpkKwgt70DhTbK?=
 =?iso-8859-1?Q?7odOR4kfDAn2tl/gWiw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b26454-7f28-437e-963a-08dbb9c24461
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:13:42.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7TMMkiax+8C8ySvskol/Yl1u1eWAoQHZTOK5OMmOFKkv3oRsA4iOdmMqyNnFMAf8M3mq/qjQwxVYlO+rrBP0TIeQU+ccrNwgdyjpZjrxHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, looks good to me. Also ran it without problems on Intel(R) Xeon(R)
Platinum 8360Y.

Reviewed-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
