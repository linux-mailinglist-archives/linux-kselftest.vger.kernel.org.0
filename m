Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982E7360721
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 12:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhDOKad (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 06:30:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:43974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOKac (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 06:30:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB622B1E8;
        Thu, 15 Apr 2021 10:30:08 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
To:     glittao@gmail.com, brendanhiggins@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com
References: <20210413100747.4921-1-glittao@gmail.com>
 <20210413100747.4921-2-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d31f8829-1cbd-7159-6f93-6f750fd3cbd4@suse.cz>
Date:   Thu, 15 Apr 2021 12:30:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210413100747.4921-2-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/13/21 12:07 PM, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> SLUB has resiliency_test() function which is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it. KUnit should be a proper replacement for it.
> 
> Try changing byte in redzone after allocation and changing
> pointer to next free node, first byte, 50th byte and redzone
> byte. Check if validation finds errors.
> 
> There are several differences from the original resiliency test:
> Tests create own caches with known state instead of corrupting
> shared kmalloc caches.
> 
> The corruption of freepointer uses correct offset, the original
> resiliency test got broken with freepointer changes.
> 
> Scratch changing random byte test, because it does not have
> meaning in this form where we need deterministic results.
> 
> Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
> Because the test deliberatly modifies non-allocated objects, it depends on
> !KASAN which would have otherwise prevented that.
> 
> Use kunit_resource to count errors in cache and silence bug reports.
> Count error whenever slab_bug() or slab_fix() is called or when
> the count of pages is wrong.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

(again with a disclaimer that I'm the advisor of Oliver's student project)
