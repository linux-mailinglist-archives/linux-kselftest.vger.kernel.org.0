Return-Path: <linux-kselftest+bounces-28315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F355AA5037D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282CE16A0DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4F24EF7D;
	Wed,  5 Mar 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aAkjUc4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA02505BD
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188615; cv=none; b=aksLE4EObi4wSdJUUuvoF679GR0wJYO4IeEtLjySVG1m4S/3AOiYjJ5yULmLPok/wrGn6mMY9AtIx4U+EK1eE76z22JXYj0q2pvLWmc2Qzis8SWa1bdzslqE6a4YMfv1Hb2wGq4u3/eJFB6UDD+w0DQYIPM9aVniOJOL6aoEzBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188615; c=relaxed/simple;
	bh=gHVlgN101n3+XVq8QXEPU23oKAm13pn+ne80d5rhJzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NA1LBve21FXiJakAt5dJqxchI9DmvDA4ZKwXtoyf9TXSa6WQ1IcYuXzpUmXHgUkMWtrIjhcW3nbHrEOf+w5YFIjGocasd7g9LkGqVkG1zbe/90iWULz44ROGnHEg4oOM6yvhMhubmWouCZHd1vnt03IhCTnlj30PJtO1OiOUlKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aAkjUc4o; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f67e4079b6so23761b6e.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 07:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741188611; x=1741793411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEdRnbd6ElHaf0cylSreE5si0Xhw1DFHYyknOm0Ao9g=;
        b=aAkjUc4oPF2QdI1DCfTGId2n+mOWbk5IryzHhT0n3WiQNdhEVVy0L0ukT6JJmt3Lyx
         T/DdLtq9lNfcfe1DPgl7HZUrv2kZ/ov0ZZV8GEQj4V9NhFQlVu+vMjUMH6hzDFMLGiDk
         sSLkvEa6NlsLiI0S4E58gso9CoL9MwxDlPJtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188611; x=1741793411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEdRnbd6ElHaf0cylSreE5si0Xhw1DFHYyknOm0Ao9g=;
        b=azgg54u0fA8W1s9MQo7cqbWfSK9hXrVh3NvcWcGxaIdE0B63ODGQo37l66JPnLOCz2
         93I4CNPPTgBJpQYEW1uRzisLGBnJEG+y4/+/FIAHnEbz3O2wKxuFa1243hqFdCG8AwZv
         7aaEEGpwHVCQOsUSn/PiyXA7Pjy5w7PkERfFC1VrV/Bu/UUpK9YNRiUII76bfikwXw/U
         f6i+9vij2mr9EAEp7TLytYtWV/BRSk7tPe/UQhH/zoFpti6CMbFT3VbQr5H7BBrrj+J4
         2ZwgTiL/qEdsGS5VkpBJibAyStEOc2NgBmw+aiNnKIYSUsOYFAGqsvdt4rzsIKAY7vn+
         AQgg==
X-Forwarded-Encrypted: i=1; AJvYcCWq/I/ynKV6hVZld3j+9NhBniFvfi1OkikmgczZbEAC0LktlehvWrL+c9cvZ9pWYarsecP3CB0JNiQYhSatlqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWQqQsgd0PtUDd1o5tV8k61iKbsZDFmH1wBO61w5NgMTvJA02
	I4ykhu5ppow4sVERusbFGXmRYMmcKJSRvCGzdiBqhYTpHZPeGYYQBdoqcUQg63ek9e81vR/EpQ6
	rkphwzjRukOTcGFzueNEOhfLRP0VFmsXCWPrf
X-Gm-Gg: ASbGncvCvQcVhN345FRdubRvZmdfrQxJy4ZaxsnIB2UFDojkiIRdWW5oe4IYCFof8ZZ
	0OT9/QHlyeJMXTsnJ4yIawEfBC4wWArefQ8HnUVYksVS26lymt4HgcQypAsdWwgZ0PuhAXhOR6C
	5wvs5bx3q13UkAvN+1eaWdessxq/QjIhe9tL5jBwa7m6yPBYMYT2Nr24EOm/Y=
X-Google-Smtp-Source: AGHT+IHSB04tBSW+Z7KYy5xTLyH1se2r+v919O73Ygx407YmZX9n7zbmBy8DtITaRXN/cqKLUXbKwVYEidOnAMnJqKE=
X-Received: by 2002:a05:6808:181c:b0:3f6:769b:56e8 with SMTP id
 5614622812f47-3f6831fe2a2mr745572b6e.7.1741188611147; Wed, 05 Mar 2025
 07:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305021711.3867874-1-jeffxu@google.com> <dfc9d260-ad0d-404d-8b90-fbcc5ce212df@lucifer.local>
In-Reply-To: <dfc9d260-ad0d-404d-8b90-fbcc5ce212df@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 5 Mar 2025 07:29:59 -0800
X-Gm-Features: AQ5f1JpmPA1PDfBWtfjrkZLUmrQFxsJpyVBNI69QbozoCWMZFvLED0uZhWOGskk
Message-ID: <CABi2SkX2zLNPdQMuS6JmYPaQCRa3WeKYa74rGu3UfmvqZY+HbA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 9:51=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Mar 05, 2025 at 02:17:04AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This is V9 version, addressing comments from V8, without code logic
> > change.
> >
> > -------------------------------------------------------------------
> > As discussed during mseal() upstream process [1], mseal() protects
> > the VMAs of a given virtual memory range against modifications, such
> > as the read/write (RW) and no-execute (NX) bits. For complete
> > descriptions of memory sealing, please see mseal.rst [2].
> >
> > The mseal() is useful to mitigate memory corruption issues where a
> > corrupted pointer is passed to a memory management system. For
> > example, such an attacker primitive can break control-flow integrity
> > guarantees since read-only memory that is supposed to be trusted can
> > become writable or .text pages can get remapped.
> >
> > The system mappings are readonly only, memory sealing can protect
> > them from ever changing to writable or unmmap/remapped as different
> > attributes.
> >
> > System mappings such as vdso, vvar, vvar_vclock,
> > vectors (arm compat-mode), sigpage (arm compat-mode),
> > are created by the kernel during program initialization, and could
> > be sealed after creation.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [3]. It could be sealed from creation.
> >
> > The vsyscall on x86-64 uses a special address (0xffffffffff600000),
> > which is outside the mm managed range. This means mprotect, munmap, and
> > mremap won't work on the vsyscall. Since sealing doesn't enhance
> > the vsyscall's security, it is skipped in this patch. If we ever seal
> > the vsyscall, it is probably only for decorative purpose, i.e. showing
> > the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the system mappings during restore operations. UML(User Mode Linu=
x)
> > and gVisor, rr are also known to change the vdso/vvar mappings.
> > Consequently, this feature cannot be universally enabled across all
> > systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.
> >
> > To support mseal of system mappings, architectures must define
> > CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS and update their special
> > mappings calls to pass mseal flag. Additionally, architectures must
> > confirm they do not unmap/remap system mappings during the process
> > lifetime. The existence of this flag for an architecture implies that
> > it does not require the remapping of thest system mappings during
> > process lifetime, so sealing these mappings is safe from a kernel
> > perspective.
> >
> > This version covers x86-64 and arm64 archiecture as minimum viable feat=
ure.
> >
> > While no specific CPU hardware features are required for enable this
> > feature on an archiecture, memory sealing requires a 64-bit kernel. Oth=
er
> > architectures can choose whether or not to adopt this feature. Currentl=
y,
> > I'm not aware of any instances in the kernel code that actively
> > munmap/mremap a system mapping without a request from userspace. The PP=
C
> > does call munmap when _install_special_mapping fails for vdso; however,
> > it's uncertain if this will ever fail for PPC - this needs to be
> > investigated by PPC in the future [4]. The UML kernel can add this supp=
ort
> > when KUnit tests require it [5].
> >
> > In this version, we've improved the handling of system mapping sealing =
from
> > previous versions, instead of modifying the _install_special_mapping
> > function itself, which would affect all architectures, we now call
> > _install_special_mapping with a sealing flag only within the specific
> > architecture that requires it. This targeted approach offers two key
> > advantages: 1) It limits the code change's impact to the necessary
> > architectures, and 2) It aligns with the software architecture by keepi=
ng
> > the core memory management within the mm layer, while delegating the
> > decision of sealing system mappings to the individual architecture, whi=
ch
> > is particularly relevant since 32-bit architectures never require seali=
ng.
> >
> > Prior to this patch series, we explored sealing special mappings from
> > userspace using glibc's dynamic linker. This approach revealed several
> > issues:
> > - The PT_LOAD header may report an incorrect length for vdso, (smaller
> >   than its actual size). The dynamic linker, which relies on PT_LOAD
> >   information to determine mapping size, would then split and partially
> >   seal the vdso mapping. Since each architecture has its own vdso/vvar
> >   code, fixing this in the kernel would require going through each
> >   archiecture. Our initial goal was to enable sealing readonly mappings=
,
> >   e.g. .text, across all architectures, sealing vdso from kernel since
> >   creation appears to be simpler than sealing vdso at glibc.
> > - The [vvar] mapping header only contains address information, not leng=
th
> >   information. Similar issues might exist for other special mappings.
> > - Mappings like uprobe are not covered by the dynamic linker,
> >   and there is no effective solution for them.
> >
> > This feature's security enhancements will benefit ChromeOS, Android,
> > and other high security systems.
> >
> > Testing:
> > This feature was tested on ChromeOS and Android for both x86-64 and ARM=
64.
> > - Enable sealing and verify vdso/vvar, sigpage, vector are sealed prope=
rly,
> >   i.e. "sl" shown in the smaps for those mappings, and mremap is blocke=
d.
> > - Passing various automation tests (e.g. pre-checkin) on ChromeOS and
> >   Android to ensure the sealing doesn't affect the functionality of
> >   Chromebook and Android phone.
> >
> > I also tested the feature on Ubuntu on x86-64:
> > - With config disabled, vdso/vvar is not sealed,
> > - with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK=
,
> >   normal operations such as browsing the web, open/edit doc are OK.
> >
> > Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromi=
um.org/ [1]
> > Link: Documentation/userspace-api/mseal.rst [2]
> > Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4X=
kRkL-NrCZxYAyg@mail.gmail.com/ [3]
> > Link: https://lore.kernel.org/all/CABi2SkV6JJwJeviDLsq9N4ONvQ=3DEFANsiW=
kgiEOjyT9TQSt+HA@mail.gmail.com/ [4]
> > Link: https://lore.kernel.org/all/202502251035.239B85A93@keescook/ [5]
> >
> > -------------------------------------------
> > History:
> >
> > V9:
> >  - Add negative test in selftest (Kees Cook)
> >  - fx typos in text (Kees Cook)
>
> You have a bad habit of missing stuff off these logs. Usually I don't
> comment, as it's trivial, but while we're here :)
>
> Please try to keep an accurate log of changes requested so you can popula=
te
> these properly.
>
> Obviously this is not going to block anything. But for future reference..=
.
>
>   - Add selftest to main selftest Makefile (Lorenzo Stoakes)
>
> >
> > V8:
>
> Nit, but no lore link?
https://lore.kernel.org/all/20250303050921.3033083-1-jeffxu@google.com/

Thanks for noticing this.

>
> >   - Change ARCH_SUPPORTS_MSEAL_X to ARCH_SUPPORTS_MSEAL_X (Liam R. Howl=
ett)
> >   - Update comments in Kconfig and mseal.rst (Lorenzo Stoakes, Liam R. =
Howlett)
> >   - Change patch header perfix to "mseal sysmap" (Lorenzo Stoakes)
> >   - Remove "vm_flags =3D" (Kees Cook, Liam R. Howlett,  Oleg Nesterov)
> >   - Drop uml architecture (Lorenzo Stoakes, Kees Cook)
> >   - Add a selftest to verify system mappings are sealed (Lorenzo Stoake=
s)
> >
> > V7:
> >   https://lore.kernel.org/all/20250224225246.3712295-1-jeffxu@google.co=
m/
> >   - Remove cover letter from the first patch (Liam R. Howlett)
> >   - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
> >   - logging and fclose() in selftest (Liam R. Howlett)
> >
> > V6:
> >   https://lore.kernel.org/all/20250224174513.3600914-1-jeffxu@google.co=
m/
> >   - mseal.rst: fix a typo (Randy Dunlap)
> >   - security/Kconfig: add rr into note (Liam R. Howlett)
> >   - remove mseal_system_mappings() and use macro instead (Liam R. Howle=
tt)
> >   - mseal.rst: add incompatible userland software (Lorenzo Stoakes)
> >   - remove RFC from title (Kees Cook)
> >
> > V5
> >   https://lore.kernel.org/all/20250212032155.1276806-1-jeffxu@google.co=
m/
> >   - Remove kernel cmd line (Lorenzo Stoakes)
> >   - Add test info (Lorenzo Stoakes)
> >   - Add threat model info (Lorenzo Stoakes)
> >   - Fix x86 selftest: test_mremap_vdso
> >   - Restrict code change to ARM64/x86-64/UM arch only.
> >   - Add userprocess.h to include seal_system_mapping().
> >   - Remove sealing vsyscall.
> >   - Split the patch.
> >
> > V4:
> >   https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.co=
m/
> >   - ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
> >   - test info (Lorenzo Stoakes)
> >   - Update  mseal.rst (Liam R. Howlett)
> >   - Update test_mremap_vdso.c (Liam R. Howlett)
> >   - Misc. style, comments, doc update (Liam R. Howlett)
> >
> > V3:
> >   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.co=
m/
> >   - Revert uprobe to v1 logic (Oleg Nesterov)
> >   - use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Coo=
k)
> >   - Move kernel cmd line from fs/exec.c to mm/mseal.c and
> >     misc. (Liam R. Howlett)
> >
> > V2:
> >   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
> >   - Seal uprobe always (Oleg Nesterov)
> >   - Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg=
 Nesterov)
> >   - Rebase to linux_main
> >
> > V1:
> >  - https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.c=
om/
> >
> > --------------------------------------------------
> >
> >
> >
> > Jeff Xu (7):
> >   mseal sysmap: kernel config and header change
> >   selftests: x86: test_mremap_vdso: skip if vdso is msealed
> >   mseal sysmap: enable x86-64
> >   mseal sysmap: enable arm64
> >   mseal sysmap: uprobe mapping
> >   mseal sysmap: update mseal.rst
> >   selftest: test system mappings are sealed.
> >
> >  Documentation/userspace-api/mseal.rst         |  20 +++
> >  arch/arm64/Kconfig                            |   1 +
> >  arch/arm64/kernel/vdso.c                      |  12 +-
> >  arch/x86/Kconfig                              |   1 +
> >  arch/x86/entry/vdso/vma.c                     |   7 +-
> >  include/linux/mm.h                            |  10 ++
> >  init/Kconfig                                  |  22 ++++
> >  kernel/events/uprobes.c                       |   3 +-
> >  security/Kconfig                              |  21 ++++
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../mseal_system_mappings/.gitignore          |   2 +
> >  .../selftests/mseal_system_mappings/Makefile  |   6 +
> >  .../selftests/mseal_system_mappings/config    |   1 +
> >  .../mseal_system_mappings/sysmap_is_sealed.c  | 119 ++++++++++++++++++
> >  .../testing/selftests/x86/test_mremap_vdso.c  |  43 +++++++
> >  15 files changed, 261 insertions(+), 8 deletions(-)
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/.giti=
gnore
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/Makef=
ile
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/confi=
g
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/sysma=
p_is_sealed.c
> >
> > --
> > 2.48.1.711.g2feabab25a-goog
> >

