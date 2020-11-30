Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C432C9075
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Nov 2020 23:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgK3WC3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 17:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3WC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 17:02:29 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6ACC0613D2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 14:01:46 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o19so1516103pgn.10
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 14:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjB582WxI6/wJAaTwVSd/LBGicJY2Z97GbRpBZXLi6E=;
        b=qjhRHIc2Q2c59qrtjaOO0xaBOf0HWT5ja8LeUMZ/pgVJl+M8mSUyqR6vezP+Ndp8k9
         1kODoO5ILq5qEzXRJPhp91+F/VCIuiR+wW/S6j2hBPZ0itZOhyl6oE6aD3r2d3GLjEUn
         nB2okAYbnl571e5kG8Ja1LM6+gcghzkhC7r6P9uTnHxSJAlg8cPiZyKU2NkUoNsTbaDX
         lF3fP23FhXdZ9ahkNphIfwrcH+hXrSNLfyWzmyxxsIenqIbMfbHc+id+n07PLyFQBpFz
         AvaBxUDN/zzYOqohh4+e+IYwofH1zvNmdiq8pjYoxr5vbUJr8G9YP+lVYpj4wVSALQg0
         WebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjB582WxI6/wJAaTwVSd/LBGicJY2Z97GbRpBZXLi6E=;
        b=EhssuEMQmrtxUdbshaOtBjnTkXHWTvaAaeMU5cuc+neG+3VByotaCSsALFWyqSsExG
         4icjA4Ej/ZDvEs7Osxiz/hzNiPOrmxwFqzvozCMSLWWowAydzcPqmiqilFMt5he0ww/Y
         JGyukuntmRs1RiRtuYLHRQ82z9EuRYvHuUNfjEd+vNiKQlJylMtzjdu3gkn7dwH+57Z1
         KGqAazxFbG/IjN/CLnE0CLe+sTvTsXhgqYLbQQWNEyw/bgG1jZ6iWJ8ZYR1mABexGHnH
         xF/kHwBW9hVVVwhO0kztpedWT7LL/E24bfHrp0mUpby1IgABTVaes54xEvMn8S2+R2ct
         Uc6w==
X-Gm-Message-State: AOAM531dMsjoDQbX9+pPq40+yaHIUVV02Lqh0R+4y86NZ6FaEkJKe1Qp
        yuqgGW7qRcLmuQbnS8aCHRSAAlBPlzGCOvenWA9Kng==
X-Google-Smtp-Source: ABdhPJwTqsmR9/VAzC66+aTccouqJa1CkIfZylvRSLe1ExSH5ZMoXzGvmhZcRIkqLfSWSOZfcvRwmRb3vP4giGwr3js=
X-Received: by 2002:a63:f317:: with SMTP id l23mr19508824pgh.384.1606773705383;
 Mon, 30 Nov 2020 14:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20201110072936.1380718-1-davidgow@google.com>
In-Reply-To: <20201110072936.1380718-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Nov 2020 14:01:34 -0800
Message-ID: <CAFd5g47w3eqqZD6iC-HtpbLtYEgmN_oYwD5W37b2h59NEz3kkw@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_tool: Correctly parse diagnostic messages
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 9, 2020 at 11:29 PM David Gow <davidgow@google.com> wrote:
>
> Currently, kunit_tool expects all diagnostic lines in test results to
> contain ": " somewhere, as both the subtest header and the crash report
> do. Fix this to accept any line starting with (minus indent) "# " as
> being a valid diagnostic line.
>
> This matches what the TAP spec[1] and the draft KTAP spec[2] are
> expecting.
>
> [1]: http://testanything.org/tap-specification.html
> [2]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
