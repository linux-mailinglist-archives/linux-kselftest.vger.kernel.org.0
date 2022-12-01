Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF71263E7F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 03:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLACiF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 21:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLACiE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 21:38:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D4156EC9;
        Wed, 30 Nov 2022 18:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669862283; x=1701398283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZhWR3CnawpgZDmSvlSgdVxpZ73NMpH+njcp78v29eo=;
  b=VRcUgfeoxBucMl5f9gURuA8iYPrEexR2X/nfPRjhWGplaby05Pg2RF7R
   G9GVDg5MQsO0LK9fU8gIBE4R9TPezg+Ka8KhacvkYYkfgkHzL3Ps9oe2q
   FkR87Vgo8TBdyL6lQHjeLkqevVbPQoxNgsnFQlkCw943PYzqkhQN2OeFG
   W8Hk/qT0zKjRVc64/iMQKcOsrd41fIF+pG+SoA39KS4hSZxFjULtrgij8
   wRlRZocWiTXKWKFCOaO4OuINDW6T/1fgyge5yjKvTy/KrUG9kif5WtnI/
   HD2pchfxyBiSD6grFIbVfddvS3tW7YhOhugy7Lh7q14njTDFEwvAq+4bm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295259995"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="295259995"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 18:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769063560"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="769063560"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2022 18:38:02 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 18:38:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 18:38:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 18:38:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zocikcm3NNbC5xy9M6B9YkRFUBk3pJkEoVA9zX3E3MqUti3JiDfOzfI3Z+FoDB3tl7fmZEszKxiQ0H0Ullxa5BAQWEH8aUtvSCERTXpZdz74CPFlghOc27/HLfraOkgv5mGBDd3TPzn9QGiFq5KMwFCayL5GZQEdz+T8ZSjbyMlz3Jd+QgQhf6yw3DRI/3tgA79BtjurwyhwK02+foMlI9EmDqS+ffb0REp3ydu/FIhp6f8P6Qd2APA7xlSc4HFn+5LCHcQM1aT92662cJUKrIPS2Y/W17WsGZ8MkDvXRrYHRTb5EhamHShoFL+2f/CSZRgjJ3Rdn9K4+yq5OdBgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llXYG1FaNJE4rRz96l27uFHJcXmtTPYdJnFK7qWoplM=;
 b=Ylb9RPDjOyi3sqOh2yk2V5youuaoXSXxeU+P9iSbBA0MdcUkbHMg/dPUXQXKdzAfUntXoOLigd3Puq/tvOZII8OjHMIywav4CVyHCY56NncDe0DIXsEF6mnlqZUSV3ke9uI3yKsnZPh0k9ABbYAo3kDP8EHxBAYYtlCYkOlTZPCIzjlj1ttbCcCAXECw2fnOyhs+oPObp/SZwBgwAzHJ2zI/itkXk01TldZDZzJhQv/1p/R/M8CbbsH9mKygkU1KIIhoR0nRLvedAiqJLXHBpk4+fAjryZ8vQ6L0Ll8qGmeGWi7IhzUVrIIog0JqQ8KBAFRlrmqtpODa9/pWeYkmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 02:37:59 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 02:37:58 +0000
Message-ID: <57b8f45b-da8c-e9ae-6b3f-ba82f936c9b2@intel.com>
Date:   Wed, 30 Nov 2022 18:37:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: fw_fallback.sh test failed in Debian 11
Content-Language: en-US
To:     "Zhou, Jie2X" <jie2x.zhou@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
 <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
 <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
 <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <217b7959-facc-1028-19be-1040898a705c@intel.com>
 <CY4PR11MB13206A6918FFDEB5B3D3794BC5149@CY4PR11MB1320.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <CY4PR11MB13206A6918FFDEB5B3D3794BC5149@CY4PR11MB1320.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|SJ0PR11MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e3028e-f15b-42a2-f6db-08dad3450e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEmye7ESsXc4LqLdQRgM9robsii1/6GOaN6uDCceGHfd1G1Y2DpAHgA3ejkNExoZptxvWT2VpoocDwDxM/+biAtqa3VKd++5lhg9iak7NDS4MOXIy3VT2TQoGqtfWSzbh7T2I2njSATEG6XS73hEc92/dYcliYpX6f+GYd2jGtBB80Xjum0jLDrqfBUEZonmNv6GDH2rC6FxQMB9PybwR8ZQ+UpC+lHz9TZbSbRITgxNJo/iRY3zOjGsB4oles4q9YhfsJQ9r//EYMRZLwbrdqo1FrTrif3UMfIrpYyFMTN8KHvEvsxm/fDDjxJRnpoOTcrzhBpO2WQWMoUga2MDqrUxePCqSjUXZ3ysV/MXbFF6SZ1AQphAh1iB8r1/LjDkIGq610SWqfkqk2bV+FS9xke+hkhMxoSc4GLwtJJgUuA1O7xdr64euSVSZ41UYkw+Qgr6pzQp+HL/93w7EqPcuOCNfu6yeAJeNuQRzgSMxACwBCcWx1GJxdhVxv9yaExOtRp2z4GBE8+MMxiCLxzT2hwv4FWoExpiglS3zzhojx0x2m1O5pRasdcOGZMcWsJ4djkOiiVLXBRRBr6HjgTB2gJTeFWzlTb9AQ5SRr0aJPjqtI5DZIIZkRV70WDr0ZZbjfbhov/Q0D30uDodq/ozcJF8rRISuW++ujBFcp3rMhv9WJwsdsReyqgmlb63yq1eDtug61gircMJBdjnJG5dOQI+98JJhOLcxtJPTHuDQH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(31696002)(6506007)(478600001)(86362001)(31686004)(107886003)(53546011)(6486002)(6666004)(83380400001)(8936002)(316002)(41300700001)(82960400001)(110136005)(2616005)(5660300002)(54906003)(2906002)(38100700002)(6512007)(26005)(186003)(4326008)(8676002)(66476007)(66946007)(66556008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk00NHlHZnY2NVE0aUsyTW5EZ2IxWVNCbVk0TWlWa2lXMlN4UDRmUTRDZTUz?=
 =?utf-8?B?d04xcHg3Q0xxMjl4cGVyMlRjYTZZYzZGYWpwc3c5akdwdDZKeS95aXFSOGFy?=
 =?utf-8?B?ajFhWE1maSsyaWt5TkhiMGwvb01vOEM2QjhPUjlFUDd6VFpJSy9NN2RuL005?=
 =?utf-8?B?OUdqcW1tNU9reThIZzVYNjFHVDRQdFpYa2NUNm9nSWJSeGNpbDdiWUE3MlZK?=
 =?utf-8?B?TGRVajRmUWRMdnUxaWlWUVlqMnpkWmY0OWM5TGxBb1NteEY5TjBtOXA0UFkv?=
 =?utf-8?B?bGFpZ29yazY5UUdocld1ZmFaZUVIUHFPdFBJeElUVi9vemVGSWVENGs3WGNa?=
 =?utf-8?B?b3NxRGp1NEZsa2s3cHBWR3UxSW9qRTJDT1ZycEs0eUpNRHQxTGhsdkN6QUhz?=
 =?utf-8?B?UFlhZzhtN0dLSWRUS2JuVFdGTFpLUzVqSlJnZWtzd1JnTm95ZUhhRmp6bzFl?=
 =?utf-8?B?bGlEaXFlRFRxaGFodmorMjRBV1ZjVkhoN3BqdDcvSWd1blYzSzRuREE1cGEx?=
 =?utf-8?B?ZDA5cnRhTUUwN1JNbmx2K2ZwaDlFcHJVdWo4TlJURVV3NG1lUUZwc3JrT1VH?=
 =?utf-8?B?d1N6VS8yYmxtTXRuSEVWdHJ2YkFaL2xZYW8za0o1RUFvYmx4L1JhWEhzQmd5?=
 =?utf-8?B?eHgzOHZuZ2c4WTZhQnN4MTYvclF2WGdYSW9YRWduMkl4K1hJOGtMaGdiQjBT?=
 =?utf-8?B?aEU4ekRxNExUYjV1dWVaQmdab2dwVXFTb2pHZWRDOVBZOHBkWm9GVkJCMkFu?=
 =?utf-8?B?WWZXZXFuVmNIb2Zwcm1zNGpJL1M5M0JLVDNFWGJCWTBqV3kwTkR2R0owajl3?=
 =?utf-8?B?QkhvWC90b3ZLbnl5WUJ0UW00ZXRHbHlnV3ZDb1orT2ZwYnBmZEZkMUQzUy9G?=
 =?utf-8?B?VWlLVEd2c1FWVUhKWTF5Z09LZ2E2bmNVS1dPa3BhekRuN1QzbnVFZkVZWi9t?=
 =?utf-8?B?WVVMSmZGd2ZLNnFZUjhCVGg1Y3lKU2pzN2szbGV5TmR0dnZVbmJwM0dCK0Vo?=
 =?utf-8?B?Yk9jOFgzZHFQcGYwajBRazNxT1hGQnpBSm51Q2hjQ1UxZGdOb2xqUkl6YWdu?=
 =?utf-8?B?SEVrTllxY0xWbEdCN01Xa043S0NnYmNlcmNFNVExVXZWWnhkM2N2NG45QTJC?=
 =?utf-8?B?SHUxTWU0UWpyQlZoUXZCUFU0blQzSXE3bHlKNzMrd2hGa3NTTTgyVkc4VHlQ?=
 =?utf-8?B?V1Z1WDJ1Wm9KY0ltRkJ1MGxSbno4aVlxSEh6MFhOUVRJUkNjQmZyU0c4VlNs?=
 =?utf-8?B?ZUx6ZTluVzlTZFF6azRFOVRwYWl0THBNaU1WOVFVdEdJMmdVL09FQytIRFVP?=
 =?utf-8?B?TGVqYzBvdnJrU0YxR1lIeVBTU1cyUkp4YmlXQmtGbFN3cVJkT2JHTC84RkJh?=
 =?utf-8?B?TVpMaWpTRnJldnFLZ2dqTCt1S0JBditHRisveFZrMTdGNm9hTDVJT1RXbFIr?=
 =?utf-8?B?N1I5VlhHZjM1MlFhMEtFZ2ZTN1BXV3FMNytjVWR4WDRBUzZHNXhiT0RyQ21t?=
 =?utf-8?B?cUwwSnQ4dmJiRE5LYml2bjRtUS8vZWdmYkxWNXRqc1N1ekxNaTJ5NmllOEVT?=
 =?utf-8?B?RFJ2R1kwQ1FDUTNGTmFNQ0tuMmNGUERhQnYzc0EyWGlISW5OOGpneFE2N3Nr?=
 =?utf-8?B?enp5Q0V1WlpIeWoxZlZMcEFiUC9LY0pNWksxcmhEbHVlZy84RGJycXNpYzQ5?=
 =?utf-8?B?THpNTEgwcWsvd21JWm9hbjV5UWRYWWF6d1BEYTV5NEhBNHNTcmY3dnBYeDho?=
 =?utf-8?B?WTMrejZIU1A0ZHNrekhCTVhiODcrSzBGZ1B0cEpBTUZueDZaWE9TeFRBVlov?=
 =?utf-8?B?Rlp4b0JHaURDTnhBS0VHU0xVc3RPMU1CY0JkWkJhZEdSNUs1TUphK0xLKzJC?=
 =?utf-8?B?V3pzWnVpaEpMaVA5VzRHdDB4U1NMOU9RT1NEQlJKc1AzSEh2d2ZCZEpiR1Mw?=
 =?utf-8?B?elZFclhudUF1TmdmdFJBSFl0T29Uc1QycncyRzV3eWlNNEhOcFd3M0x5dkda?=
 =?utf-8?B?eFFHdDhwc0IyaDhHcC8xTlpmdnFmSXkxRTlsQXFyc0ZRWlRGLzlkSDR3d1dJ?=
 =?utf-8?B?U3hvTXh0SS9oL0NrVlZ6UWZjUUdIVkFCdFM3eDkvVzc1TGtybjAwNnVTVUpv?=
 =?utf-8?B?UVg5b1ZpOHRady9nalFLMEhVZlR6YkJqNXNHTFV1VmtlazVHcU1UUDBla2F0?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e3028e-f15b-42a2-f6db-08dad3450e86
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 02:37:58.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3t3eV1h8fGyznloF2SSPvHma2akLVDTnLa+oiq6+5JYerVBIAEoyOnZ/6z7xVir1ZvkJr2OAg/oPzufAH0PNjrlDQ9qCBKub0GSC2TgOLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/30/22 17:28, Zhou, Jie2X wrote:
>> How much of this path exists on your machine?
>> /sys/devices/virtual/misc/test_firmware/trigger_request
> This path exists.
>
>> And is there anything in the dmesg output that indicates a failure associated with
>> the test_firmware device?
> Yes.
>
> kern  :info  : [   77.858068] test_firmware: loading 'test-firmware.bin'
> kern  :info  : [   77.864705] test_firmware: loaded: 8
> kern  :info  : [   77.874250] test_firmware: loading 'test-firmware.bin'
> kern  :warn  : [   77.880672] misc test_firmware: Direct firmware load for test-firmware.bin failed with error -2
> kern  :info  : [   77.890106] test_firmware: load of 'test-firmware.bin' failed: -2
> kern  :info  : [   78.896662] test_firmware: loading ''
> kern  :info  : [   78.901059] test_firmware: load of '' failed: -22
> kern  :info  : [   78.907422] test_firmware: loading ''
> kern  :err   : [   78.912278] test_firmware: failed to async load firmware
> kern  :info  : [   78.918594] test_firmware: loading 'nope-test-firmware.bin'
> kern  :warn  : [   78.925405] misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
> kern  :info  : [   78.935260] Ignoring firmware sysfs fallback due to sysctl knob

The above message looks like the problem. Firmware sysfs fallback has been turned off
on this system using sysctl. Can you try turning it on and rerunning the test?

Thanks,
- Russ

> kern  :info  : [   78.941934] test_firmware: load of 'nope-test-firmware.bin' failed: -2
> kern  :info  : [   78.962155] test_firmware: loading 'test-firmware.bin'
> kern  :info  : [   78.968232] test_firmware: loaded: 9
> kern  :info  : [   78.986063] test_firmware: loading 'test-firmware.bin'
> kern  :info  : [   78.992269] test_firmware: loaded: 9
> kern  :info  : [   79.023611] test_firmware: reset
> kern  :info  : [   79.028466] test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
>
> best regards,

