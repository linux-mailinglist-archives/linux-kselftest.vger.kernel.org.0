Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C673B21EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFWUmM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 16:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFWUmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E3C0613A4
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d1so1144773plg.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4Wq1GvZOIjkJl+9Sb3C5gljEm3KHr7dyOq9Nh1kENs=;
        b=XFDgiA11BlqOZ/s5qZFq8MJlNVnoxfK5CVNFc1wQ+SamMB7fnUnMUUgxxrmEowQujn
         tChT4z4jt7Dod0HMLYvUcQ5smxaJewfSB0bx0ip0qzErWVrXCz873TRrhXNwq1WgYPh2
         J+XbSmnSUcAJVg4aI04DD6Q+X3GDjnShhd/c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4Wq1GvZOIjkJl+9Sb3C5gljEm3KHr7dyOq9Nh1kENs=;
        b=NqAH2PnehEge+qgAxvdbSm4NfsALm/FOwNRBolBH2bDPyQfjRnGKsKGMugXOTX4UC3
         F1qw8ioRLm+P37d++4QihBPIWH0qmYDZUhdJrsI1WP3STRIYDt53U5vxeLFg+n+ogQvL
         A03p9d3FQkhiSgxCkuZdEiHRDdEeAuRpo7qCy38NXJxoCNiA9EVXgTya1w8S6PW3J+Cd
         ns6qNz7+AKPjnBHaQdAvxvPzMDeZl34hmOzdtCmC4cqy7Y2e4dCt30rXvoDikqCWzX7B
         GUsk30XCwRuiOa52vQVuEGpKLLmb059phW1+0Fir56CevX5I7QbTwSJJicDRhYWtLFQJ
         NGDg==
X-Gm-Message-State: AOAM532j8ubMa8iuvaGi2Z/4es87x5AvEBFkLpQof6U9IRTjzA6cT4vQ
        o2rww6i6zBhf6J1gEH2lrrrdnw==
X-Google-Smtp-Source: ABdhPJwaRWpJV0oWeW72e7h8k40qI2L5xwkI1YI4az/SGTiOAfGJgoe0c1chphXJsHy1G3dgvqSphQ==
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr11521139pjb.6.1624480790156;
        Wed, 23 Jun 2021 13:39:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y39sm644828pfa.119.2021.06.23.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 6/9] lkdtm: Enable DOUBLE_FAULT on all architectures
Date:   Wed, 23 Jun 2021 13:39:33 -0700
Message-Id: <20210623203936.3151093-7-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; h=from:subject; bh=QfRkdXxwpbuwCkU2UJjVNaH2YmtWo4KLL9a8FrnsAOg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wGyZpmYK4bGS71//ZU4B8K/PYzebIRU4wL+IO5 4o7WiviJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBgAKCRCJcvTf3G3AJirXD/ 9ZdemyXHPgslPcJgT1bRYzqMUwNSL97PXErHRLjYgDkmORiRviHSACWq7BdCf9JHLl+jBeflXOPLZQ AbximpuX/FoB9FKsrHW7PAqWDi25hrM8UFNh/Qru8hNicn5W1byfOBVo36lG7+/+4QKrrpMorYPEsA om3e7YlG5GsVrovAHUHMNWJ5WMcPZAvZJb0D7ESVcVjxhzmYoqccFGJIJpbNQU+MnoaLTs9Iu3PRuV 3q3nzAZIENHOUMQTihH7jEog+oudsw6O4yKRlYsP1+dKYm8HI2+1PBjkUcEx4gmBuvcCOfyaYseu0j 1bdozFFNR+T/Ji8v5ry2S6p/fsoMQTItw57w7xCT/tqZHcpMgddcxy+/QcdE5VnE0oW4Zc3ySiZWZB xfyGeUzLdRHPzcKdIYqflNCMw1VQSUoQNoV/Z6ImPROiSRYk+w0173YAlUNgSjTsP2CV96lhqelPSi RtjbNSRaB0FmDCi5+P0jaXa3lKOxnR4XAOyunOMRds0qwSeGiPWU+a8MWj1dWlDzZWoAgiqHO32CQK 62fMew6TMBnOwvUSFXRq7J8zdEMNoiTO+jF+UhnChwpGrid6O+oLnFe/cjuzWYp5rICy/d03T4yBKD mSq+hoWr7vvnEQpgPh92VHycKploZOSBWMAcAaolOJlskbK4P3hc9IVdTRog==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Where feasible, I prefer to have all tests visible on all architectures,
but to have them wired to XFAIL. DOUBLE_FAIL was set up to XFAIL, but
wasn't actually being added to the test list.

Fixes: cea23efb4de2 ("lkdtm/bugs: Make double-fault test always available")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 645b31e98c77..2c89fc18669f 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -178,9 +178,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
 	CRASHTYPE(FORTIFIED_STRSCPY),
-#ifdef CONFIG_X86_32
 	CRASHTYPE(DOUBLE_FAULT),
-#endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	CRASHTYPE(PPC_SLB_MULTIHIT),
 #endif
-- 
2.30.2

