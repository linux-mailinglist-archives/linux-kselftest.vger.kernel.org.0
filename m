Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF952FCFD
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbiEUNxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiEUNxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 09:53:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8472C125;
        Sat, 21 May 2022 06:53:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 940081F41DBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653141195;
        bh=i90XVsem0f1OAQg4dG01+GakdBc/QjFw1uj4M0ILyaI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ULRBT/M1z/IqYXKTHOQMol066J5Ys/J/0M4al7RJ6XF0i8J/rliReeq4Fj/9LQe4Z
         3z0Ny2QRu3u2MpuOEpkaetWfmzqGr7yG0CXt8tind+YN2tO0CaOQrxLY9Fxkkp79ZM
         X6ZhlRFZ20hwrRXmJ9TgANek/YS/4cklDcrRXUj7NN0RKpvmQht0L5dg9SiLRusraa
         KLHP/HxFcqOn5YNmJN7mRmMKWYc9UD8Dizx/azktFM/87UXHFcGL0+5IZZj6oJDaFY
         yoHS0YmQ4LKNPLnf2IKpSK+QM4GukwoXbKvocBue1bQWw8CZ2e5mWuh3qGbjaigmKm
         G12QRCYaYI12g==
Message-ID: <5f893d8c-5419-99c6-ad0b-47a0b41b150b@collabora.com>
Date:   Sat, 21 May 2022 18:53:08 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com
Subject: Re: [PATCH v4 2/2] selftests: drivers/s390x: Add uvdevice tests
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>, Greg KH <greg@kroah.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
 <20220510144724.3321985-3-seiden@linux.ibm.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220510144724.3321985-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 7:47 PM, Steffen Eiden wrote:
> Adds some selftests to test ioctl error paths of the uv-uapi.
> The Kconfig S390_UV_UAPI must be selected and the Ultravisor facility
> must be available. The test can be executed by non-root, however, the
> uvdevice special file /dev/uv must be accessible for reading and
> writing which may imply root privileges.
> 
>   ./test-uv-device
>   TAP version 13
>   1..6
>   # Starting 6 tests from 3 test cases.
>   #  RUN           uvio_fixture.att.fault_ioctl_arg ...
>   #            OK  uvio_fixture.att.fault_ioctl_arg
>   ok 1 uvio_fixture.att.fault_ioctl_arg
>   #  RUN           uvio_fixture.att.fault_uvio_arg ...
>   #            OK  uvio_fixture.att.fault_uvio_arg
>   ok 2 uvio_fixture.att.fault_uvio_arg
>   #  RUN           uvio_fixture.att.inval_ioctl_cb ...
>   #            OK  uvio_fixture.att.inval_ioctl_cb
>   ok 3 uvio_fixture.att.inval_ioctl_cb
>   #  RUN           uvio_fixture.att.inval_ioctl_cmd ...
>   #            OK  uvio_fixture.att.inval_ioctl_cmd
>   ok 4 uvio_fixture.att.inval_ioctl_cmd
>   #  RUN           attest_fixture.att_inval_request ...
>   #            OK  attest_fixture.att_inval_request
>   ok 5 attest_fixture.att_inval_request
>   #  RUN           attest_fixture.att_inval_addr ...
>   #            OK  attest_fixture.att_inval_addr
>   ok 6 attest_fixture.att_inval_addr
>   # PASSED: 6 / 6 tests passed.
>   # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
Maybe we shouldn't add the result like this in the commit message. The
test order may change and it may become invalid soon. Just put it after
the commit message.

> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/drivers/.gitignore    |   1 +
>  .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
>  .../selftests/drivers/s390x/uvdevice/config   |   1 +
>  .../drivers/s390x/uvdevice/test_uvdevice.c    | 276 ++++++++++++++++++
>  6 files changed, 302 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
>  create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
>  create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b42ab4a35e18..46a9b1467380 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10786,6 +10786,7 @@ F:	arch/s390/kernel/uv.c
>  F:	arch/s390/kvm/
>  F:	arch/s390/mm/gmap.c
>  F:	drivers/s390/char/uvdevice.c
> +F:	tools/testing/selftests/drivers/s390x/uvdevice/
>  F:	tools/testing/selftests/kvm/*/s390x/
>  F:	tools/testing/selftests/kvm/s390x/
>  
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 2319ec87f53d..d6b307371ef7 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -10,6 +10,7 @@ TARGETS += core
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
>  TARGETS += drivers/dma-buf
> +TARGETS += drivers/s390x/uvdevice
>  TARGETS += efivarfs
>  TARGETS += exec
>  TARGETS += filesystems
> diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
> index ca74f2e1c719..09e23b5afa96 100644
> --- a/tools/testing/selftests/drivers/.gitignore
> +++ b/tools/testing/selftests/drivers/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /dma-buf/udmabuf
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
This doesn't work in different build cases. Please use $(KHDR_INCLUDES)
instead.

> +LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
Which header files do you need from here? I'm not sure what is the
purpose of the header files in $(top_srcdir)/tools/arch and where they
are used.

> +
> +CFLAGS += -Wall -Werror -static -I$(khdr_dir) -I$(LINUX_TOOL_ARCH_INCLUDE)
> +
> +include ../../../lib.mk
> +
> +endif
-- 
Muhammad Usama Anjum
