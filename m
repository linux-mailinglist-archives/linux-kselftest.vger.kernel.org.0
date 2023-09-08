Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A6799299
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 01:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbjIHXCk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 19:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjIHXCj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 19:02:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168C1FED
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 16:02:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a410316a2so2280115b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694214154; x=1694818954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3gm03RUg+/EX5Gaa+EMR3lyCYLZB5fnaib13/h9Wog=;
        b=6XdUPZhpU35w4EgWevDa1+pO5gRmmhZ1EB+1UJb2N0TceDwumJU1xdAuFCiokkI3ZA
         aGCODk0bsKZSlg/UJjiom2HwSN+CUd5BcNp+JHZ4VjMOTcUpSidfPOUpBz+FRbN77T93
         AA0PEbMvA0ehXqg1ZUyVEYXuFzHMJ519hjm/sIGKJuNYRyP+BW6fJV5NMiCO/jxTtzvp
         m3VpXoa62kYJNBKn/gDyZxyfEjlm0Q2QMWeJZBoqQoQ+Y0cm0IKtV4lfF+hAR7L4lyRw
         tQ+vliHny7ne/Zr9kBHXhGhyHZQRTK1Gv+Xxoeui576q6TUc1RZ8uYmdf/DCJnWNU5j2
         0ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694214154; x=1694818954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3gm03RUg+/EX5Gaa+EMR3lyCYLZB5fnaib13/h9Wog=;
        b=mF+eKLfck8W9lEtghaCm4xZDjpcENjd9x5LlQPsTvsxvk237Kz5+23EX15/VtVLSfa
         ooRsbLuYm0NhHYRI5jGYozei43WG5HqaMRT8mmECYH9Oqog2ZHqr35bLUt5ec/gpNdtI
         QKC9wSTIi+1gFoQe7+pU771GNZoKtD3m/9dTCKeycAlAChl/ulFvDUe1FC36i4k+BcQF
         /s34VZ/KELA1J2fkncPsQBUjjP1NKggV8mo9DkMotcaXcHOMPhVDAD+5X1Aec4/dvlyA
         L2rvH/POQNwasuXmrMI14l8MJbXNLvNF25p5CgOf+iwo9o13l2nYuBpGrh/cCvajOb5w
         JWgg==
X-Gm-Message-State: AOJu0YzEz3gTKeFSW/SwOZmwMlLPIA1TB4TNcxbEXpP6LdHymU09FjyX
        YL9Y9lo74hOAePEViQOUWY5IDQ==
X-Google-Smtp-Source: AGHT+IFS+Nskv6R1HWPO1fnwAzKoZR+l2MTbKrrsdbgDWCjS9RGNTlB1Vy9DYoCX21GSL+ppgh7S+Q==
X-Received: by 2002:a05:6a00:2494:b0:68a:4bef:5f9a with SMTP id c20-20020a056a00249400b0068a4bef5f9amr3856161pfv.0.1694214153767;
        Fri, 08 Sep 2023 16:02:33 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:d39f:a985:2060:eedd])
        by smtp.gmail.com with ESMTPSA id j20-20020a62e914000000b0068b1149ea4dsm1753544pfh.69.2023.09.08.16.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 16:02:33 -0700 (PDT)
Date:   Fri, 8 Sep 2023 16:02:28 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 0/3] selftests/hid: fix building for older kernels
Message-ID: <ZPuoBBGossSy0EiO@google.com>
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 08, 2023 at 10:22:37PM +0000, Justin Stitt wrote:
> Hi, I am sending this series on behalf of myself and Benjamin Tissoires. There
> existed an initial n=3 patch series which was later expanded to n=4 and
> is now back to n=3 with some fixes added in and rebased against
> mainline.
> 
> This patch series aims to ensure that the hid/bpf selftests can be built
> without errors.
> 
> Here's Benjamin's initial cover letter for context:
> |  These fixes have been triggered by [0]:
> |  basically, if you do not recompile the kernel first, and are
> |  running on an old kernel, vmlinux.h doesn't have the required
> |  symbols and the compilation fails.
> |
> |  The tests will fail if you run them on that very same machine,
> |  of course, but the binary should compile.
> |
> |  And while I was sorting out why it was failing, I realized I
> |  could do a couple of improvements on the Makefile.
> |
> |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com/T/#t
> 
> Changes from v1 -> v2:
> - roll Justin's fix into patch 1/3
> - add __attribute__((preserve_access_index)) (thanks Eduard)
> - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> - Link to v1: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c862769020a8@kernel.org/
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61

Thanks to you and Benjamin for sorting all of this out! With this series
applied, I was able to build the hid selftests now without the previous
-Wvisibility diagnostics failing the build.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Build

> ---
> Benjamin Tissoires (3):
>       selftests/hid: ensure we can compile the tests on kernels pre-6.3
>       selftests/hid: do not manually call headers_install
>       selftests/hid: force using our compiled libbpf headers
> 
>  tools/testing/selftests/hid/Makefile               | 10 ++---
>  tools/testing/selftests/hid/progs/hid.c            |  3 --
>  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 9 deletions(-)
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230908-kselftest-09-08-56d7f4a8d5c4
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
