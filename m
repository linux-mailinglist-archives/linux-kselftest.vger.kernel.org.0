Return-Path: <linux-kselftest+bounces-40719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FCB42EBD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 03:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D0C1C22612
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A921A239D;
	Thu,  4 Sep 2025 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjCqXDKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19637339A8
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756948644; cv=none; b=OQbCLiBy2DHdbS5X+czXYHyUK+Kk4QxexvIQnOe9fkZEByFDA1iMqzyx0D3LtFDhs12Dc/c3PqfA7Z5gixvWlb7pa3ujtF31MeZ8kb4tc3L3I2FDV91Me3WJRHvjKvvJ3LOGO/HIqVWjzbtBrKBohf9/axhXxP+FLU3on3tKVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756948644; c=relaxed/simple;
	bh=8WHvKqvvSEubjuAjLqach/gWo8VeUE96OgFtsrxG0zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/gmLfvJcy3O4R7pl2v14t+cz/spEFqwd/PG7+sEI0awvmqVLE1nkQsExBg5UJyRaBtLBA7gPQ97iK4+tkatFMvTCuXav9qYjROc5EtAF1LDGLYwqFQMxiJzHBcZHH0vYW4U+8DgbbravA7aQQ2EukS7o/1YGhFc8bvzfkKIKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjCqXDKC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so3117a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756948641; x=1757553441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WHvKqvvSEubjuAjLqach/gWo8VeUE96OgFtsrxG0zY=;
        b=sjCqXDKCHJLkX57C1R322AwwlPTY1QdFRIEkjF2JXSFpTHZ7/DXxV/d2G1GFCyFuR5
         kUl/dI5lJzyNInlocXVz1Crl/nNmVFnLEavGUmhS4eJAQWaFcYxbfImFZBLoHZ6hYl6K
         srczSy+hQM4TobdUPYxrAbkFhfoH0JcI2Pn27srZnEX3Vi8CX1jkJ5Eh/d8RPkWqv9Bv
         aEFZlz6zWHguC1XOV/9vzIYmDaIcfLlnoFfmTZVdKYQMM7JlFluzyoWimUTVeoikoWFt
         qcmsGOYns/+lgiA1KsL8tx2YU9Z7XMXW+7BjSeISAGPXpWHdSBg75KgGeu4sYVw5Q0CZ
         HkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756948641; x=1757553441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WHvKqvvSEubjuAjLqach/gWo8VeUE96OgFtsrxG0zY=;
        b=clk5g+bqAuwl/BocZ0KtfYWicdxLR5QPnYijBN7ESrSUXylR9jLP1dg9HXQRz/DbfY
         xO5sQcRpInGC3LyYOpRAgS9UatI99A3kHirwA1Z8+yLYxCdruiNwvXUft8ZR8uW/mu7n
         bBFa6NQnVR5VAGKqMxbnhGmU0kNeq8mEoK/L3R0UrkDMoQD0VamlKjqB7ASZ33AmIDmp
         Ca0TODpvkcnn7t7FufWlOFpPQTtpwvnUv0AZQM6bA943qDJPsUJCp2YaVvvUWUZHz7y1
         RJCrxXPLvBAkq+QPjwVV1/JHaDbyLxBXosUZdc7QsjE9f3uwVAebb6vSdAs1gQt6hHhB
         cydg==
X-Forwarded-Encrypted: i=1; AJvYcCWi8Zk4dYvr3VGtnOYUFjO+uRf8t/Szw/YKaqzqno9G/Sq/s0WCbE/SrSb0e3babgLe1TOsk/Htm/NB6UIYTNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDpECkazYrcJfrkOe1J2yp/Uz4VSbjJwjKPTPag1eDX/7AG+A
	bPJE+Srx9fhjlCArtMV85mmktRB33HAtTjSumktv1s8yeGWWyEoJBxOrorzEhYYbzUM1e0EHwqR
	Ia/7hH0mG32juEmVcGaxupXzUyACfAqTGUogdJm/7
X-Gm-Gg: ASbGncuMkRRMK0HA6x9gmP2KVM/hcHWTF4rww7dvYnLHEaymheLpAntO6hKOFR7jeRP
	a6jMnqHkwixPRVrC6XGSsDVoFlobDzfyf7seZL36Jb5ysBCm6Rt8O9EFv/6STM6b7tjglDUGBFB
	m9NG07iph2E1KHw8JeGRoCL+sF6ulSuKIjA1FbPePsgtGWOw1HC4w0JNRNKHMat9C18iGsjL/6T
	BXENtbgLCrZtf47A9OGXERAMZ7GnBVZVdFHVx57jZ8p+A==
X-Google-Smtp-Source: AGHT+IGNaVDWuTXLfEYCkZcF780c5W6sUlcccbr8SJ/Dixpmi2WMVpg+C3u1b++4ueIrG0C3O8SsxYci+0qeFibVDbI=
X-Received: by 2002:aa7:d497:0:b0:61c:e774:38da with SMTP id
 4fb4d7f45d1cf-61f5c00d99dmr3416a12.5.1756948641405; Wed, 03 Sep 2025 18:17:21
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902235504.4190036-1-marcharvey@google.com> <aLjlLl03-YJ_avaa@fedora>
In-Reply-To: <aLjlLl03-YJ_avaa@fedora>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 3 Sep 2025 18:17:09 -0700
X-Gm-Features: Ac12FXyfm3TngUE4mQAcz9NuluXDmrgAEDjytvy5pH-XdliFBTbBKspeqvai7_w
Message-ID: <CANkEMgn4UT7GyN1MjdGCJKD13ENJ8BpAEvLotT=FkReZ9YBRyQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Add tests to verify team driver
 option set and get.
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com, 
	willemb@google.com, maheshb@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:02=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> w=
rote:
> I didn't find you use namespace for testing, so why include the in_netns.=
sh ?
> BTW, It's recommended to use namespace for testing to avoid affect the ma=
in
> net.

It does, at the beginning of the file it runs itself inside a namespace.

