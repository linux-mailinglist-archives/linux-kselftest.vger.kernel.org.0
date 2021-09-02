Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB673FECE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhIBL0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 07:26:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3776 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233850AbhIBL0j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 07:26:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182AvqDT029916;
        Thu, 2 Sep 2021 11:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bMivpNKdwQijQtZdNwiAuq4UrcxGOu86zctUhW4blIM=;
 b=PqaxiqECFaCEM5l5teMAnIat3s5OT+67Tig49lawLRyTya84jMuuHSMUp8+lAUDYDTTs
 DmHQf6mBDLRRtGac2YKXOmCsZ1qJnxKmyE5h9RBaXU/el/s+32m5TfhXkCZkmQ6tNpLd
 oRkVcMUXFN2iko/VVOw72vVzxt/u4LrborKIogDokPGmAA6ut+OD70sERinV7Z9YBnVf
 bD6Z7FIxyG+mYp3kYohZdqS4Tcj5lSqJzEEhEHOv4VVHaQFuNItw5ZL6muUxpAl362Q0
 DqNg1tzGeBwo2bxn4+/iNLZSPf4kbnxftFHtYeoxromspnm3xeruiFLcGELVQak+84HS SQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bMivpNKdwQijQtZdNwiAuq4UrcxGOu86zctUhW4blIM=;
 b=BIMNN1vnAlxbV/Ed3syPhAGwYCrExPs2guX15nrvulGPVxgoZhe1MxjJ7ttZbCALDAnC
 64QBZW6ddZg1t7XQYz1ibJ2Js2nctcBEeLPLvnwNr8LkWYtrejila91+asyk22YtXnV8
 8NsS1jguQLOiuuhsJB6lKJzk/bPGUJ5CO3Fv7vlDeNJajCPL/8IDfI9xxvTZtXa0oKwS
 Im85mqPQ8YO2j1ZzCOUd1wF/hfXWFPdFNSidjEbfnXPUvMdkNp9U5gL7sEi1Roph36iA
 Q6dvYBaWZ8ydfapPDqppu9rsA/KP7a8dLpCLP81OxLetN2bWjvHXEmMGIpZ+lK1LLI12 ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw02cpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 11:25:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182BFrhi095406;
        Thu, 2 Sep 2021 11:25:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3030.oracle.com with ESMTP id 3atdywuku1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 11:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEIunnHbxzw7mLvA08GVcVX9btE6+DynxNxxKZtC82WqGD706tDvL+f+p2B0P0S5x4RP6mNTxCLDPZpI4ez79/87zWrSuO5Ce3baTjqhgrComDj3LVCLHcKIbIrCM7xjjSqg96Oy0+4yGy0KUMw/XG7nRAEfZR8EcRiF1Bq4A89x7b4skivx3OwaVqmCFIFgft0Z+hCa5soaFvQdj1qrMQXxqV6T1jp7ZIOaTSO1uaY+vSusvSqh7WiQM6+RcJtfnnEkQD7lC1EV+ByJByyeDI+OaWFz3OQRV3uli+XY6elWqbYZsAYMudYyuLviuhb1PFbT+aHXEmctmETZRAnEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bMivpNKdwQijQtZdNwiAuq4UrcxGOu86zctUhW4blIM=;
 b=GT4CeKvYMiDp42CBmBbsvceHtq9ine+F5iNTnxMsco3aumXwPTEmOyHvtW2HIEkjIfAKJNtx4gCEK1c3TdhaqDlYT34QeBBv7Ghv8DOnXYYiRe+VA1bN5FyJJ7RF70yY7YpwJYs9x4xIpN+ZxeTF7aKqvV3YDVTeeG9Sd6GQM8GuXMvOU2v2dLZCw2ZqbHP1WSpeEQKh2N1HAt6yMIKhYHcU9zc7O13Dl/euPglRxTO0ImQ23myy2sV5lSc0jk/SKkyJLHYq7vO6KOwuF6j/6BW1TA9ZQIju3iWeUTyOfd4Iy3ApyiQvtWOVL2ISvJOL1QYz1m4Fl9cEJBs5czWLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMivpNKdwQijQtZdNwiAuq4UrcxGOu86zctUhW4blIM=;
 b=O1OiQZNlCJ+Uby5juyL3n5DNsuF83RrfD2cV8zrJzqYf+qLJ0Y0spu7jgwzBIqLRE3DlBrix+PHxXxCPzYnCma3d7+76ujRhqubkTCKuJLFqoWXcO6NisNsfylaASCjdFn+08AynOj/j4/aIYH37dX3Ref5LFyL6R38SQ0QGCwo=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1568.namprd10.prod.outlook.com (2603:10b6:300:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 11:25:25 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::95c2:636:f86f:c6a8]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::95c2:636:f86f:c6a8%8]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 11:25:25 +0000
Subject: Re: [PATCH] kselftests/sched: cleanup the child processes
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, peterz@infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210902024333.75983-1-lizhijian@cn.fujitsu.com>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <282b1eaf-c506-c18c-01d7-df7bdab88fef@oracle.com>
Date:   Thu, 2 Sep 2021 07:25:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20210902024333.75983-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:610:e5::21) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
Received: from [192.168.0.193] (67.242.218.156) by CH0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:610:e5::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 11:25:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bd2bec5-6071-4fd1-8a6b-08d96e045be1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1568:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1568D39F6F3521046A2CFFA89BCE9@MWHPR10MB1568.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0H4PaVog9KI3vC437bhfxxnyjxvced0NNinD3VDKDBlacTq9IwR8kUhX/BbsnrWu6UguMlDMZu/TlDpfxWTcaHGjBtHX1xuVmYjier4iDz/cuXdqxSCsoyzOdXKKynAb5gzm9w00vlOlvjiHeVhSYya5jqMmNjSG/9iXq5VWywKb4DXjdjiWl9Y4tTP279gbM+wEdKiPerxFkSfVgkksmNOjgx1O8LDu9Sd9GZDRgwbqpvWqaFwW9bgIwaTJhb5VFT1GBqHTZq4sQMZvqOuOyZKEaKR65nn2zk1xEIsh4jOjFmtr4rTYZNHDFH/CsiAfpqgA+6VznIMwQX7MsaCy6mqJhWDmPHEvqykz+CLUhlf9FOEgLM6Ub/vzciBVbQivSDfFK2k8c0eDkbX76JatNbWwv0ph2cK+ZUEbAo8mmy69nVr68P56xJ1dj3yE50XvvT6ZsOTVsQglfsX/DAYzcOnhufGvwwl3DAgogCpBlyZ+/DkaMnb/39S0qpnBJz2SBn5G/eLuVIy33x2089aLMUO066UvoRDb6Hsmmx+4Yt4jZR3QGiHH8Pfy10GlR7Bg3D0Vs/hpBQ1yb2Nx8ePEx6MOp1M/8JuTMilN16dPPl/9zZ+hC444/t+cL18Igo3n8yT9d38lfqwkYIASug8aVx00vyLwqgEYnzOb3noSUCorY21RkWFqrspTlf2nLBlEO5RBDpMDPJUWWm6zghCGtpM4+tnSWUQ8fXM61bMgjvIl5FhP0xA4AiIgwGiU20tGXQF6oqyqQJQnctHWClzsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(66946007)(66476007)(66556008)(8676002)(6666004)(478600001)(83380400001)(54906003)(52116002)(53546011)(31696002)(16576012)(316002)(86362001)(38350700002)(38100700002)(31686004)(36756003)(6486002)(44832011)(2906002)(186003)(5660300002)(8936002)(4326008)(956004)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2Urc0tzZHlXT3FQc1g2UjdTM294bnNjZjEzMFhSL0cwYVh1SEtzVEI0WFQv?=
 =?utf-8?B?bDZpSzR6SE1vTm9rSUNnMVZUc3ZrT0pZVWQ0NDN1N0NyR0NQWkVSbGZkR2pG?=
 =?utf-8?B?Z1E5RElCN2FZOXlqaVNKVCtLR1JRNmN3bGR2RVVPdjRqTzlvUnpGUjN4Q1Mw?=
 =?utf-8?B?c2RBTlBuaWlFN0NGelplK3pRNm1YcXlIbGZxNjZEb0ZiYktFRnlHbEZEOXFn?=
 =?utf-8?B?eU9SVjEzTk5kQVF5SEQzcjR6RHJEdW1mQWJ3cURZblFaRmpKancvcVRxcTRD?=
 =?utf-8?B?dlkrK1pFV2h4VUZpR2pIbWpyNEVESzl3clNWd1RGYjFaZ3dVbVVQR0lpN1dM?=
 =?utf-8?B?aWRpemJLSHppRlNtM2xCd1lWblR3K09PKytRZG1vQzdOWGpUNlZvcFMvdncv?=
 =?utf-8?B?Z3M3REZxZHBpem5RVFdsSkhxb2RvcWRUTXp1azZJOTAyaEhaNHk4UkNjdFRo?=
 =?utf-8?B?VWhMbVg0a21mbWhnam9jM3FQRnBVSjNhdCtHSUtnejBLQWhsanJOUjJ5clZ0?=
 =?utf-8?B?Tk9xbGRqS2dZRXh0TU1scUZUR2RQOTBZa3VvNU55Z3c0emZGWkIwVVZqNnJO?=
 =?utf-8?B?bEE2Z3pqYTRqVzZyMGdkWmRVdEF0OXVDdWR3ZDRWTzZLalNXRzd4ZWVVYXVW?=
 =?utf-8?B?R0xkV1E1aGhiRFRrK24rL2x6ekxtTTIrUE4vdHV6MEVZcXA5Wk5vbFN4TVI3?=
 =?utf-8?B?Ty91VUJBQXNTamJOelZUWldvMzdvNTMydzVKZGJQNnB6Wk56eExQVFhBOFM4?=
 =?utf-8?B?Y01tWjhHRWk3N2duMUZLL052dXQzVWc3Z1RPbmdSMFN4RUxrYjFQMTZQOFd4?=
 =?utf-8?B?SUhsUSs3T2xJUmpnUSs0dmJlUDBwbjhUbTVxMHQrWGt5ZWN0NWtFQ0hMQUw5?=
 =?utf-8?B?ZkxqZGxlN2wwUzFzOWxlLzJyOW9hQlJGRzNSTW5XSGZQd0h2YTd2RlA0QVNF?=
 =?utf-8?B?elprSkZjRE8yRFdNUk1XZVRjbGpMK2NHK1M3R0pPZFJFVWhhZEc2TTI3Mnp6?=
 =?utf-8?B?K2RRU05vQXFWYlRTdHozbFV4aWdWSEUyaWpsQjkzRDFrNUNDRFJqTURvTHNG?=
 =?utf-8?B?VEp2Z3FQQTNVUmFXS1BVR21VM0dsNzg0N2dGbDBJN2pCQm44UkhZZjFKV3Zt?=
 =?utf-8?B?U1hVU2pHcU9JODIzMzBXRXdvRFJBY2o2clB4ZExlRHFCUHhkaHYxWFVaRlhM?=
 =?utf-8?B?c1dOdjgwazU4YkJ4NUlUaDV3YnJjM0lPMGFPSlFzVTVSUmk1VFV0ZGZab2ZI?=
 =?utf-8?B?QUdmTHBsaWRBQzNqdDlyWDFFdUdqMU1oQ2NhL1JJKzludVNRZTZhOGR0K0VH?=
 =?utf-8?B?ZWlUWXZaZ2tlLy9icFUzRWtkSHNySU1MVEE4My9GMU9PRUFrWnVZbjhRY3hq?=
 =?utf-8?B?d2NORndQcUFFNzZ0SG9wTHhHTHhhUnR5cXh6eDZEWkZYVXF6NGpLT1BRcTZl?=
 =?utf-8?B?Qm5kUm9ZdUt3ZDRNMi9FeUs1cys4Z2ZHN2V3ZkxyZVhpRlRySzFubTRycjRL?=
 =?utf-8?B?QkRjWUNRSHhTbTh0ZzRwNW5OVGNaUnFINmRVRVRyemZaZGdCV0NwUlphY3M4?=
 =?utf-8?B?dWNwMXFleFE3QkE4VWw0em5pMHBieGEvK2pzZGpPZmZUT0wzT1ZOangzckpt?=
 =?utf-8?B?dy9SbG5hSTV1QmpNTVhyRmMzOG9mUWprRzB1dFdNVnhTeXkrTHNadXBVNVR0?=
 =?utf-8?B?Sml5TVVEdDl4S0FSMXdHOHBrNnlKZkJWclFMdWJjRSs4RFNObThKKzkzTHdS?=
 =?utf-8?Q?3G8/7Xec50eGCFjEiVntcuh5H8PHads9GmrNOsx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd2bec5-6071-4fd1-8a6b-08d96e045be1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 11:25:25.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57j9Q3qCf19HvD90khCWz6iTiU46eAIlYI4sruKAO5xLV5Qq7Ey7HgNK6IUtLR0iJqnM8Kp4/d04fCvJ0ab5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020071
X-Proofpoint-GUID: n1E0LeeZsYRKROzU783cNPIw0AaN2G2Y
X-Proofpoint-ORIG-GUID: n1E0LeeZsYRKROzU783cNPIw0AaN2G2Y
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/1/21 10:43 PM, Li Zhijian wrote:
> Previously, 'make -C sched run_tests' will block forever when it occurs
> something wrong where the *selftests framework* is waiting for its child
> processes to exit.
> 
> [root@iaas-rpma sched]# ./cs_prctl_test
> 
>   ## Create a thread/process/process group hiearchy
> Not a core sched system
> tid=74985, / tgid=74985 / pgid=74985: ffffffffffffffff
> Not a core sched system
>      tid=74986, / tgid=74986 / pgid=74985: ffffffffffffffff
> Not a core sched system
>          tid=74988, / tgid=74986 / pgid=74985: ffffffffffffffff
> Not a core sched system
>          tid=74989, / tgid=74986 / pgid=74985: ffffffffffffffff
> Not a core sched system
>          tid=74990, / tgid=74986 / pgid=74985: ffffffffffffffff
> Not a core sched system
>      tid=74987, / tgid=74987 / pgid=74985: ffffffffffffffff
> Not a core sched system
>          tid=74991, / tgid=74987 / pgid=74985: ffffffffffffffff
> Not a core sched system
>          tid=74992, / tgid=74987 / pgid=74985: ffffffffffffffff
> Not a core sched system
>          tid=74993, / tgid=74987 / pgid=74985: ffffffffffffffff
> 
> Not a core sched system
> (268) FAILED: get_cs_cookie(0) == 0
> 
>   ## Set a cookie on entire process group
> -1 = prctl(62, 1, 0, 2, 0)
> core_sched create failed -- PGID: Invalid argument
> (cs_prctl_test.c:272) -
> [root@iaas-rpma sched]# ps
>      PID TTY          TIME CMD
>     4605 pts/2    00:00:00 bash
>    74986 pts/2    00:00:00 cs_prctl_test
>    74987 pts/2    00:00:00 cs_prctl_test
>    74999 pts/2    00:00:00 ps
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 28 ++++++++++++-------
>   1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 63fe6521c56d..1829383715c6 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -64,6 +64,17 @@ enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
>   
>   const int THREAD_CLONE_FLAGS = CLONE_THREAD | CLONE_SIGHAND | CLONE_FS | CLONE_VM | CLONE_FILES;
>   
> +struct child_args {
> +	int num_threads;
> +	int pfd[2];
> +	int cpid;
> +	int thr_tids[MAX_THREADS];
> +};
> +
> +static struct child_args procs[MAX_PROCESSES];
> +static int num_processes = 2;
> +static int need_cleanup = 0;
> +
>   static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4,
>   		  unsigned long arg5)
>   {
> @@ -80,8 +91,14 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
>   #define handle_error(msg) __handle_error(__FILE__, __LINE__, msg)
>   static void __handle_error(char *fn, int ln, char *msg)
>   {
> +	int pidx;
>   	printf("(%s:%d) - ", fn, ln);
>   	perror(msg);
> +	if (need_cleanup) {
> +		for (pidx = 0; pidx < num_processes; ++pidx)
> +			kill(procs[pidx].cpid, 15);
> +		need_cleanup = 0;
> +	}
>   	exit(EXIT_FAILURE);
>   }
>   
> @@ -108,13 +125,6 @@ static unsigned long get_cs_cookie(int pid)
>   	return cookie;
>   }
>   
> -struct child_args {
> -	int num_threads;
> -	int pfd[2];
> -	int cpid;
> -	int thr_tids[MAX_THREADS];
> -};
> -
>   static int child_func_thread(void __attribute__((unused))*arg)
>   {
>   	while (1)
> @@ -214,10 +224,7 @@ void _validate(int line, int val, char *msg)
>   
>   int main(int argc, char *argv[])
>   {
> -	struct child_args procs[MAX_PROCESSES];
> -
>   	int keypress = 0;
> -	int num_processes = 2;
>   	int num_threads = 3;
>   	int delay = 0;
>   	int res = 0;
> @@ -264,6 +271,7 @@ int main(int argc, char *argv[])
>   
>   	printf("\n## Create a thread/process/process group hiearchy\n");
>   	create_processes(num_processes, num_threads, procs);
> +	need_cleanup = 1;
>   	disp_processes(num_processes, procs);
>   	validate(get_cs_cookie(0) == 0);
>   

Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
