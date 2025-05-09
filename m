Return-Path: <linux-kselftest+bounces-32759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E362EAB1A69
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B225237AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76E2356C5;
	Fri,  9 May 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oLANYEub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2822ACEF;
	Fri,  9 May 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807985; cv=none; b=NykyCUiCotxtyTL+7zc/Mifj2yEd9RJIZU8YL88lvOljk4lMDIkQfuX3IfiBeSQQnfxjcj1npDGOrw4cXg0j+1OmnoXy+8Xy/dV21HB4pXRJ6td+w6Rdgg1BCzeZMvx+BJ89QbLA/TBLZBg8DP4NAZCf5urw1cBqa2koUAqDu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807985; c=relaxed/simple;
	bh=lnR1y+zHULWTqrlJAQ5R+4+2iYh8oJTzze9UjaZi2Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5hXdmu5hme8fj4+EwCEAE3JrzSmn1LPZzusZUdn46GFTDw+oW03H3l69Ma96+SNCn1dhkk1qijIa86zWIDvG9cQOjdwh2eyvSmjLgJoMRsN9etMQbIzFU0KDAcmAPIsh6iXoHZFuqmyWYKyp7JBDc0+/JCK0Bp2q6szRFt+6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oLANYEub; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549EYAvH031612;
	Fri, 9 May 2025 16:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pDz77u
	zBNO2nIiR2GXoB/HFEY5WV+wPEqr0qWm3PIiA=; b=oLANYEubYSQ8/6vdHfuGIi
	+bffgxTLERPaLCv+6i6gshdUphuva+xjnshn0qcK/vRGddOgY/4VX2851VCqHENE
	9WzLtuGpYpQdp13kE6ucgl9o8DDz6RIEJpqJyQxx5WgiWhv+TO9vpUumOoxZGXgD
	azi9MhjomFnazCqlIpfwXFcX7ESbCytiiNzGtzNkii8a8rqmviXTNt3kz4XREObY
	hD7sJ9+oB7FRB270gpdEvAvWz/vObD34VZNQ0EFbpj9YOozyc+VChMxcXHyVeZGH
	S1gdQA+w7fSvaVpGcEhpVCS8YxpO+cI0hQ+c4NJ/btaVSLuQo9f0C5z22odT41eg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwd0mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 16:25:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 549GPoqY024125;
	Fri, 9 May 2025 16:25:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwd0mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 16:25:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549EsvJP001304;
	Fri, 9 May 2025 16:25:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftvk2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 16:25:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549GPqBP24642072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 16:25:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4943858062;
	Fri,  9 May 2025 16:25:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19845805E;
	Fri,  9 May 2025 16:25:43 +0000 (GMT)
Received: from [9.61.252.85] (unknown [9.61.252.85])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 16:25:43 +0000 (GMT)
Message-ID: <10152245-9d67-4a4a-acf8-b743bcf42254@linux.ibm.com>
Date: Fri, 9 May 2025 21:55:42 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Fix bpf selftest build warning
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, daniel@iogearbox.net,
        mykolal@fb.com, yoong.siang.song@intel.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org
References: <20250509123802.695574-1-skb99@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250509123802.695574-1-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e2c92 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=cjiv8ubDXIRvis6Dy9MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: onYZqRvaz-xhmNZgpDBhA0Bg_2NVAFhw
X-Proofpoint-ORIG-GUID: R0MOMKTa911bxpp-gYxhSAy3BRFk7zNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1OSBTYWx0ZWRfX56xS6pVkJ/Op AaqU0y3/vQntVE+eZlL6/1dkIfyGf7qZ6RZRpbH5IsxvCZ5rF0vWmRYyD3t8I+UY/kPHe1uyfIu CLJAstUPaw7QscwWXHsaBP9UclX5UsgNEW17mBs8BwrAbacx7f0TWlrTD+Mkw7tvD6TbLYaPszL
 9foTXF/T5W67d/d7XLbMgmf/uBtlWaL2UDvWUI0gt9VD4/w43iKs2Nvo2z8eUOTmyCkufXSScnf 8JxSz3kQOHNMsSWVFVsokh8mbFlptYo/8bHz2FCod1tTi52uB92Hw14HyuBMER6T8jSiLtNOxi1 d3nllFmF58bJThX1PqY/P9ez9+fjwLL96lqqGpGZ+Y4zeBP8n3nw/zEp15jm2lH81B3+t6F3BRx
 aq0uoowGdTO3+cynumusKOrTZR5AROAgx0IlABQAYi8+NnNLnGng8qiykVizDYDZojsRqj4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=941 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090159


On 09/05/25 6:08 pm, Saket Kumar Bhaskar wrote:
> On linux-next, build for bpf selftest displays a warning:
>
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
> differs from latest version at 'include/uapi/linux/if_xdp.h'.
>
> Commit 8066e388be48 ("net: add UAPI to the header guard in various network headers")
> changed the header guard from _LINUX_IF_XDP_H to _UAPI_LINUX_IF_XDP_H
> in include/uapi/linux/if_xdp.h.
>
> To resolve the warning, update tools/include/uapi/linux/if_xdp.h
> to align with the changes in include/uapi/linux/if_xdp.h
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/c2bc466d-dff2-4d0d-a797-9af7f676c065@linux.ibm.com/
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   tools/include/uapi/linux/if_xdp.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> index 42869770776e..44f2bb93e7e6 100644
> --- a/tools/include/uapi/linux/if_xdp.h
> +++ b/tools/include/uapi/linux/if_xdp.h
> @@ -7,8 +7,8 @@
>    *	      Magnus Karlsson <magnus.karlsson@intel.com>
>    */
>   
> -#ifndef _LINUX_IF_XDP_H
> -#define _LINUX_IF_XDP_H
> +#ifndef _UAPI_LINUX_IF_XDP_H
> +#define _UAPI_LINUX_IF_XDP_H
>   
>   #include <linux/types.h>
>   
> @@ -180,4 +180,4 @@ struct xdp_desc {
>   /* TX packet carries valid metadata. */
>   #define XDP_TX_METADATA (1 << 1)
>   
> -#endif /* _LINUX_IF_XDP_H */
> +#endif /* _UAPI_LINUX_IF_XDP_H */


This patch fixes the reported issue. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.


