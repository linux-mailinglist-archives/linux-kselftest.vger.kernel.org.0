Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DDF7B86D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjJDRnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjJDRnR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 13:43:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D94AB8;
        Wed,  4 Oct 2023 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696441392; x=1727977392;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wusBh9D5/dwIr4VShsVPhbHzM/ThsQwHdFWuOQGmq1g=;
  b=J/S8WyxobaAm5F+i5w3SI0zFBAIef4TgMdmEND1FlJcLb/oMinqdAyuh
   HIBTlnpLvUJ9im9zre0aMAZE4DU7yUsE1FDyVUGkV2f+vq/mJYtL8BF4k
   IIVhX2tG6S7+Br6tEdtRQtBCAZJGQ8IGWD6iX7FW+JKX1je5wLvDgyLRp
   CCZCcaCcnx4afoQ2w9h2B2rfObdRNUUUrDG7w4FldRohD03zht6qCz1la
   CvKsVSgcxVa5/dOdN7Gm9U8sShCLY7Vrhb6tGed7F3Ua0nmP43I0Db2Ug
   Fu8J8NQpQdUXnBRGiU36FvoolW4FStqEX+NLyRLXiWab6o9dAMZA1034l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="386075726"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="386075726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 10:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="745076022"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="745076022"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 10:43:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 10:43:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 10:43:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 10:43:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 10:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnBiZfc3ucQ86VeOAz5fPtYZAkcVIOVJX9ILv70efH+X925nHqVIogss3ip7DeEVAhi8KPII9NaW0i+sJ3SiSahUPaDBEsn1YYd8YEXqud1RzjUEcaaDQWYeTO79/Tz5BO5iuZdcxYAdaYJmtpocNbx2d8an20kUFqJ+cTeGCv8yDBi3W/yVcMAWaJnxAu3vK77u0X615Sk07VlUU319K6eu/pmoyzmhxZ93bOizTowuoq/B/IYCytFl1EUQ6JCf4sqLuMJmhT5OPyKoHczE7/2yLFTBkD9q+x6Bd3vClGMvSUmbT/K6UmAxojS429hJ2abrUvSdkJ+crV6OlbpDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRQLfonJiS4Q7WUEqR4CaoXo3DBqEU4oYuH08nlsVrI=;
 b=b5rWArY+d4tNe+5AJ8Kq8C35iLkOuWdxbIbT+5IqMV6T4jU4hRk6M/1PTFrPkJqy4pBuOphsjjtXwuI+CCd30FFeEnEqJGvLNuQcrj9h+QVO5vFjpvzbwXFs7acHL7IFYs9LJFYcqD+t/Z1zZ4Ia+W1wuzPa7yp//8dYED83u6K/oHa4qy6gODB6VaFSqMd+V+ZUYJefiGKFZoM2UCHs78aMAI8YlxzE2WUXBn6fkYKnS7MAy/d8gHNHiBziwqr75O/ivd641NlTGMztqCZ78YCwHYlYfEn4JEa0naMbYS2ovO6uxJFgq+BeDj9+/DUvQHDnysWULOAs5xa6HVeKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 17:43:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 17:43:08 +0000
Message-ID: <0033ee44-5383-4e69-b85d-ed88592bee94@intel.com>
Date:   Wed, 4 Oct 2023 10:43:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-2-ilpo.jarvinen@linux.intel.com>
 <d2d94def-742d-7661-3632-b9f7e4996415@intel.com>
 <TYAPR01MB6330F248767F48A2A649CDE58BC1A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330F248767F48A2A649CDE58BC1A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f0b0be-e640-4c68-b086-08dbc5015ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+Fo5G8COUTHxN+U4eUvPU8wBC8wcSA4H3WdasYnpMQpmf0hwxF+HCvvyreF83JbKfnoYMpi9NcyimKDjMmCK9a0jS3DacuPpAmMelbQrls7rl0VK1C5Rhm/xaC9vScyfYB0pkqGPrIIIZAz/CVvKMtBATKLeqIwA0JoL6gX+zMqy5bndhAMQkA4PofgHgp8uAHVELwxvpvrAPJ1OWTb86sTyWJdJj3TGmluV+wJ5d85ycvldiTMtKMEvvBZucRqQhTE4l1npUapw424QWMCk3VYREZ87CSbfAcwQCS4T0t8A4AgygQhr3U8k8BwymP9JuVt2VWU79RZxHHi4Ndarq2cwrbCgJmGWJy+b8lqksmsUOvk/YQAvqdnnm9F1gyki/4GHvzc0U3Xcu2wzWDRXojbPVw8dzTIsq4tmdflBSEP6H3yHo1zpB18Kpo5FgHzJ0KTTxkwEkhjqCXZATFbv1dWTMYIZNpLhTQ84J4X0EitEO/xKKovHzP8pjEwn3VaFaQoDGTHa1w3HNeZvZgJpMLrTE/C8j1mnObSe3+PCBhY5yhCYU/XDbM4Ye48RMqV/mApHSx+lo5tQIS5CqFQ+8ydn6SZmGT7p6NAOHByYKbZmNi96lqDIdn1eRGpnWDx5rEsNrgxTGO8CJjSNfFI/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(6486002)(6506007)(6666004)(478600001)(83380400001)(6512007)(26005)(2906002)(110136005)(41300700001)(316002)(6636002)(66946007)(66476007)(54906003)(8936002)(5660300002)(66556008)(4326008)(44832011)(8676002)(38100700002)(36756003)(66574015)(82960400001)(86362001)(31696002)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkxCRmJDUjZMRVVaNkJacXczcXJ0TEx0YUMyaVhvSDUwNFFPbWZVam55Y1JK?=
 =?utf-8?B?bFRZSW4zRnl1VTk4OU81bW9Sc0hYakFUeUdaaGM0V1V2SU0yMWxwbXFtdjJI?=
 =?utf-8?B?V0NSMWtha1BSV0o0R1lMWUtUYkU3b3EvVmtPNW5MQW8rT24waG5JdlREeWhs?=
 =?utf-8?B?a0pDQk5SUnh1aFAzMU9PWjUwRndiMXB3cnc1ZXdYM3Z4RG5Za2h4Sm9SYlUw?=
 =?utf-8?B?YTBIYTNhR1RFMDVRZlhMejA5OEozV0dsQkdEV0FZTS8vaVIvTUNQS0lQZXhz?=
 =?utf-8?B?amQycWNncWxROTRFYlo3eGlHOE1qL0FydUI1dkZmV0RsdTlaV3RXL3p1eU9t?=
 =?utf-8?B?ZkhvdWtHTFJZS1NEWkdxUm1ybzdIUThkckl5bzNMUWpSQ25qQUU0OGVGUUho?=
 =?utf-8?B?NGdWVHFYems0R1pOcFdiQlQ3TWlmNUNMemFvVUpMTFBLYnNGOEo1c2pDYTN2?=
 =?utf-8?B?dUtqVzNHcHVFQU9sTFZSNXFQaUpJM0pzcVJzaE0xZndYUVNIaFl0aXE4SFJy?=
 =?utf-8?B?ZzhKeWRDR3U2d2g4Mnk1WXVSbnF3ZXBXKzZKQkdtZHYxalZUTFdlUEloLzFE?=
 =?utf-8?B?V1FNaTNFbitpM3pUVTdHM2tmb1NuWFdFUlhudGEyRDdOdVpISDdPMmZHcVlH?=
 =?utf-8?B?M1hvTlh5S0pLdUdNZFhwN3Y2L2ZIRjBaeHRmRG9BR1N2Z3hBTGhHQmFPN2JD?=
 =?utf-8?B?eFBhWDh4RGRpRXFpMjAzUldaaDVOZnZBRFBjQWNzdE1YTVBqN1pReWZ4Mlhi?=
 =?utf-8?B?ZGhlTU8vR3Y0M25yTnBja1BsWi95YTNYUzJkVFhMMFAzOVluODNwdWROWTVx?=
 =?utf-8?B?enVxTllDaDE3clJFajV1SHRUSUN6U0s3Y0tNdEI4eUVjSVgvclZ5R0dBY2Fq?=
 =?utf-8?B?VXhmc2NwUExmSUVFLytMUXJpOTVMUUpGYjhOTUppNDRZbldveFBBNzJGUVJH?=
 =?utf-8?B?K3ZWTHlxOU0ydU5adTJsOEVHZkFBU3A3NVJrNFhmSWg0dW9IZnh0VS8waE5B?=
 =?utf-8?B?V3NZYTRCM0VvUlp1WHJESzVtT1Roa2ltZHVPbCtXVUs5RjZ5dDdCL0kvZWll?=
 =?utf-8?B?QjZ6VzBMWE1SUVlociswNVh1UFNKUW50YkNHb3VFVW9CMkZ3TzdjQlQzQWlY?=
 =?utf-8?B?aXZRV21XMXJLNTZkVVFFSkxFSW9reUpGVEJnREcvK2xQSHNYYjc0aVZWdkcv?=
 =?utf-8?B?b3F5OU9xUDVTdG9ZL0ZEZjZCUHNyOUk0emNsREhIRUtteWx4U2JVTndoQlo1?=
 =?utf-8?B?b0dpem1KZFIvNlMzejlYMGdhaTY1YjFIUnNqVUo1MTlLQ0pxMGhyb1kvTDBq?=
 =?utf-8?B?U0ZnZGlRUEhGY01WZHlYc3d0aVhjc21KaGVDSGUzeGNsTE9ZMDE4YmN2MTJI?=
 =?utf-8?B?WUpQTGhKNFErK2p3Mk0yTnR0UlJCNTVISm41bW02T0JWZ3N5NGh0Tm1ackZu?=
 =?utf-8?B?YUpJM1NYTy9FSk1WcEhXRkNJaXh6THk1QVdVcURkUVZPZkRTQWhDalU2dGg1?=
 =?utf-8?B?Uk5XV1VZQ0ZQdWhKeFJVQmQyRUttUVgzMWhINlptWE1NNGpxSkE5QTlpVkF4?=
 =?utf-8?B?QnJyYU9pWEJhMTcyL0hOYTB5djBqN3RQT3RZbmtrNmFSanV5SDJXYXAxMHY0?=
 =?utf-8?B?QUR2TXJpaTNkVFE4bXZLandFM3FyVUR3bFRuSUVlczM4cUpKYXMzQ0lPRnE5?=
 =?utf-8?B?YTI0MVoxTmozTHNaa2ZIUGRkemdjMDZGc0ZXSzNrMDZueDBIeU1KWG05eUhX?=
 =?utf-8?B?VCtUWDJTNzhFU1dmWmw5RU15RktMUnNFT1E2Q0wrS09vZjRLdGVLRnZiWHY5?=
 =?utf-8?B?cjBlZktieXhTaUNCVS9aMlZpSXc4T0tXSVpmaXczeW55ZGhsQUd6eTN5anIz?=
 =?utf-8?B?d2VCMFZvM1RGWUF3MklOSmtWMzQ2K1VXZlMwVlJGZzM5b3lqeEtoNFB0bEhF?=
 =?utf-8?B?RmdxQVBqYU1NR2piVTNxK1JDUUx5VGR0WlZIbVhYZFlKWDRXM2p3WncwZDV4?=
 =?utf-8?B?a3JrdTJrNlJzVU9NczhmYVc4b3g0TDZVUmxBK1pMSTFZa0dXZSs2OWZCK2tV?=
 =?utf-8?B?M2JhTzJrS3JqZGE1RDcvdjNqSElhWFY5TUc0NjlObFJ6Ujk2VUYyZ1ZPY0dT?=
 =?utf-8?B?bitVbTFCV2hBU3QwbEtsMHhjNEZXU3E4NDJCSU9oM1dmQUpzazRMc2JKcENV?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f0b0be-e640-4c68-b086-08dbc5015ed9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:43:08.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf8eAsUsntbNOr90fnxZsWi0ZRp0DczfWg+zUltBUaZlxYKDBZiRxd4fUwpONY5Shkme0NH+UzsvhsALQilmrR2VVgGuiG3AMwMVea1Pfto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 9/28/2023 1:10 AM, Shaopeng Tan (Fujitsu) wrote:
>> On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:

...

>>> +static void run_mbm_test(const char * const *benchmark_cmd, int
>>> +cpu_no) {
>>> +	int res;
>>> +
>>> +	ksft_print_msg("Starting MBM BW change ...\n");
>>> +
>>> +	if (test_prepare())
>>> +		return;
>>>
>>
>> I am not sure about this. With this exit the kselftest machinery is not aware of
>> the test passing or failing. I wonder if there should not rather be a "goto" here
>> that triggers ksft_test_result()? This needs some more thought though. First,
>> with this change test_prepare() officially gains responsibility to determine if a
>> failure is transient (just a single test
>> fails) or permanent (no use trying any other tests if this fails). For the former it
>> would then be up to the caller to call ksft_test_result() and for the latter
>> test_prepare() will call ksft_exit_fail_msg().
>> Second, that SNC warning may be an inconvenience with a new goto. Here it
>> may be ok to print that message before the test failure?
> 
> If a failure may be permanent, it may be best to detect it before running all tests, rather than in test_prepare().
> Now some detections are completed before running all tests. For example:
> 273         if (geteuid() != 0)
> 274                 return ksft_exit_skip("Not running as root. Skipping...\n");
> 275
> 276         if (!check_resctrlfs_support())
> 277                 return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
> 278
> 279         if (umount_resctrlfs())
> 280                 return ksft_exit_skip("resctrl FS unmount failed.\n");
> 

You are correct that the tests should aim to detect as early as possible if
no test has a chance of succeeding. This is covered in the checks you mention.
The purpose of test_prepare()/test_cleanup() pair is to perform actions that
should be done for every test. For example, resctrl is mounted before each
test and unmounted after each test. Since these actions are required to be done
for every test it cannot be a single call before all tests are run.

It may be possible to add a test_prepare() directly followed by a test_cleanup()
before any test is run to be more explicit about early detection but that
does not seem necessary considering the checks would be done anyway when the
first test is run. Even when doing so it would not eliminate the need for 
test_prepare()/test_cleanup() to form part of every test run and needing to exit
if, for example, a previous test triggered a fault preventing resctrl from
being mounted.

Reinette
