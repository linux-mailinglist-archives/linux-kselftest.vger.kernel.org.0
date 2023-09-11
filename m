Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFCB79B054
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjIKVUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbjIKNnV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 09:43:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F5CD7;
        Mon, 11 Sep 2023 06:43:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9aa2468bdb4so165619166b.0;
        Mon, 11 Sep 2023 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694439795; x=1695044595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7B0+k6CDS8ME4sBoGSxHB8zO+rinDpQtys983piRCY=;
        b=SpCvWKltp/bSLktK2QKHUbz02BZJ0zbvr4nrB/ohVnYmo0JhzUJYGfN24lHwJ5aUmh
         ZPJkdrbV+HQcRhmvd6jt+8Ic4iopLXCfKhOOse/qucdmp+lMQqZXNDDjIi/DNfZ4Kgep
         ymths3TyWswXBx6OKC/7TH0uw/Ct+0+nZpF26dPLQiUmWvsBp8HSQO3SUPyzZNHRds8E
         Rm8gxGNvVP3N19Qs7Y0cxRkI4v8yg6SJJjseQZueTEvjTeuJFtvDE6GCJvGucyiOIkJX
         /iqdpaCz2lTVqmGE5NQyuuD9/SxtDK/nYqVyzOL3SOAS/14Smxi31akyZNAvHV4E6J3N
         IkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439795; x=1695044595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7B0+k6CDS8ME4sBoGSxHB8zO+rinDpQtys983piRCY=;
        b=OlTPy1ytoaqNRUEkspOBtze7S5kNxaVGMNzN2pV0dAUnzUsPUvwnxB4EO2y4ukcxQ/
         AvAD3W2wjfu8XBsYZdxGnFl/cx1IlPyAWv4jQ4AaUd1UYcGXdqWKYtl8Qj8U14TFGh2i
         iayO87sYUKYw3FqmZDlYEpXuM3TrrVGddx2lslqCv3oD4jtjJ2jSKuTKX1akZFpcxhJW
         BnU6exy/XHJrf8aDiZh/NiPuP8rSYIFfVO0tjerb1qDxYYyX4AF1sV+1WWjLoI67+qmW
         8bypxFNxPgVjXvils3NLQffl/mijdh977DGGFc1ZKNVtxx8OxE9JjnMD1bMPx0+lTzj6
         BSSA==
X-Gm-Message-State: AOJu0YwoERFteEeS39aqZRwbQJUUmsIKvjL0/zRxIFC0VeE+LNA5xJoh
        62eqsXcjGNbgWbhd/gQ7LSRPTzjktjA=
X-Google-Smtp-Source: AGHT+IHOP9zj9x+a+6NUIy8N++tLNmNEdrLHQjwMCxjsBDviuvW6NIQoRxI+UYUYzygTBmjhggE9nw==
X-Received: by 2002:a17:906:209c:b0:9a1:c659:7c56 with SMTP id 28-20020a170906209c00b009a1c6597c56mr9712657ejq.22.1694439794467;
        Mon, 11 Sep 2023 06:43:14 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ck19-20020a170906c45300b009a1a653770bsm5375835ejb.87.2023.09.11.06.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:43:14 -0700 (PDT)
Message-ID: <d12c34177a8bbdca129ef6e18784f13254c85964.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] selftests/hid: ensure we can compile the tests
 on kernels pre-6.3
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Mon, 11 Sep 2023 16:43:13 +0300
In-Reply-To: <hnmbc2vo6ylihwvxbmtiylw6kseqbyk5iydne4vmshssjhrcac@ijbyzhoeag34>
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
         <20230908-kselftest-09-08-v2-1-0def978a4c1b@google.com>
         <d168d22ba2133d3b38a09ee0e8dbbe0fa97f72d0.camel@gmail.com>
         <hnmbc2vo6ylihwvxbmtiylw6kseqbyk5iydne4vmshssjhrcac@ijbyzhoeag34>
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

On Mon, 2023-09-11 at 15:39 +0200, Benjamin Tissoires wrote:
> On Sep 11 2023, Eduard Zingerman wrote:
> > On Fri, 2023-09-08 at 22:22 +0000, Justin Stitt wrote:
> > > From: Benjamin Tissoires <bentiss@kernel.org>
> > >=20
> > > For the hid-bpf tests to compile, we need to have the definition of
> > > struct hid_bpf_ctx. This definition is an internal one from the kerne=
l
> > > and it is supposed to be defined in the generated vmlinux.h.
> > >=20
> > > This vmlinux.h header is generated based on the currently running ker=
nel
> > > or if the kernel was already compiled in the tree. If you just compil=
e
> > > the selftests without compiling the kernel beforehand and you are run=
ning
> > > on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_c=
tx
> > > definition.
> > >=20
> > > Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.=
h
> > > to force the definition of that symbol in case we don't find it in th=
e
> > > BTF and also add __attribute__((preserve_access_index)) to further
> > > support CO-RE functionality for these tests.
> > >=20
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> > >  tools/testing/selftests/hid/progs/hid.c            |  3 --
> > >  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++=
++++++++++
> > >  2 files changed, 49 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/=
selftests/hid/progs/hid.c
> > > index 88c593f753b5..1e558826b809 100644
> > > --- a/tools/testing/selftests/hid/progs/hid.c
> > > +++ b/tools/testing/selftests/hid/progs/hid.c
> > > @@ -1,8 +1,5 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /* Copyright (c) 2022 Red hat */
> > > -#include "vmlinux.h"
> > > -#include <bpf/bpf_helpers.h>
> > > -#include <bpf/bpf_tracing.h>
> > >  #include "hid_bpf_helpers.h"
> > > =20
> > >  char _license[] SEC("license") =3D "GPL";
> > > diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/to=
ols/testing/selftests/hid/progs/hid_bpf_helpers.h
> > > index 4fff31dbe0e7..ab3b18ba48c4 100644
> > > --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > > +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > > @@ -5,6 +5,55 @@
> > >  #ifndef __HID_BPF_HELPERS_H
> > >  #define __HID_BPF_HELPERS_H
> > > =20
> > > +/* "undefine" structs in vmlinux.h, because we "override" them below=
 */
> >=20
> > Hi Justin,
> >=20
> > What you have here should work, however I still think that the trick
> > with "___local" suffix I refer to in [1] is a bit less hacky, e.g.:
> >=20
> >     enum hid_report_type___local { ... };
> >     struct hid_bpf_ctx___local {
> >        __u32 index;
> >        const struct hid_device *hid; // this one should be in vmlinux.h=
 with any config
> >        __u32 allocated_size;
> >        enum hid_report_type___local report_type;
> >        union {
> >            __s32 retval;
> >            __s32 size;
> >        };
> >     } __attribute__((preserve_access_index));
> >    =20
> >     enum hid_class_request___local { ... };
> >     enum hid_bpf_attach_flags___local { ... };
> >     ...
> >     extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx___local *ctx,
> >                                   unsigned int offset,
> >=20
> >=20
> > (sorry for being a bore, won't bring this up anymore).
>=20
> No need to apologies for trying to make the code better :)
>=20
> I specifically asked Justin to not use this because I intend the
> examples to be here to use the same API in the selftests dir than users
> in the wild. So if your suggestion definitely makes the header code
> much better, it also means that everybody will start using `___local`
> annotations for anything HID-BPF related, which is not what I want.
>=20
> This header file is supposed to be included in the BPF, and IMO it's not
> that important that we have the cleanest code, as long as the users have
> the proper API.
>=20
> Feel free to share your concerns :)

Got it, thank you for explanation :)

>=20
> Cheers,
> Benjamin
>=20
> >=20
> > Thanks,
> > Eduard
> >=20
> > [1] https://lore.kernel.org/bpf/e99b4226bd450fedfebd4eb5c37054f032432b4=
f.camel@gmail.com/
> >=20
> > > +#define hid_bpf_ctx hid_bpf_ctx___not_used
> > > +#define hid_report_type hid_report_type___not_used
> > > +#define hid_class_request hid_class_request___not_used
> > > +#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> > > +#include "vmlinux.h"
> > > +#undef hid_bpf_ctx
> > > +#undef hid_report_type
> > > +#undef hid_class_request
> > > +#undef hid_bpf_attach_flags
> > > +
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include <linux/const.h>
> > > +
> > > +enum hid_report_type {
> > > +	HID_INPUT_REPORT		=3D 0,
> > > +	HID_OUTPUT_REPORT		=3D 1,
> > > +	HID_FEATURE_REPORT		=3D 2,
> > > +
> > > +	HID_REPORT_TYPES,
> > > +};
> > > +
> > > +struct hid_bpf_ctx {
> > > +	__u32 index;
> > > +	const struct hid_device *hid;
> > > +	__u32 allocated_size;
> > > +	enum hid_report_type report_type;
> > > +	union {
> > > +		__s32 retval;
> > > +		__s32 size;
> > > +	};
> > > +} __attribute__((preserve_access_index));
> > > +
> > > +enum hid_class_request {
> > > +	HID_REQ_GET_REPORT		=3D 0x01,
> > > +	HID_REQ_GET_IDLE		=3D 0x02,
> > > +	HID_REQ_GET_PROTOCOL		=3D 0x03,
> > > +	HID_REQ_SET_REPORT		=3D 0x09,
> > > +	HID_REQ_SET_IDLE		=3D 0x0A,
> > > +	HID_REQ_SET_PROTOCOL		=3D 0x0B,
> > > +};
> > > +
> > > +enum hid_bpf_attach_flags {
> > > +	HID_BPF_FLAG_NONE =3D 0,
> > > +	HID_BPF_FLAG_INSERT_HEAD =3D _BITUL(0),
> > > +	HID_BPF_FLAG_MAX,
> > > +};
> > > +
> > >  /* following are kfuncs exported by HID for HID-BPF */
> > >  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> > >  			      unsigned int offset,
> > >=20
> >=20

