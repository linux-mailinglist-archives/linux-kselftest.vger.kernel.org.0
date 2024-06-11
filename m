Return-Path: <linux-kselftest+bounces-11689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ABD9040D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190B11F23959
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F533B1A3;
	Tue, 11 Jun 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3FxDznW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC743AC5;
	Tue, 11 Jun 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121851; cv=none; b=HbRjfuUQeUfiJ1cvpz0+1ONX8dkCbiuZoukcypOBtCYzbQtXQE1va0E5p5Pex5uS65Ui23+s3Fwm8Vf3JM3AFM/LDFG2JRdeHQ8bxDT4vnend7a8OMTPuqBc+0QWybRwwdUq1k7NiAYkK5oB3Wp5jmfwm0Q7az02kRLcdR95Vvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121851; c=relaxed/simple;
	bh=OnTkHejPNw3tngPD/gLNuIdXyEPXReQ7Og4rR03tJUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXjqk6xzCpXFkODmH2sDHY56pUCl/SfbBV7J4NMKGOs65zGL7cfGHL5b7XLUsiSE+iBCdz3QP+cXx1eziTFNLE1o+3O/OZHJJyGCEAPwlEEPS+WdSnb+gvYSPakdUGVYNNFlM6bEwDRTAwXQGNveQuUd1htAOWKjkDcx6GCfLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3FxDznW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f188e09a8so2589575f8f.2;
        Tue, 11 Jun 2024 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718121848; x=1718726648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7OxeEGQvtZSHolpPtCDm/Oc1t2xdqPNsViOQEbQvYo=;
        b=Y3FxDznWQnY/DlmkqbIvfxgWrT7ToMPIPIy79BjpQvNz4bCM587yDrZUpJWCo7OqsA
         zSPUdZAAKEn5yPVcuVRnWe3gflnyDqia0GERna9fOVGGFQeeGx6jbwGoQ+2rvZ0D4XNt
         SS9pIRMpBM/FVsJJ+zE3eR2crSXiRv66iICm9+0YB8jlpQr+E7NcqKvr5XL8czNcBSXQ
         J/B0q0Xot3fhxcyI/W+roE+BJVVVK7jidPpYjYflHb8ptsU9arWK5z0lKzz5BAC2rsoO
         2QrFB0PL74kGnzrxqZBiouk4rY8WFSy5E6MrCvAcC+aKxC60aSIqudxjHP72+CWc9eAn
         GFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121848; x=1718726648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7OxeEGQvtZSHolpPtCDm/Oc1t2xdqPNsViOQEbQvYo=;
        b=iCM/+kmQ/z0ro2vMgxluhX5GukcuZ+wGGPevbS9xbMyx0xzrFm+zUqTs5YMPYulVjY
         MYZcAoc1mJnG9n8y8hNJ+vuxNi8UXsaS6fA6a+7zSzaXgVH3oGMssd4I3a1Y9sfRV2uZ
         OtVr4pv3PCunsGSECmmsDZEjKSTtGTjdJ1EE3ZEylIr00zX4pFGeqraVH2qSbzEj+hgq
         p2GMLz+3n2sVIvpe6hhWZHJTHTnbzWkzTNy5gGd9EJwEJRpalmsC3z+UgfBUREmPsIBn
         6wSPwxFqKMDz1Eo5tQmrFGZxlVvQ3DaKA4bTGLFiJXEMYMazBMMc8R0bz6tMA4qBPEn6
         UvUg==
X-Forwarded-Encrypted: i=1; AJvYcCV7P7vMTpC1fvoEhMlc0iQE6ijGjN5aTcORAM8TivAXlcKkON8uwviNnfi3LiQtUWDPZLv7sy1yqMS9eboDvjL52NbhBjoaBNgvHKxjwJEm8+NUR8HUTEPHOIxFpvCL/7b+xkqsp16Ccqederohv6V1dMg+kIC2fgnilAUkNdmN/EOq
X-Gm-Message-State: AOJu0YwxIw7ogwH9ZUfZgOaJKVGZKlw6ji9CuQXVX1tb3fxlGDMVcYru
	18bJlsI3iEf7SUcx1RPEq8A6oMc/RFNqjU0BlEvi1L2vUTSQWBpPva8lR39CUmG2bO/p0LdRqY4
	0r6nPDWJW4Yy1VBCwOe/FIRkL3XE=
X-Google-Smtp-Source: AGHT+IGgf1ls3cDJ6B8jZSckjsi3R4ehKyK6BuvWyiUq1Q0BRGfbAUe6LlHVpdwqmLIfrHbT/2TI3nOOqIIwwdeGhAY=
X-Received: by 2002:a5d:6608:0:b0:354:f7a4:7862 with SMTP id
 ffacd0b85a97d-35efed2baacmr8566577f8f.19.1718121847806; Tue, 11 Jun 2024
 09:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717881178.git.dxu@dxuuu.xyz> <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
 <Zmb52Qp__CBzbgDh@krava> <chydnuotqnmamlfmgzgnwurj5flaegp2bjebxldqwc2y2ngs5x@3h4blknbqhlw>
In-Reply-To: <chydnuotqnmamlfmgzgnwurj5flaegp2bjebxldqwc2y2ngs5x@3h4blknbqhlw>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jun 2024 09:03:56 -0700
Message-ID: <CAADnVQJdt5K3o6SrnVzzBVf+5BmJ3Wo5TTLvULE7rKJPkKqmbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: selftests: Fix bpf_session_cookie()
 kfunc prototype
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet <quentin@isovalent.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 8:54=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Jiri,
>
> On Mon, Jun 10, 2024 at 03:04:25PM GMT, Jiri Olsa wrote:
> > On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> > > The prototype defined in bpf_kfuncs.h was not in line with how the
> > > actual kfunc was defined. This causes compilation errors when kfunc
> > > prototypes are generated from BTF.
> > >
> > > Fix by aligning with actual kfunc definition.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 =
+-
> > >  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 =
+-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing=
/selftests/bpf/bpf_kfuncs.h
> > > index be91a6919315..3b6675ab4086 100644
> > > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dy=
nptr *data_ptr,
> > >                                   struct bpf_key *trusted_keyring) __=
ksym;
> > >
> > >  extern bool bpf_session_is_return(void) __ksym __weak;
> > > -extern long *bpf_session_cookie(void) __ksym __weak;
> > > +extern __u64 *bpf_session_cookie(void) __ksym __weak;
> >
> > the original intent was to expose long instead of __u64 :-\
> >
> > could we rather change the bpf_session_cookie function to return long?
> > should be just return value type change
>
> Sounds reasonable to me. I don't think the kfunc has made it to a
> release yet, so perhaps if we extract this commit out as a fix to bpf
> tree it can still make it into 6.10. That way we won't have to worry
> about any ABI changes.

kfunc-s can be changed at any time. Keep targeting bpf-next for everything.

