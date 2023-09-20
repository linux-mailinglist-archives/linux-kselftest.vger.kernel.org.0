Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0837A8D94
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjITUMI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 16:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjITUMI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 16:12:08 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8516A9;
        Wed, 20 Sep 2023 13:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMG7RP7gyt0GaZqShDU9x959Opw7mWZIUiYP71w2wmiMk+nmVqPnoKtdeCFSQhviby6Vs5DMYHjZEyi957zrDVANuwQDLLEwXpu/qs2UkJszh3Hn8qb+Hdsf8a6RGJrNV3OGdDIhgX0uWr3WthsVW/BNuNyvmiA0egOMxWppcVqtdl7AAMoq3P6LxhOrim8QQdTKPyPUaUT50RhBMqNID6jn5aJWmkogLDGxibA2HhSN3RYtykSosJBiYGaVs+eTSqnNMbls8pUg6skR15H7Q6J+CdrD2nMfB85T1qjclmBr7OA+ScPaUVNCMeazH+rHaOtJz4NKpFPmwPqTB/6l3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAq/02j35svW7bbSAjUF4d3exCz5ocyXBg3NxHWx49k=;
 b=F4VFfxCQ4BQuZwPOZ2JCDMJyq8BgMzTOh4PVbiH4jab4cU989vhNNHwF6qXvr90OsM4aRK7VWcwrAvxbKERxns6cO7pMdaAGd62sT8oE5Ml3Uapi1dgKBRa3l/+v2V+2e5wja6YI+GNomqb8HBeK96ZJqHiO2vpVSaBOnLOS6SN0PLoWPYSDMOAVZUlRP6/3AIZtMYH6sHtwzgXMYC9xJP2Yr72Ve8s4SyihJH8sU+RHN7NCG84vmtR/mGJ0WvKhIpA6BzREhR+QYXuG1bjWrZLOK8e46nLstPW37SOvY0UbZ6FM001uVktXsDUoiLBI5C3iU4LUqWUcwz/6vFFtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAq/02j35svW7bbSAjUF4d3exCz5ocyXBg3NxHWx49k=;
 b=C1wG1NvmNTGQ94kD1KBlCh0vjR+0BgH6xFMv7DzVvldN9GSb9T/CUyOVzn93lMRrGZ4ItKJynGBbpTyXI4CUjlHVNpa1Kr6+wFWPZqT2LnHkQMA2GZZxkDhQ2Yas+3G1mKqoUXtNbIQh8PlMYHFI/iIqr3Imb6ZpaU7FawSoTrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 20:11:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:11:57 +0000
Message-ID: <d981aa59-8aec-4929-9633-9ec7af81b099@amd.com>
Date:   Wed, 20 Sep 2023 15:11:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Huang Rui <ray.huang@amd.com>, Meng Li <li.meng@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230918081407.756858-1-li.meng@amd.com>
 <5973628.lOV4Wx5bFT@natalenko.name>
 <ce377dda-e1ce-4553-b9b8-125620b8b2d7@amd.com>
 <12290212.O9o76ZdvQC@natalenko.name>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <12290212.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:5:54::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cd9f14-0499-4393-47e8-08dbba15d763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oN//KjOHnulX+7yTLNhrUtrxLo0yWdzJ/JuUMSXs3K1xL59twRxuJYtazh5hfc/Ym3mrPuAhZgqS87Eybc7P9FiUmqcjZsfMSCgckXZr4u1Y6uCrD3HP2QBBiT9W672FyQTAD62oCp5fXLpTyixo4TywUPs9QP9nn7O6oWHkozQVjEGpNtsqY7+2sLqesJn0Hd4QEjH1kNtFLPXixDEd065ZXtdwyR0ArNegR2TC3GBUH6g/V39BAVNMOwxUWnrvt4yFOcK6SzFrizdLZ9S8ztS64SId10Tjq77uUTWyKNtgT+idWcdwi0qAQmT1KTZ5fmnrzqNwS+kE73tjuM27TZMAkZnu24vMMpD7nGwaso+4J6UMkFjztXfAghsGm3eqXjTBajd7EdY9kXO2GOP8cTNvn5ANdus1MJj/eGsW3j23e9mmetlyBoERKqGBvJzmxhDaRLQo3QWZImd2+pHmLQCMgh1mvOjjFsdpv8dEfOVQhte6bGSZb8K1Pxf2TzzjD0AA024j8TR0817SD1A2uI5C4kcdJsjFHNO9g5A1jHNO/DXIt7hQVb/OVPBm6R6V/TgT3/IgWr40cOndisFLfurHc+3FNzYfh5ym+56+nweYMxipFmWFz1wI4tCySX/wVbu3BUiYe3BkIBER7IrrJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(31686004)(6486002)(6666004)(53546011)(6506007)(478600001)(36756003)(86362001)(38100700002)(31696002)(2616005)(26005)(66574015)(6512007)(2906002)(83380400001)(5660300002)(8676002)(110136005)(7416002)(41300700001)(8936002)(66556008)(44832011)(4326008)(316002)(6636002)(54906003)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFXQzhwQTdRQ0VDL1QyRE5TKzBFbXdRdTJnUFQxR0F4L0s3M3JURVZwWldD?=
 =?utf-8?B?Yzh0SXRLN2VHajBKcTZ4RXFoTVE1WmllYVMxQ0dEK0JCclp1SnJzSUVIdnNj?=
 =?utf-8?B?NUpYR0dwelJLOE9OZFRyV0pWckQzL1RMZFlsRzJQZEsxMlJJbDY3dkkzK1ZU?=
 =?utf-8?B?R1BJd2NVYXlVVGZML0FSTCs5OXV5clhsU2tDR25iUUNQelZBV0NYbWJuZlVu?=
 =?utf-8?B?cXZKVnVidlR3R2x3SVVhOTAvc2xHcWs1VjZ3WGdMYVpMUUVBNFJHeWYzQUNB?=
 =?utf-8?B?d0lackF6K2lQREhkczd3ZmNmeThYYmtmTUdUb1R6aWlLdGJrRTBGZ3JZWVY1?=
 =?utf-8?B?V0tPNkk4dEVrZGZ4Z0dTaWZ1NVhaK01TZzVPYXFxRUE5VEd5bHVGOWs2bTNx?=
 =?utf-8?B?dTkwSDJsMHlKZG5RcVUvcWlERFFLTlNWSVplQWM4ZENqQUxwcmdGN3R4UjFj?=
 =?utf-8?B?RUxMb2NLQkpZT2tpNExRK29yc2ZPK3JqMzhDWHRScEF6M3NTZ3BGWFJMaVpI?=
 =?utf-8?B?TWd1LzRJRFY3bmlkM2cyWk9xTWdWOEFrSnNBYU1qeXJyQ1VwN3JvSFpSU0p5?=
 =?utf-8?B?NS82TGM1YXgybVlXcXBEaWJZSHhUelZsUU5aWFpCWE1zcTAvdG5XQ0dSOUNG?=
 =?utf-8?B?OU1aU2xoNXVWMmhwWnp4ZkdEUWhvUm0wcVBwVWpjZ0VVazhvbHp5dDFZNVZj?=
 =?utf-8?B?Q200WmFyQkkvYjNjUmNsUk02aXJRWnhJcFNIMEE2QXRuZ2dURFIzM2paY3Bi?=
 =?utf-8?B?Sno5T1BvMzBYclJKZjd2Q3I5NkFrYURsUzh3Q3k1WGpKTXhLSUNVMXFOYjBM?=
 =?utf-8?B?OVppakwwc0FBMGh5NEhyV01uak9CTSt1YWJGMjgza21TUnE2V3B5bUQ5UFky?=
 =?utf-8?B?NHY5NHlNUUhKYUcrZ1VoOHljS1IxU2NKNG8veVkwWjk4czZpQ1FKcnB2V09G?=
 =?utf-8?B?WHF4ckpZOVJ2NjhRWWNmbGdRRStnNGM5a2UxZHVzcXU4WnFISDVaeWZoWlVG?=
 =?utf-8?B?eEdTUkJlTzBraTZhVTQ0dVIzdFRyMTF2Qk9uMHJsaW1iVHFRN2VYaGFEaThX?=
 =?utf-8?B?NVY3Z3ZPQXZZbmpmck5EcW9IOFJPVXhETkZVSEJhcEttTVh5VDE1aElQMEdH?=
 =?utf-8?B?OUYyd1VxZGtqNUtwd0J5WVIzWk5lR0N3QkgxUk9zd0RUbzArc2YxZUo4MXl6?=
 =?utf-8?B?RWh5aHZQUEpuc2daaGdoZVFXSEVod1FXb1pVQ2lveWdWdGJmV3Bjd0haS2tN?=
 =?utf-8?B?cnRhSFB3ZnBqOXcxS28yWFpsRzBOT2FkQndLK21XNmJ1MkZnQ2lOSDhCZk0x?=
 =?utf-8?B?cVppeU04dEhVOTlBN0lLREY1cWZzZVBOKzBGb0tBOGt2WTBBb0ljSmpEdDlj?=
 =?utf-8?B?dmxscUNBTnNLZ2k0RWhyYTlLakU2MFhBMVVOYnMzT1lPQnBxY0VEQXFLQkg5?=
 =?utf-8?B?aitrYUlGanhNeEtpNUkrVmNQVTZ6clBML1hubm5XNVVlZ29PNXlaYmQ0MDBP?=
 =?utf-8?B?UmFkQ0NxdDRIcEQyalNGV3A5bitmemxWSTM5VDVacUphci81VjdEUnYvaENW?=
 =?utf-8?B?UUN0dlhHNUlJZG5pSnNZTUR4OFVlVGdZNk8zVHE1anlKSzEzRnQxR3dnL1Ba?=
 =?utf-8?B?R244WlVqUlU3UktZaE9MN1plaEZMUXkwaE84cG43NkV0UGdYZzlzREZWOHQ2?=
 =?utf-8?B?VHRHbjd5VXljeVVscjlVQXBKWXIxVlljQjk4UVJQZTNldWZoeGZnT05lR1E1?=
 =?utf-8?B?RTBhTUNJQ2g0Y0VZRkkzR0hHQTZZSjJBTGlLUXQ2YldVY0l4cEFiK0pHTWFk?=
 =?utf-8?B?eitXcWt2U2FuMzMzMGVycExzM2ZPb1BLeWYrb3ZmSzFrdEQvRERYc0JCKzh4?=
 =?utf-8?B?NFYyTTNHNXFOc0FEejBGMVVsQUt4OEwvZWFPUHZ4bk42Wi9QUnluVzJad1Rm?=
 =?utf-8?B?SlhROGphSDlsM1ZVbmtnVE9wWlg4bHN3TThPa01JNTVTaHhEY0l0R0dVczFM?=
 =?utf-8?B?TWpmNE9MSzBNKzB2Q2thTDh6c25xWVNMenNlSVBNY1MrRHMvckZXZk1FMmo1?=
 =?utf-8?B?UTRYbUVJUTZndDVlQzFwbC9acTFoMXpsMEFmRy9rU01zenpvNnE5bHphdEFv?=
 =?utf-8?Q?gTktFdvw8EJVxGJcvieh6weeR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cd9f14-0499-4393-47e8-08dbba15d763
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:11:57.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wcys+QOxMFRgXQFxLCj/jw+Oh3cXaBxr2SF7lehEWxeLQYOi0qFyBd7Bf2VA1UZyzGrORah7aGTK4fM0V311Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/20/2023 14:34, Oleksandr Natalenko wrote:
> Hello.
> 
> On středa 20. září 2023 18:56:09 CEST Mario Limonciello wrote:
>>> When applied on top of v6.5.3 this breaks turbo on my 5950X after suspend/resume cycle. Please see the scenario description below.
>>>
>>> If I boot v6.5.3 + this patchset, then `turbostat` reports ~4.9 GHz on core 0 where `taskset -c 0 dd if=/dev/zero of=/dev/null` is being run.
>>>
>>> After I suspend the machine and then resume it, and run `dd` again, `turbostat` reports the core to be capped to a stock frequency of ~3.4 GHz. Rebooting the machine fixes this, and the CPU can boost again.
>>>
>>> If this patchset is reverted, then the CPU can turbo after suspend/resume cycle just fine.
>>>
>>> I'm using `amd_pstate=guided`.
>>>
>>> Is this behaviour expected?
>>
>> To help confirm where the issue is, can I ask you to do three
>> experiments with the patch series applied:
>>
>> 1) 'amd_pstate=active' on your kernel command line.
> 
> The issue is reproducible. If I toggle the governor in cpupower to `powersave` and back to `performance`, boost is restored.
> 
>> 2) 'amd_pstate=active amd_prefcore=disable' on your kernel command line.
> 
> The issue is not reproducible.
> 
>> 3) 'amd_pstate=guided amd_prefcore=disable' on your kernel command line.
> 
> The issue is not reproducible.
> 
> I should also mention that in my initial configuration I use `amd_pstate=guided` and `schedutil`. If I switch to `performance` after suspend-resume cycle, the boost is restored. However, if I switch back to `schedutil`, the freq is capped.
> 
> Does this info help?
> 

Yeah, it matches my expectations for this issue you reported.
Thanks!

Jassmine can dig into a fix for another spin of this series.

>> Looking through the code, I anticipate from your report that it
>> reproduces on "1" but not "2" and "3".
>>
>> Meng,
>>
>> Can you try to repro?
>>
>> I think that it's probably a call to amd_pstate_init_prefcore() missing
>> from amd_pstate_cpu_resume() and also amd_pstate_epp_resume().
> 

