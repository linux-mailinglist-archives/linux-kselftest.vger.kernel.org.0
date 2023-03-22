Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0696C4EF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCVPGu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCVPGt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 11:06:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FDC67805;
        Wed, 22 Mar 2023 08:06:29 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MEJrIL029634;
        Wed, 22 Mar 2023 15:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=We4TAfGqbYV8zr38XP2HZI4NEqPgTicFa9IDGOaG/Kc=;
 b=ksmj6/xvmKebNtGArH9hfkzgpxisumf6ikD1DocrPOiR26Igqou5fmgyupLePc46GxRa
 T5a3m77lp82oCarOHxP/sEmEYvRr1MLVEDYXc5MaCVRFzLpDOE7c2eAwrNYCxjnVh9dO
 tUHnblKcF/YMvpJO2XFYKnjDxeEbiobpM0b0OaqUD5NoEsgyNagBaHuIyD0M3FyHqVcO
 j2+zFBr0Ouj0nsgLvjoquUO3O8V4PXHQN0/Q87SNlWew28fLkumaktvzA3HGNz7vGr59
 vG7xAqvEbuRtkRVj1hQG1DkQoIV2qUf8JGbv70gf/seDmyOgKoVDq3kwEpNmjGvk1Eno Jw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg1fan1e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 15:06:25 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0adOF003363;
        Wed, 22 Mar 2023 15:06:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6d3jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 15:06:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32MF6KjV21037574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:06:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07DA22005A;
        Wed, 22 Mar 2023 15:06:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC8422004D;
        Wed, 22 Mar 2023 15:06:19 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 15:06:19 +0000 (GMT)
Date:   Wed, 22 Mar 2023 16:06:17 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/2] KVM: s390: CMMA migration selftest and small
 bugfix
Message-ID: <20230322160617.37b05b90@p-imbrenda>
In-Reply-To: <167949723863.87786.17316594054151666220@t14-nrb>
References: <20230208144827.131300-1-nrb@linux.ibm.com>
        <167949723863.87786.17316594054151666220@t14-nrb>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AZvlrjuG88fgqidLfmGU0iSmWj2d9wZO
X-Proofpoint-ORIG-GUID: AZvlrjuG88fgqidLfmGU0iSmWj2d9wZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=994
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220106
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 22 Mar 2023 16:00:38 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> Quoting Nico Boehr (2023-02-08 15:48:25)
> > Add a new selftest for CMMA migration. Also fix a small issue found during
> > development of the test.
> > 
> > Nico Boehr (2):
> >   KVM: s390: selftests: add selftest for CMMA migration
> >   KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
> > 
> >  arch/s390/kvm/kvm-s390.c                      |   4 +
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  tools/testing/selftests/kvm/s390x/cmma_test.c | 679 ++++++++++++++++++
> >  3 files changed, 684 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c  
> 
> Polite ping.

oops this had fallen off my radar

I'll have a look at it ASAP
