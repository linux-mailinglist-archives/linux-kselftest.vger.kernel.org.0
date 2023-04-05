Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339556D89A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjDEVhR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjDEVhN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 17:37:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD507D85;
        Wed,  5 Apr 2023 14:37:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so40890247pjp.1;
        Wed, 05 Apr 2023 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680730628;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoNclKH1nYsZGnrvEAOJxEvKBpD/uYy7MIKqll7pqEs=;
        b=gDqF7IkCuJavXVzDvwHcguNzLMX1UBBORNklBqrzDKocxQKGZlQJaIo6V1xD8vnDeX
         SNTs/GHY/U7bFLupLXXsYLaKLK8tlWW+YXfBmZqgu/gvSl8tG1TQ26dPt7k/jika7wxP
         nBk9yTqGr0jC6UQsNv6xH80AC84UYHZUplXFibb4xFxTf1YMfyF5BKzSW07Z272xm9z5
         bQ2pkY9DoQ6iHBt/RVbmSqvFNLYlAryn9CvT7ksnc3aAvOSvmaqFPYtg9jOSQ016J7T3
         RCUtSov7M8lKqIs05PnKOtxLMtPJZXPn8iyzbTFqK6LoZG2kMG6uZLO6W6ez6yc4QvrD
         ADpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680730628;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PoNclKH1nYsZGnrvEAOJxEvKBpD/uYy7MIKqll7pqEs=;
        b=ats/hz6MOZ4yi1+9lNfggIZfWt0HkXsB6izlqv5Iq7fTPnV9KeJbb+36UhOfGy0NR4
         I+cT/BqD0KV3q9Z1lNG0ZhkA4LtrnUy8vos8enpsSIRKWYrAkOT/fhVeYryWG3EplTue
         N6+/yCCwLlZkulmnmMiTE/EKYvUCMzG92DzCzKODH2XJBvd60IjA4BOuknBYG6IPzz8K
         nZoRaEtTG9AA8GPJtSneinSazYEUYH+wkgazt2ZPCOmyKGyc7C9NPYxP1xR/hSlA1bay
         4idf59FDWyW+lO0kG+VJOJJ6ocmnVPS6ZWeyFcgerx5ldCMCHiCRT0k2ZRLPV0+zcXSh
         t+AQ==
X-Gm-Message-State: AAQBX9evFfdCRP2CJ2D3zBRW/pS4QGKB8KScpnbcsz2EdRnA+KzS4HWA
        vxujcbJNjZZv77qX7Zqvo0E=
X-Google-Smtp-Source: AKy350Z1cfCQ2vnYROM1uwE30kubHcOoBXb5poeK9Z/8J9nClMuo3LxP94CR/wX8AwPfZaG000Oidg==
X-Received: by 2002:a05:6a20:3824:b0:cb:77f0:9a42 with SMTP id p36-20020a056a20382400b000cb77f09a42mr552717pzf.33.1680730628299;
        Wed, 05 Apr 2023 14:37:08 -0700 (PDT)
Received: from localhost ([2605:59c8:4c5:7110:5120:4bff:95ea:9ce0])
        by smtp.gmail.com with ESMTPSA id d26-20020a630e1a000000b0050bcf117643sm9404073pgl.17.2023.04.05.14.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:37:07 -0700 (PDT)
Date:   Wed, 05 Apr 2023 14:37:06 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Pengfei Xu <pengfei.xu@intel.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org,
        john.fastabend@gmail.com, heng.su@intel.com, lkp@intel.com,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yi1.lai@intel.com
Message-ID: <642dea024554c_1ab91208f4@john.notmuch>
In-Reply-To: <ZCwujl7qJPvMsHKv@xpf.sh.intel.com>
References: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com>
 <ZAdVvximUvRXcGZZ@xpf.sh.intel.com>
 <ZCvusEIauvO8BLM5@xpf.sh.intel.com>
 <CANn89iJjqTyev28kzEwBjoNafn_4Ku3ZijJxQ_+Tc93TaG3D=g@mail.gmail.com>
 <ZCwujl7qJPvMsHKv@xpf.sh.intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING: refcount bug in
 sock_map_free in v6.3-rc1
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Pengfei Xu wrote:
> On 2023-04-04 at 11:43:36 +0200, Eric Dumazet wrote:
> > On Tue, Apr 4, 2023 at 11:31=E2=80=AFAM Pengfei Xu <pengfei.xu@intel.=
com> wrote:
> > >
> > > ++ GPIO and kself-test mailing list.
> > >
> > > Hi kernel experts,
> > >
> > > It's a soft remind.
> > >
> > > My colleague Lai Yi found that similar "refcount_t: underflow; use-=
after-free"
> > > issue still existed in v6.3-rc5 kernel on x86 platforms.
> > >
> > > We could reproduce issue from kself-test: gpio-mockup.sh easily:
> > > kernel/tools/testing/selftests/gpio/gpio-mockup.sh:
> > >
> > > "
> > > [ 5781.338917] -----------[ cut here ]-----------
> > > [ 5781.344192] refcount_t: underflow; use-after-free.
> > > [ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25 re=
fcount_warn_saturate+0xbe/0x110
> > > [ 5781.359550] Modules linked in: gpio_mockup isst_if_mmio isst_if_=
mbox_pci intel_th_sth stm_core intel_th_pti intel_th_pci intel_th_gth pmt=
_telemetry pmt_class intel_vsec intel_rapl_msr intel_rapl_common nfsv3 rp=
csec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace bridge stp llc sunrpc int=
el_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg=
_temp_thermal intel_powerclamp coretemp iTCO_wdt ofpart kvm_intel intel_p=
mc_bxt iTCO_vendor_support spi_nor mtd intel_sdsi kvm spdm irqbypass dax_=
hmem joydev asn1_encoder snd_pcm mei_me i2c_i801 spi_intel_pci isst_if_co=
mmon idxd snd_timer intel_th i2c_smbus spi_intel mei i2c_ismt ipmi_ssif c=
xl_acpi ipmi_si cxl_core acpi_power_meter crc32c_intel i40e igb dca igc p=
inctrl_emmitsburg pinctrl_intel pwm_lpss fuse [last unloaded: isst_if_mmi=
o]
> > > [ 5781.438080] CPU: 250 PID: 82496 Comm: modprobe Not tainted 6.3.0=
-rc5 #1
> > > [ 5781.449711] Hardware name: Intel Corporation, BIOS IFWI 03/12/20=
23
> > > [ 5781.461615] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> > > [ 5781.467585] Code: 01 01 e8 75 56 8e ff 0f 0b c3 cc cc cc cc 80 3=
d 4c 67 ac 01 00 75 85 48 c7 c7 b0 31 cd a9 c6 05 3c 67 ac 01 01 e8 52 56=
 8e ff <0f> 0b c3 cc cc cc cc 80 3d 27 67 ac 01 00 0f 85 5e ff ff ff 48 c=
7
> > > [ 5781.488761] RSP: 0018:ff45a7f44d39feb0 EFLAGS: 00010286
> > > [ 5781.494745] RAX: 0000000000000000 RBX: ffffffffc0b36540 RCX: 000=
0000000000000
> > > [ 5781.502871] RDX: 0000000000000002 RSI: ffffffffa9c065c8 RDI: 000=
00000ffffffff
> > > [ 5781.510984] RBP: ff31c1afa78cb800 R08: 0000000000000001 R09: 000=
0000000000003
> > > [ 5781.519100] R10: ff31c1b6fc000000 R11: ff31c1b6fc000000 R12: ff3=
1c1afa78c4f40
> > > [ 5781.527215] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
> > > [ 5781.535337] FS: 00007f9bc705a740(0000) GS:ff31c1b700280000(0000)=
 knlGS:0000000000000000
> > > [ 5781.544529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 5781.551063] CR2: 00007f9bc5e50dc0 CR3: 000000093b36c003 CR4: 000=
0000000f71ee0
> > > [ 5781.559180] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > [ 5781.567307] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 000=
0000000000400
> > > [ 5781.575413] PKRU: 55555554
> > > [ 5781.578551] Call Trace:
> > > [ 5781.581394] <TASK>
> > > [ 5781.583868] gpio_mockup_exit+0x33/0x420 [gpio_mockup]
> > > [ 5781.589756] __do_sys_delete_module.constprop.0+0x180/0x270
> > > [ 5781.596112] ? syscall_trace_enter.constprop.0+0x17f/0x1b0
> > > [ 5781.602354] do_syscall_64+0x43/0x90
> > =

> > I hear you but this trace has nothing to do with the bpf/sockmap comm=
it ?
> > =

>    I just saw the same WARNING from kself-test: gpio-mockup.sh, maybe
>    it's different issue, sorry.
> "
> refcount_t: underflow; use-after-free.
> [ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25
> "

The  ./gpio-mockup.sh thing doesn't use sockmap at all right? I can't see=

why the bisec to that patch would happen off-hand.

> =

>   Thanks!
>   BR.
>   -Pengfei
> =

> > My change looks correct, so your bisection might simply trigger becau=
se
> > of a wider window for another bug to surface.
> > =

> > John, do you have an idea of what is going on here ?

No idea here.
