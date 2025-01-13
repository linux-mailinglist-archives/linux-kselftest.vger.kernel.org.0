Return-Path: <linux-kselftest+bounces-24361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AFA0B7F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD611613F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4BC22318;
	Mon, 13 Jan 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2ir0JQT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRWWQOaZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51D17993;
	Mon, 13 Jan 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774234; cv=none; b=NUCGMQ7vNU20CEcI8/GlbGIvqG4K/2cAS5lLbjeGWVBqbZX/bNRM+QYerk7qJznxr3O4Eo5xGIs/At0zQF5WSZCOrWLoFPCRUra+Q/gd27CCPoTDR74emJrRS738C4jb2lycbD3nSwW/ImVEAdoIEM9W1yh1FAk/EoNDc6t6hW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774234; c=relaxed/simple;
	bh=m0ZvOwE24LhMBfXqxaQHkAKn3VpdDyFJa05tqZYKi3o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZTPhO2FiM2CDlSHpSmi/vxOG1wsXXA8eZ0T5eD+VFFC003uPUnH3DS+bLuWwJnx0dLzlnnrRkbfIRxiSmEuJYcDRpUkjnoLa3hzQN/rkdaUBcgjVMNuNC7+SBLOPRv1qQsNx9N5hYi6tPKtaRqwxtd3zvQ8k8S51M5+k5nR2r7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f2ir0JQT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRWWQOaZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736774230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mYupyF2Gsl9U0NrCNSWW0D+ZsnFdoZ4dytuLiu3xZBE=;
	b=f2ir0JQTCp/VDv10SQLqUVdVSd9zjTEK9VTrC16Ud6MIQfn6pDL08uguKXgmdy1e/5I71v
	3qBBc32skJgKO2XedUfG3RTyaFE1QjQZxH58wCcOxFRzP5Fh9NLGFDaFN7S++FKnpkzBl2
	I8fMwQXzL1L0aK2hLwZghcCDj5ZelQk6ESy+yQ8ya/sP9V716k6PedZRvjI/r1QZ/2sREY
	ttiPnS8jIm9yq6epO4rphWQ9lKmdOf7gxnEWuj6GBhbjw3N/gd0IqVGkCWKB7Y8ElDGlfd
	ajLisPPrZ/ZINQng1NGufLYA5Rb0E+57LlMRLVUrgfW/pAd3BECyc4v9Zzn+0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736774230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mYupyF2Gsl9U0NrCNSWW0D+ZsnFdoZ4dytuLiu3xZBE=;
	b=yRWWQOaZPboXBggFIJl+ThKBTYXkA1DaSPV5/bPM/1QX02IJQr0cs6Hy3VWMDuSPm4CoSv
	trq8fGDsYnho2OCA==
Subject: [PATCH v3 0/4] selftests/mm: virtual_address_range: Reduce memory
 usage and avoid VM_IO access
Date: Mon, 13 Jan 2025 14:15:34 +0100
Message-Id: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPYRhWcC/43NTQqDMBCG4atI1k3JjxrtqvcoRaKZ1AHRksRgE
 e/e6Kp0Ubp8P4ZnVuLBIXhyyVbiIKLHaUwhTxnpej0+gKJJTQQTBeNM0YguzHpotDEOvG/ccRT
 AB0/rosqlKkura0WS8HRgcTn02z11jz5M7nU8i3xf/3Mjp4zKSuZa2DZXFq4DjnNw04jL2QDZ7
 Sg+PM5+eyJ5ohRatFZ20rBvb9u2N6d9GsQaAQAA
X-Change-ID: 20250107-virtual_address_range-tests-95843766fa97
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736774229; l=1741;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=m0ZvOwE24LhMBfXqxaQHkAKn3VpdDyFJa05tqZYKi3o=;
 b=VRRAV92gYVVHFsciCiOQ8m/bK7PvHMYYwYPFWqnAQdwj6Cuar90T1/2jwy7tF1T8rhaAeHNR2
 7k+uWfytxsfBA7i8QgwzMZt4UvRFoYmQ1DIspQpzv8phphiX9PllvWD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The selftest started failing since commit e93d2521b27f
("x86/vdso: Split virtual clock pages into dedicated mapping")
was merged. While debugging I stumbled upon some memory usage
optimizations.

With these test now runs on a VM with only 60MiB of memory.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Pick up review tags
- Fix naming around PR_SET_VMA_ANON_NAME helper functions
- Skip selftest if PR_SET_VMA_ANON_NAME is not supported
- Check for VM_IO instead of [vvar name prefix
- Link to v2: https://lore.kernel.org/r/20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de

Changes in v2:
- Drop /dev/null usage
- Avoid overcommit restrictions by dropping PROT_WRITE
- Avoid high memory usage due to PTEs
- Link to v1: https://lore.kernel.org/r/20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de

---
Thomas Weißschuh (4):
      selftests/mm: virtual_address_range: mmap() without PROT_WRITE
      selftests/mm: virtual_address_range: Unmap chunks after validation
      selftests/mm: vm_util: Split up /proc/self/smaps parsing
      selftests/mm: virtual_address_range: Avoid reading from VM_IO mappings

 tools/testing/selftests/mm/config                  |  1 +
 tools/testing/selftests/mm/virtual_address_range.c | 41 ++++++++++++--
 tools/testing/selftests/mm/vm_util.c               | 63 +++++++++++++++++-----
 tools/testing/selftests/mm/vm_util.h               |  1 +
 4 files changed, 89 insertions(+), 17 deletions(-)
---
base-commit: 7793bee8fed2027eb15219014de6fb0dc15d4a03
change-id: 20250107-virtual_address_range-tests-95843766fa97

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


