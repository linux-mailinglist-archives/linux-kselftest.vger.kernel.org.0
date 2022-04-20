Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED625085F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 12:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351746AbiDTKg5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 06:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiDTKg4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 06:36:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56813F8B7;
        Wed, 20 Apr 2022 03:34:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K919nX024979;
        Wed, 20 Apr 2022 10:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PpX6WuxG/jalbB31OImhOuSRHOCLWrsapvSdJsAGK1Y=;
 b=earW7e0HaCWAqyBaPd5U1v0HzHNL6Km3e+miRZjUb0UiEsRimOfEl2PxveQXd0V4jJeU
 qY96xYTUkzfm/nsZIecn1Trat10vjBBNTi8H9mW9C+0kBSFRA7WDF56CHoQUNkhCnMRw
 5q0thnzKAS0EqjGvdeutmnAVpFRBm0xbjpXKCXobPdtuluSUGtUrmA0rgU3fmOfcaWds
 /wXgz4GnGIwNrXfyI4pthbLILjm7MDaUctOld5bEXrSsuzZ6jmPyBiq2N8q94tUD1Dve
 l2cP7gNHh9HvtNcU5+1PUb4UlGFV++/DYppNN0IevOy0zdM5SODO+nNXPIqONpH0QQgh BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhuukb7sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:34:07 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23K9qflQ029579;
        Wed, 20 Apr 2022 10:34:07 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhuukb7rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:34:06 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KARmrr016525;
        Wed, 20 Apr 2022 10:34:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3ffvt9cew4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:34:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KALEGk53281106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 10:21:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A64EAAE059;
        Wed, 20 Apr 2022 10:34:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FEB2AE056;
        Wed, 20 Apr 2022 10:34:01 +0000 (GMT)
Received: from [9.145.164.14] (unknown [9.145.164.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 10:34:01 +0000 (GMT)
Message-ID: <fb468756-2f80-3e0b-91d9-8e6a0679f36c@linux.ibm.com>
Date:   Wed, 20 Apr 2022 12:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20220419185857.128351-1-thuth@redhat.com>
 <20220419185857.128351-5-thuth@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] KVM: s390: selftests: Use TAP interface in the
 reset test
In-Reply-To: <20220419185857.128351-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: isTQJwZiTYD7a-wuVFkHyAuRqCEYN0-F
X-Proofpoint-GUID: T0QPBP9OvwGQAnm-0EX5pfpxfpOiL-Q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_02,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200065
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/19/22 20:58, Thomas Huth wrote:
> Let's standardize the s390x KVM selftest output to the TAP output
> generated via the kselftests.h interface.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

[...]
> -	return 0;
> +
> +	ksft_finished();

main() is still int so it looks really weird, that we remove the return 
here. After reading the ksft_finished() code I know that we never return 
because we do an exit() but I'd like to have a comment, change to void 
or noreturn tag to make this clearer.

I'd guess that's true for all 4 patches.

>   }

