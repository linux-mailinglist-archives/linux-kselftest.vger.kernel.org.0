Return-Path: <linux-kselftest+bounces-40404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B53B3DC0B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A01F3A1F59
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC82EE607;
	Mon,  1 Sep 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5dFWRed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E32EE5FC
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714281; cv=none; b=aU22ubPVYDHHG1ri9xJaLi8mKQr9xI+VuNpQOa5pMw7FjwwjbK9J2dJ250VJNBwJPpmOoHIATz+81eCilJLUPrN5sml0A/6CX06ZCfFafN2sozduXLBGj1N2FDX+DM7yt9OmxUljFb23bhVF8oQrwGxAK7BvtAXL7YXQkDtqUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714281; c=relaxed/simple;
	bh=Q5AGi7XhHW8VnKM63g6aNYwYi47i9z0v6I4c1IVd4yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2NAgmWjSSq7N7BuPnF5/OkFO19tw2ry5RezokTNFpbhJ4OGgzNmWwum/Rhz8pstJV6ZsDIMkduhdlSaJ6Yc/Lwb5k32QJ5NcWobuL52Omb4CWMR8eTC5OUmnrJc7VMpvxC63uqRE5qBJ83kQTW4r8pbcs1xW/soIbt42enuvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5dFWRed; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso2581951a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756714279; x=1757319079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5AGi7XhHW8VnKM63g6aNYwYi47i9z0v6I4c1IVd4yQ=;
        b=Y5dFWRed2teiGvFIGXAiK8/hwzOX7htLxnuZaETsZX+ud6snUit+JJlq5tb5WBGs9b
         QwKljFf5IBJEyacgFX1Oz/t/59QIc/z+hcIArgQXStvIebLGAjzgMFm3ya8IIKJgSj4D
         pp/nA35WEM6MlbiRYlIjeOnu9Y3ozzuR1VSH0s0YUuzO7DCDGSd5xhcCt9CqOLmvkZtj
         P251a+8yaDVN2kfg/EKMqx7ifdvxviVX9K/f8hab1ScJFgzqEveNskqX0l+z3jr0vY8E
         qjc0Sd7AikWLRqVsctZJVHP5oYEDnQOLgm2+8btaDyoR2aJ/NdyTWIWRP0XFZNxmPB4M
         MOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714279; x=1757319079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5AGi7XhHW8VnKM63g6aNYwYi47i9z0v6I4c1IVd4yQ=;
        b=xK5MdFoAEQs6DX28yVTv6H+4mpzvS6Z/BU9/is1Q7iJKIYQoR6p/NR3Q1IVswVDUOi
         glBLaZliTzkU4QbRJC6uU3m0ZnGAa2dAOu7monsEQFqUBqqq4unDtKyYipIC+0L4KA3k
         VXlbRHQI+M75328d6oaz1tR2k2ekBJAIzdu1685GENsgbr6UXDSg2ncuufXgJuFm7Vca
         UYVEnYwxYMBupdFiptJjDjSsTcB9pkGyyMO2sDZ+c7RE/0nNJS9Q3XVx6lEIhxrz4bdl
         zjGNoB/livwbILrypPe4gtQwjUPoFF18/MrL/mOsnVVMIhlIa0tnADroO9PT8sxQdK68
         +I1w==
X-Forwarded-Encrypted: i=1; AJvYcCW56GZPbiw5Gc3bVNZqx7xgl/H4krGd00G+5ufEC32oRKzJjK+JNScjCKiOKwveVeI9BSzB/g4d5Cqyx1p+TFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1aswR5a2uGYfjzvdiHfIKQA+P0qIEpw/YQfglbKwEiAAcx5R
	HqJ3oeW9ZE2evhc8XsKQQcY1e2pupkbABtWix6wdgXQ9nVRTAfPirG7i4IVMTgU6yTE=
X-Gm-Gg: ASbGncvyfjGRqzaPRuBqiEHkNLi4HEia3wh5mr1l6g5GKpcd3zojFzmDWrPyxG8v0Mh
	EonSsZsCUiTs/ZIWtGScQWOjdsPRtXju6eDJSpCpMacNI+F+syZQS2q+SWwoHwsHcVpGPYbVaNR
	sm4rD6vwFtN7c1hZtj+TrrADn8M6NMwt3mM4i6pDK9TYaxSdUqvDQU74JaaI+o9kE+Dt4a1oZk4
	PJvrOZaFcoe/MUEdYvDokC/pDAApwWYK81q1g7oOuf781ZpLmhjH82bzUm6XaQK0UHlxmcXkvId
	iCg7n/bfsugH7/OX6HP0PbbCZls8gRSUXFjD+nP4N4ANWnaOOf5wtoxJ0bZW2Y6Ju+gJXbiyzds
	UmMkim25OTs52TjlOoUXyXwK8MxOfUZIZ8Azf1xKHl5waICnynI0gA14=
X-Google-Smtp-Source: AGHT+IHcj/FAbK4A4O/d8fkw6kgGd+jXx4cMW2UIpuOeyQbupm50HFzGMJ0DQuzjVNTanV7t9zNREw==
X-Received: by 2002:a17:902:ce04:b0:24a:ad8a:81cf with SMTP id d9443c01a7336-24aad8a859dmr53063615ad.50.1756714278684;
        Mon, 01 Sep 2025 01:11:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:9ae:9b62:915a:9b08:d9c0:516d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249063961desm97322825ad.103.2025.09.01.01.11.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 01:11:18 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	richard.weiyang@gmail.com,
	ziy@nvidia.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap corrupt data
Date: Mon,  1 Sep 2025 16:11:09 +0800
Message-Id: <20250901081109.52460-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
References: <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


>I'm confused, don't we have that exact check later in the function?

> Your v1 might have been better, unless I am missing something.

Hi David,

Perhaps you missed this in the v1 feedback:
https://lore.kernel.org/linux-mm/E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com/ ?

Best regards,
wang lian

