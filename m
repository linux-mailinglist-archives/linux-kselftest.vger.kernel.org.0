Return-Path: <linux-kselftest+bounces-40386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A49B3D6DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 04:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203F81644DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AEA20C038;
	Mon,  1 Sep 2025 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvc2hXJL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0710F2;
	Mon,  1 Sep 2025 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695509; cv=none; b=gfkMNt/GB29MTMw8z8KXhPKWYf9Wt2fcS9fOelplgAtGJzUUMdFMrViaWwFrkVbYj+Rf2sZX0k7C1k4oowfgpIhP836StMvnpqqOGaeITVq0k97VfFsSc7eSw1U3KxwpPuUHyNL14sCUNq5lJCkGh2IVR2thmNDaIOGT/KEk8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695509; c=relaxed/simple;
	bh=8xc5xb7dUSiUl+N7EzdGMbpJHVkz/svcP008qWdxybM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX4qpkC33U3COUT0M/ELwx19ssoSuDs90jzRbwiw39af91LV+JuOvcCl20YZBeGRag4a0t8Na444MZfEsL65Adwi3jh8oI9XSJBTVGdtsjgS1FWY3HUyACLQMP/gVJku+Kc8eaEiGOEejfNTySVCTV5Ij8rXDVI1q5eMuIBpv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvc2hXJL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24879ed7c17so29223955ad.1;
        Sun, 31 Aug 2025 19:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756695507; x=1757300307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xc5xb7dUSiUl+N7EzdGMbpJHVkz/svcP008qWdxybM=;
        b=dvc2hXJLCBG6VoVniW1uTEGbdXmI6Er2KinhjWxHazq8vPg346w4Ow+9xU/9GF0Gh1
         JV0l5VoV1I1C8OymWdtzauJ3WzPdowgqa4GYf0EWmvPhq8fuN0lBsiOXmWsHqxjxzZCc
         vJdXdAvqK1HtRuCDtVD1V0gtqfb05JRpIKhgG4V9pwm/5PRTCgNh4sVrFmZRQzO3MwdG
         ZxxUGFrgjhR0KT7pxBFpQt9TkGCxjVEmTkWKUf1+Fq7o6OATjGfcHA19DCfQu6G2AzxT
         7btFVWZTkhY8pipoJCN8+FJZvhahpnlzu1He78ME3gNQ97zKPYF0GIQweEKGCXklNE0Y
         tPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756695507; x=1757300307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xc5xb7dUSiUl+N7EzdGMbpJHVkz/svcP008qWdxybM=;
        b=K2CIPzaNeuk0WQZCeV1dTXsj1RAYuiLbdUhA+XDCWkmAqMg7VeVcxCOvaWq96vxlgJ
         UQ+Uxj7iFhi34tLxo+50dJNDL+0Jm+CMbmnDTOs81iIWrUdlBzkl2Jm1dmVFGIdkIpt1
         54tIYO7HE2w+WwMC//NRctC4i7ZzPcOPevTdYRsJxbwIyBlP5L0IHH2Wm9h5/xP0EKMa
         hbYAV7P9NA8cTY/EQB7UTuRuinpWAetiNw3S47Kyu0oBrJ7To08o8lEAdvV86N8Z8bS/
         PxCok8Yd9EVojnkpG2U+jOnRRap+BmBZYuQqPomSVMvxbOc73ZuqBKHgKZcBACKwdN85
         Ax6A==
X-Forwarded-Encrypted: i=1; AJvYcCVuUhM1taF2ClStPLxJ9++Xjr56d3xG+vtIbEBtP+O4r4tSm3RAsABjPNzm77yffLCGKNK1v9yc8dOFPzPGUbDh@vger.kernel.org, AJvYcCW+441w79owyqtp+sc6Fr8lVzlsgrtYqUa+jTER9QCU6PbiXX+YDfkAlrqYsVOlBIdXxwO+KtLqID80daivkFi8KaKc57q7@vger.kernel.org, AJvYcCWxXlJxEiW5nzhdZP0PBJjRR8qcfH3ZdVaY0AwIFV56MoF++FbuavO9D5Fthd4Cm4YXRC0h9NRdHTi/3HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9T3mIP5C9gEe/haoYj/9WOU2XY+VmDeHyGO4JNx3h6zAfgu8Z
	1ZfJq/u2aFSLQygLpT02T3KbSnAdgwLGR6hcnUTGwNuaoFKPty/I7BB9
X-Gm-Gg: ASbGnct4ivi0AGbylarZMzq4moZWGgk+5KH3ulyCxcSF0lATda7pGTLR1/SKEv/zpxp
	z/keF6a5o7A0El5VdVJ4ZTH6K32tf31mDHc1nmlsO84LeiYO3fqInFnLabTozpIWWRCIWKX8YPj
	QfdhABTBfdNMX1Tqy3kVjyEcVlVDWp9F562ivxEzPVd9LZ72S2BLhUBIgaF778vBSoBqikgeHzU
	dfcFzMM6c4lKifJbxlStzLzQzKR6AkeyQ2DayFtcSoGHJIY9AsA4yWgk9wrcoGzYCBufb/rg1ZS
	5Rqsnjumxf34AW9ndDgv9lubzkidcfLu1mXAlwaQNqKOz2ShAV7Wns+48DAOAhnfb1DfPFV0IEu
	mDqM+hPjLSipqVpe0Zln167l8tJbTXemxGGpR1QZrqDdscDBRA3JPpmsl2420Ea2Xx7QzId0APL
	x/NwiJ0r8HmbciHqQivg==
X-Google-Smtp-Source: AGHT+IFyHhiruqCGi2RbQrXtTVcp3oahgZsFHaTw5UBozGNvye3RIxU3ujQdE+d1aHrK4k6SNgCdrw==
X-Received: by 2002:a17:903:2f8a:b0:24a:e25d:c704 with SMTP id d9443c01a7336-24ae25dc9a2mr7167595ad.47.1756695506906;
        Sun, 31 Aug 2025 19:58:26 -0700 (PDT)
Received: from server.. ([103.251.57.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065d1b19sm86681015ad.131.2025.08.31.19.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 19:58:26 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
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
	richard.weiyang@gmail.com,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: Re: [PATCH v2 2/2] selftests: Replace relative includes with non-relative for kselftest.h and kselftest_harness.h
Date: Mon,  1 Sep 2025 08:28:16 +0530
Message-ID: <20250901025816.1729-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831130340.c096ab001dd38bcdb11146b8@linux-foundation.org>
References: <20250831130340.c096ab001dd38bcdb11146b8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Sorry for the trouble caused by this patch. No problem on
dropping the conflicting hunks.

I'll send a follow up patch after 6.17 to cover the missed
conversion sites.

Thanks for your review.

Bala Vignesh

