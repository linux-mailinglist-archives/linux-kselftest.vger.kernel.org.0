Return-Path: <linux-kselftest+bounces-21014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F66A9B5480
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 21:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF7B21B00
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99D20897A;
	Tue, 29 Oct 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWGMu7nG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0331520823D
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235330; cv=none; b=QqXmxLB4xBREisOOn23aTzZNoVj1emgyemSmBIUDw9vCWLLE5WnQsId2QP+y6Qj4CyugvYZUW1hIwcgpLLJGViwlQopQ/SNGW2m/VbV9yIk9u1qiBxYNZU7xJOAjfJNmCQQStSFQSet9reHI3fwlPF4I16FUzBiQCn/l6BMQBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235330; c=relaxed/simple;
	bh=UnbV6MuNFExLfF8+2aKHw1foBqeANBQ10VftomuflNY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IOKVYCMso0ANCSpYQJ/BgqidiJKXOGPau7DdEh4acNcQFLIHripSGcZodKhctppCur6dYj5K7peW3kAlcf1nsfDEXfnYqBc2wV7XHTIfin8fY5tjVlfnKXhoaB9zikZS3AgZdp9eb2rkrBwiCqWK5kTC4AC2DoQp8DO9XMuffeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWGMu7nG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370d76c15so114703387b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730235328; x=1730840128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=zWGMu7nGrUOogZZ/lb4mNSun6MEFISABT+LPCGwJnh3VmIXEDPSUcPBCpudhYfef7T
         w9+cWd4cfeYqsuEcqbcSnqkukHMSL7o2CPnHdWA+Fd+eGxG+NftB+nCyAc+05NUX6bTN
         vZhMcBuGdH7q8EYaTMhX5tKyAequroK+ID58w4gBi0fndiNdmZYMZEIKniw5JOHDdY75
         6oQXSQ5Agdg363fqC0fdjziaHsHP5siYzw+UHsezcJioZOeajugph5aQZo7r1jhDnHKW
         2qvhZMp7t6LMiiKmE/ubIvhyLLtkD4+Q/EUeb6Nd79m69k3rI2I1ijyxytzTas7bs9BW
         iBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235328; x=1730840128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=Mz+dwR8oqyRdMvO5ScJQ+IgArZF3dzDV4YQkJ6WmSWluZoku6NQ03P1khflCGIZ8lF
         a+0JCq5p9SAsPTsaCAhebF7A0OG5HK+8sH+CY36yqHiJjmspcmDLsAUqYvAqWpOebK7I
         rYrtzpYse9dwQbGzixz9YkvVwaTDsHRtWHjO0PSIKVSIUpYd6GK/g6ylbOPwEKTcX0IC
         pMr2uExJl1/0PeaLKT0rZxweZ/+2mJOnb6b1p/oNJqqsyWquUyeMhfVV3VfjgYshnRik
         GfaJTPALsUAewbf4b+Bv7crgby0XqNVWRkS3/npEcPlkzQcGh5eP5LIApZ7CpaYgXvsv
         oXpA==
X-Forwarded-Encrypted: i=1; AJvYcCXC/eyBB0hi3PbcmYygWCsqO3bCNFS9G0PeyElKCSy5esiap4b6PeGFaXZTWTMdTi2+9+/kfuKUWD4LKv5hX0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkhbWhk+kJPfGoUtcr7HJh6xEF+6PflTSN9DjWChy00NKEjpv
	g3aphWt7CaEAiSqj6J2+Zfj+J4y34jF6rvUa5ih92QMFE9F/S12Ld234wXoULr7B9fZ6Z9iziOD
	So8wNgAFmJREMBRTyDdkmWQ==
X-Google-Smtp-Source: AGHT+IGMfp/9F/7aUtKW5hZyYZvd/DuF+kw8AKC0A40gzCalNS+sh1n16Gs4wTxRQv6s5eZbUKL1UJCRgHCh/HWnXg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:ea48:0:b0:e30:d37d:2792 with SMTP
 id 3f1490d57ef6-e30d37d2919mr5935276.0.1730235327817; Tue, 29 Oct 2024
 13:55:27 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:55:20 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029205524.1306364-1-almasrymina@google.com>
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


