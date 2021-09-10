Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26012407352
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Sep 2021 00:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhIJWWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Sep 2021 18:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhIJWWl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Sep 2021 18:22:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3CC061756
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 15:21:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w29so3886701wra.8
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O957Ri/0BgbMSrPbxQY/9ULVJYFNDqjXyqmF7WgsPVo=;
        b=LhvJ5TKap96EqV9/pPcDlP3U58e7yk7wFss4ufzPsVIj5y2XJbPcKaAlOvABrLGrKd
         CmDE5YasEk5QfA+RKiPigj25VuDR6UuHnzRiCaYoq+K0CAG8NYbyGBvY8ej0MZc8VM7X
         IxjGId1hnLBYpgGrJP2zj7WaRkX53sDTuAv8EZablEdPkv7j/ZX2sQbAhjfrrTuIKkMp
         otLhkNMkkgX8sTYHW3wEYAlI2gN62tAFfyVtrmgD1uoCzfIzo0Qx2YR61X0F79pJztA5
         9gKzxU93MSzBFOTyjkUAUPWifDmGlbnN2B2trk8LX+nkdqmcv1PHt2Y1Ihu9OOAtu9C1
         xZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O957Ri/0BgbMSrPbxQY/9ULVJYFNDqjXyqmF7WgsPVo=;
        b=iL9v0tx96UCvA9Eq36H5mAO6A6+7LdxKNF4HTMpPY2/J0o9c87FZV6mvz1iGk3C+X3
         LlCNDnUGQlZM6r70yXIrQ7Ej36EcpTgVy8V/GOxu0thuV8Su+bY+uYEcVjKGcxepKatl
         JP0kluXLnkOMQroq3zMGVLd6C9zEZxd4BVALsqXmFRLwp4nfemJITbu3W8hSF1/OOWNe
         K+Ygc/lIL6X7iiLH9bFWkoV8wGjqX/AT9FRqEzc16kmtbuAia3ryo+G2HHBqGmHl6QWX
         bw4ui+dRDsFlTRT9qnTZOZOdiQPlALG4EgcjjXz7LezjsAdcjpfvzftOIUjGuxyzsuKX
         QlwQ==
X-Gm-Message-State: AOAM5304RnYlKFNHGQkGXhp8krJy0PZBVjFt71aYfExAy+4xrdOwsUMG
        sE6ZsPAsPJhhB29KXhweLGfJNPKUtvNyfEK/xX4vl3dge7wjSQ==
X-Google-Smtp-Source: ABdhPJwPCI1BFrQljr8CVIaPm/HOKh9tjiswuqnbA3ltFmsMfJOsLlLTxXucgARNDednGBrthMujWF+g5kzitLnlR20=
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr2646wrx.147.1631312487842;
 Fri, 10 Sep 2021 15:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
In-Reply-To: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
From:   David Gow <davidgow@google.com>
Date:   Sat, 11 Sep 2021 06:21:16 +0800
Message-ID: <CABVgOSkHoVcRQLGVTZZ1andSY4UHqoRwLdyiTHh9KTQ4m3av9w@mail.gmail.com>
Subject: Re: After KUnit update for Linux 5.15-rc1 - unable to share VFAT
 filesystem via samba
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 10, 2021 at 8:02 PM Arthur Marsh
<arthur.marsh@internode.on.net> wrote:
>
>
>  Hi, I have been sharing an old VFAT formatted hard disk on one pc to
> another using Samba and sometime after kernel 5.14.0 it stopped working (apparently no longer being shared as the mount.smbfs command
> on the client failed with error -13 yet mount.smbfs still worked for
> ext3 filesytems shared from the same machine which had the VFAT
> filesystem).
>  The only error I saw on the machine with the VFAT formatted hard disk
> was the output of the mount command had truncated the name of the
> mount to only include the first 4 characters of the base name of the
> mount point.
>  e.g. when VFAT filesystem was mounted on /mnt/victoria, the output of
> the mount command showed the filesytem mounted on /mnt/vict
>

I can't reproduce this on my machine (which is openSUSE Tumbleweed
with their "vanilla" 5.14 kernel package on x86_64, mounting a FAT16
filesystem).

# mount /dev/sda1 /mnt/victoria
# mount | grep vic
/dev/sda1 on /mnt/victoria type vfat
(rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
# uname -a
Linux patpat 5.14.0-1-vanilla #1 SMP Mon Aug 30 07:01:36 UTC 2021
(dc06e24) x86_64 x86_64 x86_64 GNU/Linux

I can try it again on an older i386 machine, but I doubt that'd change
things: this doesn't smell architecture-specific to me.

This seems a lot more like it's something to do with /proc/mounts or
similar, rather than a FAT specific issue (and, unless something
really strange has happened with the CONFIG_FAT_DEFAULT_CODEPAGE
config option, which I doubt), this change shouldn't affect anything
at all when KUnit isn't enabled and used. I suspect it just shows up
in the bisect because it's basically the only change in fs/fat for a
while.

The bisect against the whole kernel tree seems likely to be of more use.

-- David
