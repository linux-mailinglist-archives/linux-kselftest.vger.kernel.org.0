Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102814E5BCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 00:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345485AbiCWXbx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345479AbiCWXbw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 19:31:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83869CCB
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:30:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so5895555ejd.5
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfS7RNhMsAvhm3dkViHCIr0vMqh85tM7E/+ao0kRKJs=;
        b=tW2EeH/eBKHhPEoNUW7aeZDdjSo2N3sR5g8/rjFyrWWIfWC9lzpK7okoF/VHQoK3/R
         nRnXQzDF/+QOzMU5yhwb972fhRH79C3FASiflIzZF8aFHuGLrEbg9V2ojYFvJoHWrXTg
         Rm9xIyV8e3TrJCUCw+B+7bIVxPbQfaXlyC9ysfKC0uwry4x2DrEiYC++/51pb+RW2DU9
         WKnqE3tlVdqzQHCILZG7Fp5+Hy0OD3VN+P4mdQ35EngOytiOZ/9St5He9SjbDhSUlCYV
         rK+T4hZ4nfTY9AnZMav6bqNLsIOBTA+GiUrJF5I4n8B4BsfziS9oabg3fqvrik1d1MWi
         zURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfS7RNhMsAvhm3dkViHCIr0vMqh85tM7E/+ao0kRKJs=;
        b=4OBdcDNsBJ1uqx6ojN5RBbkDXoNoqqgpRJLTRm8+HW9GKP9NvMQeBbd1xCsje/4Lxt
         bMjEYNpwH8EdhxoZvK6YHklkGBfcubmHB4h6Z6BeiJXpIbamWNqN3ejZcYdfrdE5UL7k
         4k/HD4XD9Jv7mLPPy49vXv3c7uBc70mSUmnj+r8Ja2BhWAd9Azrbwr5WVI6zGKsy0DGe
         Dsfql7QPbw/egp8BLrxV37G0z5PaCXpux9owld8AkRMetvwUacLOri3YdPigLgAbKqgd
         gbyjzmQnVye6ChNf3Ii5LMM8DQLBevax0wrVngUb39uj8scuCq3MSSze0Z0FeW+bs0ym
         /YEg==
X-Gm-Message-State: AOAM530/LiH7P8RSXRXG+V4bRcriC67jcWztUL4/hq+6cdyFgRuRZsXP
        uJO+iFnKF9mw7d+GXaiQ+OGhBUMw4a4CxXX55yX3gA==
X-Google-Smtp-Source: ABdhPJy9tB8cZmFLq7/08WeSSCigTCYfwMBIqUubd0WCU7po5l9Q1JOyl8dsivDi3xN38be3+/LEihyciTgUmeVucoU=
X-Received: by 2002:a17:906:d54d:b0:6e0:1f9b:5064 with SMTP id
 cr13-20020a170906d54d00b006e01f9b5064mr2733192ejc.59.1648078219829; Wed, 23
 Mar 2022 16:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220224055350.1854078-1-keescook@chromium.org>
In-Reply-To: <20220224055350.1854078-1-keescook@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:30:08 -0400
Message-ID: <CAFd5g47HMRbKOFbANe_kZ8Td4OHxxwDqpszV515uaMzsz9DoXw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Do not colorize output when redirected
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 24, 2022 at 12:53 AM Kees Cook <keescook@chromium.org> wrote:
>
> Filling log files with color codes makes diffs and other comparisons
> difficult. Only emit vt100 codes when the stdout is a TTY.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
