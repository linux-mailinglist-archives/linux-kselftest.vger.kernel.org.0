Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0877706B36
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEQOfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 10:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjEQOfK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 10:35:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1C272BB;
        Wed, 17 May 2023 07:35:09 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HEY5CQ028967;
        Wed, 17 May 2023 14:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=XV543IhCd2Bpd07S0y+6zMd4kb7cCwwJDkuKr5netPY=;
 b=N9F87kYgRbM6I+iBA00itDCGtKJTVSUDdIsoKrTzG/uHA4QiKR1KdkprfVXi8sVw++yA
 +aj/g8icbaNtAw8GlRTwVjqQYWv1Dddr5yWmFsiS5BSFdGjLbm4ptVrA3Qvz0vPzOXOe
 n/jQKAIihRmOIKs9fFcEdlTtiAUyQASUMn/k/v4dayVEBjIqP0opN2yXxx7802mxqICS
 EX+Z0/EnpBWVsDjTUEYh0ocv02tJrfn2EnIgfHSYNfMaMJD2gM+jDpjPU9WpzifZvDBM
 j/K0y8cUcQddRA/eoS4JItnTsYgjd+a/nCF8RA5B3xIE7bZZobFAqx1MXyk7Mjwy7qtF Mw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmytajcqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:35:04 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE8Y5h031816;
        Wed, 17 May 2023 14:34:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qj264sudt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:34:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34HEYQhs24576386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 14:34:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A3120049;
        Wed, 17 May 2023 14:34:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F13F820043;
        Wed, 17 May 2023 14:34:24 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 14:34:24 +0000 (GMT)
Date:   Wed, 17 May 2023 16:34:23 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] KVM: s390: CMMA migration selftest and small
 bugfix
Message-ID: <20230517163423.2e8a5bce@p-imbrenda>
In-Reply-To: <168379811019.9368.1588862499018469612@t14-nrb>
References: <20230324145424.293889-1-nrb@linux.ibm.com>
        <168379811019.9368.1588862499018469612@t14-nrb>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GOqBpNTEMYaObwTe0G-svS34s224qb5w
X-Proofpoint-ORIG-GUID: GOqBpNTEMYaObwTe0G-svS34s224qb5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305170119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 11 May 2023 11:41:50 +0200
Nico Boehr <nrb@linux.ibm.com> wrote:

> Quoting Nico Boehr (2023-03-24 15:54:22)
> > v2:
> > ---
> > * swap order of patches (thanks Claudio)
> > * add r-b
> > * add comment why memslots are zeroed
> > 
> > Add a new selftest for CMMA migration. Also fix a small issue found during
> > development of the test.
> > 
> > Nico Boehr (2):
> >   KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
> >   KVM: s390: selftests: add selftest for CMMA migration
> > 
> >  arch/s390/kvm/kvm-s390.c                      |   4 +
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  tools/testing/selftests/kvm/s390x/cmma_test.c | 680 ++++++++++++++++++
> >  3 files changed, 685 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c
> > 
> > -- 
> > 2.39.1
> >   
> 
> Polite ping.

Ooops, I thought this had already been picked

I'll queue it for 6.5

