Return-Path: <linux-kselftest+bounces-4362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A163C84E9C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43901C22DDC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609963F9EB;
	Thu,  8 Feb 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVTfAGBS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08674F1F3;
	Thu,  8 Feb 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424766; cv=none; b=jfusSCw/YrPS4+U2vCSJcvowLmPJLFVKZik6ZISpnDKLARKBTKF6yKpyVM7UE8aoq/yIzmofDOzgO5apLEeFBkxkKXwgoDTsB8ZUgOVdzDUr9BPXVISLDNSXv/MzieZy06/K8A9hAJ77FJ3E+IcOfFeyiecJ+Ji3Yr1YSAY6afE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424766; c=relaxed/simple;
	bh=v50a1RLENJnMG5Fn33xnx9PKJJ03gcToXahGpMfUKRQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bW/z+28Mes1O6vGlP28qI7XcILRMvF4jjAkRKOlf34lH3IcEI+HRMtNsfnp0wImv531lhvUZ2pVDA0xmggVRVMVtweUPHaINc7xdRQE1IqHUoQiBC5fOlvMVtJJQ4ih07miZXyJlMDanRw1g5qzaaf4WCkXVXchpPRh++roOKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVTfAGBS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68cc84a23b1so1111566d6.2;
        Thu, 08 Feb 2024 12:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707424763; x=1708029563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WP5psndlTDJjMy8HX6p5W8vCqQLOQzb8AfkQ/8GsqY=;
        b=WVTfAGBSfyCDSJ5k01NylEDSN7kh0ODB2RP7z0u4Q7WloqlHXSlEtr634UsmAjowTf
         yWSMEf+k8S/Cvl2vd1Viu5mIZ6N0tjfSlmkX35MFDHyyHMZanMHG/7SfjoWCIOaLjsKc
         YCLoo2eOdbPKml7ta154nH/NGzAZwYewD8Wuipc2qNM4/yRfStqo+ziDJPkCyC3IDS3z
         DF/B6h+is9F2J6Wwcmgzh6/n9qhw0TfT8rE4Tiq4Ds70Ta73QPeA3utA7ObdWwySWzk/
         hpWsMsG3KWDTdsm4RaRmj77Oc+szt/WkkgshA9Rq8GkpqvpXRL+sCZbcgvdgpux9P89X
         vJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424763; x=1708029563;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WP5psndlTDJjMy8HX6p5W8vCqQLOQzb8AfkQ/8GsqY=;
        b=RDXiOdRw/zuMl1ObCDDTa6dVLcXeEIcOaQWzWxzWa+fy8o5Ero0DtM+Hg9r18lpTgv
         zUQjqGX+iaLIGdZpYX2k8na3Q0kSfkL7RuN058LV50l8Tw5GWHv5ScnYhWHLL7mgRRbX
         EGTu1N28GX14bDFZAs5WKHNSTZMUzznysuYkUFFBrTdJBfgD0v3sopG8HHun21pKgtRp
         gYZsl3XNBFwFoDF6UcyHvy0WRNGouEtIw5upigqO66Kdbqsw7QsYurhiVbUMQTWsdkNK
         pN5Z1DBlCzQXuc6TmIgyeEnHn2+2w03vV/vP/K4CnzKL2tnCjR3YFWlb4VvYLYh8dcuT
         XhFw==
X-Gm-Message-State: AOJu0YyxEpq8LM4hhiuwG5o9bRXW39tt3wD1Ly6DHBGBdhWrdxn5Mlgd
	SxSoNMxEJtPxpB9kGRDasYHuA1CV+RIOydaEsG4dT/bIgBF00aUH
X-Google-Smtp-Source: AGHT+IGlz+fajFv5kjT947Kp2MlKhEcGs9DI5YGE2QBluo/fjvAVrSMy8Z7Oojj4z56kfFGj4K74QA==
X-Received: by 2002:a0c:cc0c:0:b0:68c:5c8a:6dca with SMTP id r12-20020a0ccc0c000000b0068c5c8a6dcamr412874qvk.21.1707424763646;
        Thu, 08 Feb 2024 12:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSLo+fhs9ZzhYIPw0SFVDXifLn7kWm2HACtyUo4ilG/BIwZmuxqBk9QNk67VsP5Et2hD2wSPIGLcatazjzIKQ/R8xvKoaWDwJj0hAh1c7EFCOnNePtg8IdydJuuLndWp/QymF2KPA8fwTgF3tAJJtonSthM3cMrcXq16mLiljHwHMIznepO5Di8p0PaHT51TS0MzIpnQ+UVccNWQW1SpOVUWbSuGLiQBjoksDbAJupUCNYacHxFuWWzgmdEjs5RfQtFrY7eLxcHKOuaTXt
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ly2-20020a0562145c0200b0068c9086c4d2sm133829qvb.10.2024.02.08.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:39:23 -0800 (PST)
Date: Thu, 08 Feb 2024 15:39:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65c53bfad8669_1c6ed32946@willemb.c.googlers.com.notmuch>
In-Reply-To: <53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
References: <53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
Subject: Re: [PATCH net] selftests: net: wait for receiver startup in
 so_txtime.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> The mentioned test is failing in slow environments:
> 
>   # SO_TXTIME ipv4 clock monotonic
>   # ./so_txtime: recv: timeout: Resource temporarily unavailable
>   not ok 1 selftests: net: so_txtime.sh # exit=1
> 
> The receiver is started in background and the sender could end-up
> transmitting the packet before the receiver is ready, so that the
> later recv times out.
> 
> Address the issue explcitly waiting for the socket being bound to
> the relevant port.
> 
> Fixes: af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

