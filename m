Return-Path: <linux-kselftest+bounces-47485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D6CB7EA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D2713008493
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280C30E0C2;
	Fri, 12 Dec 2025 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QDNh8Nsi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3182D7DE6
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516630; cv=none; b=DH6lF83SwH3M/7DcAynxvXGz+3CIvuZPMbci5DvTlY5dkyzfkessOI12eklhTr3l4+BlAyhjFY8SeTTNM3jkuHaxXxoINHcQ1Pva7AX0IKWn6kSVNnubuqayoC0k/+nJs+qkFiKVhFjSM76p4V+lwxdeE/ICczvgg1nMXBUx0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516630; c=relaxed/simple;
	bh=vSXwqIJgqlSVc1smP8I+ivy5i3pkVVt8KiqpRNZZ4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8l7YZ6BGBqCURnakVPx+eEWc/rDlkcL/dilqTV/MtoP7wTI3W3JjnfMgZB8eLPDOQtu5fBMQ/BsWn9j3TSayI+klmW5w5n6gk8oJcukbapKtKrpLNXcMN780Li0tOqN6d9e68WqxM63rDLUDpyAoql8qih02U5tjv6sNptHbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QDNh8Nsi; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b7639da2362so14372566b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516625; x=1766121425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+3L8femEvpIo66E++G/m45qvGvJwQnFca+SKH5jlbs=;
        b=QDNh8NsiV09emj53y/qMmPh2CYmVLzOcri1nWHaAvwbBdR3hr0xrwRMtKLHuK8Ia9H
         0PVtHc+dDCbBY1Uah91yC8ASEMLTnXOd4GlzBjM5BpbvLkjfhA30p2TcDlBEY3/fcvg/
         65zD8751W8zMQmWD0qLVBldxcOex7fKBufAN8VaifcpQgw4dbDyWQINJUmLOPpW/ACWT
         JEkk6Bkk3uHR8VPb+Y67kJK9vEPntAWnpLn20fagBUGjzzeWv3NE3uCQ/wOzpEKSGfi8
         /ZYCVZkJSA9b8g+wvcvoLO9Cj1L7EatEESLIrXfNH0bLUTHT6hpGoNI0Wy4yvK+eAsq1
         QeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516625; x=1766121425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+3L8femEvpIo66E++G/m45qvGvJwQnFca+SKH5jlbs=;
        b=fOXcJxxx1zRkkZEO4QxDgzU24kL7YUSgeI/jszoZ51Z+x0y+xKnduAxdnEmoj56ywx
         JXhSpRLQeOFUvPHE2XxDs6YFdpBoDcAqXKY+x3br6887lQwfDAv4XlcqILVZLAd/Fcdb
         AmuNiEe3s50uT4cIgX5tgrmR6RW7xbihV3rGAJWqgmkwDZQeGtiHoPRyBJLbhTJwQGEh
         27m798wnkHe0ulCqY5VDN3NplklJYdMJH1EwTkQPpbo7dHS4ph4zktP0fBMygY0hyDtX
         0X7DTVO3fHr6HzCjrenwUiJNyiadJotSBFSoWA2Ng3g34jvtEUYygw9f9xhdRqmDyTfC
         gAyw==
X-Forwarded-Encrypted: i=1; AJvYcCXYoNP2nqUOTg26VodSTIZiaG6Nma2pqWXAd7IPbXJvsNLdQ/HAX3IRbh8ndkxVxNUN830Uvg6mouKIX8xzaRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiXwMRA95GSAENSrDHmNZ+Re8wQI3cuHWkBojp/mj3B25GbbAh
	oowz3K81YvWe9r1J8LzBNW00jQXGmbicJAs4uwNZMkozx1CIB5S4WQ2R2mZEjz+QS2I7GLsiOZv
	SGqytzqgXMbFCWOSEzRTaZn4V5vtdTVn5g/O9GADSJ9EJCRJMzL8f
X-Gm-Gg: AY/fxX67o7bN8M6vaqQSNiDWlRR7qSWc2TafAEoVOAwAvJWjzFaywNH7nZLCqHo4IOZ
	b0xADaKOzPGhTJMUI7bV6BkwnpPckQjYqc9UDOB19oIlK76OM/iNw9tFJPj0SMBT7tsxodbfVYl
	J0OPP8BI37+vBm+xjjtHutEGE36kiVr6pC6bUV7s+3Y5+ixEUPsLyT+VurmokmEBhwvwzcMVZBd
	4UQw7KCfwy4oUhbF0YzLH/Dm7POdyzNjoQucrWsRSKeJV93BOcOBZ+7q8DVQZy1h/5KMAdlpgco
	1lYA2T8HN9zaKTjb1C+kd7NvJ/R9WvlDqzNo/boqph11LeaFg5wAMbzNLB4NW1DQWcjHPpzjxJY
	Uhfz6ePbW5dvZPEzfc5+yqkEUv+w=
X-Google-Smtp-Source: AGHT+IHgEuWVwR0RX1wTZ7OF90db/MRXj16eInoWlRqFjPQZaS+k3kMpczRUtT6+Vfaf+LABKLHjxjBNmsTj
X-Received: by 2002:a17:907:6d26:b0:b73:59b0:34c6 with SMTP id a640c23a62f3a-b7d23762815mr32323566b.4.1765516625184;
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa609a26sm86779266b.86.2025.12.11.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7AD3B3420F0;
	Thu, 11 Dec 2025 22:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 74D2EE41A2E; Thu, 11 Dec 2025 22:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 5/8] selftests: ublk: don't share backing files between ublk servers
Date: Thu, 11 Dec 2025 22:16:55 -0700
Message-ID: <20251212051658.1618543-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stress_04 is missing a wait between blocks of tests, meaning multiple
ublk servers will be running in parallel using the same backing files.
Add a wait after each section to ensure each backing file is in use by a
single ublk server at a time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 965befcee830..c7220723b537 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -29,23 +29,25 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_kill_daemon 8G -t null -q 4 -z --no_ublk_fixed_fd &
 ublk_io_and_kill_daemon 256M -t loop -q 4 -z --no_ublk_fixed_fd "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
+	wait
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
+	wait
 fi
-wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2


