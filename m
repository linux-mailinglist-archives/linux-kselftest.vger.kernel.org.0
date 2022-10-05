Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254055F5B2B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJEUnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJEUnF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:43:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE1061729
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:43:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot12so314255ejb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyg/xSbqc6YjfKAnVU7YGGT1j7ZqGbK/FQ9IaJudGs0=;
        b=nq4gFl8x3PDTHtMukRjR339j1Sh8DgsUtPjrpdzKDm4Fl/PRgKx2tgbu7Sft7nJqaO
         uhY2mZlejvrRmhurwx556klr/M/LpvX4cQKViM0I9GheMvEjbZkB13QZjwOkBtzoOB0J
         eEQsiRfS46Y4yNs3XRDBjieT5xl3bZ/FlPV29hgvxhJKYc6ZTb/fbRx+NjR/X7AuHFZH
         3nex9IJdP0xTjJeu0tEPed42MTUOkUCcUrxjLXIRR+tTvSWb1Tq13HilExXkc4nDOtcY
         lBRaiS8MqeNX1yjDtV/B4qkdpg6AGm2/o8xTQIJQhB36MPd62/CEtZ1JwKFH/yd5lQ83
         3pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uyg/xSbqc6YjfKAnVU7YGGT1j7ZqGbK/FQ9IaJudGs0=;
        b=tRZUPc4sJlX7BnESFOKIdCBvs3xfL0e0wiR1pg2GdFvGsCwjmYJ7+bJL+oif7XNWdd
         CDEmpipmKfWSnOdIpo9jJUL/QR7z1CHQncWbAlAvUfFnrDd8cthnUWAtUqktUxYXLY+M
         9CAYF2Bm1dwKVQFhUqsVJYyOa79DQC/RQ9YJgJU6c4rAS3anezXEnXdFtVJQGssIYdhT
         8nXfjhmSo4rcXXbcB5+3uW7VqMRNoYpC0pTJh2t/VP235KbqUROPHyYVjAnakz9x8AiE
         IMkHVtvhLqgQC2lwVMo4SC9h4efbBpaTKDmvGkE0PzIebcZl5xsw/8c+QGeWvVa/ZNwB
         OmYQ==
X-Gm-Message-State: ACrzQf3QmbLOvgHCi1UUEndPQkE7ZK7mITGW1zy/GOGBXtYgK56/pvX+
        UDAMZX0alVv071eVaywNKHALXqyzjVHCbsudQScrVQ==
X-Google-Smtp-Source: AMsMyM6/Qo8zDvnM3qgpGGqrO5MPh9PzJ8Lb8zrsHZluGDFXq8f2wLT78LMvXO5kjUf5CX9lv2aoWTQeTGk5KahJtYg=
X-Received: by 2002:a17:906:6791:b0:78d:4051:969f with SMTP id
 q17-20020a170906679100b0078d4051969fmr349532ejp.171.1665002583274; Wed, 05
 Oct 2022 13:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220923050039.3371091-1-davidgow@google.com>
In-Reply-To: <20220923050039.3371091-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:42:52 -0400
Message-ID: <CAFd5g47Ne7+w36AbaZ9nvq0_yia4X_t6Ft64LAAtBgK5xROC3g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Don't download risc-v opensbi firmware with wget
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 23, 2022 at 1:01 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> When running a RISC-V test kernel under QEMU, we need an OpenSBI BIOS
> file. In the original QEMU support patchset, kunit_tool would optionally
> download this file from GitHub if it didn't exist, using wget.
>
> These days, it can usually be found in the distro's qemu-system-riscv
> package, and is located in /usr/share/qemu on all the distros I tried
> (Debian, Arch, OpenSUSE). Use this file, and thereby don't do any
> downloading in kunit_tool.
>
> In addition, we used to shell out to whatever 'wget' was in the path,
> which could have potentially been used to trick the developer into
> running another binary. By not using wget at all, we nicely sidestep
> this issue.
>
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Fixes: 87c9c1631788 ("kunit: tool: add support for QEMU")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
