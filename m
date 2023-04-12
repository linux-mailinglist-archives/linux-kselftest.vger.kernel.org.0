Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D736E0091
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 23:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDLVPM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDLVPL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 17:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D05244;
        Wed, 12 Apr 2023 14:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02BC261262;
        Wed, 12 Apr 2023 21:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04321C433D2;
        Wed, 12 Apr 2023 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681334109;
        bh=rUARulnjOQ307xRRVyKm5Rnu9uPFHJQRoc2s3q/8t0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rrr0D4OWLyVLCRnjgYHThscFy+m3+ZBz+6ThAEp6ELd27jTeFGBOxTC5RicER1VCc
         TJu63jqtoYpV3rjCG/PhpJXDF4U08MrhJP7it6C2b36t/6y265PSgpNR80rSn/PybW
         cAuNxVHam5iVXb/KudaCh6BzpcsjET3APwu6m2fc=
Date:   Wed, 12 Apr 2023 14:15:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v1 RESEND 3/6] sparc/mm: don't unconditionally set HW
 writable bit when setting PTE dirty on 64bit
Message-Id: <20230412141508.d91f9e07df9dd840219098ed@linux-foundation.org>
In-Reply-To: <de93ddc4-29ff-6113-a146-bc278dcce5f9@redhat.com>
References: <20230411142512.438404-1-david@redhat.com>
        <20230411142512.438404-4-david@redhat.com>
        <20230411193548.GA2094947@ravnborg.org>
        <de93ddc4-29ff-6113-a146-bc278dcce5f9@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 12 Apr 2023 11:48:15 +0200 David Hildenbrand <david@redhat.com> wrote:

> >> We have to move pte_dirty() and pte_dirty() up. The code patching
> > One of the pte_dirty() should be replaced with pte_write().
> > 
> 
> Indeed, thanks. I assume Andrew can change the latter to pte_write(). 

It was a struggle, but I managed to do this ;)
