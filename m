Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9616271A0
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Nov 2022 19:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiKMSUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Nov 2022 13:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMSU3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Nov 2022 13:20:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344FF255;
        Sun, 13 Nov 2022 10:20:29 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2ADIGS83009191;
        Sun, 13 Nov 2022 18:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=EYCIkaYzDxwuZXC3UHhvzR3SuHH7w40UTQ1Xugj8ahY=;
 b=Rotm8+wtBJ+je6vfvL6pES/0Lk0vdZC/iNW/l3dP21K2ogLZgS7aXMiUonQLTXo0VmJ7
 qa95W1smRrMY6g95NdJVIc+/PhOlC/Emo9HIhr3cUmORqllJmyPzOGAkP4MIZ8E/9UUM
 MUjjkuRO3SPLqVa31xGM+e7jxfU8gCccZlXfXVtuOh/ICEn+0HVnoiHW0l4xyCIq4N1Q
 zb6Gc/b1aCER9G1GZ8unERo6M8ggp+Ra8XWc2lrxzzx/AQ1pMMNqismRN2vp2wSFofHD
 UhpUnknpvjN1z1Hp6616MLzecACiOYWLryDJgjtYJUYS/mUJBD3okxP8mzSQgHorv0FA fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ku5qe820x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 18:20:25 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ADIKPqZ020536;
        Sun, 13 Nov 2022 18:20:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ku5qe8200-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 18:20:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ADI7crI026412;
        Sun, 13 Nov 2022 18:20:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3kt348sjy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 18:20:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ADIEPOb15860198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 18:14:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19BC3AE051;
        Sun, 13 Nov 2022 18:20:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75BA1AE045;
        Sun, 13 Nov 2022 18:20:18 +0000 (GMT)
Received: from osiris (unknown [9.145.44.108])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 13 Nov 2022 18:20:18 +0000 (GMT)
Date:   Sun, 13 Nov 2022 19:20:17 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Message-ID: <Y3E1YdKzSItZOKWW@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
 <Y2J8axs+bcQ2dO/l@osiris>
 <f604b6038c4a8bad5123e1f1f14b15c2190f28e9.camel@linux.ibm.com>
 <Y2womHanaMzETfwU@osiris>
 <31fcea80f54c5f53012489f29ebedba775672919.camel@linux.ibm.com>
 <Y2zhNhFjIJPKJao8@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2zhNhFjIJPKJao8@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _xiOF1Jsu-3d-DSHhSjh8yCQj6PQO7jn
X-Proofpoint-ORIG-GUID: ghWzfo4_mknh7pGsI72MDn6dEfYiWgTH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=728 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211130121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 10, 2022 at 12:32:06PM +0100, Heiko Carstens wrote:
> > That's why I asked about cmpxchg.h. If you don't want non-cosmetic changes to the existing
> > cmpxchg function and consistency of the new key checked function, then obviously the loop
> > condition needs to be the same.
> 
> Such a change is fine of course, even though compare-and-swap for one and
> two byte patterns don't really matter. I would appreciate if you could send
> one or two patches on-top of this series which adds the improved logic to
> (now) both variants.
> 
> And, since the question will come up anyway: as soon as we agreed on a
> complete patch series, I think we should go for a features branch on s390's
> kernel.org tree which would contain the first five patches sent by me plus
> potential addon patches provided by you.
> This tree can then be pulled in by the kvms390 tree where your kvm specific
> patches can then be applied on top.

FWIW, pushed a non-stable work-in-progress branch to
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git wip/cmpxchg_user_key

This includes also an updated patch, which fixes the missing shift of
the access key.
