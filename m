Return-Path: <linux-kselftest+bounces-18350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F1986009
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CAD1F26311
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DAD192D96;
	Wed, 25 Sep 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jec5IJN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EF18452A;
	Wed, 25 Sep 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267045; cv=none; b=agT0uQMbLyhGApxbZc/0OZTOxns9yoqRCKhtdArVaY3UH7I+I21+SVwCTBQB+QlL6Cc4sNjqxQbkJF8+9OhJ9HMzzHxG8acES7CSZZ0Ommkq34oE+cUI+betdxinWoW47/ykIFArMC3MV4ktVQvcsZ4I4qKhMYvs1KmAm74sJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267045; c=relaxed/simple;
	bh=/0BRZHUYHg7b8BpYfsT0qrXwbXQQ0jG649TK756HeFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D3Fgjh7G2uPDL/0HkdToDWHbgsrgsc7KloxexXHv0j/wZzyErVWhIOI8huJC2PZLx4Zpf9+7hIngQYaQLIeyyPXvUkM+cMScYmmT90VT/wIyRGc3of41n+gnxr8dcddiS6EFk4DDJVsPdDyKZ4KI6n/bqfjswshzCT3HdUlq0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jec5IJN8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-536748c7e9aso1299608e87.0;
        Wed, 25 Sep 2024 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727267041; x=1727871841; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3D9H7m1ayAExeAteiY4BmZMeyV1ukgj31CzY4MoI5+Y=;
        b=Jec5IJN8G4EW7D18pZ35Lh5T5a+fQWBf4qUXlNmTeNMyCzIfOaaQHVs0bniufJQpbK
         5BbnZ+qPOPnvlPbzy0sHq3oXzHQ/6igYx1ZXH91jYkwEHQ0uvTFO4ImD57rMwB61ythL
         gdemvaeNERA5ceXUay05Opz3r4Nu5xylS63p6/s0eJtOD7I7W7dOCoP7Z+GelIhAKJe8
         s/NOnPQ/s4vUSpMc/QdiQzx4dozU5o/1a5bajIvs03LBSwC42mn1CMNxq6GvicL4cRhF
         Yyup2Qy6viq04/QfcF4fvOYFXQlCVMBoK75/33phvm0zVbaFMfqvtCNb0kwuHOGx0Jzy
         36Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267041; x=1727871841;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3D9H7m1ayAExeAteiY4BmZMeyV1ukgj31CzY4MoI5+Y=;
        b=UUHJXHJzgdhWiFsIsBmQeeZy99SJTfT3k5FUOWYqWwqiw79OPAscZLMXX1UhFr+mNc
         WiQPqW4I3SzFhT9NHqJjRj0yEfWgPeMgvzvDhQgXeLEwVQRA4uM2H0+fLn0VEqbSYyuU
         j9AqMZ6knBp4p2eY8WK+pwxXA6MT7gfc9jlgwp1eWcOLGWl3w850FaAapvAo/raMeurM
         E4Cr3fYFw3q7mOKW49GL5aakN+GEEBNJ0VBPCgPsvbvzIxFMeR86XiRMAZV1IXLuf0PX
         UtOaiE9ifP0QBol5qwu387/5JULT1JpnomQh51+7TGnly/XlaW3tvmMZKmejcwL0s/zC
         1YNA==
X-Forwarded-Encrypted: i=1; AJvYcCUdmHyvEou5OZYWYd95caAFL8UIA6Aw76I2OkAGAyaU54UqlpNM9xcPl8dKkwcdCmemL6cvIM+m/W6WsJs=@vger.kernel.org, AJvYcCVROfuLpSFFr9LTKl+5hbKHW+a7GxHPd8u9ffA1IJngfXJesVvg+guKZta0TEw+pJ/fU+NGNitQ@vger.kernel.org, AJvYcCVqWFwufBviq1CMgHaBSZjztE+caGn5TX6a4XqEeFT5HJfDZOjhaT0QjizTp111f5EPCQVRKcRA0a8jiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5HOTKfC+unETNEJYZgPU3Ux/l8bohajCV5fGbQ9ALGlgkfTn
	DcBKmcmOPSBdJTF0QW92TZ2rWcn1gqHOa3jocibYQlY/MYorEdkhi28oiNZc
X-Google-Smtp-Source: AGHT+IHFfLQnU+I3m0J+fjUdYH3rJ/SG1O3DECX99SL7D3Bh0hOkeXe84K8q9nD+8SM2zX2uss31zg==
X-Received: by 2002:a05:6512:b01:b0:530:ae22:a6f0 with SMTP id 2adb3069b0e04-53873455f14mr1633306e87.5.1727267040906;
        Wed, 25 Sep 2024 05:24:00 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8529sm204745566b.185.2024.09.25.05.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:24:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] selftsets: gitignore and clean target file
 additions
Date: Wed, 25 Sep 2024 14:23:43 +0200
Message-Id: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8A9GYC/32NQQ6CMBBFr0JmbQ1tQYsr72FY1DKUSYCaTkM0p
 He3cgCX7yX//R0YIyHDrdoh4kZMYS2gThW4ya4eBQ2FQdWqqTvVCMZ5TMiJhadEfg0RBTZSao0
 X1z4HKMtXxJHeR/XRF56IU4if42STP/u/t0lRi+7attYZo7Uxd79Yms8uLNDnnL/fZQFAtgAAA
 A==
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727267039; l=1181;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=/0BRZHUYHg7b8BpYfsT0qrXwbXQQ0jG649TK756HeFE=;
 b=nnlM9AKYM+9p4f8mDEbSXp8CsfNyW08Xlqfp9YMAcdhL6diwkcbWgGsKug91Y6fb4Dx8ffyY5
 p+OaBLVnccBAulRnnP3E7pqKJdx2n1tTl0OxSTbg72iKSsRc0x9zYrb
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Trivial patches to update the gitignore files unders selftests, and a
little addition to EXTRA_CLEAN under net/rds to account for the
automatically generated include.sh.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- [PATCH 4/4] add excepction for load_address.c (must be tracked).
- Link to v1: https://lore.kernel.org/r/20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com

---
Javier Carrasco (4):
      selftests: add unshare_test and msg_oob to gitignore
      selftests: rds: add include.sh to EXTRA_CLEAN
      selftests: rds: add gitignore file for include.sh
      selftests: exec: update gitignore for load_address

 tools/testing/selftests/core/.gitignore    | 1 +
 tools/testing/selftests/exec/.gitignore    | 3 ++-
 tools/testing/selftests/net/.gitignore     | 1 +
 tools/testing/selftests/net/rds/.gitignore | 1 +
 tools/testing/selftests/net/rds/Makefile   | 2 +-
 5 files changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
change-id: 20240924-selftests-gitignore-e41133e6c5bd

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


