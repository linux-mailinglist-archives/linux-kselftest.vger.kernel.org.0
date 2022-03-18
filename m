Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC874DE324
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 21:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiCRVBO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiCRVBN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 17:01:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9C02DF3C2;
        Fri, 18 Mar 2022 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647637194; x=1679173194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rbaOHmef3Jf0/s8X9lRnLRD3cw4DkUDMoncls54HVKo=;
  b=cAx7Nq4Xs5+6+U/5ctxIeSmFfcyAFn1T/SAWXb/pn06JkJeWknS20zOg
   KSsySBw5p+YkAn3f/8i6fm3XinrW4U3AW05/6D0lC2tOPVzVO39xGgQNm
   PR/t/ve2d2SOAPavZ7H7xOepoQxl1uTTwVZfcRU7NXDZecFmfWVUyMVmc
   zFK6wh4QwtF/1pSdzQ2011DfhNK9dnuIWKRVLpGSyGbB0xbrDkaVWtbkI
   GCsgEPOfTjaHt7/iAeAUOdef+NRG6rdOv7Ro2rzBRWd1CYv0vb+k5yDT5
   VsxymOEvOmjwQpWioWcNcuc53hdy5htKtHWMrcvjEWs0+MrUNIgxYPib0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257174329"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257174329"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="517402084"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2022 13:59:53 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:52 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 13:59:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVRUhSkVqRtBusQwLX7hEE1pfFGYPVuDItRK003BrKTJX7SWGPEvgyC97wUtIF3xJLKFEtD6+VnwsJWfUQxIc8/44dIof8r55GtlbV85VpIQnxNWnVMP/iXATpfZuX1itQAJ514wHz4j2qa+VjfYPNRoYSq4s3L36kbPf4w3gzt2P0a18jO0BBSwZWQCr7uWTvEN958qUxrbQh/tlZtHM6HDHOUTvHsNU6WMxtKisQBSG1NSvht66rzbLHCo+6XXBzU9TqKHTaUX+MTPbblThxPsG2KsEJWPGRXLbX2OGpan+eW6e0pOt8MElEvTeYjJW3H1F44kEOazC1ciObvcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpldTAI+nZSTiT3t5TvArfyuVpUr0Twm9kuOlKxgzHI=;
 b=ESfBJmIP4PMD7pYgFdduPnT7UqkKtWvmBmzldL+EYCiz4FMBzFSLoKzcHqpvOXg7c4b84ln2G/5cIjZl1XKkLDhEvF4PdhcMsCgRDjkU/K6JpL3hAb2zaYV1SaqFwJMXeiz1S5s5m495kFjdMzui9SvU4ex03bNzm4mvsw8aXIVeYVAykHApaUWnh6aMiigdIz3Vz3ymfH1+7aGJ2tEGld/MXXM3ibofD0QDhLylYUotMf63VHnRMBaTrfwLvSGKnk3ra0IjozwWAkvv51iZPngEpPxt4/QWUE2qs9cx6jjwuKqrTW2YC3J1+vB9VHicukoUs5SOSxYG9tmC3RDKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2146.namprd11.prod.outlook.com (2603:10b6:405:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 20:59:50 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 20:59:49 +0000
Message-ID: <63be5521-9f98-a9f9-8e4e-3a8e042c423e@intel.com>
Date:   Fri, 18 Mar 2022 13:59:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v6 5/6] selftests/resctrl: Update README about using
 kselftest framework to build/run resctrl_tests
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-6-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220318075807.2921063-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:300:117::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36826e12-4986-4601-08d6-08da09223dc1
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2146:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB214666B4AB8E0D0A679D46A4F8139@BN6PR1101MB2146.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJPbuy0dkE0XbMrPmKjKCpy+lwi0P5KpXslxwkTteZM2RsAT9dNtfXmPSK0NRzwxk6lVmhAd8gMMYr5B7iflXnLyHScyHMxuVkgr5/o84HBdltCx8+Z4otZRox7ERpYDe96fGgSLL/XgTa8NQhDjD9BZxCQbA/BD7xD9nc3pq21jKhk9QHfeOvFljNYU4jzwgMp6RJAlui/jJNh+PM1ZQ8nDJVQIzh2CT5FTrX3Kj3U7iVrkM4tGuvtc0gzRvSdjnnh7bXi0DE2qdk2nAYllNiT+ZR57ScFUw17AIQLQxgMiabRzXAWDNTt38b+CZamWLcpW0JaSWwwGKMel8nqB9BgCsUML1p16ItGAsjKEZeGoinach4zI2xRQu4Jn/ObwoffA9AVwz5llPCHGNmKRQCUrjTQcGFkl/FKpo1AWIAny1FCLVKm+PEd20YuaFlSzzX2oLrUwLR9gG9AVvor1Vm8LKNYRVR2olP7RffrSSnIZ8n5fvrK3bI2ymkM2yt6sYNSrdIbi955uHa2HsfISrD/ijz/L8dZKj7TBDAu9w9UfhT+biAnW4mEulp5/8N5OvQD0Y7E6mgdDcTNYwFKfCHzZju/a/RrfkdsOXW3xs0Bxd+xUMFst0G0gEYfmnqZaAKR9gtBpuVq1vLSfI9FgcrsGPF+NoNf8mrfKnPkU72a3WszdxEXr1XCZhyojQuFz39w5CkzSv+seUgOY4R3BMrVtVNNC710IjHBO6AD/RpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(8936002)(5660300002)(186003)(53546011)(26005)(6666004)(31686004)(6512007)(316002)(6506007)(36756003)(2906002)(4326008)(66946007)(8676002)(66476007)(66556008)(508600001)(86362001)(31696002)(82960400001)(558084003)(2616005)(6486002)(38100700002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NLMzE5WWwwZllZakVsZ3VlYS9Za1o3TEl2MGgycmFCN3owSEp6TlBpWUx5?=
 =?utf-8?B?UlJ1c0F3NzVhYXVRN0ZBczFZY1JoNzBhcHphZTkxK09TdWtFcm9ibWt6QUwv?=
 =?utf-8?B?cE5EZnhGMTh6VUE1Nk14Tm5nZEZyOEl3SktlN2ZHMUl4SHdQbHZhTFlIc0xT?=
 =?utf-8?B?SFhBTllSZFBFRDluVlhEYkVOZ3dNOU54bEhyclBpazJrVzViWmVZbmR4cm1U?=
 =?utf-8?B?bE5sTXQvZlJDbExaTUJyVURsZ3JxbG5PQWlFVlU0NC9HZkwwZjVHVElIaW5M?=
 =?utf-8?B?Ukp5b3hqWDlTUkN1ckplM01UdkdOOXNGVjAzUGlQYktvUUNJUVc4RThuOFFU?=
 =?utf-8?B?ZmdQZHNuYUZEQkhsdUNrWUFvRVdRMG1ZcDFPVisybXZ4R0tQVVFrZ1pTTGJz?=
 =?utf-8?B?SU5ZckQwTTRPVlQ0bUMzUnEwajYycWFES3BWWGpEWGpsUUd5b1RGSW9zNGxy?=
 =?utf-8?B?TndWY0tlWDJlZXVFN3BxdWQ0VU1nc3h4UHNjcjRuemJSZU1rc1pQdEJXaEly?=
 =?utf-8?B?anB6WGNDV09ISFl5bTQwdmdVajR1N2l5NnZYUXRjM2pTK1JJSFlENTg0c3dx?=
 =?utf-8?B?bndFQmVybkp6U1lSZUdaZG9WUDN6SXAwOE03VkNpdmZrVG45UjFFYy8rSXpD?=
 =?utf-8?B?MVhBR0sveEU2VlArdnZ4RDlaRXFIWXJWMWhwb1VVcXhKTzFtUTFnYjFHUFRG?=
 =?utf-8?B?QkNCQnplZmNtWENIRkR4K3E0OWNPUDhHQ1lsWmhZVVI4UHIza3F0eG9xVDFD?=
 =?utf-8?B?WDU4YmVUMFlzcUNjWjNBdlVuYW5TN3RDN3VuUmlMczFJS2J6b21ndG5Yb3N4?=
 =?utf-8?B?cW9DTnBSVzFjU05WVm1vVU1xWkh5TlpvQi9lRVdJWStSd3FWbWpMbXRtQ25a?=
 =?utf-8?B?bkxWYy9kcGtkMm1QVFRCanMvaTYwSjVDQUhUSTRGNnJDRThidjYvaXBIYStS?=
 =?utf-8?B?Z25VKzdybXBlbmVQR2pGVnBVazNUeUFlQXNZOGRzK21MTklXaGhaT1hBazdD?=
 =?utf-8?B?ODF4Q2RNODdoVUhwV09CR1BFQ1NUaXlzQVlSaTFPR3JyZjZOUXgvVDJGNEdC?=
 =?utf-8?B?VTZZV2RTNzBWQTJpenRSbWs3MitTdTZ4dkl3MThYR3IxVk9CYWlmT25MWXls?=
 =?utf-8?B?aGNFbnpGN3NSNDJKQkI3cXlsbms4V0VNZm5EeXZoWEsyMmZzTytGNUVqd3BM?=
 =?utf-8?B?T0hQcTl5QllnVDRrRzF0Mm1YaUxHaURncmV3bEoyNDBBOEI4d0VEbTBGOVQ2?=
 =?utf-8?B?anY4dFkvYkFMaTJMTTFyUXlRdHR0T25TTEtEQWZRNGtqMUZYZHExWmZaT1lE?=
 =?utf-8?B?L3FEYmlYSHFBemNGb2ZVOHJkcVdNMktPMWJlMENMcDBLZ0E5L1JReGJDTUdK?=
 =?utf-8?B?UWpDampzbUZqanRlTFVXSkRCZTQ4WVozcTJKRkxZZDF0WUdwWlFQRERsNTZx?=
 =?utf-8?B?Yno4NlhBc2FObFU1WkVTVkFKVFlGUmVmZGl1ZEFnekE4RjQ4RW5NMy9uYVN5?=
 =?utf-8?B?ZWsxZ1dNV3hKS0VVTGptdnZHNWYvYndGYlJvYlY4MnpKZU5vN2xMaGFZalQx?=
 =?utf-8?B?c1hzVktBRVl0RUh2UDdhVVhrVzFzb0dTeUlsdWxBL3MzcHFEQlZqV1BuMGpa?=
 =?utf-8?B?QXU3bHJwV1JKdjlRZUtLeTJyd0lhTXhhZEZmRnRBNFpnRk84YUEyU2pPdG14?=
 =?utf-8?B?UThyenZ6Rm9BcmNBM2tnekk5cFJpVVRPb2xiNG1iK3JPaTNleFBjK1BJWkZ4?=
 =?utf-8?B?Ykwvbit0U2FsUy9ISnlIaTR1dFhEa0xnUUZWa2RKM3ZlQ3dtTU1lNTh6UTUx?=
 =?utf-8?B?TUg0NGpuYnJXTW9KMnJFRlJZVmorRDJiRHorNDQ0SmYweEJFWGFneWY5RnZ0?=
 =?utf-8?B?blVCVUxiLzRqTzUralJwTzA1Ym56cDErczFZWWVnR2cwOStudHBRY3hRZ1l3?=
 =?utf-8?B?WXJkYlFhVEs1RXZrVzZDVEMxbWJnUGIxcU4xQ1JBRnRZdXBuS0UvZERGNnJ4?=
 =?utf-8?B?emtXdHdkR2pnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36826e12-4986-4601-08d6-08da09223dc1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 20:59:49.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPI52G6HkVcUHVXQVPPbXQFF0ppdIH2hgJz/0268UqIwIMFdf0Z1D8CuZmnHOfy7T65tL4j131XH9y5vHinOYpZdIgvtLJ+31Y9Tt/JL+6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/18/2022 12:58 AM, Shaopeng Tan wrote:
> resctrl_tests can be built or run using kselftests framework.
> Add description on how to do so in README.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
