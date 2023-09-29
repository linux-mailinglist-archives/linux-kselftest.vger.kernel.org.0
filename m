Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78D7B3C9E
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Sep 2023 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjI2WcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 18:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2WcN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 18:32:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79681A8;
        Fri, 29 Sep 2023 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696026731; x=1727562731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iDh660wBUOfQnpafRHFN0vuDlVvtG/noKhlPWILWQEQ=;
  b=jA/6nJIta2lMOzfhrtL1G5QWVxz3vkp7iexIPljytDtIA0we+CQdU224
   W3J2h9cbZ1letawugwyJ6/l3aNUdrHI0hsUaakfLdM7AadPlCo6jSS7kM
   fgG6X1XtccckyOXgbjHXbV33C7OlaLfrhlyj64bJwhd9wRtTPWtVFU8PD
   tYzUWR2MBu8l/VP5HvhM367czRdI4SQo2XFKctNqopWKIjfRKDhghx3wy
   0BnGJKLw3ZNWbO+SVjElbpTQk8+yB2zGRJ1Q/iFLHfChmEIuFDS5ZTlwu
   OQN6K/pM/yKeDYytpF5ebf1jMh2JzLSeQGX9TTK69HsyimDUiKBvm9yQE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468675221"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="468675221"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 15:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="753515848"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="753515848"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 15:32:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 15:32:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 15:32:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 15:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8sIP+fUHZvdabA3F7wtW6D1gWK2OK+xemZ4NZSNSe+BggIMWLuCvKUzDCyPzKUypjtilH5Ik86EOjCLGxtOoIEpYzEslAYGgBklwgjPTUduJfYYugDx8DAGsKCQxkS6OtElIkwhX25vvfYMXQfki9wlSuYmnB0Oj1Bkihz+diHtCpXhwsrmvvVYbtjj1vaKDDb9iscc/gKXeLWVjMihRXQUO3rMZALuTk5Y3Lnwc48UnsFbDNPzIghK0l49I1mCnN+pE6JECWBOAaiSjlS3/JVpka570l3eI0h/B0Ez8YbxiP7Ny49yo+s2swrgBWYuEB9v8Qr8w74i9aCLPujfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsLXmBAPMDWWvqAl4d0C8Ocp2/ViKxvNCHMhOEIQXlI=;
 b=BmLjq5XzwsgvyfzfI0pMQwquzGIQK4jpdOMwD8Z6vZK6KJks9jeVjAgt6GAE0jOomQ5uNTC7w7h5wtDyvseA0P8OZVuRCVzvNKhUWPtHGaJShw+e6SLKds8rzCfVQFwzS86ISHq87nTeiAYt/pKqnA/KSFAgvrWNT2Ol0+EDB/EmVC1j1KexQVMBes5puIsN4DlS2m6iKlq1wu1R/9LdgJIa3Tha3C6lw0UdhBggvgmz/isdNUukEB2djoAoi/JY9mbH8yx12o1OyvHcTBiFpMsJmJfYlXQIuSr1EclS48G+Y4jRPRxsbas0e4oJ8djPYqh+Ng+vFttoKA5sZ2p3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 22:32:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 22:32:08 +0000
Message-ID: <813e7332-6a05-a80f-6460-d3fdbecc2305@intel.com>
Date:   Fri, 29 Sep 2023 15:32:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v3 8/8] selftests/resctrl: Fix wrong format specifier
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
 <1545d7dfb7dd73a7bb2b28fe2f643b87421bf20c.1695373131.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1545d7dfb7dd73a7bb2b28fe2f643b87421bf20c.1695373131.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b66e29-21fd-4dd6-a9b5-08dbc13bea43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfrCYj9fr9GsrEu2uDzuMqixMEw1HO5jlCNhcdd2YtYq1r8s4yPF7+LJjkRpGmZXVdN4KD4CzuRLWMuiMQA1oU6yA2KozVM6twm5SSh/BLtQ6bZ3jLx1xyItUXdLPaVLjfBV8yTKYLAPTYvx7zHojVXOFoisltKG7WuWf0xest4ymmO30CBvHZVnwy1xf3Ze/AF1BnnxAu49ykoLQ6+1ui+gBVezHEvN59w7wGm+NVrT82oAJCGdWqNysv0JBQFqFHwN48XiG2TyNs8yuM3kUvtJWjxKmP2uTRzfM3hnxH1p/EMAeaTCojLk4E5onSBZ6AsYltNOEm4K68sweA2TGw9qAMm8FFttqHPHoGi02tlqc/GleT5mvyZ4JuJoh8/z9pJ0ekL8aTtWhUPb2jDWybgUa20U7hP16LwWAZLOBcJ1YnO4Mq4kTOhadXP7wlg1o/61J64ydJyU7Up02/cDUEuFbknIIduVRI+/IoVzQt8QPtWHpOBH57sXYl9gHTp+U6aquWAlo4nTg0I/uDPXDzVVAHpH45UN/7tie+qiUo1KecfDE+zBungQcLZpj1IO4/sco/6x7VJfWZPr9WyDbc69iZk1/FvNt4oDLNPLzCxd4XNMvq1X+S8h9KnCpxTzrMtMfky2OP/zkt/Vi3gn7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(4744005)(2906002)(110136005)(44832011)(5660300002)(478600001)(66556008)(66476007)(6512007)(53546011)(66946007)(2616005)(26005)(6506007)(6486002)(8676002)(316002)(4326008)(8936002)(41300700001)(36756003)(86362001)(82960400001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUczeUhTNk1mSVltU3pON3dYKzQ3OWxKc295dFBaVmxoZWhIUnlKR2hFQnM2?=
 =?utf-8?B?UTdjQ3ZrZXFwMFphR0VUNDlxUGFFaE5laXdzSHNrdTFLUlU3TWovdFNCRUY1?=
 =?utf-8?B?UWxZTDZleHlhajBFY3J2WjRWRDJuTS95Zm8wWjB4Mk5vU08wNTZqVkJybktx?=
 =?utf-8?B?TmZrYUVTMWhtQzJQNzQwQnc5L2hkSmRIWDV5UmZjdWRHc29vTmN4YnRoVGhM?=
 =?utf-8?B?czZsdFlTMHA0R2tnWk0zbXhmdUU1ZVNGeFBUS3E0SVAxa0c3WEd6OElNS1A5?=
 =?utf-8?B?Q3VkQklDSVRKbER5bzNJUFFweGVaUTlzRXlvZ1F3NXJldUVIMW9zVG5zK2xN?=
 =?utf-8?B?dHR1azRUYk1pQ3BiOGROVHhUWk4ycUNSSFVqQ2lmMXlaUGZ0b3d4Y2dyaWJS?=
 =?utf-8?B?TlRpSzJpVnI0RmRHanlxWUlJVGdjeFNBaHB0UHh6aDNzdEdpT29VR0NuWG9t?=
 =?utf-8?B?NjRwTEtnY09TSUtsMm1ucm5CY1FxZ2UrOURzWFZEalYrYitsb01HN1NLWWpB?=
 =?utf-8?B?VzdKU1pYcFhDMkZVQ1Mya1lIVUFqMEZlUW8vMzhNRVpUZlZhRDMyVW51Mm1K?=
 =?utf-8?B?ZlJiUGowcDh6K1FVckxmc1YrdUM0Yk15djk1SFJ0RUdTVEpqS1QwUmljNHRy?=
 =?utf-8?B?bHFrRkJVMnZjRHMzVmYvdDRqL01tTERMRUpnWVVWeVpCUHpaSHFhdWdwVDk3?=
 =?utf-8?B?MEM4Q01qWmJ5aW9sQTBlVmxEV01iN1Y2TXp2S1NZaDhPRW8zRUVmdTBKcHFo?=
 =?utf-8?B?T0lpZGpJY2xvbXd0NE5udktueG1Kd2pZQ0Rka3Nha20wQkJSaHUvQnd1VHVj?=
 =?utf-8?B?a1BhdXJ2TlZuZFl6bDBkcVlHTVBjOERpdk1MeWRxSjBvU1hlTVorelNhOWJK?=
 =?utf-8?B?YnVnQU1HYXkrMFpRUldLQkZFbWtYeXhCakE1dmFheTQ5d2NwOUdLTDhZREZN?=
 =?utf-8?B?d0o1VDcvZC9ZWWJmaisxMFpSOURIOGVNdzZkYmdybUhRczFJQmJaQVpYM2l3?=
 =?utf-8?B?b0cvaVBPbkNpVVBHRTBXSkwva0p1Y2M2akJmRUw0VG9jM0tLOWpQeDhtbGZN?=
 =?utf-8?B?eVRHK1MwQlB6L3VGRitsY2ttUVZJLzdNdW9XTVBvdnpQVk0wd1RjbEVJMVZP?=
 =?utf-8?B?TDFiRzhJZlZYMVArMURBbmxtSTFJQ3owTmRBbEFGN2x6VFJLRmZiSU5MN016?=
 =?utf-8?B?dVNhdE50MjQva2Z3bHR0cy9oelp4S0pHcEppSjdyK3IxcGdZNFlWOHgzdTVl?=
 =?utf-8?B?S2VtMG9uU2hZcldBZEtFNWZERGtmY25rZzgyWUI2SVo5dE9wcE5ERCtPUXl3?=
 =?utf-8?B?endydVQ4dWxQSzZjVlZDTmZVQ2dFREVMQnBkUWlvR0U0d3FwMHVZNWJtbGhX?=
 =?utf-8?B?S3RTNHNkdThiQjY4cmh2S3FZTDFYZENMWmk2Wk1rSjNJY3JGMzVSUTlHNWRt?=
 =?utf-8?B?Y0JTNDZQcHI1TDJHS2hJZXFQdG1KclB2elJOVUttMk43TEJTNFpkY3FwbjlU?=
 =?utf-8?B?REY3eDZLREpOdm9ZbG0zT2N5WHUrenNScCsrL09WcjhaMUg4VFFRK1lhbmRG?=
 =?utf-8?B?bVZQTmRpbnFIQk1BbmdZdXZzTVcvay9KOHQ2b2Y0U2N4cmV3bFR4ekZmUUM4?=
 =?utf-8?B?RFN0WEcvUk5xaDBLVkVCNHEyZkNrZkdMOGdSeUErTmFEV01GcHlzKys2R3NI?=
 =?utf-8?B?VFlTZDJ1ZG10WkE4eGRoRW45Z01lMk05V1Z3c0dYKzR4MTl3cXZ2VEg1R2h3?=
 =?utf-8?B?ek9RQzhGUTF6dFdIcWFaUlg2NmdxeVBnajhiWk9mMzJWNkhkRHZQekE5K2N6?=
 =?utf-8?B?QUpzdmJCSEswdkJhVk9BUDl0Y3UwU3BKQmd3bW1QQ1FOMENtTHVCdjRvT2N0?=
 =?utf-8?B?SEtrTmdoR1E2WGR1aVVzUkZFd0s2ZFFlQ3VxZTh0YzRqK3owN2g0OHJZQy9a?=
 =?utf-8?B?R3hZTjFMRWtVTEN2bVhERHcrWEc1bmxsMFR5dVpmaSs1N21ETERLcWtwYkhO?=
 =?utf-8?B?MlRzNkFoM3R1eUxlQjdrbU1PYzRtbVNNbHBoMUNnY1FpbThSbTF5S2tTbFFF?=
 =?utf-8?B?QWRxMXFSOTQzUWZNNit5cXo3anl2WFlNaGdPdGl1emp4WldSVXF5M051bWls?=
 =?utf-8?B?OEdXRDVCcndZZExZNUhRYVYvZUpGUzNoTjBEZzdWYnlaa1Fsbnhob2ZkQXpV?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b66e29-21fd-4dd6-a9b5-08dbc13bea43
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 22:32:08.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAW5haS9F/kzo4fVwy2JI8ZmKRPsc3d4Usg3lxB5KQXCad63t9C6RXgWqFLECBfu1syTSo63J3eKe0P0tPW4a6SW+Q/NVkQutcgwhyONHNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/22/2023 2:06 AM, Maciej Wieczor-Retman wrote:
> A long unsigned int variable is passed to the ksft_print_msg() and the
> format specifier used expects a variable of type int.
> 
> Change the format specifier to match the passed variable.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

Thank you very much for this cleanup.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
