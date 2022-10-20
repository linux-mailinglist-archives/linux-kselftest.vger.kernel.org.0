Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C520606201
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 15:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJTNl7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 09:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJTNlf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 09:41:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5801A650D;
        Thu, 20 Oct 2022 06:41:22 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KDGrx4025981;
        Thu, 20 Oct 2022 13:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : from
 : to : subject : cc : message-id : date; s=pp1;
 bh=t8l3kKsZDZ/AZkt0hRQbiV3KZM8BxnPFYuJg5YPTk8o=;
 b=Dkb96XS0AdGa/jCNdSv2V5p6tlnzzobgrkSVNrZe5LYVk0Egq6MFNbAPcMuD9ESihsn6
 QCi7A0RPewtJM4Hv57MVkjCvyRQ92eUTgKp5hJuszvmST7xwisucp9RVhEvdIcRyYn2h
 O9o9dGX16V6BPv9n0IknRuvLPNEnsHdWZTMB1yZJ++9xHwiG7YAHCPFlFsjkzcfYLIr1
 7egAPcJ/8BxHlwmAmswVspTQuTg8P//SkmkTlXCIOayvhK01MlblQYPnYyBtSiKWD0Ui
 cA9Ohhk+/2miyROJYVmJc+xzAbqoxZTBjAfGnXtm2iWvBXd3mg2QKhvXgXKU53XtYDJS +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb72y12gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 13:41:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29KDH2tY026402;
        Thu, 20 Oct 2022 13:41:02 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb72y12ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 13:41:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29KDaLVO006241;
        Thu, 20 Oct 2022 13:41:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3kajmrsqer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 13:41:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29KDevWa61211124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 13:40:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B4A64C044;
        Thu, 20 Oct 2022 13:40:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0E504C040;
        Thu, 20 Oct 2022 13:40:56 +0000 (GMT)
Received: from t14-nrb (unknown [9.155.203.253])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 13:40:56 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221012205609.2811294-2-scgl@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com> <20221012205609.2811294-2-scgl@linux.ibm.com>
From:   Nico Boehr <nrb@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 1/9] s390/uaccess: Add storage key checked cmpxchg access to user space
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Message-ID: <166627325676.27216.13358887886569042677@t14-nrb>
User-Agent: alot/0.8.1
Date:   Thu, 20 Oct 2022 15:40:56 +0200
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DLrlK0IIG6wl0xaMkZClxGmT1kqTLDv1
X-Proofpoint-GUID: 6NA1uWqsDKKHW0CEddXjic_nuy0441YH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_04,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Janis Schoetterl-Glausch (2022-10-12 22:56:01)
[...]
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uacc=
ess.h
> index f7038b800cc3..f148f5a22c93 100644
[...]
> +static __always_inline int __cmpxchg_user_key_small(int size, u64 addres=
s,
> +                                                   unsigned __int128 *ol=
d_p,
> +                                                   unsigned __int128 new=
, u8 access_key)
> +{

This function is quite hard to understand for me without some context. I ha=
ve a
few suggestions for some comments and one small question below.

> +       u32 shift, mask, old_word, new_word, align_mask, tmp;
> +       u64 aligned;
> +       int ret =3D -EFAULT;
> +

something like this:

/*
 * There is no instruction for 2 and 1 byte compare swap, hence emulate it =
with
 * a 4-byte compare swap.
 * When the 4-bytes compare swap fails, it can be because the actual value =
user
 * space wanted to exchange mismatched. In this case, return to user space.
 * Or it can be because something outside of the value user space wanted to
 * access mismatched (the "remainder" of the word). In this case, retry in
 * kernel space.
 */

> +       switch (size) {
> +       case 2:

/* assume address is 2-byte-aligned - cannot cross word boundary */

> +               align_mask =3D 2;

/* fancy way of saying aligned =3D address & ~align_mask */

> +               aligned =3D (address ^ (address & align_mask));

/* generate mask to extract value to xchg from the word */

> +               shift =3D (sizeof(u32) - (address & align_mask) - size) *=
 8;
> +               mask =3D 0xffff << shift;
> +               old_word =3D ((u16)*old_p) << shift;
> +               new_word =3D ((u16)new) << shift;
> +               break;
> +       case 1:
> +               align_mask =3D 3;
> +               aligned =3D (address ^ (address & align_mask));
> +               shift =3D (sizeof(u32) - (address & align_mask) - size) *=
 8;
> +               mask =3D 0xff << shift;
> +               old_word =3D ((u8)*old_p) << shift;
> +               new_word =3D ((u8)new) << shift;
> +               break;
> +       }
> +       tmp =3D old_word; /* don't modify *old_p on fault */
> +       asm volatile(
> +                      "spka    0(%[access_key])\n"

/* secondary space has user asce loaded */

> +               "       sacf    256\n"
> +               "0:     l       %[tmp],%[aligned]\n"
> +               "1:     nr      %[tmp],%[mask]\n"

/* invert mask to generate mask for the remainder */

> +               "       xilf    %[mask],0xffffffff\n"
> +               "       or      %[new_word],%[tmp]\n"
> +               "       or      %[tmp],%[old_word]\n"
> +               "2:     lr      %[old_word],%[tmp]\n"
> +               "3:     cs      %[tmp],%[new_word],%[aligned]\n"
> +               "4:     jnl     5f\n"
> +               /* We'll restore old_word before the cs, use reg for the =
diff */
> +               "       xr      %[old_word],%[tmp]\n"
> +               /* Apply diff assuming only bits outside target byte(s) c=
hanged */
> +               "       xr      %[new_word],%[old_word]\n"
> +               /* If prior assumption false we exit loop, so not an issu=
e */
> +               "       nr      %[old_word],%[mask]\n"
> +               "       jz      2b\n"

So if the remainder changed but the actual value to exchange stays the same=
, we
loop in the kernel. Does it maybe make sense to limit the number of iterati=
ons
we spend retrying? I think while looping here the calling process can't be
killed, can it?
