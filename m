Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36516E1179
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDMPyt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDMPys (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 11:54:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F67EC2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681401287; x=1712937287;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QiO12O+XVFg0HJeX9GCRULfJZurP2+08fc6dmBezuzw=;
  b=boVSIFIJGoAgru9W1KImtiXpKSdpJIAnAwEzhBAf+f3bKpPubFv3Bity
   HMk0D/dcbiHKHeiyDQhuycI6yQbX9Exo+u7inuG7E+01Xp4PEpVK0ZaZu
   XOfDDe6ipkuWNYU/WMgZQ0u/Nki9rOe5475dzdqKYG+h8p0V4ehvmXfjH
   /fs1L0sgyRWKWuu+3k/5uvxgOPnTd4doLtnmmpoWDNMAaXAuGt1kna38R
   A4u1DGSSIyMQVYT51DCKR5OKjT2FQ/7nHY3AU+UyNPLKfOTokjd4nJJ7S
   VhxhSNwNn/LCKT5E7+zriJFrqfRtfyr10KsYd+Zf61sfeKGStSF3AjJro
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="328361392"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="328361392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 08:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="833191096"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="833191096"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2023 08:53:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 08:53:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 08:53:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 08:53:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 08:53:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4j4I53LB+hl1mnSRjrmidWXczMtDe6/HmpqXoZSsy08G1LzoVTHtyzPVnDhElziVb8vJ8Wwj+yauh5S+qbCI4edtffxLMvEL/QGtcgwtOa8go1ClwqVk29Pc8cvhruiU2kZRvkc2RyCBfPYD5KgPpGQoyCMWMOWTC8TP6h1w+wfKIFk80j5ppD2IMDkD7TRXnggfSwGrvUGRkQIh6ghPmbmcSXbThaQopkM6qemIZRGJ3c5BKhPZNf/2qw20ky3YnQyUNPKGOPbkul2Y+5vdHEvFYr/fWpjvF0V8+TNY5TrUbyd5zk5spI9p+awhzeoiFVkrf4cyK2y7k/dB5OfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuIvCg70YdB6G+v+r7d41H9X6U8wv9f3y+ellRB3tP0=;
 b=SgPvTjGabvnqAWaKmvMKqeq2fSFDYo0NGexGGt1gxPQHyhSQV7w0lYxUNmIbC0YgW9HZeF+i+co8Krm3P2Pu9ST9IiAPdbkPYZMUFQyH/6CnPaw7PxUb3741vjU14jdjCkEJkQ5YIHlqkT0kjAA+BXCpHh666QDc+l++XDqrUvv7JxkunjDfk+RsuakD9hqw68VDPuTHyhFT0Zn9igtPirTzjZPm1hgFzxEGV68IHywtQDUuKLq84lryQHNQIC/1IKGw2yBJ/nb7BbX+IM3vQuksYPFHvPDrUw9hwLIn9jx2sUn38G8DMSxLRFNzEz4HNoOad78xoLxFJWa5H6fhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.43; Thu, 13 Apr
 2023 15:53:50 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 15:53:50 +0000
Message-ID: <753f0eae-527d-c909-2b6e-8c59b788d4e2@intel.com>
Date:   Thu, 13 Apr 2023 08:53:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: resctrl selftest patches
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
References: <eaf96617-2f3e-b573-8990-6e9e6b0cb6fd@intel.com>
 <71b769fd-6cde-0ccc-ca41-c94d4737b596@linuxfoundation.org>
 <168d8f63-3d42-96e4-e8b1-89f92fb8cf36@intel.com>
In-Reply-To: <168d8f63-3d42-96e4-e8b1-89f92fb8cf36@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b56ea73-f923-4746-e6ab-08db3c374646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65HGLILoLkHVARBcQDebq0o8OOdozDWapK5eprpzpzcXkSMJP37sOb+ILSD4m3iNZyltKoM4muZ/mL9FxoNDgo06Vq+Xe9egvD8/GtMx1nRZEjLzkPL6IYsWHWEbBLKgpuit27XHFmVX2t90d4AZQOmxjOxd6FCMYstEM4hRt0l8uwkRGaDhnkawDzf5Z7BjiOMjymxOr0wldO1feZgbhT3q+pEQqnegI5SExX53kWWGd24g86BmTRBu1j2J6di2bTh4T972prKx6zeKFXFDHJlyBIsog6iMF53mIBNjikmEyDxPFV1YIVl+PGXR36SgvcfIBvArvO3EefN55Q7o5qLyqfAYIbkF3WmIjslaoe7LY1+XTBcCz82JiH5h+7VPYJbNkIPsS2jDuFPZpW6ibm+Lf5ryYnTFfI/MpyR717DIdWTYEs19m0SmbJX1tYq2cKq5tgCmj8LUPADWi9ZLNqXVAUHuWFdQVvIGT9DaCLyVeTW6HWkVVltHyqTG/Y8vQ4bJuz0zt3REQO4IKRBFopyNZUHqRekEzd86DNKrZzmADD2A9MSW4H4ajLS+INIk9LxoPM0uBWRsguSWVRkUQbhu6GWK0W0bPQpMYu853VAsofr/bB48bTEJGEbkloLleRssp/lqHu+2IY8c00tkPcpZ9bwOfU9Jg3C7Aw09VelA7vfpLMLGEt4fAJHh/i+b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(31696002)(2616005)(36756003)(31686004)(26005)(53546011)(6512007)(6506007)(186003)(5660300002)(86362001)(107886003)(6486002)(966005)(3480700007)(6666004)(110136005)(316002)(478600001)(54906003)(4326008)(66899021)(66946007)(66556008)(66476007)(41300700001)(82960400001)(8936002)(8676002)(7116003)(44832011)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJvSlFvT1FqVWpsdXVTYmdlRXNGb2tPeGJ2WVQrRER5M1dJeWhNWnh5dndL?=
 =?utf-8?B?bFZzSzliN0xHRllETDNxRXUvcU9CbnJuYzYyQkxuMW5qRCt2UkJvNjZiTHNT?=
 =?utf-8?B?dDdueGh3TmN5UGZZSHpkZ292Z2V3MHBZVmdGSkkrdWRvU1VtN2JCeGdJV3Fw?=
 =?utf-8?B?RWJ2aDg1bU5SOEs5ems1VlBHMElvbVR0WUxaRDE0TFFmVkNHbWhBL3NIWXR6?=
 =?utf-8?B?MHN2MWFRdkR3YmJQL0hRNkFYdjVqR0lHcDVkZFFSU0ZoWC9vZnZzdUhMbjRu?=
 =?utf-8?B?R2xydjhHeklvWnBwU002akdLTW1OQ0JzY1lpMWV5SDdDdFBQL0JWU3ZjeDVR?=
 =?utf-8?B?SWhwRHBlcSswYnlVOVA3V21XZ1hCcU5BNzM4QXhzN29rNnRzcUZiSC9JSU44?=
 =?utf-8?B?RnkrZDF0SGlITHU0SUpadnZLem1naGVUVHpqT08zQlFFNG96Yk9sOWNvSjVL?=
 =?utf-8?B?WmcxNjZrN0RrUmNYQnpTQVIwdVVsbTFWbER0Y0plT1ZyQ1pERVJHQjhSWDRo?=
 =?utf-8?B?Z2xvei9ScGRmTmk1bSszQmx2RitBQllDbkpNZFNNOTZtZjdFSGozZ09kdCtz?=
 =?utf-8?B?NGpqWXBmWHMxd3QrYUZzRjJ2NnQvL3FGanQxREZlLzJFTWtSVjgwOFRxc3BM?=
 =?utf-8?B?bmFHcHJiWmEwYlFmRzNkamhRM0xXaGpNTEQ3cHcxS09QcXlLM21lOWtzV1Ix?=
 =?utf-8?B?VWxMOGVMUHV5WDhqcjVlZDVhSDBqbnpqZkRwMkNGdjFqMnRmNHZ5Ynp1Wms0?=
 =?utf-8?B?bTYvTUZJMGZzV1RBZm5mY1JNa0g2bUo1OVVGRU0zOWtYWThwV0tNSzRURllS?=
 =?utf-8?B?RE5iTSsvMlpzcDFkQUZHL0tjT1g5OExwMzJWS2NuSDVjZGFreHY3aEVKU1Vx?=
 =?utf-8?B?MlVwdEYwWGdNUlRyQWNUK3hac3dlRjVXOHFHYTZxWUpsQjhZNG80RDhHRzBo?=
 =?utf-8?B?QkZFSG05cW1lMDc5c1hmUk5LcXExYTJLS2dYbEdFSnN1KzJaNGR6L2EydG4v?=
 =?utf-8?B?UkxqcFFZaHFHZDdWbkFZVlpZVUxSNjdzNU9pTUI0Q2c1anF4bUR5d0VodFE2?=
 =?utf-8?B?Q1ZKZDhHdWk0SGFsczAwOXRNd0hIcTE3a1N6QjdsNkN2clloVlJ4bTFOeWRV?=
 =?utf-8?B?b3JZcVJJNzF6bFF3c1puR0p0S1IxN1BBdXJoUzhRSmx4YW1WWnMzWDkvSDhZ?=
 =?utf-8?B?OW1pTXpvaGprR3JieTZhTG1xSTd6aFhtcEpEUHRlMDA0UElvNjdiY2F2N1hV?=
 =?utf-8?B?eTNTN1k1SXFUWDhuZm5Fc1hSZ2duM3dsVVkybXY2cW1waEpGMjVYMVVOOWph?=
 =?utf-8?B?QmhOWXcwdS93MlNSN2xIa3h2SmhwQmw0aHIwekU3U0YvaldXaXYrVnl0UGF0?=
 =?utf-8?B?T2dPRTNGdGhsdkc2S2E0NTVaanRsUkdFTXVqMC9yaC93TWlkTjRtbTNGYTlt?=
 =?utf-8?B?cHFtKzNpNXNha2RkWitOS1I5ZlE5dm1PWDNGWXFmSkZVaG5UUGFoUGdnSW9v?=
 =?utf-8?B?Y0lTclltL3kwNnZrN1JSamo1QVlzUkFaR3YxQ056TWFqNUFMaHN6ZlJnSXhz?=
 =?utf-8?B?dC9RZi9Oall2eHhJeHYrVnNEdE9ybXlrQTlaNmFXcHMwbFg1Q0VDMmlxODRI?=
 =?utf-8?B?NTg2SDFPaVluNENLY0xBZG1UWjlWa3c5a2dSamdqcm1EUzBJUWFEZmpLeVFH?=
 =?utf-8?B?WG9Ya1ArMXlxV3dlMG9nYXlKWVJtNWZuQS9lWnVuNFNQQi9PRDJ1elFiNm1k?=
 =?utf-8?B?cWloVy9VMlUzRGN5YWIzWHE2K3lIWDcxZ0pNNHdmUk1qelNtY1Yxais1Uzgy?=
 =?utf-8?B?bS95cVd5YW1DbkFVeHhKaDNEVUQyUVBnM1JWM2lZMWpTUGNsOTc5RnY5WTFB?=
 =?utf-8?B?YVZuVEp3MjYyY2JZQytKT3pvZFVWSkhFZ2Nkbk9RU1BUOHRDOExud0ZrVXFP?=
 =?utf-8?B?eUVvS252QmM0QkIraGlwdkFDRC9JMk1tWjY5WjZ6UjI3bVN6S2dyUEhtaWcx?=
 =?utf-8?B?SjM2UU1NQ2NEeG43S0VxV01lbU9zNE5QOVR1T01naXZPcUkzYTk1OFRpYjNt?=
 =?utf-8?B?RFk5S091ell2d25JR3U5M3BPdThldlhvSmNRUVRvdEJHNy9tRmJubm14dlRv?=
 =?utf-8?B?TE1OSHh5bStzRHBvYWg1Z2pJbW5IenN3Uy9KUi9SL0Y0T3Fzd3Z5K0M5YjY3?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b56ea73-f923-4746-e6ab-08db3c374646
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:53:50.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7Rupbu4I43/s+a20BoqCE22QHRzc4uR+YQ6RZdkmViTKB60miP/l/DGx1lTqnO3Zjq2TTQq6I2SwKBj7Fq3w32O/+4j3aRkV0x0tqXWC6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 4/10/2023 11:39 AM, Reinette Chatre wrote:
> On 4/10/2023 11:25 AM, Shuah Khan wrote:
>> On 4/10/23 10:43, Reinette Chatre wrote:
>>> Hi Shuah and kselftest team,
>>>
>>> There are a couple of resctrl selftest patches that are ready for
>>> inclusion. They have been percolating on the list for a while
>>> without expecting more feedback. All have "Reviewed-by" tags from
>>> at least one reviewer. Could you please consider including them
>>> into the kselftest repo? There is one minor merge conflict between
>>> two of the series for which the snippet below shows resolution.
>>> [PATCH v8 0/6] Some improvements of resctrl selftest
>>> https://lore.kernel.org/lkml/20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com/
>>>
>>> [PATCH v2 0/9] selftests/resctrl: Fixes to error handling logic and cleanups
>>> https://lore.kernel.org/lkml/20230215130605.31583-1-ilpo.jarvinen@linux.intel.com/
>>>
>>
>> I was waiting for another ack from x86, don't see one.
> 
> I see. What are your expectations for resctrl patches to be considered
> ready for inclusion?
> 
>> I just applied them all.
>>
>> v9 patches are now in linux-kselftest next for Linux 6.4
>>
> 
> Thank you very much for picking up Ilpo's series.
> 
> Would you be ok to also pick up Shaopeng and Peter's contributions?
> 
> These are the following (nothing new, just copied from previous email):
> 
> [PATCH v8 0/6] Some improvements of resctrl selftest
> https://lore.kernel.org/lkml/20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com/

Shaopeng just sent a v9 with the only change being that it is rebased
on top of kselftest's next branch. This leaves you with no merge conflicts to
deal with:
https://lore.kernel.org/lkml/20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com/

Discussion surrounding this work completed a few months ago (it was ready before the
resctrl selftest series you merged this week and a couple of the patches also carry
your "Reviewed-by:"). I believe that it it ready for inclusion. Could you please
consider including this work in the kselftest repo?

> 
> [PATCH] selftests/resctrl: Use correct exit code when tests fail
> https://lore.kernel.org/lkml/20230309145757.2280518-1-peternewman@google.com/

This patch is also ready for inclusion and continues to apply cleanly.

Thank you very much

Reinette
