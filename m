Return-Path: <linux-kselftest+bounces-34404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 415D1ACF8E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 22:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE74189CBED
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08A27E7D9;
	Thu,  5 Jun 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGpzMmoA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEB19D880;
	Thu,  5 Jun 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156358; cv=none; b=XaeYxAzXJgeU01/qxpKXkefmUDYeNO5qsU5hPJd8UxRJ0BZZoKJk0Spqi/sohm3ZYRmGWED9CdDuQgqyW/BWFyz8QOUkviYenhHNJtcMiJSkI+6w6rnIPVu1Vt6nAN9F5BTQ2bjHwuNsC/Gxlvk7a6u1xdmxYHkbdneMDWYbpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156358; c=relaxed/simple;
	bh=KaleJOZCFYwOjK3nI6qlWVXegytr99EwRh96RQIPuX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRjhpihuh4mEjOSefBEbaX1C4PLjDVQj1Fp5ENxdX405Vdc0bx0oMHZ14s5dtdpNEu/QGgUEp4hYr8+7eZ4QLezIZ1VdSpGyASiyq665MwQeNeosgRf+/mlFkL7s3JniDRLmx60VQYbklZKVoPMRsyNjMjRv9LWuN+h0KvgNuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGpzMmoA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3122a63201bso1285309a91.0;
        Thu, 05 Jun 2025 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749156356; x=1749761156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08nvIWQniSHmCFLizlsO6hV7YjeqPzOvfL/VB+gEMjQ=;
        b=TGpzMmoArGh92boshPkIgyyRzUM76ISskMt0AysCDrtJMSsFOpxUwIJ3JkPcy/NDkL
         0WK1odIwqI1cH8pMeiB25RFT+9kelTHkDJ7Z1jtQMv6P0ZLFPru7j+DHYynVV+7+7A8x
         fV1/HLpDe9NemgeSEirjy7JXOSeRDOjUUfNpfWh9yPvyaEd88wdpCMK5FgyoFJ3Oyi1M
         scm/Ji5d4mhHbDYTp9rJk2faS910QJiZignijW/Bq80iWod1Ya5BU81WY+K5mqh2HKI6
         vvUIEDlikp69qzrhJ1MAhFKyefccbYZkKTR2IOAAH4jnigQwGsfBT1jMKo/TJkEAtQUO
         omgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749156356; x=1749761156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08nvIWQniSHmCFLizlsO6hV7YjeqPzOvfL/VB+gEMjQ=;
        b=onsXXDYlnhU/qVvGFKDUCjXAs9P3VAkDkk1UNW6/rAgUkfheYoLFOazpgVL/eyWG3v
         SevCI1kDBbkstsmzGCd7dHT+ZG0cm/A9y/RM2lkvI+QUfAaUGloY2cItKu8dvaYY48yA
         MygN3lineQFsA8TDIyR6MOrSlw6jL7FxyFSOnqZOLynsR6VAd51R8nuhyhK9PRoEmf8i
         rQUoSxpTjtAy+42dXAGHbXQ6gCJoSOluF6JoiJr5Yi3LtGrpNIa5cBg1bpujWM5/kHYE
         Z3Q7EPsLnic0u6PJU6mlSnQyA+klnsEvcI/C0aT1xLi9VDNBAHuLdsA/SFldB2febp56
         dqxg==
X-Forwarded-Encrypted: i=1; AJvYcCWIRZPxpQCLGcIwnBbEy+cP7H0BqPlThj1xy3QDssXRWyYmzaMxyjts9zqh2I+va04+lQjbhJAejELXWUnt@vger.kernel.org, AJvYcCWftN1v4hoWtZaT0lyT3uTDeN7FX2tbpQdyZajetDyvZ1+P79/3Ie6ohaFR46uY+YjEBJo9P32wRdMhsUNsMDLU@vger.kernel.org, AJvYcCWp9my6zr39cSNW360avezYsHpclNdbbPc3NRXbKFKxMWCNwL+ty0O8URy7BWXpqFrk3nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVfcmKcnLGRnSmPXkme7UDBR9izkHmfzLfgP48EIfVcNCL8tV
	pgpgX2c8nFKGZDdbbdZ+ooXTJ4+4soquq9hWerdpt8uxiKa8cjaRqD6xrk4qbtzEDc/x5NKHu5M
	0U7TVjjaqRvSnDimJJlQXSNNzDCafDd4=
X-Gm-Gg: ASbGncsm8J2vaCxaDK7bGfQUkqy56nW6yX23MfcxhFDcq3Gd5T/PDP9/rL5P6c+Bpse
	IlRGI8OIDPHkeqzD6W0OIidOkp7YX991fIaTexUtm4ufWXbsNwiwkGEVAeloUlKf+ERhs+WGPWN
	1Awfgpqyno3ERq0+ZK5QLeEWRsy6MfU5+x5aEEgFKHA15upMa6rs/3+J8YkIc=
X-Google-Smtp-Source: AGHT+IHsr9ttE7WIn3845WOdkjd+yiJ7dZGR1JHZtZQdlQhQ6XinR/AD3N+nP6o+ND2yd8oiZBZvEkpoETpzIV7L2t4=
X-Received: by 2002:a17:90b:58cf:b0:311:ea13:2e63 with SMTP id
 98e67ed59e1d1-31347300dafmr1668278a91.13.1749156356548; Thu, 05 Jun 2025
 13:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603203701.520541-1-blakejones@google.com> <20250603203701.520541-2-blakejones@google.com>
In-Reply-To: <20250603203701.520541-2-blakejones@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 13:45:42 -0700
X-Gm-Features: AX0GCFsF8bZqbHLzfHuC1RDhJourh4uvIqmM0-HJinP_vZEVbnxfekkB0vbUQNM
Message-ID: <CAEf4BzYyn0=d-M45czJe-Qfk0tTuqLcjzCOge_p9iu6vXWR7hA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Tests for the ".emit_strings" functionality in the
 BTF dumper.
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 1:37=E2=80=AFPM Blake Jones <blakejones@google.com> =
wrote:
>
> When this mode is turned on, "emit_zeroes" and "compact" have no effect,
> and embedded NUL characters always terminate printing of an array.
>
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  .../selftests/bpf/prog_tests/btf_dump.c       | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>

Nice set of tests, thank you! Applied to bpf-next.

[...]

