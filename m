Return-Path: <linux-kselftest+bounces-18377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB159868C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 23:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429662822FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA218452A;
	Wed, 25 Sep 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtByoH3a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0417DFFC;
	Wed, 25 Sep 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301333; cv=none; b=XPC5FWK/FjODTejY4kX9jYC58BF20a8g9q4wqmI8c58pfJNb4qhQ3DMgfoAcs+kbfmBsg8AqwO7dv9h68qAz5jaL9L+Mn8cVZZfysci3uaVfJx+0Uaj3rA4PvYWIi6JxmXgj77W5cDIrJEraOVj1JZG8hzr3/ijpx0PjETKa7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301333; c=relaxed/simple;
	bh=7IW7RTcLpOgxZZP501qb1vVbPlEm3RjQ1ux8c067MVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9CILG6kT+HJb+3b19T6G2YiaCtkc2Qu78RU5Ct8yepp0dhG+J3UOQEQHYg/P3Q7pmNgKcqqXmipvK6yN4WyLolMQoNI4Drsf9hxHw2bCn+UAhwzhB4cDpKoROeV+vscJ3BD61T+KDhb0p9VcP/9BKTJL1m+2VchE873dP65G9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtByoH3a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so2678735e9.0;
        Wed, 25 Sep 2024 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727301330; x=1727906130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lsxEOCwsoXbFkn1yMDzhagn4UCZ4K4wi9PS2Tk4cfw=;
        b=dtByoH3aTMkROufvYDRMPmRqCDtKlQkltGZTEiHV1qERrfDFo6CrGECy9T91IkzT+E
         tLh7vaM0ii6N+xJWqKUEf98alKcvmo7EuEKOQGOsUhD01SEV/fveDjUs0sUjdjRV7a7k
         rgaBHIOrc6aohfydp+AMGdN3vzixJrffWirMXLTHQpHOdoa/c5+boa+ICJAk8g6ppbFX
         NEPlQx36/gQFi9ClvoMma4pDSc7U0RXpoj2OslqmYfTzvG+AHuvOFTNA9fM47uwj0Fqy
         OoWABsUcXzGE8Rkv0Py5z3PTNBdGJ5wSbyK24Kh5CKcli41r11FAZANsQYMdIpqrQpvT
         jCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727301330; x=1727906130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lsxEOCwsoXbFkn1yMDzhagn4UCZ4K4wi9PS2Tk4cfw=;
        b=E0JcKhqG2VLjjXGLMG2v2NZOudEiFWhagPABV0zHksWRF7KDiMC8aKSOl65/j2z1fJ
         jQVRU1v1JpKD5cbGJpPQLo7p78skyWIzeHSEKcLv+OpzALGM4nG/YoM9n32HNA9Ds4Yr
         rbXZ0hUVi4y0CU4RJ0dhcF2/zczlDEzchgj+NhGWpwJXnDSCcPXI++M+Z0W//blus+wn
         a1ys6Ay8u8gPr5XhgTdxKT19cRiSTWQZ4xA4IffnfdS82VNCT5WI7Soj+Btfvb9TCdSa
         noelCeezWw3IO858u15SXPhXEScCW/ZLLSFsjl+7iJPDIRE39Ev8IlMlFsMYx6mTsnQ0
         vHew==
X-Forwarded-Encrypted: i=1; AJvYcCUW7B9nh6tYpm7nheMtjDAt6tauE1HcINZGvZo36KIlQm5+mLxo3WnxMpouF/FQZOyS58ZRnpzD@vger.kernel.org, AJvYcCVV4xAtJq5F4sFIsApW5BdEsxmCCeaMe9hIwiD+0QkFN63YyGeJy/6BvDwotL251eeKaCs/YfLuksUdlg==@vger.kernel.org, AJvYcCWWLJVnhx4A4pKdItmSq3ahfyCuQ//pSE2G4Do5ddaXOlmEA9AnaGDZB7nNYKke7KpfyICDlHCS4Mk4880=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLST5TkZ2mX5waRCrrWdZdJdUBAkDuRGYzsv8rpMdpkbvCfpV7
	MOoSkIxoTk7Lp+F91BEa7vJ3PkepKlg0K8OlX4fktUWNyKyfJeuphJqQk+wq
X-Google-Smtp-Source: AGHT+IGFQ4MmWyqAfjWrEI1rjvVqY2tB3bR3hAOHcc/V4KmU3OJf507LaJsJ9K1hmAgn0cYE5Pffvw==
X-Received: by 2002:a05:600c:4447:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-42e9610d4famr26735415e9.13.1727301329607;
        Wed, 25 Sep 2024 14:55:29 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-370b-ca26-d622-f1c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:370b:ca26:d622:f1c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a165fdsm29129385e9.34.2024.09.25.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:55:28 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 23:55:15 +0200
Subject: [PATCH v3 5/5] selftests: exec: update gitignore for load_address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v3-5-9db896474170@gmail.com>
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727301314; l=863;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7IW7RTcLpOgxZZP501qb1vVbPlEm3RjQ1ux8c067MVg=;
 b=Q8EBY9TuoJ+RJFrfKdvGQwxnNe7qFkXDAOZLpLfhaTWfVIq9NWgNnXRqga/0GXQemSOfZcvWn
 QSsC2tB/7BGCciQzNNepQjHas8bvtW1izvO6asFGNoGinEtOFX/3Xst
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The name of the "load_address" objects has been modified, but the
corresponding entry in the gitignore file must be updated.

Update the load_address entry in the gitignore file to account for
the new names, adding an exception to keep on tracking load_address.c.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/exec/.gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 90c238ba6a4b..a0dc5d4bf733 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -9,7 +9,8 @@ execveat.ephemeral
 execveat.denatured
 non-regular
 null-argv
-/load_address_*
+/load_address.*
+!load_address.c
 /recursion-depth
 xxxxxxxx*
 pipe

-- 
2.43.0


