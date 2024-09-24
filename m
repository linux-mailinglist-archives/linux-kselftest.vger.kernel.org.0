Return-Path: <linux-kselftest+bounces-18298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD298461C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B050F1C22909
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6581A0BD6;
	Tue, 24 Sep 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZD08kL9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D111A270;
	Tue, 24 Sep 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182157; cv=none; b=VYAgiiXKl5oTrT+yJ4ARbpRANSIjSbZZWobex8MoJ51xIxMsncp+5Ruyn/zsLNLCDE3Ijj0BrbvTmZFYpt1+kU0Xl6i142mt+Mm3WNjSyoxZ8G234JBxAeADSDSBkb7eF/6E5vgrm8NbAOMacEneItS9yMxHER0MONXD1nTDXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182157; c=relaxed/simple;
	bh=9QGjApg6eWCbeS4kZh0gNjKR95Z8he6c64YgKoxqz6Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fsgb+WVN8lv2mb4OB0JmiOJuNiAypDnIntYVXB37VJnNKjbDgEXWas77il7DhWqsWKT2ffmEkGITlNY2MPEW348XJq2c7KjOWGcoG+i++v1fV81MIZj4UvpGBvE0kaR+o6+Fbis+40ID4PGE8A9aAMeuaDU7F8VyhpApU9RTm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZD08kL9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f66423686bso48431001fa.3;
        Tue, 24 Sep 2024 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727182154; x=1727786954; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkfcF9Kbwvbpcpz52USf47BwMvRETyUhgdMgF2eZ6p0=;
        b=cZD08kL9ny0LnNZexVolnaRE+q/IdWWpAnUZ8NeuLp0dtvVqpwaRR7NbXiB9XKF45M
         Px9Ez42GitMdbztHNHbnM1mZUr6zXFxFrwzK/zKz/9GGTv4YWqwZCAzN1KhP9VUCIH4o
         ovsv7jAKQgnWp+TAfiYycBkwoFtAm7nF2zF8PEifdSW+A2ko5Sw9JGRAnrk/vSq8Kgc2
         GuqZHLnYPkCE90zEaRz23MMsrbTnnnsRFpj3HnOrRRYeuRvnyUkt4K7QoL2GqDMmK7Bp
         fsVTTGEyT78tbwX/FfW9CxSCJXED9qkD9IOyoevP+8vdYcfjV5lAz1osAZMSYwXR11Ww
         klkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182154; x=1727786954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkfcF9Kbwvbpcpz52USf47BwMvRETyUhgdMgF2eZ6p0=;
        b=wikul/qDOwDSRNPi5aMiCkDlo2ydzyIatnNLs0lvoShpIOiFUhIhG6ogfLQgwiljuW
         PDMPz5HEFmDyoVpN1Pa0sHaV8AxeJmhkLqT4smw6Hcpae3T27s8Nz/C5MjJlvYGvVgqQ
         8m0EWY2QjaXRCTLjjM6ritCYovK8bJiT++aK2qZW51KidefT8x8A559WrnihPRusfIaP
         boKuKjy1FVTCGo/3VTZQ1gr5AtakzSdBW+4Rr7pm4lk07vJt3PHYkjP9x7UlMu9B0nLt
         dDHNDID0l2mO3Wjc7i1QO/DvjkhNLNYLNdkf6QaJNre2Nr0Q00KP7JRhFw/iE0J0Xgov
         Xp+A==
X-Forwarded-Encrypted: i=1; AJvYcCUBpNWwCGhHXQ/ENhQQLBlF8rn7gUQaa+T4LU8tg1lWIf9sE1MqwZ3AmNx43PmEYmHlKGiAn+Iu@vger.kernel.org, AJvYcCW0De64KdSL+SbMA8iyAa9Vk+Y0nJcu9f4nOevUwSyOri0oaItbPGVwutZsvhaeioVWJHmZcfpHTuKVt1c=@vger.kernel.org, AJvYcCWs7Yr6X8Ndg+CubkixPanX2qAPwOmIMjR8gTNALV7mbmRbEKaReyBjkjesbByURMfqDV1qsWCmGDP9nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVwNtzDVC6/CPMs6jZBhN55oOQ+222dZqFdt+XChHWryUNQh0
	1UrQO1QvC7Ri6HQov7fK8VYqenKqoj2fhN4LOoU/FRnftMpXyQF7
X-Google-Smtp-Source: AGHT+IEeaoaZNwgYWsmOF94yInjDZ6PXr09ERcAY0a8ekQMv/z/m1gYX13niyCD330MjkSiAKsNtag==
X-Received: by 2002:a2e:a9a8:0:b0:2f7:7d69:cb55 with SMTP id 38308e7fff4ca-2f7cc2bcffdmr73238161fa.0.1727182153259;
        Tue, 24 Sep 2024 05:49:13 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c500dsm704932a12.61.2024.09.24.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:49:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] selftsets: gitignore and clean target file additions
Date: Tue, 24 Sep 2024 14:49:06 +0200
Message-Id: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEK18mYC/x3MSQqAMBAF0atIrw2YQUGvIi4cvrFBoqSDCOLdD
 S7fouohQWQIdcVDERcLHyFDlwXN2xg8FC/ZZCrjqtY4JdjXBEmiPCf24YhQcFpbi2aup4VyeUa
 sfP/XfnjfD/WAMqFlAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727182152; l=991;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=9QGjApg6eWCbeS4kZh0gNjKR95Z8he6c64YgKoxqz6Q=;
 b=gpZqwmT3dLPwdDO9Z3vf/zoFskB5jdC87a0gj0m8DOCySuxELJwoiDlIQXBJId+JX7oHFh9OX
 kN+oEPrXp1BB6PJM67yRSs66f1Hw4Mp8wxHpA+CeYRZj7RSsn5JAtyy
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Trivial patches to update the gitignore files unders selftests, and a
little addition to EXTRA_CLEAN under net/rds to account for the
automatically generated include.sh.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      selftests: add unshare_test and msg_oob to gitignore
      selftests: rds: add include.sh to EXTRA_CLEAN
      selftests: rds: add gitignore file for include.sh
      selftests: exec: update gitignore for load_address

 tools/testing/selftests/core/.gitignore    | 1 +
 tools/testing/selftests/exec/.gitignore    | 2 +-
 tools/testing/selftests/net/.gitignore     | 1 +
 tools/testing/selftests/net/rds/.gitignore | 1 +
 tools/testing/selftests/net/rds/Makefile   | 2 +-
 5 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
change-id: 20240924-selftests-gitignore-e41133e6c5bd

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


