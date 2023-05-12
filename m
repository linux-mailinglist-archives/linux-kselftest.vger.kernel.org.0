Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4A1700152
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 09:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbjELHVe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjELHUo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 03:20:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680052689;
        Fri, 12 May 2023 00:20:42 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C79s53025587;
        Fri, 12 May 2023 07:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YYOSn4U1MhqyoYEGVbgEkoVO46zkgsZoG+XmtnWgVds=;
 b=gOtvv6gI2X2njP6UQTMbZnl04+BE+bd1FrQyWwA9OMOvRPTe3BpyGf3I8htIgm347w+s
 x4kDHCVohCeTZZdvuLazorLHMtI6kJr3OFeeshTng8DJxgd+k/bmqljwpjzP6pFm1EZr
 7nyxAwiWKoKvg4wXBz0Gc5uSjaT7NUkAnG0QyJRzN0dJatnMcNWnbcttThNGVif/c3hv
 ENlJe21NPKlzHcL64xO/jvByKLNzxwBqhsEObWp//ADtsr5WlVtYdGHYR//nG2sfogmr
 W3C2JRuJcJ41N6vkRuAvjiWDV+0a6sf3aKrEzuz1n/WhM82NNgY4iNCDf+Mq7AylEewx 3g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhg0w1wt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:20:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34BL9TOX007034;
        Fri, 12 May 2023 07:20:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qf896t6ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:20:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34C7KWvU47513934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 07:20:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63D0520063;
        Fri, 12 May 2023 07:20:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1464D2004F;
        Fri, 12 May 2023 07:20:32 +0000 (GMT)
Received: from [9.171.66.102] (unknown [9.171.66.102])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 12 May 2023 07:20:32 +0000 (GMT)
Message-ID: <56258345-3e3c-3acd-e240-a0b348eb9df3@linux.ibm.com>
Date:   Fri, 12 May 2023 09:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in
 memslot holes
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230324145424.293889-1-nrb@linux.ibm.com>
 <20230324145424.293889-2-nrb@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230324145424.293889-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1ZI_67EOK9umRujf4TPJ82qfnF4gPvVG
X-Proofpoint-GUID: 1ZI_67EOK9umRujf4TPJ82qfnF4gPvVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxlogscore=784 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120059
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/24/23 15:54, Nico Boehr wrote:
> The KVM_S390_GET_CMMA_BITS ioctl may return incorrect values when userspace
> specifies a start_gfn outside of memslots.
> 
> This can occur when a VM has multiple memslots with a hole in between:
> 
> +-----+----------+--------+--------+
> | ... | Slot N-1 | <hole> | Slot N |
> +-----+----------+--------+--------+
>        ^          ^        ^        ^
>        |          |        |        |
> GFN   A          A+B      |        |
>                            A+B+C    |
> 			           A+B+C+D
> 
> When userspace specifies a GFN in [A+B, A+B+C), it would expect to get the
> CMMA values of the first dirty page in Slot N. However, userspace may get a
> start_gfn of A+B+C+D with a count of 0, hence completely skipping over any
> dirty pages in slot N.
> 
> The error is in kvm_s390_next_dirty_cmma(), which assumes
> gfn_to_memslot_approx() will return the memslot _below_ the specified GFN
> when the specified GFN lies outside a memslot. In reality it may return
> either the memslot below or above the specified GFN.
> 
> When a memslot above the specified GFN is returned this happens:
> 
> - ofs is calculated, but since the memslot's base_gfn is larger than the
>    specified cur_gfn, ofs will underflow to a huge number.
> - ofs is passed to find_next_bit(). Since ofs will exceed the memslot's
>    number of pages, the number of pages in the memslot is returned,
>    completely skipping over all bits in the memslot userspace would be
>    interested in.
> 
> Fix this by resetting ofs to zero when a memslot _above_ cur_gfn is
> returned (cur_gfn < ms->base_gfn).
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Does this need a fix tag?

