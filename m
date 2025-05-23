Return-Path: <linux-kselftest+bounces-33664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF9FAC28A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FB89E1D63
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA2D298C1F;
	Fri, 23 May 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U14N00Sx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450BF2989BC
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021364; cv=none; b=DnEQvaGQCrfSXZbru9GP7Wmazm68a8ULHz8+b5dbK4QVc63Y0cnseGo5+2D/ZXoPV2+NCSo6p0l1wV0d7myqRwOxbkvOMbz+BsHbygbE6h8Y45G156JAXRgj6j2ZU/eh2BZV1blqjzzJYqUXYnoPqGZ5Kjn5gpOr/qOqpRX/MIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021364; c=relaxed/simple;
	bh=8wJq7CJj1ACgt2A1eG9/dKcPUVrCSJCqNlO3bxAC0Vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AL1TYzlDo5paoco4dam/ykvrn5cVvr9bJ6LBTrdRw0hhxgJZTHXPUF266fpZ+3cCl6w++nykKP7JMeUqmcD/z2mfqkt5ydvXicilEgFXSJO1DgtmEcK3lT4y1egy+o/6o5bzuOXeCaAtigQPm0w6iEQl7BrVlK9QXFt3590oY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U14N00Sx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748021362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wJq7CJj1ACgt2A1eG9/dKcPUVrCSJCqNlO3bxAC0Vw=;
	b=U14N00SxjK5PTga5vT+qMbHe1b0vIiWUumWNS2GW5U4gqP69NkU/td0epsY1KA3t9OM1b5
	SkfzwOfH4yhMyDaX+6SjkSKJdGWgxA0CXddwyibTEf5M9IEN/e/2mdyvz5+6MkxGT3+xLh
	FRRQHN4PtxCr28SPWhnjCNynWKmMCtY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-ZLqVJvnAN7qYVfeu9S3-0w-1; Fri,
 23 May 2025 13:29:16 -0400
X-MC-Unique: ZLqVJvnAN7qYVfeu9S3-0w-1
X-Mimecast-MFC-AGG-ID: ZLqVJvnAN7qYVfeu9S3-0w_1748021354
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39EA1180034E;
	Fri, 23 May 2025 17:29:13 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37F29195608F;
	Fri, 23 May 2025 17:29:07 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
Cc: <pablo@netfilter.org>,  <kadlec@netfilter.org>,  <davem@davemloft.net>,
  <edumazet@google.com>,  <kuba@kernel.org>,  <pabeni@redhat.com>,
  <horms@kernel.org>,  <shuah@kernel.org>,  <echaudro@redhat.com>,
  <i.maximets@ovn.org>,  <netfilter-devel@vger.kernel.org>,
  <coreteam@netfilter.org>,  <netdev@vger.kernel.org>,
  <linux-kselftest@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <skhan@linuxfoundation.org>,  <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] selftests: net: fix spelling and grammar mistakes
In-Reply-To: <20250523022242.3518-1-praveen.balakrishnan@magd.ox.ac.uk>
	(Praveen Balakrishnan's message of "Fri, 23 May 2025 03:22:42 +0100")
References: <4f0d5c19-8358-4e5b-a8f0-3adcee34ffd4@linuxfoundation.org>
	<20250523022242.3518-1-praveen.balakrishnan@magd.ox.ac.uk>
Date: Fri, 23 May 2025 13:29:06 -0400
Message-ID: <f7tldqn9qxp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk> writes:

> Fix several spelling and grammatical mistakes in output messages from
> the net selftests to improve readability.
>
> Only the message strings for the test output have been modified. No
> changes to the functional logic of the tests have been made.
>
> Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
> ---

LGTM - thanks for fixing the ovs-dpctl.py output.

For the OVS test

Reviewed-by: Aaron Conole <aconole@redhat.com>


