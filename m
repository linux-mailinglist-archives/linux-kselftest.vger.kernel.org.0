Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9328A2F9056
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Jan 2021 04:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbhAQDnv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jan 2021 22:43:51 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36769 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbhAQDnv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jan 2021 22:43:51 -0500
Received: by mail-pf1-f173.google.com with SMTP id b3so8130935pft.3;
        Sat, 16 Jan 2021 19:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U+QdVbDm+ZXIHrLWBLuKdDUFMDUi7DR0AIHkMgQp5Ws=;
        b=VognvNhGs9qHkOnzf617rjxjAVDkT4CKO7qzzsGUgBoxfyS1VwkaitSGvY3qTeh8Um
         C7W8MCJF6Se4BU/9+7mC7+787dJQxx+dVIk2vsE2OzwJooEAnBpISENT3dc77anOzy2+
         n8xwakz1T06udc3+2cD2Vz8HSaO+3axehCiKBNGOLscPo97cRr84INBiTs+b3gChYs5d
         K72BKldxveg7bhUX/bhxA8z67iRS3qZ/qwi172lkfSwMTJjBKSqi3xbtDuiwmTVDvapv
         rELB0GJInz9eGEV6xClu/sbORSbLTiphYqAdYBC/pYFpXJHkTWMTifqCAoANa0ik0HGC
         lrIg==
X-Gm-Message-State: AOAM530f63DnTMikcsit7ZH2LK3/IRTVomwJ9t6fwXtTgewZujnnmwtJ
        +ZyQXJ6+yjewiBfsuE3JAmA=
X-Google-Smtp-Source: ABdhPJzoRs4IS77hgxeHqnCI2PGNA8F6FFxZNSJz99WJ+dwd+HHXbjHUc0uD8Mn2dsKfJewfOdVYYg==
X-Received: by 2002:a62:2bd4:0:b029:1ae:4d9f:60da with SMTP id r203-20020a622bd40000b02901ae4d9f60damr20751041pfr.20.1610854990004;
        Sat, 16 Jan 2021 19:43:10 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z28sm12592339pfr.140.2021.01.16.19.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 19:43:09 -0800 (PST)
Date:   Sat, 16 Jan 2021 19:43:08 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     shuah@kernel.org, mdf@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2] selftests: drivers: fpga: A test for interrupt support
Message-ID: <YAOyTI0PEclTUUuG@epycbox.lan>
References: <20210116193321.385848-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116193321.385848-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tom,

On Sat, Jan 16, 2021 at 11:33:21AM -0800, trix@redhat.com wrote:
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
> index 000000000000..b362fb1f788d
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

Is that how it works with selftests?
> +
> +TEST(afu_intr)
> +{
> +	int devfd, status;
> +	struct dfl_fpga_port_info port_info;
> +	uint32_t irq_num = UINT32_MAX;
Can you order those?

xxxx
xx
x
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

Thanks for starting this, I don't know a lot about selftests (yet).
So we probably want to get a look at this from corresponding maintainers.

- Moritz
