Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93DBE31FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439625AbfJXMOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 08:14:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbfJXMOA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 08:14:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OC7okH064212
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 08:13:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vua4vc423-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 08:13:59 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 24 Oct 2019 13:13:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 13:13:54 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9OCDqDW45482084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 12:13:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8C1352052;
        Thu, 24 Oct 2019 12:13:52 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.235])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5A9E052054;
        Thu, 24 Oct 2019 12:13:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RESEND v3 0/2] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
Date:   Thu, 24 Oct 2019 14:13:45 +0200
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102412-0020-0000-0000-0000037DD0EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102412-0021-0000-0000-000021D41782
Message-Id: <20191024121347.22189-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=685 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240121
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

Is there anything blocking this from getting merged?


This patch series fixes the following problem:

linux# make kselftest TARGETS=bpf O=/mnt/linux-build
# selftests: bpf: test_libbpf.sh
# ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
# test_libbpf: failed at file test_l4lb.o
# selftests: test_libbpf [FAILED]

Patch 1 appends / to $(OUTPUT) in order to make it more uniform with the
rest of the tree.

Patch 2 fixes the problem by prepending $(OUTPUT) to all members of
$(TEST_PROGS).

v1->v2:
- Append / to $(OUTPUT).
- Use $(addprefix) instead of $(foreach).

v2->v3:
- Split the patch in two.
- Improve the commit message.

Ilya Leoshkevich (2):
  selftests: append / to $(OUTPUT)
  selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)

 tools/testing/selftests/Makefile | 16 ++++++++--------
 tools/testing/selftests/lib.mk   |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.23.0

