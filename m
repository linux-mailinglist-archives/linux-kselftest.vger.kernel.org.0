Return-Path: <linux-kselftest+bounces-1997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B5814076
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 04:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1757283755
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FB111D;
	Fri, 15 Dec 2023 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkoONAbH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D4D275;
	Fri, 15 Dec 2023 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so2130845e9.3;
        Thu, 14 Dec 2023 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702609870; x=1703214670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWWvM6V+4Sz/C3HWl2XXKBRKAxsD/qZWAz3+i6W9vIE=;
        b=AkoONAbHTLbcb+4vZxG8VUX3bdonca7dWy9n4/R2atJS3PFHA/zTvJ/Dw/T523SDeV
         jJ/f41TmBLdXbbrSzW/owEd0k7CLL/66REPWvdRNKbJcZVH6f/eCy/ssdgG48f8a7ZxR
         JlxyX3Tl9pzahbrqdm5T66aYzrMpn3p3Dp+A0NKfTroF3GeZ7m6QPiTNOQ2EdWG5TTLg
         ddd/L2sPgdt4D6c/f8S8q9z7ioEaA47rX+kwlyIn8S4I8Qh/CosbLSQsxjwz8bJJ/RaF
         9dZ0/tqQn+f7yfjwtsIKp86i7faXhGJfTpqU9ge/SOMF3kfkRHkDwCUWmCAtnXWyjdrz
         ICHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609870; x=1703214670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWWvM6V+4Sz/C3HWl2XXKBRKAxsD/qZWAz3+i6W9vIE=;
        b=tztv/Hf/tifLdduFJ30r8BjXrrK3jJW4ySHKxDwhB2Vdc/SBsAPur3ZG7T0S09+z4/
         RujJ6V6FQLeab/d/CTTN7YcEfc3gzO7OfqbIo6fFzwgt9vxacBfkt/+wGqQZps73UxZl
         XBDwuwCByk3KByNTryqAdpt+tA5HbUjy7VNv7h3hY3gRA6OFVRM7zIwnuanRN8kc1uJh
         BEixsJ/QEV9hkXAD8t4RPmtYYAiW+s1KBxT6S9Ub11SM3dwvESQARuNjX1MS98T/o5z8
         xl3s5vIW4sEtrA1FHEJ3Y9+U2keCoTiz3xrQKUYwY1gbZnWGkl1xDb+3jjoQ21mr10xT
         G3IA==
X-Gm-Message-State: AOJu0YzmUFd2PWOf4W+Q0vBYL/g7JuTqml9snnkDWExN+8terbL5VUPI
	OP+7Q4dpphdyOBfVqlcfX4CXb272OAuXxMBPGyY=
X-Google-Smtp-Source: AGHT+IFKjwdIqetMw4ytAHX7krNYfIP4Nsnc8r/AbTBHBF0CuvK26jl6s0TZRrJbnF+FCJShuLXqT6Zw87RCZEfCfBs=
X-Received: by 2002:adf:e282:0:b0:332:ef1e:bb88 with SMTP id
 v2-20020adfe282000000b00332ef1ebb88mr5991991wri.33.1702609870183; Thu, 14 Dec
 2023 19:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702594357.git.dxu@dxuuu.xyz> <97ada80f3aaaeb16bf97e31a8fc204513b4fb6a9.1702594357.git.dxu@dxuuu.xyz>
 <CAADnVQ+j80DCDHsqJZVmBOohFzOT01Ofdi3TbFEuV2xJ4+A=tA@mail.gmail.com>
In-Reply-To: <CAADnVQ+j80DCDHsqJZVmBOohFzOT01Ofdi3TbFEuV2xJ4+A=tA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 19:10:58 -0800
Message-ID: <CAADnVQLtQ3Qcv3Fp9iNVCXY-_2zTP9hEFqccKLxjgUZNs_uWjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: selftests: Add bpf_assert_if() and
 bpf_assert_with_if() macros
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 14, 2023 at 2:56=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > These macros are a temporary stop-gap until bpf exceptions support
> > unwinding acquired entities. Basically these macros act as if they take
> > a callback which only get executed if the assertion fails.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  .../testing/selftests/bpf/bpf_experimental.h  | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/tes=
ting/selftests/bpf/bpf_experimental.h
> > index 1386baf9ae4a..d63f415bef26 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -263,6 +263,17 @@ extern void bpf_throw(u64 cookie) __ksym;
> >   */
> >  #define bpf_assert(cond) if (!(cond)) bpf_throw(0);
> >
> > +/* Description
> > + *     Assert that a conditional expression is true. If false, runs co=
de in the
> > + *     body before throwing.
> > + * Returns
> > + *     Void.
> > + * Throws
> > + *     An exception with the value zero when the assertion fails.
> > + */
> > +#define bpf_assert_if(cond) \
> > +       for (int ___i =3D 0, ___j =3D !!(cond); !(___j) && !___i; bpf_t=
hrow(0), ___i++)
>
> Kumar,
>
> Is this approach reliable?
> I suspect the compiler can still optimize it.
> I feel it will be annoying to clean up if folks start using it now,
> since there won't be a drop in replacement.
> Every such bpf_assert_if() would need to be manually patched.
>
> If 2nd part of exception is far, how about we add an equivalent
> of __bpf_assert() macroses with conditional ops in asm,
> but with extra 'asm volatile goto' that can be used to construct
> release of resources.
>
> bpf_do_assert_eq(var1, 0) { bpf_spin_unlock(...); }
> bpf_do_assert_lt(var2, 0) { bpf_spin_unlock(...); }

Just realized that we can go the other way instead.

We can get rid of bpf_assert_eq/ne/... and replace with:

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
b/tools/testing/selftests/bpf/bpf_experimental.h
index 1386baf9ae4a..1c500287766d 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -254,6 +254,15 @@ extern void bpf_throw(u64 cookie) __ksym;
                }
                 \
         })

+#define _EQ(LHS, RHS) \
+       ({ int var =3D 1;\
+               asm volatile goto("if %[lhs] =3D=3D %[rhs] goto %l[l_yes]" =
\
+               :: [lhs] "r"(LHS), [rhs] "i"(RHS) :: l_yes);\
+       var =3D 0;\
+l_yes:\
+       var;\
+       })
+
 /* Description
  *     Assert that a conditional expression is true.
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c
b/tools/testing/selftests/bpf/progs/exceptions.c
index 2811ee842b01..1111e852f154 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -203,6 +203,7 @@ __noinline int assert_nz_gfunc(u64 c)
        volatile u64 cookie =3D c;

        bpf_assert(cookie !=3D 0);
+       bpf_assert(_EQ(cookie, 2));
        return 0;
 }

we can probably remove bpf_assert_with() and
all of the bpf_assert_le|ne|qt|eq|_with()

Users can open code everything:
if (!_EQ(foo, bar)) bpf_throw(123);

bpf_assert_if() can work too,
but let's call it bpf_do_assert() and use like:

bpf_do_assert(EQ(time, 0)) {
   // cleanup
}

