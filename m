Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F87DB5A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 10:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjJ3JDT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 05:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjJ3JDS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 05:03:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC7AB
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 02:03:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f70391608so1738548f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698656594; x=1699261394; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5DNReJrJjqC3ApxSGU7LvngHjOHwZujFq9jNZRCwZ0=;
        b=Knd5/ZgAFGenFoFuAX7lFdY109eZxtGViHvleFy7dLLDhOiLL79k0FB1rSBURa9pH7
         TB/q2FvPRvQSiV+BzeM7IcaaIqZpJDtxX+t6+VDxjcPpu8XxDlWm2SbOJ9QP2myufPzi
         etgcWbbODMVYhY1R5EXonoHqiyDmaBp0xmeUNmIR0cONhDDr7tr/MVsaE66Qt/BLqfsy
         CzBIbiY7AWA4JHeMthpQLCqvonXWIP5qYT2++wa4+6gFtXjdVHBQg3bbIWWtNc8O0IUM
         qrxXCsSFz55cHalcAySHn15CkVNRJ3AR1ORGdxDOWFnuBjLcHT+/rloVhGptMwvlaSbV
         m4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656594; x=1699261394;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5DNReJrJjqC3ApxSGU7LvngHjOHwZujFq9jNZRCwZ0=;
        b=M8tVY+aFpbAgjxWR9O+LzHJj6ejytCERFYEcT7exSPDE3EL1KEo8W0ZVOpk5QzBuyi
         6+Dbr55+OZbLO/j0qHCE46eWFH8DLhOHO4AuSGWarKxmXsczb7mRHwRlRcfin9qRnSpj
         2MrGsaBL3nVLIp133tHRXkqhBbhrMJIn3S9NYggSp7jCQongeW9F28z3q1etu9otpo3i
         hLPCA0afjrb0ey4rvYeKllelAmzhniOKVcQIuGYaS3NW/z8rLnE2s69enDL+h+OcQAOF
         FDLACgqrSm2FZ8Nv1X4nwYrZvS1Tl/OWP9UcxsvOpWOdBn6K4m2ID1xJ+DL7ij7i6t1R
         hTXQ==
X-Gm-Message-State: AOJu0YxKWJ8fTXXML0oMCZUkTysdMKrMatCXM9FoWnYuTCRoNdTYLmKk
        xft66A6LX5iMzTqVY5tIwloGwg==
X-Google-Smtp-Source: AGHT+IEhsz4/79n5D4u1uifu9B339uC6hyL43ZVUwHGiKOTkc6qwKZ4xELMfYIeVLRV4xprg4rCGaQ==
X-Received: by 2002:adf:f18a:0:b0:32d:ac49:2bb1 with SMTP id h10-20020adff18a000000b0032dac492bb1mr7477941wro.63.1698656593914;
        Mon, 30 Oct 2023 02:03:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6ac9000000b0032d687fd9d0sm7701427wrw.19.2023.10.30.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:03:13 -0700 (PDT)
Date:   Mon, 30 Oct 2023 12:01:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kv-team <kv-team@linaro.org>
Subject: [RFC] drm/tests: annotate intentional stack trace in
 drm_test_rect_calc_hscale()
Message-ID: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have started printing more and more intentional stack traces.  Whether
it's testing KASAN is able to detect use after frees or it's part of a
kunit test.

These stack traces can be problematic.  They suddenly show up as a new
failure.  Now the test team has to contact the developers.  A bunch of
people have to investigate the bug.  We finally decide that it's
intentional so now the test team has to update their filter scripts to
mark it as intentional.  These filters are ad-hoc because there is no
standard format for warnings.

A better way would be to mark it as intentional from the start.

Here, I have marked the beginning and the end of the trace.  It's more
tricky for things like lkdtm_FORTIFY_MEM_MEMBER() where the flow doesn't
reach the end of the function.  I guess I would print a different
warning for stack traces that can't have a
"Intentional warning finished\n" message at the end.

I haven't actually tested this patch...  Daniel, do you have a
list of intentional stack traces we could annotate?

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 2 ++
 include/kunit/test.h                  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 76332cd2ead8..367738254493 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -409,8 +409,10 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	START_INTENTIONAL_WARNING();
 	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	END_INTENTIONAL_WARNING();
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 20ed9f9275c9..1f01d4c81055 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -337,6 +337,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
 void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin);
 void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr);
 
+#define START_INTENTIONAL_WARNING() pr_info("Triggering a stack trace\n")
+#define END_INTENTIONAL_WARNING() pr_info("Intentional warning finished\n")
+
 #if IS_BUILTIN(CONFIG_KUNIT)
 int kunit_run_all_tests(void);
 #else
-- 
2.42.0

