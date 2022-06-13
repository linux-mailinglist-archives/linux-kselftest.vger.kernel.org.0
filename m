Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0558B54A21B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 00:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiFMWbO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiFMWbN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 18:31:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E392E2DD57;
        Mon, 13 Jun 2022 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655159472; x=1686695472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gmHIguPy4DiifgnlaXt5AfB2LuiSyjaoiO8tgQ9BOtE=;
  b=QOVPgT/razEQAHXRcn4mQGL3ZN/c6iyewTx+o523Wvxu1t4xbzUcDAZ/
   YrDiti9p+qUSw32cEapg8w3n8L8AAhe9+8n69vGBfANVSou0yhaPSCX5u
   iW5xBGd/E1h5oYbjUoUsbw2FKBtB5dzfN6ByEfhq1ROL0NX35tS0xclTD
   LWhdAjKCxI83ydVxiKMGBHXpGigdQ9ldM/8IklyESF7RTQ4+JGHa860xw
   GnVjL00yx/SZL2S8NGyB7bKPDbakaIf9G7B1k0buxppbgyrtAWjnN9CMy
   W9bR4Du7+6ExH5hf4P2ug4BzObD+yPTBibyWY5cPf+UWPE32wpcMSrO1g
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364760155"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="364760155"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 15:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="611969499"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2022 15:31:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 15:31:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 15:31:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 15:31:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 15:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOka7kLi4SAZGlXk6612TGczQ1m9rkX/d92W5U+iOc/O20k1ZLXCmC+B/vCTaRFU9fTqJDX1kJP4ZUg2lPRcRwRZu0AJz8sX766Utpv3Z6+n2fGD39qzVTKbUHO4Gqs0f9Sf4sciPSgKTZe7hGtxxlyu6P/4jHCRoHb7ZpjazVBw5bYIruqEKAV4gfwWMfDnjked6NjtQJLjeR1t1XYAiU78Uvwpt46VGpBdsF3C/PDCSzma9ZEaXe16p/UX/1Y2o/DGtNxRTao2/tzXFd5Qbg1YuMb2ibWj8OBpoABPyVXSVIq6hBgaG47Gfy99lDOpX8DQsHe3g9u8r0Onr1h9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA4UuR4f/tdPKa3ZgKOJbmKLNcZlREb2EYb6NpWeQtE=;
 b=OR64XOvVA+otXKNhZA9AFAvyIg+RPPSjGXRIgHV6x51qOM3gmV4kMf+3x9cFifwanJ8aQKspq+frpk57KzKt75otPKojWGWTncuuNGvxKjc8dSTYyXSL4quW/ETQZjRfZCxrHEShLeZmDj3gzE8ANNMeW4wsbpp0tJ2+EoG6AF8KSbH1v9aPmZFfqOnWOlM4wt9ZYc/XdRt5WSmoDybB0FliNt4f58ZPLp5Kr0rhXF7T+fjeIoiRnbo58O/Z91UF7UwqIw35ofkqp/cdXbYGeV5iaYbSNDlclO56tqBXZGIixD8e0gCp7nVF8urgwJcdjwj4hkTaYEHnx1luZHjbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 22:31:04 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:31:04 +0000
Message-ID: <951dc92e-b4fe-71fb-4601-d9df1319a9ca@intel.com>
Date:   Mon, 13 Jun 2022 15:31:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/6] testing/pkeys: Add command line options
Content-Language: en-US
To:     <ira.weiny@intel.com>, <linux-api@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        <x86@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-2-ira.weiny@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20220610233533.3649584-2-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::18) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5184f1c3-ceac-4e94-9708-08da4d8c6701
X-MS-TrafficTypeDiagnostic: DM4PR11MB6480:EE_
X-Microsoft-Antispam-PRVS: <DM4PR11MB6480209C043A0CDEEED84730E5AB9@DM4PR11MB6480.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kC1DU7Nc730aiGEcrmSutAEPwD25ULValxQtCfBrUvHTFkze9Np+vpzP8bQGPGB6P9zU1mXW+cSO+M2hTDneSAfUGiA52yueMRYerpgTKGSGosz1/b9kOiAiDxk02yR3G0aIQtwBHTx9tHd5KCR1i8GnIH8EIEayXz/fD6by7nfWqvvObb7HM2ECkklDCuQ2rVN2X0mGCpp1EiNRO7T7HaVmK8I2JjulDD+ESTlO0N90gHlpo5Yv51AjD6Q6NQG09lhXToum1zARtlrsbhxH+GKO95nukXBm+haXfTcI2DOWYfNiOzd3m/tL1cz2o54gBKaaDEpoW8PCtmCGd6CCEzq2ULvBKKVKrJrvcO0nfE5uWXZeqdSOCsKNtF49b6Xsj3Pi51VZ7Pv9hInqiwjKx3qcU3cmCsoECh5b3J0hnhMR0tBgurndxXwBSDb4fO6A5aP75pmVxFYEyOfGFUWdwPFh79hki5YVf8x4giZgEV+PAIrfimnj4rhd7yiDX8M9YzUZzBXrUP0ZvupIbe25yrKOt/1xCpC9XZuwp0MJJtUWA3FMKcjcMHIA30VIDKhLbwrt5NC6paj45E1lOVY1R4bAtWqqi2e3Oz2+lPlRiXKo2e9wzn1HfBBCz953SdXS4A2LQsqsJPfR7GOzh9o5eLh1uh8J00ZHS2Te9kPIGwV+mYDPxtjMRmcRI1nkukLFomqz4oryOCJcxwW4ItaB0IrSNPS79EJkbbbfcO9364CNcoXpPFVVpWgYwgWzusQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(82960400001)(6506007)(31696002)(53546011)(5660300002)(4744005)(66946007)(66556008)(8936002)(31686004)(2616005)(186003)(36756003)(38100700002)(66476007)(508600001)(4326008)(8676002)(44832011)(316002)(6486002)(6512007)(2906002)(86362001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXVRc2FEMzU4ZFgyNnY2Zzg1ZmxDZEZ1M0dvUlZNTmQ5eVpuaWRZREtQbGtx?=
 =?utf-8?B?cmZPNGtOWm8vc0NzR0JIT3dydDBEdk1EMUpiU3FKOEt2ZmdmbUg1ZjlxMi9m?=
 =?utf-8?B?WGN3VmFPMDQrTHBKT3MvN3V2ZGlhaVIwbnhRS2RpL2NJUjhmeHUrRk1EWFNF?=
 =?utf-8?B?VzR4WWtqbDIrTFVScnM2V1RRZ1NZYk1aeVEvcDI5NVMxV1doVkFUQko1L1dy?=
 =?utf-8?B?Q1lNZGJXWElQWWV5aGo4eFBWVHVkWitLbE1oQ3JDbjhsSGNSbDhvWFQ5QWEr?=
 =?utf-8?B?c2M2R3kwVi9KeW5mUXIwNUIzN29yYWUxeUpUcDErWUFhZU1wZDJCSFNlRVVm?=
 =?utf-8?B?TDFWNXFIcTkzcDdTRjVQZE9uM0IyS205UUdXZG1DckxTK2t2ZDNWd0EwaHNH?=
 =?utf-8?B?bHFVYWh5bzJWRnZId0NmK1AzU3JaMlY2RVVKdEtldk5mblBZN2FlaUtCcElM?=
 =?utf-8?B?VzlPSjhXTlVLMTk2K2dzWFc3QldxL2pJRDRIb29DOWVrWjREQnh4TE9xMHk2?=
 =?utf-8?B?NGhQOWFwMXpnN0xMeXBxVVlRME44RWpMVGt0Y0hlMytTZkV1RXFwWmpZczFk?=
 =?utf-8?B?ZE9aMWJPM1I5cTlhRHJyQUtZOHFnVkFkU1BwdVZSakh3T05odUQ5N0tCWWpk?=
 =?utf-8?B?TllsSlZzbWEvT0FUMHUydTFVNDFvaG9GNG5CY2JJNWl2aXF1RVZ1V0RqRE1T?=
 =?utf-8?B?S21LYWxXS09hUzFOR25NUjFKSmRFbG8xNDd2NEhDWEsrQTZsRjlFWkYrc0xN?=
 =?utf-8?B?NDBKeHp3TVNWUmFRMmVBdnBNd3FZUjNBQ3VVZzdDYmtPSW9hc0dsZGZhdFg4?=
 =?utf-8?B?TVBSWE10UzR2WmJSYWR3NGhVUUhrS1VodWpMYWt5cUxVZ3hjNDNGZVo5aXFz?=
 =?utf-8?B?RERoZ2VJNDBzSUpUOWlucG1kN2w2bXJtTmdQRDB1Y3Y3SmZmSUQza1hBMEsx?=
 =?utf-8?B?YmhDOFlrS212TVJLYzVBM2k4T2RxK0hFSFlWVnVrTVJlVU9nRHdYczdFbTdw?=
 =?utf-8?B?cVdJSzdkTWZ6aW1Wckx3SHpOUkg2MmhycmIrZmNDcnFWUFdXVDBlekNUOFMv?=
 =?utf-8?B?Z2VuNXorV20wV0NlTkpMM3o4dkh4OGFMSXBDSXVDay9nQVNyMW5qZTVnTzNK?=
 =?utf-8?B?S1B2cHVTNEpkKzNPaTRDQkZwQ09OWWtWWUpFQ2Jzc0sydHhLbllhTHpXUDR4?=
 =?utf-8?B?cEh3UUhBS3Fpd0U1ZGROL0tRWXN5ZmNKNXZjbjhDT3hQTHVkclgxZkQyYlA4?=
 =?utf-8?B?WWl6dHV1YktKSnN6a1YwWnZQaklESEZpZUFZR1NLZWM0UkV0Mkx2bHFVRktO?=
 =?utf-8?B?MlkxakVCZU5qYmdLbC9rTlZUWXl2ZHZCMlFOcFkwRklONlc1UUFQQVBNQ0FO?=
 =?utf-8?B?cGRFVW5VZ1R2cmMyNW80ck5MNlFReDJSSldBeGgxQU1JUGxBN3ZoZHd3cG1u?=
 =?utf-8?B?L05BRFB6czQvRkh0MVhkKzh3YVJ4a3ZSWXZ0MGhxVU94M3VlUkN4cDZORmlk?=
 =?utf-8?B?aGFMRHYwTk55eGZuWjF3b0F0UTNuemZpUExDd3FVb1dYd2dBbnJRYTMzcTM3?=
 =?utf-8?B?OFQ4T09tUmUrT3p4L3ZXK1R1dzNVTm81R3pxSXMvTzc2MjJtWGZMVnA2QS9J?=
 =?utf-8?B?VVp2dWJObGhBRzRGNGVJUEsybWQ3ZmRYNFRTcEtia2gyK0hpZ093RWVQRlRD?=
 =?utf-8?B?ZHdKU2hEWDBkMGlZQXB2NWlQYXlsR21pS3lMbSt5M1JDUS9ZVmsxUmMrSi9V?=
 =?utf-8?B?bFovMWVHRDhzSWlRWGR0Z3paZzlBbmZRKzYvSTRTenpQZmJpd21WQmhacmRh?=
 =?utf-8?B?Sm40MDRhRS9oUllUakJqU3JGYndBT2xzMWNMQWwxSzFYaTV6MnF0RkRSNVhO?=
 =?utf-8?B?eHFzZHlaWmc5cFV5VnlwSFdsMDNDYlU5M2VzWUI2aFdaWnUzK1N0Um9SQ0hv?=
 =?utf-8?B?SWhnUFMxa3NjVGFEQW5mQm1jeFB6enpWZjFzMGpsc0N5NFFEVFdCVzVmY1Av?=
 =?utf-8?B?UEJTenZITXMzbjdHenp5SVRkYys1dFVmMnNYZngyYndqZzdVNjE3NE45TDN6?=
 =?utf-8?B?cHcxb25jY2JmemNhZmJXbzNjTk5wSjZ3WWhVNGtOSC9ZdkIrb2dYMFEwMmdK?=
 =?utf-8?B?S1Z1R2JwTU54ZDN2S21XdndkeUxrNVg2RzBPU3ppNm1iMWIwQ2FkVVdRSElF?=
 =?utf-8?B?Vk5MLzRKMC94ME9jd1ZkYnp2bFhna0wxMi82SzBhandkSkNlWGNlZCtGWG9U?=
 =?utf-8?B?Skx1WFFTMThFaW5mSkVTa1hsOUpUWitBaVJ3Y2pxUVhNTXhCRjlYQTM4dUVM?=
 =?utf-8?B?R2pOYzFMcjZxYTBOdW94TmtlTUs3clU3L2FjOW9xRytNb3pINEpobHFMeWtl?=
 =?utf-8?Q?NkvORtaN5KQJ7btw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5184f1c3-ceac-4e94-9708-08da4d8c6701
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:31:04.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1ZVlt9mQIu6mh3KpvtGbtWRP1AWXSvFOnK71QLkkESC6TZP05V/DGQR/umVNEY08SwTJvsXUuO0OZ3vsBY+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/2022 4:35 PM, ira.weiny@intel.com wrote:

> Add command line options for debug level and number of iterations.
> 
> $ ./protection_keys_64 -h
> Usage: ./protection_keys_64 [-h,-d,-i <iter>]
>          --help,-h   This help
> 	--debug,-d  Increase debug level for each -d

Is this mechanism (of counting d's) commonplace in other selftests as 
well? Looking at the test code for pkeys the debug levels run from 1-5. 
That feels like quite a few d's to input :)

Would it be easier to input the number in the command line directly?

Either way it would be useful to know the debug range in the help.
Maybe something like:
	--debug,-d  Increase debug level for each -d (1-5)

The patch seems fine to me otherwise.

> 	--iterations,-i <iter>  repeate test <iter> times
> 		default: 22
> 

Thanks,
Sohil
