Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED0842B299
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 04:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhJMC2w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 22:28:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21064 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233316AbhJMC2v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 22:28:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D0dwZB010778;
        Wed, 13 Oct 2021 02:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R9VFeNpgtGanzy7EsY0H2fVJGZE8Rms74Ds8BsEJdY0=;
 b=RTmOuyQjr15UV0uI8HG08M0f10N0Ddv4czJpsqbrmpRMJvNT2/m31rj3GITS8nzDS5JW
 ZNbhKaUxI/3Vii/5ArJv0+Rx+Q0GlLgOoKel7BWXfMi2CmNazf/8cmLdMwBmJ/7mBpCb
 djEbXPjZ87czg6F/JkDh03jpdM+phDEh92o4VDceAo0PBZWse/J2IQeNoMrN6uPxhMfS
 H6TiovnxFW3ulNoGwnCWkHGFuLAwDDdRma6QHT8vKu7Xgio8P7eVlvQZ33aOa1ypIxaP
 njktunZMSxH6jugB4AfXHN58hWHr0bspw9JLHgjtucJY0uejnhHJuffnkj/VvXyP9Xln iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbk8s7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 02:20:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D2B8qK123975;
        Wed, 13 Oct 2021 02:20:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by userp3020.oracle.com with ESMTP id 3bkyvb7n5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 02:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bELMKihJyC/UjmtN52t/dHzSGcGpqV/iIlFWJzrKT5hq6Vzzo5NSTz3oW9xQA4PcGRUC4zj47STTxr38g3zuwAHCq1pjFY1RujUKLEWOeiYJLp6Lt8Huut/ldKOrf2R+CdddGzR+JKuDGfWDDEmLjq8PhqUEi626ob9S3J4YrzPq09XksmU5KPOVyMIUfpuWQzRhW6b3JnmOvamVuB5F+F2aPaksgNIoq9FiqXvspBmOGyoCuA5qJsYw/z5bavAJJO39wRTIuYbviZZyMxrGqD/+Hessa8+7VbEZPxH8v9D9Ad5k0/X/KWkPmjcVZwCFA4EiUcWpw7Pabci3p+QqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9VFeNpgtGanzy7EsY0H2fVJGZE8Rms74Ds8BsEJdY0=;
 b=CHlEO190wD4iQKaa5FcEZ8jbO1VdTo4YRU6ivrmmpow109GUpLhESYrC9DM5NWYRL841c9gn3i3fphSol7es7r69KcBdJOMSNaK69obHcziz9GFA0SCZRxe85Ky6fCgKgeHTQDfdEpgKSL2wy0EPqUF95o2UfJrn/t2D+fW8wl3hl19Q08JhyUTQ9FjThJVQtYPACDVPFsXjs+YYVn89bz2ehrz/bzy7A/UEewJgcg79GxYOCHUuBri2/hlkV7cTPwVzyNhfudahHKX6milGu3op5+PMqhEj9NSallidcG1zIhhTW6TwRY64Z8FskvUm8I8fdhlKRJToM1Iw6aopYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9VFeNpgtGanzy7EsY0H2fVJGZE8Rms74Ds8BsEJdY0=;
 b=nsmQSx40a0Ik54aAGCN65VWyjdo41G6NAjJOY8lA1SeapMWycjPgSXdKzBLU3Rb5TyIe/O2hLcTFzald16jBJXzeW9o6lyjuH2Er2Z025c6R5ahXBa/5vDKDUOjZJBtPzFG/UrK0mvBAFJjVX/NDIR+e3ixieRxvEyCvfbquHvs=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SN6PR10MB2861.namprd10.prod.outlook.com (2603:10b6:805:cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 02:20:45 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 02:20:45 +0000
Subject: Re: [RFC 02/16] KVM: selftests: add hooks for managing encrypted
 guest memory
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
 <20211005234459.430873-3-michael.roth@amd.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <6b8e4fb7-fb96-bc3a-dc46-70d9f07d3c8d@oracle.com>
Date:   Tue, 12 Oct 2021 19:20:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20211005234459.430873-3-michael.roth@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0118.namprd11.prod.outlook.com
 (2603:10b6:806:d1::33) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SA0PR11CA0118.namprd11.prod.outlook.com (2603:10b6:806:d1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 02:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 720487ae-71f8-4d38-a0f4-08d98df01029
X-MS-TrafficTypeDiagnostic: SN6PR10MB2861:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2861C26098C342A3B297F0DA81B79@SN6PR10MB2861.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ct+AL8QGarq67wyoqt9IdQzPWv23xTH8IlYp3JSxa4MjiocPfI4/uhPFOai3rt+fJx0J+KbpfYTjzGI1yeLB2nbfpvWJXpqxWwDL0hejQryrX1UdKXfmYi4la3gadvjvRtWDgsiWj1De1wAk9yTi5uoxYKi0cmqrDHM4cr/IkmepiyoX7LdgI/wbVDKfMW4hxLU/51t2TeO+K3VOdm5cSotYE7omoIeZXcziMR0tgt4Faa8h6IXvc1WEtYPdKnGPTz18Nah9pQGLn0tMVi7xZq6eodZ46G7cPphWyQT1amxwKSEW3vbHar6RsBeDsxPrc2hlzg13YloUp3uwAtymkeaos0vzn3abGd1ghj+dJMa5XtXVjrPABH5xYt/GyKVkywAujIobGbLOLHlYWbHcCJeWDxRUiWKy9fjRPYMLSsnO+nC11FYXgM8EZNqIwbDaegVOyRFQmSBuAMiri7UEeLzqMov853WzVx7Uedwq8Bbp9vFBp45vhD2CXupLHx3L7kkBcyP+lKaPjzKx13BiDFiIxBQAnhFv2CC2cJoDYKmCt8a8Anz7PeLTjh6efxGs33cnT47R5gEd1AKNkkutbf+E7lZg4BOKBkut/55UObjR6M/jVrfK5O0myIkDKneShxXfffrDYYOX+Jq0NqZlr1oTB67C68LzRFHTajog7pjYs5zdmb2danZroxMkgybWc2Or/w06dDpPTJhnOqP/Et6lcI/IcOpE785QoZq3jxizSovHjjGn6qps43OiciE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(8676002)(8936002)(83380400001)(54906003)(36756003)(2616005)(7416002)(5660300002)(6486002)(31686004)(66946007)(508600001)(6512007)(31696002)(6506007)(86362001)(38100700002)(186003)(2906002)(316002)(4326008)(53546011)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhKSjVVa21QQUlpb1V2UGowZUJxNGFoQlpzY0QyMGhSRzVROWV6RTVENjdT?=
 =?utf-8?B?TXlEcFFOUWxPTWJrTGx0L2QwTG9RSnErcjlVQ3BucDAyYVI3QXBQTHBydW9D?=
 =?utf-8?B?bm9vdVdtTzVnMVBaaS9nUmN2VUQ1bitST1Qyc0dHbTJZQVRwV3EvUktFVVls?=
 =?utf-8?B?SWdRa2RrcFlCcFYxaEk0K0wra2JoeU11a1RLSzUrVXZCeWlFUENMYlltSFNY?=
 =?utf-8?B?Y2hFc3FJYTJHbUZoTDNQNXR3dmVvcUtRdzM3eUlRTVo5S0pFbXlUOFpiUDlh?=
 =?utf-8?B?RDFDR3FBb0RLdWlJVkZoYWRBSlJRY3prM00vNlpWMU9IVmtyWENtbW5qcmp0?=
 =?utf-8?B?b3hSWXFNZVZsenoyLzBwRmErdE1mQ2pKcjdJU25mN3VBT0Y1U1lURUh2dG55?=
 =?utf-8?B?eXFWbmNTcFc1WGFRZTN5ZlBpNW1rWXBNU3EySGR5MzFGaTZpaU5GL1ZEb3h4?=
 =?utf-8?B?d05NZ0wwT0NJZlgxSGs5a21NSE1LVVhBZmVWUW1NcTV2YjJsWStVS0dJYkF0?=
 =?utf-8?B?M240MDJHT3FNTmU0VnFibFl6NUhnQ3ZEQXRhc2c0QTl4UldsVDhJWjUrZi95?=
 =?utf-8?B?SjRDcDdEQ1lva2kxeThqUzhwMjJkbkkwN0pSMGl5R3RSb1Y3bkM0RTNCc3VR?=
 =?utf-8?B?WHRTeUIrNlJVcW1uTzBYeXFFLzk3Qm1mbEFWaXFicm9FaEltWm5ESitQaUZB?=
 =?utf-8?B?WGxuR3BOcTBra3RoVTAveCtIbnNIY21NSkU0dGNqdEh0UFZHRE9wU2dCb1NX?=
 =?utf-8?B?c29WNmpIVDV6amJ6OFlBbFV2VHZCVVhoN2IzSEZWK0dIckJiNlUvaHpmRmdM?=
 =?utf-8?B?aUhQV0syUzRsczNMNmJwRVZyUXkyZWtCVUpSWUhXWldyWFlPR2VyUXZYTnhz?=
 =?utf-8?B?QXQ3cFVXTi8zOSt5T1J1bTU5T0lic2ZYaUs2QWxVbG45UXQ1MWZ4ekdMS09w?=
 =?utf-8?B?TGdsVTBpcTNKRnhHM0VIa1FxTEkvSW1UZEZpb1pCK1JzbWY1elV1U2ZxRkFS?=
 =?utf-8?B?WHpiOUFwTzJ3VEdYMG1lVnZQVVZLMUxQM1dzQlQwTlpWMi9rbHRYRE1uTDgr?=
 =?utf-8?B?MXhBbkVOY2FvNWxsTkl4NnFZUlhmREd2aDZ1c0Y1Znd4N280YTY0WTFPYlFB?=
 =?utf-8?B?Kzc4Zk1Eand3d1pJdGJQOEZXMzdHRDlOQjBUNkdNR0EyQUNzWXpWNjJTZjZ4?=
 =?utf-8?B?OWVVNmtxRk1kaExGc3ZKczJWNWlzcGhlRDhaV1NsNUdEb1czdStacEdMQVh1?=
 =?utf-8?B?NnYxNk9YY1NJTWk3WDlLdlA3VnlxVGxnQlZoY29IMk54elNZS1RKUGl2L1lF?=
 =?utf-8?B?b3JuSkdVZGtMQjhHQ0tZWXBsaEd3THMrYU5RS0NzSEowRFpWcGNhV2U2ZmRP?=
 =?utf-8?B?d1RXeWpweEV3ZVRTbVFhbytQREtnTkM2Q0VFcTJRZmNNSEs4ckpwUU8vQ1Vn?=
 =?utf-8?B?VVBrQU9KYXNnWWtPSGpENDBxL2EyeTRHL0FuU0pXdHZUcGJWL0JPS2FKb3Vz?=
 =?utf-8?B?c2pNU3FlM1FrTmJ6RXEwd0tiT3QrenRhcjd3QXY4SVd6U3E2elZxZ1VZOXdk?=
 =?utf-8?B?ek9hckozQnJpZS83RVRMYzlBd1Y0MUtHY3BSMkNCa25GQ01YQ0dzUzVIS0U4?=
 =?utf-8?B?bUxiK3pIMjBYZjZXbmNLYWkvN1BKS0Z6ODhHVFc5NGxFbjdrQnp0Y0pJblhD?=
 =?utf-8?B?UzUxRVlURzhsNENsYjFsS1Y5S1EwbTJjMHdNd1dMSHdsWUVHczgwQmVsSHlJ?=
 =?utf-8?B?R1J3ZTl2REl5S3pYNUE3dkJJakNWM0M2eVhBZFJWZE9HVXhFaytUaEtlS3NG?=
 =?utf-8?Q?1wJGdrv53BGsGTNa9kZR+3JCAl0OeII8PeZps=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720487ae-71f8-4d38-a0f4-08d98df01029
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 02:20:45.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhbfX/dIIpEtgyPcSPWZ3hlQsE4n0bMICvNtJUj4LwPGQCaAPaGFIFRL7E9q6BL3nK36Ry0TAbjSO6DEDAaR7rRJRfkDpVPg/SYgHeCbQMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2861
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130012
X-Proofpoint-GUID: SyV1af76wvy2B5CDJ881LylQtwFUezLv
X-Proofpoint-ORIG-GUID: SyV1af76wvy2B5CDJ881LylQtwFUezLv
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/5/21 4:44 PM, Michael Roth wrote:
> VM implementations that make use of encrypted memory need a way to
> configure things like the encryption/shared bit position for page
> table handling, the default encryption policy for internal allocations
> made by the core library, and a way to fetch the list/bitmap of
> encrypted pages to do the actual memory encryption. Add an interface to
> configure these parameters. Also introduce a sparsebit map to track
> allocations/mappings that should be treated as encrypted, and provide
> a way for VM implementations to retrieve it to handle operations
> related memory encryption.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   .../testing/selftests/kvm/include/kvm_util.h  |  6 ++
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 63 +++++++++++++++++--
>   .../selftests/kvm/lib/kvm_util_internal.h     | 10 +++
>   3 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 010b59b13917..f417de80596c 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -348,6 +348,12 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
>   
>   void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
>   
> +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> +			      uint8_t enc_bit);
> +struct sparsebit *vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot,
> +					     vm_paddr_t *gpa_start,
> +					     uint64_t *size);
> +
>   /* Common ucalls */
>   enum {
>   	UCALL_NONE,
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 92f59adddebe..c58f930dedd2 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -631,6 +631,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>   		    "rc: %i errno: %i", ret, errno);
>   
>   	sparsebit_free(&region->unused_phy_pages);
> +	sparsebit_free(&region->encrypted_phy_pages);
>   	ret = munmap(region->mmap_start, region->mmap_size);
>   	TEST_ASSERT(ret == 0, "munmap failed, rc: %i errno: %i", ret, errno);
>   
> @@ -924,6 +925,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>   	}
>   
>   	region->unused_phy_pages = sparsebit_alloc();
> +	region->encrypted_phy_pages = sparsebit_alloc();
>   	sparsebit_set_num(region->unused_phy_pages,
>   		guest_paddr >> vm->page_shift, npages);
>   	region->region.slot = slot;
> @@ -1153,6 +1155,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
>    *   num - number of pages
>    *   paddr_min - Physical address minimum
>    *   memslot - Memory region to allocate page from
> + *   encrypt - Whether to treat the pages as encrypted
>    *
>    * Output Args: None
>    *
> @@ -1164,11 +1167,13 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
>    * and their base address is returned. A TEST_ASSERT failure occurs if
>    * not enough pages are available at or above paddr_min.
>    */
> -vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> -			      vm_paddr_t paddr_min, uint32_t memslot)
> +static vm_paddr_t
> +_vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, vm_paddr_t paddr_min,
> +		    uint32_t memslot, bool encrypt)
>   {
>   	struct userspace_mem_region *region;
>   	sparsebit_idx_t pg, base;
> +	vm_paddr_t gpa;
>   
>   	TEST_ASSERT(num > 0, "Must allocate at least one page");
>   
> @@ -1198,10 +1203,25 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>   		abort();
>   	}
>   
> -	for (pg = base; pg < base + num; ++pg)
> +	for (pg = base; pg < base + num; ++pg) {
>   		sparsebit_clear(region->unused_phy_pages, pg);
> +		if (encrypt)
> +			sparsebit_set(region->encrypted_phy_pages, pg);
> +	}
> +
> +	gpa = base * vm->page_size;
>   
> -	return base * vm->page_size;
> +	if (encrypt && vm->memcrypt.has_enc_bit)
> +		gpa |= (1ULL << vm->memcrypt.enc_bit);
> +
> +	return gpa;
> +}
> +
> +vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> +			      vm_paddr_t paddr_min, uint32_t memslot)
> +{
> +	return _vm_phy_pages_alloc(vm, 1, paddr_min, memslot,
> +				   vm->memcrypt.enc_by_default);
>   }
>   
>   vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> @@ -2146,6 +2166,10 @@ void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
>   			region->host_mem);
>   		fprintf(stream, "%*sunused_phy_pages: ", indent + 2, "");
>   		sparsebit_dump(stream, region->unused_phy_pages, 0);
> +		if (vm->memcrypt.enabled) {
> +			fprintf(stream, "%*sencrypted_phy_pages: ", indent + 2, "");
> +			sparsebit_dump(stream, region->encrypted_phy_pages, 0);
> +		}
>   	}
>   	fprintf(stream, "%*sMapped Virtual Pages:\n", indent, "");
>   	sparsebit_dump(stream, vm->vpages_mapped, indent + 2);
> @@ -2343,3 +2367,34 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
>   
>   	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
>   }
> +
> +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> +			      uint8_t enc_bit)
> +{
> +	vm->memcrypt.enabled = true;
> +	vm->memcrypt.enc_by_default = enc_by_default;
> +	vm->memcrypt.has_enc_bit = has_enc_bit;
> +	vm->memcrypt.enc_bit = enc_bit;
> +}
> +
> +struct sparsebit *
> +vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
> +			   uint64_t *size)
> +{
> +	struct userspace_mem_region *region;
> +	struct sparsebit *encrypted_phy_pages;
> +
> +	if (!vm->memcrypt.enabled)
> +		return NULL;
> +
> +	region = memslot2region(vm, slot);
> +	if (!region)
> +		return NULL;
> +
> +	encrypted_phy_pages = sparsebit_alloc();
> +	sparsebit_copy(encrypted_phy_pages, region->encrypted_phy_pages);
> +	*size = region->region.memory_size;
> +	*gpa_start = region->region.guest_phys_addr;
> +
> +	return encrypted_phy_pages;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> index a03febc24ba6..99ccab86115c 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> +++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> @@ -16,6 +16,7 @@
>   struct userspace_mem_region {
>   	struct kvm_userspace_memory_region region;
>   	struct sparsebit *unused_phy_pages;
> +	struct sparsebit *encrypted_phy_pages;
>   	int fd;
>   	off_t offset;
>   	void *host_mem;
> @@ -44,6 +45,14 @@ struct userspace_mem_regions {
>   	DECLARE_HASHTABLE(slot_hash, 9);
>   };
>   
> +/* Memory encryption policy/configuration. */
> +struct vm_memcrypt {
> +	bool enabled;
> +	int8_t enc_by_default;
> +	bool has_enc_bit;
> +	int8_t enc_bit;
> +};
> +
>   struct kvm_vm {
>   	int mode;
>   	unsigned long type;
> @@ -67,6 +76,7 @@ struct kvm_vm {
>   	vm_vaddr_t idt;
>   	vm_vaddr_t handlers;
>   	uint32_t dirty_ring_size;
> +	struct vm_memcrypt memcrypt;


For readability, it's probably better to adopt a standard naming 
convention for structures, members and  functions ?  For example,

         encrypted_phy_pages    ->     enc_phy_pages

         struct vm_memcrypt  {    ->    struct vm_mem_enc {

         struct vm_memcrypt memcrypt    ->    struct vm_mem_enc  mem_enc

         vm_get_encrypted_phy_pages()    -> vm_get_enc_phy_pages



>   };
>   
>   struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid);
