Return-Path: <linux-kselftest+bounces-27994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDAA4B767
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 06:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A4C188DB53
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3E1DED40;
	Mon,  3 Mar 2025 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b7v9ETW9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229E1D88A6
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978571; cv=none; b=RM4AjZgyQJoAzqu9LAzAfRiHrXFqsfEuc2w35ASc5cbQlhx1RIqd1cHFrkcP/iJp8+5g7dL0Ie6HAuDlJ/zC3TSVwoiYsz7l14dP6i4g725mribcRs79Kg/narIwEpb522AWxbZi6WGpnOExOrRfAFJPpj91EHJ1pYGGBhP/yPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978571; c=relaxed/simple;
	bh=/qRPtKa42LWZBuXTa5EaqFMm86f53UMryHQI6TDhH0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6V1RRTz6WR2J3z2eL27xGxxpNJoSlfayefhaQkusCNHov2LKWpm3YgSTJ+kt5GRIgCaaNRmpfLegp+QmIHWuWycidoM4p2Zswd/T5tjqSwIr62edzafg/x2rGf/tjNBCCTavoSq8RmtFlJEOEoV76gtNWrrmRoPeZ9FWt7T/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b7v9ETW9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e52bf5eb0fso62639a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 21:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978568; x=1741583368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDEVHx745HfqQKzrcbjnWQijhbqwLuomPt+Qpt4lkGM=;
        b=b7v9ETW9KEg6iBp26Blp7M+oDZ33w7F43xabicB3uO6jnffm3cvadGHHYRilGXq2yX
         zD9+fcEhdM831s8yKG+6VnQPEOdL/y9Xq0Akf8RV7VU73fiOfzhNHTWQtnOK9CxfmhPA
         AzyaEAWDkN+5SYvsM/wYTMOtyhTj4FzQdcteQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978568; x=1741583368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDEVHx745HfqQKzrcbjnWQijhbqwLuomPt+Qpt4lkGM=;
        b=lvZQnNwi43UssFN1qoSV0KAZ2Goru6hdIWZfT43ExqM5PqBYtwn/KNrQ+7y004bS22
         ro/oh5fWGnygm+h0gTmc1Q2j9YEgJ9wThRa1oPXt3H0/DXcKjqr0AozuhRdW2UDlpPY2
         414CtqyP/iwI/qhZf27rxTATLzJNXYzYMVGOXdLl6OTvg8/oSyBaPf9/F+3nVOAWFIMF
         p1ZuWdg4lf5e1kZ7EQjeJrsxQXTD4iksxQPRKRnUShSJMZA2vN4hgoydoJeu7OYxlmkL
         qAUhvPXnQDL4n5oCLuTOdvCXHUJIxQlztACAp00QrMeYJO4LnvvlOlvdHXVwddZIlN4M
         IInQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVwMTY3MM7pv+Xe30W/8WrenirySyU9QBfKUtSJMJOrxKkNuRCdWYA1U56wu2y3115ngap2HcI3bN8ujAvkW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsJoB06ni6zuy654L0T4H5JBGZOe0BLemLs0tByzGypcBLcsZ
	EJrNl2D9mnT8eqg2C7vovmHypoSKWMSDM8AUzey4rEwW+bhMQwdqNC8ByU+ctg==
X-Gm-Gg: ASbGncuNGm4jZCBPxToBuemooId00zWSNOudzwcCjVhjQyvEsYaq/cu1EUoMjRdHaHN
	ClrmaHQ7lIeu4kOX6zKo326/vpy/F4imi4UM5S+eB4I3m+u0t8W2IEov0w7S2AI4wvcO793n8Qy
	AWidq0D8b3oLteK4AxfegryBQxmGp8Ws5SWsIGuEYaGAZThHcKFUB/urAfGXAdFpn7OlTNRaquU
	cwzSIVqDySDKksrvCzhhTWI+FkZ2VDHPjL8M29uDDqefc5db7k17NRdevtxGQtNJKFq/He79WcK
	SErXrCse2yL6F2Fp/1ArIAx9p1rhRHCXexMkpAyfxFgmdxr5g857Aus3n8mlbBUuIk5TMaXUzU0
	k
X-Google-Smtp-Source: AGHT+IFJJ1/Y+xG0LrBQCoUEh3jDQ/6gxJ5XlGCFi/rSh9nmo+Q+kXS8EIpqecs4DgVt86ejopjo1w==
X-Received: by 2002:a05:6402:2694:b0:5d0:d183:cc11 with SMTP id 4fb4d7f45d1cf-5e4d6acd351mr5227775a12.2.1740978567672;
        Sun, 02 Mar 2025 21:09:27 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:27 -0800 (PST)
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
	Jeff Xu <jeffxu@google.com>
Subject: [PATCH v8 0/7] mseal system mappings
Date: Mon,  3 Mar 2025 05:09:14 +0000
Message-ID: <20250303050921.3033083-1-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

This is V8 version, addressing comments from V7, without code logic
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
vectors (arm compact-mode), sigpage (arm compact-mode),
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

 Documentation/userspace-api/mseal.rst         |  20 ++++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/kernel/vdso.c                      |  12 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/vma.c                     |   7 +-
 include/linux/mm.h                            |  10 ++
 init/Kconfig                                  |  22 ++++
 kernel/events/uprobes.c                       |   3 +-
 security/Kconfig                              |  21 ++++
 .../mseal_system_mappings/.gitignore          |   2 +
 .../selftests/mseal_system_mappings/Makefile  |   6 +
 .../selftests/mseal_system_mappings/config    |   1 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
 .../testing/selftests/x86/test_mremap_vdso.c  |  43 +++++++
 14 files changed, 254 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 create mode 100644 tools/testing/selftests/mseal_system_mappings/config
 create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

-- 
2.48.1.711.g2feabab25a-goog


