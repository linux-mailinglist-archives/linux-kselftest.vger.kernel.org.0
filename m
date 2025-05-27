Return-Path: <linux-kselftest+bounces-33832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5EAC46B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 05:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A71188DC78
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091EA15383A;
	Tue, 27 May 2025 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATm7chRK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697FBA38;
	Tue, 27 May 2025 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748316408; cv=none; b=VsqMOYt6liElrrYfsByJK5rNbnoG2cIcYXolPB3scrq5RhxkEqNO+qU5DwMMsylO4vcR8KBc/V81lqnfouyrUITz6xlpFkY/HfJzPuLd0TrIXFB0ucnM6NmN8HIHkcLxEHeIHo3w+s6f6heg6tjk9vuulCjoJ1akdjBqOj6oAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748316408; c=relaxed/simple;
	bh=5AMmgb7ijJfzCs5AWWsr82LJn3t+meyVy/mNWRNbxIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4OuYoLTdqRbB0+yZASKHut83CLKbkcJQucW3l+J5ht+UufRQkHeQKZPT5TVEqsIgfpnAL2cZAsyFJRBsGG5r4UHBNIHHxTrDgcThJI/RQiRhhsJAAVJS4+ul7lrwUf/GaENkHN2LpVVt+vIBPWMJjTBs4A4w6NEqBWNYoqMLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATm7chRK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c9563fafso1829967b3a.0;
        Mon, 26 May 2025 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748316406; x=1748921206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+dQKs4smeHKhBn5vB7/b04LpJegWUgXprxkxS6zC3s=;
        b=ATm7chRKuFCTaF5Dahs764qQra8c8+/sqgJcfytp7wBGCsWak7Id7dc7VDI9SW/ncs
         bYLPO9b5eTVYARoiniNTT3fb4voAfMtZrD7HsP7+PfD3G67o6vW6PRAFP7QkH1Zt0YuV
         4pYQV6iIgDeMgpsqLlxHqzzOblL449pRcWtWTn+01Hiv0r/Vwl0BDm8xaHjbB0SzlNkC
         +WMohNlkOS6b4RGH1sYAK8e3pw1ycEGZAnVg0+CmFz7QIjOOx3faMl4ywDjIVdJ379EV
         9YnY6fErzWeRxxh52XRNzc2M8aLTq5vIwQHae0J2vCiyRLkT4jdDiMfXaYSemYtOEhBT
         fM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748316406; x=1748921206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+dQKs4smeHKhBn5vB7/b04LpJegWUgXprxkxS6zC3s=;
        b=unterzQ4wnZY40ne0OxHudSUHd9IZfLo/Gm+/EBRRPqxuuB58v6PSczDmnR7UR+3EV
         Eg2dhgX18xe9uzZ3b6wUfHjQ275n2V74p78Z2j+cFFwgvQ/nmDP6hEilR0k3FL3hiuWH
         +YXG1nxJ92xhEOKb60LoIgvGmO4vLoRU4KHpoD1ujbrYypUFRUM11QskluOzdhMGKuOS
         1WbYQmM53AFEiHLhbwGGvVb4eycK5wPUvCCglJquLDZHIbk6aW5J+e9Qpjcx9WZ7W0x7
         1uxNQ0sxq+MCphtO856O84F2LNtQafp+bHKUQs5LbAl44SUGXGKxDl0Ydkr9Q+SUdcBv
         l75g==
X-Forwarded-Encrypted: i=1; AJvYcCUrJI6jGUmZS8yaq0ShD1BSD9ZwRZ7lZaLVGqQWfwSjC6y4LbpvKgY5d1q0oPx3P9Uxt3xSoShIsdVwZXs=@vger.kernel.org, AJvYcCWIkX6I5B2ZkIhCIEJNZQvbFqInfCcNr2ZzD945xSj2UAGidVMimd6ayaCwesTIjw1nXbzRRJKVB9sbR5wikzYO@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzIB8u2KauKEFrHwKmWg3AOZH/MD28lkvE0LTN4/vRjRsbuZb
	PKxrI9rl8qkEBwa9/SGZoTBABDGRdzaNJU+VwUqluixLkrLTe9173KgRtCyp5GlsgtufAQ==
X-Gm-Gg: ASbGnculztkX4Kls101QtvvK/oUoBwxUIAfuej1EfOUbbsi1hlAjGe3RJn/IJgk+B7j
	jcWR45dwQ3KxTNz8PvFPA7vUSvsc9oQWRvzoP8jFs778vDOnaoe4SaecKMAkOph46XNdtl/68X0
	pAONsr7oClsuwTZVFpM5MTdahj2Eil2ZdiYglEXLeaR5hz6ImzPOEORHat/OyJK8ZyJMO9HfEi1
	iOMMMsto594QnHWrbXd2XxsL9X04UGOT2ONmywraKbkCQ1OCr5tLE1ikAsamxlazRXay7uEeJyP
	DVv2xxy2SYx3QjUVTl3eteuPkfj4rSl86KtjWW0TopGM7mB75rILnaGXmLHSWlB8p3HEeUw=
X-Google-Smtp-Source: AGHT+IGgF85+/TM8/Lb9bTE3REIcJSRSSaneox0Iitx/fr11aMcDr510JMXivb83lsKssFF1zcKoxw==
X-Received: by 2002:a05:6a00:f0d:b0:746:285b:595c with SMTP id d2e1a72fcca58-746285b5bdamr1242815b3a.8.1748316406483;
        Mon, 26 May 2025 20:26:46 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74622b3b481sm865926b3a.131.2025.05.26.20.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 20:26:45 -0700 (PDT)
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
Subject: [PATCHv7 RESEND wireguard 0/2] wireguard: selftests: use nftables for testing
Date: Tue, 27 May 2025 03:26:33 +0000
Message-ID: <20250527032635.10361-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set convert the wireguard selftest to nftables, as iptables is
deparated and nftables is the default framework of most releases.

v7: re-post, no update.
v6: fix typo in patch 1/2. Update the description (Phil Sutter)
v5: remove the counter in nft rules and link nft statically (Jason A.
Donenfeld)
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


