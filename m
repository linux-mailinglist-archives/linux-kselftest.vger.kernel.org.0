Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D475306BBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Jan 2021 04:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhA1D6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Jan 2021 22:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhA1DjC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Jan 2021 22:39:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8036C061573
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Jan 2021 19:38:03 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r38so3369081pgk.13
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Jan 2021 19:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hollensbe-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eY5BQOmvzcQ3FJ+UYFQX4gZCqBAW08lM8MHHxyhSvY8=;
        b=wjqpBzeZBjFF43DqQA+T0dptnB0XvpseEsXpbkxSOa/xK9C2EIwvyzlbq4JSdb4Fe4
         oMAC/A5BdcR4ON1oLZDjsIjktcovKf2SgjEVQzag0QcB6z3SVUH9U0WxZilKH+/KK6m6
         My1rc+pxErqTEfoab36taXdcktviNsz4lzeBawIzmVU8+eF9wr1eTBV4A0LXJAoHkrCT
         HBZugh0FzH/iUwTI/yoFYk6pAC116zExAEnLAsqojuG2lX9Cka/5b+RQ8FiDKrrdWGpA
         q/9XEusXzmsH5IbvYC3TmOhSEtOiLPcxeQCbhz2iVOz3e+w8fjq6N4ts0h6xN4hN/MGg
         FSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eY5BQOmvzcQ3FJ+UYFQX4gZCqBAW08lM8MHHxyhSvY8=;
        b=pdoU+xYCBhP6LvXSQGbYxbEJP07zclyRmmOO+2eCedqxU8jhv2+vkH/X3R+/Vyvnb1
         WPhETLQGNEqaoz8I+Z03AAPjv8ZPFGXhd7Omhvb4i+9A9Uuj4iYb0EZEmUFjNbj/dQcC
         SAHHCVY1zBTCRAQsH/Qey2V42xQMcjICRcDJYKiYmI5HMFTVsD5XIPdO0RESk++fbx6S
         7xffbkRVNQXQixPZQwYZm4ht69lX0KdEnJUHAdSfRAImjZTGQhToQatVxH7imVmZrUgC
         XdWL+LFZlJx1HlMTKojWsOQHfekq7M0ME8+sVHUzKur6PsGTSFMNZc2WuQVgAhNXSKrE
         hpAw==
X-Gm-Message-State: AOAM5338KBQz+N600O0FxewV0LWRIL0mVeUTJBz2YZdKSc6QT8cBGFF6
        tmO2KMzEUd0d5H6CsS21XKkZ21A7WhyNnw==
X-Google-Smtp-Source: ABdhPJz0iiGeerPXl/fstTkwKfF1IiK+b+Sk06bSVbMFGLlxUJq2+IZDpP5EKTXXS2lDhn6ifjWkag==
X-Received: by 2002:aa7:909a:0:b029:1bc:22d3:9e58 with SMTP id i26-20020aa7909a0000b02901bc22d39e58mr13951655pfa.29.1611805083259;
        Wed, 27 Jan 2021 19:38:03 -0800 (PST)
Received: from linuxdev.home ([104.220.82.74])
        by smtp.gmail.com with ESMTPSA id r14sm4142363pgi.27.2021.01.27.19.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 19:38:02 -0800 (PST)
From:   Erik Hollensbe <erik@hollensbe.org>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
Subject: Correct .gitignore in several places for kselftest outputs
Date:   Wed, 27 Jan 2021 19:37:42 -0800
Message-Id: <20210128033743.77040-1-erik@hollensbe.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sincerely hope I did this right; first time contributor, learning the
patch workflow. I took the opportunity to fix two .gitignore files that
were leaving stale worktree/index outputs after running `make kselftest`
against recent mainline (76c057c84d286140c6c416c3b4ba832cd1d8984e).

Thanks for your time!


