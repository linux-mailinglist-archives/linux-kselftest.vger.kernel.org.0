Return-Path: <linux-kselftest+bounces-825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ED77FDB35
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DD1282BB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6127374FF;
	Wed, 29 Nov 2023 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGCduNII"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A033032E;
	Wed, 29 Nov 2023 15:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34D4C433CB;
	Wed, 29 Nov 2023 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271507;
	bh=kG2+ej6cJ+ghQo+0P11j+c5Gws+B/g/6ONT5dR7kBSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dGCduNIIvZgqq/TxuYMezF3tHg4UfzJwkO+QFU+etNx5EnXi07/Dq/aHCLz5bQzqu
	 gK9S/QFt7JL+C3Pw8OcXQ87oMJ47zQu7+pjtlmEvITlVIbzQm2JrmWf6/+nmUkP3ei
	 48NIvmprJGh8PHWIGPSIkreSxwNU6dSty+MOxBErDg7y53pMTifxQPTeCRBnV8HQoY
	 lrEs1zX8tXjYCh8sdzhrL3rczWjkrjGNKX+62qTgcpCcT6+MDHCbOBfPWbB0JeCdxE
	 q+4/+TJh42PO2n+dmLa7RUMdn56EBVFUDhr8aQB/dwvilxA+g/qkGw0nttTgwOtdne
	 nzqoAeVbNJyLg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 29 Nov 2023 16:24:28 +0100
Subject: [PATCH 03/12] selftests/hid: base: allow for multiple
 skip_if_uhdev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-3-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1211;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=kG2+ej6cJ+ghQo+0P11j+c5Gws+B/g/6ONT5dR7kBSg=;
 b=cRFybPnwZ68SH5mCbsRVxDJcFgImN6Y5PIICvbba808TbqdFz1Ch3p8CQc+UIyA6tVhJaY+bY
 zLd5oD03G7bD+zF5g/bCAs6eMhzDrtSDwOw2wyqAvs2ZkwA226KbLuS
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We can actually have multiple occurences of `skip_if_uhdev` if we follow
the information from the pytest doc[0].

This is not immediately used, but can be if we need multiple conditions
on a given test.


[0] https://docs.pytest.org/en/latest/historical-notes.html#update-marker-code

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/base.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
index 1305cfc9646e..5d9c26dfc460 100644
--- a/tools/testing/selftests/hid/tests/base.py
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -238,8 +238,7 @@ class BaseTestCase:
             try:
                 with HIDTestUdevRule.instance():
                     with new_uhdev as self.uhdev:
-                        skip_cond = request.node.get_closest_marker("skip_if_uhdev")
-                        if skip_cond:
+                        for skip_cond in request.node.iter_markers("skip_if_uhdev"):
                             test, message, *rest = skip_cond.args
 
                             if test(self.uhdev):

-- 
2.41.0


