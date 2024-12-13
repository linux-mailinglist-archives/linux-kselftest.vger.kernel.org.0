Return-Path: <linux-kselftest+bounces-23289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92B9F02E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406B4282F7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 03:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119413D281;
	Fri, 13 Dec 2024 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMt86Fm5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7F2AD14;
	Fri, 13 Dec 2024 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734059317; cv=none; b=AN/wFzTsbzqG5x4FF6N5BMnbdua08DQtRgMCuBwcA1VyV7xsQxHGIrWmGfMtBvj18dt4gdV+hNYPj0Xeq7uGL1hoC5vMARJPfTuffWiRa/F7bLsBK4d1s374NxzRIyP2rGNKLItkLh5kik0I5xa2D8kF1rZQmkIut7FaSPFCD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734059317; c=relaxed/simple;
	bh=c4yS/DaE4EHTpmyOzsZ+nFXQdXRCuXZckMtCqXiaAug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lg2XELogDZOogVWkQDHageg6OQIx5nd/DINtCwF/fiUX2CLX5etLDE4PZNSD/2cax6/1iJXbMVfWoP57tP+vHF3IZpa2iSIsw8r2j5Wn1ap0Pd0kLk5yW2VgVI2T4r594gQu9VKGbQc/vkQSGyy8J5RzKNfTIQC3Vfy+ONLBWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMt86Fm5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728e1799d95so1500135b3a.2;
        Thu, 12 Dec 2024 19:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734059315; x=1734664115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsVQQttPAUDux//1Wpy1fzssaRVCUnaS6/5ziBY5sHI=;
        b=PMt86Fm59iz7iKuhbWsHjAQ9XP/7bDhb/YHZewcIaRQZOJwCXb+oJCcb5LMGgDnzyn
         8QBILgP9vjUqCTEA3KeScWJdgJ4TRBhacJcLJY2RHBuEMjKzcGxZWfo3YQCI3zA0FPu4
         HOdivKX1l5FkazS3BfKzz8vtsAtQ3xLUJBGds0AEXNct4gps1gAHYh/hgEuY+cPacqfL
         jBrguBCEoSWZSQ5gKZijgBfnr1eYwaCCxO+OS0+llcDqN22zFk1hB+RisJSP2YLYalDi
         JnWf1wKrpIA0Q6RXfwkwPv8FpvGe6jZgc3u5k3OCfqTALNu+p5t61nxhwu7Huh3C5rS9
         3uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734059315; x=1734664115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsVQQttPAUDux//1Wpy1fzssaRVCUnaS6/5ziBY5sHI=;
        b=T97HvcuJ0Clb0NZw6/fGNscguKB93FUMcN+ybDVvXvazJCAVuIGn2PZ+49r0o28ezn
         1TaHlQ8ZPtYbTXx7m37RYxRcH7z6+wbo4Mi7ah6QkZ7AG63qiSIt2nuY7XBA/mKOmfaE
         K2XlxpfjhJctFy1KYaCHAGmGyFND8IdLsHfKpIWjUE6UZV+CXDqUDmuVWXCd9nOIoxif
         VFtpQLY4BFrhL0JqsP6GsRgpBkjMeuTEzGw54tVU4GhPVcEeACon207XsTrNs8qPxmkh
         WUkjzwCuRDdCvBeEfq7G+ByZthzIysKa2EoN0CKQ+qsGgCcXXl1BzbjfTqRNiw0yxJ0m
         nK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS+ISP7a8VvGKz7+JmVhMVZc8jItV27eAypMzlRiGCQyPMLWALnlVMzEJU0cZl4TsnavYGDuRelQs9e53ID1h8@vger.kernel.org, AJvYcCUaVeIK0+xermNxPg6/oD5JnnoQUUzxQw5xvh7r5I+vB1j7PGEZQPOO0C3Vse5FyToPY9A=@vger.kernel.org, AJvYcCWtrD9tmWjgZvPKBa2d8syMaZJlPXWXEkACnIcD1hHh1ioLtrKsRoMyT6oeISDywXqaJ+BzNV1BZjXA2R0o@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjYrD9EGxkcdN/0EXWEANO4y69yeYU+jIVXYZ0xFqpQT/UgBO
	GAzWnSuFoJVvvdes+vWzxmP0nS8bQV2bk0MotKafxSJDqurFQOvM0LpJCP2e
X-Gm-Gg: ASbGncuDKC8I6Wh9DJ0zVTpsfXq/NDSRXAx03CWDAek4p9VvBWrT5UeqDmoaIV0SVqw
	r/aEMtiQY1JrYuerq4AK7NCKbmDZ5qfwghvKVxWUm9OcUN5IpwEkgGDWrfViTtPjhVK7Qy6d7Yj
	eT+ZIJrDqkp8FJ3+VV3bhTtW9C3cDMD4pO5PsnZQxjbiiYkVD+SIwCGEX6mpkUV3D+RbUpxbqGc
	Q3eobKZRjHy+F1B9kF/zo45y/XSEtyB8pRbBCETOhIxiedou0RilPsuWbsQjXFwrVwTtx8O2scY
X-Google-Smtp-Source: AGHT+IH5T+12UrShKAcJ0VU5BfSw/tnglHGREsGWmhbe31fe5uxZw6FabVtRivIabCVNyDYxfmiysg==
X-Received: by 2002:a05:6a20:c99a:b0:1e0:d851:cda5 with SMTP id adf61e73a8af0-1e1dfd2a7a6mr1667673637.14.1734059315338;
        Thu, 12 Dec 2024 19:08:35 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e4b13545sm9152783b3a.126.2024.12.12.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:08:34 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/2] selftests: wireguards: use nftables for testing
Date: Fri, 13 Dec 2024 03:08:17 +0000
Message-ID: <20241213030819.49987-1-liuhangbin@gmail.com>
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

v3: drop iptables directly (Jason A. Donenfeld)
    Also convert to using nft for qemu testing (Jason A. Donenfeld)
v2: use one nft table for testing (Phil Sutter)

Hangbin Liu (2):
  selftests: wireguards: convert iptables to nft
  selftests: wireguard: update to using nft for qemu test

 tools/testing/selftests/wireguard/netns.sh    | 29 +++++++++-----
 .../testing/selftests/wireguard/qemu/Makefile | 40 ++++++++++++++-----
 .../selftests/wireguard/qemu/kernel.config    |  7 ++--
 3 files changed, 53 insertions(+), 23 deletions(-)

-- 
2.39.5 (Apple Git-154)


