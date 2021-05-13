Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1ED37FE38
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhEMTha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhEMTh1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:37:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF9C0613ED
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v184-20020a257ac10000b02904f84a5c5297so32382995ybc.16
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j4dTw95drqrKGLsIzhqWyfJoN7fFkyBDIWTnc+mWSdg=;
        b=Ejb4cU4h1LlcI/oT1K/A5w2fgdKUJHpJYumrHixERrRE06tFFtHbY8zPw+al7C3ica
         jAbc+9YW4ZS1P7Z4PLDwiqcW7m13nT3teIOer9bRXjopVpt7KZ8kNNj14B8L6X7mHbvU
         QvZG0xYgun1nQ3igBEERk+GbJJdFabQ/dcthTsO5QSOOAZJTKLJL7B5VPjArFF1shOOU
         SFyxFdyVeyC6Fd2kdzuVGP5v2U3Zx1hLv8JocEZQfyqQna8pDi0Ev1EbmykdzZoZLVzj
         78eHA/SIEkard36oRBOACYKPCZmyMn8SqpB/OUeAjiqyjZElHFmaVYF2TeY+ZWfK4X4t
         6doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j4dTw95drqrKGLsIzhqWyfJoN7fFkyBDIWTnc+mWSdg=;
        b=GGaYN+y8QbgeihUFwOvtldt85dTyOnwJTTUxmBHWypQyG9aOgGn3t1J3oIAAsZp9j3
         kaSEbesPgZ0AnccE4LCrHdkyaI3cqeNO7ze3LGaGLaZiusxhhEtsYJFLHKNthSTqiBD2
         yXfkHvMyrH1ditJBlYkFH1+W79vuV7XseYnji5Bf1LtvrwfRA8XbFi32VwdEv/p+Zf9d
         +M691r+mBoqcRovoul1wSfcMrs7vhyM5/+Lv15Z4mhRyV+f3v6zA+VV9ZpojkzmiiXKT
         PFKGOdjMLBVWPBwNX+PSQCFzbA8b+4dpEcpQH89xwmCfAnndLdD3s5ZOSZD8inaYMCvV
         pg6g==
X-Gm-Message-State: AOAM533Cdf9jJx8sX08NUT8kaTzMehuTjH3wzr2vX58UsnZYB4BMa8Uf
        8MIFFIB4FFVVylS/3zMCHc//eHBWf3C4sw==
X-Google-Smtp-Source: ABdhPJwb3SJWr+n53AlRXUSWKNV2MkP1AkHI2ru+bAbYlY+9M+fpeI2waMBEfCqxfZTXZ83g9OKt2+0A2s0g8Q==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a25:6188:: with SMTP id
 v130mr16460583ybb.20.1620934575080; Thu, 13 May 2021 12:36:15 -0700 (PDT)
Date:   Thu, 13 May 2021 12:32:01 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-7-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 07/10] thunderbolt: test: Remove sone casts which are no
 longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With some of the stricter type checking in KUnit's EXPECT macros
removed, several casts in the thunderbolt KUnit tests are no longer
required.

Remove the unnecessary casts, making the conditions clearer.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 drivers/thunderbolt/test.c | 152 ++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 87 deletions(-)

diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 5ff5a03bc9ce..247dc9f4757e 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -384,20 +384,18 @@ static void tb_test_path_single_hop_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i--;
 	}
 
@@ -443,20 +441,18 @@ static void tb_test_path_daisy_chain_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i--;
 	}
 
@@ -506,20 +502,18 @@ static void tb_test_path_simple_tree_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i--;
 	}
 
@@ -590,20 +584,18 @@ static void tb_test_path_complex_tree_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i--;
 	}
 
@@ -693,20 +685,18 @@ static void tb_test_path_max_length_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
-				test_data[i].type);
+		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
 		i--;
 	}
 
@@ -780,7 +770,7 @@ static void tb_test_path_not_bonded_lane0(struct kunit *test)
 
 	path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -789,12 +779,10 @@ static void tb_test_path_not_bonded_lane0(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
-				test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
-				test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -842,7 +830,7 @@ static void tb_test_path_not_bonded_lane1(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -851,12 +839,10 @@ static void tb_test_path_not_bonded_lane1(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
-				test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
-				test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -922,7 +908,7 @@ static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -931,12 +917,10 @@ static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
-				test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
-				test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -1002,7 +986,7 @@ static void tb_test_path_not_bonded_lane1_chain_reverse(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -1011,12 +995,10 @@ static void tb_test_path_not_bonded_lane1_chain_reverse(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
-				test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
-				test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -1094,7 +1076,7 @@ static void tb_test_path_mixed_chain(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -1103,12 +1085,10 @@ static void tb_test_path_mixed_chain(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
-				test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
-				test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -1186,7 +1166,7 @@ static void tb_test_path_mixed_chain_reverse(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -1195,12 +1175,10 @@ static void tb_test_path_mixed_chain_reverse(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
-				test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
-				test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -1230,10 +1208,10 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	up = &dev1->ports[9];
 	tunnel1 = tb_tunnel_alloc_pci(NULL, up, down);
 	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel1->type, (enum tb_tunnel_type)TB_TUNNEL_PCI);
+	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel1->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[1].out_port, up);
@@ -1245,10 +1223,10 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	up = &dev2->ports[9];
 	tunnel2 = tb_tunnel_alloc_pci(NULL, up, down);
 	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel2->type, (enum tb_tunnel_type)TB_TUNNEL_PCI);
+	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel2->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[1].out_port, up);
@@ -1282,10 +1260,10 @@ static void tb_test_tunnel_dp(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[1].out_port, out);
@@ -1328,10 +1306,10 @@ static void tb_test_tunnel_dp_chain(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[2].out_port, out);
@@ -1378,10 +1356,10 @@ static void tb_test_tunnel_dp_tree(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 4);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[3].out_port, out);
@@ -1443,10 +1421,10 @@ static void tb_test_tunnel_dp_max_length(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 13);
 	/* First hop */
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
@@ -1499,10 +1477,10 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	up = &dev1->ports[16];
 	tunnel1 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel1->type, (enum tb_tunnel_type)TB_TUNNEL_USB3);
+	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel1->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[1].out_port, up);
@@ -1514,10 +1492,10 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	up = &dev2->ports[16];
 	tunnel2 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel2->type, (enum tb_tunnel_type)TB_TUNNEL_USB3);
+	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel2->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[1].out_port, up);
@@ -1618,10 +1596,10 @@ static void tb_test_tunnel_dma(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 2);
 	/* RX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 1);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, port);
@@ -1661,10 +1639,10 @@ static void tb_test_tunnel_dma_rx(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 2);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)1);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 1);
 	/* RX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 1);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, port);
@@ -1698,10 +1676,10 @@ static void tb_test_tunnel_dma_tx(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 2, -1, -1);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)1);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 1);
 	/* TX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 1);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, nhi);
@@ -1744,10 +1722,10 @@ static void tb_test_tunnel_dma_chain(struct kunit *test)
 	port = &dev2->ports[3];
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 2);
 	/* RX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, port);
@@ -1906,7 +1884,7 @@ static void tb_test_property_parse(struct kunit *test)
 
 	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0xa27);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
@@ -1914,7 +1892,7 @@ static void tb_test_property_parse(struct kunit *test)
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0xa);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
 
 	p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
 	KUNIT_ASSERT_TRUE(test, !p);
@@ -1927,19 +1905,19 @@ static void tb_test_property_parse(struct kunit *test)
 
 	p = tb_property_find(network_dir, "prtcid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x1);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcvers", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x1);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcrevs", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x1);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcstns", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x0);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x0);
 
 	p = tb_property_find(network_dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_EXPECT_TRUE(test, !p);
@@ -1960,7 +1938,7 @@ static void tb_test_property_format(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, dir != NULL);
 
 	ret = tb_property_format_dir(dir, NULL, 0);
-	KUNIT_ASSERT_EQ(test, ret, (int)ARRAY_SIZE(root_directory));
+	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
 
 	block_len = ret;
 
@@ -2063,7 +2041,7 @@ static void tb_test_property_copy(struct kunit *test)
 
 	/* Compare the resulting property block */
 	ret = tb_property_format_dir(dst, NULL, 0);
-	KUNIT_ASSERT_EQ(test, ret, (int)ARRAY_SIZE(root_directory));
+	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
 
 	block = kunit_kzalloc(test, sizeof(root_directory), GFP_KERNEL);
 	KUNIT_ASSERT_TRUE(test, block != NULL);
-- 
2.31.1.751.gd2f1c929bd-goog

