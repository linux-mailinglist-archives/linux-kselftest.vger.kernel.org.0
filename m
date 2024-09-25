Return-Path: <linux-kselftest+bounces-18372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1839868B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 23:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD9A1F2265D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A2154452;
	Wed, 25 Sep 2024 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvS3Bv9N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF414C91;
	Wed, 25 Sep 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301320; cv=none; b=VDp3BNCBRLOB44YjMNGJ3fds+lo+7Pxn5xn0qNNkdNe9NFquJ9FgAz1h4hedEz0x6cIuP3KHUEFBzkMjQyX77HdKoyY0O7ZlUVwXr6uOZVbGCeRiwHEmnDqY9d0V4/KMse4kRUuCvnTeB6tIWZpsLaIq+67yBg6mr8pUCaGTXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301320; c=relaxed/simple;
	bh=vxG9Q6QSTtFcvhnEY8P6xoSiQfhrYXqvTk6sHzPTLvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rpVtQCppaTVMUf4s541cwVjwbUpSfS97OCfhaZ8mNx6P4ru4aWuAHdkTGBr+vsKfyK4vS7QmzE/AcSDf4mKz2RyuviwCtaAYIx1yFFHZSO5s7QoDrrapiKuKwIcIeK4jdc8iszC4w0G+GTKrrMf3F6UtgZExTql4wEyiZMUzJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvS3Bv9N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso2417555e9.0;
        Wed, 25 Sep 2024 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727301317; x=1727906117; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbUIdirgb2NKn/al311NR4bdvWEF/7y80ibmO08goVU=;
        b=JvS3Bv9NdoHyKvLWEG05mStM3lTsXZdidfBlBLpOVkjRp97ityNtULNtasl79ky8gt
         3SCbDg6xwqLHaxb9irV17BMz90lwRGmrOxc1lYNI1ZiyNofUVkVKXExpIHd6SEvGD/zq
         cTZC3yTrPuqlc3bCQOf7mWEHrL/wg/qdJEcYIPckskinnwkpY3A7XIIR65KNugXzX7j1
         vJigQnMJQoxPcJQKHWRei2GkRLzroCeUbawShWvmNDRgre1ZpScF368rErFe5vuwHN8x
         nWe0pvm3M4MubjXOzl0wA9aWDkdjZpKmxTUSB9bOAUD++VNWgeyhWMkbcDsYA3NmsBfr
         nzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727301317; x=1727906117;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbUIdirgb2NKn/al311NR4bdvWEF/7y80ibmO08goVU=;
        b=s93SpN/dhSsWiHAE+fCVyQj6J4HxYhfhUM+v6ehupAEEnf2duwe0wTk3VtdfonlWbr
         d6Qsfz30EpZdcZB5FYT+7Q6jy8fEelhrMlE1l9jGZS2kUVjzKTYZn9sGJMKNlZlBVUlg
         Sj83iyqLdukNMBrs2LXq/RfvTEZUKiu00hG6UVoZPH6wqyXfRSG1e9HS5hXmFFmmDKGE
         GaHTI/5DkMSOm3/q4+DLWOIXJpHF/j2i/U0lB23Z0ZI5/UJO/ONKG6SYYgToU9CiGwgO
         bg5YNxKRe/ltGAXoUY/lLgBhBUlocWl0coxXIEkU9LvpGCbP7uPoRRT3pkBGeA6281H3
         025w==
X-Forwarded-Encrypted: i=1; AJvYcCUsumg1h34GI+BLcvFaQSKvOK3RLuX1tSVqz43hpbKhp0xR/ON8ABhTAQK//+JmH4qXwjYi/vBGphJHIg==@vger.kernel.org, AJvYcCVF6mYcmvqixAjGGc0kgLxIQ3foRZPaFOtKXPZNj4BPTK7esC418WMkbo2npcGKj9ozyxjOtmz0/kKj7rI=@vger.kernel.org, AJvYcCW4ForYomM6+62Lk/HIzA4MRmG1WT9J2owQ8Gq/+ipJt/q6+9LVLD0g5/u2TydmmkzAXkeYprVl@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQidjAhviqy8MYo9UTxq6Vw9j+EDofLav8h7YVUPCdC/MiNpd
	g6wZSxwt16kG3o742OIh7gDyVloMOD0qdF64qXmBqORtg2XVvR2ZzJzTq3rZ
X-Google-Smtp-Source: AGHT+IEeBAHoqDG18W4bQGBegjI+2ccmYpkdAttee07RXyuyt/ZPCiSlRQfkj6RZsGdv8nvIQ6GcCQ==
X-Received: by 2002:a5d:4e10:0:b0:374:c10c:83b3 with SMTP id ffacd0b85a97d-37cc24c5b4amr2748949f8f.54.1727301316926;
        Wed, 25 Sep 2024 14:55:16 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-370b-ca26-d622-f1c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:370b:ca26:d622:f1c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a165fdsm29129385e9.34.2024.09.25.14.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:55:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/5] selftests: gitignore and clean target file
 additions
Date: Wed, 25 Sep 2024 23:55:10 +0200
Message-Id: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL6G9GYC/33NSw6CMBCA4auQrq2hL21deQ/jAspQJgFq2qbRE
 O5uYcXCOLt/kvlmIRECQiS3aiEBMkb0cwlxqogdmtkBxa404TWXteGSRhj7BDFF6jChm30ACpI
 xIeBiVduRcvkK0ON7Vx/P0gPG5MNnf5LZtv3vZUZraq5KNVZrIbS+u6nB8Wz9RDYv86Ohfhu8G
 G2ZDnrOjDJHY13XL8MTft/6AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727301314; l=1410;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=vxG9Q6QSTtFcvhnEY8P6xoSiQfhrYXqvTk6sHzPTLvQ=;
 b=CnL4QtmtajcGgAdChsd9/mZ55gyhRR03ZZFXZTxpWO87aLIAQQpQGrgmIi0LxnvK+ikpCrSqV
 e3xOuXA8IR7D1lnLlfbIFWqw4pZibDCqDhKsgkDxTcD/H2RzL4ETi8A
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Trivial patches to update the gitignore files unders selftests, and a
little addition to EXTRA_CLEAN under net/rds to account for the
automatically generated include.sh.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Split new entries in core and net gitignore files into two patches.
- Link to v2: https://lore.kernel.org/r/20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com

Changes in v2:
- [PATCH 4/4] add excepction for load_address.c (must be tracked).
- Link to v1: https://lore.kernel.org/r/20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com

---
Javier Carrasco (5):
      selftests: core: add unshare_test to gitignore
      selftests: net: add msg_oob to gitignore
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


