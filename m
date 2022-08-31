Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC93E5A8520
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiHaSLn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiHaSLK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 14:11:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBAE5894;
        Wed, 31 Aug 2022 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661969443; x=1693505443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+P2jGFlhW0U954QbhxPJD7GcQOFMvMwpfEDTKRD3F6k=;
  b=KqJg6XQfJOZNEjgcEHprlzSBEQhiyqHKrUUe+UsbaQfjddEBlRuaemR6
   OSOsb4mwGr8OPNmNFsVd255A0u3lyFiemK0Pwh2wkWDYr+RbryQpIBAei
   zEvRJQizxpfm5RSSqx2Nmv6/bUqOsK/t2gKHxq+ImCm12x0iOfA0A0LsZ
   WXnaoL4+FJV2hW5EFj3A7250RF/fPCzwg6IhWQe6rDmm8f88oAPjTYd46
   7i1ubipichb4XPJIfjXj8NeRrMYEHYEUY4L120iORfXv/gK5/RmEv4lfk
   9fVuIWzkEdOc8zDQpvioVRT474LWCLYY2FfWdCZklNQHkeGkozZJ0mNQu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275260561"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="275260561"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="701447461"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Aug 2022 11:09:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:09:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 11:09:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 11:09:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQNVXMJ3runbvAAPV8tdIVGEOWruABcc/YlDq+8ke/LfBdcxPRMOKqYuEnAeMWR/R4+/GMAlo9n/G+kN7KLxzo0TUHB7/PMcdws+wT0Oye1gwuhUdUfp0269lCOwoBMNID4iyKPjM4lvlmBRt8nedX7zTWSyRnnWNygyL9dM4JZj69fcX6pmnFIj4dxLZoK7nIzF/ZN6jf9EcaF38oE2INxfgKtmF33ewTHxF1LebpjiDQZYshuIXVlIVg3hUofRDhYQsuB25EK6/xUneBlh/9o+YahBPXE6cWIERa/x/UZybN5b7h3e20EBbiH6jA3S3pcJYb/uYjxAXaXGDDQqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpELTAWHkzi+U49E1QuMCNyD/tR+9Si4THdmkaDgk28=;
 b=Zq+4mGXirITmZLrcGTWzVACoGIC9tj+cW1btfvaXJt8Hom0+rq8HvuuEmBGmZ32lK+NHAD4X3/HzqEitA0QqlclDsjaYq10NzOGlZGbKqnprHVxwbw3Rx63W6FG7zkWKv7F9hc2SS7dr4kkl5a3rAl9Zk6JKuissGCALlK/kpHrJgoRnQRwpnysXWRWBX1QIlsikYw8/T9njR/iGV1qTurqtJL5s+Lt2wHiuwFeXOc61Y/zU2YPYUhjtzRLa7bSu0H44Wiqg5SwTTIIWMCmQKas/GkZDCOlooR/wEDsvw95FR4XZMYjGEez1sjdlZ8L2G3W8kyCGanLS4xcYGiS5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 18:09:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 18:09:24 +0000
Message-ID: <c3717761-7b00-db03-117a-0b672c865fa9@intel.com>
Date:   Wed, 31 Aug 2022 11:09:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 5/6] selftests/sgx: retry the ioctls returned with EAGAIN
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
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-6-jarkko@kernel.org>
 <5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com>
 <Yw7IFcnjbfm3Xgqk@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yw7IFcnjbfm3Xgqk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb668ca-43d0-4cc4-43c0-08da8b7bef45
X-MS-TrafficTypeDiagnostic: DM6PR11MB3146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87aqLvb0cZB3daQT14JFXCzSbaTyR9EM5vHkuwp35/5bp9W9WeDiVwCdyTxzyJltNdpUfTsc/BEkKUd64m3FDs6xCku1fa/mePgUMzgg1qUpovL+HwVWHvuf0x/TRRbk3Fl/1du4HgFbETTO8IVn/VPWhaLZaN3etCybIAcctGVRGrglA0mmJyRw4TlTE7Wu0074+16N0wZ7hjBQLozGQhRuMmsAhKo8nqPHlbAvvC5ZJs1T1o1tvZK5cKhrDl1cHRi7DCJizRoHTdrgkpzk+/HyjeQz4cm5+xwlY5lrwpi9Tyjm44gjMVnK429lgWp4B1qup+oj9vOOpX1CwoshUtbMTjRmFsNTCWeTnAmrbUPby6Pm0hSNRKcyAwSNMdVqbTXbRq9jYhIzHQ1WWVAz7qsYuxvFsujEiOhnfQNYBxcJMW5DKFtdkWK0NZQMopSlUEzJo6wKxAS3DXls2Om4gE091e14EnfWgNX2CBJXN64ltLe3FtHoRO0UxL8AIZW7l43R0oa5DKOkQG9ep12KHS2kxb2hysnzaDKVLj4H/PXNiOE77j6EWPoCj5l6DmvDgpl5KbLLtaAlFG5DhLNM8216pqbwe2uFpZDQg1OR8ZOLK4qnxZvap44ABLUMBn8ZYFvg7MZQ3IpN8DTgtz/b8Vv7vWS5LQTLFzCbCY2BcfI/VBfQzOQy6dcEeppp597LSLGTQjaR1odw8YCCTgLzy9EX8APLtiPx3NcRROvQflf0gHBj1Gck9/8oY4K5htAJBmlIbMankxwoI5ws5nZhaK8jP4m5k2zxMgZ8mA/mlco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(4744005)(8936002)(54906003)(41300700001)(6486002)(6666004)(38100700002)(6916009)(44832011)(6506007)(31686004)(66946007)(66556008)(4326008)(8676002)(316002)(66476007)(36756003)(5660300002)(26005)(6512007)(2906002)(2616005)(53546011)(186003)(83380400001)(478600001)(86362001)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09MY1hIVUJ5NFViTjhjLzBQSitadUwyNXo1UmhYY01sN0pNcGUzbWRick1G?=
 =?utf-8?B?TEgwMmNaSFdtYUJmME04N2ROWS9VSTRVcUl6SVJjeXdQRm9Ja3cvM0pSUkRL?=
 =?utf-8?B?bFZLa2oyZzIzbDJGaG9KbE5zaUhOSzM5Nmo4cmtWZlBFYmdhVENORWcwRTlF?=
 =?utf-8?B?VE1hU3QyM3E3UlZvZHdEMHdyUjhwM0QwblZhQ3lacjUvR3dGVitzaFBlL0ww?=
 =?utf-8?B?dFkwWnlyb2NxeXd4aExTQ0g5aEx1NTFRcm9MZ2hPNzZPcjJ3RjZDVE5MNmVS?=
 =?utf-8?B?QWgzUXdGbncwK1dBbnl6SVlwWE1pejZoOW1TLzhVZU0vVXJlT3p5Szlxc2Fm?=
 =?utf-8?B?UU5panBka1E5WE9weDFSLzBaU3k4S3FPUW9qRm9WREFEeWo0YjRZNmxjclE3?=
 =?utf-8?B?SW9PQ2crMkhzOW1iZExKZGY5YkFrZWhPLyswVHRTWkFrdTVLTE4rL3JxR2g2?=
 =?utf-8?B?eU5BYXJiY2cyRngxSkU0bUhDM2NYWCtDU1d2N1Y4TlhvdlFYcFlCNlhrTFpl?=
 =?utf-8?B?Nlo0OXhEd2RmbWNVQTIyOWprK0xwVlhDVGxuZ0llS3FVeUljQk9rNUZJQVFw?=
 =?utf-8?B?U1hIMGxudmhlV1dOWW1OdHBUd1VBUVBPSUx5RFJ3WVhPVlc5TWM4cnV5LzB5?=
 =?utf-8?B?QWwvcWNBQW91NzQyQTV1QWRvUzdMQ3prdEFSWGhSWXNlb2lMdUx6Q3lUdHk4?=
 =?utf-8?B?N0tpRHFudGJhSlQ1WmZnWFhSd1RyMXVTM0hnSUZ1R0UvT2Q4TEZCaVBDaFQ1?=
 =?utf-8?B?NGhUVHFmUUREN0YxL2RndE54NWxPZ3RMMGFDd1I2NDBkWTlLM3pwTnpMODZr?=
 =?utf-8?B?NXZCYUN0VGVKWW1SakxsMWg4aUJWeC8vYUpFTmtKanlNMXhub0ZPKzk0RUVD?=
 =?utf-8?B?QmsxdzJRRHlGVnZHb2dNaU9GN3IwN2FLUXpHQTU3dGNDanFBTTB5YTh0eFFZ?=
 =?utf-8?B?RFNNMnNZWmI0WjREdkdyNGhPVXRXb3RSSzNVdVBrM1o3bHJnOHpzdlphc3Rp?=
 =?utf-8?B?TkRkUWV5YUJHMTR1TmtjbkVCa3VsZ0RpNmx1VE1GL3crUDdWR0R4L2JTdUhM?=
 =?utf-8?B?U2I3c2wzd0FHQlB6WVJ1dUg5VHJRQ09lNFU3eXlrNzNwdVp2NHdadElmTE5Z?=
 =?utf-8?B?QlNoNHdIK2daa2NxamdOR0U3cnQ3dTBYMDEyUFoyQnN1dUdoeXZRL0dkZUJ3?=
 =?utf-8?B?dDZvNll3anZsVkJ0MTkwTjN2SDhzQmZyNDkvVHVZaUJrSng2NGZERmFoY1RL?=
 =?utf-8?B?UzJwbXFqY3BQbmJ4QzNzeG9FQUUrQ3g2bXRUUTVyeE5xUVNva3FVNkRET3VI?=
 =?utf-8?B?SE9nbmgwTjlyREhVVFhDZFIvK2U4bktDSFJWMnNYWWl3VmsxbVBOdkdweTQ5?=
 =?utf-8?B?K2RxMG5sZFQxM3BZS3h0RkRqSnE4c2tFZC93akxMeHlNNlhzYjVkSEhGeDEy?=
 =?utf-8?B?U3FiRUtGbGtnSTVIK1pLWDdxNzlRTkNrWkhuNEU0eWRGekNIV2M1RVBjUmlu?=
 =?utf-8?B?Sk5yWHBxMXZZUDRKTVNZRUJzcnRyc0tLMnFzSTBkKy96WE1Zc05wN0ZhaWpw?=
 =?utf-8?B?M3ZnaVgrb1k3OHpWZU9wc3E2ZXlLSldYUzRWWUlHb3NzMWRRV2pZZ3JtRmpx?=
 =?utf-8?B?bHdzVmNxcG52MFBGWEZMN1F6TlVFSmRyNlBjKzVxUmovYVdlTURIVEVvVnZk?=
 =?utf-8?B?YzBYVU9Ib1ZNanB2dlB3MjE0ektOZzMrZU40by9mbkhPbVkvSURVZ000RTM1?=
 =?utf-8?B?WmhOUTlVQjdCM2lJL1lFK3NEd0ZNUzBBN0E1ZXpGdzNtUE00KzRHdTJsMlNW?=
 =?utf-8?B?c1RWMU9yaVF6N09oRXd6MCsvV3FFRmxrZEZJT2pjV3c4YmNxL2VFSlIyaklE?=
 =?utf-8?B?aG4vQTBrN2VFdUZ5ajlPY1NFNmY5UUh0YVN3bDJuZzZmVlFCamlJNFZHMjIy?=
 =?utf-8?B?SXdsQUFwWlBTYXV2YXBNRWFzWWQrVE45ZS8zMFQ1ZmtqZTM2NHpoUWVwTDdw?=
 =?utf-8?B?YXpKVkRSWlpTUWpQL3lSdmhDTVkreEUvbzVFRG9jaDlNMDhMM0p2RldxWXJl?=
 =?utf-8?B?cFhoSXhEZ2RLWUxCVUpMZVNCclhGSW9La1ZBS3Y5UllFSUkrZytBWHRoTVh4?=
 =?utf-8?B?RnBRMnJreFAyeGRoanRlOHlsZHJlazdMQUtRSmE5M2MxNlk5K1dyck9UKzIv?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb668ca-43d0-4cc4-43c0-08da8b7bef45
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:09:23.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXaveEaGG5aEX1TeizzJ6jiSy48Yl2qAqF8OlbhGu+UiE4LONSj5LFjlKzruFNKibM1xZqf0oc7okUta2PoIJ5NarwMF180y6P2KtSbp7Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/30/2022 7:31 PM, Jarkko Sakkinen wrote:
> On Tue, Aug 30, 2022 at 03:56:29PM -0700, Reinette Chatre wrote:
>> Hi Haitao and Jarkko,
>>
>>
>> selftests/sgx: Retry the ioctl()s returned with EAGAIN
>>
>>
>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
>>> From: Haitao Huang <haitao.huang@linux.intel.com>
>>>
>>> For EMODT and EREMOVE ioctls with a large range, kernel
>>
>> ioctl()s?
> 
> Ioctl is common enough to be considered as noun and is
> widely phrased like that in commit messages. I don't
> see any added clarity.

ok. I was asked to make this change in the SGX2 patches and
thought that I should propagate this advice :)

>>> +			modt_ioc.count = 0;
>>> +		} else
>>> +			break;
>>
>> Watch out for unbalanced braces (also later in patch). This causes
>> checkpatch.pl noise.
> 
> Again. I did run checkpatch to all of these. Will revisit.

It looks like I see it because I use "checkpatch.pl --strict".

Reinette
