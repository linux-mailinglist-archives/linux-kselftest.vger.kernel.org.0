Return-Path: <linux-kselftest+bounces-22337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E243A9D3769
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE13B21616
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A118A6B2;
	Wed, 20 Nov 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8b4Pml8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D422318;
	Wed, 20 Nov 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096280; cv=none; b=hBTkGkQUbWQdYiXP/uQl2xicI6xtD1WbrvJMOSZHMQH/ECP7oRCk/HzB2gOOibQd4CWUVa0tg2PVoMLsdOAKVXGHzH2R1C1QkkPQFmVZJQMwBl8+SLInl1cHRkoGjgd0hlfeggEJyAVMZ5RfyEH4eDmgWdbNOAedWEYPwEv5Spc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096280; c=relaxed/simple;
	bh=QnEvV7M7dRUWTCULBMx/LYYNVmrHpXS1rh3A+FZ5syA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GnK41zVDvgU/oUIqa3Ecn8mVhA4+kT3Ivj17bKjUNytmJSq8yLf+41euT0/S7/RVDymBxlR4wLynXe/hYhZ9F7aJiC0sH8kE2nbs3xWkeRWgJOD5SXkzOueW2DnRW0Qhf4Jl8LV45loqjqxsDwHwvljsapsZmiHkWWmjNVruJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8b4Pml8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea8b039ddcso1439283a91.0;
        Wed, 20 Nov 2024 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732096278; x=1732701078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rS5nazrbc0MnpmMLjGy+J8J5XBtZBX25qoYPsMvVIlY=;
        b=B8b4Pml8cnF9se7V/yt3XvVo7iOm/B566VcZtsmKbZnv7VzhAW9cKYRXAQNLI8dTTM
         yvG8l9lEZK6okIxwlUTDdAI+NtuOo5OkpfecWf0MCzw0XkL7VMFTSFoaGtySY4XDxabY
         KhBkGNKPeufEIMreTm3H40CJ/cZTDAqZb0g4EzpLq/sEzcGLjpYORmgu9r8Ukw6B+DmB
         zC01do4qQM51RQAvkYJ+HONPbtSMFlS7oDLv5koa/w9yUIItaYBGQkE1Kd1JLnO/kxF+
         XEvCA4hhXJjbh3kLK3IcPBfvOQT7qBioXHbUxUY2hdCCbkZ+0co3KBvA9NbTmiMs8ZpH
         /0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096278; x=1732701078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rS5nazrbc0MnpmMLjGy+J8J5XBtZBX25qoYPsMvVIlY=;
        b=tpexs5SealEaIcgk9DiLI+XHD2bjw26C0wqLlyDcoCHsaOUxKU4+hq6BVMA5h+1TdS
         5Fg2hUB//qLLUmqbEI7elz4T71wu+KjohYIyHBnmE0Z01AZNwZmx87gMbgj7BgDIixtt
         VIbo1e5Y/sQyx3rYVdbfWl9l/0++uDmmnrlOWw+5Q5jFQdiKtC/gD1O+VzMeEaDzMcc8
         niFOlm1xra7QT8bwEsNA6PrM8il8u/LqVNU2Lq1D5ity7b2DFid9UHp26P7j50Q7WsqY
         GCsweL+vc9coJGuwIlt0TX7AEsYcOFd4rym3TY3wnLuGPD3RZiGSFpZyH/bJJPyk1rjg
         3fYw==
X-Forwarded-Encrypted: i=1; AJvYcCVp9dJmmFcvdpAITh2haPbomSsaNw7SmGXMVn7Ts8/CA/I/+s1tu/r+pWmsgK12m1SKk2OCSm7tPW6mPJ07UfT2@vger.kernel.org, AJvYcCVzh+gagIqkagck9JWztEHHEBJBH86yzdqKoEGGGRIR0/7hg6hIZk9sKeinc2E2FZqS58hnrVqgUMS3MvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXeHkxvbVnEKzssw2KuXzM0F6evm7pyyA/UqjTLYs3SC/j+6iB
	uHn+AWWF2dmx/wkyh3O/eEOLh0C7kdXg6Gj4lpIYMrhZ1wgonlNY3EnjuquFgXM=
X-Gm-Gg: ASbGncthq8eLQqFGPMk1mEQGrnf+iLMkbknmMJgxs1wDiF8STUhdPSqaAQDhpiFW31v
	yh/p4NJQaf4KdXQ2eAC4FRoQIM8YFtKK3Fpj2jW7q1u1VI4Ve4ZkLKFObp7ezetMU8sMJUXN5Vw
	CdddVr6M3oQ4wKfCO5YPrXUUxTNbe1caPyUzDvuMCjNUq6zPnAm6AKkmLo+0W4z3u4Ec7OjUqcr
	0I9M3DWy5ikKTCBiWDFh0Ma4RNVFnpr9nPr/VFwHS6Cpls+q8MNYCNn+9I+0PHs11KysQ==
X-Google-Smtp-Source: AGHT+IHl7gHPKMf4LQG3giGJiOy/u4nlubmYH4+Zq1qHn9Cm6IO+ffN848IAgrodnrjGDMxJ1ui+ag==
X-Received: by 2002:a17:90b:3a84:b0:2ea:77d9:634d with SMTP id 98e67ed59e1d1-2eaca7448c4mr2596265a91.17.1732096278280;
        Wed, 20 Nov 2024 01:51:18 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de5bbsm887338a91.36.2024.11.20.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 01:51:17 -0800 (PST)
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
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Alex Henrie <alexhenrie24@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 0/2] ipv6: fix temporary address not removed correctly
Date: Wed, 20 Nov 2024 09:51:06 +0000
Message-ID: <20241120095108.199779-1-liuhangbin@gmail.com>
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

v2:
1) delete the tempaddrs directly instead of remove them in  addrconf_verify_rtnl(Sam Edwards)
2) Update the test case by checking the address including, add Sam in SOB (Sam Edwards)

Hangbin Liu (2):
  net/ipv6: delete temporary address if mngtmpaddr is removed or
    unmanaged
  selftests/rtnetlink.sh: add mngtempaddr test

 net/ipv6/addrconf.c                      | 41 +++++++---
 tools/testing/selftests/net/rtnetlink.sh | 95 ++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 12 deletions(-)

-- 
2.46.0


