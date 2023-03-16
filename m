Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87DA6BD477
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 16:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCPP5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCPP5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 11:57:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5443D5A63;
        Thu, 16 Mar 2023 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678982255; x=1710518255;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UZVbLxzQ4BQlTuhuFD7n9JbuM/O31PPJkvreBWcnDYk=;
  b=SGYnbpvX4Ph5nhg+xN59izA08Njw1BSXMOF4eSuupGX5Ktr+lrh0uDJ8
   lMK63bAvJm/33zMwdhWbSC7ixHpg4YhAXB8PAxG8H5oiV8a/YQ/93lEPu
   bfOR6eYxE8sHIRuGq+XftfJdt4iknSQfoFG3Oh8ZAQ2fIPlznuJhi6/6j
   H3QbQREmUqg7zl35KWfo+0yjZSEXhUpYBI+G4f8gatykAOiSrpJ5fjrJU
   v2SO4YMzhWcvL9m6qAyLLawmcKTwn8NPQJLeYE6LuI6nl2Y2FCiqKvstm
   8guhiYEUEwI74q2jaEK2g8VktBTOAxNuNYhBkSnszjysFaf0YRaSEn4Sk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424306203"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424306203"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657212616"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657212616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2023 08:57:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 08:57:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 08:57:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 08:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie0QOFdWoQi6fyhBCfebt1Pjy+Zv280UAsjac5lejLlTWAKUq46lgHmz/X9zrwSCltwAEEKQM5tBFu8OCWrOn/EQJFxc//cO8QvUG6xzK85+y63fD/S3JH823FOekjSjWAMVMPNyh61Fydgeans9nepIXN9sNuAlfdhMqIml/bHWZr7oHTzWOYwSCvWZGE6uv0oRlRTzysPLY5gX527o9vHtvW/xiqGU04feiN3mKrJ8Ibh9Z5CXd+HPlMtRKd42B5Dy29A27D8efXU9j/tgvrQJqM4QdKE1Aq+GqeEEs4R47QMtrQieiXmw4R5LauDAId4Koe8y/ugKhzOgcAlZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWj2nTH8vTH8GPTq/g+ml82aPqqh70xc7RgfgqaHrgE=;
 b=HlKQmtPxtvs54+W0PXZsPUSGgE2MPhrsroGqNq/ft5rplPW4LXd7gk2kZZ4MOQLq8dHFmDzVDwHEdGH+WqJJqik5GOQWRtpS3awtWoik7oqHumhYbJevPQVdKyHEh1Ojd9zECoP46i0N15fQfOy1HKp8sHxjIvc+Mh+BnKK2cCLiy5tYMiA2fEVUoye+wFJwup2Hty2wPjyNpDoGRwf4O1mVFNXKbnKcqYcXQliTEOjVD4pDZStDoJrtsVINDEJ+/Z+LLDXbDS3uRN5qu00/lWHjUXPSN8sVBsMgkGqNX/ZQraka/mCl5SkT6RThPrNjljrXcuT3XRGz4614DGXMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 15:57:16 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 15:57:16 +0000
Message-ID: <003b0346-e525-cdd3-57e5-96389ccbc05b@intel.com>
Date:   Thu, 16 Mar 2023 08:57:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 8/9] selftests/resctrl: Use remount_resctrlfs()
 consistently with boolean
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-9-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 070c5fa6-b10e-47ea-10ee-08db26371d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEJFA9CrP7FiZ1xiVcdRoN1pPAayivyo120sZ7GoGpIxaa7yRBIpji5LFDo+AOTHvd9rqQUvUA8zI3WL8I0S8/I5BpHHN5i142sKmyj1JFBlGRaBlruCxc+r99NO0i44s7EPU64vqSgxrM5+4CGdJdiJA0ClLDSHI37JK1Ndjoh/OG0rEIHdQVjbqapXKcz5hcNqZD6jZp+IMMKOEjHfistdRc+MlunvQvoesfzsrDhfJlR2USf9t/XVXPo9ELThZGUMmFDUO9NfTM8s/Mn4dKl9Q/vh29uJGmufMuJxRf/zJloBtbdK0qTiR5olZxhnjaj7dGv9ogV3a0EKAJxKbz+ycIJH3YcWhOVrnCf/fXjER/JxnZ+KOAB+D6R0EIRYG8lmtJTZYNSxBQSOT952SR3rJ/gQdJgR6VM0OdpEpEo/gRlZG9oYaS3rQT5RwS7wwxQWFGt5hwwBZ7Ate2u+fQRdAHxGfbFSEr/eTWpAhAsuq+VoIVlEOVHovWQwidTUlntJhaugshKGm6zdVqJUSJ+wHM8wLIblrvUvAwCC3SSj/wDjvLI9GU2VwMZWDx/zaR9qZx9pIj6jfOGTNuSI4amVoKzwvuCpVKaBkGnJpK8J9p4FnzlFElG4mvvth3gnbAjc5wSC/LvHqZuMyaw6KEZpfLFNQ7NbtfGwsl8fhY9UVcKEMyZQ4c2wK2OfMTQaMgHZAAwW24wfw5V+oBjWEeyN8uosQK5gebakxyZ91BQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199018)(31686004)(8936002)(2906002)(5660300002)(4744005)(44832011)(36756003)(31696002)(86362001)(38100700002)(82960400001)(66556008)(6666004)(66476007)(6486002)(41300700001)(6506007)(66946007)(478600001)(110136005)(186003)(316002)(8676002)(6512007)(53546011)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpWenFtKzFYMWtMR2NBZUt1aHRwLytrcFlyL2J6bjJ5ZnNHejRLd2J3Wko2?=
 =?utf-8?B?cWs5OURhbDUrOW1IZmt6Q1dKVTgyMUt0RjBvbDZJUXVGQ3BTenlYQVkzV010?=
 =?utf-8?B?SnZIMktuNitiWDlvUXJLSE5YVVFyblF3QXpKVnRpTjV1K2lLUTVlNk1MWk5D?=
 =?utf-8?B?ZFR1UzVOV0hSWFdvVmt0MURCSXZoMGNIZEpQMHZhMUxlNlJpeThzTCt1TU8y?=
 =?utf-8?B?TjFaWGUzR0Z1U3RoVUs2VC9ZV3JLKy9tdC9iUWEvSk55eWRKaklOM09EMWVz?=
 =?utf-8?B?d00vU3lORDFCbmFqV0NDQ3MxUTRoc0l3VTZLQ0lYZzMrU1g4Sjk5L29VM0xy?=
 =?utf-8?B?TndoaWpYRkEzWGtielU1aTRHQ3RXanRWaUQwVFpmV3p2Z0xSWjFxOUhnR3JQ?=
 =?utf-8?B?cS9Fdk43TE1KSGNITDBDR25qQUF2TStrSzVueTRjRmVsL1M5bGJvc2ZqaWxm?=
 =?utf-8?B?VFh5OUEzdVFINTFrSWlKL3dxZ283ZFpoMGpVN0N1VWJjbFptNFBkSnRheUZr?=
 =?utf-8?B?a2paKzZEbjhVUElTL3N4anJiMm0vZk90K05tWXM3eU90SWZmWkUyT0VBODhp?=
 =?utf-8?B?TzlidEZrT2JYSXA4QWFublJzU3pqUDRnNTlPckVZdEN1M1REU3c2aTk0ZWtx?=
 =?utf-8?B?VWwvZmd1MDF3TW1uQlJLS3NJZXFPVlFoaVNEL3pTY0JNdXZSNnhQd0w2RjFN?=
 =?utf-8?B?MkZLTDZDTzgrMTN5VW1TTmFMczFzeTFIeW5DcEFaUDhZTkhOOFdjcGI2dXdM?=
 =?utf-8?B?bVlmWEFYQitvemNRbzdHcFEzNEhaT2RoOXRSUTd0cFh6QTM2UWk1VHNFNWV1?=
 =?utf-8?B?TTE3alQrZ0pZdDNMSXpBVFRvQU53VkhuVmhmdVdickFGTEphN25kUzZkSmRM?=
 =?utf-8?B?Tmg4d05aS2RCR296bUNWZWEyVVVTblRSazhyN0ZBZXJ4ZnFRclBsUkp5QmFH?=
 =?utf-8?B?UXBwSmUrMDBzNHM5UkJSd1FReko2aFJNZWVPNGE3TVdlSDMvSlhwVGMwdVdz?=
 =?utf-8?B?dVJIanhjTmtFMGl6N2wzVE8zekxqb25wN1Y4ZURaWGNzZ3VEVXUvUldvL0Iz?=
 =?utf-8?B?cHBlZ1hyaEpJLy9TeXkrblpiNlVxUTlSemljbkx6WEJXSmN4S041bUgzcHRM?=
 =?utf-8?B?dWx4ZFVDYUR2bVYwRnNRZS90Umpzb0RiTTFvaGdLNGtrTVdLeE1HdFp4OUVq?=
 =?utf-8?B?ZjdNS2ZGMkI5eVVPSC8zQk1HcWVBQVJWVmRPU25keE0xMnVRamU5enVRWmIv?=
 =?utf-8?B?NlZQZWFLMkp3a3dtbnZldjBDWFYwb1J5STdNYWpNMGw1bFpEcWNSYmRGMkxI?=
 =?utf-8?B?RHM4am1YOUZjRElob1NBbWIzeEhxcW13NjNJYk5VTHpPRlM3NDdOMDFJZVI1?=
 =?utf-8?B?U0E4UGVpUXRUOGdKYWFLT3RSTFpBR1A5OEpCdnpuYTUwQ2Z6T3VIKy9VT01r?=
 =?utf-8?B?TGVseGlJQzFYa2JMNkdHL1JITTNWbzFvMjRBb0lxamNNa2ZhdHBGeWU2OWN0?=
 =?utf-8?B?Y0VpQnZNVmR5UzlXNWJlc01aZnBKR1YzRy9OK0VrbTh6aU0vNUNpVmZDKy9h?=
 =?utf-8?B?Q1RDcnlhVkZNYWlxQTgzcHpCRk5weXVtTTcxNE8vb2ZjRVdjTGsxQXg2L0NM?=
 =?utf-8?B?UGVacmN3V00zVDZqQVozNVMzMTJvZDB2a3RId0hvWGxJZGFqNkxVMldMNlk4?=
 =?utf-8?B?cUZicEdOb2diMnA2OHdTdlYrR0ExNTdjL0ZNb2dTc1puUWJvYjUxb1EvWlIx?=
 =?utf-8?B?eVEyRjF4NmZTMzhZTmZBZW1hV3lXSXVKOWdsNXVVZUw0WTkyWXJzelhKMmpQ?=
 =?utf-8?B?M3VtZkFHRVBoWUl0RGwzcUxUVmFma3U0L3BTM3ZCazlaTHFxNWtCN0U1ODBS?=
 =?utf-8?B?dmhUdVlDY1dsYlFObmhqeW5zbE1oRVBYajVEQWtWZmh5UFAxc2pJbklTK0Vv?=
 =?utf-8?B?NEJMTERkMnNFRnRTNFVpM2REc0xWN1c2eVUzdXJtcXVHcDJ6N09VUHVUYzZV?=
 =?utf-8?B?NldnQ0YzMjFJY0JoYkh0K0llNUhhZVZLZmVpa0tSNUFmVjljUkdWamFoMGJi?=
 =?utf-8?B?RURSalYyZjBGdklYaFN1ZkYyaWtGc0xtM1Y1WGZQYXhuTUhZcXErSHpOai84?=
 =?utf-8?B?NU1TN1FWRi9YMlFCYWdOandxTC9WbVJKczlRWDlkdUwvNkVZeCt5dTVOL0dx?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 070c5fa6-b10e-47ea-10ee-08db26371d28
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 15:57:16.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAUDcPpIlBffXHQg2eSUeIjhu+KzqU0H6tC1m0V0S2RupxRU8BK/RFDb6ti7UTqSy/0j+DyzVQ8fGEFxIX7NcP0ArcBj6Mn5mBKk3BeIFUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:06 AM, Ilpo Järvinen wrote:
> remount_resctrlfs() accepts a boolean value as an argument. Some tests
> pass 0/1 and some tests pass true/false.
> 
> Make all the callers of remount_resctrlfs() use true/false so that the
> parameter usage is consistent across tests.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
