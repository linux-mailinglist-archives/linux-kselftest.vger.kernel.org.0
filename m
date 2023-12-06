Return-Path: <linux-kselftest+bounces-1293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B7807379
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A66282030
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84C3FB2E;
	Wed,  6 Dec 2023 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDUxckXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC92D62
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701875644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDBnyP1g1RG8X2pWpNL9U6g9VK+bR9BnvKJLC9D2B9Y=;
	b=iDUxckXpbUkV0lK/3oqmUOfbhjunx/VT+OJlQNDAXlT9d/8td1o9CpT9NiWAZu4mn5rai3
	wRG2dpGiss3BGfWoDVXDghY7HtRmnecJfRGhWlBj9HNV5zB1q/QEcwqh2Iu3QrGhz6XxYO
	/6L93rDtUfRh8YQuZ7rRzI65qrgzH9o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-nAXxfhxbPRO8rZkBmSMgHw-1; Wed, 06 Dec 2023 10:14:02 -0500
X-MC-Unique: nAXxfhxbPRO8rZkBmSMgHw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1ae30a04ffso81633666b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 07:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875641; x=1702480441;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDBnyP1g1RG8X2pWpNL9U6g9VK+bR9BnvKJLC9D2B9Y=;
        b=rRbLrFO5oo6bD9U3ULViZzeFIUkXG3tPMdpi4pZCeF9Zv5EuBCfXTk1vvMiDSWFAdz
         JSe4wMUnNwdTItLLovbKVkUr0ibU+U/KvgdWgiVAgDPKZEnStHh5X7UKy70CYgyIyEpr
         ilmRde6zXjYzYdg8rA1eYJoQiwEVlkeNOTtyHUMKHpQ00tit8CtINzpH5xJAy8Y/NxSH
         RsMNOQXS2MOr8Z95nGsCfT8FJaIOGvEpaDw2c9QgfejJjd2tqBqfDQXYx9ftGAZp3F1U
         IB50YgSMocQ4RbnaRoTfTeJtBcLUUkwz7MwTm3sUbETo4SSQ+TOfQ2dMYOtuMnpwrd+/
         qF6w==
X-Gm-Message-State: AOJu0YwnarBoGDeYcQ4b/p3VEfwtFryOsUnr5KYqWE6/mWTp0hYCrsGd
	2VJFoR/QHFtlHNl98jn5A66h2NiQ5+w+ybLuBMHy221DHowLK2A+t3N+izLUS+es5L/ySC66/jn
	1xnqlAqEaMS0AxXV2AnGbKPKBXVK2p9YmF/Qm
X-Received: by 2002:a17:906:7f08:b0:a1d:1c71:8158 with SMTP id d8-20020a1709067f0800b00a1d1c718158mr1376391ejr.4.1701875641534;
        Wed, 06 Dec 2023 07:14:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH4g3R2HEOI3zDVywah2i1EzMR4lb37y99R2HGm/dv2ky/blvgh6Pw56PyopKcfjAyqvBjqA==
X-Received: by 2002:a17:906:7f08:b0:a1d:1c71:8158 with SMTP id d8-20020a1709067f0800b00a1d1c718158mr1376368ejr.4.1701875641118;
        Wed, 06 Dec 2023 07:14:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709064e5900b00a1aa6f2d5fcsm37351ejw.110.2023.12.06.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:14:00 -0800 (PST)
Message-ID: <70497ad83be1c7bd715abc8f29c72ee39a381f58.camel@redhat.com>
Subject: Re: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,  Shuah Khan <shuah@kernel.org>, David Ahern
 <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,  Po-Hsu Lin
 <po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>, James
 Prestwood <prestwoj@gmail.com>, Jaehee Park <jhpark1013@gmail.com>, Ido
 Schimmel <idosch@nvidia.com>, Justin Iurman <justin.iurman@uliege.be>, Xin
 Long <lucien.xin@gmail.com>, James Chapman <jchapman@katalix.com>
Date: Wed, 06 Dec 2023 16:13:59 +0100
In-Reply-To: <87jzpr5x0r.fsf@nvidia.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
	 <20231202020110.362433-2-liuhangbin@gmail.com>
	 <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
	 <87jzpr5x0r.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 13:32 +0100, Petr Machata wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>=20
> > Side note for a possible follow-up: if you maintain $ns_list as global
> > variable, and remove from such list the ns deleted by cleanup_ns, you
> > could remove the cleanup trap from the individual test with something
> > alike:
> >=20
> > final_cleanup_ns()
> > {
> > 	cleanup_ns $ns_list
> > }
> >=20
> > trap final_cleanup_ns EXIT
> >=20
> > No respin needed for the above, could be a follow-up if agreed upon.
>=20
> If you propose this for the library then I'm against it. The exit trap
> is a global resource that the client scripts sometimes need to use as
> well, to do topology teardowns or just general cleanups.=C2=A0
> So either the library would have to provide APIs for cleanup management, =
or the trap
> is for exclusive use by clients. The latter is IMHO simpler.

Even the former would not be very complex:

TRAPS=3D""
do_at_exit() {
        TRAPS=3D"${TRAPS}$@;"

        trap "${TRAPS}" EXIT
}

And then use "do_at_exit <whatever>" instead of "trap <whatever> EXIT"

> It also puts the cleanups at the same place where the acquisition is
> prompted: the client allocates the NS, the client should prompt its
> cleanup.

I guess I could argue that the the script is asking the library to
allocate the namespaces, and the library could take care of disposing
them.

But I'm not pushing the proposed option, if there is no agreement no
need for additional work ;)

Cheers,

Paolo


