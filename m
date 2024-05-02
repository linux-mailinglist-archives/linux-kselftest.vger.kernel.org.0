Return-Path: <linux-kselftest+bounces-9272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55A8B9FA9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A23B23288
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462B16FF41;
	Thu,  2 May 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7u3X90E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF115B559
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671611; cv=none; b=snomFFpLbq49kKmIyMagFRChWV8baqOom19jVxnhQGxu9/R8jmi1Y8hHsgV1kEyly5ZisLI6dnUTuK7DMOiWdB+q052Mg7kJ7Yc+ZX1VCKNxyK6ZuLet+XLtzI1QSqY0Ee3kjT3MFAWOt4Lbb/e3NKm2cx+ACTjCgW2kVwvCN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671611; c=relaxed/simple;
	bh=70z6YTUBQ+A0gQs7cuzGrUjnZbwGiVAMw/C3dltW1Zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oxgmPECYvUKQ7HLf9Qc1JurRrhx6WCDPBns6m31I9SBBog96gookPFpMeIfJmeLg+j5/hMjOOGKwGKZ9rRz4+t/jkcVQXjjyC78gI0IYvBzZuTyY2d74EC1LxrX7WmX94OK/9pMRYthbeUKGLPWGaFoabRhnWMH3mAyKWFN/cvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7u3X90E; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de615257412so6525397276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714671609; x=1715276409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ9OJMpWeutkitSt7FSlYwaBe/E1WyMSeH/OQAfe+DE=;
        b=c7u3X90Epp2LVB5JNrjeV0s3VwdBzYpNt7VLbe4gijZwoIZRF87NDpW24MKaiTeMCh
         60x+4YJgcnOBhjT6IZUGh9gtrGGDYJO+U8yHi3JTC9LA4vdwz65SkPigtNuIfGTZuo5m
         At7uYmsb6qZ77AD2rOfn6hai0gul/HQ/4cPbg6j5qLEpzTgE4K5lDHE3lYg3ac1g5r2f
         g5qLFuLtpvvS9Z1pvBih28ekem0KW4neaEOrZKNJe9n12fFPBhxX8sIQH4p1FNZ3jz04
         5vUXYRd0x4wWtx4ZWXm+sP4UiVb5TSoKinHa7vid7gK6l0REydvc9AvX0XIJbstm+uht
         /Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671609; x=1715276409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ9OJMpWeutkitSt7FSlYwaBe/E1WyMSeH/OQAfe+DE=;
        b=FllwkFrpd/mMWDBi3UO9LV+bZvWioRCdG7ctkSR+rCLKY3zeo0Dcp3RUY31ewOmJXi
         xH+BZK0+7XwMMVMDAh8HFA2hdubumlAG+GoEBx6nFBFeVKHEh1qo1Dey/jjQlFnSMnLV
         9PLD2l2monyLYzcR9Gv/qKQPYyZKsXWIqlsOn9W699Y/VADvPtrRhhK28THyP7WYDC31
         3UiKQg/5q7os9XIo6HYzO74C3NopekUrJI0YPvWysG0waFPcD3+xMudk0p6MvB/Ec9oP
         8J+fYBUFptAzzTLdTlK07L11ChketHbq7LLBj/0jNp0gm+4QBm/68fftoMfGDfbV5zCZ
         FgaQ==
X-Gm-Message-State: AOJu0Ywd/Sgpxybnw/ySuEg/x8saEKF2/laaINJuFjuyARb8hRpr084m
	dSp2A+4fEa3Rx7ZCHW2GcmIlVISMdWTsdJXeK+JfREp29dbVX7mIU18Uxz9hs5tsv7I1dPqacaL
	CAA==
X-Google-Smtp-Source: AGHT+IHtzmwFJbX2ANAYJrqATOESXdiQBAY+tXHzGFKxXan3JPZHl6mex0H/4681sC95CMMHl6kLbXQPp78=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b89:b0:de5:2325:72dc with SMTP id
 fj9-20020a0569022b8900b00de5232572dcmr149662ybb.5.1714671609013; Thu, 02 May
 2024 10:40:09 -0700 (PDT)
Date: Thu, 2 May 2024 10:40:07 -0700
In-Reply-To: <20240429233435.19003-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429233435.19003-1-zide.chen@intel.com>
Message-ID: <ZjO48cDeqOBGCH6K@google.com>
Subject: Re: [PATCH V4] KVM: selftests: Add a new option to rseq_test
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	donsheng <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 29, 2024, Zide Chen wrote:
> Currently, the migration worker delays 1-10 us, assuming that one
> KVM_RUN iteration only takes a few microseconds.  But if the CPU low
> power wakeup latency is large enough, for example, hundreds or even
> thousands of microseconds deep C-state exit latencies on x86 server
> CPUs, it may happen that it's not able to wakeup the target CPU before
> the migration worker starts to migrate the vCPU thread to the next CPU.
> 
> If the system workload is light, most CPUs could be at a certain low
> power state, which may result in less successful migrations and fail the
> migration/KVM_RUN ratio sanity check.  But this is not supposed to be
> deemed a test failure.
> 
> This patch adds a command line option to skip the sanity check in
> this case.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Co-developed-by: donsheng <dongsheng.x.zhang@intel.com>

This needs Dongsheng's SoB, and your SoB should come last.  And the attributed
name for any tag should use the person's full name.  Given that I have emails from
Dongsheng that show up as "Dongsheng Zhang", I _assume_ "donsheng" is incomplete,
but that's a big assumption on my part.

Dongsheng, can you provide your explicit SoB, with how you want your name to show
up?  Thanks!

From Documentation/process/submitting-patches.rst:

  Co-developed-by: states that the patch was co-created by multiple developers;
  it is used to give attribution to co-authors (in addition to the author
  attributed by the From: tag) when several people work on a single patch.  Since
  Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
  followed by a Signed-off-by: of the associated co-author.  Standard sign-off
  procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
  chronological history of the patch insofar as possible, regardless of whether
  the author is attributed via From: or Co-developed-by:.  Notably, the last
  Signed-off-by: must always be that of the developer submitting the patch.
  
  Note, the From: tag is optional when the From: author is also the person (and
  email) listed in the From: line of the email header.
  
  Example of a patch submitted by the From: author::
  
          <changelog>
  
          Co-developed-by: First Co-Author <first@coauthor.example.org>
          Signed-off-by: First Co-Author <first@coauthor.example.org>
          Co-developed-by: Second Co-Author <second@coauthor.example.org>
          Signed-off-by: Second Co-Author <second@coauthor.example.org>
          Signed-off-by: From Author <from@author.example.org>
  
  Example of a patch submitted by a Co-developed-by: author::
  
          From: From Author <from@author.example.org>
  
          <changelog>
  
          Co-developed-by: Random Co-Author <random@coauthor.example.org>
          Signed-off-by: Random Co-Author <random@coauthor.example.org>
          Signed-off-by: From Author <from@author.example.org>
          Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
          Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>

