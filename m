Return-Path: <linux-kselftest+bounces-45029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD82C3D8F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 23:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDB0188E298
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C630B52F;
	Thu,  6 Nov 2025 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DQa171+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AF30C372
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467310; cv=none; b=jKDtPw++mi9ItADBVAXDel/pHeWVRWjdgnopbgxwLBRVvZN14yD72qDRBu9KXGnPC+BNPawnbrFFMTwj4qa2VsaTv7m3JbJduKkVrp/LKNtzTnTeTCzDiFF05whpKTK55Cv9kqA9kDudQebpUrDpNUWl9pfBFr7Qj80SyT7YxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467310; c=relaxed/simple;
	bh=HUyJsMoU7vKGcC46di7f4HcprOlRD7DP810v6feRbK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8f929nZ6duIJQ4W99JiRmDzzmgXOMnyixciM7QVbYTACvK9/5bbKX8nSYNaxnHrG9mhA8hNgPcmD+577KfRuPDOty/r1twGrnY7muTd+d/F+G8oeaxemt90m4axyWRSchq0D3QtuTJWnIXf4JrSXqGklD3gCjlJ+//47GmDNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DQa171+o; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so188222a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762467305; x=1763072105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f81U5/79UyOAGW6VXn6pxFacbUSlx5ZrI8Z3RpSpADo=;
        b=DQa171+oqiFSwEqXEMz7yD5bNcI0AwFa1dT1I45YMfpbCBVR99nsAXkDzq6kULs9ij
         IJt+Dcili1OjoVCNpEmEHnXYAvhpWX1YTdQGhUur/pD4dsqwoXa4R30WZnVHhc+dUoaa
         P59L3LnRzJrDFdi7WBNVViMH2HLFLT9s03otzU3cGAJ6CS8NolO8tMeAoF94IuTaWZou
         PJ54suuUy7p6CtlNiuCvBRvyGn4Lx0qsTjs9E4u+BpqCWx0Hm7uxx9LTfkDLEK2Tnx50
         vgUHHA2m+z7FnpJjH7j7zBrYiAyPg3UwDGRtpXl2WZwjyeOXAyNgfJSDIgU89ImtXRWk
         ZX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467305; x=1763072105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f81U5/79UyOAGW6VXn6pxFacbUSlx5ZrI8Z3RpSpADo=;
        b=C1XSeL9qE/KFrTIduEIOwkmZQErm7EXPrU8My0/8JMX4y+3zc15LjgRjnKRz/LrYST
         mLZ9H44KEXFJNWDnALKX2EnZhmocA9izUbKkEJny2sT/uBNdNg+SaV1JmKZyaNW9pw0y
         gLxaeIQGK+FMkrG4RrDZqYN9dH3tTuc9VvTuvZpU6wr7Vr5KssKNL8avBgwMyTOQuQha
         kx/JTTG8b2HNqt2rhQTWNcanw6HeMtgTG4fuV3tP1lrpDTHbMjRXDw2TPqTUXQVyJr9L
         Qit4D2tCBHGOb9VqVfC+9NAI04MsktLrgfvIFBJ0gLMDKeXsOwfx+V28sdXYVCWNnV0Q
         qfvg==
X-Forwarded-Encrypted: i=1; AJvYcCX+iYHfO1TZAUwb+IzS+x3SHoQF/cLXQobVEPZmpbiaYn10UgfWvPAkPxCqfK+sMcbfswFo/gGvV6hffpnkzbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnkaueRrSYupqYBsRc49vGWWL5TN5/GbvPvHSrBKps+uoUjH6
	Kw3RT5flumtXQWZKQrMjH9eDFRWkS+WVTTEuY93MJs2mCkvFdO0XL7cYIQAOXXVnf5RclCDFhgN
	4bXvxrcevcSVdhcFYCtg7TFDiautNj5tTk5kl0X2S8g==
X-Gm-Gg: ASbGncvhaBTAUe1cGtTnWMuasLcWtHOTguWeiGzq4z01j7qAZt5IHuBvrogNi79RxmE
	Iz2QrHncq1S4WdrN7dz7DE0IwNtISuI60YQYYarcaYGtEJP55mu6lLgmMvU0ARh43TmRplPRPMs
	Njii9GD7959P80Yb6w5jmZBCWCLRVPkkwc83UAw+u4IByOzN+brLQden8LDs193qX3fN62SjOEU
	3XGFS8nec4tedc8aQyzTj/U1qykGzJJ2HXURTAKPM7SpuGxWRnExjzSQ07AE2xPN0gV
X-Google-Smtp-Source: AGHT+IFMNxw/R1yQ2ypKv/nek+CS+Dt0g6lco0tSe4JF0aLBw9GdvNDeY3wOMxlums/5C8vWYWYunbR1HZth+5+nSYU=
X-Received: by 2002:a05:6402:3590:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-6413f08ef69mr1005608a12.34.1762467305387; Thu, 06 Nov 2025
 14:15:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-3-pasha.tatashin@soleen.com>
 <202511061629.e242724-lkp@intel.com> <CA+CK2bCUWuK4fmuz5Us_mS1ByGy5SjaedVEquj1WxN8JUPsJaw@mail.gmail.com>
In-Reply-To: <CA+CK2bCUWuK4fmuz5Us_mS1ByGy5SjaedVEquj1WxN8JUPsJaw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 6 Nov 2025 17:14:28 -0500
X-Gm-Features: AWmQ_bkf90cd7vGfxxwFQfOgh84qLMbCwawCMq5n9jVWpcK7oaXbMt6knSHxPMQ
Message-ID: <CA+CK2bCSv99byZ-mc8bdoqfbp7qZTS9anky6oh=5ptg=MWPgxA@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] kho: drop notifiers
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, 
	linux-kselftest@vger.kernel.org, masahiroy@kernel.org, ojeda@kernel.org, 
	pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:46=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> The bug is in lib/test_kho.c, when KHO is not enabled, it should not
> run KHO commands, there is a function to test that: kho_is_enabled().
> So, KHO is disabled and kho_add_subtree() which calles add debugfs
> entry, and the list is not initialized, because KHO is disabled. The
> fix is:

Sent it as a patch:
https://lore.kernel.org/all/20251106220635.2608494-1-pasha.tatashin@soleen.=
com

>
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 025ea251a186..85b60d87a50a 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -315,6 +315,9 @@ static int __init kho_test_init(void)
>         phys_addr_t fdt_phys;
>         int err;
>
> +       if (!kho_is_enabled())
> +               return 0;
> +
>         err =3D kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
>         if (!err)
>                 return kho_test_restore(fdt_phys);
>
> On Thu, Nov 6, 2025 at 3:41=E2=80=AFAM kernel test robot <oliver.sang@int=
el.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "WARNING:at_kernel/kexec_handover.c:#kho_add_=
subtree" on:
> >
> > commit: e44a700c561d1e892a8d0829d557e221604a7b93 ("[PATCH v9 2/9] kho: =
drop notifiers")
> > url: https://github.com/intel-lab-lkp/linux/commits/Pasha-Tatashin/kho-=
make-debugfs-interface-optional/20251101-222610
> > patch link: https://lore.kernel.org/all/20251101142325.1326536-3-pasha.=
tatashin@soleen.com/
> > patch subject: [PATCH v9 2/9] kho: drop notifiers
> >
> > in testcase: boot
> >
> > config: x86_64-randconfig-001-20251015
> > compiler: gcc-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +--------------------------------------------------------+------------+=
------------+
> > |                                                        | 93e4b3b2e9 |=
 e44a700c56 |
> > +--------------------------------------------------------+------------+=
------------+
> > | WARNING:at_kernel/kexec_handover.c:#kho_add_subtree    | 0          |=
 8          |
> > | RIP:kho_add_subtree                                    | 0          |=
 8          |
> > +--------------------------------------------------------+------------+=
------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel=
.com
> >
> >
> > [   13.620111][    T1] ------------[ cut here ]------------
> > [   13.620739][    T1] WARNING: CPU: 1 PID: 1 at kernel/kexec_handover.=
c:704 kho_add_subtree (kernel/kexec_handover.c:704)
> > [   13.621665][    T1] Modules linked in:
> > [   13.622090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted=
 6.18.0-rc3-00211-ge44a700c561d #1 VOLUNTARY
> > [   13.623073][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   13.624054][    T1] RIP: 0010:kho_add_subtree (kernel/kexec_handover=
.c:704)
> > [   13.624596][    T1] Code: c7 38 b4 ac 85 31 ed e8 01 1c 00 00 48 c7 =
c7 70 5a ca 86 85 c0 89 c3 40 0f 95 c5 31 c9 31 d2 89 ee e8 37 b5 0a 00 85 =
db 74 02 <0f> 0b b9 01 00 00 00 31 d2 89 ee 48 c7 c7 40 5a ca 86 e8 1c b5 0=
a
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   c7 38 b4 ac 85          xbegin 0xffffffff85acb43d,(bad)
> >    5:   31 ed                   xor    %ebp,%ebp
> >    7:   e8 01 1c 00 00          call   0x1c0d
> >    c:   48 c7 c7 70 5a ca 86    mov    $0xffffffff86ca5a70,%rdi
> >   13:   85 c0                   test   %eax,%eax
> >   15:   89 c3                   mov    %eax,%ebx
> >   17:   40 0f 95 c5             setne  %bpl
> >   1b:   31 c9                   xor    %ecx,%ecx
> >   1d:   31 d2                   xor    %edx,%edx
> >   1f:   89 ee                   mov    %ebp,%esi
> >   21:   e8 37 b5 0a 00          call   0xab55d
> >   26:   85 db                   test   %ebx,%ebx
> >   28:   74 02                   je     0x2c
> >   2a:*  0f 0b                   ud2             <-- trapping instructio=
n
> >   2c:   b9 01 00 00 00          mov    $0x1,%ecx
> >   31:   31 d2                   xor    %edx,%edx
> >   33:   89 ee                   mov    %ebp,%esi
> >   35:   48 c7 c7 40 5a ca 86    mov    $0xffffffff86ca5a40,%rdi
> >   3c:   e8                      .byte 0xe8
> >   3d:   1c b5                   sbb    $0xb5,%al
> >   3f:   0a                      .byte 0xa
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   0f 0b                   ud2
> >    2:   b9 01 00 00 00          mov    $0x1,%ecx
> >    7:   31 d2                   xor    %edx,%edx
> >    9:   89 ee                   mov    %ebp,%esi
> >    b:   48 c7 c7 40 5a ca 86    mov    $0xffffffff86ca5a40,%rdi
> >   12:   e8                      .byte 0xe8
> >   13:   1c b5                   sbb    $0xb5,%al
> >   15:   0a                      .byte 0xa
> > [   13.626370][    T1] RSP: 0018:ffffc9000001fca0 EFLAGS: 00010286
> > [   13.626951][    T1] RAX: dffffc0000000000 RBX: 00000000ffffffff RCX:=
 0000000000000000
> > [   13.627737][    T1] RDX: 1ffffffff0d94b52 RSI: 0000000000000001 RDI:=
 ffffffff86ca5a90
> > [   13.628523][    T1] RBP: 0000000000000001 R08: 0000000000000008 R09:=
 fffffbfff0dfac4c
> > [   13.629330][    T1] R10: 0000000000000000 R11: ffffffff86fd6267 R12:=
 ffff888133ee2000
> > [   13.630101][    T1] R13: ffffffff85acb340 R14: ffff888117a5f988 R15:=
 dffffc0000000000
> > [   13.630869][    T1] FS:  0000000000000000(0000) GS:ffff888426ea0000(=
0000) knlGS:0000000000000000
> > [   13.631727][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [   13.632370][    T1] CR2: 00007f586df260ac CR3: 00000000054ea000 CR4:=
 00000000000406f0
> > [   13.633154][    T1] Call Trace:
> > [   13.633506][    T1]  <TASK>
> > [   13.633833][    T1]  kho_test_prepare_fdt+0x145/0x180
> > [   13.634446][    T1]  ? kho_test_save_data+0x210/0x210
> > [   13.635097][    T1]  ? csum_partial (lib/checksum.c:123)
> > [   13.635546][    T1]  kho_test_init (lib/test_kho.c:177 lib/test_kho.=
c:284)
> > [   13.636018][    T1]  ? vmalloc_test_init (lib/test_kho.c:271)
> > [   13.636508][    T1]  ? add_device_randomness (drivers/char/random.c:=
944)
> > [   13.637485][    T1]  ? mix_pool_bytes (drivers/char/random.c:944)
> > [   13.637955][    T1]  ? trace_initcall_start (include/trace/events/in=
itcall.h:27 (discriminator 3))
> > [   13.638498][    T1]  ? vmalloc_test_init (lib/test_kho.c:271)
> > [   13.638989][    T1]  do_one_initcall (init/main.c:1284)
> > [   13.639477][    T1]  ? trace_initcall_start (init/main.c:1274)
> > [   13.639998][    T1]  ? parse_one (kernel/params.c:143)
> > [   13.640455][    T1]  ? kasan_save_track (mm/kasan/common.c:69 (discr=
iminator 1) mm/kasan/common.c:78 (discriminator 1))
> > [   13.640948][    T1]  ? __kmalloc_noprof (mm/slub.c:5659)
> > [   13.641465][    T1]  do_initcalls (init/main.c:1344 (discriminator 3=
) init/main.c:1361 (discriminator 3))
> > [   13.641924][    T1]  kernel_init_freeable (init/main.c:1595)
> > [   13.642441][    T1]  ? rest_init (init/main.c:1475)
> > [   13.642891][    T1]  kernel_init (init/main.c:1485)
> > [   13.643345][    T1]  ? rest_init (init/main.c:1475)
> > [   13.643788][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
> > [   13.644256][    T1]  ? rest_init (init/main.c:1475)
> > [   13.644703][    T1]  ret_from_fork_asm (arch/x86/entry/entry_64.S:25=
5)
> > [   13.645213][    T1]  </TASK>
> > [   13.645540][    T1] irq event stamp: 132025
> > [   13.645971][    T1] hardirqs last  enabled at (132035): __up_console=
_sem (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:10=
9 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345)
> > [   13.646887][    T1] hardirqs last disabled at (132046): __up_console=
_sem (kernel/printk/printk.c:343 (discriminator 3))
> > [   13.648253][    T1] softirqs last  enabled at (131286): handle_softi=
rqs (kernel/softirq.c:469 (discriminator 1) kernel/softirq.c:650 (discrimin=
ator 1))
> > [   13.649690][    T1] softirqs last disabled at (131281): __irq_exit_r=
cu (kernel/softirq.c:496 kernel/softirq.c:723)
> > [   13.651128][    T1] ---[ end trace 0000000000000000 ]---
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20251106/202511061629.e242724-l=
kp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >

