Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206486EB653
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjDVAQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDVAQj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:16:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA92696;
        Fri, 21 Apr 2023 17:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122591; x=1713658591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y0knH73k3tlFjTV/6lnAoCcywuwOSQW7E8N/bqEWyjY=;
  b=Akxm+7jRr/IPfXEEPwXL9a43NEmtt3ngEV5433SSIdtnTwpUyZPthuPV
   Kw3xVqPfePxGJIiL0UlnG5ND+uSu8AcMUi2FKrGup64DPOxuJi8vkTpWD
   f8PH/ophAQ3EbUrx/LN0yvsxN7BTmoSYbc6Dc9i58Fxr199AFmdq9M4Nw
   y1TJ3UMS0Yz+wNciZO9QW/uegacNzNLIvQGBTHqtV9B90O8EAat4767I6
   NRydW57p1tsPaoVXgOzynE/ndLbeQ79CiX7b+q2Qj9TWNG8UEH+gTD+RO
   L0o5JMGtooW59FwCU2efCeWHmhE/l4afPtggIZO0p+QUhT9VrJeGKnj65
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="432383909"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="432383909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="866854789"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="866854789"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 17:16:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:16:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:16:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oONFCuYT6eTOUKcVxgGxwSebYZa3aKpsspzOsx9iyI3VeNwf7OC4r+WsK0Cuul2zREU9aCFz8O7auL37jGyyEyg1msOgAmkze/zqYRSG4tx9hq8Ea1BUiJqLGxPKNNkx6dR4vA3sAYJA/EXfbFnHvgXaLAhdLkheVq7bA5nvBKLCq/bXclx+CEgb3ErrUw+yoBoDbEqaDDtA/TUTUb4AQjRa79Cm2RrWc3XYLUSa9Uyka8W1XlZcFOmuo25GopbmT0AbHl9zuYCybfvffI6WNOmZ2OoYrcj2EZjlmy0MXQ/cNdKa/dH6c8P//V5idIBZBMJYwgKwpUJJA4Ho93Qh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vNN11e5oi3k4QaoLHbdWorCM/ZHsB3gdhCzgcdW00U=;
 b=f1r8v3pTRmdTLjiqAAIJV0RvdZOl5B2WEjywZHiEm9MnXR2/aCtllZJF+d7KK6EqxC8YxWc8iMQL3DWrygxeyro6KuIfSmc0Ztj+9djTsU+/bhgC4vaRBjYmgszs41rB+ylvdVuGhzV/sE62Ypk4GXiUpLyyKZt9OO/Q8tgJ6nqDhxbAMCM8XwRocFgi3p9tPX5YPzPs/om+8sTFI42gGcB/iH9zgFqfdO1fF3WoZiSVgqjZU3Bhwcr5cdBTEZ7+CTgL4LXEzWyFjJytMVAMfJ31lbzseHZuOJhan3f7ZXj/Gmw2iNVRvuFQYL1TKBIEqMf81Rv2JSOG3UrtYftbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:16:23 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:16:22 +0000
Message-ID: <0926a288-fa67-5f47-42dc-bc08aa31889f@intel.com>
Date:   Fri, 21 Apr 2023 17:16:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 11/24] selftests/resctrl: Remove start_buf local
 variable from buffer alloc func
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-12-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d64e5d-c7b3-4501-eb61-08db42c6cdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAlsud//xlAjQMfcTxeE6WxyefnfRT9j+4oAGuhb/IfzSKFZeU9+/pL/wAB7lQQM7QoJB6kvtJVNkJUtrZk8Mbb/lnI7ZmrbU4CJOUQPlNextTfmCBtRkfOZ4Xvd6bGKseZKCYg4jcTnt0WEkvqhTO9uiaKtEiZguXCIlVaYs6JvxvCdHL+auqZowbPfRL3gt//qFTegrn+3KbKq7T+SkF11CnhFRKi2Fq6/D8lbdhckgglgnePRBbK/6+WkKe5fzj1KUu6pbkI1gDalzRtjyX8XpjvZohaDI0PsZ2fClZvBUfZdarIByHYglA4XOq9U3sC/aLkX0IjnALNn9W00zjqy8Jd4RwZxmyy/q31dhdiremZcO6Q6zQly9VynQ2Dugh01fzbQsWBDjBWpHYi6ilFraAnIcaj6QOMrjQruHj2LKO7F6nZGN4yER+k7fF10y7FqJ79kFQJjBvO3DzkzC8IbMFApZUw9Prl4vjzXADY+4vj3H/DKKmCsFTQms/PEWLg53JUbWUitiQDNqo4Na9YMCS7A+Uu78rkKGocWPzpNvfn8bBypWi+XqJJfeMw43B+sxxwJeMsapaHlWh4iRMDM63uYLXGyHdFnjqdc31M2ztoWEZhho0NFoAc/GKVkYQy+9BFUCwhLGvc8zsFeJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(4744005)(2906002)(8936002)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(31696002)(6506007)(6486002)(6512007)(26005)(110136005)(2616005)(31686004)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhsQkxVTXR3MU15NW84ajI4ZlliRXR0SldmNGl5WGJQOVBMSno1RldmbENO?=
 =?utf-8?B?WnFQUk40dmlVdWhtYVBVdDVSWk5iaFdFVndYbzIvRUNxWDM2Ym13UDgrS01T?=
 =?utf-8?B?MTNTS2tPeTZpSmJ3Rm9EMm1sazk1OFJjd1ZZWm5SZVZ3L1ZDdGJ0c1QzaVNy?=
 =?utf-8?B?WVRuVUlBZ2FDbHFVZGdSaW4rNHI3WkY5dXlUSUNLdVhVaFlEUkNHcVZHaW9U?=
 =?utf-8?B?TVZZRnRCclprYjUwN2JUdDlIUjhubXlzMlViK3M1elJJbGw3cU5QRVpaRms5?=
 =?utf-8?B?NUFIQmZPc2h6OGFDL25vby9UcmNiSzZMeWVUSmR1ZjkrZS9JUEcyb2gxTlVB?=
 =?utf-8?B?SlJhUy9ZM2NYRXhDSzRhYnhjZ3dROE1MVjJNSVRHenIxRlhveDJoL0JWYkIv?=
 =?utf-8?B?SmFlZmorcG1EeUdyeGUyVC92TDE2bnA5bEYveG9nVlhBbFRyMDVUYThhbjZ1?=
 =?utf-8?B?aGNlOUgxdDhNckNrQkJzeTF0WlBya0lFNHR5TjV0emNhUnc5dEpScFV4VjY4?=
 =?utf-8?B?L1JkRFBxb3ZMcHVyM1J4QTFMTE85QjdsSEhlK1E3d2F1cVdnbEpuYkRPYUcx?=
 =?utf-8?B?R3pGRkhHMnUxdVIrVjFQajZuSGg5OGdhUTIzRlprbkM5cU1sS0dNbDZSSUZt?=
 =?utf-8?B?WU5TQXZjTEF5NnE2NkRpMnpYbHYwQ0E4dDdRb1ZPeW9aNEN1ci9zaDFjS3lH?=
 =?utf-8?B?cVk2NUdxZGVuNmtad0JqVWdBdFpuQWtiektKeHZDTXJjNGloZ1BGc2ZnVWZ0?=
 =?utf-8?B?Q0RvQWpXR3hxWDc5alNpeVI1SnBxbWduUjBpT1ZxVnozcVByY1R3bVk4RVg5?=
 =?utf-8?B?bE9lRkVFb3JhT3dzR0c1Zm9EN1VRd2tIdmVlVy9xalBXbEI5QXlISTFCQ29N?=
 =?utf-8?B?RkkzajVYTldhVWRaSjBjVWhDYXJwZmlaRzB6STNCNnZkc3dOeEo0SUN3djdt?=
 =?utf-8?B?KzBJUTFwRGdOZytzNmpXMjk5MWZHU2kxYnNCRFZ6ckx4K3IrU0FQSmRyWDl1?=
 =?utf-8?B?S1c5UnQwWlgzY09GRHJONVI2U0VyRHp2b2d4Z1U4Zk9Zdk80UmJtbFB3cXM0?=
 =?utf-8?B?eFFad012M24yaWJZNlNGMnFmS1lyakNzaHdtTGFjTzBKeTVzV2dBa0pJNk5D?=
 =?utf-8?B?akE5UkdFUEhrM2xKem5yMnh3WVBScHhINFhzRUdrdGpDNnF6UGpFZXJ3bmFp?=
 =?utf-8?B?aGxtT3MyU0lOc1FJZkpKUzNHamc1aml4cVo1WjVhMXhFU0tlaTZLT0REd1Jp?=
 =?utf-8?B?aWxGZEFYM3dNejlNcWk4N3ExZTl6K2NxazcrYWpFZFNiSDI1M2dYU2NOc3Fj?=
 =?utf-8?B?UUsydDk2U081amhnbS82SVlRM01IckZCRCtyWFIrREppMkZGT0pqKzZrOElH?=
 =?utf-8?B?c3VNSkFCWmpUOTg0V2owa2x1T1ppQjlkYzRFeHpzL3BETGFCc0ZhbVk5amNF?=
 =?utf-8?B?UnBNVlMzN3lkT2V5RFl0RXlhNER5L3NZMEVpNm83Q0sxdTZBVlJYNStSMzFh?=
 =?utf-8?B?a2tuSWZ4YVdXR3dHNjhnV2FyQytSQmlLWVFSSVB0WmRWL2pCMVVRcVE1VEdI?=
 =?utf-8?B?YnRFKzBkMEFtcDc5U3hFemt1WEZxVmFHUEtxV3ZWQnJiZERNUUFrUWdFYXkw?=
 =?utf-8?B?SzNMZzFqOFhPSkNmZ1MzajFSbElkTSswTFdBOVNSOHJTYWJ0MFJTU1AzYmRk?=
 =?utf-8?B?QVdMR0lrZnpJVXpRc3hQSk81amRXVy8yM081dzBsVXFNSWlTVjRQcFh5RWNj?=
 =?utf-8?B?d2xIRmJ6bkRFQjEyYjlrZk9nVGczdjVJTTB4NHV4SmFtYS9VL0N2a3IvTi90?=
 =?utf-8?B?Yk1xWVN2LzhqS2pXL2dZbGpadU9FNmNpbitUUnlBVjNVUG1vSTNyTVJOMnhz?=
 =?utf-8?B?WW5IRStZQ29FS0E1enBVRjl4K05zLzhUZ0VDUUF3cm4xWmZ6dlZjeG9pd3Jm?=
 =?utf-8?B?WnlJRVZKckxBLzBkTkE3NVZOYmhjSTEzbERGSENySmMvWGl5ZkFod2dmTTQ4?=
 =?utf-8?B?bS93S1lCZjh2azNDUlc0U3RUZ1IrYzFnbUxoN0xNZWluaUV0OXJGcWNzZUJO?=
 =?utf-8?B?d3hPT3lJcVpBRUNGNWtMTVZYbVFaaDJjOWd6S20yUzBIQkhxMTlmQTBydXZH?=
 =?utf-8?B?N21mS2lLNUdSb3I5UGZSRWJJSW5PUlpIVWJrbThEYXlCaFFCY2cwTFVIdHBL?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d64e5d-c7b3-4501-eb61-08db42c6cdcf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:16:22.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oLiANMsX7ChfwS4uRuhdjjmLd65kJe7oG8p1reZNL5T5yw+b2wVkLSlnT6BeMMoNiSPE9MqR5MnGHaEcDqGZBBcsj10rajWECQ1lyHl7DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> alloc_buffer() has local start_ptr variable which is unnecessary.
> 
> Assign the pointer of the allocated buffer directly to startptr that is
> a global variable in fill_buf to simplify the code in alloc_buffer().

I think the opposite (removing the global variable) would make the
code more manageable. Tests manage their own buffer pointers, there is
no need for a global buffer pointer (that I can see).

Reinette
