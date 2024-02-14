Return-Path: <linux-kselftest+bounces-4606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C187985409D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 01:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E01AB2A55C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF56A38C;
	Wed, 14 Feb 2024 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOL6LIxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C333D6C;
	Wed, 14 Feb 2024 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869017; cv=none; b=hUOMFzyE11+nNXxINZ6DxHIGJUDQf22AJTbNHkaF7e+W44TNgB+o2C2ho23ePjfeMgUQAob4rTlOQk9i4v/xj9n8MGFB69kcIb89EBArevJFAJ7yTirld7SO57RzRd8ZDRhr3nEqPps8k/VbSo1eU881kkIQxuiTRnm/NvIGlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869017; c=relaxed/simple;
	bh=ud6hiWlOkW4Y0z3+Rjp7RnQZGuIdyQQt0TQhTwB6A6w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MaO/72MGYEEilobnZ2A3wr4uxSOxHxhDGjQnGYLXRFzXY6ubX/BZf67f3BtI45abB26WJxLuoQhlkHWiA5aKmb309jbmNko7m+YfSluCs9Oyh0w4yUaeVQutX7F2IAlLOsDUBe/ZkcvwXseAD6jyOyYHmX0vhpkQAQHiKrjn4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOL6LIxW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a36126ee41eso674096666b.2;
        Tue, 13 Feb 2024 16:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869014; x=1708473814; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hudSvXJpKxgbOix/IzJC/qkrhU8IxJzfKB1kbMTIGcs=;
        b=iOL6LIxWBXQrFVsv5j9KD7JVR3JNTLtIRtCiI30bJB6yzbFa9+d0+LaQFmh7vyseZd
         8vVW/qZ5f3N7TD37/9M2o+kEjtz0RrDOulYZGTZlQEOVzSci8Anycn9FVAhuJtcmG1iy
         Bk04BB9Ht2+uV9NV1w9R31dgM3fDySNc1gRYkfGC5AZ8suCE0un3wjV8ZrG7/CUU2yja
         qvy4EURV00AzRt3/PtsI27GtDMf0Pr+GQChzrO6qEpzedDe0f0uL9KYahtf4b39onFWP
         GUY//lUYfxql2KSuZ5Cc9e2okR35Zs0rGF67b4VERA1khIfPzIVLROA8l+9Fff20Gx41
         ZYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869014; x=1708473814;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hudSvXJpKxgbOix/IzJC/qkrhU8IxJzfKB1kbMTIGcs=;
        b=StSzlLyp+dPZPcSIH8upQ3G+RMcCCXsvI/g8gSaXRbrjYwMHNR1w7069DWffLXO7Ca
         kwhgOpHlDjw/EN93apYzQuc4PNoHz+lGRP4FxNzpCc7/K6c5fDO25vL6cBw4jxTCH3wZ
         4v3Uj9e2sctkqlwc1x1xd2+22bX0EBEdM/7qHD2HHaAm9aGjISEo1XIDYL1swn2XvL8Q
         rrcRe8LN/LJi+ysFZ98qL3O1n7bta/pR0CW8XeviOJ24WF/kOnBGEMJXNSW2agLDgu9T
         t1OD2A1SNonJ9NZlazHhbQ7L47RECj6KxVIt+g1lcEYcn8Uun8/XEEb0SPPRGy4SGVYk
         1nCA==
X-Forwarded-Encrypted: i=1; AJvYcCWZRZyBxazRhf09kofCXiWhPYYgMdOUq418Plw/uGeiHbDjg1vvilLLPET8JFCrcLZlevkL20zSnyJtQDLvPLn21ZAn148pXjmb5fw4+Tze
X-Gm-Message-State: AOJu0YyqnkIhziUnQ9JN6WQOBYr5q5gacCSpW9b4ddVFD6xrks4aY6mE
	KusNGx+kt1UIc2UK81o4RZ72BYSP14n9E+IKcUTezEys9sLjq/8gaJknCndkSQmhEA==
X-Google-Smtp-Source: AGHT+IHkPIRHHlOVTgmconF9JHdQgzE5mLUa+O5J8ImR+juKThs2QU/hYP8dz2+L/ihcdRfU/xh2Xg==
X-Received: by 2002:a17:906:513:b0:a3d:3aee:85f5 with SMTP id j19-20020a170906051300b00a3d3aee85f5mr296850eja.75.1707869013530;
        Tue, 13 Feb 2024 16:03:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyd7/OBZpcF8C9S2bY/3xZ7DIvy+VGSlaP2M2dOxAJlN4w6Q4kHQZTNOmwO7CZtJzrxN1gU4WCUP6fMzT7ze0Ga8qQmpgsBl+Ea9Ayd0dGE+Wwxtv8g01MMnIsSOeUSFb7/gzT563Oo13POvDWJuoW8Zz2sstmDIuPdEzidys=
Received: from [127.0.1.1] (2a02-8389-41cf-e200-68a7-7041-4298-e66b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:68a7:7041:4298:e66b])
        by smtp.gmail.com with ESMTPSA id vo10-20020a170907a80a00b00a3cfd838f32sm1160901ejc.178.2024.02.13.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:03:33 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v4 0/3] selftests: add missing gitignore files and include
 generated objects
Date: Wed, 14 Feb 2024 01:03:30 +0100
Message-Id: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIDzGUC/33N0YrCMBAF0F+RPBuZmdim+uR/yCJJO20HaipJt
 +wi/XejL4qIj/fCPfeqEkfhpParq4o8S5Ix5LBdr1Tdu9CxliZnRUBbQECdeGgnTtOpk0m6MEb
 WtnFUF2BsWbLKQ+8Sax9dqPs8Db/DkMtL5Fb+Hk/Hn5x7SdMY/x/HM97brx8zatDsS/Swc42H4
 tCdnQybejyrOzfTkyCkjwRlwhYtNFyAQ1u9E+aVMB8JkwlsKyRTVhbIvxLLstwAbdm8rk8BAAA
 =
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707869012; l=1876;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=ud6hiWlOkW4Y0z3+Rjp7RnQZGuIdyQQt0TQhTwB6A6w=;
 b=CIkS03mKMQLym1bfSWkpdNIhqZ/uMbyJaIRxtGd1EBPP3ClPHeqffi0T5MR7z1GkOUQ+8iqpG
 M636jYpbsdGBayg7cwVm2j5sj4XI9VnR0j4S7C7L0KRrpO2rzHZZyt7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series aims to keep the git status clean after building the
selftests by adding some missing .gitignore files and object inclusion
in existing .gitignore files. This is one of the requirements listed in
the selftests documentation for new tests, but it is not always followed
as desired.

After adding these .gitignore files and including the generated objects,
the working tree appears clean again.

To: Shuah Khan <shuah@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v4:
- damon: remove from the series to apply it in mm separately.
- Link to v3: https://lore.kernel.org/r/20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com

Changes in v3:
- General: base on mm-unstable to avoid conflicts.
- damon: add missing Closes tag.
- Link to v2: https://lore.kernel.org/r/20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com

Changes in v2:
- Remove patch for netfilter (not relevant anymore).
- Add patch for damon (missing binary in .gitignore).
- Link to v1: https://lore.kernel.org/r/20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com

---
Javier Carrasco (3):
      selftests: uevent: add missing gitignore
      selftests: thermal: intel: power_floor: add missing gitignore
      selftests: thermal: intel: workload_hint: add missing gitignore

 tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 1 +
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 tools/testing/selftests/uevent/.gitignore                      | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
change-id: 20240101-selftest_gitignore-7da2c503766e

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


