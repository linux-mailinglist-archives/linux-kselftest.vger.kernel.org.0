Return-Path: <linux-kselftest+bounces-38206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17AB18BCC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8483A1957
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D7B221267;
	Sat,  2 Aug 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0/A75IE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55220AF87;
	Sat,  2 Aug 2025 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126688; cv=none; b=PhS67p1NOyEeotYWnDllUhN9C2QMeIWjEwGCm8VZTjJUoJ98vOAjl8f3TSmPde4J/MLVfe1Rs5Zy59nXEmPDPi8Hh4QTpYiVAQiMp3kl6HBnzeQcUOvvwU9QzrUoIOEOQJ7kZONlKjbsMeTnUVo2Lph3wHidoHxvSNiVjpguH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126688; c=relaxed/simple;
	bh=h2teT3pd09OM+PIVXgepBlvaOtU0HtakDUYKutozKGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1+DzCy31vkuG5v1kJQkbidTzFw35+p/GstCf9A4EXv9ClnTL0dnczXJUAn4aF0DAmMTjrPIQwq1zlKmbp1tcLDCAeuANWt0wzlaqCItt5Y38CKbavVXkLTa1RAR7Kh3e5VyxY3kCzfzGDOjvuCBvZm/cMHSEHEBdVIBDWRYkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0/A75IE; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76aea119891so3681483b3a.1;
        Sat, 02 Aug 2025 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754126684; x=1754731484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KF2s+yc2RxKLUVYHR8inXYwOSGhSIe86MFGDiyC5+rI=;
        b=I0/A75IE7+ogIYXmGZxG6qQRbZ4AO9S8L2GJiOQzehy0hlAfOUbz2VQ1qlUsjAeSot
         ATJ2BmHPLOaAcQuiS9YRDjeS60puvyNQ5eAdGaYB52SSMz8nvzHqE7P1h1rYWtrAb/QU
         ulbn0CS4/yW6I6vZLZreqj/5fTMnVR0Zyp6XDuM4+/DW5TfVH7DddWiVVQzZIjfvocdR
         nybTpUDqITaOW+Rfv2zHhnKLH2/wL2vFqT6TbDd9h5mf0UMAmITde/S85fWV6qViL5QJ
         WHX6O+GSyvQ/NRm7t4XsmLwASc4MZEmU6V1lNR1+FeaKT8vcrmHvUSbjtXri8q+N4UWB
         +Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754126684; x=1754731484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KF2s+yc2RxKLUVYHR8inXYwOSGhSIe86MFGDiyC5+rI=;
        b=pjim3xU1NNK+1zmUYeh0HDBCPCqV1xUCv/SVHZXNnpeMgf7fsGV+M57BBr566Dowbs
         WLsqhdbnkC6lj2g3C+ID5TUwebRTo0/UqyjHKd9Vw8xpWsuCbpEG/lvhUkaagdLliOAc
         Ex+DrQ47iBwZlSt1Yc2wLviiqX4/bDzDqqWdx/Sx8hoY0gvwNj9bSMtcHLqye8W+7udN
         XjyarLMkz3PZQCrn453oJqLXGFjCz+NUNvMBiDkoxEoa++GcY6bWIDG4hoXbH1B844L0
         36t4ZbC1BI5YRl6kkaFxy0LFZcQezLSsU/cF898hptyspxbhJmByLkEwZC66xwAB6YKR
         Zc8A==
X-Forwarded-Encrypted: i=1; AJvYcCVEoUWCENh92iagEKdwB14im46jUvMk01LqMNvRiiEQI8+elqXJQgtU7CIcfbMx4bG4PRsq11pw@vger.kernel.org, AJvYcCVXEfTbT85HAjV8JO/5V/5jCotKd1tAKu8f5FUSLlvK/8c0qXGbHkqlRjpxWSRCWm1GamGlPxfxFBG/fPA=@vger.kernel.org, AJvYcCVauZpqYGM43JUJBFfJ35+3J/XT6AQpWt3dxNxi0bF+mMdWuBicSaIFJ6K11CEe+fgvdJq+Ash41F0nMstDxdM4@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPdSpnGzJwlP5Xw8dYj35hG9ee9BPDYkjrYhwFj7QvDP0gdWd
	G4HxgMM7mTBs2HOVCyDOJkAat/u7W8LerCq8/Zux060YsaT3OxmBnD7fdvLCfiyfE/U=
X-Gm-Gg: ASbGncva+QaOWxGk1oL1N8BpJ/DdDkegP3TQlhd5SkFPIVeOKgh5onDPEl/i4LxpWLR
	tYNLeCoTAoDYvv/SUwfi6Xt8S64/3xIrtXxBMy0BCOXSgoir24rLF/fFTarSbzWR3HskVOv9L6s
	XPdlOiAHrlPKXdlDrCHsph/N5bmT7WMAU8ti6CwK7DgnRpTQOc5Ikwypzo5Yk0JDWeCw729mac2
	DfAkXUx8nPwQD4hmvnzKnwQP3+Eu6xYQ3I4aBQqeXiKue4VPw0Hj5W5+PASKlZvD/af7WUkuIYD
	V4lTdtDd4U98uMkBa58pmA2zCbk6f2TB12dDkzesX2RPIQnFbaBr7gyg2uxlfkwHpG3z3EC27d+
	DzGnXvYg34QPFq0VARuM=
X-Google-Smtp-Source: AGHT+IF9/s8KH5iC2ZE5PVK55qaK5lCRWkSkkYH9v3t3I5I73Z+TFu2uVgdqoAtzaa+67HA8+8vK8g==
X-Received: by 2002:a05:6a20:7d8b:b0:222:ca3f:199 with SMTP id adf61e73a8af0-23df915254emr4190532637.18.1754126683708;
        Sat, 02 Aug 2025 02:24:43 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd7887522sm4799161b3a.20.2025.08.02.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 02:24:43 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuniyu@google.com
Cc: ncardwell@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	kraig@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 0/2] net: tcp: lookup the best matched listen socket
Date: Sat,  2 Aug 2025 17:24:33 +0800
Message-ID: <20250802092435.288714-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the tcp socket lookup will terminate if the socket is reuse port
in inet_lhash2_lookup(), which makes the socket is not the best match.

For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
but socket1 bind on "eth0". We create socket1 first, and then socket2.
Then, all connections will goto socket2, which is not expected, as socket1
has higher priority.

The 1st patch fix this problem, and the 2nd patch is a selftests for this
problem. Without the 1st patch, the selftests will fail with:

$ ./tcp_reuseport.py
TAP version 13
1..1
FAIL: wrong assignment
not ok 1 tcp_reuseport.test_reuseport_select
Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

With the 1st patch, it will success:
$ ./tcp_reuseport.py
TAP version 13
1..1
SUCCESS: assigned properly: (<socket.socket fd=6, family=2, type=1, proto=0, laddr=('127.0.0.1', 33787), raddr=('127.0.0.1', 43140)>, ('127.0.0.1', 43140))
SUCCESS: assigned properly: (<socket.socket fd=5, family=2, type=1, proto=0, laddr=('127.0.0.1', 33787), raddr=('127.0.0.1', 43146)>, ('127.0.0.1', 43146))
SUCCESS: assigned properly: (<socket.socket fd=6, family=2, type=1, proto=0, laddr=('127.0.0.1', 33787), raddr=('127.0.0.1', 43162)>, ('127.0.0.1', 43162))
ok 1 tcp_reuseport.test_reuseport_select
Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes since V2:
* use the approach in V1
* add the Fixes tag in the 1st patch
* introduce the selftests

Menglong Dong (2):
  net: tcp: lookup the best matched listen socket
  selftests/net: test TCP reuseport socket selection

 net/ipv4/inet_hashtables.c                   | 13 +++----
 net/ipv6/inet6_hashtables.c                  | 13 +++----
 tools/testing/selftests/net/Makefile         |  1 +
 tools/testing/selftests/net/tcp_reuseport.py | 36 ++++++++++++++++++++
 4 files changed, 51 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/net/tcp_reuseport.py

-- 
2.50.1


