Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051075FCC7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJLU42 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 16:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJLU4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 16:56:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7021386F89;
        Wed, 12 Oct 2022 13:56:23 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CJSO1d006626;
        Wed, 12 Oct 2022 20:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lIAmJVbqU9zfZgUBxV43AKLVLaZ9iQI/TulNZFSuAbU=;
 b=ke0hNgLBhC/bU+TM0axWIwZBfBlY+Z3EADcvoqAtONErXsv6q680t7tnI+nOsYBEdZfj
 lkrCD3AeiifwLyFFxOupg++JYLSBZwr7kET/aH6a49qywME/9o421vmdKkzOU/QrxuQc
 cdg1B5ny6lXuCm29eN5microzObSBuoWtItPtMWAr09tayiAWVqS9i3OrKljXk4jBoyO
 vHc02HMCv2mDpx96Ur17kmbNV5vNiAxXsEhUoEfe4GqZVee0GyXnIugiBtp9F9HLkbol
 1/d98rb9GKUcJ5BdL02KNQpXtcrgv1mi8QLAr1gOOQmC+Q634LYgL8kvdRU/ZDuI5HEd rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62kpvcck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CJTo5n011833;
        Wed, 12 Oct 2022 20:56:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62kpvcc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CKqjhA002838;
        Wed, 12 Oct 2022 20:56:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3k30u9ejf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29CKuCwF65995238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:56:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 442D75204E;
        Wed, 12 Oct 2022 20:56:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C7AEC52051;
        Wed, 12 Oct 2022 20:56:11 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 1/9] s390/uaccess: Add storage key checked cmpxchg access to user space
Date:   Wed, 12 Oct 2022 22:56:01 +0200
Message-Id: <20221012205609.2811294-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012205609.2811294-1-scgl@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Xr6tDpIb7BzyiOHXhy1Y_4cYYC097Xx
X-Proofpoint-GUID: 0YcU9TwW8glSImyu29bPnZG-x69q-H6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add cmpxchg functionality similar to that in cmpxchg.h except that the
target is a user space address and that the address' storage key is
matched with the access_key argument in order to honor key-controlled
protection.
The access is performed by changing to the secondary-spaces mode and
setting the PSW key for the duration of the compare and swap.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---


Possible variations:
  * check the assumptions made in cmpxchg_user_key_size and error out
  * call functions called by copy_to_user
     * access_ok? is a nop
     * should_fail_usercopy?
     * instrument_copy_to_user? doesn't make sense IMO
  * don't be overly strict in cmpxchg_user_key


 arch/s390/include/asm/uaccess.h | 189 ++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index f7038b800cc3..f148f5a22c93 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -19,6 +19,8 @@
 #include <asm/extable.h>
 #include <asm/facility.h>
 #include <asm-generic/access_ok.h>
+#include <asm/page.h>
+#include <linux/log2.h>
 
 void debug_user_asce(int exit);
 
@@ -390,4 +392,191 @@ do {									\
 		goto err_label;						\
 } while (0)
 
+static __always_inline int __cmpxchg_user_key_small(int size, u64 address,
+						    unsigned __int128 *old_p,
+						    unsigned __int128 new, u8 access_key)
+{
+	u32 shift, mask, old_word, new_word, align_mask, tmp;
+	u64 aligned;
+	int ret = -EFAULT;
+
+	switch (size) {
+	case 2:
+		align_mask = 2;
+		aligned = (address ^ (address & align_mask));
+		shift = (sizeof(u32) - (address & align_mask) - size) * 8;
+		mask = 0xffff << shift;
+		old_word = ((u16)*old_p) << shift;
+		new_word = ((u16)new) << shift;
+		break;
+	case 1:
+		align_mask = 3;
+		aligned = (address ^ (address & align_mask));
+		shift = (sizeof(u32) - (address & align_mask) - size) * 8;
+		mask = 0xff << shift;
+		old_word = ((u8)*old_p) << shift;
+		new_word = ((u8)new) << shift;
+		break;
+	}
+	tmp = old_word; /* don't modify *old_p on fault */
+	asm volatile(
+		       "spka	0(%[access_key])\n"
+		"	sacf	256\n"
+		"0:	l	%[tmp],%[aligned]\n"
+		"1:	nr	%[tmp],%[mask]\n"
+		"	xilf	%[mask],0xffffffff\n"
+		"	or	%[new_word],%[tmp]\n"
+		"	or	%[tmp],%[old_word]\n"
+		"2:	lr	%[old_word],%[tmp]\n"
+		"3:	cs	%[tmp],%[new_word],%[aligned]\n"
+		"4:	jnl	5f\n"
+		/* We'll restore old_word before the cs, use reg for the diff */
+		"	xr	%[old_word],%[tmp]\n"
+		/* Apply diff assuming only bits outside target byte(s) changed */
+		"	xr	%[new_word],%[old_word]\n"
+		/* If prior assumption false we exit loop, so not an issue */
+		"	nr	%[old_word],%[mask]\n"
+		"	jz	2b\n"
+		"5:	ipm	%[ret]\n"
+		"	srl	%[ret],28\n"
+		"6:	sacf	768\n"
+		"	spka	%[default_key]\n"
+		EX_TABLE(0b, 6b) EX_TABLE(1b, 6b)
+		EX_TABLE(3b, 6b) EX_TABLE(4b, 6b)
+		: [old_word] "+&d" (old_word),
+		  [new_word] "+&d" (new_word),
+		  [tmp] "+&d" (tmp),
+		  [aligned] "+Q" (*(u32 *)aligned),
+		  [ret] "+d" (ret)
+		: [access_key] "a" (access_key << 4),
+		  [mask] "d" (~mask),
+		  [default_key] "J" (PAGE_DEFAULT_KEY)
+		: "cc"
+	);
+	*old_p = (tmp & mask) >> shift;
+	return ret;
+}
+
+/**
+ * cmpxchg_user_key_size() - cmpxchg with user space target, honoring storage keys
+ * @size: Size of the value being cmpxchg'ed, one of 1,2,4,8,16.
+ * @address: User space address of value to compare to *@old_p and exchange with
+ *           @new. Must be aligned to @size.
+ * @old_p: Pointer to old value. Interpreted as a @size byte integer and compared
+ *         to the content pointed to by @address in order to determine if the
+ *         exchange occurs. The value read from @address is written back to *@old_p.
+ * @new: New value to place at @address, interpreted as a @size byte integer.
+ * @access_key: Access key to use for checking storage key protection.
+ *
+ * Perform a cmpxchg on a user space target, honoring storage key protection.
+ * @access_key alone determines how key checking is performed, neither
+ * storage-protection-override nor fetch-protection-override apply.
+ *
+ * Return:	0: successful exchange
+ *		1: exchange failed
+ *		-EFAULT: @address not accessible or not naturally aligned
+ *		-EINVAL: invalid @size
+ */
+static __always_inline int cmpxchg_user_key_size(int size, void __user *address,
+						 unsigned __int128 *old_p,
+						 unsigned __int128 new, u8 access_key)
+{
+	union {
+		u32 word;
+		u64 doubleword;
+	} old;
+	int ret = -EFAULT;
+
+	/*
+	 * The following assumes that:
+	 *  * the current psw key is the default key
+	 *  * no storage protection overrides are in effect
+	 */
+	might_fault();
+	switch (size) {
+	case 16:
+		asm volatile(
+			       "spka	0(%[access_key])\n"
+			"	sacf	256\n"
+			"0:	cdsg	%[old],%[new],%[target]\n"
+			"1:	ipm	%[ret]\n"
+			"	srl	%[ret],28\n"
+			"2:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+			: [old] "+d" (*old_p),
+			  [target] "+Q" (*(unsigned __int128 __user *)address),
+			  [ret] "+d" (ret)
+			: [access_key] "a" (access_key << 4),
+			  [new] "d" (new),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "cc"
+		);
+		return ret;
+	case 8:
+		old.doubleword = *old_p;
+		asm volatile(
+			       "spka	0(%[access_key])\n"
+			"	sacf	256\n"
+			"0:	csg	%[old],%[new],%[target]\n"
+			"1:	ipm	%[ret]\n"
+			"	srl	%[ret],28\n"
+			"2:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+			: [old] "+d" (old.doubleword),
+			  [target] "+Q" (*(u64 __user *)address),
+			  [ret] "+d" (ret)
+			: [access_key] "a" (access_key << 4),
+			  [new] "d" ((u64)new),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "cc"
+		);
+		*old_p = old.doubleword;
+		return ret;
+	case 4:
+		old.word = *old_p;
+		asm volatile(
+			       "spka	0(%[access_key])\n"
+			"	sacf	256\n"
+			"0:	cs	%[old],%[new],%[target]\n"
+			"1:	ipm	%[ret]\n"
+			"	srl	%[ret],28\n"
+			"2:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+			: [old] "+d" (old.word),
+			  [target] "+Q" (*(u32 __user *)address),
+			  [ret] "+d" (ret)
+			: [access_key] "a" (access_key << 4),
+			  [new] "d" ((u32)new),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "cc"
+		);
+		*old_p = old.word;
+		return ret;
+	case 2:
+	case 1:
+		return __cmpxchg_user_key_small(size, (u64)address, old_p, new, access_key);
+	default:
+		return -EINVAL;
+	}
+}
+
+#define cmpxchg_user_key(target_p, old_p, new, access_key)			\
+({										\
+	__typeof__(old_p) __old_p = (old_p);					\
+	unsigned __int128 __old = *__old_p;					\
+	size_t __size = sizeof(*(target_p));					\
+	int __ret;								\
+										\
+	BUILD_BUG_ON(__size != sizeof(*__old_p));				\
+	BUILD_BUG_ON(__size != sizeof(new));					\
+	BUILD_BUG_ON(__size > 16 || !is_power_of_2(__size));			\
+	__ret = cmpxchg_user_key_size(__size, (target_p), &__old, (new),	\
+				      (access_key));				\
+	*__old_p = __old;							\
+	__ret;									\
+})
+
 #endif /* __S390_UACCESS_H */
-- 
2.34.1

