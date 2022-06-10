Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB654611F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbiFJJLh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiFJJK4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 05:10:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C027FE03;
        Fri, 10 Jun 2022 02:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJXpJAC5L7hQx7IHF2665PZqcXdiM38O2O0lrQaedbA75PHSji8dDZHNEFDNc3WiS0TAZX/TSlBAfMzW36be73p4FcF5rK5SKWSHnwaNsYcK0VaeBplzPu5Sgw9LBiXfCnRh1hGtpGrDc0lP5y/etpmT9YR7TJqPN5EejzcXRUqE8yH73lQ4EO7I2yp1HqlKH8al2pkbeMfvCDBmbYSAAK2M5wulO2rY2FaAkW2yYyUbC2D6YoLEHXggrIieZM8eWt2goOBA8fWxSBqufmfyqGUeGaXUxx0THh1D26YYco3U+IVjTqtNc//BBoef6R77/uwSJJ4FTFs5mppV+Hsylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpzunkK0YdR6gt7AXm8CwcBUxTAPTjjGQDDWdf/9UAU=;
 b=HGqQyLKReIo2KZEUKqiw9gY7uUO2yn/GnpoLg8+Pgvo7NFsPgDyT3+pzGlKBKnbhVkUDAwsAwWKkN96ZMkr7jYaDPZJFbh/Hspr3ZxnWDecie+8TypE5qgLTrLPAFJMU78pvzEBwHDWZrtqqTiJrhe0scVUaJAZKYfHdrfhMrCZRsflOH7OavJJVSmC2tCLqLmEf7v+Nokl75vuwytSkRAMgZIi4xrFRMYWkMAmGxnud1PK+87u5Gfk8irQ561H9W4Ee6Xqo5ZDe4tFAWNGemYi5R5FLwsy8Yes6OGBmj9vVZZ4pwlwmIYDEQ5a0wwUqGd7gv5yhIeZvQ+6qag5R/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpzunkK0YdR6gt7AXm8CwcBUxTAPTjjGQDDWdf/9UAU=;
 b=eE3G4Az/V4NZc3eimawngtG2V8SkPlcPwsyARFJQ1SLTc8SkuMTyfMqOQNRu17Cyuxs6HYPqTquTuELAkKRWbH7X5Jd/A/a9kE05LXf+3vyMVrHLI8s28XtciThtpitX+0nc4IXrvYw+QxjzvGQvHMuvFeTKd/+UvSgnVfnwXDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 by MWHPR12MB1903.namprd12.prod.outlook.com (2603:10b6:300:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 09:09:15 +0000
Received: from BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b]) by BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b%9]) with mapi id 15.20.5332.012; Fri, 10 Jun 2022
 09:09:14 +0000
Message-ID: <bc5f1d0f-ffa3-6341-58c1-8a781d9071ac@amd.com>
Date:   Fri, 10 Jun 2022 14:39:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] selftests/vm: Add protection_keys tests to run_vmtests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220531102556.388-1-kalpana.shetty@amd.com>
 <4b0aab3f-83f4-80f7-6df0-447561f0da88@linuxfoundation.org>
From:   "Shetty, Kalpana" <kalpana.shetty@amd.com>
In-Reply-To: <4b0aab3f-83f4-80f7-6df0-447561f0da88@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::23) To BL3PR12MB6449.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498e6e42-d47f-4ac3-8f0f-08da4ac0e3e5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1903:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB19032115E04C3BA20EA34AC18CA69@MWHPR12MB1903.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pMBTUUkPNZNhfHDmUXNDi6fLsJHnSzysJ4lMatWPeXX6W5VqfdrUjuZRPiB74TIJnMv2bJFnQEAh7D/pVyENBsY76zIvXMN6KaSuCaV5q9v/lIq1X4X8ilpDSllaXo7vTwGmAOeOgbehBSENpc7JtgDQ3t4cAPruXtTyYqB2CEWW+GQlkH1i9E995giDCWLfopB/2V9YUeS0CR+A6jTJnUkohRkH12uW5WyMQpWzaJrEDG49/F954VTPZkiAQUBHB/rQLBYu9NYZhILCFeKop1U8gbLwDsX0Mkf7kK3dZGXwG1aKxeFIwUewPrbH5t/KRF5JuLx/GmE08tVvY3gjYSoy6Y/qhSZY8kf7KRP8os21C63lMXigqTxWrQ/VS3X16SfYM58wABQt6eI4BX7EuBzIhYuAlCrv8g5Hud+0Y7P8XnskS4voXsLTxSzsGlg1h40Em11RqED2IPY5pxj128wbjAk45eyK++KgiIr18fXkpwvAn13wVLxO42nBccd+7Uh0Zsbw7KF/J+j51XRFat0QaeoG5LqSIpyrjcbmDHDKqg/ItJfIFX5DX15ClBYGMD64SxtW07v+AnUWopPkzNLIILgRXsQAaW4UmmQI5sB+T9vRWntaBactg5XQEdIRQgApciWm1yaDEIZsAVMTJLs/qk70PLizfLS/bpAKgAKwrxzbmzOb2vTiBmrUNeEVQOeQu9pvD8nppAxwWsL28+xUxgqTrQdVBLR+dJvqgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6449.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(86362001)(38100700002)(508600001)(6486002)(2906002)(36756003)(6666004)(8936002)(31686004)(66946007)(66556008)(66476007)(8676002)(4744005)(5660300002)(186003)(2616005)(316002)(53546011)(6506007)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUpzR0ZHek9IcG5lemlpMklZWS9uOXVUT29hTGwyY1Bha0xiWU5nSFNjYm5R?=
 =?utf-8?B?TFF1RitBOVREa1Q5WlpNU1pPNStXSDBCaWIyeU9uNmdVNVNsSExJaVhoUHhR?=
 =?utf-8?B?eFV6aWJKekw5VnRicXphUmlqaytXazg2Mk1iWTV0WEN1RWc1L1lHVnNPV0FH?=
 =?utf-8?B?RkJOYU92TUhmRU1lb09meE1ud2dqTVFpd3V2YjFIcno3RWlzd3ZMZmZFOVhU?=
 =?utf-8?B?WmZhVXZkYnNTMnI3M0NuZkQ5MlZZOE8waVg0bEh1ZWJpK29xVDZOZ0VGNjJE?=
 =?utf-8?B?VWRqV2dlSWxaS0RCMXUvSVQvblpjNlBVWXR5QktCQzRTNGx4KzYwUWpKWmVC?=
 =?utf-8?B?b3loSzRqVVBMTkttTDh5UGRQVVFsRFAvYnZGb0JrSTA5aHBsMmYzVFBVdk9L?=
 =?utf-8?B?anFzNGIxZm5LOURlQ2hkTnZ1aWxZTmNNMXdDZUp6YWtLTVlBa3VoVlpTYUpa?=
 =?utf-8?B?UzhpT1hsSmc4UFYwQ1ZIcHZRZ0daNllaM08wTDR0dXVqa1B6cmVpSWoyQWdD?=
 =?utf-8?B?cmdvTmZUR0RtN1BGZ1hVam14N21ibzcvemphZk5ndTg5eDMzLzJTcVVvRVJF?=
 =?utf-8?B?ckNKem9LQTl1M0QzK1orUTNFdE9BalRTU1pqY3J0VWNDTTUxaU5OQUVYa1BO?=
 =?utf-8?B?d2JJbDhIejlPU2dxUzNEM3p6UVgwcHNZUlhaVThmN3NpSURzdEVydE12K29K?=
 =?utf-8?B?d1JqN21nWG5TMkJzem5OQ21JQllZR2pTU3ZRZW5YeDBiZlV2Sy83Q0pGZVZr?=
 =?utf-8?B?empLTyszT25oVy9QZXpxK2MvajdQYU4vL2k4MmpsN2l1ZUMyL3F2c0hNdER3?=
 =?utf-8?B?bXY4RXVqVy9lcStrUWVEeFVNODh5d21CMXl3am41bXpmWXlRV2dLdzZCOGtO?=
 =?utf-8?B?YXI2b0NlMExvRVFuTzdkbUR2K2h0SGVqdUk4NEk1STBzMHFhb1NGRmoxNVNw?=
 =?utf-8?B?VE1ZcEdXY0taZFBOdFpYQ0YrdmtoVGllM3RHYlB1OGgzc204akdhQ0l1YXhz?=
 =?utf-8?B?akx1VHhvMERQbjJ0d3l5SVQvMGNNdWYvUUI0dzlEMjVOTHV0NHVneUVWakhm?=
 =?utf-8?B?aWtJR3dyNHdrU0wrdUlneVF6NzZ6TzdtTld2VjdGUitibUloR0lLRmp3bVNU?=
 =?utf-8?B?a2NlMHYxSXBQcjdZRkdxMGxJRjRldHJrRXJ0SEtRMVd0VEVzUzJHZVBKcy9j?=
 =?utf-8?B?ekc0SXI3NXM0RGZNdnpDc1JGUFRWZjVYVHd5Y3FxbVQybEJuSXNnVm9sQ01R?=
 =?utf-8?B?TmVYajBTcEtEZXVwbVFpVVhDdkgrMUVXWkFPOVQ3SG5SSXZDMFo5R3RGMjdX?=
 =?utf-8?B?bFl6dC9vU0F5R1pKd01nbFFTZjF5eURLODNNZnJQd2s2eWNSZEFQNW9tUGtD?=
 =?utf-8?B?K01VQlZkWWZaMTdlZEhtTWFFS3F3eVk4K2tWRkwvS24wWEJ1N0NCcVlTWHl1?=
 =?utf-8?B?RDFmQmNCWk5zWk9nSWt2bGEzanp4eTR6OXJlRkFJWVhTKzA4N2ZXZGVNOWNz?=
 =?utf-8?B?V1hxMDFYaUI2OURBLzhyZk15MUw4MjZhcHBnUmdiWk0rVmlTOTRSaE5UYnpQ?=
 =?utf-8?B?cGVrelNUc2JWLzZYeUhlU3o5L0x1VW9ta1JEaW5QcFZ6UVpOTzZBdjZUZGpW?=
 =?utf-8?B?NWlHT2VmdXNsdU1kWjlyOFZFbUxvSFRDK2d5dmpacm5kOUQ1cW5uWWppNFhs?=
 =?utf-8?B?aWoyZ3d2MFRjYmNzeHRKYlAyWFlnVmlYOFdFLy9TUWRRRXVBeVNndFBCN3Fi?=
 =?utf-8?B?SHM4S2lzVTllYU5ONU4rcGVjaVVkL2ZRUUVLbzUxZ2hwRnJya1dSdWxBRmtN?=
 =?utf-8?B?WmlqVWtXZ0VzVkpDNFpPeGZkMXNVS2dVZzVsekNsQllNQ0I2TWpKdnBEOWtK?=
 =?utf-8?B?SkZ4Y0tDd2o4SWZUSU1qQjJSQ3BGd2JSNTZzRGMwV3ZaOWlHazQwd1JuVWJZ?=
 =?utf-8?B?Y2MzNXpCbkk5ZE14YUN1bUk4T1hycDNhL2dpd1JmODJoUWJPcE05dVNtVDl3?=
 =?utf-8?B?aWw5N09LaHlJZEJNWmJSdWtBSTlBbTlMY2QvK3NNY1AxMXBXZnRiM0hnTlV2?=
 =?utf-8?B?S3dwZ295cWNIc0FVaUt4NktyZno0cTB0RzFzSWsxYUVJNDUvT3l4aFZiL0pk?=
 =?utf-8?B?eWpoMDhhdVRQY2Q2OXlucTQ1cUx0VFREMGhXQVEzS0JnWHAvaFhOc1MyQjFQ?=
 =?utf-8?B?cW8xQVRST3NUc2RvQWEySFQxK2JaSldMaHdXaVM1OXVvY21yZGdYOW1YODNz?=
 =?utf-8?B?YkNSYmtqTHltcDRHOEFyNmZrTVpkRVhKWDRoOTlpU2ZWQXZZTGQzYmdFTXQx?=
 =?utf-8?B?RktYdFJ4M0JSS3ZrOWlnM1VTZ2hQMzg1b29ZLy81ZmhyWTB6NVhYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498e6e42-d47f-4ac3-8f0f-08da4ac0e3e5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6449.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 09:09:14.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/cdka+TwXkrvvCApq1aPTITNfnqkIKllmDsIkYqfr+Kshyl+niMcH/XBqcGIBwi0EzQKfQOAMZIeg55NiS0Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1903
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/10/2022 1:51 AM, Shuah Khan wrote:
> On 5/31/22 4:25 AM, Kalpana Shetty wrote:
>> Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
>
> Missing commit log - please add a detailed commit log explaining why
> this change is necessary.

Sent V2 patch with patch description.

Thanks,

Kalpana

>
>> ---
>>   tools/testing/selftests/vm/run_vmtests.sh | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/vm/run_vmtests.sh 
>> b/tools/testing/selftests/vm/run_vmtests.sh
>> index 41fce8bea929..54a0c28f810c 100755
>> --- a/tools/testing/selftests/vm/run_vmtests.sh
>> +++ b/tools/testing/selftests/vm/run_vmtests.sh
>> @@ -179,4 +179,11 @@ run_test ./ksm_tests -N -m 1
>>   # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>>   run_test ./ksm_tests -N -m 0
>>   +# protection_keys tests
>> +if [ $VADDR64 -eq 0 ]; then
>> +    run_test ./protection_keys_32
>> +else
>> +    run_test ./protection_keys_64
>> +fi
>> +
>>   exit $exitcode
>>
>
> thanks,
> -- Shuah
