Return-Path: <linux-kselftest+bounces-11928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C8908B61
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F9C1C24EB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE6D19307D;
	Fri, 14 Jun 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixvY7Wjv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570F196C8C;
	Fri, 14 Jun 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367305; cv=none; b=piFCv3DIF3Sx7mKBz+SFxCY9ccex1iQAwxmUhsGW/Slz1NW2eZC45OdKdH42zLKLyB383vyx7uvYbzs/ompmPXcBDO2ZT0zi3+u4J+kwPas5fNcx3LubKVjoNt9Fw4EXjOE6pBvlvFNtT/StVhaSzA1VinBD4NaJ2OF+3sOeayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367305; c=relaxed/simple;
	bh=bT5WI50G/xe0b9CL3tlQRNjDOMccYX8o9ugjNQ5PcwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrjXGUTZBY5Hq9RT2lwjIcMoyCPjoCdkte/FJ+cUlekIfoA35yTKxQn3Ond6wYIyNcEszbebWQLtQeVXRRoPHLF2ToDKKrAfR9P7yrEk+yHblGxdCg/+qF7YYUtUEzkjPHk2heDowBQxCs1tev4mh4Z3NL3PhJaQMiNB0HFryOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixvY7Wjv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so2353090e87.3;
        Fri, 14 Jun 2024 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718367302; x=1718972102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX4EUljvFqSnOBU+TT5aydICyOEMY1+G4VpnprRU4mo=;
        b=ixvY7Wjvo+JRCsKZOekovmhZCFjorh12H2mKuVGDlOBio0InJbF+hykfRY/hMUXHUO
         6FJ0At5misQLneZuFXGePgtXViKKJ8vgd3RSclYl2/DttTTOLDDvHmG+qNsY7VGZi3fh
         l8h86QimKV72zSFFf7EGlvWDdTIXJs9SbeXseVQ8/U8asAc388y1b6XzBBtLHpLOgMjD
         tRakEpCFjwe28BZUTVs9CwTnxRM2G269tWY8mrvs11196b4JNHrnfvlbGaC08zmwFGOo
         C+J5ptNEeJdnFsvRgQIniYHAWzTMcqtIRhiv94rUGfXFDXCa5xMqnXdW/Hbe9vY2dQdo
         ICWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367302; x=1718972102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX4EUljvFqSnOBU+TT5aydICyOEMY1+G4VpnprRU4mo=;
        b=DcyYNNF9fSL9EdJQUt0yYgB9itR4iECzQ8DkqYu/sSkuWvssothuMSG9rL11JZEawX
         S5ZoevPtmQmz8oiD13p5EqUMRQUUSl7V8qZZb7QMx7sInopj2LJ6FJ1F8MKjqbpGcRil
         A0JvWntJZzTxp/0KJjHBanu/MggqBmYyVaNCMWhxR//LNSJVg1IFhO1963HqzgWIyBSu
         aBFdQc1NNAe2K6fHmyXLl+ZeBHqARrMN+Ir8MZKcePcmv/R+NUu/Ovhk9iRCYKK9/NcD
         1FRVCfBxp8BSBsyxqgItSpwnmuNbKEkJapFnddr4aHMGP2AiOgIcJRmO3KEjySNtU6Er
         PD/w==
X-Forwarded-Encrypted: i=1; AJvYcCWKXz5mWFh/PYN4dnycE80RHyeniqE/7T+5HiNalSiTfP08KmuboMoys1/mYdl0+L0jEwZJfUotM8dY7hHZnGEwSvjzptnV0qG7wWyowedY
X-Gm-Message-State: AOJu0Yx9NuaXdGZLDiX5LVce/X8ExUJHBYdym3rtVHdvEw6NbEU/Pnwd
	KJtw5NC52UGxGGgV950YUOKv6Wtsp2Esm++Y3ZlzLrDHu/TuZYpp8Y0HGi4IzVI9Ul358A+35by
	6U72e0PkqZXBZYzyKpp7NSjqltfo=
X-Google-Smtp-Source: AGHT+IEnSljkcDo4Wfe0Fr61DdCGe1zBjBWU2kejP8zs+dh2KgULXRKoka6ALHY8M0+zg9FByfz4kXlhX6OCrrwltRI=
X-Received: by 2002:ac2:4181:0:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-52ca6e99397mr1518697e87.58.1718367301474; Fri, 14 Jun 2024
 05:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYveCjzej3SDZR=PBASc=ycdL7xvWENonYCOXCjRJe8+oQ@mail.gmail.com>
In-Reply-To: <CA+G9fYveCjzej3SDZR=PBASc=ycdL7xvWENonYCOXCjRJe8+oQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 14 Jun 2024 14:14:50 +0200
Message-ID: <CANk7y0hEQVTRTZWCJiC8d8pmQVy7fvdL_qQM_Sa__YuBa-5s=A@mail.gmail.com>
Subject: Re: selftests: ftrace: WARNING: at arch/arm64/kernel/stacktrace.c:112 arch_stack_walk
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Nianyao Tang <tangnianyao@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Puranjay Mohan <puranjay@kernel.org>, 
	James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

Thanks for finding this.

On Thu, Jun 13, 2024 at 3:16=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> The following kernel warning noticed on arm64 qemu-arm64 and rk3399-rock-=
pi-4
> device while running selftests ftrace tests on Linux next-20240613.
>
> This is always reproducible on qemu-arm64 and rock-pi-4 device with
> kselftest merge configs
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Test log:
> -------
> kselftest: Running tests in ftrace
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: ftrace: ftracetest-ktap
> # unlink: cannot unlink
> '/opt/kselftests/default-in-kernel/ftrace/logs/latest': No such file
> or directory
> # TAP version 13
> # 1..141
> # ok 1 Basic trace file check
> <4>[   96.183553] ------------[ cut here ]------------
> <4>[ 96.187100] WARNING: CPU: 1 PID: 538 at
> arch/arm64/kernel/stacktrace.c:112 arch_stack_walk


29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()") made
the ftrace_graph_ret_addr() use the
'idx' pointer to optimise the stack unwinding but arm64, riscv, and
some other architectures pass `NULL` for this
parameter. The fix for this is to pass a valid pointer to
ftrace_graph_ret_addr() like x86_64 is doing.

I will send a patch to fix this unless someone else has already sent one.

Thanks,
Puranjay

