Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85F301975
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jan 2021 05:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbhAXEYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Jan 2021 23:24:53 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:44417 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbhAXEYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Jan 2021 23:24:52 -0500
Received: by mail-pf1-f177.google.com with SMTP id t29so6389743pfg.11;
        Sat, 23 Jan 2021 20:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJjehByYClNPkMjmMUzJUZGHRUSf5Lho6X2FcregUXE=;
        b=PdfSAh+EcCw4K+kRLhfslQaNCofx2SY0/iydb2Jk38ZYqTFJdGhi3lr2uCaMv9ARNw
         u0snHTy1uFsF9aIaBVYZn/TyyqVvm7ywa1XwNhdjzrYz9SGZZzXxHVSsKmlWamFvniII
         dJ3+kovNloJ+PVkraWLjcrf/1yUwXICng2Wd8cOAPozOIKLyXvSYyJ4wWgR84h2ur67H
         yp4MGjKT+4UdZ/mukmt2J1Nk7b32+pJH90OkdFXVM505x+jrRtk24WuJnlwtPjcrj46e
         3ZTtzGdJ9uWdKr7XGZNiKGVo1FVHoyObWVWHlEV7dPEYmg2y9FmIz98KSLxGqTAxJLFB
         4Cpw==
X-Gm-Message-State: AOAM532aV5ag3CbV+BiS7G8V6qiOSpExOz1iXMIiytnzd4r6oHKh0+jZ
        O/l14cIeOuJ1WGQxPCNcCOU=
X-Google-Smtp-Source: ABdhPJzNwjKEWsdoOZgLIwoylgr9wmRusOGH5Vc+NPJhCqXflejYLOTe+kH3r/1eX7HtmRdBSe/rDw==
X-Received: by 2002:a62:8c85:0:b029:1bd:5441:6cb8 with SMTP id m127-20020a628c850000b02901bd54416cb8mr4332555pfd.29.1611462251284;
        Sat, 23 Jan 2021 20:24:11 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id bv21sm13709361pjb.1.2021.01.23.20.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 20:24:10 -0800 (PST)
Date:   Sat, 23 Jan 2021 20:24:09 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     shuah@kernel.org, mdf@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3] selftests: drivers: fpga: A test for interrupt support
Message-ID: <YAz2aaHnQ8brCl6q@epycbox.lan>
References: <20210117161815.514078-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117161815.514078-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tom,

On Sun, Jan 17, 2021 at 08:18:15AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
> an expected result.
> 
> Tested on vf device 0xbcc1
> 
> Sample run with
>  # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
>  ...
>  TAP version 13
>  1..1
>  # selftests: drivers/fpga: intr
>  # TAP version 13
>  # 1..1
>  # # Starting 1 tests from 1 test cases.
>  # #  RUN           global.afu_intr ...
>  # #            OK  global.afu_intr
>  # ok 1 global.afu_intr
>  # # PASSED: 1 / 1 tests passed.
>  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>  ok 1 selftests: drivers/fpga: intr
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v1: Convert to kselftest_harness.h framework
> v2: reverse xmas tree variables
> ---
>  MAINTAINERS                                   |  1 +
>  tools/testing/selftests/Makefile              |  1 +
>  tools/testing/selftests/drivers/fpga/Makefile |  7 ++++
>  tools/testing/selftests/drivers/fpga/config   |  1 +
>  tools/testing/selftests/drivers/fpga/intr.c   | 36 +++++++++++++++++++
>  5 files changed, 46 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
>  create mode 100644 tools/testing/selftests/drivers/fpga/config
>  create mode 100644 tools/testing/selftests/drivers/fpga/intr.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index de610a06cb5c..7ed3ce58d95e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6973,6 +6973,7 @@ F:	Documentation/driver-api/fpga/
>  F:	Documentation/fpga/
>  F:	drivers/fpga/
>  F:	include/linux/fpga/
> +F:	tools/testing/selftests/drivers/fpga/
>  
>  FPGA SECURITY MANAGER DRIVERS
>  M:	Russ Weight <russell.h.weight@intel.com>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index afbab4aeef3c..aad4763ec348 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -9,6 +9,7 @@ TARGETS += core
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
>  TARGETS += drivers/dma-buf
> +TARGETS += drivers/fpga
>  TARGETS += efivarfs
>  TARGETS += exec
>  TARGETS += filesystems
> diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
> new file mode 100644
> index 000000000000..eba35c405d5b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/fpga/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +CFLAGS += -I../../../../../usr/include/
> +CFLAGS += -I../../../../../include/uapi/
> +
> +TEST_GEN_PROGS := intr
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
> new file mode 100644
> index 000000000000..e2111b81d8d7
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/fpga/config
> @@ -0,0 +1 @@
> +CONFIG_FPGA_DFL_AFU=m
> diff --git a/tools/testing/selftests/drivers/fpga/intr.c b/tools/testing/selftests/drivers/fpga/intr.c
> new file mode 100644
> index 000000000000..927dcc757f0b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/fpga/intr.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <sys/fcntl.h>
> +#include <sys/ioctl.h>
> +#include <linux/fpga-dfl.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +TEST(afu_intr)
> +{
> +	struct dfl_fpga_port_info port_info;
> +	uint32_t irq_num = UINT32_MAX;
> +	int devfd, status;
> +
> +	devfd = open("/dev/dfl-port.0", O_RDONLY);
> +	if (devfd < 0)
> +		SKIP(0, "no fpga afu device 0");
> +	/*
> +	 * From fpga-dl.h :
> +	 * Currently hardware supports up to 1 irq.
> +	 * Return: 0 on success, -errno on failure.
> +	 */
> +	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
> +	ASSERT_EQ(0, status) {
> +		TH_LOG("ioctl() failed to get the number irqs");
> +	}
> +	ASSERT_LT(irq_num, 256) {
> +		TH_LOG("unexpeced number of irqs");
> +	}
> +	close(devfd);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.27.0
> 
Looks good to me, from FPGA perspective, needs Acked-by from Shua, though.

Also, this does not apply to linux-next, or for-5.12 or char-misc-next,
so I'm confused :)

Once that's sorted, feel free to add

Acked-by: Moritz Fischer <mdf@kernel.org>

- Moritz
