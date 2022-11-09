Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376FF62367F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 23:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiKIWYn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 17:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiKIWYm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 17:24:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C63140C1;
        Wed,  9 Nov 2022 14:24:41 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Kuqct000960;
        Wed, 9 Nov 2022 22:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OXK2rflp5rKV+rHWMnZiJD3myzm6Ph+64qqnZ6aXot8=;
 b=ePA9ac7n7ndS86zvofrKBK46O2F6Crd9IxMaYo8pamZ40ObP/AExxjnefystbq3NU7Us
 ilsfqcbb+T71jyq9zyArOLMgD99lneToJH2QiRN+MVioi6qRlkuCohFJV5JEvpuNEZFc
 JjU8G5wtNQI5clOiKaRTXL5CuRaVWDBDZ0yu4KF8t7Kx8LmD+93Nv/KsN+L8rIbihVrf
 We+pumeIsFGnlxA6FJhsVY28uFrpK3VHJ3hq+luj2fqorkuHzx7hymspLEb1WFoc7oWu
 CyyAs+iDxgq2duQocmkd60w0TEHd4pxt1rC8H9qWShSCXIsE6QFrRHxsvAR5tzhliLwE uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krfgv14eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 22:24:32 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A9Lqe2E028847;
        Wed, 9 Nov 2022 22:24:32 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krfgv14dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 22:24:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9MKhZQ004854;
        Wed, 9 Nov 2022 22:24:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqgeb24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 22:24:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9MOQAB65405368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 22:24:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D7FDA4054;
        Wed,  9 Nov 2022 22:24:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E94AA405F;
        Wed,  9 Nov 2022 22:24:25 +0000 (GMT)
Received: from osiris (unknown [9.145.168.231])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Nov 2022 22:24:25 +0000 (GMT)
Date:   Wed, 9 Nov 2022 23:24:24 +0100
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
Message-ID: <Y2womHanaMzETfwU@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
 <Y2J8axs+bcQ2dO/l@osiris>
 <f604b6038c4a8bad5123e1f1f14b15c2190f28e9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f604b6038c4a8bad5123e1f1f14b15c2190f28e9.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3lV4qHHsjdqfHjgEzB8DO73hOaXXctYa
X-Proofpoint-ORIG-GUID: xPEyVc6oijzPJ_nU3OIvfGBZasFkAUT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=783 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090166
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 09, 2022 at 04:46:29PM +0100, Janis Schoetterl-Glausch wrote:
> On Wed, 2022-11-02 at 15:19 +0100, Heiko Carstens wrote:
> > +	case 1: {
> > +		unsigned int prev, tmp, shift;
> > +
> > +		shift = (3 ^ (address & 3)) << 3;
> > +		address ^= address & 3;
> > +		asm volatile(
> > +			"	spka	0(%[key])\n"
> > +			"	sacf	256\n"
> > +			"0:	l	%[prev],%[address]\n"
> > +			"1:	nr	%[prev],%[mask]\n"
> > +			"	lr	%[tmp],%[prev]\n"
> > +			"	or	%[prev],%[old]\n"
> > +			"	or	%[tmp],%[new]\n"
> > +			"2:	cs	%[prev],%[tmp],%[address]\n"
> > +			"3:	jnl	4f\n"
> > +			"	xr	%[tmp],%[prev]\n"
> > +			"	nr	%[tmp],%[mask]\n"
> 
> Are you only entertaining cosmetic changes to cmpxchg.h?

I fail to parse what you are trying to say. Please elaborate.

> The loop condition being imprecise seems non-ideal.

What exactly is imprecise?

> > +			  [key] "a" (key),
> 
> Why did you get rid of the << 4 shift?
> That's inconsistent with the other uaccess functions that take an access key.

That's not only inconsistent, but also a bug.
Thank you for pointing this out. Will be fixed.
