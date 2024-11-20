Return-Path: <linux-kselftest+bounces-22342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E219D38D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 11:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBE3B289B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9511A01BE;
	Wed, 20 Nov 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1/Wx7Flr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2719E99B
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100211; cv=none; b=Ky6PA3bBHAsnlqk5fh02EIwwUsA5pm1IrVK6sQQOwgSyhEwLIhrO6PzubyiOYVWHJRfUeq6+bEd/hefvtNND7HWqusoVAOqo65XOjIsSEDTcexKKtA4MHBczXJm0yeDmtKZHJxUQYhsXys1uJ8v1cPCupUaPwaIrYm1SpwpU3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100211; c=relaxed/simple;
	bh=R5Sd6loj5EJcii2NLPGZvmbISqB4vmDy06J8WmMBhj8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Na4OJoKghks1fVUuOIeoLjuAVqIfz+ULRXawR1mcaKWD0BhwttaKeceFRs3cQaIrD0UwIUGLL1Bv7CLsCECj0TDONEbihNzYk/zKaCmPoDHb0dBvoQnk7lNUKFO7eqMMT16aHn8dMOKvlPgzciNABlbxB4AxvEWIs+BA6xw9aFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1/Wx7Flr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4608dddaa35so708081cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 02:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732100208; x=1732705008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R5Sd6loj5EJcii2NLPGZvmbISqB4vmDy06J8WmMBhj8=;
        b=1/Wx7FlrzBz3ykAzb9HIjs8WJFlJbuvZxAwph3YI355bkufo142GpIZYPLnyxfa98c
         EJ1q6jRBh7oPtdRJD8o5GnqeqR8RF9erLzPrPUV1qXsQyEvLhFZ/OjMVOc71k4gy/U/D
         Df/1OeGFoz2YR7v4z9DeF63cyqULRABG5J/4iMFZjBX2MnTaVqZv05j4XZklTIyRvVLh
         mbUSiC6K6EiOHLxnpbcfYKBlgphO5tXyJnutUBcRqqXqPgnE97WCvoTNQI1PSieSOKvx
         8W+gusskOmBAKd0RsM4zwPY9faMvQsmfcywqOzQxNSXN01lpA8E9VpYjB88wO5V/Xz1F
         c4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732100208; x=1732705008;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5Sd6loj5EJcii2NLPGZvmbISqB4vmDy06J8WmMBhj8=;
        b=Mz1PubgW7zpnq60xd0PeD5gqfvx6/7sIcvgGYqNK7qfb55NSR06KWwj7LahoKE/tUD
         jdhFI0ympyyYZTobRTc+ps4ooDWKpT2jC6yIPR5NmCsWMy26vFPIwKMuXJyZ9rX+EXnL
         0oAVk1FHA1crRLijrzYUpKD3InBFRkbFw8vAkT6TNlcQL63T+qeFFhf7XmVHtER/ZRLK
         jMF+xQvSsKcp8ADVOkxG05YBgV7wpQFtgwArTCSFpnALNP2EkK4NQA52Vksv2Z8X5TZd
         8whjYZ6F65/0MEXzXzXiBG7aI4yAEgTd5ygvDwwIQlCp1msOuvSnd5PerglkXQ1/iLa8
         ucVw==
X-Forwarded-Encrypted: i=1; AJvYcCWLp4rRnHCiuKl/rWieiRPUPEN0l/H9lGSTkUxrUgk2K9mTsmYMHrpyEizeUcM9d+wBqpp/0Vs6UEoPWENb0nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvakKah1hvYDHOssqKULpKjAEyWVzR5GDC8BBg8j8HZxBD+D+
	qGV4WmNlDrEtKnd2zemvojEalEBKV2MMCSU9UopNFnXJ5th1I6TNVnpEgMMxKjdizCvi4gp5Bud
	6nQvEsY0OXZD4/kpynB2qUm6q4Mz1VLiy9fXt
X-Gm-Gg: ASbGncvCKQQQW/G3spICptLyiELMxbUpUqJH+zUYPAorGnjKDqKepi2lb4KbU5Y4yHu
	aIlBLixbX+uS/KuUOuKPfW1K4ACANJWj8yDdpV3oTgw8zAgJ78u6TUE0lOVTo
X-Google-Smtp-Source: AGHT+IHOei8nFMFF4TTbyZshOJG5RNeCMFKpJQk1wMiqpk7eZsHz/J//8k+nRa9rsxbTP9Mz2H0m1Rxg4oT8A/Ho4Kw=
X-Received: by 2002:a05:622a:1c0b:b0:460:f093:f259 with SMTP id
 d75a77b69052e-46426a0e5e9mr3212521cf.22.1732100208367; Wed, 20 Nov 2024
 02:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 20 Nov 2024 11:56:37 +0100
Message-ID: <CA+i-1C1hggn+uhYAb1uNtma3T8N7n8T4KJ+z3eKb041u5X7SPA@mail.gmail.com>
Subject: KUnit expectations in atomic context
To: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Cc: David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Another rather vague question from me - does anyone know any reasons
why we couldn't support KUNIT_EXPECT in atomic contexts?

For Address Space Isolation we have some tests that want to disable
preemption. I guess this is not a totally insane thing to want to do -
am I missing anything there?

You can see some examples here:
https://github.com/googleprodkernel/linux-kvm/blob/asi-lpc-24/arch/x86/mm/asi_test.c

(Actually, looks like in that code we just started doing KUNIT_EXPECT
in preempt-disabled regions anyway, and I never suffered any
consequences until recently. Probably we just never had those
assertions fail under DEBUG_ATOMIC_SLEEP).

From a very quick look, it seems like the only reason you can't
KUNIT_EXPECT from atomic right now is the GFP_KERNEL allocations.
So... what if we just made them GFP_ATOMIC? In general I think that's
a pretty ropey approach, but maybe fine in the context of unit tests?
Or, we could have variants of the assertions, or a test attribute, to
just use GFP_ATOMIC in the cases where it's needed.

Is there anything else missing that would need to be done?

Alternatively, we could expose the whole context concern to the user
in such a way that KUNIT_ASSERT can be used too, something like:

struct kunit_defer defer = KUNIT_INIT_DEFER(test);
preempt_disable();
KUNIT_EXPECT_DEFERRED_TRUE(&defer, ...);
KUNIT_ASSERT_DEFERRED_EQ(&defer, ...);
preempt_enable();
// Prints failures from above, aborts if the ASSERT failed:
kunit_defer_finish(&defer);

I hope that wouldn't be necessary though, it seems like a lot of API surface.

