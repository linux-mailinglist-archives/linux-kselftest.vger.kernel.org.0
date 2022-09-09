Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A45B2AC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 02:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIIAHH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIIAHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 20:07:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665310E879;
        Thu,  8 Sep 2022 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662682024; x=1694218024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7FYe4D8uMIJgRseJsB8oMlVUCQO8BsFS+6u9cehwv7E=;
  b=Sv3uwZuiMpbXnAE4hPlGpFTsT3wCWOs2C40rizOWuhORJBkXeji6GRby
   Gwlq5lG90wKyEmOnrsnLTlwF24Fd3Te2r9Adhs85njB1QBCgakOwMG8Oi
   PxmKoDMHZCmglWew3dQFgywInquN/IpmaJC1LuMI0yk2d+wBCn7vKsjY7
   scOBv1HsDvJzVvU6t7XmMmB4CiXEKg4V5WZGAUw/Qcjoyozyp0u6FshsN
   mbeJYosyc4h/3IVMMnEdquhOmpYraKdWZccbcbY++mGMBqrk7c7J9qkZs
   UPDRkJCmHaIUTMMFOfRUD+pmhrbKnWQi1yqAndjl2CSfYCW6xFXn2LIxY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297355886"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297355886"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 17:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="615086468"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2022 17:07:03 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 17:07:03 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 17:07:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 17:07:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 17:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzsFNGs3trB0/sQxF0q8OE06Zb1u1NlhdcwqCqId+NeiiQksnpp3xxoCdUMpoCcCy/oRjDZcgxneGJ0yq9n3HUtCbwSFa6yNxP2zdWlBFHeX5hZWk01GiA+uXt7+f0zTetRDQoNw4TRiP8x8vup3pJc9iLR0tvwoGpsRY1u6DHVQt447qo/jZ8uuuzcWq82j13P6Ge9iDr1dOaq5w6i4Hlvd7sMT9rJxsHDVqWIPhJ5OTJxNEYWU6i2DefoyXYik4E/rDKeytBmx3YDIZ+BpmXgWiXAOp0V+T2mrhiuFYs99Rkmh23yE31ZDylJGkVuVZlE+BsiVu0F7c/abdZLoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6fIhlVbGR/wN5P7lgi1wjpThleXMeX1s9N78cXv+d4=;
 b=hv5Qiu8spkqWtqAW3d76q035853psbBHrwkSGHsPOuTrpwCLcVY0tPo4BFC1wo+JR6HKcHdd553d62rT7yzM/75Afz6vpPEg8Keq3OUrQBBvYZGzz5KCfaYR84nyiqxrqF+HAc/SFuZlSroiqGd4J6MBhIdodGw3Bi0BQtLH8W42g3UrmvtGiCHe3XYLjomGd+o1MNh4ggvVTHL2p+Jzx+EpTdiIK1/St2yokDrFqfymTUSKjWjYjQ6LFH+6T2aglZbcaARQqK5PX7lHZ52pg7Nj51PtJR/nuxMPNKJy04Oafh/LpJkduXCVukp+c8rrRmZdC8hd3evSBZdTFz+6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 00:07:01 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Fri, 9 Sep 2022
 00:07:01 +0000
Message-ID: <d2cccc58-b6b2-4153-0c1b-8d5b39ca0862@intel.com>
Date:   Thu, 8 Sep 2022 17:06:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/5] selftests/sgx: Retry the ioctl()'s returned with
 EAGAIN
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-2-jarkko@kernel.org>
 <fe0e7a0c-da41-5918-6ef4-8906598998a6@intel.com>
 <Yxp4iIKjOQflQC2i@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yxp4iIKjOQflQC2i@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33b8cca8-e25f-455c-4097-08da91f73809
X-MS-TrafficTypeDiagnostic: CO1PR11MB5172:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pn3+m+SgPBGc88Q3LiLxyog7tilizUFLfdMDrGx8aQFY387+kTwcNUlXCRN7QzCtdDdLq/kwDv+knfea0+5zyYLwMNAk98yGKXory7sK+uRYhF37pAmE/AjgGnvlRg4B8a2jgbtDRw7RsQiB58Rgu3DsV1rlWNF171XgkqVBUN8Qt/Zx+dzeHO0fXNwJBDwK3NwA+UhKcI1ciKRdZap3SJBtHjNO5AEIfgR44/KtGHCkNtK/LpwAce+kWfE2+Oz0uTRXinwy51DYmEywrIMvUrvFNahdoGCOp5QZyvcwCMWiCW1SbBSabKxJizBaQdwFa3wmH6Erk9fyQipbufcdovjFwg2ImpU4rxLSFbaNSmTRn8GarFGA77oqGWLsV2gKLWhbZd8ssVwYQyyinlpGo4goT6r9VhpC9RWbGa+pDC9XFfV9Ob/KS86YcEZKXNSTp1Kb9WlMBS4VJ8C06FqB3Z27YkcEuFPZcmFrHehXbkIiBG3RdVkzU8rPzdeYWZ9ur7XctcdJ6U6Zezq94P2kwYUE0Al2+wVTfIlFDxc+Z0YNAXDM7XhAPzafixwnaOQO9ddEPb/0fRr5KA+TrQRoZCJ5vd7Dre4pHPbYIWUa0r6qRAtAwwgLouPRxSklXYIBvelQfbq1hLgXHgqZtFtLKVHP8wIHKsZG9yf4AYVm9XI63K0pI9Xl3kUEThERiHTNQ0USNyNljd72BxiFyIm1+lwD/HfxXaNX7SOShBFmbqcDxSoudNthVonoB91VNs5W65lmbg/iSXXQ/FuP3iJJBX1x0UH47BJucORnK1gchiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(316002)(82960400001)(38100700002)(31686004)(6916009)(54906003)(36756003)(8676002)(6486002)(44832011)(83380400001)(6506007)(86362001)(4326008)(66946007)(478600001)(66476007)(66556008)(8936002)(2616005)(41300700001)(5660300002)(6666004)(186003)(2906002)(26005)(53546011)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJWOFJROVNDbFZiRlZ2UVZISGtOMGFBaS9ISDJwS0RMYkpnL1R4RFhVQ0o5?=
 =?utf-8?B?OVRyTlFjeDlKVHNXejFHQzZkeEZDRVNPY0NubGgrZEE0SHhxckxjMjJzSUZX?=
 =?utf-8?B?RnpqOG5pTTh5TFlRaUxLMFBCUG1iNFZDa1FwemcxVHhDQkV0TTNKMmJPTmkx?=
 =?utf-8?B?bGJDdmRTZmVaazRsTGtCdnBVSXlJWkxBZDJaYy9WYm5NY1VtYVZsZVUvaHE1?=
 =?utf-8?B?MlMzR0tVcHhCemhIZHZQejRCRDRzMEtMTHVhVXRsaERWRUM2Ui80dmFMSjE4?=
 =?utf-8?B?Qm1vZTVhdVpSM0JDSXdXeFBzQ3U5cU41a3N3cVBWVXB6M09GVkFrd2NOVkxE?=
 =?utf-8?B?d3FzSlVFSWtOUXpDNCtKSU1tZnk3ZHBKQm9ZR1p0VnNvUXM3cXJsVG9sY09I?=
 =?utf-8?B?RnVzeWZvU1RtZHpxV0FXb2dVQzFWekxZRzh4bFcvMFZGV3QwTy9CY1NGUXhN?=
 =?utf-8?B?bXpwS2dXZVo0ckNYVjBESlVMNWhRUEI5ZmV1RG5xMk9RS0RGMWNnYkdDVzFi?=
 =?utf-8?B?am9ZcUczZzdRY01NOTA3TTAwZmxOS25jREtDSjNFckVVL3BVWnUvTHdkcHNn?=
 =?utf-8?B?RVFHNHUzRSsrTHNBNXZVZnBmbkhVUkpvRWZ2MGtNaVlIb1BWS251Z29aQUNI?=
 =?utf-8?B?ZjZ6ckswM1B4eFNuM1dhVFl0VHhHbjNGcUFDNDhNWnZjSXoxYStvR05ZN1dK?=
 =?utf-8?B?VXE1blZjNCtDY3Z3bDk0c2tQcUxNU3Y1NmhPOExudUlVMjE1d21TKzFCQlBm?=
 =?utf-8?B?YnJWOCtlUmE3SlZERW5kSk8xRjBENUxsUzJWOHBPaFNsOWFCaDMzUGN0bEM3?=
 =?utf-8?B?c1I4bjFhMU9JazE3MTBWY1dseU1QK2Z5QWNWRlVLdEhCSWdjY3FOb3NTRUxj?=
 =?utf-8?B?Q0JOTzU1NCtvSFlocUYrTXV0ZDN1d3pXTkZhU0JRb3orTnRpSmVZOEo0M1Jv?=
 =?utf-8?B?UDVONHQwd3p5bHN2SEtlTkg1d0xnN1cwL2hhT3VNNktTTUhmVUxucVd4WWYx?=
 =?utf-8?B?bjlqeWk0UHdUVzJZRmFYS2tMSTBMN3pZTlVySXRtNHpvWlhpNzRVNW9NNmRl?=
 =?utf-8?B?WG9RSWg5clB2WVkyZDlqbWd2VWJrUXJHdjZtL2Ria2gxcHBMd1VlL1RqdGZI?=
 =?utf-8?B?VDFNWnkrQTd3UGlwL1dMTUgwNjc3WXRjelVwVkk0MlVyUURBcDZXZGNMOVdQ?=
 =?utf-8?B?b3ZRMlZ3WHNBL1VYL1FweDNkcXU2RXZGUTRyK0F0WGI0Y1gwWUFjc0kzYXI2?=
 =?utf-8?B?azJOOVJoOEhybU5DellvOVJPcm9oaVE3M2crZytnWHRIZ01XN1EzMERxK2tx?=
 =?utf-8?B?K0taTXZtZDk5Z3grRDNkZXozc1FPVmcwKzVVSjZpRm9TU0hDaXUxOEova21P?=
 =?utf-8?B?L3hubjFmRWt4U1UwcUozU21JZ1h1aVc1a2l4enFaOVEvU1hvcEpBWXo0akdH?=
 =?utf-8?B?QktQLzVyTWcyNit2NUZ0cDRPTUFyOFlmZWRvQ3NWcWErSTdOU0tRVGMxVHFP?=
 =?utf-8?B?TXdQdGFMYXZWd2FzRVBEbUM5QUdnZCtrSDRrK24vaGF6VWFldmkwWmRSQm04?=
 =?utf-8?B?QkYyOVdxQ0pBOU9ZeEVIaXA3UkZ3L2J3Nzc1YWloSGdDZFhqRUlQbFNCR2wz?=
 =?utf-8?B?eCtIZWNQb2QvNW9RTTJoK3NMbERkcVBuWVFVMWUycG11My9uaUF6ZlhHMEdw?=
 =?utf-8?B?azNZQ2xMOUNqaUdSUjd0elJxejYwTUFBVU5IbjRiN1hsWjJkaHU5aWdZQmE3?=
 =?utf-8?B?VWF5QnJUN2VENXZNNVVhNmU1OSttYUE2YTBEZUJnTHpwZEpDSUttbDVOSEd1?=
 =?utf-8?B?UFFwT012RWJRSjNvL09FNjdsRGNqWkZndTl5NmpEd0ptKzFpdk5BR29Hb2hk?=
 =?utf-8?B?aXRUcmFNOFdYUTN5ZG9aWXhFREs3bFRVUVUwM1lnZkIrV3ZrYXhQRFZkVy9D?=
 =?utf-8?B?TS9UUE1ncUFQM2dLTmRDNUdRbEtpNkZuMmMrU0swL3I4RUw4cy9NeW1EQkwz?=
 =?utf-8?B?QTVoQmdFV1RvWnBLSHYrNGdwNnFYakdjMjkxVGJmcG1iemxaM2JtNU5Tbllk?=
 =?utf-8?B?ZTVTcExEaE9WeG9HZUFtRXp5N2JuUTAwNWFpQWRIRkp1U1E2VHZ0Yk56N01t?=
 =?utf-8?B?TG5jYTlreE1TbGFNdWo4cTROdTgvaVlQOXVrdnhPRlVPUGYzSUJxcms2VUpT?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b8cca8-e25f-455c-4097-08da91f73809
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 00:07:01.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6xI2RY90yv9lqz3GlaTnX4nEixAnSFfIetjcWtqxmy/AFxu3kGd0uhQLpAXldKkKHTMBdFdFodmyNkjxloQNBPOHJCTIFHMgF0atoENhwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 9/8/2022 4:19 PM, Jarkko Sakkinen wrote:
> On Thu, Sep 08, 2022 at 03:43:06PM -0700, Reinette Chatre wrote:
>> Hi Jarkko and Haitao,
>>
>> On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
>>> From: Haitao Huang <haitao.huang@linux.intel.com>
>>>
>>> For EMODT and EREMOVE ioctl()'s with a large range, kernel
>>> may not finish in one shot and return EAGAIN error code
>>> and count of bytes of EPC pages on that operations are
>>> finished successfully.
>>>
>>> Change the unclobbered_vdso_oversubscribed_remove test
>>> to rerun the ioctl()'s in a loop, updating offset and length
>>> using the byte count returned in each iteration.
>>>
>>> Fixes: 6507cce561b4 ("selftests/sgx: Page removal stress test")
>>
>> Should this patch be moved to the "critical fixes for v6.0" series?
> 
> I think not because it does not risk stability of the
> kernel itself. It's "nice to have" but not mandatory.

ok, thank you for considering it.

...

>>> @@ -453,16 +454,30 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
>>>  	modt_ioc.offset = heap->offset;
>>>  	modt_ioc.length = heap->size;
>>>  	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
>>> -
>>> +	count = 0;
>>>  	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
>>>  	       heap->size);
>>> -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
>>> -	errno_save = ret == -1 ? errno : 0;
>>> +	do {
>>> +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
>>> +
>>> +		errno_save = ret == -1 ? errno : 0;
>>> +		if (errno_save != EAGAIN)
>>> +			break;
>>> +
>>> +		EXPECT_EQ(modt_ioc.result, 0);
>>
>> If this check triggers then there is something seriously wrong and in that case
>> it may also be that this loop may be unable to terminate or the error condition would
>> keep appearing until the loop terminates (which may be many iterations). Considering
>> the severity and risk I do think that ASSERT_EQ() would be more appropriate,
>> similar to how ASSERT_EQ() is used in patch 5/5.
>>
>> Apart from that I think that this looks good.
>>
>> Thank you very much for adding this.
>>
>> Reinette
> 
> Hmm... I could along the lines:
> 
> /*
>  * Get time since Epoch is milliseconds.
>  */
> unsigned long get_time(void)
> {
>     struct timeval start;
> 
>     gettimeofday(&start, NULL);
> 
>     return (unsigneg long)start.tv_sec * 1000L + (unsigned long)start.tv_usec / 1000L;
> }
> 
> and
> 
> #define IOCTL_RETRY_TIMEOUT 100
> 
> In the test function:
> 
>         unsigned long start_time;
> 
>         /* ... */
> 
>         start_time = get_time();
>         do {
>                 EXPECT_LT(get_time() - start_time(), IOCTL_RETRY_TIMEOUT);
> 
>                 /* ... */
>         }
> 
>         /* ... */
> 
> What do you think?

I do think that your proposal can be considered for an additional check in this
test but the way I understand it it does not address my feedback.

In this patch the flow is:

	do {
		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);

		errno_save = ret == -1 ? errno : 0;
		if (errno_save != EAGAIN)
			break;

		EXPECT_EQ(modt_ioc.result, 0);
		...
	} while ...


If this EXPECT_EQ() check fails then it means that errno_save is EAGAIN
and modt_ioc.result != 0. This should never happen because in the kernel
(sgx_enclave_modify_types()) the only time modt_ioc.result can be set is
when the ioctl() returns EFAULT.

In my opinion this check should be changed to:
		ASSERT_EQ(modt_ioc.result, 0);

This is my opinion because this check indicates a kernel bug and I do
not see value in continuing the test after a kernel bug is encountered.
My expectation is that this test is of value to folks modifying
the kernel code.

As for the new check you are proposing - it seems to me that kselftest
with TIMEOUT_DEFAULT already covers this.

Reinette






