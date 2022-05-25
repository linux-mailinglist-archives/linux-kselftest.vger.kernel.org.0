Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6773553354E
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 04:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiEYC1z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 22:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbiEYC0O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 22:26:14 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAECE22BF3;
        Tue, 24 May 2022 19:26:13 -0700 (PDT)
Date:   Tue, 24 May 2022 19:26:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653445571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXx4F9wUjqDqnxItlogKlV+6bSU2C37UciSDkRX2OcU=;
        b=cltERvpd9/BsbbrUHUBYK9fauukniigpOChcjUlKIHJPRgAc6yjyz3akEdweV6Xi4OJZyj
        xwcrNb/oUv0hkOCAg+rPrlPKRX6J+lb11T+AN+CraLePT67cbn9CIDG/2th4mL0KM4KPah
        4gjfewLE7dCTdZVEzTWN+toba5BPeQ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v3 5/5] selftests: memcg: Factor out common parts of
 memory.{low,min} tests
Message-ID: <Yo2TvWr/0Y6s9SE2@carbon>
References: <20220524162955.8635-1-mkoutny@suse.com>
 <20220524162955.8635-6-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524162955.8635-6-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 24, 2022 at 06:29:55PM +0200, Michal Koutny wrote:
> The memory protection test setup and runtime is almost equal for
> memory.low and memory.min cases.
> It makes modification of the common parts prone to mistakes, since the
> protections are similar not only in setup but also in principle, factor
> the common part out.
> 
> Past exceptions between the tests:
> - missing memory.min is fine (kept),
> - test_memcg_low protected orphaned pagecache (adapted like
>   test_memcg_min and we keep the processes of protected memory running).
> 
> The evaluation in two tests is different (OOM of allocator vs low events
> of protégés), this is kept different.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
