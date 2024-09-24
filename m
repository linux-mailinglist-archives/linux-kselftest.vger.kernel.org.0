Return-Path: <linux-kselftest+bounces-18294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C587B984438
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 13:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC81F222F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4D1A4E9F;
	Tue, 24 Sep 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5i5pQY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941419E98A;
	Tue, 24 Sep 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176174; cv=none; b=n47AqGjC93p5dOKfiWQMG+neCjKA5bNTFbsvqIj8v1R7U0VxFaNfdqM2kWGjs48LYIlMEXNF9DRvdhZGDZ7UA1Bze/9ZECHqJK+TDladSjQkLxURRzexGlIdNh1BCWESiFfz/7j0EkcFZ8dtCyTfIZH4pmF6zMF98OmpkCwC2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176174; c=relaxed/simple;
	bh=C2KsKJ3VaL6KowMsuyZfe6cS0JW8ksINh3HbU6/3l4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNWQT7tl3xHDSt6US/8mIfKlDEM5woB3VFQi8DkjVdSGG4rTZafu6q0U309JU6sOuf+bzfKG//tfq5e+UMbX+CfBtLBkvPU0ZpB+BoCvLnlFQQGyh33R9Rh3nIGozWRQRPzh+z9RjVm5mic7U6eppi9XFkfSnyC1WPu4yZ7spgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5i5pQY9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206b9455460so40923855ad.0;
        Tue, 24 Sep 2024 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727176172; x=1727780972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2KsKJ3VaL6KowMsuyZfe6cS0JW8ksINh3HbU6/3l4o=;
        b=d5i5pQY9atJEjM2B3U0EUV9r8FfczM8dnYAuALHBLERkZsn6RbOQGs8W1auAun/M0p
         wKjvshK/ssYIWtLrO0zI2r74XxjU3qEOLhDFvCUtUtstZstxmzyDXMlctggDjWbG9v9B
         c5WfBVQ0fR4Ne45OLkol+fn1dX1lj5c6BQs5MJgl5fBT+Tp4WERvJ7Xh3dJIJ2XsLLGc
         8+Efn/PQ2AbH8vC6RZ3cbaeroIl7fOghNkF/Cjyqwe2Nuq82JY/g0cfz9FSuJo3PQI4T
         7aCwUI+F73szKCbIM1Rjvb79Rgo2f/VuJnQMt5j5Dvxp9pu5C4XHy16m4Jpw0zChuJqi
         3rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176172; x=1727780972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2KsKJ3VaL6KowMsuyZfe6cS0JW8ksINh3HbU6/3l4o=;
        b=URtJWr8rF2ag2F0+eE8J4SYLvZnSiVQvi4dPe4LkAT7f3EpRypOBfb2/3MNv2jlWu4
         vQjVij/XKL+WbzNXniXDfwWOLiOe5MUUrU8wa5vfZlulIgj4R4Mrv7fZgEGqiWpSTpWp
         85AipDmlyaoRUXQEiT514K42T4IKuzL17OgixHDL6AMQWTp1uvNOwx3hqYyA4qJEMuY2
         LMJdZ+SQew7sEYAOJAAwoMzm0iuC1MLpCBqiN63dwAr+yyaLOBIKrBlxCMwKDe3HyZQR
         wRzR7AID/1sI395kPq/4EdYd89XsxJXHwOGibra33etDLaZ7U6s1QC/onT0v6tOrxkWY
         pHFg==
X-Forwarded-Encrypted: i=1; AJvYcCUF5WUpF08TFg4pTFHkjbYEp8IrOu4alogn6FSiJzZrbB0ig5b0bW1BXSQgF95/5i8ksf1uyKk0W0/u5qrA@vger.kernel.org, AJvYcCV+Zk8kp/b+BkqYPoFHThy9oKJKZmLAw3ELuSGE7RD14t7a57Em8EpimWYDrED4mi3JTnM=@vger.kernel.org, AJvYcCXey52aawInweXKW9W16qoWyF3YNpy/I0ZlhWkzAfgBdTt0+KIUI4jmTv0TUnuR+ADqsEtYzn6DKPzxgdg81rOD@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcjsTjZLy7aJYoEKv6mBvxfe1U8SicQ0KbYN1t7L/5Rdlf+jX
	OuBGUZ6Qfmsrxq8jatFACTDlcb8ROCo0q3KwaM7amiBu3v34ybRYRFhvVy26
X-Google-Smtp-Source: AGHT+IGQq7X7HpuEbTOkrYYaoD11F1CKrWkGCj4fLeKD+7f3XfOb82rNHyRUHVh8KI7/32lG7s/rmg==
X-Received: by 2002:a17:902:cecb:b0:206:9dfb:3e9e with SMTP id d9443c01a7336-20aed09feeamr42684295ad.10.1727176172141;
        Tue, 24 Sep 2024 04:09:32 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1851f88sm8584975ad.242.2024.09.24.04.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 04:09:31 -0700 (PDT)
Message-ID: <df4f18a91ae9bf016a569fe65ad5a164541345ab.camel@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add missing va_end.
From: Eduard Zingerman <eddyz87@gmail.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, andrii@kernel.org
Cc: shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 04:09:27 -0700
In-Reply-To: <20240924045534.8672-1-zhangjiao2@cmss.chinamobile.com>
References: <20240924045534.8672-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 12:55 +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>=20
> There is no va_end after va_copy, just add it.
>=20
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---

My bad, thank you for fixing this.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


