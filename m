Return-Path: <linux-kselftest+bounces-12852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C163091A840
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31194B2150D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 13:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A7194C95;
	Thu, 27 Jun 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIZYK+j9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C7194AF5
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495983; cv=none; b=pfEwEhvc7lkYZdzHeOm6PLD7UOfY7K7azP+FssqbMEUSZhlULl6qqJlJKcEXfDvnwyiczVpvOMK/tTRkRG6sUfVsUpkARtFsPpxYza7yJZmAQxS//Ni7E46/sQV0yGiiEKiXLWSY4oMGaZCpnM9EvHFEdCav0+tAQiefbTiiNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495983; c=relaxed/simple;
	bh=CxN0i2o6jLJzZ1S+WrM3/09xy0WQOsRB0G06hcALGys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jgB3QKB+qpSn8zL1nsKd6xtP58R1Ia7wEiFja/gpID0oT7fGRMV+aC4SMA1BO5Qw+PmdhXr2vq7jbRwdN9IjnC4pm0NoUVMAk6I/4ZsA43A53gIDcJvfs7QBvJeyIZZw4zsNIQfoHGGTOJTsO+xhqQysn7TH7dFXbVcPRS74vX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIZYK+j9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719495979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2H2eOsk+IBvdW6vn90H4Ieju5WkyuY2eQ65TuxwaxSM=;
	b=JIZYK+j93avH/LfD4Fa1r1u/aAlAgRdQob/mzP2/1s3nHUy+EqqmiKkq/I0O3TpU5tnp2E
	/wbrfVW3ZtPzVPz9b/ivLjW3o6iFzKyM+f+U/omV3tMZxBz8H70CQz3JRJGQ7PohZZJEnz
	MLmh7ddWa+YiH3+e9m3od39/XZNsmcw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-Az17NnIyPkaoaB2ucf5FMg-1; Thu,
 27 Jun 2024 09:46:16 -0400
X-MC-Unique: Az17NnIyPkaoaB2ucf5FMg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 152BD1956080;
	Thu, 27 Jun 2024 13:46:14 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 595BC300021A;
	Thu, 27 Jun 2024 13:46:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,  Stefano Brivio
 <sbrivio@redhat.com>,  =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v3 6/7] selftests: net: Use the provided dpctl
 rather than the vswitchd for tests.
In-Reply-To: <20240626165455.GA3104@kernel.org> (Simon Horman's message of
	"Wed, 26 Jun 2024 17:54:55 +0100")
References: <20240625172245.233874-1-aconole@redhat.com>
	<20240625172245.233874-7-aconole@redhat.com>
	<20240626165455.GA3104@kernel.org>
Date: Thu, 27 Jun 2024 09:46:09 -0400
Message-ID: <f7t1q4izefy.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Simon Horman <horms@kernel.org> writes:

> On Tue, Jun 25, 2024 at 01:22:44PM -0400, Aaron Conole wrote:
>> The current pmtu test infrastucture requires an installed copy of the
>> ovs-vswitchd userspace.  This means that any automated or constrained
>> environments may not have the requisite tools to run the tests.  However,
>> the pmtu tests don't require any special classifier processing.  Indeed
>> they are only using the vswitchd in the most basic mode - as a NORMAL
>> switch.
>> 
>> However, the ovs-dpctl kernel utility can now program all the needed basic
>> flows to allow traffic to traverse the tunnels and provide support for at
>> least testing some basic pmtu scenarios.  More complicated flow pipelines
>> can be added to the internal ovs test infrastructure, but that is work for
>> the future.  For now, enable the most common cases - wide mega flows with
>> no other prerequisites.
>> 
>> Enhance the pmtu testing to try testing using the internal utility, first.
>> As a fallback, if the internal utility isn't running, then try with the
>> ovs-vswitchd userspace tools.
>> 
>> Additionally, make sure that when the pyroute2 package is not available
>> the ovs-dpctl utility will error out to properly signal an error has
>> occurred and skip using the internal utility.
>
> Hi Aaron,
>
> I don't feel strongly about this, but it does feel like the
> change to ovs-dpctl.py could live in a separate patch.

I can do it if others feel like it should be a separate change.  I
debated it as a separate patch, but I felt that it wasn't really a bug
fix, more like a behavior change that would be associated with this pmtu
script.  I didn't (at the time, and still don't) see a reason to
separately backport them, but it could also be considered as a separate
orthogonal change, and I'm okay with it being a different patch.  Like
you, I don't feel strongly either way.

If I do separate it, I will also add your Reviewed and Tested tags to
that patch.

>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>
> The above not withstanding,
>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> I have tested pmtu.sh with this change on Fedora 40 both
> with python3-pyroute2 installed, which uses ovs-dpctl,
> and without, which uses ovs-vswitchd userspace tools.
>
> Tested-by: Simon Horman <horms@kernel.org>

Thanks!

> ...


