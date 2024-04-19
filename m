Return-Path: <linux-kselftest+bounces-8391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6288AA753
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 05:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2E21C20BC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8D5664;
	Fri, 19 Apr 2024 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="itj99syu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26F6C127
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498257; cv=none; b=bq48sUa64avwB0iiZgS/GQzWcHg3R+pbIhCyjEwfeq1juUBaKl2eP4lCb0xbvi/jKN+NwNDx1CgooQYFca6Ar/t7/itvDfuh8KnHFCg2qFdxdpwXQnnGgt1jgOew3UspTtkfyxzJ1YXM3MR/4txna1Lkb7BzoBJ+8DhNFBQyx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498257; c=relaxed/simple;
	bh=LEYqE0qd071c9CuFgM81rB1fNi6CsdV4Et4J3doB3/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vm9ymImB1Ip0Jtkp3nh5QkmMms/kUxlx/fb180Ab5zpbaQoi/9TPcPKDHu2B9pgUDfw3yin99eB1J5bvDJwTZmIiEl0koHqg21BpPc+wAb936WiqeqU4p7vH/m0PrMFIVIE7Lwt5UNkjNQJpbDhEydC+628A2aCxbwpe6p9nT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=itj99syu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso12611345ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 20:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713498255; x=1714103055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3dPORF8japLtcUmYKjlJBINfdM6kZOPj2xLkwxviP4=;
        b=itj99syuyq+j+lk35u656e4u0cbk3vsg7o05xgp8bBX/7vNNmHZQgWN2btq33i6mM1
         0ghCcwzZtPbPt418tfUub5kaDA8E48DrNgZrkx+MPk/Q5ITtW1aj6ldgKG+RLZF+ZWDe
         S6BwhNitVyiXBWv3NhFTCFbirvr3vPuq/GnXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713498255; x=1714103055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3dPORF8japLtcUmYKjlJBINfdM6kZOPj2xLkwxviP4=;
        b=Waf3fr0sa2V44Z/zMwFi9MMNIxpiZvKa3vh3z6VYzPWngdmcc9OUai3vZjwZzkmaJm
         KVNmWyUrKe2wJ6Ouu86ZKH6xokvUi5WJxkPW2A50Z4vIu29PvhdJI8vly7xFhZ5W5QpF
         tNBn9umLq5pIvwAkcsSDDVnxohx7ue0vSQHLKnn/RfoDRQUnARTEWHJBCdh24Y2brA2D
         qYZEzfoOgcoDMqD9gU9Zl7lrzYTEMjY+/CEW3TWDOeUP04U3VBzjXV1Yu9UkMr21tTvb
         mw1DTQecNJlsM/yOwcpPCSLJnvKGxUIcqQfMD8JlE7CW09IfLR1wg4tywKTUZELHJhSN
         tNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMW/UrMuYJpQ0NY02hj8oLHWYdoGlqM2OC6UrVC0XRORTv65Wo/bED2QDlNywAeGhWtB4Skb6XoKmxzfGj1CXWF2kORMjVBVPMfqdfKpW2
X-Gm-Message-State: AOJu0YwOfUopnog8jv+2JEbqcp3dpjoixrkAYWDASl3RTiRHPdbzDHWI
	y/krBZXoSTQWznvv5Jodr5B4uBDDDsZ9xAZmoCl7nFbBSEFQ9zltSYyOUCGzjA==
X-Google-Smtp-Source: AGHT+IFAPX7JOoA58NK+Y2Bi0sFgLBEYjwtVBphY7PadAL/7xMv18yC5JU1x1nMqOCgthh6EoaRSnw==
X-Received: by 2002:a17:902:74c4:b0:1e2:817b:460a with SMTP id f4-20020a17090274c400b001e2817b460amr973647plt.34.1713498254977;
        Thu, 18 Apr 2024 20:44:14 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id w7-20020a1709029a8700b001e509d4d6ddsm2307248plp.1.2024.04.18.20.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 20:44:14 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: jeffxu@google.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 0/1] selftest mm/mseal compile warning
Date: Fri, 19 Apr 2024 03:43:49 +0000
Message-ID: <20240419034350.127838-1-jeffxu@chromium.org>
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

Thanks!
-Jeff


Jeff Xu (1):
  selftest mm/mseal: fix compile warning

 tools/testing/selftests/mm/mseal_test.c | 3 +--
 tools/testing/selftests/mm/seal_elf.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


