Return-Path: <linux-kselftest+bounces-40161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E653BB3989D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B1198684D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C72BD5BF;
	Thu, 28 Aug 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ4P75mu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D622D9787;
	Thu, 28 Aug 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374029; cv=none; b=WaT6fkNjy21h0qrTRRBk6RuWx6PD6wvV33bxjzFt7X/Z15gwAV4pCQBwaPhWloQ/MjUk3HECslhwg+Wt1JvJC8qNO0F8bNCwWquTYLoRj+wX49sEBDY+zGe8tuaypTPa+cTDdA+K4nmJxzFk49rza2PW9RBF1iSBsmjC0zC3h50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374029; c=relaxed/simple;
	bh=R6jxNMAjDI19J1IHRQGgmZqJDB7pJyMti4vDt5IrhUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc/Lbbwd8yPXSm5N8avOsHK/jiP7hY6WuuVnj9+9paODmOefoka5za54cv6LGqJ6W2kpzbsAsD38Zv9X72uLi+QB2FeQ+VJRfY7xi4e6qkOay79QX2UlRNn5Ia8b2SCnDiegURI+fBnRDEkmcpnpCFF9jrVcs9OmujRKfoy8oEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ4P75mu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323267872f3so714856a91.1;
        Thu, 28 Aug 2025 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756374027; x=1756978827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6jxNMAjDI19J1IHRQGgmZqJDB7pJyMti4vDt5IrhUw=;
        b=GQ4P75muGjUYUrm0Zp+8YgA9k79Aw+UT6J50VCF/ZbBvQ4WS1YSP+4QEntgZaX0AgC
         l0Q2gQL8mWI3XuPgGwsu/+oslUhvctFNQFOvBntI5jkCOW4cZJnFdqLZRrC47GItua5p
         i36pIzU2Z9bU5sNf9t3a8MEFGJwEBbjDf9saotQT3mQTElheQa2zqYVbANnTON3rv+St
         wIwOsGKEQJtfAEQuBR+wLvpUjupXo9EuBVSGkDTaFRErNxjw/vGBxVmbhrBdfITJhvvy
         Tbhyu9ZnjU2RzzsDHAgqpi+XeBTJuf7JxTvG+eFx9zOjOm/37s4CvgXgBYcVoWHMCJ/4
         PjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374027; x=1756978827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6jxNMAjDI19J1IHRQGgmZqJDB7pJyMti4vDt5IrhUw=;
        b=j0aZn1N1+zvXV/DqbyBI1IaNebOisGPmdzMLpU4XEyFP7WbBArKKaEaJ48igKOHoq7
         d8A0FmY6b/g1Ews8zLXFo4c0Zgef0WzGMXF0X61RHDWN+LmT5ePhLO9vxUNoj67l/5dA
         eyZDQ/IQyacAegVWD0PhpvwQe3RGAbHvpbpAOopkbtVfGcsThKEQof2YLPm9ryMePs18
         ZoPjIu6OCA60ZjTP9m5q1nEcdbre9BAlcYk3VS2H/INHvFAF1H6zzJkWa584wkgOQawQ
         KjwfiW6v4ZIYSfQGA52FP3IJgLjulT3Lky15S4W57ghjztZqhwL+QO6SalhHUjPA7SYE
         iaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3K/C9s+fCfP8HlAuNTiaqDakFKYJ6LvIZoZIZq4VW+XwHMIW45TDHywAbEKHhcMZeUHMkBwRRz5Aas/A=@vger.kernel.org, AJvYcCVfEtBEugOUw+CY9x1cZ8f2wiF/HlqSy0IRYjGJawrsao0Y4UiDkXx6ty6SUS5Spi44yf8LjyKbL64/XINcbkvA@vger.kernel.org, AJvYcCXDUKye5n6Q6BEtB3PDLyegrO5USMobWAwDy1pAAXZIruZZTQ7s1ILNppwzojK4Dxh49yQVlOXTIl9tc0qy99D+dsG1cSKd@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBtyMkL6ddYxDJVnXIvXA0J1lmKnUgw63dozYXJgjVjVEYAQd
	obg+0HG6RANDb8HwKWiVbVdA6eT6XgqmOahL0MoDeHDs8Pg5xYRrIyBgjeiccVWIucU=
X-Gm-Gg: ASbGncuIyKJvioctgKDSG4c2wkNpbArWX5aCz3Xh/AAMDQYoBiC5F38JMntljZ8A4ar
	wb28E/4V4FgjvuJlyqm7p8/vWNmdbajVb90dqoyqOzBNE2BGdlNXKZgnUxaj3/t7oKNJapzMU37
	NojXRLHaf7FcxJ8uc0+zFKKoTZCQaYSxj+ZWCPVCIo+LDPmJbJTvlyrlYW83ttQNQyrbkCJ9s9m
	TOUf1RE+aQrqMG3HrDaR32QtnhdpCZ1hoikrunLfxSmOVX4qouE/sxdyn7r1HytJL/TXhWyI/mJ
	ZcQ+EEgobGjrvIFyF5K+HI7iZ2dRk7IeyGg889wtVnFAp5MooAR1L2ge2p8RnhuiOD6EiZBxmsN
	BzyTh8WansJuQrpCj0BBeerGv1hFhEBR3dOjesViXa3/S1a25TDwEWVZ6CFaxUE8Frp0YfnqZlC
	yI6jyK7L1t1L4BZeCNRQ==
X-Google-Smtp-Source: AGHT+IFyJcs7VZXQO4bl1E7h+tk1g9mI2keQqRtJvL/QqXUnkVgw42POnmQAIbH/7ZuAy7kHK1BBsA==
X-Received: by 2002:a17:90b:1649:b0:321:4182:2b9e with SMTP id 98e67ed59e1d1-32515e37410mr28758623a91.12.1756374026134;
        Thu, 28 Aug 2025 02:40:26 -0700 (PDT)
Received: from server.. ([103.251.57.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd33c1sm4518432a91.17.2025.08.28.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:40:25 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: richard.weiyang@gmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	david@redhat.com,
	edumazet@google.com,
	gnoack@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mic@digikod.net,
	ming.lei@redhat.com,
	pabeni@redhat.com,
	reddybalavignesh9979@gmail.com,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: Re: [PATCH 2/2] selftests: Replace relative includes with non-relative for kselftest.h and kselftest_harness.h
Date: Thu, 28 Aug 2025 15:10:16 +0530
Message-ID: <20250828094016.18063-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828081026.yx6vgphtsf4pmr3y@master>
References: <20250828081026.yx6vgphtsf4pmr3y@master>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wei,

Thanks for testing and for your feedback.

Yeah, if you try to build inside a subdirectory, the top level
export may not apply, so CFLAGS don't get updated, and even if
they did, the path could be pointing to wrong location.

As the docs recommend, building selftest using TARGETS,
either from kernel source or "tools/testing/selftests/"
works fine and doesn't fail.

If you really want to build from selftests/mm/ directory then
defining KSFT_INCLUDES with a fallback in the Makefile will
resolve it, but there is no need of it if we stick with "TARGETS=mm".

Thanks
Bala Vignesh


