Return-Path: <linux-kselftest+bounces-3997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337D846A17
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 09:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FFD1F2AC24
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BE917BDD;
	Fri,  2 Feb 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5quuSBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8518624
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861006; cv=none; b=CpmKa2Y0WHvwkx8Bp0Uq52VSIceQ3tR8BAUYSDS7mEiJDkZJrWL+G2M09gBP6RcPSsvc5nJ43pyDGJ3sMceggwobPGmjqOmH0UP5tK9eYrxzVIDHDSEB+vWY2QV5twUSvQxLdSDTkdso4fvpYlw5uN89kvY65ry0KfXN2m8ZyXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861006; c=relaxed/simple;
	bh=0oMylLbW9ZNzwTzwnz+7++Pst18Skg2vbTJYvge5Uck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8fWuzWMgY8sGXG1oyJHX1b6HTtdNkVbEIhoxjM2juYmzLnNWAZyDIhvLZbmAHSlB+lqXYjYofedKQ6ISNTbvBPCzb9GjD5py5/rOCdOH0QUIuDQrYzoEzH+gkbvcQV8VBmhvOPIdVCbluWBbiVtfNZxxU0237NIEtGWB1oJgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5quuSBu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11466a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 00:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706861002; x=1707465802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oMylLbW9ZNzwTzwnz+7++Pst18Skg2vbTJYvge5Uck=;
        b=P5quuSBu2zQQoNZgqkrQea0Ser8H0BfKfeeCq044rog7Qg3H1WfFw6Og+Z8KWLM2CD
         lCGvxeJrkrvDBdLPBlaCqFZUghqjUVv7VcNpftyyG79f9lS83WrfNAhPF6bZioIA6u4c
         tdKsGogoX6rWFd42sAfWSivKLP0t5CevzYHUZWShinOMHgtGuxa80B8s//6qQv5YkNur
         0qVPujP3FJrS/XzedyTGxgBpN2Hm/nY5ojQNJFdxhgv56K51+PX2BEEGSdlayNq6tG/Q
         dApUZ/srIU7qhN2RxLjeM3QTgLyfTWwkwpaRVZOaEa5BYn7ukD62p+TE7h4uA6Mxo6m4
         6D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861002; x=1707465802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oMylLbW9ZNzwTzwnz+7++Pst18Skg2vbTJYvge5Uck=;
        b=iV+9UyxusrorqJ4BtmwpIAoVHQk/xCAhpTmpM9Be0zL0qKDNqdfJMi1uqRoE3FpJ5K
         uisCZ2gWVNe7yz1MmF5H/bvtQCvYcKgqXho91Or2cqKAzEn2ARpbXD2VAkNVlsZW8ZtI
         I6q5Hx142Vrbbgw5uZIh7uVzqClX2qkaNd6fhqrqSUoxuYsVhDohWiSeD6luMP/rEBAO
         dgWZ7SQR5hSx+vJi41pMr5JaF2Ll9TFlbEyC9eLSkgzaUsioPAfIw/hzG5BvONESbmWF
         Ty+8FyTVh2Va23qn7YnAsvs3Uhu4sfx/AUoyMywoj5lARGby5MqNHoQ5r9h0zvbzjTpH
         gM/g==
X-Gm-Message-State: AOJu0YwTQgzQBj5pcuYGbcNM7X6Orqz0kz2vNt6jU9neO+5uXR3aRRBS
	5OeTuYhp6TJe82/GqaHpeJnmo4rHFKLiy6AbekAp0Z7WovdpS0lKOQExIk0BDzGynyIg7z9ZpZD
	+8sI7Y4N56NopS7kJU3OMnxEFoYpS7MjXMc/D
X-Google-Smtp-Source: AGHT+IEq8AKlbi9wI/1/P6iW/rfXtlvDdRL9SHijXbQoldby6jTh5exdKZ35PszRJShlBF0XGgF7iezV+6yIO9aRYPc=
X-Received: by 2002:a50:f689:0:b0:55f:8a86:e694 with SMTP id
 d9-20020a50f689000000b0055f8a86e694mr71013edn.3.1706861002332; Fri, 02 Feb
 2024 00:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202001154.414386-1-kuba@kernel.org>
In-Reply-To: <20240202001154.414386-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2024 09:03:11 +0100
Message-ID: <CANn89i+5Z1_t3OX8pNeVumq=QcErqnVLx9L=rU8GQqDTwfFq0g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: netdevsim: stop using ifconfig
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, horms@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Paolo points out that ifconfig is legacy and we should not use it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

