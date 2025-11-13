Return-Path: <linux-kselftest+bounces-45529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B1AC5721B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3EB3B51A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B633A026;
	Thu, 13 Nov 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsjiFkuP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8802D5C6C
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032475; cv=none; b=bBMDOM7U2FGr8/6PfygWs9hX6trNYH93fe9dl6yhR076eaqq7R2JXOM5IJnZAYFQmjCg2ZaVg9Lnvh9TvQ432uz6GnNHwKjXmuIeFEfhGgdknQmrI7TRf82W56RfEKf4enJtsNi22EwIw1FOGdv2GV3Ir4DY/LXwrCHrkf1YG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032475; c=relaxed/simple;
	bh=th9M2NykH7Yb81ZiuFZqKlR0D3oO9gdoL+Ub+EW7tMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrELZvFp0FnW3HGvwjtyXVHQbfiImRilLgMhDLTPtzqV+tmi+Afb7tCO6mFsn9kOrU7nFyjygcD/61hon4WU+8wUMCQq5hSlnzjzcXfM5BrNOrCLv5aQ96SWToCEbjmYLkZs53cDjmkO4UHSX3l7khPLdjf8VsdcMBFirzHMXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsjiFkuP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae77516so7331275e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 03:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763032471; x=1763637271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g4u7C3Y0NwjJH9VEsr30c+gij/q8WlsHyQOgxxJgZik=;
        b=MsjiFkuPZXAnw4rEum1edPN9qIxLMbLHQe/ZISRDpMSP4znWYz/Xph/yAp2pvSD3/A
         uTv0MMCu/JeYfXLXAuEdivkFUR3It/BzRbdghzvYYfTdKXW9Y6B+vy3yXgphVUFa7F5L
         AHaGMPmXjC9/NEwRv82BDVejZTQGPCloEuwrI/gsaTnvYcbqm+zlTTMauSkTMi4Qikko
         aTetlyzE8mqWJjtLgcSElfzPiCh/v4u/lFBNNdtz+Y8MbGKzI7K2wi7mu3zk8p+KpVbp
         MaZNYmPUMvFGdDF8S8285a7UiUHeRkP+8CRg4cbXnKZ2lX4OkHxzOqesCkjyhxqc5XnE
         CQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032471; x=1763637271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4u7C3Y0NwjJH9VEsr30c+gij/q8WlsHyQOgxxJgZik=;
        b=dDt2WMLtdvBAlJryu64bvluDC5brkZAII/DBXn3W7EynJGYumKUgEvA8ZfQSOgaRSC
         6u+kgo0nk8A8QJ0ESA+n61PdcFMCyzpwhwoZjowdUKrLZRkqL9+AyeYcZdDVAd+c2Zq9
         lLq72P8YOxKgz6W+akb/YWM7sy9LBKrfMFL2bEda4bUpv8H+nNuV1amm4rjfwmUvOV4S
         JwgErJlzUczHcKL4tNQY3DZrUEcsPqfnvDtFflRHur0KotXiZyfMjQu7lL2sb8nQs4Xe
         GJu6lGD80mq/hHe5OTeEjyRqXveb81hagG/ObkYME143uI/yjFhhyKWf85kbEWQRfGlv
         RpXg==
X-Forwarded-Encrypted: i=1; AJvYcCXDXWlbLr6z8enEkCQsvXf5woAW60oqY1QCtP28jHHohyWcrRNm6bbOamRpjksFN9SELFafHXrzqxv+M91/qjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC624rP4keRjUJCiyuX8jm7dl7Y6YDw5VtFITaGJUK9M947N26
	UXpV9r74G8IFSb0sCzMLItVx68CUz64ji6LkUOtdXqgScQkcDNQhs+k5
X-Gm-Gg: ASbGncuwLcYwi+49yBBLY/6pFS7y7pzmq9G06igFEwKePQH8TATfw1+BvuTwD5D4ynS
	MwS+7W6zgOIXV3M2xDVBJGted++eE5FPIXqQpODGXhwAV1y1fPfYDF+JiJW/0MHqk0WQlRSJjyL
	+V7khinAm133ugCMD00z5UhFlno5M24d38FUFJ/L4bvcj9INBaZufHm3lkEFC2uI/070ZTbyR30
	gexW89DHmejxQtOWemaNYmiferuEFO6CxLhQL1G/Vuv3bMHbYKQ6PXt0g1GeyFireFWtNZYBCOs
	YmbFJw31pwy+UOBanDq8bpm5EGGJYVKcCHs6prMTPANGoLXmwjTsSY3QT/Z5EQppqaVyoTD1vnx
	s6QT5I+OmvbP8eOn4vw/iUQ2CxrkRs1HYn1GlpEzlryl2YTyto8K1tTRT0zkUzxNwtzi62FtGa6
	eY3MnpGXxLXbXP4wRE6csNmeQ=
X-Google-Smtp-Source: AGHT+IFYVhYBjfP04vJBGEnSjIyHx4PM2GrEwHP+F5uBytgA+05q2tu/UUG98vl4/aZlU3S5nvI9PQ==
X-Received: by 2002:a05:600c:3587:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-477870450ffmr68835375e9.1.1763032470903;
        Thu, 13 Nov 2025 03:14:30 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcfa2e9sm17739825e9.12.2025.11.13.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:14:30 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v3 0/2] libbpf: fix BTF dedup to support recursive typedef
Date: Thu, 13 Nov 2025 12:14:04 +0100
Message-ID: <cover.1763024337.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_struct_types() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Changes in v3:
  1. Patch 1: Adjusted the comment of btf_dedup_ref_type() to refer to
  typedef as well.
  2. Patch 2: Update of the "dedup: recursive typedef" test to include a
  duplicated version of the types to make sure deduplication still happens
  in this case.

Changes in v2:
  1. Patch 1: Refactored code to prevent copying existing logic. Instead of
  adding a new function we modify the existing btf_dedup_struct_type()
  function to handle the BTF_KIND_TYPEDEF case. Calls to btf_hash_struct()
  and btf_shallow_equal_struct() are replaced with calls to functions that
  select btf_hash_struct() / btf_hash_typedef() based on the type.
  2. Patch 2: Added tests

v2: https://lore.kernel.org/lkml/cover.1762956564.git.paul.houssel@orange.com/

v1: https://lore.kernel.org/lkml/20251107153408.159342-1-paulhoussel2@gmail.com/

Paul Houssel (2):
  libbpf: fix BTF dedup to support recursive typedef definitions
  selftests/bpf: add BTF dedup tests for recursive typedef definitions

 tools/lib/bpf/btf.c                          | 73 +++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/btf.c | 65 +++++++++++++++++
 2 files changed, 121 insertions(+), 17 deletions(-)

-- 
2.51.0


