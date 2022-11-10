Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4CB624096
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKJLBi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 06:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKJLBg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 06:01:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130962CE;
        Thu, 10 Nov 2022 03:01:35 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA9CjCt032607;
        Thu, 10 Nov 2022 11:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GdD9dZ9DG3YUE6VnCGcC1XtrAYtPWih2GZSB26eCFg4=;
 b=Ikk8k4wxqRkYdFLyR9LeHOMHZpIOGbMiPwAIPXylD72To2QvhPKo30lecrqLufpDwRNL
 KAGfNLirIk+5XRxAw1BKdpvLRGbE3CDv/1QgHt+TnDto0JqQpJB6ii+O5caAEVNBFXwz
 /7PjCF81PzBUzxe29wD5bPHzg9Djgrn+OLyB9HKL7sCPPon5w+CkaZE2woPtWNfin2oL
 Td1+HPekVPsBBDEXygP2N/XSQjTuHIMBaSwAsiZI8+NPXtNhSe2PtpqzaegFc6930Kkv
 Yfp5EjlKAA9y4nJN8Hmlg4qNM+1gDk8BcyKcnufqJvrBq9OpfAxuPAois6zjwLTAR/F5 fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krxf9ar1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:01:30 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AAAhnK7004770;
        Thu, 10 Nov 2022 11:01:30 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krxf9ar0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:01:30 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AAAqq0j020160;
        Thu, 10 Nov 2022 11:01:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3kngmqn4qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:01:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AAB1OLT197320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 11:01:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 600B1A4053;
        Thu, 10 Nov 2022 11:01:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B133CA4051;
        Thu, 10 Nov 2022 11:01:23 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.16.172])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Nov 2022 11:01:23 +0000 (GMT)
Message-ID: <31fcea80f54c5f53012489f29ebedba775672919.camel@linux.ibm.com>
Subject: Re: [PATCH 5/5] s390/uaccess: add cmpxchg_user_key()
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
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
Date:   Thu, 10 Nov 2022 12:01:23 +0100
In-Reply-To: <Y2womHanaMzETfwU@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
         <20221012205609.2811294-2-scgl@linux.ibm.com> <Y2J61LWSV+HolIeT@osiris>
         <Y2J8axs+bcQ2dO/l@osiris>
         <f604b6038c4a8bad5123e1f1f14b15c2190f28e9.camel@linux.ibm.com>
         <Y2womHanaMzETfwU@osiris>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9SPW37mYrHRmqXz2ywNGmzPKwmqvIf5a
X-Proofpoint-GUID: aQv6nTzK71vM5pzWW_2nJRhG863TYoNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_07,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-11-09 at 23:24 +0100, Heiko Carstens wrote:
> On Wed, Nov 09, 2022 at 04:46:29PM +0100, Janis Schoetterl-Glausch wrote:
> > On Wed, 2022-11-02 at 15:19 +0100, Heiko Carstens wrote:
> > > +	case 1: {
> > > +		unsigned int prev, tmp, shift;
> > > +
> > > +		shift = (3 ^ (address & 3)) << 3;
> > > +		address ^= address & 3;
> > > +		asm volatile(
> > > +			"	spka	0(%[key])\n"
> > > +			"	sacf	256\n"
> > > +			"0:	l	%[prev],%[address]\n"
> > > +			"1:	nr	%[prev],%[mask]\n"
> > > +			"	lr	%[tmp],%[prev]\n"
> > > +			"	or	%[prev],%[old]\n"
> > > +			"	or	%[tmp],%[new]\n"
> > > +			"2:	cs	%[prev],%[tmp],%[address]\n"
> > > +			"3:	jnl	4f\n"
> > > +			"	xr	%[tmp],%[prev]\n"
> > > +			"	nr	%[tmp],%[mask]\n"
> > 
> > Are you only entertaining cosmetic changes to cmpxchg.h?
> 
> I fail to parse what you are trying to say. Please elaborate.
> 
> > The loop condition being imprecise seems non-ideal.
> 
> What exactly is imprecise?

The loop retries the CS if bits outside the target byte changed instead
of retrying until the target byte differs from the old value.
So if you attempt to exchange (prev_left_0 old_byte prev_right_0) and 
that fails because the word at the address is (prev_left_1 x prev_right_1)
where both x != old_byte and one of the prev_*_1 values differs from the respective
prev_*_0 value, the CS is retried. If there were a native 1 byte compare and swap,
the exchange would just fail here. Instead the loop retries the CS until the margin
values are stable and it can infer from that that the CS failed because of the target value.
(Assuming that doesn't change to the old_byte value.)

It's not a problem, but it struck me as non-ideal, which is why for v2 I inverted the mask
after using it to punch the hole for the old/new values.
Then you can use it to test if bits inside the target byte differ.

That's why I asked about cmpxchg.h. If you don't want non-cosmetic changes to the existing
cmpxchg function and consistency of the new key checked function, then obviously the loop
condition needs to be the same.
> 
> > > +			  [key] "a" (key),
> > 
> > Why did you get rid of the << 4 shift?
> > That's inconsistent with the other uaccess functions that take an access key.
> 
> That's not only inconsistent, but also a bug.
> Thank you for pointing this out. Will be fixed.

Well, you could pass in the shifted key as argument, but yeah.
