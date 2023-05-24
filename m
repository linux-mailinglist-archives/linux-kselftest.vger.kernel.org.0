Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD170FCB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjEXRdU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjEXRdT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:33:19 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FF812E;
        Wed, 24 May 2023 10:33:18 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51097a4f330so311391a12.0;
        Wed, 24 May 2023 10:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684949597; x=1687541597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCSKoj+QaYMGiALxKIVygFGEfEGQMG7Gw+jdrUBXjYI=;
        b=QjmIs1SU39Gf2T4z3QvfIc/ApguHIhSJ13yhSoq2Z2Z491ppcXJa/1Do1+O55SZ2Rc
         ZyKbgbX7jUNe06FYYeOKsM3k2E+2Gw+l/Z+PbhVyBzYtQNAyDpOM2j8PBYMHZjLfj+dP
         eNPtk544mJteUsEpVixGQ5FNkyx05edYhqmN/yzNyq4aNouXS2vyxD03ATiqft/Q1wAI
         7tzAb98CNu+ASWudQfpUjR8Cj596jFEiS333QjZK+i8C4CJgbZ/b/e7JZ6FY32eD1gMs
         ViFhfpr8R8U4Wd5MYGI7MMja7skAYBCiKIw8rYz8fIBYW2tOdypvdvSKhb77vo88QeXH
         Nu1w==
X-Gm-Message-State: AC+VfDz6xnZ4fu0Be/1bShT3ZJ2zPG6phusACDzxBLqD9V4H0MAjdvJB
        0pIpEdblBPjHNbRzmvUg+UAph5oGHnd78R5BDZI=
X-Google-Smtp-Source: ACHHUZ75t5LOoP5fPEw1B3B8AOZ5QAW3p/uA3PR3RjFQ63NrJQ3bU0l+qjgSiV2WQ1zsptMKJ1KiCOsk0UIwyQ0utjI=
X-Received: by 2002:a17:906:2218:b0:96f:4c38:4b1a with SMTP id
 s24-20020a170906221800b0096f4c384b1amr16403004ejs.5.1684949596574; Wed, 24
 May 2023 10:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230517131102.934196-1-arnd@kernel.org> <20230517131102.934196-11-arnd@kernel.org>
 <CAJZ5v0h0spuxK-7LBJSU9BK2TEOUeMjf7hhKScadkxFN_RwStQ@mail.gmail.com> <6b7f6f66-7890-47a3-a22d-e29f2944823a@app.fastmail.com>
In-Reply-To: <6b7f6f66-7890-47a3-a22d-e29f2944823a@app.fastmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:33:05 +0200
Message-ID: <CAJZ5v0h+HNTMcfxFuOeO92D__NzJSTHfjzP5VQG4D+WuNmHpdw@mail.gmail.com>
Subject: Re: [PATCH 10/14] suspend: add a arch_resume_nosmt() prototype
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 4:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 17, 2023, at 15:48, Rafael J. Wysocki wrote:
> > On Wed, May 17, 2023 at 3:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> The arch_resume_nosmt() has a __weak definition, plus an x86
> >> specific override, but no prototype that ensures the two have
> >> the same arguments. This causes a W=1 warning:
> >>
> >> arch/x86/power/hibernate.c:189:5: error: no previous prototype for 'arch_resume_nosmt' [-Werror=missing-prototypes]
> >>
> >> Add the prototype in linux/suspend.h, which is included in
> >> both places.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Do you want me to pick this up?
>
> Yes, please do. Thanks,

Done, thanks!
