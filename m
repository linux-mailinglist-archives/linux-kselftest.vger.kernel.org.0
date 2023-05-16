Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962717050B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 16:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjEPO2C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 10:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjEPO17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 10:27:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA07EE8
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 07:27:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f38824a025so1819981cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684247277; x=1686839277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AayuNIhRTV03xRUzarJZPTHvJp4e+UHEoTcw79g1j40=;
        b=kwqcHYdkL7rFl3g+642wuNa0GbUpjcFfyO1NjDeeVfYnNMJJy+TmSlotRBJFoo+837
         fqwQh5q8TdPYkbp/aMYqqFj/hNh3GFABRAc2z8CZyOGRY9E4tfq4R1C65QWVeQ15fbHs
         /mCTPJ9hj2OYCuUKB/kbmLEBNJgEFWZnUFmRHyHprjObjtBL4zc1bznF91aXPHBKoUkt
         B2/uhY2SPwQAJWacDXOAQvgy9lHF0VnF4ModaPbrtACRA2NtqkkJO7ZFCfcyLXUGjo38
         Rr3e8DwslXe4gh8uyDIh9BtCL1nuJ2Vo91dyLeC+f5lC5UuWwtHchIOtFxMNghfglnEm
         FYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684247277; x=1686839277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AayuNIhRTV03xRUzarJZPTHvJp4e+UHEoTcw79g1j40=;
        b=JnHF2DxqBqbYQG+uYVNjn/UfkNVaq/L+mI/yA12s3hJ1IGOLL+/1iPiXaHTKyZwUCN
         ZgRaJ00rSLIuLWOWfwf+OkgWCqr1vPg0Q8uFVgGSrphEJ00irqLSZoMvMUS1fad+VE5x
         v+qjD4TUV3tl8kUrVGQR0x+cWeJD+r1ZPBDDeBfIQYe3ZwfVhRXI54v+j2e3o/7DSdgo
         lfbmxOPyuTisEEbCfcL3BT+KtmxCztmuD+60PdO83GmyRE4Pp7/ZFEOwL8WWtNqhNewS
         Y8d5QpZzl1nOlCyLhOYyO3QUiywHp/vXqPflwdHwgBV0+Lh2JKs/u8ShTs9nizt2JeXE
         MKQA==
X-Gm-Message-State: AC+VfDz4ynakTqDjTxsSqjOOocajYjlkZWiSXqUDaoSKNMZaPeX6OVkB
        nMBjE9PdwnOXubSrtSsmSGD4WWIR6/zW1qqvE8gQmKGgWn2ze4m8Lf8=
X-Google-Smtp-Source: ACHHUZ7hy9ErGHl7Q2627H6m7yBU8eMVeGoH11mFgv+H6UWXrnbD8ul2vnuUcwA4B5PG96UT0yYGss8DpU53mUFAH/g=
X-Received: by 2002:ac8:7dcb:0:b0:3f5:2006:50f1 with SMTP id
 c11-20020ac87dcb000000b003f5200650f1mr341722qte.12.1684247277584; Tue, 16 May
 2023 07:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com> <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com> <CALPaoCgknY0pWkXaCayPx28otcA5=v5a5FFoLFx3At0cGvAykg@mail.gmail.com>
In-Reply-To: <CALPaoCgknY0pWkXaCayPx28otcA5=v5a5FFoLFx3At0cGvAykg@mail.gmail.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 16 May 2023 16:27:46 +0200
Message-ID: <CALPaoCj4a=ePOfdd1CKHkOP1B9DZTGLCDHeNb0QLvCophX941g@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 16, 2023 at 4:18=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
> According to cpu_hotplug.rst, the startup callbacks are called before
> a CPU is started and the teardown callbacks are called after the CPU
> has become dysfunctional, so it should always be safe for a CPU to
> access its own data, so all I need to do here is avoid walking domain
> lists in resctrl_mbm_flush_cpu().
>
> However, this also means that resctrl_{on,off}line_cpu() call
> clear_closid_rmid() on a different CPU, so whichever CPU executes
> these will zap its own pqr_state struct and PQR_ASSOC MSR.

Sorry, I read the wrong section. I was looking at PREPARE section
callbacks. ONLINE callbacks are called on the CPU, so calling
clear_closid_rmid() is fine.

It says the offline callback is called from the per-cpu hotplug
thread, so I'm not sure if that means another context switch is
possible after the teardown handler has run. To be safe, I can make
resctrl_mbm_flush_cpu() check to see if it still has its domain state.

-Peter
