Return-Path: <linux-kselftest+bounces-46163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87069C76D7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 02:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA6454E4DBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3393272E45;
	Fri, 21 Nov 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="kZI5MxAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pHi4dfYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B96381AF;
	Fri, 21 Nov 2025 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687263; cv=none; b=ihZL6ITIVw1HaYNdQw9GE8hdoYxP72bYSMFYZI+RjdXNOSGg0IMpovfV3YegVmcYPl0qF0oD3uKmx+HXmK6rowC9H/VV0QFpRYt6CDM0EExef9jZDuRg5nPi20hoBcKtyMK69uGSHD9njRkWmSBV6ydKJXgJRHvKkfH0EXxTZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687263; c=relaxed/simple;
	bh=fQfZ3bxD/S+hRVj/cWNhZRvET046tgfhHw/kZkeYAeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCYPhUZDJ8mNy94DxbZduJAMBUMReo6YlEjnwinUsMBvF0cv4svdSw4UrFc+cCNnvx1NdhkmdUJdgkXgkGT2ap8oL9FjO7Jnm9jJ+xJa56lT+k+pQPgtDyABNro2hrVTezfKaxwEFG9i/Rj9PSpC3dFfTdvIqjoI+bF7PVsDpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=kZI5MxAs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pHi4dfYS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A1C5B1D00238;
	Thu, 20 Nov 2025 20:07:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 20 Nov 2025 20:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763687260;
	 x=1763773660; bh=H5bUK2RPSuk/U3cKqzetAtWj+ditPSaDuPILFklbIsk=; b=
	kZI5MxAsgVVJw3reTU924nftxxchfCHxAWxgZHH8rNEODnc0KOlsp6H3mXmtfYe0
	H3Mc1qA4Icftdw3JB/+82IBtGGhNwpnNkWNU6/uBmfkS3qihvgO16EWlkA5ByFD3
	g3M4yxUNg1KK+we9mI7eFup7fspGG9QeE32IP5CDLCUyAKbKAp8dexubMaXZLmCO
	QPWTZKFp6N1cpH4u1+dEFaRrm2W/vL/ESW/maHsMyZsX6QQJ0ruKkpw68xuHJMhA
	QhbYhCeX9/kzHssXjbSwrbVA5l0syXJcV8XK107wMQymnMgliyOudUSA2cOmLX7i
	PMhUNoltzO/aEqp4Oyl3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763687260; x=
	1763773660; bh=H5bUK2RPSuk/U3cKqzetAtWj+ditPSaDuPILFklbIsk=; b=p
	Hi4dfYSViJ3UB3lToJtD5oNF7S3zMIiL+X/iJq2uwSkN58AosI22d0XPfMJ1sacS
	BhJaWyl9pt5iU7IhjHbyVFugtNh5f1vo0eumWbHkZHMnEAFTIT0+CPnXqBbLmyNW
	saMq6ZEHXaqlkGhpXe74xlUlaqDZm8ROli0+jtvrunqmbT440QODrIeO002JN8eU
	yasC+zRIvii0MI440Tn4sk1048UrxC2rY7MIdXajAvaPGEkIJb1jc3enSyxb92I3
	js2QUJriSF2XlXn/KXFYjh3pn/S3/H57FarRIMYhmy4Rpq4+gzARsXfCmxCPykAI
	RtFrTW2xZVSmTLy5mhWew==
X-ME-Sender: <xms:XLsfaYCulbhcjzVB8mn3WZF15Y5DmL5B-CRx5Ew4kxlx7uAV3m36ww>
    <xme:XLsfaa8CJAL5vnNi9PLIrs-pstFnB2h66KFZOUb9tCSvfKpjp8R_VGA8xf3H9ov8K
    BIjQ0czhTnTg75M_EjLofoUxZTzWEy7lqDacfSXegAVwVNDgNCugis>
X-ME-Received: <xmr:XLsfacRaGUjrgbHGJqixmMWppI4OS94cwOZm_AwkumxxX0tubQtwxRxLZg9CBIxcl4AOTy3WUTOCnPxF8LZv_mjd2JeXIuAubg3rK4Yv6zzK9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrvghtvghr
    ucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
    eqnecuggftrfgrthhtvghrnheptdetffeliefgueeuudfgkeeiveektddufeetjeelveef
    gfeiheeggeekjedtvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtpdhnsggp
    rhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhurghhse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehvrgguihhmsegtihhrqhhuvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtpdhrtghpthhtohepjhhi
    khhosheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XLsfaWWk05YBsxAUUNMS4U0STd_liQq7sGerQWkQgAwZ2YGGe2v3BA>
    <xmx:XLsfaeT1kfQvg2ENPXAcX-gY5H7iNk_Fv0F3uBzVj-7kJ_UFpA1HFA>
    <xmx:XLsfaW2LtdvbOusAUPMNtUsk54znw3ImRg2E8RMVaaZQ6KBKx1CVOw>
    <xmx:XLsfaWcjKhLw9jkWWkOqtfAMqyPJQOcy4dSm9LoMvMCWvbLmti74OA>
    <xmx:XLsfaaOMnWDrZ4kRwS1xlvy8n9lqFtDVMQOS4mtm8UGuUDjV_AzOzu3e>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 20:07:37 -0500 (EST)
From: Peter Hutterer <peter.hutterer@who-t.net>
Date: Fri, 21 Nov 2025 11:07:11 +1000
Subject: [PATCH 1/3] selftests/hid: require hidtools 0.12
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-wip-hid-pressurepad-v1-1-e32e5565a527@who-t.net>
References: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
In-Reply-To: <20251121-wip-hid-pressurepad-v1-0-e32e5565a527@who-t.net>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582;
 i=peter.hutterer@who-t.net; h=from:subject:message-id;
 bh=fQfZ3bxD/S+hRVj/cWNhZRvET046tgfhHw/kZkeYAeY=;
 b=owGbwMvMwCT4yLquYEv6h/2Mp9WSGDLld4fuXuS6OSyB/43jg1crbi+fte9j2oSX+ZvaPX58j
 D15/27Mjo5YFgZBJgZZMUUWGx3nmy61kRbvXQNfw8xhZQIZwsDFKQATUfRhmGf8LMDh88JleYvk
 fvldDO/es9u9fQLD/JiDlYrJZUeXHV5w+6jyiprb52Im3AAA
X-Developer-Key: i=peter.hutterer@who-t.net; a=openpgp;
 fpr=3C2C43D9447D5938EF4551EBE23B7E70B467F0BF

Not all our tests really require it but since it's likely pip-installed
anyway it's trivial to require the new version, just in case we want to
start cleaning up other bits.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 tools/testing/selftests/hid/tests/conftest.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/conftest.py b/tools/testing/selftests/hid/tests/conftest.py
index 1361ec981db6f79a58cf91e8732dcd7c05c47d38..985a535324b2fbe322e754e561d7af6898345b27 100644
--- a/tools/testing/selftests/hid/tests/conftest.py
+++ b/tools/testing/selftests/hid/tests/conftest.py
@@ -5,6 +5,7 @@
 # Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
 # Copyright (c) 2017 Red Hat, Inc.
 
+from packaging.version import Version
 import platform
 import pytest
 import re
@@ -14,6 +15,19 @@ from .base import HIDTestUdevRule
 from pathlib import Path
 
 
+@pytest.fixture(autouse=True)
+def hidtools_version_check():
+    HIDTOOLS_VERSION = "0.12"
+    try:
+        import hidtools
+
+        version = hidtools.__version__  # type: ignore
+        if Version(version) < Version(HIDTOOLS_VERSION):
+            pytest.skip(reason=f"have hidtools {version}, require >={HIDTOOLS_VERSION}")
+    except Exception:
+        pytest.skip(reason=f"hidtools >={HIDTOOLS_VERSION} required")
+
+
 # See the comment in HIDTestUdevRule, this doesn't set up but it will clean
 # up once the last test exited.
 @pytest.fixture(autouse=True, scope="session")

-- 
2.51.1


