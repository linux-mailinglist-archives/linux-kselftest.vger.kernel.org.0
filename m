Return-Path: <linux-kselftest+bounces-21922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E119C6FC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE712868C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD81FB743;
	Wed, 13 Nov 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7A2jNgW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5E1DF97D;
	Wed, 13 Nov 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502323; cv=none; b=ryEiiCW1ygrL02Emdj1BG488rXANb2sDzKgKY3yau20XkBob8jlL/vOhkZsz3dmfJdriYxnPQ8F8NeM4ZdE5PuFjxg4GgA1pXPEPiNI1jZPaslNPyI+rbHEzwciHEVOtOuZCsVBXLwPOCDu3B2J0huizGCYpufnhrZ4v9sl9Zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502323; c=relaxed/simple;
	bh=ZL4tb4tyjkA3ngZw5JSNkQKoqazR6ZjBwQyEWSIY3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WCIIquwb8r4cyPUA6Y9Ee3dHKiKgaL50BqVLzPB0bE5spcLk+APwh+nlATtrhFEcVDOkV4rduz8Q6bva2UwqFFMc6hws5bYHPqG0pbJVvfc89kOkUuyxKoQJEx5PChMUPzRzptc8yw4zPHlx14ZxgHy9FmKTf9hGY9tVj2QbhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7A2jNgW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cf6eea3c0so65230905ad.0;
        Wed, 13 Nov 2024 04:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502321; x=1732107121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CwYc4d5Eu0RMIkZQjvwgqzFCRj5Rn8qF1GZCxG3QZAQ=;
        b=Q7A2jNgWl+JRxa0m69FdCiMjuO38JTRaMhMQgQKt77oagQ9DrJQwtXSSFpUz5m4MTP
         CIX+JSSX0Yv2OtsKu5qOh9u8srrON74e5b3xC6s+qiRamebLYzND4SrzdtcggXJIQbIu
         iLfLydn1GzrHcp7rQd3o2bdD8m8H/Y1vRNjt6Zr1nyG+ZpAxNnVidzjBZo7o/QJn03bY
         I6wgXdD/DJ1MbB5+nPMDmtzp81bQ0521hcRLeF7BYbyqaksd6Ibtq7d59GAWIg2/4Aka
         GCtD+vozmu5VkB+epGirOxQ+4O+YSEUvKJn0kxM0TV0mIu7xDL70Ek4qOY7BFlpqRU14
         BMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502321; x=1732107121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwYc4d5Eu0RMIkZQjvwgqzFCRj5Rn8qF1GZCxG3QZAQ=;
        b=xLkEj9jTNh2ZD/Vk/nY3C5yi/eoLwbfLR9Gjrj7zQTITJQdesSkOWBFSIMRe5LYixH
         RD2vzhsJYXZrdrtaLXJ+rdIvblRZuuyfraxGoZCJFSfjjX+wOWfPYqS6N6aR4X6tw9Ap
         h/jQDNAx6/pMzDFLAfXoFNzOEOeod21TBeed/Py7ylABgGyJPS5CtReMT6Sb2rz8w++d
         +5eM0J0pBIuwPG9gvfYX2dG/c7laB/WFcv/ZunT2yHci2HveZjJjZ9frLPr1b3gT4x+n
         j6cGOzeLT+nNljhXYP9u5jIUkzIJemXd0yJFKiNcrnOInLS944dbdaqvgNFUWpAH/zry
         QYAA==
X-Forwarded-Encrypted: i=1; AJvYcCWH9oFQFGeSKk+tuo5qpil1j7sXRzdwgzo/LbDcoljkSj2I9Kph76agoZkissfdAD1bpvcK25x1tkgzOpA=@vger.kernel.org, AJvYcCWnp3gxc3+IYkGy2M+haQPT31A+jts9W5tfRGuVsgx+aswpnQnQiM28hrCgUmCvwIKGi7JI2cur49yETW6q/RwB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3+sMrT6tNNoI5U30Yq5sPO6+HFgEoxC+1g/RN6ENh6CZDVEI
	pm4qQWCTq8xpPqB9Tp+XzInH4OS+RIlGldOX+rqx77mXHJIOsKzedGBJ5QnpAm3NnA==
X-Google-Smtp-Source: AGHT+IFiPl3oBKoofvZbn+pOjY4pAF7UNAdAsAV6dCifV0l8Mayxr6JOwfe3xQjMmvx1/jktOGIo1g==
X-Received: by 2002:a17:903:4306:b0:20c:f0dd:c408 with SMTP id d9443c01a7336-21183521d2bmr174148815ad.20.1731502321074;
        Wed, 13 Nov 2024 04:52:01 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177cfb0ecsm109276345ad.0.2024.11.13.04.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:52:00 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/2] ipv6: fix temporary address not removed correctly
Date: Wed, 13 Nov 2024 12:51:50 +0000
Message-ID: <20241113125152.752778-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the temporary address is not removed when mngtmpaddr is deleted
or becomes unmanaged. The patch set fixed this issue and add a related
test.

Hangbin Liu (2):
  net/ipv6: delete temporary address if mngtmpaddr is removed or
    un-mngtmpaddr
  selftests/rtnetlink.sh: add mngtempaddr test

 net/ipv6/addrconf.c                      |  5 ++
 tools/testing/selftests/net/rtnetlink.sh | 89 ++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

-- 
2.46.0


