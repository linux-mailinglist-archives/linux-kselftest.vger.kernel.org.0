Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA57077EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjERCSq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 22:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjERCSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 22:18:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F6210C
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:44 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f52d303bcdso16412571cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684376324; x=1686968324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCu7Ak9sgK0WMAL5249Y718D7sduRnnJz2HjRJyEMOs=;
        b=F4rW5UP8TqTkd/lQXeAReTFK35lieoXOx8Yw8Zu20T3/n6psCNhmevEoHClkJcitLV
         BnqyTQVgrRo9mC7D/ko++Kn6HsZStPa2GXnAGX2DaRkFr5JistFH30eCNIND7IFOBo/N
         hh6+RcUE1+w+HMBAAcDWj+XCeEWEFz2cLA6z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684376324; x=1686968324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCu7Ak9sgK0WMAL5249Y718D7sduRnnJz2HjRJyEMOs=;
        b=hCUvuhq8KgO97Oit7fldOTfa07ifoG1IOixRHspXHprHQWJPfxD3ymH0y6dh9vVpLS
         BjgrUHiG+FbTk5SSSIXb6oCspRXXDcOH3DagDDDi6Kftjez4ubZRd0lhmMVgC5AMfud6
         ibdy6BxdwUBizf9QmjbtLSRDxW9nhqgIa4JE6xcHoBG9kq+Xna6EdygEtr8UO6c+pL5Q
         zjnQcVBvB+p3zj03OHqUGi8+L6xSZrGAJoAVaCNEnTsV6H1tVTZwf1YmJXTScTSosS0h
         FatOcPpBSq/amiVGgwDajNoYucVaOXhFu4yTwjymvROMRyMjIUXGF/uxPq5SCeuXl/Fu
         KinA==
X-Gm-Message-State: AC+VfDwFKDBH/0q9LlBzVoYyW4gALaJW809ytYjv9oLrm1rkYDmuvjus
        PrnXAophTZHpLUZx9fS5nIXRhw==
X-Google-Smtp-Source: ACHHUZ6b19lX6KtHk/RmSTe5aPH5FrPt1j5ndazqzwGpCqf9Nutq5nFVszhWb6vLIYsJKGruXC0/YA==
X-Received: by 2002:ac8:594e:0:b0:3f4:cfed:96b5 with SMTP id 14-20020ac8594e000000b003f4cfed96b5mr3360483qtz.59.1684376323817;
        Wed, 17 May 2023 19:18:43 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a000d00b007577ccf566asm85082qki.93.2023.05.17.19.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 19:18:43 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 0/4] Optimize mremap during mutual alignment within PMD
Date:   Thu, 18 May 2023 02:18:21 +0000
Message-ID: <20230518021825.712742-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

I am posting this as an RFC for any feedback. I have tested them suitably and I
am continuing to test them.

These patches optimizes the start addresses in move_page_tables(). It addresses a
warning [1] that occurs due to a downward, overlapping move on a mutually-aligned
offset within a PMD during exec. By initiating the copy process at the PMD
level when such alignment is present, we can prevent this warning and speed up
the copying process at the same time. Linus Torvalds suggested this idea.

Please check the individual patches for more details.

thanks,

 - Joel

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/

Joel Fernandes (Google) (4):
mm/mremap: Optimize the start addresses in move_page_tables()
selftests: mm: Fix failure case when new remap region was not found
selftests: mm: Add a test for mutually aligned moves > PMD size
selftests: mm: Add a test for remapping to area immediately after
existing mapping

mm/mremap.c                              | 49 +++++++++++++++++
tools/testing/selftests/mm/mremap_test.c | 69 +++++++++++++++++++++---
2 files changed, 112 insertions(+), 6 deletions(-)

--
2.40.1.606.ga4b1b128d6-goog

