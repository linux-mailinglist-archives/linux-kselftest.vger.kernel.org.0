Return-Path: <linux-kselftest+bounces-8909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957F8B350A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 12:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB681C21A73
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E24142E93;
	Fri, 26 Apr 2024 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nc9Zjp7K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306E14264F
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126434; cv=none; b=klD4YKKi4uf4IIzo/kReJhWIbDWN8LL/tDWuW9yMVb8IJ14qVewMO6toqOv4lKgLg3Hrg0H1THA4ktkNPCXDCrgCcQStvjGcxXlgXBQ6VnnMgqHR2EeeAsiCP9W0b4UAw5OhmTWlEc/y3XYigFO5fEqsa45leBwk3f1V/KOZcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126434; c=relaxed/simple;
	bh=24kJE+8eVc4ogyRndMk8jZL6OfEUwakFZ92WxqX0NX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s59bvOHzJeJy4qBXNiF+DXgFCpIoTd0BpIM4T0XL8kfFmNxDVSRJZ3bESOvLSy3KNLX8k3q7oZguLrQ1vuYbbpTnvbH5iY0mGXNZiFR+sPgGmr3cNwE9TMjPRjEdJ6aw+9k8dWVCdgEgN1h8ti3y97AKdvL3fudEH/72cmpxhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nc9Zjp7K; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-439b1c72676so317121cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714126432; x=1714731232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/LwG0GvPr9JWPbmW+g/6YHRZg+/MP5hxVTSkmO9J3A=;
        b=nc9Zjp7KEi7GifK5+kHhBitePNyV57j3EF376yI7+L1kSzLORc7SqsJtWfLJm0/9p4
         710HrGm+SsjrBqmr9KBiDL+pSJyerwp4v5rTSW5meWDdgv6kABoFFOfYWccQahrz67Tb
         ZN5xb4M2knfSGnFyX/QY7C++mS6F2PCXctYzK0q7Ffx9LJ9tEHicbZ9cT4zHfBAzLl8/
         LxG0ualS0gqM6n1GtPZQN7IVtw/yIzNMzmeHTvRx6MhYE0j6W3txybUOYDO5amzMEeA3
         Q3+hbR9De/eZ2utXaPGDTINvSNmPFLyecOOPS1KL2Ctub76ckHXHD0HNi0qILF5INxKV
         nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714126432; x=1714731232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/LwG0GvPr9JWPbmW+g/6YHRZg+/MP5hxVTSkmO9J3A=;
        b=lBEsczLxu+hwVfj+YQLI2AgOs+GxldlpPcLEPE3ettW7dk9MpesQWFbE3eTi+2+2eT
         c8/YcZ/YhziEzfiXkXpcf50IhOnTnkaGvcNOLccXKjbZoy+IoWRo2s8628/k1lwVDC0V
         54lD8dcWHbExODYWUKWd9aaJv0xfxUUbTOjFrM2vE0koHB8s/cTk4oEOxRJDuefBl2vV
         0ikdkbDzn3q2Aat8s3AX6e9atpdcFU/CGfad1Nul9U1iS0RMsvgrA2JIhzWJpodpm2Nl
         qR1sVZvOrLjmG8xkmecvSY979tRJCkYCp192o30Tr9u6Fb+YsEINbxEj/x6bdC5QMk86
         0P1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQiWSTGAA5RG6TrrGknepsQyKE3LjSuPnLFk6VDJQUS4R7ljHZ8w8osr94LEfm8ej+o40OQqb4KXqiQF6q+k5P8WLNq2CKGkBITf/tEKNc
X-Gm-Message-State: AOJu0YxmUpFgj7q1DxvqwTaypxeBXABGQgF3rXzj3749do1gxoyuhFrd
	S8lbWm0/i/IGvD3I+cQOeWLLdrvx+Fx19b4SbJHiTzQ0gb30vRyMJfPd22nWa8L/pg3BQOfybfc
	0Sz9+B2ljZPCk/Dbv5p4KR8jq1vpi2Sa7s2Qs
X-Google-Smtp-Source: AGHT+IHi71L9eDaKtkraqMxL4gEt3ivysSLcXt8Ec3WGJM26HKGhUUS6XNYPVxaBjwiR90EFu0IelSE7k4TA7wxOP9M=
X-Received: by 2002:ac8:5809:0:b0:437:8ba1:ee1 with SMTP id
 g9-20020ac85809000000b004378ba10ee1mr225334qtg.5.1714126432301; Fri, 26 Apr
 2024 03:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com> <Ziri424B_R9GXA9Q@google.com>
In-Reply-To: <Ziri424B_R9GXA9Q@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 26 Apr 2024 12:13:38 +0200
Message-ID: <CA+i-1C1SoXugro50OO3BJx17Ea4VtmGNZ29YcatHVAQ3YO+sKA@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Avoid assuming "sudo" exists
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 01:10, Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Apr 15, 2024, Brendan Jackman wrote:
[...]
> > +     function maybe_sudo () {
>
> Any objection to do_sudo instead of maybe_sudo?  I can fixup when applying if
> that works for you.

Sounds good to me :)

