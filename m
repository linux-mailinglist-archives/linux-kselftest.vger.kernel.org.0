Return-Path: <linux-kselftest+bounces-47758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E96BCD2E24
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 12:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2D893001832
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD280305E21;
	Sat, 20 Dec 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH0aiJ6r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015842D6E66
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766230544; cv=none; b=ObjLS3W5klaiv7Qrhg/Ay08eeL3K0CzTzbxmZNGyCj27Km0fkLZ1ops7NLC7m6u4epzc0Y5Oap7BJkm9LVzZFLwesvYf44mvxvIBbfnoaa55mqRlu5IPrF8lfu9CR4ET4w8H34TazwRMREn29jSlUG4eI9dAaUbAMyaGBNvX8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766230544; c=relaxed/simple;
	bh=vXafQvDXbxhmRy9/A/k3bNzYbmfkT2tbUIk9/L+02a4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T/IKI2jQGbFNbf6OF4yg6yfUcfHnCH74MLtfNjg3fWGfnFUNm0aHK25GGGJogPPKEI9pNBAgp6hc8hmcfiqAgDDcH4kW8c3fumjb8albywibIiKS6IdkpVr/3rhFsaApSBSLQ8m8G0p8oDa3Cnc3vruUG69+QbHMaeuszyr15lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH0aiJ6r; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so2230977a91.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766230542; x=1766835342; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93uwlo3kvewJRRDvy0FK7OcjMcJRt550CMeXmSvT00w=;
        b=QH0aiJ6rsw4tZaqLi611WNvFwdPTnpjNztQcg7rEoSTvu6EsxoLesAfGFrNvil0RMz
         EmO5ffmErxTnZyQQ6bktByK0m07HhypRYfvDrOR6gVnYg7vHkHKvQyh0eLgxhMgmCUGK
         I9g1Ut6cIJN++C3YmtL9i2FepjfPCdmie+80lG8hGYMFxbeL9CUxSGiZOfauxPC3DYnJ
         0rUIAT7FeGuRqcdod6vV3nrZ88PZmbcqIqdMi+/NcJigqEVm+yaez+5UGoOYJy0aRpBf
         EFb1xhCQZG2H5DU5miBHlWvtl3h8+W5qDDbd+dM53qecTcAu5AkYRDGvoCWB8wvQpRwS
         OOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766230542; x=1766835342;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93uwlo3kvewJRRDvy0FK7OcjMcJRt550CMeXmSvT00w=;
        b=dWv68GPVfsn5lb7Yd8+aB9w5T3bU+XFRY3K4R3dZo6Qwys29DSzBoNuGX33/Qp0vny
         7mVBRkjY1K5l5wdxbT2AlNhnAFkWtAIoHAI1P8LaeKhlHxkAE7NLiDAeqbIJhNEsQ4kj
         mEt9jyabI3QtSOD5ih69zYgeLOrXzkjKGalZx28wzwtiXgB7Sm5UH+WJX/cNiayh7gSd
         O5bYp3Y+/uLfeNK9S5WJYI/w4VSbTcSdKJQ34TgiB4xSH4JfcEX2IkZEKKjMJP5YkO6J
         wDHsfS66ClrZ4hnD4hHHygW0KYhDjatC9i9XIS3Rvag4ASRq5vdzLgEnivPgySBLbuWU
         EYMw==
X-Forwarded-Encrypted: i=1; AJvYcCUCcSQOOgLUiqMvgW0tLsIjSb7iuV4e/hJ5FRVXwWSykkoiRT9JUlDWttFWKsQkD0IUTspzfV3w+vyS1vUpcDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZISmTDlrNPtomF5oETdVIHZnLqzQUGMi2H9e+FOmPmDSdpiT
	NBI704AisG/JisNJ9HV7DtbXrwutNmVV37MYwxudeUnLFTbS7DodvRoV
X-Gm-Gg: AY/fxX4ZjAxfNMIAU/j5KWcUgyW2NrR77eZ8sKHlzY2ebfw47odFtWQxoq2fvyCTfov
	soocE/T6oo4Bd91YKcsxnSaF82qSko4Q+DPMgkijxA7yAPpGq9stKLEPzbP7LiY/+LxrFYMjhxt
	m0/9XoBoCkOCGmX1xdnW9dAWXL7T38fRJyn6+mLvc9QDuwHX5fU9Wf5FO+IEywnPnoBA37Yg5Pn
	GIHza9cfBeqHP6v4ep+HwmStVqUcRDnR+oXNWlNSiKmYyJcWqr/Sp8LJEFzdKyaGKMNon+QBcee
	Kfz3+Q8NuWs7VKFfhRePhFE2uq6CND+uCsanYv8hzIMk/Mao8HbfAB5IAnfwlE776M3DXNK8hYD
	DDMtTuLnOEwhtku+Y9JKICEm22HwHOn7/ae6CqppwkBBK7cT/Itzj96ndMWD0kWwXbVqIXFzieB
	XjSMMJ03mj2aaeAoUaP68kUw==
X-Google-Smtp-Source: AGHT+IHZeSJ8DIPXHLFiAU6EtpaggaD6/tEfpVwHzU5oxuvR3r0N7paTuMWLmHBPXJh6SE6mjTO3lQ==
X-Received: by 2002:a17:90b:1e4b:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-34e921ad83fmr4533520a91.23.1766230541794;
        Sat, 20 Dec 2025 03:35:41 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d65653sm7799389a91.5.2025.12.20.03.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:35:41 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Subject: [RFC bpf PATCH 0/2] bpf: Fix memory access tags in helper
 prototypes
Date: Sat, 20 Dec 2025 19:35:03 +0800
Message-Id: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOeJRmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyMD3YzUnILUoviCovySfN20JLNUMxNDCyMTM3MloJaCotS0zAqwcdG
 xtbUANTIgfV4AAAA=
X-Change-ID: 20251220-helper_proto-fb6e64182467
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Zesen Liu <ftyghome@gmail.com>, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4329; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=vXafQvDXbxhmRy9/A/k3bNzYbmfkT2tbUIk9/L+02a4=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ6ZbF8vKqrWzJlu5nDi75d8B27tP6917sp8J9E9ntX6/1
 DdYx35uRykLgxgXg6yYIkvvD8O7KzPNjbfZLDgIM4eVCWQIAxenAEzkkRwjw6O7ro4bL03gj6sw
 i5i4SutYvzh38qXLsYEX3l7/8nXLBidGhs3zuFdpnAzhuNCcMOfUBsmnv8941xqVL53xl8Xw2eV
 wQQ4A
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Hi,

This series adds missing memory access tags (MEM_RDONLY or MEM_WRITE) to
several bpf helper function prototypes that use ARG_PTR_TO_MEM but lack the
correct type annotation.

Missing memory access tags in helper prototypes can lead to critical
correctness issues when the verifier tries to perform code optimization.
After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking"), the verifier relies on the memory access tags, rather than
treating all arguments in helper functions as potentially modifying the
pointed-to memory.

We have already seen several reports regarding this:

- commit ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's
   output buffer") adds MEM_WRITE to bpf_d_path;
- commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name
   args") adds MEM_WRITE to bpf_sysctl_get_name.

This series looks through all prototypes in the kernel and completes the
tags. In addition, this series also adds selftests for some of these
functions.

I marked the series as RFC since the introduced selftests are fragile and
ad hoc (similar to the previously added selftests). The original goal of
these tests is to reproduce the case where the verifier wrongly optimizes
reads after the helper function is called. However, triggering the error
often requires carefully designed code patterns. For example, I had to
explicitly use "if (xx != 0)" in my attached tests, because using memcmp
will not reproduce the issue. This makes the reproduction heavily dependent
on the verifier's internal optimization logic and clutters the selftests
with specific, unnatural patterns.

Some cases are also hard to trigger by selftests. For example, I couldn't
find a triggering pattern for bpf_read_branch_records, since the
execution of program seems to be messed up by wrong tags. For
bpf_skb_fib_lookup, I also failed to reproduce it because the argument
needs content on entry, but the verifier seems to only enable this
optimization for fully empty buffers.

Since adding selftests does not help with existing issues or prevent future
occurrences of similar problems, I believe one way to resolve it is to
statically restrict ARG_PTR_TO_MEM from appearing without memory access
tags. Using ARG_PTR_TO_MEM alone without tags is nonsensical because:

- If the helper does not change the argument, missing MEM_RDONLY causes
   the verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
   verifier to incorrectly assume the memory is unchanged, leading to
   potential errors.

I am still wondering, if we agree on the above, how should we enforce this
restriction? Should we let ARG_PTR_TO_MEM imply MEM_WRITE semantics by
default, and change ARG_PTR_TO_MEM | MEM_RDONLY to ARG_CONST_PTR_TO_MEM? Or
should we add a check in the verifier to ensure ARG_PTR_TO_MEM always comes
with an access tag (though this seems to only catch errors at
runtime/testing)?

Any insights and comments are welcome. If the individual fix patches for
the prototypes look correct, I would also really appreciate it if they
could be merged ahead of the discussion.

Thanks,

Zesen Liu

Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
Zesen Liu (2):
      bpf: Fix memory access tags in helper prototypes
      selftests/bpf: add regression tests for snprintf and get_stack helpers

 kernel/bpf/helpers.c                                      |  2 +-
 kernel/trace/bpf_trace.c                                  |  6 +++---
 net/core/filter.c                                         |  8 ++++----
 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c | 15 +++++++++++++--
 tools/testing/selftests/bpf/prog_tests/snprintf.c         |  6 ++++++
 tools/testing/selftests/bpf/prog_tests/snprintf_btf.c     |  3 +++
 tools/testing/selftests/bpf/progs/netif_receive_skb.c     | 13 ++++++++++++-
 tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c  | 11 ++++++++++-
 tools/testing/selftests/bpf/progs/test_snprintf.c         | 12 ++++++++++++
 9 files changed, 64 insertions(+), 12 deletions(-)
---
base-commit: 22cc16c04b7893d8fc22810599f49a305d600b9e
change-id: 20251220-helper_proto-fb6e64182467

Best regards,
-- 
Zesen Liu <ftyghome@gmail.com>


