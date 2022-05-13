Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADA525C7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377851AbiEMHpz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351043AbiEMHpx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 03:45:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C02BE27;
        Fri, 13 May 2022 00:45:51 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D7hKPb034229;
        Fri, 13 May 2022 07:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XH60+iE4KQaUMkuCpdgG51B45zzc/i0J0KkV0et3RIY=;
 b=obX4JsVrG74g80WwJJGlmp5UUou56HiV9ohIq7KS4Vg0mYa8zl0CfSz5/GiU6lAbuf2L
 5txEtMBgcRgdhe0o+V5NocRf/+pMk/QWR112Sgc67PcLLihVtF+Y/0GGdcUGOyJN3BFz
 38sVYtzBmAm/Gct4gA50MfHDYyOSNs/BeTJRPJs+dS6YvANkW+Zu6KI1dXGcqEHXj13C
 xOL7G2Ig31clV/2b7YQohljDOcPNFWmRigpsEtVXT9QjB+g7F4QUY3+RNGYFUUx04XAd
 Sy90afFpvPRBnOeVgNMaPFdaR4loOVn5LByslMOrM8VEwxSc0uyIuvS1ZnkS/uRzQJ8/ hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1k6d01av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 07:45:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24D7jjMR003320;
        Fri, 13 May 2022 07:45:45 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1k6d01a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 07:45:45 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24D7XUXf011467;
        Fri, 13 May 2022 07:45:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3fwgd8xdu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 07:45:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24D7jHYK26673592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 07:45:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 132E5A4060;
        Fri, 13 May 2022 07:45:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A009CA4054;
        Fri, 13 May 2022 07:45:39 +0000 (GMT)
Received: from [9.145.187.154] (unknown [9.145.187.154])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 07:45:39 +0000 (GMT)
Message-ID: <80afde93-b9cf-f6c4-da40-3385d7f6741b@linux.ibm.com>
Date:   Fri, 13 May 2022 09:45:39 +0200
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
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220512163327.2c86cab1@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hgKQP7T049ACNXLuelJthVCo7Ko4XR5u
X-Proofpoint-ORIG-GUID: PoJeDmkkth4nVl1WJ2xlyIMh0Cf_V8R2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_02,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130033
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/12/22 16:33, Claudio Imbrenda wrote:

[snip]

>> +/*
>> + * IOCTL entry point for the Ultravisor device.
>> + */
>> +static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>> +{
>> +	void __user *argp = (void __user *)arg;
>> +	struct uvio_ioctl_cb *uv_ioctl;
>> +	long ret;
>> +
>> +	ret = -ENOMEM;
>> +	uv_ioctl = vzalloc(sizeof(*uv_ioctl));
> struct uvio_ioctl_cb is rather small, couldn't you just allocate it on
> the stack?
> 
IIRC it was on stack in some previous version. We then had a discussion
earlier about this triggered by the inverse comment and decided to not 
use the stack.

[snip]

