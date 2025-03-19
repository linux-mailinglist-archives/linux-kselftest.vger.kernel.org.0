Return-Path: <linux-kselftest+bounces-29416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F3EA683B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 04:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE35170E98
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 03:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649224E4A8;
	Wed, 19 Mar 2025 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY9kafSk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E83208;
	Wed, 19 Mar 2025 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354800; cv=none; b=dbXyztZzriaFomitCJ7RIqbNor5Tzw7ocGY4bNWa2tG4oqUdHdYsF7i0pmGjh2EAq2cJbMxjfGyFD/27xZ8ggKIYCVg6Uf6bNstHJbLBxrpcYyl++NXx0abnCPJwvLsc/g5g+OkgBoVyWx1IIA2KjcJ4KJcAggN9egbzuOCE3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354800; c=relaxed/simple;
	bh=P/ehgbpk+5vA88XB2CClLC1viuSC34YTkdQTnDE5P2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsjJsmGRBRZFqxoj3PGGYeJTlszTImjLZkqmAVRFGXQDlSGKesVHwCIjn4QfO6NAmWtwEtlzaOrHPXi83N5QxxYbKr8TyQcHF/S25BYjLucSzSS4xVQhHXn5ChPS7KBplJC638jnR6k6Okrbq61/hpV+r1H9cN0BNfkaS5y30o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY9kafSk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso3716262a91.2;
        Tue, 18 Mar 2025 20:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742354798; x=1742959598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ONc2NKKA9rxhBuj8Dk0LD4YRO1Z4JZeeX+A7dNlQ7iU=;
        b=AY9kafSksyNzOMNr5R4uxgZoBqu+dOlRsBj7JZXxmy46gI1q7qm15GXU4INY3hRdOo
         bnHObEOEy8+SaiJnpKvAbTv3XRPtAUWFAmdcNDEURH4wvQ8AzoYHN9RVw/ZdqiUG//eG
         l6o4vGLZfCNmUrQbYKMSYgYSMsFU3Gbluw+os7//70A0/2R4DC90NSh0lgHu4PtujPsc
         PzAxnokbllAdvxpoiHLdYNmxtqjwW2SDpsvbcVQOaSePSUGD+WHi3yxAB4FLBtju9UX1
         86hm1+d4ExVs1xDdB2WPgblNOjQCyICcoGdxVZwx343Dc3ZKgtjfE40I0xt/1HRwCNDf
         ocAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742354798; x=1742959598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONc2NKKA9rxhBuj8Dk0LD4YRO1Z4JZeeX+A7dNlQ7iU=;
        b=AgYQ9Ssp8l8hOC7qjbnXUFYaDTkklTvWKmjO1bB/sWIp49Frm0RnNMALvZM5FGhl5T
         fzyisv+Pw3MfBjDbirN/l5jEwyLYohpEKnSokFY0HjHgoLd9I8aSWRKLLpBSANdvC1yu
         7jhPdHQb8v3XAM1ArSjqgj/2k7gWeZIwU+lccX6sCRMyjcB7qizNlUrby95q1TFNhE11
         KjbHfpkpbSUj00IpClollPLiX+64gIjpKHWqFo2c3l6miHi0hpGCwPB5JeYT/xQtxUT1
         QbXVxH67hknPa3VzBwk5UvRMIcbI062w77B7MTxZe1JmCNGTkUi1xuSsDA7kR67iauZ7
         DOjA==
X-Forwarded-Encrypted: i=1; AJvYcCUiiD8AjW5u2tON+cjnNmZrjfNm0kXR7ngrV6sER5HsBBbluccdYT897mJZIlfn7Jt4TQEXCBxp@vger.kernel.org, AJvYcCVZt7s9M99n9APzZKLwUrBRX2Ju7aGNrwISK9AaugstMY6eGMUT+ipAmbBB8ISjGVh4QaT/QDJBwj6t45f99qOj@vger.kernel.org, AJvYcCVgji7N6oTutv4ENkHncZTfBRWHpRCxaPQ+Gj8tBTnjCjO+uhPl5PsjzRMRCRUnvsXtDpqduC6nmkYkslY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2j+cb0NEpt3iSE06IAilKRf2pl/+NwwRMlt4SPIlQ8t2C1v3
	fdXdCuAAfSKbqlJR8b/aVIrPTdHPFcs1rhSBGEj3xFsdteT46mCZE9tlNltJyB/kSWmtyupA/0b
	7dZSnlYr0IGcFtEh155+dwLtH28A=
X-Gm-Gg: ASbGncuXxmZPJZmoITSU4DHNTjCWTn6rV3KE5as6XpDP3X2zNzhdYYKtffawH8hvdtz
	uaIQRHugDZzkab75qlgPGTJeG822LWT/B6bnHIWdCHI6nW4nfLdYwoe8ExOCwiXrFCT98Jtvjat
	88Gqk+AlnwXfFVxa8eH89AQakhwA==
X-Google-Smtp-Source: AGHT+IEhh9je53mlU+YNfo/E+s5+DZiahqCtS/UeM+2c5VO6wETPeDDOp5McEZW/rZaZIbcob8g2Isw+8odAftssVBU=
X-Received: by 2002:a17:90b:4fc5:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-301be20750dmr1899287a91.35.1742354798394; Tue, 18 Mar 2025
 20:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com> <CAJwJo6bkdeGh0j1ABfrMQ3dRD7frEsNnJERWP8-jJs8dSYFwYA@mail.gmail.com>
In-Reply-To: <CAJwJo6bkdeGh0j1ABfrMQ3dRD7frEsNnJERWP8-jJs8dSYFwYA@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 19 Mar 2025 03:26:27 +0000
X-Gm-Features: AQ5f1JqMFkj02AZydIrEhT-StmOCueqFdL_RVZCS15cegHVwZB6ib4jq5FwdKqA
Message-ID: <CAJwJo6Y9g0JYiLY-taxtj7bo=Jy+U7bqTFsQjhgu2Re7BgaLsA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] selftests/net: Mixed select()+polling mode for
 TCP-AO tests
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 03:20, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> On Wed, 12 Mar 2025 at 09:11, Dmitry Safonov via B4 Relay
> <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> >
> > Should fix flaky tcp-ao/connect-deny-ipv6 test.
> > Begging pardon for the delay since the report and for sending it this
> > late in the release cycle.
> >
> > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> I think patchwork can't detect v2 to be the same series, so doing it
> manually here:
> pw-bot: changes-requested

* potentially because of the -net vs -net-next subject.

However, as I sent the patches with b4 relay, it seems patchwork is
unable to authorise me as the author of the series. Ugh :(

> Just in case, v2 link:
> https://lore.kernel.org/netdev/20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com/

-- 
             Dmitry

