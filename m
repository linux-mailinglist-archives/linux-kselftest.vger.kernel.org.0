Return-Path: <linux-kselftest+bounces-48391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB07CFD206
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 11:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334A13053392
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2430F923;
	Wed,  7 Jan 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFGvzwG4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kPwTW4Om"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FFF30DEC0
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780518; cv=none; b=dUgdDnWshorkdZeyVT0U4y76mjSjUS8T+w7oN4UHr0cjjiUpsiEA5ueYOX09aIokPnErQUg+sMWH7JaV2hFpBPSHrVUIF9ThFMlUScjQBCmUgrsPB6dHZb8M5GwFHouBW7Z16kIxYn0I3rsD4koOrfT9exqz/unjos2l1T+lRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780518; c=relaxed/simple;
	bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nj0KHpPRLqyEcexZN95t5dk6LrJStWSfhJkKziNe05T6GBRLOe8RjWhncukqzBaAxEbeVdYQUBopiCfoBD/YPsHcVc6XLSifzxxBtaRgLvFu7dGcXxlhlUS4ytfEqDgZQwyJNDk/3dzqt/gMP0+7KD8HAUtwwQOBkqsfKYvYX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFGvzwG4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kPwTW4Om; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767780516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
	b=RFGvzwG4Z/cUidSDzPkQ0hwgNT8CkQ4HAh/5TOmTUPqgbDGW595J/BZhc+3mjlUwjNchQZ
	IclSs19xwStQjzpreRAZhsI7QjUtt7XQCUcis3URW2WSG/kEImAzASv/JzBEHP5qNJPlr/
	Sa0N1Bhql6bIhOjLnvnHWhF7NhE5mIU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-cDdrCAgwPEGm8dOYsx6lwQ-1; Wed, 07 Jan 2026 05:08:34 -0500
X-MC-Unique: cDdrCAgwPEGm8dOYsx6lwQ-1
X-Mimecast-MFC-AGG-ID: cDdrCAgwPEGm8dOYsx6lwQ_1767780514
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b83623fd3bdso250559766b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767780514; x=1768385314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
        b=kPwTW4OmPZOq8dkMASjieQDDP71IZGZSvBo4P+B/hHs8ecwKum07/3dIx+jlNurR6T
         tFHRjy6joqUb8xqA1m0H+EFcJMwiWO3O9+p9QDVFKIHn0pviu2btT7fwfV112C/bQTYu
         bdq58Z+D7MHjvRHW9OncsNmzwRSWxw0QjLtksZF0ebDX9A9TxdsKV2e1nofzOxbqhFn6
         4ORI0dF1xK+uossrITq2Fbwjan21Vup0LRi3Ma1/dee2ioiEZQdp1IT1xaCs0UxNVduz
         COiudEo37NC1xd8U9td0Qo2/g1E9BuK91FjzG+zSzZOka/jNZmAUMYq8T8TJ1jW9wRI9
         JIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767780514; x=1768385314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
        b=OaCIwGK4H1j/Av8GRAL5XCi8kC2aXl4tAkr3uMD+rjHkFRUdeCFb9TK8fN0ulmilev
         AckYIS2xYfMDNnKu+c1kJMDUKgvvPb64SxGgRQ00AFeedH+KnQ2XFT1sfAuFf4MfXljh
         Zyuw8kUcQBPzxuzWHX2VanAyh4fn7+yoCDz6B6qwwK7AizZFqM0kanCRDYjLVxQj3vY9
         Ww3Bv+1lGe4UBNrBqfwDqXjt8Zw1pDKccPZRZtQJ7DACImQq029Fi09tp/b59uOu6R6y
         ckNM85Yy2lK2xnB21sPEREHGUCkk+UVPUS9KVHKAkVu/PoJmKeJl956MDF4KXBFJl+jx
         gC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAkYPftN+3mzsbdgH/ZOTztR3lkoWK3AEQrv0gQyneNSpD8lpP5WPHJTQ51E7O4s4OFwg+ET3L5vVW4kHbzlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvahSeT4F5pT2EBMmjPqJRxleBPkMM/ErNRUf7+kF676lLShwr
	TqpPXnboqDqeDQRMBKFqR/aHx8qcNB+cjU4tsquMLpvipmmHgFW67zuYmN6QVC1jFYIstnc9tWZ
	YAFq7bZ448OW8qdFyy7pXY0Fj37i+40PyPk7tEfdCYGxpgUP0rDMoFilFd0HKajJ92jCnyrUyyK
	Zi9yB2IKlZrfkiW5MvGR/Go3Az3WN19qVO8LKN4I7jN8pC
X-Gm-Gg: AY/fxX70CF0bhW2j+zmCxZC24/uKINzZXVPHV53xFYsdddg/obczzVNEHykNZVKDLyc
	iegkI6UN4pDCU1ZpoYjVuZyHiM1A4n495h0BPVWK5GH5015DsW7Gj3ACmlq1ajxWWDNMHRluP7s
	BB2CkRcKdF4/08YSReQzVcuIwRsXa1nareQNjDgykgTAwWbnPH4+q+Xpm5QLQsoJbehKs=
X-Received: by 2002:a17:907:3d4c:b0:b83:7fb8:1f54 with SMTP id a640c23a62f3a-b8445357b42mr206559266b.39.1767780513676;
        Wed, 07 Jan 2026 02:08:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE81GdeuNAEywjYesgsiMhu6sLL7zfN/AhZAkDb8gl/VOQRYao7CB3ma4keuKvaOSyaMMr5oeFFLjUFgp8dpuY=
X-Received: by 2002:a17:907:3d4c:b0:b83:7fb8:1f54 with SMTP id
 a640c23a62f3a-b8445357b42mr206534966b.39.1767780508499; Wed, 07 Jan 2026
 02:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767597114.git.xudu@redhat.com> <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
 <20260106145822.3cd9b317@kernel.org>
In-Reply-To: <20260106145822.3cd9b317@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Wed, 7 Jan 2026 18:08:17 +0800
X-Gm-Features: AQt7F2oOpa5k4FH9OvrOLzMFLUr2Dae6WSsV1U5PxQngfIFZxya3WX6skGieWRg
Message-ID: <CAA92KxkOYKA9vsihvk0FR58m4zgM8-oZVWGsLDYycnk4UWmQAg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 06 Jan 2026 17:14:05 -0500 Willem de Bruijn wrote:
> > For instance, can the new netlink code be replaced by YNL, whether in
> > C or called from a script?
>
> +1 looks like YNL is already used in net/ tests, and it supports
> the operations in question, so that's a much better direction.
> Please let us (YNL maintainers) know if there's anything missing
> or not working, IDK how much use the rtnetlink support in YNL is
> getting.
>

Thank you for the suggestion. I am looking into replacing the netlink
with YNL to reduce code. But after reviewing rt-link.rst, I found that
rt-link currently lacks support for VXLAN. Would more significant changes
 to the patch be acceptable if I switch to Geneve to leverage YNL?

--=20


Regards,

Xu


--

Xu Du

Quality Engineer, RHEL Network QE

Raycom, Beijing, China


