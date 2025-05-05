Return-Path: <linux-kselftest+bounces-32426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABFAA9BAA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0199E1659D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0126F454;
	Mon,  5 May 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="hma8j/LP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4426B097
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470383; cv=none; b=gMX4WkemOZxev99wAqwwLIxLdojP7A+hwttX8tOhAoxgR7TxYBLCX39TuIBqe34a8XXqyp1LQQk26bDYFWlYRwq5OR3vmGl0ms50PXUuDYma/INmOT5cFFhj7IYcemCKdzDGcKvtmsWHbfqV5L4ol1BTlNSKcP3bC4fzNnKPclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470383; c=relaxed/simple;
	bh=hXBcmhzt7pc6mnlU3vaU2qmGiS+9/nJx5CuvAcuDxoM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+eTuNZ40LcrjPKPXGQdMnOLjErYSkSDUaR37NP+kQb15rPgKmmIK+zl0KH4Ru3hlOEkxUid1n7ywd5HL3lsVg8fvqPDMDIQgwuHp22M6/mJt/Hq40kDKpyBHvGxIvFaGZbId88igW1HarbHEB1f8QCHFI4lUM3GMCeRvS67jJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=hma8j/LP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso2838000f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746470380; x=1747075180; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r39SIeBEKMPL6NAc24Q2e8XKW+qtgjjLIiRr8dMiQPo=;
        b=hma8j/LPJpq2VP4VSnLFKv5J8fIktsNniUoWw3ynZbUjkiJMcu7IWllkXixFUcCSOR
         b0Gkr//lOu99HYwdzzqD8kbAI08Ua+cm+rEdv3RbJD7WhNPQiJVaV6YuiAQ0Zps1lHmJ
         S10x0/JwY3XVg0bwinsDIRSzOMIlILemP0MmnTbsj+l/KwX1zcuokCnwVLGwMCXuA+pw
         TQXgsryfJFXS7Y3cw4cUNLXjxlcmy7hnoe5yFxkIT+nyZ+g08JFDPrib6XyUNJ7dYMk1
         5HAF2q3MHy5QeREMhVmbt7qUigw6rXct874H6HAPZZYDy7nC/cV8qWnPC8HapFEKIEJF
         pMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470380; x=1747075180;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r39SIeBEKMPL6NAc24Q2e8XKW+qtgjjLIiRr8dMiQPo=;
        b=WMIA4kEZavv/nuQUrDEe81IFg7joeMQ1kgK+3SoM4fEodM2xb3d5qh0LmUwg6lDSJb
         tkKJMPYSPZmt9H9pVA9bsjAiEDTVwHjhXNfIsG81RdJOQo73QSKGrf38txI2ocGzNcOD
         nG86j9NR8Nj0VZakB+I1isceyjPtr45vJgupIYLazH3mcZvJTFCpb8xbEAu5jmgSozni
         l00KBomgiYPSt3gbjw4TBRu4SM29OCDFzVaXXcCpbqLnbhhlPOZIP5+LS2v2p4GlWybc
         GF1xvai14TCc/xBoU9nMYWdDm9dIK8suzrv+TQkCDTLQoTEiHDYEWGvxLV5l2yyLq5BM
         VpWA==
X-Forwarded-Encrypted: i=1; AJvYcCVQyIlKvu7Y1XczHbM2RREYUEhsBEcJ8lcsft8Yfg8sy0X0vXmJyjuAi0Fw+jx2DGWomjV4j624D6sLI8CIVh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUMcXs5QSsBC1rQHauD2ADWMm3IqZUcLNVeABXAsBU+azn/Ep
	TfhdtCxZGnL5IDp6A75fLr0eK70PnbJRhd3GuBgF7MUMJ2HM7m8d4BpLWG4GQDs=
X-Gm-Gg: ASbGncslkPmUHxA9UIv3FCt8/O0qR3dIK4I9EvAJfLResAhuhUvb0YCYsufkO8kEDUV
	BA+XV5UitDBWgvvf7nPZ+e5nzqleC/ejH5klCPt+GwezKQINt9mY9MO0Lvh3bvQ4uiB7xHSv8tq
	oFrD2e3RoRUszJCf3FJ4rt4+gJsXm9dIol1S+qjGxYN6Dls3AlxYm+rGKXMrsbPecHf2+Tgkw/v
	jJLMabncQjsBc4n4+CJNNa66o0NF60so/+7YRDcBFp0nVFZXVFkefUD+dO4693plQyWmg8YH4cS
	+jj/h+ho3sNa0i3eXHP7YcskWJYL8Lq9QZHn8+MbBi1pbAY41ZfWCbfxJm++nY5AXR6nujHlSGa
	yan+rByjmXYixgI8vJ/7DPSBj5hxd2TnpELb9
X-Google-Smtp-Source: AGHT+IGaobnO4beOxK06wBrh3AtVwE6dZwzlJzIKWXgEz52cycCg7Fbg2XB6I7+Nolx5NZpbK0CsIw==
X-Received: by 2002:a5d:59a7:0:b0:39f:bfa:7c90 with SMTP id ffacd0b85a97d-3a0ab57d1bdmr475313f8f.13.1746470379915;
        Mon, 05 May 2025 11:39:39 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8117sm11328877f8f.56.2025.05.05.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:39:39 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v3 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Date: Mon, 05 May 2025 19:38:42 +0100
Message-Id: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIFGWgC/23NQQ7CIBQE0Ks0rMXAp1jrynsYF4i/9ictNFBJT
 dO7S1iZxuVkMm9WFjEQRnapVhYwUSTvclCHitneuBdyeubMQIAWWkiexoHce+HjaCYOaLU+Kau
 wkyxPpoAdLYW7scfUcYfLzO656SnOPnzKT5Kl/08myQU3BhqodQO6PV8p+mQGdPPR+rFgCX4B2
 AGQgVZbaGStai3bPbBt2xcErgqQ9wAAAA==
X-Change-ID: 20250501-vmlinux-mmap-2ec5563c3ef1
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
With some upcoming changes the library is sitting at 5MiB for a parse.
Most of that memory is simply copying the BTF blob into user space.
By allowing vmlinux BTF to be mmapped read-only into user space I can
cut memory usage by about 75%.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v3:
- Remove slightly confusing calculation of trailing (Alexei)
- Use vm_insert_page (Alexei)
- Simplified libbpf code
- Link to v2: https://lore.kernel.org/r/20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com

Changes in v2:
- Use btf__new in selftest
- Avoid vm_iomap_memory in btf_vmlinux_mmap
- Add VM_DONTDUMP
- Add support to libbpf
- Link to v1: https://lore.kernel.org/r/20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com

---
Lorenz Bauer (3):
      btf: allow mmap of vmlinux btf
      selftests: bpf: add a test for mmapable vmlinux BTF
      libbpf: Use mmap to parse vmlinux BTF from sysfs

 include/asm-generic/vmlinux.lds.h                  |  3 +-
 kernel/bpf/sysfs_btf.c                             | 37 ++++++++++
 tools/lib/bpf/btf.c                                | 83 +++++++++++++++++++---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 83 ++++++++++++++++++++++
 4 files changed, 194 insertions(+), 12 deletions(-)
---
base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


