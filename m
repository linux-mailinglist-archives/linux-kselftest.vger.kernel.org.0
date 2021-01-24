Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91134301CEE
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jan 2021 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbhAXPIW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 10:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbhAXPIV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 10:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611500813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WggKaRygWF5ZvUkOTaB2jRxdcoS8ZrKYqVE+CHFSYHs=;
        b=IQ5f3lnjauBe4cHO/xRVcvMeZBbOicE3LtkBQRR5wP/FSmGtEvvajobmeqcjd81LlooLzf
        G/3XNPAqGSCC2lVdNZPub8C9Da/6qqmguITQQr7lFYGNQFVVZM5NcMqwqX3xiVNIG+2XUv
        O9NGFbx/1w+kan6iD/XTbm2s2HUH5KI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-0cEHSXccOA2rbPYRcdrXXA-1; Sun, 24 Jan 2021 10:06:51 -0500
X-MC-Unique: 0cEHSXccOA2rbPYRcdrXXA-1
Received: by mail-qk1-f198.google.com with SMTP id s66so8172573qkh.10
        for <linux-kselftest@vger.kernel.org>; Sun, 24 Jan 2021 07:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WggKaRygWF5ZvUkOTaB2jRxdcoS8ZrKYqVE+CHFSYHs=;
        b=ETULyNer4Hv3oR7dHa82yfvZT6ghn6Pql+sDXj8CxJRFmf71Zi48IN782fsSUJmwuv
         54IiD7gqUcUsXqJnQ6hghZw0NqaX8XD9bEI71BBy/Haa54Kj1g4kT5TAYvSFOnQ3XErN
         HPqs4oeuH7UAWFfYbbz5HyJtDWSHWOkc6J02Q7lA52nnzAnpmdKIDbhMzcaD26uYxrlA
         cUnUggvNe40PCkAkBa17GNpmNVe0gua8XKzE2QE85E+ME6iLQ+NaqxumRLeHQsV+zxcX
         7YCkZG0MfuoDdcxwZjbqVetnZfs9HnDjaB3PchLg0GLsPuHbBTCmqeM1oI0teDOwFy3R
         QXLQ==
X-Gm-Message-State: AOAM531MxVrX5VN14gsvypFPCeCSYjlAiY1mGomslPuJmVoAvmSFYTgM
        xjfyk9V1fyaw1GkNZye4/G4EBwIAtzDvQX+QLGBGRD2tdOjsl3FpcFKUSRoNHNk9CITnh5x1EeU
        4PMzDJUhULxxZDUtlI0pGfYPaz64h
X-Received: by 2002:a0c:c242:: with SMTP id w2mr1117969qvh.33.1611500811442;
        Sun, 24 Jan 2021 07:06:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfmqtAhJWKl1QaXXrTEpjaZiUordM271aZzT7QHEM4rFJW0hNtUnvvlF826xGa4AR31SgNog==
X-Received: by 2002:a0c:c242:: with SMTP id w2mr1117955qvh.33.1611500811240;
        Sun, 24 Jan 2021 07:06:51 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j124sm10093281qkf.113.2021.01.24.07.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 07:06:50 -0800 (PST)
Subject: Re: [PATCH v3] selftests: drivers: fpga: A test for interrupt support
To:     Moritz Fischer <mdf@kernel.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20210117161815.514078-1-trix@redhat.com>
 <YAz2aaHnQ8brCl6q@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4c5adecc-8a66-350a-c1a2-a44e8ca982ef@redhat.com>
Date:   Sun, 24 Jan 2021 07:06:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAz2aaHnQ8brCl6q@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/23/21 8:24 PM, Moritz Fischer wrote:
> Tom,
>
> On Sun, Jan 17, 2021 at 08:18:15AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
>> an expected result.
>>
>> Tested on vf device 0xbcc1
>>
>> Sample run with
>>  # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
>>  ...
>>  TAP version 13
>>  1..1
>>  # selftests: drivers/fpga: intr
>>  # TAP version 13
>>  # 1..1
>>  # # Starting 1 tests from 1 test cases.
>>  # #  RUN           global.afu_intr ...
>>  # #            OK  global.afu_intr
>>  # ok 1 global.afu_intr
>>  # # PASSED: 1 / 1 tests passed.
>>  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>  ok 1 selftests: drivers/fpga: intr
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> v1: Convert to kselftest_harness.h framework
>> v2: reverse xmas tree variables
>> ---
>>  MAINTAINERS                                   |  1 +
>>  tools/testing/selftests/Makefile              |  1 +
>>  tools/testing/selftests/drivers/fpga/Makefile |  7 ++++
>>  tools/testing/selftests/drivers/fpga/config   |  1 +
>>  tools/testing/selftests/drivers/fpga/intr.c   | 36 +++++++++++++++++++
>>  5 files changed, 46 insertions(+)
>>  create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
>>  create mode 100644 tools/testing/selftests/drivers/fpga/config
>>  create mode 100644 tools/testing/selftests/drivers/fpga/intr.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index de610a06cb5c..7ed3ce58d95e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6973,6 +6973,7 @@ F:	Documentation/driver-api/fpga/
>>  F:	Documentation/fpga/
>>  F:	drivers/fpga/
>>  F:	include/linux/fpga/
>> +F:	tools/testing/selftests/drivers/fpga/
>>  
>>  FPGA SECURITY MANAGER DRIVERS
>>  M:	Russ Weight <russell.h.weight@intel.com>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index afbab4aeef3c..aad4763ec348 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -9,6 +9,7 @@ TARGETS += core
>>  TARGETS += cpufreq
>>  TARGETS += cpu-hotplug
>>  TARGETS += drivers/dma-buf
>> +TARGETS += drivers/fpga
>>  TARGETS += efivarfs
>>  TARGETS += exec
>>  TARGETS += filesystems
>> diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
>> new file mode 100644
>> index 000000000000..eba35c405d5b
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/fpga/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +CFLAGS += -I../../../../../usr/include/
>> +CFLAGS += -I../../../../../include/uapi/
>> +
>> +TEST_GEN_PROGS := intr
>> +
>> +include ../../lib.mk
>> diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
>> new file mode 100644
>> index 000000000000..e2111b81d8d7
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/fpga/config
>> @@ -0,0 +1 @@
>> +CONFIG_FPGA_DFL_AFU=m
>> diff --git a/tools/testing/selftests/drivers/fpga/intr.c b/tools/testing/selftests/drivers/fpga/intr.c
>> new file mode 100644
>> index 000000000000..927dcc757f0b
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/fpga/intr.c
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <stdint.h>
>> +#include <string.h>
>> +#include <sys/fcntl.h>
>> +#include <sys/ioctl.h>
>> +#include <linux/fpga-dfl.h>
>> +
>> +#include "../../kselftest_harness.h"
>> +
>> +TEST(afu_intr)
>> +{
>> +	struct dfl_fpga_port_info port_info;
>> +	uint32_t irq_num = UINT32_MAX;
>> +	int devfd, status;
>> +
>> +	devfd = open("/dev/dfl-port.0", O_RDONLY);
>> +	if (devfd < 0)
>> +		SKIP(0, "no fpga afu device 0");
>> +	/*
>> +	 * From fpga-dl.h :
>> +	 * Currently hardware supports up to 1 irq.
>> +	 * Return: 0 on success, -errno on failure.
>> +	 */
>> +	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
>> +	ASSERT_EQ(0, status) {
>> +		TH_LOG("ioctl() failed to get the number irqs");
>> +	}
>> +	ASSERT_LT(irq_num, 256) {
>> +		TH_LOG("unexpeced number of irqs");
>> +	}
>> +	close(devfd);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> -- 
>> 2.27.0
>>
> Looks good to me, from FPGA perspective, needs Acked-by from Shua, though.
>
> Also, this does not apply to linux-next, or for-5.12 or char-misc-next,
> so I'm confused :)
>
> Once that's sorted, feel free to add

This applied to char-misc-next, at least a couple of days ago, I will check again

T

> Acked-by: Moritz Fischer <mdf@kernel.org>
>
> - Moritz
>

