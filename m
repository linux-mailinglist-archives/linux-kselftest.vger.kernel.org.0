Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF14E7DA1CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjJ0Ud0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJ0UdZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 16:33:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271691AA;
        Fri, 27 Oct 2023 13:33:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9be3b66f254so370225066b.3;
        Fri, 27 Oct 2023 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698438801; x=1699043601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WUzkzWOGzjZzeiD3BpbR+P5JlIo6IVznlquX7VRDdM=;
        b=AS+r+lK+qLTPqgwGvdaTMQMZjWn1IxwyxEr+L0I+q7Hzhd2e2zvnot9jsrdnh2AYzj
         s/thX8ofDebJtAzUkw5i5AIZceeLZgpUc2WnfyOlWIYJce/ysPV66yrrRXUdJR8OALUo
         L+NtrWTMThqsNYAgOp8UNVXCO2FTYdhateY5+GYZaP3zLwQDkwlAQ/r+eUFIt0XvhMMn
         SZdueFTQahfj1jbUDvCkOKA/ceuQrt30UHCIgA/WLnYIfkXRIqJeC2S0AWya6u2c9AT5
         pMzTPicc+F+HfbAgNWiMzscGbgt+qTp2XnPbRmxcKH4FOP9wRSJzRD+mRI2YALnRazTG
         jOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438801; x=1699043601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WUzkzWOGzjZzeiD3BpbR+P5JlIo6IVznlquX7VRDdM=;
        b=laTXjZhISoc2PMtrrMK1q2POopE74Piq1akp6rRqbPTnLNOjNsYaXVI8EKLWW4vMMm
         3v5Qtxz/4p2gOrSZGbq6PAKohiqtuvsT5SDesc3+OEP72H8Rzpk6suTd0F/yengA2y3R
         Q7oZQ15heENs79Gyj6ykWPJrbqqfraUGfPr+kbqYMPsfhKb/EvQhYjsRHyW45oq0WPrR
         w2iLe7KsszhZX47yC29snCyrwKNh71doeTXmpODVfy8twtheEIjuBh4AnTcJ1TUxPYyr
         viRdbKdefBgniHGZlLMFaXO+svw68KXS7bGvWQ53bGGRJgROjONA/ElPEXN+GMEXSpHi
         g7Pw==
X-Gm-Message-State: AOJu0YwFcryWdvQhNZkj8bdxNT1MJNTSHz5xg3JXfW/6C+lW6dpfiXJB
        6nObiNUJxRo0bZn9m4L850Fi2+pti0u0ognU5pQ=
X-Google-Smtp-Source: AGHT+IEQcuU6AspRF/iYz51h6Fxm9XEzXXy07XGXFGMwlBIEYRmJFysFf17xyVwTMzmTAAN8Xqur82lVSFGcWBuXR1c=
X-Received: by 2002:a17:907:7f19:b0:9be:cdca:dae9 with SMTP id
 qf25-20020a1709077f1900b009becdcadae9mr3015726ejc.36.1698438801317; Fri, 27
 Oct 2023 13:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698431765.git.dxu@dxuuu.xyz> <111a64c3e6ccda6b8a2826491715d4e8a645e384.1698431765.git.dxu@dxuuu.xyz>
In-Reply-To: <111a64c3e6ccda6b8a2826491715d4e8a645e384.1698431765.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 27 Oct 2023 13:33:09 -0700
Message-ID: <CAEf4BzbwHZmCJHe8WiV0WeUV1XC+cDB4d4v8YLJh+ZL_k7yB1g@mail.gmail.com>
Subject: Re: [RFC bpf-next 5/6] bpf: selftests: test_tunnel: Disable CO-RE relocations
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     ast@kernel.org, andrii@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, steffen.klassert@secunet.com,
        antony.antony@secunet.com, mykolal@fb.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023 at 11:46=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Switching to vmlinux.h definitions seems to make the verifier very
> unhappy with bitfield accesses. The error is:
>
>     ; md.u.md2.dir =3D direction;
>     33: (69) r1 =3D *(u16 *)(r2 +11)
>     misaligned stack access off (0x0; 0x0)+-64+11 size 2
>
> It looks like disabling CO-RE relocations seem to make the error go
> away.
>

for accessing bitfields libbpf provides
BPF_CORE_READ_BITFIELD_PROBED() and BPF_CORE_READ_BITFIELD() macros

> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools=
/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 3065a716544d..ec7e04e012ae 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -6,6 +6,7 @@
>   * modify it under the terms of version 2 of the GNU General Public
>   * License as published by the Free Software Foundation.
>   */
> +#define BPF_NO_PRESERVE_ACCESS_INDEX
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
> --
> 2.42.0
>
