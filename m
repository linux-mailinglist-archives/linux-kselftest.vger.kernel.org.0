Return-Path: <linux-kselftest+bounces-17533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA2972072
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D283285144
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C540178CC8;
	Mon,  9 Sep 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQt/TzeU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35D168BD;
	Mon,  9 Sep 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902806; cv=none; b=n5lqane4qnYMZlPHjt3whdxdlaV9LP8tpz4lXo3lwqOKptF9Jd5ZKenT2i36GxJ6gIpE4tdXTYKf3rahtvkKq9FhW/Wh/oc02YfcZ60zCgJAMHtwxe4bltQf0VVnAqGKeP+Fo+CXBxCkZ3WEmjqDIROFosaFLxjP9R0lZl9k1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902806; c=relaxed/simple;
	bh=ef4pbd28HCelXPtMY1fHPeGbPL21l4s6NsCF5v5Xuos=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AGFCbQ5k3mF2HpGaNzF943DexWEbsC+Y52CszMELTe86pKICWZh6CEGLuo/yAC7Rh9yzKgn8OaI264M+LOq4bpe9gf1L1ClpECUIbTyh2OD9IkiDew6LUUKaHvJBpgfqd/8WzKCqd6sIdPxojdpYrbYeuU2OYWJAl9tlIUFOkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQt/TzeU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9ad15d11bso189884885a.0;
        Mon, 09 Sep 2024 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725902804; x=1726507604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef4pbd28HCelXPtMY1fHPeGbPL21l4s6NsCF5v5Xuos=;
        b=XQt/TzeUU6vdCUbQZTvGjwiXvIY5lcyTsHeGOrDvWO+TT9d7wcy67NcPyMUNAvuIAP
         Dqzffn4UrxKN+7IOqHpAqrtcdyOqDO226r89ZhNVeOsEak9cXXbYQV46SvRc8h2SXJLM
         YdkT/5JTGBxO8uiOf7JBRkJFdOnhMLRTYIraTAgqxs9i5RkgGe0dzSouC8Nt8PVH1J7E
         UXhHaaDmHA51CmczUNRZiBy86mEZmPdrcdDi7dYw07edgesYd/3f/f+dNyOy960b4hFJ
         I0Hv+5WpKEtep2nL2lZHVdpIoBLSHgE7s5uB2xpydAnkbKXELUuJ8WwKpOTf0OgD6LJb
         1L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902804; x=1726507604;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ef4pbd28HCelXPtMY1fHPeGbPL21l4s6NsCF5v5Xuos=;
        b=jcy2h9ZQXe9YbzP6YSUV6jC013nMAzxnvGp0RqEmbKltMhKAjka1Ion+V7tP4c3tTn
         KI8gGNNWfWQsex5NdbNO73i+JxrO0Uxj0z47b1P7D1pVXOzPtSTYuYE4K0v1Cn0lpwoe
         Y1FRCYapBPCj8razCV2uLCiuEL6K9Rnp/t/KZ7xGekmL6xd/yR8ntbMwyn0dDT3HjEVg
         nmLxe6Sb9OnSK1Ot9lKOxIhVmn1HUgRIwpH9WnHeuwndadLXSLyyC7bfm2jv83B+t3YZ
         WIQgMBqMjT1qpFI/e4KV/Y2XEgmRjGR7HyXL5gGHLZJpPAANwBN/U2krTkRQothCrG/u
         m3dg==
X-Forwarded-Encrypted: i=1; AJvYcCVNrHs5Xr/Rf+AH7MdkbgNa/Io3W6bRCsBAlFrkz+IFedf9kI0PZHHipwYMrBl138Snf8v2zPV9b2ROIBwFOisp@vger.kernel.org, AJvYcCVO4qBcSKGx6RhR+1t+vwFh0JSo5VvBZ4zac3IMaA6oZHYDzSSDdryISfM6SjZ3sP5Mo8Nm980c@vger.kernel.org, AJvYcCXuXic75onX/0pwKoLE83bYCIqkL2iVS7I2WRidDldxtK4mqPiXcbdZIwzznIiPBDQgXvTxgU+f12WjosU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgussg9b72mwqEYRFLWLDpSh9dR1LXLKBHsYBLyGzVojzeTxa
	e3WIiuj148YqFjuxKBBCoySpgLuq8FB6NmfQ4n9xot8kP22O9hh5
X-Google-Smtp-Source: AGHT+IFa5bFSMKWSMgGP1PTshWTcfDXcgkyF4EVbIprH+d15pzkEartDDfUKRu5mt5lyIVhJSK7wBA==
X-Received: by 2002:a05:620a:1722:b0:7a9:a991:f6d7 with SMTP id af79cd13be357-7a9a992067fmr1382889285a.48.1725902803729;
        Mon, 09 Sep 2024 10:26:43 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1dc91sm235850585a.106.2024.09.09.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:26:43 -0700 (PDT)
Date: Mon, 09 Sep 2024 13:26:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Sean Anderson <sean.anderson@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
 <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
 <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Sep 9, 2024 at 5:02=E2=80=AFPM Sean Anderson <sean.anderson@lin=
ux.dev> wrote:
> >
> > On 9/6/24 22:05, Willem de Bruijn wrote:
> > > Sean Anderson wrote:
> > >> Padding is not included in UDP and TCP checksums. Therefore, reduc=
e the
> > >> length of the checksummed data to include only the data in the IP
> > >> payload. This fixes spurious reported checksum failures like
> > >>
> > >> rx: pkt: sport=3D33000 len=3D26 csum=3D0xc850 verify=3D0xf9fe
> > >> pkt: bad csum
> > >
> > > Are you using this test as receiver for other input?
> > >
> > > The packet builder in the test doesn't generate these, does it?
> >
> > It's added by the MAC before transmission.
> >
> > This is permitted by the standard, but in this case it actually appea=
rs
> > to be due to the MAC using 32-bit reads for the data and not masking =
off
> > the end. Not sure whether this is a bug in the driver/device, since
> > technically we may leak up to 3 bytes of memory.
> =

> This seems to be a bug in the driver.
> =

> A call to skb_put_padto(skb, ETH_ZLEN) should be added.

In which case this test detecting it may be nice to have, for lack of
a more targeted test.

