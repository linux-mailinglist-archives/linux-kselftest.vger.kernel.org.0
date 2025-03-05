Return-Path: <linux-kselftest+bounces-28266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FAA4F486
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BFA3A6A2C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C88155333;
	Wed,  5 Mar 2025 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FI9xMl1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058F3B2A0
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141043; cv=none; b=Xt0cVw88wm203+vlCbCRU7l24V6K3a3SMoCaq0ecECrgc4kBCF5hSmErySc06fvdtKO0SI7fWOmU+QPZbXvEroTTVIT2b44hFiGbmiXSqS1SPrtsrNyTxmA9/LBAClnV1+qwKhCe7A8+qzUdKl10oKohuN0v3QzSWh8+IBQTXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141043; c=relaxed/simple;
	bh=On54tDRUS6TI1ccIjKILXTQawB/Q78xP8RuJ0wrOx14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnoL70N2Y44y9E16xqyWiEXbKqOAFKbie2mKc9pPudXokWcBszW2ApjYfh4UQFAjcRnm6eLHuFrL5sgbvSLF4tICBr+0CzgxgBoVwDQXqt2zu4sKPTUZ7wHiT8lkZFyDXKHX7/1KZFmmyPG3FqIUawEimkeM6SfLb+Gf/fOBvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FI9xMl1Y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so762361a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 18:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141039; x=1741745839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8KwX6NeTRi2sXa8vhuc0snxgnOuiDK19+zFcgBNOqI=;
        b=FI9xMl1Y4Jl2ZkdiVhfKL8WjSkeak8bwmY2epTEDNP4Fx4nbpFPrqAasvA08dCL5RY
         2pazJSoRrRU16XHVzP1AfCAXRa8DGd+Dc87itqZn14h9kS6Qhaiqg1zqjQy6G+GLiII/
         fE+5UfBFznKjaDxAMVIqj4BxlbTdlIadm70J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141039; x=1741745839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8KwX6NeTRi2sXa8vhuc0snxgnOuiDK19+zFcgBNOqI=;
        b=sta4OztBSUay3K/SbHV3k438AqLvHydUtQkJcBWMVkrfxuR6CBTesxBzhDFunnpoG/
         gFi2UMQmrVOGQK1HaRiVWdnDPZZbS2iuIis3+4P1mMdfr3whZz1VOpJYCDpmbb2U7yYN
         WI+FvZkKC+ICeX5hCPfd5ooGMy15mFic9NN17FwgZtmb1X1LA4eU+5B1InD3TBwwa4je
         IloHB+Buvk9tCIgF+wgsxXAR9J2N54AouSY+pkd9qBdcmOMFwkAb0Cwn+6veY2AmYQWe
         wxvzxU4ZwPv3iXiSsi7fYzYAh5E9GYUO9HKyxANkVCp5KH7D6l9x8g/+6Kvyq31o+HWB
         fNUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3xSe/SYvHxVQwaE+yiffT9K0uh16Js7tbKaz7RzellSVenOfaB5Kqh1mIPa46S4Sk/rOPhFaimkc7i/oUUdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1x5k4hxktlDfhhKCtsZdE0uoYnGJtYT7lJQ0bn1uSf2MJ6ng
	/5+r0t2SxxnyK+2TKnbxYTajYoCFSJ5d+DtoZdggI2F2oBKP7EH02h2pMWIqNQ==
X-Gm-Gg: ASbGncuGrBNuBmV0tyuOKHIxSqb/mE79IhB2rdBOLoDqZzZZ11zdKEHU6asayFQVAaX
	Y31fOFw/MyAHuOdyMMG+AZIHmPKFD6JKz4Crz2h/rD/hkTnxeH2K6Eby95CjxURWe2thJWoAPqW
	Ht1es8sC49K123RhqE4szv7+njqLHy5pSMbQR5Mv+w2U2//Gs0357pHCm3HosMl+UJXLwZgzyeA
	iI6i4R+Hx23q5B7dJ6iuXCauEM03M8wMC46P1Bsnc+/xfCI8K9FsTJkObyUiBZJK+B5cfeHJGXi
	ZBJi+zh8RlXUcuT9/Zxcv2czuWYkwP+0WMm7fkrrcLN4a0ZZfmDMa7GSG0T5VencXwH2RABcf9x
	d
X-Google-Smtp-Source: AGHT+IFW/bnkh/EXUarYUjFcjTWQL/8MURY2vEnuH4PoUi0AT2GFPUZ+5ZTlzNAFJBJhfu5/nDZg7w==
X-Received: by 2002:a05:6402:270b:b0:5e0:36fa:ac1c with SMTP id 4fb4d7f45d1cf-5e59f4b6de6mr480560a12.9.1741141039103;
        Tue, 04 Mar 2025 18:17:19 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:17 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v9 0/7] mseal system mappings
Date: Wed,  5 Mar 2025 02:17:04 +0000
Message-ID: <20250305021711.3867874-1-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is V9 version, addressing comments from V8, without code logic
change.

-------------------------------------------------------------------
As discussed during mseal() upstream process [1], mseal() protects
the VMAs of a given virtual memory range against modifications, such
as the read/write (RW) and no-execute (NX) bits. For complete
descriptions of memory sealing, please see mseal.rst [2].

The mseal() is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped.

The system mappings are readonly only, memory sealing can protect
them from ever changing to writable or unmmap/remapped as different
attributes.

System mappings such as vdso, vvar, vvar_vclock,
vectors (arm compat-mode), sigpage (arm compat-mode),
are created by the kernel during program initialization, and could
be sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [3]. It could be sealed from creation.

The vsyscall on x86-64 uses a special address (0xffffffffff600000),
which is outside the mm managed range. This means mprotect, munmap, and
mremap won't work on the vsyscall. Since sealing doesn't enhance
the vsyscall's security, it is skipped in this patch. If we ever seal
the vsyscall, it is probably only for decorative purpose, i.e. showing
the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the system mappings during restore operations. UML(User Mode Linux)
and gVisor, rr are also known to change the vdso/vvar mappings.
Consequently, this feature cannot be universally enabled across all
systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.

To support mseal of system mappings, architectures must define
CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS and update their special
mappings calls to pass mseal flag. Additionally, architectures must
confirm they do not unmap/remap system mappings during the process
lifetime. The existence of this flag for an architecture implies that
it does not require the remapping of thest system mappings during
process lifetime, so sealing these mappings is safe from a kernel
perspective.

This version covers x86-64 and arm64 archiecture as minimum viable feature.

While no specific CPU hardware features are required for enable this
feature on an archiecture, memory sealing requires a 64-bit kernel. Other
architectures can choose whether or not to adopt this feature. Currently,
I'm not aware of any instances in the kernel code that actively
munmap/mremap a system mapping without a request from userspace. The PPC
does call munmap when _install_special_mapping fails for vdso; however,
it's uncertain if this will ever fail for PPC - this needs to be
investigated by PPC in the future [4]. The UML kernel can add this support
when KUnit tests require it [5].

In this version, we've improved the handling of system mapping sealing from
previous versions, instead of modifying the _install_special_mapping
function itself, which would affect all architectures, we now call
_install_special_mapping with a sealing flag only within the specific
architecture that requires it. This targeted approach offers two key
advantages: 1) It limits the code change's impact to the necessary
architectures, and 2) It aligns with the software architecture by keeping
the core memory management within the mm layer, while delegating the
decision of sealing system mappings to the individual architecture, which
is particularly relevant since 32-bit architectures never require sealing.

Prior to this patch series, we explored sealing special mappings from
userspace using glibc's dynamic linker. This approach revealed several
issues:
- The PT_LOAD header may report an incorrect length for vdso, (smaller
  than its actual size). The dynamic linker, which relies on PT_LOAD
  information to determine mapping size, would then split and partially
  seal the vdso mapping. Since each architecture has its own vdso/vvar
  code, fixing this in the kernel would require going through each
  archiecture. Our initial goal was to enable sealing readonly mappings,
  e.g. .text, across all architectures, sealing vdso from kernel since
  creation appears to be simpler than sealing vdso at glibc.
- The [vvar] mapping header only contains address information, not length
  information. Similar issues might exist for other special mappings.
- Mappings like uprobe are not covered by the dynamic linker,
  and there is no effective solution for them.

This feature's security enhancements will benefit ChromeOS, Android,
and other high security systems.

Testing:
This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
- Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
  i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
- Passing various automation tests (e.g. pre-checkin) on ChromeOS and
  Android to ensure the sealing doesn't affect the functionality of
  Chromebook and Android phone.

I also tested the feature on Ubuntu on x86-64:
- With config disabled, vdso/vvar is not sealed,
- with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
  normal operations such as browsing the web, open/edit doc are OK.

Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
Link: Documentation/userspace-api/mseal.rst [2]
Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]
Link: https://lore.kernel.org/all/CABi2SkV6JJwJeviDLsq9N4ONvQ=EFANsiWkgiEOjyT9TQSt+HA@mail.gmail.com/ [4]
Link: https://lore.kernel.org/all/202502251035.239B85A93@keescook/ [5]

-------------------------------------------
History:

V9:
 - Add negative test in selftest (Kees Cook)
 - fx typos in text (Kees Cook)

V8:
  - Change ARCH_SUPPORTS_MSEAL_X to ARCH_SUPPORTS_MSEAL_X (Liam R. Howlett)
  - Update comments in Kconfig and mseal.rst (Lorenzo Stoakes, Liam R. Howlett)
  - Change patch header perfix to "mseal sysmap" (Lorenzo Stoakes)
  - Remove "vm_flags =" (Kees Cook, Liam R. Howlett,  Oleg Nesterov)
  - Drop uml architecture (Lorenzo Stoakes, Kees Cook)
  - Add a selftest to verify system mappings are sealed (Lorenzo Stoakes)

V7:
  https://lore.kernel.org/all/20250224225246.3712295-1-jeffxu@google.com/
  - Remove cover letter from the first patch (Liam R. Howlett)
  - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
  - logging and fclose() in selftest (Liam R. Howlett)

V6:
  https://lore.kernel.org/all/20250224174513.3600914-1-jeffxu@google.com/
  - mseal.rst: fix a typo (Randy Dunlap)
  - security/Kconfig: add rr into note (Liam R. Howlett)
  - remove mseal_system_mappings() and use macro instead (Liam R. Howlett)
  - mseal.rst: add incompatible userland software (Lorenzo Stoakes)
  - remove RFC from title (Kees Cook)

V5
  https://lore.kernel.org/all/20250212032155.1276806-1-jeffxu@google.com/
  - Remove kernel cmd line (Lorenzo Stoakes)
  - Add test info (Lorenzo Stoakes)
  - Add threat model info (Lorenzo Stoakes)
  - Fix x86 selftest: test_mremap_vdso
  - Restrict code change to ARM64/x86-64/UM arch only.
  - Add userprocess.h to include seal_system_mapping().
  - Remove sealing vsyscall.
  - Split the patch.

V4:
  https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/
  - ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
  - test info (Lorenzo Stoakes)
  - Update  mseal.rst (Liam R. Howlett)
  - Update test_mremap_vdso.c (Liam R. Howlett)
  - Misc. style, comments, doc update (Liam R. Howlett)

V3:
  https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/
  - Revert uprobe to v1 logic (Oleg Nesterov)
  - use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Cook)
  - Move kernel cmd line from fs/exec.c to mm/mseal.c and
    misc. (Liam R. Howlett)

V2:
  https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
  - Seal uprobe always (Oleg Nesterov)
  - Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nesterov)
  - Rebase to linux_main

V1:
 - https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

--------------------------------------------------



Jeff Xu (7):
  mseal sysmap: kernel config and header change
  selftests: x86: test_mremap_vdso: skip if vdso is msealed
  mseal sysmap: enable x86-64
  mseal sysmap: enable arm64
  mseal sysmap: uprobe mapping
  mseal sysmap: update mseal.rst
  selftest: test system mappings are sealed.

 Documentation/userspace-api/mseal.rst         |  20 +++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/kernel/vdso.c                      |  12 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/vma.c                     |   7 +-
 include/linux/mm.h                            |  10 ++
 init/Kconfig                                  |  22 ++++
 kernel/events/uprobes.c                       |   3 +-
 security/Kconfig                              |  21 ++++
 tools/testing/selftests/Makefile              |   1 +
 .../mseal_system_mappings/.gitignore          |   2 +
 .../selftests/mseal_system_mappings/Makefile  |   6 +
 .../selftests/mseal_system_mappings/config    |   1 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 119 ++++++++++++++++++
 .../testing/selftests/x86/test_mremap_vdso.c  |  43 +++++++
 15 files changed, 261 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 create mode 100644 tools/testing/selftests/mseal_system_mappings/config
 create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

-- 
2.48.1.711.g2feabab25a-goog


