Return-Path: <linux-kselftest+bounces-4529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364EF851E0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984AF284690
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858448781;
	Mon, 12 Feb 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhCmDZrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573F481B4;
	Mon, 12 Feb 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767024; cv=none; b=f9wh57m4Ai3hD/dkYzYjzyaLWVQCKMhPxTxEAhD3m57zHtlV+t9ai4Ta3GKdbir92to++4R3d7UuaIU4326rv5qbzUO6lxZfaIF1PQtLl+fUhNboCABh19TCEd8jk9ilhq2I7Z0/UjdGxjfaZaOfNlP1FR5L3Qd2CANoGaAa99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767024; c=relaxed/simple;
	bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niFxYcgaNwDhPHilAg2RWeEt6VYIOAxlttqJMKv6szaNc3+u1zCbALjTwd18clR/1qOCrXRmGk4JeCtf9ikgrlXYsAV2Jua3GYfCN6t+yEyC/PmM1lqi001d898I4U3RdexUTql2FqkhBq0RGdre4Bw5DfMYivB+8T0hHslmqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhCmDZrh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a30f7c9574eso17655466b.0;
        Mon, 12 Feb 2024 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767020; x=1708371820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=YhCmDZrhdNi1iU2TxF5dEs7GEtGk7YThpkTzQpb5TTpP/sqFJc0tdUjzLHAqIZPsPO
         tuY9bZyjJDLZfOB5zJTM0bzGVJBdJGB01tn+Y+tbeEcjik6qsADMUjIay0yJYN2+tZJa
         T54NL5GihCSV8yEsYm+cKgifNlH0l/A4GzZu++XY1fw2jmowpGASHoW8f0IonSm4FCCg
         LA7GP8lMe2hb+g2x5OWClcYMPTQ07Xd71JGco4mH/JXyRcyjpzYQzGycEXZBx1ppx3HD
         AI4GRp/156L7+2lYSOoi9PAPVqlML70CXWjqXfJMnaCjG98pyDdOsiGu+2eMut02e42r
         x4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767020; x=1708371820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=ed11KvLnEb72WS77c3u0UYvn4lzFR/2Umx/HHxjSb501G32CN/7c/JAaVJyH/m1eKF
         ywv7HyWMFXExDaNTOb5OqpaBUSspRodm8oL1ImS5WHyMzpz2GaK719tjJiQnfYjON3aI
         PeLSnkuTo6WKn3KVgVI5Gv3o4JC8MDQ9dO91v9W3h6XdpXMGI43YZCfI8V/cMmyUM2FV
         SuDvVCMpDZHnJ4lQuAzA1+DQNzgkbAd7JKbuL5Nzl8C1oDiNVezNaHwwHpAbsXRCFckE
         KQOpBaTjY8ZU4jEbcxl7d5PTP5Xg9Qi3hAORl2XhqvyAMG65omYsVSwUBjGVqJpHw0Fq
         xo2g==
X-Gm-Message-State: AOJu0YxKEfUYS9wgHMq1D/JGg49Jj+Pez3z5FssKE82HV2zIDyT1CctY
	ZlsQkqkugH/F3uStK91gUV2GHNIrZvtUPQXyZSF/CSylBx3nMLLV
X-Google-Smtp-Source: AGHT+IEYhoVKt6+ph0IS6aNoOBB2GhXkcHadPbmFd+yeLBLvAD9woPDg3bX6Tq4y5ucJawuRvTz4Tg==
X-Received: by 2002:a17:906:e2ce:b0:a3c:8d55:bd7 with SMTP id gr14-20020a170906e2ce00b00a3c8d550bd7mr2681537ejb.23.1707767020593;
        Mon, 12 Feb 2024 11:43:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQX+FVohLVW9V+EuI5M+OMnY/4RbHojcf09owLeeu+Vrmfcsxpmy2iXuJa15IyEuWg9IlhKLGQ16j06gjlDc342+M36uk5KpPe6/suhmsH5SrV1yPfw5FxNoLwsOOep8vTTDdarZ2x8xW9jHo18hxbQ/febrkvQVY1wk9Hj0YDjnXohHvbc752UnowefVkkuqCatr+7HQq0us97he60OoWByZ9SQOWKOe1uW/4gtU4VDxr42wgLHzLem3kJTOXB+JR
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:40 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:37 +0100
Subject: [PATCH v2 2/4] selftests: thermal: intel: power_floor: add missing
 gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-2-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=738;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
 b=U9JPqhmipPaxTM+qc7NP8sBbNgbXPf1Aelc2TmOFCe1hKrrw4MvUlBCldhUaovyU87CyT4sJN
 xDoY87TG4pBBOMUmJqLcJF52w62kBmpI86jTFlN9SrJIA0UFK2YxUZc
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'power_floor' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'power_floor'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/power_floor/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/.gitignore b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
new file mode 100644
index 000000000000..1b9a76406f18
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
@@ -0,0 +1 @@
+power_floor_test

-- 
2.40.1


