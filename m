Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92433605EA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJTLSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 07:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJTLSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 07:18:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34991ACAAD;
        Thu, 20 Oct 2022 04:18:48 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KBEhqM015308;
        Thu, 20 Oct 2022 11:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=m0/zDB9esedN1FeU0NeS+vO2OMMH7WbilvlrNoZH0qs=;
 b=QLHcOiT99zePR8dQgIgQ6vEEZzAXVakIevLJo3CS4goC2W2Pq8GaR3o4USXlPI+ANvLr
 UEW+B9TxpdfWwODw04ZIgO+t2aPqBV/xtXehaa/5HiWc5l9xOQOgo2YRMod7ZJ/7fK3s
 qYNd8jnpfGfhYrm+JJ3ZYr3Vsk1eM7DfJuwO1SNjmmqQ+vfhNTPiEbdZ0x9U/ZG6kb31
 FKiq36GDbNKLL41l4t0f0Xu4PGGM0LUPY3MP9LmN9myUmayZfN1nuretOaUBwgC8oHEq
 Fcc9mo9mTEVoe5SgrwZjjLuZuY0racxPHSuRFyrFBPevE8FSqfAZ66SKkO6sLeuzIQe7 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb59jg381-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 11:18:43 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29KBICNq031838;
        Thu, 20 Oct 2022 11:18:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb59jg377-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 11:18:42 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29KB6PB0014031;
        Thu, 20 Oct 2022 11:18:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kajmrsh0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 11:18:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29KBIcwL1704660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 11:18:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBF495204F;
        Thu, 20 Oct 2022 11:18:37 +0000 (GMT)
Received: from osiris (unknown [9.152.212.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 82DCC5204E;
        Thu, 20 Oct 2022 11:18:37 +0000 (GMT)
Date:   Thu, 20 Oct 2022 13:18:37 +0200
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
Message-ID: <Y1EujYeiDjy43wUN@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012205609.2811294-2-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DXiud5lnz0qHz52hmUW7aLhhFFDzz_2e
X-Proofpoint-ORIG-GUID: MPFyuwfdOx1UFPeLiaJTnXuSSB6tM1Tf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=696 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200066
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

This not how I would have expected something that would be
symmetrical/consistent with what we already have. However instead of
spending several iterations I'll send something for this.

This might take a bit due to my limited time. So please be patient.
