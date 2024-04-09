Return-Path: <linux-kselftest+bounces-7491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C3B89DE29
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835FE1F2B701
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B904135A50;
	Tue,  9 Apr 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez19ziXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C7135A4C;
	Tue,  9 Apr 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675149; cv=none; b=Kt8y0eWjHnRzOh2BX/z6+GDA3YYAOTmzXzREaAJKFG49k9CfA4F/fMUt6zDAG+PW+2rc/yrineCzPVDh1+SlZqTWcAY01ZAR+F43rTlwYif1Kos4JccpvoH0cpHl5nj1TcC/xaCRB6PETcd6DJVQKHo/zLQt0O13dXQSIFwcqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675149; c=relaxed/simple;
	bh=gfygpdlZBA/UR+d6jNGrfUkHe5v/BqLsPvdwuu6LPOI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qP8pMGCde3x6F6e0gT5bV3HS6jeVjFnPF6dt+5z1CKeSB9VdTjGlOwpS/3ikNAFindf9TCNeUz//yWDighREF/vhnWHHiRb8dKYDEYyCqOXSTFaBlUeSCXMcjy41x0hP2HdHpV/7OtSCSZ2eaAVSLHnlzMFsG77kbpefVJHU8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez19ziXD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d6bc947aeso76275185a.0;
        Tue, 09 Apr 2024 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712675147; x=1713279947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1JiqW17Thx4tVhGhPVb84r7nRSgwjiyVwzWN22hbKg=;
        b=ez19ziXDAM+WKatxF90Bdg8tYuAu4KnIge/YVXX4hxCvdS0WkXAdMZBHeOk1x4jep9
         rO+XKjlE9li/i9mc2pf7ynUE6+kpUJPGJEXG0m4jVgIC6aNTipXOrNGaCXK8qJQk78Jg
         /n/aqgMj9ekwoBe9G+jeKuGvBzM9tfkpU4uK5F2d5rJ+5k0+GMDpNU5XpVjS4m8mQmLq
         dGp/gJMeP78ua5TJoQFCvn6TyUGh+uTw8jBjkcozzhvcgv50Evkg+EffB3VkcNSeVz85
         YzLZILVxJ653RIpk/VzpF8s/rghKDY71WewKy6SX+dcxytwtScpYqhDM6Gjb8LbwMV+p
         wyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675147; x=1713279947;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1JiqW17Thx4tVhGhPVb84r7nRSgwjiyVwzWN22hbKg=;
        b=l9YX++rHUf1nWIyXx0lcD7JUAKehvqQ9FOn74loNm3ARabG+31C91LlqgRldxuOmza
         Jbsu5hX+RWyDxjgj3/5zUR5Rdh+cR2diDRWiToZK4R4qpQk315j9NrAzVnV37ooMuCtK
         FqP4EDYBfQAhVHrO1EvfaMVwncm9krLr5wXBuJW9ws9FopIMAJuCIkyHN5SL+lG8eiku
         ZhMUosYjTRdhT4FSF+oEDIlLDZc0KSRGe5Hf6sJeRkmmuDq+Kg0XyqWQRVP3V5riiPja
         /EItXNANduihepap1tuxDDuv4RkXcKqbcur6xqp1JUawcGdMmDs2Pz6IVFnVSaZXrwJC
         FRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCViiW3bab6WvzIheIGjUU6OlVah9B85qZuntTKrl6NmPdDqCzQzqm1RLyqQC9pB6oEvd8VIkinRMhCSgxeNl5qPHUcsjx0DlB05u1iJV0JlQaMqjY9cY8qVe9NY16cp4DRnGgrRw6XqjnZIVMu+EhrK9Txx7STJBcXcpPE60AWepZTI4pu+
X-Gm-Message-State: AOJu0YwF51qe2kucvVcOkJcXwTNiUEC4S6u82ai10sA33jUKcIPBk67i
	Rg/MOYIpe72Ksw/xwsu7WceJper9KRZA6+DU/lYKqFLvaEPpI9Bd
X-Google-Smtp-Source: AGHT+IFbologFtzoOOVUCXskYwR2w+4QFcNb2kah9xNwJh9qv0RtRxIZj6M7sP0k18mo4GXpwrAXcA==
X-Received: by 2002:a05:620a:84a:b0:78d:5d7e:9d0c with SMTP id u10-20020a05620a084a00b0078d5d7e9d0cmr8938132qku.10.1712675147348;
        Tue, 09 Apr 2024 08:05:47 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a110800b0078d67d40c49sm1693556qkk.70.2024.04.09.08.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:05:47 -0700 (PDT)
Date: Tue, 09 Apr 2024 11:05:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6615594ab06f2_23a2b22945@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240408141720.98832-5-richardbgobert@gmail.com>
References: <20240408141720.98832-1-richardbgobert@gmail.com>
 <20240408141720.98832-5-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v5 4/6] net: gro: add {inner_}network_offset to
 napi_gro_cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
> makes sure both are set correctly. In the common path there's only one
> write (skb_gro_reset_offset).
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      | 18 ++++++++++++++++--
>  net/8021q/vlan_core.c  |  2 ++
>  net/core/gro.c         |  1 +
>  net/ethernet/eth.c     |  1 +
>  net/ipv4/af_inet.c     |  5 +----
>  net/ipv4/gre_offload.c |  1 +
>  net/ipv6/ip6_offload.c |  8 ++++----

Should this cover more protocols, like geneve, ipsec?

