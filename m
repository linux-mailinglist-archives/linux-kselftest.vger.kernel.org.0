Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A228EB5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 05:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgJODCF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 23:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgJODCF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 23:02:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265EC0613D3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 20:02:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k1so2409787ilc.10
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE37yiXefAPuWdOvXCxECs8BTHKeK76YuEhnWlDbpwo=;
        b=k+4SOOKNx1rO/LBOD7BT3yOb7lmbfJwQgep7TIo5grne3cBSlnHHLzBVr2DDxyT8v2
         Twe5JLel24/2t229GtyKyKZYb+Bkm+mw/s0NDWPPittJ/EeD1bb/4YleFanrgizR8fLJ
         eZ8JFL0z3YTOYpSrXDiB0FVryT4A94S4ClVArEESMi7XQhcr1TaJ20PBNkCi3G0b2IMs
         U+Ii7tbkh8tEEmOY1FH98Qk7xDwUFZcftvHayY3s+3+5YisjHbwcuzhmKRV+q3vSnTNY
         A50YoE+vZA0UrWAm9p7puIfoTn16Z8hBDEQ7ZglGfmW5IsEw0VIeQRCqWPFBZNAPPFp5
         7DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE37yiXefAPuWdOvXCxECs8BTHKeK76YuEhnWlDbpwo=;
        b=sY0EdjCGiGIgoDWcgxsWsUYFznECa4livyCHsPS+KM9OQLCIEDwZe57xm0R4ucSgqF
         MoDUYR6p7QS/z96ZXVk1WbeYb+J7JUjf78vCdKkSz4oZKvnNQdCcdOM8FnECc/YS692B
         IsgjnyXL2Q+k/3PHSn0tuFGDiZAMSly9sbqT2H8g3XuUcPQdN1sPcO6ri+T2eRIvZcbH
         LZXYpMI5+nMz+rhpwVYIXY+s41mqRxPHP3wwrjwyZzFNT+MTwYVYIQYEn0il0+8ICiZI
         H4yviegPT5Tm8z6zixS4SzLMERiWBJ7klcdxyAN8vJZxESu2xwFHCOnWO7OJT2EQL4qP
         vdVw==
X-Gm-Message-State: AOAM533zvvxXnno/eLjl7GJPEmFo8wBHGj6H/D178ZlimZ2YF7Ijs8ry
        8ZxgYxx1FPg2GRy6XvDO3ImJa8Ha9GAE/YXyA54E0w==
X-Google-Smtp-Source: ABdhPJxtJ8xfLbGX5R7RGysvv/WdX3cvUvH9P/82SA5nT+JuPN/1E9QJ150Dqu8NvMgFOtDQV4i5oWT0snQaSy2PQNs=
X-Received: by 2002:a05:6e02:bf4:: with SMTP id d20mr1615013ilu.252.1602730924068;
 Wed, 14 Oct 2020 20:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv=zPRGCKyhi9DeUsvyb6ZLVVXdV3hW+15XnQN2R3ircQ@mail.gmail.com>
 <20201014193034.GA14337@salvia>
In-Reply-To: <20201014193034.GA14337@salvia>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 15 Oct 2020 08:31:52 +0530
Message-ID: <CA+G9fYsnPH4nQWoY0bpdw+DS5sqO4xcxDXuu-tfEHxXEGrMyUA@mail.gmail.com>
Subject: Re: selftests: netfilter: nft_nat.sh: /dev/stdin:2:9-15: Error:
 syntax error, unexpected counter
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Florian Westphal <fw@strlen.de>, fabf@skynet.be,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 15 Oct 2020 at 01:00, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> On Wed, Oct 14, 2020 at 05:19:33PM +0530, Naresh Kamboju wrote:
> > While running kselftest netfilter test on x86_64 devices linux next
> > tag 20201013 kernel
> > these errors are noticed. This not specific to kernel version we have
> > noticed these errors
> > earlier also.
> >
> > Am I missing configs ?
>
> What nftables version are you using?

nft --version
nftables v0.7 (Scrooge McDuck)

- Naresh
