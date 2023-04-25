Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6D6EE3E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 16:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjDYO2w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 10:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDYO2v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 10:28:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358CD2D54;
        Tue, 25 Apr 2023 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682432930; x=1713968930;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=alLOUv60Yfg2TQD/AZFiPBByc2zoUcBRudXAEk+7Rhg=;
  b=LhMyH5iyv3v54xrc5vFqVHXMU360XUIOyLHmXM7YNLdUb3yYworXRWgy
   hy2AmDFtKVrkuskn03W0hl5LQuL23A/sqew6xo05rEQ719LGichJo2Z9P
   NPYZ5vxoasp46KCKJglXexvDXCczWWUBttVLZ93X6Wi9SbXBln9aSLIfN
   ZRl3kbyrQBEE8Qj1VRFd/rfyN/cNByWBsLBbBwkHh7Bj2K0le6iPG0UVF
   Eg03ygHaeCbHZDR8Xudt2Iv7Tz2z3THXd6aaIU7WZNZ5F3CwrVblGrqPG
   6RnB2JJwNy6WyLddDzjPawTnQDOxAtwbL7hAYfIuNc7KOhWedYypvxp2Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="330999588"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="330999588"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 07:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="805090513"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="805090513"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2023 07:28:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 07:28:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 07:28:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 25 Apr 2023 07:28:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 25 Apr 2023 07:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaNbkv+9t6TaX1hQ+xsJt0E0vOsbzEMwLU0n96jupwZvGh/wyI0qwMRHbzarFoNwr9VzpTbua6ti7BWDIRBEjgSX13E1aKJgi6YaDkXCPtsCos/Ig1nqqscWQGlR2Vmydmm+xoLFTnOi7PQD62P9K5xMrbYzlruA8FP2aXD4U5EXFCdd5n2dK8pBTbkcehAXvRTSWoRyRcaFXdLAZ8ii+mjP86zc3xHxS6jMaSyfe7UzD5yCtlhGddPwxgBM/hsJCSWkm4jfuPhDpJl6diHkZJmbjhZsOCTnxkvUgnV7b7Krez6qI5QXBVi7iUVq14t3DkHuDWYntAqDDP/XaGvrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r8xHC/uj02XrS8VaLA2ECpRx52iXw4SE72sIK522CA=;
 b=iEI+DsjuAoUDkWcMZA5hYcA6y/m8EN+Tr9xTlYNQewfkfU3LIkUc7kqjRvEEQsI/yDtj9k7a0q4q26g44tJvdLIsgJJBrwCGkEL8IBNZ7RGzY3yfLGEOa9uxBUj29HcSOLaBZBA6s957MhR5BucUhRpHbIEB6lqP+AjYVj5wl4wWEhCzAN44BHEbGUS2ZpD1rkxKvFFMvAQDmP5jgXeCvEFCd90NCAE7fhRZl/XTDAWZ02nvs/Kd23nfd7uFUllduBrXLf2Ad2Cv0x4Ydn41Sum1qUyR2GFpbkSC+tgg5VJGY2uv8mmskWc/ANmXRrDhH8Vd1SFUfEXCI6xKjkGyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB5174.namprd11.prod.outlook.com (2603:10b6:510:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Tue, 25 Apr
 2023 14:28:47 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 14:28:46 +0000
Message-ID: <d18ec8d3-afc8-3a67-54d3-de30108cf733@intel.com>
Date:   Tue, 25 Apr 2023 07:28:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com>
 <455c986a-0d51-0302-d5c3-c6c0f1cc6bad@intel.com>
 <7bb3f116-2f4d-b81a-3f49-dae7175e82c1@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7bb3f116-2f4d-b81a-3f49-dae7175e82c1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: cd577847-de10-479f-3684-08db459960ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkoVDMHoCEMWE66B3pHecJQ+ucYRkYtWQH6EH/mQOWIkXRjw0SCY4V7iyr4kSjG58L6rOB3qtlmt79A2U8zpDj7zrL0krTx+Qeq2SeUs5yTAaoVJfUZKm58SL8SizoRQqC/v5DpWUnVCT+wl/PpY9RCkbtd37id/me8sVGbNXXgiX6+6Q3QU9zIXE0Xhgj++Ihx986fHv3pcNZ4P+NwDSNngjQzBbhzgN1ByA1OBJjFZMQ5Q/+v9q6wdMf5v1MpeXQMJMJ+ACCBH2UggoYzIgj76sn2E5fesVWpFJpyDyWTFLxCeirgigVLG6ZEae5oN0jWwikx4kT6mfRkeD948kTb6xdK4WP2SYQDeQJ4G7SOCV/AOJgSue6erG96+UYxZMWC34jVG3dotQ7lZ0Gl0Syt1zFe3OuJj7daHuWqxOXOZ670NR1UO4+ehB6Wds+L759tWY8MLmtu8a5LsoirQhmYgDIiehsFROBcAz/JJwequBcv5OEMHJA1VGZZNKSVSRS/6wvznq9KQiQ+h/13nSYiR0OdWQuaJbQxegjqcEMgUGHpX4DiElIsu8Rh97loVbfYUGsghEM+chn1tDb5luRTLvTeH1AdChXQ56daa/KBg7vttojT06kD9gM7IN7/JWtez8QDNdzVJ56U3Zqj3oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(54906003)(478600001)(5660300002)(38100700002)(8936002)(8676002)(36756003)(2906002)(86362001)(31696002)(44832011)(6916009)(4326008)(82960400001)(316002)(66476007)(66946007)(41300700001)(186003)(31686004)(2616005)(66556008)(26005)(6506007)(53546011)(6512007)(66574015)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZYbFdYRGJudmkzZDArT3BCWVpwbHBxdDJldzJ1aUJQOE5mWmhzMXdvV3hS?=
 =?utf-8?B?dVYzK2Erd2U1NDlUTXRkQmhZdkxpWWRMVzVpRFVnazRSQldOQzlGZUpKeW9F?=
 =?utf-8?B?ZXBIV1FvVERmYkhsN0lnWEF0ZFF6QlJtQXVFb3dwRmFxT20waE1KKzhlQU1Q?=
 =?utf-8?B?c3NQdXBwS1dKL1pER3pVbUUrM2Q1SGlVWFI4WFQvSGxkd05EOVBNekUwbmRy?=
 =?utf-8?B?Z09zbG9hKzJOdGVFZ0I2clhCdFdGTXBKSmtWZWxHbkZhT1NCVHlxYWFXWFNu?=
 =?utf-8?B?MzFaMWpva0NYdnNEUkc1NWsyTFYxMW9lenBOblZUUUdETkFRT3BHcS9rWDBC?=
 =?utf-8?B?RXdQN0NxV1ZPWmlNODhvck42VUpVM0pKM0syOHA4MFY5eDNwYlFjSGk0SDh5?=
 =?utf-8?B?M3lIZ2dueW51SlJIS05QZUZLUXM4dU5QOGJ1MmNZM3BhOEpsVDg0bkF4OS9a?=
 =?utf-8?B?enB6aitzK2Rrd0gyOFNUSW9EMDE5MGkvby8weldNNlVpcGZKSFo5eW9SSzEz?=
 =?utf-8?B?ZHVHakVGb1pUdkxzYmdteHJCU0drMDBOZVhRUm5La2pPUTIrRDh4T21QYXJT?=
 =?utf-8?B?NHI4NHpReU5MTGFmUU9pL08ydjJGbWZSdVRFOElNbXBYbTBJQVR5QmhjR2lP?=
 =?utf-8?B?bTArdnhBNUhXaEdQNTV1M1V5SDZ6OHlBa3ZyQkRKOVpBZktoNkE2NlFVTFJJ?=
 =?utf-8?B?dVlXYlVSUWdmSlBXYjlPMk91STNlVjR1cFJKdWYxbUlJVFF1eFZGd0s4OHg4?=
 =?utf-8?B?aWY4Y0p2SUVJZnM4QTY3ZTVWN0pLNWtNWHhZWW9oMURWQmlXVWpzMGtqSjFk?=
 =?utf-8?B?Si9pZEMzNXBmSjZlTW54d3dwNkQydGl1c2VRVDh3VFNrVEpVVG5BSCs3ejJV?=
 =?utf-8?B?U2RMbGxJVE1FSHQ2eWUvSTNUSUhqNU9NZWJyc1VscHZxZjlydUc2NDE2YzUy?=
 =?utf-8?B?ajlncWpHOCtxY09zYUloaU85MGtoQTdNemhHVksxQ2hhVUFYaHJxN0RhNFRo?=
 =?utf-8?B?SDJTMW1ETXcwOGttVU82L1pSVHF0ZU13RFFWdzE3TXBrdmtaZzBsVVlCd3BU?=
 =?utf-8?B?SGlrbjVQa25HdTBDS3dicW9VcEVXbm9LV1ZGRlczNzJSME1WK0ZuK3JDYiti?=
 =?utf-8?B?VmlQajVRMkRmMDlHK1JNbHIwUWJ6UWNxS0llQmJ3MUdTaDBzYUZHbTdxR0ZO?=
 =?utf-8?B?RW40aTloVitkUE01ajBNYU5vNGtpVnRISFNTWjJnWDZoVWUwTzBNMm4rdjVl?=
 =?utf-8?B?OEk2dng0VzVoTFAxVHFCd3ZwdW5qSHNPdWdGVVFoSkZpZUF2SE1vLzhjSW5t?=
 =?utf-8?B?bm9vK0J2ZCtla2QvUVdjT3FhcFFjSFpoRHczNHQrd3YzT1ZzWXQ2U3NIcjZl?=
 =?utf-8?B?Q2VKSUlnbVpSMXdWNGNyeTlJUlZtR2dYVXlWQUxPK0t2cDdHdFcxc2ovSldK?=
 =?utf-8?B?S0NHQTVRTEV2QWhrbURWWjk3MVNjcUpVZ3lES0xxMWhubzR1c2E5MkduRGJE?=
 =?utf-8?B?c0wzUVExamhhYzJyUGZ4ekNsUlhCSFM5ZEx5bCtxZ3lURGo2ZythY0xPQ1po?=
 =?utf-8?B?Z2Fkbjcrb3NaR3FYZkJaNG0vTjdQRTUzNFE5aVdBeFhGQmUwcEN2dU1wRFFL?=
 =?utf-8?B?T1BvRUxKK1ZZNjA5T1hPZ1ZuVmIwQkJXZGIyb0lwbDVrSU53WFVTNG1STm9Q?=
 =?utf-8?B?NkFFL1dCY2NEa3drcXR2YlhwUkdHbWNQdW1EaUo0Z2hWS2h3QXBoR2lyYUpU?=
 =?utf-8?B?QzRZeng2cE41NmRiVllWNGdSWlgzSTYvWThPdVJ1TFRKdXlBUXd0di9IK1A2?=
 =?utf-8?B?TVcvckVjYzEvRkZrV21BQTdud001a3MrQTFHK0lYaFdzTnY3UlhKRTM4cHpW?=
 =?utf-8?B?dUdzQnRhVGFDcVN6TmNrTitwL1AwUXJoQS9UTHo1Smg1WURFUmU3enN1MTlx?=
 =?utf-8?B?TGNGRWR4bndTWUkvZ0xQWUV5ZDZnbXdNWHppRk9JaWtGbDMyQWxtMjdSbnZr?=
 =?utf-8?B?TmUzU1R6bC9EL3hWZC9RMFF2UFNEMnljbTJBVnRiQWtuOUhhSWQzRFo1M3px?=
 =?utf-8?B?V2ZPRzNVREdvbW0wNEEwR2daNFBqT0hqMVBMUTQzUURTOHpIQ01FUjJQTFFN?=
 =?utf-8?B?NmtWWkJBRWMwclg2cGRpQW1TRFl1dnBTUUpBZ3MxRmp5ZkF1K2VRWEk4NXJT?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd577847-de10-479f-3684-08db459960ed
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:28:46.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFa0BV4Nqgb2h/KGTjT74QRShuydZVbVHmI5Gjg3LAKNgLWMCm/h2aVd71lnYhVPZT4WhLkL/pZbTWGlzxLYfEnwUwptAU+XQSdsC0zeEM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/25/2023 4:41 AM, Ilpo Järvinen wrote:
> On Fri, 21 Apr 2023, Reinette Chatre wrote:
>> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
>>> CAT and CMT tests depends on masks being continuous.
>>
>> The term used in the spec is "contiguous", using it here
>> may help to convey the goal.
>>
>>>
>>> Replace count_bits with more appropriate variant that counts
>>> consecutive bits.
>>
>> Could you please elaborate why this is more appropriate and
>> why this is necessary? What is wrong with current solution?
>>
>> Please note that cbm_mask in resctrl will always be contiguous.
> 
> Hi,
> 
> It's good that you asked this question.
> 
> This comes from a change (not by me originally) that also excluded the 
> shareable bits from the mask the CAT test uses. I assumed (w/o better 
> knowledge) that those shareable bits could create a hole into the mask.

You are correct. Shareable bits can create a hole in the mask.

> 
> It could be wrong assumption and the shareable bits are always at one end 
> of the CBM mask.
> 
> Do you happen to know how the shareable bits are positioned within the 
> mask?

This depends on the hardware. Software learns about it via a bitmask (as
opposed to "number of bits") so the hardware has flexibility to communicate
any combination of shared ways.

These comments are not related to this patch though. I understand that
this patch has been created in support of the changes that follow. My questions
are related to this patch that communicates that it is "more appropriate"
for what the code currently does without consideration of what is to come.
I would like to understand how this is more appropriate. Also note
that cbm_mask will always be contiguous - in this case the hardware
communicates a number of bits, not a bitmask, so this will always be
contiguous. This patch claims that the current solution is not
appropriate to parse cbm_mask, could you please elaborate why?

Reinette
