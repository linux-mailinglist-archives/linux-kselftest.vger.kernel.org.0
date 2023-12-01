Return-Path: <linux-kselftest+bounces-992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE3801825
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B531281361
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412456760;
	Fri,  1 Dec 2023 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlw4zXl4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9D1730;
	Fri,  1 Dec 2023 15:52:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00ac0101d9so393036166b.0;
        Fri, 01 Dec 2023 15:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701474757; x=1702079557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhIirItyGrM+IUEe5Xj2pk25VhtqsjDKJXNwWgIhPek=;
        b=Tlw4zXl44yxpcxH1XnAQRApMOyAIdD/lOn5823cNUnRS7QnRPH0C7pHmO1GndkXUwr
         sKxIYNpXtidbaNJSDyyhrs2RI4sXlb4Q+Z/MxOKlqhq2IcpEj4uO0BlVlo1At/pPpnzU
         A7bPva6PYM6nsRGcusAiYrIj0gq5l7YwodnWHqhjqdNU8kkGNOeSOvedj0KZKaAL1mPY
         ICznI7KopxKHws2ZFR4JR0z8ueyZptpnIO8QqA9VUCOL6ZHefuDtXgt/59PDdHd4vItO
         FqwPk5wExXbtGhGC723yDoesYLWZfmwkkbVKmx4sJYSsXDnuz4oeG5XiSzHlwFXkzuTZ
         W4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474757; x=1702079557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhIirItyGrM+IUEe5Xj2pk25VhtqsjDKJXNwWgIhPek=;
        b=KY1ug6VtVo40hwpCrEA9RWZh1Gxf0KEnVJeAO8sDKLqbNxUQAefgr5xQNP9EUUR7Wo
         68nwhdliL/dBUuq9V2nld892oIgSUr4QFiwdQ4tBgdlfsclAqwCDPse8bMJQpP6BIi49
         tRIVAI885s/l5GD/RzLDDyDw/DuqE7sGrTtM++/aqS3XR9QXZQ3qH+4Lks4uKYODcqxf
         PNIO0Ile1AZBRvTjeFVET5PlnQhcfIIVa+C5DuHc+uVggyKWXEMIzZKAsc3wTyFoNOXT
         jhCn2nmyz+ePs48d6oOsQCsHTZW50ZeYwPbcQFmmED/mtJK0BmW3LE7sqTqrTknAHZoM
         KuSQ==
X-Gm-Message-State: AOJu0Yx5HSBwhCsot/4jlalrb/Tzx4633nJ76gfNkohuhzynjfTXZQB7
	AUkR3v3CZe3sVuymGcktT/mmRy5r0h2y13ZI7Is=
X-Google-Smtp-Source: AGHT+IGKhf/n9b6eiNuN56GAqHZi8+0m/CaKAM7wWM3NFDU24OsLJQ7aXZq2mfEVT2h+7kzTpquaPRctHJ6Ioxamf+Y=
X-Received: by 2002:a17:906:1091:b0:a02:54fa:4f2f with SMTP id
 u17-20020a170906109100b00a0254fa4f2fmr1573374eju.53.1701474757149; Fri, 01
 Dec 2023 15:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701462010.git.dxu@dxuuu.xyz> <e4d14fb5f07145ff4a367cc01d8dcf6c82581c88.1701462010.git.dxu@dxuuu.xyz>
In-Reply-To: <e4d14fb5f07145ff4a367cc01d8dcf6c82581c88.1701462010.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 15:52:25 -0800
Message-ID: <CAEf4Bzaz+_y=kxBpPmwYsvzaHypmL=ZBfOK12vLom04DRDWyPg@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v3 5/9] libbpf: selftests: Add verifier tests
 for CO-RE bitfield writes
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org, andrii@kernel.org, 
	steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, devel@linux-ipsec.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 12:24=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
> non-trivial bit fiddling is going on, make sure various edge cases (such
> as adjacent bitfields and bitfields at the edge of structs) are
> exercised.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_w=
rite.c
>

LGTM, but I'm not sure why we need all those __failure_unpriv, see
below. Regardless:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 5cfa7a6316b6..67b4948865a3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -6,6 +6,7 @@
>  #include "verifier_and.skel.h"
>  #include "verifier_array_access.skel.h"
>  #include "verifier_basic_stack.skel.h"
> +#include "verifier_bitfield_write.skel.h"
>  #include "verifier_bounds.skel.h"
>  #include "verifier_bounds_deduction.skel.h"
>  #include "verifier_bounds_deduction_non_const.skel.h"
> @@ -115,6 +116,7 @@ static void run_tests_aux(const char *skel_name,
>
>  void test_verifier_and(void)                  { RUN(verifier_and); }
>  void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack=
); }
> +void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_wr=
ite); }
>  void test_verifier_bounds(void)               { RUN(verifier_bounds); }
>  void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_dedu=
ction); }
>  void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_b=
ounds_deduction_non_const); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c =
b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
> new file mode 100644
> index 000000000000..8fe355a19ba6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <stdint.h>
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#include "bpf_misc.h"
> +
> +struct core_reloc_bitfields {
> +       /* unsigned bitfields */
> +       uint8_t         ub1: 1;
> +       uint8_t         ub2: 2;
> +       uint32_t        ub7: 7;
> +       /* signed bitfields */
> +       int8_t          sb4: 4;
> +       int32_t         sb20: 20;
> +       /* non-bitfields */
> +       uint32_t        u32;
> +       int32_t         s32;
> +} __attribute__((preserve_access_index));
> +
> +SEC("tc")
> +__description("single CO-RE bitfield roundtrip")
> +__btf_path("btf__core_reloc_bitfields.bpf.o")
> +__success __failure_unpriv

do we want __failure_unpriv at all? Is this failure related to
*bitfield* logic at all?

> +__retval(3)
> +int single_field_roundtrip(struct __sk_buff *ctx)
> +{
> +       struct core_reloc_bitfields bitfields;
> +
> +       __builtin_memset(&bitfields, 0, sizeof(bitfields));
> +       BPF_CORE_WRITE_BITFIELD(&bitfields, ub2, 3);
> +       return BPF_CORE_READ_BITFIELD(&bitfields, ub2);
> +}
> +

[...]

