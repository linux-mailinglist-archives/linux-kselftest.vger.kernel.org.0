Return-Path: <linux-kselftest+bounces-18611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE47989F9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B92F1F2240C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2518BB97;
	Mon, 30 Sep 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmQaaN83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2D152E02;
	Mon, 30 Sep 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692935; cv=none; b=NpqZO5wk5+T8XytlMp/wknsAnpsWPb7LkGasj5/Y1PX2nJ6QkKkb5oAYZFzgPoUvxzAF9IWnYhmPX/nq3XiYt/YU/ntufFvXvY5qkCHr26UWPyqb3WfveQBEcbS/QNBFfnZ+fgnlMSlMUVTEe0hpXCVoN+UnG3J5sFO1RShVfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692935; c=relaxed/simple;
	bh=ctuclsZKzXbjCrUI0bjwLy0V5pzv2OPfxtLnt+IOIlw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XvRyIT6ALI8q4sXjGYhHsI2DXlyJFxlsThrIDSMZMQ2/oj6Xd1x8wgHZgHV7w5iEzWIkrcFuy3TlalZgyFmAhXQaFMe6dYWDNWgAT02xZuNZmcNtUWI1inA4cpfNiiWdd8mW4ef95qnVkhkWTK9WzS8zel+lL+beWFQMFwUbxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmQaaN83; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4582a0b438aso33947311cf.0;
        Mon, 30 Sep 2024 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727692932; x=1728297732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my2lIyuIcvRttarQMt2UalGLjpHwIfPU09pYlufrVlw=;
        b=ZmQaaN83QA2/4RjHrgf7X7Ctn+QEUddUujEeHIQefxG5XQ/eYXlYVF/NcFYBOqxYsH
         VIjGpzwoaqkaHCbIZUpQGYTUJTTfuvpyEyCW/xTMlvfGUUi35vwoRp9MnUbJyW8DeUUF
         zyyqPCtg/7nCLcsC5oEi0PiEzRciso/iMlkr0Z+woPb+69P9P7p9luEP6jhAFa8cCjao
         TI1kENjebvAeVaRADhWFAVXFH9V3XB1/CUZcGaxS1cVpuorfgep/CdveDUkPXD6QYl4k
         P10WtVwzex0ADOdjoKe83PvvgBuJhzMdbU7PODf+6JI5IVjvN2j9IJvUA7TUsbBBhMZg
         b8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692932; x=1728297732;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=my2lIyuIcvRttarQMt2UalGLjpHwIfPU09pYlufrVlw=;
        b=h+GPfl5IMSB5kEbFh9bTlIyu6Nj9CSbuaWODIuueo49ZnH0ME24lTYmJfJelVwG+Ec
         rhqyVktjumPcyuGsTFKbhAGvC97lrb8zVyL1un8F48doryGK5lEhdMaaaZWkZ4luFs0+
         nmnsdaVRTlzZUpWXh6rnO3fPv0Sy6cyPAsWSr79Xm24B2W9dhx1CFoX27Pt1dXQRhNep
         MTzaufTqu1RzhwT98OSriniOM03lVh/ivpYoMKaAEs+bFN8ep1Tz7k5McAlcfNxMAwyH
         0h7M5U25mEq3RmYO16Ez4I1gNpErX8oTVleK+Trhbr6gED5xGlI58HfDuLO9ghhyXO82
         n+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs3PF7C0LPc+x//m1PplAc8bcYrrtghntdmeasOiugnpkduC47jXkfbe9OKboXu+xrfecQsTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKbNdbDorVKbB65K9/X8tQDsBYuBZFydedf3/uT6eSKRgr1w4
	objERiB5D3R+8Q95teCcFWgiMUex5IUsu9O2gLlJqTUGHdsxEYDz
X-Google-Smtp-Source: AGHT+IHYNmJu18YfrA8WHU+3ro8YWd6kwZl732+3K8hGbpSw7SZv2D8RmEoa/BIo3FQY3WaFFaP1FA==
X-Received: by 2002:ac8:7c45:0:b0:456:8b5e:bcf3 with SMTP id d75a77b69052e-45c9f2a75ddmr184989521cf.52.1727692932475;
        Mon, 30 Sep 2024 03:42:12 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f28d527sm35470861cf.1.2024.09.30.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:42:11 -0700 (PDT)
Date: Mon, 30 Sep 2024 06:42:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 willemb@google.com
Cc: linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66fa808374566_17948d2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240930092416.80830-3-kerneljasonxing@gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 2/3] net-timestamp: add OPT_ID_TCP test in
 selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Introduce a test for SOF_TIMESTAMPING_OPT_ID_TCP for TCP proto so
> that we can get aware of whether using write_seq as an initial key
> value works as expected.

Does the test behave different with this flag set?

> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  tools/testing/selftests/net/txtimestamp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index d626f22f9550..5f5de79d0e51 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -893,6 +893,12 @@ static void do_main(int family)
>  		do_test(family, SOF_TIMESTAMPING_TX_SCHED |
>  				SOF_TIMESTAMPING_TX_SOFTWARE |
>  				SOF_TIMESTAMPING_TX_ACK);
> +
> +		fprintf(stderr, "\ntest ENQ + SND + ACK with tcp tskey setting\n");
> +		do_test(family, SOF_TIMESTAMPING_TX_SCHED |
> +				SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_ACK |
> +				SOF_TIMESTAMPING_OPT_ID_TCP);
>  	}
>  }
>  
> -- 
> 2.37.3
> 



