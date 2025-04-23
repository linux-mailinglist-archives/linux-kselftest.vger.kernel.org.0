Return-Path: <linux-kselftest+bounces-31438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11EA99749
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D23A7B3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0BE28CF62;
	Wed, 23 Apr 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTWm+xoq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67041C69;
	Wed, 23 Apr 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431110; cv=none; b=dXiPJWeKSHMDRUazcFU22YlsdKVubeFtRg339CMA16CLyiNU7bmzkeeWG0/SwviDXXDYPkjTzLzOoAZlYVcJuXtPg3gAYjlIGT/J9CoIUehm4OoJ6K5HwLn4CvhaqDoVQCrfu6xrNO9sd0E/QI1n1PAHmPbqd1FqHjFW7qMwNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431110; c=relaxed/simple;
	bh=n8yECHIKn8yVX6a3GHWM1uCLevpPfZKJp8WUnunLZuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy8y2+DoZ0FZOcDgoheu9KmBuH6Kzcr0+Ro+giaBIGmUoGTQ8BR/CBpG/YdP3X8NmgSpmf0RWIR4Hb37Um3MJkruCbCqJ1QIgPlq4MjrVkkhTq6PQU1haPrLB2WFPwQ/jlnpsFmUqmYvr3J6BSfqrADlVvyJEJqiacUtTNRzj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTWm+xoq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22435603572so1613495ad.1;
        Wed, 23 Apr 2025 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745431109; x=1746035909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8yECHIKn8yVX6a3GHWM1uCLevpPfZKJp8WUnunLZuI=;
        b=PTWm+xoq41UOH9bI5UTwD60mGWj8wX7aO+xu0X1L7cCMbHKUiTmm/ay5ZsjiDrVlmJ
         b3O6HgBUABBU++djLZ/n+RS8WST+a77e0vPvKeOMrfih0CwLpwU/O1M29YbKl5pgY+Of
         H+w7QY7e+PLLqFoCsQEp1UmC5INyUt70BOYbxpNi+yj0xYtY+DtRNmlWiq3CuCWebocT
         ILHziHPqFSh6hCwzkDWMd7L4gFZCY6NwJGzZgcO0ig4pPcu43h2KO6dLKXO4lUWTp/2m
         43F79Pr+bfv+Vmk2IozAytftGNo3N/nrSIBPVJ1vxM0pQXJCv9H7WyVLCwDYb63IOWCH
         XA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431109; x=1746035909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8yECHIKn8yVX6a3GHWM1uCLevpPfZKJp8WUnunLZuI=;
        b=bGw9sOLsSsfcTJa3RMOXeqswkjdMQ5n41Bz5XTC4Cj3ygDue4WukEQjiK2HnK7s/pO
         J4+VZO3+xLnr1edjT0EyuGmIrtEQEtXeRgHWlDr0fJB2F2QUcJ5d5VyiDcnA2aYaIDoo
         vj55aSb4GInepAH/b8FBLYlQ8rWeOXMzzGUmp3xjVRxdWUMKQfIXdpnavAxhHCJoodeR
         R88QgQTV+CNLkwT4mlF0hbKRAoAlG5tjXrht1z7aRd5vKfAKORTwfbW9b4S7aLjbyRm2
         9ohXerjz79DcLzH2YjnKlNep9B1BfAsuygLsXlumlWi9PU8tVREZ/931Yv9Vs4MyAjCt
         W3HA==
X-Forwarded-Encrypted: i=1; AJvYcCU4PSrwX0YzDcO7mJRt1gwYKhI4yRMLNiepz59aq+BGWwxqdIr7nQYGvQGYk7tifc4ugNU5EJXGgVvWz/y+@vger.kernel.org, AJvYcCWSWq3ZGEGCPxhmyYbn6z8XW7BiSfmnIyQOXVxjgEH+zv4WxykT5vHv9nXzByqjNH2+B7nxXnDmUG1P8gXldh++@vger.kernel.org, AJvYcCXIGefua2yCuw9EmJ17tTBvx0LHLLekJEPWwTJyZvCGVLMYAHxXx2icJcG2oGFwRJ/JcpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxJJt7I9V9rPK/a7NHoWBzQCzx0cEKiIJ4p/Y5YcE7fUDivx0
	SvAEamhCF2mpHNdl5YP62AU3m0uT9AxC03QOxGcC1ZJkXxuEUYKV
X-Gm-Gg: ASbGnctKi8Qj2ozRa2HUxVwbmnTnjpwDd09HnY2mAdsWDS7sjW7pA1ok/LwlGaKFurC
	Sbgv85qQtqhqdeEmBzJyM6BnvU4P1E8WCopb7SMIujSw2ZXQOMtcG+P9XJUz/c3x+jFPA/fvqxA
	8EyZ+OZj+xTxU1PWg8+ZjrIB7KYoAOm/v1gFj8Ftoy7JlM8G0b81VmlJ/Z7tfH8QUXEV7qfZWlS
	Br6vVRcI4WfrW0gCOeIYky8IqnxlAtGB7NnDnYbS5WrQjSHc50n2VIHo2nJInd4Ptli1tyHtGiy
	KIHnhs/7sa4/IYAtnDkQR+SMHS1QSpEmvcrwG8FNLLI=
X-Google-Smtp-Source: AGHT+IG4CA1htCgHu1Hm2Mfkm0GaZN6lb8+ytF7ev8DwGyZF7LxdAhTv4nfu1t+Sq9O6JVmd3o2RXg==
X-Received: by 2002:a17:903:2410:b0:224:3c9:19ae with SMTP id d9443c01a7336-22c53601521mr337572005ad.34.1745431108499;
        Wed, 23 Apr 2025 10:58:28 -0700 (PDT)
Received: from prabhav.. ([115.99.163.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bd9949sm107650295ad.10.2025.04.23.10.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:58:27 -0700 (PDT)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mykolal@fb.com,
	pvkumar5749404@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH] selftests/bpf: Fix potential null pointer dereference in skb_pkt_end.c
Date: Wed, 23 Apr 2025 23:28:14 +0530
Message-Id: <20250423175814.1273032-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e7ee365f-f275-4ee0-80fb-370cb3c242ea@linux.dev>
References: <e7ee365f-f275-4ee0-80fb-370cb3c242ea@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Prabhav Kumar <pvkumar5749404@gmail.com>

Hi Martin,
Thank you for the feedback.

You're right — I reviewed commit 9cc873e85800 and now understand that the test is designed to validate specific LLVM code generation, not just runtime behavior. I see how my change, although addressing the warning, could unintentionally alter the generated instructions and defeat the purpose of the test.

I'll drop this patch to preserve the original test intent. Thanks again for the context!

Best Regards,
Prabhav

