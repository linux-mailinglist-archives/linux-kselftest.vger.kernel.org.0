Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5FD752DAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjGMXDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjGMXCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:02:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F782D55;
        Thu, 13 Jul 2023 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289319; x=1720825319;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/KZNw7k6guUcYTe7fEK9L1oXyfVIoyFBMlg/PMVya0Q=;
  b=H/el3zr5ks7oy/VByEYpiGrnZ1h1UYhNy9bDn7etS6s1v/1POU5M6+Gb
   DSzBi3eanu+bCVnzYzbaPCDnptE0Hc29OjheWo3qBCyW7mwqqzQgxR0pD
   KHCL74+ZAeTkUA3AK6zS2Nm+wg2CJx0Az9Cgrv+8RPrOkak/P2KAx7+fg
   XWX5WzqzYW02NPqN+3Ho8MV2UKzxXvJRl9P6IZBvurCSrDMw3HIVKhkzi
   QQxmusr0Nks548nVpNrrnilvQkTJGIMylMniqZTG2xPzqai1wiRGzgs0e
   ThnPg5s0yIJ8N31OPYZp4ljUYZ0/eeWPiGRjeegGAvQS0WLz+6bYeqApI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344931646"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="344931646"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1052817192"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="1052817192"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2023 16:01:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:01:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:01:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvLwDS2xJwca8Ru7pDZxWab7pRCxxqTi3qqMFgu/OUdNJE4gxEf0MSUgBzXWapIaBUaheVPHVDHRZYZJz8ctbvw53mMyGaw2vvpRjGXe7HTkETeK8BSeMvpl7zhtpVxi1H/jNI9x7eGpLLGnEsSq1k6DRcKHr63m4QQ4DYpMC1DJ56vdevPIR5p7so2M2vhUNCpLpQoKOCSWqVjh5nLB3pLABcRt9/RscOb9tTOszkn8+r2sHF95Z9Bihy7cqPQEmq2T6lm6HXoTMKkRGl6EAw8tGqzPn65jVCiozt4TfoFsNnlJsABVmz1wB0CFPB/O6O6lHS3dbHFCZDd0jfTA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7ewUBCw9kOjQE4mFypX46wAX3ezNvGZYCZqE67GrCM=;
 b=VgarDHHahdYV8QpMoywZX1DXtSdQidqpRh7oBhcyQ8E532kT4jYBye+7ycfhLSAeYO20xGhpzlWQMhDCZrhQiL++q6V3g+Iwq7SRM5fvcyClbM3DxW4K66eYT209tFnYosFJLQfdxlv7GfbrS9209gkQZRY/BXpBEOYsXU/K1Rn6deWkiQrgmxEd7NHpZgrONaldiHohceY+XpCl3i99VEff2mIv3vOSAm9TCmavb67X9MhqL8CY0iHlEZhSfRBYzZpS/xo8uGOA8GnrA427Xf5yFH3bMbKaIrFmlWSzRW8Ltc6HSA4c91ewMtyKUO4SHVjYQ5VfZF3IIXtpqE1hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Thu, 13 Jul
 2023 23:01:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 23:01:56 +0000
Message-ID: <6d86980f-ad9f-0676-011a-41a4625318a6@intel.com>
Date:   Thu, 13 Jul 2023 16:01:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 11/19] selftests/resctrl: Remove duplicated preparation
 for span arg
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-12-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO6PR11MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: d0dbae49-1d02-47c1-ae85-08db83f52823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9omK7QWsytfjaJPslnguGt3jq6ll0ev+//0XVYU1+ApBjK3NzrzkkTS7cA39drVb3KNNRb0WJjHo35M0B9M3SJKnSG/X9BmuOKhUktf3YJxy6UH/DSdpcqP+SYy28iF/57u6iRNHaPg9EKIQKFqf5c+sZ4KBxhlMuv86fBV/JB5aWKdveWFC6/ToZBXVupqZPyNWh6vLG3oWNyVo1imrOAzX0A3nhGrJK74PR5HuE9d0DzvLfrdQ2OYmaEfLXLYXG9rUv4FO+it4sLkrHq16Dn3CU0KEeKFKrnE3ifubuq81oS2S5MmhxmWdvWwIOFk/zypGN2X/lRl+d8K8vBpR7s+6Kt2+l3P2iwoiZ/11AEtbPUry5/f36Et7u9pBk12Tfcms0++Jg+h5qKg2FriCo7aamwuJOk/7k1/Rfbhdm9lxapnb0efujgcPfbAr4xAlXtv7cYakbyOjHPbPvrsbrNl7JAevl7a9XK/5zmN9fy9TopbvdGAISuyQ0QkRtEt9eGLCa8uxNwcljH0k4erzDRGKbGPVClOpKJ6Z3NKXq7MnBiaOu5oUVnS6u5/KUaec/m1TkgvfBD5sUKQw61oxJhaODcQrrW3Ad5b+MOmcGq6PrnXRXiiO5poAV2U2DgqgHQB9E++KD1v7+dMd2scnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(110136005)(41300700001)(44832011)(66476007)(66946007)(66556008)(478600001)(4744005)(31686004)(5660300002)(2906002)(8676002)(8936002)(316002)(6486002)(6512007)(82960400001)(31696002)(86362001)(26005)(6506007)(53546011)(186003)(2616005)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnI2M0Y3VmRiRXNIc1hTQjVoTkFDQS9TejNHbU9RbjFiU1JUekREdzUrMk5u?=
 =?utf-8?B?Vmt6RVE3Z29DU1oyaHJpSk41UC9tbUkvZ1p4cXJxOUppVnoyOWErOFRIVnU0?=
 =?utf-8?B?djJsMVZCRytBSHIyeU1wNnI2eE9mYS9lY29DUUF3QlRNYjFjdWd0VFVXRDBQ?=
 =?utf-8?B?RHd2WHRKVDB6azhIM2grck1LeTBjeGV2ODc4UjdsQUg2ejhZckpIZWp4a2NP?=
 =?utf-8?B?aGpVam9CdnZrNFBENmZPZFlVRmdSb2ZQQU5aTWd6TDJVNXJIamRnRWtuVDIx?=
 =?utf-8?B?NWU5N0VWU1ZROHhpS2ZrQ3dLM0FrYUZvcDVVSll5OXdwMGw4d2hXSFlPbGc3?=
 =?utf-8?B?dlFteHptZkFhODlzOE5RMzZQd0VBM241TVBUeFlJVVphQ2VHNGxHZ2NDN25j?=
 =?utf-8?B?dEFXTENCT2FZTUNIM2M5U1FoZzZHNzRGQzd6Q2IzazkwVndDYkdVZUtUVzB1?=
 =?utf-8?B?N0JmbjhHQlJxVHFYdytmS2orTUMrTlEvbjRlYWFkbXFKZSsxaEFqUCt3bDFH?=
 =?utf-8?B?WForV0p0VUdyaDluMmJkWmNpMXgyaVp6b2ZiemtZeDJhQmhlSkVMVnVRTDAv?=
 =?utf-8?B?TlVRWUx6ZEd2UWNHVlhMdHhKWXU5QUZjYko5NlMrMW1Eb0d3L1VOemtyUjVU?=
 =?utf-8?B?L3ovRkN4dnNqZmZMNWxkeE02OFloc0dnenJqM1BRZUxVdTJiTm9HeUFoTEVq?=
 =?utf-8?B?ZVViV1RFUWd0MnUvZHhtMXNvaTJ1Y0hYMTM3L2xqaW9QWk1RK3c4QzB2ckUr?=
 =?utf-8?B?VHJxaWhaNWxRLzVrOFhaMytXWnVFaTB1RytSNXhlRmFyZ2ZwaGRsajhYemcw?=
 =?utf-8?B?RVM1N0tHdzg4TVJaWGhRNkV3TEUrb2pCKzlzSVRNZE9mSlZzUUJVUFhaMXpw?=
 =?utf-8?B?K1dhUjdSejA5UjNhYmtPOW1pTjlTOC8wWUZoVmhVZHQweEs2Wjhiek5Mck83?=
 =?utf-8?B?SnVYRVYvNkVLKzZCL0ZZSDQvbk1sejg3Z1FlekE2Z2trZ0VYaE44bCtuZkhQ?=
 =?utf-8?B?Z2xKb0tiWG9hWHZGdXhKYnA1ZExGeENJQkVwYVY2blI5VFk2M2VDQW4wQWd6?=
 =?utf-8?B?QWVjcTFwWEM2c1FmSkV1Rmd4Y0NyMVh3c2JCOGVFcEdheVhVTTlIa0hraGtE?=
 =?utf-8?B?QWF1NVQ5Smc4NDlNZ1hRUjZQaHkvTWorVDVhNHdrcXFDMFRoeDJES1ZDbHZT?=
 =?utf-8?B?YnIrT245dDZGUUNkazRpekIySEFWa1NxQXpxN3dOTExCcUpwYzV2UDk1MEhL?=
 =?utf-8?B?ZWhvOFZsK1p6OUhNSGs4K2ZoQVBiQU11TU5OVEhEUGc1cVhsMmo2b2xSMGw3?=
 =?utf-8?B?eVZBaklmbVIvVzduWXJKRXNjRnIwTld3STUyN3dkNUdUQnhpTHVlVUkvdzdi?=
 =?utf-8?B?WlNvekQyRXZOUCtiYVBueGIydkEybWZqeHNlVmN4VFJ2MzV0V0JQYldOUm1X?=
 =?utf-8?B?YVVTSnhoTlU2Wk5ZRVYvaEZvVU01cS93Y3Rhd0tjaG1BL2w2QkV3M2lJMDF2?=
 =?utf-8?B?VjVoUjE2RE9tRG5nMGp2MDRWWFZKVlh3ZlJiL1hjRWJYUW5PWTFEUmNQRTdM?=
 =?utf-8?B?NkJtdTFJMWNWUzhHU0VnOSs1dm5kTUZkLzhDRVpRZHRFWjhKYXh2UnlrU3pu?=
 =?utf-8?B?M2d1cjNoU3JXUDRhUjFDaFdxMDBKMTErQmozN2JEdHdDUXNMd0JCQkpaRkht?=
 =?utf-8?B?YmRNeDE2TDF4d2xMQy9jelNmOEhFS3FwbjRtTm9NNTcvY1ZCelpoTHhwd1Nl?=
 =?utf-8?B?eUxJc1lkNWpWV2hDUmZocVpTY2hxTWxLSTZHTXA1QjVpNUZHT3dyT1Nuakxq?=
 =?utf-8?B?ZUhmVU9DK3FjcmJTaTN0SUJub2FGdmthV0NnNGxjOG5yQ0dSWDZ1Z2MyL242?=
 =?utf-8?B?TENaN0UxN3RUK2x0VCs2V1Y4R3RyM2J6L0NUL09FNVFCdWJIdllhMzMwRUhw?=
 =?utf-8?B?bXNMbkZnS2tCZHJMaUFuT2NtbVN3UGRkT1ZMclVuU0svNGpNNFZLRjZQUGc2?=
 =?utf-8?B?YjllYU5ROFdHYW5GWHl3VkNtMDdDekVqbExqaXBSNGpFcmoyMEMrT0Fxcmk0?=
 =?utf-8?B?UnZLK3ZybVpRazlCVkdIWDhMVFlCcUo1U3YwMkY0dEJNSCtHWFNOdEdaMWNV?=
 =?utf-8?B?MWkwRXlnbS84RzJqbktGUFdkS1E1VlU5L3dEK2ozSG05dXBWc0pCV1NweDRl?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dbae49-1d02-47c1-ae85-08db83f52823
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:01:56.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEB9XJg6b6UqUCmw84hVF7SN8iXDX5d18WrOcvmU+5oWQkLl+Hs7k9J3WgJ2dA693wHQHDvqqjNbDKVADmFjK5gCfMuDrYOXqehPb+5iIcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
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
> When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
> main(). There's no need to do it again in run_mba_test().
> 
> Remove the duplicated preparation for span argument into
> benchmark_cmd[1] from run_mba_test(). After this, the has_ben and span
> arguments to run_mba_test() can be removed.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
