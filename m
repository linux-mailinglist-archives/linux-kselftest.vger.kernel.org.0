Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF7043C52
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfFMPfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:35:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43938 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbfFMKaM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 06:30:12 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hbMyW-0002n5-5c
        for linux-kselftest@vger.kernel.org; Thu, 13 Jun 2019 10:28:56 +0000
Received: by mail-wr1-f71.google.com with SMTP id b14so8647441wrn.8
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 03:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vJoe4QOYmSpzL3TX3nF/EcZqCXILy8LMNIEV2dPMlw=;
        b=i3AqIopmUZMEC1849OATbkpsSJcM8yknb9kDvSjfm/FS0lnX+u6YSgF+AWTZAEHFbu
         J1X9H/O7LXxTst3GiOZwvOhWK1SwRfGBO4xVnmqOFeqAQ36JEYTQmOBC7loQxc2LlHQn
         boDPVUJ5Lwdqomxbk08GiVqCzvA3JbAHDThyX5LgO+7QklXne8D2boZYZ+U7VhDbwK7I
         Nxcus3zNDUqWxefhTyrESCm6f1RMGYNHD+Ou7GZGDenFiIVCXAEDpN+76NyLh9VL8/VL
         rUbqnzrglwtUQTFlmAbDbu1bCcI0ygzs5OJyfOsnqdoWtALB48PVFJk2wVb0Bl3iHro0
         gd8w==
X-Gm-Message-State: APjAAAUMfAnwaStL3q2Oqj8+DNioLdoOntwvMD6lT2XLYcFpdGE2QXw0
        3HyU/3C5qse24KGQf4fZ2n+aQAoJKSKl6fK7tUDpIg3IWxWvH9jNFLMuhf3xbLOmbX3kRVudpXK
        yP9Hq3K59bNyfD95TXoLsURdwHZ3VI7ZhoSmYJ4/Xfp7uF2kLUXu/a7yDYCMt
X-Received: by 2002:a7b:c313:: with SMTP id k19mr3050158wmj.2.1560421735774;
        Thu, 13 Jun 2019 03:28:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgKUzFv9JlTv26cq3GlGgLVgjVoMCkwh6CKsBT7LawKThQzRDyIbi5mMPqn4/bfa1JwGFkSAyBv6iKEvpwYik=
X-Received: by 2002:a7b:c313:: with SMTP id k19mr3050140wmj.2.1560421735553;
 Thu, 13 Jun 2019 03:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190612064752.6701-1-po-hsu.lin@canonical.com> <20190612.092711.1626983045451710048.davem@davemloft.net>
In-Reply-To: <20190612.092711.1626983045451710048.davem@davemloft.net>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 13 Jun 2019 18:28:44 +0800
Message-ID: <CAMy_GT8YjDhRSHMYBALHeqDhKYhr2Z+--=imZ+T5WV0wCz_v6g@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: skip psock_tpacket test if KALLSYMS was
 not enabled
To:     David Miller <davem@davemloft.net>
Cc:     shuah <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

This issue was spotted on Ubuntu linux-kvm kernel, on which the
CONFIG_KALLSYMS was disabled intentionally.
I think this extra check could be helpful when running the net test directly.
$ make -C tools/testing/selftests TARGETS=net run_tests

Also, there is an identical check implemented in the ftrace
kprobe_args_symbol test.

I can send V2 along with CONFIG_KALLSYMS appended to the "config" file
if you agree with this.

Thanks

On Thu, Jun 13, 2019 at 12:27 AM David Miller <davem@davemloft.net> wrote:
>
> From: Po-Hsu Lin <po-hsu.lin@canonical.com>
> Date: Wed, 12 Jun 2019 14:47:52 +0800
>
> > The psock_tpacket test will need to access /proc/kallsyms, this would
> > require the kernel config CONFIG_KALLSYMS to be enabled first.
> >
> > Check the file existence to determine if we can run this test.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Please just add CONFIG_KALLSYMS to "config".
