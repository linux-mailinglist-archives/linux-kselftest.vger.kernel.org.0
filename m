Return-Path: <linux-kselftest+bounces-48238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E847CF622C
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89325301EA2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0620221770A;
	Tue,  6 Jan 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="d5d6Im4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7101F7916
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661090; cv=none; b=KMiph8JITRSJ7/ENTBD9bbkjabpAhHJ2LjBIDrALRNJ6Tnzw134CyDhheYHQnaJnfa5EH1jnlz6NuaZItHZ7iiagW7dazsbhiqMxEadk/ckk3eiukG3Ddt6KcUtXc+dCsOAABA1otZp6O0UKDPYGM2IVr6/fxPQyTc2qFpPRUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661090; c=relaxed/simple;
	bh=q10SKFFxbNc8ypfAvSgR7OQ5RK9W5sbsfCaJmLr4ejc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTXpybfE2/8Q8uYLwWy94+YyUCqaIfrFZsLk6uswE5lsjDISx8IO+x7flIR0CltzSjkGDPNjpp7jb++JRp1qHm9sZUQElYX3AE4jto/gBL0n4Y5A1r3g3LHYGbs3Cq7IPrziwuSB42FxV6sq5Pr7UI2ZMe0Pyq8dHwfhZjUXTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=d5d6Im4/; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29f3018dfc3so1434215ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661088; x=1768265888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDFmcsW33BYHY8GTo4tOOXvcpZxTkuMyQW3H6JOO+EU=;
        b=d5d6Im4/LusQhwTG7y3bXsSG8Sq0CgpEYegcY3zbTFNUIlXY4pwQ3kuMq1cm17HugV
         /z8qfdNe1Zgp03mZHE0pWS0fTiu73Kxb6gzpsTfOEFaiU8l4SlEVr2BH0JuzVFjMw4xZ
         bur4ffeSFntZB5p48BteNb2R10XHSe/11plP5k3/qKTLfV41hZ4bl4ME/F2Cxy+XtdJB
         5OYOLPVJeKINJLrhvFVMDVqmRwPJMI+7iPPGsagvRI3B5DhA3b68C9RgVq/8OAZh5F0/
         P9iMrpUlztUOlcRx8wycWWCoD9CwvKfSpJTTzpFOPa3OJ1A0yQiirtm943HCqK3mLFWr
         s8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661088; x=1768265888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDFmcsW33BYHY8GTo4tOOXvcpZxTkuMyQW3H6JOO+EU=;
        b=t1N5O8d5OYCcN7Gj/btjf9JxDc09sPl21pHPHDWtxKAgjAnJIrleo6OckSaBYxAT2t
         bShTlQX/SD2I+tkg15h14pXxyo6u9FRt0zY4pt0H3dSD9iSFJOkbg8U0N57+yhcY7QHn
         ZlpS5N7/+iNMfchFKKJnbNicCCB8EOPA8cxpPr5B3bcOBAk5+gLPW+UlXnJL0JwCqoYI
         5FR0CsKIZwwMMhodJsgW/r2sjQIS5JyLEgyCitvnpA1HNK9L8wJGWcGy37N/p2X2Ahyy
         a+EGAEDGMYHsR1ZZdPXC/ELb0aTYR/zHeiMi5VLQcErHbrzMfC8br8LcowjwTxxX1MTM
         5Vew==
X-Forwarded-Encrypted: i=1; AJvYcCXzZ6lu5mimMZPT2jZ1P0WRIc0JcB3F7j5xbmO1WVEVHPpuX4Kd214AaheDzHfXM5B3NLg86XlhbCzJEXb6iOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgHzlRumvy/6h1DcmSHyd5D2TjCbmGP5RNr4SE20fwtH2s1Z8
	VdjNG021IOiiI9vM26KCtK20zZGP/Mh6J67R76j/bAnU8TID4JODlWmlohqKWjhnYFVSV9VDRus
	/DDy0YcNPYwjsGMQo22h+gFfa8S9r2I2KWegb
X-Gm-Gg: AY/fxX6IAyswqwGk8MyCR7FdCaIWf+VeWcxrA2VPPKWpU5pIZ+OCh49tbhsFMdjrAbV
	aUL94EXNJIPYR0saTnuvgAU1Rh9Fle13sBUKAF6lmejAvQPOj6O3sCVIQbyBeZVpoD9x7jw6vnJ
	oxECpX2m1A4OU8Cem0jKA3gDFurfjDLPrIyhl3yETwG5MxWiK8eJzU/mJEk78P/NeQxNWMWzL9x
	fYoQ8EcXU02zclOZwKutMxYIe4KjaYfgBpWDEvVtdZXkHk1ITPwaNxig3B+MKiupcSdf5ldesqu
	LTF6ipmw2OszHQnBhKdotytH/zISSLghqdutyrOdEP6JVtgqAnEAmTJtz9see9GhH4qwx8gq058
	hxg7XBxIaPsZI/FzG1qD7+RQgTAcOADFVJkaxyg05zA==
X-Google-Smtp-Source: AGHT+IGsdVivyDW/c7LUHssPEi8LlFgcRlPN75s66XNJ3Fg2TMMRQxr2eDyeu21zMI5rpQJyTMoTgxtJXjAt
X-Received: by 2002:a17:903:1b04:b0:297:f3a7:9305 with SMTP id d9443c01a7336-2a3e2e079eamr9824795ad.6.1767661088175;
        Mon, 05 Jan 2026 16:58:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4aa8sm882765ad.46.2026.01.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 96BF43401CC;
	Mon,  5 Jan 2026 17:58:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7176CE44554; Mon,  5 Jan 2026 17:58:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 00/19] ublk: add support for integrity data
Date: Mon,  5 Jan 2026 17:57:32 -0700
Message-ID: <20260106005752.3784925-1-csander@purestorage.com>
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

Not yet supported is an analogue for the IO_INTEGRITY_CHK_*/BIP_CHECK_*
flags to ask the ublk server to verify the guard, reftag, and/or apptag
of a request's protection information. The user copy mechanism currently
forbids a ublk server from reading the data/integrity buffer of a
read-direction request. We could potentially relax this restriction for
integrity data on reads. Alternatively, the ublk driver could verify the
requested fields as part of the user copy operation.

v3:
- Drop support for communicating BIP_CHECK_* for now until the interface
 is decided
- Add Reviewed-by tags

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
  ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
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

 drivers/block/ublk_drv.c                     | 350 +++++++++++++------
 include/linux/blk-integrity.h                |   6 +-
 include/uapi/linux/ublk_cmd.h                |  24 ++
 tools/testing/selftests/ublk/Makefile        |   6 +-
 tools/testing/selftests/ublk/common.c        |   4 +-
 tools/testing/selftests/ublk/fault_inject.c  |   1 +
 tools/testing/selftests/ublk/file_backed.c   |  61 +++-
 tools/testing/selftests/ublk/kublk.c         |  90 ++++-
 tools/testing/selftests/ublk/kublk.h         |  37 +-
 tools/testing/selftests/ublk/metadata_size.c |  36 ++
 tools/testing/selftests/ublk/null.c          |   1 +
 tools/testing/selftests/ublk/stripe.c        |   6 +-
 tools/testing/selftests/ublk/test_common.sh  |  10 +
 tools/testing/selftests/ublk/test_loop_08.sh | 111 ++++++
 tools/testing/selftests/ublk/test_null_04.sh | 166 +++++++++
 15 files changed, 777 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

-- 
2.45.2


