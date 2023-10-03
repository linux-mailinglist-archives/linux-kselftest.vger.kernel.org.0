Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573947B741F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJCWfP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 18:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjJCWfO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 18:35:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F30B4
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Oct 2023 15:35:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9adca291f99so259512866b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Oct 2023 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696372508; x=1696977308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It7Xi0oiD+rM83TcJHmcj911Rk0KwZSdh5qD12BcX2k=;
        b=OwTDMkdDhx4AcJ5v2PF48k5IeFyXS0QQTqWYCrdXl4uUB2BsFQeDbs00rJZ/7x8SPk
         5De0FQ1wHsCxVbiUQtze83KK/zqsdBQrcehqHoFD4kRzQoHI9NpJwEOXNVSZ9y9oGe7r
         JoAK+EKmXEiCmv/i/2l8r1bPrAxcIu3nwbd6OZGNI7Sq1xF8QlSq6gwbKZKFxbRTi/LN
         UXUGhFBN6O4yHCDSnbtbFzax9tzdoJY2ze8VaU3xLJXPWSa3fN3KIBW8o+xGL97aUg3i
         CsQ7oRBaghLz78/RsEGhQHfmjDvsf7f82pscZUHSMMoetvlh10bcoBXS0hN3+BXr1KvH
         gPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696372508; x=1696977308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It7Xi0oiD+rM83TcJHmcj911Rk0KwZSdh5qD12BcX2k=;
        b=PUHvUTrJHut0C2FC15j138aQUBxh3hj16SOBDZ0/yg/YbO591lyyy0QJJOV7+KJTJv
         U1jgBPtoW2WIYUoaeeZJopnIlw/9FS4l3tSXRr3SXqObXHYeAeC7S/HPH4FfhS87SXRp
         YZ+JbyFug5vZREg683jSrdqhqqxpDbufXYcMACTPYQHegvFG9TDsby2TfaLAEj4hx5Zx
         vOKf8Wzt9QSp5iQ8R8YpuDbhRV9y0sz8ccM3f327dDr0Bg7NCG8mFaJU8FlZoXrLPSDN
         caJ1PcgyZCxDlxK1hgxrSH5xU2BRPZ4cBTTRqTvE5hZPTkT4e8tNVTUTAEzkf/TlzlLi
         2uWg==
X-Gm-Message-State: AOJu0Yznqda4GdJAwRB+oLHtGW+qDn7Zisq3xWHe/3BOd+eUK9s4c2i7
        V3lXR0+vcJq7roFgNkLACfO1fftbNpZx2/ObxIqJww==
X-Google-Smtp-Source: AGHT+IHBY9DipGSWqL52LM/MHQoLGvY1Km3Touj8d7gcQ7WH3o0AQ6vExMuZKH7wROcqEwJcnojm86N5ig2Ram4x/34=
X-Received: by 2002:a17:907:b1a:b0:9b6:5a86:2926 with SMTP id
 h26-20020a1709070b1a00b009b65a862926mr419738ejl.62.1696372507814; Tue, 03 Oct
 2023 15:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
 <CAFhGd8pEv32zp4RDsj_jeBjzP5hcsf4dP4Knueiw_UM8ZsqcKw@mail.gmail.com> <lhb7u2lg7fv2wx3kzrboftqcdtmbjvbzz7zssfn5mho72hcrvj@i53fzzis7b4q>
In-Reply-To: <lhb7u2lg7fv2wx3kzrboftqcdtmbjvbzz7zssfn5mho72hcrvj@i53fzzis7b4q>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 3 Oct 2023 15:34:54 -0700
Message-ID: <CAFhGd8pTDfgQ+uTTQpMUnyfwbTgf_Hi7hv0ZQP4Vao_fqEvB5A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selftests/hid: fix building for older kernels
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 2, 2023 at 7:48=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> On Sep 26 2023, Justin Stitt wrote:
> > Hey all,
> >
> > Gentle ping on this patch. Looking to get this patch and [1] slated
> > for 6.7 wherein we can start getting cleaner kselftests builds.
> >
> > I do not think I am able to successfully run the hid/bpf selftests due
> > to my kernel version being too low (and an inability to upgrade it as
> > I'm on a corp rolling release). I'd appreciate some insight on how to
> > get the tests running or if someone could actually build+run the tests
> > with this patch applied.
>
> I wanted to apply this series today, but it failed my own CI now with
> the enums being already defined:
> https://gitlab.freedesktop.org/bentiss/hid/-/jobs/49754306
>
> I'll probably squash the following patch in 1/3, would you mind giving
> it a test?

Works for me with this incantation:
$ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 -j128
ARCH=3Dx86_64 -C tools/testing/selftests TARGETS=3Dhid
...
---> BINARY   hid_bpf

Although, the tests expectedly fail.

Looks good to me.

>
> ---
> From 37feca6c0e84705ad65e621643206c287b63bb0a Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <bentiss@kernel.org>
> Date: Mon, 2 Oct 2023 15:37:18 +0200
> Subject: [PATCH] fix selftests/hid: ensure we can compile the tests on ke=
rnels
>  pre-6.3
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  .../selftests/hid/progs/hid_bpf_helpers.h     | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/=
testing/selftests/hid/progs/hid_bpf_helpers.h
> index ab3b18ba48c4..feed5a991e05 100644
> --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> @@ -5,16 +5,44 @@
>  #ifndef __HID_BPF_HELPERS_H
>  #define __HID_BPF_HELPERS_H
>
> -/* "undefine" structs in vmlinux.h, because we "override" them below */
> +/* "undefine" structs and enums in vmlinux.h, because we "override" them=
 below */
>  #define hid_bpf_ctx hid_bpf_ctx___not_used
>  #define hid_report_type hid_report_type___not_used
>  #define hid_class_request hid_class_request___not_used
>  #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> +#define HID_INPUT_REPORT         HID_INPUT_REPORT___not_used
> +#define HID_OUTPUT_REPORT        HID_OUTPUT_REPORT___not_used
> +#define HID_FEATURE_REPORT       HID_FEATURE_REPORT___not_used
> +#define HID_REPORT_TYPES         HID_REPORT_TYPES___not_used
> +#define HID_REQ_GET_REPORT       HID_REQ_GET_REPORT___not_used
> +#define HID_REQ_GET_IDLE         HID_REQ_GET_IDLE___not_used
> +#define HID_REQ_GET_PROTOCOL     HID_REQ_GET_PROTOCOL___not_used
> +#define HID_REQ_SET_REPORT       HID_REQ_SET_REPORT___not_used
> +#define HID_REQ_SET_IDLE         HID_REQ_SET_IDLE___not_used
> +#define HID_REQ_SET_PROTOCOL     HID_REQ_SET_PROTOCOL___not_used
> +#define HID_BPF_FLAG_NONE        HID_BPF_FLAG_NONE___not_used
> +#define HID_BPF_FLAG_INSERT_HEAD HID_BPF_FLAG_INSERT_HEAD=C2=B7___not_us=
ed
> +#define HID_BPF_FLAG_MAX         HID_BPF_FLAG_MAX___not_used
> +
>  #include "vmlinux.h"
> +
>  #undef hid_bpf_ctx
>  #undef hid_report_type
>  #undef hid_class_request
>  #undef hid_bpf_attach_flags
> +#undef HID_INPUT_REPORT
> +#undef HID_OUTPUT_REPORT
> +#undef HID_FEATURE_REPORT
> +#undef HID_REPORT_TYPES
> +#undef HID_REQ_GET_REPORT
> +#undef HID_REQ_GET_IDLE
> +#undef HID_REQ_GET_PROTOCOL
> +#undef HID_REQ_SET_REPORT
> +#undef HID_REQ_SET_IDLE
> +#undef HID_REQ_SET_PROTOCOL
> +#undef HID_BPF_FLAG_NONE
> +#undef HID_BPF_FLAG_INSERT_HEAD
> +#undef HID_BPF_FLAG_MAX
>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> --
> 2.41.0
> ---
>
> Cheers,
> Benjamin
>
> >
> > On Sat, Sep 9, 2023 at 7:22=E2=80=AFAM Justin Stitt <justinstitt@google=
.com> wrote:
> > >
> > > Hi, I am sending this series on behalf of myself and Benjamin Tissoir=
es. There
> > > existed an initial n=3D3 patch series which was later expanded to n=
=3D4 and
> > > is now back to n=3D3 with some fixes added in and rebased against
> > > mainline.
> > >
> > > This patch series aims to ensure that the hid/bpf selftests can be bu=
ilt
> > > without errors.
> > >
> > > Here's Benjamin's initial cover letter for context:
> > > |  These fixes have been triggered by [0]:
> > > |  basically, if you do not recompile the kernel first, and are
> > > |  running on an old kernel, vmlinux.h doesn't have the required
> > > |  symbols and the compilation fails.
> > > |
> > > |  The tests will fail if you run them on that very same machine,
> > > |  of course, but the binary should compile.
> > > |
> > > |  And while I was sorting out why it was failing, I realized I
> > > |  could do a couple of improvements on the Makefile.
> > > |
> > > |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0c=
a1c153dcb2@redhat.com/T/#t
> > >
> > > Changes from v1 -> v2:
> > > - roll Justin's fix into patch 1/3
> > > - add __attribute__((preserve_access_index)) (thanks Eduard)
> > > - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> > > - Link to v1: https://lore.kernel.org/all/20230825-wip-selftests-v1-0=
-c862769020a8@kernel.org/
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > > Link: https://github.com/ClangBuiltLinux/continuous-integration2/issu=
es/61
> > > ---
> > > Benjamin Tissoires (3):
> > >       selftests/hid: ensure we can compile the tests on kernels pre-6=
.3
> > >       selftests/hid: do not manually call headers_install
> > >       selftests/hid: force using our compiled libbpf headers
> > >
> > >  tools/testing/selftests/hid/Makefile               | 10 ++---
> > >  tools/testing/selftests/hid/progs/hid.c            |  3 --
> > >  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++=
++++++++++
> > >  3 files changed, 53 insertions(+), 9 deletions(-)
> > > ---
> > > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > > change-id: 20230908-kselftest-09-08-56d7f4a8d5c4
> > >
> > > Best regards,
> > > --
> > > Justin Stitt <justinstitt@google.com>
> > >
> >
> > [1]: https://lore.kernel.org/all/20230912-kselftest-param_test-c-v1-1-8=
0a6cffc7374@google.com/
> >
> > Thanks
> > Justin

Thanks
Justin
