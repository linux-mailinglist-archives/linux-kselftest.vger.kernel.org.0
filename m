Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8875247488D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 17:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhLNQyI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 11:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhLNQyH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 11:54:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFE9C061574;
        Tue, 14 Dec 2021 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bsdwAHsReHN03BIweW5JUQAG4/ExPGCG9l6sB1GkEkw=; b=L9RyD9Wu8lmVnED7gzfOb+3xHy
        NhdYy5Sj4JqQjkpPsyX2DHgvRIcsvD6npwAlQtUkUOx7ir+ZUb4MorVGmPIx/YEbnuHSCYuzMPDg1
        g84oe1RGcdP1KcCE5xZEi7bClPLEYkJY5rBhJl0rgRxeucFwYd897q/4jdyBsLhok/dNNf2UemXzc
        PFBvSFbutHCQKligvjpurhn/k8yq0ZLZuKxtzc4sEryQ8TlGen4/pV9LjQGfBQmm39oIRgQdOt2hZ
        /+a9SpRuNAqGqf/Ni9GTYewYR9rI7Rw58EAwJ1cI1U1KpxhV6egAJ5PN+HZI/CcfeWbjzk4CnGIZQ
        jCc0HfpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxB40-00Du42-1V; Tue, 14 Dec 2021 16:54:04 +0000
Date:   Tue, 14 Dec 2021 16:54:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     broonie@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: linux-next: manual merge of the xarray tree with the kselftest
 tree
Message-ID: <YbjMLHCRXNMwp4nU@casper.infradead.org>
References: <20211213222443.474487-1-broonie@kernel.org>
 <1dcd2d43-cf39-3b4c-49b5-138d94f34433@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcd2d43-cf39-3b4c-49b5-138d94f34433@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 09:39:25AM -0700, Shuah Khan wrote:
> On 12/13/21 3:24 PM, broonie@kernel.org wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the xarray tree got a conflict in:
> > 
> >    tools/include/linux/kernel.h
> > 
> > between commits:
> > 
> >    d6e6a27d960f9 ("tools: Fix math.h breakage")
> >    066b34aa5461f ("tools: fix ARRAY_SIZE defines in tools and selftests hdrs")
> > 
> > from the kselftest and origin trees and commit:
> > 
> >    f2aa11fd51440 ("tools: Fix math.h breakage")
> > 
> > from the xarray tree.

I've dropped that commit from the XArray tree since d6e6a27d960f9
was essentially f2aa11fd51440 applied to Linus' tree.  The only change
left in the XArray tree today is a documentation update.

> Thank you. I will keep track of this when I send pull request.

As long as what you have merges cleanly against Linus' tree (and I see
the "conflict" -- __round_mask() is defined adjacent to ARRAY_SIZE()),
then it'll be fine.  You might want to rebase to a more recent Linus
tree to get rid of the conflict.
