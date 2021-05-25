Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DFE3909E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 May 2021 21:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhEYTvG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 15:51:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62382 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231442AbhEYTvF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 15:51:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PJgUGt028557;
        Tue, 25 May 2021 19:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=05I52TBdZw09CCTc0gdWiw98NfRn5otRT24mhBuimUI=;
 b=Bl28RElTWhtByrRmF1rgCtzg5/otu22TQwD6C/y+AxoypItCBHR37mkE+9BITV7EtFe+
 zn/BprLyS2d5wzV0z6poUQWjbXdk22/HkxxTCRq/8uqPI24yvBLXK4dPsAWEeXrP3yO3
 q9Tto4xZcf1zecmJV63uRxHJYK81mS17Td/tL5EBAWk8ID1MzctCuCETUuxMiubG+Swj
 oGrBM8CRbXwwyDphRGILZ3hie7fY1K+uSo68cvGSgZbOsUf2dz9KjblWAr8vu9jOU9tc
 jSPqxEbHqzR6glBJMEMS4d0OisKvYsGrWIAY4rszvXb5OLNsUr5UsrKS8JS+w8MyIFN2 kg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38r1bdrsfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:49:12 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14PJmLmE090466;
        Tue, 25 May 2021 19:49:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 38pq2uhhsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzFQ1WxN2klUqOZWIPdvJGWJ6cRWJuEedmJF6LkNFyeoZkRYD57UTHA82WitTc0iQgWbrIrvmuLYTJubpnZGQqYNydAcCnjDprbevbzLiN5G+L6xGw2DoeKT1U4HFX1k6XriyMoOj2OOiV31qCoMLZAfFnvVefsPByWo0uy60jQpLdGC0y2NzXteDgYFAo6UwOq8UZeVXri3baqsqBr9sifZMCXQXZdNV5jEFiU4uEVYvj2FyR4EX/c0S8ZupWCVQJ+pQsvA4Rz6j3Sj/qs60myuGPu/bBzZnBPOaOvFsxGQzQsNdITijeWg1K9wIfA1iUzZzobY+q0yz2f79Jjh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05I52TBdZw09CCTc0gdWiw98NfRn5otRT24mhBuimUI=;
 b=Q/ZTU45Bq9K2rq34hxximEeQ5rSnHbixxL2y0k0HKogPqT48ydA/zdVRjFJ6tc87iyaqU6UrxpN3Xbr3pSQe7Opfa9B3ksXQlUVUzEVQMc/eAFU3nB/GKtybVCbbFHnhZQACd20VpBFjWJJXp21XNNx8yO3bog37oImynYxFfxvHtrQPhQXzIX7mbLA3RZv2eQGLIeEBlE/cp7i2YV4WFzDZXfHakf3YCKhA17PjzDih6er4rwJTvRAUT3CFLnIPQIi8Vw9bwARSIOwJdiBJWlMyC9Z4B7aK59JR4FeGSnIQ8+aVtlB9TJll6BH+keCATRqWOSjmTTMMK1x2DUDuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05I52TBdZw09CCTc0gdWiw98NfRn5otRT24mhBuimUI=;
 b=LR8sIlwIZxMrjxIwwhrPr8DYceDxKj6lwk44v3agJdopR6Jn8Aip2762OWseDwJ9a308Pm93SmoJV5a4Wmec907LGfu2cSaKexq+rPFnl8vdaveAcxs8MQxtz5+7d5APpOADtTSFzdC1SrKWA7ch71AuH7L44cXLXX0H3T9luMA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 19:49:08 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::5911:9489:e05c:2d44]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::5911:9489:e05c:2d44%5]) with mapi id 15.20.4129.036; Tue, 25 May 2021
 19:49:08 +0000
Subject: Re: [PATCH v6 1/4] KVM: stats: Separate common stats from
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
References: <20210524151828.4113777-1-jingzhangos@google.com>
 <20210524151828.4113777-2-jingzhangos@google.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <8cab5aa8-196f-04f3-6ab8-ffcbc9c35b67@oracle.com>
Date:   Tue, 25 May 2021 12:49:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210524151828.4113777-2-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN7PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:806:121::11) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SN7PR04CA0066.namprd04.prod.outlook.com (2603:10b6:806:121::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Tue, 25 May 2021 19:49:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c4c544d-4c01-41b0-eaee-08d91fb628e3
X-MS-TrafficTypeDiagnostic: SA2PR10MB4506:
X-Microsoft-Antispam-PRVS: <SA2PR10MB450655893BAF35443C40C46981259@SA2PR10MB4506.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qIDkP03jgILsjdeKoQ8mfRGGGJfSJxrAAgJHpflYoz6brDSbBqbJPSifutFlwKNUl5zh8cdZxZg3bglHIuOfIAVTAS5o3P3UJJ58fTlUxgp+bmRQbEOkI7Y8Whi0/lwLBZroj6xaVpoSAw2hg20hmG1XSRXpq2e9SDWdNkE0eWHaE42C4pLfy21YQhOQiymJO9Un2asNdDPSNUAl6JmidY7dV5Hlo0IeZoIoKY0Xfp6CvkVFqTHW7IXM7rORf3X0ClUjAnepOVihYQ8aTKTeWmYAcGASIv7QxUIjpLrZObA+dffqo9uETVgOZIQjYFjpdaH/RE8+luJIy5z2+rLtoua67KEzgWs82AdkVy7howaLnchrMphLdlV5H0Ruvbm2bEjs0XN0sDu++YhUiWWlzTLD8WE6xiQApmL8XNkwLIpPcOUYLPOsDQTv4Y4zZBmNVkc0wU9QbWSXgSUy3B3eSnVCZjebgFCRvEXV/LQpbwGQVm2AlJ83aG5Gs48qr9CnlFv8wP+p9GQVN1Swr0t97YT8HqZ1Tg5tIFXUAuEb4m3DKPP9bT28DpAPJm/7Qwq+FiorJJaC4P+6oFO/aswHMHnWlGM3CxVDc11kgHTtfmlx2kMVfaE7bhaKTK5tzqDoZhx8+RRX8cA5aY3uVUJ92KSwbTY/sfUZh8N9XLDrm7sCWiy9J4WS7j27ThTxSKwAmMrh/2jJbvmfB0Qy+GuTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(8676002)(36756003)(7406005)(921005)(8936002)(2616005)(7416002)(66946007)(6512007)(186003)(66556008)(16526019)(478600001)(66476007)(31696002)(38100700002)(6486002)(110136005)(6506007)(86362001)(53546011)(2906002)(83380400001)(31686004)(316002)(30864003)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VE56ODdaYVlGa1VzTDdjQnA0UlNMWWQ0eWVIKzI5T29SS2psZ25nUzB5a0cw?=
 =?utf-8?B?YXNOdTVtczhsZnNRVVdrb3VvOGdOelFyS2prQnNDNXhKUVl0Ylp0WTRTRUdp?=
 =?utf-8?B?ZGRmbFh0N0V4OUJhVEhaLzVFYlc3NWhUTWRtYm5zUjhJU2VYMFgvbklJVmpW?=
 =?utf-8?B?WmMveExkZjMwWnpZUlFtZDdQa0J4THRxNkx1dTI3enc3d0Urb0NGZlJjYzYr?=
 =?utf-8?B?akdJYzZYSDhzN2lVK3U4c0cvUnNIZUNMMFhtVWoxYmV2RnI4M1dobDQ4YXlx?=
 =?utf-8?B?ZnpqVlBhZFBOSHBlK3pMYmdVRlRXeG02SWRPNU80MDJtQm9jSFprdnhaRjMv?=
 =?utf-8?B?MTZiM01LeGlUSlBQWW1ueGp0d2NBcitka3RrYi9TMEdFQUFCTm5aZUJMU3Uw?=
 =?utf-8?B?UkcvUm8rWnYrSHd6Q0ZncWl4cGRoWjV0Ums1c2x3VVAvV2pzVlVpOEcxVCt6?=
 =?utf-8?B?QkVHek1RcDEyQjQySXRldTNscnpldnVHbDhCQXFxaitoMHJhcXRuOFpoZStD?=
 =?utf-8?B?dy92cS9BQklOYzFXRTVoaGgzKzNyMENNemRCMU5Tc2lMcC9kTC9zb2Vpaldp?=
 =?utf-8?B?T1J0Y1Y5N0pZNzBvd1hCeXY5VEdKR3ZvTWZXc2pSTlVpMS9ndFRac1l3cERq?=
 =?utf-8?B?OENIZklqU1NaMnBJdmF5b3diZE1SWEJrMzVaU05ycUJEWU5vaXZ6TXMyb05w?=
 =?utf-8?B?L0lyU3Zwbm0vUU5LM1VHRmZNZHh1eEM2dlJoMVVHUVBpWEdZc2lHVEdWWnJV?=
 =?utf-8?B?Z3ZNWmN1NVdVeEtVM2tDaXpRS0dkQ2dmY3pFYVhpRkJ6Rmt5VkRhelQ2ODRz?=
 =?utf-8?B?OWNxdGd0c20zdUQvZXlqeDlUZXhzWkpvSEk1R0ZkVkFFdXpxNWNUeXVWMkZE?=
 =?utf-8?B?a0hiVEd6M1hhYnZ6ZmNORFplcFdYV0w5L1hsRGp1WXM5Q1F2UXZwN2p5dnRn?=
 =?utf-8?B?UFpWRE1XQjl0Mi9KQVl5WWxoaXNpS2FndEgzc2pnT0o0Z3hXaUdNTnpKZjdN?=
 =?utf-8?B?RXQyQll3WnM4L0w4REgwSzlmZEwxcUVtenY0L3N1S0NFa0Npb0RKd0gwcENh?=
 =?utf-8?B?ZlI0OHM1bVdBdFhyTWJRY0w0R2pnOWdha1kySFVOV2xJVTE4MzFFRlFtZ0Ur?=
 =?utf-8?B?MFZ0USt6TjhqWUdoY3ZUWnJraUpLYndVbVZUZmptVE9lc2l2dUV2TmtOUHhy?=
 =?utf-8?B?UkV2Rlc5Ukx3U0ZQNHRHYjdnYmJRQWRDZWN2R1RmbGgvQ2ZwNURZSEhqdk9u?=
 =?utf-8?B?TDB0bXlSV2VZbWdsd3JzemNUaUlaY1E3K0hKUEh4ekdrYzVRTit3aU1XdHlC?=
 =?utf-8?B?dnM4ZlpTL2FJWGpLUnFTSS9jaWF1SGtTZFAxQ01IeHhobVRJeVdlbkhXMzRG?=
 =?utf-8?B?RDQ5Y29pMzJlODBJdTYxMk5MV0R6MDE1aU45VnFFRndOek4wZVNlZnVpc29X?=
 =?utf-8?B?aUJyOGNlMHFXc0pXa09JVFdtN0N4ZllMaFdyNVE1KzluVWd6UWdZVjMvWUVw?=
 =?utf-8?B?TXZTRXBhU0JhblpiYmt6eUtNY2c2ZXVRaUhGV2x0cVF2UlBSMSsza2JHdkdF?=
 =?utf-8?B?dzFMckYxREEzem9zSXFLZkltTXBRVHEweEZPakdpd2RXdytPa1MrZXdyaUdy?=
 =?utf-8?B?dUJVdGg0dWNsa3ByakVOWldpRHhzUlE3cnBSWThkYWZ6SkNtTTA5eURtNGVF?=
 =?utf-8?B?aU51dzZJZWF3eThzZmM1T0d4bUhaYU5OZXZ4MFo4S2MzU09pVS9lSFhRSDFN?=
 =?utf-8?B?cGo2amJjVkZqUUFDVXY2ZDlqcGlEMW8yRVV5c2tzUGVCQy9MODh3dHdCTDdM?=
 =?utf-8?B?Q2FXN2pvb0FGcUZGOUo4dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4c544d-4c01-41b0-eaee-08d91fb628e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:49:08.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYwk/55mb46xy3wRbArx2lepe68YN5ckEnXHQDzL9Ds4087U0AE+2PtJCmm8SddKoNkM/4mwHKMgM8aNY3nbg/h5jEQRnWddqn7+74on/QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250120
X-Proofpoint-ORIG-GUID: -0KCoNFbaYn8Dl4LQN2flzGrnJUJ8gGt
X-Proofpoint-GUID: -0KCoNFbaYn8Dl4LQN2flzGrnJUJ8gGt
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/24/21 8:18 AM, Jing Zhang wrote:
> Put all common statistics in a separate structure to ease
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
> index 7cd7d5c8c4bc..f3ad7a20b0af 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -556,16 +556,11 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
>   }
>   
>   struct kvm_vm_stat {
> -	ulong remote_tlb_flush;
> +	struct kvm_vm_stat_common common;
>   };
>   
>   struct kvm_vcpu_stat {
> -	u64 halt_successful_poll;
> -	u64 halt_attempted_poll;
> -	u64 halt_poll_success_ns;
> -	u64 halt_poll_fail_ns;
> -	u64 halt_poll_invalid;
> -	u64 halt_wakeup;
> +	struct kvm_vcpu_stat_common common;
>   	u64 hvc_exit_stat;
>   	u64 wfe_exit_stat;
>   	u64 wfi_exit_stat;
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 5cb4a1cd5603..0e41331b0911 100644
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
> +	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
>   	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
>   	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
>   	VCPU_STAT("mmio_exit_user", mmio_exit_user),
>   	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
>   	VCPU_STAT("exits", exits),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
>   	{ NULL }
>   };
>   
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index fca4547d580f..6f610fbcd8d1 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -109,10 +109,11 @@ static inline bool kvm_is_error_hva(unsigned long addr)
>   }
>   
>   struct kvm_vm_stat {
> -	ulong remote_tlb_flush;
> +	struct kvm_vm_stat_common common;
>   };
>   
>   struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_common common;
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
> index 4d4af97dcc88..f4fc60c05e9c 100644
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
> +	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
>   	{NULL}
>   };
>   
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 1e83359f286b..473d9d0804ff 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -80,12 +80,13 @@ struct kvmppc_book3s_shadow_vcpu;
>   struct kvm_nested_guest;
>   
>   struct kvm_vm_stat {
> -	ulong remote_tlb_flush;
> +	struct kvm_vm_stat_common common;
>   	ulong num_2M_pages;
>   	ulong num_1G_pages;
>   };
>   
>   struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_common common;
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
> index 2b691f4d1f26..bd3a10e1fdaf 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -47,14 +47,14 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("dec", dec_exits),
>   	VCPU_STAT("ext_intr", ext_intr_exits),
>   	VCPU_STAT("queue_intr", queue_intr),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
>   	VCPU_STAT("halt_wait_ns", halt_wait_ns),
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
>   	VCPU_STAT("halt_successful_wait", halt_successful_wait),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("pf_storage", pf_storage),
>   	VCPU_STAT("sp_storage", sp_storage),
>   	VCPU_STAT("pf_instruc", pf_instruc),
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 28a80d240b76..58e187e03c52 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -236,7 +236,7 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
>   
>   	waitp = kvm_arch_vcpu_get_wait(vcpu);
>   	if (rcuwait_wake_up(waitp))
> -		++vcpu->stat.halt_wakeup;
> +		++vcpu->stat.common.halt_wakeup;
>   
>   	cpu = READ_ONCE(vcpu->arch.thread_cpu);
>   	if (cpu >= 0 && kvmppc_ipi_thread(cpu))
> @@ -3925,7 +3925,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   	cur = start_poll = ktime_get();
>   	if (vc->halt_poll_ns) {
>   		ktime_t stop = ktime_add_ns(start_poll, vc->halt_poll_ns);
> -		++vc->runner->stat.halt_attempted_poll;
> +		++vc->runner->stat.common.halt_attempted_poll;
>   
>   		vc->vcore_state = VCORE_POLLING;
>   		spin_unlock(&vc->lock);
> @@ -3942,7 +3942,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   		vc->vcore_state = VCORE_INACTIVE;
>   
>   		if (!do_sleep) {
> -			++vc->runner->stat.halt_successful_poll;
> +			++vc->runner->stat.common.halt_successful_poll;
>   			goto out;
>   		}
>   	}
> @@ -3954,7 +3954,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   		do_sleep = 0;
>   		/* If we polled, count this as a successful poll */
>   		if (vc->halt_poll_ns)
> -			++vc->runner->stat.halt_successful_poll;
> +			++vc->runner->stat.common.halt_successful_poll;
>   		goto out;
>   	}
>   
> @@ -3981,13 +3981,13 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>   			ktime_to_ns(cur) - ktime_to_ns(start_wait);
>   		/* Attribute failed poll time */
>   		if (vc->halt_poll_ns)
> -			vc->runner->stat.halt_poll_fail_ns +=
> +			vc->runner->stat.common.halt_poll_fail_ns +=
>   				ktime_to_ns(start_wait) -
>   				ktime_to_ns(start_poll);
>   	} else {
>   		/* Attribute successful poll time */
>   		if (vc->halt_poll_ns)
> -			vc->runner->stat.halt_poll_success_ns +=
> +			vc->runner->stat.common.halt_poll_success_ns +=
>   				ktime_to_ns(cur) -
>   				ktime_to_ns(start_poll);
>   	}
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index d7733b07f489..214caa9d9675 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -493,7 +493,7 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
>   		if (!vcpu->arch.pending_exceptions) {
>   			kvm_vcpu_block(vcpu);
>   			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> -			vcpu->stat.halt_wakeup++;
> +			vcpu->stat.common.halt_wakeup++;
>   
>   			/* Unset POW bit after we woke up */
>   			msr &= ~MSR_POW;
> diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
> index 031c8015864a..9384625c8051 100644
> --- a/arch/powerpc/kvm/book3s_pr_papr.c
> +++ b/arch/powerpc/kvm/book3s_pr_papr.c
> @@ -378,7 +378,7 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
>   		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
>   		kvm_vcpu_block(vcpu);
>   		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> -		vcpu->stat.halt_wakeup++;
> +		vcpu->stat.common.halt_wakeup++;
>   		return EMULATE_DONE;
>   	case H_LOGICAL_CI_LOAD:
>   		return kvmppc_h_pr_logical_ci_load(vcpu);
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 7d5fe43f85c4..07fdd7a1254a 100644
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
> +	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("doorbell", dbell_exits),
>   	VCPU_STAT("guest doorbell", gdbell_exits),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> -	VM_STAT("remote_tlb_flush", remote_tlb_flush),
> +	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VM_STAT_COM("remote_tlb_flush", remote_tlb_flush),
>   	{ NULL }
>   };
>   
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8925f3969478..57a20897f3db 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -361,6 +361,7 @@ struct sie_page {
>   };
>   
>   struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_common common;
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
> +	struct kvm_vm_stat_common common;
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
> index 1296fc10f80c..d6bf3372bb10 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -72,13 +72,13 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("exit_program_interruption", exit_program_interruption),
>   	VCPU_STAT("exit_instr_and_program_int", exit_instr_and_program),
>   	VCPU_STAT("exit_operation_exception", exit_operation_exception),
> -	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> -	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> -	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
>   	VCPU_STAT("halt_no_poll_steal", halt_no_poll_steal),
> -	VCPU_STAT("halt_wakeup", halt_wakeup),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
> +	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
>   	VCPU_STAT("instruction_lctlg", instruction_lctlg),
>   	VCPU_STAT("instruction_lctl", instruction_lctl),
>   	VCPU_STAT("instruction_stctl", instruction_stctl),
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 55efbacfc244..5bfd6893fbf6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1127,6 +1127,7 @@ struct kvm_arch {
>   };
>   
>   struct kvm_vm_stat {
> +	struct kvm_vm_stat_common common;
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
> +	struct kvm_vcpu_stat_common common;
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
> index 9b6bca616929..9a93d80caff6 100644
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
> +	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
>   	VCPU_STAT("hypercalls", hypercalls),
>   	VCPU_STAT("request_irq", request_irq_exits),
>   	VCPU_STAT("irq_exits", irq_exits),
> @@ -241,8 +241,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("nmi_injections", nmi_injections),
>   	VCPU_STAT("req_event", req_event),
>   	VCPU_STAT("l1d_flush", l1d_flush),
> -	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> -	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
> +	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
>   	VCPU_STAT("nested_run", nested_run),
>   	VCPU_STAT("directed_yield_attempted", directed_yield_attempted),
>   	VCPU_STAT("directed_yield_successful", directed_yield_successful),
> @@ -253,7 +253,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VM_STAT("mmu_recycled", mmu_recycled),
>   	VM_STAT("mmu_cache_miss", mmu_cache_miss),
>   	VM_STAT("mmu_unsync", mmu_unsync),
> -	VM_STAT("remote_tlb_flush", remote_tlb_flush),
> +	VM_STAT_COM("remote_tlb_flush", remote_tlb_flush),
>   	VM_STAT("largepages", lpages, .mode = 0444),
>   	VM_STAT("nx_largepages_splitted", nx_lpage_splits, .mode = 0444),
>   	VM_STAT("max_mmu_page_hash_collisions", max_mmu_page_hash_collisions),
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 2f34487e21f2..97700e41db3b 100644
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
> +#define VM_STAT_COM(n, x, ...)						       \
> +	{ n, offsetof(struct kvm, stat.common.x), KVM_STAT_VM, ## __VA_ARGS__ }
> +#define VCPU_STAT_COM(n, x, ...)					       \
> +	{ n, offsetof(struct kvm_vcpu, stat.common.x),			       \
> +	  KVM_STAT_VCPU, ## __VA_ARGS__ }
>   
>   extern struct kvm_stats_debugfs_item debugfs_entries[];
>   extern struct dentry *kvm_debugfs_dir;
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index a7580f69dda0..87eb05ad678b 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -76,5 +76,17 @@ struct kvm_mmu_memory_cache {
>   };
>   #endif
>   
> +struct kvm_vm_stat_common {


Should this be named as 'kvm_vm_stat_generic' by following the 
convention in kvm_main.c ?  For example, kvm_vm_ioctl_enable_cap()  vs.  
kvm_vm_ioctl_enable_cap_generic().

> +	ulong remote_tlb_flush;
> +};
> +
> +struct kvm_vcpu_stat_common {


Same comment as above.

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
> index 6b4feb92dc79..34a4cf265297 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -330,7 +330,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>   	 */
>   	if (!kvm_arch_flush_remote_tlb(kvm)
>   	    || kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
> -		++kvm->stat.remote_tlb_flush;
> +		++kvm->stat.common.remote_tlb_flush;
>   	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
>   }
>   EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
> @@ -2940,9 +2940,9 @@ static inline void
>   update_halt_poll_stats(struct kvm_vcpu *vcpu, u64 poll_ns, bool waited)
>   {
>   	if (waited)
> -		vcpu->stat.halt_poll_fail_ns += poll_ns;
> +		vcpu->stat.common.halt_poll_fail_ns += poll_ns;
>   	else
> -		vcpu->stat.halt_poll_success_ns += poll_ns;
> +		vcpu->stat.common.halt_poll_success_ns += poll_ns;
>   }
>   
>   /*
> @@ -2960,16 +2960,16 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>   	if (vcpu->halt_poll_ns && !kvm_arch_no_poll(vcpu)) {
>   		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
>   
> -		++vcpu->stat.halt_attempted_poll;
> +		++vcpu->stat.common.halt_attempted_poll;
>   		do {
>   			/*
>   			 * This sets KVM_REQ_UNHALT if an interrupt
>   			 * arrives.
>   			 */
>   			if (kvm_vcpu_check_block(vcpu) < 0) {
> -				++vcpu->stat.halt_successful_poll;
> +				++vcpu->stat.common.halt_successful_poll;
>   				if (!vcpu_valid_wakeup(vcpu))
> -					++vcpu->stat.halt_poll_invalid;
> +					++vcpu->stat.common.halt_poll_invalid;
>   				goto out;
>   			}
>   			poll_end = cur = ktime_get();
> @@ -3027,7 +3027,7 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>   	waitp = kvm_arch_vcpu_get_wait(vcpu);
>   	if (rcuwait_wake_up(waitp)) {
>   		WRITE_ONCE(vcpu->ready, true);
> -		++vcpu->stat.halt_wakeup;
> +		++vcpu->stat.common.halt_wakeup;
>   		return true;
>   	}
>   
