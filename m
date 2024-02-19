Return-Path: <linux-kselftest+bounces-4985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3785AFE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 00:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C81D282E27
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7675677D;
	Mon, 19 Feb 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRtigiwa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07E5478B;
	Mon, 19 Feb 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386872; cv=none; b=mFXoXSolDPDRvUUUkJrmUhGbMeh7wKdFwGtzatDdcUPMLDzqsVc+gfWZUIdhNhmw25sV265MlO1P5A4/PozYGxmTAPrObEoJf154+ap/ellNtoVAKiKw4cv7PIeOQn7yo5QN4PzkXjuPfEh7OVA5XHtIOPgzLCrI03NKsx0m6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386872; c=relaxed/simple;
	bh=QeDHhaJqxzviod2zL7H9Evl4rD2LSxF3WcsodiKIcWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKvJHf/LL9fPaa3mTN9qUDd3ASYxFJ8jsRRR44AnFf8jJXmSU7mw9IKaP36/XaEDh8X8flOkH+W4Vi+/lnAM/i6DgItPScxaqkHvJ4WfWtgD3oL7hrWMV0RuZHptIyg4fStIWSD44yrAzyDxugwTe6Bc6LMho5yadRd+8FPeYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRtigiwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63129C433C7;
	Mon, 19 Feb 2024 23:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708386872;
	bh=QeDHhaJqxzviod2zL7H9Evl4rD2LSxF3WcsodiKIcWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRtigiwaCwGFdaQcibAEmCQkQnntlgLSz5ACEFdQskrM+XOuwO6dsXIPtw4OKsdzp
	 biB1sBj2hFBNraQhapP+OTQF0VP0S50aXTlmdszB69+t+4L6EqRpd4L5hw2wUXPUtx
	 75hZANqklyyNYzqObWSCCi4Y/F1+Vqbo+hV3ueKfifDEymUxj2x6SxzLmUJUmdt566
	 GHGwUJaHPCQl5Zhs5enV00GQTOTiGRPbDPcqcR8Ninhmb2HVZPLz9dTQ5EU6oRc9k7
	 UYjhSDcxVMfw7S8a3wwL+oju1wObBiyma4KxwArOKREXOMb5o3K9voqALknNYReLsf
	 bCuX6r4g0+S4A==
From: SeongJae Park <sj@kernel.org>
To: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Cc: SeongJae Park <sj@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vijaikumar_Kanagarajan@mentor.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Date: Mon, 19 Feb 2024 15:54:30 -0800
Message-Id: <20240219235430.161792-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ee8b746b-aee9-43d8-949b-62017fe0bca0@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 14:01:06 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:

> On 17/02/2024 00:31, SeongJae Park wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Fri, 16 Feb 2024 16:01:20 -0800 Kees Cook <keescook@chromium.org> wrote:
> > 
> >> On Wed, Feb 14, 2024 at 05:13:09PM -0800, SeongJae Park wrote:
> >>> A gentle reminder.
> >>>
> >>>
> >>> Thanks,
> >>> SJ
> >>>
> >>> On Fri, 9 Feb 2024 09:42:43 -0800 SeongJae Park <sj@kernel.org> wrote:
> >>>
> >>>> On Fri, 9 Feb 2024 10:30:38 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:
> >>>>
> >>>>> On 08/02/2024 21:29, SeongJae Park wrote:
> >>>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> While mq_perf_tests runs with the default kselftest timeout limit, which
> >>>>>> is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> >>>>>> AWS instances.  Hence, the test always times out.  Increase the timeout
> >>>>>> to 100 seconds.
> >>>>>>
> >>>>>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> >>>>>> Cc: <stable@vger.kernel.org> # 5.4.x
> >>>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
> >>>>>> ---
> >>>>>>    tools/testing/selftests/mqueue/setting | 1 +
> >>>>>>    1 file changed, 1 insertion(+)
> >>>>>>    create mode 100644 tools/testing/selftests/mqueue/setting
> >>>>>>
> >>>>>> diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..54dc12287839
> >>>>>> --- /dev/null
> >>>>>> +++ b/tools/testing/selftests/mqueue/setting
> >>>>>> @@ -0,0 +1 @@
> >>>>>> +timeout=100
> >>>>>> --
> >>>>>> 2.39.2
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> Added Vijai Kumar to CC
> >>>>>
> >>>>> This looks similar to [PATCH] kselftest: mqueue: increase timeout
> >>>>> https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7
> >>>>> which was increasing the timeout to 180 however it's not clear why this
> >>>>> hasn't been merged yet.
> >>
> >> Should it be 100 or 180?
> Both options may work, I am more inclined to have this as 180 seconds by 
> giving more time for the test to finish, this can be reduced later to 
> 100 or something else if we start hearing complains about the new timeout.

Thank you for the opinion.  I will send v2 with 180 seconds timeout.


Thanks,
SJ

> 
> Hazem
> > 
> > As mentioned on the previous mail[1], either values are good to me :)
> > 
> > [1] https://lore.kernel.org/r/20240215011309.73168-1-sj@kernel.org
> > 
> >> Either way:
> >>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Thank you!
> > 
> > 
> > Thanks,
> > SJ
> > 
> >>
> >> --
> >> Kees Cook
> >>
> 
> 

