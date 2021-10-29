Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B314401FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJ2Sgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhJ2Sgv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 14:36:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF77C0613F5
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:34:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v7-20020a25ab87000000b005c2130838beso583026ybi.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=aWdu1dWgU6LDlQT9WUgK1tbGyRaKD3AurTsATcx1ByY=;
        b=jtbbuakJZsRZNaPCbKbfFEJmOU9Uoi3SgTKnPTxiKpMGfnbaSlJy2stcE7VXQOgk3Y
         8bE9sTwZB4gVvZSs1w9ZbFbvJ0t1unK6DB/gzmQgkm6HgAOJEHv968FbY7hJajgtUNoY
         2BCnTRP2ZgFqaTEimHnrN4cHb3FYJnJ5ib+SWRJpS11KIYfX42ZpP9gP+7ctok3m4WCi
         zz6X2fY2YHn7qSqq5hKQ864OD25HPN/N2P2WJ6otYalY28oNO4h/iToCmZhKd39P8xPU
         aAfSZLHDuo6WjfoAbCXaTjT1jVku5v4UJomfxT54+0kxQMfJyGQQcUeYWtUq28iBayuR
         PxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=aWdu1dWgU6LDlQT9WUgK1tbGyRaKD3AurTsATcx1ByY=;
        b=t/ao4wcwe5in9WdxShFB2koLF03WOEc35+mZQbCHLIHZjFy3gYBFa9sVBxg9cHyUb9
         UnE2fSuPArADJHeDSCvcJZB0ZUjMehwnRHfGfw9cbwziBDzIcmw0wY+Qs5YPrLfxO1L6
         Kb9SYIUso9wtIx7tdOpUEhwsEFXA0pDg1azT73VfKvkkmTwEJhnWcXPtb0ObqFaCtt14
         B9bG5y7q2kj9istautyr5SKoXgfclM5NF8egSuez3I72ods12++y2GSMK2SFUf9CQe63
         cW+GdxOcdA+lr+8xMbe2Aj9SM9UENGYoSQa8nlMOChFIsOYnaZrNQ3kBLe0yuoZjqnJ5
         54iA==
X-Gm-Message-State: AOAM531q9e5h/fdeRRRdW2ARhfjxl9fsenUB/1mZ2k3TH/3f4RXOBZwP
        3+kzqd5ZiGS9l3T1Jv8fjpUA2Wgik0ZqA23sFg==
X-Google-Smtp-Source: ABdhPJxoOcfzYFe02j1Yvr53Nxi/e0BJwqCy7bwvJ5kG7TNG3tF0RFNwZgGROz2u207zvd8NZcELsX/MmPmadoPPMw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b03:1d88:1cf2:4973])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:402:: with SMTP id
 m2mr13884785ybp.422.1635532461875; Fri, 29 Oct 2021 11:34:21 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:33:29 -0700
In-Reply-To: <20211029183339.3216491-1-kaleshsingh@google.com>
Message-Id: <20211029183339.3216491-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211029183339.3216491-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 3/4] tracing/histogram: Document hist trigger variables
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the tracefs README to describe how hist trigger variables
can be created.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---

Changes in v2:
  - Add Masami's Acked-by.

 kernel/trace/trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bc677cd64224..c41b3786401d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5628,6 +5628,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_HIST_TRIGGERS
 	"      hist trigger\t- If set, event hits are aggregated into a hash table\n"
 	"\t    Format: hist:keys=<field1[,field2,...]>\n"
+	"\t            [:<var1>=<field|var_ref|numeric_literal>[,<var2>=...]]\n"
 	"\t            [:values=<field1[,field2,...]>]\n"
 	"\t            [:sort=<field1[,field2,...]>]\n"
 	"\t            [:size=#entries]\n"
@@ -5639,6 +5640,16 @@ static const char readme_msg[] =
 	"\t            common_timestamp - to record current timestamp\n"
 	"\t            common_cpu - to record the CPU the event happened on\n"
 	"\n"
+	"\t    A hist trigger variable can be:\n"
+	"\t        - a reference to a field e.g. x=current_timestamp,\n"
+	"\t        - a reference to another variable e.g. y=$x,\n"
+	"\t        - a numeric literal: e.g. ms_per_sec=1000,\n"
+	"\t        - an arithmetic expression: e.g. time_secs=current_timestamp/1000\n"
+	"\n"
+	"\t    hist trigger aritmethic expressions support addition(+), subtraction(-),\n"
+	"\t    multiplication(*) and division(/) operators. An operand can be either a\n"
+	"\t    variable reference, field or numeric literal.\n"
+	"\n"
 	"\t    When a matching event is hit, an entry is added to a hash\n"
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
 	"\t    sum called 'hitcount' is incremented.  Keys and values\n"
-- 
2.33.1.1089.g2158813163f-goog

