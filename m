Return-Path: <linux-kselftest+bounces-36135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE798AEECCF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B0E3A8943
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 03:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F31D63EE;
	Tue,  1 Jul 2025 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS1KsWxF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C60A926;
	Tue,  1 Jul 2025 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339513; cv=none; b=G9vXQ9Yue35q170Q/NrA9VeJ1SqWCSj4vK/1jh7s0oN4gMvLBv6xytQ9jDFZKF32Rn8Gx3GIlI8Btsin28vt5jCQwywagNj64aFXJ+gfZqCelunl+duntnP4SwBu/1B3tTVxt3MQNDFsLVFH206YNfxRlBRxtRee2CJAuukJSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339513; c=relaxed/simple;
	bh=gUyGOCch3gn6XpxWY5QNQhH2EQOnOeQtq0QEk9FAvLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQeuQN++7jscF4Zlf3q6pruhN8Isa9ZCqnd79bdBH3qaf+A4TYCwIngxWNJW3EhSTM8pa3TSLMy4M1QY3PoBrZ08XHsnsgWNK/YNdSGvpSbj8NWXXicuM1XrkNwe56noznFtLa+m+eqGIOb42bsSNERw1t+zgcrJceg61Dv/KFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS1KsWxF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-addda47ebeaso1094254766b.1;
        Mon, 30 Jun 2025 20:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339510; x=1751944310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4dYyADSCBeNUgmcTsT7e0/hHvL9bx+mynbmUEp3saw=;
        b=dS1KsWxFzkeE2pLMGL2O/tPmTy/4BmWN/XVq26K7aEJKVEbvpA/DCqR8EaV6gRHDL9
         opOwktBE7qtJ1ySKtAbsAHlDqI/pNYskOCC4y0ANiyau5FGnlOYL6+RVVsNu5PFQNRRW
         RbYL8g3b3Hf/gLNiX0NnKBFSd+07GVSBaqm5VadjM7bejjR6UoyFKAp3/qnNACbVMYQj
         ahVWQEnogdPx8H+zSfuIXEcypxZ7EpziweHVl5+TCWnVgYy0BLpsnrA2vHBYsmThvbaC
         m/wK+jC1n0jA7d7ifV82hlxWFw3Edutc54Gd85jrS615d/ycNMpUh8D+XCk/IFvuguTi
         fXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339510; x=1751944310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4dYyADSCBeNUgmcTsT7e0/hHvL9bx+mynbmUEp3saw=;
        b=D1tBPnWyltlgyYA96u4AXaWOG64GZCjs1BouFI4O8pDmMAbKzQ4rOsTlAC6Ky0n2BA
         4Sn5cnXTUNLYn/WQpKUEfRsyxrCuh4st2t6E2CbAOS6gFnu7G/mVuWuml17Ok3dJDuC5
         cnXbO699d9AZdf9aOJyFnDUQI/p8pMk8g2Tv+cebEwHxhZC1sygFseRoJUtyg9Pcm/u7
         1X+M/237i18EdUWBaHL+bOeBEkbyNFNuNXMLvgsTXBiYCul0w/QNXkKbsZ7faEeRi4mw
         UdxHC9pISRHQfmKEtvqsgMc67FkSKQmkzrDJB9/oeGAa9AjYY9cHoc1qDAVYUU//veui
         6+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYeZALwYnW9FC+Tqd3UruCOxom1D0ajCWy9/VvxiBz5Vg6Q/Wev4WQ5I9uWhJjztKLw33NYth/TVHt8SStKnM=@vger.kernel.org, AJvYcCXgj8Qzg2UbCWB5TWzuCIQy9wW2Liv6MruVH/rDv+npF2u0iEHC8/acSu4qaZtfo+/AxkIqXneE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28fu9UwuMcQZS611FkgUJNKb9pdKQjoVMbevJ8Q0CttE+sRki
	mNpJoltptvUhnVlkRWxqaFiSUIdYhBO0KtLGxxVy4fW46pFsCfu8mTVJxf8jFgr+KKsZsZ0UOt+
	PV33ZEKWOty7LUb495mh6FQ876BabQqY=
X-Gm-Gg: ASbGnctkBa6GDauNO7Ymfv7VWk0uLIA59ciJF5Q1CDaWiTC6e+4uaB46t30l3B+L7qM
	yqAJve6K+wMt5VaMdMQPxnrbwgLkyZ1iJqjwgB85FQXo9kiNosibIsmitGSx4dTw/v6ejKIEZUe
	vsCh8q8GGyLB+Md7QogA7r2/2CuRearue1wNCjt8DcIt46Nw==
X-Google-Smtp-Source: AGHT+IFbZbVlTWYVBHL5VhIDsI0Id1Oth13L2v+d+EmtgTqLRBKDxudncNmWv6124BztoDICBTK944lyqJBFnqi9SLs=
X-Received: by 2002:a17:907:3d16:b0:ae3:7255:ba53 with SMTP id
 a640c23a62f3a-ae37255bcd3mr974720966b.53.1751339509891; Mon, 30 Jun 2025
 20:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630092818.1449599-1-ap420073@gmail.com> <CAHS8izN9CWwwUk0tfDy1iGrfwYLTD9paiF622jP4z4mgD844uw@mail.gmail.com>
In-Reply-To: <CAHS8izN9CWwwUk0tfDy1iGrfwYLTD9paiF622jP4z4mgD844uw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 1 Jul 2025 12:11:37 +0900
X-Gm-Features: Ac12FXzT1tAKGjWECnijrdEPAwV7DdNlNjCX9AImkD8tQEcVkQV9tT0EdZJoRVA
Message-ID: <CAMArcTWf7pRi+qVAhTTTEG8cZjBteeNk=EtLns-=RPoKRmeKWQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: devmem: configure HDS threshold
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org, sdf@fomichev.me, 
	jdamato@fastly.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:12=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>

Hi Mina,
Thanks a lot for your review!

> On Mon, Jun 30, 2025 at 2:28=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > change it automatically.
> > Therefore, configure_hds_thresh() is added to handle this.
> >
> > The run_devmem_tests() now tests hds_thresh, but it skips test if the
> > hds_thresh_max value is 0.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >  .../selftests/drivers/net/hw/ncdevmem.c       | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/=
testing/selftests/drivers/net/hw/ncdevmem.c
> > index cc9b40d9c5d5..d78b5e5697d7 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -349,6 +349,72 @@ static int configure_headersplit(bool on)
> >         return ret;
> >  }
> >
> > +static int configure_hds_thresh(int len)
> > +{
> > +       struct ethtool_rings_get_req *get_req;
> > +       struct ethtool_rings_get_rsp *get_rsp;
> > +       struct ethtool_rings_set_req *req;
> > +       struct ynl_error yerr;
> > +       struct ynl_sock *ys;
> > +       int ret;
> > +
> > +       ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> > +       if (!ys) {
> > +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> > +               return -1;
> > +       }
> > +
> > +       req =3D ethtool_rings_set_req_alloc();
> > +       ethtool_rings_set_req_set_header_dev_index(req, ifindex);
> > +       ethtool_rings_set_req_set_hds_thresh(req, len);
> > +       ret =3D ethtool_rings_set(ys, req);
> > +       if (ret < 0)
> > +               fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
> > +       ethtool_rings_set_req_free(req);
> > +
> > +       if (ret =3D=3D 0) {
> > +               get_req =3D ethtool_rings_get_req_alloc();
> > +               ethtool_rings_get_req_set_header_dev_index(get_req, ifi=
ndex);
> > +               get_rsp =3D ethtool_rings_get(ys, get_req);
> > +               ethtool_rings_get_req_free(get_req);
> > +               if (get_rsp)
> > +                       fprintf(stderr, "HDS threshold: %d\n",
> > +                               get_rsp->hds_thresh);
> > +               ethtool_rings_get_rsp_free(get_rsp);
> > +       }
> > +
> > +       ynl_sock_destroy(ys);
> > +
> > +       return ret;
> > +}
> > +
> > +static int get_hds_thresh_max(void)
> > +{
> > +       struct ethtool_rings_get_req *get_req;
> > +       struct ethtool_rings_get_rsp *get_rsp;
> > +       struct ynl_error yerr;
> > +       unsigned int ret =3D 0;
> > +       struct ynl_sock *ys;
> > +
> > +       ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> > +       if (!ys) {
> > +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> > +               return -1;
> > +       }
> > +
> > +       get_req =3D ethtool_rings_get_req_alloc();
> > +       ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
> > +       get_rsp =3D ethtool_rings_get(ys, get_req);
> > +       ethtool_rings_get_req_free(get_req);
> > +       if (get_rsp)
> > +               ret =3D get_rsp->hds_thresh_max;
> > +       ethtool_rings_get_rsp_free(get_rsp);
> > +
> > +       ynl_sock_destroy(ys);
> > +
> > +       return ret;
> > +}
> > +
> >  static int configure_rss(void)
> >  {
> >         return run_command("sudo ethtool -X %s equal %d >&2", ifname, s=
tart_queue);
> > @@ -565,6 +631,9 @@ static int do_server(struct memory_buffer *mem)
> >         if (configure_headersplit(1))
> >                 error(1, 0, "Failed to enable TCP header split\n");
> >
> > +       if (configure_hds_thresh(0))
> > +               error(1, 0, "Failed to set HDS threshold\n");
> > +
>
> hds_thresh should probably be part of configuring headersplit.
>
> But also, failing to set hds_thresh should not fail the test, to
> maintain compatibility with drivers that don't support configuring
> hds_thresh.

Okay, I will add the setting hds-thresh part into
configure_headersplit(). hds-thresh value will be set to 0 when
tcp-data-split is being enabled.

Thanks a lot!
Taehee Yoo

