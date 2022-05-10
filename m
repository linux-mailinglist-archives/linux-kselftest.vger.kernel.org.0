Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900395213EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbiEJLk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbiEJLkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 07:40:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D63B18995A;
        Tue, 10 May 2022 04:36:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m6so18178837iob.4;
        Tue, 10 May 2022 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EZpR3qbj2OiB8Rs7HNB/ykkYoIogT5opUzlrLNV8YI=;
        b=VoJKpqMfxxTPHvVta4VrHB92nXtrqsdoFMCKO72GGQiiTNlssKn+AXRFv2R0zA/qJl
         ctxf5yvCTzchX0hBX89nV/pbn8AMQXcZyobufzGfOBQSZx6nhMaYwA+R8ZttLsdM8Xl+
         rpydufKYD/6bVeUkxjjhLcjOQR0qGg0c2UaMnbMITS+RV4LBbE8poluGb/ji6ozV4ggX
         2ZOwstsWV1YYyBdttQncwLva3BWyKTcGbQP+6PrGtjhkepSKztq/WSV1uGa3OR1zPmHp
         fWEbAq+8c6Bu4dtUV2ivF9jPrKCiNZQT0HzmRt0DR1EBUHs6Rmtmvgahn+B8mMcFvjaB
         CbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EZpR3qbj2OiB8Rs7HNB/ykkYoIogT5opUzlrLNV8YI=;
        b=xAaRcOLEjXYF8ZIctQZuKRNbZn8skkklilc3NYRN/mlxAeVWmKan3DI33EaAwHnzLp
         xfdWt8V1rO9cWRd6926JmVlmwkA/rm7H8oT+dYF0v/L5xyB+ucbFBsLFTcQhphWKmNqF
         fCLm8vDKWmAw7bqIcqXlM9WhJ1NKtDz7Tc3PB8i2t2t1+pAmjSpKoXLPoDVXaSwRKvDe
         0Y0EUSy47rpAzk+Oyup8Q8yE4oJp2xAdwbM9xeFPyY+01Kw/qQwy7uj/kK8SxOSnXvEz
         6nfcYkgdOoo5YfSvi0qaYOFfjfcSqANtJcjaGRsk0lUf5YQ6wrXwoAuGquN1/r0MO921
         GysQ==
X-Gm-Message-State: AOAM531tgx6cHsW8QamPo789rckrvnVJ/9lCJkC8JO4wGImhriSqwyGR
        S3WeMC5/YmkPtQ+9hgFu2+kR5Vn+TGHi29FKI+s=
X-Google-Smtp-Source: ABdhPJxse48OZESZFthVDv8nUynrMkvM0JCiuRjG7/tN4zNaiseDCEGjt9o4QzkyV4Z20WHbORCpQublLG3V37jZ2Dg=
X-Received: by 2002:a02:8624:0:b0:32b:397d:eeb1 with SMTP id
 e33-20020a028624000000b0032b397deeb1mr9940559jai.264.1652182582955; Tue, 10
 May 2022 04:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <CABVgOSm5S2=QYnHJ+B0JbYtFYKBDRZiOhE5YMKKUKZU56d17HQ@mail.gmail.com>
 <CANiq72=0ft6+QLbdwWD6cLm4FhWfv53GSg6HKEwxQ-q2N-UkOw@mail.gmail.com> <CABVgOSkrvfvA7Ay4GC5wg64S1gibvm5_U5VGBog3sw4_UFo8Cg@mail.gmail.com>
In-Reply-To: <CABVgOSkrvfvA7Ay4GC5wg64S1gibvm5_U5VGBog3sw4_UFo8Cg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 10 May 2022 13:36:11 +0200
Message-ID: <CANiq72mcvKDW6qO=1PzYR_U0tAwVLyCWFZjFVLL81znWDSYq7A@mail.gmail.com>
Subject: Re: [PATCH v6 00/23] Rust support
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Tue, May 10, 2022 at 6:45 AM David Gow <davidgow@google.com> wrote:
>
> I've just sent out a pull request to get this working under UML as
> well, which would simplify running these further:
> https://github.com/Rust-for-Linux/linux/pull/766

Thanks a lot!

> Yeah, these are all fair points: particularly for small doctests.
>
> Maybe having an optional name, which more significant tests could use
> to override the file:line names? That could be useful for a few of the
> larger, more often referenced tests.

Sounds reasonable. I can add support for that.

> Ugh: it's a bit ugly either way. I suspect that file:line is still
> probably better, if only because we need some way of looking up the
> test in the code if it fails. I'd hate for people to be randomly
> hashing bits of just to find out what test is failing.

One redeeming quality is that the assertion prints the line/file
number in the generated file, so it would still be possible to check
where it came from:

    [13:13:43] # rust_kernel_doctest_str_rs_somehash: ASSERTION FAILED
at rust/doctests_kernel_generated.rs:2209
    [13:13:43] Expected 2 > 3 to be true, but is false
    [13:13:43] not ok 43 - rust_kernel_doctest_str_rs_somehash
    [13:13:43] [FAILED] rust_kernel_doctest_str_rs_somehash

Another alternative is to keep the file:line information around
without embedding it into the test name, e.g. in a TAP comment or a
mapping file (which `kunit.py` could read).

But, yeah, before doing hashes or things like that, I would just go
for simplicity and keep things as they are unless some use case really
needs doctests to be stable.

> Oops: I missed that (one of the issues with testing this on a
> different machine which had a rust toolchain). Looks good to me.
>
> Ah: I didn't realise the plan was always to have crate-specific
> suites, and possibly to split things up.
>
> The KTAP output specification does actually support arbitrary nesting
> (though KUnit itself doesn't at the moment), which would potentially
> be an option if (e.g.) providing the complete module nesting made
> sense. I'm not convinced that'd make things easier to read, though.

That is useful to know in case we need it, thanks!

Cheers,
Miguel
