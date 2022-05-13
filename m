Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A128A526215
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380384AbiEMMfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380421AbiEMMfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 08:35:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661F68FAB;
        Fri, 13 May 2022 05:35:12 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DABgZr016716;
        Fri, 13 May 2022 12:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gmS+Ius9bVpzAeKtBw6cRfpCwfOcAkz4Sl8pe/HmEzY=;
 b=V8N4Jxk3YLYCPI77TY9hO2yyW64qG69XlRnoxSbuZwZ6XVA4h41VfQJuRhGVhTPgBz3j
 E2KkMusH++GTSUZgR0jK90h2erykgblWol9T0mOugKoF8OJTUs+TW6IePA7/PcuxkUST
 YolMb3bCNAIPwOUm319O0mS9QEvPH+UOPjubBIi5vBUuY/si/YC8UkhIz8RMson11HbJ
 puMAl2fHEeb1+LgJlLPFkXkN3KppkywT2k80LLltaLl+fNxJdhhcJrJ+lCEJTdyDaoz1
 km3LYE9PvBhbbjAYWMZFDzq5r3qs7Yk6Kg4C7uBbD42sQBkmCbl817k9qMYuGzJVTtnw kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1mxr31gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:35:07 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24DCEmjm018706;
        Fri, 13 May 2022 12:35:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1mxr31fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:35:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DCWNvH005938;
        Fri, 13 May 2022 12:35:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk4hgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 12:35:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DCZ1ON24576452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 12:35:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A665A405F;
        Fri, 13 May 2022 12:35:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2EA3A4054;
        Fri, 13 May 2022 12:35:00 +0000 (GMT)
Received: from [9.145.187.154] (unknown [9.145.187.154])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 12:35:00 +0000 (GMT)
Message-ID: <5674a855-456f-d9b8-661f-49908aad2025@linux.ibm.com>
Date:   Fri, 13 May 2022 14:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Greg KH <greg@kroah.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
 <20220510144724.3321985-2-seiden@linux.ibm.com>
 <20220512163327.2c86cab1@p-imbrenda>
 <80afde93-b9cf-f6c4-da40-3385d7f6741b@linux.ibm.com>
 <20220513103758.5a4baf7c@p-imbrenda>
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220513103758.5a4baf7c@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Ps0IppIsUVJPjeL2BzjY9q0C5X9STDY
X-Proofpoint-ORIG-GUID: ab9qKxzQRR1a_i9e-MIGdEuf_P1BVu95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130055
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/13/22 10:37, Claudio Imbrenda wrote:
> On Fri, 13 May 2022 09:45:39 +0200
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
>> On 5/12/22 16:33, Claudio Imbrenda wrote:
>>
>> [snip]
>>
>>>> +/*
>>>> + * IOCTL entry point for the Ultravisor device.
>>>> + */
>>>> +static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>>> +{
>>>> +	void __user *argp = (void __user *)arg;
>>>> +	struct uvio_ioctl_cb *uv_ioctl;
>>>> +	long ret;
>>>> +
>>>> +	ret = -ENOMEM;
>>>> +	uv_ioctl = vzalloc(sizeof(*uv_ioctl));
>>> struct uvio_ioctl_cb is rather small, couldn't you just allocate it on
>>> the stack?
>>>    
>> IIRC it was on stack in some previous version. We then had a discussion
>> earlier about this triggered by the inverse comment and decided to not
>> use the stack.
> 
> ok fair enough
> 
> but what's the reason for a vzalloc instead of a kzalloc, when the
> allocation is surely going to be small?
> 
We had no strong reasons against or for vzalloc/kzalloc.
If you want me to change it to kzalloc I can do it. I still
have no strong opinion on that.

>> [snip]
