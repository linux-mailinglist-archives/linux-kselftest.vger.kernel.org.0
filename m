Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC84BB8D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiBRMJk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 07:09:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiBRMJj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 07:09:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79D185540;
        Fri, 18 Feb 2022 04:09:22 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IBdEws018520;
        Fri, 18 Feb 2022 12:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kiZSoymZWrUZ21eL5E5DBr3+lL3dmAn6D++X/+xOH8I=;
 b=PMrydSkxhf8Kx+mBHJdYZFO/tp6QeMvhSVU6wbzlwQ074IvDbJJjiv30hQo2ioEh62mm
 ED2RREd9UH9sdZ0nJ1k98vJVzw0LWD2o9rk/RsOtrJ6+B/oRnkZ6Vv+2qLy7NNPxizrF
 iXYjH/rGYGq7BSi3v9ZlFSzivDwejkIiRghrimrHK/gN6n+ce0/E0zgfce+7qZVCzGv+
 rFAcVAjrBYJBhd+GuwBz/iyQ5YiXFhtcc8gRjpR6FAYB2jfteA9NH8SEr7Y7KGdZkQZv
 b0CSmHtThBGh7u32HHd9vx+nGUdgFIr0gq9hgAiv6lG1B8GJF7LGhaXmvvZ9dGH5ra/e HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ea94utcrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 12:09:21 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21IBjv7D007125;
        Fri, 18 Feb 2022 12:09:20 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ea94utcq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 12:09:20 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IC82ex022802;
        Fri, 18 Feb 2022 12:09:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3e64haf7ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 12:09:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IBwlNZ45875568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 11:58:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8B88A4062;
        Fri, 18 Feb 2022 12:09:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C04CBA4054;
        Fri, 18 Feb 2022 12:09:13 +0000 (GMT)
Received: from [9.171.81.151] (unknown [9.171.81.151])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 12:09:13 +0000 (GMT)
Message-ID: <a1c0e067-cc6a-8edb-1fe9-4aa368aa6518@linux.ibm.com>
Date:   Fri, 18 Feb 2022 13:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] KVM: s390: selftests: Refactor memop test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
 <20220217145336.1794778-2-scgl@linux.ibm.com>
 <ce27dcb4-c2a3-fad6-8277-f5b86e184892@linuxfoundation.org>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <ce27dcb4-c2a3-fad6-8277-f5b86e184892@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WKL47Nh10YO_jYeg13qEB_Nw-QQz5Vng
X-Proofpoint-ORIG-GUID: SlmLjttPh4R2paLaNXGk_FajH913T4JG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_04,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/22 18:36, Shuah Khan wrote:
> On 2/17/22 7:53 AM, Janis Schoetterl-Glausch wrote:
>> Introduce macro for performing MEM_OP ioctls in a concise way.
> 
> How does this help? What is the value in re-writing existing
> code and turning it into a macro?

I want invocations of the ioctl to be independent of each other, so the reader does not
have to keep track of the state of the struct kvm_s390_mem_op.

So you have to specify all arguments manually like so, which is rather noisy and makes it
hard to see what the relevant parameter is:

ksmo.gaddr = guest_mem1;
ksmo.flags = 0;
ksmo.size = maxsize;
ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
ksmo.buf = (uintptr_t)mem1;
ksmo.ar = 17;
rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);

Or you introduce an abstraction.
Previously I used lots of functions with repeated code which got chaotic.
I decided on the macro because it's more flexible, e.g. you don't have to pass default args.
For example, there is only one test that passes the access register arg, so you would want
to default it to 0 for all other test.
For the access key argument you need to pass both a flag and the key itself, so you'd probably
get rid of this redundancy also.
There also might be future extensions of the ioctl that work the same way
(not 100% but not purely theoretical either).

With the macro all that is orthogonal, you just pass the argument you need or you don't.
With functions you'd maybe add a memop_key() variant and a _ar() variant and a _key_ar()
variant if you need it (currently not necessary), doubling the number of functions with
each additional argument. Another example is GADDR_V and GADDR, the first takes care of
translating the address to an physical one, but sometimes you need to pass it untranslated,
and we need to combine that with passing a key or not.

A big improvement was making the target of the ioctl (vm/vcpu) and the operation arguments
instead of baking it into the function. Since they're mandatory arguments this is independent
of the macro vs functions question.

In the end there are multiple independent but interacting improvements and it is kinda
hard to make the call on how far to go along one dimension, e.g. I was unsure if I
wanted to introduce the DEFAULT_READ macro, but decided for it, since, as a reviewer,
you can see that it executes the same code with different arguments, instead of trying
to identify the difference between 5 copy-pasted and modified lines of code. On the other
hand you have the cost of introducing an indirection.
> 
> 
>> Split test cases into multiple host/guest pairs making them independent.
> 
> This is a good change.
> 
>> Make various minor improvements.
>> All in all this lays the groundwork for future extensions.
> 
> Also good if these changes make it easier to add test. Would be helpful
> to know the details of the groundwork.

Yeah I'm not too happy about the commit descriptions.
I was unsure how to structure the patches, since the new test motivate
the restructuring, e.g. if I put the _test_errors_common in the first patch
it's kinda weird since at that stage there is no commonality at all.
I ended up moving stuff around + since I'm not quite sure about stuff like the DEFAULT_
macros I left the description kinda vague.

Probably should have linked to the series this is a reply to, since linux-kselftest wasn't on cc:
https://lore.kernel.org/kvm/20220211182215.2730017-1-scgl@linux.ibm.com/

> 
> thanks,
> -- Shuah

