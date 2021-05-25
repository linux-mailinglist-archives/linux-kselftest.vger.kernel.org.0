Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81428390C21
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 00:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhEYW0H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 18:26:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34052 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230375AbhEYW0G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 18:26:06 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PMGDWg030484;
        Tue, 25 May 2021 22:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=u+6sMU1mTqzFWbADW4DhKpvi74aDVxkiu2DiuMt4q9M=;
 b=bzrKI/81xyj7nbczDNps+fF3Itygjt0reGWjh5DfGOmXtbNjasa2XHS/qeT4fNmH7X6E
 a3Dnqypmfve9amItHPgCr2YD7xGE/0sZkgTw+2V/lPimr4MMM6tV2DAGENMQdhW6GQ+Q
 PrRzfN1cdg2/XvBRkgfD5s3zSq4Cd36jQR/+YTXg8QZmIeOCK8QN0Gh5TBuGPxeVmTw1
 af4XdnNoVdu1NYkP6imB9JVt/Q0BbakQKBqJn3IU8WSOPJdjF6FDZWYHSopUXU34JuCF
 vKpZJGbQaH8IV+9XSxWcj4KHfCl6aJ47WYL1o7oaOZFuoe1qoLAigZn/Y+oZ2NwjoBVJ 6g== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38r9t10nsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 22:23:06 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14PMN4S2064381;
        Tue, 25 May 2021 22:23:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by userp3020.oracle.com with ESMTP id 38qbqsnt6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 22:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwdtpqLnQCwl2TVVt0OxSENrKHhXSG+/b6TriHKAce+LsByJ0F4xRuQ+zu1TcQsezRLvQiKKzOm7KKgiUL/VwMrvTeFR0u1SSqmj2ysAtAZduMREDFSvQp9be7okh8Y/Pqr6tsj7v98Izv6T+i22ZRxTzfzO3DycKG8656c34JSy9juqL93msrj1ppVNqfIUh7cKx5v0IC5rhL2hg2C/YeL7K0iKnLPMrZyhDD3hsqHczLeSmSNT64BmzsM7fLYpVONKRE9iuekn34X0vv5bS3Is2ue68oyYja4xbu0mtBoIH9WyqQbCVKqKGyQnsXwemRDf8zD0IeG830+q9lPa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+6sMU1mTqzFWbADW4DhKpvi74aDVxkiu2DiuMt4q9M=;
 b=ajzMA0tjGc4ztvy2AKYWEcIRt/Nx1hbnRICiSCy2o0M2K8SgzfXoM8PnG+owlBuzMOqWPDWLql8d0ipqTCKwOKsqSEaISMXCIsPjcBN0EdR89Rt+IAFOut4l35aXcNWyeR/f/QQt0r5FjRhMnDsjIR3Wy4g1RHupYVY0s1LMSgfD3Bw2r+KSl+ob1pQ5cprGFuh/YV69ynGrY3+8zDR6Zver7xi55t2T4tcuSt61sn5pp+MoKHKVsQk15rjo5lQ+2JMOpyBwyue0AIvhASVHfwHHqyNPmOAhqr2K80j3bZSymfx1x6op1KEGJMOOC77HA/oKxPv4D26nzsMrd/XgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+6sMU1mTqzFWbADW4DhKpvi74aDVxkiu2DiuMt4q9M=;
 b=M/TQtJacnE7aQwg/dLvmXYifD40cs+lwe9Y84fi3ohbNE41E9ZkAaNH0m9uDx8gSIcqOrFvZKKRHblxOlAgFSPMHtat+LqJanbXoaA6MqcYbKawKGD6dy1qvb4/EpJ8iC5XHuV6j+tMM8bEMi78gAjVO3se7HSSQo24zZp6IUiQ=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH0PR10MB5145.namprd10.prod.outlook.com (2603:10b6:610:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 22:23:02 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517%5]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 22:23:02 +0000
Subject: Re: x86/fpu/xsave: protection key test failures
To:     Dave Hansen <dave.hansen@intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, shuah@kernel.org, jroedel@suse.de,
        ubizjak@gmail.com, viro@zeniv.linux.org.uk, jpa@git.mail.kapsi.fi,
        fenghua.yu@intel.com, kan.liang@linux.intel.com,
        akpm@linux-foundation.org, rppt@kernel.org, Fan_Yang@sjtu.edu.cn,
        anshuman.khandual@arm.com, b.thiel@posteo.de, jgross@suse.com,
        keescook@chromium.org, seanjc@google.com, mh@glandium.org,
        sashal@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        0x7f454c46@gmail.com, jhubbard@nvidia.com, sandipan@linux.ibm.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        suxingxing@loongson.cn, harish@linux.ibm.com,
        rong.a.chen@intel.com, linuxram@us.ibm.com, bauerman@linux.ibm.com
References: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
 <7a407363-e074-aa84-3ca1-909b497122aa@intel.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <18af2b84-b350-6bde-9aef-c0266d604e4a@oracle.com>
Date:   Tue, 25 May 2021 17:22:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <7a407363-e074-aa84-3ca1-909b497122aa@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SN7PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:806:125::14) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SN7PR04CA0159.namprd04.prod.outlook.com (2603:10b6:806:125::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 22:22:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d923a3-8a0d-47e7-873d-08d91fcba8ca
X-MS-TrafficTypeDiagnostic: CH0PR10MB5145:
X-Microsoft-Antispam-PRVS: <CH0PR10MB514575B89B258D7A84BE888887259@CH0PR10MB5145.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA7lQvC8/xAc+MSjKL9Cy53DafS2n9QCPa+WS/8rLBfJsTcDE5Lo0Rz1fe++KzAp3fDCDOk4RiBOzzUSqgrjDJtHKy4dR0nZEBE4ybAzhvBxgDz0dVuG4DO/zcD8sOYsK/61oMnReKht76g0Ccg8uzd/p6rmUGUeLjiT1rpnY4Y4LmW9cs5WCA6+yUyCFCb+DsKAel1dGCfGJgIk+IHIUWr5kQNpXVnKqEt6upY48E6rp04LYCK/K08CYw4dDR/0OQxRiF1NLLHIb/2POEEcA1tY+AbJ3LxZ9pcENUxS/OG+PNIHhElvJYyj1KH4WvG0tmpPFGCRbUSsik1Rpa7t04QElUohcC79tmbkpjKNYOdiaI8qB5zbQBJzByCU1O0mO5S1Hd87//MTyoch5N3CtY0k2ZqiDoBhcJ9jD0rHJrD6SJYx9hhkBQhuiuH56usLYxdbGb7q3kbagqnkEIaTCRW9D9QLajsOF7ZX8kHVP9n5Yf+rW75VtpOgbdvXSgsHum8+QNxWGLL2zIX4DtEGpROgfjZrPw4cxLTWpG+MpGLZ/VumQItTx7lj+Bmtdj59e7GG/S5zd/hfNzz7MPRCRDWuACCIOGiFF6oZoUAEFJctttb2Ir0IgYKK6J25nid7pYvvJ8t2yOfx3a64mFVzCRiaPYV8R+YJGMD6YmVc+Zz1h7Ut39R7dK02fLycoJuS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(83380400001)(7416002)(478600001)(8676002)(38100700002)(6486002)(5660300002)(7406005)(31686004)(86362001)(53546011)(316002)(66476007)(66946007)(66556008)(31696002)(2906002)(110136005)(16576012)(36756003)(26005)(956004)(44832011)(2616005)(16526019)(8936002)(4326008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?jJ90E35mtt82pYmYotYBCAmHtL1Bn3PZsseWeCvWRVJWjGuMgGfa6LOQ?=
 =?Windows-1252?Q?6dnsMEzhZcz8FaCPPqWgCDSPYdf2DkUICZ2+a3o4qAySjtTAX0C3cM/k?=
 =?Windows-1252?Q?Nc2a4WEPUtGXxt2vZiPJdIFJrioR7Hrsi2Z4Tl5lJD8CYfhTK0rT0Ve2?=
 =?Windows-1252?Q?Rn9rSLs3YANvNWVEEeWBsLsP9ion4T66VFXdoiqyUi2b62qGWwV5SA2p?=
 =?Windows-1252?Q?7wUh9qSV+6o/kB+Kt1fKVjct1Y8o3CZ+Rtmw/e6oDNxjZUs9xIemycNr?=
 =?Windows-1252?Q?jnv6fOTJVL07o4f9ZgJr71gd29EODaJPcBLBcCX8kbT9NcUipVOA9Zb0?=
 =?Windows-1252?Q?atJk7xgtfE93YBk4oKewAwOVrS9nBXQzb/3WsiDWThxZsU4rw929Z3SG?=
 =?Windows-1252?Q?Jr5821wQWqUcUNDwv0LYFCjKJYFI9VwFwrDWj7Uf9FHxQD0x405m6aax?=
 =?Windows-1252?Q?s2CvQlgUmBTPYb8wNARPu9MMES2DAshq3qmM1NsqFhoB57aPmJi1x0UN?=
 =?Windows-1252?Q?kL4zNKuUs2ugCGJWWXOrMtrCiUKtAwwtlXYnlBVEZkg1MrHsMQwmFdVJ?=
 =?Windows-1252?Q?qJwqsgoGQNOEFsiNWmtXZhSzpE1zJa97U34XTp3h8XvLicIBT5jXMJSh?=
 =?Windows-1252?Q?11oJjqsH1IZV1CE/dfhc2rkyiHHABFHuKghWTZPo2Bckn5QMWYtp8tdJ?=
 =?Windows-1252?Q?OmuaKm/lScSorWEKrc1PnCmoNHGyhL/LIsiG+uaMUZswaOzck/fqvxgb?=
 =?Windows-1252?Q?fYSScOvOkFk+V4LGuhI+uMrz5eHm/2p6/RMPIgr09qAnYeFG06XkZc0Q?=
 =?Windows-1252?Q?phTc9rjfjjW+vv5KkA4WfEacfQ3LNNU+3mZouPJOtVvPPl3MY/WGr/J1?=
 =?Windows-1252?Q?7fRw0BJDaabhJErQhl69a7/s5CfpB096Z63RQ9yXpo+UklrwWOovh1h0?=
 =?Windows-1252?Q?7CjR7CilhLY+Og5BzFyVytj/nWc1l1TkyxGiLAcK48NKxJTSc4HMDiUF?=
 =?Windows-1252?Q?47MMZfaz7wfKaryaCMdsn9RVpnxJR5wmC2/yfpkk5+ptSIIhVsyLAEgj?=
 =?Windows-1252?Q?i7+8EPUqVNWEnvocEwEya+Gm1anej82JN0HCW5yFv9bHfcvXuBZ1u9aP?=
 =?Windows-1252?Q?QCYCyOquG08NZ/xJjO19AgKcwjbs/DC+kPBNPl1V0roXcsKb1IpGptez?=
 =?Windows-1252?Q?wstZwBR5oW2OASyk/0Hve4I5C71ZibxTvCRPvQk0mx6Xv/Rnib7JJvYn?=
 =?Windows-1252?Q?9/ut35iaHkyUIpokgg+wQPze9228MDcuIUFVFxRSIOHah+6oP8jTumX9?=
 =?Windows-1252?Q?b45XOnv5XLiWeCNBhD67aWJLRY7E7LF+k+dqQknvreQFaSk+8f9ktKPL?=
 =?Windows-1252?Q?TP7I5IQSP0ragXpxrnbrYWUX6vZk6Ycj701R5XUsP3SNCq+HrsBnRlyQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d923a3-8a0d-47e7-873d-08d91fcba8ca
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 22:23:02.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js8DWaYgf+iFICjiwErwHsO1PmdTtY8xo4h8p4opSo4viDI3O0Q0ZM/NdpEEgkusUL7gMYzPgw5NrVc7UqynbMDgA4g2PDTA219t9iH5q1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250138
X-Proofpoint-ORIG-GUID: 0lZCE3uplevUrIXzjT-9SB0N9Shphtp6
X-Proofpoint-GUID: 0lZCE3uplevUrIXzjT-9SB0N9Shphtp6
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/21 5:18 PM, Dave Hansen wrote:
> On 5/25/21 2:37 PM, Babu Moger wrote:
>> My suspicion at this point is towards the selftest tool protection_keys.c.
>> I will keep looking. Any feedback would be much appreciated to debug further.
> 
> The pkey selftest code that pokes at the signal stack is rather hackish.
>   If I had to guess, I'd suspect that PKRU ends up in there in a slightly
> different place than on Intel CPUs.
> 
> One oddity is that xfeatures seems to lose its pkey bit somewhere:
> 
>>   protection_keys-17350 [035] 59275.834197: x86_fpu_copy_src:     	x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
>>   protection_keys-17350 [035] 59275.834197: x86_fpu_copy_dst:     	x86/fpu: 0xffff93d722877800 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207
> 
> The only legitimate way that can happen (on Intel at least) is an XRSTOR
> that brings PKRU back to the init state.  That would destroy all
> meaningful PKRU state, unless PKRU=0, which it almost never does on Linux.
> 
> What values do PKRU and the shadow have when the test fails?  Is PKRU 0?
>   Any idea how xfeatures&0x200 got clear?

I did observe that PKRU is 0 right before the failure.

Shouldn't this still be a valid value?
