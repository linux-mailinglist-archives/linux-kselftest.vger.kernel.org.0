Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA24070A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Sep 2021 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhIJRom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Sep 2021 13:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJRol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Sep 2021 13:44:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A4C061756
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 10:43:30 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b7so3347258iob.4
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qw3i7ZkRYyRAIDKAvMyUaqPTTRDJN0J3gzh1YtLJNZI=;
        b=H0qmjbKYUEvyXyLOKZSh7axYPu5rWika6mv2MFuBPBKYYGY7sLSyUD16rVZbR9Iig3
         bOK2yBJ9w1rvQBTuHa84A/SdI+JFHBlrzRZtRmrPydwIUcoj9lvSkFf6IzB9UiB5Stxt
         0R3p4cFeKAlcXs/PGQ6OHHkr7OxH95OaY6Srk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qw3i7ZkRYyRAIDKAvMyUaqPTTRDJN0J3gzh1YtLJNZI=;
        b=RQmVAbnIHoA/IKCPilt3/iw1ya/MQrrS239NuMG3FXwKjSAHYosIcWeYeOT5QB2BNr
         gYDhtVdA/tnWAgO1OnVE3h3BGYA2hMXlcHOKbFVPjjM8/ZyVxrqUTs8USFVOtrfM06CS
         sFK7N0Ia5y3ctA1XXyhAzuifqemZXiE5gB8KCDz7rjO82PPvWgijC9M96ljxoz3vohel
         +U0SATqNXjD6dp3BLEfBmJqDWO9QmufSILuHGDJaQvpSsUFsMaotEAJVgWnFtHWabtfx
         dWP//AICl79z/KiscExOhxZi+pg9JrIXcsxeEYoD5t0IEER+z7pk8bdAzzZj2D4XMmlp
         px2A==
X-Gm-Message-State: AOAM532OI+AlfShOQq9jY6XDbGKOroUVVmvASxNrIyLfEcVbcNJ7SBN7
        PkGmeqD6MI6d1cNLtfygTfWqNw==
X-Google-Smtp-Source: ABdhPJxbeVole14DxMmq7hdrTu6bspXWv6Dh2xY5aXGIAfaszutk1niQpVx0lIia221XbGJCTsH67w==
X-Received: by 2002:a5d:9145:: with SMTP id y5mr7905456ioq.200.1631295810144;
        Fri, 10 Sep 2021 10:43:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l1sm2867638ilc.65.2021.09.10.10.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 10:43:29 -0700 (PDT)
Subject: Re: After KUnit update for Linux 5.15-rc1 - unable to share VFAT
 filesystem via samba
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f1d84102-6edf-271f-52f9-0d4bbc85c0c7@linuxfoundation.org>
Date:   Fri, 10 Sep 2021 11:43:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Arthur,

On 9/10/21 5:57 AM, Arthur Marsh wrote:
> 
>   Hi, I have been sharing an old VFAT formatted hard disk on one pc to
> another using Samba and sometime after kernel 5.14.0 it stopped working (apparently no longer being shared as the mount.smbfs command
> on the client failed with error -13 yet mount.smbfs still worked for
> ext3 filesytems shared from the same machine which had the VFAT
> filesystem).
>   The only error I saw on the machine with the VFAT formatted hard disk
> was the output of the mount command had truncated the name of the
> mount to only include the first 4 characters of the base name of the
> mount point.
>   e.g. when VFAT filesystem was mounted on /mnt/victoria, the output of
> the mount command showed the filesytem mounted on /mnt/vict
> 

This could be path name related to the second bad commit in your bisect.

> The kernel build used was i386 with gcc 11.2.0-4 using
> 
> make - j2 menuconfig bindeb-pkg
> 
> .config available on request.
> 

Can you send your config and dmesg? This will help determine if
KUNIT is enabled - it shouldn't be.

>   The git-bisect was:
> victoria:/usr/src/linux# git bisect loggit bisect start '--' 'fs/fat'#
> good: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14git bisect
> good 7d2a07b769330c34b4deabeed939325c77a7ec2f# bad:
> [a3fa7a101dcff93791d1b1bdb3affcad1410c8c1] Merge branches 'akpm' and
> 'akpm-hotfixes' (patches from Andrew)git bisect bad
> a3fa7a101dcff93791d1b1bdb3affcad1410c8c1# good:
> [edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba] block: move the bdi from
> the request_queue to the gendiskgit bisect good
> edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba# good:
> [b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd] fat: Add KUnit tests for
> checksums and timestampsgit bisect good


> b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd# bad:

This one is a KUnit patch
Subject: [PATCH] fat: Add KUnit tests for checksums and timestamps


> [c815f04ba94940fbc303a6ea9669e7da87f8e77d] Merge tag
> 'linux-kselftest-kunit-5.15-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftestgit
> bisect bad c815f04ba94940fbc303a6ea9669e7da87f8e77d# first bad commit:
> [c815f04ba94940fbc303a6ea9669e7da87f8e77d] Merge tag

Subject: [PATCH] d_path: make 'prepend()' fill up the buffer exactly on
  overflow

> 'linux-kselftest-kunit-5.15-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
>
thanks,
-- Shuah
