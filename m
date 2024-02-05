Return-Path: <linux-kselftest+bounces-4162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB5B84A996
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3FB220AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A51EB3B;
	Mon,  5 Feb 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy94LXHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DC1DA4F;
	Mon,  5 Feb 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173772; cv=none; b=KwPD6+CBFlrd7x77EECxF7HAQbOBEI0YidLW2LDtYszAgMxqOQHz2yHoqHYNFbWxL1uMKjS+DDQgt/sHaEeJtNFRZsPL3zgDT2+TpvmVWV3KWEb3KZxywil9YIwivK+Aw85FcY2qDm1+XiOZaQbfo0nPP3pN7mUhrIrl9EiKnk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173772; c=relaxed/simple;
	bh=cVSB2Axlocc54DEhrkoIJ/p7tDjCzcZXwIbB+OQi5cU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggAxilAWrGlxw7un9XakWlQFgGZtadYItMFrq5Kcss6nQIqZnXJEu98nfIUPAGgQXbxyYKYIE1kOdgmXkpfGWvGcZtI4scLnQ8oYfbzCvjQvPPqj4t6oveMifZqIaacfbLmFNmyZQzf6QVGsl956Qwvo2y7bebByycNeXOVZLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy94LXHD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783d4b3ad96so317729785a.3;
        Mon, 05 Feb 2024 14:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707173769; x=1707778569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGdyPa7Pf/Y7EOUem+E2iwIgjOxOpmm5HyY7qygEzks=;
        b=Yy94LXHDNDh377q1S31UE8UPlqhySVt5gsmMQAFmyzGZMk9BpctS0K8Mvav/2OkiRu
         3wVIAXEoAXGsL3kbYRnzl8dH18P2Sd6shdJ/1P0aNstoYZvAcQjAP14s5A08MPM+b3au
         pBrJN/jGYBDhswo9+d6lRuuMW5OO1kcQR8w6pnCf0n1RkQrDk93Qqi1tgPnS16Oe0eM2
         RrG4aTL8cRFS/gfxUVD3z6CHDvuV6evj1VhfZtojmH16bFHBRQifdDYGORAMCvOpBiZt
         OBBqg+3CSYnF+wwCq8smI3SokMkvzhhswi9EC4BN70QPkabqmYs5uE0jd7UtlSh2nC0d
         xlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173769; x=1707778569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGdyPa7Pf/Y7EOUem+E2iwIgjOxOpmm5HyY7qygEzks=;
        b=B1uFAN6IGFu6/iEWqyWkZQy67kNNgQs8J6DyU1P1ss/tbz50szK4UO3z/qbm1QScOP
         lQXgZWYkIFJIU+sDIvUENO9ySrJI86g8mm+HQIBrwPFwnrARPY2PAWCS7UKdJ5yZuuho
         iM+4+NX+VpQXYP8gqrf9GjuF/wPVxQIwjLo/gMa31ceUHALJaoBdlRf8z96YDqdcfreR
         2liAfbHymrnmZCHVgtQuRJnzD4j5m2UgdJ8VxUo5EMs83mwfUoQGDO5iFm6zn+C/xVLo
         XxCIjY43n6HR8eJr3olMuvaVdaOCOkFSZ5D7lMrCEgksm2DDExrCxWiw4hJlQVuIFQlQ
         /RHw==
X-Gm-Message-State: AOJu0Yyd73sFyEkAj9ukEDs2BzbfFvJn5mqvEpptSRNYZore4WjrltQ4
	D9FDvS2Nk+cV72z+fe8mkCjB4gvhO8ihD3vnr+NP7F9W1+lur7tr
X-Google-Smtp-Source: AGHT+IGfKgXtdhTde5jttlEus/aYY1VrLcbaT3SzAbrDsR2jr1jMh14fzNUl3l8jyMk7UlYIteSyoA==
X-Received: by 2002:a05:6214:20a8:b0:68c:9307:3021 with SMTP id 8-20020a05621420a800b0068c93073021mr995244qvd.47.1707173769636;
        Mon, 05 Feb 2024 14:56:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7v8PF1XGBVOPoV/mq8PqMOogCMRrSc680TooUNtMA8rTz/Bsl7IMunpZ1x0OfJtfBnYBMT5FPPrEzwlDkYiPJOgEwvLjmeHj+ufIsoHk3REU1CulcwJ+JHFl8sPgLs9RMcQB9bwrMLy+OH4Ao5nNoinytQ84nQa8zQyDVp9JFjeVnXA5OrTlgVz9lP3etUHSgsDOSonjCLd1q74MFSgHgW36WPbWt+3exSlO2jV4GX2aWn3Y0yL0OgdsIlDeT5UTOi9uWSp2SAiNwOFSfvCelGTz8qqg8M/y82EuTI7aVHIxC+OLZPGq4XjoPt8amG4yXftmCC+vHaIJExAFnUh8I7ZxoWpBJp+jWpcDNWGFNsP9xAHrdRopUqPcLe/AkQkO70XUw/NuJxxhNTE6i5CQ=
Received: from localhost (fwdproxy-nao-006.fbsv.net. [2a03:2880:23ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ez4-20020ad45904000000b0068ca41d6c26sm421459qvb.78.2024.02.05.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:56:09 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/3] fix and extend zswap kselftests
Date: Mon,  5 Feb 2024 14:56:05 -0800
Message-Id: <20240205225608.3083251-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v3:
	* More cleanup (patch 3) (suggested by Yosry Ahmed).
	* Check swap peak in swapin test
v2:
	* Make the swapin test also checks for zswap usage (patch 3)
	  (suggested by Yosry Ahmed)
	* Some test simplifications/cleanups (patch 3)
	  (suggested by Yosry Ahmed).

Fix a broken zswap kselftest due to cgroup zswap writeback counter
renaming, and add 2 zswap kselftests, one to cover the (z)swapin case,
and another to check that no zswapping happens when the cgroup limit is
0.

Also, add the zswap kselftest file to zswap maintainer entry so that
get_maintainers script can find zswap maintainers.

Nhat Pham (3):
  selftests: zswap: add zswap selftest file to zswap maintainer entry
  selftests: fix the zswap invasive shrink test
  selftests: add zswapin and no zswap tests

 MAINTAINERS                                 |   1 +
 tools/testing/selftests/cgroup/test_zswap.c | 122 +++++++++++++++++++-
 2 files changed, 121 insertions(+), 2 deletions(-)


base-commit: 91f3daa1765ee4e0c89987dc25f72c40f07af34d
-- 
2.39.3

