Return-Path: <linux-kselftest+bounces-24056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95309A05A70
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 12:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9628D7A2F3D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2521F9F4F;
	Wed,  8 Jan 2025 11:50:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792601F8AC5;
	Wed,  8 Jan 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337040; cv=none; b=UDZQdsbF2m2COrsTvl9Sxq8bTUG0QjNHpJ16dekieebQFbGO4gh5zATNLhJaIWx0dkBY30XAWUHjBfONZ52AcALxz6yTbwrhHVztCgo8dIu1hAO1B8FckW4WVvyAkH3MXTZjredSPSrz6D7zDkEPPdRIErQrQlY+r5DVrrFeObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337040; c=relaxed/simple;
	bh=zdLHWj2Qh+I3oRS6DXan+l1E0UCjSGA0XCi+9rpeSLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hm1HBOPr+3R33kUF4s0QcHDyUYHOI6gJF5vF/Ep3YVyOp7zOKJrW8gR0d3aJyyXrM+WxfWsaxi8srF78hU0o8TYn2xdE5wbrMpE8VbgxdDkD2q1y+6AlAqRy2LIBMGrY+DcbZ6XPl7ck4oOA8qD4yZxZ1de+gESebwFRULHuYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso3480356166b.1;
        Wed, 08 Jan 2025 03:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337037; x=1736941837;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kE5Ik9z58K3vMl+d5jDdiRTT4sfBsakcDNQojzo97Co=;
        b=HrCHc+9vNrr7NkQj/BrAFPthWVmtROCVnK392sHccF4a0Q9EgJJ5nlOFZ20ctNIbq3
         phZ9w8WAlVWcTRBgkfbjNNi+NtsKD846uyVg42yZ37MYDS57WroHM1hv//QG02KVgoeo
         KyPWFhN5+1Qs4D2ABw7A7DI+pEF8UdZs0Nizaf9x4mQq75vy8h4Nz6iXuAt+/awv2L//
         dUhfoQvU4HdkuviC1iMYHt9cK5bXpJaJbZx8LAAiz6S2o1e31YCyFK9WADXd4SwEQaJ8
         TnZbkjelJFkLx7pBcWZ6z/PLr42PgqExP8mapXgkcfE5pYu8crEO3GVgWXgeg9Ots6mt
         FCng==
X-Forwarded-Encrypted: i=1; AJvYcCVFFftAjLNU/AO1Xi144ouoGGRagnORxfwUb26MRAUhqWTPvvBATyMdCRbKrcHtTeCGLh9uPZhMbj6Gf8U=@vger.kernel.org, AJvYcCWebDA1/3vlN4gyf67g23zpfxHzxs3iOd5Sb1Gu4DctCifXpEIPwqRxYr5bC+8xeFSgyOtzzffKL1250gKfCXRN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AO8SU+S8S8LChfhBPso7IIhi89htpkFizwthfcgsngDj5oTo
	nZOsnWOscXX/Cx8gsm8SdBcIXBw4cMkyJgw/cB7ji6DmxPFHOeQp
X-Gm-Gg: ASbGncvmnl4IZT+u+PDSl1df/h7bwuP7Uw2RM4KznnC7VUu99gzbccW1mTjvctD4g9b
	b3Ix0J4jUlFr3OTR9qkXQ45vm/7EoHs5gA7vFEDRklHof65x3BUg6rN6SUpd9SJ8O7rPd9AoUxI
	FiHahDX4eSAIigmVhIvadR5lOe67kZ+nDQXMkg1J1lJH3j/3t5hc8nImiz2aAPp9eqz8FYOOtFL
	MDGCIv7EA7NmU7cAfr9t+aUm4A6QDTmpKRvKpe9p3aYxFE=
X-Google-Smtp-Source: AGHT+IGYP/nSCvT7/l7vlKva4zNZnpbnsdLesiWhtrvqIxngDr6Y4lfiRxVAIp/SY1k7eGZrkAMb4w==
X-Received: by 2002:a17:907:2d08:b0:aa6:a21b:2aa with SMTP id a640c23a62f3a-ab2ab6a75f8mr176498066b.12.1736337036391;
        Wed, 08 Jan 2025 03:50:36 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe48ecsm2512879266b.126.2025.01.08.03.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:50:35 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/4] netconsole: selftest for userdata overflow
Date: Wed, 08 Jan 2025 03:50:24 -0800
Message-Id: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIFmfmcC/4XN3QqCMBiA4VsZ37GL/ZnmUfcRIdN900FssY1li
 PceCZ0E0fELz7tCwugwQUdWiFhccsFDR2RFYJy1n5A6Ax0BwYTiginqMY/Bpz4UjPYWHn3GlCl
 q28jacNsoCRWBe0Trlt29gMdMPS4ZrhWB2aUc4nMfFr73P3bhlFHd1ro1TI8o+Nng4LQ/hDjtZ
 BEfpmacyV+MeDPqZE8DHtX4xWzb9gJX/dVcDAEAAA==
X-Change-ID: 20241204-netcons_overflow_test-eaf735d1f743
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=leitao@debian.org;
 h=from:subject:message-id; bh=zdLHWj2Qh+I3oRS6DXan+l1E0UCjSGA0XCi+9rpeSLs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfmaKe+YSjDD8UyTlLnI+V86UPDe4OJvUnyAil
 J6Dtp57HNKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ35migAKCRA1o5Of/Hh3
 beHVEACby+8F9cpiITtw89SpAr9b8NV5nItZtfMf3atcRX//JC8/aMR3NME2ihLGQzaLsmrqZDP
 nZcN1sYWDbh/HVIV3ISbP/oYJfDOLnouj0+u1KQGLoi6kLGs9sH89VQevj7Dp+GOgqLEd5Oqz2V
 hr2xjoB0jR9EknBrtnQdkvLnDxt5N65BQGcQG7Fh3plYu6ufMPhe30IioUApG0vwt8uSkZ8hKts
 8MI2KwOy2nZFC6IFr2ZeLz8IESTxux6JCKJBcgnkXFEQB6dsjqgE3OnPcKdH3on+BfLYMlBWj+E
 T4BJb2M3ZMR9baGsUQqhNVCkSPzcTdQEnReTG5RHaEfmET1NLjL++uqSfDNde1c/w91YTMR46j6
 jvaqjnjDwbi47L6PxDkb19tK9msMq5JHpoGdB0IAs444/BXAOnZMSNvYzExIcoL+Vdn/nYQn4OO
 6140DykdiM6Z4SvA2BS5nxqRxLhR9LkshQW1wv7kuJrMOboPoPxgRedD6gI+g6tjQVS6blD2bLz
 gyBLnElWzdfEevfWxmA6sBKBf/+IdXWnaxAO7+gIsrhiFe1gPqDYcD3ZsyH6hRc4HRSNdowgyrC
 tObecnuknzlHs8U4feN1cIa3xuWRW75DChNF9rDivXBPuvwK8lgRQV51CYnzM64vZP6UNskV8wx
 6S5sk5VACeaUblQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Implement comprehensive testing for netconsole userdata entry handling,
demonstrating correct behavior when creating maximum entries and
preventing unauthorized overflow.

Refactor existing test infrastructure to support modular, reusable
helper functions that validate strict entry limit enforcement.

Also, add a warning if update_userdata() sees more than
MAX_USERDATA_ITEMS entries. This shouldn't happen and it is a bug that
shouldn't be silently ignored.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Added the new shell helpers files in the TEST_INCLUDES (Jakub)
- Link to v2: https://lore.kernel.org/r/20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org

Changes in v2:
- Add the new script (netcons_overflow.sh) in
  tools/testing/selftests/drivers/net/Makefile as suggested by Simon
  Horman
- Link to v1: https://lore.kernel.org/r/20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org

---
Breno Leitao (4):
      netconsole: Warn if MAX_USERDATA_ITEMS limit is exceeded
      netconsole: selftest: Split the helpers from the selftest
      netconsole: selftest: Delete all userdata keys
      netconsole: selftest: verify userdata entry limit

 MAINTAINERS                                        |   3 +-
 drivers/net/netconsole.c                           |   2 +-
 tools/testing/selftests/drivers/net/Makefile       |   2 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 225 +++++++++++++++++++++
 .../testing/selftests/drivers/net/netcons_basic.sh | 218 +-------------------
 .../selftests/drivers/net/netcons_overflow.sh      |  67 ++++++
 6 files changed, 298 insertions(+), 219 deletions(-)
---
base-commit: 7bf1659bad4e9413cdba132ef9cbd0caa9cabcc4
change-id: 20241204-netcons_overflow_test-eaf735d1f743

Best regards,
-- 
Breno Leitao <leitao@debian.org>


