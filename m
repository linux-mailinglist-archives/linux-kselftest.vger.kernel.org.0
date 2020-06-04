Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112BD1EE4D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jun 2020 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgFDM42 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Jun 2020 08:56:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgFDM42 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Jun 2020 08:56:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054CWjoJ010764;
        Thu, 4 Jun 2020 08:56:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31efd5q15q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 08:56:18 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054CinA2054649;
        Thu, 4 Jun 2020 08:56:18 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31efd5q14u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 08:56:17 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054CamOs027515;
        Thu, 4 Jun 2020 12:56:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 31bf47v430-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 12:56:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 054CuCPM24510574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jun 2020 12:56:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71C10AE055;
        Thu,  4 Jun 2020 12:56:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF056AE056;
        Thu,  4 Jun 2020 12:56:10 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jun 2020 12:56:10 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
Subject: [PATCH v3 0/3] selftests: powerpc: Fixes and execute-disable test for pkeys
Date:   Thu,  4 Jun 2020 18:26:07 +0530
Message-Id: <20200604125610.649668-1-sandipan@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_10:2020-06-02,2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 cotscore=-2147483648 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040087
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This fixes the way the Authority Mask Register (AMR) is updated
by the existing pkey tests and adds a new test to verify the
functionality of execute-disabled pkeys.

Previous versions can be found at:
v2: https://lore.kernel.org/linuxppc-dev/20200527030342.13712-1-sandipan@linux.ibm.com/
v1: https://lore.kernel.org/linuxppc-dev/20200508162332.65316-1-sandipan@linux.ibm.com/

Changes in v3:
- Fixed AMR writes for existing pkey tests (new patch).
- Moved Hash MMU check under utilities (new patch) and removed duplicate
  code.
- Fixed comments on why the pkey permission bits were redefined.
- Switched to existing mfspr() macro for reading AMR.
- Switched to sig_atomic_t as data type for variables updated in the
  signal handlers.
- Switched to exit()-ing if the signal handlers come across an unexpected
  condition instead of trying to reset page and pkey permissions.
- Switched to write() from printf() for printing error messages from
  the signal handlers.
- Switched to getpagesize().
- Renamed fault counter to denote remaining faults.
- Dropped unnecessary randomization for choosing an address to fault at.
- Added additional information on change in permissions due to AMR and
  IAMR bits in comments.
- Switched the first instruction word of the executable region to a trap
  to test if it is actually overwritten by a no-op later.
- Added an new test scenario where the pkey imposes no restrictions and
  an attempt is made to jump to the executable region again.

Changes in v2:
- Added .gitignore entry for test binary.
- Fixed builds for older distros where siginfo_t might not have si_pkey as
  a formal member based on discussion with Michael.

Sandipan Das (3):
  selftests: powerpc: Fix pkey access right updates
  selftests: powerpc: Move Hash MMU check to utilities
  selftests: powerpc: Add test for execute-disabled pkeys

 tools/testing/selftests/powerpc/include/reg.h |   6 +
 .../testing/selftests/powerpc/include/utils.h |   1 +
 tools/testing/selftests/powerpc/mm/.gitignore |   1 +
 tools/testing/selftests/powerpc/mm/Makefile   |   5 +-
 .../selftests/powerpc/mm/bad_accesses.c       |  28 --
 .../selftests/powerpc/mm/pkey_exec_prot.c     | 388 ++++++++++++++++++
 .../selftests/powerpc/ptrace/core-pkey.c      |   2 +-
 .../selftests/powerpc/ptrace/ptrace-pkey.c    |   2 +-
 tools/testing/selftests/powerpc/utils.c       |  28 ++
 9 files changed, 429 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c

-- 
2.25.1

