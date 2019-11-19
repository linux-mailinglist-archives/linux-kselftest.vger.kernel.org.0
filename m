Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD3102E13
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 22:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKSVNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 16:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSVNQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 16:13:16 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EFC6223E4;
        Tue, 19 Nov 2019 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574197995;
        bh=+rZbMiTPYllqoniIMcGs/dtJqiSXsDPl4BOGrV5LLyM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fXZYQ+b+Ktmf9wsPjVTZpfwRmX+bHAdGGR+e8D2LHjAiOOZrrpf/kniJKaLV6p8As
         /qlwSrWVMmGPnJi2+7jkxaJACmiHB4NBr5+63q2yZ38RqvKXH2XNkPeSjl63VdEj6S
         lZGBvUDbeO4y58fjCKEZczMw0VYE3Lj+2slmXyEs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573812972-10529-6-git-send-email-alan.maguire@oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-6-git-send-email-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 linux-kselftest-test 5/6] kunit: allow kunit to be loaded as a module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 13:13:14 -0800
Message-Id: <20191119211315.4EFC6223E4@mail.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Alan Maguire (2019-11-15 02:16:11)
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 87b5cf1..41ef71a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -486,3 +486,16 @@ void kunit_cleanup(struct kunit *test)
>         }
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
> +
> +static int kunit_init(void)

Missing __init?

> +{
> +       return 0;
> +}
> +late_initcall(kunit_init);

It looks pretty weird that this doesn't do anything in the module init
or exit path. How does it work? And why does it need to be late init if
nothing is called from here?

> +
> +static void __exit kunit_exit(void)
> +{
> +}
> +module_exit(kunit_exit);
> +
> +MODULE_LICENSE("GPL");

I guess should be "GPL v2"?

