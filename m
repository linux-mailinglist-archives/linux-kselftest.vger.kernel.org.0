Return-Path: <linux-kselftest+bounces-40385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB9B3D68C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 04:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D85C172355
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E2620B80D;
	Mon,  1 Sep 2025 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UExxoy/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EF207A32
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692549; cv=none; b=KL95mxO8xAJN4azwYM0gk0UkOWQxJip8F0NVi4c94oEHZu9KdfsBr88KDomUTAiSSMnmRZsHbvu1RLjR09VbGIHxrt8nDNR0kv5mmT02NV18zkX+ZEnOyIRklLGM6goRQNVDqQflP4/mwz7iiULO44nbLNhJfqw+B59QjIbJxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692549; c=relaxed/simple;
	bh=ucEctInuZvUNa3JvowQkVMa4HblV4+0edJR4XUz791U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ym2qXUjkVZVnIrMwuCJh9XjHL8ot7wqwfN0NRL1lzacyACxArfOaXVXvaYPC8x2dx4P5O26KivkZR6DB7glDpzdTjVsMA0N7c7v8TtY28fT0TdnegYuU6NDv16uae1LOLUmGez8ccI0j63Z5vHhexV7Zp6z06YI/WTz6RimH/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UExxoy/8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-327f8726b95so2084508a91.0
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Aug 2025 19:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756692547; x=1757297347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucEctInuZvUNa3JvowQkVMa4HblV4+0edJR4XUz791U=;
        b=UExxoy/8WZj2fR9bU+A+GNqM53oB6pMrmA9J05Q9TCUQ77ZmLqmLQ1bhkbx5m5WlvJ
         0u6PBDz70Ng+48pMREYrw9IU4tNz5UgCyChn8QW4kgRUje5+70S5dprFJCaTo5ww495u
         79YetEgth+hYnMdTVBR2UzgEmNE8J02t2cm8VUhYBZevM+IMRO+hsj8QIFpdfQwBkU70
         7oO/b/Cp8nK29l1niaeRfBttIpOqWYo8dA+WTdF/KveTJDPsCpBCLKHip5LrlTnmIhvg
         E08YrXfu5Tin/N3/bX5aywFm4IbB71TtAwjjNatp5EAIJP2yVzcq8dYdBox08T/XmYDd
         qSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692547; x=1757297347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucEctInuZvUNa3JvowQkVMa4HblV4+0edJR4XUz791U=;
        b=hFjsfQFZULSv4U2tfBL5iosSJwHOusWXOj8E6/Gqje5Zhe/w7SmP5t1zIuELSCU/wy
         iSsNlqTI2chqiEB3MHpei3RZ35dbyFVOFy/rgPQn7FU82j4DR0EzjvvhJOrtwrzrCjJx
         /jBddT4gRbcPNyDTp64BvszR+xLk/IZOVvpfscgBysSb1DBefShjBG+V/VTh7EszF8Os
         Q7cEUR7kIbgKJQ5KrI3Q3598FEPrWAs5gqHxWgmzMRTBH7mKbC1FRVJxjbaonNx+OIO3
         D7B3r45AdeORxpxnSUFQj8xNaF3DO8ARPpsRYLQGbUfig5tOwixexT5K0X2BEH27xZ+Z
         qeJw==
X-Forwarded-Encrypted: i=1; AJvYcCURBd4n/gWPeRPEKDE/5uGBu3zrnv5+NjFI8FqrSUiAnoQquVWhHMV6+/jOBaSJZY1DUawmLYeR/8LAaLmqWW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4R+RDCYUavN1HZZP/MvTQGy29mIbYp5lWHm0ZfV1nQu8/rHv
	dmpCaQGUUUs5zMQoU2mUtzy+vlJ+vC9OghNLR+dHGSU5aXKAmvpIOYXRJW1pGk5UHp4=
X-Gm-Gg: ASbGncv+/VaE7rXJ/ATsjnN4ur2Hn6mAlZUSCHO8G9uTZurT1aYhObM8MTcaFv0m88A
	EfEGeaEDFS4uTfzxTNdkehDfeqwmC9oL6oLEFls5Nu5gjSi9CFPk6G1zCibeq9GDZpjyeDVQ2Md
	OWPFdISqrf6Vce/pi72XyuYMwkhQt9siro1/AMSUyTNWOt1moNiWh4DYYWnMz97DiCXK7IakEnr
	9NGd0x5sdC33lWhlblpQBbwBgJbF/dVkK43IYUDxUFF/loPahNJJgNgBL/CDDUlvWmro+xH3CDy
	2kluHdAxrhKIRwM9xxit8CQimNnreZfkpn8W+sQWCgcfKHum6v7jK07drag8Zp6IS4vpU0Yc174
	e3iOuobsgUVw9pjo7uCtslZNj9e64yWvX9pG76c1+0KtW83ykJ6TbkPxPTgzpC8u3T8rFgw==
X-Google-Smtp-Source: AGHT+IGbZ6VmOvpDlTVFv+9h7OOgKudwCo2hDyGM86h5YZJ/r2KjDGMa80yS4pSyRQ55qeRqP1kbTA==
X-Received: by 2002:a17:90b:1e0f:b0:31f:14b:f397 with SMTP id 98e67ed59e1d1-3281541407emr8547594a91.1.1756692547177;
        Sun, 31 Aug 2025 19:09:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:3fe:4a4:e96c:b5d6:3ed4:22b6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm9392312a91.0.2025.08.31.19.09.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 31 Aug 2025 19:09:06 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: richard.weiyang@gmail.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap corrupt data
Date: Mon,  1 Sep 2025 10:08:55 +0800
Message-Id: <20250901020855.47218-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250831022701.2595-1-richard.weiyang@gmail.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> After mremap(), add a check on content to see whether mremap corrupt
> data.

LGTM.
Reviewed-by: wang lian <lianux.mm@gmail.com>

Best regards,
wang lian

