Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C225577BF49
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjHNRve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHNRvQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:51:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D01717;
        Mon, 14 Aug 2023 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035472; x=1723571472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yy+Pz886r0+CuIZ5gWFMwacZQhf//4Cv7EhIrnxAvVc=;
  b=VZlxp6kROWKFp9KY04zAq1Z7ztGj83BGCcYa7AW3tVT/WL4dT4dOOSa4
   ZB/HCSbB85+JjqyYE/fqiRXvhev+PcfFEzBXfGzPFlQG62DXseHaLoqzv
   bTIjn41QsRxeqLRh+WY16nUGx5Sa9Soi2XNQRUvVXdEFVlgpCQ8aggj4f
   3yRtor8EMww60PPAo1Rovhsqdrp6xhOSKRHG0MZamNnfskWVLKMHK2MYL
   1HyIFGk+S7Onx+qChVSDsdCcoW+EkgQMD9U1teoi+/OAqIdPpqsYZfm/w
   mbeq4ROVmKb3ONtRm+Rl9r+l8LjXScV5oQuG2ioIPGekHucRT6Y6kxd8n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357067147"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357067147"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736604413"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736604413"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 10:51:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:51:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:51:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9f7KJkJuzhOBjrNUdD12W7WpH8grNaq4JlT8vzlISeX7mU5gQLHnCLGsPLiryx6iJaVplLBRGKzak2ucVq5mhR8nn3H53D0bfREUfMap4l4idU6yLOLAWNI1Ua7AXCjFfIn4UJE/avch3bDS+JvSrFv5NWPJPNnNZcuiNlLzdXoxp7QMXIFQzieRL/x3w+6NCVZCX6T1SA3AjDasxRMEWK5dy/kWc5LEeiwk/242D/1jNH86wBDH8VlsTA08a890JG9qnmbNjNZPs8P6ejCLtRtTlChkkWqsTEPDm58kDQfsCLtDKNkxqb9HtfY3TJ4Fd8YZ7PiIYNv/MUMGRjaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK/E5Typ+fscsd60RYteqw5UWEs07u+IBK+bmSlK19I=;
 b=Qx697YHlsJax0+RykwI27mlmbneUj6dgKufh/aCokiDH1V9dxhdkjXy+hw0QTS6GuwmvBVUt0LBtOWDNSzonrXuZ5hW3WSsQaXlZg4OmMtZxFgUIy8x5JB+5cWOmJr9Wbw7I8jqi6O6gZlGkrCZnZO/NeBGNUxjHTqhqFysHPfB0Ukz+x4qc4hE71IeK63vvSY8XRgR1JvY9Q/EyIbaAAmyE1QyRdeLBENGrcpa0W7v0VEL1u5M627DmNlPPcDBG0Jwd92MgJNXNJB2e/H6OYhzb7Itl8VKU82sP3mOUryRLpUAnIhX4LA1fVYmuqHWtrNlkZWaS00XnPFH8VuxHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:51:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:51:06 +0000
Message-ID: <a68c3511-f61e-1405-6dad-93b29fd05e04@intel.com>
Date:   Mon, 14 Aug 2023 10:51:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 6/7] selftests/resctrl: remove ben_count variable
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-7-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230808091625.12760-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 64681aad-8025-4090-ee38-08db9cef08d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjbPiQO0DfzaElc0OxO2FVBumqTzLziF28c8FoJ8TgDhU2L8JUvX6wIPtgUXi6O9McPTGg/O7w3IgcXKt7fdhAt1sd3FCuoKibVroqx8bJzIPj0PKwCVYB+OoqzDiwth4FLht1gOze1aj+nFHEMkYvUTN8CZzdGbUoA/6XoMmkgJRcXOJA6rO9UnKFESvYXwHVj/Uj1IYzoYOYuT8sP/WZNpcMtpyDXkO/I+8phjjlF9TqPnwsP//8empeNj1QHvkmhDTT2gWdzyOOU2K7WKmjTNir0dU1CzXHOaJoBnJ5k2Z781Ve7PfS+n3tOriv3++bHgKcKzTEG6eXC4fcAXqdGtgFCd5b5D6LQ6zKvDaVoHsgyMRxD2+lCtRTttcCEKKQu/l9Y7O7KxRL2J6IsnLMAmk2StHTdAW3fNoLVH4RtL8NbNHpM4DluOwpJeMWLHGuUybUch2vQxZl5WQtgkMXq8VRbXTBiW/2THPbyI32nT5bvGwtSBJyRagMDxBuiI20/QdmHrsu9djYCzbje15DO23w8tm3pxLZzocPNlCLWA5iu65mUKXIJTqjB05bsj0uUIpL2ddAlDD4rIiGkPFzQhQIRuDoWiW+fFtNegXmAhOMbIbasG9cSSRruy1x4nbWpbPhfuZm5bXW/ty54bTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(1800799006)(186006)(38100700002)(110136005)(6486002)(478600001)(82960400001)(2906002)(5660300002)(36756003)(4744005)(86362001)(31696002)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(53546011)(26005)(83380400001)(2616005)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBwZkl0aFlOQzBXV2ZtcTVkNjBkR0J5VjJxcitLVFdrem5MSzlGZXZBbEYy?=
 =?utf-8?B?bThLYjFkeUc1TmJmTFhOSjlaSko3VFBtbEptelJQYlc5b29LWUkvN25RV3RC?=
 =?utf-8?B?eGN1QXFHU0UrWnVwLzBFbDQ0ckhWcFU0aXRCQjZaQ1ZyaU5scDV0WDAxNkFT?=
 =?utf-8?B?MCtUeG5XK2ZyeEdJWnY5STc2VmJQUnBTYURCWUp3TndBcVg5djN1WERUcVhP?=
 =?utf-8?B?ZE1WeGpoanVOTmxLdU53cittVTBLM043MXEzbWNEd0ZkVS8xNEI3STRjQkt5?=
 =?utf-8?B?Q0xXYTZUSjFTK3dpdDgvNUxMVHY4TmQxaVJmd2xmejB3M0JZaVFENzZRa3Vj?=
 =?utf-8?B?WitEMDJlUzRtbHprWVVnTTAvOStnVGRXNGg3ZXdHTlJ2N28yU2FxeXY3SGhV?=
 =?utf-8?B?UzBCeHVBSkRlNjIrZG9UNnoxMTZoUHhmNHp6enh6RUhjKzBmRlcrY0lmSnU4?=
 =?utf-8?B?QTZpZCtxY01UaXZoenZtc2Q3RzZJNDZOUHVlRVdZNjFnRXV3S3lvd0ZiM0Fo?=
 =?utf-8?B?UWRPQVArYTRVTHowckNBVUZ1TWt6VktGMUF3Q2xXeitQRDFHWW5oaGxJdXVV?=
 =?utf-8?B?VjN0OFMvUk02SDNDTDlhVzdMcEFXd2ZLelZudkN2WDd4V3JtRXovV3ZRdWVm?=
 =?utf-8?B?Q0V2VlN3aVNlb3dFNjZ1eWVOUVpEeFFuNHJualFTd0hQK1NvQTRuZnJCaGZU?=
 =?utf-8?B?UVRIMjN3UWo3SlVhakJZS0QrcEgvRVd1dW92TVlPUnhiNXZueHNBNkdTSjFN?=
 =?utf-8?B?MUtab1B2S1lEU2xoQlZOZXljY1pjTjBUNlZSckEzK0NMWHZkelQ0ZG9NL1ZH?=
 =?utf-8?B?MEI1MWdiU21BODdMb3Y2OVAzUlNwSExNeUNodGV2ZGwybTZGZ2plM0EvZCtD?=
 =?utf-8?B?dVUvL0xSaG1aUkp5Qnc0SnAzZFBrZHoxVFY4QTBSV2o5TkViaHZobWoyaERU?=
 =?utf-8?B?bHVZZjJ5cGxTcU5UaUR5ZTlJYWpzWUpkSXM1aS85RmRpVEJ3TFJSRElUM3Jp?=
 =?utf-8?B?cE5SRGRQY1d6dU5WQUNKYXFhVVRSVEJLNjdGckNOS0pwb2hLSktaTFZOZUZK?=
 =?utf-8?B?bHI0VFVFZFl1VXlGRGdPNDB5dXpzVkk3cUdaaHM4ejN6QTU0RVVzSDBrSC8v?=
 =?utf-8?B?YTJVWXgxc3o4VVI0a3pMR2dNcXNqUU5QZklpQXRhdFZDbDlRWHdMYWxpL0x0?=
 =?utf-8?B?aGFRbUVld0lURllLMWZHcG1DTUx5dGszMmVNMzFITUVKamxsTlVvU1NSd0xU?=
 =?utf-8?B?S3oyRW1meHhHVnFONFE1am04YlZaeXBoazZhRTIwNUxycmpOYVJ0cGtiTW5w?=
 =?utf-8?B?VElVTUdaejBDQWxZN3F2eDk4UkRRN08vcDFCbW9rQ3orZHZMa3VmcC9Sbkts?=
 =?utf-8?B?WjJxbW9iN29ScTIrc2crU0tCenBrM0JoMEtTeVh1emZyemZMbFhLMldxSURw?=
 =?utf-8?B?TG1ma3I0b0pZZytkYmJlc250cTlROUliNXdVZk1DOGcwYkNyNGV5UE5OWGpN?=
 =?utf-8?B?UW4zbFZyUGJELzczSXpqWXg3RnhSd1lCUWZEODZMV0xWdlM0Vk8rNGtXRk9W?=
 =?utf-8?B?WlMrQzkvRU1CeWVPY0pLY2MxQVZkdVBSejNDNVc4bGlVSkZMdjhLQ1R2dHlw?=
 =?utf-8?B?L0Z1VEk4bW04Y2JVNlNObFkzYXpiOGVFcE5IdGxHYWpZK3p0VTZFejRpd2Ir?=
 =?utf-8?B?WlhzVWEyYThjOU4zRHVsb0lBRDNIcDRobkdCUkM3eWx4bTFkMWNMdENyWTRh?=
 =?utf-8?B?M05SLzNKc2VoSTZKZ2R5eUNENVpPTUkwUDZ0TlVpb2xwVjdsNm9GZTVIUXQv?=
 =?utf-8?B?MTh0VGk5Y09CMXNVaTdsd1dIeTY3UE1UNkYzdm5TUjdSazBoWTIxenBOdUs2?=
 =?utf-8?B?WSs4SGxhUGJqbTZjdVF5TkR3ZER2bzNvOHJueGNrRHZHRDBGVG15V3B3UXpk?=
 =?utf-8?B?N3oxbGh0MEpWM3JBSitieVRNWEZ4ZEZRaG9GSWlubEJ1Q1VhMm4yY1hzRDJK?=
 =?utf-8?B?YmtsbFBaR1dYUkUyK2Q3Q1Bqa2wwdjNlU2NMa2VYazVnME1FRnR0MzQ3WFNh?=
 =?utf-8?B?Y3RRQVhaQXAwcHZTMGtncERiWG50d2g1d1JSQnphY3NRZE0xdFN3Q1JTbDFI?=
 =?utf-8?B?aTBPdmtlakdOSGY5cVZabXE3YWYxcEF6em50WFZWSjZKeEh6Ym9zcVBlRkIw?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64681aad-8025-4090-ee38-08db9cef08d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:51:06.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyBS3ud1fVhhYnN6OxvFwR2tVJpMdVasNTR8IF00ElfdGjpPK54NBxZ8EwcqlblYR14iSEvoeBWviL81PuUpJ+qQATQ3WGofjJdq/qJclKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

Just a nitpick ... this patch is standing out among the rest by not
starting the subject with a capital letter.

On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> ben_count is only used to write the terminator for the list. It is
> enough to use i from the loop so no need for another variable.
> 
> Remove ben_count variable as it is not needed.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
