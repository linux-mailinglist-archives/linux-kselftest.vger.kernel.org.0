Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E11465A91
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354147AbhLBAWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 19:22:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:10996 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354160AbhLBAWa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 19:22:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="299976920"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="299976920"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="602501602"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2021 16:19:05 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 16:19:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 1 Dec 2021 16:19:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 1 Dec 2021 16:19:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcT1Nbkf+KrKrUAupQmNoampt94Tmoxfj8m4YRGkT69zy79TfNuJi2tpytrzoDLh732Fx/p1kHtbIpdtRiRIF00Pw1Ba3ZIVvXP0/fIFzUj0db488S5StM7gZy4QBskC6btUf1+ksdxWzFkk+iRAjmOUT71ne1QC3nIWq3nrNpjPdOKycEPDfNZViupbaeMWi5CVx0P83p6f6niw1LqWjpmN3TRwZMDHU8/V+dVNDI0gw51cqksEQfNRTTmtL1vFtqged+MIspPsfe9hJncwBFWtfgbJSZJRQ0S/rJ1GloKUYh6+yYK+VdcdrZrP7BsD1RwoSdaPJ1ne/rJ8HhMkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7MTxhPjGOrZOWz+1TynOG7I0KTsRBKQNwbxZCLs2tM=;
 b=F86JyPPcj0ufR2EAYY5nWuHsAuyRW/Pa3317soHhk2DFCzd0IjWfeFPmD2DQ0YKQRCy/vUsEup+0MpfykT7sJPp70E22THTkK6K8loexyouRdGqcLFaeEP4OObCVaoSywHeA36mBM49HKRPdYkmp/cZyfiyQrLNq3aJOXd8ZRM57bcS98iQQ2ElUsjIzcPPmTsw8o0Qpth8hc3KuoCmcoO22ImU7m6+D5crJgqEAPkvk+xtjVs12szgOXFp89bxBdhParmRa/wp7srMltmbJKdWFwysVdEZFMrNuiLXTx23juKYdwrJu6h9c4aoh1TJ7qHRUJuk9wM0v4cZN1Y7lkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7MTxhPjGOrZOWz+1TynOG7I0KTsRBKQNwbxZCLs2tM=;
 b=Je18CzQ9iDsJK/kpWEzX1lHW2AtQUmNp8cQCvUfeW1EJ4WLcmhGASTmaFHHhrmMnmEeG5a86TeVJMSONtueECGaZNsC736Cs6iv64cXH9JXMzC2nI6g0sXT9VcOHXj6pgJagVcwASeP1b2L+ScMktyAhL+++X/Gtan2FOk9erU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2675.namprd11.prod.outlook.com (2603:10b6:406:ab::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 00:18:52 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Thu, 2 Dec 2021
 00:18:52 +0000
Message-ID: <6d4eb508-f551-4c12-2e15-34ab9b1dc49f@intel.com>
Date:   Wed, 1 Dec 2021 16:18:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
 <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
 <TYAPR01MB633090B5A9DE4480D12CC9268B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB633090B5A9DE4480D12CC9268B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0335.namprd03.prod.outlook.com (2603:10b6:303:dc::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 2 Dec 2021 00:18:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf11139-2cb3-4926-a52f-08d9b5295169
X-MS-TrafficTypeDiagnostic: BN7PR11MB2675:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2675D52AE2C64A9B061BE539F8699@BN7PR11MB2675.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pnY1qD91pf5zJUjF8YtZXHebGWIARRJiSDyOcmJE+tWQm+QP3ZC6WrGl0N0Wss8SkXhuEYTbq1c0ja8TkQN83vr58T04WGvAqjBMGK0h62FVSrQq4HdSH7szyOst139qzJGHC5KvU1NzZ6FKPxivSvutxXamHGR8PNQvpS9hKqCu6JITwPlqQ3Rf1/B/2yJWPgAnxWa73QdSUfJlwtm+Xgj7mSdYjOl9vHsCGMOdwbQ6M0EgVZr+73xDWvZ4+lnFV3pUZz1vGdGwb6o9S0pd+ZpwCslHKYKnjFmqNAA1hS5KyZO4SdkgaevJZe1WH6iV9HkgN3Pk4MMuDoiCBq46MN5BYwkQt/+82verWGQU219GFKDIQaBRZaYfmOCQgmm8UoyAx7MaxSJtwmHyeXvDx+ZJjSsozsNaRXfiVx55MjPX7l7ixNPtQ5A2XL+AIykIIHpaLY3GMOfak8oTbDWz8s3hWo/ilkNPK3n3YYOiLW0/u6jFRFbONtxYOZ0F8cOs8pIEz1TuWwxPrHl4ZFaGqQvsCK5r5/aK7m1t+JGVsnwH2QY+X3O9bV5sjx9dOKdmkopXMUckw1FvjLD7r0g/vJcQvxtEhQ7ML5T1cJcGFXb93Mdnn6t33ZK1ZdBkv9QSUZ9C/tbUo8OlIizn5griDbuSOcOSKaqw8f77hkEm8iI3o5z1GvxacTXX8VlOKwfnlk+xwvd2GwQrqt/gDuyuZMUkIe7Y5MfisirPlsEb+bLUXQyO7xpSQxvJ5dfgQCMDwZH5Ayyb+F0TzC2pjy4Z36XAmo/G8iZgSNaVpU+CW5IvaUHWZEaVXxqc+zjRZe3DWy5Soup/Ce5SpQ5ZkKqXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(4326008)(956004)(8936002)(53546011)(54906003)(2616005)(186003)(110136005)(26005)(5660300002)(8676002)(16576012)(2906002)(316002)(966005)(66946007)(66476007)(38100700002)(31696002)(6486002)(6666004)(508600001)(31686004)(66556008)(83380400001)(36756003)(82960400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhLVWVJb1ZReVEyMG55Tmx0d3VOZmNNMDMyTkFNQVk2ZmtaTFN0Tno2QTl4?=
 =?utf-8?B?YmQwaTd6RVFkelU4WHVZU2J5RFVjWWtaSStEdHZlWUYxbjlwQ1FScmF0Zkcw?=
 =?utf-8?B?ZklRSjBIZFZ0WnhHSlZ4UXUrRGtUSEtIL0FmQ1Q0NXoyaEk1MjZmYVB5ZVZF?=
 =?utf-8?B?M2xQNG4wSjRBZUwzRVhoRm9JVmxlc2YyMkQzSy9SMkRPelJSeGp3NnA1aElM?=
 =?utf-8?B?b3pETEx6UTVXai9jZVZPYU1HRjdITGVCNjhGSUw5bkZ0aEExM1BNSzhQbHpl?=
 =?utf-8?B?enFqUHhmYmhTSFVrSE0venFUdE1aNHVHNGF0SDU0OHhpMkhTZEl0ZnF3cE1v?=
 =?utf-8?B?YitDMjlCYlk5Q3hiTWJtS2gvL25vRGtvMWlpaGk3UjVnRVJ0Z2tYdzBwVklR?=
 =?utf-8?B?SDFCUFhWdXkyby9jVUN3ZmljTk9TVDZXWGp1cmR0OUI5RXFnWGV0VTQ3am1M?=
 =?utf-8?B?QnRqUEcxbW1YdlI1MTBpM09OYjlHMzVrc3Y5V1pTQzBWbHRpYmZKeXNoWjFj?=
 =?utf-8?B?L1hnM3pqN1lFYnN1c0pXY2IxOUVPeGh1THdBSXlPbHhScE51VDI3L2tSNDQy?=
 =?utf-8?B?RXR0bldKTGZPWGtZdXlOSjl2YWo5WTdPVGpvSTZoZGxra1NwemNaclNYend5?=
 =?utf-8?B?ays0TXJaTVFucXllODkzZHhmRUFaVkxobEluRVJ2SzVZbFJOYVZVVWdSeVBC?=
 =?utf-8?B?ZENnK21HUU9QUjdHWFE4d2xQbGo4VnU4aHNTeE53a3RRdmdnNGdQbDhLZGRF?=
 =?utf-8?B?VmVHeS9xbmtCbk05R2dWT0ZDS2pUM3c4VUpOcG41RTZMaXc0TGNYYmlhT2lm?=
 =?utf-8?B?Qzl2bzQrZWE0NEpmaW9FcnAwbVNsemd4V1lpUG9KcFo0RGpjREVvRGY2czlZ?=
 =?utf-8?B?YWFGL0dwS1ArOWN6VmcvRm96SThON1NSYU1jc1pPUEZsSnNVVUY3VmNYSEJw?=
 =?utf-8?B?Q2dMRlVNU0VhWUNlRTVxWmtJdG1wa3l4WnVQelpkd01NWE1iNG8zMDd1VUF1?=
 =?utf-8?B?cStzb0ZhNmhha0JMZFdpTHpuM3ZINVBzbHYyRXJJSUVuWmdrUTdpT0F5UVNu?=
 =?utf-8?B?cHJFVTc1WGxLRno2ZU45eVMrd2hSVG50OGpTODJLQXNRZmhOWGdNcVp4YXVl?=
 =?utf-8?B?YUIwQStKZ1J4eGxpT1RZdnZSYUZoWnlTNmxycmJPdFEzU0ZaUmVwNzlFbVlx?=
 =?utf-8?B?S3JoZ2xBSGx4NG1KOWdJVUtyWEtzZFFPd2cvQUU0VlRiRWw3dW5jMVFEY2lk?=
 =?utf-8?B?TzJ2dnRYZnUwbDdWSXN1cjJ6UnQ3eUtKY3pzaEh0M1htWWFaSzVaL1R0NUtn?=
 =?utf-8?B?RjhwRHhVZnZFendCT1NBeElXWWNGaFRCVC84ekh1b0VyZ3E2TStXdi9temlq?=
 =?utf-8?B?STNVeGttSXhTQzJGZlBodWhNMWhZSTZ0UURqOWhPQ0JqNVVaQjkzZDNNekR4?=
 =?utf-8?B?MkdBN0ZnR2ttTnRFZ0hHcjdSVkV6YzV3NDE3OHdUV1ZzNVF3R1RPaTNEVVlh?=
 =?utf-8?B?bzJjRTR3bjlYQ1FvRDlGYmszTmNjU1JuMGRseVpBeUh2Q2pJbUpmVFBFTllk?=
 =?utf-8?B?NEMvZEdOV1BEQ01GUTRuNE5rSEVpSzNvMk4rL0JHMzJXSlpLSDFFTzBOVXpt?=
 =?utf-8?B?R2FXMWJNZkFvdEJ0eGwwUU4yMUk4aENJMlBvdlg1cFBDYnZMNnB5N25wdnpu?=
 =?utf-8?B?L0s0YU5LVloreStnbkExdHY0SkhmUGl3Tmdnb2FGNTFBS2IvKzdaRUt5K05F?=
 =?utf-8?B?bzJVdWJwZlY3VlNVVFE4MERFMEdYRDFiKytiUmVhWklZeVR0RXBrek9PajZ2?=
 =?utf-8?B?dzRrT3R0cWdFbE5LOG9nVldlQVhBZm9reHd5U2ZJOTNmZ1RzaDQ5YVl2V3dy?=
 =?utf-8?B?bkRHYWlZV2Q5dk1kZktWQXhQMnRCSVdtNUEyeFVoU1BNN29FdEQxd2lqeFZO?=
 =?utf-8?B?eWJESllta1AwUkZNbVNKMHI5L1BOcktrM2lzRW4vcmthRHp6RUlzTUVKWFFa?=
 =?utf-8?B?VjNOYzhPbXRJSDRydmlJdVg1NzlNVnltT01SRDE4QllxSXFPT2FjMTlSUjBK?=
 =?utf-8?B?Mklsd1BtY1RpbUhneXB6RUovbFdwOVFqYjZhSFBKTHJtYVEwY1NPNFRsR3pZ?=
 =?utf-8?B?ZDgxR255Sk9TUzhmT0ozbDM2WnhkT05RbmNUWGYwL0JMZ2hXajQ4cHZmdjNj?=
 =?utf-8?B?N25BTE1QNW1URGkwZi9lVG1TdHVSNmJWRnlzcmw0MHhBWVJCNnpVeDdEdVFu?=
 =?utf-8?Q?LKkIGgIIvexEPz/rzggGIKMs6Xkp3vVn+Vt4HULMzw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abf11139-2cb3-4926-a52f-08d9b5295169
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 00:18:52.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oCTRwUv0QD89QESMew5d5TaXRLX/ePyD4FpQuW+VAo/DeEKF69jDG4VuJGiFMtrxbw24SLY4zlX+XXDGsx5QqAt8eZlW1aqidbpK2Z+S0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 11/30/2021 6:36 PM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette
> 
>> On 11/10/2021 1:33 AM, Shaopeng Tan wrote:
>>> From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>
>>>
>>> This commit enables kselftest to be built/run in resctrl framework.
>>> Build/run resctrl_tests by build/run all tests of kselftest, or by
>>> using the "TARGETS" variable on the make command line to specify
>> resctrl_tests.
>>> To make resctrl_tests run using kselftest framework, this commit
>>> modified the Makefile of kernel kselftest set and the Makefile of
>> resctrl_tests.
>>
>> The above sentence mentions that changes were made to the resctrl selftest
>> Makefile but it does not describe what the change accomplish or why they are
>> needed. Could you please elaborate?
> 
> Before these changes of Makefile, when we run resctrl test,
> we need to goto tools/testing/selftests/resctrl/ directory,
> run "make" to build executable file "resctrl_tests",
> and run "sudo ./resctrl_tests" to execute the test.
> 
> With this patch, we can resctrl test in selftest framwork as follow.
> Run all tests include resctrl:
>   $ make -C tools/testing/selftests run_tests
> Run a subset(resctrl) of selftests:
>   $ make -C tools/testing/selftests TARGETS=resctrl run_tests
> 
> Linux Kernel Selftests :
> https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

Understood and this is a reasonable change. What you wrote above would 
be a great addition to the changelog. I think it is also important to 
add to the changelog that the changes do not change the existing 
behavior and users can continue to build and run the tests as before.

Also, please follow the guidance found in "Separate your changes" in
Documentation/process/submitting-patches.rst: Logical changes should be 
in separate patches. This patch does too many things. Please consider:
1) the license addition is not relevant to this work
2) the new comment seems unnecessary as it states the obvious
3) where is the "LDLIBS += -lnuma" change coming from and why is it needed?

When logical changes are isolated into separate patches it really makes 
the patches easier to understand.

>>> To ensure the resctrl_tests finish in limited time, this commit
>>> changed the default limited time(45s) to 120 seconds for resctrl_tests
>>> by adding "setting" file.
>>
>> How is changing the timeout related to the resctrl framework changes? Is it not
>> a separate change?
> 
> In selftest framwork, the default limited time of all tests is 45 seconds
> which is specified by common file tools/testing/selftests/kselftest/runner.sh.
> Each test can change the limited time individually by adding a "setting"
> file into its own directory. I changed the limited time of resctrl to120s
> because 45s was not enough in my environment.

Understood. My question was if this can be a separate change with its 
own patch? It seems to me that this deserves its own patch ... but 
actually it also raises an important issue that the resctrl tests are 
taking a long time.

I do see a rule for tests in Documentation/dev-tools/kselftest.rst: 
"Don't take too long". This may be a motivation _not_ to include the 
resctrl tests in the regular kselftest targets because when a user wants 
to run all tests on a system it needs to be quick and the resctrl tests 
are not quick.

Reinette
