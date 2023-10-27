Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5E7D98A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345906AbjJ0MnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345904AbjJ0MnC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:43:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761210A;
        Fri, 27 Oct 2023 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698410580; x=1729946580;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=puol2HJpGGZ4P0ZtECFhTBMLCqeurnc/Yepxutg4wAc=;
  b=Byyc1kj/nUk96ptECrWdQV5bDj8URzuw2eBf2PqkD344pXlbxgkCCXgD
   0210B8+Iwifc4Tzn911brbZ9AAhjTVfjp/udMOP3xu/lXMNI7gqn2A/Tp
   yJkIrBIiysPLuZJpCItqyBJXxF54RxcfgYaC3LCZhV+/VY7KSz8MBz4b6
   iqORj1IWKpfvDBGPs2Tis8+CDI5TBd06u8RvpcEGIwLMTsPUFC4/OYmG8
   6iHf4lY9Zg97BeXjAC8wlwUU7HvVfQq0G7NBLHozX3qEKMbM/QE0S7iI1
   Jd5/BEzf83a0wAkrGvu7Dsi2tcwFZGWJ7PyO2HzmzBCVcWHLHUuOX8YWE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="452005336"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="452005336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="7219466"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 05:41:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:43:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 05:43:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 05:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiUF6SbbiCkzWKJQkBnopRNx587KQxAd/iiDL4h2doKD/77lfF38zOsMq+Xw99X+LO+EZVfJkb6D3TM44fdbd0tCfXAU53uywCiTStzUfC+LUvuPxB2X9fdfaNMP4PgNBs6qt68dFuHEwEOYEMcN6m9lNBslnMxDyu9fv2/bV8Euiy0jPA3GNKan7Tcs65H+5SPZSPHKuyjOvUnhL1CJj6LSstDl9uyY/0DTNxfX1kC09XE0jzSQvEvl7QXCeS/sNRqxEBotThGnK7PO2426JKHFXRsb/yRr4yRJClrJnhfVXBHmqHMUj6bz5e95RkEhAoIzubqbGRQhbgkTQf1T9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPnjE4Dq3XbQBuOJfrlfvE5SZSAKEEB8utTp75dQ4bM=;
 b=cmp5QFPwvnmBTad+9tbzAK8YlXe8X7NdptkRxi7MSCnoPl17nsm3F0+w/Bi7grpi913IHK5a7WBkxTlBDLJVvQsmjFWf6AngH0l86B1jRtcDyFVSV8SSE9IHLCJ4VKLgl3vXdFcQOC/xRDGGqLam3MKibefuTfnXqLXihAyTvIB3T7iRDOxIXScFG8ZnuImJLeH/PoyyaCwADTWRgPU5pnwJxPbp2CxiIxnQUTsMrNv5zFVk+cJkwuk+/EECf1w0Ckry+cw1W364sXvRYAdXJ8+h3rUaEXRUeMI1Al0W04YPS0bjMYX/4K0h8PjwPkvLwqxPUSi+LQhQ4pOboX/+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 12:42:58 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:42:58 +0000
Date:   Fri, 27 Oct 2023 14:42:54 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 22/24] selftests/resctrl: Add test groups and name L3 CAT
 test L3_CAT
Message-ID: <xxotsuuotwml47vwauy22noziekqtl4bfi3xthm6khhtaw4mhi@ie6c4psawpkp>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-23-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-23-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8a14d1-bc4a-427e-a5c8-08dbd6ea3f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 617a6XfbHI/i1LrQGXDzu3tpL4ihPBAMPDHJ8d2q19SoqPM4FM/FavXihn1+91R/Y8kI5TQXKlGEkxOGP/sYktlsIk8aXArY1I3otQda/sKTaLqhb9GVx7NKuY9hQ6dJOhWBIZczvaAu811Ahivp8QtaKg4nm53BjIZ7bo8Xj0UNtchwdAS4k9uscUhbNNkR1yv433uSR+yyoQQNOiQAkdaBYv8+cm+bhEg+XgwfeHesEkJnNGItWf9zZHWj8Ewd/f57EscBIibsqhod+4L5PIf7sXGnNLZBa57ivxGTeHL+iAVcZfMA8SF1raT0pLqcEwz7nCxJs1a/nWZhf7uAof3OnyGhtFbaxJWDMu0zBkkmgQp1lAqauAZF8DBzefhdG3R1H2+HA9GFDlHk+LXlC7X8wy0V8l1aS/zAmNd4lqRzW7l/bQkLjlX+3ksBA43vdia7YIoXXJtoFXmZeIDnJKOZ/mMaT8SCUipHfj0D4ZFRegEjwcRg0Is0czjFz2eIQPJ4sshv0559tX48iCNz6Tyb/Rwv/MIdgkDFmoFa9udo4n+5gR9ODDimcAHrbbXV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(5660300002)(316002)(26005)(53546011)(66476007)(9686003)(6512007)(54906003)(6666004)(82960400001)(478600001)(38100700002)(66556008)(6486002)(6506007)(33716001)(41300700001)(8676002)(66946007)(4326008)(86362001)(8936002)(4744005)(6916009)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jTzX0dgcpp7u6Yo3iyafi4OvyurDeAecgv/ZJsKadgTLpO2jmDTZGDfyyk?=
 =?iso-8859-1?Q?1OBwsHVm6x6TYx1BQS8+0ntu3kNYNoYCeZP1AVFh9K6yNPX7GsGHjQuuTw?=
 =?iso-8859-1?Q?WMkiMnwc/XdJUoVeNIObBd1XHVmU77++hiCch0VoXfoyaQp5wOUbmDjUVe?=
 =?iso-8859-1?Q?pY0puB8cZANIwPeE3+/QIaJpznSerC1Z6jQwXCAYjm7ctNci+8kIN9Y3Sm?=
 =?iso-8859-1?Q?a+v52WCG+Hsf/xefwdmIot8oWyz48FfJnXWB3SLYUMY5NvBy7f1IWBl979?=
 =?iso-8859-1?Q?BuoWeEbtq2MS8Bn6m+oaO3FaPU4h5vWJwvm++flLHKjGH36rzNpRSBVJev?=
 =?iso-8859-1?Q?HOCBZShaz4rHqqcYi1WWo8kHaIs1yuDKuJgRk4C2iV5eSbLnGM2OOctff/?=
 =?iso-8859-1?Q?0J7wVLZDbcYzlV7LpToH5b9baAlyw2knmytmBM+NxHBQb611e4Pw0W1TLE?=
 =?iso-8859-1?Q?iWhKvwXhsoJWuOBUvJkYYfmrXJI5em+dq/ZoxYzl1VPrB/6dHqQ1MEjaks?=
 =?iso-8859-1?Q?Txgntja7hbA6ZZNkBYPDD6bPrYSUltHbznpZxadSD33Scy6+0sXwiumKHs?=
 =?iso-8859-1?Q?nSkNkXNI0oXt7Fqe6iLRcNXahfMWCyjqax6aPfsbwKa2i9baJ6DS9TZBR7?=
 =?iso-8859-1?Q?ibronKCeJvHKSvyp/j9X5g61Oi7Swa1hp7rqvgEAMzKHxb//m6tF0Xbyxv?=
 =?iso-8859-1?Q?JYJMj+6EePivvu1vOE0L3UWjBf9lXucS2iSSubIpOHciseNR3NlqgAYN4H?=
 =?iso-8859-1?Q?LKZxxODuGhFD7xl1iCrDr4bntxjKXGzA1yxpbdrH1XA1jvT2Irwe/QuL2A?=
 =?iso-8859-1?Q?YoeeBqzmUSj1k44hM6RmgTw4c8XeBjRl46NN93n4KgQtJxV5BkwupwJ66d?=
 =?iso-8859-1?Q?T1Y4xK5QRUb7ZurFfg3+Bd8NXYyzuBeairI+7kRGnKDH0EHHJkgkVMkC0l?=
 =?iso-8859-1?Q?l/tz9e1pPWhQZ07gsVxWHLsfccW4Z1VYSt0mVGsdm9vituyggaSNXx1ika?=
 =?iso-8859-1?Q?bNtIQ45lyv0cdEsDJoAigzE3hvID5uugn4M2bz7OFsD6PQ/DsPq/9b6nOf?=
 =?iso-8859-1?Q?3TFqtTKD/7dbNlL/Ar5QNlcR3CpHH4/+ae5xEF7iL6CQNhOtaVlMEGwZUs?=
 =?iso-8859-1?Q?G6k8E1lLt3kWFB3gi2QMzfo2RlnKxDebXQuqI1EffZBS1QBk+Ku1OWJSKm?=
 =?iso-8859-1?Q?7EwkflJl28Qhv3elUrVoh/bwyqDwVHtvBgJh4mXrS/5wVQjILu9z96smb8?=
 =?iso-8859-1?Q?gJlqxgC/R/VNB05pmwBEPQiBPWrDa6qAoNJuOa7+mIpmyfRjT+033QY+mo?=
 =?iso-8859-1?Q?Ydovnmw6g3NWlqO1st7VwXgVUuwa2RFK6/vHK0fd3n8QmXtfVzppAlsoyq?=
 =?iso-8859-1?Q?tb/d5K+7gNIhiIZOB/HwI4OGAKtY+/sJZVVXxzRjVFX6fvbQuob71e3TQ2?=
 =?iso-8859-1?Q?uWdoVFZybBFkC3pwRFLS5+XYmHnPi8QUWZctVE3TUdqstDruW+bq1ru5j0?=
 =?iso-8859-1?Q?3CaX1TONNnV18VQPQU5rO48CEq7lpX6QpMV6omiwxNoJQGMACHSMFSDRl7?=
 =?iso-8859-1?Q?oozdN0zCCHoDArOq2302damGZIMKUGdTpbO7JZNVlejKQGcxypirvEuO+k?=
 =?iso-8859-1?Q?scPdSpJ8dO3r05sg40CLbwEUNJVRfJAUoAMFETIWIwJAnMuaInFCEurRnp?=
 =?iso-8859-1?Q?9HFEtpb1Ttz1urtOWQM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8a14d1-bc4a-427e-a5c8-08dbd6ea3f80
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:42:58.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Efujaa21/Uzf/oVXfP7dJ6FDJ1X3o5lcp5y8sGnVf+fuqv2KxRZHBkuECU8ub4YZ6KOdlqPNAGNHLTssk265kXhuQn8r3N3cwh2yQ5GQYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
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

On 2023-10-24 at 12:26:32 +0300, Ilpo Järvinen wrote:
>To select test to run -t parameter can be used. However, -t cat
>currently maps to L3 CAT test which is confusing after L2 CAT test is
>be the next change.
>
>Allow selecting tests as groups and call L3 CAT test L3_CAT, "CAT"
>group will enable to both L3 and L2 CAT tests.

"enable to both" -> "enable both"?

>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
