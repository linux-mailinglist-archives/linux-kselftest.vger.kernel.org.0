Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FBA75EC4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 09:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGXHM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGXHM5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 03:12:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21683195;
        Mon, 24 Jul 2023 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690182756; x=1721718756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wh5xne+i23zqoixmrNS3u6IpDdsFdo4YLWmcVo1SHmQ=;
  b=Utcemurc8B1Ry061EGXCCBGngdn55jjIDi0RMS8y5xmzmCOYs6RLY7I8
   o2GFiYmQlTqHEqIYszzD6gzQm7gitX7qZYlHuu5cUn0zZnNQ4ZuJ8GWbb
   USrhkdls5wIDcb+61OBXVBDy9MS4JHC3g9gkWOT9JVRUWTiA91AKhvPZg
   WX1n6ey8HB0I3OmXzZUY8SNiOADjnenP+fw9tz0dNTebxiXBldPU4SLqm
   ox7pG2CwDefgThixAHTXwUtTck09ZB/RpP7LX/qp4wtkI1q5NWa8WF+an
   0io3qS7htDtayJR4iSlYQaTeaFVP5+/qbV+FMZgIYFrEbJpsMkMihu2eo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364828925"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364828925"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 00:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="702761289"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="702761289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2023 00:12:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 00:12:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 00:12:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 00:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lED0EwqMqFwkcqEYGXT7gAPe6twblLBvzy8oT+JBtbxzy4rThTjs9nX+fP+PXpru20uu1i3Y+YFz3mDa9GpjdKF9iZX+eGwVVfDkEEAFdeibepbtUR4morYZ+DSAcSigDI9s9whKcOeF4GFO4fNF14NdchBF7WEcwsZF52Ce7Wu6ydVC9ePmtB0xfGq1J1MmQO1liM3xPFxc7MHtRkYDBnG+DfjU62GsTn8BeFUdWXLGyEyqBMowclJCG8kANnWewfn1/Zcg8PKFTFNVzyASgQvLM3YEjT3+kP4pkeq52NqeE2SfhmZAGYMDK4Z9OpuJjsQYIaGbtPmqdoW5Ndafwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA+YufPepZgBGHb8daMuRBgiiZICkLL5+ZW4oEHSD/k=;
 b=EAPHrKoY2bCSZxU5l5K1WI/ngD2ApxZ9HebdEgK2HxQMhmYjK3ZYAfl+JdxiYIKdt5fkhTz2mB7Tunrw4SLKRFKJ9nksPubfEXBow0/3X34Ev7UBsPhruf1oLPQ2iiV0BJEY4u6ooynJmytWnlA01pa0gncWGzQR9odm/0/Ex6gnU7OdrNQEuYhEBSfxqpAupZEAKFzejNvcXAStHwJ0bMfEoZj2J76jymYg7c/Iyn3JdLUFxPpSk2CYzRSjWtuo1PtTvMN2U8x11/4Hb4mnvAb4FrRYq9pfxCMLOHEQ66BAAPinvLSCb17GcS3JiV0haKwxgWOzh5HD1SrM5/5dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY8PR11MB7732.namprd11.prod.outlook.com (2603:10b6:930:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 07:12:33 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 07:12:32 +0000
Message-ID: <903b5c02-7d7b-11c7-167b-c4f0f3862ae0@intel.com>
Date:   Mon, 24 Jul 2023 09:12:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/19] selftests/resctrl: Refactor remount_resctrl(bool
 mum_resctrlfs) to mount_resctrl()
Content-Language: pl
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-8-ilpo.jarvinen@linux.intel.com>
 <09605219-19db-ba2d-aaad-9e279543f461@intel.com>
 <2c1f4d5f-7d6f-1178-7ec4-7f8b862b26e9@linux.intel.com>
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
In-Reply-To: <2c1f4d5f-7d6f-1178-7ec4-7f8b862b26e9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::16) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY8PR11MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7340c1-1924-4f63-28d0-08db8c15596c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDEBPZB3LFoAoWLXpK47IEwEYtZuI+8bs1khuld1zSlqD0/X3IBdWNLxvGT3mok6BogTmuvYn7jUB8NtiwzNk3ereDw0ewyIzqx98g4Azipv8IoJtCss3HZoSGCzSQExCNx7ppwQSVy+gZa5aXneAu8SM16q08DYbDbZA7LQCOC0QsMfM9RDM/P1V+aNfILEvAh/LQ05fsOopgT8q8CIuD4HEzkPgQI4MGusP00jqZHrwwCQy3f4qjTliF6kSqjjp4Mb1S963LB5f/83sZb1NOaRmfjJnrK1GQb6clegq67lJYmBBCpVImhTm5w52WRf/YRGKDJbEofphY2xrxcbRv1wTkpSidjlvUiRRDnMlo3ZyytWC9R7mWnDXqNdSwq1uatucFqs6cfVFIVod5147pDvZ0N5xfOpxPSEEN1mqhb2Cd64RIZr+t+Pb8J1IiPxKe31KZ66W3wBRKI9zSqBB14IgcSl9k6BkIaZq7Qj7365g/aATb7iDCWOH4HaF/8UmHo106fVS7EK+DVdbTXe7Cm4WapzEvrjlKZ/dGtXOZ5WJoQ1y58CzIq7OO5yVMxX6hLiZngwNygVLHZYIW4A9cOt0imkWfwwdTirBUyqkxTeYiiC9Y8EPK0jFk9qSj3HzYNpFBcZYnSOJBE2CoIZAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(36756003)(5660300002)(53546011)(6506007)(26005)(186003)(316002)(6636002)(4326008)(66476007)(66946007)(66556008)(41300700001)(31686004)(6486002)(66574015)(2616005)(2906002)(6512007)(6666004)(54906003)(31696002)(110136005)(478600001)(8676002)(8936002)(83380400001)(82960400001)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxEa25obyt4VklwSVZVaFhmalhsOU40dzNJVzNZVEtoT3J0VGU3ZFFmZU5R?=
 =?utf-8?B?cnZ2cWdJc3d3K2xFSXFIdE5oTkJ4WWFVdDBLZDMrRldsaGZEd09FNDdjYWZn?=
 =?utf-8?B?VGNGTHJ0N25zTE0rZ3B0L3pHNWZWQVZ3MnVvNlNJWlFtRjdlbWc3ZXBjTHJY?=
 =?utf-8?B?cDhwSTZ1elVkVVNIbGdZUUViSUtOeitOME9pSjRsMWZ5amRvb0d1MnFQTW1V?=
 =?utf-8?B?MUE3TmtsQlBId2dTWkFhZEUydSt6TEFUai9XK2oyNHFtdXg5REdxZS9jN29i?=
 =?utf-8?B?dGVUU1FmQjlwcmV5RmVmWXhXUDllV3l5MjdZMmFYOWQrdWRHLzV3ek0zYnZZ?=
 =?utf-8?B?MEk1V1dKMzJFZ1hza2tkaTUzbnhrdzJNREUyd1I0MFdTSzJkRE9hSkNQVWN6?=
 =?utf-8?B?emp1QURiVHR6MFAyY3RaTEhlWlhQTmc2Q2c5YWJERmMzb3hOdFRWUnIwRndQ?=
 =?utf-8?B?RElsQ3pCMHN1UWN3YTRDQ2s4TVdrS2kxdVV5bSsxcjNIMkdIVkdwL3dPaWxw?=
 =?utf-8?B?Z1dxRTR2UGwxYm9yM2ZwSUtKbWZEeFgyV2lMekxHc1pwUVkvQVVUQjV2eGFO?=
 =?utf-8?B?Wkx0ZGdrdXNaRnpscy9IWnNIZjBETHhIWG5vUzlCcHRqUVE5Zm5YTEZsNVQy?=
 =?utf-8?B?Y2ZVM0FKbW04dnUrZTJMTEo1aHdZR1RuOXVHM3JuUjdQNzZPT2JOWUx0WTlw?=
 =?utf-8?B?eEdSQTAzaHdCZnRITjFxeXVobGpHcDVIRjhsQk4weDY5a2RseEZTeU1nT2ZG?=
 =?utf-8?B?eXlzRzVMdXNOYnBuMldjSWk4em1pVUtNTzBKTHoxbWRXdGZMTmdtVXhEZStm?=
 =?utf-8?B?b080MHl2d1VoR1dMa00rYjZVSlFkQ2RJcWkvaWhtaFY2VHdnd1haeWV1enVE?=
 =?utf-8?B?S0ErdWN2MVZVOW1JT0VNUTBUZ0dKWkg5T0E1ZzJWRlRUU0FWM1oyTWNFL2V2?=
 =?utf-8?B?VC9UNjlGWG5QOFp5STZDaCtneThyYTdnR3hCMjVWcWVVcENucm9uVSs0ZlhU?=
 =?utf-8?B?NDB6Z2VKUHdXWEFCR3o3eVhNbjFGNHc1OXp4UEFNbEIzN1JjWGRHNW5mVU90?=
 =?utf-8?B?TVNlTjFmVGZubGJHQ01FZWNlQTZZZHZiSHluUjdKNmhCVjV0RnlvTzYwMTM0?=
 =?utf-8?B?S1ozK2F6UzZXaW4vZmRGNzN2SEZnTjZ6WHE1UWFFbGFVNzJaUTZUMWRSUXh1?=
 =?utf-8?B?TWZJMEErWUx5ZlBwRGJVenN0N0NVRGJIOWtuV2wxSGVjWlBpUjZ6TWZPRTFJ?=
 =?utf-8?B?QzhlR1NQZHMyTm4xb0NOL1ViS3hob2FydUlhRDR0UE4rUng3REhRWkxNN3RZ?=
 =?utf-8?B?ZGZLL1FmQS84ZGhTZFhuQU9vNWZ4MFpBc2xBd0IvU3hNSmhiZkxJQ0ViUzZX?=
 =?utf-8?B?aUZwTXFyQjRMYjFJS3lpN25Sc3E3T1N1aTZuWjhMYnR0NTV6UWgyN1Z3a1lU?=
 =?utf-8?B?WlRIOTRSVC9Ja3VmZ0FBbUI0ZkRlaWM3UENFWERCaytVd1JSamxTWFJGeDk4?=
 =?utf-8?B?R1J2K25nY250SmtLbEFOTzBSYU50Vk5nc2YwMU1FdEE2TVNJY1NOQlVZS2w4?=
 =?utf-8?B?bjNhdkN6OXZyWU9CUFZoWE94bytoU1MzZmxRWUFicm9OMkhDZENFUXFOeWZt?=
 =?utf-8?B?a1AxdU12VU1MNUtIeFUrYkhnSTA2eDYvWm5KVHRzd2FJVzUxdWE4KzFEWUhu?=
 =?utf-8?B?NndZUlVaZXZWME5GVlhGTnJLVWVIVzRUcDJmaWJvSlYwZFU2K2w0Uzc2QWlh?=
 =?utf-8?B?SEFkckdKMUpMcG5KbGk3d3ZGeEpjZlZKNUo3TmdKcTNZMDdxeldzRDh4QlJU?=
 =?utf-8?B?VkN2azhJZHdMODZkV1U2NkcyZWVDSFp1eU1KS1FMdG1Ramc2M0laR0pRK1Vx?=
 =?utf-8?B?aFFmWjhFaXQzSlgrY1Z2Zm1qL0lZV25NMTVVeXFXb2l1djB4eWo5djNGTUpG?=
 =?utf-8?B?bUNBQjhNczVscHU2KzJTMyt0c0F2elFXVmJvRGNaTWtxcXR4amJyRHAwL1dF?=
 =?utf-8?B?czlOSmI3ZFoxRmpRSWVLcXBmNjZ3eUJ4LzBGeWdwUjRlMlBuV25MM0kvR2xR?=
 =?utf-8?B?aEdHMWtDQ1RYMFZrcDEya3p0bDNDZURVZTNZaENzZVhna2FGc1V2VU5nTEg0?=
 =?utf-8?B?MDQ3YmdkOWkxMTJ3ZUtNTlhhRkxvTExGc09zeDZQR0JVYkhjRDlkaVR2SEV0?=
 =?utf-8?Q?+U+mC3qFBkAZthNUwP4oFx4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7340c1-1924-4f63-28d0-08db8c15596c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:12:32.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdFuJKbnszvqM1CeafWXUyCUpWhEWiZo7GVGDAMqczI1ZyHqb+HsGzgBiSLnpOaN6UsgQgWUfSNAGv+dQYg5alunHeZ7bTF9xvN/RkI7cD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7732
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

On 14.07.2023 13:03, Ilpo Järvinen wrote:
> On Thu, 13 Jul 2023, Reinette Chatre wrote:
>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
>>> -int remount_resctrlfs(bool mum_resctrlfs)
>>> +int mount_resctrlfs(void)
>>>  {
>>> -	char mountpoint[256];
>>>  	int ret;
>>>  
>>> -	ret = find_resctrl_mount(mountpoint);
>>> -	if (ret)
>>> -		strcpy(mountpoint, RESCTRL_PATH);
>>> -
>>> -	if (!ret && mum_resctrlfs && umount(mountpoint))
>>> -		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
>>> -
>>> -	if (!ret && !mum_resctrlfs)
>>> -		return 0;
>>> +	ret = find_resctrl_mount(NULL);
>>> +	if (!ret)
>>> +		return -1;
>>
>> This treats "ret == 0" as a failure. What about -ENXIO? It seems to
>> me that only "ret == -ENOENT" is "success".
> 
> Yes, it's a good catch.
> 

I had an idea about a small redesign of find_resctrl_mount
return values so it is easier to see what the function tries
to accomplish.

When there is an error (-ENXIO for example) it could 
return the negative error value. When no mount is found
it could return a zero (instead of the -ENOENT error code).
Finally when a mount point was found it could return a positive
value (for example return 1). This way errors could be 
separate from regular return values and in my opinion the
function logic would be more transparent.

What do you think about it?

Kind regards
Maciej Wieczór-Retman

