Return-Path: <linux-kselftest+bounces-47663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3581BCC8086
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 15:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D8B73006722
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2C385CD4;
	Wed, 17 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLJzYCjI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D52387B07
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979979; cv=none; b=T+6Lr2tW2rLDE/Epw99HBcFj5EMVCu7oWQs5K+eyDb2JQaHYHELb8oKjWkW7nnlbUQoPLaSeM88AcEcX0C0YvR17UJI1MrPU5FUh6TcU/IPYTwCUqE8ygdIwGS5D+W7OnwnZ77b+EoH7nzgL6VKq5/EsZkkh/AWbwZ4Y9wt4s6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979979; c=relaxed/simple;
	bh=fvKxH/XdJpR1VGlJrGJwhcWm0/GHxvf3rLmcaDAVhrY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q27hCOFqYZiHFrRpyC74+mTSPfHzY1m/ADgsMXISWVqCesyGLkGomqGIHYJX7NeDXgUMcIqkRR4976qNdgitRVCFW7FN5iNneZQKsDUa4CK5ngaEP3Y8tdpES/t9IWF5wt5N1224dY9Rm4bPd7ucUmlXMLfl949I2ZtNRPOLEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLJzYCjI; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b70b2a89c22so98628466b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765979975; x=1766584775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4m+/p9DwVtvLw/ZoRn7BCKgyTf8N+JbFKUU8HCxN+OY=;
        b=yLJzYCjIu6w2bZxDTkXHuGOoKJmOruE+uC5/B3UK0BPMAIueubtBhcmsuTP/N+miJz
         H3xhvPj34yjtDN3f7ti5CsyyD6PsZZSCMIga6kHnGj9jqGjgs1vfwiVy5oeBdyhp7e3U
         9q7yFbFvUfbN/YhNgoi9B4ZJVZeuW/tnB/IPrPYRCmmfUo61+xEZAsdRg7MOzDiWtwHL
         g5WuXzpY0qANQ1i+KDPohsJkjaOSKU/QHwzMXkioHDBJzOQB/cUqG1d5JQjGHhOpxwkI
         TltqZWFYkzqKSKq9ylGSM9YXmHWHFA7B3R6xoGXSWUCrbx2eRMp+SS8aVnXZhwLV9CEu
         wxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979975; x=1766584775;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4m+/p9DwVtvLw/ZoRn7BCKgyTf8N+JbFKUU8HCxN+OY=;
        b=fFOzLJgr+R8p0A/BDqE1jvxL6mk7iwJ7DYtf3Jco+TvlpW+MlOhtycVEFyiCxpXPlD
         CT7qEvkjgjqvGrEBX8XvjfXgHG5odXM67tLitnySAfpAMc9XIq0cdCHWrDDQeTk99tBq
         Ed5dMDD4Fk1xckPPKJQueRZOCfi5pYWkCbKNBgnQdQ4amvGukNMR7kANI3TTo/ktzQB5
         dFBOCWUyOvx1MePWIjvOZjpnHAPbAnNm1KyO3+t5GFUunNy/mNUXbuXH9ukR/Tt5uu/6
         ngElYjxGoUqk2TQU0K+DOnlH+ptH+8uy9refUm35xfs9H7zWKIFL12hiPoR+qAlqECwV
         Vcjw==
X-Forwarded-Encrypted: i=1; AJvYcCWNOpSzLQ6v7FvRNdAS593JAMbZSBIPsmt6ahQ7qC+wWTGiVACvMMLXe+/adOlsRAIg3y1elsboTwiCBnufU7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFaysTCfwnq1c/nfQbV7sPiPxNpad2tEHvBf1MYc1T4Pl/ArJ
	LVQGpeC9LtNYkfe+ZwWDt4eeNbQx7jlKUUyCBpz4SAkRXUPcONunowMniAB6l/c5HWtHbJEnSFd
	JW7ZuRQ==
X-Google-Smtp-Source: AGHT+IGlfC96a8lTJuPCH59OXIoH1D0B7xe7e0QAvxhlBK7+O2j2um1O4VcwMtHmDJY0096GVUCeTt/hFIk=
X-Received: from edqz16.prod.google.com ([2002:aa7:d410:0:b0:649:906c:d248])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3da6:b0:b3f:f6d:1d9e
 with SMTP id a640c23a62f3a-b7d02138442mr2503373666b.6.1765979975028; Wed, 17
 Dec 2025 05:59:35 -0800 (PST)
Date: Wed, 17 Dec 2025 13:59:30 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251217135932.3153847-1-srosek@google.com>
Subject: [PATCH v1 0/2] selftests/x86: Skip int80 if not supported
From: Slawomir Rosek <srosek@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
Cc: Betty Zhou <bettyzhou@google.com>, Wake Liu <wakel@google.com>, 
	Kazuhiro Inaba <kinaba@google.com>, Jeff Xu <jeffxu@google.com>, 
	Alistair Delva <adelva@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

The IA32 Emulation support can be either removed from the kernel,
disabled by default or disabled at runtime. Some of x86 selftests
are crashing for all of above thus is_32bit_syscall_supported()
helper is added to skip int80 syscalls if they are not supported.

Slawomir Rosek (2):
  selftests/x86/ldt_gdt: Skip int80 if not supported
  selftests/x86/ptrace_syscall: Skip int80 if not supported

 tools/testing/selftests/x86/ldt_gdt.c        | 21 +++++++++++++++++++-
 tools/testing/selftests/x86/ptrace_syscall.c | 20 +++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.52.0.305.g3fc767764a-goog


