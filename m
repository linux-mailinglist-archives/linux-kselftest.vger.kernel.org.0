Return-Path: <linux-kselftest+bounces-5327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901518608CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 03:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6668B22EDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 02:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27424B664;
	Fri, 23 Feb 2024 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MW/Wwdxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B6BA5F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655105; cv=none; b=Rn9XWOE/vMY7+I33kSRBm8cxj8XxzfBrqhLTO0Pg9uvOpjJduPzPZOrviRjsrGDeSKHaDqtBcCqvo3c/dlXjzvZxejxY6Ui/7yOWaU3IHjUFGJU5aXm0/Zx78VpAizIa/RhhRpJ5XofB5ArYDgRoyIhWMS/NDyxWkc0exoRWtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655105; c=relaxed/simple;
	bh=PzfE8dvOzIfSG/xSCddRDMvBcZR0ITDteEVsQNyILMw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=MY7du6zyjvgxcEL1lqSMI2WmIoryQqnuDD0PPBlPcNiJkjahpdFgDW9gKgtZBZhBGazCaUNX86vgsyoaE2EEuQeGaYkbRecbK4QvmTEWQRs+mQxY+8prSz5APr4qc23kC3rnZCOZN3gMieIOMpfoFAQXt9LnWwJvrzEyHF8S2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MW/Wwdxp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e4841ce028so218509b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 18:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708655103; x=1709259903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvpsMbjqPU4UR9+5wWiHmUmCTwM1PMtLjxdFJ8jAgDo=;
        b=MW/WwdxppZuCISdh5ukjVaVojPDfa8y2RJ9EMgTLHGmO75iCpbGn9eOMQOynBMj9Yk
         +nHcnfM5AoyhqCq8WDWBF5mYyQ0l7RJIrKd+6dDMBx0DDyXNTnle9GNGeIET6VjoE5r+
         ip+H99r3aucGAz50ztmNfyQ6n4RtZAMRKA8AJkeYUTnm2NsUVAgzm4MZlK5R04fc/yA6
         mR/8Zc3FooUqY6XgJzf03hNheaOYJpKWtbd14YbhoPMPVwRXBw4vQ8lOV5UNbE7B1eb9
         k7952iFSIPy9KB5OkO3aIAibOpIHFUe7YW0kQRG/JdPHJ+3ulfMCIxWWwr8sK0NQvXtW
         thmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708655103; x=1709259903;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvpsMbjqPU4UR9+5wWiHmUmCTwM1PMtLjxdFJ8jAgDo=;
        b=px/PQWyCra+loMO2jpvZ4JKVfskJh0dlUOogD0y99o33unWslvrCmW93wZWSVx1ejY
         ydTUsTRgHAI65OJMON2PS8t+cZ0QEJYjsGreigWIdPL/ouNTOIf6ISncTk5N6bohBXws
         mOSezsVp/CQD/G95n9jAWVlKF/hHJDxepvF409D6cXhTio41A5Ne3nqiVNDitkmYX9Vu
         4cbZBlPy1eaK1+H56fz/gc0eF0sZzk6JfzRNthJJUZalOxjkMla3/tVoyexjYwK2taQZ
         0UNg1XtEfVFuWAkscaBz+gPhBWps3OtXP+c/e98FTRKZabHNIuhnSc3sr228qX0xNZQl
         6jnw==
X-Forwarded-Encrypted: i=1; AJvYcCVONeLY6XTr3VmY+ZBQcX07fl4SOMj51bXUeHD/48NXg77vnQXOtTvefOQ/59F6fVQKjucnsukxQsYR83jm4Lpn17tCt03gDFebKSCekWzM
X-Gm-Message-State: AOJu0Yw+SIrQg6FSDvxnQdD6BDkonCJNdupF0IJyO4RvNpzXotP5lO8T
	ZCYV/sbPwiNogOqATyGURk7gYAqeeizQPf1zC+BPlZ/LT/uRbUTF/i2uGDGDW8zhy681dTtZkOJ
	k8SU=
X-Google-Smtp-Source: AGHT+IGXzUvLuIBqAH6IpfTDaGkH8Ve8NCjMdXcR7MwfrFmhzj20/am5IT7QTj11UMAitUQcB9a5gw==
X-Received: by 2002:a05:6a20:e607:b0:19e:a353:81b0 with SMTP id my7-20020a056a20e60700b0019ea35381b0mr734946pzb.11.1708655102714;
        Thu, 22 Feb 2024 18:25:02 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:902e:6d00:6c11:e63b])
        by smtp.gmail.com with ESMTPSA id mf8-20020a170902fc8800b001d9fc6cb5f2sm10645873plb.203.2024.02.22.18.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 18:25:02 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
 <87sf1n7uea.fsf@linaro.org>
 <9b899b4e-7410-4c3b-967b-7794dac742e4@sirena.org.uk>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 33/38] kselftest/arm64: Add a GCS test program built
 with the system libc
In-reply-to: <9b899b4e-7410-4c3b-967b-7794dac742e4@sirena.org.uk>
Date: Thu, 22 Feb 2024 23:24:59 -0300
Message-ID: <87ttlzsyro.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Mark Brown <broonie@kernel.org> writes:

> On Mon, Feb 19, 2024 at 11:15:57PM -0300, Thiago Jung Bauermann wrote:
>
>> The only issue as can be seen above is that the can_call_function test
>> is failing. The child is getting a GCS Segmentation fault when returning
>> from fork().
>
>> I tried debugging it with GDB, but I don't see what's wrong since the
>> address in LR matches the first entry in GCSPR. Here is the
>> debug session:
>
> I believe based on prior discussions that you're running this using
> shrinkwrap - can you confirm exactly how please, including things like
> which firmware configuration you're using?  I'm using current git with
>
>   shrinkwrap run \
>         --rtvar KERNEL=3Darch/arm64/boot/Image \
>         --rtvar ROOTFS=3D${ROOTFS} \
>         --rtvar CMDLINE=3D"${CMDLINE}" \
>         --overlay=3Darch/v9.4.yaml ns-edk2.yaml
>
> and a locally built yocto and everything seems perfectly happy.

Yes, this is how I'm running it:

  CMDLINE=3D"Image dtb=3Dfdt.dtb console=3DttyAMA0 earlycon=3Dpl011,0x1c090=
000 root=3D/dev/vda2 ip=3Ddhcp maxcpus=3D1"

  shrinkwrap run \
      --rtvar=3DKERNEL=3DImage-gcs-v8-v6.7-rc4-14743-ga551a7d7af93 \
      --rtvar=3DROOTFS=3D$HOME/VMs/ubuntu-aarch64.img \
      --rtvar=3DCMDLINE=3D"$CMDLINE" \
      ns-edk2.yaml

I ran the following to set up the FVP VM:

$ shrinkwrap build --overlay=3Darch/v9.4.yaml ns-edk2.yaml

My rootfs is Ubuntu 22.04.3. In case it's useful, my kernel config is
here:

https://people.linaro.org/~thiago.bauermann/gcs/config-v6.8.0-rc2

I tried removing "maxcpus=3D1" from the kernel command line, but it made
no difference.

I also tried resetting my Shrinkwrap setup and starting from scratch,
but it also made no difference: I just pulled from the current main
branch and removed Shrinkwrap's build and package directories, and also
removed all Docker images and the one container I had.

Here are some firmware versions from early boot:

  NOTICE:  Booting Trusted Firmware
  NOTICE:  BL1: v2.10.0   (release):v2.10.0
  NOTICE:  BL1: Built : 00:07:29, Feb 23 2024
     =E2=8B=AE
  NOTICE:  BL2: v2.10.0   (release):v2.10.0
  NOTICE:  BL2: Built : 00:07:29, Feb 23 2024
     =E2=8B=AE
  NOTICE:  BL31: v2.10.0  (release):v2.10.0
  NOTICE:  BL31: Built : 00:07:29, Feb 23 2024
     =E2=8B=AE
  [  edk2 ] UEFI firmware (version  built at 00:06:55 on Feb 23 2024)
  Press ESCAPE for boot options ...........UEFI Interactive Shell v2.2
  EDK II
  UEFI v2.70 (EDK II, 0x00010000)

It looks like our main differences are the kernel config and the distro.

--=20
Thiago

