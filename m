Return-Path: <linux-kselftest+bounces-35678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3FAE62D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0477017BA75
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED51285CAC;
	Tue, 24 Jun 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8beRxSP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326A283CA0;
	Tue, 24 Jun 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762032; cv=none; b=sn02BOuYrpMiRp4fNaFeT0lN875H8sM9bLjzkMIe9bkqUJSYyDDrsxsygNBRrcdAk0j/8gmc9a08WtqEcaaGiFNFSDrclH3BrA3cbUq4amEoyz6UJMotuwdBOgDiCY1FJWmnh45m8KapKMuZy2Zxl1RVIuPbknzY3pf5JTVMqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762032; c=relaxed/simple;
	bh=q9YNLRyxz8U7WyFP8P37wvG+tQymx7Vu2sHvl8qoV8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO+4GxrBcy4eo0Uhoj9zvB9vltYbUH4SWVpv8S6TFUaQi9rBauhOgtw0KBPX7qQfOA7hF0t5HL2P9SulQ8sg7Y3b82dSHO9hLEiV6P0jPLnSsO9V++xLSOfxINFuTU5FMFcx8w0a9Sq+2wnGzDSdo+ShJf6FDgRVUqvYwxXDZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8beRxSP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234bfe37cccso3195515ad.0;
        Tue, 24 Jun 2025 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750762030; x=1751366830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9YNLRyxz8U7WyFP8P37wvG+tQymx7Vu2sHvl8qoV8A=;
        b=E8beRxSPQ6d2P9yLyUkbMginVI2cNla0l72mrBuipYASdmVRhYAar5NyyFi4xm1+BY
         EI37OHtbXETIa7oQ8PK1at4mDQPjlWFAL3/a7TqlyAn6Xz2uSv1RQD8/o+KJt3Iilbix
         Q4DVyKdaZTBmQiAxC3fj0J4aME5jmTbxrGb72OXyIIcDx2GrljvT3yMq1arNhZQsFh9K
         jadIUczfObseyY0ggoKiBqd6OGMpOE2ilnDmCufoG0sj/ayZ0RJYPZu5tIJ152Xv9El8
         1dHD+QAWenhnZL10PsMX1sNIwwL1yKwivXE+Cp08ZZljSgnkTzDkkuZ1pa8qHnKl9nCZ
         OmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762030; x=1751366830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9YNLRyxz8U7WyFP8P37wvG+tQymx7Vu2sHvl8qoV8A=;
        b=fGe/QbB9srdX9D0RG2XoNZb0+j9XfJN21TDqDvzitd/vYf0CHR9z/XOiqlV1aoSjRx
         KPVU84PgF7MDNJPKZ2b853mfU25GPooGl9+xeDwCxOv1WODkIa13jO4t7O7+wrE5dqsP
         7HHz6pMV9c8sgdBufy21/J+yDG3qzskoVFTL/NaHEmFEdyrHhG8kLknLl1my3nLfBaxo
         XfbPNTjSUNaZwkAqbVMnY/u2frRUbcxERZbIz1tjFO8ibDyaP8adpuCDHYD1OT1zQ+pu
         jwegR9L135WA4cn9gsOf3KJyaKHcRS8ziTEOset93wGzLWhTeR11dWjtgQJSfH8rwLOo
         fLjA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFjFbyH5+B4bUK/Qzf9t+e9DkURSp2vxX79zjWOtteSrxJQylimS/3rA7pXm7mnL9AsG5fttl2m61Pv4=@vger.kernel.org, AJvYcCUiW+Ah6bkkjsbXCbG33VnYDMFb2z9fCiIsDrtIddv/l4hC+Fjdi/dyKl3cKmwKTR9L67a/pUTKbJaasoMaDCWl@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyG+U7wR9qQcUZcecazrvtwBcD4F6KDsznKiQftEUHw1A01gQ
	+IUdz6EzINkwiaML1s7rTGQzMtD+aScOaqPbYx+kkzq0jfae2iv8NApc
X-Gm-Gg: ASbGncvSJ8OS3u7+yK4gIUNqvT8T+qcwhsU+PEz5nNfE8BHYvnP8k4oJzQ34O0NX2Oi
	ezhcQ94xpHS0KhGvrDqYVxw+sfbGdWZAV3KtbGGilqJhldhHoJSuB7RdCqMYhDt+nB90EhWDlJr
	gsG0bULzRdchkarSSzeWIFIZwc1bwBIkGMdEx3fg1NecCr3YEAzeIC0UAjG534ykkZLey+FchFa
	SXlw5X1GEZertsW8bcKkYR7Z04QZadkFjl0HAh7UuZLU79vjPuYofjurJFI6RBbQgnsOLc72wi1
	TGdwW22BmzyVY/VnpPWuKWou2UJWaV5D9S9VObkUdcumFN/yb1hEs5pV3VxqkHbwLBUGYNtPgx7
	NJzoN5A==
X-Google-Smtp-Source: AGHT+IEAuZlnLUM/Oq3ydavrFM6HAFPj4rQDIaVo8ArRUvugCEeLHAbS8fik1d5nYG9tGqisHGfz/g==
X-Received: by 2002:a17:902:e54a:b0:234:f6ba:e681 with SMTP id d9443c01a7336-237d97628bfmr283468345ad.5.1750762030536;
        Tue, 24 Jun 2025 03:47:10 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([111.202.167.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860fb58sm102904785ad.99.2025.06.24.03.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 03:47:10 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: Re: [PATCH] selftests: add basic test for MADV_POPULATE_(READ|WRITE)
Date: Tue, 24 Jun 2025 18:46:54 +0800
Message-ID: <20250624104654.4418-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4af59ef8-bbea-48f7-a207-8a92284fc34d@lucifer.local>
References: <4af59ef8-bbea-48f7-a207-8a92284fc34d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 24, 2025 at 00:00:00 +0000, Lorenzo Stoakes wrote:
> Sorry if it seemed harsh, I appreciate the first patch can be difficult
> (I still remember mine!) but hopefully it's clear the focus is on
> getting things right technically and this is all :)
>
> Overall I think something more like a generalised test of
> process_madvise() behaviour would be most valuable, as David suggested?

Thank you for your helpful and constructive feedback.

I understand that getting things right technically is critical, and I
really appreciate your guidance and encouragement as I work on my
first patch.

I will revise the patch based on the suggestion to generalize the test
for `process_madvise()` behavior, as David proposed.

Thanks again to everyone for the insightful comments and support!

Best regards,
wang lian


