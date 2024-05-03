Return-Path: <linux-kselftest+bounces-9435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD668BB64A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 23:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF301285409
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB985653;
	Fri,  3 May 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03pBKCJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC2137752
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772289; cv=none; b=Tf96mB+z6fxYbOr00bWBOYHfKOPVkiOXZXXRTDrNsXk0J08Il7866xl5fpSSCHYCiWyf3yQRjSy7Y8giqYhr4mr/MOablXO4Qh82xY26yeexxy3c2/qkKfyHHK7QZ9qMDuG/ZPDPPeyf+7yi4cECBksWgaPgH4FBwZ4IjFSvnek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772289; c=relaxed/simple;
	bh=LV1torYTcOBrk5M5IpbWLvb2Dqs4x5O9Se4egYxeacI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTQJJEiIIv1/6k+BSMPakMMicP/ETlAzi5wjpeBwEOC10OTZ8z4Q90HaSOdOUkhg9gVrH1LvB5dodW5qQvWg4frqU7ZC27zpI9nEWuNko5RyxFhfq81dZ/7UcOAeWYBZZQXmm8YJ5+yHtdjIGYSnJK9IsmUsNRgpqgYn+kh/Ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03pBKCJG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e45572fb3fso1450785ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714772287; x=1715377087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvaHOQSi8w1h6IbGa1LE1RlfYHHDvwTzey3TdbGvPsU=;
        b=03pBKCJG6qECcQtWWZru+EzWsFBy3CQ8s6Hckk9icqsguSjg0TK63STDPrpUBVEZuz
         QTckZeRbVXyUk2ZumKSAcXT42g/UrV7Mh88d+D4OcMcq4LvAsgnlC69/j5YDW3NZtTl0
         pzOrAi1tWI0aosGMY1/rROCjyb4IIE7SqzV0/gzYelYoJOeQG8C9nZ5qoOrQyoBgVLXm
         Q0cYtg5wxib4hwxO6aF8GLiTaQLnXK4eA8akJlN20gocEyPlGdid3ywHQ5rTRyWjWuJX
         QxEIpABPMkc94LJlFUjmBQTIFp2q2WHvlO/FaeyCxBYxJCycQrjG35Ugk7dDjkpsi2Mu
         Hr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772287; x=1715377087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvaHOQSi8w1h6IbGa1LE1RlfYHHDvwTzey3TdbGvPsU=;
        b=ftRtGmVTBB5YUFedIHyx7zbzv3W1Dgp5JfDrkeL45+iZg200c15eoa4tz633Evcuq9
         W8gDRZpUMapX4Llfn84N71pIql/aAX69sz6U0nPrGPgh8JyBGvJUKC9SmcZkRHuBOcHj
         UyXPA6yRhu13f7vskq+ormb05fhgLZFmpibYvfiGLYykAfnpEpU2W6Qn/sIi7PXtctLH
         5MEttvV7a7qr67nPPt+ugR51CQUEmcSUR+aiyHNI6Pp7604Iu9/x3LBbvvXONUoXqfxF
         RIDfAmVbDMwUf+ShxHpfMvXTtQuPFZhMTb/UiNTLTPP5o+wItiZ5j6oBV82b8F2iaq64
         fW0g==
X-Forwarded-Encrypted: i=1; AJvYcCVGaCX9MzKg3L/48uct8gUhE7E+lip0X7jVPr95hHykQGbosMVlUPpOaYyo6w3v4dJ5ZpteLJCVBAUUoRBTp2ILV2PC/DNrmb3F65FHR4pF
X-Gm-Message-State: AOJu0YyFqVrNOfRaqQ133m/C3/+Lzb4Kw1JdV7NTpvQuSFCGike/3Zdf
	V2dp4W8oHCangG1808ofeR7L26At2e4/XfmkbWadPOnnqxeCvJPATt/inQ9bPGwlAjabzpt4Voy
	2yw==
X-Google-Smtp-Source: AGHT+IGJHJlBiEQ2rieRBD/37ir1M2MGRe9FjKE3o7aLjZel71PHnGGkjhV9qocKdL1td0MM9cLqwHQknjc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a510:b0:1e8:5dc6:405a with SMTP id
 s16-20020a170902a51000b001e85dc6405amr197676plq.4.1714772287457; Fri, 03 May
 2024 14:38:07 -0700 (PDT)
Date: Fri,  3 May 2024 14:32:28 -0700
In-Reply-To: <20240502213936.27619-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213936.27619-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <171469160565.1008873.16336312098515318304.b4-ty@google.com>
Subject: Re: [PATCH V5] KVM: selftests: Add a new option to rseq_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org, 
	Zide Chen <zide.chen@intel.com>
Cc: pbonzini@redhat.com, Dongsheng Zhang <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 02 May 2024 14:39:36 -0700, Zide Chen wrote:
> Currently, the migration worker delays 1-10 us, assuming that one
> KVM_RUN iteration only takes a few microseconds.  But if the CPU low
> power wakeup latency is large enough, for example, hundreds or even
> thousands of microseconds deep C-state exit latencies on x86 server
> CPUs, it may happen that it's not able to wakeup the target CPU before
> the migration worker starts to migrate the vCPU thread to the next CPU.
> 
> [...]

Applied to kvm-x86 selftests, thanks!  I tweaked the changelog slightly to call
out the new comment and assert message.  I also added an extra newline so that
the "help" part of the assert message is isolated from the primary explanation
of why the assert fired.  E.g. the output looks like:

==== Test Assertion Failure ====
  rseq_test.c:290: skip_sanity_check || i > (NR_TASK_MIGRATIONS * 2002)
  pid=20283 tid=20283 errno=4 - Interrupted system call
     1	0x000000000040210a: main at rseq_test.c:286
     2	0x00007f07fa821c86: ?? ??:0
     3	0x0000000000402209: _start at ??:?
  Only performed 11162 KVM_RUNs, task stalled too much?

  Try disabling deep sleep states to reduce CPU wakeup latency,
  e.g. via cpuidle.off=1 or setting /dev/cpu_dma_latency to '0',
  or run with -u to disable this sanity check.

[1/1] KVM: selftests: Add a new option to rseq_test
      https://github.com/kvm-x86/linux/commit/20ecf595b513

--
https://github.com/kvm-x86/linux/tree/next

