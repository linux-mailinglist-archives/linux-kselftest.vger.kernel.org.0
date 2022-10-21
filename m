Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29139607EFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 21:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJUTXH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJUTXG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 15:23:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CCE297F13;
        Fri, 21 Oct 2022 12:22:58 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LJAOSw016332;
        Fri, 21 Oct 2022 19:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=O2wrMryTEiAay8wx5tyw/G36BC6rjJNRPY6ceokv4ko=;
 b=Mg2ttchFt+6glxcDusxlK/LuFfgS+MfNNcU4Pd4QuIrAAc0vZOPRDG+X+473YU7YmH6X
 2o73eck8h//PRdFNO8av5gcS+uYlNu1k0Iv50w7VR9WAkoy7+wDhqz/wdR1YnHcq8Sc7
 E0Ds8TwIrSenF1D++qAvpgtuhThdYmWq11E1sqF9t81LlCS4LqXjYCY/kuhXZm3NNpJN
 CMYBpj4HvVdGVhNNyvpfoWIYEQvig4qT70cFFC61zCQ20R/2o6j+vcqlmrxSVg2UyTmW
 +ZT05OT/hDraoaCheZyJMskvq+YQZecMGA0NsbkTuHi3aZGZivrx8F6ZoVdEPzd43cx5 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kc0p69jsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 19:22:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29LJMr9Y011350;
        Fri, 21 Oct 2022 19:22:53 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kc0p69jrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 19:22:53 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LJKbQR015132;
        Fri, 21 Oct 2022 19:22:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3k7mg9g7pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 19:22:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LJMlaK328250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 19:22:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5F8EA405F;
        Fri, 21 Oct 2022 19:22:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2819BA405B;
        Fri, 21 Oct 2022 19:22:47 +0000 (GMT)
Received: from osiris (unknown [9.145.190.216])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Oct 2022 19:22:47 +0000 (GMT)
Date:   Fri, 21 Oct 2022 21:22:45 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2 1/9] s390/uaccess: Add storage key checked cmpxchg
 access to user space
Message-ID: <Y1LxhaZaVZlM0Cl/@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <166627325676.27216.13358887886569042677@t14-nrb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166627325676.27216.13358887886569042677@t14-nrb>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g2hTvFXAjC5Zgx26NB4fqiBeHV2Lyv3D
X-Proofpoint-GUID: 5CTYsYsWsjZDwPO2UxkN15iFYffX3NEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 20, 2022 at 03:40:56PM +0200, Nico Boehr wrote:
> Quoting Janis Schoetterl-Glausch (2022-10-12 22:56:01)
> > +               "2:     lr      %[old_word],%[tmp]\n"
> > +               "3:     cs      %[tmp],%[new_word],%[aligned]\n"
> > +               "4:     jnl     5f\n"
> > +               /* We'll restore old_word before the cs, use reg for the diff */
> > +               "       xr      %[old_word],%[tmp]\n"
> > +               /* Apply diff assuming only bits outside target byte(s) changed */
> > +               "       xr      %[new_word],%[old_word]\n"
> > +               /* If prior assumption false we exit loop, so not an issue */
> > +               "       nr      %[old_word],%[mask]\n"
> > +               "       jz      2b\n"
> 
> So if the remainder changed but the actual value to exchange stays the same, we
> loop in the kernel. Does it maybe make sense to limit the number of iterations
> we spend retrying? I think while looping here the calling process can't be
> killed, can it?

Yes, the number of loops should be limited; quite similar what arm64
implemented with commit 03110a5cb216 ("arm64: futex: Bound number of
LDXR/STXR loops in FUTEX_WAKE_OP").
