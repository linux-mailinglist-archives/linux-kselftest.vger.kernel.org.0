Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2363E6D5C3F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjDDJoo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 05:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjDDJo3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 05:44:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B030F6
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 02:43:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v6-20020a05600c470600b003f034269c96so9415027wmo.4
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Apr 2023 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680601428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfzrHqvHyLsWAPDz54joGKpO7tlrlcYlQl14281oUfc=;
        b=kt6hKh2ZqwsC6EdtCzx3k/PeDcnjRiBhD5XFex3ZkLIMrbbKYK4Nhlec4dI3jW42Fo
         +tjIFxb/rSXWPxbJmC8Q92QAPNJxFG/D8qzagCYjtRK3Phd6sktRA/2tYIGQ9wbnPb/i
         cm49Vu7ptAaSIL41+rGvFxkY6VAw/1xVQggZdVKhIJurg1JoY/pzl0eFoya6v56FrJlG
         0CFJMypiciBcGJ3Yl4e93SSxMNngkfjohOJ21fMipS6fLeyQ0WE/nTyzEoRyAyq+4S4W
         DuNK20eUuh5gHAinueYKiM6jsJBhXmO9QJoODwBodAzOLXpMl9GI1Pt/XkRH8dIa9rLr
         ogzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfzrHqvHyLsWAPDz54joGKpO7tlrlcYlQl14281oUfc=;
        b=f9+2bKcfT22c5G8mevTBbSUzR9Q67B5itZzmW29itSVLo4SXXr3Pph5encFTQ4LWu/
         vYpKicS/KM/2dKfrCjOPqWIvg/PEEtOq8mNlXAoSLCJyMZhnqEHZ1QGpOvATV8U+TP9D
         a+O99sIGTxh4I/ctOi1VEl4lZllJZ9/sNeiswL7dw0RJMjhbKGqOjxhlCw7jCG7eP/dy
         odIWYM+3A5KxQ+QUU2R2aqxK5P6/gWmTXuW1CAIYvC8rq2+AAJj13Ub4IVTuWuDVO2qk
         iIXVGBPmNM2gqcFMamdN534xOvmU7iH2UtJf4XmA/ip9Hx2fmb2ls0nyVP0OCfnxVhJh
         7bZw==
X-Gm-Message-State: AAQBX9fRxeoMZI0DklJcsEj+WXIQqjvDRQuaqdDOTyawThkaM6Mt7ieq
        mWi8C+Z4FZ+mPmchRzqXtfS9YtChW/iaxymPP6iVHA==
X-Google-Smtp-Source: AKy350Z1tJnnTPViJm2Vx27jvJEU/2RWZZbOBSkvq/1whW9j1cgHC1V6qAqRs6vYy5sUFAvkin6P5OpplLMG/vJF7Fk=
X-Received: by 2002:a05:600c:201:b0:3ed:1f9f:41d5 with SMTP id
 1-20020a05600c020100b003ed1f9f41d5mr581365wmi.0.1680601427875; Tue, 04 Apr
 2023 02:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com> <ZAdVvximUvRXcGZZ@xpf.sh.intel.com>
 <ZCvusEIauvO8BLM5@xpf.sh.intel.com>
In-Reply-To: <ZCvusEIauvO8BLM5@xpf.sh.intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 4 Apr 2023 11:43:36 +0200
Message-ID: <CANn89iJjqTyev28kzEwBjoNafn_4Ku3ZijJxQ_+Tc93TaG3D=g@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is WARNING: refcount bug in
 sock_map_free in v6.3-rc1
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org,
        john.fastabend@gmail.com, heng.su@intel.com, lkp@intel.com,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 4, 2023 at 11:31=E2=80=AFAM Pengfei Xu <pengfei.xu@intel.com> w=
rote:
>
> ++ GPIO and kself-test mailing list.
>
> Hi kernel experts,
>
> It's a soft remind.
>
> My colleague Lai Yi found that similar "refcount_t: underflow; use-after-=
free"
> issue still existed in v6.3-rc5 kernel on x86 platforms.
>
> We could reproduce issue from kself-test: gpio-mockup.sh easily:
> kernel/tools/testing/selftests/gpio/gpio-mockup.sh:
>
> "
> [ 5781.338917] -----------[ cut here ]-----------
> [ 5781.344192] refcount_t: underflow; use-after-free.
> [ 5781.349666] WARNING: CPU: 250 PID: 82496 at lib/refcount.c:25 refcount=
_warn_saturate+0xbe/0x110
> [ 5781.359550] Modules linked in: gpio_mockup isst_if_mmio isst_if_mbox_p=
ci intel_th_sth stm_core intel_th_pti intel_th_pci intel_th_gth pmt_telemet=
ry pmt_class intel_vsec intel_rapl_msr intel_rapl_common nfsv3 rpcsec_gss_k=
rb5 auth_rpcgss nfsv4 nfs lockd grace bridge stp llc sunrpc intel_uncore_fr=
equency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal =
intel_powerclamp coretemp iTCO_wdt ofpart kvm_intel intel_pmc_bxt iTCO_vend=
or_support spi_nor mtd intel_sdsi kvm spdm irqbypass dax_hmem joydev asn1_e=
ncoder snd_pcm mei_me i2c_i801 spi_intel_pci isst_if_common idxd snd_timer =
intel_th i2c_smbus spi_intel mei i2c_ismt ipmi_ssif cxl_acpi ipmi_si cxl_co=
re acpi_power_meter crc32c_intel i40e igb dca igc pinctrl_emmitsburg pinctr=
l_intel pwm_lpss fuse [last unloaded: isst_if_mmio]
> [ 5781.438080] CPU: 250 PID: 82496 Comm: modprobe Not tainted 6.3.0-rc5 #=
1
> [ 5781.449711] Hardware name: Intel Corporation, BIOS IFWI 03/12/2023
> [ 5781.461615] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> [ 5781.467585] Code: 01 01 e8 75 56 8e ff 0f 0b c3 cc cc cc cc 80 3d 4c 6=
7 ac 01 00 75 85 48 c7 c7 b0 31 cd a9 c6 05 3c 67 ac 01 01 e8 52 56 8e ff <=
0f> 0b c3 cc cc cc cc 80 3d 27 67 ac 01 00 0f 85 5e ff ff ff 48 c7
> [ 5781.488761] RSP: 0018:ff45a7f44d39feb0 EFLAGS: 00010286
> [ 5781.494745] RAX: 0000000000000000 RBX: ffffffffc0b36540 RCX: 000000000=
0000000
> [ 5781.502871] RDX: 0000000000000002 RSI: ffffffffa9c065c8 RDI: 00000000f=
fffffff
> [ 5781.510984] RBP: ff31c1afa78cb800 R08: 0000000000000001 R09: 000000000=
0000003
> [ 5781.519100] R10: ff31c1b6fc000000 R11: ff31c1b6fc000000 R12: ff31c1afa=
78c4f40
> [ 5781.527215] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [ 5781.535337] FS: 00007f9bc705a740(0000) GS:ff31c1b700280000(0000) knlGS=
:0000000000000000
> [ 5781.544529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5781.551063] CR2: 00007f9bc5e50dc0 CR3: 000000093b36c003 CR4: 000000000=
0f71ee0
> [ 5781.559180] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 5781.567307] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 000000000=
0000400
> [ 5781.575413] PKRU: 55555554
> [ 5781.578551] Call Trace:
> [ 5781.581394] <TASK>
> [ 5781.583868] gpio_mockup_exit+0x33/0x420 [gpio_mockup]
> [ 5781.589756] __do_sys_delete_module.constprop.0+0x180/0x270
> [ 5781.596112] ? syscall_trace_enter.constprop.0+0x17f/0x1b0
> [ 5781.602354] do_syscall_64+0x43/0x90

I hear you but this trace has nothing to do with the bpf/sockmap commit ?

My change looks correct, so your bisection might simply trigger because
of a wider window for another bug to surface.

John, do you have an idea of what is going on here ?
