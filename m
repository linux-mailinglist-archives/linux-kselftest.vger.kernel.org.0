Return-Path: <linux-kselftest+bounces-31972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0179AA3EA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84DC481E9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FD38FA3;
	Wed, 30 Apr 2025 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZcewtGx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363E2A8C1
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971770; cv=none; b=mWtYxW55f4oGg+QDdHfhZP+9S8/bAjwDstT6gO+763qqUuxKTueuunMbHhu6hL4BQGKE4temfnwiet63L7h9TBvk7qTTRjKmzD0vgU0EeDtBeZxZX7bE4j0vapHh9tWTMKUnRSJ77C2xZ9HMYsmHYB2+KyjxoroDuY53dqARjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971770; c=relaxed/simple;
	bh=nWIRVXNziIXV8U6vS6Ynr/rXvc0HzMyqYPWLe66JFJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcplAADpeLCpejtDyJGFJQ1yDjUd6UuBa8cpFDHxUBmL+dgwbZNEREtKbEyCRv/XcZ6dBRV7YmcmIBn+bTNfFr4AorGXR2i6is915EOKOu+lNblx4oxtKnesrbf2KkcjKS232oUPUqiUsD9X0Qo+Dw7sFvxkZFGTRJxjUat0ZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZcewtGx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745971766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lJzIa8zN478vM1h2v+0aBrpsB1V2UdrD0VW9ycWo8Y=;
	b=ZZcewtGxsDKusEYHltrwn9EMJ4DeisBkPcsqOTsfbRGi5l1/7D1WBdLFSILD2ZzzPS26mv
	1PkogHP7SUKzggs/lN4jQ9zaz8B9b2C+8zxqE0FzTaDOgPZn/32fjiiddWSJyAY/M/lmqU
	hNsX9NgACiW1EWSK2qnYn8L+kYuouxY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-qBZhgEgIOvWeqh89gKFP4g-1; Tue,
 29 Apr 2025 20:09:23 -0400
X-MC-Unique: qBZhgEgIOvWeqh89gKFP4g-1
X-Mimecast-MFC-AGG-ID: qBZhgEgIOvWeqh89gKFP4g_1745971762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8099180056F;
	Wed, 30 Apr 2025 00:09:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A1E919560A3;
	Wed, 30 Apr 2025 00:09:17 +0000 (UTC)
Date: Wed, 30 Apr 2025 08:09:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] selftests: ublk: kublk: build with -Werror iff
 WERROR!=0
Message-ID: <aBFqKZFAqwc5dEYl@fedora>
References: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
 <20250429-ublk_selftests-v2-1-e970b6d9e4f4@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-ublk_selftests-v2-1-e970b6d9e4f4@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Apr 29, 2025 at 04:41:03PM -0600, Uday Shankar wrote:
> Compiler warnings can catch bugs at compile time; thus, heeding them is
> usually a good idea. Turn warnings into errors by default for the kublk
> build so that anyone making changes is forced to heed them. Compiler
> warnings can also sometimes produce annoying false positives, so provide
> a flag WERROR that the developer can use as follows to have the build
> and selftests run go through even if there are warnings:
> 
> make WERROR=0 TARGETS=ublk kselftest

I thought WERROR is 0 default, but actually the default value is 1.

Just tried gcc 14/15 and clang 18/20, looks everything works fine.

For kernel selftests, I guess the usual way is to do it explicitly
by passing 'make -C tools/testing/selftests TARGETS=ublk'.

Even though the build fails for people who is running the test on purpose,
or doling whole kernel selfests, they still can:

- report the failure

- skip ublk test by adding 'SKIP_TARGETS=ublk' to command line

Also this ways has been used by perf, lib/api, lib/subcmd and lib/sysmbol in
linux kernel tools/, so I feel the change should be doable, but let Jens decide
if it is fine to pass -Werror at default:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Otherwise, it still can be enabled conditionally with default off.


Thanks,
Ming


