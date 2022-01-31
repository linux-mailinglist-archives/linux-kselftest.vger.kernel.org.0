Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40CD4A515E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 22:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351138AbiAaVU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 16:20:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:50103 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380665AbiAaVU2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 16:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643664028; x=1675200028;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pziNtz0vPAOyGVwmTRUofncrGFl1uXhRxX1dvbP4T/g=;
  b=jt5wG+BRQaIWF3kQ1Ph8AYw3av0Rib2Eu2rZxL++V9YQqbdwSsx0btBW
   RC8xmdHmMS2CPVi5TsnWfkt2aQ4N+6eoc1Gr7hBELXayPgWZRuQhOFtyI
   EK/Yp7v6p21PowVI3Jgnl808qm7ueEV6bZ86oKDp9wnLggomB1SdWxQUO
   i/OQ6METRD2M/dGoe6N2pkalxArRWuYnW7Pb7VDKHLLE1KA9dGCWJ9Xaz
   JFLjoP/RkmQqTFoLQcG716sTFvsVaTSpmv9vlWpM4ZyEDChc2gYSSxAs9
   FrydYVOqubL33O4IKPhCfuUpQ8n8OAdCIYy7P1RQHza8oj9agvbeYZq9o
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="231123342"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="231123342"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 13:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="770903099"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jan 2022 13:20:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 13:20:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 13:20:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 13:20:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3+Rye0JvQE5AWzR2PNBateb0fG4SiL119h9Yeu0sWWECEdI9t48RIvqkpjSsRNKwJeJxs8FZw5hFxpc8vyKk3IHxxiq06aoCXUWa/rTK0vqsy5rhvirwBQmjKVqeu03gi3ybAy1C6sk19n/JQ4X2lE8pRaEYe/fWL816kUDr0+pZ2CBWyF24aENeeP48LQygSraSU2wmtmdiAznlAeQX09YugBGjGyijjzibHKIRT17dEPJN5tYFW4Au4dvKIDO3tvuj+i85qkScgYhQxriI8MzN2cnrUbIFQcwM9QwIW1DZRI8qDCG8IW9Ztns46q2HR7fdpjcyERrbVFdw/fNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwwKbPkvAXPWHuQHFvLehaFyKJb38aUPP38HiQsZImI=;
 b=Oawa9ABr8lTJsAPhzWC2lSn4FL7OB+5O8ffzgJ90yt4x1b50nuoh+gVLdd4CKVQT1Iv+gHAWXDOy9i1RbLMcllqy0CzCpA0iRH+kQr6E+x5lT1I5LLm+ENWraU51RPbE0afq8+svA8mB8Q3HpPKd402EJuof6GOSDMsJMm2eJyzzing4/UgucbhtfKaFUYixNUvzyNnuFdFjE6JEEtovDGJwlKspRd6y7nQCHJCCKqbvfOUAjgyPExXUkSYKVGEjJlNQmFATxEB6yG8yuqW5laYVwbgiUGVBsGoArn1EW2Bx6DvBYxUvBVZ8toCLrp6CvI1asOR9a+KryNtJoPuYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CH0PR11MB5753.namprd11.prod.outlook.com (2603:10b6:610:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 21:20:22 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 21:20:22 +0000
Message-ID: <6f9083e2-d633-d483-702e-f974317133b7@intel.com>
Date:   Mon, 31 Jan 2022 13:20:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH] docs/kselftest: clarify running mainline tests on stables
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
        <corbet@lwn.net>
CC:     <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220126201341.55771-1-skhan@linuxfoundation.org>
 <7ba5e99a-9169-75c4-2324-f9a3ce9a506e@intel.com>
 <bb1ba6f5-4cd8-742c-62b7-a62a6f4cef91@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bb1ba6f5-4cd8-742c-62b7-a62a6f4cef91@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO1PR15CA0075.namprd15.prod.outlook.com
 (2603:10b6:101:20::19) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd8eef9a-9504-4afb-5fb7-08d9e4ff7d72
X-MS-TrafficTypeDiagnostic: CH0PR11MB5753:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB5753479852A2B9A9A2E566DFF8259@CH0PR11MB5753.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1yWfs1EEuvhxIIR36kydeMV9AAMYAHh2+7McZp6Ti2HPO8RRXgWtTFmsPClHNO67jhN+QqbwKrBMtPoFAd5I7eniZg0z6KgqitY+Z6t/UcCq2zCBJkTXSqILK+tt+HAvVV4qS6iABDaCxmoUxnBgnZswYmxBwrhtDLeCEGE0VgiP5Qvh8BKZg4B0YTNl66CdYH7V/frBHD4qIHJNXDYd1+vIHmhNeaMkHNex2kIcwCeSQOoSskFuL2ff868El80VlK99ZGc3SJ6Z183JIWeVQSgkbSjDDLoU/3yjT7yCATZsfMwruSEkmq59bsOrIg1f0z2iNQpCuHGkZREhDW6wi7ep1ID/XYwJZuVEBkmNfGqtqpZxhid/RnG6nOU7C53qs6W0eGjdABPTd06c2oKJcLaN5C4MHw0wkrGk+JOYAOm9EqdgYGhIy/8zryI4bZ7VKsLVZ8bLFPg9z3qvUTukGsFRySZvGiwc0M/1PSOWFBW0yhh/u/pHkDXhsiwdNIWWjQVCpweaPw+p2FWrSXrqzGswlwb7UvHDfYLoSLTqSJQj4YEwZuwivmoUXp0z0GuG3VXUkD+j2zedIkUG3ZvrKmqBtj+vGB3urBnIh6Zu5mG2Ow2lFgcnt97fFawg2PbBHo833UpeWSgxb/ycCpatdZmM7P6ideDkNvIGVaphQiKHCoRz7klhVZnpmprp3dvsz9T/37tBwdvv6hG0750mg6YcNKZff0LizWnZpBBA1IxHCkUmhdgzDpoVtWgy+SM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(31686004)(38100700002)(83380400001)(2616005)(44832011)(2906002)(186003)(26005)(316002)(8676002)(8936002)(5660300002)(966005)(6666004)(66476007)(6506007)(508600001)(86362001)(6486002)(36756003)(53546011)(66946007)(66556008)(6512007)(82960400001)(31696002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cERkeEUvQnB1cjlDMVNJR2ZGZGhYcWNrUVUrZEgraGUzbmtZS3c4WkpkZlRu?=
 =?utf-8?B?ZlBUQU4yV0lSTElMd0pZVEp0ZlNzQWoxNk5ROHRZWStpeVVIWndyWEhTMkNI?=
 =?utf-8?B?SlltVjF0VmowZDA4b0xoUVJJOU5pWER1ZEFzYWt4SndUaDZ6R1Bac3ZOdEYr?=
 =?utf-8?B?VUl6VTZna0M4WmFvblBDbzJTdEFiMHl2cEF3TktaRE1SWmRJQ3FCdS9yTkVJ?=
 =?utf-8?B?ck5uMndZY1ZyYkg5bUtNSk1YVEFkc3l1NVpYOFV0bkZHMzFwdnErdmg5azIv?=
 =?utf-8?B?QWpUWHkxQTBKY3VQeFFwRmFXRjgwVnM1aVRxUjhrZktNem5iK21SbkVOT0Zh?=
 =?utf-8?B?Rnc1elZkTXB3Zm5VRUtQVGZPOGpYNHBRRVNndE1JMlJOQ2htcmRaL2dFcU1Q?=
 =?utf-8?B?cE5JV3VUMHRXaGNKaWtRNUJDcWhtcFMxdFQ2SHdFckVqZnozcXlsRnIxV2lI?=
 =?utf-8?B?N1lRcVJ0MGdjTWQ1bzZvNERvbmx4ZUZyV3F1b3lqcjlXdEFhdWgrWTJNSFc2?=
 =?utf-8?B?eXZEMmpzUTVwQ1ptWGpuTi9aTnVnZkxxY3h6RDRPVTBCSDFoeWRwS1NPbVBw?=
 =?utf-8?B?ZmJGMnlFRFU3VlZBTEY3cjRnVmZ0d3hQYlhuNXRMM01hb2NMMFJPR0JnNXlt?=
 =?utf-8?B?RWZhY29yNmUvZ05lVlgvdkJNenN2N0xzQVplV05KVG5zVVJNUXlEaUVJTmQ0?=
 =?utf-8?B?QlRsYUF4YUlFQ3U2UTRRRkhUT210STBUVGIxakFIYXkwZW9uNnR5cW52K01D?=
 =?utf-8?B?RS9zMWNzeEovelhLejZzNmlaQkFVVzNPV25EdXREcERNT0ViMzFtMEZEZzIw?=
 =?utf-8?B?RUNFQWdZNWdLbktkeGJSRUlpSE16a0xJOW9hK1Q5YlBrWHQxOFhpQjRLTlVw?=
 =?utf-8?B?b1Z4QTBXVzJTUGZNOGV4MXplS2llQ2tlcFkxMjZ1YkRtMmVpSXBCYkpuTzBU?=
 =?utf-8?B?am11blRaZlFpTjA2bnZEa1BBZlZhMG1QT2dRKzRhSWRraW9qbGhLa0N6Njg5?=
 =?utf-8?B?c2tBRXQxc21DTUE0NFpFbG9oZCt6YUxOQWw0M0w0R0xqNzlqUmduMHhYY0Vr?=
 =?utf-8?B?WlJnUmJ0NnJ1RGIzMS80cVlZdzkxVU1MSFVKWEUvSWI4THN4c0p5eHpQVW5Y?=
 =?utf-8?B?MDR0TENyeGV1UU1lMDBBSlRQSzlzb3pSMTJFZEdwZ3RmVjduNEFFcXZSSVhw?=
 =?utf-8?B?dWNXSDBDbWVtUHU5VU1wNUYzdTRIajVPeGJ1OVEwMSt5RTNqZXRJQ1p0RGJX?=
 =?utf-8?B?eTc2cWVka2hVWVVBVjc2UzRIcmlyK0d2M3c0aWpZeVYrRXVlZ1VTSllHcm05?=
 =?utf-8?B?NVp5b29XTmV3RTE4d1hEUWNoMnZHZGR6OFE4WmszNkdtZS9Xdm04ckwxamx5?=
 =?utf-8?B?MzVKVmUrMit0aTZoU2V5SkhYSjVPSXBpbXdqM3Bxa1JLb3JjR3g2b3Fwek9O?=
 =?utf-8?B?VGZ0YUlrQTJ5TFFaa3hKZlZPMHNBQXlIejdyR0ovMnUwTEx1RVVXREdxOHh6?=
 =?utf-8?B?YTNmdFZyZmV5U0Y3NUExOVAwNElVZnA3RlpiN245MW1Ibm1tSVA1YnpKejNU?=
 =?utf-8?B?NGtmRHM0U2hWU0hmR0xNb3U1RVhzZVNNQjAxVFFieksxeEVKY1FOYXd5eXVn?=
 =?utf-8?B?M1gyZ253VzVBcHE0dVhzZGt4ajlvdmdnbHNrWElqYnV5TFpZcytzYTEvOHZN?=
 =?utf-8?B?MkMxRUZuTCtkdWlOY0I1Q0RMMHp0bm0xTGxsUlRWTkFaRFFkQ1JmT2dVMFNR?=
 =?utf-8?B?SWtVODJQdUN0WGJZZThyaW53eFMzK1FqYUJpRndtZUxtKzVuT05iVC8zQVQ3?=
 =?utf-8?B?OVZnT2hIcmJDYjNzSEd4TVVYSkN6cXMrdm9jYUVaVDdSbnZDbTJqR1lEVEtw?=
 =?utf-8?B?WGZJMjByWkRRVEgvMldwckZMdmZHRXFUbjVjcFlzR1hnemFoZnZERVBWM0l5?=
 =?utf-8?B?d0E4RFE2UUZPMUtSdGg5YjE4cVcvbXlrWmxRSkJSYUFXSmhiYTZOMnpaMzJP?=
 =?utf-8?B?K2p5TjdyR0xQTWg2VitsNmFBdHRSeVMwZElaekVNZ1dKWkVNS3lRanpBMWVx?=
 =?utf-8?B?YW9wemE1VE1pVVp2bmVuVjg5Yklpb1pxUEp5OXAzaTFnMUVxWjRtdTZUN3BW?=
 =?utf-8?B?aDNQNGhYMSsrZnpQMnllL1NYNkRqZGdrQnU0K29JMUJCUzA2dENJWFoyV1Q0?=
 =?utf-8?B?MVN4UGVlaDdCL0lTYzBLV2dXOUNWTnBYUDRrS0FNUmpqNmdnZWVnU040MnBi?=
 =?utf-8?Q?VRztf8F3+89Mf9WL0y5OenkYF8TRVza4697NpzvG5k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8eef9a-9504-4afb-5fb7-08d9e4ff7d72
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 21:20:22.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMpk0H6qJn7pSCg8bchpaKsYNHgJZ7Cxyi62kiTcPqAkZP2JIts83+mlBMsw1FkO0bH02m6C3ZCrteFyyHP2agiyv7VF5P7oCBAmS3/Bo48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5753
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 1/31/2022 12:34 PM, Shuah Khan wrote:
> On 1/31/22 12:37 PM, Reinette Chatre wrote:
>> On 1/26/2022 12:13 PM, Shuah Khan wrote:
>>> Update the document to clarifiy support for running mainline
>>> kselftest on stable releases and the reasons for not removing
>>> test code that can test older kernels.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> ---
>>>   Documentation/dev-tools/kselftest.rst | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>>> index dcefee707ccd..a833ecf12fbc 100644
>>> --- a/Documentation/dev-tools/kselftest.rst
>>> +++ b/Documentation/dev-tools/kselftest.rst
>>> @@ -7,6 +7,14 @@ directory. These are intended to be small tests to exercise individual code
>>>   paths in the kernel. Tests are intended to be run after building, installing
>>>   and booting a kernel.
>>>   +Kselftest from mainline can be run on older stable kernels. Running tests
>>> +from mainline offers the best coverage. Several test rings run mainline
>>> +kselftest suite on stable releases. The reason is that when a new test
>>> +gets added to test existing code to regression test a bug, we should be
>>> +able to run that test on an older kernel. Hence, it is important to keep
>>> +code that can still test an older kernel and make sure it skips the test
>>> +gracefully on newer releases.
>>> +
>>>   You can find additional information on Kselftest framework, how to
>>>   write new tests using the framework on Kselftest wiki:
>>>   
>>
>> (My apologies if this is already documented, I was not able to find this guidance
>> in Documentation/dev-tools/kselftest.rst nor when looking at the
>> "Kselftest use-cases..." slides linked from https://kselftest.wiki.kernel.org/)
>>
>> Could you please clarify what the requirement/expectation is regarding fixes
>> to tests? Since the recommendation in the above change is that Kselftest from
>> mainline should be run on older stable kernels, is it required to backport
>> fixes to the tests themselves to stable kernels?
>>
> 
> Couple of things to consider.
> 
> - A new test gets added to regression test a bug in stable and mainline
> - A new test gets added to test a kernel module/feature/API that has been
>   supported by stable and mainline releases
> 
> In both of these cases, running mainline kselftest on stables gives you the
> best coverage.
> 
> Kselftest fixes get pulled into stables like any other kernel fixes. If a few
> fixes are missing, it is a good idea to back-port if they fall into above two
> categories. If the test is for a new feature then, it doesn't make sense to
> back-port.
> 
> Hope this is helpful.

This is helpful, thank you very much. In summary I understand this to mean that
when testing a stable kernel it is recommended to run tests from mainline, but
running the tests from the same stable kernel version as the kernel being tested
is also a supported use case and thus fixes to tests should be back-ported. 

Thank you

Reinette



