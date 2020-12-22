Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8502E0AD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Dec 2020 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgLVNdm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Dec 2020 08:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgLVNdm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Dec 2020 08:33:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B9C06179C;
        Tue, 22 Dec 2020 05:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L72h3sjEObPKtskr0qgLJjQgQiwOWQdgosDwtPfonDE=; b=jBaNN9MYdKMfzwMcvvDfw/KK6s
        +0Ey2ZfmzkxF/eweGQjUgC8k8a4tOJj3JrSzTapbKYK4foMg7KIXO0qa4WgaMBBOKrPj6TFYP1GKe
        sfFZjzxPsYevDI98Hr7rsJAvWE5Anor7VTv8auhSQ1pHuVfFP7E83W0rICTVHQ+JcrrEhAGuhXzj0
        QfaWq/5NquWlJk4zx+Yu3fuq5SqUn666FBE+yzT20MrwiUePW4RMQezaurmQ/BNsYXGgPJS3G/6WP
        v4o/V1Hjlk4k0eP1ylBbDrrzn7+7Y9JMlcz/xb3awLry9RiwxxC02J/t9M5qgnDmZrTXE9CuTsW5b
        AO4F+cTw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krhmQ-0001SZ-29; Tue, 22 Dec 2020 13:32:46 +0000
Date:   Tue, 22 Dec 2020 13:32:46 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     josef@toxicpanda.com, bvanassche@acm.org,
        Christoph Hellwig <hch@infradead.org>, snitzer@redhat.com,
        corbet@lwn.net, kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
Subject: Re: [dm-devel] [PATCH v1 0/5] dm: dm-user: New target that proxies
 BIOs to userspace
Message-ID: <20201222133246.GA5099@infradead.org>
References: <30d39293-80a4-9ef5-92bb-6b6dec464be3@toxicpanda.com>
 <mhng-2da5b1a2-20f9-4b0e-9ffd-7f60a161ebf0@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-2da5b1a2-20f9-4b0e-9ffd-7f60a161ebf0@palmerdabbelt-glaptop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 14, 2020 at 07:00:57PM -0800, Palmer Dabbelt wrote:
> I haven't gotten a whole lot of feedback, so I'm inclined to at least have some
> reasonable performance numbers before bothering with a v2.

FYI, my other main worry beside duplicating nbd is that device mapper
really is a stacked interface that sits on top of other block device.
Turning this into something else that just pipes data to userspace
seems very strange.

