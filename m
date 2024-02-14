Return-Path: <linux-kselftest+bounces-4634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A665854C3F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E5C1C27692
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96725C8F1;
	Wed, 14 Feb 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdM0mQ/u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B75C60C
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923504; cv=none; b=H0nrr1nrVIgz0fqnoIJUGKTER9euFuk/ZFn7gOkv9LYXAhWq2xOsqvREXi3n1e2xdwMTAUiiroNo9lTjjj4sxGNEF+m9zzlA4ZXLCJ3pvVR3U7F13hWDuIB79aWjx6Exg37+ivEv1mSNdffZDhp2ThREFyI0dD6EQ1WKZGSbm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923504; c=relaxed/simple;
	bh=stEdLz2b2kf1O6LPDO2yn1MKWkJG2SJcOQnAUy1OlLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tuXViu0EaoKrc//ZFzPwP/saYZClCDyC92p88udxZBxvTxqPqSTSkJVvF1knRB76UhFpWUX+72meJmchq7WuzTVumvOjt9Ub6BbpKjUDU+Ogw6/3X6gvmpJWpirtPPpGXy6zYjAIfgU6YQ1NBC6l/rzQzuTIO6fsY1wHLkzdupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdM0mQ/u; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso3657909b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 07:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707923502; x=1708528302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKRvUfP65U1ffniAVOOvF4GghsVtSOXabt1zX4dzt/E=;
        b=WdM0mQ/u3ZapvLiMuZ4etKN0DEMtCEl19GNBNYk/kQ3DRDObi26kdo0Zc2/iKkwucQ
         0Az1ew+1cnoC2Hl7FHp0IJefSnIWHjwyY74GQXuiq3LJjWcq8RVjvpc+zNADQKKNIZbz
         of2eBV+8MK6srQpYUBDqGDkrmIVxgoud+1YdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923502; x=1708528302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKRvUfP65U1ffniAVOOvF4GghsVtSOXabt1zX4dzt/E=;
        b=ImD6LY6nnwhAZmDJ2EI4Sm99PwZmZJAdeTTGUKQIFAMOSE2FRZ+fwGTndjeoda43pn
         cLBZ0twfB1Y2rShnqpeewV6Nxy+fXTCzX0A4TMJQniCiYEY7+ZjOkdb+88IKtUcntATW
         7vxIHDOjjIXq3SioorlhGSSpE+Jz+RxAERnhsKBH3N3aXnOKLQFOJeVYOe5yYVOMt/ZV
         CCubbuq+a6aeMbRezbRCbq7lCF4yrVN/cNBkGq94jI88eABDV3/mTLtzTyAkMjiw9kBz
         M5EgVPK3OVfcEblTWZfS7i5BYcnpGgyDVcqt+hGMOQURwo4LDZmgNOW66IOE4z43qlNY
         udjg==
X-Forwarded-Encrypted: i=1; AJvYcCXx6Fa+U95KzmJUoCAJjlfzrVLDTiMlWFSu2S/tcUy3hVgRMHhcoPn3MIEeefJhnO71B4+6m5nGPRwXIasVlPtGjl8Jr+P4fEaMlbHSkyd4
X-Gm-Message-State: AOJu0YwHPi8Ql/eidKBMQgt+TJ8qcd0QEn9h/PaAizU26HniTjgP1XQZ
	LHw8iTMqHVKixJo0xYB2rbkVlK3axb0ECQrWVKD1zIWUyJ0QUhAA2Al3zUPB9A==
X-Google-Smtp-Source: AGHT+IESOqUgJ1EXWILtEIXTZYHo7bR+fFPqUnEPAyT89Pf7hLBaK/1lzubgs3upFpwd/D2AfJCo+Q==
X-Received: by 2002:a05:6a00:3d4e:b0:6d9:b4e6:ffb with SMTP id lp14-20020a056a003d4e00b006d9b4e60ffbmr3251999pfb.0.1707923501151;
        Wed, 14 Feb 2024 07:11:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxXBz5qGx0tCJZifpxATH9+pffWgqXdmzgcgWCWue9XHwP0sVrx4++52k2jCuOK0edeMjmGdbQdwA0gi9ZyjQAd4sRLrcperpsDJis1E1VQ6f8IA9FpYW1q6MT6Bxt5WKSQIsuetpfnKw2PYxzvL3OC1SGXWMtKcvYiRMc6Kbd6vsC6/tF8fUBWP2+s8OcvV1QB+wVDxFXbczBNWhMqlsQYxuYhEYpAZyVffykeiH7820vUs+1gKRKoAxshXLW3i3pkpSC2NgdYJaCkMGrgCw9aFAwjW+bHSgMzlepqMpHAzShhqqAYFksYZ+cA4Loh/ZbToJHKMFm+Ov1SepAgsvOQWgf2DSmWx1DV+5YwXJwq22YdgJ+Y8oO41bBiIRldOOtSzyuZTbQmVyaSo3Qb+0rw/veTdGHB78z53nKBs/FR6ItYLBvJEVeYYj+5VwVvIv36Xr3G+ujUiCVCN8mjKbiKixxmiV8x+XFU5WiEpR06+qNQ69eT5VHkDCzdUUaxpXc1OyjTkMNmUiCJwAp5Q7vrBDb3qEV2HPKISEazJvdc6w1yGm+fcocKMZirE+J0ls8/7vJElK3e2eqcI7OjiQz+RTMmwvg+V/qm72xrT5+YaENDBNdrnGgh/yRnfnQEaR7E3JdP3hDTqUQQSwK0tXdRW5ZceagUOc7xPQO76CUfRpgo2Z0QfKZIqkRtRIC7Wwabsw1lVk24Y2W6Qi7KVb7iwpoegSWkrgp3JZF650uzHq+zTKKTEuzd5kez/hKNxuEdbi17Av3Rh1qQP2JWyYHP7Y=
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with UTF8SMTPSA id y23-20020aa78557000000b006e09ec69d7dsm9164968pfn.98.2024.02.14.07.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:11:40 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	=David.Laight@aculab.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v9 0/5] Introduce mseal
Date: Wed, 14 Feb 2024 15:11:24 +0000
Message-ID: <20240214151130.616240-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is V9 version, with removing MAP_SEALABLE and PROT_SEAL
from mmap(), adding perfrmance benchmark and a test
to demo the sealing of read-only memory segment of elf mapping.

------------------------------------------------------------------

This patchset proposes a new mseal() syscall for the Linux kernel.

In a nutshell, mseal() protects the VMAs of a given virtual memory
range against modifications, such as changes to their permission bits.

Modern CPUs support memory permissions, such as the read/write (RW)
and no-execute (NX) bits. Linux has supported NX since the release of
kernel version 2.6.8 in August 2004 [1]. The memory permission feature
improves the security stance on memory corruption bugs, as an attacker
cannot simply write to arbitrary memory and point the code to it. The
memory must be marked with the X bit, or else an exception will occur.
Internally, the kernel maintains the memory permissions in a data
structure called VMA (vm_area_struct). mseal() additionally protects
the VMA itself against modifications of the selected seal type.

Memory sealing is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped. Memory sealing can
automatically be applied by the runtime loader to seal .text and
.rodata pages and applications can additionally seal security critical
data at runtime. A similar feature already exists in the XNU kernel
with the VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the
mimmutable syscall [4]. Also, Chrome wants to adopt this feature for
their CFI work [2] and this patchset has been designed to be
compatible with the Chrome use case.

Two system calls are involved in sealing the map:  mmap() and mseal().

The new mseal() is an syscall on 64 bit CPU, and with
following signature:

int mseal(void addr, size_t len, unsigned long flags)
addr/len: memory range.
flags: reserved.

mseal() blocks following operations for the given memory range.

1> Unmapping, moving to another location, and shrinking the size,
   via munmap() and mremap(), can leave an empty space, therefore can
   be replaced with a VMA with a new set of attributes.

2> Moving or expanding a different VMA into the current location,
   via mremap().

3> Modifying a VMA via mmap(MAP_FIXED).

4> Size expansion, via mremap(), does not appear to pose any specific
   risks to sealed VMAs. It is included anyway because the use case is
   unclear. In any case, users can rely on merging to expand a sealed VMA.

5> mprotect() and pkey_mprotect().

6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymous
   memory, when users don't have write permission to the memory. Those
   behaviors can alter region contents by discarding pages, effectively a
   memset(0) for anonymous memory.

The idea that inspired this patch comes from Stephen Röttger’s work in
V8 CFI [5]. Chrome browser in ChromeOS will be the first user of this
API.

Indeed, the Chrome browser has very specific requirements for sealing,
which are distinct from those of most applications. For example, in
the case of libc, sealing is only applied to read-only (RO) or
read-execute (RX) memory segments (such as .text and .RELRO) to
prevent them from becoming writable, the lifetime of those mappings
are tied to the lifetime of the process.

Chrome wants to seal two large address space reservations that are
managed by different allocators. The memory is mapped RW- and RWX
respectively but write access to it is restricted using pkeys (or in
the future ARM permission overlay extensions). The lifetime of those
mappings are not tied to the lifetime of the process, therefore, while
the memory is sealed, the allocators still need to free or discard the
unused memory. For example, with madvise(DONTNEED).

However, always allowing madvise(DONTNEED) on this range poses a
security risk. For example if a jump instruction crosses a page
boundary and the second page gets discarded, it will overwrite the
target bytes with zeros and change the control flow. Checking
write-permission before the discard operation allows us to control
when the operation is valid. In this case, the madvise will only
succeed if the executing thread has PKEY write permissions and PKRU
changes are protected in software by control-flow integrity.

Although the initial version of this patch series is targeting the
Chrome browser as its first user, it became evident during upstream
discussions that we would also want to ensure that the patch set
eventually is a complete solution for memory sealing and compatible
with other use cases. The specific scenario currently in mind is
glibc's use case of loading and sealing ELF executables. To this end,
Stephen is working on a change to glibc to add sealing support to the
dynamic linker, which will seal all non-writable segments at startup.
Once this work is completed, all applications will be able to
automatically benefit from these new protections.

In closing, I would like to formally acknowledge the valuable
contributions received during the RFC process, which were instrumental
in shaping this patch:

Jann Horn: raising awareness and providing valuable insights on the
  destructive madvise operations.
Liam R. Howlett: perf optimization.
Linus Torvalds: assisting in defining system call signature and scope.
Theo de Raadt: sharing the experiences and insight gained from
  implementing mimmutable() in OpenBSD.

MM perf benchmarks
==================
This patch adds a loop in the mprotect/munmap/madvise(DONTNEED) to
check the VMAs’ sealing flag, so that no partial update can be made,
when any segment within the given memory range is sealed.

To measure the performance impact of this loop, two tests are developed.
[8]

The first is measuring the time taken for a particular system call,
by using clock_gettime(CLOCK_MONOTONIC). The second is using
PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests have
similar results.

The tests have roughly below sequence:
for (i = 0; i < 1000, i++)
    create 1000 mappings (1 page per VMA)
    start the sampling
    for (j = 0; j < 1000, j++)
        mprotect one mapping
    stop and save the sample
    delete 1000 mappings
calculates all samples.

Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ 2.00GHz,
4G memory, Chromebook.

Based on the latest upstream code:
The first test (measuring time)
syscall__	vmas	t	t_mseal	delta_ns	per_vma	%
munmap__  	1	909	944	35	35	104%
munmap__  	2	1398	1502	104	52	107%
munmap__  	4	2444	2594	149	37	106%
munmap__  	8	4029	4323	293	37	107%
munmap__  	16	6647	6935	288	18	104%
munmap__  	32	11811	12398	587	18	105%
mprotect	1	439	465	26	26	106%
mprotect	2	1659	1745	86	43	105%
mprotect	4	3747	3889	142	36	104%
mprotect	8	6755	6969	215	27	103%
mprotect	16	13748	14144	396	25	103%
mprotect	32	27827	28969	1142	36	104%
madvise_	1	240	262	22	22	109%
madvise_	2	366	442	76	38	121%
madvise_	4	623	751	128	32	121%
madvise_	8	1110	1324	215	27	119%
madvise_	16	2127	2451	324	20	115%
madvise_	32	4109	4642	534	17	113%

The second test (measuring cpu cycle)
syscall__	vmas	cpu	cmseal	delta_cpu	per_vma	%
munmap__	1	1790	1890	100	100	106%
munmap__	2	2819	3033	214	107	108%
munmap__	4	4959	5271	312	78	106%
munmap__	8	8262	8745	483	60	106%
munmap__	16	13099	14116	1017	64	108%
munmap__	32	23221	24785	1565	49	107%
mprotect	1	906	967	62	62	107%
mprotect	2	3019	3203	184	92	106%
mprotect	4	6149	6569	420	105	107%
mprotect	8	9978	10524	545	68	105%
mprotect	16	20448	21427	979	61	105%
mprotect	32	40972	42935	1963	61	105%
madvise_	1	434	497	63	63	115%
madvise_	2	752	899	147	74	120%
madvise_	4	1313	1513	200	50	115%
madvise_	8	2271	2627	356	44	116%
madvise_	16	4312	4883	571	36	113%
madvise_	32	8376	9319	943	29	111%

Based on the result, for 6.8 kernel, sealing check adds
20-40 nano seconds, or around 50-100 CPU cycles, per VMA.

In addition, I applied the sealing to 5.10 kernel:
The first test (measuring time)
syscall__	vmas	t	tmseal	delta_ns	per_vma	%
munmap__	1	357	390	33	33	109%
munmap__	2	442	463	21	11	105%
munmap__	4	614	634	20	5	103%
munmap__	8	1017	1137	120	15	112%
munmap__	16	1889	2153	263	16	114%
munmap__	32	4109	4088	-21	-1	99%
mprotect	1	235	227	-7	-7	97%
mprotect	2	495	464	-30	-15	94%
mprotect	4	741	764	24	6	103%
mprotect	8	1434	1437	2	0	100%
mprotect	16	2958	2991	33	2	101%
mprotect	32	6431	6608	177	6	103%
madvise_	1	191	208	16	16	109%
madvise_	2	300	324	24	12	108%
madvise_	4	450	473	23	6	105%
madvise_	8	753	806	53	7	107%
madvise_	16	1467	1592	125	8	108%
madvise_	32	2795	3405	610	19	122%
					
The second test (measuring cpu cycle)
syscall__	nbr_vma	cpu	cmseal	delta_cpu	per_vma	%
munmap__	1	684	715	31	31	105%
munmap__	2	861	898	38	19	104%
munmap__	4	1183	1235	51	13	104%
munmap__	8	1999	2045	46	6	102%
munmap__	16	3839	3816	-23	-1	99%
munmap__	32	7672	7887	216	7	103%
mprotect	1	397	443	46	46	112%
mprotect	2	738	788	50	25	107%
mprotect	4	1221	1256	35	9	103%
mprotect	8	2356	2429	72	9	103%
mprotect	16	4961	4935	-26	-2	99%
mprotect	32	9882	10172	291	9	103%
madvise_	1	351	380	29	29	108%
madvise_	2	565	615	49	25	109%
madvise_	4	872	933	61	15	107%
madvise_	8	1508	1640	132	16	109%
madvise_	16	3078	3323	245	15	108%
madvise_	32	5893	6704	811	25	114%

For 5.10 kernel, sealing check adds 0-15 ns in time, or 10-30
CPU cycles, there is even decrease in some cases.

It might be interesting to compare 5.10 and 6.8 kernel
The first test (measuring time)
syscall__	vmas	t_5_10	t_6_8	delta_ns	per_vma	%
munmap__	1	357	909	552	552	254%
munmap__	2	442	1398	956	478	316%
munmap__	4	614	2444	1830	458	398%
munmap__	8	1017	4029	3012	377	396%
munmap__	16	1889	6647	4758	297	352%
munmap__	32	4109	11811	7702	241	287%
mprotect	1	235	439	204	204	187%
mprotect	2	495	1659	1164	582	335%
mprotect	4	741	3747	3006	752	506%
mprotect	8	1434	6755	5320	665	471%
mprotect	16	2958	13748	10790	674	465%
mprotect	32	6431	27827	21397	669	433%
madvise_	1	191	240	49	49	125%
madvise_	2	300	366	67	33	122%
madvise_	4	450	623	173	43	138%
madvise_	8	753	1110	357	45	147%
madvise_	16	1467	2127	660	41	145%
madvise_	32	2795	4109	1314	41	147%

The second test (measuring cpu cycle)
syscall__	vmas	cpu_5_10	c_6_8	delta_cpu	per_vma	%
munmap__	1	684	1790	1106	1106	262%
munmap__	2	861	2819	1958	979	327%
munmap__	4	1183	4959	3776	944	419%
munmap__	8	1999	8262	6263	783	413%
munmap__	16	3839	13099	9260	579	341%
munmap__	32	7672	23221	15549	486	303%
mprotect	1	397	906	509	509	228%
mprotect	2	738	3019	2281	1140	409%
mprotect	4	1221	6149	4929	1232	504%
mprotect	8	2356	9978	7622	953	423%
mprotect	16	4961	20448	15487	968	412%
mprotect	32	9882	40972	31091	972	415%
madvise_	1	351	434	82	82	123%
madvise_	2	565	752	186	93	133%
madvise_	4	872	1313	442	110	151%
madvise_	8	1508	2271	763	95	151%
madvise_	16	3078	4312	1234	77	140%
madvise_	32	5893	8376	2483	78	142%

From 5.10 to 6.8
munmap: added 250-550 ns in time, or 500-1100 in cpu cycle, per vma.
mprotect: added 200-750 ns in time, or 500-1200 in cpu cycle, per vma.
madvise: added 33-50 ns in time, or 70-110 in cpu cycle, per vma.

In comparison to mseal, which adds 20-40 ns or 50-100 CPU cycles, the
increase from 5.10 to 6.8 is significantly larger, approximately ten
times greater for munmap and mprotect.

When I discuss the mm performance with Brian Makin, an engineer worked
on performance, it was brought to my attention that such a performance
benchmarks, which measuring millions of mm syscall in a tight loop, may
not accurately reflect real-world scenarios, such as that of a database
service. Also this is tested using a single HW and ChromeOS, the data
from another HW or distribution might be different. It might be best
to take this data with a grain of salt.


Change history:
===============
V9:
- remove mmap(PROT_SEAL) and mmap(MAP_SEALABLE) (Linus, Theo de Raadt)
- Update mseal_test to check for prot bit (Liam R. Howlett)
- Update documentation to give more detail on sealing check (Liam R. Howlett)
- Add seal_elf test.
- Add performance measure data.
- mseal_test: fix arm build.

V8:
- perf optimization in mmap. (Liam R. Howlett)
- add one testcase (test_seal_zero_address) 
- Update mseal.rst to add note for MAP_SEALABLE.
https://lore.kernel.org/lkml/20240131175027.3287009-1-jeffxu@chromium.org/

V7:
- fix index.rst (Randy Dunlap)
- fix arm build (Randy Dunlap)
- return EPERM for blocked operations (Theo de Raadt)
https://lore.kernel.org/linux-mm/20240122152905.2220849-2-jeffxu@chromium.org/T/

V6:
- Drop RFC from subject, Given Linus's general approval.
- Adjust syscall number for mseal (main Jan.11/2024) 
- Code style fix (Matthew Wilcox)
- selftest: use ksft macros (Muhammad Usama Anjum)
- Document fix. (Randy Dunlap)
https://lore.kernel.org/all/20240111234142.2944934-1-jeffxu@chromium.org/

V5:
- fix build issue in mseal-Wire-up-mseal-syscall
  (Suggested by Linus Torvalds, and Greg KH)
- updates on selftest.
https://lore.kernel.org/lkml/20240109154547.1839886-1-jeffxu@chromium.org/#r

V4:
(Suggested by Linus Torvalds)
- new signature: mseal(start,len,flags)
- 32 bit is not supported. vm_seal is removed, use vm_flags instead.
- single bit in vm_flags for sealed state.
- CONFIG_MSEAL kernel config is removed.
- single bit of PROT_SEAL in the "Prot" field of mmap().
Other changes:
- update selftest (Suggested by Muhammad Usama Anjum)
- update documentation.
https://lore.kernel.org/all/20240104185138.169307-1-jeffxu@chromium.org/

V3:
- Abandon per-syscall approach, (Suggested by Linus Torvalds).
- Organize sealing types around their functionality, such as
  MM_SEAL_BASE, MM_SEAL_PROT_PKEY.
- Extend the scope of sealing from calls originated in userspace to
  both kernel and userspace. (Suggested by Linus Torvalds)
- Add seal type support in mmap(). (Suggested by Pedro Falcato)
- Add a new sealing type: MM_SEAL_DISCARD_RO_ANON to prevent
  destructive operations of madvise. (Suggested by Jann Horn and
  Stephen Röttger)
- Make sealed VMAs mergeable. (Suggested by Jann Horn)
- Add MAP_SEALABLE to mmap()
- Add documentation - mseal.rst
https://lore.kernel.org/linux-mm/20231212231706.2680890-2-jeffxu@chromium.org/

v2:
Use _BITUL to define MM_SEAL_XX type.
Use unsigned long for seal type in sys_mseal() and other functions.
Remove internal VM_SEAL_XX type and convert_user_seal_type().
Remove MM_ACTION_XX type.
Remove caller_origin(ON_BEHALF_OF_XX) and replace with sealing bitmask.
Add more comments in code.
Add a detailed commit message.
https://lore.kernel.org/lkml/20231017090815.1067790-1-jeffxu@chromium.org/

v1:
https://lore.kernel.org/lkml/20231016143828.647848-1-jeffxu@chromium.org/

----------------------------------------------------------------
[1] https://kernelnewbies.org/Linux_2_6_8
[2] https://v8.dev/blog/control-flow-integrity
[3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
[4] https://man.openbsd.org/mimmutable.2
[5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
[6] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com/
[7] https://lore.kernel.org/lkml/20230515130553.2311248-1-jeffxu@chromium.org/
[8] https://github.com/peaktocreek/mmperf


Jeff Xu (5):
  mseal: Wire up mseal syscall
  mseal: add mseal syscall
  selftest mm/mseal memory sealing
  mseal:add documentation
  selftest mm/mseal read-only elf memory segment

 Documentation/userspace-api/index.rst       |    1 +
 Documentation/userspace-api/mseal.rst       |  199 ++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
 arch/arm/tools/syscall.tbl                  |    1 +
 arch/arm64/include/asm/unistd.h             |    2 +-
 arch/arm64/include/asm/unistd32.h           |    2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
 arch/s390/kernel/syscalls/syscall.tbl       |    1 +
 arch/sh/kernel/syscalls/syscall.tbl         |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
 include/linux/syscalls.h                    |    1 +
 include/uapi/asm-generic/unistd.h           |    5 +-
 kernel/sys_ni.c                             |    1 +
 mm/Makefile                                 |    4 +
 mm/internal.h                               |   37 +
 mm/madvise.c                                |   12 +
 mm/mmap.c                                   |   31 +-
 mm/mprotect.c                               |   10 +
 mm/mremap.c                                 |   31 +
 mm/mseal.c                                  |  307 ++++
 tools/testing/selftests/mm/.gitignore       |    2 +
 tools/testing/selftests/mm/Makefile         |    2 +
 tools/testing/selftests/mm/mseal_test.c     | 1836 +++++++++++++++++++
 tools/testing/selftests/mm/seal_elf.c       |  183 ++
 33 files changed, 2678 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/userspace-api/mseal.rst
 create mode 100644 mm/mseal.c
 create mode 100644 tools/testing/selftests/mm/mseal_test.c
 create mode 100644 tools/testing/selftests/mm/seal_elf.c

-- 
2.43.0.687.g38aa6559b0-goog


