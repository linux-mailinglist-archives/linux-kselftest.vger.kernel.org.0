Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2200D58CCF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiHHRqh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Aug 2022 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbiHHRqP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Aug 2022 13:46:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35DF21C
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 10:46:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 17so9171523plj.10
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Aug 2022 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WT0gvMZYO/av++KMudc6Dk4HO66L8Urniksc21Z/06c=;
        b=HqrXaad1rdwTwFVLqtIf2gsOjqqHSCtra1Op2I+Ip1+B6FPHxPEzwTFH7bXQwHcgET
         670AgcycqxHJDRROfj5zyTe5NwQtZFhFxYR5FYTupki7enfM8YtWwCxJCV7/nQfmy4cJ
         IxrZhtFvvcJ66LqIrfUAMfkK7CmlRw5Rv0KXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WT0gvMZYO/av++KMudc6Dk4HO66L8Urniksc21Z/06c=;
        b=1D1/0tpX7YphFMM6yOQmdKNzsDpystvnODFa6zWWYNuUnkyria6whmLIwZaUnTmOSc
         m/MT40KQkd5MCyURsomniRlMxodkUfxylGzwz8LxXX/MvcrOV4mEOI3h2YMqRB0MNT6Q
         6kDLs2NDdG/SKtVVub0s/NA52ZnuZjto2SxFZv66AKhrTvsLxhwk91AgmIFMROggZ/BJ
         fnWNucDpP94aQ5yadaYC2VcYQS074udwzg49uPTtJ4a8slF+toQn+nIfquP6Z+738aIT
         wu/pygv3v+91ijXiZ3LYOuXllywL7pw696YnN3McHggIQzeu4ieCroBH+Hha7kLR/mk1
         2QzQ==
X-Gm-Message-State: ACgBeo0ZBC+/BJdiWYjTdTBHoc1zFGC5GY6Ti2RcLe8MfMe+8zr/+YQp
        PWh20GG6B6Fkn7k84r5q9aQCfg==
X-Google-Smtp-Source: AA6agR55vq+x0LDDr8mxEbc8OnrHWhZtkoyD+AcW+LYABM9JFgkRs4j4RTu6F017ikC4JmT33xQogA==
X-Received: by 2002:a17:90b:3c4c:b0:1f3:3d62:39e2 with SMTP id pm12-20020a17090b3c4c00b001f33d6239e2mr29906557pjb.88.1659980770387;
        Mon, 08 Aug 2022 10:46:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090ad98f00b001f200eabc65sm8394142pjv.41.2022.08.08.10.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:46:09 -0700 (PDT)
Date:   Mon, 8 Aug 2022 10:46:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@google.com
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>, linux-hardening@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>, dev@opencontainers.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] mm/memfd: MFD_NOEXEC for memfd_create
Message-ID: <202208081018.9C782F184C@keescook>
References: <20220805222126.142525-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805222126.142525-1-jeffxu@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 05, 2022 at 10:21:21PM +0000, jeffxu@google.com wrote:
> This v2 series MFD_NOEXEC, this series includes:
> 1> address comments in V1
> 2> add sysctl (vm.mfd_noexec) to change the default file permissions
>     of memfd_create to be non-executable.
> 
> Below are cover-level for v1:
> 
> The default file permissions on a memfd include execute bits, which
> means that such a memfd can be filled with a executable and passed to
> the exec() family of functions. This is undesirable on systems where all
> code is verified and all filesystems are intended to be mounted noexec,
> since an attacker may be able to use a memfd to load unverified code and
> execute it.

I would absolutely like to see some kind of protection here. However,
I'd like a more specific threat model. What are the cases where the X
bit has been abused (e.g.[1])? What are the cases where the X bit is
needed (e.g.[2])? With those in mind, it should be possible to draw
a clear line between the two cases. (e.g. we need to avoid a confused
deputy attack where an "unprivileged" user can pass an executable memfd
to a "privileged" user. How those privileges are defined may matter a
lot based on how memfds are being used. For example, can runc's use of
executable memfds be distinguished from an attacker's?)

> Additionally, execution via memfd is a common way to avoid scrutiny for
> malicious code, since it allows execution of a program without a file
> ever appearing on disk. This attack vector is not totally mitigated with
> this new flag, since the default memfd file permissions must remain
> executable to avoid breaking existing legitimate uses, but it should be
> possible to use other security mechanisms to prevent memfd_create calls
> without MFD_NOEXEC on systems where it is known that executable memfds
> are not necessary.

This reminds me of dealing with non-executable stacks. There ended up
being three states:

- requested to be executable (PT_GNU_STACK X)
- requested to be non-executable (PT_GNU_STACK NX)
- undefined (no PT_GNU_STACK)

The first two are clearly defined, but the third needed a lot of special
handling. For a "safe by default" world, the third should be "NX", but
old stuff depended on it being "X".

Here, we have a bit being present or not, so we only have a binary
state. I'd much rather the default be NX (no bit set) instead of making
every future (safe) user of memfd have to specify MFD_NOEXEC.

It's also easier on a filtering side to say "disallow memfd_create with
MFD_EXEC", but how do we deal with the older software?

If the default perms of memfd_create()'s exec bit is controlled by a
sysctl and the sysctl is set to "leave it executable", how does a user
create an NX memfd? (i.e. setting MFD_EXEC means "exec" and not setting
it means "exec" also.) Are two bits needed? Seems wasteful.
MFD_I_KNOW_HOW_TO_SET_EXEC | MFD_EXEC, etc...

For F_SEAL_EXEC, it seems this should imply F_SEAL_WRITE if forced
executable to avoid WX mappings (i.e. provide W^X from the start).

-Kees

[1] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
[2] https://lwn.net/Articles/781013/

-- 
Kees Cook
