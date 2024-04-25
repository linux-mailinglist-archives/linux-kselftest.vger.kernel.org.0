Return-Path: <linux-kselftest+bounces-8882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4E08B2961
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C11C21948
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67642152E0E;
	Thu, 25 Apr 2024 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLJkMQS2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48A815253F
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075485; cv=none; b=gngdYrMntH2QzeLa/fQiZjZG7XDTaOPD+H6MV325GAfkOYBwpuY/zmFjfHqVfTpoId2qR7jBLMMx/aJDSqg+oRR1MIwYu2/GveBukpIspeoL32ajwjv2CLvHu1l9MUoIS+1QrKatc6VNyVbO+wcthcctYxxb38WR6PhRxuIvN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075485; c=relaxed/simple;
	bh=Vl4naPZ+M9zhxl2iiW3r7jXEsNcmJy33cza9OfjzaaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m0W3OJMlA24DDTW2H230GOfyp9YSLaGZ4iqK54OtMkSnmzjwkQKPzoQkv3pei1ZGHoHxZA9yF694n3Iw0n2kGwOOCTpJORiREVr11taXFqAVP9N1jTQTpl9gb0TJDhp7Ib4V8FPTzET1mD+haSksCz/oRWRrZTi02hRG6XyiVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLJkMQS2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714075482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qxE6XochzTWopeOrnU+9zZscC0cF4tZlDCAfcT1tbuA=;
	b=XLJkMQS2Au1QehdzWHMfkTvDI0K386M6hJfzCUGc/rEvN/RABtWatXcxTtc2MQOFkSegED
	Zx1c06Y9PTgJA6mlQT0w0UX21zS1Z65x3aCDVonqrNMFojllB/B87L0nqKOuNKAyJzjro+
	MJJGMTeN4su+fi5w3BCL7klG/HSYAl0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-3Fw2uxqpPMOnYT6G7ely5w-1; Thu, 25 Apr 2024 16:04:36 -0400
X-MC-Unique: 3Fw2uxqpPMOnYT6G7ely5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B841780021A;
	Thu, 25 Apr 2024 20:04:35 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.33.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 741D0200A5C5;
	Thu, 25 Apr 2024 20:04:35 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,  dev@openvswitch.org,
  netdev@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
In-Reply-To: <20240425122151.1d5efcc2@kernel.org> (Jakub Kicinski's message of
	"Thu, 25 Apr 2024 12:21:51 -0700")
References: <20240424164405.GN42092@kernel.org>
	<20240424173000.21c12587@kernel.org>
	<20240425082637.GU42092@kernel.org>
	<20240425185719.GV42092@kernel.org>
	<20240425122151.1d5efcc2@kernel.org>
Date: Thu, 25 Apr 2024 16:04:35 -0400
Message-ID: <f7tsez98azw.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 25 Apr 2024 19:57:19 +0100 Simon Horman wrote:
>> openvswitch.sh does not appear to have any dependencies on Open vSwitch
>> user-space. My understanding is that, rather, it makes use of
>> tools/testing/selftests/net/openvswitch/ovs-dpctl.py to talk to the Kernel
>> using Netlink (which is also what Open vSwitch user-space does).
>> 
>> My brief testing indicates that for this the only dependencies
>> when running on Amazon Linux 2 are python3 and pyroute2.
>> 
>> I think that it should be possible to port pmtu.sh to use ovs-dpctl.py.
>> This would require some enhancements to ovs-dpctl.py to handle adding the
>> tunnel vports (interfaces).

I have some work from some time back:

https://github.com/apconole/linux-next-work/commit/61d2b9fc68a4e3fc950a24b06232c2fbcbfa0372

https://github.com/apconole/linux-next-work/commit/7262107de7170d44b6dbf6c5ea6f7e6c0bb71d36

https://github.com/apconole/linux-next-work/commit/af5338c9044660fa0eaaa967602aec706bbaeb5b

I was using it to try and build up a test to check recursions in the
datapath, but didn't get a chance to finish.

BUT most of the stuff is there, just needs to be cleaned up.  It would
at least cover the classic case, but the LWT support needs to be added.

>> As an aside, to run the Open vSwitch tests in pmtu.sh the openvswitch
>> kernel module is needed. So I think it would make sense to add
>> CONFIG_OPENVSWITCH to tools/testing/selftests/net/config.
>> 
>> That would mean that tools/testing/selftests/net/config also has all
>> the requirements to run openvswitch.sh. If so, we probably wouldn't need to
>> add tools/testing/selftests/net/openvswitch/config or otherwise do anything
>> special to configure the kernel for openvswitch.sh.
>
> That sounds great, for simplicity we could move the ovs files down 
> to the .../net/ directory. It'd be cool to not have to do that, and
> let us separate tests more clearly into directories. But right now
> every directory has its own runner so there's a high price to pay
> for a primarily aesthetic gain :(

Either one would work for me.  I will repost the RFC addressing some of
the comments.  It should be runnable in a bare VM that has the required
python packages that Simon notes (pyroute2 and python3).


