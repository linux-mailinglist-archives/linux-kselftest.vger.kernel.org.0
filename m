Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D363139E76A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jun 2021 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFGTZU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 15:25:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47948 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231163AbhFGTZT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 15:25:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157JDGSP020134;
        Mon, 7 Jun 2021 19:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CmNH9rFwJW3heyqp4Dn4rrJhi/XFi5TEZv2rOf5U+Hk=;
 b=q7AcsqHkVl+8IQwVo2AznF+XZ0+1GCXbAiMWO9pYe9RZzdkPHQknL66ZCNw++ljdmTbl
 0ANmz97m32N7q8PitsV4jkMYpQsM9nPOoVXiKCF+qTfxGCFERg0ztBJfmhujqCdivmIm
 tcww9+8admSePG50T8K6/tLQq/mzer6xACpTrW2oXvOtfHsRrIbGZg+mAyhmNsd1+4TB
 ZhP2+lfiK2G8/UnBoXNKNbcF6ynffzHkKRznw7AuXbI345IOoOVZb3U4QozyT2aLI6Zq
 yqT7XDA/DrWyh5AMi03t9naRtMe9WPjI7GeY/Jr1Ag4MzDx7Rc5iDr/Adx+m4pIpvwFm 1g== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3916m08c2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:23:08 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 157JN7bZ100041;
        Mon, 7 Jun 2021 19:23:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3030.oracle.com with ESMTP id 38yyaab6pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:23:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVUxKooahRBkazZGxfy+yvJJsxjbTMcg/zzNDHwePUOlKOp7uFOnIMJpoEHcjM4XeUqu+nRk5M4jrkVHIwscIemENIz7lrE2YsaSDDs/c+AyggWseT+h8XwHK7RVYD8aDBDjTPySmdFjJqytm8TnSGAmrngVDGSbapn9rWpjP8+A0OZE49pVr+tykyE0q7VoZe8QsgPJXVc2a6mj8t84SniNq7xY5dhy8eT+UJFTN/Js41zkjw8YnnPgTkOL4W94gCifj60PKJLGCxlEDCR+SD8mvCzARBR/KD0K01MZHWwJb9vG3WCNRq7S4xUHufYGf8pmGnJhN4iTcTsx2i1NKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmNH9rFwJW3heyqp4Dn4rrJhi/XFi5TEZv2rOf5U+Hk=;
 b=Vzvfb3M3hjRqnQVjJxt4xH+A7hmRG5R0iF1xBWPUvwFUW4B1JmL4PdtyUUL19kHCJ+t5AdrfmAO2layYdpSamKTN1IirbzlA+1uTrKQQLdI/iU0K4NFiVkeBWARnmg5qU1C2zMTbT8M41UWomtPzhpWHikB9yLzfUDVaQnL6wFbw99i8XTgNxjO/c3GgCNMQ7Yv5I9IKeC0mxHLGrn6/SxQ5L86MNbiV428ze6ZABzvWaCzWzTWw58CiyAcyPgX0R+EWkidlSOikyAS14AURz53dO82ReN/6nR5xMZVnUtiQ68M5nrNPYLYB6Po2O8dDOu3B6G49r6HrlvEjqtU+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmNH9rFwJW3heyqp4Dn4rrJhi/XFi5TEZv2rOf5U+Hk=;
 b=uem2nR0Rd5OopzqgtP8EBVvaStdm2cNzqz12KdATfVrcrTAtzrhA8eE6q4RJE1Xjh/ec8Yuxef7qKC5i/Ej65HXdyGmjRQVMjH6cgGc6G+FoPm+C7Vydr8asevYt4qEnA9eLmAhd/je9L726L5FdMY27apMFRxCITvXppKd1Ilc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 19:23:02 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f17c:44eb:d1be:2107%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:23:02 +0000
Subject: Re: [PATCH v7 3/4] KVM: stats: Add documentation for statistics data
 binary interface
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
 <20210603211426.790093-4-jingzhangos@google.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <0431329c-4fda-8011-607d-2ef4a3af9237@oracle.com>
Date:   Mon, 7 Jun 2021 12:22:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210603211426.790093-4-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 19:23:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 080f2eed-25cc-46c5-7d0e-08d929e9aaf5
X-MS-TrafficTypeDiagnostic: SN6PR10MB2464:
X-Microsoft-Antispam-PRVS: <SN6PR10MB24648E7AC97C69DCFCBE65A681389@SN6PR10MB2464.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbIUGRnjgkYdUke5dR+VevYNoSDf6QhoannEo6SsZXw2GA2PSdvsNrCkPeKiZb7VmWO+pz36XRvDT62d2LoHCWLOTvxq+aSMgvkDSgRVI8CFzMSq/Izv5bUFzbN7qhW0DRJbhJV75eNxh+H9VeS4WggFv/9tX5wSqUO379PAlzpv5xgO0Caqn+1DKLo6BTn42QfDJXnVb/xoU8t2SQkhg5CJhYCWMP2JQKCmeKBaER587CuRfH0R+WJFtj9fEZWpgKP0NfeZay48Td61h6HLrhwSPE4+znuYSU7k2MonD88ge45N7Vooe3/1NWr8je65Rz2u3vghDfjUa2yuiLQlXzaREJzh0ZNURYJoeSPp+RbCyqs7COw211F70BEMDSbB+HHr3EWysJMawJghDrFUZ2Bs/ZgEnCDREwqzkId99I/VNeQV7flyBez9SNc1iEGEQ3Q+MLrvT3qLCkYJW/hFD5TF3qZnY2CcTMZF5heFu+0sS6w9eN4CdHuxGE41B8gIQjUnPyPjcEaEH5p4n90Aj6ryxfkLT26RzQNXr1/flFmCX4eCJxDjXKsmpq3WI0SRQqD/MYtVRykbw+2GEX1Exs3qNLsmgGjkVlvKWpRIAjHi9PotrLdAsSmgz/TuRuUqiD3UXpJ0ey1ZKWgbd/6HUW+GPOZaHuFf6E2OdsaRi526ten7/bpFTzEFYZkkE00/KvSlSIHqAAm7dCe2gWubMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(38100700002)(478600001)(53546011)(31686004)(2906002)(5660300002)(110136005)(44832011)(8936002)(8676002)(2616005)(66476007)(66946007)(6486002)(66556008)(6512007)(83380400001)(16526019)(31696002)(186003)(86362001)(36756003)(7416002)(921005)(316002)(6506007)(7406005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SlZBMEJIZmhOc1Z5dmNOeVc1NFk2Zzl5U2xreHkwNUhtMUExekgyS2tmdklH?=
 =?utf-8?B?Ty9MVi9zVGp0cjUyZDJwa2xqK0QxVUZHczd6d2QyQUh4NDNXeXRYQjJCMWJL?=
 =?utf-8?B?UjErM0xXd1g0L0ozZ3N3SHg4UlNWNUw5SzdSWHBwcmJZS2IzODNqci9BM0xL?=
 =?utf-8?B?N3RqNkJtVENnRWxvajEzRTlKZlpxWGVqaUJyVnprWVVhOHVZdFh4QzhrLzJy?=
 =?utf-8?B?cXlqTlFVVG9ZdE9OR09lWDY3RmJzemZWa3dnZXMrUDNBaHM3Q2d5azZRMFVC?=
 =?utf-8?B?a0ErQWJORTU2QXIrVWd3UXBCN21FQmQvcGVHZzhXdFEzZnBYNXFJOWRzUnVB?=
 =?utf-8?B?NjBmU1NYekRKZXlvUG9nZmNpU0hGUk43cUdDT3ZnZEFUWk5kZDJzVzRrVll1?=
 =?utf-8?B?LzcxTFBrellUTVlReTMyRDU1dldGSXRBaXJXZThReks3UnVSN2tQTURnNFpy?=
 =?utf-8?B?aGVZeTdaY1pINERvSG1ibGV6QWJ0RklzbjFyUzM3V3ZYa3dzMnMrcW4zS0lD?=
 =?utf-8?B?em9KeTVEaWZSZXFQUTJmZ0NQRlVCdzVKelpvZDVSYXRRWHhqK3NSaEI3c3Uy?=
 =?utf-8?B?dEdoNWUrcm5iV3E4TXB5S1ovMXRQVERVRm8yMjJKMURFNjgzU0hzU2pWWmlh?=
 =?utf-8?B?d043NEQxSTZydUl3WnVFU3lka2k2Unp4VEhvN242eUtkM1JUdk52WDZ3cG91?=
 =?utf-8?B?MGJ5dnJKSkI4MHhzRTQ4eVRQZTBqSmlaYit6OW1jeFMyRm5GSnpBMmFOa0M0?=
 =?utf-8?B?T2tFZFNzZG45ekxCd1RsSHhnMWxRZWxYUGQxNEFmSnZaUGlZQXMyUkxtUURZ?=
 =?utf-8?B?RllpQWxJdlZQREVnOXFxK0ZaY0FMWEZGSlpSNFZpakNyZUpsSjJZWC9ydHBG?=
 =?utf-8?B?OExXZWl4YXdad3NRTGY5RU9WNGlOTnNYVFp5QnVPenFQUllaZU9EUmRkdXRa?=
 =?utf-8?B?M0dGQkZDUmV3TG95L3czcjh2Z253UVpYZ054bjRTa3lGa1lHaUxLSWR1bGFl?=
 =?utf-8?B?elIycThsUEMycVZjQkR2QUFxR1pRWHVjMXV0ZFZ3WTFJeDBOODA2clZnQ3kr?=
 =?utf-8?B?M2lUOTZqa1ZKN28wYWVZZUJHdnhoRVVxUWNsbkRKSjZzMFRyb0hoK1RjQnlw?=
 =?utf-8?B?UW4raDhqby9aWXAvYkswNHdFTmdILzcyUnNqUFdPN2pFVk9OYUprejFvM2FL?=
 =?utf-8?B?bEExWmVxdE42dFNUTXNRQ0ZoSkxaNWc3UUo5K0FKakNuQUU4TGs2YXdjUXkw?=
 =?utf-8?B?ZkQvVUNpd3JPWTk2TmZqTk9jM2VtVnA3QnpRQXpYS2M1WTlMZjFMMElpQnNu?=
 =?utf-8?B?WDhsS3MyTGlVM3lFL3dXVjJPS1kwYXF4QTgrdDBLcFhHNFFLZ2JGUWRrTG9x?=
 =?utf-8?B?MzgvdndWelFtWUJnaXdQU0RVK1Fxd3VJeWoxK1hnUVg5VE5LWGZwV3RZZHU1?=
 =?utf-8?B?YTc2dzk3V2FrbnVkR3ZWMDR2NVEzSFZHazV3dXRrc3FYQlVpQzRhWHdUN0p2?=
 =?utf-8?B?OTJPZnFmTUsrT3A5YmlZZmpSaGxqaDJJTnJjNTVzTlUycy9XQ3VMRTc1Y29S?=
 =?utf-8?B?RUx5b1dnbE84eVRhRlJGelB5aVJheGduTmxvZy9pTzZTNHlpR01wbjk2NWMr?=
 =?utf-8?B?NkFMb2NPM3N0U0dLMFVTNUFqZzBOL3dVZExNanZkaEVSaGltdG02Q2tPV2pu?=
 =?utf-8?B?VzhUd0VTdmI3MllaK3V2em9oSG5rVHVxN0Y0VmF5Tk4rV1hkVWJYWXp6U0ZU?=
 =?utf-8?B?bnY4SVJxQTh3OUYxMU5lS1dlWU4xMGRraENidy91dlN2N0FDMGk2d1Z1anRD?=
 =?utf-8?B?Yk9kNjVIcWh1aW9MZkhlZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080f2eed-25cc-46c5-7d0e-08d929e9aaf5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:23:02.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LqFdhuq35EA+SRt1fGxZh/mLez41JeRwJRoDytMM20ZdqQZIydUmIFm+j+GnKS94Sbbyd/s4sVku66x/0qRbKIqTw+oyKlh85rfTRock2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070131
X-Proofpoint-ORIG-GUID: _sAhpD124hm8B6qTo5EW_A_bTBkZMkow
X-Proofpoint-GUID: _sAhpD124hm8B6qTo5EW_A_bTBkZMkow
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/3/21 2:14 PM, Jing Zhang wrote:
> Update KVM API documentation for binary statistics.
>
> Reviewed-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>   Documentation/virt/kvm/api.rst | 180 +++++++++++++++++++++++++++++++++
>   1 file changed, 180 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7fcb2fd38f42..550bfbdf611b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5034,6 +5034,178 @@ see KVM_XEN_VCPU_SET_ATTR above.
>   The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
>   with the KVM_XEN_VCPU_GET_ATTR ioctl.
>   
> +4.130 KVM_GET_STATS_FD
> +---------------------
> +
> +:Capability: KVM_CAP_STATS_BINARY_FD
> +:Architectures: all
> +:Type: vm ioctl, vcpu ioctl
> +:Parameters: none
> +:Returns: statistics file descriptor on success, < 0 on error
> +
> +Errors:
> +
> +  ======     ======================================================
> +  ENOMEM     if the fd could not be created due to lack of memory
> +  EMFILE     if the number of opened files exceeds the limit
> +  ======     ======================================================
> +
> +The file descriptor can be used to read VM/vCPU statistics data in binary
> +format. The file data is organized into three blocks as below:
> ++-------------+
> +|   Header    |
> ++-------------+
> +| Descriptors |
> ++-------------+
> +| Stats Data  |
> ++-------------+
> +
> +The Header block is always at the start of the file. It is only needed to be
> +read one time for the lifetime of the file descriptor.
> +It is in the form of ``struct kvm_stats_header`` as below::
> +
> +	#define KVM_STATS_ID_MAXLEN		64
> +
> +	struct kvm_stats_header {
> +		char id[KVM_STATS_ID_MAXLEN];
> +		__u32 name_size;
> +		__u32 count;
> +		__u32 desc_offset;
> +		__u32 data_offset;
> +	};
> +
> +The ``id`` field is identification for the corresponding KVM statistics. For
> +VM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For
> +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
> +"kvm-12345/vcpu-12".

Currently, KVM debugfs shows VCPUs as "vcpuXX" where is XX is the id. 
Should we follow the same convention ?
> +
> +The ``name_size`` field is the size (byte) of the statistics name string
> +(including trailing '\0') appended to the end of every statistics descriptor.
> +
> +The ``count`` field is the number of statistics.
> +
> +The ``desc_offset`` field is the offset of the Descriptors block from the start
> +of the file indicated by the file descriptor.
> +
> +The ``data_offset`` field is the offset of the Stats Data block from the start
> +of the file indicated by the file descriptor.
> +
> +The Descriptors block is only needed to be read once for the lifetime of the
> +file descriptor. It is an array of ``struct kvm_stats_desc`` as shown in
> +below code block::
> +
> +	#define KVM_STATS_TYPE_SHIFT		0
> +	#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
> +	#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
> +	#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
> +	#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
> +
> +	#define KVM_STATS_UNIT_SHIFT		4
> +	#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
> +	#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
> +
> +	#define KVM_STATS_BASE_SHIFT		8
> +	#define KVM_STATS_BASE_MASK		(0xF << KVM_STATS_BASE_SHIFT)
> +	#define KVM_STATS_BASE_POW10		(0x0 << KVM_STATS_BASE_SHIFT)
> +	#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
> +	#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
> +
> +	struct kvm_stats_desc {
> +		__u32 flags;
> +		__s16 exponent;
> +		__u16 size;
> +		__u32 unused1;
> +		__u32 unused2;
> +		char name[0];
> +	};
> +
> +The ``flags`` field contains the type and unit of the statistics data described
> +by this descriptor. The following flags are supported:
> +
> +Bits 0-3 of ``flags`` encode the type:
> +  * ``KVM_STATS_TYPE_CUMULATIVE``
> +    The statistics data is cumulative. The value of data can only be increased.
> +    Most of the counters used in KVM are of this type.
> +    The corresponding ``count`` filed for this type is always 1.
> +  * ``KVM_STATS_TYPE_INSTANT``
> +    The statistics data is instantaneous. Its value can be increased or
> +    decreased. This type is usually used as a measurement of some resources,
> +    like the number of dirty pages, the number of large pages, etc.
> +    The corresponding ``count`` field for this type is always 1.
> +
> +Bits 4-7 of ``flags`` encode the unit:
> +  * ``KVM_STATS_UNIT_NONE``
> +    There is no unit for the value of statistics data. This usually means that
> +    the value is a simple counter of an event.
> +  * ``KVM_STATS_UNIT_BYTES``
> +    It indicates that the statistics data is used to measure memory size, in the
> +    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
> +    determined by the ``exponent`` field in the descriptor. The
> +    ``KVM_STATS_BASE_POW2`` flag is valid in this case. The unit of the data is
> +    determined by ``pow(2, exponent)``. For example, if value is 10,
> +    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
> +    can get the statistics data in the unit of Byte by
> +    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
> +    10 * 1024 * 1024 Bytes.
> +  * ``KVM_STATS_UNIT_SECONDS``
> +    It indicates that the statistics data is used to measure time/latency, in
> +    the unit of nanosecond, microsecond, millisecond and second. The unit of the
> +    data is determined by the ``exponent`` field in the descriptor. The
> +    ``KVM_STATS_BASE_POW10`` flag is valid in this case. The unit of the data
> +    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
> +    ``exponent`` is -6, which means the unit of statistics data is microsecond,
> +    we can get the statistics data in the unit of second by
> +    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
> +  * ``KVM_STATS_UNIT_CYCLES``
> +    It indicates that the statistics data is used to measure CPU clock cycles.
> +    The ``KVM_STATS_BASE_POW10`` flag is valid in this case. For example, if
> +    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
> +    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
> +
> +Bits 7-11 of ``flags`` encode the base:
> +  * ``KVM_STATS_BASE_POW10``
> +    The scale is based on power of 10. It is used for measurement of time and
> +    CPU clock cycles.
> +  * ``KVM_STATS_BASE_POW2``
> +    The scale is based on power of 2. It is used for measurement of memory size.
> +
> +The ``exponent`` field is the scale of corresponding statistics data. For
> +example, if the unit is ``KVM_STATS_UNIT_BYTES``, the base is
> +``KVM_STATS_BASE_POW2``, the ``exponent`` is 10, then we know that the real
> +unit of the statistics data is KBytes a.k.a pow(2, 10) = 1024 bytes.
> +
> +The ``size`` field is the number of values of this statistics data. It is in the
> +unit of ``unsigned long`` for VM or ``__u64`` for VCPU.
> +
> +The ``unused1`` and ``unused2`` fields are reserved for future
> +support for other types of statistics data, like log/linear histogram.
> +
> +The ``name`` field points to the name string of the statistics data. The name
> +string starts at the end of ``struct kvm_stats_desc``.
> +The maximum length (including trailing '\0') is indicated by ``name_size``
> +in ``struct kvm_stats_header``.
> +
> +The Stats Data block contains an array of data values of type ``struct
> +kvm_vm_stats_data`` or ``struct kvm_vcpu_stats_data``. It would be read by
> +user space periodically to pull statistics data.
> +The order of data value in Stats Data block is the same as the order of
> +descriptors in Descriptors block.
> +  * Statistics data for VM::
> +
> +	struct kvm_vm_stats_data {
> +		unsigned long value[0];
> +	};
> +
> +  * Statistics data for VCPU::
> +
> +	struct kvm_vcpu_stats_data {
> +		__u64 value[0];
> +	};
> +
>   5. The kvm_run structure
>   ========================
>   
> @@ -6891,3 +7063,11 @@ This capability is always enabled.
>   This capability indicates that the KVM virtual PTP service is
>   supported in the host. A VMM can check whether the service is
>   available to the guest on migration.
> +
> +8.33 KVM_CAP_STATS_BINARY_FD
> +----------------------------
> +
> +:Architectures: all
> +
> +This capability indicates the feature that user space can create get a file
> +descriptor for every VM and VCPU to read statistics data in binary format.


Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

