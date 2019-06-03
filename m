Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709933369D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfFCR3V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 13:29:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfFCR3V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 13:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E3YMznrQvI4XYCbxYdGQLQYRxZ6se0IICAJQI35QmUc=; b=rBmKAzm6VMFiVqBuypdPrNnHG
        9qR/xC1YUSUo4q1ihLjn3I1k3Z3Zt6ifT4BOE9d8JuD+KANIIdW4jN8PXiVc/rtwsBx2jUqqiusN9
        XZiJCQFveWwYCiDODxQrw3kCKKimNiQpVcsgEcblb0zsMWY+TexrkRomHsn0JqXwETKx9ELJfGj9q
        jOQlw3G/UlUJUPhW/UmsBMxDxE09/TlTcCGWjEEy2oiu1YHyvKMt+HBSMRmxLaLtbJMUdKbvkie5m
        R6xIoJDLFjnWEVIxBVl5q2n4wLYhS96OJs3nOLbuM/ziN5On8QOyJ8ynpVakg7HFTHIHdWMjvK7eX
        tMuk6CEhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXqlo-00025Q-9C; Mon, 03 Jun 2019 17:29:16 +0000
Date:   Mon, 3 Jun 2019 10:29:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v16 01/16] uaccess: add untagged_addr definition for
 other arches
Message-ID: <20190603172916.GA5390@infradead.org>
References: <cover.1559580831.git.andreyknvl@google.com>
 <097bc300a5c6554ca6fd1886421bb2e0adb03420.1559580831.git.andreyknvl@google.com>
 <8ff5b0ff-849a-1e0b-18da-ccb5be85dd2b@oracle.com>
 <CAAeHK+xX2538e674Pz25unkdFPCO_SH0pFwFu=8+DS7RzfYnLQ@mail.gmail.com>
 <f6711d31-e52c-473a-d7ad-b2d63131d7a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6711d31-e52c-473a-d7ad-b2d63131d7a5@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 11:24:35AM -0600, Khalid Aziz wrote:
> On 6/3/19 11:06 AM, Andrey Konovalov wrote:
> > On Mon, Jun 3, 2019 at 7:04 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >> Andrey,
> >>
> >> This patch has now become part of the other patch series Chris Hellwig
> >> has sent out -
> >> <https://lore.kernel.org/lkml/20190601074959.14036-1-hch@lst.de/>. Can
> >> you coordinate with that patch series?
> > 
> > Hi!
> > 
> > Yes, I've seen it. How should I coordinate? Rebase this series on top
> > of that one?
> 
> That would be one way to do it. Better yet, separate this patch from
> both patch series, make it standalone and then rebase the two patch
> series on top of it.

I think easiest would be to just ask Linus if he could make an exception
and include this trivial prep patch in 5.2-rc.
