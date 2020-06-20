Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2348C20261D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFTTOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 15:14:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36125 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgFTTOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 15:14:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id c21so7419356lfb.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Jun 2020 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLT5NQm5Gdiao5LFnbXicx4H9nK0dIz0m6pUUgA2bUM=;
        b=QewcG8XnW47c4csRZDroyH9m6W1rqSNfm8JCmtq6PTU7UzF/6GQR48pqd+++JAq2d5
         7fdIZvuI42lUbBQW7UAHvgnGzbNn5laVHOPdLWnSg+3S9kR8VckTTkuLHUxVECpFnsZQ
         dpEqU5rfpJ1MkZWAedQDJskUfNU5BX1E6lvZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLT5NQm5Gdiao5LFnbXicx4H9nK0dIz0m6pUUgA2bUM=;
        b=EEsTnyWV0VqS/9fPvbWY7Bfymir31lYoxbSNwRmt9W8ohToCTg5EG8QOyBlYfM7Vxx
         WkSlqYj/j6VhfGXngTjeK0UC+fo74QtSw54h4CDBSuZZv3h3M/RvkPr5CVTVRLiKpHU6
         X2+1A1VDugw2y5Y7hz24BwMg+s5kcuIOYM+hCJ7zAUiQlZZyy9TpJY8vGSt60IqF8kI0
         IJXlyQZrq4iII4ru9RWUqXTpqBWVghKMeCPirmVe+Nigo6KyrrpuZCodjBDSKwJlOCB9
         yUR32P6eMAP1r3WNgxzWMtbo9zxYthwyy6aFAE7DFlRFJQNdZdyKdMBj+XKTCcejWHnC
         OI8Q==
X-Gm-Message-State: AOAM533P4luPFBhxkjLspj2ySA3QXoPgy0eD1j3GHJ6Ty4MtZUn4YUmi
        ffOqUqEHoHU1vsSrCnbXeljpgMTpPs8=
X-Google-Smtp-Source: ABdhPJxlFdL3MYCGphTDmDsaNx09c8qFcPn99j1Y3XhB8gWohazjvGPHMoysYjuTOMjKZmSOVQZ/rw==
X-Received: by 2002:a19:a8c:: with SMTP id 134mr3677469lfk.128.1592680412631;
        Sat, 20 Jun 2020 12:13:32 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l5sm2601729lfp.9.2020.06.20.12.13.31
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 12:13:31 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id i3so15124528ljg.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Jun 2020 12:13:31 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr4462227ljn.70.1592680410966;
 Sat, 20 Jun 2020 12:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <90024a5c-ea67-2529-e330-3a4f0bef6596@linuxfoundation.org>
In-Reply-To: <90024a5c-ea67-2529-e330-3a4f0bef6596@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 12:13:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
Message-ID: <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
Subject: Re: [GIT PULL] Kunit update for Linux 5.8-rc2
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 19, 2020 at 10:28 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please pull the Kunit update for Linux 5.8-rc12.

This doesn't sound like a fix for after the merge window. Explain.

              Linus
