Return-Path: <linux-kselftest+bounces-38796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D4B22E85
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092472A4473
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC82FAC0F;
	Tue, 12 Aug 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cn+Sse2v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95B2F83CE
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018025; cv=none; b=SRJ4YUO89UcDz/hS2vEkKsI33SqCT6jZPqdL57QL5fVKRqmvCK6Yt0sd/did+XmcdMzaiMAJzPZRxuzIaCmDbm0LPHrGnFSg7oLc/7hx4nEzAImQgrLyfvlG16u7KwDu/S0hrNdxYv3+nMJyWqngOPYwGrmx7PRNjjpH5cbBREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018025; c=relaxed/simple;
	bh=g+xnwDkX5ngCL07XyKRVEFBFnuHLjAvKsgHBvXMtb3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhjG+VJ1ByqYPL67/OP01J/MCbmvft9oemDgnzJdoYX2hJQJNqK2UklU5d+JGJddmuFtDs1REfnx8NPIZkVLjFmGFscqIYv2ppTu077ST+AjUNI43oSZ+YU/kCKfJJTeJdhXTYZ+JyV81R7wQoSk05eJq5i04uTZ3mGaSIbwwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cn+Sse2v; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so576e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755018022; x=1755622822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+xnwDkX5ngCL07XyKRVEFBFnuHLjAvKsgHBvXMtb3A=;
        b=cn+Sse2vQYYSTXa8Uk/+ng2UExnV40XNGXOXyUHm6U6CVhqh5mjDF7JcI2v+sm5xN8
         ZfY+vhoS+NT3r6wJsYkMTDwdb4SYS2qNrUVzbycHGxfXzqPFTBey+v9X16UHu0WTOhUf
         Ysgfqyship5w9gJsontSXHJHLsPehRho4HUj0vnS28fC9uCUgeGgBfyA7ui4D9uidWOY
         8+QHibXXxuSaMTSYPLXF3w/MKOuGSAFbILefc7bxUh5X+fryGgGl09eAljou0nFNi/z6
         qrL+wIxbt4o9siXXFOJ8og0N+ufwWWf57tcsLzpgJTWpWAoTIO3y0xBAZ6r8tx4NDS8Q
         PU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018022; x=1755622822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+xnwDkX5ngCL07XyKRVEFBFnuHLjAvKsgHBvXMtb3A=;
        b=m+ZE7hA6rla1XPO50w/UBKZqpJybs4Uc9BN2YHPuD4vk9CrNJaL73VVi+SXg7BnpBT
         LQ+GsHXWHyL1xh03wFbMx2FG3oSijODYzvWCjFeGWa0dLyEGrsLDSzrNKU5iSlEwET4s
         DWBb690MvxnsLteQtmsBETMrlba+41pj8uRQNsjketN8QuSTQmlGeYQyyjH8zflOj6LE
         Z713mp/k0COOtLKFADAhsNypJEwyUDSZxQiXMaJkmouEJTmQPyZNWLKIq9EEDwiki2Fk
         dk3ZakT4VrGti1THsbAPViucjN4fezHERwC4Sx/zJvQuWmYm+k9zWU97geUqF1i/R3vV
         sm5w==
X-Forwarded-Encrypted: i=1; AJvYcCUYmTefQuRKfcPJNg/iiMfGiRBv2+tsB5IkjbFpwCtf0H4ngFbwQpr2cXQgAVAiucySp7lzKr4Cbz0M1hNjGzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYalG5a7JcMApYu3t5jvSNPh6U1M80GThlio5iteRAlmW1FnG
	JXTrfR1QPFDdahG6B7mZDETj6Y22qQy4G0xveG7ONg4qfe+IPXBAKJpfXJivQmjVGg5YGljn1BC
	Ci2+18BK23S01Kf41jZCpPj2FpDLFmXumOEp1ksRC
X-Gm-Gg: ASbGncugM8KffGhhi9Xb14Rnfyy6kMRa1gu7Y2zXR8q/DSoZ6hTTjFHobZclblsA0Yt
	Xo/Zy/n2WgAdHC38MIl2FqXqFjA1JF9TTVOoXarwy0F6Da9ufdzd0LFzkMP77l5LW7j90BwFiDe
	EfuLW88TA9icMXXsQwBCumjEqhW/fDKWfJaGuJov3CUfHx+gK4vNqIs9BQN4YPauXiQTKnD0LZ2
	IGYkWteozoy9D/qy2UzLzyoguqj07sMZx0eDw==
X-Google-Smtp-Source: AGHT+IGsm+bamhT29td+SwHGDqIrSinbu6HW1fTMkiRm3PCRaVm11QVRWbd5T45tIE+/NfYE+AaeEgGPepfjyo6/j/Q=
X-Received: by 2002:a05:6512:33d6:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55cd934255emr412363e87.2.1755018021029; Tue, 12 Aug 2025
 10:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-4-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-4-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 10:00:09 -0700
X-Gm-Features: Ac12FXyDGk6XAUlBJwbNHP01ld7E2h4F-F2d8KqPQRtX-nKG5NcUnDuUe0iPPMU
Message-ID: <CAHS8izOzh_vvGBCreeMvETO=m3Rsqf8t9ABwXsgzAQre=iO6Bg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: devmem: add / correct
 the IPv6 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We need to use bracketed IPv6 addresses for socat.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

