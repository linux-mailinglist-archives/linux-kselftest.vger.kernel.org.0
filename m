Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942A706C8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjEQPWG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEQPWF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 11:22:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB276BE
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 08:22:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso7108a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684336921; x=1686928921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HphpZG1cfp4ZuEeq32BSNbxONoUw/U/BOfxh6PlDKrI=;
        b=eAbUHob0fvSN+keUC4LH8COrh2z6bi/dUGViO2F8YhgafASrYUyJhiI1nnoxS4F0u4
         oOfvp6HZwnW+7ZfQ2maR569eeTSTLJqZDlCfUMGU6qnqnDBNZpvxvn+l3qLbZ3DaHhdb
         a55sDMdXNOWilq21OpS2MBescQVd1sIMEM17wvmciHj0af+PfkCl85wEyMoh5aFLrajy
         DcGHkMp6BYdqoPD2RcQfHhWkgxWez0NVDti2+0XbaXRdjsOLPa4nnRP2WQAoOpQJImS5
         weEUDQRHGB6LPTpDTSs8ROoEpiKzYsac6RzNDnYZsGsvgTG5tIfLmcHbQeuoEEoZ1Pos
         U/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336921; x=1686928921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HphpZG1cfp4ZuEeq32BSNbxONoUw/U/BOfxh6PlDKrI=;
        b=jb8ygTESmTgR7asPUTd5qIlnVzffA7jRwx8dbVrT9kH394WIdAPUBIbJ+vdIWUasbe
         fnEGE8lCXYq/h6vV0aps+IfW90vx1o4gm1MU6iEP7IXcuW65cQaYYXkuMYrAZ/qmbQML
         /Zhi9L6Tf4qpxVrTR49ViUhg21zDPbuq1AtfYW+sPdwyF1Ynx9mDTv9FwKOEilCPyQB1
         KAbO//29B7LB89H0ocJ8Kejbd7qnEpjjmwIxQSi8sjYxq1WjjyB/41FhYnYValpD4H9u
         /sHdnz9mG5p2S01nZeiy5Ds1FS01TJklTbgX2AS9aAwRAlgvtxOhrG9l4MBBwrD2AVi7
         /eIA==
X-Gm-Message-State: AC+VfDzMCNQQrIbRZHJvyITiipLCb6bm0tJ6fp4oeXGKr3NSvrDpiO1D
        GiriTlH8SueYS71feg4YMBHatP1oUsmDCtL7ZcWozA==
X-Google-Smtp-Source: ACHHUZ4G7d3trM79A9+Z27qD8TGxLp9bh/6bY2sGZ9ppET4JtI3nyUXUpn97bcd2BZ3TlAms6Z2VtD3tYpahhrHXcQw=
X-Received: by 2002:a50:aadd:0:b0:50b:f6ce:2f3d with SMTP id
 r29-20020a50aadd000000b0050bf6ce2f3dmr142899edc.0.1684336921213; Wed, 17 May
 2023 08:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com>
In-Reply-To: <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 17 May 2023 08:21:23 -0700
Message-ID: <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
        jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
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

On Wed, May 17, 2023 at 8:07=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/17/23 03:51, Stephen R=C3=B6ttger wrote:
> > On Wed, May 17, 2023 at 12:41=E2=80=AFAM Dave Hansen <dave.hansen@intel=
.com> wrote:
> >> Can't run arbitrary instructions, but can make (pretty) arbitrary sysc=
alls?
> >
> > The threat model is that the attacker has arbitrary read/write, while o=
ther
> > threads run in parallel. So whenever a regular thread performs a syscal=
l and
> > takes a syscall argument from memory, we assume that argument can be at=
tacker
> > controlled.
> > Unfortunately, the line is a bit blurry which syscalls / syscall argume=
nts we
> > need to assume to be attacker controlled.
>
> Ahh, OK.  So, it's not that the *attacker* can make arbitrary syscalls.
> It's that the attacker might leverage its arbitrary write to trick a
> victim thread into turning what would otherwise be a good syscall into a
> bad one with attacker-controlled content.
>
> I guess that makes the readv/writev-style of things a bad idea in this
> environment.
>
> >>> Sigreturn is a separate problem that we hope to solve by adding pkey
> >>> support to sigaltstack
> >>
> >> What kind of support were you planning to add?
> >
> > We=E2=80=99d like to allow registering pkey-tagged memory as a sigaltst=
ack. This would
> > allow the signal handler to run isolated from other threads. Right now,=
 the
> > main reason this doesn=E2=80=99t work is that the kernel would need to =
change the pkru
> > state before storing the register state on the stack.
> >
> >> I was thinking that an attacker with arbitrary write access would wait
> >> until PKRU was on the userspace stack and *JUST* before the kernel
> >> sigreturn code restores it to write a malicious value.  It could
> >> presumably do this with some asynchronous mechanism so that even if
> >> there was only one attacker thread, it could change its own value.
> >
> > I=E2=80=99m not sure I follow the details, can you give an example of a=
n asynchronous
> > mechanism to do this? E.g. would this be the kernel writing to the memo=
ry in a
> > syscall for example?
>
> I was thinking of all of the IORING_OP_*'s that can write to memory or
> aio(7).

IORING is challenging from security perspectives, for now, it is
disabled in ChromeOS.
Though I'm not sure how aio is related ?

Thanks
-Jeff
