Return-Path: <linux-kselftest+bounces-25962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F8A2BAC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C684B188546C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 05:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD615FD13;
	Fri,  7 Feb 2025 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b1ky/Dop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06B74059
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907119; cv=none; b=SQogf7PZ0zMCLFN3j0FLC0FXwBIwYUPjvM2ETKtvXX712KsBrNbtp7ta7Oolm715rAvTOuitsiq2ZSD7eeN1q8HTzcnghialIzNMj7HLdY4NJPmSL5SeehBPfTagKEh4QQs7Id5xoeUxjp+MPApboTDfp6VlE6SLZdIBmk/Y3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907119; c=relaxed/simple;
	bh=gGezzYUMXDPK6inJCR26T2eTUq46GlYyJKYRkqpWgx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b6sOMpJgbGB8mQC7gsr/dusfKUqRJhIk2toEcN9omAfhE3cIjKeM2vilzgIqlJkeSKt3HndQSbCTL8kpCnhkQt8Apbr5aOdGN5uMQipbg7BUMAmrG79YaebVPtpWDfvOFC6xyC0mR7HKvckWUGR2zFJWigknsS6koBCIL4GfH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b1ky/Dop; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f19a6c04so147893985a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 21:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738907116; x=1739511916; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IiZZm6INZur7VVU7RwSrWYWqBqXxi7mFTnqmXj0pFQ=;
        b=b1ky/Dopd3ZyYLidjqAEjjEtD/pNxHIeEP6hdmIq5KfSj4M3FKwIZFAqROusAUAi6T
         OCDHKTdMcRb8yV1XzEnzByg7XgSxdQlHKnJpokKj85X1MMPYn8sZbJbaQKyUZNgl7h7R
         gXy1uPMgVm960SeUswycb4p6U0yRjtdAWJyQ9rGyat6qdoQma4BLghkTIVUcmSCKLCFJ
         JkMPt/gjly39jtkQfkE3zeawIr2gkCCx1i9TG4ttVwSh2VRhIhs9JAgtI5J5fTiCIY2k
         RIVNlQJdD0WF6QbTWv0xU//PsKajVtHPtNPW18Pp7yFEsebp+KSE2ph9EXOQqWLkTztM
         nBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738907116; x=1739511916;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IiZZm6INZur7VVU7RwSrWYWqBqXxi7mFTnqmXj0pFQ=;
        b=jZZJjbgOWwY87it2dwXb9ZbILjFlHrEUSF7Eef3svhh6wH8XMHtsSYovbw5chPyr17
         M2Ne08VdNiGXZjmyp0NOIHOehfjpoBTD2Vxhz6rL7TucFJc0GNzEkwovbOVxJvGqusrx
         KkK0sTXkC3dFJNMyYM1UZWn94ZcnUWdKpnlwjj8uV9vH7Iq5Wa/C2hpX7VZ0XOVSExiN
         ptHslfjQLYJb1yx9LMW+61Uuv7uIpNlaheNvSd7CS0jKxnmPjUjZwshOmMmDkeN8fzDU
         Iafukt9xsJuqOHdKLvkfd2AgYG1nWReYEysDVBiof9J9QYfbgeBw03fWl3MRv0upNSUD
         Jj7g==
X-Forwarded-Encrypted: i=1; AJvYcCVtleNPWfQMKkBjPivkzhq3rXOU10WqSmY4FErTZrdx5M46NCt6rgdZU5x2Dm6fOP/yMGRIKC1Bc901QNoEMno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLOQePxZzwFJqoauRQouBctbJc/QfbQ0IrQ/+KurFhOVv9X9Z
	csNoJMDzUeqEru0Me/BbOnDrCgJiTV8kOlghblpMiLqS74p0lFUC/d0/TDqzQlY=
X-Gm-Gg: ASbGncvMByQhF6A1umPCHdGESN8fm1+bJFHBkpjmCWVFil1uhe3jSKetqiXF5Kru20w
	ZSwluNA9CATW69pfdeftIIHYNMbZ1pKE7a/vweXRBXtaf5gkO3GTgjg7NnFanradP0/DOE41xqC
	eYeKzeqMssX2QQkkSWAl/tFQXU6drkeXxqGK1WyKRWnZZbcTnqB5WagGoBtJs3tAzusJcSsFLkQ
	MRWzKnglH32hl/Uy1fEU6P3SV2tDGN5s0ko1l9Se23AjnOHVaHFh11GtjUd+E5zIP2nXo5SJz6Z
	sQk=
X-Google-Smtp-Source: AGHT+IHeDFG4PsZo7iKREMUrGLF3htyuKAaLBY80zJViJUgHflhFdo3XRhrHt9jyqehSZE1DfqfxDg==
X-Received: by 2002:a05:620a:290d:b0:7be:8343:df2b with SMTP id af79cd13be357-7c047c34936mr298818285a.10.1738907116412;
        Thu, 06 Feb 2025 21:45:16 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f9e6sm148107685a.85.2025.02.06.21.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 21:45:14 -0800 (PST)
Date: Thu, 6 Feb 2025 21:45:11 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH v2 bpf 0/2] bpf: skip non exist keys in
Message-ID: <cover.1738905497.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

generic_map_lookup_batch

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

This patch fixes this behavior by skipping the non-existing key, and
does not return EINTR any more.

V1->V2: split the fix and selftests; fixed a few selftests issues.

V1: https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/

Yan Zhai (2):
  bpf: skip non exist keys in generic_map_lookup_batch
  selftests: bpf: test batch lookup on array of maps with holes

 kernel/bpf/syscall.c                          | 16 ++---
 .../bpf/map_tests/map_in_map_batch_ops.c      | 62 +++++++++++++------
 2 files changed, 49 insertions(+), 29 deletions(-)

-- 
2.39.5



