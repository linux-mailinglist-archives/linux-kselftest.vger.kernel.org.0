Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBB01E64AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbgE1Owq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 10:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403790AbgE1Owm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 10:52:42 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A952075F;
        Thu, 28 May 2020 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590677561;
        bh=czaYCN6eqWR7GuJTWJzQRoAJaa0eRrF2WnNBmRdRUT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kcklip7nlRYJiaSCAQqnvdJk3dX5xAuRoJWISKrM3l/KvJx4NYK6CCDylh6Ixk6/E
         VNVQqi4y4iariGF3FywLKVijz/1eMcJIc2uAVquqpnPkmHkoijd+eYz4zJ+9cwkrHH
         Y4+Pyw6sRxcZENcEkPoOmF2929/8glkEOQ9dzwv4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: [PATCH 4/4] selftests/sysctl: Make sysctl test driver as a module
Date:   Thu, 28 May 2020 23:52:37 +0900
Message-Id: <159067755690.229397.12060049846042042480.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159067751438.229397.6746886115540895104.stgit@devnote2>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix config file to require CONFIG_TEST_SYSCTL=m instead of y
because this driver introduces a test sysctl interfaces which
are normally not used, and only used for the selftest.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/sysctl/config |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
index 6ca14800d755..fc263efd1fad 100644
--- a/tools/testing/selftests/sysctl/config
+++ b/tools/testing/selftests/sysctl/config
@@ -1 +1 @@
-CONFIG_TEST_SYSCTL=y
+CONFIG_TEST_SYSCTL=m

