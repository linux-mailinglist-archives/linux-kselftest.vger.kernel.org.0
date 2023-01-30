Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F468173A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 18:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjA3RGR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 12:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbjA3RGM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 12:06:12 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173D42BD2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 09:06:01 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-510476ee20aso61102247b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jf6Gno5Ff0dyq7DhHlgvJXHlK7RmShhFzf2bK4ajpRc=;
        b=j4LEOYLrNL76NTObijY7YXLC4t96dJ8kb3jnT9Z4KLjjXjmnaczCBsSZ7eJWsIzV5n
         t/WVFhIJn7oZVX80U5QL82BYsHE6a/5rHhcBCBehPR+DPLTsjZ7ihzGQVell0V4Mjbw6
         MmxDe1H4gGWmKUaKMhGWf81K9t3sv8JtNV2rzglFX6ggWGZxerdPOaV3Nt56Ttz3mFfP
         hMgc0jYkr4sIPn8QQBkJLOLbZ1Iuo5pSJQOIukuthcUoibNOQovrbNizkJFky0ffo5hh
         Sy39ON+/vITAIZpvPaiUjGhpSLLcO2MMTgIx5NpgCIPQd1k4rjv7o0mOrkT8ATzkhKMv
         DwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf6Gno5Ff0dyq7DhHlgvJXHlK7RmShhFzf2bK4ajpRc=;
        b=ch6fFjpXQ+YXuzMlUm2lgmV1XNX2t4Yd5biEY/W+yFgSBgPac7sJyAe8CZgSm1/hPd
         QBRUIYexiT7ySjr4bVikM0Nez5CqPt+0BXTI/XcTO/dd+ytY3YP+t4XICFCdKd+MAma2
         nPbvRaZWNTuRQ+viC9RCQs34zSi45mNrWJF5JfutX38irZbFrOag74qVA+NU3KhAdgiV
         Lt8p2THtm5f47IJN326hS+HKGHAQuoDya7EY29g1SVyVpqGH9OddbwfQ1GXqz6s8LKH/
         j3MpjoiCbgXxw6sDuQpBSG4cd6jXoOo+7PhNaaHXVyHetQRvj1SQLD9hDTqaYpK8lL92
         qM6A==
X-Gm-Message-State: AO0yUKWc9+310rWvyqgK6XusRGlO8fkU5qF6aZzA322kcgirNg6U8ye1
        1v4pD88tgOc5EFyyBcJhccJm5A==
X-Google-Smtp-Source: AK7set/5cvu/Y4VbF9ce6JFU9HpdtREDJXkI9Z7P5HN59ix/E6X27128930KbFn8HyT2QvOZIxBzjA==
X-Received: by 2002:a05:7500:25a0:b0:f3:b3b7:2da0 with SMTP id bq32-20020a05750025a000b000f3b3b72da0mr807909gab.23.1675098360850;
        Mon, 30 Jan 2023 09:06:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id v4-20020a379304000000b006cec8001bf4sm8347900qkd.26.2023.01.30.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:06:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pMXbT-001KTE-LA;
        Mon, 30 Jan 2023 13:05:59 -0400
Date:   Mon, 30 Jan 2023 13:05:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 31/34] selftests: iommu: Use installed kernel headers
 search path
Message-ID: <Y9f495UGJcLfwJ6t@ziepe.ca>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
 <a0dbbe49-ee6d-7e69-a472-5dc76d3e2c14@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0dbbe49-ee6d-7e69-a472-5dc76d3e2c14@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 30, 2023 at 10:01:23AM -0700, Shuah Khan wrote:
> On 1/27/23 06:57, Mathieu Desnoyers wrote:
> > Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
> > than using kernel headers in include/uapi from the source kernel tree
> > kernel headers.
> > 
> > Remove bogus ../../../../include/ from the search path, because
> > kernel source headers are not needed by those user-space selftests, and
> > it causes issues because -I paths are searched before -isystem paths,
> > and conflicts for files appearing both in kernel sources and in uapi
> > headers with incompatible semantics (e.g. types.h).
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: Ingo Molnar <mingo@redhat.com>
> > ---
> >   tools/testing/selftests/iommu/Makefile | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> > index 7cb74d26f141..32c5fdfd0eef 100644
> > --- a/tools/testing/selftests/iommu/Makefile
> > +++ b/tools/testing/selftests/iommu/Makefile
> > @@ -1,7 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   CFLAGS += -Wall -O2 -Wno-unused-function
> > -CFLAGS += -I../../../../include/uapi/
> > -CFLAGS += -I../../../../include/
> > +CFLAGS += $(KHDR_INCLUDES)
> >   CFLAGS += -D_GNU_SOURCE
> 
> Adding iommu test maintainers:
> 
> I plan to take this through kselftest unless there are conflicts.
> In case there are conflicts and you want to take this through yours
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Go ahead please

Jason
