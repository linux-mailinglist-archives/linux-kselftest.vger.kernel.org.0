Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CE37DD191
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjJaQ2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjJaQ2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 12:28:07 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E00102
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 09:28:01 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b6043d0bbeso1760808241.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698769681; x=1699374481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnirYMb0/SealnyxAtrqPAbgD/M5iu32PEWT4EArxN4=;
        b=yG4puHE53c+IyNaejmRIGXhFRwubGeKwvabl6mZFGZpPnGhp52S3vRKw9Ofl4SNX/R
         ZWDBcNxLRlTAunvKDKsY/wGT+mDdBgR21D0fkk/zx9Fmi2FQeBkekQP0q9i8lAjM6Tkz
         PZxt8HHzB7gC+1WL5LCxnA7WoNPJqzGqOgaJm8t3OL2N9glAGXoTGzudhOAFTbi+R+n4
         ZLpw8UOXl+7Tk1RWRR8L+yzm99n+2+yRcwB/nRsrwoVaR51CqhjfKYDQr+nIXtEg8uUr
         AT94tor25Ujjm/Zkn1ZMhs+UmyA/eQpQOPjpkFogIKKmrw87rprTHytqPYjo0QYPzRE4
         j90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769681; x=1699374481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnirYMb0/SealnyxAtrqPAbgD/M5iu32PEWT4EArxN4=;
        b=UAm6PVj1viZKeD/bL0zh2Ar4ThuNRsNXurByPPpfo/8UahVIWhh1OXTpKW2z8czYen
         TXTub60rbezPDxfTqi4sk+ajEkDnK5Mz0goAHq7kIS1R0E3O8RzwYj5vaZi01fWxd7uC
         vORuSOYjY6m88BRU9wv5fqeOyZCU8wvmcBfb2T/D+Vlj/rEuNm1hGyp5UHwAdR1SpwIT
         XKFF1fXnqClVOoQJZB0O5H+8gVSSKr66MCFqU958fqhKvgZvn9UoH+piBZryZxqG/aP7
         RV9P26e/wMEZFKjza6GfqtupZYW6yDgPasGQDB9fEMR7QC5g8NgEZiz11etC/rYGm/is
         3TEQ==
X-Gm-Message-State: AOJu0YyrUIuNyNG9MccEGvs0z2QiOdA3HrpmB+Tl2rjr4JG04SYg+OHl
        9qF7kqSUs2UVMUgsD8TXz/m4pP+5i/T619pvGmRmDw==
X-Google-Smtp-Source: AGHT+IETU8E60Bh/4WCGXygwfnJhns7LzXQAo16DH204oQiIzKGqiKrWnorgKsc4NzL2ZOqBnvb+hnY/4MHe4cYpiqg=
X-Received: by 2002:a67:a205:0:b0:457:d3d1:494b with SMTP id
 l5-20020a67a205000000b00457d3d1494bmr9611347vse.23.1698769680510; Tue, 31 Oct
 2023 09:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
In-Reply-To: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 31 Oct 2023 21:57:48 +0530
Message-ID: <CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com>
Subject: Re: [RFC] drm/tests: annotate intentional stack trace in drm_test_rect_calc_hscale()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        kv-team <kv-team@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 30 Oct 2023 at 14:33, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> We have started printing more and more intentional stack traces.  Whether
> it's testing KASAN is able to detect use after frees or it's part of a
> kunit test.
>
> These stack traces can be problematic.  They suddenly show up as a new
> failure.  Now the test team has to contact the developers.  A bunch of
> people have to investigate the bug.  We finally decide that it's
> intentional so now the test team has to update their filter scripts to
> mark it as intentional.  These filters are ad-hoc because there is no
> standard format for warnings.
>
> A better way would be to mark it as intentional from the start.
>
> Here, I have marked the beginning and the end of the trace.  It's more
> tricky for things like lkdtm_FORTIFY_MEM_MEMBER() where the flow doesn't
> reach the end of the function.  I guess I would print a different
> warning for stack traces that can't have a
> "Intentional warning finished\n" message at the end.
>
> I haven't actually tested this patch...  Daniel, do you have a
> list of intentional stack traces we could annotate?

[My two cents]

I have been noticing following kernel warnings / BUGs
These are starting happening from next-20231009.
I am not sure which are "Intentional warnings" or real regressions.

[   37.378220] BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xc4/0x300
[   37.645506] BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xec/0x300
..
[  632.407425] BUG: KASAN: null-ptr-deref in kobject_namespace+0x3c/0xb0


Logs: [Sorry for sharing long logs ]
==========

------------[ cut here ]------------
[  629.699281] WARNING: CPU: 0 PID: 2834 at
drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_hscale+0xbc/0xe8
[drm_kms_helper]
[  629.710944] Modules linked in: drm_rect_test(+)
drm_probe_helper_test drm_plane_helper_test drm_modes_test drm_mm_test
drm_managed_test drm_framebuffer_test drm_format_test
drm_format_helper_test drm_exec_test drm_exec drm_kunit_helpers
drm_dp_mst_helper_test drm_display_helper drm_damage_helper_test
drm_connector_test drm_cmdline_parser_test drm_buddy_test
prime_numbers drm_buddy tda998x onboard_usb_hub hdlcd cec crct10dif_ce
drm_dma_helper drm_kms_helper drm fuse backlight dm_mod ip_tables
x_tables
[  629.756007] CPU: 0 PID: 2834 Comm: kunit_try_catch Tainted: G    B
          N 6.6.0-next-20231031 #1
[  629.765381] Hardware name: ARM Juno development board (r2) (DT)
[  629.771343] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  629.778362] pc : drm_rect_calc_hscale+0xbc/0xe8 [drm_kms_helper]
[  629.785160] lr : drm_rect_calc_hscale+0x60/0xe8 [drm_kms_helper]
[  629.791955] sp : ffff800088907d20
[  629.795301] x29: ffff800088907d20 x28: 0000000000000000 x27: 0000000000000000
[  629.802533] x26: ffff0008270a39c0 x25: ffff8000885673e8 x24: ffff8000809ccf28
[  629.809770] x23: 0000000000000000 x22: 000000007fffffff x21: 00000000ffff0000
[  629.817003] x20: ffff80007faf0018 x19: 0000000000010000 x18: 000000007be82992
[  629.824236] x17: 000000040044ffff x16: 00500072b5503510 x15: 0000000000000000
[  629.831469] x14: ffff800085d51d00 x13: ffff8008b22e5000 x12: ffff600105778569
[  629.838704] x11: 1fffe00105778568 x10: ffff600105778568 x9 : ffff80007fae56e4
[  629.845940] x8 : ffff800088907d08 x7 : 0000000000000000 x6 : 0000000041b58ab3
[  629.853171] x5 : dfff800000000000 x4 : ffff700011120fb2 x3 : dfff800000000000
[  629.860406] x2 : 0000000000000003 x1 : 00000000ffff0000 x0 : 0000000000010000
[  629.867637] Call trace:
[  629.870108]  drm_rect_calc_hscale+0xbc/0xe8 [drm_kms_helper]
[  629.876561]  drm_test_rect_calc_hscale+0xac/0x150 [drm_rect_test]
[  629.882811]  kunit_try_run_case+0x84/0x110
[  629.886984]  kunit_generic_run_threadfn_adapter+0x38/0x60
[  629.892445]  kthread+0x18c/0x1a8
[  629.895723]  ret_from_fork+0x10/0x20
[  629.899355] ---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
[  629.914458] WARNING: CPU: 5 PID: 2836 at
drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_hscale+0xbc/0xe8
[drm_kms_helper]
[  629.926098] Modules linked in: drm_rect_test(+)
drm_probe_helper_test drm_plane_helper_test drm_modes_test drm_mm_test
drm_managed_test drm_framebuffer_test drm_format_test
drm_format_helper_test drm_exec_test drm_exec drm_kunit_helpers
drm_dp_mst_helper_test drm_display_helper drm_damage_helper_test
drm_connector_test drm_cmdline_parser_test drm_buddy_test
prime_numbers drm_buddy tda998x onboard_usb_hub hdlcd cec crct10dif_ce
drm_dma_helper drm_kms_helper drm fuse backlight dm_mod ip_tables
x_tables
[  629.971166] CPU: 5 PID: 2836 Comm: kunit_try_catch Tainted: G    B
 W        N 6.6.0-next-20231031 #1
[  629.980553] Hardware name: ARM Juno development board (r2) (DT)
[  629.986519] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  629.993545] pc : drm_rect_calc_hscale+0xbc/0xe8 [drm_kms_helper]
[  630.000401] lr : drm_rect_calc_hscale+0x60/0xe8 [drm_kms_helper]
[  630.007201] sp : ffff800088957d20
[  630.010548] x29: ffff800088957d20 x28: 0000000000000000 x27: 0000000000000000
[  630.017783] x26: ffff0008270a3dc0 x25: ffff8000885673e8 x24: ffff8000809ccf28
[  630.025019] x23: 0000000000000000 x22: 000000007fffffff x21: 0000000000010000
[  630.032249] x20: ffff80007faf0050 x19: 00000000ffff0000 x18: 00000000f9b8fcdb
[  630.039483] x17: 000000040044ffff x16: 00500072b5503510 x15: 0000000000000000
[  630.046715] x14: ffff0008008fa300 x13: ffff8008b2380000 x12: ffff600105778799
[  630.053951] x11: 1fffe00105778798 x10: ffff600105778798 x9 : ffff80007fae56e4
[  630.061187] x8 : ffff800088957d08 x7 : 0000000000000000 x6 : 0000000041b58ab3
[  630.068417] x5 : dfff800000000000 x4 : ffff70001112afb2 x3 : dfff800000000000
[  630.075651] x2 : 0000000000000003 x1 : 00000000ffff0000 x0 : 00000000ffff0000
[  630.082883] Call trace:
[  630.085355]  drm_rect_calc_hscale+0xbc/0xe8 [drm_kms_helper]
[  630.091808]  drm_test_rect_calc_hscale+0xac/0x150 [drm_rect_test]
[  630.098060]  kunit_try_run_case+0x84/0x110
[  630.102233]  kunit_generic_run_threadfn_adapter+0x38/0x60
[  630.107694]  kthread+0x18c/0x1a8
[  630.110973]  ret_from_fork+0x10/0x20
[  630.114607] ---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
[  630.172564] WARNING: CPU: 5 PID: 2846 at
drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_vscale+0xbc/0xe8
[drm_kms_helper]
[  630.184211] Modules linked in: drm_rect_test(+)
drm_probe_helper_test drm_plane_helper_test drm_modes_test drm_mm_test
drm_managed_test drm_framebuffer_test drm_format_test
drm_format_helper_test drm_exec_test drm_exec drm_kunit_helpers
drm_dp_mst_helper_test drm_display_helper drm_damage_helper_test
drm_connector_test drm_cmdline_parser_test drm_buddy_test
prime_numbers drm_buddy tda998x onboard_usb_hub hdlcd cec crct10dif_ce
drm_dma_helper drm_kms_helper drm fuse backlight dm_mod ip_tables
x_tables
[  630.229265] CPU: 5 PID: 2846 Comm: kunit_try_catch Tainted: G    B
 W        N 6.6.0-next-20231031 #1
[  630.238639] Hardware name: ARM Juno development board (r2) (DT)
[  630.244601] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  630.251621] pc : drm_rect_calc_vscale+0xbc/0xe8 [drm_kms_helper]
[  630.258417] lr : drm_rect_calc_vscale+0x60/0xe8 [drm_kms_helper]
[  630.265214] sp : ffff8000889c7d20
[  630.268560] x29: ffff8000889c7d20 x28: 0000000000000000 x27: 0000000000000000
[  630.275792] x26: ffff00082e57d440 x25: ffff8000885673e8 x24: ffff8000809ccf28
[  630.283029] x23: 0000000000000000 x22: 000000007fffffff x21: 00000000ffff0000
[  630.290261] x20: ffff80007faf0018 x19: 0000000000010000 x18: 000000004d058349
[  630.297494] x17: 000000040044ffff x16: 00500072b5503510 x15: 0000000000000000
[  630.304726] x14: ffff0008008fa300 x13: ffff8008b2380000 x12: ffff600105e39569
[  630.311962] x11: 1fffe00105e39568 x10: ffff600105e39568 x9 : ffff80007fae5594
[  630.319198] x8 : ffff8000889c7d08 x7 : 0000000000000000 x6 : 0000000041b58ab3
[  630.326430] x5 : dfff800000000000 x4 : ffff700011138fb2 x3 : dfff800000000000
[  630.333665] x2 : 0000000000000007 x1 : 00000000ffff0000 x0 : 0000000000010000
[  630.340894] Call trace:
[  630.343367]  drm_rect_calc_vscale+0xbc/0xe8 [drm_kms_helper]
[  630.349818]  drm_test_rect_calc_vscale+0xac/0x150 [drm_rect_test]
[  630.356068]  kunit_try_run_case+0x84/0x110
[  630.360240]  kunit_generic_run_threadfn_adapter+0x38/0x60
[  630.365701]  kthread+0x18c/0x1a8
[  630.368978]  ret_from_fork+0x10/0x20
[  630.372611] ---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
[  630.388003] WARNING: CPU: 3 PID: 2848 at
drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_vscale+0xbc/0xe8
[drm_kms_helper]
[  630.399652] Modules linked in: drm_rect_test(+)
drm_probe_helper_test drm_plane_helper_test drm_modes_test drm_mm_test
drm_managed_test drm_framebuffer_test drm_format_test
drm_format_helper_test drm_exec_test drm_exec drm_kunit_helpers
drm_dp_mst_helper_test drm_display_helper drm_damage_helper_test
drm_connector_test drm_cmdline_parser_test drm_buddy_test
prime_numbers drm_buddy tda998x onboard_usb_hub hdlcd cec crct10dif_ce
drm_dma_helper drm_kms_helper drm fuse backlight dm_mod ip_tables
x_tables
[  630.444724] CPU: 3 PID: 2848 Comm: kunit_try_catch Tainted: G    B
 W        N 6.6.0-next-20231031 #1
[  630.454107] Hardware name: ARM Juno development board (r2) (DT)
[  630.460071] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  630.467097] pc : drm_rect_calc_vscale+0xbc/0xe8 [drm_kms_helper]
[  630.473953] lr : drm_rect_calc_vscale+0x60/0xe8 [drm_kms_helper]
[  630.480751] sp : ffff8000889e7d20
[  630.484097] x29: ffff8000889e7d20 x28: 0000000000000000 x27: 0000000000000000
[  630.491332] x26: ffff00082e57d1c0 x25: ffff8000885673e8 x24: ffff8000809ccf28
[  630.498568] x23: 0000000000000000 x22: 000000007fffffff x21: 0000000000010000
[  630.505800] x20: ffff80007faf0050 x19: 00000000ffff0000 x18: 000000007be82992
[  630.513032] x17: 000000040044ffff x16: 00500072b5503510 x15: 0000000000000000
[  630.520265] x14: ffff0008008f8000 x13: 6461657268745f68 x12: ffff600104d8cbf9
[  630.527500] x11: 1fffe00104d8cbf8 x10: ffff600104d8cbf8 x9 : ffff80007fae5594
[  630.534736] x8 : ffff8000889e7d08 x7 : 0000000000000000 x6 : 0000000041b58ab3
[  630.541968] x5 : dfff800000000000 x4 : ffff70001113cfb2 x3 : dfff800000000000
[  630.549202] x2 : 0000000000000007 x1 : 00000000ffff0000 x0 : 00000000ffff0000
[  630.556433] Call trace:
[  630.558906]  drm_rect_calc_vscale+0xbc/0xe8 [drm_kms_helper]
[  630.565357]  drm_test_rect_calc_vscale+0xac/0x150 [drm_rect_test]
[  630.571609]  kunit_try_run_case+0x84/0x110
[  630.575782]  kunit_generic_run_threadfn_adapter+0x38/0x60
[  630.581244]  kthread+0x18c/0x1a8
[  630.584523]  ret_from_fork+0x10/0x20
[  630.588156] ---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
[  631.679963] kobject: '(null)' (00000000f512f33b): is not
initialized, yet kobject_get() is being called.
[  631.692367] WARNING: CPU: 2 PID: 2900 at lib/kobject.c:637
kobject_get+0xa4/0xf0
[  631.702388] Modules linked in: snd_hda_cirrus_scodec_test(+)
snd_hda_cirrus_scodec preemptirq_delay_test usbtest pci_epf_test
pci_endpoint_test hte_tegra194_test drm_rect_test
drm_probe_helper_test drm_plane_helper_test drm_modes_test drm_mm_test
drm_managed_test drm_framebuffer_test drm_format_test
drm_format_helper_test drm_exec_test drm_exec drm_kunit_helpers
drm_dp_mst_helper_test drm_display_helper drm_damage_helper_test
drm_connector_test drm_cmdline_parser_test drm_buddy_test
prime_numbers drm_buddy tda998x onboard_usb_hub hdlcd cec crct10dif_ce
drm_dma_helper drm_kms_helper drm fuse backlight dm_mod ip_tables
x_tables
[  631.760697] CPU: 2 PID: 2900 Comm: modprobe Tainted: G    B   W
   N 6.6.0-next-20231031 #1
[  631.772184] Hardware name: ARM Juno development board (r2) (DT)
[  631.780891] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  631.790639] pc : kobject_get+0xa4/0xf0
[  631.797169] lr : kobject_get+0xa4/0xf0
[  631.803699] sp : ffff800088616fa0
[  631.809794] x29: ffff800088616fa0 x28: ffff800085d42a60 x27: ffff80007fb3a180
[  631.819718] x26: ffff000830a36968 x25: ffff80007fb3a218 x24: ffff000828158298
[  631.829642] x23: ffff0008281582a0 x22: ffff80007fb3a1d0 x21: 1ffff000110c2e0c
[  631.839566] x20: ffff800082bd05a0 x19: ffff80007fb3a1d0 x18: 0000000000000000
[  631.849490] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 696e6920746f6e20
[  631.859413] x14: 7369203a29623333 x13: 2e64656c6c616320 x12: ffff7000110c2d95
[  631.869337] x11: 1ffff000110c2d94 x10: ffff7000110c2d94 x9 : ffff8000801a1018
[  631.879261] x8 : 00008fffeef3d26c x7 : ffff800088616ca7 x6 : 0000000000000001
[  631.889185] x5 : ffff800088616ca0 x4 : ffff7000110c2d95 x3 : dfff800000000000
[  631.899109] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00083c8fb480
[  631.909033] Call trace:
[  631.914258]  kobject_get+0xa4/0xf0
[  631.920440]  kobject_add_internal+0x58/0x438
[  631.927491]  kobject_add+0x104/0x198
[  631.933852]  kobject_create_and_add+0x70/0xc8
[  631.940991]  module_add_driver+0x190/0x1b0
[  631.947869]  bus_add_driver+0x1ac/0x2d0
[  631.954490]  driver_register+0xac/0x1f8
[  631.961107]  __platform_driver_register+0x4c/0x68
[  631.968595]  cirrus_scodec_test_suite_init+0x34/0xa8
[snd_hda_cirrus_scodec_test]
[  631.978867]  kunit_run_tests+0xc8/0x860
[  631.985484]  __kunit_test_suites_init+0x9c/0xf0
[  631.992797]  kunit_exec_run_tests+0x9c/0xb8
[  631.999762]  kunit_module_notify+0x2f0/0x318
[  632.006819]  notifier_call_chain+0x90/0x1c8
[  632.013784]  blocking_notifier_call_chain_robust+0xc8/0x148
[  632.022141]  load_module+0x2950/0x2d30
[  632.028672]  init_module_from_file+0xdc/0x138
[  632.035811]  __arm64_sys_finit_module+0x23c/0x458
[  632.043298]  invoke_syscall+0x68/0x198
[  632.049828]  el0_svc_common.constprop.0+0x80/0x150
[  632.057403]  do_el0_svc+0x38/0x50
[  632.063498]  el0_svc+0x3c/0x80
[  632.069332]  el0t_64_sync_handler+0x120/0x130
[  632.076471]  el0t_64_sync+0x190/0x198
[  632.082915] ---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
[  632.097826] refcount_t: addition on 0; use-after-free.
[  632.105742] WARNING: CPU: 2 PID: 2900 at lib/refcount.c:25
refcount_warn_saturate+0x14c/0x178
[  632.116955] Modules linked in: snd_hda_cirrus_scodec_test(+)
snd_hda_cirrus_scodec preemptirq_delay_test usbtest pci_epf_test
pci_endpoint_test hte_tegra194_test drm_rect_test
drm_probe_helper_test drm_plane_helper_test drm_modes_test drm_mm_test
drm_managed_test drm_framebuffer_test drm_format_test
drm_format_helper_test drm_exec_test drm_exec drm_kunit_helpers
drm_dp_mst_helper_test drm_display_helper drm_damage_helper_test
drm_connector_test drm_cmdline_parser_test drm_buddy_test
prime_numbers drm_buddy tda998x onboard_usb_hub hdlcd cec crct10dif_ce
drm_dma_helper drm_kms_helper drm fuse backlight dm_mod ip_tables
x_tables
[  632.175267] CPU: 2 PID: 2900 Comm: modprobe Tainted: G    B   W
   N 6.6.0-next-20231031 #1
[  632.186759] Hardware name: ARM Juno development board (r2) (DT)
[  632.193900] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  632.200892] pc : refcount_warn_saturate+0x14c/0x178
[  632.205801] lr : refcount_warn_saturate+0x14c/0x178
[  632.210703] sp : ffff800088616f80
[  632.214028] x29: ffff800088616f80 x28: ffff800085d42a60 x27: ffff80007fb3a180
[  632.221214] x26: ffff000830a36968 x25: ffff80007fb3a218 x24: ffff000828158298
[  632.228400] x23: ffff0008281582a0 x22: ffff80007fb3a1d0 x21: 1ffff000110c2e0c
[  632.235582] x20: ffff80007fb3a208 x19: 0000000000000002 x18: 0000000000000000
[  632.242769] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  632.249946] x14: 0000000000000000 x13: 2e656572662d7265 x12: ffff7000110c2d91
[  632.257125] x11: 1ffff000110c2d90 x10: ffff7000110c2d90 x9 : ffff8000801a1018
[  632.264305] x8 : 00008fffeef3d270 x7 : ffff800088616c87 x6 : 0000000000000001
[  632.271483] x5 : ffff800088616c80 x4 : ffff7000110c2d91 x3 : dfff800000000000
[  632.278663] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00083c8fb480
[  632.285842] Call trace:
[  632.288296]  refcount_warn_saturate+0x14c/0x178
[  632.292851]  kobject_get+0xec/0xf0
[  632.296277]  kobject_add_internal+0x58/0x438
[  632.300573]  kobject_add+0x104/0x198
[  632.304171]  kobject_create_and_add+0x70/0xc8
[  632.308553]  module_add_driver+0x190/0x1b0
[  632.312674]  bus_add_driver+0x1ac/0x2d0
[  632.316534]  driver_register+0xac/0x1f8
[  632.320388]  __platform_driver_register+0x4c/0x68
[  632.325116]  cirrus_scodec_test_suite_init+0x34/0xa8
[snd_hda_cirrus_scodec_test]
[  632.332668]  kunit_run_tests+0xc8/0x860
[  632.336527]  __kunit_test_suites_init+0x9c/0xf0
[  632.341084]  kunit_exec_run_tests+0x9c/0xb8
[  632.345287]  kunit_module_notify+0x2f0/0x318
[  632.349581]  notifier_call_chain+0x90/0x1c8
[  632.353788]  blocking_notifier_call_chain_robust+0xc8/0x148
[  632.359387]  load_module+0x2950/0x2d30
[  632.363160]  init_module_from_file+0xdc/0x138
[  632.367542]  __arm64_sys_finit_module+0x23c/0x458
[  632.372272]  invoke_syscall+0x68/0x198
[  632.376045]  el0_svc_common.constprop.0+0x80/0x150
[  632.380863]  do_el0_svc+0x38/0x50
[  632.384200]  el0_svc+0x3c/0x80
[  632.387273]  el0t_64_sync_handler+0x120/0x130
[  632.391653]  el0t_64_sync+0x190/0x198
[  632.395335] ---[ end trace 0000000000000000 ]---

[  632.400176] ==================================================================
[  632.407425] BUG: KASAN: null-ptr-deref in kobject_namespace+0x3c/0xb0
[  632.413902] Read of size 8 at addr 0000000000000018 by task modprobe/2900
[  632.420715]
[  632.422214] CPU: 2 PID: 2900 Comm: modprobe Tainted: G    B   W
   N 6.6.0-next-20231031 #1
[  632.430946] Hardware name: ARM Juno development board (r2) (DT)
[  632.436885] Call trace:
[  632.439338]  dump_backtrace+0x9c/0x128
[  632.443109]  show_stack+0x20/0x38
[  632.446441]  dump_stack_lvl+0x60/0xb0
[  632.450124]  print_report+0x2f0/0x5d8
[  632.453811]  kasan_report+0xc8/0x118
[  632.457408]  __asan_load8+0x68/0xc0
[  632.460918]  kobject_namespace+0x3c/0xb0
[  632.464866]  kobject_add_internal+0x104/0x438
[  632.469248]  kobject_add+0x104/0x198
[  632.472846]  kobject_create_and_add+0x70/0xc8
[  632.477229]  module_add_driver+0x190/0x1b0
[  632.481348]  bus_add_driver+0x1ac/0x2d0
[  632.485208]  driver_register+0xac/0x1f8
[  632.489063]  __platform_driver_register+0x4c/0x68
[  632.493790]  cirrus_scodec_test_suite_init+0x34/0xa8
[snd_hda_cirrus_scodec_test]
[  632.501337]  kunit_run_tests+0xc8/0x860
[  632.505197]  __kunit_test_suites_init+0x9c/0xf0
[  632.509754]  kunit_exec_run_tests+0x9c/0xb8
[  632.513956]  kunit_module_notify+0x2f0/0x318
[  632.518251]  notifier_call_chain+0x90/0x1c8
[  632.522457]  blocking_notifier_call_chain_robust+0xc8/0x148
[  632.528057]  load_module+0x2950/0x2d30
[  632.531829]  init_module_from_file+0xdc/0x138
[  632.536211]  __arm64_sys_finit_module+0x23c/0x458
[  632.540941]  invoke_syscall+0x68/0x198
[  632.544713]  el0_svc_common.constprop.0+0x80/0x150
[  632.549531]  do_el0_svc+0x38/0x50
[  632.552868]  el0_svc+0x3c/0x80
[  632.555941]  el0t_64_sync_handler+0x120/0x130
[  632.560321]  el0t_64_sync+0x190/0x198
[  632.564002] ==================================================================
[  632.571398] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000018
[  632.580388] Mem abort info:
[  632.583201]   ESR = 0x0000000096000004
[  632.587023]   EC = 0x25: DABT (current EL), IL = 32 bits
[  632.592413]   SET = 0, FnV = 0
[  632.595520]   EA = 0, S1PTW = 0
[  632.598682]   FSC = 0x04: level 0 translation fault
[  632.603612] Data abort info:
[  632.606510]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  632.612049]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  632.617155]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  632.622524] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008ace48000
[  632.629044] [0000000000000018] pgd=0000000000000000, p4d=0000000000000000
[  632.635923] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  632.642219] Modules linked in: snd_hda_cirrus_scodec_test(+)
snd_hda_cirrus_scodec preemptirq_delay_test usbtest pci_epf_test
pci_endpoint_test hte_tegra194_test drm_rect_test
drm_probe_helper_test drm_plane_helper_test drm_modes_test drm_mm_test
drm_managed_test drm_framebuffer_test drm_format_test
drm_format_helper_test drm_exec_test drm_exec drm_kunit_helpers
drm_dp_mst_helper_test drm_display_helper drm_damage_helper_test
drm_connector_test drm_cmdline_parser_test drm_buddy_test
prime_numbers drm_buddy tda998x onboard_usb_hub hdlcd cec crct10dif_ce
drm_dma_helper drm_kms_helper drm fuse backlight dm_mod ip_tables
x_tables
[  632.698102] CPU: 2 PID: 2900 Comm: modprobe Tainted: G    B   W
   N 6.6.0-next-20231031 #1
[  632.706838] Hardware name: ARM Juno development board (r2) (DT)
[  632.712777] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  632.719767] pc : kobject_namespace+0x3c/0xb0
[  632.724072] lr : kobject_namespace+0x3c/0xb0
[  632.728367] sp : ffff800088616f90
[  632.731692] x29: ffff800088616f90 x28: ffff800085d42a60 x27: ffff80007fb3a180
[  632.738878] x26: ffff000830a36968 x25: ffff8000831269a0 x24: ffff000828158298
[  632.746062] x23: ffff0008281582a0 x22: ffff0008281582a8 x21: 0000000000000000
[  632.753242] x20: ffff80007fb3a1d0 x19: ffff000828158280 x18: 0000000000000000
[  632.760421] x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 3d3d3d3d3d3d3d3d
[  632.767600] x14: 3d3d3d3d3d3d3d3d x13: 3d3d3d3d3d3d3d3d x12: ffff700010ed19d9
[  632.774780] x11: 1ffff00010ed19d8 x10: ffff700010ed19d8 x9 : dfff800000000000
[  632.781967] x8 : 00008fffef12e628 x7 : ffff80008768cec7 x6 : 0000000000000001
[  632.789151] x5 : ffff80008768cec0 x4 : ffff700010ed19d9 x3 : 0000000000000000
[  632.796330] x2 : 0000000000040220 x1 : ffff00083c8fb480 x0 : 0000000000000001
[  632.803508] Call trace:
[  632.805966]  kobject_namespace+0x3c/0xb0
[  632.809917]  kobject_add_internal+0x104/0x438
[  632.814300]  kobject_add+0x104/0x198
[  632.817898]  kobject_create_and_add+0x70/0xc8
[  632.822286]  module_add_driver+0x190/0x1b0
[  632.826408]  bus_add_driver+0x1ac/0x2d0
[  632.830269]  driver_register+0xac/0x1f8
[  632.834123]  __platform_driver_register+0x4c/0x68
[  632.838858]  cirrus_scodec_test_suite_init+0x34/0xa8
[snd_hda_cirrus_scodec_test]
[  632.846408]  kunit_run_tests+0xc8/0x860
[  632.850270]  __kunit_test_suites_init+0x9c/0xf0
[  632.854828]  kunit_exec_run_tests+0x9c/0xb8
[  632.859037]  kunit_module_notify+0x2f0/0x318
[  632.863332]  notifier_call_chain+0x90/0x1c8
[  632.867541]  blocking_notifier_call_chain_robust+0xc8/0x148
[  632.873141]  load_module+0x2950/0x2d30
[  632.876913]  init_module_from_file+0xdc/0x138
[  632.881295]  __arm64_sys_finit_module+0x23c/0x458
[  632.886028]  invoke_syscall+0x68/0x198
[  632.889806]  el0_svc_common.constprop.0+0x80/0x150
[  632.894625]  do_el0_svc+0x38/0x50
[  632.897966]  el0_svc+0x3c/0x80
[  632.901045]  el0t_64_sync_handler+0x120/0x130
[  632.905428]  el0t_64_sync+0x190/0x198
[  632.909116] Code: 979a7e35 f9401695 910062a0 979a7e32 (f9400ea1)
[  632.915238] ---[ end trace 0000000000000000 ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231031/testrun/20866349/suite/log-parser-test/test/check-kernel-bug/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231031/testrun/20866349/suite/log-parser-test/tests/

- Naresh
