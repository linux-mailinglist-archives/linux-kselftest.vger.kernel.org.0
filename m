Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5279362E884
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 23:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKQWgb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 17:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiKQWgP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 17:36:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6AD13F16;
        Thu, 17 Nov 2022 14:36:13 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHMZFWA009705;
        Thu, 17 Nov 2022 22:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=lm/WYRwGpksgFWqXZFY7rDQZdMBX9Zcy+ngdvNoLJYU=;
 b=Xi2jzwl4noJcerB8163A8WO0QnjJBycna8ZZB0VKWEJ9ZW11myW7Hj8JEI0crMDCwkjO
 Ng6Lw6yJI6M3x5tFphCiKdnHdSUHESqJarA1okuolmyxId24WQphnkpJU7R4Yea1q/hV
 ol7nu/jVWBhthB50wMl2jCblmkX0xSmgVFA7L/ssmbpQixq7bBpcJdmWR/31pFB9dgsm
 gNFYgDvL4WSWkry7AZpqGZ9EWPmOLK1av77BHDtPAiydYIsNyY5gIMKQ5tfzoPpStx9Q
 8slZX7XRMVyU9qKqHujvZXsGs6E3KGp6dNxUJVsVvLDoEVc2+MOcMP7W9QeXlG9n8kqX pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kwwvp801e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 22:36:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHMS4fK008684;
        Thu, 17 Nov 2022 22:36:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xg3apm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 22:36:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX0RUfcAVE9KpuU+1nMOpEP4s0On+Nffno5edQ75hgpdOiDGRLey83cPDioa9l1cD7mFT2cjstQpLioLgSqHtaLhbe4hmXaGpRkn1MYpgZhCFpMNrAAq3PjW6KrhdsqZzSBLybIRhVJufkpOv+DJ2fBq69baPTbjabCvKpIzcyrTideK6obRV7lPyo1znB9xzcbFCYRbPDToxaSKX9f3AA7X60IzhlryGMJQUOpnwhIrCN93FBZHmQ+qOXCaey9eYeQmQWoYFWT3ZrnmRI7RzV9U0Cy8mfuHDqb4XRxdAQHfW138JOtYU7hpZ3K0RGYsupAACbvolTMO+zdGmEJ6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm/WYRwGpksgFWqXZFY7rDQZdMBX9Zcy+ngdvNoLJYU=;
 b=gczH4OAgOXoI0v2wot38TsPe6nGeSJSIvWgvA4R8sbDWL4JYMnGt6hZ8N0aStHpDYjq7/avJ15KcUGV2TfRR71hF7juKT64wm3u3NQIOsidxRlV/dOANpJPReK55ReH6eON5CVkNpyLYTSTbaZmjVKcZWBbST0t34wsvwv7lVZrHE8vbo/GigVD3ZsKj4dWZq15Oc7QGU5DDlSI9HFalV5vFnZM/KYzpnuoYYJvOSRcYar0ojpfJuCG5Fr9pfNF4N9PJ8wclgKiIQWIZyhhVr/vho6Wu+aFjv3hVNG8pw6BD/bwLmcfZdteda5d9Km4QC2uolmQZqySB53WURXK8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm/WYRwGpksgFWqXZFY7rDQZdMBX9Zcy+ngdvNoLJYU=;
 b=BI/X3Nn8KkbW0KlPLlAVuK2epoZmJvGd53Lj9Hy6UTKutbzP+nbyCnafPmGWGLYQxtrmTMqB9ppLcETQnX8BKcJc77aN2m6Qo4yibTu5CA+6xhDTyw3iywPadyTWP104uiVqoPJbvjQosLeOXBDR3EmzRyHCT8r+PLiuhhYlUyg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6218.namprd10.prod.outlook.com (2603:10b6:208:3a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 22:36:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 22:36:00 +0000
Date:   Thu, 17 Nov 2022 14:35:57 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH linux-next] selftests/vm: calculate variables in correct
 order
Message-ID: <Y3a3TcM55a6RnpUA@monkey>
References: <20221028132640.2791026-1-jsavitz@redhat.com>
 <20221108163124.a54f932f8f79f9c1d6e63903@linux-foundation.org>
 <CAL1p7m7Ar_DBbpLWuha8dPYKU3FjS6NyAROBa_PO6NKRgfuGxQ@mail.gmail.com>
 <Y3aojfUC2nSwbCzB@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3aojfUC2nSwbCzB@x1n>
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 7591411b-db94-4bcc-c422-08dac8ec1a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5k46+7iE+XjwQnsEssGt1HFqfcbuaxoAg5h/xVMfBaD3v2E3WH5J1OOu4+LwGfSIXkx3U/Z4uofsw8mhRFF9/LMs9LP4+js55rx+iIhSgYjo12jinXP9WNFZr4dPj6ir460ANqW56zrOKMPEF81x+egHP1rqvQ0PHNYw4CvSjWj6j/kr7LH9UERMrOe9WkNty7x+8FkUMhJai5P9rDx+m0Tqr+gYtm3bVfgR4gHDkFTNhp+EkysrOXSq+zXbSHUGtOaayUIyEgZDbc2PNyFIj9RGS+LGBe63NczyXqf3zDRlb7dzWtra9NE/EYVQNc/KYm9GSJFRdw6XGwzrczpn8Ur/jjp0NcU/pLj6esgeH+YvI/BE59vfLaOY3FJffkVaipZZpyb+3zLwnHdvNrimebNmRZrFyoJDJLNkvVB/+WSyzC7dgvDaxa6v8YVdweuAKwBjrR64dWl11OLKUY9z7LAGZA5I3b/jK6LCyKDWd6MEakQFlqDpwg71NNrWckGWV08RhqWo4o2+ZiLi7zAuC8irYGU9616e8HtNJqdBpbuoo3xr2Jl9qyavk3bMB+ktfUWXHpNZA6N4LGHTGs828OrNK2FgDWTauAmVLX0WddxsiVH0ehDOtlKEiBrAbBxWo3nd5njG1bQ2ZJnKxE3Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(6486002)(44832011)(478600001)(5660300002)(86362001)(2906002)(186003)(8936002)(83380400001)(6916009)(41300700001)(54906003)(316002)(53546011)(6506007)(4326008)(6666004)(6512007)(26005)(66476007)(8676002)(66556008)(66946007)(9686003)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NAzl2Con9gFZ7bsqF6W6wp8aMAvNK7lRn3EcypbpArxW3EkUG+kHgUWHZKFw?=
 =?us-ascii?Q?AhyV6gDQm+R3jCBnRbUSdJiwi4lO+QpHLFK5TkTDJ45lsJSWBli7orXnvYSV?=
 =?us-ascii?Q?i1Toq2lDs7+7yIMU1ITw3EzFqDRvx+ORylbw0Y6+iz8RzaFLoQ7N7L7xLydq?=
 =?us-ascii?Q?rlp8lRwlo/bRgAgv5B6ZNBrmQqIW+Nt/1RtsHBzjhnjSgv1ICxq3CmBjTmlJ?=
 =?us-ascii?Q?6Hi0vETkDhwKNzM5sZRDWlZQgxUDhIDSynEeW9VCoFBIc5LIAC/4d35hz5uA?=
 =?us-ascii?Q?WJe1uUg9WMGq/J4Ot4Lihy1UvR6ZDeXpLjw33NlSIXnjjvSkpZiPVPdKMmZK?=
 =?us-ascii?Q?D8nXsqrOX0wT5x+f8gjAIssErp6W+eIAMdR/pUqFjFvtRk/vqmjcd3NYl2/T?=
 =?us-ascii?Q?Kvx0SARXQJrt+9rokYQD1K0CMhx/4w8UBF7D9oqSj63KxrT+X6pqopw7ibUx?=
 =?us-ascii?Q?g/zu5jj7jGY6UBmCuNDqO9Zi2XR3cD4sOcOfbTfks1RqjDN8EENSMNK1sGWr?=
 =?us-ascii?Q?iDLkzC/dylVmpA7sIk/S5wHqKUvaIIA6p9bH5LmKYmVOMt+ruvpl21FFghxK?=
 =?us-ascii?Q?RDX3YD7EJBb/Ta2Su0+xxAwDkQTNnhdPRbw1aR2sT+Nk20tiU1Kofb4gWNm4?=
 =?us-ascii?Q?1voCqJryy7GBKmTxZ200sSeZLDRSe3/GGXuuzk3xBYJjmR/DU/uw3yWaPhkM?=
 =?us-ascii?Q?IwNsElwEpMaWzLbpBEVaUCPVsQZYPXiYmyF1lbcWs+2p/0CkEKU6Y+1pkVJn?=
 =?us-ascii?Q?Nq1I/0bdQggR5K5KV/ifAlje7t4BFtXRYOPPeEKHm/VsynFLTBxUWVXWUKSl?=
 =?us-ascii?Q?30hBlejnch9lOZOB9Q+0v6LDQqO/zOhXbewxXhqz4w5U79fVpNwNPuicCJju?=
 =?us-ascii?Q?rj3kLjNJ7A5ZdCe+4iXsGSUFGwdAH37KEYltB/8bGT553fINOqDuiYeuomp1?=
 =?us-ascii?Q?8dz13ItaZXNYW2Nd/FSjRFL4gNfZTQ0ltUJoLhvJbYtnhqNAJqiHKpyIis38?=
 =?us-ascii?Q?f1K6lvPzvBfTbl82Lf4EnQ6K3Za3cpDM5QLddgMP49aQbAePBHJIpnovljvM?=
 =?us-ascii?Q?BaLVRzfm0+ENfFpNQH6Hnpo8s9yhhwrcLF3zsaFk2PQC1Ug7l794ZBLhquzN?=
 =?us-ascii?Q?hTkQyrV1j8lL2FrOUC+2jlJpOD2KMR4y2FrUaCaTRsbEhd1pfiCVn2aUk8Kv?=
 =?us-ascii?Q?9T8Tuz/LwWhCUilZsHoY1Zy5+/9wDS8H2gVq9tGPCNelxqAdwFE1MYwdgehd?=
 =?us-ascii?Q?Z/CM1FatJ9WKoCZF2TZFTzAeBPu76RkMZ16h/HuS6c1H38K5qfeO4S+WiyRM?=
 =?us-ascii?Q?j2BayK6gb6RE6k98PQDrVJ/2RVRCJQ3IqGWoRXxUWePSHPXjn1CUNUXi9Lt/?=
 =?us-ascii?Q?dIr5AcDTHEHLHExA7yoyiCxUdtBQ57smTIrWAr07H3T2mNxj6/eO6QjvnvX6?=
 =?us-ascii?Q?zQgoxmcdLii5IcWtzKXMLpyjo17UOdx7fxBb50gHogaYKQnRm95ulgM68m14?=
 =?us-ascii?Q?oApt+hPcsatd0K35o+fEnDRNAg00qVojLhGhz+J2kgQaK4ZgEZrGSLdsoRUn?=
 =?us-ascii?Q?I97gLeiyGWstHQqtz+/3bORiixIvG4A+2euj8X1meGoZyLvCbVc6s0WNklCM?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?G8n/4ieTcBrJeO3Jc7TtCkZMef/6OR/jELDns6PVQ3VgvYakw/gAdqRaoBz2?=
 =?us-ascii?Q?zhNZA/VfMlRgSP+fdiyni6daepeSh9qQ4mI+l/oCefQX9fgjFYchHI0BK3qK?=
 =?us-ascii?Q?DrDbpU5cUVaFJMXs2kNzLxzTdnqjQym6S7ykHJIkgxoDLR9OCGRCU0rGL7Ag?=
 =?us-ascii?Q?xaq2qz6EDU10z6BUByoOBhCiAO8c1fJJZKkxxqMAaQ4Iv+fywvecyP+x2fWR?=
 =?us-ascii?Q?9NTfPrNEZVUwFD1f2umcuzJQBlSRj4LEscKbkRD4ksZ6g4nNHxRSU2VZiKmp?=
 =?us-ascii?Q?FFi5YIfiuXHEteTRsG2VL5bD7E95ArrHUoMfCmhIKR5saHwX7WgRdEUC9bo+?=
 =?us-ascii?Q?ubeMwfPuLxr3x8xm7M8T4+Fjbu5xTSLL7REqKRlaDSowamxqU9mOjUxY2q05?=
 =?us-ascii?Q?07GHwd2dr6uJAIp0HTYK+iRHieILA8e6gdDyfjSKbi8p8Tk3Y2AZ99zWyykR?=
 =?us-ascii?Q?w6WCZYS16N1VA8Ux3oueVWgOlB5av2RF5XEAc4Xdv9ZworB/592JcSqhg0IM?=
 =?us-ascii?Q?sDkZhcKLcPtSJHMjXKU8qZalHDRPxwUQxrWGYjQ9K4wBcRNT4p35NaTW+KrU?=
 =?us-ascii?Q?fNCPOfRDXgYT61XfEwRvqIiTQo8Vcql70Bdc3tRNpgiBasgCslVWDlas1Pls?=
 =?us-ascii?Q?CA6D5nsIE2it6R2haTG52mVvsIz4FBWRHTPoX5d9FW4qB+FAoYUX98O+pvqv?=
 =?us-ascii?Q?3Wl+d2wRuVdrpHW7cJsRNCX10aglwMHyvDW55NoTvuWzZvp4Nj8QUs4snvTu?=
 =?us-ascii?Q?zTwZY3y7kNkdb0DY3qlx3fGGSF4+DvVDhQR5Nf7Cz8lZd2rGih/FSrUQtnz0?=
 =?us-ascii?Q?d6OhRGpgMflRxLuL4MYDXhj8YRTkTzjtmRMbT+Vyrl+Jrb1H1K6uih3n0muo?=
 =?us-ascii?Q?kaBd/tBlIux33U9rniGrQKWJY4GaVuCYVFvXNi4UkvD77MN4XKL6oXAFgZR/?=
 =?us-ascii?Q?oSCogDNU8T5xZVF0gp+Ppk69t5n4+0sHtrlDopQIebkg1I9ACpE5Vh4oe0Bv?=
 =?us-ascii?Q?HT6SH1C9F04N0bLHaKXEdgP8lJrAn5P5eE7zA2+94/EKhwE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7591411b-db94-4bcc-c422-08dac8ec1a19
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:36:00.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck+M/NVz0VN5NDdJbi2ZYWlDZsX/gTYeryzB08V+rxRhrnc3JcBcjFmiJR6LpDd5rbRZ51Ug9q4qVPyeQ61/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170160
X-Proofpoint-GUID: 05W3FLSujCwAUicSwHZX1y258rO-n-3Y
X-Proofpoint-ORIG-GUID: 05W3FLSujCwAUicSwHZX1y258rO-n-3Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/17/22 16:33, Peter Xu wrote:
> On Wed, Nov 16, 2022 at 08:09:11PM -0400, Joel Savitz wrote:
> > However, I noticed that on the mm-everything branch, the hugepage-mmap test
> > fails:
> > 
> > # ./run_vmtests.sh -t "hugetlb"
> > running: ./hugepage-mmap
> > -----------------------
> > running ./hugepage-mmap
> > -----------------------
> > Open failed: No such file or directory
> > [FAIL]
> > ...
> > 
> > It appears this is due to commit 0796c7b8be84 ("selftests/vm: drop mnt
> > point for hugetlb in run_vmtests.sh")
> > as the test still replies on the ./huge mountpoint removed in that commit.
> > The test passes before that patchset is applied.
> 
> Oops, sorry I totally overlooked this hard-coded test case using the
> mntpoint.
> 
> Fix is simple though, which is attached.
> 
> -- 
> Peter Xu

> From 71da2480d4bac0fc598e4d1f05f71aba8b980bc4 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 17 Nov 2022 16:29:15 -0500
> Subject: [PATCH] selftests/vm: use memfd for hugepage-mmap test
> Content-type: text/plain
> 
> This test was overlooked with a hard-coded mntpoint path in test when we're
> removing the hugetlb mntpoint in commit 0796c7b8be84.  Fix it up so the
> test can keep running.
> 
> Reported-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/hugepage-mmap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Thanks Peter!
That is also something I noticed and was on my todo list.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
