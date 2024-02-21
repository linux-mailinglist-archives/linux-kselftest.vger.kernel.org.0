Return-Path: <linux-kselftest+bounces-5220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D2185E68A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76052B26DC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B768563B;
	Wed, 21 Feb 2024 18:43:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB682D97
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540982; cv=none; b=Ce9HIt27FSnNDPpCCaDYr2m29vQbZTll20zYwfZANw9I5lAm0OeYenQ4P+FLykWRxbOpnk4KyMKNzKsjHbVGP7ygaIiiD1j+CmiJrjKxr9xD2OQOPXGK8AkV9fTwXCTNiHgRHtX5pdnVcWhhCXegCDKRIVVsBVFXFgrJ6mAgyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540982; c=relaxed/simple;
	bh=oVNuU9YKrLoRRfSZIlaOBQOx2be/Q856y3oTYpDUt0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=odfjBIzCNwyIVKWeb5LlfWAEr6NMdBYjX7TbaFILr9rgGjvxUsdZp50sR99zNhTQv+eu956H09yB+9vTKEiLwkcbaWtynqSUleQtZw7g2B03GYR/zMpE51b8xbCmro9Rw6c0e5Hpj7jwiQ4ABNJL+/4JE7d8hcaJWzN9j1qJHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-GLvlNxMfNvqvC1La6uR5dg-1; Wed, 21 Feb 2024 13:42:55 -0500
X-MC-Unique: GLvlNxMfNvqvC1La6uR5dg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7C188F5DA2;
	Wed, 21 Feb 2024 18:42:39 +0000 (UTC)
Received: from hog (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AF521C06710;
	Wed, 21 Feb 2024 18:42:38 +0000 (UTC)
Date: Wed, 21 Feb 2024 19:42:37 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Vakul Garg <vakul.garg@nxp.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] tls: don't skip over different type records from
 the rx_list
Message-ID: <ZdZEHTbRF_8aVzmu@hog>
References: <cover.1708007371.git.sd@queasysnail.net>
 <f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
 <20240219120703.219ad3b2@kernel.org>
 <ZdPgAjFobWzrg_qY@hog>
 <20240220175053.16324f4d@kernel.org>
 <ZdYBzKcmIorAO47N@hog>
 <20240221103330.2ae35871@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240221103330.2ae35871@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-21, 10:33:30 -0800, Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 14:59:40 +0100 Sabrina Dubroca wrote:
> > It's not exactly enough, since tls_record_content_type will return 0
> > on a content type mismatch. We'll have to translate that into an
> > "error".=20
>=20
> Ugh, that's unpleasant.
>=20
> > I think it would be a bit nicer to set err=3D1 and then check
> > err !=3D 0 in tls_sw_recvmsg (we can document that in a comment above
> > process_rx_list) rather than making up a fake errno. See diff [1].
> >=20
> > Or we could swap the 0/1 returns from tls_record_content_type and
> > switch the err <=3D 0 tests to err !=3D 0 after the existing calls, the=
n
> > process_rx_list doesn't have a weird special case [2].
> >=20
> > What do you think?
>=20
> I missed the error =3D 1 case, sorry. No strong preference, then.
> Checking for error =3D 1 will be as special as the new rx_more
> flag. Should I apply this version as is, then?

If you're ok with that version, sure. Thanks.

--=20
Sabrina


