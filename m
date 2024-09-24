Return-Path: <linux-kselftest+bounces-18299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D7984621
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 14:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8711F23D30
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509951A76BD;
	Tue, 24 Sep 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HswAqeJB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1785481B7;
	Tue, 24 Sep 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182158; cv=none; b=YzTYxFE5Q/mjwC1xtmEIU4BHkdNl+rVlX7pis6Pu3THjwi9IsjklUe0F9Ocs9d1xz0XqrHi5muVjbKxWjWB/0krDQDkDj6S+0GYJWocVCMeMxQud6rX5dwUUD70Fg9oLXsKhlV4LAVoOfHg/KieGF4U0hSaPKmXUU7pHVCHOIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182158; c=relaxed/simple;
	bh=VAzLbhePXQTUa0RgQqWgt2vOIC7KZp5Sq9bUPalwf7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJlJLlS5379zlR/NaNWwY8F51E1EA2G6vhScXqVQVigfUUQTKEKxWsNgc6PnV5HT+ryvywtJ3mdn0hGjrf35bbNSwC1OBatteGlVhhdnyVV2N5AUCbIQedVTWxHplNNOeUJ8Rd1Z/NSRTBs3wlBAIcBD7P0MCZ5NZ6Se1HwiVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HswAqeJB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so3239381a12.1;
        Tue, 24 Sep 2024 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727182155; x=1727786955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My/o3x2ZINOHGQf4kyCetcXoEUn+zJEi0VQbO3a2Fzs=;
        b=HswAqeJBIJn5yiVOr9ZZH4bqKx02TKZHn23XVdO0voGiZANqkQKP2xMtA3d4AkZEb3
         d4+GRNc8JJdGTWaMPyFaz8J0jD/6RZMumnb3e6FySkNgdy4O/mQmlfxsujrPWGf4vyAn
         B8yAXxtDUPGppP+u6D7VKaW4DaZUU1oDWq875z+TYNzb8yP4RFrUmXRb9OWmBENs/9Pf
         5Wbba4Zim21TDUd+YOBW4XairDNJ+T6Y4upeYmZYXCCY55Mbm4dPUKEVrHfD1me42jgA
         URoFvA3Fos4ZLwaLxcrRBYbNRzHXeJ97wB9Ov8ofIDZhHUqZNaPuZg+8y+YImWLChAzD
         l9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182155; x=1727786955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=My/o3x2ZINOHGQf4kyCetcXoEUn+zJEi0VQbO3a2Fzs=;
        b=a/uWDG+wDQ0EDyZ4RQ6qzYyhDLRcgGxxLPL8aeeM9mM8ZPBhfliMbjk6HUI8KpbnIb
         e6rUMzJ/AjTXjpzN3iLd3RjRIns0n5fH3Mi+A+7GgbA+MqKIZIjB/sUDAGROI9w5xoS8
         EvjVQKvWS3xm/uX51orhZed5nA+tWOpnuu1+CCqI56dptl/AuESnUQCMW+uyFflj8Iwt
         DQCzb3XxuGvLeXnHLYKVJkqzjaQGa0SDmi5kgz6Qb9gtepqp+WaFrYRxyiHr0hsYWUmn
         KwAeL9Cnj8b/aVBIH0DGSwNHYuqO6i/nXipXPgSY/L+t+Wkoav5k6Ex4y44RXL9Aj7GA
         y/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1V71LUoNomkTC0aWpFB394lDdtV+u7xNQCVrI/s3BNv1d+6oySFOUeCN/ptfM0YpxeE1yKrCZFIA0miU=@vger.kernel.org, AJvYcCUy/Q5PbUiEqvohvE2f4du4XWn0+pvs/lJCFBSFAVFf6oMcmF5EB+t+MjVlu/pbpCOCZ5f+WWmSPa0IjQ==@vger.kernel.org, AJvYcCXEeTeOMEVh5/F916gXC2kxo+R3dK0uYOuTW2YeCL10byzNeDvQgL1t7mfp/0U1tuRFGPD/dPAU@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDEe7PC+6yHg4AUMiWwsYOzT8gVCWyNtBjSP5PjA+iN5c7oAc
	O/DaJWSuOud0JGHTdn4cQOK9UxZCkt6ibUvTGQ4Bm6DCFgk9Y1tH
X-Google-Smtp-Source: AGHT+IGbzfhIVwxpNRqAdKVpWJx3mcKdQ9M5j9hwogScJ7XBf8i2j19IloZ7SDrkMCQ1VKnGcbzkow==
X-Received: by 2002:a05:6402:274a:b0:5c5:c5fb:57d5 with SMTP id 4fb4d7f45d1cf-5c5c5fb5846mr3475751a12.33.1727182154700;
        Tue, 24 Sep 2024 05:49:14 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c500dsm704932a12.61.2024.09.24.05.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:49:14 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Sep 2024 14:49:07 +0200
Subject: [PATCH 1/4] selftests: add unshare_test and msg_oob to gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-selftests-gitignore-v1-1-9755ac883388@gmail.com>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
In-Reply-To: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727182152; l=950;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=VAzLbhePXQTUa0RgQqWgt2vOIC7KZp5Sq9bUPalwf7E=;
 b=xvXLVdISnFCMi59JGXVRzSF3prM3iNEQxB7oXBjdoLHN/H9U5FoZR/hioZ5OlqOfitP/HoqK6
 R8GDASHLXq0A8+6cF/HQ0MteV/eqwZQBqSX15Dh1Mb03SVnDL5fGZZV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These executables are missing from their corresponding gitignore files.
Add them to the lists.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/core/.gitignore | 1 +
 tools/testing/selftests/net/.gitignore  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
index 6e6712ce5817..7999361992aa 100644
--- a/tools/testing/selftests/core/.gitignore
+++ b/tools/testing/selftests/core/.gitignore
@@ -1 +1,2 @@
 close_range_test
+unshare_test
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1c04c780db66..9dcdff533414 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,6 +17,7 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
+msg_oob
 ncdevmem
 nettest
 psock_fanout

-- 
2.43.0


