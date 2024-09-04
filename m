Return-Path: <linux-kselftest+bounces-17143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335C96C30A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6351F22012
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774A1E490F;
	Wed,  4 Sep 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS8ay/0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612B1E4131
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465093; cv=none; b=UAAGdHnuN/3hyFWd5NBRM/CEeiM5l2JooH0oQVjrXOMQeVFda9/W2jSY61uUxKKJ5pywD4M9usqks/8wqsswE4c9Cqe1OPBW3bOC+uYb1RyR1Q5dQojKqgk2Y46zJN4CUgIz1zJWd8H2Rt3XegY94Z0TpWpA9p1DCW7BCvQJLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465093; c=relaxed/simple;
	bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEmqslR+wG7T9tFEjYJGye98LTmwCV753aDRji06HVlgGPoLyfdnvbVXd+lFnU4unToK2xyOXemCmUrzv1uxBbdBnMKwPcLz1nyjszIvWcqOze1iLsFXJFP5LsbVKVDab4vloPcI+pFf+Tl/BWNVMrUWeBcsKsrvsnoR/9ecPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS8ay/0S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725465090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
	b=JS8ay/0SU+4aqJti0/KIoqZmxxW/l2fWrJW0aXvF2zsEvJY7N39BAKa8iqw67rXmZuq8fT
	K9QmFNgyEfGoGGOGVPPGBa3dGu4z2HoKv2uXF9s+lVNuBz8CE7ZfcCQDX0YrtoVVlxTWc/
	Yr7YHoemwfuMnaLCyxGDGfaM4c4pVuA=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-Ugq6cWufOVioAd6lAmThBw-1; Wed, 04 Sep 2024 11:51:29 -0400
X-MC-Unique: Ugq6cWufOVioAd6lAmThBw-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4fce6e3067bso2597098e0c.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 08:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465089; x=1726069889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
        b=CZGjP40SlUbi0X5+wfSKJlkQT1pEB4XvrtL1fXdYIIEgwYMvoEeU6NqQwGXFvra4Kv
         lmFPL5uVrs/5Xb73MSpPU2Y6iIwLdtJE45oOGoQPJVdWcgvSaDJ3qQs2tk+73ge3o2ON
         NKaJP5DH8VecwxtQ1UPt+t1X2Qpp70Y+2VS8MgFJc/hyTas21+2BbGsHuvoodidIKL6k
         JYTRzJcUn/lCM4G2CJyeEsl/7gmQaPVcR0Nfc+v2NdJ1Uo6D3juoiVs4CAO4l7rzvrnK
         OLbrhYyJhUXjGIRYP535ewOBd9M4RJyBP2alDCu74bZZYaBgRwZQSG2DyClsD3Q380Q/
         A6+w==
X-Forwarded-Encrypted: i=1; AJvYcCUPeFFIc8MVCMr0OgpAy309bg3+4O8ay+qg51B1deEqbr2r2ecFZ0N/DJiko44T0FWSIRIOhWyw9DU46TIV7S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7V3AytDgtX0BblCn2AqhQFINmGl3fygCHSQuvrNuma/zIEOZ8
	PrACZgOSDrmrWzAg9Fs6/B26nQb27VlRpzNIQNtGt6jg2kbZU689flumPJ6rz/qq8VNxR94XtfI
	cm4Z3w53sFNvHgjmx8k6sEt/ObISy9CMTlIiqFfZ1qNlOhhPAtBHDdhK2NMQsr8Y/PA==
X-Received: by 2002:a05:6122:411b:b0:4f3:828:7a47 with SMTP id 71dfb90a1353d-500aad4a345mr13917539e0c.6.1725465088652;
        Wed, 04 Sep 2024 08:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6DuFNQkzu/koNhZpY20gpJZ5XX5BKL3S/FjTMXEDCyB3q8D3zZLHyV2mW6t2xJyy7IgmqHQ==
X-Received: by 2002:a05:6122:411b:b0:4f3:828:7a47 with SMTP id 71dfb90a1353d-500aad4a345mr13917520e0c.6.1725465088242;
        Wed, 04 Sep 2024 08:51:28 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d61b5asm635774585a.110.2024.09.04.08.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:51:27 -0700 (PDT)
Message-ID: <cff6d1fcd3331574a5189737f1f58774882649fe.camel@redhat.com>
Subject: Re: [PATCH] um: kunit: resolve missing prototypes warning
From: Gabriele Monaco <gmonaco@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arnd Bergmann
 <arnd@arndb.de>,  linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Richard
 Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Date: Wed, 04 Sep 2024 17:51:20 +0200
In-Reply-To: <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
References: <20240904135019.200756-1-gmonaco@redhat.com>
	 <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


First of all, thanks for the quick reply

> I get that you have this on kunit on ARCH=3Dum, but that makes it
> neither
> a kunit nor a um patch :)

Well, yes I wasn't entirely sure how to put it, sure people from
UM/KUnit know what this is about, but I agree perhaps the patch title
can be a bit misleading.

> Arnd had originally wanted to fix this another way, but that got
> dropped. I don't know if this fix is right, though I can see that it
> works. I have the same workaround in my tree, but I'm really not
> convinced that it doesn't have side-effects on other architectures.

I thought about doing it differently, perhaps using an additional
header file or even re-arranging the macro dependency, this seemed to
me the easiest and perhaps less risky for other architectures, but I
get the concerns.

I could perform some further analyses building it for multiple targets
(besides _it builds_ I mean), if you have anything specific in mind.

Gabriele


