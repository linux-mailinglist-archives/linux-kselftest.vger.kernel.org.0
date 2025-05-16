Return-Path: <linux-kselftest+bounces-33234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEADABA6B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 01:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DFB1BC7253
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 23:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277228033A;
	Fri, 16 May 2025 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiUXrZZB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5D27874B;
	Fri, 16 May 2025 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439364; cv=none; b=k7mBJZKNDgluvA3YnMSPlFC/imeSTy/3HevIKgZEzQXfHQdjad6/eRzqch19terMdZuNFHhFFVN5MHu7BU4RwWR0brnjOU1iSzB8vCZz6a/7rgDtbvKAIsf/UNBDCOhoRI9/J6LjwLjh5jI/QIunyeh1qT/sIgjg8Gb7DQ31r8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439364; c=relaxed/simple;
	bh=JynXQczZCmV7Hl5daVJbPr86DC3r593cY6JyojI2h9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bejp73J3Ow1F22pPpN08eUE2dpK9c8c/yszJn+/nCoANrPoyAjpjIhnPnSrpfVlOgWvKQvarQRgXwTlkFsuibFZPYc2NOPhvyH9zUS3s+2RB+g7/6LfidJ6pgOPgqLmb1Ujfg06eC34LWyOJBYvOJaIpr3DW/D13Nzc9U36j86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiUXrZZB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so2253046f8f.2;
        Fri, 16 May 2025 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747439361; x=1748044161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLNmQk56WXrXrbrs+Rd+UwZYq2EuCmP2+ysJch2Gqcc=;
        b=MiUXrZZBrUd9CJ/R3/+8Euo7FHdltR9apr1qojwyPposhAXDMtluhx6Ma77U3/fQ/9
         WstozBnkwfFxrQnOtNkB0/TEqj+1GGSCJPiqQaCj8Bghob3bWTg+AHqt1p5wQm01bRRA
         wRjV56XG3VayKgCkE+Av88VFUQcLkS45oKu3BmYfnXf0f+BhVeZPgornLkNEiOiwwpnz
         05r1vWQxuRl1qnQlJRM/6vCTCJdzcKyVvAiwbvLxlQHhGkQZXGMf+9MBDGs/8mmABiJG
         SbnMLS9EHdPuScZ4Lc1EXZN7vISEmhV49GwM8t+QMKqvSC2vsPdBP68Xgh2ZApyRJOQI
         Fs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747439361; x=1748044161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLNmQk56WXrXrbrs+Rd+UwZYq2EuCmP2+ysJch2Gqcc=;
        b=o/QNgtJ6cCiFwd5nxwiDZFYghh74azp6qfn6FMB8ARPtuiS7I/G11BdJ9a1oOacVj5
         7zfc/QuaNX9+k7vcJooYi6SK/5FOT7OsafRnhcT9iz7vRrsbqr4JPnguh+wj7qdf7GHc
         SL4nYhPKhNI/dHqvDRjF5I6C3b8pUc0La433k4jqHh+C73IjkrCJT8UvZC/wALjGFG4e
         ouL9JDfx+JN4UblcJDZO/RvaeLxPdvAKZWX6mJQEDXAcUxxbnxXh7BacA1TS6nzTJWu0
         mUKXjg9l6FaakTZNrOsLwP+nob9IsIIig+1GSRtpKexn1dbKlBO/IqmTeh19XXxs9J9Z
         xaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5FeF7kkF2U5AYT6VdEIV8WLV8/pX1e4GJPfLulSzL2uKwJf/KKVpRUAIJhivnd7tVg0cSysnW8KI6BehfwDji@vger.kernel.org, AJvYcCUhZPY9yN5APNO51UZI+BTgxeBx880FxFPx+kPLwC0rdzGH11dg9lWbeTBLmOm/a1+5Qb4tOjey03XBd7KE@vger.kernel.org, AJvYcCVErITNKojpOXoE6sP1wXgeAouQ0pJKDPED3IVs5qoTpF4FxfT9Y2on3+FFcAF1UrOkaDU=@vger.kernel.org, AJvYcCWER5uU43BWVTqAJ6frriEbeu7d2P8SqFmyzSqrxRdZTUv6UgD1Ww2Lfsql+Qyrx1y23x/dh5nozf4zwm9YWxLrFXuPCf0F@vger.kernel.org, AJvYcCX0Ioi/NFBaoTDRy67CfC0VTsJBNvUEChe9DgUwHCMELZX2uQQAdNwjTzOJDiOZXo0rmBaGRFz09qm9@vger.kernel.org, AJvYcCX2xaznOQAGBUWdMR0kADGSVmGnLAcoYsbS2ibo/p9v/q2i3xSO1G1LIGzvwR5qKU/M0NYfTa5Yddo=@vger.kernel.org, AJvYcCX7lGViFscXfQtN794DogQ68CFV8lf0BQA1io5kxIRE2uJvioSduGN68Xw0X+5fL4jY3lurtktzDAUyj9lW@vger.kernel.org, AJvYcCXFqa5AyQLfFxBMbKKlVZLPoNidpivOQrHLz90AgrcrdeO38mF3CXNUtV/ACvaDycnlO6H0d85TTq5pRNnQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2v6MDp0LEt1fbawEwKKbyRzC0g37Lse4hVedzDwagB04GIbDZ
	O8JbYM8Ea3UnV+DV9Nz8hhN2r8Dk6gdzXattPfMhLSe7XR09ujfIn+qrBLjQkU7+n+kEGh1XjiI
	GIjDDlPM1IrKATVcVy0ZtfyqaDThmPyw=
X-Gm-Gg: ASbGncsfaSO6/sS6H4j/xjd7yiJtLU1TFNooiTI+7gCwctt9VxB1Puemqia81mPWg8x
	kaJSPOjF/o3w+7PtJEsj7FMjMxHL9SdYjrys52A7Ti5f6X4UndA5FtSZ+ie0J2dOj6GHCr2Qo88
	S8pNaplmlOftmdIi99LrwRqk9HBnihoIWwcUgNiT0uGnLQKYG0JeNL8k445Ip1G85qOGqamHYo
X-Google-Smtp-Source: AGHT+IEt13ebOwzpc+kY0WsGrWXwVoXKnKPvRfcOK4btMC7AsUlFZwn4kwFfwxO5xffregucUV2pzpgY8z4kdU24ZPU=
X-Received: by 2002:adf:f50b:0:b0:3a3:5c97:d756 with SMTP id
 ffacd0b85a97d-3a35c97d8aamr4266342f8f.17.1747439361049; Fri, 16 May 2025
 16:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
 <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
 <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com> <CAHC9VhTeFBhdagvw4cT3EvA72EYCfAn6ToptpE9PWipG9YLrFw@mail.gmail.com>
In-Reply-To: <CAHC9VhTeFBhdagvw4cT3EvA72EYCfAn6ToptpE9PWipG9YLrFw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 May 2025 16:49:09 -0700
X-Gm-Features: AX0GCFuvvvJ18JnaOTj0Zx7VVAejABXpQG7xGivhE2V41LonoDOtxmhIAAR39TA
Message-ID: <CAADnVQJ4GDKvLSWuAMdwajA0V2DEw5m-O228QknW8Eo9jxhyig@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	code@tyhicks.com, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Morris <jmorris@namei.org>, Jan Stancek <jstancek@redhat.com>, 
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas@fjasle.eu>, nkapron@google.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Matteo Croce <teknoraver@meta.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, kysrinivasan@gmail.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 12:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, May 14, 2025 at 2:48=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Wed, May 14, 2025 at 5:06=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Sat, May 10, 2025 at 10:01=E2=80=AFPM KP Singh <kpsingh@kernel.org=
> wrote:
> > > >
> > >
> > > ...
> > >
> > > > The signature check in the verifier (during BPF_PROG_LOAD):
> > > >
> > > >     verify_pkcs7_signature(prog->aux->sha, sizeof(prog->aux->sha),
> > > > sig_from_bpf_attr, =E2=80=A6);
> > >
> > > I think we still need to clarify the authorization aspect of your
> > > proposed design.
> > >
> > > Working under the assumption that the core BPF kernel code doesn't
> > > want to enforce any restrictions, or at least as few as possible ...
> >
> > The assumption is not true, I should have clarified it in the original
> > design. With the UAPI / bpf_attr the bpf syscall is simply denied if
> > the signature does not verify, so we don't need any LSM logic for
> > this. There is really no point in continuing as signature verification
> > is a part of the API contract when the user passes the sig, keyring in
> > the bpf syscall.
>
> I think we need some clarification on a few of these details, it would
> be good if you could answer the questions below about the
> authorization aspects of your design?
>
> * Is the signature validation code in the BPF verifier *always* going
> to be enforced when a signature is passed in from userspace?  In other
> words, in your design is there going to be either a kernel build time
> or runtime configuration knob that could selectively enable (or
> disable) signature verification in the BPF verifier?

If there is a signature in union bpf_attr and it's incorrect
the prog_load command will be rejected.
No point in adding a knob to control that.

> * In the case where the signature validation code in the BPF verifier
> is active, what happens when a signature is *not* passed in from
> userspace?  Will the BPF verifier allow the program load to take
> place?  Will the load operation be blocked?  Will the load operation
> be subject to a more granular policy, and if so, how do you plan to
> incorporate that policy decision into the BPF program load path?

If there is no signature the existing loading semantics will remain intact.
We can discuss whether to add a sysctl or cgroup knob to disallow
loading when signature is not present, but it probably should be
a job of trivial LSM:
if (prog_attr doesn't have signature &&
   (task =3D=3D .. || task is under certain cgroup || whatever))
  disallow.


Note that the prog verification itself is independent of the signature.
If prog fails to pass safety checks it will still be rejected
even if signature is ok.
We're not going to do a verifier bypass.

