Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E25531202
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiEWN3i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiEWN3Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 09:29:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E81FCFA;
        Mon, 23 May 2022 06:29:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A09AC21ACF;
        Mon, 23 May 2022 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653312559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtxU29oO1IFvVA3hN0PuI5lGfiBVozRsUJAeElrZ+0M=;
        b=IXT+cH2wydH7nqcS1UuXTHk70XKlgBcSFLBInZA3NzwcOi4YTvYLyHoGDjpnf/0xPS002U
        7cEHjkPzTdRzhmhZJWszJj4Fmk8JZszqWKwLAE63ifwZ8einhrZsvmylYrUY/hY4mtk3oP
        EvlUPDNRE0cf0oPb0O2GzeRQU+RCI9M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6867A139F5;
        Mon, 23 May 2022 13:29:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cuh1GC+Mi2I2WwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 23 May 2022 13:29:19 +0000
Date:   Mon, 23 May 2022 15:29:17 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH v2 1/5] selftests: memcg: Fix compilation
Message-ID: <20220523132917.GA4988@blackbody.suse.cz>
References: <20220518161859.21565-1-mkoutny@suse.com>
 <20220518161859.21565-2-mkoutny@suse.com>
 <5242b7ab-d6b6-55d4-c211-ec27293be795@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5242b7ab-d6b6-55d4-c211-ec27293be795@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 21, 2022 at 07:11:01PM +0500, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> On 5/18/22 9:18 PM, Michal Koutný wrote:
> > This fixes mis-applied changes from commit 72b1e03aa725 ("cgroup:
> > account for memory_localevents in test_memcg_oom_group_leaf_events()").
> Shouldn't the Fixes tag be added here and in 2/5 patch?

Ad the patch 1/5 -- yes, sounds appropriate.

Ad the patch 2/5 -- that's an effective revert, I don't see reverts
being marked with Fixes.

I see the patch 5/5 didn't make it to MLs (their public archives, except
for LKML). So I'll resend the series with the modified commit message
(if nothing else pops up).

Michal
