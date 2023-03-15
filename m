Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1416BC1F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCOX7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCOX7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:59:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900D1FC3;
        Wed, 15 Mar 2023 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678924783; x=1710460783;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+qd8bA/4V/pc6/XrWhzeEhLSaP1ytFJbdPenDTdPs+E=;
  b=ThjpB/Y2gOcyuFRl7+nWXMNewaGMve3Hs7jeTiNxZ+w0uU0MmyFWg2wn
   pOBJ9dKynK6citVLdlsR69zQnrIS3nTAYFDKlxvUPWoIdfi3S9TbSqwaA
   PU7vlZhGFLxtxDOKU4Gzc6k755hi7Q6e1cwqrndRlrseLADPOveLw0Xh8
   BKq2S8gX4QUVaujjYSrityi+pxZwovVzEwUYaEr1izCszoTsHGgBWg1+p
   j52aWyKadw4iPNCh0pTPNWRXI6rJSaQo7RudJ4WQFK6vU08YYqCVHzpRy
   O4nfWbPsiGljIUlwyqqg1v4tBo9QuazUEptJa75QcK1tElPASaoFoe4Tl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321688864"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321688864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="853794542"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="853794542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2023 16:59:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 16:59:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 16:59:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 16:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkYJnr6RXJfj267i4wV/TiqcBE3uJTHs9rroj7Q7KaRClbVVfl+iad/u/DwNFjbBIoft6S0NN1TiSIss10E+O39bSxUT7gH1DhBumtF82pJ3WiyC0oW41TBLzUBYc8BLZIDgrO2rGXpBNSJ5sQGR3Ey50Um77ecIZ516XWHZa4FyOCMwRRXr+Xtn7f1Djion3sbMnXytBYmr+awQhHWE6XRdp/5KhOoVwnhmT8z6UDRCpYhFlsJ45B/b6t/cX4xTDtnFh/bvMu04zApJiBe/MbIJzRt1JL5pxcJhY4hMWV8CeL8PxRlly0YeZ0BPmhe+4mD1t3p2lR7Wa21PaGpGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMQ0S3qIX0m6jNMdq82+4dYH3hyZhIw8feb/m9XGFRU=;
 b=PM9CX9cCvbSRG4PmiFnb2DmytQplE9Hma97E0SCk1l0ytayj5fZNHNs7R+84hsj3tAXW7CUASkuKY06zVpjxOiMzTfTcxpRRUg2B0DMbGaXYOJ/a1nLiDr4EwDy/fCx3pLefSqJroD5xvjXhuGGLulAI6ULN+3+xk8P2rU3QXUk8KnhsfewiZTed9DIf2pEI+3OEZaiXijnh94OZGgA8iSFUxcrGEn0oCFrmJioaC5N4/yBv/al5tdHdSnuTTeCQI7JvM1V3qV1cMScIRshEkxAsOk0rQDPiuOxH6mVWWWiegQZiObIH3p6Z9lOcN9z7hrsYpwFRVptLPSaGhVLs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 23:59:40 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Wed, 15 Mar
 2023 23:59:40 +0000
Message-ID: <5c160cba-4104-996f-04bc-df2a59acf7ea@intel.com>
Date:   Wed, 15 Mar 2023 16:59:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/9] selftests/resctrl: Return NULL if
 malloc_and_init_memory() did not alloc mem
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 57feb5b0-ceee-4349-2049-08db25b1571b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uu7pfxRbHjSGTOYBroRYqb6y0blBSi2Xbm5RNEHAauy96REs6eHa6ztSLQVoQKiQZCiL2iDU7bPNOxwCodJeABpTTGQSoLFMmKCMmRCmdIT+IWX5QY72nZuN1ZG/A1yW3OwUJTSjvdhV40fwdb6nOkRLfRw5nzu2JxOLf4HvLRwTdeB6TXXjdjSO2iMTNOD9o+NiTeZsB0H+xq72RvjyJneM6/B/hYbgQaPhtZKau5xBhlw4dpuENrKyw6EaHyTmZmVf7+hWRwwpqGg201mWR7IXCxXqLIgiSqzr10qu6Qz3aTTnE4vvEF7xEmvIkwlslTVNrVHMcjjgFNGhGT5wXXJNflUp4TFiZ/qa/0AJhR81cQkWxOBahaVbs/m3Y3xUgSHH6l+GwA4isAgSqx0ksZDvJXH+HPZLUxrDJfYvcJBdRuoby/9Ex4wn5njXCCQNHc7UaTfppXYtjwK73GEHfvocNBZI4uqztR5z4tXkAzQUCZa4YPv8ACB5aSxAYGDfjfqahIdIgbutG8vOUnedMjynb7akz5ta9iX1Et4de7ky8e6Sm/RoYv5p9YYJCi2SvL3EZlS75q60ePFN0xgNZNDYCNNiuVWOOluzRx5aqP69CqxUDzcQvWrpE4Tlg77xO9bwn6rVRGFSNZ+23p64kMI0sNk8RmOEJcQygv753cP+zjOjPFuu+pZxYNhlHIIMvdGHi2sR7OoO8whX8M2INmmeKFWtJs2TUKBKKVzVRg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(31686004)(41300700001)(8936002)(5660300002)(44832011)(38100700002)(31696002)(36756003)(86362001)(4744005)(82960400001)(2906002)(478600001)(6486002)(66476007)(66556008)(8676002)(66946007)(2616005)(83380400001)(110136005)(316002)(6512007)(186003)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFVGMUREUFd1MlVHUkEwWDdNZzJDcDVBU2wrYXlkcGVsOWRQN2h2MC95Ni9S?=
 =?utf-8?B?VU1xUGpWTUhHWnpiWnJseGlmZmRNT1VmR2JjY3RZTEU5SmtZa3FYbFYxZTBL?=
 =?utf-8?B?bXVpdEdCalZia2xEWTlMWUJ6cWVzcXlQb3VDZ1ljcjkxY0llWmUvTzB0cDFx?=
 =?utf-8?B?bk9WajlZSHVVbVd5Yzg1bWdicjdhRm9URmNoYVVhWDl0ME5PbHZPckxOWUg2?=
 =?utf-8?B?QzltVm1YRnZaSnE1ajVZL3dwbkpKRzJlMUs2M1I2RHUvMXFHN3dTenFJNWl2?=
 =?utf-8?B?RHJhSVZTNHFuR1UxRWlya2htNTY4RTRBaVk0QWVCbEZqV29ya3o3VDdETXhl?=
 =?utf-8?B?RExYRGFpOTZhU3lJbHdOYXhzd0tnRlN2OGd3L3FMVVhzR2xTeFV1d0QyRUlI?=
 =?utf-8?B?SnUyMlRFNXQwd2hJSHB2ZnVSayt2MzBESDJIK2ZmWGx2Y3lWMFdlbnFWZzdQ?=
 =?utf-8?B?ZmJCUDN5MXV2ZTRFR1hWUVVUTWlyQjBPZWxJcXY0YXVBWjFoRFpDLzdWY2dR?=
 =?utf-8?B?Tk1UT25PQUYxbk9jVTg3UWh3L2pHY211c1NaVk42aDlTb0RoVWZ2c1dWWHA4?=
 =?utf-8?B?dWNON3I4ZkpCOHhMbXRLajJEc09FWWd0ZHM0QXlOdUxncWhLTC9UdEJJOE80?=
 =?utf-8?B?TDk0SXcveDNJOXRSak9CV1FjTmVVcFh1ai9sUWF0RjN3SGZQL1hxQ0k4QlV0?=
 =?utf-8?B?Qm1GWWp4RWIwcGNwemc4dmxxdUFEeG1nalVJMzczbEJNUHNCRkl6Vk5mSTUx?=
 =?utf-8?B?TVJ0QUNWVW5qVDdmMms0eGlIYnV5YUlEWGl0aUVwMkpsdmFQWEhGdWl6TW91?=
 =?utf-8?B?aGt1K0IzeittSG5HcVE5VWNPU2Y2dlVvdEtqQ1BoNnFWN0plUWFNaytjNWFW?=
 =?utf-8?B?bEN1RlV0N1d4YWFEYUdjU1lRVVdTYTVHdmNtV2ZUWForWFFKVzRwd2hFQVg1?=
 =?utf-8?B?aFV4UWE1MGt5dFF4ZkZnUTVMWWw2dnFOV3V0N3pLZ2VoQXpYQ0xxbXFSM0Fs?=
 =?utf-8?B?SFdSMjRMcjN6WEhhZjdieUMxVU1kSkg0RW4rODNsUzlIbEJDRjZxT1FiYlp3?=
 =?utf-8?B?RGhuWWJteVphTTFRTWJlbkNzQ0ZidEhvU1JZVjBQdEZJOEdjQjhDeFMwaGQ5?=
 =?utf-8?B?RFhJakprbDJsOWVmTWROcHFYUi8xYTREeUdWWkxkZVhpU2Q2L3B1M3pkc2sy?=
 =?utf-8?B?OHh5cGNDeGJDRFMrUHhINGQ4MGl2bVd2TXoxOC8yTDhENzJMdUVWN3BjMVZE?=
 =?utf-8?B?dGVKT1U2K2pZS0VMNXJWQ2wxOUphVU5xQU85V3RzdU9RQzNmRXh4c0J5VjdG?=
 =?utf-8?B?TjErMTVyUG9nK0xjNUVrUU9Hb0trNldYcWJNK2ZYUW1MaWNuRTl1NHhSSTVa?=
 =?utf-8?B?YnNhTExvc01iQkxYeEtpaGFUWlhKenlLNjFtYUllOGhnNEZ6SzVFdlBPS000?=
 =?utf-8?B?OXo5NjR1TWp5azQ2Sm1UOUJMUVdPOEhRVXBYWVJPbUZBeFVpazliWHZ4czVx?=
 =?utf-8?B?REVzSDlONUh6cnJlMzdWblRFak54U2FLL1FOWHloaGROSHBiS012UHV4bzQ4?=
 =?utf-8?B?S3FjRlI0dnRiRmxPcDVSYy92RXMyaC9xc3VKWVBNMExIWkRwanZRc0dxMW1J?=
 =?utf-8?B?K29jZ281cjdiV25LOVl5cEtnWEFSM1ZMR3RWLzAwa3d3YzR4M2lOUjZFdCtX?=
 =?utf-8?B?N1dHRERObXRGYXhWWEFnc3R3WktWQ1hUcnFnbEs1RzJYMHlQb2liL2tMN1ZK?=
 =?utf-8?B?am1lTVo0YTBLQkkrazNoaS9RZmIveERydDVDRmY5TmZuZFFIMXRlZCtldlVY?=
 =?utf-8?B?TnFETzJRbHRzRElMTU1MaDNBVTVGazlJZUxRRUVVcXNRMmQ5VnZJYi91Mmcz?=
 =?utf-8?B?a3lIVC9RVGEvVTBySjlpVFBnKyt0OUpuUVA3WEcwOGw5ZmFpSUFxVDV1R3A1?=
 =?utf-8?B?WXF6Mk5FUmNmNUpFWUoycy9jazV0ZDV5VERnTG1RQVpnY051dFR6aG1vRG1V?=
 =?utf-8?B?UTFLNjRKQzFrODZnditxS3NhQnl6UjVWMEVJQVE5L0VCRUsrRmMvOFNiU0Zn?=
 =?utf-8?B?azFCTllaTW9zakJCc2N3NXovUHpqa0dJeHRkL0tCTEQ3RjMrejV2OG15dVVr?=
 =?utf-8?B?em1yTWFpbHd2WWJvTThhZEUvNUVOb3RCcEdGd1p5NGxRN0YvVnlvN0hiemRu?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57feb5b0-ceee-4349-2049-08db25b1571b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 23:59:40.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx2cBC6HTusZh5Mrkv6KRQE1e27MC8lsBRSRgiIxIkSeKTzWvHJiVMkcDxHRXp8wd2Ye2KdroWDXOJcCp0zlVdm5qsRGe1PJrrVeJk6pTPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:05 AM, Ilpo Järvinen wrote:
> malloc_and_init_memory() in fill_buf isn't checking if memalign()
> successfully allocated memory or not before accessing the memory.
> 
> Check the return value of memalign() and return NULL if allocating
> aligned memory fails.
> 
> Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
