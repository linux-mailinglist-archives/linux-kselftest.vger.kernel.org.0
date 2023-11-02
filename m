Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBEF7DF959
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbjKBR7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjKBR6f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D5D61;
        Thu,  2 Nov 2023 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947898; x=1730483898;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2SnE0f6x9doPsSr4pfU2Zw4dFgo6++ToI2D8dY19ALY=;
  b=kTGwNpPKGtpaQA1tJm3JI1PDIeUG62o2B9JTwMFH1QlfqiUpMtUrM/4v
   4QFHJCVVhZM45o3zvMU0W0SnTnwhxxUOfpbWDrQ2ZwIEKdEXXWv6XPwPN
   RnS3ASHG0zLfmHICH+TJbUMuTES+vsBN5EM2peZBvDc5dbpJQR3x61BSp
   cZeL8yLtb7WJu1b9LMwXlAdIs3ifYyUJlNCiqAyLrfraedbCkzsK/oksU
   gDKCrW53i2qpGkdfdI/7IatBDU+Hvc6ATdI5P28cL8wXXzynWj7LDSq4G
   6rkSXFK5wLFvFZ9qQO8ttdTw9NbWr2Tob5EV/KpELZO5LsIDYCuan2VO2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="385954281"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="385954281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="934853414"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="934853414"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:57:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:57:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:57:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:57:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKHI6NMfCA+RkF3EhYkEy18JHgmZmIWxCcKJX+NwCr2WE2v3Hn9nLIwMeiPTs8xwKBQrpi852Z0JOEN0SgJ4pH1JAf1Ya6K+Z5zec43Cqk5BRex9ak48XGWYSw57O3zf6ijsbycLjjEgUHzkiWSPlTKlJuc8PtkxgrN9D/1k0TB4b4+1LGPqQOQYXKi4jgdcTcf1vFw/JbRKIIVwDJyE8mjtjyfv+fkyCwe4t3Cxf7Mm26pt7q0hkUw83fvftS6AuTCu6fR1GjUXkyktFZ84n4iGLBt8G/y2kIJXcUbUFDP66R0eO5IIArLSpXsmAfFT/jbni5n9KQFSBhvaPyrpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JogLTP4ZSk5VTF5xXmQHMzR0O8BM1Bj768cDY/D8SNY=;
 b=aQp/G8TDH/lx+hwa1V//L05im/MboUbqHlqf5sVCtfsGtKlYLfySD5hDKKMJvQIufm2LLT57PsY9KBGgoJNY42SP0ENaaFilQgg5unNfuyZ8AITpbut2GyoioU1qlS7z6rI21+kKKWqVoEzPbYG882FOA3kuQh/vqS0zhaPJ82fyfO85i/B/rLBqp99FUic9Icc2jCMijcdxcpWPSPGyTf0NRT16rP37GzQob7JHENv0p3eyUxZXnMm+RKlK9qJkhxZfP5x8KWK2gSVGCEZIoH5A+z2GJGaHIrZoU3XcQRCrrM9KR4qNVMyzsq+8GacyZ/KYYpTvOZURG3DMEXam0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:57:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:57:46 +0000
Message-ID: <a5160a37-7778-49ff-8c25-92846d42e87e@intel.com>
Date:   Thu, 2 Nov 2023 10:57:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] selftests/resctrl: Ignore failures from L2 CAT test
 with <= 2 bits
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-25-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-25-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: ff579015-7dce-4e8f-9dc6-08dbdbcd3886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euLfpb0dfd692IeTcRLFPxzRXFuvHQXZotEtiVgHlA6YzoP9c8JQ+NXKPhfd26lrGWquyqncULm/qVlfhleimYwWP9/CESc1zj05w/XaYgfxUipF9Qq3/Sw1t5/kOY6Zbj5w+mQt14Bp+zK/3jwbO49mU/TtF9PcWrIl+w4GhSv3+SlOnZmmuZxrFabf6kHaZqg5L/qaWSUYLtB90fw+i7iujjBqXblKXtBqAW/LugLWKC6wXpNgpcJWFhdgFu7mhdddMDFm66IDvhjunXn30wHnLkhCTAzfgpBP2tVIqhrdoWPZE4ICUnUF6XKVAmeMRW1B3l6uRobGqv6jC9vpfdTX7ERLexbO734CbOZ9Ls8Y67AtnBMMsAHVhYNbQly4rNS0VcG/76QU8y8R0tjD9RdIHgTXjQ+x6ESbr6jSTQSbHWua9c4iaw8UbDAc+nCJsc4NIAQOPo0SDCV365Bygl21TFszvHvcBb+nIyqmQACACscBPZAgNA3uesyFt5+yDuYnfZHEnX8kQSi+V9iZ0E2+h8TihPdvGLT18qFN2R3bgaKh9o9PaycxNSmlKztQnF6i51Gvl+DBgSSxu/9OFmpQJrDqQ36y1CVQd0+HBKqoGzpWqPuhKhonHMxnqn8av1UkSOAMuzNtSmDlurTg8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6512007)(2616005)(478600001)(6506007)(53546011)(66946007)(5660300002)(41300700001)(4744005)(6486002)(316002)(110136005)(66556008)(6636002)(8676002)(83380400001)(8936002)(26005)(44832011)(2906002)(66476007)(4326008)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2VzbkphMDg5Q2h3QW5NRHAybmRLbUlFcU9sQW5CQ0Ivb3pmNU1qWXV0RDE3?=
 =?utf-8?B?UEIxN2wvaWo4c3psRVUvQUhodjQvSXhBU1JacFVlOWdjajJSemJ3OG1NL3Y5?=
 =?utf-8?B?akYzSkNFTGROVDRKU3N2L1NJRmszeU9ZNEIwc3kxc3NxU3hKMWFsZGVaRUhW?=
 =?utf-8?B?ZUxaSkZTQ3cwWTBra0YySXdoZ2llTE43ZXVCVHkwZE9LcjBVdmNzMXI0RUxw?=
 =?utf-8?B?U0ExaDFIR1htYmpES3lHOTVlOHVvdFRwd29ONWxlMkhibE5oeDZHcXIzdkpx?=
 =?utf-8?B?TlV4TitrMFNPcUIyVzBJd1BSS25aZDVkUmRvQUQ3ejRoTmtkYlF4MEl3WXM3?=
 =?utf-8?B?ZkZkbkpYMkp2d3crTXUwb2JFcWhQUi9tUGNtS3ZhZXc4VUlFdDlrNVNWRGhO?=
 =?utf-8?B?K0wvSC9jclptRE5qdTg3OWZjcUlrSGRjZmhYTUpjcSs5elQzbDF0UFQ5Qk1S?=
 =?utf-8?B?WGY2OHpjY2VjUUNUbnlvQ1o3SEVlSm4vc2Y4OXFhZWRWYm1hVjIxaVRSK0ZG?=
 =?utf-8?B?OVRPUzVaSnJQelFrOXc3enRlMWdKZDFLaU93QXlYK1ZQVkNaSVM2OW1WOXpI?=
 =?utf-8?B?TUVtRFhxc1pyYUowV2cvUjVRbmxpNXE4UCtydVc4WXpzeFdxSHE0ZU5nRUtS?=
 =?utf-8?B?OGFRODNKdUI1dDBRQUNhM0pjR2M0VEd3cTBFYzVoTS9PSzRCOFd6TmYyMFdh?=
 =?utf-8?B?V0tRbVVrTyt2b2dnc3ZsMWpJTTZHc25XRG1McHg5MldiVkVvMFVPbGVJVjly?=
 =?utf-8?B?aG1CMkU4RXUyaXJDMXpTRlc4YkZSd3JFSjExdGhlWVJ4OE13NUV4dnZFNGJt?=
 =?utf-8?B?VjRWeTFzVGUrenVDRC9Nc3oxTnNmdW9NS0x5NW80VDJJeWJwdlc3NEx3UmZH?=
 =?utf-8?B?aEIvK25ma0NwRHdBRXRPbVVGN0U0RjhvZVViS1RUcFJNdUVEcmgyczZXZ1ZQ?=
 =?utf-8?B?RnNBUk5pNlVwQ2g3M3dqUmVDcVVFYmNBUW5SdkVVYm5BdzVTbXpSd0VkSXpT?=
 =?utf-8?B?RVFZZDJvQXM3czdJbjQwKzI3OXE5cHZEbytLb2ViYXNubWdSOCttQnd1TVNM?=
 =?utf-8?B?bktMemZFZSswWGlXSkU1THBWMmNvU3liOU1PVWlqcThoUGZRUkViaUd0OTRG?=
 =?utf-8?B?OHFTYzdjdjhGQkJiUFRQTjUyNFlLRHFRTi9FNy9qb21WdXJ6Z24yblp2dFp0?=
 =?utf-8?B?WE13OU5yTU9saER4SEoyV1NaTmlHTU9sdCtoRUJQcFlFcE1tYUozMWhqa2VR?=
 =?utf-8?B?WHk0UWpEU2RhczRCMk91WXFVQmgwVHFiRjAvUFpoNDZoSnpWcER2bkYwa1hE?=
 =?utf-8?B?dkhmdzJKM2ozVlNDNnNWRnJjYjFyaUUwSDcxdituMDg2THlTWUJaeHBvaUo2?=
 =?utf-8?B?ZnQrSzdTUEdkWmt1dVIyc3ErSnJ1QXV2TExnUVhHKzVPVERKY0JEbDd1ZlM0?=
 =?utf-8?B?NUlLRmZON2d1cnVmSnVWWCs0ZStBSFRHSUdsYm5ZVFgzK1NTdElpcEV4K0Qw?=
 =?utf-8?B?TDJwNEJIcmZHRk4zZkdvK3c4eXVJWVo2ODhRTE5SZGNPb3VYcHRiVFFvSzFR?=
 =?utf-8?B?MTMxeUk2VUJEVkNsVEVseVNhdE9vNDV4aDRxSEN5aXRQQzBwU2JWUVdIU0tt?=
 =?utf-8?B?QXpuMVVmSnc0OW92ZmhOaGs4T3N0YjRtT3Q0Vk9jY0RXd1h0dDFGNENNeXhu?=
 =?utf-8?B?clA3WjhvcmtjTWhUU3NQUHYyeWxOQ2s2TS8rdkxoaGZKMWVpcndYc1NWcHVF?=
 =?utf-8?B?dTBsY1h3L3g1Q0ZhamZlK2FNM2RQcHBlaDZoNUhhZDBORGVjRWwzQ3FTNXVn?=
 =?utf-8?B?VFhESk9FNHVFRlRwbUJCU2FEWjlsQ1BDZ2Y1ZytLVHNvQ3Z2N3hJakRsUjlw?=
 =?utf-8?B?TGNlMkVxNEFJZmRoMUpXdzltbzVmY3JvR05JdVhROWcrOWhyc1VyWWNIS3FN?=
 =?utf-8?B?ZjZxbnVvWVBrY0o4MkJvVDRta1pDVElaVDk2NXZuNmZsV2hyUUxQVnZSYkwv?=
 =?utf-8?B?NWRuZGx1WmFiWU5kREJSU2RGMldoVVE1VTdpb2oyRU1IU2d6aERPc1djUW9O?=
 =?utf-8?B?dmdlNUthZmt5Qk1pcERqWEtmR253bzFEMWtZMlZXQ3pKV2t6TkNXQkdKTXBo?=
 =?utf-8?B?TGlBTDFDSjRuTXRISnNRVGltTzJHNnZNVVIxTmkzbG5MYUdzby8zWi9vZ2RE?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff579015-7dce-4e8f-9dc6-08dbdbcd3886
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:57:46.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTDMLDZOsCbubMlJLyk0mgdrXxMcaORhb2iUKyAH1G/bP0PJ45DnMVFIbG8g8M5ene9uriCJ6E2zdiJU3Z2MbY2bGD6BIR9lkRcGlc7RJWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> L2 CAT test with low number of bits tends to occasionally fail because
> of what seems random variation. The margin is quite small to begin with
> for <= 2 bits in CBM. At times, the result can even become negative.
> While it would be possible to allow negative values for those cases, it
> would be more confusing to user.
> 
> Ignore failures from the tests where <= 2 were used to avoid false
> negative results.
> 

I think the core message is that 2 or fewer bits should not be used. Instead
of running the test and ignoring the results the test should perhaps just not
be run.

Reinette
