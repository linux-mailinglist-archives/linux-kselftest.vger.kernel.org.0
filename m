Return-Path: <linux-kselftest+bounces-48484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAE3D020AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AC8313AB6B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3038A42B935;
	Thu,  8 Jan 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e6QnvJAe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110C42A596
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864012; cv=none; b=lFVQzwVXTDKQxnyhJItiSQLNDzRGwEudm9n4ckzXPKHr3gT7chbed9t8U7VzYEwe1WjNfecFCsniFEwbktRRRg9SFbSngwkphP4QTSFzQdHc8gfXEBFWojTHFqOsLsYMFR5vxlg66Hzcv7XfY9Q/YtRXi2apZujciaVprFlLQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864012; c=relaxed/simple;
	bh=/cX1S2kpXdfGOM+zBYi0+ItgHbd7lQp5U45NRKX3a1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+5uATQTujkXItF5LMO8KlqCy18Q4USvuUthIchUx7/9UZeVmSLFIEQxmKhiTNqIcONL5EIzInDGRheZgBzQIVAPbAouPBqpL5GyVqrVJnz1sQu4hCvEAKh2fFJnapbPJ5aLH7OmMW7CPajtLEn82ZmmFlBl9TfHmY9T9SrHzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e6QnvJAe; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b29aaf9e3bso36968485a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTYID6DoRfwiB2/1tRruiunrWZu28+OjUHb4ZIUtOw8=;
        b=e6QnvJAeDgs09jceh8HdsfTf9v7lA0FtBJPMoojiLxdJU+6yqhBo+BQmQIfis79wwS
         dbgmb6Qx+tltTcB61BumW4DJlXZS3nhHevOyF1rjN585KAHCC0JAYY12M5wpZOuUt1Nl
         KMR1oCmxU1L7UhKUkiWhiYGKn2HpzBteXzlD/1V7clvO+wLdh54jVMA43JIO9xBydrk1
         mCjJJP/yWwPYty0AbCEH0EokVdZli1+Sk+IxLcr09CiYzcKYdPOZGgxbvSYXjc91UeqJ
         pi04b/qN1egokoJHMFvq0s7EDi46mdYv++07gb56ymHzHZHuwnM9E0MpSnF+qdRTYxMK
         g9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTYID6DoRfwiB2/1tRruiunrWZu28+OjUHb4ZIUtOw8=;
        b=IR31TwnTBNd+zPsVRSX7e+WBX8nymyva5PVQJlR3A3fstx0NEl298tCL1sOauTiqG7
         tbgVtRiChsbb9Rnzn7g327UiIYNYa6hmVGV2plZVWJ+/YeU4z44PPwGNHMI7zS9o2exM
         tq0D1sBJLWdMphI6yammW5jNlpRVQ9F7oRxyE9jGKLYuIR0TNCiMXTngeB3V87PkULKr
         lvG7I4TJ91b3jc+P5doNpnfKAbxpmQtTzf6EQ1q+0/phtkMHSVLmOtlW9sSCeNQkUNfL
         Bt009WL+bHqxB4qETbDxav5iuN9uVSWe2FhdWKIpsrJXnziPOn1a6aHvDEG1yAx0fdUF
         GWBA==
X-Forwarded-Encrypted: i=1; AJvYcCVzOM4vQW2G7/Rs2xgq4llHFW9ajPH+klSnEgm+juloh54K2ZHJ+uAwZWZuSNQjQrk8G0C3007aFpBROiwmWKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqWhEkfm4K5MR9ZyF7u5/ZoTr8IX5xCqskI4Vzbf/KszKMVOq
	E1JHVmiiR14TXQkpk1vOBwOuM8cK9/Rh8EYqnOIO9lD2XriUo6rPxoWvO+5kcrwUauxRSh6mg2Z
	5x+mxc4qe4LjshLasfYnGKt42DK78kN0VJQC2
X-Gm-Gg: AY/fxX6i1Po2iCRG0rIlLJWOPkWtubAxIQDlaYUe+AO1/cMUUd6aogIrrd4Eu8+nykN
	6JeNyM8TFsdt4qXXxRks1AEIB7dxC4LK2hBvEzZ5rxHtIKJRcOLc5U+Qi4dQfdMfCrPlUeI92VT
	5FjBRLZBMYjlQwS9SqgnJAf19SKcEaXi4pbAMh9wkJp+CpoxDAcK3BhfrdhV4uwtLpUewgNq42b
	ehmGjvbQsslrzpCZGnD42TqliMYaaRtZIklniJqN8Ze+a8yPV6+avOPfaXjqIcX7iU4Vbaq/Uoo
	elNSB4nBJ1UaiFkIJN9+LHZSMIyN4H1+Ls+yRoyCeUtxqMdRQBKfr88jvw9/XalZF+ZKePrpWkN
	1NOhJLOKKI86nXuZYal9lGOiQrX7iam2PAf9m5EVXPQ==
X-Google-Smtp-Source: AGHT+IF/rVOzLEhkAR5cONWO3fZUALGrTiAA3WwQeV+nDp+rvvKKhef1G+9hCOog3DBY5g7GEqnSWvmMg8Bm
X-Received: by 2002:a05:620a:4083:b0:85a:8fc6:5c28 with SMTP id af79cd13be357-8c3893dc383mr526666085a.6.1767863996054;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c37f461be0sm82438285a.1.2026.01.08.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 17EF2341DAF;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0595FE42F2C; Thu,  8 Jan 2026 02:19:54 -0700 (MST)
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
Subject: [PATCH v4 00/19] ublk: add support for integrity data
Date: Thu,  8 Jan 2026 02:19:28 -0700
Message-ID: <20260108091948.1099139-1-csander@purestorage.com>
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

v4:
- Add max_integrity_segments to struct ublk_param_integrity (Ming)
- Move UBLKSRV_IO_INTEGRITY_FLAG to avoid overflow from
  QID + UBLKSRV_IO_BUF_OFFSET (Ming)
- Check UBLK_F_INTEGRITY when UBLKSRV_IO_INTEGRITY_FLAG is used (Ming)
- Initialize integrity backing file to disable integrity checks (Ming)

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
  ublk: split out ublk_copy_user_bvec() helper
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

 drivers/block/ublk_drv.c                     | 358 +++++++++++++------
 include/linux/blk-integrity.h                |   6 +-
 include/uapi/linux/ublk_cmd.h                |  25 ++
 tools/testing/selftests/ublk/Makefile        |   7 +-
 tools/testing/selftests/ublk/common.c        |   4 +-
 tools/testing/selftests/ublk/fault_inject.c  |   1 +
 tools/testing/selftests/ublk/file_backed.c   |  90 ++++-
 tools/testing/selftests/ublk/kublk.c         |  90 ++++-
 tools/testing/selftests/ublk/kublk.h         |  37 +-
 tools/testing/selftests/ublk/metadata_size.c |  36 ++
 tools/testing/selftests/ublk/null.c          |   1 +
 tools/testing/selftests/ublk/stripe.c        |   6 +-
 tools/testing/selftests/ublk/test_common.sh  |  10 +
 tools/testing/selftests/ublk/test_loop_08.sh | 111 ++++++
 tools/testing/selftests/ublk/test_null_04.sh | 166 +++++++++
 15 files changed, 817 insertions(+), 131 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

-- 
2.45.2


