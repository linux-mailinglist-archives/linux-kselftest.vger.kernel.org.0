Return-Path: <linux-kselftest+bounces-14057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE879399A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 08:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853581F2231E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1013D602;
	Tue, 23 Jul 2024 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fw//d8GW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D813957B
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715953; cv=none; b=ls2WUcPhP7ru6uOIX1GdAuHWdJgPjjRQ2c9hko7DU9/gCXBKB3V3iE3JU3ZGOkEzY/CGXYxUN0fX8Ou7QwLD2RGIIWEuaPeeQh+DK89d060DqSZo8xlD9AJnd7tkuIRNzLxqPLD8y4/nbrSYfCI305y0Jv6IlW2h2pM7no7KyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715953; c=relaxed/simple;
	bh=aTBVANdttMOXuSCIgkmx1xWhKRwAckVr6YKfyBgdSgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUpSpsseDJLpp8MWMWTHp9Px2+llSMIVAn3XXtlp1k9EMSwTBj2fv7dMWcN3kCzyEeJMd4NUP6g/OGMoT/DBajztwpgofL/EIY6+UsOCT8wB8tfufgBMeOz5nYjG+79rW/ZbMFFP+gpSsRcye3TCkmiqU+nHnh3G1Gw5SVTmpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fw//d8GW; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f524fa193aso853292e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721715951; x=1722320751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTBVANdttMOXuSCIgkmx1xWhKRwAckVr6YKfyBgdSgo=;
        b=Fw//d8GW2Kp4sWJkcpFsQOjcDXFJ7shhX72gTSu4UiOv4zgJtDDf9laTEAQNqdkLG9
         yfWRyT+Va/RQFyWKk+jyZid/LeNVf05HLUgOcgL8K7T/ILblcii0QjvVxiO/jSgWJTK+
         B61XyFUb1/8G+xGXxG9JV8BK4Za5aozYgRhe6rsxMwerPOwLggMLHKSEtP0QkH3I97CX
         x14BkS3vw8s0BGwbYvTWBV4Ae/6mD0aF7xLu+/lus5YSSEfAD/bh6p6fC11u0Ur0TfIH
         qm5F0XSE4UD+W2rUWryuOgbomfNra3bMpQsedXi9azCKh31XQMdY+2Gq8uO8x4bLzG8Y
         6vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721715951; x=1722320751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTBVANdttMOXuSCIgkmx1xWhKRwAckVr6YKfyBgdSgo=;
        b=g5Rzf+G6wao4Zq3x1zBXKxmvdzZhNFw5FvnCrZ1+ysjS/o5kvyouKJtLzXbzbHC7OI
         yhSP+0ibl+O9+K9briLNYPUaf5Zpmr8A7Uw/dUUS+K5YmD5hwqioslWdQq9QyHl1z/So
         UWTX6jnm8r8zoTRDXIK54ezz1RaBXfn3FfTb++itGcSr/Yn8dUIoqABSbuIOUNfn/grX
         Mxx7jkwPtV25qJuD9nqycpD//chN9YKuW8CgHICX1EadYIPSdowEbp8N+8C/XqWTmQ/m
         JlI063r4pWTAnZri+XZ2xsqReT5UmzOPhPZnnXicG1ri/OODWZviCeItRqEzcNjDQnXh
         aC/A==
X-Forwarded-Encrypted: i=1; AJvYcCVMgxtxk7Bb2mFUJrLnnUpYUcyMSSiLjtPW6cLnqI6tUadOqdp2arQ/0QkjjqRv1VUs+ihsYPQV9IEOVa/FwdtRN+p3O0GFZHvVJvKm42BV
X-Gm-Message-State: AOJu0YznM8M3TmN5bXAhemzyxk9HTsNbXInsFduJtcMckMnkX7Wjhu0d
	0AyODP74mesrCLQPJl6raa8tk1UpjwwKsjM9RN50lXNoj5/LwsBVhZ7BuPIBxPT5EgtJfOpyIMI
	CgF2UbOqsIbTgYuBhnPdfqgJsIw5+LUq7QGz+
X-Google-Smtp-Source: AGHT+IGYpi+JoZQQhZs6O9IGtu4xCEk7HDlQGqsFix4wK+iUDPMnsk44RBBVGjW3KWF1sH0f2+qryiAODhA56J1feEs=
X-Received: by 2002:ac5:ccf2:0:b0:4eb:ddd:4b95 with SMTP id
 71dfb90a1353d-4f6a8cf0f99mr376295e0c.0.1721715950983; Mon, 22 Jul 2024
 23:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720165441.it.320-kees@kernel.org> <Zp4spjsaqQ85fVuk@elver.google.com>
 <d91ed522-9df6-4a83-9cc4-9f71f160f3e4@nvidia.com>
In-Reply-To: <d91ed522-9df6-4a83-9cc4-9f71f160f3e4@nvidia.com>
From: Marco Elver <elver@google.com>
Date: Tue, 23 Jul 2024 08:25:14 +0200
Message-ID: <CANpmjNMzNLBmUa4VgEEibmmD3fS6ZwOjq2tKxmR_H=45PaaJtA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: KUnit: Update filename best practices
To: John Hubbard <jhubbard@nvidia.com>
Cc: Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 01:49, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 7/22/24 2:55 AM, Marco Elver wrote:
> > On Sat, Jul 20, 2024 at 09:54AM -0700, Kees Cook wrote:
> ...
> > I'm more confused now. This is just moving tests further away from what
> > they are testing for no good reason. If there's a directory "foo", then
> > moving things to "tests/foo" is unclear. It's unclear if "tests" is
> > inside parent of "foo" or actually a subdir of "foo". Per the paragraph
> > above, I inferred it's "foo/tests/foo/...", which is horrible. If it's
> > "../tests/foo/..." it's also bad because it's just moving tests further
> > away from what they are testing.
> >
> > And keeping tests close to the source files under test is generally
> > considered good practice, as it avoids the friction required to discover
> > where tests live. Moving tests to "../tests" or "../../*/tests" in the
> > majority of cases is counterproductive.
> >
> > It is more important for people to quickly discover tests nearby and
> > actually run them, vs. having them stashed away somewhere so they don't
> > bother us.
> >
> > While we can apply common sense, all too often someone follows these
> > rules blindly and we end up with a mess.
> >
>
> Here, you've actually made a good argument for "blindly" following the
> new naming/location conventions: it's easier to find things if a
> standard naming and location convention is in place. Especially if
> we document it. Now if only someone would post a patch with such
> documentation... :)
>
> I would add that the "_kunit" part of the name is especially helpful,
> because (as I mentioned earlier) these tests really are different enough
> that it's worth calling out. You can run them simply by loading the
> kernel module.
>
> So if I want to quickly run kunit tests, searching for "*_kunit.c" does
> help with that.

That's fair, and I'm not too hung up about _test vs _kunit. But that's
only a tiny change of the new rules, and not the main thing I pointed
out. My main point above was about the suboptimal guidance about
where/when to introduce the "tests" subdirectory.

Thanks,
-- Marco

