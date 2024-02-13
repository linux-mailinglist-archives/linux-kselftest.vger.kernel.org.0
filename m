Return-Path: <linux-kselftest+bounces-4599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188CE853F0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 23:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826F31F211F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 22:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDDC627EE;
	Tue, 13 Feb 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhQGk2fL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E062A0F;
	Tue, 13 Feb 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864418; cv=none; b=Jgd3bQwjd1ECNJ1qgIGD4wnSiJv3unZC0wTmnfUwqR88eTIJVxkdKjREcxkfeGGDopuc3lSpbeM9g5pPgBcABy8LpfmSpsuc7JA3dDy1RHNx24HAXTqVSGYlRWr5xnpWRapozkHWhR2HZscSv3aWT615eKh8Hyc4F2Opecug9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864418; c=relaxed/simple;
	bh=NWymtgigjzoqDAPLAUI5PGd5uNPIj+sUwjpbAWET0BQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OuMRA+CJMrvG0RmBn9HmZyCJScclrpTKotsOfeUCVnglwenSyIDw8Bn+y0tzauz7Oyri+C2K8ylM6TjRttYJQeBCIK7XjZ68uMZ0D9TsWl4sWDQH+tLDnI2wS7d7zZj8KJPaRa8RzURaQVO0uqVKj4JOpBwjOCq7kvkkZKEAWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhQGk2fL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51165a488baso6460482e87.2;
        Tue, 13 Feb 2024 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864414; x=1708469214; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwLLOmE70wcyVhCXpJbxp7NNDK3hurRDw/SPkFr+jms=;
        b=HhQGk2fLzntY/mzsjdwPJJDqcPlt5sWf999yQm+WUV97xwBKJCwxz66Ryga2Nfs4Rb
         XEI71gQP9ues8ANNiq5qy/g2iYvmH3fiD+O8QY0EUbwDPPhlljthG9hc8Cipw64BwbdG
         zxy7CWjMvwKYkbKrcKx7E0wSJqThIy/X0RY2JMjDeEzG4CWk9vgn9SpZfrYMqZntFkrE
         /stTsUykrVl24RkK7wbZ2dW/P/88g8uQMrCHTiq02zQJwIqia+btHfK27zMeYCf88roi
         zsr1Zzt3V3VX96sY9eJvOu9Qu55hzZu/vccDnpct8HbUgJDZrWeS0BBb30erEmyJq/pM
         MAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864414; x=1708469214;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwLLOmE70wcyVhCXpJbxp7NNDK3hurRDw/SPkFr+jms=;
        b=r9rPVWuIkbNqmAVC3LtpMHRSYapRtV/WsHZVFFQ6xfulM+r5dDEEz+L5NPdVBEMR9l
         jx3jlkEk0XagPmz5XNtHspPS9pf7Y3K6llVPyY1juNWpEbR/3Na9wHSwMVxbKh/OvIoO
         aPgg3DKt45NG7WWMCN/UEqoXei+WATq89fqnweUY7EJRwDx8ED5Pfaje1btZIM0+3FoK
         fWK4quw0Hd3rQmZGNysHlBS7yCoFu7pf9scR9zjIQafwgGcvEG5hq5x2fdE6/hMqgF+D
         RY6C0pZNm13MlOQujyNqN0223rK4fRX3JmYEFUc/2mrq6sQiGsM1vqoDZKoMaJ7HbWI9
         6D/w==
X-Forwarded-Encrypted: i=1; AJvYcCWEKVLuIU4KKbyrTeG4RmP0Dm2zKPTnPh7DP5lQnrKnYDVAHP6yq2nZ5m9RNaERPcQrVEnOkiH2JMwlzNx1sdhg2vDsa5AxLNraqWwLjsRa
X-Gm-Message-State: AOJu0Yw3a2ibfpoMXEnNaF7L4dpXTGK6m7m1GKF0Dxm17xEXusweO7GK
	i0PYJ2aYTxkFn9QdWMMtR3dIFeS4Duf0mhxz4rEUqcO/6PxWtHkc
X-Google-Smtp-Source: AGHT+IG34v6jyBe2Oeqqwtl6vRLDvIT1X6L8CHvZ0QnxH6uz5O0cifARegdiO3RFzJ/WOA+j5BnTEQ==
X-Received: by 2002:a05:6512:142:b0:511:a2ed:f6c7 with SMTP id m2-20020a056512014200b00511a2edf6c7mr295611lfo.11.1707864413746;
        Tue, 13 Feb 2024 14:46:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZKxL7x8ulxvHQgonYO238frw0mrKRNeZOF+lQb2cE7g3pwPsg+qdOo5CqGX5y9kd5vKk/AfJUv4oLVciz9KJ5mvV1l32cqxFr2/yirqA6SEO2pgoCN5qJsw7uwmT7LcNbEC+MoU5PDte0GrYy7ukZ9ABIa8cDhvdywDnpXTbq2DVSVRXvYm7oPVWIUo8QYNxQi+jL/TAir057RbeiM/c8BvYwzCrhs3j1c+9oVAn2xVmvwQCWxBdzcZfs2wf/Qgcp72Ce
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:53 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/4] selftests: add missing gitignore files and include
 generated objects
Date: Tue, 13 Feb 2024 23:46:49 +0100
Message-Id: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnxy2UC/32Nyw6CMBBFf4V0bc20CKgr/8MY08cAk2Br2ko0h
 H+3sNGFcXlucs+ZWMRAGNmxmFjAkSJ5l6HcFMz0ynXIyWZmEuQOBAgecWgTxnTtKFHnfEDeWCV
 NBWVT18jyUauIXAflTJ+v7jEMebwHbOm5ls6XzD3F5MNrDY9iWf82RsGBo66FhoOyGqpTd1M0b
 I2/sUU3yo9CCvlTIbOiqVqwWIESzf5bMc/zG1uUgXwMAQAA
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=2277;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=NWymtgigjzoqDAPLAUI5PGd5uNPIj+sUwjpbAWET0BQ=;
 b=d8izg/JRL0bE8oGX7Jlnp2piKA2ZyEjgsR6a33ONDmqY85yGeoybOwVqNJNzkj4brsBHKAt4m
 4ZyFdCvpneaCAP3iEyp/Pt5mWGqZYZC67HTvSRntipNI+7e01FSk1iL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series aims to keep the git status clean after building the
selftests by adding some missing .gitignore files and object inclusion
in existing .gitignore files. This is one of the requirements listed in
the selftests documentation for new tests, but it is not always followed
as desired.

After adding these .gitignore files and including the generated objects,
the working tree appears clean again.

The new version includes a missing entry fot the .gitignore in damon,
which was reported by Bernd Edlinger <bernd.edlinger@hotmail.de>, who
also proposed a patch for it as well as for other missing .gitignore
files covered by v1. Bernd has been added to the corresponding patch as
the reporter. If a different tag is desired, I am fine with it.

To: Shuah Khan <shuah@kernel.org>
To: SeongJae Park <sj@kernel.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v3:
- General: base on mm-unstable to avoid conflicts.
- damon: add missing Closes tag.
- Link to v2: https://lore.kernel.org/r/20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com

Changes in v2:
- Remove patch for netfilter (not relevant anymore).
- Add patch for damon (missing binary in .gitignore).
- Link to v1: https://lore.kernel.org/r/20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com

---
Javier Carrasco (4):
      selftests: uevent: add missing gitignore
      selftests: thermal: intel: power_floor: add missing gitignore
      selftests: thermal: intel: workload_hint: add missing gitignore
      selftests: damon: add access_memory to .gitignore

 tools/testing/selftests/damon/.gitignore                       | 1 +
 tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 1 +
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 tools/testing/selftests/uevent/.gitignore                      | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: 7e56cf9a7f108e8129d75cea0dabc9488fb4defa
change-id: 20240101-selftest_gitignore-7da2c503766e

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


