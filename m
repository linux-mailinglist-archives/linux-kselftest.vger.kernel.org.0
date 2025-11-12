Return-Path: <linux-kselftest+bounces-45424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B3FC53861
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D398A4A7DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF843339B2F;
	Wed, 12 Nov 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSECrgHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D125F975
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962058; cv=none; b=dpEZYpKx51ZP30QJESi7GtDLv6eePTZt7ztjCDI/mFSTIsZOruzeo8ftzbZ8K7T2OnmUxGPaikl0Qq/FH2tH7MFNUoQHsTOeoZdxLaM3PUR1pHdD4F3fd0bBJCj3MTuc/cxr5NXwyKgqvzGAZI2b3rIoa3tVDuoZesnE+OoK94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962058; c=relaxed/simple;
	bh=UBRooRStreNcjVeeAT3XNznOyrQlM7eqhrh8UAVvTqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iH7zKlvlbf9zQn45VrhsUrZvWKcGVMd5hKYlyJQFUkRLDOrYVY1zfJqDTvxYpNfPe2YCX5gg8sPng4azI72Dqhlr+N4N5Pu3ihWA3w4mYNwzYgIgGEg32ng5gB0Pz2wsxen7RRsf1pmyZA91I0mq0z03GAd80xPr/x+xkt7Xdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSECrgHG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so601872f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962054; x=1763566854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFs3kTHkGBrKQxp1G6sqUrQi97LKHlOLvTeMD+N2qro=;
        b=LSECrgHGZecwuVBvZSUywXc0XjvlUOgCT4KjyIQhE76u67oEPsLgs8ODP69vtz3vNL
         bz8UmzWozfooOaSlind5wmOeBZHE9Oj1aR94362XHDCWocGqh//iVvJQqVuU/eGULA57
         CACRa0rQfL/QoP8ewqapnkPU/x1MvW7I/ktSdKJIxQxubeuqunUJdMyB8/s+MSddv9SL
         0pxyWdvDl36Oob9efEKQ94Z3uvkFXBU/kNaorTATTkpWa74ycqOEHiE9llHCUP6F8320
         mig2CVLqp/FqY5YgAPM3Y5DYVT66QgfrkTmkumZyHgfJ6vsyReI8bwrCU4dy+BqXZxQq
         GbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962054; x=1763566854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFs3kTHkGBrKQxp1G6sqUrQi97LKHlOLvTeMD+N2qro=;
        b=k+DEQ+EAB5cqbtVx9LyWmK8pdrZLGDeCdMGk5va0UfyZ543qp35ojK0Z/IVYO4BwkZ
         0BCbKlOoiP1Vu5CYneZDocNT2syvw2wMjz8n9mw4mRDrVb11RblemC0/L/yAwr6e1oC7
         9pDkpII7JWGixF1aqyv5Wx8WK8blCcRRCtRiW1yqJMxD29lMtejntUtAjgsApl6wr+SN
         AOkOyQw0qoKlxE3BpJgotD6WFbUeg+0z/kPjMhKHRh4WGCV7t8Ch1hwBrD7gBm7oo3Xd
         AbTJgZdVkQizQh5fRtZbN08bjqNl8G+kM/z94JoTMI46J5ZzyQv4ZUReH2f4FZBDO8XZ
         Uu5w==
X-Forwarded-Encrypted: i=1; AJvYcCXFhK3BfAuLPlSU+FhmT14oNpFjX2uJSe+nTARbIJhLaVpow4bDKvNPzbQQfqwFho4omalZZvrHBLV3X7IBqDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmIgyFWprII+R30t9BNthrQfXhZsGDnaResdlVogUW0Ji539u+
	UbrPmLU+J9ZL8ynQlCjeM2D65oj3LlAtNNfQQB+d7+3qSFCBA+xb2WSVX1y+JrGZkPlB37aUMXZ
	gn795xJM3d/JvcuM5LQyjyXbhV9Ee2gA=
X-Gm-Gg: ASbGncvuuKww/hjEZ4gDx0aQE3oQZtjQdqXrFyVIBl0pkn19/x2dxt4oBoaSXx87gE8
	+IhRlgQbXh4BpV8SFOP4q72o9NpEncdGCVsIeiykUV0K1UGQLBslbTsIp2EeC7pd+4BVqtOasdQ
	m7LpjiE/CDtb7LEzaK1sWMZ2mfHu1BOtOWNC46qrA6iO8jzxtusSw+JkMBhmsDtmI3EJlMMe+Zq
	cJWiCVgA7NMhvuq7nBv2GqTqo3wHyDL5zQjfXahHsoogvRSHV0IiYY5e8FE4mOeuBaYX6ObNK9p
	dCrD5BVy9BrYWDCm
X-Google-Smtp-Source: AGHT+IF2MdyR6XNYV6P0kSXew9d429BiXIlJ/9qjxM1PCZKvgnbjMGzwbb2Yef3RI8X+Baihq5Fm7yML2MkKdKxj48k=
X-Received: by 2002:a05:6000:2601:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-42b4bdd6073mr3183964f8f.56.1762962054363; Wed, 12 Nov 2025
 07:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106052628.349117-1-skb99@linux.ibm.com> <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
 <aRNJE5GRUxdlJbZB@linux.ibm.com> <CAADnVQLbMZdMO1zM2OhLsX+w22wQnNQWf60fazctCeEzPUfr0g@mail.gmail.com>
 <aRSi7MADBZBoLLEP@linux.ibm.com>
In-Reply-To: <aRSi7MADBZBoLLEP@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 07:40:43 -0800
X-Gm-Features: AWmQ_bn6DUma_HA2eb4GQSnH2fwI_ZpDCfXLcjZKYxzENKsIfWopPWj3TdOG48A
Message-ID: <CAADnVQL=zjYyVpFSDxGJ4dF5kW+cg+1c+AA1rX3WqxNRMfT4cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:08=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Tue, Nov 11, 2025 at 10:35:39AM -0800, Alexei Starovoitov wrote:
> > On Tue, Nov 11, 2025 at 6:33=E2=80=AFAM Saket Kumar Bhaskar <skb99@linu=
x.ibm.com> wrote:
> > >
> > > On Thu, Nov 06, 2025 at 09:15:39AM -0800, Alexei Starovoitov wrote:
> > > > On Wed, Nov 5, 2025 at 9:26=E2=80=AFPM Saket Kumar Bhaskar <skb99@l=
inux.ibm.com> wrote:
> > > > >
> > > > > Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection an=
d recovery")
> > > > > the updated path on re-entrancy now reports deadlock via
> > > > > -EDEADLK instead of the previous -EBUSY.
> > > > >
> > > > > The selftest is updated to align with expected errno
> > > > > with the kernel=E2=80=99s current behavior.
> > > > >
> > > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c=
 b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > > index 2bc85f4814f4..98d52bb1446f 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > > @@ -40,7 +40,7 @@ static void test_reenter_update(void)
> > > > >         if (!ASSERT_OK(err, "add element"))
> > > > >                 goto out;
> > > > >
> > > > > -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy")=
;
> > > > > +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy=
");
> > > >
> > > > Makes sense, but looks like the test was broken for quite some time=
.
> > > > It fails with
> > > >         /* lookup_elem_raw() may be inlined and find_kernel_btf_id(=
)
> > > > will return -ESRCH */
> > > >         bpf_program__set_autoload(skel->progs.lookup_elem_raw, true=
);
> > > >         err =3D htab_update__load(skel);
> > > >         if (!ASSERT_TRUE(!err || err =3D=3D -ESRCH, "htab_update__l=
oad") || err)
> > > >
> > > > before reaching deadlk check.
> > > > Pls make it more robust.
> > > > __pcpu_freelist_pop() might be better alternative then lookup_elem_=
raw().
> > > >
> > > > pw-bot: cr
> > >
> > > Hi Alexei,
> > >
> > > I tried for __pcpu_freelist_pop, looks like it is not good candidate =
to
> > > attach fentry for, as it is non traceable:
> > >
> > > trace_kprobe: Could not probe notrace function __pcpu_freelist_pop
> > >
> > > I wasn't able to find any other function for this.
> >
> > alloc_htab_elem() is not inlined for me.
> > bpf_obj_free_fields() would be another option.
> Since alloc_htab_elem() is a static function, wouldn=E2=80=99t its
> inlining behavior be compiler-dependent?

of course. Just like lookup_elem_raw(), but alloc is much bigger
and less likely to be inlined.

> static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key=
,
>                                          void *value, u32 key_size, u32 h=
ash,
>                                          bool percpu, bool onallcpus,
>                                          struct htab_elem *old_elem)
>
> When the fentry program is instead attached to bpf_obj_free_fields(),
> the bpf_map_update_elem() call returns 0 rather than -EDEADLK,
> because bpf_obj_free_fields() is not invoked in the bpf_map_update_elem()
> re-entrancy path:

Then make it so. Think what you need to do to make
check_and_free_fields() call it.

