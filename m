Return-Path: <linux-kselftest+bounces-18307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CE9848E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36456B2151A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4731ABEA7;
	Tue, 24 Sep 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDuB1kmf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CC1AB6E0
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193413; cv=none; b=hLQLnA5p6ccTeQjBKvkgq0aOs1Ctx6O2z6yoYaTZSToKKdXCulICt55t70OlHqTonyBKencT6bRRdqSndGoCpWRZ/V/3+cRBYLWeLLMxHpnIXSs4UBrd60IKUSICcPE5Bjod/F8dmsW5D03NuNEDazNr75jwylRTCADU8A5x3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193413; c=relaxed/simple;
	bh=BD4oxz4ohEQbKoYtZm3iSs+1uo7yPgLOw8YJFNMr7BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZvRChxG5tupl2lN7lipv+dBh3nq5ZpMBCL+8pGQE9eZ6Ui8FXZbWm/rlajwBOUvYHQdkwWE0VZtxc+M9aJfsBK9vs09O3ycQEm/L7h95CLqa5YsjucOe/U7CEmNqfi0n5SUiW34oz1j46aApdsjqFQPqRUa2YkcCKMhdb4Y8rbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDuB1kmf; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82cd869453eso214578439f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727193411; x=1727798211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Orwzf4vl19r2PEeizo+it5ykxsLyDLfwmpPyw2xeBY=;
        b=KDuB1kmfXhMIgHBTFspXOcvA33kYCqYOqou6b3xFdjQXe/sQG5vw7/FAJLaPueCxY1
         RWANl/CTcy+pL/TCREwbuVrtlfPgX79ApeqoJwjXveWokyKhaJBFP7fRzISzQ9HUww6m
         /OgCaWeAxIzJX1Wilbw2l7XShrv1Jc+eaDaz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193411; x=1727798211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Orwzf4vl19r2PEeizo+it5ykxsLyDLfwmpPyw2xeBY=;
        b=afiFNNkzYK+hoIxCaxXMRZAj1owTwJnCzDEypUUe8a1R2o4llCnKeoFc2MQGLcMpDm
         fetU8A3nUZy73Tzeifp/RSa2MA4ZVfJtShkg/N3UOWHI679t94/OL+UW5/zMrXwC5UEQ
         oYfjpXfPBQowYDadOXT9QZNmt0uk3pqbP+Ncjt3y+TOfydXgFV3jXF5afVc+60+yomVp
         sRPr7cdbJd9y4otLHz4TdG/n6stTXaAT+iY4rppCMfm7oJ7i++FYkHS/botnuKPAl9aP
         79xd8FsxdXYX5zF/0c+gdtrVujzqO5BEKh1PPILn8pBD0l6gSQRMUastwjBv6Zc8wPk3
         s6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWEkplx0bCweN2YIbg1kDuEBCDCiALS5XWX86w0hNcX9kIYwQySwbPCV1S7VJtH3Q7cuI9om/wYwewexFLpCcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfybllrhmWUJoFcLjwKa00uq7Uy9bHbK0A7BbVrGg5qKk+U5Il
	N3v26dqROVjIChqqxcBEKcjMqQTBvqNh97t6RdGmurawjmnSLZZoPu8NI9FMsTI=
X-Google-Smtp-Source: AGHT+IGIytvphTbM94QqywnWbqNlUvZ6WkqpO2TD3CN/RxYwe8ykUm0fd5AGdgNl7fNEc7pdKgVBwg==
X-Received: by 2002:a05:6e02:198b:b0:39e:78d9:ebf4 with SMTP id e9e14a558f8ab-3a0c8d2af50mr150412255ab.22.1727193410814;
        Tue, 24 Sep 2024 08:56:50 -0700 (PDT)
Received: from localhost.localdomain ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713b64sm4492035ab.58.2024.09.24.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:56:50 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] timers test fix and duplicate defines cleanup 
Date: Tue, 24 Sep 2024 09:56:45 -0600
Message-Id: <cover.1727191485.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch in this two patch fixes warn_unused_result compile
time warning in posix_timers test.

The second patch removes local NSEC_PER_SEC and USEC_PER_SEC defines.
NSEC_PER_SEC and USEC_PER_SEC are defines in several timers tests.
These defines are inconsistent with variations of ULL, LL, etc. without
any explanation why it is necessary.

These defines can be picked up from include/vdso/time64.h header
file. In the interest of making it easier to maintain, remove the
local defines. Include include/vdso/time64.h instead. This change
will also make the defines consistent.

Shuah Khan (2):
  selftests:timers: posix_timers: Fix warn_unused_result in
    __fatal_error()
  selftests: timers: Remove local NSEC_PER_SEC and USEC_PER_SEC defines

 tools/testing/selftests/timers/Makefile       |  2 +-
 tools/testing/selftests/timers/adjtick.c      |  4 +--
 .../selftests/timers/alarmtimer-suspend.c     |  2 +-
 .../selftests/timers/inconsistency-check.c    |  2 +-
 tools/testing/selftests/timers/leap-a-day.c   |  2 +-
 tools/testing/selftests/timers/mqueue-lat.c   |  2 +-
 tools/testing/selftests/timers/nanosleep.c    |  3 +--
 tools/testing/selftests/timers/posix_timers.c | 27 ++++++++++---------
 tools/testing/selftests/timers/raw_skew.c     |  2 +-
 tools/testing/selftests/timers/set-2038.c     |  3 +--
 .../testing/selftests/timers/set-timer-lat.c  |  3 +--
 .../testing/selftests/timers/valid-adjtimex.c |  4 +--
 12 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.40.1


