Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F51650DD85
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbiDYKF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiDYKFI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 06:05:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66431121;
        Mon, 25 Apr 2022 03:02:02 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P8bA8V017221;
        Mon, 25 Apr 2022 10:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yJ1zH/5or4oymVpE6MpywAGJV0sLnLwAeYGgNXujOL8=;
 b=dWVxAJAz+HE8ivoCl8W0bOjuORNpod8q4Qkj3TavutRtDVY1XxRbMLUkpG6HDeRZmkSs
 VrBQcKOF7A6ROkeOuhGQiCe7gbiM8vCBKepsyxTCN4S/ziyKhfKvcJTjR4FNvALYy7dq
 DoXl9Hea+zosN4de4+vd4Uxgr4f2abmg8miSuBYJrEFf3FXJGoCXSttU8bSj6r56FWan
 ggUDG5DJETjGhssmEFUmaaqbiHbaYv+bnwB0S98zDfMJrNt2YD/afAyCoAijgrop37BS
 LpJuRk+BdfXOZ/WjjRMAEHxGmI5RJ9I2aip5ZoB/AJ2nESmnvSXneimp4fBLfArlNVMI eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmtt75xkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:01:58 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23P9sQ43010172;
        Mon, 25 Apr 2022 10:01:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmtt75xju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:01:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P9rKOR010822;
        Mon, 25 Apr 2022 10:01:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938t5p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:01:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PA1qB746858678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 10:01:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 215764203F;
        Mon, 25 Apr 2022 10:01:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A56F742047;
        Mon, 25 Apr 2022 10:01:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 10:01:51 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/2] Dirtying, failing memop: don't indicate suppression
Date:   Mon, 25 Apr 2022 12:01:45 +0200
Message-Id: <20220425100147.1755340-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4VQjVuQ6EtulenyNeAdKeaZfUj349-xi
X-Proofpoint-ORIG-GUID: IplMkzRrx3fmY94QmOmdYV35_zj0R7q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_05,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=739 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If a memop fails due to key checked protection, after already having
written to the guest, don't indicate suppression to the guest, as that
would imply that memory wasn't modified.

This could be considered a fix to the code introducing storage key
support, however this is a bug in KVM only if we emulate an
instructions writing to an operand spanning multiple pages, which I
don't believe we do.

v1 -> v2
 * Reword commit message of patch 1

Janis Schoetterl-Glausch (2):
  KVM: s390: Don't indicate suppression on dirtying, failing memop
  KVM: s390: selftest: Test suppression indication on key prot exception

 arch/s390/kvm/gaccess.c                   | 47 ++++++++++++++---------
 tools/testing/selftests/kvm/s390x/memop.c | 43 ++++++++++++++++++++-
 2 files changed, 70 insertions(+), 20 deletions(-)


base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
-- 
2.32.0

