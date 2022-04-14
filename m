Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DCB50194D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiDNQ7x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiDNQ5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 12:57:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED61456E0;
        Thu, 14 Apr 2022 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649953649; x=1681489649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KaCyqeoWauqoGX9FGkcO6yjVPaj3bCqpPQt2gFDaRq0=;
  b=Sc6mEPKedIwSR7kTMJy9Q9eowSI1VL2RYTNtezTrZIuRwPkQYEvI21aA
   oyP4XQixrzVV7M7vnOq+41ZtapeJy05BTS4UtoQHoZIKl35rClM0ezQzQ
   LNDpyzZqmrspwp2dmbCZUzOOKYHeSvOEjfm6HoaMHDck7ekgMYKBvNp5s
   9uutWNWk+GhtmAg4BrOfCqXQ+d4qGU7FPiCQ8XvEeJUQU7buoTS6vhAim
   8TYNiOp+oqTgTUKrrAt804cSpT/Jw79rFceFHczNr9Nl6ShPXTBNDqNBP
   b7XIlN16B7WgbcikCqkiTYqGkmTcKY2YEamuyzm+zWy3Vt/Cr80m2EtEM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="244855769"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="244855769"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="803188831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2022 09:27:28 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:27:28 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:27:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 09:27:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 09:27:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0Wb6DDcNSEvgxb2AwbwF5iAtyY873OvhMrwX7wufbZN49TdjmsueroAE+lDOWDxhuskFiZaSbB/03rwXZGdLOdkNZDOpXYDecbMqN4I9UmTnejNr+MUKIXyJstAcYiwB/KRsj0VZZyiynySFdPKu1eIvyLARmnKH1rUFY66ZYs//41Hw0/bxazOpQSaOkfXwVfC0NhL3qMEZNXbZ3FALVfJFGijTUXdyj6i0CbIW0f+dGsUs9Qj03XGX9xt2m15+f2ml51AGcxXkeb3dEIcC2pUgluAaHS0TG1YpUwqs0cFj6/+TSWZ6L1d6R08uUvTaAZ+syX8Bna2Ucs0HGpHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld2nFeAdJPB3lMRS9uhAg2PbFf3Pa80u0Pfu1rnR4Vw=;
 b=EVVjRQbtzNzHZSv9GqWJaNGc/zRpCZzJL2duAop/RgtO0ycR2BlFsmrVXMzGQrLCn/BhLbDOIIypYiJxiVZpPWnjsH3HD/n0L9ozs1HhX7whTOfoPfk6t6b7R+sxn4PqV9NnIevVHV7xql+H9yDcir+FU1GB9YJgNPOkgiEXwfv7FAmQnF2H0eYEWyDUVp2NCit4gFXEukMTZZUeKl2Fz72oG2YKb8wlmmTXOdRQEPDU6XdO4WOMQOFgb1mr3G37ZzqA/cqSk0veiYjQbBH259F/Icl5kB/1YIjSxE2VUhKWG+xKT+9vvXYXFXzCay31KtXEqMX1FInJj9SAOQ+oRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4044.namprd11.prod.outlook.com (2603:10b6:5:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 16:27:25 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:27:25 +0000
Message-ID: <9664ee1d-ce4f-11b5-2623-456cde0baa0f@intel.com>
Date:   Thu, 14 Apr 2022 09:27:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 11/31] x86/sgx: Keep record of SGX page type
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <vijay.dhanraj@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <9978af37f51fa45c8878a3c05ceaf44f35806bb8.1649878359.git.reinette.chatre@intel.com>
 <7a24b43f4d3d568ccd61117df4a3f6ec25ae1941.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7a24b43f4d3d568ccd61117df4a3f6ec25ae1941.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26d164ba-d65b-4baa-ac47-08da1e33a87c
X-MS-TrafficTypeDiagnostic: DM6PR11MB4044:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB40440C09466334FC839ACEDAF8EF9@DM6PR11MB4044.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lciD2peI/EzZvKvig0XeiOL04maLebwmiosqkM1p0UGhJIY8ucLAeFEzmyustwfD2iaVjpKdQVNW/NdodxLY3fK32tvjctp6XghToxbJX/EbcBsTT4FDvf49VU6NhTcA3KcYQXYrSv0bAWBJvQ0Rm9B7WY1TbyBgdf0afN/8RVpV7nUXxjg2S9ZYKvkQWvN+b4+N1n70/Hq/9f7Iqsu9z+r16hkZmuQR1DHxBg+L+bDgLU6tJDy2JXcaiqha6jJvwOrJEIKYJz1AvvUEalxWVDIaXKY8akiJPyGWKvG4RV/2qiCqEbaQwOimN9SG9DJAyTX4JfBeOwGuVWFtgasfNYANeMJmPr1u74a95Mnyv7+rTp/SJQG+yflWLG3lXfgtB5fOzG7oJg1+qiDcNEfF3UTawNMditd4UXKsPnbZhaPk6D09rgD06dJZGfAK0PaqZYdWcxp2D8nAhyCgyv0Lgrkh/34DQbmqBkF983NXmyEBS07o9tgaIZqDvpDl1oXD5Db9k8waf0ZiyImsRgS879bAWqhfGfQHCBEo1h+YhSv65SdqKL0slhfdwWOBjSJcNCbs6w5WdoC/k83IZBxRzVR0Pv9OYKzkE4A2CREnDnecDPazt+9XTKV/ZUA3GS1sWXY/8GplfJGygrw9tNCJbQeXP4yqrbC3taRZaG+A7XP3Z2rS2ljBhXjTFujNDNp3jVvuYkWVkPIihP5/duOnO+qxXHUHaFIjvQAliZxRCgLRPM3mYc+lms75dtEC3IM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(8676002)(2906002)(86362001)(8936002)(921005)(66476007)(66556008)(2616005)(6486002)(508600001)(6666004)(82960400001)(4326008)(38100700002)(316002)(53546011)(6506007)(44832011)(6512007)(26005)(186003)(83380400001)(31696002)(7416002)(5660300002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUpVMkFMcGpCQ1BGVFg0MHJyOWprSmg4R05qZHNCNy9rOUxlNzhCeEZaQk92?=
 =?utf-8?B?cU5GdVViWFlUcDFJRldIdzlQTmNrNlVBZXhENEZtV0RrbjlFdmh1WHFRM1NN?=
 =?utf-8?B?ZVFVTnJYdkNRZTIrbTJXd0hiM1FsblhEaEJZbStwb1RxTURDN1ZvRU52UDUx?=
 =?utf-8?B?ZHI4SDhrTkxxUXhRKzBqbWk2V0NtVUJhMkFJT1ZHcWdPSFZkRDY0Ui9GeXBO?=
 =?utf-8?B?Qlc1N2IrWXdlOXR6UmpsMVM3OTR0bmsvTDUzWitPZkFIRFJ3OVpHWFdnblBI?=
 =?utf-8?B?ZmhZRmhiSG1Mam50NEFzQjhod2F6RHg1STBEYTEyUUtncHZPU1dEczM4cXhE?=
 =?utf-8?B?MnVtZWVTdi9DZzZoRHNxYzZkRzZJdXlYRjlpRURPMHhOZU8zSTZnNlA2SFB5?=
 =?utf-8?B?bzhvUHpyK2FGRGxlNzdCTEtXeVU3NExaQ0ZPMVMwY0RtdlZlY0VkNHord2VQ?=
 =?utf-8?B?U3doa2phai9hb1F5QmRqVUQ1eW1EMS9McUM0MzMwajhSZEFYZklzdk55Mm9B?=
 =?utf-8?B?SEROZCtYcVk1VG1MK2NodmF4NXVPSVF1dzBVeStUbkdqSi9VN3F1aVNaOU5h?=
 =?utf-8?B?UXd4R1huU3lvVHl0WWtOampCWG5uL2xaOU5xTVRrb0RRN1V3T3V6eXVtNTRI?=
 =?utf-8?B?TXY4RDNoNDgwRDkxVGxYaEMxbGYrU1MvTzVncUErNkdiMGpvS1hPZXZBKzF1?=
 =?utf-8?B?QlY3ejdHSGdDMVV4dnhwY085cUtleDBiU0EyOVNyWHVnZWw3eHhsMnQvRjh3?=
 =?utf-8?B?cE80TkhUSVRzQTBqeUNXRVRWdCtCSllmWGRxbTNualQrbkdWQlpvTDUraXN3?=
 =?utf-8?B?Y0tvUFJtRXVmUTN2d2xyS1lCZXV4STZPZ2J5QmVVbXplYUNvUmQ2ZEhFVy9o?=
 =?utf-8?B?QStOaTJWNEpocFFpQUk1a2J0SWdGdGlXeUp6TzhWUDlWSjhGMXFPdWlDWE1Z?=
 =?utf-8?B?dE1oWDJWWFYyNmtCMTVNMVdxeFVTYm04My9WR2xmYXdzN3NFbWZPL0lZa3RR?=
 =?utf-8?B?Ykg2MkdKY0RKOE5FWm9pSWVROGduUzZ6K0paQXhVWW1LNjhlb0k0UHlyeUdv?=
 =?utf-8?B?WDlha09BTFBuUENPcXJHQWRlNXN1aHQvWXVFemtGUEdqNVBoQXI1YWtZYzVt?=
 =?utf-8?B?ZDBoYWNzWm15YURxUGszZnphbUFJcjFKWEZhN3FiS0xMb01LK3ZHWmVHODAv?=
 =?utf-8?B?YmpzbHBqa29kR25jMDd2L0dBSng1Y0NaVFpRV2F5a09GbnFHZjI1UFIzSzVK?=
 =?utf-8?B?M3BSc29SV0tsL2RoRFhjTjFLcU9YeXk5Tk5KaFJsY3Y2V3J3OGZJNHk0T01Z?=
 =?utf-8?B?SGgxT3p2MDhUSkg3a2tIRU4rb2pCSDNEVlRSN0RDVVdVTkhZZGpjdzllNzRC?=
 =?utf-8?B?aEljeFM1Z2REQXVZL1I1NExzSjlzRTBjcmdkT3FkOFhrNFdoUURDTjlYVFcr?=
 =?utf-8?B?LzNsVEtFNEMzQ3pXMmNLSDJrVkpqZlBjcEdaeUxhYk9MZU5ZcXovY3lGY01y?=
 =?utf-8?B?ZHRYWmpCeldvZ0hld2V4cnU4dXh0aWM4elQ3NlJSV0VRSGMvci8wNXlENk5H?=
 =?utf-8?B?TFBmUXJ0UDArNmxYR0R4dUFDU3RoZDV6MkNiVFBIdTlodWNETHBmaDhTYjJQ?=
 =?utf-8?B?RXJ6MDdnbDhzRS8rYVB0eEsraWQxRlc4dGczb2tJVmU4b0tGYnREeUNBV0h5?=
 =?utf-8?B?b0QwdjN4OHAyT2IvS1hGMms5RHF2VnROV29Qb0FxSHMvWk9zZloxc3ZBTDZX?=
 =?utf-8?B?UHY5Yi9lNmMyUTFINjVtcUVQN0p0QWZyZWRWUVlHQ09BWXVZNzdFQkpwNTFt?=
 =?utf-8?B?N1VFc0hKVnl5TjlxWGNDdk5yby9BUWloaWsvMlZVQnFBaGMwMW1DQkY5SW9n?=
 =?utf-8?B?MmJrQzIreElkQ1pYMmk0TDlSZjhSbnlqTUIyMmRIMUZWYTBRczFNL0grZm8y?=
 =?utf-8?B?UEVOdUI5Y1pMbzl0dHpqVVRoTjJRZHZuRFRCRFRNR241YmZLVXBsT0U5Nnhy?=
 =?utf-8?B?L2V1WkZjd3ZXdWRuMWQrY3VUK1BkZDc1cTYxbHZzVzlvY2dTUFVVZkRvbDNi?=
 =?utf-8?B?MGxsdW0yeHMvVyttZjdIL1pQbFZqNG9WcmxDQUJyZWlnRlZaZW8xai84TG5X?=
 =?utf-8?B?MUhsTE5yNy85bXo4cFVxekFlQ21WU0JxZXJ1TXhLUVJFNkh0UE15ODAySXM4?=
 =?utf-8?B?UGFzWGd4dVpUZ2F1SEhnRHladFBnMDBDYTBZOHJ4cjVyNXdSS3cyK09YZU9v?=
 =?utf-8?B?cGxuUFlXTHBMOFZBRU5ZbGpqYWRRRkNPa3hEa3Y5Y3poK2tVY3EvdEF3RVJU?=
 =?utf-8?B?YTRKY0FwdXo0U1kxTUhYOElyeU4reFlRSnFRaEJlY2FIVTUvN3dWUlUvUkc0?=
 =?utf-8?Q?wVrwYXuh42oYijio=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d164ba-d65b-4baa-ac47-08da1e33a87c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:27:24.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6D1vog8zD0OP4FnvgMnpoU1U4U+jxt7K0Vz/fYGGS8zRyk/hDLzfDUzlKv1YFzOwbweQpFAy7Ak9Q5vR3bPj8MpCWFpcdoRMdeiQhg++sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 4/14/2022 4:12 AM, Jarkko Sakkinen wrote:
> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
>> SGX2 functions are not allowed on all page types. For example,
>> ENCLS[EMODPR] is only allowed on regular SGX enclave pages and
>> ENCLS[EMODPT] is only allowed on TCS and regular pages. If these
>> functions are attempted on another type of page the hardware would
>> trigger a fault.
>>
>> Keep a record of the SGX page type so that there is more
>> certainty whether an SGX2 instruction can succeed and faults
>> can be treated as real failures.
>>
>> The page type is a property of struct sgx_encl_page
>> and thus does not cover the VA page type. VA pages are maintained
>> in separate structures and their type can be determined in
>> a different way. The SGX2 instructions needing the page type do not
>> operate on VA pages and this is thus not a scenario needing to
>> be covered at this time.
>>
>> struct sgx_encl_page hosting this information is maintained for each
>> enclave page so the space consumed by the struct is important.
>> The existing sgx_encl_page->vm_max_prot_bits is already unsigned long
>> while only using three bits. Transition to a bitfield for the two
>> members to support the additional information without increasing
>> the space consumed by the struct.
>>
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Nit: reviewed-by overrides acked-by so you can remove acked-by and
> keep reviewed-by.

Understood. I'll do so in the next version.

Reinette
