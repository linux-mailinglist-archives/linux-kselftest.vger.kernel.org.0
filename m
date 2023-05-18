Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC167077F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 04:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjERCSr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 22:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjERCSq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 22:18:46 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB922139
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6238daae378so2863106d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684376325; x=1686968325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKe+AGy/Knc6S6d8Do5DN/gqM9Uy00SAbxH28Kp1LUQ=;
        b=gpiRUjEC25YrRlvGt299DCLZarxkVMlPppBRMeGjpsXJgixg9Mf1V9AuFtBCGh5WIO
         zYyRiKyN25sNF/Dcpz8SONWOiUN5ginUd3c7nz+IsRYtc1emCT1YYGJXOzWz7hQjxiRf
         eGy+COuTrQdS11tlfAZg8TDkFkoBJhCtLoMlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684376325; x=1686968325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKe+AGy/Knc6S6d8Do5DN/gqM9Uy00SAbxH28Kp1LUQ=;
        b=Bztokf+hCZ2xpAqc9C7DXtwiYf2rBfu0YkdunrGiUDAOQt5xN4E25xBMEMyXSIHLI0
         1skxuSEvPT/tS9U4osQ7ShApezMpdw0+DvcBcokvgwiVN2trVOKynlNesVB1Fz0y9Wxs
         OZTOgPylxRY9iKU1rJS835T8kkAtPSs/ypYgyZ6eIJjDxhIQ3CeByVWLpJvuIJtC/9gK
         IAnBV2x64pm0ZksgdMYRCp3r84Sk7Z40tkGkIHAUS5cvx0riuLWpynRtJHIDtJldK+NX
         5BMVABGOI8fPtP4G78Yss/JcX2aaZ4ZiuPhI6Ioi5kcz52gVnFmDU2+R5pW6U1Y8bjMk
         8USw==
X-Gm-Message-State: AC+VfDzfjo0atrTJylxfg1Lmo3lLgA2GO3Juxv1hxr/fJ0875BdUllGx
        iOLLYxXA/R1s3uF2KP49lCYPMg==
X-Google-Smtp-Source: ACHHUZ777yYcb28ukvf7wMe6arbQau3nQ7xByk5Y74MW/Ag+xPWbEEnjrqrm1N1GiSy28LtIBX+nRg==
X-Received: by 2002:a05:6214:2349:b0:5e8:3496:e641 with SMTP id hu9-20020a056214234900b005e83496e641mr2657341qvb.13.1684376324809;
        Wed, 17 May 2023 19:18:44 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a000d00b007577ccf566asm85082qki.93.2023.05.17.19.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 19:18:44 -0700 (PDT)
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
Subject: [PATCH RFC 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
Date:   Thu, 18 May 2023 02:18:22 +0000
Message-ID: <20230518021825.712742-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230518021825.712742-1-joel@joelfernandes.org>
References: <20230518021825.712742-1-joel@joelfernandes.org>
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

Recently, we see reports [1] of a warning that triggers due to
move_page_tables() doing a downward and overlapping move on a
mutually-aligned offset within a PMD. By mutual alignment, I
mean the source and destination addresses of the mremap are at
the same offset within a PMD.

This mutual alignment along with the fact that the move is downward is
sufficient to cause a warning related to having an allocated PMD that
does not have PTEs in it.

This warning will only trigger when there is mutual alignment in the
move operation. A solution, as suggested by Linus Torvalds [2], is to
initiate the copy process at the PMD level whenever such alignment is
present. Implementing this approach will not only prevent the warning
from being triggered, but it will also optimize the operation as this
method should enhance the speed of the copy process whenever there's a
possibility to start copying at the PMD level.

Some more points:
a. The optimization can be done only when both the source and
destination of the mremap do not have anything mapped below it up to a
PMD boundary. I add support to detect that.

b. #1 is not a problem for the call to move_page_tables() from exec.c as
nothing is expected to be mapped below the source/destination. However,
for non-overlapping mutually aligned moves as triggered by mremap(2),
I added support for checking such cases.

c. I currently only optimize for PMD moves, in the future I/we can build
on this work and do PUD moves as well if there is a need for this. But I
want to take it one step at a time.

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
[2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/mremap.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 411a85682b58..d7ee3b20e170 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	return moved;
 }
 
+/*
+ * A helper to check if a previous mapping exists. Required for
+ * move_page_tables() and realign_addr() to determine if a previous mapping
+ * exists before we can do realignment optimizations.
+ */
+static bool check_addr_in_prev(struct vm_area_struct *vma, unsigned long addr,
+			       unsigned long mask)
+{
+	int addr_masked = addr & mask;
+	struct vm_area_struct *prev = NULL, *cur = NULL;
+
+	/* If the masked address is within vma, there is no prev mapping of concern. */
+	if (vma->vm_start <= addr_masked)
+		return false;
+
+	/*
+	 * Attempt to find vma before prev that contains the address.
+	 * On any issue, assume the address is within a previous mapping.
+	 * @mmap write lock is held here, so the lookup is safe.
+	 */
+	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
+	if (!cur || cur != vma || !prev)
+		return true;
+
+	/* The masked address fell within a previous mapping. */
+	if (prev->vm_end > addr_masked)
+		return true;
+
+	return false;
+}
+
+/* Opportunistically realign to specified boundary for faster copy. */
+static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
+			 unsigned long *new_addr, struct vm_area_struct *new_vma,
+			 unsigned long mask)
+{
+	if ((*old_addr & ~mask) &&
+	    (*old_addr & ~mask) == (*new_addr & ~mask) &&
+	    !check_addr_in_prev(old_vma, *old_addr, mask) &&
+	    !check_addr_in_prev(new_vma, *new_addr, mask)) {
+		*old_addr = *old_addr & mask;
+		*new_addr = *new_addr & mask;
+	}
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -493,6 +538,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	old_end = old_addr + len;
 
+	/* If possible, realign addresses to PMD boundary for faster copy. */
+	if (len >= PMD_SIZE)
+		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+
 	if (is_vm_hugetlb_page(vma))
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 						new_addr, len);
-- 
2.40.1.606.ga4b1b128d6-goog

