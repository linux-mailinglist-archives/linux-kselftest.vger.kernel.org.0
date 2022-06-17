Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12054F695
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379829AbiFQLW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 07:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiFQLW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 07:22:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12566C569;
        Fri, 17 Jun 2022 04:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niP0p9RLacaH613XoyrNvra9iwt0as/cLpLgyvR1i9Abrp2FzE0YU+YhwRjppbnQNXHi/GyvcUgLlLUME5TBS6TtMNFn43SgODEIfWDf3/0aOYZuik0QxCEjggQQeaeHMsVeX+CPtPVR8XP5ofh7E61k6kk3aHeb07nVsSWRkxYMSNl3/j+2MpdclXrvBZLN1SUPq0xGupfB1CSPCTwEDwoZEKtLlnwunmj+GrOeuSB45GO475hKDsg3NvGACwG3YUX3ixHR1qqw3WGkCTko7poO1cOU4hZjxJsJqCB9RsLw+LriHxiabARLtj9DiJkz7jbNBnsf+Ph02tuiuAbUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaZz8K70RhJyHbsbj8KnmRC7kShKQ0FqvibACCuLg5M=;
 b=h28UC8N6LUDZPPPyWYOIvuKYinxwEBuODmM9phmsk0w1lPHJHSyPWeiEIGvO+JXPLLK1NZ8bvHfrRFT32yke0Cb8py5NuGIS/d50oKwDqiB8uGoUZBRicef/uBBGSq6dlQQLNDe5tgm1BC9ybQnsyimPVFNWAVNqjvT8sXgwfrBAflknHXitqxxbwNeE37ERt5x2C15v/UD6JBG0fQ0EhCuyucMEIEujr3FiFwt7k+6RQOW1gTjE720pOhz+mZhIu47975vY/m3vgkm4VWK9TJfeX2Mii45gIDZW956ykIDcIbK7eRJbBlDpYBSXBGmwKdEW9SW192ccgJJ4FDmHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaZz8K70RhJyHbsbj8KnmRC7kShKQ0FqvibACCuLg5M=;
 b=MwwxveQ1QNjoN3hOR0RAZg5V0uIRxPloEFG/Yw4ikxnyTmZMayr3KJtL4ebcT0DAQdp8B7Z9gy2E4q6VHgbFDGDoC/PdYZi0cD2YND5O8PlDoqkJskOXERx2JRFn6WtdHicnETvXFnZjnNaWPBQtowEnsa08FA6TC4B6ZGSLg/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 11:22:25 +0000
Received: from BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b]) by BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b%9]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 11:22:25 +0000
Message-ID: <13351a41-75f3-2247-e8fa-72a919e2b5cb@amd.com>
Date:   Fri, 17 Jun 2022 16:52:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2] selftests/vm: Add protection_keys tests to run_vmtests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610090704.296-1-kalpana.shetty@amd.com>
 <8e7fca3a-096c-7d6c-e43b-9292995ab970@linuxfoundation.org>
 <e1703fcf-c5e2-70b1-cae2-30330108ad26@amd.com>
 <2f157493-02ed-4bc8-6624-b7d077c0d5af@linuxfoundation.org>
 <442c7cb4-7ec5-bf34-b9d6-ce9480b4b491@amd.com>
 <b63d3373-0a42-afdc-1f03-875301e9b6c8@linuxfoundation.org>
From:   "Shetty, Kalpana" <kalpana.shetty@amd.com>
In-Reply-To: <b63d3373-0a42-afdc-1f03-875301e9b6c8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::16) To BL3PR12MB6449.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e1c6059-6936-4768-7ea6-08da5053a7cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB6278:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB62789DA7A77F79E7ECF7611C8CAF9@DM4PR12MB6278.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXjyjOOYtKD+d/Kzc6EHsuLYhfDcsgJS0Nwf0jG7m2Lu1DTsj8xstCxWbIGKRCns/+zfCc4fmrZ0/fs4IyFB13LlXsQNHofyKweXXptY3yzEjJpINS81r7MgSSEJQ18H+rahB7Yn7qRVLj6dIwCoMik3dOPwzce4hKrFtENbDtWWlb+OSHwi6dUAg10AE1zYxIp/I7kTpI5lP17QKm6Ms4ubs6bxMGXRIRDmjzDbubIkhPe6rvOtWiKGf/XRYde9Co2OPgpHfC1cbDYnWCAjkV+afTPBXBX5VGRZlmfZjibrJMJjup4wGhm9H1rRZ2SxJjpDTVe3yu76V+DhR5S8O2oxjTpVuD8HhjScuUUAB33NtHu2MTGSRW8y0ZPU6jfHRXZHLS7Dpgjzaljx+PRBf3flA/H1+OYgOO0VlrIv0s+paaZOH9n5hJjp2+/jWnurarmZg7Bj1CwiIg/t2Z/JwyPOhKFcOfrILg7BC7ipzMxaNTCzmrNKoVHovir/0vgesYQ24nSCpR5ICuylnV3zaM+R74TjNI63ZhfYgf2qYRP3aHhplGubxc1oz1wFSrnpOuJj/VcbAalaq5w2Ym1tke6Zj3NJa3v03LUCfFSsW4mnsTaJ6ESFyVasUl3MuiU0U7R68DXJsDRCKfWtP5xIVJ2IR4pYrechemI2sE4qJXNI55IFFCdPR8dMlUD3LNssRwnnlC6Qs64z5CCcGxiAufAgJ0cCpFMsqgLnvPQouGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6449.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6506007)(186003)(2616005)(26005)(6666004)(66946007)(66476007)(53546011)(6512007)(86362001)(38100700002)(31696002)(5660300002)(8936002)(31686004)(36756003)(316002)(6486002)(2906002)(66556008)(498600001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG0rT3dQTEx0ZVBaUDIyWTdXUkphVmNHUE13cFVTc3JmMWwxZ3ptWXVFa0JF?=
 =?utf-8?B?MnR5elQ3dVJNZktBNXByZlk2RmVSN0pUcEtwQSsrZ3dWMTdlQlJ1L2tSQkQ2?=
 =?utf-8?B?aWxQbkE3NXR0ZjZ4dHkvOGcyUjBKcW8rTkR0S1g4WkRub0Ywa25LTlNCWFU0?=
 =?utf-8?B?bjhtbWs3cGcrVmpSbXZwNmFTb0lNRjVRbkhVdCtGeExwMVpkNTE2TjRMRkhX?=
 =?utf-8?B?eGY1L1o3cm9Nc09kNUxTb3BESVNCbTNkSFJ0WXAzWW5RVUlGWXR4bWJWTG9K?=
 =?utf-8?B?aUVqZWl6QlE4Zmc0ZlE4UEpocUh3emJQT01JZzhVOWhrc05FZG00b1Nudks3?=
 =?utf-8?B?V2MrbC9ickRXNncrTW1oM25iSDNpS0hkOVg4MU1yZnFHYVdLYWZKSEtmVEl0?=
 =?utf-8?B?YWNYNXBCY0RnU1duYmgxZTNxd2ptTDdJUXpnVHRXS0xTZDU0TXhET29YZ3Y1?=
 =?utf-8?B?L0lDUWhFTU5CKzlLbk9veDNoRFd1R3p5VngrUTlQZDI4NTFFM2pqcDRwaFVy?=
 =?utf-8?B?YTdqcGlaVHlvK21kZFYrS1BPYlhQT1dLWEJmL2QxaS81VWhyRXpuTDlSOGQ2?=
 =?utf-8?B?S1d0QndDc3ZlcStHRlRySU1rYWJqdGIyWjFSMCtvbGNFeUljUG90ZjlmVFF6?=
 =?utf-8?B?Q1M2MVNKbTlUYlBLSUIyMGFaUlNyajNLUCtObUduMlhqeW5ENC9EVmRsTnJN?=
 =?utf-8?B?YXZhS3E5Y0k0YW54ZlJGM1l6LzViczlvc0Vta1NXQWdBODNYSTJ4TUg5bVdu?=
 =?utf-8?B?eEpGc2h3eFZscUdmL05jMDdWZ3MwWGpDNDFyc00ycG0va05JdmhUYVR4dWZh?=
 =?utf-8?B?NTlOcHcybUNZRkUvSUFJTDUycXI3Tk1SZzdZZUdwRStPQ0UyVHZjOVM2aUNV?=
 =?utf-8?B?T2ZvcnA2RXZRdldFVCtPejdWU2U5amh3NFNRNkN0cEJPUmFNWUJuSmdqSk1M?=
 =?utf-8?B?YVBvcWpJZVRURlVCaWdCOVlTZGc2Z3cxS2IwbWVuQmZSUTRIVWkyM3N5K05J?=
 =?utf-8?B?QVFWVlVtT2FiTXVBcnNRVWtrQm82Q21hSmtJSG1rdndsLzJRS0dubUtUS0pZ?=
 =?utf-8?B?VFFkbWd4cWJLbE5VTE52YVFydXJNWjgvRHMzVzduNThUaGJJa3JWRHc4MHUz?=
 =?utf-8?B?ZWdRQWxpOTZYSVlxK3NJNWhaV2ZXeDBhZmJkQ1dIaE1sWVFNeVZUd1NrOTZi?=
 =?utf-8?B?cUJHMzNpcnN2Vm1pU3dET0JiMnZNTk9aV2JBNVF3Wnc3ckZKMlg4S0FIdkRw?=
 =?utf-8?B?amNDYkh0b01CNmdmTU1DM3pCU2V3bXJXY3FEZHd2Rm1HSnFZMXdHUmtBaVJx?=
 =?utf-8?B?RWNFY0kxUmZuOUJleU5xOWdwQTNsWUZYdjlvSXBMclJNSnA4ZUVWNmhjc0V3?=
 =?utf-8?B?MXM2REFxS2xlRUtWWDVEOGJEdW8wZGZpM2RaN2tRQVk1UEgxUW1PV1NlMHcv?=
 =?utf-8?B?bkJVSlNyTHUzeE1lb0VSM0w1QUdDS3Q3cm1VdmtyQlRmL3A0RmtJeSsza2k0?=
 =?utf-8?B?bk1BdjEyVlBzMHhLUVFIQ1lJelNnSmgzd0xiN2hReFJBSU1jYWNHcDNEYklG?=
 =?utf-8?B?ZWN5V3o2NlZXZXF6TUFQNngvcnFxZlB6bE9HK1RVeWtGZjcra0dMWDEwSkJq?=
 =?utf-8?B?aWdrNXR3M1BqZkFSenZvMG4rTnppbDZMaHRCaU0xMTBaVkZ3Z2R6TnI4NmNT?=
 =?utf-8?B?d01JQTdqNm1LKzc5M0xMcEFobkNxMlNkRHg4NWUrSnRoU0M5OTJ1QklEdGZx?=
 =?utf-8?B?TlRIcjIxckhDTFZFSnBqUWgwcUczN1NLV3Y5eERYZ1ozR3VrcnJ2VlkwNktD?=
 =?utf-8?B?a1pucmJCU0NHSWhHN1g2cVJBZVJEOE9ybXRsMzR2ajdFYm50S0lCRmN4OHRU?=
 =?utf-8?B?d0w0cjZTNkU2bVVoUFRLeXM4UzhQOUYxMFNIZTFOWWU4Q3NxS1dmVGlKUnVD?=
 =?utf-8?B?QWV1RjQzNE0xb0loNG1HcUNJUHVCclcweUVkRGRkSWt1NVR4dVN6NTNmaEFL?=
 =?utf-8?B?cVl3VEE4VDNLQjYzbTlkYjVZRGF0d0ZKTllYeFRmbmFEY0FNOU1jKzI4RUxl?=
 =?utf-8?B?TklwM056QUhmL0kreFQzWjVRSHpGa2VFRXhJUHFTeWpiZGlwRVlzbzlvMzhw?=
 =?utf-8?B?WXRiRW1QcjloKzNndGZEbjRXK2lZcTRpUlJjM0FvdHBsTGxTSnlzekI1ZG55?=
 =?utf-8?B?TlFxNHI2ekhQRkYyNTIzM3JVZzdBV2RzU3ozRWJkODNlNmoxb3piRDF3TzZW?=
 =?utf-8?B?eVQ1c1NjTmJycnN1ZkJDbUttTFBMT2xuUnVKVG0rbll3bHhEdlg2dE91enBS?=
 =?utf-8?B?cjhiV3lTSjV3ZWhWZWdtd3hXSDRpQVRRbXBzVjB4ZjY3aXVvbXdlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1c6059-6936-4768-7ea6-08da5053a7cf
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6449.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 11:22:25.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7MyXKZeCL2RnjM1vZDaTyGQ77E+MmNt8gUYlkHHD7+Gryxt9FErfmqQ/wOsK9amuYt4UIL1eR9BtGgpddwl9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/17/2022 1:23 AM, Shuah Khan wrote:
> On 6/15/22 6:04 AM, Shetty, Kalpana wrote:
>>
>> On 6/14/2022 10:50 PM, Shuah Khan wrote:
>>> On 6/14/22 6:15 AM, Shetty, Kalpana wrote:
>>>>
>>>> On 6/14/2022 3:14 AM, Shuah Khan wrote:
>>>>> On 6/10/22 3:07 AM, Kalpana Shetty wrote:
>>>>>> Adding "protected_keys" tests to "run_vmtests.sh" would help out 
>>>>>> to run all VM related tests
>>>>>> from a single shell script.
>>>>>>
>>>>>
>>>>> Makes sense - can you explain why you can't just run
>>>>> protection_keys_32 without checks? 
>>>>
>>>> Yes; we can run protection_keys_32 without check.
>>>>
>>>>
>>>>> Why are you checking for VADDR64? 
>>>>
>>>> The check is added to ensure if the system is in 64-bit mode before 
>>>> executing 64-bit binary.
>>>>
>>>>
>>>
>>> Okay. protection_keys_32 will only be built on 32-bit system and.
>>> protection_keys_64 on 64-bit system.
>>
>> On 64-bit system, we get both 32-bit and 64-bit binary.
>>
>>
>>>
>>> Won't it be better to check if binary exists and run either _32 or
>>> _64 instead of checking for VADDR64?
>>
>> makes sense;
>>
>> In this case on 64-bit platform we would run both _32 and _64 and 
>> this should be fine.
>>
>>
>
> Okay - send v3 with the change.
Done; thanks for your input/review comments.
>
> thanks,
> -- Shuah

Thanks,

Kalpana

