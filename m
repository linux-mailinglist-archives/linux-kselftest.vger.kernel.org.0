Return-Path: <linux-kselftest+bounces-10970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C38D563A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DBE28841B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073E17E441;
	Thu, 30 May 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejz6rW9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3F4D8C3;
	Thu, 30 May 2024 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111656; cv=none; b=Lk/g8XBBX82a3GDONPXemx1jspilSLS02VvLCdX28Cbw9jvyLPhlMpAW+PxXgG71B8XGouLaKNcp9npw6gJAWesleI9CXzEO2owwMP1jskRNeW+Y67sIkz6B3Nmv79rC9RJXKm51l9KEwbSiVIBWPhmI5+A8DN8bJod5LkPCmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111656; c=relaxed/simple;
	bh=J936r+DiOMS3MgFGq6523UYD7iDOXAN2fhSE2VGZZss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9qjJlr3+EYbHwY6naMteYIRzRDTj5zgrIKLMQdg8g49fPvsquzhIx6580DLrDBPxEbVRID95iaHboh1mzl8eCiYRoY5KdM/qy6RTCO5Frp8KAMPHqikDMbaFVYENzRov7E8JRtoKoaOf+/iCccwuek6s5W8pdb/LVnHbM2ggeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejz6rW9g; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e964acff1aso14759961fa.0;
        Thu, 30 May 2024 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717111653; x=1717716453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4p5dezIqTlwyao4nfb4lQwbHXPe29ko3E6Z2p0D7l4=;
        b=Ejz6rW9gmcDbE3gN8d6v0qyl5ArcGqTaouJxCoUxa1w6j+hLr8bH/gToaT5PAgLfVh
         G1bcraO0vtvH7Ddt4E2Fhv/ngwbr9jAtZU1jjxLYi7dbyo4/Kfa3Hv/dJUCx6Qdx2hBj
         v9N0oQTOmjSqahv1UInPEBrwGqna31qQwhknpzIM4DW/upZAdbFjoa8lYCwDQFgFmR/f
         gjx94pN4rSi5PY8SZKCZyAIwOj3ZYLk2SnwqGraeAe6RqRI5rGpaVm41CdeZYo6GkBAp
         PnrIvAF/ER9QlHIH/limCn6zDYHR+bNNxkEojMOJg31iiRITvZSaxgzICoLp4jNJEZfL
         QXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717111653; x=1717716453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4p5dezIqTlwyao4nfb4lQwbHXPe29ko3E6Z2p0D7l4=;
        b=T+YLUtoK1pqZ0AUMNk6FnwqYxbDVCAOl9W1u5AmsiD8sPxPoZb8/10C4EJxdywzv+N
         GOwOAlqr/Y1OSslC8uAl/HCqnEkHLEc/HAg1tqrggo6GzgCXvP1IcUQ0LvS+VXWXSnRQ
         Ts0ss/64DiI9B6AwfMJ2AVX/YInsXUJJCFpU/J8eyVyfHMhPCv5GtEgCbiJ9VyoFV1Xa
         BFGgqsOMYHyYhjsxH1XWZTWH1r0vwhMroY/F0V9ITyV/Z2nvoTPo8+Nqv5fA0RcqEVQI
         gWudHg1M3qqLZdmTN79UALqPvl+3v0nOLO4RIXxtpksZh/JDjwE5NVzr2X6EEBhsc/4O
         m4QA==
X-Forwarded-Encrypted: i=1; AJvYcCUDfY5ytEoFomLGGxP2Z8q0z7QSBtSjyVG9lrbSbvRsz8BOdYK/alNFWIqGmjcXKr5jKfcSNaNGpm43oFYiTc23BSYfuFRv87Z/cKEpTGMv4eU1/b2xGb8t0QzZ6SyZs51u4vHF1SAXCm+0f4S5
X-Gm-Message-State: AOJu0YyvYPlolaK0Dl8UzmvQGcJzr0q6fopVElSnspqcvE91wSVMJPIW
	w4Z+V6w53MjZXRGyfSHUYc39y0ZsH2oL0TSv2+bHT+gepFWXBxCXBUVMvA==
X-Google-Smtp-Source: AGHT+IHi05csmUaC/XdePFs1mfj5AfezWi9oiIMwfg2LOseu0xjlzdLecM1APuhYP98qnjfxF4H8SQ==
X-Received: by 2002:ac2:5b1e:0:b0:52b:8926:9052 with SMTP id 2adb3069b0e04-52b8955b3e8mr78151e87.5.1717111652620;
        Thu, 30 May 2024 16:27:32 -0700 (PDT)
Received: from lenovo.. (mob-2-43-182-132.net.vodafone.it. [2.43.182.132])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a35e86c36sm197223a12.54.2024.05.30.16.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:27:31 -0700 (PDT)
From: technoboy85@gmail.com
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH net-next v2 0/2] net: visibility of memory limits in netns
Date: Fri, 31 May 2024 01:27:20 +0200
Message-ID: <20240530232722.45255-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

Some programs need to know the size of the network buffers to operate
correctly, export the following sysctls read-only in network namespaces:

- net.core.rmem_default
- net.core.rmem_max
- net.core.wmem_default
- net.core.wmem_max

Matteo Croce (2):
  net: make net.core.{r,w}mem_{default,max} namespaced
  selftests: net: tests net.core.{r,w}mem_{default,max} sysctls in a
    netns

changes from v1:
- added SPDX header to test
- rewrite test with more detailed error messages

 net/core/sysctl_net_core.c                  | 75 ++++++++++++---------
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-sysctl.sh | 40 +++++++++++
 3 files changed, 83 insertions(+), 33 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns-sysctl.sh

-- 
2.45.1


