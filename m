Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39F760117E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJQOsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJQOsM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 10:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0189767C87
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 07:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4136113B
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 14:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17874C433D7;
        Mon, 17 Oct 2022 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018073;
        bh=vNP3GDP+dTei/h41iY7XScHfo9eD8dv4mbQThXgHuS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJXoBdhCj3bhhKqQ5+OVFIX66OLikQbkOOZwzIoPT7eB10DmDLSdd/vXY2y0iioOb
         w0dQjTITNerLmZAUeoo9JRsPSSo2TiBRT5SxAZ9lbVS/8KmSlhp9DM1r5PrIFCAnLT
         g2oCjUeWI7Etdmgi7UPOqr9G8IE13ylM9pdCwFb494EyDS1rY0fMsyURCVGWgwXXB/
         EA2WJuxdVXN+pzCEZvCeaYitwhXhZkEgxtykMbIq0h0sseyLYQx7ueUsvY5yWmSDGD
         w+1m+VHJabx8mvQT98QwNkYZuT6EylqpAaOnOn6m2Oni7glde1WETw/vubzvzGUepK
         tE1rTlsqIJz6g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] kselftest/arm64: Check that all children are producing output in fp-stress
Date:   Mon, 17 Oct 2022 15:45:52 +0100
Message-Id: <20221017144553.773176-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017144553.773176-1-broonie@kernel.org>
References: <20221017144553.773176-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446; i=broonie@kernel.org; h=from:subject; bh=vNP3GDP+dTei/h41iY7XScHfo9eD8dv4mbQThXgHuS0=; b=owGbwMvMwMWocq27KDak/QLjabUkhmTfrPlKUUdq/7Dt/ZxyfW7MTmmZJ4cnPv1p5r1YuSfmaZBk M+O3TkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIvMj2P/7K6W7Z2a5aEQxNLSfXG Rue3e1m+XVOk0uk9tGBvfNtXnPRV/x6v5cl9W99vmp+CzOxbOY38RX+Pxs79585O6+6UnJsRGyEfO2 il1/bRAefLBeIXxqgOa7Mucnh9a4ySz54/hIam59M4P0hISUR3/+5GfuDXQxPKZ+r992+bZnV6XFLT sPa9202rdIoe/ug/X7j71bcjONLajrNOubVU+a31yM+zZH3rdENVj10aWiK51pbzXvLDmRLpdU5pTF JVaxsrFWN0+1RsHwxa75ySKTUwJO/a+cUBBW9Th+w/qYMo2bTM7q8RG9RhUtatLtyTpPWRdqdUk3v+ fR7Gq/m27Z291+vPZq25ebRfOsAQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we don't have an explicit check that when it's been a second
since we have seen output produced from the test programs starting up that
means all of them are running and we should start both sending signals and
timing out. This is not reliable, especially on very heavily loaded systems
where the test programs might take longer than a second to run.

We do skip sending signals to children that have not produced output yet
so we won't cause them to exit unexpectedly by sending a signal but this
can create confusion when interpreting output, for example appearing to
show the tests running for less time than expected or appearing to show
missed signal deliveries. Avoid issues by explicitly checking that we have
seen output from all the child processes before we start sending signals
or counting test run time.

This is especially likely on virtual platforms with large numbers of vector
lengths supported since the platforms are slow and there will be a lot of
tasks per CPU.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 4e62a9199f97..35dc07648d52 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -403,6 +403,8 @@ int main(int argc, char **argv)
 	int timeout = 10;
 	int cpus, tests, i, j, c;
 	int sve_vl_count, sme_vl_count, fpsimd_per_cpu;
+	bool all_children_started = false;
+	int seen_children;
 	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
 	struct epoll_event ev;
 	struct sigaction sa;
@@ -526,6 +528,27 @@ int main(int argc, char **argv)
 
 		/* Otherwise epoll_wait() timed out */
 
+		/*
+		 * If the child processes have not produced output they
+		 * aren't actually running the tests yet .
+		 */
+		if (!all_children_started) {
+			seen_children = 0;
+
+			for (i = 0; i < num_children; i++)
+				if (children[i].output_seen ||
+				    children[i].exited)
+					seen_children++;
+
+			if (seen_children != num_children) {
+				ksft_print_msg("Waiting for %d children\n",
+					       num_children - seen_children);
+				continue;
+			}
+
+			all_children_started = true;
+		}
+
 		for (i = 0; i < num_children; i++)
 			child_tickle(&children[i]);
 
-- 
2.30.2

