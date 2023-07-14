Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A152B752E21
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjGNAF6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 20:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGNAF5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 20:05:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE922D5D;
        Thu, 13 Jul 2023 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689293150; x=1720829150;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kUsmTXhmzLzRYQtB5qPPUTP10WoH7a/qctBWdfdj2g4=;
  b=aajO9z/NiFi1jxFDpXZVQTM7XZnVqlmnvRNp4QM7w34tGJoJblI+Ld8r
   SX8FyyU2gtlq8XwxKyumXfWx1d7seG4kVTX/unEPJY6SRCikh3MeM5zWC
   gLp1KFiN56Lc8V3pdWF+91TfcZHXuFj0JTJnmsbgyjuiaw9ZTjwah9gfz
   bM/bChMJLDfcHoz/X0MYpTA/PATrDZvMRuZ0oFDcrfA/43uKRwla7xW7h
   y3ei6JILPSfquSc2q+hLMlXtXdaVx+ZNbjgJ8qGmwovGG3L6wTKR5czpw
   XXUHLcRQCoctg0+L0sR+L+UI5h1KQzjKQ4XQicLrx8qXGV7aBWlpwD1My
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365385128"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365385128"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 17:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896207003"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896207003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 17:05:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:05:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:05:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 17:05:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 17:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZspdTFAGmkDI0mQisNsPlNXJ3z6sNLMBisWgPT2RxitaNOZjnCmCWEC4Bh0aGRLGrh8wEG4vksndqFwXaImdmS65pLYpDjKLpvDhJM9dEfdRRPY/S3Z2NRTcwwzj6noDo4GOjoC9AgZXzobmbhbkgdogdX26iUIDJe/IzOmFEk4VPIobcu095+1iJ8af119I4xgukA7Xnz2P1PsH7ydN1gyl1y+BdfsDE24Uf1fV12uQNvGvM7PUpaRZXi7MCMgyjkm7/foAly5mF6ZrIIpTrlJ4FUkwe1IYm5Nel9dBW76POfO7IlKz4fIQJgdmkn08fXEzpUgev5KDr8RXVlLz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lvmuqyMvF+UFslxdcITun1S2LVJGvK3qKxYV3skUPk=;
 b=dFZtZCoP9CjWb4X7+jI+NQR/vWVfMCc2A5PLHQO14IujhCjrbnKmy7RV7AhHi3eO7evGtYUnQqfdNgHNDcwGNCiiCAraqBzS03aMxogo/YOMxPgcaXAO2vl1Os2FtwRoBzonoXa8Gynwe73U87HAiKDA5o77HUAg1nJSe9IsBmin6VAG0h43ulkY4XWrR4hP9Aa0QN0nQ3c4CfFWZ+Us4OSrAjCR75MwnxFqO8CfES9WkaUPlsRDJOigONA285NBIcaKZXAlrQHW95Lj8KcbfZCARbxlRzl8RbCzt44RejoS21lTm+vSH242sh9xJvhrZsiB8s6SY62TgX0Sj72yZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Fri, 14 Jul
 2023 00:05:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 00:05:39 +0000
Message-ID: <76b47b61-f54b-78a1-17de-998b2cc47bd8@intel.com>
Date:   Thu, 13 Jul 2023 17:05:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 18/19] selftests/resctrl: Pass the real number of tests
 to show_cache_info()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-19-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-19-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 044c179c-2aa8-440d-529d-08db83fe0e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rstcSuB//d8KG3aV3AldFnu/P9kgLBBRxeG58sPItq3YP246dYJiehnZ3IOFyYn7GTl1uCKypdIzxUJCQmHG1XZT0KYSbHmHCfkVF9tBuM+ifbQqtaSYyWZ9XHj3GMRNbWZAGGqmHfltPIrdnMmVdB+AzlAXDTI2YDiblNprPrJMbm2MOgHo8pTDQb5a/zxrSdliKAfXhEYXqUcYbZYxWRQq/h/B0LbSJksxiWKeGdluydBaE63KiCiTq8b96edg8rLxBqYB117AbgxMfyvIqfzHNdekAM64/YwyBF1lpP9hwEtmHoLKf62E9monaa0/2XEOTySZS78mKelEV+pS6NhZz7xCp2IZlL/PFNldd44S4Bws1BkDsCVUahbp7I/rwNijEawIOmakBVa35qY2PM0vsj3Sn0KR2BmoSaeNubTlr1bSdXqx0i8ohTVFnaurpqXiziLocIb9E9ll+aHGKW6EZLG1bZAww2wE9CQoa87NTueiAHRlmYIadra+5YctFaZFkfSlzmc+mb67WKE6X8ExYBAwMKnVaea84uu7hT+ykYvtyeyWKUQ6MnTn6B2coLlibvqcYPiII6MIZkQ8xx0tEWygT790OMcbFYxyZZ9jExbH9pK3niWxJHmbpm8SuoslIwehUCPivWxRMouehw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(53546011)(26005)(186003)(478600001)(110136005)(41300700001)(316002)(66946007)(66556008)(66476007)(8936002)(8676002)(5660300002)(6486002)(6512007)(31686004)(6506007)(44832011)(2616005)(2906002)(4744005)(31696002)(38100700002)(82960400001)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRHVTZTMmZPLytiY0dCQXpVNXF0Zk9zTnFXeVBIT2hLb2xHMVV1YmdjN0R5?=
 =?utf-8?B?NzM5cVF3SVV3RTFEbFNnTGM2NVdiUmM0eUppaVk3dUxzOFlOMnc5WlZOdEk3?=
 =?utf-8?B?TW4yNnNkazVUQjY1VThMaHFRaXYxWXJ4a1IwZUY4L3hLRXU0eElndWplQU1K?=
 =?utf-8?B?Y3JIWE9yZXM2NVhnSG1EVVdXYmgzdnlENmxIbkVOa25NdUJIdlowRzVZSnRR?=
 =?utf-8?B?eTV1SW9Wb3NGOHNuTzRWaW8vU0FiNjRRL1hiWklyTWZmdG94VzRoeWN0aDRz?=
 =?utf-8?B?ZzEwREwvOUFUdTNPRXhvL2R1cjRqRjYrLy9QTUVxbWdxblV3TVYzcXQ3SGM0?=
 =?utf-8?B?V3hHaUpYMk5NaERwWW52RVhtTjFVc1kxNmpRMDk1dTZ5ZHNxR0lUUGFqV2pr?=
 =?utf-8?B?NU5ESUphK3BiVXZQd1U5Z250bmp5M3ZMdXZlc2hnU1kwNnJRL2d5U2ZJb08y?=
 =?utf-8?B?Ujk4ZUllRDhpMnE2VE9tc1h0ZlIxVmNvOHE4YitoclRvRExHMzkzdlFNb2FZ?=
 =?utf-8?B?VFdkN00rRU56RzJWZmZqQ29QdStDb3dMNmwySDhxS2c3T20xN1Avd3Raencr?=
 =?utf-8?B?TjgramwxUkpCNWxpSGl3NVhVNENFREk4eUxobkhJbDhzaWE4ZnkwNitYN3gx?=
 =?utf-8?B?MENOZDhwN1d4djkrTE94ZGJvRDczenZZL0VWNWRxbFBmWWViK25DSVBzQU9V?=
 =?utf-8?B?NWhia3YyOHd0NmV6dW1JRXAyZUdwalpkWUZmckIwaTl4R3BHd3R1dXEzOVNk?=
 =?utf-8?B?SmJoazlmMTdUdHptemhwNTR0eXhoUVRiL0ExcStSWUtKODNhWEJLL2hyTEo2?=
 =?utf-8?B?eTBUcnU5UUpqdVZWUWwxOWR2VENUVGlFMXI0Q3lhVkdxUFpmdkE3bGg4YVlN?=
 =?utf-8?B?WFNHdW4xS0x3NllzQit5Y3NjMW9kajV5TzlNdlNEUUhQcjhFemk3OHR0alhw?=
 =?utf-8?B?UXZuaEZJNEYxV3NHK2JFWnF6K0E1QTJxS0JyaWhmU1RVSHYvbVdnTkljTG5R?=
 =?utf-8?B?TTFLdmo1dmdkancwMmMvREJTUjJPU3h2YVpOdkF5V3UzOTlmNVRSYktYSGJK?=
 =?utf-8?B?dlEwUzFBRjBNV1ZqTUpLL2NETUVGRnNjaXVsb0g2alpUUDJQVWIxbktCMGlU?=
 =?utf-8?B?YjYrMHNOdENFVkJ4RkdTcHc4b0o0cTUyU0tmckl6VHBWNnhwNnV6V0MrT2U3?=
 =?utf-8?B?U05OUWZxWVBiUTJCZnIwL0M4QXE1SklpREpSU201bnJhV0ZBZmdKTmV5V0J4?=
 =?utf-8?B?S2laNjd1RkhYREJTYnREbDAydmdpeXRNUHc0c0pTbjQwbDQ2ZEE1dis1N25a?=
 =?utf-8?B?aitRc0VmYStMOU9DMWtNN3lweWoyczFLOXk1bWtGeCtmS05LOEZyWjlidEE4?=
 =?utf-8?B?MGRPUjFoZFZBOTh1Sjl3Z3Jna3p1d3o2VW1FdXlLSVE2dnlyN0c2eWFFNlpR?=
 =?utf-8?B?QVIrNDB4ZWE4bTZqUmtnMlZ6VEdLVitzTUdadUE1c0NyWkdlWXBYSmNIU2VR?=
 =?utf-8?B?UUVmZ1FMUzVFd3JBTk9zMWxmUmRaZlJ4WFk1K2hLVEYvM1BZbThnNkNnTXFj?=
 =?utf-8?B?d1gyTGI3aEwxUy9iTllRYWdXN1M5SVhZL2ZFS0liYTJ2czg2YWFsRGFjdEMz?=
 =?utf-8?B?NzhsYTl4QXI1SXhweGRHUDRlME1vWnpYWUExL080VXZMZ2o1MGRwVFhsQ0Nm?=
 =?utf-8?B?dkZCcDI4ZSs5YnFQZ2pxQ0ovSmtRd1Y3QWY4aE04RmIrTmxORFhVblNlVWFy?=
 =?utf-8?B?TUNSZkgzekJKbzRTWU5SZ1AxVjI3dDVUc2E1cnQzU0l3TDFkMi9YdWs3Z0lF?=
 =?utf-8?B?bTNBQXVKNmdONENUS3RzWWUrT3NsVHRhazRtaWFMOTRhUTN0akJDMXE0NGdX?=
 =?utf-8?B?dWp2RzVDQnJ5ZWtnS20xb0FjeE5uc0RyclVWd2RReUhkazY3aUk0S1QrSEJk?=
 =?utf-8?B?cUU2YWhVUlI2aCsvRTdxMC96SXpXVjVNZXZKZ0ZQbjE4RkVCTlhqWXdudEdk?=
 =?utf-8?B?aVZ4SmJGTlpMcnZEZjNlNDFjMDFoNmVKQnMxby9LS1RvcWlib2ZwdmpWbHZT?=
 =?utf-8?B?VDZtSzQraCszRGtPNmxudDZDNmFZWmw2SzdHZ3ZrQVBobTBNcWtEZmtpc2ZX?=
 =?utf-8?B?Z1k5MGhFaGFCYVNrRTRoUnM3WVhscDNoRFFTWTBTWHBrRGtBdE1CWjJqZVhV?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 044c179c-2aa8-440d-529d-08db83fe0e41
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 00:05:38.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIS+vLW79ZNUUhsExGo5RypEEBg64r828t7rC+4adddjGC1AzUXBCFlJCasiS+2n///AEQxq+NkqpFbcN5VA+ktfoO+QYMS4sGqgffcih4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> Results include warm-up test which is discarded before passing the sum
> to show_cache_info(). show_cache_info() handles this by subtracting one
> from the number of tests in divisor. It is a trappy construct to have
> sum and number of tests parameters to disagree like this.
> 
> A more logical place for subtracting the skipped tests is where the sum
> is calculated so move it there. Pass the correct number of tests to
> show_cache_info() so it can be used directly as the divisor for
> calculating the average.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
