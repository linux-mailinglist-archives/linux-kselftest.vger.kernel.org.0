Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA74EF914
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350513AbiDARma (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350482AbiDARm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 13:42:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A114B843;
        Fri,  1 Apr 2022 10:40:39 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231GJT4o017900;
        Fri, 1 Apr 2022 17:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XHoH67PGA72qyhjjgtkwClKk3acuJgRp8YcrEaqS3Pc=;
 b=LAkbIbrWRHRPp/C1oy7GH6GfHjhzgOnsZ7/1hxdfH974+DpGoUDBZPtQ1mB9x9jOEyTK
 ZdTbfV4q3NG56Y6/16UGYgHxYOS2adl53JoGqQ3P0LDaLLya1WoNqPwd42QfwYodWhLP
 q0oA2KdFZ/qe74VNnsWn50m7EWyyDVFQb+SGUvTYUfNHNBw5dfra1gamDcDUS3F0HcZz
 yViNeDYjhvoeuJcOhFpkYtl/XJp5iIf8nloFLocGhkHEcgOjvy4gnYrZYomnAN/0vKHV
 Cek5m+SALCmXXKBWvOQSco/bvlZFUwi0YRBXgue8oYGXlf/MAR2kJjHrxKst7SxLXqfY /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f64tdhm86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:40:37 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 231HRvQO010118;
        Fri, 1 Apr 2022 17:40:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f64tdhm7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:40:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 231HYAg0001987;
        Fri, 1 Apr 2022 17:40:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3f1tf9nfy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:40:34 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 231HeV7i53215640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 17:40:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2945011C04C;
        Fri,  1 Apr 2022 17:40:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D38C11C04A;
        Fri,  1 Apr 2022 17:40:30 +0000 (GMT)
Received: from [9.171.85.89] (unknown [9.171.85.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Apr 2022 17:40:30 +0000 (GMT)
Message-ID: <6f385869-3f3b-d985-6804-02943a8dee07@linux.ibm.com>
Date:   Fri, 1 Apr 2022 19:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] KVM: s390: Don't indicate suppression on dirtying,
 failing memop
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220401170247.1287354-1-scgl@linux.ibm.com>
 <20220401170247.1287354-2-scgl@linux.ibm.com>
 <e191fbc0-9471-5cde-7698-cdd32d83051f@linux.ibm.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <e191fbc0-9471-5cde-7698-cdd32d83051f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6TEJYwhOAQh6ZcCWjo3z149zDPU4tiCh
X-Proofpoint-GUID: CgxRsK4QBiTIwikhTuqjAbIBFto1FQWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=689 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204010084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/1/22 19:13, Christian Borntraeger wrote:
> 
> 
> Am 01.04.22 um 19:02 schrieb Janis Schoetterl-Glausch:
>> If user space uses a memop to emulate an instruction and that
>> memop fails, the execution of the instruction ends.
>> Instruction execution can end in different ways, one of which is
>> suppression, which requires that the instruction execute like a no-op.
>> A writing memop that spans multiple pages and fails due to key
>> protection can modified guest memory. Therefore do not indicate a
>> suppressing instruction ending in this case.

A writing memop that spans multiple pages and fails due to key
protection can modified guest memory, as a result, the likely
correct ending is termination. Therefore do not indicate a
suppressing instruction ending in this case.

?

It's phrased a bit vaguely, because we don't really know what user space wants
when emulating an instruction, I guess it could try to revert the changes?
And the TEID does not indicate termination, it only indicates that
the guest cannot assume that the instruction was suppressed.

> 
> Make it explicit in the changelog that this is "terminating" instead of
> "suppressing". z/VM has the same logic and the architecture allows for
> terminating in those cases (even for ESOP2).
>  >
>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>> ---
