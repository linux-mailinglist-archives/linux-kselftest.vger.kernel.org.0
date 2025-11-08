Return-Path: <linux-kselftest+bounces-45180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71FC433CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0069188CFB1
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B926D4CD;
	Sat,  8 Nov 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m78ub/XP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF622A80D
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630938; cv=none; b=YYa8I9JRY0qiKF/cW/kR/reMhmzt7r5Xlc6AB+qANx8UdPCMEg+gXYsCffVt3Q5qzI4zB5wyw2URE25pzqdspoMA4cd768e0IyuH9/2W8tw3CTXSjT4kh44nhDWAVzQT8EYagEJYYf/fVfWO7ELUAAZLZUadJ8N6/HUlx9Mhw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630938; c=relaxed/simple;
	bh=X8ZNMlar1Ow1eWShjc511gIpn78CLUhuBDckR+OLvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fa9b5nL6i1h1ZQpdnjuVvP+Y4GAH9yPgGf9FDMU7Bk/zV6lxfCkXbvTChhiKWMMmXkc6BXBb8Xwnb+dVR8Bg0Bc7WHmm6sNr1mJ3V/GJLRXX5koWl6v/Y5QY1LcfH2iZmH5C4b8FalnJXnnX6rAvV28pfm+RFWLrozaCf+TGpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m78ub/XP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso15299051fa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630935; x=1763235735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13aFuuc1GQr46fPnxHYB7JQQ32jMQnvYNiL//B4303c=;
        b=m78ub/XPYARFiCn1X41kMWCyirwXam48zSHEEhpkCYS2pEjXzk1KGrPIQfIZ6+Sy6+
         OwUgLhw8b0puzPaZk1AOZJKMEmZ6hWDof9yREOiaqiQ/jAprOvBEDYtaIUIpPAQ2REgR
         Bm2kZ55dyrg/w66BUvIrbqwyB/8L54nOzdW5yvYKFITgielw0JftKukmd7gY5CPhuhc4
         HjWvIfjTtZUFInIJ1cxBzAJNqJT5n4Evl9oYAodOBRS8pBNaUBWVtFA0DXf1yIsHVB3r
         DmCsR5QrsMLu4YOIzXT6Hof4biz25iWoPaNO0340paVEXG1kSu/CaPbFwsw/xwpKSUW6
         TIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630935; x=1763235735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13aFuuc1GQr46fPnxHYB7JQQ32jMQnvYNiL//B4303c=;
        b=F6fpVGuG16oh5ZyusoDkhO3I3tH+I7Kz3xsscolv42hJqlaUwBXM5lzqBptIBXHFTe
         JV6LkI75TeKc+B4/GERfYjhztDLDqmh2Xx2dDXK5tmc630PIeD5v9qRofBm6oknytZif
         yWCNuiUrQAF72uMVy2/nGud3JJZRJz6DLO2RWSd+yryyv4NBI7ZRxtKKLll2DrNMCOrI
         CS7IWL/xSxdAaNOoOSVXj6hPp3FfsaGr4KY21o3+KV93wz7WOLUam5Kii8USajs7aC0o
         N5RUSg9K+xroU3pzFbrnpH1Om1bRGEwDyBNtDzxG4+kAQZARixbWuG/YkxyuZh7TcNaq
         XraQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYBEJhJin1yN8qurnvYhEyZzd2IzXgk/6yZohscO0xIG/qlH6ruyUrUd6SMWktzjak75H7qmCmGqf4mFhzlpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2/6J53cogpwdI/yDfMaIXxJ1GlGxoOkdvJ7xC3I9q/SlJX2n
	3LD9Y2V0rt8nwhZgB8XjTQAtEbyXvolXX5p1wkKzGeAxx7a4DP+vZNLO
X-Gm-Gg: ASbGncvZ3U0HhVqyE4eVL4a1elCG5dzfklMz0OzqzjThSqOhvzQa5O+ShRq9zCuRpvk
	V/WLC7stRGEILw/SvoYHa/GIDTSu96MKbONsbKP5ArC4bVZBgrhuGRfGKnv230K9xMEb4Z1kLAR
	5DgBMffKbFZXIa2X10aSuj8/8vMg53084A8NRtzUvOuoJPQiC3uv3gv6ZT8nvJrXUCyAlIJzZv7
	f4frf2hT/qH56ZrBJ2+3AjtfB+leHB2uu0UhMf9PNrmIUFY9IeLfXWz5LW4VlpxZ+VjBJxBe+/u
	wEu5w3lo1Atyr1SU1ueyQGAz/fW7ym+Jn1ZxHD++9JEBJat9J0JoR4tQji6niG9QSfW3vkhIK5U
	0xFk1bLAh/DNMrkgXiTYyIyv0/BtH0J8cn3mXJmdtoejKi8dvb6EDFE7R4FSnhO7sCDgxYSvmV5
	H4ZA==
X-Google-Smtp-Source: AGHT+IFnDCuSBk7jK+h8KqudoG4bWkSSmVwNgOJURKDwKCfuB23jHIyPUYE9uyHMOVa5uRsybmgG3Q==
X-Received: by 2002:a2e:b535:0:b0:37a:2f61:5f30 with SMTP id 38308e7fff4ca-37a7b30bad5mr6315371fa.35.1762630934396;
        Sat, 08 Nov 2025 11:42:14 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:12 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 0/9] riscv: vector: misc ptrace fixes for debug use-cases
Date: Sat,  8 Nov 2025 22:41:39 +0300
Message-ID: <20251108194207.1257866-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series suggests fixes for several corner cases in the RISC-V
vector ptrace implementation:

- init vector context with proper vlenb, to avoid reading zero vlenb
  by an early attached debugger

- follow gdbserver expectations and return ENODATA instead of EINVAL
  if vector extension is supported but not yet activated for the
  traced process

- validate input vector csr registers in ptrace, to maintain an accurate
  view of the tracee's vector context across multiple halt/resume
  debug cycles

For detailed description see the appropriate commit messages. A new test
suite v_ptrace is added into the tools/testing/selftests/riscv/vector
to verify some of the vector ptrace functionality and corner cases.

Previous versions:
- v3: https://lore.kernel.org/linux-riscv/20251025210655.43099-1-geomatsi@gmail.com/T/#u
- v2: https://lore.kernel.org/linux-riscv/20250821173957.563472-1-geomatsi@gmail.com/T/#u
- v1: https://lore.kernel.org/linux-riscv/20251007115840.2320557-1-geomatsi@gmail.com/T/#u

Changes in v4:
The form 'vsetvli x0, x0, ...' can only be used if VLMAX remains
unchanged, see spec 6.2. This condition was not met by the initial
values in the selftests w.r.t. the initial zeroed context. QEMU accepted
such values, but actual hardware (c908, BananaPi CanMV Zero board) did
not, setting vill. So fix the selftests after testing on hardware:
- replace 'vsetvli x0, x0, ...' by 'vsetvli rd, x0, ...' 
- fixed instruction returns VLMAX, so use it in checks as well
- replace fixed vlenb == 16 in the syscall test

Changes in v3:
Address the review comments by Andy Chiu and rework the approach:
- drop forced vector context save entirely
- perform strict validation of vector csr regs in ptrace

Changes in v2:
- add thread_info flag to allow to force vector context save
- force vector context save after vector ptrace to ensure valid vector
  context in the next ptrace operations
- force vector context save on the first context switch after vector
  context init to get proper vlenb

---

Ilya Mamay (1):
  riscv: ptrace: return ENODATA for inactive vector extension

Sergey Matyukevich (8):
  selftests: riscv: test ptrace vector interface
  selftests: riscv: verify initial vector state with ptrace
  riscv: vector: init vector context with proper vlenb
  riscv: csr: define vtype registers elements
  riscv: ptrace: validate input vector csr registers
  selftests: riscv: verify ptrace rejects invalid vector csr inputs
  selftests: riscv: verify ptrace accepts valid vector csr values
  selftests: riscv: verify syscalls discard vector context

 arch/riscv/include/asm/csr.h                  |  11 +
 arch/riscv/kernel/ptrace.c                    |  72 +-
 arch/riscv/kernel/vector.c                    |  12 +-
 .../testing/selftests/riscv/vector/.gitignore |   1 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 754 ++++++++++++++++++
 6 files changed, 847 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c


base-commit: e811c33b1f137be26a20444b79db8cbc1fca1c89
-- 
2.51.0


