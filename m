Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4F39E772
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jun 2021 21:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhFGTZ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 15:25:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51126 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231163AbhFGTZ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 15:25:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157JKiTE030946;
        Mon, 7 Jun 2021 19:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rmZiz+Ua93H36d2blNl6PtRkAp7UrPGt/9yYlTmsTqU=;
 b=EIIaU8GcxaXjQV46woGk53Ea0acNXX9uu/mcPOaiA+gkn3YyqPgQQKGy/ae4smNGRpwe
 cu9hQd6EM/hwxXFcx1ySmKqnFSy8xDnlo29ogcB9Z/IBq44Qa/O9+UY/nyRJHA/49oq2
 ENcZPKkbOPG7qnwBxSxIEBQwcE6KzmeHmLSDT026V8z6eZmssGy7h1e8o18Htyy0Qeyb
 yGwO/TtjgA1MT7C5JI1v0DA9+yZ1BZ4ySq0RBRutcMPcyp7SANwfa/8srqt2O4Cs4qci
 NRBE5+fcZulff3sRFrZcTNjaRwpg/lMSU1p2s6CNseUj4e9MKv4Vte1ivINyg/WRmAHc 5w== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3917d4gbsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:23:20 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 157JK2cJ095797;
        Mon, 7 Jun 2021 19:23:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 38yyaab6sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/d4cUGZubLcRKa2la2fvH9bVY/gTNcZnyur9nX5I9mGfDmuIxJZeSf/eARO/d5Tr162pr1r9HKx2g6WLEdsFxB8dgyOff9crgT3Xa5JwowERCpaM4LY22d4vtfOEB91yzKJtuxf06mkS/gmQOmQ+lf0v9LVgQ0o4GDCqUXQwmPoUejExgxGwUZXnk/rv+4q1fVR4sooBMOiBm94S1MUi9pAGYoYK79ze62gWxJDSfCAMY8IK3FVh6QmcOYdoPqXT4HwTEGy274f4QWqVdufGjUkznDmBr9KtLQrjNyritQFyr6hmSzWGz2upKArsOU5FFq5BriMzlrv2/HcSS+Dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmZiz+Ua93H36d2blNl6PtRkAp7UrPGt/9yYlTmsTqU=;
 b=BB2mf/xRy29HBCRPv/Vi0M9g05PQbTumqosHA39ZRTJ0pWSjnJpRJlMJ/pI70/01GIkZl2rhgmUF4EtHA7UaMTg8H8NJRyLme1GJIUYSDpLrBrpBB9PAwbuVpqwTsyl3MPFJ98XL4u6siWyLnbbCPV7gSq707NK9e/x8kd/jxBpE74FitAfxb9qYBWSisIEOAzmDFeJiL/nVwvY5swY8/zE2bZCgMiY64e8qbp/0w1Uvi8pUPNr4cV2M3LTT+w5a0M2YCHLhhaQnQZhqvbWWhthykYVyrwnkzumtYKvuBxgMwW2hgpOJcSPZ1vHjgGWPCuUPYpjXRYpzECL6nWnz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmZiz+Ua93H36d2blNl6PtRkAp7UrPGt/9yYlTmsTqU=;
 b=ffRSFe74gOwTP3TjjS5acXGlX6PM7z6URoTrh5IxoDbr8UQ1Nc4sNNO4lEDb/78HAQKntQEOaNjktrmhus40GqmJlOTzmMOf2c25q9QST5QJjbJvJWv0ofl4jUYkgRaX8HSFxF+7tG/B9Cweu7uJOTItxbPUhe05BynA4OG1hUU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SN6PR10MB3455.namprd10.prod.outlook.com (2603:10b6:805:cd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 19:23:17 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:23:17 +0000
Subject: Re: [PATCH v7 4/4] KVM: selftests: Add selftest for KVM statistics
 data binary interface
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-5-jingzhangos@google.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <122adf1f-1cb8-8cc4-d52f-8e434ab6c95b@oracle.com>
Date:   Mon, 7 Jun 2021 12:23:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210603211426.790093-5-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN6PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:805:ca::33) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SN6PR16CA0056.namprd16.prod.outlook.com (2603:10b6:805:ca::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 19:23:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f73405a-92cd-41d9-320f-08d929e9b3d6
X-MS-TrafficTypeDiagnostic: SN6PR10MB3455:
X-Microsoft-Antispam-PRVS: <SN6PR10MB345585962BC3CDC9D0B08F6C81389@SN6PR10MB3455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GOYvuNAaAQgQDfEi/REtlY+zQEA8LewP/rUoc7HL0ZvlbxIwsRyNpVYHiRNa+QRZPeXiehXAQiYmPT9ASbEbDr3l4+OLyh9B6+F2erkjvE1YMBYy898kCHjBahQPOmfLYMtOiGDORhWgHUVYc3NB8Hll9BLi9mQvPvduRwsbB3KmgRQ+pPf//fUdrQoEei++KiddQpNVZD5JNDRpk46A9FEwbTiTNBN3jM9CbyWYTDXyN/fVctik488nLo0qqN5p6d4QkhDETTvrJbmLwETICX7EGLnqOi9cV5QTc71wLlRzlwIb7WlN7JTkPQii4LcBPvhgxzQMe4BvFc/tVeTVw5smljJLg56W/7N8e3JCOIGGCtFLtweR33S5Wz+3F5RAKuYLdSLrFkYfHa+0AQedcH97HfCGVZkswz0g3oSyNfkFIz2pm5UwcnYDbn2g0yfAUJvmGj3O+qfhSbBOrHSWxT72LNum2oyKrFoO1YT7hqDWSzgVq5GoYlPu6fN3QWZ6kPJWJfuInP+/HJTFNkksrwtdPp+PpQBG8EpLVD/xa1Mg3T4ZEStrXE4fzFA8qrtweoNwFo0IK76wjeBE//0CjS8Bko7MadM5uXnmRokYsDm7sHSOVPcBD3Z3IM0rhXj4Mw0MCeKvk3yJonuvTSAHr+b1CEOsGg80tFw9C0XhN5va9aElfbkT3bsW8qwOqvgdjcMmIhR5cEuCWuwtkzpfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(2616005)(30864003)(8936002)(6486002)(110136005)(316002)(5660300002)(2906002)(6512007)(6666004)(66556008)(53546011)(38100700002)(921005)(66476007)(31696002)(7416002)(186003)(86362001)(16526019)(66946007)(44832011)(7406005)(478600001)(83380400001)(31686004)(36756003)(8676002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnhjdnlDR2haMFIwbXkxTnJqN2RKY0hXZU9JMmFieDRwSFhqdVdNdC9JbDlX?=
 =?utf-8?B?R0QvY1M4T0JnMWh2aytSN2kwZWF0UUxsaUllY2hwR0ZPYzRzMWNLZWdGVisw?=
 =?utf-8?B?azFxUzBLTG00VHpHR2JieWNVVjR4dHF2RUdUdnY5SiszUU5rVjBsaVNuMGRa?=
 =?utf-8?B?Tmh5TTFOa09ZemdiUzhSWXlXaHJNVnpIeE92TUppUWh4S0lLdmY3Nkd4Misr?=
 =?utf-8?B?UWp5MWp3UktiWlJRRGNmVXBrQnZNR3h3KzAyb3BxVDVzdXRKUFJVK0Q1TFBq?=
 =?utf-8?B?YUFDbVAwNFVOZzRleitGVTdaT29rOEplRHc0endOWHNHbnpBNmxmM1lOUnRa?=
 =?utf-8?B?bXhEOFYzM2tadkp2M2VraE9BU011d3ZUODhIQndLbEQzVmoyckk3K3I2SlBC?=
 =?utf-8?B?R2RaRzdYQjNPblhBZkNXdGkvT3M5dU5SRkZpYThSTGFjME5NQkNNQ25VYk1o?=
 =?utf-8?B?V0dpM0VWeERYQWwwMjhYaHJJSXJlY21iaytvdnphMm9Kd2FaclExU2JSdWRj?=
 =?utf-8?B?bENpaVNTSVdDWnFtOWhucXJwbzM1aE9hcmlRTVp0UGRIbWNHQnVKMVJCWW0r?=
 =?utf-8?B?Q1JZTk0wNkF6RjY1TDJIRlY4TStWcVJHS3ZsZi8ybUprR3B6YzZGekVUS2Jv?=
 =?utf-8?B?bXB2eXNyWng1THdPYzIvekI2NUpSWWtPek9qK2l5WUpqZGRWLzlBNm13ejlV?=
 =?utf-8?B?MzE5aHdGb0NEQVVLN1JyY1c1OUYvUmR0Tm56OVB1clh4aVFraXFPdEExV21q?=
 =?utf-8?B?V3hoZTZyRlB2d2pvUWpsU0E3UTdHVFp3dWdISUozMGpGaXlHWWwxNEFSQVl2?=
 =?utf-8?B?QTA1NHRpNE9ZZHA4R2VPRXc1SmxqM2J4QTVCZHZHbldmZ0tEcGpOTzZJck9J?=
 =?utf-8?B?cTFlUTNRRmdoaUpBRERUL2JGRHJRaXVhaEY4TnJBY0hramJ4RWVSQnlWcTl4?=
 =?utf-8?B?M3VOdHZuaWJkc3BGNXpZSVFHL3ZiLzIyd0FadldHclduTks3bG56c3pJeWJa?=
 =?utf-8?B?VHpTNDkvN1NRck1TVExLcFp2djlkNjN3UDdodkxSemQ3Nk1UVXkzUEY4ZTBE?=
 =?utf-8?B?LzBWUm5KSlFJd2kyUkhZOU1GYm8wQW11MWRyRFp2ZnJJWWdVK2wvMlF0eVdP?=
 =?utf-8?B?T1hXdE1DbEZBYTVhbHhCMW1TdHlrZEpXbkswY3FWRkhZcTV6VTd4c1lYbVhk?=
 =?utf-8?B?U3diU2dnOXovZzhBN0VoQzJhbEROdVB3NHo1Qkk5UTV0Uy9oV2FVZWFGMzFy?=
 =?utf-8?B?d0NYVkk0eWFMLytFNVBSME1nSko0dTU5MmdzbnFTK3hMOXhwWGMxM01IMHVQ?=
 =?utf-8?B?RE9TTk1xSFVKTFprSm15bW1nZW9iem1ScGJYV05WN3FsVjE1RkRLWlgyWXJ4?=
 =?utf-8?B?bDl4Mk5ucTFTOEdCVkx5WVNCeXU4YTB5R1BPdE5uVGNJSHRHTU9hZWFVWWFo?=
 =?utf-8?B?N05PWXJ4bWdRMnM1czBqUSszcDQyd0VWRGdZR1QwUUw4cnVKY3dsOWhackZN?=
 =?utf-8?B?eWZHUGZ0RGNSUGxJV1BIM3l2OWo0blM3all1L2FPRVdpaTA0elArZkhXeDBz?=
 =?utf-8?B?R0twOEFuQWVXWlNNNGNpUXhvVy9QL0xsMWVwT1RpczF1amp2dkFqUzh5R250?=
 =?utf-8?B?S1dhYWo0ckRhdllEdFN0bTdIYmxzdHgzdUhNM1pkdXFjTzVva3ZUemtxL2pQ?=
 =?utf-8?B?SUJKcWJFbDJkcm9Iei95aDhmSDFaYXh2M1oyVGF2SWdBajZBUWd1MmY5Qm95?=
 =?utf-8?B?L0d2SGREekVuUTNVdXBlTmFvYlR0UmIzWDNiSkhjWVZWbXdzSmNQSEJ1MFVn?=
 =?utf-8?B?WnhkYXdCS2txYWo4cHl3dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f73405a-92cd-41d9-320f-08d929e9b3d6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:23:17.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mq9DA88p/+HzcF+A+RwDl80j98i8WHb86APCOZ0JY30qmBX5BMqh20GmtdtzlTByDcGAx63t4T44dV+WJK8JtCrPdptRisRb0wpILKDgYl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3455
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070131
X-Proofpoint-ORIG-GUID: -YlGwfWm2PvcJO5y2bzbAQHR5JGJ4rx8
X-Proofpoint-GUID: -YlGwfWm2PvcJO5y2bzbAQHR5JGJ4rx8
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/3/21 2:14 PM, Jing Zhang wrote:
> Add selftest to check KVM stats descriptors validity.
>
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   3 +
>   .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>   .../selftests/kvm/kvm_binary_stats_test.c     | 215 ++++++++++++++++++
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
>   5 files changed, 234 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index bd83158e0e0b..d1c3ee7d3e41 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -43,3 +43,4 @@
>   /memslot_modification_stress_test
>   /set_memory_region_test
>   /steal_time
> +/kvm_binary_stats_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index e439d027939d..0cd46d6d1e15 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -76,6 +76,7 @@ TEST_GEN_PROGS_x86_64 += kvm_page_table_test
>   TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
>   TEST_GEN_PROGS_x86_64 += set_memory_region_test
>   TEST_GEN_PROGS_x86_64 += steal_time
> +TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>   
>   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
>   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
> @@ -87,6 +88,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>   TEST_GEN_PROGS_aarch64 += kvm_page_table_test
>   TEST_GEN_PROGS_aarch64 += set_memory_region_test
>   TEST_GEN_PROGS_aarch64 += steal_time
> +TEST_GEN_PROGS_aarch64 += kvm_binary_stats_test
>   
>   TEST_GEN_PROGS_s390x = s390x/memop
>   TEST_GEN_PROGS_s390x += s390x/resets
> @@ -96,6 +98,7 @@ TEST_GEN_PROGS_s390x += dirty_log_test
>   TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
>   TEST_GEN_PROGS_s390x += kvm_page_table_test
>   TEST_GEN_PROGS_s390x += set_memory_region_test
> +TEST_GEN_PROGS_s390x += kvm_binary_stats_test
>   
>   TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
>   LIBKVM += $(LIBKVM_$(UNAME_M))
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index a8f022794ce3..96d15da3d72e 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -387,4 +387,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
>   #define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
>   	__GUEST_ASSERT((_condition), 4, (arg1), (arg2), (arg3), (arg4))
>   
> +int vm_get_stats_fd(struct kvm_vm *vm);
> +int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
> +
>   #endif /* SELFTEST_KVM_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> new file mode 100644
> index 000000000000..081983110dc5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * kvm_binary_stats_test
> + *
> + * Copyright (C) 2021, Google LLC.
> + *
> + * Test the fd-based interface for KVM statistics.
> + */
> +
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include "test_util.h"
> +
> +#include "kvm_util.h"
> +#include "asm/kvm.h"
> +#include "linux/kvm.h"
> +
> +void stats_test(int stats_fd, int size_stat)
> +{
> +	ssize_t ret;
> +	int i;
> +	size_t size_desc, size_data = 0;
> +	struct kvm_stats_header header;
> +	struct kvm_stats_desc *stats_desc, *pdesc;
> +	void *stats_data;
> +
> +	/* Read kvm stats header */
> +	ret = read(stats_fd, &header, sizeof(header));
> +	TEST_ASSERT(ret == sizeof(header), "Read stats header");
> +	size_desc = sizeof(*stats_desc) + header.name_size;
> +
> +	/* Check id string in header, that should start with "kvm" */
> +	TEST_ASSERT(!strncmp(header.id, "kvm", 3) &&
> +			strlen(header.id) < KVM_STATS_ID_MAXLEN,
> +			"Invalid KVM stats type");
> +
> +	/* Sanity check for other fields in header */
> +	if (header.count == 0) {
> +		printf("No KVM stats defined!");
> +		return;
> +	}
> +	/* Check overlap */
> +	TEST_ASSERT(header.desc_offset > 0 && header.data_offset > 0
> +			&& header.desc_offset >= sizeof(header)
> +			&& header.data_offset >= sizeof(header),
> +			"Invalid offset fields in header");
> +	TEST_ASSERT(header.desc_offset > header.data_offset
> +			|| (header.desc_offset + size_desc * header.count <=
> +				header.data_offset),
> +			"Descriptor block is overlapped with data block");
> +
> +	/* Allocate memory for stats descriptors */
> +	stats_desc = calloc(header.count, size_desc);
> +	TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
> +	/* Read kvm stats descriptors */
> +	ret = pread(stats_fd, stats_desc,
> +			size_desc * header.count, header.desc_offset);
> +	TEST_ASSERT(ret == size_desc * header.count,
> +			"Read KVM stats descriptors");
> +
> +	/* Sanity check for fields in descriptors */
> +	for (i = 0; i < header.count; ++i) {
> +		pdesc = (void *)stats_desc + i * size_desc;
> +		/* Check type,unit,base boundaries */
> +		TEST_ASSERT((pdesc->flags & KVM_STATS_TYPE_MASK)
> +				<= KVM_STATS_TYPE_MAX, "Unknown KVM stats type");
> +		TEST_ASSERT((pdesc->flags & KVM_STATS_UNIT_MASK)
> +				<= KVM_STATS_UNIT_MAX, "Unknown KVM stats unit");
> +		TEST_ASSERT((pdesc->flags & KVM_STATS_BASE_MASK)
> +				<= KVM_STATS_BASE_MAX, "Unknown KVM stats base");
> +		/* Check exponent for stats unit
> +		 * Exponent for counter should be greater than or equal to 0
> +		 * Exponent for unit bytes should be greater than or equal to 0
> +		 * Exponent for unit seconds should be less than or equal to 0
> +		 * Exponent for unit clock cycles should be greater than or
> +		 * equal to 0
> +		 */
> +		switch (pdesc->flags & KVM_STATS_UNIT_MASK) {
> +		case KVM_STATS_UNIT_NONE:
> +		case KVM_STATS_UNIT_BYTES:
> +		case KVM_STATS_UNIT_CYCLES:
> +			TEST_ASSERT(pdesc->exponent >= 0,
> +					"Unsupported KVM stats unit");
> +			break;
> +		case KVM_STATS_UNIT_SECONDS:
> +			TEST_ASSERT(pdesc->exponent <= 0,
> +					"Unsupported KVM stats unit");
> +			break;
> +		}
> +		/* Check name string */
> +		TEST_ASSERT(strlen(pdesc->name) < header.name_size,
> +				"KVM stats name(%s) too long", pdesc->name);
> +		/* Check size field, which should not be zero */
> +		TEST_ASSERT(pdesc->size, "KVM descriptor(%s) with size of 0",
> +				pdesc->name);
> +		size_data += pdesc->size * size_stat;
> +	}
> +	/* Check overlap */
> +	TEST_ASSERT(header.data_offset >= header.desc_offset
> +			|| header.data_offset + size_data <= header.desc_offset,
> +			"Data block is overlapped with Descriptor block");
> +	/* Check validity of all stats data size */
> +	TEST_ASSERT(size_data >= header.count * size_stat,
> +			"Data size is not correct");
> +
> +	/* Allocate memory for stats data */
> +	stats_data = malloc(size_data);
> +	TEST_ASSERT(stats_data, "Allocate memory for stats data");
> +	/* Read kvm stats data as a bulk */
> +	ret = pread(stats_fd, stats_data, size_data, header.data_offset);
> +	TEST_ASSERT(ret == size_data, "Read KVM stats data");
> +	/* Read kvm stats data one by one */
> +	size_data = 0;
> +	for (i = 0; i < header.count; ++i) {
> +		pdesc = (void *)stats_desc + i * size_desc;
> +		ret = pread(stats_fd, stats_data, pdesc->size * size_stat,
> +				header.data_offset + size_data);
> +		TEST_ASSERT(ret == pdesc->size * size_stat,
> +				"Read data of KVM stats: %s", pdesc->name);
> +		size_data += pdesc->size * size_stat;
> +	}
> +
> +	free(stats_data);
> +	free(stats_desc);
> +}
> +
> +
> +void vm_stats_test(struct kvm_vm *vm)
> +{
> +	int stats_fd;
> +	struct kvm_vm_stats_data *stats_data;
> +
> +	/* Get fd for VM stats */
> +	stats_fd = vm_get_stats_fd(vm);
> +	TEST_ASSERT(stats_fd >= 0, "Get VM stats fd");
> +
> +	stats_test(stats_fd, sizeof(stats_data->value[0]));
> +	close(stats_fd);
> +	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
> +}
> +
> +void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
> +{
> +	int stats_fd;
> +	struct kvm_vcpu_stats_data *stats_data;
> +
> +	/* Get fd for VCPU stats */
> +	stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
> +	TEST_ASSERT(stats_fd >= 0, "Get VCPU stats fd");
> +
> +	stats_test(stats_fd, sizeof(stats_data->value[0]));
> +	close(stats_fd);
> +	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
> +}
> +
> +#define DEFAULT_NUM_VM		4
> +#define DEFAULT_NUM_VCPU	4
> +
> +/*
> + * Usage: kvm_bin_form_stats [#vm] [#vcpu]
> + * The first parameter #vm set the number of VMs being created.
> + * The second parameter #vcpu set the number of VCPUs being created.
> + * By default, DEFAULT_NUM_VM VM and DEFAULT_NUM_VCPU VCPU for the VM would be
> + * created for testing.
> + */
> +
> +int main(int argc, char *argv[])
> +{
> +	int max_vm = DEFAULT_NUM_VM, max_vcpu = DEFAULT_NUM_VCPU, ret, i, j;
> +	struct kvm_vm **vms;
> +
> +	/* Get the number of VMs and VCPUs that would be created for testing. */
> +	if (argc > 1) {
> +		max_vm = strtol(argv[1], NULL, 0);
> +		if (max_vm <= 0)
> +			max_vm = DEFAULT_NUM_VM;
> +	}
> +	if (argc > 2) {
> +		max_vcpu = strtol(argv[2], NULL, 0);
> +		if (max_vcpu <= 0)
> +			max_vcpu = DEFAULT_NUM_VCPU;
> +	}
> +
> +	/* Check the extension for binary stats */
> +	ret = kvm_check_cap(KVM_CAP_STATS_BINARY_FD);
> +	TEST_ASSERT(ret >= 0,
> +			"Binary form statistics interface is not supported");
> +
> +	/* Create VMs and VCPUs */
> +	vms = malloc(sizeof(vms[0]) * max_vm);
> +	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
> +	for (i = 0; i < max_vm; ++i) {
> +		vms[i] = vm_create(VM_MODE_DEFAULT,
> +				DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> +		for (j = 0; j < max_vcpu; ++j)
> +			vm_vcpu_add(vms[i], j);
> +	}
> +
> +	/* Check stats read for every VM and VCPU */
> +	for (i = 0; i < max_vm; ++i) {
> +		vm_stats_test(vms[i]);
> +		for (j = 0; j < max_vcpu; ++j)
> +			vcpu_stats_test(vms[i], j);
> +	}
> +
> +	for (i = 0; i < max_vm; ++i)
> +		kvm_vm_free(vms[i]);
> +	free(vms);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index fc83f6c5902d..10385b76fe11 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2090,3 +2090,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
>   	n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
>   	return vm_adjust_num_guest_pages(mode, n);
>   }
> +
> +int vm_get_stats_fd(struct kvm_vm *vm)
> +{
> +	return ioctl(vm->fd, KVM_GET_STATS_FD, NULL);
> +}
> +
> +int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
> +{
> +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +
> +	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
> +}

We don't want to add a test case for testing the fd interface on a 
deleted VM and a deleted VCPU ?

Anyway, for the current content,

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

