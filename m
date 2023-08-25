Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADC788EFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 20:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjHYSya (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHYSyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 14:54:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C11BD2;
        Fri, 25 Aug 2023 11:54:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a2185bd83cso157107766b.0;
        Fri, 25 Aug 2023 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989640; x=1693594440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxQMK9RP6ilUyhYYI+Su+gjUxqffi2sMga7zj0RkO+8=;
        b=G0PN2o2H/4RkfQisDlOCOfjlg+Od9j1hPLw4L1DHMocm8PQsH3NskvWP5tAec/p2JK
         VmQxoLccLp6GcypBkKPReC95jTmXFCP+RwQfPFuQW+Exw0skitjCLATUzzsuMlnhrqoS
         WS/I+C03x4Bn06EJq52dn7rEYOHWl2GYOrbHs2nGhuuOw1IONhpVVUUNet1f64pFTMdv
         Sc+ibh/XWdxCEXdXgnvu4XxYs9xmEQkdZAFUdQqNZ19U0hdQ7rrd0Sw0N9UFVwYXHNw/
         IMQUn06hAPAX9YHvc9692N7fRVXz1GaAzpE+rOrdBYn2SFaQON4KeIE8gXNeSNZvducR
         1ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989640; x=1693594440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxQMK9RP6ilUyhYYI+Su+gjUxqffi2sMga7zj0RkO+8=;
        b=XRe/rQAjlrYJAaIdtPI2odT2+BSOOMYmJGOVDn0fRTwqx/2vy+Cj8Yy65Y+D4uHVpd
         hxj11LBokEU0jU6VGWTubhL5I6h+GYdzbLja4Z+pz1jg3BP6G9nZLHsqL6SUsnN8V+4D
         lGtyo8pwanX6naGFLGxb2enwFvV2ZvsttjUozT/HgZh5JGWWNKXbIHphi503v8q7dH+H
         lwry7ACnUN9CulEjWKklTJ29dCEES+KaTE6c3oFgNmSB1ptqK1ddCQmfEZLhjrQ+k3FL
         yaLbtPf6lbTA1x9amm3kFWepAIrmfn10FdI6OnjwHTsmdf8hcMjM3fHL8pdkwM2Y2AAG
         oyuw==
X-Gm-Message-State: AOJu0YxVWmNQoyd5VBll6Ydpt1oDAtJtiu9ehPeqjQkdDIGBJYg/4Sa4
        p1gybldbJmNUbLx+U+cT3RI=
X-Google-Smtp-Source: AGHT+IGMYgJx3Qngg0jobBAnd3GFqEAJm2aB9ZBPeZNi4vv2ZU1Rkq0gIQ93J2FfL57nwSXCYhgWow==
X-Received: by 2002:a17:906:5385:b0:994:4095:3abf with SMTP id g5-20020a170906538500b0099440953abfmr14748340ejo.14.1692989639406;
        Fri, 25 Aug 2023 11:53:59 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jx13-20020a170906ca4d00b00992d122af63sm1239162ejb.89.2023.08.25.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:53:58 -0700 (PDT)
Message-ID: <65800771171dcaff9901dae47de960ec66602f7e.camel@gmail.com>
Subject: Re: [PATCH 4/3] selftests/hid: more fixes to build with older kernel
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Justin Stitt <justinstitt@google.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date:   Fri, 25 Aug 2023 21:53:57 +0300
In-Reply-To: <20230825182316.m2ksjoxe4s7dsapn@google.com>
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
         <20230825182316.m2ksjoxe4s7dsapn@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-08-25 at 18:23 +0000, Justin Stitt wrote:
> On Fri, Aug 25, 2023 at 10:36:30AM +0200, Benjamin Tissoires wrote:
> > These fixes have been triggered by [0]:
> > basically, if you do not recompile the kernel first, and are
> > running on an old kernel, vmlinux.h doesn't have the required
> > symbols and the compilation fails.
> >=20
> > The tests will fail if you run them on that very same machine,
> > of course, but the binary should compile.
> >=20
> > And while I was sorting out why it was failing, I realized I
> > could do a couple of improvements on the Makefile.
> >=20
> > [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c15=
3dcb2@redhat.com/T/#t
> >=20
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> > Benjamin Tissoires (3):
> >       selftests/hid: ensure we can compile the tests on kernels pre-6.3
> >       selftests/hid: do not manually call headers_install
> >       selftests/hid: force using our compiled libbpf headers
> >=20
> >  tools/testing/selftests/hid/Makefile                | 10 ++++------
> >  tools/testing/selftests/hid/progs/hid.c             |  3 ---
> >  tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 20 +++++++++++++=
+++++++
> >  3 files changed, 24 insertions(+), 9 deletions(-)
> > ---
> > base-commit: 1d7546042f8fdc4bc39ab91ec966203e2d64f8bd
> > change-id: 20230825-wip-selftests-9a7502b56542
> >=20
> > Best regards,
> > --
> > Benjamin Tissoires <bentiss@kernel.org>
> >=20
>=20
> Benjamin, thanks for the work here. Your series fixed up _some_ of the
> errors I had while building on my 6.3.11 kernel. I'm proposing a single
> patch that should be applied on top of your series that fully fixes
> _all_ of the build errors I'm experiencing.
>=20
> Can you let me know if it works and potentially formulate a new series
> so that `b4 shazam` applies it cleanly?
>=20
> PATCH BELOW
> ---
> From 5378d70e1b3f7f75656332f9bff65a37122bb288 Mon Sep 17 00:00:00 2001
> From: Justin Stitt <justinstitt@google.com>
> Date: Fri, 25 Aug 2023 18:10:33 +0000
> Subject: [PATCH 4/3] selftests/hid: more fixes to build with older kernel
>=20
> I had to use the clever trick [1] on some other symbols to get my builds
> working.
>=20
> Apply this patch on top of Benjamin's series [2].
>=20
> This is now a n=3D4 patch series which has fixed my builds when running:
> > $ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers
> > $ make LLVM=3D1 -j128 ARCH=3Dx86_64 -C tools/testing/selftests TARGETS=
=3Dhid
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/tools/testing/selftests/bpf/progs/bpf_iter.h#n3
> [2]: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c862769020a8=
@kernel.org/
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  .../selftests/hid/progs/hid_bpf_helpers.h     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/=
testing/selftests/hid/progs/hid_bpf_helpers.h
> index 749097f8f4d9..e2eace2c0029 100644
> --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> @@ -7,12 +7,26 @@
>=20
>  /* "undefine" structs in vmlinux.h, because we "override" them below */
>  #define hid_bpf_ctx hid_bpf_ctx___not_used
> +#define hid_report_type hid_report_type___not_used
> +#define hid_class_request hid_class_request___not_used
> +#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
>  #include "vmlinux.h"
>  #undef hid_bpf_ctx
> +#undef hid_report_type
> +#undef hid_class_request
> +#undef hid_bpf_attach_flags
>=20
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> +#include <linux/const.h>
>=20
> +enum hid_report_type {
> +	HID_INPUT_REPORT		=3D 0,
> +	HID_OUTPUT_REPORT		=3D 1,
> +	HID_FEATURE_REPORT		=3D 2,
> +
> +	HID_REPORT_TYPES,
> +};
>=20
>  struct hid_bpf_ctx {
>  	__u32 index;
> @@ -25,6 +39,21 @@ struct hid_bpf_ctx {
>  	};
>  };

Note, vmlinux.h has the following preamble/postamble:

    #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
    #pragma clang attribute push (__attribute__((preserve_access_index)), a=
pply_to =3D record)
    #endif
    ...
    #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
    #pragma clang attribute pop
    #endif

You might want to use it or add __attribute__((preserve_access_index))
to structure definitions, depending on whether or not you need CO-RE
functionality for these tests.

>=20
> +enum hid_class_request {
> +	HID_REQ_GET_REPORT		=3D 0x01,
> +	HID_REQ_GET_IDLE		=3D 0x02,
> +	HID_REQ_GET_PROTOCOL		=3D 0x03,
> +	HID_REQ_SET_REPORT		=3D 0x09,
> +	HID_REQ_SET_IDLE		=3D 0x0A,
> +	HID_REQ_SET_PROTOCOL		=3D 0x0B,
> +};
> +
> +enum hid_bpf_attach_flags {
> +	HID_BPF_FLAG_NONE =3D 0,
> +	HID_BPF_FLAG_INSERT_HEAD =3D _BITUL(0),
> +	HID_BPF_FLAG_MAX,
> +};
> +
>  /* following are kfuncs exported by HID for HID-BPF */
>  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
>  			      unsigned int offset,
> --
> 2.42.0.rc1.204.g551eb34607-goog
>=20

