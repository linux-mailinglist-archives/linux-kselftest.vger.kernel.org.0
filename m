Return-Path: <linux-kselftest+bounces-34287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FD7ACD997
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1AD16FAAE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DD288CAA;
	Wed,  4 Jun 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7XVgHF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4824503B
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025322; cv=none; b=bsz+EXdBUimh3CrAKpbZUvk6pzbl+oJRuguqU44F7mQCB4QD7Yk2/aeeny1EIvVNSZjMS/1GluXmYsPEDWIHfLjgzebZAtNeORtMOZW0Fxp19Dza0ZgC9Rn+cl38cTAGedmoKPzTrLiy7HCDcjsot/xM8w1XxG6o3dumviZpmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025322; c=relaxed/simple;
	bh=IGXzs+S5NkzhTxjCd7UEIuWp3voVZPTKtZnGQtboBJo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=h8RZc2k5vAEcK84eF8D2e5BuxRcl1yTXNoco4kPS3XCXAfnCxnv0uojyKwx7w9wpGMP5JlcU9AezrZ/M/lts2LrerN04Q2rWVO+igJn5c/FGBDCtPnn6NvtxI1JhestdJqK2i4ChscAIuEZ8qXlcENgoz3Fkrc6dik9k4R+04I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7XVgHF9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso2548455a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749025319; x=1749630119; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIbd83p7XUFk1nIUFG1NDnXEafOj80GqhwMEQ6R7KE0=;
        b=K7XVgHF9cjSdNJQt+yFlkh8vMs6lCXJ46PI6FAth7sr6FyYirh+lVe2V0KLwiraNvR
         v+gqw5HVIVRsdb6wwuE97GvBztBVZ1p9F9HFy3nyz+5FSrd6D2TSQLtj+1vAg9coBpEg
         9iDYX/0CtAuC9yihmOhXLGnWkoo3EyGJbz0HKjiBDFufIREsumnCocDVh6xrw/b/4yZd
         N6+1mCkWdt1c1IgmsQzaf1IP7UfTdVjJ+1BW6wjzkXFRsRiFnheMlBlIT8WfOZ6FcZM6
         nWiywI/tVW9bU+le8rs+YEoY3+5lPSHf6Ql1KNC09uzMNSGlzA3dBqSdZ+QUQGPgLBVt
         8AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025319; x=1749630119;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIbd83p7XUFk1nIUFG1NDnXEafOj80GqhwMEQ6R7KE0=;
        b=S/DpyCJ64UwK+qsFskDXUfY5FWWHxnsEspu/6S2+Cz/4wKpMzIsyYi7dpfUtXFYeNK
         AhfeaFtWIrqDPxVvLrBVsNDg7IRyzti10ynVDceQZfQa+xMKfiBPkOoS9dgFD3RMjUkS
         EA0JVJ49HUxbzPBTa6WPBJF9/ng+cI0NRE5GOy3aLx2kCVkstmKELZEVvmR1TJK1Vura
         VCOslTIDyLamhmXfBbpwHWbZvHQn/bg8lkM1QihVLa4KeglE+uNFERO1SyURSyglhYSb
         Hzb5fS/bns433aZ5LZfDW2ssaUQMpUjK11oRNsnaUJCctII2J/TymvUKgDibLWLbyRgb
         KFfg==
X-Forwarded-Encrypted: i=1; AJvYcCV5kC+K1GO0agp/VFStaTWuvyYayQ8piJI9vJ85kmdcFMURB/fgDI+U2ypp5XqzsoSA+Npr591Q0wXDrIMaa58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOaJGjjPgb0bnYVKDpTbUw/y1l/+zN5gWHY/x2/bnjgFRoe+6
	DwQuL2kWI2E43mQIySzLPOv73el0CN1/GltlOvT11N4RVrvoYhQHG6T/5gE+HFjM
X-Gm-Gg: ASbGnct9MzGV0spNMkzTAE8ntNBFf2xx4sIIZhWXO5pvzQ+xY72/Y+MWaFyEgetam5p
	pgOPucCeE0G5lVIJjS8VMQLjWoVAIS+sNC/zdgpOr3dCJ6aip7qxKeb0dSrSRtU90q2a+YVpbxh
	KeFsa+h7ncBrj6Fq9hIT2Fgxxt9t4hgNe1+fLIT9P5jpO68TuyJRe03pcAtCTO925lhEgdTA5wz
	NR4tqUWCp120cQaFs6UwMute/HbSD3oHu4lWtD8g0DU//bBKSpUjkyfDMPLuPp6zu+97s0iZEXu
	OKi5d85IBG0DIMDBvByaYB5KhOJKk/cVVT/zD/HlnqFJf3v+kzeG3qWECiTlBA==
X-Google-Smtp-Source: AGHT+IFjY69ZgP3ucPvqNFgnViZIHn36gJ0JSTO8M8OHEh+t1p17nS9SaCTWn4dRKk+/kx2U2PRgyA==
X-Received: by 2002:a17:907:6d02:b0:ad5:2328:e39b with SMTP id a640c23a62f3a-addf8ed687amr161560166b.31.1749025318686;
        Wed, 04 Jun 2025 01:21:58 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d84f389sm1053537566b.82.2025.06.04.01.21.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jun 2025 01:21:58 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [RFC Patch 0/2] selftests/mm: assert rmap behave as expected
Date: Wed,  4 Jun 2025 08:21:43 +0000
Message-Id: <20250604082145.13800-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

As David suggested, currently we don't have a high level test case to
verify the behavior of rmap. This patch set introduce the verification 
on rmap by migration.

Patch 1 is a preparation to move ksm related operation into vm_util.
Patch 2 is the new test case.

Currently it covers following four scenarios:

  * anonymous page
  * shmem page
  * pagecache page
  * ksm page

Wei Yang (2):
  selftests/mm: put general ksm operation into vm_util
  selftests/mm: assert rmap behave as expected

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 .../selftests/mm/ksm_functional_tests.c       |  76 +--
 tools/testing/selftests/mm/rmap.c             | 466 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 tools/testing/selftests/mm/vm_util.c          |  71 +++
 tools/testing/selftests/mm/vm_util.h          |   7 +
 8 files changed, 563 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/mm/rmap.c

-- 
2.34.1


