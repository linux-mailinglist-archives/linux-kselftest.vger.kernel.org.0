Return-Path: <linux-kselftest+bounces-23851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA0A00720
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 10:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4497A0230
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D51F8EEB;
	Fri,  3 Jan 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoFluvXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCF148832;
	Fri,  3 Jan 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896991; cv=none; b=eyFX1CEsvZJIHb4Za+/ZUY2zLF/RhQWjDDKN4HZ3InhU8I9Q0VXajcIbAV6A1I1Tn1xZ0+W2O9t7qWDP2iOaMEdDtpswHPXZRIZ0t6EpmoQGq9fVy+6BQ5oTx7fU1v+d/XWBqy670gQ6qdaNll3MlGIWi3lXJo2ZQ201fkFW2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896991; c=relaxed/simple;
	bh=639KMUfq0hsIg+9byXNTL9sLUkhLh49mRYvs+JGQ0yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5/Po7GHUicj29ITrKutS2Lo5ur+uHKm+8nj3L9LfrTPwAHyC5jhH1tTcpw5cbflmNU8lF/Fa+oH6IQUEIHHKGs8QD/ZJVvENwXnENbVjVbaJ04lQkvV9jO4QwoSHn/Qn6yWn6uZlrVebXQUz6lxjRkNlGtL6DzCTFZ9c2pbs4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoFluvXk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f19a6c04so1035471785a.0;
        Fri, 03 Jan 2025 01:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735896986; x=1736501786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT1Q3EqSdVAcFIKkVLfAv4OMhPOq6p5vtFSXeM2zO0w=;
        b=WoFluvXkOT/CD5QQwn+vR9WOZxzRMOGMi2frFy2bTi/wbXHlFEIwiIQLh452fTREQW
         sWdL6vkOLYcx8ckLdrHxeNihNtgDUb4QMKiHHQG/NqHoZdoNOa1HktPce9sWwZqqVC81
         McLBlDwfKgTOVS6JOTfbJMrAGzbw4H7+W6W+8Ip2G6Y1Z4LtH2h41EK9Q5KS/ChZC1O1
         N6FJMnRfm0laBbl2uT/3UexWCUi1LawZf9IXoFlAylBBf9OpW6+/wRkOwSCOkYj868Xa
         v433h+MUc4QP/mvl1r/9kP3rQ+TdI2EwNv5u3Zwxu91ABDTK6MZa9Vxist9cnd429nM9
         KI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896986; x=1736501786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT1Q3EqSdVAcFIKkVLfAv4OMhPOq6p5vtFSXeM2zO0w=;
        b=qP9/kA1mOxjCDbyw6AprELkvweO4x4mRvZlALQd3pRzSw8D7qgiC9smcGqMIHMUcUd
         72aw+g6xjQfSg5qFJqOjYR5J7U6RX14v5ZtCZ3QWHjmvo6olzQ/JE513DgFc/eJUf9Ys
         xDPeFcyVGaJIAFKrBia/OvtmGdg+Bp22CsRC5E3WuaAWGG3FglNVlvMVbr0PnJ1aQI6C
         X6dvflpuHJ06Tmy10LNqLywQghGZ1fb7pBJo+4/8K3AzKpdBNsKtBFypbVfX3CBHsgMA
         NKKu5rCbaxlB44+0V+TAwfoF9GOsIB0TSP7mIBevLwUz6lTKTkWo3EcJhhtjF3mraQf0
         Q9nw==
X-Forwarded-Encrypted: i=1; AJvYcCVntKJR96xG5ovjWQU/Mud6DRy/CivU5bEQnXnqK/sKfPqvAjn4yhnKMfYxnVQegP393mc=@vger.kernel.org, AJvYcCWCHnSckVTlqF1obfWoi14y4plwLlIjYUUXbAYOFYAcIa5BFiP1xqFF/OY5R9N0DLQDwpzs2ihFEVPb5rw8z7VX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61TXowR3Ot2mZiwqMyrdrwpYjLDN/UH+CkIwNb4jkJNMfhSPt
	e+qXXuKzFiKtweW7vrHQQqSp2NXmmy92ZObNFvhSJAbZOn/cZEBf8PgWS4MHTnvYLknKpIh4BPB
	vD1/Lo7bRgi298afGA7yDDSb/VrNvNZd9
X-Gm-Gg: ASbGncvEgtP7n1tBjndgHobTni9Hfsb0qw3eG6AkBSNW/SJnoXF0cLKVZ5uTfGXMiZ6
	djPOFXZ779hABwmdZ1O3twqNdb8tUyC0U/g7SyH/P
X-Google-Smtp-Source: AGHT+IG9EjrrBEBN5l+y5be7S1FCSaE7049c4FthvAbvp5q6XKuLTxqJrbnDqYkkrEjy7Inll/PtCHm68XU5bCE9jUU=
X-Received: by 2002:a05:6214:2b0e:b0:6d8:e641:da29 with SMTP id
 6a1803df08f44-6dd2331f4e2mr803488896d6.6.1735896985818; Fri, 03 Jan 2025
 01:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3d0bd36-c074-4cda-b6e1-5f873453ad30@bootlin.com> <Z3cTnjss5soyUobX@mini-arch>
In-Reply-To: <Z3cTnjss5soyUobX@mini-arch>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 3 Jan 2025 10:36:15 +0100
Message-ID: <CAJ8uoz1r0dDna9tZwm8Q62dks18DHdstF8dkpm-q+_nwOUmbdw@mail.gmail.com>
Subject: Re: Question about test_xsk.sh
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jan 2025 at 23:31, Stanislav Fomichev <stfomichev@gmail.com> wrot=
e:
>
> On 12/20, Alexis Lothor=C3=A9 wrote:
> > Hello all,
> >
> > I was looking  at other test candidates for conversion to bpf test_prog=
s
> > framework (to increase automatic testing scope) and found test_xsk.sh, =
which
> > does not seem to have coverage yet in test_progs. This test validates t=
he AF_XDP
> > socket behavior with different XDP modes (SKB, DRV, zero copy) and sock=
et
> > configuration (normal, busy polling).
> >
> > The testing program looks pretty big, considering all files involved
> > (test_xsk.sh, xskxceiver.c, xsk.c, the different XDP programs) and the =
matrix of
> > tests it runs. So before really diving into it, I would like to ask:
> > - is it indeed a good/relevant target for integration in test_progs (al=
l tests
> > look like functional tests, so I guess it is) ?
> > - if so, is there anyone already working on this ?
> > - multiple commits on xskxceiver.c hint that the program is also used f=
or
> > testing on real hardware, could someone confirm that it is still the ca=
se
> > (similar need has been seen with test_xdp_features.sh for example) ? If=
 so, it
> > means that the current form must be preserved, and it would be an addit=
ional
> > integration into test_progs rather a conversion (then most of the code =
should be
> > shared between the non-test_progs and the test_progs version)
>
> Since no one came back to you, here is my attempt to answer.. It is a
> good target but it is indeed a good idea to preserve the ability to
> run it outside of test_progs framework. Maybe we can eventually run
> it with the real hw (in loopback mode) from
> tools/testing/selftests/rivers/net/hw. And I don't think anybody
> is working on integrating it into test_progs. But Magnus/Maciej should
> have more context...

Sorry Alexis for the late reply. I have enjoyed a long vacation over
the holidays.

I agree with Stanislav's reply. The only thing I can add is that we
really want to preserve the ability to run on real HW as the majority
of bugs we find are indeed in the zero-copy driver implementations. So
these real HW/driver tests are more useful to us than the self
contained tests using veth.

