Return-Path: <linux-kselftest+bounces-34-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EAD7E922A
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 20:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BBC1F20FA2
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE1168BD;
	Sun, 12 Nov 2023 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCxS1kg3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B501641A
	for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 19:03:48 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D55136
	for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 11:03:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ee6a1801so51983257b3.3
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699815827; x=1700420627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVnkWw4jhrOIly/GzASzTYN635YWhiNBSpshulSH7pE=;
        b=eCxS1kg3BCgS9kqJTsNqyc+SEA5z5tfWZYwb4Ontn9rAzo35KofFedD9vPv3CKs5qU
         0UMP+rwouDP3BF6Ga4jWRSP3VepqeYRJnl9b8zAjCKWYs7k82pSxpqVrcD7znRcD6a/X
         Ixs6tVibUwIqDM3r2SBM9tn79Ed+D1j2Z/eJsgZ8mi4MgCCd+mooIEIvxEOqvZ7ckLlq
         vRtpEKqiU3qvY8JarnS3QQVoxquEqOFxCJ270V+tSW07bhTBe5Fq0R2z0YQ66ZItxau8
         VexOyVDWwIxXd6glLmCQGTvHlrwBu4AiEN5H3alWKGj+Iiwy94FB9C4DdXX9hKwMfMS7
         EYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699815827; x=1700420627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVnkWw4jhrOIly/GzASzTYN635YWhiNBSpshulSH7pE=;
        b=YvZjRw6D9KtewqNj2y667s4YC41Ge/3bOhzMY7OEyL4XCow444dnw8C0tNTrsM7p+C
         k7wPDY8edCOWjhYHiDBZWbHGHJrUYQV2Ne59P0l9FwNYZ1wwHR16RxwIhhzfhIUs2Yk1
         2y4yctcCHjtQmXkDLWJqCpZtp1KmQVk2u3nj7GPoa+pjMmm0oLHGHMaQ4+cjXL3B4tZe
         DsZLMzPOrxp3ny7J0E0ZMdmA+sDvBf1k3zsb8vGoN97B5pBB6uon/a3XUJuGxS4/zk8g
         mIqg70HETWrZxAVgRWr0tBQ+W13suO44XpcyHQIZG9X/gn7IHC9IF4P9qvsDPQP3PlAL
         2lVA==
X-Gm-Message-State: AOJu0Yz0wLBQBSsmWROSnn8uenGTLlEFCvxJFSUgiqeh2A15+4hUkV1D
	dFoS3KZk+VxVYiHFSiwsR1pZKsI=
X-Google-Smtp-Source: AGHT+IHe5QhVbXGYPIeqKyOMd4+FS0ox3cxktGIDU/UldT5BZk8i8jB5JA7YdWQXkWV9xpRl63FzDBE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4f90:0:b0:5a7:b543:7f0c with SMTP id
 d138-20020a814f90000000b005a7b5437f0cmr144573ywb.10.1699815827278; Sun, 12
 Nov 2023 11:03:47 -0800 (PST)
Date: Sun, 12 Nov 2023 11:03:45 -0800
In-Reply-To: <20231112023010.144675-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231112023010.144675-1-linux@jordanrome.com>
Message-ID: <ZVEhkbB5fZmxWObG@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add assert for user stacks in test_task_stack
From: Stanislav Fomichev <sdf@google.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="utf-8"

On 11/11, Jordan Rome wrote:
> This is a follow up to:
> commit b8e3a87a627b ("bpf: Add crosstask check to __bpf_get_stack").
> 
> This test ensures that the task iterator only gets a single
> user stack (for the current task).
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

(based on the tests passing)

