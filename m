Return-Path: <linux-kselftest+bounces-29919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E168EA757BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 20:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF64188B44E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5791C6F55;
	Sat, 29 Mar 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQb4YGbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413C1DF27D
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743277739; cv=none; b=NYSPTNMRjnnOUXPTHbtnzN9VHhN1HVJCSZD46ji5+RYW/jecx5G5qba0KOmj9MiltA+OQ6XLimXy+yhGz8MQz8KDJ9gYM8GFVsdUxE64DStJvuGPCVjcYz+h+jTWvKXPxXDPhFXyJTC0LSgV1sF7f1cUJH2TBykDhKFRuBkGrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743277739; c=relaxed/simple;
	bh=S2ETKIN3HmHFqIShbmrAWQBXkDhzl2QluIFt7rG1VLE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LujWE+C0K4XQvkqrWWGwEmyyhper+np4s5lZHHr4e55YfiQN31MAdWUec2w5bnm/vSMj4ZvJqSgXy8QX+2grEhkKDZ4ibXrirwZ8yvtmVQ2+m9xEdpy1chgsfh6hoLiPdb5BYj+0WXOX1wWOXcawRIl4OBoLRcFRBcN6lMFKaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQb4YGbw; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743277734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NrzsJEiSUtPBug58DYaBN5O7dfjQmdHlytyRfQtgL8=;
	b=oQb4YGbw8Y1wluPqYukbBkLBulwPbI4/P9Qiw12J4E5vQgg02ymJG/yoqXitiUgl+SocUx
	Ok4EWe/gNuYNS3fpEuuAZJrPkGxoB82V4QDQ5JHr/yjlYQv1FhSeBKJq4e5YUHeydH8xPN
	GwhIt/l9sKPt39DauEll12A5me7nkQU=
Date: Sat, 29 Mar 2025 19:48:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <42f679b4fac5f6425232e4873acb00d50a5fb8e3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] selftests/run_kselftest.sh: Use readlink if realpath is
 not available
To: "Shuah Khan" <skhan@linuxfoundation.org>, "Shuah Khan" <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>
In-Reply-To: <4424b86b-b80d-4fdc-ba56-5cea5dc0b9a4@linuxfoundation.org>
References: <20250318160510.3441646-1-yosry.ahmed@linux.dev>
 <4424b86b-b80d-4fdc-ba56-5cea5dc0b9a4@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

March 28, 2025 at 10:05 PM, "Shuah Khan" <skhan@linuxfoundation.org> wrot=
e:
>=20
>=20On 3/18/25 10:05, Yosry Ahmed wrote:
>=20
>=20> 'realpath' is not always available, fallback to 'readlink -f' if is=
 not
> >  available. They seem to work equally well in this context.
>=20
>=20Can you add more specifics on "realpath" is not always available,"
> No issues with the patch itself. I would like to know the cases
> where "realpath" command is missing.

Not all distros have realpath. In my case, it was an internal distro we u=
se on some test machines, so I can't really share much details about it.

Thanks.

> >=20
>=20> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> >  ---
> >  tools/testing/selftests/run_kselftest.sh | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >  diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testin=
g/selftests/run_kselftest.sh
> >  index 50e03eefe7ac7..0443beacf3621 100755
> >  --- a/tools/testing/selftests/run_kselftest.sh
> >  +++ b/tools/testing/selftests/run_kselftest.sh
> >  @@ -3,7 +3,14 @@
> >  #
> >  # Run installed kselftest tests.
> >  #
> >  -BASE_DIR=3D$(realpath $(dirname $0))
> >  +
> >  +# Fallback to readlink if realpath is not available
> >  +if which realpath > /dev/null; then
> >  + BASE_DIR=3D$(realpath $(dirname $0))
> >  +else
> >  + BASE_DIR=3D$(readlink -f $(dirname $0))
> >  +fi
> >  +
> >  cd $BASE_DIR
> >  TESTS=3D"$BASE_DIR"/kselftest-list.txt
> >  if [ ! -r "$TESTS" ] ; then
>=20
>=20thanks,
>=20
>=20-- Shuah
>

