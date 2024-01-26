Return-Path: <linux-kselftest+bounces-3630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C446183DE74
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026961C229D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47211D6BD;
	Fri, 26 Jan 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daiM4fnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E271D545
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285941; cv=none; b=V5LRV0pWlXRq9JuGIq/391Xy4t3Tmu4szCcXubhR7u98LOrQpGD8x3vll9bLieWXBup+qt3cz0+i2SaPSZCUsgxksvtJ4bhurPA7KMaaEXDHSbowtcPxNcDGZx6NnsL2DpWJquwu6rhzkJ1hDQ7B3BEvbyMP+XggRQVZVcVV3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285941; c=relaxed/simple;
	bh=+frgNUH2ZlZhwZP2UO21VP36KfozIuygrIl6i1D+e7w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=C46ek9G6ZpokkTcBtoABVa/M7XBLt1HtKouHlA7ceqDm6dkVRyxD73z8Epg6kwegbW7e6q2aV1sJUM9sje2ZWAiAQjMwvhPFV0AXV9gQQiS0Is3HdxzvQaUiyyogWsxncjz2sCTaotYSa0Proe91g1Ab7kQBFdL374CBGAeMyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daiM4fnO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706285939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6RnvoYDcpPaS4iUg5kcJdLzlRXCzjAoYe4p9PjhV4aw=;
	b=daiM4fnOzVw3mMea15Swtxew67z/CZ9Lj8YhkLO+tmaNItneYt2R3IGOSBfX5XL8jZJEM4
	jkk627umGeLKuL+cOMXtGPOnasFU62nwoeVBmfwrEBX9YkyzkYT+5aXu3T5jQuPkC8BPbn
	9157xOmySSndxeIGCpXblgwNeOcgFPU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-IRAC04QZMeiIfD3hQUIYgQ-1; Fri,
 26 Jan 2024 11:18:55 -0500
X-MC-Unique: IRAC04QZMeiIfD3hQUIYgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92C0E1C07F43;
	Fri, 26 Jan 2024 16:18:54 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.33.141])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE2251C060AF;
	Fri, 26 Jan 2024 16:18:53 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Shuah
 Khan <shuah@kernel.org>,  Xin Long <lucien.xin@gmail.com>,  Florian
 Westphal <fw@strlen.de>,  Nikolay Aleksandrov <razor@blackwall.org>,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp tests
References: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
Date: Fri, 26 Jan 2024 11:18:53 -0500
In-Reply-To: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	(Paolo Abeni's message of "Fri, 26 Jan 2024 16:32:36 +0100")
Message-ID: <f7til3g130y.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Paolo Abeni <pabeni@redhat.com> writes:

> The big_tcp test-case requires a few kernel knobs currently
> not specified in the net selftests config, causing the
> following failure:
>
>   # selftests: net: big_tcp.sh
>   # Error: Failed to load TC action module.
>   # We have an error talking to the kernel
> ...
>   # Testing for BIG TCP:
>   # CLI GSO | GW GRO | GW GSO | SER GRO
>   # ./big_tcp.sh: line 107: test: !=: unary operator expected
> ...
>   # on        on       on       on      : [FAIL_on_link1]
>
> Add the missing configs
>
> Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Thanks for the fix.

Maybe we should also add the config for NET_ACT_CT since we will
invoke it on setup.  I guess there's some dependency that must be
pulling it in for us already so we don't explicitly call for it, but we
do require it in setup() if I understand correctly.  I don't think it
should hold up this patch though.

Acked-by: Aaron Conole <aconole@redhat.com>


