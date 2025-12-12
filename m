Return-Path: <linux-kselftest+bounces-47482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5ACB7EBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37993051E98
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C230E0D5;
	Fri, 12 Dec 2025 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W0ACdi1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F301A0BD0
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516628; cv=none; b=Y1Z49pr/xHnd8d/gAUadg6NE9+JZHHVU3VVkEh54BRd3d3T4AZnzd/CLwqBGZ/IQ3uTRiawvOBeisbcawbWMzhi5v/tWAYjPJhUKAyu62AobAsY3tjfezC7qtHUlNcpeAHu/XyfbKZZw55wLR7euqpPlmgTgCiDTAn6IVNYyL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516628; c=relaxed/simple;
	bh=Kx8N1bylWHtbc8Bcfrw3QypXu8hIDc8UcqEu1LGE9cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8SCVhIgR1KEbyRex0uSAL5Ihwi3LEZCaS27n03oIRLLss88HGURPbPaRBp61T8TJyBPGG5oA1G2c6e6yX2wWxxXj+kZi0hqVq0bEbWHdnfntRVxiVZlyx3X4E6M0dZxA4ZP2BMKjV6DecK7gjlUBowAqxJE7AOJ1IJO1WmrmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W0ACdi1p; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-b769a872550so11557066b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516624; x=1766121424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ai5WkR4oEYh5O0EvOPkNqS4qWJnvXURC4QkhQFv6TA=;
        b=W0ACdi1pwQRQFoB/Jyibb7GcNiq2H9lXu03g12eBDRH8C6mtU80AEUwtSi4yzgn0xa
         KlJ31uDLXgOjO1I+wf1JkuLdSiLiYvT4kjzDJ+MgocZXF5vS+UU8p6MXpUO9O0gB2iq6
         9cWv14cJ20ujfu3eSbDffVl/qUa7XbWtWQWFltTmFbMjC53alc2DMoBFAGrRlTap6NBs
         RQegHuBNZJVyXnT++eEwSFWyRnTPAS20h+3ogHCkfcbxsemvmGaKy1hGCv5VsGdE6FS1
         EYsfXy6LCWiBE/BoYq89PlVH/+3uyhTgm9rjmehIt1NX08cbXWKj6rFgPAoybKMFuZCA
         d+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516624; x=1766121424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ai5WkR4oEYh5O0EvOPkNqS4qWJnvXURC4QkhQFv6TA=;
        b=I4joH2ovYxEj+xfSubizxIb8i4qSqVtLyY9dfLHoeJJQ9lN6I151NDJ5fz8jJnY4Gq
         Xg7ayWSwXhyK61ygwbErBINupderv25J9nGfFA2KDE6KKxy2kf/ZKybfQcIl9MOwjuYj
         pbAeJ99dSZetdb3yAiP1osnMtGP4cVZtGwzsF7jAPmW8uP7P7KOmMUixWUUHV81abElL
         AN8TbpaeQKwSvMBklWfZBC4iKreAcUqtmw9qDLmUvkPJN9zXVvrk/PAxMumMcekji4PD
         aFUdjsmofg8Hx+GYfHSpiTIo0Ld8fSHIto8aIVH//2+TkogNTZNsM/v46ubKb0u8CKDL
         a6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqZI5cuHDiaKkt9fZnTN6ewkUvELhEezi/NXN3+UzN2iy7vHLeBBFlLUMPo2tazLxkPOoUfx6Q8tncImA0cic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzIrxRyThVB5aWbsh3u0v4gDPZ3jNjf0ywd/qxOe+IAu1eF2ZN
	26aXLITlR3xWB6Ip0+RKQRU3hRtSuqH6HxxTRwFLlQ7ecFVIL8fyWcP9gXHqhVUYIv+/iVEUtVt
	dt+25stMq/lvfE1LeL8dGEd21vm/FJN9OzhqlY5rq7AxwW8JhtgBS
X-Gm-Gg: AY/fxX5o1/FEvm7g6A3KNOb1Q+Wfi6exHEnhlwuO9r3J/txy3nArrhIy2Jf1rUG5wfo
	XgxFh20IVLOFq30QOfp3rUG7eI2l5qLc7FPf0gY/ilTMd6bUiNS1tRcxzm8c4m9pjnRwbP5b7VC
	KP3kbTiyZUqe2z7Ds/KkT4rV4alY3l+IRPugA5GfDeudgnKvEgrlgW8ifqB63cO/cHY14zeK6PX
	eEopU+sHbzvGmyWyohgAiMRC1A7mKUEerwOhwh86DNnJWpdNvfT8z8EuItKPDltrSqOal31qF6E
	sgu11FPtq0p1B+vmtpeX+3yXgGzuxmT5Aui8c65wpUKAt1A9Y6f7hyBh7a9Iwb14wP3YXp/J145
	rTLhY1PDzXS1olUSGqG2Gchaol2A=
X-Google-Smtp-Source: AGHT+IGJPg4q2IDeX/L7bg7HAM9XpF8sJyvqLzheZcLWMRdmnfuidnrD1FeMw27GjSBDHq5hw179fL9B+2OP
X-Received: by 2002:a17:907:3f20:b0:b73:51f6:e070 with SMTP id a640c23a62f3a-b7d23aa416emr34917866b.7.1765516623708;
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa54ea05sm89263266b.51.2025.12.11.21.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6B56634079F;
	Thu, 11 Dec 2025 22:17:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 64581E41A2E; Thu, 11 Dec 2025 22:17:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/8] selftests: ublk: add user copy test cases
Date: Thu, 11 Dec 2025 22:16:50 -0700
Message-ID: <20251212051658.1618543-1-csander@purestorage.com>
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

v2:
- Allow --zero_copy and --auto_zc to coexist for --auto_zc_fallback
- Don't add test cases to test_stress_05.sh as it's close to the timeout
- Add Reviewed-By tags

Caleb Sander Mateos (8):
  selftests: ublk: correct last_rw map type in seq_io.bt
  selftests: ublk: remove unused ios map in seq_io.bt
  selftests: ublk: fix fio arguments in run_io_and_recover()
  selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
  selftests: ublk: don't share backing files between ublk servers
  selftests: ublk: forbid multiple data copy modes
  selftests: ublk: add support for user copy to kublk
  selftests: ublk: add user copy test cases

 tools/testing/selftests/ublk/Makefile         |  8 +++
 tools/testing/selftests/ublk/file_backed.c    |  7 +-
 tools/testing/selftests/ublk/kublk.c          | 64 +++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h          | 11 ++++
 tools/testing/selftests/ublk/stripe.c         |  2 +-
 tools/testing/selftests/ublk/test_common.sh   |  5 +-
 .../testing/selftests/ublk/test_generic_04.sh |  2 +-
 .../testing/selftests/ublk/test_generic_05.sh |  2 +-
 .../testing/selftests/ublk/test_generic_11.sh |  2 +-
 .../testing/selftests/ublk/test_generic_14.sh | 40 ++++++++++++
 tools/testing/selftests/ublk/test_loop_06.sh  | 25 ++++++++
 tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++
 tools/testing/selftests/ublk/test_null_03.sh  | 24 +++++++
 .../testing/selftests/ublk/test_stress_04.sh  | 12 ++--
 .../testing/selftests/ublk/test_stress_05.sh  | 10 +--
 .../testing/selftests/ublk/test_stress_06.sh  | 39 +++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 39 +++++++++++
 .../testing/selftests/ublk/test_stripe_05.sh  | 26 ++++++++
 .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++
 tools/testing/selftests/ublk/trace/seq_io.bt  |  3 +-
 20 files changed, 336 insertions(+), 27 deletions(-)
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


