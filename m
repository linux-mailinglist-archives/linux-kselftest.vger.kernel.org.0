Return-Path: <linux-kselftest+bounces-3148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5C830713
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90621C214A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A91EB51;
	Wed, 17 Jan 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpX0ZGGL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7914A87;
	Wed, 17 Jan 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498050; cv=none; b=fgztqRvbPpA1E8hvITjggYZG9nFy1IKHDidP24GFZVwWkmASBuFnBvFXPhnTSvMtJ7hg6CAtQOuphx6qX3ZbVJHpF0e4m3ry0WtrbJiWROX/i6aVJEKut7Mo8n64jXyBCin6ZjXjdTSwApijHXf37t2yt5fc3vYY+0qHVUe9D7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498050; c=relaxed/simple;
	bh=tywzkYCatCjvmllWPiu8+4g6b7SfayHdRCj5tZxD2aY=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key; b=YU/T4yaRXbrGU3fR+vqf7meorafhrYvUiOS/weYvqGx3W29JPyyYxT6q+DegA2RoYlLW0qjhNK36Lix4NssOKerhhHOu6fUkNJte1YWS6Z/JBwv8dkIcsr61OMYw+feA6adKYYYlpfKsHzieP7mbJeen3BeRvnv9vlJ/YOJJj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpX0ZGGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11054C433C7;
	Wed, 17 Jan 2024 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705498049;
	bh=tywzkYCatCjvmllWPiu8+4g6b7SfayHdRCj5tZxD2aY=;
	h=From:Date:Subject:To:Cc:From;
	b=BpX0ZGGLJIc2VX6MAPAWP7z8lbc2pUD9G3GIJvnD/QBB4AJhcD13u0IcVFtRRTs4o
	 zbbWuwpm7ltx7aX6lqt2fzbRxn0H7X4U6av8iHKDGYe/2OViwBWXEJXP3QuBiLJGf3
	 h+5suyjX+ZY4w1jyj06d4OQAv3NY1vXoHtx8IUCudYokO5SP/tbXculPc93dj/J3Xg
	 Z9ntMDKR9BtBuRF4tbJZjQ+qjMSv9fb2Gb/PFLO+w8UctMuTB7kivYkDLVfZO7Vryt
	 PaW+EmfdbUhc7iW65Izq9gp2izxQQkmjbZE125bGr+Bp1rJBtZWpzK78pCioxxffrl
	 JAwGSTZkWHlWw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 17 Jan 2024 14:27:15 +0100
Subject: [PATCH] selftests/hid: wacom: fix confidence tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-b4-wip-wacom-tests-fixes-v1-1-f317784f3c36@kernel.org>
X-B4-Tracking: v=1; b=H4sIALLVp2UC/x3LTQqAIBBA4avErBtQMfq5SrTQmmoWpThRQXT3p
 OXH4z0glJgEuuKBRCcLhz1DlwWMq9sXQp6ywShjldY1eosXR7zcGDY8SA7BmW8SNG3jK+XJ2Xq
 GvMdEf8h3P7zvByhu+wJqAAAA
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705498047; l=2088;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=tywzkYCatCjvmllWPiu8+4g6b7SfayHdRCj5tZxD2aY=;
 b=IWzV59t4VHpJ7UoQOlD9tX+ULtDRWbwucPyNMZaoHScUQLIkX976SUTV53Af6WvswqS+9spXf
 VyFYjlDA+cHDmmI1hVitU6gE/ZTGsokN+SQzQIOZ23xfYJPCb+hsILW
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The device is exported with a fuzz of 4, meaning that the `+ t` here
is removed by the fuzz algorithm, making those tests failing.

Not sure why, but when I run this locally it was passing, but not in the
VM.

Link: https://gitlab.freedesktop.org/bentiss/hid/-/jobs/53692957#L3315
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Over the break the test suite wasn't properly running on my runner,
and this small issue sneaked in.
---
 tools/testing/selftests/hid/tests/test_wacom_generic.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
index 352fc39f3c6c..b62c7dba6777 100644
--- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
+++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
@@ -880,8 +880,8 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         does not overlap with other contacts. The value of `t` may be
         incremented over time to move the point along a linear path.
         """
-        x = 50 + 10 * contact_id + t
-        y = 100 + 100 * contact_id + t
+        x = 50 + 10 * contact_id + t * 11
+        y = 100 + 100 * contact_id + t * 11
         return test_multitouch.Touch(contact_id, x, y)
 
     def make_contacts(self, n, t=0):
@@ -902,8 +902,8 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         tracking_id = contact_ids.tracking_id
         slot_num = contact_ids.slot_num
 
-        x = 50 + 10 * contact_id + t
-        y = 100 + 100 * contact_id + t
+        x = 50 + 10 * contact_id + t * 11
+        y = 100 + 100 * contact_id + t * 11
 
         # If the data isn't supposed to be stored in any slots, there is
         # nothing we can check for in the evdev stream.

---
base-commit: 80d5a73edcfbd1d8d6a4c2b755873c5d63a1ebd7
change-id: 20240117-b4-wip-wacom-tests-fixes-298b50bea47f

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


