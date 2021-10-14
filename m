Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD842CFEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Oct 2021 03:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhJNB37 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 21:29:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54466 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJNB35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 21:29:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19E0dZmY009357;
        Thu, 14 Oct 2021 01:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yhIVN7ax8FUiyDgQmeTol5qRaevsI1CqpdU0zOmhSSY=;
 b=T2QHeIhE6bMyei/W7PQHF14tbJTxOso2onx4tdOm5LpXSeANYl2b1djpCH+Ou0X2+wAq
 Tnces8VKPi3ZecY3XTnV4vPKLoinb2CqBK+iOCrkcZTpv944iGCB+m790hUjeb66mK/z
 DWIBjO7iFVlrU8S6OpBJRPd6iz/SGo1LHVwblHXMq6+TY99SPPqeuSCnY7ibCwb50Kbc
 WpVaBtk2eFBF1tSE2ymTwH4sbHUqnONoapzKm/gy3bk0ue/BTv7EvfLgsvBDm8e0tlkQ
 HjX/IIYdWT+AnJL/AM7sqa291NaSAi+iTd/zjmWo5roWotxhUuxTVmHp9ejo6i0S+Ad7 Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbn0e4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 01:26:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19E1LBmr109462;
        Thu, 14 Oct 2021 01:26:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3bkyvbtb2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 01:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEk9QfDfj8lRdBzVNJ2ebP3xP8gpYclvG0SwOa5Ef7PJFVBydaELxIvzOLfz4g2IBHNy/QbTdVnFoPK0pmWpYLjs4oxVX57FxZdSt1P/e/Vx+GGFFDy46vM3zqa/ZG1UjztB8dRq9TxYF651tmKjIRj+z7qdppi18p+j2RFYucdkq8txJQYHlmVGfgzh7DGvy0RuE0hmJ19k7xsyhZXFMUGxTZXiHHYivrm29vqqvv03N/mP5ZyUUPjo+GNx6Ybzi8VKq33MI7N6kx0JWmx/MnPHSav5blsDP5v9eeHfBoxZ5V9zypi5TgaHc+GC5/SgwR6b5cRLJLOFjuGa92c+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhIVN7ax8FUiyDgQmeTol5qRaevsI1CqpdU0zOmhSSY=;
 b=PIf8hNTcpLCi6yc7LVZ12NQAuyD81V05+s9ZoYu+ZPj8UZaJh5UP4/SWPWGc+CuQgUC+bnEl9xzfq54FHov0Z+3WZO/94SWyX07tZv2MYqE7F5J9FZ+1dRTmfPaUM1Kw/I0Ls8LQxKYUteAnOOI0YSAB9JFljJu35a72viLYD4tASe2Ilo8BnDy4iKQRExQJoiVkd39Dxa5ruejFfNh4njYplIl1/v8McgrX9XmjGAn/wHUDOScOfOpctVorm73ndfOuKyDM+ZgbFxw1qq0SDV1idvs6qPCAeKr9U06F46y0Kem+iT43GcFsz02SyzaGnSwNToPykCtei6ppdISRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhIVN7ax8FUiyDgQmeTol5qRaevsI1CqpdU0zOmhSSY=;
 b=ESE/M2yy9i78x8aMv7r0XMTiowyXov7Cd6MGF6Nk1QZfflWs5EUr4oMdKBlYtOTzRbahqdjUgDN1txEMvEnUAqXv5YPQmg56MoIetGCr0pDSBdsGOP06NOEtHWotySFmgIQ0ijqxRfSPfSK41oV1M46bWEHdHkBzO+oYwjwxp1M=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 01:26:52 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491%7]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 01:26:52 +0000
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
Message-ID: <d6d0c3f2-5b7f-9314-2fb0-1ec2f85a270e@oracle.com>
Date:   Wed, 13 Oct 2021 18:26:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20211006203710.13326-1-michael.roth@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0212.namprd04.prod.outlook.com
 (2603:10b6:806:127::7) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SN7PR04CA0212.namprd04.prod.outlook.com (2603:10b6:806:127::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 01:26:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2889708-bbe3-44f5-a4cd-08d98eb1b337
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4684AAC6132291F92C4BFC0481B89@SA2PR10MB4684.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DYrtBbVLmcylB6LcVg5MzkWUnIdM+9azsKOnoqfJijSeS1U2P35rUHqoZpIHx41RBysydQGcLdbQRQC7gLKdSsdDEYQKyuITgeiChmlhesgcdQznvpNFQ2P+C2Md4p6AP7vABvPMyb9szVw8A83kmNHMzk0CUodue3VcNWwB2dwx2aj/QTKziaghLJBaBTgeqLVVFmUXEYOmoJ/GSoYYkciYEqdJtew1LjSUD2xj+R2whEgQvp90KB0Lim0joZruELNBWdbZsRW2MqIovZCZVJ2XHHlYXcxAzcTncH7Gu44i+wMuwouTqJV6J8L5cJd5XKDbfi5oWYt27GwXJkH3wt7BtYwSIPkgLk+n6ibkAQuuQDZIDC62rVf3HgqmiXCCWnD+14o7aOFJUXmHjw5hVK06Rx1oDK+zXf8lpj38z2fOh7K54KH59zpeWjvGo15rvrHB3OHdosB2GFqUzLPvaqo0eWH81SKPUUIHghBbQy0EcMfpkQ1z/4buLgrydm1UaCkOeHPA+SKS9FF3PnJ0wopyPpEiDmri3xy+T34J4MGFIoJhXBFtIF8UFGbWaJ3TD7ReLboep2cVSyk1eqQbkW51kXFIAW3t1+8Bbdrcain6VQuXYh18tjJR9M2VE0jnvvo5x65ejbXmVJv6Tk/7HdCl/70jsNz9YsBj7yg67Bk9LlGIQq09cUvfVALP4hRMaEwPESlwWa6Lx5HcY5t3huX7pynHjgqc1R6Skn/ens=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(7416002)(6512007)(66556008)(508600001)(36756003)(2616005)(5660300002)(6486002)(2906002)(83380400001)(186003)(316002)(30864003)(8936002)(66946007)(8676002)(44832011)(86362001)(38100700002)(66476007)(6506007)(53546011)(31686004)(31696002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0RFVXRrY3JMT3o3ajFOeUxKRTRKZW15M0FmQ2VqdXExQlBCS0tuUHZ0MXpU?=
 =?utf-8?B?RVdHNHBlc0JFY2kxV2FTcHJraHNneHhlRERUekk4TWZnd2RkcVFDSGtvQ3F5?=
 =?utf-8?B?UmE5Y1dWL3E2WnFDUFJWT2h1eThWazRVU2UwbGdhWFFkYUdjY1ZqZThjZElr?=
 =?utf-8?B?MllhZmpjc2VuSkU4eGE2WDNlNEpYY0hrcFdXbFlJT2x0UnZzT0t3RFdMNE9V?=
 =?utf-8?B?NmpwMk5vRmJQWHhNRDdaQk0wY1M2U3hsVXJDelAwU1cyOVB3bnluNnlDeVNt?=
 =?utf-8?B?U2dJSThHUFF0YjNoVFNremdMUTFwK2FRd1QwekJBRm5YaFdxUUY3SVlnaXc3?=
 =?utf-8?B?SG9MMm9pN1NFczBWZjhyMVZMdlltclFxZEhsUWlTUlNDME8rUVN3dlppSEVl?=
 =?utf-8?B?cUo4cXFCMnVxL3ZBd2lFYzNRN25iN0lsUnM4ayt3a1VhRC9EdVpad0NJOVAw?=
 =?utf-8?B?dU1jWmorYTNyRDVJYVRmMFNNK0I2T2UyS0VlOG1ZZFYzM3ZxOTZtclgrNW1C?=
 =?utf-8?B?alYwWHliS3R0ZW9jYlVYcFhqc3VjWGFGRmsxc1Y4TjY0NW05ck1GV093UXZP?=
 =?utf-8?B?cllTWW5LVnl3ZU9jM2Z1ZnRReHZIMEV5d0pxMDRMbWdiOXNLc2xiM3VJNDIr?=
 =?utf-8?B?MFgyK1ZEK2FDSFlUQ0poTllOSFppMStYY0dyOVM0cC9sVHltUG1HWG5zYWN3?=
 =?utf-8?B?UjRydjhLQ09zWnJxNmFrRklPeG1VbzZpTzZ2Qkl3MlRYcVVxRmx5T0x6NTdW?=
 =?utf-8?B?VTVXOVVuc3JEaTBRWnZ5OFhnZVJmelRSSGRjTUtoYjNFNGY5UW52NVE4Zm1W?=
 =?utf-8?B?UjltTERKQkZaNHJ6MmIvYThXTEY0dWhLMXJVNHNHZ0JpVUJ1cmJZdWNNbkpX?=
 =?utf-8?B?UCswUjFKMEtvY3BFbXV0aER0T1JWOU1zM3MrM2Yrd01xYllUT2RueElCV1I3?=
 =?utf-8?B?cVhIV045LzJWb20rVlM2NFZtNFBGTXRVbEVaT3EycFJsbmx5MUhuUDNhQlkw?=
 =?utf-8?B?MnVnNklaM2dsdStOdm1FOFhiVGdDZGNEVHhPVVljeTdxQzJLVVYwNk5tZC9B?=
 =?utf-8?B?RnR1RytoUGRKUHM2TzFUaFVjNkIrNU5KQXpISnZlc2RaVWIzS3ZiWHRleTFH?=
 =?utf-8?B?bjV0cWhmUTdaeUt4S0hSaWhaTEhWQUN1N29sQXdGWVFZTjlxeFdpeHBKRXpy?=
 =?utf-8?B?VWZmK3BKRWhNWG1ucjNCVmkzSFZsenBNQTNZWnh5NG5uRTI0NWZOYnJxcWV6?=
 =?utf-8?B?T3pGS1dEVmpSSUFJbzgwcEkyQUVRM3VLV2l3b2Y5T0EwTG45NjBsNi9TZ2t0?=
 =?utf-8?B?ZGduNElLbTRlbTEvRS9zYXM2ejFtS28rRGFCOVFyekFYbENFMnJHTDE2cUdD?=
 =?utf-8?B?dzZ3UFFyOVZna0gxQytQRXVFTHhka1BCbUlhY0VsWnhEWVNLaWZhT3VFa3Ns?=
 =?utf-8?B?OHpSaE56MHBraXlTeFl5NVlFUWdHenFyN1h5K1EyN2NjeXEvV2dtOFhiOE44?=
 =?utf-8?B?SFJPcVVjNGFqL08wMFZOWDQyM1oweFQwKzhnbnlmL0lqUTFBbUJtS1lwV0U1?=
 =?utf-8?B?bzJkYzNaTkVJUHAxZnVZVG1KOE9YbFFvbmRTWk1vWWdBdE1IT204cE5qcGRD?=
 =?utf-8?B?ZFFJL29zZVF2Tmt4cHJnMnQyelg1TUJ1T3VFVmh1SXJkTnQ5d3owUFg4MjJ5?=
 =?utf-8?B?OU9scVBDRXdHaHFGRHpQK1hwYTkzbDlXMUtRd0o1Zm5ybjhHUDNXQXR3QWhE?=
 =?utf-8?B?MWt6R3VveDVoUUUxY0JiTUVNbkZnR0tPNUEvcTBDMTFDcHdtVWFRYjZMc3hH?=
 =?utf-8?B?RXdiMmdPNFFsK2RrQ0xKZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2889708-bbe3-44f5-a4cd-08d98eb1b337
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 01:26:51.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGnqikqFkLAublDC6Rb6INzR2xl1Hzp/HsYK347/KodiWzJMUKPSzoeHESmK0EqHTRXZ0bQV9cCyUZnwW1YZ7gSLAB3tSNHj1CelVtx7MpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4684
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110140007
X-Proofpoint-ORIG-GUID: puZ765FFirwWQUFIn3WJTh7s6lyfmtRE
X-Proofpoint-GUID: puZ765FFirwWQUFIn3WJTh7s6lyfmtRE
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


Since 'region' is used in every naming, it's better to call it 
sev_register_user_region or sev_register_userspace_region for the sake 
of consistency.

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


vm_get_encrypted_phy_pages() allocates a duplicate sparsebit. I am 
wondering if it is possible for the function to just give a pointer to 
'region->encrypted_phy_pages' so the allocation and freeing of memory 
can be avoided.

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


Can there be a better name like, sev_vm_alloc because it's essentially 
allocating and initializing a sev_vm data structure.

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
