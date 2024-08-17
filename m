Return-Path: <linux-kselftest+bounces-15572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B795541B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCF1F22656
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3920ED;
	Sat, 17 Aug 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auhkbE1H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2407804;
	Sat, 17 Aug 2024 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853925; cv=none; b=NIu78nY1v+OFVwr3DoqKKSMv637Vo9RxsgvlLZbFFX//h+1fbyCIQKiKluXN+hHaKfyFmIH0U3x7A91osQdMZlN7XPTTSl4ZYpMBrAkxNqmD6ixw7F2l+sT6yW6vSkoWBeXk9Y7PUHZEBMgNG6A2I4iFqBPmlRoaJcNXDYhLqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853925; c=relaxed/simple;
	bh=ufE/PHJwHtozgOo80lheam97ifCZCnaNckOqvivsUgg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lLx0okb1BviNtoNTtSTmE1xJbPEJNIpvWa2tpy5mDLYoDemM1G/YB8IKsk4DK05Zcj+WWg5Qx9eL865kVmoZwhT0nMsfLkbrdVw1cS9biXhjJRq23iwIdB2/kPmnSMcKHhchFG8mFhGDp9UaxK3R9FdXQdxTsrldEF9+bIRVY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auhkbE1H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281faefea9so17592885e9.2;
        Fri, 16 Aug 2024 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853917; x=1724458717; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FURCjfhnzhcGGezKZU8awwiF5O22NwDdSRjockESBWM=;
        b=auhkbE1HqcyN5S6WNri75bU11wwrGTpKBXoN67vjNk2JvicvKwIdRt4SXPT3o9vIJQ
         dSPTHIRHUGjofbqT6FoXU1/dW80kytL0/AltDtXxh8GAvkfLIXmmMOqQ3KVKniZUIAtT
         YruYQuIBObf1Brezoibu5ClgZHBXnaQqpUBLpGAGpaO/DU0PbbFEOQKvJs5YoApM1Q+t
         urbu35DMvrjeghMq2BllGOK9Dverkopx53p9G51j5WZfU4MEndPmiKFUTxt9P1818NrO
         1Vuntqk15hVP7/fJ6SWI//kO0JQZh92lFyVT46QKu6U1zB5gEBSyBlPka+eDzaycEKAk
         jFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853917; x=1724458717;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FURCjfhnzhcGGezKZU8awwiF5O22NwDdSRjockESBWM=;
        b=F/i+nA5BdNTV5rnFifTXyosKrC6F2SSx78zEa/coAHNHNZrbVOLFmc/vRL17CVqGKQ
         fXKhOmELgpxO4BKBKsYbsB4BYEpTuU+H/8r4jLl1BEwMoNl3f8g1jzhutRRYC6lGrNBG
         FAGj2ASfia0I7Fw3S3DUcS+S63d1Iccjzsb7ohuF98AAUyiXqEKlogQsCaA8etAUcAvb
         l7D89zKmhrS6jjydf+ZUTVfldlC3MmnYakCVLwyVoVx8JKquxJpdrkSMt40fSgDXwCJZ
         6UQU8nwd/Tq4s4FUfud41yvmqZX+4FLz9VP5pu4oVSL8/MO7tSvhzWbUkU3RNb7t8C8G
         xlHA==
X-Forwarded-Encrypted: i=1; AJvYcCXJJc7aCsh6AHGNQKsp2eZ1XYR8OhFBvBRb/pBP0Tw4YauaCF1UJJSHzg+yvwKzYK/rHU9ebJ5w0lQfBh1eieFfRRnnlbn4dFjwq8MLmIHLHtvFw2Wua9slnuaivYnjG3I5H/5uQdRfRJiyMo1q
X-Gm-Message-State: AOJu0YyOrmY7rSx9RsCK/vVNXMS7M6SrssugNifvgLSCfVdTIS20pzY9
	EWkjJmhb4z5Wrnarnkf+zqNS70hTnBEC4l7g3uemm4Hwqs57OxOUt8rCjMqE
X-Google-Smtp-Source: AGHT+IFf2S4c4JqR9lrs6zCGZE0Bs81QFLoFc10b65Dvw+kBaOCfyiQAmdWl+vnO7F2nO3D1XzBcmA==
X-Received: by 2002:a05:600c:19cf:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-429ed7cc5dcmr30748785e9.24.1723853916328;
        Fri, 16 Aug 2024 17:18:36 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:35 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v3 0/7] mm: Optimize mseal checks
Date: Sat, 17 Aug 2024 01:18:27 +0100
Message-Id: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPsv2YC/x3MSwqAIBRG4a3EHSeYRlRbiQahv3WhF16ISNp70
 vAbnJNIEBlCfZEo4mLhY8+wZUFumfYZin02GW1q3VaN2gTTqjxOiPDGD1Swne9C7axxDeXujAh
 8/89hfN8PJcmTxmMAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Kees Cook <kees@kernel.org>, Pedro Falcato <pedro.falcato@gmail.com>
X-Mailer: b4 0.14.1

[based on mm-unstable, 651c8c1d7359]

Optimize mseal checks by removing the separate can_modify_mm() step, and
just doing checks on the individual vmas, when various operations are
themselves iterating through the tree. This provides a nice speedup and restores
performance parity with pre-mseal[3].

This series also depends on the powerpc series that removes arch_unmap[2]. This
series is already in mm-unstable.

will-it-scale mmap1_process[1] -t 1 results:

commit 3450fe2b574b4345e4296ccae395149e1a357fee:

min:277605 max:277605 total:277605
min:281784 max:281784 total:281784
min:277238 max:277238 total:277238
min:281761 max:281761 total:281761
min:274279 max:274279 total:274279
min:254854 max:254854 total:254854
measurement
min:269143 max:269143 total:269143
min:270454 max:270454 total:270454
min:243523 max:243523 total:243523
min:251148 max:251148 total:251148
min:209669 max:209669 total:209669
min:190426 max:190426 total:190426
min:231219 max:231219 total:231219
min:275364 max:275364 total:275364
min:266540 max:266540 total:266540
min:242572 max:242572 total:242572
min:284469 max:284469 total:284469
min:278882 max:278882 total:278882
min:283269 max:283269 total:283269
min:281204 max:281204 total:281204

After this patch set:

min:280580 max:280580 total:280580
min:290514 max:290514 total:290514
min:291006 max:291006 total:291006
min:290352 max:290352 total:290352
min:294582 max:294582 total:294582
min:293075 max:293075 total:293075
measurement
min:295613 max:295613 total:295613
min:294070 max:294070 total:294070
min:293193 max:293193 total:293193
min:291631 max:291631 total:291631
min:295278 max:295278 total:295278
min:293782 max:293782 total:293782
min:290361 max:290361 total:290361
min:294517 max:294517 total:294517
min:293750 max:293750 total:293750
min:293572 max:293572 total:293572
min:295239 max:295239 total:295239
min:292932 max:292932 total:292932
min:293319 max:293319 total:293319
min:294954 max:294954 total:294954

This was a Completely Unscientific test but seems to show there were around 5-10% gains on ops per second.

Oliver performed his own tests and showed[3] a similar ~5% gain in them.

[1]: mmap1_process does mmap and munmap in a loop. I didn't bother testing multithreading cases.
[2]: https://lore.kernel.org/all/20240807124103.85644-1-mpe@ellerman.id.au/
[3]: https://lore.kernel.org/all/ZrMMJfe9aXSWxJz6@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/all/202408041602.caa0372-oliver.sang@intel.com/

Changes in v3:
 - Moved can_modify_vma to vma.h instead of internal.h (Lorenzo)
 - Fixed a bug in munmap where we used the wrong VMA pointer
 - Added tests for the previous munmap bug
 - Moved the mremap source vma check upwards, to stop us from unmapping
   dest while the source is sealed (Liam)
Changes in v2:
 - Rebased on top of mm-unstable
 - Removed a superfluous check in mremap (Jeff Xu)

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
Pedro Falcato (7):
      mm: Move can_modify_vma to mm/vma.h
      mm/munmap: Replace can_modify_mm with can_modify_vma
      mm/mprotect: Replace can_modify_mm with can_modify_vma
      mm/mremap: Replace can_modify_mm with can_modify_vma
      mseal: Replace can_modify_mm_madv with a vma variant
      mm: Remove can_modify_mm()
      selftests/mm: add more mseal traversal tests

 mm/internal.h                           |  16 -----
 mm/madvise.c                            |  13 +---
 mm/mmap.c                               |  11 +---
 mm/mprotect.c                           |  12 +---
 mm/mremap.c                             |  32 ++-------
 mm/mseal.c                              |  55 ++--------------
 mm/vma.c                                |  19 ++++--
 mm/vma.h                                |  35 ++++++++++
 tools/testing/selftests/mm/mseal_test.c | 111 +++++++++++++++++++++++++++++++-
 9 files changed, 174 insertions(+), 130 deletions(-)
---
base-commit: 651c8c1d735983040bec4f71d0e2e690f3c0fc2d
change-id: 20240816-mseal-depessimize-f39d9f4c32c6

Best regards,
-- 
Pedro Falcato <pedro.falcato@gmail.com>


