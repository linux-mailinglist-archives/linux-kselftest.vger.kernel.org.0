Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C092E1975
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Dec 2020 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLWHtv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Dec 2020 02:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgLWHtv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Dec 2020 02:49:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126BDC0613D3;
        Tue, 22 Dec 2020 23:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VJA2Gqy8jGT0RgzTT5UVlJfq4XprQm8NpWSKksAaoTw=; b=Y2KK7HRkXqg1VLN9ubpTwYDI0w
        Ep+SKigC5jwe2uB1UnUMz3uOsrVasAiYXZUzP9QprSSBjPJVqSZvomAb9NqBq8/VzqcNEclwAUs/a
        9DpG7xDpanTsGh1QSz6ldIcRgzZwLujXZ+nZ/jcAJSf48gFxTkatMqAmJmc2aOcQMSVzk2xyxf/9+
        tGNvyc4LINYaZpwmksQKJ4Mnlp6k069qYALw9MkYmOSKZVWgpS4Mesca9CJVr2T0TaIpy6LcqkJTl
        9gjBt/ayYYok4M0W0gqXj+mKdlMVIPkSK6Ni3DTGAUivYygjDnO58CGjHXQgH7OiKrcppizSGoHq+
        xahlPh9g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kryt8-00046B-Vc; Wed, 23 Dec 2020 07:48:52 +0000
Date:   Wed, 23 Dec 2020 07:48:50 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     snitzer@redhat.com, Christoph Hellwig <hch@infradead.org>,
        josef@toxicpanda.com, bvanassche@acm.org, corbet@lwn.net,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
Subject: Re: [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to
 userspace
Message-ID: <20201223074850.GA15369@infradead.org>
References: <20201222143616.GB12885@redhat.com>
 <mhng-26d96d8e-77aa-415b-a8ee-518a0e91b6ef@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-26d96d8e-77aa-415b-a8ee-518a0e91b6ef@palmerdabbelt-glaptop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


FYI, a few years ago I spent some time helping a customer to prepare
their block device in userspace using fuse code for upstreaming, but
at some point they abandoned the project.  But if for some reason we
don't want to use nbd I think a driver using the fuse infrastructure
would be the next logical choice.
