Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B502822AC75
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGWKWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:22:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgGWKWd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:22:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NA4QJx176342;
        Thu, 23 Jul 2020 06:22:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vstqg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:09 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NA6li0187675;
        Thu, 23 Jul 2020 06:22:08 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vstqfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:08 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NAGqFh022080;
        Thu, 23 Jul 2020 10:22:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 32brq83924-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:22:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAM2Au29622582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:22:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0965EA405B;
        Thu, 23 Jul 2020 10:22:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBE42A405F;
        Thu, 23 Jul 2020 10:21:58 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:21:58 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/7] powerpc/watchpoint: 2nd DAWR kvm enablement + selftests
Date:   Thu, 23 Jul 2020 15:50:51 +0530
Message-Id: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230072
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Patch #1, #2 and #3 enables p10 2nd DAWR feature for Book3S kvm guest. DAWR
is a hypervisor resource and thus H_SET_MODE hcall is used to set/unset it.
A new case H_SET_MODE_RESOURCE_SET_DAWR1 is introduced in H_SET_MODE hcall
for setting/unsetting 2nd DAWR. Also, new capability KVM_CAP_PPC_DAWR1 has
been added to query 2nd DAWR support via kvm ioctl.

This feature also needs to be enabled in Qemu to really use it. I'll reply
link to qemu patches once I post them in qemu-devel mailing list.

Patch #4, #5, #6 and #7 adds selftests to test 2nd DAWR.

Dependency:
  1: p10 kvm base enablement
     https://lore.kernel.org/linuxppc-dev/20200602055325.6102-1-alistair@popple.id.au

  2: 2nd DAWR powervm/baremetal enablement
     https://lore.kernel.org/linuxppc-dev/20200723090813.303838-1-ravi.bangoria@linux.ibm.com

  3: ptrace PPC_DEBUG_FEATURE_DATA_BP_DAWR_ARCH_31 flag
     https://lore.kernel.org/linuxppc-dev/20200723093330.306341-1-ravi.bangoria@linux.ibm.com

Patches in this series applies fine on top of powerpc/next (9a77c4a0a125)
plus above dependency patches.

Ravi Bangoria (7):
  powerpc/watchpoint/kvm: Rename current DAWR macros and variables
  powerpc/watchpoint/kvm: Add infrastructure to support 2nd DAWR
  powerpc/watchpoint/kvm: Introduce new capability for 2nd DAWR
  powerpc/selftests/ptrace-hwbreak: Add testcases for 2nd DAWR
  powerpc/selftests/perf-hwbreak: Coalesce event creation code
  powerpc/selftests/perf-hwbreak: Add testcases for 2nd DAWR
  powerpc/selftests: Add selftest to test concurrent perf/ptrace events

 Documentation/virt/kvm/api.rst                |   6 +-
 arch/powerpc/include/asm/hvcall.h             |   2 +
 arch/powerpc/include/asm/kvm_host.h           |   6 +-
 arch/powerpc/include/uapi/asm/kvm.h           |   8 +-
 arch/powerpc/kernel/asm-offsets.c             |   6 +-
 arch/powerpc/kvm/book3s_hv.c                  |  73 +-
 arch/powerpc/kvm/book3s_hv_nested.c           |  15 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |  43 +-
 arch/powerpc/kvm/powerpc.c                    |   3 +
 include/uapi/linux/kvm.h                      |   1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h     |   8 +-
 .../selftests/powerpc/ptrace/.gitignore       |   1 +
 .../testing/selftests/powerpc/ptrace/Makefile |   2 +-
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 646 +++++++++++++++--
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c |  79 +++
 .../powerpc/ptrace/ptrace-perf-hwbreak.c      | 659 ++++++++++++++++++
 16 files changed, 1476 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-perf-hwbreak.c

-- 
2.26.2

