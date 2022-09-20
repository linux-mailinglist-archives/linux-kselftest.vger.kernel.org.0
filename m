Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827505BDC6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 07:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiITF2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 01:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiITF17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 01:27:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312CB5F58;
        Mon, 19 Sep 2022 22:27:58 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28JMsj2N026427;
        Mon, 19 Sep 2022 22:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HpL42Egz8QXgDHJ7uLfx+DO5fLIvLH13ejN048KjLzc=;
 b=kqX2C6gOYPLIQKw2rTfdRB4ieRiSkTh/IuYnGdWpeBvzoj3IcLfMPYGUzyil8gt6rspI
 UOPjDNjOBu+UCVU8IW2/MnTU1KWmw0l91vp8akZle5ZXqcyekZDH9bz8dtNKjWOA7avB
 HSpL99XBC3eixDoJ1sOfURWcY5CCqEMj1co= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jn9wursgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 22:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIGJdpmWjUPko/P8f5B9TeN7hW/9S1M4/oyZHtqyhL+Q0CsZxpF0Nk+NHY4Iikh+wSFcwMrfx+VoxHYtKm7qlRhy6BT1GXX/lN4gR9wqiXlQe5kKAe57+7m7FOIY5CpkvxrqdiE5X+vpJ7uDNP4c0VJuisHald2iNyEzm3Qn8eKuD+Bx9KNM4DMG6azun3v5OQs7FVzOr0AROANTyeI6oQ2zoSXmoEJPj+J9LGx6wz2GMEWvLRyWjspJgG7LpWk3p0xTh/QTOLKqSeMRXkn6c6ivKUCIqYrj7nbUQh5Ow7S6TwPz5xJGFB1fAXzKfKuGI8sj7Zdqdq0CcwCJRDaV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpL42Egz8QXgDHJ7uLfx+DO5fLIvLH13ejN048KjLzc=;
 b=Mei+4EpnIsyn/fpreBwgrLNIQwL4+y9T/6pySD+JTNWVL5JRtZZOApmoKj/kB1WucRLJMZiZgz70uw0KVol/In1Va1BP/M8otPii59Nog6zU+V3YqERB9j6C1+2czkEHsL5jri4mSMK8VvQYxqnXilvw9TVqDUTuKlqkKn7TWZccE+8rWfDKxGLSnl8Gj3rbxGnTTs5tONiEePy9smV2g59Lf6tjouP+GwyJvq1gklScJvZx0fFq7TPrN1R2rS3Niq8G60HiM1W0rrl1FJoA5QWsa+FxMloHIqTt4/7oF5A0sDgTZkVu3yYVSaoCY9qS7349qX1w1ZkfPJ6wvYWdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR1501MB1959.namprd15.prod.outlook.com (2603:10b6:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:26:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 05:26:57 +0000
Message-ID: <eae58ded-7d6b-bf26-d302-391e3746f7ac@fb.com>
Date:   Mon, 19 Sep 2022 22:26:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v17 11/12] selftests/bpf: Add test for
 bpf_verify_pkcs7_signature() kfunc
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com>
 <20220909120736.1027040-12-roberto.sassu@huaweicloud.com>
 <CACYkzJ7uraUdmGV9gMmTZs1OMb_3Q2DttoaxU-irmrXFudOweQ@mail.gmail.com>
 <045a177ebb15bbf406c4c4d75f48dd45e810be8e.camel@huaweicloud.com>
 <64e8ef59363bcd0f314d4e1eb7483f4dd2b7dbcf.camel@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <64e8ef59363bcd0f314d4e1eb7483f4dd2b7dbcf.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0121.namprd02.prod.outlook.com
 (2603:10b6:208:35::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR1501MB1959:EE_
X-MS-Office365-Filtering-Correlation-Id: 012b0922-633d-475e-087e-08da9ac8bc82
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIIaAMQCgn7iuBW0kuOEjlVuUKwIBE6BjA8xiSmhxdoCIvddvTp/M2UrlGDC32fhI+VdHvvS9gY32malcKSKyajUhRYzcpZ5gsCLRPSojxYawLSRmum3/mpV0V2WoJssb98ntEs4BXI/Xnrxc35D6F0Dl0ttcZKDpqloKe0oIbLac8d7LScepYCG3PJUv/QG1T4rWoTbYeDdgMEhy8R/sxFAPoGSK8Nv7s64vGvtBTHOHLoZUFiCWg78ocVAFw6TURHewJdlv+GWLEImNWOmUtGUQXw41sIULgCpv//yAca2lHGC6iYyzwPg8byfrSloBSFnxDvMFum2hTzr932h5IoTulseZq5YYLOLPjvVr5/tYHhxb+a23MG6GwZpCn85H3Sa2TS+lMkQQk4IkxQ3fWoT8wGVbBy1PO2yqRBZgacueXY6gB4cdMe061Hc8mG261ory7U1Ld2Qv+JC/ZSvTfGPqyW+X41Up0VdGPw1AmNpr6kQtuRXw+ASoKuC8lfiayIU/Kounolf2bWyqX2gM5/TkIME29xaFGYNymjaYBaNC/Qu20O7Jyj3sGcxvlAhuKSWWqUsZgKT6hNWcvvQaSIqj5KEkJ+b3D8U7x6xXIioxcBclIKdcgByIoEIz29BA+LcQ68BawOAGmMRB7YHSUtAlCFe0Ni4fprvE89rT5GmzsEpRz0FJGjxoaxsAP9TMGebROa9nagdk6OyFibz64gz3idOBwSfsgpPkwAQq0Vv9HVYFkQf2jTCBZ9I0utPkuQ09N/5hsWmzNIUhC6hn9F0dp7qubExf0CHszZWi9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(8676002)(2616005)(186003)(83380400001)(31696002)(86362001)(38100700002)(41300700001)(7416002)(8936002)(66476007)(66556008)(66946007)(4326008)(2906002)(6512007)(5660300002)(6666004)(6506007)(53546011)(110136005)(54906003)(6486002)(316002)(478600001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCt1cU1YNGFPenA3UkJrZ1N1SzB5WHZGTFVTSFpHTlY5djRlVm5ROURQVndu?=
 =?utf-8?B?L3BPb20vNkFKcTVLQzlDcDc1TDVSSi9vTkEzOXo5QU9mM0JNR1Q5dEdXaWcv?=
 =?utf-8?B?bTVFUjZjK05XS0RlcWVrcXVWWUNrby9ad0M5aGZodHp0UDV6VTdLMm9VejE1?=
 =?utf-8?B?NUJuckVWeWVJalowVFRTMThpTy9KQUtZcy84bWIxREVUUDhuRjJ0bzRkTmp0?=
 =?utf-8?B?WU54M3NKaVRXVWxVTDllTnpsQVBFdWE5a091RlZidFFtRFM0NVpxWVBlcWhH?=
 =?utf-8?B?am80UnB3UkNsNDZSWitPendXUk1rTEtlTWNIcEFTTSs2VU9ZbDFORE56VzVs?=
 =?utf-8?B?YmpYa0lvN3J5ZTRuODJmdU5OQU9Udkp6MjllTzJxWHVoNldvVUlKTmY1WFBt?=
 =?utf-8?B?cGJQS3loSkxHZnBxNkpvR0xNUWMrUEZCRlhEa1ZmejdKMEwzWDJVaWtCRnJ4?=
 =?utf-8?B?MHp5UXp5ODVOZ0k4YXJLSnNjdDZKSGsvQThrcWo5c3lCcStUSENHQUR3RThS?=
 =?utf-8?B?blR0REJucm1PZWs4MlZHREdQcEp0WkxDQnozdVNWcHlnSEZ4UytOTVdpSyti?=
 =?utf-8?B?RFA2NVd5QndiYzd3ZjZ0R3BueDdRZ0x2djA3cWVkWCtHa0VVQUlNQmphMCtr?=
 =?utf-8?B?aDh0VXNsRCtmK2E1N05PTUZzMjN5YVg0NzBhTm1lRi9KV2hzNjlFaXJaL2wy?=
 =?utf-8?B?NkIzVjRwZUlnZkxNREJnSHRVYSt0MXpmNmttQmtnMHJCNkxGN0MzYzdzMzk4?=
 =?utf-8?B?dDU5QlcxSGdIRW1Mck9TOWFMMThIWXZhSExmZHMxbFcwWWpZTzg2QnY5WXRo?=
 =?utf-8?B?YnJ4WlRGZU9kQit1VUQzaVMrZXVxQWliZDFtSmprKzErSmJUTkREdVFNWVJt?=
 =?utf-8?B?Q20vNHVwM2ZEN01lRjN5RXEyWS9lUk4zTXJzSkVoWCs3TnRZQXY0RFgzNy93?=
 =?utf-8?B?c3B1RkM1SzA1UmlBN29keC85YWMwNVI3aTZGdmtBTHRCeFQ1SHU2c0s1KzhR?=
 =?utf-8?B?cHJ2K3ErZGJ3ajFJOGJPWXYrNkVJZVY1NS90YllHcXJ5K0YzNVV5Y0pRVGkr?=
 =?utf-8?B?M1QvcmsyWENtN2h4Ri9zeVNDNU1qQWVpWFFhdk1LV0MvUDRXRXJDanI3U0ha?=
 =?utf-8?B?aUhBbktjZUxGSnE0R2duSTdJQ1hoVkI0Yjc4aUFQNUZNZ2xTeUU2OXp2WjVY?=
 =?utf-8?B?YWVSQ0JvTGt2eTRyZE9Ga2I5Yzk4M29rcVVCWkhVOUxMLzhnbVVQQU8vQ3dx?=
 =?utf-8?B?TVM1bmZ1dzNJY2IrbWYyV0FLdFg2bzlaaWtTQlZLTGM0NE5UYWhydWtlaWNh?=
 =?utf-8?B?RGtiS01wR1ZaS0RRMEx5My9uSFZVdDNKY3FwWmpGZHFWQWVqSk9SOE04NHV5?=
 =?utf-8?B?WGpkWmVnUTZIekRyeWQ4ekRPa2w1WUY1RGxnRzcvWS8rSXplWkUrbTJld2hC?=
 =?utf-8?B?K1l3Q1BLclVpL1pBQWNkSEFBekRRQTYwNEJtb1BCK3dGeTJIWEpHY2FJZWRB?=
 =?utf-8?B?dEF5MnBvYzZ6bERFRjZTWTVNTzUzUHBQZ3FsS3lXRUgrakVLUWEvSzhLS0h2?=
 =?utf-8?B?d25IWWI5STAzQzJ3SmVobzhrY2I5VXZEZFlqYWVQVWI2Ty84SzZxU1AzSGtq?=
 =?utf-8?B?eG9HMURQOTY1VjJydTg5V2c4ZDRxUWVhMTVXMnZJVTlXUW1QUHVna1JXeHZM?=
 =?utf-8?B?SVA0UU9VaDMyK1U1eUYyRnZybGVKQ3JVM3d3RHlJRzJKbHlSZjVlREpTSkdL?=
 =?utf-8?B?aXQ0U2NYQWVuY0JXVnNzVitxTFpoZ2V2V2RjUHZMSUwzSEc2R3RDbGNmZmdI?=
 =?utf-8?B?b0ZpcTliemk0d0JGN1hhSk1hL0NuWDRjRUwzNVFKWTdXSmp6ZEg1cXd4WGor?=
 =?utf-8?B?NCtqT3pPWHZEeThJOTJ2ZzRYdWtSMkNwU2R4a1ZiOVdkeWtZNVlOd1RyMzZS?=
 =?utf-8?B?SFFFL1pSYmNsUENPc0N3VFVPcHBTNXhvVGE5VmovOGdTS0xLeFJCM3dSVU9a?=
 =?utf-8?B?ZGhTZHRmUWZPK2VDU3FNQUhzZWFiWXp6eFhLdFBRMHZSL05xOTBxK3o5Rm1G?=
 =?utf-8?B?UitQSGN5TXVNbmd2RnZoSDVBTWl6czVHTjhQbnJUSkZHeVZMcjl1Ry9jRlU2?=
 =?utf-8?B?YzJpdXluazYwYnJFb09LYndSNjZhaGg4QzNuZWZwaHVlcWtZTktyMDliUmlr?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012b0922-633d-475e-087e-08da9ac8bc82
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:26:57.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Krt+B2tAevVr1w8PA5wJcKsZjgaGKToC0HA2goc3bLv3FLcrWBBaiv/sNJBR842Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB1959
X-Proofpoint-GUID: 5w1JLbPXeEpGNYR3ghbbrtna3GSx-qo5
X-Proofpoint-ORIG-GUID: 5w1JLbPXeEpGNYR3ghbbrtna3GSx-qo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_01,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/19/22 6:09 AM, Roberto Sassu wrote:
> On Mon, 2022-09-19 at 13:17 +0200, Roberto Sassu wrote:
>> On Thu, 2022-09-15 at 17:11 +0100, KP Singh wrote:
>>> On Fri, Sep 9, 2022 at 1:10 PM Roberto Sassu
>>> <roberto.sassu@huaweicloud.com> wrote:
>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>
>>>
>>> [...]
>>>
>>>> +}
>>>> diff --git
>>>> a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>>>> b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>>>> new file mode 100644
>>>> index 000000000000..4ceab545d99a
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>>>> @@ -0,0 +1,100 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +/*
>>>> + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
>>>> + *
>>>> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
>>>> + */
>>>> +
>>>> +#include "vmlinux.h"
>>>> +#include <errno.h>
>>>> +#include <bpf/bpf_helpers.h>
>>>> +#include <bpf/bpf_tracing.h>
>>>> +
>>>> +#define MAX_DATA_SIZE (1024 * 1024)
>>>> +#define MAX_SIG_SIZE 1024
>>>> +
>>>> +typedef __u8 u8;
>>>> +typedef __u16 u16;
>>>> +typedef __u32 u32;
>>>> +typedef __u64 u64;
>>>
>>> I think you can avoid this and just use u32 and u64 directly.
>>
>> Thanks, yes.
>>
>>> +
>>>> +struct bpf_dynptr {
>>>> +       __u64 :64;
>>>> +       __u64 :64;
>>>> +} __attribute__((aligned(8)));
>>>> +
>>>
>>> I think you are doing this because including the uapi headers
>>> causes
>>> type conflicts.
>>> This does happen quite often. What do other folks think about doing
>>> something like
>>>
>>> #define DYNPTR(x) ((void *)x)
>>>
>>> It seems like this will be an issue anytime we use the helpers with
>>> vmlinux.h and users
>>> will always have to define this type in their tests.
>>
>> It seems it is sufficient to use struct bpf_dynptr somehow in the
>> kernel code. That causes the definition to be exported with BTF. Not
>> sure what would be the proper place to do that. When I tried, I
>> declared a unused variable.
> 
> Easier:
> 
> BTF_TYPE_EMIT(struct bpf_dynptr);
> 
> I added it in bpf_dynptr_from_mem(), right?

Yes, you can add it to a related function. The BTF_TYPE_EMIT
will be optimized out by the compiler.

> 
> Thanks
> 
> Roberto
> 
