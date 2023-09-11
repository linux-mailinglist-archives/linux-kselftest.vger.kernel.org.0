Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43C79BBB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbjIKVUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbjIKNTc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 09:19:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988AEE;
        Mon, 11 Sep 2023 06:19:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a9cd066db5so563945366b.0;
        Mon, 11 Sep 2023 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438365; x=1695043165; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oYApqvgaLw3ymGGIpb89h6zPjC6eHwEbBV7sAXEoTx4=;
        b=loGRq68sbDK7K+nxJ7ch/PVyC1246xfq++YioxtPOK0QK623lWmq4XvGfVMA0zc7dZ
         N9rYdqPxhOTftehIlGYdg5VzWoQ5Yn6z7PpuYfv+i1AneAyuHITELVt6GXBCOrRHmGj7
         AI2egPnVwy/4M0hWrv2IA6Dw4vPANpGpvFMUS8PSpaXavDaTkcXMcOZrnSIi2MQxG7d0
         kIEc/ckl83J5JV83D7Lm8PYdUXHbXQGWXkOfAh7JncTzR+smytQ+DGozX95j4fx2sEyM
         sJOuOW/lHSVKAtUyGyCQwdo8JXvT1m/IYofv58vYKHW5cXiMe3GS9/DR/RmBdrag5n5R
         cpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438365; x=1695043165;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYApqvgaLw3ymGGIpb89h6zPjC6eHwEbBV7sAXEoTx4=;
        b=suqx47OM+1kVz72Q+zpnI4+zrKPblhEsyj5q8ZigmJ4wL7VT4DFFkIjF3FoyNUtO+K
         CwpLTt37fw/A9S5UfI4IlM9SZ4ApniUU1Nt3sQOBKbj/iUI+SdLSU9JsjI+ZvSUwsGzG
         lr8aLT+sghJZpu2vVZqoErOElBls0w9YyMwoJJ1nSV8pDIu5Aj85HqfSuiCpWQPEMGXl
         BXsXdXe+vsjrCmL4IYlCEgd/USFot24W+C4MdhllG7G8tjNSDYmPKO7JwlzU2Sgm8dhk
         ryoGRnFBGxu77ssW50p+BFE8uK/bpPbK7hybgM5tPSeaQ689fBErjiHEACDkJ6OPkAla
         Kkmw==
X-Gm-Message-State: AOJu0Yx8U/CDwFHwmnv2EBIoKgxSWdn1xFcSMCohTLjPJNY22MUxhsdY
        NDIblvLVD0eVe179zH5Ngq1DMXCYHx0=
X-Google-Smtp-Source: AGHT+IF8gRl9y19pvIHmim64bQq1N0gu6atCEteh1ulReooZA/H5+YH+OytdKZ0jIXcwJe1ywmIUSw==
X-Received: by 2002:a17:906:301b:b0:9a1:c39a:8bfd with SMTP id 27-20020a170906301b00b009a1c39a8bfdmr7755321ejz.57.1694438363659;
        Mon, 11 Sep 2023 06:19:23 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906718300b0098e34446464sm5359448ejk.25.2023.09.11.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:19:23 -0700 (PDT)
Message-ID: <d168d22ba2133d3b38a09ee0e8dbbe0fa97f72d0.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] selftests/hid: ensure we can compile the tests
 on kernels pre-6.3
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Justin Stitt <justinstitt@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
Date:   Mon, 11 Sep 2023 16:19:21 +0300
In-Reply-To: <20230908-kselftest-09-08-v2-1-0def978a4c1b@google.com>
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
         <20230908-kselftest-09-08-v2-1-0def978a4c1b@google.com>
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

On Fri, 2023-09-08 at 22:22 +0000, Justin Stitt wrote:
> From: Benjamin Tissoires <bentiss@kernel.org>
>=20
> For the hid-bpf tests to compile, we need to have the definition of
> struct hid_bpf_ctx. This definition is an internal one from the kernel
> and it is supposed to be defined in the generated vmlinux.h.
>=20
> This vmlinux.h header is generated based on the currently running kernel
> or if the kernel was already compiled in the tree. If you just compile
> the selftests without compiling the kernel beforehand and you are running
> on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_ctx
> definition.
>=20
> Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.h
> to force the definition of that symbol in case we don't find it in the
> BTF and also add __attribute__((preserve_access_index)) to further
> support CO-RE functionality for these tests.
>=20
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  tools/testing/selftests/hid/progs/hid.c            |  3 --
>  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++=
++++++
>  2 files changed, 49 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/self=
tests/hid/progs/hid.c
> index 88c593f753b5..1e558826b809 100644
> --- a/tools/testing/selftests/hid/progs/hid.c
> +++ b/tools/testing/selftests/hid/progs/hid.c
> @@ -1,8 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2022 Red hat */
> -#include "vmlinux.h"
> -#include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
>  #include "hid_bpf_helpers.h"
> =20
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/=
testing/selftests/hid/progs/hid_bpf_helpers.h
> index 4fff31dbe0e7..ab3b18ba48c4 100644
> --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> @@ -5,6 +5,55 @@
>  #ifndef __HID_BPF_HELPERS_H
>  #define __HID_BPF_HELPERS_H
> =20
> +/* "undefine" structs in vmlinux.h, because we "override" them below */

Hi Justin,

What you have here should work, however I still think that the trick
with "___local" suffix I refer to in [1] is a bit less hacky, e.g.:

    enum hid_report_type___local { ... };
    struct hid_bpf_ctx___local {
       __u32 index;
       const struct hid_device *hid; // this one should be in vmlinux.h wit=
h any config
       __u32 allocated_size;
       enum hid_report_type___local report_type;
       union {
           __s32 retval;
           __s32 size;
       };
    } __attribute__((preserve_access_index));
   =20
    enum hid_class_request___local { ... };
    enum hid_bpf_attach_flags___local { ... };
    ...
    extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx___local *ctx,
                                  unsigned int offset,


(sorry for being a bore, won't bring this up anymore).

Thanks,
Eduard

[1] https://lore.kernel.org/bpf/e99b4226bd450fedfebd4eb5c37054f032432b4f.ca=
mel@gmail.com/

> +#define hid_bpf_ctx hid_bpf_ctx___not_used
> +#define hid_report_type hid_report_type___not_used
> +#define hid_class_request hid_class_request___not_used
> +#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> +#include "vmlinux.h"
> +#undef hid_bpf_ctx
> +#undef hid_report_type
> +#undef hid_class_request
> +#undef hid_bpf_attach_flags
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <linux/const.h>
> +
> +enum hid_report_type {
> +	HID_INPUT_REPORT		=3D 0,
> +	HID_OUTPUT_REPORT		=3D 1,
> +	HID_FEATURE_REPORT		=3D 2,
> +
> +	HID_REPORT_TYPES,
> +};
> +
> +struct hid_bpf_ctx {
> +	__u32 index;
> +	const struct hid_device *hid;
> +	__u32 allocated_size;
> +	enum hid_report_type report_type;
> +	union {
> +		__s32 retval;
> +		__s32 size;
> +	};
> +} __attribute__((preserve_access_index));
> +
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
>=20

