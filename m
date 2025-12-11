Return-Path: <linux-kselftest+bounces-47457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C09ACB74DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 23:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51AF53023A1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 22:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785F22578D;
	Thu, 11 Dec 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atgIWHxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAB178372
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765492241; cv=none; b=Mw/iahkGbB80yQ/Mn7QJnnUQUAQA2ezdzycxsB7xTBSp4UKA8+ut4SKHIFSwY8P3LdbW6PZso1TmLJemZLRC98p4SIvMYhqjG2cSK72rECFRhP5Udju8BEkVYLIFMwnSt1rxUD0uP30dW4WNPQZUHJyC3M8geGBvqReZpsfQ2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765492241; c=relaxed/simple;
	bh=4ZW56M6mqMeCPPk/Cgo0OT9/wALrJkG/9+V6xOlMlLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyeJrf495k18wx4s5lEYd2KpzvjTLGUb8Hj7pJl2UeusomGqEZ2AsnzUJh8ZY5zW52UKYWMegE5nKEE5fB/VXPNlv0O0Qh8lRsnmDT7Ehm38x0oH26Vl6yJFlQxCHem9juizt7xuAfWqRWIDyP2w/C/ZsiCklnh3QQg2VLP59Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atgIWHxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765492238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1FswJjs4lOfWUQqTXQJ+czd2WofQq4TJvPazjufzOs=;
	b=atgIWHxUj78S8z1Mp0h2mfjEc+svXWr/aS21gOzmjCk7IH1s7Kj07qCrXkPIUnFrZ5gqWD
	q2eNkcgIMZheXgYPL4K8s8KedLjnIARlk0Vu2leqC7GxPAwus9qU2O2ofxHPyp2OGuPvZz
	BwrD2/SnJK/nC2LibGwyHIB5OlGgslw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-aNrW3iINOH-EHeyb5b5xyQ-1; Thu,
 11 Dec 2025 17:30:35 -0500
X-MC-Unique: aNrW3iINOH-EHeyb5b5xyQ-1
X-Mimecast-MFC-AGG-ID: aNrW3iINOH-EHeyb5b5xyQ_1765492234
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AA4718009C2;
	Thu, 11 Dec 2025 22:30:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE0591800451;
	Thu, 11 Dec 2025 22:30:30 +0000 (UTC)
Date: Fri, 12 Dec 2025 06:30:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests
 in stress_04
Message-ID: <aTtGAeJlK3QqgpvD@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-5-csander@purestorage.com>
 <aTqJlLbAiup38hTI@fedora>
 <CADUfDZrR=4RhHa+wFTXMzqEMmCBcRKuAxY0q20PahjPFptNouw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrR=4RhHa+wFTXMzqEMmCBcRKuAxY0q20PahjPFptNouw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Dec 11, 2025 at 10:33:20AM -0800, Caleb Sander Mateos wrote:
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
> What about the duplicated "-t null -q 4 --nthreads 8 --per_io_tasks"
> test case? I can't imagine that's intentional...

OK, the last one may need to pass '-z' so that --per_io_tasks & -z
combination can be covered.


Thanks,
Ming


