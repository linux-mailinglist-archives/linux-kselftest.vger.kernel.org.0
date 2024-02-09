Return-Path: <linux-kselftest+bounces-4464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F584FB3C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E12EB2CDC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4BC80BF1;
	Fri,  9 Feb 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwe1+XiE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654F7F495;
	Fri,  9 Feb 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500566; cv=none; b=lmFwzqU9aFB7WZesyMZbb7XVlOvz07ZKL7FY4BFKM4tyn0C1VBuhTI6yvvU/OnzKRcXxsVK8lhMwf1i6oZZUIzgvK9Ud7ZfKc0nZN4pJqjos8dX1y4a8lI3iGwMIzRq1Ci8zPT20zHKnoNfMP5iptsOl2g7JxjHNVcpOs/ETNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500566; c=relaxed/simple;
	bh=rhNKLnhLe5HdzjzUzQi3KIpHEZzbdz1mv24bHXkl+jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Roc5cesTIQvB1jruGQmIGk8yUM7Jlfsh7sRyy/Ox+5C7LmoUg3r15/Umnr7xNLLVi0nQt5jLgxUtsBVCcXolX6zf0XTZmaCmfHhxa1lOtXz07kQQWAFDLjg/uCzCcNLgdH6qLBa5DELo4JMasS6lfjNg3ZOYFHvjTNYNi2Z7Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwe1+XiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E34AC433A6;
	Fri,  9 Feb 2024 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707500566;
	bh=rhNKLnhLe5HdzjzUzQi3KIpHEZzbdz1mv24bHXkl+jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwe1+XiER5ITd1d3ts0XDblUoiGl+P7lT7ji3B0DbaMM3hnax4NsrK+xTdIVAejtf
	 QwIweBs5EGSQxtHvzIuGIo/js78Ah43dLyMPJJAqrAKlWLeVFxkmfvDcZdMe4tfaGv
	 XrChnDO09zfkeRqccBnSqqvcAJwpoSYn1F5yv0VXNKd64yw4ENqYkZrefnxSnPGypo
	 lE5XfLhfyRz/tuAtci8kFwDUtd+6WDcalDFzDdiJpTIVYuzPAMUvapyxtmM5jVtivT
	 Z7K/fiwlVJBO/R9zWXhhB3/RJkomAMMKPscDNd8xn180iubrrwLeoFF+zUHE0aOoXO
	 0Xehr2Nr8GLeQ==
From: SeongJae Park <sj@kernel.org>
To: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vijaikumar_Kanagarajan@mentor.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Date: Fri,  9 Feb 2024 09:42:43 -0800
Message-Id: <20240209174243.74220-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <4c17a7bb-c32c-4314-bd29-6d74b2413d54@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 9 Feb 2024 10:30:38 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:

> On 08/02/2024 21:29, SeongJae Park wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > While mq_perf_tests runs with the default kselftest timeout limit, which
> > is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> > AWS instances.  Hence, the test always times out.  Increase the timeout
> > to 100 seconds.
> > 
> > Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> > Cc: <stable@vger.kernel.org> # 5.4.x
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >   tools/testing/selftests/mqueue/setting | 1 +
> >   1 file changed, 1 insertion(+)
> >   create mode 100644 tools/testing/selftests/mqueue/setting
> > 
> > diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> > new file mode 100644
> > index 000000000000..54dc12287839
> > --- /dev/null
> > +++ b/tools/testing/selftests/mqueue/setting
> > @@ -0,0 +1 @@
> > +timeout=100
> > --
> > 2.39.2
> > 
> >
> 
> Added Vijai Kumar to CC
> 
> This looks similar to [PATCH] kselftest: mqueue: increase timeout 
> https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7 
> which was increasing the timeout to 180 however it's not clear why this 
> hasn't been merged yet.

Thank you.  I don't care who's patch would be picked, but hope any of those be
merged.  For more eyes, I'm Cc-ing contacts from
`./scripts/get_maintainer.pl ipc/mqueue.c` output.

> I have seen the same issue on v5.15.y so it's 
> very likely that we will need to apply this on all LTS branches not just 
> 5.4 as mentioned in Cc: <stable@vger.kernel.org> # 5.4.x

Yes, that's the intent of the Fixes: and Cc: <stable@vger.kernel.org> lines.  I
hope the lines to be added to Vijai's patch if it is picked instead of this.


Thanks,
SJ

> 
> Hazem
> 

