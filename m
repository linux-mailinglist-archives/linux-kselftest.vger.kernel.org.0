Return-Path: <linux-kselftest+bounces-38795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B3B22E72
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E950C1A254F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B12FA0FC;
	Tue, 12 Aug 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+uXnEM6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9929994A
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017924; cv=none; b=iGS586JPiFkBFggzKGjTwbTOfEKjD0udbxUUU0F7Fjn25MNdMcwy0rlaj4XEcJnJ9G6IqWflTc9oNRIhtRHbh0GuStmbYFn6cYUd6Oszn9MPFpyP4hLhihkiKArynf0tKbEL8xflzzbK1xT1rUDryJCGOYwaO9wEsjR0AGc4eL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017924; c=relaxed/simple;
	bh=Qy9oS0z+URawKAcMl/2Vd9gSleJAKrBFL589siNML9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+9mZGX2iBkTlYk79cDl7obkiLmxIf0j08OSsb6a4s8SaWbGaAxZkNOmj7a2uCCfCPE5MrpsL0hUTyv8MbPXKTaGvFbG0LFScs2TjPvFZFUAPPqY/GKCmzvq4M2cJXX74vxWzYveGG83Hjj861/9uDojNy0kxROgSrJOiqHxcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+uXnEM6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55cdfd57585so321e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755017920; x=1755622720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy9oS0z+URawKAcMl/2Vd9gSleJAKrBFL589siNML9o=;
        b=g+uXnEM6tpzDUt1p63ATLoazdFNurAWHMkp6FPZ5ukVKYeir59mL8iFiH9ycSzC0Hs
         NCIhWWSkVXm2F0VN2BA7Gax9STclrMIz5mdP5eJE5e14pGRty5jMnBBaYULgwXiLQt3c
         Trjpn355ZiFp8PZebTHBFCtWJ0xHJtOSPrLCpQGPC+tPK5bIwMQrVUhjJ9m9hknY4zYi
         4qbv2r7KCHqrerWRKmKTQ9aQ3Gr4PI12guCobwQlH+iKQpSOIixwgKLCdQiXP6qOaexY
         /GUZXHOpVcAzUMsvm7IhR4ZdzSN/bGgMkDDeuqObVlymfuD88FO+Gmx/1pzpydH7XHqm
         fg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017920; x=1755622720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy9oS0z+URawKAcMl/2Vd9gSleJAKrBFL589siNML9o=;
        b=wu0jVpfwoSABD1K3lx33FYXbKz+lfwjQYztfuIsmbXcq0+hkBk4Tj8bB3LWnrf0DGz
         TOE1uB4EAqNcohIvm5hN8Xk3xUgDDJrnDPQmbyMhnoE1VJ1e9h+HUic9S7O//5LtMzVn
         zOSrGTsDIGS2cnERggwZShU5RVEwdVnN1QUhAa7Ko/1FoKQHbwNXBZxMDRClIuzhXSu+
         ND7OeYAouY88dTajb2CJHpwukeoTUm3QDe93Qqpx0OFho83iwQYWSzfrMaSmpKWtpKjc
         yH3oDSiXD3aXfH+uyzt4VOVtQac9IOZsuYrIlfgXjRFsXU+ipLuVjhtlrNQ5ui/36rNF
         4IHw==
X-Forwarded-Encrypted: i=1; AJvYcCUdFDK7gxqYnli1zDwd6dlmGVLSiwtdkYQsO+4y2/d+IMxdVZjx1AFzazX4EvsSW6zBdToBTHhdaTsQgV0PT94=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxmg8uVLLzto+qKYHuHXgzbxrx1B72XJHMxKcAfoCK8JrSX+1s
	E2j9aIjNErAqpaTuLIAuzfUzVCu6zk/BhAj9gA5hmG3u7uVAuxrfcqEAslR81cA8lVbU0a4PcxB
	aQ/h+QGJPcXF79ThoNyb4FOMidynQRoS35YTYxbK+
X-Gm-Gg: ASbGncvQ/aw325xBldiDFUOOv22WJGKlAotG7aF62vwsisgsyZMsWOEXBfVci0otb6Z
	MbNJRoCk5+F1mrbiPwJAoo6yrnLyMTDzsLD/4GPcJNfNFOQ/rM2Xwl82pHOqXetfNFtQOwYY8sd
	6sTXNDOkj3HsUmQeJcA9lhgMuYnJMvVx7LOTy9yUDLzPCkP1RnPeARrsp9XiKPS5763msqCNP3B
	0mDK6Uf8dTiaMRrmG9QoPkW8/p0bmajc2SY3E2/IhIs3HM0
X-Google-Smtp-Source: AGHT+IHFO3hu6qLIYD4pNak/e7/kyr5MizAqIZP39928lL/DShmP8FSt4bKE2xbS7kM4+Wzc4y7I1WoLhK6H6m2xWlk=
X-Received: by 2002:ac2:4e8f:0:b0:55a:2d72:de56 with SMTP id
 2adb3069b0e04-55cd9c8e601mr248681e87.5.1755017920305; Tue, 12 Aug 2025
 09:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-3-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-3-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 09:58:28 -0700
X-Gm-Features: Ac12FXzgFjbwrj8oRSzZ5U6kExdIoKfRjmESYbnIZDyNVwm10F_iDRcuuAZxx_U
Message-ID: <CAHS8izPOYNyj7v9ZaVC1Z_+pZhHGjCLjFCK+55i_zk-VPrP2Tw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] selftests: drv-net: devmem: remove sudo from
 system() calls
To: Jakub Kicinski <kuba@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Shivaji Kant <shivajikant@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The general expectations for network HW selftests is that they
> will be run as root. sudo doesn't seem to work on NIPA VMs.
> While it's probably something solvable in the setup I think we should
> remove the sudos. devmem is the only networking test using sudo.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I suspect this breaks my test setup, but I can probably figure out how
to run our tests as sudo. I can't argue with consistency with the rest
of the tests which don't sudo anyway :D

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

