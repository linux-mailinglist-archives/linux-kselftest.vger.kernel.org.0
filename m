Return-Path: <linux-kselftest+bounces-35724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279AAAE747A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3C07AFD4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533731957FC;
	Wed, 25 Jun 2025 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anMMQg//"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159781EB3E;
	Wed, 25 Jun 2025 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816233; cv=none; b=pc8Lda6u4ypU72Umw9DeO5xyPwUX52suncmxSFvxQNZeh7WkIr1ZwSh3WgDk8C//CzSsgyWEKJblzUewWgRCuky7n182ImktRsvTnhjlC4LHuCER9/vVQz8lOGmMxfbuXGG85s/g6cSG8i3jGrC8JLj+TmP6W/QxcLJR4jnRcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816233; c=relaxed/simple;
	bh=bmUWLcvye+1nPz4fQShxjm3W8AY6KuwuhJhKpVqruLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkjnEJXOWx8pl97u+dVGK4VzpfLWb0MDddSow+e6z4NxqAGwDaYcr+ozIX+IlpfXVwcEEI+m8U9S1bXKZb34Z3djvAjuF/OLWZz5TZQj5IKHXwm2wenEEimcTkO4V7nKp23UKFxWbS9iUo/wkUloh9gsB4p6NnArHOHdxI1D1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anMMQg//; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso50451095e9.2;
        Tue, 24 Jun 2025 18:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750816229; x=1751421029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmKV4DiMx7DurtNkNx3vlHszT8EImdBOR7C1+LIzwOc=;
        b=anMMQg//zNheK7Up+SYS1tUeh/wsrC+dnay36lYB25vI3mXffIfRrbqSvKj8NGJlc3
         yw360bXB32B4/GpvtWoYtF3benMXLngtpRMf9lecA4RRhn5aQ4Fh2JjheBE4scpXVnmz
         oibVNMq6fLSLIahj9fHzoW4bgC4sJBD4N5I1vVSVRU2xhE6erqFvivTObHqK5IirrZAP
         jaZ2M3M7iw92CzTWLavbvg9ChTbsrCcQ2MAN3Ilte0YD5Rh4qjk+cSShFKm46weUH+1a
         QaU+QWx6m8H9n6wW5cHibjl7ekyzvVWHk3Vhg/H8U3Dz/fnjIidi4Hqkl7iTOzcWNYIO
         gw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750816229; x=1751421029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmKV4DiMx7DurtNkNx3vlHszT8EImdBOR7C1+LIzwOc=;
        b=gZIWMQTSpQUi3TPqO6BLCZosl4lBE0Q8xWJPywDcKsA8MYXbJln3RN2yqn6Z+7oW6S
         APTzFMgNe0La5CcMBk8D5NWQSr3A+LNBPsbEfSWHCuEuJHnu+Ub9dJM0s74sTfZaIA8E
         iF5YOXun96CPQR8eftAuAr/TbS3d1LDm2oS3pEy38ohCjDHYbswzBJIEFYJCgSDglZ3F
         A6fRdAdKMAkswAszfI05dF43twf0/hCXBVtvo6vxsYfoCZg5RAlK8QVxEgZU4OCNKnIY
         Yb5Q7XNl9gypNaJEEH1OU+4I621np6PBtvECyeetML7RK8wSu5lQNLZm0RZxsnIduBub
         wKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+1keg2//pDlFcjK3oBl/LyWOC/cxnkxY7Rm3SIHxdQmSTZqOIaUe2A1ikL9oMXgdWRKVmQY/V+z7blTFZ@vger.kernel.org, AJvYcCVZuob4WCxU2vfRezTz4zFU5NoqrGVdBw6r4OrVaLfABYHUw/oOAbeP7t5iYfxTrJ3F3aM=@vger.kernel.org, AJvYcCWtflyAtYlxV0RxTIyh6dehQNQDBYH5M8OeUfHiAdQHc4htnayTqIQlzoe2buGivEt2Y5PPiTJItaS05dX5CijW@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5SjGzmsdeDJgv055e9+66giTebommmtiH4T/o72xSduFr9ek
	OGeTimBMRbZEEewgaPkzY2/z5IPNgJkMp476D5i4fZdZS9laI6XP1Phri0jiuIuCuJ5f0jCbVnt
	jIQyWwHmrydXs3LCD2E2+q56yJMo5no4=
X-Gm-Gg: ASbGncs8reTd/9atCVCsIsnZaoooqrrib4x2gdi8TnIj06GwBAENV1+lRrNSHYBubqC
	V+7a03zHOFr2r4MhyfBiex2/eikIVO8d5IfgL+Tb7hijfedcvhEc0JYcz1t44aJF17CeVqLmP5W
	vD19x3Wf6v53tm3Vdrl/zwORujvZnKY1UgRYy1RzPKAttchVVuQSqJl6LvE+H0AnkfCs9iTk8w6
	O2LFlgBpnk=
X-Google-Smtp-Source: AGHT+IHXxkeFcIQ6qo4NCCDqiWhSLyoD2Fiv7nrmmoIMkv2T+Le98qhHLkhH0F3/G3QoKqgoAPX9KtxakULN1fBZHuY=
X-Received: by 2002:a05:600c:3b03:b0:453:a88:d509 with SMTP id
 5b1f17b1804b1-45381aa4972mr10831985e9.10.1750816229085; Tue, 24 Jun 2025
 18:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
 <20250623040359.343235-3-harishankar.vishwanathan@gmail.com> <460a82dd188203e9da23cf0606845b593097faaf.camel@gmail.com>
In-Reply-To: <460a82dd188203e9da23cf0606845b593097faaf.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 18:50:18 -0700
X-Gm-Features: Ac12FXzx7oB21zF2yDcot5XaMWhet-BLNLYGDMmhhW0JjMTK0ZFnDhllw0LJdA8
Message-ID: <CAADnVQL6ivxjMdej3Lp+fww4_0C1bKhq3SFtCj597qRjSRjMCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: Add testcases for BPF_ADD and BPF_SUB
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Matan Shachnai <m.shachnai@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Matan Shachnai <m.shachnai@gmail.com>, 
	Henriette Herzog <henriette.herzog@rub.de>, Luis Gerhorst <luis.gerhorst@fau.de>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-06-23 at 00:03 -0400, Harishankar Vishwanathan wrote:
> > The previous commit improves the precision in scalar(32)_min_max_add,
> > and scalar(32)_min_max_sub. The improvement in precision occurs in case=
s
> > when all outcomes overflow or underflow, respectively.
> >
> > This commit adds selftests that exercise those cases.
> >
> > This commit also adds selftests for cases where the output register
> > state bounds for u(32)_min/u(32)_max are conservatively set to unbounde=
d
> > (when there is partial overflow or underflow).
> >
> > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> > Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
>
> Thank you for adding these tests.  Even with "human readable" numbers
> took me 15-20 minutes to verify the numbers :)
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  .../selftests/bpf/progs/verifier_bounds.c     | 161 ++++++++++++++++++
> >  1 file changed, 161 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tool=
s/testing/selftests/bpf/progs/verifier_bounds.c
> > index 30e16153fdf1..31986f6c609e 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > @@ -1371,4 +1371,165 @@ __naked void mult_sign_ovf(void)
> >         __imm(bpf_skb_store_bytes)
> >       : __clobber_all);
> >  }
> > +
> > +SEC("socket")
> > +__description("64-bit addition, all outcomes overflow")
> > +__success __log_level(2)
> > +__msg("5: (0f) r3 +=3D r3 {{.*}} R3_w=3Dscalar(umin=3D0x40000000000000=
00,umax=3D0xfffffffffffffffe)")
> > +__retval(0)
> > +__naked void add64_full_overflow(void)
> > +{
> > +     asm volatile (
> > +     "r4 =3D 0;"
> > +     "r4 =3D -r4;"
>
> Nit: there is a change in the workings that would make range
>      propagation in negation instruction, a better way to get unbound
>      scalar here is e.g. call to bpf_get_prandom_u32() or read from a
>      constant global map.
>      Depending on order in which patches would be accepted this rework
>      would be either on you or on the other patch-set author.

Fixed them up like below while applying:

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c
b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 31986f6c609e..e52a24e15b34 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1380,15 +1380,15 @@ __retval(0)
 __naked void add64_full_overflow(void)
 {
        asm volatile (
-       "r4 =3D 0;"
-       "r4 =3D -r4;"
+       "call %[bpf_get_prandom_u32];"
+       "r4 =3D r0;"
        "r3 =3D 0xa000000000000000 ll;"
        "r3 |=3D r4;"
        "r3 +=3D r3;"
        "r0 =3D 0;"
        "exit"
        :
-       :
+       : __imm(bpf_get_prandom_u32)
        : __clobber_all);
 }

@@ -1400,15 +1400,15 @@ __retval(0)
 __naked void add64_partial_overflow(void)
 {
        asm volatile (
-       "r4 =3D 0;"
-       "r4 =3D -r4;"
+       "call %[bpf_get_prandom_u32];"
+       "r4 =3D r0;"
        "r3 =3D 2;"
        "r3 |=3D r4;"
        "r3 +=3D r3;"
        "r0 =3D 0;"
        "exit"
        :
-       :
+       : __imm(bpf_get_prandom_u32)
        : __clobber_all);
 }

etc

