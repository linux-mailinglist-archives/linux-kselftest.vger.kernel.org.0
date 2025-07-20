Return-Path: <linux-kselftest+bounces-37730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD890B0B904
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 01:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC101895AAD
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 23:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C9F1DDA31;
	Sun, 20 Jul 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhI1/6sI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B0CA4E;
	Sun, 20 Jul 2025 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753052543; cv=none; b=U/5nyZWfIAZTIX8SQYGAd2OmUJGNDLb3FwokfLD/j8etxMV+0LfOsBxa6VDbLC8hlrPmOyFdRiGYk8KGxj64b7q88i+YYvgrpGBGFKXwfzTMI/ZXNIqMpO3tlmPM9hB8Db3FuZnHck+N+vXFxXzULvnSBYuK1gSYXcF/3BRVCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753052543; c=relaxed/simple;
	bh=bojz5YeZggk/9lojFQ3d6xcEP4ZQqP/6SS0bDQKkrxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNRlWTHvp3ryACAxcIs8C4+bTimXsg3DBv5HPreHTe+JUFpgfVgsOEuq79X3g6h6d/nweF2rkxQNXM5g3CasD9VBZzft+oPXJHA9U5/a2H+NfqupO4t/KDV+GNwfb+J+NsWbHUBQ/oYjcSHcxQPrBtiQ8/eEleit3Fo/mrI4UPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhI1/6sI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso3847122e87.2;
        Sun, 20 Jul 2025 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753052540; x=1753657340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ95xvQUm/kBpw7gVlmEOuHhj67FGfKcDHTGipklSuM=;
        b=YhI1/6sIyJnRbLItWeUMeddwaSW1FwWbxdQtRCspQu5JR5y1mD+GAjbKuK/wYRT5CK
         Sj+TYXEEJ04vnstafhH3CV7R/wXNAWrPZBTKqQuIbevHF3Uch2xsD3c6BngnypdM+eZr
         nMhLpXeYcZ5JQ+XmMPlr536k2G+Qtyl/1q2gQCodAGgc+INu4Xn8v7YF8h9InVGdu2PG
         qs1qymthlf8E+5pKgxWgVSzQrEjmONPc/3FdHm+YjhbrcFk2LWswEZF5MiBTYgdd73J0
         jcR9pk7VEe7KjzGKhCgt/f6oE/mx7m+C5kuBpGrcxSAyE3j8cRAm8cK8oHnnGpLFox/6
         68rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753052540; x=1753657340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ95xvQUm/kBpw7gVlmEOuHhj67FGfKcDHTGipklSuM=;
        b=R415/yaJToQ4eE+CmBCfY6y8Lk33xNrpvbjz3EUBgleEMQPaha+nPohUVqG/+Jjz69
         +Gvp888YicWRidTzS0kODIHZjWGVfWDfz3DcgTdp+5Z3aQot6+QeYKvuBAiQt8RXaWMW
         UsbTI9U//qNL8ozxQWipnMuPWSkAIRvBls5DeLcIEPohdRzsJ9QEAQNd3QV2he51N4Fe
         rkmiqV9BLbTd6OwPXQQS2EaNPtlGttljTGKBvBkzVNulPuAn9Y9Vn9ICyIW9nE8i6TfP
         0UvyfTGYUfALvQ1w/Ah7tE7Ozo3TvTK6DQZ1715NyYHgnyo38p2FpkdxqGSpoRuN1Wci
         9Xvg==
X-Forwarded-Encrypted: i=1; AJvYcCU3E0sH2ai56o1+F7nx/40RvpXHPDCf4n3W16PSqMjz+XHisyT5DWwCxTYOWgvZsE/OPupslCUwTCiStLB/+tQB@vger.kernel.org, AJvYcCWnqk/D49s0YjNCi9IbObCrv3nAydcJ46YHT+O9P46roATtBD9KiChW8XljgO5NmL4VMCsIMysHM7em6Z8ABVQ=@vger.kernel.org, AJvYcCXa8D1WmPDPwEhjgf9J5gbP/s7YqaJjYrLFt7F/RB9FRbzs1XQ56KgI+DPPy2WkYMte+ZnNOHO+0U28hB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zc3NcJawAWxZCtlgf+w5wz0yukZVxuofjZph9epogemN7Eje
	s+jA7Z1Ifj6kpkEnXl2NDyKpNzqwmCxBHsN/PY8PrM4wKwJAM9dDDLFehiwPveYq5K3HqqCEOQd
	SJrDJjr+Wrg+UMuoGit3ttjxbJg/hu2paVybkKEiCdA==
X-Gm-Gg: ASbGncu8j8n/oWhAxGVuohQ2sR7l77pJRZ6AV0NbhpzdA7GdSMoc6i2JVPUQuL36Nqc
	xpn41WRyzoO0AjcWWjFlJFhuvPnPzfiir3vnDON5MxEQHg5n7OAdf9UVrxlVNHzWvhMcfRHLygL
	JS8iV9PuqqOfomcb0NywbV6hl1FGC4zaSOcZVysauzQa8nk76EVHquob9l0oyBxfyKJXoUwoA7x
	7IyATZ2rt01tZ/L4rYDPuB2eyywW0v9m7PKvTIxWg==
X-Google-Smtp-Source: AGHT+IE+FCX6UtXA190qovvKWqmj9Qc7kYrLAljsuFf21aT7QM/McGfFwDZUlU+YBrUNaOJ996gDs2QpBz6dlSHgjxE=
X-Received: by 2002:a05:6512:3e0e:b0:55a:2735:fe6a with SMTP id
 2adb3069b0e04-55a3177a061mr2942491e87.0.1753052539912; Sun, 20 Jul 2025
 16:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
 <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com> <CANiq72nb4LuwkZVjEseMubSX4VOMNTX-8wUV7LtS5FN80cMjyQ@mail.gmail.com>
In-Reply-To: <CANiq72nb4LuwkZVjEseMubSX4VOMNTX-8wUV7LtS5FN80cMjyQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 20 Jul 2025 19:01:43 -0400
X-Gm-Features: Ac12FXwksZ7ly4zRrODQBvaHDTk-pZqsw5wqhXOkkFG8bCEizzAQktr9SrphcoQ
Message-ID: <CAJ-ks9mq_bPH84Mjb0csMQWNHMXuxBK3syuvAdkiRp5FiXOJLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: emit path candidates in panic message
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 6:20=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, May 29, 2025 at 3:15=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > +                write!(&mut candidates, "    {path:?}").unwrap();
>
> I assume this was supposed to be `writeln!`; otherwise, we lose the
> newlines and the indent does not make much sense.

Duh, yes, that's right.

> I will fix it when applying.

Thank you!

