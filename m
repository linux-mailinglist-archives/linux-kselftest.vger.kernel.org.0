Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7DB3EB73C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Aug 2021 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbhHMPAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Aug 2021 11:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241035AbhHMPAl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Aug 2021 11:00:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36B3A610F7;
        Fri, 13 Aug 2021 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628866814;
        bh=rJVB8c8zbROro7cBJd32sE+qX454V0M11ELW5v/GB3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKct3yRhUjIGcZVMd3+a4SEO46LXuMVjuhR1kUj18Pdtt+l/GKCcxfY110R9CPNby
         GzbXyFA7YWqSPKSsfSZ94Lm6ZLYTWaunQddsfcaxBBUYbm1SDOo/XLo8XBSEwSCVfJ
         mITOtkl3bE7gsfo+EcR95klekcpGOxipr0jS8/up6VE6fB6eCFt2XnXtaH5p1sNqfm
         MyKN46D33TQ05nuXjE5H398odFXpQOU16utmASAt/3URmksN3TNC3yxJDpHqdkTojj
         pxLSpp9sZ1QsiJqkvJnyw1Ctl6i5nBMGQ0cy6EIgCxaWRjtbzoWEe+o7ewZiCv3nyF
         87NF/ZCBLw40w==
Date:   Fri, 13 Aug 2021 16:00:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, luto@kernel.org,
        linux-kselftest@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2] selftest: Add test for Soft-Dirty PTE bit
Message-ID: <20210813150009.GC8451@willie-the-truck>
References: <20210603151518.2437813-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603151518.2437813-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 03, 2021 at 11:15:18AM -0400, Gabriel Krisman Bertazi wrote:
> This introduces three tests:
> 
> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
> check if the SD bit flipped.
> 
> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
> 
> 3) Check soft-dirty on huge pages
> 
> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
> same issue that he fixed, and this test would have caught it.
> 
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> --
> Changes since V1:
>   - Fix last minute build break with page_size
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/soft-dirty/.gitignore |   1 +
>  tools/testing/selftests/soft-dirty/Makefile   |   9 +
>  .../testing/selftests/soft-dirty/soft-dirty.c | 254 ++++++++++++++++++
>  4 files changed, 265 insertions(+)
>  create mode 100644 tools/testing/selftests/soft-dirty/.gitignore
>  create mode 100644 tools/testing/selftests/soft-dirty/Makefile
>  create mode 100644 tools/testing/selftests/soft-dirty/soft-dirty.c

Although I think adding a test for this is great (and I certainly wouldn't
want to get in the way of that; quite the opposite), I notice that we
already have test_softdirty() in selftests/vm/madv_populate.c. Would we be
better off extending that test instead of introducing another one?

Will
