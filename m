Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAA219FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2019 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfEQOtk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 May 2019 10:49:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbfEQOtk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 May 2019 10:49:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C624E1715;
        Fri, 17 May 2019 07:49:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BA583F71E;
        Fri, 17 May 2019 07:49:34 -0700 (PDT)
Date:   Fri, 17 May 2019 15:49:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190517144931.GA56186@arrakis.emea.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrey,

On Mon, May 06, 2019 at 06:30:46PM +0200, Andrey Konovalov wrote:
> One of the alternative approaches to untagging that was considered is to
> completely strip the pointer tag as the pointer enters the kernel with
> some kind of a syscall wrapper, but that won't work with the countless
> number of different ioctl calls. With this approach we would need a custom
> wrapper for each ioctl variation, which doesn't seem practical.

The more I look at this problem, the less convinced I am that we can
solve it in a way that results in a stable ABI covering ioctls(). While
for the Android kernel codebase it could be simpler as you don't upgrade
the kernel version every 2.5 months, for the mainline kernel this
doesn't scale. Any run-time checks are relatively limited in terms of
drivers covered. Better static checking would be nice as a long term
solution but we didn't get anywhere with the discussion last year.

IMO (RFC for now), I see two ways forward:

1. Make this a user space problem and do not allow tagged pointers into
   the syscall ABI. A libc wrapper would have to convert structures,
   parameters before passing them into the kernel. Note that we can
   still support the hardware MTE in the kernel by enabling tagged
   memory ranges, saving/restoring tags etc. but not allowing tagged
   addresses at the syscall boundary.

2. Similar shim to the above libc wrapper but inside the kernel
   (arch/arm64 only; most pointer arguments could be covered with an
   __SC_CAST similar to the s390 one). There are two differences from
   what we've discussed in the past:

   a) this is an opt-in by the user which would have to explicitly call
      prctl(). If it returns -ENOTSUPP etc., the user won't be allowed
      to pass tagged pointers to the kernel. This would probably be the
      responsibility of the C lib to make sure it doesn't tag heap
      allocations. If the user did not opt-in, the syscalls are routed
      through the normal path (no untagging address shim).

   b) ioctl() and other blacklisted syscalls (prctl) will not accept
      tagged pointers (to be documented in Vicenzo's ABI patches).

It doesn't solve the problems we are trying to address but 2.a saves us
from blindly relaxing the ABI without knowing how to easily assess new
code being merged (over 500K lines between kernel versions). Existing
applications (who don't opt-in) won't inadvertently start using the new
ABI which could risk becoming de-facto ABI that we need to support on
the long run.

Option 1 wouldn't solve the ioctl() problem either and while it makes
things simpler for the kernel, I am aware that it's slightly more
complicated in user space (but I really don't mind if you prefer option
1 ;)).

The tagged pointers (whether hwasan or MTE) should ideally be a
transparent feature for the application writer but I don't think we can
solve it entirely and make it seamless for the multitude of ioctls().
I'd say you only opt in to such feature if you know what you are doing
and the user code takes care of specific cases like ioctl(), hence the
prctl() proposal even for the hwasan.

Comments welcomed.

-- 
Catalin
