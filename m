Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3292AA273
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 06:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgKGFAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Nov 2020 00:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgKGFAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Nov 2020 00:00:32 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CDC0613CF
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 21:00:30 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p15so3733406ljj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 21:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voEsZPkyjZD18rzLtdDPpUVqOWAqR2u8yHFoISL5tWA=;
        b=ozEJnOM2IixHrnCPEtGb8FlqnzWcNz+owQfR7J4Eue5meJU/pZItrdTH+v0KHF0cFo
         3lLpgXRPOSHF6gUusRw2FxmWULcNJa0AV7m/aCcn8kIQWrxpaenHvu4ZfGHc3ZiZiZBW
         WVFQB3tG8c63Lifd0NAKzG5T8ez3LWkaxc26yiUmwNA314ZHSabqU+PFVT0gGvfiPp6W
         TZYs2MYDYb1AFpUxW2W+wjZVFeZkYueQs6SaJyl5/oe0ESlReMhwk+xbeJ3Y9Y4s1GXs
         07Fe+pa4L7AXyhtkqeXfpjSsJGpKXdPXYPYdYX2eifPUuJxWYcbqFN0iESHwomlTY+gt
         bJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voEsZPkyjZD18rzLtdDPpUVqOWAqR2u8yHFoISL5tWA=;
        b=Zfawwh1Y80TtBwBewFsNe1s2N2vgWCV+FlYGSHQQ92UkfTj1PupD4EnVzai4lsREba
         kuDUlF1MNElES8KpEh++QH/T8F5e2L7sn1eVnQcHalnvx4SgH6shVA19P0Y+KOgjnGT6
         zgzYoK55luH9+72sKG6diWmDN/mefolq4WKymxqaHAjGIDtS/GlfmvNG6cfEk/kbGHFK
         bKKxuteWOMKBwgNxIAoW4pZa9SnkEzdMQNK+cn4oPbARAgiP0GDAgDewatVpIpg6URqp
         kRI/y3Z/p8vcLY6/wbNEC1yPuSC5UQJALRk4U6sWFY+MR168FseDTLqfMLP/GzScK5Yz
         H7hw==
X-Gm-Message-State: AOAM5321r8HTL2V0KkR+bgWRJ59XFm3sTlznPazw/oZ4tEQjI9g5OBWI
        DB78CFWE1YnOyP9LLK+01jKOr7roKS+C+xb6/AsH0w==
X-Google-Smtp-Source: ABdhPJxRL+E/FG0jMGqNmEVkiK0JKDx1AmCZa7th6GCMdfj5xVmIDB1v0qf0mRD8QdCKNL5aBnnNUOaJn4UczaqLpNs=
X-Received: by 2002:a2e:9a89:: with SMTP id p9mr2070693lji.363.1604725228766;
 Fri, 06 Nov 2020 21:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <20201106192249.51574-1-98.arpi@gmail.com>
In-Reply-To: <20201106192249.51574-1-98.arpi@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Nov 2020 13:00:17 +0800
Message-ID: <CABVgOSkdwPHLSVQRZX_HoRNokgLFq8ue2gm6zVHWvkD=1-dFyQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 7, 2020 at 3:23 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---

This looks good to me. Thanks!

Reviewed-by: David Gow <davidgow@google.com>

-- David
