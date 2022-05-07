Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E398351E583
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446091AbiEGIUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 May 2022 04:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446079AbiEGIUK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 May 2022 04:20:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5230558384
        for <linux-kselftest@vger.kernel.org>; Sat,  7 May 2022 01:16:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 202so7927787pgc.9
        for <linux-kselftest@vger.kernel.org>; Sat, 07 May 2022 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=idVYGXtFtIYXbD4diMzv44fhyusigdC9ymPPyiEa4fU=;
        b=YkMuW6w3LJLPY8hqfnwOzbmQzRI+9TJX7xo3XtWW+byYW4msua8cUQhwEZ45NyWBB2
         aVelMQryw0+PknSAzroHFoN8+qsMO9V2DlI1AGeKzCgQaGgDAW5BM4TxFwnp8YUCxiru
         YJ2fPcslpe9WHXdO/b4tQwM/RhQe5Bf2OoG/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idVYGXtFtIYXbD4diMzv44fhyusigdC9ymPPyiEa4fU=;
        b=UAekp3tIUw2s/d2oXUX0lMlRfVV9G8QfBHEvNO0/d//8jb915PhK0lG+FfJ9NFLq7w
         2/vJzmE5zcvfZ6KRRDCPaxoEUZJsUAxBx9oU1AHGU8nH+VmyNsNTAedvDXOreSousvJJ
         r/bYgbUESIdpbVS+ddk8Po9QY3rzawzDnV9gzfQc5biG3hT3hMgQ271GB1LHhkd6Ut3k
         8TtTWB+xoz87sa+tvHNc3a3kgLuJ8Ez2fTichMrd3D3Cx1XeFBd6O8jdtuTTewJFwod+
         +4QmJqtD4BJJOmi94h6daPy9isRpP1E2phjYZWJTnnKLvCMucpvMdqphfhIqzyTvKpW2
         +qWw==
X-Gm-Message-State: AOAM530MR5olGzjgPhtwr0KvEsxlQcgMuLjau4CzBVuTe0ypq+3+WGH+
        AqYrzwqZjO0YptUxH9ovsFOhTg==
X-Google-Smtp-Source: ABdhPJwG5MlyM0SHoqpNwrzltkE25qDsC6TpJlnHRyC6+fUj7zjzSKMW/Tu252LlrQ9GEa9hSXRzoA==
X-Received: by 2002:a63:a06:0:b0:3c2:3345:bf99 with SMTP id 6-20020a630a06000000b003c23345bf99mr6016622pgk.477.1651911384751;
        Sat, 07 May 2022 01:16:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l65-20020a622544000000b0050dc762818dsm4719584pfl.103.2022.05.07.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:16:24 -0700 (PDT)
Date:   Sat, 7 May 2022 01:16:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: take `kunit_assert` as `const`
Message-ID: <202205070116.BC6B4E33@keescook>
References: <20220502093625.GA23225@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502093625.GA23225@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 02, 2022 at 11:36:25AM +0200, Miguel Ojeda wrote:
> The `kunit_do_failed_assertion` function passes its
> `struct kunit_assert` argument to `kunit_fail`. This one,
> in turn, calls its `format` field passing the assert again
> as a `const` pointer.
> 
> Therefore, the whole chain may be made `const`.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
