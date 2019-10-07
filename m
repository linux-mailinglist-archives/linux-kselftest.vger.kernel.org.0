Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA077CEEAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJGV6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 17:58:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42592 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGV6L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 17:58:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so9010508pgp.9
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d9R2DytZLVyk2fwJJFRzpjruYoBx/tgy0WautWlgOD8=;
        b=Fi8DtEjIQeSKrxEK0+d42P779M0GrBfYYm+MgPk1Xj1ol6nl48uSmWyivr1wC7aQZ3
         SBRmwey+QVdnbcBzrHYjark4SV/68MO04hHYrjLg3R2duGdAIJ5D/Pw347dnBXlwVVH9
         cW0799mRq1crPTl6lQ1S5motdn4zbfG51kqiYkqh4QLUaAwbqSgYjyrsMXFrj9clkPza
         rC2EoEsxcUDjOSrQKRUHgLnxjiw5GdhHX3W7HR3KjuBbfx3Ua9JPhKkdjJ3Fq0E2j3MH
         MXkaPHBzET+2hjqUAQfDu+is4YsBX9qz8Hluoezq/wI+rMOd4b3VwQIAQ2jMKJsHOqwH
         Hejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9R2DytZLVyk2fwJJFRzpjruYoBx/tgy0WautWlgOD8=;
        b=C6f5CVP4QyFZ7TMuK1Qh5NTP5zL937e6zxEjZhgXn/BVTK3bQqpJrqjvtsQVt+hYtn
         bBTK02S/lbZE/sdsQoiy9Rz2yVCG0dgIa7eqW8Lx1032hSiqdk/ensyXjJ/yNlEd1uD5
         xiTJyDxUBAZHJnzH4z/FmWF47A6OHep8fVT+EiIwKNnIP+3Kxnbr7YLYUnFlp65lWoG6
         MTAY1ptzJ7R7B6tCiGB4GH3IL+5cI5+M9YXqgIT6JCD4Wolw9xvRV2tPOc0sfc1rowSH
         TeknXMXJSbcGz6pvW5QCDxhkAw2jOPbDP8IJwBjnLLZXGfUe11aAPJvR+MDdtFDqogs2
         NbyQ==
X-Gm-Message-State: APjAAAW1OcESjTLws+Y0GC9s/luwkuaI3XBgmVwXcn/n4+s+FGAK0C29
        pSY4cqdlqJwKBUu+j4jcbBqk0Q==
X-Google-Smtp-Source: APXvYqwL205rHfAPFri+fkXARng7t7g7JOTuAdW9fVsDitixtXyp2m0tM+RHh6xfTDgdgPcNZjw6lw==
X-Received: by 2002:a62:75d2:: with SMTP id q201mr34993831pfc.43.1570485489852;
        Mon, 07 Oct 2019 14:58:09 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id 26sm13262381pgz.70.2019.10.07.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 14:58:08 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:58:04 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <20191007215804.GA119460@google.com>
References: <20191007213633.92565-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007213633.92565-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> This change adds a KUnit test for the kernel doubly linked list
> implementation in include/linux/list.h
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> This change depends on KUnit, so should be merged via the 'test' branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test

Others might feel differently than me, but I think this should go in the
comment section (below the "---").

> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  lib/Kconfig.debug |  12 +
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 726 insertions(+)
>  create mode 100644 lib/list-test.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5dadcd..60691c0aac3e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1961,6 +1961,18 @@ config SYSCTL_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_TEST
> +	bool "KUnit Test for Kernel Linked-list stuctures"
> +	depends on KUNIT
> +	help
> +	  This builds the linked list unit test, which runs on boot.
> +	  It tests that the API and basic functionality of the list_head type
> +	  and associated macros.
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index bba1fd5485f7..309e174ee35d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) += objagg.o
> +
> +# KUnit tests
> +obj-$(CONFIG_LIST_TEST) += list-test.o
> diff --git a/lib/list-test.c b/lib/list-test.c
> new file mode 100644
> index 000000000000..f333e8b0d9fe
> --- /dev/null
> +++ b/lib/list-test.c
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: GPL-2.0

Might also want to add a bit more of a description here. Even if it is
just something like "KUnit test for the doubly linked list data
structure."

Also:

/*
 * <Insert description here.>
 *
 * Copyright (C) 2019, Google LLC.
 * Author: David Gow <davidgow@google.com>
 */

> +#include <kunit/test.h>
> +
> +#include <linux/list.h>
> +
> +struct list_test_struct {
> +	int data;
> +	struct list_head list;
> +};

<snip>

Thanks!
