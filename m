Return-Path: <linux-kselftest+bounces-24780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4339BA169FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470FD3A4321
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9161B0425;
	Mon, 20 Jan 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYmQ0WSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38219AD8D
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366717; cv=none; b=SsyT/fiPbALKE96bYlHe3NRvD6snNXyjsh1Lfs/gjirndn2mUum5OBJjE3xa4WArYBgcM3lCqDua1WrPj8HHHhcyH3mtp2L4SlNyGXsyU0JXKQoi98Hjif+eEFfjzqSJxh6pygOpmzZMS/BXWhSXtaCeXcIpYX8gJMcJuvBjIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366717; c=relaxed/simple;
	bh=BOZ3s1t7hDYuX0/p3Oc5PPZqVuyuSG05BfhdZLtCcAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7ekm3CvStiryJ2CDIyzSzW+SornFUBtGXTn89GhH6ak7ZZjdTHxS8nHiLUkwL5o+33eN8I19+KBI/Mty+2MYXtFuVFioKUjeK4Bt5yQBi+Qto90U+AyW6avWAclqEfOmS3FUc415yL9v/y1x8m2lEAMCiHLYaaAjPhXzPt8AIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYmQ0WSl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737366714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpH1QAsie6Aj5+j+dKy2ZYT+MDiT5rB0nMJCwHs4fbU=;
	b=NYmQ0WSlAjyNEFQD3eVZKRc8ajPBVfoYx57CjJ/RLRpHgFBLOrOwTLJrR9uTGfoacEeQjk
	Xk+iqxuIeAphXATa9TW/Y71xfSemEWjkqhKxc1K9UE+yIk/vCcXq76RvF/YiJ9DCfb6/CF
	H075WOnN0ehzcvxVcUQpENF7woMzi+0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-UUSWLKhiOCyZY9Hl_a3XUQ-1; Mon,
 20 Jan 2025 04:51:50 -0500
X-MC-Unique: UUSWLKhiOCyZY9Hl_a3XUQ-1
X-Mimecast-MFC-AGG-ID: UUSWLKhiOCyZY9Hl_a3XUQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 898ED19560AA;
	Mon, 20 Jan 2025 09:51:46 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58E1019560A3;
	Mon, 20 Jan 2025 09:51:39 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>,  Aleksa Sarai
 <cyphar@cyphar.com>,  Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,  Vincent
 Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,  Arnd Bergmann
 <arnd@arndb.de>,  Shuah Khan <shuah@kernel.org>,  Kees Cook
 <kees@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,
  linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [PATCH RFC v3 02/10] sched_getattr: port to copy_struct_to_user
In-Reply-To: <b66580447aa94593136186a4046fd350e598943a.camel@xry111.site> (Xi
	Ruoyao's message of "Mon, 20 Jan 2025 17:21:08 +0800")
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
	<20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
	<87y10nz9qo.fsf@oldenburg.str.redhat.com>
	<20241211-gemsen-zuarbeiten-ae8d062ec251@brauner>
	<82ee186ae5580548fe6b0edd2720359c18f6fa9a.camel@xry111.site>
	<87jzaqdpfe.fsf@oldenburg.str.redhat.com>
	<b66580447aa94593136186a4046fd350e598943a.camel@xry111.site>
Date: Mon, 20 Jan 2025 10:51:36 +0100
Message-ID: <87r04xdd93.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Xi Ruoyao:

>> > So should we drop the test before Glibc-2.41 release?=C2=A0 I'm seeing=
 the
>> > failure during my machine test.
>> I was waiting for a verdict from the kernel developers.=C2=A0 I didn't e=
xpect
>> such a change to happen given the alleged UAPI policy.
>
> But 6.13 is already released without reverting the behavior change
> now...  So is this the "final" verdict?

I had originally missed the Linux 6.13 release.  I've submitted a glibc
patch:

  [PATCH] Linux: Do not check unused bytes after sched_getattr in
  tst-sched_setattr
  <https://inbox.sourceware.org/libc-alpha/87v7u9ddas.fsf@oldenburg.str.red=
hat.com/>

Thanks,
Florian


