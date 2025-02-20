Return-Path: <linux-kselftest+bounces-27076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B593A3DDB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306303B2142
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17C20C00C;
	Thu, 20 Feb 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ilp8yF2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A94204F95
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063832; cv=none; b=SvOVhyUMVg+AxaPfXNRr3jnQm6CbngT33e5+ZRiNTny2lZDI+zqO+7r503wrITzuqeBFV0mkj6I6Z7+CtvSdGTLoEHiDu89e52ORZ2kXr6VhNxO+9aIlQqQLAz5l3h+n9HowWV7TwdJU9NwUND1QOm4YrcFv80AZj1bEP/F2zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063832; c=relaxed/simple;
	bh=6us0OPPk/bMiyXUbfdqsVWAztptDhX3dd4CerV72Gpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YfNOVX6yNyI0howwy42BxsAhLJX40I++Pj3SlSYqdjaAS8ro3MGsA1zT8gwPD45XUwKSgoDJY9a8FYOSGyELI/jEotoq+Gys/uimdQ7XfErKVTTKNkHpw16PF1pche7ORnzoYjog8WZsHzsB4pXqh4g4zAUB5pmKo0sBunw1vBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ilp8yF2m; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-439385b08d1so6851235e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063828; x=1740668628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5anIIX08DH7I1Pe1I+Cw11KP1w7s/U6PELcC7zyacQ=;
        b=Ilp8yF2mhlguBz/pE42gDVU1Yv/8+JSRN4l1WY/AAnGP4Zvv9c6sVxXWZh7iTWc8tU
         BP8ZaZYjDnamyCYu4jDggFLG9NR3oCX8gGbubvw95jehcPWodq7by1FFqhP1OeZsc4Fk
         md20EeZ1XdzV/tIakH6kWPPFyzxkH81I2DVU3DLBYCHyP/XBDB4/yU/iWqsWGLDLbHHH
         RmuyZFXDSR5M5KAZudeNQ1uMhRaE0P3OulnLdIWCLRKW6ZrDvYDesGEtmkmdjK6fepad
         oMCtXnFQFeN3MDpCmuHtdYal4irDfMDWGx7/nIehKlFLlJ9I6/GqDI/KQ1JhQb+oHnz5
         FpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063828; x=1740668628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5anIIX08DH7I1Pe1I+Cw11KP1w7s/U6PELcC7zyacQ=;
        b=NhR2ftzeTqWyGDscQHWEBRjdL/OHpQKQVi3FkXGc3EBvoGCRzYIvHX2OuSVNJzLQ6B
         +GtO6BN2gNPDkBQpGUflCmWRGqlmeVbGPiWJZZ/OdA8Ca3ItnIWlT+dAlUmSvTL6luo0
         zZc+6st629wnz5esjczIc7/Q0eAOa13whhDGT9eTnqc0lxtxC7wrCgwcBd3FwzZcAQ3N
         LcgShjx7BLTbgq51/+JVeETTv1As30cNNWGslSqmSgCMfnnlqS2iX48tOzfSaXE7uEa/
         4tU4a8M+WZSlqIhndXNP+bHpe11IzytiiNuWyVPO2YZqtHtvPNwT0+oG4/uhSmqhrCCW
         fi+g==
X-Forwarded-Encrypted: i=1; AJvYcCUgKWPpv70PE+igTDDdeDEY+xStepruXIkploSaxBJuCaZG5YS5fMCT9eig8RDmFaglP2/MevAt1ErA6ru0awA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2aP8lV7Zw9lYwS/2iXrB4UkWAOX8QmExoL6nw1J0SNgMVaMdh
	CkAaZY7h0PldZ+9KHNdi2g9MWB5eEW7TA9HomcAXFikWTy+5NZA0it0aYTWYCLW0ST5VHd9xRpG
	KGP2v9Raehg==
X-Google-Smtp-Source: AGHT+IGIpi/Y/94IOaJbe0uGO6m//Yh2Wsky4Ip3Q/V6kyqLVCBH3J882rU0thH0J4Ub/her4q4G/B/xr6R6VQ==
X-Received: from wmbfk5.prod.google.com ([2002:a05:600c:cc5:b0:439:89d1:bf88])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b26:b0:439:985b:17d6 with SMTP id 5b1f17b1804b1-43999ddaa0bmr75459345e9.27.1740063828632;
 Thu, 20 Feb 2025 07:03:48 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:17 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-5-9bbf57d64463@google.com>
Subject: [PATCH 5/6] selftests/mm: Print some details when uffd-stress gets
 bad params
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

So this can be debugged more easily.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index db5366b4766e5bfa2d1150d2f3c2d32469a6e28b..1facfb79e09aa4113e344d7d90dec06a37264058 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -456,7 +456,8 @@ int main(int argc, char **argv)
 
 	nr_pages_per_cpu = bytes / page_size / nr_cpus;
 	if (!nr_pages_per_cpu) {
-		_err("invalid MiB");
+		_err("invalid MiB %lu (%lu / %lu / %lu)",
+			nr_pages_per_cpu, bytes, page_size, nr_cpus);
 		usage();
 	}
 

-- 
2.48.1.601.g30ceb7b040-goog


