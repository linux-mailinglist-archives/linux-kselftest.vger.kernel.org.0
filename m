Return-Path: <linux-kselftest+bounces-13180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D95927091
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77C7287767
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584961A2C00;
	Thu,  4 Jul 2024 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSorCOss"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5041A256C
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Jul 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078122; cv=none; b=G9b2S5/BuxupdZ5JG22iQi5Pclug47HO7BGXRtRwiGRQgq5dPRKZ/GiXiywFfyRYNjNEiT24xwsptSfF1GE3JKVOYVCxbNcSgRg4oLZpybdFtOVNQ+DKFFk6frqsv+k/POUVDiiD9eYkFrBfiLIvrsRWiFglBI6qmBTQ0+SW6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078122; c=relaxed/simple;
	bh=YXs8cgT/wMh5raP4CBIWj9ffPIuFhyYfSJpRvlOtqcE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIYZ0nWZ4gIBn51NQKG7RiLhgQTdyvNQU3vZut3AV0B6PtCaJzeXlkzzhTiU91xe81FoXPxGZDbJtX2lxANVC33eKDbhaCScZyG1J8qvSBGbwTJ/AlPhiy+AGThqoGVRD+4nxT+JtylGCq3auP/WSg8BTnlTEhqWE+NIoZcmk74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSorCOss; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720078119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvbJILSJxkt6UdWhQQUecUb1XAMG0H35Fa4mDS2O+Dw=;
	b=bSorCOssnmli7wtaBlDLpEhQ8TWw95eX0AStX1herO4Mm3MFQLtAjN7YybyxweuEIXxCFr
	QOA7+l0bAUM+zakGuFHjWSEZDNw8fpfk5qAqQ3hIb+RvyqUTbXoblGbv8OZdUnaVsvm4T8
	POpX94NP9QTkB7z8kB6RZeP1qjCIXJA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-IQDKsLoMPGOA3tpEm9eavw-1; Thu, 04 Jul 2024 03:28:34 -0400
X-MC-Unique: IQDKsLoMPGOA3tpEm9eavw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5ebdd8109so5203236d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Jul 2024 00:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078114; x=1720682914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AvbJILSJxkt6UdWhQQUecUb1XAMG0H35Fa4mDS2O+Dw=;
        b=O/miiRpDSKee5ePHe7E3LiYudLzhgYvg1wRlhqej0ypGAKlqvTkU/QsSVMg6HToFSb
         jCAMMgUQjsVYJHARX0h1bqw1FNua55YnBJ738oohvUTEvMGaFwKvmwna0Fw/7eecaRAW
         2rlEB9VDffnzmGr+8ErNQMg7rTj995lbmPLJEpGTBThYBMx54h+dwR7wpkTwMstwHi2n
         3KE/B5dE+vgOXNRtpAZrZmipnubRykVpUUNxKhfjx5EoUcGyFF/PaegUyvKzaqONiWKJ
         KuSgY6rZZJcvwqF+u8l1DaDLhC16QOYGC3bUYqWstlZJvIepDK1ZRwiwu9waB36QNPza
         ypWw==
X-Forwarded-Encrypted: i=1; AJvYcCXoED67gbAay6hGo5+ces/cC/Fheqk+oHSBvLptd1kwF2kA8sFVwN175t23nEfV2QCU8aC4dZ52xl6YNCYxo2aO6tcD8YT1NQGsyTvZ6Zzd
X-Gm-Message-State: AOJu0YznuB4PKlbu2Vr1GksVNzj2RFNa5dLb9jk+mocdsxfscWCD/zM3
	xoSUbLNnrsPC/L8r+zMZShmjKQXuuajpGv+uuyoyrImIADD1CNwcf8Wf9IwsUQdLRi97bLK/opx
	6zh6m/Ju2cwihyuJA8vd8iiz3ee7auQXBMf2jEMnJCwd7J+xXyPPfWbtN35FH8gDTAspVES2wie
	5v4cX+OVSC+P+Qm6HcQD4vRFWLv5U/0CJhrRhQGPAF
X-Received: by 2002:ad4:5cad:0:b0:6b5:2655:4518 with SMTP id 6a1803df08f44-6b5ecfb62femr8276036d6.20.1720078114456;
        Thu, 04 Jul 2024 00:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkb9qyz5cfjppp3EFyiqrqSOSa6sg8iHdFvSW2awFrFhVoyLlJQdPk1YTJv/0mtSfHUtHi9GRXWC4Cfxpm3PE=
X-Received: by 2002:ad4:5cad:0:b0:6b5:2655:4518 with SMTP id
 6a1803df08f44-6b5ecfb62femr8275926d6.20.1720078114175; Thu, 04 Jul 2024
 00:28:34 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jul 2024 00:28:33 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240702095336.596506-1-amorenoz@redhat.com> <20240703193519.16305196@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240703193519.16305196@kernel.org>
Date: Thu, 4 Jul 2024 00:28:33 -0700
Message-ID: <CAG=2xmMGcLiN94G_f21kFaj18+36XPBZUos7KD4GEZAZ9794Rg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/10] net: openvswitch: Add sample multicasting.
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 07:35:19PM GMT, Jakub Kicinski wrote:
> On Tue,  2 Jul 2024 11:53:17 +0200 Adrian Moreno wrote:
> >   selftests: openvswitch: add psample action
> >   selftests: openvswitch: add userspace parsing
> >   selftests: openvswitch: parse trunc action
> >   selftests: openvswitch: add psample test
>
> Sorry for applying things slightly out of order but without Aaron's
> patches we can't check if these work in our CI. Unfortunately, they
> conflict, could you respin one more time?

No problem. I'll respin.

Adri=C3=A1n

> --
> pw-bot: cr
>


