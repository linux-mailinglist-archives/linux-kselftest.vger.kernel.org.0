Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A642D4E9F14
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiC1SkT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiC1SkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 14:40:18 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171B14014;
        Mon, 28 Mar 2022 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648492716; x=1680028716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EFMfa0Xw4+0BNLi3LuU65MJtdwGEqio81+B/7wNCbRE=;
  b=aXmkKxOD+a2/1+mtNkYQIq5BGc8sHvSRatiHvJG4KBb38GmFUbKj19Rh
   UEemfQ4Gwv0yL3/QtwhNJNGHpBDp0hoH7vpzZWvYz60J7oz/DKhOycfIL
   ifQNM5HCs2sWHXe3tdc92IdBw1wWwvE+kQBpkIggXDLj+2Z5VJoJfh8WM
   nTkAFlySM1Es3gjal2EPDqTxIjDC9Q50lsOM97hjWPs2RbJ8JKZLxlocC
   2eDYLGwxRd/jY74kFjEuseVCe+ERQXBBXPq8iJXkxitThS7Vg4k+Hr51z
   g0M+ejf96W2LfiGlxf6Oph4rNUr2gOy+dPvSkcAgGOHtyCHscVW92UESL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319777783"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="319777783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 11:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="502617516"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 11:38:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 11:38:36 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 11:38:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 11:38:35 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 11:38:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKgfCcJoXpMobRMJ5DrSRJqxDqvMWlqp616q+q1ZnmwVFli+KRcggkzx9gmm5tEr58BRxhe8gLS7oRGN2ID92L06zKjDPpeTku8Eq0o2MeCZczpUuSjiacOOZcHTHdGKxMRKUgjUazgOSUbNXUBhYHR6zPpi7z81wFdo01ObRuSlou2tSUP85UBsdr6xTFi6qpyQGNriz/ed8PweY+6+lwMpnAIBLM0lNUzZc96N3YoNkrzY8azggX1iNlauKcnaxyt8q0dKvHSlQW4iVmPthvYksHGr8bqUDL0vHHqCencvJ08JoE7U3QL7TnLc7vRfiYWTTXfiC3DyVG1XawBR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbNSaiUVVjn/Ob+BoFwG8jWP8wz+sGrgsmGRdSs+SQw=;
 b=mZZZEhUnK8Y/NrjE/SfSrhsnlovritXEv9/kKGDyo6+nX9FzPWgWnsPt07jAtBsA919X5arL9aR9WoXwg9nHuDACIvFdkg1JTGPwhX+zIeFEhqfrJ0RVYDDSpcJZESQprYoelmL13vpzwYmfCnBtQ8UgcfkFCOR0seHrg0kDYG5KzwQIMbMADjptaeG7pUuXDuc3a3Bxfu6CTpT8r+mm/6A53X6rIhIjBASQua45H/ngOh1GF4Icq6Pay6VaLvPWmuvfbzhKDHFo5Vj+6KiMyqXIt3FgH8mZd92yXW88zj6HA1GKvpExn0rRtH137pC2hYPZo/QtvYOHOKNKlfjnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR11MB1675.namprd11.prod.outlook.com (2603:10b6:4:d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Mon, 28 Mar 2022 18:38:34 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 18:38:34 +0000
Message-ID: <939859da-762c-7d48-0111-fbbb4f2e16e5@intel.com>
Date:   Mon, 28 Mar 2022 11:38:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/2] selftests/resctrl: Extend CPU vendor detection
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <20220323080928.1586408-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220323080928.1586408-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a9459e4-9f18-4be2-74a0-08da10ea29e8
X-MS-TrafficTypeDiagnostic: DM5PR11MB1675:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB16754403E318BE656F1310EFF81D9@DM5PR11MB1675.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Gh+3CVJIao6PJ/s9Kk8bjvyOmB+Dlp/4MQkj8nPkKvxFp7U2BkQj4SOmZgq8LY8uVLQjDKbPy+piKswqYEqMlszYMWftS2o0hyshWqoEmlmwUv8Ff5dNaIzrE6vE1pzfR3fPLUgvLr2gocabCcLpyPKn1S3KEjGc0G89kU/pi7RQJEEYmxZd5U+CcF1KUha+0jmsLXc92n285/B/ECYzr7jm6mkaInxWLjCqBZB8FRZCl0ol8yjG+Idv0IGJLU2mEUCEhwXzLvrVssQ3B7GqYdKqIhhpY/vTvZe1ksaW17mMSUQPV+DnlFJOYaWlEbn6tMOv/pp7metccfLeErS22w6SXw8ylGnDcOK4DP/tOb52sCDL0dE9y8PT8oWPgG4c8cZTKLe9YAP+zlDwkG6HfynHiAR64r0MMFqMSvX+qJsKTyIyrOESpBuXC6snp2JrqupFXMaipYblfqZl+6PVVeGFY1wg6w2WO8GwytoWeVkJewGK/e9xgyOlKJuWu7V8M/CMpiE7s4nRnENm3my6boiJ87T8oZ9dMgbnz+xB5jpPpuBt4TS7esyO6YgIgvh3qjJRgYUJ61HxGsHAiwPZQbG6Bpfu912xKqsuBZhe110AzfvQZeWq4kIp0iXG2tg71p+Vmfnyv74DSqWjz00k5HIjFlXJLwr8HVEojwcXGiXJtjFx8fv5V2E8NRg27WXEV3YHoGIa+F4hveu2WQM5k5Wa89zS4vLpH7WJfuOmXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(508600001)(31696002)(44832011)(6666004)(4326008)(53546011)(66476007)(8936002)(66946007)(5660300002)(66556008)(316002)(86362001)(36756003)(6486002)(8676002)(4744005)(31686004)(83380400001)(82960400001)(38100700002)(2906002)(186003)(2616005)(26005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEU4d2lLQ1hvM2h0UStVUDlaUjhWVlo1YWNURmtFMEo2NWY3MU9TTktPMExi?=
 =?utf-8?B?MmVua2lqZ1diVU1MSDBVVWNzZVhyVVJsazNaNlY3ZTBNOHVDNVZLNGpQYUlX?=
 =?utf-8?B?NGFYLzFydS9qNy9wbFV5VzZGSzJNZmdObEgyc0t0R3dlb2hLa05BUFJ0d3ZZ?=
 =?utf-8?B?ZXpiTDd2UFBXckZHRUY4OFFud0JBcXF6a1FXK01kT1FHSnlWbzFnanllU1lL?=
 =?utf-8?B?UW1aOHhlL2tLV0NrL1prWjRxdDVXdUt1OXpJQ3BabXFnQkU0M1ZWbDhkK1c0?=
 =?utf-8?B?Vm0wdllMZzVOZzVIdFBlTzBHc0hvVlB3dlE0cW5GNC9JR3RudklpaGg0YWh2?=
 =?utf-8?B?amQvOWFKaGphbUpnSDdjeURFYThocWN6U0tLaTRpa2VtTU5rSmlRUit1dUZR?=
 =?utf-8?B?cVRlQk1UMFpEOEJsRkg1dTRzWFVIbzI2NU5MUTVkejBqbDN3Q0p2SllMZWdm?=
 =?utf-8?B?UXNsR3NxMUs2dFQzdmw1dEJHM2wwNk1Ha1hpT1FGcUJ4T2lxNzNERkxUQzhv?=
 =?utf-8?B?MEloS3pSbC8wU1NETmlQNnJOeXJmNEJHdXlTcWM4NjJqbEJtN09TQU9xSWxS?=
 =?utf-8?B?WnMrTUNOVkpEeXpOaXdFbkxLclkxeUpJRTRQVEZrVUxBbWE5QUVQYm4vSGxS?=
 =?utf-8?B?YnVhcTBpZk12OVZLVEE0Sk0xS0dZV25qYUdaQlhoWFc0NUIzK0dZazdLODhu?=
 =?utf-8?B?NVdzMHFyNjNkaUluK1E0aW85YWIzQ1F2V2diZW1waTNyVFBGaSt0NDc2YTRm?=
 =?utf-8?B?dXNVUFZCZGNVTjRpOFd1NGx6VThQemhwdm93bkJQeUpmOXNheWpucUdQREF1?=
 =?utf-8?B?c0RNSkZRUTVsdU1qSVpkMVNkTkV3cFcwbnFGbHhZVUM5clZqMGFReGxRbFUr?=
 =?utf-8?B?NEh2WDNvZGg5emsrMlBRQTR6UzlEdWxGRVlLQzZDcy96K3V1Nkx1bFdkT3pP?=
 =?utf-8?B?c2ZHYSs4RWloOFRnUGhoUmlSN294Q2JIWFlyZHEzRUI1ZXExbnk4b1RoTjlD?=
 =?utf-8?B?NmdmOXpqTXpkWGRNWDNZTkZJNTFzOExuMllxbnloZ3kxT1FnK1RkUHd1bnll?=
 =?utf-8?B?a01SZ1JnUkJwY3VyRTZiODM3ejBBYVpMZGJhWVBOeTFqNFVKUTFkekU2aFdl?=
 =?utf-8?B?WGZScWpZc2ZWNXRKQmZuLzlKUHFqd1FnMGZ1RFRHbDJLSTBJaFRvMC9sMjF5?=
 =?utf-8?B?YTZwWlZuWktSL3Rld0xpRk5zdHlTZktVRWlDSXZzYVlNakZwbDk2N3lXbXUx?=
 =?utf-8?B?N1V0Uy95SHRYaFIrVmNhRWZ2TUdBdDV0dXRxaWlHaWl3R3hyTlBKZ3VlRzFk?=
 =?utf-8?B?R3RvaDhhbmZJMUp1aHFnaTRidGZmdUNMOXFXVWVsdGF2UktvYUFzeXpxcm14?=
 =?utf-8?B?VjRPaGEyQ09UWDFtUGViYnpobm1MT2ljY0ZMNlJJZEdQaFd0bFk2bHhqUlRj?=
 =?utf-8?B?djd5dXlSK2Zjck1udXNRSy9VNG9vaVB6R2FFeUM4RlFoczZwNmRab1c4eSt4?=
 =?utf-8?B?WWJzajk1TnJVWkNOUEMrYjVIVjR0ZFI0dW54OUR2QmN4aWNKZEhnMzBXNUh4?=
 =?utf-8?B?MG52Rzk3UWxZMlk4c0FWcHh3OWpWNTd1ZlpLeHVScjJQSlRNeUFPNWpEK0V2?=
 =?utf-8?B?K2lsYi9pano3T3BobmNxUnRiT1A4c2szeDhpeHRCMmVWSldQY25KN3MwTjFB?=
 =?utf-8?B?b2lWUHl6T21xZGxwcmgxbjJKQzFDSWJiazlLMjhhVm9TbkRNdFpsRENvaHNx?=
 =?utf-8?B?N0Ewa0Vzek1IdlY5THkvMHV6TDg0d0hGWTBuVEtnQlpVN3NQbTUxYkp5bkZE?=
 =?utf-8?B?WlpjMmEweHBxU1FFS2QxSWlxZDhTblVScktIT2kyOE1PZ0lIVTBpVzcyMXg4?=
 =?utf-8?B?anFHWFgxeW04b3ZnRHJVZVRZUFZBaExxcHZSeE1pRmgyZUFsdk8vMGlXcFBm?=
 =?utf-8?B?QnRoUzhSdDN6RlBmenFrTTkwM09jVDFCZnNXMzR5UkZldXdFM3A2TzI3L3Nv?=
 =?utf-8?B?Z09Ka01iMFlBYjhWczBYUzN5R0VOSVJLTm1uK3F5eW94V3JjRUgzeStIUEQ1?=
 =?utf-8?B?TGkrTUZJM0dNdEtCQjh5RHRDTXJXSkh2M3FON3FMSlgyQkVwQlg3emh0azYz?=
 =?utf-8?B?KzhENCtWcllwWHExa3duY2Jab20vYk5YL0RVTGFwWjM4R1ZxZTB1anZKMkwz?=
 =?utf-8?B?Ulp3UDUrdEx6c1BtRUhlVlBQUEQ4ZjFRWURId2tHQW9rTFMzYmR4TnVNbXo2?=
 =?utf-8?B?dFlZRFhFZU9hRUFHYVJ2MUV2Tk8vZGZCQk9uRyswRWZCbFdlYjlOR1ZMYUdV?=
 =?utf-8?B?YzJ2YmxRZm4rK3dWdDI2V2MxVUpGbHM1WjJoYStWVDBYSEFuTWNkcllJR3dF?=
 =?utf-8?Q?yR4fgtODCDynRYCI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9459e4-9f18-4be2-74a0-08da10ea29e8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 18:38:34.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OS4WNg4dsy0DiBeO0J5x6+uJZ35FI8tXLEiEhsE9Ecup7XQA8ztpbgTQcmZHxsgQatW/nsHwRguqOoK2ozy2kPCyGChuZsLKOh5bUKwbTAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/23/2022 1:09 AM, Shaopeng Tan wrote:
> Currently, the resctrl_tests only has a function to detect AMD vendor.
> Since when the Intel Sub-NUMA Clustering feature is enabled,
> Intel CMT and MBM counters may not be accurate,
> the resctrl_tests also need a function to detect Intel vendor.
> And in the future, resctrl_tests will need a function to detect different
> vendors, such as Arm.
> 
> Extend the function to detect Intel vendor as well. Also,
> this function can be easily extended to detect other vendors.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you

Reinette


