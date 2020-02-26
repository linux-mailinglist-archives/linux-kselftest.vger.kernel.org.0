Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB317076A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 19:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBZSOq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 13:14:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41335 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBZSOq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 13:14:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so110466ljc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2020 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjVgEuW47C2Xrvk9SsDOlUklU0qxH2P/gutncBnIpZo=;
        b=OAWY1TMlyTY31yFaVWeJv1zsgKX7UFGsEx4qNdEfDU9zGJW12QpOe9TXsqYw3G1mVO
         vGpS9h09icLXW7ngtscDtxwnWCVgJALfoKKOGNm9BvBsmIspjLg0snQe4dHiUvDBOP14
         vbI0lrFc0btaa9cby9RqUnLyGsniu1i5ZsBB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjVgEuW47C2Xrvk9SsDOlUklU0qxH2P/gutncBnIpZo=;
        b=a/c6Fhn4XcT4rUbK4gwy0C0KdMd878VirBFfI4WL+PbyWQAo2AFVDpDg3fSVRtnwFi
         MbNmH0U6YWrGT3diQX5/PnzZwVLFaHfX9Ctts+WeEZNlwXyOFThS0UqFyhAj8mEbjM4v
         qVK9sUpbJLy8+IQgr2DOqH/O5RvA0Z4YvWZk2VjjE/O1DCSGitNg89k7ij2peJszeo6O
         wHFMKPvfVKSSgSqSNOfRvAR6zQRWlA3dxj554dJwKThgCnzCsig78nADfOMumdP8b22O
         w7AljvgvunmVif05nUJUaSNRDQvDUi8ZKzGz3y306pxYcwsWWWcUMVJD5BC836ekBoo0
         Va+w==
X-Gm-Message-State: ANhLgQ1omhAANxTTeKwqeo3prF6aoR85TNo/iy0S9xzY8JrIAGHfkCx1
        Iq+19KfCmdvcedgB4ahAKqCcqD1SobE=
X-Google-Smtp-Source: ADFU+vvsKA7TwA9go+SpGTFmgQ5gYnjCp0nm7yQnByvlGOKxk6vSApV7+oJD49wfDF0f5k5BBMTiNA==
X-Received: by 2002:a2e:9284:: with SMTP id d4mr134724ljh.226.1582740883395;
        Wed, 26 Feb 2020 10:14:43 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f26sm1400099lfk.84.2020.02.26.10.14.42
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 10:14:42 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 7so18445lfz.11
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2020 10:14:42 -0800 (PST)
X-Received: by 2002:ac2:490e:: with SMTP id n14mr3230490lfi.142.1582740881995;
 Wed, 26 Feb 2020 10:14:41 -0800 (PST)
MIME-Version: 1.0
References: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
In-Reply-To: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Feb 2020 10:14:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGqq1XyJgYr+Mrx7Po2d2JVRvroSigxzQ+C6jCcU7uqw@mail.gmail.com>
Message-ID: <CAHk-=whGqq1XyJgYr+Mrx7Po2d2JVRvroSigxzQ+C6jCcU7uqw@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.6-rc4
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 25, 2020 at 3:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> - Declutter git status fix from Christophe Leroy

I've pulled this, but just for future reference (and hoping for a
future cleanup patch): instead of putting things in the global
.gitignore file, do it in the relevant local one.

So you could just have added

  *.sh
  !run.sh

in 'tools/testing/selftests/lkdtm/.gitignore' instead of doing

  # Generated lkdtm tests
  /tools/testing/selftests/lkdtm/*.sh
  !/tools/testing/selftests/lkdtm/run.sh

in the top-level one.

That keeps things much better separated. It also incidentally means
that if a directory gets renamed, the gitignore file just "magically"
continues to work (if you rename the actual files themselves that are
named in gitignore, then that's obviously a different thing).

If you put it in the leaf directory, it also means that you don't need
the '/' at the beginning, because the local gitignore entries will
only affect that subdirectory (and any subdirectories under it).

So please put only "global" gitignore patterns in the top-level gitignore file.

              Linus
