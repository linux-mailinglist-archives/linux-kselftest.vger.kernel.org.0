Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72DC33EF75
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 12:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhCQLZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 07:25:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhCQLZB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 07:25:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB608AB8C;
        Wed, 17 Mar 2021 11:24:59 +0000 (UTC)
Subject: Re: [PATCH 1/2] selftests: add a kselftest for SLUB debugging
 functionality
To:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20210316124118.6874-1-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <de335a91-9ab6-37ac-f139-bb5f46c84625@suse.cz>
Date:   Wed, 17 Mar 2021 12:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316124118.6874-1-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/21 1:41 PM, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> SLUB has resiliency_test() function which is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it. Kselftest should proper replacement for it.
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
> Add new option CONFIG_TEST_SLUB in Kconfig.
> 
> Add parameter to function validate_slab_cache() to return
> number of errors in cache.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Disclaimer: this is done as part of Oliver's university project that I'm advising.
