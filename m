Return-Path: <linux-kselftest+bounces-17405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F02896F927
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FA71C21E40
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD001D048E;
	Fri,  6 Sep 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyrQrZ0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B02D045;
	Fri,  6 Sep 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639552; cv=none; b=oH2WxGfZzXj4/R668lVyBeiMWaeg7wozphyFv7Sm/wckYB0AnLJVF5Cqnii33mIAFfAf8lLL7V1MMrKPwz6hLxxot6ZxAWRNg0M4DnBThns/T3C6JpPMhJR9jhpKz0Qp02e7zHOlDZGDqQTOOqw684mFSZUgFZQb78HuxiuVR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639552; c=relaxed/simple;
	bh=sUIjw6J5Zhl72OejvSGd4be+a3PR6uydCmrLtsi5OW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnFcaViJkP0Yylcnl60rTKnGJCJFMBaTCsrj0w+YwqYxJaHz80zbFd25e2WdCz5dIIai7Rw/QVIU6GjWSs9BickHcub5ajIEWKsj9KjHYWGuG6X7HY2dtijSWCHsEOSTwEW/leI/+eoKlZDOnn/s53dOFI4UIH+N6K9XJ7jkMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyrQrZ0u; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a8f3e7a10so76594639f.2;
        Fri, 06 Sep 2024 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725639550; x=1726244350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUIjw6J5Zhl72OejvSGd4be+a3PR6uydCmrLtsi5OW0=;
        b=EyrQrZ0u7C57Ul2aTNHGnwgeF0lR0JWvc+BVyUalbMk5+OQbDdzubF7yjqHtKvd/S+
         AuPp4Op8KBPOIcq3QHprhev7yKpqTx7r5NUEt2UC4CUDDUOZ5BnCiLqXOymvJd1nyXLO
         zgs35Z5j/M1w17ixgio82cknsAbt006SgVMPxkROtydrgrSGy7zyp9citrKny6DbtO6m
         Mk1t2xhLUshV6H51FrGiBqNcTFmGp9Xj3v/aJLRuiHf8uNKNqwMFXxWRAZyKVzYhYl2V
         XGTzkGjEd+Jt/mIuHJZZ/oGWox9J38/TluLIJh4pSV0Q+v7zm/J+/nob3tB8iJzvbPX+
         VsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639550; x=1726244350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUIjw6J5Zhl72OejvSGd4be+a3PR6uydCmrLtsi5OW0=;
        b=AjlO7pyW3I0LaNMh09/GF5ZykUQSNIhTLmUUGUxxJXWiQsltrvNBXBfIq6z+3VXmO/
         ND7jPop6/Qya2kW85Pbb+N369jsGvzPhUwerpKKy+ZqqIVZOnOJfpaoKJ76r+n+cytRm
         Uutj+VFvkWbBCZ22O4XcScmQJgXJwwuHxbMPR+dlpxmgPMrOezLETaYpqBz3+LqMShhO
         hTa/Q0se4WPSTcd+1I72uRyOBuOlgMwbfjpmx0S8gljB6WAaNj6ALX8NR/OoeTvPo5ha
         fdSzQUq1TYIOxyx1UvzlbseJ9Ue+crkUJcW5wADuf25mVs8vcFFSi2OAaUHJiU7iPgL/
         bg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs78sxGL1lXDAfAS3u0kXRjsZbGolUiuxmKFVU+eWHK/T50mloJZ6mX2HeBh78M0ZjpUY0/6i3@vger.kernel.org, AJvYcCXFnm45KEgdXx+NcA64ZLcfiQCA2Yh/IBG23wAztHP+4W+P+yhVYdZf12UvTWwtwEhAePNGpZJLqtUXW+UQuX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xHkpApoH+uKofTjXbLRG3f+wse+8g7eWGvuoCPIjNhpyQM7k
	cK5bAL+ytV4DVaUrPe8Q2kMMHyyuyWGwiU3e+/Vt/DaDiV0AUE2vOT2321D7sJcJ9jIPGha7V60
	KeA6/YIrtnEX6WqPKADrBgGF2Dj8=
X-Google-Smtp-Source: AGHT+IEidF6ubeDWvg9DxQuFOBMuQ2ZFrgm3I2e7IKIlf7yuFVqXUY5h8M6mXUiWMphRPF7UsP14bB+JMAp9X5K/wwU=
X-Received: by 2002:a05:6e02:1c09:b0:399:4535:b66e with SMTP id
 e9e14a558f8ab-3a04f0792b0mr37602645ab.9.1725639549920; Fri, 06 Sep 2024
 09:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906095706.77636-1-kerneljasonxing@gmail.com> <66db1f2a40965_29a385294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <66db1f2a40965_29a385294eb@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 7 Sep 2024 00:18:33 +0800
Message-ID: <CAL+tcoCeB-bVanW49Sv=-BMc7SOHcq4m8S4WtaER2unzPs9aAQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 11:26=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
> > timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
> > SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.
> >
> > So let us revise the doc here.
> >
> > Link: Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@wille=
mb.c.googlers.com.notmuch/

Something seems wrong with my macbook... Really strange

Ah, sorry, I have to repost it...

>
> nit: duplicate keyword
>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> indeed

Thanks.

