Return-Path: <linux-kselftest+bounces-43650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEFDBF590A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 11:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F65A352A66
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433812F6939;
	Tue, 21 Oct 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYxy82pA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041C231845
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039761; cv=none; b=NI0OQk3o4xwGosbxkrgulddNIBWreZJGpJJGciAhgTC5cX/MVfv9j5wl0K4SAndwsC/LppzpXAaU5BgYd6zCPQ34fRxq0Aa9MeJt1TemAdhdwPWM5NGySa/OOlvm28dHj6WV9ML4lvh0o3RbyrwjsE77qnu6K6L8bOY2BzpDt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039761; c=relaxed/simple;
	bh=MSVMapS+wT8A48mbedXknuF6hMRfcMnPOR8fjkLNzBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efdF7IpwQexQmrYeU9bfB3iNqadUl4QxLq3hmBE2wam6ECrh/RVv9wFaEy6xEYgEG8uoIUHB+kh6b1D3vDdaYKK03odwMN3NeMPpsTTyjK/J6IXFia/wYp7X7xP7XApco0OD34OdE9AMytbUd2GNmvyKwQKXcLVmqk4D4eHM4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYxy82pA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHjS/qyeeKcJ3eN+7yFgpurORtwwe8MoT2GpgobO51M=;
	b=cYxy82pA+fjtnSs8kfgHcNsl0wGBbBsMQRBG41ACA+7CSNb/OBrgqAsEvNwLN+uFxeSpKC
	vYQaljoIpmyKo7wWCx5axfcPv0WBde3JufWEFIttmhBsoZCjqcgvTBdiXpvwMOo+2s6ojQ
	47yTjQROpASezdVVcLzBmaTKGKh7+bw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-EX09KXVsNqWKEkmidQz6rw-1; Tue, 21 Oct 2025 05:42:35 -0400
X-MC-Unique: EX09KXVsNqWKEkmidQz6rw-1
X-Mimecast-MFC-AGG-ID: EX09KXVsNqWKEkmidQz6rw_1761039755
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1ed305b4so176526426d6.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 02:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039755; x=1761644555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHjS/qyeeKcJ3eN+7yFgpurORtwwe8MoT2GpgobO51M=;
        b=e7EaJdYgFrfc8rlwdoS4lVL4ayN4hI6UNeRR0v0Jphl7sKuTfZoGckEJFJkvEEMaRh
         uWTHwbeE9jFSn9TAs9DvBhznS6nlwaKDFBnIcijhOEghzVTGAlFmwClYHbV3obfYX4cm
         H4b+hZkum99bSw3ou6wW4ISpZbpcS0LDK6hbw+E503ZsBjcerTdposKhMBAalX414kj8
         VYDDDeAugrq3hq5UpU3DH/Iwm1YBrhWFK5wsK1+0ez+ErrPx/IfJgihF4ALN4vVofqRe
         x+UIES4q9IOJtAMcuivmtkhG/JkhdpfgQB2eD1yk+ZQVpnazOmfrHEe1BoQ2lOUIxR+d
         s1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV6cljIza6UqPWcg8vUUMuWtqaPQuqJTrcTSfhIgMZa7yQIiBgr4shjK/95g0R5JIZ2JJEHmWeF6hS1AY1ILo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94FxKRTUhOzAld9LVUzQcLG3otVzkgSd3JR7zjEWzY5Q0Aa7/
	L1cZtoeWKh1KlZD8MQSxV9RQdwmRMAXf/XneTtABt7ReWb7cxI7DZtJng/kNXZUJyFY7h2eZo9F
	y+ZPzohFxSok691eoOco5cIPUvSxaYKlUJp5cfwdQuVdhwvMZO1iaJDIfENedsW1s1de6cFFrxh
	CyRc0h4guUZEVDuEpS4VAdRRHxNrxYOMwFkP9ZO6U6dk60
X-Gm-Gg: ASbGncvUe+4dmak/uJ/PMTAV5R11Rt2CHaFvHUTepmJ8+EMu4kohfx0iZOMEqM266+d
	uxZTXJ5tUfxRkg1ikTNxWHoUUy8Pwy3UtoKZM8R6cOkAa8fP1AktcUMaKf8WkwfvMWUX9mVlyTL
	wfEjFvHJu2pThXRb7xPtqdSs8XTnzk//6/3wn6SkyRmIKwktHSxH44OzdsnihkOUCLvNbhpqPrP
	MQcx+0uUfBrdv28
X-Received: by 2002:ac8:5712:0:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4e8b679b7a2mr115979241cf.52.1761039755351;
        Tue, 21 Oct 2025 02:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtJWXOjke0RTmK0/xZXoqnt4Ou0KacBj/M07aRFHuZEpUI1vDSqa7DdT8a6/Yrxfq2QlaYBVOMZ0kPdqztzzI=
X-Received: by 2002:ac8:5712:0:b0:4b0:6205:d22b with SMTP id
 d75a77b69052e-4e8b679b7a2mr115979131cf.52.1761039755012; Tue, 21 Oct 2025
 02:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <2025102111-facility-dismay-322e@gregkh>
In-Reply-To: <2025102111-facility-dismay-322e@gregkh>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Tue, 21 Oct 2025 11:42:24 +0200
X-Gm-Features: AS18NWBpQWaCgTUPFKBGe-mp83ffIdDKrAgAWm46CipP2yYr5wYthLbhuHqwos0
Message-ID: <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
To: Greg KH <gregkh@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Oct 21, 2025 at 9:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 10, 2025 at 06:59:57PM +0200, Gabriele Paoloni wrote:
> > [1] was an initial proposal defining testable code specifications for
> > some functions in /drivers/char/mem.c.
> > However a Guideline to write such specifications was missing and test
> > cases tracing to such specifications were missing.
> > This patchset represents a next step and is organised as follows:
> > - patch 1/3 contains the Guideline for writing code specifications
> > - patch 2/3 contains examples of code specfications defined for some
> >   functions of drivers/char/mem.c
> > - patch 3/3 contains examples of selftests that map to some code
> >   specifications of patch 2/3
> >
> > [1] https://lore.kernel.org/all/20250821170419.70668-1-gpaoloni@redhat.=
com/
>
> "RFC" implies there is a request.  I don't see that here, am I missing
> that?  Or is this "good to go" and want us to seriously consider
> accepting this?

I assumed that an RFC (as in request for comments) that comes with proposed
changes to upstream files would be interpreted as a request for feedbacks
associated with the proposed changes (what is wrong or what is missing);
next time I will communicate the request explicitly.

WRT this specific patchset, the intent is to introduce formalism in specify=
ing
code behavior (so that the same formalism can also be used to write and
review test cases), so my high level asks would be:

1) In the first part of patch 1/3 we explain why we are doing this and the =
high
level goals. Do you agree with these? Are these clear?

2) In the rest of the patchset we introduce the formalism, we propose some
specs (in patch 2) and associated selftests (in patch 3). Please let us kno=
w
if there is something wrong, missing or to be improved.

Thanks and kind regards
Gab

>
> thanks,
>
> greg k-h
>


