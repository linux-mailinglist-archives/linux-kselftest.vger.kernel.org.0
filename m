Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2F391FB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhEZSyz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 14:54:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41790 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234284AbhEZSyy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 14:54:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QIksRJ025468;
        Wed, 26 May 2021 18:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IPrQIJAoWwk6bUgeSc9kdW86+3ZvVilb4NxbkbPLvQU=;
 b=UjTVCNSVrE/D3tThSLZZzne9lj3g25LbZmjVJu/pC5aD2SBQQ3VVMaafNu9um9BJLAFU
 TOUyzdMHt3Fjee66U9wZA8B4Nvvt8MnFehHo5sf4o0X/HgCH8po43CTs1LcFt+1ZHVL/
 bdEcMRy0FKGXMYM51DzPoq2pn09k06QW2taUt4aKxmTKAzabsATmCbjn2WgfZknhyYdJ
 pMUwzAWlHxrpwVxHVczCkDkT36yBgTo1D048kHrt8LfXlD00SxwZaeQjvOhSXJQrXQFK
 psZ5KcME3Xy2IcGPu5B9VrBzjnJSn+acNI8SQuqcB7P0pWSV4fPgImopJtjKH+UtjlA/ LQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38sppd03wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 18:53:01 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14QIkuKD123702;
        Wed, 26 May 2021 18:53:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 38pr0cy8hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 18:53:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGEeDfoWhPdS1SRB2N5CLvWvNwB1NnHxrHW0n8aO26S6xeYG7X6Xqf7o0ncwlHThx9R2xkXWOAiyELJsmOG6fRgcr+Vf8VQeyEITnUyGThofJ6fiw205ezlXq/7Z87YFRdxPuPe4fJJuQJ5erXipy/CN9iA17Fshq4j6RjJ6ZNxw14keoAfRdWxpIoPFa+uB9w45/UQpIYdM8rEwYhrX4YpaZ1ndXeq0VTDdEmJhVZSOHdguecA9joo4TsoEnITxJuuhofu48YgbPtKB1Ke9zf4vgXxkXNlGNiPeT8xwPjHQngandF5mJEnVLU/2nDWz3xCl8kuEYVInwcmCLRiKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPrQIJAoWwk6bUgeSc9kdW86+3ZvVilb4NxbkbPLvQU=;
 b=clcISfkenSa5+/Mcx1Mfj3X7gAvWbQLuwfXO1aQfMsEZHOsYi7y7crTSCtxjZpH6VHUZrP1GRePrFVmdbZL5XpCOL6n3zYZc91iX5cHS3ExgwZNIZxwThJZgpcoci4SpWiZf37oVjSwS2ODvKcy4nb07V+pTT74fCedWmTWuZQnL6X7qBl4qQ/0PA0RwZSjkJrHC1xw02j4cmVr9p3Oyhu6lUAc/mL3Tz6iJD2EFhvdwS2cnToDmyu0yhqoVfrlJiAIIorGCd7JwVqJKa4I4qixHi+xtpbncmwWzEoSFEZhfe4nuxXpsBVHAXnsTpmQTY0jFBF2B4/19MIQStSw+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPrQIJAoWwk6bUgeSc9kdW86+3ZvVilb4NxbkbPLvQU=;
 b=lTbTf7ULMaeaUkfmjLaHmzRg6rOv95G0mduc2x+8QRz4U0KZLh+LEZ8lMoVaytfId8pzCo5qtpseE85y9Eh1UVqWq3hXf8sfkG1fvvsNHKOBMuzSwJ4PAymJiCzxWmCWHvwGJXFjfQFORxP5hLYhvnAs2EDbgATDW8R+4a8FTqk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3019.namprd10.prod.outlook.com (2603:10b6:5:6f::23) by
 DM6PR10MB3258.namprd10.prod.outlook.com (2603:10b6:5:1a0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Wed, 26 May 2021 18:52:57 +0000
Received: from DM6PR10MB3019.namprd10.prod.outlook.com
 ([fe80::1962:84ab:e8e0:d471]) by DM6PR10MB3019.namprd10.prod.outlook.com
 ([fe80::1962:84ab:e8e0:d471%3]) with mapi id 15.20.4129.032; Wed, 26 May 2021
 18:52:57 +0000
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Subject: Re: [PATCH v6 2/4] KVM: stats: Add fd-based API to read binary stats
 data
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
 <20210524151828.4113777-3-jingzhangos@google.com>
Message-ID: <48fe1fb3-4109-6875-7354-ae3eeb4cfd54@oracle.com>
Date:   Wed, 26 May 2021 11:52:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210524151828.4113777-3-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To DM6PR10MB3019.namprd10.prod.outlook.com
 (2603:10b6:5:6f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Wed, 26 May 2021 18:52:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b4ef74f-f7d1-4cf5-4750-08d920777a17
X-MS-TrafficTypeDiagnostic: DM6PR10MB3258:
X-Microsoft-Antispam-PRVS: <DM6PR10MB3258E0CADC3E3C3D8A127A9A81249@DM6PR10MB3258.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG2Bfq/qhsU7PCD9sKzwI7T05b+TDut/dQCEKU+/YMTQ7DeDt0vSm7Jy5xP1CxIWg6yr2WDhsho+0yc9m5ajlSEHpgPqmsWF/+htrcjVGfP1MR3Zm6rRTyyfTnizd3Cq7UQnXEDY6llTubiT21vfgap25/p8AqZXWfd/61uYP+wG1ZhcgmvJTOPXLVw2jtAfSKTJaLJUHOcN05UQkRIvrdtbMgAtvPguUDMXJBghRNZQJgJ997oCFq/QtclO5glehtqQsyJv8xfmu9AuH+74RsTku4VGxT4GzNzJO3QQSTnCYqyWj7zaC+nHpKA0BTtyh2F0ckz6A/o6fd5Bk6KdoPPqeVedcleoC+479trubQKm3fuLI7JduRGxl4gIFclvXcG1FsLWNyD5r7KnJDHo30y26FzJwuc5fj6oyucquWOTZ52e6YBb3x9uZGMQ5lHaQg26HUH4dqb8ZxI+3gJvDHXYfu5WeNkRCVkY3pwK2nPJd67CRmHzbrTL6PKOSn5ODQlnND17fOZJah61Rzu0o50QGu4s4IQXmbfazAdy7s62IXx3woXuK51rZtNpKNCiyUj8ehowI9GdW4QqiBZSBeMEOhFaiaG5kU+73dLBbc7nFqTiSljohrcGzSkjHvQVrI8D/alV7AgVtHcbIMPVP6LtiNeIhsmf+RWcaOkJ6s6BRNw4QK+4PoI8LzMRZbn1om3dpM+r56X73WT8Xu16LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3019.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(396003)(346002)(316002)(38100700002)(6486002)(53546011)(7416002)(6506007)(66556008)(36756003)(186003)(16526019)(44832011)(30864003)(66476007)(478600001)(86362001)(921005)(8676002)(110136005)(31696002)(2616005)(31686004)(7406005)(2906002)(6512007)(5660300002)(83380400001)(66946007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGxoUjhZL1VXbC9ZcFQwY3ZOMjJsbUJvZ3l4QVJ1TVYydEdHYXdHLzljeTBV?=
 =?utf-8?B?RHVYOXYzOVI5Z0FUbmk3b0FnM1JkL3dLR0xIRWxXanlQWU9nM0N6d0lyWm5m?=
 =?utf-8?B?bCtPODNYamIyUU13MDQ4bExzMHRZMHJKc1FONDZaVzdtOCtjZmo4OWF1Zmxt?=
 =?utf-8?B?VUhYS1NaQldBUUptYnFSUjBzdi94ZEM3TUp3dGRUT0MwN1liaFlJZnlUWWww?=
 =?utf-8?B?SGxRRGsyOTM1UHdJTXd5Y3FoS3dpVGgwRDhlcjlFdTAvWEhvV0ZQVEYwUFhX?=
 =?utf-8?B?MUhxWDhqdXhWWVE3ZDExamhBaTd5bG02Yk0rMFpDcEZINmx2VkprSWpTdjRS?=
 =?utf-8?B?Nk5McmJ2TWhmRzAxa0tkNGdJVjdITEpQUEd2eFE2U3Y5K3BvK0ZCeFVsK09o?=
 =?utf-8?B?ejR3TFpLczNYQUdid3V1c0htQ2FWYU1LMVl6YlhXNk80Y0dxdjNkNEJ6YmtM?=
 =?utf-8?B?ZllMSGs3eXNqRzlYbUhlWXVHVGJ4cGI4Z3d6RVBCYWlRd2VNenZpQ2lHUDQ5?=
 =?utf-8?B?M1FHcXN3KzRLQ0Q3ajNQUFlaM0RJTUpIdVNjbjl6b1hhajhHSzR2dFlUYXJS?=
 =?utf-8?B?WXRNV3JqYjY3SkYzOWp1dnRmdnZaeTFwRnFpdEF3ZktMbVVuUCt5NGNGS09y?=
 =?utf-8?B?aUFsWDB3aGFyMVpSVXBBSVRoVXdMMEtSV2I0QTRReHRhZU1RZm1lWEw2QVFY?=
 =?utf-8?B?eHRxRnNtQjNCVlN2SlZHakExQkwreTh6UUFObjg3Z1hHQ01maGQ2Q1hzcEcv?=
 =?utf-8?B?bksvK0VmaUhXek8ycDZERkd0SXRveVVMZVJkZDBsSUpyRlZuTW5xSisrc0Fk?=
 =?utf-8?B?Rmxrc2ZRekdNU2pzWnZacWpwZDJ0VFlCb3JCaDVJcmxEa2RTVVVuUkh1b05K?=
 =?utf-8?B?cnQ3QXNnUVpLdEt6U2hYSnMxSkgzR2NwQ2tzelNYRzY5SE9FWlE5TnNiYmha?=
 =?utf-8?B?bjNLajNvaXFJME05U25rYTh1TEJlR01rdlBwUWNHaHczM1pQbER2b1ErUVUz?=
 =?utf-8?B?NlRjR1BEZjR6WkVpMGhuek0xbjZ6bUZtZklEWm1ycXhKRlhmQWdxNDZCa1Vu?=
 =?utf-8?B?TFNZalN2bWQyTTMxSmc3S0dkN3pYeXY2bVd1dFdLSGxnNGJTWGFFS2xqS0pN?=
 =?utf-8?B?Ritybk5FVi9JWWg1d01wMERXZkRKcGZzaGwxbC9GRnJrdk5GM3JHNWh0TWRm?=
 =?utf-8?B?QkFRU1VyR1lMSnlzMTN4K2RKei9XQSt2NGc4Y29LY2tyL3VPTjdYTTNKajNx?=
 =?utf-8?B?Wkxhd3FrdUhjSnNFVGVySlhUR1Q2YlpPMWNuUDR3empSM3dYWVFWUDBKamFK?=
 =?utf-8?B?R1JadjBUMHJiaEx4U0thSjJOKzlzRXhRVlQvUDNiSnE2M2hOZ0FScGhvQi9l?=
 =?utf-8?B?NzU1dWw2YnVnMkJHdnpJZUZjbzN6a0xWZXdWTjBMdEIvYlh5YThTMEZ5cWRy?=
 =?utf-8?B?bUhxRHdya0JKMjAyTUlCUnZEMklhMExrek1SaGZzQUdJMXJEZEZqekFFY0Zw?=
 =?utf-8?B?TENnUTRPeGFnQ1VwMVdrRENsQm5VU0tZaVplY0ZuSkpmYldPZ3JKQmxlSWho?=
 =?utf-8?B?eFRUUXo0RlVQYkEyeWkvQ25XaEF6U0NhUTBxMVBkOGc2clZmUEVUNllzQ0RS?=
 =?utf-8?B?WUphU2E3WWNySFQ1ajV3MjRNK0k4WGtIRi8veFZ4QlhzQnl3eWIycE9zZGFQ?=
 =?utf-8?B?REhrQy91Q0FhcXkwVmd5elJ4Rmd3emxHUDVsL0d3dW9uT0NGUlhOcEt2YkM4?=
 =?utf-8?B?UkpKeUpDVzNHdUk4cmtPRk1XTzNyMXpsaTlsUWZyUlRvNVg3UVZtM0JJeDFJ?=
 =?utf-8?B?UHpBNE0wREdUWko3bkQ0UT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4ef74f-f7d1-4cf5-4750-08d920777a17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3019.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 18:52:57.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6z1YBRqY1ZjHMLJpvV7WswHDAFHSIuvWc3Yo2u2xWTIvxS62fMmCzFtdU3nAOilseyOWd9Yw9H9EEEe72/hWobaOkqvqk0tjVrzXLP14Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3258
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260127
X-Proofpoint-GUID: XfSvockvgVEQ7Ywjgpx0djn2p2GBBYHn
X-Proofpoint-ORIG-GUID: XfSvockvgVEQ7Ywjgpx0djn2p2GBBYHn
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/24/21 8:18 AM, Jing Zhang wrote:
> Provides a file descriptor per VM to read VM stats info/data.
> Provides a file descriptor per vCPU to read vCPU stats info/data.
>
> Reviewed-by: David Matlack<dmatlack@google.com>
> Reviewed-by: Ricardo Koller<ricarkol@google.com>
> Signed-off-by: Jing Zhang<jingzhangos@google.com>
> ---
>   arch/arm64/kvm/guest.c    |  26 ++++++
>   arch/mips/kvm/mips.c      |  52 ++++++++++++
>   arch/powerpc/kvm/book3s.c |  52 ++++++++++++
>   arch/powerpc/kvm/booke.c  |  45 +++++++++++
>   arch/s390/kvm/kvm-s390.c  | 117 +++++++++++++++++++++++++++
>   arch/x86/kvm/x86.c        |  53 ++++++++++++
>   include/linux/kvm_host.h  | 132 ++++++++++++++++++++++++++++++
>   include/uapi/linux/kvm.h  |  50 ++++++++++++
>   virt/kvm/kvm_main.c       | 165 ++++++++++++++++++++++++++++++++++++++
>   9 files changed, 692 insertions(+)
>
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 0e41331b0911..1cc1d83630ac 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -28,6 +28,32 @@
>   
>   #include "trace.h"
>   
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC();
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vm_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +	STATS_DESC_COUNTER("hvc_exit_stat"),
> +	STATS_DESC_COUNTER("wfe_exit_stat"),
> +	STATS_DESC_COUNTER("wfi_exit_stat"),
> +	STATS_DESC_COUNTER("mmio_exit_user"),
> +	STATS_DESC_COUNTER("mmio_exit_kernel"),
> +	STATS_DESC_COUNTER("exits"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vcpu_stats_desc),
> +};
> +
>   struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
>   	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll), diff --git a/arch/mips/kvm/mips.c 
> b/arch/mips/kvm/mips.c index f4fc60c05e9c..f17a65743ccd 100644 --- 
> a/arch/mips/kvm/mips.c +++ b/arch/mips/kvm/mips.c @@ -38,6 +38,58 @@ 
> #define VECTORSPACING 0x100 /* for EI/VI mode */ #endif +struct 
> _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(); + 
> +struct _kvm_stats_header kvm_vm_stats_header = { + .name_size = 
> KVM_STATS_NAME_LEN, + .count = ARRAY_SIZE(kvm_vm_stats_desc), + 
> .desc_offset = sizeof(struct kvm_stats_header), + .data_offset = 
> sizeof(struct kvm_stats_header) + + sizeof(kvm_vm_stats_desc), +}; + 
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = 
> DEFINE_VCPU_STATS_DESC( + STATS_DESC_COUNTER("wait_exits"),
> +	STATS_DESC_COUNTER("cache_exits"),
> +	STATS_DESC_COUNTER("signal_exits"),
> +	STATS_DESC_COUNTER("int_exits"),
> +	STATS_DESC_COUNTER("cop_unusable_exits"),
> +	STATS_DESC_COUNTER("tlbmod_exits"),
> +	STATS_DESC_COUNTER("tlbmiss_ld_exits"),
> +	STATS_DESC_COUNTER("tlbmiss_st_exits"),
> +	STATS_DESC_COUNTER("addrerr_st_exits"),
> +	STATS_DESC_COUNTER("addrerr_ld_exits"),
> +	STATS_DESC_COUNTER("syscall_exits"),
> +	STATS_DESC_COUNTER("resvd_inst_exits"),
> +	STATS_DESC_COUNTER("break_inst_exits"),
> +	STATS_DESC_COUNTER("trap_inst_exits"),
> +	STATS_DESC_COUNTER("msa_fpe_exits"),
> +	STATS_DESC_COUNTER("fpe_exits"),
> +	STATS_DESC_COUNTER("msa_disabled_exits"),
> +	STATS_DESC_COUNTER("flush_dcache_exits"),
> +#ifdef CONFIG_KVM_MIPS_VZ
> +	STATS_DESC_COUNTER("vz_gpsi_exits"),
> +	STATS_DESC_COUNTER("vz_gsfc_exits"),
> +	STATS_DESC_COUNTER("vz_hc_exits"),
> +	STATS_DESC_COUNTER("vz_grr_exits"),
> +	STATS_DESC_COUNTER("vz_gva_exits"),
> +	STATS_DESC_COUNTER("vz_ghfc_exits"),
> +	STATS_DESC_COUNTER("vz_gpa_exits"),
> +	STATS_DESC_COUNTER("vz_resvd_exits"),
> +#ifdef CONFIG_CPU_LOONGSON64
> +	STATS_DESC_COUNTER("vz_cpucfg_exits"),
> +#endif
> +#endif
> +	);
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vcpu_stats_desc),
> +};
> +
>   struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("wait", wait_exits),
>   	VCPU_STAT("cache", cache_exits),
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index bd3a10e1fdaf..5e8ee0d39ef9 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -38,6 +38,58 @@
>   
>   /* #define EXIT_DEBUG */
>   
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +	STATS_DESC_ICOUNTER("num_2M_pages"),
> +	STATS_DESC_ICOUNTER("num_1G_pages"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vm_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +	STATS_DESC_COUNTER("sum_exits"),
> +	STATS_DESC_COUNTER("mmio_exits"),
> +	STATS_DESC_COUNTER("signal_exits"),
> +	STATS_DESC_COUNTER("light_exits"),
> +	STATS_DESC_COUNTER("itlb_real_miss_exits"),
> +	STATS_DESC_COUNTER("itlb_virt_miss_exits"),
> +	STATS_DESC_COUNTER("dtlb_real_miss_exits"),
> +	STATS_DESC_COUNTER("dtlb_virt_miss_exits"),
> +	STATS_DESC_COUNTER("syscall_exits"),
> +	STATS_DESC_COUNTER("isi_exits"),
> +	STATS_DESC_COUNTER("dsi_exits"),
> +	STATS_DESC_COUNTER("emulated_inst_exits"),
> +	STATS_DESC_COUNTER("dec_exits"),
> +	STATS_DESC_COUNTER("ext_intr_exits"),
> +	STATS_DESC_TIME_NSEC("halt_wait_ns"),
> +	STATS_DESC_COUNTER("halt_successful_wait"),
> +	STATS_DESC_COUNTER("dbell_exits"),
> +	STATS_DESC_COUNTER("gdbell_exits"),
> +	STATS_DESC_COUNTER("ld"),
> +	STATS_DESC_COUNTER("st"),
> +	STATS_DESC_COUNTER("pf_storage"),
> +	STATS_DESC_COUNTER("pf_instruc"),
> +	STATS_DESC_COUNTER("sp_storage"),
> +	STATS_DESC_COUNTER("sp_instruc"),
> +	STATS_DESC_COUNTER("queue_intr"),
> +	STATS_DESC_COUNTER("ld_slow"),
> +	STATS_DESC_COUNTER("st_slow"),
> +	STATS_DESC_COUNTER("pthru_all"),
> +	STATS_DESC_COUNTER("pthru_host"),
> +	STATS_DESC_COUNTER("pthru_bad_aff"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vcpu_stats_desc),
> +};
> +
>   struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("exits", sum_exits),
>   	VCPU_STAT("mmio", mmio_exits),
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 07fdd7a1254a..86d221e9193e 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -36,6 +36,51 @@
>   
>   unsigned long kvmppc_booke_handlers;
>   
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +	STATS_DESC_ICOUNTER("num_2M_pages"),
> +	STATS_DESC_ICOUNTER("num_1G_pages"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vm_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +	STATS_DESC_COUNTER("sum_exits"),
> +	STATS_DESC_COUNTER("mmio_exits"),
> +	STATS_DESC_COUNTER("signal_exits"),
> +	STATS_DESC_COUNTER("light_exits"),
> +	STATS_DESC_COUNTER("itlb_real_miss_exits"),
> +	STATS_DESC_COUNTER("itlb_virt_miss_exits"),
> +	STATS_DESC_COUNTER("dtlb_real_miss_exits"),
> +	STATS_DESC_COUNTER("dtlb_virt_miss_exits"),
> +	STATS_DESC_COUNTER("syscall_exits"),
> +	STATS_DESC_COUNTER("isi_exits"),
> +	STATS_DESC_COUNTER("dsi_exits"),
> +	STATS_DESC_COUNTER("emulated_inst_exits"),
> +	STATS_DESC_COUNTER("dec_exits"),
> +	STATS_DESC_COUNTER("ext_intr_exits"),
> +	STATS_DESC_TIME_NSEC("halt_wait_ns"),
> +	STATS_DESC_COUNTER("halt_successful_wait"),
> +	STATS_DESC_COUNTER("dbell_exits"),
> +	STATS_DESC_COUNTER("gdbell_exits"),
> +	STATS_DESC_COUNTER("ld"),
> +	STATS_DESC_COUNTER("st"),
> +	STATS_DESC_COUNTER("pthru_all"),
> +	STATS_DESC_COUNTER("pthru_host"),
> +	STATS_DESC_COUNTER("pthru_bad_aff"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vcpu_stats_desc),
> +};
> +
>   struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("mmio", mmio_exits),
>   	VCPU_STAT("sig", signal_exits),
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d6bf3372bb10..003feee79fce 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -58,6 +58,123 @@
>   #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
>   			   (KVM_MAX_VCPUS + LOCAL_IRQS))
>   
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +	STATS_DESC_COUNTER("inject_io"),
> +	STATS_DESC_COUNTER("inject_float_mchk"),
> +	STATS_DESC_COUNTER("inject_pfault_done"),
> +	STATS_DESC_COUNTER("inject_service_signal"),
> +	STATS_DESC_COUNTER("inject_virtio"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vm_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +	STATS_DESC_COUNTER("exit_userspace"),
> +	STATS_DESC_COUNTER("exit_null"),
> +	STATS_DESC_COUNTER("exit_external_request"),
> +	STATS_DESC_COUNTER("exit_io_request"),
> +	STATS_DESC_COUNTER("exit_external_interrupt"),
> +	STATS_DESC_COUNTER("exit_stop_request"),
> +	STATS_DESC_COUNTER("exit_validity"),
> +	STATS_DESC_COUNTER("exit_instruction"),
> +	STATS_DESC_COUNTER("exit_pei"),
> +	STATS_DESC_COUNTER("halt_no_poll_steal"),
> +	STATS_DESC_COUNTER("instruction_lctl"),
> +	STATS_DESC_COUNTER("instruction_lctlg"),
> +	STATS_DESC_COUNTER("instruction_stctl"),
> +	STATS_DESC_COUNTER("instruction_stctg"),
> +	STATS_DESC_COUNTER("exit_program_interruption"),
> +	STATS_DESC_COUNTER("exit_instr_and_program"),
> +	STATS_DESC_COUNTER("exit_operation_exception"),
> +	STATS_DESC_COUNTER("deliver_ckc"),
> +	STATS_DESC_COUNTER("deliver_cputm"),
> +	STATS_DESC_COUNTER("deliver_external_call"),
> +	STATS_DESC_COUNTER("deliver_emergency_signal"),
> +	STATS_DESC_COUNTER("deliver_service_signal"),
> +	STATS_DESC_COUNTER("deliver_virtio"),
> +	STATS_DESC_COUNTER("deliver_stop_signal"),
> +	STATS_DESC_COUNTER("deliver_prefix_signal"),
> +	STATS_DESC_COUNTER("deliver_restart_signal"),
> +	STATS_DESC_COUNTER("deliver_program"),
> +	STATS_DESC_COUNTER("deliver_io"),
> +	STATS_DESC_COUNTER("deliver_machine_check"),
> +	STATS_DESC_COUNTER("exit_wait_state"),
> +	STATS_DESC_COUNTER("inject_ckc"),
> +	STATS_DESC_COUNTER("inject_cputm"),
> +	STATS_DESC_COUNTER("inject_external_call"),
> +	STATS_DESC_COUNTER("inject_emergency_signal"),
> +	STATS_DESC_COUNTER("inject_mchk"),
> +	STATS_DESC_COUNTER("inject_pfault_init"),
> +	STATS_DESC_COUNTER("inject_program"),
> +	STATS_DESC_COUNTER("inject_restart"),
> +	STATS_DESC_COUNTER("inject_set_prefix"),
> +	STATS_DESC_COUNTER("inject_stop_signal"),
> +	STATS_DESC_COUNTER("instruction_epsw"),
> +	STATS_DESC_COUNTER("instruction_gs"),
> +	STATS_DESC_COUNTER("instruction_io_other"),
> +	STATS_DESC_COUNTER("instruction_lpsw"),
> +	STATS_DESC_COUNTER("instruction_lpswe"),
> +	STATS_DESC_COUNTER("instruction_pfmf"),
> +	STATS_DESC_COUNTER("instruction_ptff"),
> +	STATS_DESC_COUNTER("instruction_sck"),
> +	STATS_DESC_COUNTER("instruction_sckpf"),
> +	STATS_DESC_COUNTER("instruction_stidp"),
> +	STATS_DESC_COUNTER("instruction_spx"),
> +	STATS_DESC_COUNTER("instruction_stpx"),
> +	STATS_DESC_COUNTER("instruction_stap"),
> +	STATS_DESC_COUNTER("instruction_iske"),
> +	STATS_DESC_COUNTER("instruction_ri"),
> +	STATS_DESC_COUNTER("instruction_rrbe"),
> +	STATS_DESC_COUNTER("instruction_sske"),
> +	STATS_DESC_COUNTER("instruction_ipte_interlock"),
> +	STATS_DESC_COUNTER("instruction_stsi"),
> +	STATS_DESC_COUNTER("instruction_stfl"),
> +	STATS_DESC_COUNTER("instruction_tb"),
> +	STATS_DESC_COUNTER("instruction_tpi"),
> +	STATS_DESC_COUNTER("instruction_tprot"),
> +	STATS_DESC_COUNTER("instruction_tsch"),
> +	STATS_DESC_COUNTER("instruction_sie"),
> +	STATS_DESC_COUNTER("instruction_essa"),
> +	STATS_DESC_COUNTER("instruction_sthyi"),
> +	STATS_DESC_COUNTER("instruction_sigp_sense"),
> +	STATS_DESC_COUNTER("instruction_sigp_sense_running"),
> +	STATS_DESC_COUNTER("instruction_sigp_external_call"),
> +	STATS_DESC_COUNTER("instruction_sigp_emergency"),
> +	STATS_DESC_COUNTER("instruction_sigp_cond_emergency"),
> +	STATS_DESC_COUNTER("instruction_sigp_start"),
> +	STATS_DESC_COUNTER("instruction_sigp_stop"),
> +	STATS_DESC_COUNTER("instruction_sigp_stop_store_status"),
> +	STATS_DESC_COUNTER("instruction_sigp_store_status"),
> +	STATS_DESC_COUNTER("instruction_sigp_store_adtl_status"),
> +	STATS_DESC_COUNTER("instruction_sigp_arch"),
> +	STATS_DESC_COUNTER("instruction_sigp_prefix"),
> +	STATS_DESC_COUNTER("instruction_sigp_restart"),
> +	STATS_DESC_COUNTER("instruction_sigp_init_cpu_reset"),
> +	STATS_DESC_COUNTER("instruction_sigp_cpu_reset"),
> +	STATS_DESC_COUNTER("instruction_sigp_unknown"),
> +	STATS_DESC_COUNTER("diagnose_10"),
> +	STATS_DESC_COUNTER("diagnose_44"),
> +	STATS_DESC_COUNTER("diagnose_9c"),
> +	STATS_DESC_COUNTER("diagnose_9c_ignored"),
> +	STATS_DESC_COUNTER("diagnose_258"),
> +	STATS_DESC_COUNTER("diagnose_308"),
> +	STATS_DESC_COUNTER("diagnose_500"),
> +	STATS_DESC_COUNTER("diagnose_other"),
> +	STATS_DESC_COUNTER("pfault_sync"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vcpu_stats_desc),
> +};
> +
>   struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("userspace_handled", exit_userspace),
>   	VCPU_STAT("exit_null", exit_null),
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9a93d80caff6..84880687c199 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -214,6 +214,59 @@ EXPORT_SYMBOL_GPL(host_xss);
>   u64 __read_mostly supported_xss;
>   EXPORT_SYMBOL_GPL(supported_xss);
>   
> +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> +	STATS_DESC_COUNTER("mmu_shadow_zapped"),
> +	STATS_DESC_COUNTER("mmu_pte_write"),
> +	STATS_DESC_COUNTER("mmu_pde_zapped"),
> +	STATS_DESC_COUNTER("mmu_flooded"),
> +	STATS_DESC_COUNTER("mmu_recycled"),
> +	STATS_DESC_COUNTER("mmu_cache_miss"),
> +	STATS_DESC_ICOUNTER("mmu_unsync"),
> +	STATS_DESC_ICOUNTER("largepages"),
> +	STATS_DESC_ICOUNTER("nx_largepages_splits"),
> +	STATS_DESC_ICOUNTER("max_mmu_page_hash_collisions"));
> +
> +struct _kvm_stats_header kvm_vm_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vm_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vm_stats_desc),
> +};
> +
> +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> +	STATS_DESC_COUNTER("pf_fixed"),
> +	STATS_DESC_COUNTER("pf_guest"),
> +	STATS_DESC_COUNTER("tlb_flush"),
> +	STATS_DESC_COUNTER("invlpg"),
> +	STATS_DESC_COUNTER("exits"),
> +	STATS_DESC_COUNTER("io_exits"),
> +	STATS_DESC_COUNTER("mmio_exits"),
> +	STATS_DESC_COUNTER("signal_exits"),
> +	STATS_DESC_COUNTER("irq_window_exits"),
> +	STATS_DESC_COUNTER("nmi_window_exits"),
> +	STATS_DESC_COUNTER("l1d_flush"),
> +	STATS_DESC_COUNTER("halt_exits"),
> +	STATS_DESC_COUNTER("request_irq_exits"),
> +	STATS_DESC_COUNTER("irq_exits"),
> +	STATS_DESC_COUNTER("host_state_reload"),
> +	STATS_DESC_COUNTER("fpu_reload"),
> +	STATS_DESC_COUNTER("insn_emulation"),
> +	STATS_DESC_COUNTER("insn_emulation_fail"),
> +	STATS_DESC_COUNTER("hypercalls"),
> +	STATS_DESC_COUNTER("irq_injections"),
> +	STATS_DESC_COUNTER("nmi_injections"),
> +	STATS_DESC_COUNTER("req_event"),
> +	STATS_DESC_COUNTER("nested_run"));
> +
> +struct _kvm_stats_header kvm_vcpu_stats_header = {
> +	.name_size = KVM_STATS_NAME_LEN,
> +	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> +	.desc_offset = sizeof(struct kvm_stats_header),
> +	.data_offset = sizeof(struct kvm_stats_header) +
> +		sizeof(kvm_vcpu_stats_desc),
> +};
> +
>   struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("pf_fixed", pf_fixed),
>   	VCPU_STAT("pf_guest", pf_guest),
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 97700e41db3b..c0a8e6ddc745 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1240,6 +1240,19 @@ struct kvm_stats_debugfs_item {
>   	int mode;
>   };
>   
> +struct _kvm_stats_header {
> +	__u32 name_size;
> +	__u32 count;
> +	__u32 desc_offset;
> +	__u32 data_offset;
> +};
> +
> +#define KVM_STATS_NAME_LEN	48
> +struct _kvm_stats_desc {
> +	struct kvm_stats_desc desc;
> +	char name[KVM_STATS_NAME_LEN];
> +};
> +
>   #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
>   	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
>   
> @@ -1253,8 +1266,127 @@ struct kvm_stats_debugfs_item {
>   	{ n, offsetof(struct kvm_vcpu, stat.common.x),			       \
>   	  KVM_STAT_VCPU, ## __VA_ARGS__ }
>   
> +#define STATS_DESC(stat, type, unit, scale, exp)			       \
> +	{								       \
> +		{							       \
> +			.flags = type | unit | scale,			       \
> +			.exponent = exp,				       \
> +			.size = 1					       \
> +		},							       \
> +		.name = stat,						       \
> +	}
> +#define STATS_DESC_CUMULATIVE(name, unit, scale, exponent)		       \
> +	STATS_DESC(name, KVM_STATS_TYPE_CUMULATIVE, unit, scale, exponent)
> +#define STATS_DESC_INSTANT(name, unit, scale, exponent)			       \
> +	STATS_DESC(name, KVM_STATS_TYPE_INSTANT, unit, scale, exponent)
> +
> +/* Cumulative counter */
> +#define STATS_DESC_COUNTER(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_NONE,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Instantaneous counter */
> +#define STATS_DESC_ICOUNTER(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_NONE,			       \
> +		KVM_STATS_BASE_POW10, 0)
> +
> +/* Cumulative clock cycles */
> +#define STATS_DESC_CYCLE(name)						       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_CYCLES,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Instantaneous clock cycles */
> +#define STATS_DESC_ICYCLE(name)						       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_CYCLES,			       \
> +		KVM_STATS_BASE_POW10, 0)
> +
> +/* Cumulative memory size in Byte */
> +#define STATS_DESC_SIZE_BYTE(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 0)
> +/* Cumulative memory size in KiByte */
> +#define STATS_DESC_SIZE_KBYTE(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 10)
> +/* Cumulative memory size in MiByte */
> +#define STATS_DESC_SIZE_MBYTE(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 20)
> +/* Cumulative memory size in GiByte */
> +#define STATS_DESC_SIZE_GBYTE(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,		       \
> +		KVM_STATS_BASE_POW2, 30)
> +
> +/* Instantaneous memory size in Byte */
> +#define STATS_DESC_ISIZE_BYTE(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,			       \
> +		KVM_STATS_BASE_POW2, 0)
> +/* Instantaneous memory size in KiByte */
> +#define STATS_DESC_ISIZE_KBYTE(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,			       \
> +		KVM_STATS_BASE_POW2, 10)
> +/* Instantaneous memory size in MiByte */
> +#define STATS_DESC_ISIZE_MBYTE(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,			       \
> +		KVM_STATS_BASE_POW2, 20)
> +/* Instantaneous memory size in GiByte */
> +#define STATS_DESC_ISIZE_GBYTE(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,			       \
> +		KVM_STATS_BASE_POW2, 30)
> +
> +/* Cumulative time in second */
> +#define STATS_DESC_TIME_SEC(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Cumulative time in millisecond */
> +#define STATS_DESC_TIME_MSEC(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -3)
> +/* Cumulative time in microsecond */
> +#define STATS_DESC_TIME_USEC(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -6)
> +/* Cumulative time in nanosecond */
> +#define STATS_DESC_TIME_NSEC(name)					       \
> +	STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -9)
> +
> +/* Instantaneous time in second */
> +#define STATS_DESC_ITIME_SEC(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, 0)
> +/* Instantaneous time in millisecond */
> +#define STATS_DESC_ITIME_MSEC(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -3)
> +/* Instantaneous time in microsecond */
> +#define STATS_DESC_ITIME_USEC(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -6)
> +/* Instantaneous time in nanosecond */
> +#define STATS_DESC_ITIME_NSEC(name)					       \
> +	STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,		       \
> +		KVM_STATS_BASE_POW10, -9)
> +
> +#define DEFINE_VM_STATS_DESC(...) {					       \
> +	STATS_DESC_COUNTER("remote_tlb_flush"),				       \
> +	## __VA_ARGS__							       \
> +}
> +
> +#define DEFINE_VCPU_STATS_DESC(...) {					       \
> +	STATS_DESC_COUNTER("halt_successful_poll"),			       \
> +	STATS_DESC_COUNTER("halt_attempted_poll"),			       \
> +	STATS_DESC_COUNTER("halt_poll_invalid"),			       \
> +	STATS_DESC_COUNTER("halt_wakeup"),				       \
> +	STATS_DESC_TIME_NSEC("halt_poll_success_ns"),			       \
> +	STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),			       \
> +	## __VA_ARGS__							       \
> +}
> +
>   extern struct kvm_stats_debugfs_item debugfs_entries[];
>   extern struct dentry *kvm_debugfs_dir;
> +extern struct _kvm_stats_header kvm_vm_stats_header;
> +extern struct _kvm_stats_header kvm_vcpu_stats_header;
> +extern struct _kvm_stats_desc kvm_vm_stats_desc[];
> +extern struct _kvm_stats_desc kvm_vcpu_stats_desc[];
>   
>   #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>   static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 3fd9a7e9d90c..82db825c392c 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1082,6 +1082,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_SGX_ATTRIBUTE 196
>   #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
>   #define KVM_CAP_PTP_KVM 198
> +#define KVM_CAP_STATS_BINARY_FD 199
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> @@ -1898,4 +1899,53 @@ struct kvm_dirty_gfn {
>   #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
>   #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
>   
> +#define KVM_STATS_ID_MAXLEN		64
> +
> +struct kvm_stats_header {
> +	char id[KVM_STATS_ID_MAXLEN];
> +	__u32 name_size;
> +	__u32 count;
> +	__u32 desc_offset;
> +	__u32 data_offset;
> +};
> +
> +#define KVM_STATS_TYPE_SHIFT		0
> +#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
> +#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
> +
> +#define KVM_STATS_UNIT_SHIFT		4
> +#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
> +#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
> +
> +#define KVM_STATS_BASE_SHIFT		8
> +#define KVM_STATS_BASE_MASK		(0xF << KVM_STATS_BASE_SHIFT)
> +#define KVM_STATS_BASE_POW10		(0x0 << KVM_STATS_BASE_SHIFT)
> +#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
> +#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
> +
> +struct kvm_stats_desc {
> +	__u32 flags;
> +	__s16 exponent;
> +	__u16 size;
> +	__u32 unused1;
> +	__u32 unused2;
> +	char name[0];
> +};
> +
> +struct kvm_vm_stats_data {
> +	unsigned long value[0];
> +};
> +
> +struct kvm_vcpu_stats_data {
> +	__u64 value[0];
> +};
> +
> +#define KVM_STATS_GETFD  _IOR(KVMIO,  0xcc, struct kvm_stats_header)
> +
>   #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 34a4cf265297..9e20e2ff78b4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3409,6 +3409,120 @@ static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
>   	return 0;
>   }
>   
> +static ssize_t kvm_stats_read(char *id, struct _kvm_stats_header *header,
> +		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
> +		char __user *user_buffer, size_t size, loff_t *offset)
> +{
> +	ssize_t copylen, len, remain = size;
> +	size_t size_header, size_desc;
> +	loff_t pos = *offset;
> +	char __user *dest = user_buffer;
> +	void *src;
> +
> +	size_header = sizeof(*header);
> +	size_desc = header->count * sizeof(*desc);
> +
> +	len = KVM_STATS_ID_MAXLEN + size_header + size_desc + size_stats - pos;
> +	len = min(len, remain);
> +	if (len <= 0)
> +		return 0;
> +	remain = len;
> +
> +	/* Copy kvm stats header id string */
> +	copylen = KVM_STATS_ID_MAXLEN - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = id + pos;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm stats header */
> +	copylen = KVM_STATS_ID_MAXLEN + size_header - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = header + pos - KVM_STATS_ID_MAXLEN;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm stats descriptors */
> +	copylen = header->desc_offset + size_desc - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = desc + pos - header->desc_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm stats values */
> +	copylen = header->data_offset + size_stats - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = stats + pos - header->data_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +


Is it possible to re-use the 'if' portion either via a separate function 
? For example,

static int copy_data(void *src)

{
         if (copy_to_user(dest, src, copylen))
             return -EFAULT;
         remain -= copylen;
         pos += copylen;
         dest += copylen;
         return 0;

}

and then calling it as,

         if (copylen > 0)

             copy_data(stats + pos - header->data_offset);

> +	*offset = pos;
> +	return len;
> +}
> +
> +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> +			      size_t size, loff_t *offset)
> +{
> +	char id[KVM_STATS_ID_MAXLEN];
> +	struct kvm_vcpu *vcpu = file->private_data;
> +
> +	snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> +			task_pid_nr(current), vcpu->vcpu_id);
> +	return kvm_stats_read(id, &kvm_vcpu_stats_header,
> +			&kvm_vcpu_stats_desc[0], &vcpu->stat,
> +			sizeof(vcpu->stat), user_buffer, size, offset);
> +}
> +
> +static const struct file_operations kvm_vcpu_stats_fops = {
> +	.read = kvm_vcpu_stats_read,
> +	.llseek = noop_llseek,
> +};
> +
> +static int kvm_vcpu_ioctl_get_statsfd(struct kvm_vcpu *vcpu)
> +{
> +	int error, fd;
> +	struct file *file;
> +	char name[15 + ITOA_MAX_LEN + 1];
> +
> +	snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
> +
> +	error = get_unused_fd_flags(O_CLOEXEC);
> +	if (error < 0)
> +		return error;
> +	fd = error;
> +
> +	file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
> +	if (IS_ERR(file)) {
> +		error = PTR_ERR(file);
> +		goto err_put_unused_fd;
> +	}
> +	file->f_mode |= FMODE_PREAD;
> +	fd_install(fd, file);
> +
> +	return fd;
> +
> +err_put_unused_fd:
> +	put_unused_fd(fd);
> +	return error;
> +}
> +
>   static long kvm_vcpu_ioctl(struct file *filp,
>   			   unsigned int ioctl, unsigned long arg)
>   {
> @@ -3606,6 +3720,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
>   		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
>   		break;
>   	}
> +	case KVM_STATS_GETFD: {
> +		r = kvm_vcpu_ioctl_get_statsfd(vcpu);
> +		break;
> +	}
>   	default:
>   		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>   	}
> @@ -3864,6 +3982,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   #else
>   		return 0;
>   #endif
> +	case KVM_CAP_STATS_BINARY_FD:
> +		return 1;
>   	default:
>   		break;
>   	}
> @@ -3967,6 +4087,48 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
>   	}
>   }
>   
> +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> +			      size_t size, loff_t *offset)
> +{
> +	char id[KVM_STATS_ID_MAXLEN];
> +	struct kvm *kvm = file->private_data;
> +
> +	snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> +	return kvm_stats_read(id, &kvm_vm_stats_header, &kvm_vm_stats_desc[0],
> +		&kvm->stat, sizeof(kvm->stat), user_buffer, size, offset);
> +}
> +
> +static const struct file_operations kvm_vm_stats_fops = {
> +	.read = kvm_vm_stats_read,
> +	.llseek = noop_llseek,
> +};
> +
> +static int kvm_vm_ioctl_get_statsfd(struct kvm *kvm)
> +{
> +	int error, fd;
> +	struct file *file;
> +
> +	error = get_unused_fd_flags(O_CLOEXEC);
> +	if (error < 0)
> +		return error;
> +	fd = error;


Why not just do,

             fd = get_unused_fd_flags(O_CLOEXEC);
             if (fd < 0)
                     return fd;

?

> +
> +	file = anon_inode_getfile("kvm-vm-stats",
> +			&kvm_vm_stats_fops, kvm, O_RDONLY);
> +	if (IS_ERR(file)) {
> +		error = PTR_ERR(file);
> +		goto err_put_unused_fd;


Here, we can do,

                if (IS_ERR(file)) {

                     put_unused_fd(fd);

                     return (PTR_ERR(file));

                 }

and won't need a goto statement.

Same comment for kvm_vcpu_ioctl_get_statsfd().

> +	}
> +	file->f_mode |= FMODE_PREAD;
> +	fd_install(fd, file);
> +
> +	return fd;
> +
> +err_put_unused_fd:
> +	put_unused_fd(fd);
> +	return error;
> +}
> +
>   static long kvm_vm_ioctl(struct file *filp,
>   			   unsigned int ioctl, unsigned long arg)
>   {
> @@ -4149,6 +4311,9 @@ static long kvm_vm_ioctl(struct file *filp,
>   	case KVM_RESET_DIRTY_RINGS:
>   		r = kvm_vm_ioctl_reset_dirty_pages(kvm);
>   		break;
> +	case KVM_STATS_GETFD:


This should be named KVM_GET_STATS_FD.  For example, we have names like 
KVM_GET_DIRTY_LOG etc.

Same comment for KVM_STATS_GETFD.

> +		r = kvm_vm_ioctl_get_statsfd(kvm);


It's probably more readable if we call it kvm_vm_ioctl_get_stats_fd().

> +		break;
>   	default:
>   		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
>   	}
