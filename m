Return-Path: <linux-kselftest+bounces-1407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F56809A0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 04:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CF51C2093C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BC1FDB;
	Fri,  8 Dec 2023 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCK9VudA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CFE10CA
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 19:07:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso3410a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 19:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702004844; x=1702609644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nW5R1L3whjb3H6LuQQAxkTyfGdke42PafpR59i/Lueo=;
        b=LCK9VudAWUsyGSyWgzzk3ltYcN2LIiiuO2udQttM5uC+aZ53d41KrcY4MjyAUIddJ4
         CFBjqKZi3MnDPwj4gioxKIe0NBle5/EVSShVjua84z8m9vofwZ3R62zW2eKMgtrLZX0N
         z9N0baazzhv6gxM9cI94fV6G9WmrUI+oRrOOn6RkUUoX4LRdVKwW3p+PHhRF/4USGRY3
         RzNNreKB1CB/e3e/MUdadTUlD5fqyeSvuuM5Ib5t44U9EO3y9EoxSMn6nV5PzutbV+gb
         IJB7xiXIrJhAgn6erwQqCZS9FMDwbGJccP9716u2Gf75V4sAB+acQuf2PsG7hkk12eNr
         BZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702004844; x=1702609644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW5R1L3whjb3H6LuQQAxkTyfGdke42PafpR59i/Lueo=;
        b=g4GvVNDEoAhm6plv9t+RD7vjo/BFR2nrlkOqub44hjiL5cJBQ95gYwlvmOsw1pOLIp
         41NqdjUrWww8L+GfRcsyOQ0BtZQYwiImvlRiGx08J3HcMau/tqlrqVRxqKel4Gj+b+sq
         DmWCzFvbbHquw4U77Ly16rbzC5F21VbOfquqmcuIjzWjncarJJughKmTkXo0EMua+jGU
         p6m6QCPemMoDtuNkSaLn4S9vPK7t73JgmiNDB9F9/pfxo2p8glScCIlzcxCj/Nap3WhB
         q9znfjDEqIkRgogbdPdS5h/9S2zyqAFCTwK9GG0J3g9fCRf4KsB+Z/ja90Knqnr4BH0Z
         oTMQ==
X-Gm-Message-State: AOJu0YzPeO2xbb0n7/TUb1Mj5VNTSLS26eR9T1CvbsKzacDtaGKPYtFR
	LSW2gQ/TvoyHCG7wXWAMFDFyhedHdAueBy1Wy2aYmg==
X-Google-Smtp-Source: AGHT+IGWvJNjRaDyQ2HhpaiEblVY2IXDlHySVCSNNiEiHdaScFfbFUnbtFE3a/McmwsWNujrHeKQtXdK5ZwZiRHwQnU=
X-Received: by 2002:a50:c092:0:b0:543:fb17:1a8 with SMTP id
 k18-20020a50c092000000b00543fb1701a8mr14087edf.3.1702004844448; Thu, 07 Dec
 2023 19:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207213410.417564-1-rmoar@google.com>
In-Reply-To: <20231207213410.417564-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 8 Dec 2023 11:07:13 +0800
Message-ID: <CABVgOSnC86QafLEj6JE7-_ySMhg2zkGAvn3O0BYk1fzcqbv_7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: tool: fix parsing of test attributes
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Dec 2023 at 05:34, Rae Moar <rmoar@google.com> wrote:
>
> Add parsing of attributes as diagnostic data. Fixes issue with test plan
> being parsed incorrectly as diagnostic data when located after
> suite-level attributes.
>
> Note that if there does not exist a test plan line, the diagnostic lines
> between the suite header and the first result will be saved in the suite
> log rather than the first test case log.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks, this looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

