Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6376164A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKBONB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBOM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:12:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7824B22B16;
        Wed,  2 Nov 2022 07:12:57 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Dqc0j008745;
        Wed, 2 Nov 2022 14:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=35nE7o15c9riT5mLxghtC7oxViP9L6ZfHhdvEYODxLM=;
 b=SlEayUNUlqFz784oCyvTtczjBdNqH67uOoBWijkPAxYmaA2oi0QZrwojcdbz1m59dOuJ
 P4Mi47hD4dE0VGLg4Z/eMOaO7Jp7E61GhdpanVdvQfA722BxcSIeteSLaKByHdfo0Kkg
 Vpyg8a6Y7DDQPsTKajfiImHP2M3JsVwnG/3ZMZRpDcRvNRS0wMi0K9uFs0/02lBkR5EK
 e3IwCPykKJ2aHf8Zomm9U5cxvEYJ9jRSDXdB/R8Dhf9derW/w9n+Klxjt1YK8rVWh2On
 ReR3Bo0hc+q/kHuFQlVDfoHbSyQenFCms2bTP93WgxvJBPOTGL9EGuviBDYW12VWDp7I ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kks22jjtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:12:43 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2DEIWY010237;
        Wed, 2 Nov 2022 14:12:43 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kks22jjsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:12:43 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2E6bq1008788;
        Wed, 2 Nov 2022 14:12:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3kguejd6fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:12:41 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2ECcLZ27787858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 14:12:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58260A405B;
        Wed,  2 Nov 2022 14:12:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4528A4060;
        Wed,  2 Nov 2022 14:12:37 +0000 (GMT)
Received: from osiris (unknown [9.145.56.93])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 14:12:37 +0000 (GMT)
Date:   Wed, 2 Nov 2022 15:12:36 +0100
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
Subject: Re: [PATCH v2 1/9] s390/uaccess: Add storage key checked cmpxchg
 access to user space
Message-ID: <Y2J61LWSV+HolIeT@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012205609.2811294-2-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vEqvPEkNOiMjLF4A4AXRnLajCt2hxpmZ
X-Proofpoint-ORIG-GUID: eMFw4JuDxVV5yzho1KrLvvsVObKo68QS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_09,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Janis,

On Wed, Oct 12, 2022 at 10:56:01PM +0200, Janis Schoetterl-Glausch wrote:
> Add cmpxchg functionality similar to that in cmpxchg.h except that the
> target is a user space address and that the address' storage key is
> matched with the access_key argument in order to honor key-controlled
> protection.
> The access is performed by changing to the secondary-spaces mode and
> setting the PSW key for the duration of the compare and swap.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> Possible variations:
>   * check the assumptions made in cmpxchg_user_key_size and error out
>   * call functions called by copy_to_user
>      * access_ok? is a nop
>      * should_fail_usercopy?
>      * instrument_copy_to_user? doesn't make sense IMO
>   * don't be overly strict in cmpxchg_user_key
> 
> 
>  arch/s390/include/asm/uaccess.h | 189 ++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)

So finally I send the uaccess/cmpxchg patches in reply to this mail.
Sorry for the long delay!

The first three patches are not required for the functionality you need,
but given that I always stress that the code should be consistent I include
them anyway.

The changes are probably quite obvious:

- Keep uaccess cmpxchg code more or less identical to regular cmpxchg
  code. I wasn't able to come up with a readable code base which could be
  used for both variants.

- Users may only use the cmpxchg_user_key() macro - _not_ the inline
  function, which is an internal API. This will require that you need to
  add a switch statement and couple of casts within the KVM code, but
  shouldn't have much of an impact on the generated code.

- Cause link error for non-integral sizes, similar to other uaccess
  functions.

- cmpxchg_user_key() has now a simple return value: 0 or -EFAULT, and
  writes the old value to a location provided by a pointer. This is quite
  similar to the futex code. Users must compare the old and expected value
  to figure out if something was exchanged. Note that this is in most cases
  more efficient than extracting the condition code from the PSW with ipm,
  since nowadays we have instructions like compare and branch relative on
  condition, etc.

- Couple of other minor changes which I forgot.

Code is untested (of course :) ). Please give it a try and let me know if
this is good enough for your purposes.

I also did not limit the number of retries for the one and two byte
scenarion. Before doing that we need to have proof that there really is a
problem. Maybe Nico or you will give this a try.

Thanks,
Heiko
