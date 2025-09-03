Return-Path: <linux-kselftest+bounces-40684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B861FB423C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 16:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC981BC2B13
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6391F3B85;
	Wed,  3 Sep 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="OO6D0bjv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B31EE019
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909912; cv=none; b=o44XfBuhXjNmbRzFBVVNf9CUzmG3FTeA0Upq44UzwtKF4CHWPrtwdaOGq6mb6H59P06e7FObwxUCFlDnEf/zYvuds6/m0XkSDn2mZz15ni/1TS9//nXesJY5RBt/21JbDDVwqkNg5jZX59AEx8434ZOF+MyDhyrkIgdFh8kzgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909912; c=relaxed/simple;
	bh=dFJHOuSlomZMY1e1WhYT/9BjuUTdLl4qUfkdjnWwEdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd0IKDSbZRISNYV7idv3vWAK4idkwHupLaX/DP5vXDFrzCl+/+h7YHlC3Ndq5awPZ9PDMV2UKHyLxKWCScbtpq7ugMOQUJWWkrKnVApKJLg78JxmEdW0yAKz+7bcEZL55jpDM+N8ql/UnQ1aHs+dWY8ifJaPq98VEOuzDoUXkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=OO6D0bjv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3f663c57226so1888305ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1756909909; x=1757514709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xK1Ixt22UPQpRV6eJF15nySq1ENYn93GAeXzGVGJzQ=;
        b=OO6D0bjvsCNz4UDjJc/eT5GiK/c5J+Hxok4gpK5DlhwLVFp/jDdWosAR0he7yTlLMP
         G0OtHeQ0jLvw2FPtrRVnOyiflVyHps0HdBMYaZqXglvh8vADnJ1lgEM1k8YFHsoFkjSA
         vbkuvgwq1SheH2p7HotMXtBh0X7miwaXjKP5XsBqkssNoeuiOc17ydxcwo3wJXuura/i
         Jn3WqYjZ6ytUt//11QiXNCZFMy7ZPoxAFiZ7Fa0kmb/v2X91DCa29XysIjuzkWZiCyns
         9gn97QRkMgJ9tO3RnL7mjbWy0933idCIfYYoyissrdB4I8ngszURRBpkFLAF2IGTN2je
         n/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909909; x=1757514709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xK1Ixt22UPQpRV6eJF15nySq1ENYn93GAeXzGVGJzQ=;
        b=wEyDZH9UZjJxatnLnjS71SOZdHBGCsHvXWPxDkCiJlQjc0tP9ZsecFKSVcDaq7j6gW
         zy1K6gStsdjUvJLJWrHFVFXq4sW/U3stOWXOxFQPa+NOcA55zJy6o63Vad19Ms8OX6Uq
         Wfm31raKb1SviKvrV0Dt3EOyb88zUE3g1atPqraQB0Jt6fqyewWzQSk7qVNolOSC+SN9
         VM4xMhTMQhoPxiqCl93Ti3UIK3X6niMPdu+SLGY4Ls/VLe1Oz/goInYjg5fQjjwiUDUX
         dV0FSQhsNSZHbrB1+hPEnF3JkKkpt973ZJ8RvHrXJb2IzmfElJV7UGZ7IBRgA8GKE5A+
         XJXw==
X-Forwarded-Encrypted: i=1; AJvYcCWPF2REOcTHPD56qQgx5Fce4b9xAKb8fI5jZ9ML8yvS+ReEIqLthztx24ocFEHNhFnrwirTeAqeVh3OSQngIBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJqOPWhdfORv1qI5GrKlPmtXphelMLMFXPw7GEAJajxWpTFqQ
	1icnd3QLuKmhsqNSOKbdQCSBv0wVU2WWC71YLotYZHQzCBkSdK9zaPEEsDMQYm8Pj8ZKMsDsw9l
	BHeP84zTSbgXNqD+b15hxQdEcaLE+MX0PEceSttLiIQ==
X-Gm-Gg: ASbGncs8J0/AT4OGktcAUaD9JwLdTE3f+K4RouPLHPG7mWlNtNIYnfATP6oOgnNUFCT
	QZBuZj/MTvj/FOts2dwXJyoM7Y09ys6fOghik/8pHmLVKAP4A570lLCFAkhqEoFJlzSxfZ+ssNW
	ixjIAKVh40BLognO5F/CZTeBt9jYrBE69hzisMPdEJ3pR35YIjWuM2QYjDEeswMvPW3WRRU/Hgh
	lwc4mmJNg9A6wygvUUbtw/NfQd2RIu68Yz+u8u5lJ9psYncqxq8s8Shw8fjsQ==
X-Google-Smtp-Source: AGHT+IEdqptgFgnh5uv2GzzQGJFqAZUOszFTkmnyBR24wl/TgHUrHJeCtE9hinNDxe7tcZMD8cJExtpH41CpN+afzKw=
X-Received: by 2002:a92:ca4a:0:b0:3f2:1a77:4876 with SMTP id
 e9e14a558f8ab-3f4024cb129mr260307905ab.26.1756909909294; Wed, 03 Sep 2025
 07:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756710918.git.dayss1224@gmail.com>
In-Reply-To: <cover.1756710918.git.dayss1224@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Sep 2025 20:01:37 +0530
X-Gm-Features: Ac12FXwG5rgdOIo0vaX3JEvtxdbhO8ebAqv0PdEvBcoUhtsHNdiKMQlA4BgxMFY
Message-ID: <CAAhSdy0DriNa-90QO_YgUbuxrjkDSQ_iTtNVG5ie0h09y2xSHA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] KVM: riscv: selftests: Enable supported test cases
To: dayss1224@gmail.com
Cc: pbonzini@redhat.com, shuah@kernel.org, atish.patra@linux.dev, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 1:06=E2=80=AFPM <dayss1224@gmail.com> wrote:
>
> From: Dong Yang <dayss1224@gmail.com>
>
> Add supported KVM test cases and fix the compilation dependencies.
> ---
> Changes in v3:
> - Reorder patches to fix build dependencies
> - Sort common supported test cases alphabetically
> - Move ucall_common.h include from common header to specific source files
>
> Changes in v2:
> - Delete some repeat KVM test cases on riscv
> - Add missing headers to fix the build for new RISC-V KVM selftests
>
> Dong Yang (1):
>   KVM: riscv: selftests: Add missing headers for new testcases
>
> Quan Zhou (2):
>   KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
>     `rseq-riscv.h`
>   KVM: riscv: selftests: Add common supported test cases

Queued this series for Linux-6.18

Thanks,
Anup

