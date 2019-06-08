Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8339A88
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 05:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfFHD41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 23:56:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36159 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbfFHD40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 23:56:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so1542750plr.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sg8hZnfRQyshVayh9AfBUaCUwYP0fG+PoifVRoQ1/2U=;
        b=dA3axcy3OSjQBllR3jO2rSL28yV4HEUJp/aPnDeszFXA+QJykqsQIUJ72CJFJfYEfw
         wdg907Km6KiqXC2789/OeRpcFlLBSZiEqKz1cQEJwy/XIHhLz8qR/HqqVrGp+0QeTjJc
         WftaB+rnktSZBXZ74MuozosAkMHfiOKMwo6jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sg8hZnfRQyshVayh9AfBUaCUwYP0fG+PoifVRoQ1/2U=;
        b=pthrR9qWK64PiQeBeFosTLbY2bEHGaoTECFO4kmG4zPhqCGiwc659DkMsO34GcOGPr
         qB3iMhrAS0XuzJePTJP6XIKDqhtt/mYvh5MBQDeSo9bPjNBgF3YSEQucTi+N+Cnak2RZ
         +38erf+uOk7TLFPWPd0Y0Xqdjbpv6u9ZT7NZ5Jq0eZ9HpvWESkzJqs41Vhfxe45YjAkC
         Xkq5C5bEHyHYkNKmK7HVA7kmIjOJI12y8KdGV1JWVtfzrCfKU5LPBooNRDHs/AMVFE38
         y1QkzJAAqJbAKdzezw7R+yDjx0bFw5BqdKbb/IE0RuSkfxTD3lEArd/IYYKDun8f+doy
         S34w==
X-Gm-Message-State: APjAAAWc9yMraBTTZ9fTljxGGfUYXjaJmLdaP3EgDiHY3c0oVdhBjUlv
        7XlySxtaCms9ml+prTO7TgM9NQ==
X-Google-Smtp-Source: APXvYqxOa+LbIfSKzO98kP7ZimZglTjC5TFvL11aIkaQBz55ZFGw6dQUA6lPd2PVhnyZkGPHF3XY8g==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr59073078plt.81.1559966186036;
        Fri, 07 Jun 2019 20:56:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c6sm6781898pfm.163.2019.06.07.20.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:56:25 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:56:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v16 16/16] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
Message-ID: <201906072055.7DFED7B@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <9e1b5998a28f82b16076fc85ab4f88af5381cf74.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1b5998a28f82b16076fc85ab4f88af5381cf74.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:18PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> This patch adds a simple test, that calls the uname syscall with a
> tagged user pointer as an argument. Without the kernel accepting tagged
> user pointers the test fails with EFAULT.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I'm adding Shuah to CC in case she has some suggestions about the new
selftest.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/arm64/.gitignore      |  1 +
>  tools/testing/selftests/arm64/Makefile        | 22 ++++++++++
>  .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++
>  tools/testing/selftests/arm64/tags_lib.c      | 42 +++++++++++++++++++
>  tools/testing/selftests/arm64/tags_test.c     | 18 ++++++++
>  5 files changed, 95 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/.gitignore
>  create mode 100644 tools/testing/selftests/arm64/Makefile
>  create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
>  create mode 100644 tools/testing/selftests/arm64/tags_lib.c
>  create mode 100644 tools/testing/selftests/arm64/tags_test.c
> 
> diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
> new file mode 100644
> index 000000000000..e8fae8d61ed6
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/.gitignore
> @@ -0,0 +1 @@
> +tags_test
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> new file mode 100644
> index 000000000000..9dee18727923
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +include ../lib.mk
> +
> +# ARCH can be overridden by the user for cross compiling
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +
> +ifneq (,$(filter $(ARCH),aarch64 arm64))
> +
> +TEST_CUSTOM_PROGS := $(OUTPUT)/tags_test
> +
> +$(OUTPUT)/tags_test: tags_test.c $(OUTPUT)/tags_lib.so
> +	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $<
> +
> +$(OUTPUT)/tags_lib.so: tags_lib.c
> +	$(CC) -o $@ -shared $(CFLAGS) $(LDFLAGS) $^
> +
> +TEST_PROGS := run_tags_test.sh
> +
> +all: $(TEST_CUSTOM_PROGS)
> +
> +endif
> diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/run_tags_test.sh
> new file mode 100755
> index 000000000000..2bbe0cd4220b
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/run_tags_test.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +echo "--------------------"
> +echo "running tags test"
> +echo "--------------------"
> +LD_PRELOAD=./tags_lib.so ./tags_test
> +if [ $? -ne 0 ]; then
> +	echo "[FAIL]"
> +else
> +	echo "[PASS]"
> +fi
> diff --git a/tools/testing/selftests/arm64/tags_lib.c b/tools/testing/selftests/arm64/tags_lib.c
> new file mode 100644
> index 000000000000..8a674509216e
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/tags_lib.c
> @@ -0,0 +1,42 @@
> +#include <stdlib.h>
> +
> +#define TAG_SHIFT	(56)
> +#define TAG_MASK	(0xffUL << TAG_SHIFT)
> +
> +void *__libc_malloc(size_t size);
> +void __libc_free(void *ptr);
> +void *__libc_realloc(void *ptr, size_t size);
> +void *__libc_calloc(size_t nmemb, size_t size);
> +
> +static void *tag_ptr(void *ptr)
> +{
> +	unsigned long tag = rand() & 0xff;
> +	if (!ptr)
> +		return ptr;
> +	return (void *)((unsigned long)ptr | (tag << TAG_SHIFT));
> +}
> +
> +static void *untag_ptr(void *ptr)
> +{
> +	return (void *)((unsigned long)ptr & ~TAG_MASK);
> +}
> +
> +void *malloc(size_t size)
> +{
> +	return tag_ptr(__libc_malloc(size));
> +}
> +
> +void free(void *ptr)
> +{
> +	__libc_free(untag_ptr(ptr));
> +}
> +
> +void *realloc(void *ptr, size_t size)
> +{
> +	return tag_ptr(__libc_realloc(untag_ptr(ptr), size));
> +}
> +
> +void *calloc(size_t nmemb, size_t size)
> +{
> +	return tag_ptr(__libc_calloc(nmemb, size));
> +}
> diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
> new file mode 100644
> index 000000000000..263b302874ed
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/tags_test.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <sys/utsname.h>
> +
> +int main(void)
> +{
> +	struct utsname *ptr;
> +	int err;
> +
> +	ptr = (struct utsname *)malloc(sizeof(*ptr));
> +	err = uname(ptr);
> +	free(ptr);
> +	return err;
> +}
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
