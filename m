Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC61FF72D
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2019 02:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfKQBgH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Nov 2019 20:36:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfKQBgH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Nov 2019 20:36:07 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4541D207DD;
        Sun, 17 Nov 2019 01:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573954566;
        bh=W8mGhvDjRgS+WJe/Ku3r460x2dTk88Tb5g6TQFG8s74=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=yK9kC5oOARUkH1CY2jV6E0hpn1OGwz8ovxrgHnQ9ZN4dJB54+QN2SOq26+swO+4iq
         iV1t/HKlJgNjpOo2pr5OghsvZvKh8Z/2Ap5sJQjNVBhcLbG6wNfZprfPHfuENIEBbh
         gwk/H1UkG+Awr2SceZFumoxqntfofy/80M1ETcPc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573812972-10529-3-git-send-email-alan.maguire@oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-3-git-send-email-alan.maguire@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v4 linux-kselftest-test 2/6] kunit: hide unexported try-catch interface in try-catch-impl.h
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 16 Nov 2019 17:36:05 -0800
Message-Id: <20191117013606.4541D207DD@mail.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Alan Maguire (2019-11-15 02:16:08)
> diff --git a/lib/kunit/try-catch-impl.h b/lib/kunit/try-catch-impl.h
> new file mode 100644
> index 0000000..e308d5c
> --- /dev/null
> +++ b/lib/kunit/try-catch-impl.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * An API to allow a function, that may fail, to be executed, and recove=
r in a

This file is not an API. Maybe just say "Internal kunit try catch
implementation details to be shared with tests".

> + * controlled manner.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_TRY_CATCH_IMPL_H
> +#define _KUNIT_TRY_CATCH_IMPL_H
> +
> +#include <kunit/try-catch.h>
> +#include <linux/types.h>
> +
> +struct kunit;
> +
> +static inline void kunit_try_catch_init(struct kunit_try_catch *try_catc=
h,
> +                                       struct kunit *test,
> +                                       kunit_try_catch_func_t try,
