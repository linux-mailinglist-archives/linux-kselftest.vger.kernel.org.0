Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A168F6155FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 00:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiKAXPL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKAXO4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 19:14:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C2BCB3
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 16:14:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r12so25590239lfp.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8yiTQsX1YddIHupT9Jn8m/7K2SjlfUqQTaa+OxHAwfA=;
        b=D7txH0CL0E3ZJdaEoJ9ZXSBklXaCASoY33ql0hzqTNyBOE99q8QLzgnmY1DVnp20+e
         cn9VXIMwJG9XQt+EbAQGf+zog8jiEDMKvNZns8ImNcN3HsRbQ05pR3IkfjOWCyskv4+/
         whSgLG8fvhjiMLJ0FuBmbe8zl7sLg1hq1lGSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yiTQsX1YddIHupT9Jn8m/7K2SjlfUqQTaa+OxHAwfA=;
        b=682yNcRLiyOSv0Sf5Hxn2Ayx4dVZWl4YEZzVb5QWsaF4jw6xZbvZQ0W6AmAFPCYArl
         smaJ0beAZ1OJCk9Hw8HjURaJYixaZaF5ZJFuomuHzZmgJVpCeB/d4LF7MSgl1ogAQo9Z
         G8dKIrgUzxBPu9ltI8emttXI5Bf43rUbZECxZUZdkmerlbaC/nKaVc5MbOVFthtuq0Zd
         gX0zrdAPYUitX8eT9aqKwaac8DWsMU6V+uG1CSRmvhNTmqMfvXpoSRNPfsfvzpqJTRFm
         XqlCgArWxy4kUe4fn/SHgk380uNCeoPQPDOjZSSbzeotGjBtv66JaswLyfg84CweOrBi
         ctbg==
X-Gm-Message-State: ACrzQf2rm6sycLkajY408EXIbmJRIm+tS4lNWfqq40/h4d8tchDta0FE
        DlvM8gzKR3Cg8FaLXItJfHsYINVETszzC7GzLjEVuQ==
X-Google-Smtp-Source: AMsMyM6yfVH5g/8K53w1J5qprFRCuXJ+DD6q91X7fVV4O1Nu9EC7J0q+sXRzpoJ2QZB26O4NzdElDUKnyHddCyFEc4g=
X-Received: by 2002:ac2:5088:0:b0:4a2:2e18:c4c9 with SMTP id
 f8-20020ac25088000000b004a22e18c4c9mr7814819lfm.5.1667344490528; Tue, 01 Nov
 2022 16:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com> <202208081018.9C782F184C@keescook>
In-Reply-To: <202208081018.9C782F184C@keescook>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 1 Nov 2022 16:14:39 -0700
Message-ID: <CABi2SkVXMUVhSTJezfHt_BKxyKP+x++9oveuB3qJZL7N672UKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm/memfd: MFD_NOEXEC for memfd_create
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@google.com, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        dev@opencontainers.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees

Sorry for the long overdue reply.

Those questions are really helpful  to understand the usage of memfd_create,
I will try to answer them, please see below inline.

On Mon, Aug 8, 2022 at 10:46 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Aug 05, 2022 at 10:21:21PM +0000, jeffxu@google.com wrote:
> > This v2 series MFD_NOEXEC, this series includes:
> > 1> address comments in V1
> > 2> add sysctl (vm.mfd_noexec) to change the default file permissions
> >     of memfd_create to be non-executable.
> >
> > Below are cover-level for v1:
> >
> > The default file permissions on a memfd include execute bits, which
> > means that such a memfd can be filled with a executable and passed to
> > the exec() family of functions. This is undesirable on systems where all
> > code is verified and all filesystems are intended to be mounted noexec,
> > since an attacker may be able to use a memfd to load unverified code and
> > execute it.
>
> I would absolutely like to see some kind of protection here. However,
> I'd like a more specific threat model. What are the cases where the X
> bit has been abused (e.g.[1])? What are the cases where the X bit is
> needed (e.g.[2])? With those in mind, it should be possible to draw
> a clear line between the two cases. (e.g. we need to avoid a confused
> deputy attack where an "unprivileged" user can pass an executable memfd
> to a "privileged" user. How those privileges are defined may matter a
> lot based on how memfds are being used. For example, can runc's use of
> executable memfds be distinguished from an attacker's?)
>
runc needs memfd to be executable, so the host with runc need to be able to
create both non-executable memfd and executable memfd.
memfd_create API itself can't enforce the security of how it is being used.

> > Additionally, execution via memfd is a common way to avoid scrutiny for
> > malicious code, since it allows execution of a program without a file
> > ever appearing on disk. This attack vector is not totally mitigated with
> > this new flag, since the default memfd file permissions must remain
> > executable to avoid breaking existing legitimate uses, but it should be
> > possible to use other security mechanisms to prevent memfd_create calls
> > without MFD_NOEXEC on systems where it is known that executable memfds
> > are not necessary.
>
> This reminds me of dealing with non-executable stacks. There ended up
> being three states:
>
> - requested to be executable (PT_GNU_STACK X)
> - requested to be non-executable (PT_GNU_STACK NX)
> - undefined (no PT_GNU_STACK)
>
> The first two are clearly defined, but the third needed a lot of special
> handling. For a "safe by default" world, the third should be "NX", but
> old stuff depended on it being "X".
>
> Here, we have a bit being present or not, so we only have a binary
> state. I'd much rather the default be NX (no bit set) instead of making
> every future (safe) user of memfd have to specify MFD_NOEXEC.
>
> It's also easier on a filtering side to say "disallow memfd_create with
> MFD_EXEC", but how do we deal with the older software?
>
> If the default perms of memfd_create()'s exec bit is controlled by a
> sysctl and the sysctl is set to "leave it executable", how does a user
> create an NX memfd? (i.e. setting MFD_EXEC means "exec" and not setting
> it means "exec" also.) Are two bits needed? Seems wasteful.
> MFD_I_KNOW_HOW_TO_SET_EXEC | MFD_EXEC, etc...
>
Great points,  with those questions and usages in mind, I m thinking below:

1> memfd_create:
Add two flags:
#define MFD_EXEC                      0x0008
#define MFD_NOEXEC _SEAL    0x0010
This lets application to set executable bit explicitly.
(If application set both, it will be rejected)

2> For old application that doesn't set executable bit:
Add a pid name-spaced sysctl.kernel.pid_mfd_noexec, with:
value = 0: Default_EXEC
     Honor MFD_EXEC and MFD_NOEXEC_SEAL
     When none is set, will fall back to original behavior (EXEC)
value = 1: Default_NOEXEC_SEAL
      Honor MFD_EXEC and MFD_NOEXEC_SEAL
      When none is set, will default to MFD_NOEXEC_SEAL

3> Add a pid name-spaced sysctl kernel.pid_mfd_noexec_enforced: with:
value = 0: default, not enforced.
value = 1: enforce NOEXEC_SEAL (overwrite everything)

Then we can use and secure memfd at host and container as below:
At host level:
Case A> In secure by default system where doesn't allow executable memfd:
sysctl.kernel.pid_mfd_noexec_enforced = 1
LSM to block creation of executable memfd  system wide.
This requires a new hook: secure_memfd_create

Case B> In system that need both (runc case),
use sysctl kernel.pid_mfd_noexec = 0/1 during converting application to new API.
SELINUX or landlock to sandbox the process.(requires work).

At container level:
It would be nice for container to control creation of executable memfd too.
This is through  sysctl kernel.pid_mfd_noexec_enforced
This lets runc to create two type of contains:
one with ability to create executable memfd, one without.

The sysctl.kernel.pid_mfd_noexec sets the default value, it is helpful
during  applications are being migrated to set the executable bit.
 Alternatively, we can have a new syscall: memfd_create2, where it is mandatary
to set executable bit (or default to NOEXEC_SEAL),  then
sysctl.kernel.pid_mfd_noexec
is not needed.

> For F_SEAL_EXEC, it seems this should imply F_SEAL_WRITE if forced
> executable to avoid WX mappings (i.e. provide W^X from the start).
>
Yes. I agree.

Thanks!
Best regards,
Jeff Xu


> -Kees
>
> [1] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
> [2] https://lwn.net/Articles/781013/
>
> --
> Kees Cook
