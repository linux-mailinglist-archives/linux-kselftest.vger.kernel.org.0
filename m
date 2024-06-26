Return-Path: <linux-kselftest+bounces-12815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B311F918466
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A08B28239
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB4185E7F;
	Wed, 26 Jun 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjLtrndE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B81F61C
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412349; cv=none; b=eOcC1JEGrH+X/65ON5/yoA/OQjP3Rmnoje4EJaXrr+Fni7EF8CyO3PIE4AzVNyEzIlITiC3uqNc0g2oTcnQhFR+fFSj2t5V/tPH7mZ9KyLKPQJMY2kayA065Nm0Ln1Oxyzl51vaGiSju/bpmKc8wuLO6Bj0xmymFjmIVmxG3Xkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412349; c=relaxed/simple;
	bh=FRcskTMvxcn7d37tsgbcNOUWozKStoLxBLjLpC+8CY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NlEthUV7Hh+rKXnJy8r7evdOtClo07yUJ8aTdA/309fDPGygOXGNPO7dTntSz9f3X2tfgAK+p4caFI2fYRgCI8Op1jhgOUMtwN6edU0P2KioWErRkwLkZPX5N41k/fMMnzrGBsmwzUuRoN/CgnEnmAU0StcNH/Pct+QvZw8JPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjLtrndE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRcskTMvxcn7d37tsgbcNOUWozKStoLxBLjLpC+8CY8=;
	b=bjLtrndE+1jdTZ5N7Fk8ISHVJjwEqargexbSlzw3jLep9r2r8BjMkGJ95WyB/7qv3qvlpy
	UsapgfBVl1lM853EdDti1WK6wh3J16q3V0GdQsTdtDvCqVv8Cj0LnYqD0Cqq6DFYPFp3nk
	ESByp8DBRt9iZ4ttTt1AUpRs1Yuzo0o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-vmX9JsasPHewxY5U2CTFyQ-1; Wed,
 26 Jun 2024 10:32:23 -0400
X-MC-Unique: vmX9JsasPHewxY5U2CTFyQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCD9D19560B3;
	Wed, 26 Jun 2024 14:32:21 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 606B33000601;
	Wed, 26 Jun 2024 14:32:19 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/10] selftests: openvswitch: add userspace
 parsing
In-Reply-To: <20240625205204.3199050-9-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 25 Jun 2024 22:51:51 +0200")
References: <20240625205204.3199050-1-amorenoz@redhat.com>
	<20240625205204.3199050-9-amorenoz@redhat.com>
Date: Wed, 26 Jun 2024 10:32:17 -0400
Message-ID: <f7tbk3ng4ge.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Adrian Moreno <amorenoz@redhat.com> writes:

> The userspace action lacks parsing support plus it contains a bug in the
> name of one of its attributes.
>
> This patch makes userspace action work.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


