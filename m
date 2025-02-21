Return-Path: <linux-kselftest+bounces-27217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED770A3FECE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9721E3A7DDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0A253F3D;
	Fri, 21 Feb 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAHLTkYj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA84253F22
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162366; cv=none; b=FekDWHy6ARuyD5O7gtspdteN6qA6FDi7ELuz3xUBwQ9eyb5M9BZvdz/4R9X9+Z8LFzx/2VKEGKNxrJpMzg7CRzJWecnooaYpP7eCo8iS6spQCy8CECOH8wdq9mMHHi05UgSk32OZ64BMbnJxvQoeUQLuSg2M0+eKDOMKF01dlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162366; c=relaxed/simple;
	bh=0VVzpjNfd+6snGR0TjzfQ8zQNDKzei8aKaEhvskOFCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jtOco5HUz3cXDuddLbqx306nhavcl6KlbgSqHgXQ1arot3JQMH0Cec8bAWRKXG4yD9NwsQ3yPyRL3aFEdqapDLcv/7zoJNdfIXDZtUdrIJikdkO9XA1HOZwEloqE1qOTljUkVot5kSCJyMI2Brw23vemG1oc+fq+I02jbDEhuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAHLTkYj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so12232955e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162363; x=1740767163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBZNxOekeKV0LYb007rKOQkv4qSAcfWIVKd3wLeISbE=;
        b=KAHLTkYjgqS2gEdw80e0AsykQPvzvthbmiNo4HB9uSAEv7iLlQKFR6HrJsOtewAX5T
         Ar8m9AO4OZPkA//fzq6YlSaNSZeGqAJ5sy4A+j+1qe/FBnuvVjR1eIvuBG0NGbTj4Wn/
         18yLiwVinIxeFKP5EHq4rS1xrAxAJcquL/mgSECT6AEdem5B3I91xuiXgy0FrYBN1V60
         MEDACqVpZRdQfsrY6HInES+i/BUO5lF0r3GRg5kDdeAOx5RDWfmRbRoiu/rCmbBBRXTj
         dOVynd7jQD8fvC7K1GVqNdyLp9YXT3mSLXAMQ42Udy97q4lJ/WROEuGqsENpEbq3xzTF
         F8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162363; x=1740767163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBZNxOekeKV0LYb007rKOQkv4qSAcfWIVKd3wLeISbE=;
        b=UK2+4MH7g1PpW5pTK8v+QcLz0v3j4cGR90qpRLy7pRmvoNsaeMdDs6c9blYqGev/L9
         P+AhPj3mH92vOOlqW3zJlQRFsIAThAymPCmVtUUGtNTxpj3UFJuHw3pshOmEQIcE9PVt
         tnBNjvrrexGM3p5C38SZdLvOg9GTOzEAqS3CTQHWqYxw/sdu1ipQLTDhxnhjs73Xv5qi
         ZYk/UDigYRFYljYzlbnklDGEy0WRgz9d1NQ3FRdfbmlrqr772Y2PNYlQspOHZ0uwcuXV
         RgijrdoNdmwfFWzwSjfehdVzimExpLcWS7QtKHD2A6SyRsH62cOZaMZV5Y4iHxISWdsL
         sEOA==
X-Forwarded-Encrypted: i=1; AJvYcCVcI4KkC/eycUY9x9ojvMUoRAT5m8J4xGxYH6r1BHk9UfBJtLpCBlNo91oZcDG5jWsbzZmNs/GjgztwtyG9SIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQb9nT/DJqTaY9WmvtW13WFTEwPnh3FaqxBzzPyg3kg/oA2SDy
	9hJdvZBAa9vGils9RSVhh+7LegkcKo9K1cGNP1dXPvVAqIWRHj8zvRigyHz/JbDQq7EjMX2d4PZ
	VcUKaQ2ZIKg==
X-Google-Smtp-Source: AGHT+IExPP5BlXnuhegFwP5+f6OWmFBTfcOqXQgMBOZhO/TZNpjmVHE5y8AbHxBbpzzmIk1bu6Aq9tp7s4OWUQ==
X-Received: from wmbay5.prod.google.com ([2002:a05:600c:1e05:b0:439:9541:1cf5])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e06:b0:439:9274:81d0 with SMTP id 5b1f17b1804b1-439af0d5031mr28996635e9.1.1740162363271;
 Fri, 21 Feb 2025 10:26:03 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:47 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-8-28c4d66383c5@google.com>
Subject: [PATCH v2 8/9] selftests/mm: Skip map_populate on weird filesystems
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It seems that 9pfs does not allow truncating unlinked files, Mark Brown
has noted that NFS may also behave this way.

It doesn't seem quite right to call this a "bug" but it's probably a
special enough case that it makes sense for the test to just SKIP if it
happens.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/map_populate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 5c8a53869b1bd287b09a250edf628a66c25c2439..cdd88531dd9fe98f2d25edf4878659767c919e8e 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -87,6 +87,13 @@ int main(int argc, char **argv)
 	BUG_ON(!ftmp, "tmpfile()");
 
 	ret = ftruncate(fileno(ftmp), MMAP_SZ);
+	if (ret < 0 && errno == ENOENT) {
+		/*
+		 * This probably means tmpfile() made a file on a filesystem
+		 * that doesn't handle temporary files the way we want.
+		 */
+		ksft_exit_skip("ftruncate(fileno(tmpfile())) gave ENOENT, weird filesystem?");
+	}
 	BUG_ON(ret, "ftruncate()");
 
 	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,

-- 
2.48.1.601.g30ceb7b040-goog


