Return-Path: <linux-kselftest+bounces-35209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E675CADCD92
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29FE1884BC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938742E2657;
	Tue, 17 Jun 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eeeubEMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9492E2646
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167433; cv=none; b=WuU4t4FmwpcL3lUJEISO/oGGLQh71wYukDhlXgGRyGOqSX3jg4IVU1iOoVPFxJmTl7ktdIwvsxBRdk9U2ly/IQW0TxWMK8JaMe6EsC6oWBAwPoneWpzy+B00VOQEumbiJWGhEC/XNoWz6YlgwuhyRRd98v709je2Zfvz4lsOIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167433; c=relaxed/simple;
	bh=syEOF23WYnR+m4ZXDu5w2UCFevHV0uRwaU7OFMcE7RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zp2OJXHr75zZlyWr8XHAEHFv78ZckKTaSKYKmaIWb4EE0xgv0il6sBAzmTLDv36DzMjlnGSSK2OQDV+CS3Hz9hzJoiyYDgn036PJeiSAA1z+UW09BWv4MZL/Q7e1vJooJvjOrDh4S481qR9/A+WcDAyFtQA86x6QDTOcH/Yjs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eeeubEMo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d6ade159so47737715e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750167429; x=1750772229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAb6vAt4cs//1SvpF4Ccxpw3YC8TLR2gb172yFffxHY=;
        b=eeeubEMojDy8IavtdzD88nb70r8zDEOBGSONI9yUjo8UqzFDIGqlTE1j/a1PXJ29z7
         f8m1JJ0PiT8S223orRhpW1QTRerbgaFXLXv6b4TQtMsPgh0I0RWP9sOTR2EEnw0ebY+2
         wRHMKxP6Jc2C5hYk6kgc2kgXp4G9z/ob7F6vANYHUO1IJU+UzD48bhHxAmMlXzT3ha9r
         1NhceHyrJ9Y1CpKCaB9KzEJ1BK/BitLLsXTY284RUvzI0De+aqvC25e+iWMy6vdnPLDX
         dFhsCnKTth+CTIy8vNTjG7SRiAIoxvOWkBYgOKjVePGlsDV4eYeNr+jYIqAsovEkZbDD
         VAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167429; x=1750772229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAb6vAt4cs//1SvpF4Ccxpw3YC8TLR2gb172yFffxHY=;
        b=cCgcCXlqt3DINybTyOhIqgAgT1eaGplACbmy5zsvvvCqkqJQfbwztmLeCbE5bPq7VN
         3OReXab29DWnUKcxmJCwyx5FiQ79MsXp2Wx+xHAdRoaQOau7/Pt8tnCJmVp/la7IjmBN
         vXhsaYTeEMoi41LxD748hJxwG7qO5PZ0UP8BuYNletLJGnxlrfA2+gNnR55Dj1AtxAq3
         tc84AF1CsJcMB6+jWl8ITAkA7PV61nrPKPEj9/p//6b1RNakMIk2DAYcnsFHtx8OT/4r
         KARXEvGVtPOrkFE836dhcVIozHG+AzERxbuiJkAWlCgL48K4ig3F3U9PtPaBtMde5hDs
         YQdw==
X-Forwarded-Encrypted: i=1; AJvYcCXonKsh4U3blAIZ1XVKfgpypWLkAx7boOXDIgStwt7cOIr/2TpmCf0cGtmUKe97TROs/PAIOq8UudBuhtLplCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvbI07UK3XCh3RoK7Y+n/9jukY9FrG/QLvXBxYh78GLPbT0wY
	RbPC5F9DETgR17EdrPvljxT6HJAw26RoFICq2tKxoVk/UX/7dWoqVqu0QGPLPBaYm7Ze1be+PB6
	KSMCpEx8=
X-Gm-Gg: ASbGncth1sCBOyBnvJJO+qJRjyOEjWu4QBS+j3z98OniMvnqjzIFeEzXbuVr3zK3k+Y
	6gPe6Fev5IO/J4MXnn91avd6yhgvzor+yv2M5lhWqOpXD9cJ3aJSx+kK1iPgHnhzdSvSekG6cST
	c5gUMfartlPX9SEI32z+kPLW8JaFNLUDa7EFG9Sax+Ioc6rGnWRNVDA+C0jMF9frl4NlnlETLP2
	x2gj8sA19a17TLm8CJXOFyXwO2MhvH9XWOv89TCtoY8Xk4QYlF1J4sQGlg7bED+kvDWA2mjG22M
	+hawPLLd8NF3JJbHViuWAiidQAiG3dd8oJDFdfdjl8KiV54IFfpBge48zYm3SJSX+5FUW3vmeeM
	=
X-Google-Smtp-Source: AGHT+IGyp/xTGp5oc1Flc0suMmUx+z84Pn68KeWyBolHGZeBeRUJhIRXZcDbZoi8bBEnqcyDMtHfRg==
X-Received: by 2002:a05:600c:470c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-4533caf534cmr134483935e9.8.1750167428760;
        Tue, 17 Jun 2025 06:37:08 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm179494365e9.1.2025.06.17.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:37:08 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 0/4] selftests: cgroup: Add support for named v1 hierarchies in test_core
Date: Tue, 17 Jun 2025 15:36:52 +0200
Message-ID: <20250617133701.400095-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This comes useful when using selftests from mainline on older
kernels/setups that still rely on cgroup v1 while maintains single
variant of selftests.
The core tests that rely on v2 specific features are skipped, the
remaining ones are adjusted to work with a v1 hierarchy.

The expected output on v1 system:
    ok 1 # SKIP test_cgcore_internal_process_constraint
    ok 2 # SKIP test_cgcore_top_down_constraint_enable
    ok 3 # SKIP test_cgcore_top_down_constraint_disable
    ok 4 # SKIP test_cgcore_no_internal_process_constraint_on_threads
    ok 5 # SKIP test_cgcore_parent_becomes_threaded
    ok 6 # SKIP test_cgcore_invalid_domain
    ok 7 # SKIP test_cgcore_populated
    ok 8 test_cgcore_proc_migration
    ok 9 test_cgcore_thread_migration
    ok 10 test_cgcore_destroy
    ok 11 test_cgcore_lesser_euid_open
    ok 12 # SKIP test_cgcore_lesser_ns_open

Michal Koutný (4):
  selftests: cgroup_util: Add helpers for testing named v1 hierarchies
  selftests: cgroup: Add support for named v1 hierarchies in test_core
  selftests: cgroup: Optionally set up v1 environment
  selftests: cgroup: Fix compilation on pre-cgroupns kernels

 .../selftests/cgroup/lib/cgroup_util.c        |  4 +-
 .../cgroup/lib/include/cgroup_util.h          |  5 ++
 tools/testing/selftests/cgroup/test_core.c    | 84 ++++++++++++++++---
 3 files changed, 82 insertions(+), 11 deletions(-)


base-commit: 9afe652958c3ee88f24df1e4a97f298afce89407
-- 
2.49.0


