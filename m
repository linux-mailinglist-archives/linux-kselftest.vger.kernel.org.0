Return-Path: <linux-kselftest+bounces-5714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE786E103
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 13:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F7EB2294E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596B6E614;
	Fri,  1 Mar 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txU40ruL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71F6E2B8
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295883; cv=none; b=px1DZr/14hzzLwYoKsEea+837qFhacdIZbtUWEjki58NpKUrAAK2IMaoY3PR1lMmI0u/8H/WVQOwfD6v+DK6mSW8N2C2kjkyADHGNyieNKh9C7R67rEFueMNEPEHqLfMRGUJxSej8tG2t55RPPrNFARUWyRljv1XGsNZv09Ydeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295883; c=relaxed/simple;
	bh=k9Rkcgum2pozTxkBzlG+M1fZGCMA8hbLFjLcwISl6cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+hR+EBHp9JryAjI4GNQYmjQ5a4az+lZXkmhvPkPwlegp619LrIWK1FxYkSrV96FQSLSlVPRQ+36VI1PgULZqa2qxaielgUwt5HGmUAVbb/C73R6198AJLh9Dlu+emfF24UqMoC+aACH8n38Sn13CK/LCb5YrAqpgMwy1KRrS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=txU40ruL; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so963595241.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 04:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709295881; x=1709900681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Rkcgum2pozTxkBzlG+M1fZGCMA8hbLFjLcwISl6cg=;
        b=txU40ruLqnbN4V+jPeqJJwaw1yeqnHFfpD8yUj/fcLRgLIAGGITkYcXFK2QUWmy9TE
         KF2Zxce3EIA1H8QTF7vlr5SOB+7UOkUjelIjOjPBKgeK7eNl89NLkKsGnE6KRQmQBLjG
         gnEWSbAfkoI6EMBpb2DtqWwtYyhncyXc8xgkRyarLc4V/6m9ug1U0HIidt6QiOblbaXo
         S/4Iy3FrELxV16zFj5wiWKJBeY9bqy5+BWobxvcOOFS2mKI+QJ69+XFAa7N7HywjK0GB
         6tl4caAas6PKfvG1r756iPT4jELjY9h0qPvvucHIoge0AF6VNdpDFc3NRz39RSE4rDDy
         QZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709295881; x=1709900681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Rkcgum2pozTxkBzlG+M1fZGCMA8hbLFjLcwISl6cg=;
        b=cx62Z7ap5fxHzms9E95dFpXRJtfGI1ehwKErVrUNwbuMMdEkqgR7CuDSSym+KFQhq9
         bh/h+iP5qI0M3dmmwcd7vWnsqSjRnmETXWU76BMy+V0dp3nGjnENIcTepRyBym6Gi+o3
         ZwTSSef9j6StzgfLKwtZHNZYl1wEwU4G1tnFOzIDnyUTjV710ybWyhbSjCYoKbZxnPhh
         YzvUvrDTEIevqAG5IKZqjdRf6yc7ork5AGKArp0bAArj4pMavGD3XfqsFkzCLchC56Y5
         Jn4yLq0g/1+OqbH5+vMUzJ432nB5ZyVWhn+xgLjsfdGooQrNt248SL++QytBftTQKPWJ
         zP+g==
X-Forwarded-Encrypted: i=1; AJvYcCX/6oirlmTIASb8FwaToXegZtF+aCj3MUwDOwphOBsh/2oAFOxmVFFETlVxdsI1gzKx2bUdppcwNLKzc6rx4gWg/SbcNFzgtw4um6SvUy4Z
X-Gm-Message-State: AOJu0YxgW0l8VhOjULNga+d2qTQNopqbwLj/F1pw89PnUhX2InKNDoym
	HkpNqS4iiRkxGxUaCtTxDok9LFt+3THTqEJCbtsEomFkkTK3Ld6Lx6E6IVPv1T1l/sdT4+N9Gz7
	hr4rGsPU85T63V8niNMmeMbojBHe5U2BiXNnNWw==
X-Google-Smtp-Source: AGHT+IEQPGVNTqruAg8A6mHm1+O7pWnzubd3URRuR4eT0PSAL4oFvoy0OF6M+SO6rvj2bK4eHHipjxBtL+4olti6rVQ=
X-Received: by 2002:a67:e21a:0:b0:472:77b2:f99e with SMTP id
 g26-20020a67e21a000000b0047277b2f99emr1202644vsa.8.1709295881170; Fri, 01 Mar
 2024 04:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229143825.1373550-1-pctammela@mojatatu.com>
In-Reply-To: <20240229143825.1373550-1-pctammela@mojatatu.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 1 Mar 2024 17:54:30 +0530
Message-ID: <CA+G9fYtuQfNTr3fgJ5MeYCXqvc1x17TdBRxJ6-aD76109=Pk9g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/tc-testing: require an up to date
 iproute2 for blockcast tests
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	victor@mojatatu.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Pedro,

On Thu, 29 Feb 2024 at 20:08, Pedro Tammela <pctammela@mojatatu.com> wrote:
>
> Add the dependsOn test check for all the mirred blockcast tests.
> It will prevent the issue reported by LKFT which happens when an older
> iproute2 is used to run the current tdc.

Thank you for the fix patch.
LKFT tests run on Debian rootfs, Please suggest the packages that are needed
for tc-testing.

>
> Tests are skipped if the dependsOn check fails.

- Naresh

