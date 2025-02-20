Return-Path: <linux-kselftest+bounces-27071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1867A3DDC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23B117CCB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2831F8BC5;
	Thu, 20 Feb 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUoC0AA0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603B1D61A3
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063822; cv=none; b=WZFaE7BZpulscExQAB4YeJi0fq8YV6AMypH+OPRj4DDs+4U2esXOG+c5QgyHa6akvyc5B1ZZXT5RJUJJGVCjEiBVVx1eT3e1qnDkrSWbSnRyASreLSh0PbEnnaa40y451QC8a9JOH9yrL5kkD8Sd7wzNEU+LZHTZWk4kkKDX6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063822; c=relaxed/simple;
	bh=wTvQAECQfBGvJfO2IYpS/3+nrOvLzdHfn9tUhrflZ/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=clluBVFj4TlWADu6w6+lz5inT3U2BWuZoJd9dve3AStj9Vga176TkBMLLQTDgwcmEWP91YANkr0+4Xzp+jer74CxYNxwQoRNWsSUVaS9GH3RnS8uDhgRxoq17QTrwV+akRRL540+yHLkcLzuQrqEVRM6hYrM+gAOKw8465x1i8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUoC0AA0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43998ec3733so5265925e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063819; x=1740668619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2cU3uizp658OhdQ9kd90hu4zfUwjiA1W6x03uXXmdAQ=;
        b=bUoC0AA0yYpCR2qG8hS2519OU4flKz6spdmdlzEjC9Tg9T8xVsGdQxsFP/ezGfdWnE
         lnu2/rZt89ylFBhnG4LxKb6nBO+Y+ydnkuRP+g9ZZ076qXN9bw3UT98nZR8ten3HkBdK
         eqcxS0GLMIFB6US5WFp90keMDlFdO1v7z44P4Q/+tsOAr8uPVZZULAAT5me0aXss4ClH
         AsJQVpbh65vClj+C/HGhSt7G4USFrN2JE2HPeQVIZ4g4SN+e4oyqAmiyObsccBHSvZCG
         GQzkghLJk4oE+OrHA4nh3bSqoDwJQ5InF//2qGjj0zhbbc27/hNSqRTNaKGPWWh6HED/
         2Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063819; x=1740668619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cU3uizp658OhdQ9kd90hu4zfUwjiA1W6x03uXXmdAQ=;
        b=EwTpov2SweeMCEt9hUykR6UmKZjl2AeCDlrCGNVfxJsBPQQIk7QpcJzL5i7p6ibics
         G6MVa5gnX4iT5aAuK7S9yyRdQ679DbSg5fWyrK3GupddmLnUnntKNGUJVPLkBP9mlIHM
         PtXCiP9ZJuaz8f0kn0n3lvcrGw8uBn3zp/pfUzTsCBdmpKg2Sy8OlVtKXj7Abnwpt9hQ
         Nac0jh/Gc/JXu9cZHvt1tfvvDYeNw55e1d7E7rNV+Teyu9/LC4jBS4EEupbL1O0IHh6+
         CKbUJPyLUgqcZbR4U73LrW6+zm9fuJexKFw7835vqzR9IhYlBYIkp1CnlShli0dKLQ/z
         TgKA==
X-Forwarded-Encrypted: i=1; AJvYcCW4HNLPGKpKXIKrSxu0VoggviysvkUz6NareDB3wsrmenKLzy3aywJGd9QrjdS+Vc4FhXkRyJgRbfnmi5tsvl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuHizJgbuH5CbQpDz4/9kvcW8VX9SxfT/XI1EKXuwVWb5g+kf
	iG0elYAgo5jYgkObOLSuC73Kf3PiwGmT+sO19i1ahbdbE8mpKJoOHdc8gcorxmkWxCWYxzl96LE
	q21uhitI35A==
X-Google-Smtp-Source: AGHT+IH7Qp/pmO8pBHKiL7eXO7DplNVB/xHNtFV3XhImarHE5JEn5i8DofNI9hIkq/P/8BZvkb36yjXAHrLGvQ==
X-Received: from wmqc19.prod.google.com ([2002:a05:600c:a53:b0:439:65f0:b039])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190b:b0:439:a1ad:6851 with SMTP id 5b1f17b1804b1-439a1ad6abfmr43641015e9.23.1740063818621;
 Thu, 20 Feb 2025 07:03:38 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:12 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADBEt2cC/x3MQQqAIBBA0avErBNsSIKuEi0kxxpIC0ciEO+et
 HyL/wsIJSaBuSuQ6GHhKzYMfQfbYeNOil0zoEajEbUKQQmdPpNkUegmp82I3m4ELbkTeX7/3bL W+gHv8BzMXgAAAA==
X-Change-Id: 20250220-mm-selftests-2d7d0542face
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Subject: [PATCH 0/6] selftests/mm: Some cleanups from trying to run them
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

I never had much luck running mm selftests so I spent a couple of hours
digging into why.

Looks like most of the reason is missing SKIP checks, so this series is
just adding a bunch of those that I found. I did not do anything like
all of them, just the ones I spotted in gup_test, mmap, userfaultfd and
memfd_secret.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (6):
      selftests/mm: Report errno when things fail
      selftests/mm: Fix assumption that sudo is present
      selftests/mm: Skip uffd-stress if userfaultfd not available
      selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
      selftests/mm: Print some details when uffd-stress gets bad params
      selftests/mm: Don't fail uffd-stress if too many CPUs

 tools/testing/selftests/mm/gup_longterm.c   | 32 ++++++++++++++---------------
 tools/testing/selftests/mm/run_vmtests.sh   | 22 ++++++++++++++++----
 tools/testing/selftests/mm/uffd-stress.c    | 11 +++++++---
 tools/testing/selftests/mm/uffd-wp-mremap.c |  5 ++++-
 4 files changed, 46 insertions(+), 24 deletions(-)
---
base-commit: 87a132e73910e8689902aed7f2fc229d6908383b
change-id: 20250220-mm-selftests-2d7d0542face

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


