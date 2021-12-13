Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D45A47376C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbhLMWYy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbhLMWYy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 17:24:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC470C061574;
        Mon, 13 Dec 2021 14:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEA25B81221;
        Mon, 13 Dec 2021 22:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C28C34601;
        Mon, 13 Dec 2021 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639434290;
        bh=JUsgj2dUHiE2WEeeCOTaDYRuKLPv+1NRbP0xBFDvqeU=;
        h=From:To:Cc:Subject:Date:From;
        b=SBKSM7XRoPfNQAQO76Hn/3KlDIXxsCnN9OcKVsYSyBUpipZtLRNtXYTAdeJVPTuVh
         KwuvNSFHczoR0cdB50J7VEm6455+2aumDjBYV/qe5tLwcMrFl3fUY6lhLtm5sxU3QT
         /QS6ISFCz89sgS7XPUH8X2cWnc+rso0Qu1m8grrAfdU2NsRgM0NFc929Lwg28vLURC
         xiuZg3wWSWHwQqtb0E7TvXOHYlfjsRDKgMLeNjqaA21gPci9kF9Ixc2SvhnwUovz9o
         y35+sQ2J2p6AuQ9uv58jDulihxEtrqvt8s9uEEaEwA5BCOz10dZ+6TpVbDJeGNTelT
         kTe9uiiwa8iXA==
From:   broonie@kernel.org
To:     Matthew Wilcox <willy@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: linux-next: manual merge of the xarray tree with the kselftest tree
Date:   Mon, 13 Dec 2021 22:24:43 +0000
Message-Id: <20211213222443.474487-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Today's linux-next merge of the xarray tree got a conflict in:

  tools/include/linux/kernel.h

between commits:

  d6e6a27d960f9 ("tools: Fix math.h breakage")
  066b34aa5461f ("tools: fix ARRAY_SIZE defines in tools and selftests hdrs")

from the kselftest and origin trees and commit:

  f2aa11fd51440 ("tools: Fix math.h breakage")

from the xarray tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/include/linux/kernel.h
index 9701e8307db02,3e8df500cfbd4..0000000000000
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
