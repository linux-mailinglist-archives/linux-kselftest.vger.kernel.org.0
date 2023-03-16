Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B386BD497
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCPQDC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCPQDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 12:03:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EDB1C7E7;
        Thu, 16 Mar 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678982578; x=1710518578;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=LZFot1RZ68rpEWeLL9tKdTAcU/t0qOUNDhhZxogF4ks=;
  b=kAx6NQGGBcV7iCdK0o3vZdyCmByqDExL9OwjnFzc+9Efbixdrhcj13nq
   tioJYmzPPL/c4oBo1RPRjUHJnoHBc0Cj8dolQnLHY9ULf3GqjWqWIrf4/
   8uOsvjTMm46t7KEVF7F8BWia2VlyIGFV9KQ4nSe6F190fEWp/RxahDXsN
   om1Tok3+gnhOGTbHiBxH+GFbpom+KBvXvCFBAEZpiTnrMSKDWw/SDwZgV
   0kVqhiSOWSTnBJgfw7KMgFjP1cq5oYpclWXLKkfAndRXPViQt8F5JwH8S
   xktjvFQwtiYc5XzXBgBN1R1+v0RbFykgFePtUA4pmJsA4Kzbs1GPv1EJq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339578268"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339578268"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 09:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="679953149"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="679953149"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2023 09:01:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 09:01:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 09:01:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 09:01:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StCmm51X4Ubo6XrEcu3Uz7oCY1stvbyf2BCUAu623H4za0gvxcKQn7osL1AwvJ1Lo9AmcsgC7qdKFgUPzYpLb9YqWPpn7pjXyvWJfVq8Mmj5PvVyLUogMis6XmSd8pbjdbPg8gJWzyuE+YvgA6j1FrJt27iOTcAgN9CZqmBVSUj3Jh0gGVoTNT9N2HQjUOxK763XuoXK3A/7lB9bHXwiEaPmZc7lDI0bEtJt8ixLnEjavvAL+01vyg76fOiCj1sDnGo+IbzMv2An9gzdXDD7H8FLOLryxYHUCiSA2xGBCyE1pCpNmOQ2VXbGmp3L6OmNTIS7EJRjCr9SuQ6Ri3tpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5HU2Aib6lD3GPAqUstnTJ3AHmWiRcSE/smCN3mlJDY=;
 b=bWlKBQ1Kt+O0kTm2rG8sGaYOBRb898IXethKsui6jgSqR4GmWz6oXvZJznHgoqgcuX9IpA4UEuQPVYoOSAKsbWDyUYLnxMFB+ZR8aAPYDRrm15XRkfL4hIVjjHxPA/IDM+AO5cND5iyRt2i+OWiw1ZI8Q0JeriXQY4PI6v1m/NlkbPpgiAg4iv6KeADLm3gUK9E1KfxD0Wxva9LEahePOe+LBWfJPq4To2pgXuD8MTQnssJVibfk/nkiZyULZJy/d9O9cSqDCtOKSPAqZxwOos1CxIfWEs3ZkqgJvNdXBrJE6Q0YbkFWVrtQ2QDX6db1JLoto0rr7cFF2wkrAu/gkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 16:01:35 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 16:01:35 +0000
Message-ID: <c7183267-054a-3f23-7012-cce981b10dc3@intel.com>
Date:   Thu, 16 Mar 2023 09:01:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/9] selftests/resctrl: Fixes to error handling logic
 and cleanups
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:a03:331::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 71acd08b-7c43-4b51-32cd-08db2637b7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZV3fK6lgdnNNuI8h9ZsFV4Dh97HqdgzIn2/cwRnjqNrUoaPKqFk0cKau4eJw02gn7FeZurH0uAVgMRabyMJ7Oh5cV/vFqKOaCp/4+SfYhBkCLl5Df52QswLTwRwtrnE7gR1voq77cOoLA/VN1jwt2p56Ae6iJMw9XV/fjK6165wm7la2Hy+sT9YKv5gxsvSi/zMU30mjbnAIkwX7Jn79+dL4SrkTRaN09Fl5JXzDoyHCQKbQT2gsAYy3ezm7t9XJGTFMh1rcgLcvzgP55FdPw4nGVPX8JZIO+CsgDCf8u/EKcxd9gIU9qGmop/rvHXE5PGU6crGuPVXzK+Zc+QhmW17iQgW7jsF8H39lQ6Cb95tJE4OVS/C4NKCgFAAnszXLOaUVD/buw06mV27jlnHZNKL90yzC1ChQ2Voa4WkXJJmcsnFgxTIST4VhtOqPKNMgFHLbX7JllFvJ1sZo+1vfItX/66LecYHo+NcSQ3EyQ56yN0ahtgzWr+pO9SCTqaUj7S4Y8VyY5zbRI0uZGUswhs+29lL9zRdPh69fUz6EYP4mo+WvT3Q5EkREVmGuat4G61Wjq2vxUw3DMOsXHM+Ujqlja7BGw3nGUv9JVGbDoQHJruA0sd0YKKbuD/o7RQ9TcNUEF4v2oc3jzJKO+uTrPKUpZyQY3P9yh3xst6LkOd5nIXRz/GhImhoiWjsz4unrwjgIbsu7yTOeptsnccTGR0WVbpTCQoMokylovaZ0mLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199018)(31686004)(8936002)(2906002)(5660300002)(4744005)(44832011)(36756003)(31696002)(86362001)(38100700002)(82960400001)(66556008)(6666004)(66476007)(6486002)(41300700001)(6506007)(66946007)(478600001)(110136005)(186003)(316002)(8676002)(6512007)(53546011)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDFHVFcrc0JRYkdSays5NDFFc295b3FCZkVXS0hndmx1T1pqRWFNd3NDaTVL?=
 =?utf-8?B?Y3lzU1BUVW4yTE01K3hqRUZSK2ZGUHAvcW5yZU0xd2pWU2Z5ZDZGMnBwVFYw?=
 =?utf-8?B?SVQxYzhRcDlxRXhJTTV5ZkY3ci9MUER6d3BRWmV5YXI0ODRHT2k1Z3dnUHpO?=
 =?utf-8?B?L1dqZGlDY2xQUEVjWHZaVTBHUmhoOFlLdHVtTUx1V1dHM3RJSUJvYU9KcDJo?=
 =?utf-8?B?aVk2ZlMzODFuTHpKclYrMVFIdUVnOWtLeU9BYWhCQWxab1ZtTEhTMFhpSDlt?=
 =?utf-8?B?bXMyK1V4RGtnUysyUnFaZW41a0M5VXYyY0lJOHl5OEQ1OVpDbkw5REJEcDhY?=
 =?utf-8?B?OVRrTEhwbWFBRjlpczYwV0dIdmRQaVlWRmxkSHRyWFJMSXNLekpwZFd6MDRl?=
 =?utf-8?B?cHF3bVowbmEvWERWanFnTnB1SjhqQ1JFT2JrYzRxWGtPZjh4V0RLRWw1dzFt?=
 =?utf-8?B?QXpjTXFUOXl5V2t0SlpkNHZ6SmVQV0wzOXZPSExxV0NvVU9icXB2bjFkU2Jk?=
 =?utf-8?B?NjlUZHNuKzB2ZXk0YkhqMFVvU2xMMFYzbEVmU01FTUFheUV1bU0rTk9pV01R?=
 =?utf-8?B?dGJYMzdaL21yRjRiSzdyS2hTUnZNT1RBSUFCdGJiRk5wWk9RSEpUYUdJand6?=
 =?utf-8?B?WVFvUkhEamkxMURaUFhmb3ViTURScjlSclFteVMveWlRTjVSQkhYbTlkK005?=
 =?utf-8?B?Z2VKbjA4L005U3FsMFZFbms0MFA4NWppbXJpRmtnamF4eHUvUG5OZDdRT0Ny?=
 =?utf-8?B?cW4relN6azdQTkNkSXlOdVU2S1grRkFBejhuV1YxdWpqTlMvNXlwL0JFR1h1?=
 =?utf-8?B?VkloOG0ySzVza0gxekZSbEp1VEUwK1NlQWlmL3p5SEhLdGxwQnU0amJkUXNk?=
 =?utf-8?B?OEh5WFhLeklYU2M0UXV2d1A0bi9hUHQrak02ZmRvc2dnTC9YYW1uM1l0U21B?=
 =?utf-8?B?a0dwTGJHSk5iSU9xZml5ZCt2eVE2Mm1ub3djSTJ6eXdBN2lKZVd2N1RMcGhp?=
 =?utf-8?B?THozanJVNW5qMUszbkRXWlZwRldESkF5UUs4MURhbzB5L0I1d3dWMVkrdjJw?=
 =?utf-8?B?cGtRRFV5aDFSQmJnZEpxYkdjYmF2TnUyUnVyWkV2ZzFqOCt6ZFVHZFlsUXE1?=
 =?utf-8?B?ZGxLSy90ZGJxblk1RFBSSnZoMldiVG1HRlUxeGR6a1gyTm5JaWdwbWFMWUpC?=
 =?utf-8?B?d2gvWVFFZmxhM28wZmZ3RUpER0l5VHo4MVlkalJ1cC9lNFRDejFyU0pkWHB1?=
 =?utf-8?B?QWxySEFsOE9wRUtYZGtNYzRxYkcwQjNqajNTRTA4MDZQb3Z2Z3NQNGJIaHo3?=
 =?utf-8?B?RU9ZT0paR3lSYSthajNxZTRIekI2M1JsdmwrQzh4UDRuUUlhU0wzYWNKZ2RB?=
 =?utf-8?B?RitvZC9oRGc5dzBmVThmd1M0NVRTV1JpV0tnZzlqVUlmeldGRU5PVHpwU3I1?=
 =?utf-8?B?VTdkNGdld0NlL3BwcCttNzRRaXIvSlNJclBIVTVuamNQZElvWEJtZFBVd09X?=
 =?utf-8?B?VjlVUmxnSFRaNWx6UTZGRDY0aHRzY2ZYWmNmTUFuV09Dc21CZDRpRk1oRGlt?=
 =?utf-8?B?WDBRd1NaUzBMUy9Pd0M4U09mQ2NsblFYcWcyMk1NSXRtR0lmWXo0cnFjNzI5?=
 =?utf-8?B?UTRxemVpc0ZEc0tWTGJjNndMa1lxdHg2WUlSa3dvRk1ibHR3YW9BMzZNK0dx?=
 =?utf-8?B?a2JCczZobEM4cUIxMk5sR0VmQnpWaFRsWmRGNVN0VkNOUDZFdjVXSE1uOXp5?=
 =?utf-8?B?OUFUM1pjRmhyNEp5Tklqc1QxZFF2eDhkdXgrUjFoQ240RjlJSkozb01hWmF4?=
 =?utf-8?B?RjJXYzNoNnVEd1BCSTluRVV0ZUxXbEk4UEdpOEpGaXFaZ210eUpaVnRDUmxv?=
 =?utf-8?B?K0lBeXplMm4rdVRnaE41SW1Kd1owNUd4Tzgwbis3b1A4K0FnaW04TitCU0JP?=
 =?utf-8?B?VHo5bVgvbDZOcHgzYVJIQzJuemNtUW96MmJWSVl6azNuNkN4RDBSdlBWeUtD?=
 =?utf-8?B?eU9aT1ZKUHhKU2d5eWdNTTZXbTlnN05xWFNtV1NkNW13MGZTOUh4R0RmdTM2?=
 =?utf-8?B?RFJGbEpmOWJRZkNNSUc3V2dzUkxVeEl4bjlzNFY4RVdlUFdiZGRpMnI4MUdY?=
 =?utf-8?B?VEVWT1FFOWh6bVVYeHErZFd2L1RXNUw0ZHE2ZElVazByNnFwVFNNKzZOam1u?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71acd08b-7c43-4b51-32cd-08db2637b7d1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 16:01:35.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6OsR5BNPBJDOjQE0FtzDWhNOwpVtjSJy/GvtbnWiJpMCn8cxuVazMantpF+2UjVLwZlUb0BIGiBpAP+eD35kk9KyQYhFVnT4+PJNHG43Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:05 AM, Ilpo Järvinen wrote:
> This series fixes a few cleanup/error handling problems and cleans up
> code.
> 

Thank you very much. These are great cleanups. Looks like I missed
sending one response with the others but at this time all patches
in this series should have my Reviewed-by tag.

If the Kselftest team finds them acceptable I hope that they
can help to route them upstream.

Reinette
