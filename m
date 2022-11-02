Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970126164DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiKBOTt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiKBOTk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:19:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66725EB8;
        Wed,  2 Nov 2022 07:19:35 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2E3CHU032109;
        Wed, 2 Nov 2022 14:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=cpS4jCXtAgG23IYho072uv1MOqrz2rC1hqfYXx9XTiM=;
 b=YHPV19VtBH3rJ3UF01yHAwCwrBio41jqU55Ty1qelzxoizbqXTET4hbvQEpesT/02aUF
 eUt7ij/e9bxMj7gbMJsZAXTmU6m/Guqfl+b/ciGs6YFK2PzJ46ijt3vI5LNJnSLU/sbB
 MA2oMDhA4+3jQ/NVv4wkukqcodvmXSOC3WzGwgQzXSQVaYctzTA4uZBUPuTu/Nqgn50G
 YVYL/tIeznflzh2zMre11c4nfMUpMfT31weuViiDWukfjASlxNNIc02nsmaeulniPbqd
 fkQmkMv+54V2W9AsTKLGXTmfhUjDWo1Km0Ea5rcSNzD4XXXgQI0v2EEjUfXSl2W27U1j Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkrm3m92e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:19:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2CVBfE001074;
        Wed, 2 Nov 2022 14:19:30 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkrm3m90x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:19:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2E5gS0031309;
        Wed, 2 Nov 2022 14:19:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kgut8xy83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:19:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2EJPNr6554200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 14:19:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C67CAE053;
        Wed,  2 Nov 2022 14:19:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92B00AE045;
        Wed,  2 Nov 2022 14:19:24 +0000 (GMT)
Received: from osiris (unknown [9.145.56.93])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 14:19:24 +0000 (GMT)
Date:   Wed, 2 Nov 2022 15:19:23 +0100
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
Subject: [PATCH 5/5] s390/uaccess: add cmpxchg_user_key()
Message-ID: <Y2J8axs+bcQ2dO/l@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2J61LWSV+HolIeT@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BQjQBuqkLLh_MI4SibRQLD6Uzy99mvew
X-Proofpoint-ORIG-GUID: GazAMsVZxi9O4ebPcugr9WgaS8FW6tu0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=751
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add cmpxchg_user_key() which allows to execute a compare and exchange
on a user space address. This allows also to specify a storage key
which makes sure that key-controlled protection is considered.

This is based on a patch written by Janis Schoetterl-Glausch.

Link: https://lore.kernel.org/all/20220930210751.225873-2-scgl@linux.ibm.com
Cc: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 183 ++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index f7038b800cc3..9bbdecb80e06 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -390,4 +390,187 @@ do {									\
 		goto err_label;						\
 } while (0)
 
+void __cmpxchg_user_key_called_with_bad_pointer(void);
+
+static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
+					      __uint128_t old, __uint128_t new,
+					      unsigned long key, int size)
+{
+	int rc = 0;
+
+	switch (size) {
+	case 1: {
+		unsigned int prev, tmp, shift;
+
+		shift = (3 ^ (address & 3)) << 3;
+		address ^= address & 3;
+		asm volatile(
+			"	spka	0(%[key])\n"
+			"	sacf	256\n"
+			"0:	l	%[prev],%[address]\n"
+			"1:	nr	%[prev],%[mask]\n"
+			"	lr	%[tmp],%[prev]\n"
+			"	or	%[prev],%[old]\n"
+			"	or	%[tmp],%[new]\n"
+			"2:	cs	%[prev],%[tmp],%[address]\n"
+			"3:	jnl	4f\n"
+			"	xr	%[tmp],%[prev]\n"
+			"	nr	%[tmp],%[mask]\n"
+			"	jnz	1b\n"
+			"4:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE_UA_LOAD_REG(0b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(1b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(2b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(3b, 4b, %[rc], %[prev])
+			: [rc] "+&d" (rc),
+			  [prev] "=&d" (prev),
+			  [tmp] "=&d" (tmp),
+			  [address] "+Q" (*(int *)address)
+			: [old] "d" (((unsigned int)old & 0xff) << shift),
+			  [new] "d" (((unsigned int)new & 0xff) << shift),
+			  [mask] "d" (~(0xff << shift)),
+			  [key] "a" (key),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "memory", "cc");
+		*(unsigned char *)uval = prev >> shift;
+		return rc;
+	}
+	case 2: {
+		unsigned int prev, tmp, shift;
+
+		shift = (2 ^ (address & 2)) << 3;
+		address ^= address & 2;
+		asm volatile(
+			"	spka	0(%[key])\n"
+			"	sacf	256\n"
+			"0:	l	%[prev],%[address]\n"
+			"1:	nr	%[prev],%[mask]\n"
+			"	lr	%[tmp],%[prev]\n"
+			"	or	%[prev],%[old]\n"
+			"	or	%[tmp],%[new]\n"
+			"2:	cs	%[prev],%[tmp],%[address]\n"
+			"3:	jnl	4f\n"
+			"	xr	%[tmp],%[prev]\n"
+			"	nr	%[tmp],%[mask]\n"
+			"	jnz	1b\n"
+			"4:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE_UA_LOAD_REG(0b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(1b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(2b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(3b, 4b, %[rc], %[prev])
+			: [rc] "+&d" (rc),
+			  [prev] "=&d" (prev),
+			  [tmp] "=&d" (tmp),
+			  [address] "+Q" (*(int *)address)
+			: [old] "d" (((unsigned int)old & 0xffff) << shift),
+			  [new] "d" (((unsigned int)new & 0xffff) << shift),
+			  [mask] "d" (~(0xffff << shift)),
+			  [key] "a" (key),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "memory", "cc");
+		*(unsigned short *)uval = prev >> shift;
+		return rc;
+	}
+	case 4:	{
+		unsigned int prev = old;
+
+		asm volatile(
+			"	spka	0(%[key])\n"
+			"	sacf	256\n"
+			"0:	cs	%[prev],%[new],%[address]\n"
+			"1:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE_UA_LOAD_REG(0b, 1b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(1b, 1b, %[rc], %[prev])
+			: [rc] "+&d" (rc),
+			  [prev] "+&d" (prev),
+			  [address] "+Q" (*(int *)address)
+			: [new] "d" ((unsigned int)new),
+			  [key] "a" (key),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "memory", "cc");
+		*(unsigned int *)uval = prev;
+		return rc;
+	}
+	case 8: {
+		unsigned long prev = old;
+
+		asm volatile(
+			"	spka	0(%[key])\n"
+			"	sacf	256\n"
+			"0:	csg	%[prev],%[new],%[address]\n"
+			"1:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE_UA_LOAD_REG(0b, 1b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(1b, 1b, %[rc], %[prev])
+			: [rc] "+&d" (rc),
+			  [prev] "+&d" (prev),
+			  [address] "+QS" (*(long *)address)
+			: [new] "d" ((unsigned long)new),
+			  [key] "a" (key),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "memory", "cc");
+		*(unsigned long *)uval = prev;
+		return rc;
+	}
+	case 16: {
+		__uint128_t prev = old;
+
+		asm volatile(
+			"	spka	0(%[key])\n"
+			"	sacf	256\n"
+			"0:	cdsg	%[prev],%[new],%[address]\n"
+			"1:	sacf	768\n"
+			"	spka	%[default_key]\n"
+			EX_TABLE_UA_LOAD_REGPAIR(0b, 1b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REGPAIR(1b, 1b, %[rc], %[prev])
+			: [rc] "+&d" (rc),
+			  [prev] "+&d" (prev),
+			  [address] "+QS" (*(__int128_t *)address)
+			: [new] "d" (new),
+			  [key] "a" (key),
+			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			: "memory", "cc");
+		*(__uint128_t *)uval = prev;
+		return rc;
+	}
+	}
+	__cmpxchg_user_key_called_with_bad_pointer();
+	return rc;
+}
+
+/**
+ * cmpxchg_user_key() - cmpxchg with user space target, honoring storage keys
+ * @ptr: User space address of value to compare to @old and exchange with
+ *	 @new. Must be aligned to sizeof(*@size).
+ * @uval: Address where the old value of *@ptr is written to.
+ * @old: Old value. Compared to the content pointed to by @ptr in order to
+ *	 determine if the exchange occurs. The old value read from *@ptr is
+ *	 written to *@uval.
+ * @new: New value to place at *@ptr.
+ * @key: Access key to use for checking storage key protection.
+ *
+ * Perform a cmpxchg on a user space target, honoring storage key protection.
+ * @key alone determines how key checking is performed, neither
+ * storage-protection-override nor fetch-protection-override apply.
+ * The caller must compare *@uval and @old to determine if values have been
+ * exchanged. In case of an exception *@uval is set to zero.
+ *
+ * Return:     0: cmpxchg executed
+ *	       -EFAULT: an exception happened when trying to access *@ptr
+ */
+#define cmpxchg_user_key(ptr, uval, old, new, key)			\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(uval) __uval = (uval);				\
+									\
+	BUILD_BUG_ON(sizeof(*(__ptr)) != sizeof(*(__uval)));		\
+	might_fault();							\
+	__chk_user_ptr(__ptr);						\
+	__cmpxchg_user_key((unsigned long)(__ptr), (void *)(__uval),	\
+			   (old), (new), (key), sizeof(*(__ptr)));	\
+})
+
 #endif /* __S390_UACCESS_H */
-- 
2.34.1

