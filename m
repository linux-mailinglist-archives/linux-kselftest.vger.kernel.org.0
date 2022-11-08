Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998862124A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 14:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiKHNZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 08:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiKHNZc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 08:25:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9BF1A3A9;
        Tue,  8 Nov 2022 05:25:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8C8rqN010671;
        Tue, 8 Nov 2022 13:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zRKNtn5RScxF2H4DTysF0N3GLDhiObwB/9r8Ijyjdng=;
 b=0y0Gqhv5vpxBxkYWq6TtacScWEnWNVsjExEUmERZ75r+RTzQXax5q7vGEWl63flCiSOo
 ziaLnDg61kMNGmBmOXZAPLa8p0nI/IAwtk8ifC6cyiOt3YFKwNDhvlFa6Wt1DSnzML++
 3AScGeM1/B1zsWkT9EXo1A0SRggr4OUz4VpILdxGRUluofGvJSgD4ahU/8/PZ90f2qZC
 vZowtF/n+JlSj5SEPB0nK5P9mKv6BCsdjK3aLCC9SvXK0TNTdkgMyHhWVNLOjF1Q0jpv
 RVEFOgmR0Rw57WvyEt5Yx9esll4fT0EXPBTG3SXg9OI4bqe95P/6TPWMHVVzWgIISkWP lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngnuy7mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 13:25:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8DJ9N2014355;
        Tue, 8 Nov 2022 13:25:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq1vxu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 13:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTdz4fcnVOxWlmnWlB4ky74nKpevEyNaCPivvnJ6gfUPtYN0X7UKiqiqvOgflwGfAw6m4OpMaT0Ginh1EXEHEPXfH1jiY1gAYZn5etv3if8owg2wP7z7ctwq4v9me/hxk4BAg+CJ1opWgzCtbzfAHrTINYEsJXiutTAFZUjLqerOSuoaHu9pay6GeR9mju29uvp4LUoxohSDJ9SKHCM2YcIYRtEhIRIBFySZvD6uDrd5VR2rnN2fgnyfYfUSrceVaJ90MuH4bDpXTmYDfmzENmy37OcgMcytMHk5OktmtwoikBMFidejUF6YQhlG6tcUY0Z90VDI+G0dbuU5gGYOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRKNtn5RScxF2H4DTysF0N3GLDhiObwB/9r8Ijyjdng=;
 b=gIgjaI/AkfvLbfsPbWtFU8wLS/b+0Siut/RdCum6HXJ/ngMx6oF4w+g+O2G3ntZZLSHRKGhOgkS75RD4xghG35534fM/ZxFTSH8nGkuClfSqSRkqLQflJ6sJEq4T34m33HBN/+LS4UldYgWbewlaLHxQ9ooX41KQ5HOFRaUTOyp12P/KR1z2n672DixsAk5zHS1ITOmRUZWXbSAVHOve/d3D2yPkb7lSEUPeArwwiJfIFqtNEc2WGnpFYZJGkXP5Dlz6vFw1WiLDmARNuwnyjGvwTnPC/ck6HMVLsBe/ZaeYBY1xBskR4Smsm0h5THjrEof3ylBmq3ps59FHlQqJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRKNtn5RScxF2H4DTysF0N3GLDhiObwB/9r8Ijyjdng=;
 b=cWCGQokNyWhdLUrnHcEU2AexpDqRwenrPePj3HhF7z9aMJNuTCQlDQdjDZMUWNsFtrRt2SfhAlyYpo3VPjdbPlp7bh8015iU38ySCQbm25w5h6A/7JkAET/iz8Ff5HzSVWZdvNhooPjho204JNQ8bUISy45EQqF9ZSCp7J+9sM0=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 13:25:07 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b9f5:77e4:456c:9e08]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b9f5:77e4:456c:9e08%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 13:25:07 +0000
Message-ID: <62a98c8e-c471-dc02-58f4-63dd1361f92c@oracle.com>
Date:   Tue, 8 Nov 2022 18:54:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] selftests: cgroup: Fix unsigned comparison with less than
 zero
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
        yosryahmed@google.com, roman.gushchin@linux.dev,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221105110611.28920-1-yuehaibing@huawei.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20221105110611.28920-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afebf2c-d7ea-40be-b4fb-08dac18ca6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANyfxwzw6hMBddtto+VCqn4RdwDTwKL3tWh68JWuFmAid9VwRCni4WEe7FauPFFRnJuADoulyFEwH0tQ1RAUlP1ZsyjFShXzGSxoRjjQujL+l6Rln9feZLFSYWGxl1F/GxqidTPOVFOCa+DpWGV0C0O1RLsMTzTKmV3B0lrjT4HJpQah23pHMN/qRzqiCKRA0bauj0oxbqrCX0UjpRd2ySWCp8Nf1myQNjQ73hdfJvUQPw2n6Ui9d0QXlLe5ka3xE0K5qfrDmFiHRTWRxfUUAG6FhaQoHFcvwUz867bbz2zUgzsJ5DQDupL2MYVwZrrZlknQ7WLEeKGSH4pKLqRvRVrcFGkwgAYLoYq9nnzpR4IkoTowykzrVYBGV5j4rJqXuknzNWHKADDXJJ37BRTrhe25UXLhEwgUbyZ4VTvNtIO6UDieOPYIOYUYELTyKiJ4oJNyiU/HhOakVrZZ2Em/fkZoYrkQQrjZoKmjNqpsQlQb7uAhJGr+dtcWEgyun5l2wBA9QfD0hTfBll1F7rX0V7w7oyQvjylFNsYc+4uZZelNZpW96UokbNHt7NBfXeoOqlMMb7ZleIkICx99TZnT3/NSBvkGKJ4OOfqAXyAfjet+LozCh3EWccvwmgRfR8PrLC1RuSJRKsGdILG0IYOt5MkGvzJhurHls1xhw8D2JRyC0hIS++CecpGjjn5wR0NHlEFU8RxtglLnwW5TvHD2FdC0/IGklTuUUvXXxx1cSm1btGhkh1yo3+M/stkrhCu0bkE8LXAmw/tQIqPNSk8jo144SGfke8AMfbcFKfTdAaqSw9xvOmc1Fx3AeUA5OSQZo5AltxbMDDp4YLIz0F0efJCb7bLF7SUWeBM3mJnct8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(36756003)(31686004)(31696002)(921005)(66556008)(86362001)(44832011)(2906002)(7416002)(26005)(6512007)(5660300002)(38100700002)(83380400001)(186003)(6506007)(53546011)(2616005)(8676002)(4326008)(316002)(66476007)(41300700001)(8936002)(6486002)(66946007)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUxRbjdkTk9iQ2ZUeVNZcG5NMUV3Y25HWFJuVVNOY2h0bDJ0MUVkQmJERzM5?=
 =?utf-8?B?Mml5TElkelVmalBiRjB6RVp3ejJIMjBXYnozcUNybVBsNDJ4Z0tmREZkS2Ez?=
 =?utf-8?B?Mm5BN1ZRNTkzdEE1L3lKZjNKK3N1emoveS9oRGNndVBUK251VXNITWZvWEZm?=
 =?utf-8?B?ckNvQWpJNVNidEFlK0lxb01mZVhwY1I0S3pONkZxZE5WODRBTFpvQ1JMd2xK?=
 =?utf-8?B?QjJIbzlpbllvZjBmc2t4Z2RJZnNxNFFOdHczeHBFZWppZDYwcTJiWUdwbFZF?=
 =?utf-8?B?MjNUREZ4Y3E0V1krTFVlRlZ2RElDbmhzUk55TjM4K2R6SHJRcWNFV0drK01o?=
 =?utf-8?B?V0o4OElOamxBSytJVlVDMStkWHh3U0Q4Q0ZoS1MvYjFSbjBlM1VlWHZhWktr?=
 =?utf-8?B?M2htZllHOU5ORGRwZk1NMXkrWnZiQWtnaEhuTHd4aCtUUXV4Zm9IZVRqNHlj?=
 =?utf-8?B?bWlGNDg0VGlEbUJ4Zzlqc016V2k5WW1nVXMraVhwSWxGdDVQKzdoMnhIS3Z5?=
 =?utf-8?B?V2Z3ZVRTT01rOERxYnhuSFBqMFhIR1lDOTFoTk81dVJQNm1GNXIrQ09ZOVRE?=
 =?utf-8?B?SEV6aUJ2WXRGL3FGTURWSVhkRlY4MGFqaGFwV0UzR0wvWmpCc3FZeXEyTUh6?=
 =?utf-8?B?aXFFbW5razBQQWd5N3VodmNEdUFlYWJhelZVWGxsdlEvMW9oZmNlcG9aNGJW?=
 =?utf-8?B?amMzeVBLdlNDeGhEMWIraUxONnpPNmR4ZjgvdU85YnpJUHdUWHN1cGFraHBs?=
 =?utf-8?B?My9odlZJQ1ZMdUdScXpQSkhGMDQ4UU00a1l6VXRTYUJMQ3FDVWNEVTdaNVZI?=
 =?utf-8?B?SFlnMXRhSnRWUkVRSmRxMWs5MUl1MU5lK0xFZm9iUmVmZDNXdGsrUkIzczRl?=
 =?utf-8?B?T04yZ2xCc2Q1OTV2NVhSUmRoMWxXYW41aVdCTUxuUTI5Z1djS0M1bDBCamtT?=
 =?utf-8?B?OWtENU4zdndpL0tmWGx0eXVMbkdSejV4TzRlZWlqMG5YVldQeDExSHFJYlYx?=
 =?utf-8?B?My84SHdZQlVXYXZ2M2FoNjIvc2FVQWNyWFVaVzM5MDJMMDkwcHJRUWRjcEV1?=
 =?utf-8?B?ajFsb01yUVRBZElEenlmRTFvaktQdy9peGxSUXoyVXRxaTMwcmk1eG1OZnZX?=
 =?utf-8?B?akJ6NC9pR3F4R2NucGsxRzg0NS9sMUhvV0UzVFRyMmljNWJvd3J3RURLVURx?=
 =?utf-8?B?cjFVdVM3NDFsRUgvdFIxS1I0Sk8xS2xKYjM5TmlMRk5hRnBuaFVFaHpYOHBP?=
 =?utf-8?B?VDZXVHYyTnNFUnVSNFhsVWlRTmphNkdXVnBpQm1FbktPMXBlSUNrZmJiVy9z?=
 =?utf-8?B?RktTU3RXalJrNkdyKzdncU9SM1VRNHIyUjhIKzFRN0lSdnhQYm9XRjNBWmxw?=
 =?utf-8?B?NGVRbGphNVJHT0RKVzduZ3BjamJqRXNSdEpGcm5hcVhIaEJsVWN3ZUZ0bVBS?=
 =?utf-8?B?b0lTWEMxdGxHaFZXWHVscFRPSllBNWx6N0IxcDZoVTRiQmxYdmtpRndQOW0v?=
 =?utf-8?B?SmdqNWVJcmgzdWJBNE5qLzZLU1ZDMi9XYzlPQ3RaY201UG1HOGZtSzhGRm5P?=
 =?utf-8?B?cGNoZWR0RHdKMVVwVnNVa0txM0ZLSThEVXVOeHJnc3U5V2NXYlZ5N1BmNmRM?=
 =?utf-8?B?TTNtSE94azdQUVdJbXM0QlQweFA5SzJmV1hoeDlzYVNkRHk4V1dyb2YxOURm?=
 =?utf-8?B?VUhrY1dtUEVLT01iSjBiNUZwdVAyS2d2ZHZaRmJWVU5MSkVibnA4NEZVU2hw?=
 =?utf-8?B?NWxRY3ZOd21PTWVDYVRNblJoNXl5QWFkOUN2MXV1VjZmUG04bms3akdCOW9Z?=
 =?utf-8?B?dG5uLzJlbURWZ01EK2VJZXlvTk82S2FLSnUrcUxWeU1FdWd0YlF4Y284RDhi?=
 =?utf-8?B?cGVJWVd4OGlUb2ZqRFpSRXBac0FIK3BIZHhTd0ZHc1pMc1pRM09wa04yekpO?=
 =?utf-8?B?RXRsWE5FRUdBNDJSU3FOSzZ2RVFyM0FheWRlOHBoZ25NUUZxbHI1elpWLzFS?=
 =?utf-8?B?M0IwUWVrR1FxcWk2enl0eFJUempub2EyVFZrYUUreXI4bzVkVXdvaUdnN2xR?=
 =?utf-8?B?eHJjcmkvK2s3R3pJQnVLdFNsMUFIWGRwcnE3MjVLUXZpK2hBSml1dytGYk9V?=
 =?utf-8?B?eWRQWVoyRWZNYmRtNlFJVXFaUHNzTzlOaUJvYWg1TGVWbFFjcjFKUkE0MmZG?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afebf2c-d7ea-40be-b4fb-08dac18ca6e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:25:06.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntiqI5ZgfSCPI0nevjHmzhvRLvEDtmYfb1uUKJ2IgFSPJu5zaPU30YPAyEbcBNqxwiEYf0tZpUV3p4onQViEQwXqJOI09EgITC0vbZJJBDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080079
X-Proofpoint-GUID: 5MfQY1do0RYYZYJ47yzrEKqh7RC6LdwQ
X-Proofpoint-ORIG-GUID: 5MfQY1do0RYYZYJ47yzrEKqh7RC6LdwQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/5/22 16:36, YueHaibing wrote:
> 'size' is unsigned, it never less than zero.
> 
> Fixes: 6c26df84e1f2 ("selftests: cgroup: return -errno from cg_read()/cg_write() on failure")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 4c52cc6f2f9c..e8bbbdb77e0d 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -555,6 +555,7 @@ int proc_mount_contains(const char *option)
>  ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
>  {
>  	char path[PATH_MAX];
> +	ssize_t ret;
>  
>  	if (!pid)
>  		snprintf(path, sizeof(path), "/proc/%s/%s",
> @@ -562,8 +563,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
>  	else
>  		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
>  
> -	size = read_text(path, buf, size);
> -	return size < 0 ? -1 : size;
> +	ret = read_text(path, buf, size);
> +	return ret < 0 ? -1 : ret;
>  }
>  
>  int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)

-- 
Thanks,
Kamalesh
