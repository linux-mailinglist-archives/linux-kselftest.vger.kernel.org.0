Return-Path: <linux-kselftest+bounces-47381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E0CB4BAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BAA5301596B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 05:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A104285CA7;
	Thu, 11 Dec 2025 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GGZ5oo2y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A11F461D
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430196; cv=none; b=a+P21NLq5MsgnVHV0fVXYigZ0wxh+Im/DdPykLz7kcxybghq9XXE+TNp26WplY6V4ZljXvNdS+NI4iRGKkWcUzVLnN7ME1bKBkIvypjnlyo+1rteePL6VFfYc9eBHCElHflYP/AQDvbWtKvX7ISrKzJlUpGiZfy4+Hs2IHdY5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430196; c=relaxed/simple;
	bh=8qOJtiA6XHp28x6wRFTwTNp0IucDuqFRVR0W+H1pxqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JK3tP3o+JrfvMXpv9Yk9N6XmxzpfZkkY8YHuBaI10+VWgyswNRxsEw6INv8CL0L/gqKkvdbjJmPRfUIy7jNyXcT03sjpwafCs+yplSawxbgZbpKUqw6VpXDBaQXG+Vlr2P1lixy11iZTVMQyYxhvQn6BAAbrgXr43Uk7mJK15xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GGZ5oo2y; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c78003b948so117296a34.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430192; x=1766034992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYcoseH5JgdGnDsS6/FYsWYdHdJE/J4Cwcg2CuVmw64=;
        b=GGZ5oo2y2n0X4StzmG+JXrYa5HyHypf86LAMSZhdwqSm3sStt5mt7HiOUBiwPDxuUI
         Yw3iPMX/aNk2WG/YvPC/iYKzRS2tEY/piinOUMfXWcWBjvXq8PeMZ6s/qPVbE3t685hf
         88048ZGlqJD+zmbefe5nKUhHJKPBmJaDA7qKLPM3U3l1F7zVQXV+QPwjZkEzR05GBKWY
         4YogbxPGaPYFZE+lXhLwwRNXcGxnmHk7r0fc/tZm3LzuF4b9ZwtmTphysrBrwbi57N8u
         Imx2uEZXac1P/ooh+kXIzpFGppJTRigbNJRlZBya7pmP5czbpln5BZ+FWO6NxpLbOA3n
         lpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430192; x=1766034992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYcoseH5JgdGnDsS6/FYsWYdHdJE/J4Cwcg2CuVmw64=;
        b=n1Bz9yXON1McT+HOkX/SrVpuMBxSM2qMEXwQ47ahN5ucFe1J9NsSKEp8hTEfua6mBj
         ngFzMQZ49Rg9DmMMmnCh9qoev+6KXNldsKk3/Aue9E5v0PVhLU9xqlhb8tLE/GFoFmYW
         Tb9xKCAHdhT7ZimUf2LdIaK2ZFiAjTlBrrjmerzCQzFA1aK9By4Jly45TYP8yoO+QZeD
         oCSnY65ZkvBX8L8BREcwUy1h/jELxRZ05yujUXxBoyAs9OcRMBAZe90FlDZpV5/uTYmc
         FSP6rHaZ4WeSXOzfGCtufPvkfR6ujWlt6pjj2muSAw9ntserpMf6gt+UMJmLQdwHBt/6
         e7dA==
X-Forwarded-Encrypted: i=1; AJvYcCWtIUi3IiUfjejAr/KFmIqW3iBMfUSyMUtxVG+hiJKyVkgz0JfUJ79aZUnGWsLRBd/zlKytXmPZjrN4t+TSD2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60StsgL4kQljkO0NHF3zy+a2T64qWwT7L30mpO57oNQNn5qv3
	15EEEj5Tj1LpK99z++jUCjvy1l6REsKEZoHGPMPaHmczgXk9V7NlHEo5PNNIWheGmyTYtU00tsI
	2O63BXMZhyGgQ1Xczj7cZOQY2rxpOYdsnbQCutuUWiyQoVuafQ2vf
X-Gm-Gg: AY/fxX4oeaVwjfUKtT9ouwl820vHGN3dUIcxCs8Dm2tTyg+5/s4aSvwIv2OCkUxcTl/
	jD44sqykrf7BQuGuNN4JJP5Vlb9BF6xJsVNYRkRvIH9c+XZZombCiPdHCGD7jbskJvAB6NlGmFb
	n/Vc5spRc65V3pb1aZwq15Awk+LaWx8fCH7XCGLFa+KEdHwzWxnTCX7n//6HgeRATH+2rRliWDO
	JZ0PWD1pqhEQf6I7xneFBzuIlTrXt8fo8vK5Nd9fSog3tCiJzX4Uph6aGVzg+DTxDFsgYkhOH93
	dVWxEkKBQqkUrNgAqmHrzu38todCU9t5KJCGhtq4eFUYFO1zqYLNqHWiqJIzOvmkVoED6jGQLlG
	ApQ8fQYEyVzB2MKqJM+ziU43FfXg=
X-Google-Smtp-Source: AGHT+IF7kuKU1dPaXTTDGo7PixAh9OWTqtoT167eLT1jITjiGyOtsNEP/s4KYfWR/Z1qH4/D6IPi+pev8POD
X-Received: by 2002:a05:6871:6608:b0:3f5:94d:f6ab with SMTP id 586e51a60fabf-3f5bda5c39cmr2448079fac.4.1765430192480;
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f5d4e1e554sm246177fac.3.2025.12.10.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 61DBB3401CC;
	Wed, 10 Dec 2025 22:16:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4AE75E400B8; Wed, 10 Dec 2025 22:16:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/8] selftests: ublk: add user copy test cases
Date: Wed, 10 Dec 2025 22:15:55 -0700
Message-ID: <20251211051603.1154841-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some existing issues in the ublk selftest suite and add coverage
for user copy, which is currently untested.

Caleb Sander Mateos (8):
  selftests: ublk: correct last_rw map type in seq_io.bt
  selftests: ublk: remove unused ios map in seq_io.bt
  selftests: ublk: fix fio arguments in run_io_and_recover()
  selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
  selftests: ublk: don't share backing files between ublk servers
  selftests: ublk: forbid multiple data copy modes
  selftests: ublk: add support for user copy to kublk
  selftests: ublk: add user copy test cases

 tools/testing/selftests/ublk/Makefile         |  8 ++
 tools/testing/selftests/ublk/file_backed.c    |  7 +-
 tools/testing/selftests/ublk/kublk.c          | 74 +++++++++++++++----
 tools/testing/selftests/ublk/kublk.h          | 11 +++
 tools/testing/selftests/ublk/stripe.c         |  2 +-
 tools/testing/selftests/ublk/test_common.sh   |  5 +-
 .../testing/selftests/ublk/test_generic_04.sh |  2 +-
 .../testing/selftests/ublk/test_generic_05.sh |  2 +-
 .../testing/selftests/ublk/test_generic_09.sh |  2 +-
 .../testing/selftests/ublk/test_generic_11.sh |  2 +-
 .../testing/selftests/ublk/test_generic_14.sh | 40 ++++++++++
 tools/testing/selftests/ublk/test_loop_06.sh  | 25 +++++++
 tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++
 tools/testing/selftests/ublk/test_null_03.sh  | 24 ++++++
 .../testing/selftests/ublk/test_stress_03.sh  |  4 +-
 .../testing/selftests/ublk/test_stress_04.sh  | 14 ++--
 .../testing/selftests/ublk/test_stress_05.sh  | 17 +++--
 .../testing/selftests/ublk/test_stress_06.sh  | 39 ++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 39 ++++++++++
 .../testing/selftests/ublk/test_stripe_05.sh  | 26 +++++++
 .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++
 tools/testing/selftests/ublk/trace/seq_io.bt  |  3 +-
 22 files changed, 350 insertions(+), 38 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_06.sh

-- 
2.45.2


