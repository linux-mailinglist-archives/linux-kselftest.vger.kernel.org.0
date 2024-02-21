Return-Path: <linux-kselftest+bounces-5109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8B85CD6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3A284E2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E620E6;
	Wed, 21 Feb 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWrAeSWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381791FBF;
	Wed, 21 Feb 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478670; cv=none; b=VESWiLEzZr4/QjpG7ru6bfrcSPjp0X8O2Il+54aPVSEypRojLPqTgsUlcUjqNM1xWjOKR2AKsRxx+5Yl1BZn5HEfW41JryO3dlJN9l5cVxYQxguufo/PAwQOUNDv5yATdga+F4wOuRLG98bew6d0xfyWF8WxE2HanvEXOJswU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478670; c=relaxed/simple;
	bh=QZojfwT+RxAPcmdQGaQgA+F8ssXlbPridr3vJSQMHT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRldLuwejUA2QQ2q/90ioEu2BGGZcnHmYHK+vCy14XoHr+fPT4+YgdEFnuvfdJGMqJvEosoGKZSrPM3/9WpBVH3YWOT8Vivdc4Dacb+rJCfrfc6xjPA34SCqLipLYKTR7+pm/oRKwCZTfalMRc0m5ZI8m1uPgVpXfQrpDZLfvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWrAeSWf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d754746c3so261294f8f.1;
        Tue, 20 Feb 2024 17:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478667; x=1709083467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZojfwT+RxAPcmdQGaQgA+F8ssXlbPridr3vJSQMHT4=;
        b=OWrAeSWfUGL36cZTld8OYlai5rafUEyLQ8TlkZaY6AhUOjumMc4P9k8F612tzCww8S
         HztGjYC72SK1gsDcvM/j0KHGuFcPg2VqFZBtM+wbS8Im+RbTjPsKsOyF/iB1JipdkWFC
         avQeS9MVsrHwe1Jhyi7Rzz3+ShggxJG0FwOxJS2gBJxLfDLUJIZqFRhZBHsWzL4TKQhz
         qAXnDSKMGjGVW5XX/8irw1ReKYr79Z+qFXO46KuhIz6RB1L3jmX9JFJpa5Dcb8zrUTeF
         P/xWE/Z0/FyYVLhjkz16HD0wRw/rTtKJiFhkVqy83onyFHEus1xmsrbNWd6vzVts7FdF
         gf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478667; x=1709083467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZojfwT+RxAPcmdQGaQgA+F8ssXlbPridr3vJSQMHT4=;
        b=dw/ZLIjppozkgWHcx+QS0SObeLcu63LnzBYlCRUvG8O/Te2bvbEZGYY2EEPDZmfBGz
         fkq+U97j4AR1yaLV0pOlCvSJeNhXB2c/D44pJk2nrp9cuvnv+wqYy0dZ3ZFnv/HJd4+y
         k5I/Dj3+hrZp6yssJjvZBfom4wgDmzWTVhjQuShR5T3bWrwpx4Bqz1cPj83Ww45oGxta
         Te8hHDWcoyRmZl1vbd5E93Qbc0BPv42DFX+7MJ8jd63L3KCZBklX2qDtU1qSW+aD252J
         mFq+OlAUL9c98tcheo+nyyHezJVsoVJNV5vGVptCv57lR0BE3eO5cDLTmN9Lh9HehPrz
         VEkA==
X-Forwarded-Encrypted: i=1; AJvYcCVW6GZKh+2dZ1W4ScGEQh2Axi/iThsI/BiIbmVi7U2urW1O96SqxyDLSmga9ExsSEGHmHL71zwZjQN09j5QFV4jrG1pHOo2yzBYRhN+s5dT4IeZNjW+tT+ykLMcUwicpT2xEkKRpP07yCcQqAayqU255yLFd/HizYdWX7Qm0TIy1jxC
X-Gm-Message-State: AOJu0Yz4ExHCzImanBCBaWVUAUaarJpA+zOLdwDh2P256GopdeZgpz5/
	gXb5A8IsCgodtVTB55oNC7acdxPRDcc7AphlbkcnT2fb7O4SHposV30/1yTf7svm+m7EWnicI+Q
	46YXjl5Ol+dyOKTbvqug69bWNlD8=
X-Google-Smtp-Source: AGHT+IFyffuFUKOEwh8cz2anMZHoATwBV3He7T2iJSSw7NZmTRvibOeFA+SKuUw6n1BjpafmDJGA/qD3RYrvTH/2jQ4=
X-Received: by 2002:a05:6000:1e86:b0:33d:34a9:902f with SMTP id
 dd6-20020a0560001e8600b0033d34a9902fmr7166848wrb.36.1708478667438; Tue, 20
 Feb 2024 17:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
In-Reply-To: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Feb 2024 17:24:16 -0800
Message-ID: <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: make tracing program support multi-attach
To: Menglong Dong <dongmenglong.8@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Kui-Feng Lee <thinker.li@gmail.com>, 
	Feng Zhou <zhoufeng.zf@bytedance.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
<dongmenglong.8@bytedance.com> wrote:
>
> For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed to
> be attached to multiple hooks, and we have to create a BPF program for
> each kernel function, for which we want to trace, even through all the
> program have the same (or similar) logic. This can consume extra memory,
> and make the program loading slow if we have plenty of kernel function to
> trace.

Should this be combined with multi link ?
(As was recently done for kprobe_multi and uprobe_multi).
Loading fentry prog once and attaching it through many bpf_links
to multiple places is a nice addition,
but we should probably add a multi link right away too.

