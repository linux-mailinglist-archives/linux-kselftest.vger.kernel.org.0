Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DE624174
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 12:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKJLcV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 06:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKJLcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 06:32:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D269DE7;
        Thu, 10 Nov 2022 03:32:19 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA9Pkjp025543;
        Thu, 10 Nov 2022 11:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=odZuaOXgEcwiho7Vd2GAbLiA+e2NrRx88L45LQeNahE=;
 b=EZi+25v8sryaW8fEM75ehr8FVbpNmo3mylj9O4AtJtQ0wYUzIb+hXNE53l5emNjgR8aJ
 Mqpft2y0BP4isxOo2sol6rQitBX2MIGnA0ygp2pJx6czXpl45ebO8IMP7ADkJJH1g73W
 5IijTUw4VD+hebsN4NJrbRM7Bkn5C5dqsDQlWt6sz+upDALcp6no76U3jSRuIX8bZgJT
 9PgrahvovMCO4aOr50T3yUYgpJTk+7I4iRXFogPFITuQAYpWsP0aGDteufhyqL1qtJtZ
 dyuC6Adu7TjnthNfhXEtsgZfeQPWt9WidVd1ZdXBSeJjbV+/edYzWRD958YKqfP3mh20 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krt47ts2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:32:14 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AAA0kCJ028787;
        Thu, 10 Nov 2022 11:32:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krt47ts1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:32:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AABK7ob023805;
        Thu, 10 Nov 2022 11:32:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3kngncf5xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:32:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AABW7Yq48038364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 11:32:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C59D54203F;
        Thu, 10 Nov 2022 11:32:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5641F42041;
        Thu, 10 Nov 2022 11:32:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 10 Nov 2022 11:32:07 +0000 (GMT)
Date:   Thu, 10 Nov 2022 12:32:06 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 5/5] s390/uaccess: add cmpxchg_user_key()
Message-ID: <Y2zhNhFjIJPKJao8@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
 <Y2J8axs+bcQ2dO/l@osiris>
 <f604b6038c4a8bad5123e1f1f14b15c2190f28e9.camel@linux.ibm.com>
 <Y2womHanaMzETfwU@osiris>
 <31fcea80f54c5f53012489f29ebedba775672919.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31fcea80f54c5f53012489f29ebedba775672919.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xMeGjM2OJvIUyAXqdE8wcNt8zu9RJW95
X-Proofpoint-ORIG-GUID: 404XSrVZL5FeLDEDpoiKtGoeSK6bN-Sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_08,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=965
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 10, 2022 at 12:01:23PM +0100, Janis Schoetterl-Glausch wrote:
> On Wed, 2022-11-09 at 23:24 +0100, Heiko Carstens wrote:
> > On Wed, Nov 09, 2022 at 04:46:29PM +0100, Janis Schoetterl-Glausch wrote:
> > > Are you only entertaining cosmetic changes to cmpxchg.h?
> > 
> > I fail to parse what you are trying to say. Please elaborate.
> > 
> > > The loop condition being imprecise seems non-ideal.
> > 
> > What exactly is imprecise?
> 
> The loop retries the CS if bits outside the target byte changed instead
> of retrying until the target byte differs from the old value.
> So if you attempt to exchange (prev_left_0 old_byte prev_right_0) and 
> that fails because the word at the address is (prev_left_1 x prev_right_1)
> where both x != old_byte and one of the prev_*_1 values differs from the respective
> prev_*_0 value, the CS is retried. If there were a native 1 byte compare and swap,
> the exchange would just fail here. Instead the loop retries the CS until the margin
> values are stable and it can infer from that that the CS failed because of the target value.
> (Assuming that doesn't change to the old_byte value.)
> 
> It's not a problem, but it struck me as non-ideal, which is why for v2 I inverted the mask
> after using it to punch the hole for the old/new values.
> Then you can use it to test if bits inside the target byte differ.
> 
> That's why I asked about cmpxchg.h. If you don't want non-cosmetic changes to the existing
> cmpxchg function and consistency of the new key checked function, then obviously the loop
> condition needs to be the same.

Such a change is fine of course, even though compare-and-swap for one and
two byte patterns don't really matter. I would appreciate if you could send
one or two patches on-top of this series which adds the improved logic to
(now) both variants.

And, since the question will come up anyway: as soon as we agreed on a
complete patch series, I think we should go for a features branch on s390's
kernel.org tree which would contain the first five patches sent by me plus
potential addon patches provided by you.
This tree can then be pulled in by the kvms390 tree where your kvm specific
patches can then be applied on top.
