Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5324339E75F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jun 2021 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFGTY7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 15:24:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20904 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230311AbhFGTY7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 15:24:59 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157JBPXZ015359;
        Mon, 7 Jun 2021 19:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aLGcX6T1NlQG3qjcZ7YUngBcUHdi7ocaT0tP+U3xK/U=;
 b=ljL4zaTqa11FUMnM9GR8NQOouImM+F4WEPeh+T+G5CFjcUEBmbuyOH8o8o6i9Mdijf/R
 epuLHEorxLGYmPL3t4jVvbG0H0gNxWAdqK/KNWiIjKor6zWREa5edRwaD6ABHywnVnXM
 rQApHLhzkh1IqJTBESlSJaaynAnqtg2msDFvvsgFHUJxGhFQSYFov2i1u4N70LNhSfYT
 SnVVwDK/3Sz9+IsOimOfBNJq8jPcLkv4iJpIv8tRSwzzwXnPdsEengscdEEz+u7IZj+m
 bivVO/WpGj2f8jNlQz3LMNXnet/NmWkI36dAQUkuoeH/x2tBt3r7YRDYpgUi4qvvaXMK eg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 391g4g86t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:22:43 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 157JMgDQ099533;
        Mon, 7 Jun 2021 19:22:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 38yyaab6f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABE1vV2ZhzaPAwPLKwtX0KVUrVUYOHaGEb3cOsF90EWFDV09h/Otjhi0jpNU39Y3XqCIkpsKuWjXmsicRvu3CzDl34B51d/+mpsCjWE8czxBJ5iuDNT5rYD6IbK6c0it8n5u48Wgn/IGq8kIrWvZg0U7mVrjMvyIeiCSAH3PbWzaY2CG7Nl+SH0xtTHr2O+nYBFbYRLlMgwJHpfgAinCJZvs9Yl1VFsfHtBVarlBbNR2FnDOa4zO6tnrSSSdWI5In3J9sjCu5MAnG0zaQzgtaxjq6QM+M+DzgdiKsXGnfNA6LiTtcBXWjgoOkAe5q5qShG/blkvKHgKJdrIxW52Gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLGcX6T1NlQG3qjcZ7YUngBcUHdi7ocaT0tP+U3xK/U=;
 b=IhQO68BGCkqm3ePnqqplbtophnK72Lc4Zogc/OFxln3ZN3ve0eMg82UsbBngcRjt6E+Pc1OJyfEsJyJilbE7mY9XLzqG4YHEHcFK4H3SqMMrwDBaCfUEhCNtdMKt2UrxCaOMnakwa9T2soyS9uAMghqwbPSngNoxvQeCxvprQ7qa1nftTb9Jw8x38eSHOOwKMU9uLcSTFb/OMqqRRWYQtByPfUxTXpyY7oBz6x85EoZojiuJlVF5pWwCHnOI3s7RZjA4IO+mmvAW5qrMrfJp+rGZ16KhPrsEjKPFJdXHzcOqm+p7dv/Oj6cATGHY+IVcPkYlGSzSw7cjF+K31t3UGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLGcX6T1NlQG3qjcZ7YUngBcUHdi7ocaT0tP+U3xK/U=;
 b=NLspbweOITSuDKXmyCaPXtMJp6RlZSkLXeNJMRHpRQW+QWWOVFplpndh1amNWQGg9E9cFcigpnkmXq/adCSw5f9tGjYVTk92ORQM5UXF2WMqspf8Chjal4kWGBojFYqycGT3uMImOtfX+VxoLTDgf6ljjLm6vGv+8ptETWm4W8s=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SA2PR10MB4537.namprd10.prod.outlook.com (2603:10b6:806:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 19:22:40 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:22:40 +0000
Subject: Re: [PATCH v7 1/4] KVM: stats: Separate generic stats from
 architecture specific ones
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
 <20210603211426.790093-2-jingzhangos@google.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <a39a6e64-1edf-2341-fb3a-0f333dd4a323@oracle.com>
Date:   Mon, 7 Jun 2021 12:22:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210603211426.790093-2-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN6PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:805:ca::48) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SN6PR16CA0071.namprd16.prod.outlook.com (2603:10b6:805:ca::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 19:22:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6260042-050b-4e93-df53-08d929e99d7a
X-MS-TrafficTypeDiagnostic: SA2PR10MB4537:
X-Microsoft-Antispam-PRVS: <SA2PR10MB45377FC1E14F9EE44F91664E81389@SA2PR10MB4537.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00N4kbyRIoi36W7L8FtMfDTFd7aboMg3xIHPWwD/O9bAKDb7KxuUvzMGRIPkZ5Eesb4LO7RyNjdJXT0k8dhPOadT6HszhNqht5IQnRyKM0WlojnCYr9mYO8OdOA3Y43zxglSFWaNOmLe8qLwH6f7mldHv9LI2koANwKjHQSOKK0YG527An1n05L1yxq96IEJ2akbptRoUfWXvrB5Hlr75UF7S2Vz2eFhQfT2YrV2MCja7UhjOFXZtlBbxW7A/npF9dhYTG7HKpC7OHHf8/O87Kv8H7xd3b+uzbfVeGpgxzN2V0ZAPbu0fNcNSJdSK3zHYvTquTC0E/f9eBJ0aAWwjYMJDnqsss3zlLfV1qghRAmcvULF01sQ7W92jDKVfvsyVicpy45d5G4Qq6gcvCiJPKFaxbv6KGZkZU0gfEPAOQLJT+xobtyrrilLRFQu25EZKZ7RWsIKxHSk18PdChqpsmmjs4QkY670Wfr3D2MC2NX4RtKiWHhMDUswmMZXD1cSwgtWWWHtwqez+940pLLzhaRuNBUKzeyKNccxBOyS0XNwi5vUCZduAfX7Jpo5zKtOjW9VEh8wh4Ai0jX2JrojdVgPcBRUvalpB4kMsQI5W1dE0cect6zguntoQh4dZBuwqWr5ZOG9NgxT+lBXfguUFIxd7mtk7dCBtLIN2dubcW/DVZZlg81jPBlY2Zv+V3b+X0WCeqjkLtT+HKxwNw9P8aEyD8wfcIhcExbhVi2EfG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(2616005)(66946007)(66476007)(66556008)(31696002)(86362001)(186003)(36756003)(6506007)(38100700002)(5660300002)(8676002)(921005)(53546011)(16526019)(44832011)(7406005)(8936002)(2906002)(7416002)(83380400001)(6486002)(478600001)(31686004)(110136005)(6512007)(30864003)(316002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MkJvb2tFR1JDSUI0V21mckZkcS9lVHJJQVJUNVM0SVgwNTF2S1hVelM5eUVh?=
 =?utf-8?B?L3FqcDYwWnhveHlrT3lEaWE2QVZtSzkrRitvMnBSTUNTUER0ZnVaVE5SOG50?=
 =?utf-8?B?TTVzTmZDVHhONGErOEM1SGtUNm50QytSNmd2VW9UejF4eVNQUHVBMDgzQW41?=
 =?utf-8?B?RlJsNXJHU1llaHlMbEJ2a3A4MXhFU3FqWmhIT0dDSkxUSHUvU0RJQ0V6WTIr?=
 =?utf-8?B?TlRPRnV5ZnB2WEpwUWhBVEo2ZTVqMVdnYm9kTk0xSGtLM2dqOTZrYVZvQ3N5?=
 =?utf-8?B?ZWxCSWpDSUt6elp2amkvSEF6K3Q5M28zaFNJRE5KajJOT0ZwNlNHRDZwMUZC?=
 =?utf-8?B?RUJWMmtrekZ2WGZ4ckFVNWdNMCtQbnVUd0NKWG56R2Fqb2JWcDRSclpTQzJh?=
 =?utf-8?B?QlE1b1FqSEtDbXJSYnRhUVQvRDd5MkV4eTVBdWJXdlpoQXEvWjFzRHVYSVFz?=
 =?utf-8?B?bE5ld3hzQ2liUlJhQWFjZ2djdkpJOWRvakFzeVJMUzVmbnFWcld6Q1lodDM4?=
 =?utf-8?B?bU85NHBrSStIbDkwMEo2K1VZZ0lQRzMybGNyTi9McEs1Z21kc20weXpicFZB?=
 =?utf-8?B?bjA0OEl1OXZvYVBnUytFRk4yWlI4WkZvaFZPQUkzQmNJL1ltdXBVUGswK2d1?=
 =?utf-8?B?WHRPSGFTSjl0RUF2MFRHd0htTGl0SmdyYXdteGc5d1NtZldnYjlrNENncEV3?=
 =?utf-8?B?NE1vSGl1cVpCb1cxYkhnbitPdDI0MDZkMkxVazZBanRXNjh3SFpWOUY1dU5S?=
 =?utf-8?B?N2d1bG0vVEFhaU9aVUx4Y2ZGeGljUUV5dnlDZURzSGJyY0VEaVMzcHNSYVdC?=
 =?utf-8?B?MmhSL1M2WVJqdTM3M2FRL2dIYkl1M05QYUJCZmZYTHE4NFRjRlM1K0FJQVA0?=
 =?utf-8?B?YmtNM0g2RHR1SzZkVHNwbmxhRHFKVjdDSDdUQnZaSDAxczVIU0JFYXZyRHRy?=
 =?utf-8?B?dm1jakI1RFA4MjdpdG1BRVpkVTNJWlg1U0VSU094WFVkbTVNaHhlbW5BTHdX?=
 =?utf-8?B?VExEbFlDL3RZNHUvaEhudWFFTUdtL3V3QWJrbm8vRmFiSUNLbzFVdjRJWlNr?=
 =?utf-8?B?dnRLM0FQcytVWXordityaWwzbGpBTHhPR3loS3Qvbk9ZOTdXcUFzNzhuRW5C?=
 =?utf-8?B?Vkt3WlpoLzQ2R1lPQno5amxEbytXaUIyK3pRWTBYaUlQMVJBR2xkWVFhVWkx?=
 =?utf-8?B?Ukw1YVFwa2FScDRscE15R3E3QzVEWlNFZjBFZS9XWkoxMkgvVUZwSy9Kd2I5?=
 =?utf-8?B?cnBLYkdMRFdtOWcwTlNZRHVaL3ppSlM4dTZCWXBFNUFLRG4rK3g2RVpEZkJ4?=
 =?utf-8?B?SkR6ZEtiWmtyNW1NMFBVd2oxZWhsaVNLYlZqZ0hUeGViSWhhN05tU2J1VDF3?=
 =?utf-8?B?WUQvaHA1MkdHUUl3UzBkMWxLVTBSUGk0QnNtaHdLYlFEWVNOekNhamJWcGdv?=
 =?utf-8?B?YkVNUjJiTnV0UkJMR3o4L2ZkRXR0bFZnQ2xjNnBVdkFkMHhqcWdSZGZkR0x0?=
 =?utf-8?B?UjRPaXBKMkltc2UwTC9BRTVPMXZXN3lKWW5uUEtobXNDbGNjeG1pY0l5blZq?=
 =?utf-8?B?OXh3cFA0Y2RnY2JQRlY4NHdjenlsdTFjbVpkNllvbzZUNDdtWWtIVVJoYWVi?=
 =?utf-8?B?cXM5dThZVFBIYlJoenpOSEdUNU5nZnFhRzdQdnNCdzE0eE4waHBMVmpkZTl4?=
 =?utf-8?B?aDI0QUd5QW85SGp6ODY3bUV1VVpwSkkrQzhOTlVHOVpScDlKV1l4c25pM1Nv?=
 =?utf-8?B?MThSRGlZYU1jVkJpVHRzQldoSjhCWGkzdVhSVjcrcnQ2UFlEN2xsdkpMT3Nj?=
 =?utf-8?B?VSs5dHM1WjNyTzF3eHl6QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6260042-050b-4e93-df53-08d929e99d7a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:22:39.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diUoZUpNKusuRDNVZ6Omz05GNyMvo+mt2NhnIzX1rjw04KBQfUPbDhs3eKHRTW0OZd1D6SI2XXhLGVb/IKdQaQjF19rG53SAMMX6/0mrGq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070131
X-Proofpoint-GUID: 1NRxo0lqGjhsQvOoeXKyu2YjpG20dqjt
X-Proofpoint-ORIG-GUID: 1NRxo0lqGjhsQvOoeXKyu2YjpG20dqjt
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/3/21 2:14 PM, Jing Zhang wrote:
> Put all generic statistics in a separate structure to ease
> statistics handling for the incoming new statistics API.
>
> No functional change intended.
>
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>   arch/arm64/include/asm/kvm_host.h   |  9 ++-------
>   arch/arm64/kvm/guest.c              | 12 ++++++------
>   arch/mips/include/asm/kvm_host.h    |  9 ++-------
>   arch/mips/kvm/mips.c                | 12 ++++++------
>   arch/powerpc/include/asm/kvm_host.h |  9 ++-------
>   arch/powerpc/kvm/book3s.c           | 12 ++++++------
>   arch/powerpc/kvm/book3s_hv.c        | 12 ++++++------
>   arch/powerpc/kvm/book3s_pr.c        |  2 +-
>   arch/powerpc/kvm/book3s_pr_papr.c   |  2 +-
>   arch/powerpc/kvm/booke.c            | 14 +++++++-------
>   arch/s390/include/asm/kvm_host.h    |  9 ++-------
>   arch/s390/kvm/kvm-s390.c            | 12 ++++++------
>   arch/x86/include/asm/kvm_host.h     |  9 ++-------
>   arch/x86/kvm/x86.c                  | 14 +++++++-------
>   include/linux/kvm_host.h            |  9 +++++++--
>   include/linux/kvm_types.h           | 12 ++++++++++++
>   virt/kvm/kvm_main.c                 | 14 +++++++-------
>   17 files changed, 82 insertions(+), 90 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 7cd7d5c8c4bc..5a2c82f63baa 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -556,16 +556,11 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
>   }
>   
>   struct kvm_vm_stat {
> -	ulong remote_tlb_flush;
> +	struct kvm_vm_stat_generic generic;
>   };
>   
>   struct kvm_vcpu_stat {
> -	u64 halt_successful_poll;
> -	u64 halt_attempted_poll;
> -	u64 halt_poll_success_ns;
> -	u64 halt_poll_fail_ns;
> -	u64 halt_poll_invalid;
> -	u64 halt_wakeup;
> +	struct kvm_vcpu_stat_generic generic;
>   	u64 hvc_exit_stat;
>   	u64 wfe_exit_stat;
>   	u64 wfi_exit_stat;
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 5cb4a1cd5603..4962331d01e6 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -29,18 +29,18 @@
>   #include "trace.h"
>   
>   struct kvm_stats_debugfs_item debugfs_entries[] = {
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
>   	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
>   	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
>   	VCPU_STAT("mmio_exit_user", mmio_exit_user),
>   	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
>   	VCPU_STAT("exits", exits),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
>   	{ NULL }
>   };
>   
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index fca4547d580f..696f6b009377 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -109,10 +109,11 @@ static inline bool kvm_is_error_hva(unsigned long addr)
>   }
>   
>   struct kvm_vm_stat {
> -	ulong remote_tlb_flush;
> +	struct kvm_vm_stat_generic generic;
>   };
>   
>   struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_generic generic;
>   	u64 wait_exits;
>   	u64 cache_exits;
>   	u64 signal_exits;
> @@ -142,12 +143,6 @@ struct kvm_vcpu_stat {
>   #ifdef CONFIG_CPU_LOONGSON64
>   	u64 vz_cpucfg_exits;
>   #endif
> -	u64 halt_successful_poll;
> -	u64 halt_attempted_poll;
> -	u64 halt_poll_success_ns;
> -	u64 halt_poll_fail_ns;
> -	u64 halt_poll_invalid;
> -	u64 halt_wakeup;
>   };
>   
>   struct kvm_arch_memory_slot {
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 4d4af97dcc88..ff205b35719b 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -68,12 +68,12 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   #ifdef CONFIG_CPU_LOONGSON64
>   	VCPU_STAT("vz_cpucfg", vz_cpucfg_exits),
>   #endif
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
>   	{NULL}
>   };
>   
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 1e83359f286b..6e41064858a1 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -80,12 +80,13 @@ struct kvmppc_book3s_shadow_vcpu;
>   struct kvm_nested_guest;
>   
>   struct kvm_vm_stat {
> -	ulong remote_tlb_flush;
> +	struct kvm_vm_stat_generic generic;
>   	ulong num_2M_pages;
>   	ulong num_1G_pages;
>   };
>   
>   struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_generic generic;
>   	u64 sum_exits;
>   	u64 mmio_exits;
>   	u64 signal_exits;
> @@ -101,14 +102,8 @@ struct kvm_vcpu_stat {
>   	u64 emulated_inst_exits;
>   	u64 dec_exits;
>   	u64 ext_intr_exits;
> -	u64 halt_poll_success_ns;
> -	u64 halt_poll_fail_ns;
>   	u64 halt_wait_ns;
> -	u64 halt_successful_poll;
> -	u64 halt_attempted_poll;
>   	u64 halt_successful_wait;
> -	u64 halt_poll_invalid;
> -	u64 halt_wakeup;
>   	u64 dbell_exits;
>   	u64 gdbell_exits;
>   	u64 ld;
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 2b691f4d1f26..92cdb4175945 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -47,14 +47,14 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("dec", dec_exits),
>   	VCPU_STAT("ext_intr", ext_intr_exits),
>   	VCPU_STAT("queue_intr", queue_intr),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
>   	VCPU_STAT("halt_wait_ns", halt_wait_ns),
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
>   	VCPU_STAT("halt_successful_wait", halt_successful_wait),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("pf_storage", pf_storage),
>   	VCPU_STAT("sp_storage", sp_storage),
>   	VCPU_STAT("pf_instruc", pf_instruc),
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 28a80d240b76..2a1cf29ba3fd 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -236,7 +236,7 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
>   
>   	waitp = kvm_arch_vcpu_get_wait(vcpu);
>   	if (rcuwait_wake_up(waitp))
> -		++vcpu->stat.halt_wakeup;
> +		++vcpu->stat.generic.halt_wakeup;
>   
>   	cpu = READ_ONCE(vcpu->arch.thread_cpu);
>   	if (cpu >= 0 && kvmppc_ipi_thread(cpu))
> @@ -3925,7 +3925,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   	cur = start_poll = ktime_get();
>   	if (vc->halt_poll_ns) {
>   		ktime_t stop = ktime_add_ns(start_poll, vc->halt_poll_ns);
> -		++vc->runner->stat.halt_attempted_poll;
> +		++vc->runner->stat.generic.halt_attempted_poll;
>   
>   		vc->vcore_state = VCORE_POLLING;
>   		spin_unlock(&vc->lock);
> @@ -3942,7 +3942,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   		vc->vcore_state = VCORE_INACTIVE;
>   
>   		if (!do_sleep) {
> -			++vc->runner->stat.halt_successful_poll;
> +			++vc->runner->stat.generic.halt_successful_poll;
>   			goto out;
>   		}
>   	}
> @@ -3954,7 +3954,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   		do_sleep = 0;
>   		/* If we polled, count this as a successful poll */
>   		if (vc->halt_poll_ns)
> -			++vc->runner->stat.halt_successful_poll;
> +			++vc->runner->stat.generic.halt_successful_poll;
>   		goto out;
>   	}
>   
> @@ -3981,13 +3981,13 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   			ktime_to_ns(cur) - ktime_to_ns(start_wait);
>   		/* Attribute failed poll time */
>   		if (vc->halt_poll_ns)
> -			vc->runner->stat.halt_poll_fail_ns +=
> +			vc->runner->stat.generic.halt_poll_fail_ns +=
>   				ktime_to_ns(start_wait) -
>   				ktime_to_ns(start_poll);
>   	} else {
>   		/* Attribute successful poll time */
>   		if (vc->halt_poll_ns)
> -			vc->runner->stat.halt_poll_success_ns +=
> +			vc->runner->stat.generic.halt_poll_success_ns +=
>   				ktime_to_ns(cur) -
>   				ktime_to_ns(start_poll);
>   	}
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index d7733b07f489..71bcb0140461 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -493,7 +493,7 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
>   		if (!vcpu->arch.pending_exceptions) {
>   			kvm_vcpu_block(vcpu);
>   			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> -			vcpu->stat.halt_wakeup++;
> +			vcpu->stat.generic.halt_wakeup++;
>   
>   			/* Unset POW bit after we woke up */
>   			msr &= ~MSR_POW;
> diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
> index 031c8015864a..ac14239f3424 100644
> --- a/arch/powerpc/kvm/book3s_pr_papr.c
> +++ b/arch/powerpc/kvm/book3s_pr_papr.c
> @@ -378,7 +378,7 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
>   		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
>   		kvm_vcpu_block(vcpu);
>   		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> -		vcpu->stat.halt_wakeup++;
> +		vcpu->stat.generic.halt_wakeup++;
>   		return EMULATE_DONE;
>   	case H_LOGICAL_CI_LOAD:
>   		return kvmppc_h_pr_logical_ci_load(vcpu);
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 7d5fe43f85c4..80d3b39aa7ac 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -49,15 +49,15 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("inst_emu", emulated_inst_exits),
>   	VCPU_STAT("dec", dec_exits),
>   	VCPU_STAT("ext_intr", ext_intr_exits),
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("doorbell", dbell_exits),
>   	VCPU_STAT("guest doorbell", gdbell_exits),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> -	VM_STAT("remote_tlb_flush", remote_tlb_flush),
> +	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VM_STAT_GENERIC("remote_tlb_flush", remote_tlb_flush),
>   	{ NULL }
>   };
>   
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8925f3969478..9b4473f76e56 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -361,6 +361,7 @@ struct sie_page {
>   };
>   
>   struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_generic generic;
>   	u64 exit_userspace;
>   	u64 exit_null;
>   	u64 exit_external_request;
> @@ -370,13 +371,7 @@ struct kvm_vcpu_stat {
>   	u64 exit_validity;
>   	u64 exit_instruction;
>   	u64 exit_pei;
> -	u64 halt_successful_poll;
> -	u64 halt_attempted_poll;
> -	u64 halt_poll_invalid;
>   	u64 halt_no_poll_steal;
> -	u64 halt_wakeup;
> -	u64 halt_poll_success_ns;
> -	u64 halt_poll_fail_ns;
>   	u64 instruction_lctl;
>   	u64 instruction_lctlg;
>   	u64 instruction_stctl;
> @@ -755,12 +750,12 @@ struct kvm_vcpu_arch {
>   };
>   
>   struct kvm_vm_stat {
> +	struct kvm_vm_stat_generic generic;
>   	u64 inject_io;
>   	u64 inject_float_mchk;
>   	u64 inject_pfault_done;
>   	u64 inject_service_signal;
>   	u64 inject_virtio;
> -	u64 remote_tlb_flush;
>   };
>   
>   struct kvm_arch_memory_slot {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1296fc10f80c..e8bc7cd06794 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -72,13 +72,13 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("exit_program_interruption", exit_program_interruption),
>   	VCPU_STAT("exit_instr_and_program_int", exit_instr_and_program),
>   	VCPU_STAT("exit_operation_exception", exit_operation_exception),
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
>   	VCPU_STAT("halt_no_poll_steal", halt_no_poll_steal),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
>   	VCPU_STAT("instruction_lctlg", instruction_lctlg),
>   	VCPU_STAT("instruction_lctl", instruction_lctl),
>   	VCPU_STAT("instruction_stctl", instruction_stctl),
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 55efbacfc244..db8eb3dead7e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1127,6 +1127,7 @@ struct kvm_arch {
>   };
>   
>   struct kvm_vm_stat {
> +	struct kvm_vm_stat_generic generic;
>   	ulong mmu_shadow_zapped;
>   	ulong mmu_pte_write;
>   	ulong mmu_pde_zapped;
> @@ -1134,13 +1135,13 @@ struct kvm_vm_stat {
>   	ulong mmu_recycled;
>   	ulong mmu_cache_miss;
>   	ulong mmu_unsync;
> -	ulong remote_tlb_flush;
>   	ulong lpages;
>   	ulong nx_lpage_splits;
>   	ulong max_mmu_page_hash_collisions;
>   };
>   
>   struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_generic generic;
>   	u64 pf_fixed;
>   	u64 pf_guest;
>   	u64 tlb_flush;
> @@ -1154,10 +1155,6 @@ struct kvm_vcpu_stat {
>   	u64 nmi_window_exits;
>   	u64 l1d_flush;
>   	u64 halt_exits;
> -	u64 halt_successful_poll;
> -	u64 halt_attempted_poll;
> -	u64 halt_poll_invalid;
> -	u64 halt_wakeup;
>   	u64 request_irq_exits;
>   	u64 irq_exits;
>   	u64 host_state_reload;
> @@ -1168,8 +1165,6 @@ struct kvm_vcpu_stat {
>   	u64 irq_injections;
>   	u64 nmi_injections;
>   	u64 req_event;
> -	u64 halt_poll_success_ns;
> -	u64 halt_poll_fail_ns;
>   	u64 nested_run;
>   	u64 directed_yield_attempted;
>   	u64 directed_yield_successful;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9b6bca616929..96d10253218a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -226,10 +226,10 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("irq_window", irq_window_exits),
>   	VCPU_STAT("nmi_window", nmi_window_exits),
>   	VCPU_STAT("halt_exits", halt_exits),
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("hypercalls", hypercalls),
>   	VCPU_STAT("request_irq", request_irq_exits),
>   	VCPU_STAT("irq_exits", irq_exits),
> @@ -241,8 +241,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("nmi_injections", nmi_injections),
>   	VCPU_STAT("req_event", req_event),
>   	VCPU_STAT("l1d_flush", l1d_flush),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
>   	VCPU_STAT("nested_run", nested_run),
>   	VCPU_STAT("directed_yield_attempted", directed_yield_attempted),
>   	VCPU_STAT("directed_yield_successful", directed_yield_successful),
> @@ -253,7 +253,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VM_STAT("mmu_recycled", mmu_recycled),
>   	VM_STAT("mmu_cache_miss", mmu_cache_miss),
>   	VM_STAT("mmu_unsync", mmu_unsync),
> -	VM_STAT("remote_tlb_flush", remote_tlb_flush),
> +	VM_STAT_GENERIC("remote_tlb_flush", remote_tlb_flush),
>   	VM_STAT("largepages", lpages, .mode = 0444),
>   	VM_STAT("nx_largepages_splitted", nx_lpage_splits, .mode = 0444),
>   	VM_STAT("max_mmu_page_hash_collisions", max_mmu_page_hash_collisions),
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 2f34487e21f2..1870fa928762 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1243,10 +1243,15 @@ struct kvm_stats_debugfs_item {
>   #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
>   	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
>   
> -#define VM_STAT(n, x, ...) 							\
> +#define VM_STAT(n, x, ...)						       \
>   	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
> -#define VCPU_STAT(n, x, ...)							\
> +#define VCPU_STAT(n, x, ...)						       \
>   	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
> +#define VM_STAT_GENERIC(n, x, ...)					       \
> +	{ n, offsetof(struct kvm, stat.generic.x), KVM_STAT_VM, ## __VA_ARGS__ }
> +#define VCPU_STAT_GENERIC(n, x, ...)					       \
> +	{ n, offsetof(struct kvm_vcpu, stat.generic.x),			       \
> +	  KVM_STAT_VCPU, ## __VA_ARGS__ }
>   
>   extern struct kvm_stats_debugfs_item debugfs_entries[];
>   extern struct dentry *kvm_debugfs_dir;
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index a7580f69dda0..7c39489f9953 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -76,5 +76,17 @@ struct kvm_mmu_memory_cache {
>   };
>   #endif
>   
> +struct kvm_vm_stat_generic {
> +	ulong remote_tlb_flush;
> +};
> +
> +struct kvm_vcpu_stat_generic {
> +	u64 halt_successful_poll;
> +	u64 halt_attempted_poll;
> +	u64 halt_poll_invalid;
> +	u64 halt_wakeup;
> +	u64 halt_poll_success_ns;
> +	u64 halt_poll_fail_ns;
> +};
>   
>   #endif /* __KVM_TYPES_H__ */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6b4feb92dc79..f6ad5b080994 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -330,7 +330,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>   	 */
>   	if (!kvm_arch_flush_remote_tlb(kvm)
>   	    || kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
> -		++kvm->stat.remote_tlb_flush;
> +		++kvm->stat.generic.remote_tlb_flush;
>   	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
>   }
>   EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
> @@ -2940,9 +2940,9 @@ static inline void
>   update_halt_poll_stats(struct kvm_vcpu *vcpu, u64 poll_ns, bool waited)
>   {
>   	if (waited)
> -		vcpu->stat.halt_poll_fail_ns += poll_ns;
> +		vcpu->stat.generic.halt_poll_fail_ns += poll_ns;
>   	else
> -		vcpu->stat.halt_poll_success_ns += poll_ns;
> +		vcpu->stat.generic.halt_poll_success_ns += poll_ns;
>   }
>   
>   /*
> @@ -2960,16 +2960,16 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>   	if (vcpu->halt_poll_ns && !kvm_arch_no_poll(vcpu)) {
>   		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
>   
> -		++vcpu->stat.halt_attempted_poll;
> +		++vcpu->stat.generic.halt_attempted_poll;
>   		do {
>   			/*
>   			 * This sets KVM_REQ_UNHALT if an interrupt
>   			 * arrives.
>   			 */
>   			if (kvm_vcpu_check_block(vcpu) < 0) {
> -				++vcpu->stat.halt_successful_poll;
> +				++vcpu->stat.generic.halt_successful_poll;
>   				if (!vcpu_valid_wakeup(vcpu))
> -					++vcpu->stat.halt_poll_invalid;
> +					++vcpu->stat.generic.halt_poll_invalid;
>   				goto out;
>   			}
>   			poll_end = cur = ktime_get();
> @@ -3027,7 +3027,7 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>   	waitp = kvm_arch_vcpu_get_wait(vcpu);
>   	if (rcuwait_wake_up(waitp)) {
>   		WRITE_ONCE(vcpu->ready, true);
> -		++vcpu->stat.halt_wakeup;
> +		++vcpu->stat.generic.halt_wakeup;
>   		return true;
>   	}
>   

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

