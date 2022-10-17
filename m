Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1D60117D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJQOsQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJQOsF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 10:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4996717D
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 07:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DDD061008
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 14:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEC9C433D6;
        Mon, 17 Oct 2022 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018075;
        bh=ZVvUXIhqJm/uKkg8FYlsvUX5mawG4++l48pgUS7RNAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ib0Dbq95q9MYm2X4+E8MXBefbS/Acs6dLG2xCE1YUQeXpb8Wa4M2cXF2zcD9ocrkh
         qctb3ZmlX6+Lcrbb51taIh1q7NC7rWV9gMztg7q0YvqmROMnMMbMhNPZpf78pIeT+n
         KwDKWaZO9ZArpcgd6TSfEJyRqPC9dxnh+XG7YOmdyE6sUKlkHwm1HM16I3tOmkgLl8
         mj1N6+4MBEdxBepavEJIyG8Y3Kz1x4ev3BVXidHf/vHwx3RG3wxsadXxUD8fHwe4Rz
         lWYItFY0Q7Nxc3XxkbdJOh5G98B1Rw3PQ8MSMkI4xLarHNHShy2rptr5hRMUdbErer
         B/UCUsYI8rLQg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] kselftest/arm64: Provide progress messages when signalling children
Date:   Mon, 17 Oct 2022 15:45:53 +0100
Message-Id: <20221017144553.773176-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017144553.773176-1-broonie@kernel.org>
References: <20221017144553.773176-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=broonie@kernel.org; h=from:subject; bh=ZVvUXIhqJm/uKkg8FYlsvUX5mawG4++l48pgUS7RNAg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTWqgKpbpn9mD2/oWFeT8NrlwFf72qX5bXgX624Ai oiY7OByJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01qoAAKCRAk1otyXVSH0GMuB/ wNONKQXc4DRqN0tD1qzhDuGmXpsll0OQyQ40XO73E3XUXN1Zv1sjO+i1WHI1aX+q/DFmc8QmeCjlVp xbiYxAXhJmqlcvMwZ0SDlTFu7tCLVx1BFA62YxN3tGDm8uSUekFGbQg9KxZT5SCzSo7qXa36HCaZ/R 7YgXt6tCrKEIMOcCZvSEeoyPD8mM9yod9T51bgi4jBIT967utFNkHtJZ5RKW3O9XqFjIu87BHlRFeY P3pnOcNZhJ12zJAXn/BiVDff5pehdsuWK0Gni8Q6UATJ8VDlFQHFBCLfM8/A7Xzb6/nD1t2ghj6j7W KwxnVJtv9RKRk2Ebx0rRUqgu+R1M7X
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

Especially when the test is configured to run for a longer time it can be
reassuring to users to see that the supervising program is running OK so
provide a message every second when the output timer expires.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 35dc07648d52..ccbfcf847d96 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -549,6 +549,9 @@ int main(int argc, char **argv)
 			all_children_started = true;
 		}
 
+		ksft_print_msg("Sending signals, timeout remaining: %d\n",
+			       timeout);
+
 		for (i = 0; i < num_children; i++)
 			child_tickle(&children[i]);
 
-- 
2.30.2

