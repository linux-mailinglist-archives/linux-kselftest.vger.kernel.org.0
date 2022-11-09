Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD1622F4D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 16:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKIPqo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 10:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiKIPqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 10:46:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F0DEB7;
        Wed,  9 Nov 2022 07:46:41 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9EdHsn028267;
        Wed, 9 Nov 2022 15:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EZ0sOkfiGY8CgKlokrcp3SQeALJ0FaezVHTq/beLwGQ=;
 b=bPgRgkb7TINU8VGeQQnmEPEGikaykA8iWAKLKch0fb81TjcajHSU3zMlruJnC9c4o/++
 QDjLLV6xfsFGlIiUYt+xOMKXjYVaAJ4rfwetHmeXkdm/OheIgTPr3zU3GzoFs8bix4sS
 9WVH1QsNLyWaCXaa6iArsSfoAPPqBtU5AbjxjUoy14qK+eLZ0LVhh7Z53DOYxYZ9g5qD
 uNv92ea0Iyk7K5kMydV6kk2vEYlTgt5DTTcZ0EHMPtGXBhw/ll3LerOHq7PJ9x+9SPoA
 y53MkmAbTFdXB63NWawRO5nC0AQBN4AD2/ezolBVBIPrgpxQThUOe0wE9U/kcoqyiNB0 Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kre2p27a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 15:46:36 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A9FDtvu014773;
        Wed, 9 Nov 2022 15:46:36 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kre2p2798-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 15:46:36 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9FZb6U024687;
        Wed, 9 Nov 2022 15:46:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3kngpgmafc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 15:46:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9FkUtl66847144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 15:46:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D61D1AE045;
        Wed,  9 Nov 2022 15:46:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3543BAE04D;
        Wed,  9 Nov 2022 15:46:30 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.11.163])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 15:46:30 +0000 (GMT)
Message-ID: <f604b6038c4a8bad5123e1f1f14b15c2190f28e9.camel@linux.ibm.com>
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
Date:   Wed, 09 Nov 2022 16:46:29 +0100
In-Reply-To: <Y2J8axs+bcQ2dO/l@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
         <20221012205609.2811294-2-scgl@linux.ibm.com> <Y2J61LWSV+HolIeT@osiris>
         <Y2J8axs+bcQ2dO/l@osiris>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kdTWoOuNNTaNFlFLjCcIF8aWD-O4MHwg
X-Proofpoint-ORIG-GUID: zDpiIq4JxHXEugod73xKPawjZRoSUFSA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=673 clxscore=1011
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-11-02 at 15:19 +0100, Heiko Carstens wrote:
> Add cmpxchg_user_key() which allows to execute a compare and exchange
> on a user space address. This allows also to specify a storage key
> which makes sure that key-controlled protection is considered.
> 
> This is based on a patch written by Janis Schoetterl-Glausch.
> 
> Link: https://lore.kernel.org/all/20220930210751.225873-2-scgl@linux.ibm.com
> Cc: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/uaccess.h | 183 ++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
> index f7038b800cc3..9bbdecb80e06 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -390,4 +390,187 @@ do {									\
>  		goto err_label;						\
>  } while (0)
>  
> +void __cmpxchg_user_key_called_with_bad_pointer(void);
> +
> +static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
> +					      __uint128_t old, __uint128_t new,
> +					      unsigned long key, int size)
> +{
> +	int rc = 0;
> +
> +	switch (size) {
> +	case 1: {
> +		unsigned int prev, tmp, shift;
> +
> +		shift = (3 ^ (address & 3)) << 3;
> +		address ^= address & 3;
> +		asm volatile(
> +			"	spka	0(%[key])\n"
> +			"	sacf	256\n"
> +			"0:	l	%[prev],%[address]\n"
> +			"1:	nr	%[prev],%[mask]\n"
> +			"	lr	%[tmp],%[prev]\n"
> +			"	or	%[prev],%[old]\n"
> +			"	or	%[tmp],%[new]\n"
> +			"2:	cs	%[prev],%[tmp],%[address]\n"
> +			"3:	jnl	4f\n"
> +			"	xr	%[tmp],%[prev]\n"
> +			"	nr	%[tmp],%[mask]\n"

Are you only entertaining cosmetic changes to cmpxchg.h?
The loop condition being imprecise seems non-ideal.

> +			"	jnz	1b\n"
> +			"4:	sacf	768\n"
> +			"	spka	%[default_key]\n"
> +			EX_TABLE_UA_LOAD_REG(0b, 4b, %[rc], %[prev])
> +			EX_TABLE_UA_LOAD_REG(1b, 4b, %[rc], %[prev])
> +			EX_TABLE_UA_LOAD_REG(2b, 4b, %[rc], %[prev])
> +			EX_TABLE_UA_LOAD_REG(3b, 4b, %[rc], %[prev])
> +			: [rc] "+&d" (rc),
> +			  [prev] "=&d" (prev),
> +			  [tmp] "=&d" (tmp),
> +			  [address] "+Q" (*(int *)address)
> +			: [old] "d" (((unsigned int)old & 0xff) << shift),
> +			  [new] "d" (((unsigned int)new & 0xff) << shift),
> +			  [mask] "d" (~(0xff << shift)),
> +			  [key] "a" (key),

Why did you get rid of the << 4 shift?
That's inconsistent with the other uaccess functions that take an access key.

> +			  [default_key] "J" (PAGE_DEFAULT_KEY)
> +			: "memory", "cc");
> +		*(unsigned char *)uval = prev >> shift;
> +		return rc;
> +	}

[...]
