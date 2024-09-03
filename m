Return-Path: <linux-kselftest+bounces-17068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BBC96AA4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9AD281A22
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B213DB88;
	Tue,  3 Sep 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG5DOvG5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A5126C1D;
	Tue,  3 Sep 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399477; cv=none; b=FXCALImQZ32VoCHVpzJLm6f6CAzFWKMBZSPXqYYwYr+eXR5mHoJpZm1qPdN3/OELp1lcXmYiRlE5xeMfAmLGv8x2aauWS8M0CUbfYMhXQZd7SwRlGQiEqVnOySdTlnS4ENfP2t3itNxSJdUx5kzf3qI7K2wl6VIZ71rJaEmlxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399477; c=relaxed/simple;
	bh=InThAI0FR4WvBPNu9UrkGmk6ouiadVQXAJY8jQIOXPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/cBHPKRJEWzgvB68lGOfOp6k/1QbUpQnh3GBho0jjooQCaGZyrGe8LgVI/mymMgQsMvpj0CWsGNE1z2/Za4/K4xRGERFQzxXMidIGW80iZ8WLQnEy8tiN7LF6TdABgG7+6oADjo/6W5yy+D91L6sgGARONE9Wh5CkaYx6mp2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG5DOvG5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso4236470a12.2;
        Tue, 03 Sep 2024 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725399475; x=1726004275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wx/eA5lFAXezP6/2i/EiKVm5c4nN1WqMd/n5d+yce0=;
        b=fG5DOvG5wsZVWH0XRX6pxleyaYu4JvlHt2HBMSPAKW/MCoY0EMDkH/n0Lx6NfGildc
         sTK+B6SZcAzi4hnb7gpU+b0+g0Eo5M4cUhwEHSNTIaZxY9h5QR+7kQeAX3M+9ceA97Kh
         uC6SEkumQK6Yf/cklCMZclg1KTkH47QbsLmC3XGKCBvkc1C1dD3SvBZOJhmgx8VIJ/ca
         cPirmfo9mxfK1VS3b+HRLZQQO4f/oa1rqAB/Tb0nkd0dbBiMNDRJ45fWW2NpVXlrYskf
         hamptfYNXIzBwxCPnTQzbzzqDRU/9uTo9g+5C5GoGgNDXKmoL7KUocRLhfzV1msVIUrI
         FOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399475; x=1726004275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wx/eA5lFAXezP6/2i/EiKVm5c4nN1WqMd/n5d+yce0=;
        b=dpN1tbiLuwyvYebujnoTAXQ/oDJ0vKBsmJxFBR8fGPwpLDIJRMQZ1VDW4+LJqkpvWm
         KscFccKKqgaG5xKemz7K3OaGuh2jhmeOnx+HbYO3VtxUyE14o05LpCubMNEc044d5c3L
         l6s88L57rlPRK29IlyjkqBmB8miKBEpU5dlCezHreLPhYGzI42oIdGaT/0a0PrCaLJ08
         PQJ1q1V1QGgtn9UvT8HOG/24RLJaNMuNCVFQwxZamtG8gmX1RHaQf3zlsDqMbT5U1Jw+
         RsdafkiiE+b2MAFGIhUFd3IyvQsHai7avJ5p8O79eNxwtB55QDbt7orrghD5QVSGlVlX
         wrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtuSTI1tYT8G1ZMC60UQWWKIL7WxCbTPB0l6tttSBbGrHMtql1BOarsoCCjtsTQMn4a2xLVbSd/AwOp50=@vger.kernel.org, AJvYcCXxKFgQcuCSsvjBH4ASX1SdmnUaTG5OKDDsi9xsI9RX9B3VeqHr/ak8C4YyBn5i1S9AV8TjHrkXmN6x2WCD9bS9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6zsngSaq5rLmiOnZCUCQGU/LSx8Qg5oq8+CcIAclNLYBJnJ1
	sTd9jjBSCPFhNRiLT//8qJMCeqlk5aZQ65s8WLX16VzcpXwgJOWW
X-Google-Smtp-Source: AGHT+IFTAsp7FdyX3LzIqb1DIAHRPJxdXaocbJzV/pzueeznNUEFttZfi0T7nf5SnnP7VcU7DT04TQ==
X-Received: by 2002:a17:90b:46c3:b0:2d3:bc5f:715f with SMTP id 98e67ed59e1d1-2d88d6ae5a5mr14474716a91.10.1725399475070;
        Tue, 03 Sep 2024 14:37:55 -0700 (PDT)
Received: from localhost.localdomain ([191.254.217.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8f7e2119asm3811215a91.54.2024.09.03.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:37:54 -0700 (PDT)
From: Diego Vieira <diego.daniel.professional@gmail.com>
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
Subject: [PATCH v2 0/1] Add KUnit tests for kfifo
Date: Tue,  3 Sep 2024 21:36:48 +0000
Message-Id: <20240903213649.21467-1-diego.daniel.professional@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is part of a hackathon organized by LKCAMP [1], focused on writing
tests using KUnit. We reached out a while ago asking for advice on what would
be a useful contribution [2] and ended up choosing data structures that did
not yet have tests.

This patch series depends on the patch that moves the KUnit tests on lib/
into lib/tests/ [3].

This patch adds tests for the kfifo data structure, defined in
include/linux/kfifo.h, and is inspired by the KUnit tests for the doubly
linked list in lib/tests/list-test.c (previously at lib/list-test.c) [4].

[1] https://lkcamp.dev/about/
[2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
[3] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
[4] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c

---
Changes in v2:
    - Add MODULE_DESCRIPTION()
    - Move the tests from lib/kfifo-test.c to lib/tests/kfifo_kunit.c

Diego Vieira (1):
  lib/tests/kfifo_kunit.c: add tests for the kfifo structure

 lib/Kconfig.debug       |  14 +++
 lib/tests/Makefile      |   1 +
 lib/tests/kfifo_kunit.c | 224 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 lib/tests/kfifo_kunit.c

-- 
2.34.1


