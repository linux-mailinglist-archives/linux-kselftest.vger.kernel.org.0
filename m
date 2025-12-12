Return-Path: <linux-kselftest+bounces-47468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A853CB7B92
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53831303E02B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F702749D2;
	Fri, 12 Dec 2025 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxibaOp9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1A220687
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765508805; cv=none; b=WduAv8pm57mJSLqNFDRQasJhRLRWnyNMQts5Cm/A9IWoqZngD/g+vKcuHz8502DnCvq7wZ5yKnEp4oEY9LW390lUtWH4p18f29bYkrE18QjZf/tkCZs8+EMhYm/gTArPAg/fcRWwX1mD66jWYE0po10/B3B687sPVzRWf93clwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765508805; c=relaxed/simple;
	bh=9eb39L65kAGJnCwM/1QruYSkApWmJoDivxop4vb4SZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksbhhabxIVeuh4FwOZVvJ594uJlK5yEEgCCSQ+QADpJEb+OE/qlaqEcwbmJyt4SC+6YxBpeUlF4HMPHNUc+eH2mtodL+yGKZubrBwpLVCTMFP7n0D4tdQy1W6/VagJUfaGG/hupNhSrdZ76GBJMJg2yL16W+qDZ3k5vBKkUqDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxibaOp9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765508801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79RBu1sB/suJPIq1HPzo4GbL8LvjGchoKhX3vbLfFRw=;
	b=IxibaOp9gCrwTiGEhJuRbFj43L1DW1GIdw0531+q+VtnxYdZJpdRJJb+EAof3DzQsZ552g
	wsFRsOa+cu5nNWuKEyQ6IORW9tQz9qnrK9AKgIO+vLvcU9xYM0DSpmdgSikVsmAnsXpJnU
	rF9uyHDnVPQJMHB3mZo/QfovB4kTcpA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-hrYBU8dTOgq6-vxNDfy35w-1; Thu,
 11 Dec 2025 22:06:36 -0500
X-MC-Unique: hrYBU8dTOgq6-vxNDfy35w-1
X-Mimecast-MFC-AGG-ID: hrYBU8dTOgq6-vxNDfy35w_1765508795
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536A11801312;
	Fri, 12 Dec 2025 03:06:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AAEC194C386;
	Fri, 12 Dec 2025 03:06:27 +0000 (UTC)
Date: Fri, 12 Dec 2025 11:06:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests
 in stress_04
Message-ID: <aTuGqxLmfu8vqBmM@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-5-csander@purestorage.com>
 <aTqJlLbAiup38hTI@fedora>
 <CADUfDZpaNEd2fq3_osmm4kvSevkbi_mo=5H1frXAHrOmQNc7tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpaNEd2fq3_osmm4kvSevkbi_mo=5H1frXAHrOmQNc7tg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Dec 11, 2025 at 06:57:51PM -0800, Caleb Sander Mateos wrote:
> On Thu, Dec 11, 2025 at 1:06 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Wed, Dec 10, 2025 at 10:15:59PM -0700, Caleb Sander Mateos wrote:
> > > stress_04 is described as "run IO and kill ublk server(zero copy)" but
> > > the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> > > test cases is duplicated. Add --auto_zc to these test cases and
> > > --auto_zc_fallback to one of the duplicated ones. This matches the test
> > > cases in stress_03.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> > > index 3f901db4d09d..965befcee830 100755
> > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > @@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
> > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > >       ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
> > >  fi
> > >
> > >  if _have_feature "PER_IO_DAEMON"; then
> > > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> > > -     ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > -     ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> > > +     ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > +     ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
> >
> > I'd rather to fix the test description, the original motivation is to cover
> > more data copy parameters(--z, --auto_zc, plain copy) in same stress test.
> 
> test_stress_02.sh ("run IO and kill ublk server") already covers plain
> copy. But sure, I can change the test_stress_04.sh description to "...
> (more features)" or something.

oops, stress_02 is same kind of test with stress_04.sh, I missed this point.

Your patch looks correct to make stress_04 for covering zero copy only.

Sorry for the noise.


Thanks,
Ming


