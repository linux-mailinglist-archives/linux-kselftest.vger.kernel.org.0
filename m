Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB8754FE63
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbiFQUb5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFQUb4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 16:31:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107BE5C753;
        Fri, 17 Jun 2022 13:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXd+flEYiFroDKF46HkB5ryGsSbphDrUjFyPfX1t3zeZchLhfah8BrxWC2sBWwEABxWBTIH3HuL6byVD1VicWVbPbP/19gvKZrYUuxMc1Y1DZ8/Wg5ntF897E8FM5X2RetlFNK2DLDPGz8H/WB7SH4QsPoGujPMRSMqTWcocl2oRKe7Qk20CZnOhHIkusOaTvryoFIDBz0hcG+Mj5Epd8pAf4Cup8e+dRHoe4NmHCrwuYYY9cPo3krzUkdTgTuiUhSTGk8aCi0e7vnRONYbegN2FENMmXLIIJso1Tb4DNxHRwPWlk0eIMCp4AKglvmcAINmnYeUh+SCYvOs7VuY/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdCLCWqN1Yil8Q8Q3XJbLbfKvxdlTRwZn+9zC+5ehvk=;
 b=SRSJ9vqho3Tm4j6EE+EHh9Ivip+orOW7rcKmkFqQNAYc53bKkjRzCZhco//XKWuEwFA5noaPw8vpfZVArEJUX1z9c5LtjQ/zaPVBw0DUYQkzvxeF/HlKNh4l3IDQyB15IyiNJ/2Q1zLJ+Ubhxl8V23hywwbX+n+ARKYlFaxU8wDjM/CkTode9yn0pRnSDuPqlP034zJ43ty8d99AIhn+APw11mlT7Llst+sO+cEsvLnclG54xnFlE/JUmmm6jmcM2VYpj7s0QOAtL4hSzOx3r5EraHbG911UTFfTY4KzHrI1P7LrqMLOJvEkOstszcUjj6GZMDnLzlZL9yedC5rviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdCLCWqN1Yil8Q8Q3XJbLbfKvxdlTRwZn+9zC+5ehvk=;
 b=Np8v68/IG2D3i5cKCzkCCZfV9E4Zs98VuPFRCLoy+W2ce6BBCmKU8NyFwQeAihZZvZSMMGDGH8on3huZrnvHVjgxEn9QocbKT+nPyO91n81H4x9E9AFBqfQWxp0Qp3txQahwZwWZVNjABFpQMUa2/cBvrAQhLvan+CetDcMdVzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 by BYAPR12MB2935.namprd12.prod.outlook.com (2603:10b6:a03:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 20:31:50 +0000
Received: from BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b]) by BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b%9]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 20:31:50 +0000
Message-ID: <817b6158-a6fc-bcf8-7b0d-b58f8e5a837e@amd.com>
Date:   Sat, 18 Jun 2022 02:01:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V3] selftests/vm: Add protection_keys tests to run_vmtests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220617111019.476-1-kalpana.shetty@amd.com>
 <f73fd7c9-cb9c-1e89-4e22-e6931172eb91@linuxfoundation.org>
From:   "Shetty, Kalpana" <kalpana.shetty@amd.com>
In-Reply-To: <f73fd7c9-cb9c-1e89-4e22-e6931172eb91@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To BL3PR12MB6449.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7949728f-23f2-4bcc-c59e-08da50a06860
X-MS-TrafficTypeDiagnostic: BYAPR12MB2935:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB293568EFCDC5B3393CB943538CAF9@BYAPR12MB2935.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfrXGRa2e1jyuwYC7OZtblbmYvZL36JKelvqFVKmX36+I0GMrqtfPxs5d5YHl+dee5Hoab+sDKQIR9+ta1UEZ9FJPcIJhn0/Elvh4NqU9zCLd+kRN0/3DPugGQrWD/gPBFKyKAFJQ7uxjXX96qlNe01LZ8cv8u9p6ztGuEbglWwfSBde0X9iF6RMBkbK+J1kigDrpzZPLpNjDiEGC54l6M4EJOqRfIQnFlY7F2+pipxT6UOMVzCMc0hoe5W/jBkOKzGvuyW2gKkgOv/9Df+WNQonS97RQSFPCxsMx+4xbrPQ/laUqED6iboYCus1iUwg7wTdfadpEjdfWKSwCMYkpqAPyvs51dnRvPH3dRLKuX+ZRVZM2xpXJ4k7UBC3T1JtRrU/TJznqnEgs08+HNlDzhzyqAdHOFVqo4e/RO6+AXT51TJ1waC30ShsxfP7u5du0TlSS7GmTuHb2Va0KPBKaF6UZWixK3gWUyuZoGnH3aaSpTqGKsiL9ulUqIFdmqqktdzWy1ftSj5W0pHRXVUIgCCsVVcX++A5o8O2i8wEOW+j1bHvsKyhBObxALPq76AnzmnCQ0GA1gbdKWDAalkWLbxXhRq5210lNV1j+BHebBSXjy69ma4V57zcO/RuUcsiukgwghsfMbDJufvFFlqljqNoRHwGlbERW/nrl4wDB1XJdYf0wq3Qq6GQCiWEtFICAAtcIzmm7UTUTB3aecEeZwQs5AwHFa23epVRoc/VidJFH31NR8qiofzKVgFoNXBp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6449.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(31686004)(36756003)(6666004)(6486002)(6512007)(498600001)(86362001)(26005)(6506007)(186003)(316002)(5660300002)(2616005)(53546011)(66946007)(66476007)(2906002)(8676002)(38100700002)(66556008)(8936002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZqNXIwUiswKzM1ME05T3E1WmVLb3lXbVpoRm1hdUl6TXFKbDlsOVZ0Yk5T?=
 =?utf-8?B?WkVZbmdNTWVxVDJDRmM2WDhCZGJ3dEtQNnlvT1RpWUdqWXA4MVF1TVM1MHpu?=
 =?utf-8?B?SEM2OUVFaitFOTdDaWJaQmpQMzladFExcmIwRzJuQUI0Rys1SndSVTNhUXZM?=
 =?utf-8?B?L2tWUHErYUJOR2pXU21laW51cEtxNStUS0NoZklKdUQ3a0ZkN245bm94ZEp4?=
 =?utf-8?B?aFpmMU43S0gwdFF0eFMyTkxDNGU4RS9aU2FkNWw1bXVIaEUvWUdJRkNzdVE5?=
 =?utf-8?B?YkpkcDFsU1o3ZGhvYTArcGFacW1td0M2VVlqU2tOQU1tV3EwbGQ0QzEzMzl4?=
 =?utf-8?B?WkFjWkJDZ2tKL0I1a2syb1RLNEd3T0V4UjdGRllCVkIyR244ZTFOTWlERk9L?=
 =?utf-8?B?SzM2MWlNbFhzYlllcCtCek1hTkwwYStvM3hGSzFRcmRHQ2tvZ3JYVnRWaC9H?=
 =?utf-8?B?bC9xdTBYL0ZFSFhFNzlmeWxSdmUxQ3FuL1p1eEk3bEMvb1YwL1FQWU9zeTlo?=
 =?utf-8?B?ZEtBNkhtWm91dGFqL0QzY2F6YUZPbnpuaWdhODd1QUNLOGxIU1pzclZQYzVw?=
 =?utf-8?B?cU12ZjRrZi81cCtpNEk2K0VmOFo5eHQ4NFU3b1JTS1R6VkdtRWUxMUw4SjNQ?=
 =?utf-8?B?b1V1MVE4TEJOYllTNW8xZXlqOHBMcjdKWmJkcklhOUgrc1FlSzVZcVg3bjY5?=
 =?utf-8?B?WTFMcnpzamF4azJEeVYzSVM5UTliTStJcVR1VUxjbmJKVmxrQnN5eW5vVWtl?=
 =?utf-8?B?VjFScEVqRG0rMnNLMUFvL1BYRm1BY2xOTDFtekZ1bFRMcjBTZ21KNjFWRTF4?=
 =?utf-8?B?K1pnNUFQR0NwaFVKZFk4dzluYVdNTGlIODNiSUF6Z3JZNFp1SzZEcXJ5cDhS?=
 =?utf-8?B?V01jR1lMcmsxdVVTQ0h4ODZsTzhGd0hCaFFrb3dPb3B3d1phT2owbGFEUkhF?=
 =?utf-8?B?amlwWnhvKzZKWGNTTU53TUk5Q3J4MDRkQ3M3b2V3K1MxUU1zU3ZqR24rRThh?=
 =?utf-8?B?ekFUU1hMRmFRcHVLeWQ0VVBmVGhRVHg2RmdyMllXem41ZXczTmZVaE56NnR0?=
 =?utf-8?B?YUhjc2I2b1V4K1dwT0ZDZFNJZVFtb2NuWWxvckZRYXJSZURNNW1VS0d0Rm00?=
 =?utf-8?B?aXBnUUFKV3BHbllZQVFVUC9QcU9MNUFyK1RaSGR3THlWQTlRR3BWbjJMdXlE?=
 =?utf-8?B?TTdKcXM5RWRwVHNUbXVkSnJxbXBRWkEwTmxteFJUeTNQR3FXMEJyT1o2VnJW?=
 =?utf-8?B?ZFN3L1Q4cWkzQWRtKzBKWUx3WVREdk5oK2J2S0V6WWV0ZklCS0cyMUtPSy91?=
 =?utf-8?B?aXVBUk54UnBzK0dvNFRzbzJQb1JFenh4OUtPZWlPNUZ6Y2RJSzlreVRWNDBG?=
 =?utf-8?B?R3U1R05NcURteWlsdzZvYS9SZlFsK2kwRXZTcUwwcU1IM2U2dHhOeXRERFNx?=
 =?utf-8?B?anFGQWEvT3BJaFNOTjhWWkFiTkhoWFhRMDA0UmhoRnJjQnJYd3ZFN0ZSL3VT?=
 =?utf-8?B?ckpub2dsVk9HV0Qxc0hWUHhCR0ptUjVSWUpuT09RcjZFOWRDdTVIczFMWU15?=
 =?utf-8?B?YmdXSzJMUHFRVlp4WG1sSmFGZ1JXVFF0d2FJK2ZReUc0QVNOeDhFVWxWYnJw?=
 =?utf-8?B?dzcxYjk4em9HaGNtS2FyTkRReGVLeTVSQll2enZPYm5mM3c3MENDelZ6L2x0?=
 =?utf-8?B?aUg1MjJBeXNVWkI0bW0yQk8wQkJIZUdSS3Z4WFlzNTJpKzJBd3pUTHdVc3Vr?=
 =?utf-8?B?a0RQK1VzcWZWMkJ0Vkx2RVFsaHFWVTRsREhPRFcvekFRRTVIbms0K3pVYTdE?=
 =?utf-8?B?QnpSRG9UQlJFVFl6QkN2aGRtSGdlVjhvdm5HaTIyZEtBZGFUSlpJMlJJb0dK?=
 =?utf-8?B?eG4xcEhPTCt5aWJQNmFLNENnM3Y2ZllJMjBoZjB6aGZmeGxBZHhFMGdpOW1S?=
 =?utf-8?B?ZkdKRHdtcFQ2YWJuOU56UHNaRTZIWitRR0ttSEo3THZCMVIzdzFKU2NPQlVy?=
 =?utf-8?B?MzBXZ2ViNU1pVmxrL3RTcURpaDE4dVhtYjlFdkw0YzArRVdaZjhPdnU4OFBM?=
 =?utf-8?B?WllYa0JLWnQ1aSt6VmV1a1R6U3FKc0kyZ0tSYTNlWGlIeWorRlpFVjluRXBI?=
 =?utf-8?B?QUI4WFhQLzdvU2xLUC9yUTBCNEFTSE5GczZ1RUNSc1A1dysvdWhuSjlGT0Js?=
 =?utf-8?B?ZnZmaEtTelMyWVNuUnNIb3hjTFdub0pYVEZ6eThQL3Nxb1M2Y3VxVGVMbFI2?=
 =?utf-8?B?eGxMbkVOZVZ3SlM3ZDRsZENKSXpGZHVCUmUxMlNINWk3c2M3b1Vham5PYlo4?=
 =?utf-8?B?WDJrbDhaOWtHd01pc0JWQ20rYXFDY0gvTDNYTEdNV2oyS3NWbGNzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7949728f-23f2-4bcc-c59e-08da50a06860
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6449.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 20:31:50.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcpzFuxjPlCIw2wvghcgUAdpa3nPHti/8iwvsAmU83jEgoVXay3BZeJjY/WQa30L7Cn2VWwexRYJsD8MK/IM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2935
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/18/2022 1:01 AM, Shuah Khan wrote:
> On 6/17/22 5:10 AM, Kalpana Shetty wrote:
>> Adding "protected_keys" tests to "run_vmtests.sh" would help out to 
>> run all VM related tests
>> from a single shell script.
>>
>> Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
>> ---
>> Changes in V3:
>>   Shuah Khan's review comments incorporated, added protection_keys 
>> binary check.
>>
>>   tools/testing/selftests/vm/run_vmtests.sh | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/testing/selftests/vm/run_vmtests.sh 
>> b/tools/testing/selftests/vm/run_vmtests.sh
>> index 41fce8bea929..b19c6b1b84c4 100755
>> --- a/tools/testing/selftests/vm/run_vmtests.sh
>> +++ b/tools/testing/selftests/vm/run_vmtests.sh
>> @@ -179,4 +179,15 @@ run_test ./ksm_tests -N -m 1
>>   # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>>   run_test ./ksm_tests -N -m 0
>>   +# protection_keys tests
>> +if ./protection_keys_32 &> /dev/null
>> +then
>> +    run_test ./protection_keys_32
>> +fi
>> +
>> +if ./protection_keys_64 &> /dev/null
>> +then
>> +    run_test ./protection_keys_64
>> +fi
>> +
>>   exit $exitcode
>>
>
> Why not use file test operators. -x works for this case.
> There is no need to run attempt to run the test.
Sure; thanks for the suggestion. Sent V4 patch.
>
> thanks,
> -- Shuah

Thanks,

Kalpana

