Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33D50F0FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 08:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiDZGeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 02:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDZGeU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 02:34:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10C713F4D;
        Mon, 25 Apr 2022 23:31:14 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q5isIG020438;
        Tue, 26 Apr 2022 06:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mAX2bsUVbkv/8cRjWiW2Mu16UsMh5blyASeO+thwKYM=;
 b=I4lKz3nGlK2D7ASmAWdxQN4I4yXsbC9sYUho9Rvcd3nXhnJIJkPDPDLrncfX4FgD0Qvl
 M0MlkxQBOb7MjB+5GZMvnWsQqj1z1KeG5cSwC/6WkJU2ilmsqOUe/ZQj2ktJYQI1xdoi
 KeFQx2Dwls+qXZtUd3V8wX25gX5RvgCoOTZ6E15jh5wW6CUi2Mtou6HVl3z8q3qcd5zG
 x6cxOx1ivlTdC7M7qZN1inSvv6a1AFXuRzHZZ5ksuZO44nILH4oGACwlJflt5CrhaMdm
 hnazYPbbxqErMbNwGJCbVD4zeeeO8YRazDVPhEp1laNXu3d5vvfUGbDJRxIGGXhwJvQW Rw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpav30sh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:30:48 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q6SQ2X016524;
        Tue, 26 Apr 2022 06:30:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938tx75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:30:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q6UhN743975144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 06:30:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 215EF11C066;
        Tue, 26 Apr 2022 06:30:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6024311C052;
        Tue, 26 Apr 2022 06:30:38 +0000 (GMT)
Received: from [9.43.83.251] (unknown [9.43.83.251])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 06:30:37 +0000 (GMT)
Message-ID: <0e4b0f8e-6c45-8d14-303f-2168f5004a12@linux.ibm.com>
Date:   Tue, 26 Apr 2022 12:00:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] selftests/powerpc/pmu: Fix unsigned function returning
 negative constant
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1650788802-14402-1-git-send-email-baihaowen@meizu.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <1650788802-14402-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wykWsiy-h7xfZzWLpfSChGTzFHIQ50j8
X-Proofpoint-GUID: wykWsiy-h7xfZzWLpfSChGTzFHIQ50j8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260040
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/24/22 13:56, Haowen Bai wrote:
> The function __perf_reg_mask has an unsigned return type, but returns a
> negative constant to indicate an error condition. So we change unsigned
> to int.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
> index fca054bbc094..c01a31d5f4ee 100644
> --- a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
> +++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
> @@ -274,7 +274,7 @@ u64 *get_intr_regs(struct event *event, void *sample_buff)
>  	return intr_regs;
>  }
>  
> -static const unsigned int __perf_reg_mask(const char *register_name)
> +static const int __perf_reg_mask(const char *register_name)
>  {

Hi Haowen,
 Thanks for correcting it. Can you also add fix tag with corresponding
commit id details.

Other than that patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain


>  	if (!strcmp(register_name, "R0"))
>  		return 0;
