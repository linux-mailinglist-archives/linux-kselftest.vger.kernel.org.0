Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3F1341A51
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 11:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCSKqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 06:46:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:42822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhCSKqW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 06:46:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 709A4ACC6;
        Fri, 19 Mar 2021 10:46:21 +0000 (UTC)
Subject: Re: [PATCH 1/2] selftests: add a kselftest for SLUB debugging
 functionality
To:     Marco Elver <elver@google.com>, glittao@gmail.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20210316124118.6874-1-glittao@gmail.com>
 <YFM96dY1pfk/rs3U@elver.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3ba2228a-1442-40b4-578f-f693d9a054e7@suse.cz>
Date:   Fri, 19 Mar 2021 11:46:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFM96dY1pfk/rs3U@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/18/21 12:47 PM, Marco Elver wrote:
> On Tue, Mar 16, 2021 at 01:41PM +0100, glittao@gmail.com wrote:
>> From: Oliver Glitta <glittao@gmail.com>
>> 
>> SLUB has resiliency_test() function which is hidden behind #ifdef
>> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
>> runs it. Kselftest should proper replacement for it.
>> 
>> Try changing byte in redzone after allocation and changing
>> pointer to next free node, first byte, 50th byte and redzone
>> byte. Check if validation finds errors.
>> 
>> There are several differences from the original resiliency test:
>> Tests create own caches with known state instead of corrupting
>> shared kmalloc caches.
>> 
>> The corruption of freepointer uses correct offset, the original
>> resiliency test got broken with freepointer changes.
>> 
>> Scratch changing random byte test, because it does not have
>> meaning in this form where we need deterministic results.
>> 
>> Add new option CONFIG_TEST_SLUB in Kconfig.
>> 
>> Add parameter to function validate_slab_cache() to return
>> number of errors in cache.
>> 
>> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> 
> No objection per-se, but have you considered a KUnit-based test instead?

To be honest, we didn't realize about that option.

> There is no user space portion required to run this test, and a pure
> in-kernel KUnit test would be cleaner. Various boiler-plate below,
> including pr_err()s, the kselftest script etc. would simply not be
> necessary.
> 
> This is only a suggestion, but just want to make sure you've considered
> the option and weighed its pros/cons.

Thanks for the suggestion. But I hope we would expand the tests later to e.g.
check the contents of various SLUB related sysfs files or even write to them,
and for that goal kselftest seems to be a better starting place?

Vlastimil
