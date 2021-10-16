Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1D42FFC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Oct 2021 04:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhJPC7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 22:59:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24626 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236923AbhJPC7q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 22:59:46 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19G2rU8S023138;
        Sat, 16 Oct 2021 02:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I/7u/xbG5WTazPoJsqatfbjw9DdYevDE9KIbQyuS7Vo=;
 b=NBjISde9HGuZ6xh1S8KvSxVG8cT5Ycj3lAWHSy/OX4GosxX7nNgyMNFgEFBxM+D27e87
 ajakbRTaPjc45JVUunmRhjarlTF9L0nyFpRbQNhx60TgNAM09fmcR7rM07PQvKif/Jo1
 agaoYN9JMvRTnuOli1FtUnaYH9Y8u8knV5xtr3cfIcjEc6/To/QGq4XqdzkL+ZwhxPIO
 Hvtifx0bWFsAZh5MUOj7U9wQJ0ZUXnNef9sXlNIdpOt37ZJKeeFnegobqdIntTDLMuAk
 DHwRPawDLBaf4nzEwFvRzBLx1CdtBE19vHJTHV6IRZfXX/AjGlhmESICGlIOiml0XX8X Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqpbsr082-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 02:56:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19G2ktxe129937;
        Sat, 16 Oct 2021 02:56:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3bmae5458g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 02:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dodaptvyyN/nI6J6M3BTQGkOOoiUnv9mHlpO6MYdaRFJXUpne3vbwhH/bA38mDA55611QQvSQo3fOBYgIDR2t6Sps1B/C845k7hqUSTcCK+QMFIGEY6gBLHHUOgE7ecgLe8iusQ+GHpCT9gHXLbiEt9LCbjOyjXkEkxXw1RZdvF9DAQj9gNnqPaGl05nsks/J/0RlGG65hTbo8Rqd5IkhG2mi3XQNbzvsa9wTNFam+8moyYcZUAGEcSYVLFMR4x7wwpJLlg22DDTXExPlUyM1ndxwvtB8lUjJ1UzsSXGC/uwL9d5VeUZMA3yNsWt12DGnoJ4l+DGrldx4OiImQBOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/7u/xbG5WTazPoJsqatfbjw9DdYevDE9KIbQyuS7Vo=;
 b=gA2I7DoUpUv8RRPCftzmy4SFoKTPHSC0lZWlXCrKHXqoy7/SOkcPzQ4pf1VmPiIVSCinCxY1O+bmURHNSavOADop+IUltOGQox5EARlrxSWz8pltETkCQTwiOou+boylxPTGeX1VYRoTD6yrdG9cJVgWcyWGWHmSJkue6Cna6PpzQFC3gHrsEJa5kBTz3SNlt6KiTW/CHlEGMX2umiLKAZgQt3MZfPApOu2C43bVmVdD0W/dqpaqyrYfMgeK3K0IlitIC3j7UaPG4qFxdzoi6BVKV3mE4VoUahnJmPJDLC0ffT3oICDtpoP5diTCT2fvWz8v+RMPfncg6FQmSiyNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/7u/xbG5WTazPoJsqatfbjw9DdYevDE9KIbQyuS7Vo=;
 b=jswpr58hoZVlxjbESkn7JX6EaqI8orA+wRNpEbwdQ34z59m5oBzqjC23LHoDcLAB9P+mxRSS7TOGAMpRk7RTJIqmj6bYIk5M/mZqZu0TND7ZmuhwRK/tv50G/r+9qj8ntRZ9t8F0/jnlyb/qs/dkwSwBRqI8yrw0E3bEvRb/Cas=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Sat, 16 Oct
 2021 02:56:36 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491%7]) with mapi id 15.20.4587.030; Sat, 16 Oct 2021
 02:56:36 +0000
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
To:     Michael Roth <michael.roth@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203710.13326-1-michael.roth@amd.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <7391ace3-cc50-8f57-5009-8517e39fb08f@oracle.com>
Date:   Fri, 15 Oct 2021 19:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20211006203710.13326-1-michael.roth@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:806:d2::27) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SA0PR11CA0082.namprd11.prod.outlook.com (2603:10b6:806:d2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Sat, 16 Oct 2021 02:56:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac24b94a-03aa-4b46-85a5-08d990509192
X-MS-TrafficTypeDiagnostic: SA2PR10MB4665:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4665FD2EBAD551A99EBA725481BA9@SA2PR10MB4665.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k33Lj/2Dsjr2mMtPCegbUCymiapS+/ugxisiJoWCVXxQEK0YrPGqeFc5AiRBgqmHyBNschYmkPwyJspSLfxv3/ky+SkRQQ8sFRMZLUfYaM3q42veTxzvuQcFSJ0ZueIi3LcdJIB02mTxfWd2Dm4jxZe+Qzspf64h7iP5BF0xOdZ6wHpGXjSgcbKW0Hiq4Ssl2LHOMP28hoRETeFvkLHgDpDd5Il0I89jYHPx9yU6pv84OjVdVvLJzq29qH7JZ489G3rdkunyFnjA6DBCuQnQ+exSWJHvBQEf6Kp8NpMIGZEVuFRSCvnb1xNIObDKS2cuviFDzkflAQfwQzIZd0fPVhjTO8/axm5MkaJgNXj8DGYO9woKi5c6FeloHX2OznelYEm5RmLVngM7aMDqPDrHfC27+vrgCcM0P0dyqQs0L7fzaOy/afLVgx8rbyBZD7ylgoZGcrQveuzUs57pPJogW6bG6v0EhQlVX0ze3M/JAveM8a32CFm3kah+m6YmPO4s+GcZp5QLVamUDvDGo+gwUTuEv7MattObmc7xTi47aqSGFLfedlMl9fXpl0ifgySS+jj5Lf3ooYJBC/oDUmOK79IpHWNwBManNwRWpz/XJaZA7nk+8zmFmSV9Jfmo8LWF8VEZkKvKcXxnhqZ2GhAJGWFHRo6pxb0sCD4ZreaTFowXo1K/S34vLzz9wu5vfdwKohnLWU+7oZ6qieVnTVERqiuA5c327W8KDungWx2vEHeA8nQAZGmVt/qQ7QwtSoIy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(38100700002)(31686004)(7416002)(2616005)(86362001)(31696002)(8676002)(6512007)(66556008)(66946007)(54906003)(66476007)(508600001)(8936002)(6506007)(53546011)(83380400001)(316002)(4326008)(2906002)(30864003)(5660300002)(6486002)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlVYWpxakNCQjE2M0NIeEU0TGo5RGR0d1hGRE1laHJRR0s5b3huWnNaaFhF?=
 =?utf-8?B?SGlxL1lXQnl3Sm85RzZSU25SUVFuYTB3WWNtd2VCZ3AwZTF2bTgzbGNVNm5u?=
 =?utf-8?B?ZEoyeEJ0OEpsbk1ySjhmc3hra3BrcjU4Ukc3VkJrYXB0cXN2Sjk0alFBRStu?=
 =?utf-8?B?LzJlZjMzd00yWlI1Tnh6NjZVdUxQalpzYWhxa002Zm5ZeGR0Y2xtbjN5amY2?=
 =?utf-8?B?OTRsRGFsQUYyVzI0TnYyeVZVSGVkZ1RuT2JjcUFrTXkrcmpYZFlhNXBpb2Jm?=
 =?utf-8?B?aHhHSGNtR1FraDFXZFQ4TTZhNXRMaUpOc3pjdm1vdXJNNWtrM0pGbUxKYUha?=
 =?utf-8?B?bXlZb0pSRXZiR3lLeE9rdjR2cmFyUWFEb2R2czlQNHUvSlFmbTN2MVQrRXR6?=
 =?utf-8?B?Q2tIYU1TenZubVlFRmRudGpRRDloODhhUXlydjlmUkk3Zis3RFhIczljTG0w?=
 =?utf-8?B?a0RwczRLL3V6cVVSbHl2YnJ4aHo5eVNjREVjKzdaYSt2R2c1anpjYURUOWZL?=
 =?utf-8?B?Wnd3N2NTbWpLdWJCYXJ5SHQxNzdzeU9SZDJjZGxaWkdyYzdLV3RuZ2NHSGtv?=
 =?utf-8?B?dGl4Vk44aDgxczU3aUJLN1NLOVU1UGVtNmdDZ2diVHJCaFV5V3dFYTQ4U2gy?=
 =?utf-8?B?M2RiMWJaQ1pudmRYSVdJN2VKSHAzN2ptSkgxc0RuaFFabGZlUGVRcmQ3a2tU?=
 =?utf-8?B?REM2eGNQTmVOWHVVUU5pbkJoTWpsa1JtMDcxcUtCR25YNkZFbkdPS1ROcDNH?=
 =?utf-8?B?YUY2VnhxRkROVk1DRDJDWS9rQitmeTcxeFpRUE9leTAweGc0Ty9GME1BRHp6?=
 =?utf-8?B?SmthNUNVSTdHZlU0bWJRVjVtbUF0NFlLL2krcWtpZnJkNXI0cHVRcUNoYmI1?=
 =?utf-8?B?T09FZHBjc2M2UFpxSnRMQnY1L2prWURVUnZWTE9TYk96eTFyNktUVnNwbkdi?=
 =?utf-8?B?NldJdElzYmEyZjU4bE8yWE5XWFUwWWtmbXJ4RVpWM3dPWVZacjJGNGxUMng0?=
 =?utf-8?B?b2ZjeUJGSW1nRWNBcU80cDh3dHM5MUE2cHhpNTVhZnBsOVVhdHNMbDh3Z2dy?=
 =?utf-8?B?dSt4emRJRlc1N0RhNTZJaEduR0J2WjdSYktFMXF0S0M3dHRtTFNybDlTQmF5?=
 =?utf-8?B?eS9HYTNrenhWdDloMC9QTU4ySG52ckhrMFJodElveExyY0ZxOXpwZUo2WlFU?=
 =?utf-8?B?ampRaDR6NFBESjZHTU54RTByT3F0TEp5Z3E4ck5QcjlQa2hwOC96bytKVVFV?=
 =?utf-8?B?dkhqN1QxdE9kQ0E1YkNBWnpMbkFEN1BuMXlQSzFVUS9QdGlvSWVUR1Evck1I?=
 =?utf-8?B?UzhQSlB6S1Z6QW1xdUl4RjE2dStCOVZ1bmFhMnNCSi9mRldmUTBvQzdoVEQr?=
 =?utf-8?B?c1NLS2dsODRZQ3ZVdWZpbENLTHFrRHZwTmRzTW84SnJ3V0xMeE02aXpCa0ta?=
 =?utf-8?B?QUwvbGU4eGNVNFlUTUNlNFZaN0llck00aFB2TS9ublZMcXpVdXV4WlVLWk5o?=
 =?utf-8?B?ckFzWERTTjRtVFM2emM1b3AwY2xhaWpENTVMVWZFVGtzenlEajZNVWJEZTZt?=
 =?utf-8?B?c0x5UnJ6S1pVQUdVYmVjN29PUTJiWmRKNTA5b2hBNEdPV1N0UWtZMmozREtX?=
 =?utf-8?B?WjJNdnhwK1RaTWsrWnNCa3hwRkZNZmNYazBKU0lpZ1l2ajVBKzNNNDNhcEtS?=
 =?utf-8?B?eWRkSXluelkrcXVuakpGZnhWR0wxOEp2anRrZ2V2YzJYOWJlRUJ2WklBNVA4?=
 =?utf-8?B?RSsxNXkvSDB0My9lQ1BscVRkY0VQVitSTENnSDV5Um1BeFFaV2RFYjNmd01Y?=
 =?utf-8?Q?eYuGAvBxymJhikzjYxQ33/k5zLXxt+hiT2oQU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac24b94a-03aa-4b46-85a5-08d990509192
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 02:56:36.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PTUs9CzDkKe+rDeagZZ29LDO8uEgfgK4H+8K4ka0hjL0ahekwObM5VohcnD9DQtNfIBthRV7SHHtTLRTgZI9NtLeQhmfRKAvx1yhZ4pBxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110160016
X-Proofpoint-GUID: R9xCosI0FWJtbgbCOaHK2fXXOduo23g3
X-Proofpoint-ORIG-GUID: R9xCosI0FWJtbgbCOaHK2fXXOduo23g3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/6/21 1:37 PM, Michael Roth wrote:
> Add interfaces to allow tests to create/manage SEV guests. The
> additional state associated with these guests is encapsulated in a new
> struct sev_vm, which is a light wrapper around struct kvm_vm. These
> VMs will use vm_set_memory_encryption() and vm_get_encrypted_phy_pages()
> under the covers to configure and sync up with the core kvm_util
> library on what should/shouldn't be treated as encrypted memory.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/include/x86_64/sev.h        |  62 ++++
>   tools/testing/selftests/kvm/lib/x86_64/sev.c  | 303 ++++++++++++++++++
>   3 files changed, 366 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
>   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 5832f510a16c..c7a5e1c69e0c 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -35,6 +35,7 @@ endif
>   
>   LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
>   LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
> +LIBKVM_x86_64 += lib/x86_64/sev.c
>   LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
>   LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>   
> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
> new file mode 100644
> index 000000000000..d2f41b131ecc
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Helpers used for SEV guests
> + *
> + * Copyright (C) 2021 Advanced Micro Devices
> + */
> +#ifndef SELFTEST_KVM_SEV_H
> +#define SELFTEST_KVM_SEV_H
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include "kvm_util.h"
> +
> +#define SEV_DEV_PATH		"/dev/sev"
> +#define SEV_FW_REQ_VER_MAJOR	1
> +#define SEV_FW_REQ_VER_MINOR	30
> +
> +#define SEV_POLICY_NO_DBG	(1UL << 0)
> +#define SEV_POLICY_ES		(1UL << 2)
> +
> +#define SEV_GUEST_ASSERT(sync, token, _cond) do {	\
> +	if (!(_cond))					\
> +		sev_guest_abort(sync, token, 0);	\
> +} while (0)
> +
> +enum {
> +	SEV_GSTATE_UNINIT = 0,
> +	SEV_GSTATE_LUPDATE,
> +	SEV_GSTATE_LSECRET,
> +	SEV_GSTATE_RUNNING,
> +};
> +
> +struct sev_sync_data {
> +	uint32_t token;
> +	bool pending;
> +	bool done;
> +	bool aborted;


Instead of having three different members, 'pending', done' and 'abort', 
and their corresponding functions, is it possible to use a single member 
and a single function with #defines for the three states ? This may be 
better if we need to add more sync states in the future.

> +	uint64_t info;
> +};
> +
> +struct sev_vm;
> +
> +void sev_guest_sync(struct sev_sync_data *sync, uint32_t token, uint64_t info);
> +void sev_guest_done(struct sev_sync_data *sync, uint32_t token, uint64_t info);
> +void sev_guest_abort(struct sev_sync_data *sync, uint32_t token, uint64_t info);
> +
> +void sev_check_guest_sync(struct kvm_run *run, struct sev_sync_data *sync,
> +			  uint32_t token);
> +void sev_check_guest_done(struct kvm_run *run, struct sev_sync_data *sync,
> +			  uint32_t token);
> +
> +void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data);
> +struct kvm_vm *sev_get_vm(struct sev_vm *sev);
> +uint8_t sev_get_enc_bit(struct sev_vm *sev);
> +
> +struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages);
> +void sev_vm_free(struct sev_vm *sev);
> +void sev_vm_launch(struct sev_vm *sev);
> +void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement);
> +void sev_vm_launch_finish(struct sev_vm *sev);
> +
> +#endif /* SELFTEST_KVM_SEV_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> new file mode 100644
> index 000000000000..adda3b396566
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Helpers used for SEV guests
> + *
> + * Copyright (C) 2021 Advanced Micro Devices
> + */
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include "kvm_util.h"
> +#include "linux/psp-sev.h"
> +#include "processor.h"
> +#include "sev.h"
> +
> +#define PAGE_SHIFT		12
> +#define PAGE_SIZE		(1UL << PAGE_SHIFT)
> +
> +struct sev_vm {
> +	struct kvm_vm *vm;
> +	int fd;
> +	int enc_bit;
> +	uint32_t sev_policy;
> +};
> +
> +/* Helpers for coordinating between guests and test harness. */
> +
> +void sev_guest_sync(struct sev_sync_data *sync, uint32_t token, uint64_t info)
> +{
> +	sync->token = token;
> +	sync->info = info;
> +	sync->pending = true;
> +
> +	asm volatile("hlt" : : : "memory");
> +}
> +
> +void sev_guest_done(struct sev_sync_data *sync, uint32_t token, uint64_t info)
> +{
> +	while (true) {
> +		sync->done = true;
> +		sev_guest_sync(sync, token, info);
> +	}
> +}
> +
> +void sev_guest_abort(struct sev_sync_data *sync, uint32_t token, uint64_t info)
> +{
> +	while (true) {
> +		sync->aborted = true;
> +		sev_guest_sync(sync, token, info);
> +	}
> +}
> +
> +void sev_check_guest_sync(struct kvm_run *run, struct sev_sync_data *sync,
> +			  uint32_t token)
> +{
> +	TEST_ASSERT(run->exit_reason == KVM_EXIT_HLT,
> +		    "unexpected exit reason: %u (%s)",
> +		    run->exit_reason, exit_reason_str(run->exit_reason));
> +	TEST_ASSERT(sync->token == token,
> +		    "unexpected guest token, expected %d, got: %d", token,
> +		    sync->token);
> +	TEST_ASSERT(!sync->done, "unexpected guest state");
> +	TEST_ASSERT(!sync->aborted, "unexpected guest state");
> +	sync->pending = false;
> +}
> +
> +void sev_check_guest_done(struct kvm_run *run, struct sev_sync_data *sync,
> +			  uint32_t token)
> +{
> +	TEST_ASSERT(run->exit_reason == KVM_EXIT_HLT,
> +		    "unexpected exit reason: %u (%s)",
> +		    run->exit_reason, exit_reason_str(run->exit_reason));
> +	TEST_ASSERT(sync->token == token,
> +		    "unexpected guest token, expected %d, got: %d", token,
> +		    sync->token);
> +	TEST_ASSERT(sync->done, "unexpected guest state");
> +	TEST_ASSERT(!sync->aborted, "unexpected guest state");
> +	sync->pending = false;
> +}
> +
> +/* Common SEV helpers/accessors. */
> +
> +struct kvm_vm *sev_get_vm(struct sev_vm *sev)
> +{
> +	return sev->vm;
> +}
> +
> +uint8_t sev_get_enc_bit(struct sev_vm *sev)
> +{
> +	return sev->enc_bit;
> +}
> +
> +void sev_ioctl(int sev_fd, int cmd, void *data)
> +{
> +	int ret;
> +	struct sev_issue_cmd arg;
> +
> +	arg.cmd = cmd;
> +	arg.data = (unsigned long)data;
> +	ret = ioctl(sev_fd, SEV_ISSUE_CMD, &arg);
> +	TEST_ASSERT(ret == 0,
> +		    "SEV ioctl %d failed, error: %d, fw_error: %d",
> +		    cmd, ret, arg.error);
> +}
> +
> +void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data)
> +{
> +	struct kvm_sev_cmd arg = {0};
> +	int ret;
> +
> +	arg.id = cmd;
> +	arg.sev_fd = sev->fd;
> +	arg.data = (__u64)data;
> +
> +	ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_OP, &arg);
> +	TEST_ASSERT(ret == 0,
> +		    "SEV KVM ioctl %d failed, rc: %i errno: %i (%s), fw_error: %d",
> +		    cmd, ret, errno, strerror(errno), arg.error);
> +}
> +
> +/* Local helpers. */
> +
> +static void
> +sev_register_user_range(struct sev_vm *sev, void *hva, uint64_t size)
> +{
> +	struct kvm_enc_region range = {0};
> +	int ret;
> +
> +	pr_debug("register_user_range: hva: %p, size: %lu\n", hva, size);
> +
> +	range.addr = (__u64)hva;
> +	range.size = size;
> +
> +	ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_REG_REGION, &range);
> +	TEST_ASSERT(ret == 0, "failed to register user range, errno: %i\n", errno);
> +}
> +
> +static void
> +sev_encrypt_phy_range(struct sev_vm *sev, vm_paddr_t gpa, uint64_t size)
> +{
> +	struct kvm_sev_launch_update_data ksev_update_data = {0};
> +
> +	pr_debug("encrypt_phy_range: addr: 0x%lx, size: %lu\n", gpa, size);
> +
> +	ksev_update_data.uaddr = (__u64)addr_gpa2hva(sev->vm, gpa);
> +	ksev_update_data.len = size;
> +
> +	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_DATA, &ksev_update_data);
> +}
> +
> +static void sev_encrypt(struct sev_vm *sev)
> +{
> +	struct sparsebit *enc_phy_pages;
> +	struct kvm_vm *vm = sev->vm;
> +	sparsebit_idx_t pg = 0;
> +	vm_paddr_t gpa_start;
> +	uint64_t memory_size;
> +
> +	/* Only memslot 0 supported for now. */
> +	enc_phy_pages = vm_get_encrypted_phy_pages(sev->vm, 0, &gpa_start, &memory_size);
> +	TEST_ASSERT(enc_phy_pages, "Unable to retrieve encrypted pages bitmap");
> +	while (pg < (memory_size / vm_get_page_size(vm))) {
> +		sparsebit_idx_t pg_cnt;
> +
> +		if (sparsebit_is_clear(enc_phy_pages, pg)) {
> +			pg = sparsebit_next_set(enc_phy_pages, pg);
> +			if (!pg)
> +				break;
> +		}
> +
> +		pg_cnt = sparsebit_next_clear(enc_phy_pages, pg) - pg;
> +		if (pg_cnt <= 0)
> +			pg_cnt = 1;
> +
> +		sev_encrypt_phy_range(sev,
> +				      gpa_start + pg * vm_get_page_size(vm),
> +				      pg_cnt * vm_get_page_size(vm));
> +		pg += pg_cnt;
> +	}
> +
> +	sparsebit_free(&enc_phy_pages);
> +}
> +
> +/* SEV VM implementation. */
> +
> +static struct sev_vm *sev_common_create(struct kvm_vm *vm)
> +{
> +	struct sev_user_data_status sev_status = {0};
> +	uint32_t eax, ebx, ecx, edx;
> +	struct sev_vm *sev;
> +	int sev_fd;
> +
> +	sev_fd = open(SEV_DEV_PATH, O_RDWR);
> +	if (sev_fd < 0) {
> +		pr_info("Failed to open SEV device, path: %s, error: %d, skipping test.\n",
> +			SEV_DEV_PATH, sev_fd);
> +		return NULL;
> +	}
> +
> +	sev_ioctl(sev_fd, SEV_PLATFORM_STATUS, &sev_status);
> +
> +	if (!(sev_status.api_major > SEV_FW_REQ_VER_MAJOR ||
> +	      (sev_status.api_major == SEV_FW_REQ_VER_MAJOR &&
> +	       sev_status.api_minor >= SEV_FW_REQ_VER_MINOR))) {
> +		pr_info("SEV FW version too old. Have API %d.%d (build: %d), need %d.%d, skipping test.\n",
> +			sev_status.api_major, sev_status.api_minor, sev_status.build,
> +			SEV_FW_REQ_VER_MAJOR, SEV_FW_REQ_VER_MINOR);
> +		return NULL;
> +	}
> +
> +	sev = calloc(1, sizeof(*sev));
> +	sev->fd = sev_fd;
> +	sev->vm = vm;
> +
> +	/* Get encryption bit via CPUID. */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	cpuid(&eax, &ebx, &ecx, &edx);
> +	sev->enc_bit = ebx & 0x3F;
> +
> +	return sev;
> +}
> +
> +static void sev_common_free(struct sev_vm *sev)
> +{
> +	close(sev->fd);
> +	free(sev);
> +}
> +
> +struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
> +{
> +	struct sev_vm *sev;
> +	struct kvm_vm *vm;
> +
> +	/* Need to handle memslots after init, and after setting memcrypt. */
> +	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
> +	sev = sev_common_create(vm);
> +	if (!sev)
> +		return NULL;
> +	sev->sev_policy = policy;
> +
> +	kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
> +
> +	vm_set_memory_encryption(vm, true, true, sev->enc_bit);
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
> +	sev_register_user_range(sev, addr_gpa2hva(vm, 0), npages * vm_get_page_size(vm));
> +
> +	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
> +		sev->sev_policy, npages * vm_get_page_size(vm) / 1024);
> +
> +	return sev;
> +}
> +
> +void sev_vm_free(struct sev_vm *sev)
> +{
> +	kvm_vm_free(sev->vm);
> +	sev_common_free(sev);
> +}
> +
> +void sev_vm_launch(struct sev_vm *sev)
> +{
> +	struct kvm_sev_launch_start ksev_launch_start = {0};
> +	struct kvm_sev_guest_status ksev_status = {0};
> +
> +	ksev_launch_start.policy = sev->sev_policy;
> +	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_START, &ksev_launch_start);
> +	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
> +	TEST_ASSERT(ksev_status.policy == sev->sev_policy, "Incorrect guest policy.");
> +	TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE,
> +		    "Unexpected guest state: %d", ksev_status.state);
> +
> +	sev_encrypt(sev);
> +}
> +
> +void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement)
> +{
> +	struct kvm_sev_launch_measure ksev_launch_measure = {0};
> +	struct kvm_sev_guest_status ksev_guest_status = {0};
> +
> +	ksev_launch_measure.len = 256;
> +	ksev_launch_measure.uaddr = (__u64)measurement;
> +	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_MEASURE, &ksev_launch_measure);
> +
> +	/* Measurement causes a state transition, check that. */
> +	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_guest_status);
> +	TEST_ASSERT(ksev_guest_status.state == SEV_GSTATE_LSECRET,
> +		    "Unexpected guest state: %d", ksev_guest_status.state);
> +}
> +
> +void sev_vm_launch_finish(struct sev_vm *sev)

Just like you named it after the command LAUNCH_FINISH, it's better to 
name the other functions based on the command they are executing, for 
the sake of consistency:

     sev_vm_launch_measure,    sev_vm_launch_start

> +{
> +	struct kvm_sev_guest_status ksev_status = {0};
> +
> +	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
> +	TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE ||
> +		    ksev_status.state == SEV_GSTATE_LSECRET,
> +		    "Unexpected guest state: %d", ksev_status.state);
> +
> +	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_FINISH, NULL);
> +
> +	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
> +	TEST_ASSERT(ksev_status.state == SEV_GSTATE_RUNNING,
> +		    "Unexpected guest state: %d", ksev_status.state);
> +}
