Return-Path: <linux-kselftest+bounces-8814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ACD8B1506
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 23:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0611C20EA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B4156979;
	Wed, 24 Apr 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiU2HC4l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC0745CB;
	Wed, 24 Apr 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992855; cv=none; b=HK3LriW4w/XBUPDq/Jk0bliGfZey3sFNitNcTLLLj7N8QkQQc7jZ6yC8ZOIvxD25hjpLXIVF5WuUyz8IazM7zON5MApqDlkemVgCacuKBfBjXWUpIZqkCVgzKQrMP0rQVQ8WYImFASk1xO4YRvfZuYaJQxi654qpku7gqq956g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992855; c=relaxed/simple;
	bh=G2lwFL42qbTgIYMtxVtz1OXQzhaiH7fEiwGb2ykAjBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B51WyEjOrP1zkpR7FhfqF0ZDCxIXlxinr1wiMvutY9fbI+rScQ1psffoUz3P6EaR+pfgbQ4draaLvABpaIsZtzyrOAnWhA7hgrGXXsjNyTKpFcLoKg/O4QyfuI0JW9QDPbe5RQsE86xhQw9UHoAXtn5p80DA7rvWppzntX9F6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiU2HC4l; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-349c4505058so171504f8f.3;
        Wed, 24 Apr 2024 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713992852; x=1714597652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE2wbyIVjss7r3Zca672+NKJfYO0FEw/nMOpHNeK+9Q=;
        b=eiU2HC4ltNxcGAIelbZCt9xfQu0hLl/ksa0cLQUKSshrKtM1DJheMDA/BezbMNUazL
         jUiVRl7mYzm4jVaPE/A5uEGBbGpatIiSKc1q+WTwi0HG8MyTqL+cD9WuSzqU1gHyPFk3
         tFVVcpflH3R5Q5NMqfcad/FXcvm4ddhtN4J36pTp9FhAsYawom20EDxWkWCsCZwUCzIR
         zbW/R0b9SsI8NqoUTk+XG6i6JLSc4LYITjTe0AGV4ZdLubUySY+TaKVFoiVQrX1sVEUB
         THjwR7XDS5VLEBDfjn8K8B93Lw77U22IFCTdMa0Esjczd5zqwkJK6Y10UicNjKdYLWwN
         UNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713992852; x=1714597652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE2wbyIVjss7r3Zca672+NKJfYO0FEw/nMOpHNeK+9Q=;
        b=FJYDQ/cXu0P+6IOCRY2CNLho9KOZyhFXJsvskVWbleYxa5Bct9a/WsfSmhuI8dBL7d
         Y8OM7mhAJb9Mzg1wEMYurCbhQ/lfjdiLXGmmxjkXluO8SsMdpNvWs1ivGZYrXJ6UFxCF
         1yiqeuMXfcWQcvVHM78YRkuSwXNa+p60cijQqwhMPKnPDfTerscuLjjwXFU1RbxEz1OW
         caJAtLxNXi7k/yczYFkl2TE/spVXcUrp+d+2ox58zPMDh/WxXbtOwdpN5xiVawKhAlAc
         4p0/ma/V1ESgsQqY7CyLkHIPK7RYQ88boO7BOGHkcwOG0HSJkubfLOxmdcXriQPRbwmf
         EbTA==
X-Forwarded-Encrypted: i=1; AJvYcCUupi/oBMEIJkxhkzzf8IfB8sHdPCKQKzjq0ItVWfPe+wgMSwVVKBfPc4wCEAgKAO9zXOR1ThxYGrrEg2PRtfLX4MMI4qzuuL9XvbN7ItqydGAdcZvAmWSOZqIy7hmvVa4l6S5nZgujML2Tj4eQzzDQqBzizINf3VYUr9+pyIZVs7qr
X-Gm-Message-State: AOJu0YzPCmAsHZoKuc+mh6bK6ggibNlIOiTaHYVGApMX0ZNIy+KlhNJn
	qC3tTUVj+sMW36BL2LZ4jX9Agw/DymjtGg+qqctOtb9WF6iNte3nhDulOO6Wj8tHubqS1RJcpWM
	KPDZO2SCuzO73ATeOaVJkSn8DJZ4=
X-Google-Smtp-Source: AGHT+IE6FZ56KaSxGrT+fL0fxCz1iXtlSy7llKH+pz1IX8zk/AtFf1v7IltVhlSxLpAGJsW8EXepJloeKvdYUPCzpB0=
X-Received: by 2002:adf:f488:0:b0:343:f2e0:d507 with SMTP id
 l8-20020adff488000000b00343f2e0d507mr2411318wro.41.1713992851863; Wed, 24 Apr
 2024 14:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-10-6c986a5a741f@kernel.org>
 <CAADnVQLbn9UUZ+oH=uoB7OqCL02ZCYmSbtf3YWA56+XHvG0USg@mail.gmail.com>
In-Reply-To: <CAADnVQLbn9UUZ+oH=uoB7OqCL02ZCYmSbtf3YWA56+XHvG0USg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 14:07:20 -0700
Message-ID: <CAADnVQ+uEazneZOm5Bde4RewMU-Y8H-hXzX_3HYdDeMQHznGFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/16] selftests/bpf: add bpf_wq tests
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Apr 20, 2024 at 2:10=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
> >
> > +
> > +SEC("tc")
> > +/* test that workqueues can be used from an array
> > + */
> > +__retval(0)
> > +long test_call_array_sleepable(void *ctx)
> > +{
> > +       int key =3D 0;
> > +
> > +       return test_elem_callback(&array, &key);
> > +}
> > +
> > +SEC("syscall")
> > +/* Same test than above but from a sleepable context.
> > + */
>
> I adjusted all these comments to be normal single line comments.
>
> The main thing to follow up is to figure out how to wait for wq
> to finish.
> Since we have this message:
> ./test_progs -t wq
> ...
> #521     wq:OK
> Summary: 2/9 PASSED, 0 SKIPPED, 0 FAILED
> Failed to unload bpf_testmod.ko from kernel: -11
>
> and doing manual "rmmod bpf_testmod"
> after the test run is quite annoying.
>
> Overall great stuff. Thank you for pushing it through.
> Much appreciated!

Hi Benjamin,

I've ended up fixing it as well,
because it was causing CI issues.

See
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3D82e38a505c9868e784ec31e743fd8a9fa5ca1084

