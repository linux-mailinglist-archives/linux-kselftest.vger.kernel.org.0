Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E470C47CBB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 04:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbhLVD2q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 22:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhLVD2q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 22:28:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B7C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 19:28:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q16so1931976wrg.7
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 19:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwGmaz0czI4/jq/c3gNLjgrvk2T0ZPOGYi2vGZRAgJ8=;
        b=Jt4H1fUdCEMOLQHX3j8EBBqo9BuEi+lYppPytwWRaVi0mDh8ODMpWedLRWd3H7rBfJ
         AQ5fHBfcUpWYc5BinZTMZtuYyjBr4pkV/mECZlvDJKg0fbo9/CqScbYQrjzunNsD10ws
         R4GC78RSk9bHWAowN0oXp4B+4QcZm1bP1oWOhyPirxW+IdhskSQteDzfNLrSW1UQATzC
         mL5RHZSW7E3tEYfaWw1uFkp/B9IaBmJS4cHPJkxrdDesqtq3ZHdbYUAm1D60lrU4wM7M
         0N/jdAsLtiQ+OARU0DHfXhoDcm6KRc9DVTm2PcVKTwiueoZYle3k8QGZxCEcvc5uziZL
         GXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwGmaz0czI4/jq/c3gNLjgrvk2T0ZPOGYi2vGZRAgJ8=;
        b=1YnYUkq83VAyL0RjfAw6r/a2jfsBxf8WPO+pONQxheNoxx4QQm/eJlxUv8wMwKDfMk
         Hxr4tT/BiI0IpWjSURtpDys66b9QgjHQNkh5CzkoIjZ1ee0gCOuUEM75umPyzx2Dt1Xx
         59ZWbJu8yL8DEVQ4YHmCgyqEUFSuLZ/vRqgFHWokdBsJ9KKYmySWzdL9nri5w9MROOJa
         QBoPol+Lx7v88MFj48Lns/e2GmtA+gWzKXPlvLQBjvvJI72vU7dhXiGVKzz9Y05mWy26
         qjzYk+WQZ9dwlWAf6V0wY6sZ8z1BKeueIKBEg2kqOHjruSnMvPZQHPZhiycDOj1GKAEe
         1AmQ==
X-Gm-Message-State: AOAM531O5xXxa5if43woGcGi0Xq+K0bdq+xT5UsecdYKKDietMKcOw7v
        +CsBx8r775jUIYsx302quI+JP0iWcGMHMrb2tPuDjg==
X-Google-Smtp-Source: ABdhPJyUK9DbRMSBUpws7YF1ETrsADtGZwEQdEB0A/0NZqBFbMnOmeP9lttyWY0swzgjdJ4wCDf6AlQTOuCU5OY1CEk=
X-Received: by 2002:a5d:56c2:: with SMTP id m2mr655955wrw.313.1640143724222;
 Tue, 21 Dec 2021 19:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20211221125617.932371-1-anup.patel@wdc.com> <3e3b5295-f6fb-1ff9-acfe-1a4c47c6ba20@linuxfoundation.org>
 <4d739c28-e07d-f921-8a8d-a5343139e234@redhat.com>
In-Reply-To: <4d739c28-e07d-f921-8a8d-a5343139e234@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 22 Dec 2021 08:58:30 +0530
Message-ID: <CAAhSdy26_a6RBTQB7FYrEAkZNcQ4xH+GkV-iv4yR9LuNEE_CmQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix compile error for non-x86 vm_compute_max_gfn()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 10:53 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/21/21 18:22, Shuah Khan wrote:
> > On 12/21/21 5:56 AM, Anup Patel wrote:
> >> The inline version of vm_compute_max_gfn() in kvm_util.h directly
> >> access members of "struct kvm_vm" which causes compile errors for
> >> non-x86 architectures because lib/elf.c includes "kvm_util.h" before
> >> "kvm_util_internal.h".
> >>
> >> This patch fixes above described compile error by converting inline
> >> version of vm_compute_max_gfn() into a macro.
> >
> > Thank you for the patch. Please include the actual compile error in the
> > change log and send v2,
>
> Hi, a similar patch is already queued and should get to Linus today or
> tomorrow.

Thanks Paolo, I missed Andrew's fix for this.

Regards,
Anup

>
> Paolo
>
