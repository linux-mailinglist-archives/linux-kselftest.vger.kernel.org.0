Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06745B2989
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 00:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIHWns (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 18:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiIHWnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 18:43:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBC21203E9;
        Thu,  8 Sep 2022 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662677019; x=1694213019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Va05ChG5ZjCKCcYk80Bz3vN8nPuaH2UUJZxELCg4YL4=;
  b=Zael6o5NA6ZqYNPqC+xTZ0cYVDQlcp7SI0t7RLXnly+F67QVJ7CiwJOo
   xHKwpcnzVRmyVhanci8leFuTm9zwPc/R5V6LYczd1T/VJlszl7hFvf2i/
   u9ajsP8zE3YOQPTGstehAF/5bhEfnenPEdH21t2QA7jO7L+Ba0jLM2Zwr
   akziHS586J2EKonnEWySopggO1SNJXC0GJztIgT2IfXhnbj3RZiP78lPO
   7omByMbXUjoYEgwwIrSsw+vBWNQCyOYKtxlQ3uj1zr9U6LVi6PQxnlYr1
   amqCVp5lwcJeZROF3Oj7otsu1TSWA8gaAaQ0hEdvA0q5WTeDk8nVeQKLL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="294922605"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="294922605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592378776"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2022 15:43:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 15:43:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEo7/VpGYRDVsud78CXLo6Rm41PoSZk5RIhWIiQwRPipXEzu38UClHzD7y4Pl3OL3Sp1qxp3g0sC2hiN7jRQU0TFqOZQSCvlfdK9X4Ec6BxNhAhCmiLY0lCW8+ZPNUag8y55HZAMbi1kIMigQNhCOqI+cqhBMS02Dusq5jq1JA5VYfs7ksQAB8iw5QN7HLDe56WzGS2QQ9Bp0abWNpKPYQn4XZH2X3STRYxFOQHqjnRAdZ49Spu9LfAfVIs2syA46Rh7rZY7eR54wH03/Z4CMjtjF+/1/qvRkm/1KB07EEku2rs8mm8H8c5xSn4WJFQHzvRSghZToPv3uaZyGzjq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5xHWPfNRutIQhRGyRrM+ht7imCnoOlmtGRhHy9CCno=;
 b=fkoBEba9dtKrUX8Vg7SnpjUXZTcUgrcZZTOxZRDczqKFPhN3Q399fE668LO5qhh2sKLN3YuaSQuu2JhCkMAXdm3Q2WC8gOsmoR4V4pSK1MlwCz6ZupEFjyHrgi1AluLtnL8aaiVMSCO6MXVUbEtwPla2pi751r1sN8vBEE7SMyaJydxM39qLGptR54ftgFjfVNwxB6uIV4upok4Pie2truHBUoTu/FWPFZx5g9H6JEJagcNgdILuMtYs0G5zxRKlOb0rFrGFlFOwnOnaHGGdsV8uoGk72E8E69ZIhWloRNxtY+KT3WjivyrtPQczL3j7uCVT+UhhoxMcu4kXKgQ6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 22:43:35 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 22:43:35 +0000
Message-ID: <ef27cb3d-3d60-9be3-e665-0f6d7d02e18f@intel.com>
Date:   Thu, 8 Sep 2022 15:43:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH v2 3/5] selftests/sgx: Use encl->encl_size in sigstruct.c
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-4-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220905020411.17290-4-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84848146-50b9-4a8f-ccaf-08da91eb9032
X-MS-TrafficTypeDiagnostic: DM6PR11MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLd5hguY1K6d/f/w/aE235pPkmfOcAXSAUqyj6JMg+pDZjX5UaUDl1q4HbZWTA0c03dJ4xzLGdgbclZao7jJyVwdlAXrP/fqEHBpj537BtFhMAe6k2yaz+NR90rRFjtG+u+zovEWMocRgGzxyt51X9ExQSwdZKg33wHNSgftDUbSLvb7oCb64Mw5YTXPN5DYY8UYFIcO9AUo0aX4mspaSpJgWw4FhEBAssr5T9L7hdjdHFk1Y+AlSfzKhu5bQfm7UGwZpCKbgAnz2AE7pevu8i4dq8KyaMxtZfFGnLkWgITpl7H+/iye55pVW/DlEv3nJhOLDIBrPKh3xWQWtdQEGTJdxQgOBx1SeLpUHDkJM8Y8cm0vxTv1amziMoX2FSS9G3IT9dk2JqqN1loYhXwsr0hWq7d7gLBCkyRT8eurskwLl2bMf+aSZ1yv5LXTe3qTVpJnFvuOb12Etj7NVHAQRs9OGPH6jf0UFEadop7VUEB+vhNPGG1Q//dYH0I6MYBPeon2cBt5FVe0gpeXlpLopkA4RAjQJYPV/9XOaSh0PKfcRwLQmJgMKbArw/hvClVrYnMQt8fLGf8Y2D+oZOyMw3BaVGFo8xCIWObAaro22aatDVKbvszKt499eEgquolCKbz2VPCv2VhpvK2Vfu1WW5HswnHWRVwHl9gLYdsmvYDKjUzSSsnJ8V8FyIx2/ER/wkHoJvZuxVAn9PnFTUAIKReSEsdqWx3rlh9/0OrsRF8iPBiC+EtZW/OkaMht8/U8UvMS1EGowKWFoUWTyggcrkjyxTz2V4Gs1ejXOXNg2nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(54906003)(478600001)(316002)(6506007)(6512007)(26005)(31696002)(8936002)(36756003)(2906002)(53546011)(5660300002)(4744005)(86362001)(66476007)(66556008)(4326008)(8676002)(83380400001)(31686004)(66946007)(44832011)(186003)(41300700001)(82960400001)(2616005)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRvdkdWM3EvakcvcisxZzB3U3BGVzdNby9yb0poREQvWE5YMkR6UUU1ekVL?=
 =?utf-8?B?QjRNTG1zVHpzSGtJRER6VWxMZ0U2dWNBQzFZSSs5cnNZbG02MGtIemtab1RE?=
 =?utf-8?B?Nnk1aVhvYnA0R0p5L21NdFNmSnBEWHluaXpVSFFqOXBGQU9HU1FyT01mSVdp?=
 =?utf-8?B?a1BvU2dlMUdGMmZFbGZGa0JhRUQ1UTRreFN1WS9mUFp4ZTR3bEFDYjV3cStY?=
 =?utf-8?B?YXZBZU0rY1BNcmlRazJUZ01hRnJvbGdRSytveVpvVWdvZEhtd3NJV3laZlpC?=
 =?utf-8?B?cGgxRjdqQnJhMU50K0YzRVYvRWQwbHpUV0Q5OG9UcS95VC9Bc1NtNldMbE9t?=
 =?utf-8?B?S29PS1E2cGluTHQ4Z2FkRjZNSGhPVFh3S3dlak1QSDdNT0R1eHo0M0JQRGw5?=
 =?utf-8?B?b3R6VVdIQUphWlorci9pcFJEM05lOGZFMTBZeDFRdUNldVU5eVNDSzdTcVhG?=
 =?utf-8?B?UWJ6MU14eXppYS8xWmZFQXhqQzJjWUFXNHdmbDh4M1hsNjlZSFpnTlBQbk5F?=
 =?utf-8?B?VEtsZXl3UTBzMzlEQlZ2Ni9MNG4xTGEyZTRKOHdFYmthbk1VSFhCVDh6RTZi?=
 =?utf-8?B?K3cvMkNKanBLZloyS3ZPSUJLZWtlZ3dhaUt5WUYwYU5tS2tjaHgxV0NwMzRi?=
 =?utf-8?B?bDN2NXVtd0NwY3BKU0oxd08zOEJIMzNBdDgvOGpoWFk4SXZqT2ZUTjQ5ODR1?=
 =?utf-8?B?V1RrM1YwSlhpSW1lU2EvSmNZdzZxWC9tSHRIc2hKRzFESzN0LzAxNFdYOGRU?=
 =?utf-8?B?QjRzYmNkOFBEemVXdlN2VjVBUEdMTFhTeTUxejBydm5OSGlRYjdQSzl1VEFz?=
 =?utf-8?B?N0l0Tk93STlMRm1hT3REQ0VDM2diMUREWW5xcnNPbVhTeXI5bDdBenlKVGxn?=
 =?utf-8?B?Q0ZxZGJXb0ZaUWtKd1N2NmFDb29NUkhUWWJjOG1UMCthaUJYalRyZVJPRERI?=
 =?utf-8?B?dmZicGRJSGxKRE5ONFRUNjNpYXdqTWtSV1V2ZzJSeWpWa3JTT1FFT0RaZVVm?=
 =?utf-8?B?YktZYzk4MVprUzRxaXdORkZuNVJtZjd4RjZtTnh4c1VTMldMbFBvenI2cjNT?=
 =?utf-8?B?ZjRCNXhhMTRGZVdqSVlORHdLRVNFaU1pakg5Nm9pMXpVUlZsNWxVN0oxSjMv?=
 =?utf-8?B?dWtlL3VLUU5VTHdIdXRodGZndEFuSS8wQkZhY0xSWTlGZ1NUb1BlelVISDBh?=
 =?utf-8?B?Tk45YjNrbi93NGUrdnp0ZVYxU2Fyc0FjUlZiejd2WGZtdTMxWlU5aGw0cmVn?=
 =?utf-8?B?SVpRSTZheEtWR3ZCMWdZaEZvSVJONUZCUzBvS3F0RUY4Z2JOK3c1V2hkT3hH?=
 =?utf-8?B?UllUdDJpSWJ1eW5jL1B2T0p2YktGS0Q5Z3cyc0FvZitHZXFzek03eThURUhl?=
 =?utf-8?B?RjlhWTltNXNGbmZRV21BTEJlaXJma3pFRFhMUzBrZVd3SUVOZDluMW53V3FW?=
 =?utf-8?B?aWk4VFJwNkRaSTdmNzRCYmhQcDhlVE5XaUtyZDd1dC9BVmFYNjJneGR3M2tC?=
 =?utf-8?B?L0NBSUFhN1I0TU94OUwvZ0xYRnYzdXFTbjJ4NWZ3SXhBVEVaRVJ4UWZGTmNX?=
 =?utf-8?B?N2RjUXhWQlhWcmJqanJUK3ZlZm0wVVlNUldzS09yS2h0NVl1THo0bzR6NUgv?=
 =?utf-8?B?VWxqbktxRThKZ3NEc0R2YmdPWnZEdTFXc3B6WStJdWppRTZIOWo2alRmNzZG?=
 =?utf-8?B?dXFPME16cm12b0REWFJVRjFQV3pUSkdMOVovNXBjM3h6aTA5Uk1ieUtTY1lL?=
 =?utf-8?B?TE5hbXdqYlJMVFZDaVREM1h5STNkNlVzRUdyZU5tZDh2R1JzemdPam1TOHg3?=
 =?utf-8?B?NWZEUDlib0MwNFVaK3pjek5Zd0xpbUh4cFBmQWFvS3hWSzdiendDUmZaczYr?=
 =?utf-8?B?bHhFdWFpMGV6SWpLQ1EvNXdDV0ZXeDFtc3BxcXFUZWg3eXBxeHBhSWZTY29o?=
 =?utf-8?B?Zmc1OERHcjFiVUlFRS9Md3dMRTZQNGcvc0o2OCs2RG94UFJWY2FZV1V4Njlq?=
 =?utf-8?B?TXpOWjJoNjM4RmRXdGtBOXd4RmhqSjBxSmY3TzVwbVJ5Z3FITjZpVWU0SUl5?=
 =?utf-8?B?b05vUVZYNmdFRk0rSFJBSUVIdFBZdzM0TlRUMTRLLzk2Y1UrTkgvMGVGNG9q?=
 =?utf-8?B?dFRNSW1mMElBK0JWa3B2NG0zNGcwZTQ0SUFQV1poL2Era2Facnl3V3RIVG9s?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84848146-50b9-4a8f-ccaf-08da91eb9032
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:43:35.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU3J1znroBKnQLN1TN4bYEAFjTyP7wu8kPueMvjRrA9BpGVaEHwi5R/GC1sJVB7C7748mrS3ygHZBHOrimytb2jWD9kO3v8mS2wQpmbWYh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> The final enclave address range (referred as ELRANGE in Intel SDM)
> calculation is a reminiscent of signing tool being a separate command-line
> utility, and sigstruct being produced during the compilation. Given that
> nowadays the sigstruct is calculated on-fly, use the readily calculated
> encl->encl_size instead, in order to remove duplicate code.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
