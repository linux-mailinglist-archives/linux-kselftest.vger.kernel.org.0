Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4C2227C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgGPPqb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 11:46:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60323 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgGPPqZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 11:46:25 -0400
Received: from mail-vk1-f200.google.com ([209.85.221.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jw65X-0005hi-Ct
        for linux-kselftest@vger.kernel.org; Thu, 16 Jul 2020 15:46:23 +0000
Received: by mail-vk1-f200.google.com with SMTP id m1so2179381vkl.11
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 08:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49511E8U5NzXj6XxH4TCed0T2TTPIp8dIWRGqxsbGQ8=;
        b=qBey1rzUOx3wx5PHaDFtRQtC4vzgQ1DjNk6ljYcK+3Wr2DHviAi/UTuWQsBSbXVg0G
         iovxkESPh1h5NfRIhdO/zrtA4+r/dZrat34bJZdQ3O+Pc5gC6NYnFeRKlsA8LagZFMsk
         eNpgJKU7qinSqQ6Ky7v2T4SxE+wEMJ/PCt8hxiHCKvi9zzBnaZeMyPpqqNGLNbxFG6rq
         X3/SIoL8VKwHFgiMy8Imh5BKzH7tXlYq6Yo2WeT/EmZAc6tN/jHZyOmoSc0K8oihLKja
         qsA689Dgv1lckfWUjhiNh4Bu+7CvydqizIVc1gIxgqY9u5Y0IAfh8qirVYIpN44UCemr
         qlOA==
X-Gm-Message-State: AOAM531CCdr/BAzAQRaFaFlx+3fnB9J5DVautneTovD2fkvtUvsFIdXm
        gb4sI9mrSnIrkkUrZP1M254hsyY+ejruLQkcYRjAGZO0NWOTJ6HWnpLsvBJc6iga8/NkdWP3mDx
        lzm9dfl43UkclTq2ungZFj/rBfls3lIQ0X1++Y8098soOaH1yw5Zk5/s2PS8A9Q==
X-Received: by 2002:ab0:316:: with SMTP id 22mr4021373uat.41.1594914382441;
        Thu, 16 Jul 2020 08:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjBUFlT4V7UrutO5eSdMrKrzPd3+TUuc1pXG56i1MfLoBhtZFvasxN99/Oi07H7IokRV/M1tkLBOlMIoeNZWY=
X-Received: by 2002:ab0:316:: with SMTP id 22mr4021357uat.41.1594914382214;
 Thu, 16 Jul 2020 08:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200714124032.49133-1-paolo.pisati@canonical.com>
 <20200715180144.02b83ed5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMsH0TQLKba_6G5CDpY4pDpr_PWVu0yE_c+LKoa+2fm2f4bjBQ@mail.gmail.com> <20200716083844.709bad58@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200716083844.709bad58@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Paolo Pisati <paolo.pisati@canonical.com>
Date:   Thu, 16 Jul 2020 17:46:11 +0200
Message-ID: <CAMsH0TT0yYr0R99aN8sn8nTjWryt0wo+4wHLbQsNuPTruXk8qA@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: ip_defrag: modprobe missing
 nf_defrag_ipv6 support
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 5:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> I don't think modprobe fails when code is built in.
>
> $ sudo modprobe pstore
> $ echo $?
> 0
> $ grep CONFIG_PSTORE= /boot/config-5.7.8-200.fc32.x86_64
> CONFIG_PSTORE=y
> $ lsmod | grep pstore
> $

Ah, i didn't know - i'll send a V2 then.
-- 
bye,
p.
