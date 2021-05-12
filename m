Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B328A37BA75
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 May 2021 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhELK3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 06:29:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:48574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhELK3o (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 06:29:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 703E6B02E;
        Wed, 12 May 2021 10:28:35 +0000 (UTC)
Subject: Re: [PATCH v5 1/3] kunit: make test->lock irq safe
To:     glittao@gmail.com, brendanhiggins@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com
References: <20210511150734.3492-1-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7ae6e0a1-8a4c-02b0-e26d-2d6a5f107506@suse.cz>
Date:   Wed, 12 May 2021 12:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511150734.3492-1-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/11/21 5:07 PM, glittao@gmail.com wrote:
> From: Vlastimil Babka <vbabka@suse.cz>
> 
> The upcoming SLUB kunit test will be calling kunit_find_named_resource() from
> a context with disabled interrupts. That means kunit's test->lock needs to be
> IRQ safe to avoid potential deadlocks and lockdep splats.
> 
> This patch therefore changes the test->lock usage to spin_lock_irqsave()
> and spin_unlock_irqrestore().
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Note v4 had

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

and it's unchanged AFAIK.
