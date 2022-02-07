Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C74AC944
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 20:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiBGTOT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 14:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiBGTKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 14:10:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A39C0401E1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 11:10:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id og43so20967019ejc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 11:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWmI0He58+fGpGTA8Rm8gAObvQo4qEHhiPU07NkhsrU=;
        b=BY2v58ypySxXPl14DNPEf62qtxzHENwKaC2tSiBirHnjd+8jAj+M9Fx4gncnOERxH3
         V2c6XH9eoIkHw24BGVy/I4E4w69o0GsP8LtdldiWnJ9lsAq8Atm5+4l9geyNTv/htxJ5
         Zfr00RcGOxKGXsqjYskpOlONANfjPLr08K0dUaBcgjzJR640wWPj6pLfckeKalOGbMfv
         khJgAVtNkYFDGwGL3bJ3Q9sHtKARiXG244dD64COXrcZViaG6RvzjGL/57harSacmt8Z
         iWPVHnJ+zAuLpncou7X+RkwMEMPyHHRxZvJekATtdzXsvFuXYqgHj4C+fw5nxIGk0xPk
         0M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWmI0He58+fGpGTA8Rm8gAObvQo4qEHhiPU07NkhsrU=;
        b=dflA/JgBCaocuqN+Z2BpOLxKKkQ2Nikrrttv7VulUPdOrjjX+Y+8C+82tSdDkKoo/8
         EmANFtrVnRm5cpt6fjWvRhiUgmdna7OpH3PbyikGl+bk8EvxMsJH7X4LLdqNwN5lRwA5
         wzEniyBwOKPnVZVV7UXR4P/+TmKNflLihWkXV0c1Icmh/OJIbFgZ5PiGgJQkiRyrsmfL
         yZKJyTCjFdKR8k6G4fytsILl9m7nJiGvsFGJee7RcqkG2kXKwKLIGHzrR5Zg3kQ1OfSM
         9YC34Ej0WB3GndMntOA5XIxJNxpP65VADpAEKhQNU/ttUorn4UtElvrPMpUuHlnI1Az0
         u+FQ==
X-Gm-Message-State: AOAM531wHlAQBANgdVe5kTn9S3k/COzkhwHGuc9K3K2QBP03i0Q/rG7N
        RvVWtDZEmKENwNcnvsb3ch0EXE76ne5ZkpXYIJBVtg==
X-Google-Smtp-Source: ABdhPJy3ECVc8pD/xbPPYk8vIFDKn6i0MIkRSYgTwZVmQyJo6fFv4uAkSka9bBrQB9xqtIbpVcxWgTWc5yeomuohE14=
X-Received: by 2002:a17:906:94e:: with SMTP id j14mr844785ejd.369.1644261003744;
 Mon, 07 Feb 2022 11:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20220207183308.1829495-1-ribalda@chromium.org>
In-Reply-To: <20220207183308.1829495-1-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 11:09:52 -0800
Message-ID: <CAGS_qxoTLwvVjDGbfeOjMrGvh7sck7TDmiVeDXS2S5oyDWiKzA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: Introduce _NULL and _NOT_NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Mon, Feb 7, 2022 at 10:33 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Today, when we want to check if a pointer is NULL and not ERR we have
> two options:
>
> EXPECT_TRUE(test, ptr == NULL);
>
> or
>
> EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);
>
> Create a new set of macros that take care of NULL checks.

I think we've usually had people do
  KUNIT_EXPECT_FALSE(test, nullptr);

I'm not personally against having an explicit NULL check, however.

But if we want to continue with this, we'll want to rebase on top of
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
since a lot of this code has been deleted or refactored.
E.g. see https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/include/kunit/test.h?h=kunit
