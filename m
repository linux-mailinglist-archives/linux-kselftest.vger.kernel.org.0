Return-Path: <linux-kselftest+bounces-13239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095AE928A23
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49F21F21227
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E614B96D;
	Fri,  5 Jul 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmWvdMo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD7143C46
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187366; cv=none; b=g9rPeibQR2nHIdNjqlwdqgwa/J68IKh8OA7ngUnCjEhUkzpiU0wYVmG3zbNbJcSQhpFiw95MQkbZst182QMp6PSPXx+ZANx+t74BQck97lRpyDRwWP8DVy8A3PtkYuHJ6fOw/Ji/Se8ZPeUjR0oXgkMy2MJLnA8zkkomCEsT4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187366; c=relaxed/simple;
	bh=CYfhURpn07Fl/KzClRYCrH1tzsYglzsR+DDcVMkuswE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aTVYPUSChAfkL2vqo8h7UN2vL504EDjenRQKeBa3NrkJi1XJqxJY6A6caUKfJdH2UYxeEeYZDS5S7eBzaDbYHV/olekHjjb5npPsxoCyGIGBIa6+Y/FbkKtGZxXIQhOqLCAWdi73SYPEw7cQbujXfjtMGX6Fp5FzDVp22DtL2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmWvdMo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720187363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=704ErwY8GGv8Ty+hDCVZyGwpzQ0W63+evkDASo4+BFI=;
	b=CmWvdMo54T+9tJEGiz7GzqMsrUX6vwSEkJH9o+bU11Nk4pKRw5+koqS4+wt0lLUGcTKdHy
	z9ThRz8GQBfB/QPFZ1aYUGmQ+R8xE3hAZ2uhKk/TGCV+NGkwAk8Zk2ATlaRUblC954/ZYw
	0Cs0epkFivbFlZonMEuMAa9SvWIi7AE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-wIiO7IoEOdey9EFV8Z5Oog-1; Fri,
 05 Jul 2024 09:49:19 -0400
X-MC-Unique: wIiO7IoEOdey9EFV8Z5Oog-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 710E81955F40;
	Fri,  5 Jul 2024 13:49:17 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73A251955F66;
	Fri,  5 Jul 2024 13:49:14 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Shuah
 Khan <shuah@kernel.org>,  =?utf-8?Q?Adri=C3=A1n?= Moreno
 <amorenoz@redhat.com>,  Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests: openvswitch: Address some
 flakes in the CI environment
In-Reply-To: <20240705062851.36694176@kernel.org> (Jakub Kicinski's message of
	"Fri, 5 Jul 2024 06:28:51 -0700")
References: <20240702132830.213384-1-aconole@redhat.com>
	<20240705062851.36694176@kernel.org>
Date: Fri, 05 Jul 2024 09:49:12 -0400
Message-ID: <f7th6d4ne3r.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue,  2 Jul 2024 09:28:27 -0400 Aaron Conole wrote:
>> These patches aim to make using the openvswitch testsuite more reliable.
>> These should address the major sources of flakiness in the openvswitch
>> test suite allowing the CI infrastructure to exercise the openvswitch
>> module for patch series.  There should be no change for users who simply
>> run the tests (except that patch 3/3 does make some of the debugging a bit
>> easier by making some output more verbose).
>
> Hi Aaron!
>
> The results look solid on normal builds now, but with a debug kernel
> the test is failing consistently:
>
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=openvswitch-sh

Yes - it shows a test case issue with the upcall and psample tests.

Adrian and I discussed the correct approach would be using a wait_for
instead of just sleeping, because it seems the dbg environment might be
too racy.  I think he is working on a follow up to submit after the
psample work gets merged - we were hoping not to hold that patch series
up with more potential conflicts or merge issues if that's okay.


