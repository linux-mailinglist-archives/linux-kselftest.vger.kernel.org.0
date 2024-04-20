Return-Path: <linux-kselftest+bounces-8512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792BF8AB823
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2985A281AA1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 00:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4480438F;
	Sat, 20 Apr 2024 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OvJSIpIC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236C38B
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573327; cv=none; b=H11CkE4Yok3zzCrjYch37bYT9KIgW/XKzIv0XtIzamsLlEnn9ycFLZmiQLcTA29XwshdHbfT4cPBi8vK0Z8JOf5pvl/BnuX/Az6Ezfx9GB1H9GIQowYsDjTADS4leJ6pPRt1AKVwfBzTbHCv22/1q0AYOOweROGIszAY5StDd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573327; c=relaxed/simple;
	bh=kNF7HKbcDJf0j+iv3yljA4si1tFmlJxBZsU7/8MLiGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pon/Xh5TLis8A03HQnSUIPUk/RwLlVNKaW7u1GUIfHOkq8XUjxjmwOPoYBWRyTI/DwLUROLzGvZvn+QDB0CNtwR42KdtRwvOiZOslfO0Yvr/clQRIbpxCsudw/HIeO4HQLnrehgFzfI35MaFXvWB5hJbfbYQD8Z13iXnRViNWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OvJSIpIC; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c74ff209f6so256153b6e.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 17:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713573325; x=1714178125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noCnaAnzyDbcht2bNXEE+ldm8aZtpjdLO6F8pTBCyBQ=;
        b=OvJSIpICFGRfNc5YqcwhbWLtK0aH60yI4CLSDmtvL6TCAlfV63Wdrl/UdbSEj1HFHv
         6JX9wMpWgIa2jVMbkTCC+CRSGQCmgTaRXTV2t/5fjAs2Xx9zwbhSaCsjOKVyhVZXftjF
         ++XkB49/wFn42ghZ46E+DWpQyGH6JrU5xgPkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713573325; x=1714178125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noCnaAnzyDbcht2bNXEE+ldm8aZtpjdLO6F8pTBCyBQ=;
        b=nlbJY2hfAEd0vaTr6awaoJPkQJ57l5lrTtvapOvufmw7hJF5SfOVO2DFw+QUFBJYZX
         jlmvyZHwTwO1Gg/Oz9HC9qJ4KWijPuUtjJJUoV0OOljagEnecjYP3ZD5Vsu7vxtlpqcJ
         Bb4XzHfAqDad/G5SkqSJS3DkekGO3soJCVhVNr0HIFN7QJMwWTj3qJka8Wt2R+qemBs3
         PLKVNcHtKjR6q7G2com2KBYktEpRs5h+EZ7VvLjQi3LgN5tBFFKwIqV8N0wY69P15XMR
         eIHbXzw/6HEan6LvEhsBDXDoy08rBKECkXUxpmTfMEUWXvuJo030YKMAOdRmXVjFGr83
         EIoA==
X-Forwarded-Encrypted: i=1; AJvYcCWQJ7LVopcPyGaGX3/QQjiS9GrQj1o4xOkWikAn5YRqSPcat9/0e9JQsWP16uJUKBGkODk3ir1PAOL0AlQJlEbL5R1gincvQxGYnNkqjOwN
X-Gm-Message-State: AOJu0Yx28k1v3JEHVr197Ez6qO8hsP9TuLLyjAbc0YQ90jQP6LhkCKba
	DUjnJIGu8akYPjiuuq7mCWKmHOmWpkW2RmYmmYBgq+x4rqIBwUAvmCtTDjBCmg==
X-Google-Smtp-Source: AGHT+IEDOQFdh1cQ1gCCVBQVHj81Q6el9P//jEc90A1vMSnDAhavxBBoAu8NQqzZtzkKxbyMGTslLQ==
X-Received: by 2002:a05:6808:4387:b0:3c7:4e26:f1cf with SMTP id dz7-20020a056808438700b003c74e26f1cfmr2132461oib.17.1713573324884;
        Fri, 19 Apr 2024 17:35:24 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id x19-20020a634853000000b005dc5129ba9dsm3725613pgk.72.2024.04.19.17.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 17:35:24 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	pedro.falcato@gmail.com,
	usama.anjum@collabora.com
Cc: jeffxu@google.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] selftest mm/mseal compile warning
Date: Sat, 20 Apr 2024 00:35:14 +0000
Message-ID: <20240420003515.345982-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

fix compile warning reported by test robot [1]

Please apply on top of patch titled:
"selftest mm/mseal: style change"
(which already in mm-unstable)

[1] https://lore.kernel.org/all/202404190226.OfJOewV8-lkp@intel.com/

History:
V2: fix as suggested by Pedro Falcato

v1:
https://lore.kernel.org/linux-mm/20240419034350.127838-2-jeffxu@chromium.org/T/
	
Thanks!
-Jeff

Jeff Xu (1):
  selftest mm/mseal: fix compile warning

 tools/testing/selftests/mm/mseal_test.c | 3 +--
 tools/testing/selftests/mm/seal_elf.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


