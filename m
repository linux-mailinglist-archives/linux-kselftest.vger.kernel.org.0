Return-Path: <linux-kselftest+bounces-18668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4698AB21
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398461F239AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E31940B2;
	Mon, 30 Sep 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8ce4R4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CF1925B7;
	Mon, 30 Sep 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717662; cv=none; b=sE8XGqbR/FVvJ+R4I8hyBfnbV3mdspNQDpaRUT6R4jZreybI5lK/VR+cJk2DTB121rRNpkuzy15Twyj57aIfHISNh9YbDgqOBorj8Fni8KHdf/zpj8eUKecJTm075guphM7dJmOxP7s2ecA4TyRybtlce+9Xy4764FJUY6RuZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717662; c=relaxed/simple;
	bh=8U28luUy4GCKjsunTL9hsf8j7qGd189igaqyz1LIpok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YtPvQ4U58rlw4AD/d2lOAXSQBXIQq8YoA0Wi2TEVlyQxKjoP+4o9qHic0FI7id98FcZvmvA1cjpcVMJSXXfWdGOSiRbwrXoa3EiSsg3gRMqncTYwyHQl7p6S9iX4wUoN5ouqpUxBcKbHNS0m4nYm2Z51Y10IhiDrceMk3owlTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8ce4R4c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae102702so34285835e9.0;
        Mon, 30 Sep 2024 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717659; x=1728322459; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsYWdpVZwQRCqAPkaOYwAzrAecaj1TlBisV5g2NwrO0=;
        b=J8ce4R4caLNSGWSsxZQKvoNdCgsTy8NwHZ1XkVFOwTOkSPP1gIQYBneJDVEr8o8eYg
         Az6SPsU44LuHoqhSjIHZ64Rn2FV5m1fXh9WYwseeCjug69/+P0lnmZIrZC64iztxaLbu
         ZDM0ai2GhMB0X34V1L/kS6FvZib7q9/8ooF0zYWihNAwI/d8ffs77NdEGTjIvQWsZoFA
         NiMy4hN5uIfLlrPbH4WrkXIF/OKOY5U8fbEL0BaqGBWlIWSWw+cDchWjTGvVt7lOZPZJ
         3hkhARfH3x6R5xbb0c9u/pWqe12h34V3hP1yV+sMSSvtTtwYh9P3Rb2v/oOEyuF9j0oz
         aZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717659; x=1728322459;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsYWdpVZwQRCqAPkaOYwAzrAecaj1TlBisV5g2NwrO0=;
        b=Z/vLKsw9PXpPiBSpYDodc69iXwl0lKBHoBWG21oedARFUsVIfdL2dJ+XNrH734qvDz
         DRxKV7fC3B4ups5noP4oeBrXTVeXdSsFjsRLRf5UK72h5W1CfX/gdiAdAiIv+hISsnYp
         5df6eyigy0WXKkCpNUVwoMa/HlFe3HgR5S/XWM6texeNNzHjPAndLqdTqVnC4GMDnXnq
         XwMiVj2OSX1Rx91V9uM2OVjOhoJ5oOxVi+xNvOTXgvp2Xm6ajR4cDZvvuLFp7slrcF/t
         /dM8+ifq0tO8NmDENFLyX4/dhs26QjJ7FOxhwG/a9nGJjlA/6NowkovOjHvpqt3HaaZd
         +/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVCbI/jsazaoaR7B8inFIFzhllG/P8zikZB5/SBDLY71hEGqAvNW/NFLJh1zK5iIBg2PYj6inPdnkowsg==@vger.kernel.org, AJvYcCX3LYgBF0QDtBDLt8qRS/5wUV5ksZ3pwSs0N8IYxlFuJnTCdJFCitcv3Pfc00cwER2NgJqkqLwT9lOOCvanHxNP@vger.kernel.org, AJvYcCXbDWrchYobXPfZEolVFPhQQY1cad6yNQpQvxGHdcFkhodt277e0hd2AO0X48QN1UtQx3vxREoiZs19q64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFm03/erE1xJJAVGipY3fYgjypP0IvSi33skgyvCfQDuuaZm0j
	1PSKqw5xUc61mLNEpylsm4av5ivT8uCslX/1U81dvCHSXop470aL
X-Google-Smtp-Source: AGHT+IGyQAGUy1uVK04ABzrqVzGoKVcZEqWYUj5CwNlH33RsD5D40CyRH5NwalpAhhgTSgPOLIPlpQ==
X-Received: by 2002:adf:fd52:0:b0:37c:d0f9:58c with SMTP id ffacd0b85a97d-37cd5af2de1mr7563809f8f.35.1727717658937;
        Mon, 30 Sep 2024 10:34:18 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d01esm9706942f8f.3.2024.09.30.10.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:34:18 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/3] selftests: net: add missing gitignore and EXTRA_CLEAN
 entries.
Date: Mon, 30 Sep 2024 19:34:09 +0200
Message-Id: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABHh+mYC/x3MQQrDIBBG4auEWWdAjYvYq5Qu0uTXDBRTHCkBy
 d0rWX6L9xopikDpMTQq+InKkTvsONC6LzmBZesmZ5w3YTKcUVnxiRValZNUSfkoYDu/Z++jC1O
 w1OtvQZTzPj9f1/UHyOyX2GkAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727717657; l=959;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=8U28luUy4GCKjsunTL9hsf8j7qGd189igaqyz1LIpok=;
 b=FeJ7P4/LKxoW6dlf8TTHmk/wl+QdRr+XOOtaMvo+TIqbEacVtLOClbRbeKW8xVVHT2jl3ofuu
 S1sFBt09mYTAS0BsCy0Tmv1imWSqwLSsecn4CSxqMte3Ijt+fylarXC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series is a cherry-pick on top of v6.12-rc1 from the one I sent
for selftests with other patches that were not net-related:

https://lore.kernel.org/all/20240925-selftests-gitignore-v3-0-9db896474170@gmail.com/

The patches have not been modified, and the Reviewed-by tags have
been kept.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      selftests: net: add msg_oob to gitignore
      selftests: net: rds: add include.sh to EXTRA_CLEAN
      selftests: net: rds: add gitignore file for include.sh

 tools/testing/selftests/net/.gitignore     | 1 +
 tools/testing/selftests/net/rds/.gitignore | 1 +
 tools/testing/selftests/net/rds/Makefile   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-net-selftests-gitignore-18b844f29391

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


