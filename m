Return-Path: <linux-kselftest+bounces-24764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE4CA1665E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 06:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFAA1699D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C91865E2;
	Mon, 20 Jan 2025 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEJIN4o2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6617E472
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737350940; cv=none; b=LZBF72+WDZlMh3HYJzxAK62KGwNLqXo3qKh1145tSW+FtD4apbtmpNvQoIps4tW0wvWXHAE8ogxTw/jMrV1MtO7KhATG25ctbqEJP4t2YKV8g8x5oSvOa8ULctaiiimXeYvUvyDawIk9FetP3kBOgKLKlHdZIQS8AvZWFMu0BYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737350940; c=relaxed/simple;
	bh=d+MFB2tM0sfUZcCWcXFPkBef3mL5FOzhhCsK/ChhIR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7xFLYMB9iKU9aLipwtnKn2YSN86BV3iX0bD5vZbSP9JolLjYaezhPva5HkUZcxk9Hdu+WrZ9kVPBomNg9/1XpTyWBNnjCMoDqIImapDPnqDOJJdOczYolaZNOzMnF/b8uzLlgxKw7Y1oyfbu1jDkp+LXVTGw+f6VgV3mAkBeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEJIN4o2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737350937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBt1FxdvSzhvBE77j+CaarPfTFYF95LU/1h0hGm5sdk=;
	b=EEJIN4o2NTVlFEoKmqzDUmecpUkg82dirfQCIc3Txz7LQwbGEUFhD+q2XG00WtOCG4QbOC
	CzjeyIxJFIYuazmJ5geYJo6ypDo498TNUPOz5xW/J1kNDVlnH1ckfyp/KPpgS+f/nyiyRy
	6dcYInrb7yaPmBGZldoMYYlMg1RCKts=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-7RndWSoCM6-xgWK_UTZ3QA-1; Mon,
 20 Jan 2025 00:28:52 -0500
X-MC-Unique: 7RndWSoCM6-xgWK_UTZ3QA-1
X-Mimecast-MFC-AGG-ID: 7RndWSoCM6-xgWK_UTZ3QA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BC3B19560B1;
	Mon, 20 Jan 2025 05:28:48 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D1723003FD3;
	Mon, 20 Jan 2025 05:28:40 +0000 (UTC)
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
In-Reply-To: <82ee186ae5580548fe6b0edd2720359c18f6fa9a.camel@xry111.site> (Xi
	Ruoyao's message of "Sat, 18 Jan 2025 21:02:54 +0800")
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
	<20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
	<87y10nz9qo.fsf@oldenburg.str.redhat.com>
	<20241211-gemsen-zuarbeiten-ae8d062ec251@brauner>
	<82ee186ae5580548fe6b0edd2720359c18f6fa9a.camel@xry111.site>
Date: Mon, 20 Jan 2025 06:28:37 +0100
Message-ID: <87jzaqdpfe.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Xi Ruoyao:

> On Wed, 2024-12-11 at 11:23 +0100, Christian Brauner wrote:
>> On Tue, Dec 10, 2024 at 07:14:07PM +0100, Florian Weimer wrote:
>> > * Aleksa Sarai:
>> >=20
>> > > sched_getattr(2) doesn't care about trailing non-zero bytes in the
>> > > (ksize > usize) case, so just use copy_struct_to_user() without chec=
king
>> > > ignored_trailing.
>> >=20
>> > I think this is what causes glibc's misc/tst-sched_setattr test to fail
>> > on recent kernels.=C2=A0 The previous non-modifying behavior was docum=
ented
>> > in the manual page:
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If the caller-provided attr buffe=
r is larger than the kernel's
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_attr structure, the additio=
nal bytes in the user-space
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 structure are not touched.
>> >=20
>> > I can just drop this part of the test if the kernel deems both behavio=
rs
>> > valid.
>
>> I think in general both behaviors are valid but I would consider zeroing
>> the unknown parts of the provided buffer to be the safer option. And all
>> newer extensible struct system calls do that.
>
> Florian,
>
> So should we drop the test before Glibc-2.41 release?  I'm seeing the
> failure during my machine test.

I was waiting for a verdict from the kernel developers.  I didn't expect
such a change to happen given the alleged UAPI policy.

Thanks,
Florian


