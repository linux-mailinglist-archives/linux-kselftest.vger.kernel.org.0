Return-Path: <linux-kselftest+bounces-25250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD004A20034
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2209B7A2A92
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287CD1A01B0;
	Mon, 27 Jan 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYOL7scM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D91B64A;
	Mon, 27 Jan 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015489; cv=none; b=Mvho5Bq48FdcVKaPCKOa6E3AcsM0RSM972onDpMelFS99Eamhm9pF4r+gKRgFSQ5ODVJOiUP8fvx/E8txqhxP3qOfCzvdt5RPigGssewh52bY1PSIXcUJECsWKmg+OSck9/7Jqoz9ACLyCrVF/eb8+w71wtY8c8qnlxTNGNWvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015489; c=relaxed/simple;
	bh=X9YfYIq2sLm6xuNcEXCHLbbkHYOGkRvCZ7dLgovc1p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rP8f3ZQge9UZexObixDr5d2koLoEvoA4WoG+HAmL6eseAwU89rcL4wnpCRDSV3NyOyBOEsDbutqJE5M2zNwBoQDMYamhZdt9H2k0vvk7OhnCNctCaHOVGuUvt6tzMKzrHFWE+9UFg3wGq0t9nCawwXuFWDFmAnE4GBygikroHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYOL7scM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso4682908f8f.1;
        Mon, 27 Jan 2025 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738015486; x=1738620286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDdtNnX+lWi3wWDGkVQoG3W+/RHDB5m+7YeqveGLDTc=;
        b=IYOL7scMSMTIkH10PmK0X2j03NeQO/SEG2Ls9JtOv6NlPadFucHStDqC0FpY1r3+fI
         3uPKGuOiM6VWozVmsMx0DRkCFH2OO1M/551IXnKiuq6P21O9gQkuqTTgKqdejZ3G3S9E
         aFP5frJQJ0b9LrjN13GF+6yp4yHKtFB8wYZPyMGpA2B2t6JHrHIPneAt9ekIpmescd+o
         CqfjFeedLgM+LoMI6rU0zysorR3O+GmuofP1Y0zu/4LzeHdbvi6AtHdqo7DaBqdVeUH4
         /qP5ZkCTDk8NjXZ0S/xsAmxIqkSZThoytSfs30/0hC8c6HmcKt7C3cG5y6IPrfXxcQUb
         j1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015486; x=1738620286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDdtNnX+lWi3wWDGkVQoG3W+/RHDB5m+7YeqveGLDTc=;
        b=YvlWhc4fyaJ3Y/9vG1MhgD40o19n1bW3g7/iaWOLwuI1J2gZG+/XIboxuth/su0w/x
         t+bifSnZAlB8VSPYoC85vg1XCCOYiz5RU3fl0mrzFsN62N/tYaKNrVJaTJCf+o0RNdI2
         JyofB+UaXZEG/Zcyli0S+KgloZWpw1Uc3FfgFX3oXDaBdbtsKFJeCWsxLvPOk0LrHT0z
         3lJD8AmFpoZHJWP10g0UUlf8xCmaQG0vduzsmThdY4ESgUrAmKjHrNHYXHKTod0l/b7A
         WqZHICtMkPEEtw2h686+Ivs1d7WfceBqE+2qzvhkpxPQTnDtmDyOeyt6C+jwUt5+xX3K
         96Og==
X-Forwarded-Encrypted: i=1; AJvYcCUlKMlVooC2Uk5i/q7wr/h1cMht7/0fRejmbc+o3/Mq6qdXwfN/tgmCyjTLcNz8QpcevODEqLzgVs6LqShv9wO2/x0W@vger.kernel.org, AJvYcCVb1Li/kJNfKoXKQmfd7G4QAAgxZq4RfzlIAtJ0egnsD+olNLd+gCTrjFGZ1jCZQWpKe0s=@vger.kernel.org, AJvYcCWZxn5hGp4P8KZVK0srqDJRawpDZjUfOhz1zhgmTE613vqaFcp9yx9pa9cNupWB8aoK+MeBFvcsj6RbSbci@vger.kernel.org, AJvYcCXInyUog0og7gPylsLSehZw/ozfpj2/aLwg4aKa6P60SdBxst4OcKN6m11iOu5J78jhNnv4Z58BjKMJGICD55WK@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuzbNBLbwOD1BX3etrnJEV1EUTRT4t8aaIRpPTh/+JvzZAV/x
	cp872PevJ3mh308tu39Yzg5HOIOcDkLCYZCHFvMhp3Xeo7RUUIE8lzHaat7kvsJ59zN26+lLnmQ
	s40eHK1w/8/lPjn67v1nSYmRvPHk=
X-Gm-Gg: ASbGncvrAKttZw+rZeHaBvI5864piaIUrv01HcbGAozu3VT81ZhofZ3uLmu7zCOXGEq
	H15S/Oi0aLD333i/YwxXrsnXoluVJML0tWS0dc9AHvymyafxINqRq31ntLCao2FFpCaDVt4/EeA
	fzmjUPhGs327ZcCd5iRg==
X-Google-Smtp-Source: AGHT+IEmP1BQeihoLxDsoDkg8eXKk+1oBx1pRLmvXa7WxMyzR+PKkb1/yKdhrSsHq5dmj6+XqCFkvhA8OcgHlBPm6DA=
X-Received: by 2002:a05:6000:400d:b0:38b:f37d:c875 with SMTP id
 ffacd0b85a97d-38bf566b30dmr38458073f8f.32.1738015485398; Mon, 27 Jan 2025
 14:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com> <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Jan 2025 14:04:34 -0800
X-Gm-Features: AWEUYZlv-eq4t-jTtOz7DOPfdnvt0FI_k1AxwT0cJhy5FpU1MOHfohkaB8qqLOc
Message-ID: <CAADnVQJ7bw0Qa4UM_E0zb5bqt5P09f7rryFSe6faY8ibX0zWuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement bpf_probe_read_kernel_dynptr
 helper
To: Levi Zim <rsworktech@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Sat, Jan 25, 2025 at 5:05=E2=80=AFPM Levi Zim <rsworktech@outlook.com> w=
rote:
>
> On 2025/1/26 00:58, Alexei Starovoitov wrote:
>  > On Sat, Jan 25, 2025 at 12:30=E2=80=AFAM Levi Zim via B4 Relay
>  > <devnull+rsworktech.outlook.com@kernel.org> wrote:
>  >> From: Levi Zim <rsworktech@outlook.com>
>  >>
>  >> This patch add a helper function bpf_probe_read_kernel_dynptr:
>  >>
>  >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
>  >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
>  > We stopped adding helpers years ago.
>  > Only new kfuncs are allowed.
>
> Sorry, I didn't know that. Just asking, is there any
> documentation/discussion
> about stopping adding helpers?
>
> I will switch the implementation to kfuncs in v3.
>
>  > This particular one doesn't look useful as-is.
>  > The same logic can be expressed with
>  > - create dynptr
>  > - dynptr_slice
>  > - copy_from_kernel
>
> By copy_from_kernel I assume you mean bpf_probe_read_kernel. The problem
> with dynptr_slice_rdwr and probe_read_kernel is that they only support a
> compile-time constant size [1].
>
> But in order to best utilize the space on a BPF ringbuf, it is possible
> to reserve a
> variable length of space as dynptr on a ringbuf with
> bpf_ringbuf_reserve_dynptr.

That makes sense. The commit log didn't call it out.
Please spell out the motivation clearly.
Also why bpf_probe_read_kernel_common ?
Do we need to memset() it on failure?

