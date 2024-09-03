Return-Path: <linux-kselftest+bounces-17071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B516496AA72
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419C7B23BA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54B13DB88;
	Tue,  3 Sep 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx4fgMP7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5419CC2F;
	Tue,  3 Sep 2024 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399636; cv=none; b=PsFqm2sXGHpYtlK27jeGoqWxGvFjHUzE1uo9toFsJrWxefzIgjRJ3rLwbKJ5W5Lr+EkGMMiOl822dX1wjHa+BjLY3GZEF0tf+EK+Wr8Ng8KkZ9VIGYUlxAtjUPWHS3gxh0DXMJKVyg5HFkKsOBPVZhu3qKcqCd2yUhQ9YzOk1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399636; c=relaxed/simple;
	bh=IcvbXXz0Vvf8CyXmftW5hRraLHFo0mp3pBzgWm0mHWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orD7Un9u1FNZW4lyaSUwu6H4a9jR2YUNX0FKDFDsWTDYo8L346qjAiiz31RoTd8A6o0xOKRMedGpBVZu85sOkwLRTJl0fMNAtSGcvpWEIhuA4IKudFm3abVa+aeUYPFqysKgsIFzUefsU20+y826YXkHFK7sSQRBPBhHCHDrFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx4fgMP7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20688fbaeafso15790525ad.0;
        Tue, 03 Sep 2024 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725399635; x=1726004435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItEaj+7c+oNsUU9EThJUwUeS5ekyWDXic3HWvBrov4A=;
        b=Fx4fgMP7s30aZfHU7SdcXNpb/T9nkzj4hEYtq3MGR4YTAueJSA8qrlL227e1qpDsc6
         /OSP7ViMfXaj/R+OQflCrgt8sKvN9/5EEKXwe6o9DohZjhfPpeo3527QWZ2MQ+058dgW
         LJ3KnSVPSS959ZAv082TNDSk95pcHCczaj5P0w2iP+7/vJVoRnh01vZ92jBZzqNThIwO
         Sn0r8Oc7O8fTacgvWbdw41geVgIziZypAXlOQnW+8AK65Jq/0L7Vl653HJOqza0dcIx+
         LSqHom7uB5vz2rUef2VS+a6g88AKZrHm51MpQb0pJ9+AyZLPPpjzYDF1Xl5pbo/PPU/I
         zZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399635; x=1726004435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItEaj+7c+oNsUU9EThJUwUeS5ekyWDXic3HWvBrov4A=;
        b=hhnhc1D50apnihGRuSmsRRoaCEwsN8sn1rWGOtNdLCIIy1YP7TYSRyO1n48FB3QAO5
         J6hJ5TRIIrekie6M0cyqUih4eRCbQvMOnk+tKaxSwqgEQPERdehpVA6WqcDRV/TuDaw/
         WvwvW42Xh/c2Xh5FF5hVxPkQY4uZywNEzdC78G57AYwmKqc9M9IxJODqmPWvb2C0WxkX
         bRy3Pu3yxq5HLyffW54ydiK39Pg/Vg0m4ZMTz3XbJfEUSodtQII35hSt/f9Us1Q0WkIi
         q1u9My9unIOdxeA3d0mffZbBCNXIyvnphYvBonVB0ebDexPgTgS1D4Dg7n438HBlQIx9
         ZQDw==
X-Forwarded-Encrypted: i=1; AJvYcCUaP+uuFXy+t83m7lMuBmT4+l6YI2BQrHCoRnDNe3e7vPyIIUnGPloLM+UwtGpNCPnOKRXyIzJ+iTfOTd8=@vger.kernel.org, AJvYcCUwGXe59f/Xm9LzvWiRdWYhfhrdDHPDJIzzBHKT54rVN7Wq3NIsrQGbMekEm0FhkqYHq/k4xPclxAQUJnC8NcYM@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJj8ceEGBHYJo7ZWw7vWshYVm9fQJ1Yu4A1wF5x8TLY38bbsg
	IF1ElFMdi4GCP9QVgomcK0yW76sKcfP6LRtzmHe6sQpMLLggIxCtpozeMsE6
X-Google-Smtp-Source: AGHT+IHPSQa97f07/fTQL9Cqu7xkZf/Vd8GxQ+k9+NJ/TMhGBcpFDXMPAKQe6IV000aVfCnCbk5q/A==
X-Received: by 2002:a17:902:f549:b0:1fc:6740:3ce6 with SMTP id d9443c01a7336-20584193b58mr63410285ad.20.1725399634596;
        Tue, 03 Sep 2024 14:40:34 -0700 (PDT)
Received: from arch.. ([2804:1b3:a700:a499:26ee:9aff:fe39:f350])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3864csm2699525ad.141.2024.09.03.14.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:40:34 -0700 (PDT)
From: Artur Alves <arturacb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: n@nfraprado.net,
	andrealmeid@riseup.net,
	vinicius@nukelet.com,
	diego.daniel.professional@gmail.com
Subject: [PATCH v2 0/1] Add KUnit tests for llist
Date: Tue,  3 Sep 2024 18:40:26 -0300
Message-ID: <20240903214027.77533-1-arturacb@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is part of a hackathon organized by LKCAMP[1], focused on writing
tests using KUnit. We reached out a while ago asking for advice on what
would be a useful contribution[2] and ended up choosing data structures
that did not yet have tests. 

This patch adds tests for the llist data structure, defined in 
include/linux/llist.h, and is inspired by the KUnit tests for the doubly
linked list in lib/list-test.c[3].

It is important to note that this patch depends on the patch referenced
in [4], as it utilizes the newly created lib/tests/ subdirectory.

[1] https://lkcamp.dev/about/
[2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
[3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
[4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/

---
Changes in v2:
    - Add MODULE_DESCRIPTION()
    - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
    - Change the license from "GPL v2" to "GPL"

Artur Alves (1):
  lib/llist_kunit.c: add KUnit tests for llist

 lib/Kconfig.debug       |  11 ++
 lib/tests/Makefile      |   1 +
 lib/tests/llist_kunit.c | 361 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 lib/tests/llist_kunit.c

-- 
2.46.0


