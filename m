Return-Path: <linux-kselftest+bounces-31115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEBA92F56
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 03:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DF97B134C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC51DED47;
	Fri, 18 Apr 2025 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KBwZwn04"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0551C5D7D
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940265; cv=none; b=urCxYJhlfr/Go67qPFNubZznH3B74e8iyGgHf76WhGT/4tkt9JOGNo9/lGLxuHwr6nXe4YZQn8r7xMyjbiHxjAgWCHpEhWQqjCEN4ZNKi6K2WDG7Fqzcu9THxEqRY9B90VMiH3qnWVXPERzuqVtQ9PpkOw6/QFEGVuSCppezuVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940265; c=relaxed/simple;
	bh=83ine0mrSdz+4LSvDN5s7gcTAppP0Ss3rM2gY/WezSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJ8ed4XQPg6ONv9OU9/ND4KugoqaB8JlmSBxO2SG79x9LeHa2yNwmcENP3/zuEYV6phDO4sETHJq1ZO8xF0H/Da8s5RXXN8LDy6ArCnKRdzk3xcTcvWSUElnYRER6utuROa5zOzrdfaIR/kpy5i3nDAMkQUKmwkmqxcukcEaGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KBwZwn04; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so1405686a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744940262; x=1745545062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7I8NgF9RlR8FwCsr9V1VCpYsrKioxWgjmoDan09dvi8=;
        b=KBwZwn04q/Az4CTzRDbtKoSU00TO9Z/xrWcUsw7FM+2ozNDJiRe3Ps777sLenVxfv0
         Hs+fzwD/qoGgS/vO0s0GfFXJqE/JEl3pNsiPxu0NViu5v6gqgmhkb+VfggCFol6FVNDP
         np2CMOiGNp+thzOhK4wZrb/c+aflqjbvFCrWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940262; x=1745545062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7I8NgF9RlR8FwCsr9V1VCpYsrKioxWgjmoDan09dvi8=;
        b=cIcgJ3FVX69XD8eYzfsynFKa4p97W8clVgtbZovUmNHEiPpRWM+PSpo4l7rgQX8jHH
         5bwHsAn3SIThSt7rwuhSWgZ/1Wrb4j84/Dc/9M97LVWG7WvUcXz8ye9ZqqCMPB/jYDOC
         rYKpoXSYboyJ0tYNEUolET7mhp3zDUN4I9rH1PBYnyC5jiuEnMIReDWzIoUXhV9X7ifh
         yBjVNwLL06Dlyv5dbAwW7briBWimeayD2vzEZJ9AhOA0P2OPq3qTQJPlfBlfZigg6n1T
         TmBrWrauWa631BifeGLS0jVpmyXB/60qbLGXy/BNgtaXL/fIDNv4wf4Blw0zC3CGkej3
         btKA==
X-Forwarded-Encrypted: i=1; AJvYcCXtI9j/Pl7CQF5XQ7+H1oaHKpx/jxHfMIm6liB7K9H01vEyji04QQh6UNhVBSI6WEIdVphQceY8YNwQSGoAye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGslU2LyeRg1kN5dXrA98lsXdXu4SB2WtEL+rZ6GWgxVONlUXA
	emxSFnTR2q3sNxuKj3B7DG9eQJVL492BPc7jlHS+aBTN4tth+YW/QVjqBevCMDg=
X-Gm-Gg: ASbGnctlK1Con+LgekslbX+RRdL12l+SwCBZVryG2QQ0K6dNNYQYIzJFSaw9NDUw71V
	Au1FNjos3QDPsMz7fBkBxrdRilpuVR5Dz5IYiBa1z0q+ZopQQ1YgbSnRO0vwlymJLyrlTZYaNK6
	5WTQ2+RmWDWuzgsbXOFCQ9v5WJOlfcJz8rvMUJEHWqu/svu8KWj64PLjhbFch6LlM6N3q9rHyCJ
	U7RGpw7CDMsOngXR7GuL/eJSqOHBfECPgHZd+OC1dKvyY+RO4a5wmypqgXBrMp9pIs/iQhHPbIq
	IcrXaC81KkPwaNYmepvNCYQOSV1lOpNYCjeDd38mhRjQdyNF
X-Google-Smtp-Source: AGHT+IE6KmDOqTadvPBOoP6NCbep8sj/+WD00V+zMFXa6ok1PnWjm2kVgaHVjOv1izpghACtKB8Bjw==
X-Received: by 2002:a17:90b:568b:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-3087bbc4d52mr1273243a91.27.1744940261993;
        Thu, 17 Apr 2025 18:37:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df21278sm131772a91.29.2025.04.17.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:37:41 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	shaw.leon@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next v3 0/3] Fix netdevim to correctly mark NAPI IDs
Date: Fri, 18 Apr 2025 01:37:02 +0000
Message-ID: <20250418013719.12094-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2 & 3 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 4)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v3:
  - Dropped patch 3 from v2 as it is no longer necessary.
  - Patch 3 from this series (which was patch 4 in the v2)
    - Sorted .gitignore alphabetically
    - added cfg.remote_deploy so the test supports real remote machines
    - Dropped the NetNSEnter as it is unnecessary
    - Fixed a string interpolation issue that Paolo hit with his Python
      version

v2: https://lore.kernel.org/netdev/20250417013301.39228-1-jdamato@fastly.com/
  - No longer an RFC
  - Minor whitespace change in patch 1 (no functional change).
  - Patches 2-4 new in v2

rfcv1: https://lore.kernel.org/netdev/20250329000030.39543-1-jdamato@fastly.com/

Joe Damato (3):
  netdevsim: Mark NAPI ID on skb in nsim_rcv
  selftests: drv-net: Factor out ksft C helpers
  selftests: drv-net: Test that NAPI ID is non-zero

 drivers/net/netdevsim/netdev.c                |  2 +
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 7 files changed, 173 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: 22ab6b9467c1822291a1175a0eb825b7ec057ef9
-- 
2.43.0


