Return-Path: <linux-kselftest+bounces-12941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0891C55A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 20:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406451C23391
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 18:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3829CE8;
	Fri, 28 Jun 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhZWivzM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A581E4A4
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597862; cv=none; b=BYSdkHt598DYBwGRBGGS8o6HEzRUV8RsqUG1UFKMkYJFDg1oiHV6xN8ZGPp5ucfEUlQiGZ3GYoDU7iW8/HUBQZ45lcMCb5AxOx/hHzmEj/mLQrcKXbdcWJoVRm5Rkiq9NNzMOHv0mpTuzet5yt7eO3K1fUIUwwnanKK9fwB5Glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597862; c=relaxed/simple;
	bh=8INhiaEBseC0RUfrZe+y+NnvAm1TXGbCqYcKCZQTiHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4QkSFY2wjddTKz0o1X7//2TpWvXc+IvWgCQTEnZZRPvhJVY1aPijsVwHrl2gWbUHHY6tusIG4p4ouKhOGY1KE2zy0M9YbjzzIOJwdPM//gb+EJ3qZvTIfVuu7wM1cGKHhZjjesxZ+U9GhJrt8iGKxqo0t8sTtlpqLKI2AFzEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhZWivzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719597859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vCcKq0rlbA23nf6T/8poZ7pjw4jSmiiuU2ZV4hmLMY=;
	b=KhZWivzM2ppEYY+t+AStQOv7vBXUuPh3c3NP7LCLqeobXJclGqX1wTMnTbKvnEmMZNqyO7
	CLFf8hei+LM05Cv4aXxCSoc1AnUHDTbMqF8mC5nNx0wNNX1xsEqfG904j3QURFrq67VDEW
	zS8nSuw/imGdbJHBZKqjHe67AZ2h5bA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-JM8l0Y2HPQG4pi1fyiiMsQ-1; Fri,
 28 Jun 2024 14:04:18 -0400
X-MC-Unique: JM8l0Y2HPQG4pi1fyiiMsQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DC73195423B;
	Fri, 28 Jun 2024 18:04:16 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 120F71956054;
	Fri, 28 Jun 2024 18:04:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Shuah
 Khan <shuah@kernel.org>,  Stefano Brivio <sbrivio@redhat.com>,
  =?utf-8?Q?Adri=C3=A1n?=
 Moreno <amorenoz@redhat.com>,  Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
In-Reply-To: <20240628081526.66a6b5c6@kernel.org> (Jakub Kicinski's message of
	"Fri, 28 Jun 2024 08:15:26 -0700")
References: <20240625172245.233874-1-aconole@redhat.com>
	<20240628081526.66a6b5c6@kernel.org>
Date: Fri, 28 Jun 2024 14:04:09 -0400
Message-ID: <f7th6ddx7ty.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Jun 2024 13:22:38 -0400 Aaron Conole wrote:
>> Currently, if a user wants to run pmtu.sh and cover all the provided test
>> cases, they need to install the Open vSwitch userspace utilities.  This
>> dependency is difficult for users as well as CI environments, because the
>> userspace build and setup may require lots of support and devel packages
>> to be installed, system setup to be correct, and things like permissions
>> and selinux policies to be properly configured.
>
> Hi Aaron!
>
> I merged this yesterday (with slight alphabetical reshuffling of
> the config options). The pmtu.sh test is solid now, which is great!

:)  Thanks!  That's great to see.

> I also added the OvS tests themselves, and those are not passing, yet:
> https://netdev.bots.linux.dev/contest.html?test=openvswitch-sh
> Could you take a look and LMK if these are likely env issues or
> something bad in the test itself?

I saw that.  I was looking for a place in the nipa repository where I
could submit a small fix, because I noticed in the stdout:

  make -C tools/testing/selftests TARGETS="net/openvswitch"
  TEST_PROGS=openvvswitch.sh TEST_GEN_PROGS="" run_tests
  
and I think the TEST_PROGS=openvvswitch.sh is misspelled (but it seems
to not matter too much for the run_test target).

From what I understand, there are two things causing it to be flaky.
First, the module detection is a bit flaky (and that's why it results is
some 'skip' reports).  Additionally, the connection oriented tests
include negative cases and those hit timeouts.  The default is to
declare failure after 45s.  That can be seen in:

  https://netdev-3.bots.linux.dev/vmksft-net/results/659601/91-openvswitch-sh/stdout
  ...
  # timeout set to 45
  ...
  # TEST: nat_connect_v4                                                [START]
  # Terminated
  # Terminated

This is showing that the timeout is too short.

I have patches ready for these issues, but I didn't know if you would
like me to submit config and settings files to go under net/openvswitch,
or if you would prefer to see the openvswitch.sh script, and
ovs-dpctl.py utilities move out of their net/openvswitch/ directory.  If
the latter, I can submit patches quickly with config and settings (and a
small change to the script itself) that addresses these.  If you'd
prefer the former (moving around the files), I'll need to spend some
additional time modifying pmtu and doing a larger test.  I don't have a
strong opinion on either approach.


