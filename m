Return-Path: <linux-kselftest+bounces-41310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BABB54996
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C738817A465
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701562E283E;
	Fri, 12 Sep 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JGg5hMTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3372472B5;
	Fri, 12 Sep 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672487; cv=none; b=hLMw3MWZm7S3vAe5X8Yu3iMpw7oHWxxsaVIJ5XqlkKnpu9JwxK489k8QSeEG7pSGqckQvkqLu5vl/chcE18+Upsf5jwcRFZbwkSFM0Holf+Gtdp8ZzSMNMLvYnq1145OSBujjGkKJ4pw3Orhh94KHFugLzGSPJocjP/lBFLbCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672487; c=relaxed/simple;
	bh=y6Mx8UxMbmbhKuu0xbpWx6yCgJ80CG76KHVXxl4xPyo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ESGy1diq9CzpR4uvdiJgr0AopSuCnScLKI+SQwxDVIndDueTnCwMldDcJBO7R950U5cIYp/6DW8nju8ItGmZ3S0k038zI3ztm+NVI0rplhR0Llf6wAHBlcNcVJcEsRCTs8cc85gywLVWir0hkU/zj+Q+egFjKyTSOhyYfP4LHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JGg5hMTK; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757672174; bh=7d6nPhgsu42OQ/nG1elx4UhCIT4hBtFOXQ5i6Y/4Ii4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JGg5hMTKNkjNwRGosP9a7CSFOu3VBAjKbx/AoiTl1YInuPl0VxQgaJIrvqhuwz9ik
	 TWea1vlIfhKcWtYhIpS8GMx2e+75lwv/VpZjXwJreQjEC05XnUxZmXKFERWzuHc89O
	 gZSZelB/hagMDlf5lkrZ5uQXA+QUq0+jOqseD5Nw=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 28731C2C; Fri, 12 Sep 2025 18:10:07 +0800
X-QQ-mid: xmsmtpt1757671807t8ir1jn0w
Message-ID: <tencent_43768D3DB24034B62C249781C1DE7359C807@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSLjraKA0cvy+V5eHHSDp3c3cSlTTIdWJ8tEKnd72RcZdPrdHryB
	 z1E+nv8urYdwczLXbZDt0oaAJvHuoUg56eSW5gjSCdRLAagHinVGQeHfJsQkC+gthvRidb6j5llO
	 c93iG61cGynfhWo3BTgXtcaJEIBYpmBElsOAZMJ0STbc18AUq+WJ5d09h/8qTONpt1H+yHRUMbR9
	 KhewYMsCsljKip+Or1hhf/ufGfuI57MIU+Tp2mg+1XS59DeQKd+ytdxkSUa5Gsifs23SrwmEZkYD
	 l4udximR2n7lR20ggueqeKZfIF4UxAN5Dk2dQrjtel5muuxwNY/RJERqMzQLtq3MiLaXcabkQBYx
	 mmPE7Dcft5ZnFULTVPLv3wma5ZTJLjKtMAQmb4EPnwUES4n4VHE4YMqveVaZYzjPYXMuHGprmRbD
	 bhJM7TDS6PW/lze2nIz2wpKsRAhREwBMAN0zMCj8wflDzPQzChvrTwKGxNJ/IS7XT0MKjISw0tw4
	 ChZUMe5ssepYVl+ZSQvinsyV6M/w8dXjTSv3B7xXNtlJA2+98nKfMwqpRZ9QidB8jpiRSvxISMfp
	 CPqfz02OlrGJ03ZIfNYWjTF3ckNn7yZzYrkRekPeMBZpCX9D0IZXT8divmThDjHpULHp28GCAE4Y
	 86ujWPwHTYy3Fr80KSFuYR3yGtds9OgsUXEmIz0q9PFeJFrdW0t15XCsKRJBbKtptSJPi9VXYGC6
	 +l47rv0/IcHfyY6bA3RybC+QP7jAxXheS/0DMLyWrGz+p8gkKDpVNchoCkivZg85qb5A2fuVGqnj
	 /zkkAN6UGuYEVZHv7no24xawc7QvIn0Fc9rsBHCwlbIPPmeoSpTyYasVMTDuXCFIQvnVTtfcQmDZ
	 ISn3yXdWGvUzt7BhjYg4JTgNLQ4s8V1mX5l64tbdqtc5Xp6Bd/MLqJZT0HjbsmLfK+IaUAdPNIQz
	 MmIwz3eBwg5XVzsLQRC+W/eHiG/a7ewU4vOH/hcPUZJeiDFpKWqs40qou5YAbmhj0pcuzrYIHtWU
	 AERgm0xZLf7ipyv6a1pXjZEyGi/sE=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Haofeng Li <920484857@qq.com>
To: david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>
Cc: 13266079573@163.com,
	920484857@qq.com,
	lihaofeng@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com
Subject: Re: [PATCH] mm: transhuge-stress: fix potential memory leak on realloc failure
Date: Fri, 12 Sep 2025 18:10:05 +0800
X-OQ-MSGID: <20250912101005.1980065-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b6f38984-5f89-4a9d-a905-ddcdbd7510a3@redhat.com> 
References: <b6f38984-5f89-4a9d-a905-ddcdbd7510a3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>
>What do you think happens when a process exits? :)

>Correct! All memory ever allocated to that process gets freed, avoiding 
>any memory leaks.

Thanks for pointing this out. You are absolutely correct that the operating system will reclaim all allocated memory when a process exits, so there is no persistent memory leak in this specific scenario.

I opted to add explicit memory freeing in the error path primarily as a practice for better long-term maintainability:

It ensures correctness if the code structure changes in the future (e.g., becomes part of a longer-running routine).

It maintains consistency with other error paths in the codebase.

It prevents false positives from static analysis tools (like valgrind).

I'm happy to adjust it if you still think it's preferable to remove the free() in this context.

Best regards,
	Haofeng Li


