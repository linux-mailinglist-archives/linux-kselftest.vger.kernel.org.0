Return-Path: <linux-kselftest+bounces-45797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF8C66368
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04C0435B635
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A134CFCB;
	Mon, 17 Nov 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qanSjEG0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40433451B0
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413752; cv=none; b=GOKplhCSB4ctk4wNLG8tQ4LfkkuWvP3MruaBk2KYlrFSZNOjUVHsenw5Sb0xUMrXbZtKh3PjPNOz5JnkYRJOi0KXyGaTm5t/OE0MLPpZvv5G1oK6z+xGqLXanGv2itzS0/RC1aSkL7YmywumdjP1estW60ZkJMWXpkRxwsdrBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413752; c=relaxed/simple;
	bh=dA/5NYPyaR3SpUDS42goPQsXtjt42GFHqrfiFziwDXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9z9jI0MjIdZNlNZ/irnBhv8XeL9Mh5vxkgSd8/+VbD2B8xXq+7m7xqW36rK8QRRmopSGVqCqfFTNYSQufdGx5lCwqy6t44nL2zuK43oauAy7Fqiqzm3xNxoqo9rwgKNGsIyEx913N6/hvh/mhQRspBpi3MstjfJUTDwRcxunzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qanSjEG0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-595825c8eb3so4699433e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 13:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763413746; x=1764018546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjoWhLUfJbKg+2stbKiQ55r0rLOxAAjJs86wMbbOnY8=;
        b=qanSjEG02A3Y2Oq23LtXhCxrONeIzu+2dN7Za4S1Aj4O8PHIU9ghmAeWBLxyE24UIC
         +1mlKC8jHhruCYxQeoRoeQ2HC5iBqFdUDvLd34S5eDfgMqzVXEHhYVt51a8y0K9c9TW5
         QDnn5lZmGE9sVgBkBhVvc0C65XKnlG8QWcNIFoNwL07FvmwVlOS928UhReX2UhyjBBlH
         F5zm2x6Nioz8JMJOsO6yfs1xnMVzKVLMpicytqzO7PudiEcVkWJxmdz3kEv/owd2oXQR
         2Jd5bUFcMqq1wBTp35OfjCTviMN5oosMjT/qbwGFvZHtRnv8hMHDtGjwToeVRWWIbt4o
         qkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763413746; x=1764018546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjoWhLUfJbKg+2stbKiQ55r0rLOxAAjJs86wMbbOnY8=;
        b=hk9lAflkb3etbUceEAzT2pRBqMZ+kdpN246i6HL/thWbxyrdGDnlrwkY9uQfjFERMd
         lC+OeHcJi1QtCnMOp1A0thUDjB/15XHekHBjF4eQzN5xAbzE6I/+8JxIENYZsnyJN1bW
         tXGAjaVTlH3ymA8TGZurDk7twWlV+RSnQ4EvqoysCgHQMuWIBixra2gaegnFADOeJnVS
         as8HPAGXi3QOaK/lSPb9TpOSG/o7Ft0btCMEH13nPQuk8klPwVHHKWxJHhRDAbR6tFt2
         GMa7hHEXTsA2LsQKSlAqBzDYJqIu/SB8hZr9dykJs+m08NTyjR3s8RLOQlGNtt2RLXQv
         wucg==
X-Forwarded-Encrypted: i=1; AJvYcCXADVnxQ6fPnAilOf6DQv1B4sc7vNAIezFWj6oE0IXZyz7dEhuH6zB7uvq9fQQXX2KI+tqh0euFdwQ+OGz9T2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GrmEGGWLgG/1B4BVy58ugmOk0qlWPjcgktiEkRbN0qX6UwSW
	t51gMQk0+37SRsOTjjSszm5aBZvalhbnBcYjfCWogMvCnhLg6m4+KXHrqvdXWvgI76jaPJO/FSx
	w/h+XO/jFaS6mAi17Te2t2/2UKcxC3R+CJQ+GvwRh
X-Gm-Gg: ASbGncs7RznXHC76XxmJU8QkD5vLxWeVgaEtriW4ZZVHxUnARAePGzUJaXQ91CMZzZS
	1G99d4XHlrLMoQ2KztWczZkO97IbXWh712YnQ1x/I36LilbmEGttRVv2aWlowK82WrQBfqtYNF3
	Boy99zUve7LruYEDSmVzitfsbT0nYSFK5QIGmWerIyV6kMl6NVhEyLHXDatOjkMxRqGyWkMfF8z
	UG42sPIhkLdVc390IW0XdPQKwTfGj+OmlWxUyOsOCBsmoKCbNT0WvHJ8PKl9Xs3Sm0+r8FuuyqW
	83mMNQ==
X-Google-Smtp-Source: AGHT+IFni1VNjv0z/eeugp/jXAsBHzPTprbSdMefmczevXx19k/vvMv478Xc/gXsOfk0JBX+x3U9Hk/lS2aJOagt9H8=
X-Received: by 2002:a05:6512:b05:b0:592:f441:928a with SMTP id
 2adb3069b0e04-595841eec54mr5006421e87.3.1763413745951; Mon, 17 Nov 2025
 13:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com> <20251112192232.442761-3-dmatlack@google.com>
 <aRt+XHgbKFq5k3ns@devgpu015.cco6.facebook.com>
In-Reply-To: <aRt+XHgbKFq5k3ns@devgpu015.cco6.facebook.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 17 Nov 2025 13:08:38 -0800
X-Gm-Features: AWmQ_bnjy6Qk7n2t_yD_IVUwtIQduWDCtYPxvyttcjPXfMzUdeQiOxzgfIPrCtA
Message-ID: <CALzav=fN5CAn8C0x0SnsB7Fpq6o-CHspPvvL3ctk1U5i5FE40A@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] vfio: selftests: Split run.sh into separate scripts
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:58=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote=
:
>
> On Wed, Nov 12, 2025 at 07:22:16PM +0000, David Matlack wrote:
> > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/self=
tests/vfio/Makefile
> > index 155b5ecca6a9..e9e5c6dc63b6 100644
> > --- a/tools/testing/selftests/vfio/Makefile
> > +++ b/tools/testing/selftests/vfio/Makefile
> > @@ -3,7 +3,11 @@ TEST_GEN_PROGS +=3D vfio_dma_mapping_test
> >  TEST_GEN_PROGS +=3D vfio_iommufd_setup_test
> >  TEST_GEN_PROGS +=3D vfio_pci_device_test
> >  TEST_GEN_PROGS +=3D vfio_pci_driver_test
> > +
> > +TEST_PROGS_EXTENDED :=3D scripts/cleanup.sh
> > +TEST_PROGS_EXTENDED :=3D scripts/lib.sh
> >  TEST_PROGS_EXTENDED :=3D scripts/run.sh
> > +TEST_PROGS_EXTENDED :=3D scripts/setup.sh
>
> I think these assignments will discard prior assignments. Was +=3D intend=
ed?

Yes, thanks for catching that!

