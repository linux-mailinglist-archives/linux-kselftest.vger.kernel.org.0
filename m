Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA727335
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 02:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfEWAUz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 20:20:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46395 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfEWAUz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 20:20:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id z19so1850853qtz.13
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2019 17:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kja4wR6FLtasYFQS1xUbhik8iG88bHuMFvf2ArrK0nw=;
        b=b1PxbkXji6rxJkxXzX+E8hmtsDc4EAG6spndGBpqTY6Mtd1Z82qmKG7IFdzEDWmzKK
         cpfPgmFkndIKUtDn3lZmf4ZAYcKRjit4YkqMU72A44nfyHayfu0+OGxh9SgysS/YRAv2
         RDEnuh2qly9nvvswbClZIbFXuZCzwJj2KYSwWCU/YgJUugR9fRVuJUTKIe2+8zLwiPOj
         anBDeIuRaK3lpaZn56KojfHXM/H6EWmNRZuecl/6erGrJ5dc4+VdWT4yxUQf8Rpv9nUY
         hRDkUmUo3tTzvQuC1Vf8iYC9BBrTle8EWAWahcABrO+2gaF43DLowx5aiqsiUBpSVZlJ
         7EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kja4wR6FLtasYFQS1xUbhik8iG88bHuMFvf2ArrK0nw=;
        b=CJJK92Y5IA6txwHQ8orzUHqtBpzhyZT0VrPMUyo//4OXqDQFpkTXQltyaKdi3i7dMX
         pKJNUMOrUk42GdZ/fZXyCos4DQDRpPSU9Xg+PkprO2HbHS99ApWj66RhdW2jt6/3BIxe
         g36kKf5EFIGBpCUFdEQO8vonvknYChvTWoKt30N0HsWXh9tIahD97eF3RlD6k1wP02qp
         eAPuCkk50S1K2ibqggeoJZzgrV9aUxdfksFnbbqWbnNoqJyGJVgacShJOXSgWC7WRkWV
         EEjz8Z4sn+7wjJ8esL7xpLXZaRrfExz9puDUDpNmZfysyBXGgdo/Ow6jBuz8KexSefro
         P9jA==
X-Gm-Message-State: APjAAAUldpJm+xre03wuY2pSUn5QkweXPMcWFr3R6FH9Tjl5RTl2Y6HM
        k1LzE1s5EV9qoi6vjcJRpr6Hmw==
X-Google-Smtp-Source: APXvYqwzvo9H/aW7qSfx2OQVIHnUtdd1Cyzpi6J44RNo2JLbDhDXh7kfDH2OJy33sD2sQGXynL6VQQ==
X-Received: by 2002:ac8:f71:: with SMTP id l46mr70609860qtk.321.1558570854263;
        Wed, 22 May 2019 17:20:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t30sm15637238qtc.80.2019.05.22.17.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 17:20:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTbTZ-0001Zh-03; Wed, 22 May 2019 21:20:53 -0300
Date:   Wed, 22 May 2019 21:20:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190523002052.GF15389@ziepe.ca>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <20190521184856.GC2922@ziepe.ca>
 <20190522134925.GV28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522134925.GV28398@e103592.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 02:49:28PM +0100, Dave Martin wrote:
> On Tue, May 21, 2019 at 03:48:56PM -0300, Jason Gunthorpe wrote:
> > On Fri, May 17, 2019 at 03:49:31PM +0100, Catalin Marinas wrote:
> > 
> > > The tagged pointers (whether hwasan or MTE) should ideally be a
> > > transparent feature for the application writer but I don't think we can
> > > solve it entirely and make it seamless for the multitude of ioctls().
> > > I'd say you only opt in to such feature if you know what you are doing
> > > and the user code takes care of specific cases like ioctl(), hence the
> > > prctl() proposal even for the hwasan.
> > 
> > I'm not sure such a dire view is warrented.. 
> > 
> > The ioctl situation is not so bad, other than a few special cases,
> > most drivers just take a 'void __user *' and pass it as an argument to
> > some function that accepts a 'void __user *'. sparse et al verify
> > this. 
> > 
> > As long as the core functions do the right thing the drivers will be
> > OK.
> > 
> > The only place things get dicy is if someone casts to unsigned long
> > (ie for vma work) but I think that reflects that our driver facing
> > APIs for VMAs are compatible with static analysis (ie I have no
> > earthly idea why get_user_pages() accepts an unsigned long), not that
> > this is too hard.
> 
> If multiple people will care about this, perhaps we should try to
> annotate types more explicitly in SYSCALL_DEFINEx() and ABI data
> structures.
> 
> For example, we could have a couple of mutually exclusive modifiers
> 
> T __object *
> T __vaddr * (or U __vaddr)
> 
> In the first case the pointer points to an object (in the C sense)
> that the call may dereference but not use for any other purpose.

How would you use these two differently?

So far the kernel has worked that __user should tag any pointer that
is from userspace and then you can't do anything with it until you
transform it into a kernel something

> to tell static analysers the real type of pointers smuggled through
> UAPI disguised as other types (*cough* KVM, etc.)

Yes, that would help alot, we often have to pass pointers through a
u64 in the uAPI, and there is no static checker support to make sure
they are run through the u64_to_user_ptr() helper.

Jason
