Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865CE7CD0E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQXiZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJQXiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:38:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D093;
        Tue, 17 Oct 2023 16:38:23 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMR6ir028067;
        Tue, 17 Oct 2023 23:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IWC0ejIeguhIC4ILBKph2c64vYIJZoEMTIEb39w2mtA=;
 b=F3Fljm5pdOAzjpCboMXjk9oCxgv4giTPibQ83IDsVvcA5iPQaoo8L11kG/Ov+mhYYIzS
 BLqBfn0SttFit9t7kftO1pXEkKjCSTVHEwrR2jf95yFLW+u6L1IzyUslzPowW/I7vGdU
 J0PVJKH7bKmYAC1NpqV5aKlEXY3tfFvEB7ef2me+htXrx8+gQVdNI01zRIDWe7iXtXtN
 eEVEvf09bzn8o3oejRtDi/nQbJlbUb/sL+VBnkzyxlyCjWFth82evt17TIXjAFOGD2+Q
 MDSn12Rzs5I9Uta4iZyhd38Iyy+/IEv+W/MJCN1BCzKombAeeI626nMa3N9sCPFObFb9 7g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsb3xuchd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 23:38:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HNbxFW021478
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 23:37:59 GMT
Received: from [10.111.183.229] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 16:37:58 -0700
Message-ID: <e9da3fb2-e44a-4c42-8f9f-cf24be12ccb7@quicinc.com>
Date:   Tue, 17 Oct 2023 16:37:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm: memcg: add per-memcg zswap writeback stat
Content-Language: en-US
To:     Nhat Pham <nphamcs@gmail.com>, <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <cerasuolodomenico@gmail.com>,
        <yosryahmed@google.com>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>, <vitaly.wool@konsulko.com>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <muchun.song@linux.dev>,
        <linux-mm@kvack.org>, <kernel-team@meta.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>
References: <20231017232152.2605440-1-nphamcs@gmail.com>
 <20231017232152.2605440-4-nphamcs@gmail.com>
 <CAKEwX=NgsbJ6MQJdJoOTDiGyhjhRA8KJdYe5GzV5iK1bRADfuQ@mail.gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAKEwX=NgsbJ6MQJdJoOTDiGyhjhRA8KJdYe5GzV5iK1bRADfuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zyOFRHaOEy14NpYS1DcA20VSnHZvIPLa
X-Proofpoint-ORIG-GUID: zyOFRHaOEy14NpYS1DcA20VSnHZvIPLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_07,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=805 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/2023 4:35 PM, Nhat Pham wrote:
> On Tue, Oct 17, 2023 at 4:21 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>>
>> Since zswap now writes back pages from memcg-specific LRUs, we now need a
>> new stat to show writebacks count for each memcg.
>>
>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
>> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> 
> /s/Signed-off/Acked
> This is Domenico's work :) I used the wrong tag here. Should be:
> Acked-by: Nhat Pham <nphamcs@gmail.com>

no, since you are posting the patch, you have to sign off on it.
Signed-off-by is correct

