Return-Path: <linux-kselftest+bounces-19226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A69944AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356BA1C225B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994D192D7A;
	Tue,  8 Oct 2024 09:48:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA59185B58;
	Tue,  8 Oct 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380885; cv=none; b=EeASwgho0RU7hWjgL/Ic5Ax+rT4SqjIKggkBZoHPgdhTrfunBYs176OlTDhM+IqFkQMn2XgK9HsLKaThxVEMcECFA3Iyo9CHEU7UyAVeZE2XVOgDAMhQWG+0PQdiIvxaH6yCFgw2DBrp1FuRqrSBB6yGHMvpRj0rjuBSG7gD4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380885; c=relaxed/simple;
	bh=Y9o8iqsIQJ9c1Fnb+KQgKTIXQzIM/fkjC6/3l4WuDhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EA5ekUKyxBhCWTPuP8TK3t+KNnQQabHCsihE64B3+twWlUqeLvCObdN0dEUemR8vRRz3CcI9YUKZbGKzckxo5Ot63Ibs82q1e3yMsICEE7fjHk0OOMX4uKJjK3ze9sJ1reU2SkhWzjSFZMJaEGKdPgMpwPMoxQJVnPh5kY6wtMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowAAH7nxf_gRnEkoDBQ--.54511S2;
	Tue, 08 Oct 2024 17:41:52 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 0/4] A few fixes for RISC-V
Date: Tue,  8 Oct 2024 17:41:37 +0800
Message-Id: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAH7nxf_gRnEkoDBQ--.54511S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1DZw13Wr43Kw1xWw15Arb_yoWxKwb_WF
	WxK3s7GF4kua48CFy3X3W5WrZYy3yF9FWkAryYqr93AryUZF15JF4ktr1jvw1ru3y5Ja9F
	vFW5ta93Zr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzLvtUUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAcEB2cExhT4rwAAsu

These patches are all simple fixes with no strong dependency though,
I hope that making them a patchset will be more convenient for merge.

The patchset are based on v6.12-rc2.

Chunyan Zhang (4):
  riscv: Remove unused GENERATING_ASM_OFFSETS
  riscv: Remove duplicated GET_RM
  selftest/mm: Fix typo in virtual_address_range
  selftests/mm: skip virtual_address_range tests on riscv

 arch/riscv/kernel/asm-offsets.c                    |  2 --
 arch/riscv/kernel/traps_misaligned.c               |  2 --
 tools/testing/selftests/mm/Makefile                |  2 ++
 tools/testing/selftests/mm/run_vmtests.sh          | 10 ++++++----
 tools/testing/selftests/mm/virtual_address_range.c |  4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.34.1


