Return-Path: <linux-kselftest+bounces-39273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD32B2B73A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 04:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F3527957
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B66287275;
	Tue, 19 Aug 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbqWabv3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3B219313;
	Tue, 19 Aug 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571558; cv=none; b=oxjiuQT9ouKbSy5G+ekxwL3Yx4ANqidv0UTlVAda2oUfIDlE+DHfwjZNfFQ+ESr7WLvNcUFlbRlhlURbQ3aU/YZ8nUklSrz7U7eWpYnF0JdkqrOQ9CuQ335gW4vOLpU7OZp9WVojkV0r/BMWt9G+1SMQ8Y+IMoDOAgl6sUGRnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571558; c=relaxed/simple;
	bh=opA+9G7a6pm7Ukx4ygWDa+18cnwyybIAZesL/1UB1yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F6tvyqDOuKmiD5cXJr2vBpX2tX1urwiZE2Ssac+GjLjOH8THxbRh9LeKTRpBcgab6PmvJVJZDWq44GsWtQl1vN/1frNGoA+0lQyGtPsC+wOCPPFLLZxrUeFUosNeeuz8JbIBH5QvjvFIdMCZ13KhBrUPVzxXny2QPDEtuAWdv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbqWabv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70FCCC4CEEB;
	Tue, 19 Aug 2025 02:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755571558;
	bh=opA+9G7a6pm7Ukx4ygWDa+18cnwyybIAZesL/1UB1yA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VbqWabv3EnHqF6C64W0HU6OlJFpJKAoDL9j1c6O0hJaBzgCP3LjF8+cy5TfCD9yh7
	 bZhtZggS7qkT09fHTyyr27gvIbCErX/3Ymt/fRN8Up6MCPg78H8CCcFwg5OB/ZZSPA
	 kdrB2Gqtd/nJ/CRv+YzZweE6CnXN8ebPc/8W5hmx1YDPjmWyjbC2fBpPW2/uH+MlRG
	 m9qdI9bnz5rfltronUyu+TrWgHoz6ejLS/OY+B3Mp4gJCceBiBsupBN8A3DwJvhSdA
	 5OYea43MIjUfN5f4BEMJ44ZME3KzXrJUVAJbPrSJ46m/IYKI7AgY2acUAfnpPEh01o
	 LStQloIjN7Ckg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5BACA0EEB;
	Tue, 19 Aug 2025 02:45:58 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Tue, 19 Aug 2025 10:45:57 +0800
Subject: [PATCH] selftests: net: fix memory leak in tls.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-memoryleak-v1-1-d4c70a861e62@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAGTlo2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NL3dzU3PyiypzUxGxdy5Sk1GTLxDSzZANzJaCGgqLUtMwKsGHRsbW
 1APHd1ZpcAAAA
X-Change-ID: 20250819-memoryleak-9dbec9af6c07
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com, 
 niecheng1@uniontech.com, guanwentao@uniontech.com, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755571557; l=1183;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=bJ2O1uJkJydfjBXKxT0NanxgQaONGN6lDC7g+1imYiw=;
 b=xzQfIUFyWMrFvujCffyv+PN8PbAoSZ2gVir4MYYu1oaGPhjxkT884zXmNyYRWxQMZ4Rumu7Ms
 XYBWpUhR09bAYeg8F5B+p2tk283oVjxbzbsV8eaet43ZEfxXqNBY/Sy
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

To free memory and close fd after use

Suggested-by: Jun Zhan <zhanjun@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 tools/testing/selftests/net/tls.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index d8cfcf9bb82594ca078c998ce5849131bf46ade8..23cf6ff5fa49378bd7906334ff402aa61a205f29 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -427,6 +427,8 @@ TEST_F(tls, sendfile)
 	EXPECT_GE(filefd, 0);
 	fstat(filefd, &st);
 	EXPECT_GE(sendfile(self->fd, filefd, 0, st.st_size), 0);
+
+	close(filefd);
 }
 
 TEST_F(tls, send_then_sendfile)
@@ -448,6 +450,9 @@ TEST_F(tls, send_then_sendfile)
 
 	EXPECT_GE(sendfile(self->fd, filefd, 0, st.st_size), 0);
 	EXPECT_EQ(recv(self->cfd, buf, st.st_size, MSG_WAITALL), st.st_size);
+
+	free(buf);
+	close(filefd);
 }
 
 static void chunked_sendfile(struct __test_metadata *_metadata,

---
base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
change-id: 20250819-memoryleak-9dbec9af6c07

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



