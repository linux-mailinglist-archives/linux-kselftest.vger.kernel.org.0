Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AA35B336
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 06:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfGAEEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 00:04:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36353 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfGAEEX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 00:04:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so5863706pfl.3
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Jun 2019 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qXJPxYAnauV783BSNoiICPinJN47nYOdh3JYZXZjUY=;
        b=lKcpczd8fUzta/BytKyak8CozJjmS5tCRzUTEv7mLNT8zw7YgStF/XAgnGdAP2pwax
         xnveCcblDRFDpvtyjwBbp/bOevnuA5Ka6sAk57SBUNuX86/3VqlUdGHa5mEF1FP+4z3x
         pNELFZvs3hzcgfYvTPzZ0RwViUMV0VgjX+jNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qXJPxYAnauV783BSNoiICPinJN47nYOdh3JYZXZjUY=;
        b=c0k021xIX3sf2fSw5o/TNF2PWE+du7tzunGNKtZ9Swe75igIo9z5cYvLIt5VAvSFRd
         cWjEXSX/Uq6UYRoDsI0D0XKVifliGJDNldMDPvR/Wb0rNkEXAdl+ORbqS8/XUU1llBgx
         8Aiv1eoNQ0+BmjElJWGf4875umufTVcZCKe85YPQ9/YbcJagQPGjNny34feu8+Bn4ncw
         VWooedve98la0GUExPKxn/tXAPcFfK5UdO3qF+Ab/we/YgzTlesbVpxFpmxgR7d3HWpu
         uxp610h9xqcD+8JkAiLNlxC6gTK4GA76N9lUpiF5O2XSAdROhr5wBMLZXTtcoKfPnRbi
         1EsA==
X-Gm-Message-State: APjAAAUv7z0hjgXHM3P4YH/zsXNB8CjZ7EwnA5MBPVXZGQuJuhsVHQSI
        DSI/z+If1DEj7F1dN/sqS6POpg==
X-Google-Smtp-Source: APXvYqwMPLyTUUEqZ2JAh0LEcgaDjLdoe3238I5iJJhjH9Ia8lGZLiH73Xc8d2j9wopbeCVOqGOeFQ==
X-Received: by 2002:a17:90a:1c17:: with SMTP id s23mr28762222pjs.108.1561953863102;
        Sun, 30 Jun 2019 21:04:23 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w1sm10841305pjt.30.2019.06.30.21.04.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 21:04:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC 2/3] rcu: Simplify rcu_note_context_switch exit from critical section
Date:   Mon,  1 Jul 2019 00:04:14 -0400
Message-Id: <20190701040415.219001-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701040415.219001-1-joel@joelfernandes.org>
References: <20190701040415.219001-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The rcu_preempt_note_context_switch() tries to handle cases where
__rcu_read_unlock() got preempted and then the context switch path does
the reporting of the quiscent state along with clearing any bits in the
rcu_read_unlock_special union.

This can be handled by just calling rcu_deferred_qs() which was added
during the RCU consolidation work and already does these checks.

Tested RCU config TREE03 for an hour which succeeds.

Cc: rcu@vger.kernel.org
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_plugin.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bff6410fac06..ebb4d46a6267 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -313,15 +313,6 @@ void rcu_note_context_switch(bool preempt)
 				       ? rnp->gp_seq
 				       : rcu_seq_snap(&rnp->gp_seq));
 		rcu_preempt_ctxt_queue(rnp, rdp);
-	} else if (t->rcu_read_lock_nesting < 0 &&
-		   t->rcu_read_unlock_special.s) {
-
-		/*
-		 * Complete exit from RCU read-side critical section on
-		 * behalf of preempted instance of __rcu_read_unlock().
-		 */
-		rcu_read_unlock_special(t);
-		rcu_preempt_deferred_qs(t);
 	} else {
 		rcu_preempt_deferred_qs(t);
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

