Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507EE6164D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiKBOTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKBOS5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:18:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFBA21833;
        Wed,  2 Nov 2022 07:18:56 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Dpjw4008756;
        Wed, 2 Nov 2022 14:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sF+mkI3HSPsn4wmbySApFqmizJqNfA4IkUpWUyU93Xg=;
 b=LntSF9ILKUP0pWPfKWqjEsrXixq/6KQiwLu/L7FarmtbYx3d3doqS79gFbMX8Oe17kq8
 SUEdfWJUO58/4f7ElV45F2MMWvOFYsi0wY+o2Q06DmMSPnwDAQJhR5jIboSb6PSpoHjj
 3gKj7aoUobbY6PoD08+aRGA9zeAfqyQSsZ06PEMgBS/sxWGtm94nRCD1SdP2LjKMeEL6
 X5gLJ8M2HrVEcd2djn/H9jLlIkkWlR27XFZ6TjbmI1KIySz5zmRcnTQWJmLrqBK5oOtt
 kZ7TcP5pAyH8wR47ZAklgSoTeRcgAh726qO9LhEyh6vXEXm4gokKGkx6E+ni6JyhVFl/ Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqqmx9hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:18:52 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2DpBYn038080;
        Wed, 2 Nov 2022 14:18:52 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqqmx9e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:18:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2ECr0a018887;
        Wed, 2 Nov 2022 14:18:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut96wsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:18:50 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2EJN6653281200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 14:19:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 210AAA4051;
        Wed,  2 Nov 2022 14:18:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79DF7A4040;
        Wed,  2 Nov 2022 14:18:46 +0000 (GMT)
Received: from osiris (unknown [9.145.56.93])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 14:18:46 +0000 (GMT)
Date:   Wed, 2 Nov 2022 15:18:45 +0100
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
Subject: [PATCH 4/5] s390/extable: add EX_TABLE_UA_LOAD_REGPAIR() macro
Message-ID: <Y2J8RSW2khWLgpPo@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2J61LWSV+HolIeT@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dUjOFY9LaDn_rbAjZq7InrZnIHeXXR53
X-Proofpoint-ORIG-GUID: B1Tv3iuu2unEyDUov4uPwf3p_Olq3GCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=911 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new exception table type which is able to handle register
pairs. If an exception is recognized on such an instruction the
specified register pair will be zeroed, and the specified error
register will be modified so it contains -EFAULT, similar to the
existing EX_TABLE_UA_LOAD_REG() macro.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/asm-extable.h | 4 ++++
 arch/s390/mm/extable.c              | 9 +++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index b74f1070ddb2..55a02a153dfc 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -12,6 +12,7 @@
 #define EX_TYPE_UA_STORE	3
 #define EX_TYPE_UA_LOAD_MEM	4
 #define EX_TYPE_UA_LOAD_REG	5
+#define EX_TYPE_UA_LOAD_REGPAIR	6
 
 #define EX_DATA_REG_ERR_SHIFT	0
 #define EX_DATA_REG_ERR		GENMASK(3, 0)
@@ -85,4 +86,7 @@
 #define EX_TABLE_UA_LOAD_REG(_fault, _target, _regerr, _regzero)	\
 	__EX_TABLE_UA(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REG, _regerr, _regzero, 0)
 
+#define EX_TABLE_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero)	\
+	__EX_TABLE_UA(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REGPAIR, _regerr, _regzero, 0)
+
 #endif /* __ASM_EXTABLE_H */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 1e4d2187541a..fe87291df95d 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -47,13 +47,16 @@ static bool ex_handler_ua_load_mem(const struct exception_table_entry *ex, struc
 	return true;
 }
 
-static bool ex_handler_ua_load_reg(const struct exception_table_entry *ex, struct pt_regs *regs)
+static bool ex_handler_ua_load_reg(const struct exception_table_entry *ex,
+				   bool pair, struct pt_regs *regs)
 {
 	unsigned int reg_zero = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
 	unsigned int reg_err = FIELD_GET(EX_DATA_REG_ERR, ex->data);
 
 	regs->gprs[reg_err] = -EFAULT;
 	regs->gprs[reg_zero] = 0;
+	if (pair)
+		regs->gprs[reg_zero + 1] = 0;
 	regs->psw.addr = extable_fixup(ex);
 	return true;
 }
@@ -75,7 +78,9 @@ bool fixup_exception(struct pt_regs *regs)
 	case EX_TYPE_UA_LOAD_MEM:
 		return ex_handler_ua_load_mem(ex, regs);
 	case EX_TYPE_UA_LOAD_REG:
-		return ex_handler_ua_load_reg(ex, regs);
+		return ex_handler_ua_load_reg(ex, false, regs);
+	case EX_TYPE_UA_LOAD_REGPAIR:
+		return ex_handler_ua_load_reg(ex, true, regs);
 	}
 	panic("invalid exception table entry");
 }
-- 
2.34.1

