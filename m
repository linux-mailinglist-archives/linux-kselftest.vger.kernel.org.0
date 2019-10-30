Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E18EA499
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 21:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJ3UMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 16:12:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42115 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJ3UMV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 16:12:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id m4so4176123qke.9
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2019 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GCjoby9r+s+PmV1FeOt/O5VIxJ79kYZdBdHtT5yosc=;
        b=hs4u13vDJKlNQDZKcbNVyPbIOUO4++rTthQnsQzTyBa9XWD0PqFcDlID67q4NaHOBr
         IHr6T6nX966JNzI2EeAQe8lLYg4I7H/NQsjt21lvxwCAt877j6p8citQow+UzZ2zrgyq
         oAyDlNvuSdlMkxFLCJTc07wUsNKAFK1j52tckNVnHzCvkhlpasTLzWVn++Srb25T1rcv
         w862U9tnBYoWP+h71e1Pj7OqujSeAW4Viig8S+wYMQUlS6wkq8M+fN9V4LmNvUXdq54P
         o+arqYUKSHdF3PCMnfWptbn2gLDX1+yJ/5QCCvsNT520P7REY8HVYZ8Wn6QqMtsqQtWH
         Ap2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GCjoby9r+s+PmV1FeOt/O5VIxJ79kYZdBdHtT5yosc=;
        b=hUKjJRTk0bTfgiR5paOu8AJoZcnEdwFeKgmOQSvKNbIymi6g5T85/+7Vko6exoUkJh
         kNx4rOgTuWRWs8+kON0Whm1BRvcOjw3QQgOd96KuGPTN1TSbOQLlqJnCcVQYL7zRUWwx
         sRrbYVA4gscj6UxCKbtYft/cVKkn8NBzkhAC6kG8U1TjhCCFHNi1mFwwr7e5t4mW2dQp
         ZhDxV27lzxD8yC0d7oxKFhab2myFzCqr69XzehQQilzkjrK+/abFK9aGjWrhrNyLNZfN
         y6T7RZq64xcmD0izXPAMVNDwJzF+xDgBTQKar6sQ512sKsrN4Lq7/vEHbdQNPGXCV0n+
         cMHw==
X-Gm-Message-State: APjAAAX5mo4CPHVappOLPAS7BQbW98DByYfpAXfRrw5ovAokjkyfM8Dw
        RwP288Vv4A8TfOa5I2L332gEdTfCqNHHljLcNQZ7
X-Google-Smtp-Source: APXvYqx7bti37f9+2uWLgnwmX5xe5F/Bf0v/KqsYC9Kv/tvuxGMoYEb+NTCbuNpu7R2tix93zwP51PF2WTt7jtDuQnY=
X-Received: by 2002:a37:bb06:: with SMTP id l6mr1807038qkf.289.1572466340480;
 Wed, 30 Oct 2019 13:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook>
In-Reply-To: <201910301205.74EC2A226D@keescook>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 30 Oct 2019 13:11:44 -0700
Message-ID: <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, David Gow <davidgow@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Why can't unit tests live with the code they're testing? They're already
> logically tied together; what's the harm there? This needn't be the case
> for ALL tests, etc. The test driver could still live externally. The
> test in the other .c would just have exported functions... ?
>
Curiously enough, this approach has been adopted by D 2.0 where unittests are
members of the class under test:  https://digitalmars.com/d/2.0/unittest.html
but such approach is not mainstream.
I personally like the idea of testing the lowest level bits in isolation even if
they are not a part of any interface. I think that specifying the
interface using
unit tests and ensuring implementation correctness are complementary but
I haven't had much luck arguing this with our esteemed colleagues.
