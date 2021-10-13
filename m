Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9A42B257
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 03:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhJMBsJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 21:48:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55896 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230402AbhJMBsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 21:48:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D0WcG9023311;
        Wed, 13 Oct 2021 01:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LqfUY0FqKTovrirAZ2FM9aDm4Raca8+qROzfjMZurDc=;
 b=b2In9Ysp/byMtWt6PArPImNdres3Ir3Fh6rDxodSA59oVPjarQKE8q4LjqbZlBTnsOLK
 TP1ckG0CV01aC4XN4xwxWYoFDGP9kk46J/lgOdtf5f3B2AoSVMgwnNb0aKEqw/yjZY2m
 Opi83q/qhQYD6VUnPW4DbGHG/vmPcD9oat0A0dESJFlcaor6hyks7ca0J8otMJTgZe/0
 QRxEa6KbonhAvu9tpStIGjONs7nUD7khbbxrp8+SX6B2JfkLDsVPzYcfUudQNtaY5C0H
 ziYo2kE93OZTJXobivM/WqXWqEf8Mq+g4vbBWeF6ZcgBQnM7koz6ZpSGAVcg4iccG5wS /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbj0pxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 01:45:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D1j8EK055081;
        Wed, 13 Oct 2021 01:45:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 3bkyvb6nr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 01:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7nv7c6l+WQrOtDb65F8sJL0yeRk1qVOv2j1gDT5ARjoY0fP0rq434hLBSr1UTydDUS+Yh/cKBGhbjgoQHkPrF8qdMdZB2XzS+pfs25ucpwfLXbcEkmJo7DLG6vUvEgZwij2zNJPaYwUGlPvcSQEvW2owZ90D7GYb5Gr99m6LX3mxeS4574tVsg6POxsNHTlImGZ8lE7oftIcTUVYFpUtCZvF8Es/NC49Ch1WepZAUOmy+EGMvBVlIKLEYK8NVZs9mt1feUY5bFHdt3QpaHWjA2+EKHrSeFFLKuDGd8tF0txV3V210b3909Fepz+PErVn7tDalLaSf2+eSJ26vt2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqfUY0FqKTovrirAZ2FM9aDm4Raca8+qROzfjMZurDc=;
 b=AhYyKsG1TchD5uP1WeIQYsTb4kkE1JB3Wglni2OsCMabrn2hk52qU+nW05huiuaEujpJyUa9/s2TzYwuV0/ToqQR78Pfl3Ukl7k4kdZ4W5P+FusU44kItVSZWlz4o207SJ5sYKn8afNZTFmGxzeKorqDtMz7c6mg6uexr+j0+6BP6jCqCHpQm11nhl1JG1cRcXSprbObCruPn2vEEBhNfG2d3Z5H0jvrARHp4tD2Q835tL4KB6Gco7yE2w5XFsWmsZIID/pxLlQQmeO6lfaFkClxlsTF/UpasB6yz7u+2CkgGlrQ7UMRQbomS6RZ6XmFgaHRPh4PQU3XgL1waPtaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqfUY0FqKTovrirAZ2FM9aDm4Raca8+qROzfjMZurDc=;
 b=RINf2jHXCyxBvaSt5S2k+brwpVOwD0B/+Bdxh4207VMGlwdPsSxiiZnRVTQ5FddSDMIp+SteyUIQwxctcywYrEsMia2nBDVAalWJYxk7H6wVRWQbtz+R3NkJJu+MBpVSiq00Xw3x0t4j8jY9Fjq68quCWdpIK/vmd5t7KsXpvZ4=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SN6PR10MB2910.namprd10.prod.outlook.com (2603:10b6:805:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 01:45:14 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::f12a:c57a:88a7:2491%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 01:45:14 +0000
Subject: Re: [RFC 04/16] KVM: selftests: set CPUID before setting sregs in
 vcpu creation
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
 <20211006203617.13045-1-michael.roth@amd.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <29aa85d5-fcc7-bf25-dd04-2476dc7b6241@oracle.com>
Date:   Tue, 12 Oct 2021 18:45:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20211006203617.13045-1-michael.roth@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:806:21::34) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by SA9PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.10 via Frontend Transport; Wed, 13 Oct 2021 01:45:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d1d21f-5576-4308-5268-08d98deb19a6
X-MS-TrafficTypeDiagnostic: SN6PR10MB2910:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2910281CD8DE9437CE5E003981B79@SN6PR10MB2910.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oENTTioCqWt727MhK3VQptny3zinWqw5fpypvqwa4GanGk2zqFJZmpXPRBmmPIX7/CYMEF3v37gqIlDH//2H1yVHbiUTD5WO0BsZcM9Riz4OMQJpHfJkPHdYbsh3HcC9bAQ9ROLiKnpabvnmgRaBBuJ79B5Vt3tFM19/CeVbkEhEjz3R18nr335LXttlLSMLD+luwlcczbM+okcI18zpEcXPu3yyYgkDnuLrlmzg0/8DRz6F21ZidSPtuulRjxjbHCIdGTbjkL9nof7j4ReO6Cf7UM1e6oP67eKCmPujsCU5kuBXgz8EPMerxst1PUzAovE3H9hBeEEn53w0waerN21iQs9JFg8qoRasDIFuOeDMBOB5HMTJ47hiD3ARi8v5BgySZ8mSNsl1HIBEp1HHzc6XUJn17u9UNJTyna7d7rkBw+C4MaMpHm1lBlj8XWq5gKvJ4aInGp3F7fSuDjdaCwu/HxpU0CLO2/gsITqvirq4759TsZxYv2pqwDmis7n8dkA7VcO4aPBpwr6BmZDSulrhpKZ7QtLWUyRikIEUz7OtVeZn0ydD76Z+o4kf6Z7/WfUCWINzMqLNQrXIHsosAJjjBg9l0JZaxzpt3k8zGmWckA9K/37E65TER+By5kVGOjBCbR6/fUxMvfwYZ6OfQoT6ASVeZu7FYDm/nzWs7HyT0CuS7DXv2Xg8bKTi0CXLRcV7q2wk0I0EbLb7+YqIZj2cPNM/BEyeIEOQVnY+pdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3021.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(8936002)(53546011)(186003)(8676002)(316002)(6506007)(2906002)(36756003)(6486002)(2616005)(508600001)(4744005)(38100700002)(5660300002)(86362001)(66476007)(66556008)(66946007)(54906003)(31696002)(7416002)(4326008)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFxaW5PWmtHWnIzcXRic0t5QW5yOU1rcCt0RDdaMDZvNkorWnQzMXJDaldz?=
 =?utf-8?B?dys1dHNqSkhCMjdrOGU5ZFBiZnZRTkFqemZqMzBDSVNRSFM4dWJtd2ZoU1hp?=
 =?utf-8?B?UDFhci9FdGIxZm5CZHNhOW0vOTdoaDRKOWo3VzdoeFBEWThmVEt3MXlVVWRS?=
 =?utf-8?B?aEJHY0dTTWhZM2RVeFptZUQ4WXArY2l3dktrM2R4NVRxdHM5NjNGSGQrUVhm?=
 =?utf-8?B?VG1aWHh2Q290blk5SjlCSW1kOHVZOWpuTW0vU0JiR0c3QU5XL2piUzFvaVQ1?=
 =?utf-8?B?SHNjck5FU1NvWCtyU2Zxb1lVSUUrYXc4eGd0YnNnWXdtUnUrRUxIK0FxZVFF?=
 =?utf-8?B?L1dYV2swRHl0S0diUTQyU2FTTXhRckpFQ0Frd2FTYVVweFMvYjZKMTZpNlBm?=
 =?utf-8?B?UURYTU9YQmEvMklEa0tEMXUrVXdUWnlwS2pPVis0U0I0dDNWWFNzbG02Ym4v?=
 =?utf-8?B?S2JOQnVGVDhVbk0ySkxDRWVtS3R3c3VtU3ZCMEtkRzdkN0szcEdGQWlXS2FW?=
 =?utf-8?B?Q0EvNTcrem1YVFM3YkZOWmtMY3lzeWc3Y2hqTTRLMDVnYnZ5a3BLZ2hmQVFF?=
 =?utf-8?B?ZWo3R1ppa25VeHdldXNJaU9qeWorTC92cDcwVTFCZXppOUdKbitEQ3ZDYzFX?=
 =?utf-8?B?UE1udTEycHRJL0ZnanAzbWRNMFhwZzNzcVUva1dsNTJJeTJXTzkyNlQybGZp?=
 =?utf-8?B?Z2daL0tpUVRseEh5TkJSWCtxNUVTdDIzWUV5S2xSMlpTditnd1JhMm1rbHFW?=
 =?utf-8?B?Z0p3ZFg2cVdaYkY0VG96Q0xoUFdnVXpBOWVDWE1uc01ad3RjUUM0YjdlaTMw?=
 =?utf-8?B?ZGhjeS9uL1lJaHd0T2VTTDluV1pQZkU1YU9DSDhJdzhQS1VWRmFodk5XQkpZ?=
 =?utf-8?B?WnprN2crczU3QVZyNE1pT2ZrV1NUV2J2TnBxYzVodkgxcHJhYklpQXV6b2p2?=
 =?utf-8?B?MnBNU05JSkZhOWcyR0JMV2xVaW1qUHJGQmNadHNSYldHaDRYdzlQNFRKWm9D?=
 =?utf-8?B?RGlRR2VtQ1hqbVlGaGZrWEJtakdqTDNDenRJdHM1UjF6a3JDUVg4TFhXYU1q?=
 =?utf-8?B?bWFIZ0VaTVNUYVZWNEEwWmxrNDlJOGFFRXNBSC9wUkFDOGZUY0hPZkRzQWl1?=
 =?utf-8?B?bDNzVisvK3BkS1piS0hmc1BrTnZ0MDdWeEt0YnRnTHN5K1MzTHc2VStDMnZT?=
 =?utf-8?B?eEV0NDdieWc1TEVxNVRTbWFibC8wZlZuZVY0dDRmSjYvcTJ2VS9RK1pqM0dp?=
 =?utf-8?B?OEgreWp2QURsVWZiZTJya2lWMVEzQ2o5ZElRZGJLQW9Ba3orMEE3VXhCaUVM?=
 =?utf-8?B?NURSNUNJd3FWMjNjNC9YVllXTG13M3BPTysvY1hBemIwbkVBS0w1ak9tNW9s?=
 =?utf-8?B?U2hYYU00cStpQm5XUWdSbG95d3hxWVFWTVF4cHN2aVhER0ZCUzQ1Y2plaHJI?=
 =?utf-8?B?RU1NMnBHamwzVUEzUUMrQTN0VVI3bnc0b1E0YUxnVGFxN2dCaTZXYTh0M2t6?=
 =?utf-8?B?SVdxNXVSaHFnVytHWmFic3J6RjcxeUNwTzN3aWJBQVNWQU52aEVlbVpTbFd4?=
 =?utf-8?B?WDZ0TzZQRFJNMkF1cWNOSzdMMWhpeXBIUEUwOUxmTnN2UHkzM0U2djlncU8x?=
 =?utf-8?B?OUJ4cCtKT2pKSzJjVVJyMHVPWVNscDhaSG16T1pEeEtKcnNzajlCSFZob0w4?=
 =?utf-8?B?bmpxbHNCK3FnY2JjRHBtWmc4czFBdGhRVDZmV3BFdHJmT09PWURWMW5aMkw0?=
 =?utf-8?B?WHFQWEwyV2duUEZteFJhdHdIVHdkVVFlWmlqNm52TzRNTTBQYjk1Z0hvVThP?=
 =?utf-8?B?RUwrSmFOdlYweExHbzBMdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d1d21f-5576-4308-5268-08d98deb19a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 01:45:13.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A8TeKK1Bz+i8zWFQm7dIVCwvax2iztPGxOeKj1dXSkJRhp92vnOQQx4dGGJA9ws/s+Q38kyR/D8Xbe0YY504+56XodJHArS6ZcmtNDzczM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2910
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=787
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130008
X-Proofpoint-ORIG-GUID: uTf5vghR-yLHGzL-fJGQiCONy-bxlNc3
X-Proofpoint-GUID: uTf5vghR-yLHGzL-fJGQiCONy-bxlNc3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/6/21 1:36 PM, Michael Roth wrote:
> KVM_SET_CPUID*, but kselftests currently call KVM_SET_SREGS as part of
> vm_vcpu_add_default(),*prior*  to vCPU creation, so there's no
> opportunity to call KVM_SET_CPUID* in advance. As a result,
In the current code, I see that KVM_SET_SREGS is called by vcpu_setup() 
which is called after vm_vcpu_add() that calls KVM_CREATE_VCPU. Since 
you mentioned "prior", I wanted to check if the wording was wrong or if 
I missed something.
