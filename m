Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4784B33EF79
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 12:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhCQLZm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 07:25:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhCQLZP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 07:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2568AE5C;
        Wed, 17 Mar 2021 11:25:13 +0000 (UTC)
Subject: Re: [PATCH 2/2] slub: remove resiliency_test() function
To:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20210316124118.6874-1-glittao@gmail.com>
 <20210316124118.6874-2-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d3d0c759-c73f-9ada-c463-8891e6999e59@suse.cz>
Date:   Wed, 17 Mar 2021 12:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316124118.6874-2-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/21 1:41 PM, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Function resiliency_test() is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it.
> 
> This function is replaced with kselftest for SLUB added
> by the previous patch "selftests: add a kselftest for SLUB
> debugging functionality".
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
