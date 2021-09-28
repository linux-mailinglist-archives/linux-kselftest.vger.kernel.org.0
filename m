Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32441B543
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbhI1Ri4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 13:38:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6068 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241527AbhI1Riz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 13:38:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SHSlfN028706;
        Tue, 28 Sep 2021 17:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D9ugsbrViSs3rloagVnZAmV06+cU5dMjFgFGvoFxJEg=;
 b=chDFUq4kU3h2QtLWxS+M5vAN2TT5HKPHhcAFHFj2mYbPBB9Hm+lY4Gjtr+mHFrzbwy8Q
 VwK0lEwq9p5O/rCPp0F5e+C/hXgLoQp/I6qEgAjzkzb6HKDEr0YQhalOOiHeKPHhbr4F
 kLD37UGMT4FjraOaBiHZTQJmLQaw8DW1pJ5bmVPLkLEalsye2ARkvZmjxdqXodkUfA9V
 zeT+dYz3t07HU1XoNFZNVO4xkG3cU/xGjTPLzfj3valx619r7JKO03H3fqdHgoOTmkIJ
 DudYrYhAF7o2cmnID47Oy9JRgvdz8F7C+9LH8QBCULnLwWk0VrCWxMtWjiBWi2PGgAFM tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbhvc117b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 17:37:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18SHarCi138110;
        Tue, 28 Sep 2021 17:37:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3bc4k81y3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 17:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFh0/shnm+CCDGO3GLaGapI+lXgeWSRcJc2U6+4seMKlDzHk6KyJzWWt0I0uLduqxpLle/Faxe6O/isZV+HIgerbfVL+2OHcnz+nY2cKPh8jH/p4HtbkOKVVc+GV9/J4QkWIY0gxLRy9Am4u01EhzjsEJrjWOleRMVRZKRTTBQLMC5gCIkdvEZClHlp/9F9wIJtXXeQ5G6JhUhYnaVaiU9GJ8wRf1rwgVlu1x9EP7C7X7oDo6ELdswmBoECnZTltAFiGVapGC4sssNGzdJeUiGh+5S78VYAd+D7Ztu8cxkl4+F4nOLwXZZt93o5H3XUS9hhMkHUnIKu4jpAYYLKNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D9ugsbrViSs3rloagVnZAmV06+cU5dMjFgFGvoFxJEg=;
 b=bCDK78/UtsxfY8Kj7/ce8wTHJ3ZxMGVBIKBmomLDnq1Aa6ETK5qh9v4AAEWda8Hb8RPR0GpiVeo/QI8y7n7h+UDnj1LrjAf7GCRk/XXACrwNEGigs8VC4W27fMMHkAjGaY8urFL1mp67QmO6tIcEmc/Bw5YiUH19gC++PvzH+9KOPCmp/H2r7//J5Hiv2FZIiQKsCALJr4QjWZAo8Q6Jui/wBGoAvyjjq45svAWtVVGiuD3zAc7dRpmOb0V7QvGeWdBzZXMK/kFJYUrdaHQSvNqvZxWqeNeBxserG3l4PjooXtXc3njxfiIS4Fyy446qn9RG8ke7wQeTuNk7CTVq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ugsbrViSs3rloagVnZAmV06+cU5dMjFgFGvoFxJEg=;
 b=JsmMV/1bd2YhZTdgvuVTopwPuGgizIxJgq0OqABpncP3iHl4eYY7w1Nw36UkkHiLCxUeTiRioxD3Wnt7y5QJG8qWJACvjhQwMrqMq8Y8Jxeu7/z8j/Y+Hsq75raNijxF0VWNta7YU2/L8KaLTJ5LXUdH+ZNDHRFbdq6aaBG6YBA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BYAPR10MB3543.namprd10.prod.outlook.com (2603:10b6:a03:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 28 Sep
 2021 17:37:06 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::39ae:71d3:1f4d:b4d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::39ae:71d3:1f4d:b4d%4]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 17:37:06 +0000
Subject: Re: [PATCH 1/1] selftests: KVM: set affinity of VM to right CPUs
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org
References: <20210924233037.4329-1-dongli.zhang@oracle.com>
 <YVIZ/67cfjk18mbe@google.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <5b0a16a9-e98e-368f-4ecd-359c58ae34c4@oracle.com>
Date:   Tue, 28 Sep 2021 10:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YVIZ/67cfjk18mbe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:806:125::22) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7444:8000::1e] (2606:b400:8301:1010::16aa) by SN7PR04CA0167.namprd04.prod.outlook.com (2603:10b6:806:125::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 17:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 853a00a6-79cd-449c-a74f-08d982a6972a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3543:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3543351EAE842BA96FD3BA2CF0A89@BYAPR10MB3543.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpdpXAPHRZn9hzUxGnWwoyH+zJSIrfa4SIjEOhF2N3b7xNHPp4U+YX4oAucveTp3ELkoGbzDWk0GoR0qFh6tGkxc+DGnKKCNNhYlz0IyEYPd33qyXEEXHDZH1/w1s2NMNBTT7pnClEN9VL82R9ORdnqjS51glTsfMOS+j7r8NOODHG3e9diGnOkoYbZpUe8MZ40WGtrzFmE/mlR8yfl47CbLpqgbu4Dwr5CpRKNCuC9CecCBufDkDYLgiLuvNTcujm6bsOD/kI6E+j9OoKF8WxEcIHslFyNiKJ8lOTyUOrmvHnR5xuWd4kvUoX3q54pDxKLtb1ZcZ6Tsdbs8Rnn59YHGa5/H6XTbXM6e7EBTeiZvvKtvKm98vTvxwrrSuwC5Lcd9wS5pSOel3aByeiRtIhIMGt8eHgtlkANYP56Uuxb0ldEXj0Ks7wpKNSs22wOU2Gbm3v/kbAV7M9B9P3HndCFjdL4UE8ACjdoLJ/3znb5nzgyIFAfe+gY4PGB6bb3i9ihgnVPlCEvn/8p7G37MilUHVPOHXslsb4Dp1inUsxqcdwcwjsEuw9RRsmDoVoHXc1BF+EUowY4wEKmA6zjhZwW61HbEUJ1tqIbl2w6EV3ZvfNTPiDTxvzQyfh4bVgKvZiEJ4SBbsxX9namNUYwaGj+lEpW4w8rNEWQ4D52dS7IZgrva1XSjy/AxqEmBcV2HCJlGrn6Sl2EaXnzL1v8hlyz8qe9Bc+7nP3hso/TskHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(83380400001)(4326008)(66556008)(66946007)(8676002)(316002)(6916009)(508600001)(31686004)(86362001)(31696002)(66476007)(38100700002)(36756003)(2906002)(44832011)(5660300002)(186003)(2616005)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVZveWZ6T0NJM0hsei9JVDlNMGx3T3VhTjQrUlVLc1VJRmFISVhrSWVZWngx?=
 =?utf-8?B?Ym1QYzFKdGpSRE1uVFhVaEQ5RHhDVjhWK003YUtuU3J4dUZWa0pldWk4U2U3?=
 =?utf-8?B?ejZRNlJhUWFGS3ozY2lKRytZZlNVb1dVVTJ1Ums5cmVzM1dNUUxERlR3Z1Iz?=
 =?utf-8?B?WGliSlRoRDl0dDBEcjNMVDd2QWFzNjZnK1QxY1dFQjNCRFV1dnFtamRnSzN6?=
 =?utf-8?B?bWd0dS8venhQL2JFQnRjSXZ6NDF0Qmg0QnEzVUNZK2NwOWgwTFhMMDBhNUJF?=
 =?utf-8?B?WmxTKy90bGw4cUx6aWlLSW14bGhRRzVUVFVoM2l6TkxLOURqamgvdUNjdTUx?=
 =?utf-8?B?WTlUczFuQ3IwNVlrWnFTYUNhVTVYbysvbEkzNnhWZUZ5VTAvcHV3STU4dm5w?=
 =?utf-8?B?SzlCLzlIUmZVS2ZtaFNPVWIzNzdDY2pUYVNMaEZnUlIyU0s0bjBwL0lML01H?=
 =?utf-8?B?ZE5uMUVKeEtFRC9ldDF1SHd2aDh6aGxSMWVvWTlic0FtU0hBS2x0S25QK2g5?=
 =?utf-8?B?aEQxeStveU1HYTZlM2drdVhPeVQyUkdhNVlKME5aVzdTZVkrVFg2YnBXSm5X?=
 =?utf-8?B?MGhhNkhOV0xPVWZwR1J4RDF5cVU5dDhZbDlqSTNPUE1ZUVNOQTRHc0F5Q0t6?=
 =?utf-8?B?YWs1cFZDeEtlNUNUN1Y1YjQxUFJNbEQ0bDRkeUVjYmFsK09Ob0F3czEyNXMw?=
 =?utf-8?B?N0kwYmhyQ0JlM2VoZWtkSmJhSkRkR1ZUNzlvb00xZ3EvMUE0T1k1eWxaYTJ5?=
 =?utf-8?B?U1FSUDNCT0JtQ2NIZjZmTWp0THJkZ21kR2c3S01JQmxJbUpNbWk4SWpUajB5?=
 =?utf-8?B?NkV5Uk1SbjZja1UxWVdRMVkzV21MZ2UzOXNPVG5qaHloU2c3VW9nWVBXOGZv?=
 =?utf-8?B?Z29CT29BZERpQW4rb2l1c3UrR29LY0Q1M0ttV2h1ampydUdwVVZSazhKUGV2?=
 =?utf-8?B?MHlJTGdCZmVwOXZZeGFIQUVpTWgzakt5WWNBVzdGU3EwdG94d3ZwM3RLUnQ1?=
 =?utf-8?B?M00zZDZkSEdyUHZQQURKdTBLdG5yNDhWVXVKZmd1cTN5bXVZbEN3V1dGY29k?=
 =?utf-8?B?UlBzUjBoUkMrU3cwQ2FtOE9rc0Rnck1XbXFsblRtUUd3N1ZhWlNJbGtpWmRk?=
 =?utf-8?B?ZFR5ZmVLeHRRY3g3SmRXdFZVMmhwK0ZRV0hVRG9qRVhxTU92WmNzSk5sSFpu?=
 =?utf-8?B?NTRlREM0NzVJbjcrVVVlaE55aUFyS2FGaTN3c0xneGM1aSs0MkhMNy80Y25i?=
 =?utf-8?B?Yi9vbnFVWDdiaWE3UGs0b1pXeUlGZ2hKVVc5Uzh3aDhDNWtlL3IwSmdnRkVM?=
 =?utf-8?B?dUd4OVdjdHhuS0lBdkZ4YVc2dnNjS1RNSityejVLKzM4ckNpTVVpb1NDM3Rs?=
 =?utf-8?B?TDlSdDJvT29SWTFRVEJCOG16VkRaRHFsVEhDcXh1RW1YSU5VZlQrQWpQMEJY?=
 =?utf-8?B?SXN5NitDNEpzdHh3OCtBaVdmNk5hOVlQQVhub2I3eDl5UmVvY1g2QnZWcjhW?=
 =?utf-8?B?d2g5elZxSUNTV0s3TnVTOVplNlJXYmlPeG9CVHFqRnM0VmgvQ1lwUkM4SkRq?=
 =?utf-8?B?RGx2M2owdHB1ek9xcnAybkNWNG1EMTA3ODF5SlJablNYbng3YkplMzQyVFY4?=
 =?utf-8?B?cFNsVFFtdytiZUUxUGU0R2ZKdXZZUDBsWDJkUUVUdUZEdDdicUtwYmR0YWZC?=
 =?utf-8?B?MUJuS0x6VDRBZUd6b0tjcGlnc0prdGw2bU1mWnhQcHNzcFBMaWl0S0xIaDAy?=
 =?utf-8?B?UWV3THNLMUllSzV1U29rK2lkQVlVdEJKS3JOaGpGYmg2OGRZWkswcWlTSjJy?=
 =?utf-8?B?MlVpd1lRVGw5TWVZaUNoQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853a00a6-79cd-449c-a74f-08d982a6972a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 17:37:06.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYody7DZnse6YxuRUaspPaUdebGqF5D+wtM9sM3wmpTEooZetexRwGbBEmR8ol26+r2OCEBpKEFPjEwgfGvXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280103
X-Proofpoint-ORIG-GUID: AzoJEBrVERypL4LeqZwSOUnpcI2LI00T
X-Proofpoint-GUID: AzoJEBrVERypL4LeqZwSOUnpcI2LI00T
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/27/21 12:22 PM, Sean Christopherson wrote:
> On Fri, Sep 24, 2021, Dongli Zhang wrote:
>> The nr_cpus = CPU_COUNT(&possible_mask) is the number of available CPUs in
>> possible_mask. As a result, the "cpu = i % nr_cpus" may always return CPU
>> that is not available in possible_mask.
>>
>> Suppose the server has 8 CPUs. The below Failure is encountered immediately
>> if the task is bound to CPU 5 and 6.
> 
> /facepalm
> 
>> ==== Test Assertion Failure ====
>>   rseq_test.c:228: i > (NR_TASK_MIGRATIONS / 2)
>>   pid=10127 tid=10127 errno=4 - Interrupted system call
>>      1	0x00000000004018e5: main at rseq_test.c:227
>>      2	0x00007fcc8fc66bf6: ?? ??:0
>>      3	0x0000000000401959: _start at ??:?
>>   Only performed 4 KVM_RUNs, task stalled too much?
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  tools/testing/selftests/kvm/rseq_test.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
>> index c5e0dd664a7b..41df5173970c 100644
>> --- a/tools/testing/selftests/kvm/rseq_test.c
>> +++ b/tools/testing/selftests/kvm/rseq_test.c
>> @@ -10,6 +10,7 @@
>>  #include <signal.h>
>>  #include <syscall.h>
>>  #include <sys/ioctl.h>
>> +#include <sys/sysinfo.h>
>>  #include <asm/barrier.h>
>>  #include <linux/atomic.h>
>>  #include <linux/rseq.h>
>> @@ -43,6 +44,18 @@ static bool done;
>>  
>>  static atomic_t seq_cnt;
>>  
>> +static int get_max_cpu_idx(void)
>> +{
>> +	int nproc = get_nprocs_conf();
>> +	int i, max = -ENOENT;
>> +
>> +	for (i = 0; i < nproc; i++)
>> +		if (CPU_ISSET(i, &possible_mask))
>> +			max = i;
>> +
>> +	return max;
>> +}
>> +
>>  static void guest_code(void)
>>  {
>>  	for (;;)
>> @@ -61,10 +74,13 @@ static void *migration_worker(void *ign)
>>  {
>>  	cpu_set_t allowed_mask;
>>  	int r, i, nr_cpus, cpu;
>> +	int max_cpu_idx;
>>  
>>  	CPU_ZERO(&allowed_mask);
>>  
>> -	nr_cpus = CPU_COUNT(&possible_mask);
>> +	max_cpu_idx = get_max_cpu_idx();
>> +	TEST_ASSERT(max_cpu_idx >= 0, "Invalid possible_mask");
> 
> I feel like this should be a KSFT_SKIP condition, not an assert.
> 
>> +	nr_cpus = max_cpu_idx + 1;
>>  
>>  	for (i = 0; i < NR_TASK_MIGRATIONS; i++) {
>>  		cpu = i % nr_cpus;
> 
> This is still flawed, e.g. if the max CPU is 1023, but the task is pinned to _just_
> CPU 1023, then the assert at the end will likely still fail because the migration
> helper is effectively only running 1/1024 loops.
> 
> It probably also makes sense to grab the min CPU to reduce the pain if the task
> is affined to a small subset.
> 
> As an aside, _which_ CPUs the task is affined to seems to matter, e.g. some
> combinations of CPUs on my system don't fail, even with 100x iterations.  Don't
> think there's anything the test can do about that, just an interesting data point
> that suggests pinning while running tests may be a bad idea.

I agree sometimes the failure is expected and reasonable. E.g., I am able to
randomly reproduce the failure if I reduce NR_TASK_MIGRATIONS to 1000.

> 
> Anyways, something like this?
> 
> ---
>  tools/testing/selftests/kvm/rseq_test.c | 44 ++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 060538bd405a..befd64c27152 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -10,6 +10,7 @@
>  #include <signal.h>
>  #include <syscall.h>
>  #include <sys/ioctl.h>
> +#include <sys/sysinfo.h>
>  #include <asm/barrier.h>
>  #include <linux/atomic.h>
>  #include <linux/rseq.h>
> @@ -39,6 +40,7 @@ static __thread volatile struct rseq __rseq = {
> 
>  static pthread_t migration_thread;
>  static cpu_set_t possible_mask;
> +static int min_cpu, max_cpu;
>  static bool done;
> 
>  static atomic_t seq_cnt;
> @@ -60,16 +62,17 @@ static void sys_rseq(int flags)
>  static void *migration_worker(void *ign)
>  {
>  	cpu_set_t allowed_mask;
> -	int r, i, nr_cpus, cpu;
> +	int r, i, cpu;
> 
>  	CPU_ZERO(&allowed_mask);
> 
> -	nr_cpus = CPU_COUNT(&possible_mask);
> -
> -	for (i = 0; i < NR_TASK_MIGRATIONS; i++) {
> -		cpu = i % nr_cpus;
> -		if (!CPU_ISSET(cpu, &possible_mask))
> -			continue;
> +	for (i = 0, cpu = -1; i < NR_TASK_MIGRATIONS; i++) {
> +		do {
> +			if (cpu < min_cpu || cpu > max_cpu)
> +				cpu = min_cpu;
> +			else
> +				cpu++;
> +		} while (!CPU_ISSET(cpu, &possible_mask));
> 
>  		CPU_SET(cpu, &allowed_mask);

I see. The idea is to search within between min_cpu and max_cpu for each
NR_TASK_MIGRATION iteration to find the next cpu.

Perhaps a linked list is more suitable to here (when there are 1024 cpus and the
task is bound to both 1 and 1022) ... to pre-save the possible cpus in a list
and to only move to next cpu in the list for each iteration.

However, I think min_cpu/max_cpu is good enough for selttests case.

Would you please let me know if you would like to send above with my
Reported-by, or if you would like me to send with your Suggested-by.

Thank you very much!

Dongli Zhang
