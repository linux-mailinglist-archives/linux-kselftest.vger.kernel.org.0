Return-Path: <linux-kselftest+bounces-38135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF85B178BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3AD4E1777
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C3A257426;
	Thu, 31 Jul 2025 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDqPysBy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF38F40
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999229; cv=none; b=K+FSFlkb3CYJDg4h3ZAY4KNfaYs8j+TIaY+pi/p7hi+fimtKEdqtaVXJuGPRCUAa7qpWCCE13Gy07nW+Z4hLSirdmq+KalJK9JXDPiHBAeutl7OBDcrzwqtLjpoplUtnPe4KVnj1cYlkKgt3dv5cYrmpv1Ydw/aYXqYP0PtwxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999229; c=relaxed/simple;
	bh=x/5qNHQp3hm0H146d+Dqg3WjLwLMsNAApyRZw+PjJcU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nJSEjLNRpKvybVsucFvoffOIec+JVPjVTpdox+k4sYBkOhM76oygYzABKd77sb9wmKGTDYfWQD21tbI3YHrDUkv9LNYaSu02wYuNbpD1uUKkZLjs2v8qW6wYeAjMkBVnyqdQVr0Mu/cnGHJXxHt40rPXVwr8QhmpARue9Eh3sqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDqPysBy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-240607653f4so1754565ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753999227; x=1754604027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cCSvQKtWkk35NnkkH+OyPH5z8EOYlo24FiwE70HiXFE=;
        b=mDqPysByUqxBbzoCvBYDb+iKPn5EwtNDU7IoHsFuu98vSFg9SgiXXDILxOJZQczo1S
         Ae++vOyHsX7ly6gqghu0UJiUiBLun4t6RL6sfjHhRqSoPMpDfVDBVxlfmTHuBaSickKM
         K5AFpkrxng2GjM8fB8uH8YgGnLX0GoBFQqRGRGEBEjcj6wKttGgC8qBPiJDOwAZJVrkn
         HAUO0dT505m/58DwEtW0Oy68V+2OvkugXo53W18tzm68f0n8zTtwIhBzQCl+qu819Fjo
         mUuVwS0C5kXaHwrc6JNZqJyQyhxmUljqxNij8R2jtnMvRifsVowIYj187MJjAiO5JMcx
         w2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999227; x=1754604027;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCSvQKtWkk35NnkkH+OyPH5z8EOYlo24FiwE70HiXFE=;
        b=twEsnNVB1YqjmjJD5A56UK0L2saZQWRAwlD1wfSgVDjXKsQdG8bSOvi+4yKggpcTUH
         MThiyEpUDRd1qYehXYVxr/ISrAWRRZiQK1RLinDnsrlDMYI5IwocaULsPX+QPuTcecg8
         7U3xevXNvWwRZGFhhsOnSFaX1TVQdk4VMBo5wKp7z5B7b/epcqUR0Uxrz0R6ubRguJLq
         gjfl6uhhRC6GE6XvLwKG6aXsIlZNPFH5hnSYBfd6ODpyCQdSONXkl3wSoE/qrk4tvP5v
         smj7Ih0Z9qrFNUFJXwJyH+AXx7HgazowJ+NAbfVaeK09KkGmZPGlqYCao63Jombo8ICH
         Uy7w==
X-Forwarded-Encrypted: i=1; AJvYcCUr6lgWFklLFPYFJ8PPk6c/6iYaIUru1oXGqGEMOS8EU/tYu+dzQqUNiEfcbk8PkYf7nMmzv1yAapaEuqn0QSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9MxrvilvDKFVQD03gnCI2mqWOvE4pFji4d10UfAXsmu6/SIy
	GWuGAbhrCyt2d2H+h5efMyRy4F+HiihRtuIcFcKLJK3CphBdD1a4SJ8w6bJ2UsuZw9D2721Y5gr
	sFjKdUQ==
X-Google-Smtp-Source: AGHT+IGtegZ8YgQm2ROATdnX6in35bV2Ie8nf5pnKlyAF9NAZgIOc92HgxdoMwUjsjKWnQz4jS6av6uz+y0=
X-Received: from plkl11.prod.google.com ([2002:a17:902:d34b:b0:240:11bf:3c68])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acc:b0:240:3e40:43b0
 with SMTP id d9443c01a7336-24096be1970mr126184995ad.43.1753999227429; Thu, 31
 Jul 2025 15:00:27 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:00:21 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731220024.702621-1-surenb@google.com>
Subject: [PATCH 0/3] execute PROCMAP_QUERY ioctl under per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With /proc/pid/maps now being read under per-vma lock protection we can
reuse parts of that code to execute PROCMAP_QUERY ioctl also without
taking mmap_lock. The change is designed to reduce mmap_lock contention
and prevent PROCMAP_QUERY ioctl calls from blocking address space updates.

This patchset was split out of the original patchset [1] that introduced
per-vma lock usage for /proc/pid/maps reading. It contains PROCMAP_QUERY
tests, code refactoring patch to simplify the main change and the actual
transition to per-vma lock.

[1] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/

Suren Baghdasaryan (3):
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  fs/proc/task_mmu: factor out proc_maps_private fields used by
    PROCMAP_QUERY
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |  15 +-
 fs/proc/task_mmu.c                            | 149 ++++++++++++------
 tools/testing/selftests/proc/proc-maps-race.c |  65 ++++++++
 3 files changed, 174 insertions(+), 55 deletions(-)


base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.565.gc32cd1483b-goog


