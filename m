Return-Path: <linux-kselftest+bounces-17221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A096D834
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB8C28BC16
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E1D19AD8E;
	Thu,  5 Sep 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdLWvl0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C019995A;
	Thu,  5 Sep 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538831; cv=none; b=hHHg11C/xH26xPjEFtAgeiyarM2Aoizu0b/Mon9j7TiGMEN5VO1LwBesjoEyynPGBHhX97ULj4lI/Ypy5MA6HzQOC7hbRViuQLwggK6iR7VJA7isBpaelI6Huq0siKtoRFXsCx4sAoHt1ldtxUH3pXOF53nxNSjxO23jTiZNvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538831; c=relaxed/simple;
	bh=k3d5+rFgYAJki2pkwsH+WHyHFP4ovjkew9/QpqQfEss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4NE2GFkbT1mS3TsJ6cQmdJAdUQF/N6A8LP/Ma7HCwqyzQAEhyA7roE2dnsXbfSQY0d382B2dBhHKPv9TTZblf0K7eKXTDT4CK2x8dy6WFD0x+HlJgeoKBxzIv62mdpLyceR16aiyoPGqSap7muBWzWcXTvJ5XCpZkvrddlFMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdLWvl0m; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42c828c8863so5790195e9.3;
        Thu, 05 Sep 2024 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538827; x=1726143627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/jh7PZokx9IFNSzbVHcZfaNGnzkrP5bD95SXRchUZc=;
        b=jdLWvl0mvdR9Jvoq0INa17/90TGOp18AC28xjTOr58sKF2qRxZoeS/6d7pGCT2LauO
         xiviKm0EBUEqljVZPQgwsXlZVTlhJAj4R/AvKAAjniuFpdM6ikuZTIR/xAD5si0DXH6Y
         3onRPp8jq3F7EtgjmWZ/t551BH/1Z5EmRxO5CFDz5EeVkH5TUXSB85cJ42tjR30PwhP1
         rOJ8qlmWHIuHygSV9VztWMoSGYUCZgyc/Adq7xrXv2GD08qx5qrv+DKtZn81MXWPL4Qc
         LaPOORanRclL33CX7VXTt4rqNkFzwB049Rt18CMExzpYF/qQug3FmcYeacZKwmasFmxZ
         lt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538827; x=1726143627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/jh7PZokx9IFNSzbVHcZfaNGnzkrP5bD95SXRchUZc=;
        b=aHrBp3ub+CkcqX5w/FYlI717uUZLNjIf4IlwI9U0H3skyCd5woiZxtFoDDgepe9qj/
         MwQVfOKdtjDFYUFeag/IW1zCB6PqjRwgoFFYUKe4GbbouKVjNMAuVpOY6ub2TKT0mZT7
         +yzmI4dij21yWbeyEJn9F0ETWA2e+pQmg/Nk8WH4aWBvxv27ntys252nMsxN68Ool4BH
         meOa25eGyne/0Jsp3IbZfLPtgwnZCML/kHIWH1KsC+CfCitCdrgF8uoFmGymctkAHKFA
         4OmdylYj4wODaf3zNXrQvLUaDnhSx00bbssjEbSK2RsNp55zUMz837UHhnO8fAP36O7Y
         ZPZg==
X-Forwarded-Encrypted: i=1; AJvYcCU5cZ12ln2I+LnLTK7lh+ne3s+39JqB0UF3FxtCrt36nlbITL+mA8qya3+4AO5tZpXoqENOPbNXCocieA==@vger.kernel.org, AJvYcCUlIV1f0OoL6+UBZ1mmCkJ1HZo2AErjapf/uhzLCEouP6lSiIsYIsLuMpyeurU2A5XnhOGzE+ExOmzVCbA=@vger.kernel.org, AJvYcCUt+vt+mcfltrNIII6v3puh1Inn8TSDKODafb+3p8mZmh26WPykmb6c61139fwHXoJ1bUbjpQbFwJZ352YqpQF1@vger.kernel.org, AJvYcCV+cdUmmy5Q7EZwiUxtKFq4eWjmPJCfDcnPCbaZZXIMFIA9YREUFvGgR0AkeWopbVu11aNlGe7Jd0xiU1CMFw==@vger.kernel.org, AJvYcCXafJUJeimifN0VZYW8TGiCXAY1bjaG6MvGdtPisgvJOvD26BwzybmbJc0q4yHl8umkhuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRbmANjN48dlOAD/ThK1XlW0kW/VpM920Pbl5ymlpZQ/oeRQR
	NR/ETZ2KuVTUVrikWoaJ8Ce6xEa7lCkumTizYjOsCMgfygKLpGVTY55SMJlXmIo=
X-Google-Smtp-Source: AGHT+IGWPyCho2CwtU7ltqrAmM8Ihsxd2i3XPne6K7qzyDA9oAvQKOeAenEfeGB2Pd/DmOGVTlsXwA==
X-Received: by 2002:a05:600c:4eca:b0:426:5471:156a with SMTP id 5b1f17b1804b1-42bdc6334cbmr128537975e9.13.1725538826233;
        Thu, 05 Sep 2024 05:20:26 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:25 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH 00/18] random: Include <linux/percpu.h> and resolve circular include dependency
Date: Thu,  5 Sep 2024 14:17:08 +0200
Message-ID: <20240905122020.872466-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were several attempts to resolve circular include dependency
after the addition of percpu.h: 1c9df907da83 ("random: fix circular
include dependency on arm64 after addition of percpu.h"), c0842fbc1b18
("random32: move the pseudo-random 32-bit definitions to prandom.h") and
finally d9f29deb7fe8 ("prandom: Remove unused include") that completely
removes inclusion of <linux/percpu.h>.

Due to legacy reasons, <linux/random.h> includes <linux/prandom.h>, but
with the commit entry remark:

--quote--
A further cleanup step would be to remove this from <linux/random.h>
entirely, and make people who use the prandom infrastructure include
just the new header file.  That's a bit of a churn patch, but grepping
for "prandom_" and "next_pseudo_random32" "struct rnd_state" should
catch most users.

But it turns out that that nice cleanup step is fairly painful, because
a _lot_ of code currently seems to depend on the implicit include of
<linux/random.h>, which can currently come in a lot of ways, including
such fairly core headfers as <linux/net.h>.

So the "nice cleanup" part may or may never happen.
--/quote--

__percpu tag is currently defined in include/linux/compiler_types.h,
so there is no direct need for the inclusion of <linux/percpu.h>.
However, in [1] we would like to repurpose __percpu tag as a named
address space qualifier, where __percpu macro uses defines from
<linux/percpu.h>.

This patch series is the "nice cleanup" part, and allows us to finally
include <linux/percpu.h> in prandom.h.

The whole series was tested by compiling the kernel for x86_64 allconfig
and some popular architectures, namely arm64 defconfig, powerpc defconfig
and loongarch defconfig.

[1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.com/

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: linux-fscrypt@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com

Uros Bizjak (18):
  x86/kaslr: Include <linux/prandom.h> instead of <linux/random.h>
  drm/i915/selftests: Include <linux/prandom.h> instead of
    <linux/random.h>
  drm/lib: Include <linux/prandom.h> instead of <linux/random.h>
  media: vivid: Include <linux/prandom.h> in vivid-vid-cap.c
  mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
  fscrypt: Include <linux/prandom.h> instead of <linux/random.h>
  scsi: libfcoe: Include <linux/prandom.h> instead of <linux/random.h>
  bpf: Include <linux/prandom.h> instead of <linux/random.h>
  lib/interval_tree_test.c: Include <linux/prandom.h> instead of
    <linux/random.h>
  kunit: string-stream-test: Include <linux/prandom.h> instead of
    <linux/random.h>
  random32: Include <linux/prandom.h> instead of <linux/random.h>
  lib/rbtree-test: Include <linux/prandom.h> instead of <linux/random.h>
  bpf/tests: Include <linux/prandom.h> instead of <linux/random.h>
  lib/test_parman: Include <linux/prandom.h> instead of <linux/random.h>
  lib/test_scanf: Include <linux/prandom.h> instead of <linux/random.h>
  netem: Include <linux/prandom.h> in sch_netem.c
  random: Do not include <linux/prandom.h>
  prandom: Include <linux/percpu.h>

 arch/x86/mm/kaslr.c                              | 2 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c        | 2 +-
 drivers/gpu/drm/i915/selftests/i915_random.h     | 2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c     | 2 +-
 drivers/gpu/drm/lib/drm_random.h                 | 2 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 1 +
 drivers/mtd/tests/oobtest.c                      | 2 +-
 drivers/mtd/tests/pagetest.c                     | 2 +-
 drivers/mtd/tests/subpagetest.c                  | 2 +-
 fs/crypto/keyring.c                              | 2 +-
 include/linux/prandom.h                          | 1 +
 include/linux/random.h                           | 7 -------
 include/scsi/libfcoe.h                           | 2 +-
 kernel/bpf/core.c                                | 2 +-
 lib/interval_tree_test.c                         | 2 +-
 lib/kunit/string-stream-test.c                   | 1 +
 lib/random32.c                                   | 2 +-
 lib/rbtree_test.c                                | 2 +-
 lib/test_bpf.c                                   | 2 +-
 lib/test_parman.c                                | 2 +-
 lib/test_scanf.c                                 | 2 +-
 net/sched/sch_netem.c                            | 1 +
 22 files changed, 21 insertions(+), 24 deletions(-)

-- 
2.46.0


