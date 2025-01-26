Return-Path: <linux-kselftest+bounces-25180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B262A1C616
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 03:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE6F166809
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 02:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A2615B0EF;
	Sun, 26 Jan 2025 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+kbEopA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42B288DA;
	Sun, 26 Jan 2025 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737857015; cv=none; b=RXqyxGbnaLOQc7Rf0Utgb9J9EOo+joa9pOI48h1DbDu3H5mIBX53piEHkuuzo3piqjh+Prz1YwOuvwA3hpKhQDRy/APXOPFEHeqlfZ3xDLeBc+v+ZPwJ6HpNT/wk2eHNNrDHH40aG3ePNMT6rKtALFd4y4bwBjXXFbeu6dqCPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737857015; c=relaxed/simple;
	bh=MfNmqo28UUpusfOMSYIFfY+YUnsTo2r4H/xMK7isI+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwTygu+wN+PTCHTgVw/xPqxBV6xAkfv9cdoZnqAefK/Fqh1pzLcrwOVjiYvw5q8Ik9AwgNlEYjyw18pnPrg6ffqc8ybGUHDAfqr7PiBJph6+nQALvk0Vun0Fwq/kaOOoA9odX5nbUm4gbXvZmY/5o0ApLdMN9pHN4G7ohj/KQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+kbEopA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21bc1512a63so66920885ad.1;
        Sat, 25 Jan 2025 18:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737857013; x=1738461813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgTyPCriW4fhrR+pmULZkv4C0qMMiZVcoywU8rj//4s=;
        b=T+kbEopAOJEAGO+y/N03ZU3qdqrO0wdv0z5R6/yWyI94B273OpxKXu2SxINvj64KK6
         0bw/Opa681DlUhzZXt9uCFzT2XKAEsPztgvKBDVh75xMrMnAusOYmrJswTgbPrhNS5ev
         aM5MUazbNtKLhe61HLifvN7CUJ8Ku26ZNAcXYWlqDAq86NIpbbVJfu1DTfsLSE9a6c7f
         TXjeq425yOWkSRMforR4SEhnLLrCopik4MJk+qh2Hyp4Pgc7olteGQt1WTgmkfIKISbv
         2ARKkvmQS/Fwy04ZtFrTVdWpqM9W4GipXtcDbn1j5S5Htw9TxhHmmaPzO6YmHXYtFXvQ
         OcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737857013; x=1738461813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgTyPCriW4fhrR+pmULZkv4C0qMMiZVcoywU8rj//4s=;
        b=D5vcEYdSbJk083Ep17N+NAE2jtEp1oabpPJYFXAEhl8Bm/pm0YCPzFKID5/nNhoEE3
         UUX6aB8Rbpp0/82m3BauVTjuizfbTAzx2AtJIBp1WqP4liPPipw/OQ2RoaWxgZ+Nm300
         UZfeG+Sc0QJZMQhEAOuUxuw+freONcZ8Lvst81UHryVoRxyla9ZBgFAOLNGvs7iUGcse
         RcTHsNv0FYzpv8vKjCQ0b6svengw4QIeuTlZVvcRWNxgdKh1r4Tbydgo4Xr6fLKNYhoe
         3rO5OwhI17Xy/F2TxMEW0Rea8bcIdKYnJDJIAgkjcX69UrxjMlUJvc+RNsTEr1G8B6e6
         o3SA==
X-Forwarded-Encrypted: i=1; AJvYcCUFfJcflidX8F+VY+KO1D619z/JBy4u2O2VVuKTjUcR8CSTQhOHDa8wiAqgKxYaRdJdza42RfMjczwtpKRqE3Q=@vger.kernel.org, AJvYcCUaCE38QTMwAzJTqKdutE52aLAHq0X7B5L21O4KImnVFqGUrlzWa9PIuJnmcaVwsTAkLfFH+yDq@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXj8xCzXFEzLl5LqGk94YHGGiRT3NLY2WaZ/gNZ2oGeITLWUD
	rMehwd74HSAPW4VavUo/LJNwCqhYsCmzDB18M8TkEvSQJzjFTRs/QirF7QR5bwA=
X-Gm-Gg: ASbGncujXZ/s6CIpFuPW2egOFP52b7EgIeNEMoC6+I4h3zQ9Wd7g89uM8g4sCBNP4SV
	MV5k8IApnQzvmZpLlegEnR1rj8Ayl8C6KrqkwtkFNMkTGoXUEn2Ze4V+DN3YC3DXSffmBhX/PL5
	FbiO2kJL9midOe4TfffUjaFs9DUzOY5qwe1kLJxe/t4PxnaggPE+hpEnjmc62xywYmLg9cNrUOi
	72DyYNAVS6oaMK6xI75C/EiP9s7EbvTweZ6Ab0DTW4AezjQsP6DmVBwNj/argitvBAhBkLjglMg
	Oh0ESLz3bQ==
X-Google-Smtp-Source: AGHT+IHSNUXiE7mXE2mQNbRtrUlh0BXR1895ZZHvTbbMYRJyyqq3u5SnzJtFRw7iNuhYdzex064zxA==
X-Received: by 2002:a17:903:2d0:b0:212:996:353a with SMTP id d9443c01a7336-21c355750fbmr579421645ad.12.1737857012871;
        Sat, 25 Jan 2025 18:03:32 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9dedcsm38955815ad.46.2025.01.25.18.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 18:03:32 -0800 (PST)
Date: Sun, 26 Jan 2025 02:03:26 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jan Stancek <jstancek@redhat.com>, pshelar@ovn.org, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: net/{lib,openvswitch}: extend CFLAGS to
 keep options from environment
Message-ID: <Z5WX7rUMINgA3KVJ@fedora>
References: <3d173603ee258f419d0403363765c9f9494ff79a.1737635092.git.jstancek@redhat.com>
 <26ad0900-bd9d-464e-be9f-c1806b96c971@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ad0900-bd9d-464e-be9f-c1806b96c971@kernel.org>

On Thu, Jan 23, 2025 at 01:51:27PM +0100, Matthieu Baerts wrote:
> > openvswitch/Makefile CFLAGS currently do not appear to be used, but
> > fix it anyway for the case when new tests are introduced in future.
> > 
> > Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> 
> Note that this commit is only for the Makefile in 'lib', not in
> 'openvswitch', but I guess there is no need to backport that all along.
> Maybe the two modifications should be split, but I guess that's fine here.

Maybe we can also add

Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")


Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

