Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84ED752D45
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGMW5O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGMW5N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:57:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF4B4;
        Thu, 13 Jul 2023 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289032; x=1720825032;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iqCQGsJYshhiMWS5G/0kWpwvcQQF/uXRvK7iSvpcPWU=;
  b=mHBbZc9sIW5ijxWnQ4NpDy8+yOX0u9q/nMidjW8ccN46LR6jvQeXdkG7
   NtCtCsu8HPm0h2lgxzonfr4ZmC3x5kHj1Ng2kfTBXC16tn3L3Y2dD8Wzv
   uxReVETrUtY0V5oGHZXn1QfWdbcOtw/MPrwvcvCGUlxIjniiHjDqSj6gu
   8Qee54U54cqBCCjbP1rEf3CjRQT4osEpiRcDVIh9bWdj1SW26MQ1+OGJr
   R/a+pMUW/iy2GVt6c49lxY7HmhpVmU5oYh74Xe437sc/IFPm8WG6PXjv0
   PC5jemJqjaTC3aiV6Y2HGUYOAJvoueJYTEyVIt5IA+yvkJ89h4zyjytTS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344930818"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="344930818"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716131744"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716131744"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2023 15:57:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:57:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:57:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjYRMEm1OaOsLzSSinc9dbXf5T+EZxLxKstwy98AOs4NAp1A9AoMIF4/0L8ouwcU1V0RwUWAQrWCQH9zPzAtpjcWny0PQV9rahNB1I6mNQQfX05C2wWm5hHXpkPGP7WcpdoAEDy0ApmWg6SCBKwcfZR5b8OKlpjjR6nWCYF26rxvPojSNFANOKW6NChIWjhspt0dbARS5WMfGzO2oSzPFoWsHHu/XZJ986DZJxaSwR2A7uKMU8xIXHNZ4Zf8FbZDD4DgAlxQ9cmjg4QXDMAWIoC9Kv7Nnfsysw8I+HcRAW+UhIxpRrraxnXqkNuGyPb6fCcuG3Nuws+41PtMjVXVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUR8gInFy7pMmqoNUpzrsLzPxS9BUBM7BkkcWpvaR2c=;
 b=P2+zJSld0xvRaF2kqTixffOP2a5+wqMC5zQ8qUvlV8ZeyrqE/0OyEi8nlo3O2IXCaP3rlesJ/FmxTsRkBFIHsI0PVOcMHOnGWeW8ziZGuwFhPHmufa5QoFtj4/OT9DPwVbZYW5szMKfMSVD+oqo2b5t1hBq76Y8vTq1VwoNuvmoPUiS1fELLPWcJRrzA8nFPdQPq+1Fo0Cpk8LQLV0au3BRjoef3gLJAa3C4lxN41+mHlryNPbKm99qhg0uXb8j4whiZULNEZrxLVH4PSMbOJ4zuAvyDoe8nFJHok0O9z3RbtGrvmxAsM/sN3+M7tme3OB/qEq0EQcZWsSLk6sdPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 22:57:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:57:08 +0000
Message-ID: <09605219-19db-ba2d-aaad-9e279543f461@intel.com>
Date:   Thu, 13 Jul 2023 15:57:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/19] selftests/resctrl: Refactor remount_resctrl(bool
 mum_resctrlfs) to mount_resctrl()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-8-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: f6037516-aa6f-4512-0e90-08db83f47c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgTTLK/JtluBLo1UuahsLWeD6YryKzf4W4Sr1iwt3A0b2cUPQTsB0b7mQfKbJMxrjvJ5iS0Gz+HVQQ/rqxL2c773tGkBPiO+tPt8LdYETEYHO2vodpwJm/BBFppLR9uEt5c1i6GJogN7YdORiAdbOYNKZ2Od53GEmPruO6Pto0kg64e9OPE4leHzSlNRzm2ls16QI+GPHWEAZsE7HY1dIXW/YvrsrkgyNOm1HDLh4v9QqxgtSGYyOahsweZj8ZzPwPnmdAQ3BsM+ox47Yc7WeyI553JZpnv6klwt1dfJUKSu4w09xt1acIzjoyBap5rfn/MeOIp/kC7V+2AiLgfgbpb8Chl2M44/Qv7dOA9iZjGwdh9EsHT2qnC0AIOFMhMerZRomKMosjonzR23/zNgkMDWfdhcaDAqWbvSK0w7lFeV3fN4xm6ntZ4YjGpMVpPD/aALzcn+xFa8pT4qbtL+HwbWGrTZYuVwHsmlCRhsIGb4FwHMY4XC7gZN13JUoGngcsQWO+0bpVMcMeuqboWa8yRjiGsbQ3GOY1CJTtwwTJUOC3hV70p6sP1hNnJOJ+cshKtNRmK0JlSDSI5lE8bfpuc7w4FUj6n982CBGTuQ4B4X3wxv8G4aqWOsMkqtVXIeK3TxvP5ggeuot5YaWovweQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(53546011)(186003)(41300700001)(26005)(6506007)(478600001)(110136005)(31686004)(316002)(66556008)(66946007)(66476007)(8936002)(5660300002)(8676002)(44832011)(6666004)(6512007)(6486002)(66574015)(2616005)(2906002)(83380400001)(38100700002)(82960400001)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJpMmlYUlh5Z3o1djYxUDc3YTFzaFNST1lHODk5QzdQcDcyUnhJQmNyTXJy?=
 =?utf-8?B?d3lNYzhHWmJkSk9JancxODdtS3ovRWczbHc1UFh5NFA4cndoNEg1clMxNnNY?=
 =?utf-8?B?Ry9nZFVldTRmcWc2eU5vY3hmWTFsUEFudmkwaEJsUlVTSklidFcvbENEMENz?=
 =?utf-8?B?R2RYekhoUDVyTVJHK29HWmIwaUxRVFl6VFBndXdneW50QTZwakZhY2t6QzMv?=
 =?utf-8?B?MVVkWURHdnBrSUFDcHNzSFdUVnc1a09PN1NkOVZOUHNJUUNsdUdwSVljSXoy?=
 =?utf-8?B?bmxjaDd1SXN0cWdNSkRlN2tGOFN4MU9PZ1NPWUsrNi9tNXlNN2FyN1libVR4?=
 =?utf-8?B?d3djNHZiVU1aY1VPTDJBOW03aUJmYVVEUFhic0I1N1NhWnpqWVBHRFpoRjZD?=
 =?utf-8?B?ODdmQ0VSM0crSHdNR3VDNGNXMEcxd1BXd25ZbVRjME5nSk8wNmI4YngzWUpy?=
 =?utf-8?B?SEY1dnRvV1VuTXdEd3d2em1JKzRrTTJoYmlsVXhjQ0RWKzJMeWcwc1NERmgr?=
 =?utf-8?B?UTY1andkRU9LU29Fc2lKMCtBQXdOdkd1NEV6RzNzeEVYWm90QTNOeFliZllF?=
 =?utf-8?B?SXU0S2t6eVpQSHNvZURPMThVMmREd3FpMCsvMHMvM0RURjJuaThwMm5melo5?=
 =?utf-8?B?dFJsQVVKTzM0aWJuQkhuZW5BQmFXYWp5OXVMUXpDWTRrenFRS1l2Q2dFdDZy?=
 =?utf-8?B?Umo2TUFhaWp4dE1LZGorQVBkSkdNUnAvVXBJSWZ1RkpVQWhNaEJmREF3cXpk?=
 =?utf-8?B?MGsrTGtZUlo0MVVSRGhwMGxlYjE5cXBNaVJQYXBOc2FvdTNubTBxZkJEY2hz?=
 =?utf-8?B?NFllQklqZlZYTVNOWUpsSWlLd0g5WTVIUGVYWVZpVWZWNTMvMUNlTEViNnJ5?=
 =?utf-8?B?TGFCRVdLbGhWaWw1TmJ3SXlCeWxaWUZxS3lOcTdwSmNZaFN1R2ZGL0hTcmFG?=
 =?utf-8?B?WmNPbjBySXV6Q0J3ejlLZG16ekwxUEwyZmZKSXRMYzhGek1tandWRVdrSEtm?=
 =?utf-8?B?WWlwbnRNR2NQc3AwdTVXaUFUUUtlbVlQay9tQ1g1KzJJWXVsY0d4cDAxL2ht?=
 =?utf-8?B?N2Fqd0tHZldyWTVLMDFyWkk0VlJHUUptR2FrRFdYekpEaVl6REE3UzRtNlJG?=
 =?utf-8?B?bjFRV1VrQ21LSHNpSytEZS9nQ1RHZ2VEcEJya3V5TmJoYXRvYStKdE1iOXBo?=
 =?utf-8?B?UkJmOVZ0MGdMTGpvcXd6V3c0YTVYdVNaam5RcnRDMXV0a1VNUmlFUnhTbS85?=
 =?utf-8?B?Ni9FRGRkR0xZMUFtZnYzb2F1a3YvajQ4Njd2N0I1TFZ6L1kxdDRpR05JZEJ5?=
 =?utf-8?B?U1N2OUFyOE9pMHo5cFphOWNIQmhzYzBWeEFxQndWVmQ5VURSRWtlSWlDUWtJ?=
 =?utf-8?B?REx1TUJ6K0Jqc2Q2clNBdnlrcHdUMDVESEhmYk5CNElHeEJHMHhrelpNUERD?=
 =?utf-8?B?VUQySytOc3Z2OTdLNzcxdHhuRWpPaE1vT2w4YW5hYWNYM2tzTEgwQmZkODBR?=
 =?utf-8?B?NGZKOHRQWlFyemRiSkJQSWk2OHQvUFh0b29YNE9veTR6anpxTmovVVFDZm1s?=
 =?utf-8?B?MVhWdFNXN0VwL28vZjhTRnVuOVhMcHhoYmRFd1ZQcTZESTJFSGI0dmhZRkha?=
 =?utf-8?B?MTNuWlgvdnYrcVpLaGhNMnRBMkQ1Q0ZxdTd4d1BrNDNmVTlBdUEvekZwZWNi?=
 =?utf-8?B?TElSOVpyU1ljQVhtd1pyaFQxajZkNXpxb3FJelBqREEwa016dnY5V1MwK3NF?=
 =?utf-8?B?NGFPUFNHTlNPUlVBaDdVVEw5VmlVRGRER29EUktOMUlUMGJtN0Q1OUlCL0pL?=
 =?utf-8?B?L08vc2x5eW9PcldSYk1rSlp1cmNhOGtVVHhaSGtiYW1Pb0FwZVJQZGVubTkr?=
 =?utf-8?B?aUhISTgwM3RnbEZnVDJ4TFVkcDA2WG5wQUUwSnN3c3dtTCtFYTJHMElLeStL?=
 =?utf-8?B?cXlWNEZVQUJueDFXN0NLRWF3TUpObjl5WjJPL09aVldZZkpxaDhsY3FaWXVt?=
 =?utf-8?B?M3J1TmVVKzdjQjAzYnVScW03OXpXam5SNnZ4ekhFUTVYL1UrL3RQS1cxMmZl?=
 =?utf-8?B?K3BPUnVEa0pFTkh0dW96MDFnVkxmeC96WHlMdTRwWnh6aXdGRE9WS1VmV0gz?=
 =?utf-8?B?L2gwbndoOS9hUjV5N1VhMDRKZlBjTWt3ZzhCYkhWdjhkVURRMXYrVkl4SFZs?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6037516-aa6f-4512-0e90-08db83f47c15
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:57:08.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQX6X5qKvvsYgxwDXIE+SfVVtIKsGsglijoP4X5tqo0fBW2nBSA7syT8XqrozifWtt+bebf0rpwR0a0ZFVziwfpiK7F/sTTgErvAb84rPjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> Mount/umount of the resctrl FS is now paired nicely per test.
> 
> Rename remount_resctrl(bool mum_resctrlfs) to mount_resctrl(). Make
> it unconditionally try to mount the resctrl FS and return error if
> resctrl FS was mounted already.
> 
> While at it, group the mount/umount prototypes in the header.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
>  .../testing/selftests/resctrl/resctrl_tests.c |  8 ++++----
>  tools/testing/selftests/resctrl/resctrlfs.c   | 20 +++++--------------
>  3 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index f455f0b7e314..23af3fb73cb4 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -85,8 +85,8 @@ extern char llc_occup_path[1024];
>  int get_vendor(void);
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
> -int remount_resctrlfs(bool mum_resctrlfs);
>  int get_resource_id(int cpu_no, int *resource_id);
> +int mount_resctrlfs(void);
>  int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
>  bool validate_resctrl_feature_request(const char *resctrl_val);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index a421d045de08..3f26d2279f75 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -77,7 +77,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
>  
>  	ksft_print_msg("Starting MBM BW change ...\n");
>  
> -	res = remount_resctrlfs(true);
> +	res = mount_resctrlfs();
>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> @@ -106,7 +106,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
>  
>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>  
> -	res = remount_resctrlfs(true);
> +	res = mount_resctrlfs();
>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> @@ -132,7 +132,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting CMT test ...\n");
>  
> -	res = remount_resctrlfs(true);
> +	res = mount_resctrlfs();
>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> @@ -160,7 +160,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  
>  	ksft_print_msg("Starting CAT test ...\n");
>  
> -	res = remount_resctrlfs(true);
> +	res = mount_resctrlfs();
>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index b3a05488d360..f622245adafe 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -48,29 +48,19 @@ static int find_resctrl_mount(char *buffer)
>  }
>  
>  /*
> - * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
> - * @mum_resctrlfs:	Should the resctrl FS be remounted?
> + * mount_resctrlfs - Mount resctrl FS at /sys/fs/resctrl
>   *
>   * If not mounted, mount it.
> - * If mounted and mum_resctrlfs then remount resctrl FS.
> - * If mounted and !mum_resctrlfs then noop
>   *
>   * Return: 0 on success, non-zero on failure
>   */

Since it is not obviously a "failure" I do think it will help to
add to the comments that resctrl already being mounted is treated as
a failure.

> -int remount_resctrlfs(bool mum_resctrlfs)
> +int mount_resctrlfs(void)
>  {
> -	char mountpoint[256];
>  	int ret;
>  
> -	ret = find_resctrl_mount(mountpoint);
> -	if (ret)
> -		strcpy(mountpoint, RESCTRL_PATH);
> -
> -	if (!ret && mum_resctrlfs && umount(mountpoint))
> -		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
> -
> -	if (!ret && !mum_resctrlfs)
> -		return 0;
> +	ret = find_resctrl_mount(NULL);
> +	if (!ret)
> +		return -1;

This treats "ret == 0" as a failure. What about -ENXIO? It seems to
me that only "ret == -ENOENT" is "success".

>  
>  	ksft_print_msg("Mounting resctrl to \"%s\"\n", RESCTRL_PATH);
>  	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);


Reinette
