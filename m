Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F207121BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbjEZIB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEZIB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 04:01:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A9A3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 May 2023 01:01:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30adc51b65cso60962f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 May 2023 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685088115; x=1687680115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSyxPKq6EWo4D7MkDUjCBW9xn+lNBx+ZT11wkIIdHB4=;
        b=lERcr0PA/fbIoYPsA7Sw3mkjgj+AqH5n+Fy1US6weG8wZQqlv9mBphYKJ1d8+Sq9iH
         YuQH0gX17Q5n7Vlb1A7PPE8zjhjnUDRCvwFmxqdDOpUOzEvUQ3U3DA+rYHxxdFffb2t2
         t7FniiQlnSwN+fzlkT4b749qL0/kkS8KLlcMau0zoYEl1nTOQmrdBEtI7oYA77SL0r37
         BJUJ5NLOvbi2nzIc/ag3OXRgBT7UeEqZh971zPaF5Wxo8r1OUkX9fX8V9jbB17pkArpf
         rbWXOANt/wh9E/a4eHSkXbjl0tcPJmOg15l0ueLL0RCSdgD0vh9djt9PGv6pciBstUE+
         h08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685088115; x=1687680115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSyxPKq6EWo4D7MkDUjCBW9xn+lNBx+ZT11wkIIdHB4=;
        b=WHHIOCq/MA1aqDZ7x08dfsO07CL5zR6gomeqH64L844uRLeGPJROrFVnpY5uPFhN8l
         c9tRGFuhegx8AFJ/80zB1Spt7aND6Hy7748IGjIMBliwWmJc0NV+fV0BC12nKhdqsshy
         0jvvRtEb88u8jz/FxMNABEV2L0+AxHXuBh8ZKxTg5u7FAcdmhFjmio7YO6BJ8q02AVUE
         LW5oAI1+JwnD66OYxQI4K77TbLvVaiRIQ/A5z87XEnUcYplkrQbKRQJG962LuK/yfF3f
         C74yNf9I5d6kjiYgOnvYfKEDT2nZZtGn0Ny4hw57BORdV0vqMlFE1Opa5A712wInWTjX
         OlOA==
X-Gm-Message-State: AC+VfDyEeTE5jR3xWQ9Aii7aG2IueWhfP0L907qAroyMJEz5QyfWFyQq
        P/t5r+j6L8OwVNNpMny0+ff9PQ==
X-Google-Smtp-Source: ACHHUZ7nhWjq8+8bFfH6uGh1zYKsCUqDvcd/yOlUAj7GTgZNdy3Cmviwqr0L/xYpMdiNLJgShurLfQ==
X-Received: by 2002:adf:f6d0:0:b0:305:fbfb:c7d7 with SMTP id y16-20020adff6d0000000b00305fbfbc7d7mr800217wrp.44.1685088114754;
        Fri, 26 May 2023 01:01:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5312000000b0030922ba6d0csm4337294wrv.45.2023.05.26.01.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:01:53 -0700 (PDT)
Date:   Fri, 26 May 2023 11:01:49 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kunit: Move kunit_abort() call out of
 kunit_do_failed_assertion()
Message-ID: <1dd943e3-cf3c-4928-8464-b02795092bc0@kili.mountain>
References: <20230526075355.586335-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526075355.586335-1-davidgow@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023 at 03:53:54PM +0800, David Gow wrote:
> KUnit aborts the current thread when an assertion fails. Currently, this
> is done conditionally as part of the kunit_do_failed_assertion()
> function, but this hides the kunit_abort() call from the compiler
> (particularly if it's in another module). This, in turn, can lead to
> both suboptimal code generation (the compiler can't know if
> kunit_do_failed_assertion() will return), and to static analysis tools
> like smatch giving false positives.
> 
> Moving the kunit_abort() call into the macro should give the compiler
> and tools a better chance at understanding what's going on. Doing so
> requires exporting kunit_abort(), though it's recommended to continue to
> use assertions in lieu of aborting directly.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: David Gow <davidgow@google.com>

Awesome thanks!  I had already hardcoded the current behavior but I'm
happy to delete that code.  This works automatically and will continue
to work if we change the parameters to kunit_do_failed_assertion() in
the future.

regards,
dan carpenter

