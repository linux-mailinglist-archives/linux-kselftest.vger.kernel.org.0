Return-Path: <linux-kselftest+bounces-38287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E0B1B15E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45A83A58BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F25E25F78D;
	Tue,  5 Aug 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIrTD/vu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC71E1DEC;
	Tue,  5 Aug 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387217; cv=none; b=UPL0C7Y3KpTK5mmgdyLt9Kbwt2VTkNvbVnnlt16yUqyzkU7XOisymGIsFtTLgpvWuj1zYMMNDDcVrk57f46D5IM+KplKeheHtmQ25fNlBnvx1gksZPGsIDfwMJX5ll1tYWx9ahFH/x0SoI7rnrTsCSCX21WM4rC1doydRMG5YaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387217; c=relaxed/simple;
	bh=4kupuwqi2LjBr7Ko7mNI0MhbyZ8bW7v+IfNYBs+Lwws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPW1m4mVX/Df0spfLTg1bBxHoECBwtmspLkQRQl0orkNLUZD30TyWVltyc1yu5YeRdOwzv/g9USmWa6mM1VKcfsclBicHZOWno++n8nPyZ5I/NqsEkfo4fGK55BOAMCpP+jslDQsg1yUHQP/wlBZPIaMc9PDtpDQ86nhy1POx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIrTD/vu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2403ca0313aso43342415ad.0;
        Tue, 05 Aug 2025 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754387215; x=1754992015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2Gv3tVCVIWeaarhaMnC8yYqJ7xYzifkUc1fd2gFeIA=;
        b=bIrTD/vuHacSek2bKNE2WUVMqVughrsSZcUSdEQ6o/dIqc+LdNvIX2jbvLydk4Vy6F
         nEPo1zyhVFElVcQlbeIVpDBvAMjWK5dW6FloYuUFF2Rakq7035ftG0tzQxUWD2RBjmKW
         CaaeKYvEPQC+mr8C4FP04E2b4U8vkdNSwkc7PgwO3W+qBodXheVRP6t7CWfQj1Otp3v5
         ie4J3gkdaA84byV41rs+rDxyXUVa/ELfL/W7vU2ZFZx2F66p9bjYXmFypyCM3R0ddx8n
         +8wSa52sxRH6h1se0IGgSLcUtWJEyDG1DIFDFt6vEYzXZ1QN4URy28YlZWXxS20lXAWb
         +SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387215; x=1754992015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2Gv3tVCVIWeaarhaMnC8yYqJ7xYzifkUc1fd2gFeIA=;
        b=l0CIiYxP6VaJPFqWmoFTU9XKvWE3KfnEPJ+x5PA47Ov6nH3GW3ETz8WmY4Iqp2oP5c
         Wmp381XHoavE5/l9e/+2K1Q/MG/CtfBXh2Fj1YLGwdkk2ERf7SZfxw/JcmnLovrLlhO+
         8hOCYjXIbzPUh8+Pf7poQ5FEnN2Qbv5879Y5IT9pJvgBiizouUNV0ZaszhqhxQ0nw3ZW
         BuNaWy2pXkW7ALc0YRnl17Z4fZgiGQSA08J4aauOObl1bVa+c8STUjyAauyrRZqoarZI
         6TA34XWNXY6Z4m//SWuptsCXEGC7b02dmk/G8nlSN/k9Y71ww1HvQYAY+qV+ZI/x+o2G
         QDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Sk6RkSHUlfmlYhNkEAdg6XwBB61fwjIKQF7ToebLFPRe4HWF5BRjD6yoi/hQJd2KQKZQyRwb8tmKa/k=@vger.kernel.org, AJvYcCXkQvVCmYxpFwpNJdADc6JJsoSHEeM8rpqybY/h1NghEYoLpTzqhuQiDxvwm9pBU93TcduRzAQwp7X5JK3fEegb@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7Ae+Qr5F1ySgHQ6F17hm4FQxX21xBCHmrYvKWodovZUSUJ3Z
	i5LLDenwgvtfQZ9cWDCR/zp/Q6Mwa1fg5tJFU2THF0OEsAi45binBIb4K2yxBdd4sGs=
X-Gm-Gg: ASbGncuhmVjw8JlpLCDo3cJ8otHKYk7ujlQcLAcj39cXKul6YLI3WbjVaZjw0q/VWIA
	Uf2+67IvGRXnBnmzLcsIBWjcG1p0/RjEnBYBjS24uw8TZpKGwvpCpbPoVqiuPhpUQAwSrGqhDV8
	druzyFMbncDXIiu+uRv1JhrjAWYpAhEF847E7Tm3YZzK8byx1i+AZPzMtHuAmEQreUsSlYzjR9b
	WNbojzIm6awB3BsW6qCTckiMOvRzTtuRbXX7bMZpub7nfHZtxohx9xLmgB7R5mLY2H0y9SLd/Cn
	mB57Sr5Q8/7kzRvI+JWcl50EolM2KSmTMouU3+2seiPZWKYBD3sFNf9fIqWXyV/qlFJcNItdqYs
	edRr+fIPagFpmwhQNBdedDLFX7px1wHSlh3PKl66sax/U7xA=
X-Google-Smtp-Source: AGHT+IHlvhoB50Ge92rDeLd0FURY5SMJ7Ox+2cR1ShsMI5ZbhXvPUC21eTeD/Cxnusi7j2hPTqdg6Q==
X-Received: by 2002:a17:902:f693:b0:240:41a3:c18a with SMTP id d9443c01a7336-24246f562a2mr163416115ad.6.1754387214397;
        Tue, 05 Aug 2025 02:46:54 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d18asm128934875ad.141.2025.08.05.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:46:54 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 0/3] bonding: fix negotiation flapping in 802.3ad passive mode
Date: Tue,  5 Aug 2025 09:46:31 +0000
Message-ID: <20250805094634.40173-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes unstable LACP negotiation when bonding is configured in
passive mode (`lacp_active=off`).

Previously, the actor would stop sending LACPDUs after initial negotiation
succeeded, leading to the partner timing out and restarting the negotiation
cycle. This resulted in continuous LACP state flapping.

The fix ensures the passive actor starts sending periodic LACPDUs after
receiving the first LACPDU from the partner, in accordance with IEEE
802.1AX-2020 section 6.4.1.

v2:
a) Split the patch in to 2 parts. One for lacp_active setting.
   One for passive mode negotiation flapping issue. (Nikolay Aleksandrov)
b) Update fixes tags and some comments (Nikolay Aleksandrov)
c) Update selftest to pass on normal kernel (Jakub Kicinski)


Hangbin Liu (3):
  bonding: update LACP activity flag after setting lacp_active
  bonding: send LACPDUs periodically in passive mode after receiving
    partner's LACPDU
  selftests: bonding: add test for passive LACP mode

 drivers/net/bonding/bond_3ad.c                | 67 +++++++++----
 drivers/net/bonding/bond_options.c            |  1 +
 include/net/bond_3ad.h                        |  1 +
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_passive_lacp.sh  | 95 +++++++++++++++++++
 5 files changed, 148 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh

-- 
2.46.0


