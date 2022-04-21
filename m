Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8FD50A625
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiDUQu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiDUQu7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 12:50:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497F4927A;
        Thu, 21 Apr 2022 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZZUAP2HYAHE5OkkuidiclxvYR23rMhwDhnBvEj7JuEI=; b=f1C6Ir7u4c+DNvvltg+uCHydGG
        IYpuQXQm0UkcmCFObdeIg5dWM2fsJGcEJy+8xUYhgDQecijl2VdkTa+QZ90/typfChPqKtCk2VjQj
        uH62jVMBZwQKwbl3rZ65u5UW5vhUyhsahLdS8r6lGNg9w8Xrk2M2s9APTPglY4uhRa23/6igQgGb/
        8KS9Otvsi0BqW2wf7+EBY33jDs14J3q16nH1DQELZQ08h2KLbur4GlzLBhs0K+HB+d9j++2UZO0oO
        bUfjLjXHSyEgIXrtaR+exvyVXj0AjR6aX7bhEf0LCJBibdFWsJvPIBxsupDfJAwyA1wGnc446XfQn
        zKUuuTrg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhZyP-00EJ6q-JC; Thu, 21 Apr 2022 16:48:05 +0000
Date:   Thu, 21 Apr 2022 09:48:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] Firmware loader support for ZSTD-compressed files
Message-ID: <YmGKxb6XILkRqucZ@bombadil.infradead.org>
References: <20220421152908.4718-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421152908.4718-1-tiwai@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 21, 2022 at 05:29:03PM +0200, Takashi Iwai wrote:
> Hi,
> 
> this is a revised patch set for RFC I posted some time ago (*).
> Since the ZSTD usage became much more popular now, it makes sense to
> have the consistent (de)compression support in the kernel, also for
> the firmware files.  This patch set adds the support for ZSTD-
> compressed firmware files as well as the extension of selftests, in
> addition to a couple of relevant fixes in selftests.
> 
> (*) https://lore.kernel.org/r/20210127154939.13288-1-tiwai@suse.de

Russ had posted a set of patches which this likely needs to be
rebased on top of. Russ however has to address one kernel splat
found by 0day, so I'd expect a new set and then perhaps this can
be based on that?

[0] https://lkml.kernel.org/r/20220419231658.664388-1-russell.h.weight@intel.com    

  Luis
