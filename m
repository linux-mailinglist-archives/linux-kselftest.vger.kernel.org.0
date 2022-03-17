Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82AE4DC476
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiCQLJb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiCQLJa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 07:09:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E913EB1;
        Thu, 17 Mar 2022 04:08:14 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HAuDsa021666;
        Thu, 17 Mar 2022 11:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2a6NX32i0fjMUVzjufDPdk9mpLpUddUjkJfO+NmQZGk=;
 b=QNGUeXmjv/Oo5bHcyRrUnYNUD2w1cBq5g/0E9gKBJi9gNUzMr7OStqvUCcQX0xYDGG7Z
 s6eGbKhVvrdSybuKHSY04TO3Ii+9C9eedAF3tSCK6oCVvAF2F8ZGxPmtvYloBo0S7R0p
 OhY23ICeqd+j13nehSBek6AHFK+kh+ekjoFWjwEEW0YaUYZxOBAc8fi28U1TSWj96eoa
 qjuFbv4IAmmYiHz3w5WWCaEx8CAwrqisocoCs30wwp3GJLc1Km/3DF2tRt2p/DT6oVUk
 wxB9xftuOJKPfs515zdjZStUUf1vwPy0Rz/goRp9wlClLOR1kTlj9Bg7g94C6HSYW5F8 Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3euvh1g14v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:08:04 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HAXjr3019309;
        Thu, 17 Mar 2022 11:08:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3euvh1g148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:08:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HB2vWC001979;
        Thu, 17 Mar 2022 11:08:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3erk5935dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:08:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HB7xwY55378208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 11:07:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F149BA4055;
        Thu, 17 Mar 2022 11:07:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CCD3A4053;
        Thu, 17 Mar 2022 11:07:58 +0000 (GMT)
Received: from [9.145.148.38] (unknown [9.145.148.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Mar 2022 11:07:58 +0000 (GMT)
Message-ID: <6175e7fa-070e-8ab2-843a-8019d0dc0c83@linux.ibm.com>
Date:   Thu, 17 Mar 2022 12:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 1/4] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        david@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, nrb@linux.ibm.com, shuah@kernel.org
References: <20220304141141.32767-2-seiden@linux.ibm.com>
 <20220317094706.4921-1-seiden@linux.ibm.com> <YjMGgSstSCZAmcVa@kroah.com>
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <YjMGgSstSCZAmcVa@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9L-eVfnvB6BgwtUNkaFb8gjLp_Zrnv4g
X-Proofpoint-ORIG-GUID: rPEBkZtDaCUvipmQ3TmbMvKLBgmPoqvG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=641 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203170066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi greg,

On 3/17/22 10:59, Greg KH wrote:
> On Thu, Mar 17, 2022 at 09:47:06AM +0000, Steffen Eiden wrote:
>> This patch adds a new miscdevice to expose some Ultravisor functions
>> to userspace. Userspace can send IOCTLs to the uvdevice that will then
>> emit a corresponding Ultravisor Call and hands the result over to
>> userspace. The uvdevice is available if the Ultravisor Call facility is
>> present.
>> Userspace can call the Retrieve Attestation Measurement
>> Ultravisor Call using IOCTLs on the uvdevice.
>>
>> The uvdevice will do some sanity checks first.
>> Then, copy the request data to kernel space, build the UVCB,
>> perform the UV call, and copy the result back to userspace.
>>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
> Do you have a pointer to the userspace code that interacts with this
> kernel driver?  That would be good to have to verify that the api here
> is sane.
> 
There is a userspace tool currently under development, however, not yet 
ready to be published.
Currently, I can only point to the Kselftest in this series and the 
kvm-unit-tests at 
https://lore.kernel.org/linux-s390/20220203091935.2716-1-seiden@linux.ibm.com/


> thanks,
> 
> greg k-h
> 

steffen
