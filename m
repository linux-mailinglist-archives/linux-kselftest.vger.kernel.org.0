Return-Path: <linux-kselftest+bounces-2540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1682124B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 01:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074611F225F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 00:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93338B;
	Mon,  1 Jan 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNgh7AAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EA7EE;
	Mon,  1 Jan 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so88945145e9.1;
        Sun, 31 Dec 2023 16:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704069733; x=1704674533; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ghkUk+xJ0DBfLtEO05o4G/p1AHPM0IuHhcVOc6p5cs=;
        b=dNgh7AATCDX3PeO9oBoMt0JBepq61BjHD7WFnYwgpOLNyH/IEB3tTdf0tksXLJnizA
         sAKeDAG3Gq3OppQhHymDFXMlXLjukO9V5/Y+AXIWMWIRyeRODNOiCVHtk+ZDicaycfS/
         kQQv7OB1kQbW0JYMbUYYWm3RQh26M29jYd/8SzBBKam/FSJKIQ6Caz5a1ZOk1VFNEWR+
         p2pe7SDVEgignU5PrRmR1TVBeIenHANYct6ZtJt9EDAwxYvzRqsYthaPOWGAUAwyXMHQ
         uMilv9Wrxo6iEMHwLeFQ1YQKYAkbDEu2A89f19LJhLpbWjn4HLQamADcafCPduT8wI8f
         YLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704069733; x=1704674533;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ghkUk+xJ0DBfLtEO05o4G/p1AHPM0IuHhcVOc6p5cs=;
        b=QyTxEp7wuZMcgynCAwywH09sdS6HvWGvdRuNTpBA02dMJhO7mK/KTnnwSlmSk6OcMV
         qGQfvHB36W0NRc5QJ76HNmTNjV6v6f31HtTEks6wZPjXleRTwW+Lv7VrcyUtDw1WS3kt
         971BgcOnYiXk3avDQBY4IBMPAR2qVuR8b21JrBuu/zarEpPPzY2HSwkLHkPEJ3DYQnES
         MPjLzyydANmTX3ySvDXMI2OajabFP3mVz/Wcga/YmT6/k/OURUwcq1nlnSWRjAcWRIZG
         16cwvbdgaQyVtRI0fKsHpY3fCT2UmXXEVhOdYxOdZ6g5484O+ffsINHc+ITtAri5fyTf
         o5aw==
X-Gm-Message-State: AOJu0Yw8k+un9pq0KcgT8eX533adIv1/10xDzQF9+zzR7r3WYsdWrJRW
	wNjUip23ndnw4EH5TgOdL6Eer38R6kjsu1/zzZ8=
X-Google-Smtp-Source: AGHT+IG/26NTjJQEsD6M4Hj+ZuxAjPOCCBwMvTU4Fp6SsJKb1fpRijpaReRv03lVi23/xEo5+GxgLw==
X-Received: by 2002:a05:600c:4e48:b0:40d:58bc:c296 with SMTP id e8-20020a05600c4e4800b0040d58bcc296mr2266189wmq.306.1704069733370;
        Sun, 31 Dec 2023 16:42:13 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-14df-0f70-3365-7192.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:14df:f70:3365:7192])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709062ec400b00a234585cc79sm10458605eji.188.2023.12.31.16.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 16:42:13 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] selftests: add missing gitignore files and include
 generated objects
Date: Mon, 01 Jan 2024 01:41:44 +0100
Message-Id: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgKkmUC/x2N0QrCMAwAf2Xk2ULb6Qb+ioh0XdYFSiZJFWHs3
 xd8vIPjdlAUQoV7t4Pgl5Q2NgiXDvKauKCj2Riij1cffHCKdWmo7VWoUeFN0I1zivnm+3EYECy
 ckqKbJHFeLeVPrSbfggv9/qfH8zhOVWjlIHkAAAA=
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704069732; l=1262;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=Cu+vSSU6ufFQObOMUFDWLKTfFRmNTvA8qsHA4Y3rNB0=;
 b=wOm7/Z+87TFoQe8R9jSmd7fbSFBa5m5mb5mZffmEBvbIMlcVJfvcrkttbmgjkxIHQbXqJNzBS
 J0E4raPF9MGDvKvVoXJhaID81ddcUSHkyZ+eIjq52ulFoijrA2G7vzO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series aims to keep the git status clean after building the
selftests by adding some missing .gitignore files and object inclusion
in existing .gitignore files. This is one of the requirements listed in
the selftests documentation for new tests, but it is not always followed
as desired.

After adding these .gitignore files and including the generated objects,
the working tree appears clean again.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      selftests: netfilter: add sctp_collision to gitignore
      selftests: uevent: add missing gitignore
      selftests: thermal: intel: power_floor: add missing gitignore
      selftests: thermal: intel: workload_hint: add missing gitignore

 tools/testing/selftests/netfilter/.gitignore                   | 1 +
 tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 1 +
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 tools/testing/selftests/uevent/.gitignore                      | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240101-selftest_gitignore-7da2c503766e

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


