Return-Path: <linux-kselftest+bounces-44843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A8C37B6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 21:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F3AE4E6593
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7B341ACC;
	Wed,  5 Nov 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="KwvKdmtQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1233BBDE
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374289; cv=none; b=CLnVdwfHbWwa3DNrx5UApA8aaX7oottU5TXmFOyPePPTWpUeRz+sOa8QN3x2kBNnDmmP6u5uJnbUrh2qAKsIJuzN8bAvDmf6nSEkPKV6BQ31a5FcZyT/v54b+tuL7DdJ6f34HHfhSwYAB94FV5ZDtB8zJGnk4TXfZItvN8Oi7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374289; c=relaxed/simple;
	bh=ru3LK83a2Xvfei63ibeV8+O+hclXDIspyIG4efCdDDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLA6eMCmJGIHRQuscq/ZWU8xbc9aAKyiECLeVoVhUepL8R9INpkDmuzZFtEFYZCsNwLIA1NkKZKft9eAAXlITEVooghPXJOn+YF/2VGHu3F/CXpWpxZIcfnz1LH4Nn8YgLrh9WPm9mSBXsF4LR2qilCGgHSQkgq/R5+Aozj/bPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=KwvKdmtQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ba4874edb5dso149867a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 12:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762374286; x=1762979086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTJsvc/xBov8KIoRaCRLX6nRBzvfxpOxCd2qNAg1A34=;
        b=KwvKdmtQxiotmvvLmU6YUoIWURXzm4MbuI73JD2UtRjZxZNdZoMx8iqi85PEHLaSDY
         k/LfD8nvBHQ4NchXxr1foeFPMt/vgsLP5tLQ38S/zJ0GZ6KfKQtuYlhg/hPfBsCjRhPW
         aRrOmevkp1yeD/8BD9ovrBdk8s+JSohkE0hYbQT8aQmajW5bR8G1qK1MIOGStmBh6cuK
         hVrThuImUkUZk84SiN2FVN1DMRnPYTSJlXjxm65RZLnRd06YyvMW5bAkX/dkdbRx4Upi
         edWRO+SlUvq7TXy3BaLR6fz0s6cA2XN+xLgzsFwtjl73vMiVoV2A4Qi3EgdsUpdWFPa6
         eoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374286; x=1762979086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTJsvc/xBov8KIoRaCRLX6nRBzvfxpOxCd2qNAg1A34=;
        b=BVmN+AUyoS9VuPIEhsNSVmmgGR4CKL0AnpzLnCEtYKHxTDDdDMNZkUne6jTPKrsws3
         lVdGu2UTW1drSr3VTijhOF2fTljG6LDvs62OiOMk/a/clFbq9z55jb9PEpFjDh+vo0Me
         7SccRV2/qEJbEzzLT1sUUW9SF2DrtEU8aEa1hhTiHKTykgKdnVHQK+RVCGc2nG8mB2nX
         +XLWr2Z94ZK1k3Yw49Gc1Ek5490xP0EoLOYPdHFCTL4mYA11wyC3y7bCt/g3TyqYA9C0
         cFGuwnoI7uavO8QkUb3+h/qvYfpAkJXtvIBi5p4cBcXUdSVzWh3gsVjTo/rX4i4M1Y1u
         In3g==
X-Forwarded-Encrypted: i=1; AJvYcCXx6Wdal0lB+X1cXSxJ+NXpGvfQYbfeEZ5Q5S1qAEIby4nAgazDw6vErLVkpdkZJTVHak8hMKX2JABfyCEoqwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuefWmQmMo/krCWmZw1FENA4zyjAwNSUpRxYDQ20cPaC/djpU2
	CuZxLevbYFpRjAwrM9aMjl12RQzWH2sd1dTJxDROYzZn1+ETApCGm9F/IUpgEgnW5Z8=
X-Gm-Gg: ASbGncssvC819pRHKXJRIfu1obqBk4dTvvhKQGSxKPHp58TJb6tFdd+bAvgZzjgIyYv
	F24Rg53TCUWFP7AVdzoqGSBdNhwblp9grgplJVqQrLiQap4ADytKp5vLstYKa9gljK7XzHKfrMf
	KISThfJRj4O4agSWd/U3t+L5YAptSCmumm4SHv7kjQvBRwrgj9eDgEe8rv3i2FWoy5Tt1kfHaMH
	4258YXTa44nRzmrXAkJ64JJxSd/q7BNxoaNVdrfzRLmGF5ryJqr0IjPQBpYL+mjaufBQMEcAFGR
	0MS3dYL6uxBY7tDo5x6ydEodGIfJcK2jgtooEnFhRvkRoSMPc1nzCTPekxrp0CMOiBPbdrKAHCO
	JCUnB7kk76kdj2KFyrSc3Ck69NG3Zxc5D87pP79baXeMAy1tLQG94iD1BJbJ2t0J9pesaU0oLXO
	j7yH6xp7jFj3tG+uvomkxl
X-Google-Smtp-Source: AGHT+IGcIhIZzFLFERqqOIWA4blh7/2tLrno9LJ0vWHdSq4baD/dSuxfcH7DJ7IzJv9TkLpbDdbxqg==
X-Received: by 2002:a05:6a20:7d9c:b0:34e:63bd:81b9 with SMTP id adf61e73a8af0-34f841102e6mr5836279637.24.1762374283997;
        Wed, 05 Nov 2025 12:24:43 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd52afesm294640b3a.18.2025.11.05.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:24:43 -0800 (PST)
Date: Wed, 5 Nov 2025 12:24:41 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, jim.shu@sifive.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	Zong Li <zong.li@sifive.com>,
	Michael Ellerman <mpe@tenstorrent.com>
Subject: Re: [PATCH v22 00/28] riscv control-flow integrity for usermode
Message-ID: <aQuyiVdxyqWNooJ5@debug.ba.rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <CACPK8XeQf9UJuu39bGcm2mySWrKYvUadOgFRmpas+AS9fXA2WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACPK8XeQf9UJuu39bGcm2mySWrKYvUadOgFRmpas+AS9fXA2WA@mail.gmail.com>

On Tue, Nov 04, 2025 at 05:34:11PM +1030, Joel Stanley wrote:
>Hello Deepak,
>
>On Fri, 24 Oct 2025 at 03:31, Deepak Gupta via B4 Relay
><devnull+debug.rivosinc.com@kernel.org> wrote:
>>
>> v22: fixing build error due to -march=zicfiss being picked in gcc-13 and above
>> but not actually doing any codegen or recognizing instruction for zicfiss.
>> Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
>> ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
>> visible in menuconfig.
>
>Following our discussion at the riscv summit I spent some time with
>this patch set with the goal of giving a test run on emulation. I only
>got as far as qemu, as I couldn't get the selftests passing there.
>
>I had trouble running the podman container so I built a toolchain
>using the riscv-gnu-toolchain branch (cfi-dev, d19f3009f6c2) you
>pointed to.
>
>The opensbi branch was a bit old and wouldn't build with GCC 15, so I
>tried to rebase and noticed the patches were already upstream. Have
>you tested using v1.7 (or newer) there? Is there something I missed,
>do we need more patches on upstream opensbi?
>
>I booted it in qemu 10.1.2 with the zicfi extensions both on and off.
>
>qemu-system-riscv64 -M virt,aia=aplic-imsic,aia-guests=5 \
>  -cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true
>  -smp 8 -nographic -bios fw_dynamic.elf
>  -m 1024M -kernel arch/riscv/boot/Image \
>  -initrd selftests/selftests.cpio \
>  -append 'init=mini-init command="cfitests"'
>
>My results:
>
>no zicfi, no z*mop (crash, as expected):
>-------------------------------------------------
>
>Running command: cfitests
>system_opcode_insn: Invalid opcode for CSR read/write instruction[
>0.462709] cfitests[85]: unhandled signal 4 code 0x1 at
>0x0000000000011c44 in cfitests[1c44,10000+6d000]
>[    0.463141] CPU: 4 UID: 0 PID: 85 Comm: cfitests Not tainted
>6.18.0-rc3-tt-defconfig-jms-00090-g6e2297f1edbc #93 NONE
>[    0.463338] Hardware name: riscv-virtio,qemu (DT)
>[    0.463573] epc : 0000000000011c44 ra : 00000000000104e0 sp :
>00007fffebd0ddb0
>...
>[    0.465177] status: 0000000200004020 badaddr: 00000000ce104073
>cause: 0000000000000002
>[    0.465410] Code: 0893 05d0 4501 0073 0000 b7f5 4501 b7f9 0017 0000
>(4073) ce10
>
>no zicfi, z*mop (failed to start, as expected):
>-----------------------------------------------------------
>
>Running command: cfitests
>TAP version 13
># Starting risc-v CFI tests
>Bail out! Get landing pad status failed with -22
>
>zicfi, z*mop (failed to start, unexpected):
>-------------------------------------------------------
>Running command: cfitests
>TAP version 13
># Starting risc-v CFI tests
>Bail out! Get landing pad status failed with -22
>
>I went digging to see why the zicfi enabled kernel failed. The
>userspace binary was built with CFI:
>
>$ riscv64-unknown-linux-gnu-readelf -n selftests/cfitests
>
>Displaying notes found in: .note.gnu.property
>  Owner                Data size     Description
>  GNU                  0x00000010    NT_GNU_PROPERTY_TYPE_0
>      Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>
>I then tested your opensbi tree with some hacks to get it built with a
>newer compiler. This produced different results, which was unexpected:
>
>Running command: cfitests
>TAP version 13
># Starting risc-v CFI tests
>Bail out! Landing pad is not enabled, should be enabled via glibc
># Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>
>The selftest binary and the little toy init that starts it are both
>statically linked and built against the toolchain's glibc, so I would
>expect this to work.
>
>$ riscv64-unknown-linux-gnu-readelf -n sifive-cfi-build/sysroot/usr/lib/libc.a
>
>File: sifive-cfi-build/sysroot/usr/lib/libc.a(init-first.o)
>
>Displaying notes found in: .note.gnu.property
>  Owner                Data size        Description
>  GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
>      Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>
>The kernel seems to have detected that CFI is available and is built with it:
>
>$ grep CFI .config
>CONFIG_RISCV_USER_CFI=y
>CONFIG_ARCH_SUPPORTS_CFI=y
>
>I did notice the func-sig-dev gcc branch is a few commits ahead of
>what the sifive riscv-gnu-toolchain points to.
>
>I had to context switch to some other tasks at this point. I wanted to
>do some more digging to work out what was wrong, but I haven't found
>time, so here are my notes in the hope that they are useful. I'll let
>you know if I discover anything further.


I have it working on my end with latest upstream opensbi (no hacks, same
compiler)

"""
$ git log
commit 38a6106b1099646f25657bba53cefb80886721a7 (HEAD -> master, origin/master, origin/HEAD)
Author: Benoît Monin <benoit.monin@bootlin.com>
Date:   Mon Oct 27 14:12:17 2025 +0100

     lib: utils/ipi: mswi: add MIPS P8700 compatible
....
"""

I am surprised that change of compiler on opensbi changed errorcode for userspace
in your setup. That's quite bizarre.

Output from cfitests (with toolchain that's on docker. I didn't compile from
cfi-dev branch).

# /mnt/cfitests
TAP version 13
# Starting risc-v tests
# Landing pad and shadow stack are enabled for binary
# cfi_ptrace_test, ptrace test succeeded
# Executing RISC-V shadow stack self tests
1..5
# Exercising shadow stack fork test
# Parent pid 133 and child pid 135
# dummy calls for sspush and sspopchk in context of parent
# Spewing out shadow stack ptr: 7fffbf4a9fb8
   This is to ensure shadow stack is indeed enabled and working
# Waiting on child to finish
# dummy calls for sspush and sspopchk in context of child
# Spewing out shadow stack ptr: 7fffbf4a9fb8
   This is to ensure shadow stack is indeed enabled and working
ok 1 shstk fork test
# Exercising shadow stack map test
ok 2 map shadow stack syscall
# Exercising shadow stack gup tests
ok 3 shadow stack gup tests
# Exercising shadow stack signal test
ok 4 shadow stack signal tests
# Exercising shadow stack protection test (WPT)
ok 5 memory protections of shadow stack memory
# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
#

Is there a place where I can grab your kselftest `cfitests` binary?

Only difference I can see is that `cfitests` in my case is not statically
compiled

"""
$ riscv64-unknown-linux-gnu-readelf -d /scratch/debug/sources/spectacles/cfitests | grep NEEDED
  0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

"""

>
>Cheers,
>
>Joel
>
>
>> How to test this series
>> =======================
>>
>> Toolchain
>> ---------
>> $ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
>> $ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
>> $ make -j$(nproc)
>>
>> Qemu
>> ----
>> Get the lastest qemu
>> $ cd qemu
>> $ mkdir build
>> $ cd build
>> $ ../configure --target-list=riscv64-softmmu
>> $ make -j$(nproc)
>>
>> Opensbi
>> -------
>> $ git clone git@github.com:deepak0414/opensbi.git -b v6_cfi_spec_split_opensbi
>> $ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic
>>
>> Linux
>> -----
>> Running defconfig is fine. CFI is enabled by default if the toolchain
>> supports it.
>>
>> $ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
>> $ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)
>>
>> Running
>> -------
>>
>> Modify your qemu command to have:
>> -bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
>> -cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true

