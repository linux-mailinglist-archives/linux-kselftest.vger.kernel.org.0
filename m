Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F60F2B70B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKQVKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKQVKN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:10:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9EC0613CF;
        Tue, 17 Nov 2020 13:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ri91W8ocs5j1kEkJ2qPP/wzX2scE1yNyfb4YmTpxrH4=; b=fYMULdu+st/sND/Y5nBpk1vwEM
        ZQqyFcbp0+JR5ZHTbEAnEyhsAspAv47XXzbUVytwqPrGuBFzZ8bwuWkg1WO89PU4uFmLgdz4XwFga
        AOJbkcINoGPsc9xC6lZpMV2dUVuivhAnGHstzSLmu8zPC0tp4fiNgagOr+eKyGKxM1FUZx3PaG5Sv
        p9TkaJpnsVGA2nyBr10k911eb9a9OoieU95yaxy7ZO6tgiTsP9g8uOMJnXDnkQrWEHqs3wZsiihkf
        E2RvJ200E479oTK+PrsvX407onFO8I0qmu4VInGHtJyt1cmi2Se0JPJ469qJTwHyTbCc6TC2pJBhG
        SSixLeNw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf8Ej-0003Zr-8e; Tue, 17 Nov 2020 21:10:01 +0000
Date:   Tue, 17 Nov 2020 21:10:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <20201117211001.GY29991@casper.infradead.org>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111204008.21332-4-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 03:40:05PM -0500, Zi Yan wrote:
> -	for (i = 0; i < nr; i++) {
> +	for (i = 0; i < nr; i += (1 << new_order)) {
>  		page_owner = get_page_owner(page_ext);
> -		page_owner->order = 0;
> +		page_owner->order = new_order;
>  		page_ext = page_ext_next(page_ext);
>  	}

This doesn't do what you're hoping it will.  It's going to set ->order to
new_order for the first N pages instead of every 1/N pages.

You'll need to do something like

		page_ext = lookup_page_ext(page + i);

or add a new page_ext_add(page_ext, 1 << new_order);
