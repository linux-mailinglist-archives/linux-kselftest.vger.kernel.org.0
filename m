Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542F5109ECB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 14:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKZNPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 08:15:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35692 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKZNPS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 08:15:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id 23so14067882otf.2;
        Tue, 26 Nov 2019 05:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOQdMjYPdVy6RkGpAIiWBTaVHjvFHI5z40O+OjylWNs=;
        b=Y7SBgiosMNbIocrTGKprvCSws+0ObYjHUmi9MPGHi6rZX/KyiorLStVwUf5dtEzlTI
         p+NwdZ48eEPygwn8gu2Wt0LOXDqXfT9QyZzPE6Y0e9Ke3c5qpQLEd4zJW3Au9fIJXxTs
         JO5BF4Q+nINAZkwrisuLH1JgyvHi7eS71eqeCg60DZJCbq8cDv8WvRuj/iwjkQgWhYNj
         9BB8S7QRvdO3d5U4OtcxoeNoNQwqD2IA8dST1rnMNx5GQPlwNKujD3jCIkeEs4Ty3sol
         yqzl+S+LV+QuLnEhrnY9pdLQ8LJze9wNmvtedJ9QaHtkxboraU2r1kLCaX974/Mr6B+v
         V7aQ==
X-Gm-Message-State: APjAAAWyH87rCgrRc/y2y8FkegYqVEzCU9DYqDc1CSWbUyv9RW/enPYy
        1HtE1rqh0qScKg3d5FCIwXFRgwLDomrbFEgU4L8=
X-Google-Smtp-Source: APXvYqz82YvsMLNHpNEPX4+Kqba7XbryaMpz18cKmGgzjGviKvra31QS1PI2HBdwdHYm5Us9bXfm9nzi6w+g6zzmjdw=
X-Received: by 2002:a9d:19ed:: with SMTP id k100mr1589639otk.297.1574774116545;
 Tue, 26 Nov 2019 05:15:16 -0800 (PST)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-1cbeab1b242d16fdb22dc3dab6a7d6afe746ae6d@kernel.org>
In-Reply-To: <git-mailbomb-linux-master-1cbeab1b242d16fdb22dc3dab6a7d6afe746ae6d@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Nov 2019 14:15:04 +0100
Message-ID: <CAMuHMdUoOWugmyAA3-dP=AAMYwLy7KPKpGzXwxRn_yTJugM+Ww@mail.gmail.com>
Subject: Re: ext4: add kunit test for decoding extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Lurii,

On Tue, Nov 26, 2019 at 3:12 AM Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Commit:     1cbeab1b242d16fdb22dc3dab6a7d6afe746ae6d
> Parent:     d460623c5fa126dc51bb2571dd7714ca75b0116c
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/1cbeab1b242d16fdb22dc3dab6a7d6afe746ae6d
> Author:     Iurii Zaikin <yzaikin@google.com>
> AuthorDate: Thu Oct 17 15:12:33 2019 -0700
> Committer:  Shuah Khan <skhan@linuxfoundation.org>
> CommitDate: Wed Oct 23 10:28:23 2019 -0600
>
>     ext4: add kunit test for decoding extended timestamps
>
>     KUnit tests for decoding extended 64 bit timestamps that verify the
>     seconds part of [a/c/m] timestamps in ext4 inode structs are decoded
>     correctly.
>
>     Test data is derived from the table in the Inode Timestamps section of
>     Documentation/filesystems/ext4/inodes.rst.
>
>     KUnit tests run during boot and output the results to the debug log
>     in TAP format (http://testanything.org/). Only useful for kernel devs
>     running KUnit test harness and are not for inclusion into a production
>     build.
>
>     Signed-off-by: Iurii Zaikin <yzaikin@google.com>
>     Reviewed-by: Theodore Ts'o <tytso@mit.edu>
>     Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>     Tested-by: Brendan Higgins <brendanhiggins@google.com>
>     Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

While this test succeeds on arm64, it fails on m68k and arm32 (presumably
all 32-bit platforms?):

# Subtest: ext4_inode_test
1..1
# inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/ext4/inode-test.c:250
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == -2147483648
timestamp.tv_sec == 2147483648
1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits: msb:1
lower_bound:1 extra_bits: 0
# inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/ext4/inode-test.c:250
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == 2147483648
timestamp.tv_sec == 6442450944
2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on:
msb:1 lower_bound:1 extra_bits: 1
# inode_test_xtimestamp_decoding: EXPECTATION FAILED at fs/ext4/inode-test.c:250
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == 6442450944
timestamp.tv_sec == 10737418240
2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on:
msb:1 lower_bound:1 extra_bits: 2
not ok 1 - inode_test_xtimestamp_decoding
not ok 1 - ext4_inode_test

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
