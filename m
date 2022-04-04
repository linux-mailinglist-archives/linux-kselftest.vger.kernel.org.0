Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3314F1E22
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Apr 2022 00:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiDDVyM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 17:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379933AbiDDVas (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 17:30:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A736AA180
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 14:14:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g22so12660257edz.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Apr 2022 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5JDtmIs58TRR3YM1MH2n9ydceKzu8ZMJYE0EAd1fdA=;
        b=mXu+kbIOllUFvjcA3fMxHjtto4SRHNogC5DNMGt298LCEFBZj/4pCFusAyxJJwXDFE
         aknCc84+LN9asN3z8ABlK1Neu52RGYbDbxQ/x7wMjt8hgDbCi8gC3h63ehV3//RUcjEQ
         uXd8VnYduxNmDzxwkqs5cArm2NvcR5NWQ29lBNGTdYvQoscK7mpNXBKQ0tLJIvZZx8EK
         UHAQPh+V4qvmOeqTkgtiZtN6T1lQfPOOloeTXFuwpCBWe7cbtmQqJ4Ou8yw7CeR2UsF3
         4uTo3/Qh87ML1kHT+0XUbhJ3pDx3kqchZRWH52MVse9/W3tOmLVYxXkyLWDShcPe6WYR
         SzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5JDtmIs58TRR3YM1MH2n9ydceKzu8ZMJYE0EAd1fdA=;
        b=15HnHUJYqo/HemnfxskUiUe54+Z2R2UA2zzw0GjntvmwUJmXbwPYO/G8/P8pNm3ttH
         zNNxPtdZqpUhktvvK1UOOvaN5WOpER3Ac+cajRE6YOZO9yDPx+ygsTemTqFm1u6wY6lk
         8Omv7jm+4j9NoUTUmNSyCIu1iVy1GvXpaH4+YhilarMy7bPSc14ECiwJu8OI9wJ1wlpy
         Im2KW4MKBgJcFYbyNDZhtIa1SzrOe23EVPvEr3HoRo5JW8Fh8TiieCK7P1SI9ilPDaJk
         ZBQ81aIXr5kfuiBFn3TdIY/z9cc3fDEsDilSdbuCJM10nHkgcLfRxHWg03Lh1M3E7liT
         iirA==
X-Gm-Message-State: AOAM530p4BYrk/g11ZEBSYwsvDB6Lvwa9XwW2G1en4k9TEWbVTZAD7BY
        DAy1ExwIoa82xYPX7yiKEcu52b26EdxjdotS6Lf/3A==
X-Google-Smtp-Source: ABdhPJyMO0ydKmS0siYdaHdVOwsHoBm4w6Sf5vzl64BwKlS1ZlQJjG/60KDSEZUZzhTTg4BvzwEuDDfUH50t+IgZaN8=
X-Received: by 2002:a05:6402:d0a:b0:418:ec3b:2242 with SMTP id
 eb10-20020a0564020d0a00b00418ec3b2242mr83168edb.229.1649106839033; Mon, 04
 Apr 2022 14:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318021314.3225240-3-davidgow@google.com>
In-Reply-To: <20220318021314.3225240-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 4 Apr 2022 16:13:47 -0500
Message-ID: <CAGS_qxqtMpjKX+CMF6eBUWfsc-TKR9-Bk+hYM=PHa0_wUtQQuA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kunit: expose ftrace-based API for stubbing out
 functions during tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 17, 2022 at 9:13 PM David Gow <davidgow@google.com> wrote:
> +
> +/** KUNIT_STUBBABLE - marks a function as stubbable when stubbing support is
> + * enabled.
> + *
> + * Stubbing uses ftrace internally, so we can only stub out functions when they
> + * are not inlined. This macro eavlautes to noinline when stubbing support is

Just noting a couple typos lest they be forgotten:
*evaluates

> + * enabled to thus make it safe.
> + *

<snip>

> + *
> + *     void replacement_func(int n)
> + *     {
> + *             pr_info("replacement_func() called with %d", n);
> + *             return 42;
> + *     }
> + *
> + *     void example_test(struct kunit *test)
> + *     {
> + *             kunit_active_ftrace_stub(test, real_func, replacement_func);

*activate
