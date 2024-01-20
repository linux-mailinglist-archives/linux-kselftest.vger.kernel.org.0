Return-Path: <linux-kselftest+bounces-3274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3DB83368A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 22:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA9F1F218F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142FE1428C;
	Sat, 20 Jan 2024 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Zf7leXdT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C875213AC5;
	Sat, 20 Jan 2024 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705787323; cv=none; b=HM8+c2ha+7iAPZJzXPYVEkLZqf9K019qUimMtRgqQ+LRiSFsLJuCID497zABDg5+sYE6Y+WjcgNeFQiZlOqU/AM/wSJTWTKorY2ZCkppu/+axXshDCcS1I846UW6VrG3R9mHHzVXXiLdogCOoJ1wig3x+1w9xwzAp30q0yeLhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705787323; c=relaxed/simple;
	bh=UTapdXJqd6/GeU/aS6pjbktBrgPfIjkTYoVhQTZ/yQ4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=eba+WrKPP9YYSkxtlrGmE70vUejaDIYpn2BVCF+j64DAbnSwGW2awTb0M+x6WS9Ilc6+jVLC3dfpKtge61Xy7yRnPk26XLZs4q6E3kjzRaHpQkfxgMRhmxxcNvkRMfgz9j6493Oie5vzUBo3ndXLjZ7ZUsiqXoPCNKi7VULudl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Zf7leXdT; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705787311; bh=6U2V9PznT/aHdEhNbmRHZ0xAzvTGSoyQ3tiDTQLv01Y=;
	h=From:To:Cc:Subject:Date;
	b=Zf7leXdTRyLHolgwRVNO0JJ8ybL0fo9iCJs/yNoslTvyIEBp+ApMzeOrrcXP6b0rw
	 0TgoXaq3tj1XNufDdvewTdoAmg2X7MA3OyZrnPYp0b1djY/kXam3si91Jc+wYFQfrk
	 +qRngseMtYaGWQOYADym1gg+0dspVpY/M2SYr4ro=
Received: from cyy-pc.lan ([240e:379:2240:ed00:c92f:86c3:e615:ca18])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id C1339C79; Sun, 21 Jan 2024 05:48:19 +0800
X-QQ-mid: xmsmtpt1705787299tg307jjo8
Message-ID: <tencent_B2D0435BC011135736262764B511994F4805@qq.com>
X-QQ-XMAILINFO: N4/evVE7TFO8CtGPtkNoc+aCCKSp85D26BgfmLO7AQ7zZB5kLxc7ZMOak6XQMh
	 N5crBuRjsO3x8ZFs1oAsBFekPmMPmz5nYhzCQe2TZX/zw50nA7EeP4w3UwHjygsqGl3Zcp9+fhxa
	 SHX/6J7KCCW2k1Fr8m4VKyxaupTvvRr19cK5JchF1wFI5gQ8mbHaG1KXLSZ9nCGqA81fw3zU6SkZ
	 sHSmF7pvwdhR5wPwY+tD4XlXykSivnmZKcKD0sElYvZozC9hro7OdVe7G2V+YJokSMbnYSlu04G8
	 Xf5ooaLq20OxkDho23odc0UNvp+ThlKCSpw3e5KnWaw1v0LFS2Xp0Wloos63E0sBj6cPhtSvwPH6
	 bXcR5izmnxPBYeafsfPK7DmliQBEENA7ToITc8DrKU2QonDdwVAPbm1FXAzOVoUNckRq6XhdAa9g
	 Z7DrlxNkZ2KLUuJm65wvTPZx3bXOyY9o1ZIsKmvDF9X3f/mUyYnrI28d6D3B/cmjXDvDtVOI3E1A
	 U3xhYVnNAfq1ZMPVAQLltcaQ1JUMosqAmCJY1UQOwLiw22/bZAfefrfulDX8vYnPxh3O9DxtZk8+
	 oSS/KOv1OQ7fT+JfM7qwox9X22hJCntmqBGfKebcVNjHb5OLXhgsDZyPtIqzO+I+3Rf5iNljK79y
	 EvxKjR09vGb0NUaMqRs61TBZC3mbbMfRgANe7RL0v9a5JmqLf77KCa/oMiadaiWEtcbx3y4DNP0J
	 rJOul4O5L9qHT25wZGWSShJ6AKEY3GqMsqA7/16wrF0DlRRJOBITjFYEEp4mdMzltp/eT5bf17YO
	 8kf7HgBf+HlFF5QIXRRwYryYpbCTy8zCxriOaPsZvku6g4Wht26Lg+CtJ5w0LPsddGmFLiYkstt7
	 mWEPXxtU/r2QsM09bXb9EIJkLbQhJEvetUdBqt2dnmBFcb0RUKvW3T2+gMftgHjEGGPG3hUrVCO+
	 kjq2pQVcAI9D3NRADA9Z97NIxn/QbpTx6YDghJW48nB18HxzjF9g1NXIcSpgck
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 0/3] RISC-V: mm: do not treat hint addr on mmap as the upper bound to search
Date: Sun, 21 Jan 2024 05:48:09 +0800
X-OQ-MSGID: <20240120214809.291094-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous patch series[1] changes a mmap behavior that treats the hint
address as the upper bound of the mmap address range. The motivation of the
previous patch series is that some user space software may assume 48-bit
address space and use higher bits to encode some information, which may
collide with large virtual address space mmap may return. However, to make
sv48 by default, we don't need to change the meaning of the hint address on
mmap as the upper bound of the mmap address range, especially when this
behavior only shows up on the RISC-V. This behavior also breaks some user
space software which assumes mmap should try to create mapping on the hint
address if possible.  As the mmap manpage said: 

> If addr is not NULL, then the kernel takes it as a hint about where to
> place the mapping; on Linux, the kernel will pick a nearby page boundary
> (but always above or equal to the value  specified by 
> /proc/sys/vm/mmap_min_addr) and attempt to create the mapping there.

Unfortunately, what mmap said is not true on RISC-V since kernel v6.6.

Other ISAs with larger than 48-bit virtual address space like x86, arm64,
and powerpc do not have this special mmap behavior on hint address. They
all just make 48-bit / 47-bit virtual address space by default, and if a
user space software wants to large virtual address space, it only need to
specify a hint address larger than 48-bit / 47-bit.

Thus, this patch series keeps the change of mmap to use sv48 by default but
does not treat the hint address as the upper bound of the mmap address
range. After this patch, the behavior of mmap will align with existing
behavior on other ISAs with larger than 48-bit virtual address space like
x86, arm64, and powerpc. The user space software will no longer need to
rewrite their code to fit with this special mmap behavior only on RISC-V.

My concern is that the change of mmap behavior on the hint address is
already in the upstream kernel since v6.6, and it might be hard to revert
it although it already brings some regression on some user space software.
And it will be harder than adding it since v6.6 because mmap not creating
mapping on the hint address is very common, especially when running on a
machine without sv57 / sv48. However, if some user space software already
adopted this special mmap behavior on RISC-V, we should not return a mmap
address larger than the hint if the address is larger than BIT(38). My
opinion is that revert this change on the next kernel release might be a
good choice as only a few of hardware support sv57 / sv48 now, these
changes will have no impact on sv39 systems.

Moreover, previous patch series said it make sv48 by default, which is
in the cover letter, kernel documentation and MMAP_VA_BITS defination.
However, the code on arch_get_mmap_end and arch_get_mmap_base marco still
use sv39 by default, which makes me confused, and I still use sv48 by
default in this patch series including arch_get_mmap_end and
arch_get_mmap_base.

Changes in v2:
- correct arch_get_mmap_end and arch_get_mmap_base
- Add description in documentation about mmap behavior on kernel v6.6-6.7.
- Improve commit message and cover letter
- Rebase to newest riscv/for-next branch
- Link to v1: https://lore.kernel.org/linux-riscv/tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com/

[1]. https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosinc.com/

Yangyu Chen (3):
  RISC-V: mm: do not treat hint addr on mmap as the upper bound to
    search
  RISC-V: mm: only test mmap without hint
  Documentation: riscv: correct sv57 kernel behavior

 Documentation/arch/riscv/vm-layout.rst        | 54 ++++++++++++-------
 arch/riscv/include/asm/processor.h            | 38 +++----------
 .../selftests/riscv/mm/mmap_bottomup.c        | 12 -----
 .../testing/selftests/riscv/mm/mmap_default.c | 12 -----
 tools/testing/selftests/riscv/mm/mmap_test.h  | 30 -----------
 5 files changed, 41 insertions(+), 105 deletions(-)

-- 
2.43.0


