Return-Path: <linux-kselftest+bounces-46201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 109BAC77D1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 09:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E935A2A12D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04D339B2D;
	Fri, 21 Nov 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EyzrxId6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F02FB99C
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712845; cv=none; b=S5l1TaUpCqzHk/jBxWIiCrVufRn1Tx3r02wCk8zPmBKWx4IS+bmru17SoyrElkkzbAhUMNr1HQBAKC2X5C6lLMOAgbW24jMWS/6shWYrmf+RUJzPCUOQyNHBqvXhCyL98fu1pucRRgxRX11vEp07Ao3/aUFBFN1Yj3jV2PvuI8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712845; c=relaxed/simple;
	bh=RqqYaj/cII106aSecrlvsfFGSQuqUqKxZMEY4rHQo74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnTGEYJjDTQ7tXmmPhIt+9DOOT/nAEcH7ER2QsuZ8GO2mPH7/aguO82wt2Kid+bdS70HIoGxhEObfg8juzZYK+BfOowHz6A4aDfz7mcFeL5ZvJ+AChVn+zVf75QpEzZkOVC8r4JxuAC05HTt2ERbAowrxorqKdJ6OqVhRvh+7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EyzrxId6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so15912525e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763712841; x=1764317641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu5P69WeH5TqqdvETNRSaYlqcEnkauKwjQ1PQ+ysJsc=;
        b=EyzrxId6WhrCTLwQFiuHP1SpKJ4m2QQV55iTbQrWs+iMllpgvmPdI9syf80h7AQo3Y
         etwLBK5qmS2F4256iiutDAcqRY+GYwpMW02apXC5v8L40ol03Oz/0JN0sO5eufbqkNl0
         Sf9rurYU4OkL/F2mPWF/wcS7UzNWrRMTYjPXMyaTdNgTUjErYrboFkuRAyGC8zMOvECq
         77nmgnCfA3rcSfRKJVSDSlNM6fY2sJEVvMbzwrXi+TqbmmjEWhy6a4f6Y1XJe+WKmJ/I
         Sfv5Od2NSW26hsCYchRG2wRtPHRP83c8poviWD2vc+zpaJNtaQHmjSCthCZcoWxNXKgg
         CMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763712841; x=1764317641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu5P69WeH5TqqdvETNRSaYlqcEnkauKwjQ1PQ+ysJsc=;
        b=q7OQwsVPwuHPuWVirr0wliD6fkGCHkTPZgF9hIMVSEz7TFpGsDURxVqJGbxBKl9TYP
         tAtfvFY+SYHJWrI+xQsvKyYfihiV8h3updLBxIWlR1H5UTU5Vjsq9YlnMtMjDZxNpqI7
         1ejRogt2PcQSabufjL8Rmi1S4tw2cmMUxPodrIH1m3IBVgsimxXn5TOA+XBiap7rbFfs
         xFW5xsWc3XapykEWfg0PZFZqz3Vx/qRvYOLxVlAY1uKk2wCi4Zz5eiUVr29R7phQ1dv3
         crk2YGZXEVeXOpWjd+PXkw9YgqQZOl6fwhBDDD+1KwyEFZDvh3yV6ZsIoz/pIjZ3BsV7
         ScdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRz7/+FpU8VSmGNw9RYeQLO5Y+Fe0TTsAjAoZvAJSnmcQmIVlZwvev0TtJS4arKf4N6QQJ7RxVFs8EytzI2i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFmNykftnTv4ssQjKvEIvYGJ1q0VN2fEVGoGgljQ53thPts5T
	Bwx0F3t39R9eHiTYajTeLM8SsNzpqxuG97QQjyHvx+GfXV1PSMRNA9jd1u2OMbdKKeY=
X-Gm-Gg: ASbGnctytb60AO+I3xcPbXmEvjq5Bk5oejHYWjVzcfvFzaT1H6FKKl2dz9vnMe+LA0M
	fVipLPOBa6tzgBcUhXxQoOnnPbNlsAvnbsqEWJ9s9liT9uEi0kaSvhhhz7SQ1WsS8L/91NjzUpz
	XFi0Fxa/Dfr6LkYXTs+xI/ZmaymFV+w++OeCa97gChbDxdVaQoWHz3rMo0PQlDiucPOW/6mFzQw
	t3WKhW10rhsnnApmjI2tk4NXsfJSBXFuzp0fwkX8BWHdwZVZvrWCRnOBNvJA04TSAAaQtmGUpKG
	YdDm3D56Q+IOeLRkBuRz8SPilnNo8ujGXoPMCUiLcwd6vL+SGIS8Qb54nV6gXGRn43JB/Gtkhdc
	sfJIo9/zHNKXVVM7cl+3Nc0shtHzYEZKDVS6BKOk0F/1dqBUsaCbYcsNvOzxRVyBxWTChf3nAT8
	MSC2RuWbnx6sDtM7F2wJFdUzasYVcXFdZCe7vJlveHuAsVNvkiSA==
X-Google-Smtp-Source: AGHT+IExo6P9yEJxV6Vu6XQYQ244uwk4Ca8NVmBGcVEgufQTNwqM6oCVjIDV6Wd4M5GDUo839dB7+Q==
X-Received: by 2002:a05:600c:1381:b0:477:7a95:b971 with SMTP id 5b1f17b1804b1-477c01f55damr13632975e9.31.1763712840705;
        Fri, 21 Nov 2025 00:14:00 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6314sm4722370a12.7.2025.11.21.00.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:14:00 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hoyeon.lee@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: networking test cleanups
Date: Fri, 21 Nov 2025 17:13:30 +0900
Message-ID: <20251121081332.2309838-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series finishes the sockaddr_storage migration in the networking
selftests by removing the remaining open-coded IPv4/IPv6 wrappers
(addr_port/tuple in cls_redirect, sa46 in select_reuseport). The tests
now use sockaddr_storage directly. No other custom socket-address
wrappers remain after this series, so the churn stops here and behavior
is unchanged.

---
Changes in v2:
- Drop the tuple wrapper entirely in cls_redirect and rely on ss_family
- Limit the series to patches 1/2 (3/4 applied; 5 sent separately)

Hoyeon Lee (2):
  selftests/bpf: use sockaddr_storage directly in cls_redirect test
  selftests/bpf: use sockaddr_storage instead of sa46 in
    select_reuseport test

 .../selftests/bpf/prog_tests/cls_redirect.c   | 122 ++++++------------
 .../bpf/prog_tests/select_reuseport.c         |  67 +++++-----
 2 files changed, 77 insertions(+), 112 deletions(-)

-- 
2.51.1


