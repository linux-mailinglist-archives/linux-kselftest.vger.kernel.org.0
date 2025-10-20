Return-Path: <linux-kselftest+bounces-43591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B4BF37F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441EA4270AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F362E1EE1;
	Mon, 20 Oct 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUGiufY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475FF2E0415
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993476; cv=none; b=l41rHmDf0jROMIe1DnyO/BWjuw1VWNPEE91MYKPNifwhnRI4dx8M3J0yV1cn57n50eMz1Loj9I6yduUtFwcUWQ+bRFoEvlFZdDt8byu48pD3zMadyBDSYD+AtdH2BwHwrfBrvm7/Ff9HzvY9BCNJeK9e1R/Fhbxb/4kMPQ2RZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993476; c=relaxed/simple;
	bh=d/DNocr10We9+tRibfaGdS7+LWNCjniYedbAm0aObrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2ZmgxENl/WrdZwc1aRBgpGpduynwO8j/fpb7RD3Ew0hbqNcu4CByIVSyWnIoUoULH47LhfC65OiVH/IqZ9dcX60/QEIcvPOC+vOUNNcQxEc4QDBIp6lCJr1HPw2iFQyxY8vxt3xNFb4BIP5VL5qgP8NBjK8nr48CDZqF9qXJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUGiufY8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59093250aabso5995298e87.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760993473; x=1761598273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/DNocr10We9+tRibfaGdS7+LWNCjniYedbAm0aObrM=;
        b=FUGiufY83yAlygBhP4TFTjFNKd4/t2agmvIzik+ZTYI9pDcxMgppvelmm6v6+YdXk7
         hUkmPBIu99umbqZrqqNdT+rCkDffaSnuAcGjKwG2B/TryDqmvTPWAkdm6IKExPqInpzW
         Z7o5BKrwzSKavjm6Qb0GY29CwMids43H+cEGDWZlhHx0negGtFLCUTjuP5DHtA3KyTzg
         f4GD2XF7CpyLvrI1rXhqFcWkFAwafWYXd7b9WebJ6/vHG0YmsW1ynh7H160kVZkB1i5U
         l/zLciJkGsQ1EJqPZeczG2YQypSE9HTmRK2REJmlut/FJEn38uwGTEJrF9MivwqsGRCU
         NWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993473; x=1761598273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/DNocr10We9+tRibfaGdS7+LWNCjniYedbAm0aObrM=;
        b=kZBztTG0BgNqlSCuHX/zctEi7omgiVXJvFpPiUwv19//67L75/CQ9XDmb824cLAql/
         /pfzvKUTRHMtz2czIS7bmx41DRg0gU99+3WTrBYZFmzqVNejHqcwrd8OQy5iusPqkpmt
         l51ACvYDdWjKfPk3syjooWtUocSEtrSKlV5l3+xVG5g2sbWYE6ts/VCoM2zlhD1RsuZo
         DAD/QtFWqBCuLX9IvLOBtB1zbRNpTsXiwX4EqaJ8K0w3Sgypip2eaFqOTViSjNOr5DFS
         CePnryEnjFpjg5auR15yzp7CXPCJE1Esl2Uy9wZTeYZmR2TYy+Ysa7jIVXzkeHhiH/Rb
         MESg==
X-Forwarded-Encrypted: i=1; AJvYcCV/FtDjmXOMP6SlGtfxVogtN/Ms/PtX9OMmy5DRHrb/JjWvVGuxjqG82urPPwjFTRQwsMuoke1EsD06wKmetRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+PB3yiWvCL+q2StNT4uuDgYpyh3XAx+Za0wLBCVP7onxgN4DD
	N2om9Nz0HGI4MQTgsyrvsJ+qhkgeK4t2P7NnItnuS9e4x5xAqqu/hbxQbft5QRzBu/f2LRE6Dot
	ZGDmbT4rN/YU6kjhEXiLYeW0gWvZGQPGLa0KkXRhR
X-Gm-Gg: ASbGnct3f5ccxcYckjwDCxEV0MRZxbnIemv5YIptbnBTVIg4kwweITgfT/slY+an/vM
	G11uS8mY/YBAxlIzTy5OJYknLIJ6TYSkk/aqQJn2D3Jv20P7YL6Wi4zcOesbkVa1r0sPR8RuQ1Y
	PSJbFU/rkc1Aeyi1SoPcuhiDSWrng8L3TBGnyKVEAhwJPOTfoZPMCMmVM4iq71DNp6tuaRrZanr
	Dwo2hy0c8m65/en/Mv5irgmJX3q8/2nWL5jG4qhA5Eb7I/aGiJMT0qZGTjwj6VNAxZmLSaBHQ0P
	r2iZs0k=
X-Google-Smtp-Source: AGHT+IFptH7lgeIQIF8Wb79g6w5+VZiUQoWjQkKuVLjC5A13jG0UM4rCDEn9XOnf7H7IQFGgZlhwFcy9kFCumyNbmPY=
X-Received: by 2002:a05:6512:3082:b0:58b:63:81cf with SMTP id
 2adb3069b0e04-591d8579843mr4495565e87.55.1760993473069; Mon, 20 Oct 2025
 13:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-19-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-19-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Oct 2025 13:50:45 -0700
X-Gm-Features: AS18NWDGxqhjIaoTQRNUFc91_bCzfrzvv4w3uLlEfEEIlUZmI_rVPec29OqIzHg
Message-ID: <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>
Subject: Re: [RFC PATCH 18/21] vfio: selftests: Build liveupdate library in
 VFIO selftests
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:

> +TEST_GEN_ALL_PROGS :=3D $(TEST_GEN_PROGS)
> +TEST_GEN_ALL_PROGS +=3D $(TEST_GEN_PROGS_EXTENDED)

The TEST_GEN_PROGS_EXTENDED support should go in the commit that first
needs them, or in their own commit.

