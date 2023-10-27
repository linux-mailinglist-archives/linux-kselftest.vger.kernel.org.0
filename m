Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12EF7D974C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjJ0MJd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MJc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:09:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E71810A;
        Fri, 27 Oct 2023 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698408570; x=1729944570;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FFBQUmJ5/iit+2040NMvwzYH7S9WeeoMebF/BMz7ZO0=;
  b=LkfWDbLqKTyJCAIEZmy0kHr5FXmHEw3ictCTgCoScXCKhkbVM6KUjRZa
   DQjVT+gvaqq8lAFi0A4zYyYGzAnocou+ogYiWONCRALcOpsDaw597AKWQ
   uZjfPZBPAHlU9S8Z2B+qcVNxv0OQZfaRlB12TvKKZ2agVW+4nTRHmnW4H
   YKICvL/Nvbtflov017o4Q5U6G1Lx3zIUoyM0YMLk37DBH2hAoaOxAN8nh
   2gnrHHFev7f5DSlCzytgCFVw5gkAtDE1b7i+tCLky2DFeTAUFOha4p8Hu
   se2MCOcwYcHxac5AlJ7mgvtjRM6yQOKbCorvte73iYVgER3lASYMsK0yM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="384971724"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="384971724"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="759576094"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="759576094"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 05:09:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:09:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:09:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 05:09:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 05:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7DtKAsE1+KECF0V9pXBc1Sj69wkIpPDi+14GtrY+Z4F+q6Q/nCL8hwGSf4BHUmv98lGQjJgyayoSmdwIo4CFztv2EhUCydIpaOF1XwU5u90aKIPc0lcWYAIuUdaxizM0MS3/aU+yMoWJBHza/6Q4GtGJLZpWtfCiXOA8w67LOVeHIxSRovBvf5sg2dauPdUZLfrJ9IfqQssSYQcZnZirvwb1dx+Rl6cUujvSwQobMkJx1/Lmknv06sQlokimoaoHQZHRE7qRcpxpoqD/8EkcvpyHGjxBUamb7NmfW6sZKhBX+DTuQYjo/nHtoBxyrdGtwHi7aXNs0CwzhxuHbVfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XJjW7mIBufjS8oL43+yY7q5DbRJ32EgJH1J1mDq6uA=;
 b=KmACXpkACPejOvhsoIx85GzKb3V6qWhFrIGJkzktpFPuxfmqtWRQAwC9xvbVh7mUqo5Jsa9qWEuFDCAOeHvz4ywAaNTWiBrZePS+p+nwusW8MQGanUya/INbDbF/5nROFJgwmWoQAJ2zocyz2qUKw8Oh8dkLPb8qsYC9xV03VjuWIL2mVXrur1AL7X0RoCr6rEFVxn5WYM1ODh/iKrx50+u1Ty13Lr04lhv+65Be390lN9qE8ydl2ZNjirce5KvKkE4IbkYRxj/WKkab8P4bsWJNtwlpgfI4wM7NxRx5aBX0wEetWoaWk74WZdT7PCWujA8ffEnjK8UWGbx/KB4mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS7PR11MB6152.namprd11.prod.outlook.com (2603:10b6:8:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Fri, 27 Oct 2023 12:09:27 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:09:27 +0000
Date:   Fri, 27 Oct 2023 14:09:22 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/24] selftests/resctrl: Add helper to convert L2/3 to
 integer
Message-ID: <26lcwn4b4qd253mjdgy45rxvox2mcyxy43l66siluddxxyf2t5@csbaek2muotc>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-21-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-21-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS7PR11MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: d61ac1ef-df08-4284-4930-08dbd6e590de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrmYLCmqcP5oilglhUza907Y4iJyd/7MC/imuvAAH0iKPKFGnAIjWU7m6mZO2c8UvOvE/GqWU9TvONjziM3uIMPHw+EkJklt7I52GRPAxFPhEvPTHTgudKKrKgGKQbHiXU5elM9Z7e6ZWOi+UZq8tQISCYE1WtxD9Q//nzR2+BHN7+GGoeitWwMFNpo+YdyNVzWjyVuUi9KrKwdOO2pwH+PiRChuscdFIP6+fGr0j7D0dm97EKG6sPTzad75Ny9eJDnTtf3HezLp7dNn94i2DM1LQU1z+Xn3bLsW7qVdZQIOLgACYGe3qR/9m5oUWD0IsR/GTkB5qRHA0ziHpF7sPnY+flzJ8YVHE8yVbAGZvSGnCF5E+o2XbG3mwj3q+APFaLvroeWWpPZw2IjY5aQ/6DgIbWEAwwncF4HGTbkZ5tE6zYqNUPZIPWLgqm8RuNugvps3cpGXaqmym+qWLHXY6K3r02UNAQ+YFs2kwgXaUxZxI5chdoIU+VNFY6poCzvT0HxYHX3bnTSzDK0SUoJScW/5DawtTFv8HAZOspi0PdB819f7Oagw6mKIJ4B8p26G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(6666004)(6506007)(53546011)(9686003)(478600001)(6486002)(82960400001)(66946007)(26005)(5660300002)(33716001)(4001150100001)(4744005)(8676002)(41300700001)(316002)(4326008)(66556008)(54906003)(8936002)(66476007)(86362001)(38100700002)(2906002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lUyWh5/gLu1yplSs/ocd1px0o1A6jXfwJOvhHFV90SMJOhsqW4P8oLr1fj?=
 =?iso-8859-1?Q?+ZkudG2J50220S8xdxXm6QnhOsZ2Xb0BECMYTAPQCuyS/hrnP3/42vTBqp?=
 =?iso-8859-1?Q?1mb9ty3vsBwe+huwaltAQSvgwdwG85+QGAyF0zxfIuCWltu6k/5JeL28n6?=
 =?iso-8859-1?Q?L8IRyxQ+sBV4LXwX81e0xSg3Iug31gh6a4jjUY3CHb0D3QRngZ5IgBbGAF?=
 =?iso-8859-1?Q?F9LcvJA+GwAULeZReO0XP4FdqsutG7LN+Tj1gVOQiuM1iPQv3bL17qXgsS?=
 =?iso-8859-1?Q?dzgzf2FG/I2BHCBqhbppRR2K1cEM/VVRw+tQH2LcpoT3OalTmJBo8YrKZM?=
 =?iso-8859-1?Q?RhS6GiBgThe5wYp966MJ7Ww0DE83j/u1XVk7+OUadNLF6rWhKO9RS9g4UK?=
 =?iso-8859-1?Q?fEvRVhwkRLpdewS1H0crU309xE4kSTi2AVZx0IgoY7zUo6zVwWAT988+AQ?=
 =?iso-8859-1?Q?JX0CJd1d1OO5uuogX1+pVrHPYKO6cVwBWSPEbZfpxueBfEVESSHtUPmbkd?=
 =?iso-8859-1?Q?4GrrqUqdjh4Hx4Yah1t1DDThpx/rko8Cge9k8L/zWO5JQeg+7txUSVcp3Y?=
 =?iso-8859-1?Q?6SMJ7bBxi6kK0JATC5yEmjYhbUeEWVxyTMp26Iu8gYYDOHSD6fyUZ+gpY5?=
 =?iso-8859-1?Q?AsdEJJBUvj18NMtRCize8FJbELQqaUgFvrjluoQFitLSLc3H974H+iCgUD?=
 =?iso-8859-1?Q?zKuSxrRVFfYe4QZIixThjTjwWjIE3FMBq3JMu2IwV/nhzSgK3HqICJvYPj?=
 =?iso-8859-1?Q?ZudzR4ZgZzQCmZ74n5qfO6IJi1ZNnN0BPw/Lb5bRqRJ5lKcVGUvNU9fUYj?=
 =?iso-8859-1?Q?kXkzj+sogFmNFwatkB+eAYIJZ22cwfShhjxiINf9yHlY7mEVFKNGhhnL/5?=
 =?iso-8859-1?Q?1v6bWDWlaz1DCkzGjyaNsrxsa3MiAc2Ehsm053VnCQRuPzGTRbB/5m0P1c?=
 =?iso-8859-1?Q?8KkRXius+sMbLeAehdBFtJFPwNNvb626YBw4FSTAXddU9mW+zXwjZE8GGk?=
 =?iso-8859-1?Q?ENoRmARrdKMcBLpIUgBsfqV/2DesTl/5oRhagoIFCVfvIJWgX+l5+WdtMG?=
 =?iso-8859-1?Q?Tigc8WSUMarQKnT31tbX1BRkSpukM8tvSTf6/3OjbFqpWyvf43znXwfBNX?=
 =?iso-8859-1?Q?5MB/FcEXX/hplCfXyEzaNtTgQrd6LUEQByO1GdVTOuca9EJe8zLKCxmYlC?=
 =?iso-8859-1?Q?IN/RZIv7TRmQjJfHgHF8jO8/mbMFeTFgHRl24XUhcecOzlYelJBCPY9jV1?=
 =?iso-8859-1?Q?QYxLJ9FNKWdNeSriMHjjcDOzQqbp4w3urWcJM8Sjk1Ny+zaPjfp0mzJEzR?=
 =?iso-8859-1?Q?KsPszO8v8F+3/HkM96i+whMLM4L1+RGFwqwuzTfXXRz1Pk8pYFK4ZiiE8+?=
 =?iso-8859-1?Q?EBDWAEHwXCcJJ7kHxpxlbQvorVPCq/gSs3qWMNow8YuyNLItk8G3Dkpucq?=
 =?iso-8859-1?Q?mI4Mds/nM8B5tT0DeqHke/MyjBwwSn2Glrb+9onOTaTL73bITydBXbunps?=
 =?iso-8859-1?Q?D+Hv9Cay+n7LWMNnc0OajpXD/86Ga+gt4aZiA8A6J0LsuHdOBqDP2pkV8K?=
 =?iso-8859-1?Q?YUKQDgtFOwtAfMRNflVyc+DEWNTvHSUY5hacTcXOG9svgU9pZsKvaaDaO7?=
 =?iso-8859-1?Q?WubTnYHZdIvAma/p8dUCO7D3CPc9GpbGfWNwWId/a/kyeaPsdq8N6kJxFW?=
 =?iso-8859-1?Q?EJoUgfVHr9zys/GX65c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d61ac1ef-df08-4284-4930-08dbd6e590de
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:09:27.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxyeiA5+1zh6hYOj77YhhuJSov4Iz7bS190HEyL4ovl9CtquRSYFifPRgJB2ERLy6TJZ+v/xTiAmdRVbgW9QURy4Ql/Yf6JurK6ucZY7uhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6152
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:30 +0300, Ilpo Järvinen wrote:
>"L2"/"L3" conversion to integer in embedded into get_cache_size()

"in embedded" -> "is embedded"?

>which prevents reuse.
>
>Create a helper for the cache string to integer conversion to make
>it reusable.
>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
