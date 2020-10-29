Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE57A29E029
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 02:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgJ2BIv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 21:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731984AbgJ2BGR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 21:06:17 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88029C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 18:06:16 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r127so1147381lff.12
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bUbdsznkyssxZQUaGiYFef8NyYzvzo9ihU0AaJ53g/g=;
        b=BDrxX4f+Wgvz7T2nQLENN+0irWwn/eNDmAKCTDCqH7wbKE23tfFJlUZmPAsdIVT6av
         1Or1eDLwD4Ua1/VtLB9aLqgums1ThYkU6EoVz66waVy839CCdRQ4/jA5GhhAy7zJx4fP
         lIOBOse97g1uBe2mm7vsNQdWsRKzB5bSgNBV7JJSa9s1KuspQmNoz02kO+9neBnMrIfH
         9p9f4n15YsHkpW5CrApshNR4MlYwwrAZ2bcyzIfJFWhzAWKQIqVwpqwuGuD0xVKFI8YG
         73ZcamzLaX7g3KVQHvBjBMxnmz2K2Y3WZoOLFQ4cjIZQPuTwsIYEU7TMMrzclXdPmFDT
         MJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bUbdsznkyssxZQUaGiYFef8NyYzvzo9ihU0AaJ53g/g=;
        b=quIEWDCdtx/m5hf2yXTkMG8meLFkpDjwm2T04EL9+O1j+sRVceUXvJynN2i00wm07Z
         1NhqCZa4VfnvxXL6fc/P6TBgLrHwcZwpqrRqdC7PNkpo9/m9oSlDs+m2wP72oM8h5TGV
         Pb6kXbeVYyBJNzz+Sj5yApXjQ5putb81P0Sf/zrhbG6NOWVYQ7m6lc1nnJ29rE9ZjwR4
         MnGft0cW0fJlOcC0TxnXnm7Unfyj89n7LxpDqgjWnEfS1CTWHhDJcrj931ZDZdvHt8eM
         n29Y10AIXGGjPnoJG7rgu24Wu30b66eo02omvlLhQQWfIWFd/xH5doSEc2X3d41eJSBx
         TXSg==
X-Gm-Message-State: AOAM530+Ssqvf59UMBcZswLPltxHPWqlth8ak8eO/y0+bwwkiKEHcXej
        tDi8ohf5e4O75yCNyTXD0rvki33YSJ0wh4E+NRK8pw==
X-Google-Smtp-Source: ABdhPJzcgEeCZDlwnUhahSeOHzAbFOzhL6qDHJsbmuNSbxi7XgpEx/FS/YazDdtI2Qw49nUhEoyWwL1tVaMHgN9tVZA=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr662361lfb.576.1603933574802;
 Wed, 28 Oct 2020 18:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-2-mic@digikod.net>
In-Reply-To: <20201027200358.557003-2-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:05:47 +0100
Message-ID: <CAG48ez3CKa12SFHjVUPnYzJm2E7OBWnuh3JzVMrsvqdcMS1A8A@mail.gmail.com>
Subject: Re: [PATCH v22 01/12] landlock: Add object management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> A Landlock object enables to identify a kernel object (e.g. an inode).
> A Landlock rule is a set of access rights allowed on an object.  Rules
> are grouped in rulesets that may be tied to a set of processes (i.e.
> subjects) to enforce a scoped access-control (i.e. a domain).
>
> Because Landlock's goal is to empower any process (especially
> unprivileged ones) to sandbox themselves, we cannot rely on a
> system-wide object identification such as file extended attributes.
> Indeed, we need innocuous, composable and modular access-controls.
>
> The main challenge with these constraints is to identify kernel objects
> while this identification is useful (i.e. when a security policy makes
> use of this object).  But this identification data should be freed once
> no policy is using it.  This ephemeral tagging should not and may not be
> written in the filesystem.  We then need to manage the lifetime of a
> rule according to the lifetime of its objects.  To avoid a global lock,
> this implementation make use of RCU and counters to safely reference
> objects.
>
> A following commit uses this generic object management for inodes.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Reviewed-by: Jann Horn <jannh@google.com>

except for some minor nits:

[...]
> diff --git a/security/landlock/object.c b/security/landlock/object.c
[...]
> +void landlock_put_object(struct landlock_object *const object)
> +{
> +       /*
> +        * The call to @object->underops->release(object) might sleep e.g=
.,

s/ e.g.,/, e.g./

> +        * because of iput().
> +        */
> +       might_sleep();
> +       if (!object)
> +               return;
[...]
> +}
> diff --git a/security/landlock/object.h b/security/landlock/object.h
[...]
> +struct landlock_object {
> +       /**
> +        * @usage: This counter is used to tie an object to the rules mat=
ching
> +        * it or to keep it alive while adding a new rule.  If this count=
er
> +        * reaches zero, this struct must not be modified, but this count=
er can
> +        * still be read from within an RCU read-side critical section.  =
When
> +        * adding a new rule to an object with a usage counter of zero, w=
e must
> +        * wait until the pointer to this object is set to NULL (or recyc=
led).
> +        */
> +       refcount_t usage;
> +       /**
> +        * @lock: Guards against concurrent modifications.  This lock mus=
t be

s/must be/must be held/ ?

> +        * from the time @usage drops to zero until any weak references f=
rom
> +        * @underobj to this object have been cleaned up.
> +        *
> +        * Lock ordering: inode->i_lock nests inside this.
> +        */
> +       spinlock_t lock;
[...]
> +};
> +
> +struct landlock_object *landlock_create_object(
> +               const struct landlock_object_underops *const underops,
> +               void *const underojb);

nit: "underobj"
