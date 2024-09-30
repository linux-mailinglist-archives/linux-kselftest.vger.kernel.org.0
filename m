Return-Path: <linux-kselftest+bounces-18623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E513398A2A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF651F22515
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94518E346;
	Mon, 30 Sep 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW+nPumG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583F18B471;
	Mon, 30 Sep 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699832; cv=none; b=eYHGks0thzjUmW47iK//ARN0MxcJczUXUXOsZ6CQyJgmqe5SYgXdTgXwioDoKGBCwp776MakNUPfGXTjjMR3ZwTvk8DKEc3m4Qcbl4skSB4Z2Rh2vsNJbxBiCwJ7nzLb1GB/1i4SO2lzaR3+3azEEPl5iFDsagHnWvH09HClcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699832; c=relaxed/simple;
	bh=MJaOvXfdttvUO377io9iCjqOjrH77uQ9NNVSuKdVv38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XU8nc8pPUMOX3DN/V3ezzXHDcLVAoz8KiTV3ZJij2DRJu4//oOvKJIzZi6iNz4MJts6P58CSO1UGaa0M4JQLmkp0qgIVFKPF9fA/b60LzVNHyM0WZiguQj2sUkm8F7LdprvomrQnJixVGd6QhqT1JTH+VYj3E32W/ZB40KpmanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW+nPumG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so38164755e9.1;
        Mon, 30 Sep 2024 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699829; x=1728304629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/SrlIJXoXLKGiLt5PvQw/mV4o2zsSYJUePPb/Z+Dd8=;
        b=JW+nPumG6NXI0/7Qqmt187JOQD9L/9ckcteZnKqYxZlWsRjGDY5rsz3G1D/2vm3C/t
         t9k38FclDEbilr6aoB4Jtnb0kAW2hyfEVcN5xUa81HjQYgcbaUX+7STlqJ7ZbqskxrdN
         uhReoraD2NCQbBd1iEgYK2BCy7Y9FtYfc6FZ+nVUySKfWvkgIBquuUGviEUOYT1K4NGr
         w8KEVQqYGzJ9vm+0c2yxZ8O43U8w1yIkG9ixpIPDf0JYt97fYB7zfPncCg5HXgSE1B+t
         e2ByfbDfB7AxMBZbWt0+jqFRhMYMtqPHYBKzvk3i0ZoxFv3VOOA8Qi3ThKlT6tJI5KyZ
         Krbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699829; x=1728304629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/SrlIJXoXLKGiLt5PvQw/mV4o2zsSYJUePPb/Z+Dd8=;
        b=Q8D26OyWF62qJ/KMbdC62FxlgB6mmBXFqoYv8tfSkfrD4W7j7UE+GUE7WUVuEq7lTm
         DGCM+vMxyzTxpomVB2qsT5Rro6/i2vVqI4lckOzjZonG0ypfzm1Va+QtzWy5sYTvkoA+
         ejkRmmAhoQJw6NZfcws9m7UCROtgNM62Dw437ESHQi9fwjU+H7ekakKnsZp7RCkU/K6C
         jVxHXNcZuCYvgBkGUGzG7BYRN+XxnSSJrQkSKLJ3qyJpDOgUmNO9Lz1U/MhmiKVjf1KI
         6/N4xvsK2lugKdOxYgYiXgT5sFrdSay56F4OMpHkOJB+fAa/OsCrSniRyZs8Us0lDWrn
         Ea+A==
X-Forwarded-Encrypted: i=1; AJvYcCUIy4REHP/nOTwX/yFkg33O6mfvcMxil0Ys02a2YXD/Z7Wr3lSFgwWmfKF9X/bBVPIPy9E0oD/gCiHrfGk=@vger.kernel.org, AJvYcCUvu4o7wmgFXOiQ+P0dy1sHNpfkG5+oyOpFatirZC5GwV3J/m8X5JD/RcutJFnV5GcsjChhdaaR+MAMHg==@vger.kernel.org, AJvYcCV/LgoDHrUWVpdQvNxrtX7Q/FIINae3xlojD69ohqPH4jAWSfvcI3T9oJj8WrpBCEuxPYQ=@vger.kernel.org, AJvYcCWI51m03v5deYDGe+WwvtK1lzcuisNsuBQfhSY58HRxS1TJiJa7tuWHlJRYbj5ekU2HbYbTkts5OvCOQBLHw3w0@vger.kernel.org, AJvYcCXVVJmqhaQQ5LfOfYti03HDpl/zXfhOiK/n4CFJaerfwo38EcDrC9CsGt+hgtY3HInKKmUJAPSuAhJR3takHg==@vger.kernel.org, AJvYcCXYDRPynMAb99FbuxYsXG9y3jdfhMkx9UfAYpmvT5KYKMPRw2aGsglJq0UxPU+NSMcaUfpaJ4DXg6920fa3@vger.kernel.org, AJvYcCXdjuCSmHDQ5cofnsGzWUSk79b/i7cNf0Q7nPKPgXx/YGEnq4jO6uFAmKMbsvSoN1MCoJQDwQOk38Ec5JH0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7Si0iYu5GS3fTyiAXO/uLRgAGlorqD6BsiEGWDLuOgtbqh8C
	06cahLJdvTc8YVKvEEf6hQpz6OUAmVxvcye5lTXm8FggBaik4CGT
X-Google-Smtp-Source: AGHT+IF/2i/VrNcu+rhudxHU7EwUt1cUgREAQFrWqhKqroWgeyt01AtDZZ3Ml2SacGAQnu+k2Q1CzQ==
X-Received: by 2002:a05:600c:5251:b0:42c:b8cc:205a with SMTP id 5b1f17b1804b1-42f58491029mr88602375e9.32.1727699828718;
        Mon, 30 Sep 2024 05:37:08 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:07 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v3 00/19] random: Resolve circular include dependency and include <linux/percpu.h> 
Date: Mon, 30 Sep 2024 14:33:11 +0200
Message-ID: <20240930123702.803617-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
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
removes the inclusion of <linux/percpu.h>.

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

We would like to include <linux/percpu.h> in <linux/prandom.h>.
In [1] we would like to repurpose __percpu tag as a named address space
qualifier, where __percpu macro uses defines from <linux/percpu.h>.

The major roadblock to inclusion of <linux/percpu.h> is the above
mentioned legacy inclusion of <linux/prandom.h> in <linux/random.h> that
causes circular include dependency that prevents <linux/percpu.h>
inclusion.

This patch series is the "nice cleanup" part that:

a) Substitutes the inclusion of <linux/random.h> with the
inclusion of <linux/prandom.h> where needed (patches 1 - 17).

b) Removes legacy inclusion of <linux/prandom.h> from
<linux/random.h> (patch 18).

c) Includes <linux/percpu.h> in <linux/prandom.h> (patch 19).

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
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
v2: - Reword commit messages to mention the removal of legacy inclusion
      of <linux/prandom.h> from <linux/random.h>
    - Add missing substitution in crypto/testmgr.c
      (reported by kernel test robot)
    - Add Acked-by: tags.
v3: - Update to linux 6.12rc1.
    - Add more Acked-by: tags.

Uros Bizjak (19):
  x86/kaslr: Include <linux/prandom.h> instead of <linux/random.h>
  crypto: testmgr: Include <linux/prandom.h> instead of <linux/random.h>
  drm/i915/selftests: Include <linux/prandom.h> instead of
    <linux/random.h>
  drm/lib: Include <linux/prandom.h> instead of <linux/random.h>
  media: vivid: Include <linux/prandom.h> in vivid-vid-cap.c
  mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
  fscrypt: Include <linux/once.h> in fs/crypto/keyring.c
  scsi: libfcoe: Include <linux/prandom.h> instead of <linux/random.h>
  bpf: Include <linux/prandom.h> instead of <linux/random.h>
  lib/interval_tree_test.c: Include <linux/prandom.h> instead of
    <linux/random.h>
  kunit: string-stream-test: Include <linux/prandom.h>
  random32: Include <linux/prandom.h> instead of <linux/random.h>
  lib/rbtree-test: Include <linux/prandom.h> instead of <linux/random.h>
  bpf/tests: Include <linux/prandom.h> instead of <linux/random.h>
  lib/test_parman: Include <linux/prandom.h> instead of <linux/random.h>
  lib/test_scanf: Include <linux/prandom.h> instead of <linux/random.h>
  netem: Include <linux/prandom.h> in sch_netem.c
  random: Do not include <linux/prandom.h> in <linux/random.h>
  prandom: Include <linux/percpu.h> in <linux/prandom.h>

 arch/x86/mm/kaslr.c                              | 2 +-
 crypto/testmgr.c                                 | 2 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c        | 2 +-
 drivers/gpu/drm/i915/selftests/i915_random.h     | 2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c     | 2 +-
 drivers/gpu/drm/lib/drm_random.h                 | 2 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 1 +
 drivers/mtd/tests/oobtest.c                      | 2 +-
 drivers/mtd/tests/pagetest.c                     | 2 +-
 drivers/mtd/tests/subpagetest.c                  | 2 +-
 fs/crypto/keyring.c                              | 1 +
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
 23 files changed, 22 insertions(+), 24 deletions(-)

-- 
2.46.2


