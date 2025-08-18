Return-Path: <linux-kselftest+bounces-39253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B685B2B1E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76947A16F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3692749C8;
	Mon, 18 Aug 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrbS9FyQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C21F4C84
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546837; cv=none; b=YhFS9Ly6jPzBfs41ztsaN50/JhPLiPU/XDuieEYPK+ldwzVTkImoGUHW8rmVfXitkAZxLZDMisPOswxgS2Z2ooVRhnyADfi16vr5Ktjfbjn2WAg5UyOfEwH4nphX9sjF7RPdjpohd8i/jKCrcF5lKrIrVxroTcgx1ELXgl1u504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546837; c=relaxed/simple;
	bh=FGXskxNyPi+kSWldZTuknSS/UbFBTGJPtmONfgnDfyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0QW/IyW4ZbcJOH6yjRUmZuT3JrukxndV8Fo6Se8Tr41RXJe3uXD3OjVuS3RRqkKLeg5l4tvVeuF5/3zeUv87c0+v1Ozi8csUSU2YxUXA4eGMjs2PgqETLakwzTgPLZWXv3BvZ7Nhr7AGepbA5AWGxlL9sySAl2+N1orvGe9PlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrbS9FyQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55cdfd57585so389e87.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755546833; x=1756151633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ktUFIX7oYRVV6r3VBowe+e8y/dA77n0Sl2buDMTago=;
        b=ZrbS9FyQvI1VOMvGxKXb721auWGqb++14i5Y5ghJKcoVAzM3iKsdNX4O7HWLtbbIRT
         OZGt+PEqPY0sqMfPumLooelndWLQ/eRa78XfPTDOIc6V3jdiQGzVAFTNzq/J4ng8MGKk
         tF7qF9JaOa8qtssGJ6y5QF8rxI+wUNqTURiuf1iwqDc4DjuodPyy4XrWp2mD3dgc4AM1
         QSlXMVHc+QtdP9coLU+1QOFj48AmNr6MXAjKZvm9PwJAYW+Jsk9QeaiHh3vYh7Gx8EXq
         /AqIcaOFzsNqVL9Ty3urbZHPNPqQiSZUivTkFARhQSIW05yh9Uz7xeoeORlorOjHP7in
         3ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755546833; x=1756151633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ktUFIX7oYRVV6r3VBowe+e8y/dA77n0Sl2buDMTago=;
        b=wx2UIWdV4mGB6w/RqdmUHaa8gWxTirwODsnQCmmLBw0wKo/6aVlWYMmKmWn6r21ZA4
         GwqIX3ikNbrfuP4mf5WGsq7qczCvd4omrdHzHmvV8+E+rO0KL+OMdkx+WU56ymJ1zVSv
         dOy9SaRTY8SkNrv6cTmcZ9ti+Insl3AWTaifVdik8AkBdGVpup8wCpY96gx2Kp+1qu+p
         OwZ5eFhTX7EZ5InYJl8BrQNSO+FWnalDFQ1sJDyI2pP7RQHdh5YruqUgcWk0YGE0qerM
         EIQ4QUoE8Y0B2lVoAubYd9qajas3wo5wlJ4vIe51+MBaFGWn9vk4FaHkE/fsPJMxWElm
         EvCw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHoHhYLwQpHSP4IjR4ckj7Qi4saDtIkEBkZCaOUByuQzpYk256K3EYSDycURm6B05+Y1tYsATTf62+lkKwu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyJSfbFtjbplchSC3/Gegdj/DCpfn9tWW4/S4FZLQfTiVySBI
	63Rv5VVdGceaV5efiv4m9CvFIQZ4MGLQ7ieR9Pl7rraHylxfCHU25J+3Mp+ytWmVe9NfuHI34Lb
	Gajm86B54WCYcQir+jmeUCJBI+xusXwHxM1eu9uDT
X-Gm-Gg: ASbGncu/GKB1P2zswLpZekami55w9eKp2tvKJBNrG0jcPNoK/YB7kMEOg8vnmgCPLUP
	tD6qWKlpoYx0kLHwtd8tRFfj55688lSh+9EGc+cPaVxMAr1O9Oc3hSGKm+H125wZ9RGk606NRwQ
	q0bBqCawiRarirxQdeWlKXFKO+uwWO4tm3rjHRfeW3FbmWdFugX8In6icAACvJMf1iow4JdMuFv
	qi7aAcZ3ujhuCNsB3sZKhPQBAZHRfmNNtrT8OImoaq7iVmA5Ow0qryn8/l0WGVJ3g==
X-Google-Smtp-Source: AGHT+IGAE0Ofc8PX8nXcHcZR3qsDCQCOVXp10z80sSZ1JuUmeHOv+0TcOt8kWreETfSTqUqrHmJGBVsvzBnZnmXWA8Y=
X-Received: by 2002:ac2:568d:0:b0:55b:99e4:2584 with SMTP id
 2adb3069b0e04-55e00965f92mr4105e87.2.1755546833191; Mon, 18 Aug 2025 12:53:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815231513.381652-1-kuba@kernel.org>
In-Reply-To: <20250815231513.381652-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 12:53:40 -0700
X-Gm-Features: Ac12FXyS1Q2NODm60eYKB3--zRgbzyZ3ktDzxZ4Bi8tGADJKFprlw8vjHfq1Pag
Message-ID: <CAHS8izPa8=2=u6AcrUKEOecuQSOAmwcsXKXAXtdE9tdAJhVGoA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: ncdevmem: make
 configure_channels() support combined channels
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, joe@dama.to, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> ncdevmem tests that the kernel correctly rejects attempts
> to deactivate queues with MPs bound.
>
> Make the configure_channels() test support combined channels.
> Currently it tries to set the queue counts to rx N tx N-1,
> which only makes sense for devices which have IRQs per ring
> type. Most modern devices used combined IRQs/channels with
> both Rx and Tx queues. Since the math is total Rx =3D=3D combined+Rx
> setting Rx when combined is non-zero will be increasing the total
> queue count, not decreasing as the test intends.
>
> Note that the test would previously also try to set the Tx
> ring count to Rx - 1, for some reason. Which would be 0
> if the device has only 2 queues configured.
>

Yes, I think that was a mistake. I can't think of any reason we'd
really want to do that.

> With this change (device with 2 queues):
>   setting channel count rx:1 tx:1
>   YNL set channels: Kernel error: 'requested channel counts are too low f=
or existing memory provider setting (2)'
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina

