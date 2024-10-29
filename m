Return-Path: <linux-kselftest+bounces-21008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAA9B5455
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 21:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC631B229F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BD8207A36;
	Tue, 29 Oct 2024 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXp6Lyc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBA20720A
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234747; cv=none; b=Klwgk+G8ZfUFSbnci+ChMqjij8fC5j5XWW0JX1qKd1jer/0Mb7Uiqbsa3Q4cAB0Tx155AlA51gmG9ou5vgguGk2Z9p9X82qBch8E+GG88ipyYTcy4A7qvtdRjj786jQMyI5IzKVXQj+KtG8QLZ7fMwJo0VlCfTbp5OboRj6PJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234747; c=relaxed/simple;
	bh=UnbV6MuNFExLfF8+2aKHw1foBqeANBQ10VftomuflNY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JC45bP50MdHpppMv87OELPd3q0d/57IAF1OCIb3NQeRGU9TdepzIB6fjvw92xIjakjs8IiSxfO9eLCDibYBkL51XRXrYLykTOB5xX5TigMQn73Wy+Kaoqh5FHLkYNWm3GrqYkeIrA2oTwDinu4/tNBXVYX3slVRUVD3vvSR3CSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXp6Lyc1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3c638cc27so109808517b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234743; x=1730839543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=oXp6Lyc1xtxCOdZXqJoUcVwbACrVZBTTAo0IlhJ3fS9JpILBnTPoaMaULhVNhqH9cc
         70ZIxLQFAKrUFDL+Z+bMLwmmdK8gkOYTpB9udVgjKevw7+/cIsMGKEkuafR6sQnTEsFA
         2b1vKo9OailTt+iPtpbGJ95o5a/j3oHaT0Acf99Eg/eW2UJLwQc+BOx4gtDA/enG3TiW
         fC9cxas7ltiEKDatmzXcIsIVjjjMmV/ZcDYwxV+X0+zixXy2KvEw3GcByK8piPWOLn+X
         cXbGaDmxQ1wznVKYUxmLidR2mmOQONM3JjZKiGWRG2GqXOVdFB1Lk1QO0EUwu0sKX0Q/
         CQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234743; x=1730839543;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=Wnea92LNpCyp5TTbS0DPAZzgmJN0+MnwGRy+3rpHwtH9eM4imbcFYBtV0++oLJTwLx
         PH3t86fpbyWLz6+68aAlx+I9NcfOKppI81JgNPfQuMm3E3HKHNrPDxqHFo6udKred8UM
         nnt7wu+Ho3wPvr0Pqbvd3szbXUn34s3RFaEuxV6YB5HxQdE6JjpbmZPg6a754VYckO+E
         vm6F0Wu6BDEBm3ZOOj9vGlamO5npGP66w1cbIZmnnavEyV5GasHOBl1C9bzfEPNDhPJs
         J4WE3SF6fZlOI4hWkFjIZQmfTAKD5BS2ZRXCQpjY3nczYzyErerwFjChLb/g73cIk/07
         D6ng==
X-Forwarded-Encrypted: i=1; AJvYcCWYJjI0/kp5qKgyKObRVC/4jUWLrbOJ3avyxZwVzxQOrNW1O/VGNQg/02kB/AtpIMMjnBponvIxNBoAfYn1yaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwOPDztuC3/tPkJHuGwC1O1X8Wq0gaTH2/MCJzEUHBD6MVGmZ
	zRXxtX5pJhmcpBFjCJMQz1K7w1cFJtW9Os78/C+gNh+H/H7GBV3WEgpbFcYcK+FNa0JiaWwnpgL
	o6lnJPrKuD65vaNP2ppI/RA==
X-Google-Smtp-Source: AGHT+IGrCicaNsIac7OAa7RKi54mxGcZhpjM7/v5kaVOQvujs4N2Ri/8i1wyq8Q6f5dhrmpQkbFHQ18QLGt8TO/39Q==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:7449:b0:6db:bd8f:2c59 with
 SMTP id 00721157ae682-6e9d8b8f13cmr5280167b3.4.1730234743615; Tue, 29 Oct
 2024 13:45:43 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/7] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A few unrelated devmem TCP fixes bundled in a series for some
convenience (if that's ok).

Patch 1-2: fix naming and provide page_pool_alloc_netmem for fragged
netmem.

Patch 3-4: fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

Patch 5-6: fix syzbot SO_DEVMEM_DONTNEED issue and add test for this
case.


Mina Almasry (6):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  netmem: add netmem_prefetch
  net: fix SO_DEVMEM_DONTNEED looping too long
  ncdevmem: add test for too many token_count

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 include/net/netmem.h                   |  7 ++++
 include/net/page_pool/helpers.h        | 50 ++++++++++++++++++--------
 include/net/page_pool/types.h          |  2 +-
 net/core/devmem.c                      |  9 +++--
 net/core/page_pool.c                   | 11 +++---
 net/core/sock.c                        | 46 ++++++++++++++----------
 tools/testing/selftests/net/ncdevmem.c | 11 ++++++
 7 files changed, 93 insertions(+), 43 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


