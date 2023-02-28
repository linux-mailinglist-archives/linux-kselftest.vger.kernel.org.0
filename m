Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8596A564D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjB1KHH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 05:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjB1KGl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 05:06:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764820550;
        Tue, 28 Feb 2023 02:06:29 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S9UHV0002540;
        Tue, 28 Feb 2023 10:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DC9JyX/aZ76UEG07OM6Yh20Kp+9JipCq1FCKnvIfMS8=;
 b=nXYFCRtljWpPuSTPwP4dt7aBa9tV3qvaRUjbp8EDFAKwqducPafqrGHFpRtegwtyFou3
 SXB/nHZwZ7ic4eSrbVE+bFiWyf5n9ZNZmGcxmkCOI0tHmCmTGG9AYBLTadBiwDVTiX3q
 cTsvb4MmlZIuSFxKKmvEk7108UQKNI2yeaNG/wEHzwG7BDgiuaW4t9V7cH3L9GmUq3M2
 YXWDtio/jnA2m+utf7moSn+YZliUgi/Xtuuj7TWwVQ0O55XN4MQELVGFuIeWwQOtfPSv
 E5r9AQLOBmbt5HDl1NXN6EG+tbLBpKDIHw8Oz15lr1kSRXtvTpVo5ReIVXqZXuhYYQfg mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1f1rru05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 10:06:17 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31S9kiRf008101;
        Tue, 28 Feb 2023 10:06:16 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1f1rrty2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 10:06:16 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31S4cRNl027360;
        Tue, 28 Feb 2023 10:06:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nybb4jx5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 10:06:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31SA6BSG63111512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 10:06:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51C2C20078;
        Tue, 28 Feb 2023 10:06:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7BBA20087;
        Tue, 28 Feb 2023 10:06:09 +0000 (GMT)
Received: from [9.43.45.146] (unknown [9.43.45.146])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Feb 2023 10:06:09 +0000 (GMT)
Message-ID: <d989254a-a3c4-615e-59cb-96667d0a63b3@linux.ibm.com>
Date:   Tue, 28 Feb 2023 15:36:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Possible bug in
 linux-6.2/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        David Binderman <dcb314@hotmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <DB6P189MB0568CF002762C6C43AF6DF169CA89@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
 <87ttz7vfva.fsf@mpe.ellerman.id.au>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <87ttz7vfva.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EMjlDNBoysmWaiMjZQp-kx9JEn3zS6dK
X-Proofpoint-GUID: 6GEeOT3WAZFnXJYgNfezphSvxdiUCQKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_06,2023-02-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/27/23 10:56, Michael Ellerman wrote:
> David Binderman <dcb314@hotmail.com> writes:
>> Hello there,
>>
>> I ran the static analyser cppcheck over the linux-6.2 source code and got this:
>>
>> linux-6.2/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c:68:10: style: Same expression '0x3' found multiple times in chain of '&' operators. [duplicateExpression]

Hi,
  Thanks David for reporting it.

> 
> Thanks.
> 
>> Source code is
>>
>>     FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample & 0x3) !=
>>             get_mmcra_sample_mode(get_reg_value(intr_regs, "MMCRA"), 4));
>>
>> but
>>
>> #define EV_CODE_EXTRACT(x, y)   \
>>     ((x >> ev_shift_##y) & ev_mask_##y)
>>
>>
>> Given the token pasting, I very much doubt an expression like "sample & 0x3"
>> will work correctly. Same thing on the line above 
>>
>>     FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample >> 2) !=
>>             get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4));
>>
>> "sample >> 2" doesn't look like a valid token to me.
> 
> It expands to:
> 
>  if ((((event.attr.config >> ev_shift_sample >> 2) & ev_mask_sample >> 2) != get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4))) 
> 
> Which AFAICS is valid, and does compile.
> 
> Whether it's what the author actually intended is less clear.
> 
> And the other example with & 0x3 seems obviously wrong, it expands to:
> 
>   if ((((event.attr.config >> ev_shift_sample & 0x3) & ev_mask_sample & 0x3) != get_mmcra_sample_mode(get_reg_value(intr_regs, "MMCRA"), 4)))
> 
> The shift is 24, so bitwise anding it with 0x3 gets 0 which doesn't seem
> likely to be what was intended.
> 

Hi Michael,
   Thanks for checking it. The intention is to check 3 bits of
rand_samp_elig field and 2 bits of rand_samp_mode field from the
sampling bits. Basically we first want to extract that sample field
using EV_CODE_EXTRACT macro and then fetch required value of
rand_samp_elig and rand_samp_mode, to compare it with MMCRA bits.

Right approach to do that would be:

 FAIL_IF((EV_CODE_EXTRACT(event.attr.config, sample) >> 2) !=
get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4));

 FAIL_IF((EV_CODE_EXTRACT(event.attr.config, sample) & 0x3) !=
get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4));

I will send a fix patch for same.

Thanks,
Kajol Jain

> cheers
