Return-Path: <linux-kselftest+bounces-5772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1AA86EA12
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 21:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47451289230
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A73C067;
	Fri,  1 Mar 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RdmIIQ28"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098933BB55
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323857; cv=none; b=hWkvw5n+VNAItQ8G8InKDbzj8KdNsUwx18IMJZmPy1X7v7eSPVynnJKxng+WZSKb4uSDhmKFRap93zvF2dtReJuj8cZKND2CnX2Om7iCt6wBTFbhaKzZvnrjDVL3JvjcMhEbwzuU5Ux5RFgQCytNCyGoXDHU9xP9/UdOM9VDdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323857; c=relaxed/simple;
	bh=eIlmeeWJ+q21jvedK7al42fEAfG42vJONf3MXPx/cRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vxl7T4Emi3CmhYrkMoQGIi+GxuOpJUQ3wmbsFIKoBdh4fCXbxwncAfWNDMR8s6Ygb8+g+M/Uw4gEVvNqP0/Cu9hH9cfpEDhIK085P+Yph0yWTBwDksWY44iKNoEbz6ggP017DaHts9AwFat6GTBADOXvKUMwKgjbfeQ1BZJ7nng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RdmIIQ28; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so459807566b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709323854; x=1709928654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GjHlLe8ifOuwGHIPhGu9Px14t+AYIlwm+A28Gp3fNW8=;
        b=RdmIIQ28pwgw2Gmvvf+BEEB01RZKf4N8cCilwPoZ/xPUbaNQXyxG7BPNBvqEYm0V0S
         CTfsTAyWhNTCe4vR7jqBd5dK3aqAr/YVp1AYgI9wramuDZcE1F3HjTl/vAIBHN3N6lz+
         9jEr+QEOYD5QJvHobCe/NxQq83l/MJasdEBeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709323854; x=1709928654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjHlLe8ifOuwGHIPhGu9Px14t+AYIlwm+A28Gp3fNW8=;
        b=Fw4mmtmnoBCH9nqWX+CbEdkNrqECm9JRZPxEbsq48RvbRCfo9KCW0e3HaHqwpqL9QB
         IrNdJF7K8q+iFfMisUF4yIAuW6ZZsP6wQ4I0GKMC/IzwrDBNHCSLLkiu2IrjLraBerQ4
         CuDY0hTlBeoY106KEmz0Olu+JME8hETMkjw7Axt5SGL1sqkCrhtoFUxp25Iby0ac7K3K
         E2q/u7nRFB+m9+SXJoP9+Z3ISi4EaQouqhO11dih6TGuWFUvSNscJ/iJjCX9SOfPIIRG
         4gct0ui01TtIrIGg9S7A+RDIXzSUlBc3IIN4UyZiuZHVIRslqznLtdzCg/6MCrNDc5C6
         5gRA==
X-Forwarded-Encrypted: i=1; AJvYcCWz++8ZB/GBdPz+QNboVWQSnuCoXPMXgat0jAl09FmlrDwWyQnlY0XXpNK/3eAXbF9goCCn0CnhzEhWamKmEowxTcY4E3oMbV7JhwZzHdLk
X-Gm-Message-State: AOJu0YwQ0jdO7DOpZRz8/6rZ18wxSo25CDN7v9IeJIWbpeQfzNLeu41w
	yDX0QXL0I9Sfbge6gUTMcMZvWTH/uDfg04hqQL+s2oIlqSCgMkfKDSmup1ZZ1HAu0dvNxnMK6GU
	mbEzuvw==
X-Google-Smtp-Source: AGHT+IEtnOnKe+5vZ3JF/msTQAPdJ6vmceHkVtm0x7xt3WyG34/s9w5irywxxutUSatCJmeD4nvEoA==
X-Received: by 2002:a17:906:6813:b0:a44:51d8:7dd with SMTP id k19-20020a170906681300b00a4451d807ddmr2221687ejr.0.1709323854035;
        Fri, 01 Mar 2024 12:10:54 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906244900b00a43ab37c3besm1992903ejb.195.2024.03.01.12.10.52
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 12:10:53 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso3530751a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 12:10:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIp3ttuEi7g7yvmYqD6U9xAm3DMW8uQhz82BseAi2sndWcQfpP3zSX86LPF+FXQT5PdWPqc3nlR+XDY4mN8QesTF/bPfvaL44u1KWG2uuN
X-Received: by 2002:a17:906:e08d:b0:a44:731c:bace with SMTP id
 gh13-20020a170906e08d00b00a44731cbacemr2324717ejb.35.1709323852310; Fri, 01
 Mar 2024 12:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
In-Reply-To: <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 1 Mar 2024 12:10:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
Message-ID: <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Helen Koike <helen.koike@collabora.com>, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 02:27, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>
> I agree, it's hard to imagine even a simple majority agreeing on how GitLab CI
> should be done. Still, we would like to help people, who are interested in
> this kind of thing, to set it up. How about we reframe this contribution as a
> sort of template, or a reference for people to start their setup with,
> assuming that most maintainers would want to tweak it? We would also be glad
> to stand by for questions and help, as people try to use it.

Ack. I think seeing it as a library for various gitlab CI models would
be a lot more palatable. Particularly if you can then show that yes,
it is also relevant to our currently existing drm case.

So I'm not objecting to having (for example) some kind of CI helper
templates - I think a logical place would be in tools/ci/ which is
kind of alongside our tools/testing subdirectory.

(And then perhaps have a 'gitlab' directory under that. I'm not sure
whether - and how much - commonality there might be between the
different CI models of different hosts).

Just to clarify: when I say "a logical place", I very much want to
emphasize the "a" - maybe there are better places, and I'm not saying
that is the only possible place. But it sounds more logical to me than
some.

            Linus

