Return-Path: <linux-kselftest+bounces-39748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98220B32467
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFFE1D64BA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D934F496;
	Fri, 22 Aug 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POqtATle"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052A335BC8
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897995; cv=none; b=T2q+kZoRZdnAKP7BGCG+CZbKEE5rCUWKOsNgkrLHTTvq7uqjo6APosY8lLwguPrCoy5rKR55uKbecXPzCoRLA9ZRdXPKzk6ulRyRKKyIZY5bkZOXx1049UomNxbkIpNor+91sR7MK1UZT4BwYSd8+m57tZMYCxKnRg9H+8/a97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897995; c=relaxed/simple;
	bh=YREmKh0Fboin7Z98DEMinTdbhs/073LBC+MjzBhLJ7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oimSH24S0m6SmDsLSHQmUg7P7uLMAjL0aPqACKUPwnPCIq6pKz3DTKuPs1HOw5UvsMQUlHDjwB1NIG6ocGCcybhy5y25oMdpOlpMjaQSdvwauAQeL8MDcuxuyAOtfWqfu8GMLFZFqynUjOokRMlHrjivvYUVzaU8b5mtt/SOPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POqtATle; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32515a033b6so1615412a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897994; x=1756502794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQUN3cu4Z6jhJOuigxfBc3jUQuHypS3MX4G3wGMZeLE=;
        b=POqtATleSJSlV3iMQy18tEjmGPVBRyAbbubDJq3UZO5gcBtzpr3DTnYCUlrKWv9H0G
         MX346RhClwa1APvx6q+bQH6EYVEZLizk4O9NwrMyUUnZJg3ZxrlmbELFe1jV+x4TA6Nq
         3iI1auMcal56ZOh8L7n6iCk4cE3cujZfyOfsDgEFBqy3TMi63ZxwbiWd7MTF0meOxaAB
         qiCZdfteSCi3flpwr5qctfplOnHzdUTQ45bxF6s49NqwXqpOP23kV60zoyPWKtBlogR4
         d5nWhq8q0F4Rv3z0YF/wF1garj+QvA9D/lKYp/zwFSHKv+44M7LgWhLj5eisJgSfFuwC
         2YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897994; x=1756502794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQUN3cu4Z6jhJOuigxfBc3jUQuHypS3MX4G3wGMZeLE=;
        b=uNyuiCUQv9o9iEHLHb6T9/rSailgedGMHrJ1RcHBbOenZNGfXX/rln89e17ieCJLUq
         kVAHYVVglw95N2SEzNyP63f3cryoC6ndhOmId1Bd/9MgcCC5EkIw4y+Lee+WwitOu4tW
         ZW1tU5TgIdoesdWyEu5/xr8DLrz1gyFUCGJqHgY26N7/2rosR9oOnmPRlEqA9RqmBcVC
         HxlIzF2g38jnqwbn5jlVCt972B8jT7Gy9PCdZ38KF2ML8nXe4M9WEpnclWmYFuLr5xlT
         mgDc7vUKfh4Q0kSdxflbBYLaJJyHOCQ3KxtT2MTN8Mog7SBJhX7Vzn3vLMYmsbITkRm2
         mtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW42gDnVSH3GZUGq5/cXDdlm+8A3YPiU5CklR4dHLe9o9syzz10Pf3ifAa2p+tYmVXwVgScmdmpdh2za3RcGJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzmGaIOG9PqM8YAdAOXK9humANkBbFu7BnzP89hmfd/iJcth4
	hhr3kg0+YCg08f8WkjCeOyXe0OvJdowdmmXypzdXxU/fQo7k9CPkhZ57tJBgB3jQHHdNsHSyNhz
	fR1a1qTcpLcLQ2w==
X-Google-Smtp-Source: AGHT+IEYvgtfmLrdKKCDi0VmUAdVIvAX4P0QTCRSeSsfn9oPPDleSUrFNy2Tx75Bst5Qh836IgaTXfjb+a1ETg==
X-Received: from pjbsg17.prod.google.com ([2002:a17:90b:5211:b0:321:c2a7:cbce])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dd1:b0:312:1c83:58e9 with SMTP id 98e67ed59e1d1-32515ee155cmr5544091a91.5.1755897993841;
 Fri, 22 Aug 2025 14:26:33 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:04 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-18-dmatlack@google.com>
Subject: [PATCH v2 17/30] tools headers: Add symlink to linux/pci_ids.h
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Add a symlink to include/linux/pci_ids.h to tools/include/. This will be
used by VFIO selftests in subsequent commits to match device and vendor
IDs.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 tools/include/linux/pci_ids.h

diff --git a/tools/include/linux/pci_ids.h b/tools/include/linux/pci_ids.h
new file mode 120000
index 000000000000..1c9e88f41261
--- /dev/null
+++ b/tools/include/linux/pci_ids.h
@@ -0,0 +1 @@
+../../../include/linux/pci_ids.h
\ No newline at end of file
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


