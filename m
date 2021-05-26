Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FC3922D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhEZWgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 18:36:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48564 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233207AbhEZWgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 18:36:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QMWwc0017884;
        Wed, 26 May 2021 22:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cR4e0bRppJdZL4at9IK22zQrIkPrnAXuY08J53Isy6k=;
 b=hP1aMjEErUI40/9+tAJOL4WQW2ILA6euodHc7yJ8Bos4hcYesO4qNSc781O1csmN1lBU
 TyGO4twruUOTfRcA8PBY5fAJoag5m7RO+gmcNrhN7vH9wqn/enFH0zgNZBlgcNOyiTll
 Fx9lIsTUW/vUWrEhibc/tHVrvVl2oV12V0JdIg1Ps4zkxdlUYk2l4vJ+RZA+l47x1k/Z
 nUlyG7QWESX98YvBVSjZru8+oAzkrPuuSbXICO8dFB5RQt9JaFEyYyPNxGY9N/8tgp6J
 z7rXiizxxheUa2bDFXj6rBBsazxjvF8KE72JOwpb0SwwYmzWGEg01L7yMkinBjhWBrGw wg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38sppd0604-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 22:34:12 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14QMYBMI151263;
        Wed, 26 May 2021 22:34:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 38pr0d39fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 22:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0yFhXw4fdxF3r8LhC/zGRN3G4Nc8gtSctInFukiJ2UbXlD56Ygvs5Yk6byrcM2Vk+ZOG1EcgefjUocKVhacxauZ6qRnbvb6xC4/85UKpLEJHzWuBsjHQGAG9PrVqZYFm7B8KJhbEFHU6m36QxDythxzUUBHhNCThY/orlWMKMM2oUAEfhjZsA1fPLesBQoQJespKAIMKDnJ1b2MNrDDqCFkxu11iMwv4Q7NfIVuSGu168D/x7ponmmlvLy92l0BRoPZdEQT+6SKcLbdKrJ70+OiDHZ2HbTjh0wPjRat6031f4s67uNMHGTPwhewHabCROyzLdekJN7NneMaYIEzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR4e0bRppJdZL4at9IK22zQrIkPrnAXuY08J53Isy6k=;
 b=gPclRChWStp2+YwbN1WLGdOOiiBZBJquLsKOEq9KLIiC4ROz94a95s3vObaRM/9HnAeFVzeVLdu0A0CI3c6+UTCzk6ic2dcF+vOgY3y81ww6oHdrh9Bm12tuVNplPINnBQzfUGJ4Qf67TsaB/toubWeXIZgE3UV0mZPIlY9vIHhl1CvNVf7kSYEhG7CgzAlzHYt/V0XjIgq/baA06U47D+MtOZMpM7/08k8JmYtzTff72fblu0UepWNCfq0HMxyXZMu5VRAEGKFnlKR8aKvYBmFFOzzgnTOLO8PnMXWlD7SpLGlOOMarkww/JjomKMDmJ0eHI9P5Nlzk44DTzZVvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR4e0bRppJdZL4at9IK22zQrIkPrnAXuY08J53Isy6k=;
 b=o5bMmhX6skNBgg/nWGluTHBdGWu1pwEr++Tt/5bQCYOEhobyVogGWpV58oyDwe+fwB6p5vgAjNmttNB5aT8eRJ8EUBLtmj9Sss1+vx5k0L8Yc793ZNAVjgpG6QnwumKgHtjynN+/23JJmPOIYaHanBv2j5W3FDmnTmZzMjxEjx0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 22:34:08 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107%7]) with mapi id 15.20.4173.022; Wed, 26 May 2021
 22:34:08 +0000
Subject: Re: [PATCH v6 4/4] KVM: selftests: Add selftest for KVM statistics
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
References: <20210524151828.4113777-1-jingzhangos@google.com>
 <20210524151828.4113777-5-jingzhangos@google.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <bad9e2cb-0e23-f2ea-054f-23556dbfd7e1@oracle.com>
Date:   Wed, 26 May 2021 15:34:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210524151828.4113777-5-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SA0PR11CA0145.namprd11.prod.outlook.com
 (2603:10b6:806:131::30) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SA0PR11CA0145.namprd11.prod.outlook.com (2603:10b6:806:131::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 22:34:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589fa2ac-9e23-4df0-d2a7-08d920965fea
X-MS-TrafficTypeDiagnostic: SA2PR10MB4538:
X-Microsoft-Antispam-PRVS: <SA2PR10MB45381A61C10837958E482AD381249@SA2PR10MB4538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQRSoR+tT4mEv9U10Zw/lY9Wal8ZqCv5Wg2Y2gdn45o4nRQYeYdza3ACvX38o8mY1oCb69DUWLQr7+WpKJWIC9R3wKyVk5RCegiTmG74XiriqHT6nrNFa0d+uQp5dA/489Ko6mxYnW1lXezQsE+yfrxqRzBixI63pF9LiPJARmR325mfaLxgBgCXJL780kL+99PEhK6sAa2h812kqDw4wAduf7jVegQ3oNj/fg4CTZqyp0oZg83JXBuTTpiMfzZ2DjSPhNEROpEYWh16UXK5nD5B1AR86OqpUexc6wLuCqKI9eRuLwkKuHeR4db+ZAH6Gy0xjLOaRpxCHb0M6PCFOtb8FgBv5weBdXIABWN8/zm3U5KxH1VSpNn/yqJZyvXNwv96jSEmA6JzgYcencCjLcPmBrVRMZOh7QKNxYArQId8ytlHlKlqWGPKkCuELsnh6byiUDWP/qKxcl+d0QBBChP40Q7K2ZmJpTtLNHwEirI0sNcL84zanqO3YgkHofwsGPaAoIIbOAQG+xmcwgs7e62PyIRyepydVKhXFAyR4+1oMkbnwi0qNUpJijOdncX7Ls2FcySaX3qZTmIdJfxvOVMsAi701tXOzM7Nj4WhixbOkDOldZr9BE4n7H+jbzjNkh6QSL6+3StYPQ++IHxh7EkZCr5AcIgcmsVlWSj9XRWdsnABYmReaJJRVJ7dVElCcJDrQFnKkaqoZCofISrrAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(921005)(66476007)(66946007)(66556008)(8936002)(8676002)(6506007)(31696002)(86362001)(30864003)(5660300002)(38100700002)(110136005)(316002)(478600001)(7416002)(7406005)(31686004)(44832011)(83380400001)(6512007)(186003)(53546011)(36756003)(2616005)(6486002)(16526019)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eklUOWNkUk1aYU1VQ1ZUamo3SFljVzhQa01KWGFyak5iVU9raHlDdW5PcEo4?=
 =?utf-8?B?Q0xEeHVCQ0ZURWN6emFYdFVuN0VyV1VzQVAyNm1qRkRsSTQ2QWtFR2JROUZT?=
 =?utf-8?B?MXMrSkU4VFAwVUtIUTFqTksxUEttRmt1VFZiTXdUcWF4UEo2cVE5U3M5dkxS?=
 =?utf-8?B?VTZZN3hQTE9ZcWFCb1ZwL2tKc1hGV09yQWNaV2NVUG11Wm9Ockp6bG1iN0FK?=
 =?utf-8?B?TVY0YVd6eFBxRjE2TGpabDd0ZnJVKzZTN3l0OExDb1h4bWtmOHVTNVZkOVE2?=
 =?utf-8?B?bFNHdlZJbkhRcFFpZjVoaXlDc0xwREdNQU8vZk5hRnNnMUw2UDFRTVZSTVNl?=
 =?utf-8?B?NE9iUEtydlJqRkY5bXpnWEN4em0xZ0RveEFIZ2lCRTd6d2c4U1VDZG1EczBj?=
 =?utf-8?B?aGZ2RGRlOW9JaXE3L3hJQWFqVm11SkVnckM2dW1SUDYwVmRSaDd2eVBVRm1x?=
 =?utf-8?B?QW9SZjlIWnFybndsN081ekV1MnVxWVpHcGRxTWxDbVJQakxseHk0T0ErRmhB?=
 =?utf-8?B?eXJVN1orMFRJQ01jb0cyUFhpTy9iZ2NPOG9zY2hFZ0pRNUxwWGhuNjZvaWJJ?=
 =?utf-8?B?WUVrd2RYYUNDTmx1M2dmUTEwM1JhanMxTTZxRUhtaFZQdzBHd1BQb2pBV2RI?=
 =?utf-8?B?NFp3NWpaYWk4RkhGMW02VDlHdmlyQkJodkF6U3YwenF5KzFJNm1hemNjV3ZQ?=
 =?utf-8?B?TWZxbXZrS3UxcGszQmpoRTZINmdYa1J3Q3IvM1dyZ0h3WVJkRnZzVXh6aVpM?=
 =?utf-8?B?UzlEYzROSEQ5NmpsOW41ckFhVkx2NVBmSGFBU2dVVnljMFNFLzZuSGt3L2cy?=
 =?utf-8?B?VTNMR1RQK1BEcS9mSVRxa3RBNmVHa0NmTUFSZGVqV0VPdmdNQm9FS29ENlpp?=
 =?utf-8?B?UjNLdW9iTEZFN2ZrNmwvUnFoODIzVzArclJqVzgzZDB2ajNSa1dqekFrb1hV?=
 =?utf-8?B?OEh0NzBJZzRMdG1KSVpyU1BDeDhvc253TzluZko5Rm15QjgxSGNrV3cxK3Mx?=
 =?utf-8?B?V2NGbEp4a3o1S0VuN1A4bEtiem9aYXQyU1YvSHlzVm93ODluNW1nYVh4Mmlt?=
 =?utf-8?B?b3J6dWx1VGJ1cFBCaTFIUU5SVXEwQVMxcFlXakNJZzdrQUhzVFg2NTBMbE5K?=
 =?utf-8?B?Y3o5MWsvclJad3IyS1cxV3R2eEcrVGpUbW40bXBCS1BoVHFkUHBKdmpjZDM1?=
 =?utf-8?B?TzRyRTRSOFFsRGVieXVwOVUxKzU3cFlGb0tXS3ZuKzlOc0cwN0tyY3laR1FB?=
 =?utf-8?B?L3luZlkzRUFEMTRmTWxadVBid2pQVkV6Ylh2aWVoM3lQZk1mbmRPa2VyQ0w4?=
 =?utf-8?B?NVlaSmdPR2tXRUZMU0ZuUXJ0enpxUE1BWDNyU2I2S1dxTWRobFIyWks5RFly?=
 =?utf-8?B?NEVORUdMZUNORzluUmVvUjk5Wlc1NmQ2czByODQ2cWU0Qit4akVNbm9jbFZX?=
 =?utf-8?B?SXczWGRWNm1MeXFRMlpUVXgrcjhaOTNYM2k5cmh4MnJpdHFmc3Y4dzFNZFFS?=
 =?utf-8?B?SGt3MkEyYUdralljVWsvZ1ZEaUswajVVNVZ3c3VMSFR0ZzNKOWJ2ZmZEaGpI?=
 =?utf-8?B?SE5icVV5VWI4c0ZtL2JzMVE5TTJSS2NTYTk3RTQ4R2pqR2tDSEc1TndwSmUy?=
 =?utf-8?B?YXJYeGZ2TTNiYzhTWU84OVJFc1BkUUxJb3RSRGdYZ1RhOHEwa2tiemlLLzNq?=
 =?utf-8?B?UXVQbThwU1pqb2FicDI0SjQ2UVdVRjdReU90Q3loQ2gyc3RYL2sxZldzNHBP?=
 =?utf-8?B?SHZ2OU9FbkNnR2Rjc2pteC8zeUZSQzQydFFMK3dGUjlGZXg5dUJnTlU5Rmd3?=
 =?utf-8?B?VHZnT2ZrVzhadVcraUhkUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589fa2ac-9e23-4df0-d2a7-08d920965fea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 22:34:08.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLny3sY1T3j9Aw0nNwwrl8u09yMEPVtyt3qcDqONX5DrxQBbLutF8Wtey6XGKICI4TgZLFigIl0nO8XopBL7iipY+T1cButdoQ40pneQ1fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260151
X-Proofpoint-GUID: b-4ul4KQYoNSHrvUbQ3nQnklMTcBMSSC
X-Proofpoint-ORIG-GUID: b-4ul4KQYoNSHrvUbQ3nQnklMTcBMSSC
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/24/21 8:18 AM, Jing Zhang wrote:
> Add selftest to check KVM stats descriptors validity.
>
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   3 +
>   .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>   .../selftests/kvm/kvm_bin_form_stats.c        | 216 ++++++++++++++++++
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
>   5 files changed, 235 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c


We should probably follow the naming convention for the majority of the 
files in the kvm directory and name it kvm_stats_read_test.c or 
kvm_stats_test.c or something like that.

>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index bd83158e0e0b..35796667c944 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -43,3 +43,4 @@
>   /memslot_modification_stress_test
>   /set_memory_region_test
>   /steal_time
> +/kvm_bin_form_stats
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index e439d027939d..2984c86c848a 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -76,6 +76,7 @@ TEST_GEN_PROGS_x86_64 += kvm_page_table_test
>   TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
>   TEST_GEN_PROGS_x86_64 += set_memory_region_test
>   TEST_GEN_PROGS_x86_64 += steal_time
> +TEST_GEN_PROGS_x86_64 += kvm_bin_form_stats
>   
>   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
>   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
> @@ -87,6 +88,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>   TEST_GEN_PROGS_aarch64 += kvm_page_table_test
>   TEST_GEN_PROGS_aarch64 += set_memory_region_test
>   TEST_GEN_PROGS_aarch64 += steal_time
> +TEST_GEN_PROGS_aarch64 += kvm_bin_form_stats
>   
>   TEST_GEN_PROGS_s390x = s390x/memop
>   TEST_GEN_PROGS_s390x += s390x/resets
> @@ -96,6 +98,7 @@ TEST_GEN_PROGS_s390x += dirty_log_test
>   TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
>   TEST_GEN_PROGS_s390x += kvm_page_table_test
>   TEST_GEN_PROGS_s390x += set_memory_region_test
> +TEST_GEN_PROGS_s390x += kvm_bin_form_stats
>   
>   TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
>   LIBKVM += $(LIBKVM_$(UNAME_M))
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index a8f022794ce3..ee01a67022d9 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -387,4 +387,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
>   #define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
>   	__GUEST_ASSERT((_condition), 4, (arg1), (arg2), (arg3), (arg4))
>   
> +int vm_get_statsfd(struct kvm_vm *vm);
> +int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid);
> +
>   #endif /* SELFTEST_KVM_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/kvm_bin_form_stats.c b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
> new file mode 100644
> index 000000000000..09e12c5838af
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * kvm_bin_form_stats
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
> +int stats_test(int stats_fd, int size_stat)


The return value is not used by the caller. Perhaps make it a void ?

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
> +	if (header.count == 0)


Does this need a message as to why count is zero ?

> +		return 0;
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
> +	return 0;
> +}
> +
> +
> +int vm_stats_test(struct kvm_vm *vm)
> +{
> +	int stats_fd;
> +	struct kvm_vm_stats_data *stats_data;
> +
> +	/* Get fd for VM stats */
> +	stats_fd = vm_get_statsfd(vm);
> +	TEST_ASSERT(stats_fd >= 0, "Get VM stats fd");
> +
> +	stats_test(stats_fd, sizeof(stats_data->value[0]));
> +	close(stats_fd);
> +
> +	return 0;
> +}
> +
> +int vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
> +{
> +	int stats_fd;
> +	struct kvm_vcpu_stats_data *stats_data;
> +
> +	/* Get fd for VCPU stats */
> +	stats_fd = vcpu_get_statsfd(vm, vcpu_id);
> +	TEST_ASSERT(stats_fd >= 0, "Get VCPU stats fd");
> +
> +	stats_test(stats_fd, sizeof(stats_data->value[0]));
> +	close(stats_fd);
> +
> +	return 0;
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


Does it make sense to add one more test case here to test this fd 
interface on a VM or on a VCPU that has been deleted ? For example, how 
does this fd interface behave if we delete the 4th VM and the 4th VCPU 
in the 3rd VM ?

> +	for (i = 0; i < max_vm; ++i)
> +		kvm_vm_free(vms[i]);
> +	free(vms);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index fc83f6c5902d..d9e0b2c8b906 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2090,3 +2090,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
>   	n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
>   	return vm_adjust_num_guest_pages(mode, n);
>   }
> +
> +int vm_get_statsfd(struct kvm_vm *vm)
> +{
> +	return ioctl(vm->fd, KVM_STATS_GETFD, NULL);
> +}
> +
> +int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid)
> +{
> +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +
> +	return ioctl(vcpu->fd, KVM_STATS_GETFD, NULL);
> +}


Do we need separate functions if they are called just once ?  Or perhaps 
have a single function for the ioctl call, like ?

      int get_stats_fd(int fd, int type)

      {

             return ioctl(fd, type, NULL);

      }

