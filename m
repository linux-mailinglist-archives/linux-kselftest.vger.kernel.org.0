Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3624310AB2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfK0HaF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 02:30:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40233 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfK0HaF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 02:30:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id d22so19208782oic.7;
        Tue, 26 Nov 2019 23:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daZccRQyjaNYKqLjjSER4+Xh9PUwo1L6dwl0GD49208=;
        b=DV5meT0BzlEoy62sGQFOJMuaHoRGoiLDJpfMzC3g0mXxjvhvXykDZGJKG/dALjv4Yn
         igkBn822y61oaFVUtxe4aXgmz6UguQpfxZhoRryNklXZXTcy/uIf3YALlC1hBlArJHT2
         8SI3aMZr5bnfnYNzJIWiy7k72f5vuw0mQUMMTR+wMm051HyyjjPVaN268DhzVlulXtuS
         MvqRgMqGyLmErmxsVJgrqVatMyxytQOkTt05Y4CErdUuqjqa7BxrVzpg/doKruxQaZbp
         7ZVx6I2lSqiaP5LoOLEhsBxIk1cB2RjmYuiedd+B1Z9BUC/IwfCH5oXD6qrZ4J/OlWm8
         FJwA==
X-Gm-Message-State: APjAAAVJ+H8lDG1DjIfea/FljBzW5k+q7GDZ1Ai78APOrFfHfO11el4e
        9MB+C1dGdvJDwVORBWpxTIwEDHhA9MfI4l4uNDc=
X-Google-Smtp-Source: APXvYqwbXgXFsqZPJFcC/oWnV/2IX1M8Qt4Qlx1Hykka609E7bOab82b/zM0l980CugWhvzRZ+7ZGq7OAOjmRrmhmfA=
X-Received: by 2002:a05:6808:b17:: with SMTP id s23mr2947275oij.102.1574839804401;
 Tue, 26 Nov 2019 23:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20191127003715.108479-1-yzaikin@google.com>
In-Reply-To: <20191127003715.108479-1-yzaikin@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Nov 2019 08:29:53 +0100
Message-ID: <CAMuHMdUVzwtZG1C_nw=xpRfwFOZ4GnOcmoN+b30_LkXzN29PKw@mail.gmail.com>
Subject: Re: [PATCH] fs/ext4/inode-test: Fix inode test on 32 bit platforms.
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 1:37 AM Iurii Zaikin <yzaikin@google.com> wrote:
> Fixes the issue caused by the fact that in C in the expression
> of the form -1234L only 1234L is the actual literal, the unary
> minus is an operation applied to the literal. Which means that
> to express the lower bound for the type one has to negate the
> upper bound and subtract 1.
> Original error:
> Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
> test_data[i].expected.tv_sec == -2147483648
> timestamp.tv_sec == 2147483648
> 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits: msb:1
> lower_bound:1 extra_bits: 0
> Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
> test_data[i].expected.tv_sec == 2147483648
> timestamp.tv_sec == 6442450944
> 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on:
> msb:1 lower_bound:1 extra_bits: 1
> Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
> test_data[i].expected.tv_sec == 6442450944
> timestamp.tv_sec == 10737418240
> 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on:
> msb:1 lower_bound:1 extra_bits: 2
> not ok 1 - inode_test_xtimestamp_decoding
> not ok 1 - ext4_inode_test
>
> Reported-by: Geert Uytterhoeven geert@linux-m68k.org
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>

Thanks, test succeeds (on m68k, arm32, and arm64)!

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
