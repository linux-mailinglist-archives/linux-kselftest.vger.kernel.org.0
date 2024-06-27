Return-Path: <linux-kselftest+bounces-12847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 465ED91A101
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E641F229A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC77346A;
	Thu, 27 Jun 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMAD5VKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3673451
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475145; cv=none; b=FaRTYommy/JiP19Jhzz3PcrTLXwPbn22CgqbP0VtYo8P9Upq/p02KCC7tt63XQjy+WiHkt99Uyt94JLHV8ggXIKmhxyJXfNHOTxcoOCdKU0MG5mrqYWcnXOef3oZDfhYzoKb+8UD2myCVd/P/phdJH3+XmBx6bX3yqQKutq8fRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475145; c=relaxed/simple;
	bh=xcU1eFpqgSU/Bh/CKmAiD64jwZruaevOEqyVUKJm0pM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2zVwe+xVkLagIAoLzSGErhsEeszrYe9T1dDu9lb8woFFxo+d3wfNyStJPstB5QaSDsMLGSacrPR+dcQAVzIgAXf+EkwsBIbeH5tuwXHfid6NhqnOIA/DZQx/VkAx6McqdBeaWMCyb5gn7EOT3bwZeVmK7lcFBMOGoNTmSqrkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMAD5VKo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719475142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeushS7zvrpsIs8SYBcVSJVunv4P3aSomIKJ3BjOrcI=;
	b=LMAD5VKoUjavtby8V8bi29WRLeb3awsds7IJuhdleTap4Ns2bACafjYymNP+JsN3Qf2aJv
	9+ZQnik0LkVMRZOV7Q9lsIMK8O0B/SSL8FpvzdxvMJMsjQlJMWuabo39NH0m/Tp5aEHZkE
	gJe+ItmeXWxMOqSQVvVkKjFtaOJzQm0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Xw44XBgSNB2ruARnoFNXLw-1; Thu, 27 Jun 2024 03:59:00 -0400
X-MC-Unique: Xw44XBgSNB2ruARnoFNXLw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c6f1c0365eso8709522a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 00:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719475139; x=1720079939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UeushS7zvrpsIs8SYBcVSJVunv4P3aSomIKJ3BjOrcI=;
        b=vj9kjzlQLCL8XfiZpt1x65kHRQWdPVmnAOGmuEUo4iatTO3ucVOmqxTC2vFC0wWRxd
         m7oxsXlfZm0VjGYPRpMAbvx1Y7lIDKm7zifIIjJzOOm/753S76ZuKjrKIUol4LE26GSU
         uwLiCInRz2/iC4uwbtQVy0UaBOJyFCutqGF10zNDzR140CeArtL7Ka2KEIOM3d0kXVof
         of/KAqKTB7FSLkSg8kw5NAXc9OosGjD5LuD/N38UdQ/T0IPw820R1j/tY5tkXLY6pXTo
         nORs2lWppiJeCtMR0XXNragQp7XMoF18RwckeOUjuIhIOH2H2Mvktf08dfEAyOHFbtWj
         YD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYDsXB3jMrkKJy0/jQ9qnQmoWVOukB5xQ5b/ORP9nD9T56hscmd9/HGUgtHwDRQrq8O1rjCPJ0G2S4JchGiUVrfC1HoQiZcMWjFa1wH3uF
X-Gm-Message-State: AOJu0Yzxuc63ceGL5wGmDA2AKcNkvkgUYx/+qh100SvNuK3LveMKe5fw
	/P/z6On5J5hi81vH8SwU9f073/tUheGId4rseLj5C5e5ji+aojuYkRv58VjTXKzO0vymTeH4N8q
	LjnKvgVOvws+0rAJAdvvXIaW1Y0PYJwBDWse19ifA7BNWhV69GLdxTBSYFA2nj1IJpuxweyF9Th
	eQfq4q/nMcgNZWw14RI+yoi+QNRLZTfnJtj7zG92kN
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1b22:dcce with SMTP id adf61e73a8af0-1bd1b22dd3dmr6599029637.30.1719475139136;
        Thu, 27 Jun 2024 00:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEhtQavUVxjiWNx9N6Un/I/J3BmWyhnPpVIhRhfNfnMVfGkd4OTnKCID/jsmdNPWflpzAhMX/5qaCB6D6jUe0=
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1b22:dcce with SMTP id
 adf61e73a8af0-1bd1b22dd3dmr6599019637.30.1719475138754; Thu, 27 Jun 2024
 00:58:58 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jun 2024 00:58:57 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-11-amorenoz@redhat.com>
 <3395bd94-6619-4389-9f07-1964af730372@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3395bd94-6619-4389-9f07-1964af730372@ovn.org>
Date: Thu, 27 Jun 2024 00:58:57 -0700
Message-ID: <CAG=2xmNfdAm1s1bDc6TZJL5wB3p+bOe-r=OwSm-RJ5zJ_3NqkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 10/10] selftests: openvswitch: add emit_sample test
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 01:15:21PM GMT, Ilya Maximets wrote:
> On 6/25/24 22:51, Adrian Moreno wrote:
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  .../selftests/net/openvswitch/openvswitch.sh  | 114 +++++++++++++++++-
> >  .../selftests/net/openvswitch/ovs-dpctl.py    |  73 ++++++++++-
> >  2 files changed, 181 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/t=
ools/testing/selftests/net/openvswitch/openvswitch.sh
> > index 15bca0708717..aeb9bee772be 100755
> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > @@ -20,7 +20,8 @@ tests=3D"
> >  	nat_related_v4				ip4-nat-related: ICMP related matches work with SNA=
T
> >  	netlink_checks				ovsnl: validate netlink attrs and settings
> >  	upcall_interfaces			ovs: test the upcall interfaces
> > -	drop_reason				drop: test drop reasons are emitted"
> > +	drop_reason				drop: test drop reasons are emitted
> > +	emit_sample 				emit_sample: Sampling packets with psample"
>
> There is an extra space character right after emit_sample word.
> This makes './openvswitch.sh emit_sample' to not run the test,
> because 'emit_sample' !=3D 'emit_sample '.
>

Wow, good catch! I'll get rid of that space.

Thanks.
Adri=C3=A1n


