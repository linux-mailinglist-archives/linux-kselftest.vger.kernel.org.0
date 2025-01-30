Return-Path: <linux-kselftest+bounces-25414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDCA22BA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9612B3A8629
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24D1B4257;
	Thu, 30 Jan 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdAvCTb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F7185955
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233253; cv=none; b=kYNK1cgvHtbmLnR/wjOvpjOxXVBkDBpemA2C1pUtlVfbXv7gRgUWeNUgG04XqaflQT3ig8gG0o9kbh/XnO6jUeSu+nScgpHOiaklZgPwuJMtA+1Thsgt11SWbUh75JJLeuwvSJyTySnmxLAzFS3GOcEDzLRhX49JbSM/z/NTjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233253; c=relaxed/simple;
	bh=lS1bEFcOQl3Z3qsCefy2wu140cxq5T+XxiPuugJCoCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NagjGmH+KQBUGPFkpmVNZEFzSycfU4oFCQ/IbLcx8kEomT2fbumN4OA1h2iGa1LdvZh3X05UCYuhCZMdkHXsdCRXorWhKb/or/fB5e669uv2oFwbiUYT69D1vh5TBkbugFWfLL3Vb131yUaYkBWbkJqSnr24wHDiND7og38dL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdAvCTb0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738233249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKqQ05QYoJSNu9wELFiytzHLcerxmQ7zrdUjCASu/9o=;
	b=IdAvCTb05TgfHQf9mKPEh8jIAb/Qz+zsbeA8qjAbJcK+VXKHmWhmz7EUe4FMdz6NpoH5F+
	FoNf2AGEFhzGr8rqzM0vsN2wUEy1BFTcCWo0tOidpDGMUlTyvlt1yJCXny6Ayg5YaxnDGJ
	ifMVzYCh4I+CMtFKzKVOnLpGVPL56tE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-hIc23d79NsOFirCQdD4RJA-1; Thu,
 30 Jan 2025 05:34:05 -0500
X-MC-Unique: hIc23d79NsOFirCQdD4RJA-1
X-Mimecast-MFC-AGG-ID: hIc23d79NsOFirCQdD4RJA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6438B19560BA;
	Thu, 30 Jan 2025 10:34:04 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F23D1956060;
	Thu, 30 Jan 2025 10:34:02 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
Date: Thu, 30 Jan 2025 11:33:58 +0100
Message-ID: <20250130103400.1899121-1-agruenba@redhat.com>
In-Reply-To: <dxumxyg5no5dc7ndslicm6v7dmkjkbrfr2wocsytin7jx6jdic@4utbjfwdcnqi>
References: <dxumxyg5no5dc7ndslicm6v7dmkjkbrfr2wocsytin7jx6jdic@4utbjfwdcnqi>
 <20250128163859.1883260-1-agruenba@redhat.com>
 <20250128163859.1883260-12-agruenba@redhat.com>
 <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
 <CAHc6FU6Yzk1Si37nRji-5uDZF9uaYo=G5tbtuS_5FiW6BDVTAg@mail.gmail.com>
 <rddasfmbw3ul2iezec7rgit2vxnv4p53uvoydck4b5jxuo44kq@7qlk5cru6w7r>
 <CAHc6FU7oZxP1cy6uihH=m9i=0z8PmCtozwQs2HgnqvbTDhAd_g@mail.gmail.com>
 <nxabgljkslxwr27wrzgjxao2nr3jh5leytj7f3pjir3t27uf5w@zcdmd4phur2m>
 <CAHc6FU7x8MbRLA9ELYiDM+Srz2FNzOzr28yztBA=CrPsj8X43A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jan 30, 2025 at 12:36=E2=80=AFAM Kent Overstreet <kent.overstreet@l=
inux.dev> wrote:=0D
> I've fetched it to my repo and added it to the CI:=0D
>=0D
> https://evilpiepirate.org/~testdashboard/ci?user=3Dkmo&branch=3Deytzinger=
=0D
=0D
Ah, the following went wrong in "bcachefs: convert eytzinger0_find to be 1-=
based":=0D
=0D
diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h=0D
index d3e8b9edf335..3afb346b0738 100644=0D
--- a/fs/bcachefs/eytzinger.h=0D
+++ b/fs/bcachefs/eytzinger.h=0D
@@ -308,7 +308,7 @@ static inline int eytzinger0_find_ge(void *base, size_t=
 nr, size_t size,=0D
 #define eytzinger0_find(base, nr, size, _cmp, search)			\=0D
 ({									\=0D
 	size_t _size		=3D (size);				\=0D
-	void *_base1		=3D (base) - _size;			\=0D
+	void *_base1		=3D (void *)(base) - _size;		\=0D
 	const void *_search	=3D (search);				\=0D
 	size_t _nr		=3D (nr);					\=0D
 	size_t _i		=3D 1;					\=0D
=0D
The eytzinger0_find() macro is still a bit of a mess.=0D
=0D
I've updated https://git.kernel.org/pub/scm/linux/kernel/git/agruen/linux.g=
it/log/?h=3Dbcachefs.=0D
=0D
Thanks,=0D
Andreas=0D


