Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4E42FFC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Oct 2021 04:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbhJPC7G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 22:59:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236923AbhJPC7F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 22:59:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19G0Qu3K000765;
        Sat, 16 Oct 2021 02:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eNRapz2EzA3riwh82/ll/kmDueFTJe222LVC08tNn+Y=;
 b=d3vDU4R1l7bqht09SPSBt9u1rzpOpuYrxzX4UzsQllQnCwE7EDPzd7an4rclly/jggbb
 qA4xYnvNIRGUwB05LcNLIy845FNDwG4ErOfckOhDrn+L04MnyEBbyqcRf3yVQj9RCU/k
 msngVs9Qa2olwvBUHcAZyQT3nSkr7N2U/EIZMaphMePqw1jQYcaenqoVv9uC+Nbg3diu
 lyovzw+0iy94P0tKlZl027JG+HVHDPWGblX8Jbb1YTRr9bFkoPnUNHXGzamVGV2MQ8vC
 nXIO3//sRj/w0lCyyjfiCLlV+ko/U3X6HzoLw6kboh07/mQWUdHDTI//Ttqx9WfwgF4w Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqb9pkbm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 02:56:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19G2kZFI049990;
        Sat, 16 Oct 2021 02:56:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3bqmsatmhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 02:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2CcjPsZBtOd3ug6P+4Muz3OtgW5G9VZ6ZEhm6Rr84G6xwYVrnHj8uznamdgeeluqaLgClxYpgT+F2MDuucK2pGHLtYpHrfZUyUhLeQQ5rqLIA1q5n2giew6XbPkpoNWzj4ELVGlyU/Qc6ws6jgA7De12N3QfEtWh01U3vOQFBnY+FT/Zp4WHWNfldGsfLiYn5+oV0niCGGRWKhZ3p51k7opax6h8GYhb4QDoiI1Fjh51OZMbBR6iBfF/96cf4bVGPeRF4GkkQOPnnowXRmqdAvb+1O3+oOHCrO/bqOlj0B2xHvUeqZ8kzWEd/zqTSWyl4jqlGselpEnb5A1WSCbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNRapz2EzA3riwh82/ll/kmDueFTJe222LVC08tNn+Y=;
 b=ilQiEj0Nv4s8h6Y4pRkOSMcnwSvXSNKu+SPjMtB6dgf5p7s+LQ/Q+typi2B3z3ckCz0CzHaOJTiyDB53FZU1C3MUkT6OuZZ44UmrW5+jlI95gGmsKpO+9JTWB5QOvZPcx9G05z6OVWwhQYU73/FJIgeNlnXwxh5AuPbCrc1IqU+J48gUWCAP4g3wzxa/zPRqaoZ4w9KkLc/SFWbUEqCjZZYDJOhL2C918pdjKRPsav1FIqOwEYrJDlj5zHTKILX3VPLFyfxtT3I9h7ZausSqhvXLZ1mz63MWkNh+/b/r8ECiIxf4F070hbrol+/6tmpvu9EaFQW+gK2JUnnjELCMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNRapz2EzA3riwh82/ll/kmDueFTJe222LVC08tNn+Y=;
 b=wvhg7BtwmV1BqjdNrhbtY3QmdVd7yc7uFdN0+KaARhaxL1C743b5V5qx1QXMLiiBMJtGucT8GTKmULD49A/F9Yl3rKLbeqVYGmTFSiJMpgCjGon+Gedxh7LOm1pIjMz/621eu9m+0fpzTvNmKD8Z2++iZrTHjPAxRVcFer4fhUs=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Sat, 16 Oct
 2021 02:55:57 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491%7]) with mapi id 15.20.4587.030; Sat, 16 Oct 2021
 02:55:57 +0000
Subject: Re: [RFC 07/16] KVM: selftests: add SEV boot tests
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
 <20211006203726.13402-1-michael.roth@amd.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <4e3d8f38-f01f-c1aa-335b-2c248f512638@oracle.com>
Date:   Fri, 15 Oct 2021 19:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20211006203726.13402-1-michael.roth@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:806:d2::26) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SA0PR11CA0081.namprd11.prod.outlook.com (2603:10b6:806:d2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Sat, 16 Oct 2021 02:55:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d2276c-77b7-4244-5c46-08d990507a1f
X-MS-TrafficTypeDiagnostic: SA2PR10MB4665:
X-Microsoft-Antispam-PRVS: <SA2PR10MB46653F67B782DD2C3A0382B781BA9@SA2PR10MB4665.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAf5HNA53Xn3A6+KZgJDu9LDuZK769WJOrR/UssA+zi0I1fVwDaz4s+8KIv2HbGGGO3SsUNDZmBNnqxNcLhASX+Ca8+kEIv4SuX5xDRCENvJBGp6igupSUKouaTbqhrG5TcBU7akaCOOeNHJJa4FcJQ1Gl70LRGoOLYyMfP7uBDWFtclewCJ4+qAKrIxQFZxXe4/nInGTUM+HjQKxQbQD+lK54uds4NwQhi+VhxEn8as1qK3LJ33SjBH1Xg/nQYmQcPdlbxNs5JZI5rl8k8eEjj6dHh2u5c4Ho+EcnN0XSRY4VX3VrrY8VAav8phiCfcNYY8vfIE3nHfzq8fXeGwIT3B+DYOIR0zlJcWSiQFY0AsoccDqjjNf4PpHr3hAlzohslmczRk4wCWEusH7DeOpmQMwqkwjeB9Tpb/pFKLXTsksjoE/acSDzzOqfloNAHt6zKGYv+4Z1gXBGiGue5ymsCKzPVNqZMehfGk9PQPXAkWuuW8BlNxFwowMygs5xR6oXwjN9B4kd/bFurCdCLt6R0fLZPkJ+88z/norpivycUPBfTWPX1Tst0c28Ef5X12SeU8XLw3dYpQom3GiWfOZMZo2IA6tgWATmtsryRCbXzOdf41SdxaqZcdCZd/ClKkvu8062o3a6JcumlRN8nSuy12pEK6n/QMaIWgFZtX+TZuXmvqBRSot7LWackSB8VGR6qz4YOHLpvw9y6ch28OGKdC2gKSkSLiL+mTky91lHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(38100700002)(31686004)(7416002)(2616005)(86362001)(31696002)(8676002)(6512007)(66556008)(66946007)(54906003)(66476007)(508600001)(8936002)(6506007)(53546011)(83380400001)(316002)(4326008)(2906002)(30864003)(5660300002)(6486002)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBDZGlFNkhieVpqVVZtTzhpSVhrUHBINDhMUDAzSGNMa0x6cVZWUmc5MUl5?=
 =?utf-8?B?LzY1QlJJdTA0OHh0T1NXdzBvUEdXaEdEckgxMUNZZ0RPN3NRNFlMZEFUNmRY?=
 =?utf-8?B?Q2ExekRiSGJxREtHa1dTQWZpdTRWOExKMmgvYTg5QlNwOFpMQjBmSFJLZy8v?=
 =?utf-8?B?WEpTQyt2eUFkWFFCSldEWU1UMGd0K1pLQ0c3RmlvWlhTWXFrNUlLQXc3Y3NY?=
 =?utf-8?B?SW1ockdyaXp6Ly9NbktnTUFGdEZRT2FDWk1IVmhNa01NUXB2Wm9kWWIxbVlW?=
 =?utf-8?B?d2dzV2Q2YnpGOUM3eEVUcWQ3OGh0RGVpSDNiS2NBbmtHd3NYWGVGd2xXN21Y?=
 =?utf-8?B?MWVmRzB6U0U4WHlhNlpzTlcyYmNOWUxUNHdFd1hENGY1QlRkU2NSYlFDZ25k?=
 =?utf-8?B?a0tYWkpFQ2NPQXJMZHZCU3JJYkpYVDNyRTZuaGdCTHpTVUcvL29QR2E2eU5z?=
 =?utf-8?B?ckRzVHg3RzdhclJnQjJKbjBGZFQvdGtpeHVobytLcFlSdTg0eWl0YzJJdGVV?=
 =?utf-8?B?VzJrdk5OK1RVZHl0MWQyVjZtc2MrWVZnNFBVOUgwZCtaQTV2MzVUaXhFL0cy?=
 =?utf-8?B?SkxjV3VBYm9qdFBpcGtjaDhkYndkZjg3V2hRRUVmcEhEemJxNm8rRHorS0hy?=
 =?utf-8?B?Wks1Ty9CWFdUbEF4S2poWlJyTXNzd1o1eUtURVoxWGwyYURWY2dNT1VhM0ZC?=
 =?utf-8?B?L3FhamRoemNBWVRwMEs0dVNvSHh2YWE4UW5FS0tCR1dRQlhYWHFHMGhhQjh1?=
 =?utf-8?B?aktmOU8xeG9VNG5ZQmo4bEVMOExhTlBJZW9odkVjNDN6ZzhZNGpuZTV0YmUv?=
 =?utf-8?B?UTU4aXhsK1h4YkVYUkdhOFJiVjB0TWZXQi9sYmZGbklsU3V4bXNkVnhFS2xF?=
 =?utf-8?B?TzNVTlh0alJQNkdtWDAvT1VEZUcvSEVWRXNkUk5Iamg1eUhsQzVLL0EzMVRC?=
 =?utf-8?B?bnp2cnJPd3Q2SUVGeDRWN1c1dWpwd21uVDI0REJucGlUQ01xQmtjaTJXNzFT?=
 =?utf-8?B?WURQeE13VmlQb3lpcjV5UmovNDlaRnVDQW5nZ2RhSXlmVHFtNERwYkpYcEgw?=
 =?utf-8?B?S2pPQnpySG1EczNPYlhnc3FBTjlEeWJCeVVNN3k5N24rVVRIM2hUYTYxcGVL?=
 =?utf-8?B?Mlk4b0M0WnB2KzMwQUFRQ0lHWnVKYzY1OE1YMmM5YXc0S1FQOFV6ajZXWkQr?=
 =?utf-8?B?SE1sNVNxTW5aTkNtQ3RDVGMzMmNPU2VqSU0wWE9TVG01aHpGM09SemtkejFB?=
 =?utf-8?B?MFBFZ3YvRk1MNmJHZFlZSnpGelFwYWVPSU0zR0oxMHE0bEd3NkJTZ04vZ3FH?=
 =?utf-8?B?dWRVMm5vYXZUa0lYSnc1TkdjbExjbEJzUjZJNG82NTRFSW1WMEM4UVZ5QUtz?=
 =?utf-8?B?V2grVlJMajBYVHNJdkIrQzdVTkFWdHBRV25kWEZabUVKYjZDMXBQSmhyZ3dx?=
 =?utf-8?B?QkZhNmdqN0VyczU0Qi9Kblp0MXBCV3NPWUx4ekNjZy9FNzBWaWljZXdiSUFu?=
 =?utf-8?B?Qlk5NjZPUXBtK2lETjFtUy9wWVhxWFQ4TDJmbGVtcDlPV09teVo5NEdYL3JM?=
 =?utf-8?B?L2UyLzVLRlhaMy9GZVlJS3JSMC9mSllCVmpON0ppLzlNQld0MmdPMi8yZUM2?=
 =?utf-8?B?dUhhenI5NEV6bFJkZVVNZ2NMVWRIa0psSXZ1MldMN0RXdjNlWmxEblF3dll2?=
 =?utf-8?B?Z3Z1bVFzcWxCKzFxTjNzVDR2NmZ2YXBxT2JGNENkYXYrQzQvbzh4UTgyd1pT?=
 =?utf-8?B?SStMK0JnZmc3TksrUlJVMk9idFRjSDFEQS9nR0tvMThxQ09KVHJLdDRjYXFt?=
 =?utf-8?B?ZDlEd01kOVdlY2dkK1M0Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d2276c-77b7-4244-5c46-08d990507a1f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 02:55:57.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVb6ZmDSgjaEo/xgiqQ+SEKKTZRf2wbvMffSMovy0K1vbpiERCpD8f1DhHianAnKMKYZleYDqYyB63+UKUnMmybt6BcvItzqhfhxVYvNX5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110160016
X-Proofpoint-GUID: 2enyz3H1q7jz6tgAAxTjOY8teLItVl5m
X-Proofpoint-ORIG-GUID: 2enyz3H1q7jz6tgAAxTjOY8teLItVl5m
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/6/21 1:37 PM, Michael Roth wrote:
> A common aspect of booting SEV guests is checking related CPUID/MSR
> bits and accessing shared/private memory. Add a basic test to cover
> this.
>
> This test will be expanded to cover basic boot of SEV-ES and SEV-SNP in
> subsequent patches.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/x86_64/sev_all_boot_test.c  | 252 ++++++++++++++++++
>   3 files changed, 254 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 0709af0144c8..824f100bec2a 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -38,6 +38,7 @@
>   /x86_64/xen_vmcall_test
>   /x86_64/xss_msr_test
>   /x86_64/vmx_pmu_msrs_test
> +/x86_64/sev_all_boot_test
>   /access_tracking_perf_test
>   /demand_paging_test
>   /dirty_log_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index c7a5e1c69e0c..aa8901bdbd22 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -72,6 +72,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
>   TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
>   TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
>   TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
> +TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
>   TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
>   TEST_GEN_PROGS_x86_64 += demand_paging_test
>   TEST_GEN_PROGS_x86_64 += dirty_log_test
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> new file mode 100644
> index 000000000000..8df7143ac17d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Basic SEV boot tests.
> + *
> + * Copyright (C) 2021 Advanced Micro Devices
> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +#include "linux/psp-sev.h"
> +#include "sev.h"
> +
> +#define VCPU_ID			2
> +#define PAGE_SIZE		4096
> +#define PAGE_STRIDE		32
> +
> +#define SHARED_PAGES		8192
> +#define SHARED_VADDR_MIN	0x1000000
> +
> +#define PRIVATE_PAGES		2048
> +#define PRIVATE_VADDR_MIN	(SHARED_VADDR_MIN + SHARED_PAGES * PAGE_SIZE)
> +
> +#define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
> +
> +static void fill_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < pages; i++)
> +		for (j = 0; j < PAGE_SIZE; j += stride)
> +			buf[i * PAGE_SIZE + j] = val;
> +}
> +
> +static bool check_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < pages; i++)
> +		for (j = 0; j < PAGE_SIZE; j += stride)
> +			if (buf[i * PAGE_SIZE + j] != val)
> +				return false;
> +
> +	return true;
> +}
> +
> +static void guest_test_start(struct sev_sync_data *sync)
> +{
> +	/* Initial guest check-in. */
> +	sev_guest_sync(sync, 1, 0);
> +}
> +
> +static void check_test_start(struct kvm_vm *vm, struct sev_sync_data *sync)
> +{
> +	struct kvm_run *run;
> +
> +	run = vcpu_state(vm, VCPU_ID);
> +	vcpu_run(vm, VCPU_ID);
> +
> +	/* Initial guest check-in. */
> +	sev_check_guest_sync(run, sync, 1);
> +}
> +
> +static void
> +guest_test_common(struct sev_sync_data *sync, uint8_t *shared_buf, uint8_t *private_buf)
> +{
> +	bool success;
> +
> +	/* Initial check-in for common. */
> +	sev_guest_sync(sync, 100, 0);
> +
> +	/* Ensure initial shared pages are intact. */
> +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
> +	SEV_GUEST_ASSERT(sync, 103, success);
> +
> +	/* Ensure initial private pages are intact/encrypted. */
> +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> +	SEV_GUEST_ASSERT(sync, 104, success);
> +
> +	/* Ensure host userspace can't read newly-written encrypted data. */
> +	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> +
> +	sev_guest_sync(sync, 200, 0);
> +
> +	/* Ensure guest can read newly-written shared data from host. */
> +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
> +	SEV_GUEST_ASSERT(sync, 201, success);
> +
> +	/* Ensure host can read newly-written shared data from guest. */
> +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
> +
> +	sev_guest_sync(sync, 300, 0);
> +}
> +
> +static void
> +check_test_common(struct kvm_vm *vm, struct sev_sync_data *sync,
> +		  uint8_t *shared_buf, uint8_t *private_buf)
> +{
> +	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
> +	bool success;
> +
> +	/* Initial guest check-in. */
> +	vcpu_run(vm, VCPU_ID);
> +	sev_check_guest_sync(run, sync, 100);
> +
> +	/* Ensure initial private pages are intact/encrypted. */
> +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> +	TEST_ASSERT(!success, "Initial guest memory not encrypted!");
> +
> +	vcpu_run(vm, VCPU_ID);
> +	sev_check_guest_sync(run, sync, 200);
> +
> +	/* Ensure host userspace can't read newly-written encrypted data. */
> +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> +	TEST_ASSERT(!success, "Modified guest memory not encrypted!");
> +
> +	/* Ensure guest can read newly-written shared data from host. */
> +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
> +
> +	vcpu_run(vm, VCPU_ID);
> +	sev_check_guest_sync(run, sync, 300);
> +
> +	/* Ensure host can read newly-written shared data from guest. */
> +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
> +	TEST_ASSERT(success, "Host can't read shared guest memory!");
> +}
> +
> +static void
> +guest_test_done(struct sev_sync_data *sync)
> +{
> +	sev_guest_done(sync, 10000, 0);
> +}
> +
> +static void
> +check_test_done(struct kvm_vm *vm, struct sev_sync_data *sync)
> +{
> +	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
> +
> +	vcpu_run(vm, VCPU_ID);
> +	sev_check_guest_done(run, sync, 10000);
> +}
> +
> +static void __attribute__((__flatten__))
> +guest_sev_code(struct sev_sync_data *sync, uint8_t *shared_buf, uint8_t *private_buf)
> +{
> +	uint32_t eax, ebx, ecx, edx;
> +	uint64_t sev_status;
> +
> +	guest_test_start(sync);
> +
> +	/* Check SEV CPUID bit. */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	cpuid(&eax, &ebx, &ecx, &edx);
> +	SEV_GUEST_ASSERT(sync, 2, eax & (1 << 1));
> +
> +	/* Check SEV MSR bit. */
> +	sev_status = rdmsr(MSR_AMD64_SEV);
> +	SEV_GUEST_ASSERT(sync, 3, (sev_status & 0x1) == 1);
> +
Is there any need to do the cpuid and MSR tests every time the guest 
code is executed ?
> +	guest_test_common(sync, shared_buf, private_buf);
> +
> +	guest_test_done(sync);
> +}
> +
> +static void
> +setup_test_common(struct sev_vm *sev, void *guest_code, vm_vaddr_t *sync_vaddr,
> +		  vm_vaddr_t *shared_vaddr, vm_vaddr_t *private_vaddr)
> +{
> +	struct kvm_vm *vm = sev_get_vm(sev);
> +	uint8_t *shared_buf, *private_buf;
> +
> +	/* Set up VCPU and initial guest kernel. */
> +	vm_vcpu_add_default(vm, VCPU_ID, guest_code);
> +	kvm_vm_elf_load(vm, program_invocation_name);
> +
> +	/* Set up shared sync buffer. */
> +	*sync_vaddr = vm_vaddr_alloc_shared(vm, PAGE_SIZE, 0);
> +
> +	/* Set up buffer for reserved shared memory. */
> +	*shared_vaddr = vm_vaddr_alloc_shared(vm, SHARED_PAGES * PAGE_SIZE,
> +					      SHARED_VADDR_MIN);
> +	shared_buf = addr_gva2hva(vm, *shared_vaddr);
> +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
> +
> +	/* Set up buffer for reserved private memory. */
> +	*private_vaddr = vm_vaddr_alloc(vm, PRIVATE_PAGES * PAGE_SIZE,
> +					PRIVATE_VADDR_MIN);
> +	private_buf = addr_gva2hva(vm, *private_vaddr);
> +	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> +}
> +
> +static void test_sev(void *guest_code, uint64_t policy)
> +{
> +	vm_vaddr_t sync_vaddr, shared_vaddr, private_vaddr;
> +	uint8_t *shared_buf, *private_buf;
> +	struct sev_sync_data *sync;
> +	uint8_t measurement[512];
> +	struct sev_vm *sev;
> +	struct kvm_vm *vm;
> +	int i;
> +
> +	sev = sev_vm_create(policy, TOTAL_PAGES);
> +	if (!sev)
> +		return;
> +	vm = sev_get_vm(sev);
> +
> +	setup_test_common(sev, guest_code, &sync_vaddr, &shared_vaddr, &private_vaddr);
> +
> +	/* Set up guest params. */
> +	vcpu_args_set(vm, VCPU_ID, 4, sync_vaddr, shared_vaddr, private_vaddr);
> +
> +	sync = addr_gva2hva(vm, sync_vaddr);
> +	shared_buf = addr_gva2hva(vm, shared_vaddr);
> +	private_buf = addr_gva2hva(vm, private_vaddr);
> +
> +	/* Allocations/setup done. Encrypt initial guest payload. */
> +	sev_vm_launch(sev);
> +
> +	/* Dump the initial measurement. A test to actually verify it would be nice. */
> +	sev_vm_measure(sev, measurement);
> +	pr_info("guest measurement: ");
> +	for (i = 0; i < 32; ++i)
> +		pr_info("%02x", measurement[i]);
> +	pr_info("\n");
> +
> +	sev_vm_launch_finish(sev);
Since the above section of this function is actually setup code and is 
not running the test yet, it is best placed in a setup function. My 
suggestion is that you place the above section into a function called 
setup_test_common() and within that function you further separate out 
the SEV-related setup into a function called setup_test_sev() or 
something similar. Then call the top-level setup function from within 
main().
> +
> +	/* Guest is ready to run. Do the tests. */
> +	check_test_start(vm, sync);
> +	check_test_common(vm, sync, shared_buf, private_buf);
> +	check_test_done(vm, sync);

These function names can be better. These functions are not just 
checking the result, they are actually running the guest code. So, may 
be, calling them 'test_start, test_common and test_done are better. I 
would just collapse them and place their code in test_sev() only if you 
separate the out the setup code as I suggested above.

> +
> +	sev_vm_free(sev);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	/* SEV tests */
> +	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
> +	test_sev(guest_sev_code, 0);
> +
> +	return 0;
> +}
