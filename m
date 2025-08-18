Return-Path: <linux-kselftest+bounces-39210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A29CB29D2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AA9188C8B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A1D30DD00;
	Mon, 18 Aug 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2EpWRD/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7A30C366;
	Mon, 18 Aug 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507926; cv=none; b=TiUMLwdpVZTNKZId1H5HOme6M/ZcwcNFG1dELae09kOxZ15vtI2G1U6UTtCcQfDEQekuNBwOEl8wj0X12p57uii6WSf3tZxVwXwDCyOwYQYbo6p8/etdhHG6VPl/Y8xnFYGTQB8rpQ5+C3Qtzrz2ZhXdwzO9bpBiF8oV4nPVvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507926; c=relaxed/simple;
	bh=vH+tIsOMEK98p0HykoMkipvmKZKEqumwpo/6drCnjHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CA8oH5Dhpe5ZCeRb35yzd6JoLjru4j+/eaoM1EwtR2n5tSdLXkOHZvIuUQ/++8x/Ed60tQTktClI2sVHBxYq11Nfttqx0TTrfrmw9Qmo+dxfmCT4kTWD4QkMQOgxHHgn0d7pxUxSXjEz4xHhQ5SpPzl1Iw4AfQBTjgUXf1M3lfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2EpWRD/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e9455cfb9d1so616496276.0;
        Mon, 18 Aug 2025 02:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755507924; x=1756112724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0ydw29EHrtHd4WQ+E6W52DjShQ8JL8U71+1tj1yMwE=;
        b=Y2EpWRD/ibva/n4ri3JQXcnmfhip9tpVR/oY6ns0s11cBznx6qDnBZXVy9qzpAm9lK
         fiGB4x8a8cN5G4IZFUbkHYjBJ7JBO5wW+cr+ph+ciP9YZMvGHeAiUzC7c6yvBqxGnYvc
         qdc2xc/Xq82vRHLdhPx1hWZgdzxgr5fJaacFM4adQlNibuE+qhLNjGpqP+JcEZ0ukUiw
         4XznQ3YLdlvmvqAMZtkMdiKXix8lRVh6ZwhDHu6fak2MVSeyJ/kRP6GmoB9yJW60oAKe
         rlwMAZ9wc3QRdwN9Y+sWDhZIwVeabpyN5x5MLDRIjtk61yEv4ZckErsYvz35DTNAPvQo
         L8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507924; x=1756112724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0ydw29EHrtHd4WQ+E6W52DjShQ8JL8U71+1tj1yMwE=;
        b=JZJBuDj8Es5rp5DixmskJbSHdioT7J24iIBqGYO4BlPP0CBXtEXxk3C4bCQVDuxHSo
         zbmWeLvNm8JSpUKofKAiMkvOzdKuFannhhenQVxiKHvY/iPJHGQGl+t9r96H6BoTqark
         2UyII1UAGMUvU+n3YruOToGVEn1Vd5Euo9X20td1fGFllmh6LzqD0vCzdGMeijjDjtQZ
         GhPgPmO0/AGyqDd/i2ob3o/9x14wd1vwonTi9lZVT3kiBBV6xsPuGO6exS3J2AzVYAz9
         Yv7AF1In1shu0W1ei4c9jjVyF3CZ2FG5PswD5VyBCy3PLTRNMmPDhDvFAb2jEqGnD/MB
         ZDmw==
X-Forwarded-Encrypted: i=1; AJvYcCUCeVls6whjrG+CmAAxOy6JxiQgWtNPdxnDr9dvKzM4AjM+BGRDBQvjGKjMQiszq635xNF6GTe/GC9qDPzKlihF@vger.kernel.org, AJvYcCVFseWMA9cjdeGtwTHe8F7Q1l+OCseciIQDFKtIjaDdXIFTCX+fsARhajI3wja8aUi9eVQ=@vger.kernel.org, AJvYcCWQaLhuGrazYZ+CUUZRhemYKA4Fz1DzhBKotE3kiJF+lz8d2SNNiKh34yjUOrdwMidAsxt+k3cxXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkA4X00u3M58mxvwQUC2IXypal+esJoEIPq7J6CklFjIj0hwL
	4Ya39KGOuAZmDZ9Z70SUjo6BVL9vgVvHXVGb6b1NRGe1FJtJsio1gdZt
X-Gm-Gg: ASbGnct8kBKOIrMEScdll9jrlRy1Fg05qoKiol6QWWZdy/F8w/OyObhFT2ukt8a7oBz
	zHff16RU8NeLrr8xvemYXQennyldOZ+fAIPnDq+0mBAZjLPnen7yQUW1Y5olR6nyP87KE0JjFhK
	5GN+QxPOo5BCJtPF3RQeZf14seywISFAVtB7gkLmynoLKVmAmcXT1gVtbTd0L1RmLek3LbDukHI
	hFvghYnQlXT1wtarJ1P7Pyhn/A3v03XAu+x2V5GVAJwYy+kSA5Zip+vPqM3NwHHI2PcdCDBVt5K
	O6JPh0Uw4punJkBLBACbUgVbiNBys1H3JxEfKflJaZxHNUvJBXyYMLQiowjlo2rADrlRgq0Dp71
	wyONI2rcJjdg2UQ==
X-Google-Smtp-Source: AGHT+IE8XdCLUvM7SZtGOFNnnBKB7rvfuoci9wc5NNZ7BdKSqcsm7igLli0ha5lpi1X9fgU2/Doqew==
X-Received: by 2002:a05:6902:18c7:b0:e93:3ef7:bf3 with SMTP id 3f1490d57ef6-e933ef7100bmr8822310276.15.1755507923995;
        Mon, 18 Aug 2025 02:05:23 -0700 (PDT)
Received: from roronoa.. ([146.70.98.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e933264aabcsm2985389276.9.2025.08.18.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:05:23 -0700 (PDT)
From: Djalal Harouni <tixxdz@gmail.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tixxdz@opendz.org
Cc: Djalal Harouni <tixxdz@gmail.com>
Subject: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and freezing cgroups from BPF
Date: Mon, 18 Aug 2025 10:04:21 +0100
Message-ID: <20250818090424.90458-1-tixxdz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This patch series add support to write cgroup interfaces from BPF.

It is useful to freeze a cgroup hierarchy on suspicious activity for
a more thorough analysis before killing it. Planned users of this
feature are: systemd and BPF tools where the cgroup hierarchy could
be a system service, user session, k8s pod or a container.

The writing happens via kernfs nodes and the cgroup must be on the
default hierarchy. It implements the requests and feedback from v1 [1]
where now we use a unified path for cgroup user space and BPF writing.

So I want to validate that this is the right approach first.

Todo:
* Limit size of data to be written.
* Further tests.
* Add cgroup kill support.


# RFC v1 -> v2

* Implemented Alexei and Tejun requests [1].
* Unified path where user space or BPF writing end up taking directly
  a kernfs_node with an example on the "cgroup.freeze" interface.

[1] https://lore.kernel.org/bpf/20240327225334.58474-1-tixxdz@gmail.com/


Djalal Harouni (3):
      kernfs: cgroup: support writing cgroup interfaces from a kernfs node
      bpf: cgroup: Add BPF Kfunc to write cgroup interfaces
      selftests/bpf: add selftest for bpf_cgroup_write_interface

 include/linux/cgroup.h                                      |   3 ++
 kernel/bpf/helpers.c                                        |  45 +++++
 kernel/cgroup/cgroup.c                                      | 102 +++++++
 tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c | 172 ++++++++++++
 tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c | 155 ++++++++++
 5 files changed, 471 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c

-- 
2.34.1


