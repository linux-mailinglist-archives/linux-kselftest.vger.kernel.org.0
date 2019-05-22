Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474DE2621F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfEVKlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 06:41:13 -0400
Received: from foss.arm.com ([217.140.101.70]:47710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbfEVKlM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 06:41:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10655341;
        Wed, 22 May 2019 03:41:12 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3C13F575;
        Wed, 22 May 2019 03:41:06 -0700 (PDT)
Date:   Wed, 22 May 2019 11:41:03 +0100
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
Subject: Re: [PATCH v15 03/17] lib, arm64: untag user pointers in strn*_user
Message-ID: <20190522104103.r5any4us4zz7gwvg@mbp>
References: <cover.1557160186.git.andreyknvl@google.com>
 <861418ff7ed7253356cb8267de5ee2d4bd84196d.1557160186.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861418ff7ed7253356cb8267de5ee2d4bd84196d.1557160186.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 06, 2019 at 06:30:49PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> strncpy_from_user and strnlen_user accept user addresses as arguments, and
> do not go through the same path as copy_from_user and others, so here we
> need to handle the case of tagged user addresses separately.
> 
> Untag user pointers passed to these functions.
> 
> Note, that this patch only temporarily untags the pointers to perform
> validity checks, but then uses them as is to perform user memory accesses.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Just to keep track of where I am with the reviews while the ABI
discussion continues:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
