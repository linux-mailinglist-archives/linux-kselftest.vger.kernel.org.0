Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853527244CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbjFFNtL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbjFFNtI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:49:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487610F7
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 06:48:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f6c6320d4eso176911cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686059324; x=1688651324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3etSudPv0uwqZOoY7JLZCAsQLOTHgmOhNgM4w6wd+A=;
        b=BvnVdXFthGTIr6/P+iT+/1fKKqBwuL8xK7GHR/lDK16ez+mkL+PyQts9Gtn0y+XF0F
         uALY/YZY3ZUAvdPezr/Ib1MnhKWdwxAn86wi9yJdqQIOgco+N7mB2q2n2c0RlUOmx4uh
         FtxfV7SvN4HiCnbG+RZ8BmBoMQCPBn27+Mw4OM1u9rp7u6I0ia5QvSnWI7FD6CgFwlgW
         8c/iBYode1/5JKHJdUa2Pmqx3A/aP7BpBVxhdcKUI75LN9TpB5Z++Fkxz9/1EEGl5B73
         sP/a4Bl3mUgztagYoOJYRf7An6U1Ds5meELjhxs62ZDjURa2D3G49HF+W8Lx25CEeZKK
         oEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059324; x=1688651324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3etSudPv0uwqZOoY7JLZCAsQLOTHgmOhNgM4w6wd+A=;
        b=QJDr2JUsS+vsEIrvbv6CE4Ye+Q6JYzD5Qro2MwoDZqShWoelWHTunav99+QjOb7FwG
         mv7P3SFByLFvlSPKI7o4kA6H3RFQr07XBzdsozv6a0ljhUt+vkBowgIoN6mABawS4H/k
         KYbCQKXEYUkbbjJxfl26Ppm/9CGzIh5Yyb+5T3W/2wFB4wTlWiWsYUz+kqFJnMagD21u
         8cwiiZzdkwbEIgNOf+Eu+Poe9raez20v3WFhhvV6a2wo8i4FwHv6a1t+gydgONdEgLXO
         X5Asw0WDVd4+jXwoIxmXXKnvBNuXMI2Oiu1De4iWm78+nM1fYh+pmtjBguZlgdKsBQDl
         d39g==
X-Gm-Message-State: AC+VfDyxrbKUkx0AJTIboxJ/aB/VvWzDm/EXTMAaVkL5I3vNZJ5vE4+b
        0TU3RD9pyIT2urGWNXrnbDYYX7ESlgXQK/hfbV8lEw==
X-Google-Smtp-Source: ACHHUZ6vV/EFLpvxIX5ALVT8r2w/veNw8/mRcwm+bOwmf2mu7mcfgxQXPkq4SpOg5yLLeWgic4+jmctAhp0DN+QlYpw=
X-Received: by 2002:ac8:5a81:0:b0:3f8:1db6:201c with SMTP id
 c1-20020ac85a81000000b003f81db6201cmr137840qtc.13.1686059324209; Tue, 06 Jun
 2023 06:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com> <20230421141723.2405942-9-peternewman@google.com>
In-Reply-To: <20230421141723.2405942-9-peternewman@google.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 6 Jun 2023 15:48:33 +0200
Message-ID: <CALPaoCi_N8JHbP4zFD=ijBh5-=4Q0Ec-LrspYNGGnj4G6A6U0g@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] x86/resctrl: Use mbm_update() to push soft RMID counts
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
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

On Fri, Apr 21, 2023 at 4:18=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
>
> __mon_event_count() only reads the current software count and does not
> cause CPUs in the domain to flush. For mbm_update() to be effective in
> preventing overflow in hardware counters with soft RMIDs, it needs to
> flush the domain CPUs so that all of the HW RMIDs are read.
>
> When RMIDs are soft, mbm_update() is intended to push bandwidth counts
> to the software counters rather than pulling the counts from hardware
> when userspace reads event counts, as this is a lot more efficient when
> the number of HW RMIDs is fixed.

The low frequency with which the overflow handler is run would
introduce too much error into bandwidth calculations and running it
more frequently regardless of whether event count reads are being
requested by the user is not a good use of CPU time.

mon_event_read() needs to pull fresh event count values from hardware.

> When RMIDs are soft, mbm_update() only calls mbm_flush_cpu_handler() on
> each CPU in the domain rather than reading all RMIDs.

I'll try going back to Stephane's original approach of rate-limiting
how often domain CPUs need to be flushed and allowing the user to
configure the time threshold. This will allow mbm_update() to read all
of the RMIDs without triggering lots of redundant IPIs. (redundant
because only the current RMID on each CPU can change when RMIDs are
soft)
