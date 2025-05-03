Return-Path: <linux-kselftest+bounces-32267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89538AA7DE7
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 03:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156015A3850
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C0C1C683;
	Sat,  3 May 2025 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvcaWxu8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855826AFB;
	Sat,  3 May 2025 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236128; cv=none; b=a2QD7wklWgy81A1ZowCKIIk7SF8qMIHoUanXUu1UiXVduLaFfmg4xpOuHgBjYxG/9mb7eqkfy9p4w1HJxh36yGT2rsurcsmJWFM1Ruu9qaS3Cnw0QWHa1Oq9p5Q2W7cktGjAeADS/sCC/P+e4OhHjMjPK+SrpkWRZesVN9C/JYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236128; c=relaxed/simple;
	bh=tMl8hZVUQG5HQG6FwMbiZOTecaN2qL0bC3Qr9pnE8jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7zKVI73LghTp+ismdSL+FF9UjhCRviqMJ0f08jRt7XvKvkWIatpR8zeeoMcEZjJ2y68X0DSoJfrZaL+W+/UniuWkhs7Ho34suvjkmTS0L3U5spfQmYB+0NfArdKE7PppV7gUa8QBUFbR6y23J7BNHsGMQzozjxKEkpQtyvmWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvcaWxu8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso20007415e9.2;
        Fri, 02 May 2025 18:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746236124; x=1746840924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xar3mqUDwUSQmq/Fr0wdfqpIsI5GH3WpXBsnieneFNg=;
        b=lvcaWxu8tKHHkqVFy+8OuQuEc7C00xEqIZcB3/fUlLWh47IT8Prnv1F41i1Su+jAio
         +TenW/6BRqnDWt2s/dFCL9W0gBoSFE2m7aebRoF0sHXnbwmgRQXsCd9a9n+xz78Uwf7g
         xts2QEzeMYufcmKNIlvD7Xw6LqJLtdfRsOcoypsORRg4hyUcrxC3BJUzYyRF8GQU7nVQ
         SzOIp82nyNZf7Sv5SmKK8lCQcQGuJeG+vkc3cJD3AruDnlsPfnN8MVhM2UR3Hk8OZzxb
         ekjs01ggLpWiEd2c1C7hWqE6PogAJ03wCnPjM79XDKkNsdAueBe2ypvX/VGdeAxf/tk+
         7e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746236124; x=1746840924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xar3mqUDwUSQmq/Fr0wdfqpIsI5GH3WpXBsnieneFNg=;
        b=RxqbZSHVKZky8rMfEzHk9D0poRwM9sILOlxApzGqQqwbrSf8ksQeZ9CH/RT0NdDMms
         j04TDrOpUqRGBguejmoxJAtIG/FgwwWfOgOdCRi17Nr0FyCEnyYcLpvcoZ+fVo/a8xdC
         VcuhH0/dbjSDm5P0hU/5sCxqvXblovFkO8Wx7HTxHwQ1qIQNEMRjlSJ6O38HlHtmsMhe
         pwAbVjjypqsOBOGJYsq7x+0MrOr4q4sek6Q4mJuPJrJRVO3rxY4M8rnf+O1+8YoPX4+y
         8JpoZa+476datz7vdMOfA5bg+FT3/tMkse54ksoP6oKBXX+W7V5HtZq4XkQHeTS8l7dv
         9GAg==
X-Forwarded-Encrypted: i=1; AJvYcCXQXHdcZlzF4y9q3sGZ0mA3nME17Ihun8PBRHsBAKJ8n/7zSNMgcvQ4HZdzp/KHoTZVqDu4z//HR8MpieZiPk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynayVbIYRyQjYWeAUkFjoWj4mam8G3Jct3IlXlcjuKxS2wY8y9
	lGK+s7bbCm+ibrobapU66BbdO1uWgt/Fobr0IQzcrE79230UDWHvgARpCe8C
X-Gm-Gg: ASbGncuxFK/j1lm3opMUeWQVXNHC6hshSCNUIAnoT5HszjSmZGq9ZH1ASxPXYDcMV1n
	2z5gZWvY5IlQqhHmspfZD/4FppczKrkQPX8e6ohKDHKqwuLgq3ofNrvxc/IqqzVbG0QJymc2+xy
	DFvEbBpk/zd968d/G7+v8ZJBHo7fpZ32HEBDB3j+7zLnNN3KCddyaG9tIDF0qwNcMzuHDvHWOgI
	yXKp9p53u15PgyU8XtJR1YgxTKLvLqAUjr1HgMM1CIHFyFFK4xgOyTnowXXUQyKJj4jANxs0DLp
	b1FmgZk+tAvTcmlDZFJRCr4R9Ddo7ViPlViJ0QQ=
X-Google-Smtp-Source: AGHT+IEqd1XB6kNK6F/Karw2QKCnNoTNQlAdVLXCmN2M7WpvAkzcmSXaTEtXvIAyITItPdU+cX72Yg==
X-Received: by 2002:a05:600c:4688:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-441bbeb479emr47951635e9.12.1746236124152;
        Fri, 02 May 2025 18:35:24 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d1636sm59452155e9.13.2025.05.02.18.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 18:35:23 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3 v4] selftests: drv: net: fix `ping.py` test failure
Date: Fri,  2 May 2025 18:35:15 -0700
Message-ID: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix `ping.py` test failure on an ipv6 system, and appropriately handle the
cases where either one of the two address families (ipv4, ipv6) is not
present.

Mohsin Bashir (3):
  selftests: drv: net: fix test failure on ipv6 sys
  selftests: drv: net: avoid skipping tests
  selftests: drv: net: add version indicator

 tools/testing/selftests/drivers/net/ping.py | 45 ++++++++++++---------
 1 file changed, 27 insertions(+), 18 deletions(-)

-- 
2.47.1


