Return-Path: <linux-kselftest+bounces-4893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE011858BE7
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FF528191C
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D0D646;
	Sat, 17 Feb 2024 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG2n4k1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD94C8F;
	Sat, 17 Feb 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129905; cv=none; b=eGX7k76LuvgMR16OTPFQkIWAkU1+y38Zw2rctbRR0Jx3vsC0nuKp68Xul6jzsqvXKFvSeEbNaK1liwLCnny84GcB/naU+iOCD+H+rJPahIYu7SY/UX2hytTW2cLZP3uDwbkLl5uiFWmT2uANtXPYlt5NYUVyF8Poz1sf4Rx9GuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129905; c=relaxed/simple;
	bh=J0wf0BwhyChpIzZH00msGosof2qX1pIKtcd0rpw6oGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qSbUzBTNBD0+EzmIu51vIfiOAcNEoWXqKFNLc3I4qKZ2zrs2228TnglZ0Q0ntINSxSVu7nGsicgP7kJTfh8omToyzY+5owhzMlqYXwuScrFWSHUIfNcAOvwIiQExlFJSEfqToEGd6ntWAw3YBt1yBimK+6f85xKeO7HJRci6G+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG2n4k1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7941C433C7;
	Sat, 17 Feb 2024 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129904;
	bh=J0wf0BwhyChpIzZH00msGosof2qX1pIKtcd0rpw6oGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KG2n4k1A9ocUdjbNIyx8ykEEvtCUYwyCAVplGH6C8TEfjTNsksN7YNZscUbmYQHBr
	 H2owTBWAI76L+Pd1HnsIytrljiADjoJqKkWijP90HEc9mfBT6hm+wH9YryyfF5r145
	 Q9n9w6C6XVrCPdIHCfSV+zvwIyRh5b8U3PEY4HTdjjJsd6wZsaAENoXgAw+/vEqcm1
	 l07ex6a9P3JR8Y0OX1G/W2CZlA/5MmpH3WtWhbQkSUMhxGW6XZvMPZWeT1EKRQ/6oV
	 LFRwoi5GNOWkztebJiVthMpAuJZ1h5r0XppmRepmItT9E1kx2z3dAIiHGJqm+HF2q0
	 i+5epM5IYJyOg==
From: SeongJae Park <sj@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vijaikumar_Kanagarajan@mentor.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Date: Fri, 16 Feb 2024 16:31:42 -0800
Message-Id: <20240217003142.86297-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202402161600.BF1D110BB@keescook>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 16:01:20 -0800 Kees Cook <keescook@chromium.org> wrote:

> On Wed, Feb 14, 2024 at 05:13:09PM -0800, SeongJae Park wrote:
> > A gentle reminder.
> > 
> > 
> > Thanks,
> > SJ
> > 
> > On Fri, 9 Feb 2024 09:42:43 -0800 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Fri, 9 Feb 2024 10:30:38 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:
> > > 
> > > > On 08/02/2024 21:29, SeongJae Park wrote:
> > > > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > > > 
> > > > > 
> > > > > 
> > > > > While mq_perf_tests runs with the default kselftest timeout limit, which
> > > > > is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> > > > > AWS instances.  Hence, the test always times out.  Increase the timeout
> > > > > to 100 seconds.
> > > > > 
> > > > > Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> > > > > Cc: <stable@vger.kernel.org> # 5.4.x
> > > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > > ---
> > > > >   tools/testing/selftests/mqueue/setting | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > >   create mode 100644 tools/testing/selftests/mqueue/setting
> > > > > 
> > > > > diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> > > > > new file mode 100644
> > > > > index 000000000000..54dc12287839
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/mqueue/setting
> > > > > @@ -0,0 +1 @@
> > > > > +timeout=100
> > > > > --
> > > > > 2.39.2
> > > > > 
> > > > >
> > > > 
> > > > Added Vijai Kumar to CC
> > > > 
> > > > This looks similar to [PATCH] kselftest: mqueue: increase timeout 
> > > > https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7 
> > > > which was increasing the timeout to 180 however it's not clear why this 
> > > > hasn't been merged yet.
> 
> Should it be 100 or 180?

As mentioned on the previous mail[1], either values are good to me :)

[1] https://lore.kernel.org/r/20240215011309.73168-1-sj@kernel.org

> Either way:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you!


Thanks,
SJ

> 
> -- 
> Kees Cook
> 

