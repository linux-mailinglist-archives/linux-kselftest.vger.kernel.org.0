Return-Path: <linux-kselftest+bounces-3854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B08442B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 16:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693A5B33E2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5883CC5;
	Wed, 31 Jan 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMfqgBXb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6069D00;
	Wed, 31 Jan 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713581; cv=none; b=BHrXzpLw/JaprLhzc6YqtxX6KIw4RQs3BA8Dk8qzBmacK4nO3ZazR6UuuqN1KffgFUqBu2tC/gLjqrLXtP13a+iWtBHxfDEwyVM6/mI+Kvn8M4dqxZpc6W10KewPrcn6pQAYC+Sfbdt3KW4LQqz4rtmh6TtpPnCY19Y1EN/thzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713581; c=relaxed/simple;
	bh=rjL+S8VhYams7cY41B+Sx5INRlbi1v1HLjzV2vQ93yk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VKQY7s3cOWuVEWPtl3hIRlH5PxZKB18IWkNmyR7hNL1YKrYBu74OwPWr8H+wHXn1CDQt3hB1qPx57TKC+Uk9UJRe3/57U3XoPg8fftpOEko5heWnFCCvovrnHaaHvAdCYc2UvGFaALCkc5f2mFK76rqaMfBTSAvA6x48jpK0C4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMfqgBXb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a0ba5098bso34710021cf.0;
        Wed, 31 Jan 2024 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706713579; x=1707318379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TaPxT+V6eIKAuLdvwPcXj6pCum3OdDHWE8PoctSlZQ=;
        b=OMfqgBXb1/HKYBGKISpJ1W/gvk1rL2320RIJpF8tgBhu5pJBZjJ4mdWJcJHgZR+NKY
         Pki6DAeH8CjSNnwu1ZbCRuHshIp7JRG+k5zAI26vukISJ4g0Hnb6PUV0+s/aBZZT/bBz
         tNyJu4aNJWSN7ingMHplKItfFMBKawFUMqLbuhl+4nSLxQ6hkK8j3jFDS4wyGm9hlvB6
         5sX3IOU5l2ulGF/cw6I7j58GuL5fZT5tfziRhrbEKnXc4C4DSgeUzCkFnJ80g6BwEQDl
         bfI7L12Fyyb2wQsth2lkU8S0UuDx1cyB7piRC/zuhAlDcGfUvEQifuWflYF86aYhF+mf
         bOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713579; x=1707318379;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/TaPxT+V6eIKAuLdvwPcXj6pCum3OdDHWE8PoctSlZQ=;
        b=nuNwf22naYVTgHHPhISLm/3bE9Xul1ncunYEFC8qNoQkZTSfsQLjzVebgoXArmJcP6
         d6EGmHlYLoNd89hPceiasOMOTyEXLgrYtLve7XxGZRkDY8CoWk7Ft6PhoqhvpXkSyNSt
         K4TexukDijvew/mJZB+spgTEEst2j3/Kzntom0ta0lSJafEPs5eYYgQO6VnK5cnODTmk
         WZNyZIeAIT9maV/XWYql5r5HzMFg0rG9wZvCjyAQY9U0FSUlIdKo2ExdjU0+TSOU+1Fu
         aWjNmRWsOkpeSzwkHH3WsX1FX2wLySGSDasoJO/bAPe4+xeGp2eYdq8Ayf/x77lZEUBD
         FxUA==
X-Gm-Message-State: AOJu0Yw+zQQxBsyQBkAOn7USKxr5uLVUrXLqkh3pr22vR0C78UaC7/n2
	uMzydco2qOpCpNT3QfwVdYP+IcsUrcXFctaPeSpEYrwlZu9xTT1X
X-Google-Smtp-Source: AGHT+IE9oLSRxN39V0rks9U2CfUNVGGvbNKU0GBv7t6w5XMk4BKLn+FIGOmmgELtiAQXvimHjDK7Yw==
X-Received: by 2002:a05:622a:189:b0:42a:b153:2331 with SMTP id s9-20020a05622a018900b0042ab1532331mr2413547qtw.0.1706713579158;
        Wed, 31 Jan 2024 07:06:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtbBsGAeBzWs6r8c9+61iowfTf6ogo8bO3lHuWiUjAEIDfCpV7GLCrsHkXV7tHd+H38uIncQODYO5YEnIajcmOIHhuQPNdYIEV0BzIEdWYvPudM8pRkPxKUMpPRYVqmF0S9gnYVoq2GIy0HFxLPLw5z9Ow0ML7RspFZ6LUq3TmX7+Eey+oHJ4TIvsS20QoEiyJWxbdZsTmRYO58kXz1LbDupj3TGRbtxB3N4xpHGzE8rUPxmfVf/eDvmKc0+C0pJY3
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ka26-20020a05622a441a00b0042be1188749sm1226683qtb.81.2024.01.31.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:06:18 -0800 (PST)
Date: Wed, 31 Jan 2024 10:06:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240130174736.03c79071@kernel.org>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
 <20240130174736.03c79071@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 26 Jan 2024 21:31:51 -0500 Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > The test sends packets and compares enqueue, transmit and Ack
> > timestamps with expected values. It installs netem delays to increase
> > latency between these points.
> > 
> > The test proves flaky in virtual environment (vng). Increase the
> > delays to reduce variance. Scale measurement tolerance accordingly.
> > 
> > Time sensitive tests are difficult to calibrate. Increasing delays 10x
> > also increases runtime 10x, for one. And it may still prove flaky at
> > some rate.
> 
> Willem, do you still want us to apply this as is or should we do 
> the 10x only if [ x$KSFT_MACHINE_SLOW != x ] ?

If the test passes on all platforms with this change, I think that's
still preferable.

The only downside is that it will take 10x runtime. But that will
continue on debug and virtualized builds anyway.

On the upside, the awesome dash does indicate that it passes as is on
non-debug metal instances:

https://netdev.bots.linux.dev/contest.html?test=txtimestamp-sh

Let me know if you want me to use this as a testcase for
$KSFT_MACHINE_SLOW.

Otherwise I'll start with the gro and so-txtime tests. They may not
be so easily calibrated. As we cannot control the gro timeout, nor
the FQ max horizon.

In such cases we can use the environment variable to either skip the
test entirely or --my preference-- run it to get code coverage, but
suppress a failure if due to timing (only). Sounds good?


