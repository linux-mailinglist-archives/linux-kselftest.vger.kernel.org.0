Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD895BDB56
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 06:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiITEWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 00:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiITEWJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 00:22:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAE27155;
        Mon, 19 Sep 2022 21:22:07 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMshqA013980;
        Mon, 19 Sep 2022 21:21:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DgiC6BJRkLib4GpYsBKz1bxvhfWHwUzNnSO7xkcyQ5I=;
 b=PrmOxxnoPwBrpr73vHaYXSjjzp2NHZMF96OIOPsWDF6+54wg+SFSUwh8+GbP9JXBc2y9
 Wufuiq3rnFXeXbeEC/FCJbZqzoPYRZU9liyTroIFEkeF5hXktuqb8dPoVQ9L1xU+fAU9
 4ASb0sBYs4rUmASh/3/oWBE2exf/vRTfV0k= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jq0y6hpwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdBBVzjFUTZS0QVbvFCMdkRYLD1aP6HyyDCF3TWs0Dd/nBRbShZcpSOAxekDRltUiu/5rg4bJ0FLIkuFW4Dkmr1JrOrg46bvJZhWYXNbDNM09AKnhhkSQ9Ufmsbm3uXoEFt2+nEhRTVudoHEaEHC9E6ALS+XqAj/NHf0nkxv94s8euikkAYydT/JaySfmoaqE0U1UO5AnShAmgP8qFgpP91dA+RFOvxRZV0rOWg+pi2DZzyEvPYb7vKu8hPcxLjzxvSIDUiuDKCeYXCfw6PkZRjMUsb6QpUEJdVUoxCOFYMDgYj+dGd2lHQjbOdFTC7W8WJea1wVxiDfcNzjRWoi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgiC6BJRkLib4GpYsBKz1bxvhfWHwUzNnSO7xkcyQ5I=;
 b=KbO/4HStl4aGoEQ7IbPO28exirOy98EbkXdmk0X75p6Q2KKZlDxp0yg0S1mzvT7hIOFooAmIbhlB6Q+ny6J91I2ZPDnBjDEdd8bNSZZfOIF+WNeqccLW8ahCYh9obJkEnRLG88cuYeVUAOCPsA/OcQFYGPALRabX3REKeXqM9Jj2aOgYrKJcAqV4HUDhCCJzZKer23tm9at7Y9/7TDLrP7U5n53QpJQXundkoE5sYrWgacPfH43H5u4sbxnT5UK114d17OXWGYxivImcMPr0l979tissdG8P3FMcO45JpkLVvhSA7Ay8S2VIzELms4te/F5j6Vn8fWRfgWhLATXJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4888.namprd15.prod.outlook.com (2603:10b6:806:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 04:21:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 04:21:07 +0000
Message-ID: <a56094b0-2af9-209f-780a-b5626560800c@fb.com>
Date:   Mon, 19 Sep 2022 21:21:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v17 11/12] selftests/bpf: Add test for
 bpf_verify_pkcs7_signature() kfunc
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
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
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CACYkzJ7uraUdmGV9gMmTZs1OMb_3Q2DttoaxU-irmrXFudOweQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: ce39d8a7-48f9-4019-64d7-08da9abf8a23
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EQ0UuKnBi0JBRDdIQ1hAfJxYIr4XXAQF6G9KVuZ4YsO6B1t3znViUAfdpXMIUf9vIQ/6nZ0RWcY8K1yWxAZXxsgtKF5WwunNIRn5O+YpLApZb7aGqgl0hGvUhlJ7x9YEyuOMi1YZofsQ8ZS5YUsMRQOYMgvjUwEdeBlUuTC4X5HNtwQ1kOf+F/7IGA4kndPlwfbYoWRtIMEoMwrC2ITg/HxKrRQpNhlrVEIQ28+KLfvh6XKgpkSNprXEeXN2kuO8SzCwBkCvK4pN5vxIh20/+WqhM/0O9KDO4J4sTbVuNYGkpKaVN/HWxef9k8Bbrz11QxPW668QYFkrlv5Z7pEA8KQ1+8zQ4Jpr8DlwDk1zaV3439juMmr8YYxlhG8/9J2d5Cl+p48UK6YDm6ON77GEpoy9SfIUM5tXpGiOkmBaCOGQRtxvUXelA4uOKviTr4aLB2YF/jaXfIn3hB+CTx70UOCHHHkiORE9KvJvYtOcRPXZ9lZ+/IAwXGVLiStgdvBEpZbF1Vow1krz+nLPAs9z2vZztNzjDqFVETO2easF1nUs46wZNHpkhY/2UkI8IeXhuJkX7oqpwdbY7kMK8aP4LvYGzX6WW+tmU1UDuSboMlusnXKcokQRcZV7lS8QsUfeJFX+nVttAZrNgQrNk0ALJM5KGY1FK7RVAH78j/u4lnNb7o33D9hwkOvUzOLhpFbpcqEz0P8yKFsEEXlNvdffkT7B/QSQhd01Vv9azO498OZpHixLWcb8M6AN9NqMbr5MN+rBXiE6F1AQl/uW+KYIYDPegkIt6Er2MJbXGIvrKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(6506007)(53546011)(186003)(2906002)(2616005)(6512007)(86362001)(31696002)(6486002)(316002)(54906003)(8676002)(4326008)(41300700001)(6666004)(66946007)(66556008)(66476007)(478600001)(36756003)(7416002)(31686004)(110136005)(8936002)(5660300002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJIR2E4cnRlS2FzVzJLdGdzVXIwOG16bE5yblpETFdkbFRKam4zU0I2VlJw?=
 =?utf-8?B?RnhKUnV2YUNmWnRuYVdCc3k4dVZkRjZaRHc4Sk1kWGlCc2J4WlFyKzJuRk0r?=
 =?utf-8?B?Y2FFUWk0ZVVvMmMzSDV5UHc4a0dEQ2hCU1pqWDBITmdNSHJvZ3ZObVVyK1dI?=
 =?utf-8?B?eCtvdW4wVmJ4QkF0VGFzbWRiSjd1aUJFbHRBTGkxTWhzSlJQS0ppT3dQdzFt?=
 =?utf-8?B?QlFOa2FzVkE0bkhqZFlWYmhBekRxQUNQd1ZDR3Y4amxjSktTU1A3ZXF6bSt5?=
 =?utf-8?B?YUx1M0tKNEs5dmRLZjJrcWFWTUJHSkNPcG9yMDBNWC9WY2RjVjIweVh5Rkps?=
 =?utf-8?B?VURYTlAxbjdWQTFLcm1kc3pweFVURmNWaHhhbjNONVhTMG1LNk5MT2tEWkph?=
 =?utf-8?B?UFRkNU9mNDduS3p3c0l5UnBhQThLOHA3WS84ZFlSNlZXVk1SckNiNTZXMTQ5?=
 =?utf-8?B?NGhRbUNDMUdIbWVNeXJSYnBNdXhTTVFsWGw5SkY1WDMrUFBHK3hUQk9RYm53?=
 =?utf-8?B?WmNIaFVLK2dmTWdzcHhuM2RSdnk3RytRTzhjelZBaWFoL1pVMEtLSHBlbktw?=
 =?utf-8?B?QmdzeGQ0MzFpQnAyc2J0clFQNzd5dEVHNHJsMDkzUHFXRENoSzhaTmpoK2hY?=
 =?utf-8?B?YjBsQ3V3SDB3RFlvV3NpUGxUekZhWkhUV3hXZVJHQzBzazBNUmE3MG90eWFy?=
 =?utf-8?B?bUFHWHFrU0xoOVdqZjZyUjdQZGNnZXp1K2pnNHJYeWZ1aHd3RGNTMFcrcEV2?=
 =?utf-8?B?SjRzSWZkcFRtQWF5QVBUYmRvY0d1V1RrdHF0M2tRa2VXb05HR0pGTWZCbVkr?=
 =?utf-8?B?UzV0NjVFYVp6cW5POTlBVE44ZXlvWXVKY25naTh4MjhMaU42VE5IMWVLQkE1?=
 =?utf-8?B?ZjRib2dJUXNTOHM5aC96UENSYVFqVURCOG40WVZnMXd0UTU3ZlE2MUs0cGZj?=
 =?utf-8?B?UnJOVDZZTCs0aFRXeXZIRWpwdzNQM28vN0VrU0IwVGNmWVJ6bnVldFZ0UGJa?=
 =?utf-8?B?SnNJR3p6UHNNd3hEWXpkRlhNL2xjYVVFM3ZRL2RYbUQxekVWWS9naFh1QS9u?=
 =?utf-8?B?RHgwWjZtbndEK2pDRXBBRVIwTkVUQm1hWTNKSXdDblNFTVc2azdtVHoyc05w?=
 =?utf-8?B?UE41R01WcHNJZnVXZFdKVGs5TjhEcFdGakFQb1Z0Yjl1Nk81NFZGZXlQSGVy?=
 =?utf-8?B?UTJBUkg1cXorRFFoV0dPdGVFTlJZTFdKM0lKblR1YmNKQkIrNE95WE5uWmFk?=
 =?utf-8?B?a2E3ejdOM1REMk5xZmNsVkVqTUR4TUszbldja0UvbEUvMHBxWXNmRHZkMlpX?=
 =?utf-8?B?YmZ6TW9vUUZrMjdPTGIxdDUrMVpPSDVSUzB1N1l2UDlSb1FId2tOMnVFeTR2?=
 =?utf-8?B?Qi9SU3cvbFZvaXJkbmdSQVQxYUplWjluaWVIVmVDdDl2Z0k1NzVmZExDVjRD?=
 =?utf-8?B?RjdtMmxBNlpTeUZrcU1hbEkwQ28rM04xNFBKZXhoL2RObm5Cczh0Y0hBWTZU?=
 =?utf-8?B?UldjN0IvTVlwOEY5QWpSbHNJY1pndUdvRS9XMnpIV096ZUViYTBxZ2kwTkto?=
 =?utf-8?B?blhydXJtbWxCaU1namlScE1qU2gyWjVlQlBucHhqVlNTdWhOMG8wU001MldG?=
 =?utf-8?B?cTUzTUVlNGhxc3hhN2tONHVtcCsrRWFlMnlvb3QrKzBzQ2NRbU40QmZKT2Fv?=
 =?utf-8?B?VHVQMWNVRDFsbC8wVkUyU0ppSzZkTlVLN2NPNXFkaVAwdk1kN2RFYXVHd2hN?=
 =?utf-8?B?Q2htSlg4bmZ3Y0ZHUWJMS0FMREVEekphNURtQUxDamFpQkxHcjk3Y0hQL1ZT?=
 =?utf-8?B?dHRwMGF5YWZWLzNYbk95cFV1SXNQSGJxb2M1R0FGcVhlZGNWTTI4TUQ4azhm?=
 =?utf-8?B?WFZObGh2VlNFS3VBOHhlMTIrWmduUllYNWhkQVlxQmg3REJaMmN3WTRvaFRk?=
 =?utf-8?B?eE9IU3kyWXQrUzZWU0NHYSsvZVpweXNxOHZsM3NXaGZBTk9HVVE5U2VENEpl?=
 =?utf-8?B?czlwYVF3UERrYnYxbkRwU2Fqd3pSVnNuRVhESXQ4cHRRRjlhMi9MeE9FRmRM?=
 =?utf-8?B?MjN6UVcvM042VVBRYXVvQjdoUW1BcCtiekowb043R0dSQUJOaGllczRPcUU2?=
 =?utf-8?B?d1dXcUt3ZEI2a1BJWGJhZ1lKTDY1SVRYaTMrUnA4K1ltRFdpKzdGK0JIdXdP?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce39d8a7-48f9-4019-64d7-08da9abf8a23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 04:21:07.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvitBkQi4OruaOqKDVDcxjIxgla/GkrkGYFuzf7LvtfH2EUwForEffnSHdqQqbTf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4888
X-Proofpoint-ORIG-GUID: lzVjoBNWhYwhpdDX6ZJY9vxYlMtVixXE
X-Proofpoint-GUID: lzVjoBNWhYwhpdDX6ZJY9vxYlMtVixXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_13,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/15/22 9:11 AM, KP Singh wrote:
> On Fri, Sep 9, 2022 at 1:10 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>>
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
> 
> [...]
> 
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>> new file mode 100644
>> index 000000000000..4ceab545d99a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
>> + *
>> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
>> + */
>> +
>> +#include "vmlinux.h"
>> +#include <errno.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +#define MAX_DATA_SIZE (1024 * 1024)
>> +#define MAX_SIG_SIZE 1024
>> +
>> +typedef __u8 u8;
>> +typedef __u16 u16;
>> +typedef __u32 u32;
>> +typedef __u64 u64;
> 
> I think you can avoid this and just use u32 and u64 directly.

For consistency of typical bpf programs and bpf.h, using __u{8,16,32,64}
should be okay.

> 
>> +
>> +struct bpf_dynptr {
>> +       __u64 :64;
>> +       __u64 :64;
>> +} __attribute__((aligned(8)));
>> +
> 
> I think you are doing this because including the uapi headers causes
> type conflicts.
> This does happen quite often. What do other folks think about doing
> something like
> 
> #define DYNPTR(x) ((void *)x)
> 
> It seems like this will be an issue anytime we use the helpers with
> vmlinux.h and users
> will always have to define this type in their tests.

We can use BTF_TYPE_EMIT macro to emit bpf_dynptr type to vmlinux dwarf 
and then to vmlinux BTF and vmlinux.h. For example, with below change,

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 41aeaf3862ec..bbdc53fec625 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1400,6 +1400,7 @@ static const struct bpf_func_proto 
bpf_kptr_xchg_proto = {

  static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
  {
+       BTF_TYPE_EMIT(struct bpf_dynptr);
         return ptr->size & DYNPTR_RDONLY_BIT;
  }

in vmlinux.h, we will have

struct bpf_dynptr {
         long: 64;
         long: 64;};

> 
> - KP
> 
>> +extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
>> +extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
>> +extern void bpf_key_put(struct bpf_key *key) __ksym;
>> +extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
>> +                                     struct bpf_dynptr *sig_ptr,
>> +                                     struct bpf_key *trusted_keyring) __ksym;
>> +
>> +u32 monitored_pid;
>> +u32 user_keyring_serial;
>> +u64 system_keyring_id;
>> +
>> +struct data {
>> +       u8 data[MAX_DATA_SIZE];
>> +       u32 data_len;
>> +       u8 sig[MAX_SIG_SIZE];
>> +       u32 sig_len;
>> +};
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY);
>> +       __uint(max_entries, 1);
>> +       __type(key, __u32);
>> +       __type(value, struct data);
>> +} data_input SEC(".maps");
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +SEC("lsm.s/bpf")
>> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
>> +{
>> +       struct bpf_dynptr data_ptr, sig_ptr;
>> +       struct data *data_val;
>> +       struct bpf_key *trusted_keyring;
>> +       u32 pid;
>> +       u64 value;
>> +       int ret, zero = 0;
>> +
>> +       pid = bpf_get_current_pid_tgid() >> 32;
>> +       if (pid != monitored_pid)
>> +               return 0;
>> +
>> +       data_val = bpf_map_lookup_elem(&data_input, &zero);
>> +       if (!data_val)
>> +               return 0;
>> +
>> +       bpf_probe_read(&value, sizeof(value), &attr->value);
>> +
>> +       bpf_copy_from_user(data_val, sizeof(struct data),
>>
> 
> [...]
> 
>> --
>> 2.25.1
>>
