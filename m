Return-Path: <linux-kselftest+bounces-34333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37EACE4CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F403A83C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE020CCCC;
	Wed,  4 Jun 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ALjV9fH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D41FFC5F
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065546; cv=none; b=QnNtwdEMy+nSK8epA1WvO0hfJfw55aq/t+xaz+wwlI7iLgDi60oCmPKeHAVKxn3SD4gIiPSR4fJ1KFGEkhnIhhuRcVB6028XqjLirU0IZkX88u6P7AaRB7LVTHjOEy/pvo4X5lDA6R+GMGGV3LHw9qhnbVmUs/GCf2XSahHKNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065546; c=relaxed/simple;
	bh=0mlho0POe2StDCBp+Me3F4cHnlqw0KE9iIP7T2C2kb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZztv7/xyAsvHbWxeci1Lm4Taw3C9Gc/jPzNz9HQR6RYYvQt/HcS7tjRztFkkdCkokIeE4QAT0Q8Xr9H4lfv1sNc/k025yi1Mg2PxfTBsZ7YE4M/QVk6IKCxKbd3d7ytTeSi2ghOyFWMRwuFwxvTsOrpsTBk8VF8c6+rJJkcDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ALjV9fH9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b271f3ae786so132292a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749065544; x=1749670344; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NX/Z2ZCFXvF2DvUI6aHShSd2vbVmdhiwIYLPP28K2UE=;
        b=ALjV9fH9WjVJOjQw//u8Pkuw4rN2CPCFQ06S2vgSmPouDt4cGouAr/srHFIHd9xPfN
         IgBxfXZgDxAswLM0VNe7wsiK0MbZeb/uvUGTHus9Fzjistkac91OmceHydrozZEQqgYf
         pfX+9SzIxxipbXgHznaYM0Rxuhh2AO3HQwwv/hqHqMzPRZwwH14yEMSQvgLue0iaLtq4
         BwZQWIIStFmPia6BY+LJvJ3oBaV1mT6qDUZWEg8PiCBPmZYBM5phhu5xratprsBknZLt
         27Xz8nJC0DRzTRjqYH/z5EK5UrCi5r6xNDgqphlIhDR0tg+MUvAi2lKm1mIBZJ7xuxWd
         zG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065544; x=1749670344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NX/Z2ZCFXvF2DvUI6aHShSd2vbVmdhiwIYLPP28K2UE=;
        b=cGLR3U7FOjw/9Lfg15XUaIYBfPO8PCrwiWocKyhfrh1zuysBG/qyj6A7bIe4uJnjXH
         vdzSGpe4RmpyJmuxm7TVas1RmnTmAypTgVMA5OWJUornfrV3EFs4CYTxJy5WJywrOsN2
         JH0vkg4sakD90mWBRMfKn2FG6u9Me6nYsgq1oSoxBeM3j12WAAQBgfi24W+Gmx0wEBIp
         TDvYsyLKsF7ulF65Ev00soP7m48OAUekKPphTV0VX8CunX8Z8xtugSECund+GIELspOo
         0vUAMbzvWT5R3uGvAbuV3+84EPe2T14HfivTBYhspcT64y5yGatDtdAZvBRZFCBcEWAe
         cW6A==
X-Forwarded-Encrypted: i=1; AJvYcCWZKo5IK/r9108GuiBqdSbQ8Xr2kZktHySCxMGFb24Gc2c6jyCiGJKPIQPgVRXStoQNsM98vlyuiroExACaQwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+X8CEc+AXuQ4ijyYtL2RQxrLN5sZHMyRJWQzkwp6ih37h1IzZ
	9b2FqiQNMlr8H52uipze2bzv+G+06npfk/STChjkKhboOTg3jbTXXUZllOcKyffPvL4=
X-Gm-Gg: ASbGncsc/49h6Zk/8oqO0Z1LnBtadW1fTVlbtwf46BYPsKgzZtk278OdNJAc9qbaFR8
	c/5q+0Hwg7fJ2l27LGf1waGUDDWoXHZu45ayyXn/8qg/AOA6CtYYxyqt+2T6PVFyTqIfvUbUMoA
	qStT7tQ3Ku+waSNib3R9kHr56fyu+VrBVwCbKIhzrYl+a1Sa+FktmG0SJCwuGVys3TK/LZ2W4UC
	lc4I4ihMF91Vme0rwfrFAOJoGHRfjnpdtY1D1hq9xNA4NnLlue4Y0g4Uq248RqTCFF2KTLc1MH1
	6WWhjbeiXRG/ZQwigNDrFS/YFseKgnkMsHTYlk9mmQ==
X-Google-Smtp-Source: AGHT+IFLeN5tBysOV9rnQFTJ45qBsmpEqs3WhKfupnGpcc7ue7whOvYTzRW3AaxeC9M+Me0Ca9V3Ig==
X-Received: by 2002:a17:90b:1e07:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-31310fff2d3mr4850333a91.8.1749065543993;
        Wed, 04 Jun 2025 12:32:23 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3132bff67ddsm39458a91.2.2025.06.04.12.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:32:23 -0700 (PDT)
Date: Wed, 4 Jun 2025 12:32:21 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: cleger@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
	anup@brainfault.org, atishp@atishpatra.org, shuah@kernel.org,
	corbet@lwn.net, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org, samuel.holland@sifive.com,
	ajones@ventanamicro.com, debug@rivosinc.com
Subject: Re: [PATCH v8 00/14] riscv: add SBI FWFT misaligned exception
 delegation support
Message-ID: <aECfReNdxc1ERz6K@ghost>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <mhng-C1CE13EE-C4E6-490D-ABF4-CE7BD84737C3@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-C1CE13EE-C4E6-490D-ABF4-CE7BD84737C3@palmerdabbelt-mac>

On Wed, Jun 04, 2025 at 11:02:35AM -0700, Palmer Dabbelt wrote:
> On Fri, 23 May 2025 03:19:17 PDT (-0700), cleger@rivosinc.com wrote:
> > The SBI Firmware Feature extension allows the S-mode to request some
> > specific features (either hardware or software) to be enabled. This
> > series uses this extension to request misaligned access exception
> > delegation to S-mode in order to let the kernel handle it. It also adds
> > support for the KVM FWFT SBI extension based on the misaligned access
> > handling infrastructure.
> > 
> > FWFT SBI extension is part of the SBI V3.0 specifications [1]. It can be
> > tested using the qemu provided at [2] which contains the series from
> > [3]. Upstream kvm-unit-tests can be used inside kvm to tests the correct
> > delegation of misaligned exceptions. Upstream OpenSBI can be used.
> > 
> > Note: Since SBI V3.0 is not yet ratified, FWFT extension API is split
> > between interface only and implementation, allowing to pick only the
> > interface which do not have hard dependencies on SBI.
> > 
> > The tests can be run using the kselftest from series [4].
> > 
> > $ qemu-system-riscv64 \
> > 	-cpu rv64,trap-misaligned-access=true,v=true \
> > 	-M virt \
> > 	-m 1024M \
> > 	-bios fw_dynamic.bin \
> > 	-kernel Image
> >  ...
> > 
> >  # ./misaligned
> >  TAP version 13
> >  1..23
> >  # Starting 23 tests from 1 test cases.
> >  #  RUN           global.gp_load_lh ...
> >  #            OK  global.gp_load_lh
> >  ok 1 global.gp_load_lh
> >  #  RUN           global.gp_load_lhu ...
> >  #            OK  global.gp_load_lhu
> >  ok 2 global.gp_load_lhu
> >  #  RUN           global.gp_load_lw ...
> >  #            OK  global.gp_load_lw
> >  ok 3 global.gp_load_lw
> >  #  RUN           global.gp_load_lwu ...
> >  #            OK  global.gp_load_lwu
> >  ok 4 global.gp_load_lwu
> >  #  RUN           global.gp_load_ld ...
> >  #            OK  global.gp_load_ld
> >  ok 5 global.gp_load_ld
> >  #  RUN           global.gp_load_c_lw ...
> >  #            OK  global.gp_load_c_lw
> >  ok 6 global.gp_load_c_lw
> >  #  RUN           global.gp_load_c_ld ...
> >  #            OK  global.gp_load_c_ld
> >  ok 7 global.gp_load_c_ld
> >  #  RUN           global.gp_load_c_ldsp ...
> >  #            OK  global.gp_load_c_ldsp
> >  ok 8 global.gp_load_c_ldsp
> >  #  RUN           global.gp_load_sh ...
> >  #            OK  global.gp_load_sh
> >  ok 9 global.gp_load_sh
> >  #  RUN           global.gp_load_sw ...
> >  #            OK  global.gp_load_sw
> >  ok 10 global.gp_load_sw
> >  #  RUN           global.gp_load_sd ...
> >  #            OK  global.gp_load_sd
> >  ok 11 global.gp_load_sd
> >  #  RUN           global.gp_load_c_sw ...
> >  #            OK  global.gp_load_c_sw
> >  ok 12 global.gp_load_c_sw
> >  #  RUN           global.gp_load_c_sd ...
> >  #            OK  global.gp_load_c_sd
> >  ok 13 global.gp_load_c_sd
> >  #  RUN           global.gp_load_c_sdsp ...
> >  #            OK  global.gp_load_c_sdsp
> >  ok 14 global.gp_load_c_sdsp
> >  #  RUN           global.fpu_load_flw ...
> >  #            OK  global.fpu_load_flw
> >  ok 15 global.fpu_load_flw
> >  #  RUN           global.fpu_load_fld ...
> >  #            OK  global.fpu_load_fld
> >  ok 16 global.fpu_load_fld
> >  #  RUN           global.fpu_load_c_fld ...
> >  #            OK  global.fpu_load_c_fld
> >  ok 17 global.fpu_load_c_fld
> >  #  RUN           global.fpu_load_c_fldsp ...
> >  #            OK  global.fpu_load_c_fldsp
> >  ok 18 global.fpu_load_c_fldsp
> >  #  RUN           global.fpu_store_fsw ...
> >  #            OK  global.fpu_store_fsw
> >  ok 19 global.fpu_store_fsw
> >  #  RUN           global.fpu_store_fsd ...
> >  #            OK  global.fpu_store_fsd
> >  ok 20 global.fpu_store_fsd
> >  #  RUN           global.fpu_store_c_fsd ...
> >  #            OK  global.fpu_store_c_fsd
> >  ok 21 global.fpu_store_c_fsd
> >  #  RUN           global.fpu_store_c_fsdsp ...
> >  #            OK  global.fpu_store_c_fsdsp
> >  ok 22 global.fpu_store_c_fsdsp
> >  #  RUN           global.gen_sigbus ...
> >  [12797.988647] misaligned[618]: unhandled signal 7 code 0x1 at 0x0000000000014dc0 in misaligned[4dc0,10000+76000]
> >  [12797.988990] CPU: 0 UID: 0 PID: 618 Comm: misaligned Not tainted 6.13.0-rc6-00008-g4ec4468967c9-dirty #51
> >  [12797.989169] Hardware name: riscv-virtio,qemu (DT)
> >  [12797.989264] epc : 0000000000014dc0 ra : 0000000000014d00 sp : 00007fffe165d100
> >  [12797.989407]  gp : 000000000008f6e8 tp : 0000000000095760 t0 : 0000000000000008
> >  [12797.989544]  t1 : 00000000000965d8 t2 : 000000000008e830 s0 : 00007fffe165d160
> >  [12797.989692]  s1 : 000000000000001a a0 : 0000000000000000 a1 : 0000000000000002
> >  [12797.989831]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffffdeadbeef
> >  [12797.989964]  a5 : 000000000008ef61 a6 : 626769735f6e0000 a7 : fffffffffffff000
> >  [12797.990094]  s2 : 0000000000000001 s3 : 00007fffe165d838 s4 : 00007fffe165d848
> >  [12797.990238]  s5 : 000000000000001a s6 : 0000000000010442 s7 : 0000000000010200
> >  [12797.990391]  s8 : 000000000000003a s9 : 0000000000094508 s10: 0000000000000000
> >  [12797.990526]  s11: 0000555567460668 t3 : 00007fffe165d070 t4 : 00000000000965d0
> >  [12797.990656]  t5 : fefefefefefefeff t6 : 0000000000000073
> >  [12797.990756] status: 0000000200004020 badaddr: 000000000008ef61 cause: 0000000000000006
> >  [12797.990911] Code: 8793 8791 3423 fcf4 3783 fc84 c737 dead 0713 eef7 (c398) 0001
> >  #            OK  global.gen_sigbus
> >  ok 23 global.gen_sigbus
> >  # PASSED: 23 / 23 tests passed.
> >  # Totals: pass:23 fail:0 xfail:0 xpass:0 skip:0 error:0
> > 
> > With kvm-tools:
> > 
> >  # lkvm run -k sbi.flat -m 128
> >   Info: # lkvm run -k sbi.flat -m 128 -c 1 --name guest-97
> >   Info: Removed ghost socket file "/root/.lkvm//guest-97.sock".
> > 
> >  ##########################################################################
> >  #    kvm-unit-tests
> >  ##########################################################################
> > 
> >  ... [test messages elided]
> >  PASS: sbi: fwft: FWFT extension probing no error
> >  PASS: sbi: fwft: get/set reserved feature 0x6 error == SBI_ERR_DENIED
> >  PASS: sbi: fwft: get/set reserved feature 0x3fffffff error == SBI_ERR_DENIED
> >  PASS: sbi: fwft: get/set reserved feature 0x80000000 error == SBI_ERR_DENIED
> >  PASS: sbi: fwft: get/set reserved feature 0xbfffffff error == SBI_ERR_DENIED
> >  PASS: sbi: fwft: misaligned_deleg: Get misaligned deleg feature no error
> >  PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature invalid value error
> >  PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature invalid value error
> >  PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value no error
> >  PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value 0
> >  PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value no error
> >  PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value 1
> >  PASS: sbi: fwft: misaligned_deleg: Verify misaligned load exception trap in supervisor
> >  SUMMARY: 50 tests, 2 unexpected failures, 12 skipped
> > 
> > This series is available at [5].
> > 
> > Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/vv3.0-rc2/riscv-sbi.pdf [1]
> > Link: https://github.com/rivosinc/qemu/tree/dev/cleger/misaligned [2]
> > Link: https://lore.kernel.org/all/20241211211933.198792-3-fkonrad@amd.com/T/ [3]
> > Link: https://lore.kernel.org/linux-riscv/20250414123543.1615478-1-cleger@rivosinc.com [4]
> > Link: https://github.com/rivosinc/linux/tree/dev/cleger/fwft [5]
> > ---
> > 
> > V8:
> >  - Move misaligned_access_speed under CONFIG_RISCV_MISALIGNED and add a
> >    separate commit for that.
> > 
> > V7:
> >  - Fix ifdefery build problems
> >  - Move sbi_fwft_is_supported with fwft_set_req struct
> >  - Added Atish Reviewed-by
> >  - Updated KVM vcpu cfg hedeleg value in set_delegation
> >  - Changed SBI ETIME error mapping to ETIMEDOUT
> >  - Fixed a few typo reported by Alok
> > 
> > V6:
> >  - Rename FWFT interface to remove "_local"
> >  - Fix test for MEDELEG values in KVM FWFT support
> >  - Add __init for unaligned_access_init()
> >  - Rebased on master
> > 
> > V5:
> >  - Return ERANGE as mapping for SBI_ERR_BAD_RANGE
> >  - Removed unused sbi_fwft_get()
> >  - Fix kernel for sbi_fwft_local_set_cpumask()
> >  - Fix indentation for sbi_fwft_local_set()
> >  - Remove spurious space in kvm_sbi_fwft_ops.
> >  - Rebased on origin/master
> >  - Remove fixes commits and sent them as a separate series [4]
> > 
> > V4:
> >  - Check SBI version 3.0 instead of 2.0 for FWFT presence
> >  - Use long for kvm_sbi_fwft operation return value
> >  - Init KVM sbi extension even if default_disabled
> >  - Remove revert_on_fail parameter for sbi_fwft_feature_set().
> >  - Fix comments for sbi_fwft_set/get()
> >  - Only handle local features (there are no globals yet in the spec)
> >  - Add new SBI errors to sbi_err_map_linux_errno()
> > 
> > V3:
> >  - Added comment about kvm sbi fwft supported/set/get callback
> >    requirements
> >  - Move struct kvm_sbi_fwft_feature in kvm_sbi_fwft.c
> >  - Add a FWFT interface
> > 
> > V2:
> >  - Added Kselftest for misaligned testing
> >  - Added get_user() usage instead of __get_user()
> >  - Reenable interrupt when possible in misaligned access handling
> >  - Document that riscv supports unaligned-traps
> >  - Fix KVM extension state when an init function is present
> >  - Rework SBI misaligned accesses trap delegation code
> >  - Added support for CPU hotplugging
> >  - Added KVM SBI reset callback
> >  - Added reset for KVM SBI FWFT lock
> >  - Return SBI_ERR_DENIED_LOCKED when LOCK flag is set
> > 
> > Clément Léger (14):
> >   riscv: sbi: add Firmware Feature (FWFT) SBI extensions definitions
> >   riscv: sbi: remove useless parenthesis
> >   riscv: sbi: add new SBI error mappings
> >   riscv: sbi: add FWFT extension interface
> >   riscv: sbi: add SBI FWFT extension calls
> >   riscv: misaligned: request misaligned exception from SBI
> >   riscv: misaligned: use on_each_cpu() for scalar misaligned access
> >     probing
> >   riscv: misaligned: declare misaligned_access_speed under
> >     CONFIG_RISCV_MISALIGNED
> >   riscv: misaligned: move emulated access uniformity check in a function
> >   riscv: misaligned: add a function to check misalign trap delegability
> >   RISC-V: KVM: add SBI extension init()/deinit() functions
> >   RISC-V: KVM: add SBI extension reset callback
> >   RISC-V: KVM: add support for FWFT SBI extension
> >   RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG
> > 
> >  arch/riscv/include/asm/cpufeature.h        |  14 +-
> >  arch/riscv/include/asm/kvm_host.h          |   5 +-
> >  arch/riscv/include/asm/kvm_vcpu_sbi.h      |  12 +
> >  arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  29 +++
> >  arch/riscv/include/asm/sbi.h               |  60 +++++
> >  arch/riscv/include/uapi/asm/kvm.h          |   1 +
> >  arch/riscv/kernel/sbi.c                    |  81 ++++++-
> >  arch/riscv/kernel/traps_misaligned.c       | 112 ++++++++-
> >  arch/riscv/kernel/unaligned_access_speed.c |   8 +-
> >  arch/riscv/kvm/Makefile                    |   1 +
> >  arch/riscv/kvm/vcpu.c                      |   4 +-
> >  arch/riscv/kvm/vcpu_sbi.c                  |  54 +++++
> >  arch/riscv/kvm/vcpu_sbi_fwft.c             | 257 +++++++++++++++++++++
> >  arch/riscv/kvm/vcpu_sbi_sta.c              |   3 +-
> >  14 files changed, 620 insertions(+), 21 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
> >  create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
> 
> Sorry I'm still kind of out of it here, but I think Alex was saying this has
> dependencies in the patchwork call this morning?

The "dependency" is that the kvm tree will not accept patches this late.
The KVM patches can be dropped and the riscv patches can be merged, but
it is pretty late now.

- Charlie


