Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4695F5638
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiJEOOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJEOOA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 10:14:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CB7C33A;
        Wed,  5 Oct 2022 07:13:59 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295DbnR9012930;
        Wed, 5 Oct 2022 14:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=M8evBa/i+BwZ32m38a3q5zdDdYZKhmZAofBOCds6t4c=;
 b=p0xHP3rGHmp9h7fjCHxQvJanlyaAlFF4f+/RDz4g1eoo/gcivDmkEWnzkYT6uBzk5Uf+
 aPt5fWWC/jTDNhDTQuErSG8G+5HCVRTp8dV6TlCCFMTYt8jtARsfI+dTOlqJDeKPu76/
 MKhRWwdS0jHd+niVOguvOr2RxptM3Vtc6iRFfweYybCeRBLI8L+Rx3Qow76mf9NlDcOn
 aPQFIQn9rjoYYCZSZ1Vbcv7lUVFptMUsJEEDJz3IFGmAdy6Nr9chOWU1qQKI1MF5JT/X
 eFB5BvbuFgWzLbbO+ArTpWwxgI7bXCeooHszgjRjkEW1Fr+pk8H9jSPEmCwXcjM7SQB3 mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1ap29uj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 14:13:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 295DcFSU013857;
        Wed, 5 Oct 2022 14:13:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1ap29uh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 14:13:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 295E67w2008184;
        Wed, 5 Oct 2022 14:13:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jxctj5p16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 14:13:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 295EDnHD34472628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Oct 2022 14:13:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 462A05204E;
        Wed,  5 Oct 2022 14:13:49 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C7D345204F;
        Wed,  5 Oct 2022 14:13:48 +0000 (GMT)
Date:   Wed, 5 Oct 2022 16:13:46 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 1/9] s390/uaccess: Add storage key checked cmpxchg
 access to user space
Message-ID: <20221005161346.3c735249@p-imbrenda>
In-Reply-To: <20220930210751.225873-2-scgl@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
        <20220930210751.225873-2-scgl@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R0F7TXFF4spYhlUcSlnlSGo7qLPxMefO
X-Proofpoint-GUID: PbdNM6zFOlRDSulwBK7Gr_ibpYXBPpz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210050088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 30 Sep 2022 23:07:43 +0200
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> Add cmpxchg functionality similar to that in cmpxchg.h except that the
> target is a user space address and that the address' storage key is
> matched with the access_key argument in order to honor key-controlled
> protection.
> The access is performed by changing to the secondary-spaces mode and
> setting the PSW key for the duration of the compare and swap.

this whole patch is very complex, I think it can be simplified and made
more maintainable (see my comments below)

in the end here we need an atomic compare and swap with key checking,
if we are doing a syscall for it, we are clearly not looking for
performance.

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
>  arch/s390/include/asm/uaccess.h | 187 ++++++++++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
> index f7038b800cc3..0ce90b7e2b75 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -19,6 +19,8 @@
>  #include <asm/extable.h>
>  #include <asm/facility.h>
>  #include <asm-generic/access_ok.h>
> +#include <asm/page.h>
> +#include <linux/log2.h>
>  
>  void debug_user_asce(int exit);
>  
> @@ -390,4 +392,189 @@ do {									\
>  		goto err_label;						\
>  } while (0)
>  
> +static __always_inline int __cmpxchg_user_key_small(int size, u64 address,
> +						    unsigned __int128 *old_p,
> +						    unsigned __int128 new, u8 access_key)
> +{

can this whole function be simplified to be a C wrapper for the 4 byte
version of compare and swap?

> +	u32 shift, mask, old_word, new_word, align_mask, tmp, diff;
> +	u64 aligned;
> +	int ret = -EFAULT;
> +
> +	switch (size) {
> +	case 2:
> +		align_mask = 2;
> +		aligned = (address ^ (address & align_mask));
> +		shift = (sizeof(u32) - (address & align_mask) - size) * 8;
> +		mask = 0xffff << shift;
> +		old_word = ((u16)*old_p) << shift;
> +		new_word = ((u16)new) << shift;
> +		break;
> +	case 1:
> +		align_mask = 3;
> +		aligned = (address ^ (address & align_mask));
> +		shift = (sizeof(u32) - (address & align_mask) - size) * 8;
> +		mask = 0xff << shift;
> +		old_word = ((u8)*old_p) << shift;
> +		new_word = ((u8)new) << shift;
> +		break;
> +	}
> +	asm volatile(
> +		       "spka	0(%[access_key])\n"
> +		"	sacf	256\n"
> +		"0:	l	%[tmp],%[aligned]\n"
> +		"1:	nr	%[tmp],%[hole_mask]\n"
> +		"	or	%[new_word],%[tmp]\n"
> +		"	or	%[old_word],%[tmp]\n"
> +		"	lr	%[tmp],%[old_word]\n"
> +		"2:	cs	%[tmp],%[new_word],%[aligned]\n"
> +		"3:	jnl	4f\n"
> +		"	xrk	%[diff],%[tmp],%[old_word]\n"
> +		"	nr	%[diff],%[hole_mask]\n"
> +		"	xr	%[new_word],%[diff]\n"
> +		"	xr	%[old_word],%[diff]\n"
> +		"	xrk	%[diff],%[tmp],%[old_word]\n"
> +		"	jz	2b\n"
> +		"4:	ipm	%[ret]\n"
> +		"	srl	%[ret],28\n"
> +		"5:	sacf	768\n"
> +		"	spka	%[default_key]\n"
> +		EX_TABLE(0b, 5b) EX_TABLE(1b, 5b)
> +		EX_TABLE(2b, 5b) EX_TABLE(3b, 5b)
> +		: [old_word] "+&d" (old_word),
> +		  [new_word] "+&d" (new_word),
> +		  [tmp] "=&d" (tmp),
> +		  [aligned] "+Q" (*(u32 *)aligned),
> +		  [diff] "=&d" (diff),
> +		  [ret] "+d" (ret)
> +		: [access_key] "a" (access_key << 4),
> +		  [hole_mask] "d" (~mask),
> +		  [default_key] "J" (PAGE_DEFAULT_KEY)
> +		: "cc"
> +	);
> +	*old_p = (tmp & mask) >> shift;
> +	return ret;
> +}
> +
> +/**
> + * cmpxchg_user_key_size() - cmpxchg with user space target, honoring storage keys
> + * @size: Size of the value being cmpxchg'ed, one of 1,2,4,8,16.
> + * @address: User space address of value to compare to *@old_p and exchange with
> + *           *@new. Must be aligned to @size.
> + * @old_p: Pointer to old value. Interpreted as a @size byte integer and compared
> + *         to the content pointed to by @address in order to determine if the
> + *         exchange occurs. The value read from @address is written back to *@old_p.
> + * @new: New value to place at @address, interpreted as a @size byte integer.
> + * @access_key: Access key to use for checking storage key protection.
> + *
> + * Perform a cmpxchg on a user space target, honoring storage key protection.
> + * @access_key alone determines how key checking is performed, neither
> + * storage-protection-override nor fetch-protection-override apply.
> + *
> + * Return:	0: successful exchange
> + *		1: exchange failed
> + *		-EFAULT: @address not accessible or not naturally aligned
> + *		-EINVAL: invalid @size
> + */
> +static __always_inline int cmpxchg_user_key_size(int size, void __user *address,
> +						 unsigned __int128 *old_p,
> +						 unsigned __int128 new, u8 access_key)
> +{
> +	union {
> +		u32 word;
> +		u64 doubleword;
> +	} old;
> +	int ret = -EFAULT;
> +
> +	/*
> +	 * The following assumes that:
> +	 *  * the current psw key is the default key
> +	 *  * no storage protection overrides are in effect
> +	 */
> +	might_fault();
> +	switch (size) {
> +	case 16:
> +		asm volatile(
> +			       "spka	0(%[access_key])\n"
> +			"	sacf	256\n"
> +			"0:	cdsg	%[old],%[new],%[target]\n"
> +			"1:	ipm	%[ret]\n"
> +			"	srl	%[ret],28\n"
> +			"2:	sacf	768\n"
> +			"	spka	%[default_key]\n"
> +			EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
> +			: [old] "+d" (*old_p),
> +			  [target] "+Q" (*(unsigned __int128 __user *)address),
> +			  [ret] "+d" (ret)
> +			: [access_key] "a" (access_key << 4),
> +			  [new] "d" (new),
> +			  [default_key] "J" (PAGE_DEFAULT_KEY)
> +			: "cc"
> +		);
> +		return ret;
> +	case 8:
> +		old.doubleword = *old_p;
> +		asm volatile(
> +			       "spka	0(%[access_key])\n"
> +			"	sacf	256\n"
> +			"0:	csg	%[old],%[new],%[target]\n"
> +			"1:	ipm	%[ret]\n"
> +			"	srl	%[ret],28\n"
> +			"2:	sacf	768\n"
> +			"	spka	%[default_key]\n"
> +			EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
> +			: [old] "+d" (old.doubleword),
> +			  [target] "+Q" (*(u64 __user *)address),
> +			  [ret] "+d" (ret)
> +			: [access_key] "a" (access_key << 4),
> +			  [new] "d" ((u64)new),
> +			  [default_key] "J" (PAGE_DEFAULT_KEY)
> +			: "cc"
> +		);
> +		*old_p = old.doubleword;
> +		return ret;
> +	case 4:
> +		old.word = *old_p;
> +		asm volatile(
> +			       "spka	0(%[access_key])\n"
> +			"	sacf	256\n"
> +			"0:	cs	%[old],%[new],%[target]\n"
> +			"1:	ipm	%[ret]\n"
> +			"	srl	%[ret],28\n"
> +			"2:	sacf	768\n"
> +			"	spka	%[default_key]\n"
> +			EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
> +			: [old] "+d" (old.word),
> +			  [target] "+Q" (*(u32 __user *)address),
> +			  [ret] "+d" (ret)
> +			: [access_key] "a" (access_key << 4),
> +			  [new] "d" ((u32)new),
> +			  [default_key] "J" (PAGE_DEFAULT_KEY)
> +			: "cc"

this is the same code 3 times with only very minimal changes.
can you factor it out in macros?

something like this:

#define DO_COMPARE_AND_SWAP(instr, _old, _addr, _ret, _key, _new) \
	asm volatile(
			"spka	0(%[access_key])\n"
		"	sacf	256\n" 
		"0:	" instr "%[old],%[new],%[target]\n"
		"1:	ipm	%[ret]\n"
 		"	srl 	%[ret],28\n"
		"2:	sacf	768\n"
		"	spka	%[default_key]\n"
		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
		: [old] "+d"(_old),
		  [target] "+Q" (*(_addr)),
		  [ret] "+d" (_ret)
		: [access_key] "a" ((_key) << 4),
		  [new] "d" (_new),
		  [default_key] "J" (PAGE_DEFAULT_KEY)
		: "cc"

and then in the code:

DO_COMPARE_AND_SWAP("cs", old.word, (u32 __user *)address, ret, access_key, (u32)new)

this way the code is not duplicated


or have you tried it already and there are issues I didn't think of?

> +		);
> +		*old_p = old.word;
> +		return ret;
> +	case 2:
> +	case 1:
> +		return __cmpxchg_user_key_small(size, (u64)address, old_p, new, access_key);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define cmpxchg_user_key(target_p, old_p, new, access_key)			\
> +({										\
> +	__typeof__(old_p) __old_p = (old_p);					\
> +	unsigned __int128 __old = *__old_p;					\
> +	size_t __size = sizeof(*(target_p));					\
> +	int __ret;								\
> +										\
> +	BUILD_BUG_ON(__size != sizeof(*__old_p));				\
> +	BUILD_BUG_ON(__size != sizeof(new));					\
> +	BUILD_BUG_ON(__size > 16 || !is_power_of_2(__size));			\

and here an if to see if you need the _small version or the regular
one, with the _small version being a wrapper around the regular one

> +	__ret = cmpxchg_user_key_size(__size, (target_p), &__old, (new),	\
> +				      (access_key));				\
> +	*__old_p = __old;							\
> +	__ret;									\
> +})
> +
>  #endif /* __S390_UACCESS_H */

