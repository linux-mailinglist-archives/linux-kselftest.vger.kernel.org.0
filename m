Return-Path: <linux-kselftest+bounces-11855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1A90735F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB81B25934
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D014430C;
	Thu, 13 Jun 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTqqxGE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8D142E80
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284564; cv=none; b=hGewwnxQ/rdYjZuB0dAVob/ttGOygzi90E7Uf5ngrEHjhHSg0xcGktbj22ujkPREIffoZVVxuRSoWDpEjAi1vOxGdd6PrOTbeX0PYyaniI1w9XivV9+070jnELICtLrLA1fFPNUT+Fe3plMOwwumQ3iLTf/3OIydrceGCZHNn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284564; c=relaxed/simple;
	bh=V1MODXg2FeVlGh8cU9j9/KuGFRIBbgRDLnpu/K0rcBE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=f5k5Oon+SmBcNzeg/8hkFA6DpLXCyUkhRGynLohmEwaKKP1FeBVUM6qQ/ZjfUJOLfO753mWqChnUJLqpJoYvZPOFrvY0iunl1COqf0DSDKx8kQbBa8z1YFZiAiNVq8mQD5YwiTW5QZMfITSb8c+VBg34upovOiChb7LFcF/Q5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTqqxGE2; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80b86cd882cso316381241.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718284561; x=1718889361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=61ouTCt8HWN0ZdDws0+ptI7BCpGd4+Hs5oquQFyzwjk=;
        b=RTqqxGE2s0C6Rh2eSJivNJPgvREBaGPgTPqX0f/FfDXS8VC7dCKnlOOdi7ecPHGUuR
         cAE8QhQhsbWp7F02O3v/qhivt5bxsZhzKByveW6sPysDKhw9mp8adFUyI299lyTprIUv
         y265voJHnkR0ZGfm8oH+COhE3gyrNuOjl0BDHvElmJIEQHVNzECkgmJQWH1gUEdi3D+Q
         0xO7tDQ2eGbeKQL+41cOg/udJvI/q5NKsmn6rov8tnXeFK2ujsYNjNyYgXA9zX6peqqo
         +tTOW4aV7LBDvF7Iuh54a9r08lLIxWZ4QIkxTyRBhgKz0mb7ciW1zrhrF8nHmP7XvYaY
         r3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284561; x=1718889361;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61ouTCt8HWN0ZdDws0+ptI7BCpGd4+Hs5oquQFyzwjk=;
        b=cxT3BYuCTEkdoMl+sAEQOcH1VGXDYRUlZkwdAPSUlQQuvpNRMtfDgQgmxgD5cjFjk4
         Oiox4Uq/P4bDflNnPOlVOJT576pOWU677TrXesUuCf802UKBP2kHXWVCFOUlDex/1dfc
         CP2Xg8G8XuYxBga6+J1PcJe9L43SQ+me1KPj95wc0BUsZxCzPVDRV3PYUcQJhKMaKheR
         VfLVApZf6HTpwjdgMDoyl2Cul9yYQMzPBGHFrhx6G6nkNYXZX13VTe9I+uLA0dwjbIcf
         Qr42ikuAf0QmX43Wib+YKgCwUEThNwCOc3JSdNfVkcF6uIJjgFoi/6ASWbCpE3guOB//
         Pmpw==
X-Forwarded-Encrypted: i=1; AJvYcCXAwRCv7mnkjDS3gLWJ8NwsvEwHY7Jjtc6+V+xB7DZ0gwR2AVppEzXFTinRW9oZtP0lHlFnToQFP8UJUUV++f2kP1cpHYxgAoPVDv1eK9Lz
X-Gm-Message-State: AOJu0Ywq/XUEeiyhb8Eb2LJvOdP3KpfLdk7NzEM0QDj4VRfogJPyaA8p
	L66jrPB5/FCdZE3EtfxMk0X+AKjyOY0SmUjVVesgR2d8i/xKDm2Qz7GEFTBXyDnd13DSu7+QW6D
	K5hGDMV8GQJQalQRYjUvO7rGHuS8hPRn1ik3X0Q==
X-Google-Smtp-Source: AGHT+IHv07AcEdT7ldaMS72kgcQ+CTnBQHmRnZDjUaiVpeh19fhu7+o9thMU27bhoaNTxcsaw8QJ+jw+l4h61EPdyUY=
X-Received: by 2002:a1f:e4c2:0:b0:4ed:f1:e0b7 with SMTP id 71dfb90a1353d-4ed07aad6a4mr4561204e0c.2.1718284560997;
 Thu, 13 Jun 2024 06:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 18:45:49 +0530
Message-ID: <CA+G9fYveCjzej3SDZR=PBASc=ycdL7xvWENonYCOXCjRJe8+oQ@mail.gmail.com>
Subject: selftests: ftrace: WARNING: at arch/arm64/kernel/stacktrace.c:112 arch_stack_walk
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Nianyao Tang <tangnianyao@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <swboyd@chromium.org>, 
	Puranjay Mohan <puranjay@kernel.org>, James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel warning noticed on arm64 qemu-arm64 and rk3399-rock-pi-4
device while running selftests ftrace tests on Linux next-20240613.

This is always reproducible on qemu-arm64 and rock-pi-4 device with
kselftest merge configs

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
-------
kselftest: Running tests in ftrace
TAP version 13
1..1
# timeout set to 0
# selftests: ftrace: ftracetest-ktap
# unlink: cannot unlink
'/opt/kselftests/default-in-kernel/ftrace/logs/latest': No such file
or directory
# TAP version 13
# 1..141
# ok 1 Basic trace file check
<4>[   96.183553] ------------[ cut here ]------------
<4>[ 96.187100] WARNING: CPU: 1 PID: 538 at
arch/arm64/kernel/stacktrace.c:112 arch_stack_walk
(arch/arm64/kernel/stacktrace.c:112 (discriminator 1)
arch/arm64/kernel/stacktrace.c:155 (discriminator 1)
arch/arm64/kernel/stacktrace.c:172 (discriminator 1)
arch/arm64/kernel/stacktrace.c:243 (discriminator 1)
arch/arm64/kernel/stacktrace.c:267 (discriminator 1))
<4>[   96.188005] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables
<4>[   96.189034] CPU: 1 PID: 538 Comm: ftracetest Not tainted
6.10.0-rc3-next-20240613 #1
<4>[   96.189183] Hardware name: linux,dummy-virt (DT)
<4>[   96.189366] pstate: 624000c9 (nZCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[ 96.189529] pc : arch_stack_walk
(arch/arm64/kernel/stacktrace.c:112 (discriminator 1)
arch/arm64/kernel/stacktrace.c:155 (discriminator 1)
arch/arm64/kernel/stacktrace.c:172 (discriminator 1)
arch/arm64/kernel/stacktrace.c:243 (discriminator 1)
arch/arm64/kernel/stacktrace.c:267 (discriminator 1))
<4>[ 96.189562] lr : arch_stack_walk
(arch/arm64/kernel/stacktrace.c:109 arch/arm64/kernel/stacktrace.c:155
arch/arm64/kernel/stacktrace.c:172 arch/arm64/kernel/stacktrace.c:243
arch/arm64/kernel/stacktrace.c:267)
<4>[   96.189593] sp : ffff80008000bdf0
<4>[   96.189610] x29: ffff80008000be80 x28: ffff9969bab84000 x27:
ffff9969b9c53b98
<4>[   96.189702] x26: ffff9969bb6a60c0 x25: ffff9969b9c53b98 x24:
0000000082000000
<4>[   96.189775] x23: 65cf9969b8823ddc x22: ffff9969b882e518 x21:
ffff9969b8836200
<4>[   96.189809] x20: ffff80008000bec8 x19: ffff9969b8823d70 x18:
0000000002000000
<4>[   96.189842] x17: 0000000000000000 x16: ffff800080008000 x15:
00001e8480000000
<4>[   96.189876] x14: 000000000003d090 x13: 0000000000000000 x12:
003d090000000000
<4>[   96.189910] x11: ffff9969bb764150 x10: ffff80008000bf30 x9 :
ffff9969b88b2970
<4>[   96.189958] x8 : ffff9969b882e518 x7 : 0000000000000000 x6 :
0000000000000023
<4>[   96.189990] x5 : 0000000000000000 x4 : ffff80008000bf30 x3 :
ffff80008000bfe0
<4>[   96.190021] x2 : ffff9969b882e518 x1 : ffff9969b882e518 x0 :
ffff9969b882e518
<4>[   96.190145] Call trace:
<4>[ 96.190196] arch_stack_walk (arch/arm64/kernel/stacktrace.c:112
(discriminator 1) arch/arm64/kernel/stacktrace.c:155 (discriminator 1)
arch/arm64/kernel/stacktrace.c:172 (discriminator 1)
arch/arm64/kernel/stacktrace.c:243 (discriminator 1)
arch/arm64/kernel/stacktrace.c:267 (discriminator 1))
<4>[ 96.190269] return_address (arch/arm64/kernel/return_address.c:45)
<4>[ 96.190335] trace_hardirqs_on (kernel/trace/trace_preemptirq.c:56
(discriminator 1))
<4>[ 96.190372] handle_softirqs (arch/arm64/include/asm/irqflags.h:26
arch/arm64/include/asm/irqflags.h:48 kernel/softirq.c:538)
<4>[   96.190744] ---[ end trace 0000000000000000 ]---
# ok 2 Basic test for tracers



metadata:
------
git_describe: next-20240613
git_ref: master
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: 6906a84c482f098d31486df8dc98cead21cce2d0
git_short_log: 6906a84c482f ("Add linux-next specific files for 20240613")
arch: arm and arm64
config: kselftest merge configs

Links:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240613/testrun/24304248/suite/log-parser-test/test/check-kernel-exception/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240613/testrun/24304248/suite/log-parser-test/tests/
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2hoMyyk19L9y5Hg3AT2V3yaedPU

Build reproduce:
--
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2hoMxP9HQelutO3feaEW1G9KhDz/tuxmake_reproducer.sh
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2hoMyyk19L9y5Hg3AT2V3yaedPU/reproducer

--
Linaro LKFT
https://lkft.linaro.org

