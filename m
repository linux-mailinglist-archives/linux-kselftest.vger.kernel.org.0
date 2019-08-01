Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB47DB02
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2019 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfHAMLt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Aug 2019 08:11:49 -0400
Received: from foss.arm.com ([217.140.110.172]:34840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfHAMLs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Aug 2019 08:11:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3A191570;
        Thu,  1 Aug 2019 05:11:47 -0700 (PDT)
Received: from [10.1.194.48] (e123572-lin.cambridge.arm.com [10.1.194.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A4393F575;
        Thu,  1 Aug 2019 05:11:42 -0700 (PDT)
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
To:     Dave Hansen <dave.hansen@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <8c618cc9-ae68-9769-c5bb-67f1295abc4e@intel.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <13b4cf53-3ecb-f7e7-b504-d77af15d77aa@arm.com>
Date:   Thu, 1 Aug 2019 13:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8c618cc9-ae68-9769-c5bb-67f1295abc4e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/07/2019 17:50, Dave Hansen wrote:
> On 7/23/19 10:58 AM, Andrey Konovalov wrote:
>> The mmap and mremap (only new_addr) syscalls do not currently accept
>> tagged addresses. Architectures may interpret the tag as a background
>> colour for the corresponding vma.
> What the heck is a "background colour"? :)

Good point, this is some jargon that we started using for MTE, the idea being that 
the kernel could set a tag value (specified during mmap()) as "background colour" for 
anonymous pages allocated in that range.

Anyway, this patch series is not about MTE. Andrey, for v20 (if any), I think it's 
best to drop this last sentence to avoid any confusion.

Kevin
