Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E542F7991AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 23:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbjIHV4M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjIHV4L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 17:56:11 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B29E46
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 14:56:05 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44d5ac10c41so1041395137.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694210164; x=1694814964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t21swsOyH2YblKosQFufOxa9wXHdCF/HAys5VxqFSU=;
        b=dCZ/W/TVTMsK/8Zz4BBV2Nh0uoWC3befGRJ3/ukWJr8AMTDaUx7r8lrZ2/xQdW9aWS
         kLXPlmpxmiJHKACm6fgoaUFk0O8zi/0HlEGKtMPe7FfbqiZg8LX8GpM5YkHrVrWlQMXK
         b+0+sXBN4E9954qNlrwPCwX87UAnA9Ntf4LkJ72rl/04DJBsT/P9tZlhiDfChMvPjjex
         3QFNjAkzi6qUWsat1b1hTjOY+IC/llo4s6RNeBDc6Rg6jcWcETb1i0w0h2JQVtv1lDtC
         M2G5tN7gCWXO63X4AzvlB9CptvykFm+l+NkQVd14e8TwJKQOWlOQ02/HME/oaQO4YI6z
         MSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694210164; x=1694814964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+t21swsOyH2YblKosQFufOxa9wXHdCF/HAys5VxqFSU=;
        b=e//FcU1BIuoyUBC4wPXGToGvrCtH+gbfcOhZEIinX7QhnxH8nJvD3DY3z4YArdk7HJ
         NyF4zMg/8QYdJTpFyRlB/wntIbjKXKdW5qEdV34VD+VbevM+u1ABmzWPuhIu+djjm1DZ
         Gjgr9eXzvCiV8qpgtl0enMR9JwzgMTTuvApS8L/3gVvOq864s0hpH7xzzNh05v75J3WT
         4Q+iSdnkilCHbt/7n7UlN/NshV56qF61KIKzMehUK3ongQq6omVwNRzbwHUtPJannyza
         LBcKLBfcPwjgUM9dO+gWClh238Y+4E/tOnDvj3krqXR8qKn3RhRt+vwlB+5xbxK52Gun
         AiSA==
X-Gm-Message-State: AOJu0YxUMOqZG7Q6Mf/d6pj89AY0iAuubZX2F5pCPCxZGyqW9sbsM/4O
        cYv7aTFvdU8GtleRMubWvlyGtPny/rRbpGPskaVcFQ==
X-Google-Smtp-Source: AGHT+IFkquQZzfJEqi3aegfL32v0MUP4COi0KsBHXJhNEJqPgvoL5VJcvuAC408MwYd6jYtnlMbhsJ/oBBfA1JrwqlA=
X-Received: by 2002:a05:6102:3004:b0:44e:99a2:a51 with SMTP id
 s4-20020a056102300400b0044e99a20a51mr3887876vsa.30.1694210164298; Fri, 08 Sep
 2023 14:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230908175738.41895-1-mclapinski@google.com> <87tts4z9nu.fsf@meer.lwn.net>
In-Reply-To: <87tts4z9nu.fsf@meer.lwn.net>
From:   =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date:   Fri, 8 Sep 2023 23:55:52 +0200
Message-ID: <CAAi7L5f1f3gHGr_8cCv2jW2Q5pjL9bpDD_4zrpXjXkoRmu95fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Yi Liu <yi.l.liu@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Steve French <stfrench@microsoft.com>,
        Simon Ser <contact@emersion.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 8, 2023 at 10:34=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Michal Clapinski <mclapinski@google.com> writes:
>
> > This change introduces a way to check if an fd points to a memfd's
> > original open fd (the one created by memfd_create).
> >
> > We encountered an issue with migrating memfds in CRIU (checkpoint
> > restore in userspace - it migrates running processes between
> > machines). Imagine a scenario:
> > 1. Create a memfd. By default it's open with O_RDWR and yet one can
> > exec() to it (unlike with regular files, where one would get ETXTBSY).
> > 2. Reopen that memfd with O_RDWR via /proc/self/fd/<fd>.
> >
> > Now those 2 fds are indistinguishable from userspace. You can't exec()
> > to either of them (since the reopen incremented inode->i_writecount)
> > and their /proc/self/fdinfo/ are exactly the same. Unfortunately they
> > are not the same. If you close the second one, the first one becomes
> > exec()able again. If you close the first one, the other doesn't become
> > exec()able. Therefore during migration it does matter which is recreate=
d
> > first and which is reopened but there is no way for CRIU to tell which
> > was first.
>
> So please bear with me...I'll confess that I don't fully understand the
> situation here, so this is probably a dumb question.
>
> It seems like you are adding this "original open" test as a way of
> working around a quirk with the behavior of subsequent opens.  I don't
> *think* that this is part of the intended, documented behavior of
> memfds, it's just something that happens.  You're exposing an artifact
> of the current implementation.

I don't know if the exec()ability of the original memfd was intended,
let alone the non-exec()ability of subsequent opens. But otherwise
yes.

> Given that the two file descriptors are otherwise indistinguishable,
> might a better fix be to make them indistinguishable in this regard as
> well?  Is there a good reason why the second fd doesn't become
> exec()able in this scenario and, if not, perhaps that behavior could be
> changed instead?

It probably could be changed, yes. But I'm worried that would be
broadening the bug that is the exec()ability of memfds. AFAIK no other
fd that is opened as writable can be exec()ed. If maintainers would
prefer this, I could do this.
