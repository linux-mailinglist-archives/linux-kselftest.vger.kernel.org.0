Return-Path: <linux-kselftest+bounces-48091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA49CEF929
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 611EF3011036
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F223A9A8;
	Sat,  3 Jan 2026 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GoNh2+Fj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2523957D
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401139; cv=none; b=g1i37qSmG/ODN1pk5mn0AmCVJPkOrUeFWAbUk96zndZyXPm1eEPDyz0mj0g6lc1At1/cjW1nRkMCWV3sHVesO6HjdQezXol0qWK5zUN5UOkPGXaj55GkjqQaHS8+oyJ4ppOQIqIuoetF4aTf/O4wQ5oImunA0ykbz6YB01cqt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401139; c=relaxed/simple;
	bh=C7WOnO6ID4LqxTasOYmRz/f/EOUiS1sTWpJj01SHmZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpM5f81Q8PkNbf2oTWHo0soEar4RKPM5ccG0bGFA2Wh14ryb1LzFePM+t5a3TYOhqBbKeK2H2ofuD379BwIrjXWoq9/271e6OenMlNTdjN7O9vn5kKKrKJSM3YKVLTnUIaXohYsRJdUWpLy66D82QGkUs3AztorrgngIaD6z8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GoNh2+Fj; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-29f3018dfc3so39968725ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=GoNh2+FjIG7Xs9Kvj2DdllebHKjqa3crOSDaGnq6cJONOReQf/mQqKCjZOddaeTQNp
         11Uc0myJDme2oUWEwjuF9RHNwM9UqYX2WvGfvNQXpIwSpkZlUu3w//7f/ZDjlV/nPR2w
         9HD6v9U5JDfqASq24pBOOCqv1XIz+5kojRbp1NZZTxTNFOfDBdhOeJafmIixnT1Z3RLj
         Kju/HYVtiflJIVDz//TuBMfhch87O8mjMoRkS4z+k18pBX0QrZtuJ3W6G5qZVaiFVyLx
         IAp0hswNc9GpUyYrvh6qfZ5VZhFFXxxEXQVRsfif3Os0RVX19pJBgRfAmUMT+ZgK7jMP
         dVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=qh/mszTmU1CmKyQaRTXPYkhA4Wb+jPJLgn3ry9AIH+WSj4JKud7WiubrYZjgzPOVsX
         pkEthdnRzZU+Yl6cBtNNfXYUR7da2Bj1kZzbX570pHQIBKlmC45sDv1HyXeFdv4/2SIY
         5RkTpQsLaprFlf/0QpkpMuqTUeLyWfSoVTvCgkEkDgZtoB00NRYOXZhY9MX9JX9cfs6G
         qU7eW52fCE8OdDC/S+jehiMFPIdgcrmsHZN14NL2bEaPkkOUFcLSPz3765fvLElf2Ccz
         tKjM3ZqWxslAESnIHy1+7e6MQ8buiGaknuq/RFMmaKhvtO85Y2uPeZXmyMQXepAFhbqL
         ZVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUnkXmbYUXg5kk/4TlraFTT0FMykQjUHw6Gc14OkiVhoyrBZ1wkwgdhhUptFlNcZOYgICokUqCmpJOLnEfHmwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1xAO5KmfuorIkt9WvyatBhT5TU4v6RswN1pcb4JFwzdBLCE0
	o2ziGhZUhW2fkGmp8TymZHCb+fu5oZGw+X2DYPeelbU6Bmnx2f1lZsg9LC7+7YcOkLxBLIECBSs
	saFAM5gm6JJxXckk4BLmpbkHR7LiV0K5jCkuMo8D6dfUrjQPq4ENv
X-Gm-Gg: AY/fxX4z4hb6QQQU3kTKCb8GNaCAtPxzoeepZ0h4MZZ2YTNHpfuTcvNvVQXOjMlNjJf
	+646/BFfqkEYUw3SXsga3U9Cvb+KgNBtcF487OthHOyrtiQyic5qe7cE+buf7RAY7BfqLlZxYO9
	JksyMEm9/k95LdelEUIpmmxuve1D1xhaV3qiD6OG4N3jDH7bG+sfr3+CTmETz3UQSOEVrjCEP7d
	s+10wZrUegM5z5IeIHLI+VgumgK7vtCYYmNuDwg65r32iiw9ZXp3yoBq9LZKLQ7Xe4YDZciT7FD
	SI96OahJ4LWS9RKJzjKTn1i3AtP4siqHlKJt4ZIDrlJkly1AgoriTed1hhJKHmxcJn8F/KbtSp1
	/QSjRyyrXO6gbtKNWF/8OwnYhbX4=
X-Google-Smtp-Source: AGHT+IHawm48E7pqRyjmJ9hUw0NxRRl9Ovxh9zYIlhy1Y4hqCxOwahXdq8vrTBovmg4pUO9Vts97L2O1plEF
X-Received: by 2002:a17:90b:1a86:b0:34a:b4a2:f0b5 with SMTP id 98e67ed59e1d1-34e922090femr27162417a91.5.1767401134519;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f477483cfsm71018a91.4.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F107F3402DF;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EE9F7E43D1D; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 12/19] selftests: ublk: display UBLK_F_INTEGRITY support
Date: Fri,  2 Jan 2026 17:45:22 -0700
Message-ID: <20260103004529.1582405-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for printing the UBLK_F_INTEGRITY feature flag in the
human-readable kublk features output.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..261095f19c93 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1452,10 +1452,11 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_UPDATE_SIZE),
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_INTEGRITY),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
 	int ret;
 
-- 
2.45.2


