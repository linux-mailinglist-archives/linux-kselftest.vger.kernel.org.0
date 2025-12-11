Return-Path: <linux-kselftest+bounces-47386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B4CB4BE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 648DF301AD03
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 05:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47063283FF1;
	Thu, 11 Dec 2025 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PyfksFWC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14B286D7B
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430199; cv=none; b=i6NMHUgtQwvg60a+mLk7/Q8LSymn+wKkApnNftOwYGIwkTwPCfl9jvzXaM1NB2NnB8n/jJq0LbuJSReX33Y2Yz+nYwRqu4EDJ5+K7UBcNSOJvxHxV0mfmSC5LxONlDjpkZUed9MrP3o7DUK+DUutHnT9Z2C5DiYQMvErsUkM368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430199; c=relaxed/simple;
	bh=FKbZngLfGMe4F0ejdKJ0fZ6ILmuYiVZnIW21hOqoFMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzE7ojE6RQAebQnkPPiy8w/jVmTWNeKjipOlW17puL2xvKL9w7Qr5oAVLsdroEWFL8hlK3FsTvNi8tH/4bxWBOZpefhLB9IpKRLS55aovOXBF9uQwdM6HKKLOZ/AqZpou2OlQM8z73599m/pLNohn8K8lh1UnK79+McXODaLtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PyfksFWC; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-5dfb6430553so27901137.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430194; x=1766034994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=PyfksFWCqbwVw34UP8Pi5hz2STwDa9VrLb75AWeKbRJ5NeoB4ZyZrX/pe0dqDpILOC
         4BKAhD6Rln8ruAy8MhYXg4DyF/EFwjYkUJcO8QQjoJGHFu9YMHpbPBgCVsFY1ioHWidw
         ChKxdT5SL8eickZjAVEzcAVQ6HVJGMEYhIADESbCRNe+aw3yfILlevnP2k0b8QhTIxiw
         KkgAD0409hZ/gg/06wHLGJVAJNWF73I3XHleaGsi5RsMOyXlc3ZDov1bh8hM2l/IoiEc
         daxgkbWG8Mv59ons6/xS9gYLcL6W67CjmFOXrKY+iOcmdUzQ9GymQE8G3DvD5AlpTPMp
         kqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430194; x=1766034994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=IwKvs1X7CfV9QvSB8eKHw/kU6spDIkJQ628nPlwWLUdg6/1fThuXTPnQ0vj6lNzMNc
         wHA00Nh9iynVdN/UbnWqxpmD2ErV9zerfgdqUzn54J1VCKLaQAuxs0U7HOK7Q79Syq83
         eOmuKhx3W6+TPk1CJapYOgASiLHGVA1eNdT2FugzjLEd2S/yKJxWx0TARHez19fOt79h
         I9uSJMUEqMg1PjAGoQE7UpXgfXKS4RpgLA9R00v4I/LG2DNyIx5ZAtbcJyK1FiSBcXwS
         XH3QxTCl3X/009sZ0FSU8WciUYOGTsy8Esq0uIjP8eB8/VMjN8CnHT5OnhcN2ttYjegb
         PV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXidjLIckkJQfxBz2Cs9b0ihm63XVR5mkxLpNxMTCZecxA4QHsQgp8Hyee++VyI4/n1MHu+n0NIioYBVz2BsIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7NTTa2nncgBnvC/qBTvqp+/TzrY+8qEJNQ/zhY9Yc0KHdi43
	KAX/7s7F+nAwg3Ed58OnPTuo0PAJPWlSsQ4SXNf7MnHbNcu0HdW3qbyX2Umu2hghwtxTJiAMsRx
	5/fiye5JO3Y8+/4ibhQ9q2JIR+t32Bo3POf0J
X-Gm-Gg: AY/fxX6m8PT9AOcg9rIwrI3RJeqV37AouclbH4MsZhTPXl+z93noddIYLkW/LpF2gve
	epqNOx09GD4c8QVWIEDR3QFtZnGFz+ErNvP59k2n77gVqK4BB0mLfYjcZfcqxKWnw40y073Qh2s
	6hFdaDtlt/PX98bTskJKlyqmuN9O9jdaus+4kKU9SzwPV3YaTJRuJ6nQcG13KwiYNvvXFR4cdDG
	IZLJ+GHCqXLZ5GRP8aEDaK75PltHSopkf3bNT7kIQppvfRSyX0U8HxgIMSjWzQbFLaE3L+7ks41
	Dz0fH1FOR+rvdIq6rTR0CZksT6kh1pJUVFVBihR52ujCrSc8uL2w5tsrzffzBYdsgJYcptwz5Hg
	YE1FxckQes11CJNvN5Z4mYiDTiMaozUCjjXd+/a5ZuA==
X-Google-Smtp-Source: AGHT+IH8wHkl6849aTSVx4QBElkuCxFtShXY/UySGgPZAopPw0H4GLbBbyJqdZsPQRlK5nTLNG77Q2JCbfO0
X-Received: by 2002:a05:6102:644a:b0:5db:25d3:28b4 with SMTP id ada2fe7eead31-5e7d0e28186mr197796137.5.1765430193704;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5e7db2613afsm151339137.4.2025.12.10.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 42E6F341DDC;
	Wed, 10 Dec 2025 22:16:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3E0A7E41888; Wed, 10 Dec 2025 22:16:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
Date: Wed, 10 Dec 2025 22:15:59 -0700
Message-ID: <20251211051603.1154841-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stress_04 is described as "run IO and kill ublk server(zero copy)" but
the --per_io_tasks tests cases don't use zero copy. Plus, one of the
test cases is duplicated. Add --auto_zc to these test cases and
--auto_zc_fallback to one of the duplicated ones. This matches the test
cases in stress_03.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 3f901db4d09d..965befcee830 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
-	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
-	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 fi
 wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2


