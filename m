Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404F24DC4C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 12:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiCQLYs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiCQLYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 07:24:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCB3D483;
        Thu, 17 Mar 2022 04:23:27 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H9ca0N008079;
        Thu, 17 Mar 2022 11:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MsvfyV47vlMqk+MO9HkKITZ6qtx3F2pqKOadRs8Kylg=;
 b=GPLDobNJ0/mUpQwyezfV+3zMiVHlj2YImWiG4ynzf6qlf9vcc5FmLdzjTQAJTbRQSCPg
 Dlh4W5TjnF3wJSfsKPI4v7fL46iOsrtBasijCkSMunwwVi82tYeab6V/Ob9imc7OHCTc
 BrCPKAKyX9suSnI8/NxtKMEOozw7+gegpaeTj+APjyh23jHuoMhp5l1Z76KmiVZaY74R
 OXRutk11L7h3IOgx4Vb9Ct7sGgI8dnoXtiUneQbxaivNeGaU7HygpmFHXuy7XCl6kAqG
 fEMxe1wLhWAlLYFNZ3ZbOM/WymjReiJX08WlmQkC3xbKzDZyRJQ3eqh+FDTChmNDy3CZ rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev0m5uvcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:23:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HBNM4X032298;
        Thu, 17 Mar 2022 11:23:22 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev0m5uvbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:23:22 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HBCeqV004931;
        Thu, 17 Mar 2022 11:23:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3erk58sh31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:23:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HBNHUL20447586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 11:23:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71625A4051;
        Thu, 17 Mar 2022 11:23:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0D7FA4057;
        Thu, 17 Mar 2022 11:23:16 +0000 (GMT)
Received: from [9.145.148.38] (unknown [9.145.148.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Mar 2022 11:23:16 +0000 (GMT)
Message-ID: <859962fd-cb55-42ea-78f0-75677953bb58@linux.ibm.com>
Date:   Thu, 17 Mar 2022 12:23:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 1/4] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Greg KH <greg@kroah.com>
Cc:     agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        david@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, nrb@linux.ibm.com, shuah@kernel.org
References: <20220304141141.32767-2-seiden@linux.ibm.com>
 <20220317094706.4921-1-seiden@linux.ibm.com> <YjMGgSstSCZAmcVa@kroah.com>
 <6175e7fa-070e-8ab2-843a-8019d0dc0c83@linux.ibm.com>
Organization: IBM
In-Reply-To: <6175e7fa-070e-8ab2-843a-8019d0dc0c83@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MHRup0zxH3rFLprwnK-dtrKuzDuS0nec
X-Proofpoint-ORIG-GUID: bFUNJY7u-T8z1xznRrbnvoZLQEeLWEQi
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=638 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170066
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

On 3/17/22 12:07, Steffen Eiden wrote:
> Hi greg,
> 
> On 3/17/22 10:59, Greg KH wrote:
>> On Thu, Mar 17, 2022 at 09:47:06AM +0000, Steffen Eiden wrote:
>>> This patch adds a new miscdevice to expose some Ultravisor functions
>>> to userspace. Userspace can send IOCTLs to the uvdevice that will then
>>> emit a corresponding Ultravisor Call and hands the result over to
>>> userspace. The uvdevice is available if the Ultravisor Call facility is
>>> present.
>>> Userspace can call the Retrieve Attestation Measurement
>>> Ultravisor Call using IOCTLs on the uvdevice.
>>>
>>> The uvdevice will do some sanity checks first.
>>> Then, copy the request data to kernel space, build the UVCB,
>>> perform the UV call, and copy the result back to userspace.
>>>
>>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>
>> Do you have a pointer to the userspace code that interacts with this
>> kernel driver?  That would be good to have to verify that the api here
>> is sane.
>>
> There is a userspace tool currently under development, however, not yet 
> ready to be published.
> Currently, I can only point to the Kselftest in this series and the 
> kvm-unit-tests at 
> https://lore.kernel.org/linux-s390/20220203091935.2716-1-seiden@linux.ibm.com/ 
> 
I forgot to point out that the Attestation userspace tool will be 
open-source and included in the s390-tool package.
I can send you the current state of that tool in private if you want.

> 
> 
>> thanks,
>>
>> greg k-h
>>
> 
> steffen

steffen
