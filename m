Return-Path: <linux-kselftest+bounces-38534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F51B1E02F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 03:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4211E3B3466
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F61F5F6;
	Fri,  8 Aug 2025 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn/JBiSz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FFB125D6
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754616750; cv=none; b=igzb474FSuvxKIRZAP6WgWGV442sfafpSZQVJujeAYVGx8tVnu7o6rESwz0mVQiZeKY3eabeN3tWK64P/XN+yvTBjUTqZvqJN8hRH9HPF7ilMyOJTTy2V/AH/0Ak0RYCKegxekVwlsic0qhjd7BEjekdUXgBT6X9WtiaC1oG4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754616750; c=relaxed/simple;
	bh=iwCzrtqNMN3EnZP7z/RJvG4L557QEM2U9PixkhKAWNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVJztg5v5eYMRPn5nzXdvsTRhfj80/XIvqVXjIeMEwitoP5OM/I/NbwYg5VQftdvY09bAGnNMt97iRzzNylx+Sl51gmTjGcC9uqVs2/d8ryKjchKkdmnx/5AMG2TJ56xuiItCy323YCdBxZb7o3PxZwm9xVVxSu+HH8qY3Z0yO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn/JBiSz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so1709989a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 18:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754616748; x=1755221548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPzAYDBGZDP00V9twCb7bSKQGnBYbJwPmRh50bme4Ck=;
        b=Nn/JBiSzLYsl++9wJR/uwCJzZzICKXNQ1uvxALHVcmKqqhzMRPFnJqx4oSqD+ZrjrK
         QpdWieF7cy+d+FtiW1WlXaE864RuEdumrGFkW6MMGvgMJ6o7h4uCISI1ae5iDZqwZAEQ
         c5Wk1vUyPGcHChfKbaxKrx2ZXWOb+XXlUiuDdFLQyxFzYAdep+WF78Bip6mL6znh+V0d
         sizgu5OeT+PezG7KOcp9bzHvR46BfLyN8pcoNQfLiH6zeeaIisOlaLNU4oUHo/FJin9R
         XxGusumIGgklBdv22O+uiQCQQKyAzoXuOAA650kRWHsvaaXzYDV+HNnj1NL3Uxh4lVGT
         I/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754616748; x=1755221548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPzAYDBGZDP00V9twCb7bSKQGnBYbJwPmRh50bme4Ck=;
        b=PKyAxJZXkI07OaJM7sJ3kmrCxbyCgvnNZYMG0BHjLvKQrJTc0/UdauYkJ7LIcuCllG
         2ktX0Xz5NrQgvAhxtAQ3xYcXu3+qBBR5kPyGQHS2TcXidZFJhkYwMUfc0cON9DE9HXXy
         9sH1N2htcj7PXSGuQfN4P8mBwnFevJux4E2IyGcVz70ErJdpLq02k3jMQcxrkaZREjqB
         O74+F6bLbOhBgGJXRJP7nDKHjxUABBmfKnHVoJZr/Os7SUErJyEQ3p+lgtlJtaHC8IBe
         L++oVE4sTGa2aQG3WVggudnwFyTOxY4Cmy5kr9dHETV0zRaIYx91+mBiMXzXUoonkmAn
         tObg==
X-Forwarded-Encrypted: i=1; AJvYcCV3IafqPCZzwfjKB/ig2WPLzmO0wmIoyJPucb418nC9qabKEZGkoSEPZXLl5tyez4ZsiiCMnLyPHrbKi7ZIvPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQR1MUNqrjFexMLQJCWU2LwQQiifV4heS+26nPciXzRWTeJFL
	LeWX6qdKAiw3N6LBHrOlh6nCG3LcFu0skwVkrGi3c6AVqYRb/5k8THUn
X-Gm-Gg: ASbGncuFe03aDMd6/9Mb1hIemFzZQEI2V5Pt5IQ7S6V57Cbo+vNitBj+K5ssPHiNr+5
	YZPPv5IzyU8RUjPySUSyh6ymbo0MOGJc1MMXelA6I0kKcr3mcxHLcEXhQy0EzKAxyczoRJfvqjv
	OvnFUQ3x5HmopfFGt3XX8IqfLhhllji9y51ZBLNMHBDyo4FLYyWfDpxt2roC/mVPNcMD8sgiY34
	9XfPY0dvixpjAuRQNwrPBlSn9gQxb3u9gwzA8PuX0jf5Ja3Ff6LHKZiO6Ve8avjoOTc77DYMu8V
	5Rr669iZ5YqrTVjh+W+hbK++ShD3Xvb+KfGVMeyfnDp8gx32ppoKCxfDfK9hVPfPwHLgAPTobAe
	FBpTTQAE=
X-Google-Smtp-Source: AGHT+IE1EqgY5FJCV8+9U1Zp7rvdxKI5+gB9+M0weRjBYKkKGWvez3fPSY7SffW2iDCtvC4FWdW4/A==
X-Received: by 2002:a17:902:d543:b0:240:8c85:4299 with SMTP id d9443c01a7336-242c20aafd9mr17501615ad.17.1754616748511;
        Thu, 07 Aug 2025 18:32:28 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm194543365ad.96.2025.08.07.18.32.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 18:32:28 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: richard.weiyang@gmail.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	dev.jain@arm.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been passed in
Date: Fri,  8 Aug 2025 09:30:56 +0800
Message-Id: <20250808013056.41546-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250807082707.30647-1-richard.weiyang@gmail.com>
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2025/8/8 09:27, Wei Yang wrote:
> Currently it hard coded the number of hugepage to check for
> check_huge_anon(), but we already have the number passed in.
> 
> Do the check based on the number of hugepage passed in is more
> reasonable.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---

Yes. LGTM.
Reviewed-by: wang lian <lianux.mm@gmail.com>

Best regards,
wang lian

