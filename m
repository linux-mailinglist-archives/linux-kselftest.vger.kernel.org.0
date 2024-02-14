Return-Path: <linux-kselftest+bounces-4607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED0485409F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 01:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715EC1C22646
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 00:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C377493;
	Wed, 14 Feb 2024 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJoD4fz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63408443D;
	Wed, 14 Feb 2024 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869019; cv=none; b=dQnsvbFM4cvkvKV+avzTppD63KwIseaLSTGWOEVJwbY+jgT+/3zhO6DZNSr5LWns5bY4bGcSJbjeyZGeGUmBFDy4fdDKeOZDehgZ1MyJPFWvWIHxr7/fYrgXqGACh0cBM/QdPfP8Rh2RvAMz31UJzveFrDgiQbJqU6EU/DKKzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869019; c=relaxed/simple;
	bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gETRxIzH++pkA6n8o/DJiapLf65/H+QPdmXi7sBxryGIAfMkxpJ+HJVZgjll2HqKqnK1QIOO3dFAi+v/O6TfKQZzZa0YkvlxyAkkHGk+Lpb8yq2hpBOqWx3IZXMdRd6ggzDdlOc5GiAHafoHh2nBDUgEHejb0q5d2IyVaJ95sIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJoD4fz5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a34c5ca2537so631945766b.0;
        Tue, 13 Feb 2024 16:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869015; x=1708473815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=BJoD4fz5vp3NnTHQTbzUOPvRtSWOMbDFS7BeMBz+jyAD9CAV67ttMiClGG4VLJWW3j
         YnWPyoLF8V54IWNHGOXY3O8Eg3WP1x4qD3RziR7NxgdNIC/wr4YA7cp4xS4tj2a7l3+R
         put7S1upDgrVeouwJepLF/QvbqFA5EMztan0m0W8qWHk8Ov5i/PogjI1rnvuqUxzNDwk
         BhGK/qGQ08pakzOu2pq0Ef9CW1B3WUE0YJZHCwNc3tybJf9TRh96vEpRFVJF3KWhVeHm
         KzALVqd2OpLbNPSlWG7gzBrR22Rgj6LmVNqXBgM97sSm39oiS3STt/uQbBp4WVX2cTTb
         1VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869015; x=1708473815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=aw0CxCOZ7muT5mb4oBavaS0MmSUXKBbgWxD1WrUTTnUNAKbwFFEZnvacIYCQrnw8TI
         yn3vVJlkeERbVyoVve1x9CKR0qq1dGYx8PMy8NbhP11dSMI4WxJJhj+tZAg3pS29h3kA
         yOJ6W+92eh8e4+f1ZdrZF4XMdVfM93I4mMRQAEeFHnm8VOOf+8HE6tpFDtxr5+QTudE0
         BIfVKAYDsRQHvpSwM5lwAfLsylT32cfSS/zKkLWPSjZpVACFe9ByfxldiIRaTwZOaO3s
         /KCdFqsm/zcx/2bGfPpzcr9F+wLHyFyQG8nFk84Qq4TILoWp6BgIRjZIekNi3Gh8VNNO
         zocw==
X-Forwarded-Encrypted: i=1; AJvYcCU3PTSW/Yosb2CwGE0a92J5nPKVt6g8UbYvy7e2kptm73CwrOtZvBTQcsYqqNeIgZ0FtLHXntdbr0BhRwwigS52kj7/RLhzqrCQ2nxUO2kl
X-Gm-Message-State: AOJu0YwJUE02NOmyneY3YurXKjiamsU1SF5Q8dk3FQ/AvJMC5E6HUlZw
	b+i6oUOEBfh6Jq+anTW61ZLD4ZB8+xXF1zuPh9TZQLI4EMB0TSDU6ehoLRELHerT5g==
X-Google-Smtp-Source: AGHT+IHovkvh913/+PE1f3KU15FFWal2Zx88fdzVDPVzMesSW2kFDA6aZF5XrhhNnWHqk200CHqg1Q==
X-Received: by 2002:a17:906:454f:b0:a3d:3894:b19e with SMTP id s15-20020a170906454f00b00a3d3894b19emr326960ejq.13.1707869015008;
        Tue, 13 Feb 2024 16:03:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXWDoplzryv/VVxZVnOp0oLQ9/rKdpq0KPYQohTDmBTTwD0Q1YQA+itH+72swI+oUU9rDQEXkeLH8CtaiFSyRn4rszSdIsTIQ1Dt9/PrR8NIg6SQmqb5K/yfDA+945FBzPri04niQtyO/m0Vca9dKDugAZp2d551Lszig9Bpo=
Received: from [127.0.1.1] (2a02-8389-41cf-e200-68a7-7041-4298-e66b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:68a7:7041:4298:e66b])
        by smtp.gmail.com with ESMTPSA id vo10-20020a170907a80a00b00a3cfd838f32sm1160901ejc.178.2024.02.13.16.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:03:34 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Feb 2024 01:03:31 +0100
Subject: [PATCH v4 1/3] selftests: uevent: add missing gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-selftest_gitignore-v4-1-857b39cef2fa@gmail.com>
References: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
In-Reply-To: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707869012; l=672;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
 b=dqNUS4fedMfiBw1lk1P7Zm6Tad/msmThONwZThiasxuXIp2PtqxNVxZF0PIrkmdhPwHnaBGHL
 oZiIqPAAHRdD46kZDxGFUW1jlNAcyNW78x2oiQQYG0CJ+PClCjRkaaF
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'uevent_filtering' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object
as stated in the selftest documentation.

Add the missing .gitignore file and include 'uevent_filtering'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/uevent/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/uevent/.gitignore b/tools/testing/selftests/uevent/.gitignore
new file mode 100644
index 000000000000..382afb74cd40
--- /dev/null
+++ b/tools/testing/selftests/uevent/.gitignore
@@ -0,0 +1 @@
+uevent_filtering

-- 
2.40.1


