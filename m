Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D993A8A45
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 22:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOUm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 16:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFOUm1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 16:42:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3CDC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:40:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bp38so445836lfb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mI+Uy62aXOt4Prq2PUS7VjWc/+uB2vw7iQueiUDdSS8=;
        b=Mh7FeTdwsPNuQXmG7HfR3LIBdVoplRNF5u49c3WP1H7V7D/qBiWT4GvO9Y7dzzPcn+
         ew8Ag5oOZ8bgypyaT2/P1u8tQ5PbJetE4Ut9i9UzFsBjnbjO828Gsuq37QBJEu78eKOt
         Sp3tWASzcB6xeHqyrYFLI808p9ELdvkHism3yPJsmQz8MOMrKe1ixjfHTBXT4yZdKdad
         tmLWT5MqbxYcCWpyR9XO7lri4REO9Y3KpaIZEiuveOuK65fvCplnDv4onYmdaK+gwiIu
         akr9s0n4/tEXQMlUWmPYPh6ACLN6zEHT5SysQUapNW7MvBt2OJGJs8yxLcrVSVFROIPr
         rCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mI+Uy62aXOt4Prq2PUS7VjWc/+uB2vw7iQueiUDdSS8=;
        b=ZjoF5l8B20O6FbI+vhtwfrg0LeEbn+Rxkam27elA7CSgUxauHpSK2FQnHvIJbDzKJG
         Dh3fTmLW3RS9WWX1e2I2y5UGrvWIJ3+SlI6tSpZ1ZqUCxjfKsya5wyij3uKZjFNmd4vm
         Iti0X7lEhzu1JYG1qDovb5bmJn1UybJ8v5fCJlN9YIB+r5O1ChO7hJ3EsXVop8+XNTT/
         l0GxVnJd0ZixXie5RT9HiknU9ZhfO/43ZCNgSuNxAr3IrDsEJt2t3reeuM1SkqhOOkXO
         NCHBIgPe5BtLTpVU4QU2Tl3lxHsBxDcywP52sIqdqEFzInKwv9Bv5ZdDPfJofhb43IpD
         6jkg==
X-Gm-Message-State: AOAM533+sZFoQwJhw4HFTM+eTddzQllrn2NRa73Y1NN9SDFlF0OLKybr
        vE7KxUL2rigdpTOvSyLFThjP0DXOtIGa/1Z7zBBEkg==
X-Google-Smtp-Source: ABdhPJx1gbrC8KfLRm7B88Z6r8LHurBrUrh8s9fWk20QPNqr6pDnATaWEh20Le8JHYfS0fYEB46Ujv1/uF4jUbe2hao=
X-Received: by 2002:a05:6512:3287:: with SMTP id p7mr830016lfe.213.1623789620074;
 Tue, 15 Jun 2021 13:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-9-davidgow@google.com>
In-Reply-To: <20210513193204.816681-9-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:40:09 -0700
Message-ID: <CAFd5g46n10ELbGYf8gR_uUT0kfxDDe4nFoGh-t64zzX747pnUA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] apparmor: test: Remove some casts which are
 no-longer required
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in policy_unpack_test are no longer required.
>
> Remove the unnecessary casts, making the conditions clearer.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
