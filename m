Return-Path: <linux-kselftest+bounces-25262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F6CA2012C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED391885C2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60971DC197;
	Mon, 27 Jan 2025 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E80VJDTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBE1991BF;
	Mon, 27 Jan 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738018452; cv=none; b=MCBl0xiFUOQXvXrr4ttUJeauAPvjffpQO95WA+rE/pSdWR0NDQE08rh4ZS/4GJS74aAWfwXsoI2SrgT6oJm8Q0mr3EuS75MtJ8ptMKRGjoM2S+Lsu6eDMDfLLKmQPjVHvp39KkFzzue+niZq5ZPSDUn0uoJAud1OQlR8HpjBilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738018452; c=relaxed/simple;
	bh=cRjAcpMjFLL1m2e46QLpUxuFpdU24woSx6aEV2chxao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/8Aq0yFUI5C0hEck9wwSc0wnO0Pz3m6friA0VsrOYbzODJnOnrdGRZFDsVhkV5NbUWE+cGUXFTxnkmWwBjs0WVBDlNqb4jhb9MNqtKuKc+uTGf1mG+d/TC+z6SX8es5rwHDQP9KuwLIufiW2AANGLz1borxbkXL2Q+1gg6CrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E80VJDTP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46df3fc7176so46086001cf.2;
        Mon, 27 Jan 2025 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738018450; x=1738623250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBUEBw4yjgIXSCi4zJIhbPcJ811I7WO0XsQmUV8oSV0=;
        b=E80VJDTPHLTeGO3LFLRbjfoJZ8wI+HEVv3ztuCXNm8h/fakJh6ZSTpG3JNxBtfA2wp
         3lRm+u0AEnwToQmd5CS2fOXiV20RNtkSOQkgwOB7XRjLu65qeH+nXCmTZDMhKMh0B4mk
         wBGZhKXESgg2pmLJEs6uvRv38m4tbDgdubjTPDyn5AGsHqFrIHDMiUwUPkIEgExbcj+z
         BS+TRFCgEchsFQFg9ykZwEFnR5yLxhB1AKOKt+RRS5I0L7njWbwEtM6iWhOwb4NZWVKw
         Soq+pew0XD8v1odFXk5RcTZ/kqjtsHoBRn3sVxEBk3NyMJcYlXSVBY4Mmio7138m71q+
         kJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738018450; x=1738623250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBUEBw4yjgIXSCi4zJIhbPcJ811I7WO0XsQmUV8oSV0=;
        b=aZwLBnCxxsG2ASn6img4tdFEeAFweiwf3iQRTXlxYis9Z7YyYfpAB1SYlhFCgL/Pje
         Slw1BjXmB2nLiruUPY/LDhJPNFRFw2vNIWhNSqHEC4DYwGAdxC2Kh6X7C0hN5/ZBUiGa
         UapxcOOCax6F/biL1ZY4IG5QQVDuO7qms+EYWECImbSlIbFlZ0U6+ODf9e4ePwtPoeUf
         TXVrg7h66OTglkGpRIvFe65fCDhW8J9GDbrOpc9tnkqypLEmlLa3gGaipZ7Txvb8odt6
         aAaWDxdriXi9+PwmsBino0T4rA3dcWygsYysqRxOy5QdLCOPc2eDeFTWfnmMSNdBI2W/
         qADQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc8Xto+jgwx8xRfBC46r02Xdin8iG0DPWA+WDO+95hMqZeRumiS0BZwP/DSBoHnDKyVaMU0zTZpiQPc1IPsZP2@vger.kernel.org, AJvYcCVEgZJzqTvB4GDxc6B1yoni9fqXOsrcB+e07l+17qtGzN2lKKOUVTZh15raP+3yJ9gGzyssl4ADikVCL9VG@vger.kernel.org, AJvYcCWTYUP0YdRp10T2lOdjaWWe4Xjawv2aFyUwkuDIShogkh92MvoW0kX9dmLwSzAzuZ7cFHc=@vger.kernel.org, AJvYcCWy2xjVnNE9VRH/HKUcpFLkoFlW0HfHZm7d9E/aLp9SKMwR8dzgjrqLf1+hQ6qqeq2hn7HL2v7JtZz3H/fcjfMrtzHI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9YSYPQn/iUOoqQ3RpcjoY4T6GZXKiYdI8e/8jpHK+dgkM8gHd
	8D0D2VgAvJlThHQ+bzO7IucxrKeMh+xLTg6kqdQHdYyrLKtLkEeVEu037jBM0BLZ9JRBEIttirG
	Yv5RMm/KMjatPgBISGt4ASH8vxLo=
X-Gm-Gg: ASbGncsBOHOYh/MwiASi52igYaFES9u6gMIUFI6AXl7gVk2u4Y+87/Cm96wCbJvcuPT
	Wmxx9YWGmiIoDxTTuysHM+SaAzRX8lpmsRdV5PM511jjSoVCv4u7ojQCOuJ+k8A==
X-Google-Smtp-Source: AGHT+IHKeID9uLei14uZgypw7a410glzRtnGfzWpFMgGqVPzHjs9TIV0cNc5CfaUn5rgdNeKbWW5EV04G1cfFlKRbKA=
X-Received: by 2002:ac8:59d4:0:b0:467:45b7:c49f with SMTP id
 d75a77b69052e-46e12b564f3mr602772301cf.40.1738018449973; Mon, 27 Jan 2025
 14:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com> <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
In-Reply-To: <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 27 Jan 2025 17:53:59 -0500
X-Gm-Features: AWEUYZmPMUvpm8zkeZ0gDfxE3t2WlRe0ZGxaYDOvr0SgR5lAWuywZK-kZVm_onU
Message-ID: <CABWLseu6=ZSYpQncaj=0EeVzKtP8vjPyOBJkWcFb-dxbm5OfVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement bpf_probe_read_kernel_dynptr
 helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Levi Zim <rsworktech@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 5:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Jan 25, 2025 at 5:05=E2=80=AFPM Levi Zim <rsworktech@outlook.com>=
 wrote:
> >
> > On 2025/1/26 00:58, Alexei Starovoitov wrote:
> >  > On Sat, Jan 25, 2025 at 12:30=E2=80=AFAM Levi Zim via B4 Relay
> >  > <devnull+rsworktech.outlook.com@kernel.org> wrote:
> >  >> From: Levi Zim <rsworktech@outlook.com>
> >  >>
> >  >> This patch add a helper function bpf_probe_read_kernel_dynptr:
> >  >>
> >  >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
> >  >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
> >  > We stopped adding helpers years ago.
> >  > Only new kfuncs are allowed.
> >
> > Sorry, I didn't know that. Just asking, is there any
> > documentation/discussion
> > about stopping adding helpers?
> >
> > I will switch the implementation to kfuncs in v3.
> >
> >  > This particular one doesn't look useful as-is.
> >  > The same logic can be expressed with
> >  > - create dynptr
> >  > - dynptr_slice
> >  > - copy_from_kernel
> >
> > By copy_from_kernel I assume you mean bpf_probe_read_kernel. The proble=
m
> > with dynptr_slice_rdwr and probe_read_kernel is that they only support =
a
> > compile-time constant size [1].
> >
> > But in order to best utilize the space on a BPF ringbuf, it is possible
> > to reserve a
> > variable length of space as dynptr on a ringbuf with
> > bpf_ringbuf_reserve_dynptr.

For our uprobes, we've run into similar issues around doing variable-sized
bpf_probe_read_user() into ring buffers for our debugger [1]. Our use case
is that we generate uprobes that recursively read data structures until we
fill up a buffer. The verifier's insistence on knowing statically that a re=
ad
fits into the buffer makes for awkward code, and makes it hard to pack the
buffer fully; we have to split our reads into a couple of static size class=
es.

Any chance there'd be interest in taking the opportunity to support
dynamically-sized reads from userspace too? :)

[1] https://side-eye.io

>
> That makes sense. The commit log didn't call it out.
> Please spell out the motivation clearly.
> Also why bpf_probe_read_kernel_common ?
> Do we need to memset() it on failure?
>

