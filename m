Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825AC57F948
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jul 2022 08:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiGYGBl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jul 2022 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGYGBk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jul 2022 02:01:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798166440;
        Sun, 24 Jul 2022 23:01:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P55lMb022073;
        Mon, 25 Jul 2022 06:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=soXVwM9nzuX+Q1bj83PaYPMf44fabPxDdP0zIZMD9Is=;
 b=L78DZe8i2gZLMak99ZCeXQEte1gbYAifjxIMAJPPwJAXilI6S/+IzkthSiCXnshvbulr
 LC4O/fFQzbQ9Y6l9EKc7cbwgP1vU3X8Z0GCpqazAf1Jx74N6YBxif5egmoTBgB0N+UFL
 vYcgXTkRM8AR9p3c57H5jWwY2G3jl8zVsRIW2SWLRBMx6uK0bje+u7Isi0IbYeDEY7Xy
 BEJ9oxAs2nLTAWW/MAcca8uE+dxw9jwtT8GcPIj8GAcQtCD5WP3V0rNxLlvsTo6CbPxC
 YlpN2YuAqa6EdY8Az+7cdmZP+s1aX659GS/2SUptcW1aEsEv14VgZbX7RhAhsui8UxWz lQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hga5sk7fs-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 06:01:26 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26P5mcrR010714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 05:48:38 GMT
Received: from [10.216.38.128] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 24 Jul
 2022 22:48:35 -0700
Message-ID: <8791eec2-4714-f287-6fe7-a8b724e4176a@quicinc.com>
Date:   Mon, 25 Jul 2022 11:17:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] selftests/cgroup: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <shuah@kernel.org>
CC:     <cgroups@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220724070435.7999-1-wangjianli@cdjrlc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220724070435.7999-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O0v9LtqG_0v5FKzE3ZP4mc1QUIOrRrW1
X-Proofpoint-GUID: O0v9LtqG_0v5FKzE3ZP4mc1QUIOrRrW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=974 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207250026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 7/24/2022 12:34 PM, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>   tools/testing/selftests/cgroup/test_freezer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
> index ff519029f6f4..b479434e87b7 100644
> --- a/tools/testing/selftests/cgroup/test_freezer.c
> +++ b/tools/testing/selftests/cgroup/test_freezer.c
> @@ -740,7 +740,7 @@ static int test_cgfreezer_ptraced(const char *root)
>   
>   	/*
>   	 * cg_check_frozen(cgroup, true) will fail here,
> -	 * because the task in in the TRACEd state.

s/in in/is in     ?

> +	 * because the task in the TRACEd state.
>   	 */
>   	if (cg_freeze_wait(cgroup, false))
>   		goto cleanup;


-Mukesh
