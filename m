Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740624BC2E3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Feb 2022 00:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiBRX3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 18:29:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiBRX3G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 18:29:06 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B42183B
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 15:28:46 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w7so9424840ioj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 15:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WdyRbSqxjRN1Kn8UJVUm0MbimiQX+217FfELPaU3/mo=;
        b=So2XH78/2595kAYYKMXPWI9MBLaanBtHaVGj+8tMhL2jAiQtdtMjFgn2Wt6CDsh/u3
         TR34w2Vl+WqieKRHoe0bR0w2XuiMfdnv3LrzFE+B6Vcs0jGSHaHGs51Oii2MuvHVZrFh
         I/IZ0LRqi7EEW7qvKWvYWPRgRj8BzKHB4vSDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WdyRbSqxjRN1Kn8UJVUm0MbimiQX+217FfELPaU3/mo=;
        b=0+2AqloRQgjphBnRBe3GyrgH6OSqBhLlkOwufhQdZGdkPJah/fzGKfruNILyiqJmK5
         iEoH0Ka1Tv3doyLDSslhlwNGWRAeWRtbgfbj7fOOvgYspPqTwk74T9QVffbdmYEkz5ur
         /wa3jkuA2RYBXFxcBrEj8YyhEyJXGW+O94Akzug4j2VIW8vqrRESxb38tZJqIGC6wd2d
         OQkZaWUkJlyUMU8OWr6vZ/2Aupf5Hb8OeWMfefjVd3dPxOaUiUJ0UNHtUsLVBlBR/TU2
         ZDkXtfSnxxwsVM4Qux0Ya5LClIDGws1Z04tqaYu5qQwf/JvLR+43n4PyS1l/cup4Ua9X
         dMqw==
X-Gm-Message-State: AOAM533Oyfbo4csjRXfHQUk1FLA6AH8sJtUihcuSWs/QOzoQsVIkuDVP
        vCZ5ZGiJhBg5N70qqHA0woiWCw==
X-Google-Smtp-Source: ABdhPJxmcycqlgoMN58L6oxhcMc4rumhOI+6qqD7jI8B6nrdWJoKhQN+KJXjBlbPEIJq21Mo9AC9CQ==
X-Received: by 2002:a02:cc55:0:b0:311:bd14:fe74 with SMTP id i21-20020a02cc55000000b00311bd14fe74mr6960161jaq.84.1645226926133;
        Fri, 18 Feb 2022 15:28:46 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m14sm3821705ioj.34.2022.02.18.15.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 15:28:45 -0800 (PST)
Subject: Re: [PATCH 3/3] selftests: drivers/s390x: Add uvdevice tests
To:     Steffen Eiden <seiden@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220217113717.46624-1-seiden@linux.ibm.com>
 <20220217113717.46624-4-seiden@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e624fe39-51e2-cfd0-fcdc-d04080272386@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 16:28:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220217113717.46624-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/22 4:37 AM, Steffen Eiden wrote:
> Adds some selftests to test ioctl error paths of the uv-uapi.
> 

Please add information on how to run this test and example output.

> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   MAINTAINERS                                   |   1 +
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/drivers/.gitignore    |   1 +
>   .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
>   .../selftests/drivers/s390x/uvdevice/config   |   1 +
>   .../drivers/s390x/uvdevice/test_uvdevice.c    | 280 ++++++++++++++++++
>   6 files changed, 306 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7d8d0fe48cf..c6a0311c3fa8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10462,6 +10462,7 @@ F:	arch/s390/kernel/uv.c
>   F:	arch/s390/kvm/
>   F:	arch/s390/mm/gmap.c
>   F:	drivers/s390/char/uvdevice.c
> +F:	tools/testing/selftests/drivers/s390x/uvdevice/
>   F:	tools/testing/selftests/kvm/*/s390x/
>   F:	tools/testing/selftests/kvm/s390x/
>   
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c852eb40c4f7..3b8abaee9271 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -9,6 +9,7 @@ TARGETS += core
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
> index 000000000000..f23663bcab03
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> @@ -0,0 +1,280 @@
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
> +	self->uv_fd = open("/dev/uv", O_RDWR);
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
> +		ASSERT_EQ(errno_cache, EINVAL);
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
> +	self->uv_fd = open("/dev/uv", O_RDWR);

So each test opne and closes the devuce. Can this file stay open
for the duraction of the test run and close it in main() after
test exits?

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
> +	int fd = open("/dev/uv", O_RDWR);
> +
> +	if (fd < 0) {
> +		ksft_exit_skip("No uv-device.\n");

Please add information on which confg options need to be enabled
to run this test - CONFIG_S390_UV_UAPI?

Also add a check and skip when run by non-root if this test requires
root privileges.

> +		ksft_exit(KSFT_SKIP);

You don't need this - ksft_exit_skip() calls exit(KSFT_SKIP)


> +	}
> +	close(fd);

Closing the file before test inocation?

> +	return test_harness_run(argc, argv);
> +}
> 

thanks,
-- Shuah
