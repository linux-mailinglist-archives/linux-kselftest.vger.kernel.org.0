Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD3469E52
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 16:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349476AbhLFPiH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 10:38:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:38689 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388422AbhLFPcm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 10:32:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224586251"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="224586251"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 07:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="502160271"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2021 07:23:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 07:23:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 07:23:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 07:23:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 07:23:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkfctQwJgaX4L7DoqMzDMDDCB6/IP3DPec+hyEFX9wHa/BWgChpTWbv74k5+nBuVbhRrTlZzK2c3msCRc0tYxzccb1W+5LA6h1uomX5ApE5/1AGoR6erUkCX25tRRHQiJStqKl6yhbTmRYTrdMAIweukmW8MqsqK3JTNlqz2d8CoSkJ8wP0RjDM4I3wX3gTwSHr+W2vcqONBgN44gvF+gBIIiVmjyJ/dDebkbIAjd9IWZH9S+9CYqEob8Pu9hxIxasqX4l2ZCK23OcgCJoa+M9ErUu2K/9osvi1LrA9+/p6Y149jj7eAQiWsZZLv9HlsPFi0AaPK4rfqt1HHWfYeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHsluecfqcnv7Qnvk+p7JNwuCKYNwl50EyFDb86iYS0=;
 b=lM0h2P9F99qYmQQU9M2X95kHqXi4XvOVGA7NBJ5MaHLPeFjS86QCTVrWSEohysnKcumWF3/NpMIJZV/CCTje7y9I7HtRM0AiiSBgunLZSGpRENs1Lwejsra8RJL++MvnEVCo5prF5z6VIrojznjqCW7or/FoN9wgTBlTxTd7i17QVAW3rxv3CBNx1dVyver96j8JuhryffoWtzbQn6MZsdnVaNiPWyftTxAEBHQOxlstFq7+rhoy8cYx32A9mhpu82Z2otndSgeoXLSlUHE3vy22Dko5BYv9b6lQPJUTLeahIjwOsjZEKYQGRzpyTduzVaSFzHGRIL4GgyHciuigew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHsluecfqcnv7Qnvk+p7JNwuCKYNwl50EyFDb86iYS0=;
 b=QL0HkkS6LHkqGC7Be5aa+Tu+kvs9UpZTD7BgdwpYQ/hBTVspMZhA1Up+2/LLEFCHIfbhFGseaA8Fwpidx48gYhFf5wB01O9IpqSkI0Tc4DYwe/c3I0botGU3N62cQkCJE940zaOabZYITwoBIqj+S3naW1AuqLJumNr1QglPYGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3555.namprd11.prod.outlook.com (2603:10b6:408:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.15; Mon, 6 Dec
 2021 15:23:25 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 15:23:25 +0000
Message-ID: <768fbe83-91e8-abee-02e8-aa5505f48fdb@intel.com>
Date:   Mon, 6 Dec 2021 07:23:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
 <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
 <TYAPR01MB633090B5A9DE4480D12CC9268B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <6d4eb508-f551-4c12-2e15-34ab9b1dc49f@intel.com>
 <TYAPR01MB63304F1E1A04D48CA7632C658B6A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <e26efdc5-83f8-93e8-9aab-7e21ceb99254@intel.com>
 <TYAPR01MB63309592B2B82329246319878B6D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63309592B2B82329246319878B6D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 15:23:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c644a835-7165-45f6-6b17-08d9b8cc58d3
X-MS-TrafficTypeDiagnostic: BN8PR11MB3555:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB3555E9CE40595F926126DFE1F86D9@BN8PR11MB3555.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7jbTRk/BmcsRi1PnzBG0NcYWBC1NiAaIXkae+bm34J5CbkyEL6Z6ovhKFjFROxRN8dbnLo2LyUs7IeVZdY8HZJhUbRQNro+7ryTEdkIwMc/QYxWTDRfRMGdfhifkzHgoozAvDS3Bt/4GlKmKuFAeTo6p9O1lMQ0YQhkXMqgEg/OOC7E2BsJ+sT4kt0LLnAJOs8iN6F4g0fYlc9EysOZ0LMGZW+x82lrS9atK2J2InjWhD6pXmYdW0dwy0or4ZjRo7h9jjXGcS1ye3E09tp0XotOo3kRg6TU6WNdoxua3A9/5lUhnWV8+KmnKOw0CrFI75QSHeSfuN496uKGeKDhZSFmCZwOoou/Fgna9u6xWEIvi6Hb/LvHw17dxUDCfo+fjB8aK+vxczTE7TY2A6vosqFb+VmlzngPV2QylT3ja5KnB1aBxZXSWysRVR8iD9JKcp405yrJFqloduqNBvg0EIliWfKVoevNyCoacetsrGe6rMznj4++MvM0j44JosU9LXx3KJZp9QfUHdPsMTalUDmtgpZZQ+rXw3IBwqyZdtbiAFtmkvwRfwgFoFfHlfhvys5kmEj1kNfCQqdCJ9zNEoy1/syXFLIaXZHaApIzXUOmlS3KV7yo1RSPn9+oi3J0aKXrYtk9GlPp2bXAM9eNEmGaad99dY1tdHwdIyBf4g+6OzVuLltQRpyOLydek32HoxaAfUPIuZ03e0JbIDum4wKTlYEOAqiMLj8ORrZjUx80Ho8CBOiwcyDi088iZlqL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(31696002)(44832011)(38100700002)(8676002)(508600001)(66556008)(6486002)(82960400001)(66946007)(66476007)(16576012)(316002)(54906003)(4744005)(2906002)(5660300002)(4326008)(26005)(6666004)(53546011)(36756003)(31686004)(2616005)(186003)(86362001)(6916009)(956004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZmNDF3REdJN3VCSG1yRnVMU1VJYlZOSHIrUzEzOEhXbXNGWkVaZ3U1N21X?=
 =?utf-8?B?TFNQZTFubGs0dEd5VmtXRmgrbVlMZmhTNWt2ajkrV040S1FqRnRXdG5UTUpm?=
 =?utf-8?B?WnM3em95QU9LNFY3LzAwbmkxWk5NUHJ4ZWlqcnpJZTErRmpqZDNmMFVYaHBy?=
 =?utf-8?B?L0xlSUMxU0NyRzlaTDVWdmNZbkxMMEhWdDlnSm1vL3JDV1haVklvcEMvZW4y?=
 =?utf-8?B?Z1JONCtrRnFmeG43d21aZlNONE53Y0E3SXJIQ1QxQTNNTkJDKzBXNVRwbXY3?=
 =?utf-8?B?dlhwWEhwN2xxRTduc1ZOaVpsU3VrZzJYTlAvT2tuYjRUSWJYYnpERTZ3RStz?=
 =?utf-8?B?Ym5nbURoNk5qTEx1dXpTNk5kTlBMRU1IdUZtbk5JdUV6UWg0ejE4dWliZlZn?=
 =?utf-8?B?NEhCM1dGM2JvYkF1TmQ1cWM2ajROMzF6dFVqTGw4SnFtS3RjUVFMR0YwclUr?=
 =?utf-8?B?MnU4VGZzUm9OckVRWm9CMG5YSVViS1lldlEyS0h5dnhPbEN2WHFRL0lMZTVi?=
 =?utf-8?B?L0doTGY4TXdMM1B0YU1sR0F4UHUvbStJR0ZBMFRpYnFEOW1yb1YvRHJLL29u?=
 =?utf-8?B?UWxaYTA3a2hQL2MyNGZTNllGRW1sWVQwVFlaWnI1d3NUa0NrZm1MMlJQMFBh?=
 =?utf-8?B?M010dDduT2lWSHZiQjBnZUlzVnJzeVlLRm9KZEx5TUc3amlYTTZjT2Evc1N3?=
 =?utf-8?B?ZVRVdXhENGZzdXJnV0Z6YUpDWHhzREhtVUtmaXZrOGRuSnZVd0ZCVE00K2lB?=
 =?utf-8?B?QmJuem5tekFheC93WTk2amkrNGpoTWZNMkx1VjNGWnJXcGNmUFB4c3EvQ0Vt?=
 =?utf-8?B?YkdWZm82dDJIUVBicFBxTkVFNDA3R2VjUHJLajNJdmNBbTVaWWJQNzN6RG5o?=
 =?utf-8?B?bFdZSXAzOUpudUc5ejVyYzJXd0xCUzlYTHFrNENOYW85aXVzdjdOMmtuZHBw?=
 =?utf-8?B?eHRTUXVvVkdadU04WjEvWjE3aEJHc2ZNangvTk1hTlhmblF3MHp5U2xVekY1?=
 =?utf-8?B?V081Z2t4bzhldUdlR3hpZGdzNDd1UnBmSExwNDBhK3ZYZ3VkNkV2b1NzMGo0?=
 =?utf-8?B?RDJGQmtXcmt2Ukp2TUJabnd0NlM2MDFTT1VNeUYzd2hqUWR5bXVJTlZPL0VO?=
 =?utf-8?B?cmh3R2NzVStRVENNb0g1anZxTm53dWwrcTR3c001R3c4VGM4ZGRCZTVmcEdQ?=
 =?utf-8?B?b0ZTQmphcnVFTkdtL3FIUGhDZGlwZDVjb1JONXp6aGpoaHJ6bXBxZGx3VktE?=
 =?utf-8?B?R2RXM3k0bm0xVmR6c0JPTVRKWFJDNnFWOHRvWEdiU1J2bUwvN2szcnVwc2Qx?=
 =?utf-8?B?MWlXNzFhUXJVVVpONk15bmdGNFVObzgzUUtySDJia0NTcllQNnNDaU5EcWxI?=
 =?utf-8?B?RGxHWWYyaXJrYzNCMXorQVhEbit1blpLYkFrbWpzQXB5bW1SbmFXSTZGblRD?=
 =?utf-8?B?Qkl2SUdJMS9ZaTVYNVNuSW56NHFjcnFJS0VHbEpTeTJSNXFpYW9SMms4am4v?=
 =?utf-8?B?bWlhaWhQYlJKd3BMZm5sS1AzdUtqS2dJSlA3WXhRcWZsYXNaVG9oNWF3WDFN?=
 =?utf-8?B?NDZPRktWWUt0dTcvTmFOTzdEblp4ckJyK3NLU0hMc3MvdE4rTC8xVXlCdVdL?=
 =?utf-8?B?bW1ielBzRUFob3l5cUVYVFpUcjlZaHJNOWh5alFrc1dSVkNWL3o3MEorSE5H?=
 =?utf-8?B?cDUwdndSRTNLQnNxaSt0VzRpdmVvZnBpYkdZSXY0Nks1dCs3d2lRT0lEczQ2?=
 =?utf-8?B?WE44ZHNnclR0UHA3T29Ia1ZwZ1JoenhvL2xCL2JLT1ZuRkdOOUEvMm9hZkVI?=
 =?utf-8?B?MFMxK0JYUDdOTDlsdlAzK1pVVGZsT0tkN1I5amtLRE9mTldvZWFCMFF1eExE?=
 =?utf-8?B?cnBQUkRaa21yOHdocWpJaDVCQVBPYURrQU4zNDlSeHhIc0hOR3kzdW1uV0tZ?=
 =?utf-8?B?Vm9GOHNFM0R1dU84TkVOWEF3bWJsY3pGeU5KUGJrZXlDVVFiaENWM1RlLzRR?=
 =?utf-8?B?VkJhZGtZRHZBSWlsZ21TMXphWGxLeGkyeFZ0ZzQ1N0ZHdDRZL2k1UGJMcU5u?=
 =?utf-8?B?R281QThnNjNqb3RtRlRNMWJPZFVGQ21BOWFkUXF1eDBTSWxzc2VGTjQwMEI4?=
 =?utf-8?B?VFcwbjFjRUppY3NCUDI3Q1FLeHZ1U0ZuLzhVSDAxcXVPRCtNUzNIZmlSRld1?=
 =?utf-8?B?eVRxbkhjUmJvUUJiMHUySkpZdlN4K3o2ZDA3bGlTYzQvWTlDYjU3TE1zSFBl?=
 =?utf-8?Q?wsH5lPOj2dvoUJI8YdaVwEqPQ5sVqaVTin9/p+A624=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c644a835-7165-45f6-6b17-08d9b8cc58d3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 15:23:25.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcseyXpup+Fl7V241256tAIYdi557jU5Q7jusFuXcsVUztQsR0uGh7+wUw5G2uvvKKKdpmK98mbjXqVvOePozamiV0MrnJqDfPHoxr4ARds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3555
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 12/5/2021 10:57 PM, tan.shaopeng@fujitsu.com wrote:
> I will separate the part about default limited time to a new patch.
> In order to get some opinions about change default limited time,
> I will add a description in the cover letter,
> when posting the next version of this patch.

When you submit the next version, could you please change the order so 
that current patch 3/3 becomes 1/3? If I understand correctly, without 
the SIGTERM fix, the test would just hang if run from the kselftest 
framework. It would be better to have SIGTERM handled before attempting 
to run with the framework to ensure things keep working smoothly.

Thank you very much.

Reinette
