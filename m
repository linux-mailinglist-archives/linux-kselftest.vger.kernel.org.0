Return-Path: <linux-kselftest+bounces-3706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C08578415E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 23:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC40E1C221DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AAB4F1F8;
	Mon, 29 Jan 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSf63UrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A284C61C;
	Mon, 29 Jan 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568345; cv=none; b=CEawTaTBPwhwiyp7TGX+4YByVmfF8qn2MrGBoVSluMWt7lmZRart75n3eKDDo3y4Mx45OuO/P87jrJWa65LjlLaXylquVKv0qlOZGChUbfzQPCv5JTBQ+WfWlDSoOQvISNhNXc83qTCu2qh5dM2ZTlLxnAAqzPrEFMbul1WCJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568345; c=relaxed/simple;
	bh=PeyKpi3tDbew9H/Kznq4URYw//vD+RtFj+UxPUDWjco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bZBouQgeSXQV6HRqoTtfAiapW/aiYECqKWleQNk8TI2vh+kWiHSgM5Jt0dz5nLZ73iu42VcsmqtdYhvHZTKMtB/obFQdWGLrYg8bwbELTaUJJtGCSaq2IrbrgZSNkJgxOveiDfGbbHAlLa+yW37z2kgDBufdg/nWD8RFWV0jMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSf63UrR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a31b90edcso31590171cf.0;
        Mon, 29 Jan 2024 14:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706568343; x=1707173143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlLu7trzeHyqSQRXqMq40CkkqtS7Mt/iq+CEIontNuU=;
        b=QSf63UrR2MrsORZ5jqfWHZlCX5QqLGZxE47AyBoD8K9CUj7b1HrPyNY0SCTfKcy1MK
         sFAftZI3wNOAjhoZnsWcPyvF5Tr8jfU4Jzm7QDV3RQ8Yja9l4kboWtBPH2xTKlUiBCW6
         a4r4s552HTRVvFV7pg2lzcTHG8z1hioshejKmY8qZTKIkX6umwuXCSQN8lcr4zIcUiU8
         JB5mfwiOlDgxDbapHCFcOEp3uQNcJpvPPb8Sq/ZHb1IrpTsGrKBur1CzkCeZF/btZY/C
         tEAEHWXqTCqIxfuCYzt9736JUpi4cn4L0t4dES2QOafGWIDHbGSsZHQs95Dj3ic+fEn4
         Y01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568343; x=1707173143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlLu7trzeHyqSQRXqMq40CkkqtS7Mt/iq+CEIontNuU=;
        b=n+NyzEBabC+jndUOHLpKDQqynUsGFfjsHZrpfyizuxQkvE4jYdIRQ5xzOWLW7DZs4T
         O0po+z2bTTt9kaf9GFyIPEaMd8v1tFUWToeXq/VrPrR1vaBmBxg128v/z92WBLKMyItw
         Kj3ZHikTEbLCgNKQosXfjxHCReU5pMuN3Rm4Mfq/T5AxH4sZv/uvWhPVgPJIVAYA/T0S
         Zgg4shctzkOKu2TGBneC0Prs47ReklvoCSu3vMXxGqL5G+biFOL2WArfjo1wK8QY3/Om
         7+QIRS7+sQkwk++pv3KnhKUi6z8aZZ3/WpJQyaunyror/UAcm3VXggsD72NIF5hcDmRC
         Y2zw==
X-Gm-Message-State: AOJu0YxorQLHSnR4BKUQFpbBoQrMsmZmKv5Wn5haHv1XccU9+QCvXo2T
	UWpoIR0NBvjZ4e7FaypTz3k4njFjcY997EtqSaj2oIpdJ4FIw2S4
X-Google-Smtp-Source: AGHT+IHl+hKrHO+DtzsL6zxDaVBouqbIlSWLCUFNOz0Yr0doLlsNlIvyGbJz5LcomsrpA+IO1jm9Qw==
X-Received: by 2002:ac8:5bd6:0:b0:42a:b19e:3c9c with SMTP id b22-20020ac85bd6000000b0042ab19e3c9cmr1173295qtb.58.1706568342782;
        Mon, 29 Jan 2024 14:45:42 -0800 (PST)
Received: from localhost (fwdproxy-nao-005.fbsv.net. [2a03:2880:23ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id x15-20020ac8730f000000b0042a96eae7f7sm2569239qto.57.2024.01.29.14.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:45:42 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] fix and extend zswap kselftests
Date: Mon, 29 Jan 2024 14:45:39 -0800
Message-Id: <20240129224542.162599-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a broken zswap kselftest due to cgroup zswap writeback counter
renaming, and add a kselftest to cover the (z)swapin case.

Also, add the zswap kselftest file to zswap maintainer entry so that
get_maintainers script can find zswap maintainers.

Nhat Pham (3):
  selftests: zswap: add zswap selftest file to zswap maintainer entry
  selftests: fix the zswap invasive shrink test
  selftests: add test for zswapin

 MAINTAINERS                                 |  1 +
 tools/testing/selftests/cgroup/test_zswap.c | 69 ++++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)


base-commit: d162e170f1181b4305494843e1976584ddf2b72e
-- 
2.39.3

