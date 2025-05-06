Return-Path: <linux-kselftest+bounces-32495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27FAABF2C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5B23B9D61
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182A266EEC;
	Tue,  6 May 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DymGlq5j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AD265CAF
	for <linux-kselftest@vger.kernel.org>; Tue,  6 May 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523208; cv=none; b=GilyCF8uJx8TAzu9L0P5w5JAeR0KR27pklUY6rahaHSwzh4Myn7fjPT3bi5v1X6u+j8E0zEYJUCa7zIMGIIEzAuzsKI+h7HFzG7irD9DdziGXFpDDaVlGgWjCNrLcKagHt3jqhwn/V1qm8+WrHeN+A4WEfzK68kPy0qgkfuayFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523208; c=relaxed/simple;
	bh=rbIKn6vykl25mUn46k6Ulst6D+PqqFgLtUeSd/b/CQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljx7W+2DJkgR2sJgq9ZpIDsVjmx1RKmMUAcm0qIcXReRtEl4MrccJX5MBTvOFi4KK25XP1wblPbMOWHZyt1B+iWT27j5NGmY9k/6tj9SEv25LBj/WjQnvkKcb6pI2SGZt0FzHVjSAvlptAcg3NsparhvWNkqU4zi4kEA5vNjq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DymGlq5j; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 09:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746523192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfU8XA6VcN5ylURdM0N9j42xeyDAlOsDsiJxsLmmqJ0=;
	b=DymGlq5jEFexT6p4LfMdlqWqcdKGbf6mk8wQmX12wCOHdgWBeqqamv3x3ztIcV/NdOzyex
	aDfww4HrCEi26RVYXPPCvNRGJoQNnkAUe9HVYv3qwaAVQooO05m05BVjzOUMzTz8J6/teQ
	7ZYiwletiIsg7SaMOp9gwz5Eq93Rv9A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/run_kselftest.sh: Use readlink if realpath is
 not available
Message-ID: <aBnUNFPz6buIdV-W@google.com>
References: <20250318160510.3441646-1-yosry.ahmed@linux.dev>
 <4424b86b-b80d-4fdc-ba56-5cea5dc0b9a4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4424b86b-b80d-4fdc-ba56-5cea5dc0b9a4@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 28, 2025 at 02:05:43PM -0600, Shuah Khan wrote:
> On 3/18/25 10:05, Yosry Ahmed wrote:
> > 'realpath' is not always available,  fallback to 'readlink -f' if is not
> > available. They seem to work equally well in this context.
> 
> Can you add more specifics on "realpath" is not always available,"
> 
> No issues with the patch itself. I would like to know the cases
> where "realpath" command is missing.

I think I already responded but I can't find my response, anyway:

Not all distros have realpath. In my case, it was an internal distro we
use on some test machines, so I can't really share much details about
it.

Are there any other questions that I can help answer about this patch?

> 
> 
> > 
> > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > ---
> >   tools/testing/selftests/run_kselftest.sh | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> > index 50e03eefe7ac7..0443beacf3621 100755
> > --- a/tools/testing/selftests/run_kselftest.sh
> > +++ b/tools/testing/selftests/run_kselftest.sh
> > @@ -3,7 +3,14 @@
> >   #
> >   # Run installed kselftest tests.
> >   #
> > -BASE_DIR=$(realpath $(dirname $0))
> > +
> > +# Fallback to readlink if realpath is not available
> > +if which realpath > /dev/null; then
> > +        BASE_DIR=$(realpath $(dirname $0))
> > +else
> > +        BASE_DIR=$(readlink -f $(dirname $0))
> > +fi
> > +
> >   cd $BASE_DIR
> >   TESTS="$BASE_DIR"/kselftest-list.txt
> >   if [ ! -r "$TESTS" ] ; then
> 
> thanks,
> -- Shuah
> 

