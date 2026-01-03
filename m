Return-Path: <linux-kselftest+bounces-48088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DABFCCEF923
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73583015023
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821B25B1D2;
	Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CvA2fnC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353962222C5
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401138; cv=none; b=tvCil56jqNV3nOkX05eV+njmFvSS2IwGdFmDXk8leGICg61g2egeCgeSAw+VlDWCbj/j4oIIJHMvEr051quYbisevovJj3A5LQuXvXcY1cqS1Y9VXpxE6wdCdXdY+ze9x6lt7Fb478sr8QC9S5vACS+OS+lziHO16yA4BcTDkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401138; c=relaxed/simple;
	bh=kDNBpWln3tss6/GnGFcYCJpi6GkixDu6za8dJ31Z50o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVqjdAos0NzmrfIwy3hIm0l76nwtfo0gWEYHqnud6thUoTuar7qG35C5nlEh6XabsCG9OT0VbP5RAXBCAvxw+iMT9Ws/P9MEZ4kgSQJQO6rmJXKNVQOmmoJfF3tFu8vYTZy4KV1dxQKt4AiKeysY9r3Aoz/Vj0a2c9cvEOVy+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CvA2fnC+; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-78f8fde809fso2944847b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401132; x=1768005932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgWUPa6orN5QoP4AMyCwl9k4V9aiIUl9wXZJoJJf0Jo=;
        b=CvA2fnC+97ZdMzsjUzXBbTtr6v22pYe7uHDVQ53j9QD+Eef9W8SyPXujsi7QNR0rtZ
         JJJSAlOWnDuglV08T09NaFx4V5w9NVoett/uMfNPPLRlMnEzHeHX2rBSysQDSarV0ZQA
         s0aUJEvOcBhq4Ii19SLlUJs+y6DhCfm7yQh2d56KjXb7Tv3rbwoyNAFePUDcBVLK+eHq
         W7zNEsTXLd05E4l9L/o2hJdF64VWnEDedDgKZbXa4hc6lmhAIYFGiaeURjf4Rke7smLo
         YjGRzt+SquZd16K/DXJWu2VahH2oepncmfwhX68BYkHsoP0HBjzRCp/HTS6G8/8fGAfx
         BrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401132; x=1768005932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgWUPa6orN5QoP4AMyCwl9k4V9aiIUl9wXZJoJJf0Jo=;
        b=jdyJ9Sg+EDTZR/F6ZhjTFTSidFgkp0/EqwSYu7B5oDzSZUH/F5OdgaR6ITak9LKEsa
         IZltaUJRp9TTNtdfmInc/OZT0vTkgOSSvCAjzPGWT7/PFwcUHk3odiahAjrLIyrixxlU
         UKKpOniBZ4esAyVTJqd1Y3NJN8+ObpDm2T/EwzJE53XhgC0WYsiV8Uq0E9pTvnVJeLxm
         RqiynSgrw7aUlsrxgWV4eAoAE0Nb+SPFKz8NzXiqhU2C/BkvRSGjegzLCJlUCkdEDzMg
         sl5tQY7iKdCaUxiR8CGKMs97IbDNWiB1wWsp/3b9Q6FWRdxPDeAjJ7l5X6laqO8czhhZ
         P4/g==
X-Forwarded-Encrypted: i=1; AJvYcCWefFCMfEvsMLXCizC2cf1H5M/3QfvafVwVheylBlP1YhWpnvpV3NIV5GvCxF0+0zgwjeSZhXrkU/Ew011vPNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpcvXoB3N/UnXE8Bl8pX3hNL9JBW0m71Pb4s2V/vyYyVEPlOY
	aBcWygi5XR8P4cclfMjeO9gjlYgeSYNzGjxN1/6gKs0OqYK+DYBG9cJ8jCpBbwDVSjuo1MKCLr1
	AVZTuSwWgAPZ5I1dLUABKeRChGhm+lsGHqscgJ6UrE1g6MxaE4yD0
X-Gm-Gg: AY/fxX6qyoxN4NpWISWHFzdABtyjvxP4HAiqxoqKDmSx5UvLYySh4Sv2ihdi99fLJn4
	OcTuIe0ShFSndnQEvsMBAy5gsvsymHo34rlLW6XOdr5FkaqRmhvbkgIybK7/ehxW6jM2x2sriW3
	wzkUlZHOIj7FRWdEzd/tLdlf3faxEDpwZmrLMq9WTWBo85fJWRIcyX/Broy7DStmRqQVHCmNmPp
	wNYLECEgKyMqGFN42MZ6dh9jPyFocxXj9ATN8j55nCwQnJQuKwx00oIAiM3WDL1V0riGr681vP7
	hy+ZLw86lccpsgvxDYdodnMuRF1l8d71d0iOaTqgUGiV1HjjTInTSZvNAv7aoWarSkizPsIF6Ac
	7mwErqLtsCOhrkWNJGvnUtL7I/Fc=
X-Google-Smtp-Source: AGHT+IE08Oyk7AKw0dONXxGMI2MnsTwQytJiVnGGfrOyte7cJ8GRAAloVoyv9LI4dr8MqA1SgEpfYp2R/pa3
X-Received: by 2002:a05:690c:e3e8:b0:789:524e:4be1 with SMTP id 00721157ae682-78fb4015871mr306474087b3.2.1767401132579;
        Fri, 02 Jan 2026 16:45:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fcdc7488csm19124737b3.2.2026.01.02.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 73C353402DF;
	Fri,  2 Jan 2026 17:45:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 69390E43D1D; Fri,  2 Jan 2026 17:45:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 00/19] ublk: add support for integrity data
Date: Fri,  2 Jan 2026 17:45:10 -0700
Message-ID: <20260103004529.1582405-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Much work has recently gone into supporting block device integrity data
(sometimes called "metadata") in Linux. Many NVMe devices these days
support metadata transfers and/or automatic protection information
generation and verification. However, ublk devices can't yet advertise
integrity data capabilities. This patch series wires up support for
integrity data in ublk. The ublk feature is referred to as "integrity"
rather than "metadata" to match the block layer's name for it and to
avoid confusion with the existing and unrelated UBLK_IO_F_META.

To advertise support for integrity data, a ublk server fills out the
struct ublk_params's integrity field and sets UBLK_PARAM_TYPE_INTEGRITY.
The struct ublk_param_integrity flags and csum_type fields use the
existing LBMD_PI_* constants from the linux/fs.h UAPI header. The ublk
driver fills out a corresponding struct blk_integrity.

When a request with integrity data is issued to the ublk device, the
ublk driver sets UBLK_IO_F_INTEGRITY in struct ublksrv_io_desc's
op_flags field. This is necessary for a ublk server for which
bi_offload_capable() returns true to distinguish requests with integrity
data from those without.

Integrity data transfers can currently only be performed via the ublk
user copy mechanism. The overhead of zero-copy buffer registration makes
it less appealing for the small transfers typical of integrity data.
Additionally, neither io_uring NVMe passthru nor IORING_RW_ATTR_FLAG_PI
currently allow an io_uring registered buffer for the integrity data.
The ki_pos field of the struct kiocb passed to the user copy
->{read,write}_iter() callback gains a bit UBLKSRV_IO_INTEGRITY_FLAG for
a ublk server to indicate whether to access the request's data or
integrity data.

v2:
- Communicate BIP_CHECK_* flags and expected reftag seed and app tag to
  ublk server
- Add UBLK_F_INTEGRITY feature flag (Ming)
- Don't change the definition of UBLKSRV_IO_BUF_TOTAL_BITS (Ming)
- Drop patches already applied
- Add Reviewed-by tags

Caleb Sander Mateos (16):
  blk-integrity: take const pointer in blk_integrity_rq()
  ublk: move ublk flag check functions earlier
  ublk: set request integrity params in ublksrv_io_desc
  ublk: add ublk_copy_user_bvec() helper
  ublk: split out ublk_user_copy() helper
  ublk: inline ublk_check_and_get_req() into ublk_user_copy()
  ublk: move offset check out of __ublk_check_and_get_req()
  ublk: optimize ublk_user_copy() on daemon task
  selftests: ublk: display UBLK_F_INTEGRITY support
  selftests: ublk: add utility to get block device metadata size
  selftests: ublk: add kublk support for integrity params
  selftests: ublk: implement integrity user copy in kublk
  selftests: ublk: support non-O_DIRECT backing files
  selftests: ublk: add integrity data support to loop target
  selftests: ublk: add integrity params test
  selftests: ublk: add end-to-end integrity test

Stanley Zhang (3):
  ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
  ublk: implement integrity user copy
  ublk: support UBLK_F_INTEGRITY

 drivers/block/ublk_drv.c                     | 387 ++++++++++++++-----
 include/linux/blk-integrity.h                |   6 +-
 include/uapi/linux/ublk_cmd.h                |  49 ++-
 tools/testing/selftests/ublk/Makefile        |   6 +-
 tools/testing/selftests/ublk/common.c        |   4 +-
 tools/testing/selftests/ublk/fault_inject.c  |   1 +
 tools/testing/selftests/ublk/file_backed.c   |  61 ++-
 tools/testing/selftests/ublk/kublk.c         |  90 ++++-
 tools/testing/selftests/ublk/kublk.h         |  37 +-
 tools/testing/selftests/ublk/metadata_size.c |  36 ++
 tools/testing/selftests/ublk/null.c          |   1 +
 tools/testing/selftests/ublk/stripe.c        |   6 +-
 tools/testing/selftests/ublk/test_common.sh  |  10 +
 tools/testing/selftests/ublk/test_loop_08.sh | 111 ++++++
 tools/testing/selftests/ublk/test_null_04.sh | 166 ++++++++
 15 files changed, 833 insertions(+), 138 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

-- 
2.45.2


