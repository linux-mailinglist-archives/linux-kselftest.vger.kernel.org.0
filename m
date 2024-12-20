Return-Path: <linux-kselftest+bounces-23653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2049F90D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC881189642D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE41C4610;
	Fri, 20 Dec 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6/y9oHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5EA1C1F1F;
	Fri, 20 Dec 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692434; cv=none; b=Cn9WAMxS0WuW6PGhF34YqJr9SMiPs7GTtJB0dTM7y2xILvnQYGGRsry9pKLLis4K0z5foU1a5GEtECWe+uq5naHo1AYiPzPjskLbgO1kUavJGMGX1unw1xCFtbWwF6xsmaDS5GK3wT+gAiPzYqyQ0zXfNYt3BZ+Y954DCFaAEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692434; c=relaxed/simple;
	bh=4ncuJMnReeVs8eOMu4awK9L7h8C8WOMebthwRegivuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGXWuz7JDl+kmE65oyN94auygkoG1Ju/gTmQKwikzCVd+w968Jik9gZC/lpgmoS6VDJK70y0ksdRU70/CB7+qe/l56d7hQjq4ELawMqCeMQNpyHDnbEtBDmxg9yUxPoiO/Jrbp0zDMyUC9KXhtQcWK34YsUJoQe9q3VuDzQHBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6/y9oHT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2da12248fso1450839eaf.1;
        Fri, 20 Dec 2024 03:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734692432; x=1735297232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ncuJMnReeVs8eOMu4awK9L7h8C8WOMebthwRegivuo=;
        b=a6/y9oHTomytbT+G3FlatprjtYcOQ2qkULc5zIK8h2klfASaQgDPbQMWKMZULIkplO
         eTXtFkV1B4qjnzD2t7vYAEjtHXeKgbOGREQPpvnLuyK9aQfbUasaTQHbK/MW7NTulLlM
         FhZ3n6MyftJC1zysK4AUpy++Zrw+F63jBnvYnAoPKIXc2SErOoWRdzbbmlQbxVl6l8q7
         LZZK6+f+uch/HyNoxFJIBSAgqDVBpt9yaO6ndJqWkExugyJYgAqVReTdJO1TOz8r6m6C
         8zkWg9P+NUkOXTgulOdUi/jkj5Cf/k6/oCzYGvB2iycLNvQuWJjmtPWf9Cf2FLjF/y2k
         P8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734692432; x=1735297232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ncuJMnReeVs8eOMu4awK9L7h8C8WOMebthwRegivuo=;
        b=ScNiS3ERNSGhFv+v3bQlcPdTaaYDqBHmZCm65pK5WFGRgs0OoRcUUwgCMekROhuP6A
         BqHdhFVcq4ydnTc/2z6NHTIuaUxQ5qAHWSlcIt9rgUxX5UJzG8Phx4U6CN6G6+RKg95f
         /f6iLKcCvK2DmO95cHXTM2nw7YXLNxtNNa2OjYZZMXhTu6s8+H0kraXMEmoh+x4vzqP7
         fSYwLqKlgEa3E8+zCEWf7R2xhja2X29GHq4n7SBAwd0lMK/fIPsDhNE3yI2xUuPEeEQS
         nWxB1/ZxzpGtmL/w0xMyd0ziSx89WIAmEcUyT6PliT6nwlVLGD6hjHpdPUo04KOrVP1y
         8Rsg==
X-Forwarded-Encrypted: i=1; AJvYcCXFau+Mpt2JXfgh3MJnfDEWUCehkQr/BSnYhO0+S8Yljyih5oDBdrjJ1FNrQ2NSgTdPDebzJyW1SaH8sgk=@vger.kernel.org, AJvYcCXPAat+Dt1PXmT99Z0RXfeu+PTHZfmxurh22zgO+Rnp5ecUakWGcrlgXcMYlzTToVC7XqhWgJuBAeSaN2mxXCc4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6m9kWXp9fRvtBnpoPngafABafmiGki4J/C9OXXPLaY+di8yg
	Y/KnEzruivjpOP+YN/9MlWKtn3KuvBrARV5BiVypVaSBTo1yf6YGGZuABoeqTBXHMnRMUvefphX
	e2HcxtzRHzWcSauIXIFs6Aeunf7k=
X-Gm-Gg: ASbGnct3tQakyMNq77okrboz7c067yX5HwsGpZKKA+CXydf3PSQ4DJaEExWmbXc5k07
	ilLMj7EgfPSNpkvgzocBhYaUCCPIp8TelJfONFBb0363q70G7+iZiyLW+xkc043WWXy62
X-Google-Smtp-Source: AGHT+IFTXVg/HT/WINUpDxJWNMrwpBi0uDCbB5gFq3ArMRfXz+UCM0bzxAtFUX1nz0ZPw9F7Sx433RufOx4B2nJOFI0=
X-Received: by 2002:a05:6871:b13:b0:29f:99de:4330 with SMTP id
 586e51a60fabf-2a7d10b0bdcmr3938690fac.4.1734692432404; Fri, 20 Dec 2024
 03:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net> <20241219-b4-ovpn-v16-2-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-2-3e3001153683@openvpn.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 20 Dec 2024 11:00:21 +0000
Message-ID: <CAD4GDZxg6VUrB6VXqRqz3o5jUS2KKikv5n=bHorNbrWoM_wsug@mail.gmail.com>
Subject: Re: [PATCH net-next v16 02/26] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sd@queasysnail.net, ryazanov.s.a@gmail.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 01:42, Antonio Quartulli <antonio@openvpn.net> wrote:
>
> This commit introduces basic netlink support with family
> registration/unregistration functionalities and stub pre/post-doit.
>
> More importantly it introduces the YAML uAPI description along
> with its auto-generated files:
> - include/uapi/linux/ovpn.h
> - drivers/net/ovpn/netlink-gen.c
> - drivers/net/ovpn/netlink-gen.h
>
> Cc: donald.hunter@gmail.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

