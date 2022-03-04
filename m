Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE64CD413
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 13:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiCDMMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 07:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiCDMMc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 07:12:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178921A6F8B;
        Fri,  4 Mar 2022 04:11:44 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224Ao7eI025179;
        Fri, 4 Mar 2022 12:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Svs8cOqqOCVuUEzFE0BxtsHRyKxZzAuXoVSjh7TSQuQ=;
 b=eP64G+zm9zhU9HmGpRmsCeIHBb9Zm0BeJpyrwIdFON4d/3qrfisPdVYGuDfoh+jBbEgn
 oCxPAnvz0Woq6Zorx0QziiWg6VIq4WPz0ydr6gxbPRQowsrE9ZC5Dkp0EXPcNFCaMWge
 1f7p5tPFjgqsr8cQfoqLWM/nBScJ5BejRoF22PDB8MP6FisaM4XFHkdoBPH+XsUOXJ2h
 Wuw+U0BSI4+bEaV7wVkiz0kg0GpDxvKgmFGAJJxOVE01Cu3OeW9ruShG6bA/4FVgSMiF
 3teKWYyRDYZQXtkTWIPc/1d7UuS0IzKOVOtmkIawjv19PazJn0uW5MSnY+qRHmTHMECh Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekhbx1akn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 12:11:40 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224CBe6B015191;
        Fri, 4 Mar 2022 12:11:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekhbx1ak1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 12:11:39 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224C7GJf006112;
        Fri, 4 Mar 2022 12:11:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3ek4k5hdys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 12:11:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 224CBYLg51446100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 12:11:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3239B4203F;
        Fri,  4 Mar 2022 12:11:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6A4042042;
        Fri,  4 Mar 2022 12:11:33 +0000 (GMT)
Received: from [9.145.58.173] (unknown [9.145.58.173])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Mar 2022 12:11:33 +0000 (GMT)
Message-ID: <e5567007-e710-fd13-f426-a458b93fa3f9@linux.ibm.com>
Date:   Fri, 4 Mar 2022 13:11:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] selftests: drivers/s390x: Add uvdevice tests
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220223144830.44039-1-seiden@linux.ibm.com>
 <20220223144830.44039-4-seiden@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220223144830.44039-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i1Qt4S5-_U4IfDJGcySCKNyjFX5wsAJF
X-Proofpoint-ORIG-GUID: 3mn-vxdKENRDAlT4ySE6MUZTS4wPm9Tf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_02,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/23/22 15:48, Steffen Eiden wrote:
> Adds some selftests to test ioctl error paths of the uv-uapi.
> The Kconfig S390_UV_UAPI must be selected and the Ultravisor facility
> must be available. The test can be executed by non-root, however, the
> uvdevice special file /dev/uv must be accessible for reading and
> writing which may imply root privileges.

Acked-by: Janosch Frank <frankja@linux.ibm.com>


> 
>    ./test-uv-device
>    TAP version 13
>    1..10
>    # Starting 10 tests from 4 test cases.
>    #  RUN           uvio_fixture.qui.fault_ioctl_arg ...
>    #            OK  uvio_fixture.qui.fault_ioctl_arg
>    ok 1 uvio_fixture.qui.fault_ioctl_arg
>    #  RUN           uvio_fixture.qui.fault_uvio_arg ...
>    #            OK  uvio_fixture.qui.fault_uvio_arg
>    ok 2 uvio_fixture.qui.fault_uvio_arg
>    #  RUN           uvio_fixture.qui.inval_ioctl_cb ...
>    #            OK  uvio_fixture.qui.inval_ioctl_cb
>    ok 3 uvio_fixture.qui.inval_ioctl_cb
>    #  RUN           uvio_fixture.qui.inval_ioctl_cmd ...
>    #            OK  uvio_fixture.qui.inval_ioctl_cmd
>    ok 4 uvio_fixture.qui.inval_ioctl_cmd
>    #  RUN           uvio_fixture.att.fault_ioctl_arg ...
>    #            OK  uvio_fixture.att.fault_ioctl_arg
>    ok 5 uvio_fixture.att.fault_ioctl_arg
>    #  RUN           uvio_fixture.att.fault_uvio_arg ...
>    #            OK  uvio_fixture.att.fault_uvio_arg
>    ok 6 uvio_fixture.att.fault_uvio_arg
>    #  RUN           uvio_fixture.att.inval_ioctl_cb ...
>    #            OK  uvio_fixture.att.inval_ioctl_cb
>    ok 7 uvio_fixture.att.inval_ioctl_cb
>    #  RUN           uvio_fixture.att.inval_ioctl_cmd ...
>    #            OK  uvio_fixture.att.inval_ioctl_cmd
>    ok 8 uvio_fixture.att.inval_ioctl_cmd
>    #  RUN           attest_fixture.att_inval_request ...
>    #            OK  attest_fixture.att_inval_request
>    ok 9 attest_fixture.att_inval_request
>    #  RUN           attest_fixture.att_inval_addr ...
>    #            OK  attest_fixture.att_inval_addr
>    ok 10 attest_fixture.att_inval_addr
>    # PASSED: 10 / 10 tests passed.
>    # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   MAINTAINERS                                   |   1 +
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/drivers/.gitignore    |   1 +
>   .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
>   .../selftests/drivers/s390x/uvdevice/config   |   1 +
>   .../drivers/s390x/uvdevice/test_uvdevice.c    | 281 ++++++++++++++++++
>   6 files changed, 307 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f32e876f45c2..7fdf0fa006db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10582,6 +10582,7 @@ F:	arch/s390/kernel/uv.c
>   F:	arch/s390/kvm/
>   F:	arch/s390/mm/gmap.c
>   F:	drivers/s390/char/uvdevice.c
> +F:	tools/testing/selftests/drivers/s390x/uvdevice/
>   F:	tools/testing/selftests/kvm/*/s390x/
>   F:	tools/testing/selftests/kvm/s390x/
>   
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d08fe4cfe811..d454faf936c3 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -10,6 +10,7 @@ TARGETS += core
>   TARGETS += cpufreq
>   TARGETS += cpu-hotplug
>   TARGETS += drivers/dma-buf
> +TARGETS += drivers/s390x/uvdevice
>   TARGETS += efivarfs
>   TARGETS += exec
>   TARGETS += filesystems
> diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
> index ca74f2e1c719..09e23b5afa96 100644
> --- a/tools/testing/selftests/drivers/.gitignore
> +++ b/tools/testing/selftests/drivers/.gitignore
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   /dma-buf/udmabuf
> +/s390x/uvdevice/test_uvdevice
> diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
> new file mode 100644
> index 000000000000..5e701d2708d4
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
> @@ -0,0 +1,22 @@
> +include ../../../../../build/Build.include
> +
> +UNAME_M := $(shell uname -m)
> +
> +ifneq ($(UNAME_M),s390x)
> +nothing:
> +.PHONY: all clean run_tests install
> +.SILENT:
> +else
> +
> +TEST_GEN_PROGS := test_uvdevice
> +
> +top_srcdir ?= ../../../../../..
> +KSFT_KHDR_INSTALL := 1
> +khdr_dir = $(top_srcdir)/usr/include
> +LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
> +
> +CFLAGS += -Wall -Werror -static -I$(khdr_dir) -I$(LINUX_TOOL_ARCH_INCLUDE)
> +
> +include ../../../lib.mk
> +
> +endif
> diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/config b/tools/testing/selftests/drivers/s390x/uvdevice/config
> new file mode 100644
> index 000000000000..f28a04b99eff
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/s390x/uvdevice/config
> @@ -0,0 +1 @@
> +CONFIG_S390_UV_UAPI=y
> diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> new file mode 100644
> index 000000000000..44a6fbefc156
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  selftest for the Ultravisor UAPI device
> + *
> + *  Copyright IBM Corp. 2022
> + *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
> + */
> +
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +
> +#include <asm/uvdevice.h>
> +
> +#include "../../../kselftest_harness.h"
> +
> +#define UV_PATH  "/dev/uv"
> +#define BUFFER_SIZE 0x200
> +FIXTURE(uvio_fixture) {
> +	int uv_fd;
> +	struct uvio_ioctl_cb uvio_ioctl;
> +	uint8_t buffer[BUFFER_SIZE];
> +	__u64 fault_page;
> +};
> +
> +FIXTURE_VARIANT(uvio_fixture) {
> +	unsigned long ioctl_cmd;
> +	uint32_t arg_size;
> +};
> +
> +FIXTURE_VARIANT_ADD(uvio_fixture, qui) {
> +	.ioctl_cmd = UVIO_IOCTL_QUI,
> +	.arg_size = BUFFER_SIZE,
> +};
> +
> +FIXTURE_VARIANT_ADD(uvio_fixture, att) {
> +	.ioctl_cmd = UVIO_IOCTL_ATT,
> +	.arg_size = sizeof(struct uvio_attest),
> +};
> +
> +FIXTURE_SETUP(uvio_fixture)
> +{
> +	self->uv_fd = open(UV_PATH, O_ACCMODE);
> +
> +	self->uvio_ioctl.argument_addr = (__u64)self->buffer;
> +	self->uvio_ioctl.argument_len = variant->arg_size;
> +	self->fault_page =
> +		(__u64)mmap(NULL, (size_t)getpagesize(), PROT_NONE, MAP_ANONYMOUS, -1, 0);
> +}
> +
> +FIXTURE_TEARDOWN(uvio_fixture)
> +{
> +	if (self->uv_fd)
> +		close(self->uv_fd);
> +	munmap((void *)self->fault_page, (size_t)getpagesize());
> +}
> +
> +TEST_F(uvio_fixture, fault_ioctl_arg)
> +{
> +	int rc, errno_cache;
> +
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, NULL);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EFAULT);
> +
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, self->fault_page);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EFAULT);
> +}
> +
> +TEST_F(uvio_fixture, fault_uvio_arg)
> +{
> +	int rc, errno_cache;
> +
> +	self->uvio_ioctl.argument_addr = 0;
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EFAULT);
> +
> +	self->uvio_ioctl.argument_addr = self->fault_page;
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EFAULT);
> +}
> +
> +/*
> + * Test to verify that IOCTLs with invalid values in the ioctl_control block
> + * are rejected.
> + */
> +TEST_F(uvio_fixture, inval_ioctl_cb)
> +{
> +	int rc, errno_cache;
> +
> +	self->uvio_ioctl.argument_len = 0;
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EINVAL);
> +
> +	self->uvio_ioctl.argument_len = (uint32_t)-1;
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EINVAL);
> +	self->uvio_ioctl.argument_len = variant->arg_size;
> +
> +	self->uvio_ioctl.flags = (uint32_t)-1;
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EINVAL);
> +	self->uvio_ioctl.flags = 0;
> +
> +	memset(self->uvio_ioctl.reserved14, 0xff, sizeof(self->uvio_ioctl.reserved14));
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EINVAL);
> +
> +	memset(&self->uvio_ioctl, 0x11, sizeof(self->uvio_ioctl));
> +	rc = ioctl(self->uv_fd, variant->ioctl_cmd, &self->uvio_ioctl);
> +	ASSERT_EQ(rc, -1);
> +}
> +
> +TEST_F(uvio_fixture, inval_ioctl_cmd)
> +{
> +	int rc, errno_cache;
> +	uint8_t nr = _IOC_NR(variant->ioctl_cmd);
> +	unsigned long cmds[] = {
> +		_IOWR('a', nr, struct uvio_ioctl_cb),
> +		_IOWR(UVIO_TYPE_UVC, nr, int),
> +		_IO(UVIO_TYPE_UVC, nr),
> +		_IOR(UVIO_TYPE_UVC, nr, struct uvio_ioctl_cb),
> +		_IOW(UVIO_TYPE_UVC, nr, struct uvio_ioctl_cb),
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(cmds); i++) {
> +		rc = ioctl(self->uv_fd, cmds[i], &self->uvio_ioctl);
> +		errno_cache = errno;
> +		ASSERT_EQ(rc, -1);
> +		ASSERT_EQ(errno_cache, ENOTTY);
> +	}
> +}
> +
> +struct test_attest_buffer {
> +	uint8_t arcb[0x180];
> +	uint8_t meas[64];
> +	uint8_t add[32];
> +};
> +
> +FIXTURE(attest_fixture) {
> +	int uv_fd;
> +	struct uvio_ioctl_cb uvio_ioctl;
> +	struct uvio_attest uvio_attest;
> +	struct test_attest_buffer attest_buffer;
> +	__u64 fault_page;
> +};
> +
> +FIXTURE_SETUP(attest_fixture)
> +{
> +	self->uv_fd = open(UV_PATH, O_ACCMODE);
> +
> +	self->uvio_ioctl.argument_addr = (__u64)&self->uvio_attest;
> +	self->uvio_ioctl.argument_len = sizeof(self->uvio_attest);
> +
> +	self->uvio_attest.arcb_addr = (__u64)&self->attest_buffer.arcb;
> +	self->uvio_attest.arcb_len = sizeof(self->attest_buffer.arcb);
> +
> +	self->uvio_attest.meas_addr = (__u64)&self->attest_buffer.meas;
> +	self->uvio_attest.meas_len = sizeof(self->attest_buffer.meas);
> +
> +	self->uvio_attest.add_data_addr = (__u64)&self->attest_buffer.add;
> +	self->uvio_attest.add_data_len = sizeof(self->attest_buffer.add);
> +	self->fault_page =
> +		(__u64)mmap(NULL, (size_t)getpagesize(), PROT_NONE, MAP_ANONYMOUS, -1, 0);
> +}
> +
> +FIXTURE_TEARDOWN(attest_fixture)
> +{
> +	if (self->uv_fd)
> +		close(self->uv_fd);
> +	munmap((void *)self->fault_page, (size_t)getpagesize());
> +}
> +
> +static void att_inval_sizes_test(uint32_t *size, uint32_t max_size, bool test_zero,
> +				 struct __test_metadata *_metadata,
> +				 FIXTURE_DATA(attest_fixture) *self)
> +{
> +	int rc, errno_cache;
> +	uint32_t tmp = *size;
> +
> +	if (test_zero) {
> +		*size = 0;
> +		rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
> +		errno_cache = errno;
> +		ASSERT_EQ(rc, -1);
> +		ASSERT_EQ(errno_cache, EINVAL);
> +	}
> +	*size = max_size + 1;
> +	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EINVAL);
> +	*size = tmp;
> +}
> +
> +/*
> + * Test to verify that attestation IOCTLs with invalid values in the UVIO
> + * attestation control block are rejected.
> + */
> +TEST_F(attest_fixture, att_inval_request)
> +{
> +	int rc, errno_cache;
> +
> +	att_inval_sizes_test(&self->uvio_attest.add_data_len, UVIO_ATT_ADDITIONAL_MAX_LEN,
> +			     false, _metadata, self);
> +	att_inval_sizes_test(&self->uvio_attest.meas_len, UVIO_ATT_MEASUREMENT_MAX_LEN,
> +			     true, _metadata, self);
> +	att_inval_sizes_test(&self->uvio_attest.arcb_len, UVIO_ATT_ARCB_MAX_LEN,
> +			     true, _metadata, self);
> +
> +	self->uvio_attest.reserved136 = (uint16_t)-1;
> +	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EINVAL);
> +
> +	memset(&self->uvio_attest, 0x11, sizeof(self->uvio_attest));
> +	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
> +	ASSERT_EQ(rc, -1);
> +}
> +
> +static void att_inval_addr_test(__u64 *addr, struct __test_metadata *_metadata,
> +				FIXTURE_DATA(attest_fixture) *self)
> +{
> +	int rc, errno_cache;
> +	__u64 tmp = *addr;
> +
> +	*addr = 0;
> +	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EFAULT);
> +	*addr = self->fault_page;
> +	rc = ioctl(self->uv_fd, UVIO_IOCTL_ATT, &self->uvio_ioctl);
> +	errno_cache = errno;
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_cache, EFAULT);
> +	*addr = tmp;
> +}
> +
> +TEST_F(attest_fixture, att_inval_addr)
> +{
> +	att_inval_addr_test(&self->uvio_attest.arcb_addr, _metadata, self);
> +	att_inval_addr_test(&self->uvio_attest.add_data_addr, _metadata, self);
> +	att_inval_addr_test(&self->uvio_attest.meas_addr, _metadata, self);
> +}
> +
> +static void __attribute__((constructor)) __constructor_order_last(void)
> +{
> +	if (!__constructor_order)
> +		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int fd = open(UV_PATH, O_ACCMODE);
> +
> +	if (fd < 0)
> +		ksft_exit_skip("No uv-device or cannot access " UV_PATH  "\n"
> +			       "Enable CONFIG_S390_UV_UAPI and check the access rights on "
> +			       UV_PATH ".\n");
> +	close(fd);
> +	return test_harness_run(argc, argv);
> +}

