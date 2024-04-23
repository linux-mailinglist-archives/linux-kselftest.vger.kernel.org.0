Return-Path: <linux-kselftest+bounces-8725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D68AF74D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C6E1F24853
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1613FD7D;
	Tue, 23 Apr 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gpV1IuAE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32C13D884
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900513; cv=none; b=U+fkeMStilB0P9drGuL6E8CUilOkDLrkWRklr3ZwO9F+q7zI9LwzpGguBF12Fuftc8tPmbUcve4fyEMN7dCGCocNils8moAAOwp+bjOWgkLZE3nlFVFRwydO44/3aeSIzNKS+dfuqNRet3QCdAetbsz0IYCBEw4YqkCIR8haIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900513; c=relaxed/simple;
	bh=ioDp2zvravNrsh/E9O7tBaulM8yrXPk0EyfmhqkCrFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8vTn3SsevhaxK7V5ze02+ilK+xPeYd5GrP1Z9uCXp9BTKYmUNP/OLi+noHJmn+kUNbSV4QCzKcDW1TVT+tQcghN+Dn9Om8EFwoJff1JNYkTu7qwbhJ+Q68iGRiejHY0KjFCzoAZ7JN908FIPH9LGXc/WPhLWPz9o8l181I6sJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gpV1IuAE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so53802315ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713900510; x=1714505310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INEaC4vRYJbuCJSHXmVmjM1IzdorHSDwN4KG1bY/7BU=;
        b=gpV1IuAEVzF5ES2P+hm2Ri4Qpwn0QUZjRdsHl1936Ky7hG62vkPF8LJTqFl0mtqs+K
         dLIemQLRETLtInSSmwypDaTRr/zRcnrw4ezcXr8GbTuPv75Tpey+A+LKZCgDwXVplzib
         BtzflTZQ7YXxgC2fi1q98dpLlhVoStokMv+gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900510; x=1714505310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INEaC4vRYJbuCJSHXmVmjM1IzdorHSDwN4KG1bY/7BU=;
        b=MA4XbM+oJqswJr6+fs8/ciIlUselgT1hGqgJqRmbm6TwCkaXPlaZRhbHY3Z3rB1WQ/
         pcg3lij78wRrdPpPSefojtShasP71dvRjQomp7TIUf+4w6rVXmIBBIL6XwgnBxiCddFL
         9ZbmPHFGsY4I328tKDd06iYrlfgE4oLrW3xnptPdeGjP6cbZoqhXmqzI22PwUuMoUzjX
         rApVfDkGyDUze4SKQDKxt52/bdl8oV1YYkkw1014Y6bafB0xnBeY/OlC+U853ah/A8xR
         EQFsifvZZ6scxc/PiisMAJtDiNtN4g+vHr5DLYqzvfmKVbO9mZ70e2iSDpGac+68Fii8
         1mSw==
X-Forwarded-Encrypted: i=1; AJvYcCXBgz7G2iEaRkB1LyK4RiKbL0oYJFlXzlgyFlbUB33HpO6mv2TARu4ROSvctQ8hg5Zew8XQIaASBWby4kQ0NtIBKgRQeYq7645vppWJPWGc
X-Gm-Message-State: AOJu0YynPbX/S0upqDeuNQM4lh5w1dc5jeoD7HC4CiDNzR2vmcJgYIYt
	xUj6ri6Y/iWNK/+sLJHvCRBsA3m+JsVGIygAXu/hTIE/Tr1hfOZt/NhWH7BpeQ==
X-Google-Smtp-Source: AGHT+IEkE3aR6EiB4AJEjVJJ8sF6fQHY6EOemKKBgKAsbSrWePAwJS1gaw+g+V8bS3l1Sz65QGVH+A==
X-Received: by 2002:a17:902:bb83:b0:1e6:34f9:f766 with SMTP id m3-20020a170902bb8300b001e634f9f766mr451932pls.57.1713900510547;
        Tue, 23 Apr 2024 12:28:30 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id bf6-20020a170902b90600b001e86e5dcb81sm10357738plb.283.2024.04.23.12.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 12:28:30 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	pedro.falcato@gmail.com
Cc: jeffxu@google.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 0/1] branch prediction hint
Date: Tue, 23 Apr 2024 19:28:24 +0000
Message-ID: <20240423192825.1273679-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is followup patch on discussion happened during mseal v10 discussion [1]

Add branch perdiction hint to mseal code.

Please apply on top of mseal v10 patch
(which already in mm-unstable)


[1]
https://lore.kernel.org/lkml/CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com/T/#m20917ddbc4f817ebeb99276108b1f3ceffacb5c1

Thanks!
-Jeff

Jeff Xu (1):
  mseal: Add branch prediction hint.

 mm/madvise.c  | 2 +-
 mm/mmap.c     | 4 ++--
 mm/mprotect.c | 2 +-
 mm/mremap.c   | 4 ++--
 mm/mseal.c    | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


