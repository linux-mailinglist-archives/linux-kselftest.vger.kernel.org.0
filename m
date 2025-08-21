Return-Path: <linux-kselftest+bounces-39420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3BB2EADA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88279725B75
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90924503C;
	Thu, 21 Aug 2025 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj1qRvSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28102243951;
	Thu, 21 Aug 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740426; cv=none; b=AxRtAOR34LGdOsZzDAF4h0tUmEpBKFedzaE1NI5vRUqqdp6z+RENZGyAW/WkUFQIyMNeZ/ex1JKv4k6uLkG/bi+AHA8e9RAbFna5cJb2iPFoNW/pqGXVgLYEx5Ztc9ios+SMBvBO5ZvIlQLJdS2YHZ4qWGHMwLf9KDBBj5/0rRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740426; c=relaxed/simple;
	bh=dd+p+m8RCr1gu/K9XT7fineNz8vxsj2Aal37WOOGexQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qP62BbOjIvnwm1ZM5HaWtuf6lPxzv7BURa6MG7rrrAfAtW7XoiKhw5s1xt7FDBT8mWK4pLvXhaHjBoXIRFeMPPTok4kqkuCjyM8ISwLTIJvNDAYUu5Ioik+tv07H+/+RSSoqmVZgwa8ysoh2gUuZ+U4fhoHN0mFUsJTNOlQc/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj1qRvSn; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74381efd643so123964a34.1;
        Wed, 20 Aug 2025 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740424; x=1756345224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0l2Fv6f/eOIwISC/GzHFraV5mmiSruIYibODwqgTDdo=;
        b=Fj1qRvSnC7OfZ2eQtQwFc2OG6I4fArhbegC0YQ7TXkVF6IMaY0fYZNnfd7ryc+H/9J
         xSWYoxsEmFXLMkPtM3JxKpsFFHQqaTZHS8gD9GQCQxwOl0zk+Gpb0mwv3tajuuTml2LI
         95RXNgFz/VXQiIdCiQ5S2LHe0UPcCrJl5b2fTkd8faUMpNx8E054pEp1tHpWCiTx9Xns
         JZZRopCxIg/9mwYJXe1xFrwehCn5TmPVj3g4v7ADY09pQuwc+TjeDpjRafdbzEU1prpg
         Q+gGauzV/ynPoyWjXVhWBUXNCJiD5G7Xh13bPR66HnTDYGaFyK8roo2xDxa/lznTY5Qc
         ZK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740424; x=1756345224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l2Fv6f/eOIwISC/GzHFraV5mmiSruIYibODwqgTDdo=;
        b=TlyE11sBEhSWSxcr7u3jnxIHZ0AqVM713ll3I1ZjQHrkBzlhWDAguJODrZEIo+cteU
         gv/pcNBSSxDfRe4V49f9DJ1IYMW8q+habpszkXfQNjBRruRdi0TfknzLeTyJz6GRASBG
         hU/I68922qkesE7/8nvap0McEoosQ7mvtmAECH2J5I0bMJP6fADO0RcdWudnsSbmzmu2
         QUaEZm8Q4+NQwVY865XMb8Utosg9nQ/N5IfSSq2HE4ahIW6qnM4mlybaLzZYwREruwlX
         jPSaB5uWtSWmwiVg0X5xqKDuu9v1o2wXV9SC86bj5NwqEeyGtHrcae62sn+ZjHfB7DPq
         5sKg==
X-Forwarded-Encrypted: i=1; AJvYcCWG41ywvWzxT2fjIW++eGcMqytmZ6CI+dNcD0COj3aZ8xOQq0VmzrPnJcpeEdBilEAvknfaeNyG0EDP+D5WDso=@vger.kernel.org, AJvYcCXbz1ayFxf+dAoarzdjBjgflm/+4G1JIbnCbGeSRU2GBHJBzf8+HRzY1vQhbY7dxho7hZ6rA3iO@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPKjIf5HTRYuwScUUg+6D2+uHiCvm6Wl7khgewS193r7tMAJ4
	3zZGp7IlcpQt7ce2m8l5irHxW6D4JqLieeTS7KuHSgkUHbNCaVqq/E/s
X-Gm-Gg: ASbGnctSfg3BLuo1BNxou5RlILELhhhDaYBH46RqpBdBczICBGNyHcaY+9gGcZA2eXv
	0cKDQFkRvvPWjEF0XgUGmbh3TJ9810IDpYH0h8RcwYs1cOTkTWXjCN/b8hycoWEASeLBXOsj0Gs
	oVXgEeWHm3yL8jmhO9pZ7xqhR8PqaOmoidZIHlSHWezVu26DJ75EfoTGIYsysKT2YJBsiNS7Hmw
	QMYuOy2q+yg2S2tlMTIVjLsQoO6TgfumMFGM+0MdBnroXOOutN0Zua04JRTB7kp2oftz/QboSou
	ggO8SyC96eY6FZ2FVlutD3zptaxnNKylGw7t4sEXXlX6TpXAqOcKuoMhOCmz78tPaXFbpKHLA9z
	q8Jmawwc9g8p6ppEsU23qLHP300Pm6A==
X-Google-Smtp-Source: AGHT+IHBp/V/ETNxCyJMTg1P2+9qy8XwY5wTbZan865pCwiR8ngJoZaR/VTFPNax6YFM/R9T9rvF0A==
X-Received: by 2002:a05:6830:380e:b0:744:f112:e539 with SMTP id 46e09a7af769-744f6b41776mr373612a34.32.1755740424025;
        Wed, 20 Aug 2025 18:40:24 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203b5c2sm3231251a34.28.2025.08.20.18.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 18:40:23 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/3] selftests: Test XDP_TX for single-buffer
Date: Wed, 20 Aug 2025 18:40:20 -0700
Message-ID: <20250821014023.1481662-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure single buffer XDP functions correctly by covering the following cases:
1) Zero size payload
2) Full MTU
3) Single buffer packets through a multi-buffer XDP program

These changes were tested with netdevsim and fbnic.

 # ./ksft-net-drv/drivers/net/xdp.py
 TAP version 13
 1..10
 ok 1 xdp.test_xdp_native_pass_sb
 ok 2 xdp.test_xdp_native_pass_mb
 ok 3 xdp.test_xdp_native_drop_sb
 ok 4 xdp.test_xdp_native_drop_mb
 ok 5 xdp.test_xdp_native_tx_sb
 ok 6 xdp.test_xdp_native_tx_mb
 # Failed run: pkt_sz 2048, offset 1. Last successful run: pkt_sz 1024, offset 256. Reason: Adjustment failed
 ok 7 xdp.test_xdp_native_adjst_tail_grow_data
 ok 8 xdp.test_xdp_native_adjst_tail_shrnk_data
 # Failed run: pkt_sz 512, offset -256. Last successful run: pkt_sz 512, offset -128. Reason: Adjustment failed
 ok 9 xdp.test_xdp_native_adjst_head_grow_data
 # Failed run: pkt_sz (2048) > HDS threshold (1536) and offset 64 > 48
 ok 10 xdp.test_xdp_native_adjst_head_shrnk_data
 # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0

Dimitri Daskalakis (3):
  selftests: drv-net: xdp: Extract common XDP_TX setup/validation.
  selftests: drv-net: xdp: Add a single-buffer XDP_TX test.
  selftests: drv-net: xdp: Validate single-buff XDP_TX in multi-buff
    mode

 tools/testing/selftests/drivers/net/xdp.py | 71 ++++++++++++++++++----
 1 file changed, 58 insertions(+), 13 deletions(-)

-- 
2.47.3


