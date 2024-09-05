Return-Path: <linux-kselftest+bounces-17243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0F96DC35
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F22628651E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF61AAD7;
	Thu,  5 Sep 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpFgS11w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887810940;
	Thu,  5 Sep 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547517; cv=none; b=L3qZT8t4Tfc9jOCUem71FBcccL9cVi2oKHQtmrf1tMI3WrzgfrJa+Z5i6XykdJRKyD+4w64RbfWDuhKXiFj6v+okx+TOup4pCH4OZEwUlRLOhvf8HBpaqxqLqMIDOPOlnYWY3dchpkqgl2TklRMoSe/e4+UHV6SxqP2oAp/1THg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547517; c=relaxed/simple;
	bh=8pe3R5n5nWAs0e8+9mh2nqUprXBUcIXiBNGB1irEfbc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jIM/Jne7WKU7zKmZVEJnmuAXwiLfv/IZuXHdtrne8icHba/8DFHyrfQhGR6WOujiwjnLAuREbTVLgku4A0txRPVy0v2F8EN7/v0L9nBSuutU/mnDo3GN631bJxZYkwQvG7mUPcGwCLlpjo1xXxsjSDVL8UTelFC9I0ivtH6ZKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpFgS11w; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5dca990cf58so529028eaf.1;
        Thu, 05 Sep 2024 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547515; x=1726152315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pe3R5n5nWAs0e8+9mh2nqUprXBUcIXiBNGB1irEfbc=;
        b=EpFgS11wJRJ91V/rWa6RorX/Q7YhUEyp0kK0xnsDvrPb3GI9IK35YsO4lQRgkNH2ki
         QdJTDdwqkEdFTm9VKPwAS+7Y75G9QFqefNYUvM7qP840RqKV2+s78hDMz9ulFXS1Ax96
         V6ksdyxRv4q1+wf/lkb7+GYEGAMd2En4EMWbZRbT1M4yF9IGFSRB7abDZQjlqgvQo8AE
         TherwMeLiELQ+SNO24pHv42QwFHa8Yj+6Wb3+KNnwwkp/u8GE5QOcXuvj1p8sXAtVdh8
         bvhzJgp3+vJqipELCRdK0FlECz5jGZpA9r2xRKKaqAzlhDAn0pN5BIiz5idO+xG9EKDI
         QllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547515; x=1726152315;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8pe3R5n5nWAs0e8+9mh2nqUprXBUcIXiBNGB1irEfbc=;
        b=UcPygsVLPyOpFf3Es//8QHI4PME2WGFhX/t94O6MuKTlIsRAZZSOriUKJn2XQk1pZp
         RaWJdGnWEReTRlZxtO0Tf/RW43exMnViqQZxOM0TRM5oWojPPuP+0S4qlkpx3ZUQ1BLO
         nDKGCgxUUfunpe/BxX718peVMFDSpw3MZkXVPdvtIWLzvdSezXSpZuRXXPWYYkH2uqLf
         Fe0npGNd+E/Mpe1sk5AxxDam8Xgz/TQ6zkgTgT3jO6Pv27N0N8VxHeJyvzU6BDJX2nhL
         dBCPBuvDej8j1XXTM0iPSLQZkhyPmwbmdTwD2mtF4pa+wbq/K0KLoXaDZ/ebR13rZZm1
         hkRg==
X-Forwarded-Encrypted: i=1; AJvYcCULneGalTMTgSedx/ySAgYWtlAfgy2ewYUOoZ+x9vnmLFavILhqVrU1O71BLAd/R6NZtaCCSJNqYhT4S1IwFJs=@vger.kernel.org, AJvYcCW4lddyTrQERtVSl82F8mfF6XFsVzSPiueGL/IOeJWL+micx1EHXkIe0dGHsRQpP1pPGW7Vs2Ry@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ0B7AsuCzf+VgJjzf8mAu2XZ+g0csWjOOHgD1UyebMu/UP8E
	p0fmIroNIbKTVW4pU8xMRFBo3mzT3aLOO0+pFEy4ulLdcQdQcI4/
X-Google-Smtp-Source: AGHT+IF2ZfRtyIzfn8Dhi8BxkYa98JiWGieNRTus/pjzEZZrpz1lAzqDG1XIyGoHF0eiT3R3S7kMsA==
X-Received: by 2002:a05:6870:3286:b0:270:1703:b70f with SMTP id 586e51a60fabf-278003230cfmr14110520fac.22.1725547513360;
        Thu, 05 Sep 2024 07:45:13 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f026caesm78735685a.135.2024.09.05.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:45:12 -0700 (PDT)
Date: Thu, 05 Sep 2024 10:45:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d9c3f875b90_18de412948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCfPSRaXhLMipeaebn58Knzan4gguEtfeWHXau=0eAwhA@mail.gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-3-kerneljasonxing@gmail.com>
 <66d9b467d02d3_18ac2129427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCfPSRaXhLMipeaebn58Knzan4gguEtfeWHXau=0eAwhA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net-timestamp: correct the use of
 SOF_TIMESTAMPING_RAW_HARDWARE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Thu, Sep 5, 2024 at 9:38=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
> > > timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
> > > SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.
> > >
> > > So let us revise the doc here.
> > >
> > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> > As an exception to the rule, as a one word fix, can be squashed into
> > the feature patch, I think.
> >
> > > ---
> > > Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb=
.c.googlers.com.notmuch/
> >
> > Please put these at the top of the Suggested-by/Signed-off-by/..-by
> > block. Their more useful to future readers than to current followers
> > of the mailing list.
> =

> But I have to ask if it looks a little messy if the first patch will
> grow much bigger than before with adding some suggested-by tags and
> links, and a separate paragraph to explain why we touch the doc...
> =

> Cooking one patch which saves my much energy is surely easier for me
> but not for readers probably, I assume.

Ok. This small patch can even be stand-alone. No need for a series.


