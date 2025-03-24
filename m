Return-Path: <linux-kselftest+bounces-29694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C18A6E27D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 19:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B46D3AE673
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937CF264A8E;
	Mon, 24 Mar 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb6yjvg+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A5264A97
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841321; cv=none; b=ij3TJHxf2zSziEZjT2/QV7PUWhEBcL2BrSLhpW/qSeMMaQsx1Y05At1j8WTbU6K3r6G/vZe9LRzTODa84C8GcYqjvpcNTjck1PEqh6XDi3SB7ndK7d7OZPyT0mI1kIkKhS3VnOqn31A62j39Lc7SZIgjnBjBMfVMAfiTb0kTefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841321; c=relaxed/simple;
	bh=hXOiHIS3DvlLQB4GyNTDafew3mKtY+pMoL7kwsNiNTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT8vwuG00S8QwjbcElEhN8gB6kOxMdEpBucBI4NoBhDcsfp4/F4xELLRMZNDvH6iXEfN/OiwzSCxODffoz4r57H0/Xj739ELPhR9Vf6uEdmksOcqYc94r6k/OQE/0VQbMk8+/GVw8wHvxcfL7UTBtXwhpBRuc9nIJ5q2RTO4cFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lb6yjvg+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742841318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXOiHIS3DvlLQB4GyNTDafew3mKtY+pMoL7kwsNiNTo=;
	b=Lb6yjvg+A5zZtczzxm8LyU8ne4gyXjSEVwP1n0D4QJcCPhuG5KVFgXwhKl3Pn3h4xsFh5v
	USAw8BO+hfFl6WAxt0AAfldt63N6vVR0Ko7xDOu5ezb4WqSc6CqlFUAJOMq6v5AnvBaLpo
	2Stv1MQSsYqnsFJSfiYKuKoUSBlw10c=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-xZe6_AMkN4aXx3k5z3O_Tw-1; Mon, 24 Mar 2025 14:35:17 -0400
X-MC-Unique: xZe6_AMkN4aXx3k5z3O_Tw-1
X-Mimecast-MFC-AGG-ID: xZe6_AMkN4aXx3k5z3O_Tw_1742841317
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e639763e43dso5852593276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 11:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841317; x=1743446117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXOiHIS3DvlLQB4GyNTDafew3mKtY+pMoL7kwsNiNTo=;
        b=HIJGZLHEphb+yG08hxzfY2xS4x+i8G6bIj/Rxwz6NQfKRCljLLddxcmGr+HyaowmHZ
         kX6qle61O6jxVYa7AuzTtkQtr9l/R1bscZILwXx8/Hc3gXgRBUE4jECxJT62xb2OkOjo
         KaxJQeSIuxjyZ0MQxzPaPk7Xl1qIIHQLC4057fNTt/wsU9pGTYcLUebbLu3TB6X+8Enk
         j46KWlojOjn97omR5uQbApGgPJwRwo4nkYf7SRQCMVl9BS9U+Utxr6dEjeGY9azZcTis
         pjFBowxGfW8gS9b2IjQVObbkrkSycTWqUy4obYQih0NrW3Y2YhztZjyNC3GwfhYuGPeJ
         sMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7lky0OmJuaSgovE3KUk8efWiNL3dfVU6QPpzGoUgNGHJRbGeITftuVgg9Sc0h5/p0gKWlUZMrcZO88wspyrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHN8pj3faTptUOOtfj1PdUBP+jNcce+CqXg4B21GoBXAyglpj
	lTciVcdIk5ckbNCiq+wivJpyhu7Es5gyjvSSrp+BOMA43sNzCsAbd9xGBMtC0wAv/zEqKVTkmhQ
	+zbYSHlT4lNa36G2LWsCnbVobR5/TYX8ubcTBaOecoa0JSdaVqB6MCqcej9xHiQXhu6NS9IcO09
	WTm5qlsb1iWE5hukTUGDsJhe57CmSht2i+oKTJPajs
X-Gm-Gg: ASbGnctCquauT54cCOoQfaNJXqDuc66B78FtW/aklw4PeFU4KILdluLpOyElczrUHEc
	92ztD2VSj0vuvNLF3ELbYy107jT6ea3UNuWxecGzCx7PmRV09ueKN9RngLhkQPsrUOdP5fsS+Sl
	N8o7r02Dt/UsE=
X-Received: by 2002:a05:6902:2781:b0:e61:1b41:176e with SMTP id 3f1490d57ef6-e66a4fe37b9mr17409674276.47.1742841316735;
        Mon, 24 Mar 2025 11:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8lgkjkEycjgwwOag2CdHP7QKbLWSxA2ndMrht/bd5qNPOnsWKfFP2CDU3/jWiXt5YNAqbPiSXT2f4qcYi8mI=
X-Received: by 2002:a05:6902:2781:b0:e61:1b41:176e with SMTP id
 3f1490d57ef6-e66a4fe37b9mr17409613276.47.1742841316149; Mon, 24 Mar 2025
 11:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
 <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
 <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com> <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
In-Reply-To: <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 24 Mar 2025 12:34:48 -0600
X-Gm-Features: AQ5f1Jr2LBKyY-vtXjhrKkI2mHegPoVMNKIPqwHoXVC90cmTjlCV0yTXpyR5wnE
Message-ID: <CAA1CXcCLXnsUjivG2HXWZfP=XLZRCV=Ws1y5_h+bdq3GbAYzRQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 4:11=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 20/3/25 17:35, Nico Pache wrote:
> > Sorry links got mangled
> >
> Thanks. I'm on vacation right now but I'll take a look through
> all those when I have time.
Ok thanks! no rush, enjoy your vacation!

If the links go stale (i'm not sure how long they are valid) just lmk,
I can get you new ones.

There is also this link if you want to track your upstream kunit test
on multiple arches.
https://datawarehouse.cki-project.org/kcidb/tests?tree_filter=3Dfedora-eln&=
test_filter=3DKUNIT&testresult_filter=3Dcs-dsp

>
> The unterminated string bugfix is this:
> https://lore.kernel.org/all/20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d1=
54@linutronix.de/
>
> I got lucky on all the UM, X86 and ARM builds I tested.
>


