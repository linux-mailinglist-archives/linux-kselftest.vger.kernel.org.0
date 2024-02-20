Return-Path: <linux-kselftest+bounces-5050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A485C33C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C621F24A48
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA6D7765F;
	Tue, 20 Feb 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuIoyNJB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9D76905
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452155; cv=none; b=YJv3Ph/Ak0Kdbk4XiDvJF6fLEj/QkTfeD0cG5V52l8UambME7AxTd1ABopNa5vSn93P8aF3Dh2VVgieszB5WZ7bxb6RpLOspVLKjpYVZh21oCBBX4LrBy1oFWCpoHlw9j3yCI7jPnXS7/YK66AhV2TVGsOa08HEVsvPapn623T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452155; c=relaxed/simple;
	bh=nLGu6Nb4bFkyvkAMslpI2+BlJqsZtI8Bze9aXNjf0Jk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b8Wes5S0bB/J5Is16o3CEr3EJ9xYDHIfTe3uMmAc8pROyJdDKmPt35j7CEd7Ah3xicEsmTuN6X3MngsI9/elEd2a9g0c9nUcneCsFldp6rHyT/9ct++iRd5nV1ZKJ6vYFA2YPIt7QyyBKMub3JwwMgDm01TVQoXJaYjALTulCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuIoyNJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708452153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YeqcILnxuh5l/4eD2MtYHXrzYLLCUoaxf6bJ3mGyrU=;
	b=CuIoyNJBiOgpjyrEGsRJPHTx6G+3yXagEsmM0R8u4pgn/zfZJehQcdCsG4xh+sk28SY1ZF
	XAPXFcq+8Del5CQmN5vqnHaZIq1GFRPRm3ggXU53MhhWh5fVN2SHJGDcdUQWkamX5XjPxD
	0FbHN76CtV9/NlYlK8P7SFlB4a+c/zQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-v2jcEkRlOfC-8UJMu6IJyQ-1; Tue, 20 Feb 2024 13:02:28 -0500
X-MC-Unique: v2jcEkRlOfC-8UJMu6IJyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DBE1871A85;
	Tue, 20 Feb 2024 18:02:28 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 79953400D784;
	Tue, 20 Feb 2024 18:02:27 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B
 Shelar <pshelar@ovn.org>,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>,  Simon Horman <horms@ovn.org>,  Eelco Chaudron
 <echaudro@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org
Subject: Re: [RFC 0/7] selftests: openvswitch: cleanups for running as
 selftests
References: <20240216152846.1850120-1-aconole@redhat.com>
	<20240219122855.1f1ad0ac@kernel.org>
Date: Tue, 20 Feb 2024 13:02:27 -0500
In-Reply-To: <20240219122855.1f1ad0ac@kernel.org> (Jakub Kicinski's message of
	"Mon, 19 Feb 2024 12:28:55 -0800")
Message-ID: <f7th6i3dnf0.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 16 Feb 2024 10:28:39 -0500 Aaron Conole wrote:
>> The series is a host of cleanups to the openvswitch selftest suite
>> which should be ready to run under the netdev selftest runners using
>> vng.  For now, the testing has been done with RW directories, but
>> additional testing will be done to try and keep it all as RO to be
>> more friendly.
>
> Would it be an option to make the output go into a dir in /tmp/ 
> instead of in place, in the tree?
>
>   mktemp -p /tmp/ -d ovs-test.XXXXXXXXX

That's probably the best approach.  I'll switch to it.

> or such?


