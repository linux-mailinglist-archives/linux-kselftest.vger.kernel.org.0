Return-Path: <linux-kselftest+bounces-27209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C56A3FEB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6972A189EDEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F662512D3;
	Fri, 21 Feb 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPmCopoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0341F0E36
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162350; cv=none; b=VHv/SYJmlBL+Un9bV6xkfEhpJ4p4H9AS6tn0q2SbnqG3WOd7qBtQbTEwJJHNjF/p+YfTa6jHTasJPdi2XgXYDfuI6w6egyLiwg5GOY444zjLg4yuHxIPkQCTAaE5C43nCejebBCcM/c1iT2gHmErVWAtX7H3GwYOOPD88CvfQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162350; c=relaxed/simple;
	bh=gOA4tEMs59iSopUVhBF087RBmvNaIjEsguuBZTeI76c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jsImeUBSmI18G68/03AKO0MhEgFoDEO5PXlgXb3Lx+wLHBmdKojUXs/lN7JkzLua5ylbZMkbG6655ziSZqsqqVqOq1Q3qFobA8Ir6Ta0zeBzudWtxxfwVR17nbVP1cULhzVp9t/RTyzwvvuWXbF2WZ5e7A+D08Q/bwMMYNs4Zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPmCopoi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43935e09897so17470085e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162347; x=1740767147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e5X5Z1kdyFGnbB9D3q4fSZDGH7vvQDOntsnu9alsqN0=;
        b=mPmCopoi5rPfhO7R2iVpEHPYTGyJ7OzG06+pBPKtON9adDo2GvP3tvL6fuigmoZgJN
         AqwzzPqsXEg708J9mJ8mgIvJS2TBmMGrkwfXw3tYu/Wcnf8LAQ7xOxpKg8SBO8ROvPmB
         H7zaD4ppCC0BeJ2M/Igelxm4q/y3BVGkHBmSCKVlp3MjvaaJxaw/mU9tukGq1QgomU6a
         5eDiTN79qdh3OEs+CrZQbfy7iF1QrMdAsuj2jdU/B6f9hmppv6QcoWx45gdPV8SJpgBv
         M3WZuxdrIw84t0tMWdnMFgy7WhZPQvfyqr5Kb4MAFAkoP/b+H5IpACS1nxsl5a6ytCwe
         WSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162347; x=1740767147;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5X5Z1kdyFGnbB9D3q4fSZDGH7vvQDOntsnu9alsqN0=;
        b=vzVY0BbGVMbNkg0BblSUmk04aoifKSelbcfwLq2hjgoKpd+Rwr4EY0Yg8NJxuoGQ8A
         /MbzbG21SneVo7sJe14XbG33jamiHoYVMqCvxCuKtzpZwtNCtDiFYR1H6cc04SEvOZfG
         0rnf0mSuHH6mawoOuxwCxotZreSm7CmN89RqR0rkmCj7p30zZleriH5DJC8Iimvo62/y
         3P8rFT6vttSN40QNjAyR8T6ee1DT+1/lpzSqkFX6/ESlRiG6v7HsSXeN04lZLfv5Ehpi
         6u7amjtZx4dwNtjmXa2velDzrWejQ87KyS8F9elwRVreOmGaXfk/DEdgL0ajub10hPIh
         7yJA==
X-Forwarded-Encrypted: i=1; AJvYcCUNq8nMRCZQeYpBATX7tM+nDCklEfLzRoMFdLIz8DI1KObF0UHqTl20r+1oyBK7BBZkm5EAe3pYbpEoN47bEvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJI6zCVOJAcbncI4W/31gEdCjY93fUHU7QH3IpmKonOHQhynst
	7TC8wP2TWdbh7mCnnLkqX+lAVkS1VX52WfquyaJWSdLs9iTvIG8w0PEJpsr4aCS4DK4aFGOf7JS
	Xyjbg4CPaOg==
X-Google-Smtp-Source: AGHT+IHMxs06aQFDG9IE4tzWjoOB0jTVvzlROIc1EYhAGB1AX6MoguhuHXXJWhx2mnS1XH2MxQMMi/JMSzK+5Q==
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:439:83bc:8858])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5988:0:b0:38f:4a0b:e764 with SMTP id ffacd0b85a97d-38f6e97a74amr4614068f8f.28.1740162347672;
 Fri, 21 Feb 2025 10:25:47 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:39 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACPFuGcC/3XMywqDMBCF4VeRWTclTr3QrvoexYWaSRwwRjJBW
 sR3b+q+y//A+XYQikwCj2KHSBsLhyUHXgoYp35xpNjkBtRYa0StvFdCs00kSRSa1ui6QtuPBPm yRrL8PrlXl3tiSSF+Tn0rf+sfaCuVVvdhsHVrmqpqbk8XgpvpOgYP3XEcXxgJZZ6pAAAA
X-Change-Id: 20250220-mm-selftests-2d7d0542face
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Subject: [PATCH v2 0/9] selftests/mm: Some cleanups from trying to run them
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="utf-8"

I never had much luck running mm selftests so I spent a couple of hours
digging into why.

Looks like most of the reason is missing SKIP checks, so this series is
just adding a bunch of those that I found. I did not do anything like
all of them, just the ones I spotted in gup_longterm, gup_test, mmap,
userfaultfd and memfd_secret.

It's a bit unfortunate to have to skip those tests when ftruncate()
fails, but I don't have time to dig deep enough into it to actually make
them pass - I observed these issues on both 9p and virtiofs. Probably
it requires digging into the filesystem implementation

(An alternative might just be to mount a tmpfs in the test script).

I am also seeing some failures to allocate hugetlb pages in
uffd-mp-mremap that I have not had time to fully understand, you can see
those here:

https://gist.github.com/bjackman/af74c3a6e60975e6ff0d760cba1e05d2#file-userfaultfd-log

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v2 (Thanks to Dev for the reviews):
- Improve and cleanup some error messages
- Add some extra SKIPs
- Fix misnaming of nr_cpus variable in uffd tests
- Link to v1: https://lore.kernel.org/r/20250220-mm-selftests-v1-0-9bbf57d64463@google.com

---
Brendan Jackman (9):
      selftests/mm: Report errno when things fail in gup_longterm
      selftests/mm: Fix assumption that sudo is present
      selftests/mm: Skip uffd-stress if userfaultfd not available
      selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
      selftests/mm/uffd: Rename nr_cpus -> nr_threads
      selftests/mm: Print some details when uffd-stress gets bad params
      selftests/mm: Don't fail uffd-stress if too many CPUs
      selftests/mm: Skip map_populate on weird filesystems
      selftests/mm: Skip gup_longerm tests on weird filesystems

 tools/testing/selftests/mm/gup_longterm.c    | 45 ++++++++++++++++++----------
 tools/testing/selftests/mm/map_populate.c    |  7 +++++
 tools/testing/selftests/mm/run_vmtests.sh    | 22 +++++++++++---
 tools/testing/selftests/mm/uffd-common.c     |  8 ++---
 tools/testing/selftests/mm/uffd-common.h     |  2 +-
 tools/testing/selftests/mm/uffd-stress.c     | 42 ++++++++++++++++----------
 tools/testing/selftests/mm/uffd-unit-tests.c |  2 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c  |  5 +++-
 8 files changed, 90 insertions(+), 43 deletions(-)
---
base-commit: a3daad8215143340c0870c5489e599fd059037e9
change-id: 20250220-mm-selftests-2d7d0542face

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


