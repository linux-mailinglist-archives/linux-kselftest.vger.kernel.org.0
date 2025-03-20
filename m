Return-Path: <linux-kselftest+bounces-29528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6819A6B0AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 23:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE75316A3DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 22:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BE1E5205;
	Thu, 20 Mar 2025 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlvdHbh7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39421F4CAC
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509307; cv=none; b=HfxNOIuY0zWGUZ7qpzN9srVUO31OjiICXmdEQ8icQZI0opWJZY1qxoRBeo/dGN9dR98HCbtlNgVr8pfvkyWWV88nEP6UNHkvRmxthgj3KUTKrXQ+S640zg5EqxdfYV0l57DIcI2QOjhG0OKbetwAd/ctsJ9QlVYPR0K+5t9O+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509307; c=relaxed/simple;
	bh=xL6eG1Jcd5Bnhjset+ZL+xkKPTQQeDVriw1RcZsnraY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyaTsnPcif9LYrFZVUBWrEV8+u2+QdaqEZrJCuO29RXyk8ow4gEYYNez6QydkNB1EP+A+kRSUdpb+hl0594zmcjK8Iw4jjmYfgDl2car32dzulVS+UWvzrjL6j7izEloE7G1nn1sF60lMau17VBsUhLdWr6Xk9cGtUcTxGdGxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlvdHbh7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742509304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoTOUdGGo40QBgzG+tLBneNyYIjQ5d7q1EDzszYDruU=;
	b=dlvdHbh7ifyrTivvSveuIubZV5zcbT8yKb5og72zhjbVEg8gkXLzbWBQdpJnxQK34b5sK2
	rrP9ThLkhE+UbZHNWDlTk2FSx1DN2JgonvgrOZO8H4o9H5GTZDGpHR0dNhw/mtoHPjjySm
	gS+96V+8GhepYXJRd/pRgzib9/4DhKI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-VVDmTG2MMjm_bvapyMOfow-1; Thu, 20 Mar 2025 18:21:43 -0400
X-MC-Unique: VVDmTG2MMjm_bvapyMOfow-1
X-Mimecast-MFC-AGG-ID: VVDmTG2MMjm_bvapyMOfow_1742509303
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6f2bc451902so16775727b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 15:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742509303; x=1743114103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoTOUdGGo40QBgzG+tLBneNyYIjQ5d7q1EDzszYDruU=;
        b=grO05iQ1wLI33F5ttNjNETrGYVCynazceDxVwoWHFnRRu/hAod9D/f0hBvRJI7MfET
         JmVNFGrt+ewPHw022Us686aVL4dpVYeDLjNLjHyzLAJ0wF6sCZwHgnD80HfaQGRr6b/9
         FZ1nLLFrWicV4noseJXvRoHImIvcA449jOTrnutohRaea4qcxEOy4zkKPzYzgI/g3nW2
         LTDxWV2FzOIR2xmDIvUux7pQrgpA2QpYHSkd8N7V31koY8+G6NEEkbE0hCU4oVK1yYED
         h/cny6aYTJzrIekHDcmGIX4D+fYDfa5sVR19hOQbGOZ8l1eh6+BqieNEaCpe8k5no5ru
         2otg==
X-Forwarded-Encrypted: i=1; AJvYcCV+IwtOof7gcDSeTV6JH67lJSQztWsbwHQDVLz7C7aIXmtzhEvuWbPtj+O09RUfxtOtgYXW8YhuIvLEkbAQgxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnCczfpMc2nt8b6G2rUU7SM3MjIrRtHpZ4r2v8pTs6IeBGZ+2
	O6pq1psJCUTv0/PSe8F9SnJo+pzvgiY4i905INX8YSUv+oFcXzHnQ/qP7EzNVeoAtFtY9ZWcIXB
	EU14inmG9KVUmhnMJo8rfFf1E7dl2CZRzwbfUFHpsmICut/H9tqFmvk7yNHL+tZYC8GskE1kIHO
	IRTw6bp7JjSQ1Ixsu+1wJA9ZZ2VjI5GyW2Foo44MqX
X-Gm-Gg: ASbGncvyQ676YlfIK3mmZnFXjvKp0tHOXSpqkjxKngQUS/hN5a2fz5I2DNlAPI3NNj8
	Yd3DDfGIQlAYXwBAFgjpPcNRYV7EyeTi1sPD7nL5QqZ5XDrjraRZlcf2bkBCFVMuhUafrDi9l99
	P30jp3g2nAG50=
X-Received: by 2002:a05:6902:4806:b0:e60:87a0:61fd with SMTP id 3f1490d57ef6-e66a4d3f26amr1138994276.6.1742509303075;
        Thu, 20 Mar 2025 15:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwUVs4P5Q4ZJI2I5aegi/vCQLUyiAGAG+r5msbdBnMb2gxrSj/tqgjf1GNd9XM5wY+UTlSghHPtUHKgEEGYmI=
X-Received: by 2002:a05:6902:4806:b0:e60:87a0:61fd with SMTP id
 3f1490d57ef6-e66a4d3f26amr1138968276.6.1742509302556; Thu, 20 Mar 2025
 15:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
In-Reply-To: <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
From: Nico Pache <npache@redhat.com>
Date: Thu, 20 Mar 2025 16:21:16 -0600
X-Gm-Features: AQ5f1JoJDNe7FDU_N8M34AN0_YMMO-S_IQ8LTAq-vp4m5ZRH3WV6Q8DY0XKyJ1g
Message-ID: <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Mark Brown <broonie@kernel.org>
Cc: rf@opensource.cirrus.com, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:14=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Mar 19, 2025 at 05:05:39PM -0600, Nico Pache wrote:
> > FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> > depend on if the feature is enabled. Fix this by moving FW_CS_DSP to th=
e
> > depends on clause, and set CONFIG_FW_CS_DSP=3Dy in the kunit tooling.
>
> >  config FW_CS_DSP_KUNIT_TEST
> >       tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TEST=
S
> > -     depends on KUNIT && REGMAP
> > +     depends on KUNIT && REGMAP && FW_CS_DSP
> >       default KUNIT_ALL_TESTS
> > -     select FW_CS_DSP
>
> This makes no sense to me, the select statement is forcing on the code
> it's testing which is a library and so is selected by it's users, this
Similarly to eb5c79828cfa ("firmware: cs_dsp: FW_CS_DSP_KUNIT_TEST
should not select REGMAP"), We shouldnt force a feature on when using
KUNIT_ALL_TESTS.

> change will just stop the tests being run unless someone does the dance
> to enable a driver which relies on the library.  That is something that
My config also sets the UML wrapper to enable this FW_CS_DSP config so
it will continue to work in that environment.
> seems unlikely to change the outcome of the tests when run from KUnit
> which is independent of any hardware.
KUNIT is supported outside the UML environment, and some distros (like
fedora, and downstream flavors), use KUNIT as modules, with
KUNIT_ALL_TESTS=3Dm. We only want the tests that are supported by our
config to be available, we dont want KUNIT going and enabling other
features so the test works.

Cheers,
-- Nico


