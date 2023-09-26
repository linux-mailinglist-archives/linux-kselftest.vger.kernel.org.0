Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8910E7AF696
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 01:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjIZXN4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 19:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIZXLz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 19:11:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E97EC3;
        Tue, 26 Sep 2023 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766399; x=1727302399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H/kChCsjbiWOgx92h1QGXVV8rYAK5xYjV3AilBegSjg=;
  b=VGEd2+qyqbQ7uKIk74IbVDZdZWZQ8MPf2LhIxX8pOsGLvm1C+fglozIJ
   85CG3mHA+DqRuRGGC/m3ZnNf4AGHft4JUZnaPKHmy5ptn7+8Ch+wheSpo
   a02qqsD86MUirfN+j+kp2Yy14T6wWwFsXiy0iy6YjRVZ4B+97fgTbSHtr
   n7Ze3QyLJKX87EkDU4xc6nQmZuyd5ze7Q/VCF6MC7WnqKzjyFT9C7dcyR
   kVvWwtKSrLzBlJJI5Z4HmcW6fVEWgRsOe6a8ZHo1effVBtY/EoRsRa3Vb
   bACNSUwnVQaG01eLiR6xNGwn5H5G/lwXo+zcCKx8vaQWzUbUbG1BpkFbc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="467961131"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="467961131"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="995930547"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="995930547"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:41:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:41:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:41:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvIJ865a/kTardSOs6bRDeokWcSGnOutDJFFilM2jIXUIdojCxiORwGTFpgmOPY/K4eF6NTW0A2Koo+nm7bOJDwVV9KkH2lU0iYNfdIhYuwarwrVcbvKBLJnuNDNT0KH5gqjAVpZxY9XH5CAeu5ZeAxBG6bOObBcA0fOIt4iKp139knNcKE5lPtdgO9xECdAUKqNIbL2t/duUQogvgpSTwm1xgSkz6htJuBx970vo6LfMYUYPfHjbo05cNFFIqoXyMhpRYLKtn/WangvylXGA6wAeDrzgTCklr1So7C5rvz4eqJGuvhH+gOd8SiVFMzoJRepc/a2qHzvfMI9ZKYUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rLbP2PCtrcLscEtJALx2Ka69CGVxfY2aSFb/pWJSX8=;
 b=N4eMiVAdtCEGQNJwPWlLUZxJ5EeeqB+50CgLNcS6FTzG4sdlPjDHYELy3VdIdkYULJ/qPmiF8BeF23HS7V08eUwtbCDxTq31N+Ybtv0jJfbZRoN2U7T86bFReOttWNT+dXdnTEhDOELtkih3twGG80c5op7HHM2QKFUsPBJ75REovYu++fE9VYtNn9pX+oxpjpJo9vpK2Mhv4QmPx2pYzZqd0EW/qdzI4Grn0q3Sdms900C4IbQdnmCMzJ+yMi6sTZvEqq8rsDezEO6K7zKUjnCANHzxyUtyDI9Sw1Cls53nGoDi6ZkndbpeWA6KNfAe6EihyDCge510CfkqqhaZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:41:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:41:26 +0000
Message-ID: <75a47252-f304-5377-f4a3-87a07cf4e2c5@intel.com>
Date:   Tue, 26 Sep 2023 14:41:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/6] selftests/resctrl: Fix feature checks
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915154438.82931-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:303:85::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: f8707886-d6e0-41aa-257a-08dbbed95638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUvDw74pn4JSTTg+qwLf4dQ1gAsA9kJtnx1dABKowNkL1AwOcRnk9g9nWE4/WnG2DIgU3djIOYUqwHw5Z2aIu0CCg7h4oMRf61uTZ8eCKy1jwgmK/MMD0u6lHCV3Ftab1xH+sSPvOVKfR49kH+mZh1261BJyijCZGGgHVIRJtUQOyYKQaR7OjP6Su8TBAER0F4AUML4ujiis08O/XC9YddM0TBI2khv/ZjT9Y2RFyI+SbztFBK89FOm+jB+z+4h1Szs4efGjbe2VhMKXomtKZIquZnV/NP+6qPbzqjhvapzfSmnnsxW1vfZbvGcpFjuMBhboz1A21Xj8C3pXEUnQZEaiaI9f2zmsekxzXmandpXVrm6q3eQMxQKvViVt5+Uft7290c3P1mnDQpRUwuWPU3ocRpC+V2nf1CVhmygPcVGer1U7R/JQXcKvYNe67hnmn8PJCdshAIJLgQ8uJ8aBqaP2i7u51qbr/U+hqpXozvYdNZrQj7ra6AblcWV29c+rgfRUJXb0vA7u29GWrmVLYr7Go59mkf7ERfXp3dHCgmCrCsJjBVIl/Va5zQdHIgYM3ulgLq17GZKA762W9GBBdx74v4FGdI5RxJ2QBP12ESG/ewmQPe3hrnc18/rHndvaoctL/Jiwk08MsLkp4v7xJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(6506007)(38100700002)(5660300002)(53546011)(36756003)(83380400001)(478600001)(6486002)(82960400001)(66574015)(4326008)(8676002)(8936002)(2616005)(41300700001)(110136005)(44832011)(31686004)(26005)(66476007)(31696002)(54906003)(66946007)(66556008)(6636002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm02aDZqOTdFQldNZW83UWhEL0oybTU5dGo5UTIzbnlLcTVDVnRGSk9mN2tn?=
 =?utf-8?B?SW1pVjh6R3p3UFBJYndYZU9XNmhmYlM2VURscUIzWXMwVC9kdC8zRWRCYUVv?=
 =?utf-8?B?RnkyMi9USFVtTnRoMFZPNE04R2pZNURiQVdFTy85Rm5WbVNCMkxhS1BucnhR?=
 =?utf-8?B?eUZPc0FsUUt0YTM1RDlxVnY2azFxbmVRZlJvYjZqeE9nSlRPMHhUQWRjY09U?=
 =?utf-8?B?azFTTXJpU0VIZkZCeUkyWkxSR3N0MDF0ZDB2QW9jREN3SG5iNUFjMlk3STU4?=
 =?utf-8?B?NmcxTmtYYTcwQWZHaEMrQ2txYzcrKzliZ2hGV05ibXl4RFdPMERvWG5jTzkw?=
 =?utf-8?B?RGdzdHlBNktrVnFRTHY5bmZKVW5YY2t0by9BNHFTQXNNeStIUHpuQlkzQnpC?=
 =?utf-8?B?eEtDYXJycnJzTTZSVllvaUlWTy94NXE2NkxiRDJxQm5KdExmaEF4alc4R2xa?=
 =?utf-8?B?K0toUmp5MTVUMFpHVXpFdkRXQ29YNnJYTXVJSHROQkdxaUxEVDdSc0dqZ01P?=
 =?utf-8?B?aXQ2MU9FcnltZGVuYnZHTXJacytlMUhqOGtaY3d2NVE3eFNrck5HR3Qzd2pl?=
 =?utf-8?B?eFRYR0R6SlNIZjdIYnBkQTIveWgrcHpJRHlXbjVXaGYzeVpyQzNVajlFajdo?=
 =?utf-8?B?ZkZab00yU1RlRjdWMmFhQStNVXVNZzV2R00waUNqSlBMajRvRTJqNWNZN2Nq?=
 =?utf-8?B?OXFDbnVFNXJiSVJuaTZDaUVhU2RVSWZ5bTdLM2E0ck9oeG9KV0cwUzE0Tmxa?=
 =?utf-8?B?bmFiMVN2Umc3QlByc08xZWNNUDYvVm44MlE3VEY3bjNYZkJ0T0NGdjVDMWJo?=
 =?utf-8?B?SndiU09hREJmaEQwZjBxQUNCM1ZTbVpsSkZVR0VBTUEyeTMxNUtHRkl6N05T?=
 =?utf-8?B?ckdiaXlSUjJKVm92QTUxZ0EvWjBwMGZoS2VSRCt5bERObGtIeHY5b0RZRkdl?=
 =?utf-8?B?VjBFeTlUc1VZcW1XcVJhdTRQcUtOcFhHL0plMWNpY09KZVp1cXc3SjA5SHd1?=
 =?utf-8?B?bjR2eUVFeHZNRzVOVzNJRDArNEIzWUJZM1dxaUl1ejMzZDN1NlVqY0ZXSzZ2?=
 =?utf-8?B?YUlJek9ESHRVbHFhK1c4cW1oaVJ0cVhlaUpDeTFBcGhaM1NhU0JFYnI2bVJm?=
 =?utf-8?B?YnF1ZWVTMDZDU2Z0a0ZxV1NhSFB6Y3h1UzYwZlZqSi85K2FWU1BTekRud01z?=
 =?utf-8?B?MmVqTlozMENXQmxzT0d2ZlFlWmN3b3E0TlRWdWREVTlSVFpPcWFhUDJpdFV5?=
 =?utf-8?B?Yk9lT2cxWjloYXd5SnM4L1dnUHZiK08vMHZGY3F5aUdqbXVodld2a1BUQmww?=
 =?utf-8?B?ck03ZU9BdFVpMGZURVZuYkFKTXRtVElVWEhwL2MzYWFaSENhYlgyZnFJNzRU?=
 =?utf-8?B?T3dBekFPVGpid0ZISVFFYjhKMnd3aTlXcFpYcWtyVW85eE9mUWpXMDRVWlAw?=
 =?utf-8?B?MVdVSXp5ZmpabUhlaExWYlpNbCtaZlJRZ3lTTEVSNFpsenMzTEx2em1XTElU?=
 =?utf-8?B?RWxHRm5NaHl1Qk45RTF4bXBBeXhidjZDaENFQ2c4cUdlbXBndUJUN2tnMVQ0?=
 =?utf-8?B?a2ZpaS9vWks3YldZOGY3aFhjY3k5Sy9aL2Y5M3pIT2tiQlVFblQ5TVV4b3FD?=
 =?utf-8?B?bDZnbHR1eVltaEFLK2tvdWx1cWE2cHBLZFh0OXNzQTFQSzRHMitwU096QlZR?=
 =?utf-8?B?WDgwZEJBODZVNk5Ya0M0cjVqYU1JTWlXL1JOdU5sME0vTXR3T2lLVk9uS0lk?=
 =?utf-8?B?Q0pqU28rSFUxNlNNQnNTbmdnWFRBYndrWDlJNWFOOXROV2VLSVh4a2x4QWlq?=
 =?utf-8?B?QjhiaVJWVTkzM2dhUkh4VEV4cjJhQldZMk51N2ZGNFA4V29CWUlBVUtvN1Rh?=
 =?utf-8?B?OTV4YWRTeGZYSnB6QzlLdFJNTHA1OFMzdldwSHV4aDRhRE1Fb1l0OVFFaUVm?=
 =?utf-8?B?c3NLRjNObXpSSElhZkhkclhzRkJ0OVVaZmgzUkVrZHQ3Q1JsKzgyUExzU1hF?=
 =?utf-8?B?V0hDczR5bDZiQ1FZQWFLcTRITFlva3M4T3hZM3kwd1NuM25yWlNoVkc2dmJp?=
 =?utf-8?B?elVSeWJnK0tBM0JudlhhaTEvazRSQ2gvSUhVTi9FSmNFUC94K0NDMHl1MHBB?=
 =?utf-8?B?dm1JZmlrdmk1dVJsN0dsU092V3lORHF5djhLTzF0WktCdURvUUZkY0RoQUlT?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8707886-d6e0-41aa-257a-08dbbed95638
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:41:26.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDRWgy+2sTri4nhRE9kLjaI/DTVy1sZZCEHs5pUMIvAoNyXBKki+XkExkf0BKrNEAHLMEnujGW8N6/KR5PwH1JEchN9eccciQ2rJkvyDGm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:
> The MBA and CMT tests expect support of other features to be able to
> run.
> 
> When platform only supports MBA but not MBM, MBA test will fail with:
> Failed to open total bw file: No such file or directory
> 
> When platform only supports CMT but not CAT, CMT test will fail with:
> Failed to open bit mask file '/sys/fs/resctrl/info/L3/cbm_mask': No such file or directory
> 
> Extend feature checks to cover these two conditions.

It may be helpful to expand on this more to justify why this is
stable material. At this point it sounds as though (from user space
perspective) one error is replaced by another. Perhaps just a snippet
that states that this fix will cause the test to be skipped on these
platforms.

> 
> Fixes: ee0415681eb6 ("selftests/resctrl: Use resctrl/info for feature detection")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org> # selftests/resctrl: Refactor feature check to use resource and feature name

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

