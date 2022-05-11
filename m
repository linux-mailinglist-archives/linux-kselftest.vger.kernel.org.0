Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D460F523CCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbiEKSrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 14:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiEKSrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 14:47:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED320154B22;
        Wed, 11 May 2022 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652294860; x=1683830860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rxA1c31KWfAeHhaoGQc3JzO9XlgNH65Vj4KfXyxapcc=;
  b=PIQ2xo+jf4UChxBC5jMtY5CrZtsLCmLS4bY6FNhslu2CRtg6zeiVO+Ll
   x4JPu1sbMwcWSzbgea51sroB9K9llQYGNKEabaT8tQjBpQxT3YQWl4Qq7
   CmXPl6sdBxwSy7yQKiyB9ztZZLJEtJtez5GNjGOQ1/PzTMXYbOsXEz8X/
   K6QFtekqX54VdCtoWb6sm9CWAuqUlmP3aSZLviOVKYG0sEY3fRdfNNw3x
   0EjZo7MY/i4hsRN/0ZZp0CLGVCF/CnL2cTRXTIiTbgMEJjYJwpvCRsp7K
   xYv1rAoINsOfKs0ZysNvYjfqfwdbxYNfeJshkinI1HeP2KDnmPB8kT4VL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="251837533"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="251837533"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 11:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="566313280"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 11 May 2022 11:47:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 11:47:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 11:47:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 11:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+yi73G2Y+MehPh6DsDxJFV8jael6IRbN7judw7rI9DPEs00cyM4rIGUoDkXhXRHoEt8NRst4cJ0S5aM2fUQmEOaJLuGVjlRi10sst0qrFQhZ1VkJzh6UeD4G6yKOaZtJHLc+r1WwlD55AlSpSWyA+9038C8/89IsDIJOH36eZ5XhXBmim905sPYz8jM7Y8U10jkt/y3AE0lqHWQAIp1Q2UFwjPV0S2Sl3CUUO5M/NoyslwWlIUl2gv60pX6uTxKVd2J9w0wDnhcYUi7bqeH8XXnogeNrP0hbM7/JYoJmCM/opXReyOTD0D+o8ioFRFTPy636X7d7BzoLNOFN/4O4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDFt9yKDMVJtW2B4lDj9V998vY+JVQfIEImw88G+YGU=;
 b=lSQDqAiPh3YRMrTmLyX2kuPnGIiYxCp/rOn/AbQ+2UtMTda6th+INoLypHhJSTyMGnbg+I7IACzvtdg4JfL7eaifuxHLZb0lnUD+QnM1u4twx018XvDItABU3AcsB21KkMP7xAgq9auFkSWKuUj407aOSMbLjLxjY7Nc9zgkLbqgXa/Pt4smfK9dwY9ZwpwNK+1CaiQBmqTAvMhLm/0r63m0sTr4X/Ur4AvC8AdxShiAEY5P8gD5rB/a/n740yiJ5aOYdx8f+SvfhZ1T21CMO1m66UW5DJUIfgeXFjK1Aif4ohDhqaubzptpxqmOmyn/0YeX/DDL82+dfqKemIyMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by BY5PR11MB4193.namprd11.prod.outlook.com (2603:10b6:a03:1c8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 18:47:35 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5043:8c48:2510:3ec0]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5043:8c48:2510:3ec0%8]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 18:47:35 +0000
Message-ID: <395657d1-b040-89e7-046f-3cbd358ed7c1@intel.com>
Date:   Wed, 11 May 2022 11:47:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH V5 00/31] x86/sgx and selftests/sgx: Support SGX2
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <vijay.dhanraj@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1652137848.git.reinette.chatre@intel.com>
 <YnrllJ2OqmcqLUuv@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YnrllJ2OqmcqLUuv@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5871cbd8-0740-4167-81b3-08da337eb6aa
X-MS-TrafficTypeDiagnostic: BY5PR11MB4193:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR11MB4193CD0231C6710D8C1B7BF0F8C89@BY5PR11MB4193.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fy0v3iOwzL54ihpmVeca3iFYVmX4moAuImCNoAGk7grg364ilspu7LiWB83uSKQ+A7FrgHsBLjC2HWn9MEAd4ntGkiWqI19PGdI9sJ3mFwYEVTziHiueSLYNCuYV9Xp1LfXzZofGyAfLpjb6FKEMt3kD4CqZWflIDS+jbiok8ZymTzfIrZ2z2Uc+DHv1OwMLT7kDIP0gucNn0ApibJPKTLdHLWC2iPUMumgXEkvk1pFjaY2sWflVb2ToVysp0bw9Cc8l/0WIETkYYOWy5H60FBzMl1AF8I2w8KHfav4UiWlypLCUYecvC2QQr/8VBjTkYM5o5OiugbzHQsl1NtBN0L12KwnTxH7+yvlmdMsZOEajVUIROrc9V7ZIhqmk7w00GsI15VBB7HKSwOVHbIwkjdfS5ttXmubYQlm6JsY/Xm5nOkylZsC4vEBmfKTqrCVxh3WyoUMTlWEId+r6lbGfV3LiaUzDnIA3UaU9tIIV9T+lhznX+2bBaJsAISstWKm0myu/EGKD3MFBE/K4sbx+qlLK7/D5tbHb0fn30hU3ksQDumJyblHCynHr8ZK4hrQ329GzQ4t9FSTq7e45v9mHTQfYvLMRe2lTrM8R4AWHtal0m7N8oYAknTksmP5aGLoxvUaFlLLoKkGGQy+LOw4XmnumNswZ3GSxqeqNoJUr8SnQyz7n6eUnrI9ShLlsmZPpkhxW7+HndBSDKc86xq6pOQ3XaR6sJJCTXf0YKcwwJ2yy9m3plNBKEijGba2lrg32
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(53546011)(6666004)(36756003)(6506007)(6486002)(508600001)(6916009)(31686004)(38100700002)(26005)(7416002)(2616005)(5660300002)(86362001)(186003)(6512007)(31696002)(82960400001)(8936002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0krbG1ta2VHNVhwRHJrMjdycFNNaTR4bC9UekZuaVhNN1hYZml1c3YxeUhm?=
 =?utf-8?B?RmlLa0ZSamdoMHlVRXgyTkRSNzZGWHE4MmJqVlZ3NHFGMWNDNEFVWkVWQWhM?=
 =?utf-8?B?cVpjeVdvcm9MVkpDWnoweGtnR0RKMHl6bVJIbzZFc3RNS2x4Tk9Gd241Um5U?=
 =?utf-8?B?WXVLbmlQT1hFRkFxdUdpNXdBazJzS3RWdXNBemx1ZUU4eU5tZFBYK3I2UzU5?=
 =?utf-8?B?M2svL0IyaFZ3UE5uRlE3Vks3TEFVSnlJcjYyTFA4ajBUMWpHM0RNbEttSXdt?=
 =?utf-8?B?N2N6QlQ4WGhsSmhCaVlvdzZ4R2p4Q3hMMU5BUkNneE1BWC9UQ2RYcVJMeE9R?=
 =?utf-8?B?a2haM1Q3am9lN2ZOc053T3BtdDhpY1JLakFmd0dlbHcvR213N0FkSFpPRTBz?=
 =?utf-8?B?WWx3YUw3R0pBcHhORVM1NGdIeCtzMXY3VFBiUDJPd09CSWtsMHFMb2EzUmlV?=
 =?utf-8?B?Z3FSUlhadXdUWnFuWlcrZW1UYUJqVUdveXFqWUFJL24xV21ORXljNW5WUWt4?=
 =?utf-8?B?YUdOOHVVQkFTZHFCVHd1Z280Qmx4TTEycEhwSE9xczBIb0Qyc01VUmdlemNy?=
 =?utf-8?B?YXhLUmNNUnY3eE1uUFczTUVSWEZtS3VNekJ0b056OFBIMDhOc055TjQ2Tm5s?=
 =?utf-8?B?OVVQRktaRnNPa0VMYkxSQ2xqOFhHdmRwRmlzdm8vanRSM3dwN2JpKzQ2eWxE?=
 =?utf-8?B?Uy9KVElUVzhvQTNuY2x6Vmk4bzVTVjJjemEzb1JBRUJOTG96N2VQRWdqditq?=
 =?utf-8?B?K3pURmtwYjhjekRPdHlOVGJlKzZST3FhcUd4NFVZazcrUytSWkZOd1NDcGlw?=
 =?utf-8?B?Y3RwNU42V0ZkM3hyK3NvNW5WU2hZZWxmWWVHK3hCWE04T2tBYmdxUmNIWDYr?=
 =?utf-8?B?Rm5JVlhXblVvblp6SDgyTzlXUnNTQ01DYmVENXlJb09nUW9vRjVDL1p3SnZF?=
 =?utf-8?B?TkVhYVpYWlNxOVdPdURWeDRvN3VFQ3JhU0lwbVVFSG5yS01tWEdYRXBVVXB3?=
 =?utf-8?B?Qm9MRitOdVhNV1hhaWxsWmR0MFQ4aXloamozUEl5dUx1SG5PUVB5Y2EzMVRP?=
 =?utf-8?B?c21rM25ieTB3K0lodU5aWTJpUWgzZzRPQjJCUG5PcEErL2RwZ1RYSXdMeWY0?=
 =?utf-8?B?dGlHeTVKTXpaZXc5SzhPUUpOOEhmbWJPUUFxMzNHTnM1Mm9OSThIMXJKaFFY?=
 =?utf-8?B?QjlRdWtIWWJOdDQ3OWtJSXVRSkJicjJQQ00rY3VLUFpPQWtUZE56M1BvcjJ1?=
 =?utf-8?B?eXdxMVY3QmVxN0dNVkVtWUdHOGpaYlVKbzBTNkErQWJzY0dYNWd2OTJiWjVH?=
 =?utf-8?B?Mm9UMHNiZU1NR2lZbGgyL0Y2Qm4rQ1RjQjFpM0g1UUxhN1Rid0ZtNkZGMW5V?=
 =?utf-8?B?NnMxa2I0OW1tNEFrRjMwSE9EOFRIdjE3QTZFL1h1RlEvVXBkenBVRm92cXk2?=
 =?utf-8?B?dmRLeDVEZlVxTjVla3UzNFdXZTg3VVNPcmNUK0hZZkVBV1FSbW1aM0lXV2ZY?=
 =?utf-8?B?YVY0YXIxYVhsZ1FFRjJXRkJRZFNROERmc1Q3M2kxWmF0enF0MHUrMk96cVlt?=
 =?utf-8?B?ZG90aDhXMzdSMEpKbjlyOVhSWVVvZzlNVGh5T21HRHlPaEt5VG4xYUpyMy9P?=
 =?utf-8?B?amFjOUpQTnR1N0pqZGNhdTl6VGxVV0JZc2lxWkhOeWQ2cDFOS0RXT0NhNHc2?=
 =?utf-8?B?QVNlY0FpTzcwb3Awa0JIN1hPemg2WXZUSWY4cFVoSjB0bE1HazZDRU8xM0VZ?=
 =?utf-8?B?ZUVGU0FGWjZLNm5MaUpKQ3R4ZnBwNlBWbXdzbW9McS96TWhidXdmdXZweWJw?=
 =?utf-8?B?WXBFOUp2ZHEvWnBaeGZLaGVmMmozbEtJWlVldFlsYnMwV2RobENuNWY5ekFw?=
 =?utf-8?B?WU0wUkUxQjhhenZsREtHai8rRy9UYnRHcjdldDRPU1lXZTY5aWJzZ2o2c0tI?=
 =?utf-8?B?Q2I4NUNDZ1lqQzZibmpMN3pUdTd3M0dOTE5NM2VlZ1AxeitleERJcFQ2blJY?=
 =?utf-8?B?ZXFYdlMzMkpzVER6b3cwa1Eyd3liaXZINzY1UXdsT2NvTEFHbUF3aU5oei9E?=
 =?utf-8?B?NkQySStrdUZSN09qazNlaDlEWng4M3hLVVErTGNLcldSK0ZDTWcvaytUNlpC?=
 =?utf-8?B?c3d5TTlWanlNcnlDMnNtalhtL0RhclZSaVNWY3Jnb0hnbXozVlg2azFyOEFU?=
 =?utf-8?B?RWJMNnhGUnZnOVhDaVV1VTB1ak1DWXJ5b243amVDNEYyUk9rbG41SjdXSlBE?=
 =?utf-8?B?WkRkZTd6a2txUUwvRTlCZDhtNlZMTS9jNnNNTlZhcWl4WUFtYno3NER6YXc5?=
 =?utf-8?B?Z25ZK2tNbERrSXlpdUFVWWxlYkJYMTVQTU9PTXlNVjNuWHFObVdLZjBtWkNm?=
 =?utf-8?Q?3TJBEw3Pg+Rs5mf8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5871cbd8-0740-4167-81b3-08da337eb6aa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 18:47:35.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mafLKUj7+uJiFKXmAWnu0mqwvQCLw63sYOciQArSOQCtHbyApCZGdm230EoAQqt9FMRp1qBWIXj/CVUQ9zA5xWk6ECOdsFz/CQ50Pd9OhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 5/10/2022 3:22 PM, Jarkko Sakkinen wrote:
> If there is any patch that does not have my reviewed-by, please put it
> there. I was totally happy with v4 already. I went through these, and
> did not see anything worth of complaining about.
> 
> Great job, thank you for doing this.
> 
> I can also add my tag separely to each patch, which have not have it on
> request if that makes things easier in any possible way on request.

Thank you very much. I do appreciate all the feedback and testing.

All patches in this series have some tag from you, a few have "Acked-by"
instead of "Reviewed-by".

Patch 20/31 "x86/sgx: Free up EPC pages directly to support large
page ranges" is the only x86/sgx patch that has an "Acked-by" from you
instead of a "Reviewed-by". All selftests/sgx patches have an "Acked-by"
from you.

Here is a summary of your tags if you would like to make changes:

[PATCH V5 01/31] x86/sgx: Add short descriptions to ENCLS wrappers
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 02/31] x86/sgx: Add wrapper for SGX2 EMODPR function
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 03/31] x86/sgx: Add wrapper for SGX2 EMODT function
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 04/31] x86/sgx: Add wrapper for SGX2 EAUG function
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 05/31] x86/sgx: Support loading enclave page without VMA
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 06/31] x86/sgx: Export sgx_encl_ewb_cpumask()
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 07/31] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 08/31] x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 09/31] x86/sgx: Make sgx_ipi_cb() available internally
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 10/31] x86/sgx: Create utility to validate user provided offset and length
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 11/31] x86/sgx: Keep record of SGX page type
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 12/31] x86/sgx: Export sgx_encl_{grow,shrink}()
	Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 13/31] x86/sgx: Export sgx_encl_page_alloc()
	Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 14/31] x86/sgx: Support VA page allocation without reclaiming
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 15/31] x86/sgx: Support restricting of enclave page permissions
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 16/31] x86/sgx: Support adding of pages to an initialized enclave
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 17/31] x86/sgx: Tighten accessible memory range after enclave initialization
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 18/31] x86/sgx: Support modifying SGX page type
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 19/31] x86/sgx: Support complete page removal
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 20/31] x86/sgx: Free up EPC pages directly to support large page ranges
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 21/31] Documentation/x86: Introduce enclave runtime management section
	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 22/31] selftests/sgx: Add test for EPCM permission changes
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 23/31] selftests/sgx: Add test for TCS page permission changes
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 24/31] selftests/sgx: Test two different SGX2 EAUG flows
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 25/31] selftests/sgx: Introduce dynamic entry point
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 26/31] selftests/sgx: Introduce TCS initialization enclave operation
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 27/31] selftests/sgx: Test complete changing of page type flow
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 28/31] selftests/sgx: Test faulty enclave behavior
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 29/31] selftests/sgx: Test invalid access to removed enclave page
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 30/31] selftests/sgx: Test reclaiming of untouched page
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

[PATCH V5 31/31] selftests/sgx: Page removal stress test
	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>	


Reinette
