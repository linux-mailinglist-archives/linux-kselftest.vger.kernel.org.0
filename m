Return-Path: <linux-kselftest+bounces-6520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E4A887BAF
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 05:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1A9282404
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 04:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E52134BF;
	Sun, 24 Mar 2024 04:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlHQLy62"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B6944F;
	Sun, 24 Mar 2024 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711256244; cv=none; b=FI76+NWEstIy/shKj0IEAkpX71RNZKaEJzlG86Z4BZtCSzuz4eHaTbBGQ1nGUIvlNP8UztjntvEuUMYVzEZjxvnd1U0zVaGmp77WRYzy8sBR1i1ZcraVaOlGNNCXV16byVSKwN8avVOnpoyliXkg/FShjL0gH7CxtgLIqFdU1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711256244; c=relaxed/simple;
	bh=54JqEb7Li92nCfhY0hrpirxVcYlKUDnmd8ltYtGKpiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNl2vmPzNtwKRwUyU8EyGNB/v6HjXTsPGj5Z0TYQbw/WdS/EKTzH8WYIl9HWRcjzN6OmeCVb/4HreA3y+f0511TFiLifPReygy9LDzCNm2fqaQNleT7ujFxCPOMoU8QLSRqw8Mki1+GBS5frdQnh+dcjF57C81s4zwa4cIJ4Vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlHQLy62; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-515a86daf09so320312e87.3;
        Sat, 23 Mar 2024 21:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711256240; x=1711861040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cSVtDsakOoQbVnJ/uzznqFTeQv6TFLIAtmyLgV/ntD4=;
        b=ZlHQLy62ypFLeKb4dRbk+ZM8eLPbNFNr8n91qyhf+Nw9Io7IZQDo5fk+fNZTOPam6u
         4ZM7X9hz2ULGcHHTB2UNlup+IOP5v2iwEm9+sZ8jGS3jDlz/pARFjIQZtkZl9VwvU3AH
         0t3Qe9M/wvOWIgEqMKV8gmRN4/KSTLOSgxLRXzc5laWtHYtGHDK6AAMfOzwQssRhZ7wP
         ZNpJ3nrmDyFTh1H+20X5OqJswYD/30JLCh8iyeCsyV/hg1NkjN77antqJzBNIBaLuAux
         3IaQJXyJPpy0Z7FPm+Tcni2LvTsOEbfwBQNyvUFgiDO/lP9BzvvW8XCufG3XY63gvQGs
         uyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711256240; x=1711861040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSVtDsakOoQbVnJ/uzznqFTeQv6TFLIAtmyLgV/ntD4=;
        b=qGngk8il6RJxht6WWGKDo2VPehVqkKPQsyMPBbWZ45EmxTwitCwyj+7kbRY3MMAJo0
         sAPybjSKYEEBuFH1RNseG3/o9F5SSh5ha/Ww69FP0kzXIAUGyRFwSJG3PRdfR6Lv9xxZ
         daPYd/RGdYMsbvgdVvk0QgA2wj7YFXi+KjMMmYPwGhcwuJAvTJyzAX8JgD11WI5CxQK4
         WtxrdyLifBSYp16CgU5b1i5K1lI/PDtyAPn+8SqagcnSqYi1TJlSh3MwD9MK5ZIKqz9i
         VdHD6D3z9kp5biRoU5Xa3F5IQ6WDJLzjT6C6QrIGDEPukY8lyR/yuF9dlIA5jh+mootX
         bgqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKtECEtONq0pre66AJufQyCVOdMTR6gRcusaRs4aRqBOXhStvv2oluGpZKGuLl0wzgMEKk79+/B+w+3JogL5+kxEYAgEVwOR12oZxz0tAKUtYWULy4tP8ooHuaWuxsXXiZjlVHzXTe/L/9HgCGZ+J+Tk53j1IhD8HLKJNhdGAUxVj3
X-Gm-Message-State: AOJu0YxZC8ZGLRHczcem48mDZ9YJGRbBwFCjKTmNKU0FUmTC0C5BfZb8
	lEo7HjTiRWpQuMfEUnfLY3LNGjP6b0c0WQ+Wq7mVBxCCq22tTs8584yRWjwgx9E/Xh9A2f8tr4F
	SoygGSjf8kgNs/lKdtVoUhCXgs5OE5oIrfz7Thg==
X-Google-Smtp-Source: AGHT+IF+RDDAaBdVpmc9wH8zp9rnUKJLsXWSLSPh8Znqg1m5Kn2gwlkPqE+cpMUg+6l0LL+2Qfy3+2/fI6H6xkqItvw=
X-Received: by 2002:ac2:4649:0:b0:513:cf5e:f2ad with SMTP id
 s9-20020ac24649000000b00513cf5ef2admr2612652lfo.60.1711256239930; Sat, 23 Mar
 2024 21:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org> <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
 <CAADnVQL_mQgN8uKsNFR0FBtWoaweCkzXw03EvbnQ-iFVWvXxuw@mail.gmail.com>
 <CAP01T753_FjFdj1CbCX5Bh1itYUWf8DUh41F7R_7Fdb=2SEL8g@mail.gmail.com> <CAADnVQ+5mSEW-LJwS30hED1cJeHOhqfCTKdBzYCcRd8EiVNvtA@mail.gmail.com>
In-Reply-To: <CAADnVQ+5mSEW-LJwS30hED1cJeHOhqfCTKdBzYCcRd8EiVNvtA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 24 Mar 2024 05:56:43 +0100
Message-ID: <CAP01T757ddmmFR+Cnj70DrTLFcEu+9uAcbscrO-uOmSVGB8eJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004d8eb5061460e45f"

--0000000000004d8eb5061460e45f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Mar 2024 at 05:38, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 23, 2024 at 9:01=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sun, 24 Mar 2024 at 04:53, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 22, 2024 at 9:31=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Fri, 22 Mar 2024 at 15:57, Benjamin Tissoires <bentiss@kernel.or=
g> wrote:
> > > > >
> > > > > We need to extend the bpf_timer API, but the way forward relies o=
n kfuncs.
> > > > > So make bpf_timer known for kfuncs from the verifier PoV
> > > > >
> > > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > > >
> > > > > ---
> > > > >
> > > > > changes in v5:
> > > > > - also check for the reg offset
> > > > >
> > > > > changes in v4:
> > > > > - enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE
> > > > >
> > > > > new in v3 (split from v2 02/10)
> > > > > ---
> > > > >  kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
> > > > >  1 file changed, 23 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 63749ad5ac6b..24a604e26ec7 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -10826,6 +10826,7 @@ enum {
> > > > >         KF_ARG_LIST_NODE_ID,
> > > > >         KF_ARG_RB_ROOT_ID,
> > > > >         KF_ARG_RB_NODE_ID,
> > > > > +       KF_ARG_TIMER_ID,
> > > > >  };
> > > > >
> > > > >  BTF_ID_LIST(kf_arg_btf_ids)
> > > > > @@ -10834,6 +10835,7 @@ BTF_ID(struct, bpf_list_head)
> > > > >  BTF_ID(struct, bpf_list_node)
> > > > >  BTF_ID(struct, bpf_rb_root)
> > > > >  BTF_ID(struct, bpf_rb_node)
> > > > > +BTF_ID(struct, bpf_timer_kern)
> > > > >
> > > > >  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
> > > > >                                     const struct btf_param *arg, =
int type)
> > > > > @@ -10877,6 +10879,12 @@ static bool is_kfunc_arg_rbtree_node(con=
st struct btf *btf, const struct btf_par
> > > > >         return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_I=
D);
> > > > >  }
> > > > >
> > > > > +static bool is_kfunc_arg_timer(const struct btf *btf, const stru=
ct btf_param *arg)
> > > > > +{
> > > > > +       bool ret =3D __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIM=
ER_ID);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > >  static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, =
const struct btf *btf,
> > > > >                                   const struct btf_param *arg)
> > > > >  {
> > > > > @@ -10946,6 +10954,7 @@ enum kfunc_ptr_arg_type {
> > > > >         KF_ARG_PTR_TO_NULL,
> > > > >         KF_ARG_PTR_TO_CONST_STR,
> > > > >         KF_ARG_PTR_TO_MAP,
> > > > > +       KF_ARG_PTR_TO_TIMER,
> > > > >  };
> > > > >
> > > > >  enum special_kfunc_type {
> > > > > @@ -11102,6 +11111,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifie=
r_env *env,
> > > > >         if (is_kfunc_arg_map(meta->btf, &args[argno]))
> > > > >                 return KF_ARG_PTR_TO_MAP;
> > > > >
> > > > > +       if (is_kfunc_arg_timer(meta->btf, &args[argno]))
> > > > > +               return KF_ARG_PTR_TO_TIMER;
> > > > > +
> > > > >         if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf=
_ids[base_type(reg->type)])) {
> > > > >                 if (!btf_type_is_struct(ref_t)) {
> > > > >                         verbose(env, "kernel function %s args#%d =
pointer type %s %s is not supported\n",
> > > > > @@ -11735,6 +11747,7 @@ static int check_kfunc_args(struct bpf_ve=
rifier_env *env, struct bpf_kfunc_call_
> > > > >                 case KF_ARG_PTR_TO_CALLBACK:
> > > > >                 case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> > > > >                 case KF_ARG_PTR_TO_CONST_STR:
> > > > > +               case KF_ARG_PTR_TO_TIMER:
> > > > >                         /* Trusted by default */
> > > > >                         break;
> > > > >                 default:
> > > > > @@ -12021,6 +12034,16 @@ static int check_kfunc_args(struct bpf_v=
erifier_env *env, struct bpf_kfunc_call_
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > >                         break;
> > > > > +               case KF_ARG_PTR_TO_TIMER:
> > > > > +                       if (reg->type !=3D PTR_TO_MAP_VALUE) {
> > > > > +                               verbose(env, "arg#%d doesn't poin=
t to a map value\n", i);
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > > > +                       if (reg->off) {
> > > > > +                               verbose(env, "arg#%d offset can n=
ot be greater than 0\n", i);
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > >
> > > > This won't be correct. You don't really check whether the timer exi=
sts
> > > > at reg->off (and if you did, this would still restrict it to 0 offs=
et,
> > > > and not check the variable offset which would be non-zero). What I
> > > > would suggest is calling process_timer_func (see how dynptr calls t=
he
> > > > same underlying process_dynptr_func to enforce type invariants). Th=
is
> > > > would allow sharing the same checks and avoid bugs from creeping in=
.
> > > > It does all checks wrt constant/variable offset and looking up the
> > > > timer field offset and matching it against the one in the pointer.
> > >
> > > Observation is correct. The patch is buggy,
> > > but the suggestion to follow process_dynptr_func() will lead
> > > to unnecessary complexity.
> > > dynptr-s are on stack with plenty of extra checks.
> >
> > The suggestion was to call process_timer_func, not process_dynptr_func.
> >
> > > In this case bpf_timer is in map_value.
> > > Much simpler is to follow KF_ARG_PTR_TO_MAP approach.
> >
> > What I meant by the example was that dynptr handling does the same
> > thing for kfuncs and helpers (using the same function), so timer
> > arguments should do the same (i.e. use process_timer_func), which will
> > do all checks for constant offset (ensuring var_off is tnum_is_const)
> > and match it against btf_record->timer_off.
>
> I don't follow. Please elaborate with a patch.
> The var_off and off is a part of the bug, but it's not the biggest part o=
f it.

Not compile tested.

--0000000000004d8eb5061460e45f
Content-Type: application/octet-stream; name="timer.patch"
Content-Disposition: attachment; filename="timer.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lu51q3tf0>
X-Attachment-Id: f_lu51q3tf0

RnJvbSA4ZjhjNzlkMmRmMjk5ZWZjNzZiMmJmYjU5MzI2MDNjYTNlNzM4ZThhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWls
LmNvbT4KRGF0ZTogU3VuLCAyNCBNYXIgMjAyNCAwNDo0OToyOSArMDAwMApTdWJqZWN0OiBbUEFU
Q0hdIGJwZjogQWRkIHN1cHBvcnQgZm9yIEtGX0FSR19QVFJfVE9fVElNRVIKCk5vdCBjb21waWxl
IHRlc3RlZC4KCkludHJvZHVjZSBzdXBwb3J0IGZvciBLRl9BUkdfUFRSX1RPX1RJTUVSLiBUaGUg
a2Z1bmNzIHdpbGwgdXNlIGJwZl90aW1lcgphcyBhcmd1bWVudCBhbmQgdGhhdCB3aWxsIGJlIHJl
Y29nbml6ZWQgYXMgdGltZXIgYXJndW1lbnQgYnkgdmVyaWZpZXIuCmJwZl90aW1lcl9rZXJuIGNh
c3RpbmcgY2FuIGhhcHBlbiBpbnNpZGUga2Z1bmMsIGJ1dCB1c2luZyBicGZfdGltZXIgaW4KYXJn
dW1lbnQgbWFrZXMgbGlmZSBlYXNpZXIgZm9yIHVzZXJzIHdobyB3b3JrIHdpdGggbm9uLWtlcm4g
dHlwZSBpbiBCUEYKcHJvZ3MuCgpGaXggdXAgcHJvY2Vzc190aW1lcl9mdW5jJ3MgbWV0YSBhcmd1
bWVudCB1c2FnZSAoaWdub3JlIGlmIE5VTEwpIHNvIHRoYXQKd2UgY2FuIHNoYXJlIHRoZSBzYW1l
IGNoZWNrcyBmb3IgaGVscGVycyBhbmQga2Z1bmNzLiBtZXRhIGFyZ3VtZW50IGlzCm9ubHkgbmVl
ZGVkIHRvIGVuc3VyZSBicGZfdGltZXJfaW5pdCdzIHRpbWVyIGFuZCBtYXAgYXJndW1lbnRzIGFy
ZQpjb21pbmcgZnJvbSB0aGUgc2FtZSBtYXAgKG1hcF91aWQgbG9naWMgaXMgbmVjZXNzYXJ5IGZv
ciBjb3JyZWN0CmlubmVyLW1hcCBoYW5kbGluZykuCgpObyBzdWNoIGNvbmNlcm5zIHdpbGwgYmUg
bmVjZXNzYXJ5IGZvciBrZnVuY3MgYXMgdGltZXIgaW5pdGlhbGl6YXRpb24KaGFwcGVucyB1c2lu
ZyBoZWxwZXJzLCBoZW5jZSBwYXNzIE5VTEwgdG8gcHJvY2Vzc190aW1lcl9mdW5jIGZyb20ga2Z1
bmMKYXJndW1lbnQgaGFuZGxpbmcgY29kZSB0byBpZ25vcmUgaXQuCgpTaWduZWQtb2ZmLWJ5OiBL
dW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWlsLmNvbT4KLS0tCiBrZXJuZWwvYnBm
L3ZlcmlmaWVyLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBi
L2tlcm5lbC9icGYvdmVyaWZpZXIuYwppbmRleCBjYTZjYWNmN2I0MmYuLmQ4OWJhMTZiNTZlNCAx
MDA2NDQKLS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZp
ZXIuYwpAQCAtNzU2OCwxMiArNzU2OCwxNiBAQCBzdGF0aWMgaW50IHByb2Nlc3NfdGltZXJfZnVu
YyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgcmVnbm8sCiAJCQl2YWwgKyByZWct
Pm9mZiwgbWFwLT5yZWNvcmQtPnRpbWVyX29mZik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KKwkv
KiBtZXRhIGlzIG9ubHkgbmVlZGVkIGZvciBicGZfdGltZXJfaW5pdCB0byBtYXRjaCB0aW1lciBh
bmQgbWFwICovCisJaWYgKCFtZXRhKQorCQlnb3RvIG91dDsKIAlpZiAobWV0YS0+bWFwX3B0cikg
ewogCQl2ZXJib3NlKGVudiwgInZlcmlmaWVyIGJ1Zy4gVHdvIG1hcCBwb2ludGVycyBpbiBhIHRp
bWVyIGhlbHBlclxuIik7CiAJCXJldHVybiAtRUZBVUxUOwogCX0KIAltZXRhLT5tYXBfdWlkID0g
cmVnLT5tYXBfdWlkOwogCW1ldGEtPm1hcF9wdHIgPSBtYXA7CitvdXQ6CiAJcmV0dXJuIDA7CiB9
CiAKQEAgLTEwODI2LDYgKzEwODMwLDcgQEAgZW51bSB7CiAJS0ZfQVJHX0xJU1RfTk9ERV9JRCwK
IAlLRl9BUkdfUkJfUk9PVF9JRCwKIAlLRl9BUkdfUkJfTk9ERV9JRCwKKwlLRl9BUkdfVElNRVJf
SUQsCiB9OwogCiBCVEZfSURfTElTVChrZl9hcmdfYnRmX2lkcykKQEAgLTEwODM0LDYgKzEwODM5
LDcgQEAgQlRGX0lEKHN0cnVjdCwgYnBmX2xpc3RfaGVhZCkKIEJURl9JRChzdHJ1Y3QsIGJwZl9s
aXN0X25vZGUpCiBCVEZfSUQoc3RydWN0LCBicGZfcmJfcm9vdCkKIEJURl9JRChzdHJ1Y3QsIGJw
Zl9yYl9ub2RlKQorQlRGX0lEKHN0cnVjdCwgYnBmX3RpbWVyKQogCiBzdGF0aWMgYm9vbCBfX2lz
X2tmdW5jX3B0cl9hcmdfdHlwZShjb25zdCBzdHJ1Y3QgYnRmICpidGYsCiAJCQkJICAgIGNvbnN0
IHN0cnVjdCBidGZfcGFyYW0gKmFyZywgaW50IHR5cGUpCkBAIC0xMDg3Nyw2ICsxMDg4MywxMSBA
QCBzdGF0aWMgYm9vbCBpc19rZnVuY19hcmdfcmJ0cmVlX25vZGUoY29uc3Qgc3RydWN0IGJ0ZiAq
YnRmLCBjb25zdCBzdHJ1Y3QgYnRmX3BhcgogCXJldHVybiBfX2lzX2tmdW5jX3B0cl9hcmdfdHlw
ZShidGYsIGFyZywgS0ZfQVJHX1JCX05PREVfSUQpOwogfQogCitzdGF0aWMgYm9vbCBpc19rZnVu
Y19hcmdfdGltZXIoY29uc3Qgc3RydWN0IGJ0ZiAqYnRmLCBjb25zdCBzdHJ1Y3QgYnRmX3BhcmFt
ICphcmcpCit7CisJcmV0dXJuIF9faXNfa2Z1bmNfcHRyX2FyZ190eXBlKGJ0ZiwgYXJnLCBLRl9B
UkdfVElNRVJfSUQpOworfQorCiBzdGF0aWMgYm9vbCBpc19rZnVuY19hcmdfY2FsbGJhY2soc3Ry
dWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgY29uc3Qgc3RydWN0IGJ0ZiAqYnRmLAogCQkJCSAg
Y29uc3Qgc3RydWN0IGJ0Zl9wYXJhbSAqYXJnKQogewpAQCAtMTA5NDYsNiArMTA5NTcsNyBAQCBl
bnVtIGtmdW5jX3B0cl9hcmdfdHlwZSB7CiAJS0ZfQVJHX1BUUl9UT19OVUxMLAogCUtGX0FSR19Q
VFJfVE9fQ09OU1RfU1RSLAogCUtGX0FSR19QVFJfVE9fTUFQLAorCUtGX0FSR19QVFJfVE9fVElN
RVIsCiB9OwogCiBlbnVtIHNwZWNpYWxfa2Z1bmNfdHlwZSB7CkBAIC0xMTEwMiw2ICsxMTExNCw5
IEBAIGdldF9rZnVuY19wdHJfYXJnX3R5cGUoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwK
IAlpZiAoaXNfa2Z1bmNfYXJnX21hcChtZXRhLT5idGYsICZhcmdzW2FyZ25vXSkpCiAJCXJldHVy
biBLRl9BUkdfUFRSX1RPX01BUDsKIAorCWlmIChpc19rZnVuY19hcmdfdGltZXIobWV0YS0+YnRm
LCAmYXJnc1thcmdub10pKQorCQlyZXR1cm4gS0ZfQVJHX1BUUl9UT19USU1FUjsKKwogCWlmICgo
YmFzZV90eXBlKHJlZy0+dHlwZSkgPT0gUFRSX1RPX0JURl9JRCB8fCByZWcyYnRmX2lkc1tiYXNl
X3R5cGUocmVnLT50eXBlKV0pKSB7CiAJCWlmICghYnRmX3R5cGVfaXNfc3RydWN0KHJlZl90KSkg
ewogCQkJdmVyYm9zZShlbnYsICJrZXJuZWwgZnVuY3Rpb24gJXMgYXJncyMlZCBwb2ludGVyIHR5
cGUgJXMgJXMgaXMgbm90IHN1cHBvcnRlZFxuIiwKQEAgLTExNzM1LDYgKzExNzUwLDcgQEAgc3Rh
dGljIGludCBjaGVja19rZnVuY19hcmdzKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIHN0
cnVjdCBicGZfa2Z1bmNfY2FsbF8KIAkJY2FzZSBLRl9BUkdfUFRSX1RPX0NBTExCQUNLOgogCQlj
YXNlIEtGX0FSR19QVFJfVE9fUkVGQ09VTlRFRF9LUFRSOgogCQljYXNlIEtGX0FSR19QVFJfVE9f
Q09OU1RfU1RSOgorCQljYXNlIEtGX0FSR19QVFJfVE9fVElNRVI6CiAJCQkvKiBUcnVzdGVkIGJ5
IGRlZmF1bHQgKi8KIAkJCWJyZWFrOwogCQlkZWZhdWx0OgpAQCAtMTIwMjEsNiArMTIwMzcsMTUg
QEAgc3RhdGljIGludCBjaGVja19rZnVuY19hcmdzKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICpl
bnYsIHN0cnVjdCBicGZfa2Z1bmNfY2FsbF8KIAkJCWlmIChyZXQpCiAJCQkJcmV0dXJuIHJldDsK
IAkJCWJyZWFrOworCQljYXNlIEtGX0FSR19QVFJfVE9fVElNRVI6CisJCQlpZiAocmVnLT50eXBl
ICE9IFBUUl9UT19NQVBfVkFMVUUpIHsKKwkJCQl2ZXJib3NlKGVudiwgImFyZyMlZCBkb2Vzbid0
IHBvaW50IHRvIGEgbWFwIHZhbHVlXG4iLCBpKTsKKwkJCQlyZXR1cm4gLUVJTlZBTDsKKwkJCX0K
KwkJCXJldCA9IHByb2Nlc3NfdGltZXJfZnVuYyhlbnYsIHJlZ25vLCBOVUxMKTsKKwkJCWlmIChy
ZXQgPCAwKQorCQkJCXJldHVybiByZXQ7CisJCQlicmVhazsKIAkJfQogCX0KIAotLSAKMi40My4w
Cgo=
--0000000000004d8eb5061460e45f--

