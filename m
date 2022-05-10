Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4C521DC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbiEJPOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345277AbiEJPNl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:13:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0460D606C8;
        Tue, 10 May 2022 07:47:37 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ADoZia012793;
        Tue, 10 May 2022 14:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=J1YY+eeH/Cn+Un11hD9A+z9P1pkoTiE80D60ILE2xKo=;
 b=S4RbdNWzqrArQMUj+Lmr/bkBtGVoFMyY4xqHlp0Ko5nQkvzUmrX6pWppq8EUqVpogUST
 ie2v52//T9brCE2jUX9pOC8Ta12CzHVk8qtwwq9UJFLBb/aHVKxpIbdDyv8aYZsJT+Qr
 xHhlrHLX969+K1dPssQrYv++y8JmZ6DUGtWlMFYSLHPSiUJkMfAz+PU9Rlat6zj8qHCq
 J8vCkn2Lc6VrE13XBt1C1OX+nDIGZDXK4v38lalEbW5BRGhfB9KeS6PcFEbD3lFb5Pbf
 MZ7r8n0eh5Z0ocZDMoBV3FedEMMRapLVrASIW5pesA7gupjUoEC945aWbF958aLcal6W jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fys9nscac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:47:31 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24AE6J9Q015665;
        Tue, 10 May 2022 14:47:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fys9nsc9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:47:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24AEdJr9012538;
        Tue, 10 May 2022 14:47:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk0495-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:47:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24AEXqdE47972646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 14:33:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D12BA405B;
        Tue, 10 May 2022 14:47:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC32FA405F;
        Tue, 10 May 2022 14:47:25 +0000 (GMT)
Received: from t46lp73.. (unknown [9.152.108.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 14:47:25 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Greg KH <greg@kroah.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v4 2/2] selftests: drivers/s390x: Add uvdevice tests
Date:   Tue, 10 May 2022 14:47:24 +0000
Message-Id: <20220510144724.3321985-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510144724.3321985-1-seiden@linux.ibm.com>
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q3_6BCBEDX1bwLD2J6sEjOGZM2vOmSPH
X-Proofpoint-ORIG-GUID: 0_GCxnZvWr6hjanpg_fjO3Pdk17KYLc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_03,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds some selftests to test ioctl error paths of the uv-uapi.
The Kconfig S390_UV_UAPI must be selected and the Ultravisor facility
must be available. The test can be executed by non-root, however, the
uvdevice special file /dev/uv must be accessible for reading and
writing which may imply root privileges.

  ./test-uv-device
  TAP version 13
  1..6
  # Starting 6 tests from 3 test cases.
  #  RUN           uvio_fixture.att.fault_ioctl_arg ...
  #            OK  uvio_fixture.att.fault_ioctl_arg
  ok 1 uvio_fixture.att.fault_ioctl_arg
  #  RUN           uvio_fixture.att.fault_uvio_arg ...
  #            OK  uvio_fixture.att.fault_uvio_arg
  ok 2 uvio_fixture.att.fault_uvio_arg
  #  RUN           uvio_fixture.att.inval_ioctl_cb ...
  #            OK  uvio_fixture.att.inval_ioctl_cb
  ok 3 uvio_fixture.att.inval_ioctl_cb
  #  RUN           uvio_fixture.att.inval_ioctl_cmd ...
  #            OK  uvio_fixture.att.inval_ioctl_cmd
  ok 4 uvio_fixture.att.inval_ioctl_cmd
  #  RUN           attest_fixture.att_inval_request ...
  #            OK  attest_fixture.att_inval_request
  ok 5 attest_fixture.att_inval_request
  #  RUN           attest_fixture.att_inval_addr ...
  #            OK  attest_fixture.att_inval_addr
  ok 6 attest_fixture.att_inval_addr
  # PASSED: 6 / 6 tests passed.
  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/drivers/.gitignore    |   1 +
 .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
 .../selftests/drivers/s390x/uvdevice/config   |   1 +
 .../drivers/s390x/uvdevice/test_uvdevice.c    | 276 ++++++++++++++++++
 6 files changed, 302 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b42ab4a35e18..46a9b1467380 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10786,6 +10786,7 @@ F:	arch/s390/kernel/uv.c
 F:	arch/s390/kvm/
 F:	arch/s390/mm/gmap.c
 F:	drivers/s390/char/uvdevice.c
+F:	tools/testing/selftests/drivers/s390x/uvdevice/
 F:	tools/testing/selftests/kvm/*/s390x/
 F:	tools/testing/selftests/kvm/s390x/
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2319ec87f53d..d6b307371ef7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -10,6 +10,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/s390x/uvdevice
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
index ca74f2e1c719..09e23b5afa96 100644
--- a/tools/testing/selftests/drivers/.gitignore
+++ b/tools/testing/selftests/drivers/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /dma-buf/udmabuf
+/s390x/uvdevice/test_uvdevice
diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
new file mode 100644
index 000000000000..5e701d2708d4
--- /dev/null
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
@@ -0,0 +1,22 @@
+include ../../../../../build/Build.include
+
+UNAME_M := $(shell uname -m)
+
+ifneq ($(UNAME_M),s390x)
+nothing:
+.PHONY: all clean run_tests install
+.SILENT:
+else
+
+TEST_GEN_PROGS := test_uvdevice
+
+top_srcdir ?= ../../../../../..
+KSFT_KHDR_INSTALL := 1
+khdr_dir = $(top_srcdir)/usr/include
+LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
+
+CFLAGS += -Wall -Werror -static -I$(khdr_dir) -I$(LINUX_TOOL_ARCH_INCLUDE)
+
+include ../../../lib.mk
+
+endif
diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/config b/tools/testing/selftests/drivers/s390x/uvdevice/config
new file mode 100644
index 000000000000..f28a04b99eff
--- /dev/null
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/config
@@ -0,0 +1 @@
+CONFIG_S390_UV_UAPI=y
diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
new file mode 100644
index 000000000000..ea0cdc37b44f
--- /dev/null
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  selftest for the Ultravisor UAPI device
+ *
+ *  Copyright IBM Corp. 2022
+ *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
+ */
+
+#include <stdint.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <asm/uvdevice.h>
+
+#include "../../../kselftest_harness.h"
+
+#define UV_PATH  "/dev/uv"
+#define BUFFER_SIZE 0x200
+FIXTURE(uvio_fixture) {
+	int uv_fd;
+	struct uvio_ioctl_cb uvio_ioctl;
+	uint8_t buffer[BUFFER_SIZE];
+	__u64 fault_page;
+};
+
+FIXTURE_VARIANT(uvio_fixture) {
+	unsigned long ioctl_cmd;
+	uint32_t arg_size;
+};
+
+FIXTURE_VARIANT_ADD(uvio_fixture, att) {
+	.ioctl_cmd = UVIO_IOCTL_ATT,
+	.arg_size = sizeof(struct uvio_attest),
+};
+
+FIXTURE_SETUP(uvio_fixture)
+{
+	self->uv_fd = open(UV_PATH, O_ACCMODE);
+
+	self->uvio_ioctl.argument_addr = (__u64)self->buffer;
+	self->uvio_ioctl.argument_len = variant->arg_size;
+	self->fault_page =
+		(__u64)mmap(NULL, (size_t)getpagesize(), PROT_NONE, MAP_ANONYMOUS, -1, 0);
+}
+
+FIXTURE_TEARDOWN(uvio_fixture)
+{
+	if (self->uv_fd)
+		close(self->uv_fd);
+	munmap((void *)self->fault_page, (size_t)getpagesize());
+}
+
+TEST_F(uvio_fixture, fault_ioctl_arg)
+{
+	int rc, errno_cache;
+
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, NULL);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EFAULT);
+
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, self->fault_page);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EFAULT);
+}
+
+TEST_F(uvio_fixture, fault_uvio_arg)
+{
+	int rc, errno_cache;
+
+	self->uvio_ioctl.argument_addr = 0;
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EFAULT);
+
+	self->uvio_ioctl.argument_addr = self->fault_page;
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EFAULT);
+}
+
+/*
+ * Test to verify that IOCTLs with invalid values in the ioctl_control block
+ * are rejected.
+ */
+TEST_F(uvio_fixture, inval_ioctl_cb)
+{
+	int rc, errno_cache;
+
+	self->uvio_ioctl.argument_len = 0;
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EINVAL);
+
+	self->uvio_ioctl.argument_len = (uint32_t)-1;
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EINVAL);
+	self->uvio_ioctl.argument_len = variant->arg_size;
+
+	self->uvio_ioctl.flags = (uint32_t)-1;
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EINVAL);
+	self->uvio_ioctl.flags = 0;
+
+	memset(self->uvio_ioctl.reserved14, 0xff, sizeof(self->uvio_ioctl.reserved14));
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EINVAL);
+
+	memset(&self->uvio_ioctl, 0x11, sizeof(self->uvio_ioctl));
+	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
+	ASSERT_EQ(rc, -1);
+}
+
+TEST_F(uvio_fixture, inval_ioctl_cmd)
+{
+	int rc, errno_cache;
+	uint8_t nr = _IOC_NR(variant->ioctl_cmd);
+	unsigned long cmds[] = {
+		_IOWR('a', nr, struct uvio_ioctl_cb),
+		_IOWR(UVIO_TYPE_UVC, nr, int),
+		_IO(UVIO_TYPE_UVC, nr),
+		_IOR(UVIO_TYPE_UVC, nr, struct uvio_ioctl_cb),
+		_IOW(UVIO_TYPE_UVC, nr, struct uvio_ioctl_cb),
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(cmds); i++) {
+		rc = ioctl(self->uv_fd, cmds[i], &self->uvio_ioctl);
+		errno_cache = errno;
+		ASSERT_EQ(rc, -1);
+		ASSERT_EQ(errno_cache, ENOTTY);
+	}
+}
+
+struct test_attest_buffer {
+	uint8_t arcb[0x180];
+	uint8_t meas[64];
+	uint8_t add[32];
+};
+
+FIXTURE(attest_fixture) {
+	int uv_fd;
+	struct uvio_ioctl_cb uvio_ioctl;
+	struct uvio_attest uvio_attest;
+	struct test_attest_buffer attest_buffer;
+	__u64 fault_page;
+};
+
+FIXTURE_SETUP(attest_fixture)
+{
+	self->uv_fd = open(UV_PATH, O_ACCMODE);
+
+	self->uvio_ioctl.argument_addr = (__u64)&self->uvio_attest;
+	self->uvio_ioctl.argument_len = sizeof(self->uvio_attest);
+
+	self->uvio_attest.arcb_addr = (__u64)&self->attest_buffer.arcb;
+	self->uvio_attest.arcb_len = sizeof(self->attest_buffer.arcb);
+
+	self->uvio_attest.meas_addr = (__u64)&self->attest_buffer.meas;
+	self->uvio_attest.meas_len = sizeof(self->attest_buffer.meas);
+
+	self->uvio_attest.add_data_addr = (__u64)&self->attest_buffer.add;
+	self->uvio_attest.add_data_len = sizeof(self->attest_buffer.add);
+	self->fault_page =
+		(__u64)mmap(NULL, (size_t)getpagesize(), PROT_NONE, MAP_ANONYMOUS, -1, 0);
+}
+
+FIXTURE_TEARDOWN(attest_fixture)
+{
+	if (self->uv_fd)
+		close(self->uv_fd);
+	munmap((void *)self->fault_page, (size_t)getpagesize());
+}
+
+static void att_inval_sizes_test(uint32_t *size, uint32_t max_size, bool test_zero,
+				 struct __test_metadata *_metadata,
+				 FIXTURE_DATA(attest_fixture) *self)
+{
+	int rc, errno_cache;
+	uint32_t tmp = *size;
+
+	if (test_zero) {
+		*size = 0;
+		rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
+		errno_cache = errno;
+		ASSERT_EQ(rc, -1);
+		ASSERT_EQ(errno_cache, EINVAL);
+	}
+	*size = max_size + 1;
+	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EINVAL);
+	*size = tmp;
+}
+
+/*
+ * Test to verify that attestation IOCTLs with invalid values in the UVIO
+ * attestation control block are rejected.
+ */
+TEST_F(attest_fixture, att_inval_request)
+{
+	int rc, errno_cache;
+
+	att_inval_sizes_test(&self->uvio_attest.add_data_len, UVIO_ATT_ADDITIONAL_MAX_LEN,
+			     false, _metadata, self);
+	att_inval_sizes_test(&self->uvio_attest.meas_len, UVIO_ATT_MEASUREMENT_MAX_LEN,
+			     true, _metadata, self);
+	att_inval_sizes_test(&self->uvio_attest.arcb_len, UVIO_ATT_ARCB_MAX_LEN,
+			     true, _metadata, self);
+
+	self->uvio_attest.reserved136 = (uint16_t)-1;
+	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EINVAL);
+
+	memset(&self->uvio_attest, 0x11, sizeof(self->uvio_attest));
+	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
+	ASSERT_EQ(rc, -1);
+}
+
+static void att_inval_addr_test(__u64 *addr, struct __test_metadata *_metadata,
+				FIXTURE_DATA(attest_fixture) *self)
+{
+	int rc, errno_cache;
+	__u64 tmp = *addr;
+
+	*addr = 0;
+	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EFAULT);
+	*addr = self->fault_page;
+	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
+	errno_cache = errno;
+	ASSERT_EQ(rc, -1);
+	ASSERT_EQ(errno_cache, EFAULT);
+	*addr = tmp;
+}
+
+TEST_F(attest_fixture, att_inval_addr)
+{
+	att_inval_addr_test(&self->uvio_attest.arcb_addr, _metadata, self);
+	att_inval_addr_test(&self->uvio_attest.add_data_addr, _metadata, self);
+	att_inval_addr_test(&self->uvio_attest.meas_addr, _metadata, self);
+}
+
+static void __attribute__((constructor)) __constructor_order_last(void)
+{
+	if (!__constructor_order)
+		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
+}
+
+int main(int argc, char **argv)
+{
+	int fd = open(UV_PATH, O_ACCMODE);
+
+	if (fd < 0)
+		ksft_exit_skip("No uv-device or cannot access " UV_PATH  "\n"
+			       "Enable CONFIG_S390_UV_UAPI and check the access rights on "
+			       UV_PATH ".\n");
+	close(fd);
+	return test_harness_run(argc, argv);
+}
-- 
2.30.2

