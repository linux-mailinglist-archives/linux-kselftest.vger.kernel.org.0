Return-Path: <linux-kselftest+bounces-23863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D683FA00987
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2017D1884566
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B41F9EDB;
	Fri,  3 Jan 2025 12:58:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE41A8409;
	Fri,  3 Jan 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909096; cv=none; b=LjyDBHbaTn4mY/rNL88h2tDnl8Gw1XSYYLhQPKZqVIufRaZJhX2FkPxrol8jsg7G3HF5Se8qEuBTuoi2oNiX1WccC0aaEMs+k6N3SFEfrVdsqvTFItkv+1yvX4Eo3SIqueW6ZwTv45oJ29V3GIGpnr5hblcTYHrof5rl/sxp9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909096; c=relaxed/simple;
	bh=IB90VjMAHNKP+K/46jR4Uvbc7/wsNbcO3YwAxSf426M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X53rryNygsWYZ2q3gNLG79CNosmxGFbRR5ZrGNMyuwzxoSFasrXrjik7hyJwpe88LuQ1Zcuf/lt1IKfB/AjVXL1crxpBN13cWkSKNa2zGPyMXLMaSbq6f0I3hxyjPXLN1cewGCNwWrKyUUFSZN23HK87WWn13fKO0yG1J1dUg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aab925654d9so2126692866b.2;
        Fri, 03 Jan 2025 04:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735909092; x=1736513892;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPmNMcaT/U3vtmFWiMW6rvZwIsy0bhAzb8XleWWhMjI=;
        b=LO4wnpqxTqBxQBKHHmEuPukf7ypiU8Qi4+YCnxjrpJhfcph0ND3isM84bxJIXMjfYh
         2/kOYvk6Q9Gxid8Wu5qAly+MToF2KMcpMgwryP/WGD/yCPPw5dRgK+OnDrUTgTgbU/kA
         E19t+66Ix+aeEDH486iNuzqqMh7Mw3CZo2D3ozCVPynGC3KxsqgsbD9aF0BZ8oLmA3/R
         4K6B6Ugb2J5J/jID8oAUUCEOVp3yTK3kWXomSZXF22QUnHjTku4zsm4lfVY9nZh+J9sk
         pnr3gVIPxkRL1f5eQPLeDG6yD3zz3URq/rn55j5ypiOfdieTk+FmmNMPXTENqbUmG0wz
         ip7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHr0J61GmCxJQ+M09YWDSaR+Z88/MbgyY8rnX5bUWSV4lE3eHtYzTDiFbXfYNBNLC71nwO1qa3VSqY40g=@vger.kernel.org, AJvYcCW4elJS/Ujc47+V1LDpTobN9DUaXH4SE1xKaUVZ4DtoHCQ0QqWW94ZOGlyZV9NVVlQnGewfCYSw6hMIv5IQ9rdS@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQOvpJgcHmSn8Y0Zj0JZTL/2wvquP6iQVwWXIEOj3+KVuOAaF
	9J5SPAKBTcDFZaj6MKCE0uGoBAQwBoNzZLSoVBdmtdBpNCG4YW9lWHz97w==
X-Gm-Gg: ASbGncu7vnkeFHryBS8Gd33QX1hzF0UcqY6xXaHoc6HX7AoKJMcUbxsyppbL0noeXem
	atcAlR2Xlk2TCuBcSIzdNn56bQwjRP5IUtGqyIiROrBmbvKBN6h4RpJiz4erLOXGsDaEfmm/n7U
	CiY/h/so/oB4bS0wbARICOAX9xeakUri4oT+MH74H38ToEU1AG5FFEcKaDhbiWxgmN3P0XPCqVY
	gHtsOO8lOy4Ebuf+LodF2SDEJ+h3VcmeAcFb5DRvtgWF9Hz
X-Google-Smtp-Source: AGHT+IFDtxhbykeNSX24EslvOp/lQTxgQ07RXZInwSKn1bGez5Nj1C9Lqr0S0Pw6urjLxD1nO3XYLg==
X-Received: by 2002:a17:907:3f1f:b0:aa6:6885:e2fa with SMTP id a640c23a62f3a-aac2adc43demr4278445366b.14.1735909091660;
        Fri, 03 Jan 2025 04:58:11 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f58asm1892947966b.39.2025.01.03.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 04:58:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/4] netconsole: selftest for userdata overflow
Date: Fri, 03 Jan 2025 04:57:48 -0800
Message-Id: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMzed2cC/4XNQQqDMBBA0auEWZuSREVx1XsUkdRMdKBMShJSi
 +TuBS/Q9Yf3T0gYCRNM4oSIhRIFhkmYRsC6W95QkoNJgFGm00Z1kjGvgdMSCkb/Cp8lY8oSrR/
 a3mk/dC00At4RPR2X+wDGLBmPDHMjYKeUQ/xew6Kv/scuWippx96OTtkVjb47fJLlW4gbzLXWH
 4LODWXFAAAA
X-Change-ID: 20241204-netcons_overflow_test-eaf735d1f743
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=leitao@debian.org;
 h=from:subject:message-id; bh=IB90VjMAHNKP+K/46jR4Uvbc7/wsNbcO3YwAxSf426M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnd97hItijwEm5bW7+EkX10INvtpoqKVZOWIBSo
 LGyYa0SwSaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3fe4QAKCRA1o5Of/Hh3
 bSPBEACo7eu8y6ngfvtMv9sQXm7FaM693Jw4Fh1q0AIvNUzwjRabeNyYyClBJsszJaxOHvK1tiS
 N1gYs3FpFxDHw3/hHHeePtD/2LhYyJXESel/Aarr7175UBie7VHJvrllNeA/7BEyRH/1a1sJNKM
 g0Vyi3PlUMmUGyZKvBoa/RKulrWce4puU/yF+Jwyhl5jzhpFl88+KSgQU09OsctHrRcRZmocm2I
 N89AUc8qmn1kgMxWIRuKqMrf4VozmHzhXH1G7UC0zA1PsL7pGNKrgY7gC9YHsS1NPOGN3J1v0NT
 OOJf3RcsA+anACqbxlwjTi3XMV1oS/l+Z8rsgPyIhY+9kYPVu6ZrM6nPfbMv8QDeOUDLzl8AO2l
 35avQ0JKI43MnlfnVcTODob14SesTwTvVuyV2NP0beFGCuquvL8EOIDftrDfqhd8HWQsxCJ9q4r
 hUzaQiGXTZ2ky5HGo/ivYBNVncuO9G9EmThFm6mwdiKGsI1QDlReiGTKp/cnYT6s+J8mgpfPu1D
 BRzyTAswa0UW1qqJmzpW3JjaVr8tdvBQbXSLTrnuzyI7uCl19050qhz2Fz4UZ7bb9UTbM0sGqC7
 b2cWAWIl/hu5DW8WsjT2Yc61QdGRHMSeKE72qhrjCjjAi24wZrU0CEVjeBpEAcYVNy0JPj0ySTX
 chJS8LbQ+6hD4XQ==
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
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 225 +++++++++++++++++++++
 .../testing/selftests/drivers/net/netcons_basic.sh | 218 +-------------------
 .../selftests/drivers/net/netcons_overflow.sh      |  67 ++++++
 6 files changed, 297 insertions(+), 219 deletions(-)
---
base-commit: 94c16fd4df9089931f674fb9aaec41ea20b0fd7a
change-id: 20241204-netcons_overflow_test-eaf735d1f743

Best regards,
-- 
Breno Leitao <leitao@debian.org>


