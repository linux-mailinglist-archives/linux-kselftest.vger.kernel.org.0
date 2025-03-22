Return-Path: <linux-kselftest+bounces-29600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EFA6C8BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7458B461CA7
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5C1EE7D6;
	Sat, 22 Mar 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0pWfC/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C47189906;
	Sat, 22 Mar 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635831; cv=none; b=hhxcZIdiv9A/itf8D3znU7UP/x2jvkFr5llWh+wKuANXxhgrKDXQwK2JNUAHYIG4bZhk/LjGhaDdtCcWxkRFwTayPaYRCjop6tHSqio5yzbZdHwNxmM6UfRw2TeqxvaZ3LAYppNfgVjcBiT0q5/nxMHtenk8FbZ20JzMnUar4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635831; c=relaxed/simple;
	bh=/U6Iqd26Vud+PJWtK0Yts0C6OaDyqiWKSjsAH0racDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKGVu4xL2EXAmjfzgLNNo22NCV5RQ7gu8mbhDHIGQwrWJJMNANXg9eiPH5YJTwaEo7/JE6o3CjWrFEgzCCOaSxY1lW/vRI2pBjWjpgO3EVswo36H1oyDrdS2gZI+JgSJicwwUZcDXE44Ig9GZlOGA42fwIdYuYeRx/iEwsCyonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0pWfC/9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22349bb8605so63655575ad.0;
        Sat, 22 Mar 2025 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742635829; x=1743240629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Irp+upazmFs5DB76PQDgJBxKxxQDsLsag1Qj5zhxeRM=;
        b=N0pWfC/96jRrt42I93oyNDLIsCKdW7d/ufNzdpMSwc0VEae9goG36lx6Vja5x/nrp1
         hFrBpLQuZ6UEPAOeLBp7JLaq3qiHpNHv6yWfr1OD7Dkd3lmt3kii1NxXqz++wfZwvi/p
         CybREFwKISDQQmU/SU1WdgQ1V8XoYnMzBPwqmPAb/rCUj1kjW14vNY1J28DsQkIjEYCn
         HuqaYFKS6aj8sPh+fOiZdFcAUFv/Hh4FO1UvWJIaHTRGbpEArvys3I4C/6Yd7RrPBFrA
         v7xS90NwhzidjCjv98h8j1SJ2Nj4B8xYbuRHgBe4e5C+ylxu3w4sFxI1W20rqHsjpMvM
         lPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742635829; x=1743240629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Irp+upazmFs5DB76PQDgJBxKxxQDsLsag1Qj5zhxeRM=;
        b=JI9UMz5xEqftnU/vtcjnkVWzjfc/sqdS6KrxqHEmYmSx6szifCoqIl9FVZ8f8fPCfn
         1YIZZRQ+7WSn02lfigfQZ/OriJPt70KhLUJGtmTUZtPDdqrhaqxOCw/WMQkjKNwjYpFD
         54Cq2igl1W2LS2cxP0XlqwxjMfB8Cl+3JVBDS7fUyy1eAwWuoBlJH9YBcYPfTUHF66wN
         2DrFQAF4rhG0CAaFuH4IyTh3+u1c4/KLfxkcvWbfq1R6EHeVfiByng9b9WZUeLSB/UH5
         iWGMRD4/BUtYzkblseg8iaKDT1KtpMieEN+1PLFSJoeakzBScDahTvW3lYgsBmMUu5/H
         mXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVufaY/wXYPfuwNrsGgaj/tbU6kixNYbVgSzzmKYZjJo7YwzRffA1Gldsh2sE4OVkyDuf+8JHO6p6TrS7/MNUI7@vger.kernel.org, AJvYcCW+khuErB9ELQe/LYeojyd8HpUzJe9grmgSRkIsb0EcNhArJ9y8BZwGyr/72w6KvWAllTZO3wYkaElvxtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDH7DKFYFRVq+qKJ+Iqyz0HoPUevuuGdIm5Dgf7Md++/rX9FVQ
	sV8eH/Xi2avbv10uehOEE3dMCE5BfCr+Cw+sQW9Ozr0iD/nNoTEE60rGquSToLk=
X-Gm-Gg: ASbGncv/DVPi/jE+IgMhMsTRbFcsUvSq7rLdvDQpyUVyH72vNCHoCzKKSbTwKnLMhDL
	lJGQsqBzp4AnjZQyfibIkE0Lx1Tjgdixs6ahAM8TXUwm7Tk9u185ZsZunk9CIrKbaQFIJ2BgQFv
	I3hWBcYaCsWhZt+Asoot0Vss+jFJWyvta6DG1qlc9GP53bIOAdbsOvoBonEOsB5GmDBWEcuw/YR
	r70HtxQI49mnGbXuNHXQ/WkdW5BKXJGPqFV2zXecGxBWrw+FlqATfKSshBuJF8ozOEX3M/UWf6J
	XeIWZ6UiSnvjAHxf2e1EbCZ1P/90ZKEC33f8kbuKahBSCjFDPCq7vf6/829fUiuz
X-Google-Smtp-Source: AGHT+IGuQCRnSupF0XghzaFP+eOBI/S/qSer6RZlfeXZQYP1LbR6lU52d4TKY7O00O//CA1zLcCnKw==
X-Received: by 2002:a17:90b:17d2:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-3030fe569d3mr8666490a91.5.1742635828887;
        Sat, 22 Mar 2025 02:30:28 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58c24esm8452440a91.20.2025.03.22.02.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 02:30:28 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>,
	wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 0/2] wireguard: selftests: use nftables for testing
Date: Sat, 22 Mar 2025 09:30:14 +0000
Message-ID: <20250322093016.16631-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set convert iptables to nftables for wireguard testing, as
iptables is deparated and nftables is the default framework of most releases.

v5: remove the counter in nft rules and link nft statically (Jason A. Donenfeld)
v4: no update, just re-send
v3: drop iptables directly (Jason A. Donenfeld)
    Also convert to using nft for qemu testing (Jason A. Donenfeld)
v2: use one nft table for testing (Phil Sutter)

Hangbin Liu (2):
  wireguard: selftests: convert iptables to nft
  wireguard: selftests: update to using nft for qemu test

 tools/testing/selftests/wireguard/netns.sh    | 29 +++++++++------
 .../testing/selftests/wireguard/qemu/Makefile | 36 ++++++++++++++-----
 .../selftests/wireguard/qemu/kernel.config    |  7 ++--
 3 files changed, 49 insertions(+), 23 deletions(-)

-- 
2.46.0


