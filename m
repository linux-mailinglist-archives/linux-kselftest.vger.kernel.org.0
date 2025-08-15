Return-Path: <linux-kselftest+bounces-39023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E7B273AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64210561B1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26ED27E;
	Fri, 15 Aug 2025 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJBKrI3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4073FC7;
	Fri, 15 Aug 2025 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217279; cv=none; b=EKT4zVypZ68tmx/p7qKumTJRxtXmo12RhVV2YlqSmIY3R0YYdFTRKkmBkTQjwRHx3XStMeufLnv7SWvLz2gjjadUft8NsG4cJJ/ZVOSEea1UstTlf/sq0JM0TbwDqlCCR9S09pPbihy5OIrPg5x5K2wnB9zNFs3hsLFyKTnGxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217279; c=relaxed/simple;
	bh=LUcgKwJABBj+TwKsngLhzjNx8DqesdGJKilNG5TyVRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9ksdu0Nnw/y+GY/8ZSnJX9vtQ6c3ZfepwltRh7/OB4AzvKnirGYBUSqGz7st9B2g68vrlMuQQ6zR4HvRb7J/766yC+O39VrqOHQ2dscA1UpbbI7X7wx6i2VbOhJjZcQP0Ag4MilzQ3wiIlnd+nAG3BrX3d9qHR8OqwN76cxD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJBKrI3A; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24456f3f669so16588645ad.1;
        Thu, 14 Aug 2025 17:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755217276; x=1755822076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISuSy7IMRKobKe6bhJDdOBVYdJ8VbTUzSrfjPom4VAc=;
        b=DJBKrI3A9tdKIQK4bIEjEfH6iF4qfwWMCT+m6Y3TKfBdjCCS8pdtAQeQ0UXMYtzRuM
         eCgfyFnTJbw7HdgNVAYPkxUa0yyxCel/cWHx4mKPrby2nEFApYB/SR0RUITcUQp6logW
         /R+diqeK7kr5Rj9SS78o5CI+a6pnRwXujcUIhmu1BifyNJN/XZwNHc2FHCqJAdN/FmhN
         nAMbL7U8D/asaHlvAtEiWwUEeVJ6cn+1F6UB0dFbrTHT4IPazQ6XfE/SEpE1wPfca3Ll
         mssR47vnDxqO+rAoG83wV9dletNVG1FpnHPRJwIw1oyTyCqsXDfnDSDg8qinwK4S39Kc
         Jf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217276; x=1755822076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISuSy7IMRKobKe6bhJDdOBVYdJ8VbTUzSrfjPom4VAc=;
        b=dQmTOd9cVMat8GNLrweGDpo8NUggUTmShhVbYGqGIwT+jSHclvfm24gltkkU4nJJBh
         Xd96YRDgQ72IPnNuqPw0X6PrYLI4q5F09sOlBmiKWYYMorj3U9nPDHi9UQvAw74bOgMf
         +WCYzXHn+W4ENPN3Ox2TSuAmpmswVT1i3J9njLo4zXpWwldRONMOE/g1p6rXLW4N4Sl+
         nXZGTBnylJ5IP09gX6ZjzS011ibBEJJMun+O7KMrGcAx9+YSp8fEiEwtozXG6rtpmy2y
         +aWNk+Gn5xDY9H+0jyyElbMFLsHmgt+k9+jRt4W5tEkcOVc2dohVRKaxHF/EtLwSTWb6
         CqZw==
X-Forwarded-Encrypted: i=1; AJvYcCVvaBamcN61NiGayOiYIyvqMKZthUxe3nHCQ0bJYkSP02QDVcOydfqJQNNvsyK+BLDHL6BtEqU36oZ2ZFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWNd65QVbz5hkuj2XwHDeiqtOY+qlXnRmEsH1vcqknO4ZNxKk
	1ijRnY5o3UA10ByiMVvptgtrC965QTE4ecxqeCERPLEQw3G2XK7HadTjnNb4tdAM/3s=
X-Gm-Gg: ASbGncuEi1mnX92vXuLQcpfmlVpfPhJWfzxLPRGvRGx/3AFbjtjcKH6rsrK5c5JfftV
	opxiA7gB5WkYKSAxlPKlE4y05UUUCd+5MXTGxBkDEzIgUkE+8g7kHR7oE30kEsCEhpDvuYTvjcb
	v0olk0KVlSQWFER1jio2P0boq03CqB/Rod2l814auwSyA5rm+dNP7z6K7Mu552dy86GFZ08N7FG
	4AOiFzjtM89KHZ0GQnkd4SjRL2Uo9vkj/0x9k7sr0HfrlX3EYWLapS0IbkhxhNb4Npr3sDLgKpW
	sPRgB/OZ6yI5pgI72Sh23moE6fbBk/46UIVXQN2yj72UBOvf9qdaLne8UGaEcrWLShVH1BR6tmm
	Hg8TyMZI/opAHRqLoY8NzOLV+3gVZMcQ=
X-Google-Smtp-Source: AGHT+IGLK/7oUU3EsuVi1qb1HakmjkmgPcL0yL6CGWo4A94WXUQimNdT1LfDLhHiD6YEmjgqHGVtJw==
X-Received: by 2002:a17:903:110d:b0:235:f091:11e5 with SMTP id d9443c01a7336-2446bd1dcd1mr4317745ad.10.1755217275848;
        Thu, 14 Aug 2025 17:21:15 -0700 (PDT)
Received: from soham-laptop.. ([103.182.158.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5a451esm700745ad.165.2025.08.14.17.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:21:15 -0700 (PDT)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>
Subject: [PATCH 6/6] selftests: net: tcp_ao: fix spelling mistake in comments
Date: Fri, 15 Aug 2025 05:48:03 +0530
Message-Id: <20250815001803.112924-5-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815001803.112924-1-sohammetha01@gmail.com>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
 <20250815001803.112924-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

found/fixed the following typos

- requries -> requires

in `tools/testing/selftests/safesetid/safesetid-test.c`

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 tools/testing/selftests/safesetid/safesetid-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..80f736d545a9 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -19,7 +19,7 @@
 
 /*
  * NOTES about this test:
- * - requries libcap-dev to be installed on test system
+ * - requires libcap-dev to be installed on test system
  * - requires securityfs to me mounted at /sys/kernel/security, e.g.:
  * mount -n -t securityfs -o nodev,noexec,nosuid securityfs /sys/kernel/security
  * - needs CONFIG_SECURITYFS and CONFIG_SAFESETID to be enabled
-- 
2.34.1


