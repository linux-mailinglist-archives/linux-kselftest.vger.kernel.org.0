Return-Path: <linux-kselftest+bounces-16329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5195F952
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 21:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202E01C21C36
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174E1991BA;
	Mon, 26 Aug 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdUJReRz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58875199E84
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698892; cv=none; b=mDAuSWzCqYi9sdKYh493tk8pLpv3wAE6xkDQC6lvNAIbDXTyCeQFvqyYtLlmediBt5R9NRIDmpysbRqzixVO8JBypRubLaLh0fcjsM/auNxAw46wqeGR6iQdy5/4NO1+sjJ3s/9MuWHSGLXM9ct5cK7MAC+bZp95JE2rW4cgg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698892; c=relaxed/simple;
	bh=RHjKSB/ygYXyjzR13aC6A+xJI3HGP7aMqOez4Yd74Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgV980SzF6yMqoZe+tlaGUk23NKTVHZn6jxlOUh/24H4QfhJnzoo4JNyhdSKIv0Cn+Zjcw5DWS3r/048qyBiVL6gKrwtyuP+149L8pegjoF53VB3n33NGTGklNhbjWY40kO6caSXY8HZOmWfeIfn+IjUA6c3TMlBgIp/Q4KFnwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdUJReRz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724698889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffl8OWKNM3UswhIKWAH58Ldi8KXDbvr9GP1qx7dNHBs=;
	b=VdUJReRzDwMN0qjN5SyF2hTBXptg/aiRBOfijojZBXxQ+sZLOhZ8WaEEuX4NpoC3u9bsIn
	nnyXDUP5G/wwT+bijwhffGWhJqXFora+4fVrhDJaxiPdcIX/yt3XnZBQqLg63VlP41bjB9
	h8tCLHS/rVoKPaY2PUWJRkXqP0lQO1E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-d8yCGcivOfe6CpDXcG1zSQ-1; Mon,
 26 Aug 2024 15:01:26 -0400
X-MC-Unique: d8yCGcivOfe6CpDXcG1zSQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 048721955BF9;
	Mon, 26 Aug 2024 19:01:24 +0000 (UTC)
Received: from [10.2.16.157] (unknown [10.2.16.157])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E74FD1956053;
	Mon, 26 Aug 2024 19:01:21 +0000 (UTC)
Message-ID: <ce01caf5-e576-4614-b6b8-0206da1a7c49@redhat.com>
Date: Mon, 26 Aug 2024 15:01:21 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 0/2] cgroup/cpuset: Account for boot time isolated
 CPUs
To: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240820195536.202066-1-longman@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240820195536.202066-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 8/20/24 15:55, Waiman Long wrote:
> The current cpuset code and test_cpuset_prs.sh test have not fully
> account for the possibility of pre-isolated CPUs added by the "isolcpus"
> boot command line parameter. This patch series modifies them to do the
> right thing whether or not "isolcpus" is present or not.
>
> The updated test_cpuset_prs.sh was run successfully with or without the
> "isolcpus" option.
>
> Waiman Long (2):
>    cgroup/cpuset: Account for boot time isolated CPUs
>    selftest/cgroup: Make test_cpuset_prs.sh deal with pre-isolated CPUs
>
>   kernel/cgroup/cpuset.c                        | 23 +++++++---
>   .../selftests/cgroup/test_cpuset_prs.sh       | 44 ++++++++++++++-----
>   2 files changed, 51 insertions(+), 16 deletions(-)
>
Ping! Any comment on these patches?

Thanks,
Longman


