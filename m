Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8965DB41
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jan 2023 18:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbjADR14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Jan 2023 12:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjADR1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Jan 2023 12:27:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74711180D;
        Wed,  4 Jan 2023 09:27:53 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FxpWL005636;
        Wed, 4 Jan 2023 17:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=hgVLBZKjQjTK22ngbI2KF/s8rDVwlOYDUeR6IOpssyI=;
 b=RsEyVRoN/Dt65oj0xs+/rZT3XhPHrvf4taxqt6Q+VGZOSxhvWGtdXKMWTlTzxzVLsfIU
 0IT1hJ/a0wr6rCepX8eQ9FZ2cOtYJ87v2FNgIOvvzTAXBJ5//N0lgLjJfIGgUwUNy8tX
 iEhi3pKt5V7Mm0tnJxy3EZl3DmO20hpU1VLKtSfjV0oHFMG7k7u54ErNsTUdt+Aq6lrd
 +0yTflB9fuvpJO4U2F4PDZLNVKgmOeiNnSyoN+CuEtNpYDvMhWMmpQIaaJYfGiwuRkl5
 bHVrd00mHt4vOkRElCzHeuIjC7f+aKxtOsNu1D03daH5tFr51HOJwdP0TuGP6WR8m+Aq 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwckda26h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 17:27:41 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304GqTod002027;
        Wed, 4 Jan 2023 17:27:41 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwckda261-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 17:27:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 304CbDI6021071;
        Wed, 4 Jan 2023 17:27:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6dmkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 17:27:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 304HRZkB23790010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 17:27:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7371220043;
        Wed,  4 Jan 2023 17:27:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91B7C2004B;
        Wed,  4 Jan 2023 17:27:34 +0000 (GMT)
Received: from osiris (unknown [9.179.28.126])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jan 2023 17:27:34 +0000 (GMT)
Date:   Wed, 4 Jan 2023 18:27:33 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        oe-kbuild-all@lists.linux.dev,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v4 1/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
Message-ID: <Y7W3BR4WmaapBQMT@osiris>
References: <20221213165405.2953539-2-scgl@linux.ibm.com>
 <202212141025.6iR1ex8g-lkp@intel.com>
 <4b96b112d5415d08a81d30657feec2c8c3000f7c.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b96b112d5415d08a81d30657feec2c8c3000f7c.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pcbH_lpASS6ZxiHwImdail8xfvFZjMVk
X-Proofpoint-GUID: 9YIMm65j_RIPiBtOH8fjcOAsdFTGrxS5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=923 clxscore=1011
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 19, 2022 at 10:24:33PM +0100, Janis Schoetterl-Glausch wrote:
> On Wed, 2022-12-14 at 10:23 +0800, kernel test robot wrote:
> > Hi Janis,
> > 
> > Thank you for the patch! Yet something to improve:
> > All errors (new ones prefixed by >>):
> > 
> >    s390-linux-ld: arch/s390/kvm/gaccess.o: in function `__cmpxchg_user_key':
> > > > arch/s390/include/asm/uaccess.h:410: undefined reference to `__ashlti3'
> > > > s390-linux-ld: arch/s390/include/asm/uaccess.h:411: undefined reference to `__ashlti3'
> >    s390-linux-ld: arch/s390/include/asm/uaccess.h:458: undefined reference to `__ashlti3'
> >    s390-linux-ld: arch/s390/include/asm/uaccess.h:459: undefined reference to `__ashlti3'
> > 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16 @410  		_old = (old & 0xff) << shift;
> > 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16 @411  		_new = (new & 0xff) << shift;
> 
> Not sure what it is in this config that causes gcc to emit this
> symbol instead of a shift instruction, but casting old/new to 32 bit
> fixes the error.

Right.. now we have the same fun with 128 bit arithmetics that we had
with 64 bit arithmetics on 32 bit. I really missed that :)

Fixed the way you proposed it:
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=cmpxchg_user_key&id=b33d59fb37ddcb6ee65d4fa23cc3d58793d13c5b
