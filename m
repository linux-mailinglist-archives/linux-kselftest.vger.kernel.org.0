Return-Path: <linux-kselftest+bounces-7463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A834F89D0F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482521F25F10
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBFC55E49;
	Tue,  9 Apr 2024 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUTESkjM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384154657;
	Tue,  9 Apr 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632665; cv=none; b=nlAVqI8DFzCYP/FVbO+Ci0oComy1ezCqQzfes1legzmtzHusT5quWzVHOyvrCWhtDSqs8n313kekxxJMZcyMk0qe/hhj5tQm7ZWQz7xByUaiN8z3lUpGOmkvPGIt3/4Mm55ppfl3+K1Bax9UVl6P+rFXMnOAZW2umgkcHGbAPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632665; c=relaxed/simple;
	bh=P4H/XFvHwflrrbs3t/kUcS+grqgQHB4cHU8wQ9a3lQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBgujGQsc7edpjuC9zkfQgKrcap4CUqEi3V1Rofvoyu+Z1awGCa3nZxAhS7Ko9NsvR++8t2sJbW/MVzpTHbHv8AQasOJjqMcMutXYl+MkF6AIQMTfBcWakMq/zo/1REkM9TrgM1nCCx8bi04uVICjuYu+O/royFIeDNI4OHpTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUTESkjM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41691fb4c8fso7879665e9.1;
        Mon, 08 Apr 2024 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712632662; x=1713237462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4H/XFvHwflrrbs3t/kUcS+grqgQHB4cHU8wQ9a3lQ0=;
        b=VUTESkjMUdI65c7yITJQxRwRmvuwjMj7+qOiUUa1ExKZBl3yNGBRtsKX5pWg+r+iki
         JOfM4Tvx9c82h5AlLHqglZ8EXlT9QTG/CWlbW0EpLjd7k0GHdcCjEPv5++JqKzna+6bH
         1gg9zWXQq/2o5NR1s7shZUqYA8SWbb1alWH9IsmgivWIvVNwTduNSxZynTu2pibF67tl
         6OtOGndJYKnABk2p6B1N/Clxz37sZTqL4IS4uSIz8DmBxF175T/y3FxiV20xZAv74dji
         6jLv6TgopNpDnZQWhtdpYA/8sFCVdUtuGMxp2Aa73HaWWLK0Mc154mvPr+WVXHTr3xVF
         SKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712632662; x=1713237462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4H/XFvHwflrrbs3t/kUcS+grqgQHB4cHU8wQ9a3lQ0=;
        b=hliJV0dbjYVQmCkS4TGmqUo8euX5Qdq0EgNSQvGUsx9y4jkh91Hu+RP6DGEZjDr3cx
         KKwK6VP1F2rh9eIBO6LS3cGfHRZWwH15XCSqD32muu2wrbmKEum8J6FDftgFWyp1rRE/
         xPbgX0lrJYeY6uxE3umrYB9SycfUe2JCas8nCfVDDyPa518khUHGnv7qzfRXo8uoH4gU
         1ah3u6RiiBmwgkdHRnHu+Kk1Je/Tf+XOAGWis+cfVHt1BXEtZPu+YK3V9/1HE4cjnGPZ
         2F9fhCnsuVbOduCUjJfgyvYcV4SC+c9BOHY4hLRnFa974gcqyLUL4Le9E1GzqLe4zQ9r
         6EoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvYLk/e5IFQaHgaCmVC0soe2n3pELMjgGMMMuUYAmVYPrK2W16giEnnYylYrr8rqvXu2dC5q3PD5tRd1rZtrJFpfpzwgimcVDT2GPgoVwiqOMYdCBmFV88It5jlirGPFal9lDrx7zRpCFKxyP0kDUyfJUkQXBOUWuSR6CmlJEaXRJq
X-Gm-Message-State: AOJu0YxfFpBRZ5I49Igfu+XgW+cwrLPKreBhjx82pZKM5TcHuwy0eRXu
	Jjud2zMrM+g4ukX2G1hJ4XGVtqfn6b27k+p5aPMDvaT+4sl1Hl/8epSw4iTMF+hmJh6Cb12KEN/
	z7VUfJHvYuGKMxrCd/FoKUuym2Qw=
X-Google-Smtp-Source: AGHT+IHhuTjWebgwl1PizQ7xQCCR2AzOJ+bGg22JGfhhCQsFBhXhrNBRiwCdpbhn/1fnYzFazQ0+NmziJD/Xf113GmU=
X-Received: by 2002:adf:ee08:0:b0:343:740c:5d14 with SMTP id
 y8-20020adfee08000000b00343740c5d14mr7914384wrn.31.1712632661977; Mon, 08 Apr
 2024 20:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
In-Reply-To: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Apr 2024 20:17:30 -0700
Message-ID: <CAADnVQ+TdpJ9+jH=+L+6VPCeXvdFhWaATHUf=XL5WNxtfopzQQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 0/6] sleepable bpf_timer (was: allow
 HID-BPF to do device IOs)
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 1:09=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> New version of the sleepable bpf_timer code.
>
> I'm posting this as this is the result of the previous review, so we can
> have a baseline to compare to.
>
> The plan is now to introduce a new user API struct bpf_wq, as the timer
> API working on softIRQ seems to be quite far away from a wq.

Looking forward. I think it's almost there.

