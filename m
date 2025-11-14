Return-Path: <linux-kselftest+bounces-45611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3DBC5BB10
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73BAE4F1E84
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E32C21DF;
	Fri, 14 Nov 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dP3Yqg5Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABC2652A6
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103911; cv=none; b=WDQf7pOtldLCGmn+KPqc+a7BbiQ3bYf8F66azcHEB0LcictOQit3zbTiHr9lFjiQ11EeuPLTCseXXnokqfWBcG4sGZC9EEDMumQSJr/PJYaidWTUGQzQLChfE/nw1Z1BmHapYAGVqCgb1BsLCOdXy0bS+Acj/O7zsLrGXH1jT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103911; c=relaxed/simple;
	bh=81bB82ka39OClX8Q0o7YIpWuPMYAslJbQmnQB3rWa5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0WKITHrKARV7iN8xG6j5OR8iP5ITj9uYnxa69i5fb3oxswc9r/EiFyGFKLOmBr8ghly6HqJlSpc+N5VPN3qfsiACK8OlpH9n7qpo6yOphsRGISad5U++u+NHZDCgKwfAQmtnSSeTHBzDJXF2tzYh/9mSDC+xQK+MJB+fCfXnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dP3Yqg5Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1282762f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 23:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763103906; x=1763708706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81bB82ka39OClX8Q0o7YIpWuPMYAslJbQmnQB3rWa5M=;
        b=dP3Yqg5YRz1v1Q8aouFcErFcfhiPzfUM9JGkna4dxwoB3xjXjDJyCwwW+lxNIa1XLB
         LbCSDAiYpv6q+oVSAiesQRMyBUgNRd2WrRNstFu2FnccM5TR+n5LklOjVEdAfiflWmcX
         nkZ+2IZVSwd3anq1ELSkQ1FcJPPxq/jLBNdF89KyvevG5m8TBpRWXtG5KYi9wbJ679VK
         qwpVdnJrQPY6DwAC//ltZneIYyMTa1kFY3ZwKvI7v1gj7XtQQsGK4g2LKuynhHkKTbhY
         Rqi3Tz2okA7lWpvJdtB1mw7XTNAgLmDFAa0YeT1uB2NfzKOjdHaH8yTb+eiA14xQ1UMm
         Jmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763103906; x=1763708706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81bB82ka39OClX8Q0o7YIpWuPMYAslJbQmnQB3rWa5M=;
        b=gMVIlpmwHpQYksBq4GNS8JKJvr4zF7YMH8EHsHm4cv69C2W/1slOgqazu4biUfuZdf
         6PnpjrOHbc6aVTMnmkHGxcZWG0lI+h8lJsLG1gyYhs4z5/5EseK56RrJgK8DrRpTW+/N
         raUQL3KHua4xuI0zPdTMBsMvn4sQDzSwkSQk6oIdFp7MiodovYTKkqr46RI2QL0SsxXm
         wtG/vdrWB+gIS6vahSDYhzYWuERFmEI+DhlUEwOrLuanscLlSUPfKwJeD0J4b8k7SZ4F
         cIsJ6QEjTfbApTyipEiGYEGLitSVjKF6Wng9Ei3unsGY6Q/nqpQQFysvcBYdxuqdS5XP
         VVwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyX4NMGyMJQ1I7u0Nbe0eKkEBHqmVG/jNnuFnVFs3cRdZ1ookniQNp2V9+a8jYtfclTzSt/2L61ydjsZG0ZeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6F0+YJyhk2XcjyewW6lge2MvXmwNz8b0CuUDc/NrK86jPP7F
	X1nZlaPC9TCXRKEVEHPc47cCkxGbRG+/LIfxBX45g4Q0JBJfagQHJoPeNMVuYd0GzLcR94aIpmf
	P0OWIzuUON3/a6/cQuqJx0QowsyfKahyU1nXoQOD4MQ==
X-Gm-Gg: ASbGnctZkU7GhNJJZUChi7VBiQMNZLnk12eNj/qTSKgK8xBno2tWcS3AdI+38NJccwm
	b8o9VZGHto8EVvPRjsJNF8B9ENMo3Boc6L6K11pjgWrQGvXgj2/JnjTQ6ppao26Mljtn+kpBlXK
	oRzRRzTxFnNfcm9lm1Cr1KFmz0eMLPGgakNnzfhAhrh3+vUhyK1Q7plJZI0TWgSn4iaN9OPSyAJ
	QFRFayr2HsX1DRFbWZ/8lHtzteVRYYeIrNfWQlM4/fU4ZZ2FGB2/qqy9Q==
X-Google-Smtp-Source: AGHT+IHZPORBx9Z6NEea2uQhhOChitNrQVS3plNh/xzXa5rtn5vFShG3ygCnLg/SG7mPe+IIGXme7azCutvRlaEIaSU=
X-Received: by 2002:a05:6000:4024:b0:42b:40b5:e683 with SMTP id
 ffacd0b85a97d-42b59349a6amr1680035f8f.23.1763103906496; Thu, 13 Nov 2025
 23:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf> <6916a904.9d0a0220.2b5e5.0b79SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6916a904.9d0a0220.2b5e5.0b79SMTPIN_ADDED_BROKEN@mx.google.com>
From: Sebastian Chlad <sebastian.chlad@suse.com>
Date: Fri, 14 Nov 2025 08:04:55 +0100
X-Gm-Features: AWmQ_bnKudVmCNylFi9hMvxUWZfrXa2eW_i6kp-gT9MEkjJisOwKPDQZu5R1KgE
Message-ID: <CAJR+Y9LG+qrvDdbufNpBqW4+8oPBrmY3eABJzXBm9Y_DPN4XLg@mail.gmail.com>
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: mkoutny@suse.com, tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 4:59=E2=80=AFAM Guopeng Zhang <zhangguopeng@kylinos=
.cn> wrote:
>
> Hi Michal,
>
> Thanks for reviewing and pointing out [1].
>
> > Could you please explain more why is the TAP layout beneficial?
> > (I understand selftest are for oneself, i.e. human readable only by def=
ault.)
>
> Actually, selftests are no longer just something for developers to view l=
ocally; they are now extensively
> run in CI and stable branch regression testing. Using a standardized layo=
ut means that general test runners
> and CI systems can parse the cgroup test results without any special hand=
ling.

I second that.
In fact, we do run some of those tests in the CI; i.e.
https://openqa.opensuse.org/tests/5453031#external
We added this: https://github.com/os-autoinst/openQA/blob/master/lib/OpenQA=
/Parser/Format/KTAP.pm
to our CI
but frankly the use of the KTAP across the selftests is very
inconsistent, so we need to post-process some of the output files
quite a lot.
Therefore the more standardized the output, the better for any CI.

Small ask: should we amend the commit message to say KTAP?

That being said - the cgroups tests produce nice output which is easy
to parse and gives us no issues in our CI apart
from the shell tests, specifically test_cpuset_prs.sh.

We currently run the cgroup tests only internally because some of them
tend to fail when crossing resource-usage
boundaries and don=E2=80=99t provide clear information about by how much.
That ties into my earlier effort Michal linked here::
https://lore.kernel.org/all/rua6ubri67gh3b7atarbm5mggqgjyh6646mzkry2n2547jn=
e4s@wvvpr3esi5es/

I=E2=80=99ll try to add the cgroup tests to the public openSUSE CI and will
test your patches.

>
> TAP provides a structured format that is both human-readable and machine-=
readable. The plan/result lines are parsed by tools,
> while the diagnostic lines can still contain human-readable debug informa=
tion. Over time, other selftest suites (such as mm, KVM, mptcp, etc.)
> have also been converted to TAP-style output, so this change just brings =
the cgroup tests in line with that broader direction.
>
> > Or is this part of some tree-wide effort?
>
> This patch is not part of a formal, tree-wide conversion series I am runn=
ing; it is an incremental step to align the
> cgroup C tests with the existing TAP usage. I started here because these =
tests already use ksft_test_result_*() and
> only require minor changes to generate proper TAP output.
>
> > I'm asking to better asses whether also the scripts listed in
> > Makefile:TEST_PROGS should be converted too.
>
> I agree that having them produce TAP output would benefit tooling and CI.=
 I did not want to mix
> that into this change, but if you and other maintainers think this direct=
ion is reasonable,
> I would be happy to follow up and convert the cgroup shell tests to TAP a=
s well.
>
> Thanks again for your review.
>
> Best regards,
> Guopeng
>
>

